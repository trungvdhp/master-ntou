#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
typedef struct student
{
	int id;
	int math;
	int english;
}stu;
int compare(const void*a, const void*b)
{
	stu st1=*(stu*)a;
	stu st2=*(stu*)b;
	if(st1.math!=st2.math) return st1.math-st2.math;
	else return st1.english-st2.english;
}
int main()
{
	int i;
	stu a[100];
	char s[256];
	int n;
	scanf("%d",&n);
	for(i=0;i<n;i++)
	{
		scanf("%d%d%d",&a[i].id,&a[i].math,&a[i].english);
	}
	qsort(a,n,sizeof(stu),compare);
	n--;
	printf("SN MAT ENG\n");
	while(n>=0)
	{
		printf("%d %d %d\n",a[n].id,a[n].math,a[n].english);
		n--;
	}
	return 0;
}
