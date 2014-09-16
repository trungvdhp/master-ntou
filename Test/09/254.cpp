#include<iostream>
#include<cstdio>
#include <iomanip>
using namespace std;
int main()
{
	double m,n;
	int d;
	while(scanf("%lf%lf%d",&m,&n,&d))
	{
		cout << fixed;
   		cout.precision(d);
   		cout << m/n;
	}
	return 0;
}
