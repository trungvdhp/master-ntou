#include<stdio.h>
int main()
{
    int i,j,k,n;
    scanf("%d",&n);
    for(i=1;i<=n;i++)
    {        
        for(j=n-i;j>=0;j--)
        {
            printf("%c",' ');
        }
        for(k=1;k<=i;k++)
        {
            printf("%c",'*');
        }       
        printf("\n");
    }
    return 0;
}