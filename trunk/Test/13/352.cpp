#include<stdio.h>
#include<string.h>
int main()
{
    char b[256];
    char a[256];
    int k=0;
    scanf("%s",&b);
    scanf("%s",&a);
    char *s=strstr(a,b);
    while(s!=NULL)
    {
        k++;
        printf("%s\n",s+1);
        s=strstr(s+1,b);
    }
    printf("%d",k);
    return 0;
}
