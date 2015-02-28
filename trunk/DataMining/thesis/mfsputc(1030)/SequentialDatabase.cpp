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
	//sequential.clear();
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

bool SequentialDatabase::BEPValid_1(frequencyPattern p)
{
	int i;
	int itemSize = p.frePattern.size();
	int currentId = 0;
	vector<Element>::iterator ip = p.frePattern.begin();
	vector<int> svtType1, svtType2;
	TimeLine prevTil, nextTil;
	while (true)
	{
		if (currentId == itemSize) break;
		vector<int> Stemp1, Stemp2, frequencyStemp1, frequencyStemp2;
		for (i = 0; i < p.pTir.size(); ++i)
		{
			if (currentId == 0)
			{
				vector<int> svtType1 = generateBEPType_1(p.pTir[i].sId, p.pTir[i].til[currentId]);
				generateStempType1(svtType1, Stemp1, frequencyStemp1);
				prevTil = TimeLine();
			}
			else
				prevTil = p.pTir[i].til[currentId - 1];
			if (currentId < itemSize - 1) nextTil = p.pTir[i].til[currentId + 1];
			else nextTil = TimeLine();
			vector<int> svtType2 = generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
				prevTil, nextTil, ip->items.front(), ip->items.back());
			generateStempType1(svtType2, Stemp2, frequencyStemp2);
		}
		for (i = 0; i < frequencyStemp1.size(); ++i)
			if (frequencyStemp1[i] == p.pTir.size())
				return false;
		for (i = 0; i < frequencyStemp2.size(); ++i)
			if (frequencyStemp2[i] == p.pTir.size())
				return false;
		currentId++;
		ip++;
	}
	return true;
}

bool SequentialDatabase::BEPValid_2(frequencyPattern p)
{
	int i;
	int itemSize = p.frePattern.size();
	int currentId = 0;
	vector<Element>::iterator ip = p.frePattern.begin();
	vector<int> svtType1, svtType2;
	TimeLine prevTil, nextTil;
	int pSize = p.pTir.size();
	int minT = THRESHOLD - pSize;
	bool chk2;
	vector<int> Stemp1, frequencyStemp1;
	vector<int> Stemp2, frequencyStemp2;
	bool chk1 = true;
	for (i = 0; i < pSize; ++i)
	{
		if (chk1)
		{
			vector<int> svtType1 = generateBEPType_1(p.pTir[i].sId, p.pTir[i].til[currentId]);
			chk1 = generateStempType_1(svtType1, Stemp1, frequencyStemp1, minT + i);
		}
		if (chk2)
		{
			prevTil = TimeLine();
			if (currentId < itemSize - 1)
				nextTil = p.pTir[i].til[currentId + 1];
			else
				nextTil = TimeLine();
			vector<int> svtType2 = generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
				prevTil, nextTil, ip->items.front(), ip->items.back());
			chk2 = generateStempType_1(svtType2, Stemp2, frequencyStemp2, minT + i);
		}
		if (!chk1 && !chk2) break;
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
		chk2 = true;
		for (i = 0; i < pSize; ++i)
		{
			prevTil = p.pTir[i].til[currentId - 1];
			if (currentId < itemSize - 1)
				nextTil = p.pTir[i].til[currentId + 1];
			else
				nextTil = TimeLine();
			vector<int> svtType2 = generateBEPType_2(p.pTir[i].sId, p.pTir[i].til[currentId],
				prevTil, nextTil, ip->items.front(), ip->items.back());
			if (generateStempType_1(svtType2, Stemp2, frequencyStemp2, minT + i) == false)
				break;
		}
		for (i = 0; i < frequencyStemp2.size(); ++i)
			if (frequencyStemp2[i] == p.pTir.size())
				return false;
		currentId++;
		ip++;
	}
	return true;
}

