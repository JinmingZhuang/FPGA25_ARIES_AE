

import numpy as np
from typing import Generic, TypeVar, Tuple, Union
import ast
import os
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
                ty, shape = self.arg_types[arg]
                shape = "x".join([str(s) for s in shape])
                memrefs.append(f"%{arg}: memref<{shape}xf32>")
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
        loop_range = node.iter.args[1].n 
        self.emit(f"affine.for %{loop_var} = 0 to {loop_range} {{")

        self.indent += 2
        self.generic_visit(node)
        self.indent -= 2

        self.emit("}")

    def visit_AugAssign(self, node):
        # Check if the target is a subscript (e.g., C_L1[i, j])
        if isinstance(node.target, ast.Subscript):
            target = self.parse_subscript(node.target)
            # Generate affine.load for the left-hand side
            v = self.get_var_name()

            target_ptr = target.split("[")[0]
            ty, shape = self.arg_types[target_ptr]
            shape = "x".join([str(s) for s in shape])
            load_lhs = f"{v} = affine.load %{target} : memref<{shape}xf32>"
            self.emit(f"{load_lhs}")

            # Generate code for the right-hand side (e.g., A[i, k] * B[k, j])
            # Will load the operands and perform the multiplication: res = A[i, k] * B[k, j]
            res, rhs = self.parse_binop(node.value)
            self.emit(f"{rhs}")

            # Perform addition (the "+=" operator)
            mac = self.get_var_name()
            add_op = f"{mac} = arith.addf {v}, {res} : f32"
            self.emit(f"{add_op}")

            # Generate affine.store to store the updated value
            target_ptr = target.split("[")[0]
            ty, shape = self.arg_types[target_ptr]
            shape = "x".join([str(s) for s in shape])
            store_op = f"affine.store {mac}, %{target} : memref<{shape}xf32>"
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
            ty, shape = self.arg_types[ptr]
            shape = "x".join([str(s) for s in shape])
            self.emit(f"{op2} = affine.load %{right_op} : memref<{shape}xf32>")

            result = self.get_var_name()
            return result, f"{result} = arith.mulf {left_op}, {op2} : f32"


        # Parse a binary operation (e.g., A[i, k] * B[k, j])
        if isinstance(binop_node, ast.BinOp) and isinstance(binop_node.op, ast.Mult):
            left = self.parse_subscript(binop_node.left)
            right = self.parse_subscript(binop_node.right)
            # Generate MLIR for the multiplication

            # Load operands
            op1 = self.get_var_name()
            op2 = self.get_var_name()

            ptr = left.split("[")[0]
            ty, shape = self.arg_types[ptr]
            shape = "x".join([str(s) for s in shape])
            self.emit(f"{op1} = affine.load %{left} : memref<{shape}xf32>")

            ptr = right.split("[")[0]
            ty, shape = self.arg_types[ptr]
            shape = "x".join([str(s) for s in shape])
            self.emit(f"{op2} = affine.load %{right} : memref<{shape}xf32>")
        
            result = self.get_var_name()
            return result, f"{result} = arith.mulf {op1}, {op2} : f32"

        raise NotImplementedError("Unsupported binary operation.")

    def generate(self, tree):
        # Parse the input Python code and visit nodes
        self.emit("module {")
        self.indent += 2
        self.visit(tree)
        self.indent -= 2
        self.emit("}")

        # generate top function based on self.arg_types
        sig = "func.func @top("
        for index, arg in enumerate(self.arg_types):
            ty, shape = self.arg_types[arg]
            shape = "x".join([str(s) for s in shape])
            sig += f"%{arg}: memref<{shape}xf32>"
            if index < len(self.arg_types) - 1:
                sig += ", "
        sig += ") attributes {top_func}{"
        self.emit(sig)
        self.indent += 2

        # Generate function call to the gemm function
        call_args = []
        for arg in self.arg_types:
            call_args.append(f"%{arg}")
        call_args = ", ".join(call_args)
        call_types = []
        for arg in self.arg_types:
            ty, shape = self.arg_types[arg]
            shape = "x".join([str(s) for s in shape])
            call_types.append(f"memref<{shape}xf32>")
        call_types = ", ".join(call_types)
        self.emit(f"func.call @{self.cur_func_name}({call_args}) : ({call_types}) -> ()")
    
        self.emit("return")
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
                            shape.append(r.id)
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
        print("=== MLIR assembly code ===")
        return MLIRGenerator(self.memory_mapping, self.arg_types).generate(tree)


