#include<stdio.h>
#include<math.h>

bool a[50001];
int primes[50000];

void sieve(int n)
{
	int i,j,k=0;
    int x = (int)sqrt(n) + 1;
    a[0]=true;
    a[1]=true;
    n++;
    
    for(i=2;i<x;i++)
    {
		if(!a[i])
       	{
       		primes[k++]=i;
       		//printf("%d ",i);
       		
          	for(j=i*i;j<n;j+=i)
          	{
            	a[j]=true;
          	}
       	}       
    }
    
    for(i=x;i<n;i++)
    {
    	if(!a[i])
    	{
    		primes[k++]=i;
    		//printf("%d ",i);
    	}
    }
}

bool isprime(int n)
{
	int i;
	int k;
	int x = (int)sqrt(n) + 1;
	
	for(i=0;primes[i]<x;i++)
	{
		if(n%primes[i]==0)
			break;
		else
		{
			//printf("%d ",primes[i]);
			//k++;
		}
	}
	//printf("\nk=%d\n",k);
	if(primes[i]>=x)
	{
		return true;
	}
	
	return false;
}

int main()
{
	int n;
	sieve(50000);
	
	while(scanf("%d",&n))
	{
		if(isprime(n))
			printf("YES\n");
		else
			printf("NO\n");
	}
	return 0;
}

