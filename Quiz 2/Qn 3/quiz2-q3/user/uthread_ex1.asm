
user/_uthread_ex1:     file format elf64-littleriscv


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
  10:	d4450513          	addi	a0,a0,-700 # d50 <malloc+0x104>
  14:	00001097          	auipc	ra,0x1
  18:	b80080e7          	jalr	-1152(ra) # b94 <printf>
  a_started = 1;
  1c:	4785                	li	a5,1
  1e:	00001717          	auipc	a4,0x1
  22:	44f72323          	sw	a5,1094(a4) # 1464 <a_started>
  while(b_started == 0 || c_started == 0)
  26:	00001497          	auipc	s1,0x1
  2a:	43a48493          	addi	s1,s1,1082 # 1460 <b_started>
  2e:	00001917          	auipc	s2,0x1
  32:	42e90913          	addi	s2,s2,1070 # 145c <c_started>
  36:	a029                	j	40 <thread_a+0x40>
    thread_yield();
  38:	00000097          	auipc	ra,0x0
  3c:	4dc080e7          	jalr	1244(ra) # 514 <thread_yield>
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
  52:	40a48493          	addi	s1,s1,1034 # 1458 <a_n>
  56:	00001797          	auipc	a5,0x1
  5a:	4027a783          	lw	a5,1026(a5) # 1458 <a_n>
  5e:	2785                	addiw	a5,a5,1
  60:	c09c                	sw	a5,0(s1)
    thread_yield();
  62:	00000097          	auipc	ra,0x0
  66:	4b2080e7          	jalr	1202(ra) # 514 <thread_yield>
    a_n += 1;
  6a:	409c                	lw	a5,0(s1)
  6c:	2785                	addiw	a5,a5,1
  6e:	c09c                	sw	a5,0(s1)
    thread_yield();
  70:	00000097          	auipc	ra,0x0
  74:	4a4080e7          	jalr	1188(ra) # 514 <thread_yield>
    a_n += 1;
  78:	409c                	lw	a5,0(s1)
  7a:	2785                	addiw	a5,a5,1
  7c:	c09c                	sw	a5,0(s1)
    thread_yield();
  7e:	00000097          	auipc	ra,0x0
  82:	496080e7          	jalr	1174(ra) # 514 <thread_yield>
  }
  printf("thread_a: exit after %d\n", a_n);
  86:	408c                	lw	a1,0(s1)
  88:	00001517          	auipc	a0,0x1
  8c:	ce050513          	addi	a0,a0,-800 # d68 <malloc+0x11c>
  90:	00001097          	auipc	ra,0x1
  94:	b04080e7          	jalr	-1276(ra) # b94 <printf>
  if (thread_wakeup(4)==-1){
  98:	4511                	li	a0,4
  9a:	00000097          	auipc	ra,0x0
  9e:	2ba080e7          	jalr	698(ra) # 354 <thread_wakeup>
  a2:	57fd                	li	a5,-1
  a4:	04f50163          	beq	a0,a5,e6 <thread_a+0xe6>
    printf("Error thread doesn't exist or it is not sleeping\n");
  }
  if (thread_wakeup(-1)==-1){
  a8:	557d                	li	a0,-1
  aa:	00000097          	auipc	ra,0x0
  ae:	2aa080e7          	jalr	682(ra) # 354 <thread_wakeup>
  b2:	57fd                	li	a5,-1
  b4:	04f50263          	beq	a0,a5,f8 <thread_a+0xf8>
    printf("Error thread doesn't exist or it is not sleeping\n");
  }
  thread_wakeup(2);
  b8:	4509                	li	a0,2
  ba:	00000097          	auipc	ra,0x0
  be:	29a080e7          	jalr	666(ra) # 354 <thread_wakeup>
  current_thread->state = FREE;
  c2:	00001797          	auipc	a5,0x1
  c6:	3a67b783          	ld	a5,934(a5) # 1468 <current_thread>
  ca:	6709                	lui	a4,0x2
  cc:	97ba                	add	a5,a5,a4
  ce:	0007a023          	sw	zero,0(a5)
  thread_schedule();
  d2:	00000097          	auipc	ra,0x0
  d6:	2da080e7          	jalr	730(ra) # 3ac <thread_schedule>
}
  da:	60e2                	ld	ra,24(sp)
  dc:	6442                	ld	s0,16(sp)
  de:	64a2                	ld	s1,8(sp)
  e0:	6902                	ld	s2,0(sp)
  e2:	6105                	addi	sp,sp,32
  e4:	8082                	ret
    printf("Error thread doesn't exist or it is not sleeping\n");
  e6:	00001517          	auipc	a0,0x1
  ea:	ca250513          	addi	a0,a0,-862 # d88 <malloc+0x13c>
  ee:	00001097          	auipc	ra,0x1
  f2:	aa6080e7          	jalr	-1370(ra) # b94 <printf>
  f6:	bf4d                	j	a8 <thread_a+0xa8>
    printf("Error thread doesn't exist or it is not sleeping\n");
  f8:	00001517          	auipc	a0,0x1
  fc:	c9050513          	addi	a0,a0,-880 # d88 <malloc+0x13c>
 100:	00001097          	auipc	ra,0x1
 104:	a94080e7          	jalr	-1388(ra) # b94 <printf>
 108:	bf45                	j	b8 <thread_a+0xb8>

000000000000010a <thread_b>:

void 
thread_b(void)
{
 10a:	1101                	addi	sp,sp,-32
 10c:	ec06                	sd	ra,24(sp)
 10e:	e822                	sd	s0,16(sp)
 110:	e426                	sd	s1,8(sp)
 112:	e04a                	sd	s2,0(sp)
 114:	1000                	addi	s0,sp,32
  int i;
  printf("thread_b started\n");
 116:	00001517          	auipc	a0,0x1
 11a:	caa50513          	addi	a0,a0,-854 # dc0 <malloc+0x174>
 11e:	00001097          	auipc	ra,0x1
 122:	a76080e7          	jalr	-1418(ra) # b94 <printf>
  b_started = 1;
 126:	4785                	li	a5,1
 128:	00001717          	auipc	a4,0x1
 12c:	32f72c23          	sw	a5,824(a4) # 1460 <b_started>
  while(a_started == 0 || c_started == 0)
 130:	00001497          	auipc	s1,0x1
 134:	33448493          	addi	s1,s1,820 # 1464 <a_started>
 138:	00001917          	auipc	s2,0x1
 13c:	32490913          	addi	s2,s2,804 # 145c <c_started>
 140:	a029                	j	14a <thread_b+0x40>
    thread_yield();
 142:	00000097          	auipc	ra,0x0
 146:	3d2080e7          	jalr	978(ra) # 514 <thread_yield>
  while(a_started == 0 || c_started == 0)
 14a:	409c                	lw	a5,0(s1)
 14c:	2781                	sext.w	a5,a5
 14e:	dbf5                	beqz	a5,142 <thread_b+0x38>
 150:	00092783          	lw	a5,0(s2)
 154:	2781                	sext.w	a5,a5
 156:	d7f5                	beqz	a5,142 <thread_b+0x38>
  
  thread_sleep();
 158:	00000097          	auipc	ra,0x0
 15c:	350080e7          	jalr	848(ra) # 4a8 <thread_sleep>
  for (i = 0; i < 3; i++) {
    //printf("thread_b %d\n", i);
    b_n += 1;
 160:	00001497          	auipc	s1,0x1
 164:	2f448493          	addi	s1,s1,756 # 1454 <b_n>
 168:	00001797          	auipc	a5,0x1
 16c:	2ec7a783          	lw	a5,748(a5) # 1454 <b_n>
 170:	2785                	addiw	a5,a5,1
 172:	c09c                	sw	a5,0(s1)
    thread_yield();
 174:	00000097          	auipc	ra,0x0
 178:	3a0080e7          	jalr	928(ra) # 514 <thread_yield>
    b_n += 1;
 17c:	409c                	lw	a5,0(s1)
 17e:	2785                	addiw	a5,a5,1
 180:	c09c                	sw	a5,0(s1)
    thread_yield();
 182:	00000097          	auipc	ra,0x0
 186:	392080e7          	jalr	914(ra) # 514 <thread_yield>
    b_n += 1;
 18a:	409c                	lw	a5,0(s1)
 18c:	2785                	addiw	a5,a5,1
 18e:	c09c                	sw	a5,0(s1)
    thread_yield();
 190:	00000097          	auipc	ra,0x0
 194:	384080e7          	jalr	900(ra) # 514 <thread_yield>
  }
  printf("thread_b: exit after %d\n", b_n);
 198:	408c                	lw	a1,0(s1)
 19a:	00001517          	auipc	a0,0x1
 19e:	c3e50513          	addi	a0,a0,-962 # dd8 <malloc+0x18c>
 1a2:	00001097          	auipc	ra,0x1
 1a6:	9f2080e7          	jalr	-1550(ra) # b94 <printf>
  thread_wakeup(3);
 1aa:	450d                	li	a0,3
 1ac:	00000097          	auipc	ra,0x0
 1b0:	1a8080e7          	jalr	424(ra) # 354 <thread_wakeup>
  current_thread->state = FREE;
 1b4:	00001797          	auipc	a5,0x1
 1b8:	2b47b783          	ld	a5,692(a5) # 1468 <current_thread>
 1bc:	6709                	lui	a4,0x2
 1be:	97ba                	add	a5,a5,a4
 1c0:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 1c4:	00000097          	auipc	ra,0x0
 1c8:	1e8080e7          	jalr	488(ra) # 3ac <thread_schedule>
}
 1cc:	60e2                	ld	ra,24(sp)
 1ce:	6442                	ld	s0,16(sp)
 1d0:	64a2                	ld	s1,8(sp)
 1d2:	6902                	ld	s2,0(sp)
 1d4:	6105                	addi	sp,sp,32
 1d6:	8082                	ret

