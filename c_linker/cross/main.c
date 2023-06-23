extern int main();

int __start_main(long *p)
{
	int argc = p[0];
	char **argv = (void *)(p+1);

	int ret = main(argc, argv);
	__asm__(
		"add a0, zero, %0\n\t"
		"addi x17, zero, 93\n\t"
		"ecall"
		::"r"(ret)
	);
	return 0;
}
