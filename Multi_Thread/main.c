#include <stdio.h>
#include "threads.h"

int main()
{
    pthread_t thread_id;
    printf("Before Thread\n");
    int args[] = {2, 5};
    pthread_create(&thread_id, NULL, adder, (void*) args);
    pthread_join(thread_id, NULL);
    printf("After Thread\n");
}
