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

void frequencyItem::insertTir(int sid, int lst,int let)
{
	vector<TimeIntervalRecord1>::iterator iter;
	iter = find(pTir.begin(),pTir.end(),sid);
	if (iter == pTir.end())
	{
		TimeIntervalRecord1 tir1;
		TimeIntervalRecord temp;
		tir1.setValue(sid);
		temp.setValue(lst,let);
		tir1.tir.push_back(temp);
		pTir.push_back(tir1);
	}
	else
	{
		TimeIntervalRecord temp;
		temp.setValue(lst,let);
		(*iter).tir.push_back(temp);
	}
}
