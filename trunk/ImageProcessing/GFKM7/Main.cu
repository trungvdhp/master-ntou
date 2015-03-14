#include "GFKM.cuh"
#include "GFKM.h"
#include <string>

int main(int argc, char* argv[])
{
	string path = "D:\\Master\\ImageProcessing\\GFKM\\Data\\LenaPeppersBaboon\\";
	string fname = "LenaPeppersBaboon.txt";
	int M = 2;
	int max_iter = 300;
	double epsilon = 1e-10;//numeric_limits<double>::epsilon();
	int mode = 1;
	int stop_iter = 99;

	if (argc > 2){
		path = string(argv[1]);
		fname = string(argv[2]);
		cout << path << endl;

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
						}
					}
				}
			}
		}
	}
	time_t rawtime;
	time ( &rawtime );
	GFKM G(path, fname);
	G.epsilon = epsilon;
	G.max_iter = max_iter;
	G.M = M;
	G.initialize_centroids();
	FILE * fp = fopen("test.log","a");
	fprintf(fp, "%s", ctime(&rawtime));
	fprintf(fp,"%s\%s\n N = %d, D = %d, K = %d, M = %d, epsilon = %.0e\n Mode = %s\n", 
		path.c_str(), fname.c_str(), G.N, G.D, G.K, G.M, G.epsilon, 
		mode==0 ? "Updating centroids by CPU" : "Updating centroids by GPU");
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	fprintf(fp, "GPU running\n");
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	double * gpu_rs = GFKM_GPU(fp, G, 256, stop_iter, mode);
	G.J = 0.0;
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	fprintf(fp, "CPU running\n");
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	double * cpu_rs = G.run(fp, (int)gpu_rs[1]);
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	fprintf(fp, "Total CPU time: %10.3lf\n", cpu_rs[0]);
	fprintf(fp, "Total GPU time: %10.3lf\n", gpu_rs[0]);
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	fprintf(fp, "Total CPU time / Total GPU time: %.2lf\n", cpu_rs[0]/gpu_rs[0]);
	fprintf(fp, "----------------------------------------------------------------------------------\n");
	fclose(fp);
	delete [] gpu_rs;
	delete [] cpu_rs;
	//getch();
    return 0;
}