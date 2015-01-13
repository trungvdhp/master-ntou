#include "GFKM.cuh"
#define DIM_MAX 36
#define PRN 9
#define BLOCK_MAX 1024

__global__ void initialize_NNT_kernel
	(double* points, double* centroids, int* NNT, double* DNNT,
	 int N, int D, int K, int M)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if(idx >= N) return;
	int i, j;
	i = idx*M;
	int* pNNT = NNT + i;
	double* pDNNT = DNNT + i;
	double* pCentroids = centroids;
	
	double X[DIM_MAX];
	double diff, temp;
	
	j= idx*D;
	for(i=0; i<D; i++) X[i] = points[j++];

	for(i=0; i<M; i++) pDNNT[i] = DBL_MAX;

	for(i=0; i<K; i++,pCentroids+=D){
		diff = 0.0;

		for(j=0; j<D; j++){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}
		idx = 0;

		for(; idx < M; idx++)
			if(pDNNT[idx] > diff) break;

		for(j=M-1; j>idx; j--){
			pDNNT[j] = pDNNT[j-1];
			pNNT[j] = pNNT[j-1];
		}

		if(idx < M){
			pDNNT[idx] = diff;
			pNNT[idx] = i;
		}
	}
}

__global__ void update_memberships_kernel
	(int* NNT, double* DNNT, double* U_ALG, double* tempU, 
	 int N, int K, int M, double fuzzifier)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if(idx >= N) return;
	int i;
	i = idx*M;
	int* pNNT = NNT + i;
	double* pDNNT = DNNT + i;
	i = idx*K;
	double* pU = U_ALG + i;
	double* pTempU = tempU + i;
	double f = 1.0 / (fuzzifier-1.0);
	double diff, sum = 0.0;

	for(i=0; i<K; i++){
		pU[i] = 0.0;
		pTempU[i] = 0.0;
	}

	for(i=0; i<M; i++){
		idx = pNNT[i];
		diff = pDNNT[i];

		if(diff == 0.0){ 
			pU[idx] = 1.0;
			pTempU[idx] = 1.0;
			return;
		}
		diff = pow(diff, f);
		pU[idx] = diff;
		sum = sum + 1.0 / diff;
	}

	for(i=0; i<M; i++){
		idx = pNNT[i];
		diff =  1.0 / (pU[idx]*sum);
		pU[idx] = diff;
		pTempU[idx] = pow(diff, fuzzifier);
	}
}

__host__ void update_centroids
	(double* points, double* centroids, int* NNT, double* tempU,
	 int N, int D, int K, int M)
{
	int i, j, k, idx;
	int* pNNT = NNT;
	double* pTempU = tempU;
	double* pPoints = points;
	double* pCentroids;
	double* sum = new double[K]();
	memset(centroids, 0, K*D*sizeof(double));

	for(i=0; i<N; i++,pTempU+=K,pNNT+=M,pPoints+=D){
		for(j=0; j<M; j++){
			idx = pNNT[j];
			sum[idx] = sum[idx] + pTempU[idx];
			pCentroids = centroids + idx*D;

			for(k=0; k<D; k++)
				pCentroids[k] = pCentroids[k] + pTempU[idx]*pPoints[k];
		}
	}
	pCentroids = centroids;

	for(i=0; i<K; i++,pCentroids+=D)
		for(j=0; j<D; j++)
			pCentroids[j] = pCentroids[j] / sum[i];
}

__global__ void histogram_kernel(int* NNT, int* histo, int size)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;

	if(i < size)
		atomicAdd(&(histo[NNT[i]+1]), 1);
}

__global__ void scan_kernel(int* histo, int K)
{
	for(int i=1; i<K; i++)
		histo[i] += histo[i-1];
}

__global__ void counting_sort_kernel(int* NNT, int* histo, int* odata, int size, int M)
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;

	if(i < size){
		int idx = atomicAdd(&(histo[NNT[i]]), 1);
		odata[idx] = i/M;
	}
}

