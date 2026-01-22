
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
   c:	2ba000ef          	jal	2c6 <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
  2e:	00178493          	addi	s1,a5,1
  32:	8526                	mv	a0,s1
  34:	292000ef          	jal	2c6 <strlen>
  38:	2501                	sext.w	a0,a0
  3a:	47b5                	li	a5,13
  3c:	00a7f863          	bgeu	a5,a0,4c <fmtname+0x4c>
  40:	8526                	mv	a0,s1
  42:	70a2                	ld	ra,40(sp)
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6145                	addi	sp,sp,48
  4a:	8082                	ret
  4c:	e84a                	sd	s2,16(sp)
  4e:	e44e                	sd	s3,8(sp)
  50:	8526                	mv	a0,s1
  52:	274000ef          	jal	2c6 <strlen>
  56:	00002997          	auipc	s3,0x2
  5a:	fba98993          	addi	s3,s3,-70 # 2010 <buf.0>
  5e:	0005061b          	sext.w	a2,a0
  62:	85a6                	mv	a1,s1
  64:	854e                	mv	a0,s3
  66:	3c2000ef          	jal	428 <memmove>
  6a:	8526                	mv	a0,s1
  6c:	25a000ef          	jal	2c6 <strlen>
  70:	0005091b          	sext.w	s2,a0
  74:	8526                	mv	a0,s1
  76:	250000ef          	jal	2c6 <strlen>
  7a:	1902                	slli	s2,s2,0x20
  7c:	02095913          	srli	s2,s2,0x20
  80:	4639                	li	a2,14
  82:	9e09                	subw	a2,a2,a0
  84:	02000593          	li	a1,32
  88:	01298533          	add	a0,s3,s2
  8c:	264000ef          	jal	2f0 <memset>
  90:	00098723          	sb	zero,14(s3)
  94:	84ce                	mv	s1,s3
  96:	6942                	ld	s2,16(sp)
  98:	69a2                	ld	s3,8(sp)
  9a:	b75d                	j	40 <fmtname+0x40>

000000000000009c <ls>:
  9c:	d9010113          	addi	sp,sp,-624
  a0:	26113423          	sd	ra,616(sp)
  a4:	26813023          	sd	s0,608(sp)
  a8:	25213823          	sd	s2,592(sp)
  ac:	1c80                	addi	s0,sp,624
  ae:	892a                	mv	s2,a0
  b0:	4581                	li	a1,0
  b2:	490000ef          	jal	542 <open>
  b6:	06054363          	bltz	a0,11c <ls+0x80>
  ba:	24913c23          	sd	s1,600(sp)
  be:	84aa                	mv	s1,a0
  c0:	d9840593          	addi	a1,s0,-616
  c4:	496000ef          	jal	55a <fstat>
  c8:	06054363          	bltz	a0,12e <ls+0x92>
  cc:	da041783          	lh	a5,-608(s0)
  d0:	4705                	li	a4,1
  d2:	06e78c63          	beq	a5,a4,14a <ls+0xae>
  d6:	37f9                	addiw	a5,a5,-2
  d8:	17c2                	slli	a5,a5,0x30
  da:	93c1                	srli	a5,a5,0x30
  dc:	02f76263          	bltu	a4,a5,100 <ls+0x64>
  e0:	854a                	mv	a0,s2
  e2:	f1fff0ef          	jal	0 <fmtname>
  e6:	85aa                	mv	a1,a0
  e8:	da842703          	lw	a4,-600(s0)
  ec:	d9c42683          	lw	a3,-612(s0)
  f0:	da041603          	lh	a2,-608(s0)
  f4:	00001517          	auipc	a0,0x1
  f8:	a2c50513          	addi	a0,a0,-1492 # b20 <malloc+0x136>
  fc:	03b000ef          	jal	936 <printf>
 100:	8526                	mv	a0,s1
 102:	428000ef          	jal	52a <close>
 106:	25813483          	ld	s1,600(sp)
 10a:	26813083          	ld	ra,616(sp)
 10e:	26013403          	ld	s0,608(sp)
 112:	25013903          	ld	s2,592(sp)
 116:	27010113          	addi	sp,sp,624
 11a:	8082                	ret
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	9d258593          	addi	a1,a1,-1582 # af0 <malloc+0x106>
 126:	4509                	li	a0,2
 128:	7e4000ef          	jal	90c <fprintf>
 12c:	bff9                	j	10a <ls+0x6e>
 12e:	864a                	mv	a2,s2
 130:	00001597          	auipc	a1,0x1
 134:	9d858593          	addi	a1,a1,-1576 # b08 <malloc+0x11e>
 138:	4509                	li	a0,2
 13a:	7d2000ef          	jal	90c <fprintf>
 13e:	8526                	mv	a0,s1
 140:	3ea000ef          	jal	52a <close>
 144:	25813483          	ld	s1,600(sp)
 148:	b7c9                	j	10a <ls+0x6e>
 14a:	854a                	mv	a0,s2
 14c:	17a000ef          	jal	2c6 <strlen>
 150:	2541                	addiw	a0,a0,16
 152:	20000793          	li	a5,512
 156:	00a7f963          	bgeu	a5,a0,168 <ls+0xcc>
 15a:	00001517          	auipc	a0,0x1
 15e:	9d650513          	addi	a0,a0,-1578 # b30 <malloc+0x146>
 162:	7d4000ef          	jal	936 <printf>
 166:	bf69                	j	100 <ls+0x64>
 168:	25313423          	sd	s3,584(sp)
 16c:	25413023          	sd	s4,576(sp)
 170:	23513c23          	sd	s5,568(sp)
 174:	85ca                	mv	a1,s2
 176:	dc040513          	addi	a0,s0,-576
 17a:	104000ef          	jal	27e <strcpy>
 17e:	dc040513          	addi	a0,s0,-576
 182:	144000ef          	jal	2c6 <strlen>
 186:	1502                	slli	a0,a0,0x20
 188:	9101                	srli	a0,a0,0x20
 18a:	dc040793          	addi	a5,s0,-576
 18e:	00a78933          	add	s2,a5,a0
 192:	00190993          	addi	s3,s2,1
 196:	02f00793          	li	a5,47
 19a:	00f90023          	sb	a5,0(s2)
 19e:	00001a17          	auipc	s4,0x1
 1a2:	982a0a13          	addi	s4,s4,-1662 # b20 <malloc+0x136>
 1a6:	00001a97          	auipc	s5,0x1
 1aa:	962a8a93          	addi	s5,s5,-1694 # b08 <malloc+0x11e>
 1ae:	a031                	j	1ba <ls+0x11e>
 1b0:	dc040593          	addi	a1,s0,-576
 1b4:	8556                	mv	a0,s5
 1b6:	780000ef          	jal	936 <printf>
 1ba:	4641                	li	a2,16
 1bc:	db040593          	addi	a1,s0,-592
 1c0:	8526                	mv	a0,s1
 1c2:	358000ef          	jal	51a <read>
 1c6:	47c1                	li	a5,16
 1c8:	04f51463          	bne	a0,a5,210 <ls+0x174>
 1cc:	db045783          	lhu	a5,-592(s0)
 1d0:	d7ed                	beqz	a5,1ba <ls+0x11e>
 1d2:	4639                	li	a2,14
 1d4:	db240593          	addi	a1,s0,-590
 1d8:	854e                	mv	a0,s3
 1da:	24e000ef          	jal	428 <memmove>
 1de:	000907a3          	sb	zero,15(s2)
 1e2:	d9840593          	addi	a1,s0,-616
 1e6:	dc040513          	addi	a0,s0,-576
 1ea:	1bc000ef          	jal	3a6 <stat>
 1ee:	fc0541e3          	bltz	a0,1b0 <ls+0x114>
 1f2:	dc040513          	addi	a0,s0,-576
 1f6:	e0bff0ef          	jal	0 <fmtname>
 1fa:	85aa                	mv	a1,a0
 1fc:	da842703          	lw	a4,-600(s0)
 200:	d9c42683          	lw	a3,-612(s0)
 204:	da041603          	lh	a2,-608(s0)
 208:	8552                	mv	a0,s4
 20a:	72c000ef          	jal	936 <printf>
 20e:	b775                	j	1ba <ls+0x11e>
 210:	24813983          	ld	s3,584(sp)
 214:	24013a03          	ld	s4,576(sp)
 218:	23813a83          	ld	s5,568(sp)
 21c:	b5d5                	j	100 <ls+0x64>

