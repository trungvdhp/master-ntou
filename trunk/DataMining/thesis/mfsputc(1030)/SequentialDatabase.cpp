// SequentialDatabase.cpp: implementation of the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#include "SequentialDatabase.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

SequentialDatabase::SequentialDatabase(char * filename,char * outfilename)
{
	int i;
	in = fopen(filename,"rt");
	out = fopen(outfilename,"w");
	assert(in != NULL);
	assert(out != NULL);
	frequency = new int[ITEM_NO];
	for (i = 0; i < ITEM_NO; i++)
	{
		frequency[i] = 0;
	}
	//	order_index = NULL;
}

SequentialDatabase::~SequentialDatabase()
{
	sequential.clear();
	if (frequency)
		delete [] frequency;
	//	if (order_index)
	//		delete [] order_index;
	if (in)
		fclose(in);
	if (out)
		fclose(out);
}

void SequentialDatabase::execute()
{
	scanDB();
	deleteInfrequentItem();
	//	generateL1PTir(newFrequentSequence);
	//	generateUpdateL(newFrequentSequence);
}

bool SequentialDatabase::FEPValid(frequencyPattern p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2)
{
	int sid, tid, lst, it, iid;
	int iniTime;
	int i, j, k, h, x;
	int * Stemp1Index, *Stemp2Index;
	bool * Stemp1Init, *Stemp2Init;
	Stemp1Index = new int[ITEM_NO];
	Stemp2Index = new int[ITEM_NO];
	Stemp1Init = new bool[ITEM_NO];
	Stemp2Init = new bool[ITEM_NO];
	for (i = 0; i < ITEM_NO; i++)
	{
		Stemp1Index[i] = -1;
		Stemp2Index[i] = -1;
	}
	vector<int> svtType1, svtType2;

	Element newElement;
	frequencyPattern newFrequencyPattern;
	newElement.items.push_back(0);
	newFrequencyPattern.frequency = 0;
	newFrequencyPattern.frePattern.push_back(newElement);
	for (i = 0; i < p.pTir.size(); i++) //(2)
	{
		for (j = 0; j < ITEM_NO; j++)
		{
			Stemp1Init[j] = false;
			Stemp2Init[j] = false;
		}
		for (j = 0; j < p.pTir[i]->tir.size(); j++)
		{
			sid = p.pTir[i]->sId;
			tid = p.pTir[i]->tir[j].tId;
			lst = p.pTir[i]->tir[j].lastStartTime;
			it = p.pTir[i]->tir[j].initialTime;
			iid = p.pTir[i]->tir[j].iId;
			//use the corresponding time index to determine the VTPs for type-1 patterns.
			svtType1 = generateSVTType1(tid, it, lst, sequential[sid].transaction);
			for (k = 0; k < svtType1.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
				for (h = 0; h < sequential[sid].transaction[svtType1[k]].element.items.size(); h++)
				{
					x = sequential[sid].transaction[svtType1[k]].element.items[h];
					if (Stemp1Index[x] == -1)
					{
						newFrequencyPattern.frequency = 0;
						newFrequencyPattern.frePattern[0].items[0] = x;
						newFrequencyPattern.insertTir(sid, svtType1[k], h, it, iniTime
							, p.pTir[i], NULL, Stemp1Index[x], Stemp1Init[x]);

						Stemp1.push_back(newFrequencyPattern);

						newFrequencyPattern.frequency = 0;
						newFrequencyPattern.pTir.clear();
					}
					else
					{
						Stemp1[Stemp1Index[x]].insertTir(sid, svtType1[k], h, it, iniTime
							, p.pTir[i], NULL, Stemp1Index[x], Stemp1Init[x]);
					}
				}
			}
			svtType1.clear();

			svtType2 = generateSVTType2(tid, it, lst, sequential[sid].transaction);
			for (k = 0; k < svtType2.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;
				//(2.1.4.1)
				if (svtType2[k] == tid)
				{
					for (h = iid + 1; h < sequential[sid].transaction[tid].element.items.size(); h++)
					{
						x = sequential[sid].transaction[tid].element.items[h];
						if (p.getLastItem() < x)
						{
							if (Stemp2Index[x] == -1)
							{
								newFrequencyPattern.frequency = 0;
								newFrequencyPattern.frePattern[0].items[0] = x;

								if (it < iniTime)
									newFrequencyPattern.insertTir(sid, svtType2[k], h, it, iniTime
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								else
									newFrequencyPattern.insertTir(sid, tid, iid, iniTime, it
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								Stemp2.push_back(newFrequencyPattern);

								newFrequencyPattern.pTir.clear();
								newFrequencyPattern.frequency = 0;
							}
							else
							{
								Stemp2[Stemp2Index[x]].insertTir(sid, svtType2[k], h, it, iniTime
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
							}
						}

					}
				}
				else //(2.1.4.2)
				{
					for (h = 0; h < sequential[sid].transaction[svtType2[k]].element.items.size(); h++)
					{
						x = sequential[sid].transaction[svtType2[k]].element.items[h];
						if (p.getLastItem() < x)
						{
							if (Stemp2Index[x] == -1)
							{
								newFrequencyPattern.frequency = 0;
								newFrequencyPattern.frePattern[0].items[0] = x;
								if (it < iniTime)
									newFrequencyPattern.insertTir(sid, svtType2[k], h, it, iniTime
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								else
								{
									newFrequencyPattern.insertTir(sid, tid, iid, iniTime, iniTime
										, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								}

								Stemp2.push_back(newFrequencyPattern);

								newFrequencyPattern.frequency = 0;
								newFrequencyPattern.pTir.clear();
							}
							else
							{
								if (it < iniTime)
									Stemp2[Stemp2Index[x]].insertTir(sid, svtType2[k], h, it, iniTime
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								else
								{
									Stemp2[Stemp2Index[x]].insertTir(sid, tid, iid, iniTime, iniTime
										, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								}
							}
						}

					}
				}

			}
			svtType2.clear();
		}
	}
	delete[] Stemp1Index;
	delete[] Stemp2Index;
	delete[] Stemp1Init;
	delete[] Stemp2Init;

	for (i = 0; i < Stemp1.size(); i++)
		if (Stemp1[i].frequency == p.frequency)
			return false;
	for (i = 0; i < Stemp2.size(); i++)
		if (Stemp2[i].frequency == p.frequency)
			return false;
	return true;
}

void SequentialDatabase::patternGenerationAlgorithm(frequencyPattern p)
{
//	p.output(out);
	int i;
	frequencyPattern p_;
	vector<frequencyPattern> Stemp1, Stemp2;
	bool f = FEPValid(p, Stemp1, Stemp2);
	if (f)
	{
		p.output(out);
	}
	for (i = 0; i < Stemp1.size(); i++)
	{
		if (Stemp1[i].frequency >= THRESHOLD)
		{
			p_ = updateType1Pattern(p, Stemp1[i]);
			patternGenerationAlgorithm(p_);
		}
	}
	Stemp1.clear();
	for (i = 0; i < Stemp2.size(); i++)
	{
		if (Stemp2[i].frequency >= THRESHOLD)
		{
			p_ = updateType2Pattern(p, Stemp2[i]);
			patternGenerationAlgorithm(p_);
		}
	}
	Stemp2.clear();
}

void SequentialDatabase::scanDB()
{
	int temp = 0;
	char c;
	int item, pos;
	
	int net_itemno = 0,k;
	
	set<int> oneSeqItem;
	set<int>::iterator iterSet;
	while (!feof(in))
	{
		Sequential data;
		Transaction tranData;
		do {
			item=0;
			pos=0;
			c = getc(in);
			if ( c == '{')
			{
				temp++;
			}
			else if (c == '}')
			{
				temp--;
			}
			if (c != '{' && c != '}')
			{
				while ((c >= '0') && ( c <= '9'))
				{
					item *= 10;
					item += int(c)-int('0');
					c = getc(in);
					pos++;
				}
				if (temp == 1)
				{
					if (pos)
					{
						tranData.setTimeOcc(item);
					}
				}
				else
				{
					if (pos)
					{
						oneSeqItem.insert(item);
						tranData.insertItem(item);
					}
				}
				if (c == '{')
				{
					temp++;
				}
				else if (c == '}')
				{
					temp--;
					data.transaction.push_back(tranData);
					tranData.element.items.clear();
				}
			}
		}while(c != '\n' && !feof(in));
		sequential.push_back(data);
		data.transaction.clear();
		for (iterSet = oneSeqItem.begin();iterSet != oneSeqItem.end();iterSet++)
		{
			if (*iterSet >= ITEM_NO)
			{
				int* temp = new int[2*(*iterSet)];
				for(k=0; k<=net_itemno; k++)
					temp[k] = frequency[k];
				for(; k<ITEM_NO; k++)
					temp[k] = 0;
				delete []frequency;
				frequency=temp;
				net_itemno=*iterSet;
			}
			else if(net_itemno < *iterSet)
			{
				net_itemno = *iterSet;
			}
			frequency[*iterSet]++;
		}
		oneSeqItem.clear();
	}
	ITEM_NO = net_itemno + 1;
	// if end of file is reached, rewind to beginning for next pass
	if(feof(in)){
		rewind(in);
		sequential.pop_back();
	}
}

void SequentialDatabase::deleteInfrequentItem()
{
	THRESHOLD = min_sup * sequential.size();
	int i,j;
	
	vector<int>::iterator iter;
	
	// delete infrequentItem from sequential variable
	for (i = 0; i < sequential.size(); i++)
	{
		for (j = 0; j < sequential[i].transaction.size(); j++)
		{
			iter = sequential[i].transaction[j].element.items.begin();
			while (iter != sequential[i].transaction[j].element.items.end())
				if (frequency[*iter] < THRESHOLD)
					iter = sequential[i].transaction[j].element.items.erase(iter);
				else ++iter;
		}
	}
	
	vector<Transaction>::iterator iterTrans;
	for (i = 0 ; i < sequential.size();i++)
	{
		sequential[i].transaction.erase(
			std::remove_if(sequential[i].transaction.begin(),
			sequential[i].transaction.end(), [](Transaction trans){ return trans.element.items.size() == 0;}),
			sequential[i].transaction.end());
	}
	//	order_index = new int[ITEM_NO];
	Element newElement;
	frequencyPattern newFrequencyPattern;
	newElement.items.push_back(1) ;
	newFrequencyPattern.frePattern.push_back(newElement);
	
	for (i = 0 ; i < ITEM_NO ; i++)
	{
		if (frequency[i] >= THRESHOLD)
		{
			newFrequencyPattern.frePattern[0].items[0] = i;
			
			generatePTir(newFrequencyPattern);
			newFrequencyPattern.frequency = frequency[i];
			patternGenerationAlgorithm(newFrequencyPattern);
		
			newFrequencyPattern.frequency = 0;
			newFrequencyPattern.pTir.clear();
		}
	}
	delete [] frequency;
	frequency = NULL;
}

int SequentialDatabase::binarySearch(vector<int> data,int search)
{
	int low = 0;
    int high = data.size()-1;
	
    while (low <= high)
    {
        int mid = (low + high) / 2;
		
        if (data[mid] == search)
        {
            return mid;
        }
        else if (data[mid] > search)
        {
            high = mid - 1;
        }
        else if (data[mid] < search)
        {
            low = mid + 1;
        }
    }
	return -1;
}

void SequentialDatabase::generatePTir(frequencyPattern & p)
{
	int sid,tid,iid,iniTime;
	int i = p.frePattern[0].items[0];
	vector<int>::iterator iter;
	bool isInit;
	int lastId = -1;
	for (sid = 0; sid < sequential.size();sid++)
	{
		isInit = false;
		for (tid = 0 ; tid < sequential[sid].transaction.size() ; tid++ )
		{
			iter = find(sequential[sid].transaction[tid].element.items.begin(),sequential[sid].transaction[tid].element.items.end(),i);
			if (iter != sequential[sid].transaction[tid].element.items.end())
			{
				iid = binarySearch(sequential[sid].transaction[tid].element.items,i);
				iniTime = sequential[sid].transaction[tid].timeOcc;
				p.insertTir(sid,tid,iid,iniTime,iniTime, NULL, NULL, lastId, isInit);
			}
		}
	}
	
}

bool SequentialDatabase::generateSVT(int tid,int it,int lst, vector<Transaction> trans, int x)
{
	int i,j,ub,lb;
	lb = trans[tid].timeOcc + mingap;
	ub = lst + maxgap;
	for (i = tid+1 ; i < trans.size() ; i++)
	{
		if (lb <= trans[i].timeOcc && trans[i].timeOcc <= ub )
		{
			return true;
		}
		else if (trans[i].timeOcc > ub)
		{
			break;
		}
	}
	lb = trans[tid].timeOcc - swin;
	ub = lst + swin;
	for (i = tid > 0? tid -1 : 0 ; i < trans.size() ; i++)
	{
		if (lb <= trans[i].timeOcc && trans[i].timeOcc <= ub )
		{
			for (j = 0; j < trans[i].element.items.size() ;j++)
			{
				if (trans[i].element.items[j] > x)
					return true;
			}
		}
		else if (trans[i].timeOcc > ub)
		{
			return false;
		}
	}
	return false;
}

bool SequentialDatabase::isLastItem(int sid, int tid, int iid)
{
	return (sequential[sid].transaction[tid].element.items.size()-1 == iid);
}

vector<int> SequentialDatabase::generateSVTType1(int tid, int it, int lst,vector<Transaction> trans)
{
	vector<int> temp;
	int i,ub,lb;
	lb = trans[tid].timeOcc + mingap;
	ub = lst + maxgap;
	for (i = tid+1 ; i < trans.size() ; i++)
	{
		if (lb <= trans[i].timeOcc && trans[i].timeOcc <= ub)
		{
			temp.push_back(i);
		}
		else if (trans[i].timeOcc > ub)
		{
			break;
		}
	}
	return temp;

}

vector<int> SequentialDatabase::generateSVTType1(TimeIntervalRecord1 tir1,vector<Transaction> trans)
{
	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub,lb,x;
	int tid;
	for (i = 0; i < tir1.tir.size(); i++)
	{
		tid = tir1.tir[i].tId;
		lb = trans[tid].timeOcc + mingap;
		ub = tir1.tir[i].lastStartTime + maxgap;
		for (j = tid+1; j < trans.size() ; j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub )
			{
				for (k = 0; k < sequential[tir1.sId].transaction[j].element.items.size(); k++)
				{
					x = sequential[tir1.sId].transaction[j].element.items[k];
					iter = find(temp.begin(),temp.end(),x);
					if (iter == temp.end())
					{
						temp.push_back(x);
					}
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateSVTType2(int tid, int it, int lst,vector<Transaction> trans)
{
	vector<int> temp;
	int i,ub,lb;
	lb = trans[tid].timeOcc - swin;
	ub = lst + swin;
	for (i = 0 ; i < trans.size() ; i++)
	{
		if (lb <= trans[i].timeOcc && trans[i].timeOcc <= ub)
		{
			temp.push_back(i);
		}
		else if (trans[i].timeOcc > ub)
		{
			break;
		}
	}

	return temp;
}

vector<int> SequentialDatabase::generateSVTType2(TimeIntervalRecord1 tir1,vector<Transaction> trans)
{
	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub,lb,x;
	int tid;
	for (i = 0; i < tir1.tir.size(); i++)
	{
		tid = tir1.tir[i].tId;
		lb = trans[tid].timeOcc -swin;
		ub = tir1.tir[i].lastStartTime + swin;
		for (j =  0; j < trans.size() ; j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub )
			{
				for (k = 0; k < sequential[tir1.sId].transaction[j].element.items.size(); k++)
				{
					x = sequential[tir1.sId].transaction[j].element.items[k];
					iter = find(temp.begin(),temp.end(),x);
					if (iter == temp.end())
					{
						temp.push_back(x);
					}
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}
	}
	return temp;
}

frequencyPattern SequentialDatabase::updateType1Pattern(frequencyPattern p,frequencyPattern x)
{
	int addx = x.getLastItem();
	Element newElement;
	int i ;
	x.frePattern.clear();
	for (i = 0; i < p.frePattern.size(); i++)
	{
		x.frePattern.push_back(p.frePattern[i]);
	}
	newElement.items.push_back(addx);
	x.frePattern.push_back(newElement);
	return x;
}

frequencyPattern SequentialDatabase::updateType2Pattern(frequencyPattern p,frequencyPattern x)
{
	int addx = x.getLastItem();
	int i ;
	x.frePattern.clear();
	for (i = 0; i < p.frePattern.size(); i++)
	{
		x.frePattern.push_back(p.frePattern[i]);
	}
	i = x.frePattern.size() - 1;
	x.frePattern[i].items.push_back(addx);
	return x;
}