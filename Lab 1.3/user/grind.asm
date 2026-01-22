
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
      2a:	02d7c7b3          	div	a5,a5,a3
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
      3e:	17fd                	addi	a5,a5,-1
      40:	e11c                	sd	a5,0(a0)
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	addi	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:
      74:	7159                	addi	sp,sp,-112
      76:	f486                	sd	ra,104(sp)
      78:	f0a2                	sd	s0,96(sp)
      7a:	eca6                	sd	s1,88(sp)
      7c:	fc56                	sd	s5,56(sp)
      7e:	1880                	addi	s0,sp,112
      80:	84aa                	mv	s1,a0
      82:	4501                	li	a0,0
      84:	2bd000ef          	jal	b40 <sbrk>
      88:	8aaa                	mv	s5,a0
      8a:	00001517          	auipc	a0,0x1
      8e:	0d650513          	addi	a0,a0,214 # 1160 <malloc+0x104>
      92:	34b000ef          	jal	bdc <mkdir>
      96:	00001517          	auipc	a0,0x1
      9a:	0ca50513          	addi	a0,a0,202 # 1160 <malloc+0x104>
      9e:	347000ef          	jal	be4 <chdir>
      a2:	cd11                	beqz	a0,be <go+0x4a>
      a4:	e8ca                	sd	s2,80(sp)
      a6:	e4ce                	sd	s3,72(sp)
      a8:	e0d2                	sd	s4,64(sp)
      aa:	f85a                	sd	s6,48(sp)
      ac:	00001517          	auipc	a0,0x1
      b0:	0bc50513          	addi	a0,a0,188 # 1168 <malloc+0x10c>
      b4:	6f5000ef          	jal	fa8 <printf>
      b8:	4505                	li	a0,1
      ba:	2bb000ef          	jal	b74 <exit>
      be:	e8ca                	sd	s2,80(sp)
      c0:	e4ce                	sd	s3,72(sp)
      c2:	e0d2                	sd	s4,64(sp)
      c4:	f85a                	sd	s6,48(sp)
      c6:	00001517          	auipc	a0,0x1
      ca:	0ca50513          	addi	a0,a0,202 # 1190 <malloc+0x134>
      ce:	317000ef          	jal	be4 <chdir>
      d2:	00001997          	auipc	s3,0x1
      d6:	0ce98993          	addi	s3,s3,206 # 11a0 <malloc+0x144>
      da:	c489                	beqz	s1,e4 <go+0x70>
      dc:	00001997          	auipc	s3,0x1
      e0:	0bc98993          	addi	s3,s3,188 # 1198 <malloc+0x13c>
      e4:	4481                	li	s1,0
      e6:	5a7d                	li	s4,-1
      e8:	00001917          	auipc	s2,0x1
      ec:	38890913          	addi	s2,s2,904 # 1470 <malloc+0x414>
      f0:	a819                	j	106 <go+0x92>
      f2:	20200593          	li	a1,514
      f6:	00001517          	auipc	a0,0x1
      fa:	0b250513          	addi	a0,a0,178 # 11a8 <malloc+0x14c>
      fe:	2b7000ef          	jal	bb4 <open>
     102:	29b000ef          	jal	b9c <close>
     106:	0485                	addi	s1,s1,1
     108:	1f400793          	li	a5,500
     10c:	02f4f7b3          	remu	a5,s1,a5
     110:	e791                	bnez	a5,11c <go+0xa8>
     112:	4605                	li	a2,1
     114:	85ce                	mv	a1,s3
     116:	4505                	li	a0,1
     118:	27d000ef          	jal	b94 <write>
     11c:	f3dff0ef          	jal	58 <rand>
     120:	47dd                	li	a5,23
     122:	02f5653b          	remw	a0,a0,a5
     126:	0005071b          	sext.w	a4,a0
     12a:	47d9                	li	a5,22
     12c:	fce7ede3          	bltu	a5,a4,106 <go+0x92>
     130:	02051793          	slli	a5,a0,0x20
     134:	01e7d513          	srli	a0,a5,0x1e
     138:	954a                	add	a0,a0,s2
     13a:	411c                	lw	a5,0(a0)
     13c:	97ca                	add	a5,a5,s2
     13e:	8782                	jr	a5
     140:	20200593          	li	a1,514
     144:	00001517          	auipc	a0,0x1
     148:	07450513          	addi	a0,a0,116 # 11b8 <malloc+0x15c>
     14c:	269000ef          	jal	bb4 <open>
     150:	24d000ef          	jal	b9c <close>
     154:	bf4d                	j	106 <go+0x92>
     156:	00001517          	auipc	a0,0x1
     15a:	05250513          	addi	a0,a0,82 # 11a8 <malloc+0x14c>
     15e:	267000ef          	jal	bc4 <unlink>
     162:	b755                	j	106 <go+0x92>
     164:	00001517          	auipc	a0,0x1
     168:	ffc50513          	addi	a0,a0,-4 # 1160 <malloc+0x104>
     16c:	279000ef          	jal	be4 <chdir>
     170:	ed11                	bnez	a0,18c <go+0x118>
     172:	00001517          	auipc	a0,0x1
     176:	05e50513          	addi	a0,a0,94 # 11d0 <malloc+0x174>
     17a:	24b000ef          	jal	bc4 <unlink>
     17e:	00001517          	auipc	a0,0x1
     182:	01250513          	addi	a0,a0,18 # 1190 <malloc+0x134>
     186:	25f000ef          	jal	be4 <chdir>
     18a:	bfb5                	j	106 <go+0x92>
     18c:	00001517          	auipc	a0,0x1
     190:	fdc50513          	addi	a0,a0,-36 # 1168 <malloc+0x10c>
     194:	615000ef          	jal	fa8 <printf>
     198:	4505                	li	a0,1
     19a:	1db000ef          	jal	b74 <exit>
     19e:	8552                	mv	a0,s4
     1a0:	1fd000ef          	jal	b9c <close>
     1a4:	20200593          	li	a1,514
     1a8:	00001517          	auipc	a0,0x1
     1ac:	03050513          	addi	a0,a0,48 # 11d8 <malloc+0x17c>
     1b0:	205000ef          	jal	bb4 <open>
     1b4:	8a2a                	mv	s4,a0
     1b6:	bf81                	j	106 <go+0x92>
     1b8:	8552                	mv	a0,s4
     1ba:	1e3000ef          	jal	b9c <close>
     1be:	20200593          	li	a1,514
     1c2:	00001517          	auipc	a0,0x1
     1c6:	02650513          	addi	a0,a0,38 # 11e8 <malloc+0x18c>
     1ca:	1eb000ef          	jal	bb4 <open>
     1ce:	8a2a                	mv	s4,a0
     1d0:	bf1d                	j	106 <go+0x92>
     1d2:	3e700613          	li	a2,999
     1d6:	00002597          	auipc	a1,0x2
     1da:	e4a58593          	addi	a1,a1,-438 # 2020 <buf.0>
     1de:	8552                	mv	a0,s4
     1e0:	1b5000ef          	jal	b94 <write>
     1e4:	b70d                	j	106 <go+0x92>
     1e6:	3e700613          	li	a2,999
     1ea:	00002597          	auipc	a1,0x2
     1ee:	e3658593          	addi	a1,a1,-458 # 2020 <buf.0>
     1f2:	8552                	mv	a0,s4
     1f4:	199000ef          	jal	b8c <read>
     1f8:	b739                	j	106 <go+0x92>
     1fa:	00001517          	auipc	a0,0x1
     1fe:	fae50513          	addi	a0,a0,-82 # 11a8 <malloc+0x14c>
     202:	1db000ef          	jal	bdc <mkdir>
     206:	20200593          	li	a1,514
     20a:	00001517          	auipc	a0,0x1
     20e:	ff650513          	addi	a0,a0,-10 # 1200 <malloc+0x1a4>
     212:	1a3000ef          	jal	bb4 <open>
     216:	187000ef          	jal	b9c <close>
     21a:	00001517          	auipc	a0,0x1
     21e:	ff650513          	addi	a0,a0,-10 # 1210 <malloc+0x1b4>
     222:	1a3000ef          	jal	bc4 <unlink>
     226:	b5c5                	j	106 <go+0x92>
     228:	00001517          	auipc	a0,0x1
     22c:	ff050513          	addi	a0,a0,-16 # 1218 <malloc+0x1bc>
     230:	1ad000ef          	jal	bdc <mkdir>
     234:	20200593          	li	a1,514
     238:	00001517          	auipc	a0,0x1
     23c:	fe850513          	addi	a0,a0,-24 # 1220 <malloc+0x1c4>
     240:	175000ef          	jal	bb4 <open>
     244:	159000ef          	jal	b9c <close>
     248:	00001517          	auipc	a0,0x1
     24c:	fe850513          	addi	a0,a0,-24 # 1230 <malloc+0x1d4>
     250:	175000ef          	jal	bc4 <unlink>
     254:	bd4d                	j	106 <go+0x92>
     256:	00001517          	auipc	a0,0x1
     25a:	fe250513          	addi	a0,a0,-30 # 1238 <malloc+0x1dc>
     25e:	167000ef          	jal	bc4 <unlink>
     262:	00001597          	auipc	a1,0x1
     266:	f6e58593          	addi	a1,a1,-146 # 11d0 <malloc+0x174>
     26a:	00001517          	auipc	a0,0x1
     26e:	fd650513          	addi	a0,a0,-42 # 1240 <malloc+0x1e4>
     272:	163000ef          	jal	bd4 <link>
     276:	bd41                	j	106 <go+0x92>
     278:	00001517          	auipc	a0,0x1
     27c:	fe050513          	addi	a0,a0,-32 # 1258 <malloc+0x1fc>
     280:	145000ef          	jal	bc4 <unlink>
     284:	00001597          	auipc	a1,0x1
     288:	f5458593          	addi	a1,a1,-172 # 11d8 <malloc+0x17c>
     28c:	00001517          	auipc	a0,0x1
     290:	fdc50513          	addi	a0,a0,-36 # 1268 <malloc+0x20c>
     294:	141000ef          	jal	bd4 <link>
     298:	b5bd                	j	106 <go+0x92>
     29a:	0d3000ef          	jal	b6c <fork>
     29e:	c519                	beqz	a0,2ac <go+0x238>
     2a0:	00054863          	bltz	a0,2b0 <go+0x23c>
     2a4:	4501                	li	a0,0
     2a6:	0d7000ef          	jal	b7c <wait>
     2aa:	bdb1                	j	106 <go+0x92>
     2ac:	0c9000ef          	jal	b74 <exit>
     2b0:	00001517          	auipc	a0,0x1
     2b4:	fc050513          	addi	a0,a0,-64 # 1270 <malloc+0x214>
     2b8:	4f1000ef          	jal	fa8 <printf>
     2bc:	4505                	li	a0,1
     2be:	0b7000ef          	jal	b74 <exit>
     2c2:	0ab000ef          	jal	b6c <fork>
     2c6:	c519                	beqz	a0,2d4 <go+0x260>
     2c8:	00054d63          	bltz	a0,2e2 <go+0x26e>
     2cc:	4501                	li	a0,0
     2ce:	0af000ef          	jal	b7c <wait>
     2d2:	bd15                	j	106 <go+0x92>
     2d4:	099000ef          	jal	b6c <fork>
     2d8:	095000ef          	jal	b6c <fork>
     2dc:	4501                	li	a0,0
     2de:	097000ef          	jal	b74 <exit>
     2e2:	00001517          	auipc	a0,0x1
     2e6:	f8e50513          	addi	a0,a0,-114 # 1270 <malloc+0x214>
     2ea:	4bf000ef          	jal	fa8 <printf>
     2ee:	4505                	li	a0,1
     2f0:	085000ef          	jal	b74 <exit>
     2f4:	6505                	lui	a0,0x1
     2f6:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x2ab>
     2fa:	047000ef          	jal	b40 <sbrk>
     2fe:	b521                	j	106 <go+0x92>
     300:	4501                	li	a0,0
     302:	03f000ef          	jal	b40 <sbrk>
     306:	e0aaf0e3          	bgeu	s5,a0,106 <go+0x92>
     30a:	4501                	li	a0,0
     30c:	035000ef          	jal	b40 <sbrk>
     310:	40aa853b          	subw	a0,s5,a0
     314:	02d000ef          	jal	b40 <sbrk>
     318:	b3fd                	j	106 <go+0x92>
     31a:	053000ef          	jal	b6c <fork>
     31e:	8b2a                	mv	s6,a0
     320:	c10d                	beqz	a0,342 <go+0x2ce>
     322:	02054d63          	bltz	a0,35c <go+0x2e8>
     326:	00001517          	auipc	a0,0x1
     32a:	f6a50513          	addi	a0,a0,-150 # 1290 <malloc+0x234>
     32e:	0b7000ef          	jal	be4 <chdir>
     332:	ed15                	bnez	a0,36e <go+0x2fa>
     334:	855a                	mv	a0,s6
     336:	06f000ef          	jal	ba4 <kill>
     33a:	4501                	li	a0,0
     33c:	041000ef          	jal	b7c <wait>
     340:	b3d9                	j	106 <go+0x92>
     342:	20200593          	li	a1,514
     346:	00001517          	auipc	a0,0x1
     34a:	f4250513          	addi	a0,a0,-190 # 1288 <malloc+0x22c>
     34e:	067000ef          	jal	bb4 <open>
     352:	04b000ef          	jal	b9c <close>
     356:	4501                	li	a0,0
     358:	01d000ef          	jal	b74 <exit>
     35c:	00001517          	auipc	a0,0x1
     360:	f1450513          	addi	a0,a0,-236 # 1270 <malloc+0x214>
     364:	445000ef          	jal	fa8 <printf>
     368:	4505                	li	a0,1
     36a:	00b000ef          	jal	b74 <exit>
     36e:	00001517          	auipc	a0,0x1
     372:	f3250513          	addi	a0,a0,-206 # 12a0 <malloc+0x244>
     376:	433000ef          	jal	fa8 <printf>
     37a:	4505                	li	a0,1
     37c:	7f8000ef          	jal	b74 <exit>
     380:	7ec000ef          	jal	b6c <fork>
     384:	c519                	beqz	a0,392 <go+0x31e>
     386:	00054d63          	bltz	a0,3a0 <go+0x32c>
     38a:	4501                	li	a0,0
     38c:	7f0000ef          	jal	b7c <wait>
     390:	bb9d                	j	106 <go+0x92>
     392:	063000ef          	jal	bf4 <getpid>
     396:	00f000ef          	jal	ba4 <kill>
     39a:	4501                	li	a0,0
     39c:	7d8000ef          	jal	b74 <exit>
     3a0:	00001517          	auipc	a0,0x1
     3a4:	ed050513          	addi	a0,a0,-304 # 1270 <malloc+0x214>
     3a8:	401000ef          	jal	fa8 <printf>
     3ac:	4505                	li	a0,1
     3ae:	7c6000ef          	jal	b74 <exit>
     3b2:	fa840513          	addi	a0,s0,-88
     3b6:	7ce000ef          	jal	b84 <pipe>
     3ba:	02054363          	bltz	a0,3e0 <go+0x36c>
     3be:	7ae000ef          	jal	b6c <fork>
     3c2:	c905                	beqz	a0,3f2 <go+0x37e>
     3c4:	08054263          	bltz	a0,448 <go+0x3d4>
     3c8:	fa842503          	lw	a0,-88(s0)
     3cc:	7d0000ef          	jal	b9c <close>
     3d0:	fac42503          	lw	a0,-84(s0)
     3d4:	7c8000ef          	jal	b9c <close>
     3d8:	4501                	li	a0,0
     3da:	7a2000ef          	jal	b7c <wait>
     3de:	b325                	j	106 <go+0x92>
     3e0:	00001517          	auipc	a0,0x1
     3e4:	ed850513          	addi	a0,a0,-296 # 12b8 <malloc+0x25c>
     3e8:	3c1000ef          	jal	fa8 <printf>
     3ec:	4505                	li	a0,1
     3ee:	786000ef          	jal	b74 <exit>
     3f2:	77a000ef          	jal	b6c <fork>
     3f6:	776000ef          	jal	b6c <fork>
     3fa:	4605                	li	a2,1
     3fc:	00001597          	auipc	a1,0x1
     400:	ed458593          	addi	a1,a1,-300 # 12d0 <malloc+0x274>
     404:	fac42503          	lw	a0,-84(s0)
     408:	78c000ef          	jal	b94 <write>
     40c:	4785                	li	a5,1
     40e:	00f51f63          	bne	a0,a5,42c <go+0x3b8>
     412:	4605                	li	a2,1
     414:	fa040593          	addi	a1,s0,-96
     418:	fa842503          	lw	a0,-88(s0)
     41c:	770000ef          	jal	b8c <read>
     420:	4785                	li	a5,1
     422:	00f51c63          	bne	a0,a5,43a <go+0x3c6>
     426:	4501                	li	a0,0
     428:	74c000ef          	jal	b74 <exit>
     42c:	00001517          	auipc	a0,0x1
     430:	eac50513          	addi	a0,a0,-340 # 12d8 <malloc+0x27c>
     434:	375000ef          	jal	fa8 <printf>
     438:	bfe9                	j	412 <go+0x39e>
     43a:	00001517          	auipc	a0,0x1
     43e:	ebe50513          	addi	a0,a0,-322 # 12f8 <malloc+0x29c>
     442:	367000ef          	jal	fa8 <printf>
     446:	b7c5                	j	426 <go+0x3b2>
     448:	00001517          	auipc	a0,0x1
     44c:	e2850513          	addi	a0,a0,-472 # 1270 <malloc+0x214>
     450:	359000ef          	jal	fa8 <printf>
     454:	4505                	li	a0,1
     456:	71e000ef          	jal	b74 <exit>
     45a:	712000ef          	jal	b6c <fork>
     45e:	c519                	beqz	a0,46c <go+0x3f8>
     460:	04054f63          	bltz	a0,4be <go+0x44a>
     464:	4501                	li	a0,0
     466:	716000ef          	jal	b7c <wait>
     46a:	b971                	j	106 <go+0x92>
     46c:	00001517          	auipc	a0,0x1
     470:	e1c50513          	addi	a0,a0,-484 # 1288 <malloc+0x22c>
     474:	750000ef          	jal	bc4 <unlink>
     478:	00001517          	auipc	a0,0x1
     47c:	e1050513          	addi	a0,a0,-496 # 1288 <malloc+0x22c>
     480:	75c000ef          	jal	bdc <mkdir>
     484:	00001517          	auipc	a0,0x1
     488:	e0450513          	addi	a0,a0,-508 # 1288 <malloc+0x22c>
     48c:	758000ef          	jal	be4 <chdir>
     490:	00001517          	auipc	a0,0x1
     494:	e8850513          	addi	a0,a0,-376 # 1318 <malloc+0x2bc>
     498:	72c000ef          	jal	bc4 <unlink>
     49c:	20200593          	li	a1,514
     4a0:	00001517          	auipc	a0,0x1
     4a4:	e3050513          	addi	a0,a0,-464 # 12d0 <malloc+0x274>
     4a8:	70c000ef          	jal	bb4 <open>
     4ac:	00001517          	auipc	a0,0x1
     4b0:	e2450513          	addi	a0,a0,-476 # 12d0 <malloc+0x274>
     4b4:	710000ef          	jal	bc4 <unlink>
     4b8:	4501                	li	a0,0
     4ba:	6ba000ef          	jal	b74 <exit>
     4be:	00001517          	auipc	a0,0x1
     4c2:	db250513          	addi	a0,a0,-590 # 1270 <malloc+0x214>
     4c6:	2e3000ef          	jal	fa8 <printf>
     4ca:	4505                	li	a0,1
     4cc:	6a8000ef          	jal	b74 <exit>
     4d0:	00001517          	auipc	a0,0x1
     4d4:	e5050513          	addi	a0,a0,-432 # 1320 <malloc+0x2c4>
     4d8:	6ec000ef          	jal	bc4 <unlink>
     4dc:	20200593          	li	a1,514
     4e0:	00001517          	auipc	a0,0x1
     4e4:	e4050513          	addi	a0,a0,-448 # 1320 <malloc+0x2c4>
     4e8:	6cc000ef          	jal	bb4 <open>
     4ec:	8b2a                	mv	s6,a0
     4ee:	04054763          	bltz	a0,53c <go+0x4c8>
     4f2:	4605                	li	a2,1
     4f4:	00001597          	auipc	a1,0x1
     4f8:	ddc58593          	addi	a1,a1,-548 # 12d0 <malloc+0x274>
     4fc:	698000ef          	jal	b94 <write>
     500:	4785                	li	a5,1
     502:	04f51663          	bne	a0,a5,54e <go+0x4da>
     506:	fa840593          	addi	a1,s0,-88
     50a:	855a                	mv	a0,s6
     50c:	6c0000ef          	jal	bcc <fstat>
     510:	e921                	bnez	a0,560 <go+0x4ec>
     512:	fb843583          	ld	a1,-72(s0)
     516:	4785                	li	a5,1
     518:	04f59d63          	bne	a1,a5,572 <go+0x4fe>
     51c:	fac42583          	lw	a1,-84(s0)
     520:	0c800793          	li	a5,200
     524:	06b7e163          	bltu	a5,a1,586 <go+0x512>
     528:	855a                	mv	a0,s6
     52a:	672000ef          	jal	b9c <close>
     52e:	00001517          	auipc	a0,0x1
     532:	df250513          	addi	a0,a0,-526 # 1320 <malloc+0x2c4>
     536:	68e000ef          	jal	bc4 <unlink>
     53a:	b6f1                	j	106 <go+0x92>
     53c:	00001517          	auipc	a0,0x1
     540:	dec50513          	addi	a0,a0,-532 # 1328 <malloc+0x2cc>
     544:	265000ef          	jal	fa8 <printf>
     548:	4505                	li	a0,1
     54a:	62a000ef          	jal	b74 <exit>
     54e:	00001517          	auipc	a0,0x1
     552:	df250513          	addi	a0,a0,-526 # 1340 <malloc+0x2e4>
     556:	253000ef          	jal	fa8 <printf>
     55a:	4505                	li	a0,1
     55c:	618000ef          	jal	b74 <exit>
     560:	00001517          	auipc	a0,0x1
     564:	df850513          	addi	a0,a0,-520 # 1358 <malloc+0x2fc>
     568:	241000ef          	jal	fa8 <printf>
     56c:	4505                	li	a0,1
     56e:	606000ef          	jal	b74 <exit>
     572:	2581                	sext.w	a1,a1
     574:	00001517          	auipc	a0,0x1
     578:	dfc50513          	addi	a0,a0,-516 # 1370 <malloc+0x314>
     57c:	22d000ef          	jal	fa8 <printf>
     580:	4505                	li	a0,1
     582:	5f2000ef          	jal	b74 <exit>
     586:	00001517          	auipc	a0,0x1
     58a:	e1250513          	addi	a0,a0,-494 # 1398 <malloc+0x33c>
     58e:	21b000ef          	jal	fa8 <printf>
     592:	4505                	li	a0,1
     594:	5e0000ef          	jal	b74 <exit>
     598:	f9840513          	addi	a0,s0,-104
     59c:	5e8000ef          	jal	b84 <pipe>
     5a0:	0c054263          	bltz	a0,664 <go+0x5f0>
     5a4:	fa040513          	addi	a0,s0,-96
     5a8:	5dc000ef          	jal	b84 <pipe>
     5ac:	0c054663          	bltz	a0,678 <go+0x604>
     5b0:	5bc000ef          	jal	b6c <fork>
     5b4:	0c050c63          	beqz	a0,68c <go+0x618>
     5b8:	14054e63          	bltz	a0,714 <go+0x6a0>
     5bc:	5b0000ef          	jal	b6c <fork>
     5c0:	16050463          	beqz	a0,728 <go+0x6b4>
     5c4:	20054263          	bltz	a0,7c8 <go+0x754>
     5c8:	f9842503          	lw	a0,-104(s0)
     5cc:	5d0000ef          	jal	b9c <close>
     5d0:	f9c42503          	lw	a0,-100(s0)
     5d4:	5c8000ef          	jal	b9c <close>
     5d8:	fa442503          	lw	a0,-92(s0)
     5dc:	5c0000ef          	jal	b9c <close>
     5e0:	f8042823          	sw	zero,-112(s0)
     5e4:	4605                	li	a2,1
     5e6:	f9040593          	addi	a1,s0,-112
     5ea:	fa042503          	lw	a0,-96(s0)
     5ee:	59e000ef          	jal	b8c <read>
     5f2:	4605                	li	a2,1
     5f4:	f9140593          	addi	a1,s0,-111
     5f8:	fa042503          	lw	a0,-96(s0)
     5fc:	590000ef          	jal	b8c <read>
     600:	4605                	li	a2,1
     602:	f9240593          	addi	a1,s0,-110
     606:	fa042503          	lw	a0,-96(s0)
     60a:	582000ef          	jal	b8c <read>
     60e:	fa042503          	lw	a0,-96(s0)
     612:	58a000ef          	jal	b9c <close>
     616:	f9440513          	addi	a0,s0,-108
     61a:	562000ef          	jal	b7c <wait>
     61e:	fa840513          	addi	a0,s0,-88
     622:	55a000ef          	jal	b7c <wait>
     626:	f9442783          	lw	a5,-108(s0)
     62a:	fa842703          	lw	a4,-88(s0)
     62e:	8fd9                	or	a5,a5,a4
     630:	eb99                	bnez	a5,646 <go+0x5d2>
     632:	00001597          	auipc	a1,0x1
     636:	e0658593          	addi	a1,a1,-506 # 1438 <malloc+0x3dc>
     63a:	f9040513          	addi	a0,s0,-112
     63e:	2ce000ef          	jal	90c <strcmp>
     642:	ac0502e3          	beqz	a0,106 <go+0x92>
     646:	f9040693          	addi	a3,s0,-112
     64a:	fa842603          	lw	a2,-88(s0)
     64e:	f9442583          	lw	a1,-108(s0)
     652:	00001517          	auipc	a0,0x1
     656:	dee50513          	addi	a0,a0,-530 # 1440 <malloc+0x3e4>
     65a:	14f000ef          	jal	fa8 <printf>
     65e:	4505                	li	a0,1
     660:	514000ef          	jal	b74 <exit>
     664:	00001597          	auipc	a1,0x1
     668:	c5458593          	addi	a1,a1,-940 # 12b8 <malloc+0x25c>
     66c:	4509                	li	a0,2
     66e:	111000ef          	jal	f7e <fprintf>
     672:	4505                	li	a0,1
     674:	500000ef          	jal	b74 <exit>
     678:	00001597          	auipc	a1,0x1
     67c:	c4058593          	addi	a1,a1,-960 # 12b8 <malloc+0x25c>
     680:	4509                	li	a0,2
     682:	0fd000ef          	jal	f7e <fprintf>
     686:	4505                	li	a0,1
     688:	4ec000ef          	jal	b74 <exit>
     68c:	fa042503          	lw	a0,-96(s0)
     690:	50c000ef          	jal	b9c <close>
     694:	fa442503          	lw	a0,-92(s0)
     698:	504000ef          	jal	b9c <close>
     69c:	f9842503          	lw	a0,-104(s0)
     6a0:	4fc000ef          	jal	b9c <close>
     6a4:	4505                	li	a0,1
     6a6:	4f6000ef          	jal	b9c <close>
     6aa:	f9c42503          	lw	a0,-100(s0)
     6ae:	53e000ef          	jal	bec <dup>
     6b2:	4785                	li	a5,1
     6b4:	00f50c63          	beq	a0,a5,6cc <go+0x658>
     6b8:	00001597          	auipc	a1,0x1
     6bc:	d0858593          	addi	a1,a1,-760 # 13c0 <malloc+0x364>
     6c0:	4509                	li	a0,2
     6c2:	0bd000ef          	jal	f7e <fprintf>
     6c6:	4505                	li	a0,1
     6c8:	4ac000ef          	jal	b74 <exit>
     6cc:	f9c42503          	lw	a0,-100(s0)
     6d0:	4cc000ef          	jal	b9c <close>
     6d4:	00001797          	auipc	a5,0x1
     6d8:	d0478793          	addi	a5,a5,-764 # 13d8 <malloc+0x37c>
     6dc:	faf43423          	sd	a5,-88(s0)
     6e0:	00001797          	auipc	a5,0x1
     6e4:	d0078793          	addi	a5,a5,-768 # 13e0 <malloc+0x384>
     6e8:	faf43823          	sd	a5,-80(s0)
     6ec:	fa043c23          	sd	zero,-72(s0)
     6f0:	fa840593          	addi	a1,s0,-88
     6f4:	00001517          	auipc	a0,0x1
     6f8:	cf450513          	addi	a0,a0,-780 # 13e8 <malloc+0x38c>
     6fc:	4b0000ef          	jal	bac <exec>
     700:	00001597          	auipc	a1,0x1
     704:	cf858593          	addi	a1,a1,-776 # 13f8 <malloc+0x39c>
     708:	4509                	li	a0,2
     70a:	075000ef          	jal	f7e <fprintf>
     70e:	4509                	li	a0,2
     710:	464000ef          	jal	b74 <exit>
     714:	00001597          	auipc	a1,0x1
     718:	b5c58593          	addi	a1,a1,-1188 # 1270 <malloc+0x214>
     71c:	4509                	li	a0,2
     71e:	061000ef          	jal	f7e <fprintf>
     722:	450d                	li	a0,3
     724:	450000ef          	jal	b74 <exit>
     728:	f9c42503          	lw	a0,-100(s0)
     72c:	470000ef          	jal	b9c <close>
     730:	fa042503          	lw	a0,-96(s0)
     734:	468000ef          	jal	b9c <close>
     738:	4501                	li	a0,0
     73a:	462000ef          	jal	b9c <close>
     73e:	f9842503          	lw	a0,-104(s0)
     742:	4aa000ef          	jal	bec <dup>
     746:	c919                	beqz	a0,75c <go+0x6e8>
     748:	00001597          	auipc	a1,0x1
     74c:	c7858593          	addi	a1,a1,-904 # 13c0 <malloc+0x364>
     750:	4509                	li	a0,2
     752:	02d000ef          	jal	f7e <fprintf>
     756:	4511                	li	a0,4
     758:	41c000ef          	jal	b74 <exit>
     75c:	f9842503          	lw	a0,-104(s0)
     760:	43c000ef          	jal	b9c <close>
     764:	4505                	li	a0,1
     766:	436000ef          	jal	b9c <close>
     76a:	fa442503          	lw	a0,-92(s0)
     76e:	47e000ef          	jal	bec <dup>
     772:	4785                	li	a5,1
     774:	00f50c63          	beq	a0,a5,78c <go+0x718>
     778:	00001597          	auipc	a1,0x1
     77c:	c4858593          	addi	a1,a1,-952 # 13c0 <malloc+0x364>
     780:	4509                	li	a0,2
     782:	7fc000ef          	jal	f7e <fprintf>
     786:	4515                	li	a0,5
     788:	3ec000ef          	jal	b74 <exit>
     78c:	fa442503          	lw	a0,-92(s0)
     790:	40c000ef          	jal	b9c <close>
     794:	00001797          	auipc	a5,0x1
     798:	c7c78793          	addi	a5,a5,-900 # 1410 <malloc+0x3b4>
     79c:	faf43423          	sd	a5,-88(s0)
     7a0:	fa043823          	sd	zero,-80(s0)
     7a4:	fa840593          	addi	a1,s0,-88
     7a8:	00001517          	auipc	a0,0x1
     7ac:	c7050513          	addi	a0,a0,-912 # 1418 <malloc+0x3bc>
     7b0:	3fc000ef          	jal	bac <exec>
     7b4:	00001597          	auipc	a1,0x1
     7b8:	c6c58593          	addi	a1,a1,-916 # 1420 <malloc+0x3c4>
     7bc:	4509                	li	a0,2
     7be:	7c0000ef          	jal	f7e <fprintf>
     7c2:	4519                	li	a0,6
     7c4:	3b0000ef          	jal	b74 <exit>
     7c8:	00001597          	auipc	a1,0x1
     7cc:	aa858593          	addi	a1,a1,-1368 # 1270 <malloc+0x214>
     7d0:	4509                	li	a0,2
     7d2:	7ac000ef          	jal	f7e <fprintf>
     7d6:	451d                	li	a0,7
     7d8:	39c000ef          	jal	b74 <exit>

