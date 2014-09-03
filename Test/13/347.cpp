#include<stdio.h>
#include<string.h>

int main()
{
	char s[256];
	char q[256];
	gets(s);
	gets(q);
	char *p=strstr(s,q);
	if(p==NULL)
	{
		printf("-1");
	}
	else
	{
		printf("%d",strlen(s)-strlen(p));
	}
	return 0;
}
