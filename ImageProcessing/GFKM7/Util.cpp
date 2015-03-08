#include "Util.h"
void Util::print_times(double t0, double t1, double t2, double t3, int num_iters)
{
	cout << " Number of iterations: " << num_iters << endl;
	cout <<fixed << setprecision(PRN);
	cout << " Initializing NNT    : ";
	cout.width(WID);
	cout << right << t0 << endl;
	cout << " Updating memberships: ";
	cout.width(WID);
	cout << right << t1/num_iters << " ";
	cout.width(WID);
	cout << right << t1 << endl;
	cout << " Updating centroids  : ";
	cout.width(WID);
	cout << right << t2/num_iters << " ";
	cout.width(WID);
	cout << right << t2 << endl;
	cout << " Updating NNT and J  : ";
	cout.width(WID);
	cout << right << t3/num_iters << " ";
	cout.width(WID);
	cout << right << t3 << endl;
}