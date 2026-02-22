#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"

void memdump(char *fmt, char *data);

int
main(int argc, char *argv[])
{
  if(argc == 1){
    printf("Example 1:\n");
    int a[2] = { 61810, 2025 };
    memdump("ii", (char*) a);
    
    printf("Example 2:\n");
    memdump("S", "a string");
    
    printf("Example 3:\n");
    char *s = "another";
    memdump("s", (char *) &s);

    struct sss {
      char *ptr;
      int num1;
      short num2;
      char byte;
      char bytes[8];
    } example;
    
    example.ptr = "hello";
    example.num1 = 1819438967;
    example.num2 = 100;
    example.byte = 'z';
    strcpy(example.bytes, "xyzzy");
    
    printf("Example 4:\n");
    memdump("pihcS", (char*) &example);
    
    printf("Example 5:\n");
    memdump("sccccc", (char*) &example);
  } else if(argc == 2){
    // format in argv[1], up to 512 bytes of data from standard input.
    char data[512];
    int n = 0;
    memset(data, '\0', sizeof(data));
    while(n < sizeof(data)){
      int nn = read(0, data + n, sizeof(data) - n);
      if(nn <= 0)
        break;
      n += nn;
    }
    memdump(argv[1], data);
  } else {
    printf("Usage: memdump [format]\n");
    exit(1);
  }
  exit(0);
}

void
memdump(char *fmt, char *data)
{
  // Your code here.
  // Array Pointer
  char *p = data;

  // Loop through FMT
  for (int i = 0; fmt[i] != '\0'; i++) {

    // If FMT is i
    if (fmt[i] == 'i'){
      int val = *(int *)p;
      printf("%d\n", val);
      p += 4;
    }

    //If FMT is p
    if (fmt[i] == 'p'){
      int lo = *(int *)p;
      p += 4;
      int hi = *(int *)p;
       
      // Dont print High Byte is it is Empty
      if (hi == 0){
        printf("%x\n", lo);
      } else {
        printf("%x%x\n", hi, lo);
      }
      p += 4;
    }

    //If FMT is h
    if (fmt[i] == 'h'){
      short val = *(short *)p;
      printf("%d\n", val);
      p += 2;
    }

    //If FMT is c
    if (fmt[i] == 'c'){
      char val = *p;
      printf("%c\n", val);
      p += 1;
    }

    //If FMT is s
    if (fmt[i] == 's'){
      char *val = *(char **)p;
      printf("%s\n", val);
      p += 8;
    }

    //If FMT is s
    if (fmt[i] == 'S'){
      printf("%s\n", p);
      p += strlen(p) + 1;
    }

    
  }
}
