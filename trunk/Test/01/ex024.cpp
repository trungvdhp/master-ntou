#include<stdio.h>
#include<string.h>
int a[129];
int main()
{
    char c;
    while(scanf("%c",&c)>0)
    {
       if(c>=32&&c<=128)
            a[c]++;
    }
    
    for(int i=128;i>=32;i--)
    {
        if(a[i]>0)
        {
            printf("%c %d\n",i,a[i]);
        }
    }
    
    return 0;
}
