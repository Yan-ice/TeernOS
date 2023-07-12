export cwd := $(shell pwd)
#export TARGET := riscv64imac-unknown-none-elf
export TARGET := riscv64gc-unknown-none-elf


export MODE ?= release
export BOARD ?= k210
export C_TARGET ?= musl

export QEMU_SYSTEM := $(cwd)/qemu_old/qemu-system-riscv64


export U_FAT32 := $(cwd)/fs_tool/fat.img

export OS_PATH := $(cwd)/codes/os
export NK_PATH := $(cwd)/codes/nk
export SBI_PATH := $(cwd)/opensbi_nk
export K210_PATH := $(cwd)/k210

# export KERNEL_ELF := $(NK_PATH)/target/$(TARGET)/$(MODE)/TeernOS_nk
# export KERNEL_BIN := $(KERNEL_ELF).bin
export KERNEL_BIN := $(cwd)/MMK.bin

export OKERNEL_ELF := $(OS_PATH)/target/$(TARGET)/$(MODE)/UltraOS
export OKERNEL_BIN := $(OKERNEL_ELF).bin

ifeq ($(BOARD), qemu)
	export BOOTLOADER := $(SBI_PATH)/build/platform/generic/firmware/fw_jump.bin
	KERNEL_ENTRY_PA := 0x80200000
	OKERNEL_ENTRY_PA := 0x80800000
	
else ifeq ($(BOARD), k210)
	export BOOTLOADER := $(SBI_PATH)/build/platform/kendryte/k210/firmware/fw_jump.bin
	KERNEL_ENTRY_PA := 0x80020000
	OKERNEL_ENTRY_PA := 0x80200000
endif

# for opensbi compile.
export CROSS_COMPILE = riscv64-unknown-elf-
export PLATFORM_RISCV_XLEN = 64
export FW_JUMP=y
export FW_JUMP_ADDR=$(KERNEL_ENTRY_PA)

# export PLATFORM = kendryte/k210

all: run

build:
# rustup target add riscv64gc-unknown-none-elf
	cd codes/os && make build
	# cd codes/nk && make build
	cd codes/user && make elf
ifeq ($(BOARD), qemu)
	make build_fs
else ifeq ($(BOARD), k210)
	cd k210 && make build
endif
	
run: build build_sbi
	
ifeq ($(BOARD), qemu)
	@$(QEMU_SYSTEM) \
                -machine virt \
                -nographic \
                -bios $(BOOTLOADER) \
                -device loader,file=$(KERNEL_BIN),addr=$(KERNEL_ENTRY_PA) \
                -device loader,file=$(OKERNEL_BIN),addr=$(OKERNEL_ENTRY_PA) \
                -drive file=$(U_FAT32),if=none,format=raw,id=x0 \
        	-device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0\
                -smp threads=2
else ifeq ($(BOARD), k210)
	cd k210 && make run
endif
	
build_sbi:
ifeq ($(BOARD), qemu)
	cd $(SBI_PATH) && make PLATFORM=generic
else ifeq ($(BOARD), k210)
	cd $(SBI_PATH) && make PLATFORM=kendryte/k210
endif

build_fs:
	# rm -f c_linker/*.o
	# cd c_linker && make
	# cp c_linker/ttst fs_tool/content/
	cd fs_tool && make
	
concat_k210:
	cd k210 && make concat

env:
	rustup update
	cargo install cargo-binutils
	cd codes/os && make env
	# cd codes/nk && make env

gdb:
	cd codes/os && make gdb

monitor:
	cd codes/os && make monitor

os:
	cd codes/os && make run

clean:
	cd codes/os && make clean
	cd codes/user && make clean
	# cd codes/nk && make clean

