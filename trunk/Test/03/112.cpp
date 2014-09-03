#include<stdio.h>
int main()
{
	int n;
	char a[10][2];
	int w[10];
	scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		scanf("%s%d",&a[i],&w[i]);
	}
	
	for(int i=0;i<n-2;i++)
	{
		for(int j=i+1;j<n-1;j++)
		{
			for(int k=j+1;k<n;k++)
			{
				if(w[i]+w[j]>w[k]&&w[j]+w[k]>w[i]&&w[i]+w[k]>w[j])
				{
					printf("%s %s %s\n",a[i],a[j],a[k]);
				}
			}
		}
	}
	return 0;
}