00000000000007dc <iter>:
     7dc:	7179                	addi	sp,sp,-48
     7de:	f406                	sd	ra,40(sp)
     7e0:	f022                	sd	s0,32(sp)
     7e2:	1800                	addi	s0,sp,48
     7e4:	00001517          	auipc	a0,0x1
     7e8:	aa450513          	addi	a0,a0,-1372 # 1288 <malloc+0x22c>
     7ec:	3d8000ef          	jal	bc4 <unlink>
     7f0:	00001517          	auipc	a0,0x1
     7f4:	a4850513          	addi	a0,a0,-1464 # 1238 <malloc+0x1dc>
     7f8:	3cc000ef          	jal	bc4 <unlink>
     7fc:	370000ef          	jal	b6c <fork>
     800:	02054163          	bltz	a0,822 <iter+0x46>
     804:	ec26                	sd	s1,24(sp)
     806:	84aa                	mv	s1,a0
     808:	e905                	bnez	a0,838 <iter+0x5c>
     80a:	e84a                	sd	s2,16(sp)
     80c:	00001717          	auipc	a4,0x1
     810:	7f470713          	addi	a4,a4,2036 # 2000 <rand_next>
     814:	631c                	ld	a5,0(a4)
     816:	01f7c793          	xori	a5,a5,31
     81a:	e31c                	sd	a5,0(a4)
     81c:	4501                	li	a0,0
     81e:	857ff0ef          	jal	74 <go>
     822:	ec26                	sd	s1,24(sp)
     824:	e84a                	sd	s2,16(sp)
     826:	00001517          	auipc	a0,0x1
     82a:	a4a50513          	addi	a0,a0,-1462 # 1270 <malloc+0x214>
     82e:	77a000ef          	jal	fa8 <printf>
     832:	4505                	li	a0,1
     834:	340000ef          	jal	b74 <exit>
     838:	e84a                	sd	s2,16(sp)
     83a:	332000ef          	jal	b6c <fork>
     83e:	892a                	mv	s2,a0
     840:	02054063          	bltz	a0,860 <iter+0x84>
     844:	e51d                	bnez	a0,872 <iter+0x96>
     846:	00001697          	auipc	a3,0x1
     84a:	7ba68693          	addi	a3,a3,1978 # 2000 <rand_next>
     84e:	629c                	ld	a5,0(a3)
     850:	6709                	lui	a4,0x2
     852:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x739>
     856:	8fb9                	xor	a5,a5,a4
     858:	e29c                	sd	a5,0(a3)
     85a:	4505                	li	a0,1
     85c:	819ff0ef          	jal	74 <go>
     860:	00001517          	auipc	a0,0x1
     864:	a1050513          	addi	a0,a0,-1520 # 1270 <malloc+0x214>
     868:	740000ef          	jal	fa8 <printf>
     86c:	4505                	li	a0,1
     86e:	306000ef          	jal	b74 <exit>
     872:	57fd                	li	a5,-1
     874:	fcf42e23          	sw	a5,-36(s0)
     878:	fdc40513          	addi	a0,s0,-36
     87c:	300000ef          	jal	b7c <wait>
     880:	fdc42783          	lw	a5,-36(s0)
     884:	eb99                	bnez	a5,89a <iter+0xbe>
     886:	57fd                	li	a5,-1
     888:	fcf42c23          	sw	a5,-40(s0)
     88c:	fd840513          	addi	a0,s0,-40
     890:	2ec000ef          	jal	b7c <wait>
     894:	4501                	li	a0,0
     896:	2de000ef          	jal	b74 <exit>
     89a:	8526                	mv	a0,s1
     89c:	308000ef          	jal	ba4 <kill>
     8a0:	854a                	mv	a0,s2
     8a2:	302000ef          	jal	ba4 <kill>
     8a6:	b7c5                	j	886 <iter+0xaa>

