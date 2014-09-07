#include<stdio.h>
#include<string.h>

int main()
{
	char s[256];
	char q[256];
	int count=0;
	freopen("q.txt","r",stdin);
	scanf("%s",&q);
	freopen("s.txt","r",stdin);
	while(scanf("%s",&s)>0)
	{
		if(strstr(s,q)!=NULL)
		{
			printf("The sequence is %s\n",s);
			count++;
		}
	}
	printf("There are %d sequences including %s\n",count,q);  
	return 0;
}
