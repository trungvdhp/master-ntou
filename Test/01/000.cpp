#include<stdio.h>
int main()
{
    char d;
	char s[100];
	int a[100];
	int k=0;
	int i;
	while(scanf("%c",&d)>0)
	{
		if(d!='\n')
		{
			s[k++]=d;		
		}
		else
		{
			k--;
			for(i=k;i>=0;i--)
			{
				printf("%c",s[i]);							
			}
			printf("\n");			
		}	
	}

	return 0;
}
