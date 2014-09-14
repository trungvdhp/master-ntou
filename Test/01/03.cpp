#include<stdio.h>
int main()
{
    int k;
    scanf("%d",&k);
    int i;
    int count[100];
    int max=0;
    while(k--)
    {
        int n,m;
        scanf("%d%d",&n,&m);
        for(i=n;i<=m;i++)
        {
            count[i++];
        }        
    }
    for(int j=0;j<i;j++)
    {
        if(count[j]>max)
            max=count[j];
    }
    printf("%d",max-1);
    return 0;
}