vector<int> SequentialDatabase::generateBEPType_1(int sId, TimeLine til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = sequential[sId].transaction[til.tir[i].tId].timeOcc - maxgap;
		ub = til.tir[i].lastStartTime - mingap;
		for (j = 0; j < til.tir[i].tId; ++j)
		{
			iniTime = sequential[sId].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				vector<int> items = sequential[sId].transaction[j].element.items;
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

vector<int> SequentialDatabase::generateBEPType_2(int sId, TimeLine til, TimeLine prevTil, TimeLine nextTil, 
	int firstItem, int lastItem)
{
	int i, j, ub, lb;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = sequential[sId].transaction[til.tir[i].tId].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sId].transaction.size(); ++j)
		{
			int iniTime = sequential[sId].transaction[j].timeOcc;
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
					end = sequential[sId].transaction[til.tir[i].tId].timeOcc;
				}
				bool prevValid = false;
				if (prevTil.tir.size() > 0)
				{
					for (int ii = 0; ii < prevTil.tir.size(); ++ii)
					{
						if (end - prevTil.tir[ii].lastStartTime <= maxgap && 
							start - sequential[sId].transaction[prevTil.tir[ii].tId].timeOcc >= mingap)
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
						if (sequential[sId].transaction[nextTil.tir[ii].tId].timeOcc - start <= maxgap && 
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
					vector<int> items = sequential[sId].transaction[j].element.items;
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

vector<int> SequentialDatabase::generateFEPType_1(int sId, TimeLine til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int tId, iniTime;
	for (i = 0; i < til.tir.size(); ++i)
	{
		tId = til.tir[i].tId;
		lb = sequential[sId].transaction[tId].timeOcc + mingap;
		ub = til.tir[i].lastStartTime + maxgap;
		for (j = tId + 1; j < sequential[sId].transaction.size(); ++j)
		{
			iniTime = sequential[sId].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				vector<int> items = sequential[sId].transaction[j].element.items;
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

vector<int> SequentialDatabase::generateFEPType_2(int sId, TimeLine til)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = sequential[sId].transaction[til.tir[i].tId].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sId].transaction.size(); ++j)
		{
			iniTime = sequential[sId].transaction[j].timeOcc;
			if (lb <= iniTime && iniTime <= ub)
			{
				int h = 0;
				if (j == til.tir[i].tId)
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
			else if (iniTime > ub)
			{
				break;
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType_2(int sId, TimeLine til, TimeLine prevTil)
{
	int i, j, ub, lb;
	vector<int> temp;
	int iniTime;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = sequential[sId].transaction[til.tir[i].tId].timeOcc - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < sequential[sId].transaction.size(); ++j)
		{
			iniTime = sequential[sId].transaction[j].timeOcc;
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
					end = sequential[sId].transaction[til.tir[i].tId].timeOcc;
				}
				bool prevValid = false;
				for (int ii = 0; ii < prevTil.tir.size(); ++ii)
				{
					if (end - prevTil.tir[ii].lastStartTime <= maxgap && 
						start - sequential[sId].transaction[prevTil.tir[ii].tId].timeOcc >= mingap)
					{
						prevValid = true;
						break;
					}
				}
				if (prevValid)
				{
					int h = 0;
					if (j == til.tir[i].tId)
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

void SequentialDatabase::generateStempType1(vector<int> svtType1, vector<int> & Stemp1, vector<int> & frequencyStemp1)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < svtType1.size(); ++k)
	{
		iter = find(Stemp1.begin(), Stemp1.end(), svtType1[k]);
		if (iter == Stemp1.end())
		{
			Stemp1.push_back(svtType1[k]);
			frequencyStemp1.push_back(1);
		}
		else
		{
			frequencyStemp1[iter - Stemp1.begin()]++;
		}
	}
}

void SequentialDatabase::generateStempType2(vector<int> svtType2, vector<int> & Stemp2, vector<int> & frequencyStemp2, int lastItem)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < svtType2.size(); ++k)
	{
		if (lastItem < svtType2[k])
		{
			iter = find(Stemp2.begin(), Stemp2.end(), svtType2[k]);
			if (iter == Stemp2.end())
			{
				Stemp2.push_back(svtType2[k]);
				frequencyStemp2.push_back(1);
			}
			else
			{
				frequencyStemp2[iter - Stemp2.begin()]++;
			}
		}
	}
}

bool SequentialDatabase::generateStempType_1(vector<int> svtType1, vector<int> & Stemp1, vector<int> & frequencyStemp1, int minT)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < svtType1.size(); ++k)
	{
		iter = find(Stemp1.begin(), Stemp1.end(), svtType1[k]);
		if (iter == Stemp1.end())
		{
			if (0 >= minT)
			{
				Stemp1.push_back(svtType1[k]);
				frequencyStemp1.push_back(1);
			}
		}
		else
		{
			int i = iter - Stemp1.begin();
			if (frequencyStemp1[i] >= minT)
				frequencyStemp1[i]++;
			else
			{
				Stemp1.erase(iter);
				frequencyStemp1.erase(frequencyStemp1.begin() + i);
			}
		}
		if (Stemp1.empty() && 0 < minT) return false;
	}
	return true;
}

bool SequentialDatabase::generateStempType_2(vector<int> svtType2, vector<int> & Stemp2,
	vector<int> & frequencyStemp2, int lastItem, int minT)
{
	int k;
	vector<int>::iterator iter;
	for (k = 0; k < svtType2.size(); ++k)
	{
		if (lastItem < svtType2[k])
		{
			iter = find(Stemp2.begin(), Stemp2.end(), svtType2[k]);
			if (iter == Stemp2.end())
			{
				if (0 >= minT)
				{
					Stemp2.push_back(svtType2[k]);
					frequencyStemp2.push_back(1);
				}
			}
			else
			{
				int i = iter - Stemp2.begin();
				if (frequencyStemp2[i] >= minT)
					frequencyStemp2[i]++;
				else
				{
					Stemp2.erase(iter);
					frequencyStemp2.erase(frequencyStemp2.begin() + i);
				}
			}
		}
		if (Stemp2.empty() && 0 < minT) return false;
	}
	return true;
}

frequencyPattern SequentialDatabase::updateType1Pattern(frequencyPattern p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	Element element;
	element.items.push_back(x);
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
						if (items[h] == x)
						{
							p_.insertTir(sId, k, h, iniTime, lastId, isInit, p.pTir[i].til);
							break;
						}
					}
					/*int iId = binarySearch(sequential[sId].transaction[k].element.items, x);
					if(iId != -1)
					{
						p_.insertTir(sId, tId, iId, sequential[sId].transaction[tId].timeOcc, lastId, isInit, p.pTir[i].til);
					}*/
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

frequencyPattern SequentialDatabase::updateType2Pattern(frequencyPattern p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); i++ )
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	p_.frePattern[i-1].items.push_back(x);
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
						if (items[h] == x)
						{
							if (p.pTir[i].til[lastTil].tir[j].lastStartTime < iniTime)
								p_.insertTir(sId, k, h, p.pTir[i].til[lastTil].tir[j].lastStartTime, lastId, isInit, p.pTir[i].til, true);
							else
								p_.insertTir(sId, tId, iId, iniTime, lastId, isInit, p.pTir[i].til, true);
							break;
						}
					}
					//int iId;
					//if (tId == p.pTir[i].til[lastTil].tir[j].tId)
					//	iId = binarySearch(sequential[sId].transaction[tId].element.items, x, p.pTir[i].til[lastTil].tir[j].iId + 1);
					//else
					//	iId = binarySearch(sequential[sId].transaction[tId].element.items, x);
					//if(iId != -1)
					//{
					//	if (p.pTir[i].til[lastTil].tir[j].lastStartTime < sequential[sId].transaction[tId].timeOcc)
					//		p_.insertTir(sId, tId, iId, p.pTir[i].til[lastTil].tir[j].lastStartTime, lastId, isInit, p.pTir[i].til, true);
					//	else
					//		p_.insertTir(sId, p.pTir[i].til[lastTil].tir[j].tId, p.pTir[i].til[lastTil].tir[j].iId, 
					//			sequential[sId].transaction[tId].timeOcc, lastId, isInit, p.pTir[i].til, true);
					//}
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

frequencyPattern SequentialDatabase::updateType2Pattern_1(frequencyPattern p, int x)
{
	int i, j, k;
	int lastId = -1, isInit;
	int lb, ub, sId, tId, iId;
	int lastTil = p.frePattern.size() - 1;
	frequencyPattern p_;
	for (i = 0; i < p.frePattern.size(); ++i)
	{
		p_.frePattern.push_back(p.frePattern[i]);
	}
	p_.frePattern[i-1].items.push_back(x);
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
							if (items[h] == x)
							{
								if (end == iniTime)
									p_.insertTir(sId, k, h, start, lastId, isInit, p.pTir[i].til, true);
								else
									p_.insertTir(sId, tId, iId, iniTime, lastId, isInit, p.pTir[i].til, true);
								break;
							}
						}
						/*int h = 0;
						if (k == id)
							h = p.pTir[i].til[lastTil].tir[j].iId + 1;
						h = binarySearch(sequential[sId].transaction[k].element.items, x, h);
						if(h != -1)
						{
							if (p.pTir[i].til[lastTil].tir[j].lastStartTime < iniTime)
									p_.insertTir(sId, k, h, start, lastId, isInit, p.pTir[i].til, true);
							else
								p_.insertTir(sId, p.pTir[i].til[lastTil].tir[j].tId, p.pTir[i].til[lastTil].tir[j].iId, 
									iniTime, lastId, isInit, p.pTir[i].til, true);
						}*/
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

bool  SequentialDatabase::FEPValid_1(frequencyPattern p, vector<int> & Stemp1, vector<int> & frequencyStemp1, vector<int> & Stemp2, vector<int> & frequencyStemp2)
{
	int i;
	int lastId = p.pTir[0].til.size() - 1;
	int lastItem = p.frePattern.back().items.back();
	for (i = 0; i < p.pTir.size(); ++i)
	{
		vector<int>svtType1 = generateFEPType_1(p.pTir[i].sId, p.pTir[i].til[lastId]);
		generateStempType1(svtType1, Stemp1, frequencyStemp1);
		vector<int>svtType2;
		if (lastId == 0)
			svtType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId]);
		else
			svtType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId], p.pTir[i].til[lastId - 1]);
		generateStempType2(svtType2, Stemp2, frequencyStemp2, lastItem);
	
	}
	for (i = 0; i < frequencyStemp1.size(); ++i)
		if (frequencyStemp1[i] == p.pTir.size())
			return false;
	for (i = 0; i < frequencyStemp2.size(); ++i)
		if (frequencyStemp2[i] == p.pTir.size())
			return false;
	return true;
}

