#include "device_launch_parameters.h"
#include "device_functions.h"
#include "math_functions.h"

#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "GFKM.h"

//void run();

inline __host__ int roundup(int x, int y);

__global__ void update_memberships_kernel(
	double * points, double * centroids, double * memberships, int * NNT,
	int N, int D, int K, int M, double fuzzifier);

__global__ void reduce_memberships_kernel
	(double * memberships, double * odata, int N);

__global__ void reduce_centroids_kernel
	(double * points, double * memberships, double * odata, int N);

__global__ void calculate_new_centroids(double * centroids, double * memberships);

__host__ void calculate_new_centroids(
	double * points, double * memberships, double * newCentroids, 
	int * NNT, int N, int D, int K, int M);

__global__ void check_convergence(double * centroids, double * newCentroids, int * flag, double epsilon);

__host__ double * FKM_GPU(FILE * f, GFKM & G, int block_size, int stop_iter, int mode = 1);