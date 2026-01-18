#include "kernel/types.h"
#include "user/user.h"

static inline uint64 get_pc(void) {
    uint64 pc;
    __asm__ volatile("auipc %0, 0" : "=r"(pc));
    return pc;
}

int main() {
    unsigned char *p = (unsigned char *)sbrk(20000);

    printf("Sample PC value: 0x%lx\n", get_pc());
    printf("&p: %p\n", &p);
    printf("p: %p\n", p);

    for (int i = 0; i < 20000; i++) {
        p[i] = 0x21;
    }

    vaspace();
    
    exit(0);
}