#include<iostream>
#include<algorithm>
#include<cstring>
using namespace std;

int main()
{
    int n=0;
    int id;
    char s[256];
    int a[250];
    
    cin>>s;
    char *p=strtok(s,",");

    while(p!=NULL)
    {
    	a[n++]=atoi(p);
    	p=strtok(NULL,",");
	}
	// m[i] is max length of longest descending sequence until position #i
    int m[n];
    // b[i] is parent of position #i
    int b[n];
    
    for(int i=0;i<n;i++) 
	{
		b[i]=i;
		m[i]=1;
	}
	
    for (int i=n-2; i>=0; i--)
    {
        for (int j=i+1; j<n; j++)
        {
            if (a[i]<a[j] && m[i]<=m[j])
            {
                m[i] = m[j]+1;
                b[i]=j;
            }
        }
    }
    id=0;
	       
    for(int i=1;i<n;i++) 
	{
		if(m[i]>m[id]) 
		{
			id=i;
		}
	}

	while(id!=b[id])
	{
		cout<<a[id]<<",";
		id=b[id];
	}
	cout<<a[id];
    return 0;
}


