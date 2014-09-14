#include<stdio.h>
int main()
{
    int h;
    int n;
    int k=0;
    int a[100];
    scanf("%d%d",&h,&n);
    
    while(n!=0)
    {
        a[k++]=n%h;
        n=n/h;
    }
    
    for(int j=k-1;j>=0;j--)
    {
        if(a[j]>9)
        {
            printf("%c",a[j]-10+'A');
        }
        else
            printf("%d",a[j]);
    }
    return 0;
}
