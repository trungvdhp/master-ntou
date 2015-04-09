#define __CUDA_INTERNAL_COMPILATION__
#include "math_functions.h"
#undef __CUDA_INTERNAL_COMPILATION__
#include "device_launch_parameters.h"
#include "device_functions.h"

#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "FKM.h"

__host__ double * FKM_GPU(FILE * f, FKM & G, int block_size, int stop_iter = INT_MAX, int mode = 1);