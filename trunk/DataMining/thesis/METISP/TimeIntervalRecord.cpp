// TimeIntervalRecord.cpp: implementation of the TimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#include "TimeIntervalRecord.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

TimeIntervalRecord::TimeIntervalRecord()
{
	lastEndTime = 0;
	lastStartTime = 0;
}

TimeIntervalRecord::~TimeIntervalRecord()
{

}

void TimeIntervalRecord::setValue(const int laststarttime,const int lastendtime)
{
	lastEndTime = lastendtime;
	lastStartTime = laststarttime;
}
