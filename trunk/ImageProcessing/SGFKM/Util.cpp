#include "Util.h"
void Util::print_times(double t1, double t2, double t3, int num_iters)
{
	/*std::cout << " Number of iterations: " << num_iters << std::endl;
	std::cout <<std::fixed << std::setprecision(PRN);
	std::cout << " Updating memberships     : ";
	std::cout.width(WID);
	std::cout << std::right << t1/num_iters << " ";
	std::cout.width(WID);
	std::cout << std::right << t1 << std::endl;
	std::cout << " Calculating new centroids: ";
	std::cout.width(WID);
	std::cout << std::right << t2/num_iters << " ";
	std::cout.width(WID);
	std::cout << std::right << t2 << std::endl;
	std::cout << " Checking convergence     : ";
	std::cout.width(WID);
	std::cout << std::right << t3/num_iters << " ";
	std::cout.width(WID);
	std::cout << std::right << t3 << std::endl;*/
}

void Util::print_times(FILE * f, double t1, double t2, double t3, int num_iters)
{
	/*fprintf(f, "  Number of iterations: %d\n" , num_iters);
	fprintf(f, "  Updating memberships     : ");
	fprintf(f, "%9.2lf ", t1/num_iters);
	fprintf(f, "%9.2lf\n", t1);
	fprintf(f, "  Calculating new centroids: ");
	fprintf(f, "%9.2lf ", t2/num_iters);
	fprintf(f, "%9.2lf\n", t2);
	fprintf(f, "  Checking convergence     : ");
	fprintf(f, "%9.2lf ", t3/num_iters);
	fprintf(f, "%9.2lf\n", t3);*/
}