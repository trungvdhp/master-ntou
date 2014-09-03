#include<stdio.h>
#include<string.h>

int main()
{
	char s[100][256];
	char q[256];
	int m=0;
	int count=0;
	freopen("s.txt","r",stdin);
	while(scanf("%s",&s[m])>0)
	{
		m++;
	}
	freopen("q.txt","r",stdin);
	scanf("%s",&q);
	for(int i=0;i<m;i++)
	{
		if(strstr(s[i],q)!=NULL)
		{
			printf("The sequence is %s\n",s[i]);
			count++;
		}
	}
	printf("There are %d sequences including %s\n",count,q);  
	return 0;
}
