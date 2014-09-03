#include<stdio.h>
int main()
{
	int n;
	int m;
	int rs=0;
	scanf("%d",&n);
	while(n--)
	{
		scanf("%d",&m);
		if(m>=2)
		{
			for(int i=m;i>=2;i--)
				rs+=(i+1)*i*(i-1);
		}
		printf("%d\n",rs);
	}
	return 0;
}
