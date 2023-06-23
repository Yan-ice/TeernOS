IMG_NAME := fat.img
FILE ?= .

all: commit_file

$(IMG_NAME):
	qemu-img create -u -f raw $(IMG_NAME) 128M
	sudo mkfs.vfat -F 32 $(IMG_NAME)

mnt:
	mkdir mnt
	
content:
	mkdir content

mount: mnt $(IMG_NAME)
	sudo mount $(IMG_NAME) ./mnt
	
umount: mnt $(IMG_NAME)
	sudo umount ./mnt	

add_file:
	make mount
	sudo cp $(FILE) ./mnt
	make umount

commit_file:
	rm -f $(IMG_NAME)
	make mount
	sudo rm -rf ./mnt/*
	sudo cp ./content/* ./mnt -r
	make umount

