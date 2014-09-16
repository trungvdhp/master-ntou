#include<iostream>
#include<set>
using namespace std;

int main()
{
	int n;
	cin>>n;
	int a[n];
	int m=1;
	int k=1;
	int b=4;
	a[0]=1;
	a[1]=3;
	
	while(m < n)
	{
		a[m+1]=a[m]+b;
		m++;
		k++;
		b++;
		
		while(b < a[k])
		{
			a[m+1]=a[m]+b;
			b++;
			m++;
		}
		b++;
	}
	cout<<a[n-1];
	return 0;
}
