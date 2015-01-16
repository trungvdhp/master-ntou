#include "GFKM.h"
#include "Util.h"

GFKM::GFKM(void)
{
	J = 0.0;
}

GFKM::GFKM(string _path, string filename)
{
	*this = GFKM();
	path = _path;
	read(path + filename);
}

void GFKM::read(string full_path)
{
	double dt;
	FILE *f = fopen(full_path.c_str(), "r");
	int index=0;
	if(f == NULL){
		cerr << "* File you are trying to access cannot be found or opened!" << endl;
		exit(1);
	}
	fscanf(f, "%d %d %d %d", &N, &K, &D, &L);
	points = new double[N*D];
	centroids = new double[K*D];
	labels = new string[N];

	if(L == 0){
		for(int i=0; i<N; i++){
			fscanf(f, "%s", &labels[i]);

			for(int j=0; j<D; j++){
				fscanf(f, "%lf", &dt);
				points[index++] = dt;
			}
		}
	}
	else if(L==-1){
		for(int i=0; i<N; i++){
			for(int j=0; j<D; j++){
				fscanf(f, "%lf", &dt);
				points[index++] = dt;
			}
		}
	}
	else{
		for(int i=0; i<N; i++){
			for(int j=0; j<D; j++){
				fscanf(f, "%lf", &dt);
				points[index++] = dt;
			}
			fscanf(f, "%s", &labels[i]);
		}
	}
	fuzzifier = 1.0 + (1418.0/N + 22.05)*pow(D, -2) + 
		(12.33/N + 0.243)*pow(D, -0.0406*log(N) - 0.1134);
	fclose(f);
}

void GFKM::initialize_centroids()
{
	int first_index;
	int last_index;
	int span = 0;
	int step = N/K;
	int KD = K*D;

	srand((unsigned int)time((time_t*)(NULL)));

	for(int i=0; i<KD;){
		first_index = (span + rand() % step)*D;
		last_index = first_index+D;

		while(first_index < last_index)
			centroids[i++] = points[first_index++];
		span += step;
	}
}

void GFKM::initialize_NNT()
{
	NNT = new int[N*M];
	DNNT = new double[N*M];
	
	int i, j, x, idx;
	int* pNNT = NNT;
	double* pDNNT = DNNT;
	double* pPoints = points;
	double* pCentroids;
	double diff, temp;

	for(i=0; i<N; i++,pNNT+=M, pDNNT+=M,pPoints+=D){
		pCentroids = centroids;

		for(j=0; j<M; j++) pDNNT[j] = DBL_MAX;

		for(j=0; j<K; j++,pCentroids+=D){
			diff = 0.0;

			for(x=0; x<D; x++){
				temp = pPoints[x] - pCentroids[x];
				diff = diff + temp*temp;
			}
			idx = 0;

			for(; idx < M; idx++){
				if(pDNNT[idx] > diff) break;
			}

			for(x=M-1; x>idx; x--){
				pDNNT[x] = pDNNT[x-1];
				pNNT[x] = pNNT[x-1];
			}

			if(idx < M){
				pDNNT[idx] = diff;
				pNNT[idx] = j;
			}
		}
	}
}

void GFKM::update_memberships()
{
	int i, j, idx;
	int* pNNT = NNT;
	double* pDNNT = DNNT;
	U_ALG = new double[N*K]();
	tempU = new double[N*K]();
	double* pU = U_ALG;
	double* pTempU = tempU;
	double f = 1.0/(fuzzifier-1);
	double diff, sum;
	bool next;

	for(i=0; i<N; i++,pU+=K,pTempU+=K,pNNT+=M,pDNNT+=M){
		sum = 0.0;
		next = false;

		for(j=0; j<M; j++){
			idx = pNNT[j];
			diff = pDNNT[j];

			if(diff == 0.0){
				pU[idx] = 1.0;
				pTempU[idx] = 1.0;
				next = true;
				break;
			}
			pU[idx] = pow(diff, f);
			sum = sum + 1.0 / pU[idx];
		}

		if(next)
			continue;

		for(j=0; j<M; j++){
			idx = pNNT[j];
			pU[idx] = 1.0 / (pU[idx]*sum);
			pTempU[idx] = pow(pU[idx], fuzzifier);
		}
	}
}

void GFKM::update_centroids()
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

double GFKM::update_NNT()
{
	int i, j, x, idx;
	int* pNNT = NNT;
	double* pDNNT = DNNT;
	double* pPoints = points;
	double* pTempU = tempU;
	double* pCentroids;
	double diff, temp;
	double JK = 0.0;

	for(i=0; i<N; i++,pNNT+=M,pDNNT+=M,pPoints+=D,pTempU+=K){
		pCentroids = centroids;

		for(j=0; j<M; j++) pDNNT[j] = DBL_MAX;

		for(j=0; j<K; j++,pCentroids+=D){
			diff = 0.0;

			for(x=0; x<D; x++){
				temp = pPoints[x] - pCentroids[x];
				diff = diff + temp*temp;
			}
			JK = JK + pTempU[j] * diff;
			idx = 0;

			for(; idx < M; idx++){
				if(pDNNT[idx] > diff) break;
			}

			for(x=M-1; x>idx; x--){
				pDNNT[x] = pDNNT[x-1];
				pNNT[x] = pNNT[x-1];
			}

			if(idx < M){
				pDNNT[idx] = diff;
				pNNT[idx] = j;
			}
		}
	}
	return JK;
}

double* GFKM::run(int stop_iter)
{
	int i;
	double t0, t1 = 0.0, t2 = 0.0, t3 = 0.0;
	double a, newJ;
	TimingCPU tmr;
	// initialize and update NNT
	tmr.start();
	initialize_NNT();
	tmr.stop();
	t0 = tmr.elapsed();

	for(i=0; i<max_iter && i<=stop_iter; i++){
		// Update membership by CPU
		tmr.start();
		update_memberships();
		tmr.stop();
		t1 = t1 + tmr.elapsed();
		
		// Update centroids
		tmr.start();
		update_centroids();
		tmr.stop();
		t2 = t2 + tmr.elapsed();
		
		// Update NNT
		tmr.start();
		newJ = update_NNT();
		tmr.stop();
		t3 = t3 + tmr.elapsed();

		// Check if stop
		a = fabs(newJ - J);

		if((a < epsilon && (stop_iter == INT_MAX || i==stop_iter)) || i == stop_iter)
			break;
		J = newJ;
	}

	if(i==max_iter) i--;
	Util::write<double>(centroids, K, D, path + "centroids.txt");
	Util::write<int>(NNT, N, M, path + "NNT.txt");
	//Util::write<double>(DNNT, N, M, path + "DNNT.txt");
	//Util::write<double>(U_ALG, N, K, path + "u.txt");
	//Util::write<double>(tempU, N, K, path + "tempU.txt");
	Util::print_times(t0, t1, t2, t3, i+1);
	double *rs = new double[2];
	rs[0] = t0 + t1 + t2 + t3;
	rs[1] = (double)i;

	return rs;
}