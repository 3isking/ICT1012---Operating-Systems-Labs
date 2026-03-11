
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
       0:	00008797          	auipc	a5,0x8
       4:	01078793          	addi	a5,a5,16 # 8010 <uninit>
       8:	0000a697          	auipc	a3,0xa
       c:	71868693          	addi	a3,a3,1816 # a720 <buf>
    if(uninit[i] != '\0'){
      10:	0007c703          	lbu	a4,0(a5)
      14:	e709                	bnez	a4,1e <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      16:	0785                	addi	a5,a5,1
      18:	fed79ce3          	bne	a5,a3,10 <bsstest+0x10>
      1c:	8082                	ret
{
      1e:	1141                	addi	sp,sp,-16
      20:	e406                	sd	ra,8(sp)
      22:	e022                	sd	s0,0(sp)
      24:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      26:	85aa                	mv	a1,a0
      28:	00005517          	auipc	a0,0x5
      2c:	97850513          	addi	a0,a0,-1672 # 49a0 <malloc+0x10c>
      30:	00004097          	auipc	ra,0x4
      34:	7ac080e7          	jalr	1964(ra) # 47dc <printf>
      exit(1);
      38:	4505                	li	a0,1
      3a:	00004097          	auipc	ra,0x4
      3e:	43a080e7          	jalr	1082(ra) # 4474 <exit>

0000000000000042 <iputtest>:
{
      42:	1101                	addi	sp,sp,-32
      44:	ec06                	sd	ra,24(sp)
      46:	e822                	sd	s0,16(sp)
      48:	e426                	sd	s1,8(sp)
      4a:	1000                	addi	s0,sp,32
      4c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
      4e:	00005517          	auipc	a0,0x5
      52:	96a50513          	addi	a0,a0,-1686 # 49b8 <malloc+0x124>
      56:	00004097          	auipc	ra,0x4
      5a:	486080e7          	jalr	1158(ra) # 44dc <mkdir>
      5e:	04054563          	bltz	a0,a8 <iputtest+0x66>
  if(chdir("iputdir") < 0){
      62:	00005517          	auipc	a0,0x5
      66:	95650513          	addi	a0,a0,-1706 # 49b8 <malloc+0x124>
      6a:	00004097          	auipc	ra,0x4
      6e:	47a080e7          	jalr	1146(ra) # 44e4 <chdir>
      72:	04054963          	bltz	a0,c4 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
      76:	00005517          	auipc	a0,0x5
      7a:	98250513          	addi	a0,a0,-1662 # 49f8 <malloc+0x164>
      7e:	00004097          	auipc	ra,0x4
      82:	446080e7          	jalr	1094(ra) # 44c4 <unlink>
      86:	04054d63          	bltz	a0,e0 <iputtest+0x9e>
  if(chdir("/") < 0){
      8a:	00005517          	auipc	a0,0x5
      8e:	99e50513          	addi	a0,a0,-1634 # 4a28 <malloc+0x194>
      92:	00004097          	auipc	ra,0x4
      96:	452080e7          	jalr	1106(ra) # 44e4 <chdir>
      9a:	06054163          	bltz	a0,fc <iputtest+0xba>
}
      9e:	60e2                	ld	ra,24(sp)
      a0:	6442                	ld	s0,16(sp)
      a2:	64a2                	ld	s1,8(sp)
      a4:	6105                	addi	sp,sp,32
      a6:	8082                	ret
    printf("%s: mkdir failed\n", s);
      a8:	85a6                	mv	a1,s1
      aa:	00005517          	auipc	a0,0x5
      ae:	91650513          	addi	a0,a0,-1770 # 49c0 <malloc+0x12c>
      b2:	00004097          	auipc	ra,0x4
      b6:	72a080e7          	jalr	1834(ra) # 47dc <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	00004097          	auipc	ra,0x4
      c0:	3b8080e7          	jalr	952(ra) # 4474 <exit>
    printf("%s: chdir iputdir failed\n", s);
      c4:	85a6                	mv	a1,s1
      c6:	00005517          	auipc	a0,0x5
      ca:	91250513          	addi	a0,a0,-1774 # 49d8 <malloc+0x144>
      ce:	00004097          	auipc	ra,0x4
      d2:	70e080e7          	jalr	1806(ra) # 47dc <printf>
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00004097          	auipc	ra,0x4
      dc:	39c080e7          	jalr	924(ra) # 4474 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
      e0:	85a6                	mv	a1,s1
      e2:	00005517          	auipc	a0,0x5
      e6:	92650513          	addi	a0,a0,-1754 # 4a08 <malloc+0x174>
      ea:	00004097          	auipc	ra,0x4
      ee:	6f2080e7          	jalr	1778(ra) # 47dc <printf>
    exit(1);
      f2:	4505                	li	a0,1
      f4:	00004097          	auipc	ra,0x4
      f8:	380080e7          	jalr	896(ra) # 4474 <exit>
    printf("%s: chdir / failed\n", s);
      fc:	85a6                	mv	a1,s1
      fe:	00005517          	auipc	a0,0x5
     102:	93250513          	addi	a0,a0,-1742 # 4a30 <malloc+0x19c>
     106:	00004097          	auipc	ra,0x4
     10a:	6d6080e7          	jalr	1750(ra) # 47dc <printf>
    exit(1);
     10e:	4505                	li	a0,1
     110:	00004097          	auipc	ra,0x4
     114:	364080e7          	jalr	868(ra) # 4474 <exit>

0000000000000118 <rmdot>:
{
     118:	1101                	addi	sp,sp,-32
     11a:	ec06                	sd	ra,24(sp)
     11c:	e822                	sd	s0,16(sp)
     11e:	e426                	sd	s1,8(sp)
     120:	1000                	addi	s0,sp,32
     122:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
     124:	00005517          	auipc	a0,0x5
     128:	92450513          	addi	a0,a0,-1756 # 4a48 <malloc+0x1b4>
     12c:	00004097          	auipc	ra,0x4
     130:	3b0080e7          	jalr	944(ra) # 44dc <mkdir>
     134:	e549                	bnez	a0,1be <rmdot+0xa6>
  if(chdir("dots") != 0){
     136:	00005517          	auipc	a0,0x5
     13a:	91250513          	addi	a0,a0,-1774 # 4a48 <malloc+0x1b4>
     13e:	00004097          	auipc	ra,0x4
     142:	3a6080e7          	jalr	934(ra) # 44e4 <chdir>
     146:	e951                	bnez	a0,1da <rmdot+0xc2>
  if(unlink(".") == 0){
     148:	00005517          	auipc	a0,0x5
     14c:	93850513          	addi	a0,a0,-1736 # 4a80 <malloc+0x1ec>
     150:	00004097          	auipc	ra,0x4
     154:	374080e7          	jalr	884(ra) # 44c4 <unlink>
     158:	cd59                	beqz	a0,1f6 <rmdot+0xde>
  if(unlink("..") == 0){
     15a:	00005517          	auipc	a0,0x5
     15e:	94650513          	addi	a0,a0,-1722 # 4aa0 <malloc+0x20c>
     162:	00004097          	auipc	ra,0x4
     166:	362080e7          	jalr	866(ra) # 44c4 <unlink>
     16a:	c545                	beqz	a0,212 <rmdot+0xfa>
  if(chdir("/") != 0){
     16c:	00005517          	auipc	a0,0x5
     170:	8bc50513          	addi	a0,a0,-1860 # 4a28 <malloc+0x194>
     174:	00004097          	auipc	ra,0x4
     178:	370080e7          	jalr	880(ra) # 44e4 <chdir>
     17c:	e94d                	bnez	a0,22e <rmdot+0x116>
  if(unlink("dots/.") == 0){
     17e:	00005517          	auipc	a0,0x5
     182:	94250513          	addi	a0,a0,-1726 # 4ac0 <malloc+0x22c>
     186:	00004097          	auipc	ra,0x4
     18a:	33e080e7          	jalr	830(ra) # 44c4 <unlink>
     18e:	cd55                	beqz	a0,24a <rmdot+0x132>
  if(unlink("dots/..") == 0){
     190:	00005517          	auipc	a0,0x5
     194:	95850513          	addi	a0,a0,-1704 # 4ae8 <malloc+0x254>
     198:	00004097          	auipc	ra,0x4
     19c:	32c080e7          	jalr	812(ra) # 44c4 <unlink>
     1a0:	c179                	beqz	a0,266 <rmdot+0x14e>
  if(unlink("dots") != 0){
     1a2:	00005517          	auipc	a0,0x5
     1a6:	8a650513          	addi	a0,a0,-1882 # 4a48 <malloc+0x1b4>
     1aa:	00004097          	auipc	ra,0x4
     1ae:	31a080e7          	jalr	794(ra) # 44c4 <unlink>
     1b2:	e961                	bnez	a0,282 <rmdot+0x16a>
}
     1b4:	60e2                	ld	ra,24(sp)
     1b6:	6442                	ld	s0,16(sp)
     1b8:	64a2                	ld	s1,8(sp)
     1ba:	6105                	addi	sp,sp,32
     1bc:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
     1be:	85a6                	mv	a1,s1
     1c0:	00005517          	auipc	a0,0x5
     1c4:	89050513          	addi	a0,a0,-1904 # 4a50 <malloc+0x1bc>
     1c8:	00004097          	auipc	ra,0x4
     1cc:	614080e7          	jalr	1556(ra) # 47dc <printf>
    exit(1);
     1d0:	4505                	li	a0,1
     1d2:	00004097          	auipc	ra,0x4
     1d6:	2a2080e7          	jalr	674(ra) # 4474 <exit>
    printf("%s: chdir dots failed\n", s);
     1da:	85a6                	mv	a1,s1
     1dc:	00005517          	auipc	a0,0x5
     1e0:	88c50513          	addi	a0,a0,-1908 # 4a68 <malloc+0x1d4>
     1e4:	00004097          	auipc	ra,0x4
     1e8:	5f8080e7          	jalr	1528(ra) # 47dc <printf>
    exit(1);
     1ec:	4505                	li	a0,1
     1ee:	00004097          	auipc	ra,0x4
     1f2:	286080e7          	jalr	646(ra) # 4474 <exit>
    printf("%s: rm . worked!\n", s);
     1f6:	85a6                	mv	a1,s1
     1f8:	00005517          	auipc	a0,0x5
     1fc:	89050513          	addi	a0,a0,-1904 # 4a88 <malloc+0x1f4>
     200:	00004097          	auipc	ra,0x4
     204:	5dc080e7          	jalr	1500(ra) # 47dc <printf>
    exit(1);
     208:	4505                	li	a0,1
     20a:	00004097          	auipc	ra,0x4
     20e:	26a080e7          	jalr	618(ra) # 4474 <exit>
    printf("%s: rm .. worked!\n", s);
     212:	85a6                	mv	a1,s1
     214:	00005517          	auipc	a0,0x5
     218:	89450513          	addi	a0,a0,-1900 # 4aa8 <malloc+0x214>
     21c:	00004097          	auipc	ra,0x4
     220:	5c0080e7          	jalr	1472(ra) # 47dc <printf>
    exit(1);
     224:	4505                	li	a0,1
     226:	00004097          	auipc	ra,0x4
     22a:	24e080e7          	jalr	590(ra) # 4474 <exit>
    printf("%s: chdir / failed\n", s);
     22e:	85a6                	mv	a1,s1
     230:	00005517          	auipc	a0,0x5
     234:	80050513          	addi	a0,a0,-2048 # 4a30 <malloc+0x19c>
     238:	00004097          	auipc	ra,0x4
     23c:	5a4080e7          	jalr	1444(ra) # 47dc <printf>
    exit(1);
     240:	4505                	li	a0,1
     242:	00004097          	auipc	ra,0x4
     246:	232080e7          	jalr	562(ra) # 4474 <exit>
    printf("%s: unlink dots/. worked!\n", s);
     24a:	85a6                	mv	a1,s1
     24c:	00005517          	auipc	a0,0x5
     250:	87c50513          	addi	a0,a0,-1924 # 4ac8 <malloc+0x234>
     254:	00004097          	auipc	ra,0x4
     258:	588080e7          	jalr	1416(ra) # 47dc <printf>
    exit(1);
     25c:	4505                	li	a0,1
     25e:	00004097          	auipc	ra,0x4
     262:	216080e7          	jalr	534(ra) # 4474 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
     266:	85a6                	mv	a1,s1
     268:	00005517          	auipc	a0,0x5
     26c:	88850513          	addi	a0,a0,-1912 # 4af0 <malloc+0x25c>
     270:	00004097          	auipc	ra,0x4
     274:	56c080e7          	jalr	1388(ra) # 47dc <printf>
    exit(1);
     278:	4505                	li	a0,1
     27a:	00004097          	auipc	ra,0x4
     27e:	1fa080e7          	jalr	506(ra) # 4474 <exit>
    printf("%s: unlink dots failed!\n", s);
     282:	85a6                	mv	a1,s1
     284:	00005517          	auipc	a0,0x5
     288:	88c50513          	addi	a0,a0,-1908 # 4b10 <malloc+0x27c>
     28c:	00004097          	auipc	ra,0x4
     290:	550080e7          	jalr	1360(ra) # 47dc <printf>
    exit(1);
     294:	4505                	li	a0,1
     296:	00004097          	auipc	ra,0x4
     29a:	1de080e7          	jalr	478(ra) # 4474 <exit>

000000000000029e <exitiputtest>:
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	1800                	addi	s0,sp,48
     2a8:	84aa                	mv	s1,a0
  pid = fork();
     2aa:	00004097          	auipc	ra,0x4
     2ae:	1c2080e7          	jalr	450(ra) # 446c <fork>
  if(pid < 0){
     2b2:	04054663          	bltz	a0,2fe <exitiputtest+0x60>
  if(pid == 0){
     2b6:	ed45                	bnez	a0,36e <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
     2b8:	00004517          	auipc	a0,0x4
     2bc:	70050513          	addi	a0,a0,1792 # 49b8 <malloc+0x124>
     2c0:	00004097          	auipc	ra,0x4
     2c4:	21c080e7          	jalr	540(ra) # 44dc <mkdir>
     2c8:	04054963          	bltz	a0,31a <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
     2cc:	00004517          	auipc	a0,0x4
     2d0:	6ec50513          	addi	a0,a0,1772 # 49b8 <malloc+0x124>
     2d4:	00004097          	auipc	ra,0x4
     2d8:	210080e7          	jalr	528(ra) # 44e4 <chdir>
     2dc:	04054d63          	bltz	a0,336 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
     2e0:	00004517          	auipc	a0,0x4
     2e4:	71850513          	addi	a0,a0,1816 # 49f8 <malloc+0x164>
     2e8:	00004097          	auipc	ra,0x4
     2ec:	1dc080e7          	jalr	476(ra) # 44c4 <unlink>
     2f0:	06054163          	bltz	a0,352 <exitiputtest+0xb4>
    exit(0);
     2f4:	4501                	li	a0,0
     2f6:	00004097          	auipc	ra,0x4
     2fa:	17e080e7          	jalr	382(ra) # 4474 <exit>
    printf("%s: fork failed\n", s);
     2fe:	85a6                	mv	a1,s1
     300:	00005517          	auipc	a0,0x5
     304:	83050513          	addi	a0,a0,-2000 # 4b30 <malloc+0x29c>
     308:	00004097          	auipc	ra,0x4
     30c:	4d4080e7          	jalr	1236(ra) # 47dc <printf>
    exit(1);
     310:	4505                	li	a0,1
     312:	00004097          	auipc	ra,0x4
     316:	162080e7          	jalr	354(ra) # 4474 <exit>
      printf("%s: mkdir failed\n", s);
     31a:	85a6                	mv	a1,s1
     31c:	00004517          	auipc	a0,0x4
     320:	6a450513          	addi	a0,a0,1700 # 49c0 <malloc+0x12c>
     324:	00004097          	auipc	ra,0x4
     328:	4b8080e7          	jalr	1208(ra) # 47dc <printf>
      exit(1);
     32c:	4505                	li	a0,1
     32e:	00004097          	auipc	ra,0x4
     332:	146080e7          	jalr	326(ra) # 4474 <exit>
      printf("%s: child chdir failed\n", s);
     336:	85a6                	mv	a1,s1
     338:	00005517          	auipc	a0,0x5
     33c:	81050513          	addi	a0,a0,-2032 # 4b48 <malloc+0x2b4>
     340:	00004097          	auipc	ra,0x4
     344:	49c080e7          	jalr	1180(ra) # 47dc <printf>
      exit(1);
     348:	4505                	li	a0,1
     34a:	00004097          	auipc	ra,0x4
     34e:	12a080e7          	jalr	298(ra) # 4474 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
     352:	85a6                	mv	a1,s1
     354:	00004517          	auipc	a0,0x4
     358:	6b450513          	addi	a0,a0,1716 # 4a08 <malloc+0x174>
     35c:	00004097          	auipc	ra,0x4
     360:	480080e7          	jalr	1152(ra) # 47dc <printf>
      exit(1);
     364:	4505                	li	a0,1
     366:	00004097          	auipc	ra,0x4
     36a:	10e080e7          	jalr	270(ra) # 4474 <exit>
  wait(&xstatus);
     36e:	fdc40513          	addi	a0,s0,-36
     372:	00004097          	auipc	ra,0x4
     376:	10a080e7          	jalr	266(ra) # 447c <wait>
  exit(xstatus);
     37a:	fdc42503          	lw	a0,-36(s0)
     37e:	00004097          	auipc	ra,0x4
     382:	0f6080e7          	jalr	246(ra) # 4474 <exit>

0000000000000386 <exitwait>:
{
     386:	7139                	addi	sp,sp,-64
     388:	fc06                	sd	ra,56(sp)
     38a:	f822                	sd	s0,48(sp)
     38c:	f426                	sd	s1,40(sp)
     38e:	f04a                	sd	s2,32(sp)
     390:	ec4e                	sd	s3,24(sp)
     392:	e852                	sd	s4,16(sp)
     394:	0080                	addi	s0,sp,64
     396:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
     398:	4901                	li	s2,0
     39a:	06400993          	li	s3,100
    pid = fork();
     39e:	00004097          	auipc	ra,0x4
     3a2:	0ce080e7          	jalr	206(ra) # 446c <fork>
     3a6:	84aa                	mv	s1,a0
    if(pid < 0){
     3a8:	02054a63          	bltz	a0,3dc <exitwait+0x56>
    if(pid){
     3ac:	c151                	beqz	a0,430 <exitwait+0xaa>
      if(wait(&xstate) != pid){
     3ae:	fcc40513          	addi	a0,s0,-52
     3b2:	00004097          	auipc	ra,0x4
     3b6:	0ca080e7          	jalr	202(ra) # 447c <wait>
     3ba:	02951f63          	bne	a0,s1,3f8 <exitwait+0x72>
      if(i != xstate) {
     3be:	fcc42783          	lw	a5,-52(s0)
     3c2:	05279963          	bne	a5,s2,414 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
     3c6:	2905                	addiw	s2,s2,1
     3c8:	fd391be3          	bne	s2,s3,39e <exitwait+0x18>
}
     3cc:	70e2                	ld	ra,56(sp)
     3ce:	7442                	ld	s0,48(sp)
     3d0:	74a2                	ld	s1,40(sp)
     3d2:	7902                	ld	s2,32(sp)
     3d4:	69e2                	ld	s3,24(sp)
     3d6:	6a42                	ld	s4,16(sp)
     3d8:	6121                	addi	sp,sp,64
     3da:	8082                	ret
      printf("%s: fork failed\n", s);
     3dc:	85d2                	mv	a1,s4
     3de:	00004517          	auipc	a0,0x4
     3e2:	75250513          	addi	a0,a0,1874 # 4b30 <malloc+0x29c>
     3e6:	00004097          	auipc	ra,0x4
     3ea:	3f6080e7          	jalr	1014(ra) # 47dc <printf>
      exit(1);
     3ee:	4505                	li	a0,1
     3f0:	00004097          	auipc	ra,0x4
     3f4:	084080e7          	jalr	132(ra) # 4474 <exit>
        printf("%s: wait wrong pid\n", s);
     3f8:	85d2                	mv	a1,s4
     3fa:	00004517          	auipc	a0,0x4
     3fe:	76650513          	addi	a0,a0,1894 # 4b60 <malloc+0x2cc>
     402:	00004097          	auipc	ra,0x4
     406:	3da080e7          	jalr	986(ra) # 47dc <printf>
        exit(1);
     40a:	4505                	li	a0,1
     40c:	00004097          	auipc	ra,0x4
     410:	068080e7          	jalr	104(ra) # 4474 <exit>
        printf("%s: wait wrong exit status\n", s);
     414:	85d2                	mv	a1,s4
     416:	00004517          	auipc	a0,0x4
     41a:	76250513          	addi	a0,a0,1890 # 4b78 <malloc+0x2e4>
     41e:	00004097          	auipc	ra,0x4
     422:	3be080e7          	jalr	958(ra) # 47dc <printf>
        exit(1);
     426:	4505                	li	a0,1
     428:	00004097          	auipc	ra,0x4
     42c:	04c080e7          	jalr	76(ra) # 4474 <exit>
      exit(i);
     430:	854a                	mv	a0,s2
     432:	00004097          	auipc	ra,0x4
     436:	042080e7          	jalr	66(ra) # 4474 <exit>

000000000000043a <twochildren>:
{
     43a:	1101                	addi	sp,sp,-32
     43c:	ec06                	sd	ra,24(sp)
     43e:	e822                	sd	s0,16(sp)
     440:	e426                	sd	s1,8(sp)
     442:	e04a                	sd	s2,0(sp)
     444:	1000                	addi	s0,sp,32
     446:	892a                	mv	s2,a0
     448:	3e800493          	li	s1,1000
    int pid1 = fork();
     44c:	00004097          	auipc	ra,0x4
     450:	020080e7          	jalr	32(ra) # 446c <fork>
    if(pid1 < 0){
     454:	02054c63          	bltz	a0,48c <twochildren+0x52>
    if(pid1 == 0){
     458:	c921                	beqz	a0,4a8 <twochildren+0x6e>
      int pid2 = fork();
     45a:	00004097          	auipc	ra,0x4
     45e:	012080e7          	jalr	18(ra) # 446c <fork>
      if(pid2 < 0){
     462:	04054763          	bltz	a0,4b0 <twochildren+0x76>
      if(pid2 == 0){
     466:	c13d                	beqz	a0,4cc <twochildren+0x92>
        wait(0);
     468:	4501                	li	a0,0
     46a:	00004097          	auipc	ra,0x4
     46e:	012080e7          	jalr	18(ra) # 447c <wait>
        wait(0);
     472:	4501                	li	a0,0
     474:	00004097          	auipc	ra,0x4
     478:	008080e7          	jalr	8(ra) # 447c <wait>
  for(int i = 0; i < 1000; i++){
     47c:	34fd                	addiw	s1,s1,-1
     47e:	f4f9                	bnez	s1,44c <twochildren+0x12>
}
     480:	60e2                	ld	ra,24(sp)
     482:	6442                	ld	s0,16(sp)
     484:	64a2                	ld	s1,8(sp)
     486:	6902                	ld	s2,0(sp)
     488:	6105                	addi	sp,sp,32
     48a:	8082                	ret
      printf("%s: fork failed\n", s);
     48c:	85ca                	mv	a1,s2
     48e:	00004517          	auipc	a0,0x4
     492:	6a250513          	addi	a0,a0,1698 # 4b30 <malloc+0x29c>
     496:	00004097          	auipc	ra,0x4
     49a:	346080e7          	jalr	838(ra) # 47dc <printf>
      exit(1);
     49e:	4505                	li	a0,1
     4a0:	00004097          	auipc	ra,0x4
     4a4:	fd4080e7          	jalr	-44(ra) # 4474 <exit>
      exit(0);
     4a8:	00004097          	auipc	ra,0x4
     4ac:	fcc080e7          	jalr	-52(ra) # 4474 <exit>
        printf("%s: fork failed\n", s);
     4b0:	85ca                	mv	a1,s2
     4b2:	00004517          	auipc	a0,0x4
     4b6:	67e50513          	addi	a0,a0,1662 # 4b30 <malloc+0x29c>
     4ba:	00004097          	auipc	ra,0x4
     4be:	322080e7          	jalr	802(ra) # 47dc <printf>
        exit(1);
     4c2:	4505                	li	a0,1
     4c4:	00004097          	auipc	ra,0x4
     4c8:	fb0080e7          	jalr	-80(ra) # 4474 <exit>
        exit(0);
     4cc:	00004097          	auipc	ra,0x4
     4d0:	fa8080e7          	jalr	-88(ra) # 4474 <exit>

00000000000004d4 <forkfork>:
{
     4d4:	7179                	addi	sp,sp,-48
     4d6:	f406                	sd	ra,40(sp)
     4d8:	f022                	sd	s0,32(sp)
     4da:	ec26                	sd	s1,24(sp)
     4dc:	1800                	addi	s0,sp,48
     4de:	84aa                	mv	s1,a0
    int pid = fork();
     4e0:	00004097          	auipc	ra,0x4
     4e4:	f8c080e7          	jalr	-116(ra) # 446c <fork>
    if(pid < 0){
     4e8:	04054163          	bltz	a0,52a <forkfork+0x56>
    if(pid == 0){
     4ec:	cd29                	beqz	a0,546 <forkfork+0x72>
    int pid = fork();
     4ee:	00004097          	auipc	ra,0x4
     4f2:	f7e080e7          	jalr	-130(ra) # 446c <fork>
    if(pid < 0){
     4f6:	02054a63          	bltz	a0,52a <forkfork+0x56>
    if(pid == 0){
     4fa:	c531                	beqz	a0,546 <forkfork+0x72>
    wait(&xstatus);
     4fc:	fdc40513          	addi	a0,s0,-36
     500:	00004097          	auipc	ra,0x4
     504:	f7c080e7          	jalr	-132(ra) # 447c <wait>
    if(xstatus != 0) {
     508:	fdc42783          	lw	a5,-36(s0)
     50c:	ebbd                	bnez	a5,582 <forkfork+0xae>
    wait(&xstatus);
     50e:	fdc40513          	addi	a0,s0,-36
     512:	00004097          	auipc	ra,0x4
     516:	f6a080e7          	jalr	-150(ra) # 447c <wait>
    if(xstatus != 0) {
     51a:	fdc42783          	lw	a5,-36(s0)
     51e:	e3b5                	bnez	a5,582 <forkfork+0xae>
}
     520:	70a2                	ld	ra,40(sp)
     522:	7402                	ld	s0,32(sp)
     524:	64e2                	ld	s1,24(sp)
     526:	6145                	addi	sp,sp,48
     528:	8082                	ret
      printf("%s: fork failed", s);
     52a:	85a6                	mv	a1,s1
     52c:	00004517          	auipc	a0,0x4
     530:	66c50513          	addi	a0,a0,1644 # 4b98 <malloc+0x304>
     534:	00004097          	auipc	ra,0x4
     538:	2a8080e7          	jalr	680(ra) # 47dc <printf>
      exit(1);
     53c:	4505                	li	a0,1
     53e:	00004097          	auipc	ra,0x4
     542:	f36080e7          	jalr	-202(ra) # 4474 <exit>
{
     546:	0c800493          	li	s1,200
        int pid1 = fork();
     54a:	00004097          	auipc	ra,0x4
     54e:	f22080e7          	jalr	-222(ra) # 446c <fork>
        if(pid1 < 0){
     552:	00054f63          	bltz	a0,570 <forkfork+0x9c>
        if(pid1 == 0){
     556:	c115                	beqz	a0,57a <forkfork+0xa6>
        wait(0);
     558:	4501                	li	a0,0
     55a:	00004097          	auipc	ra,0x4
     55e:	f22080e7          	jalr	-222(ra) # 447c <wait>
      for(int j = 0; j < 200; j++){
     562:	34fd                	addiw	s1,s1,-1
     564:	f0fd                	bnez	s1,54a <forkfork+0x76>
      exit(0);
     566:	4501                	li	a0,0
     568:	00004097          	auipc	ra,0x4
     56c:	f0c080e7          	jalr	-244(ra) # 4474 <exit>
          exit(1);
     570:	4505                	li	a0,1
     572:	00004097          	auipc	ra,0x4
     576:	f02080e7          	jalr	-254(ra) # 4474 <exit>
          exit(0);
     57a:	00004097          	auipc	ra,0x4
     57e:	efa080e7          	jalr	-262(ra) # 4474 <exit>
      printf("%s: fork in child failed", s);
     582:	85a6                	mv	a1,s1
     584:	00004517          	auipc	a0,0x4
     588:	62450513          	addi	a0,a0,1572 # 4ba8 <malloc+0x314>
     58c:	00004097          	auipc	ra,0x4
     590:	250080e7          	jalr	592(ra) # 47dc <printf>
      exit(1);
     594:	4505                	li	a0,1
     596:	00004097          	auipc	ra,0x4
     59a:	ede080e7          	jalr	-290(ra) # 4474 <exit>

000000000000059e <reparent2>:
{
     59e:	1101                	addi	sp,sp,-32
     5a0:	ec06                	sd	ra,24(sp)
     5a2:	e822                	sd	s0,16(sp)
     5a4:	e426                	sd	s1,8(sp)
     5a6:	1000                	addi	s0,sp,32
     5a8:	32000493          	li	s1,800
    int pid1 = fork();
     5ac:	00004097          	auipc	ra,0x4
     5b0:	ec0080e7          	jalr	-320(ra) # 446c <fork>
    if(pid1 < 0){
     5b4:	00054f63          	bltz	a0,5d2 <reparent2+0x34>
    if(pid1 == 0){
     5b8:	c915                	beqz	a0,5ec <reparent2+0x4e>
    wait(0);
     5ba:	4501                	li	a0,0
     5bc:	00004097          	auipc	ra,0x4
     5c0:	ec0080e7          	jalr	-320(ra) # 447c <wait>
  for(int i = 0; i < 800; i++){
     5c4:	34fd                	addiw	s1,s1,-1
     5c6:	f0fd                	bnez	s1,5ac <reparent2+0xe>
  exit(0);
     5c8:	4501                	li	a0,0
     5ca:	00004097          	auipc	ra,0x4
     5ce:	eaa080e7          	jalr	-342(ra) # 4474 <exit>
      printf("fork failed\n");
     5d2:	00005517          	auipc	a0,0x5
     5d6:	e7e50513          	addi	a0,a0,-386 # 5450 <malloc+0xbbc>
     5da:	00004097          	auipc	ra,0x4
     5de:	202080e7          	jalr	514(ra) # 47dc <printf>
      exit(1);
     5e2:	4505                	li	a0,1
     5e4:	00004097          	auipc	ra,0x4
     5e8:	e90080e7          	jalr	-368(ra) # 4474 <exit>
      fork();
     5ec:	00004097          	auipc	ra,0x4
     5f0:	e80080e7          	jalr	-384(ra) # 446c <fork>
      fork();
     5f4:	00004097          	auipc	ra,0x4
     5f8:	e78080e7          	jalr	-392(ra) # 446c <fork>
      exit(0);
     5fc:	4501                	li	a0,0
     5fe:	00004097          	auipc	ra,0x4
     602:	e76080e7          	jalr	-394(ra) # 4474 <exit>

0000000000000606 <forktest>:
{
     606:	7179                	addi	sp,sp,-48
     608:	f406                	sd	ra,40(sp)
     60a:	f022                	sd	s0,32(sp)
     60c:	ec26                	sd	s1,24(sp)
     60e:	e84a                	sd	s2,16(sp)
     610:	e44e                	sd	s3,8(sp)
     612:	1800                	addi	s0,sp,48
     614:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
     616:	4481                	li	s1,0
     618:	3e800913          	li	s2,1000
    pid = fork();
     61c:	00004097          	auipc	ra,0x4
     620:	e50080e7          	jalr	-432(ra) # 446c <fork>
    if(pid < 0)
     624:	08054263          	bltz	a0,6a8 <forktest+0xa2>
    if(pid == 0)
     628:	c115                	beqz	a0,64c <forktest+0x46>
  for(n=0; n<N; n++){
     62a:	2485                	addiw	s1,s1,1
     62c:	ff2498e3          	bne	s1,s2,61c <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
     630:	85ce                	mv	a1,s3
     632:	00004517          	auipc	a0,0x4
     636:	5de50513          	addi	a0,a0,1502 # 4c10 <malloc+0x37c>
     63a:	00004097          	auipc	ra,0x4
     63e:	1a2080e7          	jalr	418(ra) # 47dc <printf>
    exit(1);
     642:	4505                	li	a0,1
     644:	00004097          	auipc	ra,0x4
     648:	e30080e7          	jalr	-464(ra) # 4474 <exit>
      exit(0);
     64c:	00004097          	auipc	ra,0x4
     650:	e28080e7          	jalr	-472(ra) # 4474 <exit>
    printf("%s: no fork at all!\n", s);
     654:	85ce                	mv	a1,s3
     656:	00004517          	auipc	a0,0x4
     65a:	57250513          	addi	a0,a0,1394 # 4bc8 <malloc+0x334>
     65e:	00004097          	auipc	ra,0x4
     662:	17e080e7          	jalr	382(ra) # 47dc <printf>
    exit(1);
     666:	4505                	li	a0,1
     668:	00004097          	auipc	ra,0x4
     66c:	e0c080e7          	jalr	-500(ra) # 4474 <exit>
      printf("%s: wait stopped early\n", s);
     670:	85ce                	mv	a1,s3
     672:	00004517          	auipc	a0,0x4
     676:	56e50513          	addi	a0,a0,1390 # 4be0 <malloc+0x34c>
     67a:	00004097          	auipc	ra,0x4
     67e:	162080e7          	jalr	354(ra) # 47dc <printf>
      exit(1);
     682:	4505                	li	a0,1
     684:	00004097          	auipc	ra,0x4
     688:	df0080e7          	jalr	-528(ra) # 4474 <exit>
    printf("%s: wait got too many\n", s);
     68c:	85ce                	mv	a1,s3
     68e:	00004517          	auipc	a0,0x4
     692:	56a50513          	addi	a0,a0,1386 # 4bf8 <malloc+0x364>
     696:	00004097          	auipc	ra,0x4
     69a:	146080e7          	jalr	326(ra) # 47dc <printf>
    exit(1);
     69e:	4505                	li	a0,1
     6a0:	00004097          	auipc	ra,0x4
     6a4:	dd4080e7          	jalr	-556(ra) # 4474 <exit>
  if (n == 0) {
     6a8:	d4d5                	beqz	s1,654 <forktest+0x4e>
  for(; n > 0; n--){
     6aa:	00905b63          	blez	s1,6c0 <forktest+0xba>
    if(wait(0) < 0){
     6ae:	4501                	li	a0,0
     6b0:	00004097          	auipc	ra,0x4
     6b4:	dcc080e7          	jalr	-564(ra) # 447c <wait>
     6b8:	fa054ce3          	bltz	a0,670 <forktest+0x6a>
  for(; n > 0; n--){
     6bc:	34fd                	addiw	s1,s1,-1
     6be:	f8e5                	bnez	s1,6ae <forktest+0xa8>
  if(wait(0) != -1){
     6c0:	4501                	li	a0,0
     6c2:	00004097          	auipc	ra,0x4
     6c6:	dba080e7          	jalr	-582(ra) # 447c <wait>
     6ca:	57fd                	li	a5,-1
     6cc:	fcf510e3          	bne	a0,a5,68c <forktest+0x86>
}
     6d0:	70a2                	ld	ra,40(sp)
     6d2:	7402                	ld	s0,32(sp)
     6d4:	64e2                	ld	s1,24(sp)
     6d6:	6942                	ld	s2,16(sp)
     6d8:	69a2                	ld	s3,8(sp)
     6da:	6145                	addi	sp,sp,48
     6dc:	8082                	ret

00000000000006de <kernmem>:
{
     6de:	715d                	addi	sp,sp,-80
     6e0:	e486                	sd	ra,72(sp)
     6e2:	e0a2                	sd	s0,64(sp)
     6e4:	fc26                	sd	s1,56(sp)
     6e6:	f84a                	sd	s2,48(sp)
     6e8:	f44e                	sd	s3,40(sp)
     6ea:	f052                	sd	s4,32(sp)
     6ec:	ec56                	sd	s5,24(sp)
     6ee:	0880                	addi	s0,sp,80
     6f0:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     6f2:	4485                	li	s1,1
     6f4:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
     6f6:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     6f8:	69b1                	lui	s3,0xc
     6fa:	35098993          	addi	s3,s3,848 # c350 <buf+0x1c30>
     6fe:	1003d937          	lui	s2,0x1003d
     702:	090e                	slli	s2,s2,0x3
     704:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002fd60>
    pid = fork();
     708:	00004097          	auipc	ra,0x4
     70c:	d64080e7          	jalr	-668(ra) # 446c <fork>
    if(pid < 0){
     710:	02054963          	bltz	a0,742 <kernmem+0x64>
    if(pid == 0){
     714:	c529                	beqz	a0,75e <kernmem+0x80>
    wait(&xstatus);
     716:	fbc40513          	addi	a0,s0,-68
     71a:	00004097          	auipc	ra,0x4
     71e:	d62080e7          	jalr	-670(ra) # 447c <wait>
    if(xstatus != -1)  // did kernel kill child?
     722:	fbc42783          	lw	a5,-68(s0)
     726:	05479c63          	bne	a5,s4,77e <kernmem+0xa0>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     72a:	94ce                	add	s1,s1,s3
     72c:	fd249ee3          	bne	s1,s2,708 <kernmem+0x2a>
}
     730:	60a6                	ld	ra,72(sp)
     732:	6406                	ld	s0,64(sp)
     734:	74e2                	ld	s1,56(sp)
     736:	7942                	ld	s2,48(sp)
     738:	79a2                	ld	s3,40(sp)
     73a:	7a02                	ld	s4,32(sp)
     73c:	6ae2                	ld	s5,24(sp)
     73e:	6161                	addi	sp,sp,80
     740:	8082                	ret
      printf("%s: fork failed\n", s);
     742:	85d6                	mv	a1,s5
     744:	00004517          	auipc	a0,0x4
     748:	3ec50513          	addi	a0,a0,1004 # 4b30 <malloc+0x29c>
     74c:	00004097          	auipc	ra,0x4
     750:	090080e7          	jalr	144(ra) # 47dc <printf>
      exit(1);
     754:	4505                	li	a0,1
     756:	00004097          	auipc	ra,0x4
     75a:	d1e080e7          	jalr	-738(ra) # 4474 <exit>
      printf("%s: oops could read %x = %x\n", a, *a);
     75e:	0004c603          	lbu	a2,0(s1)
     762:	85a6                	mv	a1,s1
     764:	00004517          	auipc	a0,0x4
     768:	4d450513          	addi	a0,a0,1236 # 4c38 <malloc+0x3a4>
     76c:	00004097          	auipc	ra,0x4
     770:	070080e7          	jalr	112(ra) # 47dc <printf>
      exit(1);
     774:	4505                	li	a0,1
     776:	00004097          	auipc	ra,0x4
     77a:	cfe080e7          	jalr	-770(ra) # 4474 <exit>
      exit(1);
     77e:	4505                	li	a0,1
     780:	00004097          	auipc	ra,0x4
     784:	cf4080e7          	jalr	-780(ra) # 4474 <exit>

0000000000000788 <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
     788:	7179                	addi	sp,sp,-48
     78a:	f406                	sd	ra,40(sp)
     78c:	f022                	sd	s0,32(sp)
     78e:	ec26                	sd	s1,24(sp)
     790:	1800                	addi	s0,sp,48
     792:	84aa                	mv	s1,a0
  int pid;
  int xstatus;
  
  pid = fork();
     794:	00004097          	auipc	ra,0x4
     798:	cd8080e7          	jalr	-808(ra) # 446c <fork>
  if(pid == 0) {
     79c:	c115                	beqz	a0,7c0 <stacktest+0x38>
    char *sp = (char *) r_sp();
    sp -= PGSIZE;
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", *sp);
    exit(1);
  } else if(pid < 0){
     79e:	04054363          	bltz	a0,7e4 <stacktest+0x5c>
    printf("%s: fork failed\n", s);
    exit(1);
  }
  wait(&xstatus);
     7a2:	fdc40513          	addi	a0,s0,-36
     7a6:	00004097          	auipc	ra,0x4
     7aa:	cd6080e7          	jalr	-810(ra) # 447c <wait>
  if(xstatus == -1)  // kernel killed child?
     7ae:	fdc42503          	lw	a0,-36(s0)
     7b2:	57fd                	li	a5,-1
     7b4:	04f50663          	beq	a0,a5,800 <stacktest+0x78>
    exit(0);
  else
    exit(xstatus);
     7b8:	00004097          	auipc	ra,0x4
     7bc:	cbc080e7          	jalr	-836(ra) # 4474 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
     7c0:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", *sp);
     7c2:	77fd                	lui	a5,0xfffff
     7c4:	97ba                	add	a5,a5,a4
     7c6:	0007c583          	lbu	a1,0(a5) # fffffffffffff000 <base+0xffffffffffff18e0>
     7ca:	00004517          	auipc	a0,0x4
     7ce:	48e50513          	addi	a0,a0,1166 # 4c58 <malloc+0x3c4>
     7d2:	00004097          	auipc	ra,0x4
     7d6:	00a080e7          	jalr	10(ra) # 47dc <printf>
    exit(1);
     7da:	4505                	li	a0,1
     7dc:	00004097          	auipc	ra,0x4
     7e0:	c98080e7          	jalr	-872(ra) # 4474 <exit>
    printf("%s: fork failed\n", s);
     7e4:	85a6                	mv	a1,s1
     7e6:	00004517          	auipc	a0,0x4
     7ea:	34a50513          	addi	a0,a0,842 # 4b30 <malloc+0x29c>
     7ee:	00004097          	auipc	ra,0x4
     7f2:	fee080e7          	jalr	-18(ra) # 47dc <printf>
    exit(1);
     7f6:	4505                	li	a0,1
     7f8:	00004097          	auipc	ra,0x4
     7fc:	c7c080e7          	jalr	-900(ra) # 4474 <exit>
    exit(0);
     800:	4501                	li	a0,0
     802:	00004097          	auipc	ra,0x4
     806:	c72080e7          	jalr	-910(ra) # 4474 <exit>

000000000000080a <openiputtest>:
{
     80a:	7179                	addi	sp,sp,-48
     80c:	f406                	sd	ra,40(sp)
     80e:	f022                	sd	s0,32(sp)
     810:	ec26                	sd	s1,24(sp)
     812:	1800                	addi	s0,sp,48
     814:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
     816:	00004517          	auipc	a0,0x4
     81a:	46a50513          	addi	a0,a0,1130 # 4c80 <malloc+0x3ec>
     81e:	00004097          	auipc	ra,0x4
     822:	cbe080e7          	jalr	-834(ra) # 44dc <mkdir>
     826:	04054263          	bltz	a0,86a <openiputtest+0x60>
  pid = fork();
     82a:	00004097          	auipc	ra,0x4
     82e:	c42080e7          	jalr	-958(ra) # 446c <fork>
  if(pid < 0){
     832:	04054a63          	bltz	a0,886 <openiputtest+0x7c>
  if(pid == 0){
     836:	e93d                	bnez	a0,8ac <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
     838:	4589                	li	a1,2
     83a:	00004517          	auipc	a0,0x4
     83e:	44650513          	addi	a0,a0,1094 # 4c80 <malloc+0x3ec>
     842:	00004097          	auipc	ra,0x4
     846:	c72080e7          	jalr	-910(ra) # 44b4 <open>
    if(fd >= 0){
     84a:	04054c63          	bltz	a0,8a2 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
     84e:	85a6                	mv	a1,s1
     850:	00004517          	auipc	a0,0x4
     854:	45050513          	addi	a0,a0,1104 # 4ca0 <malloc+0x40c>
     858:	00004097          	auipc	ra,0x4
     85c:	f84080e7          	jalr	-124(ra) # 47dc <printf>
      exit(1);
     860:	4505                	li	a0,1
     862:	00004097          	auipc	ra,0x4
     866:	c12080e7          	jalr	-1006(ra) # 4474 <exit>
    printf("%s: mkdir oidir failed\n", s);
     86a:	85a6                	mv	a1,s1
     86c:	00004517          	auipc	a0,0x4
     870:	41c50513          	addi	a0,a0,1052 # 4c88 <malloc+0x3f4>
     874:	00004097          	auipc	ra,0x4
     878:	f68080e7          	jalr	-152(ra) # 47dc <printf>
    exit(1);
     87c:	4505                	li	a0,1
     87e:	00004097          	auipc	ra,0x4
     882:	bf6080e7          	jalr	-1034(ra) # 4474 <exit>
    printf("%s: fork failed\n", s);
     886:	85a6                	mv	a1,s1
     888:	00004517          	auipc	a0,0x4
     88c:	2a850513          	addi	a0,a0,680 # 4b30 <malloc+0x29c>
     890:	00004097          	auipc	ra,0x4
     894:	f4c080e7          	jalr	-180(ra) # 47dc <printf>
    exit(1);
     898:	4505                	li	a0,1
     89a:	00004097          	auipc	ra,0x4
     89e:	bda080e7          	jalr	-1062(ra) # 4474 <exit>
    exit(0);
     8a2:	4501                	li	a0,0
     8a4:	00004097          	auipc	ra,0x4
     8a8:	bd0080e7          	jalr	-1072(ra) # 4474 <exit>
  sleep(1);
     8ac:	4505                	li	a0,1
     8ae:	00004097          	auipc	ra,0x4
     8b2:	c56080e7          	jalr	-938(ra) # 4504 <sleep>
  if(unlink("oidir") != 0){
     8b6:	00004517          	auipc	a0,0x4
     8ba:	3ca50513          	addi	a0,a0,970 # 4c80 <malloc+0x3ec>
     8be:	00004097          	auipc	ra,0x4
     8c2:	c06080e7          	jalr	-1018(ra) # 44c4 <unlink>
     8c6:	cd19                	beqz	a0,8e4 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
     8c8:	85a6                	mv	a1,s1
     8ca:	00004517          	auipc	a0,0x4
     8ce:	3fe50513          	addi	a0,a0,1022 # 4cc8 <malloc+0x434>
     8d2:	00004097          	auipc	ra,0x4
     8d6:	f0a080e7          	jalr	-246(ra) # 47dc <printf>
    exit(1);
     8da:	4505                	li	a0,1
     8dc:	00004097          	auipc	ra,0x4
     8e0:	b98080e7          	jalr	-1128(ra) # 4474 <exit>
  wait(&xstatus);
     8e4:	fdc40513          	addi	a0,s0,-36
     8e8:	00004097          	auipc	ra,0x4
     8ec:	b94080e7          	jalr	-1132(ra) # 447c <wait>
  exit(xstatus);
     8f0:	fdc42503          	lw	a0,-36(s0)
     8f4:	00004097          	auipc	ra,0x4
     8f8:	b80080e7          	jalr	-1152(ra) # 4474 <exit>

00000000000008fc <opentest>:
{
     8fc:	1101                	addi	sp,sp,-32
     8fe:	ec06                	sd	ra,24(sp)
     900:	e822                	sd	s0,16(sp)
     902:	e426                	sd	s1,8(sp)
     904:	1000                	addi	s0,sp,32
     906:	84aa                	mv	s1,a0
  fd = open("echo", 0);
     908:	4581                	li	a1,0
     90a:	00004517          	auipc	a0,0x4
     90e:	3d650513          	addi	a0,a0,982 # 4ce0 <malloc+0x44c>
     912:	00004097          	auipc	ra,0x4
     916:	ba2080e7          	jalr	-1118(ra) # 44b4 <open>
  if(fd < 0){
     91a:	02054663          	bltz	a0,946 <opentest+0x4a>
  close(fd);
     91e:	00004097          	auipc	ra,0x4
     922:	b7e080e7          	jalr	-1154(ra) # 449c <close>
  fd = open("doesnotexist", 0);
     926:	4581                	li	a1,0
     928:	00004517          	auipc	a0,0x4
     92c:	3d850513          	addi	a0,a0,984 # 4d00 <malloc+0x46c>
     930:	00004097          	auipc	ra,0x4
     934:	b84080e7          	jalr	-1148(ra) # 44b4 <open>
  if(fd >= 0){
     938:	02055563          	bgez	a0,962 <opentest+0x66>
}
     93c:	60e2                	ld	ra,24(sp)
     93e:	6442                	ld	s0,16(sp)
     940:	64a2                	ld	s1,8(sp)
     942:	6105                	addi	sp,sp,32
     944:	8082                	ret
    printf("%s: open echo failed!\n", s);
     946:	85a6                	mv	a1,s1
     948:	00004517          	auipc	a0,0x4
     94c:	3a050513          	addi	a0,a0,928 # 4ce8 <malloc+0x454>
     950:	00004097          	auipc	ra,0x4
     954:	e8c080e7          	jalr	-372(ra) # 47dc <printf>
    exit(1);
     958:	4505                	li	a0,1
     95a:	00004097          	auipc	ra,0x4
     95e:	b1a080e7          	jalr	-1254(ra) # 4474 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     962:	85a6                	mv	a1,s1
     964:	00004517          	auipc	a0,0x4
     968:	3ac50513          	addi	a0,a0,940 # 4d10 <malloc+0x47c>
     96c:	00004097          	auipc	ra,0x4
     970:	e70080e7          	jalr	-400(ra) # 47dc <printf>
    exit(1);
     974:	4505                	li	a0,1
     976:	00004097          	auipc	ra,0x4
     97a:	afe080e7          	jalr	-1282(ra) # 4474 <exit>

000000000000097e <createtest>:
{
     97e:	7179                	addi	sp,sp,-48
     980:	f406                	sd	ra,40(sp)
     982:	f022                	sd	s0,32(sp)
     984:	ec26                	sd	s1,24(sp)
     986:	e84a                	sd	s2,16(sp)
     988:	e44e                	sd	s3,8(sp)
     98a:	1800                	addi	s0,sp,48
  name[0] = 'a';
     98c:	00007797          	auipc	a5,0x7
     990:	57478793          	addi	a5,a5,1396 # 7f00 <name>
     994:	06100713          	li	a4,97
     998:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     99c:	00078123          	sb	zero,2(a5)
     9a0:	03000493          	li	s1,48
    name[1] = '0' + i;
     9a4:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     9a6:	06400993          	li	s3,100
    name[1] = '0' + i;
     9aa:	009900a3          	sb	s1,1(s2)
    fd = open(name, O_CREATE|O_RDWR);
     9ae:	20200593          	li	a1,514
     9b2:	854a                	mv	a0,s2
     9b4:	00004097          	auipc	ra,0x4
     9b8:	b00080e7          	jalr	-1280(ra) # 44b4 <open>
    close(fd);
     9bc:	00004097          	auipc	ra,0x4
     9c0:	ae0080e7          	jalr	-1312(ra) # 449c <close>
  for(i = 0; i < N; i++){
     9c4:	2485                	addiw	s1,s1,1
     9c6:	0ff4f493          	zext.b	s1,s1
     9ca:	ff3490e3          	bne	s1,s3,9aa <createtest+0x2c>
  name[0] = 'a';
     9ce:	00007797          	auipc	a5,0x7
     9d2:	53278793          	addi	a5,a5,1330 # 7f00 <name>
     9d6:	06100713          	li	a4,97
     9da:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     9de:	00078123          	sb	zero,2(a5)
     9e2:	03000493          	li	s1,48
    name[1] = '0' + i;
     9e6:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     9e8:	06400993          	li	s3,100
    name[1] = '0' + i;
     9ec:	009900a3          	sb	s1,1(s2)
    unlink(name);
     9f0:	854a                	mv	a0,s2
     9f2:	00004097          	auipc	ra,0x4
     9f6:	ad2080e7          	jalr	-1326(ra) # 44c4 <unlink>
  for(i = 0; i < N; i++){
     9fa:	2485                	addiw	s1,s1,1
     9fc:	0ff4f493          	zext.b	s1,s1
     a00:	ff3496e3          	bne	s1,s3,9ec <createtest+0x6e>
}
     a04:	70a2                	ld	ra,40(sp)
     a06:	7402                	ld	s0,32(sp)
     a08:	64e2                	ld	s1,24(sp)
     a0a:	6942                	ld	s2,16(sp)
     a0c:	69a2                	ld	s3,8(sp)
     a0e:	6145                	addi	sp,sp,48
     a10:	8082                	ret

0000000000000a12 <forkforkfork>:
{
     a12:	1101                	addi	sp,sp,-32
     a14:	ec06                	sd	ra,24(sp)
     a16:	e822                	sd	s0,16(sp)
     a18:	e426                	sd	s1,8(sp)
     a1a:	1000                	addi	s0,sp,32
     a1c:	84aa                	mv	s1,a0
  unlink("stopforking");
     a1e:	00004517          	auipc	a0,0x4
     a22:	31a50513          	addi	a0,a0,794 # 4d38 <malloc+0x4a4>
     a26:	00004097          	auipc	ra,0x4
     a2a:	a9e080e7          	jalr	-1378(ra) # 44c4 <unlink>
  int pid = fork();
     a2e:	00004097          	auipc	ra,0x4
     a32:	a3e080e7          	jalr	-1474(ra) # 446c <fork>
  if(pid < 0){
     a36:	04054563          	bltz	a0,a80 <forkforkfork+0x6e>
  if(pid == 0){
     a3a:	c12d                	beqz	a0,a9c <forkforkfork+0x8a>
  sleep(20); // two seconds
     a3c:	4551                	li	a0,20
     a3e:	00004097          	auipc	ra,0x4
     a42:	ac6080e7          	jalr	-1338(ra) # 4504 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
     a46:	20200593          	li	a1,514
     a4a:	00004517          	auipc	a0,0x4
     a4e:	2ee50513          	addi	a0,a0,750 # 4d38 <malloc+0x4a4>
     a52:	00004097          	auipc	ra,0x4
     a56:	a62080e7          	jalr	-1438(ra) # 44b4 <open>
     a5a:	00004097          	auipc	ra,0x4
     a5e:	a42080e7          	jalr	-1470(ra) # 449c <close>
  wait(0);
     a62:	4501                	li	a0,0
     a64:	00004097          	auipc	ra,0x4
     a68:	a18080e7          	jalr	-1512(ra) # 447c <wait>
  sleep(10); // one second
     a6c:	4529                	li	a0,10
     a6e:	00004097          	auipc	ra,0x4
     a72:	a96080e7          	jalr	-1386(ra) # 4504 <sleep>
}
     a76:	60e2                	ld	ra,24(sp)
     a78:	6442                	ld	s0,16(sp)
     a7a:	64a2                	ld	s1,8(sp)
     a7c:	6105                	addi	sp,sp,32
     a7e:	8082                	ret
    printf("%s: fork failed", s);
     a80:	85a6                	mv	a1,s1
     a82:	00004517          	auipc	a0,0x4
     a86:	11650513          	addi	a0,a0,278 # 4b98 <malloc+0x304>
     a8a:	00004097          	auipc	ra,0x4
     a8e:	d52080e7          	jalr	-686(ra) # 47dc <printf>
    exit(1);
     a92:	4505                	li	a0,1
     a94:	00004097          	auipc	ra,0x4
     a98:	9e0080e7          	jalr	-1568(ra) # 4474 <exit>
      int fd = open("stopforking", 0);
     a9c:	00004497          	auipc	s1,0x4
     aa0:	29c48493          	addi	s1,s1,668 # 4d38 <malloc+0x4a4>
     aa4:	4581                	li	a1,0
     aa6:	8526                	mv	a0,s1
     aa8:	00004097          	auipc	ra,0x4
     aac:	a0c080e7          	jalr	-1524(ra) # 44b4 <open>
      if(fd >= 0){
     ab0:	02055763          	bgez	a0,ade <forkforkfork+0xcc>
      if(fork() < 0){
     ab4:	00004097          	auipc	ra,0x4
     ab8:	9b8080e7          	jalr	-1608(ra) # 446c <fork>
     abc:	fe0554e3          	bgez	a0,aa4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
     ac0:	20200593          	li	a1,514
     ac4:	00004517          	auipc	a0,0x4
     ac8:	27450513          	addi	a0,a0,628 # 4d38 <malloc+0x4a4>
     acc:	00004097          	auipc	ra,0x4
     ad0:	9e8080e7          	jalr	-1560(ra) # 44b4 <open>
     ad4:	00004097          	auipc	ra,0x4
     ad8:	9c8080e7          	jalr	-1592(ra) # 449c <close>
     adc:	b7e1                	j	aa4 <forkforkfork+0x92>
        exit(0);
     ade:	4501                	li	a0,0
     ae0:	00004097          	auipc	ra,0x4
     ae4:	994080e7          	jalr	-1644(ra) # 4474 <exit>

0000000000000ae8 <createdelete>:
{
     ae8:	7175                	addi	sp,sp,-144
     aea:	e506                	sd	ra,136(sp)
     aec:	e122                	sd	s0,128(sp)
     aee:	fca6                	sd	s1,120(sp)
     af0:	f8ca                	sd	s2,112(sp)
     af2:	f4ce                	sd	s3,104(sp)
     af4:	f0d2                	sd	s4,96(sp)
     af6:	ecd6                	sd	s5,88(sp)
     af8:	e8da                	sd	s6,80(sp)
     afa:	e4de                	sd	s7,72(sp)
     afc:	e0e2                	sd	s8,64(sp)
     afe:	fc66                	sd	s9,56(sp)
     b00:	0900                	addi	s0,sp,144
     b02:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
     b04:	4901                	li	s2,0
     b06:	4991                	li	s3,4
    pid = fork();
     b08:	00004097          	auipc	ra,0x4
     b0c:	964080e7          	jalr	-1692(ra) # 446c <fork>
     b10:	84aa                	mv	s1,a0
    if(pid < 0){
     b12:	02054f63          	bltz	a0,b50 <createdelete+0x68>
    if(pid == 0){
     b16:	c939                	beqz	a0,b6c <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
     b18:	2905                	addiw	s2,s2,1
     b1a:	ff3917e3          	bne	s2,s3,b08 <createdelete+0x20>
     b1e:	4491                	li	s1,4
    wait(&xstatus);
     b20:	f7c40513          	addi	a0,s0,-132
     b24:	00004097          	auipc	ra,0x4
     b28:	958080e7          	jalr	-1704(ra) # 447c <wait>
    if(xstatus != 0)
     b2c:	f7c42903          	lw	s2,-132(s0)
     b30:	0e091263          	bnez	s2,c14 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
     b34:	34fd                	addiw	s1,s1,-1
     b36:	f4ed                	bnez	s1,b20 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
     b38:	f8040123          	sb	zero,-126(s0)
     b3c:	03000993          	li	s3,48
     b40:	5a7d                	li	s4,-1
     b42:	07000c13          	li	s8,112
      if((i == 0 || i >= N/2) && fd < 0){
     b46:	4b25                	li	s6,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
     b48:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
     b4a:	07400a93          	li	s5,116
     b4e:	a28d                	j	cb0 <createdelete+0x1c8>
      printf("fork failed\n", s);
     b50:	85e6                	mv	a1,s9
     b52:	00005517          	auipc	a0,0x5
     b56:	8fe50513          	addi	a0,a0,-1794 # 5450 <malloc+0xbbc>
     b5a:	00004097          	auipc	ra,0x4
     b5e:	c82080e7          	jalr	-894(ra) # 47dc <printf>
      exit(1);
     b62:	4505                	li	a0,1
     b64:	00004097          	auipc	ra,0x4
     b68:	910080e7          	jalr	-1776(ra) # 4474 <exit>
      name[0] = 'p' + pi;
     b6c:	0709091b          	addiw	s2,s2,112
     b70:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
     b74:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
     b78:	4951                	li	s2,20
     b7a:	a015                	j	b9e <createdelete+0xb6>
          printf("%s: create failed\n", s);
     b7c:	85e6                	mv	a1,s9
     b7e:	00004517          	auipc	a0,0x4
     b82:	1ca50513          	addi	a0,a0,458 # 4d48 <malloc+0x4b4>
     b86:	00004097          	auipc	ra,0x4
     b8a:	c56080e7          	jalr	-938(ra) # 47dc <printf>
          exit(1);
     b8e:	4505                	li	a0,1
     b90:	00004097          	auipc	ra,0x4
     b94:	8e4080e7          	jalr	-1820(ra) # 4474 <exit>
      for(i = 0; i < N; i++){
     b98:	2485                	addiw	s1,s1,1
     b9a:	07248863          	beq	s1,s2,c0a <createdelete+0x122>
        name[1] = '0' + i;
     b9e:	0304879b          	addiw	a5,s1,48
     ba2:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
     ba6:	20200593          	li	a1,514
     baa:	f8040513          	addi	a0,s0,-128
     bae:	00004097          	auipc	ra,0x4
     bb2:	906080e7          	jalr	-1786(ra) # 44b4 <open>
        if(fd < 0){
     bb6:	fc0543e3          	bltz	a0,b7c <createdelete+0x94>
        close(fd);
     bba:	00004097          	auipc	ra,0x4
     bbe:	8e2080e7          	jalr	-1822(ra) # 449c <close>
        if(i > 0 && (i % 2 ) == 0){
     bc2:	12905763          	blez	s1,cf0 <createdelete+0x208>
     bc6:	0014f793          	andi	a5,s1,1
     bca:	f7f9                	bnez	a5,b98 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
     bcc:	01f4d79b          	srliw	a5,s1,0x1f
     bd0:	9fa5                	addw	a5,a5,s1
     bd2:	4017d79b          	sraiw	a5,a5,0x1
     bd6:	0307879b          	addiw	a5,a5,48
     bda:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
     bde:	f8040513          	addi	a0,s0,-128
     be2:	00004097          	auipc	ra,0x4
     be6:	8e2080e7          	jalr	-1822(ra) # 44c4 <unlink>
     bea:	fa0557e3          	bgez	a0,b98 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
     bee:	85e6                	mv	a1,s9
     bf0:	00004517          	auipc	a0,0x4
     bf4:	0d850513          	addi	a0,a0,216 # 4cc8 <malloc+0x434>
     bf8:	00004097          	auipc	ra,0x4
     bfc:	be4080e7          	jalr	-1052(ra) # 47dc <printf>
            exit(1);
     c00:	4505                	li	a0,1
     c02:	00004097          	auipc	ra,0x4
     c06:	872080e7          	jalr	-1934(ra) # 4474 <exit>
      exit(0);
     c0a:	4501                	li	a0,0
     c0c:	00004097          	auipc	ra,0x4
     c10:	868080e7          	jalr	-1944(ra) # 4474 <exit>
      exit(1);
     c14:	4505                	li	a0,1
     c16:	00004097          	auipc	ra,0x4
     c1a:	85e080e7          	jalr	-1954(ra) # 4474 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
     c1e:	f8040613          	addi	a2,s0,-128
     c22:	85e6                	mv	a1,s9
     c24:	00004517          	auipc	a0,0x4
     c28:	13c50513          	addi	a0,a0,316 # 4d60 <malloc+0x4cc>
     c2c:	00004097          	auipc	ra,0x4
     c30:	bb0080e7          	jalr	-1104(ra) # 47dc <printf>
        exit(1);
     c34:	4505                	li	a0,1
     c36:	00004097          	auipc	ra,0x4
     c3a:	83e080e7          	jalr	-1986(ra) # 4474 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c3e:	034bff63          	bgeu	s7,s4,c7c <createdelete+0x194>
      if(fd >= 0)
     c42:	02055863          	bgez	a0,c72 <createdelete+0x18a>
    for(pi = 0; pi < NCHILD; pi++){
     c46:	2485                	addiw	s1,s1,1
     c48:	0ff4f493          	zext.b	s1,s1
     c4c:	05548a63          	beq	s1,s5,ca0 <createdelete+0x1b8>
      name[0] = 'p' + pi;
     c50:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
     c54:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
     c58:	4581                	li	a1,0
     c5a:	f8040513          	addi	a0,s0,-128
     c5e:	00004097          	auipc	ra,0x4
     c62:	856080e7          	jalr	-1962(ra) # 44b4 <open>
      if((i == 0 || i >= N/2) && fd < 0){
     c66:	00090463          	beqz	s2,c6e <createdelete+0x186>
     c6a:	fd2b5ae3          	bge	s6,s2,c3e <createdelete+0x156>
     c6e:	fa0548e3          	bltz	a0,c1e <createdelete+0x136>
        close(fd);
     c72:	00004097          	auipc	ra,0x4
     c76:	82a080e7          	jalr	-2006(ra) # 449c <close>
     c7a:	b7f1                	j	c46 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c7c:	fc0545e3          	bltz	a0,c46 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
     c80:	f8040613          	addi	a2,s0,-128
     c84:	85e6                	mv	a1,s9
     c86:	00004517          	auipc	a0,0x4
     c8a:	10250513          	addi	a0,a0,258 # 4d88 <malloc+0x4f4>
     c8e:	00004097          	auipc	ra,0x4
     c92:	b4e080e7          	jalr	-1202(ra) # 47dc <printf>
        exit(1);
     c96:	4505                	li	a0,1
     c98:	00003097          	auipc	ra,0x3
     c9c:	7dc080e7          	jalr	2012(ra) # 4474 <exit>
  for(i = 0; i < N; i++){
     ca0:	2905                	addiw	s2,s2,1
     ca2:	2a05                	addiw	s4,s4,1
     ca4:	2985                	addiw	s3,s3,1
     ca6:	0ff9f993          	zext.b	s3,s3
     caa:	47d1                	li	a5,20
     cac:	02f90a63          	beq	s2,a5,ce0 <createdelete+0x1f8>
    for(pi = 0; pi < NCHILD; pi++){
     cb0:	84e2                	mv	s1,s8
     cb2:	bf79                	j	c50 <createdelete+0x168>
  for(i = 0; i < N; i++){
     cb4:	2905                	addiw	s2,s2,1
     cb6:	0ff97913          	zext.b	s2,s2
     cba:	2985                	addiw	s3,s3,1
     cbc:	0ff9f993          	zext.b	s3,s3
     cc0:	03490a63          	beq	s2,s4,cf4 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
     cc4:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
     cc6:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
     cca:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
     cce:	f8040513          	addi	a0,s0,-128
     cd2:	00003097          	auipc	ra,0x3
     cd6:	7f2080e7          	jalr	2034(ra) # 44c4 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
     cda:	34fd                	addiw	s1,s1,-1
     cdc:	f4ed                	bnez	s1,cc6 <createdelete+0x1de>
     cde:	bfd9                	j	cb4 <createdelete+0x1cc>
     ce0:	03000993          	li	s3,48
     ce4:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
     ce8:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
     cea:	08400a13          	li	s4,132
     cee:	bfd9                	j	cc4 <createdelete+0x1dc>
      for(i = 0; i < N; i++){
     cf0:	2485                	addiw	s1,s1,1
     cf2:	b575                	j	b9e <createdelete+0xb6>
}
     cf4:	60aa                	ld	ra,136(sp)
     cf6:	640a                	ld	s0,128(sp)
     cf8:	74e6                	ld	s1,120(sp)
     cfa:	7946                	ld	s2,112(sp)
     cfc:	79a6                	ld	s3,104(sp)
     cfe:	7a06                	ld	s4,96(sp)
     d00:	6ae6                	ld	s5,88(sp)
     d02:	6b46                	ld	s6,80(sp)
     d04:	6ba6                	ld	s7,72(sp)
     d06:	6c06                	ld	s8,64(sp)
     d08:	7ce2                	ld	s9,56(sp)
     d0a:	6149                	addi	sp,sp,144
     d0c:	8082                	ret

0000000000000d0e <fourteen>:
{
     d0e:	1101                	addi	sp,sp,-32
     d10:	ec06                	sd	ra,24(sp)
     d12:	e822                	sd	s0,16(sp)
     d14:	e426                	sd	s1,8(sp)
     d16:	1000                	addi	s0,sp,32
     d18:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
     d1a:	00004517          	auipc	a0,0x4
     d1e:	26650513          	addi	a0,a0,614 # 4f80 <malloc+0x6ec>
     d22:	00003097          	auipc	ra,0x3
     d26:	7ba080e7          	jalr	1978(ra) # 44dc <mkdir>
     d2a:	e141                	bnez	a0,daa <fourteen+0x9c>
  if(mkdir("12345678901234/123456789012345") != 0){
     d2c:	00004517          	auipc	a0,0x4
     d30:	0ac50513          	addi	a0,a0,172 # 4dd8 <malloc+0x544>
     d34:	00003097          	auipc	ra,0x3
     d38:	7a8080e7          	jalr	1960(ra) # 44dc <mkdir>
     d3c:	e549                	bnez	a0,dc6 <fourteen+0xb8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     d3e:	20000593          	li	a1,512
     d42:	00004517          	auipc	a0,0x4
     d46:	0ee50513          	addi	a0,a0,238 # 4e30 <malloc+0x59c>
     d4a:	00003097          	auipc	ra,0x3
     d4e:	76a080e7          	jalr	1898(ra) # 44b4 <open>
  if(fd < 0){
     d52:	08054863          	bltz	a0,de2 <fourteen+0xd4>
  close(fd);
     d56:	00003097          	auipc	ra,0x3
     d5a:	746080e7          	jalr	1862(ra) # 449c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     d5e:	4581                	li	a1,0
     d60:	00004517          	auipc	a0,0x4
     d64:	14850513          	addi	a0,a0,328 # 4ea8 <malloc+0x614>
     d68:	00003097          	auipc	ra,0x3
     d6c:	74c080e7          	jalr	1868(ra) # 44b4 <open>
  if(fd < 0){
     d70:	08054763          	bltz	a0,dfe <fourteen+0xf0>
  close(fd);
     d74:	00003097          	auipc	ra,0x3
     d78:	728080e7          	jalr	1832(ra) # 449c <close>
  if(mkdir("12345678901234/12345678901234") == 0){
     d7c:	00004517          	auipc	a0,0x4
     d80:	19c50513          	addi	a0,a0,412 # 4f18 <malloc+0x684>
     d84:	00003097          	auipc	ra,0x3
     d88:	758080e7          	jalr	1880(ra) # 44dc <mkdir>
     d8c:	c559                	beqz	a0,e1a <fourteen+0x10c>
  if(mkdir("123456789012345/12345678901234") == 0){
     d8e:	00004517          	auipc	a0,0x4
     d92:	1e250513          	addi	a0,a0,482 # 4f70 <malloc+0x6dc>
     d96:	00003097          	auipc	ra,0x3
     d9a:	746080e7          	jalr	1862(ra) # 44dc <mkdir>
     d9e:	cd41                	beqz	a0,e36 <fourteen+0x128>
}
     da0:	60e2                	ld	ra,24(sp)
     da2:	6442                	ld	s0,16(sp)
     da4:	64a2                	ld	s1,8(sp)
     da6:	6105                	addi	sp,sp,32
     da8:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
     daa:	85a6                	mv	a1,s1
     dac:	00004517          	auipc	a0,0x4
     db0:	00450513          	addi	a0,a0,4 # 4db0 <malloc+0x51c>
     db4:	00004097          	auipc	ra,0x4
     db8:	a28080e7          	jalr	-1496(ra) # 47dc <printf>
    exit(1);
     dbc:	4505                	li	a0,1
     dbe:	00003097          	auipc	ra,0x3
     dc2:	6b6080e7          	jalr	1718(ra) # 4474 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
     dc6:	85a6                	mv	a1,s1
     dc8:	00004517          	auipc	a0,0x4
     dcc:	03050513          	addi	a0,a0,48 # 4df8 <malloc+0x564>
     dd0:	00004097          	auipc	ra,0x4
     dd4:	a0c080e7          	jalr	-1524(ra) # 47dc <printf>
    exit(1);
     dd8:	4505                	li	a0,1
     dda:	00003097          	auipc	ra,0x3
     dde:	69a080e7          	jalr	1690(ra) # 4474 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
     de2:	85a6                	mv	a1,s1
     de4:	00004517          	auipc	a0,0x4
     de8:	07c50513          	addi	a0,a0,124 # 4e60 <malloc+0x5cc>
     dec:	00004097          	auipc	ra,0x4
     df0:	9f0080e7          	jalr	-1552(ra) # 47dc <printf>
    exit(1);
     df4:	4505                	li	a0,1
     df6:	00003097          	auipc	ra,0x3
     dfa:	67e080e7          	jalr	1662(ra) # 4474 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
     dfe:	85a6                	mv	a1,s1
     e00:	00004517          	auipc	a0,0x4
     e04:	0d850513          	addi	a0,a0,216 # 4ed8 <malloc+0x644>
     e08:	00004097          	auipc	ra,0x4
     e0c:	9d4080e7          	jalr	-1580(ra) # 47dc <printf>
    exit(1);
     e10:	4505                	li	a0,1
     e12:	00003097          	auipc	ra,0x3
     e16:	662080e7          	jalr	1634(ra) # 4474 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
     e1a:	85a6                	mv	a1,s1
     e1c:	00004517          	auipc	a0,0x4
     e20:	11c50513          	addi	a0,a0,284 # 4f38 <malloc+0x6a4>
     e24:	00004097          	auipc	ra,0x4
     e28:	9b8080e7          	jalr	-1608(ra) # 47dc <printf>
    exit(1);
     e2c:	4505                	li	a0,1
     e2e:	00003097          	auipc	ra,0x3
     e32:	646080e7          	jalr	1606(ra) # 4474 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
     e36:	85a6                	mv	a1,s1
     e38:	00004517          	auipc	a0,0x4
     e3c:	15850513          	addi	a0,a0,344 # 4f90 <malloc+0x6fc>
     e40:	00004097          	auipc	ra,0x4
     e44:	99c080e7          	jalr	-1636(ra) # 47dc <printf>
    exit(1);
     e48:	4505                	li	a0,1
     e4a:	00003097          	auipc	ra,0x3
     e4e:	62a080e7          	jalr	1578(ra) # 4474 <exit>

0000000000000e52 <bigwrite>:
{
     e52:	715d                	addi	sp,sp,-80
     e54:	e486                	sd	ra,72(sp)
     e56:	e0a2                	sd	s0,64(sp)
     e58:	fc26                	sd	s1,56(sp)
     e5a:	f84a                	sd	s2,48(sp)
     e5c:	f44e                	sd	s3,40(sp)
     e5e:	f052                	sd	s4,32(sp)
     e60:	ec56                	sd	s5,24(sp)
     e62:	e85a                	sd	s6,16(sp)
     e64:	e45e                	sd	s7,8(sp)
     e66:	0880                	addi	s0,sp,80
     e68:	8baa                	mv	s7,a0
  unlink("bigwrite");
     e6a:	00004517          	auipc	a0,0x4
     e6e:	15e50513          	addi	a0,a0,350 # 4fc8 <malloc+0x734>
     e72:	00003097          	auipc	ra,0x3
     e76:	652080e7          	jalr	1618(ra) # 44c4 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     e7a:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     e7e:	00004a97          	auipc	s5,0x4
     e82:	14aa8a93          	addi	s5,s5,330 # 4fc8 <malloc+0x734>
      int cc = write(fd, buf, sz);
     e86:	0000aa17          	auipc	s4,0xa
     e8a:	89aa0a13          	addi	s4,s4,-1894 # a720 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     e8e:	6b0d                	lui	s6,0x3
     e90:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirfile+0x9>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     e94:	20200593          	li	a1,514
     e98:	8556                	mv	a0,s5
     e9a:	00003097          	auipc	ra,0x3
     e9e:	61a080e7          	jalr	1562(ra) # 44b4 <open>
     ea2:	892a                	mv	s2,a0
    if(fd < 0){
     ea4:	04054d63          	bltz	a0,efe <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     ea8:	8626                	mv	a2,s1
     eaa:	85d2                	mv	a1,s4
     eac:	00003097          	auipc	ra,0x3
     eb0:	5e8080e7          	jalr	1512(ra) # 4494 <write>
     eb4:	89aa                	mv	s3,a0
      if(cc != sz){
     eb6:	06a49263          	bne	s1,a0,f1a <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     eba:	8626                	mv	a2,s1
     ebc:	85d2                	mv	a1,s4
     ebe:	854a                	mv	a0,s2
     ec0:	00003097          	auipc	ra,0x3
     ec4:	5d4080e7          	jalr	1492(ra) # 4494 <write>
      if(cc != sz){
     ec8:	04951a63          	bne	a0,s1,f1c <bigwrite+0xca>
    close(fd);
     ecc:	854a                	mv	a0,s2
     ece:	00003097          	auipc	ra,0x3
     ed2:	5ce080e7          	jalr	1486(ra) # 449c <close>
    unlink("bigwrite");
     ed6:	8556                	mv	a0,s5
     ed8:	00003097          	auipc	ra,0x3
     edc:	5ec080e7          	jalr	1516(ra) # 44c4 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     ee0:	1d74849b          	addiw	s1,s1,471
     ee4:	fb6498e3          	bne	s1,s6,e94 <bigwrite+0x42>
}
     ee8:	60a6                	ld	ra,72(sp)
     eea:	6406                	ld	s0,64(sp)
     eec:	74e2                	ld	s1,56(sp)
     eee:	7942                	ld	s2,48(sp)
     ef0:	79a2                	ld	s3,40(sp)
     ef2:	7a02                	ld	s4,32(sp)
     ef4:	6ae2                	ld	s5,24(sp)
     ef6:	6b42                	ld	s6,16(sp)
     ef8:	6ba2                	ld	s7,8(sp)
     efa:	6161                	addi	sp,sp,80
     efc:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     efe:	85de                	mv	a1,s7
     f00:	00004517          	auipc	a0,0x4
     f04:	0d850513          	addi	a0,a0,216 # 4fd8 <malloc+0x744>
     f08:	00004097          	auipc	ra,0x4
     f0c:	8d4080e7          	jalr	-1836(ra) # 47dc <printf>
      exit(1);
     f10:	4505                	li	a0,1
     f12:	00003097          	auipc	ra,0x3
     f16:	562080e7          	jalr	1378(ra) # 4474 <exit>
      if(cc != sz){
     f1a:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     f1c:	86aa                	mv	a3,a0
     f1e:	864e                	mv	a2,s3
     f20:	85de                	mv	a1,s7
     f22:	00004517          	auipc	a0,0x4
     f26:	0d650513          	addi	a0,a0,214 # 4ff8 <malloc+0x764>
     f2a:	00004097          	auipc	ra,0x4
     f2e:	8b2080e7          	jalr	-1870(ra) # 47dc <printf>
        exit(1);
     f32:	4505                	li	a0,1
     f34:	00003097          	auipc	ra,0x3
     f38:	540080e7          	jalr	1344(ra) # 4474 <exit>

0000000000000f3c <writetest>:
{
     f3c:	7139                	addi	sp,sp,-64
     f3e:	fc06                	sd	ra,56(sp)
     f40:	f822                	sd	s0,48(sp)
     f42:	f426                	sd	s1,40(sp)
     f44:	f04a                	sd	s2,32(sp)
     f46:	ec4e                	sd	s3,24(sp)
     f48:	e852                	sd	s4,16(sp)
     f4a:	e456                	sd	s5,8(sp)
     f4c:	e05a                	sd	s6,0(sp)
     f4e:	0080                	addi	s0,sp,64
     f50:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     f52:	20200593          	li	a1,514
     f56:	00004517          	auipc	a0,0x4
     f5a:	0ba50513          	addi	a0,a0,186 # 5010 <malloc+0x77c>
     f5e:	00003097          	auipc	ra,0x3
     f62:	556080e7          	jalr	1366(ra) # 44b4 <open>
  if(fd < 0){
     f66:	0a054d63          	bltz	a0,1020 <writetest+0xe4>
     f6a:	892a                	mv	s2,a0
     f6c:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     f6e:	00004997          	auipc	s3,0x4
     f72:	0ca98993          	addi	s3,s3,202 # 5038 <malloc+0x7a4>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     f76:	00004a97          	auipc	s5,0x4
     f7a:	0faa8a93          	addi	s5,s5,250 # 5070 <malloc+0x7dc>
  for(i = 0; i < N; i++){
     f7e:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     f82:	4629                	li	a2,10
     f84:	85ce                	mv	a1,s3
     f86:	854a                	mv	a0,s2
     f88:	00003097          	auipc	ra,0x3
     f8c:	50c080e7          	jalr	1292(ra) # 4494 <write>
     f90:	47a9                	li	a5,10
     f92:	0af51563          	bne	a0,a5,103c <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     f96:	4629                	li	a2,10
     f98:	85d6                	mv	a1,s5
     f9a:	854a                	mv	a0,s2
     f9c:	00003097          	auipc	ra,0x3
     fa0:	4f8080e7          	jalr	1272(ra) # 4494 <write>
     fa4:	47a9                	li	a5,10
     fa6:	0af51963          	bne	a0,a5,1058 <writetest+0x11c>
  for(i = 0; i < N; i++){
     faa:	2485                	addiw	s1,s1,1
     fac:	fd449be3          	bne	s1,s4,f82 <writetest+0x46>
  close(fd);
     fb0:	854a                	mv	a0,s2
     fb2:	00003097          	auipc	ra,0x3
     fb6:	4ea080e7          	jalr	1258(ra) # 449c <close>
  fd = open("small", O_RDONLY);
     fba:	4581                	li	a1,0
     fbc:	00004517          	auipc	a0,0x4
     fc0:	05450513          	addi	a0,a0,84 # 5010 <malloc+0x77c>
     fc4:	00003097          	auipc	ra,0x3
     fc8:	4f0080e7          	jalr	1264(ra) # 44b4 <open>
     fcc:	84aa                	mv	s1,a0
  if(fd < 0){
     fce:	0a054363          	bltz	a0,1074 <writetest+0x138>
  i = read(fd, buf, N*SZ*2);
     fd2:	7d000613          	li	a2,2000
     fd6:	00009597          	auipc	a1,0x9
     fda:	74a58593          	addi	a1,a1,1866 # a720 <buf>
     fde:	00003097          	auipc	ra,0x3
     fe2:	4ae080e7          	jalr	1198(ra) # 448c <read>
  if(i != N*SZ*2){
     fe6:	7d000793          	li	a5,2000
     fea:	0af51363          	bne	a0,a5,1090 <writetest+0x154>
  close(fd);
     fee:	8526                	mv	a0,s1
     ff0:	00003097          	auipc	ra,0x3
     ff4:	4ac080e7          	jalr	1196(ra) # 449c <close>
  if(unlink("small") < 0){
     ff8:	00004517          	auipc	a0,0x4
     ffc:	01850513          	addi	a0,a0,24 # 5010 <malloc+0x77c>
    1000:	00003097          	auipc	ra,0x3
    1004:	4c4080e7          	jalr	1220(ra) # 44c4 <unlink>
    1008:	0a054263          	bltz	a0,10ac <writetest+0x170>
}
    100c:	70e2                	ld	ra,56(sp)
    100e:	7442                	ld	s0,48(sp)
    1010:	74a2                	ld	s1,40(sp)
    1012:	7902                	ld	s2,32(sp)
    1014:	69e2                	ld	s3,24(sp)
    1016:	6a42                	ld	s4,16(sp)
    1018:	6aa2                	ld	s5,8(sp)
    101a:	6b02                	ld	s6,0(sp)
    101c:	6121                	addi	sp,sp,64
    101e:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
    1020:	85da                	mv	a1,s6
    1022:	00004517          	auipc	a0,0x4
    1026:	ff650513          	addi	a0,a0,-10 # 5018 <malloc+0x784>
    102a:	00003097          	auipc	ra,0x3
    102e:	7b2080e7          	jalr	1970(ra) # 47dc <printf>
    exit(1);
    1032:	4505                	li	a0,1
    1034:	00003097          	auipc	ra,0x3
    1038:	440080e7          	jalr	1088(ra) # 4474 <exit>
      printf("%s: error: write aa %d new file failed\n", i);
    103c:	85a6                	mv	a1,s1
    103e:	00004517          	auipc	a0,0x4
    1042:	00a50513          	addi	a0,a0,10 # 5048 <malloc+0x7b4>
    1046:	00003097          	auipc	ra,0x3
    104a:	796080e7          	jalr	1942(ra) # 47dc <printf>
      exit(1);
    104e:	4505                	li	a0,1
    1050:	00003097          	auipc	ra,0x3
    1054:	424080e7          	jalr	1060(ra) # 4474 <exit>
      printf("%s: error: write bb %d new file failed\n", i);
    1058:	85a6                	mv	a1,s1
    105a:	00004517          	auipc	a0,0x4
    105e:	02650513          	addi	a0,a0,38 # 5080 <malloc+0x7ec>
    1062:	00003097          	auipc	ra,0x3
    1066:	77a080e7          	jalr	1914(ra) # 47dc <printf>
      exit(1);
    106a:	4505                	li	a0,1
    106c:	00003097          	auipc	ra,0x3
    1070:	408080e7          	jalr	1032(ra) # 4474 <exit>
    printf("%s: error: open small failed!\n", s);
    1074:	85da                	mv	a1,s6
    1076:	00004517          	auipc	a0,0x4
    107a:	03250513          	addi	a0,a0,50 # 50a8 <malloc+0x814>
    107e:	00003097          	auipc	ra,0x3
    1082:	75e080e7          	jalr	1886(ra) # 47dc <printf>
    exit(1);
    1086:	4505                	li	a0,1
    1088:	00003097          	auipc	ra,0x3
    108c:	3ec080e7          	jalr	1004(ra) # 4474 <exit>
    printf("%s: read failed\n", s);
    1090:	85da                	mv	a1,s6
    1092:	00004517          	auipc	a0,0x4
    1096:	03650513          	addi	a0,a0,54 # 50c8 <malloc+0x834>
    109a:	00003097          	auipc	ra,0x3
    109e:	742080e7          	jalr	1858(ra) # 47dc <printf>
    exit(1);
    10a2:	4505                	li	a0,1
    10a4:	00003097          	auipc	ra,0x3
    10a8:	3d0080e7          	jalr	976(ra) # 4474 <exit>
    printf("%s: unlink small failed\n", s);
    10ac:	85da                	mv	a1,s6
    10ae:	00004517          	auipc	a0,0x4
    10b2:	03250513          	addi	a0,a0,50 # 50e0 <malloc+0x84c>
    10b6:	00003097          	auipc	ra,0x3
    10ba:	726080e7          	jalr	1830(ra) # 47dc <printf>
    exit(1);
    10be:	4505                	li	a0,1
    10c0:	00003097          	auipc	ra,0x3
    10c4:	3b4080e7          	jalr	948(ra) # 4474 <exit>

00000000000010c8 <writebig>:
{
    10c8:	7139                	addi	sp,sp,-64
    10ca:	fc06                	sd	ra,56(sp)
    10cc:	f822                	sd	s0,48(sp)
    10ce:	f426                	sd	s1,40(sp)
    10d0:	f04a                	sd	s2,32(sp)
    10d2:	ec4e                	sd	s3,24(sp)
    10d4:	e852                	sd	s4,16(sp)
    10d6:	e456                	sd	s5,8(sp)
    10d8:	0080                	addi	s0,sp,64
    10da:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
    10dc:	20200593          	li	a1,514
    10e0:	00004517          	auipc	a0,0x4
    10e4:	02050513          	addi	a0,a0,32 # 5100 <malloc+0x86c>
    10e8:	00003097          	auipc	ra,0x3
    10ec:	3cc080e7          	jalr	972(ra) # 44b4 <open>
    10f0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
    10f2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
    10f4:	00009917          	auipc	s2,0x9
    10f8:	62c90913          	addi	s2,s2,1580 # a720 <buf>
  for(i = 0; i < MAXFILE; i++){
    10fc:	6a41                	lui	s4,0x10
    10fe:	10ba0a13          	addi	s4,s4,267 # 1010b <base+0x29eb>
  if(fd < 0){
    1102:	06054c63          	bltz	a0,117a <writebig+0xb2>
    ((int*)buf)[0] = i;
    1106:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
    110a:	40000613          	li	a2,1024
    110e:	85ca                	mv	a1,s2
    1110:	854e                	mv	a0,s3
    1112:	00003097          	auipc	ra,0x3
    1116:	382080e7          	jalr	898(ra) # 4494 <write>
    111a:	40000793          	li	a5,1024
    111e:	06f51c63          	bne	a0,a5,1196 <writebig+0xce>
  for(i = 0; i < MAXFILE; i++){
    1122:	2485                	addiw	s1,s1,1
    1124:	ff4491e3          	bne	s1,s4,1106 <writebig+0x3e>
  close(fd);
    1128:	854e                	mv	a0,s3
    112a:	00003097          	auipc	ra,0x3
    112e:	372080e7          	jalr	882(ra) # 449c <close>
  fd = open("big", O_RDONLY);
    1132:	4581                	li	a1,0
    1134:	00004517          	auipc	a0,0x4
    1138:	fcc50513          	addi	a0,a0,-52 # 5100 <malloc+0x86c>
    113c:	00003097          	auipc	ra,0x3
    1140:	378080e7          	jalr	888(ra) # 44b4 <open>
    1144:	89aa                	mv	s3,a0
  n = 0;
    1146:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
    1148:	00009917          	auipc	s2,0x9
    114c:	5d890913          	addi	s2,s2,1496 # a720 <buf>
  if(fd < 0){
    1150:	06054163          	bltz	a0,11b2 <writebig+0xea>
    i = read(fd, buf, BSIZE);
    1154:	40000613          	li	a2,1024
    1158:	85ca                	mv	a1,s2
    115a:	854e                	mv	a0,s3
    115c:	00003097          	auipc	ra,0x3
    1160:	330080e7          	jalr	816(ra) # 448c <read>
    if(i == 0){
    1164:	c52d                	beqz	a0,11ce <writebig+0x106>
    } else if(i != BSIZE){
    1166:	40000793          	li	a5,1024
    116a:	0af51d63          	bne	a0,a5,1224 <writebig+0x15c>
    if(((int*)buf)[0] != n){
    116e:	00092603          	lw	a2,0(s2)
    1172:	0c961763          	bne	a2,s1,1240 <writebig+0x178>
    n++;
    1176:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
    1178:	bff1                	j	1154 <writebig+0x8c>
    printf("%s: error: creat big failed!\n", s);
    117a:	85d6                	mv	a1,s5
    117c:	00004517          	auipc	a0,0x4
    1180:	f8c50513          	addi	a0,a0,-116 # 5108 <malloc+0x874>
    1184:	00003097          	auipc	ra,0x3
    1188:	658080e7          	jalr	1624(ra) # 47dc <printf>
    exit(1);
    118c:	4505                	li	a0,1
    118e:	00003097          	auipc	ra,0x3
    1192:	2e6080e7          	jalr	742(ra) # 4474 <exit>
      printf("%s: error: write big file failed\n", i);
    1196:	85a6                	mv	a1,s1
    1198:	00004517          	auipc	a0,0x4
    119c:	f9050513          	addi	a0,a0,-112 # 5128 <malloc+0x894>
    11a0:	00003097          	auipc	ra,0x3
    11a4:	63c080e7          	jalr	1596(ra) # 47dc <printf>
      exit(1);
    11a8:	4505                	li	a0,1
    11aa:	00003097          	auipc	ra,0x3
    11ae:	2ca080e7          	jalr	714(ra) # 4474 <exit>
    printf("%s: error: open big failed!\n", s);
    11b2:	85d6                	mv	a1,s5
    11b4:	00004517          	auipc	a0,0x4
    11b8:	f9c50513          	addi	a0,a0,-100 # 5150 <malloc+0x8bc>
    11bc:	00003097          	auipc	ra,0x3
    11c0:	620080e7          	jalr	1568(ra) # 47dc <printf>
    exit(1);
    11c4:	4505                	li	a0,1
    11c6:	00003097          	auipc	ra,0x3
    11ca:	2ae080e7          	jalr	686(ra) # 4474 <exit>
      if(n == MAXFILE - 1){
    11ce:	67c1                	lui	a5,0x10
    11d0:	10a78793          	addi	a5,a5,266 # 1010a <base+0x29ea>
    11d4:	02f48a63          	beq	s1,a5,1208 <writebig+0x140>
  close(fd);
    11d8:	854e                	mv	a0,s3
    11da:	00003097          	auipc	ra,0x3
    11de:	2c2080e7          	jalr	706(ra) # 449c <close>
  if(unlink("big") < 0){
    11e2:	00004517          	auipc	a0,0x4
    11e6:	f1e50513          	addi	a0,a0,-226 # 5100 <malloc+0x86c>
    11ea:	00003097          	auipc	ra,0x3
    11ee:	2da080e7          	jalr	730(ra) # 44c4 <unlink>
    11f2:	06054563          	bltz	a0,125c <writebig+0x194>
}
    11f6:	70e2                	ld	ra,56(sp)
    11f8:	7442                	ld	s0,48(sp)
    11fa:	74a2                	ld	s1,40(sp)
    11fc:	7902                	ld	s2,32(sp)
    11fe:	69e2                	ld	s3,24(sp)
    1200:	6a42                	ld	s4,16(sp)
    1202:	6aa2                	ld	s5,8(sp)
    1204:	6121                	addi	sp,sp,64
    1206:	8082                	ret
        printf("%s: read only %d blocks from big", n);
    1208:	85be                	mv	a1,a5
    120a:	00004517          	auipc	a0,0x4
    120e:	f6650513          	addi	a0,a0,-154 # 5170 <malloc+0x8dc>
    1212:	00003097          	auipc	ra,0x3
    1216:	5ca080e7          	jalr	1482(ra) # 47dc <printf>
        exit(1);
    121a:	4505                	li	a0,1
    121c:	00003097          	auipc	ra,0x3
    1220:	258080e7          	jalr	600(ra) # 4474 <exit>
      printf("%s: read failed %d\n", i);
    1224:	85aa                	mv	a1,a0
    1226:	00004517          	auipc	a0,0x4
    122a:	f7250513          	addi	a0,a0,-142 # 5198 <malloc+0x904>
    122e:	00003097          	auipc	ra,0x3
    1232:	5ae080e7          	jalr	1454(ra) # 47dc <printf>
      exit(1);
    1236:	4505                	li	a0,1
    1238:	00003097          	auipc	ra,0x3
    123c:	23c080e7          	jalr	572(ra) # 4474 <exit>
      printf("%s: read content of block %d is %d\n",
    1240:	85a6                	mv	a1,s1
    1242:	00004517          	auipc	a0,0x4
    1246:	f6e50513          	addi	a0,a0,-146 # 51b0 <malloc+0x91c>
    124a:	00003097          	auipc	ra,0x3
    124e:	592080e7          	jalr	1426(ra) # 47dc <printf>
      exit(1);
    1252:	4505                	li	a0,1
    1254:	00003097          	auipc	ra,0x3
    1258:	220080e7          	jalr	544(ra) # 4474 <exit>
    printf("%s: unlink big failed\n", s);
    125c:	85d6                	mv	a1,s5
    125e:	00004517          	auipc	a0,0x4
    1262:	f7a50513          	addi	a0,a0,-134 # 51d8 <malloc+0x944>
    1266:	00003097          	auipc	ra,0x3
    126a:	576080e7          	jalr	1398(ra) # 47dc <printf>
    exit(1);
    126e:	4505                	li	a0,1
    1270:	00003097          	auipc	ra,0x3
    1274:	204080e7          	jalr	516(ra) # 4474 <exit>

0000000000001278 <unlinkread>:
{
    1278:	7179                	addi	sp,sp,-48
    127a:	f406                	sd	ra,40(sp)
    127c:	f022                	sd	s0,32(sp)
    127e:	ec26                	sd	s1,24(sp)
    1280:	e84a                	sd	s2,16(sp)
    1282:	e44e                	sd	s3,8(sp)
    1284:	1800                	addi	s0,sp,48
    1286:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1288:	20200593          	li	a1,514
    128c:	00004517          	auipc	a0,0x4
    1290:	f6450513          	addi	a0,a0,-156 # 51f0 <malloc+0x95c>
    1294:	00003097          	auipc	ra,0x3
    1298:	220080e7          	jalr	544(ra) # 44b4 <open>
  if(fd < 0){
    129c:	0e054563          	bltz	a0,1386 <unlinkread+0x10e>
    12a0:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
    12a2:	4615                	li	a2,5
    12a4:	00004597          	auipc	a1,0x4
    12a8:	f7c58593          	addi	a1,a1,-132 # 5220 <malloc+0x98c>
    12ac:	00003097          	auipc	ra,0x3
    12b0:	1e8080e7          	jalr	488(ra) # 4494 <write>
  close(fd);
    12b4:	8526                	mv	a0,s1
    12b6:	00003097          	auipc	ra,0x3
    12ba:	1e6080e7          	jalr	486(ra) # 449c <close>
  fd = open("unlinkread", O_RDWR);
    12be:	4589                	li	a1,2
    12c0:	00004517          	auipc	a0,0x4
    12c4:	f3050513          	addi	a0,a0,-208 # 51f0 <malloc+0x95c>
    12c8:	00003097          	auipc	ra,0x3
    12cc:	1ec080e7          	jalr	492(ra) # 44b4 <open>
    12d0:	84aa                	mv	s1,a0
  if(fd < 0){
    12d2:	0c054863          	bltz	a0,13a2 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
    12d6:	00004517          	auipc	a0,0x4
    12da:	f1a50513          	addi	a0,a0,-230 # 51f0 <malloc+0x95c>
    12de:	00003097          	auipc	ra,0x3
    12e2:	1e6080e7          	jalr	486(ra) # 44c4 <unlink>
    12e6:	ed61                	bnez	a0,13be <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    12e8:	20200593          	li	a1,514
    12ec:	00004517          	auipc	a0,0x4
    12f0:	f0450513          	addi	a0,a0,-252 # 51f0 <malloc+0x95c>
    12f4:	00003097          	auipc	ra,0x3
    12f8:	1c0080e7          	jalr	448(ra) # 44b4 <open>
    12fc:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
    12fe:	460d                	li	a2,3
    1300:	00004597          	auipc	a1,0x4
    1304:	f6858593          	addi	a1,a1,-152 # 5268 <malloc+0x9d4>
    1308:	00003097          	auipc	ra,0x3
    130c:	18c080e7          	jalr	396(ra) # 4494 <write>
  close(fd1);
    1310:	854a                	mv	a0,s2
    1312:	00003097          	auipc	ra,0x3
    1316:	18a080e7          	jalr	394(ra) # 449c <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
    131a:	660d                	lui	a2,0x3
    131c:	00009597          	auipc	a1,0x9
    1320:	40458593          	addi	a1,a1,1028 # a720 <buf>
    1324:	8526                	mv	a0,s1
    1326:	00003097          	auipc	ra,0x3
    132a:	166080e7          	jalr	358(ra) # 448c <read>
    132e:	4795                	li	a5,5
    1330:	0af51563          	bne	a0,a5,13da <unlinkread+0x162>
  if(buf[0] != 'h'){
    1334:	00009717          	auipc	a4,0x9
    1338:	3ec74703          	lbu	a4,1004(a4) # a720 <buf>
    133c:	06800793          	li	a5,104
    1340:	0af71b63          	bne	a4,a5,13f6 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
    1344:	4629                	li	a2,10
    1346:	00009597          	auipc	a1,0x9
    134a:	3da58593          	addi	a1,a1,986 # a720 <buf>
    134e:	8526                	mv	a0,s1
    1350:	00003097          	auipc	ra,0x3
    1354:	144080e7          	jalr	324(ra) # 4494 <write>
    1358:	47a9                	li	a5,10
    135a:	0af51c63          	bne	a0,a5,1412 <unlinkread+0x19a>
  close(fd);
    135e:	8526                	mv	a0,s1
    1360:	00003097          	auipc	ra,0x3
    1364:	13c080e7          	jalr	316(ra) # 449c <close>
  unlink("unlinkread");
    1368:	00004517          	auipc	a0,0x4
    136c:	e8850513          	addi	a0,a0,-376 # 51f0 <malloc+0x95c>
    1370:	00003097          	auipc	ra,0x3
    1374:	154080e7          	jalr	340(ra) # 44c4 <unlink>
}
    1378:	70a2                	ld	ra,40(sp)
    137a:	7402                	ld	s0,32(sp)
    137c:	64e2                	ld	s1,24(sp)
    137e:	6942                	ld	s2,16(sp)
    1380:	69a2                	ld	s3,8(sp)
    1382:	6145                	addi	sp,sp,48
    1384:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
    1386:	85ce                	mv	a1,s3
    1388:	00004517          	auipc	a0,0x4
    138c:	e7850513          	addi	a0,a0,-392 # 5200 <malloc+0x96c>
    1390:	00003097          	auipc	ra,0x3
    1394:	44c080e7          	jalr	1100(ra) # 47dc <printf>
    exit(1);
    1398:	4505                	li	a0,1
    139a:	00003097          	auipc	ra,0x3
    139e:	0da080e7          	jalr	218(ra) # 4474 <exit>
    printf("%s: open unlinkread failed\n", s);
    13a2:	85ce                	mv	a1,s3
    13a4:	00004517          	auipc	a0,0x4
    13a8:	e8450513          	addi	a0,a0,-380 # 5228 <malloc+0x994>
    13ac:	00003097          	auipc	ra,0x3
    13b0:	430080e7          	jalr	1072(ra) # 47dc <printf>
    exit(1);
    13b4:	4505                	li	a0,1
    13b6:	00003097          	auipc	ra,0x3
    13ba:	0be080e7          	jalr	190(ra) # 4474 <exit>
    printf("%s: unlink unlinkread failed\n", s);
    13be:	85ce                	mv	a1,s3
    13c0:	00004517          	auipc	a0,0x4
    13c4:	e8850513          	addi	a0,a0,-376 # 5248 <malloc+0x9b4>
    13c8:	00003097          	auipc	ra,0x3
    13cc:	414080e7          	jalr	1044(ra) # 47dc <printf>
    exit(1);
    13d0:	4505                	li	a0,1
    13d2:	00003097          	auipc	ra,0x3
    13d6:	0a2080e7          	jalr	162(ra) # 4474 <exit>
    printf("%s: unlinkread read failed", s);
    13da:	85ce                	mv	a1,s3
    13dc:	00004517          	auipc	a0,0x4
    13e0:	e9450513          	addi	a0,a0,-364 # 5270 <malloc+0x9dc>
    13e4:	00003097          	auipc	ra,0x3
    13e8:	3f8080e7          	jalr	1016(ra) # 47dc <printf>
    exit(1);
    13ec:	4505                	li	a0,1
    13ee:	00003097          	auipc	ra,0x3
    13f2:	086080e7          	jalr	134(ra) # 4474 <exit>
    printf("%s: unlinkread wrong data\n", s);
    13f6:	85ce                	mv	a1,s3
    13f8:	00004517          	auipc	a0,0x4
    13fc:	e9850513          	addi	a0,a0,-360 # 5290 <malloc+0x9fc>
    1400:	00003097          	auipc	ra,0x3
    1404:	3dc080e7          	jalr	988(ra) # 47dc <printf>
    exit(1);
    1408:	4505                	li	a0,1
    140a:	00003097          	auipc	ra,0x3
    140e:	06a080e7          	jalr	106(ra) # 4474 <exit>
    printf("%s: unlinkread write failed\n", s);
    1412:	85ce                	mv	a1,s3
    1414:	00004517          	auipc	a0,0x4
    1418:	e9c50513          	addi	a0,a0,-356 # 52b0 <malloc+0xa1c>
    141c:	00003097          	auipc	ra,0x3
    1420:	3c0080e7          	jalr	960(ra) # 47dc <printf>
    exit(1);
    1424:	4505                	li	a0,1
    1426:	00003097          	auipc	ra,0x3
    142a:	04e080e7          	jalr	78(ra) # 4474 <exit>

000000000000142e <exectest>:
{
    142e:	715d                	addi	sp,sp,-80
    1430:	e486                	sd	ra,72(sp)
    1432:	e0a2                	sd	s0,64(sp)
    1434:	f84a                	sd	s2,48(sp)
    1436:	0880                	addi	s0,sp,80
    1438:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    143a:	00004797          	auipc	a5,0x4
    143e:	8a678793          	addi	a5,a5,-1882 # 4ce0 <malloc+0x44c>
    1442:	fcf43023          	sd	a5,-64(s0)
    1446:	00004797          	auipc	a5,0x4
    144a:	e8a78793          	addi	a5,a5,-374 # 52d0 <malloc+0xa3c>
    144e:	fcf43423          	sd	a5,-56(s0)
    1452:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1456:	00004517          	auipc	a0,0x4
    145a:	e8250513          	addi	a0,a0,-382 # 52d8 <malloc+0xa44>
    145e:	00003097          	auipc	ra,0x3
    1462:	066080e7          	jalr	102(ra) # 44c4 <unlink>
  pid = fork();
    1466:	00003097          	auipc	ra,0x3
    146a:	006080e7          	jalr	6(ra) # 446c <fork>
  if(pid < 0) {
    146e:	04054763          	bltz	a0,14bc <exectest+0x8e>
    1472:	fc26                	sd	s1,56(sp)
    1474:	84aa                	mv	s1,a0
  if(pid == 0) {
    1476:	ed41                	bnez	a0,150e <exectest+0xe0>
    close(1);
    1478:	4505                	li	a0,1
    147a:	00003097          	auipc	ra,0x3
    147e:	022080e7          	jalr	34(ra) # 449c <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1482:	20100593          	li	a1,513
    1486:	00004517          	auipc	a0,0x4
    148a:	e5250513          	addi	a0,a0,-430 # 52d8 <malloc+0xa44>
    148e:	00003097          	auipc	ra,0x3
    1492:	026080e7          	jalr	38(ra) # 44b4 <open>
    if(fd < 0) {
    1496:	04054263          	bltz	a0,14da <exectest+0xac>
    if(fd != 1) {
    149a:	4785                	li	a5,1
    149c:	04f50d63          	beq	a0,a5,14f6 <exectest+0xc8>
      printf("%s: wrong fd\n", s);
    14a0:	85ca                	mv	a1,s2
    14a2:	00004517          	auipc	a0,0x4
    14a6:	e3e50513          	addi	a0,a0,-450 # 52e0 <malloc+0xa4c>
    14aa:	00003097          	auipc	ra,0x3
    14ae:	332080e7          	jalr	818(ra) # 47dc <printf>
      exit(1);
    14b2:	4505                	li	a0,1
    14b4:	00003097          	auipc	ra,0x3
    14b8:	fc0080e7          	jalr	-64(ra) # 4474 <exit>
    14bc:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    14be:	85ca                	mv	a1,s2
    14c0:	00003517          	auipc	a0,0x3
    14c4:	67050513          	addi	a0,a0,1648 # 4b30 <malloc+0x29c>
    14c8:	00003097          	auipc	ra,0x3
    14cc:	314080e7          	jalr	788(ra) # 47dc <printf>
     exit(1);
    14d0:	4505                	li	a0,1
    14d2:	00003097          	auipc	ra,0x3
    14d6:	fa2080e7          	jalr	-94(ra) # 4474 <exit>
      printf("%s: create failed\n", s);
    14da:	85ca                	mv	a1,s2
    14dc:	00004517          	auipc	a0,0x4
    14e0:	86c50513          	addi	a0,a0,-1940 # 4d48 <malloc+0x4b4>
    14e4:	00003097          	auipc	ra,0x3
    14e8:	2f8080e7          	jalr	760(ra) # 47dc <printf>
      exit(1);
    14ec:	4505                	li	a0,1
    14ee:	00003097          	auipc	ra,0x3
    14f2:	f86080e7          	jalr	-122(ra) # 4474 <exit>
    if(exec("echo", echoargv) < 0){
    14f6:	fc040593          	addi	a1,s0,-64
    14fa:	00003517          	auipc	a0,0x3
    14fe:	7e650513          	addi	a0,a0,2022 # 4ce0 <malloc+0x44c>
    1502:	00003097          	auipc	ra,0x3
    1506:	faa080e7          	jalr	-86(ra) # 44ac <exec>
    150a:	02054163          	bltz	a0,152c <exectest+0xfe>
  if (wait(&xstatus) != pid) {
    150e:	fdc40513          	addi	a0,s0,-36
    1512:	00003097          	auipc	ra,0x3
    1516:	f6a080e7          	jalr	-150(ra) # 447c <wait>
    151a:	02951763          	bne	a0,s1,1548 <exectest+0x11a>
  if(xstatus != 0)
    151e:	fdc42503          	lw	a0,-36(s0)
    1522:	cd0d                	beqz	a0,155c <exectest+0x12e>
    exit(xstatus);
    1524:	00003097          	auipc	ra,0x3
    1528:	f50080e7          	jalr	-176(ra) # 4474 <exit>
      printf("%s: exec echo failed\n", s);
    152c:	85ca                	mv	a1,s2
    152e:	00004517          	auipc	a0,0x4
    1532:	dc250513          	addi	a0,a0,-574 # 52f0 <malloc+0xa5c>
    1536:	00003097          	auipc	ra,0x3
    153a:	2a6080e7          	jalr	678(ra) # 47dc <printf>
      exit(1);
    153e:	4505                	li	a0,1
    1540:	00003097          	auipc	ra,0x3
    1544:	f34080e7          	jalr	-204(ra) # 4474 <exit>
    printf("%s: wait failed!\n", s);
    1548:	85ca                	mv	a1,s2
    154a:	00004517          	auipc	a0,0x4
    154e:	dbe50513          	addi	a0,a0,-578 # 5308 <malloc+0xa74>
    1552:	00003097          	auipc	ra,0x3
    1556:	28a080e7          	jalr	650(ra) # 47dc <printf>
    155a:	b7d1                	j	151e <exectest+0xf0>
  fd = open("echo-ok", O_RDONLY);
    155c:	4581                	li	a1,0
    155e:	00004517          	auipc	a0,0x4
    1562:	d7a50513          	addi	a0,a0,-646 # 52d8 <malloc+0xa44>
    1566:	00003097          	auipc	ra,0x3
    156a:	f4e080e7          	jalr	-178(ra) # 44b4 <open>
  if(fd < 0) {
    156e:	02054a63          	bltz	a0,15a2 <exectest+0x174>
  if (read(fd, buf, 2) != 2) {
    1572:	4609                	li	a2,2
    1574:	fb840593          	addi	a1,s0,-72
    1578:	00003097          	auipc	ra,0x3
    157c:	f14080e7          	jalr	-236(ra) # 448c <read>
    1580:	4789                	li	a5,2
    1582:	02f50e63          	beq	a0,a5,15be <exectest+0x190>
    printf("%s: read failed\n", s);
    1586:	85ca                	mv	a1,s2
    1588:	00004517          	auipc	a0,0x4
    158c:	b4050513          	addi	a0,a0,-1216 # 50c8 <malloc+0x834>
    1590:	00003097          	auipc	ra,0x3
    1594:	24c080e7          	jalr	588(ra) # 47dc <printf>
    exit(1);
    1598:	4505                	li	a0,1
    159a:	00003097          	auipc	ra,0x3
    159e:	eda080e7          	jalr	-294(ra) # 4474 <exit>
    printf("%s: open failed\n", s);
    15a2:	85ca                	mv	a1,s2
    15a4:	00004517          	auipc	a0,0x4
    15a8:	d7c50513          	addi	a0,a0,-644 # 5320 <malloc+0xa8c>
    15ac:	00003097          	auipc	ra,0x3
    15b0:	230080e7          	jalr	560(ra) # 47dc <printf>
    exit(1);
    15b4:	4505                	li	a0,1
    15b6:	00003097          	auipc	ra,0x3
    15ba:	ebe080e7          	jalr	-322(ra) # 4474 <exit>
  unlink("echo-ok");
    15be:	00004517          	auipc	a0,0x4
    15c2:	d1a50513          	addi	a0,a0,-742 # 52d8 <malloc+0xa44>
    15c6:	00003097          	auipc	ra,0x3
    15ca:	efe080e7          	jalr	-258(ra) # 44c4 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    15ce:	fb844703          	lbu	a4,-72(s0)
    15d2:	04f00793          	li	a5,79
    15d6:	00f71863          	bne	a4,a5,15e6 <exectest+0x1b8>
    15da:	fb944703          	lbu	a4,-71(s0)
    15de:	04b00793          	li	a5,75
    15e2:	02f70063          	beq	a4,a5,1602 <exectest+0x1d4>
    printf("%s: wrong output\n", s);
    15e6:	85ca                	mv	a1,s2
    15e8:	00004517          	auipc	a0,0x4
    15ec:	d5050513          	addi	a0,a0,-688 # 5338 <malloc+0xaa4>
    15f0:	00003097          	auipc	ra,0x3
    15f4:	1ec080e7          	jalr	492(ra) # 47dc <printf>
    exit(1);
    15f8:	4505                	li	a0,1
    15fa:	00003097          	auipc	ra,0x3
    15fe:	e7a080e7          	jalr	-390(ra) # 4474 <exit>
    exit(0);
    1602:	4501                	li	a0,0
    1604:	00003097          	auipc	ra,0x3
    1608:	e70080e7          	jalr	-400(ra) # 4474 <exit>

000000000000160c <bigargtest>:
{
    160c:	7179                	addi	sp,sp,-48
    160e:	f406                	sd	ra,40(sp)
    1610:	f022                	sd	s0,32(sp)
    1612:	ec26                	sd	s1,24(sp)
    1614:	1800                	addi	s0,sp,48
    1616:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    1618:	00004517          	auipc	a0,0x4
    161c:	d3850513          	addi	a0,a0,-712 # 5350 <malloc+0xabc>
    1620:	00003097          	auipc	ra,0x3
    1624:	ea4080e7          	jalr	-348(ra) # 44c4 <unlink>
  pid = fork();
    1628:	00003097          	auipc	ra,0x3
    162c:	e44080e7          	jalr	-444(ra) # 446c <fork>
  if(pid == 0){
    1630:	c121                	beqz	a0,1670 <bigargtest+0x64>
  } else if(pid < 0){
    1632:	0a054063          	bltz	a0,16d2 <bigargtest+0xc6>
  wait(&xstatus);
    1636:	fdc40513          	addi	a0,s0,-36
    163a:	00003097          	auipc	ra,0x3
    163e:	e42080e7          	jalr	-446(ra) # 447c <wait>
  if(xstatus != 0)
    1642:	fdc42503          	lw	a0,-36(s0)
    1646:	e545                	bnez	a0,16ee <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    1648:	4581                	li	a1,0
    164a:	00004517          	auipc	a0,0x4
    164e:	d0650513          	addi	a0,a0,-762 # 5350 <malloc+0xabc>
    1652:	00003097          	auipc	ra,0x3
    1656:	e62080e7          	jalr	-414(ra) # 44b4 <open>
  if(fd < 0){
    165a:	08054e63          	bltz	a0,16f6 <bigargtest+0xea>
  close(fd);
    165e:	00003097          	auipc	ra,0x3
    1662:	e3e080e7          	jalr	-450(ra) # 449c <close>
}
    1666:	70a2                	ld	ra,40(sp)
    1668:	7402                	ld	s0,32(sp)
    166a:	64e2                	ld	s1,24(sp)
    166c:	6145                	addi	sp,sp,48
    166e:	8082                	ret
    1670:	00007797          	auipc	a5,0x7
    1674:	8a078793          	addi	a5,a5,-1888 # 7f10 <args.0>
    1678:	00007697          	auipc	a3,0x7
    167c:	99068693          	addi	a3,a3,-1648 # 8008 <args.0+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    1680:	00004717          	auipc	a4,0x4
    1684:	ce070713          	addi	a4,a4,-800 # 5360 <malloc+0xacc>
    1688:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    168a:	07a1                	addi	a5,a5,8
    168c:	fed79ee3          	bne	a5,a3,1688 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    1690:	00007597          	auipc	a1,0x7
    1694:	88058593          	addi	a1,a1,-1920 # 7f10 <args.0>
    1698:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    169c:	00003517          	auipc	a0,0x3
    16a0:	64450513          	addi	a0,a0,1604 # 4ce0 <malloc+0x44c>
    16a4:	00003097          	auipc	ra,0x3
    16a8:	e08080e7          	jalr	-504(ra) # 44ac <exec>
    fd = open("bigarg-ok", O_CREATE);
    16ac:	20000593          	li	a1,512
    16b0:	00004517          	auipc	a0,0x4
    16b4:	ca050513          	addi	a0,a0,-864 # 5350 <malloc+0xabc>
    16b8:	00003097          	auipc	ra,0x3
    16bc:	dfc080e7          	jalr	-516(ra) # 44b4 <open>
    close(fd);
    16c0:	00003097          	auipc	ra,0x3
    16c4:	ddc080e7          	jalr	-548(ra) # 449c <close>
    exit(0);
    16c8:	4501                	li	a0,0
    16ca:	00003097          	auipc	ra,0x3
    16ce:	daa080e7          	jalr	-598(ra) # 4474 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    16d2:	85a6                	mv	a1,s1
    16d4:	00004517          	auipc	a0,0x4
    16d8:	d6c50513          	addi	a0,a0,-660 # 5440 <malloc+0xbac>
    16dc:	00003097          	auipc	ra,0x3
    16e0:	100080e7          	jalr	256(ra) # 47dc <printf>
    exit(1);
    16e4:	4505                	li	a0,1
    16e6:	00003097          	auipc	ra,0x3
    16ea:	d8e080e7          	jalr	-626(ra) # 4474 <exit>
    exit(xstatus);
    16ee:	00003097          	auipc	ra,0x3
    16f2:	d86080e7          	jalr	-634(ra) # 4474 <exit>
    printf("%s: bigarg test failed!\n", s);
    16f6:	85a6                	mv	a1,s1
    16f8:	00004517          	auipc	a0,0x4
    16fc:	d6850513          	addi	a0,a0,-664 # 5460 <malloc+0xbcc>
    1700:	00003097          	auipc	ra,0x3
    1704:	0dc080e7          	jalr	220(ra) # 47dc <printf>
    exit(1);
    1708:	4505                	li	a0,1
    170a:	00003097          	auipc	ra,0x3
    170e:	d6a080e7          	jalr	-662(ra) # 4474 <exit>

0000000000001712 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    1712:	7139                	addi	sp,sp,-64
    1714:	fc06                	sd	ra,56(sp)
    1716:	f822                	sd	s0,48(sp)
    1718:	f426                	sd	s1,40(sp)
    171a:	f04a                	sd	s2,32(sp)
    171c:	ec4e                	sd	s3,24(sp)
    171e:	0080                	addi	s0,sp,64
    1720:	64b1                	lui	s1,0xc
    1722:	35048493          	addi	s1,s1,848 # c350 <buf+0x1c30>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1726:	597d                	li	s2,-1
    1728:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    172c:	00003997          	auipc	s3,0x3
    1730:	5b498993          	addi	s3,s3,1460 # 4ce0 <malloc+0x44c>
    argv[0] = (char*)0xffffffff;
    1734:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1738:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    173c:	fc040593          	addi	a1,s0,-64
    1740:	854e                	mv	a0,s3
    1742:	00003097          	auipc	ra,0x3
    1746:	d6a080e7          	jalr	-662(ra) # 44ac <exec>
  for(int i = 0; i < 50000; i++){
    174a:	34fd                	addiw	s1,s1,-1
    174c:	f4e5                	bnez	s1,1734 <badarg+0x22>
  }
  
  exit(0);
    174e:	4501                	li	a0,0
    1750:	00003097          	auipc	ra,0x3
    1754:	d24080e7          	jalr	-732(ra) # 4474 <exit>

0000000000001758 <pipe1>:
{
    1758:	711d                	addi	sp,sp,-96
    175a:	ec86                	sd	ra,88(sp)
    175c:	e8a2                	sd	s0,80(sp)
    175e:	fc4e                	sd	s3,56(sp)
    1760:	1080                	addi	s0,sp,96
    1762:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    1764:	fa840513          	addi	a0,s0,-88
    1768:	00003097          	auipc	ra,0x3
    176c:	d1c080e7          	jalr	-740(ra) # 4484 <pipe>
    1770:	ed3d                	bnez	a0,17ee <pipe1+0x96>
    1772:	e4a6                	sd	s1,72(sp)
    1774:	f852                	sd	s4,48(sp)
    1776:	84aa                	mv	s1,a0
  pid = fork();
    1778:	00003097          	auipc	ra,0x3
    177c:	cf4080e7          	jalr	-780(ra) # 446c <fork>
    1780:	8a2a                	mv	s4,a0
  if(pid == 0){
    1782:	c951                	beqz	a0,1816 <pipe1+0xbe>
  } else if(pid > 0){
    1784:	18a05b63          	blez	a0,191a <pipe1+0x1c2>
    1788:	e0ca                	sd	s2,64(sp)
    178a:	f456                	sd	s5,40(sp)
    close(fds[1]);
    178c:	fac42503          	lw	a0,-84(s0)
    1790:	00003097          	auipc	ra,0x3
    1794:	d0c080e7          	jalr	-756(ra) # 449c <close>
    total = 0;
    1798:	8a26                	mv	s4,s1
    cc = 1;
    179a:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    179c:	00009a97          	auipc	s5,0x9
    17a0:	f84a8a93          	addi	s5,s5,-124 # a720 <buf>
    17a4:	864a                	mv	a2,s2
    17a6:	85d6                	mv	a1,s5
    17a8:	fa842503          	lw	a0,-88(s0)
    17ac:	00003097          	auipc	ra,0x3
    17b0:	ce0080e7          	jalr	-800(ra) # 448c <read>
    17b4:	10a05a63          	blez	a0,18c8 <pipe1+0x170>
      for(i = 0; i < n; i++){
    17b8:	00009717          	auipc	a4,0x9
    17bc:	f6870713          	addi	a4,a4,-152 # a720 <buf>
    17c0:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17c4:	00074683          	lbu	a3,0(a4)
    17c8:	0ff4f793          	zext.b	a5,s1
    17cc:	2485                	addiw	s1,s1,1
    17ce:	0cf69b63          	bne	a3,a5,18a4 <pipe1+0x14c>
      for(i = 0; i < n; i++){
    17d2:	0705                	addi	a4,a4,1
    17d4:	fec498e3          	bne	s1,a2,17c4 <pipe1+0x6c>
      total += n;
    17d8:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    17dc:	0019179b          	slliw	a5,s2,0x1
    17e0:	0007891b          	sext.w	s2,a5
      if(cc > sizeof(buf))
    17e4:	670d                	lui	a4,0x3
    17e6:	fb277fe3          	bgeu	a4,s2,17a4 <pipe1+0x4c>
        cc = sizeof(buf);
    17ea:	690d                	lui	s2,0x3
    17ec:	bf65                	j	17a4 <pipe1+0x4c>
    17ee:	e4a6                	sd	s1,72(sp)
    17f0:	e0ca                	sd	s2,64(sp)
    17f2:	f852                	sd	s4,48(sp)
    17f4:	f456                	sd	s5,40(sp)
    17f6:	f05a                	sd	s6,32(sp)
    17f8:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    17fa:	85ce                	mv	a1,s3
    17fc:	00004517          	auipc	a0,0x4
    1800:	c8450513          	addi	a0,a0,-892 # 5480 <malloc+0xbec>
    1804:	00003097          	auipc	ra,0x3
    1808:	fd8080e7          	jalr	-40(ra) # 47dc <printf>
    exit(1);
    180c:	4505                	li	a0,1
    180e:	00003097          	auipc	ra,0x3
    1812:	c66080e7          	jalr	-922(ra) # 4474 <exit>
    1816:	e0ca                	sd	s2,64(sp)
    1818:	f456                	sd	s5,40(sp)
    181a:	f05a                	sd	s6,32(sp)
    181c:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    181e:	fa842503          	lw	a0,-88(s0)
    1822:	00003097          	auipc	ra,0x3
    1826:	c7a080e7          	jalr	-902(ra) # 449c <close>
    for(n = 0; n < N; n++){
    182a:	00009b17          	auipc	s6,0x9
    182e:	ef6b0b13          	addi	s6,s6,-266 # a720 <buf>
    1832:	416004bb          	negw	s1,s6
    1836:	0ff4f493          	zext.b	s1,s1
    183a:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    183e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1840:	6a85                	lui	s5,0x1
    1842:	42da8a93          	addi	s5,s5,1069 # 142d <unlinkread+0x1b5>
{
    1846:	87da                	mv	a5,s6
        buf[i] = seq++;
    1848:	0097873b          	addw	a4,a5,s1
    184c:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1850:	0785                	addi	a5,a5,1
    1852:	ff279be3          	bne	a5,s2,1848 <pipe1+0xf0>
    1856:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    185a:	40900613          	li	a2,1033
    185e:	85de                	mv	a1,s7
    1860:	fac42503          	lw	a0,-84(s0)
    1864:	00003097          	auipc	ra,0x3
    1868:	c30080e7          	jalr	-976(ra) # 4494 <write>
    186c:	40900793          	li	a5,1033
    1870:	00f51c63          	bne	a0,a5,1888 <pipe1+0x130>
    for(n = 0; n < N; n++){
    1874:	24a5                	addiw	s1,s1,9
    1876:	0ff4f493          	zext.b	s1,s1
    187a:	fd5a16e3          	bne	s4,s5,1846 <pipe1+0xee>
    exit(0);
    187e:	4501                	li	a0,0
    1880:	00003097          	auipc	ra,0x3
    1884:	bf4080e7          	jalr	-1036(ra) # 4474 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1888:	85ce                	mv	a1,s3
    188a:	00004517          	auipc	a0,0x4
    188e:	c0e50513          	addi	a0,a0,-1010 # 5498 <malloc+0xc04>
    1892:	00003097          	auipc	ra,0x3
    1896:	f4a080e7          	jalr	-182(ra) # 47dc <printf>
        exit(1);
    189a:	4505                	li	a0,1
    189c:	00003097          	auipc	ra,0x3
    18a0:	bd8080e7          	jalr	-1064(ra) # 4474 <exit>
          printf("%s: pipe1 oops 2\n", s);
    18a4:	85ce                	mv	a1,s3
    18a6:	00004517          	auipc	a0,0x4
    18aa:	c0a50513          	addi	a0,a0,-1014 # 54b0 <malloc+0xc1c>
    18ae:	00003097          	auipc	ra,0x3
    18b2:	f2e080e7          	jalr	-210(ra) # 47dc <printf>
          return;
    18b6:	64a6                	ld	s1,72(sp)
    18b8:	6906                	ld	s2,64(sp)
    18ba:	7a42                	ld	s4,48(sp)
    18bc:	7aa2                	ld	s5,40(sp)
}
    18be:	60e6                	ld	ra,88(sp)
    18c0:	6446                	ld	s0,80(sp)
    18c2:	79e2                	ld	s3,56(sp)
    18c4:	6125                	addi	sp,sp,96
    18c6:	8082                	ret
    if(total != N * SZ){
    18c8:	6785                	lui	a5,0x1
    18ca:	42d78793          	addi	a5,a5,1069 # 142d <unlinkread+0x1b5>
    18ce:	02fa0263          	beq	s4,a5,18f2 <pipe1+0x19a>
    18d2:	f05a                	sd	s6,32(sp)
    18d4:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", total);
    18d6:	85d2                	mv	a1,s4
    18d8:	00004517          	auipc	a0,0x4
    18dc:	bf050513          	addi	a0,a0,-1040 # 54c8 <malloc+0xc34>
    18e0:	00003097          	auipc	ra,0x3
    18e4:	efc080e7          	jalr	-260(ra) # 47dc <printf>
      exit(1);
    18e8:	4505                	li	a0,1
    18ea:	00003097          	auipc	ra,0x3
    18ee:	b8a080e7          	jalr	-1142(ra) # 4474 <exit>
    18f2:	f05a                	sd	s6,32(sp)
    18f4:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    18f6:	fa842503          	lw	a0,-88(s0)
    18fa:	00003097          	auipc	ra,0x3
    18fe:	ba2080e7          	jalr	-1118(ra) # 449c <close>
    wait(&xstatus);
    1902:	fa440513          	addi	a0,s0,-92
    1906:	00003097          	auipc	ra,0x3
    190a:	b76080e7          	jalr	-1162(ra) # 447c <wait>
    exit(xstatus);
    190e:	fa442503          	lw	a0,-92(s0)
    1912:	00003097          	auipc	ra,0x3
    1916:	b62080e7          	jalr	-1182(ra) # 4474 <exit>
    191a:	e0ca                	sd	s2,64(sp)
    191c:	f456                	sd	s5,40(sp)
    191e:	f05a                	sd	s6,32(sp)
    1920:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    1922:	85ce                	mv	a1,s3
    1924:	00004517          	auipc	a0,0x4
    1928:	bc450513          	addi	a0,a0,-1084 # 54e8 <malloc+0xc54>
    192c:	00003097          	auipc	ra,0x3
    1930:	eb0080e7          	jalr	-336(ra) # 47dc <printf>
    exit(1);
    1934:	4505                	li	a0,1
    1936:	00003097          	auipc	ra,0x3
    193a:	b3e080e7          	jalr	-1218(ra) # 4474 <exit>

000000000000193e <pgbug>:
{
    193e:	7179                	addi	sp,sp,-48
    1940:	f406                	sd	ra,40(sp)
    1942:	f022                	sd	s0,32(sp)
    1944:	ec26                	sd	s1,24(sp)
    1946:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1948:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    194c:	eaeb14b7          	lui	s1,0xeaeb1
    1950:	b5b48493          	addi	s1,s1,-1189 # ffffffffeaeb0b5b <base+0xffffffffeaea343b>
    1954:	04d2                	slli	s1,s1,0x14
    1956:	048d                	addi	s1,s1,3
    1958:	04b2                	slli	s1,s1,0xc
    195a:	f5e48493          	addi	s1,s1,-162
    195e:	fd840593          	addi	a1,s0,-40
    1962:	8526                	mv	a0,s1
    1964:	00003097          	auipc	ra,0x3
    1968:	b48080e7          	jalr	-1208(ra) # 44ac <exec>
  pipe((int*)0xeaeb0b5b00002f5e);
    196c:	8526                	mv	a0,s1
    196e:	00003097          	auipc	ra,0x3
    1972:	b16080e7          	jalr	-1258(ra) # 4484 <pipe>
  exit(0);
    1976:	4501                	li	a0,0
    1978:	00003097          	auipc	ra,0x3
    197c:	afc080e7          	jalr	-1284(ra) # 4474 <exit>

0000000000001980 <preempt>:
{
    1980:	7139                	addi	sp,sp,-64
    1982:	fc06                	sd	ra,56(sp)
    1984:	f822                	sd	s0,48(sp)
    1986:	f426                	sd	s1,40(sp)
    1988:	f04a                	sd	s2,32(sp)
    198a:	ec4e                	sd	s3,24(sp)
    198c:	e852                	sd	s4,16(sp)
    198e:	0080                	addi	s0,sp,64
    1990:	892a                	mv	s2,a0
  pid1 = fork();
    1992:	00003097          	auipc	ra,0x3
    1996:	ada080e7          	jalr	-1318(ra) # 446c <fork>
  if(pid1 < 0) {
    199a:	00054563          	bltz	a0,19a4 <preempt+0x24>
    199e:	84aa                	mv	s1,a0
  if(pid1 == 0)
    19a0:	ed19                	bnez	a0,19be <preempt+0x3e>
    for(;;)
    19a2:	a001                	j	19a2 <preempt+0x22>
    printf("%s: fork failed");
    19a4:	00003517          	auipc	a0,0x3
    19a8:	1f450513          	addi	a0,a0,500 # 4b98 <malloc+0x304>
    19ac:	00003097          	auipc	ra,0x3
    19b0:	e30080e7          	jalr	-464(ra) # 47dc <printf>
    exit(1);
    19b4:	4505                	li	a0,1
    19b6:	00003097          	auipc	ra,0x3
    19ba:	abe080e7          	jalr	-1346(ra) # 4474 <exit>
  pid2 = fork();
    19be:	00003097          	auipc	ra,0x3
    19c2:	aae080e7          	jalr	-1362(ra) # 446c <fork>
    19c6:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    19c8:	00054463          	bltz	a0,19d0 <preempt+0x50>
  if(pid2 == 0)
    19cc:	e105                	bnez	a0,19ec <preempt+0x6c>
    for(;;)
    19ce:	a001                	j	19ce <preempt+0x4e>
    printf("%s: fork failed\n", s);
    19d0:	85ca                	mv	a1,s2
    19d2:	00003517          	auipc	a0,0x3
    19d6:	15e50513          	addi	a0,a0,350 # 4b30 <malloc+0x29c>
    19da:	00003097          	auipc	ra,0x3
    19de:	e02080e7          	jalr	-510(ra) # 47dc <printf>
    exit(1);
    19e2:	4505                	li	a0,1
    19e4:	00003097          	auipc	ra,0x3
    19e8:	a90080e7          	jalr	-1392(ra) # 4474 <exit>
  pipe(pfds);
    19ec:	fc840513          	addi	a0,s0,-56
    19f0:	00003097          	auipc	ra,0x3
    19f4:	a94080e7          	jalr	-1388(ra) # 4484 <pipe>
  pid3 = fork();
    19f8:	00003097          	auipc	ra,0x3
    19fc:	a74080e7          	jalr	-1420(ra) # 446c <fork>
    1a00:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    1a02:	02054e63          	bltz	a0,1a3e <preempt+0xbe>
  if(pid3 == 0){
    1a06:	e13d                	bnez	a0,1a6c <preempt+0xec>
    close(pfds[0]);
    1a08:	fc842503          	lw	a0,-56(s0)
    1a0c:	00003097          	auipc	ra,0x3
    1a10:	a90080e7          	jalr	-1392(ra) # 449c <close>
    if(write(pfds[1], "x", 1) != 1)
    1a14:	4605                	li	a2,1
    1a16:	00004597          	auipc	a1,0x4
    1a1a:	aea58593          	addi	a1,a1,-1302 # 5500 <malloc+0xc6c>
    1a1e:	fcc42503          	lw	a0,-52(s0)
    1a22:	00003097          	auipc	ra,0x3
    1a26:	a72080e7          	jalr	-1422(ra) # 4494 <write>
    1a2a:	4785                	li	a5,1
    1a2c:	02f51763          	bne	a0,a5,1a5a <preempt+0xda>
    close(pfds[1]);
    1a30:	fcc42503          	lw	a0,-52(s0)
    1a34:	00003097          	auipc	ra,0x3
    1a38:	a68080e7          	jalr	-1432(ra) # 449c <close>
    for(;;)
    1a3c:	a001                	j	1a3c <preempt+0xbc>
     printf("%s: fork failed\n", s);
    1a3e:	85ca                	mv	a1,s2
    1a40:	00003517          	auipc	a0,0x3
    1a44:	0f050513          	addi	a0,a0,240 # 4b30 <malloc+0x29c>
    1a48:	00003097          	auipc	ra,0x3
    1a4c:	d94080e7          	jalr	-620(ra) # 47dc <printf>
     exit(1);
    1a50:	4505                	li	a0,1
    1a52:	00003097          	auipc	ra,0x3
    1a56:	a22080e7          	jalr	-1502(ra) # 4474 <exit>
      printf("%s: preempt write error");
    1a5a:	00004517          	auipc	a0,0x4
    1a5e:	aae50513          	addi	a0,a0,-1362 # 5508 <malloc+0xc74>
    1a62:	00003097          	auipc	ra,0x3
    1a66:	d7a080e7          	jalr	-646(ra) # 47dc <printf>
    1a6a:	b7d9                	j	1a30 <preempt+0xb0>
  close(pfds[1]);
    1a6c:	fcc42503          	lw	a0,-52(s0)
    1a70:	00003097          	auipc	ra,0x3
    1a74:	a2c080e7          	jalr	-1492(ra) # 449c <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1a78:	660d                	lui	a2,0x3
    1a7a:	00009597          	auipc	a1,0x9
    1a7e:	ca658593          	addi	a1,a1,-858 # a720 <buf>
    1a82:	fc842503          	lw	a0,-56(s0)
    1a86:	00003097          	auipc	ra,0x3
    1a8a:	a06080e7          	jalr	-1530(ra) # 448c <read>
    1a8e:	4785                	li	a5,1
    1a90:	02f50263          	beq	a0,a5,1ab4 <preempt+0x134>
    printf("%s: preempt read error");
    1a94:	00004517          	auipc	a0,0x4
    1a98:	a8c50513          	addi	a0,a0,-1396 # 5520 <malloc+0xc8c>
    1a9c:	00003097          	auipc	ra,0x3
    1aa0:	d40080e7          	jalr	-704(ra) # 47dc <printf>
}
    1aa4:	70e2                	ld	ra,56(sp)
    1aa6:	7442                	ld	s0,48(sp)
    1aa8:	74a2                	ld	s1,40(sp)
    1aaa:	7902                	ld	s2,32(sp)
    1aac:	69e2                	ld	s3,24(sp)
    1aae:	6a42                	ld	s4,16(sp)
    1ab0:	6121                	addi	sp,sp,64
    1ab2:	8082                	ret
  close(pfds[0]);
    1ab4:	fc842503          	lw	a0,-56(s0)
    1ab8:	00003097          	auipc	ra,0x3
    1abc:	9e4080e7          	jalr	-1564(ra) # 449c <close>
  printf("kill... ");
    1ac0:	00004517          	auipc	a0,0x4
    1ac4:	a7850513          	addi	a0,a0,-1416 # 5538 <malloc+0xca4>
    1ac8:	00003097          	auipc	ra,0x3
    1acc:	d14080e7          	jalr	-748(ra) # 47dc <printf>
  kill(pid1);
    1ad0:	8526                	mv	a0,s1
    1ad2:	00003097          	auipc	ra,0x3
    1ad6:	9d2080e7          	jalr	-1582(ra) # 44a4 <kill>
  kill(pid2);
    1ada:	854e                	mv	a0,s3
    1adc:	00003097          	auipc	ra,0x3
    1ae0:	9c8080e7          	jalr	-1592(ra) # 44a4 <kill>
  kill(pid3);
    1ae4:	8552                	mv	a0,s4
    1ae6:	00003097          	auipc	ra,0x3
    1aea:	9be080e7          	jalr	-1602(ra) # 44a4 <kill>
  printf("wait... ");
    1aee:	00004517          	auipc	a0,0x4
    1af2:	a5a50513          	addi	a0,a0,-1446 # 5548 <malloc+0xcb4>
    1af6:	00003097          	auipc	ra,0x3
    1afa:	ce6080e7          	jalr	-794(ra) # 47dc <printf>
  wait(0);
    1afe:	4501                	li	a0,0
    1b00:	00003097          	auipc	ra,0x3
    1b04:	97c080e7          	jalr	-1668(ra) # 447c <wait>
  wait(0);
    1b08:	4501                	li	a0,0
    1b0a:	00003097          	auipc	ra,0x3
    1b0e:	972080e7          	jalr	-1678(ra) # 447c <wait>
  wait(0);
    1b12:	4501                	li	a0,0
    1b14:	00003097          	auipc	ra,0x3
    1b18:	968080e7          	jalr	-1688(ra) # 447c <wait>
    1b1c:	b761                	j	1aa4 <preempt+0x124>

0000000000001b1e <reparent>:
{
    1b1e:	7179                	addi	sp,sp,-48
    1b20:	f406                	sd	ra,40(sp)
    1b22:	f022                	sd	s0,32(sp)
    1b24:	ec26                	sd	s1,24(sp)
    1b26:	e84a                	sd	s2,16(sp)
    1b28:	e44e                	sd	s3,8(sp)
    1b2a:	e052                	sd	s4,0(sp)
    1b2c:	1800                	addi	s0,sp,48
    1b2e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    1b30:	00003097          	auipc	ra,0x3
    1b34:	9c4080e7          	jalr	-1596(ra) # 44f4 <getpid>
    1b38:	8a2a                	mv	s4,a0
    1b3a:	0c800913          	li	s2,200
    int pid = fork();
    1b3e:	00003097          	auipc	ra,0x3
    1b42:	92e080e7          	jalr	-1746(ra) # 446c <fork>
    1b46:	84aa                	mv	s1,a0
    if(pid < 0){
    1b48:	02054263          	bltz	a0,1b6c <reparent+0x4e>
    if(pid){
    1b4c:	cd21                	beqz	a0,1ba4 <reparent+0x86>
      if(wait(0) != pid){
    1b4e:	4501                	li	a0,0
    1b50:	00003097          	auipc	ra,0x3
    1b54:	92c080e7          	jalr	-1748(ra) # 447c <wait>
    1b58:	02951863          	bne	a0,s1,1b88 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    1b5c:	397d                	addiw	s2,s2,-1 # 2fff <subdir+0x605>
    1b5e:	fe0910e3          	bnez	s2,1b3e <reparent+0x20>
  exit(0);
    1b62:	4501                	li	a0,0
    1b64:	00003097          	auipc	ra,0x3
    1b68:	910080e7          	jalr	-1776(ra) # 4474 <exit>
      printf("%s: fork failed\n", s);
    1b6c:	85ce                	mv	a1,s3
    1b6e:	00003517          	auipc	a0,0x3
    1b72:	fc250513          	addi	a0,a0,-62 # 4b30 <malloc+0x29c>
    1b76:	00003097          	auipc	ra,0x3
    1b7a:	c66080e7          	jalr	-922(ra) # 47dc <printf>
      exit(1);
    1b7e:	4505                	li	a0,1
    1b80:	00003097          	auipc	ra,0x3
    1b84:	8f4080e7          	jalr	-1804(ra) # 4474 <exit>
        printf("%s: wait wrong pid\n", s);
    1b88:	85ce                	mv	a1,s3
    1b8a:	00003517          	auipc	a0,0x3
    1b8e:	fd650513          	addi	a0,a0,-42 # 4b60 <malloc+0x2cc>
    1b92:	00003097          	auipc	ra,0x3
    1b96:	c4a080e7          	jalr	-950(ra) # 47dc <printf>
        exit(1);
    1b9a:	4505                	li	a0,1
    1b9c:	00003097          	auipc	ra,0x3
    1ba0:	8d8080e7          	jalr	-1832(ra) # 4474 <exit>
      int pid2 = fork();
    1ba4:	00003097          	auipc	ra,0x3
    1ba8:	8c8080e7          	jalr	-1848(ra) # 446c <fork>
      if(pid2 < 0){
    1bac:	00054763          	bltz	a0,1bba <reparent+0x9c>
      exit(0);
    1bb0:	4501                	li	a0,0
    1bb2:	00003097          	auipc	ra,0x3
    1bb6:	8c2080e7          	jalr	-1854(ra) # 4474 <exit>
        kill(master_pid);
    1bba:	8552                	mv	a0,s4
    1bbc:	00003097          	auipc	ra,0x3
    1bc0:	8e8080e7          	jalr	-1816(ra) # 44a4 <kill>
        exit(1);
    1bc4:	4505                	li	a0,1
    1bc6:	00003097          	auipc	ra,0x3
    1bca:	8ae080e7          	jalr	-1874(ra) # 4474 <exit>

0000000000001bce <mem>:
{
    1bce:	7139                	addi	sp,sp,-64
    1bd0:	fc06                	sd	ra,56(sp)
    1bd2:	f822                	sd	s0,48(sp)
    1bd4:	f426                	sd	s1,40(sp)
    1bd6:	f04a                	sd	s2,32(sp)
    1bd8:	ec4e                	sd	s3,24(sp)
    1bda:	0080                	addi	s0,sp,64
    1bdc:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    1bde:	00003097          	auipc	ra,0x3
    1be2:	88e080e7          	jalr	-1906(ra) # 446c <fork>
    m1 = 0;
    1be6:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    1be8:	6909                	lui	s2,0x2
    1bea:	71190913          	addi	s2,s2,1809 # 2711 <concreate+0x293>
  if((pid = fork()) == 0){
    1bee:	cd19                	beqz	a0,1c0c <mem+0x3e>
    wait(&xstatus);
    1bf0:	fcc40513          	addi	a0,s0,-52
    1bf4:	00003097          	auipc	ra,0x3
    1bf8:	888080e7          	jalr	-1912(ra) # 447c <wait>
    exit(xstatus);
    1bfc:	fcc42503          	lw	a0,-52(s0)
    1c00:	00003097          	auipc	ra,0x3
    1c04:	874080e7          	jalr	-1932(ra) # 4474 <exit>
      *(char**)m2 = m1;
    1c08:	e104                	sd	s1,0(a0)
      m1 = m2;
    1c0a:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    1c0c:	854a                	mv	a0,s2
    1c0e:	00003097          	auipc	ra,0x3
    1c12:	c86080e7          	jalr	-890(ra) # 4894 <malloc>
    1c16:	f96d                	bnez	a0,1c08 <mem+0x3a>
    while(m1){
    1c18:	c881                	beqz	s1,1c28 <mem+0x5a>
      m2 = *(char**)m1;
    1c1a:	8526                	mv	a0,s1
    1c1c:	6084                	ld	s1,0(s1)
      free(m1);
    1c1e:	00003097          	auipc	ra,0x3
    1c22:	bf4080e7          	jalr	-1036(ra) # 4812 <free>
    while(m1){
    1c26:	f8f5                	bnez	s1,1c1a <mem+0x4c>
    m1 = malloc(1024*20);
    1c28:	6515                	lui	a0,0x5
    1c2a:	00003097          	auipc	ra,0x3
    1c2e:	c6a080e7          	jalr	-918(ra) # 4894 <malloc>
    if(m1 == 0){
    1c32:	c911                	beqz	a0,1c46 <mem+0x78>
    free(m1);
    1c34:	00003097          	auipc	ra,0x3
    1c38:	bde080e7          	jalr	-1058(ra) # 4812 <free>
    exit(0);
    1c3c:	4501                	li	a0,0
    1c3e:	00003097          	auipc	ra,0x3
    1c42:	836080e7          	jalr	-1994(ra) # 4474 <exit>
      printf("couldn't allocate mem?!!\n", s);
    1c46:	85ce                	mv	a1,s3
    1c48:	00004517          	auipc	a0,0x4
    1c4c:	91050513          	addi	a0,a0,-1776 # 5558 <malloc+0xcc4>
    1c50:	00003097          	auipc	ra,0x3
    1c54:	b8c080e7          	jalr	-1140(ra) # 47dc <printf>
      exit(1);
    1c58:	4505                	li	a0,1
    1c5a:	00003097          	auipc	ra,0x3
    1c5e:	81a080e7          	jalr	-2022(ra) # 4474 <exit>

0000000000001c62 <sharedfd>:
{
    1c62:	7159                	addi	sp,sp,-112
    1c64:	f486                	sd	ra,104(sp)
    1c66:	f0a2                	sd	s0,96(sp)
    1c68:	e0d2                	sd	s4,64(sp)
    1c6a:	1880                	addi	s0,sp,112
    1c6c:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    1c6e:	00004517          	auipc	a0,0x4
    1c72:	90a50513          	addi	a0,a0,-1782 # 5578 <malloc+0xce4>
    1c76:	00003097          	auipc	ra,0x3
    1c7a:	84e080e7          	jalr	-1970(ra) # 44c4 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1c7e:	20200593          	li	a1,514
    1c82:	00004517          	auipc	a0,0x4
    1c86:	8f650513          	addi	a0,a0,-1802 # 5578 <malloc+0xce4>
    1c8a:	00003097          	auipc	ra,0x3
    1c8e:	82a080e7          	jalr	-2006(ra) # 44b4 <open>
  if(fd < 0){
    1c92:	06054063          	bltz	a0,1cf2 <sharedfd+0x90>
    1c96:	eca6                	sd	s1,88(sp)
    1c98:	e8ca                	sd	s2,80(sp)
    1c9a:	e4ce                	sd	s3,72(sp)
    1c9c:	fc56                	sd	s5,56(sp)
    1c9e:	f85a                	sd	s6,48(sp)
    1ca0:	f45e                	sd	s7,40(sp)
    1ca2:	892a                	mv	s2,a0
  pid = fork();
    1ca4:	00002097          	auipc	ra,0x2
    1ca8:	7c8080e7          	jalr	1992(ra) # 446c <fork>
    1cac:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1cae:	07000593          	li	a1,112
    1cb2:	e119                	bnez	a0,1cb8 <sharedfd+0x56>
    1cb4:	06300593          	li	a1,99
    1cb8:	4629                	li	a2,10
    1cba:	fa040513          	addi	a0,s0,-96
    1cbe:	00002097          	auipc	ra,0x2
    1cc2:	5bc080e7          	jalr	1468(ra) # 427a <memset>
    1cc6:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1cca:	4629                	li	a2,10
    1ccc:	fa040593          	addi	a1,s0,-96
    1cd0:	854a                	mv	a0,s2
    1cd2:	00002097          	auipc	ra,0x2
    1cd6:	7c2080e7          	jalr	1986(ra) # 4494 <write>
    1cda:	47a9                	li	a5,10
    1cdc:	02f51f63          	bne	a0,a5,1d1a <sharedfd+0xb8>
  for(i = 0; i < N; i++){
    1ce0:	34fd                	addiw	s1,s1,-1
    1ce2:	f4e5                	bnez	s1,1cca <sharedfd+0x68>
  if(pid == 0) {
    1ce4:	04099963          	bnez	s3,1d36 <sharedfd+0xd4>
    exit(0);
    1ce8:	4501                	li	a0,0
    1cea:	00002097          	auipc	ra,0x2
    1cee:	78a080e7          	jalr	1930(ra) # 4474 <exit>
    1cf2:	eca6                	sd	s1,88(sp)
    1cf4:	e8ca                	sd	s2,80(sp)
    1cf6:	e4ce                	sd	s3,72(sp)
    1cf8:	fc56                	sd	s5,56(sp)
    1cfa:	f85a                	sd	s6,48(sp)
    1cfc:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    1cfe:	85d2                	mv	a1,s4
    1d00:	00004517          	auipc	a0,0x4
    1d04:	88850513          	addi	a0,a0,-1912 # 5588 <malloc+0xcf4>
    1d08:	00003097          	auipc	ra,0x3
    1d0c:	ad4080e7          	jalr	-1324(ra) # 47dc <printf>
    exit(1);
    1d10:	4505                	li	a0,1
    1d12:	00002097          	auipc	ra,0x2
    1d16:	762080e7          	jalr	1890(ra) # 4474 <exit>
      printf("%s: write sharedfd failed\n", s);
    1d1a:	85d2                	mv	a1,s4
    1d1c:	00004517          	auipc	a0,0x4
    1d20:	89450513          	addi	a0,a0,-1900 # 55b0 <malloc+0xd1c>
    1d24:	00003097          	auipc	ra,0x3
    1d28:	ab8080e7          	jalr	-1352(ra) # 47dc <printf>
      exit(1);
    1d2c:	4505                	li	a0,1
    1d2e:	00002097          	auipc	ra,0x2
    1d32:	746080e7          	jalr	1862(ra) # 4474 <exit>
    wait(&xstatus);
    1d36:	f9c40513          	addi	a0,s0,-100
    1d3a:	00002097          	auipc	ra,0x2
    1d3e:	742080e7          	jalr	1858(ra) # 447c <wait>
    if(xstatus != 0)
    1d42:	f9c42983          	lw	s3,-100(s0)
    1d46:	00098763          	beqz	s3,1d54 <sharedfd+0xf2>
      exit(xstatus);
    1d4a:	854e                	mv	a0,s3
    1d4c:	00002097          	auipc	ra,0x2
    1d50:	728080e7          	jalr	1832(ra) # 4474 <exit>
  close(fd);
    1d54:	854a                	mv	a0,s2
    1d56:	00002097          	auipc	ra,0x2
    1d5a:	746080e7          	jalr	1862(ra) # 449c <close>
  fd = open("sharedfd", 0);
    1d5e:	4581                	li	a1,0
    1d60:	00004517          	auipc	a0,0x4
    1d64:	81850513          	addi	a0,a0,-2024 # 5578 <malloc+0xce4>
    1d68:	00002097          	auipc	ra,0x2
    1d6c:	74c080e7          	jalr	1868(ra) # 44b4 <open>
    1d70:	8baa                	mv	s7,a0
  nc = np = 0;
    1d72:	8ace                	mv	s5,s3
  if(fd < 0){
    1d74:	02054563          	bltz	a0,1d9e <sharedfd+0x13c>
    1d78:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    1d7c:	06300493          	li	s1,99
      if(buf[i] == 'p')
    1d80:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1d84:	4629                	li	a2,10
    1d86:	fa040593          	addi	a1,s0,-96
    1d8a:	855e                	mv	a0,s7
    1d8c:	00002097          	auipc	ra,0x2
    1d90:	700080e7          	jalr	1792(ra) # 448c <read>
    1d94:	02a05f63          	blez	a0,1dd2 <sharedfd+0x170>
    1d98:	fa040793          	addi	a5,s0,-96
    1d9c:	a01d                	j	1dc2 <sharedfd+0x160>
    printf("%s: cannot open sharedfd for reading\n", s);
    1d9e:	85d2                	mv	a1,s4
    1da0:	00004517          	auipc	a0,0x4
    1da4:	83050513          	addi	a0,a0,-2000 # 55d0 <malloc+0xd3c>
    1da8:	00003097          	auipc	ra,0x3
    1dac:	a34080e7          	jalr	-1484(ra) # 47dc <printf>
    exit(1);
    1db0:	4505                	li	a0,1
    1db2:	00002097          	auipc	ra,0x2
    1db6:	6c2080e7          	jalr	1730(ra) # 4474 <exit>
        nc++;
    1dba:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    1dbc:	0785                	addi	a5,a5,1
    1dbe:	fd2783e3          	beq	a5,s2,1d84 <sharedfd+0x122>
      if(buf[i] == 'c')
    1dc2:	0007c703          	lbu	a4,0(a5)
    1dc6:	fe970ae3          	beq	a4,s1,1dba <sharedfd+0x158>
      if(buf[i] == 'p')
    1dca:	ff6719e3          	bne	a4,s6,1dbc <sharedfd+0x15a>
        np++;
    1dce:	2a85                	addiw	s5,s5,1
    1dd0:	b7f5                	j	1dbc <sharedfd+0x15a>
  close(fd);
    1dd2:	855e                	mv	a0,s7
    1dd4:	00002097          	auipc	ra,0x2
    1dd8:	6c8080e7          	jalr	1736(ra) # 449c <close>
  unlink("sharedfd");
    1ddc:	00003517          	auipc	a0,0x3
    1de0:	79c50513          	addi	a0,a0,1948 # 5578 <malloc+0xce4>
    1de4:	00002097          	auipc	ra,0x2
    1de8:	6e0080e7          	jalr	1760(ra) # 44c4 <unlink>
  if(nc == N*SZ && np == N*SZ){
    1dec:	6789                	lui	a5,0x2
    1dee:	71078793          	addi	a5,a5,1808 # 2710 <concreate+0x292>
    1df2:	00f99763          	bne	s3,a5,1e00 <sharedfd+0x19e>
    1df6:	6789                	lui	a5,0x2
    1df8:	71078793          	addi	a5,a5,1808 # 2710 <concreate+0x292>
    1dfc:	02fa8063          	beq	s5,a5,1e1c <sharedfd+0x1ba>
    printf("%s: nc/np test fails\n", s);
    1e00:	85d2                	mv	a1,s4
    1e02:	00003517          	auipc	a0,0x3
    1e06:	7f650513          	addi	a0,a0,2038 # 55f8 <malloc+0xd64>
    1e0a:	00003097          	auipc	ra,0x3
    1e0e:	9d2080e7          	jalr	-1582(ra) # 47dc <printf>
    exit(1);
    1e12:	4505                	li	a0,1
    1e14:	00002097          	auipc	ra,0x2
    1e18:	660080e7          	jalr	1632(ra) # 4474 <exit>
    exit(0);
    1e1c:	4501                	li	a0,0
    1e1e:	00002097          	auipc	ra,0x2
    1e22:	656080e7          	jalr	1622(ra) # 4474 <exit>

0000000000001e26 <fourfiles>:
{
    1e26:	7135                	addi	sp,sp,-160
    1e28:	ed06                	sd	ra,152(sp)
    1e2a:	e922                	sd	s0,144(sp)
    1e2c:	e526                	sd	s1,136(sp)
    1e2e:	e14a                	sd	s2,128(sp)
    1e30:	fcce                	sd	s3,120(sp)
    1e32:	f8d2                	sd	s4,112(sp)
    1e34:	f4d6                	sd	s5,104(sp)
    1e36:	f0da                	sd	s6,96(sp)
    1e38:	ecde                	sd	s7,88(sp)
    1e3a:	e8e2                	sd	s8,80(sp)
    1e3c:	e4e6                	sd	s9,72(sp)
    1e3e:	e0ea                	sd	s10,64(sp)
    1e40:	fc6e                	sd	s11,56(sp)
    1e42:	1100                	addi	s0,sp,160
    1e44:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e46:	00003797          	auipc	a5,0x3
    1e4a:	7ca78793          	addi	a5,a5,1994 # 5610 <malloc+0xd7c>
    1e4e:	f6f43823          	sd	a5,-144(s0)
    1e52:	00003797          	auipc	a5,0x3
    1e56:	7c678793          	addi	a5,a5,1990 # 5618 <malloc+0xd84>
    1e5a:	f6f43c23          	sd	a5,-136(s0)
    1e5e:	00003797          	auipc	a5,0x3
    1e62:	7c278793          	addi	a5,a5,1986 # 5620 <malloc+0xd8c>
    1e66:	f8f43023          	sd	a5,-128(s0)
    1e6a:	00003797          	auipc	a5,0x3
    1e6e:	7be78793          	addi	a5,a5,1982 # 5628 <malloc+0xd94>
    1e72:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    1e76:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e7a:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    1e7c:	4481                	li	s1,0
    1e7e:	4a11                	li	s4,4
    fname = names[pi];
    1e80:	00093983          	ld	s3,0(s2)
    unlink(fname);
    1e84:	854e                	mv	a0,s3
    1e86:	00002097          	auipc	ra,0x2
    1e8a:	63e080e7          	jalr	1598(ra) # 44c4 <unlink>
    pid = fork();
    1e8e:	00002097          	auipc	ra,0x2
    1e92:	5de080e7          	jalr	1502(ra) # 446c <fork>
    if(pid < 0){
    1e96:	04054063          	bltz	a0,1ed6 <fourfiles+0xb0>
    if(pid == 0){
    1e9a:	cd21                	beqz	a0,1ef2 <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    1e9c:	2485                	addiw	s1,s1,1
    1e9e:	0921                	addi	s2,s2,8
    1ea0:	ff4490e3          	bne	s1,s4,1e80 <fourfiles+0x5a>
    1ea4:	4491                	li	s1,4
    wait(&xstatus);
    1ea6:	f6c40513          	addi	a0,s0,-148
    1eaa:	00002097          	auipc	ra,0x2
    1eae:	5d2080e7          	jalr	1490(ra) # 447c <wait>
    if(xstatus != 0)
    1eb2:	f6c42a83          	lw	s5,-148(s0)
    1eb6:	0c0a9863          	bnez	s5,1f86 <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    1eba:	34fd                	addiw	s1,s1,-1
    1ebc:	f4ed                	bnez	s1,1ea6 <fourfiles+0x80>
    1ebe:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1ec2:	00009a17          	auipc	s4,0x9
    1ec6:	85ea0a13          	addi	s4,s4,-1954 # a720 <buf>
    if(total != N*SZ){
    1eca:	6d05                	lui	s10,0x1
    1ecc:	770d0d13          	addi	s10,s10,1904 # 1770 <pipe1+0x18>
  for(i = 0; i < NCHILD; i++){
    1ed0:	03400d93          	li	s11,52
    1ed4:	a22d                	j	1ffe <fourfiles+0x1d8>
      printf("fork failed\n", s);
    1ed6:	85e6                	mv	a1,s9
    1ed8:	00003517          	auipc	a0,0x3
    1edc:	57850513          	addi	a0,a0,1400 # 5450 <malloc+0xbbc>
    1ee0:	00003097          	auipc	ra,0x3
    1ee4:	8fc080e7          	jalr	-1796(ra) # 47dc <printf>
      exit(1);
    1ee8:	4505                	li	a0,1
    1eea:	00002097          	auipc	ra,0x2
    1eee:	58a080e7          	jalr	1418(ra) # 4474 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1ef2:	20200593          	li	a1,514
    1ef6:	854e                	mv	a0,s3
    1ef8:	00002097          	auipc	ra,0x2
    1efc:	5bc080e7          	jalr	1468(ra) # 44b4 <open>
    1f00:	892a                	mv	s2,a0
      if(fd < 0){
    1f02:	04054763          	bltz	a0,1f50 <fourfiles+0x12a>
      memset(buf, '0'+pi, SZ);
    1f06:	1f400613          	li	a2,500
    1f0a:	0304859b          	addiw	a1,s1,48
    1f0e:	00009517          	auipc	a0,0x9
    1f12:	81250513          	addi	a0,a0,-2030 # a720 <buf>
    1f16:	00002097          	auipc	ra,0x2
    1f1a:	364080e7          	jalr	868(ra) # 427a <memset>
    1f1e:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    1f20:	00009997          	auipc	s3,0x9
    1f24:	80098993          	addi	s3,s3,-2048 # a720 <buf>
    1f28:	1f400613          	li	a2,500
    1f2c:	85ce                	mv	a1,s3
    1f2e:	854a                	mv	a0,s2
    1f30:	00002097          	auipc	ra,0x2
    1f34:	564080e7          	jalr	1380(ra) # 4494 <write>
    1f38:	85aa                	mv	a1,a0
    1f3a:	1f400793          	li	a5,500
    1f3e:	02f51763          	bne	a0,a5,1f6c <fourfiles+0x146>
      for(i = 0; i < N; i++){
    1f42:	34fd                	addiw	s1,s1,-1
    1f44:	f0f5                	bnez	s1,1f28 <fourfiles+0x102>
      exit(0);
    1f46:	4501                	li	a0,0
    1f48:	00002097          	auipc	ra,0x2
    1f4c:	52c080e7          	jalr	1324(ra) # 4474 <exit>
        printf("create failed\n", s);
    1f50:	85e6                	mv	a1,s9
    1f52:	00003517          	auipc	a0,0x3
    1f56:	6de50513          	addi	a0,a0,1758 # 5630 <malloc+0xd9c>
    1f5a:	00003097          	auipc	ra,0x3
    1f5e:	882080e7          	jalr	-1918(ra) # 47dc <printf>
        exit(1);
    1f62:	4505                	li	a0,1
    1f64:	00002097          	auipc	ra,0x2
    1f68:	510080e7          	jalr	1296(ra) # 4474 <exit>
          printf("write failed %d\n", n);
    1f6c:	00003517          	auipc	a0,0x3
    1f70:	6d450513          	addi	a0,a0,1748 # 5640 <malloc+0xdac>
    1f74:	00003097          	auipc	ra,0x3
    1f78:	868080e7          	jalr	-1944(ra) # 47dc <printf>
          exit(1);
    1f7c:	4505                	li	a0,1
    1f7e:	00002097          	auipc	ra,0x2
    1f82:	4f6080e7          	jalr	1270(ra) # 4474 <exit>
      exit(xstatus);
    1f86:	8556                	mv	a0,s5
    1f88:	00002097          	auipc	ra,0x2
    1f8c:	4ec080e7          	jalr	1260(ra) # 4474 <exit>
          printf("wrong char\n", s);
    1f90:	85e6                	mv	a1,s9
    1f92:	00003517          	auipc	a0,0x3
    1f96:	6c650513          	addi	a0,a0,1734 # 5658 <malloc+0xdc4>
    1f9a:	00003097          	auipc	ra,0x3
    1f9e:	842080e7          	jalr	-1982(ra) # 47dc <printf>
          exit(1);
    1fa2:	4505                	li	a0,1
    1fa4:	00002097          	auipc	ra,0x2
    1fa8:	4d0080e7          	jalr	1232(ra) # 4474 <exit>
      total += n;
    1fac:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1fb0:	660d                	lui	a2,0x3
    1fb2:	85d2                	mv	a1,s4
    1fb4:	854e                	mv	a0,s3
    1fb6:	00002097          	auipc	ra,0x2
    1fba:	4d6080e7          	jalr	1238(ra) # 448c <read>
    1fbe:	02a05063          	blez	a0,1fde <fourfiles+0x1b8>
    1fc2:	00008797          	auipc	a5,0x8
    1fc6:	75e78793          	addi	a5,a5,1886 # a720 <buf>
    1fca:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    1fce:	0007c703          	lbu	a4,0(a5)
    1fd2:	fa971fe3          	bne	a4,s1,1f90 <fourfiles+0x16a>
      for(j = 0; j < n; j++){
    1fd6:	0785                	addi	a5,a5,1
    1fd8:	fed79be3          	bne	a5,a3,1fce <fourfiles+0x1a8>
    1fdc:	bfc1                	j	1fac <fourfiles+0x186>
    close(fd);
    1fde:	854e                	mv	a0,s3
    1fe0:	00002097          	auipc	ra,0x2
    1fe4:	4bc080e7          	jalr	1212(ra) # 449c <close>
    if(total != N*SZ){
    1fe8:	03a91863          	bne	s2,s10,2018 <fourfiles+0x1f2>
    unlink(fname);
    1fec:	8562                	mv	a0,s8
    1fee:	00002097          	auipc	ra,0x2
    1ff2:	4d6080e7          	jalr	1238(ra) # 44c4 <unlink>
  for(i = 0; i < NCHILD; i++){
    1ff6:	0ba1                	addi	s7,s7,8
    1ff8:	2b05                	addiw	s6,s6,1
    1ffa:	03bb0d63          	beq	s6,s11,2034 <fourfiles+0x20e>
    fname = names[i];
    1ffe:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    2002:	4581                	li	a1,0
    2004:	8562                	mv	a0,s8
    2006:	00002097          	auipc	ra,0x2
    200a:	4ae080e7          	jalr	1198(ra) # 44b4 <open>
    200e:	89aa                	mv	s3,a0
    total = 0;
    2010:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    2012:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2016:	bf69                	j	1fb0 <fourfiles+0x18a>
      printf("wrong length %d\n", total);
    2018:	85ca                	mv	a1,s2
    201a:	00003517          	auipc	a0,0x3
    201e:	64e50513          	addi	a0,a0,1614 # 5668 <malloc+0xdd4>
    2022:	00002097          	auipc	ra,0x2
    2026:	7ba080e7          	jalr	1978(ra) # 47dc <printf>
      exit(1);
    202a:	4505                	li	a0,1
    202c:	00002097          	auipc	ra,0x2
    2030:	448080e7          	jalr	1096(ra) # 4474 <exit>
}
    2034:	60ea                	ld	ra,152(sp)
    2036:	644a                	ld	s0,144(sp)
    2038:	64aa                	ld	s1,136(sp)
    203a:	690a                	ld	s2,128(sp)
    203c:	79e6                	ld	s3,120(sp)
    203e:	7a46                	ld	s4,112(sp)
    2040:	7aa6                	ld	s5,104(sp)
    2042:	7b06                	ld	s6,96(sp)
    2044:	6be6                	ld	s7,88(sp)
    2046:	6c46                	ld	s8,80(sp)
    2048:	6ca6                	ld	s9,72(sp)
    204a:	6d06                	ld	s10,64(sp)
    204c:	7de2                	ld	s11,56(sp)
    204e:	610d                	addi	sp,sp,160
    2050:	8082                	ret

0000000000002052 <bigfile>:
{
    2052:	7139                	addi	sp,sp,-64
    2054:	fc06                	sd	ra,56(sp)
    2056:	f822                	sd	s0,48(sp)
    2058:	f426                	sd	s1,40(sp)
    205a:	f04a                	sd	s2,32(sp)
    205c:	ec4e                	sd	s3,24(sp)
    205e:	e852                	sd	s4,16(sp)
    2060:	e456                	sd	s5,8(sp)
    2062:	0080                	addi	s0,sp,64
    2064:	8aaa                	mv	s5,a0
  unlink("bigfile.test");
    2066:	00003517          	auipc	a0,0x3
    206a:	61a50513          	addi	a0,a0,1562 # 5680 <malloc+0xdec>
    206e:	00002097          	auipc	ra,0x2
    2072:	456080e7          	jalr	1110(ra) # 44c4 <unlink>
  fd = open("bigfile.test", O_CREATE | O_RDWR);
    2076:	20200593          	li	a1,514
    207a:	00003517          	auipc	a0,0x3
    207e:	60650513          	addi	a0,a0,1542 # 5680 <malloc+0xdec>
    2082:	00002097          	auipc	ra,0x2
    2086:	432080e7          	jalr	1074(ra) # 44b4 <open>
    208a:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    208c:	4481                	li	s1,0
    memset(buf, i, SZ);
    208e:	00008917          	auipc	s2,0x8
    2092:	69290913          	addi	s2,s2,1682 # a720 <buf>
  for(i = 0; i < N; i++){
    2096:	4a51                	li	s4,20
  if(fd < 0){
    2098:	0a054063          	bltz	a0,2138 <bigfile+0xe6>
    memset(buf, i, SZ);
    209c:	25800613          	li	a2,600
    20a0:	85a6                	mv	a1,s1
    20a2:	854a                	mv	a0,s2
    20a4:	00002097          	auipc	ra,0x2
    20a8:	1d6080e7          	jalr	470(ra) # 427a <memset>
    if(write(fd, buf, SZ) != SZ){
    20ac:	25800613          	li	a2,600
    20b0:	85ca                	mv	a1,s2
    20b2:	854e                	mv	a0,s3
    20b4:	00002097          	auipc	ra,0x2
    20b8:	3e0080e7          	jalr	992(ra) # 4494 <write>
    20bc:	25800793          	li	a5,600
    20c0:	08f51a63          	bne	a0,a5,2154 <bigfile+0x102>
  for(i = 0; i < N; i++){
    20c4:	2485                	addiw	s1,s1,1
    20c6:	fd449be3          	bne	s1,s4,209c <bigfile+0x4a>
  close(fd);
    20ca:	854e                	mv	a0,s3
    20cc:	00002097          	auipc	ra,0x2
    20d0:	3d0080e7          	jalr	976(ra) # 449c <close>
  fd = open("bigfile.test", 0);
    20d4:	4581                	li	a1,0
    20d6:	00003517          	auipc	a0,0x3
    20da:	5aa50513          	addi	a0,a0,1450 # 5680 <malloc+0xdec>
    20de:	00002097          	auipc	ra,0x2
    20e2:	3d6080e7          	jalr	982(ra) # 44b4 <open>
    20e6:	8a2a                	mv	s4,a0
  total = 0;
    20e8:	4981                	li	s3,0
  for(i = 0; ; i++){
    20ea:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    20ec:	00008917          	auipc	s2,0x8
    20f0:	63490913          	addi	s2,s2,1588 # a720 <buf>
  if(fd < 0){
    20f4:	06054e63          	bltz	a0,2170 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    20f8:	12c00613          	li	a2,300
    20fc:	85ca                	mv	a1,s2
    20fe:	8552                	mv	a0,s4
    2100:	00002097          	auipc	ra,0x2
    2104:	38c080e7          	jalr	908(ra) # 448c <read>
    if(cc < 0){
    2108:	08054263          	bltz	a0,218c <bigfile+0x13a>
    if(cc == 0)
    210c:	c971                	beqz	a0,21e0 <bigfile+0x18e>
    if(cc != SZ/2){
    210e:	12c00793          	li	a5,300
    2112:	08f51b63          	bne	a0,a5,21a8 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    2116:	01f4d79b          	srliw	a5,s1,0x1f
    211a:	9fa5                	addw	a5,a5,s1
    211c:	4017d79b          	sraiw	a5,a5,0x1
    2120:	00094703          	lbu	a4,0(s2)
    2124:	0af71063          	bne	a4,a5,21c4 <bigfile+0x172>
    2128:	12b94703          	lbu	a4,299(s2)
    212c:	08f71c63          	bne	a4,a5,21c4 <bigfile+0x172>
    total += cc;
    2130:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    2134:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    2136:	b7c9                	j	20f8 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    2138:	85d6                	mv	a1,s5
    213a:	00003517          	auipc	a0,0x3
    213e:	55650513          	addi	a0,a0,1366 # 5690 <malloc+0xdfc>
    2142:	00002097          	auipc	ra,0x2
    2146:	69a080e7          	jalr	1690(ra) # 47dc <printf>
    exit(1);
    214a:	4505                	li	a0,1
    214c:	00002097          	auipc	ra,0x2
    2150:	328080e7          	jalr	808(ra) # 4474 <exit>
      printf("%s: write bigfile failed\n", s);
    2154:	85d6                	mv	a1,s5
    2156:	00003517          	auipc	a0,0x3
    215a:	55a50513          	addi	a0,a0,1370 # 56b0 <malloc+0xe1c>
    215e:	00002097          	auipc	ra,0x2
    2162:	67e080e7          	jalr	1662(ra) # 47dc <printf>
      exit(1);
    2166:	4505                	li	a0,1
    2168:	00002097          	auipc	ra,0x2
    216c:	30c080e7          	jalr	780(ra) # 4474 <exit>
    printf("%s: cannot open bigfile\n", s);
    2170:	85d6                	mv	a1,s5
    2172:	00003517          	auipc	a0,0x3
    2176:	55e50513          	addi	a0,a0,1374 # 56d0 <malloc+0xe3c>
    217a:	00002097          	auipc	ra,0x2
    217e:	662080e7          	jalr	1634(ra) # 47dc <printf>
    exit(1);
    2182:	4505                	li	a0,1
    2184:	00002097          	auipc	ra,0x2
    2188:	2f0080e7          	jalr	752(ra) # 4474 <exit>
      printf("%s: read bigfile failed\n", s);
    218c:	85d6                	mv	a1,s5
    218e:	00003517          	auipc	a0,0x3
    2192:	56250513          	addi	a0,a0,1378 # 56f0 <malloc+0xe5c>
    2196:	00002097          	auipc	ra,0x2
    219a:	646080e7          	jalr	1606(ra) # 47dc <printf>
      exit(1);
    219e:	4505                	li	a0,1
    21a0:	00002097          	auipc	ra,0x2
    21a4:	2d4080e7          	jalr	724(ra) # 4474 <exit>
      printf("%s: short read bigfile\n", s);
    21a8:	85d6                	mv	a1,s5
    21aa:	00003517          	auipc	a0,0x3
    21ae:	56650513          	addi	a0,a0,1382 # 5710 <malloc+0xe7c>
    21b2:	00002097          	auipc	ra,0x2
    21b6:	62a080e7          	jalr	1578(ra) # 47dc <printf>
      exit(1);
    21ba:	4505                	li	a0,1
    21bc:	00002097          	auipc	ra,0x2
    21c0:	2b8080e7          	jalr	696(ra) # 4474 <exit>
      printf("%s: read bigfile wrong data\n", s);
    21c4:	85d6                	mv	a1,s5
    21c6:	00003517          	auipc	a0,0x3
    21ca:	56250513          	addi	a0,a0,1378 # 5728 <malloc+0xe94>
    21ce:	00002097          	auipc	ra,0x2
    21d2:	60e080e7          	jalr	1550(ra) # 47dc <printf>
      exit(1);
    21d6:	4505                	li	a0,1
    21d8:	00002097          	auipc	ra,0x2
    21dc:	29c080e7          	jalr	668(ra) # 4474 <exit>
  close(fd);
    21e0:	8552                	mv	a0,s4
    21e2:	00002097          	auipc	ra,0x2
    21e6:	2ba080e7          	jalr	698(ra) # 449c <close>
  if(total != N*SZ){
    21ea:	678d                	lui	a5,0x3
    21ec:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x4e6>
    21f0:	02f99363          	bne	s3,a5,2216 <bigfile+0x1c4>
  unlink("bigfile.test");
    21f4:	00003517          	auipc	a0,0x3
    21f8:	48c50513          	addi	a0,a0,1164 # 5680 <malloc+0xdec>
    21fc:	00002097          	auipc	ra,0x2
    2200:	2c8080e7          	jalr	712(ra) # 44c4 <unlink>
}
    2204:	70e2                	ld	ra,56(sp)
    2206:	7442                	ld	s0,48(sp)
    2208:	74a2                	ld	s1,40(sp)
    220a:	7902                	ld	s2,32(sp)
    220c:	69e2                	ld	s3,24(sp)
    220e:	6a42                	ld	s4,16(sp)
    2210:	6aa2                	ld	s5,8(sp)
    2212:	6121                	addi	sp,sp,64
    2214:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    2216:	85d6                	mv	a1,s5
    2218:	00003517          	auipc	a0,0x3
    221c:	53050513          	addi	a0,a0,1328 # 5748 <malloc+0xeb4>
    2220:	00002097          	auipc	ra,0x2
    2224:	5bc080e7          	jalr	1468(ra) # 47dc <printf>
    exit(1);
    2228:	4505                	li	a0,1
    222a:	00002097          	auipc	ra,0x2
    222e:	24a080e7          	jalr	586(ra) # 4474 <exit>

0000000000002232 <linktest>:
{
    2232:	1101                	addi	sp,sp,-32
    2234:	ec06                	sd	ra,24(sp)
    2236:	e822                	sd	s0,16(sp)
    2238:	e426                	sd	s1,8(sp)
    223a:	e04a                	sd	s2,0(sp)
    223c:	1000                	addi	s0,sp,32
    223e:	892a                	mv	s2,a0
  unlink("lf1");
    2240:	00003517          	auipc	a0,0x3
    2244:	52850513          	addi	a0,a0,1320 # 5768 <malloc+0xed4>
    2248:	00002097          	auipc	ra,0x2
    224c:	27c080e7          	jalr	636(ra) # 44c4 <unlink>
  unlink("lf2");
    2250:	00003517          	auipc	a0,0x3
    2254:	52050513          	addi	a0,a0,1312 # 5770 <malloc+0xedc>
    2258:	00002097          	auipc	ra,0x2
    225c:	26c080e7          	jalr	620(ra) # 44c4 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    2260:	20200593          	li	a1,514
    2264:	00003517          	auipc	a0,0x3
    2268:	50450513          	addi	a0,a0,1284 # 5768 <malloc+0xed4>
    226c:	00002097          	auipc	ra,0x2
    2270:	248080e7          	jalr	584(ra) # 44b4 <open>
  if(fd < 0){
    2274:	10054763          	bltz	a0,2382 <linktest+0x150>
    2278:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
    227a:	4615                	li	a2,5
    227c:	00003597          	auipc	a1,0x3
    2280:	fa458593          	addi	a1,a1,-92 # 5220 <malloc+0x98c>
    2284:	00002097          	auipc	ra,0x2
    2288:	210080e7          	jalr	528(ra) # 4494 <write>
    228c:	4795                	li	a5,5
    228e:	10f51863          	bne	a0,a5,239e <linktest+0x16c>
  close(fd);
    2292:	8526                	mv	a0,s1
    2294:	00002097          	auipc	ra,0x2
    2298:	208080e7          	jalr	520(ra) # 449c <close>
  if(link("lf1", "lf2") < 0){
    229c:	00003597          	auipc	a1,0x3
    22a0:	4d458593          	addi	a1,a1,1236 # 5770 <malloc+0xedc>
    22a4:	00003517          	auipc	a0,0x3
    22a8:	4c450513          	addi	a0,a0,1220 # 5768 <malloc+0xed4>
    22ac:	00002097          	auipc	ra,0x2
    22b0:	228080e7          	jalr	552(ra) # 44d4 <link>
    22b4:	10054363          	bltz	a0,23ba <linktest+0x188>
  unlink("lf1");
    22b8:	00003517          	auipc	a0,0x3
    22bc:	4b050513          	addi	a0,a0,1200 # 5768 <malloc+0xed4>
    22c0:	00002097          	auipc	ra,0x2
    22c4:	204080e7          	jalr	516(ra) # 44c4 <unlink>
  if(open("lf1", 0) >= 0){
    22c8:	4581                	li	a1,0
    22ca:	00003517          	auipc	a0,0x3
    22ce:	49e50513          	addi	a0,a0,1182 # 5768 <malloc+0xed4>
    22d2:	00002097          	auipc	ra,0x2
    22d6:	1e2080e7          	jalr	482(ra) # 44b4 <open>
    22da:	0e055e63          	bgez	a0,23d6 <linktest+0x1a4>
  fd = open("lf2", 0);
    22de:	4581                	li	a1,0
    22e0:	00003517          	auipc	a0,0x3
    22e4:	49050513          	addi	a0,a0,1168 # 5770 <malloc+0xedc>
    22e8:	00002097          	auipc	ra,0x2
    22ec:	1cc080e7          	jalr	460(ra) # 44b4 <open>
    22f0:	84aa                	mv	s1,a0
  if(fd < 0){
    22f2:	10054063          	bltz	a0,23f2 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
    22f6:	660d                	lui	a2,0x3
    22f8:	00008597          	auipc	a1,0x8
    22fc:	42858593          	addi	a1,a1,1064 # a720 <buf>
    2300:	00002097          	auipc	ra,0x2
    2304:	18c080e7          	jalr	396(ra) # 448c <read>
    2308:	4795                	li	a5,5
    230a:	10f51263          	bne	a0,a5,240e <linktest+0x1dc>
  close(fd);
    230e:	8526                	mv	a0,s1
    2310:	00002097          	auipc	ra,0x2
    2314:	18c080e7          	jalr	396(ra) # 449c <close>
  if(link("lf2", "lf2") >= 0){
    2318:	00003597          	auipc	a1,0x3
    231c:	45858593          	addi	a1,a1,1112 # 5770 <malloc+0xedc>
    2320:	852e                	mv	a0,a1
    2322:	00002097          	auipc	ra,0x2
    2326:	1b2080e7          	jalr	434(ra) # 44d4 <link>
    232a:	10055063          	bgez	a0,242a <linktest+0x1f8>
  unlink("lf2");
    232e:	00003517          	auipc	a0,0x3
    2332:	44250513          	addi	a0,a0,1090 # 5770 <malloc+0xedc>
    2336:	00002097          	auipc	ra,0x2
    233a:	18e080e7          	jalr	398(ra) # 44c4 <unlink>
  if(link("lf2", "lf1") >= 0){
    233e:	00003597          	auipc	a1,0x3
    2342:	42a58593          	addi	a1,a1,1066 # 5768 <malloc+0xed4>
    2346:	00003517          	auipc	a0,0x3
    234a:	42a50513          	addi	a0,a0,1066 # 5770 <malloc+0xedc>
    234e:	00002097          	auipc	ra,0x2
    2352:	186080e7          	jalr	390(ra) # 44d4 <link>
    2356:	0e055863          	bgez	a0,2446 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    235a:	00003597          	auipc	a1,0x3
    235e:	40e58593          	addi	a1,a1,1038 # 5768 <malloc+0xed4>
    2362:	00002517          	auipc	a0,0x2
    2366:	71e50513          	addi	a0,a0,1822 # 4a80 <malloc+0x1ec>
    236a:	00002097          	auipc	ra,0x2
    236e:	16a080e7          	jalr	362(ra) # 44d4 <link>
    2372:	0e055863          	bgez	a0,2462 <linktest+0x230>
}
    2376:	60e2                	ld	ra,24(sp)
    2378:	6442                	ld	s0,16(sp)
    237a:	64a2                	ld	s1,8(sp)
    237c:	6902                	ld	s2,0(sp)
    237e:	6105                	addi	sp,sp,32
    2380:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    2382:	85ca                	mv	a1,s2
    2384:	00003517          	auipc	a0,0x3
    2388:	3f450513          	addi	a0,a0,1012 # 5778 <malloc+0xee4>
    238c:	00002097          	auipc	ra,0x2
    2390:	450080e7          	jalr	1104(ra) # 47dc <printf>
    exit(1);
    2394:	4505                	li	a0,1
    2396:	00002097          	auipc	ra,0x2
    239a:	0de080e7          	jalr	222(ra) # 4474 <exit>
    printf("%s: write lf1 failed\n", s);
    239e:	85ca                	mv	a1,s2
    23a0:	00003517          	auipc	a0,0x3
    23a4:	3f050513          	addi	a0,a0,1008 # 5790 <malloc+0xefc>
    23a8:	00002097          	auipc	ra,0x2
    23ac:	434080e7          	jalr	1076(ra) # 47dc <printf>
    exit(1);
    23b0:	4505                	li	a0,1
    23b2:	00002097          	auipc	ra,0x2
    23b6:	0c2080e7          	jalr	194(ra) # 4474 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    23ba:	85ca                	mv	a1,s2
    23bc:	00003517          	auipc	a0,0x3
    23c0:	3ec50513          	addi	a0,a0,1004 # 57a8 <malloc+0xf14>
    23c4:	00002097          	auipc	ra,0x2
    23c8:	418080e7          	jalr	1048(ra) # 47dc <printf>
    exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00002097          	auipc	ra,0x2
    23d2:	0a6080e7          	jalr	166(ra) # 4474 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    23d6:	85ca                	mv	a1,s2
    23d8:	00003517          	auipc	a0,0x3
    23dc:	3f050513          	addi	a0,a0,1008 # 57c8 <malloc+0xf34>
    23e0:	00002097          	auipc	ra,0x2
    23e4:	3fc080e7          	jalr	1020(ra) # 47dc <printf>
    exit(1);
    23e8:	4505                	li	a0,1
    23ea:	00002097          	auipc	ra,0x2
    23ee:	08a080e7          	jalr	138(ra) # 4474 <exit>
    printf("%s: open lf2 failed\n", s);
    23f2:	85ca                	mv	a1,s2
    23f4:	00003517          	auipc	a0,0x3
    23f8:	40450513          	addi	a0,a0,1028 # 57f8 <malloc+0xf64>
    23fc:	00002097          	auipc	ra,0x2
    2400:	3e0080e7          	jalr	992(ra) # 47dc <printf>
    exit(1);
    2404:	4505                	li	a0,1
    2406:	00002097          	auipc	ra,0x2
    240a:	06e080e7          	jalr	110(ra) # 4474 <exit>
    printf("%s: read lf2 failed\n", s);
    240e:	85ca                	mv	a1,s2
    2410:	00003517          	auipc	a0,0x3
    2414:	40050513          	addi	a0,a0,1024 # 5810 <malloc+0xf7c>
    2418:	00002097          	auipc	ra,0x2
    241c:	3c4080e7          	jalr	964(ra) # 47dc <printf>
    exit(1);
    2420:	4505                	li	a0,1
    2422:	00002097          	auipc	ra,0x2
    2426:	052080e7          	jalr	82(ra) # 4474 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    242a:	85ca                	mv	a1,s2
    242c:	00003517          	auipc	a0,0x3
    2430:	3fc50513          	addi	a0,a0,1020 # 5828 <malloc+0xf94>
    2434:	00002097          	auipc	ra,0x2
    2438:	3a8080e7          	jalr	936(ra) # 47dc <printf>
    exit(1);
    243c:	4505                	li	a0,1
    243e:	00002097          	auipc	ra,0x2
    2442:	036080e7          	jalr	54(ra) # 4474 <exit>
    printf("%s: link non-existant succeeded! oops\n", s);
    2446:	85ca                	mv	a1,s2
    2448:	00003517          	auipc	a0,0x3
    244c:	40850513          	addi	a0,a0,1032 # 5850 <malloc+0xfbc>
    2450:	00002097          	auipc	ra,0x2
    2454:	38c080e7          	jalr	908(ra) # 47dc <printf>
    exit(1);
    2458:	4505                	li	a0,1
    245a:	00002097          	auipc	ra,0x2
    245e:	01a080e7          	jalr	26(ra) # 4474 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    2462:	85ca                	mv	a1,s2
    2464:	00003517          	auipc	a0,0x3
    2468:	41450513          	addi	a0,a0,1044 # 5878 <malloc+0xfe4>
    246c:	00002097          	auipc	ra,0x2
    2470:	370080e7          	jalr	880(ra) # 47dc <printf>
    exit(1);
    2474:	4505                	li	a0,1
    2476:	00002097          	auipc	ra,0x2
    247a:	ffe080e7          	jalr	-2(ra) # 4474 <exit>

000000000000247e <concreate>:
{
    247e:	7135                	addi	sp,sp,-160
    2480:	ed06                	sd	ra,152(sp)
    2482:	e922                	sd	s0,144(sp)
    2484:	e526                	sd	s1,136(sp)
    2486:	e14a                	sd	s2,128(sp)
    2488:	fcce                	sd	s3,120(sp)
    248a:	f8d2                	sd	s4,112(sp)
    248c:	f4d6                	sd	s5,104(sp)
    248e:	f0da                	sd	s6,96(sp)
    2490:	ecde                	sd	s7,88(sp)
    2492:	1100                	addi	s0,sp,160
    2494:	89aa                	mv	s3,a0
  file[0] = 'C';
    2496:	04300793          	li	a5,67
    249a:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    249e:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    24a2:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    24a4:	4b0d                	li	s6,3
    24a6:	4a85                	li	s5,1
      link("C0", file);
    24a8:	00003b97          	auipc	s7,0x3
    24ac:	3f0b8b93          	addi	s7,s7,1008 # 5898 <malloc+0x1004>
  for(i = 0; i < N; i++){
    24b0:	02800a13          	li	s4,40
    24b4:	a479                	j	2742 <concreate+0x2c4>
      link("C0", file);
    24b6:	fa840593          	addi	a1,s0,-88
    24ba:	855e                	mv	a0,s7
    24bc:	00002097          	auipc	ra,0x2
    24c0:	018080e7          	jalr	24(ra) # 44d4 <link>
    if(pid == 0) {
    24c4:	a495                	j	2728 <concreate+0x2aa>
    } else if(pid == 0 && (i % 5) == 1){
    24c6:	4795                	li	a5,5
    24c8:	02f9693b          	remw	s2,s2,a5
    24cc:	4785                	li	a5,1
    24ce:	02f90b63          	beq	s2,a5,2504 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    24d2:	20200593          	li	a1,514
    24d6:	fa840513          	addi	a0,s0,-88
    24da:	00002097          	auipc	ra,0x2
    24de:	fda080e7          	jalr	-38(ra) # 44b4 <open>
      if(fd < 0){
    24e2:	22055a63          	bgez	a0,2716 <concreate+0x298>
        printf("concreate create %s failed\n", file);
    24e6:	fa840593          	addi	a1,s0,-88
    24ea:	00003517          	auipc	a0,0x3
    24ee:	3b650513          	addi	a0,a0,950 # 58a0 <malloc+0x100c>
    24f2:	00002097          	auipc	ra,0x2
    24f6:	2ea080e7          	jalr	746(ra) # 47dc <printf>
        exit(1);
    24fa:	4505                	li	a0,1
    24fc:	00002097          	auipc	ra,0x2
    2500:	f78080e7          	jalr	-136(ra) # 4474 <exit>
      link("C0", file);
    2504:	fa840593          	addi	a1,s0,-88
    2508:	00003517          	auipc	a0,0x3
    250c:	39050513          	addi	a0,a0,912 # 5898 <malloc+0x1004>
    2510:	00002097          	auipc	ra,0x2
    2514:	fc4080e7          	jalr	-60(ra) # 44d4 <link>
      exit(0);
    2518:	4501                	li	a0,0
    251a:	00002097          	auipc	ra,0x2
    251e:	f5a080e7          	jalr	-166(ra) # 4474 <exit>
        exit(1);
    2522:	4505                	li	a0,1
    2524:	00002097          	auipc	ra,0x2
    2528:	f50080e7          	jalr	-176(ra) # 4474 <exit>
  memset(fa, 0, sizeof(fa));
    252c:	02800613          	li	a2,40
    2530:	4581                	li	a1,0
    2532:	f8040513          	addi	a0,s0,-128
    2536:	00002097          	auipc	ra,0x2
    253a:	d44080e7          	jalr	-700(ra) # 427a <memset>
  fd = open(".", 0);
    253e:	4581                	li	a1,0
    2540:	00002517          	auipc	a0,0x2
    2544:	54050513          	addi	a0,a0,1344 # 4a80 <malloc+0x1ec>
    2548:	00002097          	auipc	ra,0x2
    254c:	f6c080e7          	jalr	-148(ra) # 44b4 <open>
    2550:	892a                	mv	s2,a0
  n = 0;
    2552:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2554:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    2558:	02700b13          	li	s6,39
      fa[i] = 1;
    255c:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    255e:	4641                	li	a2,16
    2560:	f7040593          	addi	a1,s0,-144
    2564:	854a                	mv	a0,s2
    2566:	00002097          	auipc	ra,0x2
    256a:	f26080e7          	jalr	-218(ra) # 448c <read>
    256e:	08a05263          	blez	a0,25f2 <concreate+0x174>
    if(de.inum == 0)
    2572:	f7045783          	lhu	a5,-144(s0)
    2576:	d7e5                	beqz	a5,255e <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2578:	f7244783          	lbu	a5,-142(s0)
    257c:	ff4791e3          	bne	a5,s4,255e <concreate+0xe0>
    2580:	f7444783          	lbu	a5,-140(s0)
    2584:	ffe9                	bnez	a5,255e <concreate+0xe0>
      i = de.name[1] - '0';
    2586:	f7344783          	lbu	a5,-141(s0)
    258a:	fd07879b          	addiw	a5,a5,-48
    258e:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    2592:	02eb6063          	bltu	s6,a4,25b2 <concreate+0x134>
      if(fa[i]){
    2596:	fb070793          	addi	a5,a4,-80 # 2fb0 <subdir+0x5b6>
    259a:	97a2                	add	a5,a5,s0
    259c:	fd07c783          	lbu	a5,-48(a5)
    25a0:	eb8d                	bnez	a5,25d2 <concreate+0x154>
      fa[i] = 1;
    25a2:	fb070793          	addi	a5,a4,-80
    25a6:	00878733          	add	a4,a5,s0
    25aa:	fd770823          	sb	s7,-48(a4)
      n++;
    25ae:	2a85                	addiw	s5,s5,1
    25b0:	b77d                	j	255e <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    25b2:	f7240613          	addi	a2,s0,-142
    25b6:	85ce                	mv	a1,s3
    25b8:	00003517          	auipc	a0,0x3
    25bc:	30850513          	addi	a0,a0,776 # 58c0 <malloc+0x102c>
    25c0:	00002097          	auipc	ra,0x2
    25c4:	21c080e7          	jalr	540(ra) # 47dc <printf>
        exit(1);
    25c8:	4505                	li	a0,1
    25ca:	00002097          	auipc	ra,0x2
    25ce:	eaa080e7          	jalr	-342(ra) # 4474 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    25d2:	f7240613          	addi	a2,s0,-142
    25d6:	85ce                	mv	a1,s3
    25d8:	00003517          	auipc	a0,0x3
    25dc:	30850513          	addi	a0,a0,776 # 58e0 <malloc+0x104c>
    25e0:	00002097          	auipc	ra,0x2
    25e4:	1fc080e7          	jalr	508(ra) # 47dc <printf>
        exit(1);
    25e8:	4505                	li	a0,1
    25ea:	00002097          	auipc	ra,0x2
    25ee:	e8a080e7          	jalr	-374(ra) # 4474 <exit>
  close(fd);
    25f2:	854a                	mv	a0,s2
    25f4:	00002097          	auipc	ra,0x2
    25f8:	ea8080e7          	jalr	-344(ra) # 449c <close>
  if(n != N){
    25fc:	02800793          	li	a5,40
    2600:	00fa9763          	bne	s5,a5,260e <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    2604:	4a8d                	li	s5,3
    2606:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    2608:	02800a13          	li	s4,40
    260c:	a05d                	j	26b2 <concreate+0x234>
    printf("%s: concreate not enough files in directory listing\n", s);
    260e:	85ce                	mv	a1,s3
    2610:	00003517          	auipc	a0,0x3
    2614:	2f850513          	addi	a0,a0,760 # 5908 <malloc+0x1074>
    2618:	00002097          	auipc	ra,0x2
    261c:	1c4080e7          	jalr	452(ra) # 47dc <printf>
    exit(1);
    2620:	4505                	li	a0,1
    2622:	00002097          	auipc	ra,0x2
    2626:	e52080e7          	jalr	-430(ra) # 4474 <exit>
      printf("%s: fork failed\n", s);
    262a:	85ce                	mv	a1,s3
    262c:	00002517          	auipc	a0,0x2
    2630:	50450513          	addi	a0,a0,1284 # 4b30 <malloc+0x29c>
    2634:	00002097          	auipc	ra,0x2
    2638:	1a8080e7          	jalr	424(ra) # 47dc <printf>
      exit(1);
    263c:	4505                	li	a0,1
    263e:	00002097          	auipc	ra,0x2
    2642:	e36080e7          	jalr	-458(ra) # 4474 <exit>
      close(open(file, 0));
    2646:	4581                	li	a1,0
    2648:	fa840513          	addi	a0,s0,-88
    264c:	00002097          	auipc	ra,0x2
    2650:	e68080e7          	jalr	-408(ra) # 44b4 <open>
    2654:	00002097          	auipc	ra,0x2
    2658:	e48080e7          	jalr	-440(ra) # 449c <close>
      close(open(file, 0));
    265c:	4581                	li	a1,0
    265e:	fa840513          	addi	a0,s0,-88
    2662:	00002097          	auipc	ra,0x2
    2666:	e52080e7          	jalr	-430(ra) # 44b4 <open>
    266a:	00002097          	auipc	ra,0x2
    266e:	e32080e7          	jalr	-462(ra) # 449c <close>
      close(open(file, 0));
    2672:	4581                	li	a1,0
    2674:	fa840513          	addi	a0,s0,-88
    2678:	00002097          	auipc	ra,0x2
    267c:	e3c080e7          	jalr	-452(ra) # 44b4 <open>
    2680:	00002097          	auipc	ra,0x2
    2684:	e1c080e7          	jalr	-484(ra) # 449c <close>
      close(open(file, 0));
    2688:	4581                	li	a1,0
    268a:	fa840513          	addi	a0,s0,-88
    268e:	00002097          	auipc	ra,0x2
    2692:	e26080e7          	jalr	-474(ra) # 44b4 <open>
    2696:	00002097          	auipc	ra,0x2
    269a:	e06080e7          	jalr	-506(ra) # 449c <close>
    if(pid == 0)
    269e:	06090763          	beqz	s2,270c <concreate+0x28e>
      wait(0);
    26a2:	4501                	li	a0,0
    26a4:	00002097          	auipc	ra,0x2
    26a8:	dd8080e7          	jalr	-552(ra) # 447c <wait>
  for(i = 0; i < N; i++){
    26ac:	2485                	addiw	s1,s1,1
    26ae:	0d448963          	beq	s1,s4,2780 <concreate+0x302>
    file[1] = '0' + i;
    26b2:	0304879b          	addiw	a5,s1,48
    26b6:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    26ba:	00002097          	auipc	ra,0x2
    26be:	db2080e7          	jalr	-590(ra) # 446c <fork>
    26c2:	892a                	mv	s2,a0
    if(pid < 0){
    26c4:	f60543e3          	bltz	a0,262a <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    26c8:	0354e73b          	remw	a4,s1,s5
    26cc:	00a767b3          	or	a5,a4,a0
    26d0:	2781                	sext.w	a5,a5
    26d2:	dbb5                	beqz	a5,2646 <concreate+0x1c8>
    26d4:	01671363          	bne	a4,s6,26da <concreate+0x25c>
       ((i % 3) == 1 && pid != 0)){
    26d8:	f53d                	bnez	a0,2646 <concreate+0x1c8>
      unlink(file);
    26da:	fa840513          	addi	a0,s0,-88
    26de:	00002097          	auipc	ra,0x2
    26e2:	de6080e7          	jalr	-538(ra) # 44c4 <unlink>
      unlink(file);
    26e6:	fa840513          	addi	a0,s0,-88
    26ea:	00002097          	auipc	ra,0x2
    26ee:	dda080e7          	jalr	-550(ra) # 44c4 <unlink>
      unlink(file);
    26f2:	fa840513          	addi	a0,s0,-88
    26f6:	00002097          	auipc	ra,0x2
    26fa:	dce080e7          	jalr	-562(ra) # 44c4 <unlink>
      unlink(file);
    26fe:	fa840513          	addi	a0,s0,-88
    2702:	00002097          	auipc	ra,0x2
    2706:	dc2080e7          	jalr	-574(ra) # 44c4 <unlink>
    270a:	bf51                	j	269e <concreate+0x220>
      exit(0);
    270c:	4501                	li	a0,0
    270e:	00002097          	auipc	ra,0x2
    2712:	d66080e7          	jalr	-666(ra) # 4474 <exit>
      close(fd);
    2716:	00002097          	auipc	ra,0x2
    271a:	d86080e7          	jalr	-634(ra) # 449c <close>
    if(pid == 0) {
    271e:	bbed                	j	2518 <concreate+0x9a>
      close(fd);
    2720:	00002097          	auipc	ra,0x2
    2724:	d7c080e7          	jalr	-644(ra) # 449c <close>
      wait(&xstatus);
    2728:	f6c40513          	addi	a0,s0,-148
    272c:	00002097          	auipc	ra,0x2
    2730:	d50080e7          	jalr	-688(ra) # 447c <wait>
      if(xstatus != 0)
    2734:	f6c42483          	lw	s1,-148(s0)
    2738:	de0495e3          	bnez	s1,2522 <concreate+0xa4>
  for(i = 0; i < N; i++){
    273c:	2905                	addiw	s2,s2,1
    273e:	df4907e3          	beq	s2,s4,252c <concreate+0xae>
    file[1] = '0' + i;
    2742:	0309079b          	addiw	a5,s2,48
    2746:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    274a:	fa840513          	addi	a0,s0,-88
    274e:	00002097          	auipc	ra,0x2
    2752:	d76080e7          	jalr	-650(ra) # 44c4 <unlink>
    pid = fork();
    2756:	00002097          	auipc	ra,0x2
    275a:	d16080e7          	jalr	-746(ra) # 446c <fork>
    if(pid && (i % 3) == 1){
    275e:	d60504e3          	beqz	a0,24c6 <concreate+0x48>
    2762:	036967bb          	remw	a5,s2,s6
    2766:	d55788e3          	beq	a5,s5,24b6 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    276a:	20200593          	li	a1,514
    276e:	fa840513          	addi	a0,s0,-88
    2772:	00002097          	auipc	ra,0x2
    2776:	d42080e7          	jalr	-702(ra) # 44b4 <open>
      if(fd < 0){
    277a:	fa0553e3          	bgez	a0,2720 <concreate+0x2a2>
    277e:	b3a5                	j	24e6 <concreate+0x68>
}
    2780:	60ea                	ld	ra,152(sp)
    2782:	644a                	ld	s0,144(sp)
    2784:	64aa                	ld	s1,136(sp)
    2786:	690a                	ld	s2,128(sp)
    2788:	79e6                	ld	s3,120(sp)
    278a:	7a46                	ld	s4,112(sp)
    278c:	7aa6                	ld	s5,104(sp)
    278e:	7b06                	ld	s6,96(sp)
    2790:	6be6                	ld	s7,88(sp)
    2792:	610d                	addi	sp,sp,160
    2794:	8082                	ret

0000000000002796 <linkunlink>:
{
    2796:	711d                	addi	sp,sp,-96
    2798:	ec86                	sd	ra,88(sp)
    279a:	e8a2                	sd	s0,80(sp)
    279c:	e4a6                	sd	s1,72(sp)
    279e:	e0ca                	sd	s2,64(sp)
    27a0:	fc4e                	sd	s3,56(sp)
    27a2:	f852                	sd	s4,48(sp)
    27a4:	f456                	sd	s5,40(sp)
    27a6:	f05a                	sd	s6,32(sp)
    27a8:	ec5e                	sd	s7,24(sp)
    27aa:	e862                	sd	s8,16(sp)
    27ac:	e466                	sd	s9,8(sp)
    27ae:	1080                	addi	s0,sp,96
    27b0:	84aa                	mv	s1,a0
  unlink("x");
    27b2:	00003517          	auipc	a0,0x3
    27b6:	d4e50513          	addi	a0,a0,-690 # 5500 <malloc+0xc6c>
    27ba:	00002097          	auipc	ra,0x2
    27be:	d0a080e7          	jalr	-758(ra) # 44c4 <unlink>
  pid = fork();
    27c2:	00002097          	auipc	ra,0x2
    27c6:	caa080e7          	jalr	-854(ra) # 446c <fork>
  if(pid < 0){
    27ca:	02054b63          	bltz	a0,2800 <linkunlink+0x6a>
    27ce:	8caa                	mv	s9,a0
  unsigned int x = (pid ? 1 : 97);
    27d0:	06100913          	li	s2,97
    27d4:	c111                	beqz	a0,27d8 <linkunlink+0x42>
    27d6:	4905                	li	s2,1
    27d8:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    27dc:	41c65a37          	lui	s4,0x41c65
    27e0:	e6da0a1b          	addiw	s4,s4,-403 # 41c64e6d <base+0x41c5774d>
    27e4:	698d                	lui	s3,0x3
    27e6:	0399899b          	addiw	s3,s3,57 # 3039 <subdir+0x63f>
    if((x % 3) == 0){
    27ea:	4a8d                	li	s5,3
    } else if((x % 3) == 1){
    27ec:	4b85                	li	s7,1
      unlink("x");
    27ee:	00003b17          	auipc	s6,0x3
    27f2:	d12b0b13          	addi	s6,s6,-750 # 5500 <malloc+0xc6c>
      link("cat", "x");
    27f6:	00003c17          	auipc	s8,0x3
    27fa:	14ac0c13          	addi	s8,s8,330 # 5940 <malloc+0x10ac>
    27fe:	a825                	j	2836 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    2800:	85a6                	mv	a1,s1
    2802:	00002517          	auipc	a0,0x2
    2806:	32e50513          	addi	a0,a0,814 # 4b30 <malloc+0x29c>
    280a:	00002097          	auipc	ra,0x2
    280e:	fd2080e7          	jalr	-46(ra) # 47dc <printf>
    exit(1);
    2812:	4505                	li	a0,1
    2814:	00002097          	auipc	ra,0x2
    2818:	c60080e7          	jalr	-928(ra) # 4474 <exit>
      close(open("x", O_RDWR | O_CREATE));
    281c:	20200593          	li	a1,514
    2820:	855a                	mv	a0,s6
    2822:	00002097          	auipc	ra,0x2
    2826:	c92080e7          	jalr	-878(ra) # 44b4 <open>
    282a:	00002097          	auipc	ra,0x2
    282e:	c72080e7          	jalr	-910(ra) # 449c <close>
  for(i = 0; i < 100; i++){
    2832:	34fd                	addiw	s1,s1,-1
    2834:	c895                	beqz	s1,2868 <linkunlink+0xd2>
    x = x * 1103515245 + 12345;
    2836:	034907bb          	mulw	a5,s2,s4
    283a:	013787bb          	addw	a5,a5,s3
    283e:	0007891b          	sext.w	s2,a5
    if((x % 3) == 0){
    2842:	0357f7bb          	remuw	a5,a5,s5
    2846:	2781                	sext.w	a5,a5
    2848:	dbf1                	beqz	a5,281c <linkunlink+0x86>
    } else if((x % 3) == 1){
    284a:	01778863          	beq	a5,s7,285a <linkunlink+0xc4>
      unlink("x");
    284e:	855a                	mv	a0,s6
    2850:	00002097          	auipc	ra,0x2
    2854:	c74080e7          	jalr	-908(ra) # 44c4 <unlink>
    2858:	bfe9                	j	2832 <linkunlink+0x9c>
      link("cat", "x");
    285a:	85da                	mv	a1,s6
    285c:	8562                	mv	a0,s8
    285e:	00002097          	auipc	ra,0x2
    2862:	c76080e7          	jalr	-906(ra) # 44d4 <link>
    2866:	b7f1                	j	2832 <linkunlink+0x9c>
  if(pid)
    2868:	020c8463          	beqz	s9,2890 <linkunlink+0xfa>
    wait(0);
    286c:	4501                	li	a0,0
    286e:	00002097          	auipc	ra,0x2
    2872:	c0e080e7          	jalr	-1010(ra) # 447c <wait>
}
    2876:	60e6                	ld	ra,88(sp)
    2878:	6446                	ld	s0,80(sp)
    287a:	64a6                	ld	s1,72(sp)
    287c:	6906                	ld	s2,64(sp)
    287e:	79e2                	ld	s3,56(sp)
    2880:	7a42                	ld	s4,48(sp)
    2882:	7aa2                	ld	s5,40(sp)
    2884:	7b02                	ld	s6,32(sp)
    2886:	6be2                	ld	s7,24(sp)
    2888:	6c42                	ld	s8,16(sp)
    288a:	6ca2                	ld	s9,8(sp)
    288c:	6125                	addi	sp,sp,96
    288e:	8082                	ret
    exit(0);
    2890:	4501                	li	a0,0
    2892:	00002097          	auipc	ra,0x2
    2896:	be2080e7          	jalr	-1054(ra) # 4474 <exit>

000000000000289a <bigdir>:
{
    289a:	715d                	addi	sp,sp,-80
    289c:	e486                	sd	ra,72(sp)
    289e:	e0a2                	sd	s0,64(sp)
    28a0:	fc26                	sd	s1,56(sp)
    28a2:	f84a                	sd	s2,48(sp)
    28a4:	f44e                	sd	s3,40(sp)
    28a6:	f052                	sd	s4,32(sp)
    28a8:	ec56                	sd	s5,24(sp)
    28aa:	e85a                	sd	s6,16(sp)
    28ac:	0880                	addi	s0,sp,80
    28ae:	89aa                	mv	s3,a0
  unlink("bd");
    28b0:	00003517          	auipc	a0,0x3
    28b4:	09850513          	addi	a0,a0,152 # 5948 <malloc+0x10b4>
    28b8:	00002097          	auipc	ra,0x2
    28bc:	c0c080e7          	jalr	-1012(ra) # 44c4 <unlink>
  fd = open("bd", O_CREATE);
    28c0:	20000593          	li	a1,512
    28c4:	00003517          	auipc	a0,0x3
    28c8:	08450513          	addi	a0,a0,132 # 5948 <malloc+0x10b4>
    28cc:	00002097          	auipc	ra,0x2
    28d0:	be8080e7          	jalr	-1048(ra) # 44b4 <open>
  if(fd < 0){
    28d4:	0c054963          	bltz	a0,29a6 <bigdir+0x10c>
  close(fd);
    28d8:	00002097          	auipc	ra,0x2
    28dc:	bc4080e7          	jalr	-1084(ra) # 449c <close>
  for(i = 0; i < N; i++){
    28e0:	4901                	li	s2,0
    name[0] = 'x';
    28e2:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    28e6:	00003a17          	auipc	s4,0x3
    28ea:	062a0a13          	addi	s4,s4,98 # 5948 <malloc+0x10b4>
  for(i = 0; i < N; i++){
    28ee:	1f400b13          	li	s6,500
    name[0] = 'x';
    28f2:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    28f6:	41f9571b          	sraiw	a4,s2,0x1f
    28fa:	01a7571b          	srliw	a4,a4,0x1a
    28fe:	012707bb          	addw	a5,a4,s2
    2902:	4067d69b          	sraiw	a3,a5,0x6
    2906:	0306869b          	addiw	a3,a3,48
    290a:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    290e:	03f7f793          	andi	a5,a5,63
    2912:	9f99                	subw	a5,a5,a4
    2914:	0307879b          	addiw	a5,a5,48
    2918:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    291c:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    2920:	fb040593          	addi	a1,s0,-80
    2924:	8552                	mv	a0,s4
    2926:	00002097          	auipc	ra,0x2
    292a:	bae080e7          	jalr	-1106(ra) # 44d4 <link>
    292e:	84aa                	mv	s1,a0
    2930:	e949                	bnez	a0,29c2 <bigdir+0x128>
  for(i = 0; i < N; i++){
    2932:	2905                	addiw	s2,s2,1
    2934:	fb691fe3          	bne	s2,s6,28f2 <bigdir+0x58>
  unlink("bd");
    2938:	00003517          	auipc	a0,0x3
    293c:	01050513          	addi	a0,a0,16 # 5948 <malloc+0x10b4>
    2940:	00002097          	auipc	ra,0x2
    2944:	b84080e7          	jalr	-1148(ra) # 44c4 <unlink>
    name[0] = 'x';
    2948:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    294c:	1f400a13          	li	s4,500
    name[0] = 'x';
    2950:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    2954:	41f4d71b          	sraiw	a4,s1,0x1f
    2958:	01a7571b          	srliw	a4,a4,0x1a
    295c:	009707bb          	addw	a5,a4,s1
    2960:	4067d69b          	sraiw	a3,a5,0x6
    2964:	0306869b          	addiw	a3,a3,48
    2968:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    296c:	03f7f793          	andi	a5,a5,63
    2970:	9f99                	subw	a5,a5,a4
    2972:	0307879b          	addiw	a5,a5,48
    2976:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    297a:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    297e:	fb040513          	addi	a0,s0,-80
    2982:	00002097          	auipc	ra,0x2
    2986:	b42080e7          	jalr	-1214(ra) # 44c4 <unlink>
    298a:	e931                	bnez	a0,29de <bigdir+0x144>
  for(i = 0; i < N; i++){
    298c:	2485                	addiw	s1,s1,1
    298e:	fd4491e3          	bne	s1,s4,2950 <bigdir+0xb6>
}
    2992:	60a6                	ld	ra,72(sp)
    2994:	6406                	ld	s0,64(sp)
    2996:	74e2                	ld	s1,56(sp)
    2998:	7942                	ld	s2,48(sp)
    299a:	79a2                	ld	s3,40(sp)
    299c:	7a02                	ld	s4,32(sp)
    299e:	6ae2                	ld	s5,24(sp)
    29a0:	6b42                	ld	s6,16(sp)
    29a2:	6161                	addi	sp,sp,80
    29a4:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    29a6:	85ce                	mv	a1,s3
    29a8:	00003517          	auipc	a0,0x3
    29ac:	fa850513          	addi	a0,a0,-88 # 5950 <malloc+0x10bc>
    29b0:	00002097          	auipc	ra,0x2
    29b4:	e2c080e7          	jalr	-468(ra) # 47dc <printf>
    exit(1);
    29b8:	4505                	li	a0,1
    29ba:	00002097          	auipc	ra,0x2
    29be:	aba080e7          	jalr	-1350(ra) # 4474 <exit>
      printf("%s: bigdir link failed\n", s);
    29c2:	85ce                	mv	a1,s3
    29c4:	00003517          	auipc	a0,0x3
    29c8:	fac50513          	addi	a0,a0,-84 # 5970 <malloc+0x10dc>
    29cc:	00002097          	auipc	ra,0x2
    29d0:	e10080e7          	jalr	-496(ra) # 47dc <printf>
      exit(1);
    29d4:	4505                	li	a0,1
    29d6:	00002097          	auipc	ra,0x2
    29da:	a9e080e7          	jalr	-1378(ra) # 4474 <exit>
      printf("%s: bigdir unlink failed", s);
    29de:	85ce                	mv	a1,s3
    29e0:	00003517          	auipc	a0,0x3
    29e4:	fa850513          	addi	a0,a0,-88 # 5988 <malloc+0x10f4>
    29e8:	00002097          	auipc	ra,0x2
    29ec:	df4080e7          	jalr	-524(ra) # 47dc <printf>
      exit(1);
    29f0:	4505                	li	a0,1
    29f2:	00002097          	auipc	ra,0x2
    29f6:	a82080e7          	jalr	-1406(ra) # 4474 <exit>

00000000000029fa <subdir>:
{
    29fa:	1101                	addi	sp,sp,-32
    29fc:	ec06                	sd	ra,24(sp)
    29fe:	e822                	sd	s0,16(sp)
    2a00:	e426                	sd	s1,8(sp)
    2a02:	e04a                	sd	s2,0(sp)
    2a04:	1000                	addi	s0,sp,32
    2a06:	892a                	mv	s2,a0
  unlink("ff");
    2a08:	00003517          	auipc	a0,0x3
    2a0c:	0d050513          	addi	a0,a0,208 # 5ad8 <malloc+0x1244>
    2a10:	00002097          	auipc	ra,0x2
    2a14:	ab4080e7          	jalr	-1356(ra) # 44c4 <unlink>
  if(mkdir("dd") != 0){
    2a18:	00003517          	auipc	a0,0x3
    2a1c:	f9050513          	addi	a0,a0,-112 # 59a8 <malloc+0x1114>
    2a20:	00002097          	auipc	ra,0x2
    2a24:	abc080e7          	jalr	-1348(ra) # 44dc <mkdir>
    2a28:	38051663          	bnez	a0,2db4 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2a2c:	20200593          	li	a1,514
    2a30:	00003517          	auipc	a0,0x3
    2a34:	f9850513          	addi	a0,a0,-104 # 59c8 <malloc+0x1134>
    2a38:	00002097          	auipc	ra,0x2
    2a3c:	a7c080e7          	jalr	-1412(ra) # 44b4 <open>
    2a40:	84aa                	mv	s1,a0
  if(fd < 0){
    2a42:	38054763          	bltz	a0,2dd0 <subdir+0x3d6>
  write(fd, "ff", 2);
    2a46:	4609                	li	a2,2
    2a48:	00003597          	auipc	a1,0x3
    2a4c:	09058593          	addi	a1,a1,144 # 5ad8 <malloc+0x1244>
    2a50:	00002097          	auipc	ra,0x2
    2a54:	a44080e7          	jalr	-1468(ra) # 4494 <write>
  close(fd);
    2a58:	8526                	mv	a0,s1
    2a5a:	00002097          	auipc	ra,0x2
    2a5e:	a42080e7          	jalr	-1470(ra) # 449c <close>
  if(unlink("dd") >= 0){
    2a62:	00003517          	auipc	a0,0x3
    2a66:	f4650513          	addi	a0,a0,-186 # 59a8 <malloc+0x1114>
    2a6a:	00002097          	auipc	ra,0x2
    2a6e:	a5a080e7          	jalr	-1446(ra) # 44c4 <unlink>
    2a72:	36055d63          	bgez	a0,2dec <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    2a76:	00003517          	auipc	a0,0x3
    2a7a:	faa50513          	addi	a0,a0,-86 # 5a20 <malloc+0x118c>
    2a7e:	00002097          	auipc	ra,0x2
    2a82:	a5e080e7          	jalr	-1442(ra) # 44dc <mkdir>
    2a86:	38051163          	bnez	a0,2e08 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2a8a:	20200593          	li	a1,514
    2a8e:	00003517          	auipc	a0,0x3
    2a92:	fba50513          	addi	a0,a0,-70 # 5a48 <malloc+0x11b4>
    2a96:	00002097          	auipc	ra,0x2
    2a9a:	a1e080e7          	jalr	-1506(ra) # 44b4 <open>
    2a9e:	84aa                	mv	s1,a0
  if(fd < 0){
    2aa0:	38054263          	bltz	a0,2e24 <subdir+0x42a>
  write(fd, "FF", 2);
    2aa4:	4609                	li	a2,2
    2aa6:	00003597          	auipc	a1,0x3
    2aaa:	fd258593          	addi	a1,a1,-46 # 5a78 <malloc+0x11e4>
    2aae:	00002097          	auipc	ra,0x2
    2ab2:	9e6080e7          	jalr	-1562(ra) # 4494 <write>
  close(fd);
    2ab6:	8526                	mv	a0,s1
    2ab8:	00002097          	auipc	ra,0x2
    2abc:	9e4080e7          	jalr	-1564(ra) # 449c <close>
  fd = open("dd/dd/../ff", 0);
    2ac0:	4581                	li	a1,0
    2ac2:	00003517          	auipc	a0,0x3
    2ac6:	fbe50513          	addi	a0,a0,-66 # 5a80 <malloc+0x11ec>
    2aca:	00002097          	auipc	ra,0x2
    2ace:	9ea080e7          	jalr	-1558(ra) # 44b4 <open>
    2ad2:	84aa                	mv	s1,a0
  if(fd < 0){
    2ad4:	36054663          	bltz	a0,2e40 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    2ad8:	660d                	lui	a2,0x3
    2ada:	00008597          	auipc	a1,0x8
    2ade:	c4658593          	addi	a1,a1,-954 # a720 <buf>
    2ae2:	00002097          	auipc	ra,0x2
    2ae6:	9aa080e7          	jalr	-1622(ra) # 448c <read>
  if(cc != 2 || buf[0] != 'f'){
    2aea:	4789                	li	a5,2
    2aec:	36f51863          	bne	a0,a5,2e5c <subdir+0x462>
    2af0:	00008717          	auipc	a4,0x8
    2af4:	c3074703          	lbu	a4,-976(a4) # a720 <buf>
    2af8:	06600793          	li	a5,102
    2afc:	36f71063          	bne	a4,a5,2e5c <subdir+0x462>
  close(fd);
    2b00:	8526                	mv	a0,s1
    2b02:	00002097          	auipc	ra,0x2
    2b06:	99a080e7          	jalr	-1638(ra) # 449c <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2b0a:	00003597          	auipc	a1,0x3
    2b0e:	fc658593          	addi	a1,a1,-58 # 5ad0 <malloc+0x123c>
    2b12:	00003517          	auipc	a0,0x3
    2b16:	f3650513          	addi	a0,a0,-202 # 5a48 <malloc+0x11b4>
    2b1a:	00002097          	auipc	ra,0x2
    2b1e:	9ba080e7          	jalr	-1606(ra) # 44d4 <link>
    2b22:	34051b63          	bnez	a0,2e78 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    2b26:	00003517          	auipc	a0,0x3
    2b2a:	f2250513          	addi	a0,a0,-222 # 5a48 <malloc+0x11b4>
    2b2e:	00002097          	auipc	ra,0x2
    2b32:	996080e7          	jalr	-1642(ra) # 44c4 <unlink>
    2b36:	34051f63          	bnez	a0,2e94 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2b3a:	4581                	li	a1,0
    2b3c:	00003517          	auipc	a0,0x3
    2b40:	f0c50513          	addi	a0,a0,-244 # 5a48 <malloc+0x11b4>
    2b44:	00002097          	auipc	ra,0x2
    2b48:	970080e7          	jalr	-1680(ra) # 44b4 <open>
    2b4c:	36055263          	bgez	a0,2eb0 <subdir+0x4b6>
  if(chdir("dd") != 0){
    2b50:	00003517          	auipc	a0,0x3
    2b54:	e5850513          	addi	a0,a0,-424 # 59a8 <malloc+0x1114>
    2b58:	00002097          	auipc	ra,0x2
    2b5c:	98c080e7          	jalr	-1652(ra) # 44e4 <chdir>
    2b60:	36051663          	bnez	a0,2ecc <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    2b64:	00003517          	auipc	a0,0x3
    2b68:	00450513          	addi	a0,a0,4 # 5b68 <malloc+0x12d4>
    2b6c:	00002097          	auipc	ra,0x2
    2b70:	978080e7          	jalr	-1672(ra) # 44e4 <chdir>
    2b74:	36051a63          	bnez	a0,2ee8 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    2b78:	00003517          	auipc	a0,0x3
    2b7c:	02050513          	addi	a0,a0,32 # 5b98 <malloc+0x1304>
    2b80:	00002097          	auipc	ra,0x2
    2b84:	964080e7          	jalr	-1692(ra) # 44e4 <chdir>
    2b88:	36051e63          	bnez	a0,2f04 <subdir+0x50a>
  if(chdir("./..") != 0){
    2b8c:	00003517          	auipc	a0,0x3
    2b90:	03c50513          	addi	a0,a0,60 # 5bc8 <malloc+0x1334>
    2b94:	00002097          	auipc	ra,0x2
    2b98:	950080e7          	jalr	-1712(ra) # 44e4 <chdir>
    2b9c:	38051263          	bnez	a0,2f20 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    2ba0:	4581                	li	a1,0
    2ba2:	00003517          	auipc	a0,0x3
    2ba6:	f2e50513          	addi	a0,a0,-210 # 5ad0 <malloc+0x123c>
    2baa:	00002097          	auipc	ra,0x2
    2bae:	90a080e7          	jalr	-1782(ra) # 44b4 <open>
    2bb2:	84aa                	mv	s1,a0
  if(fd < 0){
    2bb4:	38054463          	bltz	a0,2f3c <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    2bb8:	660d                	lui	a2,0x3
    2bba:	00008597          	auipc	a1,0x8
    2bbe:	b6658593          	addi	a1,a1,-1178 # a720 <buf>
    2bc2:	00002097          	auipc	ra,0x2
    2bc6:	8ca080e7          	jalr	-1846(ra) # 448c <read>
    2bca:	4789                	li	a5,2
    2bcc:	38f51663          	bne	a0,a5,2f58 <subdir+0x55e>
  close(fd);
    2bd0:	8526                	mv	a0,s1
    2bd2:	00002097          	auipc	ra,0x2
    2bd6:	8ca080e7          	jalr	-1846(ra) # 449c <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2bda:	4581                	li	a1,0
    2bdc:	00003517          	auipc	a0,0x3
    2be0:	e6c50513          	addi	a0,a0,-404 # 5a48 <malloc+0x11b4>
    2be4:	00002097          	auipc	ra,0x2
    2be8:	8d0080e7          	jalr	-1840(ra) # 44b4 <open>
    2bec:	38055463          	bgez	a0,2f74 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2bf0:	20200593          	li	a1,514
    2bf4:	00003517          	auipc	a0,0x3
    2bf8:	06450513          	addi	a0,a0,100 # 5c58 <malloc+0x13c4>
    2bfc:	00002097          	auipc	ra,0x2
    2c00:	8b8080e7          	jalr	-1864(ra) # 44b4 <open>
    2c04:	38055663          	bgez	a0,2f90 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2c08:	20200593          	li	a1,514
    2c0c:	00003517          	auipc	a0,0x3
    2c10:	07c50513          	addi	a0,a0,124 # 5c88 <malloc+0x13f4>
    2c14:	00002097          	auipc	ra,0x2
    2c18:	8a0080e7          	jalr	-1888(ra) # 44b4 <open>
    2c1c:	38055863          	bgez	a0,2fac <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    2c20:	20000593          	li	a1,512
    2c24:	00003517          	auipc	a0,0x3
    2c28:	d8450513          	addi	a0,a0,-636 # 59a8 <malloc+0x1114>
    2c2c:	00002097          	auipc	ra,0x2
    2c30:	888080e7          	jalr	-1912(ra) # 44b4 <open>
    2c34:	38055a63          	bgez	a0,2fc8 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    2c38:	4589                	li	a1,2
    2c3a:	00003517          	auipc	a0,0x3
    2c3e:	d6e50513          	addi	a0,a0,-658 # 59a8 <malloc+0x1114>
    2c42:	00002097          	auipc	ra,0x2
    2c46:	872080e7          	jalr	-1934(ra) # 44b4 <open>
    2c4a:	38055d63          	bgez	a0,2fe4 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    2c4e:	4585                	li	a1,1
    2c50:	00003517          	auipc	a0,0x3
    2c54:	d5850513          	addi	a0,a0,-680 # 59a8 <malloc+0x1114>
    2c58:	00002097          	auipc	ra,0x2
    2c5c:	85c080e7          	jalr	-1956(ra) # 44b4 <open>
    2c60:	3a055063          	bgez	a0,3000 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2c64:	00003597          	auipc	a1,0x3
    2c68:	0b458593          	addi	a1,a1,180 # 5d18 <malloc+0x1484>
    2c6c:	00003517          	auipc	a0,0x3
    2c70:	fec50513          	addi	a0,a0,-20 # 5c58 <malloc+0x13c4>
    2c74:	00002097          	auipc	ra,0x2
    2c78:	860080e7          	jalr	-1952(ra) # 44d4 <link>
    2c7c:	3a050063          	beqz	a0,301c <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2c80:	00003597          	auipc	a1,0x3
    2c84:	09858593          	addi	a1,a1,152 # 5d18 <malloc+0x1484>
    2c88:	00003517          	auipc	a0,0x3
    2c8c:	00050513          	mv	a0,a0
    2c90:	00002097          	auipc	ra,0x2
    2c94:	844080e7          	jalr	-1980(ra) # 44d4 <link>
    2c98:	3a050063          	beqz	a0,3038 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2c9c:	00003597          	auipc	a1,0x3
    2ca0:	e3458593          	addi	a1,a1,-460 # 5ad0 <malloc+0x123c>
    2ca4:	00003517          	auipc	a0,0x3
    2ca8:	d2450513          	addi	a0,a0,-732 # 59c8 <malloc+0x1134>
    2cac:	00002097          	auipc	ra,0x2
    2cb0:	828080e7          	jalr	-2008(ra) # 44d4 <link>
    2cb4:	3a050063          	beqz	a0,3054 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    2cb8:	00003517          	auipc	a0,0x3
    2cbc:	fa050513          	addi	a0,a0,-96 # 5c58 <malloc+0x13c4>
    2cc0:	00002097          	auipc	ra,0x2
    2cc4:	81c080e7          	jalr	-2020(ra) # 44dc <mkdir>
    2cc8:	3a050463          	beqz	a0,3070 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    2ccc:	00003517          	auipc	a0,0x3
    2cd0:	fbc50513          	addi	a0,a0,-68 # 5c88 <malloc+0x13f4>
    2cd4:	00002097          	auipc	ra,0x2
    2cd8:	808080e7          	jalr	-2040(ra) # 44dc <mkdir>
    2cdc:	3a050863          	beqz	a0,308c <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    2ce0:	00003517          	auipc	a0,0x3
    2ce4:	df050513          	addi	a0,a0,-528 # 5ad0 <malloc+0x123c>
    2ce8:	00001097          	auipc	ra,0x1
    2cec:	7f4080e7          	jalr	2036(ra) # 44dc <mkdir>
    2cf0:	3a050c63          	beqz	a0,30a8 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    2cf4:	00003517          	auipc	a0,0x3
    2cf8:	f9450513          	addi	a0,a0,-108 # 5c88 <malloc+0x13f4>
    2cfc:	00001097          	auipc	ra,0x1
    2d00:	7c8080e7          	jalr	1992(ra) # 44c4 <unlink>
    2d04:	3c050063          	beqz	a0,30c4 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    2d08:	00003517          	auipc	a0,0x3
    2d0c:	f5050513          	addi	a0,a0,-176 # 5c58 <malloc+0x13c4>
    2d10:	00001097          	auipc	ra,0x1
    2d14:	7b4080e7          	jalr	1972(ra) # 44c4 <unlink>
    2d18:	3c050463          	beqz	a0,30e0 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    2d1c:	00003517          	auipc	a0,0x3
    2d20:	cac50513          	addi	a0,a0,-852 # 59c8 <malloc+0x1134>
    2d24:	00001097          	auipc	ra,0x1
    2d28:	7c0080e7          	jalr	1984(ra) # 44e4 <chdir>
    2d2c:	3c050863          	beqz	a0,30fc <subdir+0x702>
  if(chdir("dd/xx") == 0){
    2d30:	00003517          	auipc	a0,0x3
    2d34:	13850513          	addi	a0,a0,312 # 5e68 <malloc+0x15d4>
    2d38:	00001097          	auipc	ra,0x1
    2d3c:	7ac080e7          	jalr	1964(ra) # 44e4 <chdir>
    2d40:	3c050c63          	beqz	a0,3118 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    2d44:	00003517          	auipc	a0,0x3
    2d48:	d8c50513          	addi	a0,a0,-628 # 5ad0 <malloc+0x123c>
    2d4c:	00001097          	auipc	ra,0x1
    2d50:	778080e7          	jalr	1912(ra) # 44c4 <unlink>
    2d54:	3e051063          	bnez	a0,3134 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    2d58:	00003517          	auipc	a0,0x3
    2d5c:	c7050513          	addi	a0,a0,-912 # 59c8 <malloc+0x1134>
    2d60:	00001097          	auipc	ra,0x1
    2d64:	764080e7          	jalr	1892(ra) # 44c4 <unlink>
    2d68:	3e051463          	bnez	a0,3150 <subdir+0x756>
  if(unlink("dd") == 0){
    2d6c:	00003517          	auipc	a0,0x3
    2d70:	c3c50513          	addi	a0,a0,-964 # 59a8 <malloc+0x1114>
    2d74:	00001097          	auipc	ra,0x1
    2d78:	750080e7          	jalr	1872(ra) # 44c4 <unlink>
    2d7c:	3e050863          	beqz	a0,316c <subdir+0x772>
  if(unlink("dd/dd") < 0){
    2d80:	00003517          	auipc	a0,0x3
    2d84:	15850513          	addi	a0,a0,344 # 5ed8 <malloc+0x1644>
    2d88:	00001097          	auipc	ra,0x1
    2d8c:	73c080e7          	jalr	1852(ra) # 44c4 <unlink>
    2d90:	3e054c63          	bltz	a0,3188 <subdir+0x78e>
  if(unlink("dd") < 0){
    2d94:	00003517          	auipc	a0,0x3
    2d98:	c1450513          	addi	a0,a0,-1004 # 59a8 <malloc+0x1114>
    2d9c:	00001097          	auipc	ra,0x1
    2da0:	728080e7          	jalr	1832(ra) # 44c4 <unlink>
    2da4:	40054063          	bltz	a0,31a4 <subdir+0x7aa>
}
    2da8:	60e2                	ld	ra,24(sp)
    2daa:	6442                	ld	s0,16(sp)
    2dac:	64a2                	ld	s1,8(sp)
    2dae:	6902                	ld	s2,0(sp)
    2db0:	6105                	addi	sp,sp,32
    2db2:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2db4:	85ca                	mv	a1,s2
    2db6:	00003517          	auipc	a0,0x3
    2dba:	bfa50513          	addi	a0,a0,-1030 # 59b0 <malloc+0x111c>
    2dbe:	00002097          	auipc	ra,0x2
    2dc2:	a1e080e7          	jalr	-1506(ra) # 47dc <printf>
    exit(1);
    2dc6:	4505                	li	a0,1
    2dc8:	00001097          	auipc	ra,0x1
    2dcc:	6ac080e7          	jalr	1708(ra) # 4474 <exit>
    printf("%s: create dd/ff failed\n", s);
    2dd0:	85ca                	mv	a1,s2
    2dd2:	00003517          	auipc	a0,0x3
    2dd6:	bfe50513          	addi	a0,a0,-1026 # 59d0 <malloc+0x113c>
    2dda:	00002097          	auipc	ra,0x2
    2dde:	a02080e7          	jalr	-1534(ra) # 47dc <printf>
    exit(1);
    2de2:	4505                	li	a0,1
    2de4:	00001097          	auipc	ra,0x1
    2de8:	690080e7          	jalr	1680(ra) # 4474 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2dec:	85ca                	mv	a1,s2
    2dee:	00003517          	auipc	a0,0x3
    2df2:	c0250513          	addi	a0,a0,-1022 # 59f0 <malloc+0x115c>
    2df6:	00002097          	auipc	ra,0x2
    2dfa:	9e6080e7          	jalr	-1562(ra) # 47dc <printf>
    exit(1);
    2dfe:	4505                	li	a0,1
    2e00:	00001097          	auipc	ra,0x1
    2e04:	674080e7          	jalr	1652(ra) # 4474 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    2e08:	85ca                	mv	a1,s2
    2e0a:	00003517          	auipc	a0,0x3
    2e0e:	c1e50513          	addi	a0,a0,-994 # 5a28 <malloc+0x1194>
    2e12:	00002097          	auipc	ra,0x2
    2e16:	9ca080e7          	jalr	-1590(ra) # 47dc <printf>
    exit(1);
    2e1a:	4505                	li	a0,1
    2e1c:	00001097          	auipc	ra,0x1
    2e20:	658080e7          	jalr	1624(ra) # 4474 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2e24:	85ca                	mv	a1,s2
    2e26:	00003517          	auipc	a0,0x3
    2e2a:	c3250513          	addi	a0,a0,-974 # 5a58 <malloc+0x11c4>
    2e2e:	00002097          	auipc	ra,0x2
    2e32:	9ae080e7          	jalr	-1618(ra) # 47dc <printf>
    exit(1);
    2e36:	4505                	li	a0,1
    2e38:	00001097          	auipc	ra,0x1
    2e3c:	63c080e7          	jalr	1596(ra) # 4474 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2e40:	85ca                	mv	a1,s2
    2e42:	00003517          	auipc	a0,0x3
    2e46:	c4e50513          	addi	a0,a0,-946 # 5a90 <malloc+0x11fc>
    2e4a:	00002097          	auipc	ra,0x2
    2e4e:	992080e7          	jalr	-1646(ra) # 47dc <printf>
    exit(1);
    2e52:	4505                	li	a0,1
    2e54:	00001097          	auipc	ra,0x1
    2e58:	620080e7          	jalr	1568(ra) # 4474 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2e5c:	85ca                	mv	a1,s2
    2e5e:	00003517          	auipc	a0,0x3
    2e62:	c5250513          	addi	a0,a0,-942 # 5ab0 <malloc+0x121c>
    2e66:	00002097          	auipc	ra,0x2
    2e6a:	976080e7          	jalr	-1674(ra) # 47dc <printf>
    exit(1);
    2e6e:	4505                	li	a0,1
    2e70:	00001097          	auipc	ra,0x1
    2e74:	604080e7          	jalr	1540(ra) # 4474 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    2e78:	85ca                	mv	a1,s2
    2e7a:	00003517          	auipc	a0,0x3
    2e7e:	c6650513          	addi	a0,a0,-922 # 5ae0 <malloc+0x124c>
    2e82:	00002097          	auipc	ra,0x2
    2e86:	95a080e7          	jalr	-1702(ra) # 47dc <printf>
    exit(1);
    2e8a:	4505                	li	a0,1
    2e8c:	00001097          	auipc	ra,0x1
    2e90:	5e8080e7          	jalr	1512(ra) # 4474 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2e94:	85ca                	mv	a1,s2
    2e96:	00003517          	auipc	a0,0x3
    2e9a:	c7250513          	addi	a0,a0,-910 # 5b08 <malloc+0x1274>
    2e9e:	00002097          	auipc	ra,0x2
    2ea2:	93e080e7          	jalr	-1730(ra) # 47dc <printf>
    exit(1);
    2ea6:	4505                	li	a0,1
    2ea8:	00001097          	auipc	ra,0x1
    2eac:	5cc080e7          	jalr	1484(ra) # 4474 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2eb0:	85ca                	mv	a1,s2
    2eb2:	00003517          	auipc	a0,0x3
    2eb6:	c7650513          	addi	a0,a0,-906 # 5b28 <malloc+0x1294>
    2eba:	00002097          	auipc	ra,0x2
    2ebe:	922080e7          	jalr	-1758(ra) # 47dc <printf>
    exit(1);
    2ec2:	4505                	li	a0,1
    2ec4:	00001097          	auipc	ra,0x1
    2ec8:	5b0080e7          	jalr	1456(ra) # 4474 <exit>
    printf("%s: chdir dd failed\n", s);
    2ecc:	85ca                	mv	a1,s2
    2ece:	00003517          	auipc	a0,0x3
    2ed2:	c8250513          	addi	a0,a0,-894 # 5b50 <malloc+0x12bc>
    2ed6:	00002097          	auipc	ra,0x2
    2eda:	906080e7          	jalr	-1786(ra) # 47dc <printf>
    exit(1);
    2ede:	4505                	li	a0,1
    2ee0:	00001097          	auipc	ra,0x1
    2ee4:	594080e7          	jalr	1428(ra) # 4474 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2ee8:	85ca                	mv	a1,s2
    2eea:	00003517          	auipc	a0,0x3
    2eee:	c8e50513          	addi	a0,a0,-882 # 5b78 <malloc+0x12e4>
    2ef2:	00002097          	auipc	ra,0x2
    2ef6:	8ea080e7          	jalr	-1814(ra) # 47dc <printf>
    exit(1);
    2efa:	4505                	li	a0,1
    2efc:	00001097          	auipc	ra,0x1
    2f00:	578080e7          	jalr	1400(ra) # 4474 <exit>
    printf("chdir dd/../../dd failed\n", s);
    2f04:	85ca                	mv	a1,s2
    2f06:	00003517          	auipc	a0,0x3
    2f0a:	ca250513          	addi	a0,a0,-862 # 5ba8 <malloc+0x1314>
    2f0e:	00002097          	auipc	ra,0x2
    2f12:	8ce080e7          	jalr	-1842(ra) # 47dc <printf>
    exit(1);
    2f16:	4505                	li	a0,1
    2f18:	00001097          	auipc	ra,0x1
    2f1c:	55c080e7          	jalr	1372(ra) # 4474 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2f20:	85ca                	mv	a1,s2
    2f22:	00003517          	auipc	a0,0x3
    2f26:	cae50513          	addi	a0,a0,-850 # 5bd0 <malloc+0x133c>
    2f2a:	00002097          	auipc	ra,0x2
    2f2e:	8b2080e7          	jalr	-1870(ra) # 47dc <printf>
    exit(1);
    2f32:	4505                	li	a0,1
    2f34:	00001097          	auipc	ra,0x1
    2f38:	540080e7          	jalr	1344(ra) # 4474 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2f3c:	85ca                	mv	a1,s2
    2f3e:	00003517          	auipc	a0,0x3
    2f42:	caa50513          	addi	a0,a0,-854 # 5be8 <malloc+0x1354>
    2f46:	00002097          	auipc	ra,0x2
    2f4a:	896080e7          	jalr	-1898(ra) # 47dc <printf>
    exit(1);
    2f4e:	4505                	li	a0,1
    2f50:	00001097          	auipc	ra,0x1
    2f54:	524080e7          	jalr	1316(ra) # 4474 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2f58:	85ca                	mv	a1,s2
    2f5a:	00003517          	auipc	a0,0x3
    2f5e:	cae50513          	addi	a0,a0,-850 # 5c08 <malloc+0x1374>
    2f62:	00002097          	auipc	ra,0x2
    2f66:	87a080e7          	jalr	-1926(ra) # 47dc <printf>
    exit(1);
    2f6a:	4505                	li	a0,1
    2f6c:	00001097          	auipc	ra,0x1
    2f70:	508080e7          	jalr	1288(ra) # 4474 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    2f74:	85ca                	mv	a1,s2
    2f76:	00003517          	auipc	a0,0x3
    2f7a:	cb250513          	addi	a0,a0,-846 # 5c28 <malloc+0x1394>
    2f7e:	00002097          	auipc	ra,0x2
    2f82:	85e080e7          	jalr	-1954(ra) # 47dc <printf>
    exit(1);
    2f86:	4505                	li	a0,1
    2f88:	00001097          	auipc	ra,0x1
    2f8c:	4ec080e7          	jalr	1260(ra) # 4474 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2f90:	85ca                	mv	a1,s2
    2f92:	00003517          	auipc	a0,0x3
    2f96:	cd650513          	addi	a0,a0,-810 # 5c68 <malloc+0x13d4>
    2f9a:	00002097          	auipc	ra,0x2
    2f9e:	842080e7          	jalr	-1982(ra) # 47dc <printf>
    exit(1);
    2fa2:	4505                	li	a0,1
    2fa4:	00001097          	auipc	ra,0x1
    2fa8:	4d0080e7          	jalr	1232(ra) # 4474 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2fac:	85ca                	mv	a1,s2
    2fae:	00003517          	auipc	a0,0x3
    2fb2:	cea50513          	addi	a0,a0,-790 # 5c98 <malloc+0x1404>
    2fb6:	00002097          	auipc	ra,0x2
    2fba:	826080e7          	jalr	-2010(ra) # 47dc <printf>
    exit(1);
    2fbe:	4505                	li	a0,1
    2fc0:	00001097          	auipc	ra,0x1
    2fc4:	4b4080e7          	jalr	1204(ra) # 4474 <exit>
    printf("%s: create dd succeeded!\n", s);
    2fc8:	85ca                	mv	a1,s2
    2fca:	00003517          	auipc	a0,0x3
    2fce:	cee50513          	addi	a0,a0,-786 # 5cb8 <malloc+0x1424>
    2fd2:	00002097          	auipc	ra,0x2
    2fd6:	80a080e7          	jalr	-2038(ra) # 47dc <printf>
    exit(1);
    2fda:	4505                	li	a0,1
    2fdc:	00001097          	auipc	ra,0x1
    2fe0:	498080e7          	jalr	1176(ra) # 4474 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    2fe4:	85ca                	mv	a1,s2
    2fe6:	00003517          	auipc	a0,0x3
    2fea:	cf250513          	addi	a0,a0,-782 # 5cd8 <malloc+0x1444>
    2fee:	00001097          	auipc	ra,0x1
    2ff2:	7ee080e7          	jalr	2030(ra) # 47dc <printf>
    exit(1);
    2ff6:	4505                	li	a0,1
    2ff8:	00001097          	auipc	ra,0x1
    2ffc:	47c080e7          	jalr	1148(ra) # 4474 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3000:	85ca                	mv	a1,s2
    3002:	00003517          	auipc	a0,0x3
    3006:	cf650513          	addi	a0,a0,-778 # 5cf8 <malloc+0x1464>
    300a:	00001097          	auipc	ra,0x1
    300e:	7d2080e7          	jalr	2002(ra) # 47dc <printf>
    exit(1);
    3012:	4505                	li	a0,1
    3014:	00001097          	auipc	ra,0x1
    3018:	460080e7          	jalr	1120(ra) # 4474 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    301c:	85ca                	mv	a1,s2
    301e:	00003517          	auipc	a0,0x3
    3022:	d0a50513          	addi	a0,a0,-758 # 5d28 <malloc+0x1494>
    3026:	00001097          	auipc	ra,0x1
    302a:	7b6080e7          	jalr	1974(ra) # 47dc <printf>
    exit(1);
    302e:	4505                	li	a0,1
    3030:	00001097          	auipc	ra,0x1
    3034:	444080e7          	jalr	1092(ra) # 4474 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3038:	85ca                	mv	a1,s2
    303a:	00003517          	auipc	a0,0x3
    303e:	d1650513          	addi	a0,a0,-746 # 5d50 <malloc+0x14bc>
    3042:	00001097          	auipc	ra,0x1
    3046:	79a080e7          	jalr	1946(ra) # 47dc <printf>
    exit(1);
    304a:	4505                	li	a0,1
    304c:	00001097          	auipc	ra,0x1
    3050:	428080e7          	jalr	1064(ra) # 4474 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3054:	85ca                	mv	a1,s2
    3056:	00003517          	auipc	a0,0x3
    305a:	d2250513          	addi	a0,a0,-734 # 5d78 <malloc+0x14e4>
    305e:	00001097          	auipc	ra,0x1
    3062:	77e080e7          	jalr	1918(ra) # 47dc <printf>
    exit(1);
    3066:	4505                	li	a0,1
    3068:	00001097          	auipc	ra,0x1
    306c:	40c080e7          	jalr	1036(ra) # 4474 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3070:	85ca                	mv	a1,s2
    3072:	00003517          	auipc	a0,0x3
    3076:	d2e50513          	addi	a0,a0,-722 # 5da0 <malloc+0x150c>
    307a:	00001097          	auipc	ra,0x1
    307e:	762080e7          	jalr	1890(ra) # 47dc <printf>
    exit(1);
    3082:	4505                	li	a0,1
    3084:	00001097          	auipc	ra,0x1
    3088:	3f0080e7          	jalr	1008(ra) # 4474 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    308c:	85ca                	mv	a1,s2
    308e:	00003517          	auipc	a0,0x3
    3092:	d3250513          	addi	a0,a0,-718 # 5dc0 <malloc+0x152c>
    3096:	00001097          	auipc	ra,0x1
    309a:	746080e7          	jalr	1862(ra) # 47dc <printf>
    exit(1);
    309e:	4505                	li	a0,1
    30a0:	00001097          	auipc	ra,0x1
    30a4:	3d4080e7          	jalr	980(ra) # 4474 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    30a8:	85ca                	mv	a1,s2
    30aa:	00003517          	auipc	a0,0x3
    30ae:	d3650513          	addi	a0,a0,-714 # 5de0 <malloc+0x154c>
    30b2:	00001097          	auipc	ra,0x1
    30b6:	72a080e7          	jalr	1834(ra) # 47dc <printf>
    exit(1);
    30ba:	4505                	li	a0,1
    30bc:	00001097          	auipc	ra,0x1
    30c0:	3b8080e7          	jalr	952(ra) # 4474 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    30c4:	85ca                	mv	a1,s2
    30c6:	00003517          	auipc	a0,0x3
    30ca:	d4250513          	addi	a0,a0,-702 # 5e08 <malloc+0x1574>
    30ce:	00001097          	auipc	ra,0x1
    30d2:	70e080e7          	jalr	1806(ra) # 47dc <printf>
    exit(1);
    30d6:	4505                	li	a0,1
    30d8:	00001097          	auipc	ra,0x1
    30dc:	39c080e7          	jalr	924(ra) # 4474 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    30e0:	85ca                	mv	a1,s2
    30e2:	00003517          	auipc	a0,0x3
    30e6:	d4650513          	addi	a0,a0,-698 # 5e28 <malloc+0x1594>
    30ea:	00001097          	auipc	ra,0x1
    30ee:	6f2080e7          	jalr	1778(ra) # 47dc <printf>
    exit(1);
    30f2:	4505                	li	a0,1
    30f4:	00001097          	auipc	ra,0x1
    30f8:	380080e7          	jalr	896(ra) # 4474 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    30fc:	85ca                	mv	a1,s2
    30fe:	00003517          	auipc	a0,0x3
    3102:	d4a50513          	addi	a0,a0,-694 # 5e48 <malloc+0x15b4>
    3106:	00001097          	auipc	ra,0x1
    310a:	6d6080e7          	jalr	1750(ra) # 47dc <printf>
    exit(1);
    310e:	4505                	li	a0,1
    3110:	00001097          	auipc	ra,0x1
    3114:	364080e7          	jalr	868(ra) # 4474 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3118:	85ca                	mv	a1,s2
    311a:	00003517          	auipc	a0,0x3
    311e:	d5650513          	addi	a0,a0,-682 # 5e70 <malloc+0x15dc>
    3122:	00001097          	auipc	ra,0x1
    3126:	6ba080e7          	jalr	1722(ra) # 47dc <printf>
    exit(1);
    312a:	4505                	li	a0,1
    312c:	00001097          	auipc	ra,0x1
    3130:	348080e7          	jalr	840(ra) # 4474 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3134:	85ca                	mv	a1,s2
    3136:	00003517          	auipc	a0,0x3
    313a:	9d250513          	addi	a0,a0,-1582 # 5b08 <malloc+0x1274>
    313e:	00001097          	auipc	ra,0x1
    3142:	69e080e7          	jalr	1694(ra) # 47dc <printf>
    exit(1);
    3146:	4505                	li	a0,1
    3148:	00001097          	auipc	ra,0x1
    314c:	32c080e7          	jalr	812(ra) # 4474 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3150:	85ca                	mv	a1,s2
    3152:	00003517          	auipc	a0,0x3
    3156:	d3e50513          	addi	a0,a0,-706 # 5e90 <malloc+0x15fc>
    315a:	00001097          	auipc	ra,0x1
    315e:	682080e7          	jalr	1666(ra) # 47dc <printf>
    exit(1);
    3162:	4505                	li	a0,1
    3164:	00001097          	auipc	ra,0x1
    3168:	310080e7          	jalr	784(ra) # 4474 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    316c:	85ca                	mv	a1,s2
    316e:	00003517          	auipc	a0,0x3
    3172:	d4250513          	addi	a0,a0,-702 # 5eb0 <malloc+0x161c>
    3176:	00001097          	auipc	ra,0x1
    317a:	666080e7          	jalr	1638(ra) # 47dc <printf>
    exit(1);
    317e:	4505                	li	a0,1
    3180:	00001097          	auipc	ra,0x1
    3184:	2f4080e7          	jalr	756(ra) # 4474 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3188:	85ca                	mv	a1,s2
    318a:	00003517          	auipc	a0,0x3
    318e:	d5650513          	addi	a0,a0,-682 # 5ee0 <malloc+0x164c>
    3192:	00001097          	auipc	ra,0x1
    3196:	64a080e7          	jalr	1610(ra) # 47dc <printf>
    exit(1);
    319a:	4505                	li	a0,1
    319c:	00001097          	auipc	ra,0x1
    31a0:	2d8080e7          	jalr	728(ra) # 4474 <exit>
    printf("%s: unlink dd failed\n", s);
    31a4:	85ca                	mv	a1,s2
    31a6:	00003517          	auipc	a0,0x3
    31aa:	d5a50513          	addi	a0,a0,-678 # 5f00 <malloc+0x166c>
    31ae:	00001097          	auipc	ra,0x1
    31b2:	62e080e7          	jalr	1582(ra) # 47dc <printf>
    exit(1);
    31b6:	4505                	li	a0,1
    31b8:	00001097          	auipc	ra,0x1
    31bc:	2bc080e7          	jalr	700(ra) # 4474 <exit>

00000000000031c0 <dirfile>:
{
    31c0:	1101                	addi	sp,sp,-32
    31c2:	ec06                	sd	ra,24(sp)
    31c4:	e822                	sd	s0,16(sp)
    31c6:	e426                	sd	s1,8(sp)
    31c8:	e04a                	sd	s2,0(sp)
    31ca:	1000                	addi	s0,sp,32
    31cc:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    31ce:	20000593          	li	a1,512
    31d2:	00003517          	auipc	a0,0x3
    31d6:	d4650513          	addi	a0,a0,-698 # 5f18 <malloc+0x1684>
    31da:	00001097          	auipc	ra,0x1
    31de:	2da080e7          	jalr	730(ra) # 44b4 <open>
  if(fd < 0){
    31e2:	0e054d63          	bltz	a0,32dc <dirfile+0x11c>
  close(fd);
    31e6:	00001097          	auipc	ra,0x1
    31ea:	2b6080e7          	jalr	694(ra) # 449c <close>
  if(chdir("dirfile") == 0){
    31ee:	00003517          	auipc	a0,0x3
    31f2:	d2a50513          	addi	a0,a0,-726 # 5f18 <malloc+0x1684>
    31f6:	00001097          	auipc	ra,0x1
    31fa:	2ee080e7          	jalr	750(ra) # 44e4 <chdir>
    31fe:	cd6d                	beqz	a0,32f8 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3200:	4581                	li	a1,0
    3202:	00003517          	auipc	a0,0x3
    3206:	d5e50513          	addi	a0,a0,-674 # 5f60 <malloc+0x16cc>
    320a:	00001097          	auipc	ra,0x1
    320e:	2aa080e7          	jalr	682(ra) # 44b4 <open>
  if(fd >= 0){
    3212:	10055163          	bgez	a0,3314 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3216:	20000593          	li	a1,512
    321a:	00003517          	auipc	a0,0x3
    321e:	d4650513          	addi	a0,a0,-698 # 5f60 <malloc+0x16cc>
    3222:	00001097          	auipc	ra,0x1
    3226:	292080e7          	jalr	658(ra) # 44b4 <open>
  if(fd >= 0){
    322a:	10055363          	bgez	a0,3330 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    322e:	00003517          	auipc	a0,0x3
    3232:	d3250513          	addi	a0,a0,-718 # 5f60 <malloc+0x16cc>
    3236:	00001097          	auipc	ra,0x1
    323a:	2a6080e7          	jalr	678(ra) # 44dc <mkdir>
    323e:	10050763          	beqz	a0,334c <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3242:	00003517          	auipc	a0,0x3
    3246:	d1e50513          	addi	a0,a0,-738 # 5f60 <malloc+0x16cc>
    324a:	00001097          	auipc	ra,0x1
    324e:	27a080e7          	jalr	634(ra) # 44c4 <unlink>
    3252:	10050b63          	beqz	a0,3368 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3256:	00003597          	auipc	a1,0x3
    325a:	d0a58593          	addi	a1,a1,-758 # 5f60 <malloc+0x16cc>
    325e:	00003517          	auipc	a0,0x3
    3262:	d8a50513          	addi	a0,a0,-630 # 5fe8 <malloc+0x1754>
    3266:	00001097          	auipc	ra,0x1
    326a:	26e080e7          	jalr	622(ra) # 44d4 <link>
    326e:	10050b63          	beqz	a0,3384 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3272:	00003517          	auipc	a0,0x3
    3276:	ca650513          	addi	a0,a0,-858 # 5f18 <malloc+0x1684>
    327a:	00001097          	auipc	ra,0x1
    327e:	24a080e7          	jalr	586(ra) # 44c4 <unlink>
    3282:	10051f63          	bnez	a0,33a0 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3286:	4589                	li	a1,2
    3288:	00001517          	auipc	a0,0x1
    328c:	7f850513          	addi	a0,a0,2040 # 4a80 <malloc+0x1ec>
    3290:	00001097          	auipc	ra,0x1
    3294:	224080e7          	jalr	548(ra) # 44b4 <open>
  if(fd >= 0){
    3298:	12055263          	bgez	a0,33bc <dirfile+0x1fc>
  fd = open(".", 0);
    329c:	4581                	li	a1,0
    329e:	00001517          	auipc	a0,0x1
    32a2:	7e250513          	addi	a0,a0,2018 # 4a80 <malloc+0x1ec>
    32a6:	00001097          	auipc	ra,0x1
    32aa:	20e080e7          	jalr	526(ra) # 44b4 <open>
    32ae:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    32b0:	4605                	li	a2,1
    32b2:	00002597          	auipc	a1,0x2
    32b6:	24e58593          	addi	a1,a1,590 # 5500 <malloc+0xc6c>
    32ba:	00001097          	auipc	ra,0x1
    32be:	1da080e7          	jalr	474(ra) # 4494 <write>
    32c2:	10a04b63          	bgtz	a0,33d8 <dirfile+0x218>
  close(fd);
    32c6:	8526                	mv	a0,s1
    32c8:	00001097          	auipc	ra,0x1
    32cc:	1d4080e7          	jalr	468(ra) # 449c <close>
}
    32d0:	60e2                	ld	ra,24(sp)
    32d2:	6442                	ld	s0,16(sp)
    32d4:	64a2                	ld	s1,8(sp)
    32d6:	6902                	ld	s2,0(sp)
    32d8:	6105                	addi	sp,sp,32
    32da:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    32dc:	85ca                	mv	a1,s2
    32de:	00003517          	auipc	a0,0x3
    32e2:	c4250513          	addi	a0,a0,-958 # 5f20 <malloc+0x168c>
    32e6:	00001097          	auipc	ra,0x1
    32ea:	4f6080e7          	jalr	1270(ra) # 47dc <printf>
    exit(1);
    32ee:	4505                	li	a0,1
    32f0:	00001097          	auipc	ra,0x1
    32f4:	184080e7          	jalr	388(ra) # 4474 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    32f8:	85ca                	mv	a1,s2
    32fa:	00003517          	auipc	a0,0x3
    32fe:	c4650513          	addi	a0,a0,-954 # 5f40 <malloc+0x16ac>
    3302:	00001097          	auipc	ra,0x1
    3306:	4da080e7          	jalr	1242(ra) # 47dc <printf>
    exit(1);
    330a:	4505                	li	a0,1
    330c:	00001097          	auipc	ra,0x1
    3310:	168080e7          	jalr	360(ra) # 4474 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3314:	85ca                	mv	a1,s2
    3316:	00003517          	auipc	a0,0x3
    331a:	c5a50513          	addi	a0,a0,-934 # 5f70 <malloc+0x16dc>
    331e:	00001097          	auipc	ra,0x1
    3322:	4be080e7          	jalr	1214(ra) # 47dc <printf>
    exit(1);
    3326:	4505                	li	a0,1
    3328:	00001097          	auipc	ra,0x1
    332c:	14c080e7          	jalr	332(ra) # 4474 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3330:	85ca                	mv	a1,s2
    3332:	00003517          	auipc	a0,0x3
    3336:	c3e50513          	addi	a0,a0,-962 # 5f70 <malloc+0x16dc>
    333a:	00001097          	auipc	ra,0x1
    333e:	4a2080e7          	jalr	1186(ra) # 47dc <printf>
    exit(1);
    3342:	4505                	li	a0,1
    3344:	00001097          	auipc	ra,0x1
    3348:	130080e7          	jalr	304(ra) # 4474 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    334c:	85ca                	mv	a1,s2
    334e:	00003517          	auipc	a0,0x3
    3352:	c4a50513          	addi	a0,a0,-950 # 5f98 <malloc+0x1704>
    3356:	00001097          	auipc	ra,0x1
    335a:	486080e7          	jalr	1158(ra) # 47dc <printf>
    exit(1);
    335e:	4505                	li	a0,1
    3360:	00001097          	auipc	ra,0x1
    3364:	114080e7          	jalr	276(ra) # 4474 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3368:	85ca                	mv	a1,s2
    336a:	00003517          	auipc	a0,0x3
    336e:	c5650513          	addi	a0,a0,-938 # 5fc0 <malloc+0x172c>
    3372:	00001097          	auipc	ra,0x1
    3376:	46a080e7          	jalr	1130(ra) # 47dc <printf>
    exit(1);
    337a:	4505                	li	a0,1
    337c:	00001097          	auipc	ra,0x1
    3380:	0f8080e7          	jalr	248(ra) # 4474 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3384:	85ca                	mv	a1,s2
    3386:	00003517          	auipc	a0,0x3
    338a:	c6a50513          	addi	a0,a0,-918 # 5ff0 <malloc+0x175c>
    338e:	00001097          	auipc	ra,0x1
    3392:	44e080e7          	jalr	1102(ra) # 47dc <printf>
    exit(1);
    3396:	4505                	li	a0,1
    3398:	00001097          	auipc	ra,0x1
    339c:	0dc080e7          	jalr	220(ra) # 4474 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    33a0:	85ca                	mv	a1,s2
    33a2:	00003517          	auipc	a0,0x3
    33a6:	c7650513          	addi	a0,a0,-906 # 6018 <malloc+0x1784>
    33aa:	00001097          	auipc	ra,0x1
    33ae:	432080e7          	jalr	1074(ra) # 47dc <printf>
    exit(1);
    33b2:	4505                	li	a0,1
    33b4:	00001097          	auipc	ra,0x1
    33b8:	0c0080e7          	jalr	192(ra) # 4474 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    33bc:	85ca                	mv	a1,s2
    33be:	00003517          	auipc	a0,0x3
    33c2:	c7a50513          	addi	a0,a0,-902 # 6038 <malloc+0x17a4>
    33c6:	00001097          	auipc	ra,0x1
    33ca:	416080e7          	jalr	1046(ra) # 47dc <printf>
    exit(1);
    33ce:	4505                	li	a0,1
    33d0:	00001097          	auipc	ra,0x1
    33d4:	0a4080e7          	jalr	164(ra) # 4474 <exit>
    printf("%s: write . succeeded!\n", s);
    33d8:	85ca                	mv	a1,s2
    33da:	00003517          	auipc	a0,0x3
    33de:	c8650513          	addi	a0,a0,-890 # 6060 <malloc+0x17cc>
    33e2:	00001097          	auipc	ra,0x1
    33e6:	3fa080e7          	jalr	1018(ra) # 47dc <printf>
    exit(1);
    33ea:	4505                	li	a0,1
    33ec:	00001097          	auipc	ra,0x1
    33f0:	088080e7          	jalr	136(ra) # 4474 <exit>

00000000000033f4 <iref>:
{
    33f4:	7139                	addi	sp,sp,-64
    33f6:	fc06                	sd	ra,56(sp)
    33f8:	f822                	sd	s0,48(sp)
    33fa:	f426                	sd	s1,40(sp)
    33fc:	f04a                	sd	s2,32(sp)
    33fe:	ec4e                	sd	s3,24(sp)
    3400:	e852                	sd	s4,16(sp)
    3402:	e456                	sd	s5,8(sp)
    3404:	e05a                	sd	s6,0(sp)
    3406:	0080                	addi	s0,sp,64
    3408:	8b2a                	mv	s6,a0
    340a:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    340e:	00003a17          	auipc	s4,0x3
    3412:	c6aa0a13          	addi	s4,s4,-918 # 6078 <malloc+0x17e4>
    mkdir("");
    3416:	00003497          	auipc	s1,0x3
    341a:	83a48493          	addi	s1,s1,-1990 # 5c50 <malloc+0x13bc>
    link("README", "");
    341e:	00003a97          	auipc	s5,0x3
    3422:	bcaa8a93          	addi	s5,s5,-1078 # 5fe8 <malloc+0x1754>
    fd = open("xx", O_CREATE);
    3426:	00003997          	auipc	s3,0x3
    342a:	b4298993          	addi	s3,s3,-1214 # 5f68 <malloc+0x16d4>
    342e:	a891                	j	3482 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3430:	85da                	mv	a1,s6
    3432:	00003517          	auipc	a0,0x3
    3436:	c4e50513          	addi	a0,a0,-946 # 6080 <malloc+0x17ec>
    343a:	00001097          	auipc	ra,0x1
    343e:	3a2080e7          	jalr	930(ra) # 47dc <printf>
      exit(1);
    3442:	4505                	li	a0,1
    3444:	00001097          	auipc	ra,0x1
    3448:	030080e7          	jalr	48(ra) # 4474 <exit>
      printf("%s: chdir irefd failed\n", s);
    344c:	85da                	mv	a1,s6
    344e:	00003517          	auipc	a0,0x3
    3452:	c4a50513          	addi	a0,a0,-950 # 6098 <malloc+0x1804>
    3456:	00001097          	auipc	ra,0x1
    345a:	386080e7          	jalr	902(ra) # 47dc <printf>
      exit(1);
    345e:	4505                	li	a0,1
    3460:	00001097          	auipc	ra,0x1
    3464:	014080e7          	jalr	20(ra) # 4474 <exit>
      close(fd);
    3468:	00001097          	auipc	ra,0x1
    346c:	034080e7          	jalr	52(ra) # 449c <close>
    3470:	a889                	j	34c2 <iref+0xce>
    unlink("xx");
    3472:	854e                	mv	a0,s3
    3474:	00001097          	auipc	ra,0x1
    3478:	050080e7          	jalr	80(ra) # 44c4 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    347c:	397d                	addiw	s2,s2,-1
    347e:	06090063          	beqz	s2,34de <iref+0xea>
    if(mkdir("irefd") != 0){
    3482:	8552                	mv	a0,s4
    3484:	00001097          	auipc	ra,0x1
    3488:	058080e7          	jalr	88(ra) # 44dc <mkdir>
    348c:	f155                	bnez	a0,3430 <iref+0x3c>
    if(chdir("irefd") != 0){
    348e:	8552                	mv	a0,s4
    3490:	00001097          	auipc	ra,0x1
    3494:	054080e7          	jalr	84(ra) # 44e4 <chdir>
    3498:	f955                	bnez	a0,344c <iref+0x58>
    mkdir("");
    349a:	8526                	mv	a0,s1
    349c:	00001097          	auipc	ra,0x1
    34a0:	040080e7          	jalr	64(ra) # 44dc <mkdir>
    link("README", "");
    34a4:	85a6                	mv	a1,s1
    34a6:	8556                	mv	a0,s5
    34a8:	00001097          	auipc	ra,0x1
    34ac:	02c080e7          	jalr	44(ra) # 44d4 <link>
    fd = open("", O_CREATE);
    34b0:	20000593          	li	a1,512
    34b4:	8526                	mv	a0,s1
    34b6:	00001097          	auipc	ra,0x1
    34ba:	ffe080e7          	jalr	-2(ra) # 44b4 <open>
    if(fd >= 0)
    34be:	fa0555e3          	bgez	a0,3468 <iref+0x74>
    fd = open("xx", O_CREATE);
    34c2:	20000593          	li	a1,512
    34c6:	854e                	mv	a0,s3
    34c8:	00001097          	auipc	ra,0x1
    34cc:	fec080e7          	jalr	-20(ra) # 44b4 <open>
    if(fd >= 0)
    34d0:	fa0541e3          	bltz	a0,3472 <iref+0x7e>
      close(fd);
    34d4:	00001097          	auipc	ra,0x1
    34d8:	fc8080e7          	jalr	-56(ra) # 449c <close>
    34dc:	bf59                	j	3472 <iref+0x7e>
  chdir("/");
    34de:	00001517          	auipc	a0,0x1
    34e2:	54a50513          	addi	a0,a0,1354 # 4a28 <malloc+0x194>
    34e6:	00001097          	auipc	ra,0x1
    34ea:	ffe080e7          	jalr	-2(ra) # 44e4 <chdir>
}
    34ee:	70e2                	ld	ra,56(sp)
    34f0:	7442                	ld	s0,48(sp)
    34f2:	74a2                	ld	s1,40(sp)
    34f4:	7902                	ld	s2,32(sp)
    34f6:	69e2                	ld	s3,24(sp)
    34f8:	6a42                	ld	s4,16(sp)
    34fa:	6aa2                	ld	s5,8(sp)
    34fc:	6b02                	ld	s6,0(sp)
    34fe:	6121                	addi	sp,sp,64
    3500:	8082                	ret

0000000000003502 <validatetest>:
{
    3502:	7139                	addi	sp,sp,-64
    3504:	fc06                	sd	ra,56(sp)
    3506:	f822                	sd	s0,48(sp)
    3508:	f426                	sd	s1,40(sp)
    350a:	f04a                	sd	s2,32(sp)
    350c:	ec4e                	sd	s3,24(sp)
    350e:	e852                	sd	s4,16(sp)
    3510:	e456                	sd	s5,8(sp)
    3512:	e05a                	sd	s6,0(sp)
    3514:	0080                	addi	s0,sp,64
    3516:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    3518:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    351a:	00003997          	auipc	s3,0x3
    351e:	b9698993          	addi	s3,s3,-1130 # 60b0 <malloc+0x181c>
    3522:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    3524:	6a85                	lui	s5,0x1
    3526:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    352a:	85a6                	mv	a1,s1
    352c:	854e                	mv	a0,s3
    352e:	00001097          	auipc	ra,0x1
    3532:	fa6080e7          	jalr	-90(ra) # 44d4 <link>
    3536:	01251f63          	bne	a0,s2,3554 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    353a:	94d6                	add	s1,s1,s5
    353c:	ff4497e3          	bne	s1,s4,352a <validatetest+0x28>
}
    3540:	70e2                	ld	ra,56(sp)
    3542:	7442                	ld	s0,48(sp)
    3544:	74a2                	ld	s1,40(sp)
    3546:	7902                	ld	s2,32(sp)
    3548:	69e2                	ld	s3,24(sp)
    354a:	6a42                	ld	s4,16(sp)
    354c:	6aa2                	ld	s5,8(sp)
    354e:	6b02                	ld	s6,0(sp)
    3550:	6121                	addi	sp,sp,64
    3552:	8082                	ret
      printf("%s: link should not succeed\n", s);
    3554:	85da                	mv	a1,s6
    3556:	00003517          	auipc	a0,0x3
    355a:	b6a50513          	addi	a0,a0,-1174 # 60c0 <malloc+0x182c>
    355e:	00001097          	auipc	ra,0x1
    3562:	27e080e7          	jalr	638(ra) # 47dc <printf>
      exit(1);
    3566:	4505                	li	a0,1
    3568:	00001097          	auipc	ra,0x1
    356c:	f0c080e7          	jalr	-244(ra) # 4474 <exit>

0000000000003570 <sbrkbasic>:
{
    3570:	7139                	addi	sp,sp,-64
    3572:	fc06                	sd	ra,56(sp)
    3574:	f822                	sd	s0,48(sp)
    3576:	e852                	sd	s4,16(sp)
    3578:	0080                	addi	s0,sp,64
    357a:	8a2a                	mv	s4,a0
  a = sbrk(TOOMUCH);
    357c:	40000537          	lui	a0,0x40000
    3580:	00001097          	auipc	ra,0x1
    3584:	f7c080e7          	jalr	-132(ra) # 44fc <sbrk>
  if(a != (char*)0xffffffffffffffffL){
    3588:	57fd                	li	a5,-1
    358a:	02f50363          	beq	a0,a5,35b0 <sbrkbasic+0x40>
    358e:	f426                	sd	s1,40(sp)
    3590:	f04a                	sd	s2,32(sp)
    3592:	ec4e                	sd	s3,24(sp)
    3594:	85aa                	mv	a1,a0
    printf("%s: sbrk(<toomuch>) returned %p\n", a);
    3596:	00003517          	auipc	a0,0x3
    359a:	b4a50513          	addi	a0,a0,-1206 # 60e0 <malloc+0x184c>
    359e:	00001097          	auipc	ra,0x1
    35a2:	23e080e7          	jalr	574(ra) # 47dc <printf>
    exit(1);
    35a6:	4505                	li	a0,1
    35a8:	00001097          	auipc	ra,0x1
    35ac:	ecc080e7          	jalr	-308(ra) # 4474 <exit>
    35b0:	f426                	sd	s1,40(sp)
    35b2:	f04a                	sd	s2,32(sp)
    35b4:	ec4e                	sd	s3,24(sp)
  a = sbrk(0);
    35b6:	4501                	li	a0,0
    35b8:	00001097          	auipc	ra,0x1
    35bc:	f44080e7          	jalr	-188(ra) # 44fc <sbrk>
    35c0:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    35c2:	4901                	li	s2,0
    35c4:	6985                	lui	s3,0x1
    35c6:	38898993          	addi	s3,s3,904 # 1388 <unlinkread+0x110>
    35ca:	a011                	j	35ce <sbrkbasic+0x5e>
    35cc:	84be                	mv	s1,a5
    b = sbrk(1);
    35ce:	4505                	li	a0,1
    35d0:	00001097          	auipc	ra,0x1
    35d4:	f2c080e7          	jalr	-212(ra) # 44fc <sbrk>
    if(b != a){
    35d8:	04951c63          	bne	a0,s1,3630 <sbrkbasic+0xc0>
    *b = 1;
    35dc:	4785                	li	a5,1
    35de:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    35e2:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    35e6:	2905                	addiw	s2,s2,1
    35e8:	ff3912e3          	bne	s2,s3,35cc <sbrkbasic+0x5c>
  pid = fork();
    35ec:	00001097          	auipc	ra,0x1
    35f0:	e80080e7          	jalr	-384(ra) # 446c <fork>
    35f4:	892a                	mv	s2,a0
  if(pid < 0){
    35f6:	04054d63          	bltz	a0,3650 <sbrkbasic+0xe0>
  c = sbrk(1);
    35fa:	4505                	li	a0,1
    35fc:	00001097          	auipc	ra,0x1
    3600:	f00080e7          	jalr	-256(ra) # 44fc <sbrk>
  c = sbrk(1);
    3604:	4505                	li	a0,1
    3606:	00001097          	auipc	ra,0x1
    360a:	ef6080e7          	jalr	-266(ra) # 44fc <sbrk>
  if(c != a + 1){
    360e:	0489                	addi	s1,s1,2
    3610:	04a48e63          	beq	s1,a0,366c <sbrkbasic+0xfc>
    printf("%s: sbrk test failed post-fork\n", s);
    3614:	85d2                	mv	a1,s4
    3616:	00003517          	auipc	a0,0x3
    361a:	b3250513          	addi	a0,a0,-1230 # 6148 <malloc+0x18b4>
    361e:	00001097          	auipc	ra,0x1
    3622:	1be080e7          	jalr	446(ra) # 47dc <printf>
    exit(1);
    3626:	4505                	li	a0,1
    3628:	00001097          	auipc	ra,0x1
    362c:	e4c080e7          	jalr	-436(ra) # 4474 <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    3630:	86aa                	mv	a3,a0
    3632:	8626                	mv	a2,s1
    3634:	85ca                	mv	a1,s2
    3636:	00003517          	auipc	a0,0x3
    363a:	ad250513          	addi	a0,a0,-1326 # 6108 <malloc+0x1874>
    363e:	00001097          	auipc	ra,0x1
    3642:	19e080e7          	jalr	414(ra) # 47dc <printf>
      exit(1);
    3646:	4505                	li	a0,1
    3648:	00001097          	auipc	ra,0x1
    364c:	e2c080e7          	jalr	-468(ra) # 4474 <exit>
    printf("%s: sbrk test fork failed\n", s);
    3650:	85d2                	mv	a1,s4
    3652:	00003517          	auipc	a0,0x3
    3656:	ad650513          	addi	a0,a0,-1322 # 6128 <malloc+0x1894>
    365a:	00001097          	auipc	ra,0x1
    365e:	182080e7          	jalr	386(ra) # 47dc <printf>
    exit(1);
    3662:	4505                	li	a0,1
    3664:	00001097          	auipc	ra,0x1
    3668:	e10080e7          	jalr	-496(ra) # 4474 <exit>
  if(pid == 0)
    366c:	00091763          	bnez	s2,367a <sbrkbasic+0x10a>
    exit(0);
    3670:	4501                	li	a0,0
    3672:	00001097          	auipc	ra,0x1
    3676:	e02080e7          	jalr	-510(ra) # 4474 <exit>
  wait(&xstatus);
    367a:	fcc40513          	addi	a0,s0,-52
    367e:	00001097          	auipc	ra,0x1
    3682:	dfe080e7          	jalr	-514(ra) # 447c <wait>
  exit(xstatus);
    3686:	fcc42503          	lw	a0,-52(s0)
    368a:	00001097          	auipc	ra,0x1
    368e:	dea080e7          	jalr	-534(ra) # 4474 <exit>

0000000000003692 <sbrkmuch>:
{
    3692:	7179                	addi	sp,sp,-48
    3694:	f406                	sd	ra,40(sp)
    3696:	f022                	sd	s0,32(sp)
    3698:	ec26                	sd	s1,24(sp)
    369a:	e84a                	sd	s2,16(sp)
    369c:	e44e                	sd	s3,8(sp)
    369e:	e052                	sd	s4,0(sp)
    36a0:	1800                	addi	s0,sp,48
    36a2:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    36a4:	4501                	li	a0,0
    36a6:	00001097          	auipc	ra,0x1
    36aa:	e56080e7          	jalr	-426(ra) # 44fc <sbrk>
    36ae:	892a                	mv	s2,a0
  a = sbrk(0);
    36b0:	4501                	li	a0,0
    36b2:	00001097          	auipc	ra,0x1
    36b6:	e4a080e7          	jalr	-438(ra) # 44fc <sbrk>
    36ba:	84aa                	mv	s1,a0
  p = sbrk(amt);
    36bc:	06400537          	lui	a0,0x6400
    36c0:	9d05                	subw	a0,a0,s1
    36c2:	00001097          	auipc	ra,0x1
    36c6:	e3a080e7          	jalr	-454(ra) # 44fc <sbrk>
  if (p != a) {
    36ca:	0aa49963          	bne	s1,a0,377c <sbrkmuch+0xea>
  *lastaddr = 99;
    36ce:	064007b7          	lui	a5,0x6400
    36d2:	06300713          	li	a4,99
    36d6:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f28df>
  a = sbrk(0);
    36da:	4501                	li	a0,0
    36dc:	00001097          	auipc	ra,0x1
    36e0:	e20080e7          	jalr	-480(ra) # 44fc <sbrk>
    36e4:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    36e6:	757d                	lui	a0,0xfffff
    36e8:	00001097          	auipc	ra,0x1
    36ec:	e14080e7          	jalr	-492(ra) # 44fc <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    36f0:	57fd                	li	a5,-1
    36f2:	0af50363          	beq	a0,a5,3798 <sbrkmuch+0x106>
  c = sbrk(0);
    36f6:	4501                	li	a0,0
    36f8:	00001097          	auipc	ra,0x1
    36fc:	e04080e7          	jalr	-508(ra) # 44fc <sbrk>
  if(c != a - PGSIZE){
    3700:	77fd                	lui	a5,0xfffff
    3702:	97a6                	add	a5,a5,s1
    3704:	0af51863          	bne	a0,a5,37b4 <sbrkmuch+0x122>
  a = sbrk(0);
    3708:	4501                	li	a0,0
    370a:	00001097          	auipc	ra,0x1
    370e:	df2080e7          	jalr	-526(ra) # 44fc <sbrk>
    3712:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    3714:	6505                	lui	a0,0x1
    3716:	00001097          	auipc	ra,0x1
    371a:	de6080e7          	jalr	-538(ra) # 44fc <sbrk>
    371e:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    3720:	0aa49963          	bne	s1,a0,37d2 <sbrkmuch+0x140>
    3724:	4501                	li	a0,0
    3726:	00001097          	auipc	ra,0x1
    372a:	dd6080e7          	jalr	-554(ra) # 44fc <sbrk>
    372e:	6785                	lui	a5,0x1
    3730:	97a6                	add	a5,a5,s1
    3732:	0af51063          	bne	a0,a5,37d2 <sbrkmuch+0x140>
  if(*lastaddr == 99){
    3736:	064007b7          	lui	a5,0x6400
    373a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f28df>
    373e:	06300793          	li	a5,99
    3742:	0af70763          	beq	a4,a5,37f0 <sbrkmuch+0x15e>
  a = sbrk(0);
    3746:	4501                	li	a0,0
    3748:	00001097          	auipc	ra,0x1
    374c:	db4080e7          	jalr	-588(ra) # 44fc <sbrk>
    3750:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    3752:	4501                	li	a0,0
    3754:	00001097          	auipc	ra,0x1
    3758:	da8080e7          	jalr	-600(ra) # 44fc <sbrk>
    375c:	40a9053b          	subw	a0,s2,a0
    3760:	00001097          	auipc	ra,0x1
    3764:	d9c080e7          	jalr	-612(ra) # 44fc <sbrk>
  if(c != a){
    3768:	0aa49263          	bne	s1,a0,380c <sbrkmuch+0x17a>
}
    376c:	70a2                	ld	ra,40(sp)
    376e:	7402                	ld	s0,32(sp)
    3770:	64e2                	ld	s1,24(sp)
    3772:	6942                	ld	s2,16(sp)
    3774:	69a2                	ld	s3,8(sp)
    3776:	6a02                	ld	s4,0(sp)
    3778:	6145                	addi	sp,sp,48
    377a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    377c:	85ce                	mv	a1,s3
    377e:	00003517          	auipc	a0,0x3
    3782:	9ea50513          	addi	a0,a0,-1558 # 6168 <malloc+0x18d4>
    3786:	00001097          	auipc	ra,0x1
    378a:	056080e7          	jalr	86(ra) # 47dc <printf>
    exit(1);
    378e:	4505                	li	a0,1
    3790:	00001097          	auipc	ra,0x1
    3794:	ce4080e7          	jalr	-796(ra) # 4474 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    3798:	85ce                	mv	a1,s3
    379a:	00003517          	auipc	a0,0x3
    379e:	a1650513          	addi	a0,a0,-1514 # 61b0 <malloc+0x191c>
    37a2:	00001097          	auipc	ra,0x1
    37a6:	03a080e7          	jalr	58(ra) # 47dc <printf>
    exit(1);
    37aa:	4505                	li	a0,1
    37ac:	00001097          	auipc	ra,0x1
    37b0:	cc8080e7          	jalr	-824(ra) # 4474 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    37b4:	862a                	mv	a2,a0
    37b6:	85a6                	mv	a1,s1
    37b8:	00003517          	auipc	a0,0x3
    37bc:	a1850513          	addi	a0,a0,-1512 # 61d0 <malloc+0x193c>
    37c0:	00001097          	auipc	ra,0x1
    37c4:	01c080e7          	jalr	28(ra) # 47dc <printf>
    exit(1);
    37c8:	4505                	li	a0,1
    37ca:	00001097          	auipc	ra,0x1
    37ce:	caa080e7          	jalr	-854(ra) # 4474 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", a, c);
    37d2:	8652                	mv	a2,s4
    37d4:	85a6                	mv	a1,s1
    37d6:	00003517          	auipc	a0,0x3
    37da:	a3a50513          	addi	a0,a0,-1478 # 6210 <malloc+0x197c>
    37de:	00001097          	auipc	ra,0x1
    37e2:	ffe080e7          	jalr	-2(ra) # 47dc <printf>
    exit(1);
    37e6:	4505                	li	a0,1
    37e8:	00001097          	auipc	ra,0x1
    37ec:	c8c080e7          	jalr	-884(ra) # 4474 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    37f0:	85ce                	mv	a1,s3
    37f2:	00003517          	auipc	a0,0x3
    37f6:	a4e50513          	addi	a0,a0,-1458 # 6240 <malloc+0x19ac>
    37fa:	00001097          	auipc	ra,0x1
    37fe:	fe2080e7          	jalr	-30(ra) # 47dc <printf>
    exit(1);
    3802:	4505                	li	a0,1
    3804:	00001097          	auipc	ra,0x1
    3808:	c70080e7          	jalr	-912(ra) # 4474 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", a, c);
    380c:	862a                	mv	a2,a0
    380e:	85a6                	mv	a1,s1
    3810:	00003517          	auipc	a0,0x3
    3814:	a6850513          	addi	a0,a0,-1432 # 6278 <malloc+0x19e4>
    3818:	00001097          	auipc	ra,0x1
    381c:	fc4080e7          	jalr	-60(ra) # 47dc <printf>
    exit(1);
    3820:	4505                	li	a0,1
    3822:	00001097          	auipc	ra,0x1
    3826:	c52080e7          	jalr	-942(ra) # 4474 <exit>

000000000000382a <sbrkfail>:
{
    382a:	7119                	addi	sp,sp,-128
    382c:	fc86                	sd	ra,120(sp)
    382e:	f8a2                	sd	s0,112(sp)
    3830:	f4a6                	sd	s1,104(sp)
    3832:	f0ca                	sd	s2,96(sp)
    3834:	ecce                	sd	s3,88(sp)
    3836:	e8d2                	sd	s4,80(sp)
    3838:	e4d6                	sd	s5,72(sp)
    383a:	0100                	addi	s0,sp,128
    383c:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    383e:	fb040513          	addi	a0,s0,-80
    3842:	00001097          	auipc	ra,0x1
    3846:	c42080e7          	jalr	-958(ra) # 4484 <pipe>
    384a:	e901                	bnez	a0,385a <sbrkfail+0x30>
    384c:	f8040493          	addi	s1,s0,-128
    3850:	fa840993          	addi	s3,s0,-88
    3854:	8926                	mv	s2,s1
    if(pids[i] != -1)
    3856:	5a7d                	li	s4,-1
    3858:	a085                	j	38b8 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    385a:	85d6                	mv	a1,s5
    385c:	00002517          	auipc	a0,0x2
    3860:	c2450513          	addi	a0,a0,-988 # 5480 <malloc+0xbec>
    3864:	00001097          	auipc	ra,0x1
    3868:	f78080e7          	jalr	-136(ra) # 47dc <printf>
    exit(1);
    386c:	4505                	li	a0,1
    386e:	00001097          	auipc	ra,0x1
    3872:	c06080e7          	jalr	-1018(ra) # 4474 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3876:	00001097          	auipc	ra,0x1
    387a:	c86080e7          	jalr	-890(ra) # 44fc <sbrk>
    387e:	064007b7          	lui	a5,0x6400
    3882:	40a7853b          	subw	a0,a5,a0
    3886:	00001097          	auipc	ra,0x1
    388a:	c76080e7          	jalr	-906(ra) # 44fc <sbrk>
      write(fds[1], "x", 1);
    388e:	4605                	li	a2,1
    3890:	00002597          	auipc	a1,0x2
    3894:	c7058593          	addi	a1,a1,-912 # 5500 <malloc+0xc6c>
    3898:	fb442503          	lw	a0,-76(s0)
    389c:	00001097          	auipc	ra,0x1
    38a0:	bf8080e7          	jalr	-1032(ra) # 4494 <write>
      for(;;) sleep(1000);
    38a4:	3e800513          	li	a0,1000
    38a8:	00001097          	auipc	ra,0x1
    38ac:	c5c080e7          	jalr	-932(ra) # 4504 <sleep>
    38b0:	bfd5                	j	38a4 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    38b2:	0911                	addi	s2,s2,4
    38b4:	03390563          	beq	s2,s3,38de <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    38b8:	00001097          	auipc	ra,0x1
    38bc:	bb4080e7          	jalr	-1100(ra) # 446c <fork>
    38c0:	00a92023          	sw	a0,0(s2)
    38c4:	d94d                	beqz	a0,3876 <sbrkfail+0x4c>
    if(pids[i] != -1)
    38c6:	ff4506e3          	beq	a0,s4,38b2 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    38ca:	4605                	li	a2,1
    38cc:	faf40593          	addi	a1,s0,-81
    38d0:	fb042503          	lw	a0,-80(s0)
    38d4:	00001097          	auipc	ra,0x1
    38d8:	bb8080e7          	jalr	-1096(ra) # 448c <read>
    38dc:	bfd9                	j	38b2 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    38de:	6505                	lui	a0,0x1
    38e0:	00001097          	auipc	ra,0x1
    38e4:	c1c080e7          	jalr	-996(ra) # 44fc <sbrk>
    38e8:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    38ea:	597d                	li	s2,-1
    38ec:	a021                	j	38f4 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    38ee:	0491                	addi	s1,s1,4
    38f0:	01348f63          	beq	s1,s3,390e <sbrkfail+0xe4>
    if(pids[i] == -1)
    38f4:	4088                	lw	a0,0(s1)
    38f6:	ff250ce3          	beq	a0,s2,38ee <sbrkfail+0xc4>
    kill(pids[i]);
    38fa:	00001097          	auipc	ra,0x1
    38fe:	baa080e7          	jalr	-1110(ra) # 44a4 <kill>
    wait(0);
    3902:	4501                	li	a0,0
    3904:	00001097          	auipc	ra,0x1
    3908:	b78080e7          	jalr	-1160(ra) # 447c <wait>
    390c:	b7cd                	j	38ee <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    390e:	57fd                	li	a5,-1
    3910:	02fa0e63          	beq	s4,a5,394c <sbrkfail+0x122>
  pid = fork();
    3914:	00001097          	auipc	ra,0x1
    3918:	b58080e7          	jalr	-1192(ra) # 446c <fork>
    391c:	84aa                	mv	s1,a0
  if(pid < 0){
    391e:	04054563          	bltz	a0,3968 <sbrkfail+0x13e>
  if(pid == 0){
    3922:	c12d                	beqz	a0,3984 <sbrkfail+0x15a>
  wait(&xstatus);
    3924:	fbc40513          	addi	a0,s0,-68
    3928:	00001097          	auipc	ra,0x1
    392c:	b54080e7          	jalr	-1196(ra) # 447c <wait>
  if(xstatus != -1)
    3930:	fbc42703          	lw	a4,-68(s0)
    3934:	57fd                	li	a5,-1
    3936:	08f71c63          	bne	a4,a5,39ce <sbrkfail+0x1a4>
}
    393a:	70e6                	ld	ra,120(sp)
    393c:	7446                	ld	s0,112(sp)
    393e:	74a6                	ld	s1,104(sp)
    3940:	7906                	ld	s2,96(sp)
    3942:	69e6                	ld	s3,88(sp)
    3944:	6a46                	ld	s4,80(sp)
    3946:	6aa6                	ld	s5,72(sp)
    3948:	6109                	addi	sp,sp,128
    394a:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    394c:	85d6                	mv	a1,s5
    394e:	00003517          	auipc	a0,0x3
    3952:	95250513          	addi	a0,a0,-1710 # 62a0 <malloc+0x1a0c>
    3956:	00001097          	auipc	ra,0x1
    395a:	e86080e7          	jalr	-378(ra) # 47dc <printf>
    exit(1);
    395e:	4505                	li	a0,1
    3960:	00001097          	auipc	ra,0x1
    3964:	b14080e7          	jalr	-1260(ra) # 4474 <exit>
    printf("%s: fork failed\n", s);
    3968:	85d6                	mv	a1,s5
    396a:	00001517          	auipc	a0,0x1
    396e:	1c650513          	addi	a0,a0,454 # 4b30 <malloc+0x29c>
    3972:	00001097          	auipc	ra,0x1
    3976:	e6a080e7          	jalr	-406(ra) # 47dc <printf>
    exit(1);
    397a:	4505                	li	a0,1
    397c:	00001097          	auipc	ra,0x1
    3980:	af8080e7          	jalr	-1288(ra) # 4474 <exit>
    a = sbrk(0);
    3984:	4501                	li	a0,0
    3986:	00001097          	auipc	ra,0x1
    398a:	b76080e7          	jalr	-1162(ra) # 44fc <sbrk>
    398e:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3990:	3e800537          	lui	a0,0x3e800
    3994:	00001097          	auipc	ra,0x1
    3998:	b68080e7          	jalr	-1176(ra) # 44fc <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    399c:	87ca                	mv	a5,s2
    399e:	3e800737          	lui	a4,0x3e800
    39a2:	993a                	add	s2,s2,a4
    39a4:	6705                	lui	a4,0x1
      n += *(a+i);
    39a6:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f28e0>
    39aa:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    39ac:	97ba                	add	a5,a5,a4
    39ae:	fef91ce3          	bne	s2,a5,39a6 <sbrkfail+0x17c>
    printf("%s: allocate a lot of memory succeeded %d\n", n);
    39b2:	85a6                	mv	a1,s1
    39b4:	00003517          	auipc	a0,0x3
    39b8:	90c50513          	addi	a0,a0,-1780 # 62c0 <malloc+0x1a2c>
    39bc:	00001097          	auipc	ra,0x1
    39c0:	e20080e7          	jalr	-480(ra) # 47dc <printf>
    exit(1);
    39c4:	4505                	li	a0,1
    39c6:	00001097          	auipc	ra,0x1
    39ca:	aae080e7          	jalr	-1362(ra) # 4474 <exit>
    exit(1);
    39ce:	4505                	li	a0,1
    39d0:	00001097          	auipc	ra,0x1
    39d4:	aa4080e7          	jalr	-1372(ra) # 4474 <exit>

00000000000039d8 <sbrkarg>:
{
    39d8:	7179                	addi	sp,sp,-48
    39da:	f406                	sd	ra,40(sp)
    39dc:	f022                	sd	s0,32(sp)
    39de:	ec26                	sd	s1,24(sp)
    39e0:	e84a                	sd	s2,16(sp)
    39e2:	e44e                	sd	s3,8(sp)
    39e4:	1800                	addi	s0,sp,48
    39e6:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    39e8:	6505                	lui	a0,0x1
    39ea:	00001097          	auipc	ra,0x1
    39ee:	b12080e7          	jalr	-1262(ra) # 44fc <sbrk>
    39f2:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    39f4:	20100593          	li	a1,513
    39f8:	00003517          	auipc	a0,0x3
    39fc:	8f850513          	addi	a0,a0,-1800 # 62f0 <malloc+0x1a5c>
    3a00:	00001097          	auipc	ra,0x1
    3a04:	ab4080e7          	jalr	-1356(ra) # 44b4 <open>
    3a08:	84aa                	mv	s1,a0
  unlink("sbrk");
    3a0a:	00003517          	auipc	a0,0x3
    3a0e:	8e650513          	addi	a0,a0,-1818 # 62f0 <malloc+0x1a5c>
    3a12:	00001097          	auipc	ra,0x1
    3a16:	ab2080e7          	jalr	-1358(ra) # 44c4 <unlink>
  if(fd < 0)  {
    3a1a:	0404c163          	bltz	s1,3a5c <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    3a1e:	6605                	lui	a2,0x1
    3a20:	85ca                	mv	a1,s2
    3a22:	8526                	mv	a0,s1
    3a24:	00001097          	auipc	ra,0x1
    3a28:	a70080e7          	jalr	-1424(ra) # 4494 <write>
    3a2c:	04054663          	bltz	a0,3a78 <sbrkarg+0xa0>
  close(fd);
    3a30:	8526                	mv	a0,s1
    3a32:	00001097          	auipc	ra,0x1
    3a36:	a6a080e7          	jalr	-1430(ra) # 449c <close>
  a = sbrk(PGSIZE);
    3a3a:	6505                	lui	a0,0x1
    3a3c:	00001097          	auipc	ra,0x1
    3a40:	ac0080e7          	jalr	-1344(ra) # 44fc <sbrk>
  if(pipe((int *) a) != 0){
    3a44:	00001097          	auipc	ra,0x1
    3a48:	a40080e7          	jalr	-1472(ra) # 4484 <pipe>
    3a4c:	e521                	bnez	a0,3a94 <sbrkarg+0xbc>
}
    3a4e:	70a2                	ld	ra,40(sp)
    3a50:	7402                	ld	s0,32(sp)
    3a52:	64e2                	ld	s1,24(sp)
    3a54:	6942                	ld	s2,16(sp)
    3a56:	69a2                	ld	s3,8(sp)
    3a58:	6145                	addi	sp,sp,48
    3a5a:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    3a5c:	85ce                	mv	a1,s3
    3a5e:	00003517          	auipc	a0,0x3
    3a62:	89a50513          	addi	a0,a0,-1894 # 62f8 <malloc+0x1a64>
    3a66:	00001097          	auipc	ra,0x1
    3a6a:	d76080e7          	jalr	-650(ra) # 47dc <printf>
    exit(1);
    3a6e:	4505                	li	a0,1
    3a70:	00001097          	auipc	ra,0x1
    3a74:	a04080e7          	jalr	-1532(ra) # 4474 <exit>
    printf("%s: write sbrk failed\n", s);
    3a78:	85ce                	mv	a1,s3
    3a7a:	00003517          	auipc	a0,0x3
    3a7e:	89650513          	addi	a0,a0,-1898 # 6310 <malloc+0x1a7c>
    3a82:	00001097          	auipc	ra,0x1
    3a86:	d5a080e7          	jalr	-678(ra) # 47dc <printf>
    exit(1);
    3a8a:	4505                	li	a0,1
    3a8c:	00001097          	auipc	ra,0x1
    3a90:	9e8080e7          	jalr	-1560(ra) # 4474 <exit>
    printf("%s: pipe() failed\n", s);
    3a94:	85ce                	mv	a1,s3
    3a96:	00002517          	auipc	a0,0x2
    3a9a:	9ea50513          	addi	a0,a0,-1558 # 5480 <malloc+0xbec>
    3a9e:	00001097          	auipc	ra,0x1
    3aa2:	d3e080e7          	jalr	-706(ra) # 47dc <printf>
    exit(1);
    3aa6:	4505                	li	a0,1
    3aa8:	00001097          	auipc	ra,0x1
    3aac:	9cc080e7          	jalr	-1588(ra) # 4474 <exit>

0000000000003ab0 <argptest>:
{
    3ab0:	1101                	addi	sp,sp,-32
    3ab2:	ec06                	sd	ra,24(sp)
    3ab4:	e822                	sd	s0,16(sp)
    3ab6:	e426                	sd	s1,8(sp)
    3ab8:	e04a                	sd	s2,0(sp)
    3aba:	1000                	addi	s0,sp,32
    3abc:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    3abe:	4581                	li	a1,0
    3ac0:	00003517          	auipc	a0,0x3
    3ac4:	86850513          	addi	a0,a0,-1944 # 6328 <malloc+0x1a94>
    3ac8:	00001097          	auipc	ra,0x1
    3acc:	9ec080e7          	jalr	-1556(ra) # 44b4 <open>
  if (fd < 0) {
    3ad0:	02054b63          	bltz	a0,3b06 <argptest+0x56>
    3ad4:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    3ad6:	4501                	li	a0,0
    3ad8:	00001097          	auipc	ra,0x1
    3adc:	a24080e7          	jalr	-1500(ra) # 44fc <sbrk>
    3ae0:	567d                	li	a2,-1
    3ae2:	fff50593          	addi	a1,a0,-1
    3ae6:	8526                	mv	a0,s1
    3ae8:	00001097          	auipc	ra,0x1
    3aec:	9a4080e7          	jalr	-1628(ra) # 448c <read>
  close(fd);
    3af0:	8526                	mv	a0,s1
    3af2:	00001097          	auipc	ra,0x1
    3af6:	9aa080e7          	jalr	-1622(ra) # 449c <close>
}
    3afa:	60e2                	ld	ra,24(sp)
    3afc:	6442                	ld	s0,16(sp)
    3afe:	64a2                	ld	s1,8(sp)
    3b00:	6902                	ld	s2,0(sp)
    3b02:	6105                	addi	sp,sp,32
    3b04:	8082                	ret
    printf("%s: open failed\n", s);
    3b06:	85ca                	mv	a1,s2
    3b08:	00002517          	auipc	a0,0x2
    3b0c:	81850513          	addi	a0,a0,-2024 # 5320 <malloc+0xa8c>
    3b10:	00001097          	auipc	ra,0x1
    3b14:	ccc080e7          	jalr	-820(ra) # 47dc <printf>
    exit(1);
    3b18:	4505                	li	a0,1
    3b1a:	00001097          	auipc	ra,0x1
    3b1e:	95a080e7          	jalr	-1702(ra) # 4474 <exit>

0000000000003b22 <sbrkbugs>:
{
    3b22:	1141                	addi	sp,sp,-16
    3b24:	e406                	sd	ra,8(sp)
    3b26:	e022                	sd	s0,0(sp)
    3b28:	0800                	addi	s0,sp,16
  int pid = fork();
    3b2a:	00001097          	auipc	ra,0x1
    3b2e:	942080e7          	jalr	-1726(ra) # 446c <fork>
  if(pid < 0){
    3b32:	02054263          	bltz	a0,3b56 <sbrkbugs+0x34>
  if(pid == 0){
    3b36:	ed0d                	bnez	a0,3b70 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    3b38:	00001097          	auipc	ra,0x1
    3b3c:	9c4080e7          	jalr	-1596(ra) # 44fc <sbrk>
    sbrk(-sz);
    3b40:	40a0053b          	negw	a0,a0
    3b44:	00001097          	auipc	ra,0x1
    3b48:	9b8080e7          	jalr	-1608(ra) # 44fc <sbrk>
    exit(0);
    3b4c:	4501                	li	a0,0
    3b4e:	00001097          	auipc	ra,0x1
    3b52:	926080e7          	jalr	-1754(ra) # 4474 <exit>
    printf("fork failed\n");
    3b56:	00002517          	auipc	a0,0x2
    3b5a:	8fa50513          	addi	a0,a0,-1798 # 5450 <malloc+0xbbc>
    3b5e:	00001097          	auipc	ra,0x1
    3b62:	c7e080e7          	jalr	-898(ra) # 47dc <printf>
    exit(1);
    3b66:	4505                	li	a0,1
    3b68:	00001097          	auipc	ra,0x1
    3b6c:	90c080e7          	jalr	-1780(ra) # 4474 <exit>
  wait(0);
    3b70:	4501                	li	a0,0
    3b72:	00001097          	auipc	ra,0x1
    3b76:	90a080e7          	jalr	-1782(ra) # 447c <wait>
  pid = fork();
    3b7a:	00001097          	auipc	ra,0x1
    3b7e:	8f2080e7          	jalr	-1806(ra) # 446c <fork>
  if(pid < 0){
    3b82:	02054563          	bltz	a0,3bac <sbrkbugs+0x8a>
  if(pid == 0){
    3b86:	e121                	bnez	a0,3bc6 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    3b88:	00001097          	auipc	ra,0x1
    3b8c:	974080e7          	jalr	-1676(ra) # 44fc <sbrk>
    sbrk(-(sz - 3500));
    3b90:	6785                	lui	a5,0x1
    3b92:	dac7879b          	addiw	a5,a5,-596 # dac <fourteen+0x9e>
    3b96:	40a7853b          	subw	a0,a5,a0
    3b9a:	00001097          	auipc	ra,0x1
    3b9e:	962080e7          	jalr	-1694(ra) # 44fc <sbrk>
    exit(0);
    3ba2:	4501                	li	a0,0
    3ba4:	00001097          	auipc	ra,0x1
    3ba8:	8d0080e7          	jalr	-1840(ra) # 4474 <exit>
    printf("fork failed\n");
    3bac:	00002517          	auipc	a0,0x2
    3bb0:	8a450513          	addi	a0,a0,-1884 # 5450 <malloc+0xbbc>
    3bb4:	00001097          	auipc	ra,0x1
    3bb8:	c28080e7          	jalr	-984(ra) # 47dc <printf>
    exit(1);
    3bbc:	4505                	li	a0,1
    3bbe:	00001097          	auipc	ra,0x1
    3bc2:	8b6080e7          	jalr	-1866(ra) # 4474 <exit>
  wait(0);
    3bc6:	4501                	li	a0,0
    3bc8:	00001097          	auipc	ra,0x1
    3bcc:	8b4080e7          	jalr	-1868(ra) # 447c <wait>
  pid = fork();
    3bd0:	00001097          	auipc	ra,0x1
    3bd4:	89c080e7          	jalr	-1892(ra) # 446c <fork>
  if(pid < 0){
    3bd8:	02054a63          	bltz	a0,3c0c <sbrkbugs+0xea>
  if(pid == 0){
    3bdc:	e529                	bnez	a0,3c26 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    3bde:	00001097          	auipc	ra,0x1
    3be2:	91e080e7          	jalr	-1762(ra) # 44fc <sbrk>
    3be6:	67ad                	lui	a5,0xb
    3be8:	8007879b          	addiw	a5,a5,-2048 # a800 <buf+0xe0>
    3bec:	40a7853b          	subw	a0,a5,a0
    3bf0:	00001097          	auipc	ra,0x1
    3bf4:	90c080e7          	jalr	-1780(ra) # 44fc <sbrk>
    sbrk(-10);
    3bf8:	5559                	li	a0,-10
    3bfa:	00001097          	auipc	ra,0x1
    3bfe:	902080e7          	jalr	-1790(ra) # 44fc <sbrk>
    exit(0);
    3c02:	4501                	li	a0,0
    3c04:	00001097          	auipc	ra,0x1
    3c08:	870080e7          	jalr	-1936(ra) # 4474 <exit>
    printf("fork failed\n");
    3c0c:	00002517          	auipc	a0,0x2
    3c10:	84450513          	addi	a0,a0,-1980 # 5450 <malloc+0xbbc>
    3c14:	00001097          	auipc	ra,0x1
    3c18:	bc8080e7          	jalr	-1080(ra) # 47dc <printf>
    exit(1);
    3c1c:	4505                	li	a0,1
    3c1e:	00001097          	auipc	ra,0x1
    3c22:	856080e7          	jalr	-1962(ra) # 4474 <exit>
  wait(0);
    3c26:	4501                	li	a0,0
    3c28:	00001097          	auipc	ra,0x1
    3c2c:	854080e7          	jalr	-1964(ra) # 447c <wait>
  exit(0);
    3c30:	4501                	li	a0,0
    3c32:	00001097          	auipc	ra,0x1
    3c36:	842080e7          	jalr	-1982(ra) # 4474 <exit>

0000000000003c3a <dirtest>:
{
    3c3a:	1101                	addi	sp,sp,-32
    3c3c:	ec06                	sd	ra,24(sp)
    3c3e:	e822                	sd	s0,16(sp)
    3c40:	e426                	sd	s1,8(sp)
    3c42:	1000                	addi	s0,sp,32
    3c44:	84aa                	mv	s1,a0
  printf("mkdir test\n");
    3c46:	00002517          	auipc	a0,0x2
    3c4a:	6ea50513          	addi	a0,a0,1770 # 6330 <malloc+0x1a9c>
    3c4e:	00001097          	auipc	ra,0x1
    3c52:	b8e080e7          	jalr	-1138(ra) # 47dc <printf>
  if(mkdir("dir0") < 0){
    3c56:	00002517          	auipc	a0,0x2
    3c5a:	6ea50513          	addi	a0,a0,1770 # 6340 <malloc+0x1aac>
    3c5e:	00001097          	auipc	ra,0x1
    3c62:	87e080e7          	jalr	-1922(ra) # 44dc <mkdir>
    3c66:	04054d63          	bltz	a0,3cc0 <dirtest+0x86>
  if(chdir("dir0") < 0){
    3c6a:	00002517          	auipc	a0,0x2
    3c6e:	6d650513          	addi	a0,a0,1750 # 6340 <malloc+0x1aac>
    3c72:	00001097          	auipc	ra,0x1
    3c76:	872080e7          	jalr	-1934(ra) # 44e4 <chdir>
    3c7a:	06054163          	bltz	a0,3cdc <dirtest+0xa2>
  if(chdir("..") < 0){
    3c7e:	00001517          	auipc	a0,0x1
    3c82:	e2250513          	addi	a0,a0,-478 # 4aa0 <malloc+0x20c>
    3c86:	00001097          	auipc	ra,0x1
    3c8a:	85e080e7          	jalr	-1954(ra) # 44e4 <chdir>
    3c8e:	06054563          	bltz	a0,3cf8 <dirtest+0xbe>
  if(unlink("dir0") < 0){
    3c92:	00002517          	auipc	a0,0x2
    3c96:	6ae50513          	addi	a0,a0,1710 # 6340 <malloc+0x1aac>
    3c9a:	00001097          	auipc	ra,0x1
    3c9e:	82a080e7          	jalr	-2006(ra) # 44c4 <unlink>
    3ca2:	06054963          	bltz	a0,3d14 <dirtest+0xda>
  printf("%s: mkdir test ok\n");
    3ca6:	00002517          	auipc	a0,0x2
    3caa:	6ea50513          	addi	a0,a0,1770 # 6390 <malloc+0x1afc>
    3cae:	00001097          	auipc	ra,0x1
    3cb2:	b2e080e7          	jalr	-1234(ra) # 47dc <printf>
}
    3cb6:	60e2                	ld	ra,24(sp)
    3cb8:	6442                	ld	s0,16(sp)
    3cba:	64a2                	ld	s1,8(sp)
    3cbc:	6105                	addi	sp,sp,32
    3cbe:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3cc0:	85a6                	mv	a1,s1
    3cc2:	00001517          	auipc	a0,0x1
    3cc6:	cfe50513          	addi	a0,a0,-770 # 49c0 <malloc+0x12c>
    3cca:	00001097          	auipc	ra,0x1
    3cce:	b12080e7          	jalr	-1262(ra) # 47dc <printf>
    exit(1);
    3cd2:	4505                	li	a0,1
    3cd4:	00000097          	auipc	ra,0x0
    3cd8:	7a0080e7          	jalr	1952(ra) # 4474 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3cdc:	85a6                	mv	a1,s1
    3cde:	00002517          	auipc	a0,0x2
    3ce2:	66a50513          	addi	a0,a0,1642 # 6348 <malloc+0x1ab4>
    3ce6:	00001097          	auipc	ra,0x1
    3cea:	af6080e7          	jalr	-1290(ra) # 47dc <printf>
    exit(1);
    3cee:	4505                	li	a0,1
    3cf0:	00000097          	auipc	ra,0x0
    3cf4:	784080e7          	jalr	1924(ra) # 4474 <exit>
    printf("%s: chdir .. failed\n", s);
    3cf8:	85a6                	mv	a1,s1
    3cfa:	00002517          	auipc	a0,0x2
    3cfe:	66650513          	addi	a0,a0,1638 # 6360 <malloc+0x1acc>
    3d02:	00001097          	auipc	ra,0x1
    3d06:	ada080e7          	jalr	-1318(ra) # 47dc <printf>
    exit(1);
    3d0a:	4505                	li	a0,1
    3d0c:	00000097          	auipc	ra,0x0
    3d10:	768080e7          	jalr	1896(ra) # 4474 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3d14:	85a6                	mv	a1,s1
    3d16:	00002517          	auipc	a0,0x2
    3d1a:	66250513          	addi	a0,a0,1634 # 6378 <malloc+0x1ae4>
    3d1e:	00001097          	auipc	ra,0x1
    3d22:	abe080e7          	jalr	-1346(ra) # 47dc <printf>
    exit(1);
    3d26:	4505                	li	a0,1
    3d28:	00000097          	auipc	ra,0x0
    3d2c:	74c080e7          	jalr	1868(ra) # 4474 <exit>

0000000000003d30 <fsfull>:
{
    3d30:	7135                	addi	sp,sp,-160
    3d32:	ed06                	sd	ra,152(sp)
    3d34:	e922                	sd	s0,144(sp)
    3d36:	e526                	sd	s1,136(sp)
    3d38:	e14a                	sd	s2,128(sp)
    3d3a:	fcce                	sd	s3,120(sp)
    3d3c:	f8d2                	sd	s4,112(sp)
    3d3e:	f4d6                	sd	s5,104(sp)
    3d40:	f0da                	sd	s6,96(sp)
    3d42:	ecde                	sd	s7,88(sp)
    3d44:	e8e2                	sd	s8,80(sp)
    3d46:	e4e6                	sd	s9,72(sp)
    3d48:	e0ea                	sd	s10,64(sp)
    3d4a:	1100                	addi	s0,sp,160
  printf("fsfull test\n");
    3d4c:	00002517          	auipc	a0,0x2
    3d50:	65c50513          	addi	a0,a0,1628 # 63a8 <malloc+0x1b14>
    3d54:	00001097          	auipc	ra,0x1
    3d58:	a88080e7          	jalr	-1400(ra) # 47dc <printf>
  for(nfiles = 0; ; nfiles++){
    3d5c:	4481                	li	s1,0
    name[0] = 'f';
    3d5e:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    3d62:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    3d66:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    3d6a:	4b29                	li	s6,10
    printf("%s: writing %s\n", name);
    3d6c:	00002c97          	auipc	s9,0x2
    3d70:	64cc8c93          	addi	s9,s9,1612 # 63b8 <malloc+0x1b24>
    name[0] = 'f';
    3d74:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    3d78:	0384c7bb          	divw	a5,s1,s8
    3d7c:	0307879b          	addiw	a5,a5,48
    3d80:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3d84:	0384e7bb          	remw	a5,s1,s8
    3d88:	0377c7bb          	divw	a5,a5,s7
    3d8c:	0307879b          	addiw	a5,a5,48
    3d90:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3d94:	0374e7bb          	remw	a5,s1,s7
    3d98:	0367c7bb          	divw	a5,a5,s6
    3d9c:	0307879b          	addiw	a5,a5,48
    3da0:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    3da4:	0364e7bb          	remw	a5,s1,s6
    3da8:	0307879b          	addiw	a5,a5,48
    3dac:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    3db0:	f60402a3          	sb	zero,-155(s0)
    printf("%s: writing %s\n", name);
    3db4:	f6040593          	addi	a1,s0,-160
    3db8:	8566                	mv	a0,s9
    3dba:	00001097          	auipc	ra,0x1
    3dbe:	a22080e7          	jalr	-1502(ra) # 47dc <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3dc2:	20200593          	li	a1,514
    3dc6:	f6040513          	addi	a0,s0,-160
    3dca:	00000097          	auipc	ra,0x0
    3dce:	6ea080e7          	jalr	1770(ra) # 44b4 <open>
    3dd2:	892a                	mv	s2,a0
    if(fd < 0){
    3dd4:	0a055563          	bgez	a0,3e7e <fsfull+0x14e>
      printf("%s: open %s failed\n", name);
    3dd8:	f6040593          	addi	a1,s0,-160
    3ddc:	00002517          	auipc	a0,0x2
    3de0:	5ec50513          	addi	a0,a0,1516 # 63c8 <malloc+0x1b34>
    3de4:	00001097          	auipc	ra,0x1
    3de8:	9f8080e7          	jalr	-1544(ra) # 47dc <printf>
  while(nfiles >= 0){
    3dec:	0604c363          	bltz	s1,3e52 <fsfull+0x122>
    name[0] = 'f';
    3df0:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    3df4:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    3df8:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    3dfc:	4929                	li	s2,10
  while(nfiles >= 0){
    3dfe:	5afd                	li	s5,-1
    name[0] = 'f';
    3e00:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    3e04:	0344c7bb          	divw	a5,s1,s4
    3e08:	0307879b          	addiw	a5,a5,48
    3e0c:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3e10:	0344e7bb          	remw	a5,s1,s4
    3e14:	0337c7bb          	divw	a5,a5,s3
    3e18:	0307879b          	addiw	a5,a5,48
    3e1c:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3e20:	0334e7bb          	remw	a5,s1,s3
    3e24:	0327c7bb          	divw	a5,a5,s2
    3e28:	0307879b          	addiw	a5,a5,48
    3e2c:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    3e30:	0324e7bb          	remw	a5,s1,s2
    3e34:	0307879b          	addiw	a5,a5,48
    3e38:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    3e3c:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    3e40:	f6040513          	addi	a0,s0,-160
    3e44:	00000097          	auipc	ra,0x0
    3e48:	680080e7          	jalr	1664(ra) # 44c4 <unlink>
    nfiles--;
    3e4c:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    3e4e:	fb5499e3          	bne	s1,s5,3e00 <fsfull+0xd0>
  printf("fsfull test finished\n");
    3e52:	00002517          	auipc	a0,0x2
    3e56:	5a650513          	addi	a0,a0,1446 # 63f8 <malloc+0x1b64>
    3e5a:	00001097          	auipc	ra,0x1
    3e5e:	982080e7          	jalr	-1662(ra) # 47dc <printf>
}
    3e62:	60ea                	ld	ra,152(sp)
    3e64:	644a                	ld	s0,144(sp)
    3e66:	64aa                	ld	s1,136(sp)
    3e68:	690a                	ld	s2,128(sp)
    3e6a:	79e6                	ld	s3,120(sp)
    3e6c:	7a46                	ld	s4,112(sp)
    3e6e:	7aa6                	ld	s5,104(sp)
    3e70:	7b06                	ld	s6,96(sp)
    3e72:	6be6                	ld	s7,88(sp)
    3e74:	6c46                	ld	s8,80(sp)
    3e76:	6ca6                	ld	s9,72(sp)
    3e78:	6d06                	ld	s10,64(sp)
    3e7a:	610d                	addi	sp,sp,160
    3e7c:	8082                	ret
    int total = 0;
    3e7e:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    3e80:	00007a97          	auipc	s5,0x7
    3e84:	8a0a8a93          	addi	s5,s5,-1888 # a720 <buf>
      if(cc < BSIZE)
    3e88:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    3e8c:	40000613          	li	a2,1024
    3e90:	85d6                	mv	a1,s5
    3e92:	854a                	mv	a0,s2
    3e94:	00000097          	auipc	ra,0x0
    3e98:	600080e7          	jalr	1536(ra) # 4494 <write>
      if(cc < BSIZE)
    3e9c:	00aa5563          	bge	s4,a0,3ea6 <fsfull+0x176>
      total += cc;
    3ea0:	00a989bb          	addw	s3,s3,a0
    while(1){
    3ea4:	b7e5                	j	3e8c <fsfull+0x15c>
    printf("%s: wrote %d bytes\n", total);
    3ea6:	85ce                	mv	a1,s3
    3ea8:	00002517          	auipc	a0,0x2
    3eac:	53850513          	addi	a0,a0,1336 # 63e0 <malloc+0x1b4c>
    3eb0:	00001097          	auipc	ra,0x1
    3eb4:	92c080e7          	jalr	-1748(ra) # 47dc <printf>
    close(fd);
    3eb8:	854a                	mv	a0,s2
    3eba:	00000097          	auipc	ra,0x0
    3ebe:	5e2080e7          	jalr	1506(ra) # 449c <close>
    if(total == 0)
    3ec2:	f20985e3          	beqz	s3,3dec <fsfull+0xbc>
  for(nfiles = 0; ; nfiles++){
    3ec6:	2485                	addiw	s1,s1,1
    3ec8:	b575                	j	3d74 <fsfull+0x44>

0000000000003eca <rand>:
{
    3eca:	1141                	addi	sp,sp,-16
    3ecc:	e422                	sd	s0,8(sp)
    3ece:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    3ed0:	00004717          	auipc	a4,0x4
    3ed4:	02070713          	addi	a4,a4,32 # 7ef0 <randstate>
    3ed8:	6308                	ld	a0,0(a4)
    3eda:	001967b7          	lui	a5,0x196
    3ede:	60d78793          	addi	a5,a5,1549 # 19660d <base+0x188eed>
    3ee2:	02f50533          	mul	a0,a0,a5
    3ee6:	3c6ef7b7          	lui	a5,0x3c6ef
    3eea:	35f78793          	addi	a5,a5,863 # 3c6ef35f <base+0x3c6e1c3f>
    3eee:	953e                	add	a0,a0,a5
    3ef0:	e308                	sd	a0,0(a4)
}
    3ef2:	2501                	sext.w	a0,a0
    3ef4:	6422                	ld	s0,8(sp)
    3ef6:	0141                	addi	sp,sp,16
    3ef8:	8082                	ret

0000000000003efa <badwrite>:
{
    3efa:	7179                	addi	sp,sp,-48
    3efc:	f406                	sd	ra,40(sp)
    3efe:	f022                	sd	s0,32(sp)
    3f00:	ec26                	sd	s1,24(sp)
    3f02:	e84a                	sd	s2,16(sp)
    3f04:	e44e                	sd	s3,8(sp)
    3f06:	e052                	sd	s4,0(sp)
    3f08:	1800                	addi	s0,sp,48
  unlink("junk");
    3f0a:	00002517          	auipc	a0,0x2
    3f0e:	50650513          	addi	a0,a0,1286 # 6410 <malloc+0x1b7c>
    3f12:	00000097          	auipc	ra,0x0
    3f16:	5b2080e7          	jalr	1458(ra) # 44c4 <unlink>
    3f1a:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    3f1e:	00002997          	auipc	s3,0x2
    3f22:	4f298993          	addi	s3,s3,1266 # 6410 <malloc+0x1b7c>
    write(fd, (char*)0xffffffffffL, 1);
    3f26:	5a7d                	li	s4,-1
    3f28:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    3f2c:	20100593          	li	a1,513
    3f30:	854e                	mv	a0,s3
    3f32:	00000097          	auipc	ra,0x0
    3f36:	582080e7          	jalr	1410(ra) # 44b4 <open>
    3f3a:	84aa                	mv	s1,a0
    if(fd < 0){
    3f3c:	06054b63          	bltz	a0,3fb2 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    3f40:	4605                	li	a2,1
    3f42:	85d2                	mv	a1,s4
    3f44:	00000097          	auipc	ra,0x0
    3f48:	550080e7          	jalr	1360(ra) # 4494 <write>
    close(fd);
    3f4c:	8526                	mv	a0,s1
    3f4e:	00000097          	auipc	ra,0x0
    3f52:	54e080e7          	jalr	1358(ra) # 449c <close>
    unlink("junk");
    3f56:	854e                	mv	a0,s3
    3f58:	00000097          	auipc	ra,0x0
    3f5c:	56c080e7          	jalr	1388(ra) # 44c4 <unlink>
  for(int i = 0; i < assumed_free; i++){
    3f60:	397d                	addiw	s2,s2,-1
    3f62:	fc0915e3          	bnez	s2,3f2c <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    3f66:	20100593          	li	a1,513
    3f6a:	00002517          	auipc	a0,0x2
    3f6e:	4a650513          	addi	a0,a0,1190 # 6410 <malloc+0x1b7c>
    3f72:	00000097          	auipc	ra,0x0
    3f76:	542080e7          	jalr	1346(ra) # 44b4 <open>
    3f7a:	84aa                	mv	s1,a0
  if(fd < 0){
    3f7c:	04054863          	bltz	a0,3fcc <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    3f80:	4605                	li	a2,1
    3f82:	00001597          	auipc	a1,0x1
    3f86:	57e58593          	addi	a1,a1,1406 # 5500 <malloc+0xc6c>
    3f8a:	00000097          	auipc	ra,0x0
    3f8e:	50a080e7          	jalr	1290(ra) # 4494 <write>
    3f92:	4785                	li	a5,1
    3f94:	04f50963          	beq	a0,a5,3fe6 <badwrite+0xec>
    printf("write failed\n");
    3f98:	00002517          	auipc	a0,0x2
    3f9c:	49850513          	addi	a0,a0,1176 # 6430 <malloc+0x1b9c>
    3fa0:	00001097          	auipc	ra,0x1
    3fa4:	83c080e7          	jalr	-1988(ra) # 47dc <printf>
    exit(1);
    3fa8:	4505                	li	a0,1
    3faa:	00000097          	auipc	ra,0x0
    3fae:	4ca080e7          	jalr	1226(ra) # 4474 <exit>
      printf("open junk failed\n");
    3fb2:	00002517          	auipc	a0,0x2
    3fb6:	46650513          	addi	a0,a0,1126 # 6418 <malloc+0x1b84>
    3fba:	00001097          	auipc	ra,0x1
    3fbe:	822080e7          	jalr	-2014(ra) # 47dc <printf>
      exit(1);
    3fc2:	4505                	li	a0,1
    3fc4:	00000097          	auipc	ra,0x0
    3fc8:	4b0080e7          	jalr	1200(ra) # 4474 <exit>
    printf("open junk failed\n");
    3fcc:	00002517          	auipc	a0,0x2
    3fd0:	44c50513          	addi	a0,a0,1100 # 6418 <malloc+0x1b84>
    3fd4:	00001097          	auipc	ra,0x1
    3fd8:	808080e7          	jalr	-2040(ra) # 47dc <printf>
    exit(1);
    3fdc:	4505                	li	a0,1
    3fde:	00000097          	auipc	ra,0x0
    3fe2:	496080e7          	jalr	1174(ra) # 4474 <exit>
  close(fd);
    3fe6:	8526                	mv	a0,s1
    3fe8:	00000097          	auipc	ra,0x0
    3fec:	4b4080e7          	jalr	1204(ra) # 449c <close>
  unlink("junk");
    3ff0:	00002517          	auipc	a0,0x2
    3ff4:	42050513          	addi	a0,a0,1056 # 6410 <malloc+0x1b7c>
    3ff8:	00000097          	auipc	ra,0x0
    3ffc:	4cc080e7          	jalr	1228(ra) # 44c4 <unlink>
  exit(0);
    4000:	4501                	li	a0,0
    4002:	00000097          	auipc	ra,0x0
    4006:	472080e7          	jalr	1138(ra) # 4474 <exit>

000000000000400a <run>:
}

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    400a:	7179                	addi	sp,sp,-48
    400c:	f406                	sd	ra,40(sp)
    400e:	f022                	sd	s0,32(sp)
    4010:	ec26                	sd	s1,24(sp)
    4012:	e84a                	sd	s2,16(sp)
    4014:	1800                	addi	s0,sp,48
    4016:	892a                	mv	s2,a0
    4018:	84ae                	mv	s1,a1
  int pid;
  int xstatus;
  
  printf("test %s: ", s);
    401a:	00002517          	auipc	a0,0x2
    401e:	42650513          	addi	a0,a0,1062 # 6440 <malloc+0x1bac>
    4022:	00000097          	auipc	ra,0x0
    4026:	7ba080e7          	jalr	1978(ra) # 47dc <printf>
  if((pid = fork()) < 0) {
    402a:	00000097          	auipc	ra,0x0
    402e:	442080e7          	jalr	1090(ra) # 446c <fork>
    4032:	02054f63          	bltz	a0,4070 <run+0x66>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4036:	c931                	beqz	a0,408a <run+0x80>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4038:	fdc40513          	addi	a0,s0,-36
    403c:	00000097          	auipc	ra,0x0
    4040:	440080e7          	jalr	1088(ra) # 447c <wait>
    if(xstatus != 0) 
    4044:	fdc42783          	lw	a5,-36(s0)
    4048:	cba1                	beqz	a5,4098 <run+0x8e>
      printf("FAILED\n", s);
    404a:	85a6                	mv	a1,s1
    404c:	00002517          	auipc	a0,0x2
    4050:	41c50513          	addi	a0,a0,1052 # 6468 <malloc+0x1bd4>
    4054:	00000097          	auipc	ra,0x0
    4058:	788080e7          	jalr	1928(ra) # 47dc <printf>
    else
      printf("OK\n", s);
    return xstatus == 0;
    405c:	fdc42503          	lw	a0,-36(s0)
  }
}
    4060:	00153513          	seqz	a0,a0
    4064:	70a2                	ld	ra,40(sp)
    4066:	7402                	ld	s0,32(sp)
    4068:	64e2                	ld	s1,24(sp)
    406a:	6942                	ld	s2,16(sp)
    406c:	6145                	addi	sp,sp,48
    406e:	8082                	ret
    printf("runtest: fork error\n");
    4070:	00002517          	auipc	a0,0x2
    4074:	3e050513          	addi	a0,a0,992 # 6450 <malloc+0x1bbc>
    4078:	00000097          	auipc	ra,0x0
    407c:	764080e7          	jalr	1892(ra) # 47dc <printf>
    exit(1);
    4080:	4505                	li	a0,1
    4082:	00000097          	auipc	ra,0x0
    4086:	3f2080e7          	jalr	1010(ra) # 4474 <exit>
    f(s);
    408a:	8526                	mv	a0,s1
    408c:	9902                	jalr	s2
    exit(0);
    408e:	4501                	li	a0,0
    4090:	00000097          	auipc	ra,0x0
    4094:	3e4080e7          	jalr	996(ra) # 4474 <exit>
      printf("OK\n", s);
    4098:	85a6                	mv	a1,s1
    409a:	00002517          	auipc	a0,0x2
    409e:	3d650513          	addi	a0,a0,982 # 6470 <malloc+0x1bdc>
    40a2:	00000097          	auipc	ra,0x0
    40a6:	73a080e7          	jalr	1850(ra) # 47dc <printf>
    40aa:	bf4d                	j	405c <run+0x52>

00000000000040ac <main>:

int
main(int argc, char *argv[])
{
    40ac:	cd010113          	addi	sp,sp,-816
    40b0:	32113423          	sd	ra,808(sp)
    40b4:	32813023          	sd	s0,800(sp)
    40b8:	31313423          	sd	s3,776(sp)
    40bc:	1e00                	addi	s0,sp,816
  char *n = 0;
  if(argc > 1) {
    40be:	4785                	li	a5,1
  char *n = 0;
    40c0:	4981                	li	s3,0
  if(argc > 1) {
    40c2:	00a7d463          	bge	a5,a0,40ca <main+0x1e>
    n = argv[1];
    40c6:	0085b983          	ld	s3,8(a1)
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    40ca:	00002797          	auipc	a5,0x2
    40ce:	68678793          	addi	a5,a5,1670 # 6750 <malloc+0x1ebc>
    40d2:	cd040713          	addi	a4,s0,-816
    40d6:	00003817          	auipc	a6,0x3
    40da:	95a80813          	addi	a6,a6,-1702 # 6a30 <malloc+0x219c>
    40de:	6388                	ld	a0,0(a5)
    40e0:	678c                	ld	a1,8(a5)
    40e2:	6b90                	ld	a2,16(a5)
    40e4:	6f94                	ld	a3,24(a5)
    40e6:	e308                	sd	a0,0(a4)
    40e8:	e70c                	sd	a1,8(a4)
    40ea:	eb10                	sd	a2,16(a4)
    40ec:	ef14                	sd	a3,24(a4)
    40ee:	02078793          	addi	a5,a5,32
    40f2:	02070713          	addi	a4,a4,32
    40f6:	ff0794e3          	bne	a5,a6,40de <main+0x32>
    40fa:	6394                	ld	a3,0(a5)
    40fc:	679c                	ld	a5,8(a5)
    40fe:	e314                	sd	a3,0(a4)
    4100:	e71c                	sd	a5,8(a4)
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };
    
  printf("usertests starting\n");
    4102:	00002517          	auipc	a0,0x2
    4106:	37650513          	addi	a0,a0,886 # 6478 <malloc+0x1be4>
    410a:	00000097          	auipc	ra,0x0
    410e:	6d2080e7          	jalr	1746(ra) # 47dc <printf>

  if(open("usertests.ran", 0) >= 0){
    4112:	4581                	li	a1,0
    4114:	00002517          	auipc	a0,0x2
    4118:	37c50513          	addi	a0,a0,892 # 6490 <malloc+0x1bfc>
    411c:	00000097          	auipc	ra,0x0
    4120:	398080e7          	jalr	920(ra) # 44b4 <open>
    4124:	02054763          	bltz	a0,4152 <main+0xa6>
    4128:	30913c23          	sd	s1,792(sp)
    412c:	31213823          	sd	s2,784(sp)
    4130:	31413023          	sd	s4,768(sp)
    4134:	2f513c23          	sd	s5,760(sp)
    printf("already ran user tests -- rebuild fs.img (rm fs.img; make fs.img)\n");
    4138:	00002517          	auipc	a0,0x2
    413c:	36850513          	addi	a0,a0,872 # 64a0 <malloc+0x1c0c>
    4140:	00000097          	auipc	ra,0x0
    4144:	69c080e7          	jalr	1692(ra) # 47dc <printf>
    exit(1);
    4148:	4505                	li	a0,1
    414a:	00000097          	auipc	ra,0x0
    414e:	32a080e7          	jalr	810(ra) # 4474 <exit>
    4152:	30913c23          	sd	s1,792(sp)
    4156:	31213823          	sd	s2,784(sp)
    415a:	31413023          	sd	s4,768(sp)
    415e:	2f513c23          	sd	s5,760(sp)
  }
  close(open("usertests.ran", O_CREATE));
    4162:	20000593          	li	a1,512
    4166:	00002517          	auipc	a0,0x2
    416a:	32a50513          	addi	a0,a0,810 # 6490 <malloc+0x1bfc>
    416e:	00000097          	auipc	ra,0x0
    4172:	346080e7          	jalr	838(ra) # 44b4 <open>
    4176:	00000097          	auipc	ra,0x0
    417a:	326080e7          	jalr	806(ra) # 449c <close>

  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    417e:	cd843903          	ld	s2,-808(s0)
    4182:	04090963          	beqz	s2,41d4 <main+0x128>
    4186:	cd040493          	addi	s1,s0,-816
  int fail = 0;
    418a:	4a01                	li	s4,0
    if((n == 0) || strcmp(t->s, n) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    418c:	4a85                	li	s5,1
    418e:	a031                	j	419a <main+0xee>
  for (struct test *t = tests; t->s != 0; t++) {
    4190:	04c1                	addi	s1,s1,16
    4192:	0084b903          	ld	s2,8(s1)
    4196:	02090463          	beqz	s2,41be <main+0x112>
    if((n == 0) || strcmp(t->s, n) == 0) {
    419a:	00098963          	beqz	s3,41ac <main+0x100>
    419e:	85ce                	mv	a1,s3
    41a0:	854a                	mv	a0,s2
    41a2:	00000097          	auipc	ra,0x0
    41a6:	082080e7          	jalr	130(ra) # 4224 <strcmp>
    41aa:	f17d                	bnez	a0,4190 <main+0xe4>
      if(!run(t->f, t->s))
    41ac:	85ca                	mv	a1,s2
    41ae:	6088                	ld	a0,0(s1)
    41b0:	00000097          	auipc	ra,0x0
    41b4:	e5a080e7          	jalr	-422(ra) # 400a <run>
    41b8:	fd61                	bnez	a0,4190 <main+0xe4>
        fail = 1;
    41ba:	8a56                	mv	s4,s5
    41bc:	bfd1                	j	4190 <main+0xe4>
    }
  }
  if(!fail)
    41be:	000a0b63          	beqz	s4,41d4 <main+0x128>
    printf("ALL TESTS PASSED\n");
  else
    printf("SOME TESTS FAILED\n");
    41c2:	00002517          	auipc	a0,0x2
    41c6:	33e50513          	addi	a0,a0,830 # 6500 <malloc+0x1c6c>
    41ca:	00000097          	auipc	ra,0x0
    41ce:	612080e7          	jalr	1554(ra) # 47dc <printf>
    41d2:	a809                	j	41e4 <main+0x138>
    printf("ALL TESTS PASSED\n");
    41d4:	00002517          	auipc	a0,0x2
    41d8:	31450513          	addi	a0,a0,788 # 64e8 <malloc+0x1c54>
    41dc:	00000097          	auipc	ra,0x0
    41e0:	600080e7          	jalr	1536(ra) # 47dc <printf>
  exit(1);   // not reached.
    41e4:	4505                	li	a0,1
    41e6:	00000097          	auipc	ra,0x0
    41ea:	28e080e7          	jalr	654(ra) # 4474 <exit>

00000000000041ee <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    41ee:	1141                	addi	sp,sp,-16
    41f0:	e406                	sd	ra,8(sp)
    41f2:	e022                	sd	s0,0(sp)
    41f4:	0800                	addi	s0,sp,16
  extern int main();
  main();
    41f6:	00000097          	auipc	ra,0x0
    41fa:	eb6080e7          	jalr	-330(ra) # 40ac <main>
  exit(0);
    41fe:	4501                	li	a0,0
    4200:	00000097          	auipc	ra,0x0
    4204:	274080e7          	jalr	628(ra) # 4474 <exit>

0000000000004208 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    4208:	1141                	addi	sp,sp,-16
    420a:	e422                	sd	s0,8(sp)
    420c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    420e:	87aa                	mv	a5,a0
    4210:	0585                	addi	a1,a1,1
    4212:	0785                	addi	a5,a5,1
    4214:	fff5c703          	lbu	a4,-1(a1)
    4218:	fee78fa3          	sb	a4,-1(a5)
    421c:	fb75                	bnez	a4,4210 <strcpy+0x8>
    ;
  return os;
}
    421e:	6422                	ld	s0,8(sp)
    4220:	0141                	addi	sp,sp,16
    4222:	8082                	ret

0000000000004224 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4224:	1141                	addi	sp,sp,-16
    4226:	e422                	sd	s0,8(sp)
    4228:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    422a:	00054783          	lbu	a5,0(a0)
    422e:	cb91                	beqz	a5,4242 <strcmp+0x1e>
    4230:	0005c703          	lbu	a4,0(a1)
    4234:	00f71763          	bne	a4,a5,4242 <strcmp+0x1e>
    p++, q++;
    4238:	0505                	addi	a0,a0,1
    423a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    423c:	00054783          	lbu	a5,0(a0)
    4240:	fbe5                	bnez	a5,4230 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    4242:	0005c503          	lbu	a0,0(a1)
}
    4246:	40a7853b          	subw	a0,a5,a0
    424a:	6422                	ld	s0,8(sp)
    424c:	0141                	addi	sp,sp,16
    424e:	8082                	ret

0000000000004250 <strlen>:

uint
strlen(const char *s)
{
    4250:	1141                	addi	sp,sp,-16
    4252:	e422                	sd	s0,8(sp)
    4254:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4256:	00054783          	lbu	a5,0(a0)
    425a:	cf91                	beqz	a5,4276 <strlen+0x26>
    425c:	0505                	addi	a0,a0,1
    425e:	87aa                	mv	a5,a0
    4260:	86be                	mv	a3,a5
    4262:	0785                	addi	a5,a5,1
    4264:	fff7c703          	lbu	a4,-1(a5)
    4268:	ff65                	bnez	a4,4260 <strlen+0x10>
    426a:	40a6853b          	subw	a0,a3,a0
    426e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    4270:	6422                	ld	s0,8(sp)
    4272:	0141                	addi	sp,sp,16
    4274:	8082                	ret
  for(n = 0; s[n]; n++)
    4276:	4501                	li	a0,0
    4278:	bfe5                	j	4270 <strlen+0x20>

000000000000427a <memset>:

void*
memset(void *dst, int c, uint n)
{
    427a:	1141                	addi	sp,sp,-16
    427c:	e422                	sd	s0,8(sp)
    427e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    4280:	ca19                	beqz	a2,4296 <memset+0x1c>
    4282:	87aa                	mv	a5,a0
    4284:	1602                	slli	a2,a2,0x20
    4286:	9201                	srli	a2,a2,0x20
    4288:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    428c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4290:	0785                	addi	a5,a5,1
    4292:	fee79de3          	bne	a5,a4,428c <memset+0x12>
  }
  return dst;
}
    4296:	6422                	ld	s0,8(sp)
    4298:	0141                	addi	sp,sp,16
    429a:	8082                	ret

000000000000429c <strchr>:

char*
strchr(const char *s, char c)
{
    429c:	1141                	addi	sp,sp,-16
    429e:	e422                	sd	s0,8(sp)
    42a0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    42a2:	00054783          	lbu	a5,0(a0)
    42a6:	cb99                	beqz	a5,42bc <strchr+0x20>
    if(*s == c)
    42a8:	00f58763          	beq	a1,a5,42b6 <strchr+0x1a>
  for(; *s; s++)
    42ac:	0505                	addi	a0,a0,1
    42ae:	00054783          	lbu	a5,0(a0)
    42b2:	fbfd                	bnez	a5,42a8 <strchr+0xc>
      return (char*)s;
  return 0;
    42b4:	4501                	li	a0,0
}
    42b6:	6422                	ld	s0,8(sp)
    42b8:	0141                	addi	sp,sp,16
    42ba:	8082                	ret
  return 0;
    42bc:	4501                	li	a0,0
    42be:	bfe5                	j	42b6 <strchr+0x1a>

00000000000042c0 <gets>:

char*
gets(char *buf, int max)
{
    42c0:	711d                	addi	sp,sp,-96
    42c2:	ec86                	sd	ra,88(sp)
    42c4:	e8a2                	sd	s0,80(sp)
    42c6:	e4a6                	sd	s1,72(sp)
    42c8:	e0ca                	sd	s2,64(sp)
    42ca:	fc4e                	sd	s3,56(sp)
    42cc:	f852                	sd	s4,48(sp)
    42ce:	f456                	sd	s5,40(sp)
    42d0:	f05a                	sd	s6,32(sp)
    42d2:	ec5e                	sd	s7,24(sp)
    42d4:	1080                	addi	s0,sp,96
    42d6:	8baa                	mv	s7,a0
    42d8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    42da:	892a                	mv	s2,a0
    42dc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    42de:	4aa9                	li	s5,10
    42e0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    42e2:	89a6                	mv	s3,s1
    42e4:	2485                	addiw	s1,s1,1
    42e6:	0344d863          	bge	s1,s4,4316 <gets+0x56>
    cc = read(0, &c, 1);
    42ea:	4605                	li	a2,1
    42ec:	faf40593          	addi	a1,s0,-81
    42f0:	4501                	li	a0,0
    42f2:	00000097          	auipc	ra,0x0
    42f6:	19a080e7          	jalr	410(ra) # 448c <read>
    if(cc < 1)
    42fa:	00a05e63          	blez	a0,4316 <gets+0x56>
    buf[i++] = c;
    42fe:	faf44783          	lbu	a5,-81(s0)
    4302:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4306:	01578763          	beq	a5,s5,4314 <gets+0x54>
    430a:	0905                	addi	s2,s2,1
    430c:	fd679be3          	bne	a5,s6,42e2 <gets+0x22>
    buf[i++] = c;
    4310:	89a6                	mv	s3,s1
    4312:	a011                	j	4316 <gets+0x56>
    4314:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    4316:	99de                	add	s3,s3,s7
    4318:	00098023          	sb	zero,0(s3)
  return buf;
}
    431c:	855e                	mv	a0,s7
    431e:	60e6                	ld	ra,88(sp)
    4320:	6446                	ld	s0,80(sp)
    4322:	64a6                	ld	s1,72(sp)
    4324:	6906                	ld	s2,64(sp)
    4326:	79e2                	ld	s3,56(sp)
    4328:	7a42                	ld	s4,48(sp)
    432a:	7aa2                	ld	s5,40(sp)
    432c:	7b02                	ld	s6,32(sp)
    432e:	6be2                	ld	s7,24(sp)
    4330:	6125                	addi	sp,sp,96
    4332:	8082                	ret

0000000000004334 <stat>:

int
stat(const char *n, struct stat *st)
{
    4334:	1101                	addi	sp,sp,-32
    4336:	ec06                	sd	ra,24(sp)
    4338:	e822                	sd	s0,16(sp)
    433a:	e04a                	sd	s2,0(sp)
    433c:	1000                	addi	s0,sp,32
    433e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4340:	4581                	li	a1,0
    4342:	00000097          	auipc	ra,0x0
    4346:	172080e7          	jalr	370(ra) # 44b4 <open>
  if(fd < 0)
    434a:	02054663          	bltz	a0,4376 <stat+0x42>
    434e:	e426                	sd	s1,8(sp)
    4350:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    4352:	85ca                	mv	a1,s2
    4354:	00000097          	auipc	ra,0x0
    4358:	178080e7          	jalr	376(ra) # 44cc <fstat>
    435c:	892a                	mv	s2,a0
  close(fd);
    435e:	8526                	mv	a0,s1
    4360:	00000097          	auipc	ra,0x0
    4364:	13c080e7          	jalr	316(ra) # 449c <close>
  return r;
    4368:	64a2                	ld	s1,8(sp)
}
    436a:	854a                	mv	a0,s2
    436c:	60e2                	ld	ra,24(sp)
    436e:	6442                	ld	s0,16(sp)
    4370:	6902                	ld	s2,0(sp)
    4372:	6105                	addi	sp,sp,32
    4374:	8082                	ret
    return -1;
    4376:	597d                	li	s2,-1
    4378:	bfcd                	j	436a <stat+0x36>

000000000000437a <atoi>:

int
atoi(const char *s)
{
    437a:	1141                	addi	sp,sp,-16
    437c:	e422                	sd	s0,8(sp)
    437e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4380:	00054683          	lbu	a3,0(a0)
    4384:	fd06879b          	addiw	a5,a3,-48
    4388:	0ff7f793          	zext.b	a5,a5
    438c:	4625                	li	a2,9
    438e:	02f66863          	bltu	a2,a5,43be <atoi+0x44>
    4392:	872a                	mv	a4,a0
  n = 0;
    4394:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    4396:	0705                	addi	a4,a4,1
    4398:	0025179b          	slliw	a5,a0,0x2
    439c:	9fa9                	addw	a5,a5,a0
    439e:	0017979b          	slliw	a5,a5,0x1
    43a2:	9fb5                	addw	a5,a5,a3
    43a4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    43a8:	00074683          	lbu	a3,0(a4)
    43ac:	fd06879b          	addiw	a5,a3,-48
    43b0:	0ff7f793          	zext.b	a5,a5
    43b4:	fef671e3          	bgeu	a2,a5,4396 <atoi+0x1c>
  return n;
}
    43b8:	6422                	ld	s0,8(sp)
    43ba:	0141                	addi	sp,sp,16
    43bc:	8082                	ret
  n = 0;
    43be:	4501                	li	a0,0
    43c0:	bfe5                	j	43b8 <atoi+0x3e>

00000000000043c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    43c2:	1141                	addi	sp,sp,-16
    43c4:	e422                	sd	s0,8(sp)
    43c6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    43c8:	02b57463          	bgeu	a0,a1,43f0 <memmove+0x2e>
    while(n-- > 0)
    43cc:	00c05f63          	blez	a2,43ea <memmove+0x28>
    43d0:	1602                	slli	a2,a2,0x20
    43d2:	9201                	srli	a2,a2,0x20
    43d4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    43d8:	872a                	mv	a4,a0
      *dst++ = *src++;
    43da:	0585                	addi	a1,a1,1
    43dc:	0705                	addi	a4,a4,1
    43de:	fff5c683          	lbu	a3,-1(a1)
    43e2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    43e6:	fef71ae3          	bne	a4,a5,43da <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    43ea:	6422                	ld	s0,8(sp)
    43ec:	0141                	addi	sp,sp,16
    43ee:	8082                	ret
    dst += n;
    43f0:	00c50733          	add	a4,a0,a2
    src += n;
    43f4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    43f6:	fec05ae3          	blez	a2,43ea <memmove+0x28>
    43fa:	fff6079b          	addiw	a5,a2,-1 # fff <writetest+0xc3>
    43fe:	1782                	slli	a5,a5,0x20
    4400:	9381                	srli	a5,a5,0x20
    4402:	fff7c793          	not	a5,a5
    4406:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4408:	15fd                	addi	a1,a1,-1
    440a:	177d                	addi	a4,a4,-1
    440c:	0005c683          	lbu	a3,0(a1)
    4410:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4414:	fee79ae3          	bne	a5,a4,4408 <memmove+0x46>
    4418:	bfc9                	j	43ea <memmove+0x28>

000000000000441a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    441a:	1141                	addi	sp,sp,-16
    441c:	e422                	sd	s0,8(sp)
    441e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4420:	ca05                	beqz	a2,4450 <memcmp+0x36>
    4422:	fff6069b          	addiw	a3,a2,-1
    4426:	1682                	slli	a3,a3,0x20
    4428:	9281                	srli	a3,a3,0x20
    442a:	0685                	addi	a3,a3,1
    442c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    442e:	00054783          	lbu	a5,0(a0)
    4432:	0005c703          	lbu	a4,0(a1)
    4436:	00e79863          	bne	a5,a4,4446 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    443a:	0505                	addi	a0,a0,1
    p2++;
    443c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    443e:	fed518e3          	bne	a0,a3,442e <memcmp+0x14>
  }
  return 0;
    4442:	4501                	li	a0,0
    4444:	a019                	j	444a <memcmp+0x30>
      return *p1 - *p2;
    4446:	40e7853b          	subw	a0,a5,a4
}
    444a:	6422                	ld	s0,8(sp)
    444c:	0141                	addi	sp,sp,16
    444e:	8082                	ret
  return 0;
    4450:	4501                	li	a0,0
    4452:	bfe5                	j	444a <memcmp+0x30>

0000000000004454 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4454:	1141                	addi	sp,sp,-16
    4456:	e406                	sd	ra,8(sp)
    4458:	e022                	sd	s0,0(sp)
    445a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    445c:	00000097          	auipc	ra,0x0
    4460:	f66080e7          	jalr	-154(ra) # 43c2 <memmove>
}
    4464:	60a2                	ld	ra,8(sp)
    4466:	6402                	ld	s0,0(sp)
    4468:	0141                	addi	sp,sp,16
    446a:	8082                	ret

000000000000446c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    446c:	4885                	li	a7,1
 ecall
    446e:	00000073          	ecall
 ret
    4472:	8082                	ret

0000000000004474 <exit>:
.global exit
exit:
 li a7, SYS_exit
    4474:	4889                	li	a7,2
 ecall
    4476:	00000073          	ecall
 ret
    447a:	8082                	ret

000000000000447c <wait>:
.global wait
wait:
 li a7, SYS_wait
    447c:	488d                	li	a7,3
 ecall
    447e:	00000073          	ecall
 ret
    4482:	8082                	ret

0000000000004484 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4484:	4891                	li	a7,4
 ecall
    4486:	00000073          	ecall
 ret
    448a:	8082                	ret

000000000000448c <read>:
.global read
read:
 li a7, SYS_read
    448c:	4895                	li	a7,5
 ecall
    448e:	00000073          	ecall
 ret
    4492:	8082                	ret

0000000000004494 <write>:
.global write
write:
 li a7, SYS_write
    4494:	48c1                	li	a7,16
 ecall
    4496:	00000073          	ecall
 ret
    449a:	8082                	ret

000000000000449c <close>:
.global close
close:
 li a7, SYS_close
    449c:	48d5                	li	a7,21
 ecall
    449e:	00000073          	ecall
 ret
    44a2:	8082                	ret

00000000000044a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
    44a4:	4899                	li	a7,6
 ecall
    44a6:	00000073          	ecall
 ret
    44aa:	8082                	ret

00000000000044ac <exec>:
.global exec
exec:
 li a7, SYS_exec
    44ac:	489d                	li	a7,7
 ecall
    44ae:	00000073          	ecall
 ret
    44b2:	8082                	ret

00000000000044b4 <open>:
.global open
open:
 li a7, SYS_open
    44b4:	48bd                	li	a7,15
 ecall
    44b6:	00000073          	ecall
 ret
    44ba:	8082                	ret

00000000000044bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    44bc:	48c5                	li	a7,17
 ecall
    44be:	00000073          	ecall
 ret
    44c2:	8082                	ret

00000000000044c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    44c4:	48c9                	li	a7,18
 ecall
    44c6:	00000073          	ecall
 ret
    44ca:	8082                	ret

00000000000044cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    44cc:	48a1                	li	a7,8
 ecall
    44ce:	00000073          	ecall
 ret
    44d2:	8082                	ret

00000000000044d4 <link>:
.global link
link:
 li a7, SYS_link
    44d4:	48cd                	li	a7,19
 ecall
    44d6:	00000073          	ecall
 ret
    44da:	8082                	ret

00000000000044dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    44dc:	48d1                	li	a7,20
 ecall
    44de:	00000073          	ecall
 ret
    44e2:	8082                	ret

00000000000044e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    44e4:	48a5                	li	a7,9
 ecall
    44e6:	00000073          	ecall
 ret
    44ea:	8082                	ret

00000000000044ec <dup>:
.global dup
dup:
 li a7, SYS_dup
    44ec:	48a9                	li	a7,10
 ecall
    44ee:	00000073          	ecall
 ret
    44f2:	8082                	ret

00000000000044f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    44f4:	48ad                	li	a7,11
 ecall
    44f6:	00000073          	ecall
 ret
    44fa:	8082                	ret

00000000000044fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    44fc:	48b1                	li	a7,12
 ecall
    44fe:	00000073          	ecall
 ret
    4502:	8082                	ret

0000000000004504 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4504:	48b5                	li	a7,13
 ecall
    4506:	00000073          	ecall
 ret
    450a:	8082                	ret

000000000000450c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    450c:	48b9                	li	a7,14
 ecall
    450e:	00000073          	ecall
 ret
    4512:	8082                	ret

0000000000004514 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4514:	1101                	addi	sp,sp,-32
    4516:	ec06                	sd	ra,24(sp)
    4518:	e822                	sd	s0,16(sp)
    451a:	1000                	addi	s0,sp,32
    451c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4520:	4605                	li	a2,1
    4522:	fef40593          	addi	a1,s0,-17
    4526:	00000097          	auipc	ra,0x0
    452a:	f6e080e7          	jalr	-146(ra) # 4494 <write>
}
    452e:	60e2                	ld	ra,24(sp)
    4530:	6442                	ld	s0,16(sp)
    4532:	6105                	addi	sp,sp,32
    4534:	8082                	ret

0000000000004536 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4536:	7139                	addi	sp,sp,-64
    4538:	fc06                	sd	ra,56(sp)
    453a:	f822                	sd	s0,48(sp)
    453c:	f426                	sd	s1,40(sp)
    453e:	0080                	addi	s0,sp,64
    4540:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4542:	c299                	beqz	a3,4548 <printint+0x12>
    4544:	0805cb63          	bltz	a1,45da <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4548:	2581                	sext.w	a1,a1
  neg = 0;
    454a:	4881                	li	a7,0
    454c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    4550:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    4552:	2601                	sext.w	a2,a2
    4554:	00002517          	auipc	a0,0x2
    4558:	54450513          	addi	a0,a0,1348 # 6a98 <digits>
    455c:	883a                	mv	a6,a4
    455e:	2705                	addiw	a4,a4,1
    4560:	02c5f7bb          	remuw	a5,a1,a2
    4564:	1782                	slli	a5,a5,0x20
    4566:	9381                	srli	a5,a5,0x20
    4568:	97aa                	add	a5,a5,a0
    456a:	0007c783          	lbu	a5,0(a5)
    456e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    4572:	0005879b          	sext.w	a5,a1
    4576:	02c5d5bb          	divuw	a1,a1,a2
    457a:	0685                	addi	a3,a3,1
    457c:	fec7f0e3          	bgeu	a5,a2,455c <printint+0x26>
  if(neg)
    4580:	00088c63          	beqz	a7,4598 <printint+0x62>
    buf[i++] = '-';
    4584:	fd070793          	addi	a5,a4,-48
    4588:	00878733          	add	a4,a5,s0
    458c:	02d00793          	li	a5,45
    4590:	fef70823          	sb	a5,-16(a4)
    4594:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    4598:	02e05c63          	blez	a4,45d0 <printint+0x9a>
    459c:	f04a                	sd	s2,32(sp)
    459e:	ec4e                	sd	s3,24(sp)
    45a0:	fc040793          	addi	a5,s0,-64
    45a4:	00e78933          	add	s2,a5,a4
    45a8:	fff78993          	addi	s3,a5,-1
    45ac:	99ba                	add	s3,s3,a4
    45ae:	377d                	addiw	a4,a4,-1
    45b0:	1702                	slli	a4,a4,0x20
    45b2:	9301                	srli	a4,a4,0x20
    45b4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    45b8:	fff94583          	lbu	a1,-1(s2)
    45bc:	8526                	mv	a0,s1
    45be:	00000097          	auipc	ra,0x0
    45c2:	f56080e7          	jalr	-170(ra) # 4514 <putc>
  while(--i >= 0)
    45c6:	197d                	addi	s2,s2,-1
    45c8:	ff3918e3          	bne	s2,s3,45b8 <printint+0x82>
    45cc:	7902                	ld	s2,32(sp)
    45ce:	69e2                	ld	s3,24(sp)
}
    45d0:	70e2                	ld	ra,56(sp)
    45d2:	7442                	ld	s0,48(sp)
    45d4:	74a2                	ld	s1,40(sp)
    45d6:	6121                	addi	sp,sp,64
    45d8:	8082                	ret
    x = -xx;
    45da:	40b005bb          	negw	a1,a1
    neg = 1;
    45de:	4885                	li	a7,1
    x = -xx;
    45e0:	b7b5                	j	454c <printint+0x16>

00000000000045e2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    45e2:	715d                	addi	sp,sp,-80
    45e4:	e486                	sd	ra,72(sp)
    45e6:	e0a2                	sd	s0,64(sp)
    45e8:	f84a                	sd	s2,48(sp)
    45ea:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    45ec:	0005c903          	lbu	s2,0(a1)
    45f0:	1a090a63          	beqz	s2,47a4 <vprintf+0x1c2>
    45f4:	fc26                	sd	s1,56(sp)
    45f6:	f44e                	sd	s3,40(sp)
    45f8:	f052                	sd	s4,32(sp)
    45fa:	ec56                	sd	s5,24(sp)
    45fc:	e85a                	sd	s6,16(sp)
    45fe:	e45e                	sd	s7,8(sp)
    4600:	8aaa                	mv	s5,a0
    4602:	8bb2                	mv	s7,a2
    4604:	00158493          	addi	s1,a1,1
  state = 0;
    4608:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    460a:	02500a13          	li	s4,37
    460e:	4b55                	li	s6,21
    4610:	a839                	j	462e <vprintf+0x4c>
        putc(fd, c);
    4612:	85ca                	mv	a1,s2
    4614:	8556                	mv	a0,s5
    4616:	00000097          	auipc	ra,0x0
    461a:	efe080e7          	jalr	-258(ra) # 4514 <putc>
    461e:	a019                	j	4624 <vprintf+0x42>
    } else if(state == '%'){
    4620:	01498d63          	beq	s3,s4,463a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    4624:	0485                	addi	s1,s1,1
    4626:	fff4c903          	lbu	s2,-1(s1)
    462a:	16090763          	beqz	s2,4798 <vprintf+0x1b6>
    if(state == 0){
    462e:	fe0999e3          	bnez	s3,4620 <vprintf+0x3e>
      if(c == '%'){
    4632:	ff4910e3          	bne	s2,s4,4612 <vprintf+0x30>
        state = '%';
    4636:	89d2                	mv	s3,s4
    4638:	b7f5                	j	4624 <vprintf+0x42>
      if(c == 'd'){
    463a:	13490463          	beq	s2,s4,4762 <vprintf+0x180>
    463e:	f9d9079b          	addiw	a5,s2,-99
    4642:	0ff7f793          	zext.b	a5,a5
    4646:	12fb6763          	bltu	s6,a5,4774 <vprintf+0x192>
    464a:	f9d9079b          	addiw	a5,s2,-99
    464e:	0ff7f713          	zext.b	a4,a5
    4652:	12eb6163          	bltu	s6,a4,4774 <vprintf+0x192>
    4656:	00271793          	slli	a5,a4,0x2
    465a:	00002717          	auipc	a4,0x2
    465e:	3e670713          	addi	a4,a4,998 # 6a40 <malloc+0x21ac>
    4662:	97ba                	add	a5,a5,a4
    4664:	439c                	lw	a5,0(a5)
    4666:	97ba                	add	a5,a5,a4
    4668:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    466a:	008b8913          	addi	s2,s7,8
    466e:	4685                	li	a3,1
    4670:	4629                	li	a2,10
    4672:	000ba583          	lw	a1,0(s7)
    4676:	8556                	mv	a0,s5
    4678:	00000097          	auipc	ra,0x0
    467c:	ebe080e7          	jalr	-322(ra) # 4536 <printint>
    4680:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    4682:	4981                	li	s3,0
    4684:	b745                	j	4624 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4686:	008b8913          	addi	s2,s7,8
    468a:	4681                	li	a3,0
    468c:	4629                	li	a2,10
    468e:	000ba583          	lw	a1,0(s7)
    4692:	8556                	mv	a0,s5
    4694:	00000097          	auipc	ra,0x0
    4698:	ea2080e7          	jalr	-350(ra) # 4536 <printint>
    469c:	8bca                	mv	s7,s2
      state = 0;
    469e:	4981                	li	s3,0
    46a0:	b751                	j	4624 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    46a2:	008b8913          	addi	s2,s7,8
    46a6:	4681                	li	a3,0
    46a8:	4641                	li	a2,16
    46aa:	000ba583          	lw	a1,0(s7)
    46ae:	8556                	mv	a0,s5
    46b0:	00000097          	auipc	ra,0x0
    46b4:	e86080e7          	jalr	-378(ra) # 4536 <printint>
    46b8:	8bca                	mv	s7,s2
      state = 0;
    46ba:	4981                	li	s3,0
    46bc:	b7a5                	j	4624 <vprintf+0x42>
    46be:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    46c0:	008b8c13          	addi	s8,s7,8
    46c4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    46c8:	03000593          	li	a1,48
    46cc:	8556                	mv	a0,s5
    46ce:	00000097          	auipc	ra,0x0
    46d2:	e46080e7          	jalr	-442(ra) # 4514 <putc>
  putc(fd, 'x');
    46d6:	07800593          	li	a1,120
    46da:	8556                	mv	a0,s5
    46dc:	00000097          	auipc	ra,0x0
    46e0:	e38080e7          	jalr	-456(ra) # 4514 <putc>
    46e4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    46e6:	00002b97          	auipc	s7,0x2
    46ea:	3b2b8b93          	addi	s7,s7,946 # 6a98 <digits>
    46ee:	03c9d793          	srli	a5,s3,0x3c
    46f2:	97de                	add	a5,a5,s7
    46f4:	0007c583          	lbu	a1,0(a5)
    46f8:	8556                	mv	a0,s5
    46fa:	00000097          	auipc	ra,0x0
    46fe:	e1a080e7          	jalr	-486(ra) # 4514 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    4702:	0992                	slli	s3,s3,0x4
    4704:	397d                	addiw	s2,s2,-1
    4706:	fe0914e3          	bnez	s2,46ee <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    470a:	8be2                	mv	s7,s8
      state = 0;
    470c:	4981                	li	s3,0
    470e:	6c02                	ld	s8,0(sp)
    4710:	bf11                	j	4624 <vprintf+0x42>
        s = va_arg(ap, char*);
    4712:	008b8993          	addi	s3,s7,8
    4716:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    471a:	02090163          	beqz	s2,473c <vprintf+0x15a>
        while(*s != 0){
    471e:	00094583          	lbu	a1,0(s2)
    4722:	c9a5                	beqz	a1,4792 <vprintf+0x1b0>
          putc(fd, *s);
    4724:	8556                	mv	a0,s5
    4726:	00000097          	auipc	ra,0x0
    472a:	dee080e7          	jalr	-530(ra) # 4514 <putc>
          s++;
    472e:	0905                	addi	s2,s2,1
        while(*s != 0){
    4730:	00094583          	lbu	a1,0(s2)
    4734:	f9e5                	bnez	a1,4724 <vprintf+0x142>
        s = va_arg(ap, char*);
    4736:	8bce                	mv	s7,s3
      state = 0;
    4738:	4981                	li	s3,0
    473a:	b5ed                	j	4624 <vprintf+0x42>
          s = "(null)";
    473c:	00002917          	auipc	s2,0x2
    4740:	00c90913          	addi	s2,s2,12 # 6748 <malloc+0x1eb4>
        while(*s != 0){
    4744:	02800593          	li	a1,40
    4748:	bff1                	j	4724 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    474a:	008b8913          	addi	s2,s7,8
    474e:	000bc583          	lbu	a1,0(s7)
    4752:	8556                	mv	a0,s5
    4754:	00000097          	auipc	ra,0x0
    4758:	dc0080e7          	jalr	-576(ra) # 4514 <putc>
    475c:	8bca                	mv	s7,s2
      state = 0;
    475e:	4981                	li	s3,0
    4760:	b5d1                	j	4624 <vprintf+0x42>
        putc(fd, c);
    4762:	02500593          	li	a1,37
    4766:	8556                	mv	a0,s5
    4768:	00000097          	auipc	ra,0x0
    476c:	dac080e7          	jalr	-596(ra) # 4514 <putc>
      state = 0;
    4770:	4981                	li	s3,0
    4772:	bd4d                	j	4624 <vprintf+0x42>
        putc(fd, '%');
    4774:	02500593          	li	a1,37
    4778:	8556                	mv	a0,s5
    477a:	00000097          	auipc	ra,0x0
    477e:	d9a080e7          	jalr	-614(ra) # 4514 <putc>
        putc(fd, c);
    4782:	85ca                	mv	a1,s2
    4784:	8556                	mv	a0,s5
    4786:	00000097          	auipc	ra,0x0
    478a:	d8e080e7          	jalr	-626(ra) # 4514 <putc>
      state = 0;
    478e:	4981                	li	s3,0
    4790:	bd51                	j	4624 <vprintf+0x42>
        s = va_arg(ap, char*);
    4792:	8bce                	mv	s7,s3
      state = 0;
    4794:	4981                	li	s3,0
    4796:	b579                	j	4624 <vprintf+0x42>
    4798:	74e2                	ld	s1,56(sp)
    479a:	79a2                	ld	s3,40(sp)
    479c:	7a02                	ld	s4,32(sp)
    479e:	6ae2                	ld	s5,24(sp)
    47a0:	6b42                	ld	s6,16(sp)
    47a2:	6ba2                	ld	s7,8(sp)
    }
  }
}
    47a4:	60a6                	ld	ra,72(sp)
    47a6:	6406                	ld	s0,64(sp)
    47a8:	7942                	ld	s2,48(sp)
    47aa:	6161                	addi	sp,sp,80
    47ac:	8082                	ret

00000000000047ae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    47ae:	715d                	addi	sp,sp,-80
    47b0:	ec06                	sd	ra,24(sp)
    47b2:	e822                	sd	s0,16(sp)
    47b4:	1000                	addi	s0,sp,32
    47b6:	e010                	sd	a2,0(s0)
    47b8:	e414                	sd	a3,8(s0)
    47ba:	e818                	sd	a4,16(s0)
    47bc:	ec1c                	sd	a5,24(s0)
    47be:	03043023          	sd	a6,32(s0)
    47c2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    47c6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    47ca:	8622                	mv	a2,s0
    47cc:	00000097          	auipc	ra,0x0
    47d0:	e16080e7          	jalr	-490(ra) # 45e2 <vprintf>
}
    47d4:	60e2                	ld	ra,24(sp)
    47d6:	6442                	ld	s0,16(sp)
    47d8:	6161                	addi	sp,sp,80
    47da:	8082                	ret

00000000000047dc <printf>:

void
printf(const char *fmt, ...)
{
    47dc:	711d                	addi	sp,sp,-96
    47de:	ec06                	sd	ra,24(sp)
    47e0:	e822                	sd	s0,16(sp)
    47e2:	1000                	addi	s0,sp,32
    47e4:	e40c                	sd	a1,8(s0)
    47e6:	e810                	sd	a2,16(s0)
    47e8:	ec14                	sd	a3,24(s0)
    47ea:	f018                	sd	a4,32(s0)
    47ec:	f41c                	sd	a5,40(s0)
    47ee:	03043823          	sd	a6,48(s0)
    47f2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    47f6:	00840613          	addi	a2,s0,8
    47fa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    47fe:	85aa                	mv	a1,a0
    4800:	4505                	li	a0,1
    4802:	00000097          	auipc	ra,0x0
    4806:	de0080e7          	jalr	-544(ra) # 45e2 <vprintf>
}
    480a:	60e2                	ld	ra,24(sp)
    480c:	6442                	ld	s0,16(sp)
    480e:	6125                	addi	sp,sp,96
    4810:	8082                	ret

0000000000004812 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4812:	1141                	addi	sp,sp,-16
    4814:	e422                	sd	s0,8(sp)
    4816:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4818:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    481c:	00003797          	auipc	a5,0x3
    4820:	6ec7b783          	ld	a5,1772(a5) # 7f08 <freep>
    4824:	a02d                	j	484e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    4826:	4618                	lw	a4,8(a2)
    4828:	9f2d                	addw	a4,a4,a1
    482a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    482e:	6398                	ld	a4,0(a5)
    4830:	6310                	ld	a2,0(a4)
    4832:	a83d                	j	4870 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    4834:	ff852703          	lw	a4,-8(a0)
    4838:	9f31                	addw	a4,a4,a2
    483a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    483c:	ff053683          	ld	a3,-16(a0)
    4840:	a091                	j	4884 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4842:	6398                	ld	a4,0(a5)
    4844:	00e7e463          	bltu	a5,a4,484c <free+0x3a>
    4848:	00e6ea63          	bltu	a3,a4,485c <free+0x4a>
{
    484c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    484e:	fed7fae3          	bgeu	a5,a3,4842 <free+0x30>
    4852:	6398                	ld	a4,0(a5)
    4854:	00e6e463          	bltu	a3,a4,485c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4858:	fee7eae3          	bltu	a5,a4,484c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    485c:	ff852583          	lw	a1,-8(a0)
    4860:	6390                	ld	a2,0(a5)
    4862:	02059813          	slli	a6,a1,0x20
    4866:	01c85713          	srli	a4,a6,0x1c
    486a:	9736                	add	a4,a4,a3
    486c:	fae60de3          	beq	a2,a4,4826 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    4870:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    4874:	4790                	lw	a2,8(a5)
    4876:	02061593          	slli	a1,a2,0x20
    487a:	01c5d713          	srli	a4,a1,0x1c
    487e:	973e                	add	a4,a4,a5
    4880:	fae68ae3          	beq	a3,a4,4834 <free+0x22>
    p->s.ptr = bp->s.ptr;
    4884:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    4886:	00003717          	auipc	a4,0x3
    488a:	68f73123          	sd	a5,1666(a4) # 7f08 <freep>
}
    488e:	6422                	ld	s0,8(sp)
    4890:	0141                	addi	sp,sp,16
    4892:	8082                	ret

0000000000004894 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4894:	7139                	addi	sp,sp,-64
    4896:	fc06                	sd	ra,56(sp)
    4898:	f822                	sd	s0,48(sp)
    489a:	f426                	sd	s1,40(sp)
    489c:	ec4e                	sd	s3,24(sp)
    489e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    48a0:	02051493          	slli	s1,a0,0x20
    48a4:	9081                	srli	s1,s1,0x20
    48a6:	04bd                	addi	s1,s1,15
    48a8:	8091                	srli	s1,s1,0x4
    48aa:	0014899b          	addiw	s3,s1,1
    48ae:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    48b0:	00003517          	auipc	a0,0x3
    48b4:	65853503          	ld	a0,1624(a0) # 7f08 <freep>
    48b8:	c915                	beqz	a0,48ec <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    48ba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    48bc:	4798                	lw	a4,8(a5)
    48be:	08977e63          	bgeu	a4,s1,495a <malloc+0xc6>
    48c2:	f04a                	sd	s2,32(sp)
    48c4:	e852                	sd	s4,16(sp)
    48c6:	e456                	sd	s5,8(sp)
    48c8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    48ca:	8a4e                	mv	s4,s3
    48cc:	0009871b          	sext.w	a4,s3
    48d0:	6685                	lui	a3,0x1
    48d2:	00d77363          	bgeu	a4,a3,48d8 <malloc+0x44>
    48d6:	6a05                	lui	s4,0x1
    48d8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    48dc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    48e0:	00003917          	auipc	s2,0x3
    48e4:	62890913          	addi	s2,s2,1576 # 7f08 <freep>
  if(p == (char*)-1)
    48e8:	5afd                	li	s5,-1
    48ea:	a091                	j	492e <malloc+0x9a>
    48ec:	f04a                	sd	s2,32(sp)
    48ee:	e852                	sd	s4,16(sp)
    48f0:	e456                	sd	s5,8(sp)
    48f2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    48f4:	00009797          	auipc	a5,0x9
    48f8:	e2c78793          	addi	a5,a5,-468 # d720 <base>
    48fc:	00003717          	auipc	a4,0x3
    4900:	60f73623          	sd	a5,1548(a4) # 7f08 <freep>
    4904:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    4906:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    490a:	b7c1                	j	48ca <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    490c:	6398                	ld	a4,0(a5)
    490e:	e118                	sd	a4,0(a0)
    4910:	a08d                	j	4972 <malloc+0xde>
  hp->s.size = nu;
    4912:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    4916:	0541                	addi	a0,a0,16
    4918:	00000097          	auipc	ra,0x0
    491c:	efa080e7          	jalr	-262(ra) # 4812 <free>
  return freep;
    4920:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    4924:	c13d                	beqz	a0,498a <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4926:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4928:	4798                	lw	a4,8(a5)
    492a:	02977463          	bgeu	a4,s1,4952 <malloc+0xbe>
    if(p == freep)
    492e:	00093703          	ld	a4,0(s2)
    4932:	853e                	mv	a0,a5
    4934:	fef719e3          	bne	a4,a5,4926 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    4938:	8552                	mv	a0,s4
    493a:	00000097          	auipc	ra,0x0
    493e:	bc2080e7          	jalr	-1086(ra) # 44fc <sbrk>
  if(p == (char*)-1)
    4942:	fd5518e3          	bne	a0,s5,4912 <malloc+0x7e>
        return 0;
    4946:	4501                	li	a0,0
    4948:	7902                	ld	s2,32(sp)
    494a:	6a42                	ld	s4,16(sp)
    494c:	6aa2                	ld	s5,8(sp)
    494e:	6b02                	ld	s6,0(sp)
    4950:	a03d                	j	497e <malloc+0xea>
    4952:	7902                	ld	s2,32(sp)
    4954:	6a42                	ld	s4,16(sp)
    4956:	6aa2                	ld	s5,8(sp)
    4958:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    495a:	fae489e3          	beq	s1,a4,490c <malloc+0x78>
        p->s.size -= nunits;
    495e:	4137073b          	subw	a4,a4,s3
    4962:	c798                	sw	a4,8(a5)
        p += p->s.size;
    4964:	02071693          	slli	a3,a4,0x20
    4968:	01c6d713          	srli	a4,a3,0x1c
    496c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    496e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    4972:	00003717          	auipc	a4,0x3
    4976:	58a73b23          	sd	a0,1430(a4) # 7f08 <freep>
      return (void*)(p + 1);
    497a:	01078513          	addi	a0,a5,16
  }
}
    497e:	70e2                	ld	ra,56(sp)
    4980:	7442                	ld	s0,48(sp)
    4982:	74a2                	ld	s1,40(sp)
    4984:	69e2                	ld	s3,24(sp)
    4986:	6121                	addi	sp,sp,64
    4988:	8082                	ret
    498a:	7902                	ld	s2,32(sp)
    498c:	6a42                	ld	s4,16(sp)
    498e:	6aa2                	ld	s5,8(sp)
    4990:	6b02                	ld	s6,0(sp)
    4992:	b7f5                	j	497e <malloc+0xea>