bool  SequentialDatabase::FEPValid_2(frequencyPattern p, vector<int> & Stemp1, vector<int> & frequencyStemp1, vector<int> & Stemp2, vector<int> & frequencyStemp2)
{
	int i;
	int lastId = p.pTir[0].til.size() - 1;
	int lastItem = p.frePattern.back().items.back();
	bool chk1 = true, chk2 = true;
	int pSize = p.pTir.size();
	int minT = THRESHOLD - pSize;
	for (i = 0; i < pSize; ++i)
	{
		if (chk1)
		{
			vector<int>svtType1 = generateFEPType_1(p.pTir[i].sId, p.pTir[i].til[lastId]);
			chk1 = generateStempType_1(svtType1, Stemp1, frequencyStemp1, minT);
		}
		if (chk2)
		{
			vector<int>svtType2;
			if (lastId == 0)
				svtType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId]);
			else
				svtType2 = generateFEPType_2(p.pTir[i].sId, p.pTir[i].til[lastId], p.pTir[i].til[lastId - 1]);
			chk2 = generateStempType_2(svtType2, Stemp2, frequencyStemp2, lastItem, minT);
		}
		if (!chk1 && !chk2) return true;
		minT++;
	}
	for (i = 0; i < frequencyStemp1.size(); ++i)
		if (frequencyStemp1[i] == pSize)
			return false;
	for (i = 0; i < frequencyStemp2.size(); ++i)
		if (frequencyStemp2[i] == pSize)
			return false;
	return true;
}

