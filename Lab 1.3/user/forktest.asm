
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
   c:	124000ef          	jal	130 <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	374000ef          	jal	38c <write>
  1c:	60e2                	ld	ra,24(sp)
  1e:	6442                	ld	s0,16(sp)
  20:	64a2                	ld	s1,8(sp)
  22:	6105                	addi	sp,sp,32
  24:	8082                	ret

0000000000000026 <forktest>:
  26:	1101                	addi	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	addi	s0,sp,32
  32:	00000517          	auipc	a0,0x0
  36:	3de50513          	addi	a0,a0,990 # 410 <uptime+0xc>
  3a:	fc7ff0ef          	jal	0 <print>
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
  44:	320000ef          	jal	364 <fork>
  48:	04054363          	bltz	a0,8e <forktest+0x68>
  4c:	cd09                	beqz	a0,66 <forktest+0x40>
  4e:	2485                	addiw	s1,s1,1
  50:	ff249ae3          	bne	s1,s2,44 <forktest+0x1e>
  54:	00000517          	auipc	a0,0x0
  58:	40c50513          	addi	a0,a0,1036 # 460 <uptime+0x5c>
  5c:	fa5ff0ef          	jal	0 <print>
  60:	4505                	li	a0,1
  62:	30a000ef          	jal	36c <exit>
  66:	306000ef          	jal	36c <exit>
  6a:	00000517          	auipc	a0,0x0
  6e:	3b650513          	addi	a0,a0,950 # 420 <uptime+0x1c>
  72:	f8fff0ef          	jal	0 <print>
  76:	4505                	li	a0,1
  78:	2f4000ef          	jal	36c <exit>
  7c:	00000517          	auipc	a0,0x0
  80:	3bc50513          	addi	a0,a0,956 # 438 <uptime+0x34>
  84:	f7dff0ef          	jal	0 <print>
  88:	4505                	li	a0,1
  8a:	2e2000ef          	jal	36c <exit>
  8e:	00905963          	blez	s1,a0 <forktest+0x7a>
  92:	4501                	li	a0,0
  94:	2e0000ef          	jal	374 <wait>
  98:	fc0549e3          	bltz	a0,6a <forktest+0x44>
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <forktest+0x6c>
  a0:	4501                	li	a0,0
  a2:	2d2000ef          	jal	374 <wait>
  a6:	57fd                	li	a5,-1
  a8:	fcf51ae3          	bne	a0,a5,7c <forktest+0x56>
  ac:	00000517          	auipc	a0,0x0
  b0:	3a450513          	addi	a0,a0,932 # 450 <uptime+0x4c>
  b4:	f4dff0ef          	jal	0 <print>
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	addi	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <main>:
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  cc:	f5bff0ef          	jal	26 <forktest>
  d0:	4501                	li	a0,0
  d2:	29a000ef          	jal	36c <exit>

00000000000000d6 <start>:
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  de:	fe7ff0ef          	jal	c4 <main>
  e2:	4501                	li	a0,0
  e4:	288000ef          	jal	36c <exit>

00000000000000e8 <strcpy>:
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0x8>
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strcmp>:
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cb91                	beqz	a5,122 <strcmp+0x1e>
 110:	0005c703          	lbu	a4,0(a1)
 114:	00f71763          	bne	a4,a5,122 <strcmp+0x1e>
 118:	0505                	addi	a0,a0,1
 11a:	0585                	addi	a1,a1,1
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbe5                	bnez	a5,110 <strcmp+0xc>
 122:	0005c503          	lbu	a0,0(a1)
 126:	40a7853b          	subw	a0,a5,a0
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strlen>:
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strlen+0x26>
 13c:	0505                	addi	a0,a0,1
 13e:	87aa                	mv	a5,a0
 140:	86be                	mv	a3,a5
 142:	0785                	addi	a5,a5,1
 144:	fff7c703          	lbu	a4,-1(a5)
 148:	ff65                	bnez	a4,140 <strlen+0x10>
 14a:	40a6853b          	subw	a0,a3,a0
 14e:	2505                	addiw	a0,a0,1
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strlen+0x20>

