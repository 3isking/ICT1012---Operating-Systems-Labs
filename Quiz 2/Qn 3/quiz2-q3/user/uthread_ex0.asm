
user/_uthread_ex0:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_a>:
volatile int a_started, b_started, c_started;
volatile int a_n, b_n, c_n;

void 
thread_a(void)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;
  printf("thread_a started\n");
  10:	00001517          	auipc	a0,0x1
  14:	d2850513          	addi	a0,a0,-728 # d38 <malloc+0x106>
  18:	00001097          	auipc	ra,0x1
  1c:	b62080e7          	jalr	-1182(ra) # b7a <printf>
  a_started = 1;
  20:	4785                	li	a5,1
  22:	00001717          	auipc	a4,0x1
  26:	42f72d23          	sw	a5,1082(a4) # 145c <a_started>
  while(b_started == 0 || c_started == 0)
  2a:	00001497          	auipc	s1,0x1
  2e:	42e48493          	addi	s1,s1,1070 # 1458 <b_started>
  32:	00001917          	auipc	s2,0x1
  36:	42290913          	addi	s2,s2,1058 # 1454 <c_started>
  3a:	a029                	j	44 <thread_a+0x44>
    thread_yield();
  3c:	00000097          	auipc	ra,0x0
  40:	4be080e7          	jalr	1214(ra) # 4fa <thread_yield>
  while(b_started == 0 || c_started == 0)
  44:	409c                	lw	a5,0(s1)
  46:	2781                	sext.w	a5,a5
  48:	dbf5                	beqz	a5,3c <thread_a+0x3c>
  4a:	00092783          	lw	a5,0(s2)
  4e:	2781                	sext.w	a5,a5
  50:	d7f5                	beqz	a5,3c <thread_a+0x3c>
  
  
  for (i = 0; i < 3; i++) {
  52:	4481                	li	s1,0
    printf("thread_a %d\n", i);
  54:	00001a17          	auipc	s4,0x1
  58:	cfca0a13          	addi	s4,s4,-772 # d50 <malloc+0x11e>
    a_n += 1;
  5c:	00001917          	auipc	s2,0x1
  60:	3f490913          	addi	s2,s2,1012 # 1450 <a_n>
  for (i = 0; i < 3; i++) {
  64:	498d                	li	s3,3
    printf("thread_a %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	8552                	mv	a0,s4
  6a:	00001097          	auipc	ra,0x1
  6e:	b10080e7          	jalr	-1264(ra) # b7a <printf>
    a_n += 1;
  72:	00092783          	lw	a5,0(s2)
  76:	2785                	addiw	a5,a5,1
  78:	00f92023          	sw	a5,0(s2)
    thread_yield();
  7c:	00000097          	auipc	ra,0x0
  80:	47e080e7          	jalr	1150(ra) # 4fa <thread_yield>
  for (i = 0; i < 3; i++) {
  84:	2485                	addiw	s1,s1,1
  86:	ff3490e3          	bne	s1,s3,66 <thread_a+0x66>
  }
  printf("thread_a: exit after %d\n", a_n);
  8a:	00001597          	auipc	a1,0x1
  8e:	3c65a583          	lw	a1,966(a1) # 1450 <a_n>
  92:	00001517          	auipc	a0,0x1
  96:	cce50513          	addi	a0,a0,-818 # d60 <malloc+0x12e>
  9a:	00001097          	auipc	ra,0x1
  9e:	ae0080e7          	jalr	-1312(ra) # b7a <printf>
  thread_wakeup(2);
  a2:	4509                	li	a0,2
  a4:	00000097          	auipc	ra,0x0
  a8:	296080e7          	jalr	662(ra) # 33a <thread_wakeup>
  current_thread->state = FREE;
  ac:	00001797          	auipc	a5,0x1
  b0:	3b47b783          	ld	a5,948(a5) # 1460 <current_thread>
  b4:	6709                	lui	a4,0x2
  b6:	97ba                	add	a5,a5,a4
  b8:	0007a023          	sw	zero,0(a5)
  thread_schedule();
  bc:	00000097          	auipc	ra,0x0
  c0:	2d6080e7          	jalr	726(ra) # 392 <thread_schedule>
}
  c4:	70a2                	ld	ra,40(sp)
  c6:	7402                	ld	s0,32(sp)
  c8:	64e2                	ld	s1,24(sp)
  ca:	6942                	ld	s2,16(sp)
  cc:	69a2                	ld	s3,8(sp)
  ce:	6a02                	ld	s4,0(sp)
  d0:	6145                	addi	sp,sp,48
  d2:	8082                	ret

00000000000000d4 <thread_b>:

void 
thread_b(void)
{
  d4:	7179                	addi	sp,sp,-48
  d6:	f406                	sd	ra,40(sp)
  d8:	f022                	sd	s0,32(sp)
  da:	ec26                	sd	s1,24(sp)
  dc:	e84a                	sd	s2,16(sp)
  de:	e44e                	sd	s3,8(sp)
  e0:	e052                	sd	s4,0(sp)
  e2:	1800                	addi	s0,sp,48
  int i;
  printf("thread_b started\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	c9c50513          	addi	a0,a0,-868 # d80 <malloc+0x14e>
  ec:	00001097          	auipc	ra,0x1
  f0:	a8e080e7          	jalr	-1394(ra) # b7a <printf>
  b_started = 1;
  f4:	4785                	li	a5,1
  f6:	00001717          	auipc	a4,0x1
  fa:	36f72123          	sw	a5,866(a4) # 1458 <b_started>
  while(a_started == 0 || c_started == 0)
  fe:	00001497          	auipc	s1,0x1
 102:	35e48493          	addi	s1,s1,862 # 145c <a_started>
 106:	00001917          	auipc	s2,0x1
 10a:	34e90913          	addi	s2,s2,846 # 1454 <c_started>
 10e:	a029                	j	118 <thread_b+0x44>
    thread_yield();
 110:	00000097          	auipc	ra,0x0
 114:	3ea080e7          	jalr	1002(ra) # 4fa <thread_yield>
  while(a_started == 0 || c_started == 0)
 118:	409c                	lw	a5,0(s1)
 11a:	2781                	sext.w	a5,a5
 11c:	dbf5                	beqz	a5,110 <thread_b+0x3c>
 11e:	00092783          	lw	a5,0(s2)
 122:	2781                	sext.w	a5,a5
 124:	d7f5                	beqz	a5,110 <thread_b+0x3c>
  
  thread_sleep();
 126:	00000097          	auipc	ra,0x0
 12a:	368080e7          	jalr	872(ra) # 48e <thread_sleep>
  for (i = 0; i < 3; i++) {
 12e:	4481                	li	s1,0
    printf("thread_b %d\n", i);
 130:	00001a17          	auipc	s4,0x1
 134:	c68a0a13          	addi	s4,s4,-920 # d98 <malloc+0x166>
    b_n += 1;
 138:	00001917          	auipc	s2,0x1
 13c:	31490913          	addi	s2,s2,788 # 144c <b_n>
  for (i = 0; i < 3; i++) {
 140:	498d                	li	s3,3
    printf("thread_b %d\n", i);
 142:	85a6                	mv	a1,s1
 144:	8552                	mv	a0,s4
 146:	00001097          	auipc	ra,0x1
 14a:	a34080e7          	jalr	-1484(ra) # b7a <printf>
    b_n += 1;
 14e:	00092783          	lw	a5,0(s2)
 152:	2785                	addiw	a5,a5,1
 154:	00f92023          	sw	a5,0(s2)
    thread_yield();
 158:	00000097          	auipc	ra,0x0
 15c:	3a2080e7          	jalr	930(ra) # 4fa <thread_yield>
  for (i = 0; i < 3; i++) {
 160:	2485                	addiw	s1,s1,1
 162:	ff3490e3          	bne	s1,s3,142 <thread_b+0x6e>
  }
  printf("thread_b: exit after %d\n", b_n);
 166:	00001597          	auipc	a1,0x1
 16a:	2e65a583          	lw	a1,742(a1) # 144c <b_n>
 16e:	00001517          	auipc	a0,0x1
 172:	c3a50513          	addi	a0,a0,-966 # da8 <malloc+0x176>
 176:	00001097          	auipc	ra,0x1
 17a:	a04080e7          	jalr	-1532(ra) # b7a <printf>
  thread_wakeup(3);
 17e:	450d                	li	a0,3
 180:	00000097          	auipc	ra,0x0
 184:	1ba080e7          	jalr	442(ra) # 33a <thread_wakeup>
  current_thread->state = FREE;
 188:	00001797          	auipc	a5,0x1
 18c:	2d87b783          	ld	a5,728(a5) # 1460 <current_thread>
 190:	6709                	lui	a4,0x2
 192:	97ba                	add	a5,a5,a4
 194:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 198:	00000097          	auipc	ra,0x0
 19c:	1fa080e7          	jalr	506(ra) # 392 <thread_schedule>
}
 1a0:	70a2                	ld	ra,40(sp)
 1a2:	7402                	ld	s0,32(sp)
 1a4:	64e2                	ld	s1,24(sp)
 1a6:	6942                	ld	s2,16(sp)
 1a8:	69a2                	ld	s3,8(sp)
 1aa:	6a02                	ld	s4,0(sp)
 1ac:	6145                	addi	sp,sp,48
 1ae:	8082                	ret

00000000000001b0 <thread_c>:

void 
thread_c(void)
{
 1b0:	7179                	addi	sp,sp,-48
 1b2:	f406                	sd	ra,40(sp)
 1b4:	f022                	sd	s0,32(sp)
 1b6:	ec26                	sd	s1,24(sp)
 1b8:	e84a                	sd	s2,16(sp)
 1ba:	e44e                	sd	s3,8(sp)
 1bc:	e052                	sd	s4,0(sp)
 1be:	1800                	addi	s0,sp,48
  int i;
  printf("thread_c started\n");
 1c0:	00001517          	auipc	a0,0x1
 1c4:	c0850513          	addi	a0,a0,-1016 # dc8 <malloc+0x196>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	9b2080e7          	jalr	-1614(ra) # b7a <printf>
  c_started = 1;
 1d0:	4785                	li	a5,1
 1d2:	00001717          	auipc	a4,0x1
 1d6:	28f72123          	sw	a5,642(a4) # 1454 <c_started>
  while(a_started == 0 || b_started == 0)
 1da:	00001497          	auipc	s1,0x1
 1de:	28248493          	addi	s1,s1,642 # 145c <a_started>
 1e2:	00001917          	auipc	s2,0x1
 1e6:	27690913          	addi	s2,s2,630 # 1458 <b_started>
 1ea:	a029                	j	1f4 <thread_c+0x44>
    thread_yield();
 1ec:	00000097          	auipc	ra,0x0
 1f0:	30e080e7          	jalr	782(ra) # 4fa <thread_yield>
  while(a_started == 0 || b_started == 0)
 1f4:	409c                	lw	a5,0(s1)
 1f6:	2781                	sext.w	a5,a5
 1f8:	dbf5                	beqz	a5,1ec <thread_c+0x3c>
 1fa:	00092783          	lw	a5,0(s2)
 1fe:	2781                	sext.w	a5,a5
 200:	d7f5                	beqz	a5,1ec <thread_c+0x3c>
  thread_sleep();
 202:	00000097          	auipc	ra,0x0
 206:	28c080e7          	jalr	652(ra) # 48e <thread_sleep>
  for (i = 0; i < 3; i++) {
 20a:	4481                	li	s1,0
    printf("thread_c %d\n", i);
 20c:	00001a17          	auipc	s4,0x1
 210:	bd4a0a13          	addi	s4,s4,-1068 # de0 <malloc+0x1ae>
    c_n += 1;
 214:	00001917          	auipc	s2,0x1
 218:	23490913          	addi	s2,s2,564 # 1448 <c_n>
  for (i = 0; i < 3; i++) {
 21c:	498d                	li	s3,3
    printf("thread_c %d\n", i);
 21e:	85a6                	mv	a1,s1
 220:	8552                	mv	a0,s4
 222:	00001097          	auipc	ra,0x1
 226:	958080e7          	jalr	-1704(ra) # b7a <printf>
    c_n += 1;
 22a:	00092783          	lw	a5,0(s2)
 22e:	2785                	addiw	a5,a5,1
 230:	00f92023          	sw	a5,0(s2)
    thread_yield();
 234:	00000097          	auipc	ra,0x0
 238:	2c6080e7          	jalr	710(ra) # 4fa <thread_yield>
  for (i = 0; i < 3; i++) {
 23c:	2485                	addiw	s1,s1,1
 23e:	ff3490e3          	bne	s1,s3,21e <thread_c+0x6e>
  }
  printf("thread_c: exit after %d\n", c_n);
 242:	00001597          	auipc	a1,0x1
 246:	2065a583          	lw	a1,518(a1) # 1448 <c_n>
 24a:	00001517          	auipc	a0,0x1
 24e:	ba650513          	addi	a0,a0,-1114 # df0 <malloc+0x1be>
 252:	00001097          	auipc	ra,0x1
 256:	928080e7          	jalr	-1752(ra) # b7a <printf>

  current_thread->state = FREE;
 25a:	00001797          	auipc	a5,0x1
 25e:	2067b783          	ld	a5,518(a5) # 1460 <current_thread>
 262:	6709                	lui	a4,0x2
 264:	97ba                	add	a5,a5,a4
 266:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 26a:	00000097          	auipc	ra,0x0
 26e:	128080e7          	jalr	296(ra) # 392 <thread_schedule>
}
 272:	70a2                	ld	ra,40(sp)
 274:	7402                	ld	s0,32(sp)
 276:	64e2                	ld	s1,24(sp)
 278:	6942                	ld	s2,16(sp)
 27a:	69a2                	ld	s3,8(sp)
 27c:	6a02                	ld	s4,0(sp)
 27e:	6145                	addi	sp,sp,48
 280:	8082                	ret

0000000000000282 <main>:

int 
main(int argc, char *argv[]) 
{
 282:	1141                	addi	sp,sp,-16
 284:	e406                	sd	ra,8(sp)
 286:	e022                	sd	s0,0(sp)
 288:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 28a:	00001797          	auipc	a5,0x1
 28e:	1c07a523          	sw	zero,458(a5) # 1454 <c_started>
 292:	00001797          	auipc	a5,0x1
 296:	1c07a323          	sw	zero,454(a5) # 1458 <b_started>
 29a:	00001797          	auipc	a5,0x1
 29e:	1c07a123          	sw	zero,450(a5) # 145c <a_started>
  a_n = b_n = c_n = 0;
 2a2:	00001797          	auipc	a5,0x1
 2a6:	1a07a323          	sw	zero,422(a5) # 1448 <c_n>
 2aa:	00001797          	auipc	a5,0x1
 2ae:	1a07a123          	sw	zero,418(a5) # 144c <b_n>
 2b2:	00001797          	auipc	a5,0x1
 2b6:	1807af23          	sw	zero,414(a5) # 1450 <a_n>
  thread_init();
 2ba:	00000097          	auipc	ra,0x0
 2be:	05a080e7          	jalr	90(ra) # 314 <thread_init>
  thread_create(thread_a);
 2c2:	00000517          	auipc	a0,0x0
 2c6:	d3e50513          	addi	a0,a0,-706 # 0 <thread_a>
 2ca:	00000097          	auipc	ra,0x0
 2ce:	1ec080e7          	jalr	492(ra) # 4b6 <thread_create>
  thread_create(thread_b);
 2d2:	00000517          	auipc	a0,0x0
 2d6:	e0250513          	addi	a0,a0,-510 # d4 <thread_b>
 2da:	00000097          	auipc	ra,0x0
 2de:	1dc080e7          	jalr	476(ra) # 4b6 <thread_create>
  thread_create(thread_c);
 2e2:	00000517          	auipc	a0,0x0
 2e6:	ece50513          	addi	a0,a0,-306 # 1b0 <thread_c>
 2ea:	00000097          	auipc	ra,0x0
 2ee:	1cc080e7          	jalr	460(ra) # 4b6 <thread_create>
  current_thread->state = FREE;
 2f2:	00001797          	auipc	a5,0x1
 2f6:	16e7b783          	ld	a5,366(a5) # 1460 <current_thread>
 2fa:	6709                	lui	a4,0x2
 2fc:	97ba                	add	a5,a5,a4
 2fe:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 302:	00000097          	auipc	ra,0x0
 306:	090080e7          	jalr	144(ra) # 392 <thread_schedule>
  exit(0);
 30a:	4501                	li	a0,0
 30c:	00000097          	auipc	ra,0x0
 310:	506080e7          	jalr	1286(ra) # 812 <exit>

0000000000000314 <thread_init>:
struct thread *current_thread;

              
void 
thread_init(void)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  // main() is thread 0, which will make the first invocation to
  // thread_schedule(). It needs a stack so that the first thread_switch() can
  // save thread 0's state.
  current_thread = &all_thread[0];
 31a:	00001797          	auipc	a5,0x1
 31e:	15678793          	addi	a5,a5,342 # 1470 <all_thread>
 322:	00001717          	auipc	a4,0x1
 326:	12f73f23          	sd	a5,318(a4) # 1460 <current_thread>
  current_thread->state = RUNNING;
 32a:	4785                	li	a5,1
 32c:	00003717          	auipc	a4,0x3
 330:	14f72223          	sw	a5,324(a4) # 3470 <__global_pointer$+0x182c>
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <thread_wakeup>:
  thread_schedule();
}

int 
thread_wakeup(int thread_id)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  //add your code here
  struct thread *wake_thread = &all_thread[thread_id];
  if (thread_id < 0 || thread_id >= MAX_THREAD){
 340:	478d                	li	a5,3
 342:	04a7e463          	bltu	a5,a0,38a <thread_wakeup+0x50>
    return -1;
  }

  if (wake_thread->state != SLEEPING){
 346:	6789                	lui	a5,0x2
 348:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x434>
 34c:	02f507b3          	mul	a5,a0,a5
 350:	00001697          	auipc	a3,0x1
 354:	12068693          	addi	a3,a3,288 # 1470 <all_thread>
 358:	96be                	add	a3,a3,a5
 35a:	6789                	lui	a5,0x2
 35c:	97b6                	add	a5,a5,a3
 35e:	4394                	lw	a3,0(a5)
 360:	478d                	li	a5,3
 362:	02f69663          	bne	a3,a5,38e <thread_wakeup+0x54>
    return -1;
  }

  wake_thread->state = RUNNABLE;
 366:	6789                	lui	a5,0x2
 368:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x434>
 36c:	02f50733          	mul	a4,a0,a5
 370:	00001797          	auipc	a5,0x1
 374:	10078793          	addi	a5,a5,256 # 1470 <all_thread>
 378:	973e                	add	a4,a4,a5
 37a:	6789                	lui	a5,0x2
 37c:	97ba                	add	a5,a5,a4
 37e:	4709                	li	a4,2
 380:	c398                	sw	a4,0(a5)
  return 0;
 382:	4501                	li	a0,0
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
    return -1;
 38a:	557d                	li	a0,-1
 38c:	bfe5                	j	384 <thread_wakeup+0x4a>
    return -1;
 38e:	557d                	li	a0,-1
 390:	bfd5                	j	384 <thread_wakeup+0x4a>

0000000000000392 <thread_schedule>:

void thread_schedule(void)
{
 392:	1101                	addi	sp,sp,-32
 394:	ec06                	sd	ra,24(sp)
 396:	e822                	sd	s0,16(sp)
 398:	e426                	sd	s1,8(sp)
 39a:	1000                	addi	s0,sp,32
  struct thread *t, *next_thread;
  int sleeping_thread = 0;
  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
 39c:	6789                	lui	a5,0x2
 39e:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x434>
 3a2:	00001597          	auipc	a1,0x1
 3a6:	0be5b583          	ld	a1,190(a1) # 1460 <current_thread>
 3aa:	95be                	add	a1,a1,a5
 3ac:	4791                	li	a5,4
  int sleeping_thread = 0;
 3ae:	4481                	li	s1,0
  for(int i = 0; i < MAX_THREAD; i++){
    if(t >= all_thread + MAX_THREAD)
 3b0:	00009817          	auipc	a6,0x9
 3b4:	2a080813          	addi	a6,a6,672 # 9650 <base>
      t = all_thread;
    if(t->state == RUNNABLE) {
 3b8:	6509                	lui	a0,0x2
 3ba:	4609                	li	a2,2
      next_thread = t;
      break;
    }
    //add code to identify that there are sleeping threads
    if(t->state == SLEEPING) {
 3bc:	488d                	li	a7,3
      sleeping_thread = 1;
 3be:	4305                	li	t1,1
    }
    t = t + 1;
 3c0:	6689                	lui	a3,0x2
 3c2:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x434>
 3c6:	a819                	j	3dc <thread_schedule+0x4a>
    if(t->state == RUNNABLE) {
 3c8:	00a58733          	add	a4,a1,a0
 3cc:	4318                	lw	a4,0(a4)
 3ce:	04c70d63          	beq	a4,a2,428 <thread_schedule+0x96>
    if(t->state == SLEEPING) {
 3d2:	01170c63          	beq	a4,a7,3ea <thread_schedule+0x58>
    t = t + 1;
 3d6:	95b6                	add	a1,a1,a3
  for(int i = 0; i < MAX_THREAD; i++){
 3d8:	37fd                	addiw	a5,a5,-1
 3da:	c3d1                	beqz	a5,45e <thread_schedule+0xcc>
    if(t >= all_thread + MAX_THREAD)
 3dc:	ff05e6e3          	bltu	a1,a6,3c8 <thread_schedule+0x36>
      t = all_thread;
 3e0:	00001597          	auipc	a1,0x1
 3e4:	09058593          	addi	a1,a1,144 # 1470 <all_thread>
 3e8:	b7c5                	j	3c8 <thread_schedule+0x36>
      sleeping_thread = 1;
 3ea:	849a                	mv	s1,t1
 3ec:	b7ed                	j	3d6 <thread_schedule+0x44>
        if(first_sleep == 0){
          all_thread[i].state = RUNNING;
          next_thread = &all_thread[i];
          first_sleep = 1;
        } else {
          all_thread[i].state = RUNNABLE;
 3ee:	4709                	li	a4,2
 3f0:	c398                	sw	a4,0(a5)
      for(int i = 0; i < MAX_THREAD; i++){ 
 3f2:	97b6                	add	a5,a5,a3
 3f4:	03078a63          	beq	a5,a6,428 <thread_schedule+0x96>
        if(all_thread[i].state == SLEEPING){
 3f8:	4398                	lw	a4,0(a5)
 3fa:	fea71ce3          	bne	a4,a0,3f2 <thread_schedule+0x60>
        if(first_sleep == 0){
 3fe:	fe0898e3          	bnez	a7,3ee <thread_schedule+0x5c>
          all_thread[i].state = RUNNING;
 402:	4705                	li	a4,1
 404:	c398                	sw	a4,0(a5)
          next_thread = &all_thread[i];
 406:	75f9                	lui	a1,0xffffe
 408:	95be                	add	a1,a1,a5
          first_sleep = 1;
 40a:	88a6                	mv	a7,s1
 40c:	b7dd                	j	3f2 <thread_schedule+0x60>

      }
      }
    }
    else{
      printf("thread_schedule: no runnable threads\n");
 40e:	00001517          	auipc	a0,0x1
 412:	a2a50513          	addi	a0,a0,-1494 # e38 <malloc+0x206>
 416:	00000097          	auipc	ra,0x0
 41a:	764080e7          	jalr	1892(ra) # b7a <printf>
      exit(-1);
 41e:	557d                	li	a0,-1
 420:	00000097          	auipc	ra,0x0
 424:	3f2080e7          	jalr	1010(ra) # 812 <exit>
    }
  }

  if (current_thread != next_thread) {         /* switch threads?  */
 428:	00001517          	auipc	a0,0x1
 42c:	03853503          	ld	a0,56(a0) # 1460 <current_thread>
 430:	02b50263          	beq	a0,a1,454 <thread_schedule+0xc2>
    next_thread->state = RUNNING;
 434:	6789                	lui	a5,0x2
 436:	97ae                	add	a5,a5,a1
 438:	4705                	li	a4,1
 43a:	c398                	sw	a4,0(a5)
    t = current_thread;
    current_thread = next_thread;
 43c:	00001797          	auipc	a5,0x1
 440:	02b7b223          	sd	a1,36(a5) # 1460 <current_thread>
    thread_switch(&t->context, &current_thread->context);
 444:	6789                	lui	a5,0x2
 446:	07a1                	addi	a5,a5,8 # 2008 <__global_pointer$+0x3c4>
 448:	95be                	add	a1,a1,a5
 44a:	953e                	add	a0,a0,a5
 44c:	00000097          	auipc	ra,0x0
 450:	0d6080e7          	jalr	214(ra) # 522 <thread_switch>
  } else
    next_thread = 0;
}
 454:	60e2                	ld	ra,24(sp)
 456:	6442                	ld	s0,16(sp)
 458:	64a2                	ld	s1,8(sp)
 45a:	6105                	addi	sp,sp,32
 45c:	8082                	ret
    if (sleeping_thread == 1){
 45e:	d8c5                	beqz	s1,40e <thread_schedule+0x7c>
      printf("only thread sleepings, wake them all\n");
 460:	00001517          	auipc	a0,0x1
 464:	9b050513          	addi	a0,a0,-1616 # e10 <malloc+0x1de>
 468:	00000097          	auipc	ra,0x0
 46c:	712080e7          	jalr	1810(ra) # b7a <printf>
      for(int i = 0; i < MAX_THREAD; i++){ 
 470:	00003797          	auipc	a5,0x3
 474:	00078793          	mv	a5,a5
 478:	0000b817          	auipc	a6,0xb
 47c:	1d880813          	addi	a6,a6,472 # b650 <__BSS_END__+0x1ff0>
      int first_sleep = 0;
 480:	4881                	li	a7,0
      printf("only thread sleepings, wake them all\n");
 482:	4581                	li	a1,0
        if(all_thread[i].state == SLEEPING){
 484:	450d                	li	a0,3
      for(int i = 0; i < MAX_THREAD; i++){ 
 486:	6689                	lui	a3,0x2
 488:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x434>
 48c:	b7b5                	j	3f8 <thread_schedule+0x66>

000000000000048e <thread_sleep>:
{
 48e:	1141                	addi	sp,sp,-16
 490:	e406                	sd	ra,8(sp)
 492:	e022                	sd	s0,0(sp)
 494:	0800                	addi	s0,sp,16
  current_thread->state = SLEEPING;
 496:	00001797          	auipc	a5,0x1
 49a:	fca7b783          	ld	a5,-54(a5) # 1460 <current_thread>
 49e:	6709                	lui	a4,0x2
 4a0:	97ba                	add	a5,a5,a4
 4a2:	470d                	li	a4,3
 4a4:	c398                	sw	a4,0(a5)
  thread_schedule();
 4a6:	00000097          	auipc	ra,0x0
 4aa:	eec080e7          	jalr	-276(ra) # 392 <thread_schedule>
}
 4ae:	60a2                	ld	ra,8(sp)
 4b0:	6402                	ld	s0,0(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <thread_create>:

void 
thread_create(void (*func)())
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4bc:	00001797          	auipc	a5,0x1
 4c0:	fb478793          	addi	a5,a5,-76 # 1470 <all_thread>
    if (t->state == FREE) break;
 4c4:	6609                	lui	a2,0x2
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4c6:	6689                	lui	a3,0x2
 4c8:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x434>
 4cc:	00009597          	auipc	a1,0x9
 4d0:	18458593          	addi	a1,a1,388 # 9650 <base>
    if (t->state == FREE) break;
 4d4:	00c78733          	add	a4,a5,a2
 4d8:	4318                	lw	a4,0(a4)
 4da:	c701                	beqz	a4,4e2 <thread_create+0x2c>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4dc:	97b6                	add	a5,a5,a3
 4de:	feb79be3          	bne	a5,a1,4d4 <thread_create+0x1e>
  }
  t->state = RUNNABLE;
 4e2:	6709                	lui	a4,0x2
 4e4:	00e786b3          	add	a3,a5,a4
 4e8:	4609                	li	a2,2
 4ea:	c290                	sw	a2,0(a3)
  t->context.sp = (uint64)&t->stack[STACK_SIZE-1];
 4ec:	177d                	addi	a4,a4,-1 # 1fff <__global_pointer$+0x3bb>
 4ee:	97ba                	add	a5,a5,a4
 4f0:	ea9c                	sd	a5,16(a3)
  t->context.ra = (uint64)(*func);
 4f2:	e688                	sd	a0,8(a3)
}
 4f4:	6422                	ld	s0,8(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret

00000000000004fa <thread_yield>:

void 
thread_yield(void)
{
 4fa:	1141                	addi	sp,sp,-16
 4fc:	e406                	sd	ra,8(sp)
 4fe:	e022                	sd	s0,0(sp)
 500:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
 502:	00001797          	auipc	a5,0x1
 506:	f5e7b783          	ld	a5,-162(a5) # 1460 <current_thread>
 50a:	6709                	lui	a4,0x2
 50c:	97ba                	add	a5,a5,a4
 50e:	4709                	li	a4,2
 510:	c398                	sw	a4,0(a5)
  thread_schedule();
 512:	00000097          	auipc	ra,0x0
 516:	e80080e7          	jalr	-384(ra) # 392 <thread_schedule>
}
 51a:	60a2                	ld	ra,8(sp)
 51c:	6402                	ld	s0,0(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret

0000000000000522 <thread_switch>:
         */

	.globl thread_switch
thread_switch:
	# Save old thread context (a0 = old, a1 = new).
	sd ra, 0(a0)
 522:	00153023          	sd	ra,0(a0)
	sd sp, 8(a0)
 526:	00253423          	sd	sp,8(a0)
	sd s0, 16(a0)
 52a:	e900                	sd	s0,16(a0)
	sd s1, 24(a0)
 52c:	ed04                	sd	s1,24(a0)
	sd s2, 32(a0)
 52e:	03253023          	sd	s2,32(a0)
	sd s3, 40(a0)
 532:	03353423          	sd	s3,40(a0)
	sd s4, 48(a0)
 536:	03453823          	sd	s4,48(a0)
	sd s5, 56(a0)
 53a:	03553c23          	sd	s5,56(a0)
	sd s6, 64(a0)
 53e:	05653023          	sd	s6,64(a0)
	sd s7, 72(a0)
 542:	05753423          	sd	s7,72(a0)
	sd s8, 80(a0)
 546:	05853823          	sd	s8,80(a0)
	sd s9, 88(a0)
 54a:	05953c23          	sd	s9,88(a0)
	sd s10, 96(a0)
 54e:	07a53023          	sd	s10,96(a0)
	sd s11, 104(a0)
 552:	07b53423          	sd	s11,104(a0)

	# Restore new thread context.
	ld ra, 0(a1)
 556:	0005b083          	ld	ra,0(a1)
	ld sp, 8(a1)
 55a:	0085b103          	ld	sp,8(a1)
	ld s0, 16(a1)
 55e:	6980                	ld	s0,16(a1)
	ld s1, 24(a1)
 560:	6d84                	ld	s1,24(a1)
	ld s2, 32(a1)
 562:	0205b903          	ld	s2,32(a1)
	ld s3, 40(a1)
 566:	0285b983          	ld	s3,40(a1)
	ld s4, 48(a1)
 56a:	0305ba03          	ld	s4,48(a1)
	ld s5, 56(a1)
 56e:	0385ba83          	ld	s5,56(a1)
	ld s6, 64(a1)
 572:	0405bb03          	ld	s6,64(a1)
	ld s7, 72(a1)
 576:	0485bb83          	ld	s7,72(a1)
	ld s8, 80(a1)
 57a:	0505bc03          	ld	s8,80(a1)
	ld s9, 88(a1)
 57e:	0585bc83          	ld	s9,88(a1)
	ld s10, 96(a1)
 582:	0605bd03          	ld	s10,96(a1)
	ld s11, 104(a1)
 586:	0685bd83          	ld	s11,104(a1)
	ret    /* return to ra */
 58a:	8082                	ret

000000000000058c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 58c:	1141                	addi	sp,sp,-16
 58e:	e406                	sd	ra,8(sp)
 590:	e022                	sd	s0,0(sp)
 592:	0800                	addi	s0,sp,16
  extern int main();
  main();
 594:	00000097          	auipc	ra,0x0
 598:	cee080e7          	jalr	-786(ra) # 282 <main>
  exit(0);
 59c:	4501                	li	a0,0
 59e:	00000097          	auipc	ra,0x0
 5a2:	274080e7          	jalr	628(ra) # 812 <exit>

00000000000005a6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 5a6:	1141                	addi	sp,sp,-16
 5a8:	e422                	sd	s0,8(sp)
 5aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5ac:	87aa                	mv	a5,a0
 5ae:	0585                	addi	a1,a1,1
 5b0:	0785                	addi	a5,a5,1
 5b2:	fff5c703          	lbu	a4,-1(a1)
 5b6:	fee78fa3          	sb	a4,-1(a5)
 5ba:	fb75                	bnez	a4,5ae <strcpy+0x8>
    ;
  return os;
}
 5bc:	6422                	ld	s0,8(sp)
 5be:	0141                	addi	sp,sp,16
 5c0:	8082                	ret

00000000000005c2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5c2:	1141                	addi	sp,sp,-16
 5c4:	e422                	sd	s0,8(sp)
 5c6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 5c8:	00054783          	lbu	a5,0(a0)
 5cc:	cb91                	beqz	a5,5e0 <strcmp+0x1e>
 5ce:	0005c703          	lbu	a4,0(a1)
 5d2:	00f71763          	bne	a4,a5,5e0 <strcmp+0x1e>
    p++, q++;
 5d6:	0505                	addi	a0,a0,1
 5d8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5da:	00054783          	lbu	a5,0(a0)
 5de:	fbe5                	bnez	a5,5ce <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5e0:	0005c503          	lbu	a0,0(a1)
}
 5e4:	40a7853b          	subw	a0,a5,a0
 5e8:	6422                	ld	s0,8(sp)
 5ea:	0141                	addi	sp,sp,16
 5ec:	8082                	ret

00000000000005ee <strlen>:

uint
strlen(const char *s)
{
 5ee:	1141                	addi	sp,sp,-16
 5f0:	e422                	sd	s0,8(sp)
 5f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5f4:	00054783          	lbu	a5,0(a0)
 5f8:	cf91                	beqz	a5,614 <strlen+0x26>
 5fa:	0505                	addi	a0,a0,1
 5fc:	87aa                	mv	a5,a0
 5fe:	86be                	mv	a3,a5
 600:	0785                	addi	a5,a5,1
 602:	fff7c703          	lbu	a4,-1(a5)
 606:	ff65                	bnez	a4,5fe <strlen+0x10>
 608:	40a6853b          	subw	a0,a3,a0
 60c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 60e:	6422                	ld	s0,8(sp)
 610:	0141                	addi	sp,sp,16
 612:	8082                	ret
  for(n = 0; s[n]; n++)
 614:	4501                	li	a0,0
 616:	bfe5                	j	60e <strlen+0x20>

0000000000000618 <memset>:

void*
memset(void *dst, int c, uint n)
{
 618:	1141                	addi	sp,sp,-16
 61a:	e422                	sd	s0,8(sp)
 61c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 61e:	ca19                	beqz	a2,634 <memset+0x1c>
 620:	87aa                	mv	a5,a0
 622:	1602                	slli	a2,a2,0x20
 624:	9201                	srli	a2,a2,0x20
 626:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 62a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 62e:	0785                	addi	a5,a5,1
 630:	fee79de3          	bne	a5,a4,62a <memset+0x12>
  }
  return dst;
}
 634:	6422                	ld	s0,8(sp)
 636:	0141                	addi	sp,sp,16
 638:	8082                	ret

000000000000063a <strchr>:

char*
strchr(const char *s, char c)
{
 63a:	1141                	addi	sp,sp,-16
 63c:	e422                	sd	s0,8(sp)
 63e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 640:	00054783          	lbu	a5,0(a0)
 644:	cb99                	beqz	a5,65a <strchr+0x20>
    if(*s == c)
 646:	00f58763          	beq	a1,a5,654 <strchr+0x1a>
  for(; *s; s++)
 64a:	0505                	addi	a0,a0,1
 64c:	00054783          	lbu	a5,0(a0)
 650:	fbfd                	bnez	a5,646 <strchr+0xc>
      return (char*)s;
  return 0;
 652:	4501                	li	a0,0
}
 654:	6422                	ld	s0,8(sp)
 656:	0141                	addi	sp,sp,16
 658:	8082                	ret
  return 0;
 65a:	4501                	li	a0,0
 65c:	bfe5                	j	654 <strchr+0x1a>

000000000000065e <gets>:

char*
gets(char *buf, int max)
{
 65e:	711d                	addi	sp,sp,-96
 660:	ec86                	sd	ra,88(sp)
 662:	e8a2                	sd	s0,80(sp)
 664:	e4a6                	sd	s1,72(sp)
 666:	e0ca                	sd	s2,64(sp)
 668:	fc4e                	sd	s3,56(sp)
 66a:	f852                	sd	s4,48(sp)
 66c:	f456                	sd	s5,40(sp)
 66e:	f05a                	sd	s6,32(sp)
 670:	ec5e                	sd	s7,24(sp)
 672:	1080                	addi	s0,sp,96
 674:	8baa                	mv	s7,a0
 676:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 678:	892a                	mv	s2,a0
 67a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 67c:	4aa9                	li	s5,10
 67e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 680:	89a6                	mv	s3,s1
 682:	2485                	addiw	s1,s1,1
 684:	0344d863          	bge	s1,s4,6b4 <gets+0x56>
    cc = read(0, &c, 1);
 688:	4605                	li	a2,1
 68a:	faf40593          	addi	a1,s0,-81
 68e:	4501                	li	a0,0
 690:	00000097          	auipc	ra,0x0
 694:	19a080e7          	jalr	410(ra) # 82a <read>
    if(cc < 1)
 698:	00a05e63          	blez	a0,6b4 <gets+0x56>
    buf[i++] = c;
 69c:	faf44783          	lbu	a5,-81(s0)
 6a0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 6a4:	01578763          	beq	a5,s5,6b2 <gets+0x54>
 6a8:	0905                	addi	s2,s2,1
 6aa:	fd679be3          	bne	a5,s6,680 <gets+0x22>
    buf[i++] = c;
 6ae:	89a6                	mv	s3,s1
 6b0:	a011                	j	6b4 <gets+0x56>
 6b2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6b4:	99de                	add	s3,s3,s7
 6b6:	00098023          	sb	zero,0(s3)
  return buf;
}
 6ba:	855e                	mv	a0,s7
 6bc:	60e6                	ld	ra,88(sp)
 6be:	6446                	ld	s0,80(sp)
 6c0:	64a6                	ld	s1,72(sp)
 6c2:	6906                	ld	s2,64(sp)
 6c4:	79e2                	ld	s3,56(sp)
 6c6:	7a42                	ld	s4,48(sp)
 6c8:	7aa2                	ld	s5,40(sp)
 6ca:	7b02                	ld	s6,32(sp)
 6cc:	6be2                	ld	s7,24(sp)
 6ce:	6125                	addi	sp,sp,96
 6d0:	8082                	ret

00000000000006d2 <stat>:

int
stat(const char *n, struct stat *st)
{
 6d2:	1101                	addi	sp,sp,-32
 6d4:	ec06                	sd	ra,24(sp)
 6d6:	e822                	sd	s0,16(sp)
 6d8:	e04a                	sd	s2,0(sp)
 6da:	1000                	addi	s0,sp,32
 6dc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6de:	4581                	li	a1,0
 6e0:	00000097          	auipc	ra,0x0
 6e4:	172080e7          	jalr	370(ra) # 852 <open>
  if(fd < 0)
 6e8:	02054663          	bltz	a0,714 <stat+0x42>
 6ec:	e426                	sd	s1,8(sp)
 6ee:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6f0:	85ca                	mv	a1,s2
 6f2:	00000097          	auipc	ra,0x0
 6f6:	178080e7          	jalr	376(ra) # 86a <fstat>
 6fa:	892a                	mv	s2,a0
  close(fd);
 6fc:	8526                	mv	a0,s1
 6fe:	00000097          	auipc	ra,0x0
 702:	13c080e7          	jalr	316(ra) # 83a <close>
  return r;
 706:	64a2                	ld	s1,8(sp)
}
 708:	854a                	mv	a0,s2
 70a:	60e2                	ld	ra,24(sp)
 70c:	6442                	ld	s0,16(sp)
 70e:	6902                	ld	s2,0(sp)
 710:	6105                	addi	sp,sp,32
 712:	8082                	ret
    return -1;
 714:	597d                	li	s2,-1
 716:	bfcd                	j	708 <stat+0x36>

0000000000000718 <atoi>:

int
atoi(const char *s)
{
 718:	1141                	addi	sp,sp,-16
 71a:	e422                	sd	s0,8(sp)
 71c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 71e:	00054683          	lbu	a3,0(a0)
 722:	fd06879b          	addiw	a5,a3,-48
 726:	0ff7f793          	zext.b	a5,a5
 72a:	4625                	li	a2,9
 72c:	02f66863          	bltu	a2,a5,75c <atoi+0x44>
 730:	872a                	mv	a4,a0
  n = 0;
 732:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 734:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0x3bd>
 736:	0025179b          	slliw	a5,a0,0x2
 73a:	9fa9                	addw	a5,a5,a0
 73c:	0017979b          	slliw	a5,a5,0x1
 740:	9fb5                	addw	a5,a5,a3
 742:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 746:	00074683          	lbu	a3,0(a4)
 74a:	fd06879b          	addiw	a5,a3,-48
 74e:	0ff7f793          	zext.b	a5,a5
 752:	fef671e3          	bgeu	a2,a5,734 <atoi+0x1c>
  return n;
}
 756:	6422                	ld	s0,8(sp)
 758:	0141                	addi	sp,sp,16
 75a:	8082                	ret
  n = 0;
 75c:	4501                	li	a0,0
 75e:	bfe5                	j	756 <atoi+0x3e>

0000000000000760 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 760:	1141                	addi	sp,sp,-16
 762:	e422                	sd	s0,8(sp)
 764:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 766:	02b57463          	bgeu	a0,a1,78e <memmove+0x2e>
    while(n-- > 0)
 76a:	00c05f63          	blez	a2,788 <memmove+0x28>
 76e:	1602                	slli	a2,a2,0x20
 770:	9201                	srli	a2,a2,0x20
 772:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 776:	872a                	mv	a4,a0
      *dst++ = *src++;
 778:	0585                	addi	a1,a1,1
 77a:	0705                	addi	a4,a4,1
 77c:	fff5c683          	lbu	a3,-1(a1)
 780:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 784:	fef71ae3          	bne	a4,a5,778 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 788:	6422                	ld	s0,8(sp)
 78a:	0141                	addi	sp,sp,16
 78c:	8082                	ret
    dst += n;
 78e:	00c50733          	add	a4,a0,a2
    src += n;
 792:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 794:	fec05ae3          	blez	a2,788 <memmove+0x28>
 798:	fff6079b          	addiw	a5,a2,-1 # 1fff <__global_pointer$+0x3bb>
 79c:	1782                	slli	a5,a5,0x20
 79e:	9381                	srli	a5,a5,0x20
 7a0:	fff7c793          	not	a5,a5
 7a4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7a6:	15fd                	addi	a1,a1,-1
 7a8:	177d                	addi	a4,a4,-1
 7aa:	0005c683          	lbu	a3,0(a1)
 7ae:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 7b2:	fee79ae3          	bne	a5,a4,7a6 <memmove+0x46>
 7b6:	bfc9                	j	788 <memmove+0x28>

00000000000007b8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e422                	sd	s0,8(sp)
 7bc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 7be:	ca05                	beqz	a2,7ee <memcmp+0x36>
 7c0:	fff6069b          	addiw	a3,a2,-1
 7c4:	1682                	slli	a3,a3,0x20
 7c6:	9281                	srli	a3,a3,0x20
 7c8:	0685                	addi	a3,a3,1
 7ca:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7cc:	00054783          	lbu	a5,0(a0)
 7d0:	0005c703          	lbu	a4,0(a1)
 7d4:	00e79863          	bne	a5,a4,7e4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7d8:	0505                	addi	a0,a0,1
    p2++;
 7da:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7dc:	fed518e3          	bne	a0,a3,7cc <memcmp+0x14>
  }
  return 0;
 7e0:	4501                	li	a0,0
 7e2:	a019                	j	7e8 <memcmp+0x30>
      return *p1 - *p2;
 7e4:	40e7853b          	subw	a0,a5,a4
}
 7e8:	6422                	ld	s0,8(sp)
 7ea:	0141                	addi	sp,sp,16
 7ec:	8082                	ret
  return 0;
 7ee:	4501                	li	a0,0
 7f0:	bfe5                	j	7e8 <memcmp+0x30>

00000000000007f2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7f2:	1141                	addi	sp,sp,-16
 7f4:	e406                	sd	ra,8(sp)
 7f6:	e022                	sd	s0,0(sp)
 7f8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7fa:	00000097          	auipc	ra,0x0
 7fe:	f66080e7          	jalr	-154(ra) # 760 <memmove>
}
 802:	60a2                	ld	ra,8(sp)
 804:	6402                	ld	s0,0(sp)
 806:	0141                	addi	sp,sp,16
 808:	8082                	ret

000000000000080a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 80a:	4885                	li	a7,1
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <exit>:
.global exit
exit:
 li a7, SYS_exit
 812:	4889                	li	a7,2
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <wait>:
.global wait
wait:
 li a7, SYS_wait
 81a:	488d                	li	a7,3
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 822:	4891                	li	a7,4
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <read>:
.global read
read:
 li a7, SYS_read
 82a:	4895                	li	a7,5
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <write>:
.global write
write:
 li a7, SYS_write
 832:	48c1                	li	a7,16
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <close>:
.global close
close:
 li a7, SYS_close
 83a:	48d5                	li	a7,21
 ecall
 83c:	00000073          	ecall
 ret
 840:	8082                	ret

0000000000000842 <kill>:
.global kill
kill:
 li a7, SYS_kill
 842:	4899                	li	a7,6
 ecall
 844:	00000073          	ecall
 ret
 848:	8082                	ret

000000000000084a <exec>:
.global exec
exec:
 li a7, SYS_exec
 84a:	489d                	li	a7,7
 ecall
 84c:	00000073          	ecall
 ret
 850:	8082                	ret

0000000000000852 <open>:
.global open
open:
 li a7, SYS_open
 852:	48bd                	li	a7,15
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 85a:	48c5                	li	a7,17
 ecall
 85c:	00000073          	ecall
 ret
 860:	8082                	ret

0000000000000862 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 862:	48c9                	li	a7,18
 ecall
 864:	00000073          	ecall
 ret
 868:	8082                	ret

000000000000086a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 86a:	48a1                	li	a7,8
 ecall
 86c:	00000073          	ecall
 ret
 870:	8082                	ret

0000000000000872 <link>:
.global link
link:
 li a7, SYS_link
 872:	48cd                	li	a7,19
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 87a:	48d1                	li	a7,20
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 882:	48a5                	li	a7,9
 ecall
 884:	00000073          	ecall
 ret
 888:	8082                	ret

000000000000088a <dup>:
.global dup
dup:
 li a7, SYS_dup
 88a:	48a9                	li	a7,10
 ecall
 88c:	00000073          	ecall
 ret
 890:	8082                	ret

0000000000000892 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 892:	48ad                	li	a7,11
 ecall
 894:	00000073          	ecall
 ret
 898:	8082                	ret

000000000000089a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 89a:	48b1                	li	a7,12
 ecall
 89c:	00000073          	ecall
 ret
 8a0:	8082                	ret

00000000000008a2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8a2:	48b5                	li	a7,13
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8aa:	48b9                	li	a7,14
 ecall
 8ac:	00000073          	ecall
 ret
 8b0:	8082                	ret

00000000000008b2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8b2:	1101                	addi	sp,sp,-32
 8b4:	ec06                	sd	ra,24(sp)
 8b6:	e822                	sd	s0,16(sp)
 8b8:	1000                	addi	s0,sp,32
 8ba:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8be:	4605                	li	a2,1
 8c0:	fef40593          	addi	a1,s0,-17
 8c4:	00000097          	auipc	ra,0x0
 8c8:	f6e080e7          	jalr	-146(ra) # 832 <write>
}
 8cc:	60e2                	ld	ra,24(sp)
 8ce:	6442                	ld	s0,16(sp)
 8d0:	6105                	addi	sp,sp,32
 8d2:	8082                	ret

00000000000008d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8d4:	7139                	addi	sp,sp,-64
 8d6:	fc06                	sd	ra,56(sp)
 8d8:	f822                	sd	s0,48(sp)
 8da:	f426                	sd	s1,40(sp)
 8dc:	0080                	addi	s0,sp,64
 8de:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8e0:	c299                	beqz	a3,8e6 <printint+0x12>
 8e2:	0805cb63          	bltz	a1,978 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8e6:	2581                	sext.w	a1,a1
  neg = 0;
 8e8:	4881                	li	a7,0
 8ea:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8ee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8f0:	2601                	sext.w	a2,a2
 8f2:	00000517          	auipc	a0,0x0
 8f6:	5ce50513          	addi	a0,a0,1486 # ec0 <digits>
 8fa:	883a                	mv	a6,a4
 8fc:	2705                	addiw	a4,a4,1
 8fe:	02c5f7bb          	remuw	a5,a1,a2
 902:	1782                	slli	a5,a5,0x20
 904:	9381                	srli	a5,a5,0x20
 906:	97aa                	add	a5,a5,a0
 908:	0007c783          	lbu	a5,0(a5)
 90c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 910:	0005879b          	sext.w	a5,a1
 914:	02c5d5bb          	divuw	a1,a1,a2
 918:	0685                	addi	a3,a3,1
 91a:	fec7f0e3          	bgeu	a5,a2,8fa <printint+0x26>
  if(neg)
 91e:	00088c63          	beqz	a7,936 <printint+0x62>
    buf[i++] = '-';
 922:	fd070793          	addi	a5,a4,-48
 926:	00878733          	add	a4,a5,s0
 92a:	02d00793          	li	a5,45
 92e:	fef70823          	sb	a5,-16(a4)
 932:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 936:	02e05c63          	blez	a4,96e <printint+0x9a>
 93a:	f04a                	sd	s2,32(sp)
 93c:	ec4e                	sd	s3,24(sp)
 93e:	fc040793          	addi	a5,s0,-64
 942:	00e78933          	add	s2,a5,a4
 946:	fff78993          	addi	s3,a5,-1
 94a:	99ba                	add	s3,s3,a4
 94c:	377d                	addiw	a4,a4,-1
 94e:	1702                	slli	a4,a4,0x20
 950:	9301                	srli	a4,a4,0x20
 952:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 956:	fff94583          	lbu	a1,-1(s2)
 95a:	8526                	mv	a0,s1
 95c:	00000097          	auipc	ra,0x0
 960:	f56080e7          	jalr	-170(ra) # 8b2 <putc>
  while(--i >= 0)
 964:	197d                	addi	s2,s2,-1
 966:	ff3918e3          	bne	s2,s3,956 <printint+0x82>
 96a:	7902                	ld	s2,32(sp)
 96c:	69e2                	ld	s3,24(sp)
}
 96e:	70e2                	ld	ra,56(sp)
 970:	7442                	ld	s0,48(sp)
 972:	74a2                	ld	s1,40(sp)
 974:	6121                	addi	sp,sp,64
 976:	8082                	ret
    x = -xx;
 978:	40b005bb          	negw	a1,a1
    neg = 1;
 97c:	4885                	li	a7,1
    x = -xx;
 97e:	b7b5                	j	8ea <printint+0x16>

0000000000000980 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 980:	715d                	addi	sp,sp,-80
 982:	e486                	sd	ra,72(sp)
 984:	e0a2                	sd	s0,64(sp)
 986:	f84a                	sd	s2,48(sp)
 988:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 98a:	0005c903          	lbu	s2,0(a1)
 98e:	1a090a63          	beqz	s2,b42 <vprintf+0x1c2>
 992:	fc26                	sd	s1,56(sp)
 994:	f44e                	sd	s3,40(sp)
 996:	f052                	sd	s4,32(sp)
 998:	ec56                	sd	s5,24(sp)
 99a:	e85a                	sd	s6,16(sp)
 99c:	e45e                	sd	s7,8(sp)
 99e:	8aaa                	mv	s5,a0
 9a0:	8bb2                	mv	s7,a2
 9a2:	00158493          	addi	s1,a1,1
  state = 0;
 9a6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9a8:	02500a13          	li	s4,37
 9ac:	4b55                	li	s6,21
 9ae:	a839                	j	9cc <vprintf+0x4c>
        putc(fd, c);
 9b0:	85ca                	mv	a1,s2
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	efe080e7          	jalr	-258(ra) # 8b2 <putc>
 9bc:	a019                	j	9c2 <vprintf+0x42>
    } else if(state == '%'){
 9be:	01498d63          	beq	s3,s4,9d8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 9c2:	0485                	addi	s1,s1,1
 9c4:	fff4c903          	lbu	s2,-1(s1)
 9c8:	16090763          	beqz	s2,b36 <vprintf+0x1b6>
    if(state == 0){
 9cc:	fe0999e3          	bnez	s3,9be <vprintf+0x3e>
      if(c == '%'){
 9d0:	ff4910e3          	bne	s2,s4,9b0 <vprintf+0x30>
        state = '%';
 9d4:	89d2                	mv	s3,s4
 9d6:	b7f5                	j	9c2 <vprintf+0x42>
      if(c == 'd'){
 9d8:	13490463          	beq	s2,s4,b00 <vprintf+0x180>
 9dc:	f9d9079b          	addiw	a5,s2,-99
 9e0:	0ff7f793          	zext.b	a5,a5
 9e4:	12fb6763          	bltu	s6,a5,b12 <vprintf+0x192>
 9e8:	f9d9079b          	addiw	a5,s2,-99
 9ec:	0ff7f713          	zext.b	a4,a5
 9f0:	12eb6163          	bltu	s6,a4,b12 <vprintf+0x192>
 9f4:	00271793          	slli	a5,a4,0x2
 9f8:	00000717          	auipc	a4,0x0
 9fc:	47070713          	addi	a4,a4,1136 # e68 <malloc+0x236>
 a00:	97ba                	add	a5,a5,a4
 a02:	439c                	lw	a5,0(a5)
 a04:	97ba                	add	a5,a5,a4
 a06:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a08:	008b8913          	addi	s2,s7,8
 a0c:	4685                	li	a3,1
 a0e:	4629                	li	a2,10
 a10:	000ba583          	lw	a1,0(s7)
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	ebe080e7          	jalr	-322(ra) # 8d4 <printint>
 a1e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a20:	4981                	li	s3,0
 a22:	b745                	j	9c2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a24:	008b8913          	addi	s2,s7,8
 a28:	4681                	li	a3,0
 a2a:	4629                	li	a2,10
 a2c:	000ba583          	lw	a1,0(s7)
 a30:	8556                	mv	a0,s5
 a32:	00000097          	auipc	ra,0x0
 a36:	ea2080e7          	jalr	-350(ra) # 8d4 <printint>
 a3a:	8bca                	mv	s7,s2
      state = 0;
 a3c:	4981                	li	s3,0
 a3e:	b751                	j	9c2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 a40:	008b8913          	addi	s2,s7,8
 a44:	4681                	li	a3,0
 a46:	4641                	li	a2,16
 a48:	000ba583          	lw	a1,0(s7)
 a4c:	8556                	mv	a0,s5
 a4e:	00000097          	auipc	ra,0x0
 a52:	e86080e7          	jalr	-378(ra) # 8d4 <printint>
 a56:	8bca                	mv	s7,s2
      state = 0;
 a58:	4981                	li	s3,0
 a5a:	b7a5                	j	9c2 <vprintf+0x42>
 a5c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a5e:	008b8c13          	addi	s8,s7,8
 a62:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a66:	03000593          	li	a1,48
 a6a:	8556                	mv	a0,s5
 a6c:	00000097          	auipc	ra,0x0
 a70:	e46080e7          	jalr	-442(ra) # 8b2 <putc>
  putc(fd, 'x');
 a74:	07800593          	li	a1,120
 a78:	8556                	mv	a0,s5
 a7a:	00000097          	auipc	ra,0x0
 a7e:	e38080e7          	jalr	-456(ra) # 8b2 <putc>
 a82:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a84:	00000b97          	auipc	s7,0x0
 a88:	43cb8b93          	addi	s7,s7,1084 # ec0 <digits>
 a8c:	03c9d793          	srli	a5,s3,0x3c
 a90:	97de                	add	a5,a5,s7
 a92:	0007c583          	lbu	a1,0(a5)
 a96:	8556                	mv	a0,s5
 a98:	00000097          	auipc	ra,0x0
 a9c:	e1a080e7          	jalr	-486(ra) # 8b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aa0:	0992                	slli	s3,s3,0x4
 aa2:	397d                	addiw	s2,s2,-1
 aa4:	fe0914e3          	bnez	s2,a8c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 aa8:	8be2                	mv	s7,s8
      state = 0;
 aaa:	4981                	li	s3,0
 aac:	6c02                	ld	s8,0(sp)
 aae:	bf11                	j	9c2 <vprintf+0x42>
        s = va_arg(ap, char*);
 ab0:	008b8993          	addi	s3,s7,8
 ab4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 ab8:	02090163          	beqz	s2,ada <vprintf+0x15a>
        while(*s != 0){
 abc:	00094583          	lbu	a1,0(s2)
 ac0:	c9a5                	beqz	a1,b30 <vprintf+0x1b0>
          putc(fd, *s);
 ac2:	8556                	mv	a0,s5
 ac4:	00000097          	auipc	ra,0x0
 ac8:	dee080e7          	jalr	-530(ra) # 8b2 <putc>
          s++;
 acc:	0905                	addi	s2,s2,1
        while(*s != 0){
 ace:	00094583          	lbu	a1,0(s2)
 ad2:	f9e5                	bnez	a1,ac2 <vprintf+0x142>
        s = va_arg(ap, char*);
 ad4:	8bce                	mv	s7,s3
      state = 0;
 ad6:	4981                	li	s3,0
 ad8:	b5ed                	j	9c2 <vprintf+0x42>
          s = "(null)";
 ada:	00000917          	auipc	s2,0x0
 ade:	38690913          	addi	s2,s2,902 # e60 <malloc+0x22e>
        while(*s != 0){
 ae2:	02800593          	li	a1,40
 ae6:	bff1                	j	ac2 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 ae8:	008b8913          	addi	s2,s7,8
 aec:	000bc583          	lbu	a1,0(s7)
 af0:	8556                	mv	a0,s5
 af2:	00000097          	auipc	ra,0x0
 af6:	dc0080e7          	jalr	-576(ra) # 8b2 <putc>
 afa:	8bca                	mv	s7,s2
      state = 0;
 afc:	4981                	li	s3,0
 afe:	b5d1                	j	9c2 <vprintf+0x42>
        putc(fd, c);
 b00:	02500593          	li	a1,37
 b04:	8556                	mv	a0,s5
 b06:	00000097          	auipc	ra,0x0
 b0a:	dac080e7          	jalr	-596(ra) # 8b2 <putc>
      state = 0;
 b0e:	4981                	li	s3,0
 b10:	bd4d                	j	9c2 <vprintf+0x42>
        putc(fd, '%');
 b12:	02500593          	li	a1,37
 b16:	8556                	mv	a0,s5
 b18:	00000097          	auipc	ra,0x0
 b1c:	d9a080e7          	jalr	-614(ra) # 8b2 <putc>
        putc(fd, c);
 b20:	85ca                	mv	a1,s2
 b22:	8556                	mv	a0,s5
 b24:	00000097          	auipc	ra,0x0
 b28:	d8e080e7          	jalr	-626(ra) # 8b2 <putc>
      state = 0;
 b2c:	4981                	li	s3,0
 b2e:	bd51                	j	9c2 <vprintf+0x42>
        s = va_arg(ap, char*);
 b30:	8bce                	mv	s7,s3
      state = 0;
 b32:	4981                	li	s3,0
 b34:	b579                	j	9c2 <vprintf+0x42>
 b36:	74e2                	ld	s1,56(sp)
 b38:	79a2                	ld	s3,40(sp)
 b3a:	7a02                	ld	s4,32(sp)
 b3c:	6ae2                	ld	s5,24(sp)
 b3e:	6b42                	ld	s6,16(sp)
 b40:	6ba2                	ld	s7,8(sp)
    }
  }
}
 b42:	60a6                	ld	ra,72(sp)
 b44:	6406                	ld	s0,64(sp)
 b46:	7942                	ld	s2,48(sp)
 b48:	6161                	addi	sp,sp,80
 b4a:	8082                	ret

0000000000000b4c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b4c:	715d                	addi	sp,sp,-80
 b4e:	ec06                	sd	ra,24(sp)
 b50:	e822                	sd	s0,16(sp)
 b52:	1000                	addi	s0,sp,32
 b54:	e010                	sd	a2,0(s0)
 b56:	e414                	sd	a3,8(s0)
 b58:	e818                	sd	a4,16(s0)
 b5a:	ec1c                	sd	a5,24(s0)
 b5c:	03043023          	sd	a6,32(s0)
 b60:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b64:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b68:	8622                	mv	a2,s0
 b6a:	00000097          	auipc	ra,0x0
 b6e:	e16080e7          	jalr	-490(ra) # 980 <vprintf>
}
 b72:	60e2                	ld	ra,24(sp)
 b74:	6442                	ld	s0,16(sp)
 b76:	6161                	addi	sp,sp,80
 b78:	8082                	ret

0000000000000b7a <printf>:

void
printf(const char *fmt, ...)
{
 b7a:	711d                	addi	sp,sp,-96
 b7c:	ec06                	sd	ra,24(sp)
 b7e:	e822                	sd	s0,16(sp)
 b80:	1000                	addi	s0,sp,32
 b82:	e40c                	sd	a1,8(s0)
 b84:	e810                	sd	a2,16(s0)
 b86:	ec14                	sd	a3,24(s0)
 b88:	f018                	sd	a4,32(s0)
 b8a:	f41c                	sd	a5,40(s0)
 b8c:	03043823          	sd	a6,48(s0)
 b90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b94:	00840613          	addi	a2,s0,8
 b98:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b9c:	85aa                	mv	a1,a0
 b9e:	4505                	li	a0,1
 ba0:	00000097          	auipc	ra,0x0
 ba4:	de0080e7          	jalr	-544(ra) # 980 <vprintf>
}
 ba8:	60e2                	ld	ra,24(sp)
 baa:	6442                	ld	s0,16(sp)
 bac:	6125                	addi	sp,sp,96
 bae:	8082                	ret

0000000000000bb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bb0:	1141                	addi	sp,sp,-16
 bb2:	e422                	sd	s0,8(sp)
 bb4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bb6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bba:	00001797          	auipc	a5,0x1
 bbe:	8ae7b783          	ld	a5,-1874(a5) # 1468 <freep>
 bc2:	a02d                	j	bec <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bc4:	4618                	lw	a4,8(a2)
 bc6:	9f2d                	addw	a4,a4,a1
 bc8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bcc:	6398                	ld	a4,0(a5)
 bce:	6310                	ld	a2,0(a4)
 bd0:	a83d                	j	c0e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bd2:	ff852703          	lw	a4,-8(a0)
 bd6:	9f31                	addw	a4,a4,a2
 bd8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bda:	ff053683          	ld	a3,-16(a0)
 bde:	a091                	j	c22 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 be0:	6398                	ld	a4,0(a5)
 be2:	00e7e463          	bltu	a5,a4,bea <free+0x3a>
 be6:	00e6ea63          	bltu	a3,a4,bfa <free+0x4a>
{
 bea:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bec:	fed7fae3          	bgeu	a5,a3,be0 <free+0x30>
 bf0:	6398                	ld	a4,0(a5)
 bf2:	00e6e463          	bltu	a3,a4,bfa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bf6:	fee7eae3          	bltu	a5,a4,bea <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bfa:	ff852583          	lw	a1,-8(a0)
 bfe:	6390                	ld	a2,0(a5)
 c00:	02059813          	slli	a6,a1,0x20
 c04:	01c85713          	srli	a4,a6,0x1c
 c08:	9736                	add	a4,a4,a3
 c0a:	fae60de3          	beq	a2,a4,bc4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c0e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c12:	4790                	lw	a2,8(a5)
 c14:	02061593          	slli	a1,a2,0x20
 c18:	01c5d713          	srli	a4,a1,0x1c
 c1c:	973e                	add	a4,a4,a5
 c1e:	fae68ae3          	beq	a3,a4,bd2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 c22:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c24:	00001717          	auipc	a4,0x1
 c28:	84f73223          	sd	a5,-1980(a4) # 1468 <freep>
}
 c2c:	6422                	ld	s0,8(sp)
 c2e:	0141                	addi	sp,sp,16
 c30:	8082                	ret

0000000000000c32 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c32:	7139                	addi	sp,sp,-64
 c34:	fc06                	sd	ra,56(sp)
 c36:	f822                	sd	s0,48(sp)
 c38:	f426                	sd	s1,40(sp)
 c3a:	ec4e                	sd	s3,24(sp)
 c3c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c3e:	02051493          	slli	s1,a0,0x20
 c42:	9081                	srli	s1,s1,0x20
 c44:	04bd                	addi	s1,s1,15
 c46:	8091                	srli	s1,s1,0x4
 c48:	0014899b          	addiw	s3,s1,1
 c4c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c4e:	00001517          	auipc	a0,0x1
 c52:	81a53503          	ld	a0,-2022(a0) # 1468 <freep>
 c56:	c915                	beqz	a0,c8a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c5a:	4798                	lw	a4,8(a5)
 c5c:	08977e63          	bgeu	a4,s1,cf8 <malloc+0xc6>
 c60:	f04a                	sd	s2,32(sp)
 c62:	e852                	sd	s4,16(sp)
 c64:	e456                	sd	s5,8(sp)
 c66:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c68:	8a4e                	mv	s4,s3
 c6a:	0009871b          	sext.w	a4,s3
 c6e:	6685                	lui	a3,0x1
 c70:	00d77363          	bgeu	a4,a3,c76 <malloc+0x44>
 c74:	6a05                	lui	s4,0x1
 c76:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c7a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c7e:	00000917          	auipc	s2,0x0
 c82:	7ea90913          	addi	s2,s2,2026 # 1468 <freep>
  if(p == (char*)-1)
 c86:	5afd                	li	s5,-1
 c88:	a091                	j	ccc <malloc+0x9a>
 c8a:	f04a                	sd	s2,32(sp)
 c8c:	e852                	sd	s4,16(sp)
 c8e:	e456                	sd	s5,8(sp)
 c90:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c92:	00009797          	auipc	a5,0x9
 c96:	9be78793          	addi	a5,a5,-1602 # 9650 <base>
 c9a:	00000717          	auipc	a4,0x0
 c9e:	7cf73723          	sd	a5,1998(a4) # 1468 <freep>
 ca2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ca4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ca8:	b7c1                	j	c68 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 caa:	6398                	ld	a4,0(a5)
 cac:	e118                	sd	a4,0(a0)
 cae:	a08d                	j	d10 <malloc+0xde>
  hp->s.size = nu;
 cb0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cb4:	0541                	addi	a0,a0,16
 cb6:	00000097          	auipc	ra,0x0
 cba:	efa080e7          	jalr	-262(ra) # bb0 <free>
  return freep;
 cbe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cc2:	c13d                	beqz	a0,d28 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cc6:	4798                	lw	a4,8(a5)
 cc8:	02977463          	bgeu	a4,s1,cf0 <malloc+0xbe>
    if(p == freep)
 ccc:	00093703          	ld	a4,0(s2)
 cd0:	853e                	mv	a0,a5
 cd2:	fef719e3          	bne	a4,a5,cc4 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 cd6:	8552                	mv	a0,s4
 cd8:	00000097          	auipc	ra,0x0
 cdc:	bc2080e7          	jalr	-1086(ra) # 89a <sbrk>
  if(p == (char*)-1)
 ce0:	fd5518e3          	bne	a0,s5,cb0 <malloc+0x7e>
        return 0;
 ce4:	4501                	li	a0,0
 ce6:	7902                	ld	s2,32(sp)
 ce8:	6a42                	ld	s4,16(sp)
 cea:	6aa2                	ld	s5,8(sp)
 cec:	6b02                	ld	s6,0(sp)
 cee:	a03d                	j	d1c <malloc+0xea>
 cf0:	7902                	ld	s2,32(sp)
 cf2:	6a42                	ld	s4,16(sp)
 cf4:	6aa2                	ld	s5,8(sp)
 cf6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cf8:	fae489e3          	beq	s1,a4,caa <malloc+0x78>
        p->s.size -= nunits;
 cfc:	4137073b          	subw	a4,a4,s3
 d00:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d02:	02071693          	slli	a3,a4,0x20
 d06:	01c6d713          	srli	a4,a3,0x1c
 d0a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d0c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d10:	00000717          	auipc	a4,0x0
 d14:	74a73c23          	sd	a0,1880(a4) # 1468 <freep>
      return (void*)(p + 1);
 d18:	01078513          	addi	a0,a5,16
  }
}
 d1c:	70e2                	ld	ra,56(sp)
 d1e:	7442                	ld	s0,48(sp)
 d20:	74a2                	ld	s1,40(sp)
 d22:	69e2                	ld	s3,24(sp)
 d24:	6121                	addi	sp,sp,64
 d26:	8082                	ret
 d28:	7902                	ld	s2,32(sp)
 d2a:	6a42                	ld	s4,16(sp)
 d2c:	6aa2                	ld	s5,8(sp)
 d2e:	6b02                	ld	s6,0(sp)
 d30:	b7f5                	j	d1c <malloc+0xea>
