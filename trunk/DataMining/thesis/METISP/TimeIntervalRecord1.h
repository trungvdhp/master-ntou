// PTimeIntervalRecord.h: interface for the PTimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_)
#define AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "TimeIntervalRecord.h"
#include "TimeIntervalRecord2.h"
#include "metisp.h"

class TimeIntervalRecord1  
{
public:
	void setValue(const int sid = 0);
	TimeIntervalRecord1();
	virtual ~TimeIntervalRecord1();
	vector<TimeIntervalRecord> tir;
	vector<TimeIntervalRecord2*> til;
	int sId;
	bool operator==(const TimeIntervalRecord1 &y);
	bool operator==(const int sid);

};

#endif // !defined(AFX_PTIMEINTERVALRECORD_H__99BED73B_A27A_4138_B17D_33A3358834CE__INCLUDED_)
