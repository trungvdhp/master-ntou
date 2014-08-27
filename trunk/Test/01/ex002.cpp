#include<stdio.h>
#include<math.h>
int main()
{
    int k;
    int n,m;
    int i,j;
    int a[80][80];
    scanf("%d",&k);
    while(k>0)
    {
        scanf("%d%d", &n, &m);
        for(i=0;i<n;i++)
            for(j=0;j<m;j++)
                scanf("%d",&a[i][j]);
        for(i=0;i<n;i++)
        {
            for(j=0;j<m;j++)
            {
                if(a[i][j]==0){
                    printf("_ ");
                }
                else{
                    if(a[i][j-1]==0 || a[i][j+1]==0 ||a[i-1][j]==0 ||a[i+1][j]==0){
                        printf("0 ");
                    }
                    else
                        printf("_ ");
                }
            }
            printf("\n");
        }
        k--; 
    }
    return 0;
}
