B=../BareMetal-OS
c=-mno-red-zone -mcmodel=large -fomit-frame-pointer -g  -fno-stack-protector
ifdef THEBUG
 c+= -DTHEBUG
endif
$(shell touch t.c)
l=-z max-page-size=0x1000
img=$B/sys/baremetal_os.img
app=$B/sys/t.app

all:$(img)

pf/pf.h:
	git clone https://github.com/kparc/pf.git
$(app):t.c makefile pf/pf.h
	$(CC) $c -c t.c
	ld -T app.ld $l t.o -o t
	objcopy -O binary t $(app)
$(img):$(app)
	cd $B && ./baremetal.sh t.app
qemu:$(img)
	qemu-system-x86_64 -serial stdio -m 256 -drive file=$(img),format=raw
bochs:$(img)
	bochs -n -q boot:disk ata0-master:type=disk,path=$(img)
clean:
	rm -rf pf $(img) $(app) *.o t
