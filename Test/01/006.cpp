#include<stdio.h>
#include<string.h>
#include<math.h>
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
int strtoint(char *s,int n,int k)
{
    int rs=0;
    int b=1;
    for(int i=n+k-1;i>=k;i--)
    {
        s[i]=s[i]-'0';
        rs+=s[i]*b;
        b*=10;
    }
    return rs;
}
int main()
{
    int max=0;
    int a;
    int i;
    char s[7];
    scanf("%s",&s);
    int n=strlen(s);
    /*for(i=0;i<n;i++)
    {
        s[i]=s[i]-'0';
    }*/
    for(i=1;i<=n;i++)
    {
        for(int j=0;j<=n-i;j++)
        {
            a=strtoint(s,i,j);
            if(a>max && isprime(a))
            {
                max=a;
            }            
        }
    
    }
    if(max==0)
        printf("No prime found");
    else
        printf("%d",max);
    return 0;
}
