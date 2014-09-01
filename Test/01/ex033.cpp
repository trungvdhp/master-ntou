#include<stdio.h>
int getid(char c)
{
    if(c=='W') return 32;
    if(c=='Z') return 33;
    if(c=='I') return 34;
    if(c=='O') return 35;
    if(c <'I') return c-'A'+10;
    if(c <'O') return c-'A'+9;
    return c-'A'+8;
}

int main()
{
    char s;
    scanf("%c",&s);
    int Y=getid(s);
    int X1=Y/10;
    int X2=Y%10;
    int P=X1+9*X2;
    
    for(int i=8;i>=1;i--)
    {
        scanf("%c",&s);
        P+=(s-'0')*i; 
    }
    scanf("%c",&s);
    P+=s-'0';
    
    if(P%10==0)
        printf("CORRECT!!!");
    else
        printf("WRONG!!!");
        
    return 0;
}