bool SequentialDatabase::FEPValid(frequencyPattern p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2)
{
	int sid, tid, lst, iid;
	int iniTime;
	int i, j, k, h;
	vector<int> Stemp1Index(ITEM_NO, -1), Stemp2Index(ITEM_NO, -1);
	vector<int> Stemp1LastIndex(ITEM_NO, -1), Stemp2LastIndex(ITEM_NO, -1);
	vector<int> Stemp1Init, Stemp2Init;
	vector<int> svtType1, svtType2;
	int lastIndex = p.pTir[0].til.size() - 1;
	int pTirSize = p.pTir.size();
	int tirSize;
	for (i = 0; i < pTirSize; i++)
	{
		Stemp1Init.assign(ITEM_NO, 0);
		Stemp2Init.assign(ITEM_NO, 0);
		sid = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastIndex].tir.size();
		for (j = 0; j < tirSize; j++)
		{
			tid = p.pTir[i].til[lastIndex].tir[j].tId;
			lst = p.pTir[i].til[lastIndex].tir[j].lastStartTime;
			iid = p.pTir[i].til[lastIndex].tir[j].iId;
			svtType1 = generateFEPType1(sid, tid, lst);
			for (k = 0; k < svtType1.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
				vector<int> items = sequential[sid].transaction[svtType1[k]].element.items;
				for (h = 0; h < items.size(); h++)
				{
					if (Stemp1Index[items[h]] == -1)
					{
						frequencyPattern newFrequencyPattern;
						newFrequencyPattern.frePattern.push_back(Element());
						newFrequencyPattern.frePattern[0].items.push_back(items[h]);
						newFrequencyPattern.insertTir(sid, svtType1[k], h, iniTime,
							Stemp1LastIndex[items[h]], Stemp1Init[items[h]], p.pTir[i].til);
						Stemp1.push_back(newFrequencyPattern);
						Stemp1Index[items[h]] = Stemp1.size() - 1;
					}
					else
						Stemp1[Stemp1Index[items[h]]].insertTir(sid, svtType1[k], h, iniTime,
							Stemp1LastIndex[items[h]], Stemp1Init[items[h]], p.pTir[i].til);
				}
			}

			svtType2 = generateFEPType2(sid, tid, lst);
			for (k = 0; k < svtType2.size(); k++)
			{
				iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;
				if (svtType2[k] == tid)
					h = iid + 1;
				else
					h = 0;
				vector<int> items = sequential[sid].transaction[svtType2[k]].element.items;
				for (; h < items.size(); h++)
				{
					if (p.getLastItem() < items[h])
					{
						if (Stemp2Index[items[h]] == -1)
						{
							frequencyPattern newFrequencyPattern;
							newFrequencyPattern.frePattern.push_back(Element());
							newFrequencyPattern.frePattern[0].items.push_back(items[h]);
							if (lst <= iniTime)
								newFrequencyPattern.insertTir(sid, svtType2[k], h, lst,
									Stemp2LastIndex[items[h]], Stemp2Init[items[h]], p.pTir[i].til, true);
							else
								newFrequencyPattern.insertTir(sid, tid, iid, iniTime,
									Stemp2LastIndex[items[h]], Stemp2Init[items[h]], p.pTir[i].til, true);
							Stemp2.push_back(newFrequencyPattern);
							Stemp2Index[items[h]] = Stemp2.size() - 1;
						}
						else
						{
							if (lst <= iniTime)
								Stemp2[Stemp2Index[items[h]]].insertTir(sid, svtType2[k], h, lst,
									Stemp2LastIndex[items[h]], Stemp2Init[items[h]], p.pTir[i].til, true);
							else
								Stemp2[Stemp2Index[items[h]]].insertTir(sid, tid, iid, iniTime,
									Stemp2LastIndex[items[h]], Stemp2Init[items[h]], p.pTir[i].til, true);
						}
					}
				}

			}
		}
	}
	for (i = 0; i < Stemp1.size(); i++)
		if (Stemp1[i].pTir.size() == p.pTir.size())
			return false;
	for (i = 0; i < Stemp2.size(); i++)
		if (Stemp2[i].pTir.size() == p.pTir.size())
			return false;
	return true;
}

