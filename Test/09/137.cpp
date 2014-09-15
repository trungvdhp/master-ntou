#include<stdio.h>

int main()
{
	float  a,h;
	
	while(scanf("%f%f",&a,&h))
	{
		printf("%.1f\n",a*h/2);
	}
	return 0;
}