00000000000008a8 <main>:
     8a8:	1101                	addi	sp,sp,-32
     8aa:	ec06                	sd	ra,24(sp)
     8ac:	e822                	sd	s0,16(sp)
     8ae:	e426                	sd	s1,8(sp)
     8b0:	1000                	addi	s0,sp,32
     8b2:	00001497          	auipc	s1,0x1
     8b6:	74e48493          	addi	s1,s1,1870 # 2000 <rand_next>
     8ba:	a809                	j	8cc <main+0x24>
     8bc:	f21ff0ef          	jal	7dc <iter>
     8c0:	4551                	li	a0,20
     8c2:	342000ef          	jal	c04 <pause>
     8c6:	609c                	ld	a5,0(s1)
     8c8:	0785                	addi	a5,a5,1
     8ca:	e09c                	sd	a5,0(s1)
     8cc:	2a0000ef          	jal	b6c <fork>
     8d0:	d575                	beqz	a0,8bc <main+0x14>
     8d2:	fea057e3          	blez	a0,8c0 <main+0x18>
     8d6:	4501                	li	a0,0
     8d8:	2a4000ef          	jal	b7c <wait>
     8dc:	b7d5                	j	8c0 <main+0x18>

00000000000008de <start>:
     8de:	1141                	addi	sp,sp,-16
     8e0:	e406                	sd	ra,8(sp)
     8e2:	e022                	sd	s0,0(sp)
     8e4:	0800                	addi	s0,sp,16
     8e6:	fc3ff0ef          	jal	8a8 <main>
     8ea:	4501                	li	a0,0
     8ec:	288000ef          	jal	b74 <exit>

