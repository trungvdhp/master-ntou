#define __CUDA_INTERNAL_COMPILATION__
#include "math_functions.h"
#undef __CUDA_INTERNAL_COMPILATION__
#include "device_launch_parameters.h"
#include "device_functions.h"
#include "sm_20_atomic_functions.h"

#include <thrust/device_ptr.h>
#include <thrust/sort.h>
#include <thrust/binary_search.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/adjacent_difference.h>

#include "CudaErrorCheck.cuh"
#include "TimingGPU.cuh"
#include "TimingCPU.h"
#include "GFKM.h"

class BlockSizeV1
{
public:
	int updateMembershipsKernelBlockSize;

	BlockSizeV1(void) {
		updateMembershipsKernelBlockSize = 288;
	}

	BlockSizeV1(int initBlockSize) {
		updateMembershipsKernelBlockSize = initBlockSize;
	}
};

class BlockSizeV2
{
public:
	int updateMembershipsKernelBlockSize;
	int reduceMembershipsKernelBlockSize;
	int reduceCentroidsKernelBlockSize;

	BlockSizeV2(void){
		updateMembershipsKernelBlockSize = 64;
		reduceMembershipsKernelBlockSize = 256;
		reduceCentroidsKernelBlockSize = 256;
	}

	BlockSizeV2(int initBlockSize) {
		updateMembershipsKernelBlockSize = initBlockSize;
		reduceMembershipsKernelBlockSize = initBlockSize;
		reduceCentroidsKernelBlockSize = initBlockSize;
	}
};

class BlockSizeV3
{
public:
	int updateMembershipsKernelBlockSize;
	int histogramKernelBlockSize;
	int countingSortKernelBlockSize;
	int reduceMembershipsKernelBlockSize;
	int reduceCentroidsKernelBlockSize;

	BlockSizeV3(void) {
		updateMembershipsKernelBlockSize = 288;
		histogramKernelBlockSize = 256;
		countingSortKernelBlockSize = 512;
		reduceMembershipsKernelBlockSize = 128;
		reduceCentroidsKernelBlockSize = 64;
	}

	BlockSizeV3(int initBlockSize) {
		updateMembershipsKernelBlockSize = initBlockSize;
		histogramKernelBlockSize = initBlockSize;
		countingSortKernelBlockSize = initBlockSize;
		reduceMembershipsKernelBlockSize = initBlockSize;
		reduceCentroidsKernelBlockSize = initBlockSize;
	}

};

 class BlockSizeV4
{
public:
	int updateMembershipsKernelBlockSize;
	int gatherKernelBlockSize;
	int reduceMembershipsKernelBlockSize;
	int reduceCentroidsKernelBlockSize;

	BlockSizeV4(void){
		updateMembershipsKernelBlockSize = 288;
		gatherKernelBlockSize = 64;
		reduceMembershipsKernelBlockSize = 128;
		reduceCentroidsKernelBlockSize = 64;
	}

	BlockSizeV4(int initBlockSize) {
		updateMembershipsKernelBlockSize = initBlockSize;
		gatherKernelBlockSize = initBlockSize;
		reduceMembershipsKernelBlockSize = initBlockSize;
		reduceCentroidsKernelBlockSize = initBlockSize;
	}
};

inline __host__ int getBlockSizeForMembershipKkernelV1a(int initBlockSize = 256);
inline __host__ int getBlockSizeForMembershipKkernelV1b(int dynamicSMemSize, int initBlockSize = 256);
inline __host__ int getBlockSizeForMembershipKkernelV1c(int dynamicSMemSize, int initBlockSize = 256);

inline __host__ int getBlockSizeForMembershipKkernelV2a(int initBlockSize = 256);
inline __host__ int getBlockSizeForMembershipKkernelV2b(int dynamicSMemSize, int initBlockSize = 256);
inline __host__ int getBlockSizeForMembershipKkernelV2c(int dynamicSMemSize, int initBlockSize = 256);

inline __host__ int blockSizeToDynamicSMemSize(int blockSize = 256);

inline __host__ BlockSizeV2 getBlockSizeForCentroidKernelV2(int initBlockSize = 256);
inline __host__ BlockSizeV3 getBlockSizeForCentroidKernelV3(int initBlockSize = 256);
inline __host__ BlockSizeV4 getBlockSizeForCentroidKernelV4(int initBlockSize = 256);

inline __host__ BlockSizeV1 getBlockSizesForVersion1(int initBlockSize = 256);
inline __host__ BlockSizeV2 getBlockSizesForVersion2(int initBlockSize = 256);
inline __host__ BlockSizeV3 getBlockSizesForVersion3(int initBlockSize = 256);
inline __host__ BlockSizeV4 getBlockSizesForVersion4(int initBlockSize = 256);

__host__ double * GFKM_GPU(FILE * f, GFKM & G, int block_size, int stop_iter, int mode = 1);