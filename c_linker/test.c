#include <stdio.h>
#include <stdlib.h>

void exitx() {
	__asm__("li a7, 93 \n\t li a0, 0 \n\t ecall");
}
int printt() {
	char *c = "awa\n\0";
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
	::"r"((unsigned long long)c)
	);
	return 0;
}
int main(){
	
	char *c = "0wa\n\0";
	unsigned long long a = (unsigned long long)c;
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
	::"r"(c)
	);
	putchar(48);
	__asm__("li a7, 999 \n\t li a0, 666 \n\t ecall");

	//__asm__("li a7, 93 \n\t li a0, 0 \n\t ecall");
	printt();
	exitx();
	return 0;
}


