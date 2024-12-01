# a mysterious bug

to reproduce the bug:
 - clone this repo
 - edit the makefile to set B to the path to BareMetal-OS
 - make sure BareMetal-OS has all binaries in sys (run ./baremetal.sh build if you're not sure)
 - run `make qemu`
   * note output is expected, it prints `hi 8\n`
 - run `THEBUG=1 make qemu`
   * note output is not expected (i get continuous output)

i suspect there is something wrong with loading apps because
the only difference between the two cases is the size of the app.
note the `#ifdef` in t.c only adds more code to the app, it doesn't
call any new code - nothing should have changed

you can also run `make bochs` if you want to see it in bochs.
 - when bochs prompts you, press 6 to begin simulation

edit the makefile to pass -s -S flags to qemu to debug
