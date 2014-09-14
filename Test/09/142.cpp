#include<stdio.h>

int main()
{
	int a,b;
	
	while(scanf("%d%d",&a,&b))
	{
		a=a+b;
		printf("%d\n",a*a);
	}
	return 0;
}
