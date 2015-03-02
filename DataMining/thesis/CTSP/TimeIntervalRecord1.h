// PTimeIntervalRecord.h: interface for the PTimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_)
#define AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "TimeLine.h"
#include "ctsp.h"

class TimeIntervalRecord1  
{
public:
	void setValue(const int & _sId, const vector<TimeLine> & _til);
	TimeIntervalRecord1();
	virtual ~TimeIntervalRecord1();
	TimeIntervalRecord1 & operator = (const TimeIntervalRecord1 & tir1);
	vector<TimeLine> til;
	int sId;
	bool operator==(const TimeIntervalRecord1 & y);
	bool operator==(const int & sid);

};

#endif // !defined(AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_)
