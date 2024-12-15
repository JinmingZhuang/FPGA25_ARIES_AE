#ifndef ARIES_DIALECT_ARIES_ADF_TYPES_TD
#define ARIES_DIALECT_ARIES_ADF_TYPES_TD

include "ADFDialect.td"
include "ADFAttrs.td"

// Base class for ADF types 
class ADF_Type<string name, string typeMnemonic> : TypeDef<ADF_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def PortType : ADF_Type<"Port", "port"> {
  let summary = "port type";
  let parameters = (ins PortDirParam:$dir);
  let assemblyFormat = "`<` $dir `>` ";
}

def PLIOType : ADF_Type<"PLIO", "plio"> {
  let summary = "plio type";
  let parameters = (ins PortDirParam:$dir, "unsigned":$width);
  let assemblyFormat = "`<` $dir `,` $width `>`";
}

def GMIOType : ADF_Type<"GMIO", "gmio"> {
  let summary = "gmio type";
  let parameters = (ins PortDirParam:$dir);
  let assemblyFormat = "`<` $dir `>`";
}

// def APIntType : ADF_Type<"APInt", "ap_int"> {
//   let summary = "abitrary precision integer type";
//   let parameters = (ins "std::size_t":$width);
//   let assemblyFormat = "`<` $width `>`";
// }

def GraphIOType : AnyTypeOf<[PLIOType, GMIOType, PortType]>;

def StreamType : ADF_Type<"Stream", "stream"> {
  let summary = "stream type";
}

def CascadeType : ADF_Type<"Cascade", "cascade"> {
  let summary = "cascade type";
}

def AnyScalarType : AnyTypeOf<[Index, AnySignlessInteger, AnyFloat]>;

def KernelIOType : AnyTypeOf<[StreamType, CascadeType, AnyScalarType,
                              AnyMemRef]>;

def ConnectType : AnyTypeOf<[KernelIOType, GraphIOType]>;


#endif  // ARIES_DIALECT_ARIES_ADF_TYPES_TD