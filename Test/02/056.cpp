#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<algorithm>
 
int N, M;
int length[25];
 
bool dfs(int, int, int, int, bool []);

int compare(const void *a, const void *b)
{
	return *(int*)a-*(int*)b;
}

int main()
{
    scanf("%d", &N);
    
    while (N--) 
	{
        scanf("%d", &M);
        int sum = 0, Max = 0;
        
        for (int i = 0; i < M; ++i) 
		{
            scanf("%d", &length[i]);
            Max = std::max(Max, length[i]);
            sum += length[i];
        }
        
        if (sum%4 != 0 || Max > sum/4) 
		{
			puts("no"); 
			continue;
		}
 
        qsort(length,M,sizeof(int),compare);
 
        bool used[25] = {0};
        
        if (dfs(0, 0, 0, sum / 4, used)) 
			puts("yes");
        else 
			puts("no");
    }
}

bool dfs(int num_of_edge, int sum, int start, const int edge_length, bool used[])
{
    if (num_of_edge == 3) return true;
 
    if (sum == edge_length)
        if (dfs(num_of_edge + 1, 0, 0, edge_length, used)) 
			return true;
 
    for (int i = start; i < M; ++i) 
	{
        if (!used[i] && sum + length[i] <= edge_length) 
		{
            used[i] = true;
            if (dfs(num_of_edge, sum + length[i], i+1, edge_length, used))
                return true;
            used[i] = false;
        }
    }
    return false;
}
