#include "TimeLine.h"


TimeLine::TimeLine()
{
}


TimeLine::~TimeLine()
{
	vector<TimeIntervalRecord>().swap(tir);
}
