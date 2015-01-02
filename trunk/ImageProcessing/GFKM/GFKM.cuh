//#include "cuda_runtime.h"
//#include "device_launch_parameters.h"
#include "device_functions.h"
#include "sm_11_atomic_functions.h"
#include "math_functions.h"

#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "GFKM.h"

#include <malloc.h>

__global__ void initialize_NNT_kernel
	(double* points, double* centroids, int* NNT, double* DNNT,
	 int N, int D, int K, int M);

__global__ void update_memberships_kernel
	(int* NNT, double* DNNT, double* U_ALG, double* tempU, 
	 int N, int K, int M, double fuzzifier);

__host__ void update_centroids
	(double* points, double* centroids, int* NNT, double* tempU,
	 int N, int D, int K, int M);

__global__ void histogram_kernel(int* NNT, int* histo, int size);

__global__ void scan_kernel(int* histo, int K);

__global__ void counting_sort_kernel(int* NNT, int* histo, int* odata, int size, int M);

__global__ void reduce_memberships_kernel
	(int* NNT, double* tempU, double* odata, int N, int K, int cid);

__global__ void reduce_centroids_kernel
	(double* points, int* NNT, double* tempU, double* odata,
	 int N, int D, int K, int pid, int cid);

__global__ void reduce_centroids_kernel
	(double* centroids, double* memberships, double* tempC, int* histo,  int D, int K);

__host__ void reduce_centroids
	(double* centroids, double* u, double* tempC, int* histo, int D, int K);

__global__ void update_NNT_kernel
	(double* points, double* centroids, int* NNT, double* DNNT, 
	 double* tempU, double* D_ALG, int N, int D, int K, int M);

__host__ double reduce_J(double* D_ALG, int N, int K);

__global__ void reduce_J_kernel(double* idata, double* odata, unsigned int n);

__host__ double* GFKM_GPU(GFKM G, int block_size, int stop_iter);

template <unsigned int blockSize, unsigned int dblockSize>
__global__ void reduce_J_kernel1(double* idata, double* odata, unsigned int n)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*dblockSize + tid;
	int gridSize = dblockSize*gridDim.x;
	sdata[tid] = 0;

	while(i < n){
		sdata[tid] = sdata[tid] + idata[i];

		if(i+blockSize < n) 
			sdata[tid] = sdata[tid] + idata[i+blockSize];
		i += gridSize;
	}
	__syncthreads();

	if(blockSize > 511){
		if(tid < 256)
			sdata[tid] = sdata[tid] + sdata[tid+256];
		__syncthreads();
	}

	if(blockSize > 255){
		if(tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	}

	if(blockSize > 127){
		if(tid < 64)
			sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	}

	if(tid < 32){
		volatile double * smem = sdata;
		if(blockSize > 63) smem[tid] = smem[tid] + smem[tid + 32];
		if(blockSize > 31) smem[tid] = smem[tid] + smem[tid + 16];
		if(blockSize > 15) smem[tid] = smem[tid] + smem[tid + 8];
		if(blockSize > 7) smem[tid] = smem[tid] + smem[tid + 4];
		if(blockSize > 3) smem[tid] = smem[tid] + smem[tid + 2];
		if(blockSize > 1) smem[tid] = smem[tid] + smem[tid + 1];
	}

	if(tid == 0) odata[blockIdx.x] = sdata[0];
};
