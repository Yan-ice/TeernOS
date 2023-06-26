int main(){
    char *my_c = "1111\n\0";

    unsigned long long my_a = (unsigned long long)my_c;

    asm("li a7, 64 \n\t li a0, 1 \n\t mv a1, %0 \n\t li a2, 4 \n\t ecall"::"r"(my_a));
	printf("here\n");
	// printf(1111);
	return 0;
}

