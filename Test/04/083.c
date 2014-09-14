#include <stdio.h>

typedef struct item
{
	char name[2];
	float value;
	float weight;
}item;

int n = 5;
float size = 20.0f;
float max_weight = 0.0f;
float max_value = 0.0f;
item M[5];
int a[5];
int b[5];
int max_m = 0;

void print()
{
	int i;
	for (i = 0; i < max_m; i++)
	{
		printf ("%s %.1f %.1f\n", M[b[i]].name, M[b[i]].value, M[b[i]].weight);
	}
	
	printf("---------------------------------------------------\n");
	printf ("weight:%.1f\n", max_weight);
	printf ("value:%.1f", max_value);
}

void tryit(int m, float weight, float value)
{
	int i, j;
	float new_weight;
	float new_value;
	
	if (weight >= size)
	{
		new_weight = weight - M[a[m - 1]].weight;
		new_value = value - M[a[m - 1]].value;
		
		if ((new_weight > max_weight) || 
			(new_weight == max_weight && new_value > max_value) || 
			(new_value == max_value && new_weight > max_weight))
		{
			max_weight = new_weight;
			max_value = new_value;
						
			for (j = 0; j < m - 1; j++)
			{
				b[j] = a[j];
			}
			max_m = m - 1;
		}
	}
	else if (m == n || a[m - 1] == 0)
	{
		if ((weight > max_weight) || 
			(weight == max_weight && value > max_value) || 
			(value == max_value && weight > max_weight))
		{
			max_weight = weight;
			max_value = value;
			
			for (j = 0; j < m; j++)
			{
				b[j] = a[j];
			}
			max_m = m;
		}
	}
	else
	{
		for (i = a[m - 1] - 1; i >= 0; i--)
		{
			a[m] = i;
			tryit(m + 1, weight + M[i].weight, value + M[i].value);
		}
	}
}

int main()
{
	int i, j;
	float value, weight;
	
	for (i = 0; i < n; i++)
	{
		scanf("%s%f%f", &M[i].name, &value, &weight);
		M[i].value = value;
		M[i].weight = weight;
 	}
	
	for (i = n - 1; i >= 0; i--)
	{
		a[0] = i;
		tryit(1, M[i].weight, M[i].value);
	}
	print();
	
	return 0;
}
