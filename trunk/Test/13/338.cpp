#include<stdio.h>
#include<ctype.h>
int main()
{
    char c;
    int n;
    scanf("%d",&n);
    n=n%26;
    int k=0;    
    while(scanf("%c",&c)>0)
    {
        if(isupper(c))
        {
            c=c+n;
            if(c=='A'-1||c=='Z'+1) 
                c=' ';
            else if(c<'A') 
                c+=27;
            else if(c>'Z') 
                c-=27;
            printf("%c",c);
        }
        else if(c==' ')
        {
            printf("H");
        }
    }
    printf("\n");
    return 0;
}