__global__ void reduce_memberships_kernel
	(int* NNT, double* tempU, double* odata, int N, int K, int cid)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*blockDim.x + tid;
	int gridSize = blockDim.x*gridDim.x;
	double temp = 0.0;

	while(i < N){
		temp = temp + tempU[NNT[i]*K+cid];
		i += gridSize;
	}
	sdata[tid] = temp;
	__syncthreads();

	//if(blockDim.x > 255){
		if(tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	//}

	//if(blockDim.x > 127){
		if(tid < 64)
			sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	//}

	if(tid < 32) sdata[tid] = sdata[tid] + sdata[tid + 32];
	if(tid < 16) sdata[tid] = sdata[tid] + sdata[tid + 16];
	if(tid < 8) sdata[tid] = sdata[tid] + sdata[tid + 8];
	if(tid < 4) sdata[tid] = sdata[tid] + sdata[tid + 4];
	if(tid < 2) sdata[tid] = sdata[tid] + sdata[tid + 2];

	if(tid == 0) odata[blockIdx.x] = sdata[0] + sdata[1];
}

__global__ void reduce_centroids_kernel
	(double* points, int* NNT, double* tempU, double* odata,
	 int N, int D, int K, int pid, int cid)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*blockDim.x + tid;
	int gridSize = blockDim.x*gridDim.x;
	int t;
	double temp = 0.0;
	
	while(i < N){
		t = NNT[i];
		temp = temp + points[t*D + pid]*tempU[t*K+cid];
		i += gridSize;
	}
	sdata[tid] = temp;
	__syncthreads();

	//if(blockDim.x > 255){
		if(tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	//}

	//if(blockDim.x > 127){
		if(tid < 64) sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	//}

	if(tid < 32) sdata[tid] = sdata[tid] + sdata[tid + 32];
	if(tid < 16) sdata[tid] = sdata[tid] + sdata[tid + 16];
	if(tid < 8) sdata[tid] = sdata[tid] + sdata[tid + 8];
	if(tid < 4) sdata[tid] = sdata[tid] + sdata[tid + 4];
	if(tid < 2) sdata[tid] = sdata[tid] + sdata[tid + 2];

	if(tid == 0) odata[blockIdx.x] = sdata[0] + sdata[1];
}

__global__ void reduce_centroids_kernel
	(double* centroids, double* memberships, double* tempC, int* histo,  int D, int K)
{
	int tid = threadIdx.x;

	if(tid >= K) return;
	double* C = centroids + tid*D;
	int size = histo[tid];
	double a = 0.0;

	if(tid>0) tid = histo[tid-1];
	int i;
	double* tempU = memberships + tid;
	double* temp = tempC + tid*D;
	size -= tid;
	
	for(i=0; i<size; i++)
		a = a + tempU[i];

	for(i=0; i<D; i++,temp+=size){
		C[i] = 0.0;

		for(tid=0; tid<size; tid++)
			C[i] = C[i] + temp[tid];
		C[i] = C[i]/a;
	}
}

inline __host__ void reduce_centroids
	(double* centroids, double* u, double* tempC, int* histo, int D, int K)
{
	int i, j, t, x=0, y=0, cid=0;
	double a;

	for(i=0; i<K; i++){
		a = 0.0;

		for(j=0; j<histo[i]; j++,x++)
			a = a + u[x];

		for(j=0; j<D; j++,cid++){
			centroids[cid] = 0.0;

			for(t=0; t<histo[i]; t++,y++)
				centroids[cid] = centroids[cid] + tempC[y];
			centroids[cid] = centroids[cid]/a;
		}
	}
}

