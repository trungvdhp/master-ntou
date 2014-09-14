#include<stdio.h>
int main()
{
	int n;
	double rs=0;
	double m=1;
	double d=1;
	scanf("%d",&n);
	for(int i=1;i<=n;i++)
	{
		rs+=d/m;
		m+=2;
		d=-d;
		printf("%d ",i);
		printf("%.16f ",rs);
	}
	printf("%.16f",rs);
	return 0;
}
