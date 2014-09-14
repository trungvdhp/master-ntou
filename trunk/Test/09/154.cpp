#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
int main()
{
	int n;
	char buf[256];
	
	while(scanf("%d",&n))
	{
		itoa(n,buf,16);
		n=strlen(buf);
		
		for(int i=0;i<n;i++)
			printf("%c",toupper(buf[i]));
		printf("\n");
	}
	return 0;
}
