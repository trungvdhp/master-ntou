#include<stdio.h>

int main()
{
	int a,n;
	
	while(scanf("%d",&n))
	{
		a=35;
		
		while(a<=n)
		{
			printf("%d ",a);
			a+=35;
		}
		printf("\n");
	}
	return 0;
}
