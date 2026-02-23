
user/_swap32_sys:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <htoi_safe>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int htoi_safe(char *s, uint *res) {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    *res = 0;
   6:	0005a023          	sw	zero,0(a1)
    char *p = s;

    // Handle 0x prefix
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X'))
   a:	00054783          	lbu	a5,0(a0)
   e:	03000713          	li	a4,48
  12:	00e78863          	beq	a5,a4,22 <htoi_safe+0x22>
        p += 2;
    if (*p == '\0') return -1;
  16:	00054783          	lbu	a5,0(a0)
  1a:	c7ad                	beqz	a5,84 <htoi_safe+0x84>
    
    while (*p) {
        uint d;
        if (*p >= '0' && *p <= '9') d = *p - '0';
  1c:	46a5                	li	a3,9
        else if (*p >= 'a' && *p <= 'f') d = *p - 'a' + 10;
  1e:	4615                	li	a2,5
  20:	a825                	j	58 <htoi_safe+0x58>
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X'))
  22:	00154703          	lbu	a4,1(a0)
  26:	0df77713          	andi	a4,a4,223
  2a:	05800693          	li	a3,88
  2e:	fed717e3          	bne	a4,a3,1c <htoi_safe+0x1c>
        p += 2;
  32:	0509                	addi	a0,a0,2
  34:	b7cd                	j	16 <htoi_safe+0x16>
        else if (*p >= 'a' && *p <= 'f') d = *p - 'a' + 10;
  36:	f9f7871b          	addiw	a4,a5,-97
  3a:	0ff77713          	zext.b	a4,a4
  3e:	02e66663          	bltu	a2,a4,6a <htoi_safe+0x6a>
  42:	fa97879b          	addiw	a5,a5,-87
        else if (*p >= 'A' && *p <= 'F') d = *p - 'A' + 10;
        else return -1; // Invalid character found
        *res = (*res << 4) | d;
  46:	4198                	lw	a4,0(a1)
  48:	0047171b          	slliw	a4,a4,0x4
  4c:	8fd9                	or	a5,a5,a4
  4e:	c19c                	sw	a5,0(a1)
        p++;
  50:	0505                	addi	a0,a0,1
    while (*p) {
  52:	00054783          	lbu	a5,0(a0)
  56:	c39d                	beqz	a5,7c <htoi_safe+0x7c>
        if (*p >= '0' && *p <= '9') d = *p - '0';
  58:	fd07871b          	addiw	a4,a5,-48
  5c:	0ff77713          	zext.b	a4,a4
  60:	fce6ebe3          	bltu	a3,a4,36 <htoi_safe+0x36>
  64:	fd07879b          	addiw	a5,a5,-48
  68:	bff9                	j	46 <htoi_safe+0x46>
        else if (*p >= 'A' && *p <= 'F') d = *p - 'A' + 10;
  6a:	fbf7871b          	addiw	a4,a5,-65
  6e:	0ff77713          	zext.b	a4,a4
  72:	00e66b63          	bltu	a2,a4,88 <htoi_safe+0x88>
  76:	fc97879b          	addiw	a5,a5,-55
  7a:	b7f1                	j	46 <htoi_safe+0x46>
    }

    return 0;
  7c:	4501                	li	a0,0
}
  7e:	6422                	ld	s0,8(sp)
  80:	0141                	addi	sp,sp,16
  82:	8082                	ret
    if (*p == '\0') return -1;
  84:	557d                	li	a0,-1
  86:	bfe5                	j	7e <htoi_safe+0x7e>
        else return -1; // Invalid character found
  88:	557d                	li	a0,-1
  8a:	bfd5                	j	7e <htoi_safe+0x7e>

000000000000008c <main>:

int main(int argc, char *argv[])
{
  8c:	7179                	addi	sp,sp,-48
  8e:	f406                	sd	ra,40(sp)
  90:	f022                	sd	s0,32(sp)
  92:	1800                	addi	s0,sp,48
    uint val;
    uint swapped;

    if (argc != 2) {
  94:	4789                	li	a5,2
  96:	00f50d63          	beq	a0,a5,b0 <main+0x24>
  9a:	ec26                	sd	s1,24(sp)
        fprintf(2, "usage: swap32 <32-bit hex value>\n");
  9c:	00001597          	auipc	a1,0x1
  a0:	8f458593          	addi	a1,a1,-1804 # 990 <malloc+0xfc>
  a4:	4509                	li	a0,2
  a6:	710000ef          	jal	7b6 <fprintf>
        exit(1);
  aa:	4505                	li	a0,1
  ac:	2f8000ef          	jal	3a4 <exit>
  b0:	ec26                	sd	s1,24(sp)
    }

    if (htoi_safe(argv[1], &val) != 0) {
  b2:	6584                	ld	s1,8(a1)
  b4:	fdc40593          	addi	a1,s0,-36
  b8:	8526                	mv	a0,s1
  ba:	f47ff0ef          	jal	0 <htoi_safe>
  be:	c10d                	beqz	a0,e0 <main+0x54>
        printf("Input:  %s\n", argv[1]);
  c0:	85a6                	mv	a1,s1
  c2:	00001517          	auipc	a0,0x1
  c6:	8f650513          	addi	a0,a0,-1802 # 9b8 <malloc+0x124>
  ca:	716000ef          	jal	7e0 <printf>
        printf("Invalid argument\n");
  ce:	00001517          	auipc	a0,0x1
  d2:	8fa50513          	addi	a0,a0,-1798 # 9c8 <malloc+0x134>
  d6:	70a000ef          	jal	7e0 <printf>
        exit(1);
  da:	4505                	li	a0,1
  dc:	2c8000ef          	jal	3a4 <exit>
    }

    // Parse hexadecimal (base 16)
    
    printf("Input:  0x%x\n", val);
  e0:	fdc42483          	lw	s1,-36(s0)
  e4:	85a6                	mv	a1,s1
  e6:	00001517          	auipc	a0,0x1
  ea:	8fa50513          	addi	a0,a0,-1798 # 9e0 <malloc+0x14c>
  ee:	6f2000ef          	jal	7e0 <printf>
    swapped = endianswap(val);
  f2:	8526                	mv	a0,s1
  f4:	350000ef          	jal	444 <endianswap>
    printf("Output: 0x%x\n", swapped);
  f8:	0005059b          	sext.w	a1,a0
  fc:	00001517          	auipc	a0,0x1
 100:	8f450513          	addi	a0,a0,-1804 # 9f0 <malloc+0x15c>
 104:	6dc000ef          	jal	7e0 <printf>
    exit(0);
 108:	4501                	li	a0,0
 10a:	29a000ef          	jal	3a4 <exit>

000000000000010e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 10e:	1141                	addi	sp,sp,-16
 110:	e406                	sd	ra,8(sp)
 112:	e022                	sd	s0,0(sp)
 114:	0800                	addi	s0,sp,16
  extern int main();
  main();
 116:	f77ff0ef          	jal	8c <main>
  exit(0);
 11a:	4501                	li	a0,0
 11c:	288000ef          	jal	3a4 <exit>

0000000000000120 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 120:	1141                	addi	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 126:	87aa                	mv	a5,a0
 128:	0585                	addi	a1,a1,1
 12a:	0785                	addi	a5,a5,1
 12c:	fff5c703          	lbu	a4,-1(a1)
 130:	fee78fa3          	sb	a4,-1(a5)
 134:	fb75                	bnez	a4,128 <strcpy+0x8>
    ;
  return os;
}
 136:	6422                	ld	s0,8(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret

000000000000013c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13c:	1141                	addi	sp,sp,-16
 13e:	e422                	sd	s0,8(sp)
 140:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	cb91                	beqz	a5,15a <strcmp+0x1e>
 148:	0005c703          	lbu	a4,0(a1)
 14c:	00f71763          	bne	a4,a5,15a <strcmp+0x1e>
    p++, q++;
 150:	0505                	addi	a0,a0,1
 152:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 154:	00054783          	lbu	a5,0(a0)
 158:	fbe5                	bnez	a5,148 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 15a:	0005c503          	lbu	a0,0(a1)
}
 15e:	40a7853b          	subw	a0,a5,a0
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strlen>:

uint
strlen(const char *s)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16e:	00054783          	lbu	a5,0(a0)
 172:	cf91                	beqz	a5,18e <strlen+0x26>
 174:	0505                	addi	a0,a0,1
 176:	87aa                	mv	a5,a0
 178:	86be                	mv	a3,a5
 17a:	0785                	addi	a5,a5,1
 17c:	fff7c703          	lbu	a4,-1(a5)
 180:	ff65                	bnez	a4,178 <strlen+0x10>
 182:	40a6853b          	subw	a0,a3,a0
 186:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret
  for(n = 0; s[n]; n++)
 18e:	4501                	li	a0,0
 190:	bfe5                	j	188 <strlen+0x20>

0000000000000192 <memset>:

void*
memset(void *dst, int c, uint n)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 198:	ca19                	beqz	a2,1ae <memset+0x1c>
 19a:	87aa                	mv	a5,a0
 19c:	1602                	slli	a2,a2,0x20
 19e:	9201                	srli	a2,a2,0x20
 1a0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a8:	0785                	addi	a5,a5,1
 1aa:	fee79de3          	bne	a5,a4,1a4 <memset+0x12>
  }
  return dst;
}
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strchr>:

