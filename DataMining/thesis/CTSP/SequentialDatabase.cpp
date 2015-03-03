// SequentialDatabase.cpp: implementation of the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#include "SequentialDatabase.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

SequentialDatabase::SequentialDatabase(char * inFileName, char * outFileName)
{
	in = fopen(inFileName,"rt");
	out = fopen(outFileName,"w");
	assert(in != NULL);
	assert(out != NULL);
	frequency =NULL;
	//current=0;
}

void SequentialDatabase::generateStempType1(vector<int> & sviType1, vector<frequencyItem> & Stemp1)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;
	//for each item in the VTPs of type-1 pattern, add one to its support.
	for (int i = 0; i < sviType1.size(); ++i)
	{
		temp.item.push_back(sviType1[i]);
		iter = find(Stemp1.begin(), Stemp1.end(), temp);
		if (iter != Stemp1.end())
		{
			(*iter).frequency++;
		}
		else
		{
			temp.frequency = 1;
			Stemp1.push_back(temp);
		}
		temp.item.clear();
	}
}

void SequentialDatabase::generateStempType2(vector<int> & sviType2, vector<frequencyItem> & Stemp2, int lastItem)
{
	frequencyItem temp;
	int last = lastItem;
	for (int i = 0; i < sviType2.size(); ++i)
	{
		if (last < sviType2[i])
		{
			temp.item.push_back(sviType2[i]);
			vector<frequencyItem>::iterator iter = find(Stemp2.begin(), Stemp2.end(), temp);
			if (iter != Stemp2.end())
			{
				(*iter).frequency++;
			}
			else
			{
				temp.frequency = 1;
				Stemp2.push_back(temp);
			}
			temp.item.clear();
		}
	}
}

