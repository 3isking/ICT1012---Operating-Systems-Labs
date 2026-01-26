#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  if(argc < 3){
    printf("Usage: monitor mask command [args...]\n");
    exit(1);
  }

  int mask = atoi(argv[1]);
  monitor(mask);

  exec(argv[2], &argv[2]);

  printf("exec failed\n");
  exit(1);
}
