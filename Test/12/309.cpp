#include<stdio.h>
#include<string>
#include<cstring>
int main()
{
	char s[100];
	while(scanf("%s",&s)>0)
	{
		int n=strlen(s);
		int a[2]={0,0};
		// Duyet va dem so ki tu 0 hay 1
		for(int i=0;i<n;i++)
		{
			// s[i]-'0' => convert ki tu so toi kieu nguyen int
			a[s[i]-'0']++;
		}
		// In ra a[1] cac chu so 1
		// Ham khoi tao xau std::string(n,c): tao ra mot xau kieu string gom n ki tu c
		// .c_str(): convert toi kieu xau char*
		printf("%s",std::string(a[1],'1').c_str());
		// In ra a[0] cac chu so 0
		printf("%s\n",std::string(a[0],'0').c_str());
	}
	return 0;
}
