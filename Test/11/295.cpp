#include<stdio.h>

void bigmul(int*a,int *n, int m)
{
	int rem=0;
	int b;
	
	for(int i=0;i<*n;i++)
	{
		b=m*a[i]+rem;
		a[i]=b%10;
		rem=b/10;
	}
	
	while(rem>0)
	{
		a[(*n)++]=rem%10;
		rem/=10;
	}
}
int main()
{
	int a[1500];
	int k;
	int n=1;
	a[0]=1;
	scanf("%d",&k);
	
	for(int i=2;i<=k;i++)
	{
		bigmul(a,&n,i);
	}
	printf("%d\n",n);
	
	for(int i=n-1;i>=0;i--)
	{
		printf("%d",a[i]);
	}
	
	return 0;
}
