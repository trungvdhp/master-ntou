#include<iostream>
#include<stack>
typedef struct node
{
	char a[5];
	float v;
	float w;
}item;

int main()
{
	item I[5];
	float v,w;
	
	for(int i=0;i<5;i++)
	{
		scanf("%s%f%f",&I[i].a[0],&v,&w);
		I[i].v=v;
		I[i].w=w;
	}
	stack<item> st;
	item it;
	
	for(int i=0;i<5;i++)
	{
		it.a[0]=i;
		it.v=I[i].v;
		it.w=I[i].w;
		st.push(it);
	}
	while(!st.empty())
	{
		item=st.top();
		st.pop();
	}
	return 0;
}
