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

TimeIntervalRecord1 * frequencyItem::binarySearch (int sId)
{
	int left = 0;
	int right = pTir.size()-1;
	int mid = (right+left)/2;
	TimeIntervalRecord1 * it;

	while(left <= right)
	{
		mid = (right+left)/2;
		it = pTir[mid];
		if (it->sId == sId)
			return it;
		if (it->sId < sId)
			left = mid + 1;
		else if (it->sId > sId)
			right = mid - 1;
	}
	return NULL;
}

void frequencyItem::insertTir(int sid, int iniTime, int lst, int let, TimeIntervalRecord1 * pre, int id, bool isInit)
{
	TimeIntervalRecord temp;
	temp.setValue(iniTime, lst,let);
	if (!isInit)
	{
		TimeIntervalRecord1 * tir1 = new TimeIntervalRecord1();
		tir1->setValue(sid);
		tir1->tir.push_back(temp);
		tir1->prev = pre;
		pTir.push_back(tir1);
	}
	else
	{
		pTir[id]->tir.push_back(temp);
	}
	//printf("\n");
}