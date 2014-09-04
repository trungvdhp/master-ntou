#include<stdio.h>
// m la so o giua vi du "12321", 3 la so o giua
// n la so phan tu cua hang dai nhat vi du m=3 => n=3*2-1=7
void printline(int n,int m)
{
	int i;
	// Tinh so dau cach can in
	int k=n-m;
	// In cac dau cach ben trai
	for(i=0;i<k;i++)
		printf(" ");
	if(m%2)
	{
		for(i=1;i<=m;i++)
			printf("%d",i);
	}
	else
	{
		for(i=m;i>=1;i--)
			printf("%d",i);
	}
	// Xuong dong
	printf("\n");
}

int main()
{
	int m;
	// Quet m
	while(scanf("%d",&m)>0)
	{
		// In cac hang ben tren hang dai nhat (hang o giua)
		for(int i=1;i<=m;i++)
		{
			printline(m,i);
		}
	}
	return 0;
}
