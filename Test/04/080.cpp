#include<stdio.h>
using namespace std;

int main()
{
	int n=0;
	/*int k=0;
	int FS[100];
	FS[0]=0;
	FS[1]=5;

	int f1,f2;
	
	while(n<100)
	{
		f1=FS[k]+5;
		
		if(FS[n]<f1)
		{
			FS[++n]=f1;
			printf("%d ",f1);
		}
		
		f1=FS[k]+7;
		f2=FS[k+1]+5;
		
		if(f1<f2)
		{
			if(FS[n]<f1)
			{
				FS[++n]=f1;
				printf("%d ",f1);
			}
		}
		else if(f1>f2)
		{
			if(FS[n]<f2)
			{
				FS[++n]=f2;
				printf("%d ",f2);
			}
			if(FS[n]<f1)
			{
				FS[++n]=f1;
				printf("%d ",f1);
			}
		}
		k++;
	}*/
	
	int f[12]={0,5,7,10,12,14,15,17,19,20,21,22};
	
	while(scanf("%d",&n))
	{
		if(n<13)
		{
			printf("%d\n",f[n-1]);
		}
		else
		{
			printf("%d\n",n+11);
		}
	}
	
	return 0;
}
