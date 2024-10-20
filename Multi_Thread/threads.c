#include "threads.h"

#include <stdio.h>
void* adder(void* nums)
{
    int a = ((int*) nums)[0];
    int b = ((int*) nums)[1];
    printf("%d\n", a);
    printf("%d\n", b);
    return NULL;
}
