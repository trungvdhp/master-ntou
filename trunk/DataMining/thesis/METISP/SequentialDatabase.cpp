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
}

SequentialDatabase::~SequentialDatabase()
{
	seq.clear();
	freSeqSet.clear();
	if (in)
		fclose(in);
	delete [] frequency;

}
// 
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

	for (i = 0; i < seq.size(); i++)
	{
		for (j = 0; j<seq[i].trans.size(); j++)
		{
			for (k = 0; k < seq[i].trans[j].t.size(); k++)
			{
				it = find(frequencySet.begin(), frequencySet.end(), seq[i].trans[j].t[k]);
				if(it == frequencySet.end())
				{
					frequencySet.push_back(seq[i].trans[j].t[k]);
				}
			}
		}

		for (j = 0; j < frequencySet.size(); j++)
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
	for (i = 0; i < freSeqSet.size(); i++)
	{
		for (j = 0 ;j < freSeqSet[i].freSeq.size(); j++)
		{
			fout << "{";
			fout << "{" << freSeqSet[i].freSeq[j].item[0];
			for (k = 1 ;k < freSeqSet[i].freSeq[j].item.size(); k++)
			{
				if (freSeqSet[i].freSeq[j].item[k] == -1)
				{
					fout << "} {";
				}
				else if (freSeqSet[i].freSeq[j].item[k-1] == -1)
				{
					fout << freSeqSet[i].freSeq[j].item[k];
				}
				else
				{
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

	int i;
	THRESHOLD = min_sup * seq.size();
	frequencyItem freItem;

	for (i = 0; i < ITEM_NO; i++)
	{
		if (frequency[i] >= THRESHOLD)
		{
			freItem.item.push_back(i) ;
			freItem.frequency = frequency[i];
			constructPTidx(freItem);
			mineDB(freItem, 1);
			freItem.item.clear();
		}
	}
}
//Scan the transactional database D to construct p-Tidx, where p-Tidx is the time index of p
void SequentialDatabase::constructPTidx(frequencyItem & p)
{
	int sid,tid;
	int pStartItem = p.item[0];
	int plastItem = p.item[p.item.size()-1];
	bool pair = false;	
	vector<int>::iterator iter;

	for (sid = 0; sid < seq.size(); sid++)
	{
		for (tid = 0 ; tid < seq[sid].trans.size() ; tid++)
		{
			iter = find(seq[sid].trans[tid].t.begin(),seq[sid].trans[tid].t.end(),pStartItem);
			if (iter != seq[sid].trans[tid].t.end())
			{
				p.insertTir(sid, seq[sid].timeOcc[tid], seq[sid].timeOcc[tid], seq[sid].timeOcc[tid]);
			}
		}
	}
}

void SequentialDatabase::generateStempType1(vector<int> svttype1, vector<frequencyItem> * Stemp1)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;
	//for each item in the VTPs of type-1 pattern, add one to its support.
	for (int j = 0; j < svttype1.size();j++)
	{
		temp.item.push_back(svttype1[j]);
		iter = find((*Stemp1).begin(), (*Stemp1).end(), temp);
		if (iter != (*Stemp1).end())
		{
			(*iter).frequency++;
		}
		else
		{
			temp.frequency = 1;
			(*Stemp1).push_back(temp);
		}
		temp.item.clear();
	}
}

void SequentialDatabase::generateStempType2(frequencyItem p, vector<int> svttype2, vector<frequencyItem> * Stemp2)
{
	frequencyItem temp;
	vector<frequencyItem>::iterator iter;
	for (int j = 0; j < svttype2.size(); j++)
	{
		if (p.item[p.item.size() - 1] < svttype2[j])
		{
			temp.item.push_back(svttype2[j]);
			iter = find((*Stemp2).begin(), (*Stemp2).end(), temp);
			if (iter != (*Stemp2).end())
			{
				(*iter).frequency++;
			}
			else
			{
				temp.frequency = 1;
				(*Stemp2).push_back(temp);
			}
			temp.item.clear();
		}
	}
}

bool SequentialDatabase::FEP(frequencyItem p, vector<frequencyItem> * Stemp1, vector<frequencyItem> * Stemp2)
{
	int i;
	vector<int> svttype1,svttype2;

	for (i = 0; i < p.pTir.size(); i++)
	{
		//use the corresponding time index to determine the VTPs for type-1 patterns.
		svttype1 = generateFEPType1(p.pTir[i],seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-1 pattern, add one to its support.
		generateStempType1(svttype1, Stemp1);
		svttype1.clear();
		//use the corresponding time index to determine the VTPs for type-2 patterns.
		svttype2 = generateFEPType2(p.pTir[i],seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-2 pattern, add one to its support.
		generateStempType2(p, svttype2, Stemp2);
		svttype2.clear();
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < (*Stemp1).size(); i++)
		if ((*Stemp1)[i].frequency == p.frequency)
			return false;
	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < (*Stemp2).size(); i++)
		if ((*Stemp2)[i].frequency == p.frequency)
			return false;
	return true;
}

void SequentialDatabase::mineDB(frequencyItem p, int count)
{
	int i;
	vector<frequencyItem> Stemp1,Stemp2;
	frequencyItem p_;
	if (FEP(p, &Stemp1, &Stemp2))
	{
		if (BEP(p))
		{
			while (freSeqSet.size() < count)
			{
				frequentSequence Sp;
				freSeqSet.push_back(Sp);
			}
			freSeqSet[count-1].freSeq.push_back(p);
		}
	}
	//for each item x found in VTPs of type-1 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp1.size(); i++)
	{
		if (Stemp1[i].frequency >= THRESHOLD)
		{
			p_ = updateType1Pattern(p, Stemp1[i], &count);
		
			mineDB(p_, count);
		}
	}

	//for each item x found in VTPs of type-2 pattern with support >= minsup X |D|
	for (i = 0; i < Stemp2.size(); i++)
	{
		if (Stemp2[i].frequency >= THRESHOLD)
		{
			p_ = updateType2Pattern(p, Stemp2[i], &count);
			
			mineDB(p_, count);
		}
	}
}

vector<int> SequentialDatabase::generateFEPType1(TimeIntervalRecord1 tir1,vector<int> ot)
{
	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub,lb;
	for (i = 0; i < tir1.tir.size(); i++)
	{
		lb = tir1.tir[i].lastEndTime + mingap;
		ub = tir1.tir[i].lastStartTime + maxgap;
		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				for (k = 0; k < seq[tir1.sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[tir1.sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[tir1.sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateFEPType2(TimeIntervalRecord1 tir1,vector<int> ot)
{

	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub,lb;
	for (i = 0; i < tir1.tir.size(); i++)
	{
		lb = tir1.tir[i].lastEndTime - swin;
		ub = tir1.tir[i].lastStartTime + swin;
		for (j = 0; j < ot.size() ; j++)
		{
			if (lb <= ot[j] && ot[j] <= ub )
			{
				for (k = 0; k < seq[tir1.sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[tir1.sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[tir1.sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}

frequencyItem SequentialDatabase::updateType1Pattern(frequencyItem p,frequencyItem x, int * count)
{
	frequencyItem p_;
	int i , j,k = 0,l,ub,lb;
	*count = 0;
	for (i = 0; i < p.item.size(); i++ )
	{
		if (p.item[i] != -1)
			(*count)++;
		p_.item.push_back(p.item[i]);
	}
	p_.item.push_back(-1);
	for (i = 0; i < x.item.size();i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;

	for (i = 0; i < p.pTir.size(); i++)
	{
		for (j = 0; j < p.pTir[i].tir.size() ; j++)
		{
			lb =  p.pTir[i].tir[j].lastEndTime + mingap;
			ub = p.pTir[i].tir[j].lastStartTime + maxgap;
			for (k = 0; k < seq[p.pTir[i].sId].timeOcc.size() ; k++)
			{
				if (lb <= seq[p.pTir[i].sId].timeOcc[k] && seq[p.pTir[i].sId].timeOcc[k] <= ub )
				{
					for (l = 0; l < seq[p.pTir[i].sId].trans[k].t.size(); l++)
					{
						if (seq[p.pTir[i].sId].trans[k].t[l] == x.item[0])
						{
							p_.insertTir(p.pTir[i].sId, p.pTir[i].tir[j].initialTime, seq[p.pTir[i].sId].timeOcc[k], seq[p.pTir[i].sId].timeOcc[k]);
						}
					}
				}
			}
		}
	}
	return p_;
}

frequencyItem SequentialDatabase::updateType2Pattern(frequencyItem p,frequencyItem x, int * count)
{
	frequencyItem p_;
	int i , j, k = 0, l, ub ,lb;
	*count = 0;
	for (i = 0; i < p.item.size(); i++ )
	{
		if (p.item[i] != -1)
			(*count)++;
		p_.item.push_back(p.item[i]);
	}
	for (i = 0; i < x.item.size(); i++)
		p_.item.push_back(x.item[i]);
	p_.frequency = x.frequency;


	for (i = 0; i < p.pTir.size(); i++)
	{
		for (j = 0; j < p.pTir[i].tir.size() ; j++)
		{
			lb =  p.pTir[i].tir[j].lastEndTime - swin;
			ub = p.pTir[i].tir[j].lastStartTime + swin;
			for (k = 0; k < seq[p.pTir[i].sId].timeOcc.size() ; k++)
			{
				if (lb <= seq[p.pTir[i].sId].timeOcc[k] && seq[p.pTir[i].sId].timeOcc[k] <= ub )
				{
					for (l = 0; l < seq[p.pTir[i].sId].trans[k].t.size(); l++)
					{
						if (seq[p.pTir[i].sId].trans[k].t[l] == x.item[0])
						{
							if (p.pTir[i].sId, p.pTir[i].tir[j].initialTime < seq[p.pTir[i].sId].timeOcc[k])
								p_.insertTir(p.pTir[i].sId, p.pTir[i].tir[j].initialTime, seq[p.pTir[i].sId].timeOcc[k], seq[p.pTir[i].sId].timeOcc[k]);
							else
								p_.insertTir(p.pTir[i].sId, seq[p.pTir[i].sId].timeOcc[k], seq[p.pTir[i].sId].timeOcc[k], p.pTir[i].tir[j].lastEndTime);
						}
					}
				}
			}
		}
	}
	return p_;
}

bool SequentialDatabase::BEP(frequencyItem p)
{
	int i;
	vector<int> svttype1, svttype2;
	vector<frequencyItem> Stemp1, Stemp2;

	for (i = 0; i < p.pTir.size(); i++)
	{
		//use the corresponding time index to determine the VTPs for type-1 patterns.
		svttype1 = generateBEPType1(p.pTir[i], seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-1 pattern, add one to its support.
		generateStempType1(svttype1, &Stemp1);
		svttype1.clear();
		//use the corresponding time index to determine the VTPs for type-2 patterns.
		svttype2 = generateBEPType2(p.pTir[i], seq[p.pTir[i].sId].timeOcc);
		//for each item in the VTPs of type-2 pattern, add one to its support.
		generateStempType2(p, svttype2, &Stemp2);
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

vector<int> SequentialDatabase::generateBEPType1(TimeIntervalRecord1 tir1,vector<int> ot)
{
	vector<int> temp;
	vector<int>::iterator iter;
	int i,k,ub,lb;
	lb = tir1.tir[0].lastEndTime - maxgap;
	ub = tir1.tir[0].initialTime - mingap;

	for (i = 0; i < ot.size() ; i++)
	{
		if (lb <= ot[i] && ot[i] <= ub )
		{
			for (k = 0; k < seq[tir1.sId].trans[i].t.size(); k++)
			{
				iter = find(temp.begin(),temp.end(),seq[tir1.sId].trans[i].t[k]);
				if (iter == temp.end())
				{
					temp.push_back(seq[tir1.sId].trans[i].t[k]);
				}
			}
		}
	}
	return temp;
}

vector<int> SequentialDatabase::generateBEPType2(TimeIntervalRecord1 tir1,vector<int> ot)
{

	vector<int> temp;
	vector<int>::iterator iter;
	int i,j,k,ub1,lb1, ub2, lb2;
	for (i = 0; i < tir1.tir.size(); i++)
	{
		lb1 = tir1.tir[i].lastEndTime - swin;
		ub1 = tir1.tir[i].initialTime;
		lb2 = tir1.tir[i].lastEndTime;
		ub2 = tir1.tir[i].initialTime + swin;

		for (j = 0; j < ot.size() ; j++)
		{
			if ((lb1 <= ot[j] && ot[j] <= ub1) || (lb2 <= ot[j] && ot[j] <= ub2))
			{
				for (k = 0; k < seq[tir1.sId].trans[j].t.size(); k++)
				{
					iter = find(temp.begin(),temp.end(),seq[tir1.sId].trans[j].t[k]);
					if (iter == temp.end())
					{
						temp.push_back(seq[tir1.sId].trans[j].t[k]);
					}
				}
			}
		}
	}
	return temp;
}