#include<stdio.h>
#include<math.h>

int a[10001];

int main()
{
	int n;
    int i,j,k=0;
    scanf("%d",&n);
    k=(int)sqrt(n)+1;
    
    for(i=2; i<=n; i++)
       	a[i]=1;
       	
    for(i=2;i<k;i++)
    {
       	a[i*i]+=i;
       	
       	for(j=i+1; j*i<=n; j++)
          	a[j*i] += i + j;
    }
    k=0;
    
    for(i=2; i<=n; i++)
       	if(a[i]==i) 
    		printf("%d ",i);
    		
    return 0;
}

