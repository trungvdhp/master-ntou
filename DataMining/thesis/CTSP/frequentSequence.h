// frequentSequence.h: interface for the frequentSequence class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FREQUENTSEQUENCE_H__F095D39F_BFDD_485B_8E8E_938B3DADA378__INCLUDED_)
#define AFX_FREQUENTSEQUENCE_H__F095D39F_BFDD_485B_8E8E_938B3DADA378__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "frequencyItem.h"
#include "ctsp.h"
class frequentSequence  
{
public:
	frequentSequence();
	virtual ~frequentSequence();
	vector<frequencyItem> freSeq;


};

#endif // !defined(AFX_FREQUENTSEQUENCE_H__F095D39F_BFDD_485B_8E8E_938B3DADA378__INCLUDED_)