char*
strchr(const char *s, char c)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	cb99                	beqz	a5,1d4 <strchr+0x20>
    if(*s == c)
 1c0:	00f58763          	beq	a1,a5,1ce <strchr+0x1a>
  for(; *s; s++)
 1c4:	0505                	addi	a0,a0,1
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	fbfd                	bnez	a5,1c0 <strchr+0xc>
      return (char*)s;
  return 0;
 1cc:	4501                	li	a0,0
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret
  return 0;
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <strchr+0x1a>

00000000000001d8 <gets>:

char*
gets(char *buf, int max)
{
 1d8:	711d                	addi	sp,sp,-96
 1da:	ec86                	sd	ra,88(sp)
 1dc:	e8a2                	sd	s0,80(sp)
 1de:	e4a6                	sd	s1,72(sp)
 1e0:	e0ca                	sd	s2,64(sp)
 1e2:	fc4e                	sd	s3,56(sp)
 1e4:	f852                	sd	s4,48(sp)
 1e6:	f456                	sd	s5,40(sp)
 1e8:	f05a                	sd	s6,32(sp)
 1ea:	ec5e                	sd	s7,24(sp)
 1ec:	1080                	addi	s0,sp,96
 1ee:	8baa                	mv	s7,a0
 1f0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f2:	892a                	mv	s2,a0
 1f4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f6:	4aa9                	li	s5,10
 1f8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1fa:	89a6                	mv	s3,s1
 1fc:	2485                	addiw	s1,s1,1
 1fe:	0344d663          	bge	s1,s4,22a <gets+0x52>
    cc = read(0, &c, 1);
 202:	4605                	li	a2,1
 204:	faf40593          	addi	a1,s0,-81
 208:	4501                	li	a0,0
 20a:	1b2000ef          	jal	3bc <read>
    if(cc < 1)
 20e:	00a05e63          	blez	a0,22a <gets+0x52>
    buf[i++] = c;
 212:	faf44783          	lbu	a5,-81(s0)
 216:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21a:	01578763          	beq	a5,s5,228 <gets+0x50>
 21e:	0905                	addi	s2,s2,1
 220:	fd679de3          	bne	a5,s6,1fa <gets+0x22>
    buf[i++] = c;
 224:	89a6                	mv	s3,s1
 226:	a011                	j	22a <gets+0x52>
 228:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22a:	99de                	add	s3,s3,s7
 22c:	00098023          	sb	zero,0(s3)
  return buf;
}
 230:	855e                	mv	a0,s7
 232:	60e6                	ld	ra,88(sp)
 234:	6446                	ld	s0,80(sp)
 236:	64a6                	ld	s1,72(sp)
 238:	6906                	ld	s2,64(sp)
 23a:	79e2                	ld	s3,56(sp)
 23c:	7a42                	ld	s4,48(sp)
 23e:	7aa2                	ld	s5,40(sp)
 240:	7b02                	ld	s6,32(sp)
 242:	6be2                	ld	s7,24(sp)
 244:	6125                	addi	sp,sp,96
 246:	8082                	ret

