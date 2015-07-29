#include "SGFKM.cuh"
#include "GFKM.h"
#include "TimingCPU.h"
#include <conio.h>
#include <chrono>

int main(int argc, char* argv[])
{
	std::string path = "D:\\Master\\ImageProcessing\\Data\\LenaPeppersBaboon\\"; //LenaPeppersBaboon
	std::string fname = "LenaPeppersBaboon.txt";
	int M = 2;
	int max_iter = 1;
	int stop_iter = 0;
	int test_runs = 1;
	int mode = 2;
	int block_size = 1;
	/*printf("Input block size : ");
	scanf("%d", &block_size);
	printf("Input mode : ");
	scanf("%d", &mode);
	printf("Input stop iter : ");
	scanf("%d", &stop_iter);*/
	//printf("Input file name : ");
	//scanf("%s", &fname);
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
								block_size = atoi(argv[8]);

								if (argc > 9){
									test_runs = atoi(argv[9]);

									if (argc > 10){
										fp = fopen(argv[10], "a");
									}
								}
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

	if(argc < 11) 
		fp = fopen("SGFKM.test.log", "a");
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp, "# %s", ctime(&rawtime));
	fprintf(fp, "-------------------------------------------------------------------------------\n");
	fprintf(fp," %s%s\n N = %d, D = %d, K = %d, M = 2,  epsilon = %.0e, block size = %d, test runs = %d.\n", 
		path.c_str(), fname.c_str(), G.N, G.D, G.K, G.epsilon, block_size, test_runs);
	//fprintf(fp," %s%s\n, M = 2, block size = %d, test runs = %d.\n", 
		//path.c_str(), fname.c_str(), block_size, test_runs);

	int sleeping_time = 5000;
	int warpSize = 32;
	int block_sizes[32];
	for (int i = 0, j = 32; i < 32; ++i, j += warpSize) block_sizes[i] = j;
	int start_id = 17;
	int end_id = 32;

	if (block_size <= 0 || block_size >= 32 && block_size <= 1024)
	{
		start_id = 0;
		end_id = 1;
		block_sizes[0] = block_size;
	}
	G.initialize_centroids();

	for (; start_id < end_id; start_id++)
	{
		fprintf(fp, "-------------------------------------------------------------------------------\n");
		fprintf(fp, "# Run with block size = %d\n", block_sizes[start_id]);
		printf ("# Run with block size = %d\n", block_sizes[start_id]);

		int start_mode = 1, end_mode = 5;
	
		if (mode > 0 && mode < 5){
			start_mode = mode;
			end_mode = start_mode + 1;
		}
		else
		{
			fprintf(fp, "-------------------------------------------------------------------------------\n");
			fprintf(fp, "# Mode %d is not from 1 to 4, so run all modes:\n", mode);
			printf ("# Mode %d is not from 1 to 4, so run all modes:\n", mode);
		}
		double * cpu_rs = G.run(fp, stop_iter);
		G.restore_initial_centroids();

		while (start_mode < end_mode)
		{
			fprintf(fp, "-------------------------------------------------------------------------------\n");
			fprintf(fp, "# Mode %d :\n", start_mode);
			printf ("# Running mode %d :\n", start_mode);
			double total_speedup = 0.0, step1_speedup = 0.0, step2_speedup = 0.0, step3_speedup = 0.0;
			printf ("# Test run = %d\n",test_runs);

			for (int i = 0; i < test_runs; ++i)
			{
				
				//printf("Finished CPU running #%d!\n", i+1);
				//_sleep(sleeping_time);
				//printf("Stop iteration = %d\n", (int)cpu_rs[3]);
				double * gpu_rs = GFKM_GPU(fp, G, block_sizes[start_id], (int)cpu_rs[3], start_mode);

				total_speedup = total_speedup + (cpu_rs[0] + cpu_rs[1] + cpu_rs[2]) / (gpu_rs[0] + gpu_rs[1] + gpu_rs[2] + gpu_rs[3]);
				step1_speedup = step1_speedup + cpu_rs[0] / gpu_rs[0];
				step2_speedup = step2_speedup + cpu_rs[1] / gpu_rs[1];
				step3_speedup = step3_speedup + cpu_rs[2] / gpu_rs[2];
				
				delete [] gpu_rs;
			}
			fprintf(fp, "-------------------------------------------------------------------------------\n");
			fprintf(fp, "# Step1 average speedup of %d times: %9.2lf\n", test_runs, step1_speedup/test_runs);
			fprintf(fp, "# Step2 average speedup of %d times: %9.2lf\n", test_runs, step2_speedup/test_runs);
			fprintf(fp, "# Step3 average speedup of %d times: %9.2lf\n", test_runs, step3_speedup/test_runs);
			fprintf(fp, "# Total average speedup of %d times: %9.2lf\n", test_runs, total_speedup/test_runs);
			printf("# Step1 average speedup of %d times: %9.2lf\n", test_runs, step1_speedup/test_runs);
			printf("# Step2 average speedup of %d times: %9.2lf\n", test_runs, step2_speedup/test_runs);
			printf("# Step3 average speedup of %d times: %9.2lf\n", test_runs, step3_speedup/test_runs);
			printf("# Total average speedup of %d times: %9.2lf\n", test_runs, total_speedup/test_runs);

			//printf(" Sleeping in %d seconds...\n", sleeping_time / 1000);
			_sleep(sleeping_time);
			start_mode++;
		}
		delete [] cpu_rs;
	}
	
	fclose(fp);
	//getch();
    return 0;
}