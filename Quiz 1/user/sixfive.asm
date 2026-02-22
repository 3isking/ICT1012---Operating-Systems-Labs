
user/_sixfive:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7151                	addi	sp,sp,-240
   2:	f586                	sd	ra,232(sp)
   4:	f1a2                	sd	s0,224(sp)
   6:	eda6                	sd	s1,216(sp)
   8:	e9ca                	sd	s2,208(sp)
   a:	e5ce                	sd	s3,200(sp)
   c:	e1d2                	sd	s4,192(sp)
   e:	fd56                	sd	s5,184(sp)
  10:	f95a                	sd	s6,176(sp)
  12:	f55e                	sd	s7,168(sp)
  14:	f162                	sd	s8,160(sp)
  16:	ed66                	sd	s9,152(sp)
  18:	1980                	addi	s0,sp,240
    int fd;
    char c;
    char str[128];
    int charCount = 0;

    if(argc >= 2){
  1a:	4785                	li	a5,1
  1c:	10a7da63          	bge	a5,a0,130 <main+0x130>
  20:	00858a93          	addi	s5,a1,8
  24:	ffe50b9b          	addiw	s7,a0,-2
  28:	020b9793          	slli	a5,s7,0x20
  2c:	01d7db93          	srli	s7,a5,0x1d
  30:	05c1                	addi	a1,a1,16
  32:	9bae                	add	s7,s7,a1
    int charCount = 0;
  34:	4481                	li	s1,0
        for (int i = 1; i < argc; i++){
            fd = open(argv[i], 0);
            while (read(fd, &c, 1) > 0){
                if(strchr(" -\r\t\n./,", c) != 0){
  36:	00001997          	auipc	s3,0x1
  3a:	98a98993          	addi	s3,s3,-1654 # 9c0 <malloc+0xf8>
                            printf("%d\n", num);
                        }
                        
                        charCount = 0;
                    }
                } else if(c >= '0' && c <= '9'){  
  3e:	4b25                	li	s6,9
                    // If character is a number, add to buffer
                    if(charCount < sizeof(str) - 1){
  40:	07e00c13          	li	s8,126
                        if (validNum == charCount && validNum <= 3){
  44:	4c8d                	li	s9,3
  46:	a065                	j	ee <main+0xee>
                        for (int j = 0; j < charCount; j++){
  48:	0705                	addi	a4,a4,1
  4a:	00c70c63          	beq	a4,a2,62 <main+0x62>
                            if (str[j] == '5' || str[j] == '6'){
  4e:	00074783          	lbu	a5,0(a4)
  52:	fcb7879b          	addiw	a5,a5,-53
  56:	0ff7f793          	zext.b	a5,a5
  5a:	fef6e7e3          	bltu	a3,a5,48 <main+0x48>
                                validNum++;
  5e:	2585                	addiw	a1,a1,1
  60:	b7e5                	j	48 <main+0x48>
                        if (validNum == charCount && validNum <= 3){
  62:	02b48f63          	beq	s1,a1,a0 <main+0xa0>
                        charCount = 0;
  66:	84d2                	mv	s1,s4
            while (read(fd, &c, 1) > 0){
  68:	4605                	li	a2,1
  6a:	f9f40593          	addi	a1,s0,-97
  6e:	854a                	mv	a0,s2
  70:	380000ef          	jal	3f0 <read>
  74:	06a05863          	blez	a0,e4 <main+0xe4>
                if(strchr(" -\r\t\n./,", c) != 0){
  78:	f9f44583          	lbu	a1,-97(s0)
  7c:	854e                	mv	a0,s3
  7e:	16a000ef          	jal	1e8 <strchr>
  82:	cd15                	beqz	a0,be <main+0xbe>
                    if(charCount > 0){
  84:	fe9052e3          	blez	s1,68 <main+0x68>
                        str[charCount] = 0;
  88:	fa048793          	addi	a5,s1,-96
  8c:	97a2                	add	a5,a5,s0
  8e:	f6078c23          	sb	zero,-136(a5)
                        for (int j = 0; j < charCount; j++){
  92:	f1840713          	addi	a4,s0,-232
  96:	00e48633          	add	a2,s1,a4
                        int validNum = 0;
  9a:	85d2                	mv	a1,s4
                            if (str[j] == '5' || str[j] == '6'){
  9c:	4685                	li	a3,1
  9e:	bf45                	j	4e <main+0x4e>
                        charCount = 0;
  a0:	4481                	li	s1,0
                        if (validNum == charCount && validNum <= 3){
  a2:	fcbcc3e3          	blt	s9,a1,68 <main+0x68>
                            int num = atoi(str);
  a6:	f1840513          	addi	a0,s0,-232
  aa:	20c000ef          	jal	2b6 <atoi>
  ae:	85aa                	mv	a1,a0
                            printf("%d\n", num);
  b0:	00001517          	auipc	a0,0x1
  b4:	92050513          	addi	a0,a0,-1760 # 9d0 <malloc+0x108>
  b8:	75c000ef          	jal	814 <printf>
  bc:	b775                	j	68 <main+0x68>
                } else if(c >= '0' && c <= '9'){  
  be:	f9f44703          	lbu	a4,-97(s0)
  c2:	fd07079b          	addiw	a5,a4,-48
  c6:	0ff7f793          	zext.b	a5,a5
  ca:	f8fb6fe3          	bltu	s6,a5,68 <main+0x68>
                    if(charCount < sizeof(str) - 1){
  ce:	0004879b          	sext.w	a5,s1
  d2:	f8fc6be3          	bltu	s8,a5,68 <main+0x68>
                        str[charCount] = c;
  d6:	fa048793          	addi	a5,s1,-96
  da:	97a2                	add	a5,a5,s0
  dc:	f6e78c23          	sb	a4,-136(a5)
                        charCount++;
  e0:	2485                	addiw	s1,s1,1
  e2:	b759                	j	68 <main+0x68>
                    }
                }
            };

            // Print last number
            if(charCount > 0){
  e4:	00904d63          	bgtz	s1,fe <main+0xfe>
        for (int i = 1; i < argc; i++){
  e8:	0aa1                	addi	s5,s5,8
  ea:	057a8963          	beq	s5,s7,13c <main+0x13c>
            fd = open(argv[i], 0);
  ee:	4581                	li	a1,0
  f0:	000ab503          	ld	a0,0(s5)
  f4:	324000ef          	jal	418 <open>
  f8:	892a                	mv	s2,a0
                        int validNum = 0;
  fa:	4a01                	li	s4,0
            while (read(fd, &c, 1) > 0){
  fc:	b7b5                	j	68 <main+0x68>
                str[charCount] = 0;
  fe:	fa048793          	addi	a5,s1,-96
 102:	97a2                	add	a5,a5,s0
 104:	f6078c23          	sb	zero,-136(a5)
                int num = atoi(str);
 108:	f1840513          	addi	a0,s0,-232
 10c:	1aa000ef          	jal	2b6 <atoi>
 110:	85aa                	mv	a1,a0
                if(num % 5 == 0 || num % 6 == 0){
 112:	4795                	li	a5,5
 114:	02f567bb          	remw	a5,a0,a5
 118:	c789                	beqz	a5,122 <main+0x122>
 11a:	4799                	li	a5,6
 11c:	02f567bb          	remw	a5,a0,a5
 120:	f7e1                	bnez	a5,e8 <main+0xe8>
                    printf("%d\n", num);
 122:	00001517          	auipc	a0,0x1
 126:	8ae50513          	addi	a0,a0,-1874 # 9d0 <malloc+0x108>
 12a:	6ea000ef          	jal	814 <printf>
 12e:	bf6d                	j	e8 <main+0xe8>
            }
        
        }
        
    } else {
        printf("Usage: sixfive [filename]\n");
 130:	00001517          	auipc	a0,0x1
 134:	8a850513          	addi	a0,a0,-1880 # 9d8 <malloc+0x110>
 138:	6dc000ef          	jal	814 <printf>
    }
    exit(0);
 13c:	4501                	li	a0,0
 13e:	29a000ef          	jal	3d8 <exit>

0000000000000142 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 142:	1141                	addi	sp,sp,-16
 144:	e406                	sd	ra,8(sp)
 146:	e022                	sd	s0,0(sp)
 148:	0800                	addi	s0,sp,16
  extern int main();
  main();
 14a:	eb7ff0ef          	jal	0 <main>
  exit(0);
 14e:	4501                	li	a0,0
 150:	288000ef          	jal	3d8 <exit>

0000000000000154 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 154:	1141                	addi	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 15a:	87aa                	mv	a5,a0
 15c:	0585                	addi	a1,a1,1
 15e:	0785                	addi	a5,a5,1
 160:	fff5c703          	lbu	a4,-1(a1)
 164:	fee78fa3          	sb	a4,-1(a5)
 168:	fb75                	bnez	a4,15c <strcpy+0x8>
    ;
  return os;
}
 16a:	6422                	ld	s0,8(sp)
 16c:	0141                	addi	sp,sp,16
 16e:	8082                	ret

0000000000000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	1141                	addi	sp,sp,-16
 172:	e422                	sd	s0,8(sp)
 174:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 176:	00054783          	lbu	a5,0(a0)
 17a:	cb91                	beqz	a5,18e <strcmp+0x1e>
 17c:	0005c703          	lbu	a4,0(a1)
 180:	00f71763          	bne	a4,a5,18e <strcmp+0x1e>
    p++, q++;
 184:	0505                	addi	a0,a0,1
 186:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 188:	00054783          	lbu	a5,0(a0)
 18c:	fbe5                	bnez	a5,17c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 18e:	0005c503          	lbu	a0,0(a1)
}
 192:	40a7853b          	subw	a0,a5,a0
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <strlen>:

uint
strlen(const char *s)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	cf91                	beqz	a5,1c2 <strlen+0x26>
 1a8:	0505                	addi	a0,a0,1
 1aa:	87aa                	mv	a5,a0
 1ac:	86be                	mv	a3,a5
 1ae:	0785                	addi	a5,a5,1
 1b0:	fff7c703          	lbu	a4,-1(a5)
 1b4:	ff65                	bnez	a4,1ac <strlen+0x10>
 1b6:	40a6853b          	subw	a0,a3,a0
 1ba:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1bc:	6422                	ld	s0,8(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret
  for(n = 0; s[n]; n++)
 1c2:	4501                	li	a0,0
 1c4:	bfe5                	j	1bc <strlen+0x20>

00000000000001c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1cc:	ca19                	beqz	a2,1e2 <memset+0x1c>
 1ce:	87aa                	mv	a5,a0
 1d0:	1602                	slli	a2,a2,0x20
 1d2:	9201                	srli	a2,a2,0x20
 1d4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1d8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1dc:	0785                	addi	a5,a5,1
 1de:	fee79de3          	bne	a5,a4,1d8 <memset+0x12>
  }
  return dst;
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret

00000000000001e8 <strchr>:

char*
strchr(const char *s, char c)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ee:	00054783          	lbu	a5,0(a0)
 1f2:	cb99                	beqz	a5,208 <strchr+0x20>
    if(*s == c)
 1f4:	00f58763          	beq	a1,a5,202 <strchr+0x1a>
  for(; *s; s++)
 1f8:	0505                	addi	a0,a0,1
 1fa:	00054783          	lbu	a5,0(a0)
 1fe:	fbfd                	bnez	a5,1f4 <strchr+0xc>
      return (char*)s;
  return 0;
 200:	4501                	li	a0,0
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  return 0;
 208:	4501                	li	a0,0
 20a:	bfe5                	j	202 <strchr+0x1a>

000000000000020c <gets>:

char*
gets(char *buf, int max)
{
 20c:	711d                	addi	sp,sp,-96
 20e:	ec86                	sd	ra,88(sp)
 210:	e8a2                	sd	s0,80(sp)
 212:	e4a6                	sd	s1,72(sp)
 214:	e0ca                	sd	s2,64(sp)
 216:	fc4e                	sd	s3,56(sp)
 218:	f852                	sd	s4,48(sp)
 21a:	f456                	sd	s5,40(sp)
 21c:	f05a                	sd	s6,32(sp)
 21e:	ec5e                	sd	s7,24(sp)
 220:	1080                	addi	s0,sp,96
 222:	8baa                	mv	s7,a0
 224:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	892a                	mv	s2,a0
 228:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 22a:	4aa9                	li	s5,10
 22c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 22e:	89a6                	mv	s3,s1
 230:	2485                	addiw	s1,s1,1
 232:	0344d663          	bge	s1,s4,25e <gets+0x52>
    cc = read(0, &c, 1);
 236:	4605                	li	a2,1
 238:	faf40593          	addi	a1,s0,-81
 23c:	4501                	li	a0,0
 23e:	1b2000ef          	jal	3f0 <read>
    if(cc < 1)
 242:	00a05e63          	blez	a0,25e <gets+0x52>
    buf[i++] = c;
 246:	faf44783          	lbu	a5,-81(s0)
 24a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 24e:	01578763          	beq	a5,s5,25c <gets+0x50>
 252:	0905                	addi	s2,s2,1
 254:	fd679de3          	bne	a5,s6,22e <gets+0x22>
    buf[i++] = c;
 258:	89a6                	mv	s3,s1
 25a:	a011                	j	25e <gets+0x52>
 25c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 25e:	99de                	add	s3,s3,s7
 260:	00098023          	sb	zero,0(s3)
  return buf;
}
 264:	855e                	mv	a0,s7
 266:	60e6                	ld	ra,88(sp)
 268:	6446                	ld	s0,80(sp)
 26a:	64a6                	ld	s1,72(sp)
 26c:	6906                	ld	s2,64(sp)
 26e:	79e2                	ld	s3,56(sp)
 270:	7a42                	ld	s4,48(sp)
 272:	7aa2                	ld	s5,40(sp)
 274:	7b02                	ld	s6,32(sp)
 276:	6be2                	ld	s7,24(sp)
 278:	6125                	addi	sp,sp,96
 27a:	8082                	ret

000000000000027c <stat>:

int
stat(const char *n, struct stat *st)
{
 27c:	1101                	addi	sp,sp,-32
 27e:	ec06                	sd	ra,24(sp)
 280:	e822                	sd	s0,16(sp)
 282:	e04a                	sd	s2,0(sp)
 284:	1000                	addi	s0,sp,32
 286:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 288:	4581                	li	a1,0
 28a:	18e000ef          	jal	418 <open>
  if(fd < 0)
 28e:	02054263          	bltz	a0,2b2 <stat+0x36>
 292:	e426                	sd	s1,8(sp)
 294:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 296:	85ca                	mv	a1,s2
 298:	198000ef          	jal	430 <fstat>
 29c:	892a                	mv	s2,a0
  close(fd);
 29e:	8526                	mv	a0,s1
 2a0:	160000ef          	jal	400 <close>
  return r;
 2a4:	64a2                	ld	s1,8(sp)
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	6902                	ld	s2,0(sp)
 2ae:	6105                	addi	sp,sp,32
 2b0:	8082                	ret
    return -1;
 2b2:	597d                	li	s2,-1
 2b4:	bfcd                	j	2a6 <stat+0x2a>

00000000000002b6 <atoi>:

int
atoi(const char *s)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bc:	00054683          	lbu	a3,0(a0)
 2c0:	fd06879b          	addiw	a5,a3,-48
 2c4:	0ff7f793          	zext.b	a5,a5
 2c8:	4625                	li	a2,9
 2ca:	02f66863          	bltu	a2,a5,2fa <atoi+0x44>
 2ce:	872a                	mv	a4,a0
  n = 0;
 2d0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d2:	0705                	addi	a4,a4,1
 2d4:	0025179b          	slliw	a5,a0,0x2
 2d8:	9fa9                	addw	a5,a5,a0
 2da:	0017979b          	slliw	a5,a5,0x1
 2de:	9fb5                	addw	a5,a5,a3
 2e0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e4:	00074683          	lbu	a3,0(a4)
 2e8:	fd06879b          	addiw	a5,a3,-48
 2ec:	0ff7f793          	zext.b	a5,a5
 2f0:	fef671e3          	bgeu	a2,a5,2d2 <atoi+0x1c>
  return n;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret
  n = 0;
 2fa:	4501                	li	a0,0
 2fc:	bfe5                	j	2f4 <atoi+0x3e>

00000000000002fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 304:	02b57463          	bgeu	a0,a1,32c <memmove+0x2e>
    while(n-- > 0)
 308:	00c05f63          	blez	a2,326 <memmove+0x28>
 30c:	1602                	slli	a2,a2,0x20
 30e:	9201                	srli	a2,a2,0x20
 310:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 314:	872a                	mv	a4,a0
      *dst++ = *src++;
 316:	0585                	addi	a1,a1,1
 318:	0705                	addi	a4,a4,1
 31a:	fff5c683          	lbu	a3,-1(a1)
 31e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 322:	fef71ae3          	bne	a4,a5,316 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret
    dst += n;
 32c:	00c50733          	add	a4,a0,a2
    src += n;
 330:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 332:	fec05ae3          	blez	a2,326 <memmove+0x28>
 336:	fff6079b          	addiw	a5,a2,-1
 33a:	1782                	slli	a5,a5,0x20
 33c:	9381                	srli	a5,a5,0x20
 33e:	fff7c793          	not	a5,a5
 342:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 344:	15fd                	addi	a1,a1,-1
 346:	177d                	addi	a4,a4,-1
 348:	0005c683          	lbu	a3,0(a1)
 34c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 350:	fee79ae3          	bne	a5,a4,344 <memmove+0x46>
 354:	bfc9                	j	326 <memmove+0x28>

0000000000000356 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35c:	ca05                	beqz	a2,38c <memcmp+0x36>
 35e:	fff6069b          	addiw	a3,a2,-1
 362:	1682                	slli	a3,a3,0x20
 364:	9281                	srli	a3,a3,0x20
 366:	0685                	addi	a3,a3,1
 368:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 36a:	00054783          	lbu	a5,0(a0)
 36e:	0005c703          	lbu	a4,0(a1)
 372:	00e79863          	bne	a5,a4,382 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 376:	0505                	addi	a0,a0,1
    p2++;
 378:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 37a:	fed518e3          	bne	a0,a3,36a <memcmp+0x14>
  }
  return 0;
 37e:	4501                	li	a0,0
 380:	a019                	j	386 <memcmp+0x30>
      return *p1 - *p2;
 382:	40e7853b          	subw	a0,a5,a4
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret
  return 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <memcmp+0x30>

0000000000000390 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 398:	f67ff0ef          	jal	2fe <memmove>
}
 39c:	60a2                	ld	ra,8(sp)
 39e:	6402                	ld	s0,0(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret

00000000000003a4 <sbrk>:

char *
sbrk(int n) {
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e406                	sd	ra,8(sp)
 3a8:	e022                	sd	s0,0(sp)
 3aa:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3ac:	4585                	li	a1,1
 3ae:	0b2000ef          	jal	460 <sys_sbrk>
}
 3b2:	60a2                	ld	ra,8(sp)
 3b4:	6402                	ld	s0,0(sp)
 3b6:	0141                	addi	sp,sp,16
 3b8:	8082                	ret

00000000000003ba <sbrklazy>:

char *
sbrklazy(int n) {
 3ba:	1141                	addi	sp,sp,-16
 3bc:	e406                	sd	ra,8(sp)
 3be:	e022                	sd	s0,0(sp)
 3c0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3c2:	4589                	li	a1,2
 3c4:	09c000ef          	jal	460 <sys_sbrk>
}
 3c8:	60a2                	ld	ra,8(sp)
 3ca:	6402                	ld	s0,0(sp)
 3cc:	0141                	addi	sp,sp,16
 3ce:	8082                	ret

00000000000003d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d0:	4885                	li	a7,1
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d8:	4889                	li	a7,2
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e0:	488d                	li	a7,3
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e8:	4891                	li	a7,4
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <read>:
.global read
read:
 li a7, SYS_read
 3f0:	4895                	li	a7,5
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <write>:
.global write
write:
 li a7, SYS_write
 3f8:	48c1                	li	a7,16
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <close>:
.global close
close:
 li a7, SYS_close
 400:	48d5                	li	a7,21
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <kill>:
.global kill
kill:
 li a7, SYS_kill
 408:	4899                	li	a7,6
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <exec>:
.global exec
exec:
 li a7, SYS_exec
 410:	489d                	li	a7,7
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <open>:
.global open
open:
 li a7, SYS_open
 418:	48bd                	li	a7,15
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 420:	48c5                	li	a7,17
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 428:	48c9                	li	a7,18
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 430:	48a1                	li	a7,8
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <link>:
.global link
link:
 li a7, SYS_link
 438:	48cd                	li	a7,19
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 440:	48d1                	li	a7,20
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 448:	48a5                	li	a7,9
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <dup>:
.global dup
dup:
 li a7, SYS_dup
 450:	48a9                	li	a7,10
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 458:	48ad                	li	a7,11
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 460:	48b1                	li	a7,12
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <pause>:
.global pause
pause:
 li a7, SYS_pause
 468:	48b5                	li	a7,13
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 470:	48b9                	li	a7,14
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <endianswap>:
.global endianswap
endianswap:
 li a7, SYS_endianswap
 478:	48d9                	li	a7,22
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 480:	1101                	addi	sp,sp,-32
 482:	ec06                	sd	ra,24(sp)
 484:	e822                	sd	s0,16(sp)
 486:	1000                	addi	s0,sp,32
 488:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 48c:	4605                	li	a2,1
 48e:	fef40593          	addi	a1,s0,-17
 492:	f67ff0ef          	jal	3f8 <write>
}
 496:	60e2                	ld	ra,24(sp)
 498:	6442                	ld	s0,16(sp)
 49a:	6105                	addi	sp,sp,32
 49c:	8082                	ret

000000000000049e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 49e:	715d                	addi	sp,sp,-80
 4a0:	e486                	sd	ra,72(sp)
 4a2:	e0a2                	sd	s0,64(sp)
 4a4:	fc26                	sd	s1,56(sp)
 4a6:	0880                	addi	s0,sp,80
 4a8:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4aa:	c299                	beqz	a3,4b0 <printint+0x12>
 4ac:	0805c963          	bltz	a1,53e <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b0:	2581                	sext.w	a1,a1
  neg = 0;
 4b2:	4881                	li	a7,0
 4b4:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 4b8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ba:	2601                	sext.w	a2,a2
 4bc:	00000517          	auipc	a0,0x0
 4c0:	54450513          	addi	a0,a0,1348 # a00 <digits>
 4c4:	883a                	mv	a6,a4
 4c6:	2705                	addiw	a4,a4,1
 4c8:	02c5f7bb          	remuw	a5,a1,a2
 4cc:	1782                	slli	a5,a5,0x20
 4ce:	9381                	srli	a5,a5,0x20
 4d0:	97aa                	add	a5,a5,a0
 4d2:	0007c783          	lbu	a5,0(a5)
 4d6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4da:	0005879b          	sext.w	a5,a1
 4de:	02c5d5bb          	divuw	a1,a1,a2
 4e2:	0685                	addi	a3,a3,1
 4e4:	fec7f0e3          	bgeu	a5,a2,4c4 <printint+0x26>
  if(neg)
 4e8:	00088c63          	beqz	a7,500 <printint+0x62>
    buf[i++] = '-';
 4ec:	fd070793          	addi	a5,a4,-48
 4f0:	00878733          	add	a4,a5,s0
 4f4:	02d00793          	li	a5,45
 4f8:	fef70423          	sb	a5,-24(a4)
 4fc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 500:	02e05a63          	blez	a4,534 <printint+0x96>
 504:	f84a                	sd	s2,48(sp)
 506:	f44e                	sd	s3,40(sp)
 508:	fb840793          	addi	a5,s0,-72
 50c:	00e78933          	add	s2,a5,a4
 510:	fff78993          	addi	s3,a5,-1
 514:	99ba                	add	s3,s3,a4
 516:	377d                	addiw	a4,a4,-1
 518:	1702                	slli	a4,a4,0x20
 51a:	9301                	srli	a4,a4,0x20
 51c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 520:	fff94583          	lbu	a1,-1(s2)
 524:	8526                	mv	a0,s1
 526:	f5bff0ef          	jal	480 <putc>
  while(--i >= 0)
 52a:	197d                	addi	s2,s2,-1
 52c:	ff391ae3          	bne	s2,s3,520 <printint+0x82>
 530:	7942                	ld	s2,48(sp)
 532:	79a2                	ld	s3,40(sp)
}
 534:	60a6                	ld	ra,72(sp)
 536:	6406                	ld	s0,64(sp)
 538:	74e2                	ld	s1,56(sp)
 53a:	6161                	addi	sp,sp,80
 53c:	8082                	ret
    x = -xx;
 53e:	40b005bb          	negw	a1,a1
    neg = 1;
 542:	4885                	li	a7,1
    x = -xx;
 544:	bf85                	j	4b4 <printint+0x16>

0000000000000546 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 546:	711d                	addi	sp,sp,-96
 548:	ec86                	sd	ra,88(sp)
 54a:	e8a2                	sd	s0,80(sp)
 54c:	e0ca                	sd	s2,64(sp)
 54e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 550:	0005c903          	lbu	s2,0(a1)
 554:	28090663          	beqz	s2,7e0 <vprintf+0x29a>
 558:	e4a6                	sd	s1,72(sp)
 55a:	fc4e                	sd	s3,56(sp)
 55c:	f852                	sd	s4,48(sp)
 55e:	f456                	sd	s5,40(sp)
 560:	f05a                	sd	s6,32(sp)
 562:	ec5e                	sd	s7,24(sp)
 564:	e862                	sd	s8,16(sp)
 566:	e466                	sd	s9,8(sp)
 568:	8b2a                	mv	s6,a0
 56a:	8a2e                	mv	s4,a1
 56c:	8bb2                	mv	s7,a2
  state = 0;
 56e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 570:	4481                	li	s1,0
 572:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 574:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 578:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 57c:	06c00c93          	li	s9,108
 580:	a005                	j	5a0 <vprintf+0x5a>
        putc(fd, c0);
 582:	85ca                	mv	a1,s2
 584:	855a                	mv	a0,s6
 586:	efbff0ef          	jal	480 <putc>
 58a:	a019                	j	590 <vprintf+0x4a>
    } else if(state == '%'){
 58c:	03598263          	beq	s3,s5,5b0 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 590:	2485                	addiw	s1,s1,1
 592:	8726                	mv	a4,s1
 594:	009a07b3          	add	a5,s4,s1
 598:	0007c903          	lbu	s2,0(a5)
 59c:	22090a63          	beqz	s2,7d0 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5a0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5a4:	fe0994e3          	bnez	s3,58c <vprintf+0x46>
      if(c0 == '%'){
 5a8:	fd579de3          	bne	a5,s5,582 <vprintf+0x3c>
        state = '%';
 5ac:	89be                	mv	s3,a5
 5ae:	b7cd                	j	590 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b0:	00ea06b3          	add	a3,s4,a4
 5b4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5b8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5ba:	c681                	beqz	a3,5c2 <vprintf+0x7c>
 5bc:	9752                	add	a4,a4,s4
 5be:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5c2:	05878363          	beq	a5,s8,608 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5c6:	05978d63          	beq	a5,s9,620 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ca:	07500713          	li	a4,117
 5ce:	0ee78763          	beq	a5,a4,6bc <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5d2:	07800713          	li	a4,120
 5d6:	12e78963          	beq	a5,a4,708 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5da:	07000713          	li	a4,112
 5de:	14e78e63          	beq	a5,a4,73a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5e2:	06300713          	li	a4,99
 5e6:	18e78e63          	beq	a5,a4,782 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ea:	07300713          	li	a4,115
 5ee:	1ae78463          	beq	a5,a4,796 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f2:	02500713          	li	a4,37
 5f6:	04e79563          	bne	a5,a4,640 <vprintf+0xfa>
        putc(fd, '%');
 5fa:	02500593          	li	a1,37
 5fe:	855a                	mv	a0,s6
 600:	e81ff0ef          	jal	480 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 604:	4981                	li	s3,0
 606:	b769                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 608:	008b8913          	addi	s2,s7,8
 60c:	4685                	li	a3,1
 60e:	4629                	li	a2,10
 610:	000ba583          	lw	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	e89ff0ef          	jal	49e <printint>
 61a:	8bca                	mv	s7,s2
      state = 0;
 61c:	4981                	li	s3,0
 61e:	bf8d                	j	590 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 620:	06400793          	li	a5,100
 624:	02f68963          	beq	a3,a5,656 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 628:	06c00793          	li	a5,108
 62c:	04f68263          	beq	a3,a5,670 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 630:	07500793          	li	a5,117
 634:	0af68063          	beq	a3,a5,6d4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 638:	07800793          	li	a5,120
 63c:	0ef68263          	beq	a3,a5,720 <vprintf+0x1da>
        putc(fd, '%');
 640:	02500593          	li	a1,37
 644:	855a                	mv	a0,s6
 646:	e3bff0ef          	jal	480 <putc>
        putc(fd, c0);
 64a:	85ca                	mv	a1,s2
 64c:	855a                	mv	a0,s6
 64e:	e33ff0ef          	jal	480 <putc>
      state = 0;
 652:	4981                	li	s3,0
 654:	bf35                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 656:	008b8913          	addi	s2,s7,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000bb583          	ld	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e3bff0ef          	jal	49e <printint>
        i += 1;
 668:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 66a:	8bca                	mv	s7,s2
      state = 0;
 66c:	4981                	li	s3,0
        i += 1;
 66e:	b70d                	j	590 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 670:	06400793          	li	a5,100
 674:	02f60763          	beq	a2,a5,6a2 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 678:	07500793          	li	a5,117
 67c:	06f60963          	beq	a2,a5,6ee <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 680:	07800793          	li	a5,120
 684:	faf61ee3          	bne	a2,a5,640 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 688:	008b8913          	addi	s2,s7,8
 68c:	4681                	li	a3,0
 68e:	4641                	li	a2,16
 690:	000bb583          	ld	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	e09ff0ef          	jal	49e <printint>
        i += 2;
 69a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	bdc5                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a2:	008b8913          	addi	s2,s7,8
 6a6:	4685                	li	a3,1
 6a8:	4629                	li	a2,10
 6aa:	000bb583          	ld	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	defff0ef          	jal	49e <printint>
        i += 2;
 6b4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b6:	8bca                	mv	s7,s2
      state = 0;
 6b8:	4981                	li	s3,0
        i += 2;
 6ba:	bdd9                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6bc:	008b8913          	addi	s2,s7,8
 6c0:	4681                	li	a3,0
 6c2:	4629                	li	a2,10
 6c4:	000be583          	lwu	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	dd5ff0ef          	jal	49e <printint>
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bd7d                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000bb583          	ld	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	dbdff0ef          	jal	49e <printint>
        i += 1;
 6e6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	8bca                	mv	s7,s2
      state = 0;
 6ea:	4981                	li	s3,0
        i += 1;
 6ec:	b555                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ee:	008b8913          	addi	s2,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4629                	li	a2,10
 6f6:	000bb583          	ld	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	da3ff0ef          	jal	49e <printint>
        i += 2;
 700:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 702:	8bca                	mv	s7,s2
      state = 0;
 704:	4981                	li	s3,0
        i += 2;
 706:	b569                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 708:	008b8913          	addi	s2,s7,8
 70c:	4681                	li	a3,0
 70e:	4641                	li	a2,16
 710:	000be583          	lwu	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	d89ff0ef          	jal	49e <printint>
 71a:	8bca                	mv	s7,s2
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bd8d                	j	590 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 720:	008b8913          	addi	s2,s7,8
 724:	4681                	li	a3,0
 726:	4641                	li	a2,16
 728:	000bb583          	ld	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	d71ff0ef          	jal	49e <printint>
        i += 1;
 732:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 734:	8bca                	mv	s7,s2
      state = 0;
 736:	4981                	li	s3,0
        i += 1;
 738:	bda1                	j	590 <vprintf+0x4a>
 73a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 73c:	008b8d13          	addi	s10,s7,8
 740:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 744:	03000593          	li	a1,48
 748:	855a                	mv	a0,s6
 74a:	d37ff0ef          	jal	480 <putc>
  putc(fd, 'x');
 74e:	07800593          	li	a1,120
 752:	855a                	mv	a0,s6
 754:	d2dff0ef          	jal	480 <putc>
 758:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75a:	00000b97          	auipc	s7,0x0
 75e:	2a6b8b93          	addi	s7,s7,678 # a00 <digits>
 762:	03c9d793          	srli	a5,s3,0x3c
 766:	97de                	add	a5,a5,s7
 768:	0007c583          	lbu	a1,0(a5)
 76c:	855a                	mv	a0,s6
 76e:	d13ff0ef          	jal	480 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 772:	0992                	slli	s3,s3,0x4
 774:	397d                	addiw	s2,s2,-1
 776:	fe0916e3          	bnez	s2,762 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 77a:	8bea                	mv	s7,s10
      state = 0;
 77c:	4981                	li	s3,0
 77e:	6d02                	ld	s10,0(sp)
 780:	bd01                	j	590 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 782:	008b8913          	addi	s2,s7,8
 786:	000bc583          	lbu	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	cf5ff0ef          	jal	480 <putc>
 790:	8bca                	mv	s7,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	bbf5                	j	590 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 796:	008b8993          	addi	s3,s7,8
 79a:	000bb903          	ld	s2,0(s7)
 79e:	00090f63          	beqz	s2,7bc <vprintf+0x276>
        for(; *s; s++)
 7a2:	00094583          	lbu	a1,0(s2)
 7a6:	c195                	beqz	a1,7ca <vprintf+0x284>
          putc(fd, *s);
 7a8:	855a                	mv	a0,s6
 7aa:	cd7ff0ef          	jal	480 <putc>
        for(; *s; s++)
 7ae:	0905                	addi	s2,s2,1
 7b0:	00094583          	lbu	a1,0(s2)
 7b4:	f9f5                	bnez	a1,7a8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7b6:	8bce                	mv	s7,s3
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bbd9                	j	590 <vprintf+0x4a>
          s = "(null)";
 7bc:	00000917          	auipc	s2,0x0
 7c0:	23c90913          	addi	s2,s2,572 # 9f8 <malloc+0x130>
        for(; *s; s++)
 7c4:	02800593          	li	a1,40
 7c8:	b7c5                	j	7a8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7ca:	8bce                	mv	s7,s3
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b3c9                	j	590 <vprintf+0x4a>
 7d0:	64a6                	ld	s1,72(sp)
 7d2:	79e2                	ld	s3,56(sp)
 7d4:	7a42                	ld	s4,48(sp)
 7d6:	7aa2                	ld	s5,40(sp)
 7d8:	7b02                	ld	s6,32(sp)
 7da:	6be2                	ld	s7,24(sp)
 7dc:	6c42                	ld	s8,16(sp)
 7de:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7e0:	60e6                	ld	ra,88(sp)
 7e2:	6446                	ld	s0,80(sp)
 7e4:	6906                	ld	s2,64(sp)
 7e6:	6125                	addi	sp,sp,96
 7e8:	8082                	ret

00000000000007ea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ea:	715d                	addi	sp,sp,-80
 7ec:	ec06                	sd	ra,24(sp)
 7ee:	e822                	sd	s0,16(sp)
 7f0:	1000                	addi	s0,sp,32
 7f2:	e010                	sd	a2,0(s0)
 7f4:	e414                	sd	a3,8(s0)
 7f6:	e818                	sd	a4,16(s0)
 7f8:	ec1c                	sd	a5,24(s0)
 7fa:	03043023          	sd	a6,32(s0)
 7fe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 802:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 806:	8622                	mv	a2,s0
 808:	d3fff0ef          	jal	546 <vprintf>
}
 80c:	60e2                	ld	ra,24(sp)
 80e:	6442                	ld	s0,16(sp)
 810:	6161                	addi	sp,sp,80
 812:	8082                	ret

0000000000000814 <printf>:

void
printf(const char *fmt, ...)
{
 814:	711d                	addi	sp,sp,-96
 816:	ec06                	sd	ra,24(sp)
 818:	e822                	sd	s0,16(sp)
 81a:	1000                	addi	s0,sp,32
 81c:	e40c                	sd	a1,8(s0)
 81e:	e810                	sd	a2,16(s0)
 820:	ec14                	sd	a3,24(s0)
 822:	f018                	sd	a4,32(s0)
 824:	f41c                	sd	a5,40(s0)
 826:	03043823          	sd	a6,48(s0)
 82a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 82e:	00840613          	addi	a2,s0,8
 832:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 836:	85aa                	mv	a1,a0
 838:	4505                	li	a0,1
 83a:	d0dff0ef          	jal	546 <vprintf>
}
 83e:	60e2                	ld	ra,24(sp)
 840:	6442                	ld	s0,16(sp)
 842:	6125                	addi	sp,sp,96
 844:	8082                	ret

0000000000000846 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 846:	1141                	addi	sp,sp,-16
 848:	e422                	sd	s0,8(sp)
 84a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 850:	00000797          	auipc	a5,0x0
 854:	7b07b783          	ld	a5,1968(a5) # 1000 <freep>
 858:	a02d                	j	882 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 85a:	4618                	lw	a4,8(a2)
 85c:	9f2d                	addw	a4,a4,a1
 85e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 862:	6398                	ld	a4,0(a5)
 864:	6310                	ld	a2,0(a4)
 866:	a83d                	j	8a4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 868:	ff852703          	lw	a4,-8(a0)
 86c:	9f31                	addw	a4,a4,a2
 86e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 870:	ff053683          	ld	a3,-16(a0)
 874:	a091                	j	8b8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 876:	6398                	ld	a4,0(a5)
 878:	00e7e463          	bltu	a5,a4,880 <free+0x3a>
 87c:	00e6ea63          	bltu	a3,a4,890 <free+0x4a>
{
 880:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 882:	fed7fae3          	bgeu	a5,a3,876 <free+0x30>
 886:	6398                	ld	a4,0(a5)
 888:	00e6e463          	bltu	a3,a4,890 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88c:	fee7eae3          	bltu	a5,a4,880 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 890:	ff852583          	lw	a1,-8(a0)
 894:	6390                	ld	a2,0(a5)
 896:	02059813          	slli	a6,a1,0x20
 89a:	01c85713          	srli	a4,a6,0x1c
 89e:	9736                	add	a4,a4,a3
 8a0:	fae60de3          	beq	a2,a4,85a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8a4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8a8:	4790                	lw	a2,8(a5)
 8aa:	02061593          	slli	a1,a2,0x20
 8ae:	01c5d713          	srli	a4,a1,0x1c
 8b2:	973e                	add	a4,a4,a5
 8b4:	fae68ae3          	beq	a3,a4,868 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8b8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ba:	00000717          	auipc	a4,0x0
 8be:	74f73323          	sd	a5,1862(a4) # 1000 <freep>
}
 8c2:	6422                	ld	s0,8(sp)
 8c4:	0141                	addi	sp,sp,16
 8c6:	8082                	ret

00000000000008c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c8:	7139                	addi	sp,sp,-64
 8ca:	fc06                	sd	ra,56(sp)
 8cc:	f822                	sd	s0,48(sp)
 8ce:	f426                	sd	s1,40(sp)
 8d0:	ec4e                	sd	s3,24(sp)
 8d2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d4:	02051493          	slli	s1,a0,0x20
 8d8:	9081                	srli	s1,s1,0x20
 8da:	04bd                	addi	s1,s1,15
 8dc:	8091                	srli	s1,s1,0x4
 8de:	0014899b          	addiw	s3,s1,1
 8e2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8e4:	00000517          	auipc	a0,0x0
 8e8:	71c53503          	ld	a0,1820(a0) # 1000 <freep>
 8ec:	c915                	beqz	a0,920 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f0:	4798                	lw	a4,8(a5)
 8f2:	08977a63          	bgeu	a4,s1,986 <malloc+0xbe>
 8f6:	f04a                	sd	s2,32(sp)
 8f8:	e852                	sd	s4,16(sp)
 8fa:	e456                	sd	s5,8(sp)
 8fc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8fe:	8a4e                	mv	s4,s3
 900:	0009871b          	sext.w	a4,s3
 904:	6685                	lui	a3,0x1
 906:	00d77363          	bgeu	a4,a3,90c <malloc+0x44>
 90a:	6a05                	lui	s4,0x1
 90c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 910:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 914:	00000917          	auipc	s2,0x0
 918:	6ec90913          	addi	s2,s2,1772 # 1000 <freep>
  if(p == SBRK_ERROR)
 91c:	5afd                	li	s5,-1
 91e:	a081                	j	95e <malloc+0x96>
 920:	f04a                	sd	s2,32(sp)
 922:	e852                	sd	s4,16(sp)
 924:	e456                	sd	s5,8(sp)
 926:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 928:	00000797          	auipc	a5,0x0
 92c:	6e878793          	addi	a5,a5,1768 # 1010 <base>
 930:	00000717          	auipc	a4,0x0
 934:	6cf73823          	sd	a5,1744(a4) # 1000 <freep>
 938:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 93a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 93e:	b7c1                	j	8fe <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 940:	6398                	ld	a4,0(a5)
 942:	e118                	sd	a4,0(a0)
 944:	a8a9                	j	99e <malloc+0xd6>
  hp->s.size = nu;
 946:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 94a:	0541                	addi	a0,a0,16
 94c:	efbff0ef          	jal	846 <free>
  return freep;
 950:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 954:	c12d                	beqz	a0,9b6 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 956:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 958:	4798                	lw	a4,8(a5)
 95a:	02977263          	bgeu	a4,s1,97e <malloc+0xb6>
    if(p == freep)
 95e:	00093703          	ld	a4,0(s2)
 962:	853e                	mv	a0,a5
 964:	fef719e3          	bne	a4,a5,956 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 968:	8552                	mv	a0,s4
 96a:	a3bff0ef          	jal	3a4 <sbrk>
  if(p == SBRK_ERROR)
 96e:	fd551ce3          	bne	a0,s5,946 <malloc+0x7e>
        return 0;
 972:	4501                	li	a0,0
 974:	7902                	ld	s2,32(sp)
 976:	6a42                	ld	s4,16(sp)
 978:	6aa2                	ld	s5,8(sp)
 97a:	6b02                	ld	s6,0(sp)
 97c:	a03d                	j	9aa <malloc+0xe2>
 97e:	7902                	ld	s2,32(sp)
 980:	6a42                	ld	s4,16(sp)
 982:	6aa2                	ld	s5,8(sp)
 984:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 986:	fae48de3          	beq	s1,a4,940 <malloc+0x78>
        p->s.size -= nunits;
 98a:	4137073b          	subw	a4,a4,s3
 98e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 990:	02071693          	slli	a3,a4,0x20
 994:	01c6d713          	srli	a4,a3,0x1c
 998:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 99e:	00000717          	auipc	a4,0x0
 9a2:	66a73123          	sd	a0,1634(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a6:	01078513          	addi	a0,a5,16
  }
}
 9aa:	70e2                	ld	ra,56(sp)
 9ac:	7442                	ld	s0,48(sp)
 9ae:	74a2                	ld	s1,40(sp)
 9b0:	69e2                	ld	s3,24(sp)
 9b2:	6121                	addi	sp,sp,64
 9b4:	8082                	ret
 9b6:	7902                	ld	s2,32(sp)
 9b8:	6a42                	ld	s4,16(sp)
 9ba:	6aa2                	ld	s5,8(sp)
 9bc:	6b02                	ld	s6,0(sp)
 9be:	b7f5                	j	9aa <malloc+0xe2>
