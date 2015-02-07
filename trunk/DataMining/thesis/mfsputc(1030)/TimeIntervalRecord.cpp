// TimeIntervalRecord.cpp: implementation of the TimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#include "TimeIntervalRecord.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

TimeIntervalRecord::TimeIntervalRecord()
{
	iId = 0;
	lastStartTime = 0;
	tId = 0;
}

TimeIntervalRecord::~TimeIntervalRecord()
{

}
void TimeIntervalRecord::setValue(const int tid,const int iid,const int laststarttime)
{
	iId = iid;
	lastStartTime = laststarttime;
	tId = tid;
}