00000000000001d8 <thread_c>:

void 
thread_c(void)
{
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	e04a                	sd	s2,0(sp)
 1e2:	1000                	addi	s0,sp,32
  int i;
  printf("thread_c started\n");
 1e4:	00001517          	auipc	a0,0x1
 1e8:	c1450513          	addi	a0,a0,-1004 # df8 <malloc+0x1ac>
 1ec:	00001097          	auipc	ra,0x1
 1f0:	9a8080e7          	jalr	-1624(ra) # b94 <printf>
  c_started = 1;
 1f4:	4785                	li	a5,1
 1f6:	00001717          	auipc	a4,0x1
 1fa:	26f72323          	sw	a5,614(a4) # 145c <c_started>
  while(a_started == 0 || b_started == 0)
 1fe:	00001497          	auipc	s1,0x1
 202:	26648493          	addi	s1,s1,614 # 1464 <a_started>
 206:	00001917          	auipc	s2,0x1
 20a:	25a90913          	addi	s2,s2,602 # 1460 <b_started>
 20e:	a029                	j	218 <thread_c+0x40>
    thread_yield();
 210:	00000097          	auipc	ra,0x0
 214:	304080e7          	jalr	772(ra) # 514 <thread_yield>
  while(a_started == 0 || b_started == 0)
 218:	409c                	lw	a5,0(s1)
 21a:	2781                	sext.w	a5,a5
 21c:	dbf5                	beqz	a5,210 <thread_c+0x38>
 21e:	00092783          	lw	a5,0(s2)
 222:	2781                	sext.w	a5,a5
 224:	d7f5                	beqz	a5,210 <thread_c+0x38>
  thread_sleep();
 226:	00000097          	auipc	ra,0x0
 22a:	282080e7          	jalr	642(ra) # 4a8 <thread_sleep>
  for (i = 0; i < 3; i++) {
    //printf("thread_c %d\n", i);
    c_n += 1;
 22e:	00001497          	auipc	s1,0x1
 232:	22248493          	addi	s1,s1,546 # 1450 <c_n>
 236:	00001797          	auipc	a5,0x1
 23a:	21a7a783          	lw	a5,538(a5) # 1450 <c_n>
 23e:	2785                	addiw	a5,a5,1
 240:	c09c                	sw	a5,0(s1)
    thread_yield();
 242:	00000097          	auipc	ra,0x0
 246:	2d2080e7          	jalr	722(ra) # 514 <thread_yield>
    c_n += 1;
 24a:	409c                	lw	a5,0(s1)
 24c:	2785                	addiw	a5,a5,1
 24e:	c09c                	sw	a5,0(s1)
    thread_yield();
 250:	00000097          	auipc	ra,0x0
 254:	2c4080e7          	jalr	708(ra) # 514 <thread_yield>
    c_n += 1;
 258:	409c                	lw	a5,0(s1)
 25a:	2785                	addiw	a5,a5,1
 25c:	c09c                	sw	a5,0(s1)
    thread_yield();
 25e:	00000097          	auipc	ra,0x0
 262:	2b6080e7          	jalr	694(ra) # 514 <thread_yield>
  }
  printf("thread_c: exit after %d\n", c_n);
 266:	408c                	lw	a1,0(s1)
 268:	00001517          	auipc	a0,0x1
 26c:	ba850513          	addi	a0,a0,-1112 # e10 <malloc+0x1c4>
 270:	00001097          	auipc	ra,0x1
 274:	924080e7          	jalr	-1756(ra) # b94 <printf>

  current_thread->state = FREE;
 278:	00001797          	auipc	a5,0x1
 27c:	1f07b783          	ld	a5,496(a5) # 1468 <current_thread>
 280:	6709                	lui	a4,0x2
 282:	97ba                	add	a5,a5,a4
 284:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 288:	00000097          	auipc	ra,0x0
 28c:	124080e7          	jalr	292(ra) # 3ac <thread_schedule>
}
 290:	60e2                	ld	ra,24(sp)
 292:	6442                	ld	s0,16(sp)
 294:	64a2                	ld	s1,8(sp)
 296:	6902                	ld	s2,0(sp)
 298:	6105                	addi	sp,sp,32
 29a:	8082                	ret

000000000000029c <main>:

int 
main(int argc, char *argv[]) 
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 2a4:	00001797          	auipc	a5,0x1
 2a8:	1a07ac23          	sw	zero,440(a5) # 145c <c_started>
 2ac:	00001797          	auipc	a5,0x1
 2b0:	1a07aa23          	sw	zero,436(a5) # 1460 <b_started>
 2b4:	00001797          	auipc	a5,0x1
 2b8:	1a07a823          	sw	zero,432(a5) # 1464 <a_started>
  a_n = b_n = c_n = 0;
 2bc:	00001797          	auipc	a5,0x1
 2c0:	1807aa23          	sw	zero,404(a5) # 1450 <c_n>
 2c4:	00001797          	auipc	a5,0x1
 2c8:	1807a823          	sw	zero,400(a5) # 1454 <b_n>
 2cc:	00001797          	auipc	a5,0x1
 2d0:	1807a623          	sw	zero,396(a5) # 1458 <a_n>
  thread_init();
 2d4:	00000097          	auipc	ra,0x0
 2d8:	05a080e7          	jalr	90(ra) # 32e <thread_init>
  thread_create(thread_a);
 2dc:	00000517          	auipc	a0,0x0
 2e0:	d2450513          	addi	a0,a0,-732 # 0 <thread_a>
 2e4:	00000097          	auipc	ra,0x0
 2e8:	1ec080e7          	jalr	492(ra) # 4d0 <thread_create>
  thread_create(thread_b);
 2ec:	00000517          	auipc	a0,0x0
 2f0:	e1e50513          	addi	a0,a0,-482 # 10a <thread_b>
 2f4:	00000097          	auipc	ra,0x0
 2f8:	1dc080e7          	jalr	476(ra) # 4d0 <thread_create>
  thread_create(thread_c);
 2fc:	00000517          	auipc	a0,0x0
 300:	edc50513          	addi	a0,a0,-292 # 1d8 <thread_c>
 304:	00000097          	auipc	ra,0x0
 308:	1cc080e7          	jalr	460(ra) # 4d0 <thread_create>
  current_thread->state = FREE;
 30c:	00001797          	auipc	a5,0x1
 310:	15c7b783          	ld	a5,348(a5) # 1468 <current_thread>
 314:	6709                	lui	a4,0x2
 316:	97ba                	add	a5,a5,a4
 318:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 31c:	00000097          	auipc	ra,0x0
 320:	090080e7          	jalr	144(ra) # 3ac <thread_schedule>
  exit(0);
 324:	4501                	li	a0,0
 326:	00000097          	auipc	ra,0x0
 32a:	506080e7          	jalr	1286(ra) # 82c <exit>

000000000000032e <thread_init>:
struct thread *current_thread;

              
void 
thread_init(void)
{
 32e:	1141                	addi	sp,sp,-16
 330:	e422                	sd	s0,8(sp)
 332:	0800                	addi	s0,sp,16
  // main() is thread 0, which will make the first invocation to
  // thread_schedule(). It needs a stack so that the first thread_switch() can
  // save thread 0's state.
  current_thread = &all_thread[0];
 334:	00001797          	auipc	a5,0x1
 338:	14478793          	addi	a5,a5,324 # 1478 <all_thread>
 33c:	00001717          	auipc	a4,0x1
 340:	12f73623          	sd	a5,300(a4) # 1468 <current_thread>
  current_thread->state = RUNNING;
 344:	4785                	li	a5,1
 346:	00003717          	auipc	a4,0x3
 34a:	12f72923          	sw	a5,306(a4) # 3478 <__global_pointer$+0x182c>
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret

0000000000000354 <thread_wakeup>:
  thread_schedule();
}

