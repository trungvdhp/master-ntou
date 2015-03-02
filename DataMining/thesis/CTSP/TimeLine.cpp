#include "TimeLine.h"


TimeLine::TimeLine()
{
}

TimeLine::~TimeLine()
{
	//vector<TimeIntervalRecord>().swap(tir);
}

TimeLine & TimeLine::operator=(const TimeLine & til)
{
	tir = til.tir;
	return *this;
}