bool SequentialDatabase::BEPValid(frequencyPattern p)
{
	int sid, tid, lst, iid, let, t;
	int iniTime;
	int i, j, k, h, x, ii;
	bool prevValid = true, nextValid = true;
	int start, end;
	int size = p.pTir.size();
	int itemSize = p.frePattern.size();
	int currentId=0;
	vector<Element>::iterator ip = p.frePattern.begin();
	vector<int> Stemp1Index, Stemp2Index;
	vector<int> Stemp1Init, Stemp2Init;
	vector<int> svtType1, svtType2;
	vector<TimeIntervalRecord> tir, tir1;
	while(true)
	{
		if(currentId==itemSize) break;
		Stemp1Index.assign(ITEM_NO, 0);
		Stemp2Index.assign(ITEM_NO, 0);
		for (i = 0; i < size; i++)
		{
			Stemp1Init.assign(ITEM_NO, 0);
			Stemp2Init.assign(ITEM_NO, 0);
			sid = p.pTir[i].sId;
			tir = p.pTir[i].til[currentId].tir;
			for (j = 0; j < tir.size(); j++)
			{
				tid = tir[j].tId;
				lst = tir[j].lastStartTime;
				iid = tir[j].iId;
				let = sequential[sid].transaction[tid].timeOcc;
				if(currentId == 0)
				{
					svtType1 = generateBEPType1(tid, lst, sequential[sid].transaction);
					for (k = 0; k < svtType1.size(); k++)
					{
						iniTime = sequential[sid].transaction[svtType1[k]].timeOcc;
						for (h = 0; h < sequential[sid].transaction[svtType1[k]].element.items.size(); h++)
						{
							x = sequential[sid].transaction[svtType1[k]].element.items[h];
							if (!Stemp1Init[x])
							{
								Stemp1Index[x]++;
								Stemp1Init[x] = 1;
							}
						}
					}
					svtType1.clear();
				}

				svtType2 = generateBEPType2(tid, lst, sequential[sid].transaction);
				for (k = 0; k < svtType2.size(); k++)
				{
					iniTime = sequential[sid].transaction[svtType2[k]].timeOcc;
					if (lst >= iniTime)
					{
						start = iniTime;
						end = let;
					}
					else if(let <= iniTime)
					{
						start = lst;
						end = iniTime;
					}
					prevValid = false;
					if (currentId != 0)
					{
						tir1 = p.pTir[i].til[currentId-1].tir;
						for (ii = 0; ii < tir1.size(); ii++)
						{
							t = sequential[sid].transaction[tir1[ii].tId].timeOcc;
							if (end - tir1[ii].lastStartTime <= maxgap && start - t >= mingap)
							{
								prevValid = true;
								break;
							}
						}
					}
					else
						prevValid = true;
					tir1.clear();
					nextValid = false;
					if (prevValid && currentId < itemSize-1)
					{
						tir1 = p.pTir[i].til[currentId+1].tir;
						for (ii = 0; ii < tir1.size(); ii++)
						{
							t = sequential[sid].transaction[tir1[ii].tId].timeOcc;
							if (t - start <= maxgap && tir1[ii].lastStartTime - end >= mingap)
							{
								nextValid = true;
								break;
							}
						}
					}
					else
						nextValid = true;
					tir1.clear();
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
			tir.clear();
		}
		
		for (i = 0; i < ITEM_NO; i++)
		{
			if (Stemp1Index[i] == p.pTir.size() || Stemp2Index[i] == p.pTir.size())
			{
				return false;
			}
		}
		currentId++;
		ip++;
	}
	return true;
}

void SequentialDatabase::patternGenerationAlgorithm(frequencyPattern p)
{
	int i;
	//vector<frequencyPattern> Stemp1, Stemp2;
	//bool f = FEPValid(p, Stemp1, Stemp2);
	//if (f)
	//{
	//	printf("%d - ", ++current);
	//	p.output(stdout);
	//	//f = BEPValid(p);
	//	//if (f)
	//	//{
	//	//	//++current;
	//	//	//printf("%d - ", ++current);
	//	//	p.output(out);
	//	//}
	//}
	//for (i = 0; i < Stemp1.size(); ++i)
	//{
	//	if (Stemp1[i].pTir.size() >= THRESHOLD)
	//	{
	//		frequencyPattern p_ = updateType1Pattern(p, Stemp1[i]);
	//		patternGenerationAlgorithm(p_);
	//	}
	//}
	//for (i = 0; i < Stemp2.size(); ++i)
	//{
	//	if (Stemp2[i].pTir.size() >= THRESHOLD)
	//	{
	//		frequencyPattern p_ = updateType2Pattern(p, Stemp2[i]);
	//		patternGenerationAlgorithm(p_);
	//	}
	//}
	vector<int> Stemp1, Stemp2, frequencyStemp1, frequencyStemp2;
	bool f = FEPValid_2(p, Stemp1, frequencyStemp1, Stemp2, frequencyStemp2);
	if (f)
	{
		/*printf("%d - ", ++current);
		p.output(stdout);*/
	/*	if(current==23126)
		{
			p.output(stdout);
			printTimeLine(p);
			return;
		}*/
		f = BEPValid_2(p);
		if (f)
		{
			//++current;
			//printf("%d - ", ++current);
			p.output(stdout);
		}
	}
	for (i = 0; i < Stemp1.size(); ++i)
	{
		if (frequencyStemp1[i] >= THRESHOLD)
		{
			frequencyPattern p_ = updateType1Pattern(p, Stemp1[i]);
			patternGenerationAlgorithm(p_);
		}
	}
	for (i = 0; i < Stemp2.size(); ++i)
	{
		if (frequencyStemp2[i] >= THRESHOLD)
		{
			frequencyPattern p_;
			if (p.frePattern.size() == 1)
				p_ = updateType2Pattern(p, Stemp2[i]);
			else
				p_ = updateType2Pattern_1(p, Stemp2[i]);
			patternGenerationAlgorithm(p_);
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
			patternGenerationAlgorithm(newFrequencyPattern);
			newFrequencyPattern.pTir.clear();
		}
	}
	delete [] frequency;
	frequency = NULL;
}

int SequentialDatabase::binarySearch(vector<int> & data, int search, int low)
{
    int high = data.size()-1;
	int mid;
    while (true)
    {
		if(low > high) return -1;
        mid = (low + high)>>1;
        if (data[mid] == search) return mid;
        if (data[mid] > search) high = mid - 1;
        else low = mid + 1;
    }
	return -1;
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
			/*iid = binarySearch(, i);
			if (iid != -1)
			{
				p.insertTir(sid, tid, iid, sequential[sid].transaction[tid].timeOcc, lastId, isInit);
			}*/
		}
	}
	
}

