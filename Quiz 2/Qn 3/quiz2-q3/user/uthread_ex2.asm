
user/_uthread_ex2:     file format elf64-littleriscv


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
  14:	d3050513          	addi	a0,a0,-720 # d40 <malloc+0x106>
  18:	00001097          	auipc	ra,0x1
  1c:	b6a080e7          	jalr	-1174(ra) # b82 <printf>
  a_started = 1;
  20:	4785                	li	a5,1
  22:	00001717          	auipc	a4,0x1
  26:	44f72123          	sw	a5,1090(a4) # 1464 <a_started>
  while(b_started == 0 || c_started == 0)
  2a:	00001497          	auipc	s1,0x1
  2e:	43648493          	addi	s1,s1,1078 # 1460 <b_started>
  32:	00001917          	auipc	s2,0x1
  36:	42a90913          	addi	s2,s2,1066 # 145c <c_started>
  3a:	a029                	j	44 <thread_a+0x44>
    thread_yield();
  3c:	00000097          	auipc	ra,0x0
  40:	4c6080e7          	jalr	1222(ra) # 502 <thread_yield>
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
  58:	d04a0a13          	addi	s4,s4,-764 # d58 <malloc+0x11e>
    a_n += 1;
  5c:	00001917          	auipc	s2,0x1
  60:	3fc90913          	addi	s2,s2,1020 # 1458 <a_n>
  for (i = 0; i < 3; i++) {
  64:	498d                	li	s3,3
    printf("thread_a %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	8552                	mv	a0,s4
  6a:	00001097          	auipc	ra,0x1
  6e:	b18080e7          	jalr	-1256(ra) # b82 <printf>
    a_n += 1;
  72:	00092783          	lw	a5,0(s2)
  76:	2785                	addiw	a5,a5,1
  78:	00f92023          	sw	a5,0(s2)
    thread_yield();
  7c:	00000097          	auipc	ra,0x0
  80:	486080e7          	jalr	1158(ra) # 502 <thread_yield>
  for (i = 0; i < 3; i++) {
  84:	2485                	addiw	s1,s1,1
  86:	ff3490e3          	bne	s1,s3,66 <thread_a+0x66>
  }
  printf("thread_a: exit after %d\n", a_n);
  8a:	00001597          	auipc	a1,0x1
  8e:	3ce5a583          	lw	a1,974(a1) # 1458 <a_n>
  92:	00001517          	auipc	a0,0x1
  96:	cd650513          	addi	a0,a0,-810 # d68 <malloc+0x12e>
  9a:	00001097          	auipc	ra,0x1
  9e:	ae8080e7          	jalr	-1304(ra) # b82 <printf>
  thread_wakeup(2);
  a2:	4509                	li	a0,2
  a4:	00000097          	auipc	ra,0x0
  a8:	29e080e7          	jalr	670(ra) # 342 <thread_wakeup>
  current_thread->state = FREE;
  ac:	00001797          	auipc	a5,0x1
  b0:	3bc7b783          	ld	a5,956(a5) # 1468 <current_thread>
  b4:	6709                	lui	a4,0x2
  b6:	97ba                	add	a5,a5,a4
  b8:	0007a023          	sw	zero,0(a5)
  thread_schedule();
  bc:	00000097          	auipc	ra,0x0
  c0:	2de080e7          	jalr	734(ra) # 39a <thread_schedule>
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
  e8:	ca450513          	addi	a0,a0,-860 # d88 <malloc+0x14e>
  ec:	00001097          	auipc	ra,0x1
  f0:	a96080e7          	jalr	-1386(ra) # b82 <printf>
  b_started = 1;
  f4:	4785                	li	a5,1
  f6:	00001717          	auipc	a4,0x1
  fa:	36f72523          	sw	a5,874(a4) # 1460 <b_started>
  while(a_started == 0 || c_started == 0)
  fe:	00001497          	auipc	s1,0x1
 102:	36648493          	addi	s1,s1,870 # 1464 <a_started>
 106:	00001917          	auipc	s2,0x1
 10a:	35690913          	addi	s2,s2,854 # 145c <c_started>
 10e:	a029                	j	118 <thread_b+0x44>
    thread_yield();
 110:	00000097          	auipc	ra,0x0
 114:	3f2080e7          	jalr	1010(ra) # 502 <thread_yield>
  while(a_started == 0 || c_started == 0)
 118:	409c                	lw	a5,0(s1)
 11a:	2781                	sext.w	a5,a5
 11c:	dbf5                	beqz	a5,110 <thread_b+0x3c>
 11e:	00092783          	lw	a5,0(s2)
 122:	2781                	sext.w	a5,a5
 124:	d7f5                	beqz	a5,110 <thread_b+0x3c>
  
  thread_sleep();
 126:	00000097          	auipc	ra,0x0
 12a:	370080e7          	jalr	880(ra) # 496 <thread_sleep>
  for (i = 0; i < 3; i++) {
 12e:	4481                	li	s1,0
    printf("thread_b %d\n", i);
 130:	00001a17          	auipc	s4,0x1
 134:	c70a0a13          	addi	s4,s4,-912 # da0 <malloc+0x166>
    b_n += 1;
 138:	00001917          	auipc	s2,0x1
 13c:	31c90913          	addi	s2,s2,796 # 1454 <b_n>
  for (i = 0; i < 3; i++) {
 140:	498d                	li	s3,3
    printf("thread_b %d\n", i);
 142:	85a6                	mv	a1,s1
 144:	8552                	mv	a0,s4
 146:	00001097          	auipc	ra,0x1
 14a:	a3c080e7          	jalr	-1476(ra) # b82 <printf>
    b_n += 1;
 14e:	00092783          	lw	a5,0(s2)
 152:	2785                	addiw	a5,a5,1
 154:	00f92023          	sw	a5,0(s2)
    thread_yield();
 158:	00000097          	auipc	ra,0x0
 15c:	3aa080e7          	jalr	938(ra) # 502 <thread_yield>
  for (i = 0; i < 3; i++) {
 160:	2485                	addiw	s1,s1,1
 162:	ff3490e3          	bne	s1,s3,142 <thread_b+0x6e>
  }
  printf("thread_b: exit after %d\n", b_n);
 166:	00001597          	auipc	a1,0x1
 16a:	2ee5a583          	lw	a1,750(a1) # 1454 <b_n>
 16e:	00001517          	auipc	a0,0x1
 172:	c4250513          	addi	a0,a0,-958 # db0 <malloc+0x176>
 176:	00001097          	auipc	ra,0x1
 17a:	a0c080e7          	jalr	-1524(ra) # b82 <printf>
  thread_wakeup(3);
 17e:	450d                	li	a0,3
 180:	00000097          	auipc	ra,0x0
 184:	1c2080e7          	jalr	450(ra) # 342 <thread_wakeup>
  current_thread->state = FREE;
 188:	00001797          	auipc	a5,0x1
 18c:	2e07b783          	ld	a5,736(a5) # 1468 <current_thread>
 190:	6709                	lui	a4,0x2
 192:	97ba                	add	a5,a5,a4
 194:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 198:	00000097          	auipc	ra,0x0
 19c:	202080e7          	jalr	514(ra) # 39a <thread_schedule>
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
 1c4:	c1050513          	addi	a0,a0,-1008 # dd0 <malloc+0x196>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	9ba080e7          	jalr	-1606(ra) # b82 <printf>
  c_started = 1;
 1d0:	4785                	li	a5,1
 1d2:	00001717          	auipc	a4,0x1
 1d6:	28f72523          	sw	a5,650(a4) # 145c <c_started>
  while(a_started == 0 || b_started == 0)
 1da:	00001497          	auipc	s1,0x1
 1de:	28a48493          	addi	s1,s1,650 # 1464 <a_started>
 1e2:	00001917          	auipc	s2,0x1
 1e6:	27e90913          	addi	s2,s2,638 # 1460 <b_started>
 1ea:	a029                	j	1f4 <thread_c+0x44>
    thread_yield();
 1ec:	00000097          	auipc	ra,0x0
 1f0:	316080e7          	jalr	790(ra) # 502 <thread_yield>
  while(a_started == 0 || b_started == 0)
 1f4:	409c                	lw	a5,0(s1)
 1f6:	2781                	sext.w	a5,a5
 1f8:	dbf5                	beqz	a5,1ec <thread_c+0x3c>
 1fa:	00092783          	lw	a5,0(s2)
 1fe:	2781                	sext.w	a5,a5
 200:	d7f5                	beqz	a5,1ec <thread_c+0x3c>
  thread_sleep();
 202:	00000097          	auipc	ra,0x0
 206:	294080e7          	jalr	660(ra) # 496 <thread_sleep>
  for (i = 0; i < 3; i++) {
 20a:	4481                	li	s1,0
    printf("thread_c %d\n", i);
 20c:	00001a17          	auipc	s4,0x1
 210:	bdca0a13          	addi	s4,s4,-1060 # de8 <malloc+0x1ae>
    c_n += 1;
 214:	00001917          	auipc	s2,0x1
 218:	23c90913          	addi	s2,s2,572 # 1450 <c_n>
  for (i = 0; i < 3; i++) {
 21c:	498d                	li	s3,3
    printf("thread_c %d\n", i);
 21e:	85a6                	mv	a1,s1
 220:	8552                	mv	a0,s4
 222:	00001097          	auipc	ra,0x1
 226:	960080e7          	jalr	-1696(ra) # b82 <printf>
    c_n += 1;
 22a:	00092783          	lw	a5,0(s2)
 22e:	2785                	addiw	a5,a5,1
 230:	00f92023          	sw	a5,0(s2)
    thread_yield();
 234:	00000097          	auipc	ra,0x0
 238:	2ce080e7          	jalr	718(ra) # 502 <thread_yield>
  for (i = 0; i < 3; i++) {
 23c:	2485                	addiw	s1,s1,1
 23e:	ff3490e3          	bne	s1,s3,21e <thread_c+0x6e>
  }
  thread_sleep();
 242:	00000097          	auipc	ra,0x0
 246:	254080e7          	jalr	596(ra) # 496 <thread_sleep>
  printf("thread_c: exit after %d\n", c_n);
 24a:	00001597          	auipc	a1,0x1
 24e:	2065a583          	lw	a1,518(a1) # 1450 <c_n>
 252:	00001517          	auipc	a0,0x1
 256:	ba650513          	addi	a0,a0,-1114 # df8 <malloc+0x1be>
 25a:	00001097          	auipc	ra,0x1
 25e:	928080e7          	jalr	-1752(ra) # b82 <printf>

  current_thread->state = FREE;
 262:	00001797          	auipc	a5,0x1
 266:	2067b783          	ld	a5,518(a5) # 1468 <current_thread>
 26a:	6709                	lui	a4,0x2
 26c:	97ba                	add	a5,a5,a4
 26e:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 272:	00000097          	auipc	ra,0x0
 276:	128080e7          	jalr	296(ra) # 39a <thread_schedule>
}
 27a:	70a2                	ld	ra,40(sp)
 27c:	7402                	ld	s0,32(sp)
 27e:	64e2                	ld	s1,24(sp)
 280:	6942                	ld	s2,16(sp)
 282:	69a2                	ld	s3,8(sp)
 284:	6a02                	ld	s4,0(sp)
 286:	6145                	addi	sp,sp,48
 288:	8082                	ret

000000000000028a <main>:

int 
main(int argc, char *argv[]) 
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 292:	00001797          	auipc	a5,0x1
 296:	1c07a523          	sw	zero,458(a5) # 145c <c_started>
 29a:	00001797          	auipc	a5,0x1
 29e:	1c07a323          	sw	zero,454(a5) # 1460 <b_started>
 2a2:	00001797          	auipc	a5,0x1
 2a6:	1c07a123          	sw	zero,450(a5) # 1464 <a_started>
  a_n = b_n = c_n = 0;
 2aa:	00001797          	auipc	a5,0x1
 2ae:	1a07a323          	sw	zero,422(a5) # 1450 <c_n>
 2b2:	00001797          	auipc	a5,0x1
 2b6:	1a07a123          	sw	zero,418(a5) # 1454 <b_n>
 2ba:	00001797          	auipc	a5,0x1
 2be:	1807af23          	sw	zero,414(a5) # 1458 <a_n>
  thread_init();
 2c2:	00000097          	auipc	ra,0x0
 2c6:	05a080e7          	jalr	90(ra) # 31c <thread_init>
  thread_create(thread_a);
 2ca:	00000517          	auipc	a0,0x0
 2ce:	d3650513          	addi	a0,a0,-714 # 0 <thread_a>
 2d2:	00000097          	auipc	ra,0x0
 2d6:	1ec080e7          	jalr	492(ra) # 4be <thread_create>
  thread_create(thread_b);
 2da:	00000517          	auipc	a0,0x0
 2de:	dfa50513          	addi	a0,a0,-518 # d4 <thread_b>
 2e2:	00000097          	auipc	ra,0x0
 2e6:	1dc080e7          	jalr	476(ra) # 4be <thread_create>
  thread_create(thread_c);
 2ea:	00000517          	auipc	a0,0x0
 2ee:	ec650513          	addi	a0,a0,-314 # 1b0 <thread_c>
 2f2:	00000097          	auipc	ra,0x0
 2f6:	1cc080e7          	jalr	460(ra) # 4be <thread_create>
  current_thread->state = FREE;
 2fa:	00001797          	auipc	a5,0x1
 2fe:	16e7b783          	ld	a5,366(a5) # 1468 <current_thread>
 302:	6709                	lui	a4,0x2
 304:	97ba                	add	a5,a5,a4
 306:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 30a:	00000097          	auipc	ra,0x0
 30e:	090080e7          	jalr	144(ra) # 39a <thread_schedule>
  exit(0);
 312:	4501                	li	a0,0
 314:	00000097          	auipc	ra,0x0
 318:	506080e7          	jalr	1286(ra) # 81a <exit>

000000000000031c <thread_init>:
struct thread *current_thread;

              
void 
thread_init(void)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	addi	s0,sp,16
  // main() is thread 0, which will make the first invocation to
  // thread_schedule(). It needs a stack so that the first thread_switch() can
  // save thread 0's state.
  current_thread = &all_thread[0];
 322:	00001797          	auipc	a5,0x1
 326:	15678793          	addi	a5,a5,342 # 1478 <all_thread>
 32a:	00001717          	auipc	a4,0x1
 32e:	12f73f23          	sd	a5,318(a4) # 1468 <current_thread>
  current_thread->state = RUNNING;
 332:	4785                	li	a5,1
 334:	00003717          	auipc	a4,0x3
 338:	14f72223          	sw	a5,324(a4) # 3478 <__global_pointer$+0x182c>
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <thread_wakeup>:
  thread_schedule();
}

int 
thread_wakeup(int thread_id)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  //add your code here
  struct thread *wake_thread = &all_thread[thread_id];
  if (thread_id < 0 || thread_id >= MAX_THREAD){
 348:	478d                	li	a5,3
 34a:	04a7e463          	bltu	a5,a0,392 <thread_wakeup+0x50>
    return -1;
  }

  if (wake_thread->state != SLEEPING){
 34e:	6789                	lui	a5,0x2
 350:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 354:	02f507b3          	mul	a5,a0,a5
 358:	00001697          	auipc	a3,0x1
 35c:	12068693          	addi	a3,a3,288 # 1478 <all_thread>
 360:	96be                	add	a3,a3,a5
 362:	6789                	lui	a5,0x2
 364:	97b6                	add	a5,a5,a3
 366:	4394                	lw	a3,0(a5)
 368:	478d                	li	a5,3
 36a:	02f69663          	bne	a3,a5,396 <thread_wakeup+0x54>
    return -1;
  }

  wake_thread->state = RUNNABLE;
 36e:	6789                	lui	a5,0x2
 370:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 374:	02f50733          	mul	a4,a0,a5
 378:	00001797          	auipc	a5,0x1
 37c:	10078793          	addi	a5,a5,256 # 1478 <all_thread>
 380:	973e                	add	a4,a4,a5
 382:	6789                	lui	a5,0x2
 384:	97ba                	add	a5,a5,a4
 386:	4709                	li	a4,2
 388:	c398                	sw	a4,0(a5)
  return 0;
 38a:	4501                	li	a0,0
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
    return -1;
 392:	557d                	li	a0,-1
 394:	bfe5                	j	38c <thread_wakeup+0x4a>
    return -1;
 396:	557d                	li	a0,-1
 398:	bfd5                	j	38c <thread_wakeup+0x4a>

000000000000039a <thread_schedule>:

void thread_schedule(void)
{
 39a:	1101                	addi	sp,sp,-32
 39c:	ec06                	sd	ra,24(sp)
 39e:	e822                	sd	s0,16(sp)
 3a0:	e426                	sd	s1,8(sp)
 3a2:	1000                	addi	s0,sp,32
  struct thread *t, *next_thread;
  int sleeping_thread = 0;
  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
 3a4:	6789                	lui	a5,0x2
 3a6:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 3aa:	00001597          	auipc	a1,0x1
 3ae:	0be5b583          	ld	a1,190(a1) # 1468 <current_thread>
 3b2:	95be                	add	a1,a1,a5
 3b4:	4791                	li	a5,4
  int sleeping_thread = 0;
 3b6:	4481                	li	s1,0
  for(int i = 0; i < MAX_THREAD; i++){
    if(t >= all_thread + MAX_THREAD)
 3b8:	00009817          	auipc	a6,0x9
 3bc:	2a080813          	addi	a6,a6,672 # 9658 <base>
      t = all_thread;
    if(t->state == RUNNABLE) {
 3c0:	6509                	lui	a0,0x2
 3c2:	4609                	li	a2,2
      next_thread = t;
      break;
    }
    //add code to identify that there are sleeping threads
    if(t->state == SLEEPING) {
 3c4:	488d                	li	a7,3
      sleeping_thread = 1;
 3c6:	4305                	li	t1,1
    }
    t = t + 1;
 3c8:	6689                	lui	a3,0x2
 3ca:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 3ce:	a819                	j	3e4 <thread_schedule+0x4a>
    if(t->state == RUNNABLE) {
 3d0:	00a58733          	add	a4,a1,a0
 3d4:	4318                	lw	a4,0(a4)
 3d6:	04c70d63          	beq	a4,a2,430 <thread_schedule+0x96>
    if(t->state == SLEEPING) {
 3da:	01170c63          	beq	a4,a7,3f2 <thread_schedule+0x58>
    t = t + 1;
 3de:	95b6                	add	a1,a1,a3
  for(int i = 0; i < MAX_THREAD; i++){
 3e0:	37fd                	addiw	a5,a5,-1
 3e2:	c3d1                	beqz	a5,466 <thread_schedule+0xcc>
    if(t >= all_thread + MAX_THREAD)
 3e4:	ff05e6e3          	bltu	a1,a6,3d0 <thread_schedule+0x36>
      t = all_thread;
 3e8:	00001597          	auipc	a1,0x1
 3ec:	09058593          	addi	a1,a1,144 # 1478 <all_thread>
 3f0:	b7c5                	j	3d0 <thread_schedule+0x36>
      sleeping_thread = 1;
 3f2:	849a                	mv	s1,t1
 3f4:	b7ed                	j	3de <thread_schedule+0x44>
        if(first_sleep == 0){
          all_thread[i].state = RUNNING;
          next_thread = &all_thread[i];
          first_sleep = 1;
        } else {
          all_thread[i].state = RUNNABLE;
 3f6:	4709                	li	a4,2
 3f8:	c398                	sw	a4,0(a5)
      for(int i = 0; i < MAX_THREAD; i++){ 
 3fa:	97b6                	add	a5,a5,a3
 3fc:	03078a63          	beq	a5,a6,430 <thread_schedule+0x96>
        if(all_thread[i].state == SLEEPING){
 400:	4398                	lw	a4,0(a5)
 402:	fea71ce3          	bne	a4,a0,3fa <thread_schedule+0x60>
        if(first_sleep == 0){
 406:	fe0898e3          	bnez	a7,3f6 <thread_schedule+0x5c>
          all_thread[i].state = RUNNING;
 40a:	4705                	li	a4,1
 40c:	c398                	sw	a4,0(a5)
          next_thread = &all_thread[i];
 40e:	75f9                	lui	a1,0xffffe
 410:	95be                	add	a1,a1,a5
          first_sleep = 1;
 412:	88a6                	mv	a7,s1
 414:	b7dd                	j	3fa <thread_schedule+0x60>

      }
      }
    }
    else{
      printf("thread_schedule: no runnable threads\n");
 416:	00001517          	auipc	a0,0x1
 41a:	a2a50513          	addi	a0,a0,-1494 # e40 <malloc+0x206>
 41e:	00000097          	auipc	ra,0x0
 422:	764080e7          	jalr	1892(ra) # b82 <printf>
      exit(-1);
 426:	557d                	li	a0,-1
 428:	00000097          	auipc	ra,0x0
 42c:	3f2080e7          	jalr	1010(ra) # 81a <exit>
    }
  }

  if (current_thread != next_thread) {         /* switch threads?  */
 430:	00001517          	auipc	a0,0x1
 434:	03853503          	ld	a0,56(a0) # 1468 <current_thread>
 438:	02b50263          	beq	a0,a1,45c <thread_schedule+0xc2>
    next_thread->state = RUNNING;
 43c:	6789                	lui	a5,0x2
 43e:	97ae                	add	a5,a5,a1
 440:	4705                	li	a4,1
 442:	c398                	sw	a4,0(a5)
    t = current_thread;
    current_thread = next_thread;
 444:	00001797          	auipc	a5,0x1
 448:	02b7b223          	sd	a1,36(a5) # 1468 <current_thread>
    thread_switch(&t->context, &current_thread->context);
 44c:	6789                	lui	a5,0x2
 44e:	07a1                	addi	a5,a5,8 # 2008 <__global_pointer$+0x3bc>
 450:	95be                	add	a1,a1,a5
 452:	953e                	add	a0,a0,a5
 454:	00000097          	auipc	ra,0x0
 458:	0d6080e7          	jalr	214(ra) # 52a <thread_switch>
  } else
    next_thread = 0;
}
 45c:	60e2                	ld	ra,24(sp)
 45e:	6442                	ld	s0,16(sp)
 460:	64a2                	ld	s1,8(sp)
 462:	6105                	addi	sp,sp,32
 464:	8082                	ret
    if (sleeping_thread == 1){
 466:	d8c5                	beqz	s1,416 <thread_schedule+0x7c>
      printf("only thread sleepings, wake them all\n");
 468:	00001517          	auipc	a0,0x1
 46c:	9b050513          	addi	a0,a0,-1616 # e18 <malloc+0x1de>
 470:	00000097          	auipc	ra,0x0
 474:	712080e7          	jalr	1810(ra) # b82 <printf>
      for(int i = 0; i < MAX_THREAD; i++){ 
 478:	00003797          	auipc	a5,0x3
 47c:	00078793          	mv	a5,a5
 480:	0000b817          	auipc	a6,0xb
 484:	1d880813          	addi	a6,a6,472 # b658 <__BSS_END__+0x1ff0>
      int first_sleep = 0;
 488:	4881                	li	a7,0
      printf("only thread sleepings, wake them all\n");
 48a:	4581                	li	a1,0
        if(all_thread[i].state == SLEEPING){
 48c:	450d                	li	a0,3
      for(int i = 0; i < MAX_THREAD; i++){ 
 48e:	6689                	lui	a3,0x2
 490:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 494:	b7b5                	j	400 <thread_schedule+0x66>

0000000000000496 <thread_sleep>:
{
 496:	1141                	addi	sp,sp,-16
 498:	e406                	sd	ra,8(sp)
 49a:	e022                	sd	s0,0(sp)
 49c:	0800                	addi	s0,sp,16
  current_thread->state = SLEEPING;
 49e:	00001797          	auipc	a5,0x1
 4a2:	fca7b783          	ld	a5,-54(a5) # 1468 <current_thread>
 4a6:	6709                	lui	a4,0x2
 4a8:	97ba                	add	a5,a5,a4
 4aa:	470d                	li	a4,3
 4ac:	c398                	sw	a4,0(a5)
  thread_schedule();
 4ae:	00000097          	auipc	ra,0x0
 4b2:	eec080e7          	jalr	-276(ra) # 39a <thread_schedule>
}
 4b6:	60a2                	ld	ra,8(sp)
 4b8:	6402                	ld	s0,0(sp)
 4ba:	0141                	addi	sp,sp,16
 4bc:	8082                	ret

00000000000004be <thread_create>:

void 
thread_create(void (*func)())
{
 4be:	1141                	addi	sp,sp,-16
 4c0:	e422                	sd	s0,8(sp)
 4c2:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4c4:	00001797          	auipc	a5,0x1
 4c8:	fb478793          	addi	a5,a5,-76 # 1478 <all_thread>
    if (t->state == FREE) break;
 4cc:	6609                	lui	a2,0x2
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4ce:	6689                	lui	a3,0x2
 4d0:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 4d4:	00009597          	auipc	a1,0x9
 4d8:	18458593          	addi	a1,a1,388 # 9658 <base>
    if (t->state == FREE) break;
 4dc:	00c78733          	add	a4,a5,a2
 4e0:	4318                	lw	a4,0(a4)
 4e2:	c701                	beqz	a4,4ea <thread_create+0x2c>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4e4:	97b6                	add	a5,a5,a3
 4e6:	feb79be3          	bne	a5,a1,4dc <thread_create+0x1e>
  }
  t->state = RUNNABLE;
 4ea:	6709                	lui	a4,0x2
 4ec:	00e786b3          	add	a3,a5,a4
 4f0:	4609                	li	a2,2
 4f2:	c290                	sw	a2,0(a3)
  t->context.sp = (uint64)&t->stack[STACK_SIZE-1];
 4f4:	177d                	addi	a4,a4,-1 # 1fff <__global_pointer$+0x3b3>
 4f6:	97ba                	add	a5,a5,a4
 4f8:	ea9c                	sd	a5,16(a3)
  t->context.ra = (uint64)(*func);
 4fa:	e688                	sd	a0,8(a3)
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret

0000000000000502 <thread_yield>:

void 
thread_yield(void)
{
 502:	1141                	addi	sp,sp,-16
 504:	e406                	sd	ra,8(sp)
 506:	e022                	sd	s0,0(sp)
 508:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
 50a:	00001797          	auipc	a5,0x1
 50e:	f5e7b783          	ld	a5,-162(a5) # 1468 <current_thread>
 512:	6709                	lui	a4,0x2
 514:	97ba                	add	a5,a5,a4
 516:	4709                	li	a4,2
 518:	c398                	sw	a4,0(a5)
  thread_schedule();
 51a:	00000097          	auipc	ra,0x0
 51e:	e80080e7          	jalr	-384(ra) # 39a <thread_schedule>
}
 522:	60a2                	ld	ra,8(sp)
 524:	6402                	ld	s0,0(sp)
 526:	0141                	addi	sp,sp,16
 528:	8082                	ret

000000000000052a <thread_switch>:
         */

	.globl thread_switch
thread_switch:
	# Save old thread context (a0 = old, a1 = new).
	sd ra, 0(a0)
 52a:	00153023          	sd	ra,0(a0)
	sd sp, 8(a0)
 52e:	00253423          	sd	sp,8(a0)
	sd s0, 16(a0)
 532:	e900                	sd	s0,16(a0)
	sd s1, 24(a0)
 534:	ed04                	sd	s1,24(a0)
	sd s2, 32(a0)
 536:	03253023          	sd	s2,32(a0)
	sd s3, 40(a0)
 53a:	03353423          	sd	s3,40(a0)
	sd s4, 48(a0)
 53e:	03453823          	sd	s4,48(a0)
	sd s5, 56(a0)
 542:	03553c23          	sd	s5,56(a0)
	sd s6, 64(a0)
 546:	05653023          	sd	s6,64(a0)
	sd s7, 72(a0)
 54a:	05753423          	sd	s7,72(a0)
	sd s8, 80(a0)
 54e:	05853823          	sd	s8,80(a0)
	sd s9, 88(a0)
 552:	05953c23          	sd	s9,88(a0)
	sd s10, 96(a0)
 556:	07a53023          	sd	s10,96(a0)
	sd s11, 104(a0)
 55a:	07b53423          	sd	s11,104(a0)

	# Restore new thread context.
	ld ra, 0(a1)
 55e:	0005b083          	ld	ra,0(a1)
	ld sp, 8(a1)
 562:	0085b103          	ld	sp,8(a1)
	ld s0, 16(a1)
 566:	6980                	ld	s0,16(a1)
	ld s1, 24(a1)
 568:	6d84                	ld	s1,24(a1)
	ld s2, 32(a1)
 56a:	0205b903          	ld	s2,32(a1)
	ld s3, 40(a1)
 56e:	0285b983          	ld	s3,40(a1)
	ld s4, 48(a1)
 572:	0305ba03          	ld	s4,48(a1)
	ld s5, 56(a1)
 576:	0385ba83          	ld	s5,56(a1)
	ld s6, 64(a1)
 57a:	0405bb03          	ld	s6,64(a1)
	ld s7, 72(a1)
 57e:	0485bb83          	ld	s7,72(a1)
	ld s8, 80(a1)
 582:	0505bc03          	ld	s8,80(a1)
	ld s9, 88(a1)
 586:	0585bc83          	ld	s9,88(a1)
	ld s10, 96(a1)
 58a:	0605bd03          	ld	s10,96(a1)
	ld s11, 104(a1)
 58e:	0685bd83          	ld	s11,104(a1)
	ret    /* return to ra */
 592:	8082                	ret

0000000000000594 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 594:	1141                	addi	sp,sp,-16
 596:	e406                	sd	ra,8(sp)
 598:	e022                	sd	s0,0(sp)
 59a:	0800                	addi	s0,sp,16
  extern int main();
  main();
 59c:	00000097          	auipc	ra,0x0
 5a0:	cee080e7          	jalr	-786(ra) # 28a <main>
  exit(0);
 5a4:	4501                	li	a0,0
 5a6:	00000097          	auipc	ra,0x0
 5aa:	274080e7          	jalr	628(ra) # 81a <exit>

00000000000005ae <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e422                	sd	s0,8(sp)
 5b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5b4:	87aa                	mv	a5,a0
 5b6:	0585                	addi	a1,a1,1
 5b8:	0785                	addi	a5,a5,1
 5ba:	fff5c703          	lbu	a4,-1(a1)
 5be:	fee78fa3          	sb	a4,-1(a5)
 5c2:	fb75                	bnez	a4,5b6 <strcpy+0x8>
    ;
  return os;
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret

00000000000005ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5ca:	1141                	addi	sp,sp,-16
 5cc:	e422                	sd	s0,8(sp)
 5ce:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	cb91                	beqz	a5,5e8 <strcmp+0x1e>
 5d6:	0005c703          	lbu	a4,0(a1)
 5da:	00f71763          	bne	a4,a5,5e8 <strcmp+0x1e>
    p++, q++;
 5de:	0505                	addi	a0,a0,1
 5e0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5e2:	00054783          	lbu	a5,0(a0)
 5e6:	fbe5                	bnez	a5,5d6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5e8:	0005c503          	lbu	a0,0(a1)
}
 5ec:	40a7853b          	subw	a0,a5,a0
 5f0:	6422                	ld	s0,8(sp)
 5f2:	0141                	addi	sp,sp,16
 5f4:	8082                	ret

00000000000005f6 <strlen>:

uint
strlen(const char *s)
{
 5f6:	1141                	addi	sp,sp,-16
 5f8:	e422                	sd	s0,8(sp)
 5fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5fc:	00054783          	lbu	a5,0(a0)
 600:	cf91                	beqz	a5,61c <strlen+0x26>
 602:	0505                	addi	a0,a0,1
 604:	87aa                	mv	a5,a0
 606:	86be                	mv	a3,a5
 608:	0785                	addi	a5,a5,1
 60a:	fff7c703          	lbu	a4,-1(a5)
 60e:	ff65                	bnez	a4,606 <strlen+0x10>
 610:	40a6853b          	subw	a0,a3,a0
 614:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 616:	6422                	ld	s0,8(sp)
 618:	0141                	addi	sp,sp,16
 61a:	8082                	ret
  for(n = 0; s[n]; n++)
 61c:	4501                	li	a0,0
 61e:	bfe5                	j	616 <strlen+0x20>

0000000000000620 <memset>:

void*
memset(void *dst, int c, uint n)
{
 620:	1141                	addi	sp,sp,-16
 622:	e422                	sd	s0,8(sp)
 624:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 626:	ca19                	beqz	a2,63c <memset+0x1c>
 628:	87aa                	mv	a5,a0
 62a:	1602                	slli	a2,a2,0x20
 62c:	9201                	srli	a2,a2,0x20
 62e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 632:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 636:	0785                	addi	a5,a5,1
 638:	fee79de3          	bne	a5,a4,632 <memset+0x12>
  }
  return dst;
}
 63c:	6422                	ld	s0,8(sp)
 63e:	0141                	addi	sp,sp,16
 640:	8082                	ret

0000000000000642 <strchr>:

char*
strchr(const char *s, char c)
{
 642:	1141                	addi	sp,sp,-16
 644:	e422                	sd	s0,8(sp)
 646:	0800                	addi	s0,sp,16
  for(; *s; s++)
 648:	00054783          	lbu	a5,0(a0)
 64c:	cb99                	beqz	a5,662 <strchr+0x20>
    if(*s == c)
 64e:	00f58763          	beq	a1,a5,65c <strchr+0x1a>
  for(; *s; s++)
 652:	0505                	addi	a0,a0,1
 654:	00054783          	lbu	a5,0(a0)
 658:	fbfd                	bnez	a5,64e <strchr+0xc>
      return (char*)s;
  return 0;
 65a:	4501                	li	a0,0
}
 65c:	6422                	ld	s0,8(sp)
 65e:	0141                	addi	sp,sp,16
 660:	8082                	ret
  return 0;
 662:	4501                	li	a0,0
 664:	bfe5                	j	65c <strchr+0x1a>

0000000000000666 <gets>:

char*
gets(char *buf, int max)
{
 666:	711d                	addi	sp,sp,-96
 668:	ec86                	sd	ra,88(sp)
 66a:	e8a2                	sd	s0,80(sp)
 66c:	e4a6                	sd	s1,72(sp)
 66e:	e0ca                	sd	s2,64(sp)
 670:	fc4e                	sd	s3,56(sp)
 672:	f852                	sd	s4,48(sp)
 674:	f456                	sd	s5,40(sp)
 676:	f05a                	sd	s6,32(sp)
 678:	ec5e                	sd	s7,24(sp)
 67a:	1080                	addi	s0,sp,96
 67c:	8baa                	mv	s7,a0
 67e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 680:	892a                	mv	s2,a0
 682:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 684:	4aa9                	li	s5,10
 686:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 688:	89a6                	mv	s3,s1
 68a:	2485                	addiw	s1,s1,1
 68c:	0344d863          	bge	s1,s4,6bc <gets+0x56>
    cc = read(0, &c, 1);
 690:	4605                	li	a2,1
 692:	faf40593          	addi	a1,s0,-81
 696:	4501                	li	a0,0
 698:	00000097          	auipc	ra,0x0
 69c:	19a080e7          	jalr	410(ra) # 832 <read>
    if(cc < 1)
 6a0:	00a05e63          	blez	a0,6bc <gets+0x56>
    buf[i++] = c;
 6a4:	faf44783          	lbu	a5,-81(s0)
 6a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 6ac:	01578763          	beq	a5,s5,6ba <gets+0x54>
 6b0:	0905                	addi	s2,s2,1
 6b2:	fd679be3          	bne	a5,s6,688 <gets+0x22>
    buf[i++] = c;
 6b6:	89a6                	mv	s3,s1
 6b8:	a011                	j	6bc <gets+0x56>
 6ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6bc:	99de                	add	s3,s3,s7
 6be:	00098023          	sb	zero,0(s3)
  return buf;
}
 6c2:	855e                	mv	a0,s7
 6c4:	60e6                	ld	ra,88(sp)
 6c6:	6446                	ld	s0,80(sp)
 6c8:	64a6                	ld	s1,72(sp)
 6ca:	6906                	ld	s2,64(sp)
 6cc:	79e2                	ld	s3,56(sp)
 6ce:	7a42                	ld	s4,48(sp)
 6d0:	7aa2                	ld	s5,40(sp)
 6d2:	7b02                	ld	s6,32(sp)
 6d4:	6be2                	ld	s7,24(sp)
 6d6:	6125                	addi	sp,sp,96
 6d8:	8082                	ret

00000000000006da <stat>:

int
stat(const char *n, struct stat *st)
{
 6da:	1101                	addi	sp,sp,-32
 6dc:	ec06                	sd	ra,24(sp)
 6de:	e822                	sd	s0,16(sp)
 6e0:	e04a                	sd	s2,0(sp)
 6e2:	1000                	addi	s0,sp,32
 6e4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6e6:	4581                	li	a1,0
 6e8:	00000097          	auipc	ra,0x0
 6ec:	172080e7          	jalr	370(ra) # 85a <open>
  if(fd < 0)
 6f0:	02054663          	bltz	a0,71c <stat+0x42>
 6f4:	e426                	sd	s1,8(sp)
 6f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6f8:	85ca                	mv	a1,s2
 6fa:	00000097          	auipc	ra,0x0
 6fe:	178080e7          	jalr	376(ra) # 872 <fstat>
 702:	892a                	mv	s2,a0
  close(fd);
 704:	8526                	mv	a0,s1
 706:	00000097          	auipc	ra,0x0
 70a:	13c080e7          	jalr	316(ra) # 842 <close>
  return r;
 70e:	64a2                	ld	s1,8(sp)
}
 710:	854a                	mv	a0,s2
 712:	60e2                	ld	ra,24(sp)
 714:	6442                	ld	s0,16(sp)
 716:	6902                	ld	s2,0(sp)
 718:	6105                	addi	sp,sp,32
 71a:	8082                	ret
    return -1;
 71c:	597d                	li	s2,-1
 71e:	bfcd                	j	710 <stat+0x36>

0000000000000720 <atoi>:

int
atoi(const char *s)
{
 720:	1141                	addi	sp,sp,-16
 722:	e422                	sd	s0,8(sp)
 724:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 726:	00054683          	lbu	a3,0(a0)
 72a:	fd06879b          	addiw	a5,a3,-48
 72e:	0ff7f793          	zext.b	a5,a5
 732:	4625                	li	a2,9
 734:	02f66863          	bltu	a2,a5,764 <atoi+0x44>
 738:	872a                	mv	a4,a0
  n = 0;
 73a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 73c:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0x3b5>
 73e:	0025179b          	slliw	a5,a0,0x2
 742:	9fa9                	addw	a5,a5,a0
 744:	0017979b          	slliw	a5,a5,0x1
 748:	9fb5                	addw	a5,a5,a3
 74a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 74e:	00074683          	lbu	a3,0(a4)
 752:	fd06879b          	addiw	a5,a3,-48
 756:	0ff7f793          	zext.b	a5,a5
 75a:	fef671e3          	bgeu	a2,a5,73c <atoi+0x1c>
  return n;
}
 75e:	6422                	ld	s0,8(sp)
 760:	0141                	addi	sp,sp,16
 762:	8082                	ret
  n = 0;
 764:	4501                	li	a0,0
 766:	bfe5                	j	75e <atoi+0x3e>

0000000000000768 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 768:	1141                	addi	sp,sp,-16
 76a:	e422                	sd	s0,8(sp)
 76c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 76e:	02b57463          	bgeu	a0,a1,796 <memmove+0x2e>
    while(n-- > 0)
 772:	00c05f63          	blez	a2,790 <memmove+0x28>
 776:	1602                	slli	a2,a2,0x20
 778:	9201                	srli	a2,a2,0x20
 77a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 77e:	872a                	mv	a4,a0
      *dst++ = *src++;
 780:	0585                	addi	a1,a1,1
 782:	0705                	addi	a4,a4,1
 784:	fff5c683          	lbu	a3,-1(a1)
 788:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 78c:	fef71ae3          	bne	a4,a5,780 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 790:	6422                	ld	s0,8(sp)
 792:	0141                	addi	sp,sp,16
 794:	8082                	ret
    dst += n;
 796:	00c50733          	add	a4,a0,a2
    src += n;
 79a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 79c:	fec05ae3          	blez	a2,790 <memmove+0x28>
 7a0:	fff6079b          	addiw	a5,a2,-1 # 1fff <__global_pointer$+0x3b3>
 7a4:	1782                	slli	a5,a5,0x20
 7a6:	9381                	srli	a5,a5,0x20
 7a8:	fff7c793          	not	a5,a5
 7ac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7ae:	15fd                	addi	a1,a1,-1
 7b0:	177d                	addi	a4,a4,-1
 7b2:	0005c683          	lbu	a3,0(a1)
 7b6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 7ba:	fee79ae3          	bne	a5,a4,7ae <memmove+0x46>
 7be:	bfc9                	j	790 <memmove+0x28>

00000000000007c0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 7c0:	1141                	addi	sp,sp,-16
 7c2:	e422                	sd	s0,8(sp)
 7c4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 7c6:	ca05                	beqz	a2,7f6 <memcmp+0x36>
 7c8:	fff6069b          	addiw	a3,a2,-1
 7cc:	1682                	slli	a3,a3,0x20
 7ce:	9281                	srli	a3,a3,0x20
 7d0:	0685                	addi	a3,a3,1
 7d2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7d4:	00054783          	lbu	a5,0(a0)
 7d8:	0005c703          	lbu	a4,0(a1)
 7dc:	00e79863          	bne	a5,a4,7ec <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7e0:	0505                	addi	a0,a0,1
    p2++;
 7e2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7e4:	fed518e3          	bne	a0,a3,7d4 <memcmp+0x14>
  }
  return 0;
 7e8:	4501                	li	a0,0
 7ea:	a019                	j	7f0 <memcmp+0x30>
      return *p1 - *p2;
 7ec:	40e7853b          	subw	a0,a5,a4
}
 7f0:	6422                	ld	s0,8(sp)
 7f2:	0141                	addi	sp,sp,16
 7f4:	8082                	ret
  return 0;
 7f6:	4501                	li	a0,0
 7f8:	bfe5                	j	7f0 <memcmp+0x30>

00000000000007fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7fa:	1141                	addi	sp,sp,-16
 7fc:	e406                	sd	ra,8(sp)
 7fe:	e022                	sd	s0,0(sp)
 800:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 802:	00000097          	auipc	ra,0x0
 806:	f66080e7          	jalr	-154(ra) # 768 <memmove>
}
 80a:	60a2                	ld	ra,8(sp)
 80c:	6402                	ld	s0,0(sp)
 80e:	0141                	addi	sp,sp,16
 810:	8082                	ret

0000000000000812 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 812:	4885                	li	a7,1
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <exit>:
.global exit
exit:
 li a7, SYS_exit
 81a:	4889                	li	a7,2
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <wait>:
.global wait
wait:
 li a7, SYS_wait
 822:	488d                	li	a7,3
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 82a:	4891                	li	a7,4
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <read>:
.global read
read:
 li a7, SYS_read
 832:	4895                	li	a7,5
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <write>:
.global write
write:
 li a7, SYS_write
 83a:	48c1                	li	a7,16
 ecall
 83c:	00000073          	ecall
 ret
 840:	8082                	ret

0000000000000842 <close>:
.global close
close:
 li a7, SYS_close
 842:	48d5                	li	a7,21
 ecall
 844:	00000073          	ecall
 ret
 848:	8082                	ret

000000000000084a <kill>:
.global kill
kill:
 li a7, SYS_kill
 84a:	4899                	li	a7,6
 ecall
 84c:	00000073          	ecall
 ret
 850:	8082                	ret

0000000000000852 <exec>:
.global exec
exec:
 li a7, SYS_exec
 852:	489d                	li	a7,7
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <open>:
.global open
open:
 li a7, SYS_open
 85a:	48bd                	li	a7,15
 ecall
 85c:	00000073          	ecall
 ret
 860:	8082                	ret

0000000000000862 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 862:	48c5                	li	a7,17
 ecall
 864:	00000073          	ecall
 ret
 868:	8082                	ret

000000000000086a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 86a:	48c9                	li	a7,18
 ecall
 86c:	00000073          	ecall
 ret
 870:	8082                	ret

0000000000000872 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 872:	48a1                	li	a7,8
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <link>:
.global link
link:
 li a7, SYS_link
 87a:	48cd                	li	a7,19
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 882:	48d1                	li	a7,20
 ecall
 884:	00000073          	ecall
 ret
 888:	8082                	ret

000000000000088a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 88a:	48a5                	li	a7,9
 ecall
 88c:	00000073          	ecall
 ret
 890:	8082                	ret

0000000000000892 <dup>:
.global dup
dup:
 li a7, SYS_dup
 892:	48a9                	li	a7,10
 ecall
 894:	00000073          	ecall
 ret
 898:	8082                	ret

000000000000089a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 89a:	48ad                	li	a7,11
 ecall
 89c:	00000073          	ecall
 ret
 8a0:	8082                	ret

00000000000008a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 8a2:	48b1                	li	a7,12
 ecall
 8a4:	00000073          	ecall
 ret
 8a8:	8082                	ret

00000000000008aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8aa:	48b5                	li	a7,13
 ecall
 8ac:	00000073          	ecall
 ret
 8b0:	8082                	ret

00000000000008b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8b2:	48b9                	li	a7,14
 ecall
 8b4:	00000073          	ecall
 ret
 8b8:	8082                	ret

00000000000008ba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8ba:	1101                	addi	sp,sp,-32
 8bc:	ec06                	sd	ra,24(sp)
 8be:	e822                	sd	s0,16(sp)
 8c0:	1000                	addi	s0,sp,32
 8c2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8c6:	4605                	li	a2,1
 8c8:	fef40593          	addi	a1,s0,-17
 8cc:	00000097          	auipc	ra,0x0
 8d0:	f6e080e7          	jalr	-146(ra) # 83a <write>
}
 8d4:	60e2                	ld	ra,24(sp)
 8d6:	6442                	ld	s0,16(sp)
 8d8:	6105                	addi	sp,sp,32
 8da:	8082                	ret

00000000000008dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8dc:	7139                	addi	sp,sp,-64
 8de:	fc06                	sd	ra,56(sp)
 8e0:	f822                	sd	s0,48(sp)
 8e2:	f426                	sd	s1,40(sp)
 8e4:	0080                	addi	s0,sp,64
 8e6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8e8:	c299                	beqz	a3,8ee <printint+0x12>
 8ea:	0805cb63          	bltz	a1,980 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8ee:	2581                	sext.w	a1,a1
  neg = 0;
 8f0:	4881                	li	a7,0
 8f2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8f6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8f8:	2601                	sext.w	a2,a2
 8fa:	00000517          	auipc	a0,0x0
 8fe:	5ce50513          	addi	a0,a0,1486 # ec8 <digits>
 902:	883a                	mv	a6,a4
 904:	2705                	addiw	a4,a4,1
 906:	02c5f7bb          	remuw	a5,a1,a2
 90a:	1782                	slli	a5,a5,0x20
 90c:	9381                	srli	a5,a5,0x20
 90e:	97aa                	add	a5,a5,a0
 910:	0007c783          	lbu	a5,0(a5)
 914:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 918:	0005879b          	sext.w	a5,a1
 91c:	02c5d5bb          	divuw	a1,a1,a2
 920:	0685                	addi	a3,a3,1
 922:	fec7f0e3          	bgeu	a5,a2,902 <printint+0x26>
  if(neg)
 926:	00088c63          	beqz	a7,93e <printint+0x62>
    buf[i++] = '-';
 92a:	fd070793          	addi	a5,a4,-48
 92e:	00878733          	add	a4,a5,s0
 932:	02d00793          	li	a5,45
 936:	fef70823          	sb	a5,-16(a4)
 93a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 93e:	02e05c63          	blez	a4,976 <printint+0x9a>
 942:	f04a                	sd	s2,32(sp)
 944:	ec4e                	sd	s3,24(sp)
 946:	fc040793          	addi	a5,s0,-64
 94a:	00e78933          	add	s2,a5,a4
 94e:	fff78993          	addi	s3,a5,-1
 952:	99ba                	add	s3,s3,a4
 954:	377d                	addiw	a4,a4,-1
 956:	1702                	slli	a4,a4,0x20
 958:	9301                	srli	a4,a4,0x20
 95a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 95e:	fff94583          	lbu	a1,-1(s2)
 962:	8526                	mv	a0,s1
 964:	00000097          	auipc	ra,0x0
 968:	f56080e7          	jalr	-170(ra) # 8ba <putc>
  while(--i >= 0)
 96c:	197d                	addi	s2,s2,-1
 96e:	ff3918e3          	bne	s2,s3,95e <printint+0x82>
 972:	7902                	ld	s2,32(sp)
 974:	69e2                	ld	s3,24(sp)
}
 976:	70e2                	ld	ra,56(sp)
 978:	7442                	ld	s0,48(sp)
 97a:	74a2                	ld	s1,40(sp)
 97c:	6121                	addi	sp,sp,64
 97e:	8082                	ret
    x = -xx;
 980:	40b005bb          	negw	a1,a1
    neg = 1;
 984:	4885                	li	a7,1
    x = -xx;
 986:	b7b5                	j	8f2 <printint+0x16>

0000000000000988 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 988:	715d                	addi	sp,sp,-80
 98a:	e486                	sd	ra,72(sp)
 98c:	e0a2                	sd	s0,64(sp)
 98e:	f84a                	sd	s2,48(sp)
 990:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 992:	0005c903          	lbu	s2,0(a1)
 996:	1a090a63          	beqz	s2,b4a <vprintf+0x1c2>
 99a:	fc26                	sd	s1,56(sp)
 99c:	f44e                	sd	s3,40(sp)
 99e:	f052                	sd	s4,32(sp)
 9a0:	ec56                	sd	s5,24(sp)
 9a2:	e85a                	sd	s6,16(sp)
 9a4:	e45e                	sd	s7,8(sp)
 9a6:	8aaa                	mv	s5,a0
 9a8:	8bb2                	mv	s7,a2
 9aa:	00158493          	addi	s1,a1,1
  state = 0;
 9ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9b0:	02500a13          	li	s4,37
 9b4:	4b55                	li	s6,21
 9b6:	a839                	j	9d4 <vprintf+0x4c>
        putc(fd, c);
 9b8:	85ca                	mv	a1,s2
 9ba:	8556                	mv	a0,s5
 9bc:	00000097          	auipc	ra,0x0
 9c0:	efe080e7          	jalr	-258(ra) # 8ba <putc>
 9c4:	a019                	j	9ca <vprintf+0x42>
    } else if(state == '%'){
 9c6:	01498d63          	beq	s3,s4,9e0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 9ca:	0485                	addi	s1,s1,1
 9cc:	fff4c903          	lbu	s2,-1(s1)
 9d0:	16090763          	beqz	s2,b3e <vprintf+0x1b6>
    if(state == 0){
 9d4:	fe0999e3          	bnez	s3,9c6 <vprintf+0x3e>
      if(c == '%'){
 9d8:	ff4910e3          	bne	s2,s4,9b8 <vprintf+0x30>
        state = '%';
 9dc:	89d2                	mv	s3,s4
 9de:	b7f5                	j	9ca <vprintf+0x42>
      if(c == 'd'){
 9e0:	13490463          	beq	s2,s4,b08 <vprintf+0x180>
 9e4:	f9d9079b          	addiw	a5,s2,-99
 9e8:	0ff7f793          	zext.b	a5,a5
 9ec:	12fb6763          	bltu	s6,a5,b1a <vprintf+0x192>
 9f0:	f9d9079b          	addiw	a5,s2,-99
 9f4:	0ff7f713          	zext.b	a4,a5
 9f8:	12eb6163          	bltu	s6,a4,b1a <vprintf+0x192>
 9fc:	00271793          	slli	a5,a4,0x2
 a00:	00000717          	auipc	a4,0x0
 a04:	47070713          	addi	a4,a4,1136 # e70 <malloc+0x236>
 a08:	97ba                	add	a5,a5,a4
 a0a:	439c                	lw	a5,0(a5)
 a0c:	97ba                	add	a5,a5,a4
 a0e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a10:	008b8913          	addi	s2,s7,8
 a14:	4685                	li	a3,1
 a16:	4629                	li	a2,10
 a18:	000ba583          	lw	a1,0(s7)
 a1c:	8556                	mv	a0,s5
 a1e:	00000097          	auipc	ra,0x0
 a22:	ebe080e7          	jalr	-322(ra) # 8dc <printint>
 a26:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	b745                	j	9ca <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a2c:	008b8913          	addi	s2,s7,8
 a30:	4681                	li	a3,0
 a32:	4629                	li	a2,10
 a34:	000ba583          	lw	a1,0(s7)
 a38:	8556                	mv	a0,s5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	ea2080e7          	jalr	-350(ra) # 8dc <printint>
 a42:	8bca                	mv	s7,s2
      state = 0;
 a44:	4981                	li	s3,0
 a46:	b751                	j	9ca <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 a48:	008b8913          	addi	s2,s7,8
 a4c:	4681                	li	a3,0
 a4e:	4641                	li	a2,16
 a50:	000ba583          	lw	a1,0(s7)
 a54:	8556                	mv	a0,s5
 a56:	00000097          	auipc	ra,0x0
 a5a:	e86080e7          	jalr	-378(ra) # 8dc <printint>
 a5e:	8bca                	mv	s7,s2
      state = 0;
 a60:	4981                	li	s3,0
 a62:	b7a5                	j	9ca <vprintf+0x42>
 a64:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a66:	008b8c13          	addi	s8,s7,8
 a6a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a6e:	03000593          	li	a1,48
 a72:	8556                	mv	a0,s5
 a74:	00000097          	auipc	ra,0x0
 a78:	e46080e7          	jalr	-442(ra) # 8ba <putc>
  putc(fd, 'x');
 a7c:	07800593          	li	a1,120
 a80:	8556                	mv	a0,s5
 a82:	00000097          	auipc	ra,0x0
 a86:	e38080e7          	jalr	-456(ra) # 8ba <putc>
 a8a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a8c:	00000b97          	auipc	s7,0x0
 a90:	43cb8b93          	addi	s7,s7,1084 # ec8 <digits>
 a94:	03c9d793          	srli	a5,s3,0x3c
 a98:	97de                	add	a5,a5,s7
 a9a:	0007c583          	lbu	a1,0(a5)
 a9e:	8556                	mv	a0,s5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	e1a080e7          	jalr	-486(ra) # 8ba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aa8:	0992                	slli	s3,s3,0x4
 aaa:	397d                	addiw	s2,s2,-1
 aac:	fe0914e3          	bnez	s2,a94 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 ab0:	8be2                	mv	s7,s8
      state = 0;
 ab2:	4981                	li	s3,0
 ab4:	6c02                	ld	s8,0(sp)
 ab6:	bf11                	j	9ca <vprintf+0x42>
        s = va_arg(ap, char*);
 ab8:	008b8993          	addi	s3,s7,8
 abc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 ac0:	02090163          	beqz	s2,ae2 <vprintf+0x15a>
        while(*s != 0){
 ac4:	00094583          	lbu	a1,0(s2)
 ac8:	c9a5                	beqz	a1,b38 <vprintf+0x1b0>
          putc(fd, *s);
 aca:	8556                	mv	a0,s5
 acc:	00000097          	auipc	ra,0x0
 ad0:	dee080e7          	jalr	-530(ra) # 8ba <putc>
          s++;
 ad4:	0905                	addi	s2,s2,1
        while(*s != 0){
 ad6:	00094583          	lbu	a1,0(s2)
 ada:	f9e5                	bnez	a1,aca <vprintf+0x142>
        s = va_arg(ap, char*);
 adc:	8bce                	mv	s7,s3
      state = 0;
 ade:	4981                	li	s3,0
 ae0:	b5ed                	j	9ca <vprintf+0x42>
          s = "(null)";
 ae2:	00000917          	auipc	s2,0x0
 ae6:	38690913          	addi	s2,s2,902 # e68 <malloc+0x22e>
        while(*s != 0){
 aea:	02800593          	li	a1,40
 aee:	bff1                	j	aca <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 af0:	008b8913          	addi	s2,s7,8
 af4:	000bc583          	lbu	a1,0(s7)
 af8:	8556                	mv	a0,s5
 afa:	00000097          	auipc	ra,0x0
 afe:	dc0080e7          	jalr	-576(ra) # 8ba <putc>
 b02:	8bca                	mv	s7,s2
      state = 0;
 b04:	4981                	li	s3,0
 b06:	b5d1                	j	9ca <vprintf+0x42>
        putc(fd, c);
 b08:	02500593          	li	a1,37
 b0c:	8556                	mv	a0,s5
 b0e:	00000097          	auipc	ra,0x0
 b12:	dac080e7          	jalr	-596(ra) # 8ba <putc>
      state = 0;
 b16:	4981                	li	s3,0
 b18:	bd4d                	j	9ca <vprintf+0x42>
        putc(fd, '%');
 b1a:	02500593          	li	a1,37
 b1e:	8556                	mv	a0,s5
 b20:	00000097          	auipc	ra,0x0
 b24:	d9a080e7          	jalr	-614(ra) # 8ba <putc>
        putc(fd, c);
 b28:	85ca                	mv	a1,s2
 b2a:	8556                	mv	a0,s5
 b2c:	00000097          	auipc	ra,0x0
 b30:	d8e080e7          	jalr	-626(ra) # 8ba <putc>
      state = 0;
 b34:	4981                	li	s3,0
 b36:	bd51                	j	9ca <vprintf+0x42>
        s = va_arg(ap, char*);
 b38:	8bce                	mv	s7,s3
      state = 0;
 b3a:	4981                	li	s3,0
 b3c:	b579                	j	9ca <vprintf+0x42>
 b3e:	74e2                	ld	s1,56(sp)
 b40:	79a2                	ld	s3,40(sp)
 b42:	7a02                	ld	s4,32(sp)
 b44:	6ae2                	ld	s5,24(sp)
 b46:	6b42                	ld	s6,16(sp)
 b48:	6ba2                	ld	s7,8(sp)
    }
  }
}
 b4a:	60a6                	ld	ra,72(sp)
 b4c:	6406                	ld	s0,64(sp)
 b4e:	7942                	ld	s2,48(sp)
 b50:	6161                	addi	sp,sp,80
 b52:	8082                	ret

0000000000000b54 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b54:	715d                	addi	sp,sp,-80
 b56:	ec06                	sd	ra,24(sp)
 b58:	e822                	sd	s0,16(sp)
 b5a:	1000                	addi	s0,sp,32
 b5c:	e010                	sd	a2,0(s0)
 b5e:	e414                	sd	a3,8(s0)
 b60:	e818                	sd	a4,16(s0)
 b62:	ec1c                	sd	a5,24(s0)
 b64:	03043023          	sd	a6,32(s0)
 b68:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b6c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b70:	8622                	mv	a2,s0
 b72:	00000097          	auipc	ra,0x0
 b76:	e16080e7          	jalr	-490(ra) # 988 <vprintf>
}
 b7a:	60e2                	ld	ra,24(sp)
 b7c:	6442                	ld	s0,16(sp)
 b7e:	6161                	addi	sp,sp,80
 b80:	8082                	ret

0000000000000b82 <printf>:

void
printf(const char *fmt, ...)
{
 b82:	711d                	addi	sp,sp,-96
 b84:	ec06                	sd	ra,24(sp)
 b86:	e822                	sd	s0,16(sp)
 b88:	1000                	addi	s0,sp,32
 b8a:	e40c                	sd	a1,8(s0)
 b8c:	e810                	sd	a2,16(s0)
 b8e:	ec14                	sd	a3,24(s0)
 b90:	f018                	sd	a4,32(s0)
 b92:	f41c                	sd	a5,40(s0)
 b94:	03043823          	sd	a6,48(s0)
 b98:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b9c:	00840613          	addi	a2,s0,8
 ba0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ba4:	85aa                	mv	a1,a0
 ba6:	4505                	li	a0,1
 ba8:	00000097          	auipc	ra,0x0
 bac:	de0080e7          	jalr	-544(ra) # 988 <vprintf>
}
 bb0:	60e2                	ld	ra,24(sp)
 bb2:	6442                	ld	s0,16(sp)
 bb4:	6125                	addi	sp,sp,96
 bb6:	8082                	ret

0000000000000bb8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bb8:	1141                	addi	sp,sp,-16
 bba:	e422                	sd	s0,8(sp)
 bbc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bbe:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc2:	00001797          	auipc	a5,0x1
 bc6:	8ae7b783          	ld	a5,-1874(a5) # 1470 <freep>
 bca:	a02d                	j	bf4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bcc:	4618                	lw	a4,8(a2)
 bce:	9f2d                	addw	a4,a4,a1
 bd0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bd4:	6398                	ld	a4,0(a5)
 bd6:	6310                	ld	a2,0(a4)
 bd8:	a83d                	j	c16 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bda:	ff852703          	lw	a4,-8(a0)
 bde:	9f31                	addw	a4,a4,a2
 be0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 be2:	ff053683          	ld	a3,-16(a0)
 be6:	a091                	j	c2a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 be8:	6398                	ld	a4,0(a5)
 bea:	00e7e463          	bltu	a5,a4,bf2 <free+0x3a>
 bee:	00e6ea63          	bltu	a3,a4,c02 <free+0x4a>
{
 bf2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf4:	fed7fae3          	bgeu	a5,a3,be8 <free+0x30>
 bf8:	6398                	ld	a4,0(a5)
 bfa:	00e6e463          	bltu	a3,a4,c02 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bfe:	fee7eae3          	bltu	a5,a4,bf2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c02:	ff852583          	lw	a1,-8(a0)
 c06:	6390                	ld	a2,0(a5)
 c08:	02059813          	slli	a6,a1,0x20
 c0c:	01c85713          	srli	a4,a6,0x1c
 c10:	9736                	add	a4,a4,a3
 c12:	fae60de3          	beq	a2,a4,bcc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c16:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c1a:	4790                	lw	a2,8(a5)
 c1c:	02061593          	slli	a1,a2,0x20
 c20:	01c5d713          	srli	a4,a1,0x1c
 c24:	973e                	add	a4,a4,a5
 c26:	fae68ae3          	beq	a3,a4,bda <free+0x22>
    p->s.ptr = bp->s.ptr;
 c2a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c2c:	00001717          	auipc	a4,0x1
 c30:	84f73223          	sd	a5,-1980(a4) # 1470 <freep>
}
 c34:	6422                	ld	s0,8(sp)
 c36:	0141                	addi	sp,sp,16
 c38:	8082                	ret

0000000000000c3a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c3a:	7139                	addi	sp,sp,-64
 c3c:	fc06                	sd	ra,56(sp)
 c3e:	f822                	sd	s0,48(sp)
 c40:	f426                	sd	s1,40(sp)
 c42:	ec4e                	sd	s3,24(sp)
 c44:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c46:	02051493          	slli	s1,a0,0x20
 c4a:	9081                	srli	s1,s1,0x20
 c4c:	04bd                	addi	s1,s1,15
 c4e:	8091                	srli	s1,s1,0x4
 c50:	0014899b          	addiw	s3,s1,1
 c54:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c56:	00001517          	auipc	a0,0x1
 c5a:	81a53503          	ld	a0,-2022(a0) # 1470 <freep>
 c5e:	c915                	beqz	a0,c92 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c60:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c62:	4798                	lw	a4,8(a5)
 c64:	08977e63          	bgeu	a4,s1,d00 <malloc+0xc6>
 c68:	f04a                	sd	s2,32(sp)
 c6a:	e852                	sd	s4,16(sp)
 c6c:	e456                	sd	s5,8(sp)
 c6e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c70:	8a4e                	mv	s4,s3
 c72:	0009871b          	sext.w	a4,s3
 c76:	6685                	lui	a3,0x1
 c78:	00d77363          	bgeu	a4,a3,c7e <malloc+0x44>
 c7c:	6a05                	lui	s4,0x1
 c7e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c82:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c86:	00000917          	auipc	s2,0x0
 c8a:	7ea90913          	addi	s2,s2,2026 # 1470 <freep>
  if(p == (char*)-1)
 c8e:	5afd                	li	s5,-1
 c90:	a091                	j	cd4 <malloc+0x9a>
 c92:	f04a                	sd	s2,32(sp)
 c94:	e852                	sd	s4,16(sp)
 c96:	e456                	sd	s5,8(sp)
 c98:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c9a:	00009797          	auipc	a5,0x9
 c9e:	9be78793          	addi	a5,a5,-1602 # 9658 <base>
 ca2:	00000717          	auipc	a4,0x0
 ca6:	7cf73723          	sd	a5,1998(a4) # 1470 <freep>
 caa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cb0:	b7c1                	j	c70 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 cb2:	6398                	ld	a4,0(a5)
 cb4:	e118                	sd	a4,0(a0)
 cb6:	a08d                	j	d18 <malloc+0xde>
  hp->s.size = nu;
 cb8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cbc:	0541                	addi	a0,a0,16
 cbe:	00000097          	auipc	ra,0x0
 cc2:	efa080e7          	jalr	-262(ra) # bb8 <free>
  return freep;
 cc6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cca:	c13d                	beqz	a0,d30 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ccc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cce:	4798                	lw	a4,8(a5)
 cd0:	02977463          	bgeu	a4,s1,cf8 <malloc+0xbe>
    if(p == freep)
 cd4:	00093703          	ld	a4,0(s2)
 cd8:	853e                	mv	a0,a5
 cda:	fef719e3          	bne	a4,a5,ccc <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 cde:	8552                	mv	a0,s4
 ce0:	00000097          	auipc	ra,0x0
 ce4:	bc2080e7          	jalr	-1086(ra) # 8a2 <sbrk>
  if(p == (char*)-1)
 ce8:	fd5518e3          	bne	a0,s5,cb8 <malloc+0x7e>
        return 0;
 cec:	4501                	li	a0,0
 cee:	7902                	ld	s2,32(sp)
 cf0:	6a42                	ld	s4,16(sp)
 cf2:	6aa2                	ld	s5,8(sp)
 cf4:	6b02                	ld	s6,0(sp)
 cf6:	a03d                	j	d24 <malloc+0xea>
 cf8:	7902                	ld	s2,32(sp)
 cfa:	6a42                	ld	s4,16(sp)
 cfc:	6aa2                	ld	s5,8(sp)
 cfe:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d00:	fae489e3          	beq	s1,a4,cb2 <malloc+0x78>
        p->s.size -= nunits;
 d04:	4137073b          	subw	a4,a4,s3
 d08:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d0a:	02071693          	slli	a3,a4,0x20
 d0e:	01c6d713          	srli	a4,a3,0x1c
 d12:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d14:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d18:	00000717          	auipc	a4,0x0
 d1c:	74a73c23          	sd	a0,1880(a4) # 1470 <freep>
      return (void*)(p + 1);
 d20:	01078513          	addi	a0,a5,16
  }
}
 d24:	70e2                	ld	ra,56(sp)
 d26:	7442                	ld	s0,48(sp)
 d28:	74a2                	ld	s1,40(sp)
 d2a:	69e2                	ld	s3,24(sp)
 d2c:	6121                	addi	sp,sp,64
 d2e:	8082                	ret
 d30:	7902                	ld	s2,32(sp)
 d32:	6a42                	ld	s4,16(sp)
 d34:	6aa2                	ld	s5,8(sp)
 d36:	6b02                	ld	s6,0(sp)
 d38:	b7f5                	j	d24 <malloc+0xea>
