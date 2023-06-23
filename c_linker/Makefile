GCC := riscv64-unknown-elf-gcc
FLAGS := -nostdlib -nostdinc
TARGET ?= test.o

build_c: $(TARGET)
	$(GCC) $(FLAGS) ./cross/main.o ./cross/crt.S $(TARGET) -Ttext 0x1000 -T ./cross/user.ld

%.o: %.c
	$(GCC) -o $@ $^ $(FLAGS)
    
