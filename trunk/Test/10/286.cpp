#include<stdio.h>
#include<time.h>
#include<stdlib.h>
int main()
{
	int game_play;
	int player_select=1;
	int strategy_code;
	srand(time(NULL));
	int bonus_box;
	int empty_box;
	
	while(scanf("%d",&game_play)>0)
	{
		bonus_box=1+rand()%3;
		int check[4]={0,0,0,0};
		check[bonus_box]++;
		
		if(game_play==1)
		{
			scanf("%d",&player_select);
		}
		else if(game_play==2)
		{
			scanf("%d",&strategy_code);
			
			if(strategy_code==1)
			{
				//1.Keep the original choice.
			}
			else if(strategy_code==2)
			{
				//2.Change to the other box.
				scanf("%d",&player_select);
			}
			else if(strategy_code==3)
			{
				//3.Random selection.
				player_select=1+rand()%3;
			}
		}
		check[player_select]++;
		
		if(check[1]==0) empty_box=1;
		else if(check[2]==0) empty_box=2;
		else empty_box=3;
		printf("=Game Role=\n");
		printf("1.Choose one box that you think with bonus.\n");
		printf("2.Wait for the banker announced an empty box then choose a strategy code.\n");
		printf("Strategy Code:\n");
		printf("1.Keep the original choice.\n");
		printf("2.Change to the other box.\n");
		printf("3.Random selection.\n");
		printf("******************************\n");
		printf("Player select:%d\n",game_play);
		printf("Empty box:%d\n",empty_box);
		printf("Final select:%d\n",player_select);
		printf(">The Bonus is in the box %d\n",bonus_box);
		printf(">>%s\n",check[bonus_box]==2?"WON":"FAILED");
	}
	return 0;
}
