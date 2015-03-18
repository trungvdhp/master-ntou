#include "FKM.h"
#include "Util.h"

FKM::FKM(void)
{
}

FKM::FKM(string _path, string filename)
{
	*this = FKM();
	path = _path;
	read(path + filename);
}

void FKM::read(string full_path)
{
	double dt;
	FILE *f = fopen(full_path.c_str(), "r");
	int index=0;
	if (f == NULL){
		cerr << "* File you are trying to access cannot be found or opened!" << endl;
		exit(1);
	}
	fscanf(f, "%d %d %d %d", &N, &K, &D, &L);
	points = new double[N*D];
	centroids = new double[K*D];
	labels = new string[N];
	memberships = new double[N*K];

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

void FKM::initialize_centroids()
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
}

void FKM::update_memberships()
{
	int i, j, x;
	double * pPoints = points;
	double * pCentroids;
	double * pMemberships = memberships;
	double f = 1.0/(fuzzifier-1);
	double diff, temp, sum;
	bool next;

	for (i = 0; i < N; ++i, pMemberships += K, pPoints += D){
		pCentroids = centroids;
		sum = 0.0;
		next = false;

		for (x = 0; x < K; ++x)
			pMemberships[x] = 0.0;

		for (j = 0; j < K; ++j, pCentroids += D){
			diff = 0.0;

			for (x = 0; x < D; ++x){
				temp = pPoints[x] - pCentroids[x];
				diff = diff + temp*temp;
			}

			if (diff == 0.0){
				pMemberships[j] = 1.0;
				next = true;
				break;
			}
			diff =  pow(diff, f);
			pMemberships[j] = diff;
			sum = sum + 1.0 / diff;
		}
		if (next)
			continue;

		for (j = 0; j < K; ++j){
			pMemberships[j] = pow(pMemberships[j]*sum, -fuzzifier);
		}
	}
}

double * FKM::calculate_new_centroids()
{
	int i, j, k;
	double * pPoints = points;
	double * pMemberships = memberships;
	double * pCentroids;
	double * newCentroids = new double[K*D]();
	double * sum = new double[K]();

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

	return newCentroids;
}

bool FKM::converged(double * newCentroids)
{
	int i, size = K*D;

	for (i = 0; i < size; ++i){
		if (fabs(centroids[i] - newCentroids[i]) >= epsilon) return false;
	}

	return true;
}

double * FKM::run(FILE * f, int stop_iter)
{
	int i;
	double t, t1 = 0.0, t2 = 0.0, t3 = 0.0;
	TimingCPU tmr;
	// initialize and update NNT
	double * newCentroids;
	bool stop;

	for (i = 0; i < max_iter && i <= stop_iter; ++i){
		// Update membership by
		tmr.start();
		update_memberships();
		tmr.stop();
		t1 = t1 + tmr.elapsed();
		
		// Calculate new centroids
		tmr.start();
		newCentroids = calculate_new_centroids();
		tmr.stop();
		t2 = t2 + tmr.elapsed();
		
		// Check convergence
		tmr.start();
		stop = converged(newCentroids);
		tmr.stop();
		t = tmr.elapsed();

		if (t < 0.0) t = 0.0;
		t3 = t3 + t;
		centroids = newCentroids;

		if ((stop && (stop_iter == INT_MAX || i == stop_iter)) || i == stop_iter)
			break;
	}

	if (i == max_iter) i--;
	Util::write<double>(centroids, K, D, path + "centroids.txt");
	Util::write<double>(memberships, N, K, path + "memberships.txt");
	Util::print_times(f, t1, t2, t3, i+1);
	double *rs = new double[2];
	rs[0] = t1 + t2 + t3;
	rs[1] = (double)i;
	return rs;
}