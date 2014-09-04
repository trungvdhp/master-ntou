#include<stdio.h>
#include<string.h>
#include<malloc.h>
int main()
{
	char s[100];
	while(gets(s))
	{
		int k=0;
		//char r[100] <=> char *r=(char*)malloc(100*sizeof(char);
		// Khai bao mang 2 chieu dang char *r[100]
		char **r=(char**)malloc(100*sizeof(char*));
		// Ham strtok tim chuoi con dua tren chuoi phan cach
		// O day la cat theo dau cach trong
		// Vi du s="56 89 23 3 1" => p="56"
		char *p=strtok(s," ");
		while(p!=NULL)
		{
			r[k++]=p;
			// Cat tu vi tri truoc do => p=89
			p=strtok(NULL," ");
		}
		while(k--)
		{
			printf("%s ", r[k]);
		}
		printf("\n");
	}
	return 0;
}
