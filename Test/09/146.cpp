#include<stdio.h>
#include<math.h>

int main()
{
	float s;
	
	while(scanf("%f",&s))
	{
		printf("%.0f\n",ceil(s/0.238));
	}
	return 0;
}
