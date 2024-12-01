# set b to the path to the BareMetal-OS directory
B=../BareMetal-OS
c=-mno-red-zone -mcmodel=large -fomit-frame-pointer -g  -fno-stack-protector
ifdef THEBUG
 c+= -DTHEBUG
endif
$(shell touch t.c)
l=-z max-page-size=0x1000

all:qemu

pf/pf.h:
	git clone https://github.com/kparc/pf.git

t.app.img:t.c makefile pf/pf.h
	$(CC) $c -c t.c
	ld -T app.ld $l t.o -o t
	objcopy -O binary t t.app
	B=$B ./img.sh t.app

qemu:t.app.img
	qemu-system-x86_64 -serial stdio -m 256 -drive file=t.app.img,format=raw

bochs:t.app.img
	bochs -n -q 'boot: disk' 'ata0-master: type=disk, path=t.app.img' 

clean:
	rm -rf pf t.app* t.o t
