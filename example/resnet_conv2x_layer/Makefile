#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# Copyright (C) 2024, Advanced Micro Devices, Inc.

srcdir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

include makefile-common

mlirFileName = aie

VPATH := ${srcdir}/kernel_instances

all: build/conv2dk1.o build/conv2dk3.o build/conv2dk1_skip.o build/final.xclbin

build/${mlirFileName}.mlir: ${srcdir}/aie2.py
	mkdir -p ${@D}
	python3 $< > $@

insts.txt: build/${mlirFileName}.mlir
	aiecc.py -v --aie-only-generate-npu --npu-insts-name=$@ $<

build/conv2dk1.o: conv2dk1.cc
	xchesscc -d ${CHESSCC2_FLAGS} -DINT8_ACT -c $< -o $@

build/conv2dk3.o: conv2dk3.cc
	xchesscc -d ${CHESSCC2_FLAGS} -DUINT8_ACT -c $< -o $@

build/conv2dk1_skip.o: conv2dk1_skip.cc
	xchesscc -d ${CHESSCC2_FLAGS} -DINT8_ACT -c $< -o $@

build/final.xclbin: build/${mlirFileName}.mlir build/conv2dk1.o build/conv2dk3.o build/conv2dk1_skip.o  
	cd build && aiecc.py -v --aie-generate-cdo --aie-generate-npu --no-compile-host \
		--basic-alloc-scheme \
		--xclbin-name=${@F} --npu-insts-name=insts.txt ${<F}

clean:
	rm -rf kernel_instances build *.elf* *.lst *.bif ${mlirFileName}.mlir.prj log .xclbin sim \
		chess* *.o insts.txt \
		*.log aie_partition.json *.bin BOOT.BIN _x test.exe

run_py: 
	${powershell} python3 ${srcdir}/test.py -x build/final.xclbin -i build/insts.txt -k MLIR_AIE
