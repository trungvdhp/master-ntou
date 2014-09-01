#include<stdio.h>
#include<stdlib.h>
#include<math.h>
int a[1000];
int n;

int compare(const void *a, const void *b)
{
    return *(int*)b-*(int*)a;
}

int main()
{
    int i=0;
    scanf("%d",&n);
    for(i=0;i<n;i++)
        scanf("%d",&a[i]);
    qsort(a,n,sizeof(int),compare);
    for(i=0;i<n;i++)
        printf("%d ",a[i]);
    return 0;
}
