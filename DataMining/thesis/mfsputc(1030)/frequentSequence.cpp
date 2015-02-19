// frequentSequence.cpp: implementation of the frequentSequence class.
//
//////////////////////////////////////////////////////////////////////

#include "frequentSequence.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

frequentSequence::frequentSequence()
{

}

frequentSequence::~frequentSequence()
{
	_frequentSequency.clear();
}

void frequentSequence::output(FILE * out)
{
	int i , j;
	for (i = 0; i < _frequentSequency.size(); i++)
	{
		fprintf(out,"{");
		for (j = 0; j < _frequentSequency[i].frePattern.size(); j++)
		{
			fprintf(out,"{");
			_frequentSequency[i].frePattern[j].output(out);
			fprintf(out,"}");
		}
		fprintf(out,"}:%d(%d)\n",_frequentSequency[i].pTir.size());
		
	}
}
