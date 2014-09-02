#include<stdio.h>
#include<string.h>
int main()
{
    int n;
    int k;
    int i,j,v;
    scanf("%d",&n);
    int m=(n-1)/2;
    for(i=1;i<=m+1;i++)
    {
        for(j=1;j<=m-i+1;j++)
        {        
            printf(" ");
        }
        for(v=1;v<=n-(2*(j-1));v++)
        {        
            printf("*");
        }        
        for(j=1;j<=m-i+1;j++)
        {        
            printf(" ");
        }
        printf("\n");
    }
    int u=n-m-1;
    
    if(n%2==0)
    {
        for(i=1;i<=n;i++)
            printf("*");
        printf("\n");
        u--;
    }
    
    for(i=1;i<=u;i++)
    {
        for(j=1;j<=i;j++)
        {        
            printf(" ");
        }
        for(v=1;v<=n-(2*(j-1));v++)
        {        
            printf("*");
        }        
        for(j=1;j<=i;j++)
        {        
            printf(" ");
        }
        printf("\n");
    }
    return 0;
}
