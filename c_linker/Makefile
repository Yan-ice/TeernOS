# GCCI := riscv64-unknown-elf-gcc
GCC := riscv64-linux-gnu-gcc
# FLAGS := -nostdlib -nostdinc ./cross/crt.S
FLAGS := -no-pie # -nostdinc -nostdlib

CC_TARGET := test.o

build_c: $(CC_TARGET)
	$(GCC) $(FLAGS) $(CC_TARGET) -static -o ttst

%.o: %.c
	$(GCC) -c -O2 -o $@ $^ $(FLAGS)
    