int 
thread_wakeup(int thread_id)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  //add your code here
  struct thread *wake_thread = &all_thread[thread_id];
  if (thread_id < 0 || thread_id >= MAX_THREAD){
 35a:	478d                	li	a5,3
 35c:	04a7e463          	bltu	a5,a0,3a4 <thread_wakeup+0x50>
    return -1;
  }

  if (wake_thread->state != SLEEPING){
 360:	6789                	lui	a5,0x2
 362:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 366:	02f507b3          	mul	a5,a0,a5
 36a:	00001697          	auipc	a3,0x1
 36e:	10e68693          	addi	a3,a3,270 # 1478 <all_thread>
 372:	96be                	add	a3,a3,a5
 374:	6789                	lui	a5,0x2
 376:	97b6                	add	a5,a5,a3
 378:	4394                	lw	a3,0(a5)
 37a:	478d                	li	a5,3
 37c:	02f69663          	bne	a3,a5,3a8 <thread_wakeup+0x54>
    return -1;
  }

  wake_thread->state = RUNNABLE;
 380:	6789                	lui	a5,0x2
 382:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 386:	02f50733          	mul	a4,a0,a5
 38a:	00001797          	auipc	a5,0x1
 38e:	0ee78793          	addi	a5,a5,238 # 1478 <all_thread>
 392:	973e                	add	a4,a4,a5
 394:	6789                	lui	a5,0x2
 396:	97ba                	add	a5,a5,a4
 398:	4709                	li	a4,2
 39a:	c398                	sw	a4,0(a5)
  return 0;
 39c:	4501                	li	a0,0
}
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
    return -1;
 3a4:	557d                	li	a0,-1
 3a6:	bfe5                	j	39e <thread_wakeup+0x4a>
    return -1;
 3a8:	557d                	li	a0,-1
 3aa:	bfd5                	j	39e <thread_wakeup+0x4a>

00000000000003ac <thread_schedule>:

