#include<stdio.h>

int main()
{
	int n;
	int f[11];
	f[0]=1;
	f[1]=1;
	n=2;
	while(n<11)
	{
		f[n]=f[n-1]*n;
		n++;
	}
	while(scanf("%d",&n))
	{
		printf("%d\n",f[n]);
	}
	return 0;
}
