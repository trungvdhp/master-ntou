#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>

int count[26];

int main()
{
    char s[256];
    gets(s);
    
    int l=strlen(s);
    for(int i=0;i<l;i++)
    {
        if(isalpha(s[i])&&islower(s[i]))
            count[s[i]-'a']++;
    }
    for(int i=0;i<26;i++)
    {
        printf("%c ",i+'a');
       
    }
    printf("\n");
    for(int i=0;i<26;i++)
    {
        printf("%d ",count[i]);
    }
    return 0;
}
