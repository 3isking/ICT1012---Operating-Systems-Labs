
user/_sniffer:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#define DATASIZE (8*4096)

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
    // Your code here.
	char *p = sbrk(DATASIZE);
  10:	6521                	lui	a0,0x8
  12:	2a8000ef          	jal	2ba <sbrk>
  16:	892a                	mv	s2,a0
  18:	4481                	li	s1,0

	for(int i = 0; i < DATASIZE - 16; i++){
		if(memcmp(p + i, "This may help.", 14) == 0){
  1a:	00001a17          	auipc	s4,0x1
  1e:	8b6a0a13          	addi	s4,s4,-1866 # 8d0 <malloc+0xfa>
	for(int i = 0; i < DATASIZE - 16; i++){
  22:	69a1                	lui	s3,0x8
  24:	19c1                	addi	s3,s3,-16 # 7ff0 <base+0x6fe0>
		if(memcmp(p + i, "This may help.", 14) == 0){
  26:	4639                	li	a2,14
  28:	85d2                	mv	a1,s4
  2a:	00990533          	add	a0,s2,s1
  2e:	23e000ef          	jal	26c <memcmp>
  32:	c519                	beqz	a0,40 <main+0x40>
	for(int i = 0; i < DATASIZE - 16; i++){
  34:	0485                	addi	s1,s1,1
  36:	ff3498e3          	bne	s1,s3,26 <main+0x26>
			printf("%s\n", p + i + 16);
		exit(0);
		}
	}
    exit(1);
  3a:	4505                	li	a0,1
  3c:	2b2000ef          	jal	2ee <exit>
			printf("%s\n", p + i + 16);
  40:	01048593          	addi	a1,s1,16
  44:	95ca                	add	a1,a1,s2
  46:	00001517          	auipc	a0,0x1
  4a:	89a50513          	addi	a0,a0,-1894 # 8e0 <malloc+0x10a>
  4e:	6d4000ef          	jal	722 <printf>
		exit(0);
  52:	4501                	li	a0,0
  54:	29a000ef          	jal	2ee <exit>

0000000000000058 <start>:
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
  5c:	e022                	sd	s0,0(sp)
  5e:	0800                	addi	s0,sp,16
  60:	fa1ff0ef          	jal	0 <main>
  64:	4501                	li	a0,0
  66:	288000ef          	jal	2ee <exit>

000000000000006a <strcpy>:
  6a:	1141                	addi	sp,sp,-16
  6c:	e422                	sd	s0,8(sp)
  6e:	0800                	addi	s0,sp,16
  70:	87aa                	mv	a5,a0
  72:	0585                	addi	a1,a1,1
  74:	0785                	addi	a5,a5,1
  76:	fff5c703          	lbu	a4,-1(a1)
  7a:	fee78fa3          	sb	a4,-1(a5)
  7e:	fb75                	bnez	a4,72 <strcpy+0x8>
  80:	6422                	ld	s0,8(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strcmp>:
  86:	1141                	addi	sp,sp,-16
  88:	e422                	sd	s0,8(sp)
  8a:	0800                	addi	s0,sp,16
  8c:	00054783          	lbu	a5,0(a0)
  90:	cb91                	beqz	a5,a4 <strcmp+0x1e>
  92:	0005c703          	lbu	a4,0(a1)
  96:	00f71763          	bne	a4,a5,a4 <strcmp+0x1e>
  9a:	0505                	addi	a0,a0,1
  9c:	0585                	addi	a1,a1,1
  9e:	00054783          	lbu	a5,0(a0)
  a2:	fbe5                	bnez	a5,92 <strcmp+0xc>
  a4:	0005c503          	lbu	a0,0(a1)
  a8:	40a7853b          	subw	a0,a5,a0
  ac:	6422                	ld	s0,8(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strlen>:
  b2:	1141                	addi	sp,sp,-16
  b4:	e422                	sd	s0,8(sp)
  b6:	0800                	addi	s0,sp,16
  b8:	00054783          	lbu	a5,0(a0)
  bc:	cf91                	beqz	a5,d8 <strlen+0x26>
  be:	0505                	addi	a0,a0,1
  c0:	87aa                	mv	a5,a0
  c2:	86be                	mv	a3,a5
  c4:	0785                	addi	a5,a5,1
  c6:	fff7c703          	lbu	a4,-1(a5)
  ca:	ff65                	bnez	a4,c2 <strlen+0x10>
  cc:	40a6853b          	subw	a0,a3,a0
  d0:	2505                	addiw	a0,a0,1
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	addi	sp,sp,16
  d6:	8082                	ret
  d8:	4501                	li	a0,0
  da:	bfe5                	j	d2 <strlen+0x20>

00000000000000dc <memset>:
  dc:	1141                	addi	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	addi	s0,sp,16
  e2:	ca19                	beqz	a2,f8 <memset+0x1c>
  e4:	87aa                	mv	a5,a0
  e6:	1602                	slli	a2,a2,0x20
  e8:	9201                	srli	a2,a2,0x20
  ea:	00a60733          	add	a4,a2,a0
  ee:	00b78023          	sb	a1,0(a5)
  f2:	0785                	addi	a5,a5,1
  f4:	fee79de3          	bne	a5,a4,ee <memset+0x12>
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	addi	sp,sp,16
  fc:	8082                	ret

00000000000000fe <strchr>:
  fe:	1141                	addi	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	addi	s0,sp,16
 104:	00054783          	lbu	a5,0(a0)
 108:	cb99                	beqz	a5,11e <strchr+0x20>
 10a:	00f58763          	beq	a1,a5,118 <strchr+0x1a>
 10e:	0505                	addi	a0,a0,1
 110:	00054783          	lbu	a5,0(a0)
 114:	fbfd                	bnez	a5,10a <strchr+0xc>
 116:	4501                	li	a0,0
 118:	6422                	ld	s0,8(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret
 11e:	4501                	li	a0,0
 120:	bfe5                	j	118 <strchr+0x1a>

0000000000000122 <gets>:
 122:	711d                	addi	sp,sp,-96
 124:	ec86                	sd	ra,88(sp)
 126:	e8a2                	sd	s0,80(sp)
 128:	e4a6                	sd	s1,72(sp)
 12a:	e0ca                	sd	s2,64(sp)
 12c:	fc4e                	sd	s3,56(sp)
 12e:	f852                	sd	s4,48(sp)
 130:	f456                	sd	s5,40(sp)
 132:	f05a                	sd	s6,32(sp)
 134:	ec5e                	sd	s7,24(sp)
 136:	1080                	addi	s0,sp,96
 138:	8baa                	mv	s7,a0
 13a:	8a2e                	mv	s4,a1
 13c:	892a                	mv	s2,a0
 13e:	4481                	li	s1,0
 140:	4aa9                	li	s5,10
 142:	4b35                	li	s6,13
 144:	89a6                	mv	s3,s1
 146:	2485                	addiw	s1,s1,1
 148:	0344d663          	bge	s1,s4,174 <gets+0x52>
 14c:	4605                	li	a2,1
 14e:	faf40593          	addi	a1,s0,-81
 152:	4501                	li	a0,0
 154:	1b2000ef          	jal	306 <read>
 158:	00a05e63          	blez	a0,174 <gets+0x52>
 15c:	faf44783          	lbu	a5,-81(s0)
 160:	00f90023          	sb	a5,0(s2)
 164:	01578763          	beq	a5,s5,172 <gets+0x50>
 168:	0905                	addi	s2,s2,1
 16a:	fd679de3          	bne	a5,s6,144 <gets+0x22>
 16e:	89a6                	mv	s3,s1
 170:	a011                	j	174 <gets+0x52>
 172:	89a6                	mv	s3,s1
 174:	99de                	add	s3,s3,s7
 176:	00098023          	sb	zero,0(s3)
 17a:	855e                	mv	a0,s7
 17c:	60e6                	ld	ra,88(sp)
 17e:	6446                	ld	s0,80(sp)
 180:	64a6                	ld	s1,72(sp)
 182:	6906                	ld	s2,64(sp)
 184:	79e2                	ld	s3,56(sp)
 186:	7a42                	ld	s4,48(sp)
 188:	7aa2                	ld	s5,40(sp)
 18a:	7b02                	ld	s6,32(sp)
 18c:	6be2                	ld	s7,24(sp)
 18e:	6125                	addi	sp,sp,96
 190:	8082                	ret

0000000000000192 <stat>:
 192:	1101                	addi	sp,sp,-32
 194:	ec06                	sd	ra,24(sp)
 196:	e822                	sd	s0,16(sp)
 198:	e04a                	sd	s2,0(sp)
 19a:	1000                	addi	s0,sp,32
 19c:	892e                	mv	s2,a1
 19e:	4581                	li	a1,0
 1a0:	18e000ef          	jal	32e <open>
 1a4:	02054263          	bltz	a0,1c8 <stat+0x36>
 1a8:	e426                	sd	s1,8(sp)
 1aa:	84aa                	mv	s1,a0
 1ac:	85ca                	mv	a1,s2
 1ae:	198000ef          	jal	346 <fstat>
 1b2:	892a                	mv	s2,a0
 1b4:	8526                	mv	a0,s1
 1b6:	160000ef          	jal	316 <close>
 1ba:	64a2                	ld	s1,8(sp)
 1bc:	854a                	mv	a0,s2
 1be:	60e2                	ld	ra,24(sp)
 1c0:	6442                	ld	s0,16(sp)
 1c2:	6902                	ld	s2,0(sp)
 1c4:	6105                	addi	sp,sp,32
 1c6:	8082                	ret
 1c8:	597d                	li	s2,-1
 1ca:	bfcd                	j	1bc <stat+0x2a>

00000000000001cc <atoi>:
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
 1d2:	00054683          	lbu	a3,0(a0)
 1d6:	fd06879b          	addiw	a5,a3,-48
 1da:	0ff7f793          	zext.b	a5,a5
 1de:	4625                	li	a2,9
 1e0:	02f66863          	bltu	a2,a5,210 <atoi+0x44>
 1e4:	872a                	mv	a4,a0
 1e6:	4501                	li	a0,0
 1e8:	0705                	addi	a4,a4,1
 1ea:	0025179b          	slliw	a5,a0,0x2
 1ee:	9fa9                	addw	a5,a5,a0
 1f0:	0017979b          	slliw	a5,a5,0x1
 1f4:	9fb5                	addw	a5,a5,a3
 1f6:	fd07851b          	addiw	a0,a5,-48
 1fa:	00074683          	lbu	a3,0(a4)
 1fe:	fd06879b          	addiw	a5,a3,-48
 202:	0ff7f793          	zext.b	a5,a5
 206:	fef671e3          	bgeu	a2,a5,1e8 <atoi+0x1c>
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret
 210:	4501                	li	a0,0
 212:	bfe5                	j	20a <atoi+0x3e>

0000000000000214 <memmove>:
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
 21a:	02b57463          	bgeu	a0,a1,242 <memmove+0x2e>
 21e:	00c05f63          	blez	a2,23c <memmove+0x28>
 222:	1602                	slli	a2,a2,0x20
 224:	9201                	srli	a2,a2,0x20
 226:	00c507b3          	add	a5,a0,a2
 22a:	872a                	mv	a4,a0
 22c:	0585                	addi	a1,a1,1
 22e:	0705                	addi	a4,a4,1
 230:	fff5c683          	lbu	a3,-1(a1)
 234:	fed70fa3          	sb	a3,-1(a4)
 238:	fef71ae3          	bne	a4,a5,22c <memmove+0x18>
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
 242:	00c50733          	add	a4,a0,a2
 246:	95b2                	add	a1,a1,a2
 248:	fec05ae3          	blez	a2,23c <memmove+0x28>
 24c:	fff6079b          	addiw	a5,a2,-1
 250:	1782                	slli	a5,a5,0x20
 252:	9381                	srli	a5,a5,0x20
 254:	fff7c793          	not	a5,a5
 258:	97ba                	add	a5,a5,a4
 25a:	15fd                	addi	a1,a1,-1
 25c:	177d                	addi	a4,a4,-1
 25e:	0005c683          	lbu	a3,0(a1)
 262:	00d70023          	sb	a3,0(a4)
 266:	fee79ae3          	bne	a5,a4,25a <memmove+0x46>
 26a:	bfc9                	j	23c <memmove+0x28>

000000000000026c <memcmp>:
 26c:	1141                	addi	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	addi	s0,sp,16
 272:	ca05                	beqz	a2,2a2 <memcmp+0x36>
 274:	fff6069b          	addiw	a3,a2,-1
 278:	1682                	slli	a3,a3,0x20
 27a:	9281                	srli	a3,a3,0x20
 27c:	0685                	addi	a3,a3,1
 27e:	96aa                	add	a3,a3,a0
 280:	00054783          	lbu	a5,0(a0)
 284:	0005c703          	lbu	a4,0(a1)
 288:	00e79863          	bne	a5,a4,298 <memcmp+0x2c>
 28c:	0505                	addi	a0,a0,1
 28e:	0585                	addi	a1,a1,1
 290:	fed518e3          	bne	a0,a3,280 <memcmp+0x14>
 294:	4501                	li	a0,0
 296:	a019                	j	29c <memcmp+0x30>
 298:	40e7853b          	subw	a0,a5,a4
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <memcmp+0x30>

00000000000002a6 <memcpy>:
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e406                	sd	ra,8(sp)
 2aa:	e022                	sd	s0,0(sp)
 2ac:	0800                	addi	s0,sp,16
 2ae:	f67ff0ef          	jal	214 <memmove>
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <sbrk>:
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e406                	sd	ra,8(sp)
 2be:	e022                	sd	s0,0(sp)
 2c0:	0800                	addi	s0,sp,16
 2c2:	4585                	li	a1,1
 2c4:	0b2000ef          	jal	376 <sys_sbrk>
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <sbrklazy>:
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
 2d8:	4589                	li	a1,2
 2da:	09c000ef          	jal	376 <sys_sbrk>
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret

00000000000002e6 <fork>:
 2e6:	4885                	li	a7,1
 2e8:	00000073          	ecall
 2ec:	8082                	ret

00000000000002ee <exit>:
 2ee:	4889                	li	a7,2
 2f0:	00000073          	ecall
 2f4:	8082                	ret

00000000000002f6 <wait>:
 2f6:	488d                	li	a7,3
 2f8:	00000073          	ecall
 2fc:	8082                	ret

00000000000002fe <pipe>:
 2fe:	4891                	li	a7,4
 300:	00000073          	ecall
 304:	8082                	ret

0000000000000306 <read>:
 306:	4895                	li	a7,5
 308:	00000073          	ecall
 30c:	8082                	ret

000000000000030e <write>:
 30e:	48c1                	li	a7,16
 310:	00000073          	ecall
 314:	8082                	ret

0000000000000316 <close>:
 316:	48d5                	li	a7,21
 318:	00000073          	ecall
 31c:	8082                	ret

000000000000031e <kill>:
 31e:	4899                	li	a7,6
 320:	00000073          	ecall
 324:	8082                	ret

0000000000000326 <exec>:
 326:	489d                	li	a7,7
 328:	00000073          	ecall
 32c:	8082                	ret

000000000000032e <open>:
 32e:	48bd                	li	a7,15
 330:	00000073          	ecall
 334:	8082                	ret

0000000000000336 <mknod>:
 336:	48c5                	li	a7,17
 338:	00000073          	ecall
 33c:	8082                	ret

000000000000033e <unlink>:
 33e:	48c9                	li	a7,18
 340:	00000073          	ecall
 344:	8082                	ret

0000000000000346 <fstat>:
 346:	48a1                	li	a7,8
 348:	00000073          	ecall
 34c:	8082                	ret

000000000000034e <link>:
 34e:	48cd                	li	a7,19
 350:	00000073          	ecall
 354:	8082                	ret

0000000000000356 <mkdir>:
 356:	48d1                	li	a7,20
 358:	00000073          	ecall
 35c:	8082                	ret

000000000000035e <chdir>:
 35e:	48a5                	li	a7,9
 360:	00000073          	ecall
 364:	8082                	ret

0000000000000366 <dup>:
 366:	48a9                	li	a7,10
 368:	00000073          	ecall
 36c:	8082                	ret

000000000000036e <getpid>:
 36e:	48ad                	li	a7,11
 370:	00000073          	ecall
 374:	8082                	ret

0000000000000376 <sys_sbrk>:
 376:	48b1                	li	a7,12
 378:	00000073          	ecall
 37c:	8082                	ret

000000000000037e <pause>:
 37e:	48b5                	li	a7,13
 380:	00000073          	ecall
 384:	8082                	ret

0000000000000386 <uptime>:
 386:	48b9                	li	a7,14
 388:	00000073          	ecall
 38c:	8082                	ret

000000000000038e <putc>:
 38e:	1101                	addi	sp,sp,-32
 390:	ec06                	sd	ra,24(sp)
 392:	e822                	sd	s0,16(sp)
 394:	1000                	addi	s0,sp,32
 396:	feb407a3          	sb	a1,-17(s0)
 39a:	4605                	li	a2,1
 39c:	fef40593          	addi	a1,s0,-17
 3a0:	f6fff0ef          	jal	30e <write>
 3a4:	60e2                	ld	ra,24(sp)
 3a6:	6442                	ld	s0,16(sp)
 3a8:	6105                	addi	sp,sp,32
 3aa:	8082                	ret

00000000000003ac <printint>:
 3ac:	715d                	addi	sp,sp,-80
 3ae:	e486                	sd	ra,72(sp)
 3b0:	e0a2                	sd	s0,64(sp)
 3b2:	fc26                	sd	s1,56(sp)
 3b4:	0880                	addi	s0,sp,80
 3b6:	84aa                	mv	s1,a0
 3b8:	c299                	beqz	a3,3be <printint+0x12>
 3ba:	0805c963          	bltz	a1,44c <printint+0xa0>
 3be:	2581                	sext.w	a1,a1
 3c0:	4881                	li	a7,0
 3c2:	fb840693          	addi	a3,s0,-72
 3c6:	4701                	li	a4,0
 3c8:	2601                	sext.w	a2,a2
 3ca:	00000517          	auipc	a0,0x0
 3ce:	52650513          	addi	a0,a0,1318 # 8f0 <digits>
 3d2:	883a                	mv	a6,a4
 3d4:	2705                	addiw	a4,a4,1
 3d6:	02c5f7bb          	remuw	a5,a1,a2
 3da:	1782                	slli	a5,a5,0x20
 3dc:	9381                	srli	a5,a5,0x20
 3de:	97aa                	add	a5,a5,a0
 3e0:	0007c783          	lbu	a5,0(a5)
 3e4:	00f68023          	sb	a5,0(a3)
 3e8:	0005879b          	sext.w	a5,a1
 3ec:	02c5d5bb          	divuw	a1,a1,a2
 3f0:	0685                	addi	a3,a3,1
 3f2:	fec7f0e3          	bgeu	a5,a2,3d2 <printint+0x26>
 3f6:	00088c63          	beqz	a7,40e <printint+0x62>
 3fa:	fd070793          	addi	a5,a4,-48
 3fe:	00878733          	add	a4,a5,s0
 402:	02d00793          	li	a5,45
 406:	fef70423          	sb	a5,-24(a4)
 40a:	0028071b          	addiw	a4,a6,2
 40e:	02e05a63          	blez	a4,442 <printint+0x96>
 412:	f84a                	sd	s2,48(sp)
 414:	f44e                	sd	s3,40(sp)
 416:	fb840793          	addi	a5,s0,-72
 41a:	00e78933          	add	s2,a5,a4
 41e:	fff78993          	addi	s3,a5,-1
 422:	99ba                	add	s3,s3,a4
 424:	377d                	addiw	a4,a4,-1
 426:	1702                	slli	a4,a4,0x20
 428:	9301                	srli	a4,a4,0x20
 42a:	40e989b3          	sub	s3,s3,a4
 42e:	fff94583          	lbu	a1,-1(s2)
 432:	8526                	mv	a0,s1
 434:	f5bff0ef          	jal	38e <putc>
 438:	197d                	addi	s2,s2,-1
 43a:	ff391ae3          	bne	s2,s3,42e <printint+0x82>
 43e:	7942                	ld	s2,48(sp)
 440:	79a2                	ld	s3,40(sp)
 442:	60a6                	ld	ra,72(sp)
 444:	6406                	ld	s0,64(sp)
 446:	74e2                	ld	s1,56(sp)
 448:	6161                	addi	sp,sp,80
 44a:	8082                	ret
 44c:	40b005bb          	negw	a1,a1
 450:	4885                	li	a7,1
 452:	bf85                	j	3c2 <printint+0x16>

0000000000000454 <vprintf>:
 454:	711d                	addi	sp,sp,-96
 456:	ec86                	sd	ra,88(sp)
 458:	e8a2                	sd	s0,80(sp)
 45a:	e0ca                	sd	s2,64(sp)
 45c:	1080                	addi	s0,sp,96
 45e:	0005c903          	lbu	s2,0(a1)
 462:	28090663          	beqz	s2,6ee <vprintf+0x29a>
 466:	e4a6                	sd	s1,72(sp)
 468:	fc4e                	sd	s3,56(sp)
 46a:	f852                	sd	s4,48(sp)
 46c:	f456                	sd	s5,40(sp)
 46e:	f05a                	sd	s6,32(sp)
 470:	ec5e                	sd	s7,24(sp)
 472:	e862                	sd	s8,16(sp)
 474:	e466                	sd	s9,8(sp)
 476:	8b2a                	mv	s6,a0
 478:	8a2e                	mv	s4,a1
 47a:	8bb2                	mv	s7,a2
 47c:	4981                	li	s3,0
 47e:	4481                	li	s1,0
 480:	4701                	li	a4,0
 482:	02500a93          	li	s5,37
 486:	06400c13          	li	s8,100
 48a:	06c00c93          	li	s9,108
 48e:	a005                	j	4ae <vprintf+0x5a>
 490:	85ca                	mv	a1,s2
 492:	855a                	mv	a0,s6
 494:	efbff0ef          	jal	38e <putc>
 498:	a019                	j	49e <vprintf+0x4a>
 49a:	03598263          	beq	s3,s5,4be <vprintf+0x6a>
 49e:	2485                	addiw	s1,s1,1
 4a0:	8726                	mv	a4,s1
 4a2:	009a07b3          	add	a5,s4,s1
 4a6:	0007c903          	lbu	s2,0(a5)
 4aa:	22090a63          	beqz	s2,6de <vprintf+0x28a>
 4ae:	0009079b          	sext.w	a5,s2
 4b2:	fe0994e3          	bnez	s3,49a <vprintf+0x46>
 4b6:	fd579de3          	bne	a5,s5,490 <vprintf+0x3c>
 4ba:	89be                	mv	s3,a5
 4bc:	b7cd                	j	49e <vprintf+0x4a>
 4be:	00ea06b3          	add	a3,s4,a4
 4c2:	0016c683          	lbu	a3,1(a3)
 4c6:	8636                	mv	a2,a3
 4c8:	c681                	beqz	a3,4d0 <vprintf+0x7c>
 4ca:	9752                	add	a4,a4,s4
 4cc:	00274603          	lbu	a2,2(a4)
 4d0:	05878363          	beq	a5,s8,516 <vprintf+0xc2>
 4d4:	05978d63          	beq	a5,s9,52e <vprintf+0xda>
 4d8:	07500713          	li	a4,117
 4dc:	0ee78763          	beq	a5,a4,5ca <vprintf+0x176>
 4e0:	07800713          	li	a4,120
 4e4:	12e78963          	beq	a5,a4,616 <vprintf+0x1c2>
 4e8:	07000713          	li	a4,112
 4ec:	14e78e63          	beq	a5,a4,648 <vprintf+0x1f4>
 4f0:	06300713          	li	a4,99
 4f4:	18e78e63          	beq	a5,a4,690 <vprintf+0x23c>
 4f8:	07300713          	li	a4,115
 4fc:	1ae78463          	beq	a5,a4,6a4 <vprintf+0x250>
 500:	02500713          	li	a4,37
 504:	04e79563          	bne	a5,a4,54e <vprintf+0xfa>
 508:	02500593          	li	a1,37
 50c:	855a                	mv	a0,s6
 50e:	e81ff0ef          	jal	38e <putc>
 512:	4981                	li	s3,0
 514:	b769                	j	49e <vprintf+0x4a>
 516:	008b8913          	addi	s2,s7,8
 51a:	4685                	li	a3,1
 51c:	4629                	li	a2,10
 51e:	000ba583          	lw	a1,0(s7)
 522:	855a                	mv	a0,s6
 524:	e89ff0ef          	jal	3ac <printint>
 528:	8bca                	mv	s7,s2
 52a:	4981                	li	s3,0
 52c:	bf8d                	j	49e <vprintf+0x4a>
 52e:	06400793          	li	a5,100
 532:	02f68963          	beq	a3,a5,564 <vprintf+0x110>
 536:	06c00793          	li	a5,108
 53a:	04f68263          	beq	a3,a5,57e <vprintf+0x12a>
 53e:	07500793          	li	a5,117
 542:	0af68063          	beq	a3,a5,5e2 <vprintf+0x18e>
 546:	07800793          	li	a5,120
 54a:	0ef68263          	beq	a3,a5,62e <vprintf+0x1da>
 54e:	02500593          	li	a1,37
 552:	855a                	mv	a0,s6
 554:	e3bff0ef          	jal	38e <putc>
 558:	85ca                	mv	a1,s2
 55a:	855a                	mv	a0,s6
 55c:	e33ff0ef          	jal	38e <putc>
 560:	4981                	li	s3,0
 562:	bf35                	j	49e <vprintf+0x4a>
 564:	008b8913          	addi	s2,s7,8
 568:	4685                	li	a3,1
 56a:	4629                	li	a2,10
 56c:	000bb583          	ld	a1,0(s7)
 570:	855a                	mv	a0,s6
 572:	e3bff0ef          	jal	3ac <printint>
 576:	2485                	addiw	s1,s1,1
 578:	8bca                	mv	s7,s2
 57a:	4981                	li	s3,0
 57c:	b70d                	j	49e <vprintf+0x4a>
 57e:	06400793          	li	a5,100
 582:	02f60763          	beq	a2,a5,5b0 <vprintf+0x15c>
 586:	07500793          	li	a5,117
 58a:	06f60963          	beq	a2,a5,5fc <vprintf+0x1a8>
 58e:	07800793          	li	a5,120
 592:	faf61ee3          	bne	a2,a5,54e <vprintf+0xfa>
 596:	008b8913          	addi	s2,s7,8
 59a:	4681                	li	a3,0
 59c:	4641                	li	a2,16
 59e:	000bb583          	ld	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	e09ff0ef          	jal	3ac <printint>
 5a8:	2489                	addiw	s1,s1,2
 5aa:	8bca                	mv	s7,s2
 5ac:	4981                	li	s3,0
 5ae:	bdc5                	j	49e <vprintf+0x4a>
 5b0:	008b8913          	addi	s2,s7,8
 5b4:	4685                	li	a3,1
 5b6:	4629                	li	a2,10
 5b8:	000bb583          	ld	a1,0(s7)
 5bc:	855a                	mv	a0,s6
 5be:	defff0ef          	jal	3ac <printint>
 5c2:	2489                	addiw	s1,s1,2
 5c4:	8bca                	mv	s7,s2
 5c6:	4981                	li	s3,0
 5c8:	bdd9                	j	49e <vprintf+0x4a>
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	4681                	li	a3,0
 5d0:	4629                	li	a2,10
 5d2:	000be583          	lwu	a1,0(s7)
 5d6:	855a                	mv	a0,s6
 5d8:	dd5ff0ef          	jal	3ac <printint>
 5dc:	8bca                	mv	s7,s2
 5de:	4981                	li	s3,0
 5e0:	bd7d                	j	49e <vprintf+0x4a>
 5e2:	008b8913          	addi	s2,s7,8
 5e6:	4681                	li	a3,0
 5e8:	4629                	li	a2,10
 5ea:	000bb583          	ld	a1,0(s7)
 5ee:	855a                	mv	a0,s6
 5f0:	dbdff0ef          	jal	3ac <printint>
 5f4:	2485                	addiw	s1,s1,1
 5f6:	8bca                	mv	s7,s2
 5f8:	4981                	li	s3,0
 5fa:	b555                	j	49e <vprintf+0x4a>
 5fc:	008b8913          	addi	s2,s7,8
 600:	4681                	li	a3,0
 602:	4629                	li	a2,10
 604:	000bb583          	ld	a1,0(s7)
 608:	855a                	mv	a0,s6
 60a:	da3ff0ef          	jal	3ac <printint>
 60e:	2489                	addiw	s1,s1,2
 610:	8bca                	mv	s7,s2
 612:	4981                	li	s3,0
 614:	b569                	j	49e <vprintf+0x4a>
 616:	008b8913          	addi	s2,s7,8
 61a:	4681                	li	a3,0
 61c:	4641                	li	a2,16
 61e:	000be583          	lwu	a1,0(s7)
 622:	855a                	mv	a0,s6
 624:	d89ff0ef          	jal	3ac <printint>
 628:	8bca                	mv	s7,s2
 62a:	4981                	li	s3,0
 62c:	bd8d                	j	49e <vprintf+0x4a>
 62e:	008b8913          	addi	s2,s7,8
 632:	4681                	li	a3,0
 634:	4641                	li	a2,16
 636:	000bb583          	ld	a1,0(s7)
 63a:	855a                	mv	a0,s6
 63c:	d71ff0ef          	jal	3ac <printint>
 640:	2485                	addiw	s1,s1,1
 642:	8bca                	mv	s7,s2
 644:	4981                	li	s3,0
 646:	bda1                	j	49e <vprintf+0x4a>
 648:	e06a                	sd	s10,0(sp)
 64a:	008b8d13          	addi	s10,s7,8
 64e:	000bb983          	ld	s3,0(s7)
 652:	03000593          	li	a1,48
 656:	855a                	mv	a0,s6
 658:	d37ff0ef          	jal	38e <putc>
 65c:	07800593          	li	a1,120
 660:	855a                	mv	a0,s6
 662:	d2dff0ef          	jal	38e <putc>
 666:	4941                	li	s2,16
 668:	00000b97          	auipc	s7,0x0
 66c:	288b8b93          	addi	s7,s7,648 # 8f0 <digits>
 670:	03c9d793          	srli	a5,s3,0x3c
 674:	97de                	add	a5,a5,s7
 676:	0007c583          	lbu	a1,0(a5)
 67a:	855a                	mv	a0,s6
 67c:	d13ff0ef          	jal	38e <putc>
 680:	0992                	slli	s3,s3,0x4
 682:	397d                	addiw	s2,s2,-1
 684:	fe0916e3          	bnez	s2,670 <vprintf+0x21c>
 688:	8bea                	mv	s7,s10
 68a:	4981                	li	s3,0
 68c:	6d02                	ld	s10,0(sp)
 68e:	bd01                	j	49e <vprintf+0x4a>
 690:	008b8913          	addi	s2,s7,8
 694:	000bc583          	lbu	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	cf5ff0ef          	jal	38e <putc>
 69e:	8bca                	mv	s7,s2
 6a0:	4981                	li	s3,0
 6a2:	bbf5                	j	49e <vprintf+0x4a>
 6a4:	008b8993          	addi	s3,s7,8
 6a8:	000bb903          	ld	s2,0(s7)
 6ac:	00090f63          	beqz	s2,6ca <vprintf+0x276>
 6b0:	00094583          	lbu	a1,0(s2)
 6b4:	c195                	beqz	a1,6d8 <vprintf+0x284>
 6b6:	855a                	mv	a0,s6
 6b8:	cd7ff0ef          	jal	38e <putc>
 6bc:	0905                	addi	s2,s2,1
 6be:	00094583          	lbu	a1,0(s2)
 6c2:	f9f5                	bnez	a1,6b6 <vprintf+0x262>
 6c4:	8bce                	mv	s7,s3
 6c6:	4981                	li	s3,0
 6c8:	bbd9                	j	49e <vprintf+0x4a>
 6ca:	00000917          	auipc	s2,0x0
 6ce:	21e90913          	addi	s2,s2,542 # 8e8 <malloc+0x112>
 6d2:	02800593          	li	a1,40
 6d6:	b7c5                	j	6b6 <vprintf+0x262>
 6d8:	8bce                	mv	s7,s3
 6da:	4981                	li	s3,0
 6dc:	b3c9                	j	49e <vprintf+0x4a>
 6de:	64a6                	ld	s1,72(sp)
 6e0:	79e2                	ld	s3,56(sp)
 6e2:	7a42                	ld	s4,48(sp)
 6e4:	7aa2                	ld	s5,40(sp)
 6e6:	7b02                	ld	s6,32(sp)
 6e8:	6be2                	ld	s7,24(sp)
 6ea:	6c42                	ld	s8,16(sp)
 6ec:	6ca2                	ld	s9,8(sp)
 6ee:	60e6                	ld	ra,88(sp)
 6f0:	6446                	ld	s0,80(sp)
 6f2:	6906                	ld	s2,64(sp)
 6f4:	6125                	addi	sp,sp,96
 6f6:	8082                	ret

00000000000006f8 <fprintf>:
 6f8:	715d                	addi	sp,sp,-80
 6fa:	ec06                	sd	ra,24(sp)
 6fc:	e822                	sd	s0,16(sp)
 6fe:	1000                	addi	s0,sp,32
 700:	e010                	sd	a2,0(s0)
 702:	e414                	sd	a3,8(s0)
 704:	e818                	sd	a4,16(s0)
 706:	ec1c                	sd	a5,24(s0)
 708:	03043023          	sd	a6,32(s0)
 70c:	03143423          	sd	a7,40(s0)
 710:	fe843423          	sd	s0,-24(s0)
 714:	8622                	mv	a2,s0
 716:	d3fff0ef          	jal	454 <vprintf>
 71a:	60e2                	ld	ra,24(sp)
 71c:	6442                	ld	s0,16(sp)
 71e:	6161                	addi	sp,sp,80
 720:	8082                	ret

0000000000000722 <printf>:
 722:	711d                	addi	sp,sp,-96
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	addi	s0,sp,32
 72a:	e40c                	sd	a1,8(s0)
 72c:	e810                	sd	a2,16(s0)
 72e:	ec14                	sd	a3,24(s0)
 730:	f018                	sd	a4,32(s0)
 732:	f41c                	sd	a5,40(s0)
 734:	03043823          	sd	a6,48(s0)
 738:	03143c23          	sd	a7,56(s0)
 73c:	00840613          	addi	a2,s0,8
 740:	fec43423          	sd	a2,-24(s0)
 744:	85aa                	mv	a1,a0
 746:	4505                	li	a0,1
 748:	d0dff0ef          	jal	454 <vprintf>
 74c:	60e2                	ld	ra,24(sp)
 74e:	6442                	ld	s0,16(sp)
 750:	6125                	addi	sp,sp,96
 752:	8082                	ret

0000000000000754 <free>:
 754:	1141                	addi	sp,sp,-16
 756:	e422                	sd	s0,8(sp)
 758:	0800                	addi	s0,sp,16
 75a:	ff050693          	addi	a3,a0,-16
 75e:	00001797          	auipc	a5,0x1
 762:	8a27b783          	ld	a5,-1886(a5) # 1000 <freep>
 766:	a02d                	j	790 <free+0x3c>
 768:	4618                	lw	a4,8(a2)
 76a:	9f2d                	addw	a4,a4,a1
 76c:	fee52c23          	sw	a4,-8(a0)
 770:	6398                	ld	a4,0(a5)
 772:	6310                	ld	a2,0(a4)
 774:	a83d                	j	7b2 <free+0x5e>
 776:	ff852703          	lw	a4,-8(a0)
 77a:	9f31                	addw	a4,a4,a2
 77c:	c798                	sw	a4,8(a5)
 77e:	ff053683          	ld	a3,-16(a0)
 782:	a091                	j	7c6 <free+0x72>
 784:	6398                	ld	a4,0(a5)
 786:	00e7e463          	bltu	a5,a4,78e <free+0x3a>
 78a:	00e6ea63          	bltu	a3,a4,79e <free+0x4a>
 78e:	87ba                	mv	a5,a4
 790:	fed7fae3          	bgeu	a5,a3,784 <free+0x30>
 794:	6398                	ld	a4,0(a5)
 796:	00e6e463          	bltu	a3,a4,79e <free+0x4a>
 79a:	fee7eae3          	bltu	a5,a4,78e <free+0x3a>
 79e:	ff852583          	lw	a1,-8(a0)
 7a2:	6390                	ld	a2,0(a5)
 7a4:	02059813          	slli	a6,a1,0x20
 7a8:	01c85713          	srli	a4,a6,0x1c
 7ac:	9736                	add	a4,a4,a3
 7ae:	fae60de3          	beq	a2,a4,768 <free+0x14>
 7b2:	fec53823          	sd	a2,-16(a0)
 7b6:	4790                	lw	a2,8(a5)
 7b8:	02061593          	slli	a1,a2,0x20
 7bc:	01c5d713          	srli	a4,a1,0x1c
 7c0:	973e                	add	a4,a4,a5
 7c2:	fae68ae3          	beq	a3,a4,776 <free+0x22>
 7c6:	e394                	sd	a3,0(a5)
 7c8:	00001717          	auipc	a4,0x1
 7cc:	82f73c23          	sd	a5,-1992(a4) # 1000 <freep>
 7d0:	6422                	ld	s0,8(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

00000000000007d6 <malloc>:
 7d6:	7139                	addi	sp,sp,-64
 7d8:	fc06                	sd	ra,56(sp)
 7da:	f822                	sd	s0,48(sp)
 7dc:	f426                	sd	s1,40(sp)
 7de:	ec4e                	sd	s3,24(sp)
 7e0:	0080                	addi	s0,sp,64
 7e2:	02051493          	slli	s1,a0,0x20
 7e6:	9081                	srli	s1,s1,0x20
 7e8:	04bd                	addi	s1,s1,15
 7ea:	8091                	srli	s1,s1,0x4
 7ec:	0014899b          	addiw	s3,s1,1
 7f0:	0485                	addi	s1,s1,1
 7f2:	00001517          	auipc	a0,0x1
 7f6:	80e53503          	ld	a0,-2034(a0) # 1000 <freep>
 7fa:	c915                	beqz	a0,82e <malloc+0x58>
 7fc:	611c                	ld	a5,0(a0)
 7fe:	4798                	lw	a4,8(a5)
 800:	08977a63          	bgeu	a4,s1,894 <malloc+0xbe>
 804:	f04a                	sd	s2,32(sp)
 806:	e852                	sd	s4,16(sp)
 808:	e456                	sd	s5,8(sp)
 80a:	e05a                	sd	s6,0(sp)
 80c:	8a4e                	mv	s4,s3
 80e:	0009871b          	sext.w	a4,s3
 812:	6685                	lui	a3,0x1
 814:	00d77363          	bgeu	a4,a3,81a <malloc+0x44>
 818:	6a05                	lui	s4,0x1
 81a:	000a0b1b          	sext.w	s6,s4
 81e:	004a1a1b          	slliw	s4,s4,0x4
 822:	00000917          	auipc	s2,0x0
 826:	7de90913          	addi	s2,s2,2014 # 1000 <freep>
 82a:	5afd                	li	s5,-1
 82c:	a081                	j	86c <malloc+0x96>
 82e:	f04a                	sd	s2,32(sp)
 830:	e852                	sd	s4,16(sp)
 832:	e456                	sd	s5,8(sp)
 834:	e05a                	sd	s6,0(sp)
 836:	00000797          	auipc	a5,0x0
 83a:	7da78793          	addi	a5,a5,2010 # 1010 <base>
 83e:	00000717          	auipc	a4,0x0
 842:	7cf73123          	sd	a5,1986(a4) # 1000 <freep>
 846:	e39c                	sd	a5,0(a5)
 848:	0007a423          	sw	zero,8(a5)
 84c:	b7c1                	j	80c <malloc+0x36>
 84e:	6398                	ld	a4,0(a5)
 850:	e118                	sd	a4,0(a0)
 852:	a8a9                	j	8ac <malloc+0xd6>
 854:	01652423          	sw	s6,8(a0)
 858:	0541                	addi	a0,a0,16
 85a:	efbff0ef          	jal	754 <free>
 85e:	00093503          	ld	a0,0(s2)
 862:	c12d                	beqz	a0,8c4 <malloc+0xee>
 864:	611c                	ld	a5,0(a0)
 866:	4798                	lw	a4,8(a5)
 868:	02977263          	bgeu	a4,s1,88c <malloc+0xb6>
 86c:	00093703          	ld	a4,0(s2)
 870:	853e                	mv	a0,a5
 872:	fef719e3          	bne	a4,a5,864 <malloc+0x8e>
 876:	8552                	mv	a0,s4
 878:	a43ff0ef          	jal	2ba <sbrk>
 87c:	fd551ce3          	bne	a0,s5,854 <malloc+0x7e>
 880:	4501                	li	a0,0
 882:	7902                	ld	s2,32(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	a03d                	j	8b8 <malloc+0xe2>
 88c:	7902                	ld	s2,32(sp)
 88e:	6a42                	ld	s4,16(sp)
 890:	6aa2                	ld	s5,8(sp)
 892:	6b02                	ld	s6,0(sp)
 894:	fae48de3          	beq	s1,a4,84e <malloc+0x78>
 898:	4137073b          	subw	a4,a4,s3
 89c:	c798                	sw	a4,8(a5)
 89e:	02071693          	slli	a3,a4,0x20
 8a2:	01c6d713          	srli	a4,a3,0x1c
 8a6:	97ba                	add	a5,a5,a4
 8a8:	0137a423          	sw	s3,8(a5)
 8ac:	00000717          	auipc	a4,0x0
 8b0:	74a73a23          	sd	a0,1876(a4) # 1000 <freep>
 8b4:	01078513          	addi	a0,a5,16
 8b8:	70e2                	ld	ra,56(sp)
 8ba:	7442                	ld	s0,48(sp)
 8bc:	74a2                	ld	s1,40(sp)
 8be:	69e2                	ld	s3,24(sp)
 8c0:	6121                	addi	sp,sp,64
 8c2:	8082                	ret
 8c4:	7902                	ld	s2,32(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	b7f5                	j	8b8 <malloc+0xe2>
