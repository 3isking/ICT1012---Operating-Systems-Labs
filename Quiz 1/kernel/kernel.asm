
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	1a813103          	ld	sp,424(sp) # 8000a1a8 <_GLOBAL_OFFSET_TABLE_+0x8>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
        csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
        # jump to start() in start.c
        call start
    80000016:	679040ef          	jal	80004e8e <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	e7a9                	bnez	a5,80000076 <kfree+0x5a>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00023797          	auipc	a5,0x23
    80000034:	4c878793          	addi	a5,a5,1224 # 800234f8 <end>
    80000038:	02f56f63          	bltu	a0,a5,80000076 <kfree+0x5a>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	02f57b63          	bgeu	a0,a5,80000076 <kfree+0x5a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	106000ef          	jal	8000014e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    8000004c:	0000a917          	auipc	s2,0xa
    80000050:	1a490913          	addi	s2,s2,420 # 8000a1f0 <kmem>
    80000054:	854a                	mv	a0,s2
    80000056:	075050ef          	jal	800058ca <acquire>
  r->next = kmem.freelist;
    8000005a:	01893783          	ld	a5,24(s2)
    8000005e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000060:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000064:	854a                	mv	a0,s2
    80000066:	0fd050ef          	jal	80005962 <release>
}
    8000006a:	60e2                	ld	ra,24(sp)
    8000006c:	6442                	ld	s0,16(sp)
    8000006e:	64a2                	ld	s1,8(sp)
    80000070:	6902                	ld	s2,0(sp)
    80000072:	6105                	addi	sp,sp,32
    80000074:	8082                	ret
    panic("kfree");
    80000076:	00007517          	auipc	a0,0x7
    8000007a:	f8a50513          	addi	a0,a0,-118 # 80007000 <etext>
    8000007e:	590050ef          	jal	8000560e <panic>

0000000080000082 <freerange>:
{
    80000082:	7179                	addi	sp,sp,-48
    80000084:	f406                	sd	ra,40(sp)
    80000086:	f022                	sd	s0,32(sp)
    80000088:	ec26                	sd	s1,24(sp)
    8000008a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000008c:	6785                	lui	a5,0x1
    8000008e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000092:	00e504b3          	add	s1,a0,a4
    80000096:	777d                	lui	a4,0xfffff
    80000098:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000009a:	94be                	add	s1,s1,a5
    8000009c:	0295e263          	bltu	a1,s1,800000c0 <freerange+0x3e>
    800000a0:	e84a                	sd	s2,16(sp)
    800000a2:	e44e                	sd	s3,8(sp)
    800000a4:	e052                	sd	s4,0(sp)
    800000a6:	892e                	mv	s2,a1
    kfree(p);
    800000a8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	6985                	lui	s3,0x1
    kfree(p);
    800000ac:	01448533          	add	a0,s1,s4
    800000b0:	f6dff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b4:	94ce                	add	s1,s1,s3
    800000b6:	fe997be3          	bgeu	s2,s1,800000ac <freerange+0x2a>
    800000ba:	6942                	ld	s2,16(sp)
    800000bc:	69a2                	ld	s3,8(sp)
    800000be:	6a02                	ld	s4,0(sp)
}
    800000c0:	70a2                	ld	ra,40(sp)
    800000c2:	7402                	ld	s0,32(sp)
    800000c4:	64e2                	ld	s1,24(sp)
    800000c6:	6145                	addi	sp,sp,48
    800000c8:	8082                	ret

00000000800000ca <kinit>:
{
    800000ca:	1141                	addi	sp,sp,-16
    800000cc:	e406                	sd	ra,8(sp)
    800000ce:	e022                	sd	s0,0(sp)
    800000d0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d2:	00007597          	auipc	a1,0x7
    800000d6:	f3e58593          	addi	a1,a1,-194 # 80007010 <etext+0x10>
    800000da:	0000a517          	auipc	a0,0xa
    800000de:	11650513          	addi	a0,a0,278 # 8000a1f0 <kmem>
    800000e2:	768050ef          	jal	8000584a <initlock>
  freerange(end, (void*)PHYSTOP);
    800000e6:	45c5                	li	a1,17
    800000e8:	05ee                	slli	a1,a1,0x1b
    800000ea:	00023517          	auipc	a0,0x23
    800000ee:	40e50513          	addi	a0,a0,1038 # 800234f8 <end>
    800000f2:	f91ff0ef          	jal	80000082 <freerange>
}
    800000f6:	60a2                	ld	ra,8(sp)
    800000f8:	6402                	ld	s0,0(sp)
    800000fa:	0141                	addi	sp,sp,16
    800000fc:	8082                	ret

00000000800000fe <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800000fe:	1101                	addi	sp,sp,-32
    80000100:	ec06                	sd	ra,24(sp)
    80000102:	e822                	sd	s0,16(sp)
    80000104:	e426                	sd	s1,8(sp)
    80000106:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000108:	0000a497          	auipc	s1,0xa
    8000010c:	0e848493          	addi	s1,s1,232 # 8000a1f0 <kmem>
    80000110:	8526                	mv	a0,s1
    80000112:	7b8050ef          	jal	800058ca <acquire>
  r = kmem.freelist;
    80000116:	6c84                	ld	s1,24(s1)
  if(r)
    80000118:	c485                	beqz	s1,80000140 <kalloc+0x42>
    kmem.freelist = r->next;
    8000011a:	609c                	ld	a5,0(s1)
    8000011c:	0000a517          	auipc	a0,0xa
    80000120:	0d450513          	addi	a0,a0,212 # 8000a1f0 <kmem>
    80000124:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000126:	03d050ef          	jal	80005962 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000012a:	6605                	lui	a2,0x1
    8000012c:	4595                	li	a1,5
    8000012e:	8526                	mv	a0,s1
    80000130:	01e000ef          	jal	8000014e <memset>
  return (void*)r;
}
    80000134:	8526                	mv	a0,s1
    80000136:	60e2                	ld	ra,24(sp)
    80000138:	6442                	ld	s0,16(sp)
    8000013a:	64a2                	ld	s1,8(sp)
    8000013c:	6105                	addi	sp,sp,32
    8000013e:	8082                	ret
  release(&kmem.lock);
    80000140:	0000a517          	auipc	a0,0xa
    80000144:	0b050513          	addi	a0,a0,176 # 8000a1f0 <kmem>
    80000148:	01b050ef          	jal	80005962 <release>
  if(r)
    8000014c:	b7e5                	j	80000134 <kalloc+0x36>

000000008000014e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000014e:	1141                	addi	sp,sp,-16
    80000150:	e422                	sd	s0,8(sp)
    80000152:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000154:	ca19                	beqz	a2,8000016a <memset+0x1c>
    80000156:	87aa                	mv	a5,a0
    80000158:	1602                	slli	a2,a2,0x20
    8000015a:	9201                	srli	a2,a2,0x20
    8000015c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000160:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000164:	0785                	addi	a5,a5,1
    80000166:	fee79de3          	bne	a5,a4,80000160 <memset+0x12>
  }
  return dst;
}
    8000016a:	6422                	ld	s0,8(sp)
    8000016c:	0141                	addi	sp,sp,16
    8000016e:	8082                	ret

0000000080000170 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000170:	1141                	addi	sp,sp,-16
    80000172:	e422                	sd	s0,8(sp)
    80000174:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000176:	ca05                	beqz	a2,800001a6 <memcmp+0x36>
    80000178:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    8000017c:	1682                	slli	a3,a3,0x20
    8000017e:	9281                	srli	a3,a3,0x20
    80000180:	0685                	addi	a3,a3,1
    80000182:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000184:	00054783          	lbu	a5,0(a0)
    80000188:	0005c703          	lbu	a4,0(a1)
    8000018c:	00e79863          	bne	a5,a4,8000019c <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000190:	0505                	addi	a0,a0,1
    80000192:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000194:	fed518e3          	bne	a0,a3,80000184 <memcmp+0x14>
  }

  return 0;
    80000198:	4501                	li	a0,0
    8000019a:	a019                	j	800001a0 <memcmp+0x30>
      return *s1 - *s2;
    8000019c:	40e7853b          	subw	a0,a5,a4
}
    800001a0:	6422                	ld	s0,8(sp)
    800001a2:	0141                	addi	sp,sp,16
    800001a4:	8082                	ret
  return 0;
    800001a6:	4501                	li	a0,0
    800001a8:	bfe5                	j	800001a0 <memcmp+0x30>

00000000800001aa <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001aa:	1141                	addi	sp,sp,-16
    800001ac:	e422                	sd	s0,8(sp)
    800001ae:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001b0:	c205                	beqz	a2,800001d0 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001b2:	02a5e263          	bltu	a1,a0,800001d6 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001b6:	1602                	slli	a2,a2,0x20
    800001b8:	9201                	srli	a2,a2,0x20
    800001ba:	00c587b3          	add	a5,a1,a2
{
    800001be:	872a                	mv	a4,a0
      *d++ = *s++;
    800001c0:	0585                	addi	a1,a1,1
    800001c2:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdbb09>
    800001c4:	fff5c683          	lbu	a3,-1(a1)
    800001c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001cc:	feb79ae3          	bne	a5,a1,800001c0 <memmove+0x16>

  return dst;
}
    800001d0:	6422                	ld	s0,8(sp)
    800001d2:	0141                	addi	sp,sp,16
    800001d4:	8082                	ret
  if(s < d && s + n > d){
    800001d6:	02061693          	slli	a3,a2,0x20
    800001da:	9281                	srli	a3,a3,0x20
    800001dc:	00d58733          	add	a4,a1,a3
    800001e0:	fce57be3          	bgeu	a0,a4,800001b6 <memmove+0xc>
    d += n;
    800001e4:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001e6:	fff6079b          	addiw	a5,a2,-1
    800001ea:	1782                	slli	a5,a5,0x20
    800001ec:	9381                	srli	a5,a5,0x20
    800001ee:	fff7c793          	not	a5,a5
    800001f2:	97ba                	add	a5,a5,a4
      *--d = *--s;
    800001f4:	177d                	addi	a4,a4,-1
    800001f6:	16fd                	addi	a3,a3,-1
    800001f8:	00074603          	lbu	a2,0(a4)
    800001fc:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000200:	fef71ae3          	bne	a4,a5,800001f4 <memmove+0x4a>
    80000204:	b7f1                	j	800001d0 <memmove+0x26>

0000000080000206 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000206:	1141                	addi	sp,sp,-16
    80000208:	e406                	sd	ra,8(sp)
    8000020a:	e022                	sd	s0,0(sp)
    8000020c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000020e:	f9dff0ef          	jal	800001aa <memmove>
}
    80000212:	60a2                	ld	ra,8(sp)
    80000214:	6402                	ld	s0,0(sp)
    80000216:	0141                	addi	sp,sp,16
    80000218:	8082                	ret

000000008000021a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000021a:	1141                	addi	sp,sp,-16
    8000021c:	e422                	sd	s0,8(sp)
    8000021e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000220:	ce11                	beqz	a2,8000023c <strncmp+0x22>
    80000222:	00054783          	lbu	a5,0(a0)
    80000226:	cf89                	beqz	a5,80000240 <strncmp+0x26>
    80000228:	0005c703          	lbu	a4,0(a1)
    8000022c:	00f71a63          	bne	a4,a5,80000240 <strncmp+0x26>
    n--, p++, q++;
    80000230:	367d                	addiw	a2,a2,-1
    80000232:	0505                	addi	a0,a0,1
    80000234:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000236:	f675                	bnez	a2,80000222 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000238:	4501                	li	a0,0
    8000023a:	a801                	j	8000024a <strncmp+0x30>
    8000023c:	4501                	li	a0,0
    8000023e:	a031                	j	8000024a <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
    80000240:	00054503          	lbu	a0,0(a0)
    80000244:	0005c783          	lbu	a5,0(a1)
    80000248:	9d1d                	subw	a0,a0,a5
}
    8000024a:	6422                	ld	s0,8(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000256:	87aa                	mv	a5,a0
    80000258:	86b2                	mv	a3,a2
    8000025a:	367d                	addiw	a2,a2,-1
    8000025c:	02d05563          	blez	a3,80000286 <strncpy+0x36>
    80000260:	0785                	addi	a5,a5,1
    80000262:	0005c703          	lbu	a4,0(a1)
    80000266:	fee78fa3          	sb	a4,-1(a5)
    8000026a:	0585                	addi	a1,a1,1
    8000026c:	f775                	bnez	a4,80000258 <strncpy+0x8>
    ;
  while(n-- > 0)
    8000026e:	873e                	mv	a4,a5
    80000270:	9fb5                	addw	a5,a5,a3
    80000272:	37fd                	addiw	a5,a5,-1
    80000274:	00c05963          	blez	a2,80000286 <strncpy+0x36>
    *s++ = 0;
    80000278:	0705                	addi	a4,a4,1
    8000027a:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    8000027e:	40e786bb          	subw	a3,a5,a4
    80000282:	fed04be3          	bgtz	a3,80000278 <strncpy+0x28>
  return os;
}
    80000286:	6422                	ld	s0,8(sp)
    80000288:	0141                	addi	sp,sp,16
    8000028a:	8082                	ret

000000008000028c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000292:	02c05363          	blez	a2,800002b8 <safestrcpy+0x2c>
    80000296:	fff6069b          	addiw	a3,a2,-1
    8000029a:	1682                	slli	a3,a3,0x20
    8000029c:	9281                	srli	a3,a3,0x20
    8000029e:	96ae                	add	a3,a3,a1
    800002a0:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002a2:	00d58963          	beq	a1,a3,800002b4 <safestrcpy+0x28>
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	0785                	addi	a5,a5,1
    800002aa:	fff5c703          	lbu	a4,-1(a1)
    800002ae:	fee78fa3          	sb	a4,-1(a5)
    800002b2:	fb65                	bnez	a4,800002a2 <safestrcpy+0x16>
    ;
  *s = 0;
    800002b4:	00078023          	sb	zero,0(a5)
  return os;
}
    800002b8:	6422                	ld	s0,8(sp)
    800002ba:	0141                	addi	sp,sp,16
    800002bc:	8082                	ret

00000000800002be <strlen>:

int
strlen(const char *s)
{
    800002be:	1141                	addi	sp,sp,-16
    800002c0:	e422                	sd	s0,8(sp)
    800002c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002c4:	00054783          	lbu	a5,0(a0)
    800002c8:	cf91                	beqz	a5,800002e4 <strlen+0x26>
    800002ca:	0505                	addi	a0,a0,1
    800002cc:	87aa                	mv	a5,a0
    800002ce:	86be                	mv	a3,a5
    800002d0:	0785                	addi	a5,a5,1
    800002d2:	fff7c703          	lbu	a4,-1(a5)
    800002d6:	ff65                	bnez	a4,800002ce <strlen+0x10>
    800002d8:	40a6853b          	subw	a0,a3,a0
    800002dc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    800002de:	6422                	ld	s0,8(sp)
    800002e0:	0141                	addi	sp,sp,16
    800002e2:	8082                	ret
  for(n = 0; s[n]; n++)
    800002e4:	4501                	li	a0,0
    800002e6:	bfe5                	j	800002de <strlen+0x20>

00000000800002e8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800002e8:	1141                	addi	sp,sp,-16
    800002ea:	e406                	sd	ra,8(sp)
    800002ec:	e022                	sd	s0,0(sp)
    800002ee:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800002f0:	25f000ef          	jal	80000d4e <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    800002f4:	0000a717          	auipc	a4,0xa
    800002f8:	ecc70713          	addi	a4,a4,-308 # 8000a1c0 <started>
  if(cpuid() == 0){
    800002fc:	c51d                	beqz	a0,8000032a <main+0x42>
    while(started == 0)
    800002fe:	431c                	lw	a5,0(a4)
    80000300:	2781                	sext.w	a5,a5
    80000302:	dff5                	beqz	a5,800002fe <main+0x16>
      ;
    __sync_synchronize();
    80000304:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000308:	247000ef          	jal	80000d4e <cpuid>
    8000030c:	85aa                	mv	a1,a0
    8000030e:	00007517          	auipc	a0,0x7
    80000312:	d2a50513          	addi	a0,a0,-726 # 80007038 <etext+0x38>
    80000316:	012050ef          	jal	80005328 <printf>
    kvminithart();    // turn on paging
    8000031a:	080000ef          	jal	8000039a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000031e:	576010ef          	jal	80001894 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000322:	586040ef          	jal	800048a8 <plicinithart>
  }

  scheduler();        
    80000326:	6b5000ef          	jal	800011da <scheduler>
    consoleinit();
    8000032a:	729040ef          	jal	80005252 <consoleinit>
    printfinit();
    8000032e:	31c050ef          	jal	8000564a <printfinit>
    printf("\n");
    80000332:	00007517          	auipc	a0,0x7
    80000336:	ce650513          	addi	a0,a0,-794 # 80007018 <etext+0x18>
    8000033a:	7ef040ef          	jal	80005328 <printf>
    printf("xv6 kernel is booting\n");
    8000033e:	00007517          	auipc	a0,0x7
    80000342:	ce250513          	addi	a0,a0,-798 # 80007020 <etext+0x20>
    80000346:	7e3040ef          	jal	80005328 <printf>
    printf("\n");
    8000034a:	00007517          	auipc	a0,0x7
    8000034e:	cce50513          	addi	a0,a0,-818 # 80007018 <etext+0x18>
    80000352:	7d7040ef          	jal	80005328 <printf>
    kinit();         // physical page allocator
    80000356:	d75ff0ef          	jal	800000ca <kinit>
    kvminit();       // create kernel page table
    8000035a:	2ca000ef          	jal	80000624 <kvminit>
    kvminithart();   // turn on paging
    8000035e:	03c000ef          	jal	8000039a <kvminithart>
    procinit();      // process table
    80000362:	137000ef          	jal	80000c98 <procinit>
    trapinit();      // trap vectors
    80000366:	50a010ef          	jal	80001870 <trapinit>
    trapinithart();  // install kernel trap vector
    8000036a:	52a010ef          	jal	80001894 <trapinithart>
    plicinit();      // set up interrupt controller
    8000036e:	520040ef          	jal	8000488e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000372:	536040ef          	jal	800048a8 <plicinithart>
    binit();         // buffer cache
    80000376:	409010ef          	jal	80001f7e <binit>
    iinit();         // inode table
    8000037a:	18e020ef          	jal	80002508 <iinit>
    fileinit();      // file table
    8000037e:	080030ef          	jal	800033fe <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000382:	616040ef          	jal	80004998 <virtio_disk_init>
    userinit();      // first user process
    80000386:	4bb000ef          	jal	80001040 <userinit>
    __sync_synchronize();
    8000038a:	0330000f          	fence	rw,rw
    started = 1;
    8000038e:	4785                	li	a5,1
    80000390:	0000a717          	auipc	a4,0xa
    80000394:	e2f72823          	sw	a5,-464(a4) # 8000a1c0 <started>
    80000398:	b779                	j	80000326 <main+0x3e>

000000008000039a <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    8000039a:	1141                	addi	sp,sp,-16
    8000039c:	e422                	sd	s0,8(sp)
    8000039e:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003a0:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003a4:	0000a797          	auipc	a5,0xa
    800003a8:	e247b783          	ld	a5,-476(a5) # 8000a1c8 <kernel_pagetable>
    800003ac:	83b1                	srli	a5,a5,0xc
    800003ae:	577d                	li	a4,-1
    800003b0:	177e                	slli	a4,a4,0x3f
    800003b2:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003b4:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003b8:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003bc:	6422                	ld	s0,8(sp)
    800003be:	0141                	addi	sp,sp,16
    800003c0:	8082                	ret

00000000800003c2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003c2:	7139                	addi	sp,sp,-64
    800003c4:	fc06                	sd	ra,56(sp)
    800003c6:	f822                	sd	s0,48(sp)
    800003c8:	f426                	sd	s1,40(sp)
    800003ca:	f04a                	sd	s2,32(sp)
    800003cc:	ec4e                	sd	s3,24(sp)
    800003ce:	e852                	sd	s4,16(sp)
    800003d0:	e456                	sd	s5,8(sp)
    800003d2:	e05a                	sd	s6,0(sp)
    800003d4:	0080                	addi	s0,sp,64
    800003d6:	84aa                	mv	s1,a0
    800003d8:	89ae                	mv	s3,a1
    800003da:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800003dc:	57fd                	li	a5,-1
    800003de:	83e9                	srli	a5,a5,0x1a
    800003e0:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800003e2:	4b31                	li	s6,12
  if(va >= MAXVA)
    800003e4:	02b7fc63          	bgeu	a5,a1,8000041c <walk+0x5a>
    panic("walk");
    800003e8:	00007517          	auipc	a0,0x7
    800003ec:	c6850513          	addi	a0,a0,-920 # 80007050 <etext+0x50>
    800003f0:	21e050ef          	jal	8000560e <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800003f4:	060a8263          	beqz	s5,80000458 <walk+0x96>
    800003f8:	d07ff0ef          	jal	800000fe <kalloc>
    800003fc:	84aa                	mv	s1,a0
    800003fe:	c139                	beqz	a0,80000444 <walk+0x82>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000400:	6605                	lui	a2,0x1
    80000402:	4581                	li	a1,0
    80000404:	d4bff0ef          	jal	8000014e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000408:	00c4d793          	srli	a5,s1,0xc
    8000040c:	07aa                	slli	a5,a5,0xa
    8000040e:	0017e793          	ori	a5,a5,1
    80000412:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000416:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdbaff>
    80000418:	036a0063          	beq	s4,s6,80000438 <walk+0x76>
    pte_t *pte = &pagetable[PX(level, va)];
    8000041c:	0149d933          	srl	s2,s3,s4
    80000420:	1ff97913          	andi	s2,s2,511
    80000424:	090e                	slli	s2,s2,0x3
    80000426:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000428:	00093483          	ld	s1,0(s2)
    8000042c:	0014f793          	andi	a5,s1,1
    80000430:	d3f1                	beqz	a5,800003f4 <walk+0x32>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000432:	80a9                	srli	s1,s1,0xa
    80000434:	04b2                	slli	s1,s1,0xc
    80000436:	b7c5                	j	80000416 <walk+0x54>
    }
  }
  return &pagetable[PX(0, va)];
    80000438:	00c9d513          	srli	a0,s3,0xc
    8000043c:	1ff57513          	andi	a0,a0,511
    80000440:	050e                	slli	a0,a0,0x3
    80000442:	9526                	add	a0,a0,s1
}
    80000444:	70e2                	ld	ra,56(sp)
    80000446:	7442                	ld	s0,48(sp)
    80000448:	74a2                	ld	s1,40(sp)
    8000044a:	7902                	ld	s2,32(sp)
    8000044c:	69e2                	ld	s3,24(sp)
    8000044e:	6a42                	ld	s4,16(sp)
    80000450:	6aa2                	ld	s5,8(sp)
    80000452:	6b02                	ld	s6,0(sp)
    80000454:	6121                	addi	sp,sp,64
    80000456:	8082                	ret
        return 0;
    80000458:	4501                	li	a0,0
    8000045a:	b7ed                	j	80000444 <walk+0x82>

000000008000045c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000045c:	57fd                	li	a5,-1
    8000045e:	83e9                	srli	a5,a5,0x1a
    80000460:	00b7f463          	bgeu	a5,a1,80000468 <walkaddr+0xc>
    return 0;
    80000464:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000466:	8082                	ret
{
    80000468:	1141                	addi	sp,sp,-16
    8000046a:	e406                	sd	ra,8(sp)
    8000046c:	e022                	sd	s0,0(sp)
    8000046e:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000470:	4601                	li	a2,0
    80000472:	f51ff0ef          	jal	800003c2 <walk>
  if(pte == 0)
    80000476:	c105                	beqz	a0,80000496 <walkaddr+0x3a>
  if((*pte & PTE_V) == 0)
    80000478:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000047a:	0117f693          	andi	a3,a5,17
    8000047e:	4745                	li	a4,17
    return 0;
    80000480:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000482:	00e68663          	beq	a3,a4,8000048e <walkaddr+0x32>
}
    80000486:	60a2                	ld	ra,8(sp)
    80000488:	6402                	ld	s0,0(sp)
    8000048a:	0141                	addi	sp,sp,16
    8000048c:	8082                	ret
  pa = PTE2PA(*pte);
    8000048e:	83a9                	srli	a5,a5,0xa
    80000490:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000494:	bfcd                	j	80000486 <walkaddr+0x2a>
    return 0;
    80000496:	4501                	li	a0,0
    80000498:	b7fd                	j	80000486 <walkaddr+0x2a>

000000008000049a <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000049a:	715d                	addi	sp,sp,-80
    8000049c:	e486                	sd	ra,72(sp)
    8000049e:	e0a2                	sd	s0,64(sp)
    800004a0:	fc26                	sd	s1,56(sp)
    800004a2:	f84a                	sd	s2,48(sp)
    800004a4:	f44e                	sd	s3,40(sp)
    800004a6:	f052                	sd	s4,32(sp)
    800004a8:	ec56                	sd	s5,24(sp)
    800004aa:	e85a                	sd	s6,16(sp)
    800004ac:	e45e                	sd	s7,8(sp)
    800004ae:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004b0:	03459793          	slli	a5,a1,0x34
    800004b4:	e7a9                	bnez	a5,800004fe <mappages+0x64>
    800004b6:	8aaa                	mv	s5,a0
    800004b8:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004ba:	03461793          	slli	a5,a2,0x34
    800004be:	e7b1                	bnez	a5,8000050a <mappages+0x70>
    panic("mappages: size not aligned");

  if(size == 0)
    800004c0:	ca39                	beqz	a2,80000516 <mappages+0x7c>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004c2:	77fd                	lui	a5,0xfffff
    800004c4:	963e                	add	a2,a2,a5
    800004c6:	00b609b3          	add	s3,a2,a1
  a = va;
    800004ca:	892e                	mv	s2,a1
    800004cc:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800004d0:	6b85                	lui	s7,0x1
    800004d2:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    800004d6:	4605                	li	a2,1
    800004d8:	85ca                	mv	a1,s2
    800004da:	8556                	mv	a0,s5
    800004dc:	ee7ff0ef          	jal	800003c2 <walk>
    800004e0:	c539                	beqz	a0,8000052e <mappages+0x94>
    if(*pte & PTE_V)
    800004e2:	611c                	ld	a5,0(a0)
    800004e4:	8b85                	andi	a5,a5,1
    800004e6:	ef95                	bnez	a5,80000522 <mappages+0x88>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800004e8:	80b1                	srli	s1,s1,0xc
    800004ea:	04aa                	slli	s1,s1,0xa
    800004ec:	0164e4b3          	or	s1,s1,s6
    800004f0:	0014e493          	ori	s1,s1,1
    800004f4:	e104                	sd	s1,0(a0)
    if(a == last)
    800004f6:	05390863          	beq	s2,s3,80000546 <mappages+0xac>
    a += PGSIZE;
    800004fa:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800004fc:	bfd9                	j	800004d2 <mappages+0x38>
    panic("mappages: va not aligned");
    800004fe:	00007517          	auipc	a0,0x7
    80000502:	b5a50513          	addi	a0,a0,-1190 # 80007058 <etext+0x58>
    80000506:	108050ef          	jal	8000560e <panic>
    panic("mappages: size not aligned");
    8000050a:	00007517          	auipc	a0,0x7
    8000050e:	b6e50513          	addi	a0,a0,-1170 # 80007078 <etext+0x78>
    80000512:	0fc050ef          	jal	8000560e <panic>
    panic("mappages: size");
    80000516:	00007517          	auipc	a0,0x7
    8000051a:	b8250513          	addi	a0,a0,-1150 # 80007098 <etext+0x98>
    8000051e:	0f0050ef          	jal	8000560e <panic>
      panic("mappages: remap");
    80000522:	00007517          	auipc	a0,0x7
    80000526:	b8650513          	addi	a0,a0,-1146 # 800070a8 <etext+0xa8>
    8000052a:	0e4050ef          	jal	8000560e <panic>
      return -1;
    8000052e:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000530:	60a6                	ld	ra,72(sp)
    80000532:	6406                	ld	s0,64(sp)
    80000534:	74e2                	ld	s1,56(sp)
    80000536:	7942                	ld	s2,48(sp)
    80000538:	79a2                	ld	s3,40(sp)
    8000053a:	7a02                	ld	s4,32(sp)
    8000053c:	6ae2                	ld	s5,24(sp)
    8000053e:	6b42                	ld	s6,16(sp)
    80000540:	6ba2                	ld	s7,8(sp)
    80000542:	6161                	addi	sp,sp,80
    80000544:	8082                	ret
  return 0;
    80000546:	4501                	li	a0,0
    80000548:	b7e5                	j	80000530 <mappages+0x96>

000000008000054a <kvmmap>:
{
    8000054a:	1141                	addi	sp,sp,-16
    8000054c:	e406                	sd	ra,8(sp)
    8000054e:	e022                	sd	s0,0(sp)
    80000550:	0800                	addi	s0,sp,16
    80000552:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000554:	86b2                	mv	a3,a2
    80000556:	863e                	mv	a2,a5
    80000558:	f43ff0ef          	jal	8000049a <mappages>
    8000055c:	e509                	bnez	a0,80000566 <kvmmap+0x1c>
}
    8000055e:	60a2                	ld	ra,8(sp)
    80000560:	6402                	ld	s0,0(sp)
    80000562:	0141                	addi	sp,sp,16
    80000564:	8082                	ret
    panic("kvmmap");
    80000566:	00007517          	auipc	a0,0x7
    8000056a:	b5250513          	addi	a0,a0,-1198 # 800070b8 <etext+0xb8>
    8000056e:	0a0050ef          	jal	8000560e <panic>

0000000080000572 <kvmmake>:
{
    80000572:	1101                	addi	sp,sp,-32
    80000574:	ec06                	sd	ra,24(sp)
    80000576:	e822                	sd	s0,16(sp)
    80000578:	e426                	sd	s1,8(sp)
    8000057a:	e04a                	sd	s2,0(sp)
    8000057c:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000057e:	b81ff0ef          	jal	800000fe <kalloc>
    80000582:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000584:	6605                	lui	a2,0x1
    80000586:	4581                	li	a1,0
    80000588:	bc7ff0ef          	jal	8000014e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000058c:	4719                	li	a4,6
    8000058e:	6685                	lui	a3,0x1
    80000590:	10000637          	lui	a2,0x10000
    80000594:	100005b7          	lui	a1,0x10000
    80000598:	8526                	mv	a0,s1
    8000059a:	fb1ff0ef          	jal	8000054a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000059e:	4719                	li	a4,6
    800005a0:	6685                	lui	a3,0x1
    800005a2:	10001637          	lui	a2,0x10001
    800005a6:	100015b7          	lui	a1,0x10001
    800005aa:	8526                	mv	a0,s1
    800005ac:	f9fff0ef          	jal	8000054a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005b0:	4719                	li	a4,6
    800005b2:	040006b7          	lui	a3,0x4000
    800005b6:	0c000637          	lui	a2,0xc000
    800005ba:	0c0005b7          	lui	a1,0xc000
    800005be:	8526                	mv	a0,s1
    800005c0:	f8bff0ef          	jal	8000054a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005c4:	00007917          	auipc	s2,0x7
    800005c8:	a3c90913          	addi	s2,s2,-1476 # 80007000 <etext>
    800005cc:	4729                	li	a4,10
    800005ce:	80007697          	auipc	a3,0x80007
    800005d2:	a3268693          	addi	a3,a3,-1486 # 7000 <_entry-0x7fff9000>
    800005d6:	4605                	li	a2,1
    800005d8:	067e                	slli	a2,a2,0x1f
    800005da:	85b2                	mv	a1,a2
    800005dc:	8526                	mv	a0,s1
    800005de:	f6dff0ef          	jal	8000054a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800005e2:	46c5                	li	a3,17
    800005e4:	06ee                	slli	a3,a3,0x1b
    800005e6:	4719                	li	a4,6
    800005e8:	412686b3          	sub	a3,a3,s2
    800005ec:	864a                	mv	a2,s2
    800005ee:	85ca                	mv	a1,s2
    800005f0:	8526                	mv	a0,s1
    800005f2:	f59ff0ef          	jal	8000054a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800005f6:	4729                	li	a4,10
    800005f8:	6685                	lui	a3,0x1
    800005fa:	00006617          	auipc	a2,0x6
    800005fe:	a0660613          	addi	a2,a2,-1530 # 80006000 <_trampoline>
    80000602:	040005b7          	lui	a1,0x4000
    80000606:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000608:	05b2                	slli	a1,a1,0xc
    8000060a:	8526                	mv	a0,s1
    8000060c:	f3fff0ef          	jal	8000054a <kvmmap>
  proc_mapstacks(kpgtbl);
    80000610:	8526                	mv	a0,s1
    80000612:	5ee000ef          	jal	80000c00 <proc_mapstacks>
}
    80000616:	8526                	mv	a0,s1
    80000618:	60e2                	ld	ra,24(sp)
    8000061a:	6442                	ld	s0,16(sp)
    8000061c:	64a2                	ld	s1,8(sp)
    8000061e:	6902                	ld	s2,0(sp)
    80000620:	6105                	addi	sp,sp,32
    80000622:	8082                	ret

0000000080000624 <kvminit>:
{
    80000624:	1141                	addi	sp,sp,-16
    80000626:	e406                	sd	ra,8(sp)
    80000628:	e022                	sd	s0,0(sp)
    8000062a:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000062c:	f47ff0ef          	jal	80000572 <kvmmake>
    80000630:	0000a797          	auipc	a5,0xa
    80000634:	b8a7bc23          	sd	a0,-1128(a5) # 8000a1c8 <kernel_pagetable>
}
    80000638:	60a2                	ld	ra,8(sp)
    8000063a:	6402                	ld	s0,0(sp)
    8000063c:	0141                	addi	sp,sp,16
    8000063e:	8082                	ret

0000000080000640 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000640:	1101                	addi	sp,sp,-32
    80000642:	ec06                	sd	ra,24(sp)
    80000644:	e822                	sd	s0,16(sp)
    80000646:	e426                	sd	s1,8(sp)
    80000648:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000064a:	ab5ff0ef          	jal	800000fe <kalloc>
    8000064e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000650:	c509                	beqz	a0,8000065a <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000652:	6605                	lui	a2,0x1
    80000654:	4581                	li	a1,0
    80000656:	af9ff0ef          	jal	8000014e <memset>
  return pagetable;
}
    8000065a:	8526                	mv	a0,s1
    8000065c:	60e2                	ld	ra,24(sp)
    8000065e:	6442                	ld	s0,16(sp)
    80000660:	64a2                	ld	s1,8(sp)
    80000662:	6105                	addi	sp,sp,32
    80000664:	8082                	ret

0000000080000666 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000666:	7139                	addi	sp,sp,-64
    80000668:	fc06                	sd	ra,56(sp)
    8000066a:	f822                	sd	s0,48(sp)
    8000066c:	0080                	addi	s0,sp,64
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000066e:	03459793          	slli	a5,a1,0x34
    80000672:	e38d                	bnez	a5,80000694 <uvmunmap+0x2e>
    80000674:	f04a                	sd	s2,32(sp)
    80000676:	ec4e                	sd	s3,24(sp)
    80000678:	e852                	sd	s4,16(sp)
    8000067a:	e456                	sd	s5,8(sp)
    8000067c:	e05a                	sd	s6,0(sp)
    8000067e:	8a2a                	mv	s4,a0
    80000680:	892e                	mv	s2,a1
    80000682:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000684:	0632                	slli	a2,a2,0xc
    80000686:	00b609b3          	add	s3,a2,a1
    8000068a:	6b05                	lui	s6,0x1
    8000068c:	0535f963          	bgeu	a1,s3,800006de <uvmunmap+0x78>
    80000690:	f426                	sd	s1,40(sp)
    80000692:	a015                	j	800006b6 <uvmunmap+0x50>
    80000694:	f426                	sd	s1,40(sp)
    80000696:	f04a                	sd	s2,32(sp)
    80000698:	ec4e                	sd	s3,24(sp)
    8000069a:	e852                	sd	s4,16(sp)
    8000069c:	e456                	sd	s5,8(sp)
    8000069e:	e05a                	sd	s6,0(sp)
    panic("uvmunmap: not aligned");
    800006a0:	00007517          	auipc	a0,0x7
    800006a4:	a2050513          	addi	a0,a0,-1504 # 800070c0 <etext+0xc0>
    800006a8:	767040ef          	jal	8000560e <panic>
      continue;
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006ac:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800006b0:	995a                	add	s2,s2,s6
    800006b2:	03397563          	bgeu	s2,s3,800006dc <uvmunmap+0x76>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    800006b6:	4601                	li	a2,0
    800006b8:	85ca                	mv	a1,s2
    800006ba:	8552                	mv	a0,s4
    800006bc:	d07ff0ef          	jal	800003c2 <walk>
    800006c0:	84aa                	mv	s1,a0
    800006c2:	d57d                	beqz	a0,800006b0 <uvmunmap+0x4a>
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    800006c4:	611c                	ld	a5,0(a0)
    800006c6:	0017f713          	andi	a4,a5,1
    800006ca:	d37d                	beqz	a4,800006b0 <uvmunmap+0x4a>
    if(do_free){
    800006cc:	fe0a80e3          	beqz	s5,800006ac <uvmunmap+0x46>
      uint64 pa = PTE2PA(*pte);
    800006d0:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    800006d2:	00c79513          	slli	a0,a5,0xc
    800006d6:	947ff0ef          	jal	8000001c <kfree>
    800006da:	bfc9                	j	800006ac <uvmunmap+0x46>
    800006dc:	74a2                	ld	s1,40(sp)
    800006de:	7902                	ld	s2,32(sp)
    800006e0:	69e2                	ld	s3,24(sp)
    800006e2:	6a42                	ld	s4,16(sp)
    800006e4:	6aa2                	ld	s5,8(sp)
    800006e6:	6b02                	ld	s6,0(sp)
  }
}
    800006e8:	70e2                	ld	ra,56(sp)
    800006ea:	7442                	ld	s0,48(sp)
    800006ec:	6121                	addi	sp,sp,64
    800006ee:	8082                	ret

00000000800006f0 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800006f0:	1101                	addi	sp,sp,-32
    800006f2:	ec06                	sd	ra,24(sp)
    800006f4:	e822                	sd	s0,16(sp)
    800006f6:	e426                	sd	s1,8(sp)
    800006f8:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800006fa:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800006fc:	00b67d63          	bgeu	a2,a1,80000716 <uvmdealloc+0x26>
    80000700:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000702:	6785                	lui	a5,0x1
    80000704:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000706:	00f60733          	add	a4,a2,a5
    8000070a:	76fd                	lui	a3,0xfffff
    8000070c:	8f75                	and	a4,a4,a3
    8000070e:	97ae                	add	a5,a5,a1
    80000710:	8ff5                	and	a5,a5,a3
    80000712:	00f76863          	bltu	a4,a5,80000722 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000716:	8526                	mv	a0,s1
    80000718:	60e2                	ld	ra,24(sp)
    8000071a:	6442                	ld	s0,16(sp)
    8000071c:	64a2                	ld	s1,8(sp)
    8000071e:	6105                	addi	sp,sp,32
    80000720:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000722:	8f99                	sub	a5,a5,a4
    80000724:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000726:	4685                	li	a3,1
    80000728:	0007861b          	sext.w	a2,a5
    8000072c:	85ba                	mv	a1,a4
    8000072e:	f39ff0ef          	jal	80000666 <uvmunmap>
    80000732:	b7d5                	j	80000716 <uvmdealloc+0x26>

0000000080000734 <uvmalloc>:
  if(newsz < oldsz)
    80000734:	08b66f63          	bltu	a2,a1,800007d2 <uvmalloc+0x9e>
{
    80000738:	7139                	addi	sp,sp,-64
    8000073a:	fc06                	sd	ra,56(sp)
    8000073c:	f822                	sd	s0,48(sp)
    8000073e:	ec4e                	sd	s3,24(sp)
    80000740:	e852                	sd	s4,16(sp)
    80000742:	e456                	sd	s5,8(sp)
    80000744:	0080                	addi	s0,sp,64
    80000746:	8aaa                	mv	s5,a0
    80000748:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000074a:	6785                	lui	a5,0x1
    8000074c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000074e:	95be                	add	a1,a1,a5
    80000750:	77fd                	lui	a5,0xfffff
    80000752:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000756:	08c9f063          	bgeu	s3,a2,800007d6 <uvmalloc+0xa2>
    8000075a:	f426                	sd	s1,40(sp)
    8000075c:	f04a                	sd	s2,32(sp)
    8000075e:	e05a                	sd	s6,0(sp)
    80000760:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000762:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000766:	999ff0ef          	jal	800000fe <kalloc>
    8000076a:	84aa                	mv	s1,a0
    if(mem == 0){
    8000076c:	c515                	beqz	a0,80000798 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    8000076e:	6605                	lui	a2,0x1
    80000770:	4581                	li	a1,0
    80000772:	9ddff0ef          	jal	8000014e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000776:	875a                	mv	a4,s6
    80000778:	86a6                	mv	a3,s1
    8000077a:	6605                	lui	a2,0x1
    8000077c:	85ca                	mv	a1,s2
    8000077e:	8556                	mv	a0,s5
    80000780:	d1bff0ef          	jal	8000049a <mappages>
    80000784:	e915                	bnez	a0,800007b8 <uvmalloc+0x84>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000786:	6785                	lui	a5,0x1
    80000788:	993e                	add	s2,s2,a5
    8000078a:	fd496ee3          	bltu	s2,s4,80000766 <uvmalloc+0x32>
  return newsz;
    8000078e:	8552                	mv	a0,s4
    80000790:	74a2                	ld	s1,40(sp)
    80000792:	7902                	ld	s2,32(sp)
    80000794:	6b02                	ld	s6,0(sp)
    80000796:	a811                	j	800007aa <uvmalloc+0x76>
      uvmdealloc(pagetable, a, oldsz);
    80000798:	864e                	mv	a2,s3
    8000079a:	85ca                	mv	a1,s2
    8000079c:	8556                	mv	a0,s5
    8000079e:	f53ff0ef          	jal	800006f0 <uvmdealloc>
      return 0;
    800007a2:	4501                	li	a0,0
    800007a4:	74a2                	ld	s1,40(sp)
    800007a6:	7902                	ld	s2,32(sp)
    800007a8:	6b02                	ld	s6,0(sp)
}
    800007aa:	70e2                	ld	ra,56(sp)
    800007ac:	7442                	ld	s0,48(sp)
    800007ae:	69e2                	ld	s3,24(sp)
    800007b0:	6a42                	ld	s4,16(sp)
    800007b2:	6aa2                	ld	s5,8(sp)
    800007b4:	6121                	addi	sp,sp,64
    800007b6:	8082                	ret
      kfree(mem);
    800007b8:	8526                	mv	a0,s1
    800007ba:	863ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800007be:	864e                	mv	a2,s3
    800007c0:	85ca                	mv	a1,s2
    800007c2:	8556                	mv	a0,s5
    800007c4:	f2dff0ef          	jal	800006f0 <uvmdealloc>
      return 0;
    800007c8:	4501                	li	a0,0
    800007ca:	74a2                	ld	s1,40(sp)
    800007cc:	7902                	ld	s2,32(sp)
    800007ce:	6b02                	ld	s6,0(sp)
    800007d0:	bfe9                	j	800007aa <uvmalloc+0x76>
    return oldsz;
    800007d2:	852e                	mv	a0,a1
}
    800007d4:	8082                	ret
  return newsz;
    800007d6:	8532                	mv	a0,a2
    800007d8:	bfc9                	j	800007aa <uvmalloc+0x76>

00000000800007da <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800007da:	7179                	addi	sp,sp,-48
    800007dc:	f406                	sd	ra,40(sp)
    800007de:	f022                	sd	s0,32(sp)
    800007e0:	ec26                	sd	s1,24(sp)
    800007e2:	e84a                	sd	s2,16(sp)
    800007e4:	e44e                	sd	s3,8(sp)
    800007e6:	e052                	sd	s4,0(sp)
    800007e8:	1800                	addi	s0,sp,48
    800007ea:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800007ec:	84aa                	mv	s1,a0
    800007ee:	6905                	lui	s2,0x1
    800007f0:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800007f2:	4985                	li	s3,1
    800007f4:	a819                	j	8000080a <freewalk+0x30>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800007f6:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800007f8:	00c79513          	slli	a0,a5,0xc
    800007fc:	fdfff0ef          	jal	800007da <freewalk>
      pagetable[i] = 0;
    80000800:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000804:	04a1                	addi	s1,s1,8
    80000806:	01248f63          	beq	s1,s2,80000824 <freewalk+0x4a>
    pte_t pte = pagetable[i];
    8000080a:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000080c:	00f7f713          	andi	a4,a5,15
    80000810:	ff3703e3          	beq	a4,s3,800007f6 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000814:	8b85                	andi	a5,a5,1
    80000816:	d7fd                	beqz	a5,80000804 <freewalk+0x2a>
      panic("freewalk: leaf");
    80000818:	00007517          	auipc	a0,0x7
    8000081c:	8c050513          	addi	a0,a0,-1856 # 800070d8 <etext+0xd8>
    80000820:	5ef040ef          	jal	8000560e <panic>
    }
  }
  kfree((void*)pagetable);
    80000824:	8552                	mv	a0,s4
    80000826:	ff6ff0ef          	jal	8000001c <kfree>
}
    8000082a:	70a2                	ld	ra,40(sp)
    8000082c:	7402                	ld	s0,32(sp)
    8000082e:	64e2                	ld	s1,24(sp)
    80000830:	6942                	ld	s2,16(sp)
    80000832:	69a2                	ld	s3,8(sp)
    80000834:	6a02                	ld	s4,0(sp)
    80000836:	6145                	addi	sp,sp,48
    80000838:	8082                	ret

000000008000083a <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000083a:	1101                	addi	sp,sp,-32
    8000083c:	ec06                	sd	ra,24(sp)
    8000083e:	e822                	sd	s0,16(sp)
    80000840:	e426                	sd	s1,8(sp)
    80000842:	1000                	addi	s0,sp,32
    80000844:	84aa                	mv	s1,a0
  if(sz > 0)
    80000846:	e989                	bnez	a1,80000858 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000848:	8526                	mv	a0,s1
    8000084a:	f91ff0ef          	jal	800007da <freewalk>
}
    8000084e:	60e2                	ld	ra,24(sp)
    80000850:	6442                	ld	s0,16(sp)
    80000852:	64a2                	ld	s1,8(sp)
    80000854:	6105                	addi	sp,sp,32
    80000856:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000858:	6785                	lui	a5,0x1
    8000085a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000085c:	95be                	add	a1,a1,a5
    8000085e:	4685                	li	a3,1
    80000860:	00c5d613          	srli	a2,a1,0xc
    80000864:	4581                	li	a1,0
    80000866:	e01ff0ef          	jal	80000666 <uvmunmap>
    8000086a:	bff9                	j	80000848 <uvmfree+0xe>

000000008000086c <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000086c:	ce49                	beqz	a2,80000906 <uvmcopy+0x9a>
{
    8000086e:	715d                	addi	sp,sp,-80
    80000870:	e486                	sd	ra,72(sp)
    80000872:	e0a2                	sd	s0,64(sp)
    80000874:	fc26                	sd	s1,56(sp)
    80000876:	f84a                	sd	s2,48(sp)
    80000878:	f44e                	sd	s3,40(sp)
    8000087a:	f052                	sd	s4,32(sp)
    8000087c:	ec56                	sd	s5,24(sp)
    8000087e:	e85a                	sd	s6,16(sp)
    80000880:	e45e                	sd	s7,8(sp)
    80000882:	0880                	addi	s0,sp,80
    80000884:	8aaa                	mv	s5,a0
    80000886:	8b2e                	mv	s6,a1
    80000888:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    8000088a:	4481                	li	s1,0
    8000088c:	a029                	j	80000896 <uvmcopy+0x2a>
    8000088e:	6785                	lui	a5,0x1
    80000890:	94be                	add	s1,s1,a5
    80000892:	0544fe63          	bgeu	s1,s4,800008ee <uvmcopy+0x82>
    if((pte = walk(old, i, 0)) == 0)
    80000896:	4601                	li	a2,0
    80000898:	85a6                	mv	a1,s1
    8000089a:	8556                	mv	a0,s5
    8000089c:	b27ff0ef          	jal	800003c2 <walk>
    800008a0:	d57d                	beqz	a0,8000088e <uvmcopy+0x22>
      continue;   // page table entry hasn't been allocated
    if((*pte & PTE_V) == 0)
    800008a2:	6118                	ld	a4,0(a0)
    800008a4:	00177793          	andi	a5,a4,1
    800008a8:	d3fd                	beqz	a5,8000088e <uvmcopy+0x22>
      continue;   // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    800008aa:	00a75593          	srli	a1,a4,0xa
    800008ae:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800008b2:	3ff77913          	andi	s2,a4,1023
    if((mem = kalloc()) == 0)
    800008b6:	849ff0ef          	jal	800000fe <kalloc>
    800008ba:	89aa                	mv	s3,a0
    800008bc:	c105                	beqz	a0,800008dc <uvmcopy+0x70>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800008be:	6605                	lui	a2,0x1
    800008c0:	85de                	mv	a1,s7
    800008c2:	8e9ff0ef          	jal	800001aa <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800008c6:	874a                	mv	a4,s2
    800008c8:	86ce                	mv	a3,s3
    800008ca:	6605                	lui	a2,0x1
    800008cc:	85a6                	mv	a1,s1
    800008ce:	855a                	mv	a0,s6
    800008d0:	bcbff0ef          	jal	8000049a <mappages>
    800008d4:	dd4d                	beqz	a0,8000088e <uvmcopy+0x22>
      kfree(mem);
    800008d6:	854e                	mv	a0,s3
    800008d8:	f44ff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800008dc:	4685                	li	a3,1
    800008de:	00c4d613          	srli	a2,s1,0xc
    800008e2:	4581                	li	a1,0
    800008e4:	855a                	mv	a0,s6
    800008e6:	d81ff0ef          	jal	80000666 <uvmunmap>
  return -1;
    800008ea:	557d                	li	a0,-1
    800008ec:	a011                	j	800008f0 <uvmcopy+0x84>
  return 0;
    800008ee:	4501                	li	a0,0
}
    800008f0:	60a6                	ld	ra,72(sp)
    800008f2:	6406                	ld	s0,64(sp)
    800008f4:	74e2                	ld	s1,56(sp)
    800008f6:	7942                	ld	s2,48(sp)
    800008f8:	79a2                	ld	s3,40(sp)
    800008fa:	7a02                	ld	s4,32(sp)
    800008fc:	6ae2                	ld	s5,24(sp)
    800008fe:	6b42                	ld	s6,16(sp)
    80000900:	6ba2                	ld	s7,8(sp)
    80000902:	6161                	addi	sp,sp,80
    80000904:	8082                	ret
  return 0;
    80000906:	4501                	li	a0,0
}
    80000908:	8082                	ret

000000008000090a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000090a:	1141                	addi	sp,sp,-16
    8000090c:	e406                	sd	ra,8(sp)
    8000090e:	e022                	sd	s0,0(sp)
    80000910:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000912:	4601                	li	a2,0
    80000914:	aafff0ef          	jal	800003c2 <walk>
  if(pte == 0)
    80000918:	c901                	beqz	a0,80000928 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000091a:	611c                	ld	a5,0(a0)
    8000091c:	9bbd                	andi	a5,a5,-17
    8000091e:	e11c                	sd	a5,0(a0)
}
    80000920:	60a2                	ld	ra,8(sp)
    80000922:	6402                	ld	s0,0(sp)
    80000924:	0141                	addi	sp,sp,16
    80000926:	8082                	ret
    panic("uvmclear");
    80000928:	00006517          	auipc	a0,0x6
    8000092c:	7c050513          	addi	a0,a0,1984 # 800070e8 <etext+0xe8>
    80000930:	4df040ef          	jal	8000560e <panic>

0000000080000934 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000934:	c6dd                	beqz	a3,800009e2 <copyinstr+0xae>
{
    80000936:	715d                	addi	sp,sp,-80
    80000938:	e486                	sd	ra,72(sp)
    8000093a:	e0a2                	sd	s0,64(sp)
    8000093c:	fc26                	sd	s1,56(sp)
    8000093e:	f84a                	sd	s2,48(sp)
    80000940:	f44e                	sd	s3,40(sp)
    80000942:	f052                	sd	s4,32(sp)
    80000944:	ec56                	sd	s5,24(sp)
    80000946:	e85a                	sd	s6,16(sp)
    80000948:	e45e                	sd	s7,8(sp)
    8000094a:	0880                	addi	s0,sp,80
    8000094c:	8a2a                	mv	s4,a0
    8000094e:	8b2e                	mv	s6,a1
    80000950:	8bb2                	mv	s7,a2
    80000952:	8936                	mv	s2,a3
    va0 = PGROUNDDOWN(srcva);
    80000954:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000956:	6985                	lui	s3,0x1
    80000958:	a825                	j	80000990 <copyinstr+0x5c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    8000095a:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    8000095e:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000960:	37fd                	addiw	a5,a5,-1
    80000962:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000966:	60a6                	ld	ra,72(sp)
    80000968:	6406                	ld	s0,64(sp)
    8000096a:	74e2                	ld	s1,56(sp)
    8000096c:	7942                	ld	s2,48(sp)
    8000096e:	79a2                	ld	s3,40(sp)
    80000970:	7a02                	ld	s4,32(sp)
    80000972:	6ae2                	ld	s5,24(sp)
    80000974:	6b42                	ld	s6,16(sp)
    80000976:	6ba2                	ld	s7,8(sp)
    80000978:	6161                	addi	sp,sp,80
    8000097a:	8082                	ret
    8000097c:	fff90713          	addi	a4,s2,-1 # fff <_entry-0x7ffff001>
    80000980:	9742                	add	a4,a4,a6
      --max;
    80000982:	40b70933          	sub	s2,a4,a1
    srcva = va0 + PGSIZE;
    80000986:	01348bb3          	add	s7,s1,s3
  while(got_null == 0 && max > 0){
    8000098a:	04e58463          	beq	a1,a4,800009d2 <copyinstr+0x9e>
{
    8000098e:	8b3e                	mv	s6,a5
    va0 = PGROUNDDOWN(srcva);
    80000990:	015bf4b3          	and	s1,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000994:	85a6                	mv	a1,s1
    80000996:	8552                	mv	a0,s4
    80000998:	ac5ff0ef          	jal	8000045c <walkaddr>
    if(pa0 == 0)
    8000099c:	cd0d                	beqz	a0,800009d6 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    8000099e:	417486b3          	sub	a3,s1,s7
    800009a2:	96ce                	add	a3,a3,s3
    if(n > max)
    800009a4:	00d97363          	bgeu	s2,a3,800009aa <copyinstr+0x76>
    800009a8:	86ca                	mv	a3,s2
    char *p = (char *) (pa0 + (srcva - va0));
    800009aa:	955e                	add	a0,a0,s7
    800009ac:	8d05                	sub	a0,a0,s1
    while(n > 0){
    800009ae:	c695                	beqz	a3,800009da <copyinstr+0xa6>
    800009b0:	87da                	mv	a5,s6
    800009b2:	885a                	mv	a6,s6
      if(*p == '\0'){
    800009b4:	41650633          	sub	a2,a0,s6
    while(n > 0){
    800009b8:	96da                	add	a3,a3,s6
    800009ba:	85be                	mv	a1,a5
      if(*p == '\0'){
    800009bc:	00f60733          	add	a4,a2,a5
    800009c0:	00074703          	lbu	a4,0(a4)
    800009c4:	db59                	beqz	a4,8000095a <copyinstr+0x26>
        *dst = *p;
    800009c6:	00e78023          	sb	a4,0(a5)
      dst++;
    800009ca:	0785                	addi	a5,a5,1
    while(n > 0){
    800009cc:	fed797e3          	bne	a5,a3,800009ba <copyinstr+0x86>
    800009d0:	b775                	j	8000097c <copyinstr+0x48>
    800009d2:	4781                	li	a5,0
    800009d4:	b771                	j	80000960 <copyinstr+0x2c>
      return -1;
    800009d6:	557d                	li	a0,-1
    800009d8:	b779                	j	80000966 <copyinstr+0x32>
    srcva = va0 + PGSIZE;
    800009da:	6b85                	lui	s7,0x1
    800009dc:	9ba6                	add	s7,s7,s1
    800009de:	87da                	mv	a5,s6
    800009e0:	b77d                	j	8000098e <copyinstr+0x5a>
  int got_null = 0;
    800009e2:	4781                	li	a5,0
  if(got_null){
    800009e4:	37fd                	addiw	a5,a5,-1
    800009e6:	0007851b          	sext.w	a0,a5
}
    800009ea:	8082                	ret

00000000800009ec <ismapped>:
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va)
{
    800009ec:	1141                	addi	sp,sp,-16
    800009ee:	e406                	sd	ra,8(sp)
    800009f0:	e022                	sd	s0,0(sp)
    800009f2:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    800009f4:	4601                	li	a2,0
    800009f6:	9cdff0ef          	jal	800003c2 <walk>
  if (pte == 0) {
    800009fa:	c519                	beqz	a0,80000a08 <ismapped+0x1c>
    return 0;
  }
  if (*pte & PTE_V){
    800009fc:	6108                	ld	a0,0(a0)
    800009fe:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    80000a00:	60a2                	ld	ra,8(sp)
    80000a02:	6402                	ld	s0,0(sp)
    80000a04:	0141                	addi	sp,sp,16
    80000a06:	8082                	ret
    return 0;
    80000a08:	4501                	li	a0,0
    80000a0a:	bfdd                	j	80000a00 <ismapped+0x14>

0000000080000a0c <vmfault>:
{
    80000a0c:	7179                	addi	sp,sp,-48
    80000a0e:	f406                	sd	ra,40(sp)
    80000a10:	f022                	sd	s0,32(sp)
    80000a12:	ec26                	sd	s1,24(sp)
    80000a14:	e44e                	sd	s3,8(sp)
    80000a16:	1800                	addi	s0,sp,48
    80000a18:	89aa                	mv	s3,a0
    80000a1a:	84ae                	mv	s1,a1
  struct proc *p = myproc();
    80000a1c:	35e000ef          	jal	80000d7a <myproc>
  if (va >= p->sz)
    80000a20:	653c                	ld	a5,72(a0)
    80000a22:	00f4ea63          	bltu	s1,a5,80000a36 <vmfault+0x2a>
    return 0;
    80000a26:	4981                	li	s3,0
}
    80000a28:	854e                	mv	a0,s3
    80000a2a:	70a2                	ld	ra,40(sp)
    80000a2c:	7402                	ld	s0,32(sp)
    80000a2e:	64e2                	ld	s1,24(sp)
    80000a30:	69a2                	ld	s3,8(sp)
    80000a32:	6145                	addi	sp,sp,48
    80000a34:	8082                	ret
    80000a36:	e84a                	sd	s2,16(sp)
    80000a38:	892a                	mv	s2,a0
  va = PGROUNDDOWN(va);
    80000a3a:	77fd                	lui	a5,0xfffff
    80000a3c:	8cfd                	and	s1,s1,a5
  if(ismapped(pagetable, va)) {
    80000a3e:	85a6                	mv	a1,s1
    80000a40:	854e                	mv	a0,s3
    80000a42:	fabff0ef          	jal	800009ec <ismapped>
    return 0;
    80000a46:	4981                	li	s3,0
  if(ismapped(pagetable, va)) {
    80000a48:	c119                	beqz	a0,80000a4e <vmfault+0x42>
    80000a4a:	6942                	ld	s2,16(sp)
    80000a4c:	bff1                	j	80000a28 <vmfault+0x1c>
    80000a4e:	e052                	sd	s4,0(sp)
  mem = (uint64) kalloc();
    80000a50:	eaeff0ef          	jal	800000fe <kalloc>
    80000a54:	8a2a                	mv	s4,a0
  if(mem == 0)
    80000a56:	c90d                	beqz	a0,80000a88 <vmfault+0x7c>
  mem = (uint64) kalloc();
    80000a58:	89aa                	mv	s3,a0
  memset((void *) mem, 0, PGSIZE);
    80000a5a:	6605                	lui	a2,0x1
    80000a5c:	4581                	li	a1,0
    80000a5e:	ef0ff0ef          	jal	8000014e <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    80000a62:	4759                	li	a4,22
    80000a64:	86d2                	mv	a3,s4
    80000a66:	6605                	lui	a2,0x1
    80000a68:	85a6                	mv	a1,s1
    80000a6a:	05093503          	ld	a0,80(s2)
    80000a6e:	a2dff0ef          	jal	8000049a <mappages>
    80000a72:	e501                	bnez	a0,80000a7a <vmfault+0x6e>
    80000a74:	6942                	ld	s2,16(sp)
    80000a76:	6a02                	ld	s4,0(sp)
    80000a78:	bf45                	j	80000a28 <vmfault+0x1c>
    kfree((void *)mem);
    80000a7a:	8552                	mv	a0,s4
    80000a7c:	da0ff0ef          	jal	8000001c <kfree>
    return 0;
    80000a80:	4981                	li	s3,0
    80000a82:	6942                	ld	s2,16(sp)
    80000a84:	6a02                	ld	s4,0(sp)
    80000a86:	b74d                	j	80000a28 <vmfault+0x1c>
    80000a88:	6942                	ld	s2,16(sp)
    80000a8a:	6a02                	ld	s4,0(sp)
    80000a8c:	bf71                	j	80000a28 <vmfault+0x1c>

0000000080000a8e <copyout>:
  while(len > 0){
    80000a8e:	c2cd                	beqz	a3,80000b30 <copyout+0xa2>
{
    80000a90:	711d                	addi	sp,sp,-96
    80000a92:	ec86                	sd	ra,88(sp)
    80000a94:	e8a2                	sd	s0,80(sp)
    80000a96:	e4a6                	sd	s1,72(sp)
    80000a98:	f852                	sd	s4,48(sp)
    80000a9a:	f05a                	sd	s6,32(sp)
    80000a9c:	ec5e                	sd	s7,24(sp)
    80000a9e:	e862                	sd	s8,16(sp)
    80000aa0:	1080                	addi	s0,sp,96
    80000aa2:	8c2a                	mv	s8,a0
    80000aa4:	8b2e                	mv	s6,a1
    80000aa6:	8bb2                	mv	s7,a2
    80000aa8:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(dstva);
    80000aaa:	74fd                	lui	s1,0xfffff
    80000aac:	8ced                	and	s1,s1,a1
    if(va0 >= MAXVA)
    80000aae:	57fd                	li	a5,-1
    80000ab0:	83e9                	srli	a5,a5,0x1a
    80000ab2:	0897e163          	bltu	a5,s1,80000b34 <copyout+0xa6>
    80000ab6:	e0ca                	sd	s2,64(sp)
    80000ab8:	fc4e                	sd	s3,56(sp)
    80000aba:	f456                	sd	s5,40(sp)
    80000abc:	e466                	sd	s9,8(sp)
    80000abe:	e06a                	sd	s10,0(sp)
    80000ac0:	6d05                	lui	s10,0x1
    80000ac2:	8cbe                	mv	s9,a5
    80000ac4:	a015                	j	80000ae8 <copyout+0x5a>
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000ac6:	409b0533          	sub	a0,s6,s1
    80000aca:	0009861b          	sext.w	a2,s3
    80000ace:	85de                	mv	a1,s7
    80000ad0:	954a                	add	a0,a0,s2
    80000ad2:	ed8ff0ef          	jal	800001aa <memmove>
    len -= n;
    80000ad6:	413a0a33          	sub	s4,s4,s3
    src += n;
    80000ada:	9bce                	add	s7,s7,s3
  while(len > 0){
    80000adc:	040a0363          	beqz	s4,80000b22 <copyout+0x94>
    if(va0 >= MAXVA)
    80000ae0:	055cec63          	bltu	s9,s5,80000b38 <copyout+0xaa>
    80000ae4:	84d6                	mv	s1,s5
    80000ae6:	8b56                	mv	s6,s5
    pa0 = walkaddr(pagetable, va0);
    80000ae8:	85a6                	mv	a1,s1
    80000aea:	8562                	mv	a0,s8
    80000aec:	971ff0ef          	jal	8000045c <walkaddr>
    80000af0:	892a                	mv	s2,a0
    if(pa0 == 0) {
    80000af2:	e901                	bnez	a0,80000b02 <copyout+0x74>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000af4:	4601                	li	a2,0
    80000af6:	85a6                	mv	a1,s1
    80000af8:	8562                	mv	a0,s8
    80000afa:	f13ff0ef          	jal	80000a0c <vmfault>
    80000afe:	892a                	mv	s2,a0
    80000b00:	c139                	beqz	a0,80000b46 <copyout+0xb8>
    pte = walk(pagetable, va0, 0);
    80000b02:	4601                	li	a2,0
    80000b04:	85a6                	mv	a1,s1
    80000b06:	8562                	mv	a0,s8
    80000b08:	8bbff0ef          	jal	800003c2 <walk>
    if((*pte & PTE_W) == 0)
    80000b0c:	611c                	ld	a5,0(a0)
    80000b0e:	8b91                	andi	a5,a5,4
    80000b10:	c3b1                	beqz	a5,80000b54 <copyout+0xc6>
    n = PGSIZE - (dstva - va0);
    80000b12:	01a48ab3          	add	s5,s1,s10
    80000b16:	416a89b3          	sub	s3,s5,s6
    if(n > len)
    80000b1a:	fb3a76e3          	bgeu	s4,s3,80000ac6 <copyout+0x38>
    80000b1e:	89d2                	mv	s3,s4
    80000b20:	b75d                	j	80000ac6 <copyout+0x38>
  return 0;
    80000b22:	4501                	li	a0,0
    80000b24:	6906                	ld	s2,64(sp)
    80000b26:	79e2                	ld	s3,56(sp)
    80000b28:	7aa2                	ld	s5,40(sp)
    80000b2a:	6ca2                	ld	s9,8(sp)
    80000b2c:	6d02                	ld	s10,0(sp)
    80000b2e:	a80d                	j	80000b60 <copyout+0xd2>
    80000b30:	4501                	li	a0,0
}
    80000b32:	8082                	ret
      return -1;
    80000b34:	557d                	li	a0,-1
    80000b36:	a02d                	j	80000b60 <copyout+0xd2>
    80000b38:	557d                	li	a0,-1
    80000b3a:	6906                	ld	s2,64(sp)
    80000b3c:	79e2                	ld	s3,56(sp)
    80000b3e:	7aa2                	ld	s5,40(sp)
    80000b40:	6ca2                	ld	s9,8(sp)
    80000b42:	6d02                	ld	s10,0(sp)
    80000b44:	a831                	j	80000b60 <copyout+0xd2>
        return -1;
    80000b46:	557d                	li	a0,-1
    80000b48:	6906                	ld	s2,64(sp)
    80000b4a:	79e2                	ld	s3,56(sp)
    80000b4c:	7aa2                	ld	s5,40(sp)
    80000b4e:	6ca2                	ld	s9,8(sp)
    80000b50:	6d02                	ld	s10,0(sp)
    80000b52:	a039                	j	80000b60 <copyout+0xd2>
      return -1;
    80000b54:	557d                	li	a0,-1
    80000b56:	6906                	ld	s2,64(sp)
    80000b58:	79e2                	ld	s3,56(sp)
    80000b5a:	7aa2                	ld	s5,40(sp)
    80000b5c:	6ca2                	ld	s9,8(sp)
    80000b5e:	6d02                	ld	s10,0(sp)
}
    80000b60:	60e6                	ld	ra,88(sp)
    80000b62:	6446                	ld	s0,80(sp)
    80000b64:	64a6                	ld	s1,72(sp)
    80000b66:	7a42                	ld	s4,48(sp)
    80000b68:	7b02                	ld	s6,32(sp)
    80000b6a:	6be2                	ld	s7,24(sp)
    80000b6c:	6c42                	ld	s8,16(sp)
    80000b6e:	6125                	addi	sp,sp,96
    80000b70:	8082                	ret

0000000080000b72 <copyin>:
  while(len > 0){
    80000b72:	c6c9                	beqz	a3,80000bfc <copyin+0x8a>
{
    80000b74:	715d                	addi	sp,sp,-80
    80000b76:	e486                	sd	ra,72(sp)
    80000b78:	e0a2                	sd	s0,64(sp)
    80000b7a:	fc26                	sd	s1,56(sp)
    80000b7c:	f84a                	sd	s2,48(sp)
    80000b7e:	f44e                	sd	s3,40(sp)
    80000b80:	f052                	sd	s4,32(sp)
    80000b82:	ec56                	sd	s5,24(sp)
    80000b84:	e85a                	sd	s6,16(sp)
    80000b86:	e45e                	sd	s7,8(sp)
    80000b88:	e062                	sd	s8,0(sp)
    80000b8a:	0880                	addi	s0,sp,80
    80000b8c:	8baa                	mv	s7,a0
    80000b8e:	8aae                	mv	s5,a1
    80000b90:	8932                	mv	s2,a2
    80000b92:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(srcva);
    80000b94:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (srcva - va0);
    80000b96:	6b05                	lui	s6,0x1
    80000b98:	a035                	j	80000bc4 <copyin+0x52>
    80000b9a:	412984b3          	sub	s1,s3,s2
    80000b9e:	94da                	add	s1,s1,s6
    if(n > len)
    80000ba0:	009a7363          	bgeu	s4,s1,80000ba6 <copyin+0x34>
    80000ba4:	84d2                	mv	s1,s4
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000ba6:	413905b3          	sub	a1,s2,s3
    80000baa:	0004861b          	sext.w	a2,s1
    80000bae:	95aa                	add	a1,a1,a0
    80000bb0:	8556                	mv	a0,s5
    80000bb2:	df8ff0ef          	jal	800001aa <memmove>
    len -= n;
    80000bb6:	409a0a33          	sub	s4,s4,s1
    dst += n;
    80000bba:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    80000bbc:	01698933          	add	s2,s3,s6
  while(len > 0){
    80000bc0:	020a0163          	beqz	s4,80000be2 <copyin+0x70>
    va0 = PGROUNDDOWN(srcva);
    80000bc4:	018979b3          	and	s3,s2,s8
    pa0 = walkaddr(pagetable, va0);
    80000bc8:	85ce                	mv	a1,s3
    80000bca:	855e                	mv	a0,s7
    80000bcc:	891ff0ef          	jal	8000045c <walkaddr>
    if(pa0 == 0) {
    80000bd0:	f569                	bnez	a0,80000b9a <copyin+0x28>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000bd2:	4601                	li	a2,0
    80000bd4:	85ce                	mv	a1,s3
    80000bd6:	855e                	mv	a0,s7
    80000bd8:	e35ff0ef          	jal	80000a0c <vmfault>
    80000bdc:	fd5d                	bnez	a0,80000b9a <copyin+0x28>
        return -1;
    80000bde:	557d                	li	a0,-1
    80000be0:	a011                	j	80000be4 <copyin+0x72>
  return 0;
    80000be2:	4501                	li	a0,0
}
    80000be4:	60a6                	ld	ra,72(sp)
    80000be6:	6406                	ld	s0,64(sp)
    80000be8:	74e2                	ld	s1,56(sp)
    80000bea:	7942                	ld	s2,48(sp)
    80000bec:	79a2                	ld	s3,40(sp)
    80000bee:	7a02                	ld	s4,32(sp)
    80000bf0:	6ae2                	ld	s5,24(sp)
    80000bf2:	6b42                	ld	s6,16(sp)
    80000bf4:	6ba2                	ld	s7,8(sp)
    80000bf6:	6c02                	ld	s8,0(sp)
    80000bf8:	6161                	addi	sp,sp,80
    80000bfa:	8082                	ret
  return 0;
    80000bfc:	4501                	li	a0,0
}
    80000bfe:	8082                	ret

0000000080000c00 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000c00:	7139                	addi	sp,sp,-64
    80000c02:	fc06                	sd	ra,56(sp)
    80000c04:	f822                	sd	s0,48(sp)
    80000c06:	f426                	sd	s1,40(sp)
    80000c08:	f04a                	sd	s2,32(sp)
    80000c0a:	ec4e                	sd	s3,24(sp)
    80000c0c:	e852                	sd	s4,16(sp)
    80000c0e:	e456                	sd	s5,8(sp)
    80000c10:	e05a                	sd	s6,0(sp)
    80000c12:	0080                	addi	s0,sp,64
    80000c14:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c16:	0000a497          	auipc	s1,0xa
    80000c1a:	a2a48493          	addi	s1,s1,-1494 # 8000a640 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000c1e:	8b26                	mv	s6,s1
    80000c20:	04fa5937          	lui	s2,0x4fa5
    80000c24:	fa590913          	addi	s2,s2,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80000c28:	0932                	slli	s2,s2,0xc
    80000c2a:	fa590913          	addi	s2,s2,-91
    80000c2e:	0932                	slli	s2,s2,0xc
    80000c30:	fa590913          	addi	s2,s2,-91
    80000c34:	0932                	slli	s2,s2,0xc
    80000c36:	fa590913          	addi	s2,s2,-91
    80000c3a:	040009b7          	lui	s3,0x4000
    80000c3e:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000c40:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c42:	0000fa97          	auipc	s5,0xf
    80000c46:	3fea8a93          	addi	s5,s5,1022 # 80010040 <tickslock>
    char *pa = kalloc();
    80000c4a:	cb4ff0ef          	jal	800000fe <kalloc>
    80000c4e:	862a                	mv	a2,a0
    if(pa == 0)
    80000c50:	cd15                	beqz	a0,80000c8c <proc_mapstacks+0x8c>
    uint64 va = KSTACK((int) (p - proc));
    80000c52:	416485b3          	sub	a1,s1,s6
    80000c56:	858d                	srai	a1,a1,0x3
    80000c58:	032585b3          	mul	a1,a1,s2
    80000c5c:	2585                	addiw	a1,a1,1
    80000c5e:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c62:	4719                	li	a4,6
    80000c64:	6685                	lui	a3,0x1
    80000c66:	40b985b3          	sub	a1,s3,a1
    80000c6a:	8552                	mv	a0,s4
    80000c6c:	8dfff0ef          	jal	8000054a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c70:	16848493          	addi	s1,s1,360
    80000c74:	fd549be3          	bne	s1,s5,80000c4a <proc_mapstacks+0x4a>
  }
}
    80000c78:	70e2                	ld	ra,56(sp)
    80000c7a:	7442                	ld	s0,48(sp)
    80000c7c:	74a2                	ld	s1,40(sp)
    80000c7e:	7902                	ld	s2,32(sp)
    80000c80:	69e2                	ld	s3,24(sp)
    80000c82:	6a42                	ld	s4,16(sp)
    80000c84:	6aa2                	ld	s5,8(sp)
    80000c86:	6b02                	ld	s6,0(sp)
    80000c88:	6121                	addi	sp,sp,64
    80000c8a:	8082                	ret
      panic("kalloc");
    80000c8c:	00006517          	auipc	a0,0x6
    80000c90:	46c50513          	addi	a0,a0,1132 # 800070f8 <etext+0xf8>
    80000c94:	17b040ef          	jal	8000560e <panic>

0000000080000c98 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000c98:	7139                	addi	sp,sp,-64
    80000c9a:	fc06                	sd	ra,56(sp)
    80000c9c:	f822                	sd	s0,48(sp)
    80000c9e:	f426                	sd	s1,40(sp)
    80000ca0:	f04a                	sd	s2,32(sp)
    80000ca2:	ec4e                	sd	s3,24(sp)
    80000ca4:	e852                	sd	s4,16(sp)
    80000ca6:	e456                	sd	s5,8(sp)
    80000ca8:	e05a                	sd	s6,0(sp)
    80000caa:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000cac:	00006597          	auipc	a1,0x6
    80000cb0:	45458593          	addi	a1,a1,1108 # 80007100 <etext+0x100>
    80000cb4:	00009517          	auipc	a0,0x9
    80000cb8:	55c50513          	addi	a0,a0,1372 # 8000a210 <pid_lock>
    80000cbc:	38f040ef          	jal	8000584a <initlock>
  initlock(&wait_lock, "wait_lock");
    80000cc0:	00006597          	auipc	a1,0x6
    80000cc4:	44858593          	addi	a1,a1,1096 # 80007108 <etext+0x108>
    80000cc8:	00009517          	auipc	a0,0x9
    80000ccc:	56050513          	addi	a0,a0,1376 # 8000a228 <wait_lock>
    80000cd0:	37b040ef          	jal	8000584a <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cd4:	0000a497          	auipc	s1,0xa
    80000cd8:	96c48493          	addi	s1,s1,-1684 # 8000a640 <proc>
      initlock(&p->lock, "proc");
    80000cdc:	00006b17          	auipc	s6,0x6
    80000ce0:	43cb0b13          	addi	s6,s6,1084 # 80007118 <etext+0x118>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000ce4:	8aa6                	mv	s5,s1
    80000ce6:	04fa5937          	lui	s2,0x4fa5
    80000cea:	fa590913          	addi	s2,s2,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80000cee:	0932                	slli	s2,s2,0xc
    80000cf0:	fa590913          	addi	s2,s2,-91
    80000cf4:	0932                	slli	s2,s2,0xc
    80000cf6:	fa590913          	addi	s2,s2,-91
    80000cfa:	0932                	slli	s2,s2,0xc
    80000cfc:	fa590913          	addi	s2,s2,-91
    80000d00:	040009b7          	lui	s3,0x4000
    80000d04:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000d06:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d08:	0000fa17          	auipc	s4,0xf
    80000d0c:	338a0a13          	addi	s4,s4,824 # 80010040 <tickslock>
      initlock(&p->lock, "proc");
    80000d10:	85da                	mv	a1,s6
    80000d12:	8526                	mv	a0,s1
    80000d14:	337040ef          	jal	8000584a <initlock>
      p->state = UNUSED;
    80000d18:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000d1c:	415487b3          	sub	a5,s1,s5
    80000d20:	878d                	srai	a5,a5,0x3
    80000d22:	032787b3          	mul	a5,a5,s2
    80000d26:	2785                	addiw	a5,a5,1 # fffffffffffff001 <end+0xffffffff7ffdbb09>
    80000d28:	00d7979b          	slliw	a5,a5,0xd
    80000d2c:	40f987b3          	sub	a5,s3,a5
    80000d30:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d32:	16848493          	addi	s1,s1,360
    80000d36:	fd449de3          	bne	s1,s4,80000d10 <procinit+0x78>
  }
}
    80000d3a:	70e2                	ld	ra,56(sp)
    80000d3c:	7442                	ld	s0,48(sp)
    80000d3e:	74a2                	ld	s1,40(sp)
    80000d40:	7902                	ld	s2,32(sp)
    80000d42:	69e2                	ld	s3,24(sp)
    80000d44:	6a42                	ld	s4,16(sp)
    80000d46:	6aa2                	ld	s5,8(sp)
    80000d48:	6b02                	ld	s6,0(sp)
    80000d4a:	6121                	addi	sp,sp,64
    80000d4c:	8082                	ret

0000000080000d4e <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000d4e:	1141                	addi	sp,sp,-16
    80000d50:	e422                	sd	s0,8(sp)
    80000d52:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d54:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d56:	2501                	sext.w	a0,a0
    80000d58:	6422                	ld	s0,8(sp)
    80000d5a:	0141                	addi	sp,sp,16
    80000d5c:	8082                	ret

0000000080000d5e <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000d5e:	1141                	addi	sp,sp,-16
    80000d60:	e422                	sd	s0,8(sp)
    80000d62:	0800                	addi	s0,sp,16
    80000d64:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d66:	2781                	sext.w	a5,a5
    80000d68:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d6a:	00009517          	auipc	a0,0x9
    80000d6e:	4d650513          	addi	a0,a0,1238 # 8000a240 <cpus>
    80000d72:	953e                	add	a0,a0,a5
    80000d74:	6422                	ld	s0,8(sp)
    80000d76:	0141                	addi	sp,sp,16
    80000d78:	8082                	ret

0000000080000d7a <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000d7a:	1101                	addi	sp,sp,-32
    80000d7c:	ec06                	sd	ra,24(sp)
    80000d7e:	e822                	sd	s0,16(sp)
    80000d80:	e426                	sd	s1,8(sp)
    80000d82:	1000                	addi	s0,sp,32
  push_off();
    80000d84:	307040ef          	jal	8000588a <push_off>
    80000d88:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000d8a:	2781                	sext.w	a5,a5
    80000d8c:	079e                	slli	a5,a5,0x7
    80000d8e:	00009717          	auipc	a4,0x9
    80000d92:	48270713          	addi	a4,a4,1154 # 8000a210 <pid_lock>
    80000d96:	97ba                	add	a5,a5,a4
    80000d98:	7b84                	ld	s1,48(a5)
  pop_off();
    80000d9a:	375040ef          	jal	8000590e <pop_off>
  return p;
}
    80000d9e:	8526                	mv	a0,s1
    80000da0:	60e2                	ld	ra,24(sp)
    80000da2:	6442                	ld	s0,16(sp)
    80000da4:	64a2                	ld	s1,8(sp)
    80000da6:	6105                	addi	sp,sp,32
    80000da8:	8082                	ret

0000000080000daa <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000daa:	7179                	addi	sp,sp,-48
    80000dac:	f406                	sd	ra,40(sp)
    80000dae:	f022                	sd	s0,32(sp)
    80000db0:	ec26                	sd	s1,24(sp)
    80000db2:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    80000db4:	fc7ff0ef          	jal	80000d7a <myproc>
    80000db8:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80000dba:	3a9040ef          	jal	80005962 <release>

  if (first) {
    80000dbe:	00009797          	auipc	a5,0x9
    80000dc2:	3d27a783          	lw	a5,978(a5) # 8000a190 <first.1>
    80000dc6:	cf8d                	beqz	a5,80000e00 <forkret+0x56>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    80000dc8:	4505                	li	a0,1
    80000dca:	3fb010ef          	jal	800029c4 <fsinit>

    first = 0;
    80000dce:	00009797          	auipc	a5,0x9
    80000dd2:	3c07a123          	sw	zero,962(a5) # 8000a190 <first.1>
    // ensure other cores see first=0.
    __sync_synchronize();
    80000dd6:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80000dda:	00006517          	auipc	a0,0x6
    80000dde:	34650513          	addi	a0,a0,838 # 80007120 <etext+0x120>
    80000de2:	fca43823          	sd	a0,-48(s0)
    80000de6:	fc043c23          	sd	zero,-40(s0)
    80000dea:	fd040593          	addi	a1,s0,-48
    80000dee:	4d7020ef          	jal	80003ac4 <kexec>
    80000df2:	6cbc                	ld	a5,88(s1)
    80000df4:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    80000df6:	6cbc                	ld	a5,88(s1)
    80000df8:	7bb8                	ld	a4,112(a5)
    80000dfa:	57fd                	li	a5,-1
    80000dfc:	02f70d63          	beq	a4,a5,80000e36 <forkret+0x8c>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80000e00:	2ad000ef          	jal	800018ac <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80000e04:	68a8                	ld	a0,80(s1)
    80000e06:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80000e08:	04000737          	lui	a4,0x4000
    80000e0c:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80000e0e:	0732                	slli	a4,a4,0xc
    80000e10:	00005797          	auipc	a5,0x5
    80000e14:	28c78793          	addi	a5,a5,652 # 8000609c <userret>
    80000e18:	00005697          	auipc	a3,0x5
    80000e1c:	1e868693          	addi	a3,a3,488 # 80006000 <_trampoline>
    80000e20:	8f95                	sub	a5,a5,a3
    80000e22:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80000e24:	577d                	li	a4,-1
    80000e26:	177e                	slli	a4,a4,0x3f
    80000e28:	8d59                	or	a0,a0,a4
    80000e2a:	9782                	jalr	a5
}
    80000e2c:	70a2                	ld	ra,40(sp)
    80000e2e:	7402                	ld	s0,32(sp)
    80000e30:	64e2                	ld	s1,24(sp)
    80000e32:	6145                	addi	sp,sp,48
    80000e34:	8082                	ret
      panic("exec");
    80000e36:	00006517          	auipc	a0,0x6
    80000e3a:	2f250513          	addi	a0,a0,754 # 80007128 <etext+0x128>
    80000e3e:	7d0040ef          	jal	8000560e <panic>

0000000080000e42 <allocpid>:
{
    80000e42:	1101                	addi	sp,sp,-32
    80000e44:	ec06                	sd	ra,24(sp)
    80000e46:	e822                	sd	s0,16(sp)
    80000e48:	e426                	sd	s1,8(sp)
    80000e4a:	e04a                	sd	s2,0(sp)
    80000e4c:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e4e:	00009917          	auipc	s2,0x9
    80000e52:	3c290913          	addi	s2,s2,962 # 8000a210 <pid_lock>
    80000e56:	854a                	mv	a0,s2
    80000e58:	273040ef          	jal	800058ca <acquire>
  pid = nextpid;
    80000e5c:	00009797          	auipc	a5,0x9
    80000e60:	33878793          	addi	a5,a5,824 # 8000a194 <nextpid>
    80000e64:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e66:	0014871b          	addiw	a4,s1,1
    80000e6a:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e6c:	854a                	mv	a0,s2
    80000e6e:	2f5040ef          	jal	80005962 <release>
}
    80000e72:	8526                	mv	a0,s1
    80000e74:	60e2                	ld	ra,24(sp)
    80000e76:	6442                	ld	s0,16(sp)
    80000e78:	64a2                	ld	s1,8(sp)
    80000e7a:	6902                	ld	s2,0(sp)
    80000e7c:	6105                	addi	sp,sp,32
    80000e7e:	8082                	ret

0000000080000e80 <proc_pagetable>:
{
    80000e80:	1101                	addi	sp,sp,-32
    80000e82:	ec06                	sd	ra,24(sp)
    80000e84:	e822                	sd	s0,16(sp)
    80000e86:	e426                	sd	s1,8(sp)
    80000e88:	e04a                	sd	s2,0(sp)
    80000e8a:	1000                	addi	s0,sp,32
    80000e8c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e8e:	fb2ff0ef          	jal	80000640 <uvmcreate>
    80000e92:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000e94:	cd05                	beqz	a0,80000ecc <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000e96:	4729                	li	a4,10
    80000e98:	00005697          	auipc	a3,0x5
    80000e9c:	16868693          	addi	a3,a3,360 # 80006000 <_trampoline>
    80000ea0:	6605                	lui	a2,0x1
    80000ea2:	040005b7          	lui	a1,0x4000
    80000ea6:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ea8:	05b2                	slli	a1,a1,0xc
    80000eaa:	df0ff0ef          	jal	8000049a <mappages>
    80000eae:	02054663          	bltz	a0,80000eda <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000eb2:	4719                	li	a4,6
    80000eb4:	05893683          	ld	a3,88(s2)
    80000eb8:	6605                	lui	a2,0x1
    80000eba:	020005b7          	lui	a1,0x2000
    80000ebe:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000ec0:	05b6                	slli	a1,a1,0xd
    80000ec2:	8526                	mv	a0,s1
    80000ec4:	dd6ff0ef          	jal	8000049a <mappages>
    80000ec8:	00054f63          	bltz	a0,80000ee6 <proc_pagetable+0x66>
}
    80000ecc:	8526                	mv	a0,s1
    80000ece:	60e2                	ld	ra,24(sp)
    80000ed0:	6442                	ld	s0,16(sp)
    80000ed2:	64a2                	ld	s1,8(sp)
    80000ed4:	6902                	ld	s2,0(sp)
    80000ed6:	6105                	addi	sp,sp,32
    80000ed8:	8082                	ret
    uvmfree(pagetable, 0);
    80000eda:	4581                	li	a1,0
    80000edc:	8526                	mv	a0,s1
    80000ede:	95dff0ef          	jal	8000083a <uvmfree>
    return 0;
    80000ee2:	4481                	li	s1,0
    80000ee4:	b7e5                	j	80000ecc <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ee6:	4681                	li	a3,0
    80000ee8:	4605                	li	a2,1
    80000eea:	040005b7          	lui	a1,0x4000
    80000eee:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ef0:	05b2                	slli	a1,a1,0xc
    80000ef2:	8526                	mv	a0,s1
    80000ef4:	f72ff0ef          	jal	80000666 <uvmunmap>
    uvmfree(pagetable, 0);
    80000ef8:	4581                	li	a1,0
    80000efa:	8526                	mv	a0,s1
    80000efc:	93fff0ef          	jal	8000083a <uvmfree>
    return 0;
    80000f00:	4481                	li	s1,0
    80000f02:	b7e9                	j	80000ecc <proc_pagetable+0x4c>

0000000080000f04 <proc_freepagetable>:
{
    80000f04:	1101                	addi	sp,sp,-32
    80000f06:	ec06                	sd	ra,24(sp)
    80000f08:	e822                	sd	s0,16(sp)
    80000f0a:	e426                	sd	s1,8(sp)
    80000f0c:	e04a                	sd	s2,0(sp)
    80000f0e:	1000                	addi	s0,sp,32
    80000f10:	84aa                	mv	s1,a0
    80000f12:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f14:	4681                	li	a3,0
    80000f16:	4605                	li	a2,1
    80000f18:	040005b7          	lui	a1,0x4000
    80000f1c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f1e:	05b2                	slli	a1,a1,0xc
    80000f20:	f46ff0ef          	jal	80000666 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000f24:	4681                	li	a3,0
    80000f26:	4605                	li	a2,1
    80000f28:	020005b7          	lui	a1,0x2000
    80000f2c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f2e:	05b6                	slli	a1,a1,0xd
    80000f30:	8526                	mv	a0,s1
    80000f32:	f34ff0ef          	jal	80000666 <uvmunmap>
  uvmfree(pagetable, sz);
    80000f36:	85ca                	mv	a1,s2
    80000f38:	8526                	mv	a0,s1
    80000f3a:	901ff0ef          	jal	8000083a <uvmfree>
}
    80000f3e:	60e2                	ld	ra,24(sp)
    80000f40:	6442                	ld	s0,16(sp)
    80000f42:	64a2                	ld	s1,8(sp)
    80000f44:	6902                	ld	s2,0(sp)
    80000f46:	6105                	addi	sp,sp,32
    80000f48:	8082                	ret

0000000080000f4a <freeproc>:
{
    80000f4a:	1101                	addi	sp,sp,-32
    80000f4c:	ec06                	sd	ra,24(sp)
    80000f4e:	e822                	sd	s0,16(sp)
    80000f50:	e426                	sd	s1,8(sp)
    80000f52:	1000                	addi	s0,sp,32
    80000f54:	84aa                	mv	s1,a0
  if(p->trapframe)
    80000f56:	6d28                	ld	a0,88(a0)
    80000f58:	c119                	beqz	a0,80000f5e <freeproc+0x14>
    kfree((void*)p->trapframe);
    80000f5a:	8c2ff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f5e:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80000f62:	68a8                	ld	a0,80(s1)
    80000f64:	c501                	beqz	a0,80000f6c <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80000f66:	64ac                	ld	a1,72(s1)
    80000f68:	f9dff0ef          	jal	80000f04 <proc_freepagetable>
  p->pagetable = 0;
    80000f6c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f70:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f74:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f78:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f7c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f80:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000f84:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000f88:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000f8c:	0004ac23          	sw	zero,24(s1)
}
    80000f90:	60e2                	ld	ra,24(sp)
    80000f92:	6442                	ld	s0,16(sp)
    80000f94:	64a2                	ld	s1,8(sp)
    80000f96:	6105                	addi	sp,sp,32
    80000f98:	8082                	ret

0000000080000f9a <allocproc>:
{
    80000f9a:	1101                	addi	sp,sp,-32
    80000f9c:	ec06                	sd	ra,24(sp)
    80000f9e:	e822                	sd	s0,16(sp)
    80000fa0:	e426                	sd	s1,8(sp)
    80000fa2:	e04a                	sd	s2,0(sp)
    80000fa4:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fa6:	00009497          	auipc	s1,0x9
    80000faa:	69a48493          	addi	s1,s1,1690 # 8000a640 <proc>
    80000fae:	0000f917          	auipc	s2,0xf
    80000fb2:	09290913          	addi	s2,s2,146 # 80010040 <tickslock>
    acquire(&p->lock);
    80000fb6:	8526                	mv	a0,s1
    80000fb8:	113040ef          	jal	800058ca <acquire>
    if(p->state == UNUSED) {
    80000fbc:	4c9c                	lw	a5,24(s1)
    80000fbe:	cb91                	beqz	a5,80000fd2 <allocproc+0x38>
      release(&p->lock);
    80000fc0:	8526                	mv	a0,s1
    80000fc2:	1a1040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fc6:	16848493          	addi	s1,s1,360
    80000fca:	ff2496e3          	bne	s1,s2,80000fb6 <allocproc+0x1c>
  return 0;
    80000fce:	4481                	li	s1,0
    80000fd0:	a089                	j	80001012 <allocproc+0x78>
  p->pid = allocpid();
    80000fd2:	e71ff0ef          	jal	80000e42 <allocpid>
    80000fd6:	d888                	sw	a0,48(s1)
  p->state = USED;
    80000fd8:	4785                	li	a5,1
    80000fda:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80000fdc:	922ff0ef          	jal	800000fe <kalloc>
    80000fe0:	892a                	mv	s2,a0
    80000fe2:	eca8                	sd	a0,88(s1)
    80000fe4:	cd15                	beqz	a0,80001020 <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80000fe6:	8526                	mv	a0,s1
    80000fe8:	e99ff0ef          	jal	80000e80 <proc_pagetable>
    80000fec:	892a                	mv	s2,a0
    80000fee:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80000ff0:	c121                	beqz	a0,80001030 <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80000ff2:	07000613          	li	a2,112
    80000ff6:	4581                	li	a1,0
    80000ff8:	06048513          	addi	a0,s1,96
    80000ffc:	952ff0ef          	jal	8000014e <memset>
  p->context.ra = (uint64)forkret;
    80001000:	00000797          	auipc	a5,0x0
    80001004:	daa78793          	addi	a5,a5,-598 # 80000daa <forkret>
    80001008:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    8000100a:	60bc                	ld	a5,64(s1)
    8000100c:	6705                	lui	a4,0x1
    8000100e:	97ba                	add	a5,a5,a4
    80001010:	f4bc                	sd	a5,104(s1)
}
    80001012:	8526                	mv	a0,s1
    80001014:	60e2                	ld	ra,24(sp)
    80001016:	6442                	ld	s0,16(sp)
    80001018:	64a2                	ld	s1,8(sp)
    8000101a:	6902                	ld	s2,0(sp)
    8000101c:	6105                	addi	sp,sp,32
    8000101e:	8082                	ret
    freeproc(p);
    80001020:	8526                	mv	a0,s1
    80001022:	f29ff0ef          	jal	80000f4a <freeproc>
    release(&p->lock);
    80001026:	8526                	mv	a0,s1
    80001028:	13b040ef          	jal	80005962 <release>
    return 0;
    8000102c:	84ca                	mv	s1,s2
    8000102e:	b7d5                	j	80001012 <allocproc+0x78>
    freeproc(p);
    80001030:	8526                	mv	a0,s1
    80001032:	f19ff0ef          	jal	80000f4a <freeproc>
    release(&p->lock);
    80001036:	8526                	mv	a0,s1
    80001038:	12b040ef          	jal	80005962 <release>
    return 0;
    8000103c:	84ca                	mv	s1,s2
    8000103e:	bfd1                	j	80001012 <allocproc+0x78>

0000000080001040 <userinit>:
{
    80001040:	1101                	addi	sp,sp,-32
    80001042:	ec06                	sd	ra,24(sp)
    80001044:	e822                	sd	s0,16(sp)
    80001046:	e426                	sd	s1,8(sp)
    80001048:	1000                	addi	s0,sp,32
  p = allocproc();
    8000104a:	f51ff0ef          	jal	80000f9a <allocproc>
    8000104e:	84aa                	mv	s1,a0
  initproc = p;
    80001050:	00009797          	auipc	a5,0x9
    80001054:	18a7b023          	sd	a0,384(a5) # 8000a1d0 <initproc>
  p->cwd = namei("/");
    80001058:	00006517          	auipc	a0,0x6
    8000105c:	0d850513          	addi	a0,a0,216 # 80007130 <etext+0x130>
    80001060:	687010ef          	jal	80002ee6 <namei>
    80001064:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001068:	478d                	li	a5,3
    8000106a:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000106c:	8526                	mv	a0,s1
    8000106e:	0f5040ef          	jal	80005962 <release>
}
    80001072:	60e2                	ld	ra,24(sp)
    80001074:	6442                	ld	s0,16(sp)
    80001076:	64a2                	ld	s1,8(sp)
    80001078:	6105                	addi	sp,sp,32
    8000107a:	8082                	ret

000000008000107c <growproc>:
{
    8000107c:	1101                	addi	sp,sp,-32
    8000107e:	ec06                	sd	ra,24(sp)
    80001080:	e822                	sd	s0,16(sp)
    80001082:	e426                	sd	s1,8(sp)
    80001084:	e04a                	sd	s2,0(sp)
    80001086:	1000                	addi	s0,sp,32
    80001088:	892a                	mv	s2,a0
  struct proc *p = myproc();
    8000108a:	cf1ff0ef          	jal	80000d7a <myproc>
    8000108e:	84aa                	mv	s1,a0
  sz = p->sz;
    80001090:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001092:	01204c63          	bgtz	s2,800010aa <growproc+0x2e>
  } else if(n < 0){
    80001096:	02094463          	bltz	s2,800010be <growproc+0x42>
  p->sz = sz;
    8000109a:	e4ac                	sd	a1,72(s1)
  return 0;
    8000109c:	4501                	li	a0,0
}
    8000109e:	60e2                	ld	ra,24(sp)
    800010a0:	6442                	ld	s0,16(sp)
    800010a2:	64a2                	ld	s1,8(sp)
    800010a4:	6902                	ld	s2,0(sp)
    800010a6:	6105                	addi	sp,sp,32
    800010a8:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    800010aa:	4691                	li	a3,4
    800010ac:	00b90633          	add	a2,s2,a1
    800010b0:	6928                	ld	a0,80(a0)
    800010b2:	e82ff0ef          	jal	80000734 <uvmalloc>
    800010b6:	85aa                	mv	a1,a0
    800010b8:	f16d                	bnez	a0,8000109a <growproc+0x1e>
      return -1;
    800010ba:	557d                	li	a0,-1
    800010bc:	b7cd                	j	8000109e <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800010be:	00b90633          	add	a2,s2,a1
    800010c2:	6928                	ld	a0,80(a0)
    800010c4:	e2cff0ef          	jal	800006f0 <uvmdealloc>
    800010c8:	85aa                	mv	a1,a0
    800010ca:	bfc1                	j	8000109a <growproc+0x1e>

00000000800010cc <kfork>:
{
    800010cc:	7139                	addi	sp,sp,-64
    800010ce:	fc06                	sd	ra,56(sp)
    800010d0:	f822                	sd	s0,48(sp)
    800010d2:	f04a                	sd	s2,32(sp)
    800010d4:	e456                	sd	s5,8(sp)
    800010d6:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800010d8:	ca3ff0ef          	jal	80000d7a <myproc>
    800010dc:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800010de:	ebdff0ef          	jal	80000f9a <allocproc>
    800010e2:	0e050a63          	beqz	a0,800011d6 <kfork+0x10a>
    800010e6:	e852                	sd	s4,16(sp)
    800010e8:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800010ea:	048ab603          	ld	a2,72(s5)
    800010ee:	692c                	ld	a1,80(a0)
    800010f0:	050ab503          	ld	a0,80(s5)
    800010f4:	f78ff0ef          	jal	8000086c <uvmcopy>
    800010f8:	04054a63          	bltz	a0,8000114c <kfork+0x80>
    800010fc:	f426                	sd	s1,40(sp)
    800010fe:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001100:	048ab783          	ld	a5,72(s5)
    80001104:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001108:	058ab683          	ld	a3,88(s5)
    8000110c:	87b6                	mv	a5,a3
    8000110e:	058a3703          	ld	a4,88(s4)
    80001112:	12068693          	addi	a3,a3,288
    80001116:	0007b803          	ld	a6,0(a5)
    8000111a:	6788                	ld	a0,8(a5)
    8000111c:	6b8c                	ld	a1,16(a5)
    8000111e:	6f90                	ld	a2,24(a5)
    80001120:	01073023          	sd	a6,0(a4) # 1000 <_entry-0x7ffff000>
    80001124:	e708                	sd	a0,8(a4)
    80001126:	eb0c                	sd	a1,16(a4)
    80001128:	ef10                	sd	a2,24(a4)
    8000112a:	02078793          	addi	a5,a5,32
    8000112e:	02070713          	addi	a4,a4,32
    80001132:	fed792e3          	bne	a5,a3,80001116 <kfork+0x4a>
  np->trapframe->a0 = 0;
    80001136:	058a3783          	ld	a5,88(s4)
    8000113a:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    8000113e:	0d0a8493          	addi	s1,s5,208
    80001142:	0d0a0913          	addi	s2,s4,208
    80001146:	150a8993          	addi	s3,s5,336
    8000114a:	a831                	j	80001166 <kfork+0x9a>
    freeproc(np);
    8000114c:	8552                	mv	a0,s4
    8000114e:	dfdff0ef          	jal	80000f4a <freeproc>
    release(&np->lock);
    80001152:	8552                	mv	a0,s4
    80001154:	00f040ef          	jal	80005962 <release>
    return -1;
    80001158:	597d                	li	s2,-1
    8000115a:	6a42                	ld	s4,16(sp)
    8000115c:	a0b5                	j	800011c8 <kfork+0xfc>
  for(i = 0; i < NOFILE; i++)
    8000115e:	04a1                	addi	s1,s1,8
    80001160:	0921                	addi	s2,s2,8
    80001162:	01348963          	beq	s1,s3,80001174 <kfork+0xa8>
    if(p->ofile[i])
    80001166:	6088                	ld	a0,0(s1)
    80001168:	d97d                	beqz	a0,8000115e <kfork+0x92>
      np->ofile[i] = filedup(p->ofile[i]);
    8000116a:	316020ef          	jal	80003480 <filedup>
    8000116e:	00a93023          	sd	a0,0(s2)
    80001172:	b7f5                	j	8000115e <kfork+0x92>
  np->cwd = idup(p->cwd);
    80001174:	150ab503          	ld	a0,336(s5)
    80001178:	522010ef          	jal	8000269a <idup>
    8000117c:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001180:	4641                	li	a2,16
    80001182:	158a8593          	addi	a1,s5,344
    80001186:	158a0513          	addi	a0,s4,344
    8000118a:	902ff0ef          	jal	8000028c <safestrcpy>
  pid = np->pid;
    8000118e:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001192:	8552                	mv	a0,s4
    80001194:	7ce040ef          	jal	80005962 <release>
  acquire(&wait_lock);
    80001198:	00009497          	auipc	s1,0x9
    8000119c:	09048493          	addi	s1,s1,144 # 8000a228 <wait_lock>
    800011a0:	8526                	mv	a0,s1
    800011a2:	728040ef          	jal	800058ca <acquire>
  np->parent = p;
    800011a6:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    800011aa:	8526                	mv	a0,s1
    800011ac:	7b6040ef          	jal	80005962 <release>
  acquire(&np->lock);
    800011b0:	8552                	mv	a0,s4
    800011b2:	718040ef          	jal	800058ca <acquire>
  np->state = RUNNABLE;
    800011b6:	478d                	li	a5,3
    800011b8:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800011bc:	8552                	mv	a0,s4
    800011be:	7a4040ef          	jal	80005962 <release>
  return pid;
    800011c2:	74a2                	ld	s1,40(sp)
    800011c4:	69e2                	ld	s3,24(sp)
    800011c6:	6a42                	ld	s4,16(sp)
}
    800011c8:	854a                	mv	a0,s2
    800011ca:	70e2                	ld	ra,56(sp)
    800011cc:	7442                	ld	s0,48(sp)
    800011ce:	7902                	ld	s2,32(sp)
    800011d0:	6aa2                	ld	s5,8(sp)
    800011d2:	6121                	addi	sp,sp,64
    800011d4:	8082                	ret
    return -1;
    800011d6:	597d                	li	s2,-1
    800011d8:	bfc5                	j	800011c8 <kfork+0xfc>

00000000800011da <scheduler>:
{
    800011da:	715d                	addi	sp,sp,-80
    800011dc:	e486                	sd	ra,72(sp)
    800011de:	e0a2                	sd	s0,64(sp)
    800011e0:	fc26                	sd	s1,56(sp)
    800011e2:	f84a                	sd	s2,48(sp)
    800011e4:	f44e                	sd	s3,40(sp)
    800011e6:	f052                	sd	s4,32(sp)
    800011e8:	ec56                	sd	s5,24(sp)
    800011ea:	e85a                	sd	s6,16(sp)
    800011ec:	e45e                	sd	s7,8(sp)
    800011ee:	e062                	sd	s8,0(sp)
    800011f0:	0880                	addi	s0,sp,80
    800011f2:	8792                	mv	a5,tp
  int id = r_tp();
    800011f4:	2781                	sext.w	a5,a5
  c->proc = 0;
    800011f6:	00779b13          	slli	s6,a5,0x7
    800011fa:	00009717          	auipc	a4,0x9
    800011fe:	01670713          	addi	a4,a4,22 # 8000a210 <pid_lock>
    80001202:	975a                	add	a4,a4,s6
    80001204:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001208:	00009717          	auipc	a4,0x9
    8000120c:	04070713          	addi	a4,a4,64 # 8000a248 <cpus+0x8>
    80001210:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80001212:	4c11                	li	s8,4
        c->proc = p;
    80001214:	079e                	slli	a5,a5,0x7
    80001216:	00009a17          	auipc	s4,0x9
    8000121a:	ffaa0a13          	addi	s4,s4,-6 # 8000a210 <pid_lock>
    8000121e:	9a3e                	add	s4,s4,a5
        found = 1;
    80001220:	4b85                	li	s7,1
    for(p = proc; p < &proc[NPROC]; p++) {
    80001222:	0000f997          	auipc	s3,0xf
    80001226:	e1e98993          	addi	s3,s3,-482 # 80010040 <tickslock>
    8000122a:	a83d                	j	80001268 <scheduler+0x8e>
      release(&p->lock);
    8000122c:	8526                	mv	a0,s1
    8000122e:	734040ef          	jal	80005962 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001232:	16848493          	addi	s1,s1,360
    80001236:	03348563          	beq	s1,s3,80001260 <scheduler+0x86>
      acquire(&p->lock);
    8000123a:	8526                	mv	a0,s1
    8000123c:	68e040ef          	jal	800058ca <acquire>
      if(p->state == RUNNABLE) {
    80001240:	4c9c                	lw	a5,24(s1)
    80001242:	ff2795e3          	bne	a5,s2,8000122c <scheduler+0x52>
        p->state = RUNNING;
    80001246:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    8000124a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000124e:	06048593          	addi	a1,s1,96
    80001252:	855a                	mv	a0,s6
    80001254:	5b2000ef          	jal	80001806 <swtch>
        c->proc = 0;
    80001258:	020a3823          	sd	zero,48(s4)
        found = 1;
    8000125c:	8ade                	mv	s5,s7
    8000125e:	b7f9                	j	8000122c <scheduler+0x52>
    if(found == 0) {
    80001260:	000a9463          	bnez	s5,80001268 <scheduler+0x8e>
      asm volatile("wfi");
    80001264:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001268:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000126c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001270:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001274:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001278:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000127a:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000127e:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    80001280:	00009497          	auipc	s1,0x9
    80001284:	3c048493          	addi	s1,s1,960 # 8000a640 <proc>
      if(p->state == RUNNABLE) {
    80001288:	490d                	li	s2,3
    8000128a:	bf45                	j	8000123a <scheduler+0x60>

000000008000128c <sched>:
{
    8000128c:	7179                	addi	sp,sp,-48
    8000128e:	f406                	sd	ra,40(sp)
    80001290:	f022                	sd	s0,32(sp)
    80001292:	ec26                	sd	s1,24(sp)
    80001294:	e84a                	sd	s2,16(sp)
    80001296:	e44e                	sd	s3,8(sp)
    80001298:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000129a:	ae1ff0ef          	jal	80000d7a <myproc>
    8000129e:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800012a0:	5c0040ef          	jal	80005860 <holding>
    800012a4:	c92d                	beqz	a0,80001316 <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012a6:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800012a8:	2781                	sext.w	a5,a5
    800012aa:	079e                	slli	a5,a5,0x7
    800012ac:	00009717          	auipc	a4,0x9
    800012b0:	f6470713          	addi	a4,a4,-156 # 8000a210 <pid_lock>
    800012b4:	97ba                	add	a5,a5,a4
    800012b6:	0a87a703          	lw	a4,168(a5)
    800012ba:	4785                	li	a5,1
    800012bc:	06f71363          	bne	a4,a5,80001322 <sched+0x96>
  if(p->state == RUNNING)
    800012c0:	4c98                	lw	a4,24(s1)
    800012c2:	4791                	li	a5,4
    800012c4:	06f70563          	beq	a4,a5,8000132e <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012c8:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800012cc:	8b89                	andi	a5,a5,2
  if(intr_get())
    800012ce:	e7b5                	bnez	a5,8000133a <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012d0:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800012d2:	00009917          	auipc	s2,0x9
    800012d6:	f3e90913          	addi	s2,s2,-194 # 8000a210 <pid_lock>
    800012da:	2781                	sext.w	a5,a5
    800012dc:	079e                	slli	a5,a5,0x7
    800012de:	97ca                	add	a5,a5,s2
    800012e0:	0ac7a983          	lw	s3,172(a5)
    800012e4:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800012e6:	2781                	sext.w	a5,a5
    800012e8:	079e                	slli	a5,a5,0x7
    800012ea:	00009597          	auipc	a1,0x9
    800012ee:	f5e58593          	addi	a1,a1,-162 # 8000a248 <cpus+0x8>
    800012f2:	95be                	add	a1,a1,a5
    800012f4:	06048513          	addi	a0,s1,96
    800012f8:	50e000ef          	jal	80001806 <swtch>
    800012fc:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800012fe:	2781                	sext.w	a5,a5
    80001300:	079e                	slli	a5,a5,0x7
    80001302:	993e                	add	s2,s2,a5
    80001304:	0b392623          	sw	s3,172(s2)
}
    80001308:	70a2                	ld	ra,40(sp)
    8000130a:	7402                	ld	s0,32(sp)
    8000130c:	64e2                	ld	s1,24(sp)
    8000130e:	6942                	ld	s2,16(sp)
    80001310:	69a2                	ld	s3,8(sp)
    80001312:	6145                	addi	sp,sp,48
    80001314:	8082                	ret
    panic("sched p->lock");
    80001316:	00006517          	auipc	a0,0x6
    8000131a:	e2250513          	addi	a0,a0,-478 # 80007138 <etext+0x138>
    8000131e:	2f0040ef          	jal	8000560e <panic>
    panic("sched locks");
    80001322:	00006517          	auipc	a0,0x6
    80001326:	e2650513          	addi	a0,a0,-474 # 80007148 <etext+0x148>
    8000132a:	2e4040ef          	jal	8000560e <panic>
    panic("sched RUNNING");
    8000132e:	00006517          	auipc	a0,0x6
    80001332:	e2a50513          	addi	a0,a0,-470 # 80007158 <etext+0x158>
    80001336:	2d8040ef          	jal	8000560e <panic>
    panic("sched interruptible");
    8000133a:	00006517          	auipc	a0,0x6
    8000133e:	e2e50513          	addi	a0,a0,-466 # 80007168 <etext+0x168>
    80001342:	2cc040ef          	jal	8000560e <panic>

0000000080001346 <yield>:
{
    80001346:	1101                	addi	sp,sp,-32
    80001348:	ec06                	sd	ra,24(sp)
    8000134a:	e822                	sd	s0,16(sp)
    8000134c:	e426                	sd	s1,8(sp)
    8000134e:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001350:	a2bff0ef          	jal	80000d7a <myproc>
    80001354:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001356:	574040ef          	jal	800058ca <acquire>
  p->state = RUNNABLE;
    8000135a:	478d                	li	a5,3
    8000135c:	cc9c                	sw	a5,24(s1)
  sched();
    8000135e:	f2fff0ef          	jal	8000128c <sched>
  release(&p->lock);
    80001362:	8526                	mv	a0,s1
    80001364:	5fe040ef          	jal	80005962 <release>
}
    80001368:	60e2                	ld	ra,24(sp)
    8000136a:	6442                	ld	s0,16(sp)
    8000136c:	64a2                	ld	s1,8(sp)
    8000136e:	6105                	addi	sp,sp,32
    80001370:	8082                	ret

0000000080001372 <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001372:	7179                	addi	sp,sp,-48
    80001374:	f406                	sd	ra,40(sp)
    80001376:	f022                	sd	s0,32(sp)
    80001378:	ec26                	sd	s1,24(sp)
    8000137a:	e84a                	sd	s2,16(sp)
    8000137c:	e44e                	sd	s3,8(sp)
    8000137e:	1800                	addi	s0,sp,48
    80001380:	89aa                	mv	s3,a0
    80001382:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001384:	9f7ff0ef          	jal	80000d7a <myproc>
    80001388:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000138a:	540040ef          	jal	800058ca <acquire>
  release(lk);
    8000138e:	854a                	mv	a0,s2
    80001390:	5d2040ef          	jal	80005962 <release>

  // Go to sleep.
  p->chan = chan;
    80001394:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001398:	4789                	li	a5,2
    8000139a:	cc9c                	sw	a5,24(s1)

  sched();
    8000139c:	ef1ff0ef          	jal	8000128c <sched>

  // Tidy up.
  p->chan = 0;
    800013a0:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800013a4:	8526                	mv	a0,s1
    800013a6:	5bc040ef          	jal	80005962 <release>
  acquire(lk);
    800013aa:	854a                	mv	a0,s2
    800013ac:	51e040ef          	jal	800058ca <acquire>
}
    800013b0:	70a2                	ld	ra,40(sp)
    800013b2:	7402                	ld	s0,32(sp)
    800013b4:	64e2                	ld	s1,24(sp)
    800013b6:	6942                	ld	s2,16(sp)
    800013b8:	69a2                	ld	s3,8(sp)
    800013ba:	6145                	addi	sp,sp,48
    800013bc:	8082                	ret

00000000800013be <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    800013be:	7139                	addi	sp,sp,-64
    800013c0:	fc06                	sd	ra,56(sp)
    800013c2:	f822                	sd	s0,48(sp)
    800013c4:	f426                	sd	s1,40(sp)
    800013c6:	f04a                	sd	s2,32(sp)
    800013c8:	ec4e                	sd	s3,24(sp)
    800013ca:	e852                	sd	s4,16(sp)
    800013cc:	e456                	sd	s5,8(sp)
    800013ce:	0080                	addi	s0,sp,64
    800013d0:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800013d2:	00009497          	auipc	s1,0x9
    800013d6:	26e48493          	addi	s1,s1,622 # 8000a640 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800013da:	4989                	li	s3,2
        p->state = RUNNABLE;
    800013dc:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800013de:	0000f917          	auipc	s2,0xf
    800013e2:	c6290913          	addi	s2,s2,-926 # 80010040 <tickslock>
    800013e6:	a801                	j	800013f6 <wakeup+0x38>
      }
      release(&p->lock);
    800013e8:	8526                	mv	a0,s1
    800013ea:	578040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800013ee:	16848493          	addi	s1,s1,360
    800013f2:	03248263          	beq	s1,s2,80001416 <wakeup+0x58>
    if(p != myproc()){
    800013f6:	985ff0ef          	jal	80000d7a <myproc>
    800013fa:	fea48ae3          	beq	s1,a0,800013ee <wakeup+0x30>
      acquire(&p->lock);
    800013fe:	8526                	mv	a0,s1
    80001400:	4ca040ef          	jal	800058ca <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001404:	4c9c                	lw	a5,24(s1)
    80001406:	ff3791e3          	bne	a5,s3,800013e8 <wakeup+0x2a>
    8000140a:	709c                	ld	a5,32(s1)
    8000140c:	fd479ee3          	bne	a5,s4,800013e8 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001410:	0154ac23          	sw	s5,24(s1)
    80001414:	bfd1                	j	800013e8 <wakeup+0x2a>
    }
  }
}
    80001416:	70e2                	ld	ra,56(sp)
    80001418:	7442                	ld	s0,48(sp)
    8000141a:	74a2                	ld	s1,40(sp)
    8000141c:	7902                	ld	s2,32(sp)
    8000141e:	69e2                	ld	s3,24(sp)
    80001420:	6a42                	ld	s4,16(sp)
    80001422:	6aa2                	ld	s5,8(sp)
    80001424:	6121                	addi	sp,sp,64
    80001426:	8082                	ret

0000000080001428 <reparent>:
{
    80001428:	7179                	addi	sp,sp,-48
    8000142a:	f406                	sd	ra,40(sp)
    8000142c:	f022                	sd	s0,32(sp)
    8000142e:	ec26                	sd	s1,24(sp)
    80001430:	e84a                	sd	s2,16(sp)
    80001432:	e44e                	sd	s3,8(sp)
    80001434:	e052                	sd	s4,0(sp)
    80001436:	1800                	addi	s0,sp,48
    80001438:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000143a:	00009497          	auipc	s1,0x9
    8000143e:	20648493          	addi	s1,s1,518 # 8000a640 <proc>
      pp->parent = initproc;
    80001442:	00009a17          	auipc	s4,0x9
    80001446:	d8ea0a13          	addi	s4,s4,-626 # 8000a1d0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000144a:	0000f997          	auipc	s3,0xf
    8000144e:	bf698993          	addi	s3,s3,-1034 # 80010040 <tickslock>
    80001452:	a029                	j	8000145c <reparent+0x34>
    80001454:	16848493          	addi	s1,s1,360
    80001458:	01348b63          	beq	s1,s3,8000146e <reparent+0x46>
    if(pp->parent == p){
    8000145c:	7c9c                	ld	a5,56(s1)
    8000145e:	ff279be3          	bne	a5,s2,80001454 <reparent+0x2c>
      pp->parent = initproc;
    80001462:	000a3503          	ld	a0,0(s4)
    80001466:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001468:	f57ff0ef          	jal	800013be <wakeup>
    8000146c:	b7e5                	j	80001454 <reparent+0x2c>
}
    8000146e:	70a2                	ld	ra,40(sp)
    80001470:	7402                	ld	s0,32(sp)
    80001472:	64e2                	ld	s1,24(sp)
    80001474:	6942                	ld	s2,16(sp)
    80001476:	69a2                	ld	s3,8(sp)
    80001478:	6a02                	ld	s4,0(sp)
    8000147a:	6145                	addi	sp,sp,48
    8000147c:	8082                	ret

000000008000147e <kexit>:
{
    8000147e:	7179                	addi	sp,sp,-48
    80001480:	f406                	sd	ra,40(sp)
    80001482:	f022                	sd	s0,32(sp)
    80001484:	ec26                	sd	s1,24(sp)
    80001486:	e84a                	sd	s2,16(sp)
    80001488:	e44e                	sd	s3,8(sp)
    8000148a:	e052                	sd	s4,0(sp)
    8000148c:	1800                	addi	s0,sp,48
    8000148e:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001490:	8ebff0ef          	jal	80000d7a <myproc>
    80001494:	89aa                	mv	s3,a0
  if(p == initproc)
    80001496:	00009797          	auipc	a5,0x9
    8000149a:	d3a7b783          	ld	a5,-710(a5) # 8000a1d0 <initproc>
    8000149e:	0d050493          	addi	s1,a0,208
    800014a2:	15050913          	addi	s2,a0,336
    800014a6:	00a79f63          	bne	a5,a0,800014c4 <kexit+0x46>
    panic("init exiting");
    800014aa:	00006517          	auipc	a0,0x6
    800014ae:	cd650513          	addi	a0,a0,-810 # 80007180 <etext+0x180>
    800014b2:	15c040ef          	jal	8000560e <panic>
      fileclose(f);
    800014b6:	010020ef          	jal	800034c6 <fileclose>
      p->ofile[fd] = 0;
    800014ba:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800014be:	04a1                	addi	s1,s1,8
    800014c0:	01248563          	beq	s1,s2,800014ca <kexit+0x4c>
    if(p->ofile[fd]){
    800014c4:	6088                	ld	a0,0(s1)
    800014c6:	f965                	bnez	a0,800014b6 <kexit+0x38>
    800014c8:	bfdd                	j	800014be <kexit+0x40>
  begin_op();
    800014ca:	3f1010ef          	jal	800030ba <begin_op>
  iput(p->cwd);
    800014ce:	1509b503          	ld	a0,336(s3)
    800014d2:	380010ef          	jal	80002852 <iput>
  end_op();
    800014d6:	44f010ef          	jal	80003124 <end_op>
  p->cwd = 0;
    800014da:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800014de:	00009497          	auipc	s1,0x9
    800014e2:	d4a48493          	addi	s1,s1,-694 # 8000a228 <wait_lock>
    800014e6:	8526                	mv	a0,s1
    800014e8:	3e2040ef          	jal	800058ca <acquire>
  reparent(p);
    800014ec:	854e                	mv	a0,s3
    800014ee:	f3bff0ef          	jal	80001428 <reparent>
  wakeup(p->parent);
    800014f2:	0389b503          	ld	a0,56(s3)
    800014f6:	ec9ff0ef          	jal	800013be <wakeup>
  acquire(&p->lock);
    800014fa:	854e                	mv	a0,s3
    800014fc:	3ce040ef          	jal	800058ca <acquire>
  p->xstate = status;
    80001500:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001504:	4795                	li	a5,5
    80001506:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000150a:	8526                	mv	a0,s1
    8000150c:	456040ef          	jal	80005962 <release>
  sched();
    80001510:	d7dff0ef          	jal	8000128c <sched>
  panic("zombie exit");
    80001514:	00006517          	auipc	a0,0x6
    80001518:	c7c50513          	addi	a0,a0,-900 # 80007190 <etext+0x190>
    8000151c:	0f2040ef          	jal	8000560e <panic>

0000000080001520 <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    80001520:	7179                	addi	sp,sp,-48
    80001522:	f406                	sd	ra,40(sp)
    80001524:	f022                	sd	s0,32(sp)
    80001526:	ec26                	sd	s1,24(sp)
    80001528:	e84a                	sd	s2,16(sp)
    8000152a:	e44e                	sd	s3,8(sp)
    8000152c:	1800                	addi	s0,sp,48
    8000152e:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001530:	00009497          	auipc	s1,0x9
    80001534:	11048493          	addi	s1,s1,272 # 8000a640 <proc>
    80001538:	0000f997          	auipc	s3,0xf
    8000153c:	b0898993          	addi	s3,s3,-1272 # 80010040 <tickslock>
    acquire(&p->lock);
    80001540:	8526                	mv	a0,s1
    80001542:	388040ef          	jal	800058ca <acquire>
    if(p->pid == pid){
    80001546:	589c                	lw	a5,48(s1)
    80001548:	01278b63          	beq	a5,s2,8000155e <kkill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000154c:	8526                	mv	a0,s1
    8000154e:	414040ef          	jal	80005962 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001552:	16848493          	addi	s1,s1,360
    80001556:	ff3495e3          	bne	s1,s3,80001540 <kkill+0x20>
  }
  return -1;
    8000155a:	557d                	li	a0,-1
    8000155c:	a819                	j	80001572 <kkill+0x52>
      p->killed = 1;
    8000155e:	4785                	li	a5,1
    80001560:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001562:	4c98                	lw	a4,24(s1)
    80001564:	4789                	li	a5,2
    80001566:	00f70d63          	beq	a4,a5,80001580 <kkill+0x60>
      release(&p->lock);
    8000156a:	8526                	mv	a0,s1
    8000156c:	3f6040ef          	jal	80005962 <release>
      return 0;
    80001570:	4501                	li	a0,0
}
    80001572:	70a2                	ld	ra,40(sp)
    80001574:	7402                	ld	s0,32(sp)
    80001576:	64e2                	ld	s1,24(sp)
    80001578:	6942                	ld	s2,16(sp)
    8000157a:	69a2                	ld	s3,8(sp)
    8000157c:	6145                	addi	sp,sp,48
    8000157e:	8082                	ret
        p->state = RUNNABLE;
    80001580:	478d                	li	a5,3
    80001582:	cc9c                	sw	a5,24(s1)
    80001584:	b7dd                	j	8000156a <kkill+0x4a>

0000000080001586 <setkilled>:

void
setkilled(struct proc *p)
{
    80001586:	1101                	addi	sp,sp,-32
    80001588:	ec06                	sd	ra,24(sp)
    8000158a:	e822                	sd	s0,16(sp)
    8000158c:	e426                	sd	s1,8(sp)
    8000158e:	1000                	addi	s0,sp,32
    80001590:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001592:	338040ef          	jal	800058ca <acquire>
  p->killed = 1;
    80001596:	4785                	li	a5,1
    80001598:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    8000159a:	8526                	mv	a0,s1
    8000159c:	3c6040ef          	jal	80005962 <release>
}
    800015a0:	60e2                	ld	ra,24(sp)
    800015a2:	6442                	ld	s0,16(sp)
    800015a4:	64a2                	ld	s1,8(sp)
    800015a6:	6105                	addi	sp,sp,32
    800015a8:	8082                	ret

00000000800015aa <killed>:

int
killed(struct proc *p)
{
    800015aa:	1101                	addi	sp,sp,-32
    800015ac:	ec06                	sd	ra,24(sp)
    800015ae:	e822                	sd	s0,16(sp)
    800015b0:	e426                	sd	s1,8(sp)
    800015b2:	e04a                	sd	s2,0(sp)
    800015b4:	1000                	addi	s0,sp,32
    800015b6:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    800015b8:	312040ef          	jal	800058ca <acquire>
  k = p->killed;
    800015bc:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    800015c0:	8526                	mv	a0,s1
    800015c2:	3a0040ef          	jal	80005962 <release>
  return k;
}
    800015c6:	854a                	mv	a0,s2
    800015c8:	60e2                	ld	ra,24(sp)
    800015ca:	6442                	ld	s0,16(sp)
    800015cc:	64a2                	ld	s1,8(sp)
    800015ce:	6902                	ld	s2,0(sp)
    800015d0:	6105                	addi	sp,sp,32
    800015d2:	8082                	ret

00000000800015d4 <kwait>:
{
    800015d4:	715d                	addi	sp,sp,-80
    800015d6:	e486                	sd	ra,72(sp)
    800015d8:	e0a2                	sd	s0,64(sp)
    800015da:	fc26                	sd	s1,56(sp)
    800015dc:	f84a                	sd	s2,48(sp)
    800015de:	f44e                	sd	s3,40(sp)
    800015e0:	f052                	sd	s4,32(sp)
    800015e2:	ec56                	sd	s5,24(sp)
    800015e4:	e85a                	sd	s6,16(sp)
    800015e6:	e45e                	sd	s7,8(sp)
    800015e8:	e062                	sd	s8,0(sp)
    800015ea:	0880                	addi	s0,sp,80
    800015ec:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800015ee:	f8cff0ef          	jal	80000d7a <myproc>
    800015f2:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800015f4:	00009517          	auipc	a0,0x9
    800015f8:	c3450513          	addi	a0,a0,-972 # 8000a228 <wait_lock>
    800015fc:	2ce040ef          	jal	800058ca <acquire>
    havekids = 0;
    80001600:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001602:	4a15                	li	s4,5
        havekids = 1;
    80001604:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001606:	0000f997          	auipc	s3,0xf
    8000160a:	a3a98993          	addi	s3,s3,-1478 # 80010040 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000160e:	00009c17          	auipc	s8,0x9
    80001612:	c1ac0c13          	addi	s8,s8,-998 # 8000a228 <wait_lock>
    80001616:	a871                	j	800016b2 <kwait+0xde>
          pid = pp->pid;
    80001618:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    8000161c:	000b0c63          	beqz	s6,80001634 <kwait+0x60>
    80001620:	4691                	li	a3,4
    80001622:	02c48613          	addi	a2,s1,44
    80001626:	85da                	mv	a1,s6
    80001628:	05093503          	ld	a0,80(s2)
    8000162c:	c62ff0ef          	jal	80000a8e <copyout>
    80001630:	02054b63          	bltz	a0,80001666 <kwait+0x92>
          freeproc(pp);
    80001634:	8526                	mv	a0,s1
    80001636:	915ff0ef          	jal	80000f4a <freeproc>
          release(&pp->lock);
    8000163a:	8526                	mv	a0,s1
    8000163c:	326040ef          	jal	80005962 <release>
          release(&wait_lock);
    80001640:	00009517          	auipc	a0,0x9
    80001644:	be850513          	addi	a0,a0,-1048 # 8000a228 <wait_lock>
    80001648:	31a040ef          	jal	80005962 <release>
}
    8000164c:	854e                	mv	a0,s3
    8000164e:	60a6                	ld	ra,72(sp)
    80001650:	6406                	ld	s0,64(sp)
    80001652:	74e2                	ld	s1,56(sp)
    80001654:	7942                	ld	s2,48(sp)
    80001656:	79a2                	ld	s3,40(sp)
    80001658:	7a02                	ld	s4,32(sp)
    8000165a:	6ae2                	ld	s5,24(sp)
    8000165c:	6b42                	ld	s6,16(sp)
    8000165e:	6ba2                	ld	s7,8(sp)
    80001660:	6c02                	ld	s8,0(sp)
    80001662:	6161                	addi	sp,sp,80
    80001664:	8082                	ret
            release(&pp->lock);
    80001666:	8526                	mv	a0,s1
    80001668:	2fa040ef          	jal	80005962 <release>
            release(&wait_lock);
    8000166c:	00009517          	auipc	a0,0x9
    80001670:	bbc50513          	addi	a0,a0,-1092 # 8000a228 <wait_lock>
    80001674:	2ee040ef          	jal	80005962 <release>
            return -1;
    80001678:	59fd                	li	s3,-1
    8000167a:	bfc9                	j	8000164c <kwait+0x78>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000167c:	16848493          	addi	s1,s1,360
    80001680:	03348063          	beq	s1,s3,800016a0 <kwait+0xcc>
      if(pp->parent == p){
    80001684:	7c9c                	ld	a5,56(s1)
    80001686:	ff279be3          	bne	a5,s2,8000167c <kwait+0xa8>
        acquire(&pp->lock);
    8000168a:	8526                	mv	a0,s1
    8000168c:	23e040ef          	jal	800058ca <acquire>
        if(pp->state == ZOMBIE){
    80001690:	4c9c                	lw	a5,24(s1)
    80001692:	f94783e3          	beq	a5,s4,80001618 <kwait+0x44>
        release(&pp->lock);
    80001696:	8526                	mv	a0,s1
    80001698:	2ca040ef          	jal	80005962 <release>
        havekids = 1;
    8000169c:	8756                	mv	a4,s5
    8000169e:	bff9                	j	8000167c <kwait+0xa8>
    if(!havekids || killed(p)){
    800016a0:	cf19                	beqz	a4,800016be <kwait+0xea>
    800016a2:	854a                	mv	a0,s2
    800016a4:	f07ff0ef          	jal	800015aa <killed>
    800016a8:	e919                	bnez	a0,800016be <kwait+0xea>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800016aa:	85e2                	mv	a1,s8
    800016ac:	854a                	mv	a0,s2
    800016ae:	cc5ff0ef          	jal	80001372 <sleep>
    havekids = 0;
    800016b2:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800016b4:	00009497          	auipc	s1,0x9
    800016b8:	f8c48493          	addi	s1,s1,-116 # 8000a640 <proc>
    800016bc:	b7e1                	j	80001684 <kwait+0xb0>
      release(&wait_lock);
    800016be:	00009517          	auipc	a0,0x9
    800016c2:	b6a50513          	addi	a0,a0,-1174 # 8000a228 <wait_lock>
    800016c6:	29c040ef          	jal	80005962 <release>
      return -1;
    800016ca:	59fd                	li	s3,-1
    800016cc:	b741                	j	8000164c <kwait+0x78>

00000000800016ce <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800016ce:	7179                	addi	sp,sp,-48
    800016d0:	f406                	sd	ra,40(sp)
    800016d2:	f022                	sd	s0,32(sp)
    800016d4:	ec26                	sd	s1,24(sp)
    800016d6:	e84a                	sd	s2,16(sp)
    800016d8:	e44e                	sd	s3,8(sp)
    800016da:	e052                	sd	s4,0(sp)
    800016dc:	1800                	addi	s0,sp,48
    800016de:	84aa                	mv	s1,a0
    800016e0:	892e                	mv	s2,a1
    800016e2:	89b2                	mv	s3,a2
    800016e4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800016e6:	e94ff0ef          	jal	80000d7a <myproc>
  if(user_dst){
    800016ea:	cc99                	beqz	s1,80001708 <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    800016ec:	86d2                	mv	a3,s4
    800016ee:	864e                	mv	a2,s3
    800016f0:	85ca                	mv	a1,s2
    800016f2:	6928                	ld	a0,80(a0)
    800016f4:	b9aff0ef          	jal	80000a8e <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800016f8:	70a2                	ld	ra,40(sp)
    800016fa:	7402                	ld	s0,32(sp)
    800016fc:	64e2                	ld	s1,24(sp)
    800016fe:	6942                	ld	s2,16(sp)
    80001700:	69a2                	ld	s3,8(sp)
    80001702:	6a02                	ld	s4,0(sp)
    80001704:	6145                	addi	sp,sp,48
    80001706:	8082                	ret
    memmove((char *)dst, src, len);
    80001708:	000a061b          	sext.w	a2,s4
    8000170c:	85ce                	mv	a1,s3
    8000170e:	854a                	mv	a0,s2
    80001710:	a9bfe0ef          	jal	800001aa <memmove>
    return 0;
    80001714:	8526                	mv	a0,s1
    80001716:	b7cd                	j	800016f8 <either_copyout+0x2a>

0000000080001718 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001718:	7179                	addi	sp,sp,-48
    8000171a:	f406                	sd	ra,40(sp)
    8000171c:	f022                	sd	s0,32(sp)
    8000171e:	ec26                	sd	s1,24(sp)
    80001720:	e84a                	sd	s2,16(sp)
    80001722:	e44e                	sd	s3,8(sp)
    80001724:	e052                	sd	s4,0(sp)
    80001726:	1800                	addi	s0,sp,48
    80001728:	892a                	mv	s2,a0
    8000172a:	84ae                	mv	s1,a1
    8000172c:	89b2                	mv	s3,a2
    8000172e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001730:	e4aff0ef          	jal	80000d7a <myproc>
  if(user_src){
    80001734:	cc99                	beqz	s1,80001752 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    80001736:	86d2                	mv	a3,s4
    80001738:	864e                	mv	a2,s3
    8000173a:	85ca                	mv	a1,s2
    8000173c:	6928                	ld	a0,80(a0)
    8000173e:	c34ff0ef          	jal	80000b72 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001742:	70a2                	ld	ra,40(sp)
    80001744:	7402                	ld	s0,32(sp)
    80001746:	64e2                	ld	s1,24(sp)
    80001748:	6942                	ld	s2,16(sp)
    8000174a:	69a2                	ld	s3,8(sp)
    8000174c:	6a02                	ld	s4,0(sp)
    8000174e:	6145                	addi	sp,sp,48
    80001750:	8082                	ret
    memmove(dst, (char*)src, len);
    80001752:	000a061b          	sext.w	a2,s4
    80001756:	85ce                	mv	a1,s3
    80001758:	854a                	mv	a0,s2
    8000175a:	a51fe0ef          	jal	800001aa <memmove>
    return 0;
    8000175e:	8526                	mv	a0,s1
    80001760:	b7cd                	j	80001742 <either_copyin+0x2a>

0000000080001762 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001762:	715d                	addi	sp,sp,-80
    80001764:	e486                	sd	ra,72(sp)
    80001766:	e0a2                	sd	s0,64(sp)
    80001768:	fc26                	sd	s1,56(sp)
    8000176a:	f84a                	sd	s2,48(sp)
    8000176c:	f44e                	sd	s3,40(sp)
    8000176e:	f052                	sd	s4,32(sp)
    80001770:	ec56                	sd	s5,24(sp)
    80001772:	e85a                	sd	s6,16(sp)
    80001774:	e45e                	sd	s7,8(sp)
    80001776:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001778:	00006517          	auipc	a0,0x6
    8000177c:	8a050513          	addi	a0,a0,-1888 # 80007018 <etext+0x18>
    80001780:	3a9030ef          	jal	80005328 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001784:	00009497          	auipc	s1,0x9
    80001788:	01448493          	addi	s1,s1,20 # 8000a798 <proc+0x158>
    8000178c:	0000f917          	auipc	s2,0xf
    80001790:	a0c90913          	addi	s2,s2,-1524 # 80010198 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001794:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001796:	00006997          	auipc	s3,0x6
    8000179a:	a0a98993          	addi	s3,s3,-1526 # 800071a0 <etext+0x1a0>
    printf("%d %s %s", p->pid, state, p->name);
    8000179e:	00006a97          	auipc	s5,0x6
    800017a2:	a0aa8a93          	addi	s5,s5,-1526 # 800071a8 <etext+0x1a8>
    printf("\n");
    800017a6:	00006a17          	auipc	s4,0x6
    800017aa:	872a0a13          	addi	s4,s4,-1934 # 80007018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800017ae:	00006b97          	auipc	s7,0x6
    800017b2:	f82b8b93          	addi	s7,s7,-126 # 80007730 <states.0>
    800017b6:	a829                	j	800017d0 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    800017b8:	ed86a583          	lw	a1,-296(a3)
    800017bc:	8556                	mv	a0,s5
    800017be:	36b030ef          	jal	80005328 <printf>
    printf("\n");
    800017c2:	8552                	mv	a0,s4
    800017c4:	365030ef          	jal	80005328 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800017c8:	16848493          	addi	s1,s1,360
    800017cc:	03248263          	beq	s1,s2,800017f0 <procdump+0x8e>
    if(p->state == UNUSED)
    800017d0:	86a6                	mv	a3,s1
    800017d2:	ec04a783          	lw	a5,-320(s1)
    800017d6:	dbed                	beqz	a5,800017c8 <procdump+0x66>
      state = "???";
    800017d8:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800017da:	fcfb6fe3          	bltu	s6,a5,800017b8 <procdump+0x56>
    800017de:	02079713          	slli	a4,a5,0x20
    800017e2:	01d75793          	srli	a5,a4,0x1d
    800017e6:	97de                	add	a5,a5,s7
    800017e8:	6390                	ld	a2,0(a5)
    800017ea:	f679                	bnez	a2,800017b8 <procdump+0x56>
      state = "???";
    800017ec:	864e                	mv	a2,s3
    800017ee:	b7e9                	j	800017b8 <procdump+0x56>
  }
}
    800017f0:	60a6                	ld	ra,72(sp)
    800017f2:	6406                	ld	s0,64(sp)
    800017f4:	74e2                	ld	s1,56(sp)
    800017f6:	7942                	ld	s2,48(sp)
    800017f8:	79a2                	ld	s3,40(sp)
    800017fa:	7a02                	ld	s4,32(sp)
    800017fc:	6ae2                	ld	s5,24(sp)
    800017fe:	6b42                	ld	s6,16(sp)
    80001800:	6ba2                	ld	s7,8(sp)
    80001802:	6161                	addi	sp,sp,80
    80001804:	8082                	ret

0000000080001806 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    80001806:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    8000180a:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    8000180e:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    80001810:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    80001812:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    80001816:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    8000181a:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    8000181e:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    80001822:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    80001826:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    8000182a:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    8000182e:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    80001832:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    80001836:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    8000183a:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    8000183e:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    80001842:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80001844:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    80001846:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    8000184a:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    8000184e:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    80001852:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    80001856:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    8000185a:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    8000185e:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    80001862:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    80001866:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    8000186a:	0685bd83          	ld	s11,104(a1)
        
        ret
    8000186e:	8082                	ret

0000000080001870 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001870:	1141                	addi	sp,sp,-16
    80001872:	e406                	sd	ra,8(sp)
    80001874:	e022                	sd	s0,0(sp)
    80001876:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001878:	00006597          	auipc	a1,0x6
    8000187c:	97058593          	addi	a1,a1,-1680 # 800071e8 <etext+0x1e8>
    80001880:	0000e517          	auipc	a0,0xe
    80001884:	7c050513          	addi	a0,a0,1984 # 80010040 <tickslock>
    80001888:	7c3030ef          	jal	8000584a <initlock>
}
    8000188c:	60a2                	ld	ra,8(sp)
    8000188e:	6402                	ld	s0,0(sp)
    80001890:	0141                	addi	sp,sp,16
    80001892:	8082                	ret

0000000080001894 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001894:	1141                	addi	sp,sp,-16
    80001896:	e422                	sd	s0,8(sp)
    80001898:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000189a:	00003797          	auipc	a5,0x3
    8000189e:	f9678793          	addi	a5,a5,-106 # 80004830 <kernelvec>
    800018a2:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    800018a6:	6422                	ld	s0,8(sp)
    800018a8:	0141                	addi	sp,sp,16
    800018aa:	8082                	ret

00000000800018ac <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    800018ac:	1141                	addi	sp,sp,-16
    800018ae:	e406                	sd	ra,8(sp)
    800018b0:	e022                	sd	s0,0(sp)
    800018b2:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800018b4:	cc6ff0ef          	jal	80000d7a <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018b8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800018bc:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018be:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800018c2:	04000737          	lui	a4,0x4000
    800018c6:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    800018c8:	0732                	slli	a4,a4,0xc
    800018ca:	00004797          	auipc	a5,0x4
    800018ce:	73678793          	addi	a5,a5,1846 # 80006000 <_trampoline>
    800018d2:	00004697          	auipc	a3,0x4
    800018d6:	72e68693          	addi	a3,a3,1838 # 80006000 <_trampoline>
    800018da:	8f95                	sub	a5,a5,a3
    800018dc:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r" (x));
    800018de:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800018e2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800018e4:	18002773          	csrr	a4,satp
    800018e8:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800018ea:	6d38                	ld	a4,88(a0)
    800018ec:	613c                	ld	a5,64(a0)
    800018ee:	6685                	lui	a3,0x1
    800018f0:	97b6                	add	a5,a5,a3
    800018f2:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800018f4:	6d3c                	ld	a5,88(a0)
    800018f6:	00000717          	auipc	a4,0x0
    800018fa:	0f870713          	addi	a4,a4,248 # 800019ee <usertrap>
    800018fe:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001900:	6d3c                	ld	a5,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001902:	8712                	mv	a4,tp
    80001904:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001906:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    8000190a:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    8000190e:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001912:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001916:	6d3c                	ld	a5,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001918:	6f9c                	ld	a5,24(a5)
    8000191a:	14179073          	csrw	sepc,a5
}
    8000191e:	60a2                	ld	ra,8(sp)
    80001920:	6402                	ld	s0,0(sp)
    80001922:	0141                	addi	sp,sp,16
    80001924:	8082                	ret

0000000080001926 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001926:	1101                	addi	sp,sp,-32
    80001928:	ec06                	sd	ra,24(sp)
    8000192a:	e822                	sd	s0,16(sp)
    8000192c:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    8000192e:	c20ff0ef          	jal	80000d4e <cpuid>
    80001932:	cd11                	beqz	a0,8000194e <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001934:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    80001938:	000f4737          	lui	a4,0xf4
    8000193c:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001940:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001942:	14d79073          	csrw	stimecmp,a5
}
    80001946:	60e2                	ld	ra,24(sp)
    80001948:	6442                	ld	s0,16(sp)
    8000194a:	6105                	addi	sp,sp,32
    8000194c:	8082                	ret
    8000194e:	e426                	sd	s1,8(sp)
    acquire(&tickslock);
    80001950:	0000e497          	auipc	s1,0xe
    80001954:	6f048493          	addi	s1,s1,1776 # 80010040 <tickslock>
    80001958:	8526                	mv	a0,s1
    8000195a:	771030ef          	jal	800058ca <acquire>
    ticks++;
    8000195e:	00009517          	auipc	a0,0x9
    80001962:	87a50513          	addi	a0,a0,-1926 # 8000a1d8 <ticks>
    80001966:	411c                	lw	a5,0(a0)
    80001968:	2785                	addiw	a5,a5,1
    8000196a:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    8000196c:	a53ff0ef          	jal	800013be <wakeup>
    release(&tickslock);
    80001970:	8526                	mv	a0,s1
    80001972:	7f1030ef          	jal	80005962 <release>
    80001976:	64a2                	ld	s1,8(sp)
    80001978:	bf75                	j	80001934 <clockintr+0xe>

000000008000197a <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000197a:	1101                	addi	sp,sp,-32
    8000197c:	ec06                	sd	ra,24(sp)
    8000197e:	e822                	sd	s0,16(sp)
    80001980:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001982:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    80001986:	57fd                	li	a5,-1
    80001988:	17fe                	slli	a5,a5,0x3f
    8000198a:	07a5                	addi	a5,a5,9
    8000198c:	00f70c63          	beq	a4,a5,800019a4 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001990:	57fd                	li	a5,-1
    80001992:	17fe                	slli	a5,a5,0x3f
    80001994:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    80001996:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    80001998:	04f70763          	beq	a4,a5,800019e6 <devintr+0x6c>
  }
}
    8000199c:	60e2                	ld	ra,24(sp)
    8000199e:	6442                	ld	s0,16(sp)
    800019a0:	6105                	addi	sp,sp,32
    800019a2:	8082                	ret
    800019a4:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    800019a6:	737020ef          	jal	800048dc <plic_claim>
    800019aa:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800019ac:	47a9                	li	a5,10
    800019ae:	00f50963          	beq	a0,a5,800019c0 <devintr+0x46>
    } else if(irq == VIRTIO0_IRQ){
    800019b2:	4785                	li	a5,1
    800019b4:	00f50963          	beq	a0,a5,800019c6 <devintr+0x4c>
    return 1;
    800019b8:	4505                	li	a0,1
    } else if(irq){
    800019ba:	e889                	bnez	s1,800019cc <devintr+0x52>
    800019bc:	64a2                	ld	s1,8(sp)
    800019be:	bff9                	j	8000199c <devintr+0x22>
      uartintr();
    800019c0:	61f030ef          	jal	800057de <uartintr>
    if(irq)
    800019c4:	a819                	j	800019da <devintr+0x60>
      virtio_disk_intr();
    800019c6:	3dc030ef          	jal	80004da2 <virtio_disk_intr>
    if(irq)
    800019ca:	a801                	j	800019da <devintr+0x60>
      printf("unexpected interrupt irq=%d\n", irq);
    800019cc:	85a6                	mv	a1,s1
    800019ce:	00006517          	auipc	a0,0x6
    800019d2:	82250513          	addi	a0,a0,-2014 # 800071f0 <etext+0x1f0>
    800019d6:	153030ef          	jal	80005328 <printf>
      plic_complete(irq);
    800019da:	8526                	mv	a0,s1
    800019dc:	721020ef          	jal	800048fc <plic_complete>
    return 1;
    800019e0:	4505                	li	a0,1
    800019e2:	64a2                	ld	s1,8(sp)
    800019e4:	bf65                	j	8000199c <devintr+0x22>
    clockintr();
    800019e6:	f41ff0ef          	jal	80001926 <clockintr>
    return 2;
    800019ea:	4509                	li	a0,2
    800019ec:	bf45                	j	8000199c <devintr+0x22>

00000000800019ee <usertrap>:
{
    800019ee:	1101                	addi	sp,sp,-32
    800019f0:	ec06                	sd	ra,24(sp)
    800019f2:	e822                	sd	s0,16(sp)
    800019f4:	e426                	sd	s1,8(sp)
    800019f6:	e04a                	sd	s2,0(sp)
    800019f8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019fa:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800019fe:	1007f793          	andi	a5,a5,256
    80001a02:	eba5                	bnez	a5,80001a72 <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001a04:	00003797          	auipc	a5,0x3
    80001a08:	e2c78793          	addi	a5,a5,-468 # 80004830 <kernelvec>
    80001a0c:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001a10:	b6aff0ef          	jal	80000d7a <myproc>
    80001a14:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001a16:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a18:	14102773          	csrr	a4,sepc
    80001a1c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a1e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001a22:	47a1                	li	a5,8
    80001a24:	04f70d63          	beq	a4,a5,80001a7e <usertrap+0x90>
  } else if((which_dev = devintr()) != 0){
    80001a28:	f53ff0ef          	jal	8000197a <devintr>
    80001a2c:	892a                	mv	s2,a0
    80001a2e:	e945                	bnez	a0,80001ade <usertrap+0xf0>
    80001a30:	14202773          	csrr	a4,scause
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001a34:	47bd                	li	a5,15
    80001a36:	08f70863          	beq	a4,a5,80001ac6 <usertrap+0xd8>
    80001a3a:	14202773          	csrr	a4,scause
    80001a3e:	47b5                	li	a5,13
    80001a40:	08f70363          	beq	a4,a5,80001ac6 <usertrap+0xd8>
    80001a44:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001a48:	5890                	lw	a2,48(s1)
    80001a4a:	00005517          	auipc	a0,0x5
    80001a4e:	7e650513          	addi	a0,a0,2022 # 80007230 <etext+0x230>
    80001a52:	0d7030ef          	jal	80005328 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a56:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a5a:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001a5e:	00006517          	auipc	a0,0x6
    80001a62:	80250513          	addi	a0,a0,-2046 # 80007260 <etext+0x260>
    80001a66:	0c3030ef          	jal	80005328 <printf>
    setkilled(p);
    80001a6a:	8526                	mv	a0,s1
    80001a6c:	b1bff0ef          	jal	80001586 <setkilled>
    80001a70:	a035                	j	80001a9c <usertrap+0xae>
    panic("usertrap: not from user mode");
    80001a72:	00005517          	auipc	a0,0x5
    80001a76:	79e50513          	addi	a0,a0,1950 # 80007210 <etext+0x210>
    80001a7a:	395030ef          	jal	8000560e <panic>
    if(killed(p))
    80001a7e:	b2dff0ef          	jal	800015aa <killed>
    80001a82:	ed15                	bnez	a0,80001abe <usertrap+0xd0>
    p->trapframe->epc += 4;
    80001a84:	6cb8                	ld	a4,88(s1)
    80001a86:	6f1c                	ld	a5,24(a4)
    80001a88:	0791                	addi	a5,a5,4
    80001a8a:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a8c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001a90:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a94:	10079073          	csrw	sstatus,a5
    syscall();
    80001a98:	246000ef          	jal	80001cde <syscall>
  if(killed(p))
    80001a9c:	8526                	mv	a0,s1
    80001a9e:	b0dff0ef          	jal	800015aa <killed>
    80001aa2:	e139                	bnez	a0,80001ae8 <usertrap+0xfa>
  prepare_return();
    80001aa4:	e09ff0ef          	jal	800018ac <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80001aa8:	68a8                	ld	a0,80(s1)
    80001aaa:	8131                	srli	a0,a0,0xc
    80001aac:	57fd                	li	a5,-1
    80001aae:	17fe                	slli	a5,a5,0x3f
    80001ab0:	8d5d                	or	a0,a0,a5
}
    80001ab2:	60e2                	ld	ra,24(sp)
    80001ab4:	6442                	ld	s0,16(sp)
    80001ab6:	64a2                	ld	s1,8(sp)
    80001ab8:	6902                	ld	s2,0(sp)
    80001aba:	6105                	addi	sp,sp,32
    80001abc:	8082                	ret
      kexit(-1);
    80001abe:	557d                	li	a0,-1
    80001ac0:	9bfff0ef          	jal	8000147e <kexit>
    80001ac4:	b7c1                	j	80001a84 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001ac6:	143025f3          	csrr	a1,stval
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001aca:	14202673          	csrr	a2,scause
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80001ace:	164d                	addi	a2,a2,-13 # ff3 <_entry-0x7ffff00d>
    80001ad0:	00163613          	seqz	a2,a2
    80001ad4:	68a8                	ld	a0,80(s1)
    80001ad6:	f37fe0ef          	jal	80000a0c <vmfault>
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001ada:	f169                	bnez	a0,80001a9c <usertrap+0xae>
    80001adc:	b7a5                	j	80001a44 <usertrap+0x56>
  if(killed(p))
    80001ade:	8526                	mv	a0,s1
    80001ae0:	acbff0ef          	jal	800015aa <killed>
    80001ae4:	c511                	beqz	a0,80001af0 <usertrap+0x102>
    80001ae6:	a011                	j	80001aea <usertrap+0xfc>
    80001ae8:	4901                	li	s2,0
    kexit(-1);
    80001aea:	557d                	li	a0,-1
    80001aec:	993ff0ef          	jal	8000147e <kexit>
  if(which_dev == 2)
    80001af0:	4789                	li	a5,2
    80001af2:	faf919e3          	bne	s2,a5,80001aa4 <usertrap+0xb6>
    yield();
    80001af6:	851ff0ef          	jal	80001346 <yield>
    80001afa:	b76d                	j	80001aa4 <usertrap+0xb6>

0000000080001afc <kerneltrap>:
{
    80001afc:	7179                	addi	sp,sp,-48
    80001afe:	f406                	sd	ra,40(sp)
    80001b00:	f022                	sd	s0,32(sp)
    80001b02:	ec26                	sd	s1,24(sp)
    80001b04:	e84a                	sd	s2,16(sp)
    80001b06:	e44e                	sd	s3,8(sp)
    80001b08:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b0a:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b0e:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b12:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001b16:	1004f793          	andi	a5,s1,256
    80001b1a:	c795                	beqz	a5,80001b46 <kerneltrap+0x4a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b1c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001b20:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001b22:	eb85                	bnez	a5,80001b52 <kerneltrap+0x56>
  if((which_dev = devintr()) == 0){
    80001b24:	e57ff0ef          	jal	8000197a <devintr>
    80001b28:	c91d                	beqz	a0,80001b5e <kerneltrap+0x62>
  if(which_dev == 2 && myproc() != 0)
    80001b2a:	4789                	li	a5,2
    80001b2c:	04f50a63          	beq	a0,a5,80001b80 <kerneltrap+0x84>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b30:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b34:	10049073          	csrw	sstatus,s1
}
    80001b38:	70a2                	ld	ra,40(sp)
    80001b3a:	7402                	ld	s0,32(sp)
    80001b3c:	64e2                	ld	s1,24(sp)
    80001b3e:	6942                	ld	s2,16(sp)
    80001b40:	69a2                	ld	s3,8(sp)
    80001b42:	6145                	addi	sp,sp,48
    80001b44:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001b46:	00005517          	auipc	a0,0x5
    80001b4a:	74250513          	addi	a0,a0,1858 # 80007288 <etext+0x288>
    80001b4e:	2c1030ef          	jal	8000560e <panic>
    panic("kerneltrap: interrupts enabled");
    80001b52:	00005517          	auipc	a0,0x5
    80001b56:	75e50513          	addi	a0,a0,1886 # 800072b0 <etext+0x2b0>
    80001b5a:	2b5030ef          	jal	8000560e <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b5e:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b62:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001b66:	85ce                	mv	a1,s3
    80001b68:	00005517          	auipc	a0,0x5
    80001b6c:	76850513          	addi	a0,a0,1896 # 800072d0 <etext+0x2d0>
    80001b70:	7b8030ef          	jal	80005328 <printf>
    panic("kerneltrap");
    80001b74:	00005517          	auipc	a0,0x5
    80001b78:	78450513          	addi	a0,a0,1924 # 800072f8 <etext+0x2f8>
    80001b7c:	293030ef          	jal	8000560e <panic>
  if(which_dev == 2 && myproc() != 0)
    80001b80:	9faff0ef          	jal	80000d7a <myproc>
    80001b84:	d555                	beqz	a0,80001b30 <kerneltrap+0x34>
    yield();
    80001b86:	fc0ff0ef          	jal	80001346 <yield>
    80001b8a:	b75d                	j	80001b30 <kerneltrap+0x34>

0000000080001b8c <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001b8c:	1101                	addi	sp,sp,-32
    80001b8e:	ec06                	sd	ra,24(sp)
    80001b90:	e822                	sd	s0,16(sp)
    80001b92:	e426                	sd	s1,8(sp)
    80001b94:	1000                	addi	s0,sp,32
    80001b96:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001b98:	9e2ff0ef          	jal	80000d7a <myproc>
  switch (n) {
    80001b9c:	4795                	li	a5,5
    80001b9e:	0497e163          	bltu	a5,s1,80001be0 <argraw+0x54>
    80001ba2:	048a                	slli	s1,s1,0x2
    80001ba4:	00006717          	auipc	a4,0x6
    80001ba8:	bbc70713          	addi	a4,a4,-1092 # 80007760 <states.0+0x30>
    80001bac:	94ba                	add	s1,s1,a4
    80001bae:	409c                	lw	a5,0(s1)
    80001bb0:	97ba                	add	a5,a5,a4
    80001bb2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001bb4:	6d3c                	ld	a5,88(a0)
    80001bb6:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001bb8:	60e2                	ld	ra,24(sp)
    80001bba:	6442                	ld	s0,16(sp)
    80001bbc:	64a2                	ld	s1,8(sp)
    80001bbe:	6105                	addi	sp,sp,32
    80001bc0:	8082                	ret
    return p->trapframe->a1;
    80001bc2:	6d3c                	ld	a5,88(a0)
    80001bc4:	7fa8                	ld	a0,120(a5)
    80001bc6:	bfcd                	j	80001bb8 <argraw+0x2c>
    return p->trapframe->a2;
    80001bc8:	6d3c                	ld	a5,88(a0)
    80001bca:	63c8                	ld	a0,128(a5)
    80001bcc:	b7f5                	j	80001bb8 <argraw+0x2c>
    return p->trapframe->a3;
    80001bce:	6d3c                	ld	a5,88(a0)
    80001bd0:	67c8                	ld	a0,136(a5)
    80001bd2:	b7dd                	j	80001bb8 <argraw+0x2c>
    return p->trapframe->a4;
    80001bd4:	6d3c                	ld	a5,88(a0)
    80001bd6:	6bc8                	ld	a0,144(a5)
    80001bd8:	b7c5                	j	80001bb8 <argraw+0x2c>
    return p->trapframe->a5;
    80001bda:	6d3c                	ld	a5,88(a0)
    80001bdc:	6fc8                	ld	a0,152(a5)
    80001bde:	bfe9                	j	80001bb8 <argraw+0x2c>
  panic("argraw");
    80001be0:	00005517          	auipc	a0,0x5
    80001be4:	72850513          	addi	a0,a0,1832 # 80007308 <etext+0x308>
    80001be8:	227030ef          	jal	8000560e <panic>

0000000080001bec <fetchaddr>:
{
    80001bec:	1101                	addi	sp,sp,-32
    80001bee:	ec06                	sd	ra,24(sp)
    80001bf0:	e822                	sd	s0,16(sp)
    80001bf2:	e426                	sd	s1,8(sp)
    80001bf4:	e04a                	sd	s2,0(sp)
    80001bf6:	1000                	addi	s0,sp,32
    80001bf8:	84aa                	mv	s1,a0
    80001bfa:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001bfc:	97eff0ef          	jal	80000d7a <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001c00:	653c                	ld	a5,72(a0)
    80001c02:	02f4f663          	bgeu	s1,a5,80001c2e <fetchaddr+0x42>
    80001c06:	00848713          	addi	a4,s1,8
    80001c0a:	02e7e463          	bltu	a5,a4,80001c32 <fetchaddr+0x46>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001c0e:	46a1                	li	a3,8
    80001c10:	8626                	mv	a2,s1
    80001c12:	85ca                	mv	a1,s2
    80001c14:	6928                	ld	a0,80(a0)
    80001c16:	f5dfe0ef          	jal	80000b72 <copyin>
    80001c1a:	00a03533          	snez	a0,a0
    80001c1e:	40a00533          	neg	a0,a0
}
    80001c22:	60e2                	ld	ra,24(sp)
    80001c24:	6442                	ld	s0,16(sp)
    80001c26:	64a2                	ld	s1,8(sp)
    80001c28:	6902                	ld	s2,0(sp)
    80001c2a:	6105                	addi	sp,sp,32
    80001c2c:	8082                	ret
    return -1;
    80001c2e:	557d                	li	a0,-1
    80001c30:	bfcd                	j	80001c22 <fetchaddr+0x36>
    80001c32:	557d                	li	a0,-1
    80001c34:	b7fd                	j	80001c22 <fetchaddr+0x36>

0000000080001c36 <fetchstr>:
{
    80001c36:	7179                	addi	sp,sp,-48
    80001c38:	f406                	sd	ra,40(sp)
    80001c3a:	f022                	sd	s0,32(sp)
    80001c3c:	ec26                	sd	s1,24(sp)
    80001c3e:	e84a                	sd	s2,16(sp)
    80001c40:	e44e                	sd	s3,8(sp)
    80001c42:	1800                	addi	s0,sp,48
    80001c44:	892a                	mv	s2,a0
    80001c46:	84ae                	mv	s1,a1
    80001c48:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001c4a:	930ff0ef          	jal	80000d7a <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001c4e:	86ce                	mv	a3,s3
    80001c50:	864a                	mv	a2,s2
    80001c52:	85a6                	mv	a1,s1
    80001c54:	6928                	ld	a0,80(a0)
    80001c56:	cdffe0ef          	jal	80000934 <copyinstr>
    80001c5a:	00054c63          	bltz	a0,80001c72 <fetchstr+0x3c>
  return strlen(buf);
    80001c5e:	8526                	mv	a0,s1
    80001c60:	e5efe0ef          	jal	800002be <strlen>
}
    80001c64:	70a2                	ld	ra,40(sp)
    80001c66:	7402                	ld	s0,32(sp)
    80001c68:	64e2                	ld	s1,24(sp)
    80001c6a:	6942                	ld	s2,16(sp)
    80001c6c:	69a2                	ld	s3,8(sp)
    80001c6e:	6145                	addi	sp,sp,48
    80001c70:	8082                	ret
    return -1;
    80001c72:	557d                	li	a0,-1
    80001c74:	bfc5                	j	80001c64 <fetchstr+0x2e>

0000000080001c76 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001c76:	1101                	addi	sp,sp,-32
    80001c78:	ec06                	sd	ra,24(sp)
    80001c7a:	e822                	sd	s0,16(sp)
    80001c7c:	e426                	sd	s1,8(sp)
    80001c7e:	1000                	addi	s0,sp,32
    80001c80:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c82:	f0bff0ef          	jal	80001b8c <argraw>
    80001c86:	c088                	sw	a0,0(s1)
}
    80001c88:	60e2                	ld	ra,24(sp)
    80001c8a:	6442                	ld	s0,16(sp)
    80001c8c:	64a2                	ld	s1,8(sp)
    80001c8e:	6105                	addi	sp,sp,32
    80001c90:	8082                	ret

0000000080001c92 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001c92:	1101                	addi	sp,sp,-32
    80001c94:	ec06                	sd	ra,24(sp)
    80001c96:	e822                	sd	s0,16(sp)
    80001c98:	e426                	sd	s1,8(sp)
    80001c9a:	1000                	addi	s0,sp,32
    80001c9c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c9e:	eefff0ef          	jal	80001b8c <argraw>
    80001ca2:	e088                	sd	a0,0(s1)
}
    80001ca4:	60e2                	ld	ra,24(sp)
    80001ca6:	6442                	ld	s0,16(sp)
    80001ca8:	64a2                	ld	s1,8(sp)
    80001caa:	6105                	addi	sp,sp,32
    80001cac:	8082                	ret

0000000080001cae <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001cae:	7179                	addi	sp,sp,-48
    80001cb0:	f406                	sd	ra,40(sp)
    80001cb2:	f022                	sd	s0,32(sp)
    80001cb4:	ec26                	sd	s1,24(sp)
    80001cb6:	e84a                	sd	s2,16(sp)
    80001cb8:	1800                	addi	s0,sp,48
    80001cba:	84ae                	mv	s1,a1
    80001cbc:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80001cbe:	fd840593          	addi	a1,s0,-40
    80001cc2:	fd1ff0ef          	jal	80001c92 <argaddr>
  return fetchstr(addr, buf, max);
    80001cc6:	864a                	mv	a2,s2
    80001cc8:	85a6                	mv	a1,s1
    80001cca:	fd843503          	ld	a0,-40(s0)
    80001cce:	f69ff0ef          	jal	80001c36 <fetchstr>
}
    80001cd2:	70a2                	ld	ra,40(sp)
    80001cd4:	7402                	ld	s0,32(sp)
    80001cd6:	64e2                	ld	s1,24(sp)
    80001cd8:	6942                	ld	s2,16(sp)
    80001cda:	6145                	addi	sp,sp,48
    80001cdc:	8082                	ret

0000000080001cde <syscall>:
[SYS_endianswap]   sys_endianswap,
};

void
syscall(void)
{
    80001cde:	1101                	addi	sp,sp,-32
    80001ce0:	ec06                	sd	ra,24(sp)
    80001ce2:	e822                	sd	s0,16(sp)
    80001ce4:	e426                	sd	s1,8(sp)
    80001ce6:	e04a                	sd	s2,0(sp)
    80001ce8:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001cea:	890ff0ef          	jal	80000d7a <myproc>
    80001cee:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001cf0:	05853903          	ld	s2,88(a0)
    80001cf4:	0a893783          	ld	a5,168(s2)
    80001cf8:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001cfc:	37fd                	addiw	a5,a5,-1
    80001cfe:	4755                	li	a4,21
    80001d00:	00f76f63          	bltu	a4,a5,80001d1e <syscall+0x40>
    80001d04:	00369713          	slli	a4,a3,0x3
    80001d08:	00006797          	auipc	a5,0x6
    80001d0c:	a7078793          	addi	a5,a5,-1424 # 80007778 <syscalls>
    80001d10:	97ba                	add	a5,a5,a4
    80001d12:	639c                	ld	a5,0(a5)
    80001d14:	c789                	beqz	a5,80001d1e <syscall+0x40>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001d16:	9782                	jalr	a5
    80001d18:	06a93823          	sd	a0,112(s2)
    80001d1c:	a829                	j	80001d36 <syscall+0x58>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001d1e:	15848613          	addi	a2,s1,344
    80001d22:	588c                	lw	a1,48(s1)
    80001d24:	00005517          	auipc	a0,0x5
    80001d28:	5ec50513          	addi	a0,a0,1516 # 80007310 <etext+0x310>
    80001d2c:	5fc030ef          	jal	80005328 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001d30:	6cbc                	ld	a5,88(s1)
    80001d32:	577d                	li	a4,-1
    80001d34:	fbb8                	sd	a4,112(a5)
  }
}
    80001d36:	60e2                	ld	ra,24(sp)
    80001d38:	6442                	ld	s0,16(sp)
    80001d3a:	64a2                	ld	s1,8(sp)
    80001d3c:	6902                	ld	s2,0(sp)
    80001d3e:	6105                	addi	sp,sp,32
    80001d40:	8082                	ret

0000000080001d42 <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    80001d42:	1101                	addi	sp,sp,-32
    80001d44:	ec06                	sd	ra,24(sp)
    80001d46:	e822                	sd	s0,16(sp)
    80001d48:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001d4a:	fec40593          	addi	a1,s0,-20
    80001d4e:	4501                	li	a0,0
    80001d50:	f27ff0ef          	jal	80001c76 <argint>
  kexit(n);
    80001d54:	fec42503          	lw	a0,-20(s0)
    80001d58:	f26ff0ef          	jal	8000147e <kexit>
  return 0;  // not reached
}
    80001d5c:	4501                	li	a0,0
    80001d5e:	60e2                	ld	ra,24(sp)
    80001d60:	6442                	ld	s0,16(sp)
    80001d62:	6105                	addi	sp,sp,32
    80001d64:	8082                	ret

0000000080001d66 <sys_getpid>:

uint64
sys_getpid(void)
{
    80001d66:	1141                	addi	sp,sp,-16
    80001d68:	e406                	sd	ra,8(sp)
    80001d6a:	e022                	sd	s0,0(sp)
    80001d6c:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001d6e:	80cff0ef          	jal	80000d7a <myproc>
}
    80001d72:	5908                	lw	a0,48(a0)
    80001d74:	60a2                	ld	ra,8(sp)
    80001d76:	6402                	ld	s0,0(sp)
    80001d78:	0141                	addi	sp,sp,16
    80001d7a:	8082                	ret

0000000080001d7c <sys_fork>:

uint64
sys_fork(void)
{
    80001d7c:	1141                	addi	sp,sp,-16
    80001d7e:	e406                	sd	ra,8(sp)
    80001d80:	e022                	sd	s0,0(sp)
    80001d82:	0800                	addi	s0,sp,16
  return kfork();
    80001d84:	b48ff0ef          	jal	800010cc <kfork>
}
    80001d88:	60a2                	ld	ra,8(sp)
    80001d8a:	6402                	ld	s0,0(sp)
    80001d8c:	0141                	addi	sp,sp,16
    80001d8e:	8082                	ret

0000000080001d90 <sys_wait>:

uint64
sys_wait(void)
{
    80001d90:	1101                	addi	sp,sp,-32
    80001d92:	ec06                	sd	ra,24(sp)
    80001d94:	e822                	sd	s0,16(sp)
    80001d96:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001d98:	fe840593          	addi	a1,s0,-24
    80001d9c:	4501                	li	a0,0
    80001d9e:	ef5ff0ef          	jal	80001c92 <argaddr>
  return kwait(p);
    80001da2:	fe843503          	ld	a0,-24(s0)
    80001da6:	82fff0ef          	jal	800015d4 <kwait>
}
    80001daa:	60e2                	ld	ra,24(sp)
    80001dac:	6442                	ld	s0,16(sp)
    80001dae:	6105                	addi	sp,sp,32
    80001db0:	8082                	ret

0000000080001db2 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001db2:	7179                	addi	sp,sp,-48
    80001db4:	f406                	sd	ra,40(sp)
    80001db6:	f022                	sd	s0,32(sp)
    80001db8:	ec26                	sd	s1,24(sp)
    80001dba:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80001dbc:	fd840593          	addi	a1,s0,-40
    80001dc0:	4501                	li	a0,0
    80001dc2:	eb5ff0ef          	jal	80001c76 <argint>
  argint(1, &t);
    80001dc6:	fdc40593          	addi	a1,s0,-36
    80001dca:	4505                	li	a0,1
    80001dcc:	eabff0ef          	jal	80001c76 <argint>
  addr = myproc()->sz;
    80001dd0:	fabfe0ef          	jal	80000d7a <myproc>
    80001dd4:	6524                	ld	s1,72(a0)

  if(t == SBRK_EAGER || n < 0) {
    80001dd6:	fdc42703          	lw	a4,-36(s0)
    80001dda:	4785                	li	a5,1
    80001ddc:	02f70163          	beq	a4,a5,80001dfe <sys_sbrk+0x4c>
    80001de0:	fd842783          	lw	a5,-40(s0)
    80001de4:	0007cd63          	bltz	a5,80001dfe <sys_sbrk+0x4c>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80001de8:	97a6                	add	a5,a5,s1
    80001dea:	0297e863          	bltu	a5,s1,80001e1a <sys_sbrk+0x68>
      return -1;
    myproc()->sz += n;
    80001dee:	f8dfe0ef          	jal	80000d7a <myproc>
    80001df2:	fd842703          	lw	a4,-40(s0)
    80001df6:	653c                	ld	a5,72(a0)
    80001df8:	97ba                	add	a5,a5,a4
    80001dfa:	e53c                	sd	a5,72(a0)
    80001dfc:	a039                	j	80001e0a <sys_sbrk+0x58>
    if(growproc(n) < 0) {
    80001dfe:	fd842503          	lw	a0,-40(s0)
    80001e02:	a7aff0ef          	jal	8000107c <growproc>
    80001e06:	00054863          	bltz	a0,80001e16 <sys_sbrk+0x64>
  }
  return addr;
}
    80001e0a:	8526                	mv	a0,s1
    80001e0c:	70a2                	ld	ra,40(sp)
    80001e0e:	7402                	ld	s0,32(sp)
    80001e10:	64e2                	ld	s1,24(sp)
    80001e12:	6145                	addi	sp,sp,48
    80001e14:	8082                	ret
      return -1;
    80001e16:	54fd                	li	s1,-1
    80001e18:	bfcd                	j	80001e0a <sys_sbrk+0x58>
      return -1;
    80001e1a:	54fd                	li	s1,-1
    80001e1c:	b7fd                	j	80001e0a <sys_sbrk+0x58>

0000000080001e1e <sys_pause>:

uint64
sys_pause(void)
{
    80001e1e:	7139                	addi	sp,sp,-64
    80001e20:	fc06                	sd	ra,56(sp)
    80001e22:	f822                	sd	s0,48(sp)
    80001e24:	f04a                	sd	s2,32(sp)
    80001e26:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80001e28:	fcc40593          	addi	a1,s0,-52
    80001e2c:	4501                	li	a0,0
    80001e2e:	e49ff0ef          	jal	80001c76 <argint>
  if(n < 0)
    80001e32:	fcc42783          	lw	a5,-52(s0)
    80001e36:	0607c763          	bltz	a5,80001ea4 <sys_pause+0x86>
    n = 0;
  acquire(&tickslock);
    80001e3a:	0000e517          	auipc	a0,0xe
    80001e3e:	20650513          	addi	a0,a0,518 # 80010040 <tickslock>
    80001e42:	289030ef          	jal	800058ca <acquire>
  ticks0 = ticks;
    80001e46:	00008917          	auipc	s2,0x8
    80001e4a:	39292903          	lw	s2,914(s2) # 8000a1d8 <ticks>
  while(ticks - ticks0 < n){
    80001e4e:	fcc42783          	lw	a5,-52(s0)
    80001e52:	cf8d                	beqz	a5,80001e8c <sys_pause+0x6e>
    80001e54:	f426                	sd	s1,40(sp)
    80001e56:	ec4e                	sd	s3,24(sp)
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001e58:	0000e997          	auipc	s3,0xe
    80001e5c:	1e898993          	addi	s3,s3,488 # 80010040 <tickslock>
    80001e60:	00008497          	auipc	s1,0x8
    80001e64:	37848493          	addi	s1,s1,888 # 8000a1d8 <ticks>
    if(killed(myproc())){
    80001e68:	f13fe0ef          	jal	80000d7a <myproc>
    80001e6c:	f3eff0ef          	jal	800015aa <killed>
    80001e70:	ed0d                	bnez	a0,80001eaa <sys_pause+0x8c>
    sleep(&ticks, &tickslock);
    80001e72:	85ce                	mv	a1,s3
    80001e74:	8526                	mv	a0,s1
    80001e76:	cfcff0ef          	jal	80001372 <sleep>
  while(ticks - ticks0 < n){
    80001e7a:	409c                	lw	a5,0(s1)
    80001e7c:	412787bb          	subw	a5,a5,s2
    80001e80:	fcc42703          	lw	a4,-52(s0)
    80001e84:	fee7e2e3          	bltu	a5,a4,80001e68 <sys_pause+0x4a>
    80001e88:	74a2                	ld	s1,40(sp)
    80001e8a:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001e8c:	0000e517          	auipc	a0,0xe
    80001e90:	1b450513          	addi	a0,a0,436 # 80010040 <tickslock>
    80001e94:	2cf030ef          	jal	80005962 <release>
  return 0;
    80001e98:	4501                	li	a0,0
}
    80001e9a:	70e2                	ld	ra,56(sp)
    80001e9c:	7442                	ld	s0,48(sp)
    80001e9e:	7902                	ld	s2,32(sp)
    80001ea0:	6121                	addi	sp,sp,64
    80001ea2:	8082                	ret
    n = 0;
    80001ea4:	fc042623          	sw	zero,-52(s0)
    80001ea8:	bf49                	j	80001e3a <sys_pause+0x1c>
      release(&tickslock);
    80001eaa:	0000e517          	auipc	a0,0xe
    80001eae:	19650513          	addi	a0,a0,406 # 80010040 <tickslock>
    80001eb2:	2b1030ef          	jal	80005962 <release>
      return -1;
    80001eb6:	557d                	li	a0,-1
    80001eb8:	74a2                	ld	s1,40(sp)
    80001eba:	69e2                	ld	s3,24(sp)
    80001ebc:	bff9                	j	80001e9a <sys_pause+0x7c>

0000000080001ebe <sys_kill>:

uint64
sys_kill(void)
{
    80001ebe:	1101                	addi	sp,sp,-32
    80001ec0:	ec06                	sd	ra,24(sp)
    80001ec2:	e822                	sd	s0,16(sp)
    80001ec4:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001ec6:	fec40593          	addi	a1,s0,-20
    80001eca:	4501                	li	a0,0
    80001ecc:	dabff0ef          	jal	80001c76 <argint>
  return kkill(pid);
    80001ed0:	fec42503          	lw	a0,-20(s0)
    80001ed4:	e4cff0ef          	jal	80001520 <kkill>
}
    80001ed8:	60e2                	ld	ra,24(sp)
    80001eda:	6442                	ld	s0,16(sp)
    80001edc:	6105                	addi	sp,sp,32
    80001ede:	8082                	ret

0000000080001ee0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001ee0:	1101                	addi	sp,sp,-32
    80001ee2:	ec06                	sd	ra,24(sp)
    80001ee4:	e822                	sd	s0,16(sp)
    80001ee6:	e426                	sd	s1,8(sp)
    80001ee8:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001eea:	0000e517          	auipc	a0,0xe
    80001eee:	15650513          	addi	a0,a0,342 # 80010040 <tickslock>
    80001ef2:	1d9030ef          	jal	800058ca <acquire>
  xticks = ticks;
    80001ef6:	00008497          	auipc	s1,0x8
    80001efa:	2e24a483          	lw	s1,738(s1) # 8000a1d8 <ticks>
  release(&tickslock);
    80001efe:	0000e517          	auipc	a0,0xe
    80001f02:	14250513          	addi	a0,a0,322 # 80010040 <tickslock>
    80001f06:	25d030ef          	jal	80005962 <release>
  return xticks;
}
    80001f0a:	02049513          	slli	a0,s1,0x20
    80001f0e:	9101                	srli	a0,a0,0x20
    80001f10:	60e2                	ld	ra,24(sp)
    80001f12:	6442                	ld	s0,16(sp)
    80001f14:	64a2                	ld	s1,8(sp)
    80001f16:	6105                	addi	sp,sp,32
    80001f18:	8082                	ret

0000000080001f1a <sys_endianswap>:

uint64
sys_endianswap(void)
{  
    80001f1a:	1101                	addi	sp,sp,-32
    80001f1c:	ec06                	sd	ra,24(sp)
    80001f1e:	e822                	sd	s0,16(sp)
    80001f20:	1000                	addi	s0,sp,32
  
  uint val;
  argint(0, (int *)&val);
    80001f22:	fec40593          	addi	a1,s0,-20
    80001f26:	4501                	li	a0,0
    80001f28:	d4fff0ef          	jal	80001c76 <argint>
  printf("Input:  0x%X\n", val);
    80001f2c:	fec42583          	lw	a1,-20(s0)
    80001f30:	00005517          	auipc	a0,0x5
    80001f34:	40050513          	addi	a0,a0,1024 # 80007330 <etext+0x330>
    80001f38:	3f0030ef          	jal	80005328 <printf>
  val = val & 0xFFFFFFFF;
    80001f3c:	fec42783          	lw	a5,-20(s0)
  // uint high2 = (val & 0x0000FF00) >> 8;
  // uint low2 = (val & 0x000000FF);
  // uint swapped = (low2 << 24) | (high2 << 16) | (low1 << 8) | high1;

  uint swapped = 
        ((val & 0x000000FF) << 24) | 
    80001f40:	0187959b          	slliw	a1,a5,0x18
        ((val & 0x0000FF00) << 8) | 
        ((val & 0x00FF0000) >> 8) | 
        ((val & 0xFF000000) >> 24);
    80001f44:	0187d71b          	srliw	a4,a5,0x18
  uint swapped = 
    80001f48:	8dd9                	or	a1,a1,a4
        ((val & 0x0000FF00) << 8) | 
    80001f4a:	0087971b          	slliw	a4,a5,0x8
    80001f4e:	00ff06b7          	lui	a3,0xff0
    80001f52:	8f75                	and	a4,a4,a3
  uint swapped = 
    80001f54:	8dd9                	or	a1,a1,a4
        ((val & 0x00FF0000) >> 8) | 
    80001f56:	0087d79b          	srliw	a5,a5,0x8
    80001f5a:	6741                	lui	a4,0x10
    80001f5c:	f0070713          	addi	a4,a4,-256 # ff00 <_entry-0x7fff0100>
    80001f60:	8ff9                	and	a5,a5,a4
  uint swapped = 
    80001f62:	8ddd                	or	a1,a1,a5

  printf("Output: 0x%X\n", swapped);
    80001f64:	2581                	sext.w	a1,a1
    80001f66:	00005517          	auipc	a0,0x5
    80001f6a:	3da50513          	addi	a0,a0,986 # 80007340 <etext+0x340>
    80001f6e:	3ba030ef          	jal	80005328 <printf>
  return val;
    80001f72:	fec46503          	lwu	a0,-20(s0)
    80001f76:	60e2                	ld	ra,24(sp)
    80001f78:	6442                	ld	s0,16(sp)
    80001f7a:	6105                	addi	sp,sp,32
    80001f7c:	8082                	ret

0000000080001f7e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001f7e:	7179                	addi	sp,sp,-48
    80001f80:	f406                	sd	ra,40(sp)
    80001f82:	f022                	sd	s0,32(sp)
    80001f84:	ec26                	sd	s1,24(sp)
    80001f86:	e84a                	sd	s2,16(sp)
    80001f88:	e44e                	sd	s3,8(sp)
    80001f8a:	e052                	sd	s4,0(sp)
    80001f8c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001f8e:	00005597          	auipc	a1,0x5
    80001f92:	3c258593          	addi	a1,a1,962 # 80007350 <etext+0x350>
    80001f96:	0000e517          	auipc	a0,0xe
    80001f9a:	0c250513          	addi	a0,a0,194 # 80010058 <bcache>
    80001f9e:	0ad030ef          	jal	8000584a <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001fa2:	00016797          	auipc	a5,0x16
    80001fa6:	0b678793          	addi	a5,a5,182 # 80018058 <bcache+0x8000>
    80001faa:	00016717          	auipc	a4,0x16
    80001fae:	31670713          	addi	a4,a4,790 # 800182c0 <bcache+0x8268>
    80001fb2:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001fb6:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001fba:	0000e497          	auipc	s1,0xe
    80001fbe:	0b648493          	addi	s1,s1,182 # 80010070 <bcache+0x18>
    b->next = bcache.head.next;
    80001fc2:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001fc4:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001fc6:	00005a17          	auipc	s4,0x5
    80001fca:	392a0a13          	addi	s4,s4,914 # 80007358 <etext+0x358>
    b->next = bcache.head.next;
    80001fce:	2b893783          	ld	a5,696(s2)
    80001fd2:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80001fd4:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80001fd8:	85d2                	mv	a1,s4
    80001fda:	01048513          	addi	a0,s1,16
    80001fde:	322010ef          	jal	80003300 <initsleeplock>
    bcache.head.next->prev = b;
    80001fe2:	2b893783          	ld	a5,696(s2)
    80001fe6:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80001fe8:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001fec:	45848493          	addi	s1,s1,1112
    80001ff0:	fd349fe3          	bne	s1,s3,80001fce <binit+0x50>
  }
}
    80001ff4:	70a2                	ld	ra,40(sp)
    80001ff6:	7402                	ld	s0,32(sp)
    80001ff8:	64e2                	ld	s1,24(sp)
    80001ffa:	6942                	ld	s2,16(sp)
    80001ffc:	69a2                	ld	s3,8(sp)
    80001ffe:	6a02                	ld	s4,0(sp)
    80002000:	6145                	addi	sp,sp,48
    80002002:	8082                	ret

0000000080002004 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002004:	7179                	addi	sp,sp,-48
    80002006:	f406                	sd	ra,40(sp)
    80002008:	f022                	sd	s0,32(sp)
    8000200a:	ec26                	sd	s1,24(sp)
    8000200c:	e84a                	sd	s2,16(sp)
    8000200e:	e44e                	sd	s3,8(sp)
    80002010:	1800                	addi	s0,sp,48
    80002012:	892a                	mv	s2,a0
    80002014:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002016:	0000e517          	auipc	a0,0xe
    8000201a:	04250513          	addi	a0,a0,66 # 80010058 <bcache>
    8000201e:	0ad030ef          	jal	800058ca <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002022:	00016497          	auipc	s1,0x16
    80002026:	2ee4b483          	ld	s1,750(s1) # 80018310 <bcache+0x82b8>
    8000202a:	00016797          	auipc	a5,0x16
    8000202e:	29678793          	addi	a5,a5,662 # 800182c0 <bcache+0x8268>
    80002032:	02f48b63          	beq	s1,a5,80002068 <bread+0x64>
    80002036:	873e                	mv	a4,a5
    80002038:	a021                	j	80002040 <bread+0x3c>
    8000203a:	68a4                	ld	s1,80(s1)
    8000203c:	02e48663          	beq	s1,a4,80002068 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80002040:	449c                	lw	a5,8(s1)
    80002042:	ff279ce3          	bne	a5,s2,8000203a <bread+0x36>
    80002046:	44dc                	lw	a5,12(s1)
    80002048:	ff3799e3          	bne	a5,s3,8000203a <bread+0x36>
      b->refcnt++;
    8000204c:	40bc                	lw	a5,64(s1)
    8000204e:	2785                	addiw	a5,a5,1
    80002050:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002052:	0000e517          	auipc	a0,0xe
    80002056:	00650513          	addi	a0,a0,6 # 80010058 <bcache>
    8000205a:	109030ef          	jal	80005962 <release>
      acquiresleep(&b->lock);
    8000205e:	01048513          	addi	a0,s1,16
    80002062:	2d4010ef          	jal	80003336 <acquiresleep>
      return b;
    80002066:	a889                	j	800020b8 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002068:	00016497          	auipc	s1,0x16
    8000206c:	2a04b483          	ld	s1,672(s1) # 80018308 <bcache+0x82b0>
    80002070:	00016797          	auipc	a5,0x16
    80002074:	25078793          	addi	a5,a5,592 # 800182c0 <bcache+0x8268>
    80002078:	00f48863          	beq	s1,a5,80002088 <bread+0x84>
    8000207c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000207e:	40bc                	lw	a5,64(s1)
    80002080:	cb91                	beqz	a5,80002094 <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002082:	64a4                	ld	s1,72(s1)
    80002084:	fee49de3          	bne	s1,a4,8000207e <bread+0x7a>
  panic("bget: no buffers");
    80002088:	00005517          	auipc	a0,0x5
    8000208c:	2d850513          	addi	a0,a0,728 # 80007360 <etext+0x360>
    80002090:	57e030ef          	jal	8000560e <panic>
      b->dev = dev;
    80002094:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002098:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8000209c:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800020a0:	4785                	li	a5,1
    800020a2:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800020a4:	0000e517          	auipc	a0,0xe
    800020a8:	fb450513          	addi	a0,a0,-76 # 80010058 <bcache>
    800020ac:	0b7030ef          	jal	80005962 <release>
      acquiresleep(&b->lock);
    800020b0:	01048513          	addi	a0,s1,16
    800020b4:	282010ef          	jal	80003336 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800020b8:	409c                	lw	a5,0(s1)
    800020ba:	cb89                	beqz	a5,800020cc <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800020bc:	8526                	mv	a0,s1
    800020be:	70a2                	ld	ra,40(sp)
    800020c0:	7402                	ld	s0,32(sp)
    800020c2:	64e2                	ld	s1,24(sp)
    800020c4:	6942                	ld	s2,16(sp)
    800020c6:	69a2                	ld	s3,8(sp)
    800020c8:	6145                	addi	sp,sp,48
    800020ca:	8082                	ret
    virtio_disk_rw(b, 0);
    800020cc:	4581                	li	a1,0
    800020ce:	8526                	mv	a0,s1
    800020d0:	2c1020ef          	jal	80004b90 <virtio_disk_rw>
    b->valid = 1;
    800020d4:	4785                	li	a5,1
    800020d6:	c09c                	sw	a5,0(s1)
  return b;
    800020d8:	b7d5                	j	800020bc <bread+0xb8>

00000000800020da <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800020da:	1101                	addi	sp,sp,-32
    800020dc:	ec06                	sd	ra,24(sp)
    800020de:	e822                	sd	s0,16(sp)
    800020e0:	e426                	sd	s1,8(sp)
    800020e2:	1000                	addi	s0,sp,32
    800020e4:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800020e6:	0541                	addi	a0,a0,16
    800020e8:	2cc010ef          	jal	800033b4 <holdingsleep>
    800020ec:	c911                	beqz	a0,80002100 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800020ee:	4585                	li	a1,1
    800020f0:	8526                	mv	a0,s1
    800020f2:	29f020ef          	jal	80004b90 <virtio_disk_rw>
}
    800020f6:	60e2                	ld	ra,24(sp)
    800020f8:	6442                	ld	s0,16(sp)
    800020fa:	64a2                	ld	s1,8(sp)
    800020fc:	6105                	addi	sp,sp,32
    800020fe:	8082                	ret
    panic("bwrite");
    80002100:	00005517          	auipc	a0,0x5
    80002104:	27850513          	addi	a0,a0,632 # 80007378 <etext+0x378>
    80002108:	506030ef          	jal	8000560e <panic>

000000008000210c <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000210c:	1101                	addi	sp,sp,-32
    8000210e:	ec06                	sd	ra,24(sp)
    80002110:	e822                	sd	s0,16(sp)
    80002112:	e426                	sd	s1,8(sp)
    80002114:	e04a                	sd	s2,0(sp)
    80002116:	1000                	addi	s0,sp,32
    80002118:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000211a:	01050913          	addi	s2,a0,16
    8000211e:	854a                	mv	a0,s2
    80002120:	294010ef          	jal	800033b4 <holdingsleep>
    80002124:	c135                	beqz	a0,80002188 <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
    80002126:	854a                	mv	a0,s2
    80002128:	254010ef          	jal	8000337c <releasesleep>

  acquire(&bcache.lock);
    8000212c:	0000e517          	auipc	a0,0xe
    80002130:	f2c50513          	addi	a0,a0,-212 # 80010058 <bcache>
    80002134:	796030ef          	jal	800058ca <acquire>
  b->refcnt--;
    80002138:	40bc                	lw	a5,64(s1)
    8000213a:	37fd                	addiw	a5,a5,-1
    8000213c:	0007871b          	sext.w	a4,a5
    80002140:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002142:	e71d                	bnez	a4,80002170 <brelse+0x64>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002144:	68b8                	ld	a4,80(s1)
    80002146:	64bc                	ld	a5,72(s1)
    80002148:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    8000214a:	68b8                	ld	a4,80(s1)
    8000214c:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000214e:	00016797          	auipc	a5,0x16
    80002152:	f0a78793          	addi	a5,a5,-246 # 80018058 <bcache+0x8000>
    80002156:	2b87b703          	ld	a4,696(a5)
    8000215a:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8000215c:	00016717          	auipc	a4,0x16
    80002160:	16470713          	addi	a4,a4,356 # 800182c0 <bcache+0x8268>
    80002164:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002166:	2b87b703          	ld	a4,696(a5)
    8000216a:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000216c:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002170:	0000e517          	auipc	a0,0xe
    80002174:	ee850513          	addi	a0,a0,-280 # 80010058 <bcache>
    80002178:	7ea030ef          	jal	80005962 <release>
}
    8000217c:	60e2                	ld	ra,24(sp)
    8000217e:	6442                	ld	s0,16(sp)
    80002180:	64a2                	ld	s1,8(sp)
    80002182:	6902                	ld	s2,0(sp)
    80002184:	6105                	addi	sp,sp,32
    80002186:	8082                	ret
    panic("brelse");
    80002188:	00005517          	auipc	a0,0x5
    8000218c:	1f850513          	addi	a0,a0,504 # 80007380 <etext+0x380>
    80002190:	47e030ef          	jal	8000560e <panic>

0000000080002194 <bpin>:

void
bpin(struct buf *b) {
    80002194:	1101                	addi	sp,sp,-32
    80002196:	ec06                	sd	ra,24(sp)
    80002198:	e822                	sd	s0,16(sp)
    8000219a:	e426                	sd	s1,8(sp)
    8000219c:	1000                	addi	s0,sp,32
    8000219e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800021a0:	0000e517          	auipc	a0,0xe
    800021a4:	eb850513          	addi	a0,a0,-328 # 80010058 <bcache>
    800021a8:	722030ef          	jal	800058ca <acquire>
  b->refcnt++;
    800021ac:	40bc                	lw	a5,64(s1)
    800021ae:	2785                	addiw	a5,a5,1
    800021b0:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800021b2:	0000e517          	auipc	a0,0xe
    800021b6:	ea650513          	addi	a0,a0,-346 # 80010058 <bcache>
    800021ba:	7a8030ef          	jal	80005962 <release>
}
    800021be:	60e2                	ld	ra,24(sp)
    800021c0:	6442                	ld	s0,16(sp)
    800021c2:	64a2                	ld	s1,8(sp)
    800021c4:	6105                	addi	sp,sp,32
    800021c6:	8082                	ret

00000000800021c8 <bunpin>:

void
bunpin(struct buf *b) {
    800021c8:	1101                	addi	sp,sp,-32
    800021ca:	ec06                	sd	ra,24(sp)
    800021cc:	e822                	sd	s0,16(sp)
    800021ce:	e426                	sd	s1,8(sp)
    800021d0:	1000                	addi	s0,sp,32
    800021d2:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800021d4:	0000e517          	auipc	a0,0xe
    800021d8:	e8450513          	addi	a0,a0,-380 # 80010058 <bcache>
    800021dc:	6ee030ef          	jal	800058ca <acquire>
  b->refcnt--;
    800021e0:	40bc                	lw	a5,64(s1)
    800021e2:	37fd                	addiw	a5,a5,-1
    800021e4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800021e6:	0000e517          	auipc	a0,0xe
    800021ea:	e7250513          	addi	a0,a0,-398 # 80010058 <bcache>
    800021ee:	774030ef          	jal	80005962 <release>
}
    800021f2:	60e2                	ld	ra,24(sp)
    800021f4:	6442                	ld	s0,16(sp)
    800021f6:	64a2                	ld	s1,8(sp)
    800021f8:	6105                	addi	sp,sp,32
    800021fa:	8082                	ret

00000000800021fc <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800021fc:	1101                	addi	sp,sp,-32
    800021fe:	ec06                	sd	ra,24(sp)
    80002200:	e822                	sd	s0,16(sp)
    80002202:	e426                	sd	s1,8(sp)
    80002204:	e04a                	sd	s2,0(sp)
    80002206:	1000                	addi	s0,sp,32
    80002208:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000220a:	00d5d59b          	srliw	a1,a1,0xd
    8000220e:	00016797          	auipc	a5,0x16
    80002212:	5267a783          	lw	a5,1318(a5) # 80018734 <sb+0x1c>
    80002216:	9dbd                	addw	a1,a1,a5
    80002218:	dedff0ef          	jal	80002004 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000221c:	0074f713          	andi	a4,s1,7
    80002220:	4785                	li	a5,1
    80002222:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002226:	14ce                	slli	s1,s1,0x33
    80002228:	90d9                	srli	s1,s1,0x36
    8000222a:	00950733          	add	a4,a0,s1
    8000222e:	05874703          	lbu	a4,88(a4)
    80002232:	00e7f6b3          	and	a3,a5,a4
    80002236:	c29d                	beqz	a3,8000225c <bfree+0x60>
    80002238:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    8000223a:	94aa                	add	s1,s1,a0
    8000223c:	fff7c793          	not	a5,a5
    80002240:	8f7d                	and	a4,a4,a5
    80002242:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002246:	7f9000ef          	jal	8000323e <log_write>
  brelse(bp);
    8000224a:	854a                	mv	a0,s2
    8000224c:	ec1ff0ef          	jal	8000210c <brelse>
}
    80002250:	60e2                	ld	ra,24(sp)
    80002252:	6442                	ld	s0,16(sp)
    80002254:	64a2                	ld	s1,8(sp)
    80002256:	6902                	ld	s2,0(sp)
    80002258:	6105                	addi	sp,sp,32
    8000225a:	8082                	ret
    panic("freeing free block");
    8000225c:	00005517          	auipc	a0,0x5
    80002260:	12c50513          	addi	a0,a0,300 # 80007388 <etext+0x388>
    80002264:	3aa030ef          	jal	8000560e <panic>

0000000080002268 <balloc>:
{
    80002268:	711d                	addi	sp,sp,-96
    8000226a:	ec86                	sd	ra,88(sp)
    8000226c:	e8a2                	sd	s0,80(sp)
    8000226e:	e4a6                	sd	s1,72(sp)
    80002270:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002272:	00016797          	auipc	a5,0x16
    80002276:	4aa7a783          	lw	a5,1194(a5) # 8001871c <sb+0x4>
    8000227a:	0e078f63          	beqz	a5,80002378 <balloc+0x110>
    8000227e:	e0ca                	sd	s2,64(sp)
    80002280:	fc4e                	sd	s3,56(sp)
    80002282:	f852                	sd	s4,48(sp)
    80002284:	f456                	sd	s5,40(sp)
    80002286:	f05a                	sd	s6,32(sp)
    80002288:	ec5e                	sd	s7,24(sp)
    8000228a:	e862                	sd	s8,16(sp)
    8000228c:	e466                	sd	s9,8(sp)
    8000228e:	8baa                	mv	s7,a0
    80002290:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002292:	00016b17          	auipc	s6,0x16
    80002296:	486b0b13          	addi	s6,s6,1158 # 80018718 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000229a:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000229c:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000229e:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800022a0:	6c89                	lui	s9,0x2
    800022a2:	a0b5                	j	8000230e <balloc+0xa6>
        bp->data[bi/8] |= m;  // Mark block in use.
    800022a4:	97ca                	add	a5,a5,s2
    800022a6:	8e55                	or	a2,a2,a3
    800022a8:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800022ac:	854a                	mv	a0,s2
    800022ae:	791000ef          	jal	8000323e <log_write>
        brelse(bp);
    800022b2:	854a                	mv	a0,s2
    800022b4:	e59ff0ef          	jal	8000210c <brelse>
  bp = bread(dev, bno);
    800022b8:	85a6                	mv	a1,s1
    800022ba:	855e                	mv	a0,s7
    800022bc:	d49ff0ef          	jal	80002004 <bread>
    800022c0:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800022c2:	40000613          	li	a2,1024
    800022c6:	4581                	li	a1,0
    800022c8:	05850513          	addi	a0,a0,88
    800022cc:	e83fd0ef          	jal	8000014e <memset>
  log_write(bp);
    800022d0:	854a                	mv	a0,s2
    800022d2:	76d000ef          	jal	8000323e <log_write>
  brelse(bp);
    800022d6:	854a                	mv	a0,s2
    800022d8:	e35ff0ef          	jal	8000210c <brelse>
}
    800022dc:	6906                	ld	s2,64(sp)
    800022de:	79e2                	ld	s3,56(sp)
    800022e0:	7a42                	ld	s4,48(sp)
    800022e2:	7aa2                	ld	s5,40(sp)
    800022e4:	7b02                	ld	s6,32(sp)
    800022e6:	6be2                	ld	s7,24(sp)
    800022e8:	6c42                	ld	s8,16(sp)
    800022ea:	6ca2                	ld	s9,8(sp)
}
    800022ec:	8526                	mv	a0,s1
    800022ee:	60e6                	ld	ra,88(sp)
    800022f0:	6446                	ld	s0,80(sp)
    800022f2:	64a6                	ld	s1,72(sp)
    800022f4:	6125                	addi	sp,sp,96
    800022f6:	8082                	ret
    brelse(bp);
    800022f8:	854a                	mv	a0,s2
    800022fa:	e13ff0ef          	jal	8000210c <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800022fe:	015c87bb          	addw	a5,s9,s5
    80002302:	00078a9b          	sext.w	s5,a5
    80002306:	004b2703          	lw	a4,4(s6)
    8000230a:	04eaff63          	bgeu	s5,a4,80002368 <balloc+0x100>
    bp = bread(dev, BBLOCK(b, sb));
    8000230e:	41fad79b          	sraiw	a5,s5,0x1f
    80002312:	0137d79b          	srliw	a5,a5,0x13
    80002316:	015787bb          	addw	a5,a5,s5
    8000231a:	40d7d79b          	sraiw	a5,a5,0xd
    8000231e:	01cb2583          	lw	a1,28(s6)
    80002322:	9dbd                	addw	a1,a1,a5
    80002324:	855e                	mv	a0,s7
    80002326:	cdfff0ef          	jal	80002004 <bread>
    8000232a:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000232c:	004b2503          	lw	a0,4(s6)
    80002330:	000a849b          	sext.w	s1,s5
    80002334:	8762                	mv	a4,s8
    80002336:	fca4f1e3          	bgeu	s1,a0,800022f8 <balloc+0x90>
      m = 1 << (bi % 8);
    8000233a:	00777693          	andi	a3,a4,7
    8000233e:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002342:	41f7579b          	sraiw	a5,a4,0x1f
    80002346:	01d7d79b          	srliw	a5,a5,0x1d
    8000234a:	9fb9                	addw	a5,a5,a4
    8000234c:	4037d79b          	sraiw	a5,a5,0x3
    80002350:	00f90633          	add	a2,s2,a5
    80002354:	05864603          	lbu	a2,88(a2)
    80002358:	00c6f5b3          	and	a1,a3,a2
    8000235c:	d5a1                	beqz	a1,800022a4 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000235e:	2705                	addiw	a4,a4,1
    80002360:	2485                	addiw	s1,s1,1
    80002362:	fd471ae3          	bne	a4,s4,80002336 <balloc+0xce>
    80002366:	bf49                	j	800022f8 <balloc+0x90>
    80002368:	6906                	ld	s2,64(sp)
    8000236a:	79e2                	ld	s3,56(sp)
    8000236c:	7a42                	ld	s4,48(sp)
    8000236e:	7aa2                	ld	s5,40(sp)
    80002370:	7b02                	ld	s6,32(sp)
    80002372:	6be2                	ld	s7,24(sp)
    80002374:	6c42                	ld	s8,16(sp)
    80002376:	6ca2                	ld	s9,8(sp)
  printf("balloc: out of blocks\n");
    80002378:	00005517          	auipc	a0,0x5
    8000237c:	02850513          	addi	a0,a0,40 # 800073a0 <etext+0x3a0>
    80002380:	7a9020ef          	jal	80005328 <printf>
  return 0;
    80002384:	4481                	li	s1,0
    80002386:	b79d                	j	800022ec <balloc+0x84>

0000000080002388 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002388:	7179                	addi	sp,sp,-48
    8000238a:	f406                	sd	ra,40(sp)
    8000238c:	f022                	sd	s0,32(sp)
    8000238e:	ec26                	sd	s1,24(sp)
    80002390:	e84a                	sd	s2,16(sp)
    80002392:	e44e                	sd	s3,8(sp)
    80002394:	1800                	addi	s0,sp,48
    80002396:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002398:	47ad                	li	a5,11
    8000239a:	02b7e663          	bltu	a5,a1,800023c6 <bmap+0x3e>
    if((addr = ip->addrs[bn]) == 0){
    8000239e:	02059793          	slli	a5,a1,0x20
    800023a2:	01e7d593          	srli	a1,a5,0x1e
    800023a6:	00b504b3          	add	s1,a0,a1
    800023aa:	0504a903          	lw	s2,80(s1)
    800023ae:	06091a63          	bnez	s2,80002422 <bmap+0x9a>
      addr = balloc(ip->dev);
    800023b2:	4108                	lw	a0,0(a0)
    800023b4:	eb5ff0ef          	jal	80002268 <balloc>
    800023b8:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800023bc:	06090363          	beqz	s2,80002422 <bmap+0x9a>
        return 0;
      ip->addrs[bn] = addr;
    800023c0:	0524a823          	sw	s2,80(s1)
    800023c4:	a8b9                	j	80002422 <bmap+0x9a>
    }
    return addr;
  }
  bn -= NDIRECT;
    800023c6:	ff45849b          	addiw	s1,a1,-12
    800023ca:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800023ce:	0ff00793          	li	a5,255
    800023d2:	06e7ee63          	bltu	a5,a4,8000244e <bmap+0xc6>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800023d6:	08052903          	lw	s2,128(a0)
    800023da:	00091d63          	bnez	s2,800023f4 <bmap+0x6c>
      addr = balloc(ip->dev);
    800023de:	4108                	lw	a0,0(a0)
    800023e0:	e89ff0ef          	jal	80002268 <balloc>
    800023e4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800023e8:	02090d63          	beqz	s2,80002422 <bmap+0x9a>
    800023ec:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    800023ee:	0929a023          	sw	s2,128(s3)
    800023f2:	a011                	j	800023f6 <bmap+0x6e>
    800023f4:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    800023f6:	85ca                	mv	a1,s2
    800023f8:	0009a503          	lw	a0,0(s3)
    800023fc:	c09ff0ef          	jal	80002004 <bread>
    80002400:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002402:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002406:	02049713          	slli	a4,s1,0x20
    8000240a:	01e75593          	srli	a1,a4,0x1e
    8000240e:	00b784b3          	add	s1,a5,a1
    80002412:	0004a903          	lw	s2,0(s1)
    80002416:	00090e63          	beqz	s2,80002432 <bmap+0xaa>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    8000241a:	8552                	mv	a0,s4
    8000241c:	cf1ff0ef          	jal	8000210c <brelse>
    return addr;
    80002420:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002422:	854a                	mv	a0,s2
    80002424:	70a2                	ld	ra,40(sp)
    80002426:	7402                	ld	s0,32(sp)
    80002428:	64e2                	ld	s1,24(sp)
    8000242a:	6942                	ld	s2,16(sp)
    8000242c:	69a2                	ld	s3,8(sp)
    8000242e:	6145                	addi	sp,sp,48
    80002430:	8082                	ret
      addr = balloc(ip->dev);
    80002432:	0009a503          	lw	a0,0(s3)
    80002436:	e33ff0ef          	jal	80002268 <balloc>
    8000243a:	0005091b          	sext.w	s2,a0
      if(addr){
    8000243e:	fc090ee3          	beqz	s2,8000241a <bmap+0x92>
        a[bn] = addr;
    80002442:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002446:	8552                	mv	a0,s4
    80002448:	5f7000ef          	jal	8000323e <log_write>
    8000244c:	b7f9                	j	8000241a <bmap+0x92>
    8000244e:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    80002450:	00005517          	auipc	a0,0x5
    80002454:	f6850513          	addi	a0,a0,-152 # 800073b8 <etext+0x3b8>
    80002458:	1b6030ef          	jal	8000560e <panic>

000000008000245c <iget>:
{
    8000245c:	7179                	addi	sp,sp,-48
    8000245e:	f406                	sd	ra,40(sp)
    80002460:	f022                	sd	s0,32(sp)
    80002462:	ec26                	sd	s1,24(sp)
    80002464:	e84a                	sd	s2,16(sp)
    80002466:	e44e                	sd	s3,8(sp)
    80002468:	e052                	sd	s4,0(sp)
    8000246a:	1800                	addi	s0,sp,48
    8000246c:	89aa                	mv	s3,a0
    8000246e:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002470:	00016517          	auipc	a0,0x16
    80002474:	2c850513          	addi	a0,a0,712 # 80018738 <itable>
    80002478:	452030ef          	jal	800058ca <acquire>
  empty = 0;
    8000247c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000247e:	00016497          	auipc	s1,0x16
    80002482:	2d248493          	addi	s1,s1,722 # 80018750 <itable+0x18>
    80002486:	00018697          	auipc	a3,0x18
    8000248a:	d5a68693          	addi	a3,a3,-678 # 8001a1e0 <log>
    8000248e:	a039                	j	8000249c <iget+0x40>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002490:	02090963          	beqz	s2,800024c2 <iget+0x66>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002494:	08848493          	addi	s1,s1,136
    80002498:	02d48863          	beq	s1,a3,800024c8 <iget+0x6c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000249c:	449c                	lw	a5,8(s1)
    8000249e:	fef059e3          	blez	a5,80002490 <iget+0x34>
    800024a2:	4098                	lw	a4,0(s1)
    800024a4:	ff3716e3          	bne	a4,s3,80002490 <iget+0x34>
    800024a8:	40d8                	lw	a4,4(s1)
    800024aa:	ff4713e3          	bne	a4,s4,80002490 <iget+0x34>
      ip->ref++;
    800024ae:	2785                	addiw	a5,a5,1
    800024b0:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800024b2:	00016517          	auipc	a0,0x16
    800024b6:	28650513          	addi	a0,a0,646 # 80018738 <itable>
    800024ba:	4a8030ef          	jal	80005962 <release>
      return ip;
    800024be:	8926                	mv	s2,s1
    800024c0:	a02d                	j	800024ea <iget+0x8e>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800024c2:	fbe9                	bnez	a5,80002494 <iget+0x38>
      empty = ip;
    800024c4:	8926                	mv	s2,s1
    800024c6:	b7f9                	j	80002494 <iget+0x38>
  if(empty == 0)
    800024c8:	02090a63          	beqz	s2,800024fc <iget+0xa0>
  ip->dev = dev;
    800024cc:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800024d0:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800024d4:	4785                	li	a5,1
    800024d6:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800024da:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800024de:	00016517          	auipc	a0,0x16
    800024e2:	25a50513          	addi	a0,a0,602 # 80018738 <itable>
    800024e6:	47c030ef          	jal	80005962 <release>
}
    800024ea:	854a                	mv	a0,s2
    800024ec:	70a2                	ld	ra,40(sp)
    800024ee:	7402                	ld	s0,32(sp)
    800024f0:	64e2                	ld	s1,24(sp)
    800024f2:	6942                	ld	s2,16(sp)
    800024f4:	69a2                	ld	s3,8(sp)
    800024f6:	6a02                	ld	s4,0(sp)
    800024f8:	6145                	addi	sp,sp,48
    800024fa:	8082                	ret
    panic("iget: no inodes");
    800024fc:	00005517          	auipc	a0,0x5
    80002500:	ed450513          	addi	a0,a0,-300 # 800073d0 <etext+0x3d0>
    80002504:	10a030ef          	jal	8000560e <panic>

0000000080002508 <iinit>:
{
    80002508:	7179                	addi	sp,sp,-48
    8000250a:	f406                	sd	ra,40(sp)
    8000250c:	f022                	sd	s0,32(sp)
    8000250e:	ec26                	sd	s1,24(sp)
    80002510:	e84a                	sd	s2,16(sp)
    80002512:	e44e                	sd	s3,8(sp)
    80002514:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002516:	00005597          	auipc	a1,0x5
    8000251a:	eca58593          	addi	a1,a1,-310 # 800073e0 <etext+0x3e0>
    8000251e:	00016517          	auipc	a0,0x16
    80002522:	21a50513          	addi	a0,a0,538 # 80018738 <itable>
    80002526:	324030ef          	jal	8000584a <initlock>
  for(i = 0; i < NINODE; i++) {
    8000252a:	00016497          	auipc	s1,0x16
    8000252e:	23648493          	addi	s1,s1,566 # 80018760 <itable+0x28>
    80002532:	00018997          	auipc	s3,0x18
    80002536:	cbe98993          	addi	s3,s3,-834 # 8001a1f0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000253a:	00005917          	auipc	s2,0x5
    8000253e:	eae90913          	addi	s2,s2,-338 # 800073e8 <etext+0x3e8>
    80002542:	85ca                	mv	a1,s2
    80002544:	8526                	mv	a0,s1
    80002546:	5bb000ef          	jal	80003300 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000254a:	08848493          	addi	s1,s1,136
    8000254e:	ff349ae3          	bne	s1,s3,80002542 <iinit+0x3a>
}
    80002552:	70a2                	ld	ra,40(sp)
    80002554:	7402                	ld	s0,32(sp)
    80002556:	64e2                	ld	s1,24(sp)
    80002558:	6942                	ld	s2,16(sp)
    8000255a:	69a2                	ld	s3,8(sp)
    8000255c:	6145                	addi	sp,sp,48
    8000255e:	8082                	ret

0000000080002560 <ialloc>:
{
    80002560:	7139                	addi	sp,sp,-64
    80002562:	fc06                	sd	ra,56(sp)
    80002564:	f822                	sd	s0,48(sp)
    80002566:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002568:	00016717          	auipc	a4,0x16
    8000256c:	1bc72703          	lw	a4,444(a4) # 80018724 <sb+0xc>
    80002570:	4785                	li	a5,1
    80002572:	06e7f063          	bgeu	a5,a4,800025d2 <ialloc+0x72>
    80002576:	f426                	sd	s1,40(sp)
    80002578:	f04a                	sd	s2,32(sp)
    8000257a:	ec4e                	sd	s3,24(sp)
    8000257c:	e852                	sd	s4,16(sp)
    8000257e:	e456                	sd	s5,8(sp)
    80002580:	e05a                	sd	s6,0(sp)
    80002582:	8aaa                	mv	s5,a0
    80002584:	8b2e                	mv	s6,a1
    80002586:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002588:	00016a17          	auipc	s4,0x16
    8000258c:	190a0a13          	addi	s4,s4,400 # 80018718 <sb>
    80002590:	00495593          	srli	a1,s2,0x4
    80002594:	018a2783          	lw	a5,24(s4)
    80002598:	9dbd                	addw	a1,a1,a5
    8000259a:	8556                	mv	a0,s5
    8000259c:	a69ff0ef          	jal	80002004 <bread>
    800025a0:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800025a2:	05850993          	addi	s3,a0,88
    800025a6:	00f97793          	andi	a5,s2,15
    800025aa:	079a                	slli	a5,a5,0x6
    800025ac:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800025ae:	00099783          	lh	a5,0(s3)
    800025b2:	cb9d                	beqz	a5,800025e8 <ialloc+0x88>
    brelse(bp);
    800025b4:	b59ff0ef          	jal	8000210c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800025b8:	0905                	addi	s2,s2,1
    800025ba:	00ca2703          	lw	a4,12(s4)
    800025be:	0009079b          	sext.w	a5,s2
    800025c2:	fce7e7e3          	bltu	a5,a4,80002590 <ialloc+0x30>
    800025c6:	74a2                	ld	s1,40(sp)
    800025c8:	7902                	ld	s2,32(sp)
    800025ca:	69e2                	ld	s3,24(sp)
    800025cc:	6a42                	ld	s4,16(sp)
    800025ce:	6aa2                	ld	s5,8(sp)
    800025d0:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    800025d2:	00005517          	auipc	a0,0x5
    800025d6:	e1e50513          	addi	a0,a0,-482 # 800073f0 <etext+0x3f0>
    800025da:	54f020ef          	jal	80005328 <printf>
  return 0;
    800025de:	4501                	li	a0,0
}
    800025e0:	70e2                	ld	ra,56(sp)
    800025e2:	7442                	ld	s0,48(sp)
    800025e4:	6121                	addi	sp,sp,64
    800025e6:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800025e8:	04000613          	li	a2,64
    800025ec:	4581                	li	a1,0
    800025ee:	854e                	mv	a0,s3
    800025f0:	b5ffd0ef          	jal	8000014e <memset>
      dip->type = type;
    800025f4:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800025f8:	8526                	mv	a0,s1
    800025fa:	445000ef          	jal	8000323e <log_write>
      brelse(bp);
    800025fe:	8526                	mv	a0,s1
    80002600:	b0dff0ef          	jal	8000210c <brelse>
      return iget(dev, inum);
    80002604:	0009059b          	sext.w	a1,s2
    80002608:	8556                	mv	a0,s5
    8000260a:	e53ff0ef          	jal	8000245c <iget>
    8000260e:	74a2                	ld	s1,40(sp)
    80002610:	7902                	ld	s2,32(sp)
    80002612:	69e2                	ld	s3,24(sp)
    80002614:	6a42                	ld	s4,16(sp)
    80002616:	6aa2                	ld	s5,8(sp)
    80002618:	6b02                	ld	s6,0(sp)
    8000261a:	b7d9                	j	800025e0 <ialloc+0x80>

000000008000261c <iupdate>:
{
    8000261c:	1101                	addi	sp,sp,-32
    8000261e:	ec06                	sd	ra,24(sp)
    80002620:	e822                	sd	s0,16(sp)
    80002622:	e426                	sd	s1,8(sp)
    80002624:	e04a                	sd	s2,0(sp)
    80002626:	1000                	addi	s0,sp,32
    80002628:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000262a:	415c                	lw	a5,4(a0)
    8000262c:	0047d79b          	srliw	a5,a5,0x4
    80002630:	00016597          	auipc	a1,0x16
    80002634:	1005a583          	lw	a1,256(a1) # 80018730 <sb+0x18>
    80002638:	9dbd                	addw	a1,a1,a5
    8000263a:	4108                	lw	a0,0(a0)
    8000263c:	9c9ff0ef          	jal	80002004 <bread>
    80002640:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002642:	05850793          	addi	a5,a0,88
    80002646:	40d8                	lw	a4,4(s1)
    80002648:	8b3d                	andi	a4,a4,15
    8000264a:	071a                	slli	a4,a4,0x6
    8000264c:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    8000264e:	04449703          	lh	a4,68(s1)
    80002652:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002656:	04649703          	lh	a4,70(s1)
    8000265a:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000265e:	04849703          	lh	a4,72(s1)
    80002662:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002666:	04a49703          	lh	a4,74(s1)
    8000266a:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000266e:	44f8                	lw	a4,76(s1)
    80002670:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002672:	03400613          	li	a2,52
    80002676:	05048593          	addi	a1,s1,80
    8000267a:	00c78513          	addi	a0,a5,12
    8000267e:	b2dfd0ef          	jal	800001aa <memmove>
  log_write(bp);
    80002682:	854a                	mv	a0,s2
    80002684:	3bb000ef          	jal	8000323e <log_write>
  brelse(bp);
    80002688:	854a                	mv	a0,s2
    8000268a:	a83ff0ef          	jal	8000210c <brelse>
}
    8000268e:	60e2                	ld	ra,24(sp)
    80002690:	6442                	ld	s0,16(sp)
    80002692:	64a2                	ld	s1,8(sp)
    80002694:	6902                	ld	s2,0(sp)
    80002696:	6105                	addi	sp,sp,32
    80002698:	8082                	ret

000000008000269a <idup>:
{
    8000269a:	1101                	addi	sp,sp,-32
    8000269c:	ec06                	sd	ra,24(sp)
    8000269e:	e822                	sd	s0,16(sp)
    800026a0:	e426                	sd	s1,8(sp)
    800026a2:	1000                	addi	s0,sp,32
    800026a4:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800026a6:	00016517          	auipc	a0,0x16
    800026aa:	09250513          	addi	a0,a0,146 # 80018738 <itable>
    800026ae:	21c030ef          	jal	800058ca <acquire>
  ip->ref++;
    800026b2:	449c                	lw	a5,8(s1)
    800026b4:	2785                	addiw	a5,a5,1
    800026b6:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800026b8:	00016517          	auipc	a0,0x16
    800026bc:	08050513          	addi	a0,a0,128 # 80018738 <itable>
    800026c0:	2a2030ef          	jal	80005962 <release>
}
    800026c4:	8526                	mv	a0,s1
    800026c6:	60e2                	ld	ra,24(sp)
    800026c8:	6442                	ld	s0,16(sp)
    800026ca:	64a2                	ld	s1,8(sp)
    800026cc:	6105                	addi	sp,sp,32
    800026ce:	8082                	ret

00000000800026d0 <ilock>:
{
    800026d0:	1101                	addi	sp,sp,-32
    800026d2:	ec06                	sd	ra,24(sp)
    800026d4:	e822                	sd	s0,16(sp)
    800026d6:	e426                	sd	s1,8(sp)
    800026d8:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800026da:	cd19                	beqz	a0,800026f8 <ilock+0x28>
    800026dc:	84aa                	mv	s1,a0
    800026de:	451c                	lw	a5,8(a0)
    800026e0:	00f05c63          	blez	a5,800026f8 <ilock+0x28>
  acquiresleep(&ip->lock);
    800026e4:	0541                	addi	a0,a0,16
    800026e6:	451000ef          	jal	80003336 <acquiresleep>
  if(ip->valid == 0){
    800026ea:	40bc                	lw	a5,64(s1)
    800026ec:	cf89                	beqz	a5,80002706 <ilock+0x36>
}
    800026ee:	60e2                	ld	ra,24(sp)
    800026f0:	6442                	ld	s0,16(sp)
    800026f2:	64a2                	ld	s1,8(sp)
    800026f4:	6105                	addi	sp,sp,32
    800026f6:	8082                	ret
    800026f8:	e04a                	sd	s2,0(sp)
    panic("ilock");
    800026fa:	00005517          	auipc	a0,0x5
    800026fe:	d0e50513          	addi	a0,a0,-754 # 80007408 <etext+0x408>
    80002702:	70d020ef          	jal	8000560e <panic>
    80002706:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002708:	40dc                	lw	a5,4(s1)
    8000270a:	0047d79b          	srliw	a5,a5,0x4
    8000270e:	00016597          	auipc	a1,0x16
    80002712:	0225a583          	lw	a1,34(a1) # 80018730 <sb+0x18>
    80002716:	9dbd                	addw	a1,a1,a5
    80002718:	4088                	lw	a0,0(s1)
    8000271a:	8ebff0ef          	jal	80002004 <bread>
    8000271e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002720:	05850593          	addi	a1,a0,88
    80002724:	40dc                	lw	a5,4(s1)
    80002726:	8bbd                	andi	a5,a5,15
    80002728:	079a                	slli	a5,a5,0x6
    8000272a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000272c:	00059783          	lh	a5,0(a1)
    80002730:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002734:	00259783          	lh	a5,2(a1)
    80002738:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000273c:	00459783          	lh	a5,4(a1)
    80002740:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002744:	00659783          	lh	a5,6(a1)
    80002748:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000274c:	459c                	lw	a5,8(a1)
    8000274e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002750:	03400613          	li	a2,52
    80002754:	05b1                	addi	a1,a1,12
    80002756:	05048513          	addi	a0,s1,80
    8000275a:	a51fd0ef          	jal	800001aa <memmove>
    brelse(bp);
    8000275e:	854a                	mv	a0,s2
    80002760:	9adff0ef          	jal	8000210c <brelse>
    ip->valid = 1;
    80002764:	4785                	li	a5,1
    80002766:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002768:	04449783          	lh	a5,68(s1)
    8000276c:	c399                	beqz	a5,80002772 <ilock+0xa2>
    8000276e:	6902                	ld	s2,0(sp)
    80002770:	bfbd                	j	800026ee <ilock+0x1e>
      panic("ilock: no type");
    80002772:	00005517          	auipc	a0,0x5
    80002776:	c9e50513          	addi	a0,a0,-866 # 80007410 <etext+0x410>
    8000277a:	695020ef          	jal	8000560e <panic>

000000008000277e <iunlock>:
{
    8000277e:	1101                	addi	sp,sp,-32
    80002780:	ec06                	sd	ra,24(sp)
    80002782:	e822                	sd	s0,16(sp)
    80002784:	e426                	sd	s1,8(sp)
    80002786:	e04a                	sd	s2,0(sp)
    80002788:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000278a:	c505                	beqz	a0,800027b2 <iunlock+0x34>
    8000278c:	84aa                	mv	s1,a0
    8000278e:	01050913          	addi	s2,a0,16
    80002792:	854a                	mv	a0,s2
    80002794:	421000ef          	jal	800033b4 <holdingsleep>
    80002798:	cd09                	beqz	a0,800027b2 <iunlock+0x34>
    8000279a:	449c                	lw	a5,8(s1)
    8000279c:	00f05b63          	blez	a5,800027b2 <iunlock+0x34>
  releasesleep(&ip->lock);
    800027a0:	854a                	mv	a0,s2
    800027a2:	3db000ef          	jal	8000337c <releasesleep>
}
    800027a6:	60e2                	ld	ra,24(sp)
    800027a8:	6442                	ld	s0,16(sp)
    800027aa:	64a2                	ld	s1,8(sp)
    800027ac:	6902                	ld	s2,0(sp)
    800027ae:	6105                	addi	sp,sp,32
    800027b0:	8082                	ret
    panic("iunlock");
    800027b2:	00005517          	auipc	a0,0x5
    800027b6:	c6e50513          	addi	a0,a0,-914 # 80007420 <etext+0x420>
    800027ba:	655020ef          	jal	8000560e <panic>

00000000800027be <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800027be:	7179                	addi	sp,sp,-48
    800027c0:	f406                	sd	ra,40(sp)
    800027c2:	f022                	sd	s0,32(sp)
    800027c4:	ec26                	sd	s1,24(sp)
    800027c6:	e84a                	sd	s2,16(sp)
    800027c8:	e44e                	sd	s3,8(sp)
    800027ca:	1800                	addi	s0,sp,48
    800027cc:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800027ce:	05050493          	addi	s1,a0,80
    800027d2:	08050913          	addi	s2,a0,128
    800027d6:	a021                	j	800027de <itrunc+0x20>
    800027d8:	0491                	addi	s1,s1,4
    800027da:	01248b63          	beq	s1,s2,800027f0 <itrunc+0x32>
    if(ip->addrs[i]){
    800027de:	408c                	lw	a1,0(s1)
    800027e0:	dde5                	beqz	a1,800027d8 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    800027e2:	0009a503          	lw	a0,0(s3)
    800027e6:	a17ff0ef          	jal	800021fc <bfree>
      ip->addrs[i] = 0;
    800027ea:	0004a023          	sw	zero,0(s1)
    800027ee:	b7ed                	j	800027d8 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    800027f0:	0809a583          	lw	a1,128(s3)
    800027f4:	ed89                	bnez	a1,8000280e <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800027f6:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800027fa:	854e                	mv	a0,s3
    800027fc:	e21ff0ef          	jal	8000261c <iupdate>
}
    80002800:	70a2                	ld	ra,40(sp)
    80002802:	7402                	ld	s0,32(sp)
    80002804:	64e2                	ld	s1,24(sp)
    80002806:	6942                	ld	s2,16(sp)
    80002808:	69a2                	ld	s3,8(sp)
    8000280a:	6145                	addi	sp,sp,48
    8000280c:	8082                	ret
    8000280e:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002810:	0009a503          	lw	a0,0(s3)
    80002814:	ff0ff0ef          	jal	80002004 <bread>
    80002818:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000281a:	05850493          	addi	s1,a0,88
    8000281e:	45850913          	addi	s2,a0,1112
    80002822:	a021                	j	8000282a <itrunc+0x6c>
    80002824:	0491                	addi	s1,s1,4
    80002826:	01248963          	beq	s1,s2,80002838 <itrunc+0x7a>
      if(a[j])
    8000282a:	408c                	lw	a1,0(s1)
    8000282c:	dde5                	beqz	a1,80002824 <itrunc+0x66>
        bfree(ip->dev, a[j]);
    8000282e:	0009a503          	lw	a0,0(s3)
    80002832:	9cbff0ef          	jal	800021fc <bfree>
    80002836:	b7fd                	j	80002824 <itrunc+0x66>
    brelse(bp);
    80002838:	8552                	mv	a0,s4
    8000283a:	8d3ff0ef          	jal	8000210c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000283e:	0809a583          	lw	a1,128(s3)
    80002842:	0009a503          	lw	a0,0(s3)
    80002846:	9b7ff0ef          	jal	800021fc <bfree>
    ip->addrs[NDIRECT] = 0;
    8000284a:	0809a023          	sw	zero,128(s3)
    8000284e:	6a02                	ld	s4,0(sp)
    80002850:	b75d                	j	800027f6 <itrunc+0x38>

0000000080002852 <iput>:
{
    80002852:	1101                	addi	sp,sp,-32
    80002854:	ec06                	sd	ra,24(sp)
    80002856:	e822                	sd	s0,16(sp)
    80002858:	e426                	sd	s1,8(sp)
    8000285a:	1000                	addi	s0,sp,32
    8000285c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000285e:	00016517          	auipc	a0,0x16
    80002862:	eda50513          	addi	a0,a0,-294 # 80018738 <itable>
    80002866:	064030ef          	jal	800058ca <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000286a:	4498                	lw	a4,8(s1)
    8000286c:	4785                	li	a5,1
    8000286e:	02f70063          	beq	a4,a5,8000288e <iput+0x3c>
  ip->ref--;
    80002872:	449c                	lw	a5,8(s1)
    80002874:	37fd                	addiw	a5,a5,-1
    80002876:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002878:	00016517          	auipc	a0,0x16
    8000287c:	ec050513          	addi	a0,a0,-320 # 80018738 <itable>
    80002880:	0e2030ef          	jal	80005962 <release>
}
    80002884:	60e2                	ld	ra,24(sp)
    80002886:	6442                	ld	s0,16(sp)
    80002888:	64a2                	ld	s1,8(sp)
    8000288a:	6105                	addi	sp,sp,32
    8000288c:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000288e:	40bc                	lw	a5,64(s1)
    80002890:	d3ed                	beqz	a5,80002872 <iput+0x20>
    80002892:	04a49783          	lh	a5,74(s1)
    80002896:	fff1                	bnez	a5,80002872 <iput+0x20>
    80002898:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    8000289a:	01048913          	addi	s2,s1,16
    8000289e:	854a                	mv	a0,s2
    800028a0:	297000ef          	jal	80003336 <acquiresleep>
    release(&itable.lock);
    800028a4:	00016517          	auipc	a0,0x16
    800028a8:	e9450513          	addi	a0,a0,-364 # 80018738 <itable>
    800028ac:	0b6030ef          	jal	80005962 <release>
    itrunc(ip);
    800028b0:	8526                	mv	a0,s1
    800028b2:	f0dff0ef          	jal	800027be <itrunc>
    ip->type = 0;
    800028b6:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800028ba:	8526                	mv	a0,s1
    800028bc:	d61ff0ef          	jal	8000261c <iupdate>
    ip->valid = 0;
    800028c0:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800028c4:	854a                	mv	a0,s2
    800028c6:	2b7000ef          	jal	8000337c <releasesleep>
    acquire(&itable.lock);
    800028ca:	00016517          	auipc	a0,0x16
    800028ce:	e6e50513          	addi	a0,a0,-402 # 80018738 <itable>
    800028d2:	7f9020ef          	jal	800058ca <acquire>
    800028d6:	6902                	ld	s2,0(sp)
    800028d8:	bf69                	j	80002872 <iput+0x20>

00000000800028da <iunlockput>:
{
    800028da:	1101                	addi	sp,sp,-32
    800028dc:	ec06                	sd	ra,24(sp)
    800028de:	e822                	sd	s0,16(sp)
    800028e0:	e426                	sd	s1,8(sp)
    800028e2:	1000                	addi	s0,sp,32
    800028e4:	84aa                	mv	s1,a0
  iunlock(ip);
    800028e6:	e99ff0ef          	jal	8000277e <iunlock>
  iput(ip);
    800028ea:	8526                	mv	a0,s1
    800028ec:	f67ff0ef          	jal	80002852 <iput>
}
    800028f0:	60e2                	ld	ra,24(sp)
    800028f2:	6442                	ld	s0,16(sp)
    800028f4:	64a2                	ld	s1,8(sp)
    800028f6:	6105                	addi	sp,sp,32
    800028f8:	8082                	ret

00000000800028fa <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800028fa:	00016717          	auipc	a4,0x16
    800028fe:	e2a72703          	lw	a4,-470(a4) # 80018724 <sb+0xc>
    80002902:	4785                	li	a5,1
    80002904:	0ae7ff63          	bgeu	a5,a4,800029c2 <ireclaim+0xc8>
{
    80002908:	7139                	addi	sp,sp,-64
    8000290a:	fc06                	sd	ra,56(sp)
    8000290c:	f822                	sd	s0,48(sp)
    8000290e:	f426                	sd	s1,40(sp)
    80002910:	f04a                	sd	s2,32(sp)
    80002912:	ec4e                	sd	s3,24(sp)
    80002914:	e852                	sd	s4,16(sp)
    80002916:	e456                	sd	s5,8(sp)
    80002918:	e05a                	sd	s6,0(sp)
    8000291a:	0080                	addi	s0,sp,64
  for (int inum = 1; inum < sb.ninodes; inum++) {
    8000291c:	4485                	li	s1,1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    8000291e:	00050a1b          	sext.w	s4,a0
    80002922:	00016a97          	auipc	s5,0x16
    80002926:	df6a8a93          	addi	s5,s5,-522 # 80018718 <sb>
      printf("ireclaim: orphaned inode %d\n", inum);
    8000292a:	00005b17          	auipc	s6,0x5
    8000292e:	afeb0b13          	addi	s6,s6,-1282 # 80007428 <etext+0x428>
    80002932:	a099                	j	80002978 <ireclaim+0x7e>
    80002934:	85ce                	mv	a1,s3
    80002936:	855a                	mv	a0,s6
    80002938:	1f1020ef          	jal	80005328 <printf>
      ip = iget(dev, inum);
    8000293c:	85ce                	mv	a1,s3
    8000293e:	8552                	mv	a0,s4
    80002940:	b1dff0ef          	jal	8000245c <iget>
    80002944:	89aa                	mv	s3,a0
    brelse(bp);
    80002946:	854a                	mv	a0,s2
    80002948:	fc4ff0ef          	jal	8000210c <brelse>
    if (ip) {
    8000294c:	00098f63          	beqz	s3,8000296a <ireclaim+0x70>
      begin_op();
    80002950:	76a000ef          	jal	800030ba <begin_op>
      ilock(ip);
    80002954:	854e                	mv	a0,s3
    80002956:	d7bff0ef          	jal	800026d0 <ilock>
      iunlock(ip);
    8000295a:	854e                	mv	a0,s3
    8000295c:	e23ff0ef          	jal	8000277e <iunlock>
      iput(ip);
    80002960:	854e                	mv	a0,s3
    80002962:	ef1ff0ef          	jal	80002852 <iput>
      end_op();
    80002966:	7be000ef          	jal	80003124 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    8000296a:	0485                	addi	s1,s1,1
    8000296c:	00caa703          	lw	a4,12(s5)
    80002970:	0004879b          	sext.w	a5,s1
    80002974:	02e7fd63          	bgeu	a5,a4,800029ae <ireclaim+0xb4>
    80002978:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    8000297c:	0044d593          	srli	a1,s1,0x4
    80002980:	018aa783          	lw	a5,24(s5)
    80002984:	9dbd                	addw	a1,a1,a5
    80002986:	8552                	mv	a0,s4
    80002988:	e7cff0ef          	jal	80002004 <bread>
    8000298c:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    8000298e:	05850793          	addi	a5,a0,88
    80002992:	00f9f713          	andi	a4,s3,15
    80002996:	071a                	slli	a4,a4,0x6
    80002998:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    8000299a:	00079703          	lh	a4,0(a5)
    8000299e:	c701                	beqz	a4,800029a6 <ireclaim+0xac>
    800029a0:	00679783          	lh	a5,6(a5)
    800029a4:	dbc1                	beqz	a5,80002934 <ireclaim+0x3a>
    brelse(bp);
    800029a6:	854a                	mv	a0,s2
    800029a8:	f64ff0ef          	jal	8000210c <brelse>
    if (ip) {
    800029ac:	bf7d                	j	8000296a <ireclaim+0x70>
}
    800029ae:	70e2                	ld	ra,56(sp)
    800029b0:	7442                	ld	s0,48(sp)
    800029b2:	74a2                	ld	s1,40(sp)
    800029b4:	7902                	ld	s2,32(sp)
    800029b6:	69e2                	ld	s3,24(sp)
    800029b8:	6a42                	ld	s4,16(sp)
    800029ba:	6aa2                	ld	s5,8(sp)
    800029bc:	6b02                	ld	s6,0(sp)
    800029be:	6121                	addi	sp,sp,64
    800029c0:	8082                	ret
    800029c2:	8082                	ret

00000000800029c4 <fsinit>:
fsinit(int dev) {
    800029c4:	7179                	addi	sp,sp,-48
    800029c6:	f406                	sd	ra,40(sp)
    800029c8:	f022                	sd	s0,32(sp)
    800029ca:	ec26                	sd	s1,24(sp)
    800029cc:	e84a                	sd	s2,16(sp)
    800029ce:	e44e                	sd	s3,8(sp)
    800029d0:	1800                	addi	s0,sp,48
    800029d2:	84aa                	mv	s1,a0
  bp = bread(dev, 1);
    800029d4:	4585                	li	a1,1
    800029d6:	e2eff0ef          	jal	80002004 <bread>
    800029da:	892a                	mv	s2,a0
  memmove(sb, bp->data, sizeof(*sb));
    800029dc:	00016997          	auipc	s3,0x16
    800029e0:	d3c98993          	addi	s3,s3,-708 # 80018718 <sb>
    800029e4:	02000613          	li	a2,32
    800029e8:	05850593          	addi	a1,a0,88
    800029ec:	854e                	mv	a0,s3
    800029ee:	fbcfd0ef          	jal	800001aa <memmove>
  brelse(bp);
    800029f2:	854a                	mv	a0,s2
    800029f4:	f18ff0ef          	jal	8000210c <brelse>
  if(sb.magic != FSMAGIC)
    800029f8:	0009a703          	lw	a4,0(s3)
    800029fc:	102037b7          	lui	a5,0x10203
    80002a00:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002a04:	02f71363          	bne	a4,a5,80002a2a <fsinit+0x66>
  initlog(dev, &sb);
    80002a08:	00016597          	auipc	a1,0x16
    80002a0c:	d1058593          	addi	a1,a1,-752 # 80018718 <sb>
    80002a10:	8526                	mv	a0,s1
    80002a12:	62a000ef          	jal	8000303c <initlog>
  ireclaim(dev);
    80002a16:	8526                	mv	a0,s1
    80002a18:	ee3ff0ef          	jal	800028fa <ireclaim>
}
    80002a1c:	70a2                	ld	ra,40(sp)
    80002a1e:	7402                	ld	s0,32(sp)
    80002a20:	64e2                	ld	s1,24(sp)
    80002a22:	6942                	ld	s2,16(sp)
    80002a24:	69a2                	ld	s3,8(sp)
    80002a26:	6145                	addi	sp,sp,48
    80002a28:	8082                	ret
    panic("invalid file system");
    80002a2a:	00005517          	auipc	a0,0x5
    80002a2e:	a1e50513          	addi	a0,a0,-1506 # 80007448 <etext+0x448>
    80002a32:	3dd020ef          	jal	8000560e <panic>

0000000080002a36 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002a36:	1141                	addi	sp,sp,-16
    80002a38:	e422                	sd	s0,8(sp)
    80002a3a:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002a3c:	411c                	lw	a5,0(a0)
    80002a3e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002a40:	415c                	lw	a5,4(a0)
    80002a42:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002a44:	04451783          	lh	a5,68(a0)
    80002a48:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002a4c:	04a51783          	lh	a5,74(a0)
    80002a50:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002a54:	04c56783          	lwu	a5,76(a0)
    80002a58:	e99c                	sd	a5,16(a1)
}
    80002a5a:	6422                	ld	s0,8(sp)
    80002a5c:	0141                	addi	sp,sp,16
    80002a5e:	8082                	ret

0000000080002a60 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002a60:	457c                	lw	a5,76(a0)
    80002a62:	0ed7eb63          	bltu	a5,a3,80002b58 <readi+0xf8>
{
    80002a66:	7159                	addi	sp,sp,-112
    80002a68:	f486                	sd	ra,104(sp)
    80002a6a:	f0a2                	sd	s0,96(sp)
    80002a6c:	eca6                	sd	s1,88(sp)
    80002a6e:	e0d2                	sd	s4,64(sp)
    80002a70:	fc56                	sd	s5,56(sp)
    80002a72:	f85a                	sd	s6,48(sp)
    80002a74:	f45e                	sd	s7,40(sp)
    80002a76:	1880                	addi	s0,sp,112
    80002a78:	8b2a                	mv	s6,a0
    80002a7a:	8bae                	mv	s7,a1
    80002a7c:	8a32                	mv	s4,a2
    80002a7e:	84b6                	mv	s1,a3
    80002a80:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002a82:	9f35                	addw	a4,a4,a3
    return 0;
    80002a84:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002a86:	0cd76063          	bltu	a4,a3,80002b46 <readi+0xe6>
    80002a8a:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002a8c:	00e7f463          	bgeu	a5,a4,80002a94 <readi+0x34>
    n = ip->size - off;
    80002a90:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a94:	080a8f63          	beqz	s5,80002b32 <readi+0xd2>
    80002a98:	e8ca                	sd	s2,80(sp)
    80002a9a:	f062                	sd	s8,32(sp)
    80002a9c:	ec66                	sd	s9,24(sp)
    80002a9e:	e86a                	sd	s10,16(sp)
    80002aa0:	e46e                	sd	s11,8(sp)
    80002aa2:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002aa4:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002aa8:	5c7d                	li	s8,-1
    80002aaa:	a80d                	j	80002adc <readi+0x7c>
    80002aac:	020d1d93          	slli	s11,s10,0x20
    80002ab0:	020ddd93          	srli	s11,s11,0x20
    80002ab4:	05890613          	addi	a2,s2,88
    80002ab8:	86ee                	mv	a3,s11
    80002aba:	963a                	add	a2,a2,a4
    80002abc:	85d2                	mv	a1,s4
    80002abe:	855e                	mv	a0,s7
    80002ac0:	c0ffe0ef          	jal	800016ce <either_copyout>
    80002ac4:	05850763          	beq	a0,s8,80002b12 <readi+0xb2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002ac8:	854a                	mv	a0,s2
    80002aca:	e42ff0ef          	jal	8000210c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002ace:	013d09bb          	addw	s3,s10,s3
    80002ad2:	009d04bb          	addw	s1,s10,s1
    80002ad6:	9a6e                	add	s4,s4,s11
    80002ad8:	0559f763          	bgeu	s3,s5,80002b26 <readi+0xc6>
    uint addr = bmap(ip, off/BSIZE);
    80002adc:	00a4d59b          	srliw	a1,s1,0xa
    80002ae0:	855a                	mv	a0,s6
    80002ae2:	8a7ff0ef          	jal	80002388 <bmap>
    80002ae6:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002aea:	c5b1                	beqz	a1,80002b36 <readi+0xd6>
    bp = bread(ip->dev, addr);
    80002aec:	000b2503          	lw	a0,0(s6)
    80002af0:	d14ff0ef          	jal	80002004 <bread>
    80002af4:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002af6:	3ff4f713          	andi	a4,s1,1023
    80002afa:	40ec87bb          	subw	a5,s9,a4
    80002afe:	413a86bb          	subw	a3,s5,s3
    80002b02:	8d3e                	mv	s10,a5
    80002b04:	2781                	sext.w	a5,a5
    80002b06:	0006861b          	sext.w	a2,a3
    80002b0a:	faf671e3          	bgeu	a2,a5,80002aac <readi+0x4c>
    80002b0e:	8d36                	mv	s10,a3
    80002b10:	bf71                	j	80002aac <readi+0x4c>
      brelse(bp);
    80002b12:	854a                	mv	a0,s2
    80002b14:	df8ff0ef          	jal	8000210c <brelse>
      tot = -1;
    80002b18:	59fd                	li	s3,-1
      break;
    80002b1a:	6946                	ld	s2,80(sp)
    80002b1c:	7c02                	ld	s8,32(sp)
    80002b1e:	6ce2                	ld	s9,24(sp)
    80002b20:	6d42                	ld	s10,16(sp)
    80002b22:	6da2                	ld	s11,8(sp)
    80002b24:	a831                	j	80002b40 <readi+0xe0>
    80002b26:	6946                	ld	s2,80(sp)
    80002b28:	7c02                	ld	s8,32(sp)
    80002b2a:	6ce2                	ld	s9,24(sp)
    80002b2c:	6d42                	ld	s10,16(sp)
    80002b2e:	6da2                	ld	s11,8(sp)
    80002b30:	a801                	j	80002b40 <readi+0xe0>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002b32:	89d6                	mv	s3,s5
    80002b34:	a031                	j	80002b40 <readi+0xe0>
    80002b36:	6946                	ld	s2,80(sp)
    80002b38:	7c02                	ld	s8,32(sp)
    80002b3a:	6ce2                	ld	s9,24(sp)
    80002b3c:	6d42                	ld	s10,16(sp)
    80002b3e:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002b40:	0009851b          	sext.w	a0,s3
    80002b44:	69a6                	ld	s3,72(sp)
}
    80002b46:	70a6                	ld	ra,104(sp)
    80002b48:	7406                	ld	s0,96(sp)
    80002b4a:	64e6                	ld	s1,88(sp)
    80002b4c:	6a06                	ld	s4,64(sp)
    80002b4e:	7ae2                	ld	s5,56(sp)
    80002b50:	7b42                	ld	s6,48(sp)
    80002b52:	7ba2                	ld	s7,40(sp)
    80002b54:	6165                	addi	sp,sp,112
    80002b56:	8082                	ret
    return 0;
    80002b58:	4501                	li	a0,0
}
    80002b5a:	8082                	ret

0000000080002b5c <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002b5c:	457c                	lw	a5,76(a0)
    80002b5e:	10d7e063          	bltu	a5,a3,80002c5e <writei+0x102>
{
    80002b62:	7159                	addi	sp,sp,-112
    80002b64:	f486                	sd	ra,104(sp)
    80002b66:	f0a2                	sd	s0,96(sp)
    80002b68:	e8ca                	sd	s2,80(sp)
    80002b6a:	e0d2                	sd	s4,64(sp)
    80002b6c:	fc56                	sd	s5,56(sp)
    80002b6e:	f85a                	sd	s6,48(sp)
    80002b70:	f45e                	sd	s7,40(sp)
    80002b72:	1880                	addi	s0,sp,112
    80002b74:	8aaa                	mv	s5,a0
    80002b76:	8bae                	mv	s7,a1
    80002b78:	8a32                	mv	s4,a2
    80002b7a:	8936                	mv	s2,a3
    80002b7c:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002b7e:	00e687bb          	addw	a5,a3,a4
    80002b82:	0ed7e063          	bltu	a5,a3,80002c62 <writei+0x106>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002b86:	00043737          	lui	a4,0x43
    80002b8a:	0cf76e63          	bltu	a4,a5,80002c66 <writei+0x10a>
    80002b8e:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b90:	0a0b0f63          	beqz	s6,80002c4e <writei+0xf2>
    80002b94:	eca6                	sd	s1,88(sp)
    80002b96:	f062                	sd	s8,32(sp)
    80002b98:	ec66                	sd	s9,24(sp)
    80002b9a:	e86a                	sd	s10,16(sp)
    80002b9c:	e46e                	sd	s11,8(sp)
    80002b9e:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ba0:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002ba4:	5c7d                	li	s8,-1
    80002ba6:	a825                	j	80002bde <writei+0x82>
    80002ba8:	020d1d93          	slli	s11,s10,0x20
    80002bac:	020ddd93          	srli	s11,s11,0x20
    80002bb0:	05848513          	addi	a0,s1,88
    80002bb4:	86ee                	mv	a3,s11
    80002bb6:	8652                	mv	a2,s4
    80002bb8:	85de                	mv	a1,s7
    80002bba:	953a                	add	a0,a0,a4
    80002bbc:	b5dfe0ef          	jal	80001718 <either_copyin>
    80002bc0:	05850a63          	beq	a0,s8,80002c14 <writei+0xb8>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002bc4:	8526                	mv	a0,s1
    80002bc6:	678000ef          	jal	8000323e <log_write>
    brelse(bp);
    80002bca:	8526                	mv	a0,s1
    80002bcc:	d40ff0ef          	jal	8000210c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002bd0:	013d09bb          	addw	s3,s10,s3
    80002bd4:	012d093b          	addw	s2,s10,s2
    80002bd8:	9a6e                	add	s4,s4,s11
    80002bda:	0569f063          	bgeu	s3,s6,80002c1a <writei+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002bde:	00a9559b          	srliw	a1,s2,0xa
    80002be2:	8556                	mv	a0,s5
    80002be4:	fa4ff0ef          	jal	80002388 <bmap>
    80002be8:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002bec:	c59d                	beqz	a1,80002c1a <writei+0xbe>
    bp = bread(ip->dev, addr);
    80002bee:	000aa503          	lw	a0,0(s5)
    80002bf2:	c12ff0ef          	jal	80002004 <bread>
    80002bf6:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002bf8:	3ff97713          	andi	a4,s2,1023
    80002bfc:	40ec87bb          	subw	a5,s9,a4
    80002c00:	413b06bb          	subw	a3,s6,s3
    80002c04:	8d3e                	mv	s10,a5
    80002c06:	2781                	sext.w	a5,a5
    80002c08:	0006861b          	sext.w	a2,a3
    80002c0c:	f8f67ee3          	bgeu	a2,a5,80002ba8 <writei+0x4c>
    80002c10:	8d36                	mv	s10,a3
    80002c12:	bf59                	j	80002ba8 <writei+0x4c>
      brelse(bp);
    80002c14:	8526                	mv	a0,s1
    80002c16:	cf6ff0ef          	jal	8000210c <brelse>
  }

  if(off > ip->size)
    80002c1a:	04caa783          	lw	a5,76(s5)
    80002c1e:	0327fa63          	bgeu	a5,s2,80002c52 <writei+0xf6>
    ip->size = off;
    80002c22:	052aa623          	sw	s2,76(s5)
    80002c26:	64e6                	ld	s1,88(sp)
    80002c28:	7c02                	ld	s8,32(sp)
    80002c2a:	6ce2                	ld	s9,24(sp)
    80002c2c:	6d42                	ld	s10,16(sp)
    80002c2e:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002c30:	8556                	mv	a0,s5
    80002c32:	9ebff0ef          	jal	8000261c <iupdate>

  return tot;
    80002c36:	0009851b          	sext.w	a0,s3
    80002c3a:	69a6                	ld	s3,72(sp)
}
    80002c3c:	70a6                	ld	ra,104(sp)
    80002c3e:	7406                	ld	s0,96(sp)
    80002c40:	6946                	ld	s2,80(sp)
    80002c42:	6a06                	ld	s4,64(sp)
    80002c44:	7ae2                	ld	s5,56(sp)
    80002c46:	7b42                	ld	s6,48(sp)
    80002c48:	7ba2                	ld	s7,40(sp)
    80002c4a:	6165                	addi	sp,sp,112
    80002c4c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002c4e:	89da                	mv	s3,s6
    80002c50:	b7c5                	j	80002c30 <writei+0xd4>
    80002c52:	64e6                	ld	s1,88(sp)
    80002c54:	7c02                	ld	s8,32(sp)
    80002c56:	6ce2                	ld	s9,24(sp)
    80002c58:	6d42                	ld	s10,16(sp)
    80002c5a:	6da2                	ld	s11,8(sp)
    80002c5c:	bfd1                	j	80002c30 <writei+0xd4>
    return -1;
    80002c5e:	557d                	li	a0,-1
}
    80002c60:	8082                	ret
    return -1;
    80002c62:	557d                	li	a0,-1
    80002c64:	bfe1                	j	80002c3c <writei+0xe0>
    return -1;
    80002c66:	557d                	li	a0,-1
    80002c68:	bfd1                	j	80002c3c <writei+0xe0>

0000000080002c6a <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002c6a:	1141                	addi	sp,sp,-16
    80002c6c:	e406                	sd	ra,8(sp)
    80002c6e:	e022                	sd	s0,0(sp)
    80002c70:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002c72:	4639                	li	a2,14
    80002c74:	da6fd0ef          	jal	8000021a <strncmp>
}
    80002c78:	60a2                	ld	ra,8(sp)
    80002c7a:	6402                	ld	s0,0(sp)
    80002c7c:	0141                	addi	sp,sp,16
    80002c7e:	8082                	ret

0000000080002c80 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002c80:	7139                	addi	sp,sp,-64
    80002c82:	fc06                	sd	ra,56(sp)
    80002c84:	f822                	sd	s0,48(sp)
    80002c86:	f426                	sd	s1,40(sp)
    80002c88:	f04a                	sd	s2,32(sp)
    80002c8a:	ec4e                	sd	s3,24(sp)
    80002c8c:	e852                	sd	s4,16(sp)
    80002c8e:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002c90:	04451703          	lh	a4,68(a0)
    80002c94:	4785                	li	a5,1
    80002c96:	00f71a63          	bne	a4,a5,80002caa <dirlookup+0x2a>
    80002c9a:	892a                	mv	s2,a0
    80002c9c:	89ae                	mv	s3,a1
    80002c9e:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002ca0:	457c                	lw	a5,76(a0)
    80002ca2:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002ca4:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002ca6:	e39d                	bnez	a5,80002ccc <dirlookup+0x4c>
    80002ca8:	a095                	j	80002d0c <dirlookup+0x8c>
    panic("dirlookup not DIR");
    80002caa:	00004517          	auipc	a0,0x4
    80002cae:	7b650513          	addi	a0,a0,1974 # 80007460 <etext+0x460>
    80002cb2:	15d020ef          	jal	8000560e <panic>
      panic("dirlookup read");
    80002cb6:	00004517          	auipc	a0,0x4
    80002cba:	7c250513          	addi	a0,a0,1986 # 80007478 <etext+0x478>
    80002cbe:	151020ef          	jal	8000560e <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002cc2:	24c1                	addiw	s1,s1,16
    80002cc4:	04c92783          	lw	a5,76(s2)
    80002cc8:	04f4f163          	bgeu	s1,a5,80002d0a <dirlookup+0x8a>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002ccc:	4741                	li	a4,16
    80002cce:	86a6                	mv	a3,s1
    80002cd0:	fc040613          	addi	a2,s0,-64
    80002cd4:	4581                	li	a1,0
    80002cd6:	854a                	mv	a0,s2
    80002cd8:	d89ff0ef          	jal	80002a60 <readi>
    80002cdc:	47c1                	li	a5,16
    80002cde:	fcf51ce3          	bne	a0,a5,80002cb6 <dirlookup+0x36>
    if(de.inum == 0)
    80002ce2:	fc045783          	lhu	a5,-64(s0)
    80002ce6:	dff1                	beqz	a5,80002cc2 <dirlookup+0x42>
    if(namecmp(name, de.name) == 0){
    80002ce8:	fc240593          	addi	a1,s0,-62
    80002cec:	854e                	mv	a0,s3
    80002cee:	f7dff0ef          	jal	80002c6a <namecmp>
    80002cf2:	f961                	bnez	a0,80002cc2 <dirlookup+0x42>
      if(poff)
    80002cf4:	000a0463          	beqz	s4,80002cfc <dirlookup+0x7c>
        *poff = off;
    80002cf8:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80002cfc:	fc045583          	lhu	a1,-64(s0)
    80002d00:	00092503          	lw	a0,0(s2)
    80002d04:	f58ff0ef          	jal	8000245c <iget>
    80002d08:	a011                	j	80002d0c <dirlookup+0x8c>
  return 0;
    80002d0a:	4501                	li	a0,0
}
    80002d0c:	70e2                	ld	ra,56(sp)
    80002d0e:	7442                	ld	s0,48(sp)
    80002d10:	74a2                	ld	s1,40(sp)
    80002d12:	7902                	ld	s2,32(sp)
    80002d14:	69e2                	ld	s3,24(sp)
    80002d16:	6a42                	ld	s4,16(sp)
    80002d18:	6121                	addi	sp,sp,64
    80002d1a:	8082                	ret

0000000080002d1c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002d1c:	711d                	addi	sp,sp,-96
    80002d1e:	ec86                	sd	ra,88(sp)
    80002d20:	e8a2                	sd	s0,80(sp)
    80002d22:	e4a6                	sd	s1,72(sp)
    80002d24:	e0ca                	sd	s2,64(sp)
    80002d26:	fc4e                	sd	s3,56(sp)
    80002d28:	f852                	sd	s4,48(sp)
    80002d2a:	f456                	sd	s5,40(sp)
    80002d2c:	f05a                	sd	s6,32(sp)
    80002d2e:	ec5e                	sd	s7,24(sp)
    80002d30:	e862                	sd	s8,16(sp)
    80002d32:	e466                	sd	s9,8(sp)
    80002d34:	1080                	addi	s0,sp,96
    80002d36:	84aa                	mv	s1,a0
    80002d38:	8b2e                	mv	s6,a1
    80002d3a:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002d3c:	00054703          	lbu	a4,0(a0)
    80002d40:	02f00793          	li	a5,47
    80002d44:	00f70e63          	beq	a4,a5,80002d60 <namex+0x44>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002d48:	832fe0ef          	jal	80000d7a <myproc>
    80002d4c:	15053503          	ld	a0,336(a0)
    80002d50:	94bff0ef          	jal	8000269a <idup>
    80002d54:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002d56:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80002d5a:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002d5c:	4b85                	li	s7,1
    80002d5e:	a871                	j	80002dfa <namex+0xde>
    ip = iget(ROOTDEV, ROOTINO);
    80002d60:	4585                	li	a1,1
    80002d62:	4505                	li	a0,1
    80002d64:	ef8ff0ef          	jal	8000245c <iget>
    80002d68:	8a2a                	mv	s4,a0
    80002d6a:	b7f5                	j	80002d56 <namex+0x3a>
      iunlockput(ip);
    80002d6c:	8552                	mv	a0,s4
    80002d6e:	b6dff0ef          	jal	800028da <iunlockput>
      return 0;
    80002d72:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002d74:	8552                	mv	a0,s4
    80002d76:	60e6                	ld	ra,88(sp)
    80002d78:	6446                	ld	s0,80(sp)
    80002d7a:	64a6                	ld	s1,72(sp)
    80002d7c:	6906                	ld	s2,64(sp)
    80002d7e:	79e2                	ld	s3,56(sp)
    80002d80:	7a42                	ld	s4,48(sp)
    80002d82:	7aa2                	ld	s5,40(sp)
    80002d84:	7b02                	ld	s6,32(sp)
    80002d86:	6be2                	ld	s7,24(sp)
    80002d88:	6c42                	ld	s8,16(sp)
    80002d8a:	6ca2                	ld	s9,8(sp)
    80002d8c:	6125                	addi	sp,sp,96
    80002d8e:	8082                	ret
      iunlock(ip);
    80002d90:	8552                	mv	a0,s4
    80002d92:	9edff0ef          	jal	8000277e <iunlock>
      return ip;
    80002d96:	bff9                	j	80002d74 <namex+0x58>
      iunlockput(ip);
    80002d98:	8552                	mv	a0,s4
    80002d9a:	b41ff0ef          	jal	800028da <iunlockput>
      return 0;
    80002d9e:	8a4e                	mv	s4,s3
    80002da0:	bfd1                	j	80002d74 <namex+0x58>
  len = path - s;
    80002da2:	40998633          	sub	a2,s3,s1
    80002da6:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80002daa:	099c5063          	bge	s8,s9,80002e2a <namex+0x10e>
    memmove(name, s, DIRSIZ);
    80002dae:	4639                	li	a2,14
    80002db0:	85a6                	mv	a1,s1
    80002db2:	8556                	mv	a0,s5
    80002db4:	bf6fd0ef          	jal	800001aa <memmove>
    80002db8:	84ce                	mv	s1,s3
  while(*path == '/')
    80002dba:	0004c783          	lbu	a5,0(s1)
    80002dbe:	01279763          	bne	a5,s2,80002dcc <namex+0xb0>
    path++;
    80002dc2:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002dc4:	0004c783          	lbu	a5,0(s1)
    80002dc8:	ff278de3          	beq	a5,s2,80002dc2 <namex+0xa6>
    ilock(ip);
    80002dcc:	8552                	mv	a0,s4
    80002dce:	903ff0ef          	jal	800026d0 <ilock>
    if(ip->type != T_DIR){
    80002dd2:	044a1783          	lh	a5,68(s4)
    80002dd6:	f9779be3          	bne	a5,s7,80002d6c <namex+0x50>
    if(nameiparent && *path == '\0'){
    80002dda:	000b0563          	beqz	s6,80002de4 <namex+0xc8>
    80002dde:	0004c783          	lbu	a5,0(s1)
    80002de2:	d7dd                	beqz	a5,80002d90 <namex+0x74>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002de4:	4601                	li	a2,0
    80002de6:	85d6                	mv	a1,s5
    80002de8:	8552                	mv	a0,s4
    80002dea:	e97ff0ef          	jal	80002c80 <dirlookup>
    80002dee:	89aa                	mv	s3,a0
    80002df0:	d545                	beqz	a0,80002d98 <namex+0x7c>
    iunlockput(ip);
    80002df2:	8552                	mv	a0,s4
    80002df4:	ae7ff0ef          	jal	800028da <iunlockput>
    ip = next;
    80002df8:	8a4e                	mv	s4,s3
  while(*path == '/')
    80002dfa:	0004c783          	lbu	a5,0(s1)
    80002dfe:	01279763          	bne	a5,s2,80002e0c <namex+0xf0>
    path++;
    80002e02:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002e04:	0004c783          	lbu	a5,0(s1)
    80002e08:	ff278de3          	beq	a5,s2,80002e02 <namex+0xe6>
  if(*path == 0)
    80002e0c:	cb8d                	beqz	a5,80002e3e <namex+0x122>
  while(*path != '/' && *path != 0)
    80002e0e:	0004c783          	lbu	a5,0(s1)
    80002e12:	89a6                	mv	s3,s1
  len = path - s;
    80002e14:	4c81                	li	s9,0
    80002e16:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80002e18:	01278963          	beq	a5,s2,80002e2a <namex+0x10e>
    80002e1c:	d3d9                	beqz	a5,80002da2 <namex+0x86>
    path++;
    80002e1e:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80002e20:	0009c783          	lbu	a5,0(s3)
    80002e24:	ff279ce3          	bne	a5,s2,80002e1c <namex+0x100>
    80002e28:	bfad                	j	80002da2 <namex+0x86>
    memmove(name, s, len);
    80002e2a:	2601                	sext.w	a2,a2
    80002e2c:	85a6                	mv	a1,s1
    80002e2e:	8556                	mv	a0,s5
    80002e30:	b7afd0ef          	jal	800001aa <memmove>
    name[len] = 0;
    80002e34:	9cd6                	add	s9,s9,s5
    80002e36:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80002e3a:	84ce                	mv	s1,s3
    80002e3c:	bfbd                	j	80002dba <namex+0x9e>
  if(nameiparent){
    80002e3e:	f20b0be3          	beqz	s6,80002d74 <namex+0x58>
    iput(ip);
    80002e42:	8552                	mv	a0,s4
    80002e44:	a0fff0ef          	jal	80002852 <iput>
    return 0;
    80002e48:	4a01                	li	s4,0
    80002e4a:	b72d                	j	80002d74 <namex+0x58>

0000000080002e4c <dirlink>:
{
    80002e4c:	7139                	addi	sp,sp,-64
    80002e4e:	fc06                	sd	ra,56(sp)
    80002e50:	f822                	sd	s0,48(sp)
    80002e52:	f04a                	sd	s2,32(sp)
    80002e54:	ec4e                	sd	s3,24(sp)
    80002e56:	e852                	sd	s4,16(sp)
    80002e58:	0080                	addi	s0,sp,64
    80002e5a:	892a                	mv	s2,a0
    80002e5c:	8a2e                	mv	s4,a1
    80002e5e:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002e60:	4601                	li	a2,0
    80002e62:	e1fff0ef          	jal	80002c80 <dirlookup>
    80002e66:	e535                	bnez	a0,80002ed2 <dirlink+0x86>
    80002e68:	f426                	sd	s1,40(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002e6a:	04c92483          	lw	s1,76(s2)
    80002e6e:	c48d                	beqz	s1,80002e98 <dirlink+0x4c>
    80002e70:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002e72:	4741                	li	a4,16
    80002e74:	86a6                	mv	a3,s1
    80002e76:	fc040613          	addi	a2,s0,-64
    80002e7a:	4581                	li	a1,0
    80002e7c:	854a                	mv	a0,s2
    80002e7e:	be3ff0ef          	jal	80002a60 <readi>
    80002e82:	47c1                	li	a5,16
    80002e84:	04f51b63          	bne	a0,a5,80002eda <dirlink+0x8e>
    if(de.inum == 0)
    80002e88:	fc045783          	lhu	a5,-64(s0)
    80002e8c:	c791                	beqz	a5,80002e98 <dirlink+0x4c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002e8e:	24c1                	addiw	s1,s1,16
    80002e90:	04c92783          	lw	a5,76(s2)
    80002e94:	fcf4efe3          	bltu	s1,a5,80002e72 <dirlink+0x26>
  strncpy(de.name, name, DIRSIZ);
    80002e98:	4639                	li	a2,14
    80002e9a:	85d2                	mv	a1,s4
    80002e9c:	fc240513          	addi	a0,s0,-62
    80002ea0:	bb0fd0ef          	jal	80000250 <strncpy>
  de.inum = inum;
    80002ea4:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002ea8:	4741                	li	a4,16
    80002eaa:	86a6                	mv	a3,s1
    80002eac:	fc040613          	addi	a2,s0,-64
    80002eb0:	4581                	li	a1,0
    80002eb2:	854a                	mv	a0,s2
    80002eb4:	ca9ff0ef          	jal	80002b5c <writei>
    80002eb8:	1541                	addi	a0,a0,-16
    80002eba:	00a03533          	snez	a0,a0
    80002ebe:	40a00533          	neg	a0,a0
    80002ec2:	74a2                	ld	s1,40(sp)
}
    80002ec4:	70e2                	ld	ra,56(sp)
    80002ec6:	7442                	ld	s0,48(sp)
    80002ec8:	7902                	ld	s2,32(sp)
    80002eca:	69e2                	ld	s3,24(sp)
    80002ecc:	6a42                	ld	s4,16(sp)
    80002ece:	6121                	addi	sp,sp,64
    80002ed0:	8082                	ret
    iput(ip);
    80002ed2:	981ff0ef          	jal	80002852 <iput>
    return -1;
    80002ed6:	557d                	li	a0,-1
    80002ed8:	b7f5                	j	80002ec4 <dirlink+0x78>
      panic("dirlink read");
    80002eda:	00004517          	auipc	a0,0x4
    80002ede:	5ae50513          	addi	a0,a0,1454 # 80007488 <etext+0x488>
    80002ee2:	72c020ef          	jal	8000560e <panic>

0000000080002ee6 <namei>:

struct inode*
namei(char *path)
{
    80002ee6:	1101                	addi	sp,sp,-32
    80002ee8:	ec06                	sd	ra,24(sp)
    80002eea:	e822                	sd	s0,16(sp)
    80002eec:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002eee:	fe040613          	addi	a2,s0,-32
    80002ef2:	4581                	li	a1,0
    80002ef4:	e29ff0ef          	jal	80002d1c <namex>
}
    80002ef8:	60e2                	ld	ra,24(sp)
    80002efa:	6442                	ld	s0,16(sp)
    80002efc:	6105                	addi	sp,sp,32
    80002efe:	8082                	ret

0000000080002f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002f00:	1141                	addi	sp,sp,-16
    80002f02:	e406                	sd	ra,8(sp)
    80002f04:	e022                	sd	s0,0(sp)
    80002f06:	0800                	addi	s0,sp,16
    80002f08:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002f0a:	4585                	li	a1,1
    80002f0c:	e11ff0ef          	jal	80002d1c <namex>
}
    80002f10:	60a2                	ld	ra,8(sp)
    80002f12:	6402                	ld	s0,0(sp)
    80002f14:	0141                	addi	sp,sp,16
    80002f16:	8082                	ret

0000000080002f18 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002f18:	1101                	addi	sp,sp,-32
    80002f1a:	ec06                	sd	ra,24(sp)
    80002f1c:	e822                	sd	s0,16(sp)
    80002f1e:	e426                	sd	s1,8(sp)
    80002f20:	e04a                	sd	s2,0(sp)
    80002f22:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002f24:	00017917          	auipc	s2,0x17
    80002f28:	2bc90913          	addi	s2,s2,700 # 8001a1e0 <log>
    80002f2c:	01892583          	lw	a1,24(s2)
    80002f30:	02492503          	lw	a0,36(s2)
    80002f34:	8d0ff0ef          	jal	80002004 <bread>
    80002f38:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002f3a:	02892603          	lw	a2,40(s2)
    80002f3e:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002f40:	00c05f63          	blez	a2,80002f5e <write_head+0x46>
    80002f44:	00017717          	auipc	a4,0x17
    80002f48:	2c870713          	addi	a4,a4,712 # 8001a20c <log+0x2c>
    80002f4c:	87aa                	mv	a5,a0
    80002f4e:	060a                	slli	a2,a2,0x2
    80002f50:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002f52:	4314                	lw	a3,0(a4)
    80002f54:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002f56:	0711                	addi	a4,a4,4
    80002f58:	0791                	addi	a5,a5,4
    80002f5a:	fec79ce3          	bne	a5,a2,80002f52 <write_head+0x3a>
  }
  bwrite(buf);
    80002f5e:	8526                	mv	a0,s1
    80002f60:	97aff0ef          	jal	800020da <bwrite>
  brelse(buf);
    80002f64:	8526                	mv	a0,s1
    80002f66:	9a6ff0ef          	jal	8000210c <brelse>
}
    80002f6a:	60e2                	ld	ra,24(sp)
    80002f6c:	6442                	ld	s0,16(sp)
    80002f6e:	64a2                	ld	s1,8(sp)
    80002f70:	6902                	ld	s2,0(sp)
    80002f72:	6105                	addi	sp,sp,32
    80002f74:	8082                	ret

0000000080002f76 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f76:	00017797          	auipc	a5,0x17
    80002f7a:	2927a783          	lw	a5,658(a5) # 8001a208 <log+0x28>
    80002f7e:	0af05e63          	blez	a5,8000303a <install_trans+0xc4>
{
    80002f82:	715d                	addi	sp,sp,-80
    80002f84:	e486                	sd	ra,72(sp)
    80002f86:	e0a2                	sd	s0,64(sp)
    80002f88:	fc26                	sd	s1,56(sp)
    80002f8a:	f84a                	sd	s2,48(sp)
    80002f8c:	f44e                	sd	s3,40(sp)
    80002f8e:	f052                	sd	s4,32(sp)
    80002f90:	ec56                	sd	s5,24(sp)
    80002f92:	e85a                	sd	s6,16(sp)
    80002f94:	e45e                	sd	s7,8(sp)
    80002f96:	0880                	addi	s0,sp,80
    80002f98:	8b2a                	mv	s6,a0
    80002f9a:	00017a97          	auipc	s5,0x17
    80002f9e:	272a8a93          	addi	s5,s5,626 # 8001a20c <log+0x2c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002fa2:	4981                	li	s3,0
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002fa4:	00004b97          	auipc	s7,0x4
    80002fa8:	4f4b8b93          	addi	s7,s7,1268 # 80007498 <etext+0x498>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002fac:	00017a17          	auipc	s4,0x17
    80002fb0:	234a0a13          	addi	s4,s4,564 # 8001a1e0 <log>
    80002fb4:	a025                	j	80002fdc <install_trans+0x66>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002fb6:	000aa603          	lw	a2,0(s5)
    80002fba:	85ce                	mv	a1,s3
    80002fbc:	855e                	mv	a0,s7
    80002fbe:	36a020ef          	jal	80005328 <printf>
    80002fc2:	a839                	j	80002fe0 <install_trans+0x6a>
    brelse(lbuf);
    80002fc4:	854a                	mv	a0,s2
    80002fc6:	946ff0ef          	jal	8000210c <brelse>
    brelse(dbuf);
    80002fca:	8526                	mv	a0,s1
    80002fcc:	940ff0ef          	jal	8000210c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002fd0:	2985                	addiw	s3,s3,1
    80002fd2:	0a91                	addi	s5,s5,4
    80002fd4:	028a2783          	lw	a5,40(s4)
    80002fd8:	04f9d663          	bge	s3,a5,80003024 <install_trans+0xae>
    if(recovering) {
    80002fdc:	fc0b1de3          	bnez	s6,80002fb6 <install_trans+0x40>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002fe0:	018a2583          	lw	a1,24(s4)
    80002fe4:	013585bb          	addw	a1,a1,s3
    80002fe8:	2585                	addiw	a1,a1,1
    80002fea:	024a2503          	lw	a0,36(s4)
    80002fee:	816ff0ef          	jal	80002004 <bread>
    80002ff2:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80002ff4:	000aa583          	lw	a1,0(s5)
    80002ff8:	024a2503          	lw	a0,36(s4)
    80002ffc:	808ff0ef          	jal	80002004 <bread>
    80003000:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003002:	40000613          	li	a2,1024
    80003006:	05890593          	addi	a1,s2,88
    8000300a:	05850513          	addi	a0,a0,88
    8000300e:	99cfd0ef          	jal	800001aa <memmove>
    bwrite(dbuf);  // write dst to disk
    80003012:	8526                	mv	a0,s1
    80003014:	8c6ff0ef          	jal	800020da <bwrite>
    if(recovering == 0)
    80003018:	fa0b16e3          	bnez	s6,80002fc4 <install_trans+0x4e>
      bunpin(dbuf);
    8000301c:	8526                	mv	a0,s1
    8000301e:	9aaff0ef          	jal	800021c8 <bunpin>
    80003022:	b74d                	j	80002fc4 <install_trans+0x4e>
}
    80003024:	60a6                	ld	ra,72(sp)
    80003026:	6406                	ld	s0,64(sp)
    80003028:	74e2                	ld	s1,56(sp)
    8000302a:	7942                	ld	s2,48(sp)
    8000302c:	79a2                	ld	s3,40(sp)
    8000302e:	7a02                	ld	s4,32(sp)
    80003030:	6ae2                	ld	s5,24(sp)
    80003032:	6b42                	ld	s6,16(sp)
    80003034:	6ba2                	ld	s7,8(sp)
    80003036:	6161                	addi	sp,sp,80
    80003038:	8082                	ret
    8000303a:	8082                	ret

000000008000303c <initlog>:
{
    8000303c:	7179                	addi	sp,sp,-48
    8000303e:	f406                	sd	ra,40(sp)
    80003040:	f022                	sd	s0,32(sp)
    80003042:	ec26                	sd	s1,24(sp)
    80003044:	e84a                	sd	s2,16(sp)
    80003046:	e44e                	sd	s3,8(sp)
    80003048:	1800                	addi	s0,sp,48
    8000304a:	892a                	mv	s2,a0
    8000304c:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000304e:	00017497          	auipc	s1,0x17
    80003052:	19248493          	addi	s1,s1,402 # 8001a1e0 <log>
    80003056:	00004597          	auipc	a1,0x4
    8000305a:	46258593          	addi	a1,a1,1122 # 800074b8 <etext+0x4b8>
    8000305e:	8526                	mv	a0,s1
    80003060:	7ea020ef          	jal	8000584a <initlock>
  log.start = sb->logstart;
    80003064:	0149a583          	lw	a1,20(s3)
    80003068:	cc8c                	sw	a1,24(s1)
  log.dev = dev;
    8000306a:	0324a223          	sw	s2,36(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000306e:	854a                	mv	a0,s2
    80003070:	f95fe0ef          	jal	80002004 <bread>
  log.lh.n = lh->n;
    80003074:	4d30                	lw	a2,88(a0)
    80003076:	d490                	sw	a2,40(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003078:	00c05f63          	blez	a2,80003096 <initlog+0x5a>
    8000307c:	87aa                	mv	a5,a0
    8000307e:	00017717          	auipc	a4,0x17
    80003082:	18e70713          	addi	a4,a4,398 # 8001a20c <log+0x2c>
    80003086:	060a                	slli	a2,a2,0x2
    80003088:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    8000308a:	4ff4                	lw	a3,92(a5)
    8000308c:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000308e:	0791                	addi	a5,a5,4
    80003090:	0711                	addi	a4,a4,4
    80003092:	fec79ce3          	bne	a5,a2,8000308a <initlog+0x4e>
  brelse(buf);
    80003096:	876ff0ef          	jal	8000210c <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000309a:	4505                	li	a0,1
    8000309c:	edbff0ef          	jal	80002f76 <install_trans>
  log.lh.n = 0;
    800030a0:	00017797          	auipc	a5,0x17
    800030a4:	1607a423          	sw	zero,360(a5) # 8001a208 <log+0x28>
  write_head(); // clear the log
    800030a8:	e71ff0ef          	jal	80002f18 <write_head>
}
    800030ac:	70a2                	ld	ra,40(sp)
    800030ae:	7402                	ld	s0,32(sp)
    800030b0:	64e2                	ld	s1,24(sp)
    800030b2:	6942                	ld	s2,16(sp)
    800030b4:	69a2                	ld	s3,8(sp)
    800030b6:	6145                	addi	sp,sp,48
    800030b8:	8082                	ret

00000000800030ba <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800030ba:	1101                	addi	sp,sp,-32
    800030bc:	ec06                	sd	ra,24(sp)
    800030be:	e822                	sd	s0,16(sp)
    800030c0:	e426                	sd	s1,8(sp)
    800030c2:	e04a                	sd	s2,0(sp)
    800030c4:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800030c6:	00017517          	auipc	a0,0x17
    800030ca:	11a50513          	addi	a0,a0,282 # 8001a1e0 <log>
    800030ce:	7fc020ef          	jal	800058ca <acquire>
  while(1){
    if(log.committing){
    800030d2:	00017497          	auipc	s1,0x17
    800030d6:	10e48493          	addi	s1,s1,270 # 8001a1e0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    800030da:	4979                	li	s2,30
    800030dc:	a029                	j	800030e6 <begin_op+0x2c>
      sleep(&log, &log.lock);
    800030de:	85a6                	mv	a1,s1
    800030e0:	8526                	mv	a0,s1
    800030e2:	a90fe0ef          	jal	80001372 <sleep>
    if(log.committing){
    800030e6:	509c                	lw	a5,32(s1)
    800030e8:	fbfd                	bnez	a5,800030de <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    800030ea:	4cd8                	lw	a4,28(s1)
    800030ec:	2705                	addiw	a4,a4,1
    800030ee:	0027179b          	slliw	a5,a4,0x2
    800030f2:	9fb9                	addw	a5,a5,a4
    800030f4:	0017979b          	slliw	a5,a5,0x1
    800030f8:	5494                	lw	a3,40(s1)
    800030fa:	9fb5                	addw	a5,a5,a3
    800030fc:	00f95763          	bge	s2,a5,8000310a <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003100:	85a6                	mv	a1,s1
    80003102:	8526                	mv	a0,s1
    80003104:	a6efe0ef          	jal	80001372 <sleep>
    80003108:	bff9                	j	800030e6 <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    8000310a:	00017517          	auipc	a0,0x17
    8000310e:	0d650513          	addi	a0,a0,214 # 8001a1e0 <log>
    80003112:	cd58                	sw	a4,28(a0)
      release(&log.lock);
    80003114:	04f020ef          	jal	80005962 <release>
      break;
    }
  }
}
    80003118:	60e2                	ld	ra,24(sp)
    8000311a:	6442                	ld	s0,16(sp)
    8000311c:	64a2                	ld	s1,8(sp)
    8000311e:	6902                	ld	s2,0(sp)
    80003120:	6105                	addi	sp,sp,32
    80003122:	8082                	ret

0000000080003124 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003124:	7139                	addi	sp,sp,-64
    80003126:	fc06                	sd	ra,56(sp)
    80003128:	f822                	sd	s0,48(sp)
    8000312a:	f426                	sd	s1,40(sp)
    8000312c:	f04a                	sd	s2,32(sp)
    8000312e:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003130:	00017497          	auipc	s1,0x17
    80003134:	0b048493          	addi	s1,s1,176 # 8001a1e0 <log>
    80003138:	8526                	mv	a0,s1
    8000313a:	790020ef          	jal	800058ca <acquire>
  log.outstanding -= 1;
    8000313e:	4cdc                	lw	a5,28(s1)
    80003140:	37fd                	addiw	a5,a5,-1
    80003142:	0007891b          	sext.w	s2,a5
    80003146:	ccdc                	sw	a5,28(s1)
  if(log.committing)
    80003148:	509c                	lw	a5,32(s1)
    8000314a:	ef9d                	bnez	a5,80003188 <end_op+0x64>
    panic("log.committing");
  if(log.outstanding == 0){
    8000314c:	04091763          	bnez	s2,8000319a <end_op+0x76>
    do_commit = 1;
    log.committing = 1;
    80003150:	00017497          	auipc	s1,0x17
    80003154:	09048493          	addi	s1,s1,144 # 8001a1e0 <log>
    80003158:	4785                	li	a5,1
    8000315a:	d09c                	sw	a5,32(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    8000315c:	8526                	mv	a0,s1
    8000315e:	005020ef          	jal	80005962 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003162:	549c                	lw	a5,40(s1)
    80003164:	04f04b63          	bgtz	a5,800031ba <end_op+0x96>
    acquire(&log.lock);
    80003168:	00017497          	auipc	s1,0x17
    8000316c:	07848493          	addi	s1,s1,120 # 8001a1e0 <log>
    80003170:	8526                	mv	a0,s1
    80003172:	758020ef          	jal	800058ca <acquire>
    log.committing = 0;
    80003176:	0204a023          	sw	zero,32(s1)
    wakeup(&log);
    8000317a:	8526                	mv	a0,s1
    8000317c:	a42fe0ef          	jal	800013be <wakeup>
    release(&log.lock);
    80003180:	8526                	mv	a0,s1
    80003182:	7e0020ef          	jal	80005962 <release>
}
    80003186:	a025                	j	800031ae <end_op+0x8a>
    80003188:	ec4e                	sd	s3,24(sp)
    8000318a:	e852                	sd	s4,16(sp)
    8000318c:	e456                	sd	s5,8(sp)
    panic("log.committing");
    8000318e:	00004517          	auipc	a0,0x4
    80003192:	33250513          	addi	a0,a0,818 # 800074c0 <etext+0x4c0>
    80003196:	478020ef          	jal	8000560e <panic>
    wakeup(&log);
    8000319a:	00017497          	auipc	s1,0x17
    8000319e:	04648493          	addi	s1,s1,70 # 8001a1e0 <log>
    800031a2:	8526                	mv	a0,s1
    800031a4:	a1afe0ef          	jal	800013be <wakeup>
  release(&log.lock);
    800031a8:	8526                	mv	a0,s1
    800031aa:	7b8020ef          	jal	80005962 <release>
}
    800031ae:	70e2                	ld	ra,56(sp)
    800031b0:	7442                	ld	s0,48(sp)
    800031b2:	74a2                	ld	s1,40(sp)
    800031b4:	7902                	ld	s2,32(sp)
    800031b6:	6121                	addi	sp,sp,64
    800031b8:	8082                	ret
    800031ba:	ec4e                	sd	s3,24(sp)
    800031bc:	e852                	sd	s4,16(sp)
    800031be:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    800031c0:	00017a97          	auipc	s5,0x17
    800031c4:	04ca8a93          	addi	s5,s5,76 # 8001a20c <log+0x2c>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800031c8:	00017a17          	auipc	s4,0x17
    800031cc:	018a0a13          	addi	s4,s4,24 # 8001a1e0 <log>
    800031d0:	018a2583          	lw	a1,24(s4)
    800031d4:	012585bb          	addw	a1,a1,s2
    800031d8:	2585                	addiw	a1,a1,1
    800031da:	024a2503          	lw	a0,36(s4)
    800031de:	e27fe0ef          	jal	80002004 <bread>
    800031e2:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800031e4:	000aa583          	lw	a1,0(s5)
    800031e8:	024a2503          	lw	a0,36(s4)
    800031ec:	e19fe0ef          	jal	80002004 <bread>
    800031f0:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800031f2:	40000613          	li	a2,1024
    800031f6:	05850593          	addi	a1,a0,88
    800031fa:	05848513          	addi	a0,s1,88
    800031fe:	fadfc0ef          	jal	800001aa <memmove>
    bwrite(to);  // write the log
    80003202:	8526                	mv	a0,s1
    80003204:	ed7fe0ef          	jal	800020da <bwrite>
    brelse(from);
    80003208:	854e                	mv	a0,s3
    8000320a:	f03fe0ef          	jal	8000210c <brelse>
    brelse(to);
    8000320e:	8526                	mv	a0,s1
    80003210:	efdfe0ef          	jal	8000210c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003214:	2905                	addiw	s2,s2,1
    80003216:	0a91                	addi	s5,s5,4
    80003218:	028a2783          	lw	a5,40(s4)
    8000321c:	faf94ae3          	blt	s2,a5,800031d0 <end_op+0xac>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003220:	cf9ff0ef          	jal	80002f18 <write_head>
    install_trans(0); // Now install writes to home locations
    80003224:	4501                	li	a0,0
    80003226:	d51ff0ef          	jal	80002f76 <install_trans>
    log.lh.n = 0;
    8000322a:	00017797          	auipc	a5,0x17
    8000322e:	fc07af23          	sw	zero,-34(a5) # 8001a208 <log+0x28>
    write_head();    // Erase the transaction from the log
    80003232:	ce7ff0ef          	jal	80002f18 <write_head>
    80003236:	69e2                	ld	s3,24(sp)
    80003238:	6a42                	ld	s4,16(sp)
    8000323a:	6aa2                	ld	s5,8(sp)
    8000323c:	b735                	j	80003168 <end_op+0x44>

000000008000323e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000323e:	1101                	addi	sp,sp,-32
    80003240:	ec06                	sd	ra,24(sp)
    80003242:	e822                	sd	s0,16(sp)
    80003244:	e426                	sd	s1,8(sp)
    80003246:	e04a                	sd	s2,0(sp)
    80003248:	1000                	addi	s0,sp,32
    8000324a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000324c:	00017917          	auipc	s2,0x17
    80003250:	f9490913          	addi	s2,s2,-108 # 8001a1e0 <log>
    80003254:	854a                	mv	a0,s2
    80003256:	674020ef          	jal	800058ca <acquire>
  if (log.lh.n >= LOGBLOCKS)
    8000325a:	02892603          	lw	a2,40(s2)
    8000325e:	47f5                	li	a5,29
    80003260:	04c7cc63          	blt	a5,a2,800032b8 <log_write+0x7a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003264:	00017797          	auipc	a5,0x17
    80003268:	f987a783          	lw	a5,-104(a5) # 8001a1fc <log+0x1c>
    8000326c:	04f05c63          	blez	a5,800032c4 <log_write+0x86>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003270:	4781                	li	a5,0
    80003272:	04c05f63          	blez	a2,800032d0 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003276:	44cc                	lw	a1,12(s1)
    80003278:	00017717          	auipc	a4,0x17
    8000327c:	f9470713          	addi	a4,a4,-108 # 8001a20c <log+0x2c>
  for (i = 0; i < log.lh.n; i++) {
    80003280:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003282:	4314                	lw	a3,0(a4)
    80003284:	04b68663          	beq	a3,a1,800032d0 <log_write+0x92>
  for (i = 0; i < log.lh.n; i++) {
    80003288:	2785                	addiw	a5,a5,1
    8000328a:	0711                	addi	a4,a4,4
    8000328c:	fef61be3          	bne	a2,a5,80003282 <log_write+0x44>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003290:	0621                	addi	a2,a2,8
    80003292:	060a                	slli	a2,a2,0x2
    80003294:	00017797          	auipc	a5,0x17
    80003298:	f4c78793          	addi	a5,a5,-180 # 8001a1e0 <log>
    8000329c:	97b2                	add	a5,a5,a2
    8000329e:	44d8                	lw	a4,12(s1)
    800032a0:	c7d8                	sw	a4,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800032a2:	8526                	mv	a0,s1
    800032a4:	ef1fe0ef          	jal	80002194 <bpin>
    log.lh.n++;
    800032a8:	00017717          	auipc	a4,0x17
    800032ac:	f3870713          	addi	a4,a4,-200 # 8001a1e0 <log>
    800032b0:	571c                	lw	a5,40(a4)
    800032b2:	2785                	addiw	a5,a5,1
    800032b4:	d71c                	sw	a5,40(a4)
    800032b6:	a80d                	j	800032e8 <log_write+0xaa>
    panic("too big a transaction");
    800032b8:	00004517          	auipc	a0,0x4
    800032bc:	21850513          	addi	a0,a0,536 # 800074d0 <etext+0x4d0>
    800032c0:	34e020ef          	jal	8000560e <panic>
    panic("log_write outside of trans");
    800032c4:	00004517          	auipc	a0,0x4
    800032c8:	22450513          	addi	a0,a0,548 # 800074e8 <etext+0x4e8>
    800032cc:	342020ef          	jal	8000560e <panic>
  log.lh.block[i] = b->blockno;
    800032d0:	00878693          	addi	a3,a5,8
    800032d4:	068a                	slli	a3,a3,0x2
    800032d6:	00017717          	auipc	a4,0x17
    800032da:	f0a70713          	addi	a4,a4,-246 # 8001a1e0 <log>
    800032de:	9736                	add	a4,a4,a3
    800032e0:	44d4                	lw	a3,12(s1)
    800032e2:	c754                	sw	a3,12(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800032e4:	faf60fe3          	beq	a2,a5,800032a2 <log_write+0x64>
  }
  release(&log.lock);
    800032e8:	00017517          	auipc	a0,0x17
    800032ec:	ef850513          	addi	a0,a0,-264 # 8001a1e0 <log>
    800032f0:	672020ef          	jal	80005962 <release>
}
    800032f4:	60e2                	ld	ra,24(sp)
    800032f6:	6442                	ld	s0,16(sp)
    800032f8:	64a2                	ld	s1,8(sp)
    800032fa:	6902                	ld	s2,0(sp)
    800032fc:	6105                	addi	sp,sp,32
    800032fe:	8082                	ret

0000000080003300 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003300:	1101                	addi	sp,sp,-32
    80003302:	ec06                	sd	ra,24(sp)
    80003304:	e822                	sd	s0,16(sp)
    80003306:	e426                	sd	s1,8(sp)
    80003308:	e04a                	sd	s2,0(sp)
    8000330a:	1000                	addi	s0,sp,32
    8000330c:	84aa                	mv	s1,a0
    8000330e:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003310:	00004597          	auipc	a1,0x4
    80003314:	1f858593          	addi	a1,a1,504 # 80007508 <etext+0x508>
    80003318:	0521                	addi	a0,a0,8
    8000331a:	530020ef          	jal	8000584a <initlock>
  lk->name = name;
    8000331e:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003322:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003326:	0204a423          	sw	zero,40(s1)
}
    8000332a:	60e2                	ld	ra,24(sp)
    8000332c:	6442                	ld	s0,16(sp)
    8000332e:	64a2                	ld	s1,8(sp)
    80003330:	6902                	ld	s2,0(sp)
    80003332:	6105                	addi	sp,sp,32
    80003334:	8082                	ret

0000000080003336 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003336:	1101                	addi	sp,sp,-32
    80003338:	ec06                	sd	ra,24(sp)
    8000333a:	e822                	sd	s0,16(sp)
    8000333c:	e426                	sd	s1,8(sp)
    8000333e:	e04a                	sd	s2,0(sp)
    80003340:	1000                	addi	s0,sp,32
    80003342:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003344:	00850913          	addi	s2,a0,8
    80003348:	854a                	mv	a0,s2
    8000334a:	580020ef          	jal	800058ca <acquire>
  while (lk->locked) {
    8000334e:	409c                	lw	a5,0(s1)
    80003350:	c799                	beqz	a5,8000335e <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    80003352:	85ca                	mv	a1,s2
    80003354:	8526                	mv	a0,s1
    80003356:	81cfe0ef          	jal	80001372 <sleep>
  while (lk->locked) {
    8000335a:	409c                	lw	a5,0(s1)
    8000335c:	fbfd                	bnez	a5,80003352 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    8000335e:	4785                	li	a5,1
    80003360:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003362:	a19fd0ef          	jal	80000d7a <myproc>
    80003366:	591c                	lw	a5,48(a0)
    80003368:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000336a:	854a                	mv	a0,s2
    8000336c:	5f6020ef          	jal	80005962 <release>
}
    80003370:	60e2                	ld	ra,24(sp)
    80003372:	6442                	ld	s0,16(sp)
    80003374:	64a2                	ld	s1,8(sp)
    80003376:	6902                	ld	s2,0(sp)
    80003378:	6105                	addi	sp,sp,32
    8000337a:	8082                	ret

000000008000337c <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000337c:	1101                	addi	sp,sp,-32
    8000337e:	ec06                	sd	ra,24(sp)
    80003380:	e822                	sd	s0,16(sp)
    80003382:	e426                	sd	s1,8(sp)
    80003384:	e04a                	sd	s2,0(sp)
    80003386:	1000                	addi	s0,sp,32
    80003388:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000338a:	00850913          	addi	s2,a0,8
    8000338e:	854a                	mv	a0,s2
    80003390:	53a020ef          	jal	800058ca <acquire>
  lk->locked = 0;
    80003394:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003398:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    8000339c:	8526                	mv	a0,s1
    8000339e:	820fe0ef          	jal	800013be <wakeup>
  release(&lk->lk);
    800033a2:	854a                	mv	a0,s2
    800033a4:	5be020ef          	jal	80005962 <release>
}
    800033a8:	60e2                	ld	ra,24(sp)
    800033aa:	6442                	ld	s0,16(sp)
    800033ac:	64a2                	ld	s1,8(sp)
    800033ae:	6902                	ld	s2,0(sp)
    800033b0:	6105                	addi	sp,sp,32
    800033b2:	8082                	ret

00000000800033b4 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800033b4:	7179                	addi	sp,sp,-48
    800033b6:	f406                	sd	ra,40(sp)
    800033b8:	f022                	sd	s0,32(sp)
    800033ba:	ec26                	sd	s1,24(sp)
    800033bc:	e84a                	sd	s2,16(sp)
    800033be:	1800                	addi	s0,sp,48
    800033c0:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800033c2:	00850913          	addi	s2,a0,8
    800033c6:	854a                	mv	a0,s2
    800033c8:	502020ef          	jal	800058ca <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800033cc:	409c                	lw	a5,0(s1)
    800033ce:	ef81                	bnez	a5,800033e6 <holdingsleep+0x32>
    800033d0:	4481                	li	s1,0
  release(&lk->lk);
    800033d2:	854a                	mv	a0,s2
    800033d4:	58e020ef          	jal	80005962 <release>
  return r;
}
    800033d8:	8526                	mv	a0,s1
    800033da:	70a2                	ld	ra,40(sp)
    800033dc:	7402                	ld	s0,32(sp)
    800033de:	64e2                	ld	s1,24(sp)
    800033e0:	6942                	ld	s2,16(sp)
    800033e2:	6145                	addi	sp,sp,48
    800033e4:	8082                	ret
    800033e6:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    800033e8:	0284a983          	lw	s3,40(s1)
    800033ec:	98ffd0ef          	jal	80000d7a <myproc>
    800033f0:	5904                	lw	s1,48(a0)
    800033f2:	413484b3          	sub	s1,s1,s3
    800033f6:	0014b493          	seqz	s1,s1
    800033fa:	69a2                	ld	s3,8(sp)
    800033fc:	bfd9                	j	800033d2 <holdingsleep+0x1e>

00000000800033fe <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800033fe:	1141                	addi	sp,sp,-16
    80003400:	e406                	sd	ra,8(sp)
    80003402:	e022                	sd	s0,0(sp)
    80003404:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003406:	00004597          	auipc	a1,0x4
    8000340a:	11258593          	addi	a1,a1,274 # 80007518 <etext+0x518>
    8000340e:	00017517          	auipc	a0,0x17
    80003412:	f1a50513          	addi	a0,a0,-230 # 8001a328 <ftable>
    80003416:	434020ef          	jal	8000584a <initlock>
}
    8000341a:	60a2                	ld	ra,8(sp)
    8000341c:	6402                	ld	s0,0(sp)
    8000341e:	0141                	addi	sp,sp,16
    80003420:	8082                	ret

0000000080003422 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003422:	1101                	addi	sp,sp,-32
    80003424:	ec06                	sd	ra,24(sp)
    80003426:	e822                	sd	s0,16(sp)
    80003428:	e426                	sd	s1,8(sp)
    8000342a:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000342c:	00017517          	auipc	a0,0x17
    80003430:	efc50513          	addi	a0,a0,-260 # 8001a328 <ftable>
    80003434:	496020ef          	jal	800058ca <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003438:	00017497          	auipc	s1,0x17
    8000343c:	f0848493          	addi	s1,s1,-248 # 8001a340 <ftable+0x18>
    80003440:	00018717          	auipc	a4,0x18
    80003444:	ea070713          	addi	a4,a4,-352 # 8001b2e0 <disk>
    if(f->ref == 0){
    80003448:	40dc                	lw	a5,4(s1)
    8000344a:	cf89                	beqz	a5,80003464 <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000344c:	02848493          	addi	s1,s1,40
    80003450:	fee49ce3          	bne	s1,a4,80003448 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003454:	00017517          	auipc	a0,0x17
    80003458:	ed450513          	addi	a0,a0,-300 # 8001a328 <ftable>
    8000345c:	506020ef          	jal	80005962 <release>
  return 0;
    80003460:	4481                	li	s1,0
    80003462:	a809                	j	80003474 <filealloc+0x52>
      f->ref = 1;
    80003464:	4785                	li	a5,1
    80003466:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003468:	00017517          	auipc	a0,0x17
    8000346c:	ec050513          	addi	a0,a0,-320 # 8001a328 <ftable>
    80003470:	4f2020ef          	jal	80005962 <release>
}
    80003474:	8526                	mv	a0,s1
    80003476:	60e2                	ld	ra,24(sp)
    80003478:	6442                	ld	s0,16(sp)
    8000347a:	64a2                	ld	s1,8(sp)
    8000347c:	6105                	addi	sp,sp,32
    8000347e:	8082                	ret

0000000080003480 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003480:	1101                	addi	sp,sp,-32
    80003482:	ec06                	sd	ra,24(sp)
    80003484:	e822                	sd	s0,16(sp)
    80003486:	e426                	sd	s1,8(sp)
    80003488:	1000                	addi	s0,sp,32
    8000348a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000348c:	00017517          	auipc	a0,0x17
    80003490:	e9c50513          	addi	a0,a0,-356 # 8001a328 <ftable>
    80003494:	436020ef          	jal	800058ca <acquire>
  if(f->ref < 1)
    80003498:	40dc                	lw	a5,4(s1)
    8000349a:	02f05063          	blez	a5,800034ba <filedup+0x3a>
    panic("filedup");
  f->ref++;
    8000349e:	2785                	addiw	a5,a5,1
    800034a0:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800034a2:	00017517          	auipc	a0,0x17
    800034a6:	e8650513          	addi	a0,a0,-378 # 8001a328 <ftable>
    800034aa:	4b8020ef          	jal	80005962 <release>
  return f;
}
    800034ae:	8526                	mv	a0,s1
    800034b0:	60e2                	ld	ra,24(sp)
    800034b2:	6442                	ld	s0,16(sp)
    800034b4:	64a2                	ld	s1,8(sp)
    800034b6:	6105                	addi	sp,sp,32
    800034b8:	8082                	ret
    panic("filedup");
    800034ba:	00004517          	auipc	a0,0x4
    800034be:	06650513          	addi	a0,a0,102 # 80007520 <etext+0x520>
    800034c2:	14c020ef          	jal	8000560e <panic>

00000000800034c6 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800034c6:	7139                	addi	sp,sp,-64
    800034c8:	fc06                	sd	ra,56(sp)
    800034ca:	f822                	sd	s0,48(sp)
    800034cc:	f426                	sd	s1,40(sp)
    800034ce:	0080                	addi	s0,sp,64
    800034d0:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800034d2:	00017517          	auipc	a0,0x17
    800034d6:	e5650513          	addi	a0,a0,-426 # 8001a328 <ftable>
    800034da:	3f0020ef          	jal	800058ca <acquire>
  if(f->ref < 1)
    800034de:	40dc                	lw	a5,4(s1)
    800034e0:	04f05a63          	blez	a5,80003534 <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    800034e4:	37fd                	addiw	a5,a5,-1
    800034e6:	0007871b          	sext.w	a4,a5
    800034ea:	c0dc                	sw	a5,4(s1)
    800034ec:	04e04e63          	bgtz	a4,80003548 <fileclose+0x82>
    800034f0:	f04a                	sd	s2,32(sp)
    800034f2:	ec4e                	sd	s3,24(sp)
    800034f4:	e852                	sd	s4,16(sp)
    800034f6:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800034f8:	0004a903          	lw	s2,0(s1)
    800034fc:	0094ca83          	lbu	s5,9(s1)
    80003500:	0104ba03          	ld	s4,16(s1)
    80003504:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003508:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000350c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003510:	00017517          	auipc	a0,0x17
    80003514:	e1850513          	addi	a0,a0,-488 # 8001a328 <ftable>
    80003518:	44a020ef          	jal	80005962 <release>

  if(ff.type == FD_PIPE){
    8000351c:	4785                	li	a5,1
    8000351e:	04f90063          	beq	s2,a5,8000355e <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003522:	3979                	addiw	s2,s2,-2
    80003524:	4785                	li	a5,1
    80003526:	0527f563          	bgeu	a5,s2,80003570 <fileclose+0xaa>
    8000352a:	7902                	ld	s2,32(sp)
    8000352c:	69e2                	ld	s3,24(sp)
    8000352e:	6a42                	ld	s4,16(sp)
    80003530:	6aa2                	ld	s5,8(sp)
    80003532:	a00d                	j	80003554 <fileclose+0x8e>
    80003534:	f04a                	sd	s2,32(sp)
    80003536:	ec4e                	sd	s3,24(sp)
    80003538:	e852                	sd	s4,16(sp)
    8000353a:	e456                	sd	s5,8(sp)
    panic("fileclose");
    8000353c:	00004517          	auipc	a0,0x4
    80003540:	fec50513          	addi	a0,a0,-20 # 80007528 <etext+0x528>
    80003544:	0ca020ef          	jal	8000560e <panic>
    release(&ftable.lock);
    80003548:	00017517          	auipc	a0,0x17
    8000354c:	de050513          	addi	a0,a0,-544 # 8001a328 <ftable>
    80003550:	412020ef          	jal	80005962 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003554:	70e2                	ld	ra,56(sp)
    80003556:	7442                	ld	s0,48(sp)
    80003558:	74a2                	ld	s1,40(sp)
    8000355a:	6121                	addi	sp,sp,64
    8000355c:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000355e:	85d6                	mv	a1,s5
    80003560:	8552                	mv	a0,s4
    80003562:	336000ef          	jal	80003898 <pipeclose>
    80003566:	7902                	ld	s2,32(sp)
    80003568:	69e2                	ld	s3,24(sp)
    8000356a:	6a42                	ld	s4,16(sp)
    8000356c:	6aa2                	ld	s5,8(sp)
    8000356e:	b7dd                	j	80003554 <fileclose+0x8e>
    begin_op();
    80003570:	b4bff0ef          	jal	800030ba <begin_op>
    iput(ff.ip);
    80003574:	854e                	mv	a0,s3
    80003576:	adcff0ef          	jal	80002852 <iput>
    end_op();
    8000357a:	babff0ef          	jal	80003124 <end_op>
    8000357e:	7902                	ld	s2,32(sp)
    80003580:	69e2                	ld	s3,24(sp)
    80003582:	6a42                	ld	s4,16(sp)
    80003584:	6aa2                	ld	s5,8(sp)
    80003586:	b7f9                	j	80003554 <fileclose+0x8e>

0000000080003588 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003588:	715d                	addi	sp,sp,-80
    8000358a:	e486                	sd	ra,72(sp)
    8000358c:	e0a2                	sd	s0,64(sp)
    8000358e:	fc26                	sd	s1,56(sp)
    80003590:	f44e                	sd	s3,40(sp)
    80003592:	0880                	addi	s0,sp,80
    80003594:	84aa                	mv	s1,a0
    80003596:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003598:	fe2fd0ef          	jal	80000d7a <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000359c:	409c                	lw	a5,0(s1)
    8000359e:	37f9                	addiw	a5,a5,-2
    800035a0:	4705                	li	a4,1
    800035a2:	04f76063          	bltu	a4,a5,800035e2 <filestat+0x5a>
    800035a6:	f84a                	sd	s2,48(sp)
    800035a8:	892a                	mv	s2,a0
    ilock(f->ip);
    800035aa:	6c88                	ld	a0,24(s1)
    800035ac:	924ff0ef          	jal	800026d0 <ilock>
    stati(f->ip, &st);
    800035b0:	fb840593          	addi	a1,s0,-72
    800035b4:	6c88                	ld	a0,24(s1)
    800035b6:	c80ff0ef          	jal	80002a36 <stati>
    iunlock(f->ip);
    800035ba:	6c88                	ld	a0,24(s1)
    800035bc:	9c2ff0ef          	jal	8000277e <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800035c0:	46e1                	li	a3,24
    800035c2:	fb840613          	addi	a2,s0,-72
    800035c6:	85ce                	mv	a1,s3
    800035c8:	05093503          	ld	a0,80(s2)
    800035cc:	cc2fd0ef          	jal	80000a8e <copyout>
    800035d0:	41f5551b          	sraiw	a0,a0,0x1f
    800035d4:	7942                	ld	s2,48(sp)
      return -1;
    return 0;
  }
  return -1;
}
    800035d6:	60a6                	ld	ra,72(sp)
    800035d8:	6406                	ld	s0,64(sp)
    800035da:	74e2                	ld	s1,56(sp)
    800035dc:	79a2                	ld	s3,40(sp)
    800035de:	6161                	addi	sp,sp,80
    800035e0:	8082                	ret
  return -1;
    800035e2:	557d                	li	a0,-1
    800035e4:	bfcd                	j	800035d6 <filestat+0x4e>

00000000800035e6 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800035e6:	7179                	addi	sp,sp,-48
    800035e8:	f406                	sd	ra,40(sp)
    800035ea:	f022                	sd	s0,32(sp)
    800035ec:	e84a                	sd	s2,16(sp)
    800035ee:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800035f0:	00854783          	lbu	a5,8(a0)
    800035f4:	cfd1                	beqz	a5,80003690 <fileread+0xaa>
    800035f6:	ec26                	sd	s1,24(sp)
    800035f8:	e44e                	sd	s3,8(sp)
    800035fa:	84aa                	mv	s1,a0
    800035fc:	89ae                	mv	s3,a1
    800035fe:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003600:	411c                	lw	a5,0(a0)
    80003602:	4705                	li	a4,1
    80003604:	04e78363          	beq	a5,a4,8000364a <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003608:	470d                	li	a4,3
    8000360a:	04e78763          	beq	a5,a4,80003658 <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000360e:	4709                	li	a4,2
    80003610:	06e79a63          	bne	a5,a4,80003684 <fileread+0x9e>
    ilock(f->ip);
    80003614:	6d08                	ld	a0,24(a0)
    80003616:	8baff0ef          	jal	800026d0 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000361a:	874a                	mv	a4,s2
    8000361c:	5094                	lw	a3,32(s1)
    8000361e:	864e                	mv	a2,s3
    80003620:	4585                	li	a1,1
    80003622:	6c88                	ld	a0,24(s1)
    80003624:	c3cff0ef          	jal	80002a60 <readi>
    80003628:	892a                	mv	s2,a0
    8000362a:	00a05563          	blez	a0,80003634 <fileread+0x4e>
      f->off += r;
    8000362e:	509c                	lw	a5,32(s1)
    80003630:	9fa9                	addw	a5,a5,a0
    80003632:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003634:	6c88                	ld	a0,24(s1)
    80003636:	948ff0ef          	jal	8000277e <iunlock>
    8000363a:	64e2                	ld	s1,24(sp)
    8000363c:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    8000363e:	854a                	mv	a0,s2
    80003640:	70a2                	ld	ra,40(sp)
    80003642:	7402                	ld	s0,32(sp)
    80003644:	6942                	ld	s2,16(sp)
    80003646:	6145                	addi	sp,sp,48
    80003648:	8082                	ret
    r = piperead(f->pipe, addr, n);
    8000364a:	6908                	ld	a0,16(a0)
    8000364c:	388000ef          	jal	800039d4 <piperead>
    80003650:	892a                	mv	s2,a0
    80003652:	64e2                	ld	s1,24(sp)
    80003654:	69a2                	ld	s3,8(sp)
    80003656:	b7e5                	j	8000363e <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003658:	02451783          	lh	a5,36(a0)
    8000365c:	03079693          	slli	a3,a5,0x30
    80003660:	92c1                	srli	a3,a3,0x30
    80003662:	4725                	li	a4,9
    80003664:	02d76863          	bltu	a4,a3,80003694 <fileread+0xae>
    80003668:	0792                	slli	a5,a5,0x4
    8000366a:	00017717          	auipc	a4,0x17
    8000366e:	c1e70713          	addi	a4,a4,-994 # 8001a288 <devsw>
    80003672:	97ba                	add	a5,a5,a4
    80003674:	639c                	ld	a5,0(a5)
    80003676:	c39d                	beqz	a5,8000369c <fileread+0xb6>
    r = devsw[f->major].read(1, addr, n);
    80003678:	4505                	li	a0,1
    8000367a:	9782                	jalr	a5
    8000367c:	892a                	mv	s2,a0
    8000367e:	64e2                	ld	s1,24(sp)
    80003680:	69a2                	ld	s3,8(sp)
    80003682:	bf75                	j	8000363e <fileread+0x58>
    panic("fileread");
    80003684:	00004517          	auipc	a0,0x4
    80003688:	eb450513          	addi	a0,a0,-332 # 80007538 <etext+0x538>
    8000368c:	783010ef          	jal	8000560e <panic>
    return -1;
    80003690:	597d                	li	s2,-1
    80003692:	b775                	j	8000363e <fileread+0x58>
      return -1;
    80003694:	597d                	li	s2,-1
    80003696:	64e2                	ld	s1,24(sp)
    80003698:	69a2                	ld	s3,8(sp)
    8000369a:	b755                	j	8000363e <fileread+0x58>
    8000369c:	597d                	li	s2,-1
    8000369e:	64e2                	ld	s1,24(sp)
    800036a0:	69a2                	ld	s3,8(sp)
    800036a2:	bf71                	j	8000363e <fileread+0x58>

00000000800036a4 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    800036a4:	00954783          	lbu	a5,9(a0)
    800036a8:	10078b63          	beqz	a5,800037be <filewrite+0x11a>
{
    800036ac:	715d                	addi	sp,sp,-80
    800036ae:	e486                	sd	ra,72(sp)
    800036b0:	e0a2                	sd	s0,64(sp)
    800036b2:	f84a                	sd	s2,48(sp)
    800036b4:	f052                	sd	s4,32(sp)
    800036b6:	e85a                	sd	s6,16(sp)
    800036b8:	0880                	addi	s0,sp,80
    800036ba:	892a                	mv	s2,a0
    800036bc:	8b2e                	mv	s6,a1
    800036be:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800036c0:	411c                	lw	a5,0(a0)
    800036c2:	4705                	li	a4,1
    800036c4:	02e78763          	beq	a5,a4,800036f2 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800036c8:	470d                	li	a4,3
    800036ca:	02e78863          	beq	a5,a4,800036fa <filewrite+0x56>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800036ce:	4709                	li	a4,2
    800036d0:	0ce79c63          	bne	a5,a4,800037a8 <filewrite+0x104>
    800036d4:	f44e                	sd	s3,40(sp)
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800036d6:	0ac05863          	blez	a2,80003786 <filewrite+0xe2>
    800036da:	fc26                	sd	s1,56(sp)
    800036dc:	ec56                	sd	s5,24(sp)
    800036de:	e45e                	sd	s7,8(sp)
    800036e0:	e062                	sd	s8,0(sp)
    int i = 0;
    800036e2:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    800036e4:	6b85                	lui	s7,0x1
    800036e6:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    800036ea:	6c05                	lui	s8,0x1
    800036ec:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    800036f0:	a8b5                	j	8000376c <filewrite+0xc8>
    ret = pipewrite(f->pipe, addr, n);
    800036f2:	6908                	ld	a0,16(a0)
    800036f4:	1fc000ef          	jal	800038f0 <pipewrite>
    800036f8:	a04d                	j	8000379a <filewrite+0xf6>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800036fa:	02451783          	lh	a5,36(a0)
    800036fe:	03079693          	slli	a3,a5,0x30
    80003702:	92c1                	srli	a3,a3,0x30
    80003704:	4725                	li	a4,9
    80003706:	0ad76e63          	bltu	a4,a3,800037c2 <filewrite+0x11e>
    8000370a:	0792                	slli	a5,a5,0x4
    8000370c:	00017717          	auipc	a4,0x17
    80003710:	b7c70713          	addi	a4,a4,-1156 # 8001a288 <devsw>
    80003714:	97ba                	add	a5,a5,a4
    80003716:	679c                	ld	a5,8(a5)
    80003718:	c7dd                	beqz	a5,800037c6 <filewrite+0x122>
    ret = devsw[f->major].write(1, addr, n);
    8000371a:	4505                	li	a0,1
    8000371c:	9782                	jalr	a5
    8000371e:	a8b5                	j	8000379a <filewrite+0xf6>
      if(n1 > max)
    80003720:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80003724:	997ff0ef          	jal	800030ba <begin_op>
      ilock(f->ip);
    80003728:	01893503          	ld	a0,24(s2)
    8000372c:	fa5fe0ef          	jal	800026d0 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003730:	8756                	mv	a4,s5
    80003732:	02092683          	lw	a3,32(s2)
    80003736:	01698633          	add	a2,s3,s6
    8000373a:	4585                	li	a1,1
    8000373c:	01893503          	ld	a0,24(s2)
    80003740:	c1cff0ef          	jal	80002b5c <writei>
    80003744:	84aa                	mv	s1,a0
    80003746:	00a05763          	blez	a0,80003754 <filewrite+0xb0>
        f->off += r;
    8000374a:	02092783          	lw	a5,32(s2)
    8000374e:	9fa9                	addw	a5,a5,a0
    80003750:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003754:	01893503          	ld	a0,24(s2)
    80003758:	826ff0ef          	jal	8000277e <iunlock>
      end_op();
    8000375c:	9c9ff0ef          	jal	80003124 <end_op>

      if(r != n1){
    80003760:	029a9563          	bne	s5,s1,8000378a <filewrite+0xe6>
        // error from writei
        break;
      }
      i += r;
    80003764:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003768:	0149da63          	bge	s3,s4,8000377c <filewrite+0xd8>
      int n1 = n - i;
    8000376c:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80003770:	0004879b          	sext.w	a5,s1
    80003774:	fafbd6e3          	bge	s7,a5,80003720 <filewrite+0x7c>
    80003778:	84e2                	mv	s1,s8
    8000377a:	b75d                	j	80003720 <filewrite+0x7c>
    8000377c:	74e2                	ld	s1,56(sp)
    8000377e:	6ae2                	ld	s5,24(sp)
    80003780:	6ba2                	ld	s7,8(sp)
    80003782:	6c02                	ld	s8,0(sp)
    80003784:	a039                	j	80003792 <filewrite+0xee>
    int i = 0;
    80003786:	4981                	li	s3,0
    80003788:	a029                	j	80003792 <filewrite+0xee>
    8000378a:	74e2                	ld	s1,56(sp)
    8000378c:	6ae2                	ld	s5,24(sp)
    8000378e:	6ba2                	ld	s7,8(sp)
    80003790:	6c02                	ld	s8,0(sp)
    }
    ret = (i == n ? n : -1);
    80003792:	033a1c63          	bne	s4,s3,800037ca <filewrite+0x126>
    80003796:	8552                	mv	a0,s4
    80003798:	79a2                	ld	s3,40(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    8000379a:	60a6                	ld	ra,72(sp)
    8000379c:	6406                	ld	s0,64(sp)
    8000379e:	7942                	ld	s2,48(sp)
    800037a0:	7a02                	ld	s4,32(sp)
    800037a2:	6b42                	ld	s6,16(sp)
    800037a4:	6161                	addi	sp,sp,80
    800037a6:	8082                	ret
    800037a8:	fc26                	sd	s1,56(sp)
    800037aa:	f44e                	sd	s3,40(sp)
    800037ac:	ec56                	sd	s5,24(sp)
    800037ae:	e45e                	sd	s7,8(sp)
    800037b0:	e062                	sd	s8,0(sp)
    panic("filewrite");
    800037b2:	00004517          	auipc	a0,0x4
    800037b6:	d9650513          	addi	a0,a0,-618 # 80007548 <etext+0x548>
    800037ba:	655010ef          	jal	8000560e <panic>
    return -1;
    800037be:	557d                	li	a0,-1
}
    800037c0:	8082                	ret
      return -1;
    800037c2:	557d                	li	a0,-1
    800037c4:	bfd9                	j	8000379a <filewrite+0xf6>
    800037c6:	557d                	li	a0,-1
    800037c8:	bfc9                	j	8000379a <filewrite+0xf6>
    ret = (i == n ? n : -1);
    800037ca:	557d                	li	a0,-1
    800037cc:	79a2                	ld	s3,40(sp)
    800037ce:	b7f1                	j	8000379a <filewrite+0xf6>

00000000800037d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800037d0:	7179                	addi	sp,sp,-48
    800037d2:	f406                	sd	ra,40(sp)
    800037d4:	f022                	sd	s0,32(sp)
    800037d6:	ec26                	sd	s1,24(sp)
    800037d8:	e052                	sd	s4,0(sp)
    800037da:	1800                	addi	s0,sp,48
    800037dc:	84aa                	mv	s1,a0
    800037de:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800037e0:	0005b023          	sd	zero,0(a1)
    800037e4:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800037e8:	c3bff0ef          	jal	80003422 <filealloc>
    800037ec:	e088                	sd	a0,0(s1)
    800037ee:	c549                	beqz	a0,80003878 <pipealloc+0xa8>
    800037f0:	c33ff0ef          	jal	80003422 <filealloc>
    800037f4:	00aa3023          	sd	a0,0(s4)
    800037f8:	cd25                	beqz	a0,80003870 <pipealloc+0xa0>
    800037fa:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800037fc:	903fc0ef          	jal	800000fe <kalloc>
    80003800:	892a                	mv	s2,a0
    80003802:	c12d                	beqz	a0,80003864 <pipealloc+0x94>
    80003804:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003806:	4985                	li	s3,1
    80003808:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    8000380c:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003810:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003814:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003818:	00004597          	auipc	a1,0x4
    8000381c:	d4058593          	addi	a1,a1,-704 # 80007558 <etext+0x558>
    80003820:	02a020ef          	jal	8000584a <initlock>
  (*f0)->type = FD_PIPE;
    80003824:	609c                	ld	a5,0(s1)
    80003826:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    8000382a:	609c                	ld	a5,0(s1)
    8000382c:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003830:	609c                	ld	a5,0(s1)
    80003832:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003836:	609c                	ld	a5,0(s1)
    80003838:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000383c:	000a3783          	ld	a5,0(s4)
    80003840:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003844:	000a3783          	ld	a5,0(s4)
    80003848:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000384c:	000a3783          	ld	a5,0(s4)
    80003850:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003854:	000a3783          	ld	a5,0(s4)
    80003858:	0127b823          	sd	s2,16(a5)
  return 0;
    8000385c:	4501                	li	a0,0
    8000385e:	6942                	ld	s2,16(sp)
    80003860:	69a2                	ld	s3,8(sp)
    80003862:	a01d                	j	80003888 <pipealloc+0xb8>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003864:	6088                	ld	a0,0(s1)
    80003866:	c119                	beqz	a0,8000386c <pipealloc+0x9c>
    80003868:	6942                	ld	s2,16(sp)
    8000386a:	a029                	j	80003874 <pipealloc+0xa4>
    8000386c:	6942                	ld	s2,16(sp)
    8000386e:	a029                	j	80003878 <pipealloc+0xa8>
    80003870:	6088                	ld	a0,0(s1)
    80003872:	c10d                	beqz	a0,80003894 <pipealloc+0xc4>
    fileclose(*f0);
    80003874:	c53ff0ef          	jal	800034c6 <fileclose>
  if(*f1)
    80003878:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000387c:	557d                	li	a0,-1
  if(*f1)
    8000387e:	c789                	beqz	a5,80003888 <pipealloc+0xb8>
    fileclose(*f1);
    80003880:	853e                	mv	a0,a5
    80003882:	c45ff0ef          	jal	800034c6 <fileclose>
  return -1;
    80003886:	557d                	li	a0,-1
}
    80003888:	70a2                	ld	ra,40(sp)
    8000388a:	7402                	ld	s0,32(sp)
    8000388c:	64e2                	ld	s1,24(sp)
    8000388e:	6a02                	ld	s4,0(sp)
    80003890:	6145                	addi	sp,sp,48
    80003892:	8082                	ret
  return -1;
    80003894:	557d                	li	a0,-1
    80003896:	bfcd                	j	80003888 <pipealloc+0xb8>

0000000080003898 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003898:	1101                	addi	sp,sp,-32
    8000389a:	ec06                	sd	ra,24(sp)
    8000389c:	e822                	sd	s0,16(sp)
    8000389e:	e426                	sd	s1,8(sp)
    800038a0:	e04a                	sd	s2,0(sp)
    800038a2:	1000                	addi	s0,sp,32
    800038a4:	84aa                	mv	s1,a0
    800038a6:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800038a8:	022020ef          	jal	800058ca <acquire>
  if(writable){
    800038ac:	02090763          	beqz	s2,800038da <pipeclose+0x42>
    pi->writeopen = 0;
    800038b0:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800038b4:	21848513          	addi	a0,s1,536
    800038b8:	b07fd0ef          	jal	800013be <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800038bc:	2204b783          	ld	a5,544(s1)
    800038c0:	e785                	bnez	a5,800038e8 <pipeclose+0x50>
    release(&pi->lock);
    800038c2:	8526                	mv	a0,s1
    800038c4:	09e020ef          	jal	80005962 <release>
    kfree((char*)pi);
    800038c8:	8526                	mv	a0,s1
    800038ca:	f52fc0ef          	jal	8000001c <kfree>
  } else
    release(&pi->lock);
}
    800038ce:	60e2                	ld	ra,24(sp)
    800038d0:	6442                	ld	s0,16(sp)
    800038d2:	64a2                	ld	s1,8(sp)
    800038d4:	6902                	ld	s2,0(sp)
    800038d6:	6105                	addi	sp,sp,32
    800038d8:	8082                	ret
    pi->readopen = 0;
    800038da:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800038de:	21c48513          	addi	a0,s1,540
    800038e2:	addfd0ef          	jal	800013be <wakeup>
    800038e6:	bfd9                	j	800038bc <pipeclose+0x24>
    release(&pi->lock);
    800038e8:	8526                	mv	a0,s1
    800038ea:	078020ef          	jal	80005962 <release>
}
    800038ee:	b7c5                	j	800038ce <pipeclose+0x36>

00000000800038f0 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800038f0:	711d                	addi	sp,sp,-96
    800038f2:	ec86                	sd	ra,88(sp)
    800038f4:	e8a2                	sd	s0,80(sp)
    800038f6:	e4a6                	sd	s1,72(sp)
    800038f8:	e0ca                	sd	s2,64(sp)
    800038fa:	fc4e                	sd	s3,56(sp)
    800038fc:	f852                	sd	s4,48(sp)
    800038fe:	f456                	sd	s5,40(sp)
    80003900:	1080                	addi	s0,sp,96
    80003902:	84aa                	mv	s1,a0
    80003904:	8aae                	mv	s5,a1
    80003906:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003908:	c72fd0ef          	jal	80000d7a <myproc>
    8000390c:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000390e:	8526                	mv	a0,s1
    80003910:	7bb010ef          	jal	800058ca <acquire>
  while(i < n){
    80003914:	0b405a63          	blez	s4,800039c8 <pipewrite+0xd8>
    80003918:	f05a                	sd	s6,32(sp)
    8000391a:	ec5e                	sd	s7,24(sp)
    8000391c:	e862                	sd	s8,16(sp)
  int i = 0;
    8000391e:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003920:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003922:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003926:	21c48b93          	addi	s7,s1,540
    8000392a:	a81d                	j	80003960 <pipewrite+0x70>
      release(&pi->lock);
    8000392c:	8526                	mv	a0,s1
    8000392e:	034020ef          	jal	80005962 <release>
      return -1;
    80003932:	597d                	li	s2,-1
    80003934:	7b02                	ld	s6,32(sp)
    80003936:	6be2                	ld	s7,24(sp)
    80003938:	6c42                	ld	s8,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000393a:	854a                	mv	a0,s2
    8000393c:	60e6                	ld	ra,88(sp)
    8000393e:	6446                	ld	s0,80(sp)
    80003940:	64a6                	ld	s1,72(sp)
    80003942:	6906                	ld	s2,64(sp)
    80003944:	79e2                	ld	s3,56(sp)
    80003946:	7a42                	ld	s4,48(sp)
    80003948:	7aa2                	ld	s5,40(sp)
    8000394a:	6125                	addi	sp,sp,96
    8000394c:	8082                	ret
      wakeup(&pi->nread);
    8000394e:	8562                	mv	a0,s8
    80003950:	a6ffd0ef          	jal	800013be <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003954:	85a6                	mv	a1,s1
    80003956:	855e                	mv	a0,s7
    80003958:	a1bfd0ef          	jal	80001372 <sleep>
  while(i < n){
    8000395c:	05495b63          	bge	s2,s4,800039b2 <pipewrite+0xc2>
    if(pi->readopen == 0 || killed(pr)){
    80003960:	2204a783          	lw	a5,544(s1)
    80003964:	d7e1                	beqz	a5,8000392c <pipewrite+0x3c>
    80003966:	854e                	mv	a0,s3
    80003968:	c43fd0ef          	jal	800015aa <killed>
    8000396c:	f161                	bnez	a0,8000392c <pipewrite+0x3c>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000396e:	2184a783          	lw	a5,536(s1)
    80003972:	21c4a703          	lw	a4,540(s1)
    80003976:	2007879b          	addiw	a5,a5,512
    8000397a:	fcf70ae3          	beq	a4,a5,8000394e <pipewrite+0x5e>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000397e:	4685                	li	a3,1
    80003980:	01590633          	add	a2,s2,s5
    80003984:	faf40593          	addi	a1,s0,-81
    80003988:	0509b503          	ld	a0,80(s3)
    8000398c:	9e6fd0ef          	jal	80000b72 <copyin>
    80003990:	03650e63          	beq	a0,s6,800039cc <pipewrite+0xdc>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003994:	21c4a783          	lw	a5,540(s1)
    80003998:	0017871b          	addiw	a4,a5,1
    8000399c:	20e4ae23          	sw	a4,540(s1)
    800039a0:	1ff7f793          	andi	a5,a5,511
    800039a4:	97a6                	add	a5,a5,s1
    800039a6:	faf44703          	lbu	a4,-81(s0)
    800039aa:	00e78c23          	sb	a4,24(a5)
      i++;
    800039ae:	2905                	addiw	s2,s2,1
    800039b0:	b775                	j	8000395c <pipewrite+0x6c>
    800039b2:	7b02                	ld	s6,32(sp)
    800039b4:	6be2                	ld	s7,24(sp)
    800039b6:	6c42                	ld	s8,16(sp)
  wakeup(&pi->nread);
    800039b8:	21848513          	addi	a0,s1,536
    800039bc:	a03fd0ef          	jal	800013be <wakeup>
  release(&pi->lock);
    800039c0:	8526                	mv	a0,s1
    800039c2:	7a1010ef          	jal	80005962 <release>
  return i;
    800039c6:	bf95                	j	8000393a <pipewrite+0x4a>
  int i = 0;
    800039c8:	4901                	li	s2,0
    800039ca:	b7fd                	j	800039b8 <pipewrite+0xc8>
    800039cc:	7b02                	ld	s6,32(sp)
    800039ce:	6be2                	ld	s7,24(sp)
    800039d0:	6c42                	ld	s8,16(sp)
    800039d2:	b7dd                	j	800039b8 <pipewrite+0xc8>

00000000800039d4 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800039d4:	715d                	addi	sp,sp,-80
    800039d6:	e486                	sd	ra,72(sp)
    800039d8:	e0a2                	sd	s0,64(sp)
    800039da:	fc26                	sd	s1,56(sp)
    800039dc:	f84a                	sd	s2,48(sp)
    800039de:	f44e                	sd	s3,40(sp)
    800039e0:	f052                	sd	s4,32(sp)
    800039e2:	ec56                	sd	s5,24(sp)
    800039e4:	0880                	addi	s0,sp,80
    800039e6:	84aa                	mv	s1,a0
    800039e8:	892e                	mv	s2,a1
    800039ea:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800039ec:	b8efd0ef          	jal	80000d7a <myproc>
    800039f0:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800039f2:	8526                	mv	a0,s1
    800039f4:	6d7010ef          	jal	800058ca <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800039f8:	2184a703          	lw	a4,536(s1)
    800039fc:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003a00:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003a04:	02f71563          	bne	a4,a5,80003a2e <piperead+0x5a>
    80003a08:	2244a783          	lw	a5,548(s1)
    80003a0c:	cb85                	beqz	a5,80003a3c <piperead+0x68>
    if(killed(pr)){
    80003a0e:	8552                	mv	a0,s4
    80003a10:	b9bfd0ef          	jal	800015aa <killed>
    80003a14:	ed19                	bnez	a0,80003a32 <piperead+0x5e>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003a16:	85a6                	mv	a1,s1
    80003a18:	854e                	mv	a0,s3
    80003a1a:	959fd0ef          	jal	80001372 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003a1e:	2184a703          	lw	a4,536(s1)
    80003a22:	21c4a783          	lw	a5,540(s1)
    80003a26:	fef701e3          	beq	a4,a5,80003a08 <piperead+0x34>
    80003a2a:	e85a                	sd	s6,16(sp)
    80003a2c:	a809                	j	80003a3e <piperead+0x6a>
    80003a2e:	e85a                	sd	s6,16(sp)
    80003a30:	a039                	j	80003a3e <piperead+0x6a>
      release(&pi->lock);
    80003a32:	8526                	mv	a0,s1
    80003a34:	72f010ef          	jal	80005962 <release>
      return -1;
    80003a38:	59fd                	li	s3,-1
    80003a3a:	a8b1                	j	80003a96 <piperead+0xc2>
    80003a3c:	e85a                	sd	s6,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a3e:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003a40:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a42:	05505263          	blez	s5,80003a86 <piperead+0xb2>
    if(pi->nread == pi->nwrite)
    80003a46:	2184a783          	lw	a5,536(s1)
    80003a4a:	21c4a703          	lw	a4,540(s1)
    80003a4e:	02f70c63          	beq	a4,a5,80003a86 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003a52:	0017871b          	addiw	a4,a5,1
    80003a56:	20e4ac23          	sw	a4,536(s1)
    80003a5a:	1ff7f793          	andi	a5,a5,511
    80003a5e:	97a6                	add	a5,a5,s1
    80003a60:	0187c783          	lbu	a5,24(a5)
    80003a64:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003a68:	4685                	li	a3,1
    80003a6a:	fbf40613          	addi	a2,s0,-65
    80003a6e:	85ca                	mv	a1,s2
    80003a70:	050a3503          	ld	a0,80(s4)
    80003a74:	81afd0ef          	jal	80000a8e <copyout>
    80003a78:	01650763          	beq	a0,s6,80003a86 <piperead+0xb2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a7c:	2985                	addiw	s3,s3,1
    80003a7e:	0905                	addi	s2,s2,1
    80003a80:	fd3a93e3          	bne	s5,s3,80003a46 <piperead+0x72>
    80003a84:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003a86:	21c48513          	addi	a0,s1,540
    80003a8a:	935fd0ef          	jal	800013be <wakeup>
  release(&pi->lock);
    80003a8e:	8526                	mv	a0,s1
    80003a90:	6d3010ef          	jal	80005962 <release>
    80003a94:	6b42                	ld	s6,16(sp)
  return i;
}
    80003a96:	854e                	mv	a0,s3
    80003a98:	60a6                	ld	ra,72(sp)
    80003a9a:	6406                	ld	s0,64(sp)
    80003a9c:	74e2                	ld	s1,56(sp)
    80003a9e:	7942                	ld	s2,48(sp)
    80003aa0:	79a2                	ld	s3,40(sp)
    80003aa2:	7a02                	ld	s4,32(sp)
    80003aa4:	6ae2                	ld	s5,24(sp)
    80003aa6:	6161                	addi	sp,sp,80
    80003aa8:	8082                	ret

0000000080003aaa <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80003aaa:	1141                	addi	sp,sp,-16
    80003aac:	e422                	sd	s0,8(sp)
    80003aae:	0800                	addi	s0,sp,16
    80003ab0:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003ab2:	8905                	andi	a0,a0,1
    80003ab4:	050e                	slli	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    80003ab6:	8b89                	andi	a5,a5,2
    80003ab8:	c399                	beqz	a5,80003abe <flags2perm+0x14>
      perm |= PTE_W;
    80003aba:	00456513          	ori	a0,a0,4
    return perm;
}
    80003abe:	6422                	ld	s0,8(sp)
    80003ac0:	0141                	addi	sp,sp,16
    80003ac2:	8082                	ret

0000000080003ac4 <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80003ac4:	df010113          	addi	sp,sp,-528
    80003ac8:	20113423          	sd	ra,520(sp)
    80003acc:	20813023          	sd	s0,512(sp)
    80003ad0:	ffa6                	sd	s1,504(sp)
    80003ad2:	fbca                	sd	s2,496(sp)
    80003ad4:	0c00                	addi	s0,sp,528
    80003ad6:	892a                	mv	s2,a0
    80003ad8:	dea43c23          	sd	a0,-520(s0)
    80003adc:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003ae0:	a9afd0ef          	jal	80000d7a <myproc>
    80003ae4:	84aa                	mv	s1,a0

  begin_op();
    80003ae6:	dd4ff0ef          	jal	800030ba <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80003aea:	854a                	mv	a0,s2
    80003aec:	bfaff0ef          	jal	80002ee6 <namei>
    80003af0:	c931                	beqz	a0,80003b44 <kexec+0x80>
    80003af2:	f3d2                	sd	s4,480(sp)
    80003af4:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003af6:	bdbfe0ef          	jal	800026d0 <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003afa:	04000713          	li	a4,64
    80003afe:	4681                	li	a3,0
    80003b00:	e5040613          	addi	a2,s0,-432
    80003b04:	4581                	li	a1,0
    80003b06:	8552                	mv	a0,s4
    80003b08:	f59fe0ef          	jal	80002a60 <readi>
    80003b0c:	04000793          	li	a5,64
    80003b10:	00f51a63          	bne	a0,a5,80003b24 <kexec+0x60>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80003b14:	e5042703          	lw	a4,-432(s0)
    80003b18:	464c47b7          	lui	a5,0x464c4
    80003b1c:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003b20:	02f70663          	beq	a4,a5,80003b4c <kexec+0x88>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003b24:	8552                	mv	a0,s4
    80003b26:	db5fe0ef          	jal	800028da <iunlockput>
    end_op();
    80003b2a:	dfaff0ef          	jal	80003124 <end_op>
  }
  return -1;
    80003b2e:	557d                	li	a0,-1
    80003b30:	7a1e                	ld	s4,480(sp)
}
    80003b32:	20813083          	ld	ra,520(sp)
    80003b36:	20013403          	ld	s0,512(sp)
    80003b3a:	74fe                	ld	s1,504(sp)
    80003b3c:	795e                	ld	s2,496(sp)
    80003b3e:	21010113          	addi	sp,sp,528
    80003b42:	8082                	ret
    end_op();
    80003b44:	de0ff0ef          	jal	80003124 <end_op>
    return -1;
    80003b48:	557d                	li	a0,-1
    80003b4a:	b7e5                	j	80003b32 <kexec+0x6e>
    80003b4c:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003b4e:	8526                	mv	a0,s1
    80003b50:	b30fd0ef          	jal	80000e80 <proc_pagetable>
    80003b54:	8b2a                	mv	s6,a0
    80003b56:	2c050b63          	beqz	a0,80003e2c <kexec+0x368>
    80003b5a:	f7ce                	sd	s3,488(sp)
    80003b5c:	efd6                	sd	s5,472(sp)
    80003b5e:	e7de                	sd	s7,456(sp)
    80003b60:	e3e2                	sd	s8,448(sp)
    80003b62:	ff66                	sd	s9,440(sp)
    80003b64:	fb6a                	sd	s10,432(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b66:	e7042d03          	lw	s10,-400(s0)
    80003b6a:	e8845783          	lhu	a5,-376(s0)
    80003b6e:	12078963          	beqz	a5,80003ca0 <kexec+0x1dc>
    80003b72:	f76e                	sd	s11,424(sp)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003b74:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b76:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80003b78:	6c85                	lui	s9,0x1
    80003b7a:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80003b7e:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003b82:	6a85                	lui	s5,0x1
    80003b84:	a085                	j	80003be4 <kexec+0x120>
      panic("loadseg: address should exist");
    80003b86:	00004517          	auipc	a0,0x4
    80003b8a:	9da50513          	addi	a0,a0,-1574 # 80007560 <etext+0x560>
    80003b8e:	281010ef          	jal	8000560e <panic>
    if(sz - i < PGSIZE)
    80003b92:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003b94:	8726                	mv	a4,s1
    80003b96:	012c06bb          	addw	a3,s8,s2
    80003b9a:	4581                	li	a1,0
    80003b9c:	8552                	mv	a0,s4
    80003b9e:	ec3fe0ef          	jal	80002a60 <readi>
    80003ba2:	2501                	sext.w	a0,a0
    80003ba4:	24a49a63          	bne	s1,a0,80003df8 <kexec+0x334>
  for(i = 0; i < sz; i += PGSIZE){
    80003ba8:	012a893b          	addw	s2,s5,s2
    80003bac:	03397363          	bgeu	s2,s3,80003bd2 <kexec+0x10e>
    pa = walkaddr(pagetable, va + i);
    80003bb0:	02091593          	slli	a1,s2,0x20
    80003bb4:	9181                	srli	a1,a1,0x20
    80003bb6:	95de                	add	a1,a1,s7
    80003bb8:	855a                	mv	a0,s6
    80003bba:	8a3fc0ef          	jal	8000045c <walkaddr>
    80003bbe:	862a                	mv	a2,a0
    if(pa == 0)
    80003bc0:	d179                	beqz	a0,80003b86 <kexec+0xc2>
    if(sz - i < PGSIZE)
    80003bc2:	412984bb          	subw	s1,s3,s2
    80003bc6:	0004879b          	sext.w	a5,s1
    80003bca:	fcfcf4e3          	bgeu	s9,a5,80003b92 <kexec+0xce>
    80003bce:	84d6                	mv	s1,s5
    80003bd0:	b7c9                	j	80003b92 <kexec+0xce>
    sz = sz1;
    80003bd2:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003bd6:	2d85                	addiw	s11,s11,1
    80003bd8:	038d0d1b          	addiw	s10,s10,56 # 1038 <_entry-0x7fffefc8>
    80003bdc:	e8845783          	lhu	a5,-376(s0)
    80003be0:	08fdd063          	bge	s11,a5,80003c60 <kexec+0x19c>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003be4:	2d01                	sext.w	s10,s10
    80003be6:	03800713          	li	a4,56
    80003bea:	86ea                	mv	a3,s10
    80003bec:	e1840613          	addi	a2,s0,-488
    80003bf0:	4581                	li	a1,0
    80003bf2:	8552                	mv	a0,s4
    80003bf4:	e6dfe0ef          	jal	80002a60 <readi>
    80003bf8:	03800793          	li	a5,56
    80003bfc:	1cf51663          	bne	a0,a5,80003dc8 <kexec+0x304>
    if(ph.type != ELF_PROG_LOAD)
    80003c00:	e1842783          	lw	a5,-488(s0)
    80003c04:	4705                	li	a4,1
    80003c06:	fce798e3          	bne	a5,a4,80003bd6 <kexec+0x112>
    if(ph.memsz < ph.filesz)
    80003c0a:	e4043483          	ld	s1,-448(s0)
    80003c0e:	e3843783          	ld	a5,-456(s0)
    80003c12:	1af4ef63          	bltu	s1,a5,80003dd0 <kexec+0x30c>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003c16:	e2843783          	ld	a5,-472(s0)
    80003c1a:	94be                	add	s1,s1,a5
    80003c1c:	1af4ee63          	bltu	s1,a5,80003dd8 <kexec+0x314>
    if(ph.vaddr % PGSIZE != 0)
    80003c20:	df043703          	ld	a4,-528(s0)
    80003c24:	8ff9                	and	a5,a5,a4
    80003c26:	1a079d63          	bnez	a5,80003de0 <kexec+0x31c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003c2a:	e1c42503          	lw	a0,-484(s0)
    80003c2e:	e7dff0ef          	jal	80003aaa <flags2perm>
    80003c32:	86aa                	mv	a3,a0
    80003c34:	8626                	mv	a2,s1
    80003c36:	85ca                	mv	a1,s2
    80003c38:	855a                	mv	a0,s6
    80003c3a:	afbfc0ef          	jal	80000734 <uvmalloc>
    80003c3e:	e0a43423          	sd	a0,-504(s0)
    80003c42:	1a050363          	beqz	a0,80003de8 <kexec+0x324>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003c46:	e2843b83          	ld	s7,-472(s0)
    80003c4a:	e2042c03          	lw	s8,-480(s0)
    80003c4e:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003c52:	00098463          	beqz	s3,80003c5a <kexec+0x196>
    80003c56:	4901                	li	s2,0
    80003c58:	bfa1                	j	80003bb0 <kexec+0xec>
    sz = sz1;
    80003c5a:	e0843903          	ld	s2,-504(s0)
    80003c5e:	bfa5                	j	80003bd6 <kexec+0x112>
    80003c60:	7dba                	ld	s11,424(sp)
  iunlockput(ip);
    80003c62:	8552                	mv	a0,s4
    80003c64:	c77fe0ef          	jal	800028da <iunlockput>
  end_op();
    80003c68:	cbcff0ef          	jal	80003124 <end_op>
  p = myproc();
    80003c6c:	90efd0ef          	jal	80000d7a <myproc>
    80003c70:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80003c72:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    80003c76:	6985                	lui	s3,0x1
    80003c78:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    80003c7a:	99ca                	add	s3,s3,s2
    80003c7c:	77fd                	lui	a5,0xfffff
    80003c7e:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003c82:	4691                	li	a3,4
    80003c84:	660d                	lui	a2,0x3
    80003c86:	964e                	add	a2,a2,s3
    80003c88:	85ce                	mv	a1,s3
    80003c8a:	855a                	mv	a0,s6
    80003c8c:	aa9fc0ef          	jal	80000734 <uvmalloc>
    80003c90:	892a                	mv	s2,a0
    80003c92:	e0a43423          	sd	a0,-504(s0)
    80003c96:	e519                	bnez	a0,80003ca4 <kexec+0x1e0>
  if(pagetable)
    80003c98:	e1343423          	sd	s3,-504(s0)
    80003c9c:	4a01                	li	s4,0
    80003c9e:	aab1                	j	80003dfa <kexec+0x336>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003ca0:	4901                	li	s2,0
    80003ca2:	b7c1                	j	80003c62 <kexec+0x19e>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003ca4:	75f5                	lui	a1,0xffffd
    80003ca6:	95aa                	add	a1,a1,a0
    80003ca8:	855a                	mv	a0,s6
    80003caa:	c61fc0ef          	jal	8000090a <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003cae:	7bf9                	lui	s7,0xffffe
    80003cb0:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    80003cb2:	e0043783          	ld	a5,-512(s0)
    80003cb6:	6388                	ld	a0,0(a5)
    80003cb8:	cd39                	beqz	a0,80003d16 <kexec+0x252>
    80003cba:	e9040993          	addi	s3,s0,-368
    80003cbe:	f9040c13          	addi	s8,s0,-112
    80003cc2:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80003cc4:	dfafc0ef          	jal	800002be <strlen>
    80003cc8:	0015079b          	addiw	a5,a0,1
    80003ccc:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003cd0:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003cd4:	11796e63          	bltu	s2,s7,80003df0 <kexec+0x32c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003cd8:	e0043d03          	ld	s10,-512(s0)
    80003cdc:	000d3a03          	ld	s4,0(s10)
    80003ce0:	8552                	mv	a0,s4
    80003ce2:	ddcfc0ef          	jal	800002be <strlen>
    80003ce6:	0015069b          	addiw	a3,a0,1
    80003cea:	8652                	mv	a2,s4
    80003cec:	85ca                	mv	a1,s2
    80003cee:	855a                	mv	a0,s6
    80003cf0:	d9ffc0ef          	jal	80000a8e <copyout>
    80003cf4:	10054063          	bltz	a0,80003df4 <kexec+0x330>
    ustack[argc] = sp;
    80003cf8:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80003cfc:	0485                	addi	s1,s1,1
    80003cfe:	008d0793          	addi	a5,s10,8
    80003d02:	e0f43023          	sd	a5,-512(s0)
    80003d06:	008d3503          	ld	a0,8(s10)
    80003d0a:	c909                	beqz	a0,80003d1c <kexec+0x258>
    if(argc >= MAXARG)
    80003d0c:	09a1                	addi	s3,s3,8
    80003d0e:	fb899be3          	bne	s3,s8,80003cc4 <kexec+0x200>
  ip = 0;
    80003d12:	4a01                	li	s4,0
    80003d14:	a0dd                	j	80003dfa <kexec+0x336>
  sp = sz;
    80003d16:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80003d1a:	4481                	li	s1,0
  ustack[argc] = 0;
    80003d1c:	00349793          	slli	a5,s1,0x3
    80003d20:	f9078793          	addi	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffdba98>
    80003d24:	97a2                	add	a5,a5,s0
    80003d26:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003d2a:	00148693          	addi	a3,s1,1
    80003d2e:	068e                	slli	a3,a3,0x3
    80003d30:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003d34:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80003d38:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    80003d3c:	f5796ee3          	bltu	s2,s7,80003c98 <kexec+0x1d4>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003d40:	e9040613          	addi	a2,s0,-368
    80003d44:	85ca                	mv	a1,s2
    80003d46:	855a                	mv	a0,s6
    80003d48:	d47fc0ef          	jal	80000a8e <copyout>
    80003d4c:	0e054263          	bltz	a0,80003e30 <kexec+0x36c>
  p->trapframe->a1 = sp;
    80003d50:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80003d54:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003d58:	df843783          	ld	a5,-520(s0)
    80003d5c:	0007c703          	lbu	a4,0(a5)
    80003d60:	cf11                	beqz	a4,80003d7c <kexec+0x2b8>
    80003d62:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003d64:	02f00693          	li	a3,47
    80003d68:	a039                	j	80003d76 <kexec+0x2b2>
      last = s+1;
    80003d6a:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80003d6e:	0785                	addi	a5,a5,1
    80003d70:	fff7c703          	lbu	a4,-1(a5)
    80003d74:	c701                	beqz	a4,80003d7c <kexec+0x2b8>
    if(*s == '/')
    80003d76:	fed71ce3          	bne	a4,a3,80003d6e <kexec+0x2aa>
    80003d7a:	bfc5                	j	80003d6a <kexec+0x2a6>
  safestrcpy(p->name, last, sizeof(p->name));
    80003d7c:	4641                	li	a2,16
    80003d7e:	df843583          	ld	a1,-520(s0)
    80003d82:	158a8513          	addi	a0,s5,344
    80003d86:	d06fc0ef          	jal	8000028c <safestrcpy>
  oldpagetable = p->pagetable;
    80003d8a:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80003d8e:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    80003d92:	e0843783          	ld	a5,-504(s0)
    80003d96:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003d9a:	058ab783          	ld	a5,88(s5)
    80003d9e:	e6843703          	ld	a4,-408(s0)
    80003da2:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003da4:	058ab783          	ld	a5,88(s5)
    80003da8:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003dac:	85e6                	mv	a1,s9
    80003dae:	956fd0ef          	jal	80000f04 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003db2:	0004851b          	sext.w	a0,s1
    80003db6:	79be                	ld	s3,488(sp)
    80003db8:	7a1e                	ld	s4,480(sp)
    80003dba:	6afe                	ld	s5,472(sp)
    80003dbc:	6b5e                	ld	s6,464(sp)
    80003dbe:	6bbe                	ld	s7,456(sp)
    80003dc0:	6c1e                	ld	s8,448(sp)
    80003dc2:	7cfa                	ld	s9,440(sp)
    80003dc4:	7d5a                	ld	s10,432(sp)
    80003dc6:	b3b5                	j	80003b32 <kexec+0x6e>
    80003dc8:	e1243423          	sd	s2,-504(s0)
    80003dcc:	7dba                	ld	s11,424(sp)
    80003dce:	a035                	j	80003dfa <kexec+0x336>
    80003dd0:	e1243423          	sd	s2,-504(s0)
    80003dd4:	7dba                	ld	s11,424(sp)
    80003dd6:	a015                	j	80003dfa <kexec+0x336>
    80003dd8:	e1243423          	sd	s2,-504(s0)
    80003ddc:	7dba                	ld	s11,424(sp)
    80003dde:	a831                	j	80003dfa <kexec+0x336>
    80003de0:	e1243423          	sd	s2,-504(s0)
    80003de4:	7dba                	ld	s11,424(sp)
    80003de6:	a811                	j	80003dfa <kexec+0x336>
    80003de8:	e1243423          	sd	s2,-504(s0)
    80003dec:	7dba                	ld	s11,424(sp)
    80003dee:	a031                	j	80003dfa <kexec+0x336>
  ip = 0;
    80003df0:	4a01                	li	s4,0
    80003df2:	a021                	j	80003dfa <kexec+0x336>
    80003df4:	4a01                	li	s4,0
  if(pagetable)
    80003df6:	a011                	j	80003dfa <kexec+0x336>
    80003df8:	7dba                	ld	s11,424(sp)
    proc_freepagetable(pagetable, sz);
    80003dfa:	e0843583          	ld	a1,-504(s0)
    80003dfe:	855a                	mv	a0,s6
    80003e00:	904fd0ef          	jal	80000f04 <proc_freepagetable>
  return -1;
    80003e04:	557d                	li	a0,-1
  if(ip){
    80003e06:	000a1b63          	bnez	s4,80003e1c <kexec+0x358>
    80003e0a:	79be                	ld	s3,488(sp)
    80003e0c:	7a1e                	ld	s4,480(sp)
    80003e0e:	6afe                	ld	s5,472(sp)
    80003e10:	6b5e                	ld	s6,464(sp)
    80003e12:	6bbe                	ld	s7,456(sp)
    80003e14:	6c1e                	ld	s8,448(sp)
    80003e16:	7cfa                	ld	s9,440(sp)
    80003e18:	7d5a                	ld	s10,432(sp)
    80003e1a:	bb21                	j	80003b32 <kexec+0x6e>
    80003e1c:	79be                	ld	s3,488(sp)
    80003e1e:	6afe                	ld	s5,472(sp)
    80003e20:	6b5e                	ld	s6,464(sp)
    80003e22:	6bbe                	ld	s7,456(sp)
    80003e24:	6c1e                	ld	s8,448(sp)
    80003e26:	7cfa                	ld	s9,440(sp)
    80003e28:	7d5a                	ld	s10,432(sp)
    80003e2a:	b9ed                	j	80003b24 <kexec+0x60>
    80003e2c:	6b5e                	ld	s6,464(sp)
    80003e2e:	b9dd                	j	80003b24 <kexec+0x60>
  sz = sz1;
    80003e30:	e0843983          	ld	s3,-504(s0)
    80003e34:	b595                	j	80003c98 <kexec+0x1d4>

0000000080003e36 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003e36:	7179                	addi	sp,sp,-48
    80003e38:	f406                	sd	ra,40(sp)
    80003e3a:	f022                	sd	s0,32(sp)
    80003e3c:	ec26                	sd	s1,24(sp)
    80003e3e:	e84a                	sd	s2,16(sp)
    80003e40:	1800                	addi	s0,sp,48
    80003e42:	892e                	mv	s2,a1
    80003e44:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003e46:	fdc40593          	addi	a1,s0,-36
    80003e4a:	e2dfd0ef          	jal	80001c76 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003e4e:	fdc42703          	lw	a4,-36(s0)
    80003e52:	47bd                	li	a5,15
    80003e54:	02e7e963          	bltu	a5,a4,80003e86 <argfd+0x50>
    80003e58:	f23fc0ef          	jal	80000d7a <myproc>
    80003e5c:	fdc42703          	lw	a4,-36(s0)
    80003e60:	01a70793          	addi	a5,a4,26
    80003e64:	078e                	slli	a5,a5,0x3
    80003e66:	953e                	add	a0,a0,a5
    80003e68:	611c                	ld	a5,0(a0)
    80003e6a:	c385                	beqz	a5,80003e8a <argfd+0x54>
    return -1;
  if(pfd)
    80003e6c:	00090463          	beqz	s2,80003e74 <argfd+0x3e>
    *pfd = fd;
    80003e70:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80003e74:	4501                	li	a0,0
  if(pf)
    80003e76:	c091                	beqz	s1,80003e7a <argfd+0x44>
    *pf = f;
    80003e78:	e09c                	sd	a5,0(s1)
}
    80003e7a:	70a2                	ld	ra,40(sp)
    80003e7c:	7402                	ld	s0,32(sp)
    80003e7e:	64e2                	ld	s1,24(sp)
    80003e80:	6942                	ld	s2,16(sp)
    80003e82:	6145                	addi	sp,sp,48
    80003e84:	8082                	ret
    return -1;
    80003e86:	557d                	li	a0,-1
    80003e88:	bfcd                	j	80003e7a <argfd+0x44>
    80003e8a:	557d                	li	a0,-1
    80003e8c:	b7fd                	j	80003e7a <argfd+0x44>

0000000080003e8e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003e8e:	1101                	addi	sp,sp,-32
    80003e90:	ec06                	sd	ra,24(sp)
    80003e92:	e822                	sd	s0,16(sp)
    80003e94:	e426                	sd	s1,8(sp)
    80003e96:	1000                	addi	s0,sp,32
    80003e98:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003e9a:	ee1fc0ef          	jal	80000d7a <myproc>
    80003e9e:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003ea0:	0d050793          	addi	a5,a0,208
    80003ea4:	4501                	li	a0,0
    80003ea6:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003ea8:	6398                	ld	a4,0(a5)
    80003eaa:	cb19                	beqz	a4,80003ec0 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003eac:	2505                	addiw	a0,a0,1
    80003eae:	07a1                	addi	a5,a5,8
    80003eb0:	fed51ce3          	bne	a0,a3,80003ea8 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003eb4:	557d                	li	a0,-1
}
    80003eb6:	60e2                	ld	ra,24(sp)
    80003eb8:	6442                	ld	s0,16(sp)
    80003eba:	64a2                	ld	s1,8(sp)
    80003ebc:	6105                	addi	sp,sp,32
    80003ebe:	8082                	ret
      p->ofile[fd] = f;
    80003ec0:	01a50793          	addi	a5,a0,26
    80003ec4:	078e                	slli	a5,a5,0x3
    80003ec6:	963e                	add	a2,a2,a5
    80003ec8:	e204                	sd	s1,0(a2)
      return fd;
    80003eca:	b7f5                	j	80003eb6 <fdalloc+0x28>

0000000080003ecc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003ecc:	715d                	addi	sp,sp,-80
    80003ece:	e486                	sd	ra,72(sp)
    80003ed0:	e0a2                	sd	s0,64(sp)
    80003ed2:	fc26                	sd	s1,56(sp)
    80003ed4:	f84a                	sd	s2,48(sp)
    80003ed6:	f44e                	sd	s3,40(sp)
    80003ed8:	ec56                	sd	s5,24(sp)
    80003eda:	e85a                	sd	s6,16(sp)
    80003edc:	0880                	addi	s0,sp,80
    80003ede:	8b2e                	mv	s6,a1
    80003ee0:	89b2                	mv	s3,a2
    80003ee2:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003ee4:	fb040593          	addi	a1,s0,-80
    80003ee8:	818ff0ef          	jal	80002f00 <nameiparent>
    80003eec:	84aa                	mv	s1,a0
    80003eee:	10050a63          	beqz	a0,80004002 <create+0x136>
    return 0;

  ilock(dp);
    80003ef2:	fdefe0ef          	jal	800026d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003ef6:	4601                	li	a2,0
    80003ef8:	fb040593          	addi	a1,s0,-80
    80003efc:	8526                	mv	a0,s1
    80003efe:	d83fe0ef          	jal	80002c80 <dirlookup>
    80003f02:	8aaa                	mv	s5,a0
    80003f04:	c129                	beqz	a0,80003f46 <create+0x7a>
    iunlockput(dp);
    80003f06:	8526                	mv	a0,s1
    80003f08:	9d3fe0ef          	jal	800028da <iunlockput>
    ilock(ip);
    80003f0c:	8556                	mv	a0,s5
    80003f0e:	fc2fe0ef          	jal	800026d0 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003f12:	4789                	li	a5,2
    80003f14:	02fb1463          	bne	s6,a5,80003f3c <create+0x70>
    80003f18:	044ad783          	lhu	a5,68(s5)
    80003f1c:	37f9                	addiw	a5,a5,-2
    80003f1e:	17c2                	slli	a5,a5,0x30
    80003f20:	93c1                	srli	a5,a5,0x30
    80003f22:	4705                	li	a4,1
    80003f24:	00f76c63          	bltu	a4,a5,80003f3c <create+0x70>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003f28:	8556                	mv	a0,s5
    80003f2a:	60a6                	ld	ra,72(sp)
    80003f2c:	6406                	ld	s0,64(sp)
    80003f2e:	74e2                	ld	s1,56(sp)
    80003f30:	7942                	ld	s2,48(sp)
    80003f32:	79a2                	ld	s3,40(sp)
    80003f34:	6ae2                	ld	s5,24(sp)
    80003f36:	6b42                	ld	s6,16(sp)
    80003f38:	6161                	addi	sp,sp,80
    80003f3a:	8082                	ret
    iunlockput(ip);
    80003f3c:	8556                	mv	a0,s5
    80003f3e:	99dfe0ef          	jal	800028da <iunlockput>
    return 0;
    80003f42:	4a81                	li	s5,0
    80003f44:	b7d5                	j	80003f28 <create+0x5c>
    80003f46:	f052                	sd	s4,32(sp)
  if((ip = ialloc(dp->dev, type)) == 0){
    80003f48:	85da                	mv	a1,s6
    80003f4a:	4088                	lw	a0,0(s1)
    80003f4c:	e14fe0ef          	jal	80002560 <ialloc>
    80003f50:	8a2a                	mv	s4,a0
    80003f52:	cd15                	beqz	a0,80003f8e <create+0xc2>
  ilock(ip);
    80003f54:	f7cfe0ef          	jal	800026d0 <ilock>
  ip->major = major;
    80003f58:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80003f5c:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80003f60:	4905                	li	s2,1
    80003f62:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80003f66:	8552                	mv	a0,s4
    80003f68:	eb4fe0ef          	jal	8000261c <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003f6c:	032b0763          	beq	s6,s2,80003f9a <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f70:	004a2603          	lw	a2,4(s4)
    80003f74:	fb040593          	addi	a1,s0,-80
    80003f78:	8526                	mv	a0,s1
    80003f7a:	ed3fe0ef          	jal	80002e4c <dirlink>
    80003f7e:	06054563          	bltz	a0,80003fe8 <create+0x11c>
  iunlockput(dp);
    80003f82:	8526                	mv	a0,s1
    80003f84:	957fe0ef          	jal	800028da <iunlockput>
  return ip;
    80003f88:	8ad2                	mv	s5,s4
    80003f8a:	7a02                	ld	s4,32(sp)
    80003f8c:	bf71                	j	80003f28 <create+0x5c>
    iunlockput(dp);
    80003f8e:	8526                	mv	a0,s1
    80003f90:	94bfe0ef          	jal	800028da <iunlockput>
    return 0;
    80003f94:	8ad2                	mv	s5,s4
    80003f96:	7a02                	ld	s4,32(sp)
    80003f98:	bf41                	j	80003f28 <create+0x5c>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003f9a:	004a2603          	lw	a2,4(s4)
    80003f9e:	00003597          	auipc	a1,0x3
    80003fa2:	5e258593          	addi	a1,a1,1506 # 80007580 <etext+0x580>
    80003fa6:	8552                	mv	a0,s4
    80003fa8:	ea5fe0ef          	jal	80002e4c <dirlink>
    80003fac:	02054e63          	bltz	a0,80003fe8 <create+0x11c>
    80003fb0:	40d0                	lw	a2,4(s1)
    80003fb2:	00003597          	auipc	a1,0x3
    80003fb6:	5d658593          	addi	a1,a1,1494 # 80007588 <etext+0x588>
    80003fba:	8552                	mv	a0,s4
    80003fbc:	e91fe0ef          	jal	80002e4c <dirlink>
    80003fc0:	02054463          	bltz	a0,80003fe8 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003fc4:	004a2603          	lw	a2,4(s4)
    80003fc8:	fb040593          	addi	a1,s0,-80
    80003fcc:	8526                	mv	a0,s1
    80003fce:	e7ffe0ef          	jal	80002e4c <dirlink>
    80003fd2:	00054b63          	bltz	a0,80003fe8 <create+0x11c>
    dp->nlink++;  // for ".."
    80003fd6:	04a4d783          	lhu	a5,74(s1)
    80003fda:	2785                	addiw	a5,a5,1
    80003fdc:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003fe0:	8526                	mv	a0,s1
    80003fe2:	e3afe0ef          	jal	8000261c <iupdate>
    80003fe6:	bf71                	j	80003f82 <create+0xb6>
  ip->nlink = 0;
    80003fe8:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80003fec:	8552                	mv	a0,s4
    80003fee:	e2efe0ef          	jal	8000261c <iupdate>
  iunlockput(ip);
    80003ff2:	8552                	mv	a0,s4
    80003ff4:	8e7fe0ef          	jal	800028da <iunlockput>
  iunlockput(dp);
    80003ff8:	8526                	mv	a0,s1
    80003ffa:	8e1fe0ef          	jal	800028da <iunlockput>
  return 0;
    80003ffe:	7a02                	ld	s4,32(sp)
    80004000:	b725                	j	80003f28 <create+0x5c>
    return 0;
    80004002:	8aaa                	mv	s5,a0
    80004004:	b715                	j	80003f28 <create+0x5c>

0000000080004006 <sys_dup>:
{
    80004006:	7179                	addi	sp,sp,-48
    80004008:	f406                	sd	ra,40(sp)
    8000400a:	f022                	sd	s0,32(sp)
    8000400c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    8000400e:	fd840613          	addi	a2,s0,-40
    80004012:	4581                	li	a1,0
    80004014:	4501                	li	a0,0
    80004016:	e21ff0ef          	jal	80003e36 <argfd>
    return -1;
    8000401a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000401c:	02054363          	bltz	a0,80004042 <sys_dup+0x3c>
    80004020:	ec26                	sd	s1,24(sp)
    80004022:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80004024:	fd843903          	ld	s2,-40(s0)
    80004028:	854a                	mv	a0,s2
    8000402a:	e65ff0ef          	jal	80003e8e <fdalloc>
    8000402e:	84aa                	mv	s1,a0
    return -1;
    80004030:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004032:	00054d63          	bltz	a0,8000404c <sys_dup+0x46>
  filedup(f);
    80004036:	854a                	mv	a0,s2
    80004038:	c48ff0ef          	jal	80003480 <filedup>
  return fd;
    8000403c:	87a6                	mv	a5,s1
    8000403e:	64e2                	ld	s1,24(sp)
    80004040:	6942                	ld	s2,16(sp)
}
    80004042:	853e                	mv	a0,a5
    80004044:	70a2                	ld	ra,40(sp)
    80004046:	7402                	ld	s0,32(sp)
    80004048:	6145                	addi	sp,sp,48
    8000404a:	8082                	ret
    8000404c:	64e2                	ld	s1,24(sp)
    8000404e:	6942                	ld	s2,16(sp)
    80004050:	bfcd                	j	80004042 <sys_dup+0x3c>

0000000080004052 <sys_read>:
{
    80004052:	7179                	addi	sp,sp,-48
    80004054:	f406                	sd	ra,40(sp)
    80004056:	f022                	sd	s0,32(sp)
    80004058:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000405a:	fd840593          	addi	a1,s0,-40
    8000405e:	4505                	li	a0,1
    80004060:	c33fd0ef          	jal	80001c92 <argaddr>
  argint(2, &n);
    80004064:	fe440593          	addi	a1,s0,-28
    80004068:	4509                	li	a0,2
    8000406a:	c0dfd0ef          	jal	80001c76 <argint>
  if(argfd(0, 0, &f) < 0)
    8000406e:	fe840613          	addi	a2,s0,-24
    80004072:	4581                	li	a1,0
    80004074:	4501                	li	a0,0
    80004076:	dc1ff0ef          	jal	80003e36 <argfd>
    8000407a:	87aa                	mv	a5,a0
    return -1;
    8000407c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000407e:	0007ca63          	bltz	a5,80004092 <sys_read+0x40>
  return fileread(f, p, n);
    80004082:	fe442603          	lw	a2,-28(s0)
    80004086:	fd843583          	ld	a1,-40(s0)
    8000408a:	fe843503          	ld	a0,-24(s0)
    8000408e:	d58ff0ef          	jal	800035e6 <fileread>
}
    80004092:	70a2                	ld	ra,40(sp)
    80004094:	7402                	ld	s0,32(sp)
    80004096:	6145                	addi	sp,sp,48
    80004098:	8082                	ret

000000008000409a <sys_write>:
{
    8000409a:	7179                	addi	sp,sp,-48
    8000409c:	f406                	sd	ra,40(sp)
    8000409e:	f022                	sd	s0,32(sp)
    800040a0:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800040a2:	fd840593          	addi	a1,s0,-40
    800040a6:	4505                	li	a0,1
    800040a8:	bebfd0ef          	jal	80001c92 <argaddr>
  argint(2, &n);
    800040ac:	fe440593          	addi	a1,s0,-28
    800040b0:	4509                	li	a0,2
    800040b2:	bc5fd0ef          	jal	80001c76 <argint>
  if(argfd(0, 0, &f) < 0)
    800040b6:	fe840613          	addi	a2,s0,-24
    800040ba:	4581                	li	a1,0
    800040bc:	4501                	li	a0,0
    800040be:	d79ff0ef          	jal	80003e36 <argfd>
    800040c2:	87aa                	mv	a5,a0
    return -1;
    800040c4:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800040c6:	0007ca63          	bltz	a5,800040da <sys_write+0x40>
  return filewrite(f, p, n);
    800040ca:	fe442603          	lw	a2,-28(s0)
    800040ce:	fd843583          	ld	a1,-40(s0)
    800040d2:	fe843503          	ld	a0,-24(s0)
    800040d6:	dceff0ef          	jal	800036a4 <filewrite>
}
    800040da:	70a2                	ld	ra,40(sp)
    800040dc:	7402                	ld	s0,32(sp)
    800040de:	6145                	addi	sp,sp,48
    800040e0:	8082                	ret

00000000800040e2 <sys_close>:
{
    800040e2:	1101                	addi	sp,sp,-32
    800040e4:	ec06                	sd	ra,24(sp)
    800040e6:	e822                	sd	s0,16(sp)
    800040e8:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800040ea:	fe040613          	addi	a2,s0,-32
    800040ee:	fec40593          	addi	a1,s0,-20
    800040f2:	4501                	li	a0,0
    800040f4:	d43ff0ef          	jal	80003e36 <argfd>
    return -1;
    800040f8:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800040fa:	02054063          	bltz	a0,8000411a <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    800040fe:	c7dfc0ef          	jal	80000d7a <myproc>
    80004102:	fec42783          	lw	a5,-20(s0)
    80004106:	07e9                	addi	a5,a5,26
    80004108:	078e                	slli	a5,a5,0x3
    8000410a:	953e                	add	a0,a0,a5
    8000410c:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80004110:	fe043503          	ld	a0,-32(s0)
    80004114:	bb2ff0ef          	jal	800034c6 <fileclose>
  return 0;
    80004118:	4781                	li	a5,0
}
    8000411a:	853e                	mv	a0,a5
    8000411c:	60e2                	ld	ra,24(sp)
    8000411e:	6442                	ld	s0,16(sp)
    80004120:	6105                	addi	sp,sp,32
    80004122:	8082                	ret

0000000080004124 <sys_fstat>:
{
    80004124:	1101                	addi	sp,sp,-32
    80004126:	ec06                	sd	ra,24(sp)
    80004128:	e822                	sd	s0,16(sp)
    8000412a:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000412c:	fe040593          	addi	a1,s0,-32
    80004130:	4505                	li	a0,1
    80004132:	b61fd0ef          	jal	80001c92 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004136:	fe840613          	addi	a2,s0,-24
    8000413a:	4581                	li	a1,0
    8000413c:	4501                	li	a0,0
    8000413e:	cf9ff0ef          	jal	80003e36 <argfd>
    80004142:	87aa                	mv	a5,a0
    return -1;
    80004144:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004146:	0007c863          	bltz	a5,80004156 <sys_fstat+0x32>
  return filestat(f, st);
    8000414a:	fe043583          	ld	a1,-32(s0)
    8000414e:	fe843503          	ld	a0,-24(s0)
    80004152:	c36ff0ef          	jal	80003588 <filestat>
}
    80004156:	60e2                	ld	ra,24(sp)
    80004158:	6442                	ld	s0,16(sp)
    8000415a:	6105                	addi	sp,sp,32
    8000415c:	8082                	ret

000000008000415e <sys_link>:
{
    8000415e:	7169                	addi	sp,sp,-304
    80004160:	f606                	sd	ra,296(sp)
    80004162:	f222                	sd	s0,288(sp)
    80004164:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004166:	08000613          	li	a2,128
    8000416a:	ed040593          	addi	a1,s0,-304
    8000416e:	4501                	li	a0,0
    80004170:	b3ffd0ef          	jal	80001cae <argstr>
    return -1;
    80004174:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004176:	0c054e63          	bltz	a0,80004252 <sys_link+0xf4>
    8000417a:	08000613          	li	a2,128
    8000417e:	f5040593          	addi	a1,s0,-176
    80004182:	4505                	li	a0,1
    80004184:	b2bfd0ef          	jal	80001cae <argstr>
    return -1;
    80004188:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000418a:	0c054463          	bltz	a0,80004252 <sys_link+0xf4>
    8000418e:	ee26                	sd	s1,280(sp)
  begin_op();
    80004190:	f2bfe0ef          	jal	800030ba <begin_op>
  if((ip = namei(old)) == 0){
    80004194:	ed040513          	addi	a0,s0,-304
    80004198:	d4ffe0ef          	jal	80002ee6 <namei>
    8000419c:	84aa                	mv	s1,a0
    8000419e:	c53d                	beqz	a0,8000420c <sys_link+0xae>
  ilock(ip);
    800041a0:	d30fe0ef          	jal	800026d0 <ilock>
  if(ip->type == T_DIR){
    800041a4:	04449703          	lh	a4,68(s1)
    800041a8:	4785                	li	a5,1
    800041aa:	06f70663          	beq	a4,a5,80004216 <sys_link+0xb8>
    800041ae:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    800041b0:	04a4d783          	lhu	a5,74(s1)
    800041b4:	2785                	addiw	a5,a5,1
    800041b6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800041ba:	8526                	mv	a0,s1
    800041bc:	c60fe0ef          	jal	8000261c <iupdate>
  iunlock(ip);
    800041c0:	8526                	mv	a0,s1
    800041c2:	dbcfe0ef          	jal	8000277e <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800041c6:	fd040593          	addi	a1,s0,-48
    800041ca:	f5040513          	addi	a0,s0,-176
    800041ce:	d33fe0ef          	jal	80002f00 <nameiparent>
    800041d2:	892a                	mv	s2,a0
    800041d4:	cd21                	beqz	a0,8000422c <sys_link+0xce>
  ilock(dp);
    800041d6:	cfafe0ef          	jal	800026d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800041da:	00092703          	lw	a4,0(s2)
    800041de:	409c                	lw	a5,0(s1)
    800041e0:	04f71363          	bne	a4,a5,80004226 <sys_link+0xc8>
    800041e4:	40d0                	lw	a2,4(s1)
    800041e6:	fd040593          	addi	a1,s0,-48
    800041ea:	854a                	mv	a0,s2
    800041ec:	c61fe0ef          	jal	80002e4c <dirlink>
    800041f0:	02054b63          	bltz	a0,80004226 <sys_link+0xc8>
  iunlockput(dp);
    800041f4:	854a                	mv	a0,s2
    800041f6:	ee4fe0ef          	jal	800028da <iunlockput>
  iput(ip);
    800041fa:	8526                	mv	a0,s1
    800041fc:	e56fe0ef          	jal	80002852 <iput>
  end_op();
    80004200:	f25fe0ef          	jal	80003124 <end_op>
  return 0;
    80004204:	4781                	li	a5,0
    80004206:	64f2                	ld	s1,280(sp)
    80004208:	6952                	ld	s2,272(sp)
    8000420a:	a0a1                	j	80004252 <sys_link+0xf4>
    end_op();
    8000420c:	f19fe0ef          	jal	80003124 <end_op>
    return -1;
    80004210:	57fd                	li	a5,-1
    80004212:	64f2                	ld	s1,280(sp)
    80004214:	a83d                	j	80004252 <sys_link+0xf4>
    iunlockput(ip);
    80004216:	8526                	mv	a0,s1
    80004218:	ec2fe0ef          	jal	800028da <iunlockput>
    end_op();
    8000421c:	f09fe0ef          	jal	80003124 <end_op>
    return -1;
    80004220:	57fd                	li	a5,-1
    80004222:	64f2                	ld	s1,280(sp)
    80004224:	a03d                	j	80004252 <sys_link+0xf4>
    iunlockput(dp);
    80004226:	854a                	mv	a0,s2
    80004228:	eb2fe0ef          	jal	800028da <iunlockput>
  ilock(ip);
    8000422c:	8526                	mv	a0,s1
    8000422e:	ca2fe0ef          	jal	800026d0 <ilock>
  ip->nlink--;
    80004232:	04a4d783          	lhu	a5,74(s1)
    80004236:	37fd                	addiw	a5,a5,-1
    80004238:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000423c:	8526                	mv	a0,s1
    8000423e:	bdefe0ef          	jal	8000261c <iupdate>
  iunlockput(ip);
    80004242:	8526                	mv	a0,s1
    80004244:	e96fe0ef          	jal	800028da <iunlockput>
  end_op();
    80004248:	eddfe0ef          	jal	80003124 <end_op>
  return -1;
    8000424c:	57fd                	li	a5,-1
    8000424e:	64f2                	ld	s1,280(sp)
    80004250:	6952                	ld	s2,272(sp)
}
    80004252:	853e                	mv	a0,a5
    80004254:	70b2                	ld	ra,296(sp)
    80004256:	7412                	ld	s0,288(sp)
    80004258:	6155                	addi	sp,sp,304
    8000425a:	8082                	ret

000000008000425c <sys_unlink>:
{
    8000425c:	7151                	addi	sp,sp,-240
    8000425e:	f586                	sd	ra,232(sp)
    80004260:	f1a2                	sd	s0,224(sp)
    80004262:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004264:	08000613          	li	a2,128
    80004268:	f3040593          	addi	a1,s0,-208
    8000426c:	4501                	li	a0,0
    8000426e:	a41fd0ef          	jal	80001cae <argstr>
    80004272:	16054063          	bltz	a0,800043d2 <sys_unlink+0x176>
    80004276:	eda6                	sd	s1,216(sp)
  begin_op();
    80004278:	e43fe0ef          	jal	800030ba <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000427c:	fb040593          	addi	a1,s0,-80
    80004280:	f3040513          	addi	a0,s0,-208
    80004284:	c7dfe0ef          	jal	80002f00 <nameiparent>
    80004288:	84aa                	mv	s1,a0
    8000428a:	c945                	beqz	a0,8000433a <sys_unlink+0xde>
  ilock(dp);
    8000428c:	c44fe0ef          	jal	800026d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004290:	00003597          	auipc	a1,0x3
    80004294:	2f058593          	addi	a1,a1,752 # 80007580 <etext+0x580>
    80004298:	fb040513          	addi	a0,s0,-80
    8000429c:	9cffe0ef          	jal	80002c6a <namecmp>
    800042a0:	10050e63          	beqz	a0,800043bc <sys_unlink+0x160>
    800042a4:	00003597          	auipc	a1,0x3
    800042a8:	2e458593          	addi	a1,a1,740 # 80007588 <etext+0x588>
    800042ac:	fb040513          	addi	a0,s0,-80
    800042b0:	9bbfe0ef          	jal	80002c6a <namecmp>
    800042b4:	10050463          	beqz	a0,800043bc <sys_unlink+0x160>
    800042b8:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    800042ba:	f2c40613          	addi	a2,s0,-212
    800042be:	fb040593          	addi	a1,s0,-80
    800042c2:	8526                	mv	a0,s1
    800042c4:	9bdfe0ef          	jal	80002c80 <dirlookup>
    800042c8:	892a                	mv	s2,a0
    800042ca:	0e050863          	beqz	a0,800043ba <sys_unlink+0x15e>
  ilock(ip);
    800042ce:	c02fe0ef          	jal	800026d0 <ilock>
  if(ip->nlink < 1)
    800042d2:	04a91783          	lh	a5,74(s2)
    800042d6:	06f05763          	blez	a5,80004344 <sys_unlink+0xe8>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800042da:	04491703          	lh	a4,68(s2)
    800042de:	4785                	li	a5,1
    800042e0:	06f70963          	beq	a4,a5,80004352 <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    800042e4:	4641                	li	a2,16
    800042e6:	4581                	li	a1,0
    800042e8:	fc040513          	addi	a0,s0,-64
    800042ec:	e63fb0ef          	jal	8000014e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800042f0:	4741                	li	a4,16
    800042f2:	f2c42683          	lw	a3,-212(s0)
    800042f6:	fc040613          	addi	a2,s0,-64
    800042fa:	4581                	li	a1,0
    800042fc:	8526                	mv	a0,s1
    800042fe:	85ffe0ef          	jal	80002b5c <writei>
    80004302:	47c1                	li	a5,16
    80004304:	08f51b63          	bne	a0,a5,8000439a <sys_unlink+0x13e>
  if(ip->type == T_DIR){
    80004308:	04491703          	lh	a4,68(s2)
    8000430c:	4785                	li	a5,1
    8000430e:	08f70d63          	beq	a4,a5,800043a8 <sys_unlink+0x14c>
  iunlockput(dp);
    80004312:	8526                	mv	a0,s1
    80004314:	dc6fe0ef          	jal	800028da <iunlockput>
  ip->nlink--;
    80004318:	04a95783          	lhu	a5,74(s2)
    8000431c:	37fd                	addiw	a5,a5,-1
    8000431e:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004322:	854a                	mv	a0,s2
    80004324:	af8fe0ef          	jal	8000261c <iupdate>
  iunlockput(ip);
    80004328:	854a                	mv	a0,s2
    8000432a:	db0fe0ef          	jal	800028da <iunlockput>
  end_op();
    8000432e:	df7fe0ef          	jal	80003124 <end_op>
  return 0;
    80004332:	4501                	li	a0,0
    80004334:	64ee                	ld	s1,216(sp)
    80004336:	694e                	ld	s2,208(sp)
    80004338:	a849                	j	800043ca <sys_unlink+0x16e>
    end_op();
    8000433a:	debfe0ef          	jal	80003124 <end_op>
    return -1;
    8000433e:	557d                	li	a0,-1
    80004340:	64ee                	ld	s1,216(sp)
    80004342:	a061                	j	800043ca <sys_unlink+0x16e>
    80004344:	e5ce                	sd	s3,200(sp)
    panic("unlink: nlink < 1");
    80004346:	00003517          	auipc	a0,0x3
    8000434a:	24a50513          	addi	a0,a0,586 # 80007590 <etext+0x590>
    8000434e:	2c0010ef          	jal	8000560e <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004352:	04c92703          	lw	a4,76(s2)
    80004356:	02000793          	li	a5,32
    8000435a:	f8e7f5e3          	bgeu	a5,a4,800042e4 <sys_unlink+0x88>
    8000435e:	e5ce                	sd	s3,200(sp)
    80004360:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004364:	4741                	li	a4,16
    80004366:	86ce                	mv	a3,s3
    80004368:	f1840613          	addi	a2,s0,-232
    8000436c:	4581                	li	a1,0
    8000436e:	854a                	mv	a0,s2
    80004370:	ef0fe0ef          	jal	80002a60 <readi>
    80004374:	47c1                	li	a5,16
    80004376:	00f51c63          	bne	a0,a5,8000438e <sys_unlink+0x132>
    if(de.inum != 0)
    8000437a:	f1845783          	lhu	a5,-232(s0)
    8000437e:	efa1                	bnez	a5,800043d6 <sys_unlink+0x17a>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004380:	29c1                	addiw	s3,s3,16
    80004382:	04c92783          	lw	a5,76(s2)
    80004386:	fcf9efe3          	bltu	s3,a5,80004364 <sys_unlink+0x108>
    8000438a:	69ae                	ld	s3,200(sp)
    8000438c:	bfa1                	j	800042e4 <sys_unlink+0x88>
      panic("isdirempty: readi");
    8000438e:	00003517          	auipc	a0,0x3
    80004392:	21a50513          	addi	a0,a0,538 # 800075a8 <etext+0x5a8>
    80004396:	278010ef          	jal	8000560e <panic>
    8000439a:	e5ce                	sd	s3,200(sp)
    panic("unlink: writei");
    8000439c:	00003517          	auipc	a0,0x3
    800043a0:	22450513          	addi	a0,a0,548 # 800075c0 <etext+0x5c0>
    800043a4:	26a010ef          	jal	8000560e <panic>
    dp->nlink--;
    800043a8:	04a4d783          	lhu	a5,74(s1)
    800043ac:	37fd                	addiw	a5,a5,-1
    800043ae:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800043b2:	8526                	mv	a0,s1
    800043b4:	a68fe0ef          	jal	8000261c <iupdate>
    800043b8:	bfa9                	j	80004312 <sys_unlink+0xb6>
    800043ba:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    800043bc:	8526                	mv	a0,s1
    800043be:	d1cfe0ef          	jal	800028da <iunlockput>
  end_op();
    800043c2:	d63fe0ef          	jal	80003124 <end_op>
  return -1;
    800043c6:	557d                	li	a0,-1
    800043c8:	64ee                	ld	s1,216(sp)
}
    800043ca:	70ae                	ld	ra,232(sp)
    800043cc:	740e                	ld	s0,224(sp)
    800043ce:	616d                	addi	sp,sp,240
    800043d0:	8082                	ret
    return -1;
    800043d2:	557d                	li	a0,-1
    800043d4:	bfdd                	j	800043ca <sys_unlink+0x16e>
    iunlockput(ip);
    800043d6:	854a                	mv	a0,s2
    800043d8:	d02fe0ef          	jal	800028da <iunlockput>
    goto bad;
    800043dc:	694e                	ld	s2,208(sp)
    800043de:	69ae                	ld	s3,200(sp)
    800043e0:	bff1                	j	800043bc <sys_unlink+0x160>

00000000800043e2 <sys_open>:

uint64
sys_open(void)
{
    800043e2:	7131                	addi	sp,sp,-192
    800043e4:	fd06                	sd	ra,184(sp)
    800043e6:	f922                	sd	s0,176(sp)
    800043e8:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    800043ea:	f4c40593          	addi	a1,s0,-180
    800043ee:	4505                	li	a0,1
    800043f0:	887fd0ef          	jal	80001c76 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800043f4:	08000613          	li	a2,128
    800043f8:	f5040593          	addi	a1,s0,-176
    800043fc:	4501                	li	a0,0
    800043fe:	8b1fd0ef          	jal	80001cae <argstr>
    80004402:	87aa                	mv	a5,a0
    return -1;
    80004404:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004406:	0a07c263          	bltz	a5,800044aa <sys_open+0xc8>
    8000440a:	f526                	sd	s1,168(sp)

  begin_op();
    8000440c:	caffe0ef          	jal	800030ba <begin_op>

  if(omode & O_CREATE){
    80004410:	f4c42783          	lw	a5,-180(s0)
    80004414:	2007f793          	andi	a5,a5,512
    80004418:	c3d5                	beqz	a5,800044bc <sys_open+0xda>
    ip = create(path, T_FILE, 0, 0);
    8000441a:	4681                	li	a3,0
    8000441c:	4601                	li	a2,0
    8000441e:	4589                	li	a1,2
    80004420:	f5040513          	addi	a0,s0,-176
    80004424:	aa9ff0ef          	jal	80003ecc <create>
    80004428:	84aa                	mv	s1,a0
    if(ip == 0){
    8000442a:	c541                	beqz	a0,800044b2 <sys_open+0xd0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000442c:	04449703          	lh	a4,68(s1)
    80004430:	478d                	li	a5,3
    80004432:	00f71763          	bne	a4,a5,80004440 <sys_open+0x5e>
    80004436:	0464d703          	lhu	a4,70(s1)
    8000443a:	47a5                	li	a5,9
    8000443c:	0ae7ed63          	bltu	a5,a4,800044f6 <sys_open+0x114>
    80004440:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004442:	fe1fe0ef          	jal	80003422 <filealloc>
    80004446:	892a                	mv	s2,a0
    80004448:	c179                	beqz	a0,8000450e <sys_open+0x12c>
    8000444a:	ed4e                	sd	s3,152(sp)
    8000444c:	a43ff0ef          	jal	80003e8e <fdalloc>
    80004450:	89aa                	mv	s3,a0
    80004452:	0a054a63          	bltz	a0,80004506 <sys_open+0x124>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004456:	04449703          	lh	a4,68(s1)
    8000445a:	478d                	li	a5,3
    8000445c:	0cf70263          	beq	a4,a5,80004520 <sys_open+0x13e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004460:	4789                	li	a5,2
    80004462:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004466:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    8000446a:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    8000446e:	f4c42783          	lw	a5,-180(s0)
    80004472:	0017c713          	xori	a4,a5,1
    80004476:	8b05                	andi	a4,a4,1
    80004478:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000447c:	0037f713          	andi	a4,a5,3
    80004480:	00e03733          	snez	a4,a4
    80004484:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004488:	4007f793          	andi	a5,a5,1024
    8000448c:	c791                	beqz	a5,80004498 <sys_open+0xb6>
    8000448e:	04449703          	lh	a4,68(s1)
    80004492:	4789                	li	a5,2
    80004494:	08f70d63          	beq	a4,a5,8000452e <sys_open+0x14c>
    itrunc(ip);
  }

  iunlock(ip);
    80004498:	8526                	mv	a0,s1
    8000449a:	ae4fe0ef          	jal	8000277e <iunlock>
  end_op();
    8000449e:	c87fe0ef          	jal	80003124 <end_op>

  return fd;
    800044a2:	854e                	mv	a0,s3
    800044a4:	74aa                	ld	s1,168(sp)
    800044a6:	790a                	ld	s2,160(sp)
    800044a8:	69ea                	ld	s3,152(sp)
}
    800044aa:	70ea                	ld	ra,184(sp)
    800044ac:	744a                	ld	s0,176(sp)
    800044ae:	6129                	addi	sp,sp,192
    800044b0:	8082                	ret
      end_op();
    800044b2:	c73fe0ef          	jal	80003124 <end_op>
      return -1;
    800044b6:	557d                	li	a0,-1
    800044b8:	74aa                	ld	s1,168(sp)
    800044ba:	bfc5                	j	800044aa <sys_open+0xc8>
    if((ip = namei(path)) == 0){
    800044bc:	f5040513          	addi	a0,s0,-176
    800044c0:	a27fe0ef          	jal	80002ee6 <namei>
    800044c4:	84aa                	mv	s1,a0
    800044c6:	c11d                	beqz	a0,800044ec <sys_open+0x10a>
    ilock(ip);
    800044c8:	a08fe0ef          	jal	800026d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800044cc:	04449703          	lh	a4,68(s1)
    800044d0:	4785                	li	a5,1
    800044d2:	f4f71de3          	bne	a4,a5,8000442c <sys_open+0x4a>
    800044d6:	f4c42783          	lw	a5,-180(s0)
    800044da:	d3bd                	beqz	a5,80004440 <sys_open+0x5e>
      iunlockput(ip);
    800044dc:	8526                	mv	a0,s1
    800044de:	bfcfe0ef          	jal	800028da <iunlockput>
      end_op();
    800044e2:	c43fe0ef          	jal	80003124 <end_op>
      return -1;
    800044e6:	557d                	li	a0,-1
    800044e8:	74aa                	ld	s1,168(sp)
    800044ea:	b7c1                	j	800044aa <sys_open+0xc8>
      end_op();
    800044ec:	c39fe0ef          	jal	80003124 <end_op>
      return -1;
    800044f0:	557d                	li	a0,-1
    800044f2:	74aa                	ld	s1,168(sp)
    800044f4:	bf5d                	j	800044aa <sys_open+0xc8>
    iunlockput(ip);
    800044f6:	8526                	mv	a0,s1
    800044f8:	be2fe0ef          	jal	800028da <iunlockput>
    end_op();
    800044fc:	c29fe0ef          	jal	80003124 <end_op>
    return -1;
    80004500:	557d                	li	a0,-1
    80004502:	74aa                	ld	s1,168(sp)
    80004504:	b75d                	j	800044aa <sys_open+0xc8>
      fileclose(f);
    80004506:	854a                	mv	a0,s2
    80004508:	fbffe0ef          	jal	800034c6 <fileclose>
    8000450c:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    8000450e:	8526                	mv	a0,s1
    80004510:	bcafe0ef          	jal	800028da <iunlockput>
    end_op();
    80004514:	c11fe0ef          	jal	80003124 <end_op>
    return -1;
    80004518:	557d                	li	a0,-1
    8000451a:	74aa                	ld	s1,168(sp)
    8000451c:	790a                	ld	s2,160(sp)
    8000451e:	b771                	j	800044aa <sys_open+0xc8>
    f->type = FD_DEVICE;
    80004520:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80004524:	04649783          	lh	a5,70(s1)
    80004528:	02f91223          	sh	a5,36(s2)
    8000452c:	bf3d                	j	8000446a <sys_open+0x88>
    itrunc(ip);
    8000452e:	8526                	mv	a0,s1
    80004530:	a8efe0ef          	jal	800027be <itrunc>
    80004534:	b795                	j	80004498 <sys_open+0xb6>

0000000080004536 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004536:	7175                	addi	sp,sp,-144
    80004538:	e506                	sd	ra,136(sp)
    8000453a:	e122                	sd	s0,128(sp)
    8000453c:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000453e:	b7dfe0ef          	jal	800030ba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004542:	08000613          	li	a2,128
    80004546:	f7040593          	addi	a1,s0,-144
    8000454a:	4501                	li	a0,0
    8000454c:	f62fd0ef          	jal	80001cae <argstr>
    80004550:	02054363          	bltz	a0,80004576 <sys_mkdir+0x40>
    80004554:	4681                	li	a3,0
    80004556:	4601                	li	a2,0
    80004558:	4585                	li	a1,1
    8000455a:	f7040513          	addi	a0,s0,-144
    8000455e:	96fff0ef          	jal	80003ecc <create>
    80004562:	c911                	beqz	a0,80004576 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004564:	b76fe0ef          	jal	800028da <iunlockput>
  end_op();
    80004568:	bbdfe0ef          	jal	80003124 <end_op>
  return 0;
    8000456c:	4501                	li	a0,0
}
    8000456e:	60aa                	ld	ra,136(sp)
    80004570:	640a                	ld	s0,128(sp)
    80004572:	6149                	addi	sp,sp,144
    80004574:	8082                	ret
    end_op();
    80004576:	baffe0ef          	jal	80003124 <end_op>
    return -1;
    8000457a:	557d                	li	a0,-1
    8000457c:	bfcd                	j	8000456e <sys_mkdir+0x38>

000000008000457e <sys_mknod>:

uint64
sys_mknod(void)
{
    8000457e:	7135                	addi	sp,sp,-160
    80004580:	ed06                	sd	ra,152(sp)
    80004582:	e922                	sd	s0,144(sp)
    80004584:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004586:	b35fe0ef          	jal	800030ba <begin_op>
  argint(1, &major);
    8000458a:	f6c40593          	addi	a1,s0,-148
    8000458e:	4505                	li	a0,1
    80004590:	ee6fd0ef          	jal	80001c76 <argint>
  argint(2, &minor);
    80004594:	f6840593          	addi	a1,s0,-152
    80004598:	4509                	li	a0,2
    8000459a:	edcfd0ef          	jal	80001c76 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000459e:	08000613          	li	a2,128
    800045a2:	f7040593          	addi	a1,s0,-144
    800045a6:	4501                	li	a0,0
    800045a8:	f06fd0ef          	jal	80001cae <argstr>
    800045ac:	02054563          	bltz	a0,800045d6 <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800045b0:	f6841683          	lh	a3,-152(s0)
    800045b4:	f6c41603          	lh	a2,-148(s0)
    800045b8:	458d                	li	a1,3
    800045ba:	f7040513          	addi	a0,s0,-144
    800045be:	90fff0ef          	jal	80003ecc <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800045c2:	c911                	beqz	a0,800045d6 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800045c4:	b16fe0ef          	jal	800028da <iunlockput>
  end_op();
    800045c8:	b5dfe0ef          	jal	80003124 <end_op>
  return 0;
    800045cc:	4501                	li	a0,0
}
    800045ce:	60ea                	ld	ra,152(sp)
    800045d0:	644a                	ld	s0,144(sp)
    800045d2:	610d                	addi	sp,sp,160
    800045d4:	8082                	ret
    end_op();
    800045d6:	b4ffe0ef          	jal	80003124 <end_op>
    return -1;
    800045da:	557d                	li	a0,-1
    800045dc:	bfcd                	j	800045ce <sys_mknod+0x50>

00000000800045de <sys_chdir>:

uint64
sys_chdir(void)
{
    800045de:	7135                	addi	sp,sp,-160
    800045e0:	ed06                	sd	ra,152(sp)
    800045e2:	e922                	sd	s0,144(sp)
    800045e4:	e14a                	sd	s2,128(sp)
    800045e6:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800045e8:	f92fc0ef          	jal	80000d7a <myproc>
    800045ec:	892a                	mv	s2,a0
  
  begin_op();
    800045ee:	acdfe0ef          	jal	800030ba <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800045f2:	08000613          	li	a2,128
    800045f6:	f6040593          	addi	a1,s0,-160
    800045fa:	4501                	li	a0,0
    800045fc:	eb2fd0ef          	jal	80001cae <argstr>
    80004600:	04054363          	bltz	a0,80004646 <sys_chdir+0x68>
    80004604:	e526                	sd	s1,136(sp)
    80004606:	f6040513          	addi	a0,s0,-160
    8000460a:	8ddfe0ef          	jal	80002ee6 <namei>
    8000460e:	84aa                	mv	s1,a0
    80004610:	c915                	beqz	a0,80004644 <sys_chdir+0x66>
    end_op();
    return -1;
  }
  ilock(ip);
    80004612:	8befe0ef          	jal	800026d0 <ilock>
  if(ip->type != T_DIR){
    80004616:	04449703          	lh	a4,68(s1)
    8000461a:	4785                	li	a5,1
    8000461c:	02f71963          	bne	a4,a5,8000464e <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004620:	8526                	mv	a0,s1
    80004622:	95cfe0ef          	jal	8000277e <iunlock>
  iput(p->cwd);
    80004626:	15093503          	ld	a0,336(s2)
    8000462a:	a28fe0ef          	jal	80002852 <iput>
  end_op();
    8000462e:	af7fe0ef          	jal	80003124 <end_op>
  p->cwd = ip;
    80004632:	14993823          	sd	s1,336(s2)
  return 0;
    80004636:	4501                	li	a0,0
    80004638:	64aa                	ld	s1,136(sp)
}
    8000463a:	60ea                	ld	ra,152(sp)
    8000463c:	644a                	ld	s0,144(sp)
    8000463e:	690a                	ld	s2,128(sp)
    80004640:	610d                	addi	sp,sp,160
    80004642:	8082                	ret
    80004644:	64aa                	ld	s1,136(sp)
    end_op();
    80004646:	adffe0ef          	jal	80003124 <end_op>
    return -1;
    8000464a:	557d                	li	a0,-1
    8000464c:	b7fd                	j	8000463a <sys_chdir+0x5c>
    iunlockput(ip);
    8000464e:	8526                	mv	a0,s1
    80004650:	a8afe0ef          	jal	800028da <iunlockput>
    end_op();
    80004654:	ad1fe0ef          	jal	80003124 <end_op>
    return -1;
    80004658:	557d                	li	a0,-1
    8000465a:	64aa                	ld	s1,136(sp)
    8000465c:	bff9                	j	8000463a <sys_chdir+0x5c>

000000008000465e <sys_exec>:

uint64
sys_exec(void)
{
    8000465e:	7121                	addi	sp,sp,-448
    80004660:	ff06                	sd	ra,440(sp)
    80004662:	fb22                	sd	s0,432(sp)
    80004664:	0380                	addi	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004666:	e4840593          	addi	a1,s0,-440
    8000466a:	4505                	li	a0,1
    8000466c:	e26fd0ef          	jal	80001c92 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004670:	08000613          	li	a2,128
    80004674:	f5040593          	addi	a1,s0,-176
    80004678:	4501                	li	a0,0
    8000467a:	e34fd0ef          	jal	80001cae <argstr>
    8000467e:	87aa                	mv	a5,a0
    return -1;
    80004680:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004682:	0c07c463          	bltz	a5,8000474a <sys_exec+0xec>
    80004686:	f726                	sd	s1,424(sp)
    80004688:	f34a                	sd	s2,416(sp)
    8000468a:	ef4e                	sd	s3,408(sp)
    8000468c:	eb52                	sd	s4,400(sp)
  }
  memset(argv, 0, sizeof(argv));
    8000468e:	10000613          	li	a2,256
    80004692:	4581                	li	a1,0
    80004694:	e5040513          	addi	a0,s0,-432
    80004698:	ab7fb0ef          	jal	8000014e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000469c:	e5040493          	addi	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    800046a0:	89a6                	mv	s3,s1
    800046a2:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800046a4:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800046a8:	00391513          	slli	a0,s2,0x3
    800046ac:	e4040593          	addi	a1,s0,-448
    800046b0:	e4843783          	ld	a5,-440(s0)
    800046b4:	953e                	add	a0,a0,a5
    800046b6:	d36fd0ef          	jal	80001bec <fetchaddr>
    800046ba:	02054663          	bltz	a0,800046e6 <sys_exec+0x88>
      goto bad;
    }
    if(uarg == 0){
    800046be:	e4043783          	ld	a5,-448(s0)
    800046c2:	c3a9                	beqz	a5,80004704 <sys_exec+0xa6>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800046c4:	a3bfb0ef          	jal	800000fe <kalloc>
    800046c8:	85aa                	mv	a1,a0
    800046ca:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800046ce:	cd01                	beqz	a0,800046e6 <sys_exec+0x88>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800046d0:	6605                	lui	a2,0x1
    800046d2:	e4043503          	ld	a0,-448(s0)
    800046d6:	d60fd0ef          	jal	80001c36 <fetchstr>
    800046da:	00054663          	bltz	a0,800046e6 <sys_exec+0x88>
    if(i >= NELEM(argv)){
    800046de:	0905                	addi	s2,s2,1
    800046e0:	09a1                	addi	s3,s3,8
    800046e2:	fd4913e3          	bne	s2,s4,800046a8 <sys_exec+0x4a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046e6:	f5040913          	addi	s2,s0,-176
    800046ea:	6088                	ld	a0,0(s1)
    800046ec:	c931                	beqz	a0,80004740 <sys_exec+0xe2>
    kfree(argv[i]);
    800046ee:	92ffb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046f2:	04a1                	addi	s1,s1,8
    800046f4:	ff249be3          	bne	s1,s2,800046ea <sys_exec+0x8c>
  return -1;
    800046f8:	557d                	li	a0,-1
    800046fa:	74ba                	ld	s1,424(sp)
    800046fc:	791a                	ld	s2,416(sp)
    800046fe:	69fa                	ld	s3,408(sp)
    80004700:	6a5a                	ld	s4,400(sp)
    80004702:	a0a1                	j	8000474a <sys_exec+0xec>
      argv[i] = 0;
    80004704:	0009079b          	sext.w	a5,s2
    80004708:	078e                	slli	a5,a5,0x3
    8000470a:	fd078793          	addi	a5,a5,-48
    8000470e:	97a2                	add	a5,a5,s0
    80004710:	e807b023          	sd	zero,-384(a5)
  int ret = kexec(path, argv);
    80004714:	e5040593          	addi	a1,s0,-432
    80004718:	f5040513          	addi	a0,s0,-176
    8000471c:	ba8ff0ef          	jal	80003ac4 <kexec>
    80004720:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004722:	f5040993          	addi	s3,s0,-176
    80004726:	6088                	ld	a0,0(s1)
    80004728:	c511                	beqz	a0,80004734 <sys_exec+0xd6>
    kfree(argv[i]);
    8000472a:	8f3fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000472e:	04a1                	addi	s1,s1,8
    80004730:	ff349be3          	bne	s1,s3,80004726 <sys_exec+0xc8>
  return ret;
    80004734:	854a                	mv	a0,s2
    80004736:	74ba                	ld	s1,424(sp)
    80004738:	791a                	ld	s2,416(sp)
    8000473a:	69fa                	ld	s3,408(sp)
    8000473c:	6a5a                	ld	s4,400(sp)
    8000473e:	a031                	j	8000474a <sys_exec+0xec>
  return -1;
    80004740:	557d                	li	a0,-1
    80004742:	74ba                	ld	s1,424(sp)
    80004744:	791a                	ld	s2,416(sp)
    80004746:	69fa                	ld	s3,408(sp)
    80004748:	6a5a                	ld	s4,400(sp)
}
    8000474a:	70fa                	ld	ra,440(sp)
    8000474c:	745a                	ld	s0,432(sp)
    8000474e:	6139                	addi	sp,sp,448
    80004750:	8082                	ret

0000000080004752 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004752:	7139                	addi	sp,sp,-64
    80004754:	fc06                	sd	ra,56(sp)
    80004756:	f822                	sd	s0,48(sp)
    80004758:	f426                	sd	s1,40(sp)
    8000475a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000475c:	e1efc0ef          	jal	80000d7a <myproc>
    80004760:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004762:	fd840593          	addi	a1,s0,-40
    80004766:	4501                	li	a0,0
    80004768:	d2afd0ef          	jal	80001c92 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000476c:	fc840593          	addi	a1,s0,-56
    80004770:	fd040513          	addi	a0,s0,-48
    80004774:	85cff0ef          	jal	800037d0 <pipealloc>
    return -1;
    80004778:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000477a:	0a054463          	bltz	a0,80004822 <sys_pipe+0xd0>
  fd0 = -1;
    8000477e:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004782:	fd043503          	ld	a0,-48(s0)
    80004786:	f08ff0ef          	jal	80003e8e <fdalloc>
    8000478a:	fca42223          	sw	a0,-60(s0)
    8000478e:	08054163          	bltz	a0,80004810 <sys_pipe+0xbe>
    80004792:	fc843503          	ld	a0,-56(s0)
    80004796:	ef8ff0ef          	jal	80003e8e <fdalloc>
    8000479a:	fca42023          	sw	a0,-64(s0)
    8000479e:	06054063          	bltz	a0,800047fe <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800047a2:	4691                	li	a3,4
    800047a4:	fc440613          	addi	a2,s0,-60
    800047a8:	fd843583          	ld	a1,-40(s0)
    800047ac:	68a8                	ld	a0,80(s1)
    800047ae:	ae0fc0ef          	jal	80000a8e <copyout>
    800047b2:	00054e63          	bltz	a0,800047ce <sys_pipe+0x7c>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800047b6:	4691                	li	a3,4
    800047b8:	fc040613          	addi	a2,s0,-64
    800047bc:	fd843583          	ld	a1,-40(s0)
    800047c0:	0591                	addi	a1,a1,4
    800047c2:	68a8                	ld	a0,80(s1)
    800047c4:	acafc0ef          	jal	80000a8e <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800047c8:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800047ca:	04055c63          	bgez	a0,80004822 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    800047ce:	fc442783          	lw	a5,-60(s0)
    800047d2:	07e9                	addi	a5,a5,26
    800047d4:	078e                	slli	a5,a5,0x3
    800047d6:	97a6                	add	a5,a5,s1
    800047d8:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800047dc:	fc042783          	lw	a5,-64(s0)
    800047e0:	07e9                	addi	a5,a5,26
    800047e2:	078e                	slli	a5,a5,0x3
    800047e4:	94be                	add	s1,s1,a5
    800047e6:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800047ea:	fd043503          	ld	a0,-48(s0)
    800047ee:	cd9fe0ef          	jal	800034c6 <fileclose>
    fileclose(wf);
    800047f2:	fc843503          	ld	a0,-56(s0)
    800047f6:	cd1fe0ef          	jal	800034c6 <fileclose>
    return -1;
    800047fa:	57fd                	li	a5,-1
    800047fc:	a01d                	j	80004822 <sys_pipe+0xd0>
    if(fd0 >= 0)
    800047fe:	fc442783          	lw	a5,-60(s0)
    80004802:	0007c763          	bltz	a5,80004810 <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    80004806:	07e9                	addi	a5,a5,26
    80004808:	078e                	slli	a5,a5,0x3
    8000480a:	97a6                	add	a5,a5,s1
    8000480c:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80004810:	fd043503          	ld	a0,-48(s0)
    80004814:	cb3fe0ef          	jal	800034c6 <fileclose>
    fileclose(wf);
    80004818:	fc843503          	ld	a0,-56(s0)
    8000481c:	cabfe0ef          	jal	800034c6 <fileclose>
    return -1;
    80004820:	57fd                	li	a5,-1
}
    80004822:	853e                	mv	a0,a5
    80004824:	70e2                	ld	ra,56(sp)
    80004826:	7442                	ld	s0,48(sp)
    80004828:	74a2                	ld	s1,40(sp)
    8000482a:	6121                	addi	sp,sp,64
    8000482c:	8082                	ret
	...

0000000080004830 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80004830:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80004832:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80004834:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80004836:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80004838:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000483a:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000483c:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    8000483e:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80004840:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80004842:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80004844:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80004846:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80004848:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000484a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000484c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000484e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80004850:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80004852:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80004854:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80004856:	aa6fd0ef          	jal	80001afc <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000485a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000485c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000485e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80004860:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80004862:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80004864:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80004866:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80004868:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000486a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000486c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000486e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80004870:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80004872:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80004874:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80004876:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80004878:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000487a:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    8000487c:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    8000487e:	10200073          	sret
	...

000000008000488e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000488e:	1141                	addi	sp,sp,-16
    80004890:	e422                	sd	s0,8(sp)
    80004892:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004894:	0c0007b7          	lui	a5,0xc000
    80004898:	4705                	li	a4,1
    8000489a:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000489c:	0c0007b7          	lui	a5,0xc000
    800048a0:	c3d8                	sw	a4,4(a5)
}
    800048a2:	6422                	ld	s0,8(sp)
    800048a4:	0141                	addi	sp,sp,16
    800048a6:	8082                	ret

00000000800048a8 <plicinithart>:

void
plicinithart(void)
{
    800048a8:	1141                	addi	sp,sp,-16
    800048aa:	e406                	sd	ra,8(sp)
    800048ac:	e022                	sd	s0,0(sp)
    800048ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800048b0:	c9efc0ef          	jal	80000d4e <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800048b4:	0085171b          	slliw	a4,a0,0x8
    800048b8:	0c0027b7          	lui	a5,0xc002
    800048bc:	97ba                	add	a5,a5,a4
    800048be:	40200713          	li	a4,1026
    800048c2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800048c6:	00d5151b          	slliw	a0,a0,0xd
    800048ca:	0c2017b7          	lui	a5,0xc201
    800048ce:	97aa                	add	a5,a5,a0
    800048d0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800048d4:	60a2                	ld	ra,8(sp)
    800048d6:	6402                	ld	s0,0(sp)
    800048d8:	0141                	addi	sp,sp,16
    800048da:	8082                	ret

00000000800048dc <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800048dc:	1141                	addi	sp,sp,-16
    800048de:	e406                	sd	ra,8(sp)
    800048e0:	e022                	sd	s0,0(sp)
    800048e2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800048e4:	c6afc0ef          	jal	80000d4e <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800048e8:	00d5151b          	slliw	a0,a0,0xd
    800048ec:	0c2017b7          	lui	a5,0xc201
    800048f0:	97aa                	add	a5,a5,a0
  return irq;
}
    800048f2:	43c8                	lw	a0,4(a5)
    800048f4:	60a2                	ld	ra,8(sp)
    800048f6:	6402                	ld	s0,0(sp)
    800048f8:	0141                	addi	sp,sp,16
    800048fa:	8082                	ret

00000000800048fc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800048fc:	1101                	addi	sp,sp,-32
    800048fe:	ec06                	sd	ra,24(sp)
    80004900:	e822                	sd	s0,16(sp)
    80004902:	e426                	sd	s1,8(sp)
    80004904:	1000                	addi	s0,sp,32
    80004906:	84aa                	mv	s1,a0
  int hart = cpuid();
    80004908:	c46fc0ef          	jal	80000d4e <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000490c:	00d5151b          	slliw	a0,a0,0xd
    80004910:	0c2017b7          	lui	a5,0xc201
    80004914:	97aa                	add	a5,a5,a0
    80004916:	c3c4                	sw	s1,4(a5)
}
    80004918:	60e2                	ld	ra,24(sp)
    8000491a:	6442                	ld	s0,16(sp)
    8000491c:	64a2                	ld	s1,8(sp)
    8000491e:	6105                	addi	sp,sp,32
    80004920:	8082                	ret

0000000080004922 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80004922:	1141                	addi	sp,sp,-16
    80004924:	e406                	sd	ra,8(sp)
    80004926:	e022                	sd	s0,0(sp)
    80004928:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000492a:	479d                	li	a5,7
    8000492c:	04a7ca63          	blt	a5,a0,80004980 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004930:	00017797          	auipc	a5,0x17
    80004934:	9b078793          	addi	a5,a5,-1616 # 8001b2e0 <disk>
    80004938:	97aa                	add	a5,a5,a0
    8000493a:	0187c783          	lbu	a5,24(a5)
    8000493e:	e7b9                	bnez	a5,8000498c <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004940:	00451693          	slli	a3,a0,0x4
    80004944:	00017797          	auipc	a5,0x17
    80004948:	99c78793          	addi	a5,a5,-1636 # 8001b2e0 <disk>
    8000494c:	6398                	ld	a4,0(a5)
    8000494e:	9736                	add	a4,a4,a3
    80004950:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    80004954:	6398                	ld	a4,0(a5)
    80004956:	9736                	add	a4,a4,a3
    80004958:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000495c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004960:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004964:	97aa                	add	a5,a5,a0
    80004966:	4705                	li	a4,1
    80004968:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    8000496c:	00017517          	auipc	a0,0x17
    80004970:	98c50513          	addi	a0,a0,-1652 # 8001b2f8 <disk+0x18>
    80004974:	a4bfc0ef          	jal	800013be <wakeup>
}
    80004978:	60a2                	ld	ra,8(sp)
    8000497a:	6402                	ld	s0,0(sp)
    8000497c:	0141                	addi	sp,sp,16
    8000497e:	8082                	ret
    panic("free_desc 1");
    80004980:	00003517          	auipc	a0,0x3
    80004984:	c5050513          	addi	a0,a0,-944 # 800075d0 <etext+0x5d0>
    80004988:	487000ef          	jal	8000560e <panic>
    panic("free_desc 2");
    8000498c:	00003517          	auipc	a0,0x3
    80004990:	c5450513          	addi	a0,a0,-940 # 800075e0 <etext+0x5e0>
    80004994:	47b000ef          	jal	8000560e <panic>

0000000080004998 <virtio_disk_init>:
{
    80004998:	1101                	addi	sp,sp,-32
    8000499a:	ec06                	sd	ra,24(sp)
    8000499c:	e822                	sd	s0,16(sp)
    8000499e:	e426                	sd	s1,8(sp)
    800049a0:	e04a                	sd	s2,0(sp)
    800049a2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800049a4:	00003597          	auipc	a1,0x3
    800049a8:	c4c58593          	addi	a1,a1,-948 # 800075f0 <etext+0x5f0>
    800049ac:	00017517          	auipc	a0,0x17
    800049b0:	a5c50513          	addi	a0,a0,-1444 # 8001b408 <disk+0x128>
    800049b4:	697000ef          	jal	8000584a <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800049b8:	100017b7          	lui	a5,0x10001
    800049bc:	4398                	lw	a4,0(a5)
    800049be:	2701                	sext.w	a4,a4
    800049c0:	747277b7          	lui	a5,0x74727
    800049c4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800049c8:	18f71063          	bne	a4,a5,80004b48 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800049cc:	100017b7          	lui	a5,0x10001
    800049d0:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    800049d2:	439c                	lw	a5,0(a5)
    800049d4:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800049d6:	4709                	li	a4,2
    800049d8:	16e79863          	bne	a5,a4,80004b48 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049dc:	100017b7          	lui	a5,0x10001
    800049e0:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    800049e2:	439c                	lw	a5,0(a5)
    800049e4:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800049e6:	16e79163          	bne	a5,a4,80004b48 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800049ea:	100017b7          	lui	a5,0x10001
    800049ee:	47d8                	lw	a4,12(a5)
    800049f0:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049f2:	554d47b7          	lui	a5,0x554d4
    800049f6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800049fa:	14f71763          	bne	a4,a5,80004b48 <virtio_disk_init+0x1b0>
  *R(VIRTIO_MMIO_STATUS) = status;
    800049fe:	100017b7          	lui	a5,0x10001
    80004a02:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a06:	4705                	li	a4,1
    80004a08:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a0a:	470d                	li	a4,3
    80004a0c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80004a0e:	10001737          	lui	a4,0x10001
    80004a12:	4b14                	lw	a3,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80004a14:	c7ffe737          	lui	a4,0xc7ffe
    80004a18:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb267>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80004a1c:	8ef9                	and	a3,a3,a4
    80004a1e:	10001737          	lui	a4,0x10001
    80004a22:	d314                	sw	a3,32(a4)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a24:	472d                	li	a4,11
    80004a26:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a28:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    80004a2c:	439c                	lw	a5,0(a5)
    80004a2e:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80004a32:	8ba1                	andi	a5,a5,8
    80004a34:	12078063          	beqz	a5,80004b54 <virtio_disk_init+0x1bc>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004a38:	100017b7          	lui	a5,0x10001
    80004a3c:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80004a40:	100017b7          	lui	a5,0x10001
    80004a44:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    80004a48:	439c                	lw	a5,0(a5)
    80004a4a:	2781                	sext.w	a5,a5
    80004a4c:	10079a63          	bnez	a5,80004b60 <virtio_disk_init+0x1c8>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004a50:	100017b7          	lui	a5,0x10001
    80004a54:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80004a58:	439c                	lw	a5,0(a5)
    80004a5a:	2781                	sext.w	a5,a5
  if(max == 0)
    80004a5c:	10078863          	beqz	a5,80004b6c <virtio_disk_init+0x1d4>
  if(max < NUM)
    80004a60:	471d                	li	a4,7
    80004a62:	10f77b63          	bgeu	a4,a5,80004b78 <virtio_disk_init+0x1e0>
  disk.desc = kalloc();
    80004a66:	e98fb0ef          	jal	800000fe <kalloc>
    80004a6a:	00017497          	auipc	s1,0x17
    80004a6e:	87648493          	addi	s1,s1,-1930 # 8001b2e0 <disk>
    80004a72:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004a74:	e8afb0ef          	jal	800000fe <kalloc>
    80004a78:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80004a7a:	e84fb0ef          	jal	800000fe <kalloc>
    80004a7e:	87aa                	mv	a5,a0
    80004a80:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004a82:	6088                	ld	a0,0(s1)
    80004a84:	10050063          	beqz	a0,80004b84 <virtio_disk_init+0x1ec>
    80004a88:	00017717          	auipc	a4,0x17
    80004a8c:	86073703          	ld	a4,-1952(a4) # 8001b2e8 <disk+0x8>
    80004a90:	0e070a63          	beqz	a4,80004b84 <virtio_disk_init+0x1ec>
    80004a94:	0e078863          	beqz	a5,80004b84 <virtio_disk_init+0x1ec>
  memset(disk.desc, 0, PGSIZE);
    80004a98:	6605                	lui	a2,0x1
    80004a9a:	4581                	li	a1,0
    80004a9c:	eb2fb0ef          	jal	8000014e <memset>
  memset(disk.avail, 0, PGSIZE);
    80004aa0:	00017497          	auipc	s1,0x17
    80004aa4:	84048493          	addi	s1,s1,-1984 # 8001b2e0 <disk>
    80004aa8:	6605                	lui	a2,0x1
    80004aaa:	4581                	li	a1,0
    80004aac:	6488                	ld	a0,8(s1)
    80004aae:	ea0fb0ef          	jal	8000014e <memset>
  memset(disk.used, 0, PGSIZE);
    80004ab2:	6605                	lui	a2,0x1
    80004ab4:	4581                	li	a1,0
    80004ab6:	6888                	ld	a0,16(s1)
    80004ab8:	e96fb0ef          	jal	8000014e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80004abc:	100017b7          	lui	a5,0x10001
    80004ac0:	4721                	li	a4,8
    80004ac2:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80004ac4:	4098                	lw	a4,0(s1)
    80004ac6:	100017b7          	lui	a5,0x10001
    80004aca:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80004ace:	40d8                	lw	a4,4(s1)
    80004ad0:	100017b7          	lui	a5,0x10001
    80004ad4:	08e7a223          	sw	a4,132(a5) # 10001084 <_entry-0x6fffef7c>
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80004ad8:	649c                	ld	a5,8(s1)
    80004ada:	0007869b          	sext.w	a3,a5
    80004ade:	10001737          	lui	a4,0x10001
    80004ae2:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80004ae6:	9781                	srai	a5,a5,0x20
    80004ae8:	10001737          	lui	a4,0x10001
    80004aec:	08f72a23          	sw	a5,148(a4) # 10001094 <_entry-0x6fffef6c>
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80004af0:	689c                	ld	a5,16(s1)
    80004af2:	0007869b          	sext.w	a3,a5
    80004af6:	10001737          	lui	a4,0x10001
    80004afa:	0ad72023          	sw	a3,160(a4) # 100010a0 <_entry-0x6fffef60>
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80004afe:	9781                	srai	a5,a5,0x20
    80004b00:	10001737          	lui	a4,0x10001
    80004b04:	0af72223          	sw	a5,164(a4) # 100010a4 <_entry-0x6fffef5c>
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004b08:	10001737          	lui	a4,0x10001
    80004b0c:	4785                	li	a5,1
    80004b0e:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004b10:	00f48c23          	sb	a5,24(s1)
    80004b14:	00f48ca3          	sb	a5,25(s1)
    80004b18:	00f48d23          	sb	a5,26(s1)
    80004b1c:	00f48da3          	sb	a5,27(s1)
    80004b20:	00f48e23          	sb	a5,28(s1)
    80004b24:	00f48ea3          	sb	a5,29(s1)
    80004b28:	00f48f23          	sb	a5,30(s1)
    80004b2c:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004b30:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004b34:	100017b7          	lui	a5,0x10001
    80004b38:	0727a823          	sw	s2,112(a5) # 10001070 <_entry-0x6fffef90>
}
    80004b3c:	60e2                	ld	ra,24(sp)
    80004b3e:	6442                	ld	s0,16(sp)
    80004b40:	64a2                	ld	s1,8(sp)
    80004b42:	6902                	ld	s2,0(sp)
    80004b44:	6105                	addi	sp,sp,32
    80004b46:	8082                	ret
    panic("could not find virtio disk");
    80004b48:	00003517          	auipc	a0,0x3
    80004b4c:	ab850513          	addi	a0,a0,-1352 # 80007600 <etext+0x600>
    80004b50:	2bf000ef          	jal	8000560e <panic>
    panic("virtio disk FEATURES_OK unset");
    80004b54:	00003517          	auipc	a0,0x3
    80004b58:	acc50513          	addi	a0,a0,-1332 # 80007620 <etext+0x620>
    80004b5c:	2b3000ef          	jal	8000560e <panic>
    panic("virtio disk should not be ready");
    80004b60:	00003517          	auipc	a0,0x3
    80004b64:	ae050513          	addi	a0,a0,-1312 # 80007640 <etext+0x640>
    80004b68:	2a7000ef          	jal	8000560e <panic>
    panic("virtio disk has no queue 0");
    80004b6c:	00003517          	auipc	a0,0x3
    80004b70:	af450513          	addi	a0,a0,-1292 # 80007660 <etext+0x660>
    80004b74:	29b000ef          	jal	8000560e <panic>
    panic("virtio disk max queue too short");
    80004b78:	00003517          	auipc	a0,0x3
    80004b7c:	b0850513          	addi	a0,a0,-1272 # 80007680 <etext+0x680>
    80004b80:	28f000ef          	jal	8000560e <panic>
    panic("virtio disk kalloc");
    80004b84:	00003517          	auipc	a0,0x3
    80004b88:	b1c50513          	addi	a0,a0,-1252 # 800076a0 <etext+0x6a0>
    80004b8c:	283000ef          	jal	8000560e <panic>

0000000080004b90 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004b90:	7159                	addi	sp,sp,-112
    80004b92:	f486                	sd	ra,104(sp)
    80004b94:	f0a2                	sd	s0,96(sp)
    80004b96:	eca6                	sd	s1,88(sp)
    80004b98:	e8ca                	sd	s2,80(sp)
    80004b9a:	e4ce                	sd	s3,72(sp)
    80004b9c:	e0d2                	sd	s4,64(sp)
    80004b9e:	fc56                	sd	s5,56(sp)
    80004ba0:	f85a                	sd	s6,48(sp)
    80004ba2:	f45e                	sd	s7,40(sp)
    80004ba4:	f062                	sd	s8,32(sp)
    80004ba6:	ec66                	sd	s9,24(sp)
    80004ba8:	1880                	addi	s0,sp,112
    80004baa:	8a2a                	mv	s4,a0
    80004bac:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004bae:	00c52c83          	lw	s9,12(a0)
    80004bb2:	001c9c9b          	slliw	s9,s9,0x1
    80004bb6:	1c82                	slli	s9,s9,0x20
    80004bb8:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80004bbc:	00017517          	auipc	a0,0x17
    80004bc0:	84c50513          	addi	a0,a0,-1972 # 8001b408 <disk+0x128>
    80004bc4:	507000ef          	jal	800058ca <acquire>
  for(int i = 0; i < 3; i++){
    80004bc8:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80004bca:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004bcc:	00016b17          	auipc	s6,0x16
    80004bd0:	714b0b13          	addi	s6,s6,1812 # 8001b2e0 <disk>
  for(int i = 0; i < 3; i++){
    80004bd4:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004bd6:	00017c17          	auipc	s8,0x17
    80004bda:	832c0c13          	addi	s8,s8,-1998 # 8001b408 <disk+0x128>
    80004bde:	a8b9                	j	80004c3c <virtio_disk_rw+0xac>
      disk.free[i] = 0;
    80004be0:	00fb0733          	add	a4,s6,a5
    80004be4:	00070c23          	sb	zero,24(a4) # 10001018 <_entry-0x6fffefe8>
    idx[i] = alloc_desc();
    80004be8:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004bea:	0207c563          	bltz	a5,80004c14 <virtio_disk_rw+0x84>
  for(int i = 0; i < 3; i++){
    80004bee:	2905                	addiw	s2,s2,1
    80004bf0:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004bf2:	05590963          	beq	s2,s5,80004c44 <virtio_disk_rw+0xb4>
    idx[i] = alloc_desc();
    80004bf6:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004bf8:	00016717          	auipc	a4,0x16
    80004bfc:	6e870713          	addi	a4,a4,1768 # 8001b2e0 <disk>
    80004c00:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80004c02:	01874683          	lbu	a3,24(a4)
    80004c06:	fee9                	bnez	a3,80004be0 <virtio_disk_rw+0x50>
  for(int i = 0; i < NUM; i++){
    80004c08:	2785                	addiw	a5,a5,1
    80004c0a:	0705                	addi	a4,a4,1
    80004c0c:	fe979be3          	bne	a5,s1,80004c02 <virtio_disk_rw+0x72>
    idx[i] = alloc_desc();
    80004c10:	57fd                	li	a5,-1
    80004c12:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80004c14:	01205d63          	blez	s2,80004c2e <virtio_disk_rw+0x9e>
        free_desc(idx[j]);
    80004c18:	f9042503          	lw	a0,-112(s0)
    80004c1c:	d07ff0ef          	jal	80004922 <free_desc>
      for(int j = 0; j < i; j++)
    80004c20:	4785                	li	a5,1
    80004c22:	0127d663          	bge	a5,s2,80004c2e <virtio_disk_rw+0x9e>
        free_desc(idx[j]);
    80004c26:	f9442503          	lw	a0,-108(s0)
    80004c2a:	cf9ff0ef          	jal	80004922 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004c2e:	85e2                	mv	a1,s8
    80004c30:	00016517          	auipc	a0,0x16
    80004c34:	6c850513          	addi	a0,a0,1736 # 8001b2f8 <disk+0x18>
    80004c38:	f3afc0ef          	jal	80001372 <sleep>
  for(int i = 0; i < 3; i++){
    80004c3c:	f9040613          	addi	a2,s0,-112
    80004c40:	894e                	mv	s2,s3
    80004c42:	bf55                	j	80004bf6 <virtio_disk_rw+0x66>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004c44:	f9042503          	lw	a0,-112(s0)
    80004c48:	00451693          	slli	a3,a0,0x4

  if(write)
    80004c4c:	00016797          	auipc	a5,0x16
    80004c50:	69478793          	addi	a5,a5,1684 # 8001b2e0 <disk>
    80004c54:	00a50713          	addi	a4,a0,10
    80004c58:	0712                	slli	a4,a4,0x4
    80004c5a:	973e                	add	a4,a4,a5
    80004c5c:	01703633          	snez	a2,s7
    80004c60:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004c62:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004c66:	01973823          	sd	s9,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c6a:	6398                	ld	a4,0(a5)
    80004c6c:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004c6e:	0a868613          	addi	a2,a3,168
    80004c72:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c74:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004c76:	6390                	ld	a2,0(a5)
    80004c78:	00d605b3          	add	a1,a2,a3
    80004c7c:	4741                	li	a4,16
    80004c7e:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004c80:	4805                	li	a6,1
    80004c82:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004c86:	f9442703          	lw	a4,-108(s0)
    80004c8a:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004c8e:	0712                	slli	a4,a4,0x4
    80004c90:	963a                	add	a2,a2,a4
    80004c92:	058a0593          	addi	a1,s4,88
    80004c96:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004c98:	0007b883          	ld	a7,0(a5)
    80004c9c:	9746                	add	a4,a4,a7
    80004c9e:	40000613          	li	a2,1024
    80004ca2:	c710                	sw	a2,8(a4)
  if(write)
    80004ca4:	001bb613          	seqz	a2,s7
    80004ca8:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004cac:	00166613          	ori	a2,a2,1
    80004cb0:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004cb4:	f9842583          	lw	a1,-104(s0)
    80004cb8:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004cbc:	00250613          	addi	a2,a0,2
    80004cc0:	0612                	slli	a2,a2,0x4
    80004cc2:	963e                	add	a2,a2,a5
    80004cc4:	577d                	li	a4,-1
    80004cc6:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004cca:	0592                	slli	a1,a1,0x4
    80004ccc:	98ae                	add	a7,a7,a1
    80004cce:	03068713          	addi	a4,a3,48
    80004cd2:	973e                	add	a4,a4,a5
    80004cd4:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004cd8:	6398                	ld	a4,0(a5)
    80004cda:	972e                	add	a4,a4,a1
    80004cdc:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004ce0:	4689                	li	a3,2
    80004ce2:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004ce6:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004cea:	010a2223          	sw	a6,4(s4)
  disk.info[idx[0]].b = b;
    80004cee:	01463423          	sd	s4,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004cf2:	6794                	ld	a3,8(a5)
    80004cf4:	0026d703          	lhu	a4,2(a3)
    80004cf8:	8b1d                	andi	a4,a4,7
    80004cfa:	0706                	slli	a4,a4,0x1
    80004cfc:	96ba                	add	a3,a3,a4
    80004cfe:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004d02:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004d06:	6798                	ld	a4,8(a5)
    80004d08:	00275783          	lhu	a5,2(a4)
    80004d0c:	2785                	addiw	a5,a5,1
    80004d0e:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004d12:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004d16:	100017b7          	lui	a5,0x10001
    80004d1a:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004d1e:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    80004d22:	00016917          	auipc	s2,0x16
    80004d26:	6e690913          	addi	s2,s2,1766 # 8001b408 <disk+0x128>
  while(b->disk == 1) {
    80004d2a:	4485                	li	s1,1
    80004d2c:	01079a63          	bne	a5,a6,80004d40 <virtio_disk_rw+0x1b0>
    sleep(b, &disk.vdisk_lock);
    80004d30:	85ca                	mv	a1,s2
    80004d32:	8552                	mv	a0,s4
    80004d34:	e3efc0ef          	jal	80001372 <sleep>
  while(b->disk == 1) {
    80004d38:	004a2783          	lw	a5,4(s4)
    80004d3c:	fe978ae3          	beq	a5,s1,80004d30 <virtio_disk_rw+0x1a0>
  }

  disk.info[idx[0]].b = 0;
    80004d40:	f9042903          	lw	s2,-112(s0)
    80004d44:	00290713          	addi	a4,s2,2
    80004d48:	0712                	slli	a4,a4,0x4
    80004d4a:	00016797          	auipc	a5,0x16
    80004d4e:	59678793          	addi	a5,a5,1430 # 8001b2e0 <disk>
    80004d52:	97ba                	add	a5,a5,a4
    80004d54:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004d58:	00016997          	auipc	s3,0x16
    80004d5c:	58898993          	addi	s3,s3,1416 # 8001b2e0 <disk>
    80004d60:	00491713          	slli	a4,s2,0x4
    80004d64:	0009b783          	ld	a5,0(s3)
    80004d68:	97ba                	add	a5,a5,a4
    80004d6a:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004d6e:	854a                	mv	a0,s2
    80004d70:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004d74:	bafff0ef          	jal	80004922 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004d78:	8885                	andi	s1,s1,1
    80004d7a:	f0fd                	bnez	s1,80004d60 <virtio_disk_rw+0x1d0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004d7c:	00016517          	auipc	a0,0x16
    80004d80:	68c50513          	addi	a0,a0,1676 # 8001b408 <disk+0x128>
    80004d84:	3df000ef          	jal	80005962 <release>
}
    80004d88:	70a6                	ld	ra,104(sp)
    80004d8a:	7406                	ld	s0,96(sp)
    80004d8c:	64e6                	ld	s1,88(sp)
    80004d8e:	6946                	ld	s2,80(sp)
    80004d90:	69a6                	ld	s3,72(sp)
    80004d92:	6a06                	ld	s4,64(sp)
    80004d94:	7ae2                	ld	s5,56(sp)
    80004d96:	7b42                	ld	s6,48(sp)
    80004d98:	7ba2                	ld	s7,40(sp)
    80004d9a:	7c02                	ld	s8,32(sp)
    80004d9c:	6ce2                	ld	s9,24(sp)
    80004d9e:	6165                	addi	sp,sp,112
    80004da0:	8082                	ret

0000000080004da2 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004da2:	1101                	addi	sp,sp,-32
    80004da4:	ec06                	sd	ra,24(sp)
    80004da6:	e822                	sd	s0,16(sp)
    80004da8:	e426                	sd	s1,8(sp)
    80004daa:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004dac:	00016497          	auipc	s1,0x16
    80004db0:	53448493          	addi	s1,s1,1332 # 8001b2e0 <disk>
    80004db4:	00016517          	auipc	a0,0x16
    80004db8:	65450513          	addi	a0,a0,1620 # 8001b408 <disk+0x128>
    80004dbc:	30f000ef          	jal	800058ca <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004dc0:	100017b7          	lui	a5,0x10001
    80004dc4:	53b8                	lw	a4,96(a5)
    80004dc6:	8b0d                	andi	a4,a4,3
    80004dc8:	100017b7          	lui	a5,0x10001
    80004dcc:	d3f8                	sw	a4,100(a5)

  __sync_synchronize();
    80004dce:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004dd2:	689c                	ld	a5,16(s1)
    80004dd4:	0204d703          	lhu	a4,32(s1)
    80004dd8:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004ddc:	04f70663          	beq	a4,a5,80004e28 <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004de0:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004de4:	6898                	ld	a4,16(s1)
    80004de6:	0204d783          	lhu	a5,32(s1)
    80004dea:	8b9d                	andi	a5,a5,7
    80004dec:	078e                	slli	a5,a5,0x3
    80004dee:	97ba                	add	a5,a5,a4
    80004df0:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004df2:	00278713          	addi	a4,a5,2
    80004df6:	0712                	slli	a4,a4,0x4
    80004df8:	9726                	add	a4,a4,s1
    80004dfa:	01074703          	lbu	a4,16(a4)
    80004dfe:	e321                	bnez	a4,80004e3e <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004e00:	0789                	addi	a5,a5,2
    80004e02:	0792                	slli	a5,a5,0x4
    80004e04:	97a6                	add	a5,a5,s1
    80004e06:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004e08:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004e0c:	db2fc0ef          	jal	800013be <wakeup>

    disk.used_idx += 1;
    80004e10:	0204d783          	lhu	a5,32(s1)
    80004e14:	2785                	addiw	a5,a5,1
    80004e16:	17c2                	slli	a5,a5,0x30
    80004e18:	93c1                	srli	a5,a5,0x30
    80004e1a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004e1e:	6898                	ld	a4,16(s1)
    80004e20:	00275703          	lhu	a4,2(a4)
    80004e24:	faf71ee3          	bne	a4,a5,80004de0 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004e28:	00016517          	auipc	a0,0x16
    80004e2c:	5e050513          	addi	a0,a0,1504 # 8001b408 <disk+0x128>
    80004e30:	333000ef          	jal	80005962 <release>
}
    80004e34:	60e2                	ld	ra,24(sp)
    80004e36:	6442                	ld	s0,16(sp)
    80004e38:	64a2                	ld	s1,8(sp)
    80004e3a:	6105                	addi	sp,sp,32
    80004e3c:	8082                	ret
      panic("virtio_disk_intr status");
    80004e3e:	00003517          	auipc	a0,0x3
    80004e42:	87a50513          	addi	a0,a0,-1926 # 800076b8 <etext+0x6b8>
    80004e46:	7c8000ef          	jal	8000560e <panic>

0000000080004e4a <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004e4a:	1141                	addi	sp,sp,-16
    80004e4c:	e422                	sd	s0,8(sp)
    80004e4e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004e50:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004e54:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004e58:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004e5c:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004e60:	577d                	li	a4,-1
    80004e62:	177e                	slli	a4,a4,0x3f
    80004e64:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004e66:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004e6a:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004e6e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004e72:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004e76:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004e7a:	000f4737          	lui	a4,0xf4
    80004e7e:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004e82:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004e84:	14d79073          	csrw	stimecmp,a5
}
    80004e88:	6422                	ld	s0,8(sp)
    80004e8a:	0141                	addi	sp,sp,16
    80004e8c:	8082                	ret

0000000080004e8e <start>:
{
    80004e8e:	1141                	addi	sp,sp,-16
    80004e90:	e406                	sd	ra,8(sp)
    80004e92:	e022                	sd	s0,0(sp)
    80004e94:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004e96:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004e9a:	7779                	lui	a4,0xffffe
    80004e9c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdb307>
    80004ea0:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004ea2:	6705                	lui	a4,0x1
    80004ea4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004ea8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004eaa:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004eae:	ffffb797          	auipc	a5,0xffffb
    80004eb2:	43a78793          	addi	a5,a5,1082 # 800002e8 <main>
    80004eb6:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004eba:	4781                	li	a5,0
    80004ebc:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004ec0:	67c1                	lui	a5,0x10
    80004ec2:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004ec4:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004ec8:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004ecc:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    80004ed0:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r" (x));
    80004ed4:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004ed8:	57fd                	li	a5,-1
    80004eda:	83a9                	srli	a5,a5,0xa
    80004edc:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004ee0:	47bd                	li	a5,15
    80004ee2:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004ee6:	f65ff0ef          	jal	80004e4a <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004eea:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004eee:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004ef0:	823e                	mv	tp,a5
  asm volatile("mret");
    80004ef2:	30200073          	mret
}
    80004ef6:	60a2                	ld	ra,8(sp)
    80004ef8:	6402                	ld	s0,0(sp)
    80004efa:	0141                	addi	sp,sp,16
    80004efc:	8082                	ret

0000000080004efe <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004efe:	7119                	addi	sp,sp,-128
    80004f00:	fc86                	sd	ra,120(sp)
    80004f02:	f8a2                	sd	s0,112(sp)
    80004f04:	f4a6                	sd	s1,104(sp)
    80004f06:	0100                	addi	s0,sp,128
  char buf[32];
  int i = 0;

  while(i < n){
    80004f08:	06c05a63          	blez	a2,80004f7c <consolewrite+0x7e>
    80004f0c:	f0ca                	sd	s2,96(sp)
    80004f0e:	ecce                	sd	s3,88(sp)
    80004f10:	e8d2                	sd	s4,80(sp)
    80004f12:	e4d6                	sd	s5,72(sp)
    80004f14:	e0da                	sd	s6,64(sp)
    80004f16:	fc5e                	sd	s7,56(sp)
    80004f18:	f862                	sd	s8,48(sp)
    80004f1a:	f466                	sd	s9,40(sp)
    80004f1c:	8aaa                	mv	s5,a0
    80004f1e:	8b2e                	mv	s6,a1
    80004f20:	8a32                	mv	s4,a2
  int i = 0;
    80004f22:	4481                	li	s1,0
    int nn = sizeof(buf);
    if(nn > n - i)
    80004f24:	02000c13          	li	s8,32
    80004f28:	02000c93          	li	s9,32
      nn = n - i;
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004f2c:	5bfd                	li	s7,-1
    80004f2e:	a035                	j	80004f5a <consolewrite+0x5c>
    if(nn > n - i)
    80004f30:	0009099b          	sext.w	s3,s2
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004f34:	86ce                	mv	a3,s3
    80004f36:	01648633          	add	a2,s1,s6
    80004f3a:	85d6                	mv	a1,s5
    80004f3c:	f8040513          	addi	a0,s0,-128
    80004f40:	fd8fc0ef          	jal	80001718 <either_copyin>
    80004f44:	03750e63          	beq	a0,s7,80004f80 <consolewrite+0x82>
      break;
    uartwrite(buf, nn);
    80004f48:	85ce                	mv	a1,s3
    80004f4a:	f8040513          	addi	a0,s0,-128
    80004f4e:	778000ef          	jal	800056c6 <uartwrite>
    i += nn;
    80004f52:	009904bb          	addw	s1,s2,s1
  while(i < n){
    80004f56:	0144da63          	bge	s1,s4,80004f6a <consolewrite+0x6c>
    if(nn > n - i)
    80004f5a:	409a093b          	subw	s2,s4,s1
    80004f5e:	0009079b          	sext.w	a5,s2
    80004f62:	fcfc57e3          	bge	s8,a5,80004f30 <consolewrite+0x32>
    80004f66:	8966                	mv	s2,s9
    80004f68:	b7e1                	j	80004f30 <consolewrite+0x32>
    80004f6a:	7906                	ld	s2,96(sp)
    80004f6c:	69e6                	ld	s3,88(sp)
    80004f6e:	6a46                	ld	s4,80(sp)
    80004f70:	6aa6                	ld	s5,72(sp)
    80004f72:	6b06                	ld	s6,64(sp)
    80004f74:	7be2                	ld	s7,56(sp)
    80004f76:	7c42                	ld	s8,48(sp)
    80004f78:	7ca2                	ld	s9,40(sp)
    80004f7a:	a819                	j	80004f90 <consolewrite+0x92>
  int i = 0;
    80004f7c:	4481                	li	s1,0
    80004f7e:	a809                	j	80004f90 <consolewrite+0x92>
    80004f80:	7906                	ld	s2,96(sp)
    80004f82:	69e6                	ld	s3,88(sp)
    80004f84:	6a46                	ld	s4,80(sp)
    80004f86:	6aa6                	ld	s5,72(sp)
    80004f88:	6b06                	ld	s6,64(sp)
    80004f8a:	7be2                	ld	s7,56(sp)
    80004f8c:	7c42                	ld	s8,48(sp)
    80004f8e:	7ca2                	ld	s9,40(sp)
  }

  return i;
}
    80004f90:	8526                	mv	a0,s1
    80004f92:	70e6                	ld	ra,120(sp)
    80004f94:	7446                	ld	s0,112(sp)
    80004f96:	74a6                	ld	s1,104(sp)
    80004f98:	6109                	addi	sp,sp,128
    80004f9a:	8082                	ret

0000000080004f9c <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004f9c:	711d                	addi	sp,sp,-96
    80004f9e:	ec86                	sd	ra,88(sp)
    80004fa0:	e8a2                	sd	s0,80(sp)
    80004fa2:	e4a6                	sd	s1,72(sp)
    80004fa4:	e0ca                	sd	s2,64(sp)
    80004fa6:	fc4e                	sd	s3,56(sp)
    80004fa8:	f852                	sd	s4,48(sp)
    80004faa:	f456                	sd	s5,40(sp)
    80004fac:	f05a                	sd	s6,32(sp)
    80004fae:	1080                	addi	s0,sp,96
    80004fb0:	8aaa                	mv	s5,a0
    80004fb2:	8a2e                	mv	s4,a1
    80004fb4:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004fb6:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80004fba:	0001e517          	auipc	a0,0x1e
    80004fbe:	46650513          	addi	a0,a0,1126 # 80023420 <cons>
    80004fc2:	109000ef          	jal	800058ca <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004fc6:	0001e497          	auipc	s1,0x1e
    80004fca:	45a48493          	addi	s1,s1,1114 # 80023420 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004fce:	0001e917          	auipc	s2,0x1e
    80004fd2:	4ea90913          	addi	s2,s2,1258 # 800234b8 <cons+0x98>
  while(n > 0){
    80004fd6:	0b305d63          	blez	s3,80005090 <consoleread+0xf4>
    while(cons.r == cons.w){
    80004fda:	0984a783          	lw	a5,152(s1)
    80004fde:	09c4a703          	lw	a4,156(s1)
    80004fe2:	0af71263          	bne	a4,a5,80005086 <consoleread+0xea>
      if(killed(myproc())){
    80004fe6:	d95fb0ef          	jal	80000d7a <myproc>
    80004fea:	dc0fc0ef          	jal	800015aa <killed>
    80004fee:	e12d                	bnez	a0,80005050 <consoleread+0xb4>
      sleep(&cons.r, &cons.lock);
    80004ff0:	85a6                	mv	a1,s1
    80004ff2:	854a                	mv	a0,s2
    80004ff4:	b7efc0ef          	jal	80001372 <sleep>
    while(cons.r == cons.w){
    80004ff8:	0984a783          	lw	a5,152(s1)
    80004ffc:	09c4a703          	lw	a4,156(s1)
    80005000:	fef703e3          	beq	a4,a5,80004fe6 <consoleread+0x4a>
    80005004:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005006:	0001e717          	auipc	a4,0x1e
    8000500a:	41a70713          	addi	a4,a4,1050 # 80023420 <cons>
    8000500e:	0017869b          	addiw	a3,a5,1
    80005012:	08d72c23          	sw	a3,152(a4)
    80005016:	07f7f693          	andi	a3,a5,127
    8000501a:	9736                	add	a4,a4,a3
    8000501c:	01874703          	lbu	a4,24(a4)
    80005020:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80005024:	4691                	li	a3,4
    80005026:	04db8663          	beq	s7,a3,80005072 <consoleread+0xd6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    8000502a:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000502e:	4685                	li	a3,1
    80005030:	faf40613          	addi	a2,s0,-81
    80005034:	85d2                	mv	a1,s4
    80005036:	8556                	mv	a0,s5
    80005038:	e96fc0ef          	jal	800016ce <either_copyout>
    8000503c:	57fd                	li	a5,-1
    8000503e:	04f50863          	beq	a0,a5,8000508e <consoleread+0xf2>
      break;

    dst++;
    80005042:	0a05                	addi	s4,s4,1
    --n;
    80005044:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80005046:	47a9                	li	a5,10
    80005048:	04fb8d63          	beq	s7,a5,800050a2 <consoleread+0x106>
    8000504c:	6be2                	ld	s7,24(sp)
    8000504e:	b761                	j	80004fd6 <consoleread+0x3a>
        release(&cons.lock);
    80005050:	0001e517          	auipc	a0,0x1e
    80005054:	3d050513          	addi	a0,a0,976 # 80023420 <cons>
    80005058:	10b000ef          	jal	80005962 <release>
        return -1;
    8000505c:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    8000505e:	60e6                	ld	ra,88(sp)
    80005060:	6446                	ld	s0,80(sp)
    80005062:	64a6                	ld	s1,72(sp)
    80005064:	6906                	ld	s2,64(sp)
    80005066:	79e2                	ld	s3,56(sp)
    80005068:	7a42                	ld	s4,48(sp)
    8000506a:	7aa2                	ld	s5,40(sp)
    8000506c:	7b02                	ld	s6,32(sp)
    8000506e:	6125                	addi	sp,sp,96
    80005070:	8082                	ret
      if(n < target){
    80005072:	0009871b          	sext.w	a4,s3
    80005076:	01677a63          	bgeu	a4,s6,8000508a <consoleread+0xee>
        cons.r--;
    8000507a:	0001e717          	auipc	a4,0x1e
    8000507e:	42f72f23          	sw	a5,1086(a4) # 800234b8 <cons+0x98>
    80005082:	6be2                	ld	s7,24(sp)
    80005084:	a031                	j	80005090 <consoleread+0xf4>
    80005086:	ec5e                	sd	s7,24(sp)
    80005088:	bfbd                	j	80005006 <consoleread+0x6a>
    8000508a:	6be2                	ld	s7,24(sp)
    8000508c:	a011                	j	80005090 <consoleread+0xf4>
    8000508e:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80005090:	0001e517          	auipc	a0,0x1e
    80005094:	39050513          	addi	a0,a0,912 # 80023420 <cons>
    80005098:	0cb000ef          	jal	80005962 <release>
  return target - n;
    8000509c:	413b053b          	subw	a0,s6,s3
    800050a0:	bf7d                	j	8000505e <consoleread+0xc2>
    800050a2:	6be2                	ld	s7,24(sp)
    800050a4:	b7f5                	j	80005090 <consoleread+0xf4>

00000000800050a6 <consputc>:
{
    800050a6:	1141                	addi	sp,sp,-16
    800050a8:	e406                	sd	ra,8(sp)
    800050aa:	e022                	sd	s0,0(sp)
    800050ac:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800050ae:	10000793          	li	a5,256
    800050b2:	00f50863          	beq	a0,a5,800050c2 <consputc+0x1c>
    uartputc_sync(c);
    800050b6:	6a4000ef          	jal	8000575a <uartputc_sync>
}
    800050ba:	60a2                	ld	ra,8(sp)
    800050bc:	6402                	ld	s0,0(sp)
    800050be:	0141                	addi	sp,sp,16
    800050c0:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800050c2:	4521                	li	a0,8
    800050c4:	696000ef          	jal	8000575a <uartputc_sync>
    800050c8:	02000513          	li	a0,32
    800050cc:	68e000ef          	jal	8000575a <uartputc_sync>
    800050d0:	4521                	li	a0,8
    800050d2:	688000ef          	jal	8000575a <uartputc_sync>
    800050d6:	b7d5                	j	800050ba <consputc+0x14>

00000000800050d8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800050d8:	1101                	addi	sp,sp,-32
    800050da:	ec06                	sd	ra,24(sp)
    800050dc:	e822                	sd	s0,16(sp)
    800050de:	e426                	sd	s1,8(sp)
    800050e0:	1000                	addi	s0,sp,32
    800050e2:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800050e4:	0001e517          	auipc	a0,0x1e
    800050e8:	33c50513          	addi	a0,a0,828 # 80023420 <cons>
    800050ec:	7de000ef          	jal	800058ca <acquire>

  switch(c){
    800050f0:	47d5                	li	a5,21
    800050f2:	08f48f63          	beq	s1,a5,80005190 <consoleintr+0xb8>
    800050f6:	0297c563          	blt	a5,s1,80005120 <consoleintr+0x48>
    800050fa:	47a1                	li	a5,8
    800050fc:	0ef48463          	beq	s1,a5,800051e4 <consoleintr+0x10c>
    80005100:	47c1                	li	a5,16
    80005102:	10f49563          	bne	s1,a5,8000520c <consoleintr+0x134>
  case C('P'):  // Print process list.
    procdump();
    80005106:	e5cfc0ef          	jal	80001762 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000510a:	0001e517          	auipc	a0,0x1e
    8000510e:	31650513          	addi	a0,a0,790 # 80023420 <cons>
    80005112:	051000ef          	jal	80005962 <release>
}
    80005116:	60e2                	ld	ra,24(sp)
    80005118:	6442                	ld	s0,16(sp)
    8000511a:	64a2                	ld	s1,8(sp)
    8000511c:	6105                	addi	sp,sp,32
    8000511e:	8082                	ret
  switch(c){
    80005120:	07f00793          	li	a5,127
    80005124:	0cf48063          	beq	s1,a5,800051e4 <consoleintr+0x10c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005128:	0001e717          	auipc	a4,0x1e
    8000512c:	2f870713          	addi	a4,a4,760 # 80023420 <cons>
    80005130:	0a072783          	lw	a5,160(a4)
    80005134:	09872703          	lw	a4,152(a4)
    80005138:	9f99                	subw	a5,a5,a4
    8000513a:	07f00713          	li	a4,127
    8000513e:	fcf766e3          	bltu	a4,a5,8000510a <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    80005142:	47b5                	li	a5,13
    80005144:	0cf48763          	beq	s1,a5,80005212 <consoleintr+0x13a>
      consputc(c);
    80005148:	8526                	mv	a0,s1
    8000514a:	f5dff0ef          	jal	800050a6 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000514e:	0001e797          	auipc	a5,0x1e
    80005152:	2d278793          	addi	a5,a5,722 # 80023420 <cons>
    80005156:	0a07a683          	lw	a3,160(a5)
    8000515a:	0016871b          	addiw	a4,a3,1
    8000515e:	0007061b          	sext.w	a2,a4
    80005162:	0ae7a023          	sw	a4,160(a5)
    80005166:	07f6f693          	andi	a3,a3,127
    8000516a:	97b6                	add	a5,a5,a3
    8000516c:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005170:	47a9                	li	a5,10
    80005172:	0cf48563          	beq	s1,a5,8000523c <consoleintr+0x164>
    80005176:	4791                	li	a5,4
    80005178:	0cf48263          	beq	s1,a5,8000523c <consoleintr+0x164>
    8000517c:	0001e797          	auipc	a5,0x1e
    80005180:	33c7a783          	lw	a5,828(a5) # 800234b8 <cons+0x98>
    80005184:	9f1d                	subw	a4,a4,a5
    80005186:	08000793          	li	a5,128
    8000518a:	f8f710e3          	bne	a4,a5,8000510a <consoleintr+0x32>
    8000518e:	a07d                	j	8000523c <consoleintr+0x164>
    80005190:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005192:	0001e717          	auipc	a4,0x1e
    80005196:	28e70713          	addi	a4,a4,654 # 80023420 <cons>
    8000519a:	0a072783          	lw	a5,160(a4)
    8000519e:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800051a2:	0001e497          	auipc	s1,0x1e
    800051a6:	27e48493          	addi	s1,s1,638 # 80023420 <cons>
    while(cons.e != cons.w &&
    800051aa:	4929                	li	s2,10
    800051ac:	02f70863          	beq	a4,a5,800051dc <consoleintr+0x104>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800051b0:	37fd                	addiw	a5,a5,-1
    800051b2:	07f7f713          	andi	a4,a5,127
    800051b6:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800051b8:	01874703          	lbu	a4,24(a4)
    800051bc:	03270263          	beq	a4,s2,800051e0 <consoleintr+0x108>
      cons.e--;
    800051c0:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800051c4:	10000513          	li	a0,256
    800051c8:	edfff0ef          	jal	800050a6 <consputc>
    while(cons.e != cons.w &&
    800051cc:	0a04a783          	lw	a5,160(s1)
    800051d0:	09c4a703          	lw	a4,156(s1)
    800051d4:	fcf71ee3          	bne	a4,a5,800051b0 <consoleintr+0xd8>
    800051d8:	6902                	ld	s2,0(sp)
    800051da:	bf05                	j	8000510a <consoleintr+0x32>
    800051dc:	6902                	ld	s2,0(sp)
    800051de:	b735                	j	8000510a <consoleintr+0x32>
    800051e0:	6902                	ld	s2,0(sp)
    800051e2:	b725                	j	8000510a <consoleintr+0x32>
    if(cons.e != cons.w){
    800051e4:	0001e717          	auipc	a4,0x1e
    800051e8:	23c70713          	addi	a4,a4,572 # 80023420 <cons>
    800051ec:	0a072783          	lw	a5,160(a4)
    800051f0:	09c72703          	lw	a4,156(a4)
    800051f4:	f0f70be3          	beq	a4,a5,8000510a <consoleintr+0x32>
      cons.e--;
    800051f8:	37fd                	addiw	a5,a5,-1
    800051fa:	0001e717          	auipc	a4,0x1e
    800051fe:	2cf72323          	sw	a5,710(a4) # 800234c0 <cons+0xa0>
      consputc(BACKSPACE);
    80005202:	10000513          	li	a0,256
    80005206:	ea1ff0ef          	jal	800050a6 <consputc>
    8000520a:	b701                	j	8000510a <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000520c:	ee048fe3          	beqz	s1,8000510a <consoleintr+0x32>
    80005210:	bf21                	j	80005128 <consoleintr+0x50>
      consputc(c);
    80005212:	4529                	li	a0,10
    80005214:	e93ff0ef          	jal	800050a6 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005218:	0001e797          	auipc	a5,0x1e
    8000521c:	20878793          	addi	a5,a5,520 # 80023420 <cons>
    80005220:	0a07a703          	lw	a4,160(a5)
    80005224:	0017069b          	addiw	a3,a4,1
    80005228:	0006861b          	sext.w	a2,a3
    8000522c:	0ad7a023          	sw	a3,160(a5)
    80005230:	07f77713          	andi	a4,a4,127
    80005234:	97ba                	add	a5,a5,a4
    80005236:	4729                	li	a4,10
    80005238:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    8000523c:	0001e797          	auipc	a5,0x1e
    80005240:	28c7a023          	sw	a2,640(a5) # 800234bc <cons+0x9c>
        wakeup(&cons.r);
    80005244:	0001e517          	auipc	a0,0x1e
    80005248:	27450513          	addi	a0,a0,628 # 800234b8 <cons+0x98>
    8000524c:	972fc0ef          	jal	800013be <wakeup>
    80005250:	bd6d                	j	8000510a <consoleintr+0x32>

0000000080005252 <consoleinit>:

void
consoleinit(void)
{
    80005252:	1141                	addi	sp,sp,-16
    80005254:	e406                	sd	ra,8(sp)
    80005256:	e022                	sd	s0,0(sp)
    80005258:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000525a:	00002597          	auipc	a1,0x2
    8000525e:	47658593          	addi	a1,a1,1142 # 800076d0 <etext+0x6d0>
    80005262:	0001e517          	auipc	a0,0x1e
    80005266:	1be50513          	addi	a0,a0,446 # 80023420 <cons>
    8000526a:	5e0000ef          	jal	8000584a <initlock>

  uartinit();
    8000526e:	400000ef          	jal	8000566e <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005272:	00015797          	auipc	a5,0x15
    80005276:	01678793          	addi	a5,a5,22 # 8001a288 <devsw>
    8000527a:	00000717          	auipc	a4,0x0
    8000527e:	d2270713          	addi	a4,a4,-734 # 80004f9c <consoleread>
    80005282:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005284:	00000717          	auipc	a4,0x0
    80005288:	c7a70713          	addi	a4,a4,-902 # 80004efe <consolewrite>
    8000528c:	ef98                	sd	a4,24(a5)
}
    8000528e:	60a2                	ld	ra,8(sp)
    80005290:	6402                	ld	s0,0(sp)
    80005292:	0141                	addi	sp,sp,16
    80005294:	8082                	ret

0000000080005296 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005296:	7139                	addi	sp,sp,-64
    80005298:	fc06                	sd	ra,56(sp)
    8000529a:	f822                	sd	s0,48(sp)
    8000529c:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    8000529e:	c219                	beqz	a2,800052a4 <printint+0xe>
    800052a0:	08054063          	bltz	a0,80005320 <printint+0x8a>
    x = -xx;
  else
    x = xx;
    800052a4:	4881                	li	a7,0
    800052a6:	fc840693          	addi	a3,s0,-56

  i = 0;
    800052aa:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    800052ac:	00002617          	auipc	a2,0x2
    800052b0:	58460613          	addi	a2,a2,1412 # 80007830 <digits>
    800052b4:	883e                	mv	a6,a5
    800052b6:	2785                	addiw	a5,a5,1
    800052b8:	02b57733          	remu	a4,a0,a1
    800052bc:	9732                	add	a4,a4,a2
    800052be:	00074703          	lbu	a4,0(a4)
    800052c2:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    800052c6:	872a                	mv	a4,a0
    800052c8:	02b55533          	divu	a0,a0,a1
    800052cc:	0685                	addi	a3,a3,1
    800052ce:	feb773e3          	bgeu	a4,a1,800052b4 <printint+0x1e>

  if(sign)
    800052d2:	00088a63          	beqz	a7,800052e6 <printint+0x50>
    buf[i++] = '-';
    800052d6:	1781                	addi	a5,a5,-32
    800052d8:	97a2                	add	a5,a5,s0
    800052da:	02d00713          	li	a4,45
    800052de:	fee78423          	sb	a4,-24(a5)
    800052e2:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
    800052e6:	02f05963          	blez	a5,80005318 <printint+0x82>
    800052ea:	f426                	sd	s1,40(sp)
    800052ec:	f04a                	sd	s2,32(sp)
    800052ee:	fc840713          	addi	a4,s0,-56
    800052f2:	00f704b3          	add	s1,a4,a5
    800052f6:	fff70913          	addi	s2,a4,-1
    800052fa:	993e                	add	s2,s2,a5
    800052fc:	37fd                	addiw	a5,a5,-1
    800052fe:	1782                	slli	a5,a5,0x20
    80005300:	9381                	srli	a5,a5,0x20
    80005302:	40f90933          	sub	s2,s2,a5
    consputc(buf[i]);
    80005306:	fff4c503          	lbu	a0,-1(s1)
    8000530a:	d9dff0ef          	jal	800050a6 <consputc>
  while(--i >= 0)
    8000530e:	14fd                	addi	s1,s1,-1
    80005310:	ff249be3          	bne	s1,s2,80005306 <printint+0x70>
    80005314:	74a2                	ld	s1,40(sp)
    80005316:	7902                	ld	s2,32(sp)
}
    80005318:	70e2                	ld	ra,56(sp)
    8000531a:	7442                	ld	s0,48(sp)
    8000531c:	6121                	addi	sp,sp,64
    8000531e:	8082                	ret
    x = -xx;
    80005320:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    80005324:	4885                	li	a7,1
    x = -xx;
    80005326:	b741                	j	800052a6 <printint+0x10>

0000000080005328 <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    80005328:	7131                	addi	sp,sp,-192
    8000532a:	fc86                	sd	ra,120(sp)
    8000532c:	f8a2                	sd	s0,112(sp)
    8000532e:	e8d2                	sd	s4,80(sp)
    80005330:	0100                	addi	s0,sp,128
    80005332:	8a2a                	mv	s4,a0
    80005334:	e40c                	sd	a1,8(s0)
    80005336:	e810                	sd	a2,16(s0)
    80005338:	ec14                	sd	a3,24(s0)
    8000533a:	f018                	sd	a4,32(s0)
    8000533c:	f41c                	sd	a5,40(s0)
    8000533e:	03043823          	sd	a6,48(s0)
    80005342:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    80005346:	00005797          	auipc	a5,0x5
    8000534a:	e9a7a783          	lw	a5,-358(a5) # 8000a1e0 <panicking>
    8000534e:	c3a1                	beqz	a5,8000538e <printf+0x66>
    acquire(&pr.lock);

  va_start(ap, fmt);
    80005350:	00840793          	addi	a5,s0,8
    80005354:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005358:	000a4503          	lbu	a0,0(s4)
    8000535c:	28050763          	beqz	a0,800055ea <printf+0x2c2>
    80005360:	f4a6                	sd	s1,104(sp)
    80005362:	f0ca                	sd	s2,96(sp)
    80005364:	ecce                	sd	s3,88(sp)
    80005366:	e4d6                	sd	s5,72(sp)
    80005368:	e0da                	sd	s6,64(sp)
    8000536a:	f862                	sd	s8,48(sp)
    8000536c:	f466                	sd	s9,40(sp)
    8000536e:	f06a                	sd	s10,32(sp)
    80005370:	ec6e                	sd	s11,24(sp)
    80005372:	4981                	li	s3,0
    if(cx != '%'){
    80005374:	02500a93          	li	s5,37
    i++;
    c0 = fmt[i+0] & 0xff;
    c1 = c2 = 0;
    if(c0) c1 = fmt[i+1] & 0xff;
    if(c1) c2 = fmt[i+2] & 0xff;
    if(c0 == 'd'){
    80005378:	06400b13          	li	s6,100
      printint(va_arg(ap, int), 10, 1);
    } else if(c0 == 'l' && c1 == 'd'){
    8000537c:	06c00c13          	li	s8,108
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    80005380:	07500c93          	li	s9,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    80005384:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    80005388:	07000d93          	li	s11,112
    8000538c:	a01d                	j	800053b2 <printf+0x8a>
    acquire(&pr.lock);
    8000538e:	0001e517          	auipc	a0,0x1e
    80005392:	13a50513          	addi	a0,a0,314 # 800234c8 <pr>
    80005396:	534000ef          	jal	800058ca <acquire>
    8000539a:	bf5d                	j	80005350 <printf+0x28>
      consputc(cx);
    8000539c:	d0bff0ef          	jal	800050a6 <consputc>
      continue;
    800053a0:	84ce                	mv	s1,s3
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    800053a2:	0014899b          	addiw	s3,s1,1
    800053a6:	013a07b3          	add	a5,s4,s3
    800053aa:	0007c503          	lbu	a0,0(a5)
    800053ae:	20050b63          	beqz	a0,800055c4 <printf+0x29c>
    if(cx != '%'){
    800053b2:	ff5515e3          	bne	a0,s5,8000539c <printf+0x74>
    i++;
    800053b6:	0019849b          	addiw	s1,s3,1
    c0 = fmt[i+0] & 0xff;
    800053ba:	009a07b3          	add	a5,s4,s1
    800053be:	0007c903          	lbu	s2,0(a5)
    if(c0) c1 = fmt[i+1] & 0xff;
    800053c2:	20090b63          	beqz	s2,800055d8 <printf+0x2b0>
    800053c6:	0017c783          	lbu	a5,1(a5)
    c1 = c2 = 0;
    800053ca:	86be                	mv	a3,a5
    if(c1) c2 = fmt[i+2] & 0xff;
    800053cc:	c789                	beqz	a5,800053d6 <printf+0xae>
    800053ce:	009a0733          	add	a4,s4,s1
    800053d2:	00274683          	lbu	a3,2(a4)
    if(c0 == 'd'){
    800053d6:	03690963          	beq	s2,s6,80005408 <printf+0xe0>
    } else if(c0 == 'l' && c1 == 'd'){
    800053da:	05890363          	beq	s2,s8,80005420 <printf+0xf8>
    } else if(c0 == 'u'){
    800053de:	0d990663          	beq	s2,s9,800054aa <printf+0x182>
    } else if(c0 == 'x'){
    800053e2:	11a90d63          	beq	s2,s10,800054fc <printf+0x1d4>
    } else if(c0 == 'p'){
    800053e6:	15b90663          	beq	s2,s11,80005532 <printf+0x20a>
      printptr(va_arg(ap, uint64));
    } else if(c0 == 'c'){
    800053ea:	06300793          	li	a5,99
    800053ee:	18f90563          	beq	s2,a5,80005578 <printf+0x250>
      consputc(va_arg(ap, uint));
    } else if(c0 == 's'){
    800053f2:	07300793          	li	a5,115
    800053f6:	18f90b63          	beq	s2,a5,8000558c <printf+0x264>
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
    } else if(c0 == '%'){
    800053fa:	03591b63          	bne	s2,s5,80005430 <printf+0x108>
      consputc('%');
    800053fe:	02500513          	li	a0,37
    80005402:	ca5ff0ef          	jal	800050a6 <consputc>
    80005406:	bf71                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, int), 10, 1);
    80005408:	f8843783          	ld	a5,-120(s0)
    8000540c:	00878713          	addi	a4,a5,8
    80005410:	f8e43423          	sd	a4,-120(s0)
    80005414:	4605                	li	a2,1
    80005416:	45a9                	li	a1,10
    80005418:	4388                	lw	a0,0(a5)
    8000541a:	e7dff0ef          	jal	80005296 <printint>
    8000541e:	b751                	j	800053a2 <printf+0x7a>
    } else if(c0 == 'l' && c1 == 'd'){
    80005420:	01678f63          	beq	a5,s6,8000543e <printf+0x116>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    80005424:	03878b63          	beq	a5,s8,8000545a <printf+0x132>
    } else if(c0 == 'l' && c1 == 'u'){
    80005428:	09978e63          	beq	a5,s9,800054c4 <printf+0x19c>
    } else if(c0 == 'l' && c1 == 'x'){
    8000542c:	0fa78563          	beq	a5,s10,80005516 <printf+0x1ee>
    } else if(c0 == 0){
      break;
    } else {
      // Print unknown % sequence to draw attention.
      consputc('%');
    80005430:	8556                	mv	a0,s5
    80005432:	c75ff0ef          	jal	800050a6 <consputc>
      consputc(c0);
    80005436:	854a                	mv	a0,s2
    80005438:	c6fff0ef          	jal	800050a6 <consputc>
    8000543c:	b79d                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 1);
    8000543e:	f8843783          	ld	a5,-120(s0)
    80005442:	00878713          	addi	a4,a5,8
    80005446:	f8e43423          	sd	a4,-120(s0)
    8000544a:	4605                	li	a2,1
    8000544c:	45a9                	li	a1,10
    8000544e:	6388                	ld	a0,0(a5)
    80005450:	e47ff0ef          	jal	80005296 <printint>
      i += 1;
    80005454:	0029849b          	addiw	s1,s3,2
    80005458:	b7a9                	j	800053a2 <printf+0x7a>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000545a:	06400793          	li	a5,100
    8000545e:	02f68863          	beq	a3,a5,8000548e <printf+0x166>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    80005462:	07500793          	li	a5,117
    80005466:	06f68d63          	beq	a3,a5,800054e0 <printf+0x1b8>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    8000546a:	07800793          	li	a5,120
    8000546e:	fcf691e3          	bne	a3,a5,80005430 <printf+0x108>
      printint(va_arg(ap, uint64), 16, 0);
    80005472:	f8843783          	ld	a5,-120(s0)
    80005476:	00878713          	addi	a4,a5,8
    8000547a:	f8e43423          	sd	a4,-120(s0)
    8000547e:	4601                	li	a2,0
    80005480:	45c1                	li	a1,16
    80005482:	6388                	ld	a0,0(a5)
    80005484:	e13ff0ef          	jal	80005296 <printint>
      i += 2;
    80005488:	0039849b          	addiw	s1,s3,3
    8000548c:	bf19                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 1);
    8000548e:	f8843783          	ld	a5,-120(s0)
    80005492:	00878713          	addi	a4,a5,8
    80005496:	f8e43423          	sd	a4,-120(s0)
    8000549a:	4605                	li	a2,1
    8000549c:	45a9                	li	a1,10
    8000549e:	6388                	ld	a0,0(a5)
    800054a0:	df7ff0ef          	jal	80005296 <printint>
      i += 2;
    800054a4:	0039849b          	addiw	s1,s3,3
    800054a8:	bded                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint32), 10, 0);
    800054aa:	f8843783          	ld	a5,-120(s0)
    800054ae:	00878713          	addi	a4,a5,8
    800054b2:	f8e43423          	sd	a4,-120(s0)
    800054b6:	4601                	li	a2,0
    800054b8:	45a9                	li	a1,10
    800054ba:	0007e503          	lwu	a0,0(a5)
    800054be:	dd9ff0ef          	jal	80005296 <printint>
    800054c2:	b5c5                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 0);
    800054c4:	f8843783          	ld	a5,-120(s0)
    800054c8:	00878713          	addi	a4,a5,8
    800054cc:	f8e43423          	sd	a4,-120(s0)
    800054d0:	4601                	li	a2,0
    800054d2:	45a9                	li	a1,10
    800054d4:	6388                	ld	a0,0(a5)
    800054d6:	dc1ff0ef          	jal	80005296 <printint>
      i += 1;
    800054da:	0029849b          	addiw	s1,s3,2
    800054de:	b5d1                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 0);
    800054e0:	f8843783          	ld	a5,-120(s0)
    800054e4:	00878713          	addi	a4,a5,8
    800054e8:	f8e43423          	sd	a4,-120(s0)
    800054ec:	4601                	li	a2,0
    800054ee:	45a9                	li	a1,10
    800054f0:	6388                	ld	a0,0(a5)
    800054f2:	da5ff0ef          	jal	80005296 <printint>
      i += 2;
    800054f6:	0039849b          	addiw	s1,s3,3
    800054fa:	b565                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint32), 16, 0);
    800054fc:	f8843783          	ld	a5,-120(s0)
    80005500:	00878713          	addi	a4,a5,8
    80005504:	f8e43423          	sd	a4,-120(s0)
    80005508:	4601                	li	a2,0
    8000550a:	45c1                	li	a1,16
    8000550c:	0007e503          	lwu	a0,0(a5)
    80005510:	d87ff0ef          	jal	80005296 <printint>
    80005514:	b579                	j	800053a2 <printf+0x7a>
      printint(va_arg(ap, uint64), 16, 0);
    80005516:	f8843783          	ld	a5,-120(s0)
    8000551a:	00878713          	addi	a4,a5,8
    8000551e:	f8e43423          	sd	a4,-120(s0)
    80005522:	4601                	li	a2,0
    80005524:	45c1                	li	a1,16
    80005526:	6388                	ld	a0,0(a5)
    80005528:	d6fff0ef          	jal	80005296 <printint>
      i += 1;
    8000552c:	0029849b          	addiw	s1,s3,2
    80005530:	bd8d                	j	800053a2 <printf+0x7a>
    80005532:	fc5e                	sd	s7,56(sp)
      printptr(va_arg(ap, uint64));
    80005534:	f8843783          	ld	a5,-120(s0)
    80005538:	00878713          	addi	a4,a5,8
    8000553c:	f8e43423          	sd	a4,-120(s0)
    80005540:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80005544:	03000513          	li	a0,48
    80005548:	b5fff0ef          	jal	800050a6 <consputc>
  consputc('x');
    8000554c:	07800513          	li	a0,120
    80005550:	b57ff0ef          	jal	800050a6 <consputc>
    80005554:	4941                	li	s2,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005556:	00002b97          	auipc	s7,0x2
    8000555a:	2dab8b93          	addi	s7,s7,730 # 80007830 <digits>
    8000555e:	03c9d793          	srli	a5,s3,0x3c
    80005562:	97de                	add	a5,a5,s7
    80005564:	0007c503          	lbu	a0,0(a5)
    80005568:	b3fff0ef          	jal	800050a6 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    8000556c:	0992                	slli	s3,s3,0x4
    8000556e:	397d                	addiw	s2,s2,-1
    80005570:	fe0917e3          	bnez	s2,8000555e <printf+0x236>
    80005574:	7be2                	ld	s7,56(sp)
    80005576:	b535                	j	800053a2 <printf+0x7a>
      consputc(va_arg(ap, uint));
    80005578:	f8843783          	ld	a5,-120(s0)
    8000557c:	00878713          	addi	a4,a5,8
    80005580:	f8e43423          	sd	a4,-120(s0)
    80005584:	4388                	lw	a0,0(a5)
    80005586:	b21ff0ef          	jal	800050a6 <consputc>
    8000558a:	bd21                	j	800053a2 <printf+0x7a>
      if((s = va_arg(ap, char*)) == 0)
    8000558c:	f8843783          	ld	a5,-120(s0)
    80005590:	00878713          	addi	a4,a5,8
    80005594:	f8e43423          	sd	a4,-120(s0)
    80005598:	0007b903          	ld	s2,0(a5)
    8000559c:	00090d63          	beqz	s2,800055b6 <printf+0x28e>
      for(; *s; s++)
    800055a0:	00094503          	lbu	a0,0(s2)
    800055a4:	de050fe3          	beqz	a0,800053a2 <printf+0x7a>
        consputc(*s);
    800055a8:	affff0ef          	jal	800050a6 <consputc>
      for(; *s; s++)
    800055ac:	0905                	addi	s2,s2,1
    800055ae:	00094503          	lbu	a0,0(s2)
    800055b2:	f97d                	bnez	a0,800055a8 <printf+0x280>
    800055b4:	b3fd                	j	800053a2 <printf+0x7a>
        s = "(null)";
    800055b6:	00002917          	auipc	s2,0x2
    800055ba:	12290913          	addi	s2,s2,290 # 800076d8 <etext+0x6d8>
      for(; *s; s++)
    800055be:	02800513          	li	a0,40
    800055c2:	b7dd                	j	800055a8 <printf+0x280>
    800055c4:	74a6                	ld	s1,104(sp)
    800055c6:	7906                	ld	s2,96(sp)
    800055c8:	69e6                	ld	s3,88(sp)
    800055ca:	6aa6                	ld	s5,72(sp)
    800055cc:	6b06                	ld	s6,64(sp)
    800055ce:	7c42                	ld	s8,48(sp)
    800055d0:	7ca2                	ld	s9,40(sp)
    800055d2:	7d02                	ld	s10,32(sp)
    800055d4:	6de2                	ld	s11,24(sp)
    800055d6:	a811                	j	800055ea <printf+0x2c2>
    800055d8:	74a6                	ld	s1,104(sp)
    800055da:	7906                	ld	s2,96(sp)
    800055dc:	69e6                	ld	s3,88(sp)
    800055de:	6aa6                	ld	s5,72(sp)
    800055e0:	6b06                	ld	s6,64(sp)
    800055e2:	7c42                	ld	s8,48(sp)
    800055e4:	7ca2                	ld	s9,40(sp)
    800055e6:	7d02                	ld	s10,32(sp)
    800055e8:	6de2                	ld	s11,24(sp)
    }

  }
  va_end(ap);

  if(panicking == 0)
    800055ea:	00005797          	auipc	a5,0x5
    800055ee:	bf67a783          	lw	a5,-1034(a5) # 8000a1e0 <panicking>
    800055f2:	c799                	beqz	a5,80005600 <printf+0x2d8>
    release(&pr.lock);

  return 0;
}
    800055f4:	4501                	li	a0,0
    800055f6:	70e6                	ld	ra,120(sp)
    800055f8:	7446                	ld	s0,112(sp)
    800055fa:	6a46                	ld	s4,80(sp)
    800055fc:	6129                	addi	sp,sp,192
    800055fe:	8082                	ret
    release(&pr.lock);
    80005600:	0001e517          	auipc	a0,0x1e
    80005604:	ec850513          	addi	a0,a0,-312 # 800234c8 <pr>
    80005608:	35a000ef          	jal	80005962 <release>
  return 0;
    8000560c:	b7e5                	j	800055f4 <printf+0x2cc>

000000008000560e <panic>:

void
panic(char *s)
{
    8000560e:	1101                	addi	sp,sp,-32
    80005610:	ec06                	sd	ra,24(sp)
    80005612:	e822                	sd	s0,16(sp)
    80005614:	e426                	sd	s1,8(sp)
    80005616:	e04a                	sd	s2,0(sp)
    80005618:	1000                	addi	s0,sp,32
    8000561a:	84aa                	mv	s1,a0
  panicking = 1;
    8000561c:	4905                	li	s2,1
    8000561e:	00005797          	auipc	a5,0x5
    80005622:	bd27a123          	sw	s2,-1086(a5) # 8000a1e0 <panicking>
  printf("panic: ");
    80005626:	00002517          	auipc	a0,0x2
    8000562a:	0ba50513          	addi	a0,a0,186 # 800076e0 <etext+0x6e0>
    8000562e:	cfbff0ef          	jal	80005328 <printf>
  printf("%s\n", s);
    80005632:	85a6                	mv	a1,s1
    80005634:	00002517          	auipc	a0,0x2
    80005638:	0b450513          	addi	a0,a0,180 # 800076e8 <etext+0x6e8>
    8000563c:	cedff0ef          	jal	80005328 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005640:	00005797          	auipc	a5,0x5
    80005644:	b927ae23          	sw	s2,-1124(a5) # 8000a1dc <panicked>
  for(;;)
    80005648:	a001                	j	80005648 <panic+0x3a>

000000008000564a <printfinit>:
    ;
}

void
printfinit(void)
{
    8000564a:	1141                	addi	sp,sp,-16
    8000564c:	e406                	sd	ra,8(sp)
    8000564e:	e022                	sd	s0,0(sp)
    80005650:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005652:	00002597          	auipc	a1,0x2
    80005656:	09e58593          	addi	a1,a1,158 # 800076f0 <etext+0x6f0>
    8000565a:	0001e517          	auipc	a0,0x1e
    8000565e:	e6e50513          	addi	a0,a0,-402 # 800234c8 <pr>
    80005662:	1e8000ef          	jal	8000584a <initlock>
}
    80005666:	60a2                	ld	ra,8(sp)
    80005668:	6402                	ld	s0,0(sp)
    8000566a:	0141                	addi	sp,sp,16
    8000566c:	8082                	ret

000000008000566e <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    8000566e:	1141                	addi	sp,sp,-16
    80005670:	e406                	sd	ra,8(sp)
    80005672:	e022                	sd	s0,0(sp)
    80005674:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005676:	100007b7          	lui	a5,0x10000
    8000567a:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000567e:	10000737          	lui	a4,0x10000
    80005682:	f8000693          	li	a3,-128
    80005686:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    8000568a:	468d                	li	a3,3
    8000568c:	10000637          	lui	a2,0x10000
    80005690:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005694:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005698:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    8000569c:	10000737          	lui	a4,0x10000
    800056a0:	461d                	li	a2,7
    800056a2:	00c70123          	sb	a2,2(a4) # 10000002 <_entry-0x6ffffffe>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800056a6:	00d780a3          	sb	a3,1(a5)

  initlock(&tx_lock, "uart");
    800056aa:	00002597          	auipc	a1,0x2
    800056ae:	04e58593          	addi	a1,a1,78 # 800076f8 <etext+0x6f8>
    800056b2:	0001e517          	auipc	a0,0x1e
    800056b6:	e2e50513          	addi	a0,a0,-466 # 800234e0 <tx_lock>
    800056ba:	190000ef          	jal	8000584a <initlock>
}
    800056be:	60a2                	ld	ra,8(sp)
    800056c0:	6402                	ld	s0,0(sp)
    800056c2:	0141                	addi	sp,sp,16
    800056c4:	8082                	ret

00000000800056c6 <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    800056c6:	715d                	addi	sp,sp,-80
    800056c8:	e486                	sd	ra,72(sp)
    800056ca:	e0a2                	sd	s0,64(sp)
    800056cc:	fc26                	sd	s1,56(sp)
    800056ce:	ec56                	sd	s5,24(sp)
    800056d0:	0880                	addi	s0,sp,80
    800056d2:	8aaa                	mv	s5,a0
    800056d4:	84ae                	mv	s1,a1
  acquire(&tx_lock);
    800056d6:	0001e517          	auipc	a0,0x1e
    800056da:	e0a50513          	addi	a0,a0,-502 # 800234e0 <tx_lock>
    800056de:	1ec000ef          	jal	800058ca <acquire>

  int i = 0;
  while(i < n){ 
    800056e2:	06905063          	blez	s1,80005742 <uartwrite+0x7c>
    800056e6:	f84a                	sd	s2,48(sp)
    800056e8:	f44e                	sd	s3,40(sp)
    800056ea:	f052                	sd	s4,32(sp)
    800056ec:	e85a                	sd	s6,16(sp)
    800056ee:	e45e                	sd	s7,8(sp)
    800056f0:	8a56                	mv	s4,s5
    800056f2:	9aa6                	add	s5,s5,s1
    while(tx_busy != 0){
    800056f4:	00005497          	auipc	s1,0x5
    800056f8:	af448493          	addi	s1,s1,-1292 # 8000a1e8 <tx_busy>
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    800056fc:	0001e997          	auipc	s3,0x1e
    80005700:	de498993          	addi	s3,s3,-540 # 800234e0 <tx_lock>
    80005704:	00005917          	auipc	s2,0x5
    80005708:	ae090913          	addi	s2,s2,-1312 # 8000a1e4 <tx_chan>
    }   
      
    WriteReg(THR, buf[i]);
    8000570c:	10000bb7          	lui	s7,0x10000
    i += 1;
    tx_busy = 1;
    80005710:	4b05                	li	s6,1
    80005712:	a005                	j	80005732 <uartwrite+0x6c>
      sleep(&tx_chan, &tx_lock);
    80005714:	85ce                	mv	a1,s3
    80005716:	854a                	mv	a0,s2
    80005718:	c5bfb0ef          	jal	80001372 <sleep>
    while(tx_busy != 0){
    8000571c:	409c                	lw	a5,0(s1)
    8000571e:	fbfd                	bnez	a5,80005714 <uartwrite+0x4e>
    WriteReg(THR, buf[i]);
    80005720:	000a4783          	lbu	a5,0(s4)
    80005724:	00fb8023          	sb	a5,0(s7) # 10000000 <_entry-0x70000000>
    tx_busy = 1;
    80005728:	0164a023          	sw	s6,0(s1)
  while(i < n){ 
    8000572c:	0a05                	addi	s4,s4,1
    8000572e:	015a0563          	beq	s4,s5,80005738 <uartwrite+0x72>
    while(tx_busy != 0){
    80005732:	409c                	lw	a5,0(s1)
    80005734:	f3e5                	bnez	a5,80005714 <uartwrite+0x4e>
    80005736:	b7ed                	j	80005720 <uartwrite+0x5a>
    80005738:	7942                	ld	s2,48(sp)
    8000573a:	79a2                	ld	s3,40(sp)
    8000573c:	7a02                	ld	s4,32(sp)
    8000573e:	6b42                	ld	s6,16(sp)
    80005740:	6ba2                	ld	s7,8(sp)
  }

  release(&tx_lock);
    80005742:	0001e517          	auipc	a0,0x1e
    80005746:	d9e50513          	addi	a0,a0,-610 # 800234e0 <tx_lock>
    8000574a:	218000ef          	jal	80005962 <release>
}
    8000574e:	60a6                	ld	ra,72(sp)
    80005750:	6406                	ld	s0,64(sp)
    80005752:	74e2                	ld	s1,56(sp)
    80005754:	6ae2                	ld	s5,24(sp)
    80005756:	6161                	addi	sp,sp,80
    80005758:	8082                	ret

000000008000575a <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000575a:	1101                	addi	sp,sp,-32
    8000575c:	ec06                	sd	ra,24(sp)
    8000575e:	e822                	sd	s0,16(sp)
    80005760:	e426                	sd	s1,8(sp)
    80005762:	1000                	addi	s0,sp,32
    80005764:	84aa                	mv	s1,a0
  if(panicking == 0)
    80005766:	00005797          	auipc	a5,0x5
    8000576a:	a7a7a783          	lw	a5,-1414(a5) # 8000a1e0 <panicking>
    8000576e:	cf95                	beqz	a5,800057aa <uartputc_sync+0x50>
    push_off();

  if(panicked){
    80005770:	00005797          	auipc	a5,0x5
    80005774:	a6c7a783          	lw	a5,-1428(a5) # 8000a1dc <panicked>
    80005778:	ef85                	bnez	a5,800057b0 <uartputc_sync+0x56>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000577a:	10000737          	lui	a4,0x10000
    8000577e:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80005780:	00074783          	lbu	a5,0(a4)
    80005784:	0207f793          	andi	a5,a5,32
    80005788:	dfe5                	beqz	a5,80005780 <uartputc_sync+0x26>
    ;
  WriteReg(THR, c);
    8000578a:	0ff4f513          	zext.b	a0,s1
    8000578e:	100007b7          	lui	a5,0x10000
    80005792:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    80005796:	00005797          	auipc	a5,0x5
    8000579a:	a4a7a783          	lw	a5,-1462(a5) # 8000a1e0 <panicking>
    8000579e:	cb91                	beqz	a5,800057b2 <uartputc_sync+0x58>
    pop_off();
}
    800057a0:	60e2                	ld	ra,24(sp)
    800057a2:	6442                	ld	s0,16(sp)
    800057a4:	64a2                	ld	s1,8(sp)
    800057a6:	6105                	addi	sp,sp,32
    800057a8:	8082                	ret
    push_off();
    800057aa:	0e0000ef          	jal	8000588a <push_off>
    800057ae:	b7c9                	j	80005770 <uartputc_sync+0x16>
    for(;;)
    800057b0:	a001                	j	800057b0 <uartputc_sync+0x56>
    pop_off();
    800057b2:	15c000ef          	jal	8000590e <pop_off>
}
    800057b6:	b7ed                	j	800057a0 <uartputc_sync+0x46>

00000000800057b8 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800057b8:	1141                	addi	sp,sp,-16
    800057ba:	e422                	sd	s0,8(sp)
    800057bc:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    800057be:	100007b7          	lui	a5,0x10000
    800057c2:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    800057c4:	0007c783          	lbu	a5,0(a5)
    800057c8:	8b85                	andi	a5,a5,1
    800057ca:	cb81                	beqz	a5,800057da <uartgetc+0x22>
    // input data is ready.
    return ReadReg(RHR);
    800057cc:	100007b7          	lui	a5,0x10000
    800057d0:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800057d4:	6422                	ld	s0,8(sp)
    800057d6:	0141                	addi	sp,sp,16
    800057d8:	8082                	ret
    return -1;
    800057da:	557d                	li	a0,-1
    800057dc:	bfe5                	j	800057d4 <uartgetc+0x1c>

00000000800057de <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800057de:	1101                	addi	sp,sp,-32
    800057e0:	ec06                	sd	ra,24(sp)
    800057e2:	e822                	sd	s0,16(sp)
    800057e4:	e426                	sd	s1,8(sp)
    800057e6:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    800057e8:	100007b7          	lui	a5,0x10000
    800057ec:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    800057ee:	0007c783          	lbu	a5,0(a5)

  acquire(&tx_lock);
    800057f2:	0001e517          	auipc	a0,0x1e
    800057f6:	cee50513          	addi	a0,a0,-786 # 800234e0 <tx_lock>
    800057fa:	0d0000ef          	jal	800058ca <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    800057fe:	100007b7          	lui	a5,0x10000
    80005802:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80005804:	0007c783          	lbu	a5,0(a5)
    80005808:	0207f793          	andi	a5,a5,32
    8000580c:	eb89                	bnez	a5,8000581e <uartintr+0x40>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    wakeup(&tx_chan);
  }
  release(&tx_lock);
    8000580e:	0001e517          	auipc	a0,0x1e
    80005812:	cd250513          	addi	a0,a0,-814 # 800234e0 <tx_lock>
    80005816:	14c000ef          	jal	80005962 <release>

  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000581a:	54fd                	li	s1,-1
    8000581c:	a831                	j	80005838 <uartintr+0x5a>
    tx_busy = 0;
    8000581e:	00005797          	auipc	a5,0x5
    80005822:	9c07a523          	sw	zero,-1590(a5) # 8000a1e8 <tx_busy>
    wakeup(&tx_chan);
    80005826:	00005517          	auipc	a0,0x5
    8000582a:	9be50513          	addi	a0,a0,-1602 # 8000a1e4 <tx_chan>
    8000582e:	b91fb0ef          	jal	800013be <wakeup>
    80005832:	bff1                	j	8000580e <uartintr+0x30>
      break;
    consoleintr(c);
    80005834:	8a5ff0ef          	jal	800050d8 <consoleintr>
    int c = uartgetc();
    80005838:	f81ff0ef          	jal	800057b8 <uartgetc>
    if(c == -1)
    8000583c:	fe951ce3          	bne	a0,s1,80005834 <uartintr+0x56>
  }
}
    80005840:	60e2                	ld	ra,24(sp)
    80005842:	6442                	ld	s0,16(sp)
    80005844:	64a2                	ld	s1,8(sp)
    80005846:	6105                	addi	sp,sp,32
    80005848:	8082                	ret

000000008000584a <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000584a:	1141                	addi	sp,sp,-16
    8000584c:	e422                	sd	s0,8(sp)
    8000584e:	0800                	addi	s0,sp,16
  lk->name = name;
    80005850:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80005852:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80005856:	00053823          	sd	zero,16(a0)
}
    8000585a:	6422                	ld	s0,8(sp)
    8000585c:	0141                	addi	sp,sp,16
    8000585e:	8082                	ret

0000000080005860 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80005860:	411c                	lw	a5,0(a0)
    80005862:	e399                	bnez	a5,80005868 <holding+0x8>
    80005864:	4501                	li	a0,0
  return r;
}
    80005866:	8082                	ret
{
    80005868:	1101                	addi	sp,sp,-32
    8000586a:	ec06                	sd	ra,24(sp)
    8000586c:	e822                	sd	s0,16(sp)
    8000586e:	e426                	sd	s1,8(sp)
    80005870:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80005872:	6904                	ld	s1,16(a0)
    80005874:	ceafb0ef          	jal	80000d5e <mycpu>
    80005878:	40a48533          	sub	a0,s1,a0
    8000587c:	00153513          	seqz	a0,a0
}
    80005880:	60e2                	ld	ra,24(sp)
    80005882:	6442                	ld	s0,16(sp)
    80005884:	64a2                	ld	s1,8(sp)
    80005886:	6105                	addi	sp,sp,32
    80005888:	8082                	ret

000000008000588a <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000588a:	1101                	addi	sp,sp,-32
    8000588c:	ec06                	sd	ra,24(sp)
    8000588e:	e822                	sd	s0,16(sp)
    80005890:	e426                	sd	s1,8(sp)
    80005892:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005894:	100024f3          	csrr	s1,sstatus
    80005898:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000589c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000589e:	10079073          	csrw	sstatus,a5

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();

  if(mycpu()->noff == 0)
    800058a2:	cbcfb0ef          	jal	80000d5e <mycpu>
    800058a6:	5d3c                	lw	a5,120(a0)
    800058a8:	cb99                	beqz	a5,800058be <push_off+0x34>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800058aa:	cb4fb0ef          	jal	80000d5e <mycpu>
    800058ae:	5d3c                	lw	a5,120(a0)
    800058b0:	2785                	addiw	a5,a5,1
    800058b2:	dd3c                	sw	a5,120(a0)
}
    800058b4:	60e2                	ld	ra,24(sp)
    800058b6:	6442                	ld	s0,16(sp)
    800058b8:	64a2                	ld	s1,8(sp)
    800058ba:	6105                	addi	sp,sp,32
    800058bc:	8082                	ret
    mycpu()->intena = old;
    800058be:	ca0fb0ef          	jal	80000d5e <mycpu>
  return (x & SSTATUS_SIE) != 0;
    800058c2:	8085                	srli	s1,s1,0x1
    800058c4:	8885                	andi	s1,s1,1
    800058c6:	dd64                	sw	s1,124(a0)
    800058c8:	b7cd                	j	800058aa <push_off+0x20>

00000000800058ca <acquire>:
{
    800058ca:	1101                	addi	sp,sp,-32
    800058cc:	ec06                	sd	ra,24(sp)
    800058ce:	e822                	sd	s0,16(sp)
    800058d0:	e426                	sd	s1,8(sp)
    800058d2:	1000                	addi	s0,sp,32
    800058d4:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800058d6:	fb5ff0ef          	jal	8000588a <push_off>
  if(holding(lk))
    800058da:	8526                	mv	a0,s1
    800058dc:	f85ff0ef          	jal	80005860 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800058e0:	4705                	li	a4,1
  if(holding(lk))
    800058e2:	e105                	bnez	a0,80005902 <acquire+0x38>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800058e4:	87ba                	mv	a5,a4
    800058e6:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800058ea:	2781                	sext.w	a5,a5
    800058ec:	ffe5                	bnez	a5,800058e4 <acquire+0x1a>
  __sync_synchronize();
    800058ee:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    800058f2:	c6cfb0ef          	jal	80000d5e <mycpu>
    800058f6:	e888                	sd	a0,16(s1)
}
    800058f8:	60e2                	ld	ra,24(sp)
    800058fa:	6442                	ld	s0,16(sp)
    800058fc:	64a2                	ld	s1,8(sp)
    800058fe:	6105                	addi	sp,sp,32
    80005900:	8082                	ret
    panic("acquire");
    80005902:	00002517          	auipc	a0,0x2
    80005906:	dfe50513          	addi	a0,a0,-514 # 80007700 <etext+0x700>
    8000590a:	d05ff0ef          	jal	8000560e <panic>

000000008000590e <pop_off>:

void
pop_off(void)
{
    8000590e:	1141                	addi	sp,sp,-16
    80005910:	e406                	sd	ra,8(sp)
    80005912:	e022                	sd	s0,0(sp)
    80005914:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80005916:	c48fb0ef          	jal	80000d5e <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000591a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000591e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80005920:	e78d                	bnez	a5,8000594a <pop_off+0x3c>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80005922:	5d3c                	lw	a5,120(a0)
    80005924:	02f05963          	blez	a5,80005956 <pop_off+0x48>
    panic("pop_off");
  c->noff -= 1;
    80005928:	37fd                	addiw	a5,a5,-1
    8000592a:	0007871b          	sext.w	a4,a5
    8000592e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80005930:	eb09                	bnez	a4,80005942 <pop_off+0x34>
    80005932:	5d7c                	lw	a5,124(a0)
    80005934:	c799                	beqz	a5,80005942 <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005936:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000593a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000593e:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80005942:	60a2                	ld	ra,8(sp)
    80005944:	6402                	ld	s0,0(sp)
    80005946:	0141                	addi	sp,sp,16
    80005948:	8082                	ret
    panic("pop_off - interruptible");
    8000594a:	00002517          	auipc	a0,0x2
    8000594e:	dbe50513          	addi	a0,a0,-578 # 80007708 <etext+0x708>
    80005952:	cbdff0ef          	jal	8000560e <panic>
    panic("pop_off");
    80005956:	00002517          	auipc	a0,0x2
    8000595a:	dca50513          	addi	a0,a0,-566 # 80007720 <etext+0x720>
    8000595e:	cb1ff0ef          	jal	8000560e <panic>

0000000080005962 <release>:
{
    80005962:	1101                	addi	sp,sp,-32
    80005964:	ec06                	sd	ra,24(sp)
    80005966:	e822                	sd	s0,16(sp)
    80005968:	e426                	sd	s1,8(sp)
    8000596a:	1000                	addi	s0,sp,32
    8000596c:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000596e:	ef3ff0ef          	jal	80005860 <holding>
    80005972:	c105                	beqz	a0,80005992 <release+0x30>
  lk->cpu = 0;
    80005974:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80005978:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    8000597c:	0310000f          	fence	rw,w
    80005980:	0004a023          	sw	zero,0(s1)
  pop_off();
    80005984:	f8bff0ef          	jal	8000590e <pop_off>
}
    80005988:	60e2                	ld	ra,24(sp)
    8000598a:	6442                	ld	s0,16(sp)
    8000598c:	64a2                	ld	s1,8(sp)
    8000598e:	6105                	addi	sp,sp,32
    80005990:	8082                	ret
    panic("release");
    80005992:	00002517          	auipc	a0,0x2
    80005996:	d9650513          	addi	a0,a0,-618 # 80007728 <etext+0x728>
    8000599a:	c75ff0ef          	jal	8000560e <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	9282                	jalr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
