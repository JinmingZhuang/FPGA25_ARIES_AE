#ifndef ARIES_DIALECT_ARIES_ADF_ATTRS_TD
#define ARIES_DIALECT_ARIES_ADF_ATTRS_TD

include "ADFDialect.td"

// Define ADF Attributes
def DirIn:     I32EnumAttrCase<"In", 0>;
def DirOut:    I32EnumAttrCase<"Out", 1>;
def DirInout:  I32EnumAttrCase<"Inout", 2>;
def Width128:  I32EnumAttrCase<"Width128", 128>;
def Width64:   I32EnumAttrCase<"Width64" , 64>;
def Width32:   I32EnumAttrCase<"Width32" , 32>;
def WidthNULL: I32EnumAttrCase<"WidthNULL" ,0>;
def Burst256:  I32EnumAttrCase<"Burst256", 256>;
def Burst128:   I32EnumAttrCase<"Burst128", 128>;
def Burst64:   I32EnumAttrCase<"Burst64", 64>;
def BurstNULL: I32EnumAttrCase<"BurstNULL", 0>;
def PLIO:      I32EnumAttrCase<"PLIO", 0>;
def GMIO:      I32EnumAttrCase<"GMIO", 1>;
def PORT:      I32EnumAttrCase<"PORT", 2>;
def Buffer:    I32EnumAttrCase<"Buffer", 0>;
def Stream:    I32EnumAttrCase<"Stream", 1>;
def Cascade:   I32EnumAttrCase<"Cascade", 2>;
def Scalar:   I32EnumAttrCase<"Scalar", 3>;

def L1:  I32EnumAttrCase<"L1", 2>; //Compatible with MLIR-AIR
def L2:  I32EnumAttrCase<"L2", 1>;
def L3:  I32EnumAttrCase<"L3", 0>;

def PortDir: I32EnumAttr<"PortDir", "Direction of the ports",
  [DirIn, DirOut, DirInout]> {
  let cppNamespace = "::mlir::aries::adf";
}
def PortDirParam: EnumParameter<PortDir>;

def PortWidth: I32EnumAttr<"PortWidth", "Width of the ports",
  [Width128, Width64, Width32, WidthNULL]> {
  let underlyingType = "int32_t";
  let cppNamespace = "::mlir::aries::adf";
}

def PortBurst: I32EnumAttr<"PortBurst", "Burst length GMIO port in bytes",
  [Burst256, Burst128, Burst64, BurstNULL]> {
  let underlyingType = "int32_t";
  let cppNamespace = "::mlir::aries::adf";
}

def GraphIOName: I32EnumAttr<"GraphIOName", "Names of graph input/output",
  [PLIO, GMIO, PORT]> {
  let cppNamespace = "::mlir::aries::adf";
}

def KernelIOName: I32EnumAttr<"KernelIOName", "Names of kernel input/output",
  [Buffer, Stream, Cascade, Scalar]> {
  let cppNamespace = "::mlir::aries::adf";
}

def MemorySpace: I32EnumAttr<"MemorySpace", "ARIES Memory Space Indeices",
  [L1, L2, L3]> {
  let cppNamespace = "::mlir::aries::adf";
}

#endif  // ARIES_DIALECT_ARIES_ADF_ATTRS_TD