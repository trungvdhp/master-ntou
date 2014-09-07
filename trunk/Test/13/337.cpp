#include<stdio.h>
int main()
{
    int n;
    int a,b;
    scanf("%d",&n);
    scanf("%d",&a);
    printf("%d ",a);
    n--;
    while(n--)
    {
        scanf("%d",&b);
        if(b!=a)
        {
            printf("%d ",b);
            a=b;
        }
    }
    
    return 0;
}