0000000000000248 <stat>:

int
stat(const char *n, struct stat *st)
{
 248:	1101                	addi	sp,sp,-32
 24a:	ec06                	sd	ra,24(sp)
 24c:	e822                	sd	s0,16(sp)
 24e:	e04a                	sd	s2,0(sp)
 250:	1000                	addi	s0,sp,32
 252:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 254:	4581                	li	a1,0
 256:	18e000ef          	jal	3e4 <open>
  if(fd < 0)
 25a:	02054263          	bltz	a0,27e <stat+0x36>
 25e:	e426                	sd	s1,8(sp)
 260:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 262:	85ca                	mv	a1,s2
 264:	198000ef          	jal	3fc <fstat>
 268:	892a                	mv	s2,a0
  close(fd);
 26a:	8526                	mv	a0,s1
 26c:	160000ef          	jal	3cc <close>
  return r;
 270:	64a2                	ld	s1,8(sp)
}
 272:	854a                	mv	a0,s2
 274:	60e2                	ld	ra,24(sp)
 276:	6442                	ld	s0,16(sp)
 278:	6902                	ld	s2,0(sp)
 27a:	6105                	addi	sp,sp,32
 27c:	8082                	ret
    return -1;
 27e:	597d                	li	s2,-1
 280:	bfcd                	j	272 <stat+0x2a>

0000000000000282 <atoi>:

int
atoi(const char *s)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 288:	00054683          	lbu	a3,0(a0)
 28c:	fd06879b          	addiw	a5,a3,-48
 290:	0ff7f793          	zext.b	a5,a5
 294:	4625                	li	a2,9
 296:	02f66863          	bltu	a2,a5,2c6 <atoi+0x44>
 29a:	872a                	mv	a4,a0
  n = 0;
 29c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 29e:	0705                	addi	a4,a4,1
 2a0:	0025179b          	slliw	a5,a0,0x2
 2a4:	9fa9                	addw	a5,a5,a0
 2a6:	0017979b          	slliw	a5,a5,0x1
 2aa:	9fb5                	addw	a5,a5,a3
 2ac:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b0:	00074683          	lbu	a3,0(a4)
 2b4:	fd06879b          	addiw	a5,a3,-48
 2b8:	0ff7f793          	zext.b	a5,a5
 2bc:	fef671e3          	bgeu	a2,a5,29e <atoi+0x1c>
  return n;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret
  n = 0;
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <atoi+0x3e>

00000000000002ca <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d0:	02b57463          	bgeu	a0,a1,2f8 <memmove+0x2e>
    while(n-- > 0)
 2d4:	00c05f63          	blez	a2,2f2 <memmove+0x28>
 2d8:	1602                	slli	a2,a2,0x20
 2da:	9201                	srli	a2,a2,0x20
 2dc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e2:	0585                	addi	a1,a1,1
 2e4:	0705                	addi	a4,a4,1
 2e6:	fff5c683          	lbu	a3,-1(a1)
 2ea:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ee:	fef71ae3          	bne	a4,a5,2e2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
    dst += n;
 2f8:	00c50733          	add	a4,a0,a2
    src += n;
 2fc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2fe:	fec05ae3          	blez	a2,2f2 <memmove+0x28>
 302:	fff6079b          	addiw	a5,a2,-1
 306:	1782                	slli	a5,a5,0x20
 308:	9381                	srli	a5,a5,0x20
 30a:	fff7c793          	not	a5,a5
 30e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 310:	15fd                	addi	a1,a1,-1
 312:	177d                	addi	a4,a4,-1
 314:	0005c683          	lbu	a3,0(a1)
 318:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31c:	fee79ae3          	bne	a5,a4,310 <memmove+0x46>
 320:	bfc9                	j	2f2 <memmove+0x28>

