#include "GFKM.cuh"
#define DIM_MAX 64
#define K_MAX 32
#define M_MAX 2
#define PRN 9

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

__global__ void update_memberships_kernel
	(double* points, int* NNT, double* DNNT, double* U_ALG, double* tempU, double* tempC,
	 int N, int D, int K, int M, double fuzzifier)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;

	if(idx >= N) return;
	int i, j;
	i = idx*M;
	int* pNNT = NNT + i;
	double* pDNNT = DNNT + i;
	i = idx*K;
	double* pU = U_ALG + i;
	double* pTempU = tempU + i;
	i *= D;
	double* pTempC = tempC + i;
	double f = 1.0 / (fuzzifier-1.0);
	double diff, sum = 0.0;
	double X[DIM_MAX];

	idx *= D;
	for(i=0; i<D; i++) X[i] = points[idx++];

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

	for(i=0; i<M; i++, tempC+=D){
		idx = pNNT[i];
		diff =  1.0 / (pU[idx]*sum);
		pU[idx] = diff;
		pTempU[idx] = pow(diff, fuzzifier);
		diff = pTempU[idx];

		for(j=0; j<D; j++)
			pTempC[j] = X[j]*diff;
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
	int i = blockIdx.x*(blockDim.x*2) + tid;
	int gridSize = blockDim.x*2*gridDim.x;
	sdata[tid] = 0;

	while(i < n){
		sdata[tid] = sdata[tid] + idata[i];

		if(i+blockDim.x < n) 
			sdata[tid] = sdata[tid] + idata[i+blockDim.x];
		i += gridSize;
	}
	__syncthreads();

	if(blockDim.x > 511){
		if(tid < 256)
			sdata[tid] = sdata[tid] + sdata[tid+256];
		__syncthreads();
	}

	if(blockDim.x > 255){
		if(tid < 128) sdata[tid] = sdata[tid] + sdata[tid+128];
		__syncthreads();
	}

	if(blockDim.x > 127){
		if(tid < 64)
			sdata[tid] = sdata[tid] + sdata[tid+64];
		__syncthreads();
	}

	if(tid < 32){
		if(blockDim.x > 63) sdata[tid] = sdata[tid] + sdata[tid + 32];
		if(blockDim.x > 31) sdata[tid] = sdata[tid] + sdata[tid + 16];
		if(blockDim.x > 15) sdata[tid] = sdata[tid] + sdata[tid + 8];
		if(blockDim.x > 7) sdata[tid] = sdata[tid] + sdata[tid + 4];
		if(blockDim.x > 3) sdata[tid] = sdata[tid] + sdata[tid + 2];
		if(blockDim.x > 1) sdata[tid] = sdata[tid] + sdata[tid + 1];
	}

	if(tid == 0) odata[blockIdx.x] = sdata[0];
}

__global__ void reduce_centroids_kernel
	(double* points, int* NNT, double* tempU, double* odata,
	 int N, int D, int K, int M)
{
	extern __shared__ double sdata[];

	int tid = threadIdx.x;
	int i = blockIdx.x*(blockDim.x*2) + tid;
	int gridSize = blockDim.x*2*gridDim.x;
	int csize = K*D;
	int usize = N*M;
	int id = tid*csize;
	int j, t;
	int cid, pid;
	double u;

	for(j=0; j<csize; j++)
		sdata[id+j] = 0.0;

	while(i < usize){
		cid = NNT[i];
		t = i/M;
		u = tempU[t*K+cid];
		cid = id + cid*D;
		pid = t*D;

		for(j=0; j<D; j++)
			sdata[cid++] += points[pid++]*u;
		t = i+blockDim.x;

		if(t < usize){
			cid = NNT[t];
			t /= M;
			u = tempU[t*K+cid];
			cid = id + cid*D;
			pid = t*D;

			for(j=0; j<D; j++)
				sdata[cid++] += points[pid++]*u;
		}
		i += gridSize;
	}
	__syncthreads();

	if(blockDim.x > 511){
		if(tid < 256){
			t = (tid+256)*csize;

			for(j=0; j<csize; j++)
				sdata[id+j] += sdata[t++];
		}
		__syncthreads();
	}

	if(blockDim.x > 255){
		if(tid < 128){
			t = (tid+128)*csize;

			for(j=0; j<csize; j++)
				sdata[id+j] += sdata[t++];
		}
		__syncthreads();
	}

	if(blockDim.x > 127){
		if(tid < 64){
			t = (tid+64)*csize;

			for(j=0; j<csize; j++)
				sdata[id+j] += sdata[t++];
		}
		__syncthreads();
	}

	if(tid < 32 && blockDim.x > 63){
		t = (tid+32)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}

	if(tid < 16 && blockDim.x > 31){
		t = (tid+16)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}

	if(tid < 8 && blockDim.x > 15){
		t = (tid+8)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}

	if(tid < 4 && blockDim.x > 7){
		t = (tid+4)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}
	if(tid < 2 && blockDim.x > 3){
		t = (tid+2)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}

	if(tid < 1 && blockDim.x > 1){
		t = (tid+1)*csize;

		for(j=0; j<csize; j++)
			sdata[id+j] += sdata[t++];
	}

	if(tid == 0){
		t = blockIdx.x*csize;

		for(j=0; j<csize; j++)
			odata[t++] = sdata[j];
	}
}

