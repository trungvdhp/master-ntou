// TimeIntervalRecord.cpp: implementation of the TimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#include "TimeIntervalRecord.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

TimeIntervalRecord::TimeIntervalRecord()
{
	initialTime = 0;
	lastEndTime = 0;
	lastStartTime = 0;
}

TimeIntervalRecord::~TimeIntervalRecord()
{

}

void TimeIntervalRecord::setValue(const int initialtime, const int laststarttime, const int lastendtime)
{
	initialTime = initialtime;
	lastEndTime = lastendtime;
	lastStartTime = laststarttime;
}
