#include "SGFKM.cuh"
#include "Util.h"
#define DIM_MAX 16
#define MMAX 32
#define NSTREAM 5

inline __host__ int roundup(int x, int y)
{
	return 1 + (x-1)/y;
}

__global__ void update_memberships_kernel(
	double * points, double * centroids, double * memberships, int * NNT,
	int N, int D, int K, int M, double fuzzifier)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if (idx >= N) return;
	int i, j;
	int * pNNT = NNT + idx*M;

	double * pMemberships = memberships + idx*K;
	double * pCentroids = centroids;
	
	double X[DIM_MAX];
	double DNNT[MMAX];

	double f = 1. / (fuzzifier - 1.);
	double diff, temp, sum = 0.;

	for (i = 0, j = idx*D; i < D; ++i, ++j) X[i] = points[j];

	for (i = 0; i < M; ++i) DNNT[i] = DBL_MAX;

	for (i = 0; i < K; ++i, pCentroids += D){
		diff = 0.;

		for (j = 0; j < D; ++j){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}
		idx = 0;

		for (; idx < M; ++idx){
			if (DNNT[idx] > diff) break;
		}

		for (j = M-1; j > idx; --j){
			DNNT[j] = DNNT[j-1];
			pNNT[j] = pNNT[j-1];
		}

		if (idx < M){
			DNNT[idx] = diff;
			pNNT[idx] = i;
		}
	}
	for (i = 0; i < K; ++i) pMemberships[i] = 0.;

	for (i = 0; i < M; ++i){
		diff = DNNT[i];

		if (diff == 0.){ 
			pMemberships[pNNT[i]] = 1.;
			return;
		}
		diff = pow(diff, f);
		pMemberships[pNNT[i]] = diff;
		sum = sum + 1. / diff;
	}

	for (i = 0; i < M; ++i){
		pMemberships[pNNT[i]] = pow(pMemberships[pNNT[i]]*sum, -fuzzifier);
	}
}

__global__ void reduce_memberships_kernel(double * memberships, double * odata, int N)
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

	//if (blockDim.x > 511){
	//	if (tid < 256)
	//		sdata[tid] = sdata[tid] + sdata[tid+256];
	//	__syncthreads();
	//}

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

	if (tid == 0) odata[blockIdx.x] = sdata[0] + sdata[1];
}

__global__ void reduce_centroids_kernel
	(double * points, double * memberships, double * odata, int N)
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

	if (tid == 0) odata[blockIdx.x] = sdata[0] + sdata[1];
}

__global__ void calculate_new_centroids(double * centroids, double * memberships)
{
	int cid = blockIdx.x*blockDim.x + threadIdx.x;
	centroids[cid] = centroids[cid] / memberships[blockIdx.x];
}

__host__ void calculate_new_centroids(
	double * points, double * memberships, double * newCentroids, 
	int * NNT, int N, int D, int K, int M)
{
	int i, j, k, idx;
	int * pNNT = NNT;
	double * pMemberships = memberships;
	double * pPoints = points;
	double * pCentroids;
	double * sum = new double[K]();
	memset(newCentroids, 0, K*D*sizeof(double));

	for (i = 0; i < N; ++i, pMemberships += K, pNNT += M, pPoints += D){
		for (j = 0; j < M; ++j){
			idx = pNNT[j];
			sum[idx] = sum[idx] + pMemberships[idx];
			pCentroids = newCentroids + idx*D;

			for (k=0; k<D; ++k)
				pCentroids[k] = pCentroids[k] + pMemberships[idx]*pPoints[k];
		}
	}
	pCentroids = newCentroids;

	for (i = 0; i < K; ++i, pCentroids += D)
		for (j = 0; j < D; ++j)
			pCentroids[j] = pCentroids[j] / sum[i];
}

__global__ void check_convergence(double * centroids, double * newCentroids, int * flag, double epsilon)
{
	flag[0] = 0;

	for (int i = 0; i < blockDim.x; ++i){
		if (fabs(centroids[i] - newCentroids[i]) >= epsilon) return;
	}
	flag[0] = 1;
}

