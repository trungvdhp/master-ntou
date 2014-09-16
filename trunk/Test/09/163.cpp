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

int largestprime(int n)
{
	int i,j;
	int k;
	for(i=n-1;i>=2;i--)
	{
		int x = (int)sqrt(i) + 1;
		//printf("sqrt(%d)+1 = %d\n",i,x);
		//k=0;
		
		for(j=0;primes[j]<x;j++)
		{
			if(i%primes[j]==0)
				break;
			else
			{
				//printf("%d ",primes[j]);
				//k++;
			}
		}
		//printf("\nk=%d\n",k);
		if(primes[j]>=x)
		{
			return i;
		}
	}
	return -1;
}

int main()
{
	int n,a;
	sieve(50000);
	
	while(scanf("%d",&n))
	{
		a=largestprime(n);
		
		if(a==-1)
			printf("No largest prime less than %d found\n",n);
		else
			printf("%d\n",a);
	}
	return 0;
}

