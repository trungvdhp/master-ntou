#pragma once
#include "TimeIntervalRecord.h"
#include "ctsp.h"
class TimeLine
{
public:
	TimeLine();
	virtual ~TimeLine();
	vector<TimeIntervalRecord> tir;
	TimeLine & operator = (const TimeLine & til);
};

