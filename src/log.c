#include "log.h"

//from: https://electronics.stackexchange.com/questions/206113/how-do-i-use-the-printf-function-on-stm32
static void vprint(const char *fmt, va_list argp)
{
	printf(fmt,argp);    
}

void printfUART(const char *fmt, ...) // custom printf() function
{
	va_list argp;
	va_start(argp, fmt);
	vprint(fmt, argp);
	va_end(argp);
}