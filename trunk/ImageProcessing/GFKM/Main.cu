#include "GFKM.cuh"
#include "GFKM.h"
#include "TimingCPU.h"
#include <conio.h>

int main(int argc, char* argv[])
{
	string path = "D:\\Projects\\master-ntou\\ImageProcessing\\GFKM\\Data\\LenaPeppersBaboon\\";//sat\\";
	string fname = "LenaPeppersBaboon.txt";//"sat.data";
	int M = 2;
	int max_iter = 1000;
	double epsilon = numeric_limits<double>::epsilon();
	int mode = 1;
	int stop_iter = INT_MAX;

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
	printf("mode = %d\n", mode);
	GFKM G(path, fname);
	G.epsilon = epsilon;
	G.max_iter = max_iter;
	G.M = M;
	G.initialize_centroids();
	cout << "-------------------------------------------------------" << endl;
	cout << "GPU running" << endl;
	cout << "-------------------------------------------------------" << endl;
	double * gpu_rs = GFKM_GPU(G, 256, stop_iter, mode);
	G.J = 0.0;
	cout << "-------------------------------------------------------" << endl;
	cout << "CPU running" << endl;
	cout << "-------------------------------------------------------" << endl;
	double * cpu_rs = G.run((int)gpu_rs[1]);
	cout << "-------------------------------------------------------" << endl;
	cout << "Total CPU time: " << cpu_rs[0] << endl;
	cout << "Total GPU time: " << gpu_rs[0] << endl;
	cout << "-------------------------------------------------------" << endl;
	cout << "Total CPU time / Total GPU time: " << cpu_rs[0]/gpu_rs[0] << endl;
	cout << "-------------------------------------------------------" << endl;
	delete [] gpu_rs;
	delete [] cpu_rs;
	//getch();
    return 0;
}