#include<stdio.h>
int main()
{
	int n;
	float a,c,r;
	
	while(scanf("%d",&n))
	{
		a=50000;
		c=10000;
		r=35.2;
		
		for(int i=0;i<n;i++)
		{
			a=a*1.36;
			c=c*1.02;
			r=r-0.2;
		}
		printf("The Company will earn %d US dollars after %d year\n",int((a-c)/r),n);
	}
}
