#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int compare(const void*a,const void*b)
{
    return *(int*)a - *(int*)b;
}
int main()
{
    char s[256];
    scanf("%s",&s);
    int a[256];
    int b[256];
    int k=0;
    char *p=strtok(s,",");
    while(p!=NULL)
    {
        a[k++]=atoi(p);
        p=strtok(NULL,",");
    }
    qsort(a,k,sizeof(int),compare);
    for(int i=0;i<k;i++)
    {
        b[i]=a[k-i-1];
    }
    int r=0;
    int temp;
    for(int i=k-1;i>=0;i--)
    {
        temp=a[i]+r;
        if(b[i]<temp)
        {
            b[i]+=10;
            r=1;
        }
        else
            r=0;
        b[i]-=temp;
    }
    r=0;
    while(b[r]==0){r++;}
    for(;r<k;r++)
    {
         printf("%d",b[r]);
    } 
    return 0;
}
