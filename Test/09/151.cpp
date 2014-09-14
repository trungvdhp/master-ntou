#include<stdio.h>
int ucln(int a, int b)
{                  
    if (a==0 ||b==0)
		return a+b;
    int c;
    
    while (a%b)
    {
       c=a;
       a=b;
       b=c%b;
    }
    return b;
}

int main()
{
	int n,m;
	
	while(scanf("%d%d",&n,&m))
	{
		printf("%d\n",ucln(n,m));
	}
	return 0;
}
