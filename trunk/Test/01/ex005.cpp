#include<stdio.h>
#include<math.h>
#include<string.h>
int main()
{
    char target[11];
    char s[21][21];
    int i, j;
    int n, m;
    int k;
    int x,check;
    scanf("%s", &target);
    n = 0;
    while(scanf("%s", &s[n++])>0)
    {
    }
    k = strlen(target);
    m = strlen(s[0]);
    for(i=0;i<n;i++)
    {
        for(j=0;j<m;j++)
        {
            if(s[i][j]==target[0])
            {
                //Trai
                if(j+1-k>=0)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i][j-x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i,j+1-k);
                    }
                }
                //Trai tren
                if(i+1-k>=0 && j+1-k>=0)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i-x][j-x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+1-k,j+1-k);
                    }
                }
                //Tren
                if(i+1-k>=0)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i-x][j])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+1-k,j);
                    }
                }
                //Phai tren
                if(i+1-k>=0 && j+k<=m)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i-x][j+x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+1-k,j+k-1);
                    }
                    
                }
                //Phai
                if(j+k<=m)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i][j+x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i,j+k-1);
                    }
                }
                //Phai duoi
                if(i+k<=n && j+k<=m)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i+x][j+x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+k-1,j+k-1);
                    }
                }
                 //Duoi
                if(i+k<=n )
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i+x][j])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+k-1,j);
                    }
                }
                 //Trai duoi
                if(i+k<=n && j+1-k>=0)
                {
                    check=1;
                    for(x=1;x<k;x++)
                    {
                        if(target[x]!=s[i+x][j-x])
                        {
                            check=0;
                            break;
                        }
                    }
                    if(check)
                    {
                        printf("%d, %d To %d, %d\n",i,j,i+k-1,j+1-k);
                    }
                }
            }
        }
    }
    return 0;
}
