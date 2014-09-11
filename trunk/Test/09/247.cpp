#include<stdio.h>
int main()
{
	int cub1[]={0,1,8,27,64,125,216,343,512,729};
	int cub2[100];
	int i,j,k;
	int a;
	int t;
	
	for(i=1;i<10;i++)
	{
		k=i*10;
		for(j=0;j<10;j++)
		{
			cub2[k+j]=cub1[i]+cub1[j];
		}
	}
	
	for(i=1;i<10;i++)
	{
		for(j=0;j<10;j++)
		{
			t=i*10+j;
			a=t*10;
			
			for(k=0;k<10;k++)
			{
				if(cub2[t]+cub1[k]==a+k)
				{
					printf("%d\n",a+k);
				}
			}
		}
	}
	
	return 0;
}
