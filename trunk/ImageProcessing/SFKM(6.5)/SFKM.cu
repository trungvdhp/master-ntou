#include "SFKM.cuh"
#include "Util.h"
#define DIM_MAX 100
#define NSTREAM 5

inline __host__ int roundup(int x, int y)
{
	return 1 + (x-1)/y;
}

__global__ void update_memberships_kernel_v1a(
	double * points, double * centroids, double * memberships, 
	int N, int D, int K, double fuzzifier)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if (idx >= N) return;
	int i, j;
	double * pMemberships = memberships + idx*K;
	double * pCentroids = centroids;
	double X[DIM_MAX];
	double f = 1. / (fuzzifier - 1.);
	double diff, temp, sum = 0.;

	for (i = 0, j = idx*D; i < D; ++i, ++j) X[i] = points[j];

	for (i = 0; i < K; ++i) pMemberships[i] = 0.;

	for (i = 0; i < K; ++i, pCentroids += D){
		diff = 0.;

		for (j = 0; j < D; ++j){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}

		if (diff == 0.){ 
			pMemberships[i] = 1.;
			return;
		}
		diff = pow(diff, f);
		pMemberships[i] = diff;
		sum = sum + 1. / diff;
	}

	for (i = 0; i < K; ++i){
		pMemberships[i] = pow(pMemberships[i]*sum, -fuzzifier);
	}
}

__global__ void update_memberships_kernel_v1b(
	double * points, double * centroids, double * memberships, 
	int N, int D, int K, double fuzzifier)
{
	extern __shared__ double C[];
	int tid = threadIdx.x;
	int idx = blockIdx.x * blockDim.x + tid;

	if (tid < K*D){
		C[tid] = centroids[tid];
	}
	__syncthreads();

	if (idx >= N) return;
	int i, j;
	double * pMemberships = memberships + idx*K;
	double * pCentroids = C;
	double X[DIM_MAX];
	double f = 1. / (fuzzifier - 1.);
	double diff, temp, sum = 0.;

	for (i = 0, j = idx*D; i < D; ++i, ++j) X[i] = points[j];

	for (i = 0; i < K; ++i) pMemberships[i] = 0.;

	for (i = 0; i < K; ++i, pCentroids += D){
		diff = 0.;

		for (j = 0; j < D; ++j){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}

		if (diff == 0.){ 
			pMemberships[i] = 1.;
			return;
		}
		diff = pow(diff, f);
		pMemberships[i] = diff;
		sum = sum + 1. / diff;
	}

	for (i = 0; i < K; ++i){
		pMemberships[i] = pow(pMemberships[i]*sum, -fuzzifier);
	}
}

__global__ void update_memberships_kernel_v1c(
	double * points, double * centroids, double * memberships, 
	int N, int D, int K, int step, double fuzzifier)
{
	extern __shared__ double C[];

	int tid = threadIdx.x;
	int idx = blockIdx.x * blockDim.x + tid;
	int i, j;
	
	for (i = 0, j = K*D, tid *= step; tid < j && i < step; ++i, ++tid){
		C[tid] = centroids[tid];
	}
	__syncthreads();

	if (idx >= N) return;
	double * pMemberships = memberships + idx*K;
	double * pCentroids = C;
	double X[DIM_MAX];
	double f = 1. / (fuzzifier - 1.);
	double diff, temp, sum = 0.;

	for (i = 0, j = idx*D; i < D; ++i, ++j) X[i] = points[j];

	for (i = 0; i < K; ++i) pMemberships[i] = 0.;

	for (i = 0; i < K; ++i, pCentroids += D){
		diff = 0.;

		for (j = 0; j < D; ++j){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}

		if (diff == 0.){ 
			pMemberships[i] = 1.;
			return;
		}
		diff = pow(diff, f);
		pMemberships[i] = diff;
		sum = sum + 1. / diff;
	}

	for (i = 0; i < K; ++i){
		pMemberships[i] = pow(pMemberships[i]*sum, -fuzzifier);
	}
}

