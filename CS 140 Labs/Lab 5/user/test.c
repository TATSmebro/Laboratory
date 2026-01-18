#include "kernel/types.h"
#include "user/user.h"

int main() {
  
  (*(volatile uint32 *) 0x100000) = 0x5555;
  return 0;

}