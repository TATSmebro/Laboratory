#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int main()
{
    char input[100];
    const char buf[1024];
    int n;

    printf("Enter filename: ");
    read(0, input, 100);

    input[strlen(input) - 1] = '\0';

    int fd = open(input, O_RDONLY);
    printf("fd mapped to %s: %d\n", input, fd);
    inodeinfo(fd);

    printf("Enter disk block number: ");
    read(0, input, 100);
    n = atoi(input);

    blockdata(n, buf);
    
    for (int i = 0; i < 1024; i++)
    {
        printf("index %d: 0x%x (%d)\n", i, buf[i], buf[i]);
    }
}