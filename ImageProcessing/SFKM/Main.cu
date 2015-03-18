#include "SFKM.cuh"
#include "FKM.h"
#include "TimingCPU.h"
#include <conio.h>

int main(int argc, char* argv[])
{
	string path = "D:\\Master\\ImageProcessing\\Data\\LenaPeppersBaboon\\";
	string fname = "LenaPeppersBaboon.txt";
	int max_iter = 300;
	int stop_iter = INT_MAX;
	int mode = 1;
	double epsilon = 1e-8;//numeric_limits<double>::epsilon();
	FILE * fp;

	if (argc > 2){
		path = string(argv[1]);
		fname = string(argv[2]);

		if (argc > 3){
			max_iter = atoi(argv[3]);

			if (argc > 4){
				epsilon = atof(argv[4]);

				if (argc > 5){
					mode = atoi(argv[5]);

					if (argc > 6){
						stop_iter = atoi(argv[6]) - 1;

						if (argc > 7){
							fp = fopen(argv[7], "a");
						}
					}
				}
			}
		}
	}
	time_t rawtime;
	time ( &rawtime );
	FKM G(path, fname);
	G.epsilon = epsilon;
	G.max_iter = max_iter;
	G.initialize_centroids();

	if(argc < 8) 
		fp = fopen("SFKM.test.log", "a");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# %s", ctime(&rawtime));
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp," %s%s\n N = %d, D = %d, K = %d, epsilon = %.0e\n", 
		path.c_str(), fname.c_str(), G.N, G.D, G.K, G.epsilon);
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# GPU running\n");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	double * gpu_rs = FKM_GPU(fp, G, 256, stop_iter, mode);
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# CPU running\n");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	double * cpu_rs = G.run(fp, (int)gpu_rs[1]);
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# Total CPU time      : %9.2lf\n", cpu_rs[0]);
	fprintf(fp, "# Total GPU time      : %9.2lf\n", gpu_rs[0]);
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# Speedup             : %9.2lf\n", cpu_rs[0]/gpu_rs[0]);
	fclose(fp);
	printf(" Speedup: %.2lf\n", cpu_rs[0]/gpu_rs[0]);
	delete [] gpu_rs;
	delete [] cpu_rs;
	
	//getch();
    return 0;
}