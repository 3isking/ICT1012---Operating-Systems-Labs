
user/_memdump:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <hexval>:
  }
  exit(0);
}

int hexval(char c)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  if(c >= '0' && c <= '9') return c - '0';
   6:	fd05079b          	addiw	a5,a0,-48
   a:	0ff7f793          	zext.b	a5,a5
   e:	4725                	li	a4,9
  10:	02f77563          	bgeu	a4,a5,3a <hexval+0x3a>
  if(c >= 'a' && c <= 'f') return c - 'a' + 10;
  14:	f9f5079b          	addiw	a5,a0,-97
  18:	0ff7f793          	zext.b	a5,a5
  1c:	4715                	li	a4,5
  1e:	02f77163          	bgeu	a4,a5,40 <hexval+0x40>
  if(c >= 'A' && c <= 'F') return c - 'A' + 10;
  22:	fbf5079b          	addiw	a5,a0,-65
  26:	0ff7f793          	zext.b	a5,a5
  2a:	4715                	li	a4,5
  2c:	00f76d63          	bltu	a4,a5,46 <hexval+0x46>
  30:	fc95051b          	addiw	a0,a0,-55
return -1; // invalid character
}
  34:	6422                	ld	s0,8(sp)
  36:	0141                	addi	sp,sp,16
  38:	8082                	ret
  if(c >= '0' && c <= '9') return c - '0';
  3a:	fd05051b          	addiw	a0,a0,-48
  3e:	bfdd                	j	34 <hexval+0x34>
  if(c >= 'a' && c <= 'f') return c - 'a' + 10;
  40:	fa95051b          	addiw	a0,a0,-87
  44:	bfc5                	j	34 <hexval+0x34>
return -1; // invalid character
  46:	557d                	li	a0,-1
  48:	b7f5                	j	34 <hexval+0x34>

