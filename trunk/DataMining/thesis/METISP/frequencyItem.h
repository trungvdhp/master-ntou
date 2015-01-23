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

	void insertTir(int sid, int iniTime, int lst, int let);
	frequencyItem();
	virtual ~frequencyItem();
	vector<int> item;
	int frequency;
	vector<TimeIntervalRecord1> pTir;
	bool operator==(const frequencyItem &y);
	bool operator<(const frequencyItem &y);
};

#endif // !defined(AFX_FREQUENCYITEM_H__27684FC1_3447_405B_87C6_BE9E83D486BE__INCLUDED_)
