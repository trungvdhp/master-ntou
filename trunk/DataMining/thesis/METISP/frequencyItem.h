// frequencyItem.h: interface for the frequencyItem class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FREQUENCYITEM_H__27684FC1_3447_405B_87C6_BE9E83D486BE__INCLUDED_)
#define AFX_FREQUENCYITEM_H__27684FC1_3447_405B_87C6_BE9E83D486BE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "TimeIntervalRecord1.h"
#include "metisp.h"
class frequencyItem  
{
public:
	
	frequencyItem();
	virtual ~frequencyItem();
	vector<int> item;
	int frequency;
	vector<TimeIntervalRecord1> pTir;
	void insertTir(int sid, int lst, int let, int & id, bool & isInit,
		const TimeIntervalRecord1 prev = TimeIntervalRecord1(), bool type = false);
	bool operator==(const frequencyItem &y);
	bool operator<(const frequencyItem &y);
private:
	TimeIntervalRecord1 * binarySearch (int sId);
};

#endif // !defined(AFX_FREQUENCYITEM_H__27684FC1_3447_405B_87C6_BE9E83D486BE__INCLUDED_)
