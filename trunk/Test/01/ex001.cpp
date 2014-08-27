#include<stdio.h>
int main()
{
    int a[100];
    int i=0;
    while (scanf("%d",&a[i])>0)
    {
        i++;
    }
    while(i>0){
        i--;
        printf("%d ",a[i]);
    }
    return 0;
}
