import numpy as np
from typing import Generic, TypeVar, Tuple, Union
import ast
import inspect
import astor
from typing import Any, Callable, Tuple


class MLIRGenerator(ast.NodeVisitor):
    def __init__(self, memory_mapping=dict(), arg_types=dict()):
        self.mlir_code = []
        self.indent = 2
        self.memory_mapping = memory_mapping
        self.arg_types = arg_types

        self.var_count = 0
        self.cur_func_name = None

    def get_var_name(self):
        self.var_count += 1
        return "%" + str(self.var_count)
    
    def get_eletype_name(self, arg):
        ty, _ = self.arg_types[arg]
        if(ty == "float32"):
          return "f32"
        elif(ty == "int32"):
          return "i32"
        elif(ty == "int16"):
          return "i16"
        elif(ty == "int8"):
          return "i8"
        else:
          raise TypeError(f"Type {ty} not supported.")
    
    def get_MemRefType_name(self, arg):
      _, shape = self.arg_types[arg]
      shape_name = "x".join([str(s) for s in shape])
      type_name = self.get_eletype_name(arg)
      memrefType_name = f"memref<{shape_name}x{type_name}>"
      return memrefType_name

    def emit(self, code):
        self.mlir_code.append(" " * self.indent + code)

    def visit_FunctionDef(self, node):
        # Process the function definition and arguments
        func_name = node.name
        args = [arg.arg for arg in node.args.args]
        # Get annotation types
        memrefs = []
        for arg in args:
            if arg in self.arg_types:
                typeName = self.get_MemRefType_name(arg)
                memrefs.append(f"%{arg}: {typeName}")
            else:
                raise ValueError(f"Argument {arg} not found in arg_types.")
        self.emit(f"func.func @{func_name}({', '.join(memrefs)}) {{")

        assert self.cur_func_name is None
        self.cur_func_name = func_name

        self.indent += 2
        self.generic_visit(node)
        self.emit("return")
        self.indent -= 2

        self.emit("}")

    def visit_For(self, node):
        # Process affine.for loop
        loop_var = node.target.id  # e.g., i0, j0, k0
        loop_call = node.iter.func.id
        loop_range = node.iter.args[1].value 
        self.emit(f"affine.for %{loop_var} = 0 to {loop_range} {{")

        self.indent += 2
        self.generic_visit(node)
        self.indent -= 2

        if loop_call == "reduction_range":
          self.emit("}{reduction}")
        else:
          self.emit("}")

    def visit_AugAssign(self, node):
        # Check if the target is a subscript (e.g., C_L1[i, j])
        if isinstance(node.target, ast.Subscript):
            target = self.parse_subscript(node.target)
            
            # Generate code for the right-hand side (e.g., A[i, k] * B[k, j])
            # Will load the operands and perform the multiplication: res = A[i, k] * B[k, j]
            res, rhs = self.parse_binop(node.value)
            self.emit(f"{rhs}")
            
            # Generate affine.load for the left-hand side
            v = self.get_var_name()
            target_ptr = target.split("[")[0]
            eleTypeName = self.get_eletype_name(target_ptr)
            typeName = self.get_MemRefType_name(target_ptr)
            load_lhs = f"{v} = affine.load %{target} : {typeName}"
            self.emit(f"{load_lhs}")

            # Perform addition (the "+=" operator)
            mac = self.get_var_name()
            if eleTypeName == "f32":
              add_op = f"{mac} = arith.addf {v}, {res} : {eleTypeName}"
            else:
              add_op = f"{mac} = arith.addi {v}, {res} : {eleTypeName}"
            self.emit(f"{add_op}")

            # Generate affine.store to store the updated value
            target_ptr = target.split("[")[0]
            ty, shape = self.arg_types[target_ptr]
            shape = "x".join([str(s) for s in shape])
            store_op = f"affine.store {mac}, %{target} : {typeName}"
            self.emit(f"{store_op}")
        else:
            raise NotImplementedError(
                "Only subscript targets are supported for AugAssign.")

    def parse_subscript(self, subscript_node):
        # Parse a subscript (e.g., C_L1[i, j]) into MLIR-compatible notation
        if isinstance(subscript_node, ast.Subscript):
            # Extract base and indices
            # Assumes the base is a simple name (e.g., C_L1)
            base = subscript_node.value.id
            if base in self.memory_mapping:
                base = self.memory_mapping[base]

            # Fix this line
            indices = [self.parse_index(idx)
                       for idx in subscript_node.slice.elts]
            return f"{base}[{', '.join(indices)}]"
        
        raise NotImplementedError("Unsupported subscript format.")

    def parse_index(self, index_node):
        # Parse an index into MLIR-compatible notation (e.g., i0, j0)
        if isinstance(index_node, ast.Name):
            # Return the name of the variable (e.g., i0, j0)
            return "%" + index_node.id
        elif isinstance(index_node, ast.Constant):
            return str(index_node.value)  # Return the constant value (e.g., 4)
        raise NotImplementedError(
            f"Unsupported index type: {type(index_node)}")

    def parse_binop(self, binop_node):
        # bin_op over bin_op + subscripts
        if isinstance(binop_node, ast.BinOp) and isinstance(binop_node.op, ast.Mult) and isinstance(binop_node.left, ast.BinOp):
            left_op, res0 = self.parse_binop(binop_node.left)
            self.emit(f"{res0}")
            right_op = self.parse_subscript(binop_node.right)

            # Load operands
            op1 = self.get_var_name()
            op2 = self.get_var_name()

            ptr = right_op.split("[")[0]
            eleTypeName = self.get_eletype_name(ptr)
            typeName = self.get_MemRefType_name(ptr)
            self.emit(f"{op2} = affine.load %{right_op} : {typeName}")

            result = self.get_var_name()
            if eleTypeName == "f32":
              mul_op = f"{result} = arith.mulf {left_op}, {op2} : {eleTypeName}"
            else:
              mul_op = f"{result} = arith.muli {left_op}, {op2} : {eleTypeName}"
            return result, mul_op


        # Parse a binary operation (e.g., A[i, k] * B[k, j])
        if isinstance(binop_node, ast.BinOp) and isinstance(binop_node.op, ast.Mult):
            left = self.parse_subscript(binop_node.left)
            right = self.parse_subscript(binop_node.right)
            # Generate MLIR for the multiplication

            # Load operands
            op1 = self.get_var_name()
            op2 = self.get_var_name()

            ptr = left.split("[")[0]
            eleTypeL = self.get_eletype_name(ptr)
            typeName = self.get_MemRefType_name(ptr)
            self.emit(f"{op1} = affine.load %{left} : {typeName}")

            ptr = right.split("[")[0]
            eleTypeR = self.get_eletype_name(ptr)
            typeName = self.get_MemRefType_name(ptr)
            self.emit(f"{op2} = affine.load %{right} : {typeName}")
        
            result = self.get_var_name()
            if eleTypeL == "f32" or eleTypeR == "f32":
              mul_op = f"{result} = arith.mulf {op1}, {op2} : {eleTypeL}"
            else:
              mul_op = f"{result} = arith.muli {op1}, {op2} : {eleTypeL}"
            return result, mul_op

        raise NotImplementedError("Unsupported binary operation.")

    def generate(self, tree):
        # Parse the input Python code and visit nodes
        self.emit("module {")
        self.indent += 2
        self.visit(tree)

        # generate top function based on self.arg_types
        sig = "func.func @top("
        for index, arg in enumerate(self.arg_types):
            typeName = self.get_MemRefType_name(arg)
            sig += f"%{arg}: {typeName}"
            if index < len(self.arg_types) - 1:
                sig += ", "
        sig += ") attributes {top_func}{"
        self.emit(sig)
        self.indent += 2

        # Generate function call to the defined function
        call_args = []
        for arg in self.arg_types:
            call_args.append(f"%{arg}")
        call_args = ", ".join(call_args)
        call_types = []
        for arg in self.arg_types:
            typeName = self.get_MemRefType_name(arg)
            call_types.append(f"{typeName}")
        call_types = ", ".join(call_types)
        self.emit(f"func.call @{self.cur_func_name}({call_args}) : ({call_types}) -> ()")
    
        self.emit("return")
        self.indent -= 2
        self.emit("}")
        
        self.indent -= 2
        self.emit("}")

        return "\n".join(self.mlir_code)


