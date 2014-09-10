#include<stdio.h>
int sumdigits(int a)
{
	int rs=0;
	while(a)
	{
		rs+=a%10;
		a=a/10;
	}
	return rs;
}
int main()
{
	int a,b;
	scanf("%d",&b);
	a=sumdigits(b);
	scanf("%d",&b);
	a+=sumdigits(b);
	scanf("%d",&b);
	a+=sumdigits(b);
	while(a>9)
	{
		a=sumdigits(a);
	}
	printf("%d",a);
	return 0;
}