__host__ double * FKM_GPU(FILE * f, GFKM & G, int block_size, int stop_iter, int mode)
{
#pragma region Declare common variables
	int i, j, k, x, y, z, w;
	int DBL_SIZE = sizeof(double);
	
	int sizeC = G.K * G.D;
	int points_size = G.N * G.D * DBL_SIZE;
	int c_size = G.K * DBL_SIZE;
	int centroids_size = c_size * G.D;
	int uk_size = G.N * c_size;
	int NNT_size = G.N * G.M * DBL_SIZE;
	int sm_size = block_size * DBL_SIZE;
	int block_dsize = block_size<<2;
	int num_blocks = roundup(G.N, block_size);
	int num_cblocks = roundup(G.N, block_dsize);
	int u_size = num_cblocks * c_size;
	int tempC_size = num_cblocks * centroids_size;
	double t1 = 0.0, t2 = 0.0, t3 = 0.0, t4;
	
	TimingCPU tmr_CPU;
	TimingGPU tmr_GPU;

	double alpha, beta;
	double * p1;
	double * p2;
	double * p3;
#pragma endregion

#pragma region Declare device memories
	double * d_points;
	double * d_pointsT;
	double * d_centroids;
	double * d_memberships;
	double * d_membershipsT;
	double * d_u;
	double * d_sumU;
	double * d_tempC;
	int * d_stop;
	int * d_NNT;
#pragma endregion

#pragma region Declare host pinned memories
	double * p_points;
	double * p_centroids;
	double * p_memberships;
	double * p_u;
	double * p_sumU;
	double * p_tempC;
	int * p_stop;
	int * p_NNT;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_points, points_size));
	CudaSafeCall(cudaMalloc(&d_pointsT, points_size));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size));
	CudaSafeCall(cudaMalloc(&d_memberships, uk_size));
	CudaSafeCall(cudaMalloc(&d_membershipsT, uk_size));
	CudaSafeCall(cudaMalloc(&d_u, u_size));
	CudaSafeCall(cudaMalloc(&d_sumU, c_size));
	CudaSafeCall(cudaMalloc(&d_tempC, tempC_size));
	CudaSafeCall(cudaMalloc(&d_stop, sizeof(int)));
	CudaSafeCall(cudaMalloc(&d_NNT, NNT_size));
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_points, points_size));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size));
	CudaSafeCall(cudaMallocHost(&p_memberships, uk_size));
	CudaSafeCall(cudaMallocHost(&p_u, u_size));
	CudaSafeCall(cudaMallocHost(&p_sumU, c_size));
	CudaSafeCall(cudaMallocHost(&p_tempC, tempC_size));
	CudaSafeCall(cudaMallocHost(&p_stop, sizeof(int)));
	CudaSafeCall(cudaMallocHost(&p_NNT, NNT_size));
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

	if (mode == 1){
		for (i = 0; i < NSTREAM; ++i)
			cudaStreamCreate(&streams[i]);

		CublasSafeCall(cublasCreate(&handle));
		alpha = 1.;
		beta  = 0.;
		tmr_GPU.StartCounter();
		CublasSafeCall(cublasDgeam(handle, CUBLAS_OP_T, CUBLAS_OP_T, G.N, G.D,
			&alpha, d_points, G.D, &beta, d_points, G.D, d_pointsT, G.N)); 
		t2 = t2 + tmr_GPU.GetCounter();
	}
#pragma endregion

