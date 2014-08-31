#include<stdio.h>
#include<string.h>
int a[11][11];
int b[11][11];
int n;
void copy()
{
    for(int i=0;i<n;i++)
        for(int j=0;j<n;j++)
            b[i][j]=a[i][j];
}

void turnL()
{
    copy();
    for(int i=0;i<n;i++)
        for(int j=0;j<n;j++)
            a[n-j-1][i]=b[i][j];
}

void turnR()
{
    copy();
    for(int i=0;i<n;i++)
        for(int j=0;j<n;j++)
            a[j][n-i-1]=b[i][j];
}

void turnN()
{
    copy();
    for(int i=0;i<n;i++)
        for(int j=0;j<n;j++)
            a[n-i-1][j]=b[i][j];
}

int main()
{
    int i,j;
    int k;
    int m;
    char s[81];
    scanf("%d",&k);
    
    while(k--)
    {
        scanf("%d",&n);
        
        for(i=0;i<n;i++)
        {
            for(j=0;j<n;j++)
            {
                a[i][j]=n*i+j+1;
            }
        }
        scanf("%s",&s);
        m=strlen(s);
        
        for(i=0;i<m;i++)
        {
            if(s[i]=='L')
                turnL();
            else if(s[i]=='R')
                turnR();
            else if(s[i]=='N')
                turnN();   
        }
        
        for(i=0;i<n;i++)
        {
            for(j=0;j<n;j++)
                printf("%d ", a[i][j]);
            printf("\n");
        }
        printf("\n");
    }
    
    return 0;
}
