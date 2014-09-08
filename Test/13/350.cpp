#include<stdio.h>
#include<string.h>
int count[256];
char check[256];
int main()
{
    char s[256];   
    gets(s);
    int l=strlen(s);
    int i,j;
    for(i=0;i<l;i++)
    {
        count[s[i]]++;
    }
    for(j=0;j<l;j++)
    {
        if(s[j]!=' ')
        {
            if(check[s[j]]==0)
            {
                check[s[j]]=1;
                printf("%c:%d ",s[j],count[s[j]]);
            }
        }
    }
    return 0;
}