vector<int> SequentialDatabase::generateFEPType1(int sId, TimeLine & til, vector<int> & ot)
{
	vector<int> temp;
	int i, j, ub, lb;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = til.tir[i].lastEndTime + mingap;
		ub = til.tir[i].lastStartTime + maxgap;
		for (j = 0; j < ot.size(); ++j)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				vector<int> t = seq[sId].trans[j].t;
				for (int k = 0; k < t.size(); ++k)
				{
					vector<int>::iterator iter = find(temp.begin(),temp.end(), t[k]);
					if (iter == temp.end())
					{
						temp.push_back(t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType2(int sId, TimeLine & til, vector<int> & ot)
{
	int i, j, ub, lb;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				vector<int> t = seq[sId].trans[j].t;
				for (int k = 0; k < t.size(); ++k)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), t[k]);
					if (iter == temp.end())
					{
						temp.push_back(t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType2(int sId, TimeLine & til, TimeLine & prevTil, vector<int> & ot)
{
	int i, j, ub, lb;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size(); ++j)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				int start, end;
				if (til.tir[i].lastStartTime < ot[j])
				{
					start = til.tir[i].lastStartTime;
					end = ot[j];
				}
				else
				{
					start = ot[j];
					end = til.tir[i].lastEndTime;
				}
				bool prevValid = false;
				for(int k=0; k < prevTil.tir.size(); ++k)
				{
					if (end - prevTil.tir[k].lastStartTime <= maxgap &&
						start - prevTil.tir[k].lastEndTime >= mingap)
					{
						prevValid = true;
						break;
					}
				}
				if (prevValid)
				{
					vector<int> t = seq[sId].trans[j].t;
					for (int k = 0; k < t.size(); ++k)
					{
						vector<int>::iterator iter = find(temp.begin(), temp.end(), t[k]);
						if (iter == temp.end())
						{
							temp.push_back(t[k]);
						}
					}
				}
			}
		}
	}
	return temp;
}

bool SequentialDatabase::FEP(frequencyItem & p, vector<frequencyItem> & Stemp1, vector<frequencyItem> & Stemp2)
{
	int i;
	int lastItem = p.item.back();
	int tid = p.pTir[0].til.size() - 1;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		//use the corresponding time index to determine the VTPs for type-1 patterns.
		vector<int> sviType1 = generateFEPType1(p.pTir[i].sId, p.pTir[i].til[tid], seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-1 pattern, add one to its support.
		generateStempType1(sviType1, Stemp1);
		//use the corresponding time index to determine the VTPs for type-2 patterns.
		vector<int> sviType2;
		if(tid==0)
			sviType2 = generateFEPType2(p.pTir[i].sId, p.pTir[i].til[tid], seq[p.pTir[i].sId].timeOcc);
		else
			sviType2 = generateFEPType2(p.pTir[i].sId, p.pTir[i].til[tid], p.pTir[i].til[tid-1], seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-2 pattern, add one to its support.
		generateStempType2(sviType2, Stemp2, lastItem);
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp1.size(); ++i)
		if (Stemp1[i].frequency == p.frequency)
			return false;
	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp2.size(); ++i)
		if (Stemp2[i].frequency == p.frequency)
			return false;
	return true;
}

void SequentialDatabase::generateBEPStempType2(frequencyItem & p, vector<int> & sviType2, 
	vector<frequencyItem> & Stemp2, int firstId, int lastId)
{
	int first = p.item[firstId], last = p.item[lastId];
	for (int i = 0; i < sviType2.size(); ++i)
	{
		if (last < sviType2[i] || first > sviType2[i])
		{
			frequencyItem temp;
			temp.item.push_back(sviType2[i]);
			vector<frequencyItem>::iterator iter = find(Stemp2.begin(), Stemp2.end(), temp);
			if (iter != Stemp2.end())
			{
				(*iter).frequency++;
			}
			else
			{
				temp.frequency = 1;
				Stemp2.push_back(temp);
			}
		}
	}
}

vector<int> SequentialDatabase::generateBEPType1(int sId, TimeLine & til, vector<int> & ot)
{
	int i, j, ub, lb;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = til.tir[i].lastEndTime - maxgap;
		ub = til.tir[i].lastStartTime - mingap;

		for (j = 0; j < ot.size(); ++j)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				vector<int> t = seq[sId].trans[j].t;
				for (int k = 0; k <t.size(); ++k)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), t[k]);
					if (iter == temp.end())
					{
						temp.push_back(t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType2(int sId, TimeLine & til, vector<int> & ot)
{
	int i, j, lb, ub;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size(); ++j)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				vector<int> t = seq[sId].trans[j].t;
				for (int k = 0; k <t.size(); ++k)
				{
					vector<int>::iterator iter = find(temp.begin(), temp.end(), t[k]);
					if (iter == temp.end())
					{
						temp.push_back(t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType2_1(int sId, TimeLine & til, vector<int> & ot,
	TimeLine & prevTil, TimeLine & nextTil)
{
	int i, j, ub, lb;
	vector<int> temp;
	for (i = 0; i < til.tir.size(); ++i)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size(); ++j)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				int start, end;
				if (til.tir[i].lastStartTime < ot[j])
				{
					start = til.tir[i].lastStartTime;
					end = ot[j];
				}
				else
				{
					start = ot[j];
					end = til.tir[i].lastEndTime;
				}
				bool prevValid = false;
				if(prevTil.tir.size() > 0)
				{
					for(int k=0; k < prevTil.tir.size(); ++k)
					{
						if (end - prevTil.tir[k].lastStartTime <= maxgap &&
							start - prevTil.tir[k].lastEndTime >= mingap)
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
					for(int k=0; k < nextTil.tir.size(); ++k)
					{
						if (nextTil.tir[k].lastEndTime - start <= maxgap &&
							nextTil.tir[k].lastStartTime - end >= mingap)
						{
							nextValid = true;
							break;
						}
					}
				}
				else 
					nextValid = true;
				if(prevValid && nextValid)
				{
					vector<int> t = seq[sId].trans[j].t;
					for (int k = 0; k < t.size(); ++k)
					{
						vector<int>::iterator iter = find(temp.begin(), temp.end(), t[k]);
						if (iter == temp.end())
						{
							temp.push_back(t[k]);
						}
					}
				}
			}
		}
	}
	return temp;
}

bool SequentialDatabase::BEP(frequencyItem & p)
{
	int i;
	int firstId, lastId;
	int size = p.pTir.size();
	int itemSize = p.pTir[0].til.size();
	int currentId = 0;
	firstId = 0;
	lastId = firstId;
	while (lastId < p.item.size() && p.item[lastId] != -1) lastId++;
	lastId--;
	TimeLine prevTil = TimeLine(), nextTil;
	vector<frequencyItem> Stemp1, Stemp2;
	vector<int> sviType1, sviType2;
	for (i = 0; i < size; ++i)
	{
		sviType1 = generateBEPType1(p.pTir[i].sId, p.pTir[i].til[currentId], seq[p.pTir[i].sId].timeOcc);
		generateStempType1(sviType1, Stemp1);
		if (currentId < itemSize - 1) 
			nextTil = p.pTir[i].til[currentId + 1];
		else 
			nextTil = TimeLine();
		sviType2 = generateBEPType2_1(p.pTir[i].sId, p.pTir[i].til[currentId],
			seq[p.pTir[i].sId].timeOcc, prevTil, nextTil);
		generateBEPStempType2(p, sviType2, Stemp2, firstId, lastId);
	}
	for (i = 0; i < Stemp1.size(); ++i)
	{
		if (Stemp1[i].frequency == p.frequency)
			return false;
	}
	for (i = 0; i < Stemp2.size(); ++i)
	{
		if (Stemp2[i].frequency == p.frequency)
			return false;
	}
	firstId = lastId + 2;
	lastId = firstId;
	while (lastId < p.item.size() && p.item[lastId] != -1) lastId++;
	lastId--;
	currentId++;
	while(currentId < itemSize)
	{
		Stemp2.clear();
		for (i = 0; i < size; ++i)
		{
			prevTil = p.pTir[i].til[currentId - 1];
			if (currentId < itemSize - 1) 
				nextTil = p.pTir[i].til[currentId + 1];
			else 
				nextTil = TimeLine();
			sviType2 = generateBEPType2_1(p.pTir[i].sId, p.pTir[i].til[currentId], 
				seq[p.pTir[i].sId].timeOcc, prevTil, nextTil);
			generateBEPStempType2(p, sviType2, Stemp2, firstId, lastId);
		}
		for (i = 0; i < Stemp2.size(); ++i)
		{
			if (Stemp2[i].frequency == p.frequency)
				return false;
		}
		firstId = lastId + 2;
		lastId = firstId;
		while (lastId < p.item.size() && p.item[lastId] != -1) lastId++;
		lastId--;
		currentId++;
	}
	return true;
}

frequencyItem SequentialDatabase::updateType1Pattern(frequencyItem & p, frequencyItem & x)
{
	int lastId = -1;
	bool isInit;
	frequencyItem p_;
	int i, j, k, ub, lb;
	for (i = 0; i < p.item.size(); i++ )
		p_.item.push_back(p.item[i]);
	p_.item.push_back(-1);
	for (i = 0; i < x.item.size();i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;
	int tirSize, iniTime, sId;
	int lastTil = p.pTir[i].til.size() - 1;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = false;
		sId = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastTil].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			lb = p.pTir[i].til[lastTil].tir[j].lastEndTime + mingap;
			ub = p.pTir[i].til[lastTil].tir[j].lastStartTime + maxgap;
			for (k = 0; k < seq[sId].timeOcc.size(); ++k)
			{
				iniTime = seq[sId].timeOcc[k];
				if (lb <= iniTime && iniTime <= ub )
				{
					vector<int> t = seq[sId].trans[k].t;
					for (int h = 0; h < t.size(); ++h)
					{
						if (t[h] == x.item[0])
						{
							p_.insertTir(sId, iniTime, iniTime, lastId, isInit, p.pTir[i]);
							break;
						}
					}
				}
			}
		}
	}
	return p_;
}

