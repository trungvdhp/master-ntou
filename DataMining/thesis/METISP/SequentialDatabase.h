// SequentialDatabase.h: interface for the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_)
#define AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Sequential.h"
#include "frequentSequence.h"
class SequentialDatabase  
{
public:
	frequencyItem updateType1Pattern(frequencyItem p,frequencyItem x, int & count);
	frequencyItem updateType2Pattern(frequencyItem p,frequencyItem x, int & count);
	void generateStempType1(vector<int> svttype1, vector<frequencyItem> & Stemp1);
	void generateStempType2(vector<int> svttype2, vector<frequencyItem> & Stemp2, int lastItem);
	void generateBEPStempType2(frequencyItem p, vector<int> svttype2, vector<frequencyItem> & Stemp2, int firstId, int lastId);
	bool FEP(frequencyItem p, vector<frequencyItem> & Stemp1, vector<frequencyItem> & Stemp2);
	vector<int> generateFEPType1(int sId, TimeLine til, vector<int> ot);
	vector<int> generateFEPType2(int sId, TimeLine til, vector<int> ot);
	vector<int> generateBEPType1(int sId, TimeLine til, vector<int> ot);
	vector<int> generateBEPType2(int sId, TimeLine til, vector<int> ot);
	vector<int> generateBEPType2_1(int sId, TimeLine til, vector<int> ot,
		TimeLine prevTil = TimeLine(), TimeLine nextTil = TimeLine());
	bool BEP(frequencyItem p);
	void mineDB(frequencyItem p, int count);
	void constructPTidx(frequencyItem & p);
	void generateSequentialPattern();
	void printFrequencyItem(frequencyItem p);
	void printTimeline(TimeIntervalRecord1 tir1);

	void outputFrequentPattern(char * filename);

	void execute();

	void scanDB();
	SequentialDatabase(char * filename);
	virtual ~SequentialDatabase();
	void getSequential();
	vector<Sequential> seq;
	vector<frequentSequence> freSeqSet;
	FILE * in;
	int  * frequency;
	int current;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_)
