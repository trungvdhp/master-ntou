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
	int start=0;
	int end=90;
	int n=end-start+1;
	int *a=random(start,end);
	for(int i=0;i<n;i++)
		printf("%d ",a[i]);
	return 0;
}
