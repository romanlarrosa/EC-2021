// gcc -Og bomba_roman_larrosa.c -o bomba_roman_larrosa -no-pie -fno-guess-branch-probability

#include <stdio.h>		// para printf(), fgets(), scanf()
#include <stdlib.h>		// para exit()
#include <string.h>		// para strncmp()
#include <sys/time.h> // para gettimeofday(), struct timeval

#define SIZE 100
#define TLIM 5

#ifndef TEST
#define TEST 0
#endif

char password[] = "ojeljnjeYma`pdt\n"; // contraseña
int passcode = 7777;									 // pin

void boom(void)
{
	printf("\n"
				 "***************\n"
				 "*** BOOM!!! ***\n"
				 "***************\n"
				 "\n");
	exit(-1);
}

void encode(char *str, size_t size)
{
	int i, temp;
	size--;

	// use for loop to iterate the string
	for (i = 0; i < size / 2; i++)
	{
		// temp variable use to temporary hold the string
		temp = str[i];
		str[i] = str[size - i - 1] + i;
		str[size - i - 1] = temp - i;
	}
}

void defused(void)
{
	printf("\n"
				 "·························\n"
				 "··· bomba desactivada ···\n"
				 "·························\n"
				 "\n");
	exit(0);
}

int main()
{
	char pw[SIZE];
	int pc, n;

	struct timeval tv1, tv2; // gettimeofday() secs-usecs
	gettimeofday(&tv1, NULL);

	do
		printf("\nIntroduce la contraseña: ");
	while (fgets(pw, SIZE, stdin) == NULL);

	encode(pw, strlen(pw)); // Codificar la contraseña

	if (strncmp(pw, password, sizeof(password)))
		boom();

	gettimeofday(&tv2, NULL);
	if (tv2.tv_sec - tv1.tv_sec > TLIM)
		boom();

	do
	{
		printf("\nIntroduce el pin: ");
		if ((n = scanf("%i", &pc)) == 0)
			scanf("%*s") == 1;
	} while (n != 1);
	if (pc != passcode)
		boom();

	gettimeofday(&tv1, NULL);
	if (tv1.tv_sec - tv2.tv_sec > TLIM)
		boom();

	defused();
}
