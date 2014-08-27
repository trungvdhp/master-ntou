#include <stdio.h>
int main()
{
    char a[100][10];
    char b;
    int i=0, k=0;
    int check=0;
    while (scanf("%c", &b)> 0)
    {
        if (b != 10)// 10 la ma ASCII cua enter
        {
            if (b != 32)// 32 la ma ASCII cua dau cach
            {
                a[k][i++]=b; // chuoi so thu k tai vi tri i gia tri bang b
                check = 0;
            }
            else if (check == 0)//chua gap dau cach
            {
                check=1; // da gap dau cach
                a[k][i]=0; // ket thuc chuoi
                i=0;
                k++;
            }
        }
        else
        {
            for (i=k-1; i>=0; i--)
            {
                printf("%s ", a[i]);
            }
            printf("\n");
            i=0;
            k=0;
        }
    }
    for (i=k-1; i>=0; i--)
    {
        printf("%s ", a[i]);
    }
    return 0;
}
