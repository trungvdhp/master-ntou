#include<stdio.h>
#include<string.h>
#include<stdlib.h>
char X1[20];
char X2[20];
int B1,B2;
int m,n;

// Ham chuyen so X1 co so B1 sang co so 10
unsigned long long ctodec()
{
    unsigned long long b=1;
    unsigned long long rs=0;
    
    for(int i=n-1;i>=0;i--)
    {
        rs+=X1[i]*b;
        b*=B1;
    }
    return rs;
}
// Ham chuyen tu so he 10 sang he B2
void dectob(unsigned long long X)
{
    m=0;
    while(X>=B2)
    {
        X2[m++]=X%B2;
        X=X/B2;
    }
    X2[m++]=X;
}
// Ham in ket qua
void print()
{
    for(int i=m-1;i>=0;i--)
    {
        if(X2[i]<=9)
            printf("%d",X2[i]);
        else
            printf("%c",X2[i]-10+'A');
    }
    printf("\n");
}

int main()
{
    scanf("%s",&X1);
    scanf("%d",&B1);
    char * p;
  	long int a;
  	//Convert string X1 in base B1 to long int value
  	a = strtol(X1,&p,B1);
    /*n = strlen(X1);
    
    for(int i=0;i<n;i++)
    {
        if(X1[i]>='A'&&X1[i]<='Z')
            X1[i]=X1[i]-'A'+10;
        else
            X1[i]=X1[i]-'0';
    }
    unsigned long long X = ctodec();*/
    
    while(1)
    {
        scanf("%d",&B2);
        
        if(B2>1)
        {
        	//convert a int value #a to base #B2 and store in string #X1
        	itoa(a,X1,B2);
        	printf("%s\n",X1);
            //dectob(X);
            print();
        }
        else break;
    }
    return 0;
}
