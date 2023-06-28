PAGE_SIZE := 4096 # 0x1000

K210_BOOTLOADER_SIZE := 131072 # 0x20000
NESTED_KERNEL_SIZE := 2097152 # 0x200000

OUTPUT := k210_img.bin

PORT ?= /dev/ttyUSB0
K210-BURNER := ./tools/kflash.py

search_port:
	# check whether board connected.
	dmesg | grep tty
	
copy_file:
	cp $(BOOTLOADER) .
	cp $(KERNEL_BIN) .
	cp $(OKERNEL_BIN) .

local_concat:
	@cp fw.bin ./$(OUTPUT)
	@dd if=TeernOS_nk.bin of=$(OUTPUT) bs=$(K210_BOOTLOADER_SIZE) seek=1
	@dd if=UltraOS.bin of=$(OUTPUT) bs=$(NESTED_KERNEL_SIZE) seek=1
	
concat:
	@cp $(BOOTLOADER) ./$(OUTPUT)
	@dd if=$(KERNEL_BIN) of=$(OUTPUT) bs=$(K210_BOOTLOADER_SIZE) seek=1
	@dd if=$(OKERNEL_BIN) of=$(OUTPUT) bs=$(NESTED_KERNEL_SIZE) seek=1
	
build: copy_file concat
	

run:
	(which $(K210-BURNER)) || (git clone https://github.com/sipeed/kflash.py.git && mv kflash.py tools)
	@sudo chmod 777 $(PORT)
	python3 $(K210-BURNER) -p $(PORT) -b 1500000 $(OUTPUT)
	python3 -m serial.tools.miniterm --eol LF --dtr 0 --rts 0 --filter direct $(PORT) 115200
