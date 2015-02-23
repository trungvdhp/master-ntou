#pragma once
#include "TimeIntervalRecord.h"
#include "mfsputc.h"
class TimeLine
{
public:
	TimeLine();
	virtual ~TimeLine();
	TimeLine & operator = (const TimeLine til);
	vector<TimeIntervalRecord> tir;
};

