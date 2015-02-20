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

void frequencyItem::insertTir(int sid, int lst, int let, int & id, bool & isInit,
	const TimeIntervalRecord1 prev, bool type)
{
	TimeIntervalRecord temp;
	temp.setValue(lst, let);
	int tsize = prev.til.size();
	if (!isInit)
	{
		id++;
		TimeIntervalRecord1  tir1;
		tir1.setValue(sid, prev.til);
		if (!type)
		{
			TimeLine til;
			til.tir.push_back(temp);
			tir1.til.push_back(til);
		}
		else
		{
			tir1.til[tsize - 1].tir.clear();
			tir1.til[tsize - 1].tir.push_back(temp);
		}
		pTir.push_back(tir1);
		isInit = 1;
	}
	else
	{
		if (!type)
			pTir[id].til[tsize].tir.push_back(temp);
		else
			pTir[id].til[tsize - 1].tir.push_back(temp);
	}
}