__global__ void reduce_memberships_kernel(double * memberships, double * sumU, int N)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*blockDim.x + tid;
	int gridSize = blockDim.x*gridDim.x;
	double temp = 0.0;

	while(i < N){
		temp = temp + memberships[i];
		i += gridSize;
	}
	sdata[tid] = temp;
	__syncthreads();

	if (blockDim.x > 255){
		if (tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	}

	if (blockDim.x > 127){
		if (tid < 64) sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	}

	if (tid < 32) sdata[tid] = sdata[tid] + sdata[tid + 32];
	if (tid < 16) sdata[tid] = sdata[tid] + sdata[tid + 16];
	if (tid < 8) sdata[tid] = sdata[tid] + sdata[tid + 8];
	if (tid < 4) sdata[tid] = sdata[tid] + sdata[tid + 4];
	if (tid < 2) sdata[tid] = sdata[tid] + sdata[tid + 2];

	if (tid == 0) sumU[blockIdx.x] = sdata[0] + sdata[1];
}

__global__ void reduce_centroids_kernel
	(double * points, double * memberships, double * sumC, int N)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*blockDim.x + tid;
	int gridSize = blockDim.x*gridDim.x;
	double temp = 0.0;
	
	while(i < N){
		temp = temp + points[i] * memberships[i];
		i += gridSize;
	}
	sdata[tid] = temp;
	__syncthreads();

	if (tid < 128) 
		sdata[tid] = sdata[tid] + sdata[tid+128];
	__syncthreads();

	if (tid < 64) 
		sdata[tid] = sdata[tid] + sdata[tid+64];
	__syncthreads();

	if (tid < 32) sdata[tid] = sdata[tid] + sdata[tid + 32];
	if (tid < 16) sdata[tid] = sdata[tid] + sdata[tid + 16];
	if (tid < 8) sdata[tid] = sdata[tid] + sdata[tid + 8];
	if (tid < 4) sdata[tid] = sdata[tid] + sdata[tid + 4];
	if (tid < 2) sdata[tid] = sdata[tid] + sdata[tid + 2];

	if (tid == 0) sumC[blockIdx.x] = sdata[0] + sdata[1];
}

__host__ void reduce_centroids
	(double * centroids, double * sumC, double * sumU, int num_reduction_blocks, int D, int K)
{
	double * p_centroids = centroids;
	double * p_sumU = sumU;
	double * p_sumC = sumC;

	double u;
	int i, j, k;

	for (i = 0; i < K; ++i){
		u = 0.0;

		for (j = 0; j < num_reduction_blocks; ++j)
			u = u + p_sumU[j];

		for (j = 0; j < D; ++j){
			p_centroids[j] = 0.0;

			for (k = 0; k < num_reduction_blocks; ++k){
				p_centroids[j] = p_centroids[j] + p_sumC[k];
			}
			p_centroids[j] = p_centroids[j] /u;
			p_sumC += num_reduction_blocks;
		}
		p_sumU += num_reduction_blocks;
		p_centroids += D;
	}
}

__global__ void calculate_new_centroids(double * centroids, double * memberships)
{
	int cid = blockIdx.x*blockDim.x + threadIdx.x;
	centroids[cid] = centroids[cid] / memberships[blockIdx.x];
}

__host__ void calculate_new_centroids(double * points, double * memberships, double * newCentroids, int N, int D, int K)
{
	int i, j, k;
	double * pPoints = points;
	double * pMemberships = memberships;
	double * pCentroids;
	double * sum = new double[K]();
	memset(newCentroids, 0, K*D*sizeof(double));

	for (i = 0; i < N; ++i, pMemberships += K, pPoints += D){
		pCentroids = newCentroids;

		for (j = 0; j < K; ++j, pCentroids += D){
			sum[j] = sum[j] + pMemberships[j];
			
			for (k = 0; k < D; ++k)
				pCentroids[k] = pCentroids[k] + pMemberships[j]*pPoints[k];
		}
	}
	pCentroids = newCentroids;

	for (i = 0; i < K; ++i, pCentroids += D)
		for (j = 0; j < D; ++j)
			pCentroids[j] = pCentroids[j] / sum[i];
}

__global__ void check_convergence(double * centroids, double * newCentroids, bool * flag, double epsilon)
{
	int cid = blockDim.x * blockIdx.x + threadIdx.x;
	flag[0] = fabs(centroids[cid] - newCentroids[cid]) >= epsilon;
	//__threadfence();
	/*flag[0] = false;
	int n = blockDim.x;

	for (int i = 0; i < n; ++i){
		if (fabs(centroids[i] - newCentroids[i]) >= epsilon){
			flag[0] = true;
			return;
		}
	}*/
}

