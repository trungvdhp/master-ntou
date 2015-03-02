// Sequential.h: interface for the Sequential class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIAL_H__797278EA_7426_44A6_9BEA_37D6E3C83C77__INCLUDED_)
#define AFX_SEQUENTIAL_H__797278EA_7426_44A6_9BEA_37D6E3C83C77__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "Transaction.h"
class Sequential  
{
public:
	Sequential();
	virtual ~Sequential();
	vector<Transaction> trans;
	vector<int> timeOcc;
};

#endif // !defined(AFX_SEQUENTIAL_H__797278EA_7426_44A6_9BEA_37D6E3C83C77__INCLUDED_)
