#include<iostream>
#include<cstdio>
using namespace std;

int main()
{
	int k;
	int n;
	int count;
	
	cin>>k;
	
	while(k--)
	{
		cin>>n;
		bool a[n+1];
		
		for(int i=1;i<=n;i++)
		{
			a[i]=true;
		}
		
		for(int i=2;i<=n;i++)
		{
			for(int j=i;j<=n;j+=i)
			{
				a[j]=!a[j];
			}
		}
		count=0;
		
		for(int i=1;i<=n;i++)
		{
			if(a[i]) count++;
		}
		
		cout<<count<<endl;
	}
	
	return 0;
}
