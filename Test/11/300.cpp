#include<stdio.h>
#include<malloc.h>

int main()
{
	int k;
	scanf("%d",&k);
	int*f=(int*)malloc((k+1)*sizeof(int));
	f[0]=1;
	f[1]=2;
	for(int i=2;i<=k;i++)
	{
		f[i]=f[i-1]+f[i/2];
	}
	printf("%d",f[k]);
	return 0;
}
