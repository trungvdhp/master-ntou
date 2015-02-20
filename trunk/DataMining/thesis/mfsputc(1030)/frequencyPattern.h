// frequencyPattern.h: interface for the frequencyPattern class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FREQUENCYPATTERN_H__06799CE0_01DF_4C6A_BEC6_983BF288CB90__INCLUDED_)
#define AFX_FREQUENCYPATTERN_H__06799CE0_01DF_4C6A_BEC6_983BF288CB90__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "Element.h"
#include "TimeIntervalRecord1.h"
class frequencyPattern  
{
public:
	void insertTir(const int sid, const int tid,const int iid,const int laststarttime
		, int & id, int & isInit, const TimeIntervalRecord1 prev = TimeIntervalRecord1(), bool type=false);
	frequencyPattern();
	virtual ~frequencyPattern();
	vector<Element> frePattern;
	vector<TimeIntervalRecord1> pTir;
	bool operator==(const frequencyPattern y);
	bool operator<(const frequencyPattern y);
	void output(FILE * out);
	int getLastItem();
};

#endif // !defined(AFX_FREQUENCYPATTERN_H__06799CE0_01DF_4C6A_BEC6_983BF288CB90__INCLUDED_)
