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
	current = 0;
}

SequentialDatabase::~SequentialDatabase()
{
	sequential.clear();
	if (frequency)
		delete [] frequency;
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

bool SequentialDatabase::BEPValid(frequencyPattern p, bool first)
{
	int sid, tid, lst, iid, let;
	int iniTime;
	int i, j, k, h, x, ii;
	bool prevValid = true, nextValid = true;
	int start, end;
	int size = p.pTir.size();
	int count=0;
	vector<Element>::iterator ip = p.frePattern.end();
	vector<TimeIntervalRecord1 *> temp;
	for (i = 0; i < size; i++)
	{
		temp.push_back(p.pTir[i]);
	}
	int * Stemp1Index, *Stemp2Index;
	int * Stemp1LastIndex, *Stemp2LastIndex;
	bool * Stemp1Init, *Stemp2Init;
	Stemp1Index = new int[ITEM_NO];
	Stemp2Index = new int[ITEM_NO];
	Stemp1LastIndex = new int[ITEM_NO];
	Stemp2LastIndex = new int[ITEM_NO];
	Stemp1Init = new bool[ITEM_NO];
	Stemp2Init = new bool[ITEM_NO];
	while(true)
	{
		if(count==size) break;
		ip--;
		for (i = 0; i < ITEM_NO; i++)
		{
			Stemp1Index[i] = 0;
			Stemp2Index[i] = 0;
		}
		for (i = 0; i < size; i++)
		{
			for (j = 0; j < ITEM_NO; j++)
			{
				Stemp1Init[j] = false;
				Stemp2Init[j] = false;
			}
			sid = temp[i]->sId;
			for (j = 0; j < temp[i]->tir.size(); j++)
			{
				tid = temp[i]->tir[j].tId;
				lst = temp[i]->tir[j].lastStartTime;
				iid = temp[i]->tir[j].iId;
				if(temp[i]->prev == NULL)
				{
					svtType1 = generateBEPType1(tid, lst, sequential[sid].transaction);
					for (k = 0; k < svtType1.size(); k++)
					{
						iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
						for (h = 0; h < sequential[sid].transaction[svtType1[k]].element.items.size(); h++)
						{
							x = sequential[sid].transaction[svtType1[k]].element.items[h];
							if (Stemp1Init[x] == false)
							{
								Stemp1Index[x]++;
								Stemp1Init[x] = true;
							}
						}
					}
					svtType1.clear();
				}

				svtType2 = generateBEPType2(tid, lst, sequential[sid].transaction);
				for (k = 0; k < svtType2.size(); k++)
				{
					iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;
					if (lst <= iniTime)
					{
						start = lst;
						end = iniTime;
					}
					else
					{
						start = iniTime;
						end = lst;
					}
					prevValid = false;
					if (temp[i]->prev != NULL)
					{
						for (ii = 0; ii < temp[i]->prev->tir.size(); ii++)
						{
							let = sequential[sid].transaction[temp[i]->prev->tir[ii].tId].timeOcc;
							if (end - temp[i]->prev->tir[ii].lastStartTime <= maxgap && start - let >= mingap)
							{
								prevValid = true;
								break;
							}
						}
					}
					else
						prevValid = true;
					nextValid = false;
					if (prevValid && temp[i]->next != NULL && first == false)
					{
						for (ii = 0; ii < temp[i]->next->tir.size(); ii++)
						{
							let = sequential[sid].transaction[temp[i]->next->tir[ii].tId].timeOcc;
							if (let - start <= maxgap && temp[i]->next->tir[ii].lastStartTime - end >= mingap)
							{
								nextValid = true;
								break;
							}
						}
					}
					else
						nextValid = true;
					if (prevValid && nextValid)
					{
						for (h = 0; h < sequential[sid].transaction[svtType2[k]].element.items.size(); h++)
						{
							x = sequential[sid].transaction[svtType2[k]].element.items[h];
							if (ip->items.back() < x || ip->items.front() > x)
							{
								if (Stemp2Init[x] == false)
								{
									Stemp2Index[x]++;
									Stemp2Init[x] = true;
								}
							}
						}
					}

				}
				svtType2.clear();
			}
			temp[i] = temp[i]->prev;
			if(temp[i] == NULL) count++;
		}
		delete[] Stemp1Init;
		delete[] Stemp2Init;

		for (i = 0; i < ITEM_NO; i++)
		{
			if (Stemp1Index[i] == p.pTir.size())
				return false;
		}
		for (i = 0; i < ITEM_NO; i++)
		{
			if (Stemp2Index[i] == p.pTir.size())
				return false;
		}
	}
	return true;
}

bool SequentialDatabase::BEPValid1(frequencyPattern p)
{
	int i;
	int size = p.pTir.size();
	int count=0;
	vector<Element>::iterator ip = p.frePattern.end();
	vector<TimeIntervalRecord1 *> temp;
	for (i = 0; i < size; i++)
	{
		temp.push_back(p.pTir[i]);
	}
	vector<int>::iterator it;
	vector<int>::iterator stempIt;
	vector<int> Stemp1, Stemp2;
	vector<int> freType1, freType2;
	while(true)
	{
		if(count==size) break;
		ip--;
		Stemp1.clear();
		Stemp2.clear();
		freType1.clear();
		freType2.clear();
		for (i = 0; i < size; i++)
		{
			generateBEPType(temp[i], sequential[temp[i]->sId].transaction, ip);
			for (it = svtType1.begin(); it != svtType1.end(); ++it)
			{
				stempIt = find(Stemp1.begin(), Stemp1.end(), *it);
				if (stempIt == Stemp1.end())
				{
					Stemp1.push_back(*it);
					freType1.push_back(1);
				}
				else
				{
					freType1[stempIt - Stemp1.begin()]++;
				}
			}
			for (it = svtType2.begin(); it != svtType2.end(); ++it)
			{
				stempIt = find(Stemp2.begin(), Stemp2.end(), *it);
				if (stempIt == Stemp2.end())
				{
					Stemp2.push_back(*it);
					freType2.push_back(1);
				}
				else
				{
					freType2[stempIt - Stemp2.begin()]++;
				}
			}
			temp[i] = temp[i]->prev;
			if(temp[i] == NULL) count++;
		}
		for (i = 0; i < freType1.size(); i++)
			if (freType1[i] == p.pTir.size())
				return false;
		for (i = 0; i < freType2.size(); i++)
			if (freType2[i] == p.pTir.size())
				return false;
	}
	return true;
}

void SequentialDatabase::generateFEPType(TimeIntervalRecord1 * pTir,vector<Transaction> trans)
{
	int i, j, h;
	int tid, lst, iid;
	int ub,lb;
	int sid =  pTir->sId;
	int x;
	vector<int> temp1, temp2;
	vector<int>::iterator iter;
	for (i = 0; i < pTir->tir.size(); i++)
	{
		tid = pTir->tir[i].tId;
		lst = pTir->tir[i].lastStartTime;
		iid = pTir->tir[i].iId;
		lb = trans[tid].timeOcc + mingap;
		ub = lst + maxgap;
		for (j = tid+1; j < trans.size(); j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
			{
				for (h = 0; h <trans[j].element.items.size(); h++)
				{
					x = trans[j].element.items[h];
					iter = find(temp1.begin(),temp1.end(),x);
					if (iter == temp1.end())
						temp1.push_back(x);
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}

		lb = trans[tid].timeOcc - swin;
		ub = lst + swin;
		for (j = 0; j < trans.size(); j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
			{
				if (j == tid)
					h = iid + 1;
				else
					h = 0;
				for (; h < trans[j].element.items.size(); h++)
				{
					x = trans[j].element.items[h];
					iter = find(temp2.begin(),temp2.end(),x);
					if (iter == temp2.end())
						temp2.push_back(x);
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}
	}
	svtType1 = temp1;
	svtType2 = temp2;
}

void SequentialDatabase::generateFEPType_1(TimeIntervalRecord1 * pTir, vector<Transaction> trans)
{
	int i, j, h;
	int tid, lst, iid;
	int ub, lb;
	int sid = pTir->sId;
	int x;
	vector<int> temp1, temp2;
	vector<int>::iterator iter;
	bool * chk1 = new bool[ITEM_NO]();
	bool * chk2 = new bool[ITEM_NO]();
	for (i = 0; i < pTir->tir.size(); i++)
	{
		tid = pTir->tir[i].tId;
		lst = pTir->tir[i].lastStartTime;
		iid = pTir->tir[i].iId;
		lb = trans[tid].timeOcc + mingap;
		ub = lst + maxgap;
		for (j = tid + 1; j < trans.size(); j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
			{
				for (h = 0; h <trans[j].element.items.size(); h++)
				{
					x = trans[j].element.items[h];
					if (!chk1[x])
					{
						temp1.push_back(x);
						chk1[x] = true;
					}
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}

		lb = trans[tid].timeOcc - swin;
		ub = lst + swin;
		for (j = 0; j < trans.size(); j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
			{
				if (j == tid)
					h = iid + 1;
				else
					h = 0;
				for (; h < trans[j].element.items.size(); h++)
				{
					x = trans[j].element.items[h];
					if (!chk2[x])
					{
						temp2.push_back(x);
						chk2[x] = true;
					}
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}
	}
	svtType1 = temp1;
	svtType2 = temp2;
}

void SequentialDatabase::generateBEPType(TimeIntervalRecord1 * pTir,vector<Transaction> trans, vector<Element>::iterator ip)
{
	int i, j, ii, h;
	int tid, lst, let, iid, iniTime;
	int ub,lb;
	int sid =  pTir->sId;
	bool prevValid = true, nextValid = true;
	int start, end;
	int x;
	vector<int> temp1, temp2;
	vector<int>::iterator iter;
	for (i = 0; i < pTir->tir.size(); i++)
	{
		tid = pTir->tir[i].tId;
		lst = pTir->tir[i].lastStartTime;
		if(pTir->prev == NULL)
		{
			lb = trans[tid].timeOcc - maxgap;
			ub = lst - mingap;
			for (j = 0; j < trans.size() ; j++)
			{
				if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
				{
					for (h = 0; h < trans[j].element.items.size(); h++)
					{
						x = trans[j].element.items[h];
						iter = find(temp1.begin(), temp1.end(), x);
						if (iter == temp1.end())
							temp1.push_back(x);
					}
				}
				else if (trans[j].timeOcc > ub)
				{
					break;
				}
			}
		}
		lb = trans[tid].timeOcc - swin;
		ub = lst + swin;
		for (j = 0 ; j < trans.size() ; j++)
		{
			if (lb <= trans[j].timeOcc && trans[j].timeOcc <= ub)
			{
				iniTime = trans[j].timeOcc;
				if (lst <= iniTime)
				{
					start = lst;
					end = iniTime;
				}
				else
				{
					start = iniTime;
					end = lst;
				}
				prevValid = false;
				if (pTir->prev != NULL)
				{
					for (ii = 0; ii < pTir->prev->tir.size(); ii++)
					{
						let = trans[pTir->prev->tir[ii].tId].timeOcc;
						if (end - pTir->prev->tir[ii].lastStartTime <= maxgap && start - let >= mingap)
						{
							prevValid = true;
							break;
						}
					}
				}
				else
					prevValid = true;
				nextValid = false;
				if (prevValid && pTir->next != NULL)
				{
					for (ii = 0; ii < pTir->next->tir.size(); ii++)
					{
						let = trans[pTir->next->tir[ii].tId].timeOcc;
						if (let - start <= maxgap && pTir->next->tir[ii].lastStartTime - end >= mingap)
						{
							nextValid = true;
							break;
						}
					}
				}
				else
					nextValid = true;
				if (prevValid && nextValid)
				{
					for (h=0; h < trans[j].element.items.size(); h++)
					{
						x = trans[j].element.items[h];
						if (ip->items.back() < x || ip->items.front() > x)
						{
							iter = find(temp2.begin(), temp2.end(), x);
							if (iter == temp2.end())
								temp2.push_back(x);
						}
					}
				}
			}
			else if (trans[j].timeOcc > ub)
			{
				break;
			}
		}
	}
	svtType1 = temp1;
	svtType2 = temp2;
}

frequencyPattern SequentialDatabase::updateType1Pattern(frequencyPattern p, int x)
{
	int i, j, k, h, y;
	int lastId = -1;
	int sid, tid, lst, lb, ub, iniTime;
	bool isInit;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	Element element;
	element.items.push_back(x);
	p_.frePattern.push_back(element);
	vector<Transaction> trans;
	for (i = 0; i < p.pTir.size(); i++)
	{
		isInit = false;
		sid = p.pTir[i]->sId;
		trans = sequential[sid].transaction;
		for (j = 0; j < p.pTir[i]->tir.size() ; j++)
		{
			tid = p.pTir[i]->tir[j].tId;
			lst = p.pTir[i]->tir[j].lastStartTime;
			lb = trans[tid].timeOcc + mingap;
			ub = lst + maxgap;
			for (k = tid+1 ; k < trans.size() ; k++)
			{
				if (lb <= trans[k].timeOcc && trans[k].timeOcc <= ub)
				{
					iniTime = trans[k].timeOcc;
					for (h = 0; h < trans[k].element.items.size(); h++)
					{
						y = trans[k].element.items[h];
						if (x == y)
						{
							p_.insertTir(sid, k, h, iniTime, p.pTir[i], NULL,lastId, isInit);
						}
					}
				}
			}
		}
	}
	return p_;
}

frequencyPattern SequentialDatabase::updateType2Pattern(frequencyPattern p, int x)
{
	int i, j, k, h, y;
	int lastId = -1;
	int sid, tid, iid, lst, lb, ub, iniTime;
	bool isInit;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	p_.frePattern[i-1].items.push_back(x);
	vector<Transaction> trans;
	for (i = 0; i < p.pTir.size(); i++)
	{
		isInit = false;
		sid = p.pTir[i]->sId;
		trans = sequential[sid].transaction;
		for (j = 0; j < p.pTir[i]->tir.size(); j++)
		{
			tid = p.pTir[i]->tir[j].tId;
			lst = p.pTir[i]->tir[j].lastStartTime;
			iid = p.pTir[i]->tir[j].iId;
			lb = trans[tid].timeOcc - swin;
			ub = lst + swin;
			for (k = 0 ; k < trans.size() ; k++)
			{
				if (lb <= trans[k].timeOcc && trans[k].timeOcc <= ub)
				{
					iniTime = trans[k].timeOcc;
					if (k == tid)
						h = iid + 1;
					else
						h = 0;
					for (; h < trans[k].element.items.size(); h++)
					{
						y = trans[k].element.items[h];
						if (x == y)
						{
							if (lst <= iniTime)
								p_.insertTir(sid, k, h, lst, p.pTir[i]->prev, p.pTir[i]->next, lastId, isInit);
							else
								p_.insertTir(sid, tid, iid, iniTime, p.pTir[i]->prev, p.pTir[i]->next, lastId, isInit);
						}
					}
				}
			}
		}
	}
	return p_;
}

bool  SequentialDatabase::FEPValid(frequencyPattern p, vector<int> & Stemp1, vector<int> & frequencyStemp1, vector<int> & Stemp2, vector<int> & frequencyStemp2)
{
	int i, k;
	vector<int>::iterator it;
	vector<int>::iterator stempIt;
	for (i = 0; i < p.pTir.size(); i++)
	{
		generateFEPType_1(p.pTir[i], sequential[p.pTir[i]->sId].transaction);
		for (it = svtType1.begin(); it != svtType1.end(); ++it)
		{
			stempIt = find(Stemp1.begin(),Stemp1.end(), *it);
			if (stempIt == Stemp1.end())
			{
				Stemp1.push_back(*it);
				frequencyStemp1.push_back(1);
			}
			else
			{
				frequencyStemp1[stempIt - Stemp1.begin()]++;
			}
		}
		for (it = svtType2.begin(); it != svtType2.end(); ++it)
		{
			if (p.getLastItem() < *it)
			{
				stempIt = find(Stemp2.begin(),Stemp2.end(), *it);
				if (stempIt == Stemp2.end())
				{
					Stemp2.push_back(*it);
					frequencyStemp2.push_back(1);
				}
				else
				{
					frequencyStemp2[stempIt - Stemp2.begin()]++;
				}
			}
		}
	}
	for (i = 0; i < frequencyStemp1.size(); i++)
		if (frequencyStemp1[i] == p.pTir.size())
			return false;
	for (i = 0; i < frequencyStemp2.size(); i++)
		if (frequencyStemp2[i] == p.pTir.size())
			return false;
	return true;
}

bool  SequentialDatabase::FEPValid_1(frequencyPattern p, vector<int> & Stemp1, vector<int> & frequencyStemp1, vector<int> & Stemp2, vector<int> & frequencyStemp2)
{
	int i, k;
	int * chk1 = new int[ITEM_NO]();
	int * chk2 = new int[ITEM_NO]();
	for (i = 0; i < p.pTir.size(); i++)
	{
		generateFEPType_1(p.pTir[i], sequential[p.pTir[i]->sId].transaction);
		for (k = 0; k < svtType1.size(); ++k)
		{
			if (!chk1[svtType1[k]])
			{
				Stemp1.push_back(svtType1[k]);
				frequencyStemp1.push_back(1);
				chk1[svtType1[k]] = Stemp1.size();
			}
			else
			{
				frequencyStemp1[chk1[svtType1[k]]-1]++;
			}
		}
		for (k = 0; k < svtType2.size(); ++k)
		{
			if (p.getLastItem() < svtType2[k])
			{
				if (!chk2[svtType2[k]])
				{
					Stemp2.push_back(svtType2[k]);
					frequencyStemp2.push_back(1);
					chk2[svtType2[k]] = Stemp2.size();

				}
				else
				{
					frequencyStemp2[chk2[svtType2[k]]-1]++;
				}
			}
		}
	}
	for (i = 0; i < frequencyStemp1.size(); i++)
		if (frequencyStemp1[i] == p.pTir.size())
			return false;
	for (i = 0; i < frequencyStemp2.size(); i++)
		if (frequencyStemp2[i] == p.pTir.size())
			return false;
	return true;
}

bool SequentialDatabase::FEPValid(frequencyPattern p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2)
{
	int sid, tid, lst, iid;
	int iniTime;
	int i, j, k, h, x;
	int * Stemp1Index, *Stemp2Index;
	int * Stemp1LastIndex, *Stemp2LastIndex;
	bool * Stemp1Init, *Stemp2Init;
	Stemp1Index = new int[ITEM_NO];
	Stemp2Index = new int[ITEM_NO];
	Stemp1LastIndex = new int[ITEM_NO];
	Stemp2LastIndex = new int[ITEM_NO];
	Stemp1Init = new bool[ITEM_NO];
	Stemp2Init = new bool[ITEM_NO];
	for (i = 0; i < ITEM_NO; i++)
	{
		Stemp1Index[i] = -1;
		Stemp2Index[i] = -1;
		Stemp1LastIndex[i] = -1;
		Stemp2LastIndex[i] = -1;
	}
	Element newElement;
	frequencyPattern newFrequencyPattern;
	newElement.items.push_back(0);
	newFrequencyPattern.frePattern.push_back(newElement);
	for (i = 0; i < p.pTir.size(); i++)
	{
		for (j = 0; j < ITEM_NO; j++)
		{
			Stemp1Init[j] = false;
			Stemp2Init[j] = false;
		}
		sid = p.pTir[i]->sId;
		for (j = 0; j < p.pTir[i]->tir.size(); j++)
		{
			tid = p.pTir[i]->tir[j].tId;
			lst = p.pTir[i]->tir[j].lastStartTime;
			iid = p.pTir[i]->tir[j].iId;
			svtType1 = generateFEPType1(tid, lst, sequential[sid].transaction);
			for (k = 0; k < svtType1.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
				for (h = 0; h < sequential[sid].transaction[svtType1[k]].element.items.size(); h++)
				{
					x = sequential[sid].transaction[svtType1[k]].element.items[h];
					if (Stemp1Index[x] == -1)
					{
						newFrequencyPattern.frePattern[0].items[0] = x;
						newFrequencyPattern.insertTir(sid, svtType1[k], h, iniTime,
							p.pTir[i], NULL, Stemp1LastIndex[x], Stemp1Init[x]);
						Stemp1.push_back(newFrequencyPattern);
						Stemp1Index[x] = Stemp1.size() - 1;
						newFrequencyPattern.pTir.clear();
					}
					else
						Stemp1[Stemp1Index[x]].insertTir(sid, svtType1[k], h, iniTime
							, p.pTir[i], NULL, Stemp1LastIndex[x], Stemp1Init[x]);
				}
			}
			svtType1.clear();

			svtType2 = generateFEPType2(tid, lst, sequential[sid].transaction);
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
							newFrequencyPattern.frePattern[0].items[0] = x;

							if (lst <= iniTime)
								newFrequencyPattern.insertTir(sid, svtType2[k], h, lst
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2LastIndex[x], Stemp2Init[x]);
							else
								newFrequencyPattern.insertTir(sid, tid, iid, iniTime
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2LastIndex[x], Stemp2Init[x]);
								
							Stemp2.push_back(newFrequencyPattern);
							Stemp2Index[x] = Stemp2.size() - 1;
							newFrequencyPattern.pTir.clear();
						}
						else
						{
							if (lst <= iniTime)
								Stemp2[Stemp2Index[x]].insertTir(sid, svtType2[k], h, lst
									, p.pTir[i]->prev, p.pTir[i]->next, Stemp2LastIndex[x], Stemp2Init[x]);
							else
								Stemp2[Stemp2Index[x]].insertTir(sid, tid, iid, iniTime
								, p.pTir[i]->prev, p.pTir[i]->next, Stemp2LastIndex[x], Stemp2Init[x]);
						}
					}
				}

			}
			svtType2.clear();
		}
	}
	delete[] Stemp1Init, Stemp2Init;
	delete[] Stemp1Index, Stemp2Index;
	delete[] Stemp1LastIndex, Stemp2LastIndex;
	for (i = 0; i < Stemp1.size(); i++)
		if (Stemp1[i].pTir.size() == p.pTir.size())
			return false;
	for (i = 0; i < Stemp2.size(); i++)
		if (Stemp2[i].pTir.size() == p.pTir.size())
			return false;
	return true;
}

void SequentialDatabase::patternGenerationAlgorithm(frequencyPattern p, bool first)
{
	//if (current > 100000) return;
	int i;
	frequencyPattern p_;
	vector<int> Stemp1, Stemp2, frequencyStemp1, frequencyStemp2;
	bool f = FEPValid_1(p, Stemp1, frequencyStemp1, Stemp2, frequencyStemp2);
	if (f)
	{
		/*printf("%d - ", ++current);
		p.output(stdout);*/
		f = BEPValid1(p);
		if (f)
		{
			printf("%d - ", ++current);
			p.output(stdout);
		}
	}
	for (i = 0; i < Stemp1.size(); ++i)
	{
		if (frequencyStemp1[i] >= THRESHOLD)
		{
			p_ = updateType1Pattern(p, Stemp1[i]);
			patternGenerationAlgorithm(p_);
		}
	}
	for (i = 0; i < Stemp2.size(); ++i)
	{
		if (frequencyStemp2[i] >= THRESHOLD)
		{
			p_ = updateType2Pattern(p, Stemp2[i]);
			patternGenerationAlgorithm(p_, first);
		}
	}
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
	/*vector<Transaction>::iterator iterTrans;*/
	for (i = 0 ; i < sequential.size(); i++)
	{
		/*iterTrans = sequential[i].transaction.begin();
		while (iterTrans != sequential[i].transaction.end())
			if ((*iterTrans).element.items.size() == 0)
				iterTrans = sequential[i].transaction.erase(iterTrans);
			else ++iterTrans;*/
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
			patternGenerationAlgorithm(newFrequencyPattern, true);
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
			iid = binarySearch(sequential[sid].transaction[tid].element.items,i);
			if (iid != -1)
			{
				iniTime = sequential[sid].transaction[tid].timeOcc;
				p.insertTir(sid, tid, iid, iniTime, NULL, NULL, lastId, isInit);
			}
		}
	}
	
}

vector<int> SequentialDatabase::generateFEPType1(int tid, int lst,vector<Transaction> trans)
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

vector<int> SequentialDatabase::generateFEPType2(int tid, int lst,vector<Transaction> trans)
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

vector<int> SequentialDatabase::generateBEPType1(int tid, int lst,vector<Transaction> trans)
{
	vector<int> temp;
	int i,ub,lb;
	lb = trans[tid].timeOcc - maxgap;
	ub = lst - mingap;
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

vector<int> SequentialDatabase::generateBEPType2(int tid, int lst,vector<Transaction> trans)
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