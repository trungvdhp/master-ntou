#include<stdio.h>
// m la so o giua vi du "12321", 3 la so o giua
// n la so phan tu cua hang dai nhat vi du m=3 => n=3*2-1=7
void printline(int n,int m)
{
	int i;
	// Tinh so dau cach can in
	int k=(n-(m*2-1))/2;
	// In cac dau cach ben trai
	for(i=0;i<k;i++)
		printf(" ");
	// In cac so ben trai m: 12
	for(i=1;i<m;i++)
		printf("%d",i);
	// In cac so ben phai m: 321
	for(i=m;i>=1;i--)
		printf("%d",i);
	// In cac dau cach ben phai
	for(i=0;i<k;i++)
		printf(" ");
	// Xuong dong
	printf("\n");
}

int main()
{
	int m;
	// Quet m
	while(scanf("%d",&m)>0)
	{
		// Tinh so phan tu cua hang dai nhat ung voi m
		int n=2*m-1;
		// In cac hang ben tren hang dai nhat (hang o giua)
		for(int i=1;i<m;i++)
		{
			printline(n,i);
		}
		// In cang hang o duoi hang dai nhat ke ca no
		for(int i=m;i>=1;i--)
		{
			printline(n,i);
		}
	}
	return 0;
}
