#include<stdio.h>
#include<string.h>

int main()
{
    char s[100],a[100];
    scanf("%s",&s);
    scanf("%s",&a);
    
    if(strstr(a,s)==NULL)
        printf("NO");
    else
        printf("YES");
    return 0;
}
