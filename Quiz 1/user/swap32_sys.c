#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int htoi_safe(char *s, uint *res) {
    *res = 0;
    char *p = s;

    // Handle 0x prefix
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X'))
        p += 2;
    if (*p == '\0') return -1;
    
    while (*p) {
        uint d;
        if (*p >= '0' && *p <= '9') d = *p - '0';
        else if (*p >= 'a' && *p <= 'f') d = *p - 'a' + 10;
        else if (*p >= 'A' && *p <= 'F') d = *p - 'A' + 10;
        else return -1; // Invalid character found
        *res = (*res << 4) | d;
        p++;
    }

    return 0;
}

int main(int argc, char *argv[])
{
    uint val;
    uint swapped;

    if (argc != 2) {
        fprintf(2, "usage: swap32 <32-bit hex value>\n");
        exit(1);
    }

    if (htoi_safe(argv[1], &val) != 0) {
        printf("Input:  %s\n", argv[1]);
        printf("Invalid argument\n");
        exit(1);
    }

    // Parse hexadecimal (base 16)
    
    printf("Input:  0x%x\n", val);
    swapped = endianswap(val);
    printf("Output: 0x%x\n", swapped);
    exit(0);
}