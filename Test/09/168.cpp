#include<stdio.h>
#include<math.h>

int main()
{
	int n,m;
	int i,k;
	int a[5000];
	
	while(scanf("%d",&n))
	{
		k=(int)sqrt(n)+1;
		m=0;
		
		for(i=1;i<k;i++)
    	{
	       	if(n%i==0)
	       	{
	       		printf("%d ",i);
	       		a[m]=n/i;
	       		if(a[m]!=i) m++;
	       	}
    	}
    	
    	while(m--)
    		printf("%d ",a[m]);	
    	printf("\n");
	}
}
