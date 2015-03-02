// Element.h: interface for the Element class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ELEMENT_H__98D4A878_A469_4E61_96CD_B32DC4240CCC__INCLUDED_)
#define AFX_ELEMENT_H__98D4A878_A469_4E61_96CD_B32DC4240CCC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "mfctcsp.h"
class Element  
{
public:
	Element();
	virtual ~Element();
	void output(FILE * out);
	vector<int> items;
};

#endif // !defined(AFX_ELEMENT_H__98D4A878_A469_4E61_96CD_B32DC4240CCC__INCLUDED_)
