// SequentialDatabase.cpp: implementation of the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#include "SequentialDatabase.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

SequentialDatabase::SequentialDatabase(char * inFileName,char * outFileName)
{
	in = fopen(inFileName,"rt");
	out = fopen(outFileName,"w");
	assert(in != NULL);
	assert(out != NULL);
	frequency = NULL;
	//current = 0;
}

void SequentialDatabase::generateStempType1(vector<int> & sviType1, vector<int> & Stemp1, 
											vector<int> & frequencyStemp1)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < sviType1.size(); ++k)
	{
		iter = find(Stemp1.begin(), Stemp1.end(), sviType1[k]);
		if (iter == Stemp1.end())
		{
			Stemp1.push_back(sviType1[k]);
			frequencyStemp1.push_back(1);
		}
		else
		{
			frequencyStemp1[iter - Stemp1.begin()]++;
		}
	}
}

void SequentialDatabase::generateStempType2(vector<int> & sviType2, vector<int> & Stemp2, 
											vector<int> & frequencyStemp2, int lastItem)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < sviType2.size(); ++k)
	{
		if (lastItem < sviType2[k])
		{
			iter = find(Stemp2.begin(), Stemp2.end(), sviType2[k]);
			if (iter == Stemp2.end())
			{
				Stemp2.push_back(sviType2[k]);
				frequencyStemp2.push_back(1);
			}
			else
			{
				frequencyStemp2[iter - Stemp2.begin()]++;
			}
		}
	}
}

bool SequentialDatabase::generateStempType_1(vector<int> & sviType1, vector<int> & Stemp1, vector<int> & frequencyStemp1,
	int & maxT, int minT)
{
	int k;
	int max = maxT, min = minT;
	vector<int>::iterator iter;
	for (k = 0; k < sviType1.size(); ++k)
	{
		iter = find(Stemp1.begin(), Stemp1.end(), sviType1[k]);
		if (iter == Stemp1.end())
		{
			if (0 >= min)
			{
				if (0 > max) max = 0;
				Stemp1.push_back(sviType1[k]);
				frequencyStemp1.push_back(1);
			}
			else if (0 > max) return false;
		}
		else
		{
			int i = iter - Stemp1.begin();
			if (frequencyStemp1[i] >= min)
			{
				if (frequencyStemp1[i] > max)
					max = frequencyStemp1[i];
				frequencyStemp1[i]++;
			}
			else if (frequencyStemp1[i] > max) return false;
		}
	}
	if (max < min)
		return false;
	maxT = max;
	return true;
}

bool SequentialDatabase::generateStempType_2(vector<int> & sviType2, vector<int> & Stemp2,
	vector<int> & frequencyStemp2, int lastItem, int & maxT, int minT)
{
	int k;
	int max = maxT, min = minT;
	vector<int>::iterator iter;
	for (k = 0; k < sviType2.size(); ++k)
	{
		if (lastItem < sviType2[k])
		{
			iter = find(Stemp2.begin(), Stemp2.end(), sviType2[k]);
			if (iter == Stemp2.end())
			{
				if (0 >= min)
				{
					if (0 > max) max = 0;
					Stemp2.push_back(sviType2[k]);
					frequencyStemp2.push_back(1);
				}
				else if (0 > max) return false;
			}
			else
			{
				int i = iter - Stemp2.begin();
				if (frequencyStemp2[i] >= min)
				{
					if (frequencyStemp2[i] > max)
						max = frequencyStemp2[i];
					frequencyStemp2[i]++;
				}
				else if (frequencyStemp2[i] > max) return false;
			}
		}
	}
	if (max < min) 
		return false;
	maxT = max;
	return true;
}

