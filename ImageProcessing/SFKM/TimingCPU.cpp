#include "TimingCPU.h"

LARGE_INTEGER TimingCPU::m_freg = (QueryPerformanceFrequency(&TimingCPU::m_freg), TimingCPU::m_freg);

LONGLONG TimingCPU::m_overhead = TimingCPU::GetOverhead();