#pragma region Main loop
	for (i = 0; i< G.max_iter; ++i){
#pragma region  Update memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel<<<num_blocks, block_size>>>
			(d_points, d_centroids,d_memberships, d_NNT, G.N, G.D, G.K, G.M, G.fuzzifier);
		//CudaCheckError();
		t1 = t1 + tmr_GPU.GetCounter();
#pragma endregion
		
		if (mode == 1){
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
			for (j = 0, x = 0, y = 0, z = 0; j < G.K; ++j, x += G.N, y += num_cblocks){
				reduce_memberships_kernel<<<num_cblocks, block_size, sm_size, streams[0]>>>
					(d_membershipsT + x, d_u + y, G.N);

				for (k = 0, w = 0; k < G.D; ++k, w += G.N, z += num_cblocks){
					reduce_centroids_kernel<<<num_cblocks, block_size, sm_size, streams[k % (NSTREAM-1)+1]>>>
							(d_pointsT + w, d_membershipsT + x, d_tempC + z, G.N);
				}
			}
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion

#pragma region Reduce block sums by CPU
			if (num_cblocks > 1){
				tmr_GPU.StartCounter();
				CudaSafeCall(cudaMemcpyAsync(p_u, d_u, u_size, cudaMemcpyDeviceToHost));
				CudaSafeCall(cudaMemcpyAsync(p_tempC, d_tempC, tempC_size, cudaMemcpyDeviceToHost));
				t2 = t2 + tmr_GPU.GetCounter();
				tmr_CPU.start();

				for (j = 0, p1 = p_u, p2 = p_tempC, p3 = p_centroids; j < G.K; ++j, p1 += num_cblocks, p3 += G.D){
					p_sumU[j] = 0.0;

					for (x = 0; x < num_cblocks; ++x)
						p_sumU[j] = p_sumU[j] + p1[x];

					for (x = 0; x < G.D; ++x, p2 += num_cblocks){
						p3[x] = 0.0;

						for (y = 0; y < num_cblocks; ++y){
							p3[x] = p3[x] + p2[y];
						}
					}
				}
				tmr_CPU.stop();
				t2 = t2 + tmr_CPU.elapsed();
				tmr_GPU.StartCounter();
				CudaSafeCall(cudaMemcpyAsync(d_u, p_sumU, c_size, cudaMemcpyHostToDevice));
				CudaSafeCall(cudaMemcpyAsync(d_tempC, p_centroids, centroids_size, cudaMemcpyHostToDevice));
				t2 = t2 + tmr_GPU.GetCounter();
			}
#pragma endregion

#pragma region Calculate centroids by GPU
			tmr_GPU.StartCounter();
			calculate_new_centroids<<<G.K, G.D>>>(d_tempC, d_u);
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
		else{
#pragma region Calculate centroids by CPU
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(p_NNT, d_NNT, NNT_size, cudaMemcpyDeviceToHost));
			CudaSafeCall(cudaMemcpyAsync(p_memberships, d_memberships, uk_size, cudaMemcpyDeviceToHost));
			t2 = t2 + tmr_GPU.GetCounter();
			tmr_CPU.start();
			calculate_new_centroids(p_points, p_memberships, p_centroids, p_NNT, G.N, G.D, G.K, G.M);
			tmr_CPU.stop();
			t2 = t2 + tmr_CPU.elapsed();
			tmr_GPU.StartCounter();
			CudaSafeCall(cudaMemcpyAsync(d_tempC, p_centroids, centroids_size, cudaMemcpyHostToDevice));
			t2 = t2 + tmr_GPU.GetCounter();
#pragma endregion
		}
#pragma region Getting and checking stop-condition
		tmr_GPU.StartCounter();
		check_convergence<<<1, sizeC>>>(d_centroids, d_tempC, d_stop, G.epsilon);
		CudaSafeCall(cudaMemcpyAsync(p_stop, d_stop, sizeof(int), cudaMemcpyDeviceToHost));
		t3 = t3 + tmr_GPU.GetCounter();
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, d_tempC, centroids_size, cudaMemcpyDeviceToDevice));
		t2 = t2 + tmr_GPU.GetCounter();

		if ((p_stop[0] == 1 && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
#pragma endregion
	}
	if (i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
	tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_centroids, d_centroids, centroids_size, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_NNT, d_NNT, NNT_size, cudaMemcpyDeviceToHost));
	t4 = tmr_GPU.GetCounter();
#pragma endregion

#pragma region Writing results to files
	Util::write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	Util::write<int>(p_NNT, G.N, G.M, G.path + "NNT.GPU.txt");
	Util::print_times(f, t1, t2, t3, i+1);
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_points);
	cudaFree(d_pointsT);
	cudaFree(d_centroids);
	cudaFree(d_memberships);
	cudaFree(d_membershipsT);
	cudaFree(d_u);
	cudaFree(d_sumU);
	cudaFree(d_tempC);
	cudaFree(d_stop);
	cudaFree(d_NNT);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_memberships);
	cudaFreeHost(p_u);
	cudaFreeHost(p_sumU);
	cudaFreeHost(p_tempC);
	cudaFreeHost(p_stop);
	cudaFreeHost(p_NNT);
#pragma endregion

#pragma region Get total time and last iteration index
	double * rs = new double[2];
	rs[0] = t1 + t2 + t3 + t4;
	rs[1] = (double)i;
#pragma endregion

#pragma region CublasDestroy, CudaStreamDestroy, and DeviceReset
	if (mode == 1)
	{
		CublasSafeCall(cublasDestroy(handle));

		for (i = 0; i < NSTREAM; ++i)
			cudaStreamDestroy(streams[i]);
	}
	
	cudaDeviceReset();
#pragma endregion
	
	return rs;
}