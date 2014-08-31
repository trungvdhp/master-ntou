#include<stdio.h>
int a,b,c;
int main()
{
    int x,y,z;
    int n;
    scanf("%d",&n);
    
    for(int i=0;i<n;i++)
    {
        scanf("%d%d%d",&x,&y,&z);
        a+=x;
        b+=y;
        c+=z;
    }
    printf("%d %d %d %d",(a+b+c)/(3*n),a/n,b/n,c/n);
    return 0;
}
