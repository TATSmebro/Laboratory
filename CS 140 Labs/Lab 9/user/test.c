#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int fd;

  /* Test 1: Simple case with "abc\n" */
  fd = open("test.txt", O_CREATE | O_WRONLY);
  if (fd < 0) {
    printf("open for write failed\n");
    exit(1);
  }

  write(fd, "abc\n", 4);
  close(fd);

  printf("Test 1: abc\\n file\n");
  printf("expected checksum: 48 (97+98+99+10=304, 304%%256=48)\n");

  fd = open("test.txt", O_RDONLY);
  if (fd < 0) {
    printf("open for read failed\n");
    exit(1);
  }

  checksum(fd);
  close(fd);

  printf("\n");

  /* Test 2: File with indirect blocks */
  char buf[512];
  for (int i = 0; i < 512; i++)
    buf[i] = 1;

  fd = open("large.txt", O_CREATE | O_WRONLY);
  if (fd < 0) {
    printf("open for write failed\n");
    exit(1);
  }

  /* Write 14 blocks (12 direct + 2 indirect) */
  for (int i = 0; i < 14; i++) {
    write(fd, buf, 512);
  }
  close(fd);

  printf("Test 2: 14 blocks of 1's\n");
  printf("expected checksum: %d ((14*512)%%256)\n", (14 * 512) & 0xff);

  fd = open("large.txt", O_RDONLY);
  if (fd < 0) {
    printf("open for read failed\n");
    exit(1);
  }

  checksum(fd);
  close(fd);

  exit(0);
}