int main();
int _start()
{
        return  main();
}

int print(char *s) {
	int n;
	for(n=0;s[n];n++)
		;
        asm volatile ("call *0x00100018" : : "S"(s), "c"(n));
}

int main()
{
	print("ho 9\n");
	return 0;
}
