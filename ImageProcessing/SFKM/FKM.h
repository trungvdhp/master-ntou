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

	string path;
	string * labels;

	FKM(void);
	FKM(string path, string filename);
	void read(string full_path);
	void initialize_centroids();
	void update_memberships();
	double * calculate_new_centroids();
	bool converged(double * newCentroids);
	double * run(FILE * f, int stop_iter);
};
