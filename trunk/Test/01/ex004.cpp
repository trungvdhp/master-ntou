#include<stdio.h>
#include<math.h>
int main()
{
    char a[9][10];
    int b[10];
    int i,j;
    int m=9,n=9;
    char check=1;
    for(i=0;i<9;i++)
    {
        scanf("%s",&a[i]);
        //printf("%s\n",a[i]);
    }
    //kiem tra hang
    for(i=0;i<n;i++)
    {
        for(j=0;j<10;j++) b[j]=0;
        
        for(j=0;j<m;j++)
        {
            if(a[i][j]!='0')
            {
                b[a[i][j]-48]++;
                if(b[a[i][j]-48]>1)
                {
                    check=0;
                    printf("row%d #%c\n",i+1,a[i][j]);
                    break;
                }
            }
        }
    }
    //kiem tra cot
    for(i=0;i<n;i++)
    {
        for(j=0;j<10;j++) b[j]=0;
        
        for(j=0;j<m;j++)
        {
            if(a[j][i]!='0')
            {
                b[a[j][i]-48]++;
                if(b[a[j][i]-48]>1)
                {
                    check=0;
                    printf("column%d #%c\n",i+1,a[j][i]);
                    break;
                }
            }
        }
        for(j=1;j<10;j++)
        {
            
        }
    }
    //kiem tra 3x3
    for(i=0; i<3; i++)
    {
        for(j=0;j<3;j++)
        {
            for(n=0;n<10;n++) b[n]=0;
            for(n=0; n<3; n++)
            {
                for(m=0;m<3;m++)
                {
                    if(a[n+3*i][m+3*j]!='0')
                    {
                        b[a[n+3*i][m+3*j]-48]++;
                        if(b[a[n+3*i][m+3*j]-48]>1)
                        {
                            check=0;
                            printf("block%d #%c\n",3*i+j+1,a[n+3*i][m+3*j]);
                            break;
                        }
                    } 
                }
            }
        }
    }
    if(check)
        printf("true");
    return 0;
}
