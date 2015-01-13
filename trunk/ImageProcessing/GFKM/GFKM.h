#pragma once
#include <iostream>
#include <algorithm>
#include <limits>
#include <cfloat>
#include <string>
#include <fstream>
#include <ctime>
#include <cassert>
#include <iomanip>
#include <cstdlib>
#include "TimingCPU.h"
using namespace std;

class GFKM
{
public:
	int N;
	int D;
	int K;
	int M;
	int L;

	string path;

	int max_iter;
	double fuzzifier;
	double epsilon;
	double J;

	double* points;
	double* centroids;
	double* U_ALG;
	double* tempU;
	double* DNNT;
	int* NNT;

	string* labels;

	GFKM(void);
	GFKM(string path, string filename);
	void read(string full_path);
	void initialize_centroids();
	void initialize_NNT();
	void update_memberships();
	void update_centroids();
	double update_NNT();
	double* run(int stop_iter);
	template <class T>
	void write(T* a, int N, int D, string filename)
	{
		ofstream file;
		int index=0;
		file.open(filename);

		if(file.fail()){
			cerr << "* File you are trying to access cannot be found or opened or created!" << endl;
			exit(1);
		}
		file << N << " " << D << endl;
		file << std::fixed << std::setprecision(9);

		for(int i=0; i<N; i++){
			for(int j=0; j<D; j++){
				if(sizeof(T) != sizeof(int)) file.width(15);
				else file.width(2);
				file << std::right << a[index++] << " ";
			}
			file << endl;
		}
	}
};