__global__ void update_NNT_kernel
	(double* points, double* centroids, int* NNT, double* DNNT, double* tempU, double* D_ALG,
	 int N, int D, int K, int M)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if(idx >= N) return;
	int i, j;
	i = idx*M;
	int* pNNT = NNT + i;
	double* pDNNT = DNNT + i;
	i = idx*K;
	double* pTempU = tempU + i;
	double* pD_ALG = D_ALG + i;
	double* pCentroids = centroids;
	
	double X[DIM_MAX];
	double diff, temp;
	
	j= idx*D;
	for(i=0; i<D; i++) X[i] = points[j++];

	for(i=0; i<M; i++) pDNNT[i] = DBL_MAX;

	for(i=0; i<K; i++,pCentroids+=D){
		diff = 0.0;

		for(j=0; j<D; j++){
			temp = X[j] - pCentroids[j];
			diff = diff + temp*temp;
		}
		pD_ALG[i] = pTempU[i]*diff;
		idx = 0;

		for(; idx < M; idx++)
			if(pDNNT[idx] > diff) break;

		for(j=M-1; j>idx; j--){
			pDNNT[j] = pDNNT[j-1];
			pNNT[j] = pNNT[j-1];
		}

		if(idx < M){
			pDNNT[idx] = diff;
			pNNT[idx] = i;
		}
	}
}

__host__ double reduce_J(double* D_ALG, int N, int K)
{
	int i, NK = N*K;;
	double JK = 0.0;
	
	for(i=0; i<NK; i++)
		JK = JK + D_ALG[i];
	return JK;
}

__global__ void reduce_J_kernel(double* idata, double* odata, int n)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*blockDim.x + tid;
	int gridSize = blockDim.x*gridDim.x;
	double temp = 0.0;

	while(i < n){
		temp = temp + idata[i];
		i += gridSize;
	}
	sdata[tid] = temp;
	__syncthreads();

	//if(blockDim.x > 511){
	//	if(tid < 256)
	//		sdata[tid] = sdata[tid] + sdata[tid+256];
	//	__syncthreads();
	//}

	if(blockDim.x > 255){
		if(tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	}

	if(blockDim.x > 127){
		if(tid < 64) sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	}

	if(tid < 32) sdata[tid] = sdata[tid] + sdata[tid + 32];
	if(tid < 16) sdata[tid] = sdata[tid] + sdata[tid + 16];
	if(tid < 8) sdata[tid] = sdata[tid] + sdata[tid + 8];
	if(tid < 4) sdata[tid] = sdata[tid] + sdata[tid + 4];
	if(tid < 2) sdata[tid] = sdata[tid] + sdata[tid + 2];

	if(tid == 0) odata[blockIdx.x] = sdata[0] + sdata[1];
}

inline __host__ int roundup(int x, int y)
{
	return 1 + (x-1)/y;
}

