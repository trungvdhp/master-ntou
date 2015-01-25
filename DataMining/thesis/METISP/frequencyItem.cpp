// frequencyItem.cpp: implementation of the frequencyItem class.
//
//////////////////////////////////////////////////////////////////////

#include "frequencyItem.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

frequencyItem::frequencyItem()
{
	frequency = 0;
}

frequencyItem::~frequencyItem()
{

}
bool frequencyItem::operator<(const frequencyItem &y)
{
	return frequency < y.frequency;
}
bool frequencyItem::operator==(const frequencyItem &y)
{
	int i , flag = 1; // false 0 true 1
	if (item.size() != y.item.size())
		return false;
	for (i = 0 ; i < item.size();i++)
	{
		if (item[i] != y.item[i])
		{
			return false;
		}
	}
	return true;
}

void frequencyItem::insertTir(int sid, int iniTime, int lst, int let)
{
	vector<TimeIntervalRecord1>::iterator iter;
	iter = find(pTir.begin(),pTir.end(),sid);
	TimeIntervalRecord temp;
	temp.setValue(iniTime, lst,let);
	TimeIntervalRecord2 * tir2 = new TimeIntervalRecord2();
	tir2->tir.setValue(iniTime, lst, let);
	if (iter == pTir.end())
	{
		TimeIntervalRecord1 tir1;
		tir1.setValue(sid);
		tir1.tir.push_back(temp);
		tir1.til.push_back(tir2);
		pTir.push_back(tir1);
	}
	else
	{
		(*iter).tir.push_back(temp);
		(*iter).til.push_back(tir2);
	}
}

void frequencyItem::insertTir(int sid, int iniTime, int lst, int let, vector<TimeIntervalRecord2*> pre)
{
	vector<TimeIntervalRecord1>::iterator iter;
	iter = find(pTir.begin(),pTir.end(),sid);
	TimeIntervalRecord temp;
	temp.setValue(iniTime, lst,let);
	TimeIntervalRecord2 * tir2 = new TimeIntervalRecord2();
	tir2->tir.setValue(iniTime, lst, let);
	tir2->prevTirs = pre;
	if (iter == pTir.end())
	{
		TimeIntervalRecord1 tir1;
		tir1.setValue(sid);
		tir1.tir.push_back(temp);
		tir1.til.push_back(tir2);
		pTir.push_back(tir1);
	}
	else
	{
		(*iter).tir.push_back(temp);
		(*iter).til.push_back(tir2);
	}
}