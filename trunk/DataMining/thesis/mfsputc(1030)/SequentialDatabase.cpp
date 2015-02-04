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
						Stemp1Index[x] = Stemp1.size() - 1;

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
								Stemp2Index[x] = Stemp2.size() - 1;

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
								//newFrequencyPattern.insertTir(sid,tid,iid,iniTime,it);

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
								//		Stemp2[Stemp2Index[x]].insertTir(sid,tid,iid,iniTime,it);
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
		//p.output(out);
	}
	for (i = 0; i < Stemp1.size();i++)
	{
		if (Stemp1[i].frequency >= THRESHOLD)
		{
			p_ = updateType1Pattern(p,Stemp1[i]);
			patternGenerationAlgorithm(p_);
		}
	}
	Stemp1.clear();
	for (i = 0; i < Stemp2.size();i++)
	{
		if (Stemp2[i].frequency >= THRESHOLD)
		{
			p_ = updateType2Pattern(p,Stemp2[i]);
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
			for (iter = sequential[i].transaction[j].element.items.begin();iter < sequential[i].transaction[j].element.items.end(); iter++)
			{
				if (frequency[*iter] < THRESHOLD)
				{
					sequential[i].transaction[j].element.items.erase(iter);
				}
			}
		}
	}
	
	vector<Transaction>::iterator iterTrans;
	for (i = 0 ; i < sequential.size();i++)
	{
		for (iterTrans = sequential[i].transaction.begin();iterTrans < sequential[i].transaction.end();iterTrans++)
		{
			if ((*iterTrans).element.items.size() == 0)
			{
				sequential[i].transaction.erase(iterTrans);
			}
		}
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
			
			//newFrequencyPattern.frequency = frequency[i];
			newFrequencyPattern.frePattern[0].items[0] = i;
			
			generatePTir(newFrequencyPattern);
			newFrequencyPattern.frequency = frequency[i];
			patternGenerationAlgorithm(newFrequencyPattern);
		
			newFrequencyPattern.frequency = 0;
			newFrequencyPattern.pTir.clear();
			//			order_index[i] = j++;
			
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
			//else
			//{
			//	p.FrequencyAdd(sid);
			//}
			//}
		}
			/*iter = find(sequential[sid].transaction[tid].element.items.begin(),sequential[sid].transaction[tid].element.items.end(),i);
			if (iter != sequential[sid].transaction[tid].element.items.end())
			{
				iid = binarySearch(sequential[sid].transaction[tid].element.items,i);
				iniTime = sequential[sid].transaction[tid].timeOcc;
				if (!isLastItem(sid,tid,iid))
				{
					p.insertTir(sid,tid,iid,iniTime,iniTime);
				}
			}*/
	}
	
}

