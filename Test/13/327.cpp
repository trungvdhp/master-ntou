#include<stdio.h>
#include<string.h>
int main()
{
	char s[100];
	char check;
	int m,n;
	while(scanf("%s",&s)>0)
	{
		int n=strlen(s);
		m=n/2;
		check=1;
		for(int i=0;i<m;i++)
		{
			if(s[i]!=s[n-i-1])
			{
				check=0;
				break;
			}
		}
		printf("%s\n", check?"YES":"NO");
	}
	return 0;
}