frequencyItem SequentialDatabase::updateType2Pattern(frequencyItem & p, frequencyItem & x)
{
	int lastId = -1;
	bool isInit;
	frequencyItem p_;
	int i, j, k, ub, lb;
	for (i = 0; i < p.item.size(); i++ )
		p_.item.push_back(p.item[i]);
	for (i = 0; i < x.item.size(); i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;
	int tirSize, iniTime, sId;
	int lastTil = p.pTir[i].til.size() - 1;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = false;
		sId = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastTil].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			lb = p.pTir[i].til[lastTil].tir[j].lastEndTime - swin;
			ub = p.pTir[i].til[lastTil].tir[j].lastStartTime + swin;
			for (k = 0; k < seq[sId].timeOcc.size(); ++k)
			{
				iniTime = seq[sId].timeOcc[k];
				if (lb <= iniTime && iniTime <= ub )
				{
					vector<int> t = seq[sId].trans[k].t;
					for (int h = 0; h < t.size(); ++h)
					{
						if (t[h] == x.item[0])
						{
							if (p.pTir[i].til[lastTil].tir[j].lastStartTime < iniTime)
								p_.insertTir(sId, p.pTir[i].til[lastTil].tir[j].lastStartTime, iniTime,
									lastId, isInit, p.pTir[i], true);
							else
								p_.insertTir(sId, iniTime, p.pTir[i].til[lastTil].tir[j].lastEndTime, 
									lastId, isInit, p.pTir[i], true);
							break;
						}
					}
				}
			}
		}
	}
	return p_;
}