class TileToLoops(ast.NodeTransformer):
    def __init__(self, grid_dims=None, tile_sizes=None):

        self.arg_types = {}
        self.sram_buffers = {}
        self.tile_ops = []

        # tile sizes and grid ranks
        self.grid_dims = grid_dims
        self.tile_sizes = tile_sizes
        self.sizes = []
        for index in range(len(self.grid_dims)):
            size = self.tile_sizes[index] * self.grid_dims[index]
            self.sizes.append(size)

        # Mapping from tiled to original size
        self.constant_mapping = {}
        self.memory_mapping = {}

    def visit_FunctionDef(self, node):
        assert len(self.arg_types) == 0
        for arg in node.args.args:
            if arg.annotation:
                ty = arg.annotation
                if isinstance(ty, ast.Subscript):
                    # Extract shape
                    shape = []
                    for r in ty.slice.elts:
                        if isinstance(r, ast.Name):
                            assert r.id in ["I", "J", "K", "L", "M", "N"]
                            index = ["I", "J", "K", "L", "M", "N"].index(r.id)
                            v = self.sizes[index]
                            shape.append(int(v))
                        else:
                            raise ValueError(
                                f"Unsupported shape type: {type(r)}")

                    self.arg_types[arg.arg] = (ty.value.id, shape) # E.g., dict[A] = T, (I, J)
                else:
                    assert False
                # arg.annotation = None

        # Traverse function body and update
        node.body = [self.visit(statement) for statement in node.body]
        return node

    def generic_visit(self, node):
        return super().generic_visit(node)

    def visit_AnnAssign(self, node):
        # print("===", type(node), astor.to_source(node))
        var_name = node.target.id
        assert var_name not in self.sram_buffers
        dtype = node.annotation.value.id
        shape = []
        assert isinstance(node.annotation.slice, ast.Tuple)
        ranges = node.annotation.slice.elts
        # Map from pointers to local variables
        for r in ranges:
            v = None
            if isinstance(r, ast.Name):
                v = r.id
            else:
                raise
            shape.append(v)
        self.sram_buffers[var_name] = (dtype, shape)
        # E.g., A_L1 => A
        self.memory_mapping[var_name] = node.value.value.id

        return None

    def visit_Assign(self, node):
        # Assigning to existing buffers, e.g., sram or off-chip memory
        assert len(node.targets) == 1
        target = node.targets[0]

        # (axis, ...) = tile_sizes()
        if isinstance(node.value, ast.Call):
            assert isinstance(node.value.func, ast.Name)

            # TI, ... = tile_sizes()

            # TI, TJ, TK = sizes
            if node.value.func.id == "tile_sizes":
                assert isinstance(target, ast.Tuple)
                assert len(target.elts) == len(self.sizes)

                for i, size in enumerate(self.sizes):
                    self.constant_mapping[target.elts[i].id] = int(size)

                return None
                # return ast.copy_location(new_node, node)

            # i, j, k = tile_ranks()
            elif node.value.func.id == "tile_ranks":
                assert isinstance(target, ast.Tuple)
                assert len(target.elts) == len(self.grid_dims)

                for i, _ in enumerate(self.grid_dims):
                    self.constant_mapping[target.elts[i].id] = 0
                return None

            elif node.value.func.id == "arange":
                # Extract arange arguments
                assert isinstance(target, ast.Name)
                assert len(node.value.args) == 2
                start = node.value.args[0]
                end = node.value.args[1]

                return None

            else:
                raise ValueError(
                    f"Unsupported function call: {node.value.func.id}")

        # A[range, range] = A_L1
        # A_L1 = A[range, range]
        assert isinstance(target, ast.Subscript), astor.to_source(node.value)

        assert self.sram_buffers.get(target.value.id) or self.arg_types.get(
            target.value.id)
        self.tile_ops.append(["STORE", target, node.value])
        return node

    def visit_Name(self, node):
        if node.id in self.constant_mapping:
            new_node = ast.Constant(
                value=self.constant_mapping[node.id], kind=None)
            return ast.copy_location(new_node, node)
        return node

    def emit(self, fn_name, tree):
        #print("=== MLIR assembly code ===")
        return MLIRGenerator(self.memory_mapping, self.arg_types).generate(tree)


