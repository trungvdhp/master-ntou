#include<stdio.h>
#include<math.h>
int a[20][2];
int main()
{
	int test;
	int dis;
	scanf("%d",&test);
	while(test--)
	{
		int max=0;
		int k;
		scanf("%d",&k);
		for(int i=0;i<k;i++)
		{
			scanf("%d%d",&a[i][0],&a[i][1]);
		}
		for(int i=0;i<k;i++)
		{
			for(int j=i+1;j<k;j++)
			{
				dis=(int)(pow(a[i][0]-a[j][0],2)+pow(a[i][1]-a[j][1],2));
				if(dis>max) max=dis;
			}
		}
		printf("%d\n",max);
	}
	return 0;
}