__host__ double * FKM_GPU_v1a(FILE * f, FKM & G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K* DBL_SIZE;

	int num_blocks = roundup(G.N, block_size);

	double t1 = 0.0, t2 = 0.0, t3 = 0.0;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;
	double * d_points;
	double * d_centroids;
	double * d_newCentroids;
	double * d_memberships;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;
	double * p_points;
	double * p_centroids;
	double * p_memberships;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));
	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_newCentroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));
	CudaSafeCall(cudaMallocHost(&p_points, points_size));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));
	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));
#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1a<<<num_blocks, block_size>>>
			(d_points, d_centroids,d_memberships, G.N, G.D, G.K, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Calculate new centroids by CPU
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
		t2 = t2 + tmr_GPU.GetCounter();
		tmr_CPU.start();
		calculate_new_centroids(p_points, p_memberships, p_centroids, G.N, G.D, G.K);
		tmr_CPU.stop();
		t2 = t2 + tmr_CPU.elapsed();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_newCentroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_newCentroids, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_newCentroids, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}
	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);
	cudaFree(d_points);
	cudaFree(d_centroids);
	cudaFree(d_newCentroids);
	cudaFree(d_memberships);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_memberships);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3;
	rs[1] = (double)i;
#pragma endregion

	cudaDeviceReset();
	return rs;
}

__host__ double * FKM_GPU_v1b(FILE * f, FKM & G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K * DBL_SIZE;

	int num_blocks = roundup(G.N, block_size);

	double t1 = 0.0, t2 = 0.0, t3 = 0.0;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;
	double * d_points;
	double * d_centroids;
	double * d_newCentroids;
	double * d_memberships;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;
	double * p_points;
	double * p_centroids;
	double * p_memberships;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));
	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_newCentroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));
	CudaSafeCall(cudaMallocHost(&p_points, points_size));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));
	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));
#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1b<<<num_blocks, block_size, centroids_size>>>
			(d_points, d_centroids,d_memberships, G.N, G.D, G.K, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Calculate new centroids by CPU
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
		t2 = t2 + tmr_GPU.GetCounter();
		tmr_CPU.start();
		calculate_new_centroids(p_points, p_memberships, p_centroids, G.N, G.D, G.K);
		tmr_CPU.stop();
		t2 = t2 + tmr_CPU.elapsed();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_newCentroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_newCentroids, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_newCentroids, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}
	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);
	cudaFree(d_points);
	cudaFree(d_centroids);
	cudaFree(d_newCentroids);
	cudaFree(d_memberships);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_memberships);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3;
	rs[1] = (double)i;
#pragma endregion

	cudaDeviceReset();
	return rs;
}

__host__ double * FKM_GPU_v1c(FILE * f, FKM & G, int block_size, int stop_iter, int step)
{
#pragma region Declare common variables
	int i;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K * DBL_SIZE;

	int num_blocks = roundup(G.N, block_size);

	double t1 = 0.0, t2 = 0.0, t3 = 0.0;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;
	double * d_points;
	double * d_centroids;
	double * d_newCentroids;
	double * d_memberships;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;
	double * p_points;
	double * p_centroids;
	double * p_memberships;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));
	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_newCentroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));
	CudaSafeCall(cudaMallocHost(&p_points, points_size));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));
	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));
#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1c<<<num_blocks, block_size, centroids_size>>>
			(d_points, d_centroids,d_memberships, G.N, G.D, G.K, step, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Calculate new centroids by CPU
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
		t2 = t2 + tmr_GPU.GetCounter();
		tmr_CPU.start();
		calculate_new_centroids(p_points, p_memberships, p_centroids, G.N, G.D, G.K);
		tmr_CPU.stop();
		t2 = t2 + tmr_CPU.elapsed();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_newCentroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_newCentroids, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_newCentroids, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}
	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);
	cudaFree(d_points);
	cudaFree(d_centroids);
	cudaFree(d_newCentroids);
	cudaFree(d_memberships);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_memberships);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3;
	rs[1] = (double)i;
#pragma endregion

	cudaDeviceReset();
	return rs;
}

