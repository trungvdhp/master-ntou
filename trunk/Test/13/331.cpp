#include<stdio.h>
#include<string.h>
#include<ctype.h>
int main()
{
    char s[100];
    int n,m;
    scanf("%d%d",&n,&m);
    n=n%26;
    if(m==1)
    {
        n=-n;
    }
    char v;
    while(scanf("%s",&s)>0)
    {
        int l=strlen(s);
        for(int i=0;i<l;i++)
        {    
            v=s[i]+n;      
            if(isupper(s[i]))
            {          
               
                if(v<'A')
                    v=v+26;
                else if(v>'Z')
                    v-=26;
            }
            if(islower(s[i]))
            {          
               
                if(v<'a')
                    v=v+26;
                else if(v>'z')
                    v-=26;
            }
            printf("%c",v);
        }
        printf("\n");
    }
    return 0;
}
