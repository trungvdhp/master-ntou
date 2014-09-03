#include<stdio.h>
#include<string.h>
char check[256];
int main()
{
	char a[256];
	char b[256];

	gets(a);
	gets(b);
	int n=strlen(a);
	int m=strlen(b);
	if(n!=m)
		printf("no");
	else
	{
		for(int i=0;i<n;i++)
		{
			check[a[i]]++;
			check[b[i]]++;
		}
		for(int i=0;i<n;i++)
		{
			if(check[a[i]]==1)
			{
				printf("no");
				return 0;
			}
		}
		printf("yes");
	}
	
	return 0;
}
