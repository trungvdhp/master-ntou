#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int primes[5]={2,3,5,7,11};
int weights[5];
int n;
int a[5];
int check[5];

void solve(int j, int sum)
{
    int i,k;
    for (i=0;i<n;i++)
    {
        if (check[i]==0)
        {

            a[j]=i;
            
            if (j==n-1)
            {
                for (k=0;k<n;k++)
                {
                	printf("%c",a[k]+'a');
                }
                printf(" %d\n",sum+weights[i]*primes[j]);
            }
            else
            {
                check[i]=1;
                solve(j+1,sum+weights[i]*primes[j]);
                check[i]=0;
            }
        }
    }
}

int main()
{
	char s[100];
	scanf("%s",s);
	char *p=strtok(s,",");
	while(p!=NULL)
	{
		weights[n++]=atoi(p);
		p=strtok(NULL,",");
	}
	solve(0,0);
	return 0;
}
