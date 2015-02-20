#pragma once
#include "TimeIntervalRecord.h"
#include "mfsputc.h"
class TimeLine
{
public:
	TimeLine();
	virtual ~TimeLine();
	vector<TimeIntervalRecord> tir;
	TimeLine & operator = (const TimeLine til);
};