__host__ double * FKM_GPU_v2a(FILE * f, FKM & G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i, j, k;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroid_size = G.K * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K * DBL_SIZE;
	
	int sm_size = block_size * DBL_SIZE;
	
	int num_blocks = roundup(G.N, block_size);
	int num_reduction_blocks;

	int reduction_block_size = block_size<<2;

	num_reduction_blocks = roundup(G.N, reduction_block_size);

	int sumU_size = num_reduction_blocks * centroid_size;
	int sumC_size = num_reduction_blocks * centroids_size;

	int offset;
	int offset_sumU;
	int offset_sumC;
	int offset_pointsT;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;

	double alpha, beta;
	double t1 = 0.0, t2 = 0.0, t3 = 0.0, t4;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;

	double * d_points;
	double * d_pointsT;

	double * d_centroids;

	double * d_memberships;
	double * d_membershipsT;

	double * d_sumU;
	double * d_sumC;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;

	double * p_points;

	double * p_centroids;

	double * p_memberships;

	double * p_sumU;
	double * p_sumC;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));

	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_pointsT, points_size));

	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));

	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
	CudaSafeCall(cudaMalloc(&d_membershipsT, memberships_size));

	CudaSafeCall(cudaMalloc(&d_sumU, sumU_size));
	CudaSafeCall(cudaMalloc(&d_sumC, sumC_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));

	CudaSafeCall(cudaMallocHost(&p_points, points_size));

	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));

	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));

	CudaSafeCall(cudaMallocHost(&p_sumU, sumU_size));
	CudaSafeCall(cudaMallocHost(&p_sumC, sumC_size));

#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Declare cuda streams and transpose points
	cublasHandle_t handle;
	cudaStream_t * streams = new cudaStream_t[NSTREAM];

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamCreate(&streams[i]);

	CublasSafeCall(cublasCreate(&handle));
	alpha = 1.;
	beta  = 0.;
	tmr_GPU.StartCounter();
	CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.D,
		&alpha, d_points, G.D, &beta, d_points, G.D, d_pointsT, G.N)); 
	t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1a<<<num_blocks, block_size>>>
			(d_points, d_centroids, d_memberships, G.N, G.D, G.K, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Transpose memberships
		alpha = 1.;
		beta  = 0.;
		tmr_GPU.StartCounter();
		CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.K,
			&alpha, d_memberships, G.K, &beta, d_memberships, G.K, d_membershipsT, G.N)); 
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Reduce centroids by GPU
		tmr_GPU.StartCounter();
		offset = 0;
		offset_sumU = 0;
		offset_sumC = 0;

		for (j = 0; j < G.K; ++j){
			reduce_memberships_kernel<<<num_reduction_blocks, block_size, sm_size, streams[0]>>>
				(d_membershipsT + offset, d_sumU + offset_sumU, G.N);
			offset_pointsT = 0;

			for (k = 0; k < G.D; ++k){
				reduce_centroids_kernel<<<num_reduction_blocks, block_size, sm_size, streams[k % (NSTREAM-1)+1]>>>
						(d_pointsT + offset_pointsT, d_membershipsT + offset, d_sumC + offset_sumC, G.N);
				offset_pointsT += G.N;
				offset_sumC += num_reduction_blocks;
			}
			offset_sumU += num_reduction_blocks;
			offset += G.N;
		}
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

		if (num_reduction_blocks > 1){
#pragma region Reduce memberships and centroids block sums by CPU
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(p_sumU, d_sumU, sumU_size, cudaMemcpyDeviceToHost));
			CudaSafeCall(cudaMemcpyAsync(p_sumC, d_sumC, sumC_size, cudaMemcpyDeviceToHost));
			t2 = t2 + tmr_GPU.GetCounter();
			tmr_CPU.start();
			reduce_centroids(p_centroids, p_sumC, p_sumU, num_reduction_blocks, G.D, G.K);
			tmr_CPU.stop();
			t2 = t2 + tmr_CPU.elapsed();
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(d_sumC, p_centroids, centroids_size, cudaMemcpyHostToDevice));
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
		else{
#pragma region Calculate centroids by GPU
			tmr_GPU.StartCounter();
			calculate_new_centroids<<<G.K, G.D>>>(d_sumC, d_sumU);
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_sumC, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_sumC, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}

	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
	tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_centroids, d_centroids, centroids_size, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
	t4 = tmr_GPU.GetCounter();
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);

	cudaFree(d_points);
	cudaFree(d_pointsT);

	cudaFree(d_centroids);

	cudaFree(d_memberships);
	cudaFree(d_membershipsT);

	cudaFree(d_sumU);
	cudaFree(d_sumC);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);

	cudaFreeHost(p_points);

	cudaFreeHost(p_centroids);

	cudaFreeHost(p_memberships);

	cudaFreeHost(p_sumU);
	cudaFreeHost(p_sumC);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3 + t4;
	rs[1] = (double)i;
