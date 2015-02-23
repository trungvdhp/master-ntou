// SequentialDatabase.cpp: implementation of the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#include "SequentialDatabase.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

SequentialDatabase::SequentialDatabase(char * filename)
{
	in = fopen(filename,"rt");
	assert(in != NULL);
	frequency =NULL;
	current=0;
}

SequentialDatabase::~SequentialDatabase()
{
	seq.clear();
	freSeqSet.clear();
	if (in)
		fclose(in);
	delete [] frequency;

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

void SequentialDatabase::execute()
{
	scanDB();
	generateSequentialPattern();
}

void SequentialDatabase::outputFrequentPattern(char * filename)
{
	int i , j , k;	
	fstream fout;
	//fout.open("out.txt",ios::out);
	fout.open(filename,fstream::out);
	char buf[2];
	for (i = 0; i < freSeqSet.size(); i++)
	{
		for (j = 0 ;j < freSeqSet[i].freSeq.size(); j++)
		{
			fout << "{";
			//sprintf(buf, "%c", 'a' + freSeqSet[i].freSeq[j].item[0]);
			fout << "{"; //<< buf;
			fout << freSeqSet[i].freSeq[j].item[0];
			for (k = 1 ;k < freSeqSet[i].freSeq[j].item.size(); k++)
			{
				if (freSeqSet[i].freSeq[j].item[k] == -1)
				{
					fout << "}{";
				}
				else if (freSeqSet[i].freSeq[j].item[k-1] == -1)
				{
					/*sprintf(buf, "%c", 'a' + freSeqSet[i].freSeq[j].item[k]);
					fout << buf;*/
					fout << freSeqSet[i].freSeq[j].item[k];
				}
				else
				{
					/*sprintf(buf, "%c", 'a' + freSeqSet[i].freSeq[j].item[k]);
					fout << " " << buf;*/
					fout << " " << freSeqSet[i].freSeq[j].item[k];
				}
			}
			fout << "}" ;
			fout << "}:"<< freSeqSet[i].freSeq[j].frequency<< endl;
		}
	}
	fout.close();
}

void SequentialDatabase::generateSequentialPattern()
{
	THRESHOLD = min_sup * seq.size();

	frequentSequence frequentSet; 
	frequencyItem freItem;
	int i;

	for (i = 0; i < ITEM_NO; i++)
	{
		if (frequency[i] >= THRESHOLD)
		{
			freItem.item.push_back(i) ;
			freItem.frequency = frequency[i];
			frequentSet.freSeq.push_back(freItem);
			freItem.item.clear();
		}
	}
	for (i = 0; i < frequentSet.freSeq.size(); i++)
	{
		constructPTidx(frequentSet.freSeq[i]);
		//printFrequencyItem(frequentSet.freSeq[i]);
		mineDB(frequentSet.freSeq[i], 1);
	}
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
		for (tid = 0 ; tid < seq[sid].trans.size() ; tid++)
		{
			iter = find(seq[sid].trans[tid].t.begin(), seq[sid].trans[tid].t.end(), pStartItem);
			if (iter != seq[sid].trans[tid].t.end())
			{
				p.insertTir(sid,seq[sid].timeOcc[tid],seq[sid].timeOcc[tid], lastId, isInit);
			}
		}
	}
}

