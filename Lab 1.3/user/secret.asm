
user/_secret:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char data[DATASIZE];

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 2){
   8:	4789                	li	a5,2
   a:	00f50c63          	beq	a0,a5,22 <main+0x22>
   e:	e426                	sd	s1,8(sp)
    printf("Usage: secret the-secret\n");
  10:	00001517          	auipc	a0,0x1
  14:	8c050513          	addi	a0,a0,-1856 # 8d0 <malloc+0x104>
  18:	700000ef          	jal	718 <printf>
    exit(1);
  1c:	4505                	li	a0,1
  1e:	2c6000ef          	jal	2e4 <exit>
  22:	e426                	sd	s1,8(sp)
  24:	84ae                	mv	s1,a1
  }

  strcpy(data, "This may help.");
  26:	00001597          	auipc	a1,0x1
  2a:	8ca58593          	addi	a1,a1,-1846 # 8f0 <malloc+0x124>
  2e:	00001517          	auipc	a0,0x1
  32:	fe250513          	addi	a0,a0,-30 # 1010 <data>
  36:	02a000ef          	jal	60 <strcpy>

  strcpy(data + 16, argv[1]);
  3a:	648c                	ld	a1,8(s1)
  3c:	00001517          	auipc	a0,0x1
  40:	fe450513          	addi	a0,a0,-28 # 1020 <data+0x10>
  44:	01c000ef          	jal	60 <strcpy>

  exit(0);
  48:	4501                	li	a0,0
  4a:	29a000ef          	jal	2e4 <exit>

000000000000004e <start>:
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  56:	fabff0ef          	jal	0 <main>
  5a:	4501                	li	a0,0
  5c:	288000ef          	jal	2e4 <exit>

0000000000000060 <strcpy>:
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  82:	00054783          	lbu	a5,0(a0)
  86:	cb91                	beqz	a5,9a <strcmp+0x1e>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71763          	bne	a4,a5,9a <strcmp+0x1e>
  90:	0505                	addi	a0,a0,1
  92:	0585                	addi	a1,a1,1
  94:	00054783          	lbu	a5,0(a0)
  98:	fbe5                	bnez	a5,88 <strcmp+0xc>
  9a:	0005c503          	lbu	a0,0(a1)
  9e:	40a7853b          	subw	a0,a5,a0
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strlen>:
  a8:	1141                	addi	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	addi	s0,sp,16
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf91                	beqz	a5,ce <strlen+0x26>
  b4:	0505                	addi	a0,a0,1
  b6:	87aa                	mv	a5,a0
  b8:	86be                	mv	a3,a5
  ba:	0785                	addi	a5,a5,1
  bc:	fff7c703          	lbu	a4,-1(a5)
  c0:	ff65                	bnez	a4,b8 <strlen+0x10>
  c2:	40a6853b          	subw	a0,a3,a0
  c6:	2505                	addiw	a0,a0,1
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret
  ce:	4501                	li	a0,0
  d0:	bfe5                	j	c8 <strlen+0x20>

00000000000000d2 <memset>:
  d2:	1141                	addi	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	addi	s0,sp,16
  d8:	ca19                	beqz	a2,ee <memset+0x1c>
  da:	87aa                	mv	a5,a0
  dc:	1602                	slli	a2,a2,0x20
  de:	9201                	srli	a2,a2,0x20
  e0:	00a60733          	add	a4,a2,a0
  e4:	00b78023          	sb	a1,0(a5)
  e8:	0785                	addi	a5,a5,1
  ea:	fee79de3          	bne	a5,a4,e4 <memset+0x12>
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strchr>:
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb99                	beqz	a5,114 <strchr+0x20>
 100:	00f58763          	beq	a1,a5,10e <strchr+0x1a>
 104:	0505                	addi	a0,a0,1
 106:	00054783          	lbu	a5,0(a0)
 10a:	fbfd                	bnez	a5,100 <strchr+0xc>
 10c:	4501                	li	a0,0
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strchr+0x1a>