vector<int> SequentialDatabase::generateFEPType_1(int sId, TimeLine & til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int tId, iniTime;
	int sid = sId;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tId = til.tir[i].tId;
		lb = sequential[sid].transaction[tId].timeOcc + mingap;
		ub = til.tir[i].lastStartTime + maxgap;
		for (j = tId + 1; j < sequential[sid].transaction.size(); ++j)
		{
			iniTime = sequential[sid].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				vector<int> items = sequential[sid].transaction[j].element.items;
				for (int h = 0; h < items.size(); ++h)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), items[h]);
					if (iter == temp.end())
					{
						temp.push_back(items[h]);
					}
				}
			}
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType_2(int sId, TimeLine & til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	int sid = sId;
	int tid;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tid = til.tir[i].tId;
		lb = sequential[sid].transaction[tid].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sid].transaction.size(); ++j)
		{
			iniTime = sequential[sid].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				int h = 0;
				if (j == tid)
					h = til.tir[i].iId + 1;
				vector<int> items = sequential[sid].transaction[j].element.items;
				for (; h < items.size(); ++h)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), items[h]);
					if (iter == temp.end())
					{
						temp.push_back(items[h]);
					}
				}
			}
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType_2(int sId, TimeLine & til, TimeLine & prevTil)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	int sid = sId;
	int tid;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tid = til.tir[i].tId;
		lb = sequential[sid].transaction[tid].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sid].transaction.size(); ++j)
		{
			iniTime = sequential[sid].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				int start, end;
				if (til.tir[i].lastStartTime < iniTime)
				{
					start = til.tir[i].lastStartTime;
					end = iniTime;
				}
				else
				{
					start = iniTime;
					end = sequential[sid].transaction[tid].timeOcc;
				}
				bool prevValid = false;
				for (int ii = 0; ii < prevTil.tir.size(); ++ii)
				{
					if (end - prevTil.tir[ii].lastStartTime <= maxgap && 
						start - sequential[sid].transaction[prevTil.tir[ii].tId].timeOcc >= mingap)
					{
						prevValid = true;
						break;
					}
				}
				if (prevValid)
				{
					int h = 0;
					if (j == tid)
						h = til.tir[i].iId + 1;
					vector<int> items = sequential[sId].transaction[j].element.items;
					for (; h < items.size(); ++h)
					{
						vector<int>::iterator iter = find(temp.begin(), temp.end(), items[h]);
						if (iter == temp.end())
						{
							temp.push_back(items[h]);
						}
					}
				}
			}
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

bool  SequentialDatabase::FEPValid_1(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1, 
									 vector<int> & Stemp2, vector<int> & frequencyStemp2)
{
	int i;
	int lastId = p.pTir[0].til.size() - 1;
	int lastItem = p.frePattern.back().items.back();
	for (i = 0; i < p.pTir.size(); ++i)
	{
		vector<int> sviType1 = generateFEPType_1(p.pTir[i].sId, p.pTir[i].til[lastId]);
		generateStempType1(sviType1, Stemp1, frequencyStemp1);
		vector<int> sviType2;
		if (lastId == 0)
			sviType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId]);
		else
			sviType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId], p.pTir[i].til[lastId - 1]);
		generateStempType2(sviType2, Stemp2, frequencyStemp2, lastItem);
	
	}
	for (i = 0; i < frequencyStemp1.size(); ++i)
		if (frequencyStemp1[i] == p.pTir.size())
			return false;
	for (i = 0; i < frequencyStemp2.size(); ++i)
		if (frequencyStemp2[i] == p.pTir.size())
			return false;
	return true;
}

