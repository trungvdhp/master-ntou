#include<stdio.h>
#include<string.h>

void sort(int a[],int n)
{
    int i,j,temp;
    for(i=0;i<n;i++)
    {
        for(j=i+1;j<n;j++)
        {
            if(a[i]<a[j])
            {
                temp=a[i];
                a[i]=a[j];
                a[j]=temp;
            }
        }
    }
}
float array_to_float(int a[], int n, int d)
{
    float rs=0.0f;
    float b=1.0f;
    int i;
    
    if(d==1) // chieu tu trai sang
    {
        for(i=0;i<n;i++)
        {
            rs+=b*a[n-i-1];
            b*=10;
        }
    }
    else
    {
        for(i=0;i<n;i++)
        {
            rs+=b*a[i];
            b*=10;
        }
    }
    
    return rs;
}

int main()
{
    char s[20];
    int a[20];
    scanf("%s",&s);
    int m = strlen(s);
    int i,n=0;
    for(i=0;i<m;i++)
    {
        if(s[i]>='0'&&s[i]<='9')
        {
            a[n++]=s[i]-'0';
        }
    }
    sort(a,n);
    printf("%.0f",array_to_float(a,n,1)-array_to_float(a,n,0));
    
    return 0;
}
