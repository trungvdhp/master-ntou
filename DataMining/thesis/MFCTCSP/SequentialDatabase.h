// SequentialDatabase.h: interface for the SequentialDatabase class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)
#define AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "Sequential.h"
#include "mfctcsp.h"
#include "frequencyPattern.h"
#include "TimeIntervalRecord1.h"
#include <map>
class SequentialDatabase  
{
public:
	// Generate stems type no termination criterial
	void generateStempType1(vector<int> & sviType1, vector<int> & Stemp1, vector<int> & frequencyStemp1);
	void generateStempType2(vector<int> & sviType2, vector<int> & Stemp2, vector<int> & frequencyStemp2, int lastItem);

	// Generate stems type with termination criterial
	bool generateStempType_1(vector<int> & sviType1, vector<int> & Stemp1, vector<int> & frequencyStemp1, 
		int & maxT, int minT);
	bool generateStempType_2(vector<int> & sviType2, vector<int> & Stemp2, vector<int> & frequencyStemp2, 
		int lastItem, int & maxT, int minT);

	// FEP: select valid items
	vector<int> generateFEPType_1(int sId, TimeLine & til);
	vector<int> generateFEPType_2(int sId, TimeLine & til);
	vector<int> generateFEPType_2(int sId, TimeLine & til, TimeLine & prevTil);

	// FEP: no termination criterial
	bool FEPValid_1(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1,
		vector<int> & Stemp2, vector<int> & frequencyStemp2);

	// FEP: with ternimation criterial
	bool FEPValid_2(frequencyPattern & p, vector<int> & Stemp1, vector<int> & frequencyStemp1,
		vector<int> & Stemp2, vector<int> & frequencyStemp2, bool & check1, bool & check2);
	
	// BEP: select valid items
	vector<int> generateBEPType_1(int sId, TimeLine & til);
	vector<int> generateBEPType_2(int sId, TimeLine & til, TimeLine & prevTil, 
		TimeLine & nextTil, int firstItem, int lastItem);

	// BEP: no termination criterial
	bool BEPValid_1(frequencyPattern & p);

	// BEP: with termination criterial
	bool BEPValid_2(frequencyPattern & p);

	// Update pattern
	frequencyPattern updateType1Pattern(frequencyPattern & p, int x);
	frequencyPattern updateType2Pattern(frequencyPattern & p, int x);
	frequencyPattern updateType2Pattern_1(frequencyPattern & p, int x);

	// Pattern generation algorithm
	void scanDB();
	void patternGenerationAlgorithm(frequencyPattern & p);
	void generatePTir(frequencyPattern & p);
	void deleteInfrequentItem();
	void execute();

	// Constructor and destructor
	SequentialDatabase(char * inFileName,char * outFileName);
	virtual ~SequentialDatabase();

	// Define variables
	vector<Sequential> sequential;
	FILE * in,* out;
	int * frequency;
//private:
//	int current;
};

#endif // !defined(AFX_SEQUENTIALDATABASE_H__936CB01E_139E_4FB0_8109_68BD741A5376__INCLUDED_)