bool  SequentialDatabase::FEPValid_2(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1, 
									 vector<int> & Stemp2, vector<int> & frequencyStemp2, 
									 bool & check1, bool & check2)
{
	int i;
	int lastId = p.pTir[0].til.size() - 1;
	int lastItem = p.frePattern.back().items.back();
	bool chk1 = true, chk2 = true;
	int pSize = p.pTir.size();
	int minT = THRESHOLD - pSize;
	int maxT1 = -1, maxT2 = -1;
	for (i = 0; i < pSize && chk1; ++i)
	{
		chk1 = generateStempType_1(
					generateFEPType_1(p.pTir[i].sId, p.pTir[i].til[lastId]),
					Stemp1, frequencyStemp1, maxT1, minT+i);
	}
	if(lastId == 0)
	{
		for (i = 0; i < pSize && chk2; ++i)
		{
			chk2 = generateStempType_2(
						generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId]),
						Stemp2, frequencyStemp2, lastItem, maxT2, minT+i);
		}
	}
	else
	{
		for (i = 0; i < pSize && chk2; ++i)
		{
			chk2 = generateStempType_2(
						generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId], 
							p.pTir[i].til[lastId - 1]), Stemp2, frequencyStemp2, 
							lastItem, maxT2, minT+i);
		}
	}
	check1 = chk1;
	check2 = chk2;
	if(chk1)
	{
		for (i = 0; i < frequencyStemp1.size(); ++i)
			if (frequencyStemp1[i] == pSize)
				return false;
	}
	if(chk2)
	{
		for (i = 0; i < frequencyStemp2.size(); ++i)
			if (frequencyStemp2[i] == pSize)
				return false;
	}
	return true;
}

vector<int> SequentialDatabase::generateBEPType_1(int sId, TimeLine & til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	int sid = sId;
	int tid;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tid = til.tir[i].tId;
		lb = sequential[sid].transaction[tid].timeOcc - maxgap;
		ub = til.tir[i].lastStartTime - mingap;
		for (j = 0; j < tid; ++j)
		{
			iniTime = sequential[sid].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				vector<int> items = sequential[sid].transaction[j].element.items;
				for (int h = 0; h < items.size(); ++h)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), items[h]);
					if (iter == temp.end())
					{
						temp.push_back(items[h]);
					}
				}
			}
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType_2(int sId, TimeLine & til, TimeLine & prevTil, TimeLine & nextTil, 
	int firstItem, int lastItem)
{
	int i, j, ub, lb;
	vector<int> temp;
	int sid = sId;
	int tid;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tid = til.tir[i].tId;
		lb = sequential[sid].transaction[tid].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sid].transaction.size(); ++j)
		{
			int iniTime = sequential[sid].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				int start, end;
				if (til.tir[i].lastStartTime < iniTime)
				{
					start = til.tir[i].lastStartTime;
					end = iniTime;
				}
				else
				{
					start = iniTime;
					end = sequential[sid].transaction[tid].timeOcc;
				}
				bool prevValid = false;
				if (prevTil.tir.size() > 0)
				{
					for (int ii = 0; ii < prevTil.tir.size(); ++ii)
					{
						if (end - prevTil.tir[ii].lastStartTime <= maxgap && 
							start - sequential[sid].transaction[prevTil.tir[ii].tId].timeOcc >= mingap)
						{
							prevValid = true;
							break;
						}
					}
				}
				else
					prevValid = true;
				bool nextValid = false;
				if (prevValid && nextTil.tir.size() > 0)
				{
					for (int ii = 0; ii < nextTil.tir.size(); ++ii)
					{
						if (sequential[sid].transaction[nextTil.tir[ii].tId].timeOcc - start <= maxgap && 
							nextTil.tir[ii].lastStartTime - end >= mingap)
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
					vector<int> items = sequential[sid].transaction[j].element.items;
					for (int h = 0; h < items.size(); ++h)
					{
						if (firstItem > items[h] || lastItem < items[h])
						{
							vector<int>::iterator iter = find(temp.begin(), temp.end(), items[h]);
							if (iter == temp.end())
							{
								temp.push_back(items[h]);
							}
						}
					}
				}
			}
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

bool SequentialDatabase::BEPValid_1(frequencyPattern & p)
{
	int i;
	int itemSize = p.frePattern.size();
	int currentId = 0;
	vector<Element>::iterator ip = p.frePattern.begin();
	vector<int> sviType1, sviType2;
	TimeLine prevTil, nextTil;
	int pSize = p.pTir.size();
	vector<int> Stemp1, frequencyStemp1;
	vector<int> Stemp2, frequencyStemp2;
	for (i = 0; i < pSize; ++i)
	{
		vector<int> sviType1 = generateBEPType_1(p.pTir[i].sId, p.pTir[i].til[currentId]);
		generateStempType1(sviType1, Stemp1, frequencyStemp1);
		prevTil = TimeLine();
		if (currentId < itemSize - 1)
			nextTil = p.pTir[i].til[currentId + 1];
		else
			nextTil = TimeLine();
		vector<int> sviType2 = generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
			prevTil, nextTil, ip->items.front(), ip->items.back());
		generateStempType1(sviType2, Stemp2, frequencyStemp2);
	}
	for (i = 0; i < frequencyStemp1.size(); ++i)
		if (frequencyStemp1[i] == p.pTir.size())
			return false;
	for (i = 0; i < frequencyStemp2.size(); ++i)
		if (frequencyStemp2[i] == p.pTir.size())
			return false;
	currentId++;
	ip++;
	while (currentId < itemSize)
	{
		Stemp2.clear();
		frequencyStemp2.clear();
		for (i = 0; i < pSize; ++i)
		{
			prevTil = p.pTir[i].til[currentId - 1];
			if (currentId < itemSize - 1)
				nextTil = p.pTir[i].til[currentId + 1];
			else
				nextTil = TimeLine();
			vector<int> sviType2 = generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
				prevTil, nextTil, ip->items.front(), ip->items.back());
			generateStempType1(sviType2, Stemp2, frequencyStemp2);
		}
		for (i = 0; i < frequencyStemp2.size(); ++i)
			if (frequencyStemp2[i] == p.pTir.size())
				return false;
		currentId++;
		ip++;
	}
	return true;
}

