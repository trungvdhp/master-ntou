#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
int main()
{
	int n;
	char buf[256];
	int j;
	
	while(scanf("%d",&n))
	{
		if(n<0) n+=256;
		itoa(n,buf,2);
		printf("%08s\n",buf);
	}
	return 0;
}
