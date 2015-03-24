#define __CUDA_INTERNAL_COMPILATION__
#include "math_functions.h"
#undef __CUDA_INTERNAL_COMPILATION__
#include "device_launch_parameters.h"
#include "device_functions.h"
#include "sm_20_atomic_functions.h"

#include <thrust/device_ptr.h>
#include <thrust/sort.h>
#include <thrust/binary_search.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/adjacent_difference.h>


#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "GFKM.h"

inline __host__ int roundup(int x, int y);

__global__ void update_memberships_kernel_v1(
	double * points, double * centroids, double * memberships, int * NNT,
	int N, int D, int K, int M, double fuzzifier);

__global__ void update_memberships_kernel_v2(
	double * points, double * centroids, double * memberships, int * NNT,
	int N, int D, int K, int M, double fuzzifier);

__global__ void reduce_memberships_kernel(double * memberships, double * sumU, int N);

__global__ void reduce_centroids_kernel
	(double * points, double * memberships, double * sumC, int N);

__host__ void reduce_centroids
	(double * centroids, double * sumC, double * sumU, int num_reduction_blocks, int D, int K);

__global__ void calculate_new_centroids(double * centroids, double * memberships);

__host__ void calculate_new_centroids(
	double * points, double * memberships, double * newCentroids, 
	int * NNT, int N, int D, int K, int M);

////
__global__ void histogram_kernel(int * NNT, int * histo, int size);

__global__ void scan_kernel(int * histo, int K);

__global__ void counting_sort_kernel( 
	int * histo, int * NNT, int * sNNT, double * memberships, double * sU, 
	int size, int M);

__global__ void reduce_centroids_kernel
	(double * points, double * sU, int * sNNT, double * sumC, int size);

__host__ void reduce_centroids
	(double * centroids, double * sumC, double * sumU, int * histo, int D, int K);

////
__global__ void check_convergence(double * centroids, double * newCentroids, bool * flag, double epsilon);

__host__ double * GFKM_GPU_v1(FILE * f, GFKM & G, int block_size, int stop_iter);

__host__ double * GFKM_GPU_v2(FILE * f, GFKM & G, int block_size, int stop_iter);

__host__ double * GFKM_GPU_v3(FILE * f, GFKM & G, int block_size, int stop_iter);

__host__ double * GFKM_GPU(FILE * f, GFKM & G, int block_size, int stop_iter, int mode = 1);