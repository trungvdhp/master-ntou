#include "GFKM.h"
#include "Util.h"

GFKM::GFKM(void)
{
}

GFKM::~GFKM(void)
{
	delete[] points, centroids, memberships, labels, NNT;
}

GFKM::GFKM(std::string _path, std::string filename, int _M)
{
	path = _path;
	read(path + filename, _M);
}

void GFKM::read(std::string full_path, int _M)
{
	double dt;
	FILE *f = fopen(full_path.c_str(), "r");
	int index=0;
	if (f == NULL){
		std::cerr << "* File you are trying to access cannot be found or opened!" << std::endl;
		exit(1);
	}
	fscanf(f, "%d %d %d %d", &N, &K, &D, &L);
	points = new double[N*D];
	centroids = new double[K*D];
	tempCentroids = new double[K*D];
	labels = new std::string[N];

	if (_M > K) M = K;
	else M = _M;

	NNT = new int[N*M];
	memberships = new double[N*M];
	
	if (L == 0){
		for (int i = 0; i < N; ++i){
			fscanf(f, "%s", &labels[i]);

			for (int j = 0; j < D; ++j){
				fscanf(f, "%lf", &dt);
				points[index++] = dt;
			}
		}
	}
	else if (L==-1){
		for (int i = 0; i < N; ++i){
			for (int j = 0; j < D; ++j){
				fscanf(f, "%lf", &dt);
				points[index++] = dt;
			}
		}
	}
	else{
		for (int i = 0; i < N; ++i){
			for (int j = 0; j < D; ++j){
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

	for (int i = 0; i < KD;){
		first_index = (span + rand() % step)*D;
		last_index = first_index+D;

		while(first_index < last_index)
			centroids[i++] = points[first_index++];
		span += step;
	}
	memcpy(tempCentroids, centroids, K*D*sizeof(double));
}

void GFKM::restore_initial_centroids()
{
	memcpy(centroids, tempCentroids, K*D*sizeof(double));
}

void GFKM::update_memberships()
{
	int i, j, x, idx;
	double * pPoints = points;
	double * pCentroids;
	double * pMemberships = memberships;
	double f = 1.0/(fuzzifier-1);
	double diff, temp, sum;
	bool next;
	double * DNNT = new double[M];
	int * pNNT = NNT;

	for (i = 0; i < N; ++i, pNNT += M, pMemberships += M, pPoints += D){
		pCentroids = centroids;
		
		next = false;

		for (j = 0; j < M; ++j){
			DNNT[j] = DBL_MAX;
			pMemberships[j] = 0.0;
		}
		
		for (j = 0; j < K; ++j, pCentroids += D){
			diff = 0.0;

			for (x = 0; x < D; ++x){
				temp = pPoints[x] - pCentroids[x];
				diff = diff + temp*temp;
			}
			idx = 0;

			for (; idx < M; ++idx){
				if (DNNT[idx] > diff) break;
			}

			for (x = M-1; x > idx; --x){
				DNNT[x] = DNNT[x-1];
				pNNT[x] = pNNT[x-1];
			}

			if (idx < M){
				DNNT[idx] = diff;
				pNNT[idx] = j;
			}
		}
		sum = 0.0;

		for (j = 0; j < M; ++j){

			if (DNNT[j] == 0){
				pMemberships[j] = 1.0;
				next = true;
				break;
			}
			diff =  pow(DNNT[j], f);

			//if (diff == std::numeric_limits<double>::infinity()) diff = DBL_MAX;
			pMemberships[j] = diff;
			sum = sum + 1.0 / diff;
			
		}
		if (next)
			continue;

		for (j = 0; j < M; ++j){
			pMemberships[j] = pow(pMemberships[j]*sum, -fuzzifier);
		}
	}
	//Util::write<double>(memberships, N, M, path + "memberships.txt");
}

double * GFKM::calculate_new_centroids()
{
	int i, j, k, idx;
	int * pNNT = NNT;
	double * pMemberships = memberships;
	double * pPoints = points;
	double * pCentroids;
	double * sum = new double[K]();
	double * newCentroids = new double[K*D]();

	for (i = 0; i < N; ++i, pMemberships += M, pNNT += M, pPoints += D){
		for (j = 0; j < M; ++j){
			idx = pNNT[j];
			sum[idx] = sum[idx] + pMemberships[j];
			pCentroids = newCentroids + idx*D;

			for ( k= 0; k < D; ++k)
				pCentroids[k] = pCentroids[k] + pMemberships[j]*pPoints[k];
		}
	}
	pCentroids = newCentroids;

	for (i = 0; i < K; ++i, pCentroids += D)
		for (j = 0; j < D; ++j)
			pCentroids[j] = pCentroids[j] / sum[i];
	return newCentroids;
}

void GFKM::calculate_new_centroids(double * newCentroids)
{
	int i, j, k, idx;
	int * pNNT = NNT;
	double * pMemberships = memberships;
	double * pPoints = points;
	double * pCentroids;
	double * sum = new double[K]();
	memset(newCentroids, 0, K*D*sizeof(double));

	for (i = 0; i < N; ++i, pMemberships += M, pNNT += M, pPoints += D){
		for (j = 0; j < M; ++j){
			idx = pNNT[j];
			sum[idx] = sum[idx] + pMemberships[j];
			pCentroids = newCentroids + idx*D;

			for (k=0; k<D; ++k)
				pCentroids[k] = pCentroids[k] + pMemberships[j]*pPoints[k];
		}
	}
	pCentroids = newCentroids;

	for (i = 0; i < K; ++i, pCentroids += D)
		for (j = 0; j < D; ++j)
			pCentroids[j] = pCentroids[j] / sum[i];
}

bool GFKM::converged(double * newCentroids)
{
	int i, size = K*D;

	for (i = 0; i < size; ++i){
		if (fabs(centroids[i] - newCentroids[i]) >= epsilon) return false;
	}

	return true;
}

double * GFKM::run(FILE * f, int stop_iter)
{
	int i;
	double t, t1 = 0.0, t2 = 0.0, t3 = 0.0;
	TimingCPU tmr;
	int centroidsSize = K*D*sizeof(double);
	double * newCentroids = (double*)malloc(centroidsSize);

	bool stop;
	// && i <= stop_iter
	for (i = 0; i < max_iter; ++i){
		// Update membership by
		tmr.start();
		update_memberships();
		tmr.stop();
		t1 = t1 + tmr.elapsed();
		
		// Calculate new centroids
		tmr.start();
		calculate_new_centroids(newCentroids);
		tmr.stop();
		t2 = t2 + tmr.elapsed();
		
		// Check convergence
		tmr.start();
		stop = converged(newCentroids);
		memcpy(centroids, newCentroids, centroidsSize);
		tmr.stop();
		t = tmr.elapsed();

		if (t < 0.0) t = 0.0;
		t3 = t3 + t;

		if ((stop && (stop_iter < 0 || i == stop_iter)) || i == stop_iter)
			break;
	}

	if (i == max_iter) i--;
	Util::write<double>(centroids, K, D, path + "centroids.txt");
	Util::write<int>(NNT, N, M, path + "NNT.txt");
	//Util::print_times(f, t1, t2, t3, i+1);
	double *rs = new double[4];
	rs[0] = t1;
	rs[1] = t2;
	rs[2] = t3;
	rs[3] = (double)i;
	return rs;
}