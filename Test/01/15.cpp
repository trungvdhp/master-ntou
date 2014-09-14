#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int main()
{
    char X1[20];
    int a;
    int B1,B2;
    scanf("%s",&X1);
    scanf("%d",&B1);
    char *p;
    a=strtol(X1,&p,B1);
    scanf("%d",&B2);
    char rs[256];
    if(B2>1)
    {
        itoa(a,rs,B2);
        printf("%s\n",rs);
    }    
    return 0;
}