00000000000008f0 <strcpy>:
     8f0:	1141                	addi	sp,sp,-16
     8f2:	e422                	sd	s0,8(sp)
     8f4:	0800                	addi	s0,sp,16
     8f6:	87aa                	mv	a5,a0
     8f8:	0585                	addi	a1,a1,1
     8fa:	0785                	addi	a5,a5,1
     8fc:	fff5c703          	lbu	a4,-1(a1)
     900:	fee78fa3          	sb	a4,-1(a5)
     904:	fb75                	bnez	a4,8f8 <strcpy+0x8>
     906:	6422                	ld	s0,8(sp)
     908:	0141                	addi	sp,sp,16
     90a:	8082                	ret

000000000000090c <strcmp>:
     90c:	1141                	addi	sp,sp,-16
     90e:	e422                	sd	s0,8(sp)
     910:	0800                	addi	s0,sp,16
     912:	00054783          	lbu	a5,0(a0)
     916:	cb91                	beqz	a5,92a <strcmp+0x1e>
     918:	0005c703          	lbu	a4,0(a1)
     91c:	00f71763          	bne	a4,a5,92a <strcmp+0x1e>
     920:	0505                	addi	a0,a0,1
     922:	0585                	addi	a1,a1,1
     924:	00054783          	lbu	a5,0(a0)
     928:	fbe5                	bnez	a5,918 <strcmp+0xc>
     92a:	0005c503          	lbu	a0,0(a1)
     92e:	40a7853b          	subw	a0,a5,a0
     932:	6422                	ld	s0,8(sp)
     934:	0141                	addi	sp,sp,16
     936:	8082                	ret

0000000000000938 <strlen>:
     938:	1141                	addi	sp,sp,-16
     93a:	e422                	sd	s0,8(sp)
     93c:	0800                	addi	s0,sp,16
     93e:	00054783          	lbu	a5,0(a0)
     942:	cf91                	beqz	a5,95e <strlen+0x26>
     944:	0505                	addi	a0,a0,1
     946:	87aa                	mv	a5,a0
     948:	86be                	mv	a3,a5
     94a:	0785                	addi	a5,a5,1
     94c:	fff7c703          	lbu	a4,-1(a5)
     950:	ff65                	bnez	a4,948 <strlen+0x10>
     952:	40a6853b          	subw	a0,a3,a0
     956:	2505                	addiw	a0,a0,1
     958:	6422                	ld	s0,8(sp)
     95a:	0141                	addi	sp,sp,16
     95c:	8082                	ret
     95e:	4501                	li	a0,0
     960:	bfe5                	j	958 <strlen+0x20>

0000000000000962 <memset>:
     962:	1141                	addi	sp,sp,-16
     964:	e422                	sd	s0,8(sp)
     966:	0800                	addi	s0,sp,16
     968:	ca19                	beqz	a2,97e <memset+0x1c>
     96a:	87aa                	mv	a5,a0
     96c:	1602                	slli	a2,a2,0x20
     96e:	9201                	srli	a2,a2,0x20
     970:	00a60733          	add	a4,a2,a0
     974:	00b78023          	sb	a1,0(a5)
     978:	0785                	addi	a5,a5,1
     97a:	fee79de3          	bne	a5,a4,974 <memset+0x12>
     97e:	6422                	ld	s0,8(sp)
     980:	0141                	addi	sp,sp,16
     982:	8082                	ret

