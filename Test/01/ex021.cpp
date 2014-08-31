#include<stdio.h>
#include<string.h>

int count[26];

int main()
{
    char c;

    
    while(scanf("%c",&c)>0)
    {
        if(c<='Z'&&c>='A')
        {
            count[c-'A']++;
        }
        else if(c<='z'&&c>='a')
        {
            count[c-'a']++;
        }
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