void thread_schedule(void)
{
 3ac:	1101                	addi	sp,sp,-32
 3ae:	ec06                	sd	ra,24(sp)
 3b0:	e822                	sd	s0,16(sp)
 3b2:	e426                	sd	s1,8(sp)
 3b4:	1000                	addi	s0,sp,32
  struct thread *t, *next_thread;
  int sleeping_thread = 0;
  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
 3b6:	6789                	lui	a5,0x2
 3b8:	07878793          	addi	a5,a5,120 # 2078 <__global_pointer$+0x42c>
 3bc:	00001597          	auipc	a1,0x1
 3c0:	0ac5b583          	ld	a1,172(a1) # 1468 <current_thread>
 3c4:	95be                	add	a1,a1,a5
 3c6:	4791                	li	a5,4
  int sleeping_thread = 0;
 3c8:	4481                	li	s1,0
  for(int i = 0; i < MAX_THREAD; i++){
    if(t >= all_thread + MAX_THREAD)
 3ca:	00009817          	auipc	a6,0x9
 3ce:	28e80813          	addi	a6,a6,654 # 9658 <base>
      t = all_thread;
    if(t->state == RUNNABLE) {
 3d2:	6509                	lui	a0,0x2
 3d4:	4609                	li	a2,2
      next_thread = t;
      break;
    }
    //add code to identify that there are sleeping threads
    if(t->state == SLEEPING) {
 3d6:	488d                	li	a7,3
      sleeping_thread = 1;
 3d8:	4305                	li	t1,1
    }
    t = t + 1;
 3da:	6689                	lui	a3,0x2
 3dc:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 3e0:	a819                	j	3f6 <thread_schedule+0x4a>
    if(t->state == RUNNABLE) {
 3e2:	00a58733          	add	a4,a1,a0
 3e6:	4318                	lw	a4,0(a4)
 3e8:	04c70d63          	beq	a4,a2,442 <thread_schedule+0x96>
    if(t->state == SLEEPING) {
 3ec:	01170c63          	beq	a4,a7,404 <thread_schedule+0x58>
    t = t + 1;
 3f0:	95b6                	add	a1,a1,a3
  for(int i = 0; i < MAX_THREAD; i++){
 3f2:	37fd                	addiw	a5,a5,-1
 3f4:	c3d1                	beqz	a5,478 <thread_schedule+0xcc>
    if(t >= all_thread + MAX_THREAD)
 3f6:	ff05e6e3          	bltu	a1,a6,3e2 <thread_schedule+0x36>
      t = all_thread;
 3fa:	00001597          	auipc	a1,0x1
 3fe:	07e58593          	addi	a1,a1,126 # 1478 <all_thread>
 402:	b7c5                	j	3e2 <thread_schedule+0x36>
      sleeping_thread = 1;
 404:	849a                	mv	s1,t1
 406:	b7ed                	j	3f0 <thread_schedule+0x44>
        if(first_sleep == 0){
          all_thread[i].state = RUNNING;
          next_thread = &all_thread[i];
          first_sleep = 1;
        } else {
          all_thread[i].state = RUNNABLE;
 408:	4709                	li	a4,2
 40a:	c398                	sw	a4,0(a5)
      for(int i = 0; i < MAX_THREAD; i++){ 
 40c:	97b6                	add	a5,a5,a3
 40e:	03078a63          	beq	a5,a6,442 <thread_schedule+0x96>
        if(all_thread[i].state == SLEEPING){
 412:	4398                	lw	a4,0(a5)
 414:	fea71ce3          	bne	a4,a0,40c <thread_schedule+0x60>
        if(first_sleep == 0){
 418:	fe0898e3          	bnez	a7,408 <thread_schedule+0x5c>
          all_thread[i].state = RUNNING;
 41c:	4705                	li	a4,1
 41e:	c398                	sw	a4,0(a5)
          next_thread = &all_thread[i];
 420:	75f9                	lui	a1,0xffffe
 422:	95be                	add	a1,a1,a5
          first_sleep = 1;
 424:	88a6                	mv	a7,s1
 426:	b7dd                	j	40c <thread_schedule+0x60>

      }
      }
    }
    else{
      printf("thread_schedule: no runnable threads\n");
 428:	00001517          	auipc	a0,0x1
 42c:	a3050513          	addi	a0,a0,-1488 # e58 <malloc+0x20c>
 430:	00000097          	auipc	ra,0x0
 434:	764080e7          	jalr	1892(ra) # b94 <printf>
      exit(-1);
 438:	557d                	li	a0,-1
 43a:	00000097          	auipc	ra,0x0
 43e:	3f2080e7          	jalr	1010(ra) # 82c <exit>
    }
  }

  if (current_thread != next_thread) {         /* switch threads?  */
 442:	00001517          	auipc	a0,0x1
 446:	02653503          	ld	a0,38(a0) # 1468 <current_thread>
 44a:	02b50263          	beq	a0,a1,46e <thread_schedule+0xc2>
    next_thread->state = RUNNING;
 44e:	6789                	lui	a5,0x2
 450:	97ae                	add	a5,a5,a1
 452:	4705                	li	a4,1
 454:	c398                	sw	a4,0(a5)
    t = current_thread;
    current_thread = next_thread;
 456:	00001797          	auipc	a5,0x1
 45a:	00b7b923          	sd	a1,18(a5) # 1468 <current_thread>
    thread_switch(&t->context, &current_thread->context);
 45e:	6789                	lui	a5,0x2
 460:	07a1                	addi	a5,a5,8 # 2008 <__global_pointer$+0x3bc>
 462:	95be                	add	a1,a1,a5
 464:	953e                	add	a0,a0,a5
 466:	00000097          	auipc	ra,0x0
 46a:	0d6080e7          	jalr	214(ra) # 53c <thread_switch>
  } else
    next_thread = 0;
}
 46e:	60e2                	ld	ra,24(sp)
 470:	6442                	ld	s0,16(sp)
 472:	64a2                	ld	s1,8(sp)
 474:	6105                	addi	sp,sp,32
 476:	8082                	ret
    if (sleeping_thread == 1){
 478:	d8c5                	beqz	s1,428 <thread_schedule+0x7c>
      printf("only thread sleepings, wake them all\n");
 47a:	00001517          	auipc	a0,0x1
 47e:	9b650513          	addi	a0,a0,-1610 # e30 <malloc+0x1e4>
 482:	00000097          	auipc	ra,0x0
 486:	712080e7          	jalr	1810(ra) # b94 <printf>
      for(int i = 0; i < MAX_THREAD; i++){ 
 48a:	00003797          	auipc	a5,0x3
 48e:	fee78793          	addi	a5,a5,-18 # 3478 <__global_pointer$+0x182c>
 492:	0000b817          	auipc	a6,0xb
 496:	1c680813          	addi	a6,a6,454 # b658 <__BSS_END__+0x1ff0>
      int first_sleep = 0;
 49a:	4881                	li	a7,0
      printf("only thread sleepings, wake them all\n");
 49c:	4581                	li	a1,0
        if(all_thread[i].state == SLEEPING){
 49e:	450d                	li	a0,3
      for(int i = 0; i < MAX_THREAD; i++){ 
 4a0:	6689                	lui	a3,0x2
 4a2:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 4a6:	b7b5                	j	412 <thread_schedule+0x66>

00000000000004a8 <thread_sleep>:
{
 4a8:	1141                	addi	sp,sp,-16
 4aa:	e406                	sd	ra,8(sp)
 4ac:	e022                	sd	s0,0(sp)
 4ae:	0800                	addi	s0,sp,16
  current_thread->state = SLEEPING;
 4b0:	00001797          	auipc	a5,0x1
 4b4:	fb87b783          	ld	a5,-72(a5) # 1468 <current_thread>
 4b8:	6709                	lui	a4,0x2
 4ba:	97ba                	add	a5,a5,a4
 4bc:	470d                	li	a4,3
 4be:	c398                	sw	a4,0(a5)
  thread_schedule();
 4c0:	00000097          	auipc	ra,0x0
 4c4:	eec080e7          	jalr	-276(ra) # 3ac <thread_schedule>
}
 4c8:	60a2                	ld	ra,8(sp)
 4ca:	6402                	ld	s0,0(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret

00000000000004d0 <thread_create>:

void 
thread_create(void (*func)())
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4d6:	00001797          	auipc	a5,0x1
 4da:	fa278793          	addi	a5,a5,-94 # 1478 <all_thread>
    if (t->state == FREE) break;
 4de:	6609                	lui	a2,0x2
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4e0:	6689                	lui	a3,0x2
 4e2:	07868693          	addi	a3,a3,120 # 2078 <__global_pointer$+0x42c>
 4e6:	00009597          	auipc	a1,0x9
 4ea:	17258593          	addi	a1,a1,370 # 9658 <base>
    if (t->state == FREE) break;
 4ee:	00c78733          	add	a4,a5,a2
 4f2:	4318                	lw	a4,0(a4)
 4f4:	c701                	beqz	a4,4fc <thread_create+0x2c>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 4f6:	97b6                	add	a5,a5,a3
 4f8:	feb79be3          	bne	a5,a1,4ee <thread_create+0x1e>
  }
  t->state = RUNNABLE;
 4fc:	6709                	lui	a4,0x2
 4fe:	00e786b3          	add	a3,a5,a4
 502:	4609                	li	a2,2
 504:	c290                	sw	a2,0(a3)
  t->context.sp = (uint64)&t->stack[STACK_SIZE-1];
 506:	177d                	addi	a4,a4,-1 # 1fff <__global_pointer$+0x3b3>
 508:	97ba                	add	a5,a5,a4
 50a:	ea9c                	sd	a5,16(a3)
  t->context.ra = (uint64)(*func);
 50c:	e688                	sd	a0,8(a3)
}
 50e:	6422                	ld	s0,8(sp)
 510:	0141                	addi	sp,sp,16
 512:	8082                	ret

0000000000000514 <thread_yield>:

void 
thread_yield(void)
{
 514:	1141                	addi	sp,sp,-16
 516:	e406                	sd	ra,8(sp)
 518:	e022                	sd	s0,0(sp)
 51a:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
 51c:	00001797          	auipc	a5,0x1
 520:	f4c7b783          	ld	a5,-180(a5) # 1468 <current_thread>
 524:	6709                	lui	a4,0x2
 526:	97ba                	add	a5,a5,a4
 528:	4709                	li	a4,2
 52a:	c398                	sw	a4,0(a5)
  thread_schedule();
 52c:	00000097          	auipc	ra,0x0
 530:	e80080e7          	jalr	-384(ra) # 3ac <thread_schedule>
}
 534:	60a2                	ld	ra,8(sp)
 536:	6402                	ld	s0,0(sp)
 538:	0141                	addi	sp,sp,16
 53a:	8082                	ret

000000000000053c <thread_switch>:
         */

	.globl thread_switch
thread_switch:
	# Save old thread context (a0 = old, a1 = new).
	sd ra, 0(a0)
 53c:	00153023          	sd	ra,0(a0)
	sd sp, 8(a0)
 540:	00253423          	sd	sp,8(a0)
	sd s0, 16(a0)
 544:	e900                	sd	s0,16(a0)
	sd s1, 24(a0)
 546:	ed04                	sd	s1,24(a0)
	sd s2, 32(a0)
 548:	03253023          	sd	s2,32(a0)
	sd s3, 40(a0)
 54c:	03353423          	sd	s3,40(a0)
	sd s4, 48(a0)
 550:	03453823          	sd	s4,48(a0)
	sd s5, 56(a0)
 554:	03553c23          	sd	s5,56(a0)
	sd s6, 64(a0)
 558:	05653023          	sd	s6,64(a0)
	sd s7, 72(a0)
 55c:	05753423          	sd	s7,72(a0)
	sd s8, 80(a0)
 560:	05853823          	sd	s8,80(a0)
	sd s9, 88(a0)
 564:	05953c23          	sd	s9,88(a0)
	sd s10, 96(a0)
 568:	07a53023          	sd	s10,96(a0)
	sd s11, 104(a0)
 56c:	07b53423          	sd	s11,104(a0)

	# Restore new thread context.
	ld ra, 0(a1)
 570:	0005b083          	ld	ra,0(a1)
	ld sp, 8(a1)
 574:	0085b103          	ld	sp,8(a1)
	ld s0, 16(a1)
 578:	6980                	ld	s0,16(a1)
	ld s1, 24(a1)
 57a:	6d84                	ld	s1,24(a1)
	ld s2, 32(a1)
 57c:	0205b903          	ld	s2,32(a1)
	ld s3, 40(a1)
 580:	0285b983          	ld	s3,40(a1)
	ld s4, 48(a1)
 584:	0305ba03          	ld	s4,48(a1)
	ld s5, 56(a1)
 588:	0385ba83          	ld	s5,56(a1)
	ld s6, 64(a1)
 58c:	0405bb03          	ld	s6,64(a1)
	ld s7, 72(a1)
 590:	0485bb83          	ld	s7,72(a1)
	ld s8, 80(a1)
 594:	0505bc03          	ld	s8,80(a1)
	ld s9, 88(a1)
 598:	0585bc83          	ld	s9,88(a1)
	ld s10, 96(a1)
 59c:	0605bd03          	ld	s10,96(a1)
	ld s11, 104(a1)
 5a0:	0685bd83          	ld	s11,104(a1)
	ret    /* return to ra */
 5a4:	8082                	ret

00000000000005a6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 5a6:	1141                	addi	sp,sp,-16
 5a8:	e406                	sd	ra,8(sp)
 5aa:	e022                	sd	s0,0(sp)
 5ac:	0800                	addi	s0,sp,16
  extern int main();
  main();
 5ae:	00000097          	auipc	ra,0x0
 5b2:	cee080e7          	jalr	-786(ra) # 29c <main>
  exit(0);
 5b6:	4501                	li	a0,0
 5b8:	00000097          	auipc	ra,0x0
 5bc:	274080e7          	jalr	628(ra) # 82c <exit>

00000000000005c0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 5c0:	1141                	addi	sp,sp,-16
 5c2:	e422                	sd	s0,8(sp)
 5c4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5c6:	87aa                	mv	a5,a0
 5c8:	0585                	addi	a1,a1,1
 5ca:	0785                	addi	a5,a5,1
 5cc:	fff5c703          	lbu	a4,-1(a1)
 5d0:	fee78fa3          	sb	a4,-1(a5)
 5d4:	fb75                	bnez	a4,5c8 <strcpy+0x8>
    ;
  return os;
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret

00000000000005dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 5e2:	00054783          	lbu	a5,0(a0)
 5e6:	cb91                	beqz	a5,5fa <strcmp+0x1e>
 5e8:	0005c703          	lbu	a4,0(a1)
 5ec:	00f71763          	bne	a4,a5,5fa <strcmp+0x1e>
    p++, q++;
 5f0:	0505                	addi	a0,a0,1
 5f2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5f4:	00054783          	lbu	a5,0(a0)
 5f8:	fbe5                	bnez	a5,5e8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5fa:	0005c503          	lbu	a0,0(a1)
}
 5fe:	40a7853b          	subw	a0,a5,a0
 602:	6422                	ld	s0,8(sp)
 604:	0141                	addi	sp,sp,16
 606:	8082                	ret

0000000000000608 <strlen>:

uint
strlen(const char *s)
{
 608:	1141                	addi	sp,sp,-16
 60a:	e422                	sd	s0,8(sp)
 60c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 60e:	00054783          	lbu	a5,0(a0)
 612:	cf91                	beqz	a5,62e <strlen+0x26>
 614:	0505                	addi	a0,a0,1
 616:	87aa                	mv	a5,a0
 618:	86be                	mv	a3,a5
 61a:	0785                	addi	a5,a5,1
 61c:	fff7c703          	lbu	a4,-1(a5)
 620:	ff65                	bnez	a4,618 <strlen+0x10>
 622:	40a6853b          	subw	a0,a3,a0
 626:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 628:	6422                	ld	s0,8(sp)
 62a:	0141                	addi	sp,sp,16
 62c:	8082                	ret
  for(n = 0; s[n]; n++)
 62e:	4501                	li	a0,0
 630:	bfe5                	j	628 <strlen+0x20>

0000000000000632 <memset>:

void*
memset(void *dst, int c, uint n)
{
 632:	1141                	addi	sp,sp,-16
 634:	e422                	sd	s0,8(sp)
 636:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 638:	ca19                	beqz	a2,64e <memset+0x1c>
 63a:	87aa                	mv	a5,a0
 63c:	1602                	slli	a2,a2,0x20
 63e:	9201                	srli	a2,a2,0x20
 640:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 644:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 648:	0785                	addi	a5,a5,1
 64a:	fee79de3          	bne	a5,a4,644 <memset+0x12>
  }
  return dst;
}
 64e:	6422                	ld	s0,8(sp)
 650:	0141                	addi	sp,sp,16
 652:	8082                	ret

0000000000000654 <strchr>:

char*
strchr(const char *s, char c)
{
 654:	1141                	addi	sp,sp,-16
 656:	e422                	sd	s0,8(sp)
 658:	0800                	addi	s0,sp,16
  for(; *s; s++)
 65a:	00054783          	lbu	a5,0(a0)
 65e:	cb99                	beqz	a5,674 <strchr+0x20>
    if(*s == c)
 660:	00f58763          	beq	a1,a5,66e <strchr+0x1a>
  for(; *s; s++)
 664:	0505                	addi	a0,a0,1
 666:	00054783          	lbu	a5,0(a0)
 66a:	fbfd                	bnez	a5,660 <strchr+0xc>
      return (char*)s;
  return 0;
 66c:	4501                	li	a0,0
}
 66e:	6422                	ld	s0,8(sp)
 670:	0141                	addi	sp,sp,16
 672:	8082                	ret
  return 0;
 674:	4501                	li	a0,0
 676:	bfe5                	j	66e <strchr+0x1a>

0000000000000678 <gets>:

char*
gets(char *buf, int max)
{
 678:	711d                	addi	sp,sp,-96
 67a:	ec86                	sd	ra,88(sp)
 67c:	e8a2                	sd	s0,80(sp)
 67e:	e4a6                	sd	s1,72(sp)
 680:	e0ca                	sd	s2,64(sp)
 682:	fc4e                	sd	s3,56(sp)
 684:	f852                	sd	s4,48(sp)
 686:	f456                	sd	s5,40(sp)
 688:	f05a                	sd	s6,32(sp)
 68a:	ec5e                	sd	s7,24(sp)
 68c:	1080                	addi	s0,sp,96
 68e:	8baa                	mv	s7,a0
 690:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 692:	892a                	mv	s2,a0
 694:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 696:	4aa9                	li	s5,10
 698:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 69a:	89a6                	mv	s3,s1
 69c:	2485                	addiw	s1,s1,1
 69e:	0344d863          	bge	s1,s4,6ce <gets+0x56>
    cc = read(0, &c, 1);
 6a2:	4605                	li	a2,1
 6a4:	faf40593          	addi	a1,s0,-81
 6a8:	4501                	li	a0,0
 6aa:	00000097          	auipc	ra,0x0
 6ae:	19a080e7          	jalr	410(ra) # 844 <read>
    if(cc < 1)
 6b2:	00a05e63          	blez	a0,6ce <gets+0x56>
    buf[i++] = c;
 6b6:	faf44783          	lbu	a5,-81(s0)
 6ba:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 6be:	01578763          	beq	a5,s5,6cc <gets+0x54>
 6c2:	0905                	addi	s2,s2,1
 6c4:	fd679be3          	bne	a5,s6,69a <gets+0x22>
    buf[i++] = c;
 6c8:	89a6                	mv	s3,s1
 6ca:	a011                	j	6ce <gets+0x56>
 6cc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 6ce:	99de                	add	s3,s3,s7
 6d0:	00098023          	sb	zero,0(s3)
  return buf;
}
 6d4:	855e                	mv	a0,s7
 6d6:	60e6                	ld	ra,88(sp)
 6d8:	6446                	ld	s0,80(sp)
 6da:	64a6                	ld	s1,72(sp)
 6dc:	6906                	ld	s2,64(sp)
 6de:	79e2                	ld	s3,56(sp)
 6e0:	7a42                	ld	s4,48(sp)
 6e2:	7aa2                	ld	s5,40(sp)
 6e4:	7b02                	ld	s6,32(sp)
 6e6:	6be2                	ld	s7,24(sp)
 6e8:	6125                	addi	sp,sp,96
 6ea:	8082                	ret

00000000000006ec <stat>:

int
stat(const char *n, struct stat *st)
{
 6ec:	1101                	addi	sp,sp,-32
 6ee:	ec06                	sd	ra,24(sp)
 6f0:	e822                	sd	s0,16(sp)
 6f2:	e04a                	sd	s2,0(sp)
 6f4:	1000                	addi	s0,sp,32
 6f6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6f8:	4581                	li	a1,0
 6fa:	00000097          	auipc	ra,0x0
 6fe:	172080e7          	jalr	370(ra) # 86c <open>
  if(fd < 0)
 702:	02054663          	bltz	a0,72e <stat+0x42>
 706:	e426                	sd	s1,8(sp)
 708:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 70a:	85ca                	mv	a1,s2
 70c:	00000097          	auipc	ra,0x0
 710:	178080e7          	jalr	376(ra) # 884 <fstat>
 714:	892a                	mv	s2,a0
  close(fd);
 716:	8526                	mv	a0,s1
 718:	00000097          	auipc	ra,0x0
 71c:	13c080e7          	jalr	316(ra) # 854 <close>
  return r;
 720:	64a2                	ld	s1,8(sp)
}
 722:	854a                	mv	a0,s2
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6902                	ld	s2,0(sp)
 72a:	6105                	addi	sp,sp,32
 72c:	8082                	ret
    return -1;
 72e:	597d                	li	s2,-1
 730:	bfcd                	j	722 <stat+0x36>

0000000000000732 <atoi>:

int
atoi(const char *s)
{
 732:	1141                	addi	sp,sp,-16
 734:	e422                	sd	s0,8(sp)
 736:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 738:	00054683          	lbu	a3,0(a0)
 73c:	fd06879b          	addiw	a5,a3,-48
 740:	0ff7f793          	zext.b	a5,a5
 744:	4625                	li	a2,9
 746:	02f66863          	bltu	a2,a5,776 <atoi+0x44>
 74a:	872a                	mv	a4,a0
  n = 0;
 74c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 74e:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0x3b5>
 750:	0025179b          	slliw	a5,a0,0x2
 754:	9fa9                	addw	a5,a5,a0
 756:	0017979b          	slliw	a5,a5,0x1
 75a:	9fb5                	addw	a5,a5,a3
 75c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 760:	00074683          	lbu	a3,0(a4)
 764:	fd06879b          	addiw	a5,a3,-48
 768:	0ff7f793          	zext.b	a5,a5
 76c:	fef671e3          	bgeu	a2,a5,74e <atoi+0x1c>
  return n;
}
 770:	6422                	ld	s0,8(sp)
 772:	0141                	addi	sp,sp,16
 774:	8082                	ret
  n = 0;
 776:	4501                	li	a0,0
 778:	bfe5                	j	770 <atoi+0x3e>

000000000000077a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 77a:	1141                	addi	sp,sp,-16
 77c:	e422                	sd	s0,8(sp)
 77e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 780:	02b57463          	bgeu	a0,a1,7a8 <memmove+0x2e>
    while(n-- > 0)
 784:	00c05f63          	blez	a2,7a2 <memmove+0x28>
 788:	1602                	slli	a2,a2,0x20
 78a:	9201                	srli	a2,a2,0x20
 78c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 790:	872a                	mv	a4,a0
      *dst++ = *src++;
 792:	0585                	addi	a1,a1,1
 794:	0705                	addi	a4,a4,1
 796:	fff5c683          	lbu	a3,-1(a1)
 79a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 79e:	fef71ae3          	bne	a4,a5,792 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 7a2:	6422                	ld	s0,8(sp)
 7a4:	0141                	addi	sp,sp,16
 7a6:	8082                	ret
    dst += n;
 7a8:	00c50733          	add	a4,a0,a2
    src += n;
 7ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 7ae:	fec05ae3          	blez	a2,7a2 <memmove+0x28>
 7b2:	fff6079b          	addiw	a5,a2,-1 # 1fff <__global_pointer$+0x3b3>
 7b6:	1782                	slli	a5,a5,0x20
 7b8:	9381                	srli	a5,a5,0x20
 7ba:	fff7c793          	not	a5,a5
 7be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 7c0:	15fd                	addi	a1,a1,-1
 7c2:	177d                	addi	a4,a4,-1
 7c4:	0005c683          	lbu	a3,0(a1)
 7c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 7cc:	fee79ae3          	bne	a5,a4,7c0 <memmove+0x46>
 7d0:	bfc9                	j	7a2 <memmove+0x28>

00000000000007d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 7d2:	1141                	addi	sp,sp,-16
 7d4:	e422                	sd	s0,8(sp)
 7d6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 7d8:	ca05                	beqz	a2,808 <memcmp+0x36>
 7da:	fff6069b          	addiw	a3,a2,-1
 7de:	1682                	slli	a3,a3,0x20
 7e0:	9281                	srli	a3,a3,0x20
 7e2:	0685                	addi	a3,a3,1
 7e4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7e6:	00054783          	lbu	a5,0(a0)
 7ea:	0005c703          	lbu	a4,0(a1)
 7ee:	00e79863          	bne	a5,a4,7fe <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7f2:	0505                	addi	a0,a0,1
    p2++;
 7f4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7f6:	fed518e3          	bne	a0,a3,7e6 <memcmp+0x14>
  }
  return 0;
 7fa:	4501                	li	a0,0
 7fc:	a019                	j	802 <memcmp+0x30>
      return *p1 - *p2;
 7fe:	40e7853b          	subw	a0,a5,a4
}
 802:	6422                	ld	s0,8(sp)
 804:	0141                	addi	sp,sp,16
 806:	8082                	ret
  return 0;
 808:	4501                	li	a0,0
 80a:	bfe5                	j	802 <memcmp+0x30>

000000000000080c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 80c:	1141                	addi	sp,sp,-16
 80e:	e406                	sd	ra,8(sp)
 810:	e022                	sd	s0,0(sp)
 812:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 814:	00000097          	auipc	ra,0x0
 818:	f66080e7          	jalr	-154(ra) # 77a <memmove>
}
 81c:	60a2                	ld	ra,8(sp)
 81e:	6402                	ld	s0,0(sp)
 820:	0141                	addi	sp,sp,16
 822:	8082                	ret

0000000000000824 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 824:	4885                	li	a7,1
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <exit>:
.global exit
exit:
 li a7, SYS_exit
 82c:	4889                	li	a7,2
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <wait>:
.global wait
wait:
 li a7, SYS_wait
 834:	488d                	li	a7,3
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 83c:	4891                	li	a7,4
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <read>:
.global read
read:
 li a7, SYS_read
 844:	4895                	li	a7,5
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <write>:
.global write
write:
 li a7, SYS_write
 84c:	48c1                	li	a7,16
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <close>:
.global close
close:
 li a7, SYS_close
 854:	48d5                	li	a7,21
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <kill>:
.global kill
kill:
 li a7, SYS_kill
 85c:	4899                	li	a7,6
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <exec>:
.global exec
exec:
 li a7, SYS_exec
 864:	489d                	li	a7,7
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <open>:
.global open
open:
 li a7, SYS_open
 86c:	48bd                	li	a7,15
 ecall
 86e:	00000073          	ecall
 ret
 872:	8082                	ret

0000000000000874 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 874:	48c5                	li	a7,17
 ecall
 876:	00000073          	ecall
 ret
 87a:	8082                	ret

000000000000087c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 87c:	48c9                	li	a7,18
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 884:	48a1                	li	a7,8
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <link>:
.global link
link:
 li a7, SYS_link
 88c:	48cd                	li	a7,19
 ecall
 88e:	00000073          	ecall
 ret
 892:	8082                	ret

0000000000000894 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 894:	48d1                	li	a7,20
 ecall
 896:	00000073          	ecall
 ret
 89a:	8082                	ret

000000000000089c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 89c:	48a5                	li	a7,9
 ecall
 89e:	00000073          	ecall
 ret
 8a2:	8082                	ret

00000000000008a4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 8a4:	48a9                	li	a7,10
 ecall
 8a6:	00000073          	ecall
 ret
 8aa:	8082                	ret

00000000000008ac <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 8ac:	48ad                	li	a7,11
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 8b4:	48b1                	li	a7,12
 ecall
 8b6:	00000073          	ecall
 ret
 8ba:	8082                	ret

00000000000008bc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8bc:	48b5                	li	a7,13
 ecall
 8be:	00000073          	ecall
 ret
 8c2:	8082                	ret

00000000000008c4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8c4:	48b9                	li	a7,14
 ecall
 8c6:	00000073          	ecall
 ret
 8ca:	8082                	ret

00000000000008cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8cc:	1101                	addi	sp,sp,-32
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8d8:	4605                	li	a2,1
 8da:	fef40593          	addi	a1,s0,-17
 8de:	00000097          	auipc	ra,0x0
 8e2:	f6e080e7          	jalr	-146(ra) # 84c <write>
}
 8e6:	60e2                	ld	ra,24(sp)
 8e8:	6442                	ld	s0,16(sp)
 8ea:	6105                	addi	sp,sp,32
 8ec:	8082                	ret

00000000000008ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8ee:	7139                	addi	sp,sp,-64
 8f0:	fc06                	sd	ra,56(sp)
 8f2:	f822                	sd	s0,48(sp)
 8f4:	f426                	sd	s1,40(sp)
 8f6:	0080                	addi	s0,sp,64
 8f8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8fa:	c299                	beqz	a3,900 <printint+0x12>
 8fc:	0805cb63          	bltz	a1,992 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 900:	2581                	sext.w	a1,a1
  neg = 0;
 902:	4881                	li	a7,0
 904:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 908:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 90a:	2601                	sext.w	a2,a2
 90c:	00000517          	auipc	a0,0x0
 910:	5d450513          	addi	a0,a0,1492 # ee0 <digits>
 914:	883a                	mv	a6,a4
 916:	2705                	addiw	a4,a4,1
 918:	02c5f7bb          	remuw	a5,a1,a2
 91c:	1782                	slli	a5,a5,0x20
 91e:	9381                	srli	a5,a5,0x20
 920:	97aa                	add	a5,a5,a0
 922:	0007c783          	lbu	a5,0(a5)
 926:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 92a:	0005879b          	sext.w	a5,a1
 92e:	02c5d5bb          	divuw	a1,a1,a2
 932:	0685                	addi	a3,a3,1
 934:	fec7f0e3          	bgeu	a5,a2,914 <printint+0x26>
  if(neg)
 938:	00088c63          	beqz	a7,950 <printint+0x62>
    buf[i++] = '-';
 93c:	fd070793          	addi	a5,a4,-48
 940:	00878733          	add	a4,a5,s0
 944:	02d00793          	li	a5,45
 948:	fef70823          	sb	a5,-16(a4)
 94c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 950:	02e05c63          	blez	a4,988 <printint+0x9a>
 954:	f04a                	sd	s2,32(sp)
 956:	ec4e                	sd	s3,24(sp)
 958:	fc040793          	addi	a5,s0,-64
 95c:	00e78933          	add	s2,a5,a4
 960:	fff78993          	addi	s3,a5,-1
 964:	99ba                	add	s3,s3,a4
 966:	377d                	addiw	a4,a4,-1
 968:	1702                	slli	a4,a4,0x20
 96a:	9301                	srli	a4,a4,0x20
 96c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 970:	fff94583          	lbu	a1,-1(s2)
 974:	8526                	mv	a0,s1
 976:	00000097          	auipc	ra,0x0
 97a:	f56080e7          	jalr	-170(ra) # 8cc <putc>
  while(--i >= 0)
 97e:	197d                	addi	s2,s2,-1
 980:	ff3918e3          	bne	s2,s3,970 <printint+0x82>
 984:	7902                	ld	s2,32(sp)
 986:	69e2                	ld	s3,24(sp)
}
 988:	70e2                	ld	ra,56(sp)
 98a:	7442                	ld	s0,48(sp)
 98c:	74a2                	ld	s1,40(sp)
 98e:	6121                	addi	sp,sp,64
 990:	8082                	ret
    x = -xx;
 992:	40b005bb          	negw	a1,a1
    neg = 1;
 996:	4885                	li	a7,1
    x = -xx;
 998:	b7b5                	j	904 <printint+0x16>

000000000000099a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 99a:	715d                	addi	sp,sp,-80
 99c:	e486                	sd	ra,72(sp)
 99e:	e0a2                	sd	s0,64(sp)
 9a0:	f84a                	sd	s2,48(sp)
 9a2:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 9a4:	0005c903          	lbu	s2,0(a1)
 9a8:	1a090a63          	beqz	s2,b5c <vprintf+0x1c2>
 9ac:	fc26                	sd	s1,56(sp)
 9ae:	f44e                	sd	s3,40(sp)
 9b0:	f052                	sd	s4,32(sp)
 9b2:	ec56                	sd	s5,24(sp)
 9b4:	e85a                	sd	s6,16(sp)
 9b6:	e45e                	sd	s7,8(sp)
 9b8:	8aaa                	mv	s5,a0
 9ba:	8bb2                	mv	s7,a2
 9bc:	00158493          	addi	s1,a1,1
  state = 0;
 9c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9c2:	02500a13          	li	s4,37
 9c6:	4b55                	li	s6,21
 9c8:	a839                	j	9e6 <vprintf+0x4c>
        putc(fd, c);
 9ca:	85ca                	mv	a1,s2
 9cc:	8556                	mv	a0,s5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	efe080e7          	jalr	-258(ra) # 8cc <putc>
 9d6:	a019                	j	9dc <vprintf+0x42>
    } else if(state == '%'){
 9d8:	01498d63          	beq	s3,s4,9f2 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 9dc:	0485                	addi	s1,s1,1
 9de:	fff4c903          	lbu	s2,-1(s1)
 9e2:	16090763          	beqz	s2,b50 <vprintf+0x1b6>
    if(state == 0){
 9e6:	fe0999e3          	bnez	s3,9d8 <vprintf+0x3e>
      if(c == '%'){
 9ea:	ff4910e3          	bne	s2,s4,9ca <vprintf+0x30>
        state = '%';
 9ee:	89d2                	mv	s3,s4
 9f0:	b7f5                	j	9dc <vprintf+0x42>
      if(c == 'd'){
 9f2:	13490463          	beq	s2,s4,b1a <vprintf+0x180>
 9f6:	f9d9079b          	addiw	a5,s2,-99
 9fa:	0ff7f793          	zext.b	a5,a5
 9fe:	12fb6763          	bltu	s6,a5,b2c <vprintf+0x192>
 a02:	f9d9079b          	addiw	a5,s2,-99
 a06:	0ff7f713          	zext.b	a4,a5
 a0a:	12eb6163          	bltu	s6,a4,b2c <vprintf+0x192>
 a0e:	00271793          	slli	a5,a4,0x2
 a12:	00000717          	auipc	a4,0x0
 a16:	47670713          	addi	a4,a4,1142 # e88 <malloc+0x23c>
 a1a:	97ba                	add	a5,a5,a4
 a1c:	439c                	lw	a5,0(a5)
 a1e:	97ba                	add	a5,a5,a4
 a20:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a22:	008b8913          	addi	s2,s7,8
 a26:	4685                	li	a3,1
 a28:	4629                	li	a2,10
 a2a:	000ba583          	lw	a1,0(s7)
 a2e:	8556                	mv	a0,s5
 a30:	00000097          	auipc	ra,0x0
 a34:	ebe080e7          	jalr	-322(ra) # 8ee <printint>
 a38:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a3a:	4981                	li	s3,0
 a3c:	b745                	j	9dc <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a3e:	008b8913          	addi	s2,s7,8
 a42:	4681                	li	a3,0
 a44:	4629                	li	a2,10
 a46:	000ba583          	lw	a1,0(s7)
 a4a:	8556                	mv	a0,s5
 a4c:	00000097          	auipc	ra,0x0
 a50:	ea2080e7          	jalr	-350(ra) # 8ee <printint>
 a54:	8bca                	mv	s7,s2
      state = 0;
 a56:	4981                	li	s3,0
 a58:	b751                	j	9dc <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 a5a:	008b8913          	addi	s2,s7,8
 a5e:	4681                	li	a3,0
 a60:	4641                	li	a2,16
 a62:	000ba583          	lw	a1,0(s7)
 a66:	8556                	mv	a0,s5
 a68:	00000097          	auipc	ra,0x0
 a6c:	e86080e7          	jalr	-378(ra) # 8ee <printint>
 a70:	8bca                	mv	s7,s2
      state = 0;
 a72:	4981                	li	s3,0
 a74:	b7a5                	j	9dc <vprintf+0x42>
 a76:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a78:	008b8c13          	addi	s8,s7,8
 a7c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a80:	03000593          	li	a1,48
 a84:	8556                	mv	a0,s5
 a86:	00000097          	auipc	ra,0x0
 a8a:	e46080e7          	jalr	-442(ra) # 8cc <putc>
  putc(fd, 'x');
 a8e:	07800593          	li	a1,120
 a92:	8556                	mv	a0,s5
 a94:	00000097          	auipc	ra,0x0
 a98:	e38080e7          	jalr	-456(ra) # 8cc <putc>
 a9c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a9e:	00000b97          	auipc	s7,0x0
 aa2:	442b8b93          	addi	s7,s7,1090 # ee0 <digits>
 aa6:	03c9d793          	srli	a5,s3,0x3c
 aaa:	97de                	add	a5,a5,s7
 aac:	0007c583          	lbu	a1,0(a5)
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	e1a080e7          	jalr	-486(ra) # 8cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aba:	0992                	slli	s3,s3,0x4
 abc:	397d                	addiw	s2,s2,-1
 abe:	fe0914e3          	bnez	s2,aa6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 ac2:	8be2                	mv	s7,s8
      state = 0;
 ac4:	4981                	li	s3,0
 ac6:	6c02                	ld	s8,0(sp)
 ac8:	bf11                	j	9dc <vprintf+0x42>
        s = va_arg(ap, char*);
 aca:	008b8993          	addi	s3,s7,8
 ace:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 ad2:	02090163          	beqz	s2,af4 <vprintf+0x15a>
        while(*s != 0){
 ad6:	00094583          	lbu	a1,0(s2)
 ada:	c9a5                	beqz	a1,b4a <vprintf+0x1b0>
          putc(fd, *s);
 adc:	8556                	mv	a0,s5
 ade:	00000097          	auipc	ra,0x0
 ae2:	dee080e7          	jalr	-530(ra) # 8cc <putc>
          s++;
 ae6:	0905                	addi	s2,s2,1
        while(*s != 0){
 ae8:	00094583          	lbu	a1,0(s2)
 aec:	f9e5                	bnez	a1,adc <vprintf+0x142>
        s = va_arg(ap, char*);
 aee:	8bce                	mv	s7,s3
      state = 0;
 af0:	4981                	li	s3,0
 af2:	b5ed                	j	9dc <vprintf+0x42>
          s = "(null)";
 af4:	00000917          	auipc	s2,0x0
 af8:	38c90913          	addi	s2,s2,908 # e80 <malloc+0x234>
        while(*s != 0){
 afc:	02800593          	li	a1,40
 b00:	bff1                	j	adc <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 b02:	008b8913          	addi	s2,s7,8
 b06:	000bc583          	lbu	a1,0(s7)
 b0a:	8556                	mv	a0,s5
 b0c:	00000097          	auipc	ra,0x0
 b10:	dc0080e7          	jalr	-576(ra) # 8cc <putc>
 b14:	8bca                	mv	s7,s2
      state = 0;
 b16:	4981                	li	s3,0
 b18:	b5d1                	j	9dc <vprintf+0x42>
        putc(fd, c);
 b1a:	02500593          	li	a1,37
 b1e:	8556                	mv	a0,s5
 b20:	00000097          	auipc	ra,0x0
 b24:	dac080e7          	jalr	-596(ra) # 8cc <putc>
      state = 0;
 b28:	4981                	li	s3,0
 b2a:	bd4d                	j	9dc <vprintf+0x42>
        putc(fd, '%');
 b2c:	02500593          	li	a1,37
 b30:	8556                	mv	a0,s5
 b32:	00000097          	auipc	ra,0x0
 b36:	d9a080e7          	jalr	-614(ra) # 8cc <putc>
        putc(fd, c);
 b3a:	85ca                	mv	a1,s2
 b3c:	8556                	mv	a0,s5
 b3e:	00000097          	auipc	ra,0x0
 b42:	d8e080e7          	jalr	-626(ra) # 8cc <putc>
      state = 0;
 b46:	4981                	li	s3,0
 b48:	bd51                	j	9dc <vprintf+0x42>
        s = va_arg(ap, char*);
 b4a:	8bce                	mv	s7,s3
      state = 0;
 b4c:	4981                	li	s3,0
 b4e:	b579                	j	9dc <vprintf+0x42>
 b50:	74e2                	ld	s1,56(sp)
 b52:	79a2                	ld	s3,40(sp)
 b54:	7a02                	ld	s4,32(sp)
 b56:	6ae2                	ld	s5,24(sp)
 b58:	6b42                	ld	s6,16(sp)
 b5a:	6ba2                	ld	s7,8(sp)
    }
  }
}
 b5c:	60a6                	ld	ra,72(sp)
 b5e:	6406                	ld	s0,64(sp)
 b60:	7942                	ld	s2,48(sp)
 b62:	6161                	addi	sp,sp,80
 b64:	8082                	ret

0000000000000b66 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b66:	715d                	addi	sp,sp,-80
 b68:	ec06                	sd	ra,24(sp)
 b6a:	e822                	sd	s0,16(sp)
 b6c:	1000                	addi	s0,sp,32
 b6e:	e010                	sd	a2,0(s0)
 b70:	e414                	sd	a3,8(s0)
 b72:	e818                	sd	a4,16(s0)
 b74:	ec1c                	sd	a5,24(s0)
 b76:	03043023          	sd	a6,32(s0)
 b7a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b7e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b82:	8622                	mv	a2,s0
 b84:	00000097          	auipc	ra,0x0
 b88:	e16080e7          	jalr	-490(ra) # 99a <vprintf>
}
 b8c:	60e2                	ld	ra,24(sp)
 b8e:	6442                	ld	s0,16(sp)
 b90:	6161                	addi	sp,sp,80
 b92:	8082                	ret

0000000000000b94 <printf>:

void
printf(const char *fmt, ...)
{
 b94:	711d                	addi	sp,sp,-96
 b96:	ec06                	sd	ra,24(sp)
 b98:	e822                	sd	s0,16(sp)
 b9a:	1000                	addi	s0,sp,32
 b9c:	e40c                	sd	a1,8(s0)
 b9e:	e810                	sd	a2,16(s0)
 ba0:	ec14                	sd	a3,24(s0)
 ba2:	f018                	sd	a4,32(s0)
 ba4:	f41c                	sd	a5,40(s0)
 ba6:	03043823          	sd	a6,48(s0)
 baa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bae:	00840613          	addi	a2,s0,8
 bb2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bb6:	85aa                	mv	a1,a0
 bb8:	4505                	li	a0,1
 bba:	00000097          	auipc	ra,0x0
 bbe:	de0080e7          	jalr	-544(ra) # 99a <vprintf>
}
 bc2:	60e2                	ld	ra,24(sp)
 bc4:	6442                	ld	s0,16(sp)
 bc6:	6125                	addi	sp,sp,96
 bc8:	8082                	ret

0000000000000bca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bca:	1141                	addi	sp,sp,-16
 bcc:	e422                	sd	s0,8(sp)
 bce:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bd0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bd4:	00001797          	auipc	a5,0x1
 bd8:	89c7b783          	ld	a5,-1892(a5) # 1470 <freep>
 bdc:	a02d                	j	c06 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bde:	4618                	lw	a4,8(a2)
 be0:	9f2d                	addw	a4,a4,a1
 be2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 be6:	6398                	ld	a4,0(a5)
 be8:	6310                	ld	a2,0(a4)
 bea:	a83d                	j	c28 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bec:	ff852703          	lw	a4,-8(a0)
 bf0:	9f31                	addw	a4,a4,a2
 bf2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bf4:	ff053683          	ld	a3,-16(a0)
 bf8:	a091                	j	c3c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bfa:	6398                	ld	a4,0(a5)
 bfc:	00e7e463          	bltu	a5,a4,c04 <free+0x3a>
 c00:	00e6ea63          	bltu	a3,a4,c14 <free+0x4a>
{
 c04:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c06:	fed7fae3          	bgeu	a5,a3,bfa <free+0x30>
 c0a:	6398                	ld	a4,0(a5)
 c0c:	00e6e463          	bltu	a3,a4,c14 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c10:	fee7eae3          	bltu	a5,a4,c04 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c14:	ff852583          	lw	a1,-8(a0)
 c18:	6390                	ld	a2,0(a5)
 c1a:	02059813          	slli	a6,a1,0x20
 c1e:	01c85713          	srli	a4,a6,0x1c
 c22:	9736                	add	a4,a4,a3
 c24:	fae60de3          	beq	a2,a4,bde <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c28:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c2c:	4790                	lw	a2,8(a5)
 c2e:	02061593          	slli	a1,a2,0x20
 c32:	01c5d713          	srli	a4,a1,0x1c
 c36:	973e                	add	a4,a4,a5
 c38:	fae68ae3          	beq	a3,a4,bec <free+0x22>
    p->s.ptr = bp->s.ptr;
 c3c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c3e:	00001717          	auipc	a4,0x1
 c42:	82f73923          	sd	a5,-1998(a4) # 1470 <freep>
}
 c46:	6422                	ld	s0,8(sp)
 c48:	0141                	addi	sp,sp,16
 c4a:	8082                	ret

0000000000000c4c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c4c:	7139                	addi	sp,sp,-64
 c4e:	fc06                	sd	ra,56(sp)
 c50:	f822                	sd	s0,48(sp)
 c52:	f426                	sd	s1,40(sp)
 c54:	ec4e                	sd	s3,24(sp)
 c56:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c58:	02051493          	slli	s1,a0,0x20
 c5c:	9081                	srli	s1,s1,0x20
 c5e:	04bd                	addi	s1,s1,15
 c60:	8091                	srli	s1,s1,0x4
 c62:	0014899b          	addiw	s3,s1,1
 c66:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c68:	00001517          	auipc	a0,0x1
 c6c:	80853503          	ld	a0,-2040(a0) # 1470 <freep>
 c70:	c915                	beqz	a0,ca4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c72:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c74:	4798                	lw	a4,8(a5)
 c76:	08977e63          	bgeu	a4,s1,d12 <malloc+0xc6>
 c7a:	f04a                	sd	s2,32(sp)
 c7c:	e852                	sd	s4,16(sp)
 c7e:	e456                	sd	s5,8(sp)
 c80:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c82:	8a4e                	mv	s4,s3
 c84:	0009871b          	sext.w	a4,s3
 c88:	6685                	lui	a3,0x1
 c8a:	00d77363          	bgeu	a4,a3,c90 <malloc+0x44>
 c8e:	6a05                	lui	s4,0x1
 c90:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c94:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c98:	00000917          	auipc	s2,0x0
 c9c:	7d890913          	addi	s2,s2,2008 # 1470 <freep>
  if(p == (char*)-1)
 ca0:	5afd                	li	s5,-1
 ca2:	a091                	j	ce6 <malloc+0x9a>
 ca4:	f04a                	sd	s2,32(sp)
 ca6:	e852                	sd	s4,16(sp)
 ca8:	e456                	sd	s5,8(sp)
 caa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 cac:	00009797          	auipc	a5,0x9
 cb0:	9ac78793          	addi	a5,a5,-1620 # 9658 <base>
 cb4:	00000717          	auipc	a4,0x0
 cb8:	7af73e23          	sd	a5,1980(a4) # 1470 <freep>
 cbc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cbe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cc2:	b7c1                	j	c82 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 cc4:	6398                	ld	a4,0(a5)
 cc6:	e118                	sd	a4,0(a0)
 cc8:	a08d                	j	d2a <malloc+0xde>
  hp->s.size = nu;
 cca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cce:	0541                	addi	a0,a0,16
 cd0:	00000097          	auipc	ra,0x0
 cd4:	efa080e7          	jalr	-262(ra) # bca <free>
  return freep;
 cd8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cdc:	c13d                	beqz	a0,d42 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cde:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ce0:	4798                	lw	a4,8(a5)
 ce2:	02977463          	bgeu	a4,s1,d0a <malloc+0xbe>
    if(p == freep)
 ce6:	00093703          	ld	a4,0(s2)
 cea:	853e                	mv	a0,a5
 cec:	fef719e3          	bne	a4,a5,cde <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 cf0:	8552                	mv	a0,s4
 cf2:	00000097          	auipc	ra,0x0
 cf6:	bc2080e7          	jalr	-1086(ra) # 8b4 <sbrk>
  if(p == (char*)-1)
 cfa:	fd5518e3          	bne	a0,s5,cca <malloc+0x7e>
        return 0;
 cfe:	4501                	li	a0,0
 d00:	7902                	ld	s2,32(sp)
 d02:	6a42                	ld	s4,16(sp)
 d04:	6aa2                	ld	s5,8(sp)
 d06:	6b02                	ld	s6,0(sp)
 d08:	a03d                	j	d36 <malloc+0xea>
 d0a:	7902                	ld	s2,32(sp)
 d0c:	6a42                	ld	s4,16(sp)
 d0e:	6aa2                	ld	s5,8(sp)
 d10:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 d12:	fae489e3          	beq	s1,a4,cc4 <malloc+0x78>
        p->s.size -= nunits;
 d16:	4137073b          	subw	a4,a4,s3
 d1a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 d1c:	02071693          	slli	a3,a4,0x20
 d20:	01c6d713          	srli	a4,a3,0x1c
 d24:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d26:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d2a:	00000717          	auipc	a4,0x0
 d2e:	74a73323          	sd	a0,1862(a4) # 1470 <freep>
      return (void*)(p + 1);
 d32:	01078513          	addi	a0,a5,16
  }
}
 d36:	70e2                	ld	ra,56(sp)
 d38:	7442                	ld	s0,48(sp)
 d3a:	74a2                	ld	s1,40(sp)
 d3c:	69e2                	ld	s3,24(sp)
 d3e:	6121                	addi	sp,sp,64
 d40:	8082                	ret
 d42:	7902                	ld	s2,32(sp)
 d44:	6a42                	ld	s4,16(sp)
 d46:	6aa2                	ld	s5,8(sp)
 d48:	6b02                	ld	s6,0(sp)
 d4a:	b7f5                	j	d36 <malloc+0xea>
