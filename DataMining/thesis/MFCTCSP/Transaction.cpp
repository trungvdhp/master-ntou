// Transaction.cpp: implementation of the Transaction class.
//
//////////////////////////////////////////////////////////////////////

#include "Transaction.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

Transaction::Transaction()
{
	timeOcc = 0;
}

Transaction::~Transaction()
{

}

void Transaction::setTimeOcc(const int & time)
{
	timeOcc = time;
}

void Transaction::insertItem(const int & item)
{
	element.items.push_back(item);
}
