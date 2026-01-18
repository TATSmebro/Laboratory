#include "kernel/types.h"
#include "user/user.h"

int main() {
    printf("Before disabling timer interrupts\n");
    asm volatile("csrw sie, %0" : : "r" (0x200));
    printf("After disabling timer interrupts\n");

    exit(0);
}