# =========== Schedule ===========
class Schedule:
    _tasks = []
    _code = ""

    def __init__(self, *tasks):
        self.tasks = tasks
        self.current_op = None
        self.customizations = {}

    def to(self, task_tiles, target):
        # Assign target to task tiles
        for task_tile in task_tiles:
            task_tile.target = target

    def pipeline(self, loop, ii=1):
        self.customizations[loop] = {"type": "pipeline", "ii": ii}

    def vectorize(self, loop, factor=1):
        self.customizations[loop] = {"type": "vectorize", "factor": factor}
        
    def build(self, target="NPU"):
        # apply customizations and copy source code to target folder
        import shutil
        # make kernel_instances directory
        if os.path.exists("kernel_instances"):
            # rm -rf kernel_instances
            shutil.rmtree("kernel_instances", ignore_errors=True)
        os.makedirs("kernel_instances")
        
        # Apply customizations and copy
        tasks = self.tasks[0]
        import inspect, re
        
        for task in tasks:
            source = inspect.getsource(task.func)
            regex = r"Conv2D\[\s*\((\d+),\s*(\d+)\),\s*(\d+),\s*(\w+)\s*\]"
            
            # Extract kernel size, padding size, and has_skip
            k0, k1, padding_size, has_skip = re.findall(regex, source)[0]
            # print(k0, k1, padding_size, has_skip, has_skip == "True")   
            k0 = int(k0)
            k1 = int(k1)
            padding_size = int(padding_size)
            has_skip = True if has_skip == "True" else False
            
            
            # Apply customizations from templates
            if k0 == 1 and k1 == 1 and not has_skip:
                assert padding_size == 0
                source = "./kernels/conv2dk1"
                
                # Apply pipeline and vectorization and copy to target
                s = source + ".cc"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk1.cc", "w") as f:
                        f.write(code)
                
                s = source + ".h"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk1.h", "w") as f:
                        f.write(code)
            
            elif k0 == 3 and k1 == 3:
                assert padding_size == 1
                assert has_skip == False
                source = "./kernels/conv2dk3"
                
                # Apply pipeline and vectorization and copy to target
                s = source + ".cc"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk3.cc", "w") as f:
                        f.write(code)
                
                s = source + ".h"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk3.h", "w") as f:
                        f.write(code)
        
            elif k0 == 1 and k1 == 1 and has_skip:
                assert padding_size == 0
                source = "./kernels/conv2dk1_skip"
                
                # Apply pipeline and vectorization and copy to target
                s = source + ".cc"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk1_skip.cc", "w") as f:
                        f.write(code)
                
                s = source + ".h"
                with open(s, "r") as f:
                    code = f.read()
                    code = code.replace("{{pipeline}}", "pipeline")
                    code = code.replace("{{ii}}", "1")
                    code = code.replace("{{vectorize}}", "vectorize")
                    code = code.replace("{{factor}}", "8")
                    with open("kernel_instances/conv2dk1_skip.h", "w") as f:
                        f.write(code)
                
            else:
                raise ValueError(f"Unsupported kernel size: {k0}, {k1}")
    
    
    def __getitem__(self, task):
        self.current_op = task
        return self


class TaskInstance:
    def __init__(self, func, grid_dims, tile_sizes, call_args, call_kwargs):
        self.func = func
        self.grid_dims = grid_dims
        self.tile_sizes = tile_sizes
        self.call_args = call_args
        self.call_kwargs = call_kwargs
        self.task_tiles = []

    def get_loops(self):
        return self.grid_dims

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


# =========== Targets ===========
class NPU:
    def __class_getitem__(cls, shape: Tuple[int, int]) -> Tuple[int, int]:
        return shape


