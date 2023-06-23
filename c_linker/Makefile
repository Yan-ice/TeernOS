# GCC := riscv64-unknown-elf-gcc
GCC := riscv64-unknown-linux-musl-gcc
# FLAGS := -nostdlib -nostdinc ./cross/crt.S
FLAGS := 
TARGET ?= fstime.c

build_c: $(TARGET)
	$(GCC) $(FLAGS) ./cross/main.o  $(TARGET) -Ttext 0x1000 -T ./cross/user.ld

%.o: %.c
	$(GCC) -o $@ $^ $(FLAGS)
    
