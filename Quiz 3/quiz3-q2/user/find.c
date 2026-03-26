#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

// Helper to get the filename from a path (e.g., "a/b/c" -> "c")
char* fmtname(char *path) {
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return the name without padding
  if(strlen(p) >= DIRSIZ)
    return p;
  
  memmove(buf, p, strlen(p));
  buf[strlen(p)] = 0; 
  return buf;
}

void find(char *path, char *target) {
  int fd;
  struct stat st;
  struct dirent de;
  static char buf[255];

  fd = open(path, 0);
  fstat(fd, &st);

  switch(st.type){
  	case T_FILE:
      if (strcmp(fmtname(path), target) == 0){
        printf("%s\n", path);
      }
      break;
      
    case T_DIR:
      //printf("directory\n");
      while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if(de.inum == 0) {	// This checking is important!!!
          //printf("This is an invalid entry! Ignore it!");
          continue;
        }
        
        if(strcmp(de.name, ".") == 0){
          //printf("This entry represents the current directory");
          continue;
        }
        
        if(strcmp(de.name, "..") == 0){
          //printf("This entry represents the parent directory");
          continue;
        }

        // Processing of the entry
        // ........
        //printf("/%s\n", de.name);
        // printf("%s: ", de.name);
        // printf("%s\n", target);
        memmove(buf, path, strlen(path));
        memmove(buf+strlen(path), "/", 1);
        memmove(buf+strlen(path)+1, de.name, strlen(de.name));
        find(buf, target);
      }
      break;
  }

  close(fd);
}

int main(int argc, char *argv[]) {
  if(argc != 3){
    fprintf(2, "Usage: find <path> <filename>\n");
    exit(1);
  }
  find(argv[1], argv[2]);
  exit(0);
}