0000000000000118 <gets>:
 118:	711d                	addi	sp,sp,-96
 11a:	ec86                	sd	ra,88(sp)
 11c:	e8a2                	sd	s0,80(sp)
 11e:	e4a6                	sd	s1,72(sp)
 120:	e0ca                	sd	s2,64(sp)
 122:	fc4e                	sd	s3,56(sp)
 124:	f852                	sd	s4,48(sp)
 126:	f456                	sd	s5,40(sp)
 128:	f05a                	sd	s6,32(sp)
 12a:	ec5e                	sd	s7,24(sp)
 12c:	1080                	addi	s0,sp,96
 12e:	8baa                	mv	s7,a0
 130:	8a2e                	mv	s4,a1
 132:	892a                	mv	s2,a0
 134:	4481                	li	s1,0
 136:	4aa9                	li	s5,10
 138:	4b35                	li	s6,13
 13a:	89a6                	mv	s3,s1
 13c:	2485                	addiw	s1,s1,1
 13e:	0344d663          	bge	s1,s4,16a <gets+0x52>
 142:	4605                	li	a2,1
 144:	faf40593          	addi	a1,s0,-81
 148:	4501                	li	a0,0
 14a:	1b2000ef          	jal	2fc <read>
 14e:	00a05e63          	blez	a0,16a <gets+0x52>
 152:	faf44783          	lbu	a5,-81(s0)
 156:	00f90023          	sb	a5,0(s2)
 15a:	01578763          	beq	a5,s5,168 <gets+0x50>
 15e:	0905                	addi	s2,s2,1
 160:	fd679de3          	bne	a5,s6,13a <gets+0x22>
 164:	89a6                	mv	s3,s1
 166:	a011                	j	16a <gets+0x52>
 168:	89a6                	mv	s3,s1
 16a:	99de                	add	s3,s3,s7
 16c:	00098023          	sb	zero,0(s3)
 170:	855e                	mv	a0,s7
 172:	60e6                	ld	ra,88(sp)
 174:	6446                	ld	s0,80(sp)
 176:	64a6                	ld	s1,72(sp)
 178:	6906                	ld	s2,64(sp)
 17a:	79e2                	ld	s3,56(sp)
 17c:	7a42                	ld	s4,48(sp)
 17e:	7aa2                	ld	s5,40(sp)
 180:	7b02                	ld	s6,32(sp)
 182:	6be2                	ld	s7,24(sp)
 184:	6125                	addi	sp,sp,96
 186:	8082                	ret

0000000000000188 <stat>:
 188:	1101                	addi	sp,sp,-32
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	addi	s0,sp,32
 192:	892e                	mv	s2,a1
 194:	4581                	li	a1,0
 196:	18e000ef          	jal	324 <open>
 19a:	02054263          	bltz	a0,1be <stat+0x36>
 19e:	e426                	sd	s1,8(sp)
 1a0:	84aa                	mv	s1,a0
 1a2:	85ca                	mv	a1,s2
 1a4:	198000ef          	jal	33c <fstat>
 1a8:	892a                	mv	s2,a0
 1aa:	8526                	mv	a0,s1
 1ac:	160000ef          	jal	30c <close>
 1b0:	64a2                	ld	s1,8(sp)
 1b2:	854a                	mv	a0,s2
 1b4:	60e2                	ld	ra,24(sp)
 1b6:	6442                	ld	s0,16(sp)
 1b8:	6902                	ld	s2,0(sp)
 1ba:	6105                	addi	sp,sp,32
 1bc:	8082                	ret
 1be:	597d                	li	s2,-1
 1c0:	bfcd                	j	1b2 <stat+0x2a>

00000000000001c2 <atoi>:
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
 1c8:	00054683          	lbu	a3,0(a0)
 1cc:	fd06879b          	addiw	a5,a3,-48
 1d0:	0ff7f793          	zext.b	a5,a5
 1d4:	4625                	li	a2,9
 1d6:	02f66863          	bltu	a2,a5,206 <atoi+0x44>
 1da:	872a                	mv	a4,a0
 1dc:	4501                	li	a0,0
 1de:	0705                	addi	a4,a4,1
 1e0:	0025179b          	slliw	a5,a0,0x2
 1e4:	9fa9                	addw	a5,a5,a0
 1e6:	0017979b          	slliw	a5,a5,0x1
 1ea:	9fb5                	addw	a5,a5,a3
 1ec:	fd07851b          	addiw	a0,a5,-48
 1f0:	00074683          	lbu	a3,0(a4)
 1f4:	fd06879b          	addiw	a5,a3,-48
 1f8:	0ff7f793          	zext.b	a5,a5
 1fc:	fef671e3          	bgeu	a2,a5,1de <atoi+0x1c>
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
 206:	4501                	li	a0,0
 208:	bfe5                	j	200 <atoi+0x3e>

000000000000020a <memmove>:
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
 210:	02b57463          	bgeu	a0,a1,238 <memmove+0x2e>
 214:	00c05f63          	blez	a2,232 <memmove+0x28>
 218:	1602                	slli	a2,a2,0x20
 21a:	9201                	srli	a2,a2,0x20
 21c:	00c507b3          	add	a5,a0,a2
 220:	872a                	mv	a4,a0
 222:	0585                	addi	a1,a1,1
 224:	0705                	addi	a4,a4,1
 226:	fff5c683          	lbu	a3,-1(a1)
 22a:	fed70fa3          	sb	a3,-1(a4)
 22e:	fef71ae3          	bne	a4,a5,222 <memmove+0x18>
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
 238:	00c50733          	add	a4,a0,a2
 23c:	95b2                	add	a1,a1,a2
 23e:	fec05ae3          	blez	a2,232 <memmove+0x28>
 242:	fff6079b          	addiw	a5,a2,-1
 246:	1782                	slli	a5,a5,0x20
 248:	9381                	srli	a5,a5,0x20
 24a:	fff7c793          	not	a5,a5
 24e:	97ba                	add	a5,a5,a4
 250:	15fd                	addi	a1,a1,-1
 252:	177d                	addi	a4,a4,-1
 254:	0005c683          	lbu	a3,0(a1)
 258:	00d70023          	sb	a3,0(a4)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x46>
 260:	bfc9                	j	232 <memmove+0x28>

