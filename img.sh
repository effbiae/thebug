#!/bin/bash
set +e
if [ x$B = x ]; then 
 echo set B to the path to BareMetal-OS
fi
app=$1
root=${PWD}
BMFS_SIZE=16
set -e
root=`pwd`
if [ ! -d $B ]; then echo no $B ; exit 1; fi
if [ x$app = x ]; then echo no app; exit 1; fi
if [ ! -e $app ]; then echo no $app; exit 1; fi

s=$B/sys
b=/tmp/bmfs.img
f=/tmp/fat32.img
rm $b $f
dd if=/dev/zero of=$b count=$BMFS_SIZE bs=1048576 > /dev/null 2>&1
dd if=/dev/zero of=$f count=128 bs=1048576 > /dev/null 2>&1
cat $s/pure64-bios.sys $s/kernel.sys $s/monitor.bin > /tmp/software-bios.sys
dd if=/tmp/software-bios.sys of=$b bs=4096 seek=2 conv=notrunc > /dev/null 2>&1
$s/bmfs $b format
# Copy first 3 bytes of MBR (jmp and nop)
dd if=$s/bios.sys of=$f bs=1 count=3 conv=notrunc > /dev/null 2>&1
# Copy MBR code starting at offset 90
dd if=$s/bios.sys of=$f bs=1 skip=90 seek=90 count=356 conv=notrunc > /dev/null 2>&1
# Copy Bootable flag (in case of no mtools)
dd if=$s/bios.sys of=$f bs=1 skip=510 seek=510 count=2 conv=notrunc > /dev/null 2>&1

$s/bmfs $b write $app

cat $f $b > $root/$app.img


