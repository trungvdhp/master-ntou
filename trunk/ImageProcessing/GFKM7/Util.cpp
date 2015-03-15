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

void Util::print_times(FILE * f, double t0, double t1, double t2, double t3, int num_iters)
{
	fprintf(f, "  Number of iterations: %d\n" , num_iters);
	fprintf(f, "  Initializing NNT    : ");
	fprintf(f, "%9.2lf\n", t0);
	fprintf(f, "  Updating memberships: ");
	fprintf(f, "%9.2lf ", t1/num_iters);
	fprintf(f, "%9.2lf\n", t1);
	fprintf(f, "  Updating centroids  : ");
	fprintf(f, "%9.2lf ", t2/num_iters);
	fprintf(f, "%9.2lf\n", t2);
	fprintf(f, "  Updating NNT and J  : ");
	fprintf(f, "%9.2lf ", t3/num_iters);
	fprintf(f, "%9.2lf\n", t3);
}