0000000000000262 <memcmp>:
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
 268:	ca05                	beqz	a2,298 <memcmp+0x36>
 26a:	fff6069b          	addiw	a3,a2,-1
 26e:	1682                	slli	a3,a3,0x20
 270:	9281                	srli	a3,a3,0x20
 272:	0685                	addi	a3,a3,1
 274:	96aa                	add	a3,a3,a0
 276:	00054783          	lbu	a5,0(a0)
 27a:	0005c703          	lbu	a4,0(a1)
 27e:	00e79863          	bne	a5,a4,28e <memcmp+0x2c>
 282:	0505                	addi	a0,a0,1
 284:	0585                	addi	a1,a1,1
 286:	fed518e3          	bne	a0,a3,276 <memcmp+0x14>
 28a:	4501                	li	a0,0
 28c:	a019                	j	292 <memcmp+0x30>
 28e:	40e7853b          	subw	a0,a5,a4
 292:	6422                	ld	s0,8(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
 298:	4501                	li	a0,0
 29a:	bfe5                	j	292 <memcmp+0x30>

000000000000029c <memcpy>:
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
 2a4:	f67ff0ef          	jal	20a <memmove>
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <sbrk>:
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e406                	sd	ra,8(sp)
 2b4:	e022                	sd	s0,0(sp)
 2b6:	0800                	addi	s0,sp,16
 2b8:	4585                	li	a1,1
 2ba:	0b2000ef          	jal	36c <sys_sbrk>
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <sbrklazy>:
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
 2ce:	4589                	li	a1,2
 2d0:	09c000ef          	jal	36c <sys_sbrk>
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <fork>:
 2dc:	4885                	li	a7,1
 2de:	00000073          	ecall
 2e2:	8082                	ret

00000000000002e4 <exit>:
 2e4:	4889                	li	a7,2
 2e6:	00000073          	ecall
 2ea:	8082                	ret

00000000000002ec <wait>:
 2ec:	488d                	li	a7,3
 2ee:	00000073          	ecall
 2f2:	8082                	ret

00000000000002f4 <pipe>:
 2f4:	4891                	li	a7,4
 2f6:	00000073          	ecall
 2fa:	8082                	ret

00000000000002fc <read>:
 2fc:	4895                	li	a7,5
 2fe:	00000073          	ecall
 302:	8082                	ret

0000000000000304 <write>:
 304:	48c1                	li	a7,16
 306:	00000073          	ecall
 30a:	8082                	ret

000000000000030c <close>:
 30c:	48d5                	li	a7,21
 30e:	00000073          	ecall
 312:	8082                	ret

0000000000000314 <kill>:
 314:	4899                	li	a7,6
 316:	00000073          	ecall
 31a:	8082                	ret

000000000000031c <exec>:
 31c:	489d                	li	a7,7
 31e:	00000073          	ecall
 322:	8082                	ret

0000000000000324 <open>:
 324:	48bd                	li	a7,15
 326:	00000073          	ecall
 32a:	8082                	ret

000000000000032c <mknod>:
 32c:	48c5                	li	a7,17
 32e:	00000073          	ecall
 332:	8082                	ret

0000000000000334 <unlink>:
 334:	48c9                	li	a7,18
 336:	00000073          	ecall
 33a:	8082                	ret

000000000000033c <fstat>:
 33c:	48a1                	li	a7,8
 33e:	00000073          	ecall
 342:	8082                	ret

0000000000000344 <link>:
 344:	48cd                	li	a7,19
 346:	00000073          	ecall
 34a:	8082                	ret

000000000000034c <mkdir>:
 34c:	48d1                	li	a7,20
 34e:	00000073          	ecall
 352:	8082                	ret

0000000000000354 <chdir>:
 354:	48a5                	li	a7,9
 356:	00000073          	ecall
 35a:	8082                	ret

000000000000035c <dup>:
 35c:	48a9                	li	a7,10
 35e:	00000073          	ecall
 362:	8082                	ret

0000000000000364 <getpid>:
 364:	48ad                	li	a7,11
 366:	00000073          	ecall
 36a:	8082                	ret

000000000000036c <sys_sbrk>:
 36c:	48b1                	li	a7,12
 36e:	00000073          	ecall
 372:	8082                	ret

0000000000000374 <pause>:
 374:	48b5                	li	a7,13
 376:	00000073          	ecall
 37a:	8082                	ret

000000000000037c <uptime>:
 37c:	48b9                	li	a7,14
 37e:	00000073          	ecall
 382:	8082                	ret

0000000000000384 <putc>:
 384:	1101                	addi	sp,sp,-32
 386:	ec06                	sd	ra,24(sp)
 388:	e822                	sd	s0,16(sp)
 38a:	1000                	addi	s0,sp,32
 38c:	feb407a3          	sb	a1,-17(s0)
 390:	4605                	li	a2,1
 392:	fef40593          	addi	a1,s0,-17
 396:	f6fff0ef          	jal	304 <write>
 39a:	60e2                	ld	ra,24(sp)
 39c:	6442                	ld	s0,16(sp)
 39e:	6105                	addi	sp,sp,32
 3a0:	8082                	ret

00000000000003a2 <printint>:
 3a2:	715d                	addi	sp,sp,-80
 3a4:	e486                	sd	ra,72(sp)
 3a6:	e0a2                	sd	s0,64(sp)
 3a8:	fc26                	sd	s1,56(sp)
 3aa:	0880                	addi	s0,sp,80
 3ac:	84aa                	mv	s1,a0
 3ae:	c299                	beqz	a3,3b4 <printint+0x12>
 3b0:	0805c963          	bltz	a1,442 <printint+0xa0>
 3b4:	2581                	sext.w	a1,a1
 3b6:	4881                	li	a7,0
 3b8:	fb840693          	addi	a3,s0,-72
 3bc:	4701                	li	a4,0
 3be:	2601                	sext.w	a2,a2
 3c0:	00000517          	auipc	a0,0x0
 3c4:	54850513          	addi	a0,a0,1352 # 908 <digits>
 3c8:	883a                	mv	a6,a4
 3ca:	2705                	addiw	a4,a4,1
 3cc:	02c5f7bb          	remuw	a5,a1,a2
 3d0:	1782                	slli	a5,a5,0x20
 3d2:	9381                	srli	a5,a5,0x20
 3d4:	97aa                	add	a5,a5,a0
 3d6:	0007c783          	lbu	a5,0(a5)
 3da:	00f68023          	sb	a5,0(a3)
 3de:	0005879b          	sext.w	a5,a1
 3e2:	02c5d5bb          	divuw	a1,a1,a2
 3e6:	0685                	addi	a3,a3,1
 3e8:	fec7f0e3          	bgeu	a5,a2,3c8 <printint+0x26>
 3ec:	00088c63          	beqz	a7,404 <printint+0x62>
 3f0:	fd070793          	addi	a5,a4,-48
 3f4:	00878733          	add	a4,a5,s0
 3f8:	02d00793          	li	a5,45
 3fc:	fef70423          	sb	a5,-24(a4)
 400:	0028071b          	addiw	a4,a6,2
 404:	02e05a63          	blez	a4,438 <printint+0x96>
 408:	f84a                	sd	s2,48(sp)
 40a:	f44e                	sd	s3,40(sp)
 40c:	fb840793          	addi	a5,s0,-72
 410:	00e78933          	add	s2,a5,a4
 414:	fff78993          	addi	s3,a5,-1
 418:	99ba                	add	s3,s3,a4
 41a:	377d                	addiw	a4,a4,-1
 41c:	1702                	slli	a4,a4,0x20
 41e:	9301                	srli	a4,a4,0x20
 420:	40e989b3          	sub	s3,s3,a4
 424:	fff94583          	lbu	a1,-1(s2)
 428:	8526                	mv	a0,s1
 42a:	f5bff0ef          	jal	384 <putc>
 42e:	197d                	addi	s2,s2,-1
 430:	ff391ae3          	bne	s2,s3,424 <printint+0x82>
 434:	7942                	ld	s2,48(sp)
 436:	79a2                	ld	s3,40(sp)
 438:	60a6                	ld	ra,72(sp)
 43a:	6406                	ld	s0,64(sp)
 43c:	74e2                	ld	s1,56(sp)
 43e:	6161                	addi	sp,sp,80
 440:	8082                	ret
 442:	40b005bb          	negw	a1,a1
 446:	4885                	li	a7,1
 448:	bf85                	j	3b8 <printint+0x16>

000000000000044a <vprintf>:
 44a:	711d                	addi	sp,sp,-96
 44c:	ec86                	sd	ra,88(sp)
 44e:	e8a2                	sd	s0,80(sp)
 450:	e0ca                	sd	s2,64(sp)
 452:	1080                	addi	s0,sp,96
 454:	0005c903          	lbu	s2,0(a1)
 458:	28090663          	beqz	s2,6e4 <vprintf+0x29a>
 45c:	e4a6                	sd	s1,72(sp)
 45e:	fc4e                	sd	s3,56(sp)
 460:	f852                	sd	s4,48(sp)
 462:	f456                	sd	s5,40(sp)
 464:	f05a                	sd	s6,32(sp)
 466:	ec5e                	sd	s7,24(sp)
 468:	e862                	sd	s8,16(sp)
 46a:	e466                	sd	s9,8(sp)
 46c:	8b2a                	mv	s6,a0
 46e:	8a2e                	mv	s4,a1
 470:	8bb2                	mv	s7,a2
 472:	4981                	li	s3,0
 474:	4481                	li	s1,0
 476:	4701                	li	a4,0
 478:	02500a93          	li	s5,37
 47c:	06400c13          	li	s8,100
 480:	06c00c93          	li	s9,108
 484:	a005                	j	4a4 <vprintf+0x5a>
 486:	85ca                	mv	a1,s2
 488:	855a                	mv	a0,s6
 48a:	efbff0ef          	jal	384 <putc>
 48e:	a019                	j	494 <vprintf+0x4a>
 490:	03598263          	beq	s3,s5,4b4 <vprintf+0x6a>
 494:	2485                	addiw	s1,s1,1
 496:	8726                	mv	a4,s1
 498:	009a07b3          	add	a5,s4,s1
 49c:	0007c903          	lbu	s2,0(a5)
 4a0:	22090a63          	beqz	s2,6d4 <vprintf+0x28a>
 4a4:	0009079b          	sext.w	a5,s2
 4a8:	fe0994e3          	bnez	s3,490 <vprintf+0x46>
 4ac:	fd579de3          	bne	a5,s5,486 <vprintf+0x3c>
 4b0:	89be                	mv	s3,a5
 4b2:	b7cd                	j	494 <vprintf+0x4a>
 4b4:	00ea06b3          	add	a3,s4,a4
 4b8:	0016c683          	lbu	a3,1(a3)
 4bc:	8636                	mv	a2,a3
 4be:	c681                	beqz	a3,4c6 <vprintf+0x7c>
 4c0:	9752                	add	a4,a4,s4
 4c2:	00274603          	lbu	a2,2(a4)
 4c6:	05878363          	beq	a5,s8,50c <vprintf+0xc2>
 4ca:	05978d63          	beq	a5,s9,524 <vprintf+0xda>
 4ce:	07500713          	li	a4,117
 4d2:	0ee78763          	beq	a5,a4,5c0 <vprintf+0x176>
 4d6:	07800713          	li	a4,120
 4da:	12e78963          	beq	a5,a4,60c <vprintf+0x1c2>
 4de:	07000713          	li	a4,112
 4e2:	14e78e63          	beq	a5,a4,63e <vprintf+0x1f4>
 4e6:	06300713          	li	a4,99
 4ea:	18e78e63          	beq	a5,a4,686 <vprintf+0x23c>
 4ee:	07300713          	li	a4,115
 4f2:	1ae78463          	beq	a5,a4,69a <vprintf+0x250>
 4f6:	02500713          	li	a4,37
 4fa:	04e79563          	bne	a5,a4,544 <vprintf+0xfa>
 4fe:	02500593          	li	a1,37
 502:	855a                	mv	a0,s6
 504:	e81ff0ef          	jal	384 <putc>
 508:	4981                	li	s3,0
 50a:	b769                	j	494 <vprintf+0x4a>
 50c:	008b8913          	addi	s2,s7,8
 510:	4685                	li	a3,1
 512:	4629                	li	a2,10
 514:	000ba583          	lw	a1,0(s7)
 518:	855a                	mv	a0,s6
 51a:	e89ff0ef          	jal	3a2 <printint>
 51e:	8bca                	mv	s7,s2
 520:	4981                	li	s3,0
 522:	bf8d                	j	494 <vprintf+0x4a>
 524:	06400793          	li	a5,100
 528:	02f68963          	beq	a3,a5,55a <vprintf+0x110>
 52c:	06c00793          	li	a5,108
 530:	04f68263          	beq	a3,a5,574 <vprintf+0x12a>
 534:	07500793          	li	a5,117
 538:	0af68063          	beq	a3,a5,5d8 <vprintf+0x18e>
 53c:	07800793          	li	a5,120
 540:	0ef68263          	beq	a3,a5,624 <vprintf+0x1da>
 544:	02500593          	li	a1,37
 548:	855a                	mv	a0,s6
 54a:	e3bff0ef          	jal	384 <putc>
 54e:	85ca                	mv	a1,s2
 550:	855a                	mv	a0,s6
 552:	e33ff0ef          	jal	384 <putc>
 556:	4981                	li	s3,0
 558:	bf35                	j	494 <vprintf+0x4a>
 55a:	008b8913          	addi	s2,s7,8
 55e:	4685                	li	a3,1
 560:	4629                	li	a2,10
 562:	000bb583          	ld	a1,0(s7)
 566:	855a                	mv	a0,s6
 568:	e3bff0ef          	jal	3a2 <printint>
 56c:	2485                	addiw	s1,s1,1
 56e:	8bca                	mv	s7,s2
 570:	4981                	li	s3,0
 572:	b70d                	j	494 <vprintf+0x4a>
 574:	06400793          	li	a5,100
 578:	02f60763          	beq	a2,a5,5a6 <vprintf+0x15c>
 57c:	07500793          	li	a5,117
 580:	06f60963          	beq	a2,a5,5f2 <vprintf+0x1a8>
 584:	07800793          	li	a5,120
 588:	faf61ee3          	bne	a2,a5,544 <vprintf+0xfa>
 58c:	008b8913          	addi	s2,s7,8
 590:	4681                	li	a3,0
 592:	4641                	li	a2,16
 594:	000bb583          	ld	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	e09ff0ef          	jal	3a2 <printint>
 59e:	2489                	addiw	s1,s1,2
 5a0:	8bca                	mv	s7,s2
 5a2:	4981                	li	s3,0
 5a4:	bdc5                	j	494 <vprintf+0x4a>
 5a6:	008b8913          	addi	s2,s7,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000bb583          	ld	a1,0(s7)
 5b2:	855a                	mv	a0,s6
 5b4:	defff0ef          	jal	3a2 <printint>
 5b8:	2489                	addiw	s1,s1,2
 5ba:	8bca                	mv	s7,s2
 5bc:	4981                	li	s3,0
 5be:	bdd9                	j	494 <vprintf+0x4a>
 5c0:	008b8913          	addi	s2,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4629                	li	a2,10
 5c8:	000be583          	lwu	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	dd5ff0ef          	jal	3a2 <printint>
 5d2:	8bca                	mv	s7,s2
 5d4:	4981                	li	s3,0
 5d6:	bd7d                	j	494 <vprintf+0x4a>
 5d8:	008b8913          	addi	s2,s7,8
 5dc:	4681                	li	a3,0
 5de:	4629                	li	a2,10
 5e0:	000bb583          	ld	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	dbdff0ef          	jal	3a2 <printint>
 5ea:	2485                	addiw	s1,s1,1
 5ec:	8bca                	mv	s7,s2
 5ee:	4981                	li	s3,0
 5f0:	b555                	j	494 <vprintf+0x4a>
 5f2:	008b8913          	addi	s2,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4629                	li	a2,10
 5fa:	000bb583          	ld	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	da3ff0ef          	jal	3a2 <printint>
 604:	2489                	addiw	s1,s1,2
 606:	8bca                	mv	s7,s2
 608:	4981                	li	s3,0
 60a:	b569                	j	494 <vprintf+0x4a>
 60c:	008b8913          	addi	s2,s7,8
 610:	4681                	li	a3,0
 612:	4641                	li	a2,16
 614:	000be583          	lwu	a1,0(s7)
 618:	855a                	mv	a0,s6
 61a:	d89ff0ef          	jal	3a2 <printint>
 61e:	8bca                	mv	s7,s2
 620:	4981                	li	s3,0
 622:	bd8d                	j	494 <vprintf+0x4a>
 624:	008b8913          	addi	s2,s7,8
 628:	4681                	li	a3,0
 62a:	4641                	li	a2,16
 62c:	000bb583          	ld	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	d71ff0ef          	jal	3a2 <printint>
 636:	2485                	addiw	s1,s1,1
 638:	8bca                	mv	s7,s2
 63a:	4981                	li	s3,0
 63c:	bda1                	j	494 <vprintf+0x4a>
 63e:	e06a                	sd	s10,0(sp)
 640:	008b8d13          	addi	s10,s7,8
 644:	000bb983          	ld	s3,0(s7)
 648:	03000593          	li	a1,48
 64c:	855a                	mv	a0,s6
 64e:	d37ff0ef          	jal	384 <putc>
 652:	07800593          	li	a1,120
 656:	855a                	mv	a0,s6
 658:	d2dff0ef          	jal	384 <putc>
 65c:	4941                	li	s2,16
 65e:	00000b97          	auipc	s7,0x0
 662:	2aab8b93          	addi	s7,s7,682 # 908 <digits>
 666:	03c9d793          	srli	a5,s3,0x3c
 66a:	97de                	add	a5,a5,s7
 66c:	0007c583          	lbu	a1,0(a5)
 670:	855a                	mv	a0,s6
 672:	d13ff0ef          	jal	384 <putc>
 676:	0992                	slli	s3,s3,0x4
 678:	397d                	addiw	s2,s2,-1
 67a:	fe0916e3          	bnez	s2,666 <vprintf+0x21c>
 67e:	8bea                	mv	s7,s10
 680:	4981                	li	s3,0
 682:	6d02                	ld	s10,0(sp)
 684:	bd01                	j	494 <vprintf+0x4a>
 686:	008b8913          	addi	s2,s7,8
 68a:	000bc583          	lbu	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	cf5ff0ef          	jal	384 <putc>
 694:	8bca                	mv	s7,s2
 696:	4981                	li	s3,0
 698:	bbf5                	j	494 <vprintf+0x4a>
 69a:	008b8993          	addi	s3,s7,8
 69e:	000bb903          	ld	s2,0(s7)
 6a2:	00090f63          	beqz	s2,6c0 <vprintf+0x276>
 6a6:	00094583          	lbu	a1,0(s2)
 6aa:	c195                	beqz	a1,6ce <vprintf+0x284>
 6ac:	855a                	mv	a0,s6
 6ae:	cd7ff0ef          	jal	384 <putc>
 6b2:	0905                	addi	s2,s2,1
 6b4:	00094583          	lbu	a1,0(s2)
 6b8:	f9f5                	bnez	a1,6ac <vprintf+0x262>
 6ba:	8bce                	mv	s7,s3
 6bc:	4981                	li	s3,0
 6be:	bbd9                	j	494 <vprintf+0x4a>
 6c0:	00000917          	auipc	s2,0x0
 6c4:	24090913          	addi	s2,s2,576 # 900 <malloc+0x134>
 6c8:	02800593          	li	a1,40
 6cc:	b7c5                	j	6ac <vprintf+0x262>
 6ce:	8bce                	mv	s7,s3
 6d0:	4981                	li	s3,0
 6d2:	b3c9                	j	494 <vprintf+0x4a>
 6d4:	64a6                	ld	s1,72(sp)
 6d6:	79e2                	ld	s3,56(sp)
 6d8:	7a42                	ld	s4,48(sp)
 6da:	7aa2                	ld	s5,40(sp)
 6dc:	7b02                	ld	s6,32(sp)
 6de:	6be2                	ld	s7,24(sp)
 6e0:	6c42                	ld	s8,16(sp)
 6e2:	6ca2                	ld	s9,8(sp)
 6e4:	60e6                	ld	ra,88(sp)
 6e6:	6446                	ld	s0,80(sp)
 6e8:	6906                	ld	s2,64(sp)
 6ea:	6125                	addi	sp,sp,96
 6ec:	8082                	ret

00000000000006ee <fprintf>:
 6ee:	715d                	addi	sp,sp,-80
 6f0:	ec06                	sd	ra,24(sp)
 6f2:	e822                	sd	s0,16(sp)
 6f4:	1000                	addi	s0,sp,32
 6f6:	e010                	sd	a2,0(s0)
 6f8:	e414                	sd	a3,8(s0)
 6fa:	e818                	sd	a4,16(s0)
 6fc:	ec1c                	sd	a5,24(s0)
 6fe:	03043023          	sd	a6,32(s0)
 702:	03143423          	sd	a7,40(s0)
 706:	fe843423          	sd	s0,-24(s0)
 70a:	8622                	mv	a2,s0
 70c:	d3fff0ef          	jal	44a <vprintf>
 710:	60e2                	ld	ra,24(sp)
 712:	6442                	ld	s0,16(sp)
 714:	6161                	addi	sp,sp,80
 716:	8082                	ret

0000000000000718 <printf>:
 718:	711d                	addi	sp,sp,-96
 71a:	ec06                	sd	ra,24(sp)
 71c:	e822                	sd	s0,16(sp)
 71e:	1000                	addi	s0,sp,32
 720:	e40c                	sd	a1,8(s0)
 722:	e810                	sd	a2,16(s0)
 724:	ec14                	sd	a3,24(s0)
 726:	f018                	sd	a4,32(s0)
 728:	f41c                	sd	a5,40(s0)
 72a:	03043823          	sd	a6,48(s0)
 72e:	03143c23          	sd	a7,56(s0)
 732:	00840613          	addi	a2,s0,8
 736:	fec43423          	sd	a2,-24(s0)
 73a:	85aa                	mv	a1,a0
 73c:	4505                	li	a0,1
 73e:	d0dff0ef          	jal	44a <vprintf>
 742:	60e2                	ld	ra,24(sp)
 744:	6442                	ld	s0,16(sp)
 746:	6125                	addi	sp,sp,96
 748:	8082                	ret

000000000000074a <free>:
 74a:	1141                	addi	sp,sp,-16
 74c:	e422                	sd	s0,8(sp)
 74e:	0800                	addi	s0,sp,16
 750:	ff050693          	addi	a3,a0,-16
 754:	00001797          	auipc	a5,0x1
 758:	8ac7b783          	ld	a5,-1876(a5) # 1000 <freep>
 75c:	a02d                	j	786 <free+0x3c>
 75e:	4618                	lw	a4,8(a2)
 760:	9f2d                	addw	a4,a4,a1
 762:	fee52c23          	sw	a4,-8(a0)
 766:	6398                	ld	a4,0(a5)
 768:	6310                	ld	a2,0(a4)
 76a:	a83d                	j	7a8 <free+0x5e>
 76c:	ff852703          	lw	a4,-8(a0)
 770:	9f31                	addw	a4,a4,a2
 772:	c798                	sw	a4,8(a5)
 774:	ff053683          	ld	a3,-16(a0)
 778:	a091                	j	7bc <free+0x72>
 77a:	6398                	ld	a4,0(a5)
 77c:	00e7e463          	bltu	a5,a4,784 <free+0x3a>
 780:	00e6ea63          	bltu	a3,a4,794 <free+0x4a>
 784:	87ba                	mv	a5,a4
 786:	fed7fae3          	bgeu	a5,a3,77a <free+0x30>
 78a:	6398                	ld	a4,0(a5)
 78c:	00e6e463          	bltu	a3,a4,794 <free+0x4a>
 790:	fee7eae3          	bltu	a5,a4,784 <free+0x3a>
 794:	ff852583          	lw	a1,-8(a0)
 798:	6390                	ld	a2,0(a5)
 79a:	02059813          	slli	a6,a1,0x20
 79e:	01c85713          	srli	a4,a6,0x1c
 7a2:	9736                	add	a4,a4,a3
 7a4:	fae60de3          	beq	a2,a4,75e <free+0x14>
 7a8:	fec53823          	sd	a2,-16(a0)
 7ac:	4790                	lw	a2,8(a5)
 7ae:	02061593          	slli	a1,a2,0x20
 7b2:	01c5d713          	srli	a4,a1,0x1c
 7b6:	973e                	add	a4,a4,a5
 7b8:	fae68ae3          	beq	a3,a4,76c <free+0x22>
 7bc:	e394                	sd	a3,0(a5)
 7be:	00001717          	auipc	a4,0x1
 7c2:	84f73123          	sd	a5,-1982(a4) # 1000 <freep>
 7c6:	6422                	ld	s0,8(sp)
 7c8:	0141                	addi	sp,sp,16
 7ca:	8082                	ret

00000000000007cc <malloc>:
 7cc:	7139                	addi	sp,sp,-64
 7ce:	fc06                	sd	ra,56(sp)
 7d0:	f822                	sd	s0,48(sp)
 7d2:	f426                	sd	s1,40(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	0080                	addi	s0,sp,64
 7d8:	02051493          	slli	s1,a0,0x20
 7dc:	9081                	srli	s1,s1,0x20
 7de:	04bd                	addi	s1,s1,15
 7e0:	8091                	srli	s1,s1,0x4
 7e2:	0014899b          	addiw	s3,s1,1
 7e6:	0485                	addi	s1,s1,1
 7e8:	00001517          	auipc	a0,0x1
 7ec:	81853503          	ld	a0,-2024(a0) # 1000 <freep>
 7f0:	c915                	beqz	a0,824 <malloc+0x58>
 7f2:	611c                	ld	a5,0(a0)
 7f4:	4798                	lw	a4,8(a5)
 7f6:	08977a63          	bgeu	a4,s1,88a <malloc+0xbe>
 7fa:	f04a                	sd	s2,32(sp)
 7fc:	e852                	sd	s4,16(sp)
 7fe:	e456                	sd	s5,8(sp)
 800:	e05a                	sd	s6,0(sp)
 802:	8a4e                	mv	s4,s3
 804:	0009871b          	sext.w	a4,s3
 808:	6685                	lui	a3,0x1
 80a:	00d77363          	bgeu	a4,a3,810 <malloc+0x44>
 80e:	6a05                	lui	s4,0x1
 810:	000a0b1b          	sext.w	s6,s4
 814:	004a1a1b          	slliw	s4,s4,0x4
 818:	00000917          	auipc	s2,0x0
 81c:	7e890913          	addi	s2,s2,2024 # 1000 <freep>
 820:	5afd                	li	s5,-1
 822:	a081                	j	862 <malloc+0x96>
 824:	f04a                	sd	s2,32(sp)
 826:	e852                	sd	s4,16(sp)
 828:	e456                	sd	s5,8(sp)
 82a:	e05a                	sd	s6,0(sp)
 82c:	00008797          	auipc	a5,0x8
 830:	7e478793          	addi	a5,a5,2020 # 9010 <base>
 834:	00000717          	auipc	a4,0x0
 838:	7cf73623          	sd	a5,1996(a4) # 1000 <freep>
 83c:	e39c                	sd	a5,0(a5)
 83e:	0007a423          	sw	zero,8(a5)
 842:	b7c1                	j	802 <malloc+0x36>
 844:	6398                	ld	a4,0(a5)
 846:	e118                	sd	a4,0(a0)
 848:	a8a9                	j	8a2 <malloc+0xd6>
 84a:	01652423          	sw	s6,8(a0)
 84e:	0541                	addi	a0,a0,16
 850:	efbff0ef          	jal	74a <free>
 854:	00093503          	ld	a0,0(s2)
 858:	c12d                	beqz	a0,8ba <malloc+0xee>
 85a:	611c                	ld	a5,0(a0)
 85c:	4798                	lw	a4,8(a5)
 85e:	02977263          	bgeu	a4,s1,882 <malloc+0xb6>
 862:	00093703          	ld	a4,0(s2)
 866:	853e                	mv	a0,a5
 868:	fef719e3          	bne	a4,a5,85a <malloc+0x8e>
 86c:	8552                	mv	a0,s4
 86e:	a43ff0ef          	jal	2b0 <sbrk>
 872:	fd551ce3          	bne	a0,s5,84a <malloc+0x7e>
 876:	4501                	li	a0,0
 878:	7902                	ld	s2,32(sp)
 87a:	6a42                	ld	s4,16(sp)
 87c:	6aa2                	ld	s5,8(sp)
 87e:	6b02                	ld	s6,0(sp)
 880:	a03d                	j	8ae <malloc+0xe2>
 882:	7902                	ld	s2,32(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	fae48de3          	beq	s1,a4,844 <malloc+0x78>
 88e:	4137073b          	subw	a4,a4,s3
 892:	c798                	sw	a4,8(a5)
 894:	02071693          	slli	a3,a4,0x20
 898:	01c6d713          	srli	a4,a3,0x1c
 89c:	97ba                	add	a5,a5,a4
 89e:	0137a423          	sw	s3,8(a5)
 8a2:	00000717          	auipc	a4,0x0
 8a6:	74a73f23          	sd	a0,1886(a4) # 1000 <freep>
 8aa:	01078513          	addi	a0,a5,16
 8ae:	70e2                	ld	ra,56(sp)
 8b0:	7442                	ld	s0,48(sp)
 8b2:	74a2                	ld	s1,40(sp)
 8b4:	69e2                	ld	s3,24(sp)
 8b6:	6121                	addi	sp,sp,64
 8b8:	8082                	ret
 8ba:	7902                	ld	s2,32(sp)
 8bc:	6a42                	ld	s4,16(sp)
 8be:	6aa2                	ld	s5,8(sp)
 8c0:	6b02                	ld	s6,0(sp)
 8c2:	b7f5                	j	8ae <malloc+0xe2>
