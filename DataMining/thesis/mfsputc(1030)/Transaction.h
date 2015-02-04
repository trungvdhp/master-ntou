// Transaction.h: interface for the Transaction class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_TRANSACTION_H__7D1D9072_2847_4E2B_8D4E_51B257D6FA30__INCLUDED_)
#define AFX_TRANSACTION_H__7D1D9072_2847_4E2B_8D4E_51B257D6FA30__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "Element.h"
class Transaction  
{
public:
	void insertItem(int item);
	void setTimeOcc(int time);
	Transaction();
	virtual ~Transaction();
	int timeOcc;
	Element element;
};

#endif // !defined(AFX_TRANSACTION_H__7D1D9072_2847_4E2B_8D4E_51B257D6FA30__INCLUDED_)
