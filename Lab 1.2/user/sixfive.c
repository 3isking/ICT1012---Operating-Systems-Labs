// user/sixfive.c
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    int fd;
    char c;
    char str[128];
    int charCount = 0;

    if(argc >= 2){
        for (int i = 1; i < argc; i++){
            fd = open(argv[i], 0);
            while (read(fd, &c, 1) > 0){
                if(strchr(" -\r\t\n./,", c) != 0){
                    // If character is a separator, parse everything in str buffer as number
                    if(charCount > 0){
                        str[charCount] = 0;
                        int num = atoi(str);

                        // Check if Number Divisible by 5 or 6
                        if (num % 5 == 0 || num % 6 == 0 ){
                            printf("%d\n", num);
                        }
                        
                        charCount = 0;
                    }
                } else if(c >= '0' && c <= '9'){  
                    // If character is a number, add to buffer
                    if(charCount < sizeof(str) - 1){
                        str[charCount] = c;
                        charCount++;
                    }
                }
            };

            // Print last number
            if(charCount > 0){
                str[charCount] = 0;
                int num = atoi(str);
                if(num % 5 == 0 || num % 6 == 0){
                    printf("%d\n", num);
                }
            }
        
        }
        
    } else {
        printf("Usage: sixfive [filename]\n");
    }
    exit(0);
}