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
        if(b=='-'&&a=='1')
        {
        	// because of that it is '-' and count already added more 1 before,
			// but it is '1' after, and we have "-1", so count should be minus 1
        	count--;
        	break;
        }
        if(a==32&&isalnum(b))
        {
        	count++;
        }
        else if(a>32&&!isalnum(a))
        {
            count++;
            if(isalnum(b))
            {
            	count++;
            }
        } 
        b=a;
    }
    printf("%d",count);
    return 0;
}
