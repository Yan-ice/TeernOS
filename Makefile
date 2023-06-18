export cwd := $(shell pwd)
export TARGET := riscv64imac-unknown-none-elf
export MODE ?= release


export QEMU_SYSTEM := $(cwd)/qemu_old/qemu-system-riscv64
export BOOTLOADER := $(cwd)/codes/bootloader/fw_jump.bin

export U_FAT32 := $(cwd)/codes/fat32-fuse/fat32.img

export OS_PATH := $(cwd)/codes/os
export NK_PATH := $(cwd)/codes/nk

export KERNEL_ELF := $(NK_PATH)/target/$(TARGET)/$(MODE)/TeernOS_nk
export KERNEL_BIN := $(KERNEL_ELF).bin

export OKERNEL_ELF := $(OS_PATH)/target/$(TARGET)/$(MODE)/UltraOS
export OKERNEL_BIN := $(OKERNEL_ELF).bin

KERNEL_ENTRY_PA := 0x80200000
OKERNEL_ENTRY_PA := 0x80800000

all: 
	# rustup target add riscv64gc-unknown-none-elf
	cd codes/user && make elf
	cd codes/os && make release BOARD=k210

build_sbi:
	cd opensbi_nk && make
	cp opensbi_nk/build/platform/generic/firmware/fw_jump.bin codes/bootloader/

env:
	rustup update
	cargo install cargo-binutils
	cd codes/fat32-fuse && sh qemu_fs.sh
	cd codes/os && make env
	cd codes/nk && make env

build_kernel:
	cd codes/os && make build
	cd codes/nk && make build

build_os: build_kernel
	cd codes/user && make elf

gdb:
	cd codes/os && make gdb

monitor:
	cd codes/os && make monitor


run_qemu: build_os
	@$(QEMU_SYSTEM) \
                -machine virt \
                -nographic \
                -bios $(BOOTLOADER) \
                -device loader,file=$(KERNEL_BIN),addr=$(KERNEL_ENTRY_PA) \
                -device loader,file=$(OKERNEL_BIN),addr=$(OKERNEL_ENTRY_PA) \
                -drive file=$(U_FAT32),if=none,format=raw,id=x0 \
        -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0\
                -smp threads=2


elf:
	cd codes/user && make elf

os:
	cd codes/os && make run
