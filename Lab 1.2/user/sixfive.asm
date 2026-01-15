
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
  18:	e96a                	sd	s10,144(sp)
  1a:	1980                	addi	s0,sp,240
    //int n;
    char c;
    char str[128];
    int charCount = 0;

    if(argc >= 2){
  1c:	4785                	li	a5,1
  1e:	0ea7d863          	bge	a5,a0,10e <main+0x10e>
  22:	00858a93          	addi	s5,a1,8
  26:	ffe50c1b          	addiw	s8,a0,-2
  2a:	020c1793          	slli	a5,s8,0x20
  2e:	01d7dc13          	srli	s8,a5,0x1d
  32:	05c1                	addi	a1,a1,16
  34:	9c2e                	add	s8,s8,a1
    int charCount = 0;
  36:	4481                	li	s1,0
        for (int i = 1; i < argc; i++){
            fd = open(argv[i], 0);
            while (read(fd, &c, 1) > 0){
                if(strchr(" -\r\t\n./,", c) != 0){
  38:	00001997          	auipc	s3,0x1
  3c:	97898993          	addi	s3,s3,-1672 # 9b0 <malloc+0x102>
                            printf("%d\n", num);
                        }
                        
                        charCount = 0;
                    }
                } else if(c >= '0' && c <= '9'){  
  40:	4ba5                	li	s7,9
                    // If character is a number, add to buffer
                    if(charCount < sizeof(str) - 1){
  42:	07e00d13          	li	s10,126
                            printf("%d\n", num);
  46:	00001c97          	auipc	s9,0x1
  4a:	97ac8c93          	addi	s9,s9,-1670 # 9c0 <malloc+0x112>
  4e:	a049                	j	d0 <main+0xd0>
  50:	8566                	mv	a0,s9
  52:	7a8000ef          	jal	7fa <printf>
                        charCount = 0;
  56:	84d2                	mv	s1,s4
            while (read(fd, &c, 1) > 0){
  58:	4605                	li	a2,1
  5a:	f9f40593          	addi	a1,s0,-97
  5e:	854a                	mv	a0,s2
  60:	36e000ef          	jal	3ce <read>
  64:	06a05163          	blez	a0,c6 <main+0xc6>
                if(strchr(" -\r\t\n./,", c) != 0){
  68:	f9f44583          	lbu	a1,-97(s0)
  6c:	854e                	mv	a0,s3
  6e:	158000ef          	jal	1c6 <strchr>
  72:	c51d                	beqz	a0,a0 <main+0xa0>
                    if(charCount > 0){
  74:	fe9052e3          	blez	s1,58 <main+0x58>
                        str[charCount] = 0;
  78:	fa048793          	addi	a5,s1,-96
  7c:	008784b3          	add	s1,a5,s0
  80:	f6048c23          	sb	zero,-136(s1)
                        int num = atoi(str);
  84:	f1840513          	addi	a0,s0,-232
  88:	20c000ef          	jal	294 <atoi>
  8c:	85aa                	mv	a1,a0
                        if (num % 5 == 0 || num % 6 == 0 ){
  8e:	036567bb          	remw	a5,a0,s6
  92:	dfdd                	beqz	a5,50 <main+0x50>
  94:	4799                	li	a5,6
  96:	02f567bb          	remw	a5,a0,a5
                        charCount = 0;
  9a:	84d2                	mv	s1,s4
                        if (num % 5 == 0 || num % 6 == 0 ){
  9c:	ffd5                	bnez	a5,58 <main+0x58>
  9e:	bf4d                	j	50 <main+0x50>
                } else if(c >= '0' && c <= '9'){  
  a0:	f9f44703          	lbu	a4,-97(s0)
  a4:	fd07079b          	addiw	a5,a4,-48
  a8:	0ff7f793          	zext.b	a5,a5
  ac:	fafbe6e3          	bltu	s7,a5,58 <main+0x58>
                    if(charCount < sizeof(str) - 1){
  b0:	0004879b          	sext.w	a5,s1
  b4:	fafd62e3          	bltu	s10,a5,58 <main+0x58>
                        str[charCount] = c;
  b8:	fa048793          	addi	a5,s1,-96
  bc:	97a2                	add	a5,a5,s0
  be:	f6e78c23          	sb	a4,-136(a5)
                        charCount++;
  c2:	2485                	addiw	s1,s1,1
  c4:	bf51                	j	58 <main+0x58>
                    }
                }
            };

            // Print last number
            if(charCount > 0){
  c6:	00904e63          	bgtz	s1,e2 <main+0xe2>
        for (int i = 1; i < argc; i++){
  ca:	0aa1                	addi	s5,s5,8
  cc:	058a8763          	beq	s5,s8,11a <main+0x11a>
            fd = open(argv[i], 0);
  d0:	4581                	li	a1,0
  d2:	000ab503          	ld	a0,0(s5)
  d6:	320000ef          	jal	3f6 <open>
  da:	892a                	mv	s2,a0
                        if (num % 5 == 0 || num % 6 == 0 ){
  dc:	4b15                	li	s6,5
                        charCount = 0;
  de:	4a01                	li	s4,0
            while (read(fd, &c, 1) > 0){
  e0:	bfa5                	j	58 <main+0x58>
                str[charCount] = 0;
  e2:	fa048793          	addi	a5,s1,-96
  e6:	97a2                	add	a5,a5,s0
  e8:	f6078c23          	sb	zero,-136(a5)
                int num = atoi(str);
  ec:	f1840513          	addi	a0,s0,-232
  f0:	1a4000ef          	jal	294 <atoi>
  f4:	85aa                	mv	a1,a0
                if(num % 5 == 0 || num % 6 == 0){
  f6:	4795                	li	a5,5
  f8:	02f567bb          	remw	a5,a0,a5
  fc:	c789                	beqz	a5,106 <main+0x106>
  fe:	4799                	li	a5,6
 100:	02f567bb          	remw	a5,a0,a5
 104:	f3f9                	bnez	a5,ca <main+0xca>
                    printf("%d\n", num);
 106:	8566                	mv	a0,s9
 108:	6f2000ef          	jal	7fa <printf>
 10c:	bf7d                	j	ca <main+0xca>
            }
        
        }
        
    } else {
        printf("Usage: sixfive [filename]\n");
 10e:	00001517          	auipc	a0,0x1
 112:	8ba50513          	addi	a0,a0,-1862 # 9c8 <malloc+0x11a>
 116:	6e4000ef          	jal	7fa <printf>
    }
    exit(0);
 11a:	4501                	li	a0,0
 11c:	29a000ef          	jal	3b6 <exit>

0000000000000120 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 120:	1141                	addi	sp,sp,-16
 122:	e406                	sd	ra,8(sp)
 124:	e022                	sd	s0,0(sp)
 126:	0800                	addi	s0,sp,16
  extern int main();
  main();
 128:	ed9ff0ef          	jal	0 <main>
  exit(0);
 12c:	4501                	li	a0,0
 12e:	288000ef          	jal	3b6 <exit>

0000000000000132 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 138:	87aa                	mv	a5,a0
 13a:	0585                	addi	a1,a1,1
 13c:	0785                	addi	a5,a5,1
 13e:	fff5c703          	lbu	a4,-1(a1)
 142:	fee78fa3          	sb	a4,-1(a5)
 146:	fb75                	bnez	a4,13a <strcpy+0x8>
    ;
  return os;
}
 148:	6422                	ld	s0,8(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret

000000000000014e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e422                	sd	s0,8(sp)
 152:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 154:	00054783          	lbu	a5,0(a0)
 158:	cb91                	beqz	a5,16c <strcmp+0x1e>
 15a:	0005c703          	lbu	a4,0(a1)
 15e:	00f71763          	bne	a4,a5,16c <strcmp+0x1e>
    p++, q++;
 162:	0505                	addi	a0,a0,1
 164:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 166:	00054783          	lbu	a5,0(a0)
 16a:	fbe5                	bnez	a5,15a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 16c:	0005c503          	lbu	a0,0(a1)
}
 170:	40a7853b          	subw	a0,a5,a0
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strlen>:

uint
strlen(const char *s)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 180:	00054783          	lbu	a5,0(a0)
 184:	cf91                	beqz	a5,1a0 <strlen+0x26>
 186:	0505                	addi	a0,a0,1
 188:	87aa                	mv	a5,a0
 18a:	86be                	mv	a3,a5
 18c:	0785                	addi	a5,a5,1
 18e:	fff7c703          	lbu	a4,-1(a5)
 192:	ff65                	bnez	a4,18a <strlen+0x10>
 194:	40a6853b          	subw	a0,a3,a0
 198:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 19a:	6422                	ld	s0,8(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret
  for(n = 0; s[n]; n++)
 1a0:	4501                	li	a0,0
 1a2:	bfe5                	j	19a <strlen+0x20>

00000000000001a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1aa:	ca19                	beqz	a2,1c0 <memset+0x1c>
 1ac:	87aa                	mv	a5,a0
 1ae:	1602                	slli	a2,a2,0x20
 1b0:	9201                	srli	a2,a2,0x20
 1b2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1b6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ba:	0785                	addi	a5,a5,1
 1bc:	fee79de3          	bne	a5,a4,1b6 <memset+0x12>
  }
  return dst;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strchr>:

char*
strchr(const char *s, char c)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	cb99                	beqz	a5,1e6 <strchr+0x20>
    if(*s == c)
 1d2:	00f58763          	beq	a1,a5,1e0 <strchr+0x1a>
  for(; *s; s++)
 1d6:	0505                	addi	a0,a0,1
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	fbfd                	bnez	a5,1d2 <strchr+0xc>
      return (char*)s;
  return 0;
 1de:	4501                	li	a0,0
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  return 0;
 1e6:	4501                	li	a0,0
 1e8:	bfe5                	j	1e0 <strchr+0x1a>

00000000000001ea <gets>:

char*
gets(char *buf, int max)
{
 1ea:	711d                	addi	sp,sp,-96
 1ec:	ec86                	sd	ra,88(sp)
 1ee:	e8a2                	sd	s0,80(sp)
 1f0:	e4a6                	sd	s1,72(sp)
 1f2:	e0ca                	sd	s2,64(sp)
 1f4:	fc4e                	sd	s3,56(sp)
 1f6:	f852                	sd	s4,48(sp)
 1f8:	f456                	sd	s5,40(sp)
 1fa:	f05a                	sd	s6,32(sp)
 1fc:	ec5e                	sd	s7,24(sp)
 1fe:	1080                	addi	s0,sp,96
 200:	8baa                	mv	s7,a0
 202:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 204:	892a                	mv	s2,a0
 206:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 208:	4aa9                	li	s5,10
 20a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 20c:	89a6                	mv	s3,s1
 20e:	2485                	addiw	s1,s1,1
 210:	0344d663          	bge	s1,s4,23c <gets+0x52>
    cc = read(0, &c, 1);
 214:	4605                	li	a2,1
 216:	faf40593          	addi	a1,s0,-81
 21a:	4501                	li	a0,0
 21c:	1b2000ef          	jal	3ce <read>
    if(cc < 1)
 220:	00a05e63          	blez	a0,23c <gets+0x52>
    buf[i++] = c;
 224:	faf44783          	lbu	a5,-81(s0)
 228:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 22c:	01578763          	beq	a5,s5,23a <gets+0x50>
 230:	0905                	addi	s2,s2,1
 232:	fd679de3          	bne	a5,s6,20c <gets+0x22>
    buf[i++] = c;
 236:	89a6                	mv	s3,s1
 238:	a011                	j	23c <gets+0x52>
 23a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 23c:	99de                	add	s3,s3,s7
 23e:	00098023          	sb	zero,0(s3)
  return buf;
}
 242:	855e                	mv	a0,s7
 244:	60e6                	ld	ra,88(sp)
 246:	6446                	ld	s0,80(sp)
 248:	64a6                	ld	s1,72(sp)
 24a:	6906                	ld	s2,64(sp)
 24c:	79e2                	ld	s3,56(sp)
 24e:	7a42                	ld	s4,48(sp)
 250:	7aa2                	ld	s5,40(sp)
 252:	7b02                	ld	s6,32(sp)
 254:	6be2                	ld	s7,24(sp)
 256:	6125                	addi	sp,sp,96
 258:	8082                	ret

000000000000025a <stat>:

int
stat(const char *n, struct stat *st)
{
 25a:	1101                	addi	sp,sp,-32
 25c:	ec06                	sd	ra,24(sp)
 25e:	e822                	sd	s0,16(sp)
 260:	e04a                	sd	s2,0(sp)
 262:	1000                	addi	s0,sp,32
 264:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 266:	4581                	li	a1,0
 268:	18e000ef          	jal	3f6 <open>
  if(fd < 0)
 26c:	02054263          	bltz	a0,290 <stat+0x36>
 270:	e426                	sd	s1,8(sp)
 272:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 274:	85ca                	mv	a1,s2
 276:	198000ef          	jal	40e <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	160000ef          	jal	3de <close>
  return r;
 282:	64a2                	ld	s1,8(sp)
}
 284:	854a                	mv	a0,s2
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	6902                	ld	s2,0(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
    return -1;
 290:	597d                	li	s2,-1
 292:	bfcd                	j	284 <stat+0x2a>

0000000000000294 <atoi>:

int
atoi(const char *s)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66863          	bltu	a2,a5,2d8 <atoi+0x44>
 2ac:	872a                	mv	a4,a0
  n = 0;
 2ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1c>
  return n;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
  n = 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <atoi+0x3e>

00000000000002dc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e2:	02b57463          	bgeu	a0,a1,30a <memmove+0x2e>
    while(n-- > 0)
 2e6:	00c05f63          	blez	a2,304 <memmove+0x28>
 2ea:	1602                	slli	a2,a2,0x20
 2ec:	9201                	srli	a2,a2,0x20
 2ee:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f4:	0585                	addi	a1,a1,1
 2f6:	0705                	addi	a4,a4,1
 2f8:	fff5c683          	lbu	a3,-1(a1)
 2fc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 300:	fef71ae3          	bne	a4,a5,2f4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
    dst += n;
 30a:	00c50733          	add	a4,a0,a2
    src += n;
 30e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 310:	fec05ae3          	blez	a2,304 <memmove+0x28>
 314:	fff6079b          	addiw	a5,a2,-1
 318:	1782                	slli	a5,a5,0x20
 31a:	9381                	srli	a5,a5,0x20
 31c:	fff7c793          	not	a5,a5
 320:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 322:	15fd                	addi	a1,a1,-1
 324:	177d                	addi	a4,a4,-1
 326:	0005c683          	lbu	a3,0(a1)
 32a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 32e:	fee79ae3          	bne	a5,a4,322 <memmove+0x46>
 332:	bfc9                	j	304 <memmove+0x28>

0000000000000334 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 33a:	ca05                	beqz	a2,36a <memcmp+0x36>
 33c:	fff6069b          	addiw	a3,a2,-1
 340:	1682                	slli	a3,a3,0x20
 342:	9281                	srli	a3,a3,0x20
 344:	0685                	addi	a3,a3,1
 346:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 348:	00054783          	lbu	a5,0(a0)
 34c:	0005c703          	lbu	a4,0(a1)
 350:	00e79863          	bne	a5,a4,360 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 354:	0505                	addi	a0,a0,1
    p2++;
 356:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 358:	fed518e3          	bne	a0,a3,348 <memcmp+0x14>
  }
  return 0;
 35c:	4501                	li	a0,0
 35e:	a019                	j	364 <memcmp+0x30>
      return *p1 - *p2;
 360:	40e7853b          	subw	a0,a5,a4
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
  return 0;
 36a:	4501                	li	a0,0
 36c:	bfe5                	j	364 <memcmp+0x30>

000000000000036e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e406                	sd	ra,8(sp)
 372:	e022                	sd	s0,0(sp)
 374:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 376:	f67ff0ef          	jal	2dc <memmove>
}
 37a:	60a2                	ld	ra,8(sp)
 37c:	6402                	ld	s0,0(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <sbrk>:

char *
sbrk(int n) {
 382:	1141                	addi	sp,sp,-16
 384:	e406                	sd	ra,8(sp)
 386:	e022                	sd	s0,0(sp)
 388:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 38a:	4585                	li	a1,1
 38c:	0b2000ef          	jal	43e <sys_sbrk>
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret

0000000000000398 <sbrklazy>:

char *
sbrklazy(int n) {
 398:	1141                	addi	sp,sp,-16
 39a:	e406                	sd	ra,8(sp)
 39c:	e022                	sd	s0,0(sp)
 39e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3a0:	4589                	li	a1,2
 3a2:	09c000ef          	jal	43e <sys_sbrk>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <pause>:
.global pause
pause:
 li a7, SYS_pause
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <hello>:
.global hello
hello:
 li a7, SYS_hello
 456:	48dd                	li	a7,23
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <interpose>:
.global interpose
interpose:
 li a7, SYS_interpose
 45e:	48d9                	li	a7,22
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 466:	1101                	addi	sp,sp,-32
 468:	ec06                	sd	ra,24(sp)
 46a:	e822                	sd	s0,16(sp)
 46c:	1000                	addi	s0,sp,32
 46e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 472:	4605                	li	a2,1
 474:	fef40593          	addi	a1,s0,-17
 478:	f5fff0ef          	jal	3d6 <write>
}
 47c:	60e2                	ld	ra,24(sp)
 47e:	6442                	ld	s0,16(sp)
 480:	6105                	addi	sp,sp,32
 482:	8082                	ret

0000000000000484 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 484:	715d                	addi	sp,sp,-80
 486:	e486                	sd	ra,72(sp)
 488:	e0a2                	sd	s0,64(sp)
 48a:	fc26                	sd	s1,56(sp)
 48c:	0880                	addi	s0,sp,80
 48e:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 490:	c299                	beqz	a3,496 <printint+0x12>
 492:	0805c963          	bltz	a1,524 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 496:	2581                	sext.w	a1,a1
  neg = 0;
 498:	4881                	li	a7,0
 49a:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 49e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a0:	2601                	sext.w	a2,a2
 4a2:	00000517          	auipc	a0,0x0
 4a6:	54e50513          	addi	a0,a0,1358 # 9f0 <digits>
 4aa:	883a                	mv	a6,a4
 4ac:	2705                	addiw	a4,a4,1
 4ae:	02c5f7bb          	remuw	a5,a1,a2
 4b2:	1782                	slli	a5,a5,0x20
 4b4:	9381                	srli	a5,a5,0x20
 4b6:	97aa                	add	a5,a5,a0
 4b8:	0007c783          	lbu	a5,0(a5)
 4bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c0:	0005879b          	sext.w	a5,a1
 4c4:	02c5d5bb          	divuw	a1,a1,a2
 4c8:	0685                	addi	a3,a3,1
 4ca:	fec7f0e3          	bgeu	a5,a2,4aa <printint+0x26>
  if(neg)
 4ce:	00088c63          	beqz	a7,4e6 <printint+0x62>
    buf[i++] = '-';
 4d2:	fd070793          	addi	a5,a4,-48
 4d6:	00878733          	add	a4,a5,s0
 4da:	02d00793          	li	a5,45
 4de:	fef70423          	sb	a5,-24(a4)
 4e2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4e6:	02e05a63          	blez	a4,51a <printint+0x96>
 4ea:	f84a                	sd	s2,48(sp)
 4ec:	f44e                	sd	s3,40(sp)
 4ee:	fb840793          	addi	a5,s0,-72
 4f2:	00e78933          	add	s2,a5,a4
 4f6:	fff78993          	addi	s3,a5,-1
 4fa:	99ba                	add	s3,s3,a4
 4fc:	377d                	addiw	a4,a4,-1
 4fe:	1702                	slli	a4,a4,0x20
 500:	9301                	srli	a4,a4,0x20
 502:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 506:	fff94583          	lbu	a1,-1(s2)
 50a:	8526                	mv	a0,s1
 50c:	f5bff0ef          	jal	466 <putc>
  while(--i >= 0)
 510:	197d                	addi	s2,s2,-1
 512:	ff391ae3          	bne	s2,s3,506 <printint+0x82>
 516:	7942                	ld	s2,48(sp)
 518:	79a2                	ld	s3,40(sp)
}
 51a:	60a6                	ld	ra,72(sp)
 51c:	6406                	ld	s0,64(sp)
 51e:	74e2                	ld	s1,56(sp)
 520:	6161                	addi	sp,sp,80
 522:	8082                	ret
    x = -xx;
 524:	40b005bb          	negw	a1,a1
    neg = 1;
 528:	4885                	li	a7,1
    x = -xx;
 52a:	bf85                	j	49a <printint+0x16>

000000000000052c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 52c:	711d                	addi	sp,sp,-96
 52e:	ec86                	sd	ra,88(sp)
 530:	e8a2                	sd	s0,80(sp)
 532:	e0ca                	sd	s2,64(sp)
 534:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 536:	0005c903          	lbu	s2,0(a1)
 53a:	28090663          	beqz	s2,7c6 <vprintf+0x29a>
 53e:	e4a6                	sd	s1,72(sp)
 540:	fc4e                	sd	s3,56(sp)
 542:	f852                	sd	s4,48(sp)
 544:	f456                	sd	s5,40(sp)
 546:	f05a                	sd	s6,32(sp)
 548:	ec5e                	sd	s7,24(sp)
 54a:	e862                	sd	s8,16(sp)
 54c:	e466                	sd	s9,8(sp)
 54e:	8b2a                	mv	s6,a0
 550:	8a2e                	mv	s4,a1
 552:	8bb2                	mv	s7,a2
  state = 0;
 554:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 556:	4481                	li	s1,0
 558:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 55a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 55e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 562:	06c00c93          	li	s9,108
 566:	a005                	j	586 <vprintf+0x5a>
        putc(fd, c0);
 568:	85ca                	mv	a1,s2
 56a:	855a                	mv	a0,s6
 56c:	efbff0ef          	jal	466 <putc>
 570:	a019                	j	576 <vprintf+0x4a>
    } else if(state == '%'){
 572:	03598263          	beq	s3,s5,596 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 576:	2485                	addiw	s1,s1,1
 578:	8726                	mv	a4,s1
 57a:	009a07b3          	add	a5,s4,s1
 57e:	0007c903          	lbu	s2,0(a5)
 582:	22090a63          	beqz	s2,7b6 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 586:	0009079b          	sext.w	a5,s2
    if(state == 0){
 58a:	fe0994e3          	bnez	s3,572 <vprintf+0x46>
      if(c0 == '%'){
 58e:	fd579de3          	bne	a5,s5,568 <vprintf+0x3c>
        state = '%';
 592:	89be                	mv	s3,a5
 594:	b7cd                	j	576 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 596:	00ea06b3          	add	a3,s4,a4
 59a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 59e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5a0:	c681                	beqz	a3,5a8 <vprintf+0x7c>
 5a2:	9752                	add	a4,a4,s4
 5a4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5a8:	05878363          	beq	a5,s8,5ee <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5ac:	05978d63          	beq	a5,s9,606 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5b0:	07500713          	li	a4,117
 5b4:	0ee78763          	beq	a5,a4,6a2 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b8:	07800713          	li	a4,120
 5bc:	12e78963          	beq	a5,a4,6ee <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5c0:	07000713          	li	a4,112
 5c4:	14e78e63          	beq	a5,a4,720 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5c8:	06300713          	li	a4,99
 5cc:	18e78e63          	beq	a5,a4,768 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5d0:	07300713          	li	a4,115
 5d4:	1ae78463          	beq	a5,a4,77c <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5d8:	02500713          	li	a4,37
 5dc:	04e79563          	bne	a5,a4,626 <vprintf+0xfa>
        putc(fd, '%');
 5e0:	02500593          	li	a1,37
 5e4:	855a                	mv	a0,s6
 5e6:	e81ff0ef          	jal	466 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b769                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ee:	008b8913          	addi	s2,s7,8
 5f2:	4685                	li	a3,1
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	e89ff0ef          	jal	484 <printint>
 600:	8bca                	mv	s7,s2
      state = 0;
 602:	4981                	li	s3,0
 604:	bf8d                	j	576 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 606:	06400793          	li	a5,100
 60a:	02f68963          	beq	a3,a5,63c <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60e:	06c00793          	li	a5,108
 612:	04f68263          	beq	a3,a5,656 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 616:	07500793          	li	a5,117
 61a:	0af68063          	beq	a3,a5,6ba <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 61e:	07800793          	li	a5,120
 622:	0ef68263          	beq	a3,a5,706 <vprintf+0x1da>
        putc(fd, '%');
 626:	02500593          	li	a1,37
 62a:	855a                	mv	a0,s6
 62c:	e3bff0ef          	jal	466 <putc>
        putc(fd, c0);
 630:	85ca                	mv	a1,s2
 632:	855a                	mv	a0,s6
 634:	e33ff0ef          	jal	466 <putc>
      state = 0;
 638:	4981                	li	s3,0
 63a:	bf35                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63c:	008b8913          	addi	s2,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000bb583          	ld	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e3bff0ef          	jal	484 <printint>
        i += 1;
 64e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	8bca                	mv	s7,s2
      state = 0;
 652:	4981                	li	s3,0
        i += 1;
 654:	b70d                	j	576 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 656:	06400793          	li	a5,100
 65a:	02f60763          	beq	a2,a5,688 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 65e:	07500793          	li	a5,117
 662:	06f60963          	beq	a2,a5,6d4 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 666:	07800793          	li	a5,120
 66a:	faf61ee3          	bne	a2,a5,626 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	008b8913          	addi	s2,s7,8
 672:	4681                	li	a3,0
 674:	4641                	li	a2,16
 676:	000bb583          	ld	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	e09ff0ef          	jal	484 <printint>
        i += 2;
 680:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 682:	8bca                	mv	s7,s2
      state = 0;
 684:	4981                	li	s3,0
        i += 2;
 686:	bdc5                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 688:	008b8913          	addi	s2,s7,8
 68c:	4685                	li	a3,1
 68e:	4629                	li	a2,10
 690:	000bb583          	ld	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	defff0ef          	jal	484 <printint>
        i += 2;
 69a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	bdd9                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6a2:	008b8913          	addi	s2,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000be583          	lwu	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	dd5ff0ef          	jal	484 <printint>
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	bd7d                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ba:	008b8913          	addi	s2,s7,8
 6be:	4681                	li	a3,0
 6c0:	4629                	li	a2,10
 6c2:	000bb583          	ld	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	dbdff0ef          	jal	484 <printint>
        i += 1;
 6cc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
        i += 1;
 6d2:	b555                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000bb583          	ld	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	da3ff0ef          	jal	484 <printint>
        i += 2;
 6e6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	8bca                	mv	s7,s2
      state = 0;
 6ea:	4981                	li	s3,0
        i += 2;
 6ec:	b569                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6ee:	008b8913          	addi	s2,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4641                	li	a2,16
 6f6:	000be583          	lwu	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	d89ff0ef          	jal	484 <printint>
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bd8d                	j	576 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 706:	008b8913          	addi	s2,s7,8
 70a:	4681                	li	a3,0
 70c:	4641                	li	a2,16
 70e:	000bb583          	ld	a1,0(s7)
 712:	855a                	mv	a0,s6
 714:	d71ff0ef          	jal	484 <printint>
        i += 1;
 718:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 71a:	8bca                	mv	s7,s2
      state = 0;
 71c:	4981                	li	s3,0
        i += 1;
 71e:	bda1                	j	576 <vprintf+0x4a>
 720:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 722:	008b8d13          	addi	s10,s7,8
 726:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 72a:	03000593          	li	a1,48
 72e:	855a                	mv	a0,s6
 730:	d37ff0ef          	jal	466 <putc>
  putc(fd, 'x');
 734:	07800593          	li	a1,120
 738:	855a                	mv	a0,s6
 73a:	d2dff0ef          	jal	466 <putc>
 73e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 740:	00000b97          	auipc	s7,0x0
 744:	2b0b8b93          	addi	s7,s7,688 # 9f0 <digits>
 748:	03c9d793          	srli	a5,s3,0x3c
 74c:	97de                	add	a5,a5,s7
 74e:	0007c583          	lbu	a1,0(a5)
 752:	855a                	mv	a0,s6
 754:	d13ff0ef          	jal	466 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 758:	0992                	slli	s3,s3,0x4
 75a:	397d                	addiw	s2,s2,-1
 75c:	fe0916e3          	bnez	s2,748 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 760:	8bea                	mv	s7,s10
      state = 0;
 762:	4981                	li	s3,0
 764:	6d02                	ld	s10,0(sp)
 766:	bd01                	j	576 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 768:	008b8913          	addi	s2,s7,8
 76c:	000bc583          	lbu	a1,0(s7)
 770:	855a                	mv	a0,s6
 772:	cf5ff0ef          	jal	466 <putc>
 776:	8bca                	mv	s7,s2
      state = 0;
 778:	4981                	li	s3,0
 77a:	bbf5                	j	576 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 77c:	008b8993          	addi	s3,s7,8
 780:	000bb903          	ld	s2,0(s7)
 784:	00090f63          	beqz	s2,7a2 <vprintf+0x276>
        for(; *s; s++)
 788:	00094583          	lbu	a1,0(s2)
 78c:	c195                	beqz	a1,7b0 <vprintf+0x284>
          putc(fd, *s);
 78e:	855a                	mv	a0,s6
 790:	cd7ff0ef          	jal	466 <putc>
        for(; *s; s++)
 794:	0905                	addi	s2,s2,1
 796:	00094583          	lbu	a1,0(s2)
 79a:	f9f5                	bnez	a1,78e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 79c:	8bce                	mv	s7,s3
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bbd9                	j	576 <vprintf+0x4a>
          s = "(null)";
 7a2:	00000917          	auipc	s2,0x0
 7a6:	24690913          	addi	s2,s2,582 # 9e8 <malloc+0x13a>
        for(; *s; s++)
 7aa:	02800593          	li	a1,40
 7ae:	b7c5                	j	78e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7b0:	8bce                	mv	s7,s3
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	b3c9                	j	576 <vprintf+0x4a>
 7b6:	64a6                	ld	s1,72(sp)
 7b8:	79e2                	ld	s3,56(sp)
 7ba:	7a42                	ld	s4,48(sp)
 7bc:	7aa2                	ld	s5,40(sp)
 7be:	7b02                	ld	s6,32(sp)
 7c0:	6be2                	ld	s7,24(sp)
 7c2:	6c42                	ld	s8,16(sp)
 7c4:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c6:	60e6                	ld	ra,88(sp)
 7c8:	6446                	ld	s0,80(sp)
 7ca:	6906                	ld	s2,64(sp)
 7cc:	6125                	addi	sp,sp,96
 7ce:	8082                	ret

00000000000007d0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d0:	715d                	addi	sp,sp,-80
 7d2:	ec06                	sd	ra,24(sp)
 7d4:	e822                	sd	s0,16(sp)
 7d6:	1000                	addi	s0,sp,32
 7d8:	e010                	sd	a2,0(s0)
 7da:	e414                	sd	a3,8(s0)
 7dc:	e818                	sd	a4,16(s0)
 7de:	ec1c                	sd	a5,24(s0)
 7e0:	03043023          	sd	a6,32(s0)
 7e4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ec:	8622                	mv	a2,s0
 7ee:	d3fff0ef          	jal	52c <vprintf>
}
 7f2:	60e2                	ld	ra,24(sp)
 7f4:	6442                	ld	s0,16(sp)
 7f6:	6161                	addi	sp,sp,80
 7f8:	8082                	ret

00000000000007fa <printf>:

void
printf(const char *fmt, ...)
{
 7fa:	711d                	addi	sp,sp,-96
 7fc:	ec06                	sd	ra,24(sp)
 7fe:	e822                	sd	s0,16(sp)
 800:	1000                	addi	s0,sp,32
 802:	e40c                	sd	a1,8(s0)
 804:	e810                	sd	a2,16(s0)
 806:	ec14                	sd	a3,24(s0)
 808:	f018                	sd	a4,32(s0)
 80a:	f41c                	sd	a5,40(s0)
 80c:	03043823          	sd	a6,48(s0)
 810:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 814:	00840613          	addi	a2,s0,8
 818:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81c:	85aa                	mv	a1,a0
 81e:	4505                	li	a0,1
 820:	d0dff0ef          	jal	52c <vprintf>
}
 824:	60e2                	ld	ra,24(sp)
 826:	6442                	ld	s0,16(sp)
 828:	6125                	addi	sp,sp,96
 82a:	8082                	ret

000000000000082c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82c:	1141                	addi	sp,sp,-16
 82e:	e422                	sd	s0,8(sp)
 830:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 832:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 836:	00000797          	auipc	a5,0x0
 83a:	7ca7b783          	ld	a5,1994(a5) # 1000 <freep>
 83e:	a02d                	j	868 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 840:	4618                	lw	a4,8(a2)
 842:	9f2d                	addw	a4,a4,a1
 844:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 848:	6398                	ld	a4,0(a5)
 84a:	6310                	ld	a2,0(a4)
 84c:	a83d                	j	88a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84e:	ff852703          	lw	a4,-8(a0)
 852:	9f31                	addw	a4,a4,a2
 854:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 856:	ff053683          	ld	a3,-16(a0)
 85a:	a091                	j	89e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	6398                	ld	a4,0(a5)
 85e:	00e7e463          	bltu	a5,a4,866 <free+0x3a>
 862:	00e6ea63          	bltu	a3,a4,876 <free+0x4a>
{
 866:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 868:	fed7fae3          	bgeu	a5,a3,85c <free+0x30>
 86c:	6398                	ld	a4,0(a5)
 86e:	00e6e463          	bltu	a3,a4,876 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 872:	fee7eae3          	bltu	a5,a4,866 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 876:	ff852583          	lw	a1,-8(a0)
 87a:	6390                	ld	a2,0(a5)
 87c:	02059813          	slli	a6,a1,0x20
 880:	01c85713          	srli	a4,a6,0x1c
 884:	9736                	add	a4,a4,a3
 886:	fae60de3          	beq	a2,a4,840 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 88a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88e:	4790                	lw	a2,8(a5)
 890:	02061593          	slli	a1,a2,0x20
 894:	01c5d713          	srli	a4,a1,0x1c
 898:	973e                	add	a4,a4,a5
 89a:	fae68ae3          	beq	a3,a4,84e <free+0x22>
    p->s.ptr = bp->s.ptr;
 89e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8a0:	00000717          	auipc	a4,0x0
 8a4:	76f73023          	sd	a5,1888(a4) # 1000 <freep>
}
 8a8:	6422                	ld	s0,8(sp)
 8aa:	0141                	addi	sp,sp,16
 8ac:	8082                	ret

00000000000008ae <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ae:	7139                	addi	sp,sp,-64
 8b0:	fc06                	sd	ra,56(sp)
 8b2:	f822                	sd	s0,48(sp)
 8b4:	f426                	sd	s1,40(sp)
 8b6:	ec4e                	sd	s3,24(sp)
 8b8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ba:	02051493          	slli	s1,a0,0x20
 8be:	9081                	srli	s1,s1,0x20
 8c0:	04bd                	addi	s1,s1,15
 8c2:	8091                	srli	s1,s1,0x4
 8c4:	0014899b          	addiw	s3,s1,1
 8c8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ca:	00000517          	auipc	a0,0x0
 8ce:	73653503          	ld	a0,1846(a0) # 1000 <freep>
 8d2:	c915                	beqz	a0,906 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d6:	4798                	lw	a4,8(a5)
 8d8:	08977a63          	bgeu	a4,s1,96c <malloc+0xbe>
 8dc:	f04a                	sd	s2,32(sp)
 8de:	e852                	sd	s4,16(sp)
 8e0:	e456                	sd	s5,8(sp)
 8e2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8e4:	8a4e                	mv	s4,s3
 8e6:	0009871b          	sext.w	a4,s3
 8ea:	6685                	lui	a3,0x1
 8ec:	00d77363          	bgeu	a4,a3,8f2 <malloc+0x44>
 8f0:	6a05                	lui	s4,0x1
 8f2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8fa:	00000917          	auipc	s2,0x0
 8fe:	70690913          	addi	s2,s2,1798 # 1000 <freep>
  if(p == SBRK_ERROR)
 902:	5afd                	li	s5,-1
 904:	a081                	j	944 <malloc+0x96>
 906:	f04a                	sd	s2,32(sp)
 908:	e852                	sd	s4,16(sp)
 90a:	e456                	sd	s5,8(sp)
 90c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 90e:	00000797          	auipc	a5,0x0
 912:	70278793          	addi	a5,a5,1794 # 1010 <base>
 916:	00000717          	auipc	a4,0x0
 91a:	6ef73523          	sd	a5,1770(a4) # 1000 <freep>
 91e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 920:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 924:	b7c1                	j	8e4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 926:	6398                	ld	a4,0(a5)
 928:	e118                	sd	a4,0(a0)
 92a:	a8a9                	j	984 <malloc+0xd6>
  hp->s.size = nu;
 92c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 930:	0541                	addi	a0,a0,16
 932:	efbff0ef          	jal	82c <free>
  return freep;
 936:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 93a:	c12d                	beqz	a0,99c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	02977263          	bgeu	a4,s1,964 <malloc+0xb6>
    if(p == freep)
 944:	00093703          	ld	a4,0(s2)
 948:	853e                	mv	a0,a5
 94a:	fef719e3          	bne	a4,a5,93c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 94e:	8552                	mv	a0,s4
 950:	a33ff0ef          	jal	382 <sbrk>
  if(p == SBRK_ERROR)
 954:	fd551ce3          	bne	a0,s5,92c <malloc+0x7e>
        return 0;
 958:	4501                	li	a0,0
 95a:	7902                	ld	s2,32(sp)
 95c:	6a42                	ld	s4,16(sp)
 95e:	6aa2                	ld	s5,8(sp)
 960:	6b02                	ld	s6,0(sp)
 962:	a03d                	j	990 <malloc+0xe2>
 964:	7902                	ld	s2,32(sp)
 966:	6a42                	ld	s4,16(sp)
 968:	6aa2                	ld	s5,8(sp)
 96a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 96c:	fae48de3          	beq	s1,a4,926 <malloc+0x78>
        p->s.size -= nunits;
 970:	4137073b          	subw	a4,a4,s3
 974:	c798                	sw	a4,8(a5)
        p += p->s.size;
 976:	02071693          	slli	a3,a4,0x20
 97a:	01c6d713          	srli	a4,a3,0x1c
 97e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 980:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 984:	00000717          	auipc	a4,0x0
 988:	66a73e23          	sd	a0,1660(a4) # 1000 <freep>
      return (void*)(p + 1);
 98c:	01078513          	addi	a0,a5,16
  }
}
 990:	70e2                	ld	ra,56(sp)
 992:	7442                	ld	s0,48(sp)
 994:	74a2                	ld	s1,40(sp)
 996:	69e2                	ld	s3,24(sp)
 998:	6121                	addi	sp,sp,64
 99a:	8082                	ret
 99c:	7902                	ld	s2,32(sp)
 99e:	6a42                	ld	s4,16(sp)
 9a0:	6aa2                	ld	s5,8(sp)
 9a2:	6b02                	ld	s6,0(sp)
 9a4:	b7f5                	j	990 <malloc+0xe2>