__host__ void reduce
	(double* data, int num_blocks, int stride)
{
	if(stride==1){
		for(int i=1; i<num_blocks; i++)
				data[0] += data[i];
	}
	else if(stride > 1){
		double * tmp = data+stride;

		for(int i=1; i<num_blocks; i++, tmp+=stride)
			for(int j=0; j<stride; j++)
				data[j] += tmp[j];
	}
}

__host__ double* GFKM_GPU(GFKM G, int block_size, int stop_iter)
{
#pragma region Declare common variables
	int i, j;
	int DBL_SIZE = sizeof(double);
	int INT_SIZE = sizeof(int);
	
	int points_size = G.N*G.D;
	int centroids_size = G.K*G.D;
	int um_size = G.N*G.M;
	int uk_size = G.N*G.K;

	int num_blocks = (int)(ceil((double)(G.N*1.0f/block_size)));
	int nblocks1, nblocks2;
	nblocks1 = (int)(ceil((double)(uk_size*1.0/(block_size*2))));
	nblocks2 =  (int)(ceil((double)(nblocks1*1.0/(block_size*2))));

	int cbsize = 6144/centroids_size;
	int ncblocks = (int)(ceil((double)(um_size*1.0/cbsize)));
	//int smsize = 6144;

	double t;
	double total_time = 0;
	double a, newJ;

	TimingGPU tmr_GPU;
	TimingCPU tmr_CPU;
#pragma endregion

#pragma region Declare device memories
	double* d_points;
	double* d_centroids;
	double* d_DNNT;
	int* d_NNT;
	double* d_DALG;
	double* d_u;
	double* d_tempU;
	double* d_JB;
	double* d_J;
	double* d_tempC;
#pragma endregion

#pragma region Declare host pinned memories
	double* p_points;
	double* p_centroids;
	double* p_DNNT;
	int* p_NNT;
	double* p_DALG;
	double* p_u;
	double* p_tempU;
	double* p_J;
	double* p_tempC;
#pragma endregion

#pragma region Malloc device
	CudaSafeCall(cudaMalloc(&d_points, points_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_centroids, centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_DNNT, um_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_NNT, um_size*INT_SIZE));
	CudaSafeCall(cudaMalloc(&d_DALG, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_u, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_tempU, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_JB, nblocks1*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_J, nblocks2*DBL_SIZE));
	CudaSafeCall(cudaMalloc(&d_tempC, ncblocks*centroids_size*DBL_SIZE));
	//thrust::device_ptr<double> cptr = thrust::device_pointer_cast(d_DALG);
#pragma endregion

#pragma region Malloc host
	CudaSafeCall(cudaMallocHost(&p_points, points_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_centroids, centroids_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_DNNT, um_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_NNT, um_size*INT_SIZE));
	CudaSafeCall(cudaMallocHost(&p_DALG, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_u, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_tempU, uk_size*DBL_SIZE));
	CudaSafeCall(cudaMallocHost(&p_tempC, ncblocks*centroids_size*DBL_SIZE));

	if(nblocks1 < block_size)
		CudaSafeCall(cudaMallocHost(&p_J, nblocks1*DBL_SIZE));
	else
		CudaSafeCall(cudaMallocHost(&p_J, nblocks2*DBL_SIZE));
#pragma endregion

#pragma region Memories copy
	memcpy(p_points, G.points, points_size*DBL_SIZE);
	memcpy(p_centroids, G.centroids, centroids_size*DBL_SIZE);
	CudaSafeCall(cudaMemcpy(d_points, p_points, points_size*DBL_SIZE, cudaMemcpyHostToDevice));
	CudaSafeCall(cudaMemcpy(d_centroids, p_centroids, centroids_size*DBL_SIZE, cudaMemcpyHostToDevice));  
#pragma endregion

#pragma region Initializing NNT by GPU
	tmr_GPU.StartCounter();
	initialize_NNT_kernel<<<num_blocks, block_size>>>
		(d_points, d_centroids, d_NNT, d_DNNT, G.N, G.D, G.K, G.M);
	//CudaCheckError();
	t = tmr_GPU.GetCounter();
	total_time = total_time + t;
	cout << std::fixed << std::setprecision(PRN);
	std::cout << " Initializing NNT by GPU time: " << t << endl;  
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
		std::cout << " Updating memberships by GPU time: " << t << endl;  
#pragma endregion

#pragma region Updating centroids by GPU reduction
		/*tmr_GPU.StartCounter();
		reduce_centroids_kernel<<<ncblocks, cbsize, smsize*DBL_SIZE>>>
			(d_points, d_NNT, d_tempU, d_tempC, G.N, G.D, G.K, G.M);
		CudaSafeCall(cudaMemcpyAsync(p_tempC, d_tempC, 
			ncblocks*centroids_size*DBL_SIZE, cudaMemcpyDeviceToHost));
		t = tmr_GPU.GetCounter();
		total_time = total_time + t;
		std::cout << " Updating centroids by GPU time: " << t << endl;
		tmr_CPU.start();
		reduce(p_tempC, ncblocks, centroids_size);
		tmr_CPU.stop();
		t = tmr_CPU.elapsed();

		if(t > 0){
			total_time = total_time + t;
			std::cout << " Reduce centroids by CPU  time: " << t << endl;
		}*/
#pragma endregion

#pragma region Updating centroids by CPU
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_NNT, d_NNT, um_size*INT_SIZE, cudaMemcpyDeviceToHost));
		CudaSafeCall(cudaMemcpyAsync(p_tempU, d_tempU, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
		t = tmr_GPU.GetCounter();
		std::cout << " Memcpy Device NNT and TempU to Host  time: " << t << endl;
		total_time = total_time + t;
		tmr_CPU.start();
		update_centroids(p_points, p_centroids, p_NNT, p_tempU, G.N, G.D, G.K, G.M);
		tmr_CPU.stop();
		t = tmr_CPU.elapsed();
		std::cout << " Calculating new centroids by CPU time: " << t << endl;
		total_time = total_time + t;  
#pragma endregion

#pragma region Updating NNT by GPU
		tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(d_centroids, p_centroids, centroids_size*DBL_SIZE, cudaMemcpyHostToDevice));
		//CudaSafeCall(cudaMemcpyAsync(d_centroids, p_tempC, centroids_size*DBL_SIZE, cudaMemcpyHostToDevice));
		update_NNT_kernel<<<num_blocks, block_size>>>
			(d_points, d_centroids, d_NNT, d_DNNT, d_tempU, d_DALG, G.N, G.D, G.K, G.M);
		//CudaCheckError();
		t = tmr_GPU.GetCounter();
		total_time = total_time + t;
		std::cout << " Updating NNT by GPU time: " << t << endl;  
#pragma endregion

#pragma region Calculating J by CPU
		/*tmr_GPU.StartCounter();
		CudaSafeCall(cudaMemcpyAsync(p_DALG, d_DALG, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
		t = tmr_GPU.GetCounter();
		tmr_CPU.start();
		newJ = reduce_J(p_DALG, G.N, G.K);*/  
#pragma endregion

#pragma region Calculating J by thrust::reduce
		// 
		/*tmr_CPU.start();
		newJ = thrust::reduce(cptr, cptr + uk_size);*/  
#pragma endregion

#pragma region Calculating J by GPU reduction
		// Reduction J #1
		tmr_GPU.StartCounter();
		//reduce_J_kernel<<<nblocks1, block_size, block_size*DBL_SIZE>>>(d_DALG, d_JB, uk_size);
		reduce_J_kernel1<256><<<nblocks1, block_size, block_size*DBL_SIZE>>>(d_DALG, d_JB, uk_size);
		//CudaCheckError();

		if(nblocks1 < block_size){
			CudaSafeCall(cudaMemcpyAsync(p_J, d_JB, nblocks1*DBL_SIZE, cudaMemcpyDeviceToHost));
			t = tmr_GPU.GetCounter();
			total_time = total_time + t;
			std::cout << " Calculating J by GPU reduction time: " << t << endl;
			// Reduction J blocksums by CPU
			newJ = 0.0;
			tmr_CPU.start();

			for(j=0; j<nblocks1; j++)
				newJ = newJ + p_J[j];
		}  
		else{
			// Reduction J #2
			//reduce_J_kernel<<<nblocks2, block_size,  block_size*DBL_SIZE>>>(d_JB, d_J, nblocks1);
			reduce_J_kernel1<256><<<nblocks2, block_size,  block_size*DBL_SIZE>>>(d_JB, d_J, nblocks1);
			//CudaCheckError();
			CudaSafeCall(cudaMemcpyAsync(p_J, d_J, nblocks2*DBL_SIZE, cudaMemcpyDeviceToHost));
			t = tmr_GPU.GetCounter();
			total_time = total_time + t;
			std::cout << " Calculate J by GPU reduction time: " << t << endl;
			// Reduction J blocksums by CPU
			newJ = 0.0;
			tmr_CPU.start();

			for(j=0; j<nblocks2; j++)
				newJ = newJ + p_J[j];
		}  
#pragma endregion

#pragma region Getting time and checking stop-condition
		tmr_CPU.stop();
		t = tmr_CPU.elapsed();

		if(t > 0){
			total_time = total_time + t;
			std::cout << " Reduce J by CPU  time: " << t << endl;
		}
		a = fabs(newJ - G.J);
		std::cout << " Diff = " << a << endl;

		if((a < G.epsilon && (stop_iter == INT_MAX || i==stop_iter)) || i==stop_iter)
			break;
		G.J = newJ;  
#pragma endregion
	}
	if(i == G.max_iter) i--;
