#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include<ctype.h>
int main()
{
    char b,a;
    int count=0;
    scanf("%c",&b);
    while(scanf("%c",&a)>0)
    {
        printf("%c",a);
        if(b=='-'&&a=='1')
            break;
        if(a==32&&isalnum(b))
            count++;
        else if(!isalnum(a))
        {
            count++;
            if(isalnum(b))
                count++;
        } 
        b=a;
    }
    printf("%d",count);
    return 0;
}
