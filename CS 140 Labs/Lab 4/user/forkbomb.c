#include "kernel/types.h"
#include "user/user.h"

int main() {
    int pid = getpid();
    char *args[] = {"forkbomb", 0};
    
    if (fork() == -1) {
        printf("fork failed for PID %d\n", pid);
    }
    
    exec("forkbomb", args);
}
