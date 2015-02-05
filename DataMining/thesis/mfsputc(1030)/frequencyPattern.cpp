// frequencyPattern.cpp: implementation of the frequencyPattern class.
//
//////////////////////////////////////////////////////////////////////

#include "frequencyPattern.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

frequencyPattern::frequencyPattern()
{
	frequency = 0;
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
	return frequency < y.frequency;
}

void frequencyPattern::insertTir(const int sid, const int tid,const int iid, const int initialtime,const int laststarttime
	, TimeIntervalRecord1 * prev, TimeIntervalRecord1 * next, int & id, bool & isInit)
{
	TimeIntervalRecord temp;
	temp.setValue(tid, iid, initialtime, laststarttime);
	if (!isInit)
	{
		id++;
		TimeIntervalRecord1 * tir1 = new TimeIntervalRecord1();
		tir1->setValue(sid);
		tir1->tir.push_back(temp);
		if (prev != NULL && next == NULL)
			prev->next = tir1;
		tir1->prev = prev;
		tir1->next = next;
		pTir.push_back(tir1);
		frequency++;
		isInit = true;
	}
	else
	{
		pTir[id]->tir.push_back(temp);
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
	//fprintf(out,"}:%d(%d)\n",frequency,pTir.size());
	fprintf(out,"}:%d\n",frequency);

/*	vector<int> array;
	array.push_back(75);
	array.push_back(631);
	array.push_back(758);

	for (i = 0;i<array.size();i++)
	{
		if (frePattern[0].items[i] != array[i])
		{
			return;
		}
	}*/
/*	int j;
for (i = 0; i < pTir.size(); i++)
	{
		fprintf(out,"%d ",pTir[i].sId);
		for (j = 0; j <pTir[i].tir.size();j++)
		{
			fprintf(out,"( %d , %d , %d, %d)",pTir[i].tir[j].tId,pTir[i].tir[j].iId,pTir[i].tir[j].initialTime,pTir[i].tir[j].lastStartTime);
		}
		fprintf(out,"\n");
	}
	fprintf(out,"\n");*/
}

int frequencyPattern::getLastItem()
{
	return frePattern[frePattern.size()-1].items[frePattern[frePattern.size()-1].items.size()-1];
}