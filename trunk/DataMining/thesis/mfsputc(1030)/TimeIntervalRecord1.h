// TimeIntervalRecord1.h: interface for the TimeIntervalRecord1 class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_)
#define AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "TimeLine.h"
#include "mfsputc.h"
class TimeIntervalRecord1  
{
public:
	TimeIntervalRecord1();
	virtual ~TimeIntervalRecord1();
	TimeIntervalRecord1 & operator = (const TimeIntervalRecord1 tir1);
	void setValue(const int sid = 0, const vector<TimeLine> til=vector<TimeLine>());
	bool operator==(const int sid);
	
	int sId;
	vector<TimeLine> til;
};

#endif // !defined(AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_)
