#include<stdio.h>
#include<string.h>
int main()
{
    int n;
    int k;
    int i;
    char s[256];
    scanf("%d",&n);
    while(n--)
    {
        scanf("%s",&s);
        k=strlen(s);
        for(i=k-1;i>=0;i--)
            printf("%c",s[i]);
        printf("\n");
    }     
    return 0;
}
