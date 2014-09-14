#include<stdio.h>

int main()
{
	int h,m;
	int ms=0;
	int cost=0;
	scanf("%d%d",&h,&m);
	ms-=h*60+m;
	scanf("%d%d",&h,&m);
	ms+=h*60+m;

	if(ms<=120)
	{
		cost+=30*(ms/30);
	}
	else
	{
		cost+=120;
		ms-=120;
		
		if(ms<=120)
		{
			cost+=40*(ms/30);
		}
		else
		{
			ms-=120;
			cost+=160;
			cost+=60*(ms/30);	
		}
	}
	printf("%d",cost);
	return 0;
}