bool SequentialDatabase::generateSVT(int tid,int it,int lst, vector<Transaction> trans, int x)
{
	int i,j,ub,lb;
	lb = trans[tid].timeOcc + mingap;
	if (lst + maxgap < it + dun)
		ub = lst + maxgap;
	else
		ub = it + dun;
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
	if ( lst + swin < it + dun)
		ub = lst + swin;
	else
		ub = it + dun;
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
	if (lst + maxgap < it + dun)
		ub = lst + maxgap;
	else
		ub = it + dun;
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
		if (tir1.tir[i].lastStartTime + maxgap < tir1.tir[i].initialTime + dun)
			ub = tir1.tir[i].lastStartTime + maxgap;
		else
			ub = tir1.tir[i].initialTime + dun;
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
	if (lst + swin < it + dun)
		ub = lst + swin;
	else
		ub = it + dun;
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
		if (tir1.tir[i].lastStartTime + swin < tir1.tir[i].initialTime + dun)
			ub = tir1.tir[i].lastStartTime + swin;
		else
			ub = tir1.tir[i].initialTime + dun;
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

/*
frequencyPattern SequentialDatabase::updateType1Pattern(frequencyPattern p,frequencyPattern x)
{
	frequencyPattern p_;
	Element newElement;
	int i , j, k = 0, l , ub ,lb;
	int itemTimeOcc;
	int sid,tid;
	for (i = 0; i < p.frePattern.size(); i++)
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	newElement.items.push_back(x.getLastItem());
	p_.frePattern.push_back(newElement);
	p_.setFrequency(x.frequency);
	
	for (i = 0; i < p.pTir.size(); i++)
	{
		sid = p.pTir[i].sId;
		for (j = 0; j < p.pTir[i].tir.size() ; j++)
		{
			tid = p.pTir[i]->tir[j].tId;
			lb = sequential[sid].transaction[tid].timeOcc + mingap;
			if (p.pTir[i]->tir[j].lastStartTime + maxgap < p.pTir[i]->tir[j].initialTime + dun)
				ub = p.pTir[i]->tir[j].lastStartTime + maxgap;
			else
				ub = p.pTir[i]->tir[j].initialTime + dun;
			for (k = tid+1; k < sequential[sid].transaction.size() ; k++)
			{
				itemTimeOcc = sequential[sid].transaction[k].timeOcc;
				if (lb <= itemTimeOcc && itemTimeOcc <= ub )
				{
					for (l = 0; l < sequential[sid].transaction[k].element.items.size(); l++)
					{
						if (sequential[sid].transaction[k].element.items[l] == x.getLastItem())
						{
							//if (generateSVT(k,p.pTir[i]->tir[j].initialTime,itemTimeOcc,sequential[sid].transaction,x.getLastItem()))
								p_.insertTir(sid,k,l,p.pTir[i]->tir[j].initialTime,itemTimeOcc);
						}
					}
				}
				else if (itemTimeOcc > ub)
				{
					break;
				}
			}
		}
	}
	
	
	return p_;
}*/

/*
frequencyPattern SequentialDatabase::updateType2Pattern(frequencyPattern p,frequencyPattern x)
{
	frequencyPattern p_;
	int i , j, k = 0, l , ub ,lb;
	int itemTimeOcc;
	int sid,tid;
	for (i = 0; i < p.frePattern.size(); i++)
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	i = p_.frePattern.size() - 1;
	p_.frePattern[i].items.push_back(x.getLastItem());
	p_.setFrequency(x.frequency);
	for (i = 0; i < p.pTir.size(); i++)
	{
		sid = p.pTir[i].sId;
		for (j = 0; j < p.pTir[i].tir.size() ; j++)
		{
			tid = p.pTir[i]->tir[j].tId;
			lb =  sequential[sid].transaction[tid].timeOcc - swin;
			if (p.pTir[i]->tir[j].lastStartTime + swin < p.pTir[i]->tir[j].initialTime + dun)
				ub = p.pTir[i]->tir[j].lastStartTime + swin;
			else
				ub = p.pTir[i]->tir[j].initialTime + dun;
			for (k = tid > 0 ? tid -1 : 0 ; k < sequential[sid].transaction.size() ; k++)
			{
				itemTimeOcc = sequential[sid].transaction[k].timeOcc;
				if (lb <= itemTimeOcc && itemTimeOcc <= ub )
				{
					for (l = 0; l < sequential[sid].transaction[k].element.items.size(); l++)
					{
						if (sequential[sid].transaction[k].element.items[l] == x.getLastItem())
						{
							if (p.pTir[i]->tir[j].initialTime < itemTimeOcc)
							{
								//if (generateSVT(k,p.pTir[i]->tir[j].initialTime,itemTimeOcc,sequential[sid].transaction,x.getLastItem()))
								{
									p_.insertTir(sid,k,l,p.pTir[i]->tir[j].initialTime,itemTimeOcc);
								}
							}
							else
							{
								//if (generateSVT(tid,itemTimeOcc,p.pTir[i]->tir[j].initialTime,sequential[sid].transaction,x.getLastItem()))
								{
									p_.insertTir(sid,tid,l,itemTimeOcc,p.pTir[i]->tir[j].initialTime);
								}
							}
							
						}
					}
				}
				else if (itemTimeOcc > ub)
				{
					break;
				}
			}
		}
	}
	
	
	return p_;
}*/