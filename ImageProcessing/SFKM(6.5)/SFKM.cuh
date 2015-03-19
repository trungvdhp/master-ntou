#define __CUDA_INTERNAL_COMPILATION__
#include "math_functions.h"
#undef __CUDA_INTERNAL_COMPILATION__
#include "device_launch_parameters.h"
#include "device_functions.h"

#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "FKM.h"

//void run();

inline __host__ int roundup(int x, int y);

__global__ void update_memberships_kernel(
	double * points, double * centroids, double * memberships, 
	int N, int D, int K, double fuzzifier);

__global__ void reduce_memberships_kernel(double * memberships, double * sumU, int N);

__global__ void reduce_centroids_kernel(double * points, double * memberships, double * sumC, int N);

__host__ void reduce_centroids
	(double * centroids, double * sumC, double * sumU, int num_reduction_blocks, int D, int K);

__global__ void calculate_new_centroids(double * centroids, double * memberships);

__host__ void calculate_new_centroids(double * points, double * memberships, double * newCentroids, int N, int D, int K);

__global__ void check_convergence(double * centroids, double * newCentroids, bool * flag, double epsilon);

__host__ double * FKM_GPU(FILE * f, FKM & G, int block_size, int stop_iter = INT_MAX, int mode = 1);