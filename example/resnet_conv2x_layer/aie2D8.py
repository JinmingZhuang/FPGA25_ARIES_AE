#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# Copyright (C) 2024, Advanced Micro Devices, Inc.

from aie.dialects.aie import *
from aie.dialects.aiex import *
from aie.extras.dialects.ext import memref, arith
from aie.dialects.scf import *
from aie.extras.context import mlir_mod_ctx
from aie.ir import MemRefType, TypeAttr

import sys

# Define bottleneck layer sizes

tensorInW = 32
tensorInH = 64
tensorInC = 256

# L1: 1x1 InC=256 OutC=64
tensorL1InC = tensorInC
tensorL1OutC = tensorL1InC // 4

# L2: 3x3 InC=64 OutC=64
tensorL2InC = tensorL1OutC
tensorL2OutC = tensorL2InC

# L3: 1x1 InC=64 OutC=256
tensorL3InC = tensorL2OutC
tensorL3OutC = tensorL3InC * 4


def bottleneck4AIEs():
    with mlir_mod_ctx() as ctx:

        @device(AIEDevice.npu1_4col)
        def deviceBody():

            # L1: Conv1x1 InC=256 OutC=64. it is data line-wise including all CHs
            tensorLayer1In_ty = MemRefType.get((tensorInW,1,tensorL1InC), IntegerType.get_signless(8))
            weightsLayer1_ty = MemRefType.get((tensorL1InC * tensorL1OutC,), IntegerType.get_signless(8))
            tensorLayer1Out_ty = MemRefType.get((tensorInW,1,tensorL1OutC), IntegerType.get_unsigned(8))

            # L2 Conv3x3 InC=64 OutC=32x2
            tensorLayer2In_ty = MemRefType.get((tensorInW,1,tensorL2InC),IntegerType.get_unsigned(8))
            weightsLayer2_ty = MemRefType.get((3 * 3 * tensorL2InC * tensorL2OutC,), IntegerType.get_signless(8))
            tensorLayer2Out_ty = MemRefType.get((tensorInW,1,tensorL2OutC // 2),IntegerType.get_unsigned(8))

            # L3 Conv1x1 InC=64 OutC=256. it takes half of the input channels from 2 L2 kernels
            tensorLayer3In_ty = MemRefType.get((tensorInW,1,tensorL3InC // 2),IntegerType.get_unsigned(8))
            weightsLayer3_ty = MemRefType.get((tensorL3InC * tensorL3OutC,), IntegerType.get_signless(8))
            tensorLayer3Out_ty = MemRefType.get((tensorInW,1,tensorL3OutC),IntegerType.get_unsigned(8))

            # weights for L1, L2x2, and L3
            allWeights_ty = MemRefType.get((tensorL1InC * tensorL1OutC
                    + 3 * 3 * tensorL2InC * tensorL2OutC
                    + tensorL3InC * tensorL3OutC,), IntegerType.get_signless(8))

            # kernel definitions
            conv2dk1 = external_func("conv2dk1_i8", inputs=[
                    tensorLayer1In_ty, weightsLayer1_ty,tensorLayer1Out_ty,
                    IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32)])
            
            conv2dk3 = external_func("conv2dk3_ui8", inputs=[
                    tensorLayer2In_ty, tensorLayer2In_ty, tensorLayer2In_ty, weightsLayer2_ty,
                    tensorLayer2Out_ty,
                    IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32)])
            
            conv2dk1_skip = external_func("conv2dk1_skip_i8", inputs=[
                    tensorLayer3In_ty, tensorLayer3In_ty, weightsLayer3_ty,
                    tensorLayer3Out_ty, tensorLayer1In_ty,
                    IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32), IntegerType.get_signless(32)])

            ShimTile = tile(0, 0)
            MemTile = tile(0, 1)
            ComputeTile2 = tile(0, 2)
            ComputeTile3 = tile(0, 3)
            ComputeTile4 = tile(0, 4)
            ComputeTile5 = tile(0, 5)


            # runtime parameters
            rtpComputeTile2 = Buffer(ComputeTile2, [16], T.i32(), "rtpComputeTile2")
            rtpComputeTile3 = Buffer(ComputeTile3, [16], T.i32(), "rtpComputeTile3")
            rtpComputeTile4 = Buffer(ComputeTile4, [16], T.i32(), "rtpComputeTile4")
            rtpComputeTile5 = Buffer(ComputeTile5, [16], T.i32(), "rtpComputeTile5")

            # input tensor (to L1 and MemTile, which is later used by L3 skip)
            of_inOF_act_L3L2 = object_fifo("inOF_act_L3L2", ShimTile, [ComputeTile2, MemTile], [2, 2, 4], tensorLayer1In_ty)
            of_skip_buf = object_fifo("skip_buf", MemTile, ComputeTile4, 2, tensorLayer1In_ty)
            object_fifo_link(of_inOF_act_L3L2, of_skip_buf)

            # weights: distributed two pipes for all layers
            inOF_wts_0_L3L2 = object_fifo("inOF_wts_0_L3L2", ShimTile, MemTile, 1, allWeights_ty)
            of_wts_buf_00 = object_fifo("wts_buf_00", MemTile, [ComputeTile2], 1, weightsLayer1_ty)
            wts_buf_01 = object_fifo("wts_buf_01", MemTile, [ComputeTile3, ComputeTile5],1, weightsLayer2_ty)
            wts_buf_02 = object_fifo("wts_buf_02", MemTile, [ComputeTile4], 1, weightsLayer3_ty)
            of_offsets = [0,np.prod(weightsLayer1_ty.shape),
                np.prod(weightsLayer1_ty.shape) + np.prod(weightsLayer2_ty.shape)]
            object_fifo_link(inOF_wts_0_L3L2, [of_wts_buf_00, wts_buf_01, wts_buf_02], [], of_offsets)

            # activation tensor (brocast from 1x1 to 2 3x3)
            of_act_2_3_5 = object_fifo("act_2_3_5", ComputeTile2, [ComputeTile3, ComputeTile5], [2, 4, 4], tensorLayer1Out_ty)  # 1x1 -> 3x3
            act_3_4 = object_fifo("act_3_4", ComputeTile3, ComputeTile4, 2, tensorLayer2Out_ty)  # 3x3 -> 1x1
            act_5_4 = object_fifo("act_5_4", ComputeTile5, ComputeTile4, 2, tensorLayer2Out_ty)  # 3x3 -> 1x1

            # output tensor
            outOFL2L3 = object_fifo("outOFL2L3", ComputeTile4, ShimTile, 2, tensorLayer3Out_ty)

            # 1x1 conv2d
            @core(ComputeTile2, "conv2dk1.o")
            def core_body():
                for _ in for_(sys.maxsize):
                    # acquire weights once
                    element0Weights = of_wts_buf_00.acquire(ObjectFifoPort.Consume, 1)
                    scale = memref.load(rtpComputeTile2, [0])
                    for _ in for_(tensorInH):
                        element0ActivactionsIn = of_inOF_act_L3L2.acquire(ObjectFifoPort.Consume, 1)
                        element0ActivactionsOut = of_act_2_3_5.acquire(ObjectFifoPort.Produce, 1)
                        res = call(conv2dk1,[
                                element0ActivactionsIn, element0Weights, element0ActivactionsOut,
                                tensorInW, tensorL1InC, tensorL1OutC, scale])

                        objectfifo_release(ObjectFifoPort.Consume, "inOF_act_L3L2", 1)
                        objectfifo_release(ObjectFifoPort.Produce, "act_2_3_5", 1)
                        yield_([])
                    objectfifo_release(ObjectFifoPort.Consume, "wts_buf_00", 1)
                    yield_([])

            # 3x3 conv2d that produces half of the output channels
            @core(ComputeTile3, "conv2dk3.o")
            def core_body():
                scale = 11
                for _ in for_(sys.maxsize):
                    element0Weights = wts_buf_01.acquire(ObjectFifoPort.Consume, 1)
                    # scale = memref.load(rtpComputeTile3, 0)

                    # pre-amble: top row
                    elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 2)
                    element0ActivactionsOut = act_3_4.acquire(ObjectFifoPort.Produce, 1)
                    res = call(conv2dk3,
                        [ elementActivactionsIn[0], elementActivactionsIn[0], elementActivactionsIn[1],
                            element0Weights, element0ActivactionsOut,
                            tensorInW, tensorL2InC, tensorL2OutC,
                            3, 3, 0, scale, 0])
                    objectfifo_release(ObjectFifoPort.Produce, "act_3_4", 1)

                    # middle
                    for _ in for_(tensorInH - 2):
                        elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 3)
                        element0ActivactionsOut = act_3_4.acquire(ObjectFifoPort.Produce, 1)
                        res = call(conv2dk3,[
                                elementActivactionsIn[0], elementActivactionsIn[1], elementActivactionsIn[2],
                                element0Weights, element0ActivactionsOut,
                                tensorInW, tensorL2InC, tensorL2OutC, 3, 3, 1, scale, 0])

                        objectfifo_release(ObjectFifoPort.Consume, "act_2_3_5", 1)
                        objectfifo_release(ObjectFifoPort.Produce, "act_3_4", 1)
                        yield_([])

                    # last part
                    elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 2)
                    element0ActivactionsOut = act_3_4.acquire(ObjectFifoPort.Produce, 1)
                    res = call(conv2dk3,[
                            elementActivactionsIn[0], elementActivactionsIn[1], elementActivactionsIn[1],
                            element0Weights, element0ActivactionsOut,
                            tensorInW, tensorL2InC, tensorL2OutC, 3, 3, 2, scale, 0])

                    objectfifo_release(ObjectFifoPort.Consume, "act_2_3_5", 2)
                    objectfifo_release(ObjectFifoPort.Produce, "act_3_4", 1)
                    objectfifo_release(ObjectFifoPort.Consume, "wts_buf_01", 1)
                    yield_([])

            # 3x3 conv2d that produces the other half of the output channels
            @core(ComputeTile5, "conv2dk3.o")
            def core_body():
                scale = 11
                for _ in for_(sys.maxsize):

                    # acquire weights and rtps once
                    element0Weights = wts_buf_01.acquire(ObjectFifoPort.Consume, 1)
                    # scale = memref.load(rtpComputeTile5, 0)
                    # pre-amble: top row
                    elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 2)
                    element0ActivactionsOut = act_5_4.acquire(ObjectFifoPort.Produce, 1)
                    res = call(conv2dk3, [
                            elementActivactionsIn[0], elementActivactionsIn[0], elementActivactionsIn[1],
                            element0Weights, element0ActivactionsOut,
                            tensorInW, tensorL2InC, tensorL2OutC, 3, 3, 0, scale,
                            tensorL2OutC // 2])

                    objectfifo_release(ObjectFifoPort.Produce, "act_5_4", 1)

                    # middle
                    for _ in for_(tensorInH - 2):
                        elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 3)
                        element0ActivactionsOut = act_5_4.acquire(ObjectFifoPort.Produce, 1)
                        res = call(conv2dk3, [
                                elementActivactionsIn[0], elementActivactionsIn[1], elementActivactionsIn[2],
                                element0Weights, element0ActivactionsOut,
                                tensorInW, tensorL2InC, tensorL2OutC, 3, 3, 1, scale, tensorL2OutC // 2])

                        objectfifo_release(ObjectFifoPort.Consume, "act_2_3_5", 1)
                        objectfifo_release(ObjectFifoPort.Produce, "act_5_4", 1)
                        yield_([])

                    # last part
                    elementActivactionsIn = of_act_2_3_5.acquire(ObjectFifoPort.Consume, 2)
                    element0ActivactionsOut = act_5_4.acquire(ObjectFifoPort.Produce, 1)
                    res = call(conv2dk3, [
                            elementActivactionsIn[0], elementActivactionsIn[1], elementActivactionsIn[1],
                            element0Weights, element0ActivactionsOut,
                            tensorInW, tensorL2InC, tensorL2OutC, 3, 3, 2, scale, tensorL2OutC // 2])
                    objectfifo_release(ObjectFifoPort.Consume, "act_2_3_5", 2)
                    objectfifo_release(ObjectFifoPort.Produce, "act_5_4", 1)
                    objectfifo_release(ObjectFifoPort.Consume, "wts_buf_01", 1)
                    yield_([])

            # # 1x1 conv2d and add skip
            @core(ComputeTile4, "conv2dk1_skip.o")
            def core_body():
                for _ in for_(sys.maxsize):

                    # acquire weights and rtps once
                    element0Weights = wts_buf_02.acquire(ObjectFifoPort.Consume, 1)
                    scale = memref.load(rtpComputeTile4, [0])
                    skipScale = memref.load(rtpComputeTile4, [1])

                    for _ in for_(tensorInH):
                        element0ActivactionsIn = act_3_4.acquire(ObjectFifoPort.Consume, 1)
                        element1ActivactionsIn = act_5_4.acquire(ObjectFifoPort.Consume, 1)
                        elementSkipsIn = of_skip_buf.acquire(ObjectFifoPort.Consume, 1)
                        elementActivactionsOut = outOFL2L3.acquire(ObjectFifoPort.Produce, 1)
                        call(conv2dk1_skip, [element0ActivactionsIn,element1ActivactionsIn,
                                element0Weights, elementActivactionsOut, elementSkipsIn,
                                tensorInW, tensorL3InC, tensorL3OutC, scale, skipScale])
                        objectfifo_release(ObjectFifoPort.Produce, "outOFL2L3", 1)
                        objectfifo_release(ObjectFifoPort.Consume, "act_3_4", 1)
                        objectfifo_release(ObjectFifoPort.Consume, "act_5_4", 1)
                        objectfifo_release(ObjectFifoPort.Consume, "skip_buf", 1)
                        yield_([])
                    objectfifo_release(ObjectFifoPort.Consume, "wts_buf_02", 1)
                    yield_([])

            # instruction stream generation
            activationsIn = tensorInW * tensorInH * tensorInC
            acitivationsOut = activationsIn
            totalWeights = (
                tensorL1InC * tensorL1OutC
                + 3 * 3 * tensorL2InC * tensorL2OutC
                + tensorL3InC * tensorL3OutC
            )

            activationsInL3_ty = MemRefType.get((activationsIn,), IntegerType.get_signless(8))
            weightsInL3_ty = MemRefType.get((totalWeights,), IntegerType.get_unsigned(8))

            @runtime_sequence(activationsInL3_ty, weightsInL3_ty, activationsInL3_ty)
            def sequence(inputFromL3, weightsFromL3, outputToL3):

                # write RTP parameters
                NpuWriteRTPOp("rtpComputeTile2", index=0, value=1)  # scale
                NpuWriteRTPOp("rtpComputeTile3", index=0, value=1)  # scale
                NpuWriteRTPOp("rtpComputeTile5", index=0, value=1)  # scale
                NpuWriteRTPOp("rtpComputeTile4", index=0, value=1)  # scale: 
                NpuWriteRTPOp("rtpComputeTile4", index=1, value=0)  # skip_scale


                for i in range(2):
                    npu_dma_memcpy_nd(metadata="inOF_act_L3L2", 
                        bd_id=0, mem=inputFromL3, sizes=[1, 1, 1, activationsIn], offsets=[0, 0, 0, 2*i * activationsIn])
                    npu_dma_memcpy_nd(metadata="outOFL2L3",
                        bd_id=2, mem=outputToL3, sizes=[1, 1, 1, acitivationsOut], offsets=[0, 0, 0, 2*i * acitivationsOut])
                    npu_dma_memcpy_nd(metadata="inOF_wts_0_L3L2",
                        bd_id=1, mem=weightsFromL3, sizes=[1, 1, 1, totalWeights])

                    npu_sync(column=0, row=0, direction=0, channel=0)

    print(ctx.module)


bottleneck4AIEs()
