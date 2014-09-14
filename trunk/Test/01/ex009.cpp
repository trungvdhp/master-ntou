#include<stdio.h>
int main()
{
    int m,n,k;
    int test;
    int a[10][10];
    int max;
    scanf("%d",&test);
    while(test--)
    {
        max=-2147483647;
        scanf("%d%d%d",&n,&m,&k);
        for(int i=0;i<n;i++)
        {
            for(int j=0;j<m;j++)
            {
                scanf("%d",&a[i][j]);
            }
        }
        //here, k is size of window
        for(int i=0;i<n+1-k;i++)
        {
            for(int j=0;j<m+1-k;j++)
            {
                int s=0;
                for(int u=0;u<k;u++)
                {
                    for(int v=0;v<k;v++)
                    {
                        s=s+a[u+i][v+j];
                    }
                }
                if(s>max)
                    max=s;
            }
        }
        printf("%d\n",max);   
    }
    return 0;
}
