#include<stdio.h>
int main()
{
	int n;
	double a[51][51];
	scanf("%d",&n);
	if(n<0||n>50)
	{
		printf("I can only print Pascal's triangle between 0 and 50.");
	}
	else
	{
		n++;
		for(int i=0;i<n;i++)
		{
			a[i][0]=1;
			a[i][i]=1;
			for(int j=1;j<i;j++)
				a[i][j]=a[i-1][j-1]+a[i-1][j];
		}
	
		for(int i=n-1;i>=0;i--)
		{
			for(int j=0;j<=i;j++)
				printf("%.0f ",a[i][j]);
			printf("\n");
		}
		
	}

	return 0;
}
