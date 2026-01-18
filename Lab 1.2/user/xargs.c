// user/xargs.c
#include "kernel/param.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    char stdin[512];
    int pos = 0;
    char *args[MAXARG];

    // perLine is 0 by Default & 1 if -n 1
    int perLine = 0;
    int cmdStart = 1;

    // Detect -n 1
    if(argc >= 3 && strcmp(argv[1], "-n") == 0 && strcmp(argv[2], "1") == 0){
        perLine = 1;
        cmdStart = 3;
    }

    if(argc <= cmdStart){
        printf("Usage: xargs command [args...]\n");
        exit(1);
    }

    // Store Base Command Into args[]
    int baseArgc = 0;
    for(int i = cmdStart; i < argc; i++){
        args[baseArgc++] = argv[i];
    }

    // Read STDIN by Char & Store into STDIN Buffer
    while(read(0, stdin + pos, 1) > 0){
        if(stdin[pos] == '\n'){
            if(perLine){
                // Terminate Lines if -n 1
                stdin[pos] = 0;
            } else {
                // Treat Newline as Space Otherwise
                stdin[pos] = ' '; 
            }
        }
        pos++;
    }

    // Contain Full Input into Buffer if no -n 1
    if(!perLine){
        stdin[pos] = 0;
        pos = strlen(stdin);
    }

    int i = 0;
    while(i < pos){
        // For perLine mode, Handle By Line
        int start = i;

        if(perLine){
            while(i < pos && stdin[i] != 0)
                i++;
        } else {
            // single run mode: whole buffer once
            i = pos;
        }

        // Tokenize STDIN into Arguments
        char *p = &stdin[start];
        int argInd = baseArgc;

        while(*p){
            // Skip Leading Spaces
            while (*p == ' ') {
                p++;
            }
            // Break loop if Endline
            if (*p == 0) {
                break;
            }
            // Loop Through Whole String & Replace Spaces with Endlines
            args[argInd++] = p;
            while (*p && *p != ' ') {
                p++;
            }
            if (*p) {
                *p = 0;
                p++;
            }
        }

        args[argInd] = 0;

        if(fork() == 0){
            exec(args[0], args);
            // Print Fail If exec() fails
            printf("xargs: exec failed\n");
            exit(1);
        } else {
            wait(0);
        }

        if(perLine)
            // Skip Null Terminator
            i++; 
        else
            break;
    }

    exit(0);
}