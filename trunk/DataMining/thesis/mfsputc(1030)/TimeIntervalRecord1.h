// TimeIntervalRecord1.h: interface for the TimeIntervalRecord1 class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_)
#define AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "TimeIntervalRecord.h"
#include "mfsputc.h"
class TimeIntervalRecord1  
{
public:
	TimeIntervalRecord1();
	virtual ~TimeIntervalRecord1();

	void setValue(const int sid = 0);
	bool operator==(const int sid);
	
	int sId;
	TimeIntervalRecord1 * prev;
	TimeIntervalRecord1 * next;
	vector<TimeIntervalRecord> tir;
	
};

#endif // !defined(AFX_TIMEINTERVALRECORD1_H__9BD14053_9400_4D2D_A24B_639CF33DFEEB__INCLUDED_)