bool SequentialDatabase::BEPValid_2(frequencyPattern & p)
{
	int i;
	int itemSize = p.frePattern.size() - 1;
	int currentId = 0;
	int pSize = p.pTir.size();
	int minT = THRESHOLD - pSize;
	int maxT1 = -1, maxT2 = -1;
	vector<Element>::iterator ip = p.frePattern.begin();
	vector<int> Stemp1, frequencyStemp1;
	vector<int> Stemp2, frequencyStemp2;
	for (i = 0; i < pSize; ++i)
	{
		if (!generateStempType_1(
				generateBEPType_1(p.pTir[i].sId, p.pTir[i].til[currentId]),
					Stemp1, frequencyStemp1, maxT1, minT + i)
			) break;
	}
	if(i == pSize)
	{
		for (i = 0; i < frequencyStemp1.size(); ++i)
			if (frequencyStemp1[i] == p.pTir.size())
				return false;
	}
	if (currentId < itemSize)
	{
		for (i = 0; i < pSize; ++i)
		{
			if (!generateStempType_1(
					generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
						TimeLine(), p.pTir[i].til[currentId + 1], 
						ip->items.front(), ip->items.back()), 
						Stemp2, frequencyStemp2, maxT2, minT + i)
				) break;
		}
	}
	else
	{
		for (i = 0; i < pSize; ++i)
		{
			if (!generateStempType_1(
					generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
						TimeLine(), TimeLine(), ip->items.front(), ip->items.back()), 
						Stemp2, frequencyStemp2, maxT2, minT + i)
				) break;
		}
	}
	if (i == pSize)
	{
		for (i = 0; i < frequencyStemp2.size(); ++i)
			if (frequencyStemp2[i] == p.pTir.size())
				return false;
	}
	currentId++;
	ip++;
	for(; currentId < itemSize; currentId++, ip++)
	{
		Stemp2.clear();
		frequencyStemp2.clear();
		maxT2 = -1;
		for (i = 0; i < pSize; ++i)
		{
			if (!generateStempType_1(
					generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
						p.pTir[i].til[currentId - 1], p.pTir[i].til[currentId + 1], 
						ip->items.front(), ip->items.back()), 
						Stemp2, frequencyStemp2, maxT2, minT + i)
				) break;
		}
		if(i==pSize)
		{
			for (i = 0; i < frequencyStemp2.size(); ++i)
				if (frequencyStemp2[i] == p.pTir.size())
					return false;
		}
	}
	if (currentId == itemSize)
	{
		Stemp2.clear();
		frequencyStemp2.clear();
		maxT2 = -1;
		for (i = 0; i < pSize; ++i)
		{
			if (!generateStempType_1(
					generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
						p.pTir[i].til[currentId - 1], TimeLine(), 
						ip->items.front(), ip->items.back()), 
						Stemp2, frequencyStemp2, maxT2, minT + i)
				) break;
		}
		if (i == pSize)
		{
			for (i = 0; i < frequencyStemp2.size(); ++i)
				if (frequencyStemp2[i] == p.pTir.size())
					return false;
		}
	}
	return true;
}

