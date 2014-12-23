#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#define CUDA_ERROR_CHECK

#define CudaSafeCall(err) __cudaSafeCall(err, __FILE__, __LINE__)
#define CudaCheckError()  __cudaCheckError(__FILE__, __LINE__)

inline void __cudaSafeCall(cudaError_t err, const char *file, const int line)
{
#ifdef CUDA_ERROR_CHECK
	if(cudaSuccess != err)
	{
		fprintf(stderr, "cudaSafeCall() failed at %s:%i : %s\n", 
			file, line, cudaGetErrorString(err));
		exit(-1);
	}
#endif
	return;
}

inline void __cudaCheckError(const char *file, const int line)
{
#ifdef CUDA_ERROR_CHECK
	cudaError_t err = cudaGetLastError();
	
	if(cudaSuccess != err){
		fprintf(stderr, "cudaCheckError() failed at %s:%i : %s\n", 
			file, line, cudaGetErrorString(err));
		exit(-1);
	}
	err = cudaDeviceSynchronize();

	if(cudaSuccess != err){
		fprintf(stderr, "cudaCheckError() with sync failed at %s:%i : %s\n", 
			file, line, cudaGetErrorString(err));
		exit(-1);
	}
#endif
	return;
}