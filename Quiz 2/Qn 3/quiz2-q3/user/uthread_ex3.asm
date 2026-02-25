
user/_uthread_ex3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_a>:
volatile int a_started, b_started, c_started;
volatile int a_n, b_n, c_n;

void 
thread_a(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;
  printf("thread_a started\n");
   c:	00001517          	auipc	a0,0x1
  10:	cfc50513          	addi	a0,a0,-772 # d08 <malloc+0x104>
  14:	00001097          	auipc	ra,0x1
  18:	b38080e7          	jalr	-1224(ra) # b4c <printf>
  a_started = 1;
  1c:	4785                	li	a5,1
  1e:	00001717          	auipc	a4,0x1
  22:	3cf72323          	sw	a5,966(a4) # 13e4 <a_started>
  while(b_started == 0 || c_started == 0)
  26:	00001497          	auipc	s1,0x1
  2a:	3ba48493          	addi	s1,s1,954 # 13e0 <b_started>
  2e:	00001917          	auipc	s2,0x1
  32:	3ae90913          	addi	s2,s2,942 # 13dc <c_started>
  36:	a029                	j	40 <thread_a+0x40>
    thread_yield();
  38:	00000097          	auipc	ra,0x0
  3c:	494080e7          	jalr	1172(ra) # 4cc <thread_yield>
  while(b_started == 0 || c_started == 0)
  40:	409c                	lw	a5,0(s1)
  42:	2781                	sext.w	a5,a5
  44:	dbf5                	beqz	a5,38 <thread_a+0x38>
  46:	00092783          	lw	a5,0(s2)
  4a:	2781                	sext.w	a5,a5
  4c:	d7f5                	beqz	a5,38 <thread_a+0x38>
  
  
  for (i = 0; i < 3; i++) {
    //printf("thread_a %d\n", i);
    a_n += 1;
  4e:	00001497          	auipc	s1,0x1
  52:	38a48493          	addi	s1,s1,906 # 13d8 <a_n>
  56:	00001797          	auipc	a5,0x1
  5a:	3827a783          	lw	a5,898(a5) # 13d8 <a_n>
  5e:	2785                	addiw	a5,a5,1
  60:	c09c                	sw	a5,0(s1)
    thread_yield();
  62:	00000097          	auipc	ra,0x0
  66:	46a080e7          	jalr	1130(ra) # 4cc <thread_yield>
    a_n += 1;
  6a:	409c                	lw	a5,0(s1)
  6c:	2785                	addiw	a5,a5,1
  6e:	c09c                	sw	a5,0(s1)
    thread_yield();
  70:	00000097          	auipc	ra,0x0
  74:	45c080e7          	jalr	1116(ra) # 4cc <thread_yield>
    a_n += 1;
  78:	409c                	lw	a5,0(s1)
  7a:	2785                	addiw	a5,a5,1
  7c:	c09c                	sw	a5,0(s1)
    thread_yield();
  7e:	00000097          	auipc	ra,0x0
  82:	44e080e7          	jalr	1102(ra) # 4cc <thread_yield>
  }
  printf("thread_a: exit after %d\n", a_n);
  86:	408c                	lw	a1,0(s1)
  88:	00001517          	auipc	a0,0x1
  8c:	c9850513          	addi	a0,a0,-872 # d20 <malloc+0x11c>
  90:	00001097          	auipc	ra,0x1
  94:	abc080e7          	jalr	-1348(ra) # b4c <printf>
  thread_sleep();
  98:	00000097          	auipc	ra,0x0
  9c:	3c8080e7          	jalr	968(ra) # 460 <thread_sleep>
  current_thread->state = FREE;
  a0:	00001797          	auipc	a5,0x1
  a4:	3487b783          	ld	a5,840(a5) # 13e8 <current_thread>
  a8:	6709                	lui	a4,0x2
  aa:	97ba                	add	a5,a5,a4
  ac:	0007a023          	sw	zero,0(a5)
  thread_schedule();
  b0:	00000097          	auipc	ra,0x0
  b4:	2b4080e7          	jalr	692(ra) # 364 <thread_schedule>
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	addi	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <thread_b>:

void 
thread_b(void)
{
  c4:	1101                	addi	sp,sp,-32
  c6:	ec06                	sd	ra,24(sp)
  c8:	e822                	sd	s0,16(sp)
  ca:	e426                	sd	s1,8(sp)
  cc:	e04a                	sd	s2,0(sp)
  ce:	1000                	addi	s0,sp,32
  int i;
  printf("thread_b started\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	c7050513          	addi	a0,a0,-912 # d40 <malloc+0x13c>
  d8:	00001097          	auipc	ra,0x1
  dc:	a74080e7          	jalr	-1420(ra) # b4c <printf>
  b_started = 1;
  e0:	4785                	li	a5,1
  e2:	00001717          	auipc	a4,0x1
  e6:	2ef72f23          	sw	a5,766(a4) # 13e0 <b_started>
  while(a_started == 0 || c_started == 0)
  ea:	00001497          	auipc	s1,0x1
  ee:	2fa48493          	addi	s1,s1,762 # 13e4 <a_started>
  f2:	00001917          	auipc	s2,0x1
  f6:	2ea90913          	addi	s2,s2,746 # 13dc <c_started>
  fa:	a029                	j	104 <thread_b+0x40>
    thread_yield();
  fc:	00000097          	auipc	ra,0x0
 100:	3d0080e7          	jalr	976(ra) # 4cc <thread_yield>
  while(a_started == 0 || c_started == 0)
 104:	409c                	lw	a5,0(s1)
 106:	2781                	sext.w	a5,a5
 108:	dbf5                	beqz	a5,fc <thread_b+0x38>
 10a:	00092783          	lw	a5,0(s2)
 10e:	2781                	sext.w	a5,a5
 110:	d7f5                	beqz	a5,fc <thread_b+0x38>
  
  thread_sleep();
 112:	00000097          	auipc	ra,0x0
 116:	34e080e7          	jalr	846(ra) # 460 <thread_sleep>
  for (i = 0; i < 3; i++) {
    //printf("thread_b %d\n", i);
    b_n += 1;
 11a:	00001497          	auipc	s1,0x1
 11e:	2ba48493          	addi	s1,s1,698 # 13d4 <b_n>
 122:	00001797          	auipc	a5,0x1
 126:	2b27a783          	lw	a5,690(a5) # 13d4 <b_n>
 12a:	2785                	addiw	a5,a5,1
 12c:	c09c                	sw	a5,0(s1)
    thread_yield();
 12e:	00000097          	auipc	ra,0x0
 132:	39e080e7          	jalr	926(ra) # 4cc <thread_yield>
    b_n += 1;
 136:	409c                	lw	a5,0(s1)
 138:	2785                	addiw	a5,a5,1
 13a:	c09c                	sw	a5,0(s1)
    thread_yield();
 13c:	00000097          	auipc	ra,0x0
 140:	390080e7          	jalr	912(ra) # 4cc <thread_yield>
    b_n += 1;
 144:	409c                	lw	a5,0(s1)
 146:	2785                	addiw	a5,a5,1
 148:	c09c                	sw	a5,0(s1)
    thread_yield();
 14a:	00000097          	auipc	ra,0x0
 14e:	382080e7          	jalr	898(ra) # 4cc <thread_yield>
  }
  printf("thread_b: exit after %d\n", b_n);
 152:	408c                	lw	a1,0(s1)
 154:	00001517          	auipc	a0,0x1
 158:	c0450513          	addi	a0,a0,-1020 # d58 <malloc+0x154>
 15c:	00001097          	auipc	ra,0x1
 160:	9f0080e7          	jalr	-1552(ra) # b4c <printf>
  current_thread->state = FREE;
 164:	00001797          	auipc	a5,0x1
 168:	2847b783          	ld	a5,644(a5) # 13e8 <current_thread>
 16c:	6709                	lui	a4,0x2
 16e:	97ba                	add	a5,a5,a4
 170:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 174:	00000097          	auipc	ra,0x0
 178:	1f0080e7          	jalr	496(ra) # 364 <thread_schedule>
}
 17c:	60e2                	ld	ra,24(sp)
 17e:	6442                	ld	s0,16(sp)
 180:	64a2                	ld	s1,8(sp)
 182:	6902                	ld	s2,0(sp)
 184:	6105                	addi	sp,sp,32
 186:	8082                	ret

0000000000000188 <thread_c>:

void 
thread_c(void)
{
 188:	1101                	addi	sp,sp,-32
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e426                	sd	s1,8(sp)
 190:	e04a                	sd	s2,0(sp)
 192:	1000                	addi	s0,sp,32
  int i;
  printf("thread_c started\n");
 194:	00001517          	auipc	a0,0x1
 198:	be450513          	addi	a0,a0,-1052 # d78 <malloc+0x174>
 19c:	00001097          	auipc	ra,0x1
 1a0:	9b0080e7          	jalr	-1616(ra) # b4c <printf>
  c_started = 1;
 1a4:	4785                	li	a5,1
 1a6:	00001717          	auipc	a4,0x1
 1aa:	22f72b23          	sw	a5,566(a4) # 13dc <c_started>
  while(a_started == 0 || b_started == 0)
 1ae:	00001497          	auipc	s1,0x1
 1b2:	23648493          	addi	s1,s1,566 # 13e4 <a_started>
 1b6:	00001917          	auipc	s2,0x1
 1ba:	22a90913          	addi	s2,s2,554 # 13e0 <b_started>
 1be:	a029                	j	1c8 <thread_c+0x40>
    thread_yield();
 1c0:	00000097          	auipc	ra,0x0
 1c4:	30c080e7          	jalr	780(ra) # 4cc <thread_yield>
  while(a_started == 0 || b_started == 0)
 1c8:	409c                	lw	a5,0(s1)
 1ca:	2781                	sext.w	a5,a5
 1cc:	dbf5                	beqz	a5,1c0 <thread_c+0x38>
 1ce:	00092783          	lw	a5,0(s2)
 1d2:	2781                	sext.w	a5,a5
 1d4:	d7f5                	beqz	a5,1c0 <thread_c+0x38>
  thread_sleep();
 1d6:	00000097          	auipc	ra,0x0
 1da:	28a080e7          	jalr	650(ra) # 460 <thread_sleep>
  for (i = 0; i < 3; i++) {
    //printf("thread_c %d\n", i);
    c_n += 1;
 1de:	00001497          	auipc	s1,0x1
 1e2:	1f248493          	addi	s1,s1,498 # 13d0 <c_n>
 1e6:	00001797          	auipc	a5,0x1
 1ea:	1ea7a783          	lw	a5,490(a5) # 13d0 <c_n>
 1ee:	2785                	addiw	a5,a5,1
 1f0:	c09c                	sw	a5,0(s1)
    thread_yield();
 1f2:	00000097          	auipc	ra,0x0
 1f6:	2da080e7          	jalr	730(ra) # 4cc <thread_yield>
    c_n += 1;
 1fa:	409c                	lw	a5,0(s1)
 1fc:	2785                	addiw	a5,a5,1
 1fe:	c09c                	sw	a5,0(s1)
    thread_yield();
 200:	00000097          	auipc	ra,0x0
 204:	2cc080e7          	jalr	716(ra) # 4cc <thread_yield>
    c_n += 1;
 208:	409c                	lw	a5,0(s1)
 20a:	2785                	addiw	a5,a5,1
 20c:	c09c                	sw	a5,0(s1)
    thread_yield();
 20e:	00000097          	auipc	ra,0x0
 212:	2be080e7          	jalr	702(ra) # 4cc <thread_yield>
  }
  thread_sleep();
 216:	00000097          	auipc	ra,0x0
 21a:	24a080e7          	jalr	586(ra) # 460 <thread_sleep>
  printf("thread_c: exit after %d\n", c_n);
 21e:	408c                	lw	a1,0(s1)
 220:	00001517          	auipc	a0,0x1
 224:	b7050513          	addi	a0,a0,-1168 # d90 <malloc+0x18c>
 228:	00001097          	auipc	ra,0x1
 22c:	924080e7          	jalr	-1756(ra) # b4c <printf>

  current_thread->state = FREE;
 230:	00001797          	auipc	a5,0x1
 234:	1b87b783          	ld	a5,440(a5) # 13e8 <current_thread>
 238:	6709                	lui	a4,0x2
 23a:	97ba                	add	a5,a5,a4
 23c:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 240:	00000097          	auipc	ra,0x0
 244:	124080e7          	jalr	292(ra) # 364 <thread_schedule>
}
 248:	60e2                	ld	ra,24(sp)
 24a:	6442                	ld	s0,16(sp)
 24c:	64a2                	ld	s1,8(sp)
 24e:	6902                	ld	s2,0(sp)
 250:	6105                	addi	sp,sp,32
 252:	8082                	ret

0000000000000254 <main>:

int 
main(int argc, char *argv[]) 
{
 254:	1141                	addi	sp,sp,-16
 256:	e406                	sd	ra,8(sp)
 258:	e022                	sd	s0,0(sp)
 25a:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 25c:	00001797          	auipc	a5,0x1
 260:	1807a023          	sw	zero,384(a5) # 13dc <c_started>
 264:	00001797          	auipc	a5,0x1
 268:	1607ae23          	sw	zero,380(a5) # 13e0 <b_started>
 26c:	00001797          	auipc	a5,0x1
 270:	1607ac23          	sw	zero,376(a5) # 13e4 <a_started>
  a_n = b_n = c_n = 0;
 274:	00001797          	auipc	a5,0x1
 278:	1407ae23          	sw	zero,348(a5) # 13d0 <c_n>
 27c:	00001797          	auipc	a5,0x1
 280:	1407ac23          	sw	zero,344(a5) # 13d4 <b_n>
 284:	00001797          	auipc	a5,0x1
 288:	1407aa23          	sw	zero,340(a5) # 13d8 <a_n>
  thread_init();
 28c:	00000097          	auipc	ra,0x0
 290:	05a080e7          	jalr	90(ra) # 2e6 <thread_init>
  thread_create(thread_a);
 294:	00000517          	auipc	a0,0x0
 298:	d6c50513          	addi	a0,a0,-660 # 0 <thread_a>
 29c:	00000097          	auipc	ra,0x0
 2a0:	1ec080e7          	jalr	492(ra) # 488 <thread_create>
  thread_create(thread_b);
 2a4:	00000517          	auipc	a0,0x0
 2a8:	e2050513          	addi	a0,a0,-480 # c4 <thread_b>
 2ac:	00000097          	auipc	ra,0x0
 2b0:	1dc080e7          	jalr	476(ra) # 488 <thread_create>
  thread_create(thread_c);
 2b4:	00000517          	auipc	a0,0x0
 2b8:	ed450513          	addi	a0,a0,-300 # 188 <thread_c>
 2bc:	00000097          	auipc	ra,0x0
 2c0:	1cc080e7          	jalr	460(ra) # 488 <thread_create>
  current_thread->state = FREE;
 2c4:	00001797          	auipc	a5,0x1
 2c8:	1247b783          	ld	a5,292(a5) # 13e8 <current_thread>
 2cc:	6709                	lui	a4,0x2
 2ce:	97ba                	add	a5,a5,a4
 2d0:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 2d4:	00000097          	auipc	ra,0x0
 2d8:	090080e7          	jalr	144(ra) # 364 <thread_schedule>
  exit(0);
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	506080e7          	jalr	1286(ra) # 7e4 <exit>

00000000000002e6 <thread_init>:
struct thread *current_thread;

              
void 
thread_init(void)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  // main() is thread 0, which will make the first invocation to
  // thread_schedule(). It needs a stack so that the first thread_switch() can
  // save thread 0's state.
  current_thread = &all_thread[0];
 2ec:	00001797          	auipc	a5,0x1
 2f0:	10c78793          	addi	a5,a5,268 # 13f8 <all_thread>
 2f4:	00001717          	auipc	a4,0x1
 2f8:	0ef73a23          	sd	a5,244(a4) # 13e8 <current_thread>
  current_thread->state = RUNNING;
 2fc:	4785                	li	a5,1
 2fe:	00003717          	auipc	a4,0x3
 302:	0ef72d23          	sw	a5,250(a4) # 33f8 <__global_pointer$+0x182c>
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <thread_wakeup>:
  thread_schedule();
}

int 
thread_wakeup(int thread_id)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
  //add your code here
  struct thread *wake_thread = &all_thread[thread_id];
  if (thread_id < 0 || thread_id >= MAX_THREAD){
 312:	478d                	li	a5,3
 314:	04a7e463          	bltu	a5,a0,35c <thread_wakeup+0x50>
    return -1;
  }

  if (wake_thread->state != SLEEPING){
 318:	6789                	lui	a5,0x2
 31a:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x4ac>
 31e:	02f507b3          	mul	a5,a0,a5
 322:	00001697          	auipc	a3,0x1
 326:	0d668693          	addi	a3,a3,214 # 13f8 <all_thread>
 32a:	96be                	add	a3,a3,a5
 32c:	6789                	lui	a5,0x2
 32e:	97b6                	add	a5,a5,a3
 330:	4394                	lw	a3,0(a5)
 332:	478d                	li	a5,3
 334:	02f69663          	bne	a3,a5,360 <thread_wakeup+0x54>
    return -1;
  }

  wake_thread->state = RUNNABLE;
 338:	6789                	lui	a5,0x2
 33a:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x4ac>
 33e:	02f50733          	mul	a4,a0,a5
 342:	00001797          	auipc	a5,0x1
 346:	0b678793          	addi	a5,a5,182 # 13f8 <all_thread>
 34a:	973e                	add	a4,a4,a5
 34c:	6789                	lui	a5,0x2
 34e:	97ba                	add	a5,a5,a4
 350:	4709                	li	a4,2
 352:	c398                	sw	a4,0(a5)
  return 0;
 354:	4501                	li	a0,0
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret
    return -1;
 35c:	557d                	li	a0,-1
 35e:	bfe5                	j	356 <thread_wakeup+0x4a>
    return -1;
 360:	557d                	li	a0,-1
 362:	bfd5                	j	356 <thread_wakeup+0x4a>

0000000000000364 <thread_schedule>:

void thread_schedule(void)
{
 364:	1101                	addi	sp,sp,-32
 366:	ec06                	sd	ra,24(sp)
 368:	e822                	sd	s0,16(sp)
 36a:	e426                	sd	s1,8(sp)
 36c:	1000                	addi	s0,sp,32
  struct thread *t, *next_thread;
  int sleeping_thread = 0;
  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
 36e:	6789                	lui	a5,0x2
 370:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x4ac>
 374:	00001597          	auipc	a1,0x1
 378:	0745b583          	ld	a1,116(a1) # 13e8 <current_thread>
 37c:	95be                	add	a1,a1,a5
 37e:	4791                	li	a5,4
  int sleeping_thread = 0;
 380:	4481                	li	s1,0
  for(int i = 0; i < MAX_THREAD; i++){
    if(t >= all_thread + MAX_THREAD)
 382:	00009817          	auipc	a6,0x9
 386:	25680813          	addi	a6,a6,598 # 95d8 <base>
      t = all_thread;
    if(t->state == RUNNABLE) {
 38a:	6509                	lui	a0,0x2
 38c:	4609                	li	a2,2
      next_thread = t;
      break;
    }
    //add code to identify that there are sleeping threads
    if(t->state == SLEEPING) {
 38e:	488d                	li	a7,3
      sleeping_thread = 1;
 390:	4305                	li	t1,1
    }
    t = t + 1;
 392:	6689                	lui	a3,0x2
 394:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x4ac>
 398:	a819                	j	3ae <thread_schedule+0x4a>
    if(t->state == RUNNABLE) {
 39a:	00a58733          	add	a4,a1,a0
 39e:	4318                	lw	a4,0(a4)
 3a0:	04c70d63          	beq	a4,a2,3fa <thread_schedule+0x96>
    if(t->state == SLEEPING) {
 3a4:	01170c63          	beq	a4,a7,3bc <thread_schedule+0x58>
    t = t + 1;
 3a8:	95b6                	add	a1,a1,a3
  for(int i = 0; i < MAX_THREAD; i++){
 3aa:	37fd                	addiw	a5,a5,-1
 3ac:	c3d1                	beqz	a5,430 <thread_schedule+0xcc>
    if(t >= all_thread + MAX_THREAD)
 3ae:	ff05e6e3          	bltu	a1,a6,39a <thread_schedule+0x36>
      t = all_thread;
 3b2:	00001597          	auipc	a1,0x1
 3b6:	04658593          	addi	a1,a1,70 # 13f8 <all_thread>
 3ba:	b7c5                	j	39a <thread_schedule+0x36>
      sleeping_thread = 1;
 3bc:	849a                	mv	s1,t1
 3be:	b7ed                	j	3a8 <thread_schedule+0x44>
        if(first_sleep == 0){
          all_thread[i].state = RUNNING;
          next_thread = &all_thread[i];
          first_sleep = 1;
        } else {
          all_thread[i].state = RUNNABLE;
 3c0:	4709                	li	a4,2
 3c2:	c398                	sw	a4,0(a5)
      for(int i = 0; i < MAX_THREAD; i++){ 
 3c4:	97b6                	add	a5,a5,a3
 3c6:	03078a63          	beq	a5,a6,3fa <thread_schedule+0x96>
        if(all_thread[i].state == SLEEPING){
 3ca:	4398                	lw	a4,0(a5)
 3cc:	fea71ce3          	bne	a4,a0,3c4 <thread_schedule+0x60>
        if(first_sleep == 0){
 3d0:	fe0898e3          	bnez	a7,3c0 <thread_schedule+0x5c>
          all_thread[i].state = RUNNING;
 3d4:	4705                	li	a4,1
 3d6:	c398                	sw	a4,0(a5)
          next_thread = &all_thread[i];
 3d8:	75f9                	lui	a1,0xffffe
 3da:	95be                	add	a1,a1,a5
          first_sleep = 1;
 3dc:	88a6                	mv	a7,s1
 3de:	b7dd                	j	3c4 <thread_schedule+0x60>

      }
      }
    }
    else{
      printf("thread_schedule: no runnable threads\n");
 3e0:	00001517          	auipc	a0,0x1
 3e4:	9f850513          	addi	a0,a0,-1544 # dd8 <malloc+0x1d4>
 3e8:	00000097          	auipc	ra,0x0
 3ec:	764080e7          	jalr	1892(ra) # b4c <printf>
      exit(-1);
 3f0:	557d                	li	a0,-1
 3f2:	00000097          	auipc	ra,0x0
 3f6:	3f2080e7          	jalr	1010(ra) # 7e4 <exit>
    }
  }

  if (current_thread != next_thread) {         /* switch threads?  */
 3fa:	00001517          	auipc	a0,0x1
 3fe:	fee53503          	ld	a0,-18(a0) # 13e8 <current_thread>
 402:	02b50263          	beq	a0,a1,426 <thread_schedule+0xc2>
    next_thread->state = RUNNING;
 406:	6789                	lui	a5,0x2
 408:	97ae                	add	a5,a5,a1
 40a:	4705                	li	a4,1
 40c:	c398                	sw	a4,0(a5)
    t = current_thread;
    current_thread = next_thread;
 40e:	00001797          	auipc	a5,0x1
 412:	fcb7bd23          	sd	a1,-38(a5) # 13e8 <current_thread>
    thread_switch(&t->context, &current_thread->context);
 416:	6789                	lui	a5,0x2
 418:	07a1                	addi	a5,a5,8 # 2008 <__global_pointer$+0x43c>
 41a:	95be                	add	a1,a1,a5
 41c:	953e                	add	a0,a0,a5
 41e:	00000097          	auipc	ra,0x0
 422:	0d6080e7          	jalr	214(ra) # 4f4 <thread_switch>
  } else
    next_thread = 0;
}
 426:	60e2                	ld	ra,24(sp)
 428:	6442                	ld	s0,16(sp)
 42a:	64a2                	ld	s1,8(sp)
 42c:	6105                	addi	sp,sp,32
 42e:	8082                	ret
    if (sleeping_thread == 1){
 430:	d8c5                	beqz	s1,3e0 <thread_schedule+0x7c>
      printf("only thread sleepings, wake them all\n");
 432:	00001517          	auipc	a0,0x1
 436:	97e50513          	addi	a0,a0,-1666 # db0 <malloc+0x1ac>
 43a:	00000097          	auipc	ra,0x0
 43e:	712080e7          	jalr	1810(ra) # b4c <printf>
      for(int i = 0; i < MAX_THREAD; i++){ 
 442:	00003797          	auipc	a5,0x3
 446:	fb678793          	addi	a5,a5,-74 # 33f8 <__global_pointer$+0x182c>
 44a:	0000b817          	auipc	a6,0xb
 44e:	18e80813          	addi	a6,a6,398 # b5d8 <__BSS_END__+0x1ff0>
      int first_sleep = 0;
 452:	4881                	li	a7,0
      printf("only thread sleepings, wake them all\n");
 454:	4581                	li	a1,0
        if(all_thread[i].state == SLEEPING){
 456:	450d                	li	a0,3
      for(int i = 0; i < MAX_THREAD; i++){ 
 458:	6689                	lui	a3,0x2
 45a:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x4ac>
 45e:	b7b5                	j	3ca <thread_schedule+0x66>

0000000000000460 <thread_sleep>:
{
 460:	1141                	addi	sp,sp,-16
 462:	e406                	sd	ra,8(sp)
 464:	e022                	sd	s0,0(sp)
 466:	0800                	addi	s0,sp,16
  current_thread->state = SLEEPING;
 468:	00001797          	auipc	a5,0x1
 46c:	f807b783          	ld	a5,-128(a5) # 13e8 <current_thread>
 470:	6709                	lui	a4,0x2
 472:	97ba                	add	a5,a5,a4
 474:	470d                	li	a4,3
 476:	c398                	sw	a4,0(a5)
  thread_schedule();
 478:	00000097          	auipc	ra,0x0
 47c:	eec080e7          	jalr	-276(ra) # 364 <thread_schedule>
}
 480:	60a2                	ld	ra,8(sp)
 482:	6402                	ld	s0,0(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret

0000000000000488 <thread_create>:

void 
thread_create(void (*func)())
{
 488:	1141                	addi	sp,sp,-16
 48a:	e422                	sd	s0,8(sp)
 48c:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 48e:	00001797          	auipc	a5,0x1
 492:	f6a78793          	addi	a5,a5,-150 # 13f8 <all_thread>
    if (t->state == FREE) break;
 496:	6609                	lui	a2,0x2
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 498:	6689                	lui	a3,0x2
 49a:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x4ac>
 49e:	00009597          	auipc	a1,0x9
 4a2:	13a58593          	addi	a1,a1,314 # 95d8 <base>
    if (t->state == FREE) break;
 4a6:	00c78733          	add	a4,a5,a2
 4aa:	4318                	lw	a4,0(a4)
 4ac:	c701                	beqz	a4,4b4 <thread_create+0x2c>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4ae:	97b6                	add	a5,a5,a3
 4b0:	feb79be3          	bne	a5,a1,4a6 <thread_create+0x1e>
  }
  t->state = RUNNABLE;
 4b4:	6709                	lui	a4,0x2
 4b6:	00e786b3          	add	a3,a5,a4
 4ba:	4609                	li	a2,2
 4bc:	c290                	sw	a2,0(a3)
  t->context.sp = (uint64)&t->stack[STACK_SIZE-1];
 4be:	177d                	addi	a4,a4,-1 # 1fff <__global_pointer$+0x433>
 4c0:	97ba                	add	a5,a5,a4
 4c2:	ea9c                	sd	a5,16(a3)
  t->context.ra = (uint64)(*func);
 4c4:	e688                	sd	a0,8(a3)
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <thread_yield>:

void 
thread_yield(void)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
 4d4:	00001797          	auipc	a5,0x1
 4d8:	f147b783          	ld	a5,-236(a5) # 13e8 <current_thread>
 4dc:	6709                	lui	a4,0x2
 4de:	97ba                	add	a5,a5,a4
 4e0:	4709                	li	a4,2
 4e2:	c398                	sw	a4,0(a5)
  thread_schedule();
 4e4:	00000097          	auipc	ra,0x0
 4e8:	e80080e7          	jalr	-384(ra) # 364 <thread_schedule>
}
 4ec:	60a2                	ld	ra,8(sp)
 4ee:	6402                	ld	s0,0(sp)
 4f0:	0141                	addi	sp,sp,16
 4f2:	8082                	ret

00000000000004f4 <thread_switch>:
         */

	.globl thread_switch
thread_switch:
	# Save old thread context (a0 = old, a1 = new).
	sd ra, 0(a0)
 4f4:	00153023          	sd	ra,0(a0)
	sd sp, 8(a0)
 4f8:	00253423          	sd	sp,8(a0)
	sd s0, 16(a0)
 4fc:	e900                	sd	s0,16(a0)
	sd s1, 24(a0)
 4fe:	ed04                	sd	s1,24(a0)
	sd s2, 32(a0)
 500:	03253023          	sd	s2,32(a0)
	sd s3, 40(a0)
 504:	03353423          	sd	s3,40(a0)
	sd s4, 48(a0)
 508:	03453823          	sd	s4,48(a0)
	sd s5, 56(a0)
 50c:	03553c23          	sd	s5,56(a0)
	sd s6, 64(a0)
 510:	05653023          	sd	s6,64(a0)
	sd s7, 72(a0)
 514:	05753423          	sd	s7,72(a0)
	sd s8, 80(a0)
 518:	05853823          	sd	s8,80(a0)
	sd s9, 88(a0)
 51c:	05953c23          	sd	s9,88(a0)
	sd s10, 96(a0)
 520:	07a53023          	sd	s10,96(a0)
	sd s11, 104(a0)
 524:	07b53423          	sd	s11,104(a0)

	# Restore new thread context.
	ld ra, 0(a1)
 528:	0005b083          	ld	ra,0(a1)
	ld sp, 8(a1)
 52c:	0085b103          	ld	sp,8(a1)
	ld s0, 16(a1)
 530:	6980                	ld	s0,16(a1)
	ld s1, 24(a1)
 532:	6d84                	ld	s1,24(a1)
	ld s2, 32(a1)
 534:	0205b903          	ld	s2,32(a1)
	ld s3, 40(a1)
 538:	0285b983          	ld	s3,40(a1)
	ld s4, 48(a1)
 53c:	0305ba03          	ld	s4,48(a1)
	ld s5, 56(a1)
 540:	0385ba83          	ld	s5,56(a1)
	ld s6, 64(a1)
 544:	0405bb03          	ld	s6,64(a1)
	ld s7, 72(a1)
 548:	0485bb83          	ld	s7,72(a1)
	ld s8, 80(a1)
 54c:	0505bc03          	ld	s8,80(a1)
	ld s9, 88(a1)
 550:	0585bc83          	ld	s9,88(a1)
	ld s10, 96(a1)
 554:	0605bd03          	ld	s10,96(a1)
	ld s11, 104(a1)
 558:	0685bd83          	ld	s11,104(a1)
	ret    /* return to ra */
 55c:	8082                	ret

000000000000055e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 55e:	1141                	addi	sp,sp,-16
 560:	e406                	sd	ra,8(sp)
 562:	e022                	sd	s0,0(sp)
 564:	0800                	addi	s0,sp,16
  extern int main();
  main();
 566:	00000097          	auipc	ra,0x0
 56a:	cee080e7          	jalr	-786(ra) # 254 <main>
  exit(0);
 56e:	4501                	li	a0,0
 570:	00000097          	auipc	ra,0x0
 574:	274080e7          	jalr	628(ra) # 7e4 <exit>

0000000000000578 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 578:	1141                	addi	sp,sp,-16
 57a:	e422                	sd	s0,8(sp)
 57c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 57e:	87aa                	mv	a5,a0
 580:	0585                	addi	a1,a1,1
 582:	0785                	addi	a5,a5,1
 584:	fff5c703          	lbu	a4,-1(a1)
 588:	fee78fa3          	sb	a4,-1(a5)
 58c:	fb75                	bnez	a4,580 <strcpy+0x8>
    ;
  return os;
}
 58e:	6422                	ld	s0,8(sp)
 590:	0141                	addi	sp,sp,16
 592:	8082                	ret

0000000000000594 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 594:	1141                	addi	sp,sp,-16
 596:	e422                	sd	s0,8(sp)
 598:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 59a:	00054783          	lbu	a5,0(a0)
 59e:	cb91                	beqz	a5,5b2 <strcmp+0x1e>
 5a0:	0005c703          	lbu	a4,0(a1)
 5a4:	00f71763          	bne	a4,a5,5b2 <strcmp+0x1e>
    p++, q++;
 5a8:	0505                	addi	a0,a0,1
 5aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5ac:	00054783          	lbu	a5,0(a0)
 5b0:	fbe5                	bnez	a5,5a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5b2:	0005c503          	lbu	a0,0(a1)
}
 5b6:	40a7853b          	subw	a0,a5,a0
 5ba:	6422                	ld	s0,8(sp)
 5bc:	0141                	addi	sp,sp,16
 5be:	8082                	ret

00000000000005c0 <strlen>:

uint
strlen(const char *s)
{
 5c0:	1141                	addi	sp,sp,-16
 5c2:	e422                	sd	s0,8(sp)
 5c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5c6:	00054783          	lbu	a5,0(a0)
 5ca:	cf91                	beqz	a5,5e6 <strlen+0x26>
 5cc:	0505                	addi	a0,a0,1
 5ce:	87aa                	mv	a5,a0
 5d0:	86be                	mv	a3,a5
 5d2:	0785                	addi	a5,a5,1
 5d4:	fff7c703          	lbu	a4,-1(a5)
 5d8:	ff65                	bnez	a4,5d0 <strlen+0x10>
 5da:	40a6853b          	subw	a0,a3,a0
 5de:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 5e0:	6422                	ld	s0,8(sp)
 5e2:	0141                	addi	sp,sp,16
 5e4:	8082                	ret
  for(n = 0; s[n]; n++)
 5e6:	4501                	li	a0,0
 5e8:	bfe5                	j	5e0 <strlen+0x20>

00000000000005ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 5ea:	1141                	addi	sp,sp,-16
 5ec:	e422                	sd	s0,8(sp)
 5ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 5f0:	ca19                	beqz	a2,606 <memset+0x1c>
 5f2:	87aa                	mv	a5,a0
 5f4:	1602                	slli	a2,a2,0x20
 5f6:	9201                	srli	a2,a2,0x20
 5f8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 5fc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 600:	0785                	addi	a5,a5,1
 602:	fee79de3          	bne	a5,a4,5fc <memset+0x12>
  }
  return dst;
}
 606:	6422                	ld	s0,8(sp)
 608:	0141                	addi	sp,sp,16
 60a:	8082                	ret

000000000000060c <strchr>:

char*
strchr(const char *s, char c)
{
 60c:	1141                	addi	sp,sp,-16
 60e:	e422                	sd	s0,8(sp)
 610:	0800                	addi	s0,sp,16
  for(; *s; s++)
 612:	00054783          	lbu	a5,0(a0)
 616:	cb99                	beqz	a5,62c <strchr+0x20>
    if(*s == c)
 618:	00f58763          	beq	a1,a5,626 <strchr+0x1a>
  for(; *s; s++)
 61c:	0505                	addi	a0,a0,1
 61e:	00054783          	lbu	a5,0(a0)
 622:	fbfd                	bnez	a5,618 <strchr+0xc>
      return (char*)s;
  return 0;
 624:	4501                	li	a0,0
}
 626:	6422                	ld	s0,8(sp)
 628:	0141                	addi	sp,sp,16
 62a:	8082                	ret
  return 0;
 62c:	4501                	li	a0,0
 62e:	bfe5                	j	626 <strchr+0x1a>

0000000000000630 <gets>:

char*
gets(char *buf, int max)
{
 630:	711d                	addi	sp,sp,-96
 632:	ec86                	sd	ra,88(sp)
 634:	e8a2                	sd	s0,80(sp)
 636:	e4a6                	sd	s1,72(sp)
 638:	e0ca                	sd	s2,64(sp)
 63a:	fc4e                	sd	s3,56(sp)
 63c:	f852                	sd	s4,48(sp)
 63e:	f456                	sd	s5,40(sp)
 640:	f05a                	sd	s6,32(sp)
 642:	ec5e                	sd	s7,24(sp)
 644:	1080                	addi	s0,sp,96
 646:	8baa                	mv	s7,a0
 648:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 64a:	892a                	mv	s2,a0
 64c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 64e:	4aa9                	li	s5,10
 650:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 652:	89a6                	mv	s3,s1
 654:	2485                	addiw	s1,s1,1
 656:	0344d863          	bge	s1,s4,686 <gets+0x56>
    cc = read(0, &c, 1);
 65a:	4605                	li	a2,1
 65c:	faf40593          	addi	a1,s0,-81
 660:	4501                	li	a0,0
 662:	00000097          	auipc	ra,0x0
 666:	19a080e7          	jalr	410(ra) # 7fc <read>
    if(cc < 1)
 66a:	00a05e63          	blez	a0,686 <gets+0x56>
    buf[i++] = c;
 66e:	faf44783          	lbu	a5,-81(s0)
 672:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 676:	01578763          	beq	a5,s5,684 <gets+0x54>
 67a:	0905                	addi	s2,s2,1
 67c:	fd679be3          	bne	a5,s6,652 <gets+0x22>
    buf[i++] = c;
 680:	89a6                	mv	s3,s1
 682:	a011                	j	686 <gets+0x56>
 684:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 686:	99de                	add	s3,s3,s7
 688:	00098023          	sb	zero,0(s3)
  return buf;
}
 68c:	855e                	mv	a0,s7
 68e:	60e6                	ld	ra,88(sp)
 690:	6446                	ld	s0,80(sp)
 692:	64a6                	ld	s1,72(sp)
 694:	6906                	ld	s2,64(sp)
 696:	79e2                	ld	s3,56(sp)
 698:	7a42                	ld	s4,48(sp)
 69a:	7aa2                	ld	s5,40(sp)
 69c:	7b02                	ld	s6,32(sp)
 69e:	6be2                	ld	s7,24(sp)
 6a0:	6125                	addi	sp,sp,96
 6a2:	8082                	ret

00000000000006a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 6a4:	1101                	addi	sp,sp,-32
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	e04a                	sd	s2,0(sp)
 6ac:	1000                	addi	s0,sp,32
 6ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6b0:	4581                	li	a1,0
 6b2:	00000097          	auipc	ra,0x0
 6b6:	172080e7          	jalr	370(ra) # 824 <open>
  if(fd < 0)
 6ba:	02054663          	bltz	a0,6e6 <stat+0x42>
 6be:	e426                	sd	s1,8(sp)
 6c0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6c2:	85ca                	mv	a1,s2
 6c4:	00000097          	auipc	ra,0x0
 6c8:	178080e7          	jalr	376(ra) # 83c <fstat>
 6cc:	892a                	mv	s2,a0
  close(fd);
 6ce:	8526                	mv	a0,s1
 6d0:	00000097          	auipc	ra,0x0
 6d4:	13c080e7          	jalr	316(ra) # 80c <close>
  return r;
 6d8:	64a2                	ld	s1,8(sp)
}
 6da:	854a                	mv	a0,s2
 6dc:	60e2                	ld	ra,24(sp)
 6de:	6442                	ld	s0,16(sp)
 6e0:	6902                	ld	s2,0(sp)
 6e2:	6105                	addi	sp,sp,32
 6e4:	8082                	ret
    return -1;
 6e6:	597d                	li	s2,-1
 6e8:	bfcd                	j	6da <stat+0x36>

00000000000006ea <atoi>:

int
atoi(const char *s)
{
 6ea:	1141                	addi	sp,sp,-16
 6ec:	e422                	sd	s0,8(sp)
 6ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6f0:	00054683          	lbu	a3,0(a0)
 6f4:	fd06879b          	addiw	a5,a3,-48
 6f8:	0ff7f793          	zext.b	a5,a5
 6fc:	4625                	li	a2,9
 6fe:	02f66863          	bltu	a2,a5,72e <atoi+0x44>
 702:	872a                	mv	a4,a0
  n = 0;
 704:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 706:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0x435>
 708:	0025179b          	slliw	a5,a0,0x2
 70c:	9fa9                	addw	a5,a5,a0
 70e:	0017979b          	slliw	a5,a5,0x1
 712:	9fb5                	addw	a5,a5,a3
 714:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 718:	00074683          	lbu	a3,0(a4)
 71c:	fd06879b          	addiw	a5,a3,-48
 720:	0ff7f793          	zext.b	a5,a5
 724:	fef671e3          	bgeu	a2,a5,706 <atoi+0x1c>
  return n;
}
 728:	6422                	ld	s0,8(sp)
 72a:	0141                	addi	sp,sp,16
 72c:	8082                	ret
  n = 0;
 72e:	4501                	li	a0,0
 730:	bfe5                	j	728 <atoi+0x3e>

0000000000000732 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 732:	1141                	addi	sp,sp,-16
 734:	e422                	sd	s0,8(sp)
 736:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 738:	02b57463          	bgeu	a0,a1,760 <memmove+0x2e>
    while(n-- > 0)
 73c:	00c05f63          	blez	a2,75a <memmove+0x28>
 740:	1602                	slli	a2,a2,0x20
 742:	9201                	srli	a2,a2,0x20
 744:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 748:	872a                	mv	a4,a0
      *dst++ = *src++;
 74a:	0585                	addi	a1,a1,1
 74c:	0705                	addi	a4,a4,1
 74e:	fff5c683          	lbu	a3,-1(a1)
 752:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 756:	fef71ae3          	bne	a4,a5,74a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 75a:	6422                	ld	s0,8(sp)
 75c:	0141                	addi	sp,sp,16
 75e:	8082                	ret
    dst += n;
 760:	00c50733          	add	a4,a0,a2
    src += n;
 764:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 766:	fec05ae3          	blez	a2,75a <memmove+0x28>
 76a:	fff6079b          	addiw	a5,a2,-1 # 1fff <__global_pointer$+0x433>
 76e:	1782                	slli	a5,a5,0x20
 770:	9381                	srli	a5,a5,0x20
 772:	fff7c793          	not	a5,a5
 776:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 778:	15fd                	addi	a1,a1,-1
 77a:	177d                	addi	a4,a4,-1
 77c:	0005c683          	lbu	a3,0(a1)
 780:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 784:	fee79ae3          	bne	a5,a4,778 <memmove+0x46>
 788:	bfc9                	j	75a <memmove+0x28>

000000000000078a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 78a:	1141                	addi	sp,sp,-16
 78c:	e422                	sd	s0,8(sp)
 78e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 790:	ca05                	beqz	a2,7c0 <memcmp+0x36>
 792:	fff6069b          	addiw	a3,a2,-1
 796:	1682                	slli	a3,a3,0x20
 798:	9281                	srli	a3,a3,0x20
 79a:	0685                	addi	a3,a3,1
 79c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 79e:	00054783          	lbu	a5,0(a0)
 7a2:	0005c703          	lbu	a4,0(a1)
 7a6:	00e79863          	bne	a5,a4,7b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7aa:	0505                	addi	a0,a0,1
    p2++;
 7ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7ae:	fed518e3          	bne	a0,a3,79e <memcmp+0x14>
  }
  return 0;
 7b2:	4501                	li	a0,0
 7b4:	a019                	j	7ba <memcmp+0x30>
      return *p1 - *p2;
 7b6:	40e7853b          	subw	a0,a5,a4
}
 7ba:	6422                	ld	s0,8(sp)
 7bc:	0141                	addi	sp,sp,16
 7be:	8082                	ret
  return 0;
 7c0:	4501                	li	a0,0
 7c2:	bfe5                	j	7ba <memcmp+0x30>

00000000000007c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7c4:	1141                	addi	sp,sp,-16
 7c6:	e406                	sd	ra,8(sp)
 7c8:	e022                	sd	s0,0(sp)
 7ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7cc:	00000097          	auipc	ra,0x0
 7d0:	f66080e7          	jalr	-154(ra) # 732 <memmove>
}
 7d4:	60a2                	ld	ra,8(sp)
 7d6:	6402                	ld	s0,0(sp)
 7d8:	0141                	addi	sp,sp,16
 7da:	8082                	ret

00000000000007dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7dc:	4885                	li	a7,1
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7e4:	4889                	li	a7,2
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 7ec:	488d                	li	a7,3
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7f4:	4891                	li	a7,4
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <read>:
.global read
read:
 li a7, SYS_read
 7fc:	4895                	li	a7,5
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <write>:
.global write
write:
 li a7, SYS_write
 804:	48c1                	li	a7,16
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <close>:
.global close
close:
 li a7, SYS_close
 80c:	48d5                	li	a7,21
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <kill>:
.global kill
kill:
 li a7, SYS_kill
 814:	4899                	li	a7,6
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <exec>:
.global exec
exec:
 li a7, SYS_exec
 81c:	489d                	li	a7,7
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <open>:
.global open
open:
 li a7, SYS_open
 824:	48bd                	li	a7,15
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 82c:	48c5                	li	a7,17
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 834:	48c9                	li	a7,18
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 83c:	48a1                	li	a7,8
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <link>:
.global link
link:
 li a7, SYS_link
 844:	48cd                	li	a7,19
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 84c:	48d1                	li	a7,20
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 854:	48a5                	li	a7,9
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <dup>:
.global dup
dup:
 li a7, SYS_dup
 85c:	48a9                	li	a7,10
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 864:	48ad                	li	a7,11
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 86c:	48b1                	li	a7,12
 ecall
 86e:	00000073          	ecall
 ret
 872:	8082                	ret

0000000000000874 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 874:	48b5                	li	a7,13
 ecall
 876:	00000073          	ecall
 ret
 87a:	8082                	ret

000000000000087c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 87c:	48b9                	li	a7,14
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 884:	1101                	addi	sp,sp,-32
 886:	ec06                	sd	ra,24(sp)
 888:	e822                	sd	s0,16(sp)
 88a:	1000                	addi	s0,sp,32
 88c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 890:	4605                	li	a2,1
 892:	fef40593          	addi	a1,s0,-17
 896:	00000097          	auipc	ra,0x0
 89a:	f6e080e7          	jalr	-146(ra) # 804 <write>
}
 89e:	60e2                	ld	ra,24(sp)
 8a0:	6442                	ld	s0,16(sp)
 8a2:	6105                	addi	sp,sp,32
 8a4:	8082                	ret

00000000000008a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8a6:	7139                	addi	sp,sp,-64
 8a8:	fc06                	sd	ra,56(sp)
 8aa:	f822                	sd	s0,48(sp)
 8ac:	f426                	sd	s1,40(sp)
 8ae:	0080                	addi	s0,sp,64
 8b0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8b2:	c299                	beqz	a3,8b8 <printint+0x12>
 8b4:	0805cb63          	bltz	a1,94a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8b8:	2581                	sext.w	a1,a1
  neg = 0;
 8ba:	4881                	li	a7,0
 8bc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8c0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8c2:	2601                	sext.w	a2,a2
 8c4:	00000517          	auipc	a0,0x0
 8c8:	59c50513          	addi	a0,a0,1436 # e60 <digits>
 8cc:	883a                	mv	a6,a4
 8ce:	2705                	addiw	a4,a4,1
 8d0:	02c5f7bb          	remuw	a5,a1,a2
 8d4:	1782                	slli	a5,a5,0x20
 8d6:	9381                	srli	a5,a5,0x20
 8d8:	97aa                	add	a5,a5,a0
 8da:	0007c783          	lbu	a5,0(a5)
 8de:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8e2:	0005879b          	sext.w	a5,a1
 8e6:	02c5d5bb          	divuw	a1,a1,a2
 8ea:	0685                	addi	a3,a3,1
 8ec:	fec7f0e3          	bgeu	a5,a2,8cc <printint+0x26>
  if(neg)
 8f0:	00088c63          	beqz	a7,908 <printint+0x62>
    buf[i++] = '-';
 8f4:	fd070793          	addi	a5,a4,-48
 8f8:	00878733          	add	a4,a5,s0
 8fc:	02d00793          	li	a5,45
 900:	fef70823          	sb	a5,-16(a4)
 904:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 908:	02e05c63          	blez	a4,940 <printint+0x9a>
 90c:	f04a                	sd	s2,32(sp)
 90e:	ec4e                	sd	s3,24(sp)
 910:	fc040793          	addi	a5,s0,-64
 914:	00e78933          	add	s2,a5,a4
 918:	fff78993          	addi	s3,a5,-1
 91c:	99ba                	add	s3,s3,a4
 91e:	377d                	addiw	a4,a4,-1
 920:	1702                	slli	a4,a4,0x20
 922:	9301                	srli	a4,a4,0x20
 924:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 928:	fff94583          	lbu	a1,-1(s2)
 92c:	8526                	mv	a0,s1
 92e:	00000097          	auipc	ra,0x0
 932:	f56080e7          	jalr	-170(ra) # 884 <putc>
  while(--i >= 0)
 936:	197d                	addi	s2,s2,-1
 938:	ff3918e3          	bne	s2,s3,928 <printint+0x82>
 93c:	7902                	ld	s2,32(sp)
 93e:	69e2                	ld	s3,24(sp)
}
 940:	70e2                	ld	ra,56(sp)
 942:	7442                	ld	s0,48(sp)
 944:	74a2                	ld	s1,40(sp)
 946:	6121                	addi	sp,sp,64
 948:	8082                	ret
    x = -xx;
 94a:	40b005bb          	negw	a1,a1
    neg = 1;
 94e:	4885                	li	a7,1
    x = -xx;
 950:	b7b5                	j	8bc <printint+0x16>

0000000000000952 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 952:	715d                	addi	sp,sp,-80
 954:	e486                	sd	ra,72(sp)
 956:	e0a2                	sd	s0,64(sp)
 958:	f84a                	sd	s2,48(sp)
 95a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 95c:	0005c903          	lbu	s2,0(a1)
 960:	1a090a63          	beqz	s2,b14 <vprintf+0x1c2>
 964:	fc26                	sd	s1,56(sp)
 966:	f44e                	sd	s3,40(sp)
 968:	f052                	sd	s4,32(sp)
 96a:	ec56                	sd	s5,24(sp)
 96c:	e85a                	sd	s6,16(sp)
 96e:	e45e                	sd	s7,8(sp)
 970:	8aaa                	mv	s5,a0
 972:	8bb2                	mv	s7,a2
 974:	00158493          	addi	s1,a1,1
  state = 0;
 978:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 97a:	02500a13          	li	s4,37
 97e:	4b55                	li	s6,21
 980:	a839                	j	99e <vprintf+0x4c>
        putc(fd, c);
 982:	85ca                	mv	a1,s2
 984:	8556                	mv	a0,s5
 986:	00000097          	auipc	ra,0x0
 98a:	efe080e7          	jalr	-258(ra) # 884 <putc>
 98e:	a019                	j	994 <vprintf+0x42>
    } else if(state == '%'){
 990:	01498d63          	beq	s3,s4,9aa <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 994:	0485                	addi	s1,s1,1
 996:	fff4c903          	lbu	s2,-1(s1)
 99a:	16090763          	beqz	s2,b08 <vprintf+0x1b6>
    if(state == 0){
 99e:	fe0999e3          	bnez	s3,990 <vprintf+0x3e>
      if(c == '%'){
 9a2:	ff4910e3          	bne	s2,s4,982 <vprintf+0x30>
        state = '%';
 9a6:	89d2                	mv	s3,s4
 9a8:	b7f5                	j	994 <vprintf+0x42>
      if(c == 'd'){
 9aa:	13490463          	beq	s2,s4,ad2 <vprintf+0x180>
 9ae:	f9d9079b          	addiw	a5,s2,-99
 9b2:	0ff7f793          	zext.b	a5,a5
 9b6:	12fb6763          	bltu	s6,a5,ae4 <vprintf+0x192>
 9ba:	f9d9079b          	addiw	a5,s2,-99
 9be:	0ff7f713          	zext.b	a4,a5
 9c2:	12eb6163          	bltu	s6,a4,ae4 <vprintf+0x192>
 9c6:	00271793          	slli	a5,a4,0x2
 9ca:	00000717          	auipc	a4,0x0
 9ce:	43e70713          	addi	a4,a4,1086 # e08 <malloc+0x204>
 9d2:	97ba                	add	a5,a5,a4
 9d4:	439c                	lw	a5,0(a5)
 9d6:	97ba                	add	a5,a5,a4
 9d8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9da:	008b8913          	addi	s2,s7,8
 9de:	4685                	li	a3,1
 9e0:	4629                	li	a2,10
 9e2:	000ba583          	lw	a1,0(s7)
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	ebe080e7          	jalr	-322(ra) # 8a6 <printint>
 9f0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	b745                	j	994 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f6:	008b8913          	addi	s2,s7,8
 9fa:	4681                	li	a3,0
 9fc:	4629                	li	a2,10
 9fe:	000ba583          	lw	a1,0(s7)
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	ea2080e7          	jalr	-350(ra) # 8a6 <printint>
 a0c:	8bca                	mv	s7,s2
      state = 0;
 a0e:	4981                	li	s3,0
 a10:	b751                	j	994 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 a12:	008b8913          	addi	s2,s7,8
 a16:	4681                	li	a3,0
 a18:	4641                	li	a2,16
 a1a:	000ba583          	lw	a1,0(s7)
 a1e:	8556                	mv	a0,s5
 a20:	00000097          	auipc	ra,0x0
 a24:	e86080e7          	jalr	-378(ra) # 8a6 <printint>
 a28:	8bca                	mv	s7,s2
      state = 0;
 a2a:	4981                	li	s3,0
 a2c:	b7a5                	j	994 <vprintf+0x42>
 a2e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a30:	008b8c13          	addi	s8,s7,8
 a34:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a38:	03000593          	li	a1,48
 a3c:	8556                	mv	a0,s5
 a3e:	00000097          	auipc	ra,0x0
 a42:	e46080e7          	jalr	-442(ra) # 884 <putc>
  putc(fd, 'x');
 a46:	07800593          	li	a1,120
 a4a:	8556                	mv	a0,s5
 a4c:	00000097          	auipc	ra,0x0
 a50:	e38080e7          	jalr	-456(ra) # 884 <putc>
 a54:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a56:	00000b97          	auipc	s7,0x0
 a5a:	40ab8b93          	addi	s7,s7,1034 # e60 <digits>
 a5e:	03c9d793          	srli	a5,s3,0x3c
 a62:	97de                	add	a5,a5,s7
 a64:	0007c583          	lbu	a1,0(a5)
 a68:	8556                	mv	a0,s5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	e1a080e7          	jalr	-486(ra) # 884 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a72:	0992                	slli	s3,s3,0x4
 a74:	397d                	addiw	s2,s2,-1
 a76:	fe0914e3          	bnez	s2,a5e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a7a:	8be2                	mv	s7,s8
      state = 0;
 a7c:	4981                	li	s3,0
 a7e:	6c02                	ld	s8,0(sp)
 a80:	bf11                	j	994 <vprintf+0x42>
        s = va_arg(ap, char*);
 a82:	008b8993          	addi	s3,s7,8
 a86:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a8a:	02090163          	beqz	s2,aac <vprintf+0x15a>
        while(*s != 0){
 a8e:	00094583          	lbu	a1,0(s2)
 a92:	c9a5                	beqz	a1,b02 <vprintf+0x1b0>
          putc(fd, *s);
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	dee080e7          	jalr	-530(ra) # 884 <putc>
          s++;
 a9e:	0905                	addi	s2,s2,1
        while(*s != 0){
 aa0:	00094583          	lbu	a1,0(s2)
 aa4:	f9e5                	bnez	a1,a94 <vprintf+0x142>
        s = va_arg(ap, char*);
 aa6:	8bce                	mv	s7,s3
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	b5ed                	j	994 <vprintf+0x42>
          s = "(null)";
 aac:	00000917          	auipc	s2,0x0
 ab0:	35490913          	addi	s2,s2,852 # e00 <malloc+0x1fc>
        while(*s != 0){
 ab4:	02800593          	li	a1,40
 ab8:	bff1                	j	a94 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 aba:	008b8913          	addi	s2,s7,8
 abe:	000bc583          	lbu	a1,0(s7)
 ac2:	8556                	mv	a0,s5
 ac4:	00000097          	auipc	ra,0x0
 ac8:	dc0080e7          	jalr	-576(ra) # 884 <putc>
 acc:	8bca                	mv	s7,s2
      state = 0;
 ace:	4981                	li	s3,0
 ad0:	b5d1                	j	994 <vprintf+0x42>
        putc(fd, c);
 ad2:	02500593          	li	a1,37
 ad6:	8556                	mv	a0,s5
 ad8:	00000097          	auipc	ra,0x0
 adc:	dac080e7          	jalr	-596(ra) # 884 <putc>
      state = 0;
 ae0:	4981                	li	s3,0
 ae2:	bd4d                	j	994 <vprintf+0x42>
        putc(fd, '%');
 ae4:	02500593          	li	a1,37
 ae8:	8556                	mv	a0,s5
 aea:	00000097          	auipc	ra,0x0
 aee:	d9a080e7          	jalr	-614(ra) # 884 <putc>
        putc(fd, c);
 af2:	85ca                	mv	a1,s2
 af4:	8556                	mv	a0,s5
 af6:	00000097          	auipc	ra,0x0
 afa:	d8e080e7          	jalr	-626(ra) # 884 <putc>
      state = 0;
 afe:	4981                	li	s3,0
 b00:	bd51                	j	994 <vprintf+0x42>
        s = va_arg(ap, char*);
 b02:	8bce                	mv	s7,s3
      state = 0;
 b04:	4981                	li	s3,0
 b06:	b579                	j	994 <vprintf+0x42>
 b08:	74e2                	ld	s1,56(sp)
 b0a:	79a2                	ld	s3,40(sp)
 b0c:	7a02                	ld	s4,32(sp)
 b0e:	6ae2                	ld	s5,24(sp)
 b10:	6b42                	ld	s6,16(sp)
 b12:	6ba2                	ld	s7,8(sp)
    }
  }
}
 b14:	60a6                	ld	ra,72(sp)
 b16:	6406                	ld	s0,64(sp)
 b18:	7942                	ld	s2,48(sp)
 b1a:	6161                	addi	sp,sp,80
 b1c:	8082                	ret

0000000000000b1e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b1e:	715d                	addi	sp,sp,-80
 b20:	ec06                	sd	ra,24(sp)
 b22:	e822                	sd	s0,16(sp)
 b24:	1000                	addi	s0,sp,32
 b26:	e010                	sd	a2,0(s0)
 b28:	e414                	sd	a3,8(s0)
 b2a:	e818                	sd	a4,16(s0)
 b2c:	ec1c                	sd	a5,24(s0)
 b2e:	03043023          	sd	a6,32(s0)
 b32:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b36:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b3a:	8622                	mv	a2,s0
 b3c:	00000097          	auipc	ra,0x0
 b40:	e16080e7          	jalr	-490(ra) # 952 <vprintf>
}
 b44:	60e2                	ld	ra,24(sp)
 b46:	6442                	ld	s0,16(sp)
 b48:	6161                	addi	sp,sp,80
 b4a:	8082                	ret

0000000000000b4c <printf>:

void
printf(const char *fmt, ...)
{
 b4c:	711d                	addi	sp,sp,-96
 b4e:	ec06                	sd	ra,24(sp)
 b50:	e822                	sd	s0,16(sp)
 b52:	1000                	addi	s0,sp,32
 b54:	e40c                	sd	a1,8(s0)
 b56:	e810                	sd	a2,16(s0)
 b58:	ec14                	sd	a3,24(s0)
 b5a:	f018                	sd	a4,32(s0)
 b5c:	f41c                	sd	a5,40(s0)
 b5e:	03043823          	sd	a6,48(s0)
 b62:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b66:	00840613          	addi	a2,s0,8
 b6a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b6e:	85aa                	mv	a1,a0
 b70:	4505                	li	a0,1
 b72:	00000097          	auipc	ra,0x0
 b76:	de0080e7          	jalr	-544(ra) # 952 <vprintf>
}
 b7a:	60e2                	ld	ra,24(sp)
 b7c:	6442                	ld	s0,16(sp)
 b7e:	6125                	addi	sp,sp,96
 b80:	8082                	ret

0000000000000b82 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b82:	1141                	addi	sp,sp,-16
 b84:	e422                	sd	s0,8(sp)
 b86:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b88:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b8c:	00001797          	auipc	a5,0x1
 b90:	8647b783          	ld	a5,-1948(a5) # 13f0 <freep>
 b94:	a02d                	j	bbe <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b96:	4618                	lw	a4,8(a2)
 b98:	9f2d                	addw	a4,a4,a1
 b9a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b9e:	6398                	ld	a4,0(a5)
 ba0:	6310                	ld	a2,0(a4)
 ba2:	a83d                	j	be0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ba4:	ff852703          	lw	a4,-8(a0)
 ba8:	9f31                	addw	a4,a4,a2
 baa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bac:	ff053683          	ld	a3,-16(a0)
 bb0:	a091                	j	bf4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb2:	6398                	ld	a4,0(a5)
 bb4:	00e7e463          	bltu	a5,a4,bbc <free+0x3a>
 bb8:	00e6ea63          	bltu	a3,a4,bcc <free+0x4a>
{
 bbc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bbe:	fed7fae3          	bgeu	a5,a3,bb2 <free+0x30>
 bc2:	6398                	ld	a4,0(a5)
 bc4:	00e6e463          	bltu	a3,a4,bcc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc8:	fee7eae3          	bltu	a5,a4,bbc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bcc:	ff852583          	lw	a1,-8(a0)
 bd0:	6390                	ld	a2,0(a5)
 bd2:	02059813          	slli	a6,a1,0x20
 bd6:	01c85713          	srli	a4,a6,0x1c
 bda:	9736                	add	a4,a4,a3
 bdc:	fae60de3          	beq	a2,a4,b96 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 be0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 be4:	4790                	lw	a2,8(a5)
 be6:	02061593          	slli	a1,a2,0x20
 bea:	01c5d713          	srli	a4,a1,0x1c
 bee:	973e                	add	a4,a4,a5
 bf0:	fae68ae3          	beq	a3,a4,ba4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bf4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bf6:	00000717          	auipc	a4,0x0
 bfa:	7ef73d23          	sd	a5,2042(a4) # 13f0 <freep>
}
 bfe:	6422                	ld	s0,8(sp)
 c00:	0141                	addi	sp,sp,16
 c02:	8082                	ret

0000000000000c04 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c04:	7139                	addi	sp,sp,-64
 c06:	fc06                	sd	ra,56(sp)
 c08:	f822                	sd	s0,48(sp)
 c0a:	f426                	sd	s1,40(sp)
 c0c:	ec4e                	sd	s3,24(sp)
 c0e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c10:	02051493          	slli	s1,a0,0x20
 c14:	9081                	srli	s1,s1,0x20
 c16:	04bd                	addi	s1,s1,15
 c18:	8091                	srli	s1,s1,0x4
 c1a:	0014899b          	addiw	s3,s1,1
 c1e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c20:	00000517          	auipc	a0,0x0
 c24:	7d053503          	ld	a0,2000(a0) # 13f0 <freep>
 c28:	c915                	beqz	a0,c5c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c2a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c2c:	4798                	lw	a4,8(a5)
 c2e:	08977e63          	bgeu	a4,s1,cca <malloc+0xc6>
 c32:	f04a                	sd	s2,32(sp)
 c34:	e852                	sd	s4,16(sp)
 c36:	e456                	sd	s5,8(sp)
 c38:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c3a:	8a4e                	mv	s4,s3
 c3c:	0009871b          	sext.w	a4,s3
 c40:	6685                	lui	a3,0x1
 c42:	00d77363          	bgeu	a4,a3,c48 <malloc+0x44>
 c46:	6a05                	lui	s4,0x1
 c48:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c4c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c50:	00000917          	auipc	s2,0x0
 c54:	7a090913          	addi	s2,s2,1952 # 13f0 <freep>
  if(p == (char*)-1)
 c58:	5afd                	li	s5,-1
 c5a:	a091                	j	c9e <malloc+0x9a>
 c5c:	f04a                	sd	s2,32(sp)
 c5e:	e852                	sd	s4,16(sp)
 c60:	e456                	sd	s5,8(sp)
 c62:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c64:	00009797          	auipc	a5,0x9
 c68:	97478793          	addi	a5,a5,-1676 # 95d8 <base>
 c6c:	00000717          	auipc	a4,0x0
 c70:	78f73223          	sd	a5,1924(a4) # 13f0 <freep>
 c74:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c76:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c7a:	b7c1                	j	c3a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c7c:	6398                	ld	a4,0(a5)
 c7e:	e118                	sd	a4,0(a0)
 c80:	a08d                	j	ce2 <malloc+0xde>
  hp->s.size = nu;
 c82:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c86:	0541                	addi	a0,a0,16
 c88:	00000097          	auipc	ra,0x0
 c8c:	efa080e7          	jalr	-262(ra) # b82 <free>
  return freep;
 c90:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c94:	c13d                	beqz	a0,cfa <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c96:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c98:	4798                	lw	a4,8(a5)
 c9a:	02977463          	bgeu	a4,s1,cc2 <malloc+0xbe>
    if(p == freep)
 c9e:	00093703          	ld	a4,0(s2)
 ca2:	853e                	mv	a0,a5
 ca4:	fef719e3          	bne	a4,a5,c96 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 ca8:	8552                	mv	a0,s4
 caa:	00000097          	auipc	ra,0x0
 cae:	bc2080e7          	jalr	-1086(ra) # 86c <sbrk>
  if(p == (char*)-1)
 cb2:	fd5518e3          	bne	a0,s5,c82 <malloc+0x7e>
        return 0;
 cb6:	4501                	li	a0,0
 cb8:	7902                	ld	s2,32(sp)
 cba:	6a42                	ld	s4,16(sp)
 cbc:	6aa2                	ld	s5,8(sp)
 cbe:	6b02                	ld	s6,0(sp)
 cc0:	a03d                	j	cee <malloc+0xea>
 cc2:	7902                	ld	s2,32(sp)
 cc4:	6a42                	ld	s4,16(sp)
 cc6:	6aa2                	ld	s5,8(sp)
 cc8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cca:	fae489e3          	beq	s1,a4,c7c <malloc+0x78>
        p->s.size -= nunits;
 cce:	4137073b          	subw	a4,a4,s3
 cd2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cd4:	02071693          	slli	a3,a4,0x20
 cd8:	01c6d713          	srli	a4,a3,0x1c
 cdc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cde:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ce2:	00000717          	auipc	a4,0x0
 ce6:	70a73723          	sd	a0,1806(a4) # 13f0 <freep>
      return (void*)(p + 1);
 cea:	01078513          	addi	a0,a5,16
  }
}
 cee:	70e2                	ld	ra,56(sp)
 cf0:	7442                	ld	s0,48(sp)
 cf2:	74a2                	ld	s1,40(sp)
 cf4:	69e2                	ld	s3,24(sp)
 cf6:	6121                	addi	sp,sp,64
 cf8:	8082                	ret
 cfa:	7902                	ld	s2,32(sp)
 cfc:	6a42                	ld	s4,16(sp)
 cfe:	6aa2                	ld	s5,8(sp)
 d00:	6b02                	ld	s6,0(sp)
 d02:	b7f5                	j	cee <malloc+0xea>
