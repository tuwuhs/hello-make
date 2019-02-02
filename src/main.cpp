
#include "ohyeah.h"
#include "yeah.h"

#include <stdio.h>

int main(int argc, char* argv[])
{
	printf("Hello world!\n");
	printf("Yeah: %d\n", Yeah(123));
	printf("OhYeah: %d\n", OhYeah(234));
	printf("YeahOhYeah: %f\n", YeahOhYeah(45));
	
	return 0;
}
