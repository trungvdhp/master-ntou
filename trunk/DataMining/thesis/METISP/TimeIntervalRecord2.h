#pragma once
#include "TimeIntervalRecord.h"
#include "metisp.h"
class TimeIntervalRecord2
{
public:
	TimeIntervalRecord2(void);
	TimeIntervalRecord tir;
	vector<TimeIntervalRecord2*> prevTirs;
	virtual ~TimeIntervalRecord2(void);
};

