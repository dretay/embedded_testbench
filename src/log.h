#pragma once

//simple debug logging
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

//void printfUART(const char *fmt, ...);
//
//#define LOG(...) printfUART(__VA_ARGS__)
#define DEBUG 1

#define _ERROR(fmt, ...)                                          \
    do {                                                          \
        if (DEBUG)                                                \
            fprintf(stderr, "[ERROR] %s:%d:%s(): " fmt, __FILE__, \
                __LINE__, __func__, __VA_ARGS__);                 \
        printf("\r\n");                                           \
    } while (0)
#define _WARN(fmt, ...)                                           \
    do {                                                          \
        if (DEBUG)                                                \
            fprintf(stderr, "[ERROR] %s:%d:%s(): " fmt, __FILE__, \
                __LINE__, __func__, __VA_ARGS__);                 \
        printf("\r\n");                                           \
    } while (0)
#define _INFO(fmt, ...)                                           \
    do {                                                          \
        if (DEBUG)                                                \
            fprintf(stderr, "[ERROR] %s:%d:%s(): " fmt, __FILE__, \
                __LINE__, __func__, __VA_ARGS__);                 \
        printf("\r\n");                                           \
    } while (0)
#define _DEBUG(fmt, ...)                                          \
    do {                                                          \
        if (DEBUG)                                                \
            fprintf(stderr, "[ERROR] %s:%d:%s(): " fmt, __FILE__, \
                __LINE__, __func__, __VA_ARGS__);                 \
        printf("\r\n");                                           \
    } while (0)

//#define _ERROR(fmt, args...) LOG("\r\n[ERROR] %s%s:%s:%d: "fmt, __FILE__, __FUNCTION__, __LINE__, args)
//#define __ERROR(...) printfUART(__VA_ARGS__)

//#define _WARN(fmt, args...) LOG("\r\n[WARN] %s%s:%s:%d: "fmt, __FILE__, __FUNCTION__, __LINE__, args)
//#define __WARN(...) printfUART(__VA_ARGS__)
//
//
//#define _INFO(fmt, args...) LOG("\r\n[INFO] %s:%s:%d: "fmt, __FILE__, __FUNCTION__, __LINE__, args)
//#define __INFO(...) printfUART(__VA_ARGS__)
//
//
//#define _DEBUG(fmt, args...) LOG("\r\n[DEBUG] %s:%s:%d: "fmt, __FILE__, __FUNCTION__, __LINE__, args)
//#define __DEBUG(...) printfUART(__VA_ARGS__)
