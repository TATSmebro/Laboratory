// fork_example.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    } 
    else if (pid == 0) {
        // Child process
        printf("Hello from the child process! PID: %d\n", getpid());
    } 
    else {
        // Parent process
        printf("Hello from the parent process! PID: %d\n", getpid());
    }

    return 0;
}