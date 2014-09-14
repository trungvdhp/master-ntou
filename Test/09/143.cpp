#include<stdio.h>

int main()
{
	int n;
	
	while(scanf("%d",&n))
	{
		if(n>31)
		{
			printf("Value of more than 31\n");
		}
		else
		{
			printf("%d\n",1<<n);
		}
	}
	return 0;
}
