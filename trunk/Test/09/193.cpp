#include<stdio.h>
int main()
{
	int a,b,c;
	int n,m;
	scanf("%d%d%d",&a,&b,&c);
	n=c/a+1;
	
	for(int x=0;x<n;x++)
	{
		m=c-a*x;
		if(m%b==0)
		{
			printf("%d,%d\n",x,m/b);
		}
	}
	return 0;
}
