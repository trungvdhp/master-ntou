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
#include <malloc.h>
#include "TimingCPU.h"

class GFKM
{
public:
	int N;
	int D;
	int K;
	int M;
	int L;

	int max_iter;
	double fuzzifier;
	double epsilon;

	double * points;
	double * centroids;
	double * memberships;
	int * NNT;

	std::string path;
	std::string * labels;

	GFKM(void);
	GFKM(std::string path, std::string filename, int _M);
	void read(std::string full_path, int _M);
	void initialize_centroids();
	void update_memberships();
	double * calculate_new_centroids();
	bool converged(double * newCentroids);
	double * run(FILE * f, int stop_iter);
};
