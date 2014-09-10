#include<stdio.h>
#include<string.h>
int main()
{
	char item[256];
	char type[9];
	int a;
	int m;
	scanf("%d",&a);
	freopen("q4.in","r",stdin);

	while(scanf("%s%s%d",&item,&type,&m)>0)
	{
		if(strcmp(type,"outgoing")==0)
		{
			a-=m;
		}
		else
		{
			a+=m;
		}
		printf("%s %s %d %d\n",item,type,m,a);
	}
	freopen("q4.out","w",stdout);
	printf("%d",a);
	fclose(stdin);
	fclose(stdout);
	return 0;
}
