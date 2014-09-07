#include<stdio.h>
#include<string.h>
#include<malloc.h>

int* add(int*a,int*n)
{
	int m=0;
	int t;
	int*rs=(int*)malloc((*n+1)*sizeof(int));

	for(int i=0;i<*n;i++)
	{
		t=a[i]+a[*n-i-1]+m;
		rs[i]=t%10;
		m=t/10;
	}
	if(m) rs[(*n)++]=m;
	return rs;
}

int ispalindrome(int*a,int n)
{
	int m=n/2+1;
	for(int i=0;i<m;i++)
	{
		if(a[i]!=a[n-i-1]) return 0;
	}
	return 1;
}

void print(int*a,int n, int d)
{
	int i;
	if(d)
	{
		i=n-1;
		
		while(a[i]==0)
		{
			i--;
		}
		
		while(i>=0)
		{
			printf("%d",a[i--]);
		}
	}
	else
	{
		i=0;
		while(a[i]==0)
		{
			i++;
		}
		while(i<n)
		{
			printf("%d",a[i++]);
		}
	}
}

int inverse(int *a,int n,int *b)
{
	int i=n-1;
	
	while(a[i]==0)
	{
		i--;
	}
	int k=0;
	
	while(i>=0)
	{
		b[k++]=a[i--];
	}
	return k;
}

void solve(int*a,int n)
{
	while(1)
	{
		print(a,n,0);
		printf("+");
		print(a,n,1);
		printf("=");
		int*tmp=add(a,&n);
		print(tmp,n,1);

		if(ispalindrome(tmp,n))
		{
			break;
		}
		printf("\n");
		n=inverse(tmp,n,a);
	}
}

int main()
{
	char s[15];
	int a[1000];
	scanf("%s",s);
	int n=strlen(s);
	int i=0;
	int k=0;
	while(s[i]=='0')
	{
		i++;
	}
	while(i<n)
	{
		a[k++]=s[i++]-'0';
	
	}
	solve(a,k);
	return 0;
}