# =========== Types ===========
Shape = TypeVar("Shape", bound=Tuple[int, ...])

# Define a generic Tensor type


class Tensor(Generic[Shape]):
    def __init__(self, shape: Tuple[int, ...]):
        self.shape = shape

    def __getitem__(self, key: Union[slice, Tuple[slice, ...]]):
        # Simulate slicing to create a new tensor
        # In real use, this would return a sliced tensor
        return Tensor(self.shape)

    def __repr__(self):
        return f"Tensor<shape={self.shape}>"

# Dynamic Tensor Factory


class T:
    def __class_getitem__(cls, shape: Tuple[int, ...]) -> Tensor:
        return Tensor(shape)


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


class Conv2D:
    # input shape: (IC/F, IH, IW, F)
    # weight shape: (OC/F, IC/F, KH, KW, F, F) 
    # output shape: (OC/F, OH, OW, F)    
    
    kernel_size = None
    padding_size = None
    has_skip = None
    
    def __init__(self, inputs):
        self.inst_pp_ii = 1
        self.oc_simd_vector = 1
        self.tile_sizes = (32, 32)

        self.has_skip = Conv2D.has_skip
        self.kernel_size = Conv2D.kernel_size
        self.padding_size = Conv2D.padding_size
        
        self.inputs = inputs
        if self.kernel_size == (3, 3):
            self.source = "conv2dk3"
        
        elif self.kernel_size == (1, 1):
            if self.has_skip:
                self.source = "conv2dk1_skip"
            else:
                self.source = "conv2dk1"
        else:
            raise ValueError(f"Unsupported kernel size: {self.kernel}")
    
    
    def __class_getitem__(cls, kernel_size, padding_size, has_skip):
        Conv2D.kernel_size = kernel_size
        Conv2D.padding_size = padding_size
        Conv2D.has_skip = has_skip
        return Conv2D
    


# ----------------------------
# Example usage
# ----------------------------

H, W = 64, 64
C0 = 256
C1 = C0 // 4
C2 = C1

@task_tile()
def layer1(A: T[C0, H, W], W: T[C1, C0, 1, 1], O: T[C1, H, W]):
    # kernel size, padding size, has skip
    Conv2D[ (1, 1), 0, False ](A, W, O)


@task_tile()
def layer2(A: T[C1, H, W], W: T[C2, C1, 3, 3], O: T[C2, H, W]):
    Conv2D[ (3, 3), 1, False ](A, W, O)


@task_tile()
def layer3(A: T[C2, H, W], W: T[C1, C2, 1, 1], O: T[C1, H, W]):
    Conv2D[ (1, 1), 0, True ](A, W, O)


def app_resnet_conv2x():
    # I, J, K = 1024, 1024, 1024
    sz = (256, 1, 32, 32)
    inputs = np.random.rand(*sz)
    w0 = np.random.rand(64, 256, 1, 1)
    out0 = np.random.rand(64, 32, 32)
    
    w1 = np.random.rand(64, 64, 3, 3)
    out1 = np.random.rand(64, 32, 32)
    
    w2 = np.random.rand(256, 64, 1, 1)
    out2 = np.random.rand(256, 32, 32)

    op0 = layer1[(64, 32), (1, 2)](inputs, w0, out0)
    op1 = layer2[(64, 32), (1, 2)](out0, w1, out1)
    op2 = layer3[(64, 32), (1, 2)](out1, w2, out2)

    ops = [op0, op1, op2]
    s = Schedule(ops)
    
    for op in ops:
        loops = op.get_loops()
        s[op].pipeline(loops[0], ii=1)
        s[op].vectorize(loops[1], factor=8)
    
    s.to(op0.task_tiles, NPU[:1, 0])
    s.to(op1.task_tiles, NPU[:1, 1:2])
    s.to(op2.task_tiles, NPU[:1, 3])
    
    # Generate IRON code from tasks
    s.build(os.path.join(os.getcwd(), "aie.py"))

if __name__ == "__main__":
    app_resnet_conv2x()

