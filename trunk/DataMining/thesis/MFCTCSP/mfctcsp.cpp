#include "mfctcsp.h"
#include <time.h>
#include "SequentialDatabase.h"
#define OUTPUTFILE
int ITEM_NO = 300000;

double min_sup;
int mingap;
int maxgap;
int swin;
int THRESHOLD;

void SetParameter()
{
	min_sup = 0.5;
	mingap = 3;
	maxgap = 15;
	swin = 2;
}

int main(int argc,char * argv[])
{
	FILE * fp = fopen("time.txt","a");
	clock_t start,finish;
	double duration;

	/*if (argc < 2)
	{
		printf("usage: mfctcsp <infile> [<MINSUP> <MINGAP> <MAXGAP> <SWIN> <DUN>] [<outfile>]\n");
		exit(1);
	}
	else */
	if (argc >= 6)
	{
		min_sup = atof(argv[2]);
		mingap = atoi(argv[3]);
		maxgap = atoi(argv[4]);
		swin = atoi(argv[5]);
	}
	else
	{
		SetParameter();
	}
	time_t rawtime;
	time ( &rawtime );
	start = clock();
	SequentialDatabase * seqDB;
	/*if (argc >= 8)
	{
		seqDB = new SequentialDatabase(argv[1],argv[7]);
	}
	else
	{
		seqDB = new SequentialDatabase(argv[1],"out.txt");
	}*/
	seqDB = new SequentialDatabase(argv[1],"out.txt");
	//seqDB = new SequentialDatabase("D:\\Master\\DataMining\\thesis\\mfctcsp(1030)\\Release\\dss.txt", "out1.txt");
	seqDB->execute();

	finish = clock();
	duration = (double)(finish - start)/CLOCKS_PER_SEC;
	
	fprintf(fp,"%s mfctcsp %s %lf %d %d %d\n", ctime (&rawtime), argv[1],min_sup,mingap,maxgap,swin);
	fprintf(fp," Duration %lf\n",duration);

	printf(" Duration %6.10lf\n",duration);
	fclose(fp);
	delete seqDB;
	return 0;
}