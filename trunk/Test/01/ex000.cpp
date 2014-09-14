#include <stdio.h>
int main()
{
    char a[100][10];
    char b;
    int i=0, k=0;
    
    while (scanf("%c", &b)> 0)
    {
        if (b != 10)// 10 la ma ASCII cua enter
        {
            if (b != 32)// 32 la ma ASCII cua dau cach
            {
                a[k][i++]=b; // chuoi so thu k tai vi tri i gia tri bang b
            }
            else
            {
                a[k][i]=0; // ket thuc chuoi
                i=0;
                k++;
            }
        }
        else
        {
            a[k][i]=0; // ket thuc chuoi
            for (i=k; i>=0; i--)
            {
                printf("%s ", a[i]);
            }
            printf("\n");
            i=0;
            k=0;
        }
    }
    
    a[k][i]=0;
    
    for (i=k; i>=0; i--)
    {
        printf("%s ", a[i]);
    }
    return 0;
}
