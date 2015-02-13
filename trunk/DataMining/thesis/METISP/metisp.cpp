#include "metisp.h"
#include "SequentialDatabase.h"
#include <time.h>

double min_sup;
int mingap;
int maxgap;
int swin;
int THRESHOLD;

int ITEM_NO = 3000;

void SetParameter()
{
	min_sup = 0.15;
	mingap = 5;
	maxgap = 16;
	swin = 3;	
}


int main(int argc, char * argv[])
{
	FILE * fp = fopen("time.txt","a");
	//fstream fout("time.txt",ios::app);
	//fout.open("time.txt",fstream::app);
	
	//time_t start,finish;
	clock_t start , finish;
	double duration;
//	argc = 2;
//	argv[0] = "";
//	argv[1] = "dss.txt"; // ¿é¤JÀÉ®×
	//if (argc < 2)
	//{
	//	printf("usage: metisp <infile> [<MINSUP> <MINGAP> <MAXGAP> <SWIN> <DUN>] [<outfile>]\n");
	//	exit(1);
	//}
	//else if (argc >= 7)
	//{
	//	min_sup = atof(argv[2]);
	//	mingap = atoi(argv[3]);
	//	maxgap = atoi(argv[4]);
	//	swin = atoi(argv[5]);
	//}
	//else
	//{
		SetParameter();
	//}
	// Set Parameter
	//SetParameter();
	//char filename[] = "dss.txt";
	//start = time(NULL);
	start = clock();
	//SequentialDatabase * seqDB = new SequentialDatabase(argv[1]);
	SequentialDatabase * seqDB = new SequentialDatabase("D:\\Master\\DataMining\\thesis\\METISP\\Debug\\ds.txt");
	seqDB->execute();
	/*if (argc >= 8)
	{
		seqDB->outputFrequentPattern(argv[7]);
	}
	else
	{
		seqDB->outputFrequentPattern("out.txt");
	}*/
	//seqDB->outputFrequentPattern("out.txt");
	finish = clock();
	//finish = time(NULL);
	
	//duration = difftime(finish,start);
	duration = (double)(finish - start)/CLOCKS_PER_SEC;
	fprintf(fp,"metisp %s %lf %d %d %d\n",argv[1],min_sup,mingap,maxgap,swin);
	fprintf(fp," Duration %lf\n",duration);
	fclose(fp);
	printf(" Duration %lf\n",duration);
	
	//fout.close();
	delete seqDB;
	//system("pause");
	return 0;
}