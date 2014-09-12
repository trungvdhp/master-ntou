#include<iostream>
#include<string>
#include<stack>
#include<map>
#include<algorithm>
using namespace std;

string s[1000];
int n=0;
stack<double> st;
map<string,double> var;

double getvalue(string a)
{
	// Check if a is a variable name or a value
	if(isalpha(a[0]))
		return var[a];	
	else
		return atof(a.c_str());
}

int main()
{
	string name;
	double val;
	double rs=0;
	double a,b;
	
	while(cin>>s[n])
	{
		// First map row (example x = 5, s[n-1]="x", s[n]="=")
		if(s[n]=="=")
		{
			n--;
			break;
		}
		// Skip "(" and ")"
		else if(s[n]!="("&&s[n]!=")")
		{
			n++;
		}
	}
	
	// First map
	if(!s[n].empty())
	{
		// Read value x = 5 => val = 5
		cin>>val;
		// Map
		var[s[n]]=val;
	}
	// Next maps
	// Read variable name
	while(cin>>name)
	{
		// Read "="
		cin>>s[n+1];
		// Read value
		cin>>val;
		// Map
		var[name]=val;
	}
	n--;
	// Beginning calculate
	while(n>=0)
	{
		if(s[n]=="+")
		{
			// Pop 2 value out stack and sum
			a=st.top();
			st.pop();
			b=st.top();
			st.pop();
			st.push(a+b);
		}
		else if(s[n]=="-")
		{
			// Pop 2 value out stack and subtract
			a=st.top();
			st.pop();
			b=st.top();
			st.pop();
			st.push(a-b);
		}
		else if(s[n]=="*")
		{
			// Pop 2 value out stack and multiply
			a=st.top();
			st.pop();
			b=st.top();
			st.pop();
			st.push(a*b);
		}
		else if(s[n]=="/")
		{
			// Pop 2 value out stack and devide
			a=st.top();
			st.pop();
			b=st.top();
			st.pop();
			st.push(a/b);
		}
		else
		{
			// Valuable => push in stack
			st.push(getvalue(s[n]));
		}
		n--;
	}
	// Print out last value, which is the result of expression
	cout<<st.top()<<endl;
	return 0;
}
