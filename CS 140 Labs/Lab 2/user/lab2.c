#include "kernel/types.h"
#include "user/user.h"

int main() {

    int dummy = 0;

    for (unsigned int i = 0; i < 1000000; i++) {
        for (unsigned int k = 0; k < 60000; k++) {
            dummy += 1;
        }
    }

    exit(0);
}
