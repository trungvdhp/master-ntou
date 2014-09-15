#include<stdio.h>

int largestprime(int n)
{
	int i;
	
	for(i=n-1;i>=2;i--) 
	{
	}
	return -1;
}

int main()
{
	int n,a;
	
	while(scanf("%d",&n))
	{
		a=largestprime(n);
		
		if(a==-1)
			printf("No largest prime less than %d found\n",n);
		else
			printf("%d\n",a);
	}
	return 0;
}