#pragma endregion

#pragma region CublasDestroy, CudaStreamDestroy, and DeviceReset
	CublasSafeCall(cublasDestroy(handle));

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamDestroy(streams[i]);
	
	cudaDeviceReset();
#pragma endregion
	
	return rs;
}

__host__ double * FKM_GPU_v2b(FILE * f, FKM & G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i, j, k;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroid_size = G.K * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K * DBL_SIZE;
	
	int sm_size = block_size * DBL_SIZE;
	
	int num_blocks = roundup(G.N, block_size);
	int num_reduction_blocks;

	int reduction_block_size = block_size<<2;

	num_reduction_blocks = roundup(G.N, reduction_block_size);

	int sumU_size = num_reduction_blocks * centroid_size;
	int sumC_size = num_reduction_blocks * centroids_size;

	int offset;
	int offset_sumU;
	int offset_sumC;
	int offset_pointsT;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;

	double alpha, beta;
	double t1 = 0.0, t2 = 0.0, t3 = 0.0, t4;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;

	double * d_points;
	double * d_pointsT;

	double * d_centroids;

	double * d_memberships;
	double * d_membershipsT;

	double * d_sumU;
	double * d_sumC;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;

	double * p_points;

	double * p_centroids;

	double * p_memberships;

	double * p_sumU;
	double * p_sumC;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));

	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_pointsT, points_size));

	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));

	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
	CudaSafeCall(cudaMalloc(&d_membershipsT, memberships_size));

	CudaSafeCall(cudaMalloc(&d_sumU, sumU_size));
	CudaSafeCall(cudaMalloc(&d_sumC, sumC_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));

	CudaSafeCall(cudaMallocHost(&p_points, points_size));

	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));

	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));

	CudaSafeCall(cudaMallocHost(&p_sumU, sumU_size));
	CudaSafeCall(cudaMallocHost(&p_sumC, sumC_size));

#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Declare cuda streams and transpose points
	cublasHandle_t handle;
	cudaStream_t * streams = new cudaStream_t[NSTREAM];

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamCreate(&streams[i]);

	CublasSafeCall(cublasCreate(&handle));
	alpha = 1.;
	beta  = 0.;
	tmr_GPU.StartCounter();
	CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.D,
		&alpha, d_points, G.D, &beta, d_points, G.D, d_pointsT, G.N)); 
	t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1b<<<num_blocks, block_size, centroids_size>>>
			(d_points, d_centroids, d_memberships, G.N, G.D, G.K, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Transpose memberships
		alpha = 1.;
		beta  = 0.;
		tmr_GPU.StartCounter();
		CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.K,
			&alpha, d_memberships, G.K, &beta, d_memberships, G.K, d_membershipsT, G.N)); 
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Reduce centroids by GPU
		tmr_GPU.StartCounter();
		offset = 0;
		offset_sumU = 0;
		offset_sumC = 0;

		for (j = 0; j < G.K; ++j){
			reduce_memberships_kernel<<<num_reduction_blocks, block_size, sm_size, streams[0]>>>
				(d_membershipsT + offset, d_sumU + offset_sumU, G.N);
			offset_pointsT = 0;

			for (k = 0; k < G.D; ++k){
				reduce_centroids_kernel<<<num_reduction_blocks, block_size, sm_size, streams[k % (NSTREAM-1)+1]>>>
						(d_pointsT + offset_pointsT, d_membershipsT + offset, d_sumC + offset_sumC, G.N);
				offset_pointsT += G.N;
				offset_sumC += num_reduction_blocks;
			}
			offset_sumU += num_reduction_blocks;
			offset += G.N;
		}
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

		if (num_reduction_blocks > 1){
#pragma region Reduce memberships and centroids block sums by CPU
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(p_sumU, d_sumU, sumU_size, cudaMemcpyDeviceToHost));
			CudaSafeCall(cudaMemcpyAsync(p_sumC, d_sumC, sumC_size, cudaMemcpyDeviceToHost));
			t2 = t2 + tmr_GPU.GetCounter();
			tmr_CPU.start();
			reduce_centroids(p_centroids, p_sumC, p_sumU, num_reduction_blocks, G.D, G.K);
			tmr_CPU.stop();
			t2 = t2 + tmr_CPU.elapsed();
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(d_sumC, p_centroids, centroids_size, cudaMemcpyHostToDevice));
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
		else{
#pragma region Calculate centroids by GPU
			tmr_GPU.StartCounter();
			calculate_new_centroids<<<G.K, G.D>>>(d_sumC, d_sumU);
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_sumC, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_sumC, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}

	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
	tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_centroids, d_centroids, centroids_size, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
	t4 = tmr_GPU.GetCounter();
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);

	cudaFree(d_points);
	cudaFree(d_pointsT);

	cudaFree(d_centroids);

	cudaFree(d_memberships);
	cudaFree(d_membershipsT);

	cudaFree(d_sumU);
	cudaFree(d_sumC);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);

	cudaFreeHost(p_points);

	cudaFreeHost(p_centroids);

	cudaFreeHost(p_memberships);

	cudaFreeHost(p_sumU);
	cudaFreeHost(p_sumC);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3 + t4;
	rs[1] = (double)i;
