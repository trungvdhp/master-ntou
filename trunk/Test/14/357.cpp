#include<stdio.h>
int main()
{
	float weight, height;
	scanf("%f%f",&height,&weight);
	height/=100;
	float BMI=weight/(height*height);
	printf("%.2f\n",BMI);
	
	if(BMI <18.5)
		printf("Underweight");
	else if(BMI<24)
		printf("Normal");
	else if(BMI<27)
		printf("Overweight");
	else if(BMI<30)
		printf("Obese Class I");
	else if(BMI<35)
		printf("Obese Class II");
	else
		printf("Obese Class III");
	return 0;
}
