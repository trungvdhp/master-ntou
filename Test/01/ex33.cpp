#include<stdio.h>
#include<string.h>
int main()
{
	char s[100];
	int a[100];
	scanf("%s",&s);
	int n=strlen(s);
	int P,l=0;
	int m;
	int Y;
	P=s[0]-'0';
	for(int i=0;i<n;i++)
	{
		if(s[i]>='A'&&s[i]<='Z')
		{
					
				m=i;			
		}
	}
	//int X1=s[m]/10;
	//int X2=s[m]%10;
	Y=s[m]+100;	
	while(Y!=0)
	{
        a[l++]=Y%10;
        Y=Y/10;
        printf("%d",a[l-1]);        
        
    }
	/*P+=X1+9*X2;
	for(int k=8;k>=1;k--)
	{
		P+=k*(s[m+1]-'0');
		m++;
	}
	P+=(s[n-1]-'0');
	printf("P=%d  ",P);*/
	
}