000000000000015a <memset>:
 15a:	1141                	addi	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	addi	s0,sp,16
 160:	ca19                	beqz	a2,176 <memset+0x1c>
 162:	87aa                	mv	a5,a0
 164:	1602                	slli	a2,a2,0x20
 166:	9201                	srli	a2,a2,0x20
 168:	00a60733          	add	a4,a2,a0
 16c:	00b78023          	sb	a1,0(a5)
 170:	0785                	addi	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x12>
 176:	6422                	ld	s0,8(sp)
 178:	0141                	addi	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:
 17c:	1141                	addi	sp,sp,-16
 17e:	e422                	sd	s0,8(sp)
 180:	0800                	addi	s0,sp,16
 182:	00054783          	lbu	a5,0(a0)
 186:	cb99                	beqz	a5,19c <strchr+0x20>
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1a>
 18c:	0505                	addi	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xc>
 194:	4501                	li	a0,0
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strchr+0x1a>

00000000000001a0 <gets>:
 1a0:	711d                	addi	sp,sp,-96
 1a2:	ec86                	sd	ra,88(sp)
 1a4:	e8a2                	sd	s0,80(sp)
 1a6:	e4a6                	sd	s1,72(sp)
 1a8:	e0ca                	sd	s2,64(sp)
 1aa:	fc4e                	sd	s3,56(sp)
 1ac:	f852                	sd	s4,48(sp)
 1ae:	f456                	sd	s5,40(sp)
 1b0:	f05a                	sd	s6,32(sp)
 1b2:	ec5e                	sd	s7,24(sp)
 1b4:	1080                	addi	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
 1be:	4aa9                	li	s5,10
 1c0:	4b35                	li	s6,13
 1c2:	89a6                	mv	s3,s1
 1c4:	2485                	addiw	s1,s1,1
 1c6:	0344d663          	bge	s1,s4,1f2 <gets+0x52>
 1ca:	4605                	li	a2,1
 1cc:	faf40593          	addi	a1,s0,-81
 1d0:	4501                	li	a0,0
 1d2:	1b2000ef          	jal	384 <read>
 1d6:	00a05e63          	blez	a0,1f2 <gets+0x52>
 1da:	faf44783          	lbu	a5,-81(s0)
 1de:	00f90023          	sb	a5,0(s2)
 1e2:	01578763          	beq	a5,s5,1f0 <gets+0x50>
 1e6:	0905                	addi	s2,s2,1
 1e8:	fd679de3          	bne	a5,s6,1c2 <gets+0x22>
 1ec:	89a6                	mv	s3,s1
 1ee:	a011                	j	1f2 <gets+0x52>
 1f0:	89a6                	mv	s3,s1
 1f2:	99de                	add	s3,s3,s7
 1f4:	00098023          	sb	zero,0(s3)
 1f8:	855e                	mv	a0,s7
 1fa:	60e6                	ld	ra,88(sp)
 1fc:	6446                	ld	s0,80(sp)
 1fe:	64a6                	ld	s1,72(sp)
 200:	6906                	ld	s2,64(sp)
 202:	79e2                	ld	s3,56(sp)
 204:	7a42                	ld	s4,48(sp)
 206:	7aa2                	ld	s5,40(sp)
 208:	7b02                	ld	s6,32(sp)
 20a:	6be2                	ld	s7,24(sp)
 20c:	6125                	addi	sp,sp,96
 20e:	8082                	ret

