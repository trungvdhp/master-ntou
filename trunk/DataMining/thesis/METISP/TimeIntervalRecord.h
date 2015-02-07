// TimeIntervalRecord.h: interface for the TimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TIMEINTERVALRECORD_H__C6263063_131D_4D0E_B824_2E5C1456C2B7__INCLUDED_)
#define AFX_TIMEINTERVALRECORD_H__C6263063_131D_4D0E_B824_2E5C1456C2B7__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000



class TimeIntervalRecord  
{
public:
	void setValue(const int laststarttime = 0, const int lastendtime = 0);
	TimeIntervalRecord();
	virtual ~TimeIntervalRecord();
    int lastEndTime;
	int lastStartTime;
};

#endif // !defined(AFX_TIMEINTERVALRECORD_H__C6263063_131D_4D0E_B824_2E5C1456C2B7__INCLUDED_)
