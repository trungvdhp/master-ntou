#include<stdio.h>
int main()
{
	int a,b,c,d;
	int x,y,z;
	scanf("%d%d%d%d",&a,&b,&c,&d);
	z=d/c+1;
	y=d/b+1;
	
	for(int i=0;i<z;i++)
	{
		for(int j=0;j<y;j++)
		{
			x=d-j*b-i*c;
			if(x>=0 && x%a==0)
			{
				printf("%d %d %d\n",x/a,j,i);
			}
		}
	}
	return 0;
}
