// Sequential.h: interface for the Sequential class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SEQUENTIAL_H__1822E203_1857_4388_BC7D_021778BA2A0C__INCLUDED_)
#define AFX_SEQUENTIAL_H__1822E203_1857_4388_BC7D_021778BA2A0C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <vector>
#include "Transaction.h"
class Sequential  
{
public:
	Sequential();
	virtual ~Sequential();
	vector<Transaction> transaction;
};

#endif // !defined(AFX_SEQUENTIAL_H__1822E203_1857_4388_BC7D_021778BA2A0C__INCLUDED_)