#pragma endregion

#pragma region CublasDestroy, CudaStreamDestroy, and DeviceReset
	CublasSafeCall(cublasDestroy(handle));

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamDestroy(streams[i]);
	
	cudaDeviceReset();
#pragma endregion
	
	return rs;
}

__host__ double * FKM_GPU_v2c(FILE * f, FKM & G, int block_size, int stop_iter, int step)
{
#pragma region Declare common variables
	int i, j, k;
	int DBL_SIZE = sizeof(double);
	int flag_size = sizeof(bool);

	int points_size = G.N * G.D * DBL_SIZE;
	int centroid_size = G.K * DBL_SIZE;
	int centroids_size = G.K * G.D * DBL_SIZE;
	int memberships_size = G.N * G.K * DBL_SIZE;
	
	int sm_size = block_size * DBL_SIZE;
	
	int num_blocks = roundup(G.N, block_size);
	int num_reduction_blocks;

	int reduction_block_size = block_size<<2;

	num_reduction_blocks = roundup(G.N, reduction_block_size);

	int sumU_size = num_reduction_blocks * centroid_size;
	int sumC_size = num_reduction_blocks * centroids_size;

	int offset;
	int offset_sumU;
	int offset_sumC;
	int offset_pointsT;

	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;

	double alpha, beta;
	double t1 = 0.0, t2 = 0.0, t3 = 0.0, t4;
#pragma endregion

#pragma region Declare device memories
	bool * d_flags;

	double * d_points;
	double * d_pointsT;

	double * d_centroids;

	double * d_memberships;
	double * d_membershipsT;

	double * d_sumU;
	double * d_sumC;
#pragma endregion

#pragma region Declare host pinned memories
	bool * p_flags;

	double * p_points;

	double * p_centroids;

	double * p_memberships;

	double * p_sumU;
	double * p_sumC;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_flags, flag_size));

	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_pointsT, points_size));

	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));

	CudaSafeCall(cudaMalloc(&d_memberships, memberships_size));
	CudaSafeCall(cudaMalloc(&d_membershipsT, memberships_size));

	CudaSafeCall(cudaMalloc(&d_sumU, sumU_size));
	CudaSafeCall(cudaMalloc(&d_sumC, sumC_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_flags, flag_size));

	CudaSafeCall(cudaMallocHost(&p_points, points_size));

	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));

	CudaSafeCall(cudaMallocHost(&p_memberships, memberships_size));

	CudaSafeCall(cudaMallocHost(&p_sumU, sumU_size));
	CudaSafeCall(cudaMallocHost(&p_sumC, sumC_size));

