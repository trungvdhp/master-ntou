#include<stdio.h>
#include<math.h>
bool a[50001];
int primes[5000];

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

int main()
{
	int n;
	int x;
	int i,j,k=0;
	sieve(50000);
	while(scanf("%d",&n))
	{
    	x = (int)sqrt(n) + 1;
    	k=0;
    	printf("%d=",n);
    	
    	while(n>1&&a[k]<x)
    	{
    		while(n%primes[k]==0)
    		{
    			printf("%d",primes[k]);
    			
    			if(n!=primes[k])
    				printf("*");
    			n=n/primes[k];
    		}
    		k++;
    	}
    	
    	if(n>1)
    	{
    		printf("%d",n);
    	}
	}
}