000000000000021e <main>:
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	1000                	addi	s0,sp,32
 226:	4785                	li	a5,1
 228:	02a7d763          	bge	a5,a0,256 <main+0x38>
 22c:	e426                	sd	s1,8(sp)
 22e:	e04a                	sd	s2,0(sp)
 230:	00858493          	addi	s1,a1,8
 234:	ffe5091b          	addiw	s2,a0,-2
 238:	02091793          	slli	a5,s2,0x20
 23c:	01d7d913          	srli	s2,a5,0x1d
 240:	05c1                	addi	a1,a1,16
 242:	992e                	add	s2,s2,a1
 244:	6088                	ld	a0,0(s1)
 246:	e57ff0ef          	jal	9c <ls>
 24a:	04a1                	addi	s1,s1,8
 24c:	ff249ce3          	bne	s1,s2,244 <main+0x26>
 250:	4501                	li	a0,0
 252:	2b0000ef          	jal	502 <exit>
 256:	e426                	sd	s1,8(sp)
 258:	e04a                	sd	s2,0(sp)
 25a:	00001517          	auipc	a0,0x1
 25e:	8ee50513          	addi	a0,a0,-1810 # b48 <malloc+0x15e>
 262:	e3bff0ef          	jal	9c <ls>
 266:	4501                	li	a0,0
 268:	29a000ef          	jal	502 <exit>

000000000000026c <start>:
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
 274:	fabff0ef          	jal	21e <main>
 278:	4501                	li	a0,0
 27a:	288000ef          	jal	502 <exit>

