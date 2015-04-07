#include "ctsp.h"
#include "SequentialDatabase.h"
#include <time.h>

double min_sup;
int mingap;
int maxgap;
int swin;
int THRESHOLD;
int ITEM_NO = 50000;

void SetParameter()
{
	min_sup = 0.005;
	mingap = 5;
	maxgap = 16;
	swin = 3;	
}

int main(int argc, char * argv[])
{
	clock_t start , finish;
	char outFileName[] = "test.out";
	double duration;

	if (argc < 2)
	{
		printf("usage: ctsp <infile> [<MINSUP> <MINGAP> <MAXGAP> <SWIN>] [<outfile>]\n");
		exit(1);
	}
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

	if (argc >= 7)
		strcpy(outFileName, argv[6]);
	
	start = clock();
	SequentialDatabase * seqDB = new SequentialDatabase(argv[1], outFileName);
	seqDB->execute();
	delete seqDB;
	finish = clock();
	duration = (double)(finish - start)/CLOCKS_PER_SEC;

	FILE * fp = fopen("test.log","a");
	fprintf(fp, "%s ctsp %s %lf %d %d %d %s\n", ctime(&rawtime),argv[1], min_sup, mingap, maxgap, swin, outFileName);
	fprintf(fp, " Duration %lf\n", duration);
	fclose(fp);

	printf(" Duration %lf\n", duration);
	return 0;
}