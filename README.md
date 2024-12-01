# a mysterious bug

to reproduce the bug:
 - edit makefile to set B to the path to BareMetal-OS
 - run `make qemu`
   * note output is expected
 - run `THEBUG=1 make qemu`
   * note output is not expected (i get continuous output)

you can also run `make bochs` if you want to see it in bochs.
 - when bochs prompts you, press 6 to begin simulation

edit the makefile to pass -s -S flags to qemu to debug
