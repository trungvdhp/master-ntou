#include<stdio.h>
#include<string.h>
#include<malloc.h>
#include<ctype.h>
char* normalize(char *s)
{
	char*t=strdup(s);
	int k=0;
	int n=strlen(s);
	for(int i=0;i<n;i++)
	{
		if(isalnum(s[i]))
		{
			t[k++]=s[i];
		}
	}
	t[k]=0;
	if(k==0) return NULL;
	return t;
}
int main()
{
	int count[100];
	char **s = (char **)malloc(100*sizeof(char));
	char t[256];
	char *r;
	int k=0;
	int check;
	while(scanf("%s",&t)>0)
	{
		r=normalize(t);
		if(r!=NULL)
		{
			check=0;
			for(int i=0;i<k;i++)
			{
				if(strcmp(s[i],r)==0)
				{
					count[i]++;
					check=1;
					break;
				}
			}
			if(!check)
			{
				s[k]=r;
				count[k]=1;
				k++;
			}
		}
	}
	for(int i=0;i<k;i++)
	{
		printf("%s : %d\n",s[i],count[i]);
	}
	return 0;
}
