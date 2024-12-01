# set b to the path to the BareMetal-OS directory
B=../BareMetal-OS
c=-mno-red-zone -mcmodel=large -fomit-frame-pointer -g  -fno-stack-protector
l=-z max-page-size=0x1000

t.app.img:t.c makefile
	$(CC) $c -c t.c
	ld -T app.ld $l t.o -o t
	objcopy -O binary t t.app
	B=$B ./img.sh t.app

qemu:t.app.img
	qemu-system-x86_64 -serial stdio -m 256 -drive file=t.app.img,format=raw

bochs:t.app.img
	bochs -n -q 'boot: disk' 'ata0-master: type=disk, path=t.app.img' 
