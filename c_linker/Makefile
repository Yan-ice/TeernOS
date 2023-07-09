musl := 1

ifdef musl
	# GCC := /home/yan_ice/riscv-musl/bin/riscv64-unknown-linux-musl-gcc
	# LIB := /home/yan_ice/riscv-musl/sysroot/lib #-L/home/yan_ice/riscv-musl/riscv64-unknown-linux-musl/lib
	# INCLUDE := /home/yan_ice/riscv-musl/sysroot/include
	GCC := riscv64-unknown-linux-musl-gcc
	LIB := /home/wind/Desktop/riscv/sysroot/lib
	INCLUDE := /home/wind/Desktop/riscv/sysroot/include
endif

ifdef elf
	# GCC := /home/yan_ice/riscv-un/bin/riscv64-unknown-elf-gcc
	# LIB := /home/yan_ice/riscv-un/riscv64-unknown-elf/lib
	# INCLUDE := /home/yan_ice/riscv-un/riscv64-unknown-elf/include
	GCC := /home/wind/Desktop/riscv-tools/bin/riscv64-unknown-elf-gcc
	LIB := /home/wind/Desktop/riscv-tools/riscv64-unknown-elf/lib
	INCLUDE := /home/wind/Desktop/riscv-tools/riscv64-unknown-elf/include
endif

ifdef gnu
	GCC := riscv64-linux-gnu-gcc
	INCLUDE := .
	LIB := .
	FLAGS := -no-pie
endif

CC_TARGET := test.o

all: build_c


build_c: $(CC_TARGET)
# $(GCC) $(FLAGS) -L$(LIB) $(CC_TARGET) -static -o ttst -march=rv64imac -mabi=lp64
	$(GCC) $(FLAGS) -L$(LIB) -lc $(CC_TARGET) -static -o ttst

build_s: $(CC_TARGET)
# $(GCC) $(FLAGS) -L. ./cross/crt.S $(CC_TARGET) -static -o ttst -march=rv64imac -mabi=lp64 -T ./cross/user.ld
	$(GCC) $(FLAGS) ./cross/crt.S -L$(LIB) -lc -lm -lrt $(CC_TARGET) -static -o ttst -T ./cross/user.ld -Ttext 0x1000



%.o: %.c
# $(GCC) -c -O0 -o $@ $^ $(FLAGS) -I$(INCLUDE) -march=rv64imac -mabi=lp64
	$(GCC) -c -O2 -o $@ $^ $(FLAGS) -I$(INCLUDE)

obj:
	/home/wind/Desktop/riscv/riscv64-unknown-linux-musl/bin/objdump -D ttst > ttst1.dis
	
    
