#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<malloc.h>
int main()
{
    int i;
    char s1[256];
    char *s;
    scanf("%s",&s1);
    if(s1[0]=='-')
    {
    	printf("-");
    	s=strstr(s1,"-")+1;
    }
    else
    {
    	s=strdup(s1);
    }
    // Tim chu e
    char *e=strstr(s,"e");
    // Khong co so mu => in ra luon nhu doc duoc
    if(e==NULL)
	{
		printf("%s",s);
		return 0;
	}
	// Tim dau cham
    char *d=strstr(s,".");
    int ls=strlen(s);
    int le=strlen(e);
    // Neu khong tim duoc dau cham thi vi tri dau cham la 0
    int ld=d==NULL?le:strlen(d);
    // Phan nguyen
    int v=ls-ld;
    // Phan thap phan
    int r=d==NULL?0:ld-le-1;
    //printf("v=%d\nr=%d\n",v,r);
    // Phan nguyen + phan thap phan
    int k=ls-le;
    // Phan so mu (10^a)
	int a=atoi(e+1);
    if(a==0)
	{
		for(i=0;i<k;i++)
			printf("%c",s[i]);
		return 0;
	}
    // So mu >= 0
    if(a>0)
    {
    	// So chu so phan thap phan it hon hoac bang so mu
        if(r<=a)
        {
        	// In phan nguyen
            for(i=0;i<v;i++)
            {
                printf("%c",s[i]);
            }
            // Bo dau cham di
            i++;
            // In phan thap phan con lai (tro thanh phan nguyen)
            for(;i<k;i++)
            {
                printf("%c",s[i]);
            }
            // In them cac chu so 0
            if(r<a)
            	printf("%0*d",a-r,0);
        }
        else
        {
            int u=k-(r-a)+1;
            // In phan nguyen
            for(i=0;i<v;i++)
            {
                printf("%c",s[i]);
            }
            // Bo dau cham di
            i++;
            // In phan thap phan truoc truoc dau cham (tro thanh phan nguyen)
            for(;i<u;i++)
            {
                printf("%c",s[i]);
            }
            // In dau cham
            printf(".");
            // In phan thap phan con lai
            for(;i<k;i++)
            {
                printf("%c",s[i]);
            }
        }   
    }
    else
    {
    	a=-a;
    	// So chu so phan nguyen it hon so mu
        if(v<=a)
        {
        	// In them cac chu so 0
        	printf("0.");
        	if(v<a)
            	printf("%0*d",d==NULL?a-v:a-v,0);
        	// In phan con lai
            for(i=0;i<v;i++)
            {
                printf("%c",s[i]);
            }
            // Bo dau cham di
            i++;
            // In phan thap phan con lai (tro thanh phan nguyen)
            for(;i<k;i++)
            {
                printf("%c",s[i]);
            }
        }
        else
        {
            int u=v-a;
            // In phan nguyen dang truoc
            for(i=0;i<u;i++)
            {
                printf("%c",s[i]);
            }
            // In dau cham
            printf(".");
            // In phan con lai
            for(;i<k;i++)
            {
            	if(s[i]!='.')
                	printf("%c",s[i]);
            }
        } 
    }
    return 0;
}