__host__ double* GFKM_GPU(GFKM G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i, j, x, y, z, q;
	int DBL_SIZE = sizeof(double);
	int INT_SIZE = sizeof(int);
	
	int points_size = G.N*G.D;
	int centroids_size = G.K*G.D;
	int centroids_dbl_size = centroids_size*DBL_SIZE;
	int um_size = G.N*G.M;
	int uk_size = G.N*G.K;
	int sm_size = block_size*DBL_SIZE;
	int block_dsize = block_size<<2;
	int histo_size = (G.K+1)*INT_SIZE;

	int num_blocks = roundup(G.N, block_size);
	int num_Jblocks1 = roundup(uk_size, block_dsize);
	int num_Jblocks2 =  roundup(num_Jblocks1,block_dsize);
	int num_cblocks = roundup(um_size, block_dsize) + G.K;
	int num_hblocks = roundup(um_size, block_size);

	int Jblock1_size = num_Jblocks1 * DBL_SIZE;
	int Jblock2_size = num_Jblocks2 * DBL_SIZE;

	double a, newJ;
	double t, tt;
	double total_time = 0.0;
	
	TimingGPU tmr_GPU;
	TimingCPU tmr_CPU;
#pragma endregion

#pragma region Declare device memories
	double* d_points;
	double* d_centroids;
	double* d_DNNT;
	int* d_NNT;
	int* d_histo;
	int* d_sp;
	double* d_DALG;
	double* d_u;
	double* d_tempU;
	double* d_JB;
	double* d_J;
	double* d_tempC;
	double* d_m;
#pragma endregion

#pragma region Declare host pinned memories
	double* p_points;
	double* p_centroids;
	double* p_DNNT;
	int* p_NNT;
	int* p_histo;
	double* p_DALG;
	double* p_u;
	double* p_tempU;
	double* p_J;
	double* p_tempC;
	double* p_m;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_points, points_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_DNNT, um_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_NNT, um_size*INT_SIZE));
	CudaSafeCall(cudaMalloc(&d_sp, um_size*INT_SIZE));
	CudaSafeCall(cudaMalloc(&d_histo, (G.K+1)*INT_SIZE));
	CudaSafeCall(cudaMalloc(&d_DALG, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_u, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_tempU, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_JB, num_Jblocks1*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_J, num_Jblocks2*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_tempC, num_cblocks*centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_m, num_cblocks*DBL_SIZE));
	//thrust::device_ptr<double> cptr = thrust::device_pointer_cast(d_DALG);
	//thrust::device_ptr<int> cptr = thrust::device_pointer_cast(d_histo);
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_points, points_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_DNNT, um_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_NNT, um_size*INT_SIZE));
	CudaSafeCall(cudaMallocHost(&p_histo, (G.K+1)*INT_SIZE));
	CudaSafeCall(cudaMallocHost(&p_DALG, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_u, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_tempU, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_tempC, num_cblocks*centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_m, num_cblocks*DBL_SIZE));

	if(num_Jblocks1 < BLOCK_MAX)
		CudaSafeCall(cudaMallocHost(&p_J, num_Jblocks1*DBL_SIZE));
	else
		CudaSafeCall(cudaMallocHost(&p_J, num_Jblocks2*DBL_SIZE));
#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size*DBL_SIZE);
	memcpy(p_centroids, G.centroids, centroids_size*DBL_SIZE);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size*DBL_SIZE, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size*DBL_SIZE, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Cuda stream create
	cudaStream_t *streams = new cudaStream_t[G.D+1];
	for(i = 0; i<=G.D; i++)
		cudaStreamCreate(&streams[i]);  
#pragma endregion

#pragma region Initializing NNT by GPU
	tmr_GPU.StartCounter();
	initialize_NNT_kernel<<<num_blocks, block_size>>>
		(d_points, d_centroids, d_NNT, d_DNNT, G.N, G.D, G.K, G.M);
	//CudaCheckError();
	t = tmr_GPU.GetCounter();
	total_time = total_time + t;
	cout << std::fixed << std::setprecision(PRN);
	std::cout << " Initializing NNT by GPU: " << t << endl;  
#pragma endregion

