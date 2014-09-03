#include<stdio.h>
#include<string.h>
#include<conio.h>
#include<malloc.h>
char u[10][256];
char s[10][256];
char q[20][256];
char check[20];
int n,m;

void initcheck()
{
	for(int i=0;i<n;i++)
		check[i]=0;
}
void print()
{
	for(int i=0;i<n;i++)
		if(check[i])
			printf("%s ",u[i]);
	printf("\n");
}
void search(char*t)
{
	// t=BC NS
	int chk;
	char **r = (char **)malloc(100*sizeof(char));
	int k=0;
	char *p;
	//cat chuoi bang cac ky tu cach trong p=BC
    p=strtok(t," "); 
    
    while(p!=NULL)
    {
    	r[k++]=p;
    	//cat chuoi tu vi tri dung lai truoc do p=NS
        p=strtok(NULL," "); 
    }

	for(int i=0;i<n;i++)
	{
		// Truong dai hoc i chua thoa man dieu kien nao thi moi kiem tra
		if(check[i]==0)
		{
			chk=1;
			for(int j=0;j<k;j++)
			{
				// Neu co bat ki mot dieu kien nao ko tim thay thi => sai
				if(strstr(s[i],r[j])==NULL)
				{
					chk=0;
					break;
				}
			}
			check[i]=chk;
		}
	}
}

int main()
{
	int k;
	// Doc so luong truong dai hoc
	scanf("%d",&n);
	
	for(int i=0;i<n;i++)
	{
		// Doc ten truong dai hoc
		scanf("%s",&u[i]);
		// Doc cac dieu kien cua truong co
		gets(s[i]);
	}
	// Doc so luong thi sinh yeu cau
	scanf("%d",&m);
	// Loai bo enter
	gets(q[0]);
	for(int i=0;i<m;i++)
	{
		// Doc yeu cau cua thi sinh thu i vd BC NS+CT HL
		gets(q[i]);
		//printf("%s\n",q[i]);
		// Khoi tao mang kiem tra xem truong dai hoc co phu hop yeu cau khong
		initcheck();
		char *p;
		//cat chuoi bang cac ky tu +
        p=strtok(q[i],"+"); 
        char **r = (char **)malloc(50*sizeof(char));
    	k=0;
        while(p!=NULL)
        {
        	//Luu lai chuoi ket qua cat duoc p=BC NS
        	r[k++]=p;
        	//cat chuoi tu vi tri dung lai truoc do p=CT HL
            p=strtok(NULL, "+");
            //printf("p=%s\n",p);
        }
        // Duyet lai cac chuoi ket qua cat duoc
        for(int j=0;j<k;j++)
        {
        	// Tim kiem va check xem truong dai hoc nao thoa man dieu kien j
        	search(r[j]);
        }
        // In ket qua ra
        print();
	}
	
	return 0;
}
