#include<stdio.h>
#include<time.h>
#include<malloc.h>
#include<algorithm>
using namespace std;
int* random(int start, int end)
{
	int i;
	int r;
	int n=end-start+1;
	int *a=(int*)malloc(n*sizeof(int));
	// initialize array
	for(i=0;i<n;i++)
	{
		a[i]=start+i;
	}
	// initialize seed "randomly"
	srand(time(0));
	// swap a[i] and a[r], where r is a random of 0 to n-1
	for(i=0;i<n;i++)
	{
		r=rand()%n;
		swap(a[i],a[r]);
	}
	return a;
}
int main()
{
    char s[256];
    while(gets(s)>0)
    {
        int l=strlen(s);
        int i;
        printf("%c",s[0]);
    	int start=1;
    	int end=l-1;
    	int *a=random(start,end);
    	for(int i=0;i<end;i++)
    		printf("%c",s[a[i]]);
    	printf("\n");
    }
	return 0;
}
