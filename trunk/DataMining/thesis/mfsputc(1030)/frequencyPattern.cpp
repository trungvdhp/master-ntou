// frequencyPattern.cpp: implementation of the frequencyPattern class.
//
//////////////////////////////////////////////////////////////////////

#include "frequencyPattern.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

frequencyPattern::frequencyPattern()
{
}

frequencyPattern::~frequencyPattern()
{
	frePattern.clear();
	pTir.clear();
}

bool frequencyPattern::operator==(const frequencyPattern y)
{
	int i,j;
	if (frePattern.size() != y.frePattern.size())
	{
		return false;
	}
	else
	{
		for (i = 0 ; i < frePattern.size() ;i++)
		{
			if (frePattern[i].items.size() != y.frePattern[i].items.size())
			{
				return false;
			}
			else
			{
				for (j = 0; j < frePattern[i].items.size(); j++)
				{
					if (frePattern[i].items[j] != y.frePattern[i].items[j])
					{
						return false;
					}
				}
			}
		}
	}
	return true;
}

bool frequencyPattern::operator<(const frequencyPattern y)
{
	return pTir.size() < y.pTir.size();
}

void frequencyPattern::insertTir(const int sid, const int tid,const int iid,const int laststarttime
	, int & id, int & isInit,const TimeIntervalRecord1 prev, bool type)
{
	TimeIntervalRecord temp;
	temp.setValue(tid, iid, laststarttime);
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
			pTir[id].til[tsize-1].tir.push_back(temp);
	}
}

void frequencyPattern::output(FILE * out)
{
	int i;
	fprintf(out,"{");
	for (i = 0; i < frePattern.size(); i++)
	{
		fprintf(out,"{");
		frePattern[i].output(out);
		fprintf(out,"}");
	}
	fprintf(out,"}:%d\n",pTir.size());
}

int frequencyPattern::getLastItem()
{
	return frePattern.back().items.back();
}