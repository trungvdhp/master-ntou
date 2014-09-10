#include<stdio.h>
#include<string.h>
#include<math.h>
#include<ctype.h>
int main()
{
	char s[100];
	int i=1;
	
	while(gets(s))
	{
		char *schn=strtok(s," ");
		char *seng=strtok(NULL," ");
		char *smath=strtok(NULL," ");
		//printf("%s %s %s\n",schn,seng,smath);
		double chn=schn==NULL||isalpha(schn[0])?0:atof(schn);
		double eng=seng==NULL||isalpha(seng[0])?-1:atof(seng);
		double math=smath==NULL||isalpha(smath[0])?-1:atof(smath);
		printf("s%d %d %d %d\n",i,(int)chn,(int)eng,(int)math);
		i++;
	}
	return 0;
}
