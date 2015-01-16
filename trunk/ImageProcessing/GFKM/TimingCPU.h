#pragma once
#include <windows.h>

class TimingCPU
{
public:
	void start() 
	{
		QueryPerformanceCounter(&m_start);
	}
	void stop()
	{
		QueryPerformanceCounter(&m_stop);
	}

	double elapsed() 
	{
		return (m_stop.QuadPart - m_start.QuadPart - m_overhead) * 1000.0 / m_freg.QuadPart;
	}
private:
	static LONGLONG GetOverhead()
	{
		TimingCPU t;
		t.start();
		t.stop();
		return t.m_stop.QuadPart - t.m_start.QuadPart;
	}

	LARGE_INTEGER m_start;
	LARGE_INTEGER m_stop;
	static LARGE_INTEGER m_freg;
	static LONGLONG m_overhead;
};

