// Element.cpp: implementation of the Element class.
//
//////////////////////////////////////////////////////////////////////

#include "Element.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

Element::Element()
{

}

Element::~Element()
{
	items.clear();
}

void Element::output(FILE *out)
{
	int i;
	fprintf(out,"%d",items[0]);
	for (i = 1; i < items.size(); i++)
		fprintf(out," %d",items[i]);
}