0000000000000210 <stat>:
 210:	1101                	addi	sp,sp,-32
 212:	ec06                	sd	ra,24(sp)
 214:	e822                	sd	s0,16(sp)
 216:	e04a                	sd	s2,0(sp)
 218:	1000                	addi	s0,sp,32
 21a:	892e                	mv	s2,a1
 21c:	4581                	li	a1,0
 21e:	18e000ef          	jal	3ac <open>
 222:	02054263          	bltz	a0,246 <stat+0x36>
 226:	e426                	sd	s1,8(sp)
 228:	84aa                	mv	s1,a0
 22a:	85ca                	mv	a1,s2
 22c:	198000ef          	jal	3c4 <fstat>
 230:	892a                	mv	s2,a0
 232:	8526                	mv	a0,s1
 234:	160000ef          	jal	394 <close>
 238:	64a2                	ld	s1,8(sp)
 23a:	854a                	mv	a0,s2
 23c:	60e2                	ld	ra,24(sp)
 23e:	6442                	ld	s0,16(sp)
 240:	6902                	ld	s2,0(sp)
 242:	6105                	addi	sp,sp,32
 244:	8082                	ret
 246:	597d                	li	s2,-1
 248:	bfcd                	j	23a <stat+0x2a>

000000000000024a <atoi>:
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
 250:	00054683          	lbu	a3,0(a0)
 254:	fd06879b          	addiw	a5,a3,-48
 258:	0ff7f793          	zext.b	a5,a5
 25c:	4625                	li	a2,9
 25e:	02f66863          	bltu	a2,a5,28e <atoi+0x44>
 262:	872a                	mv	a4,a0
 264:	4501                	li	a0,0
 266:	0705                	addi	a4,a4,1
 268:	0025179b          	slliw	a5,a0,0x2
 26c:	9fa9                	addw	a5,a5,a0
 26e:	0017979b          	slliw	a5,a5,0x1
 272:	9fb5                	addw	a5,a5,a3
 274:	fd07851b          	addiw	a0,a5,-48
 278:	00074683          	lbu	a3,0(a4)
 27c:	fd06879b          	addiw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	fef671e3          	bgeu	a2,a5,266 <atoi+0x1c>
 288:	6422                	ld	s0,8(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret
 28e:	4501                	li	a0,0
 290:	bfe5                	j	288 <atoi+0x3e>

0000000000000292 <memmove>:
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
 298:	02b57463          	bgeu	a0,a1,2c0 <memmove+0x2e>
 29c:	00c05f63          	blez	a2,2ba <memmove+0x28>
 2a0:	1602                	slli	a2,a2,0x20
 2a2:	9201                	srli	a2,a2,0x20
 2a4:	00c507b3          	add	a5,a0,a2
 2a8:	872a                	mv	a4,a0
 2aa:	0585                	addi	a1,a1,1
 2ac:	0705                	addi	a4,a4,1
 2ae:	fff5c683          	lbu	a3,-1(a1)
 2b2:	fed70fa3          	sb	a3,-1(a4)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x18>
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
 2c0:	00c50733          	add	a4,a0,a2
 2c4:	95b2                	add	a1,a1,a2
 2c6:	fec05ae3          	blez	a2,2ba <memmove+0x28>
 2ca:	fff6079b          	addiw	a5,a2,-1
 2ce:	1782                	slli	a5,a5,0x20
 2d0:	9381                	srli	a5,a5,0x20
 2d2:	fff7c793          	not	a5,a5
 2d6:	97ba                	add	a5,a5,a4
 2d8:	15fd                	addi	a1,a1,-1
 2da:	177d                	addi	a4,a4,-1
 2dc:	0005c683          	lbu	a3,0(a1)
 2e0:	00d70023          	sb	a3,0(a4)
 2e4:	fee79ae3          	bne	a5,a4,2d8 <memmove+0x46>
 2e8:	bfc9                	j	2ba <memmove+0x28>

00000000000002ea <memcmp>:
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
 2f0:	ca05                	beqz	a2,320 <memcmp+0x36>
 2f2:	fff6069b          	addiw	a3,a2,-1
 2f6:	1682                	slli	a3,a3,0x20
 2f8:	9281                	srli	a3,a3,0x20
 2fa:	0685                	addi	a3,a3,1
 2fc:	96aa                	add	a3,a3,a0
 2fe:	00054783          	lbu	a5,0(a0)
 302:	0005c703          	lbu	a4,0(a1)
 306:	00e79863          	bne	a5,a4,316 <memcmp+0x2c>
 30a:	0505                	addi	a0,a0,1
 30c:	0585                	addi	a1,a1,1
 30e:	fed518e3          	bne	a0,a3,2fe <memcmp+0x14>
 312:	4501                	li	a0,0
 314:	a019                	j	31a <memcmp+0x30>
 316:	40e7853b          	subw	a0,a5,a4
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <memcmp+0x30>

0000000000000324 <memcpy>:
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
 32c:	f67ff0ef          	jal	292 <memmove>
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret

0000000000000338 <sbrk>:
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
 340:	4585                	li	a1,1
 342:	0b2000ef          	jal	3f4 <sys_sbrk>
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <sbrklazy>:
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
 356:	4589                	li	a1,2
 358:	09c000ef          	jal	3f4 <sys_sbrk>
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <fork>:
 364:	4885                	li	a7,1
 366:	00000073          	ecall
 36a:	8082                	ret

000000000000036c <exit>:
 36c:	4889                	li	a7,2
 36e:	00000073          	ecall
 372:	8082                	ret

0000000000000374 <wait>:
 374:	488d                	li	a7,3
 376:	00000073          	ecall
 37a:	8082                	ret

000000000000037c <pipe>:
 37c:	4891                	li	a7,4
 37e:	00000073          	ecall
 382:	8082                	ret

0000000000000384 <read>:
 384:	4895                	li	a7,5
 386:	00000073          	ecall
 38a:	8082                	ret

000000000000038c <write>:
 38c:	48c1                	li	a7,16
 38e:	00000073          	ecall
 392:	8082                	ret

0000000000000394 <close>:
 394:	48d5                	li	a7,21
 396:	00000073          	ecall
 39a:	8082                	ret

000000000000039c <kill>:
 39c:	4899                	li	a7,6
 39e:	00000073          	ecall
 3a2:	8082                	ret

00000000000003a4 <exec>:
 3a4:	489d                	li	a7,7
 3a6:	00000073          	ecall
 3aa:	8082                	ret

00000000000003ac <open>:
 3ac:	48bd                	li	a7,15
 3ae:	00000073          	ecall
 3b2:	8082                	ret

00000000000003b4 <mknod>:
 3b4:	48c5                	li	a7,17
 3b6:	00000073          	ecall
 3ba:	8082                	ret

00000000000003bc <unlink>:
 3bc:	48c9                	li	a7,18
 3be:	00000073          	ecall
 3c2:	8082                	ret

00000000000003c4 <fstat>:
 3c4:	48a1                	li	a7,8
 3c6:	00000073          	ecall
 3ca:	8082                	ret

00000000000003cc <link>:
 3cc:	48cd                	li	a7,19
 3ce:	00000073          	ecall
 3d2:	8082                	ret

00000000000003d4 <mkdir>:
 3d4:	48d1                	li	a7,20
 3d6:	00000073          	ecall
 3da:	8082                	ret

00000000000003dc <chdir>:
 3dc:	48a5                	li	a7,9
 3de:	00000073          	ecall
 3e2:	8082                	ret

00000000000003e4 <dup>:
 3e4:	48a9                	li	a7,10
 3e6:	00000073          	ecall
 3ea:	8082                	ret

00000000000003ec <getpid>:
 3ec:	48ad                	li	a7,11
 3ee:	00000073          	ecall
 3f2:	8082                	ret

00000000000003f4 <sys_sbrk>:
 3f4:	48b1                	li	a7,12
 3f6:	00000073          	ecall
 3fa:	8082                	ret

00000000000003fc <pause>:
 3fc:	48b5                	li	a7,13
 3fe:	00000073          	ecall
 402:	8082                	ret

0000000000000404 <uptime>:
 404:	48b9                	li	a7,14
 406:	00000073          	ecall
 40a:	8082                	ret
