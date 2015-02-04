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
class SequentialDatabase  
{
public:
	bool FEPValid(frequencyPattern p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2);
	bool isLastItem(int sid,int tid,int iid);
	bool generateSVT(int tid,int it,int lst, vector<Transaction> trans,int x);
	void updateTypePattern(vector<frequencyPattern> & p,int x,int sid,int tid,int iid,int it,int lst,int *& index);
	frequencyPattern updateType1Pattern(frequencyPattern p,frequencyPattern x);
	frequencyPattern updateType2Pattern(frequencyPattern p,frequencyPattern x);
	vector<int> generateSVTType1(TimeIntervalRecord1 tir1,vector<Transaction> trans);
	vector<int> generateSVTType1(int tid, int it, int lst,vector<Transaction> trans);
	vector<int> generateSVTType2(TimeIntervalRecord1 tir1,vector<Transaction> trans);
	vector<int> generateSVTType2(int tid, int it, int lst,vector<Transaction> trans);
	int binarySearch(vector<int> data,int x);
	void generatePTir(frequencyPattern & p);
	void generateUpdateL(frequentSequence Sp);
	void patternGenerationAlgorithm(frequencyPattern p);
	void deleteInfrequentItem();
	void generateL1PTir(frequentSequence & Sp);
	void scanDB();
	void execute();
	SequentialDatabase(char * filename,char * outfilename);
	virtual ~SequentialDatabase();
	FILE * in,* out;
	vector<Sequential> sequential;
	int * frequency;
//	int * order_index;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)