000000000000027e <strcpy>:
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
 284:	87aa                	mv	a5,a0
 286:	0585                	addi	a1,a1,1
 288:	0785                	addi	a5,a5,1
 28a:	fff5c703          	lbu	a4,-1(a1)
 28e:	fee78fa3          	sb	a4,-1(a5)
 292:	fb75                	bnez	a4,286 <strcpy+0x8>
 294:	6422                	ld	s0,8(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret

000000000000029a <strcmp>:
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	cb91                	beqz	a5,2b8 <strcmp+0x1e>
 2a6:	0005c703          	lbu	a4,0(a1)
 2aa:	00f71763          	bne	a4,a5,2b8 <strcmp+0x1e>
 2ae:	0505                	addi	a0,a0,1
 2b0:	0585                	addi	a1,a1,1
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	fbe5                	bnez	a5,2a6 <strcmp+0xc>
 2b8:	0005c503          	lbu	a0,0(a1)
 2bc:	40a7853b          	subw	a0,a5,a0
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strlen>:
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf91                	beqz	a5,2ec <strlen+0x26>
 2d2:	0505                	addi	a0,a0,1
 2d4:	87aa                	mv	a5,a0
 2d6:	86be                	mv	a3,a5
 2d8:	0785                	addi	a5,a5,1
 2da:	fff7c703          	lbu	a4,-1(a5)
 2de:	ff65                	bnez	a4,2d6 <strlen+0x10>
 2e0:	40a6853b          	subw	a0,a3,a0
 2e4:	2505                	addiw	a0,a0,1
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
 2ec:	4501                	li	a0,0
 2ee:	bfe5                	j	2e6 <strlen+0x20>

00000000000002f0 <memset>:
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
 2f6:	ca19                	beqz	a2,30c <memset+0x1c>
 2f8:	87aa                	mv	a5,a0
 2fa:	1602                	slli	a2,a2,0x20
 2fc:	9201                	srli	a2,a2,0x20
 2fe:	00a60733          	add	a4,a2,a0
 302:	00b78023          	sb	a1,0(a5)
 306:	0785                	addi	a5,a5,1
 308:	fee79de3          	bne	a5,a4,302 <memset+0x12>
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <strchr>:
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
 318:	00054783          	lbu	a5,0(a0)
 31c:	cb99                	beqz	a5,332 <strchr+0x20>
 31e:	00f58763          	beq	a1,a5,32c <strchr+0x1a>
 322:	0505                	addi	a0,a0,1
 324:	00054783          	lbu	a5,0(a0)
 328:	fbfd                	bnez	a5,31e <strchr+0xc>
 32a:	4501                	li	a0,0
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <strchr+0x1a>

0000000000000336 <gets>:
 336:	711d                	addi	sp,sp,-96
 338:	ec86                	sd	ra,88(sp)
 33a:	e8a2                	sd	s0,80(sp)
 33c:	e4a6                	sd	s1,72(sp)
 33e:	e0ca                	sd	s2,64(sp)
 340:	fc4e                	sd	s3,56(sp)
 342:	f852                	sd	s4,48(sp)
 344:	f456                	sd	s5,40(sp)
 346:	f05a                	sd	s6,32(sp)
 348:	ec5e                	sd	s7,24(sp)
 34a:	1080                	addi	s0,sp,96
 34c:	8baa                	mv	s7,a0
 34e:	8a2e                	mv	s4,a1
 350:	892a                	mv	s2,a0
 352:	4481                	li	s1,0
 354:	4aa9                	li	s5,10
 356:	4b35                	li	s6,13
 358:	89a6                	mv	s3,s1
 35a:	2485                	addiw	s1,s1,1
 35c:	0344d663          	bge	s1,s4,388 <gets+0x52>
 360:	4605                	li	a2,1
 362:	faf40593          	addi	a1,s0,-81
 366:	4501                	li	a0,0
 368:	1b2000ef          	jal	51a <read>
 36c:	00a05e63          	blez	a0,388 <gets+0x52>
 370:	faf44783          	lbu	a5,-81(s0)
 374:	00f90023          	sb	a5,0(s2)
 378:	01578763          	beq	a5,s5,386 <gets+0x50>
 37c:	0905                	addi	s2,s2,1
 37e:	fd679de3          	bne	a5,s6,358 <gets+0x22>
 382:	89a6                	mv	s3,s1
 384:	a011                	j	388 <gets+0x52>
 386:	89a6                	mv	s3,s1
 388:	99de                	add	s3,s3,s7
 38a:	00098023          	sb	zero,0(s3)
 38e:	855e                	mv	a0,s7
 390:	60e6                	ld	ra,88(sp)
 392:	6446                	ld	s0,80(sp)
 394:	64a6                	ld	s1,72(sp)
 396:	6906                	ld	s2,64(sp)
 398:	79e2                	ld	s3,56(sp)
 39a:	7a42                	ld	s4,48(sp)
 39c:	7aa2                	ld	s5,40(sp)
 39e:	7b02                	ld	s6,32(sp)
 3a0:	6be2                	ld	s7,24(sp)
 3a2:	6125                	addi	sp,sp,96
 3a4:	8082                	ret

00000000000003a6 <stat>:
 3a6:	1101                	addi	sp,sp,-32
 3a8:	ec06                	sd	ra,24(sp)
 3aa:	e822                	sd	s0,16(sp)
 3ac:	e04a                	sd	s2,0(sp)
 3ae:	1000                	addi	s0,sp,32
 3b0:	892e                	mv	s2,a1
 3b2:	4581                	li	a1,0
 3b4:	18e000ef          	jal	542 <open>
 3b8:	02054263          	bltz	a0,3dc <stat+0x36>
 3bc:	e426                	sd	s1,8(sp)
 3be:	84aa                	mv	s1,a0
 3c0:	85ca                	mv	a1,s2
 3c2:	198000ef          	jal	55a <fstat>
 3c6:	892a                	mv	s2,a0
 3c8:	8526                	mv	a0,s1
 3ca:	160000ef          	jal	52a <close>
 3ce:	64a2                	ld	s1,8(sp)
 3d0:	854a                	mv	a0,s2
 3d2:	60e2                	ld	ra,24(sp)
 3d4:	6442                	ld	s0,16(sp)
 3d6:	6902                	ld	s2,0(sp)
 3d8:	6105                	addi	sp,sp,32
 3da:	8082                	ret
 3dc:	597d                	li	s2,-1
 3de:	bfcd                	j	3d0 <stat+0x2a>

00000000000003e0 <atoi>:
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e422                	sd	s0,8(sp)
 3e4:	0800                	addi	s0,sp,16
 3e6:	00054683          	lbu	a3,0(a0)
 3ea:	fd06879b          	addiw	a5,a3,-48
 3ee:	0ff7f793          	zext.b	a5,a5
 3f2:	4625                	li	a2,9
 3f4:	02f66863          	bltu	a2,a5,424 <atoi+0x44>
 3f8:	872a                	mv	a4,a0
 3fa:	4501                	li	a0,0
 3fc:	0705                	addi	a4,a4,1
 3fe:	0025179b          	slliw	a5,a0,0x2
 402:	9fa9                	addw	a5,a5,a0
 404:	0017979b          	slliw	a5,a5,0x1
 408:	9fb5                	addw	a5,a5,a3
 40a:	fd07851b          	addiw	a0,a5,-48
 40e:	00074683          	lbu	a3,0(a4)
 412:	fd06879b          	addiw	a5,a3,-48
 416:	0ff7f793          	zext.b	a5,a5
 41a:	fef671e3          	bgeu	a2,a5,3fc <atoi+0x1c>
 41e:	6422                	ld	s0,8(sp)
 420:	0141                	addi	sp,sp,16
 422:	8082                	ret
 424:	4501                	li	a0,0
 426:	bfe5                	j	41e <atoi+0x3e>

0000000000000428 <memmove>:
 428:	1141                	addi	sp,sp,-16
 42a:	e422                	sd	s0,8(sp)
 42c:	0800                	addi	s0,sp,16
 42e:	02b57463          	bgeu	a0,a1,456 <memmove+0x2e>
 432:	00c05f63          	blez	a2,450 <memmove+0x28>
 436:	1602                	slli	a2,a2,0x20
 438:	9201                	srli	a2,a2,0x20
 43a:	00c507b3          	add	a5,a0,a2
 43e:	872a                	mv	a4,a0
 440:	0585                	addi	a1,a1,1
 442:	0705                	addi	a4,a4,1
 444:	fff5c683          	lbu	a3,-1(a1)
 448:	fed70fa3          	sb	a3,-1(a4)
 44c:	fef71ae3          	bne	a4,a5,440 <memmove+0x18>
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret
 456:	00c50733          	add	a4,a0,a2
 45a:	95b2                	add	a1,a1,a2
 45c:	fec05ae3          	blez	a2,450 <memmove+0x28>
 460:	fff6079b          	addiw	a5,a2,-1
 464:	1782                	slli	a5,a5,0x20
 466:	9381                	srli	a5,a5,0x20
 468:	fff7c793          	not	a5,a5
 46c:	97ba                	add	a5,a5,a4
 46e:	15fd                	addi	a1,a1,-1
 470:	177d                	addi	a4,a4,-1
 472:	0005c683          	lbu	a3,0(a1)
 476:	00d70023          	sb	a3,0(a4)
 47a:	fee79ae3          	bne	a5,a4,46e <memmove+0x46>
 47e:	bfc9                	j	450 <memmove+0x28>

0000000000000480 <memcmp>:
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
 486:	ca05                	beqz	a2,4b6 <memcmp+0x36>
 488:	fff6069b          	addiw	a3,a2,-1
 48c:	1682                	slli	a3,a3,0x20
 48e:	9281                	srli	a3,a3,0x20
 490:	0685                	addi	a3,a3,1
 492:	96aa                	add	a3,a3,a0
 494:	00054783          	lbu	a5,0(a0)
 498:	0005c703          	lbu	a4,0(a1)
 49c:	00e79863          	bne	a5,a4,4ac <memcmp+0x2c>
 4a0:	0505                	addi	a0,a0,1
 4a2:	0585                	addi	a1,a1,1
 4a4:	fed518e3          	bne	a0,a3,494 <memcmp+0x14>
 4a8:	4501                	li	a0,0
 4aa:	a019                	j	4b0 <memcmp+0x30>
 4ac:	40e7853b          	subw	a0,a5,a4
 4b0:	6422                	ld	s0,8(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret
 4b6:	4501                	li	a0,0
 4b8:	bfe5                	j	4b0 <memcmp+0x30>

00000000000004ba <memcpy>:
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e406                	sd	ra,8(sp)
 4be:	e022                	sd	s0,0(sp)
 4c0:	0800                	addi	s0,sp,16
 4c2:	f67ff0ef          	jal	428 <memmove>
 4c6:	60a2                	ld	ra,8(sp)
 4c8:	6402                	ld	s0,0(sp)
 4ca:	0141                	addi	sp,sp,16
 4cc:	8082                	ret

00000000000004ce <sbrk>:
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e406                	sd	ra,8(sp)
 4d2:	e022                	sd	s0,0(sp)
 4d4:	0800                	addi	s0,sp,16
 4d6:	4585                	li	a1,1
 4d8:	0b2000ef          	jal	58a <sys_sbrk>
 4dc:	60a2                	ld	ra,8(sp)
 4de:	6402                	ld	s0,0(sp)
 4e0:	0141                	addi	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <sbrklazy>:
 4e4:	1141                	addi	sp,sp,-16
 4e6:	e406                	sd	ra,8(sp)
 4e8:	e022                	sd	s0,0(sp)
 4ea:	0800                	addi	s0,sp,16
 4ec:	4589                	li	a1,2
 4ee:	09c000ef          	jal	58a <sys_sbrk>
 4f2:	60a2                	ld	ra,8(sp)
 4f4:	6402                	ld	s0,0(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret

00000000000004fa <fork>:
 4fa:	4885                	li	a7,1
 4fc:	00000073          	ecall
 500:	8082                	ret

0000000000000502 <exit>:
 502:	4889                	li	a7,2
 504:	00000073          	ecall
 508:	8082                	ret

000000000000050a <wait>:
 50a:	488d                	li	a7,3
 50c:	00000073          	ecall
 510:	8082                	ret

0000000000000512 <pipe>:
 512:	4891                	li	a7,4
 514:	00000073          	ecall
 518:	8082                	ret

000000000000051a <read>:
 51a:	4895                	li	a7,5
 51c:	00000073          	ecall
 520:	8082                	ret

0000000000000522 <write>:
 522:	48c1                	li	a7,16
 524:	00000073          	ecall
 528:	8082                	ret

000000000000052a <close>:
 52a:	48d5                	li	a7,21
 52c:	00000073          	ecall
 530:	8082                	ret

0000000000000532 <kill>:
 532:	4899                	li	a7,6
 534:	00000073          	ecall
 538:	8082                	ret

000000000000053a <exec>:
 53a:	489d                	li	a7,7
 53c:	00000073          	ecall
 540:	8082                	ret

0000000000000542 <open>:
 542:	48bd                	li	a7,15
 544:	00000073          	ecall
 548:	8082                	ret

000000000000054a <mknod>:
 54a:	48c5                	li	a7,17
 54c:	00000073          	ecall
 550:	8082                	ret

0000000000000552 <unlink>:
 552:	48c9                	li	a7,18
 554:	00000073          	ecall
 558:	8082                	ret

000000000000055a <fstat>:
 55a:	48a1                	li	a7,8
 55c:	00000073          	ecall
 560:	8082                	ret

0000000000000562 <link>:
 562:	48cd                	li	a7,19
 564:	00000073          	ecall
 568:	8082                	ret

000000000000056a <mkdir>:
 56a:	48d1                	li	a7,20
 56c:	00000073          	ecall
 570:	8082                	ret

0000000000000572 <chdir>:
 572:	48a5                	li	a7,9
 574:	00000073          	ecall
 578:	8082                	ret

000000000000057a <dup>:
 57a:	48a9                	li	a7,10
 57c:	00000073          	ecall
 580:	8082                	ret

0000000000000582 <getpid>:
 582:	48ad                	li	a7,11
 584:	00000073          	ecall
 588:	8082                	ret

000000000000058a <sys_sbrk>:
 58a:	48b1                	li	a7,12
 58c:	00000073          	ecall
 590:	8082                	ret

0000000000000592 <pause>:
 592:	48b5                	li	a7,13
 594:	00000073          	ecall
 598:	8082                	ret

000000000000059a <uptime>:
 59a:	48b9                	li	a7,14
 59c:	00000073          	ecall
 5a0:	8082                	ret

00000000000005a2 <putc>:
 5a2:	1101                	addi	sp,sp,-32
 5a4:	ec06                	sd	ra,24(sp)
 5a6:	e822                	sd	s0,16(sp)
 5a8:	1000                	addi	s0,sp,32
 5aa:	feb407a3          	sb	a1,-17(s0)
 5ae:	4605                	li	a2,1
 5b0:	fef40593          	addi	a1,s0,-17
 5b4:	f6fff0ef          	jal	522 <write>
 5b8:	60e2                	ld	ra,24(sp)
 5ba:	6442                	ld	s0,16(sp)
 5bc:	6105                	addi	sp,sp,32
 5be:	8082                	ret

00000000000005c0 <printint>:
 5c0:	715d                	addi	sp,sp,-80
 5c2:	e486                	sd	ra,72(sp)
 5c4:	e0a2                	sd	s0,64(sp)
 5c6:	fc26                	sd	s1,56(sp)
 5c8:	0880                	addi	s0,sp,80
 5ca:	84aa                	mv	s1,a0
 5cc:	c299                	beqz	a3,5d2 <printint+0x12>
 5ce:	0805c963          	bltz	a1,660 <printint+0xa0>
 5d2:	2581                	sext.w	a1,a1
 5d4:	4881                	li	a7,0
 5d6:	fb840693          	addi	a3,s0,-72
 5da:	4701                	li	a4,0
 5dc:	2601                	sext.w	a2,a2
 5de:	00000517          	auipc	a0,0x0
 5e2:	57a50513          	addi	a0,a0,1402 # b58 <digits>
 5e6:	883a                	mv	a6,a4
 5e8:	2705                	addiw	a4,a4,1
 5ea:	02c5f7bb          	remuw	a5,a1,a2
 5ee:	1782                	slli	a5,a5,0x20
 5f0:	9381                	srli	a5,a5,0x20
 5f2:	97aa                	add	a5,a5,a0
 5f4:	0007c783          	lbu	a5,0(a5)
 5f8:	00f68023          	sb	a5,0(a3)
 5fc:	0005879b          	sext.w	a5,a1
 600:	02c5d5bb          	divuw	a1,a1,a2
 604:	0685                	addi	a3,a3,1
 606:	fec7f0e3          	bgeu	a5,a2,5e6 <printint+0x26>
 60a:	00088c63          	beqz	a7,622 <printint+0x62>
 60e:	fd070793          	addi	a5,a4,-48
 612:	00878733          	add	a4,a5,s0
 616:	02d00793          	li	a5,45
 61a:	fef70423          	sb	a5,-24(a4)
 61e:	0028071b          	addiw	a4,a6,2
 622:	02e05a63          	blez	a4,656 <printint+0x96>
 626:	f84a                	sd	s2,48(sp)
 628:	f44e                	sd	s3,40(sp)
 62a:	fb840793          	addi	a5,s0,-72
 62e:	00e78933          	add	s2,a5,a4
 632:	fff78993          	addi	s3,a5,-1
 636:	99ba                	add	s3,s3,a4
 638:	377d                	addiw	a4,a4,-1
 63a:	1702                	slli	a4,a4,0x20
 63c:	9301                	srli	a4,a4,0x20
 63e:	40e989b3          	sub	s3,s3,a4
 642:	fff94583          	lbu	a1,-1(s2)
 646:	8526                	mv	a0,s1
 648:	f5bff0ef          	jal	5a2 <putc>
 64c:	197d                	addi	s2,s2,-1
 64e:	ff391ae3          	bne	s2,s3,642 <printint+0x82>
 652:	7942                	ld	s2,48(sp)
 654:	79a2                	ld	s3,40(sp)
 656:	60a6                	ld	ra,72(sp)
 658:	6406                	ld	s0,64(sp)
 65a:	74e2                	ld	s1,56(sp)
 65c:	6161                	addi	sp,sp,80
 65e:	8082                	ret
 660:	40b005bb          	negw	a1,a1
 664:	4885                	li	a7,1
 666:	bf85                	j	5d6 <printint+0x16>

0000000000000668 <vprintf>:
 668:	711d                	addi	sp,sp,-96
 66a:	ec86                	sd	ra,88(sp)
 66c:	e8a2                	sd	s0,80(sp)
 66e:	e0ca                	sd	s2,64(sp)
 670:	1080                	addi	s0,sp,96
 672:	0005c903          	lbu	s2,0(a1)
 676:	28090663          	beqz	s2,902 <vprintf+0x29a>
 67a:	e4a6                	sd	s1,72(sp)
 67c:	fc4e                	sd	s3,56(sp)
 67e:	f852                	sd	s4,48(sp)
 680:	f456                	sd	s5,40(sp)
 682:	f05a                	sd	s6,32(sp)
 684:	ec5e                	sd	s7,24(sp)
 686:	e862                	sd	s8,16(sp)
 688:	e466                	sd	s9,8(sp)
 68a:	8b2a                	mv	s6,a0
 68c:	8a2e                	mv	s4,a1
 68e:	8bb2                	mv	s7,a2
 690:	4981                	li	s3,0
 692:	4481                	li	s1,0
 694:	4701                	li	a4,0
 696:	02500a93          	li	s5,37
 69a:	06400c13          	li	s8,100
 69e:	06c00c93          	li	s9,108
 6a2:	a005                	j	6c2 <vprintf+0x5a>
 6a4:	85ca                	mv	a1,s2
 6a6:	855a                	mv	a0,s6
 6a8:	efbff0ef          	jal	5a2 <putc>
 6ac:	a019                	j	6b2 <vprintf+0x4a>
 6ae:	03598263          	beq	s3,s5,6d2 <vprintf+0x6a>
 6b2:	2485                	addiw	s1,s1,1
 6b4:	8726                	mv	a4,s1
 6b6:	009a07b3          	add	a5,s4,s1
 6ba:	0007c903          	lbu	s2,0(a5)
 6be:	22090a63          	beqz	s2,8f2 <vprintf+0x28a>
 6c2:	0009079b          	sext.w	a5,s2
 6c6:	fe0994e3          	bnez	s3,6ae <vprintf+0x46>
 6ca:	fd579de3          	bne	a5,s5,6a4 <vprintf+0x3c>
 6ce:	89be                	mv	s3,a5
 6d0:	b7cd                	j	6b2 <vprintf+0x4a>
 6d2:	00ea06b3          	add	a3,s4,a4
 6d6:	0016c683          	lbu	a3,1(a3)
 6da:	8636                	mv	a2,a3
 6dc:	c681                	beqz	a3,6e4 <vprintf+0x7c>
 6de:	9752                	add	a4,a4,s4
 6e0:	00274603          	lbu	a2,2(a4)
 6e4:	05878363          	beq	a5,s8,72a <vprintf+0xc2>
 6e8:	05978d63          	beq	a5,s9,742 <vprintf+0xda>
 6ec:	07500713          	li	a4,117
 6f0:	0ee78763          	beq	a5,a4,7de <vprintf+0x176>
 6f4:	07800713          	li	a4,120
 6f8:	12e78963          	beq	a5,a4,82a <vprintf+0x1c2>
 6fc:	07000713          	li	a4,112
 700:	14e78e63          	beq	a5,a4,85c <vprintf+0x1f4>
 704:	06300713          	li	a4,99
 708:	18e78e63          	beq	a5,a4,8a4 <vprintf+0x23c>
 70c:	07300713          	li	a4,115
 710:	1ae78463          	beq	a5,a4,8b8 <vprintf+0x250>
 714:	02500713          	li	a4,37
 718:	04e79563          	bne	a5,a4,762 <vprintf+0xfa>
 71c:	02500593          	li	a1,37
 720:	855a                	mv	a0,s6
 722:	e81ff0ef          	jal	5a2 <putc>
 726:	4981                	li	s3,0
 728:	b769                	j	6b2 <vprintf+0x4a>
 72a:	008b8913          	addi	s2,s7,8
 72e:	4685                	li	a3,1
 730:	4629                	li	a2,10
 732:	000ba583          	lw	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	e89ff0ef          	jal	5c0 <printint>
 73c:	8bca                	mv	s7,s2
 73e:	4981                	li	s3,0
 740:	bf8d                	j	6b2 <vprintf+0x4a>
 742:	06400793          	li	a5,100
 746:	02f68963          	beq	a3,a5,778 <vprintf+0x110>
 74a:	06c00793          	li	a5,108
 74e:	04f68263          	beq	a3,a5,792 <vprintf+0x12a>
 752:	07500793          	li	a5,117
 756:	0af68063          	beq	a3,a5,7f6 <vprintf+0x18e>
 75a:	07800793          	li	a5,120
 75e:	0ef68263          	beq	a3,a5,842 <vprintf+0x1da>
 762:	02500593          	li	a1,37
 766:	855a                	mv	a0,s6
 768:	e3bff0ef          	jal	5a2 <putc>
 76c:	85ca                	mv	a1,s2
 76e:	855a                	mv	a0,s6
 770:	e33ff0ef          	jal	5a2 <putc>
 774:	4981                	li	s3,0
 776:	bf35                	j	6b2 <vprintf+0x4a>
 778:	008b8913          	addi	s2,s7,8
 77c:	4685                	li	a3,1
 77e:	4629                	li	a2,10
 780:	000bb583          	ld	a1,0(s7)
 784:	855a                	mv	a0,s6
 786:	e3bff0ef          	jal	5c0 <printint>
 78a:	2485                	addiw	s1,s1,1
 78c:	8bca                	mv	s7,s2
 78e:	4981                	li	s3,0
 790:	b70d                	j	6b2 <vprintf+0x4a>
 792:	06400793          	li	a5,100
 796:	02f60763          	beq	a2,a5,7c4 <vprintf+0x15c>
 79a:	07500793          	li	a5,117
 79e:	06f60963          	beq	a2,a5,810 <vprintf+0x1a8>
 7a2:	07800793          	li	a5,120
 7a6:	faf61ee3          	bne	a2,a5,762 <vprintf+0xfa>
 7aa:	008b8913          	addi	s2,s7,8
 7ae:	4681                	li	a3,0
 7b0:	4641                	li	a2,16
 7b2:	000bb583          	ld	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	e09ff0ef          	jal	5c0 <printint>
 7bc:	2489                	addiw	s1,s1,2
 7be:	8bca                	mv	s7,s2
 7c0:	4981                	li	s3,0
 7c2:	bdc5                	j	6b2 <vprintf+0x4a>
 7c4:	008b8913          	addi	s2,s7,8
 7c8:	4685                	li	a3,1
 7ca:	4629                	li	a2,10
 7cc:	000bb583          	ld	a1,0(s7)
 7d0:	855a                	mv	a0,s6
 7d2:	defff0ef          	jal	5c0 <printint>
 7d6:	2489                	addiw	s1,s1,2
 7d8:	8bca                	mv	s7,s2
 7da:	4981                	li	s3,0
 7dc:	bdd9                	j	6b2 <vprintf+0x4a>
 7de:	008b8913          	addi	s2,s7,8
 7e2:	4681                	li	a3,0
 7e4:	4629                	li	a2,10
 7e6:	000be583          	lwu	a1,0(s7)
 7ea:	855a                	mv	a0,s6
 7ec:	dd5ff0ef          	jal	5c0 <printint>
 7f0:	8bca                	mv	s7,s2
 7f2:	4981                	li	s3,0
 7f4:	bd7d                	j	6b2 <vprintf+0x4a>
 7f6:	008b8913          	addi	s2,s7,8
 7fa:	4681                	li	a3,0
 7fc:	4629                	li	a2,10
 7fe:	000bb583          	ld	a1,0(s7)
 802:	855a                	mv	a0,s6
 804:	dbdff0ef          	jal	5c0 <printint>
 808:	2485                	addiw	s1,s1,1
 80a:	8bca                	mv	s7,s2
 80c:	4981                	li	s3,0
 80e:	b555                	j	6b2 <vprintf+0x4a>
 810:	008b8913          	addi	s2,s7,8
 814:	4681                	li	a3,0
 816:	4629                	li	a2,10
 818:	000bb583          	ld	a1,0(s7)
 81c:	855a                	mv	a0,s6
 81e:	da3ff0ef          	jal	5c0 <printint>
 822:	2489                	addiw	s1,s1,2
 824:	8bca                	mv	s7,s2
 826:	4981                	li	s3,0
 828:	b569                	j	6b2 <vprintf+0x4a>
 82a:	008b8913          	addi	s2,s7,8
 82e:	4681                	li	a3,0
 830:	4641                	li	a2,16
 832:	000be583          	lwu	a1,0(s7)
 836:	855a                	mv	a0,s6
 838:	d89ff0ef          	jal	5c0 <printint>
 83c:	8bca                	mv	s7,s2
 83e:	4981                	li	s3,0
 840:	bd8d                	j	6b2 <vprintf+0x4a>
 842:	008b8913          	addi	s2,s7,8
 846:	4681                	li	a3,0
 848:	4641                	li	a2,16
 84a:	000bb583          	ld	a1,0(s7)
 84e:	855a                	mv	a0,s6
 850:	d71ff0ef          	jal	5c0 <printint>
 854:	2485                	addiw	s1,s1,1
 856:	8bca                	mv	s7,s2
 858:	4981                	li	s3,0
 85a:	bda1                	j	6b2 <vprintf+0x4a>
 85c:	e06a                	sd	s10,0(sp)
 85e:	008b8d13          	addi	s10,s7,8
 862:	000bb983          	ld	s3,0(s7)
 866:	03000593          	li	a1,48
 86a:	855a                	mv	a0,s6
 86c:	d37ff0ef          	jal	5a2 <putc>
 870:	07800593          	li	a1,120
 874:	855a                	mv	a0,s6
 876:	d2dff0ef          	jal	5a2 <putc>
 87a:	4941                	li	s2,16
 87c:	00000b97          	auipc	s7,0x0
 880:	2dcb8b93          	addi	s7,s7,732 # b58 <digits>
 884:	03c9d793          	srli	a5,s3,0x3c
 888:	97de                	add	a5,a5,s7
 88a:	0007c583          	lbu	a1,0(a5)
 88e:	855a                	mv	a0,s6
 890:	d13ff0ef          	jal	5a2 <putc>
 894:	0992                	slli	s3,s3,0x4
 896:	397d                	addiw	s2,s2,-1
 898:	fe0916e3          	bnez	s2,884 <vprintf+0x21c>
 89c:	8bea                	mv	s7,s10
 89e:	4981                	li	s3,0
 8a0:	6d02                	ld	s10,0(sp)
 8a2:	bd01                	j	6b2 <vprintf+0x4a>
 8a4:	008b8913          	addi	s2,s7,8
 8a8:	000bc583          	lbu	a1,0(s7)
 8ac:	855a                	mv	a0,s6
 8ae:	cf5ff0ef          	jal	5a2 <putc>
 8b2:	8bca                	mv	s7,s2
 8b4:	4981                	li	s3,0
 8b6:	bbf5                	j	6b2 <vprintf+0x4a>
 8b8:	008b8993          	addi	s3,s7,8
 8bc:	000bb903          	ld	s2,0(s7)
 8c0:	00090f63          	beqz	s2,8de <vprintf+0x276>
 8c4:	00094583          	lbu	a1,0(s2)
 8c8:	c195                	beqz	a1,8ec <vprintf+0x284>
 8ca:	855a                	mv	a0,s6
 8cc:	cd7ff0ef          	jal	5a2 <putc>
 8d0:	0905                	addi	s2,s2,1
 8d2:	00094583          	lbu	a1,0(s2)
 8d6:	f9f5                	bnez	a1,8ca <vprintf+0x262>
 8d8:	8bce                	mv	s7,s3
 8da:	4981                	li	s3,0
 8dc:	bbd9                	j	6b2 <vprintf+0x4a>
 8de:	00000917          	auipc	s2,0x0
 8e2:	27290913          	addi	s2,s2,626 # b50 <malloc+0x166>
 8e6:	02800593          	li	a1,40
 8ea:	b7c5                	j	8ca <vprintf+0x262>
 8ec:	8bce                	mv	s7,s3
 8ee:	4981                	li	s3,0
 8f0:	b3c9                	j	6b2 <vprintf+0x4a>
 8f2:	64a6                	ld	s1,72(sp)
 8f4:	79e2                	ld	s3,56(sp)
 8f6:	7a42                	ld	s4,48(sp)
 8f8:	7aa2                	ld	s5,40(sp)
 8fa:	7b02                	ld	s6,32(sp)
 8fc:	6be2                	ld	s7,24(sp)
 8fe:	6c42                	ld	s8,16(sp)
 900:	6ca2                	ld	s9,8(sp)
 902:	60e6                	ld	ra,88(sp)
 904:	6446                	ld	s0,80(sp)
 906:	6906                	ld	s2,64(sp)
 908:	6125                	addi	sp,sp,96
 90a:	8082                	ret

000000000000090c <fprintf>:
 90c:	715d                	addi	sp,sp,-80
 90e:	ec06                	sd	ra,24(sp)
 910:	e822                	sd	s0,16(sp)
 912:	1000                	addi	s0,sp,32
 914:	e010                	sd	a2,0(s0)
 916:	e414                	sd	a3,8(s0)
 918:	e818                	sd	a4,16(s0)
 91a:	ec1c                	sd	a5,24(s0)
 91c:	03043023          	sd	a6,32(s0)
 920:	03143423          	sd	a7,40(s0)
 924:	fe843423          	sd	s0,-24(s0)
 928:	8622                	mv	a2,s0
 92a:	d3fff0ef          	jal	668 <vprintf>
 92e:	60e2                	ld	ra,24(sp)
 930:	6442                	ld	s0,16(sp)
 932:	6161                	addi	sp,sp,80
 934:	8082                	ret

0000000000000936 <printf>:
 936:	711d                	addi	sp,sp,-96
 938:	ec06                	sd	ra,24(sp)
 93a:	e822                	sd	s0,16(sp)
 93c:	1000                	addi	s0,sp,32
 93e:	e40c                	sd	a1,8(s0)
 940:	e810                	sd	a2,16(s0)
 942:	ec14                	sd	a3,24(s0)
 944:	f018                	sd	a4,32(s0)
 946:	f41c                	sd	a5,40(s0)
 948:	03043823          	sd	a6,48(s0)
 94c:	03143c23          	sd	a7,56(s0)
 950:	00840613          	addi	a2,s0,8
 954:	fec43423          	sd	a2,-24(s0)
 958:	85aa                	mv	a1,a0
 95a:	4505                	li	a0,1
 95c:	d0dff0ef          	jal	668 <vprintf>
 960:	60e2                	ld	ra,24(sp)
 962:	6442                	ld	s0,16(sp)
 964:	6125                	addi	sp,sp,96
 966:	8082                	ret

0000000000000968 <free>:
 968:	1141                	addi	sp,sp,-16
 96a:	e422                	sd	s0,8(sp)
 96c:	0800                	addi	s0,sp,16
 96e:	ff050693          	addi	a3,a0,-16
 972:	00001797          	auipc	a5,0x1
 976:	68e7b783          	ld	a5,1678(a5) # 2000 <freep>
 97a:	a02d                	j	9a4 <free+0x3c>
 97c:	4618                	lw	a4,8(a2)
 97e:	9f2d                	addw	a4,a4,a1
 980:	fee52c23          	sw	a4,-8(a0)
 984:	6398                	ld	a4,0(a5)
 986:	6310                	ld	a2,0(a4)
 988:	a83d                	j	9c6 <free+0x5e>
 98a:	ff852703          	lw	a4,-8(a0)
 98e:	9f31                	addw	a4,a4,a2
 990:	c798                	sw	a4,8(a5)
 992:	ff053683          	ld	a3,-16(a0)
 996:	a091                	j	9da <free+0x72>
 998:	6398                	ld	a4,0(a5)
 99a:	00e7e463          	bltu	a5,a4,9a2 <free+0x3a>
 99e:	00e6ea63          	bltu	a3,a4,9b2 <free+0x4a>
 9a2:	87ba                	mv	a5,a4
 9a4:	fed7fae3          	bgeu	a5,a3,998 <free+0x30>
 9a8:	6398                	ld	a4,0(a5)
 9aa:	00e6e463          	bltu	a3,a4,9b2 <free+0x4a>
 9ae:	fee7eae3          	bltu	a5,a4,9a2 <free+0x3a>
 9b2:	ff852583          	lw	a1,-8(a0)
 9b6:	6390                	ld	a2,0(a5)
 9b8:	02059813          	slli	a6,a1,0x20
 9bc:	01c85713          	srli	a4,a6,0x1c
 9c0:	9736                	add	a4,a4,a3
 9c2:	fae60de3          	beq	a2,a4,97c <free+0x14>
 9c6:	fec53823          	sd	a2,-16(a0)
 9ca:	4790                	lw	a2,8(a5)
 9cc:	02061593          	slli	a1,a2,0x20
 9d0:	01c5d713          	srli	a4,a1,0x1c
 9d4:	973e                	add	a4,a4,a5
 9d6:	fae68ae3          	beq	a3,a4,98a <free+0x22>
 9da:	e394                	sd	a3,0(a5)
 9dc:	00001717          	auipc	a4,0x1
 9e0:	62f73223          	sd	a5,1572(a4) # 2000 <freep>
 9e4:	6422                	ld	s0,8(sp)
 9e6:	0141                	addi	sp,sp,16
 9e8:	8082                	ret

00000000000009ea <malloc>:
 9ea:	7139                	addi	sp,sp,-64
 9ec:	fc06                	sd	ra,56(sp)
 9ee:	f822                	sd	s0,48(sp)
 9f0:	f426                	sd	s1,40(sp)
 9f2:	ec4e                	sd	s3,24(sp)
 9f4:	0080                	addi	s0,sp,64
 9f6:	02051493          	slli	s1,a0,0x20
 9fa:	9081                	srli	s1,s1,0x20
 9fc:	04bd                	addi	s1,s1,15
 9fe:	8091                	srli	s1,s1,0x4
 a00:	0014899b          	addiw	s3,s1,1
 a04:	0485                	addi	s1,s1,1
 a06:	00001517          	auipc	a0,0x1
 a0a:	5fa53503          	ld	a0,1530(a0) # 2000 <freep>
 a0e:	c915                	beqz	a0,a42 <malloc+0x58>
 a10:	611c                	ld	a5,0(a0)
 a12:	4798                	lw	a4,8(a5)
 a14:	08977a63          	bgeu	a4,s1,aa8 <malloc+0xbe>
 a18:	f04a                	sd	s2,32(sp)
 a1a:	e852                	sd	s4,16(sp)
 a1c:	e456                	sd	s5,8(sp)
 a1e:	e05a                	sd	s6,0(sp)
 a20:	8a4e                	mv	s4,s3
 a22:	0009871b          	sext.w	a4,s3
 a26:	6685                	lui	a3,0x1
 a28:	00d77363          	bgeu	a4,a3,a2e <malloc+0x44>
 a2c:	6a05                	lui	s4,0x1
 a2e:	000a0b1b          	sext.w	s6,s4
 a32:	004a1a1b          	slliw	s4,s4,0x4
 a36:	00001917          	auipc	s2,0x1
 a3a:	5ca90913          	addi	s2,s2,1482 # 2000 <freep>
 a3e:	5afd                	li	s5,-1
 a40:	a081                	j	a80 <malloc+0x96>
 a42:	f04a                	sd	s2,32(sp)
 a44:	e852                	sd	s4,16(sp)
 a46:	e456                	sd	s5,8(sp)
 a48:	e05a                	sd	s6,0(sp)
 a4a:	00001797          	auipc	a5,0x1
 a4e:	5d678793          	addi	a5,a5,1494 # 2020 <base>
 a52:	00001717          	auipc	a4,0x1
 a56:	5af73723          	sd	a5,1454(a4) # 2000 <freep>
 a5a:	e39c                	sd	a5,0(a5)
 a5c:	0007a423          	sw	zero,8(a5)
 a60:	b7c1                	j	a20 <malloc+0x36>
 a62:	6398                	ld	a4,0(a5)
 a64:	e118                	sd	a4,0(a0)
 a66:	a8a9                	j	ac0 <malloc+0xd6>
 a68:	01652423          	sw	s6,8(a0)
 a6c:	0541                	addi	a0,a0,16
 a6e:	efbff0ef          	jal	968 <free>
 a72:	00093503          	ld	a0,0(s2)
 a76:	c12d                	beqz	a0,ad8 <malloc+0xee>
 a78:	611c                	ld	a5,0(a0)
 a7a:	4798                	lw	a4,8(a5)
 a7c:	02977263          	bgeu	a4,s1,aa0 <malloc+0xb6>
 a80:	00093703          	ld	a4,0(s2)
 a84:	853e                	mv	a0,a5
 a86:	fef719e3          	bne	a4,a5,a78 <malloc+0x8e>
 a8a:	8552                	mv	a0,s4
 a8c:	a43ff0ef          	jal	4ce <sbrk>
 a90:	fd551ce3          	bne	a0,s5,a68 <malloc+0x7e>
 a94:	4501                	li	a0,0
 a96:	7902                	ld	s2,32(sp)
 a98:	6a42                	ld	s4,16(sp)
 a9a:	6aa2                	ld	s5,8(sp)
 a9c:	6b02                	ld	s6,0(sp)
 a9e:	a03d                	j	acc <malloc+0xe2>
 aa0:	7902                	ld	s2,32(sp)
 aa2:	6a42                	ld	s4,16(sp)
 aa4:	6aa2                	ld	s5,8(sp)
 aa6:	6b02                	ld	s6,0(sp)
 aa8:	fae48de3          	beq	s1,a4,a62 <malloc+0x78>
 aac:	4137073b          	subw	a4,a4,s3
 ab0:	c798                	sw	a4,8(a5)
 ab2:	02071693          	slli	a3,a4,0x20
 ab6:	01c6d713          	srli	a4,a3,0x1c
 aba:	97ba                	add	a5,a5,a4
 abc:	0137a423          	sw	s3,8(a5)
 ac0:	00001717          	auipc	a4,0x1
 ac4:	54a73023          	sd	a0,1344(a4) # 2000 <freep>
 ac8:	01078513          	addi	a0,a5,16
 acc:	70e2                	ld	ra,56(sp)
 ace:	7442                	ld	s0,48(sp)
 ad0:	74a2                	ld	s1,40(sp)
 ad2:	69e2                	ld	s3,24(sp)
 ad4:	6121                	addi	sp,sp,64
 ad6:	8082                	ret
 ad8:	7902                	ld	s2,32(sp)
 ada:	6a42                	ld	s4,16(sp)
 adc:	6aa2                	ld	s5,8(sp)
 ade:	6b02                	ld	s6,0(sp)
 ae0:	b7f5                	j	acc <malloc+0xe2>
