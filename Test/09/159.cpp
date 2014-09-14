#include<stdio.h>
int main()
{
	int n;
	double rs;
	while(scanf("%d",&n))
	{
		n=n/3;
		printf("%.0f\n",(n*(n+1)*3.0f)/2);
	}
	return 0;
}
