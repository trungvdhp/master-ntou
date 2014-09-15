#include<stdio.h>
#include<math.h>

int main()
{
	int a,b;
	
	while(scanf("%d%d",&a,&b))
	{
		printf("%d\n",(abs(a-b)+1)*(a+b)/2);
	}
	return 0;
}
