#pragma once
#include <iostream>
#include <algorithm>
#include <limits>
#include <cfloat>
#include <string>
#include <fstream>
#include <ctime>
#include <cassert>
#include <cstdlib>
#include <vector>
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

	double * points;
	double * centroids;
	double * U_ALG;
	double * tempU;
	double * DNNT;
	int * NNT;

	string * labels;

	GFKM(void);
	GFKM(string path, string filename);
	void read(string full_path);
	void initialize_centroids();
	void initialize_NNT();
	void update_memberships();
	void update_centroids();
	double update_NNT();
	double * run(FILE * f, int stop_iter);
};
