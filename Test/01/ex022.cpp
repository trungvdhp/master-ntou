#include<stdio.h>
#include<string.h>
int main()
{
    char s[100],a[100];
    int b[100];
    int i,j,m=0;
    int n,z;
    int check;
    scanf("%s",&s);
    scanf("%s",&a);
    n=strlen(s);
    z=strlen(a);
    int k=z-n;
    for(i=0;i<z;i++)
    {
        if(a[i]==s[0]&&i<=k)
            b[m++]=i;
    }
    for(i=0;i<m;i++)
    {
        check=1;
        
        for(j=1;j<n;j++)
            if(s[j]!=a[b[i]+j])
            {
                check=0;
                break;
            }
            
        if(check)
        {
            printf("YES");
            return 0;
        }
        
    }

    printf("NO");
    return 0;
}
