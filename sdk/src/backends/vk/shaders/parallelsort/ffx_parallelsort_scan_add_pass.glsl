// This file is part of the FidelityFX SDK.
//
// Copyright © 2023 Advanced Micro Devices, Inc.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this softwareand associated documentation files(the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
// 
// The above copyright noticeand this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// Parallel Sort Scan Add Pass
// UAV  0 : ParallelSort_Scan_Source      : rw_scan_source
// UAV  1 : ParallelSort_Scan_Dest        : rw_scan_dest
// UAV  2 : ParallelSort_Scan_Scratch     : rw_scan_scratch
// CBV  0 : cbParallelSort

#version 450
#extension GL_GOOGLE_include_directive : require
#extension GL_KHR_shader_subgroup_arithmetic : require

#define FFX_PARALLELSORT_BIND_UAV_SCAN_SOURCE           2000
#define FFX_PARALLELSORT_BIND_UAV_SCAN_DEST             2001
#define FFX_PARALLELSORT_BIND_UAV_SCAN_SCRATCH          2002

#define FFX_PARALLELSORT_BIND_CB_PARALLEL_SORT          3000

#include "parallelsort/ffx_parallelsort_callbacks_glsl.h"
#include "parallelsort/ffx_parallelsort_common.h"
#include "parallelsort/ffx_parallelsort_scan_add.h"

#ifndef FFX_PARALLELSORT_THREAD_GROUP_WIDTH
#define FFX_PARALLELSORT_THREAD_GROUP_WIDTH FFX_PARALLELSORT_THREADGROUP_SIZE
#endif // #ifndef FFX_PARALLELSORT_THREAD_GROUP_WIDTH

#ifndef FFX_PARALLELSORT_THREAD_GROUP_HEIGHT
#define FFX_PARALLELSORT_THREAD_GROUP_HEIGHT 1
#endif // FFX_PARALLELSORT_THREAD_GROUP_HEIGHT

#ifndef FFX_PARALLELSORT_THREAD_GROUP_DEPTH
#define FFX_PARALLELSORT_THREAD_GROUP_DEPTH 1
#endif // #ifndef FFX_PARALLELSORT_THREAD_GROUP_DEPTH

#ifndef FFX_PARALLELSORT_NUM_THREADS
#define FFX_PARALLELSORT_NUM_THREADS layout (local_size_x = FFX_PARALLELSORT_THREAD_GROUP_WIDTH, local_size_y = FFX_PARALLELSORT_THREAD_GROUP_HEIGHT, local_size_z = FFX_PARALLELSORT_THREAD_GROUP_DEPTH) in;
#endif // #ifndef FFX_PARALLELSORT_NUM_THREADS

FFX_PARALLELSORT_NUM_THREADS
void main()
{
    FfxParallelSortScanAdd(gl_LocalInvocationID.x, gl_WorkGroupID.x);
}