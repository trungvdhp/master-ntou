#include<iostream>
#include<cstring>
#include<stack>
using namespace std;

void intopost(char*s)
{
	stack<char*> st;
	char *p=strtok(s," ");
	char *t;
	
	while(p!=NULL)
	{
		if(p[0]=='(')
		{
			st.push(p);
		}
		else if(p[0]==')')
		{
			t=st.top();
			
			while(t[0]!='(')
			{
				printf("%s ",t);
				st.pop();
				t=st.top();
			}
			st.pop();
		}
		else if(p[0]=='*'||p[0]=='/')
		{
			if(!st.empty())
			{
				t=st.top();
			
				if(t[0]=='*'||t[0]=='/')
				{
					printf("%s ",t);
					st.pop();
				}
			}
			
			st.push(p);
		}
		else if(p[0]=='+'||p[0]=='-')
		{
			if(!st.empty())
			{
				t=st.top();
				
				if(t[0]!='(')
				{
					printf("%s ",t);
					st.pop();
				}
			}
			st.push(p);
		}
		else
		{
			printf("%s ",p);
		}
		p=strtok(NULL," ");
	}
	
	while(!st.empty())
	{
		t=st.top();
		st.pop();
		printf("%s ",t);
	}
}
int main()
{
	int n;
	char s[256];
	scanf("%d",&n);
	gets(s);
		
	while(n--)
	{
		gets(s);
		intopost(s);
		printf("\n");
	}
	return 0;
}

