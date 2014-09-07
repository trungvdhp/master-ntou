#include<stdio.h>

#include<string.h>
int main()
{
    int i;
    char s[100];
    int sum=0;
    scanf("%s",&s);
    int l=strlen(s);
    for(i=0;i<l;i++)
    {
        sum+=s[i]-96;
    }
    printf("%d",sum);
    return 0;
}
