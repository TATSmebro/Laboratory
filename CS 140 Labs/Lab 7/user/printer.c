#include "kernel/types.h"
#include "user/user.h"
int main()
{
    if (fork() == 0)
    {
        while (1)
        {
            char str[] = "0123456789\n";
            write(1, str, 11);
        }
    }
    else
    {
        while (1)
        {
            char str[] = "ABCDEFGHIJ\n";
            write(1, str, 11);
        }
    }
}