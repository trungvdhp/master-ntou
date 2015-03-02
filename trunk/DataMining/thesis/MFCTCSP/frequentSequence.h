// frequentSequence.h: interface for the frequentSequence class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FREQUENTSEQUENCE_H__33A5D775_E761_4D5E_A1AD_98AC46A341D8__INCLUDED_)
#define AFX_FREQUENTSEQUENCE_H__33A5D775_E761_4D5E_A1AD_98AC46A341D8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "frequencyPattern.h"
#include "mfctcsp.h"
class frequentSequence  
{
public:
	void output(FILE * out);
	frequentSequence();
	virtual ~frequentSequence();
	vector<frequencyPattern> _frequentSequency;
};

#endif // !defined(AFX_FREQUENTSEQUENCE_H__33A5D775_E761_4D5E_A1AD_98AC46A341D8__INCLUDED_)
