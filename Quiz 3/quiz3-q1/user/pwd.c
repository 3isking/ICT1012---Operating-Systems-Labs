#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"


int main(int argc, char *argv[]) {
  int fd;
  struct dirent de;
  char namebuf[DIRSIZ + 1];

  struct stat st_curr;
  struct stat st_parent;
  int iCurrent;
  int iParent;

  while(1){
    stat(".", &st_curr);
    iCurrent = st_curr.ino;   
    stat("..", &st_parent);
    iParent = st_parent.ino;

    if (iCurrent == iParent){
      // Read Current Directory
      break;
    } else {
      
      // Read Current Directory
      fd = open("..", 0);
      while(read(fd, &de, sizeof(de)) == sizeof(de)) {
        if(de.inum == iCurrent) {
          memmove(namebuf, de.name, DIRSIZ);
          namebuf[DIRSIZ] = 0;
          break;
        }
      }
      close(fd);
      printf("/%s", namebuf);
      chdir("..");

    }
  }

  exit(0);
}