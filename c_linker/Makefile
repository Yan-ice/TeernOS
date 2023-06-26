#GCC := riscv64-linux-gnu-gcc
#INCLUDE := .
#LIB := .

musl := 1

ifdef musl
	GCC := /home/yan_ice/riscv-musl/bin/riscv64-unknown-linux-musl-gcc
	LIB := /home/yan_ice/riscv-musl/sysroot/lib #-L/home/yan_ice/riscv-musl/riscv64-unknown-linux-musl/lib
	INCLUDE := /home/yan_ice/riscv-musl/sysroot/include
endif

ifdef elf
	GCC := /home/yan_ice/riscv-un/bin/riscv64-unknown-elf-gcc
	LIB := /home/yan_ice/riscv-un/riscv64-unknown-elf/lib
	INCLUDE := /home/yan_ice/riscv-un/riscv64-unknown-elf/include
endif

# FLAGS := -nostdlib -nostdinc ./cross/crt.S
FLAGS := -no-pie -nostdinc # -nostdlib

CC_TARGET := test.o

all: build_c


build_c: $(CC_TARGET)
	$(GCC) $(FLAGS) -L$(LIB) -lc $(CC_TARGET) -static -o ttst

build_s: $(CC_TARGET)
	$(GCC) $(FLAGS) ./cross/crt.S -L$(LIB) -lc -lm -lrt $(CC_TARGET) -static -o ttst -T ./cross/user.ld


%.o: %.c
	$(GCC) -c -O2 -o $@ $^ $(FLAGS) -I$(INCLUDE)
    