# =========== Schedule ===========
class Schedule:
    _tasks = []
    _code = ""

    def __init__(self, *tasks):
        self.tasks = tasks
        self.flags = ""

    def to(self, task_tiles, target):
        # Assign target to task tiles
        for task_tile in task_tiles:
            task_tile.target = target

    def pipeline(self, loop, **kwargs):
        self.flags += f" -pipeline={loop} -ii={kwargs['ii']}"

    def vectorize(self, loop, **kwargs):
        self.flags += f" -vectorize={loop} -factor={kwargs['factor']}"

    def build(self, target):
        # Emit code for ADF optimizer and compilation configs
        return self._code, "aries-opt -emit=mlir -o=gemm.mlir " + self.flags


class TaskInstance:
    def __init__(self, func, grid_dims, tile_sizes, call_args, call_kwargs):
        self.func = func
        self.grid_dims = grid_dims
        self.tile_sizes = tile_sizes
        self.call_args = call_args
        self.call_kwargs = call_kwargs
        self.task_tiles = []


class TaskTileWrapper:
    def __init__(self, func: Callable):
        self.func = func
        self.grid_dims = None
        self.tile_sizes = None
        self.inner_loops = None

    def __getitem__(self, args: Tuple[Any, ...]):
        assert len(args) == 2
        self.grid_dims = args[0]
        self.tile_sizes = args[1]
        return self

    def __call__(self, *call_args, **call_kwargs):
        # Intercept function calls and analyze its AST instead of executing

        # source code with @task_tile decorator
        source_code = inspect.getsource(self.func)
        parsed_ast = ast.parse(source_code)
        # Remove the decorators from the AST, because the modified function will
        # be passed to them anyway and we don't want them to be called twice.
        for node in ast.walk(parsed_ast):
            if isinstance(node, ast.FunctionDef):
                node.decorator_list.clear()

        #print("Parsed AST", ast.dump(parsed_ast, indent=2))
        if not self.grid_dims or not self.tile_sizes:
            raise ValueError(
                "Grid dimensions and tile sizes must be specified")

        #print("=== Python AST code ===")
        mutator = TileToLoops(self.grid_dims, self.tile_sizes)
        tree = mutator.visit(parsed_ast)
        ast.fix_missing_locations(tree)
        #print(astor.to_source(tree))

        # Append single kernel to the schedule
        code = mutator.emit(self.func.__code__.co_name, tree)
        Schedule._code = code
        instance = TaskInstance(self.func, self.grid_dims,
                                self.tile_sizes, call_args, call_kwargs)
        Schedule._tasks.append(instance)
        return instance

    def get_loops(self):
        return [None, None, None]


