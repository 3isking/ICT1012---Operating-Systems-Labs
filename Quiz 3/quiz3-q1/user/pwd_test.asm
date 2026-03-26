
user/_pwd_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <err>:
    exit(0);
}

void
err(char *why)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  printf("pwd_test failure: %s, pid=%d\n", why, getpid());
   c:	6f6000ef          	jal	702 <getpid>
  10:	862a                	mv	a2,a0
  12:	85a6                	mv	a1,s1
  14:	00001517          	auipc	a0,0x1
  18:	c5c50513          	addi	a0,a0,-932 # c70 <malloc+0x106>
  1c:	29b000ef          	jal	ab6 <printf>
  exit(1);
  20:	4505                	li	a0,1
  22:	660000ef          	jal	682 <exit>

0000000000000026 <test1>:
}


void test1(){
  26:	7155                	addi	sp,sp,-208
  28:	e586                	sd	ra,200(sp)
  2a:	e1a2                	sd	s0,192(sp)
  2c:	fd26                	sd	s1,184(sp)
  2e:	f94a                	sd	s2,176(sp)
  30:	f54e                	sd	s3,168(sp)
  32:	0980                	addi	s0,sp,208
    int p[2];
    char buf[128];
    char *argv[] = { "/pwd", 0 };
  34:	00001797          	auipc	a5,0x1
  38:	c6478793          	addi	a5,a5,-924 # c98 <malloc+0x12e>
  3c:	f2f43c23          	sd	a5,-200(s0)
  40:	f4043023          	sd	zero,-192(s0)
    
    memset(buf, 0, sizeof(buf));
  44:	08000613          	li	a2,128
  48:	4581                	li	a1,0
  4a:	f4840513          	addi	a0,s0,-184
  4e:	422000ef          	jal	470 <memset>

    int r_mkdir = mkdir("ICT1012");
  52:	00001517          	auipc	a0,0x1
  56:	c4e50513          	addi	a0,a0,-946 # ca0 <malloc+0x136>
  5a:	690000ef          	jal	6ea <mkdir>

    if (r_mkdir == -1)
  5e:	57fd                	li	a5,-1
  60:	08f50363          	beq	a0,a5,e6 <test1+0xc0>
        err("test1 mkdir 1");
  
    int r_chdir = chdir("ICT1012");
  64:	00001517          	auipc	a0,0x1
  68:	c3c50513          	addi	a0,a0,-964 # ca0 <malloc+0x136>
  6c:	686000ef          	jal	6f2 <chdir>

    if (r_chdir == -1)
  70:	57fd                	li	a5,-1
  72:	08f50063          	beq	a0,a5,f2 <test1+0xcc>
        err("test1 chdir 1");

    r_mkdir = mkdir("Quiz-3");
  76:	00001517          	auipc	a0,0x1
  7a:	c5250513          	addi	a0,a0,-942 # cc8 <malloc+0x15e>
  7e:	66c000ef          	jal	6ea <mkdir>

    if (r_mkdir == -1)
  82:	57fd                	li	a5,-1
  84:	06f50d63          	beq	a0,a5,fe <test1+0xd8>
        err("test1 mkdir 2");
    
    r_chdir = chdir("Quiz-3");
  88:	00001517          	auipc	a0,0x1
  8c:	c4050513          	addi	a0,a0,-960 # cc8 <malloc+0x15e>
  90:	662000ef          	jal	6f2 <chdir>

    if (r_chdir == -1)
  94:	57fd                	li	a5,-1
  96:	06f50a63          	beq	a0,a5,10a <test1+0xe4>
        err("test1 chdir 2");

    
    if(pipe(p) < 0)
  9a:	fc840513          	addi	a0,s0,-56
  9e:	5f4000ef          	jal	692 <pipe>
  a2:	06054a63          	bltz	a0,116 <test1+0xf0>
        err("findtest1 pipe");


    if(fork() == 0) {   // child process to execute "find"
  a6:	5d4000ef          	jal	67a <fork>
  aa:	cd25                	beqz	a0,122 <test1+0xfc>
        err("test1 exec failed\n");
        exit(1);
    }


    close(p[1]);         // parent process must close the write side; otherwise, read will stuck
  ac:	fcc42503          	lw	a0,-52(s0)
  b0:	5fa000ef          	jal	6aa <close>

    const char * const testString = "/ICT1012/Quiz-3\n";
  
    int n;
    int totalBytes = 0;
  b4:	4481                	li	s1,0
    while((totalBytes < sizeof(buf) - 1) && (n = read(p[0], &buf[totalBytes], sizeof(buf) - totalBytes -1)) > 0) {
  b6:	4601                	li	a2,0
  b8:	07f00913          	li	s2,127
  bc:	07e00993          	li	s3,126
  c0:	40c9063b          	subw	a2,s2,a2
  c4:	f4840793          	addi	a5,s0,-184
  c8:	009785b3          	add	a1,a5,s1
  cc:	fc842503          	lw	a0,-56(s0)
  d0:	5ca000ef          	jal	69a <read>
  d4:	08a05463          	blez	a0,15c <test1+0x136>
        totalBytes += n;
  d8:	9d25                	addw	a0,a0,s1
  da:	0005049b          	sext.w	s1,a0
    while((totalBytes < sizeof(buf) - 1) && (n = read(p[0], &buf[totalBytes], sizeof(buf) - totalBytes -1)) > 0) {
  de:	8626                	mv	a2,s1
  e0:	fe99f0e3          	bgeu	s3,s1,c0 <test1+0x9a>
  e4:	a8b5                	j	160 <test1+0x13a>
        err("test1 mkdir 1");
  e6:	00001517          	auipc	a0,0x1
  ea:	bc250513          	addi	a0,a0,-1086 # ca8 <malloc+0x13e>
  ee:	f13ff0ef          	jal	0 <err>
        err("test1 chdir 1");
  f2:	00001517          	auipc	a0,0x1
  f6:	bc650513          	addi	a0,a0,-1082 # cb8 <malloc+0x14e>
  fa:	f07ff0ef          	jal	0 <err>
        err("test1 mkdir 2");
  fe:	00001517          	auipc	a0,0x1
 102:	bd250513          	addi	a0,a0,-1070 # cd0 <malloc+0x166>
 106:	efbff0ef          	jal	0 <err>
        err("test1 chdir 2");
 10a:	00001517          	auipc	a0,0x1
 10e:	bd650513          	addi	a0,a0,-1066 # ce0 <malloc+0x176>
 112:	eefff0ef          	jal	0 <err>
        err("findtest1 pipe");
 116:	00001517          	auipc	a0,0x1
 11a:	bda50513          	addi	a0,a0,-1062 # cf0 <malloc+0x186>
 11e:	ee3ff0ef          	jal	0 <err>
        close(p[0]);       // close the read side in child process
 122:	fc842503          	lw	a0,-56(s0)
 126:	584000ef          	jal	6aa <close>
        close(1);          // close current stdout (fd 1)
 12a:	4505                	li	a0,1
 12c:	57e000ef          	jal	6aa <close>
        dup(p[1]);         // redirect stdout to p[1]
 130:	fcc42503          	lw	a0,-52(s0)
 134:	5c6000ef          	jal	6fa <dup>
        close(p[1]);       // close p[1], as it is referenced by stdout now.
 138:	fcc42503          	lw	a0,-52(s0)
 13c:	56e000ef          	jal	6aa <close>
        exec("/pwd", argv);  // execute "find" and its output will be in the pipe
 140:	f3840593          	addi	a1,s0,-200
 144:	00001517          	auipc	a0,0x1
 148:	b5450513          	addi	a0,a0,-1196 # c98 <malloc+0x12e>
 14c:	56e000ef          	jal	6ba <exec>
        err("test1 exec failed\n");
 150:	00001517          	auipc	a0,0x1
 154:	bb050513          	addi	a0,a0,-1104 # d00 <malloc+0x196>
 158:	ea9ff0ef          	jal	0 <err>
        // fprintf(2, "n:%d\n", n);  
    }
    // fprintf(2, "testString: %s",testString);
    // fprintf(2, "buf: %s", buf);
    
    if(n < 0){
 15c:	02054963          	bltz	a0,18e <test1+0x168>
        err("test1 pipe read");
    }

    if(strcmp(testString, buf) != 0){
 160:	f4840593          	addi	a1,s0,-184
 164:	00001517          	auipc	a0,0x1
 168:	bc450513          	addi	a0,a0,-1084 # d28 <malloc+0x1be>
 16c:	2ae000ef          	jal	41a <strcmp>
 170:	e50d                	bnez	a0,19a <test1+0x174>
      printf("Buffer: %s\n", buf);
      printf("Test: %s\n", testString);
    }
        //err("test1 pwd");

    close(p[0]);
 172:	fc842503          	lw	a0,-56(s0)
 176:	534000ef          	jal	6aa <close>
    wait(0);             // wait until child process finishes
 17a:	4501                	li	a0,0
 17c:	50e000ef          	jal	68a <wait>
}
 180:	60ae                	ld	ra,200(sp)
 182:	640e                	ld	s0,192(sp)
 184:	74ea                	ld	s1,184(sp)
 186:	794a                	ld	s2,176(sp)
 188:	79aa                	ld	s3,168(sp)
 18a:	6169                	addi	sp,sp,208
 18c:	8082                	ret
        err("test1 pipe read");
 18e:	00001517          	auipc	a0,0x1
 192:	b8a50513          	addi	a0,a0,-1142 # d18 <malloc+0x1ae>
 196:	e6bff0ef          	jal	0 <err>
      printf("Buffer: %s\n", buf);
 19a:	f4840593          	addi	a1,s0,-184
 19e:	00001517          	auipc	a0,0x1
 1a2:	ba250513          	addi	a0,a0,-1118 # d40 <malloc+0x1d6>
 1a6:	111000ef          	jal	ab6 <printf>
      printf("Test: %s\n", testString);
 1aa:	00001597          	auipc	a1,0x1
 1ae:	b7e58593          	addi	a1,a1,-1154 # d28 <malloc+0x1be>
 1b2:	00001517          	auipc	a0,0x1
 1b6:	b9e50513          	addi	a0,a0,-1122 # d50 <malloc+0x1e6>
 1ba:	0fd000ef          	jal	ab6 <printf>
 1be:	bf55                	j	172 <test1+0x14c>

00000000000001c0 <remove_recursive>:


void remove_recursive(char *path) {
 1c0:	d9010113          	addi	sp,sp,-624
 1c4:	26113423          	sd	ra,616(sp)
 1c8:	26813023          	sd	s0,608(sp)
 1cc:	25213823          	sd	s2,592(sp)
 1d0:	1c80                	addi	s0,sp,624
 1d2:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
 1d4:	4581                	li	a1,0
 1d6:	4ec000ef          	jal	6c2 <open>
 1da:	04054063          	bltz	a0,21a <remove_recursive+0x5a>
 1de:	24913c23          	sd	s1,600(sp)
 1e2:	84aa                	mv	s1,a0
    fprintf(2, "rm: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 1e4:	d9840593          	addi	a1,s0,-616
 1e8:	4f2000ef          	jal	6da <fstat>
 1ec:	04054863          	bltz	a0,23c <remove_recursive+0x7c>
    fprintf(2, "rm: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 1f0:	da041783          	lh	a5,-608(s0)
 1f4:	4705                	li	a4,1
 1f6:	06e78c63          	beq	a5,a4,26e <remove_recursive+0xae>
 1fa:	37f9                	addiw	a5,a5,-2
 1fc:	17c2                	slli	a5,a5,0x30
 1fe:	93c1                	srli	a5,a5,0x30
 200:	16f76463          	bltu	a4,a5,368 <remove_recursive+0x1a8>
  case T_DEVICE:
  case T_FILE:
    close(fd);
 204:	8526                	mv	a0,s1
 206:	4a4000ef          	jal	6aa <close>
    if(unlink(path) < 0){
 20a:	854a                	mv	a0,s2
 20c:	4c6000ef          	jal	6d2 <unlink>
 210:	04054463          	bltz	a0,258 <remove_recursive+0x98>
 214:	25813483          	ld	s1,600(sp)
 218:	a809                	j	22a <remove_recursive+0x6a>
    fprintf(2, "rm: cannot open %s\n", path);
 21a:	864a                	mv	a2,s2
 21c:	00001597          	auipc	a1,0x1
 220:	b4458593          	addi	a1,a1,-1212 # d60 <malloc+0x1f6>
 224:	4509                	li	a0,2
 226:	067000ef          	jal	a8c <fprintf>
    if(unlink(path) < 0){
      fprintf(2, "rm: %s directory not empty or permission denied\n", path);
    }
    break;
  }
 22a:	26813083          	ld	ra,616(sp)
 22e:	26013403          	ld	s0,608(sp)
 232:	25013903          	ld	s2,592(sp)
 236:	27010113          	addi	sp,sp,624
 23a:	8082                	ret
    fprintf(2, "rm: cannot stat %s\n", path);
 23c:	864a                	mv	a2,s2
 23e:	00001597          	auipc	a1,0x1
 242:	b3a58593          	addi	a1,a1,-1222 # d78 <malloc+0x20e>
 246:	4509                	li	a0,2
 248:	045000ef          	jal	a8c <fprintf>
    close(fd);
 24c:	8526                	mv	a0,s1
 24e:	45c000ef          	jal	6aa <close>
    return;
 252:	25813483          	ld	s1,600(sp)
 256:	bfd1                	j	22a <remove_recursive+0x6a>
      fprintf(2, "rm: %s failed to delete\n", path);
 258:	864a                	mv	a2,s2
 25a:	00001597          	auipc	a1,0x1
 25e:	b3658593          	addi	a1,a1,-1226 # d90 <malloc+0x226>
 262:	4509                	li	a0,2
 264:	029000ef          	jal	a8c <fprintf>
 268:	25813483          	ld	s1,600(sp)
 26c:	bf7d                	j	22a <remove_recursive+0x6a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
 26e:	854a                	mv	a0,s2
 270:	1d6000ef          	jal	446 <strlen>
 274:	2541                	addiw	a0,a0,16
 276:	20000793          	li	a5,512
 27a:	00a7fe63          	bgeu	a5,a0,296 <remove_recursive+0xd6>
      printf("rm: path too long\n");
 27e:	00001517          	auipc	a0,0x1
 282:	b3250513          	addi	a0,a0,-1230 # db0 <malloc+0x246>
 286:	031000ef          	jal	ab6 <printf>
      close(fd);
 28a:	8526                	mv	a0,s1
 28c:	41e000ef          	jal	6aa <close>
      break;
 290:	25813483          	ld	s1,600(sp)
 294:	bf59                	j	22a <remove_recursive+0x6a>
 296:	25313423          	sd	s3,584(sp)
 29a:	25413023          	sd	s4,576(sp)
 29e:	23513c23          	sd	s5,568(sp)
    strcpy(buf, path);
 2a2:	85ca                	mv	a1,s2
 2a4:	dc040513          	addi	a0,s0,-576
 2a8:	156000ef          	jal	3fe <strcpy>
    p = buf+strlen(buf);
 2ac:	dc040513          	addi	a0,s0,-576
 2b0:	196000ef          	jal	446 <strlen>
 2b4:	1502                	slli	a0,a0,0x20
 2b6:	9101                	srli	a0,a0,0x20
 2b8:	dc040793          	addi	a5,s0,-576
 2bc:	00a789b3          	add	s3,a5,a0
    *p++ = '/';
 2c0:	00198a93          	addi	s5,s3,1
 2c4:	02f00793          	li	a5,47
 2c8:	00f98023          	sb	a5,0(s3)
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 2cc:	00001a17          	auipc	s4,0x1
 2d0:	afca0a13          	addi	s4,s4,-1284 # dc8 <malloc+0x25e>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2d4:	4641                	li	a2,16
 2d6:	db040593          	addi	a1,s0,-592
 2da:	8526                	mv	a0,s1
 2dc:	3be000ef          	jal	69a <read>
 2e0:	47c1                	li	a5,16
 2e2:	04f51163          	bne	a0,a5,324 <remove_recursive+0x164>
      if(de.inum == 0)
 2e6:	db045783          	lhu	a5,-592(s0)
 2ea:	d7ed                	beqz	a5,2d4 <remove_recursive+0x114>
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 2ec:	85d2                	mv	a1,s4
 2ee:	db240513          	addi	a0,s0,-590
 2f2:	128000ef          	jal	41a <strcmp>
 2f6:	dd79                	beqz	a0,2d4 <remove_recursive+0x114>
 2f8:	00001597          	auipc	a1,0x1
 2fc:	ad858593          	addi	a1,a1,-1320 # dd0 <malloc+0x266>
 300:	db240513          	addi	a0,s0,-590
 304:	116000ef          	jal	41a <strcmp>
 308:	d571                	beqz	a0,2d4 <remove_recursive+0x114>
      memmove(p, de.name, DIRSIZ);
 30a:	4639                	li	a2,14
 30c:	db240593          	addi	a1,s0,-590
 310:	8556                	mv	a0,s5
 312:	296000ef          	jal	5a8 <memmove>
      p[DIRSIZ] = 0;
 316:	000987a3          	sb	zero,15(s3)
      remove_recursive(buf); // recursively remove the sub directories.
 31a:	dc040513          	addi	a0,s0,-576
 31e:	ea3ff0ef          	jal	1c0 <remove_recursive>
 322:	bf4d                	j	2d4 <remove_recursive+0x114>
    close(fd);
 324:	8526                	mv	a0,s1
 326:	384000ef          	jal	6aa <close>
    if(unlink(path) < 0){
 32a:	854a                	mv	a0,s2
 32c:	3a6000ef          	jal	6d2 <unlink>
 330:	00054b63          	bltz	a0,346 <remove_recursive+0x186>
 334:	25813483          	ld	s1,600(sp)
 338:	24813983          	ld	s3,584(sp)
 33c:	24013a03          	ld	s4,576(sp)
 340:	23813a83          	ld	s5,568(sp)
 344:	b5dd                	j	22a <remove_recursive+0x6a>
      fprintf(2, "rm: %s directory not empty or permission denied\n", path);
 346:	864a                	mv	a2,s2
 348:	00001597          	auipc	a1,0x1
 34c:	a9058593          	addi	a1,a1,-1392 # dd8 <malloc+0x26e>
 350:	4509                	li	a0,2
 352:	73a000ef          	jal	a8c <fprintf>
 356:	25813483          	ld	s1,600(sp)
 35a:	24813983          	ld	s3,584(sp)
 35e:	24013a03          	ld	s4,576(sp)
 362:	23813a83          	ld	s5,568(sp)
 366:	b5d1                	j	22a <remove_recursive+0x6a>
 368:	25813483          	ld	s1,600(sp)
 36c:	bd7d                	j	22a <remove_recursive+0x6a>

000000000000036e <main>:
int main(int argc, char *argv[]) {
 36e:	1141                	addi	sp,sp,-16
 370:	e406                	sd	ra,8(sp)
 372:	e022                	sd	s0,0(sp)
 374:	0800                	addi	s0,sp,16
    if((fd = open("ICT1012", 0)) >= 0) {
 376:	4581                	li	a1,0
 378:	00001517          	auipc	a0,0x1
 37c:	92850513          	addi	a0,a0,-1752 # ca0 <malloc+0x136>
 380:	342000ef          	jal	6c2 <open>
 384:	04055263          	bgez	a0,3c8 <main+0x5a>
    printf("Testing test1()...\n");
 388:	00001517          	auipc	a0,0x1
 38c:	a8850513          	addi	a0,a0,-1400 # e10 <malloc+0x2a6>
 390:	726000ef          	jal	ab6 <printf>
    test1();
 394:	c93ff0ef          	jal	26 <test1>
    printf("test1(): OK!\n");
 398:	00001517          	auipc	a0,0x1
 39c:	a9050513          	addi	a0,a0,-1392 # e28 <malloc+0x2be>
 3a0:	716000ef          	jal	ab6 <printf>
    printf("pwd_test: all tests succeeded\n");
 3a4:	00001517          	auipc	a0,0x1
 3a8:	a9450513          	addi	a0,a0,-1388 # e38 <malloc+0x2ce>
 3ac:	70a000ef          	jal	ab6 <printf>
    if((fd = open("ICT1012", 0)) >= 0) {
 3b0:	4581                	li	a1,0
 3b2:	00001517          	auipc	a0,0x1
 3b6:	8ee50513          	addi	a0,a0,-1810 # ca0 <malloc+0x136>
 3ba:	308000ef          	jal	6c2 <open>
 3be:	00055e63          	bgez	a0,3da <main+0x6c>
    exit(0);
 3c2:	4501                	li	a0,0
 3c4:	2be000ef          	jal	682 <exit>
        close(fd);
 3c8:	2e2000ef          	jal	6aa <close>
        remove_recursive("ICT1012");
 3cc:	00001517          	auipc	a0,0x1
 3d0:	8d450513          	addi	a0,a0,-1836 # ca0 <malloc+0x136>
 3d4:	dedff0ef          	jal	1c0 <remove_recursive>
 3d8:	bf45                	j	388 <main+0x1a>
        close(fd);
 3da:	2d0000ef          	jal	6aa <close>
        remove_recursive("ICT1012");
 3de:	00001517          	auipc	a0,0x1
 3e2:	8c250513          	addi	a0,a0,-1854 # ca0 <malloc+0x136>
 3e6:	ddbff0ef          	jal	1c0 <remove_recursive>
 3ea:	bfe1                	j	3c2 <main+0x54>

00000000000003ec <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e406                	sd	ra,8(sp)
 3f0:	e022                	sd	s0,0(sp)
 3f2:	0800                	addi	s0,sp,16
  extern int main();
  main();
 3f4:	f7bff0ef          	jal	36e <main>
  exit(0);
 3f8:	4501                	li	a0,0
 3fa:	288000ef          	jal	682 <exit>

00000000000003fe <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e422                	sd	s0,8(sp)
 402:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 404:	87aa                	mv	a5,a0
 406:	0585                	addi	a1,a1,1
 408:	0785                	addi	a5,a5,1
 40a:	fff5c703          	lbu	a4,-1(a1)
 40e:	fee78fa3          	sb	a4,-1(a5)
 412:	fb75                	bnez	a4,406 <strcpy+0x8>
    ;
  return os;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret

000000000000041a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 420:	00054783          	lbu	a5,0(a0)
 424:	cb91                	beqz	a5,438 <strcmp+0x1e>
 426:	0005c703          	lbu	a4,0(a1)
 42a:	00f71763          	bne	a4,a5,438 <strcmp+0x1e>
    p++, q++;
 42e:	0505                	addi	a0,a0,1
 430:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 432:	00054783          	lbu	a5,0(a0)
 436:	fbe5                	bnez	a5,426 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 438:	0005c503          	lbu	a0,0(a1)
}
 43c:	40a7853b          	subw	a0,a5,a0
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret

0000000000000446 <strlen>:

uint
strlen(const char *s)
{
 446:	1141                	addi	sp,sp,-16
 448:	e422                	sd	s0,8(sp)
 44a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 44c:	00054783          	lbu	a5,0(a0)
 450:	cf91                	beqz	a5,46c <strlen+0x26>
 452:	0505                	addi	a0,a0,1
 454:	87aa                	mv	a5,a0
 456:	86be                	mv	a3,a5
 458:	0785                	addi	a5,a5,1
 45a:	fff7c703          	lbu	a4,-1(a5)
 45e:	ff65                	bnez	a4,456 <strlen+0x10>
 460:	40a6853b          	subw	a0,a3,a0
 464:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret
  for(n = 0; s[n]; n++)
 46c:	4501                	li	a0,0
 46e:	bfe5                	j	466 <strlen+0x20>

0000000000000470 <memset>:

void*
memset(void *dst, int c, uint n)
{
 470:	1141                	addi	sp,sp,-16
 472:	e422                	sd	s0,8(sp)
 474:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 476:	ca19                	beqz	a2,48c <memset+0x1c>
 478:	87aa                	mv	a5,a0
 47a:	1602                	slli	a2,a2,0x20
 47c:	9201                	srli	a2,a2,0x20
 47e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 482:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 486:	0785                	addi	a5,a5,1
 488:	fee79de3          	bne	a5,a4,482 <memset+0x12>
  }
  return dst;
}
 48c:	6422                	ld	s0,8(sp)
 48e:	0141                	addi	sp,sp,16
 490:	8082                	ret

0000000000000492 <strchr>:

char*
strchr(const char *s, char c)
{
 492:	1141                	addi	sp,sp,-16
 494:	e422                	sd	s0,8(sp)
 496:	0800                	addi	s0,sp,16
  for(; *s; s++)
 498:	00054783          	lbu	a5,0(a0)
 49c:	cb99                	beqz	a5,4b2 <strchr+0x20>
    if(*s == c)
 49e:	00f58763          	beq	a1,a5,4ac <strchr+0x1a>
  for(; *s; s++)
 4a2:	0505                	addi	a0,a0,1
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	fbfd                	bnez	a5,49e <strchr+0xc>
      return (char*)s;
  return 0;
 4aa:	4501                	li	a0,0
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret
  return 0;
 4b2:	4501                	li	a0,0
 4b4:	bfe5                	j	4ac <strchr+0x1a>

00000000000004b6 <gets>:

char*
gets(char *buf, int max)
{
 4b6:	711d                	addi	sp,sp,-96
 4b8:	ec86                	sd	ra,88(sp)
 4ba:	e8a2                	sd	s0,80(sp)
 4bc:	e4a6                	sd	s1,72(sp)
 4be:	e0ca                	sd	s2,64(sp)
 4c0:	fc4e                	sd	s3,56(sp)
 4c2:	f852                	sd	s4,48(sp)
 4c4:	f456                	sd	s5,40(sp)
 4c6:	f05a                	sd	s6,32(sp)
 4c8:	ec5e                	sd	s7,24(sp)
 4ca:	1080                	addi	s0,sp,96
 4cc:	8baa                	mv	s7,a0
 4ce:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d0:	892a                	mv	s2,a0
 4d2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4d4:	4aa9                	li	s5,10
 4d6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4d8:	89a6                	mv	s3,s1
 4da:	2485                	addiw	s1,s1,1
 4dc:	0344d663          	bge	s1,s4,508 <gets+0x52>
    cc = read(0, &c, 1);
 4e0:	4605                	li	a2,1
 4e2:	faf40593          	addi	a1,s0,-81
 4e6:	4501                	li	a0,0
 4e8:	1b2000ef          	jal	69a <read>
    if(cc < 1)
 4ec:	00a05e63          	blez	a0,508 <gets+0x52>
    buf[i++] = c;
 4f0:	faf44783          	lbu	a5,-81(s0)
 4f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4f8:	01578763          	beq	a5,s5,506 <gets+0x50>
 4fc:	0905                	addi	s2,s2,1
 4fe:	fd679de3          	bne	a5,s6,4d8 <gets+0x22>
    buf[i++] = c;
 502:	89a6                	mv	s3,s1
 504:	a011                	j	508 <gets+0x52>
 506:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 508:	99de                	add	s3,s3,s7
 50a:	00098023          	sb	zero,0(s3)
  return buf;
}
 50e:	855e                	mv	a0,s7
 510:	60e6                	ld	ra,88(sp)
 512:	6446                	ld	s0,80(sp)
 514:	64a6                	ld	s1,72(sp)
 516:	6906                	ld	s2,64(sp)
 518:	79e2                	ld	s3,56(sp)
 51a:	7a42                	ld	s4,48(sp)
 51c:	7aa2                	ld	s5,40(sp)
 51e:	7b02                	ld	s6,32(sp)
 520:	6be2                	ld	s7,24(sp)
 522:	6125                	addi	sp,sp,96
 524:	8082                	ret

0000000000000526 <stat>:

int
stat(const char *n, struct stat *st)
{
 526:	1101                	addi	sp,sp,-32
 528:	ec06                	sd	ra,24(sp)
 52a:	e822                	sd	s0,16(sp)
 52c:	e04a                	sd	s2,0(sp)
 52e:	1000                	addi	s0,sp,32
 530:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 532:	4581                	li	a1,0
 534:	18e000ef          	jal	6c2 <open>
  if(fd < 0)
 538:	02054263          	bltz	a0,55c <stat+0x36>
 53c:	e426                	sd	s1,8(sp)
 53e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 540:	85ca                	mv	a1,s2
 542:	198000ef          	jal	6da <fstat>
 546:	892a                	mv	s2,a0
  close(fd);
 548:	8526                	mv	a0,s1
 54a:	160000ef          	jal	6aa <close>
  return r;
 54e:	64a2                	ld	s1,8(sp)
}
 550:	854a                	mv	a0,s2
 552:	60e2                	ld	ra,24(sp)
 554:	6442                	ld	s0,16(sp)
 556:	6902                	ld	s2,0(sp)
 558:	6105                	addi	sp,sp,32
 55a:	8082                	ret
    return -1;
 55c:	597d                	li	s2,-1
 55e:	bfcd                	j	550 <stat+0x2a>

0000000000000560 <atoi>:

int
atoi(const char *s)
{
 560:	1141                	addi	sp,sp,-16
 562:	e422                	sd	s0,8(sp)
 564:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 566:	00054683          	lbu	a3,0(a0)
 56a:	fd06879b          	addiw	a5,a3,-48
 56e:	0ff7f793          	zext.b	a5,a5
 572:	4625                	li	a2,9
 574:	02f66863          	bltu	a2,a5,5a4 <atoi+0x44>
 578:	872a                	mv	a4,a0
  n = 0;
 57a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 57c:	0705                	addi	a4,a4,1
 57e:	0025179b          	slliw	a5,a0,0x2
 582:	9fa9                	addw	a5,a5,a0
 584:	0017979b          	slliw	a5,a5,0x1
 588:	9fb5                	addw	a5,a5,a3
 58a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 58e:	00074683          	lbu	a3,0(a4)
 592:	fd06879b          	addiw	a5,a3,-48
 596:	0ff7f793          	zext.b	a5,a5
 59a:	fef671e3          	bgeu	a2,a5,57c <atoi+0x1c>
  return n;
}
 59e:	6422                	ld	s0,8(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret
  n = 0;
 5a4:	4501                	li	a0,0
 5a6:	bfe5                	j	59e <atoi+0x3e>

00000000000005a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e422                	sd	s0,8(sp)
 5ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5ae:	02b57463          	bgeu	a0,a1,5d6 <memmove+0x2e>
    while(n-- > 0)
 5b2:	00c05f63          	blez	a2,5d0 <memmove+0x28>
 5b6:	1602                	slli	a2,a2,0x20
 5b8:	9201                	srli	a2,a2,0x20
 5ba:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5be:	872a                	mv	a4,a0
      *dst++ = *src++;
 5c0:	0585                	addi	a1,a1,1
 5c2:	0705                	addi	a4,a4,1
 5c4:	fff5c683          	lbu	a3,-1(a1)
 5c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5cc:	fef71ae3          	bne	a4,a5,5c0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5d0:	6422                	ld	s0,8(sp)
 5d2:	0141                	addi	sp,sp,16
 5d4:	8082                	ret
    dst += n;
 5d6:	00c50733          	add	a4,a0,a2
    src += n;
 5da:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5dc:	fec05ae3          	blez	a2,5d0 <memmove+0x28>
 5e0:	fff6079b          	addiw	a5,a2,-1
 5e4:	1782                	slli	a5,a5,0x20
 5e6:	9381                	srli	a5,a5,0x20
 5e8:	fff7c793          	not	a5,a5
 5ec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5ee:	15fd                	addi	a1,a1,-1
 5f0:	177d                	addi	a4,a4,-1
 5f2:	0005c683          	lbu	a3,0(a1)
 5f6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5fa:	fee79ae3          	bne	a5,a4,5ee <memmove+0x46>
 5fe:	bfc9                	j	5d0 <memmove+0x28>

0000000000000600 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 600:	1141                	addi	sp,sp,-16
 602:	e422                	sd	s0,8(sp)
 604:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 606:	ca05                	beqz	a2,636 <memcmp+0x36>
 608:	fff6069b          	addiw	a3,a2,-1
 60c:	1682                	slli	a3,a3,0x20
 60e:	9281                	srli	a3,a3,0x20
 610:	0685                	addi	a3,a3,1
 612:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 614:	00054783          	lbu	a5,0(a0)
 618:	0005c703          	lbu	a4,0(a1)
 61c:	00e79863          	bne	a5,a4,62c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 620:	0505                	addi	a0,a0,1
    p2++;
 622:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 624:	fed518e3          	bne	a0,a3,614 <memcmp+0x14>
  }
  return 0;
 628:	4501                	li	a0,0
 62a:	a019                	j	630 <memcmp+0x30>
      return *p1 - *p2;
 62c:	40e7853b          	subw	a0,a5,a4
}
 630:	6422                	ld	s0,8(sp)
 632:	0141                	addi	sp,sp,16
 634:	8082                	ret
  return 0;
 636:	4501                	li	a0,0
 638:	bfe5                	j	630 <memcmp+0x30>

000000000000063a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 63a:	1141                	addi	sp,sp,-16
 63c:	e406                	sd	ra,8(sp)
 63e:	e022                	sd	s0,0(sp)
 640:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 642:	f67ff0ef          	jal	5a8 <memmove>
}
 646:	60a2                	ld	ra,8(sp)
 648:	6402                	ld	s0,0(sp)
 64a:	0141                	addi	sp,sp,16
 64c:	8082                	ret

000000000000064e <sbrk>:

char *
sbrk(int n) {
 64e:	1141                	addi	sp,sp,-16
 650:	e406                	sd	ra,8(sp)
 652:	e022                	sd	s0,0(sp)
 654:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 656:	4585                	li	a1,1
 658:	0b2000ef          	jal	70a <sys_sbrk>
}
 65c:	60a2                	ld	ra,8(sp)
 65e:	6402                	ld	s0,0(sp)
 660:	0141                	addi	sp,sp,16
 662:	8082                	ret

0000000000000664 <sbrklazy>:

char *
sbrklazy(int n) {
 664:	1141                	addi	sp,sp,-16
 666:	e406                	sd	ra,8(sp)
 668:	e022                	sd	s0,0(sp)
 66a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 66c:	4589                	li	a1,2
 66e:	09c000ef          	jal	70a <sys_sbrk>
}
 672:	60a2                	ld	ra,8(sp)
 674:	6402                	ld	s0,0(sp)
 676:	0141                	addi	sp,sp,16
 678:	8082                	ret

000000000000067a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 67a:	4885                	li	a7,1
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <exit>:
.global exit
exit:
 li a7, SYS_exit
 682:	4889                	li	a7,2
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <wait>:
.global wait
wait:
 li a7, SYS_wait
 68a:	488d                	li	a7,3
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 692:	4891                	li	a7,4
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <read>:
.global read
read:
 li a7, SYS_read
 69a:	4895                	li	a7,5
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <write>:
.global write
write:
 li a7, SYS_write
 6a2:	48c1                	li	a7,16
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <close>:
.global close
close:
 li a7, SYS_close
 6aa:	48d5                	li	a7,21
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6b2:	4899                	li	a7,6
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 6ba:	489d                	li	a7,7
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <open>:
.global open
open:
 li a7, SYS_open
 6c2:	48bd                	li	a7,15
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6ca:	48c5                	li	a7,17
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6d2:	48c9                	li	a7,18
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6da:	48a1                	li	a7,8
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <link>:
.global link
link:
 li a7, SYS_link
 6e2:	48cd                	li	a7,19
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ea:	48d1                	li	a7,20
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6f2:	48a5                	li	a7,9
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 6fa:	48a9                	li	a7,10
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 702:	48ad                	li	a7,11
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 70a:	48b1                	li	a7,12
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <pause>:
.global pause
pause:
 li a7, SYS_pause
 712:	48b5                	li	a7,13
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 71a:	48b9                	li	a7,14
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 722:	1101                	addi	sp,sp,-32
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	addi	s0,sp,32
 72a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 72e:	4605                	li	a2,1
 730:	fef40593          	addi	a1,s0,-17
 734:	f6fff0ef          	jal	6a2 <write>
}
 738:	60e2                	ld	ra,24(sp)
 73a:	6442                	ld	s0,16(sp)
 73c:	6105                	addi	sp,sp,32
 73e:	8082                	ret

0000000000000740 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 740:	715d                	addi	sp,sp,-80
 742:	e486                	sd	ra,72(sp)
 744:	e0a2                	sd	s0,64(sp)
 746:	fc26                	sd	s1,56(sp)
 748:	0880                	addi	s0,sp,80
 74a:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 74c:	c299                	beqz	a3,752 <printint+0x12>
 74e:	0805c963          	bltz	a1,7e0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 752:	2581                	sext.w	a1,a1
  neg = 0;
 754:	4881                	li	a7,0
 756:	fb840693          	addi	a3,s0,-72
  }

  i = 0;
 75a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 75c:	2601                	sext.w	a2,a2
 75e:	00000517          	auipc	a0,0x0
 762:	70250513          	addi	a0,a0,1794 # e60 <digits>
 766:	883a                	mv	a6,a4
 768:	2705                	addiw	a4,a4,1
 76a:	02c5f7bb          	remuw	a5,a1,a2
 76e:	1782                	slli	a5,a5,0x20
 770:	9381                	srli	a5,a5,0x20
 772:	97aa                	add	a5,a5,a0
 774:	0007c783          	lbu	a5,0(a5)
 778:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 77c:	0005879b          	sext.w	a5,a1
 780:	02c5d5bb          	divuw	a1,a1,a2
 784:	0685                	addi	a3,a3,1
 786:	fec7f0e3          	bgeu	a5,a2,766 <printint+0x26>
  if(neg)
 78a:	00088c63          	beqz	a7,7a2 <printint+0x62>
    buf[i++] = '-';
 78e:	fd070793          	addi	a5,a4,-48
 792:	00878733          	add	a4,a5,s0
 796:	02d00793          	li	a5,45
 79a:	fef70423          	sb	a5,-24(a4)
 79e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7a2:	02e05a63          	blez	a4,7d6 <printint+0x96>
 7a6:	f84a                	sd	s2,48(sp)
 7a8:	f44e                	sd	s3,40(sp)
 7aa:	fb840793          	addi	a5,s0,-72
 7ae:	00e78933          	add	s2,a5,a4
 7b2:	fff78993          	addi	s3,a5,-1
 7b6:	99ba                	add	s3,s3,a4
 7b8:	377d                	addiw	a4,a4,-1
 7ba:	1702                	slli	a4,a4,0x20
 7bc:	9301                	srli	a4,a4,0x20
 7be:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7c2:	fff94583          	lbu	a1,-1(s2)
 7c6:	8526                	mv	a0,s1
 7c8:	f5bff0ef          	jal	722 <putc>
  while(--i >= 0)
 7cc:	197d                	addi	s2,s2,-1
 7ce:	ff391ae3          	bne	s2,s3,7c2 <printint+0x82>
 7d2:	7942                	ld	s2,48(sp)
 7d4:	79a2                	ld	s3,40(sp)
}
 7d6:	60a6                	ld	ra,72(sp)
 7d8:	6406                	ld	s0,64(sp)
 7da:	74e2                	ld	s1,56(sp)
 7dc:	6161                	addi	sp,sp,80
 7de:	8082                	ret
    x = -xx;
 7e0:	40b005bb          	negw	a1,a1
    neg = 1;
 7e4:	4885                	li	a7,1
    x = -xx;
 7e6:	bf85                	j	756 <printint+0x16>

00000000000007e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7e8:	711d                	addi	sp,sp,-96
 7ea:	ec86                	sd	ra,88(sp)
 7ec:	e8a2                	sd	s0,80(sp)
 7ee:	e0ca                	sd	s2,64(sp)
 7f0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7f2:	0005c903          	lbu	s2,0(a1)
 7f6:	28090663          	beqz	s2,a82 <vprintf+0x29a>
 7fa:	e4a6                	sd	s1,72(sp)
 7fc:	fc4e                	sd	s3,56(sp)
 7fe:	f852                	sd	s4,48(sp)
 800:	f456                	sd	s5,40(sp)
 802:	f05a                	sd	s6,32(sp)
 804:	ec5e                	sd	s7,24(sp)
 806:	e862                	sd	s8,16(sp)
 808:	e466                	sd	s9,8(sp)
 80a:	8b2a                	mv	s6,a0
 80c:	8a2e                	mv	s4,a1
 80e:	8bb2                	mv	s7,a2
  state = 0;
 810:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 812:	4481                	li	s1,0
 814:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 816:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 81a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 81e:	06c00c93          	li	s9,108
 822:	a005                	j	842 <vprintf+0x5a>
        putc(fd, c0);
 824:	85ca                	mv	a1,s2
 826:	855a                	mv	a0,s6
 828:	efbff0ef          	jal	722 <putc>
 82c:	a019                	j	832 <vprintf+0x4a>
    } else if(state == '%'){
 82e:	03598263          	beq	s3,s5,852 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 832:	2485                	addiw	s1,s1,1
 834:	8726                	mv	a4,s1
 836:	009a07b3          	add	a5,s4,s1
 83a:	0007c903          	lbu	s2,0(a5)
 83e:	22090a63          	beqz	s2,a72 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 842:	0009079b          	sext.w	a5,s2
    if(state == 0){
 846:	fe0994e3          	bnez	s3,82e <vprintf+0x46>
      if(c0 == '%'){
 84a:	fd579de3          	bne	a5,s5,824 <vprintf+0x3c>
        state = '%';
 84e:	89be                	mv	s3,a5
 850:	b7cd                	j	832 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 852:	00ea06b3          	add	a3,s4,a4
 856:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 85a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 85c:	c681                	beqz	a3,864 <vprintf+0x7c>
 85e:	9752                	add	a4,a4,s4
 860:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 864:	05878363          	beq	a5,s8,8aa <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 868:	05978d63          	beq	a5,s9,8c2 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 86c:	07500713          	li	a4,117
 870:	0ee78763          	beq	a5,a4,95e <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 874:	07800713          	li	a4,120
 878:	12e78963          	beq	a5,a4,9aa <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 87c:	07000713          	li	a4,112
 880:	14e78e63          	beq	a5,a4,9dc <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 884:	06300713          	li	a4,99
 888:	18e78e63          	beq	a5,a4,a24 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 88c:	07300713          	li	a4,115
 890:	1ae78463          	beq	a5,a4,a38 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 894:	02500713          	li	a4,37
 898:	04e79563          	bne	a5,a4,8e2 <vprintf+0xfa>
        putc(fd, '%');
 89c:	02500593          	li	a1,37
 8a0:	855a                	mv	a0,s6
 8a2:	e81ff0ef          	jal	722 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	b769                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 8aa:	008b8913          	addi	s2,s7,8
 8ae:	4685                	li	a3,1
 8b0:	4629                	li	a2,10
 8b2:	000ba583          	lw	a1,0(s7)
 8b6:	855a                	mv	a0,s6
 8b8:	e89ff0ef          	jal	740 <printint>
 8bc:	8bca                	mv	s7,s2
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bf8d                	j	832 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8c2:	06400793          	li	a5,100
 8c6:	02f68963          	beq	a3,a5,8f8 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8ca:	06c00793          	li	a5,108
 8ce:	04f68263          	beq	a3,a5,912 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 8d2:	07500793          	li	a5,117
 8d6:	0af68063          	beq	a3,a5,976 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 8da:	07800793          	li	a5,120
 8de:	0ef68263          	beq	a3,a5,9c2 <vprintf+0x1da>
        putc(fd, '%');
 8e2:	02500593          	li	a1,37
 8e6:	855a                	mv	a0,s6
 8e8:	e3bff0ef          	jal	722 <putc>
        putc(fd, c0);
 8ec:	85ca                	mv	a1,s2
 8ee:	855a                	mv	a0,s6
 8f0:	e33ff0ef          	jal	722 <putc>
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	bf35                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f8:	008b8913          	addi	s2,s7,8
 8fc:	4685                	li	a3,1
 8fe:	4629                	li	a2,10
 900:	000bb583          	ld	a1,0(s7)
 904:	855a                	mv	a0,s6
 906:	e3bff0ef          	jal	740 <printint>
        i += 1;
 90a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 90c:	8bca                	mv	s7,s2
      state = 0;
 90e:	4981                	li	s3,0
        i += 1;
 910:	b70d                	j	832 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 912:	06400793          	li	a5,100
 916:	02f60763          	beq	a2,a5,944 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 91a:	07500793          	li	a5,117
 91e:	06f60963          	beq	a2,a5,990 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 922:	07800793          	li	a5,120
 926:	faf61ee3          	bne	a2,a5,8e2 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 92a:	008b8913          	addi	s2,s7,8
 92e:	4681                	li	a3,0
 930:	4641                	li	a2,16
 932:	000bb583          	ld	a1,0(s7)
 936:	855a                	mv	a0,s6
 938:	e09ff0ef          	jal	740 <printint>
        i += 2;
 93c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 93e:	8bca                	mv	s7,s2
      state = 0;
 940:	4981                	li	s3,0
        i += 2;
 942:	bdc5                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 944:	008b8913          	addi	s2,s7,8
 948:	4685                	li	a3,1
 94a:	4629                	li	a2,10
 94c:	000bb583          	ld	a1,0(s7)
 950:	855a                	mv	a0,s6
 952:	defff0ef          	jal	740 <printint>
        i += 2;
 956:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 958:	8bca                	mv	s7,s2
      state = 0;
 95a:	4981                	li	s3,0
        i += 2;
 95c:	bdd9                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 95e:	008b8913          	addi	s2,s7,8
 962:	4681                	li	a3,0
 964:	4629                	li	a2,10
 966:	000be583          	lwu	a1,0(s7)
 96a:	855a                	mv	a0,s6
 96c:	dd5ff0ef          	jal	740 <printint>
 970:	8bca                	mv	s7,s2
      state = 0;
 972:	4981                	li	s3,0
 974:	bd7d                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 976:	008b8913          	addi	s2,s7,8
 97a:	4681                	li	a3,0
 97c:	4629                	li	a2,10
 97e:	000bb583          	ld	a1,0(s7)
 982:	855a                	mv	a0,s6
 984:	dbdff0ef          	jal	740 <printint>
        i += 1;
 988:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 98a:	8bca                	mv	s7,s2
      state = 0;
 98c:	4981                	li	s3,0
        i += 1;
 98e:	b555                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 990:	008b8913          	addi	s2,s7,8
 994:	4681                	li	a3,0
 996:	4629                	li	a2,10
 998:	000bb583          	ld	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	da3ff0ef          	jal	740 <printint>
        i += 2;
 9a2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
        i += 2;
 9a8:	b569                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 9aa:	008b8913          	addi	s2,s7,8
 9ae:	4681                	li	a3,0
 9b0:	4641                	li	a2,16
 9b2:	000be583          	lwu	a1,0(s7)
 9b6:	855a                	mv	a0,s6
 9b8:	d89ff0ef          	jal	740 <printint>
 9bc:	8bca                	mv	s7,s2
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	bd8d                	j	832 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9c2:	008b8913          	addi	s2,s7,8
 9c6:	4681                	li	a3,0
 9c8:	4641                	li	a2,16
 9ca:	000bb583          	ld	a1,0(s7)
 9ce:	855a                	mv	a0,s6
 9d0:	d71ff0ef          	jal	740 <printint>
        i += 1;
 9d4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9d6:	8bca                	mv	s7,s2
      state = 0;
 9d8:	4981                	li	s3,0
        i += 1;
 9da:	bda1                	j	832 <vprintf+0x4a>
 9dc:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9de:	008b8d13          	addi	s10,s7,8
 9e2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9e6:	03000593          	li	a1,48
 9ea:	855a                	mv	a0,s6
 9ec:	d37ff0ef          	jal	722 <putc>
  putc(fd, 'x');
 9f0:	07800593          	li	a1,120
 9f4:	855a                	mv	a0,s6
 9f6:	d2dff0ef          	jal	722 <putc>
 9fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9fc:	00000b97          	auipc	s7,0x0
 a00:	464b8b93          	addi	s7,s7,1124 # e60 <digits>
 a04:	03c9d793          	srli	a5,s3,0x3c
 a08:	97de                	add	a5,a5,s7
 a0a:	0007c583          	lbu	a1,0(a5)
 a0e:	855a                	mv	a0,s6
 a10:	d13ff0ef          	jal	722 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a14:	0992                	slli	s3,s3,0x4
 a16:	397d                	addiw	s2,s2,-1
 a18:	fe0916e3          	bnez	s2,a04 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 a1c:	8bea                	mv	s7,s10
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	6d02                	ld	s10,0(sp)
 a22:	bd01                	j	832 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 a24:	008b8913          	addi	s2,s7,8
 a28:	000bc583          	lbu	a1,0(s7)
 a2c:	855a                	mv	a0,s6
 a2e:	cf5ff0ef          	jal	722 <putc>
 a32:	8bca                	mv	s7,s2
      state = 0;
 a34:	4981                	li	s3,0
 a36:	bbf5                	j	832 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a38:	008b8993          	addi	s3,s7,8
 a3c:	000bb903          	ld	s2,0(s7)
 a40:	00090f63          	beqz	s2,a5e <vprintf+0x276>
        for(; *s; s++)
 a44:	00094583          	lbu	a1,0(s2)
 a48:	c195                	beqz	a1,a6c <vprintf+0x284>
          putc(fd, *s);
 a4a:	855a                	mv	a0,s6
 a4c:	cd7ff0ef          	jal	722 <putc>
        for(; *s; s++)
 a50:	0905                	addi	s2,s2,1
 a52:	00094583          	lbu	a1,0(s2)
 a56:	f9f5                	bnez	a1,a4a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a58:	8bce                	mv	s7,s3
      state = 0;
 a5a:	4981                	li	s3,0
 a5c:	bbd9                	j	832 <vprintf+0x4a>
          s = "(null)";
 a5e:	00000917          	auipc	s2,0x0
 a62:	3fa90913          	addi	s2,s2,1018 # e58 <malloc+0x2ee>
        for(; *s; s++)
 a66:	02800593          	li	a1,40
 a6a:	b7c5                	j	a4a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a6c:	8bce                	mv	s7,s3
      state = 0;
 a6e:	4981                	li	s3,0
 a70:	b3c9                	j	832 <vprintf+0x4a>
 a72:	64a6                	ld	s1,72(sp)
 a74:	79e2                	ld	s3,56(sp)
 a76:	7a42                	ld	s4,48(sp)
 a78:	7aa2                	ld	s5,40(sp)
 a7a:	7b02                	ld	s6,32(sp)
 a7c:	6be2                	ld	s7,24(sp)
 a7e:	6c42                	ld	s8,16(sp)
 a80:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a82:	60e6                	ld	ra,88(sp)
 a84:	6446                	ld	s0,80(sp)
 a86:	6906                	ld	s2,64(sp)
 a88:	6125                	addi	sp,sp,96
 a8a:	8082                	ret

0000000000000a8c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a8c:	715d                	addi	sp,sp,-80
 a8e:	ec06                	sd	ra,24(sp)
 a90:	e822                	sd	s0,16(sp)
 a92:	1000                	addi	s0,sp,32
 a94:	e010                	sd	a2,0(s0)
 a96:	e414                	sd	a3,8(s0)
 a98:	e818                	sd	a4,16(s0)
 a9a:	ec1c                	sd	a5,24(s0)
 a9c:	03043023          	sd	a6,32(s0)
 aa0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aa8:	8622                	mv	a2,s0
 aaa:	d3fff0ef          	jal	7e8 <vprintf>
}
 aae:	60e2                	ld	ra,24(sp)
 ab0:	6442                	ld	s0,16(sp)
 ab2:	6161                	addi	sp,sp,80
 ab4:	8082                	ret

0000000000000ab6 <printf>:

void
printf(const char *fmt, ...)
{
 ab6:	711d                	addi	sp,sp,-96
 ab8:	ec06                	sd	ra,24(sp)
 aba:	e822                	sd	s0,16(sp)
 abc:	1000                	addi	s0,sp,32
 abe:	e40c                	sd	a1,8(s0)
 ac0:	e810                	sd	a2,16(s0)
 ac2:	ec14                	sd	a3,24(s0)
 ac4:	f018                	sd	a4,32(s0)
 ac6:	f41c                	sd	a5,40(s0)
 ac8:	03043823          	sd	a6,48(s0)
 acc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad0:	00840613          	addi	a2,s0,8
 ad4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ad8:	85aa                	mv	a1,a0
 ada:	4505                	li	a0,1
 adc:	d0dff0ef          	jal	7e8 <vprintf>
}
 ae0:	60e2                	ld	ra,24(sp)
 ae2:	6442                	ld	s0,16(sp)
 ae4:	6125                	addi	sp,sp,96
 ae6:	8082                	ret

0000000000000ae8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae8:	1141                	addi	sp,sp,-16
 aea:	e422                	sd	s0,8(sp)
 aec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af2:	00001797          	auipc	a5,0x1
 af6:	50e7b783          	ld	a5,1294(a5) # 2000 <freep>
 afa:	a02d                	j	b24 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 afc:	4618                	lw	a4,8(a2)
 afe:	9f2d                	addw	a4,a4,a1
 b00:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b04:	6398                	ld	a4,0(a5)
 b06:	6310                	ld	a2,0(a4)
 b08:	a83d                	j	b46 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b0a:	ff852703          	lw	a4,-8(a0)
 b0e:	9f31                	addw	a4,a4,a2
 b10:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b12:	ff053683          	ld	a3,-16(a0)
 b16:	a091                	j	b5a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	6398                	ld	a4,0(a5)
 b1a:	00e7e463          	bltu	a5,a4,b22 <free+0x3a>
 b1e:	00e6ea63          	bltu	a3,a4,b32 <free+0x4a>
{
 b22:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b24:	fed7fae3          	bgeu	a5,a3,b18 <free+0x30>
 b28:	6398                	ld	a4,0(a5)
 b2a:	00e6e463          	bltu	a3,a4,b32 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2e:	fee7eae3          	bltu	a5,a4,b22 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b32:	ff852583          	lw	a1,-8(a0)
 b36:	6390                	ld	a2,0(a5)
 b38:	02059813          	slli	a6,a1,0x20
 b3c:	01c85713          	srli	a4,a6,0x1c
 b40:	9736                	add	a4,a4,a3
 b42:	fae60de3          	beq	a2,a4,afc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b46:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b4a:	4790                	lw	a2,8(a5)
 b4c:	02061593          	slli	a1,a2,0x20
 b50:	01c5d713          	srli	a4,a1,0x1c
 b54:	973e                	add	a4,a4,a5
 b56:	fae68ae3          	beq	a3,a4,b0a <free+0x22>
    p->s.ptr = bp->s.ptr;
 b5a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b5c:	00001717          	auipc	a4,0x1
 b60:	4af73223          	sd	a5,1188(a4) # 2000 <freep>
}
 b64:	6422                	ld	s0,8(sp)
 b66:	0141                	addi	sp,sp,16
 b68:	8082                	ret

0000000000000b6a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b6a:	7139                	addi	sp,sp,-64
 b6c:	fc06                	sd	ra,56(sp)
 b6e:	f822                	sd	s0,48(sp)
 b70:	f426                	sd	s1,40(sp)
 b72:	ec4e                	sd	s3,24(sp)
 b74:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b76:	02051493          	slli	s1,a0,0x20
 b7a:	9081                	srli	s1,s1,0x20
 b7c:	04bd                	addi	s1,s1,15
 b7e:	8091                	srli	s1,s1,0x4
 b80:	0014899b          	addiw	s3,s1,1
 b84:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b86:	00001517          	auipc	a0,0x1
 b8a:	47a53503          	ld	a0,1146(a0) # 2000 <freep>
 b8e:	c915                	beqz	a0,bc2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b92:	4798                	lw	a4,8(a5)
 b94:	08977a63          	bgeu	a4,s1,c28 <malloc+0xbe>
 b98:	f04a                	sd	s2,32(sp)
 b9a:	e852                	sd	s4,16(sp)
 b9c:	e456                	sd	s5,8(sp)
 b9e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ba0:	8a4e                	mv	s4,s3
 ba2:	0009871b          	sext.w	a4,s3
 ba6:	6685                	lui	a3,0x1
 ba8:	00d77363          	bgeu	a4,a3,bae <malloc+0x44>
 bac:	6a05                	lui	s4,0x1
 bae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bb2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bb6:	00001917          	auipc	s2,0x1
 bba:	44a90913          	addi	s2,s2,1098 # 2000 <freep>
  if(p == SBRK_ERROR)
 bbe:	5afd                	li	s5,-1
 bc0:	a081                	j	c00 <malloc+0x96>
 bc2:	f04a                	sd	s2,32(sp)
 bc4:	e852                	sd	s4,16(sp)
 bc6:	e456                	sd	s5,8(sp)
 bc8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bca:	00001797          	auipc	a5,0x1
 bce:	44678793          	addi	a5,a5,1094 # 2010 <base>
 bd2:	00001717          	auipc	a4,0x1
 bd6:	42f73723          	sd	a5,1070(a4) # 2000 <freep>
 bda:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bdc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 be0:	b7c1                	j	ba0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 be2:	6398                	ld	a4,0(a5)
 be4:	e118                	sd	a4,0(a0)
 be6:	a8a9                	j	c40 <malloc+0xd6>
  hp->s.size = nu;
 be8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bec:	0541                	addi	a0,a0,16
 bee:	efbff0ef          	jal	ae8 <free>
  return freep;
 bf2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bf6:	c12d                	beqz	a0,c58 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bf8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bfa:	4798                	lw	a4,8(a5)
 bfc:	02977263          	bgeu	a4,s1,c20 <malloc+0xb6>
    if(p == freep)
 c00:	00093703          	ld	a4,0(s2)
 c04:	853e                	mv	a0,a5
 c06:	fef719e3          	bne	a4,a5,bf8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c0a:	8552                	mv	a0,s4
 c0c:	a43ff0ef          	jal	64e <sbrk>
  if(p == SBRK_ERROR)
 c10:	fd551ce3          	bne	a0,s5,be8 <malloc+0x7e>
        return 0;
 c14:	4501                	li	a0,0
 c16:	7902                	ld	s2,32(sp)
 c18:	6a42                	ld	s4,16(sp)
 c1a:	6aa2                	ld	s5,8(sp)
 c1c:	6b02                	ld	s6,0(sp)
 c1e:	a03d                	j	c4c <malloc+0xe2>
 c20:	7902                	ld	s2,32(sp)
 c22:	6a42                	ld	s4,16(sp)
 c24:	6aa2                	ld	s5,8(sp)
 c26:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c28:	fae48de3          	beq	s1,a4,be2 <malloc+0x78>
        p->s.size -= nunits;
 c2c:	4137073b          	subw	a4,a4,s3
 c30:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c32:	02071693          	slli	a3,a4,0x20
 c36:	01c6d713          	srli	a4,a3,0x1c
 c3a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c3c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c40:	00001717          	auipc	a4,0x1
 c44:	3ca73023          	sd	a0,960(a4) # 2000 <freep>
      return (void*)(p + 1);
 c48:	01078513          	addi	a0,a5,16
  }
}
 c4c:	70e2                	ld	ra,56(sp)
 c4e:	7442                	ld	s0,48(sp)
 c50:	74a2                	ld	s1,40(sp)
 c52:	69e2                	ld	s3,24(sp)
 c54:	6121                	addi	sp,sp,64
 c56:	8082                	ret
 c58:	7902                	ld	s2,32(sp)
 c5a:	6a42                	ld	s4,16(sp)
 c5c:	6aa2                	ld	s5,8(sp)
 c5e:	6b02                	ld	s6,0(sp)
 c60:	b7f5                	j	c4c <malloc+0xe2>
