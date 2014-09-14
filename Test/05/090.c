#include <stdio.h>
#define INT_MIN -2147483647
typedef struct node
{
	char A[2];
	int begin;
	int end;
	int value;
	int parent;
}node;

node M[10][10];

int main()
{
	int i, j, k;
	int max = 0, rs = 0, x, y;
	int n;
	int a[10];
	
	scanf("%d", &n);
	
	for (i = 0; i < n; i++)
	{
		scanf("%s%d%d%d", &M[i][i].A, &M[i][i].begin,&M[i][i].end, &M[i][i].value);
		M[i][i].parent = i;
	}
	
	for (i = 0; i < n; i++)
	{
		max = -1;
		
		for (j = i + 1; j < n; j++)
		{
			if (M[j][j].begin < M[i][i].end)
			{
				M[i][j].value = INT_MIN;
			}
			else
			{
				if (max == -1)
				{
					max = i;
				
					for (k = i - 1; k >= 0; k--)
					{
						if (M[k][i].value > INT_MIN && M[k][i].value > M[max][i].value)
							max = k;
					}
				}
				M[i][j].parent = max;
				M[i][j].value = M[max][i].value + M[j][j].value;
			}
		}
	}
	x = 0; 
	y = 0;
	
	for (i = 0; i < n; i++)
	{
		for (j = i; j < n; j++)
		{
			if (M[i][j].value > M[x][y].value)
			{
				x = i;
				y = j;
			}
		}
	}
	rs = M[x][y].value;
	j = 0;
	
	while (1)
	{
		a[j++] = y;
		
		if (x == y) break;
		
		k = x;
		x = M[x][y].parent;
		y = k;
	}
	
	while (j--)
	{
		printf ("%s ", M[a[j]][a[j]].A);
	}
	printf ("%d", rs);
	
	return 0;
}

