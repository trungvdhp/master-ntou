#include<stdio.h>
#include<string.h>
#include<malloc.h>
#include<stdlib.h>
int a[100][100];
int b[100][100];

int main()
{
	int n;
	int r,c,v;
	scanf("%d",&n);
	char s[100];
	char *p;
	
	while(scanf("%s",&s)>0)
	{
		//p=s;
		p=strdup(s);
		//Remove first "("
		p++;
		//printf("%s ",p);
		p=strtok(p,":");
		//printf("%s ",p);
		r=atoi(p);
		p=strtok(NULL,")");
		//printf("%s ",p);
		c=atoi(p);
		p=strtok(NULL,"=");
		//printf("%s ",p);
		v=atoi(p);
		//printf("\n");
		a[r][c]=v;
	}
	
	for(int i=1;i<=n;i++)
	{
		for(int j=1;j<=n;j++)
		{
			// Tung gia tri tren hang i nhan voi hang j
			for(int k=1;k<=n;k++)
			{
				b[i][j]+=a[i][k]*a[j][k];
			}
		}
	}
	
	for(int i=1;i<=n;i++)
	{
		for(int j=1;j<=n;j++)
		{
			printf("%d ",b[i][j]);
		}
		printf("\n");
	}
	
	return 0;
}
