// TimeIntervalRecord1.cpp: implementation of the TimeIntervalRecord1 class.
//
//////////////////////////////////////////////////////////////////////

#include "TimeIntervalRecord1.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

TimeIntervalRecord1::TimeIntervalRecord1()
{
	sId = 0;
}

TimeIntervalRecord1::~TimeIntervalRecord1()
{

}

void TimeIntervalRecord1::setValue(const int _sId, const vector<TimeLine> _til)
{
	sId = _sId;
	til = _til;
}

TimeIntervalRecord1 & TimeIntervalRecord1::operator = (const TimeIntervalRecord1 tir1)
{
	setValue(tir1.sId, tir1.til);
	return *this;
}

bool TimeIntervalRecord1::operator==(const TimeIntervalRecord1 &y)
{
	return sId == y.sId;
}

bool TimeIntervalRecord1::operator==(const int sid)
{
	return sId == sid;
}