void SequentialDatabase::generateStempType1(vector<int> svttype1, vector<frequencyItem> & Stemp1)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;
	//for each item in the VTPs of type-1 pattern, add one to its support.
	for (int j = 0; j < svttype1.size();j++)
	{
		temp.item.push_back(svttype1[j]);
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

void SequentialDatabase::generateStempType2(vector<int> svttype2, vector<frequencyItem> & Stemp2, int lastItem)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;

	for (int j = 0; j < svttype2.size(); j++)
	{
		if (lastItem < svttype2[j])
		{
			temp.item.push_back(svttype2[j]);
			iter = find(Stemp2.begin(), Stemp2.end(), temp);
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

bool SequentialDatabase::FEP(frequencyItem p, vector<frequencyItem> & Stemp1, vector<frequencyItem> & Stemp2)
{
	int i;
	vector<int> svttype1,svttype2;
	int lastItem = p.item.back();
	int tid = p.pTir[0].til.size() - 1;
	for (i = 0; i < p.pTir.size(); i++)
	{
		//use the corresponding time index to determine the VTPs for type-1 patterns.
		svttype1 = generateFEPType1(p.pTir[i].sId, p.pTir[i].til[tid],seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-1 pattern, add one to its support.
		generateStempType1(svttype1, Stemp1);
		svttype1.clear();
		//use the corresponding time index to determine the VTPs for type-2 patterns.
		svttype2 = generateFEPType2(p.pTir[i].sId, p.pTir[i].til[tid], seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-2 pattern, add one to its support.
		generateStempType2(svttype2, Stemp2, lastItem);
		svttype2.clear();
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp1.size(); i++)
		if (Stemp1[i].frequency == p.frequency)
			return false;
	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp2.size(); i++)
		if (Stemp2[i].frequency == p.frequency)
			return false;
	return true;
}

void SequentialDatabase::mineDB(frequencyItem p, int count)
{
	int i;
	vector<frequencyItem> Stemp1,Stemp2;
	frequencyItem p_;
	bool f = FEP(p, Stemp1, Stemp2);
	if (f)
	{
		/*printf("%d - ", ++current);
		printFrequencyItem(p);*/
		f = BEP(p);
		if (f)
		{
			printf("%d - ", ++current);
			printFrequencyItem(p);
			//	//printf("ok\n");
			//	/*while (freSeqSet.size() < count)
			//	{
			//		frequentSequence Sp;
			//		freSeqSet.push_back(Sp);
			//	}
			//	freSeqSet[count-1].freSeq.push_back(p);*/
		}
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp1.size(); i++)
	{
		if (Stemp1[i].frequency >= THRESHOLD)
		{
			p_ = updateType1Pattern(p, Stemp1[i], count);
		
			mineDB(p_, count);
		}
	}
	Stemp1.clear();
	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp2.size(); i++)
	{
		if (Stemp2[i].frequency >= THRESHOLD)
		{
			p_ = updateType2Pattern(p, Stemp2[i], count);
			
			mineDB(p_, count);
		}
	}
	Stemp2.clear();
}

vector<int> SequentialDatabase::generateFEPType1(int sId, TimeLine til, vector<int> ot)
{
	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub,lb;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime + mingap;
		ub = til.tir[i].lastStartTime + maxgap;
		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				for (k = 0; k < seq[sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType2(int sId, TimeLine til, vector<int> ot)
{
	int i, j, k, ub, lb;
	vector<int> temp;
	vector<int>::iterator iter;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				for (k = 0; k < seq[sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

frequencyItem SequentialDatabase::updateType1Pattern(frequencyItem p, frequencyItem x, int & count)
{
	int lastId = -1;
	bool isInit;
	frequencyItem p_;
	int i , j,k = 0,l,ub,lb;
	count = 0;
	for (i = 0; i < p.item.size(); i++ )
	{
		if (p.item[i] != -1)
			count++;
		p_.item.push_back(p.item[i]);
	}
	p_.item.push_back(-1);
	for (i = 0; i < x.item.size();i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;

	for (i = 0; i < p.pTir.size(); i++)
	{
		isInit = false;
		vector<TimeIntervalRecord> tir = p.pTir[i].til[p.pTir[i].til.size() - 1].tir;
		for (j = 0; j < tir.size() ; j++)
		{
			lb = tir[j].lastEndTime + mingap;
			ub = tir[j].lastStartTime + maxgap;
			for (k = 0; k < seq[p.pTir[i].sId].timeOcc.size() ; k++)
			{
				if (lb <= seq[p.pTir[i].sId].timeOcc[k] && seq[p.pTir[i].sId].timeOcc[k] <= ub )
				{
					for (l = 0; l < seq[p.pTir[i].sId].trans[k].t.size(); l++)
					{
						if (seq[p.pTir[i].sId].trans[k].t[l] == x.item[0])
						{
							p_.insertTir(p.pTir[i].sId, seq[p.pTir[i].sId].timeOcc[k], seq[p.pTir[i].sId].timeOcc[k]
							, lastId, isInit, p.pTir[i]);
						}
					}
				}
			}
		}
	}
	return p_;
}

frequencyItem SequentialDatabase::updateType2Pattern(frequencyItem p, frequencyItem x, int & count)
{
	int lastId = -1;
	bool isInit;
	frequencyItem p_;
	int i , j, k = 0, l, ub ,lb;
	count = 0;
	for (i = 0; i < p.item.size(); i++ )
	{
		if (p.item[i] != -1)
			count++;
		p_.item.push_back(p.item[i]);
	}
	for (i = 0; i < x.item.size(); i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;

	for (i = 0; i < p.pTir.size(); i++)
	{
		isInit = false;
		vector<TimeIntervalRecord> tir = p.pTir[i].til[p.pTir[i].til.size() - 1].tir;
		for (j = 0; j < tir.size() ; j++)
		{
			lb = tir[j].lastEndTime - swin;
			ub = tir[j].lastStartTime + swin;
			for (k = 0; k < seq[p.pTir[i].sId].timeOcc.size() ; k++)
			{
				if (lb <= seq[p.pTir[i].sId].timeOcc[k] && seq[p.pTir[i].sId].timeOcc[k] <= ub )
				{
					for (l = 0; l < seq[p.pTir[i].sId].trans[k].t.size(); l++)
					{
						if (seq[p.pTir[i].sId].trans[k].t[l] == x.item[0])
						{
							if (p.pTir[i].sId, tir[j].lastStartTime <= seq[p.pTir[i].sId].timeOcc[k])
								p_.insertTir(p.pTir[i].sId, tir[j].lastStartTime, seq[p.pTir[i].sId].timeOcc[k]
								, lastId, isInit, p.pTir[i], true);
							else
								p_.insertTir(p.pTir[i].sId, seq[p.pTir[i].sId].timeOcc[k], tir[j].lastEndTime
								, lastId, isInit, p.pTir[i], true);
						}
					}
				}
			}
		}
	}
	return p_;
}

void SequentialDatabase::printFrequencyItem(frequencyItem p)
{
	int i,j,k;
	/*printf("---------------------------------------------------------------------\n");
	printf("Frequent pattern: ");*/
	printf("{");
	printf("{%d", p.item[0]);
	for (k = 1 ;k < p.item.size(); k++)
	{
		if (p.item[k] == -1)
		{
			printf("}{");
		}
		else if (p.item[k-1] == -1)
		{
			printf("%d", p.item[k]);
		}
		else
		{
			printf(" %d",p.item[k]);
		}
	}
	printf("}");
	printf("}:%d\n", p.frequency);
	/*for (i = 0; i < p.pTir.size(); i++)
	{
		printTimeline(p.pTir[i]);
		printf("\n");
	}*/
}

void SequentialDatabase::printTimeline(TimeIntervalRecord1 tir1)
{
	int k = tir1.til.size();
	for (int i = 0; i < k; i++)
	{
		for (int j = 0; j < tir1.til[i].tir.size(); j++)
			printf("{%d:%d} ; ", tir1.til[i].tir[j].lastStartTime, tir1.til[i].tir[j].lastEndTime);
		printf(" -- ");
	}
}

bool SequentialDatabase::BEP(frequencyItem p)
{
	int i, j;
	int count=0, firstId, lastId;
	int size = p.pTir.size();
	int itemSize = p.pTir[0].til.size();
	int currentId = 0;
	firstId = 0;
	lastId = firstId;
	while (lastId < p.item.size() && p.item[lastId] != -1) lastId++;
	lastId--;
	TimeLine prevTil, nextTil;
	vector<int> svttype1, svttype2;
	vector<frequencyItem> Stemp1, Stemp2;
	while(true)
	{
		if (currentId == itemSize) break;
		
		for (i = 0; i < size; i++)
		{
			//use the corresponding time index to determine the VTPs for type-1 patterns.
			if(currentId == 0){
				svttype1 = generateBEPType1(p.pTir[i].sId, p.pTir[i].til[currentId], seq[p.pTir[i].sId].timeOcc);
				//for each item in the VTPs of type-1 pattern, add one to its support.
				generateStempType1(svttype1, Stemp1);
				svttype1.clear();
			}
			//use the corresponding time index to determine the VTPs for type-2 patterns.
			if (currentId == 0) prevTil = TimeLine();
			else prevTil = p.pTir[i].til[currentId - 1];
			if (currentId < itemSize - 1) nextTil = p.pTir[i].til[currentId + 1];
			else nextTil = TimeLine();
			svttype2 = generateBEPType2_1(p.pTir[i].sId, p.pTir[i].til[currentId], seq[p.pTir[i].sId].timeOcc, prevTil, nextTil);
			//for each item in the VTPs of type-2 pattern, add one to its support.
			generateBEPStempType2(p, svttype2, Stemp2, firstId, lastId);
			svttype2.clear();
		}
		for (j = 0; j < Stemp1.size(); j++)
		{
			if (Stemp1[j].frequency == p.frequency)
				return false;
		}
		Stemp1.clear();
		for (j = 0; j < Stemp2.size(); j++)
		{
			if (Stemp2[j].frequency == p.frequency)
				return false;
		}
		Stemp2.clear();
		firstId = lastId + 2;
		lastId = firstId;
		while (lastId < p.item.size() && p.item[lastId] != -1) lastId++;
		lastId--;
		currentId++;
	}
	return true;
}

vector<int> SequentialDatabase::generateBEPType1(int sId, TimeLine til, vector<int> ot)
{
	int i, j, k, ub, lb;
	vector<int> temp;
	vector<int>::iterator iter;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - maxgap;
		ub = til.tir[i].lastStartTime - mingap;

		for (j = 0; j < ot.size(); j++)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				for (k = 0; k < seq[sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(), temp.end(), seq[sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType2(int sId, TimeLine til, vector<int> ot)
{
	int i, j, k, lb, ub;
	vector<int> temp;
	vector<int>::iterator iter;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;

		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				for (k = 0; k < seq[sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType2_1(int sId, TimeLine til, vector<int> ot,
	TimeLine prevTil, TimeLine nextTil)
{
	int start, end;
	int i, j, k, ub, lb;
	bool prevValid = true, nextValid = true;
	vector<int> temp;
	vector<int>::iterator iter;
	for (i = 0; i < til.tir.size(); i++)
	{
		lb = til.tir[i].lastEndTime - swin;
		ub = til.tir[i].lastStartTime + swin;

		for (j = 0; j < ot.size(); j++)
		{
			if (lb <= ot[j] && ot[j] <= ub)
			{
				if (ot[j] <= til.tir[i].lastStartTime)
				{ 
					start = ot[j];
					end = til.tir[i].lastEndTime;
				}
				else if (ot[j] >= til.tir[i].lastEndTime)
				{
					start = til.tir[i].lastStartTime;
					end = ot[j];
				}
				prevValid = false;
				if(prevTil.tir.size() > 0)
				{
					for(k=0; k < prevTil.tir.size(); k++)
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
				nextValid = false;
				if (prevValid && nextTil.tir.size() > 0)
				{
					for(k=0; k < nextTil.tir.size(); k++)
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
				if(prevValid && nextValid){
					for (k = 0; k < seq[sId].trans[j].t.size(); k++)
					{
						iter = find(temp.begin(), temp.end(), seq[sId].trans[j].t[k]);
						if (iter == temp.end())
						{
							temp.push_back(seq[sId].trans[j].t[k]);
						}
					}
				}
			}
		}
	}
	return temp;
}

void SequentialDatabase::generateBEPStempType2(frequencyItem p, vector<int> svttype2, 
	vector<frequencyItem> & Stemp2, int firstId, int lastId)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;

	for (int j = 0; j < svttype2.size(); j++)
	{
		if (p.item[lastId] < svttype2[j] || p.item[firstId] > svttype2[j])
		{
			temp.item.push_back(svttype2[j]);
			iter = find(Stemp2.begin(), Stemp2.end(), temp);
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