frequencyItem SequentialDatabase::updateType2Pattern_1(frequencyItem & p, frequencyItem & x)
{
	int lastId = -1;
	bool isInit;
	frequencyItem p_;
	int i, j, k, ub, lb;
	for (i = 0; i < p.item.size(); ++i)
		p_.item.push_back(p.item[i]);
	for (i = 0; i < x.item.size(); ++i)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;
	int iniTime, sId, tirSize;
	int lastIid = p.pTir[0].til.size()-1;
	for (i = 0; i < p.pTir.size(); ++i)
	{
		isInit = false;
		sId = p.pTir[i].sId;
		tirSize = p.pTir[i].til[lastIid].tir.size();
		for (j = 0; j < tirSize; ++j)
		{
			lb = p.pTir[i].til[lastIid].tir[j].lastEndTime - swin;
			ub = p.pTir[i].til[lastIid].tir[j].lastStartTime + swin;
			for (k = 0; k < seq[sId].timeOcc.size(); ++k)
			{
				iniTime = seq[sId].timeOcc[k];
				if (lb <= iniTime && iniTime <= ub )
				{
					int start, end;
					if (p.pTir[i].til[lastIid].tir[j].lastStartTime < iniTime)
					{ 
						start = p.pTir[i].til[lastIid].tir[j].lastStartTime;
						end = iniTime;
					}
					else
					{
						start = iniTime;
						end = p.pTir[i].til[lastIid].tir[j].lastEndTime;
					}
					bool prevValid = false;
					int prevSize = p.pTir[i].til[lastIid - 1].tir.size();
					for(int h=0; h < prevSize; ++h)
					{
						if (end - p.pTir[i].til[lastIid-1].tir[h].lastStartTime <= maxgap &&
							start - p.pTir[i].til[lastIid-1].tir[h].lastEndTime >= mingap)
						{
							prevValid = true;
							break;
						}
					}
					if (prevValid)
					{
						vector<int> t = seq[sId].trans[k].t;
						for (int h = 0; h < t.size(); ++h)
						{
							if (t[h] == x.item[0])
							{
								p_.insertTir(sId, start, end, lastId, isInit, p.pTir[i], true);
								break;
							}
						}
					}
				}
			}
		}
	}
	return p_;
}

void SequentialDatabase::printFrequencyItem(frequencyItem & p, FILE * out)
{
	int k;
	fprintf(out, "{");
	fprintf(out, "{%d", p.item[0]);
	for (k = 1; k < p.item.size(); ++k)
	{
		if (p.item[k] == -1)
		{
			fprintf(out, "}{");
		}
		else if (p.item[k-1] == -1)
		{
			fprintf(out, "%d", p.item[k]);
		}
		else
		{
			fprintf(out, " %d",p.item[k]);
		}
	}
	fprintf(out, "}");
	fprintf(out, "}:%d\n", p.frequency);
}

