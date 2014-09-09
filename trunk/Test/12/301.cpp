#include<stdio.h>
int main()
{
	int test;
	int n;
	int a,b,c,d;
	scanf("%d",&test);
	int rs;
	
	while(test--)
	{
		rs=0;
		scanf("%d",&n);
		scanf("%d%d",&a,&b);
		n--;
		
		while(n--)
		{
			scanf("%d%d",&c,&d);
			if(c<=b)
			{
				b=d;
			}
			else
			{
				rs+=b-a;
				a=c;
				b=d;
			}
		}
		rs+=b-a;
		printf("%d\n",rs);
	}
	return 0;
}
