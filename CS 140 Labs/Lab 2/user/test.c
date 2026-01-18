#include "kernel/types.h"
#include "user/user.h"
int main() {

    for (int i = 0; i < 3; i++) {
        if (fork() == 0) {
            char *argv[] = {"lab2", 0};
            exec("lab2", argv);
        }
    }

    for (int i = 0; i < 3; i++) {
        wait(0);
    }

    shutdown();
}