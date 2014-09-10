#include<stdio.h>
int main()
{
	int n,m;
	int i,j;
	int u,v;
	int check;
	int a[10][10];
	int b[100][100];
	scanf("%d",&n);
	
	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		{
			scanf("%d",&a[i][j]);
		}
	}
	scanf("%d",&m);
	
	for(i=0;i<m;i++)
	{
		for(j=0;j<m;j++)
		{
			scanf("%d",&b[i][j]);
		}
	}
	m=m-n;
	for(i=0;i<m;i++)
	{
		for(j=0;j<m;j++)
		{
			check=1;
			for(u=0;u<n;u++)
			{
				for(v=0;v<n;v++)
				{
					if(a[u][v]!=b[i+u][j+v])
					{
						check=0;
						break;
					}
				}
				if(check==0)
					break;
			}
			if(check)
			{
				printf("%d %d\n",i+1,j+1);
			}
		}
	}
	return 0;
}
