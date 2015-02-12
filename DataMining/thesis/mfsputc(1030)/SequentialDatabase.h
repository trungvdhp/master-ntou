// SequentialDatabase.h: interface for the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)
#define AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "frequentSequence.h"
#include "Sequential.h"
#include "mfsputc.h"
#include "TimeIntervalRecord1.h"
#include <map>
class SequentialDatabase  
{
public:
	frequencyPattern updateType1Pattern(frequencyPattern p, int x);
	frequencyPattern updateType2Pattern(frequencyPattern p, int x);
	bool FEPValid(frequencyPattern p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2);
	bool FEPValid(frequencyPattern p, map<int, int> & Stemp1, map<int, int> & Stemp2);
	bool BEPValid(frequencyPattern p, bool first=false);
	frequencyPattern updateType1Pattern(frequencyPattern p,frequencyPattern x);
	frequencyPattern updateType2Pattern(frequencyPattern p,frequencyPattern x);
	vector<int> generateFEPType1(int tid, int lst,vector<Transaction> trans);
	void generateFEPType(TimeIntervalRecord1 * pTir,vector<Transaction> trans);
	vector<int> generateFEPType2(int tid, int lst,vector<Transaction> trans);
	vector<int> generateBEPType1(int tid, int lst,vector<Transaction> trans);
	vector<int> generateBEPType2(int tid, int lst,vector<Transaction> trans);
	int binarySearch(vector<int> data,int x);
	void generatePTir(frequencyPattern & p);
	void generateUpdateL(frequentSequence Sp);
	void patternGenerationAlgorithm(frequencyPattern p, bool first=false);
	void deleteInfrequentItem();
	void generateL1PTir(frequentSequence & Sp);
	void scanDB();
	void execute();
	SequentialDatabase(char * filename,char * outfilename);
	virtual ~SequentialDatabase();
	FILE * in,* out;
	vector<Sequential> sequential;
	int * frequency;
private:
	int * Stemp1Index, *Stemp2Index;
	int * Stemp1LastIndex, *Stemp2LastIndex;
	bool * Stemp1Init, *Stemp2Init;
	vector<int> svtType1, svtType2;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)
