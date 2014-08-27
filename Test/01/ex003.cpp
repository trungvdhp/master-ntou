#include<stdio.h>
#include<math.h>
int a[25];
int main()
{
    int n;
    int i,x,y,max=0;
    scanf("%d",&n);
    
    while(n--)
    {
        scanf("%d%d",&x,&y);
        for(i=x;i<=y;i++)
            a[i]+=1;
    }
    
    for(i=0;i<25;i++)
        if (a[i]>max)
            max=a[i];
    printf("%d",max-1);
    return 0;
}
