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

void Transaction::setTimeOcc(int time)
{
	timeOcc = time;
}

void Transaction::insertItem(int item)
{
	element.items.push_back(item);
}
