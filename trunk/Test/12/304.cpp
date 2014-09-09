#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
typedef struct student
{
	char *id;
	int total;
	int chinese;
	int english;
	int math;
}stu;
int compare(const void*a, const void*b)
{
	stu st1=*(stu*)a;
	stu st2=*(stu*)b;
	if(st1.total!=st2.total) return st1.total-st2.total;
	else if(st1.chinese!=st2.chinese) return st1.chinese-st2.chinese;
	else if(st1.english!=st2.english) return st1.english-st2.english;
	else return st1.math-st2.math;
}
int main()
{
	stu a[100];
	char s[256];
	int n=0;
	while(scanf("%s",&s)>0)
	{
		char *p=strtok(s,",");
		a[n].id=strdup(p);
		p=strtok(NULL,",");
		a[n].total=atoi(p);
		p=strtok(NULL,",");
		a[n].chinese=atoi(p);
		p=strtok(NULL,",");
		a[n].english=atoi(p);
		p=strtok(NULL,",");
		a[n].math=atoi(p);
		n++;
	}
	qsort(a,n,sizeof(stu),compare);
	n--;
	while(n>=0)
	{
		printf("%s,%d,%d,%d,%d\n",a[n].id,a[n].total,a[n].chinese,a[n].english,a[n].math);
		n--;
	}
	return 0;
}
