#include <stdio.h>

int main()
{
	int n;
	double rs;
	
	while (scanf("%d", &n) > 0)
	{
		rs = n;
		
		if (rs <= 800)
		{
			rs *= 0.9;
		}
		else if (rs <= 1500)
		{
			rs *= 0.9 * 0.9;
		}
		else
		{
			rs *= 0.9 * 0.79;
		}
		printf ("%.1f\n", rs);
	}
	
	return 0;
}
