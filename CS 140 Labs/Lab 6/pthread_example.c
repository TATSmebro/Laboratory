#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Function that the new thread will run
void* thread_function(void* arg) {
    printf("Hello from the thread! Thread ID: %lu\n", pthread_self());
    return NULL;
}

int main() {
    pthread_t thread;

    // Create a new thread
    pthread_create(&thread, NULL, thread_function, NULL);
     
    printf("Hello from the main thread!\n");

    // Wait for the created thread to finish
    pthread_join(thread, NULL);

    return 0;
}