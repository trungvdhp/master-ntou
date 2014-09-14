#include<stdio.h>

int main()
{
	int x,y;
	
	while(scanf("%d%d",&x,&y))
	{
		x=x*x+y*y;
		
		if(x<=10000)
		{
			printf("inside\n");
		}
		else
		{
			printf("outside\n");
		}
	}
	
	return 0;
}
