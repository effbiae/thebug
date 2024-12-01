#define out(s,n) asm volatile ("call *0x00100018" : : "S"(s), "c"(n))
int main();
int _start()
{
	char*s="hi 8\n";
	int n=5;
	out(s,n);
        return main();
}

#ifdef THEBUG
#include "pf/pf.h"
ssize_t write(int f,const void *s, size_t n) {
        out(s,n);
}
#endif
int main()
{
	return 0;
}