#pragma endregion

#pragma region Copying device back to host
		tmr_GPU.StartCounter();
	CudaSafeCall(cudaMemcpyAsync(p_centroids, d_centroids, centroids_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_NNT, d_NNT, um_size*INT_SIZE, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_DNNT, d_DNNT, um_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	CudaSafeCall(cudaMemcpyAsync(p_u, d_u, uk_size*DBL_SIZE, cudaMemcpyDeviceToHost));
	t = tmr_GPU.GetCounter();
	total_time += t;
	std::cout << "Device to host time: " << t << endl;
#pragma endregion

#pragma region Writing results to files
	G.write<double>(p_centroids, G.K, G.D, G.path + "centroids.GPU.txt");
	G.write<int>(p_NNT, G.N, G.M, G.path + "NNT.GPU.txt");
	G.write<double>(p_DNNT, G.N, G.M, G.path + "DNNT.GPU.txt");
	G.write<double>(p_u, G.N, G.K, G.path + "u.GPU.txt");
	G.write<double>(p_tempU, G.N, G.K, G.path + "tempU.GPU.txt");  
#pragma endregion

#pragma region Cuda free device memories
	cudaFree(d_points);
	cudaFree(d_centroids);
	cudaFree(d_NNT);
	cudaFree(d_DNNT);
	cudaFree(d_DALG);
	cudaFree(d_u);
	cudaFree(d_tempU);
	cudaFree(d_J);
	cudaFree(d_JB);  
#pragma endregion

#pragma region Cuda free host pinned memories
	cudaFreeHost(p_points);
	cudaFreeHost(p_centroids);
	cudaFreeHost(p_NNT);
	cudaFreeHost(p_DNNT);
	cudaFreeHost(p_DALG);
	cudaFreeHost(p_u);
	cudaFreeHost(p_tempU);
	cudaFreeHost(p_J);  
#pragma endregion

#pragma region Returning last iteration index and total running time
	double * rs = new double[2];
	rs[0] = total_time;
	rs[1] = (double)i;  
#pragma endregion

	cudaDeviceReset();
	return rs;
}