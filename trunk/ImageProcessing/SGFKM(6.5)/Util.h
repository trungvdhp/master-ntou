#include <iostream>
#include <string>
#include <fstream>
#include <iomanip>
#define PRN 9
#define WID 15

class Util
{
public:
	template <typename T>
	static void write(T * a, int N, int D, std::string filename);
	static void print_times(double t1, double t2, double t3, int num_iters);
	static void print_times(FILE * f, double t1, double t2, double t3, int num_iters);
};
template <typename T>
void Util::write(T * a, int N, int D, std::string filename)
{
	std::ofstream file;
	int index = 0;
	file.open(filename);

	if (file.fail()){
		std::cerr << "* File you are trying to access cannot be found or opened or created!" << std::endl;
		exit(1);
	}
	file << N << " " << D << std::endl;
	file << std::fixed << std::setprecision(PRN);

	for (int i = 0; i < N; ++i){
		for (int j = 0; j < D; ++j){
			if (sizeof(T) != sizeof(int)) file.width(WID);
			else file.width(2);
			file << std::right << a[index++] << " ";
		}
		file << std::endl;
	}
}