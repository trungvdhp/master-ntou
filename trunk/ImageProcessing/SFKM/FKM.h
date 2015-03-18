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

class FKM
{
public:
	int N;
	int D;
	int K;
	int L;

	int max_iter;
	double fuzzifier;
	double epsilon;

	double * points;
	double * centroids;
	double * memberships;

	std::string path;
	std::string * labels;

	FKM(void);
	FKM(std::string path, std::string filename);
	void read(std::string full_path);
	void initialize_centroids();
	void update_memberships();
	double * calculate_new_centroids();
	bool converged(double * newCentroids);
	double * run(FILE * f, int stop_iter);
};
