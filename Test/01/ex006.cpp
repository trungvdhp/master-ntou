#include<stdio.h>
#include<string.h>
#include<math.h>
int strtoi(char s[],int n, int k)
{
    int rs=0;
    int b=1;
    int i;
    for(i=k+n-1;i>=k;i--)
    {
        rs+=(s[i]-48)*b;
        b=b*10;
    }
    return rs;
}
char isprime(int n)
{
    if(n==0||n==1)
        return 0;
    if(n==2)
        return 1;
    int k=(int)sqrt(n);
    for(int i=2;i<=k;i++)
    {
        if(n%i==0)
            return 0;        
    }
    return 1;
}
int main()
{
    int max=0;
    int a;
    char s[7];
    scanf("%s",&s);
    int n=strlen(s);
    for(int i=1;i<=n;i++)
    {
        for(int j=0;j<=n-i;j++)
        {
            a=strtoi(s,i,j);
            if(isprime(a)&&a>max)
            {
                max=a;
            }  
         }
    }
    if(max)
    {
        printf("%d",max);
    }
    else
    {
        printf("No prime found");
    }
    return 0;
}