000000000000004a <memdump>:
  // Your code here.
  // Array Pointer
  char *p = data;

  // Loop through FMT
  for (int i = 0; fmt[i] != '\0'; i++) {
  4a:	00054783          	lbu	a5,0(a0)
  4e:	18078763          	beqz	a5,1dc <memdump+0x192>
{
  52:	711d                	addi	sp,sp,-96
  54:	ec86                	sd	ra,88(sp)
  56:	e8a2                	sd	s0,80(sp)
  58:	e4a6                	sd	s1,72(sp)
  5a:	e0ca                	sd	s2,64(sp)
  5c:	fc4e                	sd	s3,56(sp)
  5e:	f852                	sd	s4,48(sp)
  60:	f456                	sd	s5,40(sp)
  62:	f05a                	sd	s6,32(sp)
  64:	ec5e                	sd	s7,24(sp)
  66:	e862                	sd	s8,16(sp)
  68:	e466                	sd	s9,8(sp)
  6a:	e06a                	sd	s10,0(sp)
  6c:	1080                	addi	s0,sp,96
  6e:	84aa                	mv	s1,a0
  70:	892e                	mv	s2,a1

    // If FMT is i
    if (fmt[i] == 'i'){
  72:	06900b13          	li	s6,105
      int val = *(int *)p;
      printf("%d\n", val);
  76:	00001b97          	auipc	s7,0x1
  7a:	b6ab8b93          	addi	s7,s7,-1174 # be0 <malloc+0x106>
      p += 4;
    }

    //If FMT is p
    if (fmt[i] == 'p'){
  7e:	07000a93          	li	s5,112
       
      // Dont print High Byte is it is Empty
      if (hi == 0){
        printf("%x\n", lo);
      } else {
        printf("%x%x\n", hi, lo);
  82:	00001d17          	auipc	s10,0x1
  86:	b6ed0d13          	addi	s10,s10,-1170 # bf0 <malloc+0x116>
        printf("%x\n", lo);
  8a:	00001c97          	auipc	s9,0x1
  8e:	b5ec8c93          	addi	s9,s9,-1186 # be8 <malloc+0x10e>
      }
      p += 4;
    }

    //If FMT is h
    if (fmt[i] == 'h'){
  92:	06800a13          	li	s4,104
      printf("%d\n", val);
      p += 2;
    }

    //If FMT is c
    if (fmt[i] == 'c'){
  96:	06300993          	li	s3,99
      char val = *p;
      printf("%c\n", val);
  9a:	00001c17          	auipc	s8,0x1
  9e:	b5ec0c13          	addi	s8,s8,-1186 # bf8 <malloc+0x11e>
  a2:	a891                	j	f6 <memdump+0xac>
      printf("%d\n", val);
  a4:	00092583          	lw	a1,0(s2)
  a8:	855e                	mv	a0,s7
  aa:	17d000ef          	jal	a26 <printf>
      p += 4;
  ae:	0911                	addi	s2,s2,4
  b0:	a0a9                	j	fa <memdump+0xb0>
        printf("%x%x\n", hi, lo);
  b2:	856a                	mv	a0,s10
  b4:	173000ef          	jal	a26 <printf>
      p += 4;
  b8:	0921                	addi	s2,s2,8
    if (fmt[i] == 'h'){
  ba:	0004c783          	lbu	a5,0(s1)
  be:	05478c63          	beq	a5,s4,116 <memdump+0xcc>
    if (fmt[i] == 'c'){
  c2:	0004c783          	lbu	a5,0(s1)
  c6:	05378f63          	beq	a5,s3,124 <memdump+0xda>
      p += 1;
    }

    //If FMT is s
    if (fmt[i] == 's'){
  ca:	0004c703          	lbu	a4,0(s1)
  ce:	07300793          	li	a5,115
  d2:	06f70063          	beq	a4,a5,132 <memdump+0xe8>
      printf("%s\n", val);
      p += 8;
    }

    //If FMT is s
    if (fmt[i] == 'S'){
  d6:	0004c703          	lbu	a4,0(s1)
  da:	05300793          	li	a5,83
  de:	06f70463          	beq	a4,a5,146 <memdump+0xfc>
      printf("%s\n", p);
      p += strlen(p) + 1;
    }

    //If FMT is q
    if (fmt[i] == 'q'){
  e2:	0004c703          	lbu	a4,0(s1)
  e6:	07100793          	li	a5,113
  ea:	06f70d63          	beq	a4,a5,164 <memdump+0x11a>
  for (int i = 0; fmt[i] != '\0'; i++) {
  ee:	0485                	addi	s1,s1,1
  f0:	0004c783          	lbu	a5,0(s1)
  f4:	c7f1                	beqz	a5,1c0 <memdump+0x176>
    if (fmt[i] == 'i'){
  f6:	fb6787e3          	beq	a5,s6,a4 <memdump+0x5a>
    if (fmt[i] == 'p'){
  fa:	0004c783          	lbu	a5,0(s1)
  fe:	fb579ee3          	bne	a5,s5,ba <memdump+0x70>
      int lo = *(int *)p;
 102:	00092603          	lw	a2,0(s2)
      int hi = *(int *)p;
 106:	00492583          	lw	a1,4(s2)
      if (hi == 0){
 10a:	f5c5                	bnez	a1,b2 <memdump+0x68>
        printf("%x\n", lo);
 10c:	85b2                	mv	a1,a2
 10e:	8566                	mv	a0,s9
 110:	117000ef          	jal	a26 <printf>
 114:	b755                	j	b8 <memdump+0x6e>
      printf("%d\n", val);
 116:	00091583          	lh	a1,0(s2)
 11a:	855e                	mv	a0,s7
 11c:	10b000ef          	jal	a26 <printf>
      p += 2;
 120:	0909                	addi	s2,s2,2
 122:	b745                	j	c2 <memdump+0x78>
      printf("%c\n", val);
 124:	00094583          	lbu	a1,0(s2)
 128:	8562                	mv	a0,s8
 12a:	0fd000ef          	jal	a26 <printf>
      p += 1;
 12e:	0905                	addi	s2,s2,1
 130:	bf69                	j	ca <memdump+0x80>
      printf("%s\n", val);
 132:	00093583          	ld	a1,0(s2)
 136:	00001517          	auipc	a0,0x1
 13a:	aca50513          	addi	a0,a0,-1334 # c00 <malloc+0x126>
 13e:	0e9000ef          	jal	a26 <printf>
      p += 8;
 142:	0921                	addi	s2,s2,8
 144:	bf49                	j	d6 <memdump+0x8c>
      printf("%s\n", p);
 146:	85ca                	mv	a1,s2
 148:	00001517          	auipc	a0,0x1
 14c:	ab850513          	addi	a0,a0,-1352 # c00 <malloc+0x126>
 150:	0d7000ef          	jal	a26 <printf>
      p += strlen(p) + 1;
 154:	854a                	mv	a0,s2
 156:	258000ef          	jal	3ae <strlen>
 15a:	2505                	addiw	a0,a0,1
 15c:	1502                	slli	a0,a0,0x20
 15e:	9101                	srli	a0,a0,0x20
 160:	992a                	add	s2,s2,a0
 162:	b741                	j	e2 <memdump+0x98>
 164:	89ca                	mv	s3,s2
 166:	0941                	addi	s2,s2,16

        // combine high and low nibbles into a byte
        char v = hi*16 + lo; // fill the missing code

        // printable only
        if(v >= 32 && v <= 126) // fill the missing values. Refer to the ASCII Table.
 168:	05e00a13          	li	s4,94
          printf("%c", v); // print printable ASCII
 16c:	00001a97          	auipc	s5,0x1
 170:	a9ca8a93          	addi	s5,s5,-1380 # c08 <malloc+0x12e>
 174:	a021                	j	17c <memdump+0x132>
      for (int j = 0; j < 16; j += 2){
 176:	0989                	addi	s3,s3,2
 178:	03298e63          	beq	s3,s2,1b4 <memdump+0x16a>
        int hi = hexval(p[j]); // high nibble of the byte
 17c:	0009c503          	lbu	a0,0(s3)
 180:	e81ff0ef          	jal	0 <hexval>
 184:	84aa                	mv	s1,a0
        if (hi < 0 || lo < 0)
 186:	fe0548e3          	bltz	a0,176 <memdump+0x12c>
        int lo = hexval(p[j+1]); //   fill the missing code
 18a:	0019c503          	lbu	a0,1(s3)
 18e:	e73ff0ef          	jal	0 <hexval>
        if (hi < 0 || lo < 0)
 192:	fe0542e3          	bltz	a0,176 <memdump+0x12c>
        char v = hi*16 + lo; // fill the missing code
 196:	0044959b          	slliw	a1,s1,0x4
 19a:	9da9                	addw	a1,a1,a0
 19c:	0ff5f593          	zext.b	a1,a1
        if(v >= 32 && v <= 126) // fill the missing values. Refer to the ASCII Table.
 1a0:	fe05879b          	addiw	a5,a1,-32
 1a4:	0ff7f793          	zext.b	a5,a5
 1a8:	fcfa67e3          	bltu	s4,a5,176 <memdump+0x12c>
          printf("%c", v); // print printable ASCII
 1ac:	8556                	mv	a0,s5
 1ae:	079000ef          	jal	a26 <printf>
 1b2:	b7d1                	j	176 <memdump+0x12c>
      }

      printf("\n");
 1b4:	00001517          	auipc	a0,0x1
 1b8:	a5c50513          	addi	a0,a0,-1444 # c10 <malloc+0x136>
 1bc:	06b000ef          	jal	a26 <printf>
      break;
    }

    
  }
}
 1c0:	60e6                	ld	ra,88(sp)
 1c2:	6446                	ld	s0,80(sp)
 1c4:	64a6                	ld	s1,72(sp)
 1c6:	6906                	ld	s2,64(sp)
 1c8:	79e2                	ld	s3,56(sp)
 1ca:	7a42                	ld	s4,48(sp)
 1cc:	7aa2                	ld	s5,40(sp)
 1ce:	7b02                	ld	s6,32(sp)
 1d0:	6be2                	ld	s7,24(sp)
 1d2:	6c42                	ld	s8,16(sp)
 1d4:	6ca2                	ld	s9,8(sp)
 1d6:	6d02                	ld	s10,0(sp)
 1d8:	6125                	addi	sp,sp,96
 1da:	8082                	ret
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	dc010113          	addi	sp,sp,-576
 1e2:	22113c23          	sd	ra,568(sp)
 1e6:	22813823          	sd	s0,560(sp)
 1ea:	22913423          	sd	s1,552(sp)
 1ee:	23213023          	sd	s2,544(sp)
 1f2:	21313c23          	sd	s3,536(sp)
 1f6:	21413823          	sd	s4,528(sp)
 1fa:	0480                	addi	s0,sp,576
  if(argc == 1){
 1fc:	4785                	li	a5,1
 1fe:	00f50f63          	beq	a0,a5,21c <main+0x3e>
 202:	892e                	mv	s2,a1
  } else if(argc == 2){
 204:	4789                	li	a5,2
 206:	0ef50f63          	beq	a0,a5,304 <main+0x126>
    printf("Usage: memdump [format]\n");
 20a:	00001517          	auipc	a0,0x1
 20e:	aae50513          	addi	a0,a0,-1362 # cb8 <malloc+0x1de>
 212:	015000ef          	jal	a26 <printf>
    exit(1);
 216:	4505                	li	a0,1
 218:	3d2000ef          	jal	5ea <exit>
    printf("Example 1:\n");
 21c:	00001517          	auipc	a0,0x1
 220:	9fc50513          	addi	a0,a0,-1540 # c18 <malloc+0x13e>
 224:	003000ef          	jal	a26 <printf>
    int a[2] = { 61810, 2025 };
 228:	67bd                	lui	a5,0xf
 22a:	17278793          	addi	a5,a5,370 # f172 <base+0xd162>
 22e:	dcf42023          	sw	a5,-576(s0)
 232:	7e900793          	li	a5,2025
 236:	dcf42223          	sw	a5,-572(s0)
    memdump("ii", (char*) a);
 23a:	dc040593          	addi	a1,s0,-576
 23e:	00001517          	auipc	a0,0x1
 242:	9ea50513          	addi	a0,a0,-1558 # c28 <malloc+0x14e>
 246:	e05ff0ef          	jal	4a <memdump>
    printf("Example 2:\n");
 24a:	00001517          	auipc	a0,0x1
 24e:	9e650513          	addi	a0,a0,-1562 # c30 <malloc+0x156>
 252:	7d4000ef          	jal	a26 <printf>
    memdump("S", "a string");
 256:	00001597          	auipc	a1,0x1
 25a:	9ea58593          	addi	a1,a1,-1558 # c40 <malloc+0x166>
 25e:	00001517          	auipc	a0,0x1
 262:	9f250513          	addi	a0,a0,-1550 # c50 <malloc+0x176>
 266:	de5ff0ef          	jal	4a <memdump>
    printf("Example 3:\n");
 26a:	00001517          	auipc	a0,0x1
 26e:	9ee50513          	addi	a0,a0,-1554 # c58 <malloc+0x17e>
 272:	7b4000ef          	jal	a26 <printf>
    char *s = "another";
 276:	00001797          	auipc	a5,0x1
 27a:	9f278793          	addi	a5,a5,-1550 # c68 <malloc+0x18e>
 27e:	dcf43423          	sd	a5,-568(s0)
    memdump("s", (char *) &s);
 282:	dc840593          	addi	a1,s0,-568
 286:	00001517          	auipc	a0,0x1
 28a:	9ea50513          	addi	a0,a0,-1558 # c70 <malloc+0x196>
 28e:	dbdff0ef          	jal	4a <memdump>
    example.ptr = "hello";
 292:	00001797          	auipc	a5,0x1
 296:	9e678793          	addi	a5,a5,-1562 # c78 <malloc+0x19e>
 29a:	dcf43823          	sd	a5,-560(s0)
    example.num1 = 1819438967;
 29e:	6c7277b7          	lui	a5,0x6c727
 2a2:	f7778793          	addi	a5,a5,-137 # 6c726f77 <base+0x6c724f67>
 2a6:	dcf42c23          	sw	a5,-552(s0)
    example.num2 = 100;
 2aa:	06400793          	li	a5,100
 2ae:	dcf41e23          	sh	a5,-548(s0)
    example.byte = 'z';
 2b2:	07a00793          	li	a5,122
 2b6:	dcf40f23          	sb	a5,-546(s0)
    strcpy(example.bytes, "xyzzy");
 2ba:	00001597          	auipc	a1,0x1
 2be:	9c658593          	addi	a1,a1,-1594 # c80 <malloc+0x1a6>
 2c2:	ddf40513          	addi	a0,s0,-545
 2c6:	0a0000ef          	jal	366 <strcpy>
    printf("Example 4:\n");
 2ca:	00001517          	auipc	a0,0x1
 2ce:	9be50513          	addi	a0,a0,-1602 # c88 <malloc+0x1ae>
 2d2:	754000ef          	jal	a26 <printf>
    memdump("pihcS", (char*) &example);
 2d6:	dd040593          	addi	a1,s0,-560
 2da:	00001517          	auipc	a0,0x1
 2de:	9be50513          	addi	a0,a0,-1602 # c98 <malloc+0x1be>
 2e2:	d69ff0ef          	jal	4a <memdump>
    printf("Example 5:\n");
 2e6:	00001517          	auipc	a0,0x1
 2ea:	9ba50513          	addi	a0,a0,-1606 # ca0 <malloc+0x1c6>
 2ee:	738000ef          	jal	a26 <printf>
    memdump("sccccc", (char*) &example);
 2f2:	dd040593          	addi	a1,s0,-560
 2f6:	00001517          	auipc	a0,0x1
 2fa:	9ba50513          	addi	a0,a0,-1606 # cb0 <malloc+0x1d6>
 2fe:	d4dff0ef          	jal	4a <memdump>
 302:	a0b1                	j	34e <main+0x170>
    memset(data, '\0', sizeof(data));
 304:	20000613          	li	a2,512
 308:	4581                	li	a1,0
 30a:	dd040513          	addi	a0,s0,-560
 30e:	0ca000ef          	jal	3d8 <memset>
    int n = 0;
 312:	4481                	li	s1,0
    while(n < sizeof(data)){
 314:	4601                	li	a2,0
      int nn = read(0, data + n, sizeof(data) - n);
 316:	20000993          	li	s3,512
    while(n < sizeof(data)){
 31a:	1ff00a13          	li	s4,511
      int nn = read(0, data + n, sizeof(data) - n);
 31e:	40c9863b          	subw	a2,s3,a2
 322:	dd040793          	addi	a5,s0,-560
 326:	009785b3          	add	a1,a5,s1
 32a:	4501                	li	a0,0
 32c:	2d6000ef          	jal	602 <read>
      if(nn <= 0)
 330:	00a05963          	blez	a0,342 <main+0x164>
      n += nn;
 334:	0095063b          	addw	a2,a0,s1
 338:	0006049b          	sext.w	s1,a2
    while(n < sizeof(data)){
 33c:	8626                	mv	a2,s1
 33e:	fe9a70e3          	bgeu	s4,s1,31e <main+0x140>
    memdump(argv[1], data);
 342:	dd040593          	addi	a1,s0,-560
 346:	00893503          	ld	a0,8(s2)
 34a:	d01ff0ef          	jal	4a <memdump>
  exit(0);
 34e:	4501                	li	a0,0
 350:	29a000ef          	jal	5ea <exit>

0000000000000354 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 354:	1141                	addi	sp,sp,-16
 356:	e406                	sd	ra,8(sp)
 358:	e022                	sd	s0,0(sp)
 35a:	0800                	addi	s0,sp,16
  extern int main();
  main();
 35c:	e83ff0ef          	jal	1de <main>
  exit(0);
 360:	4501                	li	a0,0
 362:	288000ef          	jal	5ea <exit>

0000000000000366 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 36c:	87aa                	mv	a5,a0
 36e:	0585                	addi	a1,a1,1
 370:	0785                	addi	a5,a5,1
 372:	fff5c703          	lbu	a4,-1(a1)
 376:	fee78fa3          	sb	a4,-1(a5)
 37a:	fb75                	bnez	a4,36e <strcpy+0x8>
    ;
  return os;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 388:	00054783          	lbu	a5,0(a0)
 38c:	cb91                	beqz	a5,3a0 <strcmp+0x1e>
 38e:	0005c703          	lbu	a4,0(a1)
 392:	00f71763          	bne	a4,a5,3a0 <strcmp+0x1e>
    p++, q++;
 396:	0505                	addi	a0,a0,1
 398:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 39a:	00054783          	lbu	a5,0(a0)
 39e:	fbe5                	bnez	a5,38e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3a0:	0005c503          	lbu	a0,0(a1)
}
 3a4:	40a7853b          	subw	a0,a5,a0
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <strlen>:

uint
strlen(const char *s)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3b4:	00054783          	lbu	a5,0(a0)
 3b8:	cf91                	beqz	a5,3d4 <strlen+0x26>
 3ba:	0505                	addi	a0,a0,1
 3bc:	87aa                	mv	a5,a0
 3be:	86be                	mv	a3,a5
 3c0:	0785                	addi	a5,a5,1
 3c2:	fff7c703          	lbu	a4,-1(a5)
 3c6:	ff65                	bnez	a4,3be <strlen+0x10>
 3c8:	40a6853b          	subw	a0,a3,a0
 3cc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
  for(n = 0; s[n]; n++)
 3d4:	4501                	li	a0,0
 3d6:	bfe5                	j	3ce <strlen+0x20>

00000000000003d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3de:	ca19                	beqz	a2,3f4 <memset+0x1c>
 3e0:	87aa                	mv	a5,a0
 3e2:	1602                	slli	a2,a2,0x20
 3e4:	9201                	srli	a2,a2,0x20
 3e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3ee:	0785                	addi	a5,a5,1
 3f0:	fee79de3          	bne	a5,a4,3ea <memset+0x12>
  }
  return dst;
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	addi	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <strchr>:

char*
strchr(const char *s, char c)
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 400:	00054783          	lbu	a5,0(a0)
 404:	cb99                	beqz	a5,41a <strchr+0x20>
    if(*s == c)
 406:	00f58763          	beq	a1,a5,414 <strchr+0x1a>
  for(; *s; s++)
 40a:	0505                	addi	a0,a0,1
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbfd                	bnez	a5,406 <strchr+0xc>
      return (char*)s;
  return 0;
 412:	4501                	li	a0,0
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
  return 0;
 41a:	4501                	li	a0,0
 41c:	bfe5                	j	414 <strchr+0x1a>

000000000000041e <gets>:

char*
gets(char *buf, int max)
{
 41e:	711d                	addi	sp,sp,-96
 420:	ec86                	sd	ra,88(sp)
 422:	e8a2                	sd	s0,80(sp)
 424:	e4a6                	sd	s1,72(sp)
 426:	e0ca                	sd	s2,64(sp)
 428:	fc4e                	sd	s3,56(sp)
 42a:	f852                	sd	s4,48(sp)
 42c:	f456                	sd	s5,40(sp)
 42e:	f05a                	sd	s6,32(sp)
 430:	ec5e                	sd	s7,24(sp)
 432:	1080                	addi	s0,sp,96
 434:	8baa                	mv	s7,a0
 436:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 438:	892a                	mv	s2,a0
 43a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 43c:	4aa9                	li	s5,10
 43e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 440:	89a6                	mv	s3,s1
 442:	2485                	addiw	s1,s1,1
 444:	0344d663          	bge	s1,s4,470 <gets+0x52>
    cc = read(0, &c, 1);
 448:	4605                	li	a2,1
 44a:	faf40593          	addi	a1,s0,-81
 44e:	4501                	li	a0,0
 450:	1b2000ef          	jal	602 <read>
    if(cc < 1)
 454:	00a05e63          	blez	a0,470 <gets+0x52>
    buf[i++] = c;
 458:	faf44783          	lbu	a5,-81(s0)
 45c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 460:	01578763          	beq	a5,s5,46e <gets+0x50>
 464:	0905                	addi	s2,s2,1
 466:	fd679de3          	bne	a5,s6,440 <gets+0x22>
    buf[i++] = c;
 46a:	89a6                	mv	s3,s1
 46c:	a011                	j	470 <gets+0x52>
 46e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 470:	99de                	add	s3,s3,s7
 472:	00098023          	sb	zero,0(s3)
  return buf;
}
 476:	855e                	mv	a0,s7
 478:	60e6                	ld	ra,88(sp)
 47a:	6446                	ld	s0,80(sp)
 47c:	64a6                	ld	s1,72(sp)
 47e:	6906                	ld	s2,64(sp)
 480:	79e2                	ld	s3,56(sp)
 482:	7a42                	ld	s4,48(sp)
 484:	7aa2                	ld	s5,40(sp)
 486:	7b02                	ld	s6,32(sp)
 488:	6be2                	ld	s7,24(sp)
 48a:	6125                	addi	sp,sp,96
 48c:	8082                	ret

000000000000048e <stat>:

int
stat(const char *n, struct stat *st)
{
 48e:	1101                	addi	sp,sp,-32
 490:	ec06                	sd	ra,24(sp)
 492:	e822                	sd	s0,16(sp)
 494:	e04a                	sd	s2,0(sp)
 496:	1000                	addi	s0,sp,32
 498:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 49a:	4581                	li	a1,0
 49c:	18e000ef          	jal	62a <open>
  if(fd < 0)
 4a0:	02054263          	bltz	a0,4c4 <stat+0x36>
 4a4:	e426                	sd	s1,8(sp)
 4a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4a8:	85ca                	mv	a1,s2
 4aa:	198000ef          	jal	642 <fstat>
 4ae:	892a                	mv	s2,a0
  close(fd);
 4b0:	8526                	mv	a0,s1
 4b2:	160000ef          	jal	612 <close>
  return r;
 4b6:	64a2                	ld	s1,8(sp)
}
 4b8:	854a                	mv	a0,s2
 4ba:	60e2                	ld	ra,24(sp)
 4bc:	6442                	ld	s0,16(sp)
 4be:	6902                	ld	s2,0(sp)
 4c0:	6105                	addi	sp,sp,32
 4c2:	8082                	ret
    return -1;
 4c4:	597d                	li	s2,-1
 4c6:	bfcd                	j	4b8 <stat+0x2a>

00000000000004c8 <atoi>:

int
atoi(const char *s)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ce:	00054683          	lbu	a3,0(a0)
 4d2:	fd06879b          	addiw	a5,a3,-48
 4d6:	0ff7f793          	zext.b	a5,a5
 4da:	4625                	li	a2,9
 4dc:	02f66863          	bltu	a2,a5,50c <atoi+0x44>
 4e0:	872a                	mv	a4,a0
  n = 0;
 4e2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4e4:	0705                	addi	a4,a4,1
 4e6:	0025179b          	slliw	a5,a0,0x2
 4ea:	9fa9                	addw	a5,a5,a0
 4ec:	0017979b          	slliw	a5,a5,0x1
 4f0:	9fb5                	addw	a5,a5,a3
 4f2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4f6:	00074683          	lbu	a3,0(a4)
 4fa:	fd06879b          	addiw	a5,a3,-48
 4fe:	0ff7f793          	zext.b	a5,a5
 502:	fef671e3          	bgeu	a2,a5,4e4 <atoi+0x1c>
  return n;
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret
  n = 0;
 50c:	4501                	li	a0,0
 50e:	bfe5                	j	506 <atoi+0x3e>

0000000000000510 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 510:	1141                	addi	sp,sp,-16
 512:	e422                	sd	s0,8(sp)
 514:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 516:	02b57463          	bgeu	a0,a1,53e <memmove+0x2e>
    while(n-- > 0)
 51a:	00c05f63          	blez	a2,538 <memmove+0x28>
 51e:	1602                	slli	a2,a2,0x20
 520:	9201                	srli	a2,a2,0x20
 522:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 526:	872a                	mv	a4,a0
      *dst++ = *src++;
 528:	0585                	addi	a1,a1,1
 52a:	0705                	addi	a4,a4,1
 52c:	fff5c683          	lbu	a3,-1(a1)
 530:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 534:	fef71ae3          	bne	a4,a5,528 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 538:	6422                	ld	s0,8(sp)
 53a:	0141                	addi	sp,sp,16
 53c:	8082                	ret
    dst += n;
 53e:	00c50733          	add	a4,a0,a2
    src += n;
 542:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 544:	fec05ae3          	blez	a2,538 <memmove+0x28>
 548:	fff6079b          	addiw	a5,a2,-1
 54c:	1782                	slli	a5,a5,0x20
 54e:	9381                	srli	a5,a5,0x20
 550:	fff7c793          	not	a5,a5
 554:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 556:	15fd                	addi	a1,a1,-1
 558:	177d                	addi	a4,a4,-1
 55a:	0005c683          	lbu	a3,0(a1)
 55e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 562:	fee79ae3          	bne	a5,a4,556 <memmove+0x46>
 566:	bfc9                	j	538 <memmove+0x28>

0000000000000568 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 568:	1141                	addi	sp,sp,-16
 56a:	e422                	sd	s0,8(sp)
 56c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 56e:	ca05                	beqz	a2,59e <memcmp+0x36>
 570:	fff6069b          	addiw	a3,a2,-1
 574:	1682                	slli	a3,a3,0x20
 576:	9281                	srli	a3,a3,0x20
 578:	0685                	addi	a3,a3,1
 57a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 57c:	00054783          	lbu	a5,0(a0)
 580:	0005c703          	lbu	a4,0(a1)
 584:	00e79863          	bne	a5,a4,594 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 588:	0505                	addi	a0,a0,1
    p2++;
 58a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 58c:	fed518e3          	bne	a0,a3,57c <memcmp+0x14>
  }
  return 0;
 590:	4501                	li	a0,0
 592:	a019                	j	598 <memcmp+0x30>
      return *p1 - *p2;
 594:	40e7853b          	subw	a0,a5,a4
}
 598:	6422                	ld	s0,8(sp)
 59a:	0141                	addi	sp,sp,16
 59c:	8082                	ret
  return 0;
 59e:	4501                	li	a0,0
 5a0:	bfe5                	j	598 <memcmp+0x30>

00000000000005a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5a2:	1141                	addi	sp,sp,-16
 5a4:	e406                	sd	ra,8(sp)
 5a6:	e022                	sd	s0,0(sp)
 5a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5aa:	f67ff0ef          	jal	510 <memmove>
}
 5ae:	60a2                	ld	ra,8(sp)
 5b0:	6402                	ld	s0,0(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret

00000000000005b6 <sbrk>:

char *
sbrk(int n) {
 5b6:	1141                	addi	sp,sp,-16
 5b8:	e406                	sd	ra,8(sp)
 5ba:	e022                	sd	s0,0(sp)
 5bc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 5be:	4585                	li	a1,1
 5c0:	0b2000ef          	jal	672 <sys_sbrk>
}
 5c4:	60a2                	ld	ra,8(sp)
 5c6:	6402                	ld	s0,0(sp)
 5c8:	0141                	addi	sp,sp,16
 5ca:	8082                	ret

00000000000005cc <sbrklazy>:

char *
sbrklazy(int n) {
 5cc:	1141                	addi	sp,sp,-16
 5ce:	e406                	sd	ra,8(sp)
 5d0:	e022                	sd	s0,0(sp)
 5d2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5d4:	4589                	li	a1,2
 5d6:	09c000ef          	jal	672 <sys_sbrk>
}
 5da:	60a2                	ld	ra,8(sp)
 5dc:	6402                	ld	s0,0(sp)
 5de:	0141                	addi	sp,sp,16
 5e0:	8082                	ret

00000000000005e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5e2:	4885                	li	a7,1
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ea:	4889                	li	a7,2
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5f2:	488d                	li	a7,3
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5fa:	4891                	li	a7,4
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <read>:
.global read
read:
 li a7, SYS_read
 602:	4895                	li	a7,5
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <write>:
.global write
write:
 li a7, SYS_write
 60a:	48c1                	li	a7,16
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <close>:
.global close
close:
 li a7, SYS_close
 612:	48d5                	li	a7,21
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <kill>:
.global kill
kill:
 li a7, SYS_kill
 61a:	4899                	li	a7,6
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <exec>:
.global exec
exec:
 li a7, SYS_exec
 622:	489d                	li	a7,7
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <open>:
.global open
open:
 li a7, SYS_open
 62a:	48bd                	li	a7,15
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 632:	48c5                	li	a7,17
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 63a:	48c9                	li	a7,18
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 642:	48a1                	li	a7,8
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <link>:
.global link
link:
 li a7, SYS_link
 64a:	48cd                	li	a7,19
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 652:	48d1                	li	a7,20
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 65a:	48a5                	li	a7,9
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <dup>:
.global dup
dup:
 li a7, SYS_dup
 662:	48a9                	li	a7,10
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 66a:	48ad                	li	a7,11
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 672:	48b1                	li	a7,12
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <pause>:
.global pause
pause:
 li a7, SYS_pause
 67a:	48b5                	li	a7,13
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 682:	48b9                	li	a7,14
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <endianswap>:
.global endianswap
endianswap:
 li a7, SYS_endianswap
 68a:	48d9                	li	a7,22
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 692:	1101                	addi	sp,sp,-32
 694:	ec06                	sd	ra,24(sp)
 696:	e822                	sd	s0,16(sp)
 698:	1000                	addi	s0,sp,32
 69a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 69e:	4605                	li	a2,1
 6a0:	fef40593          	addi	a1,s0,-17
 6a4:	f67ff0ef          	jal	60a <write>
}
 6a8:	60e2                	ld	ra,24(sp)
 6aa:	6442                	ld	s0,16(sp)
 6ac:	6105                	addi	sp,sp,32
 6ae:	8082                	ret

00000000000006b0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6b0:	715d                	addi	sp,sp,-80
 6b2:	e486                	sd	ra,72(sp)
 6b4:	e0a2                	sd	s0,64(sp)
 6b6:	fc26                	sd	s1,56(sp)
 6b8:	0880                	addi	s0,sp,80
 6ba:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6bc:	c299                	beqz	a3,6c2 <printint+0x12>
 6be:	0805c963          	bltz	a1,750 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c2:	2581                	sext.w	a1,a1
  neg = 0;
 6c4:	4881                	li	a7,0
 6c6:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 6ca:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6cc:	2601                	sext.w	a2,a2
 6ce:	00000517          	auipc	a0,0x0
 6d2:	61250513          	addi	a0,a0,1554 # ce0 <digits>
 6d6:	883a                	mv	a6,a4
 6d8:	2705                	addiw	a4,a4,1
 6da:	02c5f7bb          	remuw	a5,a1,a2
 6de:	1782                	slli	a5,a5,0x20
 6e0:	9381                	srli	a5,a5,0x20
 6e2:	97aa                	add	a5,a5,a0
 6e4:	0007c783          	lbu	a5,0(a5)
 6e8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ec:	0005879b          	sext.w	a5,a1
 6f0:	02c5d5bb          	divuw	a1,a1,a2
 6f4:	0685                	addi	a3,a3,1
 6f6:	fec7f0e3          	bgeu	a5,a2,6d6 <printint+0x26>
  if(neg)
 6fa:	00088c63          	beqz	a7,712 <printint+0x62>
    buf[i++] = '-';
 6fe:	fd070793          	addi	a5,a4,-48
 702:	00878733          	add	a4,a5,s0
 706:	02d00793          	li	a5,45
 70a:	fef70423          	sb	a5,-24(a4)
 70e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 712:	02e05a63          	blez	a4,746 <printint+0x96>
 716:	f84a                	sd	s2,48(sp)
 718:	f44e                	sd	s3,40(sp)
 71a:	fb840793          	addi	a5,s0,-72
 71e:	00e78933          	add	s2,a5,a4
 722:	fff78993          	addi	s3,a5,-1
 726:	99ba                	add	s3,s3,a4
 728:	377d                	addiw	a4,a4,-1
 72a:	1702                	slli	a4,a4,0x20
 72c:	9301                	srli	a4,a4,0x20
 72e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 732:	fff94583          	lbu	a1,-1(s2)
 736:	8526                	mv	a0,s1
 738:	f5bff0ef          	jal	692 <putc>
  while(--i >= 0)
 73c:	197d                	addi	s2,s2,-1
 73e:	ff391ae3          	bne	s2,s3,732 <printint+0x82>
 742:	7942                	ld	s2,48(sp)
 744:	79a2                	ld	s3,40(sp)
}
 746:	60a6                	ld	ra,72(sp)
 748:	6406                	ld	s0,64(sp)
 74a:	74e2                	ld	s1,56(sp)
 74c:	6161                	addi	sp,sp,80
 74e:	8082                	ret
    x = -xx;
 750:	40b005bb          	negw	a1,a1
    neg = 1;
 754:	4885                	li	a7,1
    x = -xx;
 756:	bf85                	j	6c6 <printint+0x16>

0000000000000758 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 758:	711d                	addi	sp,sp,-96
 75a:	ec86                	sd	ra,88(sp)
 75c:	e8a2                	sd	s0,80(sp)
 75e:	e0ca                	sd	s2,64(sp)
 760:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 762:	0005c903          	lbu	s2,0(a1)
 766:	28090663          	beqz	s2,9f2 <vprintf+0x29a>
 76a:	e4a6                	sd	s1,72(sp)
 76c:	fc4e                	sd	s3,56(sp)
 76e:	f852                	sd	s4,48(sp)
 770:	f456                	sd	s5,40(sp)
 772:	f05a                	sd	s6,32(sp)
 774:	ec5e                	sd	s7,24(sp)
 776:	e862                	sd	s8,16(sp)
 778:	e466                	sd	s9,8(sp)
 77a:	8b2a                	mv	s6,a0
 77c:	8a2e                	mv	s4,a1
 77e:	8bb2                	mv	s7,a2
  state = 0;
 780:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 782:	4481                	li	s1,0
 784:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 786:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 78a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 78e:	06c00c93          	li	s9,108
 792:	a005                	j	7b2 <vprintf+0x5a>
        putc(fd, c0);
 794:	85ca                	mv	a1,s2
 796:	855a                	mv	a0,s6
 798:	efbff0ef          	jal	692 <putc>
 79c:	a019                	j	7a2 <vprintf+0x4a>
    } else if(state == '%'){
 79e:	03598263          	beq	s3,s5,7c2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 7a2:	2485                	addiw	s1,s1,1
 7a4:	8726                	mv	a4,s1
 7a6:	009a07b3          	add	a5,s4,s1
 7aa:	0007c903          	lbu	s2,0(a5)
 7ae:	22090a63          	beqz	s2,9e2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 7b2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7b6:	fe0994e3          	bnez	s3,79e <vprintf+0x46>
      if(c0 == '%'){
 7ba:	fd579de3          	bne	a5,s5,794 <vprintf+0x3c>
        state = '%';
 7be:	89be                	mv	s3,a5
 7c0:	b7cd                	j	7a2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 7c2:	00ea06b3          	add	a3,s4,a4
 7c6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7ca:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7cc:	c681                	beqz	a3,7d4 <vprintf+0x7c>
 7ce:	9752                	add	a4,a4,s4
 7d0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7d4:	05878363          	beq	a5,s8,81a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7d8:	05978d63          	beq	a5,s9,832 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7dc:	07500713          	li	a4,117
 7e0:	0ee78763          	beq	a5,a4,8ce <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7e4:	07800713          	li	a4,120
 7e8:	12e78963          	beq	a5,a4,91a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7ec:	07000713          	li	a4,112
 7f0:	14e78e63          	beq	a5,a4,94c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7f4:	06300713          	li	a4,99
 7f8:	18e78e63          	beq	a5,a4,994 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7fc:	07300713          	li	a4,115
 800:	1ae78463          	beq	a5,a4,9a8 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 804:	02500713          	li	a4,37
 808:	04e79563          	bne	a5,a4,852 <vprintf+0xfa>
        putc(fd, '%');
 80c:	02500593          	li	a1,37
 810:	855a                	mv	a0,s6
 812:	e81ff0ef          	jal	692 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 816:	4981                	li	s3,0
 818:	b769                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 81a:	008b8913          	addi	s2,s7,8
 81e:	4685                	li	a3,1
 820:	4629                	li	a2,10
 822:	000ba583          	lw	a1,0(s7)
 826:	855a                	mv	a0,s6
 828:	e89ff0ef          	jal	6b0 <printint>
 82c:	8bca                	mv	s7,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bf8d                	j	7a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 832:	06400793          	li	a5,100
 836:	02f68963          	beq	a3,a5,868 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 83a:	06c00793          	li	a5,108
 83e:	04f68263          	beq	a3,a5,882 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 842:	07500793          	li	a5,117
 846:	0af68063          	beq	a3,a5,8e6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 84a:	07800793          	li	a5,120
 84e:	0ef68263          	beq	a3,a5,932 <vprintf+0x1da>
        putc(fd, '%');
 852:	02500593          	li	a1,37
 856:	855a                	mv	a0,s6
 858:	e3bff0ef          	jal	692 <putc>
        putc(fd, c0);
 85c:	85ca                	mv	a1,s2
 85e:	855a                	mv	a0,s6
 860:	e33ff0ef          	jal	692 <putc>
      state = 0;
 864:	4981                	li	s3,0
 866:	bf35                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 868:	008b8913          	addi	s2,s7,8
 86c:	4685                	li	a3,1
 86e:	4629                	li	a2,10
 870:	000bb583          	ld	a1,0(s7)
 874:	855a                	mv	a0,s6
 876:	e3bff0ef          	jal	6b0 <printint>
        i += 1;
 87a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 87c:	8bca                	mv	s7,s2
      state = 0;
 87e:	4981                	li	s3,0
        i += 1;
 880:	b70d                	j	7a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 882:	06400793          	li	a5,100
 886:	02f60763          	beq	a2,a5,8b4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 88a:	07500793          	li	a5,117
 88e:	06f60963          	beq	a2,a5,900 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 892:	07800793          	li	a5,120
 896:	faf61ee3          	bne	a2,a5,852 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 89a:	008b8913          	addi	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4641                	li	a2,16
 8a2:	000bb583          	ld	a1,0(s7)
 8a6:	855a                	mv	a0,s6
 8a8:	e09ff0ef          	jal	6b0 <printint>
        i += 2;
 8ac:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ae:	8bca                	mv	s7,s2
      state = 0;
 8b0:	4981                	li	s3,0
        i += 2;
 8b2:	bdc5                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8b4:	008b8913          	addi	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000bb583          	ld	a1,0(s7)
 8c0:	855a                	mv	a0,s6
 8c2:	defff0ef          	jal	6b0 <printint>
        i += 2;
 8c6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8c8:	8bca                	mv	s7,s2
      state = 0;
 8ca:	4981                	li	s3,0
        i += 2;
 8cc:	bdd9                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8ce:	008b8913          	addi	s2,s7,8
 8d2:	4681                	li	a3,0
 8d4:	4629                	li	a2,10
 8d6:	000be583          	lwu	a1,0(s7)
 8da:	855a                	mv	a0,s6
 8dc:	dd5ff0ef          	jal	6b0 <printint>
 8e0:	8bca                	mv	s7,s2
      state = 0;
 8e2:	4981                	li	s3,0
 8e4:	bd7d                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e6:	008b8913          	addi	s2,s7,8
 8ea:	4681                	li	a3,0
 8ec:	4629                	li	a2,10
 8ee:	000bb583          	ld	a1,0(s7)
 8f2:	855a                	mv	a0,s6
 8f4:	dbdff0ef          	jal	6b0 <printint>
        i += 1;
 8f8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fa:	8bca                	mv	s7,s2
      state = 0;
 8fc:	4981                	li	s3,0
        i += 1;
 8fe:	b555                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 900:	008b8913          	addi	s2,s7,8
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	000bb583          	ld	a1,0(s7)
 90c:	855a                	mv	a0,s6
 90e:	da3ff0ef          	jal	6b0 <printint>
        i += 2;
 912:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 914:	8bca                	mv	s7,s2
      state = 0;
 916:	4981                	li	s3,0
        i += 2;
 918:	b569                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 91a:	008b8913          	addi	s2,s7,8
 91e:	4681                	li	a3,0
 920:	4641                	li	a2,16
 922:	000be583          	lwu	a1,0(s7)
 926:	855a                	mv	a0,s6
 928:	d89ff0ef          	jal	6b0 <printint>
 92c:	8bca                	mv	s7,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	bd8d                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 932:	008b8913          	addi	s2,s7,8
 936:	4681                	li	a3,0
 938:	4641                	li	a2,16
 93a:	000bb583          	ld	a1,0(s7)
 93e:	855a                	mv	a0,s6
 940:	d71ff0ef          	jal	6b0 <printint>
        i += 1;
 944:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 946:	8bca                	mv	s7,s2
      state = 0;
 948:	4981                	li	s3,0
        i += 1;
 94a:	bda1                	j	7a2 <vprintf+0x4a>
 94c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 94e:	008b8d13          	addi	s10,s7,8
 952:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 956:	03000593          	li	a1,48
 95a:	855a                	mv	a0,s6
 95c:	d37ff0ef          	jal	692 <putc>
  putc(fd, 'x');
 960:	07800593          	li	a1,120
 964:	855a                	mv	a0,s6
 966:	d2dff0ef          	jal	692 <putc>
 96a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 96c:	00000b97          	auipc	s7,0x0
 970:	374b8b93          	addi	s7,s7,884 # ce0 <digits>
 974:	03c9d793          	srli	a5,s3,0x3c
 978:	97de                	add	a5,a5,s7
 97a:	0007c583          	lbu	a1,0(a5)
 97e:	855a                	mv	a0,s6
 980:	d13ff0ef          	jal	692 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 984:	0992                	slli	s3,s3,0x4
 986:	397d                	addiw	s2,s2,-1
 988:	fe0916e3          	bnez	s2,974 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 98c:	8bea                	mv	s7,s10
      state = 0;
 98e:	4981                	li	s3,0
 990:	6d02                	ld	s10,0(sp)
 992:	bd01                	j	7a2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 994:	008b8913          	addi	s2,s7,8
 998:	000bc583          	lbu	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	cf5ff0ef          	jal	692 <putc>
 9a2:	8bca                	mv	s7,s2
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	bbf5                	j	7a2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 9a8:	008b8993          	addi	s3,s7,8
 9ac:	000bb903          	ld	s2,0(s7)
 9b0:	00090f63          	beqz	s2,9ce <vprintf+0x276>
        for(; *s; s++)
 9b4:	00094583          	lbu	a1,0(s2)
 9b8:	c195                	beqz	a1,9dc <vprintf+0x284>
          putc(fd, *s);
 9ba:	855a                	mv	a0,s6
 9bc:	cd7ff0ef          	jal	692 <putc>
        for(; *s; s++)
 9c0:	0905                	addi	s2,s2,1
 9c2:	00094583          	lbu	a1,0(s2)
 9c6:	f9f5                	bnez	a1,9ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9c8:	8bce                	mv	s7,s3
      state = 0;
 9ca:	4981                	li	s3,0
 9cc:	bbd9                	j	7a2 <vprintf+0x4a>
          s = "(null)";
 9ce:	00000917          	auipc	s2,0x0
 9d2:	30a90913          	addi	s2,s2,778 # cd8 <malloc+0x1fe>
        for(; *s; s++)
 9d6:	02800593          	li	a1,40
 9da:	b7c5                	j	9ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9dc:	8bce                	mv	s7,s3
      state = 0;
 9de:	4981                	li	s3,0
 9e0:	b3c9                	j	7a2 <vprintf+0x4a>
 9e2:	64a6                	ld	s1,72(sp)
 9e4:	79e2                	ld	s3,56(sp)
 9e6:	7a42                	ld	s4,48(sp)
 9e8:	7aa2                	ld	s5,40(sp)
 9ea:	7b02                	ld	s6,32(sp)
 9ec:	6be2                	ld	s7,24(sp)
 9ee:	6c42                	ld	s8,16(sp)
 9f0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9f2:	60e6                	ld	ra,88(sp)
 9f4:	6446                	ld	s0,80(sp)
 9f6:	6906                	ld	s2,64(sp)
 9f8:	6125                	addi	sp,sp,96
 9fa:	8082                	ret

00000000000009fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9fc:	715d                	addi	sp,sp,-80
 9fe:	ec06                	sd	ra,24(sp)
 a00:	e822                	sd	s0,16(sp)
 a02:	1000                	addi	s0,sp,32
 a04:	e010                	sd	a2,0(s0)
 a06:	e414                	sd	a3,8(s0)
 a08:	e818                	sd	a4,16(s0)
 a0a:	ec1c                	sd	a5,24(s0)
 a0c:	03043023          	sd	a6,32(s0)
 a10:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a14:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a18:	8622                	mv	a2,s0
 a1a:	d3fff0ef          	jal	758 <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6161                	addi	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <printf>:

void
printf(const char *fmt, ...)
{
 a26:	711d                	addi	sp,sp,-96
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	addi	s0,sp,32
 a2e:	e40c                	sd	a1,8(s0)
 a30:	e810                	sd	a2,16(s0)
 a32:	ec14                	sd	a3,24(s0)
 a34:	f018                	sd	a4,32(s0)
 a36:	f41c                	sd	a5,40(s0)
 a38:	03043823          	sd	a6,48(s0)
 a3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	00840613          	addi	a2,s0,8
 a44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a48:	85aa                	mv	a1,a0
 a4a:	4505                	li	a0,1
 a4c:	d0dff0ef          	jal	758 <vprintf>
}
 a50:	60e2                	ld	ra,24(sp)
 a52:	6442                	ld	s0,16(sp)
 a54:	6125                	addi	sp,sp,96
 a56:	8082                	ret

0000000000000a58 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a58:	1141                	addi	sp,sp,-16
 a5a:	e422                	sd	s0,8(sp)
 a5c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a5e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a62:	00001797          	auipc	a5,0x1
 a66:	59e7b783          	ld	a5,1438(a5) # 2000 <freep>
 a6a:	a02d                	j	a94 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a6c:	4618                	lw	a4,8(a2)
 a6e:	9f2d                	addw	a4,a4,a1
 a70:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a74:	6398                	ld	a4,0(a5)
 a76:	6310                	ld	a2,0(a4)
 a78:	a83d                	j	ab6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7a:	ff852703          	lw	a4,-8(a0)
 a7e:	9f31                	addw	a4,a4,a2
 a80:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a82:	ff053683          	ld	a3,-16(a0)
 a86:	a091                	j	aca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a88:	6398                	ld	a4,0(a5)
 a8a:	00e7e463          	bltu	a5,a4,a92 <free+0x3a>
 a8e:	00e6ea63          	bltu	a3,a4,aa2 <free+0x4a>
{
 a92:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a94:	fed7fae3          	bgeu	a5,a3,a88 <free+0x30>
 a98:	6398                	ld	a4,0(a5)
 a9a:	00e6e463          	bltu	a3,a4,aa2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9e:	fee7eae3          	bltu	a5,a4,a92 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa2:	ff852583          	lw	a1,-8(a0)
 aa6:	6390                	ld	a2,0(a5)
 aa8:	02059813          	slli	a6,a1,0x20
 aac:	01c85713          	srli	a4,a6,0x1c
 ab0:	9736                	add	a4,a4,a3
 ab2:	fae60de3          	beq	a2,a4,a6c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ab6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 aba:	4790                	lw	a2,8(a5)
 abc:	02061593          	slli	a1,a2,0x20
 ac0:	01c5d713          	srli	a4,a1,0x1c
 ac4:	973e                	add	a4,a4,a5
 ac6:	fae68ae3          	beq	a3,a4,a7a <free+0x22>
    p->s.ptr = bp->s.ptr;
 aca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 acc:	00001717          	auipc	a4,0x1
 ad0:	52f73a23          	sd	a5,1332(a4) # 2000 <freep>
}
 ad4:	6422                	ld	s0,8(sp)
 ad6:	0141                	addi	sp,sp,16
 ad8:	8082                	ret

0000000000000ada <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ada:	7139                	addi	sp,sp,-64
 adc:	fc06                	sd	ra,56(sp)
 ade:	f822                	sd	s0,48(sp)
 ae0:	f426                	sd	s1,40(sp)
 ae2:	ec4e                	sd	s3,24(sp)
 ae4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae6:	02051493          	slli	s1,a0,0x20
 aea:	9081                	srli	s1,s1,0x20
 aec:	04bd                	addi	s1,s1,15
 aee:	8091                	srli	s1,s1,0x4
 af0:	0014899b          	addiw	s3,s1,1
 af4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 af6:	00001517          	auipc	a0,0x1
 afa:	50a53503          	ld	a0,1290(a0) # 2000 <freep>
 afe:	c915                	beqz	a0,b32 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b00:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b02:	4798                	lw	a4,8(a5)
 b04:	08977a63          	bgeu	a4,s1,b98 <malloc+0xbe>
 b08:	f04a                	sd	s2,32(sp)
 b0a:	e852                	sd	s4,16(sp)
 b0c:	e456                	sd	s5,8(sp)
 b0e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b10:	8a4e                	mv	s4,s3
 b12:	0009871b          	sext.w	a4,s3
 b16:	6685                	lui	a3,0x1
 b18:	00d77363          	bgeu	a4,a3,b1e <malloc+0x44>
 b1c:	6a05                	lui	s4,0x1
 b1e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b22:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b26:	00001917          	auipc	s2,0x1
 b2a:	4da90913          	addi	s2,s2,1242 # 2000 <freep>
  if(p == SBRK_ERROR)
 b2e:	5afd                	li	s5,-1
 b30:	a081                	j	b70 <malloc+0x96>
 b32:	f04a                	sd	s2,32(sp)
 b34:	e852                	sd	s4,16(sp)
 b36:	e456                	sd	s5,8(sp)
 b38:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b3a:	00001797          	auipc	a5,0x1
 b3e:	4d678793          	addi	a5,a5,1238 # 2010 <base>
 b42:	00001717          	auipc	a4,0x1
 b46:	4af73f23          	sd	a5,1214(a4) # 2000 <freep>
 b4a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b4c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b50:	b7c1                	j	b10 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b52:	6398                	ld	a4,0(a5)
 b54:	e118                	sd	a4,0(a0)
 b56:	a8a9                	j	bb0 <malloc+0xd6>
  hp->s.size = nu;
 b58:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b5c:	0541                	addi	a0,a0,16
 b5e:	efbff0ef          	jal	a58 <free>
  return freep;
 b62:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b66:	c12d                	beqz	a0,bc8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b6a:	4798                	lw	a4,8(a5)
 b6c:	02977263          	bgeu	a4,s1,b90 <malloc+0xb6>
    if(p == freep)
 b70:	00093703          	ld	a4,0(s2)
 b74:	853e                	mv	a0,a5
 b76:	fef719e3          	bne	a4,a5,b68 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b7a:	8552                	mv	a0,s4
 b7c:	a3bff0ef          	jal	5b6 <sbrk>
  if(p == SBRK_ERROR)
 b80:	fd551ce3          	bne	a0,s5,b58 <malloc+0x7e>
        return 0;
 b84:	4501                	li	a0,0
 b86:	7902                	ld	s2,32(sp)
 b88:	6a42                	ld	s4,16(sp)
 b8a:	6aa2                	ld	s5,8(sp)
 b8c:	6b02                	ld	s6,0(sp)
 b8e:	a03d                	j	bbc <malloc+0xe2>
 b90:	7902                	ld	s2,32(sp)
 b92:	6a42                	ld	s4,16(sp)
 b94:	6aa2                	ld	s5,8(sp)
 b96:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b98:	fae48de3          	beq	s1,a4,b52 <malloc+0x78>
        p->s.size -= nunits;
 b9c:	4137073b          	subw	a4,a4,s3
 ba0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ba2:	02071693          	slli	a3,a4,0x20
 ba6:	01c6d713          	srli	a4,a3,0x1c
 baa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bb0:	00001717          	auipc	a4,0x1
 bb4:	44a73823          	sd	a0,1104(a4) # 2000 <freep>
      return (void*)(p + 1);
 bb8:	01078513          	addi	a0,a5,16
  }
}
 bbc:	70e2                	ld	ra,56(sp)
 bbe:	7442                	ld	s0,48(sp)
 bc0:	74a2                	ld	s1,40(sp)
 bc2:	69e2                	ld	s3,24(sp)
 bc4:	6121                	addi	sp,sp,64
 bc6:	8082                	ret
 bc8:	7902                	ld	s2,32(sp)
 bca:	6a42                	ld	s4,16(sp)
 bcc:	6aa2                	ld	s5,8(sp)
 bce:	6b02                	ld	s6,0(sp)
 bd0:	b7f5                	j	bbc <malloc+0xe2>