#pragma region Main loop
	for(i=0; i<G.max_iter; i++){
		std::cout << "-------------------------------------------------------" << endl;
		std::cout << "Iteration #" << i+1 << endl;
		std::cout << "-------------------------------------------------------" << endl;

#pragma region  Updating memberships by GPU
		tmr_GPU.StartCounter();
		update_memberships_kernel<<<num_blocks, block_size>>>
			(d_NNT, d_DNNT, d_u, d_tempU, G.N, G.K, G.M, G.fuzzifier);
		//CudaCheckError();
		t = tmr_GPU.GetCounter();
		total_time = total_time + t;
		std::cout << " Updating memberships by GPU: " << t << endl;  
#pragma endregion

#pragma region Updating centroids
		std::cout << " Updating centroids:"<< endl;
		tt = 0.0;
#pragma region Counting sort by GPU
		tmr_GPU.StartCounter();
		cudaMemset(d_histo, 0, histo_size);
		// Calculate the histogram of cluster index frequencies from NNT
		histogram_kernel<<<num_hblocks, block_size>>>(d_NNT, d_histo, um_size);
		CudaSafeCall(cudaMemcpyAsync(p_histo, d_histo, histo_size, cudaMemcpyDeviceToHost));
		// Calculate the starting index for each cluster
		scan_kernel<<<1, 1>>>(d_histo, G.K);
		// Copy corresponding point indices to output array, 
		// preserving order of inputs (array NNT) with equal cluster indices
		counting_sort_kernel<<<num_hblocks, block_size>>>(d_NNT, d_histo, d_sp, um_size, G.M);
		t = tmr_GPU.GetCounter();
		tt = tt + t;
		std::cout << "  + Counting sort by GPU: " << t << endl;
#pragma endregion

#pragma region Reducing centroids by GPU
		y = 0; z = 0; q = 0;
		tmr_GPU.StartCounter();
		for(j=0; j<G.K; j++){
			p_histo[j] = roundup(p_histo[j+1], block_dsize);
			reduce_memberships_kernel<<<p_histo[j], block_size, sm_size, streams[0]>>>
				(d_sp+q, d_tempU, d_m+y, p_histo[j+1], G.K, j);

			for(x=0; x<G.D; x++){
				reduce_centroids_kernel<<<p_histo[j], block_size, sm_size, streams[x+1]>>>
					(d_points, d_sp+q, d_tempU, d_tempC+z, p_histo[j+1], G.D, G.K, x, j);
				z += p_histo[j];
			}
			y += p_histo[j];
			//p_histo[j] = y;
			q += p_histo[j+1];
		}
		CudaSafeCall(cudaMemcpyAsync(p_m, d_m, y*DBL_SIZE, cudaMemcpyDeviceToHost));
		CudaSafeCall(cudaMemcpyAsync(p_tempC, d_tempC, z*DBL_SIZE, cudaMemcpyDeviceToHost));
		t = tmr_GPU.GetCounter();
		tt = tt + t;
		std::cout << "  + Reducing centroids by GPU: " << t << endl;
#pragma endregion

#pragma region Reducing centroids by CPU
		tmr_CPU.start();
		reduce_centroids(p_centroids, p_m, p_tempC, p_histo, G.D, G.K);
		tmr_CPU.stop();
		t = tmr_CPU.elapsed();
		tt = tt + t;
		std::cout << "  + Reducing centroids by CPU: " << t << endl;
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, p_centroids, centroids_dbl_size, cudaMemcpyHostToDevice));
		t = tmr_GPU.GetCounter();
		tt = tt + t;
		total_time = total_time + tt;
		std::cout << "  + Host to device: " << t << endl;
		std::cout << " Total updating centroids time: " << tt << endl;
#pragma endregion

#pragma endregion

#pragma region Updating NNT by GPU
		tmr_GPU.StartCounter();
		update_NNT_kernel<<<num_blocks, block_size>>>
			(d_points, d_centroids, d_NNT, d_DNNT, d_tempU, d_DALG, G.N, G.D, G.K, G.M);
		//CudaCheckError();
		t = tmr_GPU.GetCounter();
		total_time = total_time + t;
		std::cout << " Updating NNT by GPU: " << t << endl;  
#pragma endregion

#pragma region Calculating distortion value J
		std::cout << " Calculating distortion value J:" << endl;
#pragma region Calculating J by CPU
		/*tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_DALG, d_DALG, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
		t = tmr_GPU.GetCounter();
		tmr_CPU.start();
		newJ = reduce_J(p_DALG, G.N, G.K);*/  
#pragma endregion

