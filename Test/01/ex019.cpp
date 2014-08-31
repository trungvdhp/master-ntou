#include<stdio.h>
int a[129];

int main()
{
    int i,k,n;
    scanf("%d",&n);
    
    for(i=0;i<n;i++)
    {
        scanf("%d",&k);
        a[k]++;
        
        if(a[k]==2)
        {
            printf("0");
            return 0;
        }
    }
    printf("1");
    return 0; 
}