#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size);
	memcpy(p_centroids, G.centroids, centroids_size);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Declare cuda streams and transpose points
	cublasHandle_t handle;
	cudaStream_t * streams = new cudaStream_t[NSTREAM];

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamCreate(&streams[i]);

	CublasSafeCall(cublasCreate(&handle));
	alpha = 1.;
	beta  = 0.;
	tmr_GPU.StartCounter();
	CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.D,
		&alpha, d_points, G.D, &beta, d_points, G.D, d_pointsT, G.N)); 
	t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel_v1c<<<num_blocks, block_size, centroids_size>>>
			(d_points, d_centroids, d_memberships, G.N, G.D, G.K, step, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
#pragma region Transpose memberships
		alpha = 1.;
		beta  = 0.;
		tmr_GPU.StartCounter();
		CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.K,
			&alpha, d_memberships, G.K, &beta, d_memberships, G.K, d_membershipsT, G.N)); 
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Reduce centroids by GPU
		tmr_GPU.StartCounter();
		offset = 0;
		offset_sumU = 0;
		offset_sumC = 0;

		for (j = 0; j < G.K; ++j){
			reduce_memberships_kernel<<<num_reduction_blocks, block_size, sm_size, streams[0]>>>
				(d_membershipsT + offset, d_sumU + offset_sumU, G.N);
			offset_pointsT = 0;

			for (k = 0; k < G.D; ++k){
				reduce_centroids_kernel<<<num_reduction_blocks, block_size, sm_size, streams[k % (NSTREAM-1)+1]>>>
						(d_pointsT + offset_pointsT, d_membershipsT + offset, d_sumC + offset_sumC, G.N);
				offset_pointsT += G.N;
				offset_sumC += num_reduction_blocks;
			}
			offset_sumU += num_reduction_blocks;
			offset += G.N;
		}
		t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

		if (num_reduction_blocks > 1){
#pragma region Reduce memberships and centroids block sums by CPU
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(p_sumU, d_sumU, sumU_size, cudaMemcpyDeviceToHost));
			CudaSafeCall(cudaMemcpyAsync(p_sumC, d_sumC, sumC_size, cudaMemcpyDeviceToHost));
			t2 = t2 + tmr_GPU.GetCounter();
			tmr_CPU.start();
			reduce_centroids(p_centroids, p_sumC, p_sumU, num_reduction_blocks, G.D, G.K);
			tmr_CPU.stop();
			t2 = t2 + tmr_CPU.elapsed();
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(d_sumC, p_centroids, centroids_size, cudaMemcpyHostToDevice));
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
		else{
#pragma region Calculate centroids by GPU
			tmr_GPU.StartCounter();
			calculate_new_centroids<<<G.K, G.D>>>(d_sumC, d_sumU);
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<G.K, G.D>>>(d_centroids, d_sumC, d_flags, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_flags, d_flags, flag_size, cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_sumC, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((!p_flags[0] && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}

	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
	tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_centroids, d_centroids, centroids_size, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, memberships_size, cudaMemcpyDeviceToHost));
	t4 = tmr_GPU.GetCounter();
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<double>(p_memberships, G.N, G.K, G.path + "memberships.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_flags);

	cudaFree(d_points);
	cudaFree(d_pointsT);

	cudaFree(d_centroids);

	cudaFree(d_memberships);
	cudaFree(d_membershipsT);

	cudaFree(d_sumU);
	cudaFree(d_sumC);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_flags);

	cudaFreeHost(p_points);

	cudaFreeHost(p_centroids);

	cudaFreeHost(p_memberships);

	cudaFreeHost(p_sumU);
	cudaFreeHost(p_sumC);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3 + t4;
	rs[1] = (double)i;
#pragma endregion

#pragma region CublasDestroy, CudaStreamDestroy, and DeviceReset
	CublasSafeCall(cublasDestroy(handle));

	for (i = 0; i < NSTREAM; ++i)
		cudaStreamDestroy(streams[i]);
	
	cudaDeviceReset();
#pragma endregion
	
	return rs;
}

__host__ double * FKM_GPU(FILE * f, FKM & G, int block_size, int stop_iter, int mode)
{
	int centroids_size = G.K*G.D;
	int step = roundup(centroids_size, block_size);

	if (mode == 1){
		if (step > 4)
			return FKM_GPU_v1a(f, G, block_size, stop_iter);
		else if (step == 1)
			return FKM_GPU_v1b(f, G, block_size, stop_iter);
		else
			return FKM_GPU_v1c(f, G, block_size, stop_iter, step);
	}
	else{
		if (step > 4)
			return FKM_GPU_v2a(f, G, block_size, stop_iter);
		else if (step == 1)
			return FKM_GPU_v2b(f, G, block_size, stop_iter);
		else
			return FKM_GPU_v2c(f, G, block_size, stop_iter, step);
	}
}