0000000000000984 <strchr>:
     984:	1141                	addi	sp,sp,-16
     986:	e422                	sd	s0,8(sp)
     988:	0800                	addi	s0,sp,16
     98a:	00054783          	lbu	a5,0(a0)
     98e:	cb99                	beqz	a5,9a4 <strchr+0x20>
     990:	00f58763          	beq	a1,a5,99e <strchr+0x1a>
     994:	0505                	addi	a0,a0,1
     996:	00054783          	lbu	a5,0(a0)
     99a:	fbfd                	bnez	a5,990 <strchr+0xc>
     99c:	4501                	li	a0,0
     99e:	6422                	ld	s0,8(sp)
     9a0:	0141                	addi	sp,sp,16
     9a2:	8082                	ret
     9a4:	4501                	li	a0,0
     9a6:	bfe5                	j	99e <strchr+0x1a>

00000000000009a8 <gets>:
     9a8:	711d                	addi	sp,sp,-96
     9aa:	ec86                	sd	ra,88(sp)
     9ac:	e8a2                	sd	s0,80(sp)
     9ae:	e4a6                	sd	s1,72(sp)
     9b0:	e0ca                	sd	s2,64(sp)
     9b2:	fc4e                	sd	s3,56(sp)
     9b4:	f852                	sd	s4,48(sp)
     9b6:	f456                	sd	s5,40(sp)
     9b8:	f05a                	sd	s6,32(sp)
     9ba:	ec5e                	sd	s7,24(sp)
     9bc:	1080                	addi	s0,sp,96
     9be:	8baa                	mv	s7,a0
     9c0:	8a2e                	mv	s4,a1
     9c2:	892a                	mv	s2,a0
     9c4:	4481                	li	s1,0
     9c6:	4aa9                	li	s5,10
     9c8:	4b35                	li	s6,13
     9ca:	89a6                	mv	s3,s1
     9cc:	2485                	addiw	s1,s1,1
     9ce:	0344d663          	bge	s1,s4,9fa <gets+0x52>
     9d2:	4605                	li	a2,1
     9d4:	faf40593          	addi	a1,s0,-81
     9d8:	4501                	li	a0,0
     9da:	1b2000ef          	jal	b8c <read>
     9de:	00a05e63          	blez	a0,9fa <gets+0x52>
     9e2:	faf44783          	lbu	a5,-81(s0)
     9e6:	00f90023          	sb	a5,0(s2)
     9ea:	01578763          	beq	a5,s5,9f8 <gets+0x50>
     9ee:	0905                	addi	s2,s2,1
     9f0:	fd679de3          	bne	a5,s6,9ca <gets+0x22>
     9f4:	89a6                	mv	s3,s1
     9f6:	a011                	j	9fa <gets+0x52>
     9f8:	89a6                	mv	s3,s1
     9fa:	99de                	add	s3,s3,s7
     9fc:	00098023          	sb	zero,0(s3)
     a00:	855e                	mv	a0,s7
     a02:	60e6                	ld	ra,88(sp)
     a04:	6446                	ld	s0,80(sp)
     a06:	64a6                	ld	s1,72(sp)
     a08:	6906                	ld	s2,64(sp)
     a0a:	79e2                	ld	s3,56(sp)
     a0c:	7a42                	ld	s4,48(sp)
     a0e:	7aa2                	ld	s5,40(sp)
     a10:	7b02                	ld	s6,32(sp)
     a12:	6be2                	ld	s7,24(sp)
     a14:	6125                	addi	sp,sp,96
     a16:	8082                	ret

0000000000000a18 <stat>:
     a18:	1101                	addi	sp,sp,-32
     a1a:	ec06                	sd	ra,24(sp)
     a1c:	e822                	sd	s0,16(sp)
     a1e:	e04a                	sd	s2,0(sp)
     a20:	1000                	addi	s0,sp,32
     a22:	892e                	mv	s2,a1
     a24:	4581                	li	a1,0
     a26:	18e000ef          	jal	bb4 <open>
     a2a:	02054263          	bltz	a0,a4e <stat+0x36>
     a2e:	e426                	sd	s1,8(sp)
     a30:	84aa                	mv	s1,a0
     a32:	85ca                	mv	a1,s2
     a34:	198000ef          	jal	bcc <fstat>
     a38:	892a                	mv	s2,a0
     a3a:	8526                	mv	a0,s1
     a3c:	160000ef          	jal	b9c <close>
     a40:	64a2                	ld	s1,8(sp)
     a42:	854a                	mv	a0,s2
     a44:	60e2                	ld	ra,24(sp)
     a46:	6442                	ld	s0,16(sp)
     a48:	6902                	ld	s2,0(sp)
     a4a:	6105                	addi	sp,sp,32
     a4c:	8082                	ret
     a4e:	597d                	li	s2,-1
     a50:	bfcd                	j	a42 <stat+0x2a>

0000000000000a52 <atoi>:
     a52:	1141                	addi	sp,sp,-16
     a54:	e422                	sd	s0,8(sp)
     a56:	0800                	addi	s0,sp,16
     a58:	00054683          	lbu	a3,0(a0)
     a5c:	fd06879b          	addiw	a5,a3,-48
     a60:	0ff7f793          	zext.b	a5,a5
     a64:	4625                	li	a2,9
     a66:	02f66863          	bltu	a2,a5,a96 <atoi+0x44>
     a6a:	872a                	mv	a4,a0
     a6c:	4501                	li	a0,0
     a6e:	0705                	addi	a4,a4,1
     a70:	0025179b          	slliw	a5,a0,0x2
     a74:	9fa9                	addw	a5,a5,a0
     a76:	0017979b          	slliw	a5,a5,0x1
     a7a:	9fb5                	addw	a5,a5,a3
     a7c:	fd07851b          	addiw	a0,a5,-48
     a80:	00074683          	lbu	a3,0(a4)
     a84:	fd06879b          	addiw	a5,a3,-48
     a88:	0ff7f793          	zext.b	a5,a5
     a8c:	fef671e3          	bgeu	a2,a5,a6e <atoi+0x1c>
     a90:	6422                	ld	s0,8(sp)
     a92:	0141                	addi	sp,sp,16
     a94:	8082                	ret
     a96:	4501                	li	a0,0
     a98:	bfe5                	j	a90 <atoi+0x3e>

0000000000000a9a <memmove>:
     a9a:	1141                	addi	sp,sp,-16
     a9c:	e422                	sd	s0,8(sp)
     a9e:	0800                	addi	s0,sp,16
     aa0:	02b57463          	bgeu	a0,a1,ac8 <memmove+0x2e>
     aa4:	00c05f63          	blez	a2,ac2 <memmove+0x28>
     aa8:	1602                	slli	a2,a2,0x20
     aaa:	9201                	srli	a2,a2,0x20
     aac:	00c507b3          	add	a5,a0,a2
     ab0:	872a                	mv	a4,a0
     ab2:	0585                	addi	a1,a1,1
     ab4:	0705                	addi	a4,a4,1
     ab6:	fff5c683          	lbu	a3,-1(a1)
     aba:	fed70fa3          	sb	a3,-1(a4)
     abe:	fef71ae3          	bne	a4,a5,ab2 <memmove+0x18>
     ac2:	6422                	ld	s0,8(sp)
     ac4:	0141                	addi	sp,sp,16
     ac6:	8082                	ret
     ac8:	00c50733          	add	a4,a0,a2
     acc:	95b2                	add	a1,a1,a2
     ace:	fec05ae3          	blez	a2,ac2 <memmove+0x28>
     ad2:	fff6079b          	addiw	a5,a2,-1
     ad6:	1782                	slli	a5,a5,0x20
     ad8:	9381                	srli	a5,a5,0x20
     ada:	fff7c793          	not	a5,a5
     ade:	97ba                	add	a5,a5,a4
     ae0:	15fd                	addi	a1,a1,-1
     ae2:	177d                	addi	a4,a4,-1
     ae4:	0005c683          	lbu	a3,0(a1)
     ae8:	00d70023          	sb	a3,0(a4)
     aec:	fee79ae3          	bne	a5,a4,ae0 <memmove+0x46>
     af0:	bfc9                	j	ac2 <memmove+0x28>

0000000000000af2 <memcmp>:
     af2:	1141                	addi	sp,sp,-16
     af4:	e422                	sd	s0,8(sp)
     af6:	0800                	addi	s0,sp,16
     af8:	ca05                	beqz	a2,b28 <memcmp+0x36>
     afa:	fff6069b          	addiw	a3,a2,-1
     afe:	1682                	slli	a3,a3,0x20
     b00:	9281                	srli	a3,a3,0x20
     b02:	0685                	addi	a3,a3,1
     b04:	96aa                	add	a3,a3,a0
     b06:	00054783          	lbu	a5,0(a0)
     b0a:	0005c703          	lbu	a4,0(a1)
     b0e:	00e79863          	bne	a5,a4,b1e <memcmp+0x2c>
     b12:	0505                	addi	a0,a0,1
     b14:	0585                	addi	a1,a1,1
     b16:	fed518e3          	bne	a0,a3,b06 <memcmp+0x14>
     b1a:	4501                	li	a0,0
     b1c:	a019                	j	b22 <memcmp+0x30>
     b1e:	40e7853b          	subw	a0,a5,a4
     b22:	6422                	ld	s0,8(sp)
     b24:	0141                	addi	sp,sp,16
     b26:	8082                	ret
     b28:	4501                	li	a0,0
     b2a:	bfe5                	j	b22 <memcmp+0x30>

0000000000000b2c <memcpy>:
     b2c:	1141                	addi	sp,sp,-16
     b2e:	e406                	sd	ra,8(sp)
     b30:	e022                	sd	s0,0(sp)
     b32:	0800                	addi	s0,sp,16
     b34:	f67ff0ef          	jal	a9a <memmove>
     b38:	60a2                	ld	ra,8(sp)
     b3a:	6402                	ld	s0,0(sp)
     b3c:	0141                	addi	sp,sp,16
     b3e:	8082                	ret

0000000000000b40 <sbrk>:
     b40:	1141                	addi	sp,sp,-16
     b42:	e406                	sd	ra,8(sp)
     b44:	e022                	sd	s0,0(sp)
     b46:	0800                	addi	s0,sp,16
     b48:	4585                	li	a1,1
     b4a:	0b2000ef          	jal	bfc <sys_sbrk>
     b4e:	60a2                	ld	ra,8(sp)
     b50:	6402                	ld	s0,0(sp)
     b52:	0141                	addi	sp,sp,16
     b54:	8082                	ret

