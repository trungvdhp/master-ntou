// TimeIntervalRecord.h: interface for the TimeIntervalRecord class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TIMEINTERVALRECORD_H__3919ED56_F158_48EB_A807_E8556789C6DE__INCLUDED_)
#define AFX_TIMEINTERVALRECORD_H__3919ED56_F158_48EB_A807_E8556789C6DE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class TimeIntervalRecord  
{
public:
	void setValue(const int tid = 0,const int iid= 0,const int laststarttime= 0);
	TimeIntervalRecord();
	virtual ~TimeIntervalRecord();
	int tId;
	int iId;
	int lastStartTime;
};

#endif // !defined(AFX_TIMEINTERVALRECORD_H__3919ED56_F158_48EB_A807_E8556789C6DE__INCLUDED_)
