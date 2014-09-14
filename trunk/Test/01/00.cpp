#include<stdio.h>
#include<string.h>
#include<malloc.h>
int main()
{
	char s[100];
	while(gets(s))
	{
		int k=0;
		char **r=(char**)malloc(100*sizeof(char*));
		char *p=strtok(s," ");
		while(p!=NULL)
		{
			r[k++]=p;
			p=strtok(NULL," ");
		}
		while(k--)
		{
			printf("%s ", r[k]);
		}
		printf("\n");
	}
	return 0;
}