0000000000000b56 <sbrklazy>:
     b56:	1141                	addi	sp,sp,-16
     b58:	e406                	sd	ra,8(sp)
     b5a:	e022                	sd	s0,0(sp)
     b5c:	0800                	addi	s0,sp,16
     b5e:	4589                	li	a1,2
     b60:	09c000ef          	jal	bfc <sys_sbrk>
     b64:	60a2                	ld	ra,8(sp)
     b66:	6402                	ld	s0,0(sp)
     b68:	0141                	addi	sp,sp,16
     b6a:	8082                	ret

0000000000000b6c <fork>:
     b6c:	4885                	li	a7,1
     b6e:	00000073          	ecall
     b72:	8082                	ret

0000000000000b74 <exit>:
     b74:	4889                	li	a7,2
     b76:	00000073          	ecall
     b7a:	8082                	ret

0000000000000b7c <wait>:
     b7c:	488d                	li	a7,3
     b7e:	00000073          	ecall
     b82:	8082                	ret

0000000000000b84 <pipe>:
     b84:	4891                	li	a7,4
     b86:	00000073          	ecall
     b8a:	8082                	ret

0000000000000b8c <read>:
     b8c:	4895                	li	a7,5
     b8e:	00000073          	ecall
     b92:	8082                	ret

0000000000000b94 <write>:
     b94:	48c1                	li	a7,16
     b96:	00000073          	ecall
     b9a:	8082                	ret

0000000000000b9c <close>:
     b9c:	48d5                	li	a7,21
     b9e:	00000073          	ecall
     ba2:	8082                	ret

0000000000000ba4 <kill>:
     ba4:	4899                	li	a7,6
     ba6:	00000073          	ecall
     baa:	8082                	ret

0000000000000bac <exec>:
     bac:	489d                	li	a7,7
     bae:	00000073          	ecall
     bb2:	8082                	ret

0000000000000bb4 <open>:
     bb4:	48bd                	li	a7,15
     bb6:	00000073          	ecall
     bba:	8082                	ret

0000000000000bbc <mknod>:
     bbc:	48c5                	li	a7,17
     bbe:	00000073          	ecall
     bc2:	8082                	ret

0000000000000bc4 <unlink>:
     bc4:	48c9                	li	a7,18
     bc6:	00000073          	ecall
     bca:	8082                	ret

0000000000000bcc <fstat>:
     bcc:	48a1                	li	a7,8
     bce:	00000073          	ecall
     bd2:	8082                	ret

0000000000000bd4 <link>:
     bd4:	48cd                	li	a7,19
     bd6:	00000073          	ecall
     bda:	8082                	ret

0000000000000bdc <mkdir>:
     bdc:	48d1                	li	a7,20
     bde:	00000073          	ecall
     be2:	8082                	ret

0000000000000be4 <chdir>:
     be4:	48a5                	li	a7,9
     be6:	00000073          	ecall
     bea:	8082                	ret

0000000000000bec <dup>:
     bec:	48a9                	li	a7,10
     bee:	00000073          	ecall
     bf2:	8082                	ret

0000000000000bf4 <getpid>:
     bf4:	48ad                	li	a7,11
     bf6:	00000073          	ecall
     bfa:	8082                	ret

0000000000000bfc <sys_sbrk>:
     bfc:	48b1                	li	a7,12
     bfe:	00000073          	ecall
     c02:	8082                	ret

0000000000000c04 <pause>:
     c04:	48b5                	li	a7,13
     c06:	00000073          	ecall
     c0a:	8082                	ret

0000000000000c0c <uptime>:
     c0c:	48b9                	li	a7,14
     c0e:	00000073          	ecall
     c12:	8082                	ret

0000000000000c14 <putc>:
     c14:	1101                	addi	sp,sp,-32
     c16:	ec06                	sd	ra,24(sp)
     c18:	e822                	sd	s0,16(sp)
     c1a:	1000                	addi	s0,sp,32
     c1c:	feb407a3          	sb	a1,-17(s0)
     c20:	4605                	li	a2,1
     c22:	fef40593          	addi	a1,s0,-17
     c26:	f6fff0ef          	jal	b94 <write>
     c2a:	60e2                	ld	ra,24(sp)
     c2c:	6442                	ld	s0,16(sp)
     c2e:	6105                	addi	sp,sp,32
     c30:	8082                	ret

0000000000000c32 <printint>:
     c32:	715d                	addi	sp,sp,-80
     c34:	e486                	sd	ra,72(sp)
     c36:	e0a2                	sd	s0,64(sp)
     c38:	fc26                	sd	s1,56(sp)
     c3a:	0880                	addi	s0,sp,80
     c3c:	84aa                	mv	s1,a0
     c3e:	c299                	beqz	a3,c44 <printint+0x12>
     c40:	0805c963          	bltz	a1,cd2 <printint+0xa0>
     c44:	2581                	sext.w	a1,a1
     c46:	4881                	li	a7,0
     c48:	fb840693          	addi	a3,s0,-72
     c4c:	4701                	li	a4,0
     c4e:	2601                	sext.w	a2,a2
     c50:	00001517          	auipc	a0,0x1
     c54:	88050513          	addi	a0,a0,-1920 # 14d0 <digits>
     c58:	883a                	mv	a6,a4
     c5a:	2705                	addiw	a4,a4,1
     c5c:	02c5f7bb          	remuw	a5,a1,a2
     c60:	1782                	slli	a5,a5,0x20
     c62:	9381                	srli	a5,a5,0x20
     c64:	97aa                	add	a5,a5,a0
     c66:	0007c783          	lbu	a5,0(a5)
     c6a:	00f68023          	sb	a5,0(a3)
     c6e:	0005879b          	sext.w	a5,a1
     c72:	02c5d5bb          	divuw	a1,a1,a2
     c76:	0685                	addi	a3,a3,1
     c78:	fec7f0e3          	bgeu	a5,a2,c58 <printint+0x26>
     c7c:	00088c63          	beqz	a7,c94 <printint+0x62>
     c80:	fd070793          	addi	a5,a4,-48
     c84:	00878733          	add	a4,a5,s0
     c88:	02d00793          	li	a5,45
     c8c:	fef70423          	sb	a5,-24(a4)
     c90:	0028071b          	addiw	a4,a6,2
     c94:	02e05a63          	blez	a4,cc8 <printint+0x96>
     c98:	f84a                	sd	s2,48(sp)
     c9a:	f44e                	sd	s3,40(sp)
     c9c:	fb840793          	addi	a5,s0,-72
     ca0:	00e78933          	add	s2,a5,a4
     ca4:	fff78993          	addi	s3,a5,-1
     ca8:	99ba                	add	s3,s3,a4
     caa:	377d                	addiw	a4,a4,-1
     cac:	1702                	slli	a4,a4,0x20
     cae:	9301                	srli	a4,a4,0x20
     cb0:	40e989b3          	sub	s3,s3,a4
     cb4:	fff94583          	lbu	a1,-1(s2)
     cb8:	8526                	mv	a0,s1
     cba:	f5bff0ef          	jal	c14 <putc>
     cbe:	197d                	addi	s2,s2,-1
     cc0:	ff391ae3          	bne	s2,s3,cb4 <printint+0x82>
     cc4:	7942                	ld	s2,48(sp)
     cc6:	79a2                	ld	s3,40(sp)
     cc8:	60a6                	ld	ra,72(sp)
     cca:	6406                	ld	s0,64(sp)
     ccc:	74e2                	ld	s1,56(sp)
     cce:	6161                	addi	sp,sp,80
     cd0:	8082                	ret
     cd2:	40b005bb          	negw	a1,a1
     cd6:	4885                	li	a7,1
     cd8:	bf85                	j	c48 <printint+0x16>

