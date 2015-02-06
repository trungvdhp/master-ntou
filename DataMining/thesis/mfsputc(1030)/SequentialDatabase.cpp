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
}

bool SequentialDatabase::BEPValid(frequencyPattern p)
{
	int sid, tid, lst, it, iid;
	int iniTime;
	int i, j, k, h, x;
	int * Stemp1Frequency, *Stemp2Frequency;
	bool * Stemp1Init, *Stemp2Init;

	int size;
	int count=0;
	vector<TimeIntervalRecord1 *> temp;
	size = p.pTir.size();
	for (i = 0; i < size; i++)
	{
		temp.push_back(p.pTir[i]);
	}
	vector<Element>::iterator ip = p.frePattern.end();
	Stemp1Frequency = new int[ITEM_NO];
	Stemp2Frequency = new int[ITEM_NO];
	Stemp1Init = new bool[ITEM_NO];
	Stemp2Init = new bool[ITEM_NO];
	vector<int> svtType1, svtType2;
	bool prevValid, nextValid;
	int start, end;
	while(true)
	{
		if(count==size) break;
		ip--;
		for (i = 0; i < ITEM_NO; i++)
		{
			Stemp1Frequency[i] = false;
			Stemp2Frequency[i] = false;
		}
		for (i = 0; i < size; i++)
		{
			for (j = 0; j < ITEM_NO; j++)
			{
				Stemp1Init[j] = false;
				Stemp2Init[j] = false;
			}
			for (j = 0; j < temp[i]->tir.size(); j++)
			{
				sid = temp[i]->sId;
				tid = temp[i]->tir[j].tId;
				lst = temp[i]->tir[j].lastStartTime;
				it = temp[i]->tir[j].initialTime;
				iid = temp[i]->tir[j].iId;
				if(temp[i]->prev == NULL)
				{
					svtType1 = generateBEPType1(tid, it, lst, sequential[sid].transaction);
					for (k = 0; k < svtType1.size(); k++)
					{
						iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
						for (h = 0; h < sequential[sid].transaction[svtType1[k]].element.items.size(); h++)
						{
							x = sequential[sid].transaction[svtType1[k]].element.items[h];
							if (Stemp1Init[x] == false)
							{
								Stemp1Frequency[x]++;
								Stemp1Init[x] = true;
							}
						}
					}
					svtType1.clear();
				}

				svtType2 = generateBEPType2(tid, it, lst, sequential[sid].transaction);
				for (k = 0; k < svtType2.size(); k++)
				{
					iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;

					for (h = 0; h < sequential[sid].transaction[svtType2[k]].element.items.size(); h++)
					{
						x = sequential[sid].transaction[svtType2[k]].element.items[h];
						if (iniTime <= lst)
						{
							start = iniTime;
							end = lst;
						}
						else if (iniTime >= sequential[sid].transaction[tid].timeOcc)
						{
							start = lst;
							end = iniTime;
						}
						prevValid = false;
						if (tir1->prev != NULL)
						{
							for (k = 0; k < tir1->prev->tir.size(); k++)
							{
								if (end - tir1->prev->tir[k].lastStartTime <= maxgap &&
									start - tir1->prev->tir[k].lastEndTime >= mingap)
								{
									prevValid = true;
									break;
								}
							}
						}
						else
							prevValid = true;
						nextValid = false;
						if (prevValid && tir1->next != NULL)
						{
							for (k = 0; k < tir1->next->tir.size(); k++)
							{
								if (tir1->next->tir[k].lastEndTime - start <= maxgap &&
									tir1->next->tir[k].lastStartTime - end >= mingap)
								{
									nextValid = true;
									break;
								}
							}
						}
						else
							nextValid = true;
						if (ip->items.back() < x || ip->items.front() > x)
						{
							if (Stemp2Init[x] == false)
							{
								Stemp2Frequency[x]++;
								Stemp2Init[x] = true;
							}
						}
					}

				}
				svtType2.clear();
			}
			temp[i] = temp[i]->prev;
			if(temp[i] == NULL) count++;
		}

		for (i = 0; i < ITEM_NO; i++)
			if (Stemp1Frequency[i] == p.frequency)
				return false;
		for (i = 0; i < ITEM_NO; i++)
			if (Stemp2Frequency[i] == p.frequency)
				return false;
	}
	return true;
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
			svtType1 = generateFEPType1(tid, it, lst, sequential[sid].transaction);
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
						Stemp1[Stemp1Index[x]].insertTir(sid, svtType1[k], h, it, iniTime
							, p.pTir[i], NULL, Stemp1Index[x], Stemp1Init[x]);
				}
			}
			svtType1.clear();

			svtType2 = generateFEPType2(tid, it, lst, sequential[sid].transaction);
			for (k = 0; k < svtType2.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;
				if (svtType2[k] == tid)
					h = iid + 1;
				else
					h = 0;
				for (; h < sequential[sid].transaction[svtType2[k]].element.items.size(); h++)
				{
					x = sequential[sid].transaction[svtType2[k]].element.items[h];
					if (p.getLastItem() < x)
					{
						if (Stemp2Index[x] == -1)
						{
							newFrequencyPattern.frequency = 0;
							newFrequencyPattern.frePattern[0].items[0] = x;

							if (it <= iniTime)
								newFrequencyPattern.insertTir(sid, svtType2[k], h, it, lst
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
							else
								newFrequencyPattern.insertTir(sid, tid, iid, iniTime, iniTime
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
								
							Stemp2.push_back(newFrequencyPattern);
							newFrequencyPattern.pTir.clear();
						}
						else
						{
							if (it <= iniTime)
								Stemp2[Stemp2Index[x]].insertTir(sid, svtType2[k], h, it, lst
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
							else
								Stemp2[Stemp2Index[x]].insertTir(sid, tid, iid, iniTime, iniTime
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2Index[x], Stemp2Init[x]);
						}
					}
				}

			}
			svtType2.clear();
		}
	}
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
	
	//vector<Transaction>::iterator iterTrans;
	for (i = 0 ; i < sequential.size(); i++)
	{
		sequential[i].transaction.erase(
			std::remove_if(sequential[i].transaction.begin(),
			sequential[i].transaction.end(), [](Transaction trans){ return trans.element.items.size() == 0;}),
			sequential[i].transaction.end());
	}
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
	for (sid = 0; sid < sequential.size(); sid++)
	{
		isInit = false;
		for (tid = 0 ; tid < sequential[sid].transaction.size() ; tid++ )
		{
			//iter = find(sequential[sid].transaction[tid].element.items.begin(),sequential[sid].transaction[tid].element.items.end(),i);
			//if (iter != sequential[sid].transaction[tid].element.items.end())
			//{
			iid = binarySearch(sequential[sid].transaction[tid].element.items,i);
			if (iid != -1)
			{
				iniTime = sequential[sid].transaction[tid].timeOcc;
				p.insertTir(sid, tid, iid, iniTime, iniTime, NULL, NULL, lastId, isInit);
			}
			//}
		}
	}
	
}

vector<int> SequentialDatabase::generateFEPType1(int tid, int it, int lst,vector<Transaction> trans)
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

vector<int> SequentialDatabase::generateFEPType2(int tid, int it, int lst,vector<Transaction> trans)
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

vector<int> SequentialDatabase::generateBEPType1(int tid, int it, int lst,vector<Transaction> trans)
{
	vector<int> temp;
	int i,ub,lb;
	lb = trans[tid].timeOcc - maxgap;
	ub = lst - mingap;
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

vector<int> SequentialDatabase::generateBEPType2(int tid, int it, int lst,vector<Transaction> trans)
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