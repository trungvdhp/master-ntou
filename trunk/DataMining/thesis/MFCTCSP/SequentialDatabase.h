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
#include "mfctcsp.h"
#include "TimeIntervalRecord1.h"
#include <map>
class SequentialDatabase  
{
public:
	vector<int> generateFEPType_1(int sId, TimeLine & til);
	vector<int> generateFEPType_2(int sId, TimeLine & til);
	vector<int> generateFEPType_2(int sId, TimeLine & til, TimeLine & prevTil);
	void generateStempType1(vector<int> & svtType1, vector<int> & Stemp1, vector<int> & frequencyStemp1);
	void generateStempType2(vector<int> & svtType2, vector<int> & Stemp2, vector<int> & frequencyStemp2, int lastItem);
	bool generateStempType_1(vector<int> & svtType1, vector<int> & Stemp1, vector<int> & frequencyStemp1, 
		int & maxT, int minT);
	bool generateStempType_2(vector<int> & svtType2, vector<int> & Stemp2, vector<int> & frequencyStemp2, 
		int lastItem, int & maxT, int minT);
	frequencyPattern updateType1Pattern(frequencyPattern & p, int x);
	frequencyPattern updateType2Pattern(frequencyPattern & p, int x);
	frequencyPattern updateType2Pattern_1(frequencyPattern & p, int x);
	bool FEPValid(frequencyPattern & p, vector<frequencyPattern> & Stemp1, vector<frequencyPattern> & Stemp2);
	bool FEPValid_1(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1,
		vector<int> & Stemp2, vector<int> & frequencyStemp2);
	bool FEPValid_2(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1,
		vector<int> & Stemp2, vector<int> & frequencyStemp2);
	/*bool FEPValid(frequencyPattern p, vector<int> & Stemp1, vector<int> & frequencyStemp1,
		vector<int> & Stemp2, vector<int> & frequencyStemp2);*/
	vector<int> generateBEPType_1(int sId, TimeLine & til);
	vector<int> generateBEPType_2(int sId, TimeLine & til, TimeLine & prevTil, 
		TimeLine & nextTil, int firstItem, int lastItem);
	bool BEPValid(frequencyPattern & p);
	bool BEPValid_1(frequencyPattern & p);
	bool BEPValid_2(frequencyPattern & p);
	frequencyPattern updateType1Pattern(frequencyPattern & p, frequencyPattern x);
	frequencyPattern updateType2Pattern(frequencyPattern & p, frequencyPattern x);
	vector<int> generateFEPType1(int sId, int tId, int lst);
	vector<int> generateFEPType2(int sId, int tId, int lst);
	/*void generateFEPType(TimeIntervalRecord1 * pTir,vector<Transaction> trans);*/
	
	/*void generateBEPType(TimeIntervalRecord1 * pTir,vector<Transaction> trans, vector<Element>::iterator ip);*/
	
	vector<int> generateBEPType1(int tid, int lst,vector<Transaction> & trans);
	vector<int> generateBEPType2(int tid, int lst,vector<Transaction> & trans);
	int binarySearch(vector<int> & data, int x, int low = 0);
	void generatePTir(frequencyPattern & p);
	/*void generateUpdateL(frequentSequence Sp);*/
	void patternGenerationAlgorithm(frequencyPattern & p);
	void deleteInfrequentItem();
	/*void generateL1PTir(frequentSequence & Sp);*/
	void scanDB();
	void execute();
	SequentialDatabase(char * filename,char * outfilename);
	virtual ~SequentialDatabase();
	FILE * in,* out;
	vector<Sequential> sequential;
	int * frequency;
	void printTimeLine(frequencyPattern & p);
private:
	//vector<int> svtType1, svtType2;
	int current;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)