vector<int> SequentialDatabase::generateFEPType1(int sId, int tId, int lst)
{
	vector<int> temp;
	int i, ub, lb, k;
	lb = sequential[sId].transaction[tId].timeOcc + mingap;
	ub = lst + maxgap;
	for (i = tId + 1; i < sequential[sId].transaction.size(); i++)
	{
		if (lb <= sequential[sId].transaction[i].timeOcc && sequential[sId].transaction[i].timeOcc <= ub)
		{
			temp.push_back(i);
		}
		else if (sequential[sId].transaction[i].timeOcc > ub)
		{
			break;
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType2(int sId, int tId, int lst)
{
	vector<int> temp;
	int i,ub,lb;
	lb = sequential[sId].transaction[tId].timeOcc - swin;
	ub = lst + swin;
	for (i = 0; i < sequential[sId].transaction.size(); i++)
	{
		if (lb <= sequential[sId].transaction[i].timeOcc && sequential[sId].transaction[i].timeOcc <= ub)
		{
			temp.push_back(i);
		}
		else if (sequential[sId].transaction[i].timeOcc > ub)
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

void SequentialDatabase::printTimeLine(frequencyPattern p)
{
	int sid, tid;
	for (int i = 0; i < p.pTir.size(); i++)
	{
		sid = p.pTir[i].sId;
		printf("SID #%d: ", sid);
		for (int j = 0; j < p.pTir[i].til.size(); j++)
		{
			for (int k = 0; k < p.pTir[i].til[j].tir.size(); k++)
			{
				tid = p.pTir[i].til[j].tir[k].tId;
				printf("{%d %d} ; ", p.pTir[i].til[j].tir[k].lastStartTime, sequential[sid].transaction[tid].timeOcc);
			}
			printf("--");
		}
		printf("\n");
	}
}