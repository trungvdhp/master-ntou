#include<stdio.h>

int main()
{
	int n;
	
	while(scanf("%d",&n))
	{
		if(n<6) n=0;
		else
		{
			n=(n-6)/12+1;
			n=6*n*n;
		}
		printf("%d\n",n);
	}
}