0000000000000cda <vprintf>:
     cda:	711d                	addi	sp,sp,-96
     cdc:	ec86                	sd	ra,88(sp)
     cde:	e8a2                	sd	s0,80(sp)
     ce0:	e0ca                	sd	s2,64(sp)
     ce2:	1080                	addi	s0,sp,96
     ce4:	0005c903          	lbu	s2,0(a1)
     ce8:	28090663          	beqz	s2,f74 <vprintf+0x29a>
     cec:	e4a6                	sd	s1,72(sp)
     cee:	fc4e                	sd	s3,56(sp)
     cf0:	f852                	sd	s4,48(sp)
     cf2:	f456                	sd	s5,40(sp)
     cf4:	f05a                	sd	s6,32(sp)
     cf6:	ec5e                	sd	s7,24(sp)
     cf8:	e862                	sd	s8,16(sp)
     cfa:	e466                	sd	s9,8(sp)
     cfc:	8b2a                	mv	s6,a0
     cfe:	8a2e                	mv	s4,a1
     d00:	8bb2                	mv	s7,a2
     d02:	4981                	li	s3,0
     d04:	4481                	li	s1,0
     d06:	4701                	li	a4,0
     d08:	02500a93          	li	s5,37
     d0c:	06400c13          	li	s8,100
     d10:	06c00c93          	li	s9,108
     d14:	a005                	j	d34 <vprintf+0x5a>
     d16:	85ca                	mv	a1,s2
     d18:	855a                	mv	a0,s6
     d1a:	efbff0ef          	jal	c14 <putc>
     d1e:	a019                	j	d24 <vprintf+0x4a>
     d20:	03598263          	beq	s3,s5,d44 <vprintf+0x6a>
     d24:	2485                	addiw	s1,s1,1
     d26:	8726                	mv	a4,s1
     d28:	009a07b3          	add	a5,s4,s1
     d2c:	0007c903          	lbu	s2,0(a5)
     d30:	22090a63          	beqz	s2,f64 <vprintf+0x28a>
     d34:	0009079b          	sext.w	a5,s2
     d38:	fe0994e3          	bnez	s3,d20 <vprintf+0x46>
     d3c:	fd579de3          	bne	a5,s5,d16 <vprintf+0x3c>
     d40:	89be                	mv	s3,a5
     d42:	b7cd                	j	d24 <vprintf+0x4a>
     d44:	00ea06b3          	add	a3,s4,a4
     d48:	0016c683          	lbu	a3,1(a3)
     d4c:	8636                	mv	a2,a3
     d4e:	c681                	beqz	a3,d56 <vprintf+0x7c>
     d50:	9752                	add	a4,a4,s4
     d52:	00274603          	lbu	a2,2(a4)
     d56:	05878363          	beq	a5,s8,d9c <vprintf+0xc2>
     d5a:	05978d63          	beq	a5,s9,db4 <vprintf+0xda>
     d5e:	07500713          	li	a4,117
     d62:	0ee78763          	beq	a5,a4,e50 <vprintf+0x176>
     d66:	07800713          	li	a4,120
     d6a:	12e78963          	beq	a5,a4,e9c <vprintf+0x1c2>
     d6e:	07000713          	li	a4,112
     d72:	14e78e63          	beq	a5,a4,ece <vprintf+0x1f4>
     d76:	06300713          	li	a4,99
     d7a:	18e78e63          	beq	a5,a4,f16 <vprintf+0x23c>
     d7e:	07300713          	li	a4,115
     d82:	1ae78463          	beq	a5,a4,f2a <vprintf+0x250>
     d86:	02500713          	li	a4,37
     d8a:	04e79563          	bne	a5,a4,dd4 <vprintf+0xfa>
     d8e:	02500593          	li	a1,37
     d92:	855a                	mv	a0,s6
     d94:	e81ff0ef          	jal	c14 <putc>
     d98:	4981                	li	s3,0
     d9a:	b769                	j	d24 <vprintf+0x4a>
     d9c:	008b8913          	addi	s2,s7,8
     da0:	4685                	li	a3,1
     da2:	4629                	li	a2,10
     da4:	000ba583          	lw	a1,0(s7)
     da8:	855a                	mv	a0,s6
     daa:	e89ff0ef          	jal	c32 <printint>
     dae:	8bca                	mv	s7,s2
     db0:	4981                	li	s3,0
     db2:	bf8d                	j	d24 <vprintf+0x4a>
     db4:	06400793          	li	a5,100
     db8:	02f68963          	beq	a3,a5,dea <vprintf+0x110>
     dbc:	06c00793          	li	a5,108
     dc0:	04f68263          	beq	a3,a5,e04 <vprintf+0x12a>
     dc4:	07500793          	li	a5,117
     dc8:	0af68063          	beq	a3,a5,e68 <vprintf+0x18e>
     dcc:	07800793          	li	a5,120
     dd0:	0ef68263          	beq	a3,a5,eb4 <vprintf+0x1da>
     dd4:	02500593          	li	a1,37
     dd8:	855a                	mv	a0,s6
     dda:	e3bff0ef          	jal	c14 <putc>
     dde:	85ca                	mv	a1,s2
     de0:	855a                	mv	a0,s6
     de2:	e33ff0ef          	jal	c14 <putc>
     de6:	4981                	li	s3,0
     de8:	bf35                	j	d24 <vprintf+0x4a>
     dea:	008b8913          	addi	s2,s7,8
     dee:	4685                	li	a3,1
     df0:	4629                	li	a2,10
     df2:	000bb583          	ld	a1,0(s7)
     df6:	855a                	mv	a0,s6
     df8:	e3bff0ef          	jal	c32 <printint>
     dfc:	2485                	addiw	s1,s1,1
     dfe:	8bca                	mv	s7,s2
     e00:	4981                	li	s3,0
     e02:	b70d                	j	d24 <vprintf+0x4a>
     e04:	06400793          	li	a5,100
     e08:	02f60763          	beq	a2,a5,e36 <vprintf+0x15c>
     e0c:	07500793          	li	a5,117
     e10:	06f60963          	beq	a2,a5,e82 <vprintf+0x1a8>
     e14:	07800793          	li	a5,120
     e18:	faf61ee3          	bne	a2,a5,dd4 <vprintf+0xfa>
     e1c:	008b8913          	addi	s2,s7,8
     e20:	4681                	li	a3,0
     e22:	4641                	li	a2,16
     e24:	000bb583          	ld	a1,0(s7)
     e28:	855a                	mv	a0,s6
     e2a:	e09ff0ef          	jal	c32 <printint>
     e2e:	2489                	addiw	s1,s1,2
     e30:	8bca                	mv	s7,s2
     e32:	4981                	li	s3,0
     e34:	bdc5                	j	d24 <vprintf+0x4a>
     e36:	008b8913          	addi	s2,s7,8
     e3a:	4685                	li	a3,1
     e3c:	4629                	li	a2,10
     e3e:	000bb583          	ld	a1,0(s7)
     e42:	855a                	mv	a0,s6
     e44:	defff0ef          	jal	c32 <printint>
     e48:	2489                	addiw	s1,s1,2
     e4a:	8bca                	mv	s7,s2
     e4c:	4981                	li	s3,0
     e4e:	bdd9                	j	d24 <vprintf+0x4a>
     e50:	008b8913          	addi	s2,s7,8
     e54:	4681                	li	a3,0
     e56:	4629                	li	a2,10
     e58:	000be583          	lwu	a1,0(s7)
     e5c:	855a                	mv	a0,s6
     e5e:	dd5ff0ef          	jal	c32 <printint>
     e62:	8bca                	mv	s7,s2
     e64:	4981                	li	s3,0
     e66:	bd7d                	j	d24 <vprintf+0x4a>
     e68:	008b8913          	addi	s2,s7,8
     e6c:	4681                	li	a3,0
     e6e:	4629                	li	a2,10
     e70:	000bb583          	ld	a1,0(s7)
     e74:	855a                	mv	a0,s6
     e76:	dbdff0ef          	jal	c32 <printint>
     e7a:	2485                	addiw	s1,s1,1
     e7c:	8bca                	mv	s7,s2
     e7e:	4981                	li	s3,0
     e80:	b555                	j	d24 <vprintf+0x4a>
     e82:	008b8913          	addi	s2,s7,8
     e86:	4681                	li	a3,0
     e88:	4629                	li	a2,10
     e8a:	000bb583          	ld	a1,0(s7)
     e8e:	855a                	mv	a0,s6
     e90:	da3ff0ef          	jal	c32 <printint>
     e94:	2489                	addiw	s1,s1,2
     e96:	8bca                	mv	s7,s2
     e98:	4981                	li	s3,0
     e9a:	b569                	j	d24 <vprintf+0x4a>
     e9c:	008b8913          	addi	s2,s7,8
     ea0:	4681                	li	a3,0
     ea2:	4641                	li	a2,16
     ea4:	000be583          	lwu	a1,0(s7)
     ea8:	855a                	mv	a0,s6
     eaa:	d89ff0ef          	jal	c32 <printint>
     eae:	8bca                	mv	s7,s2
     eb0:	4981                	li	s3,0
     eb2:	bd8d                	j	d24 <vprintf+0x4a>
     eb4:	008b8913          	addi	s2,s7,8
     eb8:	4681                	li	a3,0
     eba:	4641                	li	a2,16
     ebc:	000bb583          	ld	a1,0(s7)
     ec0:	855a                	mv	a0,s6
     ec2:	d71ff0ef          	jal	c32 <printint>
     ec6:	2485                	addiw	s1,s1,1
     ec8:	8bca                	mv	s7,s2
     eca:	4981                	li	s3,0
     ecc:	bda1                	j	d24 <vprintf+0x4a>
     ece:	e06a                	sd	s10,0(sp)
     ed0:	008b8d13          	addi	s10,s7,8
     ed4:	000bb983          	ld	s3,0(s7)
     ed8:	03000593          	li	a1,48
     edc:	855a                	mv	a0,s6
     ede:	d37ff0ef          	jal	c14 <putc>
     ee2:	07800593          	li	a1,120
     ee6:	855a                	mv	a0,s6
     ee8:	d2dff0ef          	jal	c14 <putc>
     eec:	4941                	li	s2,16
     eee:	00000b97          	auipc	s7,0x0
     ef2:	5e2b8b93          	addi	s7,s7,1506 # 14d0 <digits>
     ef6:	03c9d793          	srli	a5,s3,0x3c
     efa:	97de                	add	a5,a5,s7
     efc:	0007c583          	lbu	a1,0(a5)
     f00:	855a                	mv	a0,s6
     f02:	d13ff0ef          	jal	c14 <putc>
     f06:	0992                	slli	s3,s3,0x4
     f08:	397d                	addiw	s2,s2,-1
     f0a:	fe0916e3          	bnez	s2,ef6 <vprintf+0x21c>
     f0e:	8bea                	mv	s7,s10
     f10:	4981                	li	s3,0
     f12:	6d02                	ld	s10,0(sp)
     f14:	bd01                	j	d24 <vprintf+0x4a>
     f16:	008b8913          	addi	s2,s7,8
     f1a:	000bc583          	lbu	a1,0(s7)
     f1e:	855a                	mv	a0,s6
     f20:	cf5ff0ef          	jal	c14 <putc>
     f24:	8bca                	mv	s7,s2
     f26:	4981                	li	s3,0
     f28:	bbf5                	j	d24 <vprintf+0x4a>
     f2a:	008b8993          	addi	s3,s7,8
     f2e:	000bb903          	ld	s2,0(s7)
     f32:	00090f63          	beqz	s2,f50 <vprintf+0x276>
     f36:	00094583          	lbu	a1,0(s2)
     f3a:	c195                	beqz	a1,f5e <vprintf+0x284>
     f3c:	855a                	mv	a0,s6
     f3e:	cd7ff0ef          	jal	c14 <putc>
     f42:	0905                	addi	s2,s2,1
     f44:	00094583          	lbu	a1,0(s2)
     f48:	f9f5                	bnez	a1,f3c <vprintf+0x262>
     f4a:	8bce                	mv	s7,s3
     f4c:	4981                	li	s3,0
     f4e:	bbd9                	j	d24 <vprintf+0x4a>
     f50:	00000917          	auipc	s2,0x0
     f54:	51890913          	addi	s2,s2,1304 # 1468 <malloc+0x40c>
     f58:	02800593          	li	a1,40
     f5c:	b7c5                	j	f3c <vprintf+0x262>
     f5e:	8bce                	mv	s7,s3
     f60:	4981                	li	s3,0
     f62:	b3c9                	j	d24 <vprintf+0x4a>
     f64:	64a6                	ld	s1,72(sp)
     f66:	79e2                	ld	s3,56(sp)
     f68:	7a42                	ld	s4,48(sp)
     f6a:	7aa2                	ld	s5,40(sp)
     f6c:	7b02                	ld	s6,32(sp)
     f6e:	6be2                	ld	s7,24(sp)
     f70:	6c42                	ld	s8,16(sp)
     f72:	6ca2                	ld	s9,8(sp)
     f74:	60e6                	ld	ra,88(sp)
     f76:	6446                	ld	s0,80(sp)
     f78:	6906                	ld	s2,64(sp)
     f7a:	6125                	addi	sp,sp,96
     f7c:	8082                	ret

