// SequentialDatabase.h: interface for the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_)
#define AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Sequential.h"
#include "frequencyItem.h"
class SequentialDatabase  
{
public:
	// Generate stems type
	void generateStempType1(vector<int> & sviType1, vector<frequencyItem> & Stemp1);
	void generateStempType2(vector<int> & sviType2, vector<frequencyItem> & Stemp2, int lastItem);

	// FEP: select valid items
	vector<int> generateFEPType1(int sId, TimeLine & til, vector<int> & ot);
	vector<int> generateFEPType2(int sId, TimeLine & til, vector<int> & ot);
	vector<int> generateFEPType2(int sId, TimeLine & til, TimeLine & prevTil, vector<int> & ot);

	// FEP valid
	bool FEP(frequencyItem & p, vector<frequencyItem> & Stemp1, vector<frequencyItem> & Stemp2);

	// BEP: generate stemps type 2
	void generateBEPStempType2(frequencyItem & p, vector<int> & sviType2, vector<frequencyItem> & Stemp2, int firstId, int lastId);

	// BEP: select valid items
	vector<int> generateBEPType1(int sId, TimeLine & til, vector<int> & ot);
	vector<int> generateBEPType2(int sId, TimeLine & til, vector<int> & ot);
	vector<int> generateBEPType2_1(int sId, TimeLine & til, vector<int> & ot,
		TimeLine & prevTil = TimeLine(), TimeLine & nextTil = TimeLine());

	// BEP valid
	bool BEP(frequencyItem & p);

	// Update patterns
	frequencyItem updateType1Pattern(frequencyItem & p,frequencyItem & x);
	frequencyItem updateType2Pattern(frequencyItem & p,frequencyItem & x);
	frequencyItem updateType2Pattern_1(frequencyItem & p,frequencyItem & x);
	// Mining algorithm
	void printFrequencyItem(frequencyItem & p, FILE * out);
	void mineDB(frequencyItem & p);
	void getSequential();
	void scanDB();
	void constructPTidx(frequencyItem & p);
	void generateSequentialPattern();
	void execute();

	// Constructor and destructor
	SequentialDatabase(char * inFileName, char * outFileName);
	virtual ~SequentialDatabase();

	// Define variables
	vector<Sequential> seq;
	FILE * in, * out;
	int * frequency;
	//int current;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__61D19693_54D8_400C_9BA7_2A0CA420ACA2__INCLUDED_)