0000000000000322 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 322:	1141                	addi	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 328:	ca05                	beqz	a2,358 <memcmp+0x36>
 32a:	fff6069b          	addiw	a3,a2,-1
 32e:	1682                	slli	a3,a3,0x20
 330:	9281                	srli	a3,a3,0x20
 332:	0685                	addi	a3,a3,1
 334:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 336:	00054783          	lbu	a5,0(a0)
 33a:	0005c703          	lbu	a4,0(a1)
 33e:	00e79863          	bne	a5,a4,34e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 342:	0505                	addi	a0,a0,1
    p2++;
 344:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 346:	fed518e3          	bne	a0,a3,336 <memcmp+0x14>
  }
  return 0;
 34a:	4501                	li	a0,0
 34c:	a019                	j	352 <memcmp+0x30>
      return *p1 - *p2;
 34e:	40e7853b          	subw	a0,a5,a4
}
 352:	6422                	ld	s0,8(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret
  return 0;
 358:	4501                	li	a0,0
 35a:	bfe5                	j	352 <memcmp+0x30>

000000000000035c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e406                	sd	ra,8(sp)
 360:	e022                	sd	s0,0(sp)
 362:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 364:	f67ff0ef          	jal	2ca <memmove>
}
 368:	60a2                	ld	ra,8(sp)
 36a:	6402                	ld	s0,0(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret

0000000000000370 <sbrk>:

char *
sbrk(int n) {
 370:	1141                	addi	sp,sp,-16
 372:	e406                	sd	ra,8(sp)
 374:	e022                	sd	s0,0(sp)
 376:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 378:	4585                	li	a1,1
 37a:	0b2000ef          	jal	42c <sys_sbrk>
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <sbrklazy>:

char *
sbrklazy(int n) {
 386:	1141                	addi	sp,sp,-16
 388:	e406                	sd	ra,8(sp)
 38a:	e022                	sd	s0,0(sp)
 38c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 38e:	4589                	li	a1,2
 390:	09c000ef          	jal	42c <sys_sbrk>
}
 394:	60a2                	ld	ra,8(sp)
 396:	6402                	ld	s0,0(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret

000000000000039c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 39c:	4885                	li	a7,1
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a4:	4889                	li	a7,2
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ac:	488d                	li	a7,3
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b4:	4891                	li	a7,4
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <read>:
.global read
read:
 li a7, SYS_read
 3bc:	4895                	li	a7,5
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <write>:
.global write
write:
 li a7, SYS_write
 3c4:	48c1                	li	a7,16
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <close>:
.global close
close:
 li a7, SYS_close
 3cc:	48d5                	li	a7,21
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d4:	4899                	li	a7,6
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3dc:	489d                	li	a7,7
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <open>:
.global open
open:
 li a7, SYS_open
 3e4:	48bd                	li	a7,15
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ec:	48c5                	li	a7,17
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3f4:	48c9                	li	a7,18
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3fc:	48a1                	li	a7,8
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <link>:
.global link
link:
 li a7, SYS_link
 404:	48cd                	li	a7,19
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 40c:	48d1                	li	a7,20
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 414:	48a5                	li	a7,9
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <dup>:
.global dup
dup:
 li a7, SYS_dup
 41c:	48a9                	li	a7,10
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 424:	48ad                	li	a7,11
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 42c:	48b1                	li	a7,12
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <pause>:
.global pause
pause:
 li a7, SYS_pause
 434:	48b5                	li	a7,13
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 43c:	48b9                	li	a7,14
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <endianswap>:
.global endianswap
endianswap:
 li a7, SYS_endianswap
 444:	48d9                	li	a7,22
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 44c:	1101                	addi	sp,sp,-32
 44e:	ec06                	sd	ra,24(sp)
 450:	e822                	sd	s0,16(sp)
 452:	1000                	addi	s0,sp,32
 454:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 458:	4605                	li	a2,1
 45a:	fef40593          	addi	a1,s0,-17
 45e:	f67ff0ef          	jal	3c4 <write>
}
 462:	60e2                	ld	ra,24(sp)
 464:	6442                	ld	s0,16(sp)
 466:	6105                	addi	sp,sp,32
 468:	8082                	ret

000000000000046a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 46a:	715d                	addi	sp,sp,-80
 46c:	e486                	sd	ra,72(sp)
 46e:	e0a2                	sd	s0,64(sp)
 470:	fc26                	sd	s1,56(sp)
 472:	0880                	addi	s0,sp,80
 474:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 476:	c299                	beqz	a3,47c <printint+0x12>
 478:	0805c963          	bltz	a1,50a <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 47c:	2581                	sext.w	a1,a1
  neg = 0;
 47e:	4881                	li	a7,0
 480:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 484:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 486:	2601                	sext.w	a2,a2
 488:	00000517          	auipc	a0,0x0
 48c:	58050513          	addi	a0,a0,1408 # a08 <digits>
 490:	883a                	mv	a6,a4
 492:	2705                	addiw	a4,a4,1
 494:	02c5f7bb          	remuw	a5,a1,a2
 498:	1782                	slli	a5,a5,0x20
 49a:	9381                	srli	a5,a5,0x20
 49c:	97aa                	add	a5,a5,a0
 49e:	0007c783          	lbu	a5,0(a5)
 4a2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4a6:	0005879b          	sext.w	a5,a1
 4aa:	02c5d5bb          	divuw	a1,a1,a2
 4ae:	0685                	addi	a3,a3,1
 4b0:	fec7f0e3          	bgeu	a5,a2,490 <printint+0x26>
  if(neg)
 4b4:	00088c63          	beqz	a7,4cc <printint+0x62>
    buf[i++] = '-';
 4b8:	fd070793          	addi	a5,a4,-48
 4bc:	00878733          	add	a4,a5,s0
 4c0:	02d00793          	li	a5,45
 4c4:	fef70423          	sb	a5,-24(a4)
 4c8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4cc:	02e05a63          	blez	a4,500 <printint+0x96>
 4d0:	f84a                	sd	s2,48(sp)
 4d2:	f44e                	sd	s3,40(sp)
 4d4:	fb840793          	addi	a5,s0,-72
 4d8:	00e78933          	add	s2,a5,a4
 4dc:	fff78993          	addi	s3,a5,-1
 4e0:	99ba                	add	s3,s3,a4
 4e2:	377d                	addiw	a4,a4,-1
 4e4:	1702                	slli	a4,a4,0x20
 4e6:	9301                	srli	a4,a4,0x20
 4e8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ec:	fff94583          	lbu	a1,-1(s2)
 4f0:	8526                	mv	a0,s1
 4f2:	f5bff0ef          	jal	44c <putc>
  while(--i >= 0)
 4f6:	197d                	addi	s2,s2,-1
 4f8:	ff391ae3          	bne	s2,s3,4ec <printint+0x82>
 4fc:	7942                	ld	s2,48(sp)
 4fe:	79a2                	ld	s3,40(sp)
}
 500:	60a6                	ld	ra,72(sp)
 502:	6406                	ld	s0,64(sp)
 504:	74e2                	ld	s1,56(sp)
 506:	6161                	addi	sp,sp,80
 508:	8082                	ret
    x = -xx;
 50a:	40b005bb          	negw	a1,a1
    neg = 1;
 50e:	4885                	li	a7,1
    x = -xx;
 510:	bf85                	j	480 <printint+0x16>

0000000000000512 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 512:	711d                	addi	sp,sp,-96
 514:	ec86                	sd	ra,88(sp)
 516:	e8a2                	sd	s0,80(sp)
 518:	e0ca                	sd	s2,64(sp)
 51a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51c:	0005c903          	lbu	s2,0(a1)
 520:	28090663          	beqz	s2,7ac <vprintf+0x29a>
 524:	e4a6                	sd	s1,72(sp)
 526:	fc4e                	sd	s3,56(sp)
 528:	f852                	sd	s4,48(sp)
 52a:	f456                	sd	s5,40(sp)
 52c:	f05a                	sd	s6,32(sp)
 52e:	ec5e                	sd	s7,24(sp)
 530:	e862                	sd	s8,16(sp)
 532:	e466                	sd	s9,8(sp)
 534:	8b2a                	mv	s6,a0
 536:	8a2e                	mv	s4,a1
 538:	8bb2                	mv	s7,a2
  state = 0;
 53a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 53c:	4481                	li	s1,0
 53e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 540:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 544:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 548:	06c00c93          	li	s9,108
 54c:	a005                	j	56c <vprintf+0x5a>
        putc(fd, c0);
 54e:	85ca                	mv	a1,s2
 550:	855a                	mv	a0,s6
 552:	efbff0ef          	jal	44c <putc>
 556:	a019                	j	55c <vprintf+0x4a>
    } else if(state == '%'){
 558:	03598263          	beq	s3,s5,57c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 55c:	2485                	addiw	s1,s1,1
 55e:	8726                	mv	a4,s1
 560:	009a07b3          	add	a5,s4,s1
 564:	0007c903          	lbu	s2,0(a5)
 568:	22090a63          	beqz	s2,79c <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 56c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 570:	fe0994e3          	bnez	s3,558 <vprintf+0x46>
      if(c0 == '%'){
 574:	fd579de3          	bne	a5,s5,54e <vprintf+0x3c>
        state = '%';
 578:	89be                	mv	s3,a5
 57a:	b7cd                	j	55c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 57c:	00ea06b3          	add	a3,s4,a4
 580:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 584:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 586:	c681                	beqz	a3,58e <vprintf+0x7c>
 588:	9752                	add	a4,a4,s4
 58a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 58e:	05878363          	beq	a5,s8,5d4 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 592:	05978d63          	beq	a5,s9,5ec <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 596:	07500713          	li	a4,117
 59a:	0ee78763          	beq	a5,a4,688 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 59e:	07800713          	li	a4,120
 5a2:	12e78963          	beq	a5,a4,6d4 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5a6:	07000713          	li	a4,112
 5aa:	14e78e63          	beq	a5,a4,706 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5ae:	06300713          	li	a4,99
 5b2:	18e78e63          	beq	a5,a4,74e <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5b6:	07300713          	li	a4,115
 5ba:	1ae78463          	beq	a5,a4,762 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5be:	02500713          	li	a4,37
 5c2:	04e79563          	bne	a5,a4,60c <vprintf+0xfa>
        putc(fd, '%');
 5c6:	02500593          	li	a1,37
 5ca:	855a                	mv	a0,s6
 5cc:	e81ff0ef          	jal	44c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	b769                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5d4:	008b8913          	addi	s2,s7,8
 5d8:	4685                	li	a3,1
 5da:	4629                	li	a2,10
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	855a                	mv	a0,s6
 5e2:	e89ff0ef          	jal	46a <printint>
 5e6:	8bca                	mv	s7,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bf8d                	j	55c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5ec:	06400793          	li	a5,100
 5f0:	02f68963          	beq	a3,a5,622 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5f4:	06c00793          	li	a5,108
 5f8:	04f68263          	beq	a3,a5,63c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5fc:	07500793          	li	a5,117
 600:	0af68063          	beq	a3,a5,6a0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 604:	07800793          	li	a5,120
 608:	0ef68263          	beq	a3,a5,6ec <vprintf+0x1da>
        putc(fd, '%');
 60c:	02500593          	li	a1,37
 610:	855a                	mv	a0,s6
 612:	e3bff0ef          	jal	44c <putc>
        putc(fd, c0);
 616:	85ca                	mv	a1,s2
 618:	855a                	mv	a0,s6
 61a:	e33ff0ef          	jal	44c <putc>
      state = 0;
 61e:	4981                	li	s3,0
 620:	bf35                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 622:	008b8913          	addi	s2,s7,8
 626:	4685                	li	a3,1
 628:	4629                	li	a2,10
 62a:	000bb583          	ld	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	e3bff0ef          	jal	46a <printint>
        i += 1;
 634:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
        i += 1;
 63a:	b70d                	j	55c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 63c:	06400793          	li	a5,100
 640:	02f60763          	beq	a2,a5,66e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 644:	07500793          	li	a5,117
 648:	06f60963          	beq	a2,a5,6ba <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 64c:	07800793          	li	a5,120
 650:	faf61ee3          	bne	a2,a5,60c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 654:	008b8913          	addi	s2,s7,8
 658:	4681                	li	a3,0
 65a:	4641                	li	a2,16
 65c:	000bb583          	ld	a1,0(s7)
 660:	855a                	mv	a0,s6
 662:	e09ff0ef          	jal	46a <printint>
        i += 2;
 666:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 668:	8bca                	mv	s7,s2
      state = 0;
 66a:	4981                	li	s3,0
        i += 2;
 66c:	bdc5                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 66e:	008b8913          	addi	s2,s7,8
 672:	4685                	li	a3,1
 674:	4629                	li	a2,10
 676:	000bb583          	ld	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	defff0ef          	jal	46a <printint>
        i += 2;
 680:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 682:	8bca                	mv	s7,s2
      state = 0;
 684:	4981                	li	s3,0
        i += 2;
 686:	bdd9                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 688:	008b8913          	addi	s2,s7,8
 68c:	4681                	li	a3,0
 68e:	4629                	li	a2,10
 690:	000be583          	lwu	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	dd5ff0ef          	jal	46a <printint>
 69a:	8bca                	mv	s7,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bd7d                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a0:	008b8913          	addi	s2,s7,8
 6a4:	4681                	li	a3,0
 6a6:	4629                	li	a2,10
 6a8:	000bb583          	ld	a1,0(s7)
 6ac:	855a                	mv	a0,s6
 6ae:	dbdff0ef          	jal	46a <printint>
        i += 1;
 6b2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
        i += 1;
 6b8:	b555                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ba:	008b8913          	addi	s2,s7,8
 6be:	4681                	li	a3,0
 6c0:	4629                	li	a2,10
 6c2:	000bb583          	ld	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	da3ff0ef          	jal	46a <printint>
        i += 2;
 6cc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
        i += 2;
 6d2:	b569                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4641                	li	a2,16
 6dc:	000be583          	lwu	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	d89ff0ef          	jal	46a <printint>
 6e6:	8bca                	mv	s7,s2
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bd8d                	j	55c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ec:	008b8913          	addi	s2,s7,8
 6f0:	4681                	li	a3,0
 6f2:	4641                	li	a2,16
 6f4:	000bb583          	ld	a1,0(s7)
 6f8:	855a                	mv	a0,s6
 6fa:	d71ff0ef          	jal	46a <printint>
        i += 1;
 6fe:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
        i += 1;
 704:	bda1                	j	55c <vprintf+0x4a>
 706:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 708:	008b8d13          	addi	s10,s7,8
 70c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 710:	03000593          	li	a1,48
 714:	855a                	mv	a0,s6
 716:	d37ff0ef          	jal	44c <putc>
  putc(fd, 'x');
 71a:	07800593          	li	a1,120
 71e:	855a                	mv	a0,s6
 720:	d2dff0ef          	jal	44c <putc>
 724:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 726:	00000b97          	auipc	s7,0x0
 72a:	2e2b8b93          	addi	s7,s7,738 # a08 <digits>
 72e:	03c9d793          	srli	a5,s3,0x3c
 732:	97de                	add	a5,a5,s7
 734:	0007c583          	lbu	a1,0(a5)
 738:	855a                	mv	a0,s6
 73a:	d13ff0ef          	jal	44c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 73e:	0992                	slli	s3,s3,0x4
 740:	397d                	addiw	s2,s2,-1
 742:	fe0916e3          	bnez	s2,72e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 746:	8bea                	mv	s7,s10
      state = 0;
 748:	4981                	li	s3,0
 74a:	6d02                	ld	s10,0(sp)
 74c:	bd01                	j	55c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 74e:	008b8913          	addi	s2,s7,8
 752:	000bc583          	lbu	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	cf5ff0ef          	jal	44c <putc>
 75c:	8bca                	mv	s7,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	bbf5                	j	55c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 762:	008b8993          	addi	s3,s7,8
 766:	000bb903          	ld	s2,0(s7)
 76a:	00090f63          	beqz	s2,788 <vprintf+0x276>
        for(; *s; s++)
 76e:	00094583          	lbu	a1,0(s2)
 772:	c195                	beqz	a1,796 <vprintf+0x284>
          putc(fd, *s);
 774:	855a                	mv	a0,s6
 776:	cd7ff0ef          	jal	44c <putc>
        for(; *s; s++)
 77a:	0905                	addi	s2,s2,1
 77c:	00094583          	lbu	a1,0(s2)
 780:	f9f5                	bnez	a1,774 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 782:	8bce                	mv	s7,s3
      state = 0;
 784:	4981                	li	s3,0
 786:	bbd9                	j	55c <vprintf+0x4a>
          s = "(null)";
 788:	00000917          	auipc	s2,0x0
 78c:	27890913          	addi	s2,s2,632 # a00 <malloc+0x16c>
        for(; *s; s++)
 790:	02800593          	li	a1,40
 794:	b7c5                	j	774 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 796:	8bce                	mv	s7,s3
      state = 0;
 798:	4981                	li	s3,0
 79a:	b3c9                	j	55c <vprintf+0x4a>
 79c:	64a6                	ld	s1,72(sp)
 79e:	79e2                	ld	s3,56(sp)
 7a0:	7a42                	ld	s4,48(sp)
 7a2:	7aa2                	ld	s5,40(sp)
 7a4:	7b02                	ld	s6,32(sp)
 7a6:	6be2                	ld	s7,24(sp)
 7a8:	6c42                	ld	s8,16(sp)
 7aa:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7ac:	60e6                	ld	ra,88(sp)
 7ae:	6446                	ld	s0,80(sp)
 7b0:	6906                	ld	s2,64(sp)
 7b2:	6125                	addi	sp,sp,96
 7b4:	8082                	ret

00000000000007b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b6:	715d                	addi	sp,sp,-80
 7b8:	ec06                	sd	ra,24(sp)
 7ba:	e822                	sd	s0,16(sp)
 7bc:	1000                	addi	s0,sp,32
 7be:	e010                	sd	a2,0(s0)
 7c0:	e414                	sd	a3,8(s0)
 7c2:	e818                	sd	a4,16(s0)
 7c4:	ec1c                	sd	a5,24(s0)
 7c6:	03043023          	sd	a6,32(s0)
 7ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d2:	8622                	mv	a2,s0
 7d4:	d3fff0ef          	jal	512 <vprintf>
}
 7d8:	60e2                	ld	ra,24(sp)
 7da:	6442                	ld	s0,16(sp)
 7dc:	6161                	addi	sp,sp,80
 7de:	8082                	ret

00000000000007e0 <printf>:

void
printf(const char *fmt, ...)
{
 7e0:	711d                	addi	sp,sp,-96
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	addi	s0,sp,32
 7e8:	e40c                	sd	a1,8(s0)
 7ea:	e810                	sd	a2,16(s0)
 7ec:	ec14                	sd	a3,24(s0)
 7ee:	f018                	sd	a4,32(s0)
 7f0:	f41c                	sd	a5,40(s0)
 7f2:	03043823          	sd	a6,48(s0)
 7f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7fa:	00840613          	addi	a2,s0,8
 7fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 802:	85aa                	mv	a1,a0
 804:	4505                	li	a0,1
 806:	d0dff0ef          	jal	512 <vprintf>
}
 80a:	60e2                	ld	ra,24(sp)
 80c:	6442                	ld	s0,16(sp)
 80e:	6125                	addi	sp,sp,96
 810:	8082                	ret

0000000000000812 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 812:	1141                	addi	sp,sp,-16
 814:	e422                	sd	s0,8(sp)
 816:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 818:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81c:	00000797          	auipc	a5,0x0
 820:	7e47b783          	ld	a5,2020(a5) # 1000 <freep>
 824:	a02d                	j	84e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 826:	4618                	lw	a4,8(a2)
 828:	9f2d                	addw	a4,a4,a1
 82a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 82e:	6398                	ld	a4,0(a5)
 830:	6310                	ld	a2,0(a4)
 832:	a83d                	j	870 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 834:	ff852703          	lw	a4,-8(a0)
 838:	9f31                	addw	a4,a4,a2
 83a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 83c:	ff053683          	ld	a3,-16(a0)
 840:	a091                	j	884 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 842:	6398                	ld	a4,0(a5)
 844:	00e7e463          	bltu	a5,a4,84c <free+0x3a>
 848:	00e6ea63          	bltu	a3,a4,85c <free+0x4a>
{
 84c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84e:	fed7fae3          	bgeu	a5,a3,842 <free+0x30>
 852:	6398                	ld	a4,0(a5)
 854:	00e6e463          	bltu	a3,a4,85c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	fee7eae3          	bltu	a5,a4,84c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 85c:	ff852583          	lw	a1,-8(a0)
 860:	6390                	ld	a2,0(a5)
 862:	02059813          	slli	a6,a1,0x20
 866:	01c85713          	srli	a4,a6,0x1c
 86a:	9736                	add	a4,a4,a3
 86c:	fae60de3          	beq	a2,a4,826 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 870:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 874:	4790                	lw	a2,8(a5)
 876:	02061593          	slli	a1,a2,0x20
 87a:	01c5d713          	srli	a4,a1,0x1c
 87e:	973e                	add	a4,a4,a5
 880:	fae68ae3          	beq	a3,a4,834 <free+0x22>
    p->s.ptr = bp->s.ptr;
 884:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 886:	00000717          	auipc	a4,0x0
 88a:	76f73d23          	sd	a5,1914(a4) # 1000 <freep>
}
 88e:	6422                	ld	s0,8(sp)
 890:	0141                	addi	sp,sp,16
 892:	8082                	ret

0000000000000894 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 894:	7139                	addi	sp,sp,-64
 896:	fc06                	sd	ra,56(sp)
 898:	f822                	sd	s0,48(sp)
 89a:	f426                	sd	s1,40(sp)
 89c:	ec4e                	sd	s3,24(sp)
 89e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a0:	02051493          	slli	s1,a0,0x20
 8a4:	9081                	srli	s1,s1,0x20
 8a6:	04bd                	addi	s1,s1,15
 8a8:	8091                	srli	s1,s1,0x4
 8aa:	0014899b          	addiw	s3,s1,1
 8ae:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8b0:	00000517          	auipc	a0,0x0
 8b4:	75053503          	ld	a0,1872(a0) # 1000 <freep>
 8b8:	c915                	beqz	a0,8ec <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8bc:	4798                	lw	a4,8(a5)
 8be:	08977a63          	bgeu	a4,s1,952 <malloc+0xbe>
 8c2:	f04a                	sd	s2,32(sp)
 8c4:	e852                	sd	s4,16(sp)
 8c6:	e456                	sd	s5,8(sp)
 8c8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ca:	8a4e                	mv	s4,s3
 8cc:	0009871b          	sext.w	a4,s3
 8d0:	6685                	lui	a3,0x1
 8d2:	00d77363          	bgeu	a4,a3,8d8 <malloc+0x44>
 8d6:	6a05                	lui	s4,0x1
 8d8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8dc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e0:	00000917          	auipc	s2,0x0
 8e4:	72090913          	addi	s2,s2,1824 # 1000 <freep>
  if(p == SBRK_ERROR)
 8e8:	5afd                	li	s5,-1
 8ea:	a081                	j	92a <malloc+0x96>
 8ec:	f04a                	sd	s2,32(sp)
 8ee:	e852                	sd	s4,16(sp)
 8f0:	e456                	sd	s5,8(sp)
 8f2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8f4:	00000797          	auipc	a5,0x0
 8f8:	71c78793          	addi	a5,a5,1820 # 1010 <base>
 8fc:	00000717          	auipc	a4,0x0
 900:	70f73223          	sd	a5,1796(a4) # 1000 <freep>
 904:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 906:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 90a:	b7c1                	j	8ca <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 90c:	6398                	ld	a4,0(a5)
 90e:	e118                	sd	a4,0(a0)
 910:	a8a9                	j	96a <malloc+0xd6>
  hp->s.size = nu;
 912:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 916:	0541                	addi	a0,a0,16
 918:	efbff0ef          	jal	812 <free>
  return freep;
 91c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 920:	c12d                	beqz	a0,982 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	02977263          	bgeu	a4,s1,94a <malloc+0xb6>
    if(p == freep)
 92a:	00093703          	ld	a4,0(s2)
 92e:	853e                	mv	a0,a5
 930:	fef719e3          	bne	a4,a5,922 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 934:	8552                	mv	a0,s4
 936:	a3bff0ef          	jal	370 <sbrk>
  if(p == SBRK_ERROR)
 93a:	fd551ce3          	bne	a0,s5,912 <malloc+0x7e>
        return 0;
 93e:	4501                	li	a0,0
 940:	7902                	ld	s2,32(sp)
 942:	6a42                	ld	s4,16(sp)
 944:	6aa2                	ld	s5,8(sp)
 946:	6b02                	ld	s6,0(sp)
 948:	a03d                	j	976 <malloc+0xe2>
 94a:	7902                	ld	s2,32(sp)
 94c:	6a42                	ld	s4,16(sp)
 94e:	6aa2                	ld	s5,8(sp)
 950:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 952:	fae48de3          	beq	s1,a4,90c <malloc+0x78>
        p->s.size -= nunits;
 956:	4137073b          	subw	a4,a4,s3
 95a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 95c:	02071693          	slli	a3,a4,0x20
 960:	01c6d713          	srli	a4,a3,0x1c
 964:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 966:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96a:	00000717          	auipc	a4,0x0
 96e:	68a73b23          	sd	a0,1686(a4) # 1000 <freep>
      return (void*)(p + 1);
 972:	01078513          	addi	a0,a5,16
  }
}
 976:	70e2                	ld	ra,56(sp)
 978:	7442                	ld	s0,48(sp)
 97a:	74a2                	ld	s1,40(sp)
 97c:	69e2                	ld	s3,24(sp)
 97e:	6121                	addi	sp,sp,64
 980:	8082                	ret
 982:	7902                	ld	s2,32(sp)
 984:	6a42                	ld	s4,16(sp)
 986:	6aa2                	ld	s5,8(sp)
 988:	6b02                	ld	s6,0(sp)
 98a:	b7f5                	j	976 <malloc+0xe2>
