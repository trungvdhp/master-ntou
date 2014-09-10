#include<stdio.h>
int rdn(int y, int m, int d) 
{ 	
	/* Rata Die day one is 0001-01-01 */
    if (m < 3)
		y--, m += 12;
    return 365*y + y/4 - y/100 + y/400 + (153*m - 457)/5 + d - 306;
}

int main()
{
	int y,m,d;
	int rs=-1;
	scanf("%d%d%d",&y,&m,&d);
	rs-=rdn(y,m,d);
	scanf("%d%d%d",&y,&m,&d);
	rs+=rdn(y,m,d);
	printf("%d",rs);
	return 0;
}