void SequentialDatabase::mineDB(frequencyItem & p)
{
	int i;
	vector<frequencyItem> Stemp1,Stemp2;
	bool f = FEP(p, Stemp1, Stemp2);
	if (f)
	{
		f = BEP(p);
		if (f)
		{
			printFrequencyItem(p, out);
		}
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp1.size(); ++i)
	{
		if (Stemp1[i].frequency >= THRESHOLD)
		{
			frequencyItem p_ = updateType1Pattern(p, Stemp1[i]);
			mineDB(p_);
		}
	}
	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp2.size(); ++i)
	{
		if (Stemp2[i].frequency >= THRESHOLD)
		{
			frequencyItem p_;
			if(p.pTir[0].til.size() == 1)
				p_ = updateType2Pattern(p, Stemp2[i]);
			else
				p_ = updateType2Pattern_1(p, Stemp2[i]);
			mineDB(p_);
		}
	}
}

void SequentialDatabase::getSequential()
{
	int temp = 0;
	char c;
	int item, pos;

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
						data.timeOcc.push_back(item);
					}
				}
				else
				{
					if (pos)
					{
						tranData.t.push_back(item);
					}
				}
				if (c == '{')
				{
					temp++;
				}
				else if (c == '}')
				{
					temp--;
					data.trans.push_back(tranData);
					tranData.t.clear();
				}
			}
		}while(c != '\n' && !feof(in));
		seq.push_back(data);
		data.timeOcc.clear();
		data.trans.clear();
	}
	// if end of file is reached, rewind to beginning for next pass
	if(feof(in)){
		rewind(in);
		seq.pop_back();
	}
}

void SequentialDatabase::scanDB()
{
	int i,j,k;
	int net_itemno = 0;
	vector<int> frequencySet;
	vector<int>::iterator it;

	frequency = new int[ITEM_NO];
	for (i = 0; i < ITEM_NO; i++)
	{
		frequency[i] = 0;
	}
	getSequential();

	for (i = 0 ; i < seq.size() ;i++)
	{
		for (j = 0; j < seq[i].trans.size(); j++)
		{
			for (k = 0;k < seq[i].trans[j].t.size(); k++)
			{
				it = find(frequencySet.begin(), frequencySet.end(), seq[i].trans[j].t[k]);
				if(it == frequencySet.end())
				{
					frequencySet.push_back(seq[i].trans[j].t[k]);
				}
			}
		}

		for (j = 0; j < frequencySet.size();j++)
		{
			if (frequencySet[j] >= ITEM_NO)
			{
				int* temp = new int[2*frequencySet[j]];
				for(k=0; k<=net_itemno; k++)
					temp[k] = frequency[k];
				for(; k<ITEM_NO; k++)
					temp[k] = 0;
				delete []frequency;
				frequency=temp;
				net_itemno=frequencySet[j];
			}
			else if(net_itemno < frequencySet[j])
			{
				net_itemno = frequencySet[j];
			}
			frequency[frequencySet[j]]++;
		}
		frequencySet.clear();
	}
	ITEM_NO = net_itemno + 1;
	if (in)
		fclose(in);
}

void SequentialDatabase::constructPTidx(frequencyItem & p)
{
	int lastId=-1;
	int sid,tid;
	int pStartItem = p.item[0];
	vector<int>::iterator iter;
	bool isInit;
	for (sid = 0; sid < seq.size(); sid++)
	{
		isInit = false;
		for (tid = 0; tid < seq[sid].trans.size(); ++tid)
		{
			iter = find(seq[sid].trans[tid].t.begin(), seq[sid].trans[tid].t.end(), pStartItem);
			if (iter != seq[sid].trans[tid].t.end())
				p.insertTir(sid,seq[sid].timeOcc[tid],seq[sid].timeOcc[tid], lastId, isInit);
		}
	}
}

void SequentialDatabase::generateSequentialPattern()
{
	THRESHOLD = min_sup * seq.size();
	int i;
	for (i = 0; i < ITEM_NO; ++i)
	{
		if (frequency[i] >= THRESHOLD)
		{
			frequencyItem freItem;
			freItem.item.push_back(i) ;
			freItem.frequency = frequency[i];
			constructPTidx(freItem);
			mineDB(freItem);
		}
	}
	delete [] frequency;
	if (out)
		fclose(out);
}

void SequentialDatabase::execute()
{
	scanDB();
	generateSequentialPattern();
}

SequentialDatabase::~SequentialDatabase()
{
}