#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int main()
{
    int i;
    char s[256];
    int k=0;
    int mul=0;
    scanf("%s",&s);
    char *d=strstr(s,".");
    char *e=strstr(s,"e");    
    int ls=strlen(s);
    int le=strlen(e);
    int a=atoi(e+1);
    int v=strlen(s)-strlen(d);
    int r=strlen(d)-strlen(e);
    if(a>=0)
    {
        if(r<=a)
        {
            for(int i=0;i<ls-le;i++)
            {
                if(s[i]!='.')
                    printf("%c",s[i]);
            }
            printf("%0*d",a-r+1,0);
        }
        else
        {
            int k=ls-le;
            int u=k-(r-a)+1;
            for(int i=0;i<u;i++)
            {
                if(s[i]!='.')
                    printf("%c",s[i]);
            }
            printf(".");
            for(int i=u;i<k;i++)
            {
                printf("%c",s[i]);
            }
        }   
    }
    else
    {  
    }
    return 0;
}
