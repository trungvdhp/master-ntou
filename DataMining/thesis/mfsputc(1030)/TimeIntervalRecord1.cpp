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
	tir.clear();
}

void TimeIntervalRecord1::setValue(const int sid)
{
	sId = sid;
}


bool TimeIntervalRecord1::operator==(const int sid)
{
	return (sId == sid);
}