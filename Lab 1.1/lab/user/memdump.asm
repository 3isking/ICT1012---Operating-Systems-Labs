
user/_memdump:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <memdump>:
  // Your code here.
  // Array Pointer
  char *p = data;

  // Loop through FMT
  for (int i = 0; fmt[i] != '\0'; i++) {
   0:	00054783          	lbu	a5,0(a0)
   4:	10078863          	beqz	a5,114 <memdump+0x114>
{
   8:	711d                	addi	sp,sp,-96
   a:	ec86                	sd	ra,88(sp)
   c:	e8a2                	sd	s0,80(sp)
   e:	e4a6                	sd	s1,72(sp)
  10:	e0ca                	sd	s2,64(sp)
  12:	fc4e                	sd	s3,56(sp)
  14:	f852                	sd	s4,48(sp)
  16:	f456                	sd	s5,40(sp)
  18:	f05a                	sd	s6,32(sp)
  1a:	ec5e                	sd	s7,24(sp)
  1c:	e862                	sd	s8,16(sp)
  1e:	e466                	sd	s9,8(sp)
  20:	e06a                	sd	s10,0(sp)
  22:	1080                	addi	s0,sp,96
  24:	84aa                	mv	s1,a0
  26:	892e                	mv	s2,a1

    // If FMT is i
    if (fmt[i] == 'i'){
  28:	06900b93          	li	s7,105
      int val = *(int *)p;
      printf("%d\n", val);
  2c:	00001c17          	auipc	s8,0x1
  30:	ae4c0c13          	addi	s8,s8,-1308 # b10 <malloc+0x106>
      p += 4;
    }

    //If FMT is p
    if (fmt[i] == 'p'){
  34:	07000b13          	li	s6,112
      long val = *(long *)p;
      printf("%ld\n", val);
  38:	00001d17          	auipc	s10,0x1
  3c:	ae0d0d13          	addi	s10,s10,-1312 # b18 <malloc+0x10e>
      p += 8;
    }

    //If FMT is h
    if (fmt[i] == 'h'){
  40:	06800a93          	li	s5,104
      printf("%d\n", val);
      p += 2;
    }

    //If FMT is c
    if (fmt[i] == 'c'){
  44:	06300a13          	li	s4,99
      char val = *p;
      printf("%c\n", val);
  48:	00001c97          	auipc	s9,0x1
  4c:	ad8c8c93          	addi	s9,s9,-1320 # b20 <malloc+0x116>
      p += 1;
    }

    //If FMT is s
    if (fmt[i] == 's'){
  50:	07300993          	li	s3,115
  54:	a81d                	j	8a <memdump+0x8a>
    if (fmt[i] == 'p'){
  56:	0004c783          	lbu	a5,0(s1)
  5a:	05678163          	beq	a5,s6,9c <memdump+0x9c>
    if (fmt[i] == 'h'){
  5e:	0004c783          	lbu	a5,0(s1)
  62:	05578463          	beq	a5,s5,aa <memdump+0xaa>
    if (fmt[i] == 'c'){
  66:	0004c783          	lbu	a5,0(s1)
  6a:	05478763          	beq	a5,s4,b8 <memdump+0xb8>
    if (fmt[i] == 's'){
  6e:	0004c783          	lbu	a5,0(s1)
  72:	05378a63          	beq	a5,s3,c6 <memdump+0xc6>
      printf("%s\n", val);
      p += 8;
    }

    //If FMT is s
    if (fmt[i] == 'S'){
  76:	0004c703          	lbu	a4,0(s1)
  7a:	05300793          	li	a5,83
  7e:	04f70e63          	beq	a4,a5,da <memdump+0xda>
  for (int i = 0; fmt[i] != '\0'; i++) {
  82:	0485                	addi	s1,s1,1
  84:	0004c783          	lbu	a5,0(s1)
  88:	cba5                	beqz	a5,f8 <memdump+0xf8>
    if (fmt[i] == 'i'){
  8a:	fd7796e3          	bne	a5,s7,56 <memdump+0x56>
      printf("%d\n", val);
  8e:	00092583          	lw	a1,0(s2)
  92:	8562                	mv	a0,s8
  94:	0c3000ef          	jal	956 <printf>
      p += 4;
  98:	0911                	addi	s2,s2,4
  9a:	bf75                	j	56 <memdump+0x56>
      printf("%ld\n", val);
  9c:	00093583          	ld	a1,0(s2)
  a0:	856a                	mv	a0,s10
  a2:	0b5000ef          	jal	956 <printf>
      p += 8;
  a6:	0921                	addi	s2,s2,8
  a8:	bf5d                	j	5e <memdump+0x5e>
      printf("%d\n", val);
  aa:	00091583          	lh	a1,0(s2)
  ae:	8562                	mv	a0,s8
  b0:	0a7000ef          	jal	956 <printf>
      p += 2;
  b4:	0909                	addi	s2,s2,2
  b6:	bf45                	j	66 <memdump+0x66>
      printf("%c\n", val);
  b8:	00094583          	lbu	a1,0(s2)
  bc:	8566                	mv	a0,s9
  be:	099000ef          	jal	956 <printf>
      p += 1;
  c2:	0905                	addi	s2,s2,1
  c4:	b76d                	j	6e <memdump+0x6e>
      printf("%s\n", val);
  c6:	00093583          	ld	a1,0(s2)
  ca:	00001517          	auipc	a0,0x1
  ce:	a5e50513          	addi	a0,a0,-1442 # b28 <malloc+0x11e>
  d2:	085000ef          	jal	956 <printf>
      p += 8;
  d6:	0921                	addi	s2,s2,8
  d8:	bf79                	j	76 <memdump+0x76>
      printf("%s\n", p);
  da:	85ca                	mv	a1,s2
  dc:	00001517          	auipc	a0,0x1
  e0:	a4c50513          	addi	a0,a0,-1460 # b28 <malloc+0x11e>
  e4:	073000ef          	jal	956 <printf>
      p += strlen(p) + 1;
  e8:	854a                	mv	a0,s2
  ea:	1fc000ef          	jal	2e6 <strlen>
  ee:	2505                	addiw	a0,a0,1
  f0:	1502                	slli	a0,a0,0x20
  f2:	9101                	srli	a0,a0,0x20
  f4:	992a                	add	s2,s2,a0
  f6:	b771                	j	82 <memdump+0x82>
    }

    
  }
}
  f8:	60e6                	ld	ra,88(sp)
  fa:	6446                	ld	s0,80(sp)
  fc:	64a6                	ld	s1,72(sp)
  fe:	6906                	ld	s2,64(sp)
 100:	79e2                	ld	s3,56(sp)
 102:	7a42                	ld	s4,48(sp)
 104:	7aa2                	ld	s5,40(sp)
 106:	7b02                	ld	s6,32(sp)
 108:	6be2                	ld	s7,24(sp)
 10a:	6c42                	ld	s8,16(sp)
 10c:	6ca2                	ld	s9,8(sp)
 10e:	6d02                	ld	s10,0(sp)
 110:	6125                	addi	sp,sp,96
 112:	8082                	ret
 114:	8082                	ret

0000000000000116 <main>:
{
 116:	dc010113          	addi	sp,sp,-576
 11a:	22113c23          	sd	ra,568(sp)
 11e:	22813823          	sd	s0,560(sp)
 122:	22913423          	sd	s1,552(sp)
 126:	23213023          	sd	s2,544(sp)
 12a:	21313c23          	sd	s3,536(sp)
 12e:	21413823          	sd	s4,528(sp)
 132:	0480                	addi	s0,sp,576
  if(argc == 1){
 134:	4785                	li	a5,1
 136:	00f50f63          	beq	a0,a5,154 <main+0x3e>
 13a:	892e                	mv	s2,a1
  } else if(argc == 2){
 13c:	4789                	li	a5,2
 13e:	0ef50f63          	beq	a0,a5,23c <main+0x126>
    printf("Usage: memdump [format]\n");
 142:	00001517          	auipc	a0,0x1
 146:	a8e50513          	addi	a0,a0,-1394 # bd0 <malloc+0x1c6>
 14a:	00d000ef          	jal	956 <printf>
    exit(1);
 14e:	4505                	li	a0,1
 150:	3d2000ef          	jal	522 <exit>
    printf("Example 1:\n");
 154:	00001517          	auipc	a0,0x1
 158:	9dc50513          	addi	a0,a0,-1572 # b30 <malloc+0x126>
 15c:	7fa000ef          	jal	956 <printf>
    int a[2] = { 61810, 2025 };
 160:	67bd                	lui	a5,0xf
 162:	17278793          	addi	a5,a5,370 # f172 <base+0xd162>
 166:	dcf42023          	sw	a5,-576(s0)
 16a:	7e900793          	li	a5,2025
 16e:	dcf42223          	sw	a5,-572(s0)
    memdump("ii", (char*) a);
 172:	dc040593          	addi	a1,s0,-576
 176:	00001517          	auipc	a0,0x1
 17a:	9ca50513          	addi	a0,a0,-1590 # b40 <malloc+0x136>
 17e:	e83ff0ef          	jal	0 <memdump>
    printf("Example 2:\n");
 182:	00001517          	auipc	a0,0x1
 186:	9c650513          	addi	a0,a0,-1594 # b48 <malloc+0x13e>
 18a:	7cc000ef          	jal	956 <printf>
    memdump("S", "a string");
 18e:	00001597          	auipc	a1,0x1
 192:	9ca58593          	addi	a1,a1,-1590 # b58 <malloc+0x14e>
 196:	00001517          	auipc	a0,0x1
 19a:	9d250513          	addi	a0,a0,-1582 # b68 <malloc+0x15e>
 19e:	e63ff0ef          	jal	0 <memdump>
    printf("Example 3:\n");
 1a2:	00001517          	auipc	a0,0x1
 1a6:	9ce50513          	addi	a0,a0,-1586 # b70 <malloc+0x166>
 1aa:	7ac000ef          	jal	956 <printf>
    char *s = "another";
 1ae:	00001797          	auipc	a5,0x1
 1b2:	9d278793          	addi	a5,a5,-1582 # b80 <malloc+0x176>
 1b6:	dcf43423          	sd	a5,-568(s0)
    memdump("s", (char *) &s);
 1ba:	dc840593          	addi	a1,s0,-568
 1be:	00001517          	auipc	a0,0x1
 1c2:	9ca50513          	addi	a0,a0,-1590 # b88 <malloc+0x17e>
 1c6:	e3bff0ef          	jal	0 <memdump>
    example.ptr = "hello";
 1ca:	00001797          	auipc	a5,0x1
 1ce:	9c678793          	addi	a5,a5,-1594 # b90 <malloc+0x186>
 1d2:	dcf43823          	sd	a5,-560(s0)
    example.num1 = 1819438967;
 1d6:	6c7277b7          	lui	a5,0x6c727
 1da:	f7778793          	addi	a5,a5,-137 # 6c726f77 <base+0x6c724f67>
 1de:	dcf42c23          	sw	a5,-552(s0)
    example.num2 = 100;
 1e2:	06400793          	li	a5,100
 1e6:	dcf41e23          	sh	a5,-548(s0)
    example.byte = 'z';
 1ea:	07a00793          	li	a5,122
 1ee:	dcf40f23          	sb	a5,-546(s0)
    strcpy(example.bytes, "xyzzy");
 1f2:	00001597          	auipc	a1,0x1
 1f6:	9a658593          	addi	a1,a1,-1626 # b98 <malloc+0x18e>
 1fa:	ddf40513          	addi	a0,s0,-545
 1fe:	0a0000ef          	jal	29e <strcpy>
    printf("Example 4:\n");
 202:	00001517          	auipc	a0,0x1
 206:	99e50513          	addi	a0,a0,-1634 # ba0 <malloc+0x196>
 20a:	74c000ef          	jal	956 <printf>
    memdump("pihcS", (char*) &example);
 20e:	dd040593          	addi	a1,s0,-560
 212:	00001517          	auipc	a0,0x1
 216:	99e50513          	addi	a0,a0,-1634 # bb0 <malloc+0x1a6>
 21a:	de7ff0ef          	jal	0 <memdump>
    printf("Example 5:\n");
 21e:	00001517          	auipc	a0,0x1
 222:	99a50513          	addi	a0,a0,-1638 # bb8 <malloc+0x1ae>
 226:	730000ef          	jal	956 <printf>
    memdump("sccccc", (char*) &example);
 22a:	dd040593          	addi	a1,s0,-560
 22e:	00001517          	auipc	a0,0x1
 232:	99a50513          	addi	a0,a0,-1638 # bc8 <malloc+0x1be>
 236:	dcbff0ef          	jal	0 <memdump>
 23a:	a0b1                	j	286 <main+0x170>
    memset(data, '\0', sizeof(data));
 23c:	20000613          	li	a2,512
 240:	4581                	li	a1,0
 242:	dd040513          	addi	a0,s0,-560
 246:	0ca000ef          	jal	310 <memset>
    int n = 0;
 24a:	4481                	li	s1,0
    while(n < sizeof(data)){
 24c:	4601                	li	a2,0
      int nn = read(0, data + n, sizeof(data) - n);
 24e:	20000993          	li	s3,512
    while(n < sizeof(data)){
 252:	1ff00a13          	li	s4,511
      int nn = read(0, data + n, sizeof(data) - n);
 256:	40c9863b          	subw	a2,s3,a2
 25a:	dd040793          	addi	a5,s0,-560
 25e:	009785b3          	add	a1,a5,s1
 262:	4501                	li	a0,0
 264:	2d6000ef          	jal	53a <read>
      if(nn <= 0)
 268:	00a05963          	blez	a0,27a <main+0x164>
      n += nn;
 26c:	0095063b          	addw	a2,a0,s1
 270:	0006049b          	sext.w	s1,a2
    while(n < sizeof(data)){
 274:	8626                	mv	a2,s1
 276:	fe9a70e3          	bgeu	s4,s1,256 <main+0x140>
    memdump(argv[1], data);
 27a:	dd040593          	addi	a1,s0,-560
 27e:	00893503          	ld	a0,8(s2)
 282:	d7fff0ef          	jal	0 <memdump>
  exit(0);
 286:	4501                	li	a0,0
 288:	29a000ef          	jal	522 <exit>

000000000000028c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e406                	sd	ra,8(sp)
 290:	e022                	sd	s0,0(sp)
 292:	0800                	addi	s0,sp,16
  extern int main();
  main();
 294:	e83ff0ef          	jal	116 <main>
  exit(0);
 298:	4501                	li	a0,0
 29a:	288000ef          	jal	522 <exit>

000000000000029e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a4:	87aa                	mv	a5,a0
 2a6:	0585                	addi	a1,a1,1
 2a8:	0785                	addi	a5,a5,1
 2aa:	fff5c703          	lbu	a4,-1(a1)
 2ae:	fee78fa3          	sb	a4,-1(a5)
 2b2:	fb75                	bnez	a4,2a6 <strcpy+0x8>
    ;
  return os;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	cb91                	beqz	a5,2d8 <strcmp+0x1e>
 2c6:	0005c703          	lbu	a4,0(a1)
 2ca:	00f71763          	bne	a4,a5,2d8 <strcmp+0x1e>
    p++, q++;
 2ce:	0505                	addi	a0,a0,1
 2d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	fbe5                	bnez	a5,2c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2d8:	0005c503          	lbu	a0,0(a1)
}
 2dc:	40a7853b          	subw	a0,a5,a0
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret

00000000000002e6 <strlen>:

uint
strlen(const char *s)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	cf91                	beqz	a5,30c <strlen+0x26>
 2f2:	0505                	addi	a0,a0,1
 2f4:	87aa                	mv	a5,a0
 2f6:	86be                	mv	a3,a5
 2f8:	0785                	addi	a5,a5,1
 2fa:	fff7c703          	lbu	a4,-1(a5)
 2fe:	ff65                	bnez	a4,2f6 <strlen+0x10>
 300:	40a6853b          	subw	a0,a3,a0
 304:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  for(n = 0; s[n]; n++)
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <strlen+0x20>

0000000000000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 316:	ca19                	beqz	a2,32c <memset+0x1c>
 318:	87aa                	mv	a5,a0
 31a:	1602                	slli	a2,a2,0x20
 31c:	9201                	srli	a2,a2,0x20
 31e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 322:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 326:	0785                	addi	a5,a5,1
 328:	fee79de3          	bne	a5,a4,322 <memset+0x12>
  }
  return dst;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret

0000000000000332 <strchr>:

char*
strchr(const char *s, char c)
{
 332:	1141                	addi	sp,sp,-16
 334:	e422                	sd	s0,8(sp)
 336:	0800                	addi	s0,sp,16
  for(; *s; s++)
 338:	00054783          	lbu	a5,0(a0)
 33c:	cb99                	beqz	a5,352 <strchr+0x20>
    if(*s == c)
 33e:	00f58763          	beq	a1,a5,34c <strchr+0x1a>
  for(; *s; s++)
 342:	0505                	addi	a0,a0,1
 344:	00054783          	lbu	a5,0(a0)
 348:	fbfd                	bnez	a5,33e <strchr+0xc>
      return (char*)s;
  return 0;
 34a:	4501                	li	a0,0
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
  return 0;
 352:	4501                	li	a0,0
 354:	bfe5                	j	34c <strchr+0x1a>

0000000000000356 <gets>:

char*
gets(char *buf, int max)
{
 356:	711d                	addi	sp,sp,-96
 358:	ec86                	sd	ra,88(sp)
 35a:	e8a2                	sd	s0,80(sp)
 35c:	e4a6                	sd	s1,72(sp)
 35e:	e0ca                	sd	s2,64(sp)
 360:	fc4e                	sd	s3,56(sp)
 362:	f852                	sd	s4,48(sp)
 364:	f456                	sd	s5,40(sp)
 366:	f05a                	sd	s6,32(sp)
 368:	ec5e                	sd	s7,24(sp)
 36a:	1080                	addi	s0,sp,96
 36c:	8baa                	mv	s7,a0
 36e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 370:	892a                	mv	s2,a0
 372:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 374:	4aa9                	li	s5,10
 376:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 378:	89a6                	mv	s3,s1
 37a:	2485                	addiw	s1,s1,1
 37c:	0344d663          	bge	s1,s4,3a8 <gets+0x52>
    cc = read(0, &c, 1);
 380:	4605                	li	a2,1
 382:	faf40593          	addi	a1,s0,-81
 386:	4501                	li	a0,0
 388:	1b2000ef          	jal	53a <read>
    if(cc < 1)
 38c:	00a05e63          	blez	a0,3a8 <gets+0x52>
    buf[i++] = c;
 390:	faf44783          	lbu	a5,-81(s0)
 394:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 398:	01578763          	beq	a5,s5,3a6 <gets+0x50>
 39c:	0905                	addi	s2,s2,1
 39e:	fd679de3          	bne	a5,s6,378 <gets+0x22>
    buf[i++] = c;
 3a2:	89a6                	mv	s3,s1
 3a4:	a011                	j	3a8 <gets+0x52>
 3a6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3a8:	99de                	add	s3,s3,s7
 3aa:	00098023          	sb	zero,0(s3)
  return buf;
}
 3ae:	855e                	mv	a0,s7
 3b0:	60e6                	ld	ra,88(sp)
 3b2:	6446                	ld	s0,80(sp)
 3b4:	64a6                	ld	s1,72(sp)
 3b6:	6906                	ld	s2,64(sp)
 3b8:	79e2                	ld	s3,56(sp)
 3ba:	7a42                	ld	s4,48(sp)
 3bc:	7aa2                	ld	s5,40(sp)
 3be:	7b02                	ld	s6,32(sp)
 3c0:	6be2                	ld	s7,24(sp)
 3c2:	6125                	addi	sp,sp,96
 3c4:	8082                	ret

00000000000003c6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	e04a                	sd	s2,0(sp)
 3ce:	1000                	addi	s0,sp,32
 3d0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d2:	4581                	li	a1,0
 3d4:	18e000ef          	jal	562 <open>
  if(fd < 0)
 3d8:	02054263          	bltz	a0,3fc <stat+0x36>
 3dc:	e426                	sd	s1,8(sp)
 3de:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3e0:	85ca                	mv	a1,s2
 3e2:	198000ef          	jal	57a <fstat>
 3e6:	892a                	mv	s2,a0
  close(fd);
 3e8:	8526                	mv	a0,s1
 3ea:	160000ef          	jal	54a <close>
  return r;
 3ee:	64a2                	ld	s1,8(sp)
}
 3f0:	854a                	mv	a0,s2
 3f2:	60e2                	ld	ra,24(sp)
 3f4:	6442                	ld	s0,16(sp)
 3f6:	6902                	ld	s2,0(sp)
 3f8:	6105                	addi	sp,sp,32
 3fa:	8082                	ret
    return -1;
 3fc:	597d                	li	s2,-1
 3fe:	bfcd                	j	3f0 <stat+0x2a>

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 406:	00054683          	lbu	a3,0(a0)
 40a:	fd06879b          	addiw	a5,a3,-48
 40e:	0ff7f793          	zext.b	a5,a5
 412:	4625                	li	a2,9
 414:	02f66863          	bltu	a2,a5,444 <atoi+0x44>
 418:	872a                	mv	a4,a0
  n = 0;
 41a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41c:	0705                	addi	a4,a4,1
 41e:	0025179b          	slliw	a5,a0,0x2
 422:	9fa9                	addw	a5,a5,a0
 424:	0017979b          	slliw	a5,a5,0x1
 428:	9fb5                	addw	a5,a5,a3
 42a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 42e:	00074683          	lbu	a3,0(a4)
 432:	fd06879b          	addiw	a5,a3,-48
 436:	0ff7f793          	zext.b	a5,a5
 43a:	fef671e3          	bgeu	a2,a5,41c <atoi+0x1c>
  return n;
}
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	addi	sp,sp,16
 442:	8082                	ret
  n = 0;
 444:	4501                	li	a0,0
 446:	bfe5                	j	43e <atoi+0x3e>

0000000000000448 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 44e:	02b57463          	bgeu	a0,a1,476 <memmove+0x2e>
    while(n-- > 0)
 452:	00c05f63          	blez	a2,470 <memmove+0x28>
 456:	1602                	slli	a2,a2,0x20
 458:	9201                	srli	a2,a2,0x20
 45a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 45e:	872a                	mv	a4,a0
      *dst++ = *src++;
 460:	0585                	addi	a1,a1,1
 462:	0705                	addi	a4,a4,1
 464:	fff5c683          	lbu	a3,-1(a1)
 468:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46c:	fef71ae3          	bne	a4,a5,460 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 470:	6422                	ld	s0,8(sp)
 472:	0141                	addi	sp,sp,16
 474:	8082                	ret
    dst += n;
 476:	00c50733          	add	a4,a0,a2
    src += n;
 47a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 47c:	fec05ae3          	blez	a2,470 <memmove+0x28>
 480:	fff6079b          	addiw	a5,a2,-1
 484:	1782                	slli	a5,a5,0x20
 486:	9381                	srli	a5,a5,0x20
 488:	fff7c793          	not	a5,a5
 48c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 48e:	15fd                	addi	a1,a1,-1
 490:	177d                	addi	a4,a4,-1
 492:	0005c683          	lbu	a3,0(a1)
 496:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 49a:	fee79ae3          	bne	a5,a4,48e <memmove+0x46>
 49e:	bfc9                	j	470 <memmove+0x28>

00000000000004a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a0:	1141                	addi	sp,sp,-16
 4a2:	e422                	sd	s0,8(sp)
 4a4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4a6:	ca05                	beqz	a2,4d6 <memcmp+0x36>
 4a8:	fff6069b          	addiw	a3,a2,-1
 4ac:	1682                	slli	a3,a3,0x20
 4ae:	9281                	srli	a3,a3,0x20
 4b0:	0685                	addi	a3,a3,1
 4b2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4b4:	00054783          	lbu	a5,0(a0)
 4b8:	0005c703          	lbu	a4,0(a1)
 4bc:	00e79863          	bne	a5,a4,4cc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4c0:	0505                	addi	a0,a0,1
    p2++;
 4c2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4c4:	fed518e3          	bne	a0,a3,4b4 <memcmp+0x14>
  }
  return 0;
 4c8:	4501                	li	a0,0
 4ca:	a019                	j	4d0 <memcmp+0x30>
      return *p1 - *p2;
 4cc:	40e7853b          	subw	a0,a5,a4
}
 4d0:	6422                	ld	s0,8(sp)
 4d2:	0141                	addi	sp,sp,16
 4d4:	8082                	ret
  return 0;
 4d6:	4501                	li	a0,0
 4d8:	bfe5                	j	4d0 <memcmp+0x30>

00000000000004da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4da:	1141                	addi	sp,sp,-16
 4dc:	e406                	sd	ra,8(sp)
 4de:	e022                	sd	s0,0(sp)
 4e0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e2:	f67ff0ef          	jal	448 <memmove>
}
 4e6:	60a2                	ld	ra,8(sp)
 4e8:	6402                	ld	s0,0(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret

00000000000004ee <sbrk>:

char *
sbrk(int n) {
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e406                	sd	ra,8(sp)
 4f2:	e022                	sd	s0,0(sp)
 4f4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4f6:	4585                	li	a1,1
 4f8:	0b2000ef          	jal	5aa <sys_sbrk>
}
 4fc:	60a2                	ld	ra,8(sp)
 4fe:	6402                	ld	s0,0(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret

0000000000000504 <sbrklazy>:

char *
sbrklazy(int n) {
 504:	1141                	addi	sp,sp,-16
 506:	e406                	sd	ra,8(sp)
 508:	e022                	sd	s0,0(sp)
 50a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 50c:	4589                	li	a1,2
 50e:	09c000ef          	jal	5aa <sys_sbrk>
}
 512:	60a2                	ld	ra,8(sp)
 514:	6402                	ld	s0,0(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret

000000000000051a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 51a:	4885                	li	a7,1
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <exit>:
.global exit
exit:
 li a7, SYS_exit
 522:	4889                	li	a7,2
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <wait>:
.global wait
wait:
 li a7, SYS_wait
 52a:	488d                	li	a7,3
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 532:	4891                	li	a7,4
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <read>:
.global read
read:
 li a7, SYS_read
 53a:	4895                	li	a7,5
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <write>:
.global write
write:
 li a7, SYS_write
 542:	48c1                	li	a7,16
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <close>:
.global close
close:
 li a7, SYS_close
 54a:	48d5                	li	a7,21
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <kill>:
.global kill
kill:
 li a7, SYS_kill
 552:	4899                	li	a7,6
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <exec>:
.global exec
exec:
 li a7, SYS_exec
 55a:	489d                	li	a7,7
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <open>:
.global open
open:
 li a7, SYS_open
 562:	48bd                	li	a7,15
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 56a:	48c5                	li	a7,17
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 572:	48c9                	li	a7,18
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 57a:	48a1                	li	a7,8
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <link>:
.global link
link:
 li a7, SYS_link
 582:	48cd                	li	a7,19
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 58a:	48d1                	li	a7,20
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 592:	48a5                	li	a7,9
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <dup>:
.global dup
dup:
 li a7, SYS_dup
 59a:	48a9                	li	a7,10
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a2:	48ad                	li	a7,11
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5aa:	48b1                	li	a7,12
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5b2:	48b5                	li	a7,13
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ba:	48b9                	li	a7,14
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c2:	1101                	addi	sp,sp,-32
 5c4:	ec06                	sd	ra,24(sp)
 5c6:	e822                	sd	s0,16(sp)
 5c8:	1000                	addi	s0,sp,32
 5ca:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5ce:	4605                	li	a2,1
 5d0:	fef40593          	addi	a1,s0,-17
 5d4:	f6fff0ef          	jal	542 <write>
}
 5d8:	60e2                	ld	ra,24(sp)
 5da:	6442                	ld	s0,16(sp)
 5dc:	6105                	addi	sp,sp,32
 5de:	8082                	ret

00000000000005e0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5e0:	715d                	addi	sp,sp,-80
 5e2:	e486                	sd	ra,72(sp)
 5e4:	e0a2                	sd	s0,64(sp)
 5e6:	fc26                	sd	s1,56(sp)
 5e8:	0880                	addi	s0,sp,80
 5ea:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ec:	c299                	beqz	a3,5f2 <printint+0x12>
 5ee:	0805c963          	bltz	a1,680 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f2:	2581                	sext.w	a1,a1
  neg = 0;
 5f4:	4881                	li	a7,0
 5f6:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 5fa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5fc:	2601                	sext.w	a2,a2
 5fe:	00000517          	auipc	a0,0x0
 602:	5fa50513          	addi	a0,a0,1530 # bf8 <digits>
 606:	883a                	mv	a6,a4
 608:	2705                	addiw	a4,a4,1
 60a:	02c5f7bb          	remuw	a5,a1,a2
 60e:	1782                	slli	a5,a5,0x20
 610:	9381                	srli	a5,a5,0x20
 612:	97aa                	add	a5,a5,a0
 614:	0007c783          	lbu	a5,0(a5)
 618:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 61c:	0005879b          	sext.w	a5,a1
 620:	02c5d5bb          	divuw	a1,a1,a2
 624:	0685                	addi	a3,a3,1
 626:	fec7f0e3          	bgeu	a5,a2,606 <printint+0x26>
  if(neg)
 62a:	00088c63          	beqz	a7,642 <printint+0x62>
    buf[i++] = '-';
 62e:	fd070793          	addi	a5,a4,-48
 632:	00878733          	add	a4,a5,s0
 636:	02d00793          	li	a5,45
 63a:	fef70423          	sb	a5,-24(a4)
 63e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 642:	02e05a63          	blez	a4,676 <printint+0x96>
 646:	f84a                	sd	s2,48(sp)
 648:	f44e                	sd	s3,40(sp)
 64a:	fb840793          	addi	a5,s0,-72
 64e:	00e78933          	add	s2,a5,a4
 652:	fff78993          	addi	s3,a5,-1
 656:	99ba                	add	s3,s3,a4
 658:	377d                	addiw	a4,a4,-1
 65a:	1702                	slli	a4,a4,0x20
 65c:	9301                	srli	a4,a4,0x20
 65e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 662:	fff94583          	lbu	a1,-1(s2)
 666:	8526                	mv	a0,s1
 668:	f5bff0ef          	jal	5c2 <putc>
  while(--i >= 0)
 66c:	197d                	addi	s2,s2,-1
 66e:	ff391ae3          	bne	s2,s3,662 <printint+0x82>
 672:	7942                	ld	s2,48(sp)
 674:	79a2                	ld	s3,40(sp)
}
 676:	60a6                	ld	ra,72(sp)
 678:	6406                	ld	s0,64(sp)
 67a:	74e2                	ld	s1,56(sp)
 67c:	6161                	addi	sp,sp,80
 67e:	8082                	ret
    x = -xx;
 680:	40b005bb          	negw	a1,a1
    neg = 1;
 684:	4885                	li	a7,1
    x = -xx;
 686:	bf85                	j	5f6 <printint+0x16>

0000000000000688 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 688:	711d                	addi	sp,sp,-96
 68a:	ec86                	sd	ra,88(sp)
 68c:	e8a2                	sd	s0,80(sp)
 68e:	e0ca                	sd	s2,64(sp)
 690:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 692:	0005c903          	lbu	s2,0(a1)
 696:	28090663          	beqz	s2,922 <vprintf+0x29a>
 69a:	e4a6                	sd	s1,72(sp)
 69c:	fc4e                	sd	s3,56(sp)
 69e:	f852                	sd	s4,48(sp)
 6a0:	f456                	sd	s5,40(sp)
 6a2:	f05a                	sd	s6,32(sp)
 6a4:	ec5e                	sd	s7,24(sp)
 6a6:	e862                	sd	s8,16(sp)
 6a8:	e466                	sd	s9,8(sp)
 6aa:	8b2a                	mv	s6,a0
 6ac:	8a2e                	mv	s4,a1
 6ae:	8bb2                	mv	s7,a2
  state = 0;
 6b0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6b2:	4481                	li	s1,0
 6b4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6b6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6ba:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6be:	06c00c93          	li	s9,108
 6c2:	a005                	j	6e2 <vprintf+0x5a>
        putc(fd, c0);
 6c4:	85ca                	mv	a1,s2
 6c6:	855a                	mv	a0,s6
 6c8:	efbff0ef          	jal	5c2 <putc>
 6cc:	a019                	j	6d2 <vprintf+0x4a>
    } else if(state == '%'){
 6ce:	03598263          	beq	s3,s5,6f2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 6d2:	2485                	addiw	s1,s1,1
 6d4:	8726                	mv	a4,s1
 6d6:	009a07b3          	add	a5,s4,s1
 6da:	0007c903          	lbu	s2,0(a5)
 6de:	22090a63          	beqz	s2,912 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 6e2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6e6:	fe0994e3          	bnez	s3,6ce <vprintf+0x46>
      if(c0 == '%'){
 6ea:	fd579de3          	bne	a5,s5,6c4 <vprintf+0x3c>
        state = '%';
 6ee:	89be                	mv	s3,a5
 6f0:	b7cd                	j	6d2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6f2:	00ea06b3          	add	a3,s4,a4
 6f6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6fa:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6fc:	c681                	beqz	a3,704 <vprintf+0x7c>
 6fe:	9752                	add	a4,a4,s4
 700:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 704:	05878363          	beq	a5,s8,74a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 708:	05978d63          	beq	a5,s9,762 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 70c:	07500713          	li	a4,117
 710:	0ee78763          	beq	a5,a4,7fe <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 714:	07800713          	li	a4,120
 718:	12e78963          	beq	a5,a4,84a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 71c:	07000713          	li	a4,112
 720:	14e78e63          	beq	a5,a4,87c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 724:	06300713          	li	a4,99
 728:	18e78e63          	beq	a5,a4,8c4 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 72c:	07300713          	li	a4,115
 730:	1ae78463          	beq	a5,a4,8d8 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 734:	02500713          	li	a4,37
 738:	04e79563          	bne	a5,a4,782 <vprintf+0xfa>
        putc(fd, '%');
 73c:	02500593          	li	a1,37
 740:	855a                	mv	a0,s6
 742:	e81ff0ef          	jal	5c2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 746:	4981                	li	s3,0
 748:	b769                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 74a:	008b8913          	addi	s2,s7,8
 74e:	4685                	li	a3,1
 750:	4629                	li	a2,10
 752:	000ba583          	lw	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	e89ff0ef          	jal	5e0 <printint>
 75c:	8bca                	mv	s7,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	bf8d                	j	6d2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 762:	06400793          	li	a5,100
 766:	02f68963          	beq	a3,a5,798 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 76a:	06c00793          	li	a5,108
 76e:	04f68263          	beq	a3,a5,7b2 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 772:	07500793          	li	a5,117
 776:	0af68063          	beq	a3,a5,816 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 77a:	07800793          	li	a5,120
 77e:	0ef68263          	beq	a3,a5,862 <vprintf+0x1da>
        putc(fd, '%');
 782:	02500593          	li	a1,37
 786:	855a                	mv	a0,s6
 788:	e3bff0ef          	jal	5c2 <putc>
        putc(fd, c0);
 78c:	85ca                	mv	a1,s2
 78e:	855a                	mv	a0,s6
 790:	e33ff0ef          	jal	5c2 <putc>
      state = 0;
 794:	4981                	li	s3,0
 796:	bf35                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 798:	008b8913          	addi	s2,s7,8
 79c:	4685                	li	a3,1
 79e:	4629                	li	a2,10
 7a0:	000bb583          	ld	a1,0(s7)
 7a4:	855a                	mv	a0,s6
 7a6:	e3bff0ef          	jal	5e0 <printint>
        i += 1;
 7aa:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ac:	8bca                	mv	s7,s2
      state = 0;
 7ae:	4981                	li	s3,0
        i += 1;
 7b0:	b70d                	j	6d2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7b2:	06400793          	li	a5,100
 7b6:	02f60763          	beq	a2,a5,7e4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7ba:	07500793          	li	a5,117
 7be:	06f60963          	beq	a2,a5,830 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7c2:	07800793          	li	a5,120
 7c6:	faf61ee3          	bne	a2,a5,782 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ca:	008b8913          	addi	s2,s7,8
 7ce:	4681                	li	a3,0
 7d0:	4641                	li	a2,16
 7d2:	000bb583          	ld	a1,0(s7)
 7d6:	855a                	mv	a0,s6
 7d8:	e09ff0ef          	jal	5e0 <printint>
        i += 2;
 7dc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7de:	8bca                	mv	s7,s2
      state = 0;
 7e0:	4981                	li	s3,0
        i += 2;
 7e2:	bdc5                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7e4:	008b8913          	addi	s2,s7,8
 7e8:	4685                	li	a3,1
 7ea:	4629                	li	a2,10
 7ec:	000bb583          	ld	a1,0(s7)
 7f0:	855a                	mv	a0,s6
 7f2:	defff0ef          	jal	5e0 <printint>
        i += 2;
 7f6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f8:	8bca                	mv	s7,s2
      state = 0;
 7fa:	4981                	li	s3,0
        i += 2;
 7fc:	bdd9                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7fe:	008b8913          	addi	s2,s7,8
 802:	4681                	li	a3,0
 804:	4629                	li	a2,10
 806:	000be583          	lwu	a1,0(s7)
 80a:	855a                	mv	a0,s6
 80c:	dd5ff0ef          	jal	5e0 <printint>
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	bd7d                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 816:	008b8913          	addi	s2,s7,8
 81a:	4681                	li	a3,0
 81c:	4629                	li	a2,10
 81e:	000bb583          	ld	a1,0(s7)
 822:	855a                	mv	a0,s6
 824:	dbdff0ef          	jal	5e0 <printint>
        i += 1;
 828:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 82a:	8bca                	mv	s7,s2
      state = 0;
 82c:	4981                	li	s3,0
        i += 1;
 82e:	b555                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 830:	008b8913          	addi	s2,s7,8
 834:	4681                	li	a3,0
 836:	4629                	li	a2,10
 838:	000bb583          	ld	a1,0(s7)
 83c:	855a                	mv	a0,s6
 83e:	da3ff0ef          	jal	5e0 <printint>
        i += 2;
 842:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 844:	8bca                	mv	s7,s2
      state = 0;
 846:	4981                	li	s3,0
        i += 2;
 848:	b569                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 84a:	008b8913          	addi	s2,s7,8
 84e:	4681                	li	a3,0
 850:	4641                	li	a2,16
 852:	000be583          	lwu	a1,0(s7)
 856:	855a                	mv	a0,s6
 858:	d89ff0ef          	jal	5e0 <printint>
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
 860:	bd8d                	j	6d2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 862:	008b8913          	addi	s2,s7,8
 866:	4681                	li	a3,0
 868:	4641                	li	a2,16
 86a:	000bb583          	ld	a1,0(s7)
 86e:	855a                	mv	a0,s6
 870:	d71ff0ef          	jal	5e0 <printint>
        i += 1;
 874:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 876:	8bca                	mv	s7,s2
      state = 0;
 878:	4981                	li	s3,0
        i += 1;
 87a:	bda1                	j	6d2 <vprintf+0x4a>
 87c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 87e:	008b8d13          	addi	s10,s7,8
 882:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 886:	03000593          	li	a1,48
 88a:	855a                	mv	a0,s6
 88c:	d37ff0ef          	jal	5c2 <putc>
  putc(fd, 'x');
 890:	07800593          	li	a1,120
 894:	855a                	mv	a0,s6
 896:	d2dff0ef          	jal	5c2 <putc>
 89a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 89c:	00000b97          	auipc	s7,0x0
 8a0:	35cb8b93          	addi	s7,s7,860 # bf8 <digits>
 8a4:	03c9d793          	srli	a5,s3,0x3c
 8a8:	97de                	add	a5,a5,s7
 8aa:	0007c583          	lbu	a1,0(a5)
 8ae:	855a                	mv	a0,s6
 8b0:	d13ff0ef          	jal	5c2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8b4:	0992                	slli	s3,s3,0x4
 8b6:	397d                	addiw	s2,s2,-1
 8b8:	fe0916e3          	bnez	s2,8a4 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 8bc:	8bea                	mv	s7,s10
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	6d02                	ld	s10,0(sp)
 8c2:	bd01                	j	6d2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 8c4:	008b8913          	addi	s2,s7,8
 8c8:	000bc583          	lbu	a1,0(s7)
 8cc:	855a                	mv	a0,s6
 8ce:	cf5ff0ef          	jal	5c2 <putc>
 8d2:	8bca                	mv	s7,s2
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	bbf5                	j	6d2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 8d8:	008b8993          	addi	s3,s7,8
 8dc:	000bb903          	ld	s2,0(s7)
 8e0:	00090f63          	beqz	s2,8fe <vprintf+0x276>
        for(; *s; s++)
 8e4:	00094583          	lbu	a1,0(s2)
 8e8:	c195                	beqz	a1,90c <vprintf+0x284>
          putc(fd, *s);
 8ea:	855a                	mv	a0,s6
 8ec:	cd7ff0ef          	jal	5c2 <putc>
        for(; *s; s++)
 8f0:	0905                	addi	s2,s2,1
 8f2:	00094583          	lbu	a1,0(s2)
 8f6:	f9f5                	bnez	a1,8ea <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8f8:	8bce                	mv	s7,s3
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	bbd9                	j	6d2 <vprintf+0x4a>
          s = "(null)";
 8fe:	00000917          	auipc	s2,0x0
 902:	2f290913          	addi	s2,s2,754 # bf0 <malloc+0x1e6>
        for(; *s; s++)
 906:	02800593          	li	a1,40
 90a:	b7c5                	j	8ea <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 90c:	8bce                	mv	s7,s3
      state = 0;
 90e:	4981                	li	s3,0
 910:	b3c9                	j	6d2 <vprintf+0x4a>
 912:	64a6                	ld	s1,72(sp)
 914:	79e2                	ld	s3,56(sp)
 916:	7a42                	ld	s4,48(sp)
 918:	7aa2                	ld	s5,40(sp)
 91a:	7b02                	ld	s6,32(sp)
 91c:	6be2                	ld	s7,24(sp)
 91e:	6c42                	ld	s8,16(sp)
 920:	6ca2                	ld	s9,8(sp)
    }
  }
}
 922:	60e6                	ld	ra,88(sp)
 924:	6446                	ld	s0,80(sp)
 926:	6906                	ld	s2,64(sp)
 928:	6125                	addi	sp,sp,96
 92a:	8082                	ret

000000000000092c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 92c:	715d                	addi	sp,sp,-80
 92e:	ec06                	sd	ra,24(sp)
 930:	e822                	sd	s0,16(sp)
 932:	1000                	addi	s0,sp,32
 934:	e010                	sd	a2,0(s0)
 936:	e414                	sd	a3,8(s0)
 938:	e818                	sd	a4,16(s0)
 93a:	ec1c                	sd	a5,24(s0)
 93c:	03043023          	sd	a6,32(s0)
 940:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 944:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 948:	8622                	mv	a2,s0
 94a:	d3fff0ef          	jal	688 <vprintf>
}
 94e:	60e2                	ld	ra,24(sp)
 950:	6442                	ld	s0,16(sp)
 952:	6161                	addi	sp,sp,80
 954:	8082                	ret

0000000000000956 <printf>:

void
printf(const char *fmt, ...)
{
 956:	711d                	addi	sp,sp,-96
 958:	ec06                	sd	ra,24(sp)
 95a:	e822                	sd	s0,16(sp)
 95c:	1000                	addi	s0,sp,32
 95e:	e40c                	sd	a1,8(s0)
 960:	e810                	sd	a2,16(s0)
 962:	ec14                	sd	a3,24(s0)
 964:	f018                	sd	a4,32(s0)
 966:	f41c                	sd	a5,40(s0)
 968:	03043823          	sd	a6,48(s0)
 96c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 970:	00840613          	addi	a2,s0,8
 974:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 978:	85aa                	mv	a1,a0
 97a:	4505                	li	a0,1
 97c:	d0dff0ef          	jal	688 <vprintf>
}
 980:	60e2                	ld	ra,24(sp)
 982:	6442                	ld	s0,16(sp)
 984:	6125                	addi	sp,sp,96
 986:	8082                	ret

0000000000000988 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 988:	1141                	addi	sp,sp,-16
 98a:	e422                	sd	s0,8(sp)
 98c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 98e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 992:	00001797          	auipc	a5,0x1
 996:	66e7b783          	ld	a5,1646(a5) # 2000 <freep>
 99a:	a02d                	j	9c4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 99c:	4618                	lw	a4,8(a2)
 99e:	9f2d                	addw	a4,a4,a1
 9a0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a4:	6398                	ld	a4,0(a5)
 9a6:	6310                	ld	a2,0(a4)
 9a8:	a83d                	j	9e6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9aa:	ff852703          	lw	a4,-8(a0)
 9ae:	9f31                	addw	a4,a4,a2
 9b0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9b2:	ff053683          	ld	a3,-16(a0)
 9b6:	a091                	j	9fa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b8:	6398                	ld	a4,0(a5)
 9ba:	00e7e463          	bltu	a5,a4,9c2 <free+0x3a>
 9be:	00e6ea63          	bltu	a3,a4,9d2 <free+0x4a>
{
 9c2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c4:	fed7fae3          	bgeu	a5,a3,9b8 <free+0x30>
 9c8:	6398                	ld	a4,0(a5)
 9ca:	00e6e463          	bltu	a3,a4,9d2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ce:	fee7eae3          	bltu	a5,a4,9c2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9d2:	ff852583          	lw	a1,-8(a0)
 9d6:	6390                	ld	a2,0(a5)
 9d8:	02059813          	slli	a6,a1,0x20
 9dc:	01c85713          	srli	a4,a6,0x1c
 9e0:	9736                	add	a4,a4,a3
 9e2:	fae60de3          	beq	a2,a4,99c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9e6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ea:	4790                	lw	a2,8(a5)
 9ec:	02061593          	slli	a1,a2,0x20
 9f0:	01c5d713          	srli	a4,a1,0x1c
 9f4:	973e                	add	a4,a4,a5
 9f6:	fae68ae3          	beq	a3,a4,9aa <free+0x22>
    p->s.ptr = bp->s.ptr;
 9fa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9fc:	00001717          	auipc	a4,0x1
 a00:	60f73223          	sd	a5,1540(a4) # 2000 <freep>
}
 a04:	6422                	ld	s0,8(sp)
 a06:	0141                	addi	sp,sp,16
 a08:	8082                	ret

0000000000000a0a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a0a:	7139                	addi	sp,sp,-64
 a0c:	fc06                	sd	ra,56(sp)
 a0e:	f822                	sd	s0,48(sp)
 a10:	f426                	sd	s1,40(sp)
 a12:	ec4e                	sd	s3,24(sp)
 a14:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a16:	02051493          	slli	s1,a0,0x20
 a1a:	9081                	srli	s1,s1,0x20
 a1c:	04bd                	addi	s1,s1,15
 a1e:	8091                	srli	s1,s1,0x4
 a20:	0014899b          	addiw	s3,s1,1
 a24:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a26:	00001517          	auipc	a0,0x1
 a2a:	5da53503          	ld	a0,1498(a0) # 2000 <freep>
 a2e:	c915                	beqz	a0,a62 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a30:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a32:	4798                	lw	a4,8(a5)
 a34:	08977a63          	bgeu	a4,s1,ac8 <malloc+0xbe>
 a38:	f04a                	sd	s2,32(sp)
 a3a:	e852                	sd	s4,16(sp)
 a3c:	e456                	sd	s5,8(sp)
 a3e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a40:	8a4e                	mv	s4,s3
 a42:	0009871b          	sext.w	a4,s3
 a46:	6685                	lui	a3,0x1
 a48:	00d77363          	bgeu	a4,a3,a4e <malloc+0x44>
 a4c:	6a05                	lui	s4,0x1
 a4e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a52:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a56:	00001917          	auipc	s2,0x1
 a5a:	5aa90913          	addi	s2,s2,1450 # 2000 <freep>
  if(p == SBRK_ERROR)
 a5e:	5afd                	li	s5,-1
 a60:	a081                	j	aa0 <malloc+0x96>
 a62:	f04a                	sd	s2,32(sp)
 a64:	e852                	sd	s4,16(sp)
 a66:	e456                	sd	s5,8(sp)
 a68:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a6a:	00001797          	auipc	a5,0x1
 a6e:	5a678793          	addi	a5,a5,1446 # 2010 <base>
 a72:	00001717          	auipc	a4,0x1
 a76:	58f73723          	sd	a5,1422(a4) # 2000 <freep>
 a7a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a7c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a80:	b7c1                	j	a40 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a82:	6398                	ld	a4,0(a5)
 a84:	e118                	sd	a4,0(a0)
 a86:	a8a9                	j	ae0 <malloc+0xd6>
  hp->s.size = nu;
 a88:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a8c:	0541                	addi	a0,a0,16
 a8e:	efbff0ef          	jal	988 <free>
  return freep;
 a92:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a96:	c12d                	beqz	a0,af8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a98:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9a:	4798                	lw	a4,8(a5)
 a9c:	02977263          	bgeu	a4,s1,ac0 <malloc+0xb6>
    if(p == freep)
 aa0:	00093703          	ld	a4,0(s2)
 aa4:	853e                	mv	a0,a5
 aa6:	fef719e3          	bne	a4,a5,a98 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 aaa:	8552                	mv	a0,s4
 aac:	a43ff0ef          	jal	4ee <sbrk>
  if(p == SBRK_ERROR)
 ab0:	fd551ce3          	bne	a0,s5,a88 <malloc+0x7e>
        return 0;
 ab4:	4501                	li	a0,0
 ab6:	7902                	ld	s2,32(sp)
 ab8:	6a42                	ld	s4,16(sp)
 aba:	6aa2                	ld	s5,8(sp)
 abc:	6b02                	ld	s6,0(sp)
 abe:	a03d                	j	aec <malloc+0xe2>
 ac0:	7902                	ld	s2,32(sp)
 ac2:	6a42                	ld	s4,16(sp)
 ac4:	6aa2                	ld	s5,8(sp)
 ac6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ac8:	fae48de3          	beq	s1,a4,a82 <malloc+0x78>
        p->s.size -= nunits;
 acc:	4137073b          	subw	a4,a4,s3
 ad0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ad2:	02071693          	slli	a3,a4,0x20
 ad6:	01c6d713          	srli	a4,a3,0x1c
 ada:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 adc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ae0:	00001717          	auipc	a4,0x1
 ae4:	52a73023          	sd	a0,1312(a4) # 2000 <freep>
      return (void*)(p + 1);
 ae8:	01078513          	addi	a0,a5,16
  }
}
 aec:	70e2                	ld	ra,56(sp)
 aee:	7442                	ld	s0,48(sp)
 af0:	74a2                	ld	s1,40(sp)
 af2:	69e2                	ld	s3,24(sp)
 af4:	6121                	addi	sp,sp,64
 af6:	8082                	ret
 af8:	7902                	ld	s2,32(sp)
 afa:	6a42                	ld	s4,16(sp)
 afc:	6aa2                	ld	s5,8(sp)
 afe:	6b02                	ld	s6,0(sp)
 b00:	b7f5                	j	aec <malloc+0xe2>