frequencyPattern SequentialDatabase::updateType1Pattern(frequencyPattern & p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	int x1 = x;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	Element element;
	element.items.push_back(x1);
	p_.frePattern.push_back(element);
	int tirSize;
	int iniTime;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = 0;
		sId = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastTil].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			tId = p.pTir[i].til[lastTil].tir[j].tId;
			iId = p.pTir[i].til[lastTil].tir[j].iId;
			lb = sequential[sId].transaction[tId].timeOcc + mingap;
			ub = p.pTir[i].til[lastTil].tir[j].lastStartTime + maxgap;
			for (k = tId + 1; k < sequential[sId].transaction.size(); ++k)
			{
				iniTime = sequential[sId].transaction[k].timeOcc;
				if (lb <= iniTime && iniTime <= ub)
				{
					vector<int> items = sequential[sId].transaction[k].element.items;
					for (int h = 0; h < items.size(); ++h)
					{
						if (items[h] == x1)
						{
							p_.insertTir(sId, k, h, iniTime, lastId, isInit, p.pTir[i].til);
							break;
						}
					}
				}
				else if(iniTime > ub)
				{
					break;
				}
			}
		}
	}
	return p_;
}

frequencyPattern SequentialDatabase::updateType2Pattern(frequencyPattern & p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	int x1 = x;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	p_.frePattern[i-1].items.push_back(x1);
	int iniTime;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = 0;
		sId = p.pTir[i].sId;
		int tirSize = p.pTir[i].til[lastTil].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			tId = p.pTir[i].til[lastTil].tir[j].tId;
			iId = p.pTir[i].til[lastTil].tir[j].iId;
			lb = sequential[sId].transaction[tId].timeOcc - swin;
			ub = p.pTir[i].til[lastTil].tir[j].lastStartTime + swin;
			for (k = 0 ; k < sequential[sId].transaction.size(); ++k)
			{
				iniTime = sequential[sId].transaction[k].timeOcc;
				if (lb <= iniTime && iniTime <= ub)
				{
					int h = 0;
					if (k == tId) h = iId + 1;
					vector<int> items = sequential[sId].transaction[k].element.items;
					for (; h < items.size(); ++h)
					{
						if (items[h] == x1)
						{
							if (p.pTir[i].til[lastTil].tir[j].lastStartTime < iniTime)
								p_.insertTir(sId, k, h, p.pTir[i].til[lastTil].tir[j].lastStartTime, lastId, isInit, p.pTir[i].til, true);
							else
								p_.insertTir(sId, tId, iId, iniTime, lastId, isInit, p.pTir[i].til, true);
							break;
						}
					}
				}
				else if(iniTime > ub)
				{
					break;
				}
			}
		}
	}
	return p_;
}

