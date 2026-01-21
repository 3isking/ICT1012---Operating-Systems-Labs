// user/handshake.c
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    // Create Two Pipes, Parent-Child & Child-Parent
    int pc[2];
    int cp[2];

    // Set Buffer as Initial Byte
    char c;
    c = argv[1][0];

    pipe(pc);
    pipe(cp);
    int pid = fork();

    if(pid == 0) {
        // For Child Process, Close the Write in Parent-Child & Read in Child-Parent
        close(pc[1]);
        close(cp[0]);

        // Read the Pipe on Parent Child & Close the Pipe
        char x;
        read(pc[0], &x, 1);
        printf("%d: received %c from parent\n", getpid(), x);
        close(pc[0]);

        // Write the received Pipe on Child Parent & Close the Pipe
        write(cp[1], &x, 1);
        close(cp[1]);

    } else if (pid > 0) {
        // For Parent Process, Close the Read in Parent-Child & Write in Child-Parent
        close(pc[0]);
        close(cp[1]);

        // Write the Initial Inputted Byte into Parent-Child & Close the Pipe
        write(pc[1], &c, 1);
        close(pc[1]);
        
        // Read the Pipe on Child Parent & Close the Pipe
        char y;
        read(cp[0], &y, 1);
        printf("%d: received %c from child\n", getpid(), y);
        close(cp[0]);
    }

    exit(0);
}