#pragma region Calculating J by GPU reduction
		tt = 0.0;
		// Reduction J #1
		tmr_GPU.StartCounter();
		reduce_J_kernel<<<num_Jblocks1, block_size, sm_size>>>(d_DALG, d_JB, uk_size);
		//CudaCheckError();

		if(num_Jblocks1 < BLOCK_MAX){
			CudaSafeCall(cudaMemcpyAsync(p_J, d_JB, Jblock1_size, cudaMemcpyDeviceToHost));
			t = tmr_GPU.GetCounter();
			tt = tt + t;
			std::cout << "  + Reducing J by GPU: " << t << endl;
			// Reduction J blocksums by CPU
			tmr_CPU.start();
			newJ = 0.0;

			for(j=0; j<num_Jblocks1; j++)
				newJ = newJ + p_J[j];
		}  
		else{
			// Reduction J #2
			reduce_J_kernel<<<num_Jblocks2, block_size,  sm_size>>>(d_JB, d_J, num_Jblocks1);
			//CudaCheckError();
			CudaSafeCall(cudaMemcpyAsync(p_J, d_J, Jblock2_size, cudaMemcpyDeviceToHost));
			t = tmr_GPU.GetCounter();
			tt = tt + t;
			std::cout << "  + Reducing J by GPU: " << t << endl;
			// Reduction J blocksums by CPU
			tmr_CPU.start();
			newJ = 0.0;

			for(j=0; j<num_Jblocks2; j++)
				newJ = newJ + p_J[j];
		}
#pragma endregion
#pragma endregion

#pragma region Getting and checking stop-condition
		tmr_CPU.stop();
		t = tmr_CPU.elapsed();
		if(t < 0) t = 0;
		tt = tt + t;
		std::cout << "  + Reducing J by CPU : " << t << endl;
		total_time = total_time + tt;
		std::cout << " Total calculating J time: " << tt << endl;
		a = fabs(newJ - G.J);
		std::cout << " Difference: " << a << endl;

		if((a < G.epsilon && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
		G.J = newJ;
#pragma endregion
	}
	if(i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
	tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_NNT, d_NNT, um_size*INT_SIZE, cudaMemcpyDeviceToHost));
	//CudaSafeCall(cudaMemcpyAsync(p_DNNT, d_DNNT, um_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	//CudaSafeCall(cudaMemcpyAsync(p_u, d_u, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	//CudaSafeCall(cudaMemcpyAsync(p_tempU, d_tempU, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	t = tmr_GPU.GetCounter();
	total_time = total_time + t;
	std::cout << " Device to host: " << t << endl;
#pragma endregion

#pragma region Writing results to files
	G.write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	G.write<int>(p_NNT, G.N, G.M, G.path + "NNT.GPU.txt");
	//G.write<double>(p_DNNT, G.N, G.M, G.path + "DNNT.GPU.txt");
	//G.write<double>(p_u, G.N, G.K, G.path + "u.GPU.txt");
	//G.write<double>(p_tempU, G.N, G.K, G.path + "tempU.GPU.txt");  
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_points);
	cudaFree(d_centroids);
	cudaFree(d_tempC);
	cudaFree(d_NNT);
	cudaFree(d_m);
	cudaFree(d_histo);
	cudaFree(d_DNNT);
	cudaFree(d_DALG);
	cudaFree(d_u);
	cudaFree(d_tempU);
	cudaFree(d_J);
	cudaFree(d_JB);
	cudaFree(d_sp);
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_tempC);
	cudaFreeHost(p_NNT);
	cudaFreeHost(p_histo);
	cudaFreeHost(p_DNNT);
	cudaFreeHost(p_DALG);
	cudaFreeHost(p_u);
	cudaFreeHost(p_m);
	cudaFreeHost(p_tempU);
	cudaFreeHost(p_J);
#pragma endregion

#pragma region Get total time and last iteration index
	double *rs = new double[2];
	rs[0] = total_time;
	rs[1] = (double)i;
#pragma endregion

#pragma region CudaStreamDestroy and DeviceReset
	for(i = 0; i<=G.D; i++)
		cudaStreamDestroy(streams[i]);
	cudaDeviceReset();
#pragma endregion
	return rs;  
}