0000000000000f7e <fprintf>:
     f7e:	715d                	addi	sp,sp,-80
     f80:	ec06                	sd	ra,24(sp)
     f82:	e822                	sd	s0,16(sp)
     f84:	1000                	addi	s0,sp,32
     f86:	e010                	sd	a2,0(s0)
     f88:	e414                	sd	a3,8(s0)
     f8a:	e818                	sd	a4,16(s0)
     f8c:	ec1c                	sd	a5,24(s0)
     f8e:	03043023          	sd	a6,32(s0)
     f92:	03143423          	sd	a7,40(s0)
     f96:	fe843423          	sd	s0,-24(s0)
     f9a:	8622                	mv	a2,s0
     f9c:	d3fff0ef          	jal	cda <vprintf>
     fa0:	60e2                	ld	ra,24(sp)
     fa2:	6442                	ld	s0,16(sp)
     fa4:	6161                	addi	sp,sp,80
     fa6:	8082                	ret

0000000000000fa8 <printf>:
     fa8:	711d                	addi	sp,sp,-96
     faa:	ec06                	sd	ra,24(sp)
     fac:	e822                	sd	s0,16(sp)
     fae:	1000                	addi	s0,sp,32
     fb0:	e40c                	sd	a1,8(s0)
     fb2:	e810                	sd	a2,16(s0)
     fb4:	ec14                	sd	a3,24(s0)
     fb6:	f018                	sd	a4,32(s0)
     fb8:	f41c                	sd	a5,40(s0)
     fba:	03043823          	sd	a6,48(s0)
     fbe:	03143c23          	sd	a7,56(s0)
     fc2:	00840613          	addi	a2,s0,8
     fc6:	fec43423          	sd	a2,-24(s0)
     fca:	85aa                	mv	a1,a0
     fcc:	4505                	li	a0,1
     fce:	d0dff0ef          	jal	cda <vprintf>
     fd2:	60e2                	ld	ra,24(sp)
     fd4:	6442                	ld	s0,16(sp)
     fd6:	6125                	addi	sp,sp,96
     fd8:	8082                	ret

0000000000000fda <free>:
     fda:	1141                	addi	sp,sp,-16
     fdc:	e422                	sd	s0,8(sp)
     fde:	0800                	addi	s0,sp,16
     fe0:	ff050693          	addi	a3,a0,-16
     fe4:	00001797          	auipc	a5,0x1
     fe8:	02c7b783          	ld	a5,44(a5) # 2010 <freep>
     fec:	a02d                	j	1016 <free+0x3c>
     fee:	4618                	lw	a4,8(a2)
     ff0:	9f2d                	addw	a4,a4,a1
     ff2:	fee52c23          	sw	a4,-8(a0)
     ff6:	6398                	ld	a4,0(a5)
     ff8:	6310                	ld	a2,0(a4)
     ffa:	a83d                	j	1038 <free+0x5e>
     ffc:	ff852703          	lw	a4,-8(a0)
    1000:	9f31                	addw	a4,a4,a2
    1002:	c798                	sw	a4,8(a5)
    1004:	ff053683          	ld	a3,-16(a0)
    1008:	a091                	j	104c <free+0x72>
    100a:	6398                	ld	a4,0(a5)
    100c:	00e7e463          	bltu	a5,a4,1014 <free+0x3a>
    1010:	00e6ea63          	bltu	a3,a4,1024 <free+0x4a>
    1014:	87ba                	mv	a5,a4
    1016:	fed7fae3          	bgeu	a5,a3,100a <free+0x30>
    101a:	6398                	ld	a4,0(a5)
    101c:	00e6e463          	bltu	a3,a4,1024 <free+0x4a>
    1020:	fee7eae3          	bltu	a5,a4,1014 <free+0x3a>
    1024:	ff852583          	lw	a1,-8(a0)
    1028:	6390                	ld	a2,0(a5)
    102a:	02059813          	slli	a6,a1,0x20
    102e:	01c85713          	srli	a4,a6,0x1c
    1032:	9736                	add	a4,a4,a3
    1034:	fae60de3          	beq	a2,a4,fee <free+0x14>
    1038:	fec53823          	sd	a2,-16(a0)
    103c:	4790                	lw	a2,8(a5)
    103e:	02061593          	slli	a1,a2,0x20
    1042:	01c5d713          	srli	a4,a1,0x1c
    1046:	973e                	add	a4,a4,a5
    1048:	fae68ae3          	beq	a3,a4,ffc <free+0x22>
    104c:	e394                	sd	a3,0(a5)
    104e:	00001717          	auipc	a4,0x1
    1052:	fcf73123          	sd	a5,-62(a4) # 2010 <freep>
    1056:	6422                	ld	s0,8(sp)
    1058:	0141                	addi	sp,sp,16
    105a:	8082                	ret

000000000000105c <malloc>:
    105c:	7139                	addi	sp,sp,-64
    105e:	fc06                	sd	ra,56(sp)
    1060:	f822                	sd	s0,48(sp)
    1062:	f426                	sd	s1,40(sp)
    1064:	ec4e                	sd	s3,24(sp)
    1066:	0080                	addi	s0,sp,64
    1068:	02051493          	slli	s1,a0,0x20
    106c:	9081                	srli	s1,s1,0x20
    106e:	04bd                	addi	s1,s1,15
    1070:	8091                	srli	s1,s1,0x4
    1072:	0014899b          	addiw	s3,s1,1
    1076:	0485                	addi	s1,s1,1
    1078:	00001517          	auipc	a0,0x1
    107c:	f9853503          	ld	a0,-104(a0) # 2010 <freep>
    1080:	c915                	beqz	a0,10b4 <malloc+0x58>
    1082:	611c                	ld	a5,0(a0)
    1084:	4798                	lw	a4,8(a5)
    1086:	08977a63          	bgeu	a4,s1,111a <malloc+0xbe>
    108a:	f04a                	sd	s2,32(sp)
    108c:	e852                	sd	s4,16(sp)
    108e:	e456                	sd	s5,8(sp)
    1090:	e05a                	sd	s6,0(sp)
    1092:	8a4e                	mv	s4,s3
    1094:	0009871b          	sext.w	a4,s3
    1098:	6685                	lui	a3,0x1
    109a:	00d77363          	bgeu	a4,a3,10a0 <malloc+0x44>
    109e:	6a05                	lui	s4,0x1
    10a0:	000a0b1b          	sext.w	s6,s4
    10a4:	004a1a1b          	slliw	s4,s4,0x4
    10a8:	00001917          	auipc	s2,0x1
    10ac:	f6890913          	addi	s2,s2,-152 # 2010 <freep>
    10b0:	5afd                	li	s5,-1
    10b2:	a081                	j	10f2 <malloc+0x96>
    10b4:	f04a                	sd	s2,32(sp)
    10b6:	e852                	sd	s4,16(sp)
    10b8:	e456                	sd	s5,8(sp)
    10ba:	e05a                	sd	s6,0(sp)
    10bc:	00001797          	auipc	a5,0x1
    10c0:	34c78793          	addi	a5,a5,844 # 2408 <base>
    10c4:	00001717          	auipc	a4,0x1
    10c8:	f4f73623          	sd	a5,-180(a4) # 2010 <freep>
    10cc:	e39c                	sd	a5,0(a5)
    10ce:	0007a423          	sw	zero,8(a5)
    10d2:	b7c1                	j	1092 <malloc+0x36>
    10d4:	6398                	ld	a4,0(a5)
    10d6:	e118                	sd	a4,0(a0)
    10d8:	a8a9                	j	1132 <malloc+0xd6>
    10da:	01652423          	sw	s6,8(a0)
    10de:	0541                	addi	a0,a0,16
    10e0:	efbff0ef          	jal	fda <free>
    10e4:	00093503          	ld	a0,0(s2)
    10e8:	c12d                	beqz	a0,114a <malloc+0xee>
    10ea:	611c                	ld	a5,0(a0)
    10ec:	4798                	lw	a4,8(a5)
    10ee:	02977263          	bgeu	a4,s1,1112 <malloc+0xb6>
    10f2:	00093703          	ld	a4,0(s2)
    10f6:	853e                	mv	a0,a5
    10f8:	fef719e3          	bne	a4,a5,10ea <malloc+0x8e>
    10fc:	8552                	mv	a0,s4
    10fe:	a43ff0ef          	jal	b40 <sbrk>
    1102:	fd551ce3          	bne	a0,s5,10da <malloc+0x7e>
    1106:	4501                	li	a0,0
    1108:	7902                	ld	s2,32(sp)
    110a:	6a42                	ld	s4,16(sp)
    110c:	6aa2                	ld	s5,8(sp)
    110e:	6b02                	ld	s6,0(sp)
    1110:	a03d                	j	113e <malloc+0xe2>
    1112:	7902                	ld	s2,32(sp)
    1114:	6a42                	ld	s4,16(sp)
    1116:	6aa2                	ld	s5,8(sp)
    1118:	6b02                	ld	s6,0(sp)
    111a:	fae48de3          	beq	s1,a4,10d4 <malloc+0x78>
    111e:	4137073b          	subw	a4,a4,s3
    1122:	c798                	sw	a4,8(a5)
    1124:	02071693          	slli	a3,a4,0x20
    1128:	01c6d713          	srli	a4,a3,0x1c
    112c:	97ba                	add	a5,a5,a4
    112e:	0137a423          	sw	s3,8(a5)
    1132:	00001717          	auipc	a4,0x1
    1136:	eca73f23          	sd	a0,-290(a4) # 2010 <freep>
    113a:	01078513          	addi	a0,a5,16
    113e:	70e2                	ld	ra,56(sp)
    1140:	7442                	ld	s0,48(sp)
    1142:	74a2                	ld	s1,40(sp)
    1144:	69e2                	ld	s3,24(sp)
    1146:	6121                	addi	sp,sp,64
    1148:	8082                	ret
    114a:	7902                	ld	s2,32(sp)
    114c:	6a42                	ld	s4,16(sp)
    114e:	6aa2                	ld	s5,8(sp)
    1150:	6b02                	ld	s6,0(sp)
    1152:	b7f5                	j	113e <malloc+0xe2>
