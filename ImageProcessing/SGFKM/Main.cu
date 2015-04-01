#include "SGFKM.cuh"
#include "GFKM.h"
#include "TimingCPU.h"
#include <conio.h>

int main(int argc, char* argv[])
{
	std::string path = "D:\\Master\\ImageProcessing\\Data\\Synthetic\\";
	std::string fname = "960x512x100.dat";
	int M = 2;
	int max_iter = 1;
	int stop_iter = INT_MAX;
	int mode = 1;
	double epsilon = 1e-8;//numeric_limits<double>::epsilon();
	FILE * fp;

	if (argc > 2){
		path = std::string(argv[1]);
		fname = std::string(argv[2]);

		if (argc > 3){
			M = atoi(argv[3]);

			if (argc > 4){
				max_iter = atoi(argv[4]);

				if (argc > 5){
					epsilon = atof(argv[5]);

					if (argc > 6){
						mode = atoi(argv[6]);

						if (argc > 7){
							stop_iter = atoi(argv[7]) - 1;

							if (argc > 8){
								fp = fopen(argv[8], "a");
							}
						}
					}
				}
			}
		}
	}
	time_t rawtime;
	time ( &rawtime );
	GFKM G(path, fname, M);
	G.epsilon = epsilon;
	G.max_iter = max_iter;
	G.initialize_centroids();

	if(argc < 9) 
		fp = fopen("SGFKM.test.log", "a");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# %s", ctime(&rawtime));
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp," %s%s\n N = %d, D = %d, K = %d, epsilon = %.0e\n", 
		path.c_str(), fname.c_str(), G.N, G.D, G.K, G.epsilon);
	fprintf(fp, " Mode: Calculating new centroids on %s\n", 
		mode == 1 ? "CPU" : mode == 2 ? "GPU (FKM)" : 
		mode == 3 ? "GPU (GFKM, counting sort)" : "GPU (GFKM, thrust stable sort by key)");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# GPU running\n");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	double * gpu_rs = GFKM_GPU(fp, G, 256, stop_iter, mode);
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