def task_tile():
    """Decorator to wrap the function with enhanced behavior."""
    def decorator(func: Callable):
        return TaskTileWrapper(func)
    return decorator

# ======= Reduction range ========
class ReductionRange:
    def __init__(self, start, stop, step=1, attribute_name="reduction"):
        if stop is None:
            start, stop = 0, start
        self.range = range(start, stop, step)
        self.attribute_name = attribute_name  # Store the dynamic attribute name
        
    def __iter__(self):
        return iter(self.range)

# Helper function to create a ReductionRange
def reduction_range(start, stop, step=1, attribute_name="reduction"):
    return ReductionRange(start, stop, step, attribute_name)

# =========== Targets ===========
class VCK190:
    def __class_getitem__(cls, shape: Tuple[int, int]) -> Tuple[int, int]:
        return shape


# =========== Types ===========
Shape = TypeVar("Shape", bound=Tuple[int, ...])

# Define a generic Tensor type


class Tensor(Generic[Shape]):
    def __init__(self, dtype: str, shape: Tuple[int, ...]):
        self.dtype = dtype
        self.shape = shape

    def __getitem__(self, key: Union[slice, Tuple[slice, ...]]):
        # Simulate slicing to create a new tensor
        # In real use, this would return a sliced tensor
        return Tensor(self.dtype, self.shape)

    def __repr__(self):
        return f"Tensor<{self.dtype}[shape={self.shape}]>"
    
    def get_shape(self) -> Tuple[int, ...]:
        return self.shape

    def get_dtype(self) -> str:
        return self.dtype

# Dynamic Tensor Factory

class int8:
    def __class_getitem__(cls, shape: Tuple[int, ...]) -> Tensor:
        return Tensor("int8", shape)

class int16:
    def __class_getitem__(cls, shape: Tuple[int, ...]) -> Tensor:
        return Tensor("int16", shape)

class int32:
    def __class_getitem__(cls, shape: Tuple[int, ...]) -> Tensor:
        return Tensor("int32", shape)

class float32:
    def __class_getitem__(cls, shape: Tuple[int, ...]) -> Tensor:
        return Tensor("float32", shape)


def tile_sizes():
    # These are placeholders for the tile sizes
    # Not equal to actual number of dimensions
    return TypeVar("TI"), TypeVar("TJ"), TypeVar("TK"), TypeVar("TL"), TypeVar("TM")


def tile_ranks():
    # These are placeholders for the tile ranks
    # Not equal to actual number of dimensions
    return TypeVar("I"), TypeVar("J"), TypeVar("K"), TypeVar("L"), TypeVar("M")


def arange(start, end):
    return range(start, end)