frequencyPattern SequentialDatabase::updateType2Pattern_1(frequencyPattern & p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	int x1 = x;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); ++i)
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	p_.frePattern[i-1].items.push_back(x1);
	int tirSize, iniTime;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = 0;
		sId = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastTil].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			tId = p.pTir[i].til[lastTil].tir[j].tId;
			iId = p.pTir[i].til[lastTil].tir[j].iId;
			lb = sequential[sId].transaction[tId].timeOcc - swin;
			ub = p.pTir[i].til[lastTil].tir[j].lastStartTime + swin;
			for (k = 0; k < sequential[sId].transaction.size(); ++k)
			{
				iniTime = sequential[sId].transaction[k].timeOcc;
				if (lb <= iniTime && iniTime <= ub)
				{
					int start, end;
					if (p.pTir[i].til[lastTil].tir[j].lastStartTime < iniTime)
					{
						start = p.pTir[i].til[lastTil].tir[j].lastStartTime;
						end = iniTime;
					}
					else
					{
						start = iniTime;
						end = sequential[sId].transaction[tId].timeOcc;
					}
					bool prevValid = false;
					int prevSize = p.pTir[i].til[lastTil-1].tir.size();
					for (int ii = 0; ii < prevSize; ++ii)
					{
						if (end - p.pTir[i].til[lastTil-1].tir[ii].lastStartTime <= maxgap && 
							start - sequential[sId].transaction[p.pTir[i].til[lastTil-1].tir[ii].tId].timeOcc >= mingap)
						{
							prevValid = true;
							break;
						}
					}
					if (prevValid)
					{
						int h = 0;
						if (k == tId) h = iId + 1;
						vector<int> items = sequential[sId].transaction[k].element.items;
						for (; h < items.size(); ++h)
						{
							if (items[h] == x1)
							{
								if (end == iniTime)
									p_.insertTir(sId, k, h, start, lastId, isInit, p.pTir[i].til, true);
								else
									p_.insertTir(sId, tId, iId, iniTime, lastId, isInit, p.pTir[i].til, true);
								break;
							}
						}
					}
				}
				else if(iniTime > ub)
				{
					break;
				}
			}
		}
	}
	return p_;
}

void SequentialDatabase::patternGenerationAlgorithm(frequencyPattern & p)
{
	int i;	
	vector<int> Stemp1, Stemp2, frequencyStemp1, frequencyStemp2;
	bool check1, check2;
	frequencyPattern p_;
	if (FEPValid_2(p, Stemp1, frequencyStemp1, Stemp2, frequencyStemp2, check1, check2))
	{
		if (BEPValid_2(p))
			p.output(out);
	}
	if(check1)
	{
		for (i = 0; i < Stemp1.size(); ++i)
		{
			if (frequencyStemp1[i] >= THRESHOLD)
			{
				patternGenerationAlgorithm(updateType1Pattern(p, Stemp1[i]));
			}
		}
	}
	if(check2)
	{
		for (i = 0; i < Stemp2.size(); ++i)
		{
			if (frequencyStemp2[i] >= THRESHOLD)
			{
				if (p.frePattern.size() == 1)
					patternGenerationAlgorithm(updateType2Pattern(p, Stemp2[i]));
				else
					patternGenerationAlgorithm(updateType2Pattern_1(p, Stemp2[i]));
			}
		}
	}
}

void SequentialDatabase::scanDB()
{
	int k, temp = 0;
	char c;
	int item, pos;
	int net_itemno = 0;
	set<int> oneSeqItem;
	set<int>::iterator iterSet;
	frequency = new int[ITEM_NO];
	for (int i = 0; i < ITEM_NO; ++i)
		frequency[i] = 0;
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
	if (in)
		fclose(in);
}

void SequentialDatabase::generatePTir(frequencyPattern & p)
{
	int sid,tid,iid;
	int transSize;
	int i = p.frePattern[0].items[0];
	int isInit;
	int lastId = -1;
	vector<int>::iterator iter;
	for (sid = 0; sid < sequential.size(); ++sid)
	{
		isInit = 0;
		transSize = sequential[sid].transaction.size();
		for (tid = 0 ; tid < transSize; ++tid)
		{
			vector<int> items = sequential[sid].transaction[tid].element.items;
			for(iid=0; iid < items.size(); ++iid)
			{
				if(items[iid] == i)
				{
					p.insertTir(sid, tid, iid, sequential[sid].transaction[tid].timeOcc, lastId, isInit);
					break;
				}
			}
		}
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
			patternGenerationAlgorithm(newFrequencyPattern);
			newFrequencyPattern.pTir.clear();
		}
	}
	delete [] frequency;
	if (out)
		fclose(out);
}

void SequentialDatabase::execute()
{
	scanDB();
	deleteInfrequentItem();
}

SequentialDatabase::~SequentialDatabase()
{
}