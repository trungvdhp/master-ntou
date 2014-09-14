#include<stdio.h>
int main()
{
	int h,r;
	int x,y,z;
	
	while(scanf("%d%d",&h,&r))
	{
		if(h-60>=0) 
		{
			x=60;
			
			if(h-120>=0)
			{
				y=60;
				z=h-120;
			}
			else
			{
				y=h-60;
				z=0;
			}
		}
		else
		{
			x=h;
			y=0;
			z=0;
		}
		printf("%.0f\n",(x+y*1.33+z*1.66)*r);
	}
	return 0;
}
