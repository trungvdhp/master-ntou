#include<stdio.h>

int main()
{
	float  a,b,h;
	
	while(scanf("%f%f%f",&a,&b,&h))
	{
		printf("%.1f\n",(a+b)*h/2);
	}
	return 0;
}

