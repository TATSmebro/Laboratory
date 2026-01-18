#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int main() {
    int fd = open("test.txt", O_RDONLY);
    inodeinfo(fd);
}