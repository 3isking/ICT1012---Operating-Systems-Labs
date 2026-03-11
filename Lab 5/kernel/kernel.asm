
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	1f013103          	ld	sp,496(sp) # 8000b1f0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	229050ef          	jal	80005a3e <start>

000000008000001a <spin>:
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
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00024797          	auipc	a5,0x24
    80000034:	68078793          	addi	a5,a5,1664 # 800246b0 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	0000b917          	auipc	s2,0xb
    80000054:	1f090913          	addi	s2,s2,496 # 8000b240 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	432080e7          	jalr	1074(ra) # 8000648c <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	4d2080e7          	jalr	1234(ra) # 80006540 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f7e50513          	addi	a0,a0,-130 # 80008000 <etext>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	e88080e7          	jalr	-376(ra) # 80005f12 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000009c:	6785                	lui	a5,0x1
    8000009e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a2:	00e504b3          	add	s1,a0,a4
    800000a6:	777d                	lui	a4,0xfffff
    800000a8:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	94be                	add	s1,s1,a5
    800000ac:	0295e463          	bltu	a1,s1,800000d4 <freerange+0x42>
    800000b0:	e84a                	sd	s2,16(sp)
    800000b2:	e44e                	sd	s3,8(sp)
    800000b4:	e052                	sd	s4,0(sp)
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
    800000ce:	6942                	ld	s2,16(sp)
    800000d0:	69a2                	ld	s3,8(sp)
    800000d2:	6a02                	ld	s4,0(sp)
}
    800000d4:	70a2                	ld	ra,40(sp)
    800000d6:	7402                	ld	s0,32(sp)
    800000d8:	64e2                	ld	s1,24(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f2a58593          	addi	a1,a1,-214 # 80008010 <etext+0x10>
    800000ee:	0000b517          	auipc	a0,0xb
    800000f2:	15250513          	addi	a0,a0,338 # 8000b240 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	306080e7          	jalr	774(ra) # 800063fc <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00024517          	auipc	a0,0x24
    80000106:	5ae50513          	addi	a0,a0,1454 # 800246b0 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	0000b497          	auipc	s1,0xb
    80000128:	11c48493          	addi	s1,s1,284 # 8000b240 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	35e080e7          	jalr	862(ra) # 8000648c <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	0000b517          	auipc	a0,0xb
    80000140:	10450513          	addi	a0,a0,260 # 8000b240 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	3fa080e7          	jalr	1018(ra) # 80006540 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	0000b517          	auipc	a0,0xb
    8000016c:	0d850513          	addi	a0,a0,216 # 8000b240 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	3d0080e7          	jalr	976(ra) # 80006540 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	addi	sp,sp,-16
    8000017c:	e422                	sd	s0,8(sp)
    8000017e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000180:	ca19                	beqz	a2,80000196 <memset+0x1c>
    80000182:	87aa                	mv	a5,a0
    80000184:	1602                	slli	a2,a2,0x20
    80000186:	9201                	srli	a2,a2,0x20
    80000188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000190:	0785                	addi	a5,a5,1
    80000192:	fee79de3          	bne	a5,a4,8000018c <memset+0x12>
  }
  return dst;
}
    80000196:	6422                	ld	s0,8(sp)
    80000198:	0141                	addi	sp,sp,16
    8000019a:	8082                	ret

000000008000019c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019c:	1141                	addi	sp,sp,-16
    8000019e:	e422                	sd	s0,8(sp)
    800001a0:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a2:	ca05                	beqz	a2,800001d2 <memcmp+0x36>
    800001a4:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001a8:	1682                	slli	a3,a3,0x20
    800001aa:	9281                	srli	a3,a3,0x20
    800001ac:	0685                	addi	a3,a3,1
    800001ae:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b0:	00054783          	lbu	a5,0(a0)
    800001b4:	0005c703          	lbu	a4,0(a1)
    800001b8:	00e79863          	bne	a5,a4,800001c8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001bc:	0505                	addi	a0,a0,1
    800001be:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c0:	fed518e3          	bne	a0,a3,800001b0 <memcmp+0x14>
  }

  return 0;
    800001c4:	4501                	li	a0,0
    800001c6:	a019                	j	800001cc <memcmp+0x30>
      return *s1 - *s2;
    800001c8:	40e7853b          	subw	a0,a5,a4
}
    800001cc:	6422                	ld	s0,8(sp)
    800001ce:	0141                	addi	sp,sp,16
    800001d0:	8082                	ret
  return 0;
    800001d2:	4501                	li	a0,0
    800001d4:	bfe5                	j	800001cc <memcmp+0x30>

00000000800001d6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d6:	1141                	addi	sp,sp,-16
    800001d8:	e422                	sd	s0,8(sp)
    800001da:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001dc:	c205                	beqz	a2,800001fc <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001de:	02a5e263          	bltu	a1,a0,80000202 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001e2:	1602                	slli	a2,a2,0x20
    800001e4:	9201                	srli	a2,a2,0x20
    800001e6:	00c587b3          	add	a5,a1,a2
{
    800001ea:	872a                	mv	a4,a0
      *d++ = *s++;
    800001ec:	0585                	addi	a1,a1,1
    800001ee:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffda951>
    800001f0:	fff5c683          	lbu	a3,-1(a1)
    800001f4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001f8:	feb79ae3          	bne	a5,a1,800001ec <memmove+0x16>

  return dst;
}
    800001fc:	6422                	ld	s0,8(sp)
    800001fe:	0141                	addi	sp,sp,16
    80000200:	8082                	ret
  if(s < d && s + n > d){
    80000202:	02061693          	slli	a3,a2,0x20
    80000206:	9281                	srli	a3,a3,0x20
    80000208:	00d58733          	add	a4,a1,a3
    8000020c:	fce57be3          	bgeu	a0,a4,800001e2 <memmove+0xc>
    d += n;
    80000210:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000212:	fff6079b          	addiw	a5,a2,-1
    80000216:	1782                	slli	a5,a5,0x20
    80000218:	9381                	srli	a5,a5,0x20
    8000021a:	fff7c793          	not	a5,a5
    8000021e:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000220:	177d                	addi	a4,a4,-1
    80000222:	16fd                	addi	a3,a3,-1
    80000224:	00074603          	lbu	a2,0(a4)
    80000228:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000022c:	fef71ae3          	bne	a4,a5,80000220 <memmove+0x4a>
    80000230:	b7f1                	j	800001fc <memmove+0x26>

0000000080000232 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000232:	1141                	addi	sp,sp,-16
    80000234:	e406                	sd	ra,8(sp)
    80000236:	e022                	sd	s0,0(sp)
    80000238:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000023a:	00000097          	auipc	ra,0x0
    8000023e:	f9c080e7          	jalr	-100(ra) # 800001d6 <memmove>
}
    80000242:	60a2                	ld	ra,8(sp)
    80000244:	6402                	ld	s0,0(sp)
    80000246:	0141                	addi	sp,sp,16
    80000248:	8082                	ret

000000008000024a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000024a:	1141                	addi	sp,sp,-16
    8000024c:	e422                	sd	s0,8(sp)
    8000024e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000250:	ce11                	beqz	a2,8000026c <strncmp+0x22>
    80000252:	00054783          	lbu	a5,0(a0)
    80000256:	cf89                	beqz	a5,80000270 <strncmp+0x26>
    80000258:	0005c703          	lbu	a4,0(a1)
    8000025c:	00f71a63          	bne	a4,a5,80000270 <strncmp+0x26>
    n--, p++, q++;
    80000260:	367d                	addiw	a2,a2,-1
    80000262:	0505                	addi	a0,a0,1
    80000264:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000266:	f675                	bnez	a2,80000252 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000268:	4501                	li	a0,0
    8000026a:	a801                	j	8000027a <strncmp+0x30>
    8000026c:	4501                	li	a0,0
    8000026e:	a031                	j	8000027a <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
    80000270:	00054503          	lbu	a0,0(a0)
    80000274:	0005c783          	lbu	a5,0(a1)
    80000278:	9d1d                	subw	a0,a0,a5
}
    8000027a:	6422                	ld	s0,8(sp)
    8000027c:	0141                	addi	sp,sp,16
    8000027e:	8082                	ret

0000000080000280 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000280:	1141                	addi	sp,sp,-16
    80000282:	e422                	sd	s0,8(sp)
    80000284:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000286:	87aa                	mv	a5,a0
    80000288:	86b2                	mv	a3,a2
    8000028a:	367d                	addiw	a2,a2,-1
    8000028c:	02d05563          	blez	a3,800002b6 <strncpy+0x36>
    80000290:	0785                	addi	a5,a5,1
    80000292:	0005c703          	lbu	a4,0(a1)
    80000296:	fee78fa3          	sb	a4,-1(a5)
    8000029a:	0585                	addi	a1,a1,1
    8000029c:	f775                	bnez	a4,80000288 <strncpy+0x8>
    ;
  while(n-- > 0)
    8000029e:	873e                	mv	a4,a5
    800002a0:	9fb5                	addw	a5,a5,a3
    800002a2:	37fd                	addiw	a5,a5,-1
    800002a4:	00c05963          	blez	a2,800002b6 <strncpy+0x36>
    *s++ = 0;
    800002a8:	0705                	addi	a4,a4,1
    800002aa:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002ae:	40e786bb          	subw	a3,a5,a4
    800002b2:	fed04be3          	bgtz	a3,800002a8 <strncpy+0x28>
  return os;
}
    800002b6:	6422                	ld	s0,8(sp)
    800002b8:	0141                	addi	sp,sp,16
    800002ba:	8082                	ret

00000000800002bc <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002bc:	1141                	addi	sp,sp,-16
    800002be:	e422                	sd	s0,8(sp)
    800002c0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002c2:	02c05363          	blez	a2,800002e8 <safestrcpy+0x2c>
    800002c6:	fff6069b          	addiw	a3,a2,-1
    800002ca:	1682                	slli	a3,a3,0x20
    800002cc:	9281                	srli	a3,a3,0x20
    800002ce:	96ae                	add	a3,a3,a1
    800002d0:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002d2:	00d58963          	beq	a1,a3,800002e4 <safestrcpy+0x28>
    800002d6:	0585                	addi	a1,a1,1
    800002d8:	0785                	addi	a5,a5,1
    800002da:	fff5c703          	lbu	a4,-1(a1)
    800002de:	fee78fa3          	sb	a4,-1(a5)
    800002e2:	fb65                	bnez	a4,800002d2 <safestrcpy+0x16>
    ;
  *s = 0;
    800002e4:	00078023          	sb	zero,0(a5)
  return os;
}
    800002e8:	6422                	ld	s0,8(sp)
    800002ea:	0141                	addi	sp,sp,16
    800002ec:	8082                	ret

00000000800002ee <strlen>:

int
strlen(const char *s)
{
    800002ee:	1141                	addi	sp,sp,-16
    800002f0:	e422                	sd	s0,8(sp)
    800002f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002f4:	00054783          	lbu	a5,0(a0)
    800002f8:	cf91                	beqz	a5,80000314 <strlen+0x26>
    800002fa:	0505                	addi	a0,a0,1
    800002fc:	87aa                	mv	a5,a0
    800002fe:	86be                	mv	a3,a5
    80000300:	0785                	addi	a5,a5,1
    80000302:	fff7c703          	lbu	a4,-1(a5)
    80000306:	ff65                	bnez	a4,800002fe <strlen+0x10>
    80000308:	40a6853b          	subw	a0,a3,a0
    8000030c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    8000030e:	6422                	ld	s0,8(sp)
    80000310:	0141                	addi	sp,sp,16
    80000312:	8082                	ret
  for(n = 0; s[n]; n++)
    80000314:	4501                	li	a0,0
    80000316:	bfe5                	j	8000030e <strlen+0x20>

0000000080000318 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000318:	1141                	addi	sp,sp,-16
    8000031a:	e406                	sd	ra,8(sp)
    8000031c:	e022                	sd	s0,0(sp)
    8000031e:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000320:	00001097          	auipc	ra,0x1
    80000324:	bba080e7          	jalr	-1094(ra) # 80000eda <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000328:	0000b717          	auipc	a4,0xb
    8000032c:	ee870713          	addi	a4,a4,-280 # 8000b210 <started>
  if(cpuid() == 0){
    80000330:	c139                	beqz	a0,80000376 <main+0x5e>
    while(started == 0)
    80000332:	431c                	lw	a5,0(a4)
    80000334:	2781                	sext.w	a5,a5
    80000336:	dff5                	beqz	a5,80000332 <main+0x1a>
      ;
    __sync_synchronize();
    80000338:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    8000033c:	00001097          	auipc	ra,0x1
    80000340:	b9e080e7          	jalr	-1122(ra) # 80000eda <cpuid>
    80000344:	85aa                	mv	a1,a0
    80000346:	00008517          	auipc	a0,0x8
    8000034a:	cf250513          	addi	a0,a0,-782 # 80008038 <etext+0x38>
    8000034e:	00006097          	auipc	ra,0x6
    80000352:	c0e080e7          	jalr	-1010(ra) # 80005f5c <printf>
    kvminithart();    // turn on paging
    80000356:	00000097          	auipc	ra,0x0
    8000035a:	0d8080e7          	jalr	216(ra) # 8000042e <kvminithart>
    trapinithart();   // install kernel trap vector
    8000035e:	00002097          	auipc	ra,0x2
    80000362:	84c080e7          	jalr	-1972(ra) # 80001baa <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000366:	00005097          	auipc	ra,0x5
    8000036a:	04e080e7          	jalr	78(ra) # 800053b4 <plicinithart>
  }

  scheduler();        
    8000036e:	00001097          	auipc	ra,0x1
    80000372:	094080e7          	jalr	148(ra) # 80001402 <scheduler>
    consoleinit();
    80000376:	00006097          	auipc	ra,0x6
    8000037a:	aac080e7          	jalr	-1364(ra) # 80005e22 <consoleinit>
    printfinit();
    8000037e:	00006097          	auipc	ra,0x6
    80000382:	de6080e7          	jalr	-538(ra) # 80006164 <printfinit>
    printf("\n");
    80000386:	00008517          	auipc	a0,0x8
    8000038a:	c9250513          	addi	a0,a0,-878 # 80008018 <etext+0x18>
    8000038e:	00006097          	auipc	ra,0x6
    80000392:	bce080e7          	jalr	-1074(ra) # 80005f5c <printf>
    printf("xv6 kernel is booting\n");
    80000396:	00008517          	auipc	a0,0x8
    8000039a:	c8a50513          	addi	a0,a0,-886 # 80008020 <etext+0x20>
    8000039e:	00006097          	auipc	ra,0x6
    800003a2:	bbe080e7          	jalr	-1090(ra) # 80005f5c <printf>
    printf("\n");
    800003a6:	00008517          	auipc	a0,0x8
    800003aa:	c7250513          	addi	a0,a0,-910 # 80008018 <etext+0x18>
    800003ae:	00006097          	auipc	ra,0x6
    800003b2:	bae080e7          	jalr	-1106(ra) # 80005f5c <printf>
    kinit();         // physical page allocator
    800003b6:	00000097          	auipc	ra,0x0
    800003ba:	d28080e7          	jalr	-728(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003be:	00000097          	auipc	ra,0x0
    800003c2:	34a080e7          	jalr	842(ra) # 80000708 <kvminit>
    kvminithart();   // turn on paging
    800003c6:	00000097          	auipc	ra,0x0
    800003ca:	068080e7          	jalr	104(ra) # 8000042e <kvminithart>
    procinit();      // process table
    800003ce:	00001097          	auipc	ra,0x1
    800003d2:	a4a080e7          	jalr	-1462(ra) # 80000e18 <procinit>
    trapinit();      // trap vectors
    800003d6:	00001097          	auipc	ra,0x1
    800003da:	7ac080e7          	jalr	1964(ra) # 80001b82 <trapinit>
    trapinithart();  // install kernel trap vector
    800003de:	00001097          	auipc	ra,0x1
    800003e2:	7cc080e7          	jalr	1996(ra) # 80001baa <trapinithart>
    plicinit();      // set up interrupt controller
    800003e6:	00005097          	auipc	ra,0x5
    800003ea:	fb4080e7          	jalr	-76(ra) # 8000539a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003ee:	00005097          	auipc	ra,0x5
    800003f2:	fc6080e7          	jalr	-58(ra) # 800053b4 <plicinithart>
    binit();         // buffer cache
    800003f6:	00002097          	auipc	ra,0x2
    800003fa:	f0a080e7          	jalr	-246(ra) # 80002300 <binit>
    iinit();         // inode table
    800003fe:	00002097          	auipc	ra,0x2
    80000402:	69e080e7          	jalr	1694(ra) # 80002a9c <iinit>
    fileinit();      // file table
    80000406:	00003097          	auipc	ra,0x3
    8000040a:	6fa080e7          	jalr	1786(ra) # 80003b00 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000040e:	00005097          	auipc	ra,0x5
    80000412:	0ae080e7          	jalr	174(ra) # 800054bc <virtio_disk_init>
    userinit();      // first user process
    80000416:	00001097          	auipc	ra,0x1
    8000041a:	dcc080e7          	jalr	-564(ra) # 800011e2 <userinit>
    __sync_synchronize();
    8000041e:	0330000f          	fence	rw,rw
    started = 1;
    80000422:	4785                	li	a5,1
    80000424:	0000b717          	auipc	a4,0xb
    80000428:	def72623          	sw	a5,-532(a4) # 8000b210 <started>
    8000042c:	b789                	j	8000036e <main+0x56>

000000008000042e <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000042e:	1141                	addi	sp,sp,-16
    80000430:	e422                	sd	s0,8(sp)
    80000432:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000434:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000438:	0000b797          	auipc	a5,0xb
    8000043c:	de07b783          	ld	a5,-544(a5) # 8000b218 <kernel_pagetable>
    80000440:	83b1                	srli	a5,a5,0xc
    80000442:	577d                	li	a4,-1
    80000444:	177e                	slli	a4,a4,0x3f
    80000446:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000448:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    8000044c:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000450:	6422                	ld	s0,8(sp)
    80000452:	0141                	addi	sp,sp,16
    80000454:	8082                	ret

0000000080000456 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000456:	7139                	addi	sp,sp,-64
    80000458:	fc06                	sd	ra,56(sp)
    8000045a:	f822                	sd	s0,48(sp)
    8000045c:	f426                	sd	s1,40(sp)
    8000045e:	f04a                	sd	s2,32(sp)
    80000460:	ec4e                	sd	s3,24(sp)
    80000462:	e852                	sd	s4,16(sp)
    80000464:	e456                	sd	s5,8(sp)
    80000466:	e05a                	sd	s6,0(sp)
    80000468:	0080                	addi	s0,sp,64
    8000046a:	84aa                	mv	s1,a0
    8000046c:	89ae                	mv	s3,a1
    8000046e:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000470:	57fd                	li	a5,-1
    80000472:	83e9                	srli	a5,a5,0x1a
    80000474:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000476:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000478:	04b7f263          	bgeu	a5,a1,800004bc <walk+0x66>
    panic("walk");
    8000047c:	00008517          	auipc	a0,0x8
    80000480:	bd450513          	addi	a0,a0,-1068 # 80008050 <etext+0x50>
    80000484:	00006097          	auipc	ra,0x6
    80000488:	a8e080e7          	jalr	-1394(ra) # 80005f12 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000048c:	060a8663          	beqz	s5,800004f8 <walk+0xa2>
    80000490:	00000097          	auipc	ra,0x0
    80000494:	c8a080e7          	jalr	-886(ra) # 8000011a <kalloc>
    80000498:	84aa                	mv	s1,a0
    8000049a:	c529                	beqz	a0,800004e4 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    8000049c:	6605                	lui	a2,0x1
    8000049e:	4581                	li	a1,0
    800004a0:	00000097          	auipc	ra,0x0
    800004a4:	cda080e7          	jalr	-806(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004a8:	00c4d793          	srli	a5,s1,0xc
    800004ac:	07aa                	slli	a5,a5,0xa
    800004ae:	0017e793          	ori	a5,a5,1
    800004b2:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004b6:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffda947>
    800004b8:	036a0063          	beq	s4,s6,800004d8 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004bc:	0149d933          	srl	s2,s3,s4
    800004c0:	1ff97913          	andi	s2,s2,511
    800004c4:	090e                	slli	s2,s2,0x3
    800004c6:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004c8:	00093483          	ld	s1,0(s2)
    800004cc:	0014f793          	andi	a5,s1,1
    800004d0:	dfd5                	beqz	a5,8000048c <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004d2:	80a9                	srli	s1,s1,0xa
    800004d4:	04b2                	slli	s1,s1,0xc
    800004d6:	b7c5                	j	800004b6 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004d8:	00c9d513          	srli	a0,s3,0xc
    800004dc:	1ff57513          	andi	a0,a0,511
    800004e0:	050e                	slli	a0,a0,0x3
    800004e2:	9526                	add	a0,a0,s1
}
    800004e4:	70e2                	ld	ra,56(sp)
    800004e6:	7442                	ld	s0,48(sp)
    800004e8:	74a2                	ld	s1,40(sp)
    800004ea:	7902                	ld	s2,32(sp)
    800004ec:	69e2                	ld	s3,24(sp)
    800004ee:	6a42                	ld	s4,16(sp)
    800004f0:	6aa2                	ld	s5,8(sp)
    800004f2:	6b02                	ld	s6,0(sp)
    800004f4:	6121                	addi	sp,sp,64
    800004f6:	8082                	ret
        return 0;
    800004f8:	4501                	li	a0,0
    800004fa:	b7ed                	j	800004e4 <walk+0x8e>

00000000800004fc <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    800004fc:	57fd                	li	a5,-1
    800004fe:	83e9                	srli	a5,a5,0x1a
    80000500:	00b7f463          	bgeu	a5,a1,80000508 <walkaddr+0xc>
    return 0;
    80000504:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000506:	8082                	ret
{
    80000508:	1141                	addi	sp,sp,-16
    8000050a:	e406                	sd	ra,8(sp)
    8000050c:	e022                	sd	s0,0(sp)
    8000050e:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000510:	4601                	li	a2,0
    80000512:	00000097          	auipc	ra,0x0
    80000516:	f44080e7          	jalr	-188(ra) # 80000456 <walk>
  if(pte == 0)
    8000051a:	c105                	beqz	a0,8000053a <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000051c:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000051e:	0117f693          	andi	a3,a5,17
    80000522:	4745                	li	a4,17
    return 0;
    80000524:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000526:	00e68663          	beq	a3,a4,80000532 <walkaddr+0x36>
}
    8000052a:	60a2                	ld	ra,8(sp)
    8000052c:	6402                	ld	s0,0(sp)
    8000052e:	0141                	addi	sp,sp,16
    80000530:	8082                	ret
  pa = PTE2PA(*pte);
    80000532:	83a9                	srli	a5,a5,0xa
    80000534:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000538:	bfcd                	j	8000052a <walkaddr+0x2e>
    return 0;
    8000053a:	4501                	li	a0,0
    8000053c:	b7fd                	j	8000052a <walkaddr+0x2e>

000000008000053e <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000053e:	715d                	addi	sp,sp,-80
    80000540:	e486                	sd	ra,72(sp)
    80000542:	e0a2                	sd	s0,64(sp)
    80000544:	fc26                	sd	s1,56(sp)
    80000546:	f84a                	sd	s2,48(sp)
    80000548:	f44e                	sd	s3,40(sp)
    8000054a:	f052                	sd	s4,32(sp)
    8000054c:	ec56                	sd	s5,24(sp)
    8000054e:	e85a                	sd	s6,16(sp)
    80000550:	e45e                	sd	s7,8(sp)
    80000552:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000554:	03459793          	slli	a5,a1,0x34
    80000558:	e7b9                	bnez	a5,800005a6 <mappages+0x68>
    8000055a:	8aaa                	mv	s5,a0
    8000055c:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    8000055e:	03461793          	slli	a5,a2,0x34
    80000562:	ebb1                	bnez	a5,800005b6 <mappages+0x78>
    panic("mappages: size not aligned");

  if(size == 0)
    80000564:	c22d                	beqz	a2,800005c6 <mappages+0x88>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    80000566:	77fd                	lui	a5,0xfffff
    80000568:	963e                	add	a2,a2,a5
    8000056a:	00b609b3          	add	s3,a2,a1
  a = va;
    8000056e:	892e                	mv	s2,a1
    80000570:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000574:	6b85                	lui	s7,0x1
    80000576:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    8000057a:	4605                	li	a2,1
    8000057c:	85ca                	mv	a1,s2
    8000057e:	8556                	mv	a0,s5
    80000580:	00000097          	auipc	ra,0x0
    80000584:	ed6080e7          	jalr	-298(ra) # 80000456 <walk>
    80000588:	cd39                	beqz	a0,800005e6 <mappages+0xa8>
    if(*pte & PTE_V)
    8000058a:	611c                	ld	a5,0(a0)
    8000058c:	8b85                	andi	a5,a5,1
    8000058e:	e7a1                	bnez	a5,800005d6 <mappages+0x98>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000590:	80b1                	srli	s1,s1,0xc
    80000592:	04aa                	slli	s1,s1,0xa
    80000594:	0164e4b3          	or	s1,s1,s6
    80000598:	0014e493          	ori	s1,s1,1
    8000059c:	e104                	sd	s1,0(a0)
    if(a == last)
    8000059e:	07390063          	beq	s2,s3,800005fe <mappages+0xc0>
    a += PGSIZE;
    800005a2:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a4:	bfc9                	j	80000576 <mappages+0x38>
    panic("mappages: va not aligned");
    800005a6:	00008517          	auipc	a0,0x8
    800005aa:	ab250513          	addi	a0,a0,-1358 # 80008058 <etext+0x58>
    800005ae:	00006097          	auipc	ra,0x6
    800005b2:	964080e7          	jalr	-1692(ra) # 80005f12 <panic>
    panic("mappages: size not aligned");
    800005b6:	00008517          	auipc	a0,0x8
    800005ba:	ac250513          	addi	a0,a0,-1342 # 80008078 <etext+0x78>
    800005be:	00006097          	auipc	ra,0x6
    800005c2:	954080e7          	jalr	-1708(ra) # 80005f12 <panic>
    panic("mappages: size");
    800005c6:	00008517          	auipc	a0,0x8
    800005ca:	ad250513          	addi	a0,a0,-1326 # 80008098 <etext+0x98>
    800005ce:	00006097          	auipc	ra,0x6
    800005d2:	944080e7          	jalr	-1724(ra) # 80005f12 <panic>
      panic("mappages: remap");
    800005d6:	00008517          	auipc	a0,0x8
    800005da:	ad250513          	addi	a0,a0,-1326 # 800080a8 <etext+0xa8>
    800005de:	00006097          	auipc	ra,0x6
    800005e2:	934080e7          	jalr	-1740(ra) # 80005f12 <panic>
      return -1;
    800005e6:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005e8:	60a6                	ld	ra,72(sp)
    800005ea:	6406                	ld	s0,64(sp)
    800005ec:	74e2                	ld	s1,56(sp)
    800005ee:	7942                	ld	s2,48(sp)
    800005f0:	79a2                	ld	s3,40(sp)
    800005f2:	7a02                	ld	s4,32(sp)
    800005f4:	6ae2                	ld	s5,24(sp)
    800005f6:	6b42                	ld	s6,16(sp)
    800005f8:	6ba2                	ld	s7,8(sp)
    800005fa:	6161                	addi	sp,sp,80
    800005fc:	8082                	ret
  return 0;
    800005fe:	4501                	li	a0,0
    80000600:	b7e5                	j	800005e8 <mappages+0xaa>

0000000080000602 <kvmmap>:
{
    80000602:	1141                	addi	sp,sp,-16
    80000604:	e406                	sd	ra,8(sp)
    80000606:	e022                	sd	s0,0(sp)
    80000608:	0800                	addi	s0,sp,16
    8000060a:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000060c:	86b2                	mv	a3,a2
    8000060e:	863e                	mv	a2,a5
    80000610:	00000097          	auipc	ra,0x0
    80000614:	f2e080e7          	jalr	-210(ra) # 8000053e <mappages>
    80000618:	e509                	bnez	a0,80000622 <kvmmap+0x20>
}
    8000061a:	60a2                	ld	ra,8(sp)
    8000061c:	6402                	ld	s0,0(sp)
    8000061e:	0141                	addi	sp,sp,16
    80000620:	8082                	ret
    panic("kvmmap");
    80000622:	00008517          	auipc	a0,0x8
    80000626:	a9650513          	addi	a0,a0,-1386 # 800080b8 <etext+0xb8>
    8000062a:	00006097          	auipc	ra,0x6
    8000062e:	8e8080e7          	jalr	-1816(ra) # 80005f12 <panic>

0000000080000632 <kvmmake>:
{
    80000632:	1101                	addi	sp,sp,-32
    80000634:	ec06                	sd	ra,24(sp)
    80000636:	e822                	sd	s0,16(sp)
    80000638:	e426                	sd	s1,8(sp)
    8000063a:	e04a                	sd	s2,0(sp)
    8000063c:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000063e:	00000097          	auipc	ra,0x0
    80000642:	adc080e7          	jalr	-1316(ra) # 8000011a <kalloc>
    80000646:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000648:	6605                	lui	a2,0x1
    8000064a:	4581                	li	a1,0
    8000064c:	00000097          	auipc	ra,0x0
    80000650:	b2e080e7          	jalr	-1234(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000654:	4719                	li	a4,6
    80000656:	6685                	lui	a3,0x1
    80000658:	10000637          	lui	a2,0x10000
    8000065c:	100005b7          	lui	a1,0x10000
    80000660:	8526                	mv	a0,s1
    80000662:	00000097          	auipc	ra,0x0
    80000666:	fa0080e7          	jalr	-96(ra) # 80000602 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000066a:	4719                	li	a4,6
    8000066c:	6685                	lui	a3,0x1
    8000066e:	10001637          	lui	a2,0x10001
    80000672:	100015b7          	lui	a1,0x10001
    80000676:	8526                	mv	a0,s1
    80000678:	00000097          	auipc	ra,0x0
    8000067c:	f8a080e7          	jalr	-118(ra) # 80000602 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000680:	4719                	li	a4,6
    80000682:	004006b7          	lui	a3,0x400
    80000686:	0c000637          	lui	a2,0xc000
    8000068a:	0c0005b7          	lui	a1,0xc000
    8000068e:	8526                	mv	a0,s1
    80000690:	00000097          	auipc	ra,0x0
    80000694:	f72080e7          	jalr	-142(ra) # 80000602 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000698:	00008917          	auipc	s2,0x8
    8000069c:	96890913          	addi	s2,s2,-1688 # 80008000 <etext>
    800006a0:	4729                	li	a4,10
    800006a2:	80008697          	auipc	a3,0x80008
    800006a6:	95e68693          	addi	a3,a3,-1698 # 8000 <_entry-0x7fff8000>
    800006aa:	4605                	li	a2,1
    800006ac:	067e                	slli	a2,a2,0x1f
    800006ae:	85b2                	mv	a1,a2
    800006b0:	8526                	mv	a0,s1
    800006b2:	00000097          	auipc	ra,0x0
    800006b6:	f50080e7          	jalr	-176(ra) # 80000602 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006ba:	46c5                	li	a3,17
    800006bc:	06ee                	slli	a3,a3,0x1b
    800006be:	4719                	li	a4,6
    800006c0:	412686b3          	sub	a3,a3,s2
    800006c4:	864a                	mv	a2,s2
    800006c6:	85ca                	mv	a1,s2
    800006c8:	8526                	mv	a0,s1
    800006ca:	00000097          	auipc	ra,0x0
    800006ce:	f38080e7          	jalr	-200(ra) # 80000602 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006d2:	4729                	li	a4,10
    800006d4:	6685                	lui	a3,0x1
    800006d6:	00007617          	auipc	a2,0x7
    800006da:	92a60613          	addi	a2,a2,-1750 # 80007000 <_trampoline>
    800006de:	040005b7          	lui	a1,0x4000
    800006e2:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006e4:	05b2                	slli	a1,a1,0xc
    800006e6:	8526                	mv	a0,s1
    800006e8:	00000097          	auipc	ra,0x0
    800006ec:	f1a080e7          	jalr	-230(ra) # 80000602 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006f0:	8526                	mv	a0,s1
    800006f2:	00000097          	auipc	ra,0x0
    800006f6:	682080e7          	jalr	1666(ra) # 80000d74 <proc_mapstacks>
}
    800006fa:	8526                	mv	a0,s1
    800006fc:	60e2                	ld	ra,24(sp)
    800006fe:	6442                	ld	s0,16(sp)
    80000700:	64a2                	ld	s1,8(sp)
    80000702:	6902                	ld	s2,0(sp)
    80000704:	6105                	addi	sp,sp,32
    80000706:	8082                	ret

0000000080000708 <kvminit>:
{
    80000708:	1141                	addi	sp,sp,-16
    8000070a:	e406                	sd	ra,8(sp)
    8000070c:	e022                	sd	s0,0(sp)
    8000070e:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000710:	00000097          	auipc	ra,0x0
    80000714:	f22080e7          	jalr	-222(ra) # 80000632 <kvmmake>
    80000718:	0000b797          	auipc	a5,0xb
    8000071c:	b0a7b023          	sd	a0,-1280(a5) # 8000b218 <kernel_pagetable>
}
    80000720:	60a2                	ld	ra,8(sp)
    80000722:	6402                	ld	s0,0(sp)
    80000724:	0141                	addi	sp,sp,16
    80000726:	8082                	ret

0000000080000728 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000728:	715d                	addi	sp,sp,-80
    8000072a:	e486                	sd	ra,72(sp)
    8000072c:	e0a2                	sd	s0,64(sp)
    8000072e:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000730:	03459793          	slli	a5,a1,0x34
    80000734:	e39d                	bnez	a5,8000075a <uvmunmap+0x32>
    80000736:	f84a                	sd	s2,48(sp)
    80000738:	f44e                	sd	s3,40(sp)
    8000073a:	f052                	sd	s4,32(sp)
    8000073c:	ec56                	sd	s5,24(sp)
    8000073e:	e85a                	sd	s6,16(sp)
    80000740:	e45e                	sd	s7,8(sp)
    80000742:	8a2a                	mv	s4,a0
    80000744:	892e                	mv	s2,a1
    80000746:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000748:	0632                	slli	a2,a2,0xc
    8000074a:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000074e:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000750:	6b05                	lui	s6,0x1
    80000752:	0935fb63          	bgeu	a1,s3,800007e8 <uvmunmap+0xc0>
    80000756:	fc26                	sd	s1,56(sp)
    80000758:	a8a9                	j	800007b2 <uvmunmap+0x8a>
    8000075a:	fc26                	sd	s1,56(sp)
    8000075c:	f84a                	sd	s2,48(sp)
    8000075e:	f44e                	sd	s3,40(sp)
    80000760:	f052                	sd	s4,32(sp)
    80000762:	ec56                	sd	s5,24(sp)
    80000764:	e85a                	sd	s6,16(sp)
    80000766:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    80000768:	00008517          	auipc	a0,0x8
    8000076c:	95850513          	addi	a0,a0,-1704 # 800080c0 <etext+0xc0>
    80000770:	00005097          	auipc	ra,0x5
    80000774:	7a2080e7          	jalr	1954(ra) # 80005f12 <panic>
      panic("uvmunmap: walk");
    80000778:	00008517          	auipc	a0,0x8
    8000077c:	96050513          	addi	a0,a0,-1696 # 800080d8 <etext+0xd8>
    80000780:	00005097          	auipc	ra,0x5
    80000784:	792080e7          	jalr	1938(ra) # 80005f12 <panic>
      panic("uvmunmap: not mapped");
    80000788:	00008517          	auipc	a0,0x8
    8000078c:	96050513          	addi	a0,a0,-1696 # 800080e8 <etext+0xe8>
    80000790:	00005097          	auipc	ra,0x5
    80000794:	782080e7          	jalr	1922(ra) # 80005f12 <panic>
      panic("uvmunmap: not a leaf");
    80000798:	00008517          	auipc	a0,0x8
    8000079c:	96850513          	addi	a0,a0,-1688 # 80008100 <etext+0x100>
    800007a0:	00005097          	auipc	ra,0x5
    800007a4:	772080e7          	jalr	1906(ra) # 80005f12 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800007a8:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007ac:	995a                	add	s2,s2,s6
    800007ae:	03397c63          	bgeu	s2,s3,800007e6 <uvmunmap+0xbe>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007b2:	4601                	li	a2,0
    800007b4:	85ca                	mv	a1,s2
    800007b6:	8552                	mv	a0,s4
    800007b8:	00000097          	auipc	ra,0x0
    800007bc:	c9e080e7          	jalr	-866(ra) # 80000456 <walk>
    800007c0:	84aa                	mv	s1,a0
    800007c2:	d95d                	beqz	a0,80000778 <uvmunmap+0x50>
    if((*pte & PTE_V) == 0)
    800007c4:	6108                	ld	a0,0(a0)
    800007c6:	00157793          	andi	a5,a0,1
    800007ca:	dfdd                	beqz	a5,80000788 <uvmunmap+0x60>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007cc:	3ff57793          	andi	a5,a0,1023
    800007d0:	fd7784e3          	beq	a5,s7,80000798 <uvmunmap+0x70>
    if(do_free){
    800007d4:	fc0a8ae3          	beqz	s5,800007a8 <uvmunmap+0x80>
      uint64 pa = PTE2PA(*pte);
    800007d8:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007da:	0532                	slli	a0,a0,0xc
    800007dc:	00000097          	auipc	ra,0x0
    800007e0:	840080e7          	jalr	-1984(ra) # 8000001c <kfree>
    800007e4:	b7d1                	j	800007a8 <uvmunmap+0x80>
    800007e6:	74e2                	ld	s1,56(sp)
    800007e8:	7942                	ld	s2,48(sp)
    800007ea:	79a2                	ld	s3,40(sp)
    800007ec:	7a02                	ld	s4,32(sp)
    800007ee:	6ae2                	ld	s5,24(sp)
    800007f0:	6b42                	ld	s6,16(sp)
    800007f2:	6ba2                	ld	s7,8(sp)
  }
}
    800007f4:	60a6                	ld	ra,72(sp)
    800007f6:	6406                	ld	s0,64(sp)
    800007f8:	6161                	addi	sp,sp,80
    800007fa:	8082                	ret

00000000800007fc <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007fc:	1101                	addi	sp,sp,-32
    800007fe:	ec06                	sd	ra,24(sp)
    80000800:	e822                	sd	s0,16(sp)
    80000802:	e426                	sd	s1,8(sp)
    80000804:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000806:	00000097          	auipc	ra,0x0
    8000080a:	914080e7          	jalr	-1772(ra) # 8000011a <kalloc>
    8000080e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000810:	c519                	beqz	a0,8000081e <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000812:	6605                	lui	a2,0x1
    80000814:	4581                	li	a1,0
    80000816:	00000097          	auipc	ra,0x0
    8000081a:	964080e7          	jalr	-1692(ra) # 8000017a <memset>
  return pagetable;
}
    8000081e:	8526                	mv	a0,s1
    80000820:	60e2                	ld	ra,24(sp)
    80000822:	6442                	ld	s0,16(sp)
    80000824:	64a2                	ld	s1,8(sp)
    80000826:	6105                	addi	sp,sp,32
    80000828:	8082                	ret

000000008000082a <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    8000082a:	7179                	addi	sp,sp,-48
    8000082c:	f406                	sd	ra,40(sp)
    8000082e:	f022                	sd	s0,32(sp)
    80000830:	ec26                	sd	s1,24(sp)
    80000832:	e84a                	sd	s2,16(sp)
    80000834:	e44e                	sd	s3,8(sp)
    80000836:	e052                	sd	s4,0(sp)
    80000838:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000083a:	6785                	lui	a5,0x1
    8000083c:	04f67863          	bgeu	a2,a5,8000088c <uvmfirst+0x62>
    80000840:	8a2a                	mv	s4,a0
    80000842:	89ae                	mv	s3,a1
    80000844:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000846:	00000097          	auipc	ra,0x0
    8000084a:	8d4080e7          	jalr	-1836(ra) # 8000011a <kalloc>
    8000084e:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000850:	6605                	lui	a2,0x1
    80000852:	4581                	li	a1,0
    80000854:	00000097          	auipc	ra,0x0
    80000858:	926080e7          	jalr	-1754(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000085c:	4779                	li	a4,30
    8000085e:	86ca                	mv	a3,s2
    80000860:	6605                	lui	a2,0x1
    80000862:	4581                	li	a1,0
    80000864:	8552                	mv	a0,s4
    80000866:	00000097          	auipc	ra,0x0
    8000086a:	cd8080e7          	jalr	-808(ra) # 8000053e <mappages>
  memmove(mem, src, sz);
    8000086e:	8626                	mv	a2,s1
    80000870:	85ce                	mv	a1,s3
    80000872:	854a                	mv	a0,s2
    80000874:	00000097          	auipc	ra,0x0
    80000878:	962080e7          	jalr	-1694(ra) # 800001d6 <memmove>
}
    8000087c:	70a2                	ld	ra,40(sp)
    8000087e:	7402                	ld	s0,32(sp)
    80000880:	64e2                	ld	s1,24(sp)
    80000882:	6942                	ld	s2,16(sp)
    80000884:	69a2                	ld	s3,8(sp)
    80000886:	6a02                	ld	s4,0(sp)
    80000888:	6145                	addi	sp,sp,48
    8000088a:	8082                	ret
    panic("uvmfirst: more than a page");
    8000088c:	00008517          	auipc	a0,0x8
    80000890:	88c50513          	addi	a0,a0,-1908 # 80008118 <etext+0x118>
    80000894:	00005097          	auipc	ra,0x5
    80000898:	67e080e7          	jalr	1662(ra) # 80005f12 <panic>

000000008000089c <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000089c:	1101                	addi	sp,sp,-32
    8000089e:	ec06                	sd	ra,24(sp)
    800008a0:	e822                	sd	s0,16(sp)
    800008a2:	e426                	sd	s1,8(sp)
    800008a4:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800008a6:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008a8:	00b67d63          	bgeu	a2,a1,800008c2 <uvmdealloc+0x26>
    800008ac:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008ae:	6785                	lui	a5,0x1
    800008b0:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008b2:	00f60733          	add	a4,a2,a5
    800008b6:	76fd                	lui	a3,0xfffff
    800008b8:	8f75                	and	a4,a4,a3
    800008ba:	97ae                	add	a5,a5,a1
    800008bc:	8ff5                	and	a5,a5,a3
    800008be:	00f76863          	bltu	a4,a5,800008ce <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008c2:	8526                	mv	a0,s1
    800008c4:	60e2                	ld	ra,24(sp)
    800008c6:	6442                	ld	s0,16(sp)
    800008c8:	64a2                	ld	s1,8(sp)
    800008ca:	6105                	addi	sp,sp,32
    800008cc:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008ce:	8f99                	sub	a5,a5,a4
    800008d0:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008d2:	4685                	li	a3,1
    800008d4:	0007861b          	sext.w	a2,a5
    800008d8:	85ba                	mv	a1,a4
    800008da:	00000097          	auipc	ra,0x0
    800008de:	e4e080e7          	jalr	-434(ra) # 80000728 <uvmunmap>
    800008e2:	b7c5                	j	800008c2 <uvmdealloc+0x26>

00000000800008e4 <uvmalloc>:
  if(newsz < oldsz)
    800008e4:	0ab66b63          	bltu	a2,a1,8000099a <uvmalloc+0xb6>
{
    800008e8:	7139                	addi	sp,sp,-64
    800008ea:	fc06                	sd	ra,56(sp)
    800008ec:	f822                	sd	s0,48(sp)
    800008ee:	ec4e                	sd	s3,24(sp)
    800008f0:	e852                	sd	s4,16(sp)
    800008f2:	e456                	sd	s5,8(sp)
    800008f4:	0080                	addi	s0,sp,64
    800008f6:	8aaa                	mv	s5,a0
    800008f8:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008fa:	6785                	lui	a5,0x1
    800008fc:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008fe:	95be                	add	a1,a1,a5
    80000900:	77fd                	lui	a5,0xfffff
    80000902:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000906:	08c9fc63          	bgeu	s3,a2,8000099e <uvmalloc+0xba>
    8000090a:	f426                	sd	s1,40(sp)
    8000090c:	f04a                	sd	s2,32(sp)
    8000090e:	e05a                	sd	s6,0(sp)
    80000910:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000912:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000916:	00000097          	auipc	ra,0x0
    8000091a:	804080e7          	jalr	-2044(ra) # 8000011a <kalloc>
    8000091e:	84aa                	mv	s1,a0
    if(mem == 0){
    80000920:	c915                	beqz	a0,80000954 <uvmalloc+0x70>
    memset(mem, 0, PGSIZE);
    80000922:	6605                	lui	a2,0x1
    80000924:	4581                	li	a1,0
    80000926:	00000097          	auipc	ra,0x0
    8000092a:	854080e7          	jalr	-1964(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000092e:	875a                	mv	a4,s6
    80000930:	86a6                	mv	a3,s1
    80000932:	6605                	lui	a2,0x1
    80000934:	85ca                	mv	a1,s2
    80000936:	8556                	mv	a0,s5
    80000938:	00000097          	auipc	ra,0x0
    8000093c:	c06080e7          	jalr	-1018(ra) # 8000053e <mappages>
    80000940:	ed05                	bnez	a0,80000978 <uvmalloc+0x94>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000942:	6785                	lui	a5,0x1
    80000944:	993e                	add	s2,s2,a5
    80000946:	fd4968e3          	bltu	s2,s4,80000916 <uvmalloc+0x32>
  return newsz;
    8000094a:	8552                	mv	a0,s4
    8000094c:	74a2                	ld	s1,40(sp)
    8000094e:	7902                	ld	s2,32(sp)
    80000950:	6b02                	ld	s6,0(sp)
    80000952:	a821                	j	8000096a <uvmalloc+0x86>
      uvmdealloc(pagetable, a, oldsz);
    80000954:	864e                	mv	a2,s3
    80000956:	85ca                	mv	a1,s2
    80000958:	8556                	mv	a0,s5
    8000095a:	00000097          	auipc	ra,0x0
    8000095e:	f42080e7          	jalr	-190(ra) # 8000089c <uvmdealloc>
      return 0;
    80000962:	4501                	li	a0,0
    80000964:	74a2                	ld	s1,40(sp)
    80000966:	7902                	ld	s2,32(sp)
    80000968:	6b02                	ld	s6,0(sp)
}
    8000096a:	70e2                	ld	ra,56(sp)
    8000096c:	7442                	ld	s0,48(sp)
    8000096e:	69e2                	ld	s3,24(sp)
    80000970:	6a42                	ld	s4,16(sp)
    80000972:	6aa2                	ld	s5,8(sp)
    80000974:	6121                	addi	sp,sp,64
    80000976:	8082                	ret
      kfree(mem);
    80000978:	8526                	mv	a0,s1
    8000097a:	fffff097          	auipc	ra,0xfffff
    8000097e:	6a2080e7          	jalr	1698(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000982:	864e                	mv	a2,s3
    80000984:	85ca                	mv	a1,s2
    80000986:	8556                	mv	a0,s5
    80000988:	00000097          	auipc	ra,0x0
    8000098c:	f14080e7          	jalr	-236(ra) # 8000089c <uvmdealloc>
      return 0;
    80000990:	4501                	li	a0,0
    80000992:	74a2                	ld	s1,40(sp)
    80000994:	7902                	ld	s2,32(sp)
    80000996:	6b02                	ld	s6,0(sp)
    80000998:	bfc9                	j	8000096a <uvmalloc+0x86>
    return oldsz;
    8000099a:	852e                	mv	a0,a1
}
    8000099c:	8082                	ret
  return newsz;
    8000099e:	8532                	mv	a0,a2
    800009a0:	b7e9                	j	8000096a <uvmalloc+0x86>

00000000800009a2 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009a2:	7179                	addi	sp,sp,-48
    800009a4:	f406                	sd	ra,40(sp)
    800009a6:	f022                	sd	s0,32(sp)
    800009a8:	ec26                	sd	s1,24(sp)
    800009aa:	e84a                	sd	s2,16(sp)
    800009ac:	e44e                	sd	s3,8(sp)
    800009ae:	e052                	sd	s4,0(sp)
    800009b0:	1800                	addi	s0,sp,48
    800009b2:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009b4:	84aa                	mv	s1,a0
    800009b6:	6905                	lui	s2,0x1
    800009b8:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009ba:	4985                	li	s3,1
    800009bc:	a829                	j	800009d6 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009be:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009c0:	00c79513          	slli	a0,a5,0xc
    800009c4:	00000097          	auipc	ra,0x0
    800009c8:	fde080e7          	jalr	-34(ra) # 800009a2 <freewalk>
      pagetable[i] = 0;
    800009cc:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800009d0:	04a1                	addi	s1,s1,8
    800009d2:	03248163          	beq	s1,s2,800009f4 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800009d6:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009d8:	00f7f713          	andi	a4,a5,15
    800009dc:	ff3701e3          	beq	a4,s3,800009be <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009e0:	8b85                	andi	a5,a5,1
    800009e2:	d7fd                	beqz	a5,800009d0 <freewalk+0x2e>
      panic("freewalk: leaf");
    800009e4:	00007517          	auipc	a0,0x7
    800009e8:	75450513          	addi	a0,a0,1876 # 80008138 <etext+0x138>
    800009ec:	00005097          	auipc	ra,0x5
    800009f0:	526080e7          	jalr	1318(ra) # 80005f12 <panic>
    }
  }
  kfree((void*)pagetable);
    800009f4:	8552                	mv	a0,s4
    800009f6:	fffff097          	auipc	ra,0xfffff
    800009fa:	626080e7          	jalr	1574(ra) # 8000001c <kfree>
}
    800009fe:	70a2                	ld	ra,40(sp)
    80000a00:	7402                	ld	s0,32(sp)
    80000a02:	64e2                	ld	s1,24(sp)
    80000a04:	6942                	ld	s2,16(sp)
    80000a06:	69a2                	ld	s3,8(sp)
    80000a08:	6a02                	ld	s4,0(sp)
    80000a0a:	6145                	addi	sp,sp,48
    80000a0c:	8082                	ret

0000000080000a0e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a0e:	1101                	addi	sp,sp,-32
    80000a10:	ec06                	sd	ra,24(sp)
    80000a12:	e822                	sd	s0,16(sp)
    80000a14:	e426                	sd	s1,8(sp)
    80000a16:	1000                	addi	s0,sp,32
    80000a18:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a1a:	e999                	bnez	a1,80000a30 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a1c:	8526                	mv	a0,s1
    80000a1e:	00000097          	auipc	ra,0x0
    80000a22:	f84080e7          	jalr	-124(ra) # 800009a2 <freewalk>
}
    80000a26:	60e2                	ld	ra,24(sp)
    80000a28:	6442                	ld	s0,16(sp)
    80000a2a:	64a2                	ld	s1,8(sp)
    80000a2c:	6105                	addi	sp,sp,32
    80000a2e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a30:	6785                	lui	a5,0x1
    80000a32:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a34:	95be                	add	a1,a1,a5
    80000a36:	4685                	li	a3,1
    80000a38:	00c5d613          	srli	a2,a1,0xc
    80000a3c:	4581                	li	a1,0
    80000a3e:	00000097          	auipc	ra,0x0
    80000a42:	cea080e7          	jalr	-790(ra) # 80000728 <uvmunmap>
    80000a46:	bfd9                	j	80000a1c <uvmfree+0xe>

0000000080000a48 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a48:	c679                	beqz	a2,80000b16 <uvmcopy+0xce>
{
    80000a4a:	715d                	addi	sp,sp,-80
    80000a4c:	e486                	sd	ra,72(sp)
    80000a4e:	e0a2                	sd	s0,64(sp)
    80000a50:	fc26                	sd	s1,56(sp)
    80000a52:	f84a                	sd	s2,48(sp)
    80000a54:	f44e                	sd	s3,40(sp)
    80000a56:	f052                	sd	s4,32(sp)
    80000a58:	ec56                	sd	s5,24(sp)
    80000a5a:	e85a                	sd	s6,16(sp)
    80000a5c:	e45e                	sd	s7,8(sp)
    80000a5e:	0880                	addi	s0,sp,80
    80000a60:	8b2a                	mv	s6,a0
    80000a62:	8aae                	mv	s5,a1
    80000a64:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a66:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a68:	4601                	li	a2,0
    80000a6a:	85ce                	mv	a1,s3
    80000a6c:	855a                	mv	a0,s6
    80000a6e:	00000097          	auipc	ra,0x0
    80000a72:	9e8080e7          	jalr	-1560(ra) # 80000456 <walk>
    80000a76:	c531                	beqz	a0,80000ac2 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a78:	6118                	ld	a4,0(a0)
    80000a7a:	00177793          	andi	a5,a4,1
    80000a7e:	cbb1                	beqz	a5,80000ad2 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a80:	00a75593          	srli	a1,a4,0xa
    80000a84:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a88:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a8c:	fffff097          	auipc	ra,0xfffff
    80000a90:	68e080e7          	jalr	1678(ra) # 8000011a <kalloc>
    80000a94:	892a                	mv	s2,a0
    80000a96:	c939                	beqz	a0,80000aec <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a98:	6605                	lui	a2,0x1
    80000a9a:	85de                	mv	a1,s7
    80000a9c:	fffff097          	auipc	ra,0xfffff
    80000aa0:	73a080e7          	jalr	1850(ra) # 800001d6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000aa4:	8726                	mv	a4,s1
    80000aa6:	86ca                	mv	a3,s2
    80000aa8:	6605                	lui	a2,0x1
    80000aaa:	85ce                	mv	a1,s3
    80000aac:	8556                	mv	a0,s5
    80000aae:	00000097          	auipc	ra,0x0
    80000ab2:	a90080e7          	jalr	-1392(ra) # 8000053e <mappages>
    80000ab6:	e515                	bnez	a0,80000ae2 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000ab8:	6785                	lui	a5,0x1
    80000aba:	99be                	add	s3,s3,a5
    80000abc:	fb49e6e3          	bltu	s3,s4,80000a68 <uvmcopy+0x20>
    80000ac0:	a081                	j	80000b00 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000ac2:	00007517          	auipc	a0,0x7
    80000ac6:	68650513          	addi	a0,a0,1670 # 80008148 <etext+0x148>
    80000aca:	00005097          	auipc	ra,0x5
    80000ace:	448080e7          	jalr	1096(ra) # 80005f12 <panic>
      panic("uvmcopy: page not present");
    80000ad2:	00007517          	auipc	a0,0x7
    80000ad6:	69650513          	addi	a0,a0,1686 # 80008168 <etext+0x168>
    80000ada:	00005097          	auipc	ra,0x5
    80000ade:	438080e7          	jalr	1080(ra) # 80005f12 <panic>
      kfree(mem);
    80000ae2:	854a                	mv	a0,s2
    80000ae4:	fffff097          	auipc	ra,0xfffff
    80000ae8:	538080e7          	jalr	1336(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aec:	4685                	li	a3,1
    80000aee:	00c9d613          	srli	a2,s3,0xc
    80000af2:	4581                	li	a1,0
    80000af4:	8556                	mv	a0,s5
    80000af6:	00000097          	auipc	ra,0x0
    80000afa:	c32080e7          	jalr	-974(ra) # 80000728 <uvmunmap>
  return -1;
    80000afe:	557d                	li	a0,-1
}
    80000b00:	60a6                	ld	ra,72(sp)
    80000b02:	6406                	ld	s0,64(sp)
    80000b04:	74e2                	ld	s1,56(sp)
    80000b06:	7942                	ld	s2,48(sp)
    80000b08:	79a2                	ld	s3,40(sp)
    80000b0a:	7a02                	ld	s4,32(sp)
    80000b0c:	6ae2                	ld	s5,24(sp)
    80000b0e:	6b42                	ld	s6,16(sp)
    80000b10:	6ba2                	ld	s7,8(sp)
    80000b12:	6161                	addi	sp,sp,80
    80000b14:	8082                	ret
  return 0;
    80000b16:	4501                	li	a0,0
}
    80000b18:	8082                	ret

0000000080000b1a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b1a:	1141                	addi	sp,sp,-16
    80000b1c:	e406                	sd	ra,8(sp)
    80000b1e:	e022                	sd	s0,0(sp)
    80000b20:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b22:	4601                	li	a2,0
    80000b24:	00000097          	auipc	ra,0x0
    80000b28:	932080e7          	jalr	-1742(ra) # 80000456 <walk>
  if(pte == 0)
    80000b2c:	c901                	beqz	a0,80000b3c <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b2e:	611c                	ld	a5,0(a0)
    80000b30:	9bbd                	andi	a5,a5,-17
    80000b32:	e11c                	sd	a5,0(a0)
}
    80000b34:	60a2                	ld	ra,8(sp)
    80000b36:	6402                	ld	s0,0(sp)
    80000b38:	0141                	addi	sp,sp,16
    80000b3a:	8082                	ret
    panic("uvmclear");
    80000b3c:	00007517          	auipc	a0,0x7
    80000b40:	64c50513          	addi	a0,a0,1612 # 80008188 <etext+0x188>
    80000b44:	00005097          	auipc	ra,0x5
    80000b48:	3ce080e7          	jalr	974(ra) # 80005f12 <panic>

0000000080000b4c <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    80000b4c:	ced1                	beqz	a3,80000be8 <copyout+0x9c>
{
    80000b4e:	711d                	addi	sp,sp,-96
    80000b50:	ec86                	sd	ra,88(sp)
    80000b52:	e8a2                	sd	s0,80(sp)
    80000b54:	e4a6                	sd	s1,72(sp)
    80000b56:	fc4e                	sd	s3,56(sp)
    80000b58:	f456                	sd	s5,40(sp)
    80000b5a:	f05a                	sd	s6,32(sp)
    80000b5c:	ec5e                	sd	s7,24(sp)
    80000b5e:	1080                	addi	s0,sp,96
    80000b60:	8baa                	mv	s7,a0
    80000b62:	8aae                	mv	s5,a1
    80000b64:	8b32                	mv	s6,a2
    80000b66:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b68:	74fd                	lui	s1,0xfffff
    80000b6a:	8ced                	and	s1,s1,a1
    if(va0 >= MAXVA)
    80000b6c:	57fd                	li	a5,-1
    80000b6e:	83e9                	srli	a5,a5,0x1a
    80000b70:	0697ee63          	bltu	a5,s1,80000bec <copyout+0xa0>
    80000b74:	e0ca                	sd	s2,64(sp)
    80000b76:	f852                	sd	s4,48(sp)
    80000b78:	e862                	sd	s8,16(sp)
    80000b7a:	e466                	sd	s9,8(sp)
    80000b7c:	e06a                	sd	s10,0(sp)
      return -1;
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000b7e:	4cd5                	li	s9,21
    80000b80:	6d05                	lui	s10,0x1
    if(va0 >= MAXVA)
    80000b82:	8c3e                	mv	s8,a5
    80000b84:	a035                	j	80000bb0 <copyout+0x64>
       (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    80000b86:	83a9                	srli	a5,a5,0xa
    80000b88:	07b2                	slli	a5,a5,0xc
    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b8a:	409a8533          	sub	a0,s5,s1
    80000b8e:	0009061b          	sext.w	a2,s2
    80000b92:	85da                	mv	a1,s6
    80000b94:	953e                	add	a0,a0,a5
    80000b96:	fffff097          	auipc	ra,0xfffff
    80000b9a:	640080e7          	jalr	1600(ra) # 800001d6 <memmove>

    len -= n;
    80000b9e:	412989b3          	sub	s3,s3,s2
    src += n;
    80000ba2:	9b4a                	add	s6,s6,s2
  while(len > 0){
    80000ba4:	02098b63          	beqz	s3,80000bda <copyout+0x8e>
    if(va0 >= MAXVA)
    80000ba8:	054c6463          	bltu	s8,s4,80000bf0 <copyout+0xa4>
    80000bac:	84d2                	mv	s1,s4
    80000bae:	8ad2                	mv	s5,s4
    pte = walk(pagetable, va0, 0);
    80000bb0:	4601                	li	a2,0
    80000bb2:	85a6                	mv	a1,s1
    80000bb4:	855e                	mv	a0,s7
    80000bb6:	00000097          	auipc	ra,0x0
    80000bba:	8a0080e7          	jalr	-1888(ra) # 80000456 <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000bbe:	c121                	beqz	a0,80000bfe <copyout+0xb2>
    80000bc0:	611c                	ld	a5,0(a0)
    80000bc2:	0157f713          	andi	a4,a5,21
    80000bc6:	05971b63          	bne	a4,s9,80000c1c <copyout+0xd0>
    n = PGSIZE - (dstva - va0);
    80000bca:	01a48a33          	add	s4,s1,s10
    80000bce:	415a0933          	sub	s2,s4,s5
    if(n > len)
    80000bd2:	fb29fae3          	bgeu	s3,s2,80000b86 <copyout+0x3a>
    80000bd6:	894e                	mv	s2,s3
    80000bd8:	b77d                	j	80000b86 <copyout+0x3a>
    dstva = va0 + PGSIZE;
  }
  return 0;
    80000bda:	4501                	li	a0,0
    80000bdc:	6906                	ld	s2,64(sp)
    80000bde:	7a42                	ld	s4,48(sp)
    80000be0:	6c42                	ld	s8,16(sp)
    80000be2:	6ca2                	ld	s9,8(sp)
    80000be4:	6d02                	ld	s10,0(sp)
    80000be6:	a015                	j	80000c0a <copyout+0xbe>
    80000be8:	4501                	li	a0,0
}
    80000bea:	8082                	ret
      return -1;
    80000bec:	557d                	li	a0,-1
    80000bee:	a831                	j	80000c0a <copyout+0xbe>
    80000bf0:	557d                	li	a0,-1
    80000bf2:	6906                	ld	s2,64(sp)
    80000bf4:	7a42                	ld	s4,48(sp)
    80000bf6:	6c42                	ld	s8,16(sp)
    80000bf8:	6ca2                	ld	s9,8(sp)
    80000bfa:	6d02                	ld	s10,0(sp)
    80000bfc:	a039                	j	80000c0a <copyout+0xbe>
      return -1;
    80000bfe:	557d                	li	a0,-1
    80000c00:	6906                	ld	s2,64(sp)
    80000c02:	7a42                	ld	s4,48(sp)
    80000c04:	6c42                	ld	s8,16(sp)
    80000c06:	6ca2                	ld	s9,8(sp)
    80000c08:	6d02                	ld	s10,0(sp)
}
    80000c0a:	60e6                	ld	ra,88(sp)
    80000c0c:	6446                	ld	s0,80(sp)
    80000c0e:	64a6                	ld	s1,72(sp)
    80000c10:	79e2                	ld	s3,56(sp)
    80000c12:	7aa2                	ld	s5,40(sp)
    80000c14:	7b02                	ld	s6,32(sp)
    80000c16:	6be2                	ld	s7,24(sp)
    80000c18:	6125                	addi	sp,sp,96
    80000c1a:	8082                	ret
      return -1;
    80000c1c:	557d                	li	a0,-1
    80000c1e:	6906                	ld	s2,64(sp)
    80000c20:	7a42                	ld	s4,48(sp)
    80000c22:	6c42                	ld	s8,16(sp)
    80000c24:	6ca2                	ld	s9,8(sp)
    80000c26:	6d02                	ld	s10,0(sp)
    80000c28:	b7cd                	j	80000c0a <copyout+0xbe>

0000000080000c2a <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000c2a:	caa5                	beqz	a3,80000c9a <copyin+0x70>
{
    80000c2c:	715d                	addi	sp,sp,-80
    80000c2e:	e486                	sd	ra,72(sp)
    80000c30:	e0a2                	sd	s0,64(sp)
    80000c32:	fc26                	sd	s1,56(sp)
    80000c34:	f84a                	sd	s2,48(sp)
    80000c36:	f44e                	sd	s3,40(sp)
    80000c38:	f052                	sd	s4,32(sp)
    80000c3a:	ec56                	sd	s5,24(sp)
    80000c3c:	e85a                	sd	s6,16(sp)
    80000c3e:	e45e                	sd	s7,8(sp)
    80000c40:	e062                	sd	s8,0(sp)
    80000c42:	0880                	addi	s0,sp,80
    80000c44:	8b2a                	mv	s6,a0
    80000c46:	8a2e                	mv	s4,a1
    80000c48:	8c32                	mv	s8,a2
    80000c4a:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c4c:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c4e:	6a85                	lui	s5,0x1
    80000c50:	a01d                	j	80000c76 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c52:	018505b3          	add	a1,a0,s8
    80000c56:	0004861b          	sext.w	a2,s1
    80000c5a:	412585b3          	sub	a1,a1,s2
    80000c5e:	8552                	mv	a0,s4
    80000c60:	fffff097          	auipc	ra,0xfffff
    80000c64:	576080e7          	jalr	1398(ra) # 800001d6 <memmove>

    len -= n;
    80000c68:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c6c:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c6e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c72:	02098263          	beqz	s3,80000c96 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c76:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c7a:	85ca                	mv	a1,s2
    80000c7c:	855a                	mv	a0,s6
    80000c7e:	00000097          	auipc	ra,0x0
    80000c82:	87e080e7          	jalr	-1922(ra) # 800004fc <walkaddr>
    if(pa0 == 0)
    80000c86:	cd01                	beqz	a0,80000c9e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c88:	418904b3          	sub	s1,s2,s8
    80000c8c:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c8e:	fc99f2e3          	bgeu	s3,s1,80000c52 <copyin+0x28>
    80000c92:	84ce                	mv	s1,s3
    80000c94:	bf7d                	j	80000c52 <copyin+0x28>
  }
  return 0;
    80000c96:	4501                	li	a0,0
    80000c98:	a021                	j	80000ca0 <copyin+0x76>
    80000c9a:	4501                	li	a0,0
}
    80000c9c:	8082                	ret
      return -1;
    80000c9e:	557d                	li	a0,-1
}
    80000ca0:	60a6                	ld	ra,72(sp)
    80000ca2:	6406                	ld	s0,64(sp)
    80000ca4:	74e2                	ld	s1,56(sp)
    80000ca6:	7942                	ld	s2,48(sp)
    80000ca8:	79a2                	ld	s3,40(sp)
    80000caa:	7a02                	ld	s4,32(sp)
    80000cac:	6ae2                	ld	s5,24(sp)
    80000cae:	6b42                	ld	s6,16(sp)
    80000cb0:	6ba2                	ld	s7,8(sp)
    80000cb2:	6c02                	ld	s8,0(sp)
    80000cb4:	6161                	addi	sp,sp,80
    80000cb6:	8082                	ret

0000000080000cb8 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000cb8:	cacd                	beqz	a3,80000d6a <copyinstr+0xb2>
{
    80000cba:	715d                	addi	sp,sp,-80
    80000cbc:	e486                	sd	ra,72(sp)
    80000cbe:	e0a2                	sd	s0,64(sp)
    80000cc0:	fc26                	sd	s1,56(sp)
    80000cc2:	f84a                	sd	s2,48(sp)
    80000cc4:	f44e                	sd	s3,40(sp)
    80000cc6:	f052                	sd	s4,32(sp)
    80000cc8:	ec56                	sd	s5,24(sp)
    80000cca:	e85a                	sd	s6,16(sp)
    80000ccc:	e45e                	sd	s7,8(sp)
    80000cce:	0880                	addi	s0,sp,80
    80000cd0:	8a2a                	mv	s4,a0
    80000cd2:	8b2e                	mv	s6,a1
    80000cd4:	8bb2                	mv	s7,a2
    80000cd6:	8936                	mv	s2,a3
    va0 = PGROUNDDOWN(srcva);
    80000cd8:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000cda:	6985                	lui	s3,0x1
    80000cdc:	a825                	j	80000d14 <copyinstr+0x5c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000cde:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000ce2:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000ce4:	37fd                	addiw	a5,a5,-1
    80000ce6:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000cea:	60a6                	ld	ra,72(sp)
    80000cec:	6406                	ld	s0,64(sp)
    80000cee:	74e2                	ld	s1,56(sp)
    80000cf0:	7942                	ld	s2,48(sp)
    80000cf2:	79a2                	ld	s3,40(sp)
    80000cf4:	7a02                	ld	s4,32(sp)
    80000cf6:	6ae2                	ld	s5,24(sp)
    80000cf8:	6b42                	ld	s6,16(sp)
    80000cfa:	6ba2                	ld	s7,8(sp)
    80000cfc:	6161                	addi	sp,sp,80
    80000cfe:	8082                	ret
    80000d00:	fff90713          	addi	a4,s2,-1 # fff <_entry-0x7ffff001>
    80000d04:	9742                	add	a4,a4,a6
      --max;
    80000d06:	40b70933          	sub	s2,a4,a1
    srcva = va0 + PGSIZE;
    80000d0a:	01348bb3          	add	s7,s1,s3
  while(got_null == 0 && max > 0){
    80000d0e:	04e58663          	beq	a1,a4,80000d5a <copyinstr+0xa2>
{
    80000d12:	8b3e                	mv	s6,a5
    va0 = PGROUNDDOWN(srcva);
    80000d14:	015bf4b3          	and	s1,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000d18:	85a6                	mv	a1,s1
    80000d1a:	8552                	mv	a0,s4
    80000d1c:	fffff097          	auipc	ra,0xfffff
    80000d20:	7e0080e7          	jalr	2016(ra) # 800004fc <walkaddr>
    if(pa0 == 0)
    80000d24:	cd0d                	beqz	a0,80000d5e <copyinstr+0xa6>
    n = PGSIZE - (srcva - va0);
    80000d26:	417486b3          	sub	a3,s1,s7
    80000d2a:	96ce                	add	a3,a3,s3
    if(n > max)
    80000d2c:	00d97363          	bgeu	s2,a3,80000d32 <copyinstr+0x7a>
    80000d30:	86ca                	mv	a3,s2
    char *p = (char *) (pa0 + (srcva - va0));
    80000d32:	955e                	add	a0,a0,s7
    80000d34:	8d05                	sub	a0,a0,s1
    while(n > 0){
    80000d36:	c695                	beqz	a3,80000d62 <copyinstr+0xaa>
    80000d38:	87da                	mv	a5,s6
    80000d3a:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000d3c:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000d40:	96da                	add	a3,a3,s6
    80000d42:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000d44:	00f60733          	add	a4,a2,a5
    80000d48:	00074703          	lbu	a4,0(a4)
    80000d4c:	db49                	beqz	a4,80000cde <copyinstr+0x26>
        *dst = *p;
    80000d4e:	00e78023          	sb	a4,0(a5)
      dst++;
    80000d52:	0785                	addi	a5,a5,1
    while(n > 0){
    80000d54:	fed797e3          	bne	a5,a3,80000d42 <copyinstr+0x8a>
    80000d58:	b765                	j	80000d00 <copyinstr+0x48>
    80000d5a:	4781                	li	a5,0
    80000d5c:	b761                	j	80000ce4 <copyinstr+0x2c>
      return -1;
    80000d5e:	557d                	li	a0,-1
    80000d60:	b769                	j	80000cea <copyinstr+0x32>
    srcva = va0 + PGSIZE;
    80000d62:	6b85                	lui	s7,0x1
    80000d64:	9ba6                	add	s7,s7,s1
    80000d66:	87da                	mv	a5,s6
    80000d68:	b76d                	j	80000d12 <copyinstr+0x5a>
  int got_null = 0;
    80000d6a:	4781                	li	a5,0
  if(got_null){
    80000d6c:	37fd                	addiw	a5,a5,-1
    80000d6e:	0007851b          	sext.w	a0,a5
}
    80000d72:	8082                	ret

0000000080000d74 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000d74:	7139                	addi	sp,sp,-64
    80000d76:	fc06                	sd	ra,56(sp)
    80000d78:	f822                	sd	s0,48(sp)
    80000d7a:	f426                	sd	s1,40(sp)
    80000d7c:	f04a                	sd	s2,32(sp)
    80000d7e:	ec4e                	sd	s3,24(sp)
    80000d80:	e852                	sd	s4,16(sp)
    80000d82:	e456                	sd	s5,8(sp)
    80000d84:	e05a                	sd	s6,0(sp)
    80000d86:	0080                	addi	s0,sp,64
    80000d88:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d8a:	0000b497          	auipc	s1,0xb
    80000d8e:	90648493          	addi	s1,s1,-1786 # 8000b690 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d92:	8b26                	mv	s6,s1
    80000d94:	04fa5937          	lui	s2,0x4fa5
    80000d98:	fa590913          	addi	s2,s2,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80000d9c:	0932                	slli	s2,s2,0xc
    80000d9e:	fa590913          	addi	s2,s2,-91
    80000da2:	0932                	slli	s2,s2,0xc
    80000da4:	fa590913          	addi	s2,s2,-91
    80000da8:	0932                	slli	s2,s2,0xc
    80000daa:	fa590913          	addi	s2,s2,-91
    80000dae:	040009b7          	lui	s3,0x4000
    80000db2:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000db4:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000db6:	00010a97          	auipc	s5,0x10
    80000dba:	2daa8a93          	addi	s5,s5,730 # 80011090 <tickslock>
    char *pa = kalloc();
    80000dbe:	fffff097          	auipc	ra,0xfffff
    80000dc2:	35c080e7          	jalr	860(ra) # 8000011a <kalloc>
    80000dc6:	862a                	mv	a2,a0
    if(pa == 0)
    80000dc8:	c121                	beqz	a0,80000e08 <proc_mapstacks+0x94>
    uint64 va = KSTACK((int) (p - proc));
    80000dca:	416485b3          	sub	a1,s1,s6
    80000dce:	858d                	srai	a1,a1,0x3
    80000dd0:	032585b3          	mul	a1,a1,s2
    80000dd4:	2585                	addiw	a1,a1,1
    80000dd6:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000dda:	4719                	li	a4,6
    80000ddc:	6685                	lui	a3,0x1
    80000dde:	40b985b3          	sub	a1,s3,a1
    80000de2:	8552                	mv	a0,s4
    80000de4:	00000097          	auipc	ra,0x0
    80000de8:	81e080e7          	jalr	-2018(ra) # 80000602 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dec:	16848493          	addi	s1,s1,360
    80000df0:	fd5497e3          	bne	s1,s5,80000dbe <proc_mapstacks+0x4a>
  }
}
    80000df4:	70e2                	ld	ra,56(sp)
    80000df6:	7442                	ld	s0,48(sp)
    80000df8:	74a2                	ld	s1,40(sp)
    80000dfa:	7902                	ld	s2,32(sp)
    80000dfc:	69e2                	ld	s3,24(sp)
    80000dfe:	6a42                	ld	s4,16(sp)
    80000e00:	6aa2                	ld	s5,8(sp)
    80000e02:	6b02                	ld	s6,0(sp)
    80000e04:	6121                	addi	sp,sp,64
    80000e06:	8082                	ret
      panic("kalloc");
    80000e08:	00007517          	auipc	a0,0x7
    80000e0c:	39050513          	addi	a0,a0,912 # 80008198 <etext+0x198>
    80000e10:	00005097          	auipc	ra,0x5
    80000e14:	102080e7          	jalr	258(ra) # 80005f12 <panic>

0000000080000e18 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000e18:	7139                	addi	sp,sp,-64
    80000e1a:	fc06                	sd	ra,56(sp)
    80000e1c:	f822                	sd	s0,48(sp)
    80000e1e:	f426                	sd	s1,40(sp)
    80000e20:	f04a                	sd	s2,32(sp)
    80000e22:	ec4e                	sd	s3,24(sp)
    80000e24:	e852                	sd	s4,16(sp)
    80000e26:	e456                	sd	s5,8(sp)
    80000e28:	e05a                	sd	s6,0(sp)
    80000e2a:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000e2c:	00007597          	auipc	a1,0x7
    80000e30:	37458593          	addi	a1,a1,884 # 800081a0 <etext+0x1a0>
    80000e34:	0000a517          	auipc	a0,0xa
    80000e38:	42c50513          	addi	a0,a0,1068 # 8000b260 <pid_lock>
    80000e3c:	00005097          	auipc	ra,0x5
    80000e40:	5c0080e7          	jalr	1472(ra) # 800063fc <initlock>
  initlock(&wait_lock, "wait_lock");
    80000e44:	00007597          	auipc	a1,0x7
    80000e48:	36458593          	addi	a1,a1,868 # 800081a8 <etext+0x1a8>
    80000e4c:	0000a517          	auipc	a0,0xa
    80000e50:	42c50513          	addi	a0,a0,1068 # 8000b278 <wait_lock>
    80000e54:	00005097          	auipc	ra,0x5
    80000e58:	5a8080e7          	jalr	1448(ra) # 800063fc <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e5c:	0000b497          	auipc	s1,0xb
    80000e60:	83448493          	addi	s1,s1,-1996 # 8000b690 <proc>
      initlock(&p->lock, "proc");
    80000e64:	00007b17          	auipc	s6,0x7
    80000e68:	354b0b13          	addi	s6,s6,852 # 800081b8 <etext+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000e6c:	8aa6                	mv	s5,s1
    80000e6e:	04fa5937          	lui	s2,0x4fa5
    80000e72:	fa590913          	addi	s2,s2,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80000e76:	0932                	slli	s2,s2,0xc
    80000e78:	fa590913          	addi	s2,s2,-91
    80000e7c:	0932                	slli	s2,s2,0xc
    80000e7e:	fa590913          	addi	s2,s2,-91
    80000e82:	0932                	slli	s2,s2,0xc
    80000e84:	fa590913          	addi	s2,s2,-91
    80000e88:	040009b7          	lui	s3,0x4000
    80000e8c:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000e8e:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e90:	00010a17          	auipc	s4,0x10
    80000e94:	200a0a13          	addi	s4,s4,512 # 80011090 <tickslock>
      initlock(&p->lock, "proc");
    80000e98:	85da                	mv	a1,s6
    80000e9a:	8526                	mv	a0,s1
    80000e9c:	00005097          	auipc	ra,0x5
    80000ea0:	560080e7          	jalr	1376(ra) # 800063fc <initlock>
      p->state = UNUSED;
    80000ea4:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000ea8:	415487b3          	sub	a5,s1,s5
    80000eac:	878d                	srai	a5,a5,0x3
    80000eae:	032787b3          	mul	a5,a5,s2
    80000eb2:	2785                	addiw	a5,a5,1
    80000eb4:	00d7979b          	slliw	a5,a5,0xd
    80000eb8:	40f987b3          	sub	a5,s3,a5
    80000ebc:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ebe:	16848493          	addi	s1,s1,360
    80000ec2:	fd449be3          	bne	s1,s4,80000e98 <procinit+0x80>
  }
}
    80000ec6:	70e2                	ld	ra,56(sp)
    80000ec8:	7442                	ld	s0,48(sp)
    80000eca:	74a2                	ld	s1,40(sp)
    80000ecc:	7902                	ld	s2,32(sp)
    80000ece:	69e2                	ld	s3,24(sp)
    80000ed0:	6a42                	ld	s4,16(sp)
    80000ed2:	6aa2                	ld	s5,8(sp)
    80000ed4:	6b02                	ld	s6,0(sp)
    80000ed6:	6121                	addi	sp,sp,64
    80000ed8:	8082                	ret

0000000080000eda <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000eda:	1141                	addi	sp,sp,-16
    80000edc:	e422                	sd	s0,8(sp)
    80000ede:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000ee0:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000ee2:	2501                	sext.w	a0,a0
    80000ee4:	6422                	ld	s0,8(sp)
    80000ee6:	0141                	addi	sp,sp,16
    80000ee8:	8082                	ret

0000000080000eea <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000eea:	1141                	addi	sp,sp,-16
    80000eec:	e422                	sd	s0,8(sp)
    80000eee:	0800                	addi	s0,sp,16
    80000ef0:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000ef2:	2781                	sext.w	a5,a5
    80000ef4:	079e                	slli	a5,a5,0x7
  return c;
}
    80000ef6:	0000a517          	auipc	a0,0xa
    80000efa:	39a50513          	addi	a0,a0,922 # 8000b290 <cpus>
    80000efe:	953e                	add	a0,a0,a5
    80000f00:	6422                	ld	s0,8(sp)
    80000f02:	0141                	addi	sp,sp,16
    80000f04:	8082                	ret

0000000080000f06 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000f06:	1101                	addi	sp,sp,-32
    80000f08:	ec06                	sd	ra,24(sp)
    80000f0a:	e822                	sd	s0,16(sp)
    80000f0c:	e426                	sd	s1,8(sp)
    80000f0e:	1000                	addi	s0,sp,32
  push_off();
    80000f10:	00005097          	auipc	ra,0x5
    80000f14:	530080e7          	jalr	1328(ra) # 80006440 <push_off>
    80000f18:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000f1a:	2781                	sext.w	a5,a5
    80000f1c:	079e                	slli	a5,a5,0x7
    80000f1e:	0000a717          	auipc	a4,0xa
    80000f22:	34270713          	addi	a4,a4,834 # 8000b260 <pid_lock>
    80000f26:	97ba                	add	a5,a5,a4
    80000f28:	7b84                	ld	s1,48(a5)
  pop_off();
    80000f2a:	00005097          	auipc	ra,0x5
    80000f2e:	5b6080e7          	jalr	1462(ra) # 800064e0 <pop_off>
  return p;
}
    80000f32:	8526                	mv	a0,s1
    80000f34:	60e2                	ld	ra,24(sp)
    80000f36:	6442                	ld	s0,16(sp)
    80000f38:	64a2                	ld	s1,8(sp)
    80000f3a:	6105                	addi	sp,sp,32
    80000f3c:	8082                	ret

0000000080000f3e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000f3e:	1141                	addi	sp,sp,-16
    80000f40:	e406                	sd	ra,8(sp)
    80000f42:	e022                	sd	s0,0(sp)
    80000f44:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000f46:	00000097          	auipc	ra,0x0
    80000f4a:	fc0080e7          	jalr	-64(ra) # 80000f06 <myproc>
    80000f4e:	00005097          	auipc	ra,0x5
    80000f52:	5f2080e7          	jalr	1522(ra) # 80006540 <release>

  if (first) {
    80000f56:	0000a797          	auipc	a5,0xa
    80000f5a:	24a7a783          	lw	a5,586(a5) # 8000b1a0 <first.1>
    80000f5e:	eb89                	bnez	a5,80000f70 <forkret+0x32>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    80000f60:	00001097          	auipc	ra,0x1
    80000f64:	c62080e7          	jalr	-926(ra) # 80001bc2 <usertrapret>
}
    80000f68:	60a2                	ld	ra,8(sp)
    80000f6a:	6402                	ld	s0,0(sp)
    80000f6c:	0141                	addi	sp,sp,16
    80000f6e:	8082                	ret
    fsinit(ROOTDEV);
    80000f70:	4505                	li	a0,1
    80000f72:	00002097          	auipc	ra,0x2
    80000f76:	aaa080e7          	jalr	-1366(ra) # 80002a1c <fsinit>
    first = 0;
    80000f7a:	0000a797          	auipc	a5,0xa
    80000f7e:	2207a323          	sw	zero,550(a5) # 8000b1a0 <first.1>
    __sync_synchronize();
    80000f82:	0330000f          	fence	rw,rw
    80000f86:	bfe9                	j	80000f60 <forkret+0x22>

0000000080000f88 <allocpid>:
{
    80000f88:	1101                	addi	sp,sp,-32
    80000f8a:	ec06                	sd	ra,24(sp)
    80000f8c:	e822                	sd	s0,16(sp)
    80000f8e:	e426                	sd	s1,8(sp)
    80000f90:	e04a                	sd	s2,0(sp)
    80000f92:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f94:	0000a917          	auipc	s2,0xa
    80000f98:	2cc90913          	addi	s2,s2,716 # 8000b260 <pid_lock>
    80000f9c:	854a                	mv	a0,s2
    80000f9e:	00005097          	auipc	ra,0x5
    80000fa2:	4ee080e7          	jalr	1262(ra) # 8000648c <acquire>
  pid = nextpid;
    80000fa6:	0000a797          	auipc	a5,0xa
    80000faa:	1fe78793          	addi	a5,a5,510 # 8000b1a4 <nextpid>
    80000fae:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000fb0:	0014871b          	addiw	a4,s1,1
    80000fb4:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000fb6:	854a                	mv	a0,s2
    80000fb8:	00005097          	auipc	ra,0x5
    80000fbc:	588080e7          	jalr	1416(ra) # 80006540 <release>
}
    80000fc0:	8526                	mv	a0,s1
    80000fc2:	60e2                	ld	ra,24(sp)
    80000fc4:	6442                	ld	s0,16(sp)
    80000fc6:	64a2                	ld	s1,8(sp)
    80000fc8:	6902                	ld	s2,0(sp)
    80000fca:	6105                	addi	sp,sp,32
    80000fcc:	8082                	ret

0000000080000fce <proc_pagetable>:
{
    80000fce:	1101                	addi	sp,sp,-32
    80000fd0:	ec06                	sd	ra,24(sp)
    80000fd2:	e822                	sd	s0,16(sp)
    80000fd4:	e426                	sd	s1,8(sp)
    80000fd6:	e04a                	sd	s2,0(sp)
    80000fd8:	1000                	addi	s0,sp,32
    80000fda:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000fdc:	00000097          	auipc	ra,0x0
    80000fe0:	820080e7          	jalr	-2016(ra) # 800007fc <uvmcreate>
    80000fe4:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000fe6:	c121                	beqz	a0,80001026 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000fe8:	4729                	li	a4,10
    80000fea:	00006697          	auipc	a3,0x6
    80000fee:	01668693          	addi	a3,a3,22 # 80007000 <_trampoline>
    80000ff2:	6605                	lui	a2,0x1
    80000ff4:	040005b7          	lui	a1,0x4000
    80000ff8:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ffa:	05b2                	slli	a1,a1,0xc
    80000ffc:	fffff097          	auipc	ra,0xfffff
    80001000:	542080e7          	jalr	1346(ra) # 8000053e <mappages>
    80001004:	02054863          	bltz	a0,80001034 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001008:	4719                	li	a4,6
    8000100a:	05893683          	ld	a3,88(s2)
    8000100e:	6605                	lui	a2,0x1
    80001010:	020005b7          	lui	a1,0x2000
    80001014:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001016:	05b6                	slli	a1,a1,0xd
    80001018:	8526                	mv	a0,s1
    8000101a:	fffff097          	auipc	ra,0xfffff
    8000101e:	524080e7          	jalr	1316(ra) # 8000053e <mappages>
    80001022:	02054163          	bltz	a0,80001044 <proc_pagetable+0x76>
}
    80001026:	8526                	mv	a0,s1
    80001028:	60e2                	ld	ra,24(sp)
    8000102a:	6442                	ld	s0,16(sp)
    8000102c:	64a2                	ld	s1,8(sp)
    8000102e:	6902                	ld	s2,0(sp)
    80001030:	6105                	addi	sp,sp,32
    80001032:	8082                	ret
    uvmfree(pagetable, 0);
    80001034:	4581                	li	a1,0
    80001036:	8526                	mv	a0,s1
    80001038:	00000097          	auipc	ra,0x0
    8000103c:	9d6080e7          	jalr	-1578(ra) # 80000a0e <uvmfree>
    return 0;
    80001040:	4481                	li	s1,0
    80001042:	b7d5                	j	80001026 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001044:	4681                	li	a3,0
    80001046:	4605                	li	a2,1
    80001048:	040005b7          	lui	a1,0x4000
    8000104c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000104e:	05b2                	slli	a1,a1,0xc
    80001050:	8526                	mv	a0,s1
    80001052:	fffff097          	auipc	ra,0xfffff
    80001056:	6d6080e7          	jalr	1750(ra) # 80000728 <uvmunmap>
    uvmfree(pagetable, 0);
    8000105a:	4581                	li	a1,0
    8000105c:	8526                	mv	a0,s1
    8000105e:	00000097          	auipc	ra,0x0
    80001062:	9b0080e7          	jalr	-1616(ra) # 80000a0e <uvmfree>
    return 0;
    80001066:	4481                	li	s1,0
    80001068:	bf7d                	j	80001026 <proc_pagetable+0x58>

000000008000106a <proc_freepagetable>:
{
    8000106a:	1101                	addi	sp,sp,-32
    8000106c:	ec06                	sd	ra,24(sp)
    8000106e:	e822                	sd	s0,16(sp)
    80001070:	e426                	sd	s1,8(sp)
    80001072:	e04a                	sd	s2,0(sp)
    80001074:	1000                	addi	s0,sp,32
    80001076:	84aa                	mv	s1,a0
    80001078:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000107a:	4681                	li	a3,0
    8000107c:	4605                	li	a2,1
    8000107e:	040005b7          	lui	a1,0x4000
    80001082:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001084:	05b2                	slli	a1,a1,0xc
    80001086:	fffff097          	auipc	ra,0xfffff
    8000108a:	6a2080e7          	jalr	1698(ra) # 80000728 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000108e:	4681                	li	a3,0
    80001090:	4605                	li	a2,1
    80001092:	020005b7          	lui	a1,0x2000
    80001096:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001098:	05b6                	slli	a1,a1,0xd
    8000109a:	8526                	mv	a0,s1
    8000109c:	fffff097          	auipc	ra,0xfffff
    800010a0:	68c080e7          	jalr	1676(ra) # 80000728 <uvmunmap>
  uvmfree(pagetable, sz);
    800010a4:	85ca                	mv	a1,s2
    800010a6:	8526                	mv	a0,s1
    800010a8:	00000097          	auipc	ra,0x0
    800010ac:	966080e7          	jalr	-1690(ra) # 80000a0e <uvmfree>
}
    800010b0:	60e2                	ld	ra,24(sp)
    800010b2:	6442                	ld	s0,16(sp)
    800010b4:	64a2                	ld	s1,8(sp)
    800010b6:	6902                	ld	s2,0(sp)
    800010b8:	6105                	addi	sp,sp,32
    800010ba:	8082                	ret

00000000800010bc <freeproc>:
{
    800010bc:	1101                	addi	sp,sp,-32
    800010be:	ec06                	sd	ra,24(sp)
    800010c0:	e822                	sd	s0,16(sp)
    800010c2:	e426                	sd	s1,8(sp)
    800010c4:	1000                	addi	s0,sp,32
    800010c6:	84aa                	mv	s1,a0
  if(p->trapframe)
    800010c8:	6d28                	ld	a0,88(a0)
    800010ca:	c509                	beqz	a0,800010d4 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800010cc:	fffff097          	auipc	ra,0xfffff
    800010d0:	f50080e7          	jalr	-176(ra) # 8000001c <kfree>
  p->trapframe = 0;
    800010d4:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    800010d8:	68a8                	ld	a0,80(s1)
    800010da:	c511                	beqz	a0,800010e6 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    800010dc:	64ac                	ld	a1,72(s1)
    800010de:	00000097          	auipc	ra,0x0
    800010e2:	f8c080e7          	jalr	-116(ra) # 8000106a <proc_freepagetable>
  p->pagetable = 0;
    800010e6:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800010ea:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800010ee:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    800010f2:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    800010f6:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800010fa:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800010fe:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001102:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001106:	0004ac23          	sw	zero,24(s1)
}
    8000110a:	60e2                	ld	ra,24(sp)
    8000110c:	6442                	ld	s0,16(sp)
    8000110e:	64a2                	ld	s1,8(sp)
    80001110:	6105                	addi	sp,sp,32
    80001112:	8082                	ret

0000000080001114 <allocproc>:
{
    80001114:	1101                	addi	sp,sp,-32
    80001116:	ec06                	sd	ra,24(sp)
    80001118:	e822                	sd	s0,16(sp)
    8000111a:	e426                	sd	s1,8(sp)
    8000111c:	e04a                	sd	s2,0(sp)
    8000111e:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001120:	0000a497          	auipc	s1,0xa
    80001124:	57048493          	addi	s1,s1,1392 # 8000b690 <proc>
    80001128:	00010917          	auipc	s2,0x10
    8000112c:	f6890913          	addi	s2,s2,-152 # 80011090 <tickslock>
    acquire(&p->lock);
    80001130:	8526                	mv	a0,s1
    80001132:	00005097          	auipc	ra,0x5
    80001136:	35a080e7          	jalr	858(ra) # 8000648c <acquire>
    if(p->state == UNUSED) {
    8000113a:	4c9c                	lw	a5,24(s1)
    8000113c:	cf81                	beqz	a5,80001154 <allocproc+0x40>
      release(&p->lock);
    8000113e:	8526                	mv	a0,s1
    80001140:	00005097          	auipc	ra,0x5
    80001144:	400080e7          	jalr	1024(ra) # 80006540 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001148:	16848493          	addi	s1,s1,360
    8000114c:	ff2492e3          	bne	s1,s2,80001130 <allocproc+0x1c>
  return 0;
    80001150:	4481                	li	s1,0
    80001152:	a889                	j	800011a4 <allocproc+0x90>
  p->pid = allocpid();
    80001154:	00000097          	auipc	ra,0x0
    80001158:	e34080e7          	jalr	-460(ra) # 80000f88 <allocpid>
    8000115c:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000115e:	4785                	li	a5,1
    80001160:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001162:	fffff097          	auipc	ra,0xfffff
    80001166:	fb8080e7          	jalr	-72(ra) # 8000011a <kalloc>
    8000116a:	892a                	mv	s2,a0
    8000116c:	eca8                	sd	a0,88(s1)
    8000116e:	c131                	beqz	a0,800011b2 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001170:	8526                	mv	a0,s1
    80001172:	00000097          	auipc	ra,0x0
    80001176:	e5c080e7          	jalr	-420(ra) # 80000fce <proc_pagetable>
    8000117a:	892a                	mv	s2,a0
    8000117c:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000117e:	c531                	beqz	a0,800011ca <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001180:	07000613          	li	a2,112
    80001184:	4581                	li	a1,0
    80001186:	06048513          	addi	a0,s1,96
    8000118a:	fffff097          	auipc	ra,0xfffff
    8000118e:	ff0080e7          	jalr	-16(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    80001192:	00000797          	auipc	a5,0x0
    80001196:	dac78793          	addi	a5,a5,-596 # 80000f3e <forkret>
    8000119a:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    8000119c:	60bc                	ld	a5,64(s1)
    8000119e:	6705                	lui	a4,0x1
    800011a0:	97ba                	add	a5,a5,a4
    800011a2:	f4bc                	sd	a5,104(s1)
}
    800011a4:	8526                	mv	a0,s1
    800011a6:	60e2                	ld	ra,24(sp)
    800011a8:	6442                	ld	s0,16(sp)
    800011aa:	64a2                	ld	s1,8(sp)
    800011ac:	6902                	ld	s2,0(sp)
    800011ae:	6105                	addi	sp,sp,32
    800011b0:	8082                	ret
    freeproc(p);
    800011b2:	8526                	mv	a0,s1
    800011b4:	00000097          	auipc	ra,0x0
    800011b8:	f08080e7          	jalr	-248(ra) # 800010bc <freeproc>
    release(&p->lock);
    800011bc:	8526                	mv	a0,s1
    800011be:	00005097          	auipc	ra,0x5
    800011c2:	382080e7          	jalr	898(ra) # 80006540 <release>
    return 0;
    800011c6:	84ca                	mv	s1,s2
    800011c8:	bff1                	j	800011a4 <allocproc+0x90>
    freeproc(p);
    800011ca:	8526                	mv	a0,s1
    800011cc:	00000097          	auipc	ra,0x0
    800011d0:	ef0080e7          	jalr	-272(ra) # 800010bc <freeproc>
    release(&p->lock);
    800011d4:	8526                	mv	a0,s1
    800011d6:	00005097          	auipc	ra,0x5
    800011da:	36a080e7          	jalr	874(ra) # 80006540 <release>
    return 0;
    800011de:	84ca                	mv	s1,s2
    800011e0:	b7d1                	j	800011a4 <allocproc+0x90>

00000000800011e2 <userinit>:
{
    800011e2:	1101                	addi	sp,sp,-32
    800011e4:	ec06                	sd	ra,24(sp)
    800011e6:	e822                	sd	s0,16(sp)
    800011e8:	e426                	sd	s1,8(sp)
    800011ea:	1000                	addi	s0,sp,32
  p = allocproc();
    800011ec:	00000097          	auipc	ra,0x0
    800011f0:	f28080e7          	jalr	-216(ra) # 80001114 <allocproc>
    800011f4:	84aa                	mv	s1,a0
  initproc = p;
    800011f6:	0000a797          	auipc	a5,0xa
    800011fa:	02a7b523          	sd	a0,42(a5) # 8000b220 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800011fe:	03400613          	li	a2,52
    80001202:	0000a597          	auipc	a1,0xa
    80001206:	fae58593          	addi	a1,a1,-82 # 8000b1b0 <initcode>
    8000120a:	6928                	ld	a0,80(a0)
    8000120c:	fffff097          	auipc	ra,0xfffff
    80001210:	61e080e7          	jalr	1566(ra) # 8000082a <uvmfirst>
  p->sz = PGSIZE;
    80001214:	6785                	lui	a5,0x1
    80001216:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001218:	6cb8                	ld	a4,88(s1)
    8000121a:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000121e:	6cb8                	ld	a4,88(s1)
    80001220:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001222:	4641                	li	a2,16
    80001224:	00007597          	auipc	a1,0x7
    80001228:	f9c58593          	addi	a1,a1,-100 # 800081c0 <etext+0x1c0>
    8000122c:	15848513          	addi	a0,s1,344
    80001230:	fffff097          	auipc	ra,0xfffff
    80001234:	08c080e7          	jalr	140(ra) # 800002bc <safestrcpy>
  p->cwd = namei("/");
    80001238:	00007517          	auipc	a0,0x7
    8000123c:	f9850513          	addi	a0,a0,-104 # 800081d0 <etext+0x1d0>
    80001240:	00002097          	auipc	ra,0x2
    80001244:	2da080e7          	jalr	730(ra) # 8000351a <namei>
    80001248:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000124c:	478d                	li	a5,3
    8000124e:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001250:	8526                	mv	a0,s1
    80001252:	00005097          	auipc	ra,0x5
    80001256:	2ee080e7          	jalr	750(ra) # 80006540 <release>
}
    8000125a:	60e2                	ld	ra,24(sp)
    8000125c:	6442                	ld	s0,16(sp)
    8000125e:	64a2                	ld	s1,8(sp)
    80001260:	6105                	addi	sp,sp,32
    80001262:	8082                	ret

0000000080001264 <growproc>:
{
    80001264:	1101                	addi	sp,sp,-32
    80001266:	ec06                	sd	ra,24(sp)
    80001268:	e822                	sd	s0,16(sp)
    8000126a:	e426                	sd	s1,8(sp)
    8000126c:	e04a                	sd	s2,0(sp)
    8000126e:	1000                	addi	s0,sp,32
    80001270:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001272:	00000097          	auipc	ra,0x0
    80001276:	c94080e7          	jalr	-876(ra) # 80000f06 <myproc>
    8000127a:	84aa                	mv	s1,a0
  sz = p->sz;
    8000127c:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000127e:	01204c63          	bgtz	s2,80001296 <growproc+0x32>
  } else if(n < 0){
    80001282:	02094663          	bltz	s2,800012ae <growproc+0x4a>
  p->sz = sz;
    80001286:	e4ac                	sd	a1,72(s1)
  return 0;
    80001288:	4501                	li	a0,0
}
    8000128a:	60e2                	ld	ra,24(sp)
    8000128c:	6442                	ld	s0,16(sp)
    8000128e:	64a2                	ld	s1,8(sp)
    80001290:	6902                	ld	s2,0(sp)
    80001292:	6105                	addi	sp,sp,32
    80001294:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001296:	4691                	li	a3,4
    80001298:	00b90633          	add	a2,s2,a1
    8000129c:	6928                	ld	a0,80(a0)
    8000129e:	fffff097          	auipc	ra,0xfffff
    800012a2:	646080e7          	jalr	1606(ra) # 800008e4 <uvmalloc>
    800012a6:	85aa                	mv	a1,a0
    800012a8:	fd79                	bnez	a0,80001286 <growproc+0x22>
      return -1;
    800012aa:	557d                	li	a0,-1
    800012ac:	bff9                	j	8000128a <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800012ae:	00b90633          	add	a2,s2,a1
    800012b2:	6928                	ld	a0,80(a0)
    800012b4:	fffff097          	auipc	ra,0xfffff
    800012b8:	5e8080e7          	jalr	1512(ra) # 8000089c <uvmdealloc>
    800012bc:	85aa                	mv	a1,a0
    800012be:	b7e1                	j	80001286 <growproc+0x22>

00000000800012c0 <fork>:
{
    800012c0:	7139                	addi	sp,sp,-64
    800012c2:	fc06                	sd	ra,56(sp)
    800012c4:	f822                	sd	s0,48(sp)
    800012c6:	f04a                	sd	s2,32(sp)
    800012c8:	e456                	sd	s5,8(sp)
    800012ca:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800012cc:	00000097          	auipc	ra,0x0
    800012d0:	c3a080e7          	jalr	-966(ra) # 80000f06 <myproc>
    800012d4:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800012d6:	00000097          	auipc	ra,0x0
    800012da:	e3e080e7          	jalr	-450(ra) # 80001114 <allocproc>
    800012de:	12050063          	beqz	a0,800013fe <fork+0x13e>
    800012e2:	e852                	sd	s4,16(sp)
    800012e4:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800012e6:	048ab603          	ld	a2,72(s5)
    800012ea:	692c                	ld	a1,80(a0)
    800012ec:	050ab503          	ld	a0,80(s5)
    800012f0:	fffff097          	auipc	ra,0xfffff
    800012f4:	758080e7          	jalr	1880(ra) # 80000a48 <uvmcopy>
    800012f8:	04054a63          	bltz	a0,8000134c <fork+0x8c>
    800012fc:	f426                	sd	s1,40(sp)
    800012fe:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001300:	048ab783          	ld	a5,72(s5)
    80001304:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001308:	058ab683          	ld	a3,88(s5)
    8000130c:	87b6                	mv	a5,a3
    8000130e:	058a3703          	ld	a4,88(s4)
    80001312:	12068693          	addi	a3,a3,288
    80001316:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000131a:	6788                	ld	a0,8(a5)
    8000131c:	6b8c                	ld	a1,16(a5)
    8000131e:	6f90                	ld	a2,24(a5)
    80001320:	01073023          	sd	a6,0(a4)
    80001324:	e708                	sd	a0,8(a4)
    80001326:	eb0c                	sd	a1,16(a4)
    80001328:	ef10                	sd	a2,24(a4)
    8000132a:	02078793          	addi	a5,a5,32
    8000132e:	02070713          	addi	a4,a4,32
    80001332:	fed792e3          	bne	a5,a3,80001316 <fork+0x56>
  np->trapframe->a0 = 0;
    80001336:	058a3783          	ld	a5,88(s4)
    8000133a:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    8000133e:	0d0a8493          	addi	s1,s5,208
    80001342:	0d0a0913          	addi	s2,s4,208
    80001346:	150a8993          	addi	s3,s5,336
    8000134a:	a015                	j	8000136e <fork+0xae>
    freeproc(np);
    8000134c:	8552                	mv	a0,s4
    8000134e:	00000097          	auipc	ra,0x0
    80001352:	d6e080e7          	jalr	-658(ra) # 800010bc <freeproc>
    release(&np->lock);
    80001356:	8552                	mv	a0,s4
    80001358:	00005097          	auipc	ra,0x5
    8000135c:	1e8080e7          	jalr	488(ra) # 80006540 <release>
    return -1;
    80001360:	597d                	li	s2,-1
    80001362:	6a42                	ld	s4,16(sp)
    80001364:	a071                	j	800013f0 <fork+0x130>
  for(i = 0; i < NOFILE; i++)
    80001366:	04a1                	addi	s1,s1,8
    80001368:	0921                	addi	s2,s2,8
    8000136a:	01348b63          	beq	s1,s3,80001380 <fork+0xc0>
    if(p->ofile[i])
    8000136e:	6088                	ld	a0,0(s1)
    80001370:	d97d                	beqz	a0,80001366 <fork+0xa6>
      np->ofile[i] = filedup(p->ofile[i]);
    80001372:	00003097          	auipc	ra,0x3
    80001376:	820080e7          	jalr	-2016(ra) # 80003b92 <filedup>
    8000137a:	00a93023          	sd	a0,0(s2)
    8000137e:	b7e5                	j	80001366 <fork+0xa6>
  np->cwd = idup(p->cwd);
    80001380:	150ab503          	ld	a0,336(s5)
    80001384:	00002097          	auipc	ra,0x2
    80001388:	8de080e7          	jalr	-1826(ra) # 80002c62 <idup>
    8000138c:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001390:	4641                	li	a2,16
    80001392:	158a8593          	addi	a1,s5,344
    80001396:	158a0513          	addi	a0,s4,344
    8000139a:	fffff097          	auipc	ra,0xfffff
    8000139e:	f22080e7          	jalr	-222(ra) # 800002bc <safestrcpy>
  pid = np->pid;
    800013a2:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    800013a6:	8552                	mv	a0,s4
    800013a8:	00005097          	auipc	ra,0x5
    800013ac:	198080e7          	jalr	408(ra) # 80006540 <release>
  acquire(&wait_lock);
    800013b0:	0000a497          	auipc	s1,0xa
    800013b4:	ec848493          	addi	s1,s1,-312 # 8000b278 <wait_lock>
    800013b8:	8526                	mv	a0,s1
    800013ba:	00005097          	auipc	ra,0x5
    800013be:	0d2080e7          	jalr	210(ra) # 8000648c <acquire>
  np->parent = p;
    800013c2:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    800013c6:	8526                	mv	a0,s1
    800013c8:	00005097          	auipc	ra,0x5
    800013cc:	178080e7          	jalr	376(ra) # 80006540 <release>
  acquire(&np->lock);
    800013d0:	8552                	mv	a0,s4
    800013d2:	00005097          	auipc	ra,0x5
    800013d6:	0ba080e7          	jalr	186(ra) # 8000648c <acquire>
  np->state = RUNNABLE;
    800013da:	478d                	li	a5,3
    800013dc:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800013e0:	8552                	mv	a0,s4
    800013e2:	00005097          	auipc	ra,0x5
    800013e6:	15e080e7          	jalr	350(ra) # 80006540 <release>
  return pid;
    800013ea:	74a2                	ld	s1,40(sp)
    800013ec:	69e2                	ld	s3,24(sp)
    800013ee:	6a42                	ld	s4,16(sp)
}
    800013f0:	854a                	mv	a0,s2
    800013f2:	70e2                	ld	ra,56(sp)
    800013f4:	7442                	ld	s0,48(sp)
    800013f6:	7902                	ld	s2,32(sp)
    800013f8:	6aa2                	ld	s5,8(sp)
    800013fa:	6121                	addi	sp,sp,64
    800013fc:	8082                	ret
    return -1;
    800013fe:	597d                	li	s2,-1
    80001400:	bfc5                	j	800013f0 <fork+0x130>

0000000080001402 <scheduler>:
{
    80001402:	7139                	addi	sp,sp,-64
    80001404:	fc06                	sd	ra,56(sp)
    80001406:	f822                	sd	s0,48(sp)
    80001408:	f426                	sd	s1,40(sp)
    8000140a:	f04a                	sd	s2,32(sp)
    8000140c:	ec4e                	sd	s3,24(sp)
    8000140e:	e852                	sd	s4,16(sp)
    80001410:	e456                	sd	s5,8(sp)
    80001412:	e05a                	sd	s6,0(sp)
    80001414:	0080                	addi	s0,sp,64
    80001416:	8792                	mv	a5,tp
  int id = r_tp();
    80001418:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000141a:	00779a93          	slli	s5,a5,0x7
    8000141e:	0000a717          	auipc	a4,0xa
    80001422:	e4270713          	addi	a4,a4,-446 # 8000b260 <pid_lock>
    80001426:	9756                	add	a4,a4,s5
    80001428:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    8000142c:	0000a717          	auipc	a4,0xa
    80001430:	e6c70713          	addi	a4,a4,-404 # 8000b298 <cpus+0x8>
    80001434:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001436:	498d                	li	s3,3
        p->state = RUNNING;
    80001438:	4b11                	li	s6,4
        c->proc = p;
    8000143a:	079e                	slli	a5,a5,0x7
    8000143c:	0000aa17          	auipc	s4,0xa
    80001440:	e24a0a13          	addi	s4,s4,-476 # 8000b260 <pid_lock>
    80001444:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001446:	00010917          	auipc	s2,0x10
    8000144a:	c4a90913          	addi	s2,s2,-950 # 80011090 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000144e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001452:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001456:	10079073          	csrw	sstatus,a5
    8000145a:	0000a497          	auipc	s1,0xa
    8000145e:	23648493          	addi	s1,s1,566 # 8000b690 <proc>
    80001462:	a811                	j	80001476 <scheduler+0x74>
      release(&p->lock);
    80001464:	8526                	mv	a0,s1
    80001466:	00005097          	auipc	ra,0x5
    8000146a:	0da080e7          	jalr	218(ra) # 80006540 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8000146e:	16848493          	addi	s1,s1,360
    80001472:	fd248ee3          	beq	s1,s2,8000144e <scheduler+0x4c>
      acquire(&p->lock);
    80001476:	8526                	mv	a0,s1
    80001478:	00005097          	auipc	ra,0x5
    8000147c:	014080e7          	jalr	20(ra) # 8000648c <acquire>
      if(p->state == RUNNABLE) {
    80001480:	4c9c                	lw	a5,24(s1)
    80001482:	ff3791e3          	bne	a5,s3,80001464 <scheduler+0x62>
        p->state = RUNNING;
    80001486:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    8000148a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000148e:	06048593          	addi	a1,s1,96
    80001492:	8556                	mv	a0,s5
    80001494:	00000097          	auipc	ra,0x0
    80001498:	684080e7          	jalr	1668(ra) # 80001b18 <swtch>
        c->proc = 0;
    8000149c:	020a3823          	sd	zero,48(s4)
    800014a0:	b7d1                	j	80001464 <scheduler+0x62>

00000000800014a2 <sched>:
{
    800014a2:	7179                	addi	sp,sp,-48
    800014a4:	f406                	sd	ra,40(sp)
    800014a6:	f022                	sd	s0,32(sp)
    800014a8:	ec26                	sd	s1,24(sp)
    800014aa:	e84a                	sd	s2,16(sp)
    800014ac:	e44e                	sd	s3,8(sp)
    800014ae:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800014b0:	00000097          	auipc	ra,0x0
    800014b4:	a56080e7          	jalr	-1450(ra) # 80000f06 <myproc>
    800014b8:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800014ba:	00005097          	auipc	ra,0x5
    800014be:	f58080e7          	jalr	-168(ra) # 80006412 <holding>
    800014c2:	c93d                	beqz	a0,80001538 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014c4:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800014c6:	2781                	sext.w	a5,a5
    800014c8:	079e                	slli	a5,a5,0x7
    800014ca:	0000a717          	auipc	a4,0xa
    800014ce:	d9670713          	addi	a4,a4,-618 # 8000b260 <pid_lock>
    800014d2:	97ba                	add	a5,a5,a4
    800014d4:	0a87a703          	lw	a4,168(a5)
    800014d8:	4785                	li	a5,1
    800014da:	06f71763          	bne	a4,a5,80001548 <sched+0xa6>
  if(p->state == RUNNING)
    800014de:	4c98                	lw	a4,24(s1)
    800014e0:	4791                	li	a5,4
    800014e2:	06f70b63          	beq	a4,a5,80001558 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800014e6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800014ea:	8b89                	andi	a5,a5,2
  if(intr_get())
    800014ec:	efb5                	bnez	a5,80001568 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014ee:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800014f0:	0000a917          	auipc	s2,0xa
    800014f4:	d7090913          	addi	s2,s2,-656 # 8000b260 <pid_lock>
    800014f8:	2781                	sext.w	a5,a5
    800014fa:	079e                	slli	a5,a5,0x7
    800014fc:	97ca                	add	a5,a5,s2
    800014fe:	0ac7a983          	lw	s3,172(a5)
    80001502:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001504:	2781                	sext.w	a5,a5
    80001506:	079e                	slli	a5,a5,0x7
    80001508:	0000a597          	auipc	a1,0xa
    8000150c:	d9058593          	addi	a1,a1,-624 # 8000b298 <cpus+0x8>
    80001510:	95be                	add	a1,a1,a5
    80001512:	06048513          	addi	a0,s1,96
    80001516:	00000097          	auipc	ra,0x0
    8000151a:	602080e7          	jalr	1538(ra) # 80001b18 <swtch>
    8000151e:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001520:	2781                	sext.w	a5,a5
    80001522:	079e                	slli	a5,a5,0x7
    80001524:	993e                	add	s2,s2,a5
    80001526:	0b392623          	sw	s3,172(s2)
}
    8000152a:	70a2                	ld	ra,40(sp)
    8000152c:	7402                	ld	s0,32(sp)
    8000152e:	64e2                	ld	s1,24(sp)
    80001530:	6942                	ld	s2,16(sp)
    80001532:	69a2                	ld	s3,8(sp)
    80001534:	6145                	addi	sp,sp,48
    80001536:	8082                	ret
    panic("sched p->lock");
    80001538:	00007517          	auipc	a0,0x7
    8000153c:	ca050513          	addi	a0,a0,-864 # 800081d8 <etext+0x1d8>
    80001540:	00005097          	auipc	ra,0x5
    80001544:	9d2080e7          	jalr	-1582(ra) # 80005f12 <panic>
    panic("sched locks");
    80001548:	00007517          	auipc	a0,0x7
    8000154c:	ca050513          	addi	a0,a0,-864 # 800081e8 <etext+0x1e8>
    80001550:	00005097          	auipc	ra,0x5
    80001554:	9c2080e7          	jalr	-1598(ra) # 80005f12 <panic>
    panic("sched running");
    80001558:	00007517          	auipc	a0,0x7
    8000155c:	ca050513          	addi	a0,a0,-864 # 800081f8 <etext+0x1f8>
    80001560:	00005097          	auipc	ra,0x5
    80001564:	9b2080e7          	jalr	-1614(ra) # 80005f12 <panic>
    panic("sched interruptible");
    80001568:	00007517          	auipc	a0,0x7
    8000156c:	ca050513          	addi	a0,a0,-864 # 80008208 <etext+0x208>
    80001570:	00005097          	auipc	ra,0x5
    80001574:	9a2080e7          	jalr	-1630(ra) # 80005f12 <panic>

0000000080001578 <yield>:
{
    80001578:	1101                	addi	sp,sp,-32
    8000157a:	ec06                	sd	ra,24(sp)
    8000157c:	e822                	sd	s0,16(sp)
    8000157e:	e426                	sd	s1,8(sp)
    80001580:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001582:	00000097          	auipc	ra,0x0
    80001586:	984080e7          	jalr	-1660(ra) # 80000f06 <myproc>
    8000158a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000158c:	00005097          	auipc	ra,0x5
    80001590:	f00080e7          	jalr	-256(ra) # 8000648c <acquire>
  p->state = RUNNABLE;
    80001594:	478d                	li	a5,3
    80001596:	cc9c                	sw	a5,24(s1)
  sched();
    80001598:	00000097          	auipc	ra,0x0
    8000159c:	f0a080e7          	jalr	-246(ra) # 800014a2 <sched>
  release(&p->lock);
    800015a0:	8526                	mv	a0,s1
    800015a2:	00005097          	auipc	ra,0x5
    800015a6:	f9e080e7          	jalr	-98(ra) # 80006540 <release>
}
    800015aa:	60e2                	ld	ra,24(sp)
    800015ac:	6442                	ld	s0,16(sp)
    800015ae:	64a2                	ld	s1,8(sp)
    800015b0:	6105                	addi	sp,sp,32
    800015b2:	8082                	ret

00000000800015b4 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800015b4:	7179                	addi	sp,sp,-48
    800015b6:	f406                	sd	ra,40(sp)
    800015b8:	f022                	sd	s0,32(sp)
    800015ba:	ec26                	sd	s1,24(sp)
    800015bc:	e84a                	sd	s2,16(sp)
    800015be:	e44e                	sd	s3,8(sp)
    800015c0:	1800                	addi	s0,sp,48
    800015c2:	89aa                	mv	s3,a0
    800015c4:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800015c6:	00000097          	auipc	ra,0x0
    800015ca:	940080e7          	jalr	-1728(ra) # 80000f06 <myproc>
    800015ce:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800015d0:	00005097          	auipc	ra,0x5
    800015d4:	ebc080e7          	jalr	-324(ra) # 8000648c <acquire>
  release(lk);
    800015d8:	854a                	mv	a0,s2
    800015da:	00005097          	auipc	ra,0x5
    800015de:	f66080e7          	jalr	-154(ra) # 80006540 <release>

  // Go to sleep.
  p->chan = chan;
    800015e2:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800015e6:	4789                	li	a5,2
    800015e8:	cc9c                	sw	a5,24(s1)

  sched();
    800015ea:	00000097          	auipc	ra,0x0
    800015ee:	eb8080e7          	jalr	-328(ra) # 800014a2 <sched>

  // Tidy up.
  p->chan = 0;
    800015f2:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800015f6:	8526                	mv	a0,s1
    800015f8:	00005097          	auipc	ra,0x5
    800015fc:	f48080e7          	jalr	-184(ra) # 80006540 <release>
  acquire(lk);
    80001600:	854a                	mv	a0,s2
    80001602:	00005097          	auipc	ra,0x5
    80001606:	e8a080e7          	jalr	-374(ra) # 8000648c <acquire>
}
    8000160a:	70a2                	ld	ra,40(sp)
    8000160c:	7402                	ld	s0,32(sp)
    8000160e:	64e2                	ld	s1,24(sp)
    80001610:	6942                	ld	s2,16(sp)
    80001612:	69a2                	ld	s3,8(sp)
    80001614:	6145                	addi	sp,sp,48
    80001616:	8082                	ret

0000000080001618 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001618:	7139                	addi	sp,sp,-64
    8000161a:	fc06                	sd	ra,56(sp)
    8000161c:	f822                	sd	s0,48(sp)
    8000161e:	f426                	sd	s1,40(sp)
    80001620:	f04a                	sd	s2,32(sp)
    80001622:	ec4e                	sd	s3,24(sp)
    80001624:	e852                	sd	s4,16(sp)
    80001626:	e456                	sd	s5,8(sp)
    80001628:	0080                	addi	s0,sp,64
    8000162a:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000162c:	0000a497          	auipc	s1,0xa
    80001630:	06448493          	addi	s1,s1,100 # 8000b690 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001634:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001636:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001638:	00010917          	auipc	s2,0x10
    8000163c:	a5890913          	addi	s2,s2,-1448 # 80011090 <tickslock>
    80001640:	a811                	j	80001654 <wakeup+0x3c>
      }
      release(&p->lock);
    80001642:	8526                	mv	a0,s1
    80001644:	00005097          	auipc	ra,0x5
    80001648:	efc080e7          	jalr	-260(ra) # 80006540 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000164c:	16848493          	addi	s1,s1,360
    80001650:	03248663          	beq	s1,s2,8000167c <wakeup+0x64>
    if(p != myproc()){
    80001654:	00000097          	auipc	ra,0x0
    80001658:	8b2080e7          	jalr	-1870(ra) # 80000f06 <myproc>
    8000165c:	fea488e3          	beq	s1,a0,8000164c <wakeup+0x34>
      acquire(&p->lock);
    80001660:	8526                	mv	a0,s1
    80001662:	00005097          	auipc	ra,0x5
    80001666:	e2a080e7          	jalr	-470(ra) # 8000648c <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000166a:	4c9c                	lw	a5,24(s1)
    8000166c:	fd379be3          	bne	a5,s3,80001642 <wakeup+0x2a>
    80001670:	709c                	ld	a5,32(s1)
    80001672:	fd4798e3          	bne	a5,s4,80001642 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001676:	0154ac23          	sw	s5,24(s1)
    8000167a:	b7e1                	j	80001642 <wakeup+0x2a>
    }
  }
}
    8000167c:	70e2                	ld	ra,56(sp)
    8000167e:	7442                	ld	s0,48(sp)
    80001680:	74a2                	ld	s1,40(sp)
    80001682:	7902                	ld	s2,32(sp)
    80001684:	69e2                	ld	s3,24(sp)
    80001686:	6a42                	ld	s4,16(sp)
    80001688:	6aa2                	ld	s5,8(sp)
    8000168a:	6121                	addi	sp,sp,64
    8000168c:	8082                	ret

000000008000168e <reparent>:
{
    8000168e:	7179                	addi	sp,sp,-48
    80001690:	f406                	sd	ra,40(sp)
    80001692:	f022                	sd	s0,32(sp)
    80001694:	ec26                	sd	s1,24(sp)
    80001696:	e84a                	sd	s2,16(sp)
    80001698:	e44e                	sd	s3,8(sp)
    8000169a:	e052                	sd	s4,0(sp)
    8000169c:	1800                	addi	s0,sp,48
    8000169e:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800016a0:	0000a497          	auipc	s1,0xa
    800016a4:	ff048493          	addi	s1,s1,-16 # 8000b690 <proc>
      pp->parent = initproc;
    800016a8:	0000aa17          	auipc	s4,0xa
    800016ac:	b78a0a13          	addi	s4,s4,-1160 # 8000b220 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800016b0:	00010997          	auipc	s3,0x10
    800016b4:	9e098993          	addi	s3,s3,-1568 # 80011090 <tickslock>
    800016b8:	a029                	j	800016c2 <reparent+0x34>
    800016ba:	16848493          	addi	s1,s1,360
    800016be:	01348d63          	beq	s1,s3,800016d8 <reparent+0x4a>
    if(pp->parent == p){
    800016c2:	7c9c                	ld	a5,56(s1)
    800016c4:	ff279be3          	bne	a5,s2,800016ba <reparent+0x2c>
      pp->parent = initproc;
    800016c8:	000a3503          	ld	a0,0(s4)
    800016cc:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800016ce:	00000097          	auipc	ra,0x0
    800016d2:	f4a080e7          	jalr	-182(ra) # 80001618 <wakeup>
    800016d6:	b7d5                	j	800016ba <reparent+0x2c>
}
    800016d8:	70a2                	ld	ra,40(sp)
    800016da:	7402                	ld	s0,32(sp)
    800016dc:	64e2                	ld	s1,24(sp)
    800016de:	6942                	ld	s2,16(sp)
    800016e0:	69a2                	ld	s3,8(sp)
    800016e2:	6a02                	ld	s4,0(sp)
    800016e4:	6145                	addi	sp,sp,48
    800016e6:	8082                	ret

00000000800016e8 <exit>:
{
    800016e8:	7179                	addi	sp,sp,-48
    800016ea:	f406                	sd	ra,40(sp)
    800016ec:	f022                	sd	s0,32(sp)
    800016ee:	ec26                	sd	s1,24(sp)
    800016f0:	e84a                	sd	s2,16(sp)
    800016f2:	e44e                	sd	s3,8(sp)
    800016f4:	e052                	sd	s4,0(sp)
    800016f6:	1800                	addi	s0,sp,48
    800016f8:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800016fa:	00000097          	auipc	ra,0x0
    800016fe:	80c080e7          	jalr	-2036(ra) # 80000f06 <myproc>
    80001702:	89aa                	mv	s3,a0
  if(p == initproc)
    80001704:	0000a797          	auipc	a5,0xa
    80001708:	b1c7b783          	ld	a5,-1252(a5) # 8000b220 <initproc>
    8000170c:	0d050493          	addi	s1,a0,208
    80001710:	15050913          	addi	s2,a0,336
    80001714:	02a79363          	bne	a5,a0,8000173a <exit+0x52>
    panic("init exiting");
    80001718:	00007517          	auipc	a0,0x7
    8000171c:	b0850513          	addi	a0,a0,-1272 # 80008220 <etext+0x220>
    80001720:	00004097          	auipc	ra,0x4
    80001724:	7f2080e7          	jalr	2034(ra) # 80005f12 <panic>
      fileclose(f);
    80001728:	00002097          	auipc	ra,0x2
    8000172c:	4bc080e7          	jalr	1212(ra) # 80003be4 <fileclose>
      p->ofile[fd] = 0;
    80001730:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001734:	04a1                	addi	s1,s1,8
    80001736:	01248563          	beq	s1,s2,80001740 <exit+0x58>
    if(p->ofile[fd]){
    8000173a:	6088                	ld	a0,0(s1)
    8000173c:	f575                	bnez	a0,80001728 <exit+0x40>
    8000173e:	bfdd                	j	80001734 <exit+0x4c>
  begin_op();
    80001740:	00002097          	auipc	ra,0x2
    80001744:	fda080e7          	jalr	-38(ra) # 8000371a <begin_op>
  iput(p->cwd);
    80001748:	1509b503          	ld	a0,336(s3)
    8000174c:	00001097          	auipc	ra,0x1
    80001750:	7bc080e7          	jalr	1980(ra) # 80002f08 <iput>
  end_op();
    80001754:	00002097          	auipc	ra,0x2
    80001758:	040080e7          	jalr	64(ra) # 80003794 <end_op>
  p->cwd = 0;
    8000175c:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001760:	0000a497          	auipc	s1,0xa
    80001764:	b1848493          	addi	s1,s1,-1256 # 8000b278 <wait_lock>
    80001768:	8526                	mv	a0,s1
    8000176a:	00005097          	auipc	ra,0x5
    8000176e:	d22080e7          	jalr	-734(ra) # 8000648c <acquire>
  reparent(p);
    80001772:	854e                	mv	a0,s3
    80001774:	00000097          	auipc	ra,0x0
    80001778:	f1a080e7          	jalr	-230(ra) # 8000168e <reparent>
  wakeup(p->parent);
    8000177c:	0389b503          	ld	a0,56(s3)
    80001780:	00000097          	auipc	ra,0x0
    80001784:	e98080e7          	jalr	-360(ra) # 80001618 <wakeup>
  acquire(&p->lock);
    80001788:	854e                	mv	a0,s3
    8000178a:	00005097          	auipc	ra,0x5
    8000178e:	d02080e7          	jalr	-766(ra) # 8000648c <acquire>
  p->xstate = status;
    80001792:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001796:	4795                	li	a5,5
    80001798:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000179c:	8526                	mv	a0,s1
    8000179e:	00005097          	auipc	ra,0x5
    800017a2:	da2080e7          	jalr	-606(ra) # 80006540 <release>
  sched();
    800017a6:	00000097          	auipc	ra,0x0
    800017aa:	cfc080e7          	jalr	-772(ra) # 800014a2 <sched>
  panic("zombie exit");
    800017ae:	00007517          	auipc	a0,0x7
    800017b2:	a8250513          	addi	a0,a0,-1406 # 80008230 <etext+0x230>
    800017b6:	00004097          	auipc	ra,0x4
    800017ba:	75c080e7          	jalr	1884(ra) # 80005f12 <panic>

00000000800017be <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800017be:	7179                	addi	sp,sp,-48
    800017c0:	f406                	sd	ra,40(sp)
    800017c2:	f022                	sd	s0,32(sp)
    800017c4:	ec26                	sd	s1,24(sp)
    800017c6:	e84a                	sd	s2,16(sp)
    800017c8:	e44e                	sd	s3,8(sp)
    800017ca:	1800                	addi	s0,sp,48
    800017cc:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800017ce:	0000a497          	auipc	s1,0xa
    800017d2:	ec248493          	addi	s1,s1,-318 # 8000b690 <proc>
    800017d6:	00010997          	auipc	s3,0x10
    800017da:	8ba98993          	addi	s3,s3,-1862 # 80011090 <tickslock>
    acquire(&p->lock);
    800017de:	8526                	mv	a0,s1
    800017e0:	00005097          	auipc	ra,0x5
    800017e4:	cac080e7          	jalr	-852(ra) # 8000648c <acquire>
    if(p->pid == pid){
    800017e8:	589c                	lw	a5,48(s1)
    800017ea:	01278d63          	beq	a5,s2,80001804 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800017ee:	8526                	mv	a0,s1
    800017f0:	00005097          	auipc	ra,0x5
    800017f4:	d50080e7          	jalr	-688(ra) # 80006540 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800017f8:	16848493          	addi	s1,s1,360
    800017fc:	ff3491e3          	bne	s1,s3,800017de <kill+0x20>
  }
  return -1;
    80001800:	557d                	li	a0,-1
    80001802:	a829                	j	8000181c <kill+0x5e>
      p->killed = 1;
    80001804:	4785                	li	a5,1
    80001806:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001808:	4c98                	lw	a4,24(s1)
    8000180a:	4789                	li	a5,2
    8000180c:	00f70f63          	beq	a4,a5,8000182a <kill+0x6c>
      release(&p->lock);
    80001810:	8526                	mv	a0,s1
    80001812:	00005097          	auipc	ra,0x5
    80001816:	d2e080e7          	jalr	-722(ra) # 80006540 <release>
      return 0;
    8000181a:	4501                	li	a0,0
}
    8000181c:	70a2                	ld	ra,40(sp)
    8000181e:	7402                	ld	s0,32(sp)
    80001820:	64e2                	ld	s1,24(sp)
    80001822:	6942                	ld	s2,16(sp)
    80001824:	69a2                	ld	s3,8(sp)
    80001826:	6145                	addi	sp,sp,48
    80001828:	8082                	ret
        p->state = RUNNABLE;
    8000182a:	478d                	li	a5,3
    8000182c:	cc9c                	sw	a5,24(s1)
    8000182e:	b7cd                	j	80001810 <kill+0x52>

0000000080001830 <setkilled>:

void
setkilled(struct proc *p)
{
    80001830:	1101                	addi	sp,sp,-32
    80001832:	ec06                	sd	ra,24(sp)
    80001834:	e822                	sd	s0,16(sp)
    80001836:	e426                	sd	s1,8(sp)
    80001838:	1000                	addi	s0,sp,32
    8000183a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000183c:	00005097          	auipc	ra,0x5
    80001840:	c50080e7          	jalr	-944(ra) # 8000648c <acquire>
  p->killed = 1;
    80001844:	4785                	li	a5,1
    80001846:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001848:	8526                	mv	a0,s1
    8000184a:	00005097          	auipc	ra,0x5
    8000184e:	cf6080e7          	jalr	-778(ra) # 80006540 <release>
}
    80001852:	60e2                	ld	ra,24(sp)
    80001854:	6442                	ld	s0,16(sp)
    80001856:	64a2                	ld	s1,8(sp)
    80001858:	6105                	addi	sp,sp,32
    8000185a:	8082                	ret

000000008000185c <killed>:

int
killed(struct proc *p)
{
    8000185c:	1101                	addi	sp,sp,-32
    8000185e:	ec06                	sd	ra,24(sp)
    80001860:	e822                	sd	s0,16(sp)
    80001862:	e426                	sd	s1,8(sp)
    80001864:	e04a                	sd	s2,0(sp)
    80001866:	1000                	addi	s0,sp,32
    80001868:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    8000186a:	00005097          	auipc	ra,0x5
    8000186e:	c22080e7          	jalr	-990(ra) # 8000648c <acquire>
  k = p->killed;
    80001872:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001876:	8526                	mv	a0,s1
    80001878:	00005097          	auipc	ra,0x5
    8000187c:	cc8080e7          	jalr	-824(ra) # 80006540 <release>
  return k;
}
    80001880:	854a                	mv	a0,s2
    80001882:	60e2                	ld	ra,24(sp)
    80001884:	6442                	ld	s0,16(sp)
    80001886:	64a2                	ld	s1,8(sp)
    80001888:	6902                	ld	s2,0(sp)
    8000188a:	6105                	addi	sp,sp,32
    8000188c:	8082                	ret

000000008000188e <wait>:
{
    8000188e:	715d                	addi	sp,sp,-80
    80001890:	e486                	sd	ra,72(sp)
    80001892:	e0a2                	sd	s0,64(sp)
    80001894:	fc26                	sd	s1,56(sp)
    80001896:	f84a                	sd	s2,48(sp)
    80001898:	f44e                	sd	s3,40(sp)
    8000189a:	f052                	sd	s4,32(sp)
    8000189c:	ec56                	sd	s5,24(sp)
    8000189e:	e85a                	sd	s6,16(sp)
    800018a0:	e45e                	sd	s7,8(sp)
    800018a2:	e062                	sd	s8,0(sp)
    800018a4:	0880                	addi	s0,sp,80
    800018a6:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800018a8:	fffff097          	auipc	ra,0xfffff
    800018ac:	65e080e7          	jalr	1630(ra) # 80000f06 <myproc>
    800018b0:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800018b2:	0000a517          	auipc	a0,0xa
    800018b6:	9c650513          	addi	a0,a0,-1594 # 8000b278 <wait_lock>
    800018ba:	00005097          	auipc	ra,0x5
    800018be:	bd2080e7          	jalr	-1070(ra) # 8000648c <acquire>
    havekids = 0;
    800018c2:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    800018c4:	4a15                	li	s4,5
        havekids = 1;
    800018c6:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800018c8:	0000f997          	auipc	s3,0xf
    800018cc:	7c898993          	addi	s3,s3,1992 # 80011090 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800018d0:	0000ac17          	auipc	s8,0xa
    800018d4:	9a8c0c13          	addi	s8,s8,-1624 # 8000b278 <wait_lock>
    800018d8:	a0d1                	j	8000199c <wait+0x10e>
          pid = pp->pid;
    800018da:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800018de:	000b0e63          	beqz	s6,800018fa <wait+0x6c>
    800018e2:	4691                	li	a3,4
    800018e4:	02c48613          	addi	a2,s1,44
    800018e8:	85da                	mv	a1,s6
    800018ea:	05093503          	ld	a0,80(s2)
    800018ee:	fffff097          	auipc	ra,0xfffff
    800018f2:	25e080e7          	jalr	606(ra) # 80000b4c <copyout>
    800018f6:	04054163          	bltz	a0,80001938 <wait+0xaa>
          freeproc(pp);
    800018fa:	8526                	mv	a0,s1
    800018fc:	fffff097          	auipc	ra,0xfffff
    80001900:	7c0080e7          	jalr	1984(ra) # 800010bc <freeproc>
          release(&pp->lock);
    80001904:	8526                	mv	a0,s1
    80001906:	00005097          	auipc	ra,0x5
    8000190a:	c3a080e7          	jalr	-966(ra) # 80006540 <release>
          release(&wait_lock);
    8000190e:	0000a517          	auipc	a0,0xa
    80001912:	96a50513          	addi	a0,a0,-1686 # 8000b278 <wait_lock>
    80001916:	00005097          	auipc	ra,0x5
    8000191a:	c2a080e7          	jalr	-982(ra) # 80006540 <release>
}
    8000191e:	854e                	mv	a0,s3
    80001920:	60a6                	ld	ra,72(sp)
    80001922:	6406                	ld	s0,64(sp)
    80001924:	74e2                	ld	s1,56(sp)
    80001926:	7942                	ld	s2,48(sp)
    80001928:	79a2                	ld	s3,40(sp)
    8000192a:	7a02                	ld	s4,32(sp)
    8000192c:	6ae2                	ld	s5,24(sp)
    8000192e:	6b42                	ld	s6,16(sp)
    80001930:	6ba2                	ld	s7,8(sp)
    80001932:	6c02                	ld	s8,0(sp)
    80001934:	6161                	addi	sp,sp,80
    80001936:	8082                	ret
            release(&pp->lock);
    80001938:	8526                	mv	a0,s1
    8000193a:	00005097          	auipc	ra,0x5
    8000193e:	c06080e7          	jalr	-1018(ra) # 80006540 <release>
            release(&wait_lock);
    80001942:	0000a517          	auipc	a0,0xa
    80001946:	93650513          	addi	a0,a0,-1738 # 8000b278 <wait_lock>
    8000194a:	00005097          	auipc	ra,0x5
    8000194e:	bf6080e7          	jalr	-1034(ra) # 80006540 <release>
            return -1;
    80001952:	59fd                	li	s3,-1
    80001954:	b7e9                	j	8000191e <wait+0x90>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001956:	16848493          	addi	s1,s1,360
    8000195a:	03348463          	beq	s1,s3,80001982 <wait+0xf4>
      if(pp->parent == p){
    8000195e:	7c9c                	ld	a5,56(s1)
    80001960:	ff279be3          	bne	a5,s2,80001956 <wait+0xc8>
        acquire(&pp->lock);
    80001964:	8526                	mv	a0,s1
    80001966:	00005097          	auipc	ra,0x5
    8000196a:	b26080e7          	jalr	-1242(ra) # 8000648c <acquire>
        if(pp->state == ZOMBIE){
    8000196e:	4c9c                	lw	a5,24(s1)
    80001970:	f74785e3          	beq	a5,s4,800018da <wait+0x4c>
        release(&pp->lock);
    80001974:	8526                	mv	a0,s1
    80001976:	00005097          	auipc	ra,0x5
    8000197a:	bca080e7          	jalr	-1078(ra) # 80006540 <release>
        havekids = 1;
    8000197e:	8756                	mv	a4,s5
    80001980:	bfd9                	j	80001956 <wait+0xc8>
    if(!havekids || killed(p)){
    80001982:	c31d                	beqz	a4,800019a8 <wait+0x11a>
    80001984:	854a                	mv	a0,s2
    80001986:	00000097          	auipc	ra,0x0
    8000198a:	ed6080e7          	jalr	-298(ra) # 8000185c <killed>
    8000198e:	ed09                	bnez	a0,800019a8 <wait+0x11a>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001990:	85e2                	mv	a1,s8
    80001992:	854a                	mv	a0,s2
    80001994:	00000097          	auipc	ra,0x0
    80001998:	c20080e7          	jalr	-992(ra) # 800015b4 <sleep>
    havekids = 0;
    8000199c:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000199e:	0000a497          	auipc	s1,0xa
    800019a2:	cf248493          	addi	s1,s1,-782 # 8000b690 <proc>
    800019a6:	bf65                	j	8000195e <wait+0xd0>
      release(&wait_lock);
    800019a8:	0000a517          	auipc	a0,0xa
    800019ac:	8d050513          	addi	a0,a0,-1840 # 8000b278 <wait_lock>
    800019b0:	00005097          	auipc	ra,0x5
    800019b4:	b90080e7          	jalr	-1136(ra) # 80006540 <release>
      return -1;
    800019b8:	59fd                	li	s3,-1
    800019ba:	b795                	j	8000191e <wait+0x90>

00000000800019bc <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800019bc:	7179                	addi	sp,sp,-48
    800019be:	f406                	sd	ra,40(sp)
    800019c0:	f022                	sd	s0,32(sp)
    800019c2:	ec26                	sd	s1,24(sp)
    800019c4:	e84a                	sd	s2,16(sp)
    800019c6:	e44e                	sd	s3,8(sp)
    800019c8:	e052                	sd	s4,0(sp)
    800019ca:	1800                	addi	s0,sp,48
    800019cc:	84aa                	mv	s1,a0
    800019ce:	892e                	mv	s2,a1
    800019d0:	89b2                	mv	s3,a2
    800019d2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019d4:	fffff097          	auipc	ra,0xfffff
    800019d8:	532080e7          	jalr	1330(ra) # 80000f06 <myproc>
  if(user_dst){
    800019dc:	c08d                	beqz	s1,800019fe <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800019de:	86d2                	mv	a3,s4
    800019e0:	864e                	mv	a2,s3
    800019e2:	85ca                	mv	a1,s2
    800019e4:	6928                	ld	a0,80(a0)
    800019e6:	fffff097          	auipc	ra,0xfffff
    800019ea:	166080e7          	jalr	358(ra) # 80000b4c <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800019ee:	70a2                	ld	ra,40(sp)
    800019f0:	7402                	ld	s0,32(sp)
    800019f2:	64e2                	ld	s1,24(sp)
    800019f4:	6942                	ld	s2,16(sp)
    800019f6:	69a2                	ld	s3,8(sp)
    800019f8:	6a02                	ld	s4,0(sp)
    800019fa:	6145                	addi	sp,sp,48
    800019fc:	8082                	ret
    memmove((char *)dst, src, len);
    800019fe:	000a061b          	sext.w	a2,s4
    80001a02:	85ce                	mv	a1,s3
    80001a04:	854a                	mv	a0,s2
    80001a06:	ffffe097          	auipc	ra,0xffffe
    80001a0a:	7d0080e7          	jalr	2000(ra) # 800001d6 <memmove>
    return 0;
    80001a0e:	8526                	mv	a0,s1
    80001a10:	bff9                	j	800019ee <either_copyout+0x32>

0000000080001a12 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001a12:	7179                	addi	sp,sp,-48
    80001a14:	f406                	sd	ra,40(sp)
    80001a16:	f022                	sd	s0,32(sp)
    80001a18:	ec26                	sd	s1,24(sp)
    80001a1a:	e84a                	sd	s2,16(sp)
    80001a1c:	e44e                	sd	s3,8(sp)
    80001a1e:	e052                	sd	s4,0(sp)
    80001a20:	1800                	addi	s0,sp,48
    80001a22:	892a                	mv	s2,a0
    80001a24:	84ae                	mv	s1,a1
    80001a26:	89b2                	mv	s3,a2
    80001a28:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001a2a:	fffff097          	auipc	ra,0xfffff
    80001a2e:	4dc080e7          	jalr	1244(ra) # 80000f06 <myproc>
  if(user_src){
    80001a32:	c08d                	beqz	s1,80001a54 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001a34:	86d2                	mv	a3,s4
    80001a36:	864e                	mv	a2,s3
    80001a38:	85ca                	mv	a1,s2
    80001a3a:	6928                	ld	a0,80(a0)
    80001a3c:	fffff097          	auipc	ra,0xfffff
    80001a40:	1ee080e7          	jalr	494(ra) # 80000c2a <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001a44:	70a2                	ld	ra,40(sp)
    80001a46:	7402                	ld	s0,32(sp)
    80001a48:	64e2                	ld	s1,24(sp)
    80001a4a:	6942                	ld	s2,16(sp)
    80001a4c:	69a2                	ld	s3,8(sp)
    80001a4e:	6a02                	ld	s4,0(sp)
    80001a50:	6145                	addi	sp,sp,48
    80001a52:	8082                	ret
    memmove(dst, (char*)src, len);
    80001a54:	000a061b          	sext.w	a2,s4
    80001a58:	85ce                	mv	a1,s3
    80001a5a:	854a                	mv	a0,s2
    80001a5c:	ffffe097          	auipc	ra,0xffffe
    80001a60:	77a080e7          	jalr	1914(ra) # 800001d6 <memmove>
    return 0;
    80001a64:	8526                	mv	a0,s1
    80001a66:	bff9                	j	80001a44 <either_copyin+0x32>

0000000080001a68 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a68:	715d                	addi	sp,sp,-80
    80001a6a:	e486                	sd	ra,72(sp)
    80001a6c:	e0a2                	sd	s0,64(sp)
    80001a6e:	fc26                	sd	s1,56(sp)
    80001a70:	f84a                	sd	s2,48(sp)
    80001a72:	f44e                	sd	s3,40(sp)
    80001a74:	f052                	sd	s4,32(sp)
    80001a76:	ec56                	sd	s5,24(sp)
    80001a78:	e85a                	sd	s6,16(sp)
    80001a7a:	e45e                	sd	s7,8(sp)
    80001a7c:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a7e:	00006517          	auipc	a0,0x6
    80001a82:	59a50513          	addi	a0,a0,1434 # 80008018 <etext+0x18>
    80001a86:	00004097          	auipc	ra,0x4
    80001a8a:	4d6080e7          	jalr	1238(ra) # 80005f5c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a8e:	0000a497          	auipc	s1,0xa
    80001a92:	d5a48493          	addi	s1,s1,-678 # 8000b7e8 <proc+0x158>
    80001a96:	0000f917          	auipc	s2,0xf
    80001a9a:	75290913          	addi	s2,s2,1874 # 800111e8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a9e:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001aa0:	00006997          	auipc	s3,0x6
    80001aa4:	7a098993          	addi	s3,s3,1952 # 80008240 <etext+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    80001aa8:	00006a97          	auipc	s5,0x6
    80001aac:	7a0a8a93          	addi	s5,s5,1952 # 80008248 <etext+0x248>
    printf("\n");
    80001ab0:	00006a17          	auipc	s4,0x6
    80001ab4:	568a0a13          	addi	s4,s4,1384 # 80008018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ab8:	00007b97          	auipc	s7,0x7
    80001abc:	cb8b8b93          	addi	s7,s7,-840 # 80008770 <states.0>
    80001ac0:	a00d                	j	80001ae2 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001ac2:	ed86a583          	lw	a1,-296(a3)
    80001ac6:	8556                	mv	a0,s5
    80001ac8:	00004097          	auipc	ra,0x4
    80001acc:	494080e7          	jalr	1172(ra) # 80005f5c <printf>
    printf("\n");
    80001ad0:	8552                	mv	a0,s4
    80001ad2:	00004097          	auipc	ra,0x4
    80001ad6:	48a080e7          	jalr	1162(ra) # 80005f5c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001ada:	16848493          	addi	s1,s1,360
    80001ade:	03248263          	beq	s1,s2,80001b02 <procdump+0x9a>
    if(p->state == UNUSED)
    80001ae2:	86a6                	mv	a3,s1
    80001ae4:	ec04a783          	lw	a5,-320(s1)
    80001ae8:	dbed                	beqz	a5,80001ada <procdump+0x72>
      state = "???";
    80001aea:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001aec:	fcfb6be3          	bltu	s6,a5,80001ac2 <procdump+0x5a>
    80001af0:	02079713          	slli	a4,a5,0x20
    80001af4:	01d75793          	srli	a5,a4,0x1d
    80001af8:	97de                	add	a5,a5,s7
    80001afa:	6390                	ld	a2,0(a5)
    80001afc:	f279                	bnez	a2,80001ac2 <procdump+0x5a>
      state = "???";
    80001afe:	864e                	mv	a2,s3
    80001b00:	b7c9                	j	80001ac2 <procdump+0x5a>
  }
}
    80001b02:	60a6                	ld	ra,72(sp)
    80001b04:	6406                	ld	s0,64(sp)
    80001b06:	74e2                	ld	s1,56(sp)
    80001b08:	7942                	ld	s2,48(sp)
    80001b0a:	79a2                	ld	s3,40(sp)
    80001b0c:	7a02                	ld	s4,32(sp)
    80001b0e:	6ae2                	ld	s5,24(sp)
    80001b10:	6b42                	ld	s6,16(sp)
    80001b12:	6ba2                	ld	s7,8(sp)
    80001b14:	6161                	addi	sp,sp,80
    80001b16:	8082                	ret

0000000080001b18 <swtch>:
    80001b18:	00153023          	sd	ra,0(a0)
    80001b1c:	00253423          	sd	sp,8(a0)
    80001b20:	e900                	sd	s0,16(a0)
    80001b22:	ed04                	sd	s1,24(a0)
    80001b24:	03253023          	sd	s2,32(a0)
    80001b28:	03353423          	sd	s3,40(a0)
    80001b2c:	03453823          	sd	s4,48(a0)
    80001b30:	03553c23          	sd	s5,56(a0)
    80001b34:	05653023          	sd	s6,64(a0)
    80001b38:	05753423          	sd	s7,72(a0)
    80001b3c:	05853823          	sd	s8,80(a0)
    80001b40:	05953c23          	sd	s9,88(a0)
    80001b44:	07a53023          	sd	s10,96(a0)
    80001b48:	07b53423          	sd	s11,104(a0)
    80001b4c:	0005b083          	ld	ra,0(a1)
    80001b50:	0085b103          	ld	sp,8(a1)
    80001b54:	6980                	ld	s0,16(a1)
    80001b56:	6d84                	ld	s1,24(a1)
    80001b58:	0205b903          	ld	s2,32(a1)
    80001b5c:	0285b983          	ld	s3,40(a1)
    80001b60:	0305ba03          	ld	s4,48(a1)
    80001b64:	0385ba83          	ld	s5,56(a1)
    80001b68:	0405bb03          	ld	s6,64(a1)
    80001b6c:	0485bb83          	ld	s7,72(a1)
    80001b70:	0505bc03          	ld	s8,80(a1)
    80001b74:	0585bc83          	ld	s9,88(a1)
    80001b78:	0605bd03          	ld	s10,96(a1)
    80001b7c:	0685bd83          	ld	s11,104(a1)
    80001b80:	8082                	ret

0000000080001b82 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001b82:	1141                	addi	sp,sp,-16
    80001b84:	e406                	sd	ra,8(sp)
    80001b86:	e022                	sd	s0,0(sp)
    80001b88:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001b8a:	00006597          	auipc	a1,0x6
    80001b8e:	6fe58593          	addi	a1,a1,1790 # 80008288 <etext+0x288>
    80001b92:	0000f517          	auipc	a0,0xf
    80001b96:	4fe50513          	addi	a0,a0,1278 # 80011090 <tickslock>
    80001b9a:	00005097          	auipc	ra,0x5
    80001b9e:	862080e7          	jalr	-1950(ra) # 800063fc <initlock>
}
    80001ba2:	60a2                	ld	ra,8(sp)
    80001ba4:	6402                	ld	s0,0(sp)
    80001ba6:	0141                	addi	sp,sp,16
    80001ba8:	8082                	ret

0000000080001baa <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001baa:	1141                	addi	sp,sp,-16
    80001bac:	e422                	sd	s0,8(sp)
    80001bae:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bb0:	00003797          	auipc	a5,0x3
    80001bb4:	73078793          	addi	a5,a5,1840 # 800052e0 <kernelvec>
    80001bb8:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001bbc:	6422                	ld	s0,8(sp)
    80001bbe:	0141                	addi	sp,sp,16
    80001bc0:	8082                	ret

0000000080001bc2 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001bc2:	1141                	addi	sp,sp,-16
    80001bc4:	e406                	sd	ra,8(sp)
    80001bc6:	e022                	sd	s0,0(sp)
    80001bc8:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001bca:	fffff097          	auipc	ra,0xfffff
    80001bce:	33c080e7          	jalr	828(ra) # 80000f06 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001bd2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001bd6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bd8:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001bdc:	00005697          	auipc	a3,0x5
    80001be0:	42468693          	addi	a3,a3,1060 # 80007000 <_trampoline>
    80001be4:	00005717          	auipc	a4,0x5
    80001be8:	41c70713          	addi	a4,a4,1052 # 80007000 <_trampoline>
    80001bec:	8f15                	sub	a4,a4,a3
    80001bee:	040007b7          	lui	a5,0x4000
    80001bf2:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001bf4:	07b2                	slli	a5,a5,0xc
    80001bf6:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bf8:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001bfc:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001bfe:	18002673          	csrr	a2,satp
    80001c02:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001c04:	6d30                	ld	a2,88(a0)
    80001c06:	6138                	ld	a4,64(a0)
    80001c08:	6585                	lui	a1,0x1
    80001c0a:	972e                	add	a4,a4,a1
    80001c0c:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001c0e:	6d38                	ld	a4,88(a0)
    80001c10:	00000617          	auipc	a2,0x0
    80001c14:	13860613          	addi	a2,a2,312 # 80001d48 <usertrap>
    80001c18:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001c1a:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001c1c:	8612                	mv	a2,tp
    80001c1e:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c20:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001c24:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001c28:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c2c:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001c30:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001c32:	6f18                	ld	a4,24(a4)
    80001c34:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001c38:	6928                	ld	a0,80(a0)
    80001c3a:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001c3c:	00005717          	auipc	a4,0x5
    80001c40:	46070713          	addi	a4,a4,1120 # 8000709c <userret>
    80001c44:	8f15                	sub	a4,a4,a3
    80001c46:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001c48:	577d                	li	a4,-1
    80001c4a:	177e                	slli	a4,a4,0x3f
    80001c4c:	8d59                	or	a0,a0,a4
    80001c4e:	9782                	jalr	a5
}
    80001c50:	60a2                	ld	ra,8(sp)
    80001c52:	6402                	ld	s0,0(sp)
    80001c54:	0141                	addi	sp,sp,16
    80001c56:	8082                	ret

0000000080001c58 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001c58:	1101                	addi	sp,sp,-32
    80001c5a:	ec06                	sd	ra,24(sp)
    80001c5c:	e822                	sd	s0,16(sp)
    80001c5e:	e426                	sd	s1,8(sp)
    80001c60:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001c62:	0000f497          	auipc	s1,0xf
    80001c66:	42e48493          	addi	s1,s1,1070 # 80011090 <tickslock>
    80001c6a:	8526                	mv	a0,s1
    80001c6c:	00005097          	auipc	ra,0x5
    80001c70:	820080e7          	jalr	-2016(ra) # 8000648c <acquire>
  ticks++;
    80001c74:	00009517          	auipc	a0,0x9
    80001c78:	5b450513          	addi	a0,a0,1460 # 8000b228 <ticks>
    80001c7c:	411c                	lw	a5,0(a0)
    80001c7e:	2785                	addiw	a5,a5,1
    80001c80:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001c82:	00000097          	auipc	ra,0x0
    80001c86:	996080e7          	jalr	-1642(ra) # 80001618 <wakeup>
  release(&tickslock);
    80001c8a:	8526                	mv	a0,s1
    80001c8c:	00005097          	auipc	ra,0x5
    80001c90:	8b4080e7          	jalr	-1868(ra) # 80006540 <release>
}
    80001c94:	60e2                	ld	ra,24(sp)
    80001c96:	6442                	ld	s0,16(sp)
    80001c98:	64a2                	ld	s1,8(sp)
    80001c9a:	6105                	addi	sp,sp,32
    80001c9c:	8082                	ret

0000000080001c9e <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c9e:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001ca2:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001ca4:	0a07d163          	bgez	a5,80001d46 <devintr+0xa8>
{
    80001ca8:	1101                	addi	sp,sp,-32
    80001caa:	ec06                	sd	ra,24(sp)
    80001cac:	e822                	sd	s0,16(sp)
    80001cae:	1000                	addi	s0,sp,32
     (scause & 0xff) == 9){
    80001cb0:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001cb4:	46a5                	li	a3,9
    80001cb6:	00d70c63          	beq	a4,a3,80001cce <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    80001cba:	577d                	li	a4,-1
    80001cbc:	177e                	slli	a4,a4,0x3f
    80001cbe:	0705                	addi	a4,a4,1
    return 0;
    80001cc0:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001cc2:	06e78163          	beq	a5,a4,80001d24 <devintr+0x86>
  }
}
    80001cc6:	60e2                	ld	ra,24(sp)
    80001cc8:	6442                	ld	s0,16(sp)
    80001cca:	6105                	addi	sp,sp,32
    80001ccc:	8082                	ret
    80001cce:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001cd0:	00003097          	auipc	ra,0x3
    80001cd4:	71c080e7          	jalr	1820(ra) # 800053ec <plic_claim>
    80001cd8:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001cda:	47a9                	li	a5,10
    80001cdc:	00f50963          	beq	a0,a5,80001cee <devintr+0x50>
    } else if(irq == VIRTIO0_IRQ){
    80001ce0:	4785                	li	a5,1
    80001ce2:	00f50b63          	beq	a0,a5,80001cf8 <devintr+0x5a>
    return 1;
    80001ce6:	4505                	li	a0,1
    } else if(irq){
    80001ce8:	ec89                	bnez	s1,80001d02 <devintr+0x64>
    80001cea:	64a2                	ld	s1,8(sp)
    80001cec:	bfe9                	j	80001cc6 <devintr+0x28>
      uartintr();
    80001cee:	00004097          	auipc	ra,0x4
    80001cf2:	6be080e7          	jalr	1726(ra) # 800063ac <uartintr>
    if(irq)
    80001cf6:	a839                	j	80001d14 <devintr+0x76>
      virtio_disk_intr();
    80001cf8:	00004097          	auipc	ra,0x4
    80001cfc:	c1e080e7          	jalr	-994(ra) # 80005916 <virtio_disk_intr>
    if(irq)
    80001d00:	a811                	j	80001d14 <devintr+0x76>
      printf("unexpected interrupt irq=%d\n", irq);
    80001d02:	85a6                	mv	a1,s1
    80001d04:	00006517          	auipc	a0,0x6
    80001d08:	58c50513          	addi	a0,a0,1420 # 80008290 <etext+0x290>
    80001d0c:	00004097          	auipc	ra,0x4
    80001d10:	250080e7          	jalr	592(ra) # 80005f5c <printf>
      plic_complete(irq);
    80001d14:	8526                	mv	a0,s1
    80001d16:	00003097          	auipc	ra,0x3
    80001d1a:	6fa080e7          	jalr	1786(ra) # 80005410 <plic_complete>
    return 1;
    80001d1e:	4505                	li	a0,1
    80001d20:	64a2                	ld	s1,8(sp)
    80001d22:	b755                	j	80001cc6 <devintr+0x28>
    if(cpuid() == 0){
    80001d24:	fffff097          	auipc	ra,0xfffff
    80001d28:	1b6080e7          	jalr	438(ra) # 80000eda <cpuid>
    80001d2c:	c901                	beqz	a0,80001d3c <devintr+0x9e>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001d2e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001d32:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001d34:	14479073          	csrw	sip,a5
    return 2;
    80001d38:	4509                	li	a0,2
    80001d3a:	b771                	j	80001cc6 <devintr+0x28>
      clockintr();
    80001d3c:	00000097          	auipc	ra,0x0
    80001d40:	f1c080e7          	jalr	-228(ra) # 80001c58 <clockintr>
    80001d44:	b7ed                	j	80001d2e <devintr+0x90>
}
    80001d46:	8082                	ret

0000000080001d48 <usertrap>:
{
    80001d48:	1101                	addi	sp,sp,-32
    80001d4a:	ec06                	sd	ra,24(sp)
    80001d4c:	e822                	sd	s0,16(sp)
    80001d4e:	e426                	sd	s1,8(sp)
    80001d50:	e04a                	sd	s2,0(sp)
    80001d52:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d54:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001d58:	1007f793          	andi	a5,a5,256
    80001d5c:	e3b1                	bnez	a5,80001da0 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d5e:	00003797          	auipc	a5,0x3
    80001d62:	58278793          	addi	a5,a5,1410 # 800052e0 <kernelvec>
    80001d66:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001d6a:	fffff097          	auipc	ra,0xfffff
    80001d6e:	19c080e7          	jalr	412(ra) # 80000f06 <myproc>
    80001d72:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001d74:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d76:	14102773          	csrr	a4,sepc
    80001d7a:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d7c:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001d80:	47a1                	li	a5,8
    80001d82:	02f70763          	beq	a4,a5,80001db0 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001d86:	00000097          	auipc	ra,0x0
    80001d8a:	f18080e7          	jalr	-232(ra) # 80001c9e <devintr>
    80001d8e:	892a                	mv	s2,a0
    80001d90:	c151                	beqz	a0,80001e14 <usertrap+0xcc>
  if(killed(p))
    80001d92:	8526                	mv	a0,s1
    80001d94:	00000097          	auipc	ra,0x0
    80001d98:	ac8080e7          	jalr	-1336(ra) # 8000185c <killed>
    80001d9c:	c929                	beqz	a0,80001dee <usertrap+0xa6>
    80001d9e:	a099                	j	80001de4 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001da0:	00006517          	auipc	a0,0x6
    80001da4:	51050513          	addi	a0,a0,1296 # 800082b0 <etext+0x2b0>
    80001da8:	00004097          	auipc	ra,0x4
    80001dac:	16a080e7          	jalr	362(ra) # 80005f12 <panic>
    if(killed(p))
    80001db0:	00000097          	auipc	ra,0x0
    80001db4:	aac080e7          	jalr	-1364(ra) # 8000185c <killed>
    80001db8:	e921                	bnez	a0,80001e08 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001dba:	6cb8                	ld	a4,88(s1)
    80001dbc:	6f1c                	ld	a5,24(a4)
    80001dbe:	0791                	addi	a5,a5,4
    80001dc0:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dc2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001dc6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dca:	10079073          	csrw	sstatus,a5
    syscall();
    80001dce:	00000097          	auipc	ra,0x0
    80001dd2:	2d4080e7          	jalr	724(ra) # 800020a2 <syscall>
  if(killed(p))
    80001dd6:	8526                	mv	a0,s1
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	a84080e7          	jalr	-1404(ra) # 8000185c <killed>
    80001de0:	c911                	beqz	a0,80001df4 <usertrap+0xac>
    80001de2:	4901                	li	s2,0
    exit(-1);
    80001de4:	557d                	li	a0,-1
    80001de6:	00000097          	auipc	ra,0x0
    80001dea:	902080e7          	jalr	-1790(ra) # 800016e8 <exit>
  if(which_dev == 2)
    80001dee:	4789                	li	a5,2
    80001df0:	04f90f63          	beq	s2,a5,80001e4e <usertrap+0x106>
  usertrapret();
    80001df4:	00000097          	auipc	ra,0x0
    80001df8:	dce080e7          	jalr	-562(ra) # 80001bc2 <usertrapret>
}
    80001dfc:	60e2                	ld	ra,24(sp)
    80001dfe:	6442                	ld	s0,16(sp)
    80001e00:	64a2                	ld	s1,8(sp)
    80001e02:	6902                	ld	s2,0(sp)
    80001e04:	6105                	addi	sp,sp,32
    80001e06:	8082                	ret
      exit(-1);
    80001e08:	557d                	li	a0,-1
    80001e0a:	00000097          	auipc	ra,0x0
    80001e0e:	8de080e7          	jalr	-1826(ra) # 800016e8 <exit>
    80001e12:	b765                	j	80001dba <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e14:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001e18:	5890                	lw	a2,48(s1)
    80001e1a:	00006517          	auipc	a0,0x6
    80001e1e:	4b650513          	addi	a0,a0,1206 # 800082d0 <etext+0x2d0>
    80001e22:	00004097          	auipc	ra,0x4
    80001e26:	13a080e7          	jalr	314(ra) # 80005f5c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e2a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e2e:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e32:	00006517          	auipc	a0,0x6
    80001e36:	4ce50513          	addi	a0,a0,1230 # 80008300 <etext+0x300>
    80001e3a:	00004097          	auipc	ra,0x4
    80001e3e:	122080e7          	jalr	290(ra) # 80005f5c <printf>
    setkilled(p);
    80001e42:	8526                	mv	a0,s1
    80001e44:	00000097          	auipc	ra,0x0
    80001e48:	9ec080e7          	jalr	-1556(ra) # 80001830 <setkilled>
    80001e4c:	b769                	j	80001dd6 <usertrap+0x8e>
    yield();
    80001e4e:	fffff097          	auipc	ra,0xfffff
    80001e52:	72a080e7          	jalr	1834(ra) # 80001578 <yield>
    80001e56:	bf79                	j	80001df4 <usertrap+0xac>

0000000080001e58 <kerneltrap>:
{
    80001e58:	7179                	addi	sp,sp,-48
    80001e5a:	f406                	sd	ra,40(sp)
    80001e5c:	f022                	sd	s0,32(sp)
    80001e5e:	ec26                	sd	s1,24(sp)
    80001e60:	e84a                	sd	s2,16(sp)
    80001e62:	e44e                	sd	s3,8(sp)
    80001e64:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e66:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e6a:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e6e:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001e72:	1004f793          	andi	a5,s1,256
    80001e76:	cb85                	beqz	a5,80001ea6 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e78:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e7c:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001e7e:	ef85                	bnez	a5,80001eb6 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001e80:	00000097          	auipc	ra,0x0
    80001e84:	e1e080e7          	jalr	-482(ra) # 80001c9e <devintr>
    80001e88:	cd1d                	beqz	a0,80001ec6 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e8a:	4789                	li	a5,2
    80001e8c:	06f50a63          	beq	a0,a5,80001f00 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e90:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e94:	10049073          	csrw	sstatus,s1
}
    80001e98:	70a2                	ld	ra,40(sp)
    80001e9a:	7402                	ld	s0,32(sp)
    80001e9c:	64e2                	ld	s1,24(sp)
    80001e9e:	6942                	ld	s2,16(sp)
    80001ea0:	69a2                	ld	s3,8(sp)
    80001ea2:	6145                	addi	sp,sp,48
    80001ea4:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001ea6:	00006517          	auipc	a0,0x6
    80001eaa:	47a50513          	addi	a0,a0,1146 # 80008320 <etext+0x320>
    80001eae:	00004097          	auipc	ra,0x4
    80001eb2:	064080e7          	jalr	100(ra) # 80005f12 <panic>
    panic("kerneltrap: interrupts enabled");
    80001eb6:	00006517          	auipc	a0,0x6
    80001eba:	49250513          	addi	a0,a0,1170 # 80008348 <etext+0x348>
    80001ebe:	00004097          	auipc	ra,0x4
    80001ec2:	054080e7          	jalr	84(ra) # 80005f12 <panic>
    printf("scause %p\n", scause);
    80001ec6:	85ce                	mv	a1,s3
    80001ec8:	00006517          	auipc	a0,0x6
    80001ecc:	4a050513          	addi	a0,a0,1184 # 80008368 <etext+0x368>
    80001ed0:	00004097          	auipc	ra,0x4
    80001ed4:	08c080e7          	jalr	140(ra) # 80005f5c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ed8:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001edc:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001ee0:	00006517          	auipc	a0,0x6
    80001ee4:	49850513          	addi	a0,a0,1176 # 80008378 <etext+0x378>
    80001ee8:	00004097          	auipc	ra,0x4
    80001eec:	074080e7          	jalr	116(ra) # 80005f5c <printf>
    panic("kerneltrap");
    80001ef0:	00006517          	auipc	a0,0x6
    80001ef4:	4a050513          	addi	a0,a0,1184 # 80008390 <etext+0x390>
    80001ef8:	00004097          	auipc	ra,0x4
    80001efc:	01a080e7          	jalr	26(ra) # 80005f12 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f00:	fffff097          	auipc	ra,0xfffff
    80001f04:	006080e7          	jalr	6(ra) # 80000f06 <myproc>
    80001f08:	d541                	beqz	a0,80001e90 <kerneltrap+0x38>
    80001f0a:	fffff097          	auipc	ra,0xfffff
    80001f0e:	ffc080e7          	jalr	-4(ra) # 80000f06 <myproc>
    80001f12:	4d18                	lw	a4,24(a0)
    80001f14:	4791                	li	a5,4
    80001f16:	f6f71de3          	bne	a4,a5,80001e90 <kerneltrap+0x38>
    yield();
    80001f1a:	fffff097          	auipc	ra,0xfffff
    80001f1e:	65e080e7          	jalr	1630(ra) # 80001578 <yield>
    80001f22:	b7bd                	j	80001e90 <kerneltrap+0x38>

0000000080001f24 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001f24:	1101                	addi	sp,sp,-32
    80001f26:	ec06                	sd	ra,24(sp)
    80001f28:	e822                	sd	s0,16(sp)
    80001f2a:	e426                	sd	s1,8(sp)
    80001f2c:	1000                	addi	s0,sp,32
    80001f2e:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	fd6080e7          	jalr	-42(ra) # 80000f06 <myproc>
  switch (n) {
    80001f38:	4795                	li	a5,5
    80001f3a:	0497e163          	bltu	a5,s1,80001f7c <argraw+0x58>
    80001f3e:	048a                	slli	s1,s1,0x2
    80001f40:	00007717          	auipc	a4,0x7
    80001f44:	86070713          	addi	a4,a4,-1952 # 800087a0 <states.0+0x30>
    80001f48:	94ba                	add	s1,s1,a4
    80001f4a:	409c                	lw	a5,0(s1)
    80001f4c:	97ba                	add	a5,a5,a4
    80001f4e:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001f50:	6d3c                	ld	a5,88(a0)
    80001f52:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001f54:	60e2                	ld	ra,24(sp)
    80001f56:	6442                	ld	s0,16(sp)
    80001f58:	64a2                	ld	s1,8(sp)
    80001f5a:	6105                	addi	sp,sp,32
    80001f5c:	8082                	ret
    return p->trapframe->a1;
    80001f5e:	6d3c                	ld	a5,88(a0)
    80001f60:	7fa8                	ld	a0,120(a5)
    80001f62:	bfcd                	j	80001f54 <argraw+0x30>
    return p->trapframe->a2;
    80001f64:	6d3c                	ld	a5,88(a0)
    80001f66:	63c8                	ld	a0,128(a5)
    80001f68:	b7f5                	j	80001f54 <argraw+0x30>
    return p->trapframe->a3;
    80001f6a:	6d3c                	ld	a5,88(a0)
    80001f6c:	67c8                	ld	a0,136(a5)
    80001f6e:	b7dd                	j	80001f54 <argraw+0x30>
    return p->trapframe->a4;
    80001f70:	6d3c                	ld	a5,88(a0)
    80001f72:	6bc8                	ld	a0,144(a5)
    80001f74:	b7c5                	j	80001f54 <argraw+0x30>
    return p->trapframe->a5;
    80001f76:	6d3c                	ld	a5,88(a0)
    80001f78:	6fc8                	ld	a0,152(a5)
    80001f7a:	bfe9                	j	80001f54 <argraw+0x30>
  panic("argraw");
    80001f7c:	00006517          	auipc	a0,0x6
    80001f80:	42450513          	addi	a0,a0,1060 # 800083a0 <etext+0x3a0>
    80001f84:	00004097          	auipc	ra,0x4
    80001f88:	f8e080e7          	jalr	-114(ra) # 80005f12 <panic>

0000000080001f8c <fetchaddr>:
{
    80001f8c:	1101                	addi	sp,sp,-32
    80001f8e:	ec06                	sd	ra,24(sp)
    80001f90:	e822                	sd	s0,16(sp)
    80001f92:	e426                	sd	s1,8(sp)
    80001f94:	e04a                	sd	s2,0(sp)
    80001f96:	1000                	addi	s0,sp,32
    80001f98:	84aa                	mv	s1,a0
    80001f9a:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f9c:	fffff097          	auipc	ra,0xfffff
    80001fa0:	f6a080e7          	jalr	-150(ra) # 80000f06 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001fa4:	653c                	ld	a5,72(a0)
    80001fa6:	02f4f863          	bgeu	s1,a5,80001fd6 <fetchaddr+0x4a>
    80001faa:	00848713          	addi	a4,s1,8
    80001fae:	02e7e663          	bltu	a5,a4,80001fda <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001fb2:	46a1                	li	a3,8
    80001fb4:	8626                	mv	a2,s1
    80001fb6:	85ca                	mv	a1,s2
    80001fb8:	6928                	ld	a0,80(a0)
    80001fba:	fffff097          	auipc	ra,0xfffff
    80001fbe:	c70080e7          	jalr	-912(ra) # 80000c2a <copyin>
    80001fc2:	00a03533          	snez	a0,a0
    80001fc6:	40a00533          	neg	a0,a0
}
    80001fca:	60e2                	ld	ra,24(sp)
    80001fcc:	6442                	ld	s0,16(sp)
    80001fce:	64a2                	ld	s1,8(sp)
    80001fd0:	6902                	ld	s2,0(sp)
    80001fd2:	6105                	addi	sp,sp,32
    80001fd4:	8082                	ret
    return -1;
    80001fd6:	557d                	li	a0,-1
    80001fd8:	bfcd                	j	80001fca <fetchaddr+0x3e>
    80001fda:	557d                	li	a0,-1
    80001fdc:	b7fd                	j	80001fca <fetchaddr+0x3e>

0000000080001fde <fetchstr>:
{
    80001fde:	7179                	addi	sp,sp,-48
    80001fe0:	f406                	sd	ra,40(sp)
    80001fe2:	f022                	sd	s0,32(sp)
    80001fe4:	ec26                	sd	s1,24(sp)
    80001fe6:	e84a                	sd	s2,16(sp)
    80001fe8:	e44e                	sd	s3,8(sp)
    80001fea:	1800                	addi	s0,sp,48
    80001fec:	892a                	mv	s2,a0
    80001fee:	84ae                	mv	s1,a1
    80001ff0:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001ff2:	fffff097          	auipc	ra,0xfffff
    80001ff6:	f14080e7          	jalr	-236(ra) # 80000f06 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001ffa:	86ce                	mv	a3,s3
    80001ffc:	864a                	mv	a2,s2
    80001ffe:	85a6                	mv	a1,s1
    80002000:	6928                	ld	a0,80(a0)
    80002002:	fffff097          	auipc	ra,0xfffff
    80002006:	cb6080e7          	jalr	-842(ra) # 80000cb8 <copyinstr>
    8000200a:	00054e63          	bltz	a0,80002026 <fetchstr+0x48>
  return strlen(buf);
    8000200e:	8526                	mv	a0,s1
    80002010:	ffffe097          	auipc	ra,0xffffe
    80002014:	2de080e7          	jalr	734(ra) # 800002ee <strlen>
}
    80002018:	70a2                	ld	ra,40(sp)
    8000201a:	7402                	ld	s0,32(sp)
    8000201c:	64e2                	ld	s1,24(sp)
    8000201e:	6942                	ld	s2,16(sp)
    80002020:	69a2                	ld	s3,8(sp)
    80002022:	6145                	addi	sp,sp,48
    80002024:	8082                	ret
    return -1;
    80002026:	557d                	li	a0,-1
    80002028:	bfc5                	j	80002018 <fetchstr+0x3a>

000000008000202a <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    8000202a:	1101                	addi	sp,sp,-32
    8000202c:	ec06                	sd	ra,24(sp)
    8000202e:	e822                	sd	s0,16(sp)
    80002030:	e426                	sd	s1,8(sp)
    80002032:	1000                	addi	s0,sp,32
    80002034:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002036:	00000097          	auipc	ra,0x0
    8000203a:	eee080e7          	jalr	-274(ra) # 80001f24 <argraw>
    8000203e:	c088                	sw	a0,0(s1)
}
    80002040:	60e2                	ld	ra,24(sp)
    80002042:	6442                	ld	s0,16(sp)
    80002044:	64a2                	ld	s1,8(sp)
    80002046:	6105                	addi	sp,sp,32
    80002048:	8082                	ret

000000008000204a <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    8000204a:	1101                	addi	sp,sp,-32
    8000204c:	ec06                	sd	ra,24(sp)
    8000204e:	e822                	sd	s0,16(sp)
    80002050:	e426                	sd	s1,8(sp)
    80002052:	1000                	addi	s0,sp,32
    80002054:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002056:	00000097          	auipc	ra,0x0
    8000205a:	ece080e7          	jalr	-306(ra) # 80001f24 <argraw>
    8000205e:	e088                	sd	a0,0(s1)
}
    80002060:	60e2                	ld	ra,24(sp)
    80002062:	6442                	ld	s0,16(sp)
    80002064:	64a2                	ld	s1,8(sp)
    80002066:	6105                	addi	sp,sp,32
    80002068:	8082                	ret

000000008000206a <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000206a:	7179                	addi	sp,sp,-48
    8000206c:	f406                	sd	ra,40(sp)
    8000206e:	f022                	sd	s0,32(sp)
    80002070:	ec26                	sd	s1,24(sp)
    80002072:	e84a                	sd	s2,16(sp)
    80002074:	1800                	addi	s0,sp,48
    80002076:	84ae                	mv	s1,a1
    80002078:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    8000207a:	fd840593          	addi	a1,s0,-40
    8000207e:	00000097          	auipc	ra,0x0
    80002082:	fcc080e7          	jalr	-52(ra) # 8000204a <argaddr>
  return fetchstr(addr, buf, max);
    80002086:	864a                	mv	a2,s2
    80002088:	85a6                	mv	a1,s1
    8000208a:	fd843503          	ld	a0,-40(s0)
    8000208e:	00000097          	auipc	ra,0x0
    80002092:	f50080e7          	jalr	-176(ra) # 80001fde <fetchstr>
}
    80002096:	70a2                	ld	ra,40(sp)
    80002098:	7402                	ld	s0,32(sp)
    8000209a:	64e2                	ld	s1,24(sp)
    8000209c:	6942                	ld	s2,16(sp)
    8000209e:	6145                	addi	sp,sp,48
    800020a0:	8082                	ret

00000000800020a2 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    800020a2:	1101                	addi	sp,sp,-32
    800020a4:	ec06                	sd	ra,24(sp)
    800020a6:	e822                	sd	s0,16(sp)
    800020a8:	e426                	sd	s1,8(sp)
    800020aa:	e04a                	sd	s2,0(sp)
    800020ac:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    800020ae:	fffff097          	auipc	ra,0xfffff
    800020b2:	e58080e7          	jalr	-424(ra) # 80000f06 <myproc>
    800020b6:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800020b8:	05853903          	ld	s2,88(a0)
    800020bc:	0a893783          	ld	a5,168(s2)
    800020c0:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800020c4:	37fd                	addiw	a5,a5,-1
    800020c6:	4751                	li	a4,20
    800020c8:	00f76f63          	bltu	a4,a5,800020e6 <syscall+0x44>
    800020cc:	00369713          	slli	a4,a3,0x3
    800020d0:	00006797          	auipc	a5,0x6
    800020d4:	6e878793          	addi	a5,a5,1768 # 800087b8 <syscalls>
    800020d8:	97ba                	add	a5,a5,a4
    800020da:	639c                	ld	a5,0(a5)
    800020dc:	c789                	beqz	a5,800020e6 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    800020de:	9782                	jalr	a5
    800020e0:	06a93823          	sd	a0,112(s2)
    800020e4:	a839                	j	80002102 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800020e6:	15848613          	addi	a2,s1,344
    800020ea:	588c                	lw	a1,48(s1)
    800020ec:	00006517          	auipc	a0,0x6
    800020f0:	2bc50513          	addi	a0,a0,700 # 800083a8 <etext+0x3a8>
    800020f4:	00004097          	auipc	ra,0x4
    800020f8:	e68080e7          	jalr	-408(ra) # 80005f5c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800020fc:	6cbc                	ld	a5,88(s1)
    800020fe:	577d                	li	a4,-1
    80002100:	fbb8                	sd	a4,112(a5)
  }
}
    80002102:	60e2                	ld	ra,24(sp)
    80002104:	6442                	ld	s0,16(sp)
    80002106:	64a2                	ld	s1,8(sp)
    80002108:	6902                	ld	s2,0(sp)
    8000210a:	6105                	addi	sp,sp,32
    8000210c:	8082                	ret

000000008000210e <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000210e:	1101                	addi	sp,sp,-32
    80002110:	ec06                	sd	ra,24(sp)
    80002112:	e822                	sd	s0,16(sp)
    80002114:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002116:	fec40593          	addi	a1,s0,-20
    8000211a:	4501                	li	a0,0
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	f0e080e7          	jalr	-242(ra) # 8000202a <argint>
  exit(n);
    80002124:	fec42503          	lw	a0,-20(s0)
    80002128:	fffff097          	auipc	ra,0xfffff
    8000212c:	5c0080e7          	jalr	1472(ra) # 800016e8 <exit>
  return 0;  // not reached
}
    80002130:	4501                	li	a0,0
    80002132:	60e2                	ld	ra,24(sp)
    80002134:	6442                	ld	s0,16(sp)
    80002136:	6105                	addi	sp,sp,32
    80002138:	8082                	ret

000000008000213a <sys_getpid>:

uint64
sys_getpid(void)
{
    8000213a:	1141                	addi	sp,sp,-16
    8000213c:	e406                	sd	ra,8(sp)
    8000213e:	e022                	sd	s0,0(sp)
    80002140:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002142:	fffff097          	auipc	ra,0xfffff
    80002146:	dc4080e7          	jalr	-572(ra) # 80000f06 <myproc>
}
    8000214a:	5908                	lw	a0,48(a0)
    8000214c:	60a2                	ld	ra,8(sp)
    8000214e:	6402                	ld	s0,0(sp)
    80002150:	0141                	addi	sp,sp,16
    80002152:	8082                	ret

0000000080002154 <sys_fork>:

uint64
sys_fork(void)
{
    80002154:	1141                	addi	sp,sp,-16
    80002156:	e406                	sd	ra,8(sp)
    80002158:	e022                	sd	s0,0(sp)
    8000215a:	0800                	addi	s0,sp,16
  return fork();
    8000215c:	fffff097          	auipc	ra,0xfffff
    80002160:	164080e7          	jalr	356(ra) # 800012c0 <fork>
}
    80002164:	60a2                	ld	ra,8(sp)
    80002166:	6402                	ld	s0,0(sp)
    80002168:	0141                	addi	sp,sp,16
    8000216a:	8082                	ret

000000008000216c <sys_wait>:

uint64
sys_wait(void)
{
    8000216c:	1101                	addi	sp,sp,-32
    8000216e:	ec06                	sd	ra,24(sp)
    80002170:	e822                	sd	s0,16(sp)
    80002172:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002174:	fe840593          	addi	a1,s0,-24
    80002178:	4501                	li	a0,0
    8000217a:	00000097          	auipc	ra,0x0
    8000217e:	ed0080e7          	jalr	-304(ra) # 8000204a <argaddr>
  return wait(p);
    80002182:	fe843503          	ld	a0,-24(s0)
    80002186:	fffff097          	auipc	ra,0xfffff
    8000218a:	708080e7          	jalr	1800(ra) # 8000188e <wait>
}
    8000218e:	60e2                	ld	ra,24(sp)
    80002190:	6442                	ld	s0,16(sp)
    80002192:	6105                	addi	sp,sp,32
    80002194:	8082                	ret

0000000080002196 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002196:	7179                	addi	sp,sp,-48
    80002198:	f406                	sd	ra,40(sp)
    8000219a:	f022                	sd	s0,32(sp)
    8000219c:	ec26                	sd	s1,24(sp)
    8000219e:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    800021a0:	fdc40593          	addi	a1,s0,-36
    800021a4:	4501                	li	a0,0
    800021a6:	00000097          	auipc	ra,0x0
    800021aa:	e84080e7          	jalr	-380(ra) # 8000202a <argint>
  addr = myproc()->sz;
    800021ae:	fffff097          	auipc	ra,0xfffff
    800021b2:	d58080e7          	jalr	-680(ra) # 80000f06 <myproc>
    800021b6:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    800021b8:	fdc42503          	lw	a0,-36(s0)
    800021bc:	fffff097          	auipc	ra,0xfffff
    800021c0:	0a8080e7          	jalr	168(ra) # 80001264 <growproc>
    800021c4:	00054863          	bltz	a0,800021d4 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    800021c8:	8526                	mv	a0,s1
    800021ca:	70a2                	ld	ra,40(sp)
    800021cc:	7402                	ld	s0,32(sp)
    800021ce:	64e2                	ld	s1,24(sp)
    800021d0:	6145                	addi	sp,sp,48
    800021d2:	8082                	ret
    return -1;
    800021d4:	54fd                	li	s1,-1
    800021d6:	bfcd                	j	800021c8 <sys_sbrk+0x32>

00000000800021d8 <sys_sleep>:

uint64
sys_sleep(void)
{
    800021d8:	7139                	addi	sp,sp,-64
    800021da:	fc06                	sd	ra,56(sp)
    800021dc:	f822                	sd	s0,48(sp)
    800021de:	f04a                	sd	s2,32(sp)
    800021e0:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    800021e2:	fcc40593          	addi	a1,s0,-52
    800021e6:	4501                	li	a0,0
    800021e8:	00000097          	auipc	ra,0x0
    800021ec:	e42080e7          	jalr	-446(ra) # 8000202a <argint>
  if(n < 0)
    800021f0:	fcc42783          	lw	a5,-52(s0)
    800021f4:	0807c163          	bltz	a5,80002276 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    800021f8:	0000f517          	auipc	a0,0xf
    800021fc:	e9850513          	addi	a0,a0,-360 # 80011090 <tickslock>
    80002200:	00004097          	auipc	ra,0x4
    80002204:	28c080e7          	jalr	652(ra) # 8000648c <acquire>
  ticks0 = ticks;
    80002208:	00009917          	auipc	s2,0x9
    8000220c:	02092903          	lw	s2,32(s2) # 8000b228 <ticks>
  while(ticks - ticks0 < n){
    80002210:	fcc42783          	lw	a5,-52(s0)
    80002214:	c3b9                	beqz	a5,8000225a <sys_sleep+0x82>
    80002216:	f426                	sd	s1,40(sp)
    80002218:	ec4e                	sd	s3,24(sp)
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000221a:	0000f997          	auipc	s3,0xf
    8000221e:	e7698993          	addi	s3,s3,-394 # 80011090 <tickslock>
    80002222:	00009497          	auipc	s1,0x9
    80002226:	00648493          	addi	s1,s1,6 # 8000b228 <ticks>
    if(killed(myproc())){
    8000222a:	fffff097          	auipc	ra,0xfffff
    8000222e:	cdc080e7          	jalr	-804(ra) # 80000f06 <myproc>
    80002232:	fffff097          	auipc	ra,0xfffff
    80002236:	62a080e7          	jalr	1578(ra) # 8000185c <killed>
    8000223a:	e129                	bnez	a0,8000227c <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    8000223c:	85ce                	mv	a1,s3
    8000223e:	8526                	mv	a0,s1
    80002240:	fffff097          	auipc	ra,0xfffff
    80002244:	374080e7          	jalr	884(ra) # 800015b4 <sleep>
  while(ticks - ticks0 < n){
    80002248:	409c                	lw	a5,0(s1)
    8000224a:	412787bb          	subw	a5,a5,s2
    8000224e:	fcc42703          	lw	a4,-52(s0)
    80002252:	fce7ece3          	bltu	a5,a4,8000222a <sys_sleep+0x52>
    80002256:	74a2                	ld	s1,40(sp)
    80002258:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    8000225a:	0000f517          	auipc	a0,0xf
    8000225e:	e3650513          	addi	a0,a0,-458 # 80011090 <tickslock>
    80002262:	00004097          	auipc	ra,0x4
    80002266:	2de080e7          	jalr	734(ra) # 80006540 <release>
  return 0;
    8000226a:	4501                	li	a0,0
}
    8000226c:	70e2                	ld	ra,56(sp)
    8000226e:	7442                	ld	s0,48(sp)
    80002270:	7902                	ld	s2,32(sp)
    80002272:	6121                	addi	sp,sp,64
    80002274:	8082                	ret
    n = 0;
    80002276:	fc042623          	sw	zero,-52(s0)
    8000227a:	bfbd                	j	800021f8 <sys_sleep+0x20>
      release(&tickslock);
    8000227c:	0000f517          	auipc	a0,0xf
    80002280:	e1450513          	addi	a0,a0,-492 # 80011090 <tickslock>
    80002284:	00004097          	auipc	ra,0x4
    80002288:	2bc080e7          	jalr	700(ra) # 80006540 <release>
      return -1;
    8000228c:	557d                	li	a0,-1
    8000228e:	74a2                	ld	s1,40(sp)
    80002290:	69e2                	ld	s3,24(sp)
    80002292:	bfe9                	j	8000226c <sys_sleep+0x94>

0000000080002294 <sys_kill>:

uint64
sys_kill(void)
{
    80002294:	1101                	addi	sp,sp,-32
    80002296:	ec06                	sd	ra,24(sp)
    80002298:	e822                	sd	s0,16(sp)
    8000229a:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    8000229c:	fec40593          	addi	a1,s0,-20
    800022a0:	4501                	li	a0,0
    800022a2:	00000097          	auipc	ra,0x0
    800022a6:	d88080e7          	jalr	-632(ra) # 8000202a <argint>
  return kill(pid);
    800022aa:	fec42503          	lw	a0,-20(s0)
    800022ae:	fffff097          	auipc	ra,0xfffff
    800022b2:	510080e7          	jalr	1296(ra) # 800017be <kill>
}
    800022b6:	60e2                	ld	ra,24(sp)
    800022b8:	6442                	ld	s0,16(sp)
    800022ba:	6105                	addi	sp,sp,32
    800022bc:	8082                	ret

00000000800022be <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800022be:	1101                	addi	sp,sp,-32
    800022c0:	ec06                	sd	ra,24(sp)
    800022c2:	e822                	sd	s0,16(sp)
    800022c4:	e426                	sd	s1,8(sp)
    800022c6:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800022c8:	0000f517          	auipc	a0,0xf
    800022cc:	dc850513          	addi	a0,a0,-568 # 80011090 <tickslock>
    800022d0:	00004097          	auipc	ra,0x4
    800022d4:	1bc080e7          	jalr	444(ra) # 8000648c <acquire>
  xticks = ticks;
    800022d8:	00009497          	auipc	s1,0x9
    800022dc:	f504a483          	lw	s1,-176(s1) # 8000b228 <ticks>
  release(&tickslock);
    800022e0:	0000f517          	auipc	a0,0xf
    800022e4:	db050513          	addi	a0,a0,-592 # 80011090 <tickslock>
    800022e8:	00004097          	auipc	ra,0x4
    800022ec:	258080e7          	jalr	600(ra) # 80006540 <release>
  return xticks;
}
    800022f0:	02049513          	slli	a0,s1,0x20
    800022f4:	9101                	srli	a0,a0,0x20
    800022f6:	60e2                	ld	ra,24(sp)
    800022f8:	6442                	ld	s0,16(sp)
    800022fa:	64a2                	ld	s1,8(sp)
    800022fc:	6105                	addi	sp,sp,32
    800022fe:	8082                	ret

0000000080002300 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002300:	7179                	addi	sp,sp,-48
    80002302:	f406                	sd	ra,40(sp)
    80002304:	f022                	sd	s0,32(sp)
    80002306:	ec26                	sd	s1,24(sp)
    80002308:	e84a                	sd	s2,16(sp)
    8000230a:	e44e                	sd	s3,8(sp)
    8000230c:	e052                	sd	s4,0(sp)
    8000230e:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002310:	00006597          	auipc	a1,0x6
    80002314:	0b858593          	addi	a1,a1,184 # 800083c8 <etext+0x3c8>
    80002318:	0000f517          	auipc	a0,0xf
    8000231c:	d9050513          	addi	a0,a0,-624 # 800110a8 <bcache>
    80002320:	00004097          	auipc	ra,0x4
    80002324:	0dc080e7          	jalr	220(ra) # 800063fc <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002328:	00017797          	auipc	a5,0x17
    8000232c:	d8078793          	addi	a5,a5,-640 # 800190a8 <bcache+0x8000>
    80002330:	00017717          	auipc	a4,0x17
    80002334:	fe070713          	addi	a4,a4,-32 # 80019310 <bcache+0x8268>
    80002338:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000233c:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002340:	0000f497          	auipc	s1,0xf
    80002344:	d8048493          	addi	s1,s1,-640 # 800110c0 <bcache+0x18>
    b->next = bcache.head.next;
    80002348:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000234a:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000234c:	00006a17          	auipc	s4,0x6
    80002350:	084a0a13          	addi	s4,s4,132 # 800083d0 <etext+0x3d0>
    b->next = bcache.head.next;
    80002354:	2b893783          	ld	a5,696(s2)
    80002358:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000235a:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000235e:	85d2                	mv	a1,s4
    80002360:	01048513          	addi	a0,s1,16
    80002364:	00001097          	auipc	ra,0x1
    80002368:	672080e7          	jalr	1650(ra) # 800039d6 <initsleeplock>
    bcache.head.next->prev = b;
    8000236c:	2b893783          	ld	a5,696(s2)
    80002370:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002372:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002376:	45848493          	addi	s1,s1,1112
    8000237a:	fd349de3          	bne	s1,s3,80002354 <binit+0x54>
  }
}
    8000237e:	70a2                	ld	ra,40(sp)
    80002380:	7402                	ld	s0,32(sp)
    80002382:	64e2                	ld	s1,24(sp)
    80002384:	6942                	ld	s2,16(sp)
    80002386:	69a2                	ld	s3,8(sp)
    80002388:	6a02                	ld	s4,0(sp)
    8000238a:	6145                	addi	sp,sp,48
    8000238c:	8082                	ret

000000008000238e <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000238e:	7179                	addi	sp,sp,-48
    80002390:	f406                	sd	ra,40(sp)
    80002392:	f022                	sd	s0,32(sp)
    80002394:	ec26                	sd	s1,24(sp)
    80002396:	e84a                	sd	s2,16(sp)
    80002398:	e44e                	sd	s3,8(sp)
    8000239a:	1800                	addi	s0,sp,48
    8000239c:	892a                	mv	s2,a0
    8000239e:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800023a0:	0000f517          	auipc	a0,0xf
    800023a4:	d0850513          	addi	a0,a0,-760 # 800110a8 <bcache>
    800023a8:	00004097          	auipc	ra,0x4
    800023ac:	0e4080e7          	jalr	228(ra) # 8000648c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800023b0:	00017497          	auipc	s1,0x17
    800023b4:	fb04b483          	ld	s1,-80(s1) # 80019360 <bcache+0x82b8>
    800023b8:	00017797          	auipc	a5,0x17
    800023bc:	f5878793          	addi	a5,a5,-168 # 80019310 <bcache+0x8268>
    800023c0:	02f48f63          	beq	s1,a5,800023fe <bread+0x70>
    800023c4:	873e                	mv	a4,a5
    800023c6:	a021                	j	800023ce <bread+0x40>
    800023c8:	68a4                	ld	s1,80(s1)
    800023ca:	02e48a63          	beq	s1,a4,800023fe <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800023ce:	449c                	lw	a5,8(s1)
    800023d0:	ff279ce3          	bne	a5,s2,800023c8 <bread+0x3a>
    800023d4:	44dc                	lw	a5,12(s1)
    800023d6:	ff3799e3          	bne	a5,s3,800023c8 <bread+0x3a>
      b->refcnt++;
    800023da:	40bc                	lw	a5,64(s1)
    800023dc:	2785                	addiw	a5,a5,1
    800023de:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800023e0:	0000f517          	auipc	a0,0xf
    800023e4:	cc850513          	addi	a0,a0,-824 # 800110a8 <bcache>
    800023e8:	00004097          	auipc	ra,0x4
    800023ec:	158080e7          	jalr	344(ra) # 80006540 <release>
      acquiresleep(&b->lock);
    800023f0:	01048513          	addi	a0,s1,16
    800023f4:	00001097          	auipc	ra,0x1
    800023f8:	61c080e7          	jalr	1564(ra) # 80003a10 <acquiresleep>
      return b;
    800023fc:	a8b9                	j	8000245a <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800023fe:	00017497          	auipc	s1,0x17
    80002402:	f5a4b483          	ld	s1,-166(s1) # 80019358 <bcache+0x82b0>
    80002406:	00017797          	auipc	a5,0x17
    8000240a:	f0a78793          	addi	a5,a5,-246 # 80019310 <bcache+0x8268>
    8000240e:	00f48863          	beq	s1,a5,8000241e <bread+0x90>
    80002412:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002414:	40bc                	lw	a5,64(s1)
    80002416:	cf81                	beqz	a5,8000242e <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002418:	64a4                	ld	s1,72(s1)
    8000241a:	fee49de3          	bne	s1,a4,80002414 <bread+0x86>
  panic("bget: no buffers");
    8000241e:	00006517          	auipc	a0,0x6
    80002422:	fba50513          	addi	a0,a0,-70 # 800083d8 <etext+0x3d8>
    80002426:	00004097          	auipc	ra,0x4
    8000242a:	aec080e7          	jalr	-1300(ra) # 80005f12 <panic>
      b->dev = dev;
    8000242e:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002432:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002436:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8000243a:	4785                	li	a5,1
    8000243c:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000243e:	0000f517          	auipc	a0,0xf
    80002442:	c6a50513          	addi	a0,a0,-918 # 800110a8 <bcache>
    80002446:	00004097          	auipc	ra,0x4
    8000244a:	0fa080e7          	jalr	250(ra) # 80006540 <release>
      acquiresleep(&b->lock);
    8000244e:	01048513          	addi	a0,s1,16
    80002452:	00001097          	auipc	ra,0x1
    80002456:	5be080e7          	jalr	1470(ra) # 80003a10 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    8000245a:	409c                	lw	a5,0(s1)
    8000245c:	cb89                	beqz	a5,8000246e <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000245e:	8526                	mv	a0,s1
    80002460:	70a2                	ld	ra,40(sp)
    80002462:	7402                	ld	s0,32(sp)
    80002464:	64e2                	ld	s1,24(sp)
    80002466:	6942                	ld	s2,16(sp)
    80002468:	69a2                	ld	s3,8(sp)
    8000246a:	6145                	addi	sp,sp,48
    8000246c:	8082                	ret
    virtio_disk_rw(b, 0);
    8000246e:	4581                	li	a1,0
    80002470:	8526                	mv	a0,s1
    80002472:	00003097          	auipc	ra,0x3
    80002476:	276080e7          	jalr	630(ra) # 800056e8 <virtio_disk_rw>
    b->valid = 1;
    8000247a:	4785                	li	a5,1
    8000247c:	c09c                	sw	a5,0(s1)
  return b;
    8000247e:	b7c5                	j	8000245e <bread+0xd0>

0000000080002480 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002480:	1101                	addi	sp,sp,-32
    80002482:	ec06                	sd	ra,24(sp)
    80002484:	e822                	sd	s0,16(sp)
    80002486:	e426                	sd	s1,8(sp)
    80002488:	1000                	addi	s0,sp,32
    8000248a:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000248c:	0541                	addi	a0,a0,16
    8000248e:	00001097          	auipc	ra,0x1
    80002492:	61c080e7          	jalr	1564(ra) # 80003aaa <holdingsleep>
    80002496:	cd01                	beqz	a0,800024ae <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002498:	4585                	li	a1,1
    8000249a:	8526                	mv	a0,s1
    8000249c:	00003097          	auipc	ra,0x3
    800024a0:	24c080e7          	jalr	588(ra) # 800056e8 <virtio_disk_rw>
}
    800024a4:	60e2                	ld	ra,24(sp)
    800024a6:	6442                	ld	s0,16(sp)
    800024a8:	64a2                	ld	s1,8(sp)
    800024aa:	6105                	addi	sp,sp,32
    800024ac:	8082                	ret
    panic("bwrite");
    800024ae:	00006517          	auipc	a0,0x6
    800024b2:	f4250513          	addi	a0,a0,-190 # 800083f0 <etext+0x3f0>
    800024b6:	00004097          	auipc	ra,0x4
    800024ba:	a5c080e7          	jalr	-1444(ra) # 80005f12 <panic>

00000000800024be <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800024be:	1101                	addi	sp,sp,-32
    800024c0:	ec06                	sd	ra,24(sp)
    800024c2:	e822                	sd	s0,16(sp)
    800024c4:	e426                	sd	s1,8(sp)
    800024c6:	e04a                	sd	s2,0(sp)
    800024c8:	1000                	addi	s0,sp,32
    800024ca:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800024cc:	01050913          	addi	s2,a0,16
    800024d0:	854a                	mv	a0,s2
    800024d2:	00001097          	auipc	ra,0x1
    800024d6:	5d8080e7          	jalr	1496(ra) # 80003aaa <holdingsleep>
    800024da:	c925                	beqz	a0,8000254a <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    800024dc:	854a                	mv	a0,s2
    800024de:	00001097          	auipc	ra,0x1
    800024e2:	588080e7          	jalr	1416(ra) # 80003a66 <releasesleep>

  acquire(&bcache.lock);
    800024e6:	0000f517          	auipc	a0,0xf
    800024ea:	bc250513          	addi	a0,a0,-1086 # 800110a8 <bcache>
    800024ee:	00004097          	auipc	ra,0x4
    800024f2:	f9e080e7          	jalr	-98(ra) # 8000648c <acquire>
  b->refcnt--;
    800024f6:	40bc                	lw	a5,64(s1)
    800024f8:	37fd                	addiw	a5,a5,-1
    800024fa:	0007871b          	sext.w	a4,a5
    800024fe:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002500:	e71d                	bnez	a4,8000252e <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002502:	68b8                	ld	a4,80(s1)
    80002504:	64bc                	ld	a5,72(s1)
    80002506:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002508:	68b8                	ld	a4,80(s1)
    8000250a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000250c:	00017797          	auipc	a5,0x17
    80002510:	b9c78793          	addi	a5,a5,-1124 # 800190a8 <bcache+0x8000>
    80002514:	2b87b703          	ld	a4,696(a5)
    80002518:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8000251a:	00017717          	auipc	a4,0x17
    8000251e:	df670713          	addi	a4,a4,-522 # 80019310 <bcache+0x8268>
    80002522:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002524:	2b87b703          	ld	a4,696(a5)
    80002528:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000252a:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000252e:	0000f517          	auipc	a0,0xf
    80002532:	b7a50513          	addi	a0,a0,-1158 # 800110a8 <bcache>
    80002536:	00004097          	auipc	ra,0x4
    8000253a:	00a080e7          	jalr	10(ra) # 80006540 <release>
}
    8000253e:	60e2                	ld	ra,24(sp)
    80002540:	6442                	ld	s0,16(sp)
    80002542:	64a2                	ld	s1,8(sp)
    80002544:	6902                	ld	s2,0(sp)
    80002546:	6105                	addi	sp,sp,32
    80002548:	8082                	ret
    panic("brelse");
    8000254a:	00006517          	auipc	a0,0x6
    8000254e:	eae50513          	addi	a0,a0,-338 # 800083f8 <etext+0x3f8>
    80002552:	00004097          	auipc	ra,0x4
    80002556:	9c0080e7          	jalr	-1600(ra) # 80005f12 <panic>

000000008000255a <bpin>:

void
bpin(struct buf *b) {
    8000255a:	1101                	addi	sp,sp,-32
    8000255c:	ec06                	sd	ra,24(sp)
    8000255e:	e822                	sd	s0,16(sp)
    80002560:	e426                	sd	s1,8(sp)
    80002562:	1000                	addi	s0,sp,32
    80002564:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002566:	0000f517          	auipc	a0,0xf
    8000256a:	b4250513          	addi	a0,a0,-1214 # 800110a8 <bcache>
    8000256e:	00004097          	auipc	ra,0x4
    80002572:	f1e080e7          	jalr	-226(ra) # 8000648c <acquire>
  b->refcnt++;
    80002576:	40bc                	lw	a5,64(s1)
    80002578:	2785                	addiw	a5,a5,1
    8000257a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000257c:	0000f517          	auipc	a0,0xf
    80002580:	b2c50513          	addi	a0,a0,-1236 # 800110a8 <bcache>
    80002584:	00004097          	auipc	ra,0x4
    80002588:	fbc080e7          	jalr	-68(ra) # 80006540 <release>
}
    8000258c:	60e2                	ld	ra,24(sp)
    8000258e:	6442                	ld	s0,16(sp)
    80002590:	64a2                	ld	s1,8(sp)
    80002592:	6105                	addi	sp,sp,32
    80002594:	8082                	ret

0000000080002596 <bunpin>:

void
bunpin(struct buf *b) {
    80002596:	1101                	addi	sp,sp,-32
    80002598:	ec06                	sd	ra,24(sp)
    8000259a:	e822                	sd	s0,16(sp)
    8000259c:	e426                	sd	s1,8(sp)
    8000259e:	1000                	addi	s0,sp,32
    800025a0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800025a2:	0000f517          	auipc	a0,0xf
    800025a6:	b0650513          	addi	a0,a0,-1274 # 800110a8 <bcache>
    800025aa:	00004097          	auipc	ra,0x4
    800025ae:	ee2080e7          	jalr	-286(ra) # 8000648c <acquire>
  b->refcnt--;
    800025b2:	40bc                	lw	a5,64(s1)
    800025b4:	37fd                	addiw	a5,a5,-1
    800025b6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800025b8:	0000f517          	auipc	a0,0xf
    800025bc:	af050513          	addi	a0,a0,-1296 # 800110a8 <bcache>
    800025c0:	00004097          	auipc	ra,0x4
    800025c4:	f80080e7          	jalr	-128(ra) # 80006540 <release>
}
    800025c8:	60e2                	ld	ra,24(sp)
    800025ca:	6442                	ld	s0,16(sp)
    800025cc:	64a2                	ld	s1,8(sp)
    800025ce:	6105                	addi	sp,sp,32
    800025d0:	8082                	ret

00000000800025d2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800025d2:	1101                	addi	sp,sp,-32
    800025d4:	ec06                	sd	ra,24(sp)
    800025d6:	e822                	sd	s0,16(sp)
    800025d8:	e426                	sd	s1,8(sp)
    800025da:	e04a                	sd	s2,0(sp)
    800025dc:	1000                	addi	s0,sp,32
    800025de:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800025e0:	00d5d59b          	srliw	a1,a1,0xd
    800025e4:	00017797          	auipc	a5,0x17
    800025e8:	1a07a783          	lw	a5,416(a5) # 80019784 <sb+0x1c>
    800025ec:	9dbd                	addw	a1,a1,a5
    800025ee:	00000097          	auipc	ra,0x0
    800025f2:	da0080e7          	jalr	-608(ra) # 8000238e <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800025f6:	0074f713          	andi	a4,s1,7
    800025fa:	4785                	li	a5,1
    800025fc:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002600:	14ce                	slli	s1,s1,0x33
    80002602:	90d9                	srli	s1,s1,0x36
    80002604:	00950733          	add	a4,a0,s1
    80002608:	05874703          	lbu	a4,88(a4)
    8000260c:	00e7f6b3          	and	a3,a5,a4
    80002610:	c69d                	beqz	a3,8000263e <bfree+0x6c>
    80002612:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002614:	94aa                	add	s1,s1,a0
    80002616:	fff7c793          	not	a5,a5
    8000261a:	8f7d                	and	a4,a4,a5
    8000261c:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002620:	00001097          	auipc	ra,0x1
    80002624:	2d2080e7          	jalr	722(ra) # 800038f2 <log_write>
  brelse(bp);
    80002628:	854a                	mv	a0,s2
    8000262a:	00000097          	auipc	ra,0x0
    8000262e:	e94080e7          	jalr	-364(ra) # 800024be <brelse>
}
    80002632:	60e2                	ld	ra,24(sp)
    80002634:	6442                	ld	s0,16(sp)
    80002636:	64a2                	ld	s1,8(sp)
    80002638:	6902                	ld	s2,0(sp)
    8000263a:	6105                	addi	sp,sp,32
    8000263c:	8082                	ret
    panic("freeing free block");
    8000263e:	00006517          	auipc	a0,0x6
    80002642:	dc250513          	addi	a0,a0,-574 # 80008400 <etext+0x400>
    80002646:	00004097          	auipc	ra,0x4
    8000264a:	8cc080e7          	jalr	-1844(ra) # 80005f12 <panic>

000000008000264e <balloc>:
{
    8000264e:	711d                	addi	sp,sp,-96
    80002650:	ec86                	sd	ra,88(sp)
    80002652:	e8a2                	sd	s0,80(sp)
    80002654:	e4a6                	sd	s1,72(sp)
    80002656:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002658:	00017797          	auipc	a5,0x17
    8000265c:	1147a783          	lw	a5,276(a5) # 8001976c <sb+0x4>
    80002660:	10078f63          	beqz	a5,8000277e <balloc+0x130>
    80002664:	e0ca                	sd	s2,64(sp)
    80002666:	fc4e                	sd	s3,56(sp)
    80002668:	f852                	sd	s4,48(sp)
    8000266a:	f456                	sd	s5,40(sp)
    8000266c:	f05a                	sd	s6,32(sp)
    8000266e:	ec5e                	sd	s7,24(sp)
    80002670:	e862                	sd	s8,16(sp)
    80002672:	e466                	sd	s9,8(sp)
    80002674:	8baa                	mv	s7,a0
    80002676:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002678:	00017b17          	auipc	s6,0x17
    8000267c:	0f0b0b13          	addi	s6,s6,240 # 80019768 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002680:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002682:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002684:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002686:	6c89                	lui	s9,0x2
    80002688:	a061                	j	80002710 <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000268a:	97ca                	add	a5,a5,s2
    8000268c:	8e55                	or	a2,a2,a3
    8000268e:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002692:	854a                	mv	a0,s2
    80002694:	00001097          	auipc	ra,0x1
    80002698:	25e080e7          	jalr	606(ra) # 800038f2 <log_write>
        brelse(bp);
    8000269c:	854a                	mv	a0,s2
    8000269e:	00000097          	auipc	ra,0x0
    800026a2:	e20080e7          	jalr	-480(ra) # 800024be <brelse>
  bp = bread(dev, bno);
    800026a6:	85a6                	mv	a1,s1
    800026a8:	855e                	mv	a0,s7
    800026aa:	00000097          	auipc	ra,0x0
    800026ae:	ce4080e7          	jalr	-796(ra) # 8000238e <bread>
    800026b2:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800026b4:	40000613          	li	a2,1024
    800026b8:	4581                	li	a1,0
    800026ba:	05850513          	addi	a0,a0,88
    800026be:	ffffe097          	auipc	ra,0xffffe
    800026c2:	abc080e7          	jalr	-1348(ra) # 8000017a <memset>
  log_write(bp);
    800026c6:	854a                	mv	a0,s2
    800026c8:	00001097          	auipc	ra,0x1
    800026cc:	22a080e7          	jalr	554(ra) # 800038f2 <log_write>
  brelse(bp);
    800026d0:	854a                	mv	a0,s2
    800026d2:	00000097          	auipc	ra,0x0
    800026d6:	dec080e7          	jalr	-532(ra) # 800024be <brelse>
}
    800026da:	6906                	ld	s2,64(sp)
    800026dc:	79e2                	ld	s3,56(sp)
    800026de:	7a42                	ld	s4,48(sp)
    800026e0:	7aa2                	ld	s5,40(sp)
    800026e2:	7b02                	ld	s6,32(sp)
    800026e4:	6be2                	ld	s7,24(sp)
    800026e6:	6c42                	ld	s8,16(sp)
    800026e8:	6ca2                	ld	s9,8(sp)
}
    800026ea:	8526                	mv	a0,s1
    800026ec:	60e6                	ld	ra,88(sp)
    800026ee:	6446                	ld	s0,80(sp)
    800026f0:	64a6                	ld	s1,72(sp)
    800026f2:	6125                	addi	sp,sp,96
    800026f4:	8082                	ret
    brelse(bp);
    800026f6:	854a                	mv	a0,s2
    800026f8:	00000097          	auipc	ra,0x0
    800026fc:	dc6080e7          	jalr	-570(ra) # 800024be <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002700:	015c87bb          	addw	a5,s9,s5
    80002704:	00078a9b          	sext.w	s5,a5
    80002708:	004b2703          	lw	a4,4(s6)
    8000270c:	06eaf163          	bgeu	s5,a4,8000276e <balloc+0x120>
    bp = bread(dev, BBLOCK(b, sb));
    80002710:	41fad79b          	sraiw	a5,s5,0x1f
    80002714:	0137d79b          	srliw	a5,a5,0x13
    80002718:	015787bb          	addw	a5,a5,s5
    8000271c:	40d7d79b          	sraiw	a5,a5,0xd
    80002720:	01cb2583          	lw	a1,28(s6)
    80002724:	9dbd                	addw	a1,a1,a5
    80002726:	855e                	mv	a0,s7
    80002728:	00000097          	auipc	ra,0x0
    8000272c:	c66080e7          	jalr	-922(ra) # 8000238e <bread>
    80002730:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002732:	004b2503          	lw	a0,4(s6)
    80002736:	000a849b          	sext.w	s1,s5
    8000273a:	8762                	mv	a4,s8
    8000273c:	faa4fde3          	bgeu	s1,a0,800026f6 <balloc+0xa8>
      m = 1 << (bi % 8);
    80002740:	00777693          	andi	a3,a4,7
    80002744:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002748:	41f7579b          	sraiw	a5,a4,0x1f
    8000274c:	01d7d79b          	srliw	a5,a5,0x1d
    80002750:	9fb9                	addw	a5,a5,a4
    80002752:	4037d79b          	sraiw	a5,a5,0x3
    80002756:	00f90633          	add	a2,s2,a5
    8000275a:	05864603          	lbu	a2,88(a2)
    8000275e:	00c6f5b3          	and	a1,a3,a2
    80002762:	d585                	beqz	a1,8000268a <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002764:	2705                	addiw	a4,a4,1
    80002766:	2485                	addiw	s1,s1,1
    80002768:	fd471ae3          	bne	a4,s4,8000273c <balloc+0xee>
    8000276c:	b769                	j	800026f6 <balloc+0xa8>
    8000276e:	6906                	ld	s2,64(sp)
    80002770:	79e2                	ld	s3,56(sp)
    80002772:	7a42                	ld	s4,48(sp)
    80002774:	7aa2                	ld	s5,40(sp)
    80002776:	7b02                	ld	s6,32(sp)
    80002778:	6be2                	ld	s7,24(sp)
    8000277a:	6c42                	ld	s8,16(sp)
    8000277c:	6ca2                	ld	s9,8(sp)
  printf("balloc: out of blocks\n");
    8000277e:	00006517          	auipc	a0,0x6
    80002782:	c9a50513          	addi	a0,a0,-870 # 80008418 <etext+0x418>
    80002786:	00003097          	auipc	ra,0x3
    8000278a:	7d6080e7          	jalr	2006(ra) # 80005f5c <printf>
  return 0;
    8000278e:	4481                	li	s1,0
    80002790:	bfa9                	j	800026ea <balloc+0x9c>

0000000080002792 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002792:	7139                	addi	sp,sp,-64
    80002794:	fc06                	sd	ra,56(sp)
    80002796:	f822                	sd	s0,48(sp)
    80002798:	f426                	sd	s1,40(sp)
    8000279a:	f04a                	sd	s2,32(sp)
    8000279c:	ec4e                	sd	s3,24(sp)
    8000279e:	0080                	addi	s0,sp,64
    800027a0:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800027a2:	47a9                	li	a5,10
    800027a4:	04b7e063          	bltu	a5,a1,800027e4 <bmap+0x52>
    if((addr = ip->addrs[bn]) == 0){
    800027a8:	02059793          	slli	a5,a1,0x20
    800027ac:	01e7d593          	srli	a1,a5,0x1e
    800027b0:	00b504b3          	add	s1,a0,a1
    800027b4:	0504a903          	lw	s2,80(s1)
    800027b8:	00090a63          	beqz	s2,800027cc <bmap+0x3a>
    // Return the address of the found data block
    return addr;
  }

  panic("bmap: out of range");
}
    800027bc:	854a                	mv	a0,s2
    800027be:	70e2                	ld	ra,56(sp)
    800027c0:	7442                	ld	s0,48(sp)
    800027c2:	74a2                	ld	s1,40(sp)
    800027c4:	7902                	ld	s2,32(sp)
    800027c6:	69e2                	ld	s3,24(sp)
    800027c8:	6121                	addi	sp,sp,64
    800027ca:	8082                	ret
      addr = balloc(ip->dev);
    800027cc:	4108                	lw	a0,0(a0)
    800027ce:	00000097          	auipc	ra,0x0
    800027d2:	e80080e7          	jalr	-384(ra) # 8000264e <balloc>
    800027d6:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800027da:	fe0901e3          	beqz	s2,800027bc <bmap+0x2a>
      ip->addrs[bn] = addr;
    800027de:	0524a823          	sw	s2,80(s1)
    800027e2:	bfe9                	j	800027bc <bmap+0x2a>
  bn -= NDIRECT;
    800027e4:	ff55849b          	addiw	s1,a1,-11
    800027e8:	0004871b          	sext.w	a4,s1
  if(bn < NINDIRECT){
    800027ec:	0ff00793          	li	a5,255
    800027f0:	08e7e063          	bltu	a5,a4,80002870 <bmap+0xde>
    if((addr = ip->addrs[NDIRECT]) == 0){
    800027f4:	07c52903          	lw	s2,124(a0)
    800027f8:	00091f63          	bnez	s2,80002816 <bmap+0x84>
      addr = balloc(ip->dev);
    800027fc:	4108                	lw	a0,0(a0)
    800027fe:	00000097          	auipc	ra,0x0
    80002802:	e50080e7          	jalr	-432(ra) # 8000264e <balloc>
    80002806:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000280a:	fa0909e3          	beqz	s2,800027bc <bmap+0x2a>
    8000280e:	e852                	sd	s4,16(sp)
      ip->addrs[NDIRECT] = addr;
    80002810:	0729ae23          	sw	s2,124(s3)
    80002814:	a011                	j	80002818 <bmap+0x86>
    80002816:	e852                	sd	s4,16(sp)
    bp = bread(ip->dev, addr);
    80002818:	85ca                	mv	a1,s2
    8000281a:	0009a503          	lw	a0,0(s3)
    8000281e:	00000097          	auipc	ra,0x0
    80002822:	b70080e7          	jalr	-1168(ra) # 8000238e <bread>
    80002826:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002828:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000282c:	02049713          	slli	a4,s1,0x20
    80002830:	01e75493          	srli	s1,a4,0x1e
    80002834:	94be                	add	s1,s1,a5
    80002836:	0004a903          	lw	s2,0(s1)
    8000283a:	00090963          	beqz	s2,8000284c <bmap+0xba>
    brelse(bp);
    8000283e:	8552                	mv	a0,s4
    80002840:	00000097          	auipc	ra,0x0
    80002844:	c7e080e7          	jalr	-898(ra) # 800024be <brelse>
    return addr;
    80002848:	6a42                	ld	s4,16(sp)
    8000284a:	bf8d                	j	800027bc <bmap+0x2a>
      addr = balloc(ip->dev);
    8000284c:	0009a503          	lw	a0,0(s3)
    80002850:	00000097          	auipc	ra,0x0
    80002854:	dfe080e7          	jalr	-514(ra) # 8000264e <balloc>
    80002858:	0005091b          	sext.w	s2,a0
      if(addr){
    8000285c:	fe0901e3          	beqz	s2,8000283e <bmap+0xac>
        a[bn] = addr;
    80002860:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002864:	8552                	mv	a0,s4
    80002866:	00001097          	auipc	ra,0x1
    8000286a:	08c080e7          	jalr	140(ra) # 800038f2 <log_write>
    8000286e:	bfc1                	j	8000283e <bmap+0xac>
  bn -= NINDIRECT;
    80002870:	ef55849b          	addiw	s1,a1,-267
    80002874:	0004871b          	sext.w	a4,s1
  if(bn < NDINDIRECT){
    80002878:	67c1                	lui	a5,0x10
    8000287a:	0cf77963          	bgeu	a4,a5,8000294c <bmap+0x1ba>
    if((addr = ip->addrs[NDIRECT + 1]) == 0){
    8000287e:	08052903          	lw	s2,128(a0)
    80002882:	02091063          	bnez	s2,800028a2 <bmap+0x110>
      addr = balloc(ip->dev);
    80002886:	4108                	lw	a0,0(a0)
    80002888:	00000097          	auipc	ra,0x0
    8000288c:	dc6080e7          	jalr	-570(ra) # 8000264e <balloc>
    80002890:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002894:	f20904e3          	beqz	s2,800027bc <bmap+0x2a>
    80002898:	e852                	sd	s4,16(sp)
    8000289a:	e456                	sd	s5,8(sp)
      ip->addrs[NDIRECT + 1] = addr;
    8000289c:	0929a023          	sw	s2,128(s3)
    800028a0:	a019                	j	800028a6 <bmap+0x114>
    800028a2:	e852                	sd	s4,16(sp)
    800028a4:	e456                	sd	s5,8(sp)
    bp = bread(ip->dev, addr);
    800028a6:	85ca                	mv	a1,s2
    800028a8:	0009a503          	lw	a0,0(s3)
    800028ac:	00000097          	auipc	ra,0x0
    800028b0:	ae2080e7          	jalr	-1310(ra) # 8000238e <bread>
    800028b4:	892a                	mv	s2,a0
    uint second = bn % NINDIRECT; // Eg. bn = 500. 500 % 256 = 244. Use index 244 Block
    800028b6:	0ff4fa93          	zext.b	s5,s1
    a = (uint*)bp->data;
    800028ba:	05850a13          	addi	s4,a0,88
    if((addr = a[first]) == 0){
    800028be:	0084d59b          	srliw	a1,s1,0x8
    800028c2:	058a                	slli	a1,a1,0x2
    800028c4:	9a2e                	add	s4,s4,a1
    800028c6:	000a2483          	lw	s1,0(s4) # 2000 <_entry-0x7fffe000>
    800028ca:	cc95                	beqz	s1,80002906 <bmap+0x174>
    brelse(bp);
    800028cc:	854a                	mv	a0,s2
    800028ce:	00000097          	auipc	ra,0x0
    800028d2:	bf0080e7          	jalr	-1040(ra) # 800024be <brelse>
    bp = bread(ip->dev, addr);
    800028d6:	85a6                	mv	a1,s1
    800028d8:	0009a503          	lw	a0,0(s3)
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	ab2080e7          	jalr	-1358(ra) # 8000238e <bread>
    800028e4:	84aa                	mv	s1,a0
    a = (uint*)bp->data;
    800028e6:	05850a13          	addi	s4,a0,88
    if((addr = a[second]) == 0){
    800028ea:	0a8a                	slli	s5,s5,0x2
    800028ec:	9a56                	add	s4,s4,s5
    800028ee:	000a2903          	lw	s2,0(s4)
    800028f2:	02090b63          	beqz	s2,80002928 <bmap+0x196>
    brelse(bp);
    800028f6:	8526                	mv	a0,s1
    800028f8:	00000097          	auipc	ra,0x0
    800028fc:	bc6080e7          	jalr	-1082(ra) # 800024be <brelse>
    return addr;
    80002900:	6a42                	ld	s4,16(sp)
    80002902:	6aa2                	ld	s5,8(sp)
    80002904:	bd65                	j	800027bc <bmap+0x2a>
      addr = balloc(ip->dev);
    80002906:	0009a503          	lw	a0,0(s3)
    8000290a:	00000097          	auipc	ra,0x0
    8000290e:	d44080e7          	jalr	-700(ra) # 8000264e <balloc>
    80002912:	0005049b          	sext.w	s1,a0
      if(addr){
    80002916:	d8dd                	beqz	s1,800028cc <bmap+0x13a>
        a[first] = addr;
    80002918:	009a2023          	sw	s1,0(s4)
        log_write(bp);
    8000291c:	854a                	mv	a0,s2
    8000291e:	00001097          	auipc	ra,0x1
    80002922:	fd4080e7          	jalr	-44(ra) # 800038f2 <log_write>
    80002926:	b75d                	j	800028cc <bmap+0x13a>
      addr = balloc(ip->dev);
    80002928:	0009a503          	lw	a0,0(s3)
    8000292c:	00000097          	auipc	ra,0x0
    80002930:	d22080e7          	jalr	-734(ra) # 8000264e <balloc>
    80002934:	0005091b          	sext.w	s2,a0
      if(addr){
    80002938:	fa090fe3          	beqz	s2,800028f6 <bmap+0x164>
        a[second] = addr;
    8000293c:	012a2023          	sw	s2,0(s4)
        log_write(bp);
    80002940:	8526                	mv	a0,s1
    80002942:	00001097          	auipc	ra,0x1
    80002946:	fb0080e7          	jalr	-80(ra) # 800038f2 <log_write>
    8000294a:	b775                	j	800028f6 <bmap+0x164>
    8000294c:	e852                	sd	s4,16(sp)
    8000294e:	e456                	sd	s5,8(sp)
  panic("bmap: out of range");
    80002950:	00006517          	auipc	a0,0x6
    80002954:	ae050513          	addi	a0,a0,-1312 # 80008430 <etext+0x430>
    80002958:	00003097          	auipc	ra,0x3
    8000295c:	5ba080e7          	jalr	1466(ra) # 80005f12 <panic>

0000000080002960 <iget>:
{
    80002960:	7179                	addi	sp,sp,-48
    80002962:	f406                	sd	ra,40(sp)
    80002964:	f022                	sd	s0,32(sp)
    80002966:	ec26                	sd	s1,24(sp)
    80002968:	e84a                	sd	s2,16(sp)
    8000296a:	e44e                	sd	s3,8(sp)
    8000296c:	e052                	sd	s4,0(sp)
    8000296e:	1800                	addi	s0,sp,48
    80002970:	89aa                	mv	s3,a0
    80002972:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002974:	00017517          	auipc	a0,0x17
    80002978:	e1450513          	addi	a0,a0,-492 # 80019788 <itable>
    8000297c:	00004097          	auipc	ra,0x4
    80002980:	b10080e7          	jalr	-1264(ra) # 8000648c <acquire>
  empty = 0;
    80002984:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002986:	00017497          	auipc	s1,0x17
    8000298a:	e1a48493          	addi	s1,s1,-486 # 800197a0 <itable+0x18>
    8000298e:	00019697          	auipc	a3,0x19
    80002992:	8a268693          	addi	a3,a3,-1886 # 8001b230 <log>
    80002996:	a039                	j	800029a4 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002998:	02090b63          	beqz	s2,800029ce <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000299c:	08848493          	addi	s1,s1,136
    800029a0:	02d48a63          	beq	s1,a3,800029d4 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800029a4:	449c                	lw	a5,8(s1)
    800029a6:	fef059e3          	blez	a5,80002998 <iget+0x38>
    800029aa:	4098                	lw	a4,0(s1)
    800029ac:	ff3716e3          	bne	a4,s3,80002998 <iget+0x38>
    800029b0:	40d8                	lw	a4,4(s1)
    800029b2:	ff4713e3          	bne	a4,s4,80002998 <iget+0x38>
      ip->ref++;
    800029b6:	2785                	addiw	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    800029b8:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800029ba:	00017517          	auipc	a0,0x17
    800029be:	dce50513          	addi	a0,a0,-562 # 80019788 <itable>
    800029c2:	00004097          	auipc	ra,0x4
    800029c6:	b7e080e7          	jalr	-1154(ra) # 80006540 <release>
      return ip;
    800029ca:	8926                	mv	s2,s1
    800029cc:	a03d                	j	800029fa <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800029ce:	f7f9                	bnez	a5,8000299c <iget+0x3c>
      empty = ip;
    800029d0:	8926                	mv	s2,s1
    800029d2:	b7e9                	j	8000299c <iget+0x3c>
  if(empty == 0)
    800029d4:	02090c63          	beqz	s2,80002a0c <iget+0xac>
  ip->dev = dev;
    800029d8:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800029dc:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800029e0:	4785                	li	a5,1
    800029e2:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800029e6:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800029ea:	00017517          	auipc	a0,0x17
    800029ee:	d9e50513          	addi	a0,a0,-610 # 80019788 <itable>
    800029f2:	00004097          	auipc	ra,0x4
    800029f6:	b4e080e7          	jalr	-1202(ra) # 80006540 <release>
}
    800029fa:	854a                	mv	a0,s2
    800029fc:	70a2                	ld	ra,40(sp)
    800029fe:	7402                	ld	s0,32(sp)
    80002a00:	64e2                	ld	s1,24(sp)
    80002a02:	6942                	ld	s2,16(sp)
    80002a04:	69a2                	ld	s3,8(sp)
    80002a06:	6a02                	ld	s4,0(sp)
    80002a08:	6145                	addi	sp,sp,48
    80002a0a:	8082                	ret
    panic("iget: no inodes");
    80002a0c:	00006517          	auipc	a0,0x6
    80002a10:	a3c50513          	addi	a0,a0,-1476 # 80008448 <etext+0x448>
    80002a14:	00003097          	auipc	ra,0x3
    80002a18:	4fe080e7          	jalr	1278(ra) # 80005f12 <panic>

0000000080002a1c <fsinit>:
fsinit(int dev) {
    80002a1c:	7179                	addi	sp,sp,-48
    80002a1e:	f406                	sd	ra,40(sp)
    80002a20:	f022                	sd	s0,32(sp)
    80002a22:	ec26                	sd	s1,24(sp)
    80002a24:	e84a                	sd	s2,16(sp)
    80002a26:	e44e                	sd	s3,8(sp)
    80002a28:	1800                	addi	s0,sp,48
    80002a2a:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002a2c:	4585                	li	a1,1
    80002a2e:	00000097          	auipc	ra,0x0
    80002a32:	960080e7          	jalr	-1696(ra) # 8000238e <bread>
    80002a36:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002a38:	00017997          	auipc	s3,0x17
    80002a3c:	d3098993          	addi	s3,s3,-720 # 80019768 <sb>
    80002a40:	02000613          	li	a2,32
    80002a44:	05850593          	addi	a1,a0,88
    80002a48:	854e                	mv	a0,s3
    80002a4a:	ffffd097          	auipc	ra,0xffffd
    80002a4e:	78c080e7          	jalr	1932(ra) # 800001d6 <memmove>
  brelse(bp);
    80002a52:	8526                	mv	a0,s1
    80002a54:	00000097          	auipc	ra,0x0
    80002a58:	a6a080e7          	jalr	-1430(ra) # 800024be <brelse>
  if(sb.magic != FSMAGIC)
    80002a5c:	0009a703          	lw	a4,0(s3)
    80002a60:	102037b7          	lui	a5,0x10203
    80002a64:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002a68:	02f71263          	bne	a4,a5,80002a8c <fsinit+0x70>
  initlog(dev, &sb);
    80002a6c:	00017597          	auipc	a1,0x17
    80002a70:	cfc58593          	addi	a1,a1,-772 # 80019768 <sb>
    80002a74:	854a                	mv	a0,s2
    80002a76:	00001097          	auipc	ra,0x1
    80002a7a:	c0c080e7          	jalr	-1012(ra) # 80003682 <initlog>
}
    80002a7e:	70a2                	ld	ra,40(sp)
    80002a80:	7402                	ld	s0,32(sp)
    80002a82:	64e2                	ld	s1,24(sp)
    80002a84:	6942                	ld	s2,16(sp)
    80002a86:	69a2                	ld	s3,8(sp)
    80002a88:	6145                	addi	sp,sp,48
    80002a8a:	8082                	ret
    panic("invalid file system");
    80002a8c:	00006517          	auipc	a0,0x6
    80002a90:	9cc50513          	addi	a0,a0,-1588 # 80008458 <etext+0x458>
    80002a94:	00003097          	auipc	ra,0x3
    80002a98:	47e080e7          	jalr	1150(ra) # 80005f12 <panic>

0000000080002a9c <iinit>:
{
    80002a9c:	7179                	addi	sp,sp,-48
    80002a9e:	f406                	sd	ra,40(sp)
    80002aa0:	f022                	sd	s0,32(sp)
    80002aa2:	ec26                	sd	s1,24(sp)
    80002aa4:	e84a                	sd	s2,16(sp)
    80002aa6:	e44e                	sd	s3,8(sp)
    80002aa8:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002aaa:	00006597          	auipc	a1,0x6
    80002aae:	9c658593          	addi	a1,a1,-1594 # 80008470 <etext+0x470>
    80002ab2:	00017517          	auipc	a0,0x17
    80002ab6:	cd650513          	addi	a0,a0,-810 # 80019788 <itable>
    80002aba:	00004097          	auipc	ra,0x4
    80002abe:	942080e7          	jalr	-1726(ra) # 800063fc <initlock>
  for(i = 0; i < NINODE; i++) {
    80002ac2:	00017497          	auipc	s1,0x17
    80002ac6:	cee48493          	addi	s1,s1,-786 # 800197b0 <itable+0x28>
    80002aca:	00018997          	auipc	s3,0x18
    80002ace:	77698993          	addi	s3,s3,1910 # 8001b240 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002ad2:	00006917          	auipc	s2,0x6
    80002ad6:	9a690913          	addi	s2,s2,-1626 # 80008478 <etext+0x478>
    80002ada:	85ca                	mv	a1,s2
    80002adc:	8526                	mv	a0,s1
    80002ade:	00001097          	auipc	ra,0x1
    80002ae2:	ef8080e7          	jalr	-264(ra) # 800039d6 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002ae6:	08848493          	addi	s1,s1,136
    80002aea:	ff3498e3          	bne	s1,s3,80002ada <iinit+0x3e>
}
    80002aee:	70a2                	ld	ra,40(sp)
    80002af0:	7402                	ld	s0,32(sp)
    80002af2:	64e2                	ld	s1,24(sp)
    80002af4:	6942                	ld	s2,16(sp)
    80002af6:	69a2                	ld	s3,8(sp)
    80002af8:	6145                	addi	sp,sp,48
    80002afa:	8082                	ret

0000000080002afc <ialloc>:
{
    80002afc:	7139                	addi	sp,sp,-64
    80002afe:	fc06                	sd	ra,56(sp)
    80002b00:	f822                	sd	s0,48(sp)
    80002b02:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b04:	00017717          	auipc	a4,0x17
    80002b08:	c7072703          	lw	a4,-912(a4) # 80019774 <sb+0xc>
    80002b0c:	4785                	li	a5,1
    80002b0e:	06e7f463          	bgeu	a5,a4,80002b76 <ialloc+0x7a>
    80002b12:	f426                	sd	s1,40(sp)
    80002b14:	f04a                	sd	s2,32(sp)
    80002b16:	ec4e                	sd	s3,24(sp)
    80002b18:	e852                	sd	s4,16(sp)
    80002b1a:	e456                	sd	s5,8(sp)
    80002b1c:	e05a                	sd	s6,0(sp)
    80002b1e:	8aaa                	mv	s5,a0
    80002b20:	8b2e                	mv	s6,a1
    80002b22:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002b24:	00017a17          	auipc	s4,0x17
    80002b28:	c44a0a13          	addi	s4,s4,-956 # 80019768 <sb>
    80002b2c:	00495593          	srli	a1,s2,0x4
    80002b30:	018a2783          	lw	a5,24(s4)
    80002b34:	9dbd                	addw	a1,a1,a5
    80002b36:	8556                	mv	a0,s5
    80002b38:	00000097          	auipc	ra,0x0
    80002b3c:	856080e7          	jalr	-1962(ra) # 8000238e <bread>
    80002b40:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002b42:	05850993          	addi	s3,a0,88
    80002b46:	00f97793          	andi	a5,s2,15
    80002b4a:	079a                	slli	a5,a5,0x6
    80002b4c:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002b4e:	00099783          	lh	a5,0(s3)
    80002b52:	cf9d                	beqz	a5,80002b90 <ialloc+0x94>
    brelse(bp);
    80002b54:	00000097          	auipc	ra,0x0
    80002b58:	96a080e7          	jalr	-1686(ra) # 800024be <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b5c:	0905                	addi	s2,s2,1
    80002b5e:	00ca2703          	lw	a4,12(s4)
    80002b62:	0009079b          	sext.w	a5,s2
    80002b66:	fce7e3e3          	bltu	a5,a4,80002b2c <ialloc+0x30>
    80002b6a:	74a2                	ld	s1,40(sp)
    80002b6c:	7902                	ld	s2,32(sp)
    80002b6e:	69e2                	ld	s3,24(sp)
    80002b70:	6a42                	ld	s4,16(sp)
    80002b72:	6aa2                	ld	s5,8(sp)
    80002b74:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    80002b76:	00006517          	auipc	a0,0x6
    80002b7a:	90a50513          	addi	a0,a0,-1782 # 80008480 <etext+0x480>
    80002b7e:	00003097          	auipc	ra,0x3
    80002b82:	3de080e7          	jalr	990(ra) # 80005f5c <printf>
  return 0;
    80002b86:	4501                	li	a0,0
}
    80002b88:	70e2                	ld	ra,56(sp)
    80002b8a:	7442                	ld	s0,48(sp)
    80002b8c:	6121                	addi	sp,sp,64
    80002b8e:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002b90:	04000613          	li	a2,64
    80002b94:	4581                	li	a1,0
    80002b96:	854e                	mv	a0,s3
    80002b98:	ffffd097          	auipc	ra,0xffffd
    80002b9c:	5e2080e7          	jalr	1506(ra) # 8000017a <memset>
      dip->type = type;
    80002ba0:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002ba4:	8526                	mv	a0,s1
    80002ba6:	00001097          	auipc	ra,0x1
    80002baa:	d4c080e7          	jalr	-692(ra) # 800038f2 <log_write>
      brelse(bp);
    80002bae:	8526                	mv	a0,s1
    80002bb0:	00000097          	auipc	ra,0x0
    80002bb4:	90e080e7          	jalr	-1778(ra) # 800024be <brelse>
      return iget(dev, inum);
    80002bb8:	0009059b          	sext.w	a1,s2
    80002bbc:	8556                	mv	a0,s5
    80002bbe:	00000097          	auipc	ra,0x0
    80002bc2:	da2080e7          	jalr	-606(ra) # 80002960 <iget>
    80002bc6:	74a2                	ld	s1,40(sp)
    80002bc8:	7902                	ld	s2,32(sp)
    80002bca:	69e2                	ld	s3,24(sp)
    80002bcc:	6a42                	ld	s4,16(sp)
    80002bce:	6aa2                	ld	s5,8(sp)
    80002bd0:	6b02                	ld	s6,0(sp)
    80002bd2:	bf5d                	j	80002b88 <ialloc+0x8c>

0000000080002bd4 <iupdate>:
{
    80002bd4:	1101                	addi	sp,sp,-32
    80002bd6:	ec06                	sd	ra,24(sp)
    80002bd8:	e822                	sd	s0,16(sp)
    80002bda:	e426                	sd	s1,8(sp)
    80002bdc:	e04a                	sd	s2,0(sp)
    80002bde:	1000                	addi	s0,sp,32
    80002be0:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002be2:	415c                	lw	a5,4(a0)
    80002be4:	0047d79b          	srliw	a5,a5,0x4
    80002be8:	00017597          	auipc	a1,0x17
    80002bec:	b985a583          	lw	a1,-1128(a1) # 80019780 <sb+0x18>
    80002bf0:	9dbd                	addw	a1,a1,a5
    80002bf2:	4108                	lw	a0,0(a0)
    80002bf4:	fffff097          	auipc	ra,0xfffff
    80002bf8:	79a080e7          	jalr	1946(ra) # 8000238e <bread>
    80002bfc:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002bfe:	05850793          	addi	a5,a0,88
    80002c02:	40d8                	lw	a4,4(s1)
    80002c04:	8b3d                	andi	a4,a4,15
    80002c06:	071a                	slli	a4,a4,0x6
    80002c08:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002c0a:	04449703          	lh	a4,68(s1)
    80002c0e:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002c12:	04649703          	lh	a4,70(s1)
    80002c16:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002c1a:	04849703          	lh	a4,72(s1)
    80002c1e:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002c22:	04a49703          	lh	a4,74(s1)
    80002c26:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002c2a:	44f8                	lw	a4,76(s1)
    80002c2c:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002c2e:	03400613          	li	a2,52
    80002c32:	05048593          	addi	a1,s1,80
    80002c36:	00c78513          	addi	a0,a5,12
    80002c3a:	ffffd097          	auipc	ra,0xffffd
    80002c3e:	59c080e7          	jalr	1436(ra) # 800001d6 <memmove>
  log_write(bp);
    80002c42:	854a                	mv	a0,s2
    80002c44:	00001097          	auipc	ra,0x1
    80002c48:	cae080e7          	jalr	-850(ra) # 800038f2 <log_write>
  brelse(bp);
    80002c4c:	854a                	mv	a0,s2
    80002c4e:	00000097          	auipc	ra,0x0
    80002c52:	870080e7          	jalr	-1936(ra) # 800024be <brelse>
}
    80002c56:	60e2                	ld	ra,24(sp)
    80002c58:	6442                	ld	s0,16(sp)
    80002c5a:	64a2                	ld	s1,8(sp)
    80002c5c:	6902                	ld	s2,0(sp)
    80002c5e:	6105                	addi	sp,sp,32
    80002c60:	8082                	ret

0000000080002c62 <idup>:
{
    80002c62:	1101                	addi	sp,sp,-32
    80002c64:	ec06                	sd	ra,24(sp)
    80002c66:	e822                	sd	s0,16(sp)
    80002c68:	e426                	sd	s1,8(sp)
    80002c6a:	1000                	addi	s0,sp,32
    80002c6c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c6e:	00017517          	auipc	a0,0x17
    80002c72:	b1a50513          	addi	a0,a0,-1254 # 80019788 <itable>
    80002c76:	00004097          	auipc	ra,0x4
    80002c7a:	816080e7          	jalr	-2026(ra) # 8000648c <acquire>
  ip->ref++;
    80002c7e:	449c                	lw	a5,8(s1)
    80002c80:	2785                	addiw	a5,a5,1
    80002c82:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002c84:	00017517          	auipc	a0,0x17
    80002c88:	b0450513          	addi	a0,a0,-1276 # 80019788 <itable>
    80002c8c:	00004097          	auipc	ra,0x4
    80002c90:	8b4080e7          	jalr	-1868(ra) # 80006540 <release>
}
    80002c94:	8526                	mv	a0,s1
    80002c96:	60e2                	ld	ra,24(sp)
    80002c98:	6442                	ld	s0,16(sp)
    80002c9a:	64a2                	ld	s1,8(sp)
    80002c9c:	6105                	addi	sp,sp,32
    80002c9e:	8082                	ret

0000000080002ca0 <ilock>:
{
    80002ca0:	1101                	addi	sp,sp,-32
    80002ca2:	ec06                	sd	ra,24(sp)
    80002ca4:	e822                	sd	s0,16(sp)
    80002ca6:	e426                	sd	s1,8(sp)
    80002ca8:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002caa:	c10d                	beqz	a0,80002ccc <ilock+0x2c>
    80002cac:	84aa                	mv	s1,a0
    80002cae:	451c                	lw	a5,8(a0)
    80002cb0:	00f05e63          	blez	a5,80002ccc <ilock+0x2c>
  acquiresleep(&ip->lock);
    80002cb4:	0541                	addi	a0,a0,16
    80002cb6:	00001097          	auipc	ra,0x1
    80002cba:	d5a080e7          	jalr	-678(ra) # 80003a10 <acquiresleep>
  if(ip->valid == 0){
    80002cbe:	40bc                	lw	a5,64(s1)
    80002cc0:	cf99                	beqz	a5,80002cde <ilock+0x3e>
}
    80002cc2:	60e2                	ld	ra,24(sp)
    80002cc4:	6442                	ld	s0,16(sp)
    80002cc6:	64a2                	ld	s1,8(sp)
    80002cc8:	6105                	addi	sp,sp,32
    80002cca:	8082                	ret
    80002ccc:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002cce:	00005517          	auipc	a0,0x5
    80002cd2:	7ca50513          	addi	a0,a0,1994 # 80008498 <etext+0x498>
    80002cd6:	00003097          	auipc	ra,0x3
    80002cda:	23c080e7          	jalr	572(ra) # 80005f12 <panic>
    80002cde:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002ce0:	40dc                	lw	a5,4(s1)
    80002ce2:	0047d79b          	srliw	a5,a5,0x4
    80002ce6:	00017597          	auipc	a1,0x17
    80002cea:	a9a5a583          	lw	a1,-1382(a1) # 80019780 <sb+0x18>
    80002cee:	9dbd                	addw	a1,a1,a5
    80002cf0:	4088                	lw	a0,0(s1)
    80002cf2:	fffff097          	auipc	ra,0xfffff
    80002cf6:	69c080e7          	jalr	1692(ra) # 8000238e <bread>
    80002cfa:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002cfc:	05850593          	addi	a1,a0,88
    80002d00:	40dc                	lw	a5,4(s1)
    80002d02:	8bbd                	andi	a5,a5,15
    80002d04:	079a                	slli	a5,a5,0x6
    80002d06:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002d08:	00059783          	lh	a5,0(a1)
    80002d0c:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002d10:	00259783          	lh	a5,2(a1)
    80002d14:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002d18:	00459783          	lh	a5,4(a1)
    80002d1c:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002d20:	00659783          	lh	a5,6(a1)
    80002d24:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002d28:	459c                	lw	a5,8(a1)
    80002d2a:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002d2c:	03400613          	li	a2,52
    80002d30:	05b1                	addi	a1,a1,12
    80002d32:	05048513          	addi	a0,s1,80
    80002d36:	ffffd097          	auipc	ra,0xffffd
    80002d3a:	4a0080e7          	jalr	1184(ra) # 800001d6 <memmove>
    brelse(bp);
    80002d3e:	854a                	mv	a0,s2
    80002d40:	fffff097          	auipc	ra,0xfffff
    80002d44:	77e080e7          	jalr	1918(ra) # 800024be <brelse>
    ip->valid = 1;
    80002d48:	4785                	li	a5,1
    80002d4a:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002d4c:	04449783          	lh	a5,68(s1)
    80002d50:	c399                	beqz	a5,80002d56 <ilock+0xb6>
    80002d52:	6902                	ld	s2,0(sp)
    80002d54:	b7bd                	j	80002cc2 <ilock+0x22>
      panic("ilock: no type");
    80002d56:	00005517          	auipc	a0,0x5
    80002d5a:	74a50513          	addi	a0,a0,1866 # 800084a0 <etext+0x4a0>
    80002d5e:	00003097          	auipc	ra,0x3
    80002d62:	1b4080e7          	jalr	436(ra) # 80005f12 <panic>

0000000080002d66 <iunlock>:
{
    80002d66:	1101                	addi	sp,sp,-32
    80002d68:	ec06                	sd	ra,24(sp)
    80002d6a:	e822                	sd	s0,16(sp)
    80002d6c:	e426                	sd	s1,8(sp)
    80002d6e:	e04a                	sd	s2,0(sp)
    80002d70:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002d72:	c905                	beqz	a0,80002da2 <iunlock+0x3c>
    80002d74:	84aa                	mv	s1,a0
    80002d76:	01050913          	addi	s2,a0,16
    80002d7a:	854a                	mv	a0,s2
    80002d7c:	00001097          	auipc	ra,0x1
    80002d80:	d2e080e7          	jalr	-722(ra) # 80003aaa <holdingsleep>
    80002d84:	cd19                	beqz	a0,80002da2 <iunlock+0x3c>
    80002d86:	449c                	lw	a5,8(s1)
    80002d88:	00f05d63          	blez	a5,80002da2 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002d8c:	854a                	mv	a0,s2
    80002d8e:	00001097          	auipc	ra,0x1
    80002d92:	cd8080e7          	jalr	-808(ra) # 80003a66 <releasesleep>
}
    80002d96:	60e2                	ld	ra,24(sp)
    80002d98:	6442                	ld	s0,16(sp)
    80002d9a:	64a2                	ld	s1,8(sp)
    80002d9c:	6902                	ld	s2,0(sp)
    80002d9e:	6105                	addi	sp,sp,32
    80002da0:	8082                	ret
    panic("iunlock");
    80002da2:	00005517          	auipc	a0,0x5
    80002da6:	70e50513          	addi	a0,a0,1806 # 800084b0 <etext+0x4b0>
    80002daa:	00003097          	auipc	ra,0x3
    80002dae:	168080e7          	jalr	360(ra) # 80005f12 <panic>

0000000080002db2 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002db2:	715d                	addi	sp,sp,-80
    80002db4:	e486                	sd	ra,72(sp)
    80002db6:	e0a2                	sd	s0,64(sp)
    80002db8:	fc26                	sd	s1,56(sp)
    80002dba:	f84a                	sd	s2,48(sp)
    80002dbc:	f44e                	sd	s3,40(sp)
    80002dbe:	0880                	addi	s0,sp,80
    80002dc0:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002dc2:	05050493          	addi	s1,a0,80
    80002dc6:	07c50913          	addi	s2,a0,124
    80002dca:	a021                	j	80002dd2 <itrunc+0x20>
    80002dcc:	0491                	addi	s1,s1,4
    80002dce:	01248d63          	beq	s1,s2,80002de8 <itrunc+0x36>
    if(ip->addrs[i]){
    80002dd2:	408c                	lw	a1,0(s1)
    80002dd4:	dde5                	beqz	a1,80002dcc <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002dd6:	0009a503          	lw	a0,0(s3)
    80002dda:	fffff097          	auipc	ra,0xfffff
    80002dde:	7f8080e7          	jalr	2040(ra) # 800025d2 <bfree>
      ip->addrs[i] = 0;
    80002de2:	0004a023          	sw	zero,0(s1)
    80002de6:	b7dd                	j	80002dcc <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002de8:	07c9a583          	lw	a1,124(s3)
    80002dec:	e195                	bnez	a1,80002e10 <itrunc+0x5e>
  */

  // NDIRECT is 11 and the Double Indirect is in index 12
  // Check if Index 12 In the Inode Contains the Address of the Block.
  // If it does, complete the clearing logic
  if(ip->addrs[NDIRECT + 1]){
    80002dee:	0809a583          	lw	a1,128(s3)
    80002df2:	e9ad                	bnez	a1,80002e64 <itrunc+0xb2>

    // Clear the inode by setting the index of the array to 0
    ip->addrs[NDIRECT + 1] = 0;
  }

  ip->size = 0;
    80002df4:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002df8:	854e                	mv	a0,s3
    80002dfa:	00000097          	auipc	ra,0x0
    80002dfe:	dda080e7          	jalr	-550(ra) # 80002bd4 <iupdate>
}
    80002e02:	60a6                	ld	ra,72(sp)
    80002e04:	6406                	ld	s0,64(sp)
    80002e06:	74e2                	ld	s1,56(sp)
    80002e08:	7942                	ld	s2,48(sp)
    80002e0a:	79a2                	ld	s3,40(sp)
    80002e0c:	6161                	addi	sp,sp,80
    80002e0e:	8082                	ret
    80002e10:	f052                	sd	s4,32(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002e12:	0009a503          	lw	a0,0(s3)
    80002e16:	fffff097          	auipc	ra,0xfffff
    80002e1a:	578080e7          	jalr	1400(ra) # 8000238e <bread>
    80002e1e:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002e20:	05850493          	addi	s1,a0,88
    80002e24:	45850913          	addi	s2,a0,1112
    80002e28:	a021                	j	80002e30 <itrunc+0x7e>
    80002e2a:	0491                	addi	s1,s1,4
    80002e2c:	01248b63          	beq	s1,s2,80002e42 <itrunc+0x90>
      if(a[j])
    80002e30:	408c                	lw	a1,0(s1)
    80002e32:	dde5                	beqz	a1,80002e2a <itrunc+0x78>
        bfree(ip->dev, a[j]);
    80002e34:	0009a503          	lw	a0,0(s3)
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	79a080e7          	jalr	1946(ra) # 800025d2 <bfree>
    80002e40:	b7ed                	j	80002e2a <itrunc+0x78>
    brelse(bp);
    80002e42:	8552                	mv	a0,s4
    80002e44:	fffff097          	auipc	ra,0xfffff
    80002e48:	67a080e7          	jalr	1658(ra) # 800024be <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002e4c:	07c9a583          	lw	a1,124(s3)
    80002e50:	0009a503          	lw	a0,0(s3)
    80002e54:	fffff097          	auipc	ra,0xfffff
    80002e58:	77e080e7          	jalr	1918(ra) # 800025d2 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002e5c:	0609ae23          	sw	zero,124(s3)
    80002e60:	7a02                	ld	s4,32(sp)
    80002e62:	b771                	j	80002dee <itrunc+0x3c>
    80002e64:	f052                	sd	s4,32(sp)
    80002e66:	ec56                	sd	s5,24(sp)
    80002e68:	e85a                	sd	s6,16(sp)
    80002e6a:	e45e                	sd	s7,8(sp)
    80002e6c:	e062                	sd	s8,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT + 1]);
    80002e6e:	0009a503          	lw	a0,0(s3)
    80002e72:	fffff097          	auipc	ra,0xfffff
    80002e76:	51c080e7          	jalr	1308(ra) # 8000238e <bread>
    80002e7a:	8c2a                	mv	s8,a0
    for(int i = 0; i < NINDIRECT; i++){
    80002e7c:	05850a13          	addi	s4,a0,88
    80002e80:	45850b13          	addi	s6,a0,1112
    80002e84:	a82d                	j	80002ebe <itrunc+0x10c>
        for(int j = 0; j < NINDIRECT; j++){
    80002e86:	0491                	addi	s1,s1,4
    80002e88:	01248b63          	beq	s1,s2,80002e9e <itrunc+0xec>
          if(a2[j])
    80002e8c:	408c                	lw	a1,0(s1)
    80002e8e:	dde5                	beqz	a1,80002e86 <itrunc+0xd4>
            bfree(ip->dev, a2[j]);
    80002e90:	0009a503          	lw	a0,0(s3)
    80002e94:	fffff097          	auipc	ra,0xfffff
    80002e98:	73e080e7          	jalr	1854(ra) # 800025d2 <bfree>
    80002e9c:	b7ed                	j	80002e86 <itrunc+0xd4>
        brelse(bp2);
    80002e9e:	855e                	mv	a0,s7
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	61e080e7          	jalr	1566(ra) # 800024be <brelse>
        bfree(ip->dev, a[i]);
    80002ea8:	000aa583          	lw	a1,0(s5)
    80002eac:	0009a503          	lw	a0,0(s3)
    80002eb0:	fffff097          	auipc	ra,0xfffff
    80002eb4:	722080e7          	jalr	1826(ra) # 800025d2 <bfree>
    for(int i = 0; i < NINDIRECT; i++){
    80002eb8:	0a11                	addi	s4,s4,4
    80002eba:	036a0263          	beq	s4,s6,80002ede <itrunc+0x12c>
      if(a[i]){
    80002ebe:	8ad2                	mv	s5,s4
    80002ec0:	000a2583          	lw	a1,0(s4)
    80002ec4:	d9f5                	beqz	a1,80002eb8 <itrunc+0x106>
        struct buf *bp2 = bread(ip->dev, a[i]);
    80002ec6:	0009a503          	lw	a0,0(s3)
    80002eca:	fffff097          	auipc	ra,0xfffff
    80002ece:	4c4080e7          	jalr	1220(ra) # 8000238e <bread>
    80002ed2:	8baa                	mv	s7,a0
        for(int j = 0; j < NINDIRECT; j++){
    80002ed4:	05850493          	addi	s1,a0,88
    80002ed8:	45850913          	addi	s2,a0,1112
    80002edc:	bf45                	j	80002e8c <itrunc+0xda>
    brelse(bp);
    80002ede:	8562                	mv	a0,s8
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	5de080e7          	jalr	1502(ra) # 800024be <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT + 1]);
    80002ee8:	0809a583          	lw	a1,128(s3)
    80002eec:	0009a503          	lw	a0,0(s3)
    80002ef0:	fffff097          	auipc	ra,0xfffff
    80002ef4:	6e2080e7          	jalr	1762(ra) # 800025d2 <bfree>
    ip->addrs[NDIRECT + 1] = 0;
    80002ef8:	0809a023          	sw	zero,128(s3)
    80002efc:	7a02                	ld	s4,32(sp)
    80002efe:	6ae2                	ld	s5,24(sp)
    80002f00:	6b42                	ld	s6,16(sp)
    80002f02:	6ba2                	ld	s7,8(sp)
    80002f04:	6c02                	ld	s8,0(sp)
    80002f06:	b5fd                	j	80002df4 <itrunc+0x42>

0000000080002f08 <iput>:
{
    80002f08:	1101                	addi	sp,sp,-32
    80002f0a:	ec06                	sd	ra,24(sp)
    80002f0c:	e822                	sd	s0,16(sp)
    80002f0e:	e426                	sd	s1,8(sp)
    80002f10:	1000                	addi	s0,sp,32
    80002f12:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f14:	00017517          	auipc	a0,0x17
    80002f18:	87450513          	addi	a0,a0,-1932 # 80019788 <itable>
    80002f1c:	00003097          	auipc	ra,0x3
    80002f20:	570080e7          	jalr	1392(ra) # 8000648c <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f24:	4498                	lw	a4,8(s1)
    80002f26:	4785                	li	a5,1
    80002f28:	02f70263          	beq	a4,a5,80002f4c <iput+0x44>
  ip->ref--;
    80002f2c:	449c                	lw	a5,8(s1)
    80002f2e:	37fd                	addiw	a5,a5,-1
    80002f30:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002f32:	00017517          	auipc	a0,0x17
    80002f36:	85650513          	addi	a0,a0,-1962 # 80019788 <itable>
    80002f3a:	00003097          	auipc	ra,0x3
    80002f3e:	606080e7          	jalr	1542(ra) # 80006540 <release>
}
    80002f42:	60e2                	ld	ra,24(sp)
    80002f44:	6442                	ld	s0,16(sp)
    80002f46:	64a2                	ld	s1,8(sp)
    80002f48:	6105                	addi	sp,sp,32
    80002f4a:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f4c:	40bc                	lw	a5,64(s1)
    80002f4e:	dff9                	beqz	a5,80002f2c <iput+0x24>
    80002f50:	04a49783          	lh	a5,74(s1)
    80002f54:	ffe1                	bnez	a5,80002f2c <iput+0x24>
    80002f56:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002f58:	01048913          	addi	s2,s1,16
    80002f5c:	854a                	mv	a0,s2
    80002f5e:	00001097          	auipc	ra,0x1
    80002f62:	ab2080e7          	jalr	-1358(ra) # 80003a10 <acquiresleep>
    release(&itable.lock);
    80002f66:	00017517          	auipc	a0,0x17
    80002f6a:	82250513          	addi	a0,a0,-2014 # 80019788 <itable>
    80002f6e:	00003097          	auipc	ra,0x3
    80002f72:	5d2080e7          	jalr	1490(ra) # 80006540 <release>
    itrunc(ip);
    80002f76:	8526                	mv	a0,s1
    80002f78:	00000097          	auipc	ra,0x0
    80002f7c:	e3a080e7          	jalr	-454(ra) # 80002db2 <itrunc>
    ip->type = 0;
    80002f80:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002f84:	8526                	mv	a0,s1
    80002f86:	00000097          	auipc	ra,0x0
    80002f8a:	c4e080e7          	jalr	-946(ra) # 80002bd4 <iupdate>
    ip->valid = 0;
    80002f8e:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002f92:	854a                	mv	a0,s2
    80002f94:	00001097          	auipc	ra,0x1
    80002f98:	ad2080e7          	jalr	-1326(ra) # 80003a66 <releasesleep>
    acquire(&itable.lock);
    80002f9c:	00016517          	auipc	a0,0x16
    80002fa0:	7ec50513          	addi	a0,a0,2028 # 80019788 <itable>
    80002fa4:	00003097          	auipc	ra,0x3
    80002fa8:	4e8080e7          	jalr	1256(ra) # 8000648c <acquire>
    80002fac:	6902                	ld	s2,0(sp)
    80002fae:	bfbd                	j	80002f2c <iput+0x24>

0000000080002fb0 <iunlockput>:
{
    80002fb0:	1101                	addi	sp,sp,-32
    80002fb2:	ec06                	sd	ra,24(sp)
    80002fb4:	e822                	sd	s0,16(sp)
    80002fb6:	e426                	sd	s1,8(sp)
    80002fb8:	1000                	addi	s0,sp,32
    80002fba:	84aa                	mv	s1,a0
  iunlock(ip);
    80002fbc:	00000097          	auipc	ra,0x0
    80002fc0:	daa080e7          	jalr	-598(ra) # 80002d66 <iunlock>
  iput(ip);
    80002fc4:	8526                	mv	a0,s1
    80002fc6:	00000097          	auipc	ra,0x0
    80002fca:	f42080e7          	jalr	-190(ra) # 80002f08 <iput>
}
    80002fce:	60e2                	ld	ra,24(sp)
    80002fd0:	6442                	ld	s0,16(sp)
    80002fd2:	64a2                	ld	s1,8(sp)
    80002fd4:	6105                	addi	sp,sp,32
    80002fd6:	8082                	ret

0000000080002fd8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002fd8:	1141                	addi	sp,sp,-16
    80002fda:	e422                	sd	s0,8(sp)
    80002fdc:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002fde:	411c                	lw	a5,0(a0)
    80002fe0:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002fe2:	415c                	lw	a5,4(a0)
    80002fe4:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002fe6:	04451783          	lh	a5,68(a0)
    80002fea:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002fee:	04a51783          	lh	a5,74(a0)
    80002ff2:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002ff6:	04c56783          	lwu	a5,76(a0)
    80002ffa:	e99c                	sd	a5,16(a1)
}
    80002ffc:	6422                	ld	s0,8(sp)
    80002ffe:	0141                	addi	sp,sp,16
    80003000:	8082                	ret

0000000080003002 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003002:	457c                	lw	a5,76(a0)
    80003004:	10d7e563          	bltu	a5,a3,8000310e <readi+0x10c>
{
    80003008:	7159                	addi	sp,sp,-112
    8000300a:	f486                	sd	ra,104(sp)
    8000300c:	f0a2                	sd	s0,96(sp)
    8000300e:	eca6                	sd	s1,88(sp)
    80003010:	e0d2                	sd	s4,64(sp)
    80003012:	fc56                	sd	s5,56(sp)
    80003014:	f85a                	sd	s6,48(sp)
    80003016:	f45e                	sd	s7,40(sp)
    80003018:	1880                	addi	s0,sp,112
    8000301a:	8b2a                	mv	s6,a0
    8000301c:	8bae                	mv	s7,a1
    8000301e:	8a32                	mv	s4,a2
    80003020:	84b6                	mv	s1,a3
    80003022:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003024:	9f35                	addw	a4,a4,a3
    return 0;
    80003026:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003028:	0cd76a63          	bltu	a4,a3,800030fc <readi+0xfa>
    8000302c:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    8000302e:	00e7f463          	bgeu	a5,a4,80003036 <readi+0x34>
    n = ip->size - off;
    80003032:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003036:	0a0a8963          	beqz	s5,800030e8 <readi+0xe6>
    8000303a:	e8ca                	sd	s2,80(sp)
    8000303c:	f062                	sd	s8,32(sp)
    8000303e:	ec66                	sd	s9,24(sp)
    80003040:	e86a                	sd	s10,16(sp)
    80003042:	e46e                	sd	s11,8(sp)
    80003044:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003046:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000304a:	5c7d                	li	s8,-1
    8000304c:	a82d                	j	80003086 <readi+0x84>
    8000304e:	020d1d93          	slli	s11,s10,0x20
    80003052:	020ddd93          	srli	s11,s11,0x20
    80003056:	05890613          	addi	a2,s2,88
    8000305a:	86ee                	mv	a3,s11
    8000305c:	963a                	add	a2,a2,a4
    8000305e:	85d2                	mv	a1,s4
    80003060:	855e                	mv	a0,s7
    80003062:	fffff097          	auipc	ra,0xfffff
    80003066:	95a080e7          	jalr	-1702(ra) # 800019bc <either_copyout>
    8000306a:	05850d63          	beq	a0,s8,800030c4 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    8000306e:	854a                	mv	a0,s2
    80003070:	fffff097          	auipc	ra,0xfffff
    80003074:	44e080e7          	jalr	1102(ra) # 800024be <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003078:	013d09bb          	addw	s3,s10,s3
    8000307c:	009d04bb          	addw	s1,s10,s1
    80003080:	9a6e                	add	s4,s4,s11
    80003082:	0559fd63          	bgeu	s3,s5,800030dc <readi+0xda>
    uint addr = bmap(ip, off/BSIZE);
    80003086:	00a4d59b          	srliw	a1,s1,0xa
    8000308a:	855a                	mv	a0,s6
    8000308c:	fffff097          	auipc	ra,0xfffff
    80003090:	706080e7          	jalr	1798(ra) # 80002792 <bmap>
    80003094:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003098:	c9b1                	beqz	a1,800030ec <readi+0xea>
    bp = bread(ip->dev, addr);
    8000309a:	000b2503          	lw	a0,0(s6)
    8000309e:	fffff097          	auipc	ra,0xfffff
    800030a2:	2f0080e7          	jalr	752(ra) # 8000238e <bread>
    800030a6:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800030a8:	3ff4f713          	andi	a4,s1,1023
    800030ac:	40ec87bb          	subw	a5,s9,a4
    800030b0:	413a86bb          	subw	a3,s5,s3
    800030b4:	8d3e                	mv	s10,a5
    800030b6:	2781                	sext.w	a5,a5
    800030b8:	0006861b          	sext.w	a2,a3
    800030bc:	f8f679e3          	bgeu	a2,a5,8000304e <readi+0x4c>
    800030c0:	8d36                	mv	s10,a3
    800030c2:	b771                	j	8000304e <readi+0x4c>
      brelse(bp);
    800030c4:	854a                	mv	a0,s2
    800030c6:	fffff097          	auipc	ra,0xfffff
    800030ca:	3f8080e7          	jalr	1016(ra) # 800024be <brelse>
      tot = -1;
    800030ce:	59fd                	li	s3,-1
      break;
    800030d0:	6946                	ld	s2,80(sp)
    800030d2:	7c02                	ld	s8,32(sp)
    800030d4:	6ce2                	ld	s9,24(sp)
    800030d6:	6d42                	ld	s10,16(sp)
    800030d8:	6da2                	ld	s11,8(sp)
    800030da:	a831                	j	800030f6 <readi+0xf4>
    800030dc:	6946                	ld	s2,80(sp)
    800030de:	7c02                	ld	s8,32(sp)
    800030e0:	6ce2                	ld	s9,24(sp)
    800030e2:	6d42                	ld	s10,16(sp)
    800030e4:	6da2                	ld	s11,8(sp)
    800030e6:	a801                	j	800030f6 <readi+0xf4>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030e8:	89d6                	mv	s3,s5
    800030ea:	a031                	j	800030f6 <readi+0xf4>
    800030ec:	6946                	ld	s2,80(sp)
    800030ee:	7c02                	ld	s8,32(sp)
    800030f0:	6ce2                	ld	s9,24(sp)
    800030f2:	6d42                	ld	s10,16(sp)
    800030f4:	6da2                	ld	s11,8(sp)
  }
  return tot;
    800030f6:	0009851b          	sext.w	a0,s3
    800030fa:	69a6                	ld	s3,72(sp)
}
    800030fc:	70a6                	ld	ra,104(sp)
    800030fe:	7406                	ld	s0,96(sp)
    80003100:	64e6                	ld	s1,88(sp)
    80003102:	6a06                	ld	s4,64(sp)
    80003104:	7ae2                	ld	s5,56(sp)
    80003106:	7b42                	ld	s6,48(sp)
    80003108:	7ba2                	ld	s7,40(sp)
    8000310a:	6165                	addi	sp,sp,112
    8000310c:	8082                	ret
    return 0;
    8000310e:	4501                	li	a0,0
}
    80003110:	8082                	ret

0000000080003112 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003112:	457c                	lw	a5,76(a0)
    80003114:	10d7ef63          	bltu	a5,a3,80003232 <writei+0x120>
{
    80003118:	7159                	addi	sp,sp,-112
    8000311a:	f486                	sd	ra,104(sp)
    8000311c:	f0a2                	sd	s0,96(sp)
    8000311e:	e8ca                	sd	s2,80(sp)
    80003120:	e0d2                	sd	s4,64(sp)
    80003122:	fc56                	sd	s5,56(sp)
    80003124:	f85a                	sd	s6,48(sp)
    80003126:	f45e                	sd	s7,40(sp)
    80003128:	1880                	addi	s0,sp,112
    8000312a:	8aaa                	mv	s5,a0
    8000312c:	8bae                	mv	s7,a1
    8000312e:	8a32                	mv	s4,a2
    80003130:	8936                	mv	s2,a3
    80003132:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003134:	9f35                	addw	a4,a4,a3
    80003136:	10d76063          	bltu	a4,a3,80003236 <writei+0x124>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    8000313a:	040437b7          	lui	a5,0x4043
    8000313e:	c0078793          	addi	a5,a5,-1024 # 4042c00 <_entry-0x7bfbd400>
    80003142:	0ee7ec63          	bltu	a5,a4,8000323a <writei+0x128>
    80003146:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003148:	0c0b0d63          	beqz	s6,80003222 <writei+0x110>
    8000314c:	eca6                	sd	s1,88(sp)
    8000314e:	f062                	sd	s8,32(sp)
    80003150:	ec66                	sd	s9,24(sp)
    80003152:	e86a                	sd	s10,16(sp)
    80003154:	e46e                	sd	s11,8(sp)
    80003156:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003158:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000315c:	5c7d                	li	s8,-1
    8000315e:	a091                	j	800031a2 <writei+0x90>
    80003160:	020d1d93          	slli	s11,s10,0x20
    80003164:	020ddd93          	srli	s11,s11,0x20
    80003168:	05848513          	addi	a0,s1,88
    8000316c:	86ee                	mv	a3,s11
    8000316e:	8652                	mv	a2,s4
    80003170:	85de                	mv	a1,s7
    80003172:	953a                	add	a0,a0,a4
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	89e080e7          	jalr	-1890(ra) # 80001a12 <either_copyin>
    8000317c:	07850263          	beq	a0,s8,800031e0 <writei+0xce>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003180:	8526                	mv	a0,s1
    80003182:	00000097          	auipc	ra,0x0
    80003186:	770080e7          	jalr	1904(ra) # 800038f2 <log_write>
    brelse(bp);
    8000318a:	8526                	mv	a0,s1
    8000318c:	fffff097          	auipc	ra,0xfffff
    80003190:	332080e7          	jalr	818(ra) # 800024be <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003194:	013d09bb          	addw	s3,s10,s3
    80003198:	012d093b          	addw	s2,s10,s2
    8000319c:	9a6e                	add	s4,s4,s11
    8000319e:	0569f663          	bgeu	s3,s6,800031ea <writei+0xd8>
    uint addr = bmap(ip, off/BSIZE);
    800031a2:	00a9559b          	srliw	a1,s2,0xa
    800031a6:	8556                	mv	a0,s5
    800031a8:	fffff097          	auipc	ra,0xfffff
    800031ac:	5ea080e7          	jalr	1514(ra) # 80002792 <bmap>
    800031b0:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800031b4:	c99d                	beqz	a1,800031ea <writei+0xd8>
    bp = bread(ip->dev, addr);
    800031b6:	000aa503          	lw	a0,0(s5)
    800031ba:	fffff097          	auipc	ra,0xfffff
    800031be:	1d4080e7          	jalr	468(ra) # 8000238e <bread>
    800031c2:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800031c4:	3ff97713          	andi	a4,s2,1023
    800031c8:	40ec87bb          	subw	a5,s9,a4
    800031cc:	413b06bb          	subw	a3,s6,s3
    800031d0:	8d3e                	mv	s10,a5
    800031d2:	2781                	sext.w	a5,a5
    800031d4:	0006861b          	sext.w	a2,a3
    800031d8:	f8f674e3          	bgeu	a2,a5,80003160 <writei+0x4e>
    800031dc:	8d36                	mv	s10,a3
    800031de:	b749                	j	80003160 <writei+0x4e>
      brelse(bp);
    800031e0:	8526                	mv	a0,s1
    800031e2:	fffff097          	auipc	ra,0xfffff
    800031e6:	2dc080e7          	jalr	732(ra) # 800024be <brelse>
  }

  if(off > ip->size)
    800031ea:	04caa783          	lw	a5,76(s5)
    800031ee:	0327fc63          	bgeu	a5,s2,80003226 <writei+0x114>
    ip->size = off;
    800031f2:	052aa623          	sw	s2,76(s5)
    800031f6:	64e6                	ld	s1,88(sp)
    800031f8:	7c02                	ld	s8,32(sp)
    800031fa:	6ce2                	ld	s9,24(sp)
    800031fc:	6d42                	ld	s10,16(sp)
    800031fe:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003200:	8556                	mv	a0,s5
    80003202:	00000097          	auipc	ra,0x0
    80003206:	9d2080e7          	jalr	-1582(ra) # 80002bd4 <iupdate>

  return tot;
    8000320a:	0009851b          	sext.w	a0,s3
    8000320e:	69a6                	ld	s3,72(sp)
}
    80003210:	70a6                	ld	ra,104(sp)
    80003212:	7406                	ld	s0,96(sp)
    80003214:	6946                	ld	s2,80(sp)
    80003216:	6a06                	ld	s4,64(sp)
    80003218:	7ae2                	ld	s5,56(sp)
    8000321a:	7b42                	ld	s6,48(sp)
    8000321c:	7ba2                	ld	s7,40(sp)
    8000321e:	6165                	addi	sp,sp,112
    80003220:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003222:	89da                	mv	s3,s6
    80003224:	bff1                	j	80003200 <writei+0xee>
    80003226:	64e6                	ld	s1,88(sp)
    80003228:	7c02                	ld	s8,32(sp)
    8000322a:	6ce2                	ld	s9,24(sp)
    8000322c:	6d42                	ld	s10,16(sp)
    8000322e:	6da2                	ld	s11,8(sp)
    80003230:	bfc1                	j	80003200 <writei+0xee>
    return -1;
    80003232:	557d                	li	a0,-1
}
    80003234:	8082                	ret
    return -1;
    80003236:	557d                	li	a0,-1
    80003238:	bfe1                	j	80003210 <writei+0xfe>
    return -1;
    8000323a:	557d                	li	a0,-1
    8000323c:	bfd1                	j	80003210 <writei+0xfe>

000000008000323e <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    8000323e:	1141                	addi	sp,sp,-16
    80003240:	e406                	sd	ra,8(sp)
    80003242:	e022                	sd	s0,0(sp)
    80003244:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003246:	4639                	li	a2,14
    80003248:	ffffd097          	auipc	ra,0xffffd
    8000324c:	002080e7          	jalr	2(ra) # 8000024a <strncmp>
}
    80003250:	60a2                	ld	ra,8(sp)
    80003252:	6402                	ld	s0,0(sp)
    80003254:	0141                	addi	sp,sp,16
    80003256:	8082                	ret

0000000080003258 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003258:	7139                	addi	sp,sp,-64
    8000325a:	fc06                	sd	ra,56(sp)
    8000325c:	f822                	sd	s0,48(sp)
    8000325e:	f426                	sd	s1,40(sp)
    80003260:	f04a                	sd	s2,32(sp)
    80003262:	ec4e                	sd	s3,24(sp)
    80003264:	e852                	sd	s4,16(sp)
    80003266:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003268:	04451703          	lh	a4,68(a0)
    8000326c:	4785                	li	a5,1
    8000326e:	00f71a63          	bne	a4,a5,80003282 <dirlookup+0x2a>
    80003272:	892a                	mv	s2,a0
    80003274:	89ae                	mv	s3,a1
    80003276:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003278:	457c                	lw	a5,76(a0)
    8000327a:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000327c:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000327e:	e79d                	bnez	a5,800032ac <dirlookup+0x54>
    80003280:	a8a5                	j	800032f8 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003282:	00005517          	auipc	a0,0x5
    80003286:	23650513          	addi	a0,a0,566 # 800084b8 <etext+0x4b8>
    8000328a:	00003097          	auipc	ra,0x3
    8000328e:	c88080e7          	jalr	-888(ra) # 80005f12 <panic>
      panic("dirlookup read");
    80003292:	00005517          	auipc	a0,0x5
    80003296:	23e50513          	addi	a0,a0,574 # 800084d0 <etext+0x4d0>
    8000329a:	00003097          	auipc	ra,0x3
    8000329e:	c78080e7          	jalr	-904(ra) # 80005f12 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032a2:	24c1                	addiw	s1,s1,16
    800032a4:	04c92783          	lw	a5,76(s2)
    800032a8:	04f4f763          	bgeu	s1,a5,800032f6 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032ac:	4741                	li	a4,16
    800032ae:	86a6                	mv	a3,s1
    800032b0:	fc040613          	addi	a2,s0,-64
    800032b4:	4581                	li	a1,0
    800032b6:	854a                	mv	a0,s2
    800032b8:	00000097          	auipc	ra,0x0
    800032bc:	d4a080e7          	jalr	-694(ra) # 80003002 <readi>
    800032c0:	47c1                	li	a5,16
    800032c2:	fcf518e3          	bne	a0,a5,80003292 <dirlookup+0x3a>
    if(de.inum == 0)
    800032c6:	fc045783          	lhu	a5,-64(s0)
    800032ca:	dfe1                	beqz	a5,800032a2 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800032cc:	fc240593          	addi	a1,s0,-62
    800032d0:	854e                	mv	a0,s3
    800032d2:	00000097          	auipc	ra,0x0
    800032d6:	f6c080e7          	jalr	-148(ra) # 8000323e <namecmp>
    800032da:	f561                	bnez	a0,800032a2 <dirlookup+0x4a>
      if(poff)
    800032dc:	000a0463          	beqz	s4,800032e4 <dirlookup+0x8c>
        *poff = off;
    800032e0:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800032e4:	fc045583          	lhu	a1,-64(s0)
    800032e8:	00092503          	lw	a0,0(s2)
    800032ec:	fffff097          	auipc	ra,0xfffff
    800032f0:	674080e7          	jalr	1652(ra) # 80002960 <iget>
    800032f4:	a011                	j	800032f8 <dirlookup+0xa0>
  return 0;
    800032f6:	4501                	li	a0,0
}
    800032f8:	70e2                	ld	ra,56(sp)
    800032fa:	7442                	ld	s0,48(sp)
    800032fc:	74a2                	ld	s1,40(sp)
    800032fe:	7902                	ld	s2,32(sp)
    80003300:	69e2                	ld	s3,24(sp)
    80003302:	6a42                	ld	s4,16(sp)
    80003304:	6121                	addi	sp,sp,64
    80003306:	8082                	ret

0000000080003308 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003308:	711d                	addi	sp,sp,-96
    8000330a:	ec86                	sd	ra,88(sp)
    8000330c:	e8a2                	sd	s0,80(sp)
    8000330e:	e4a6                	sd	s1,72(sp)
    80003310:	e0ca                	sd	s2,64(sp)
    80003312:	fc4e                	sd	s3,56(sp)
    80003314:	f852                	sd	s4,48(sp)
    80003316:	f456                	sd	s5,40(sp)
    80003318:	f05a                	sd	s6,32(sp)
    8000331a:	ec5e                	sd	s7,24(sp)
    8000331c:	e862                	sd	s8,16(sp)
    8000331e:	e466                	sd	s9,8(sp)
    80003320:	1080                	addi	s0,sp,96
    80003322:	84aa                	mv	s1,a0
    80003324:	8b2e                	mv	s6,a1
    80003326:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003328:	00054703          	lbu	a4,0(a0)
    8000332c:	02f00793          	li	a5,47
    80003330:	02f70263          	beq	a4,a5,80003354 <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003334:	ffffe097          	auipc	ra,0xffffe
    80003338:	bd2080e7          	jalr	-1070(ra) # 80000f06 <myproc>
    8000333c:	15053503          	ld	a0,336(a0)
    80003340:	00000097          	auipc	ra,0x0
    80003344:	922080e7          	jalr	-1758(ra) # 80002c62 <idup>
    80003348:	8a2a                	mv	s4,a0
  while(*path == '/')
    8000334a:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    8000334e:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003350:	4b85                	li	s7,1
    80003352:	a875                	j	8000340e <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    80003354:	4585                	li	a1,1
    80003356:	4505                	li	a0,1
    80003358:	fffff097          	auipc	ra,0xfffff
    8000335c:	608080e7          	jalr	1544(ra) # 80002960 <iget>
    80003360:	8a2a                	mv	s4,a0
    80003362:	b7e5                	j	8000334a <namex+0x42>
      iunlockput(ip);
    80003364:	8552                	mv	a0,s4
    80003366:	00000097          	auipc	ra,0x0
    8000336a:	c4a080e7          	jalr	-950(ra) # 80002fb0 <iunlockput>
      return 0;
    8000336e:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003370:	8552                	mv	a0,s4
    80003372:	60e6                	ld	ra,88(sp)
    80003374:	6446                	ld	s0,80(sp)
    80003376:	64a6                	ld	s1,72(sp)
    80003378:	6906                	ld	s2,64(sp)
    8000337a:	79e2                	ld	s3,56(sp)
    8000337c:	7a42                	ld	s4,48(sp)
    8000337e:	7aa2                	ld	s5,40(sp)
    80003380:	7b02                	ld	s6,32(sp)
    80003382:	6be2                	ld	s7,24(sp)
    80003384:	6c42                	ld	s8,16(sp)
    80003386:	6ca2                	ld	s9,8(sp)
    80003388:	6125                	addi	sp,sp,96
    8000338a:	8082                	ret
      iunlock(ip);
    8000338c:	8552                	mv	a0,s4
    8000338e:	00000097          	auipc	ra,0x0
    80003392:	9d8080e7          	jalr	-1576(ra) # 80002d66 <iunlock>
      return ip;
    80003396:	bfe9                	j	80003370 <namex+0x68>
      iunlockput(ip);
    80003398:	8552                	mv	a0,s4
    8000339a:	00000097          	auipc	ra,0x0
    8000339e:	c16080e7          	jalr	-1002(ra) # 80002fb0 <iunlockput>
      return 0;
    800033a2:	8a4e                	mv	s4,s3
    800033a4:	b7f1                	j	80003370 <namex+0x68>
  len = path - s;
    800033a6:	40998633          	sub	a2,s3,s1
    800033aa:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    800033ae:	099c5863          	bge	s8,s9,8000343e <namex+0x136>
    memmove(name, s, DIRSIZ);
    800033b2:	4639                	li	a2,14
    800033b4:	85a6                	mv	a1,s1
    800033b6:	8556                	mv	a0,s5
    800033b8:	ffffd097          	auipc	ra,0xffffd
    800033bc:	e1e080e7          	jalr	-482(ra) # 800001d6 <memmove>
    800033c0:	84ce                	mv	s1,s3
  while(*path == '/')
    800033c2:	0004c783          	lbu	a5,0(s1)
    800033c6:	01279763          	bne	a5,s2,800033d4 <namex+0xcc>
    path++;
    800033ca:	0485                	addi	s1,s1,1
  while(*path == '/')
    800033cc:	0004c783          	lbu	a5,0(s1)
    800033d0:	ff278de3          	beq	a5,s2,800033ca <namex+0xc2>
    ilock(ip);
    800033d4:	8552                	mv	a0,s4
    800033d6:	00000097          	auipc	ra,0x0
    800033da:	8ca080e7          	jalr	-1846(ra) # 80002ca0 <ilock>
    if(ip->type != T_DIR){
    800033de:	044a1783          	lh	a5,68(s4)
    800033e2:	f97791e3          	bne	a5,s7,80003364 <namex+0x5c>
    if(nameiparent && *path == '\0'){
    800033e6:	000b0563          	beqz	s6,800033f0 <namex+0xe8>
    800033ea:	0004c783          	lbu	a5,0(s1)
    800033ee:	dfd9                	beqz	a5,8000338c <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    800033f0:	4601                	li	a2,0
    800033f2:	85d6                	mv	a1,s5
    800033f4:	8552                	mv	a0,s4
    800033f6:	00000097          	auipc	ra,0x0
    800033fa:	e62080e7          	jalr	-414(ra) # 80003258 <dirlookup>
    800033fe:	89aa                	mv	s3,a0
    80003400:	dd41                	beqz	a0,80003398 <namex+0x90>
    iunlockput(ip);
    80003402:	8552                	mv	a0,s4
    80003404:	00000097          	auipc	ra,0x0
    80003408:	bac080e7          	jalr	-1108(ra) # 80002fb0 <iunlockput>
    ip = next;
    8000340c:	8a4e                	mv	s4,s3
  while(*path == '/')
    8000340e:	0004c783          	lbu	a5,0(s1)
    80003412:	01279763          	bne	a5,s2,80003420 <namex+0x118>
    path++;
    80003416:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003418:	0004c783          	lbu	a5,0(s1)
    8000341c:	ff278de3          	beq	a5,s2,80003416 <namex+0x10e>
  if(*path == 0)
    80003420:	cb9d                	beqz	a5,80003456 <namex+0x14e>
  while(*path != '/' && *path != 0)
    80003422:	0004c783          	lbu	a5,0(s1)
    80003426:	89a6                	mv	s3,s1
  len = path - s;
    80003428:	4c81                	li	s9,0
    8000342a:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    8000342c:	01278963          	beq	a5,s2,8000343e <namex+0x136>
    80003430:	dbbd                	beqz	a5,800033a6 <namex+0x9e>
    path++;
    80003432:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80003434:	0009c783          	lbu	a5,0(s3)
    80003438:	ff279ce3          	bne	a5,s2,80003430 <namex+0x128>
    8000343c:	b7ad                	j	800033a6 <namex+0x9e>
    memmove(name, s, len);
    8000343e:	2601                	sext.w	a2,a2
    80003440:	85a6                	mv	a1,s1
    80003442:	8556                	mv	a0,s5
    80003444:	ffffd097          	auipc	ra,0xffffd
    80003448:	d92080e7          	jalr	-622(ra) # 800001d6 <memmove>
    name[len] = 0;
    8000344c:	9cd6                	add	s9,s9,s5
    8000344e:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003452:	84ce                	mv	s1,s3
    80003454:	b7bd                	j	800033c2 <namex+0xba>
  if(nameiparent){
    80003456:	f00b0de3          	beqz	s6,80003370 <namex+0x68>
    iput(ip);
    8000345a:	8552                	mv	a0,s4
    8000345c:	00000097          	auipc	ra,0x0
    80003460:	aac080e7          	jalr	-1364(ra) # 80002f08 <iput>
    return 0;
    80003464:	4a01                	li	s4,0
    80003466:	b729                	j	80003370 <namex+0x68>

0000000080003468 <dirlink>:
{
    80003468:	7139                	addi	sp,sp,-64
    8000346a:	fc06                	sd	ra,56(sp)
    8000346c:	f822                	sd	s0,48(sp)
    8000346e:	f04a                	sd	s2,32(sp)
    80003470:	ec4e                	sd	s3,24(sp)
    80003472:	e852                	sd	s4,16(sp)
    80003474:	0080                	addi	s0,sp,64
    80003476:	892a                	mv	s2,a0
    80003478:	8a2e                	mv	s4,a1
    8000347a:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    8000347c:	4601                	li	a2,0
    8000347e:	00000097          	auipc	ra,0x0
    80003482:	dda080e7          	jalr	-550(ra) # 80003258 <dirlookup>
    80003486:	ed25                	bnez	a0,800034fe <dirlink+0x96>
    80003488:	f426                	sd	s1,40(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000348a:	04c92483          	lw	s1,76(s2)
    8000348e:	c49d                	beqz	s1,800034bc <dirlink+0x54>
    80003490:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003492:	4741                	li	a4,16
    80003494:	86a6                	mv	a3,s1
    80003496:	fc040613          	addi	a2,s0,-64
    8000349a:	4581                	li	a1,0
    8000349c:	854a                	mv	a0,s2
    8000349e:	00000097          	auipc	ra,0x0
    800034a2:	b64080e7          	jalr	-1180(ra) # 80003002 <readi>
    800034a6:	47c1                	li	a5,16
    800034a8:	06f51163          	bne	a0,a5,8000350a <dirlink+0xa2>
    if(de.inum == 0)
    800034ac:	fc045783          	lhu	a5,-64(s0)
    800034b0:	c791                	beqz	a5,800034bc <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034b2:	24c1                	addiw	s1,s1,16
    800034b4:	04c92783          	lw	a5,76(s2)
    800034b8:	fcf4ede3          	bltu	s1,a5,80003492 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800034bc:	4639                	li	a2,14
    800034be:	85d2                	mv	a1,s4
    800034c0:	fc240513          	addi	a0,s0,-62
    800034c4:	ffffd097          	auipc	ra,0xffffd
    800034c8:	dbc080e7          	jalr	-580(ra) # 80000280 <strncpy>
  de.inum = inum;
    800034cc:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034d0:	4741                	li	a4,16
    800034d2:	86a6                	mv	a3,s1
    800034d4:	fc040613          	addi	a2,s0,-64
    800034d8:	4581                	li	a1,0
    800034da:	854a                	mv	a0,s2
    800034dc:	00000097          	auipc	ra,0x0
    800034e0:	c36080e7          	jalr	-970(ra) # 80003112 <writei>
    800034e4:	1541                	addi	a0,a0,-16
    800034e6:	00a03533          	snez	a0,a0
    800034ea:	40a00533          	neg	a0,a0
    800034ee:	74a2                	ld	s1,40(sp)
}
    800034f0:	70e2                	ld	ra,56(sp)
    800034f2:	7442                	ld	s0,48(sp)
    800034f4:	7902                	ld	s2,32(sp)
    800034f6:	69e2                	ld	s3,24(sp)
    800034f8:	6a42                	ld	s4,16(sp)
    800034fa:	6121                	addi	sp,sp,64
    800034fc:	8082                	ret
    iput(ip);
    800034fe:	00000097          	auipc	ra,0x0
    80003502:	a0a080e7          	jalr	-1526(ra) # 80002f08 <iput>
    return -1;
    80003506:	557d                	li	a0,-1
    80003508:	b7e5                	j	800034f0 <dirlink+0x88>
      panic("dirlink read");
    8000350a:	00005517          	auipc	a0,0x5
    8000350e:	fd650513          	addi	a0,a0,-42 # 800084e0 <etext+0x4e0>
    80003512:	00003097          	auipc	ra,0x3
    80003516:	a00080e7          	jalr	-1536(ra) # 80005f12 <panic>

000000008000351a <namei>:

struct inode*
namei(char *path)
{
    8000351a:	1101                	addi	sp,sp,-32
    8000351c:	ec06                	sd	ra,24(sp)
    8000351e:	e822                	sd	s0,16(sp)
    80003520:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003522:	fe040613          	addi	a2,s0,-32
    80003526:	4581                	li	a1,0
    80003528:	00000097          	auipc	ra,0x0
    8000352c:	de0080e7          	jalr	-544(ra) # 80003308 <namex>
}
    80003530:	60e2                	ld	ra,24(sp)
    80003532:	6442                	ld	s0,16(sp)
    80003534:	6105                	addi	sp,sp,32
    80003536:	8082                	ret

0000000080003538 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003538:	1141                	addi	sp,sp,-16
    8000353a:	e406                	sd	ra,8(sp)
    8000353c:	e022                	sd	s0,0(sp)
    8000353e:	0800                	addi	s0,sp,16
    80003540:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003542:	4585                	li	a1,1
    80003544:	00000097          	auipc	ra,0x0
    80003548:	dc4080e7          	jalr	-572(ra) # 80003308 <namex>
}
    8000354c:	60a2                	ld	ra,8(sp)
    8000354e:	6402                	ld	s0,0(sp)
    80003550:	0141                	addi	sp,sp,16
    80003552:	8082                	ret

0000000080003554 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003554:	1101                	addi	sp,sp,-32
    80003556:	ec06                	sd	ra,24(sp)
    80003558:	e822                	sd	s0,16(sp)
    8000355a:	e426                	sd	s1,8(sp)
    8000355c:	e04a                	sd	s2,0(sp)
    8000355e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003560:	00018917          	auipc	s2,0x18
    80003564:	cd090913          	addi	s2,s2,-816 # 8001b230 <log>
    80003568:	01892583          	lw	a1,24(s2)
    8000356c:	02892503          	lw	a0,40(s2)
    80003570:	fffff097          	auipc	ra,0xfffff
    80003574:	e1e080e7          	jalr	-482(ra) # 8000238e <bread>
    80003578:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    8000357a:	02c92603          	lw	a2,44(s2)
    8000357e:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003580:	00c05f63          	blez	a2,8000359e <write_head+0x4a>
    80003584:	00018717          	auipc	a4,0x18
    80003588:	cdc70713          	addi	a4,a4,-804 # 8001b260 <log+0x30>
    8000358c:	87aa                	mv	a5,a0
    8000358e:	060a                	slli	a2,a2,0x2
    80003590:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003592:	4314                	lw	a3,0(a4)
    80003594:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003596:	0711                	addi	a4,a4,4
    80003598:	0791                	addi	a5,a5,4
    8000359a:	fec79ce3          	bne	a5,a2,80003592 <write_head+0x3e>
  }
  bwrite(buf);
    8000359e:	8526                	mv	a0,s1
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	ee0080e7          	jalr	-288(ra) # 80002480 <bwrite>
  brelse(buf);
    800035a8:	8526                	mv	a0,s1
    800035aa:	fffff097          	auipc	ra,0xfffff
    800035ae:	f14080e7          	jalr	-236(ra) # 800024be <brelse>
}
    800035b2:	60e2                	ld	ra,24(sp)
    800035b4:	6442                	ld	s0,16(sp)
    800035b6:	64a2                	ld	s1,8(sp)
    800035b8:	6902                	ld	s2,0(sp)
    800035ba:	6105                	addi	sp,sp,32
    800035bc:	8082                	ret

00000000800035be <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035be:	00018797          	auipc	a5,0x18
    800035c2:	c9e7a783          	lw	a5,-866(a5) # 8001b25c <log+0x2c>
    800035c6:	0af05d63          	blez	a5,80003680 <install_trans+0xc2>
{
    800035ca:	7139                	addi	sp,sp,-64
    800035cc:	fc06                	sd	ra,56(sp)
    800035ce:	f822                	sd	s0,48(sp)
    800035d0:	f426                	sd	s1,40(sp)
    800035d2:	f04a                	sd	s2,32(sp)
    800035d4:	ec4e                	sd	s3,24(sp)
    800035d6:	e852                	sd	s4,16(sp)
    800035d8:	e456                	sd	s5,8(sp)
    800035da:	e05a                	sd	s6,0(sp)
    800035dc:	0080                	addi	s0,sp,64
    800035de:	8b2a                	mv	s6,a0
    800035e0:	00018a97          	auipc	s5,0x18
    800035e4:	c80a8a93          	addi	s5,s5,-896 # 8001b260 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035e8:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800035ea:	00018997          	auipc	s3,0x18
    800035ee:	c4698993          	addi	s3,s3,-954 # 8001b230 <log>
    800035f2:	a00d                	j	80003614 <install_trans+0x56>
    brelse(lbuf);
    800035f4:	854a                	mv	a0,s2
    800035f6:	fffff097          	auipc	ra,0xfffff
    800035fa:	ec8080e7          	jalr	-312(ra) # 800024be <brelse>
    brelse(dbuf);
    800035fe:	8526                	mv	a0,s1
    80003600:	fffff097          	auipc	ra,0xfffff
    80003604:	ebe080e7          	jalr	-322(ra) # 800024be <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003608:	2a05                	addiw	s4,s4,1
    8000360a:	0a91                	addi	s5,s5,4
    8000360c:	02c9a783          	lw	a5,44(s3)
    80003610:	04fa5e63          	bge	s4,a5,8000366c <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003614:	0189a583          	lw	a1,24(s3)
    80003618:	014585bb          	addw	a1,a1,s4
    8000361c:	2585                	addiw	a1,a1,1
    8000361e:	0289a503          	lw	a0,40(s3)
    80003622:	fffff097          	auipc	ra,0xfffff
    80003626:	d6c080e7          	jalr	-660(ra) # 8000238e <bread>
    8000362a:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000362c:	000aa583          	lw	a1,0(s5)
    80003630:	0289a503          	lw	a0,40(s3)
    80003634:	fffff097          	auipc	ra,0xfffff
    80003638:	d5a080e7          	jalr	-678(ra) # 8000238e <bread>
    8000363c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000363e:	40000613          	li	a2,1024
    80003642:	05890593          	addi	a1,s2,88
    80003646:	05850513          	addi	a0,a0,88
    8000364a:	ffffd097          	auipc	ra,0xffffd
    8000364e:	b8c080e7          	jalr	-1140(ra) # 800001d6 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003652:	8526                	mv	a0,s1
    80003654:	fffff097          	auipc	ra,0xfffff
    80003658:	e2c080e7          	jalr	-468(ra) # 80002480 <bwrite>
    if(recovering == 0)
    8000365c:	f80b1ce3          	bnez	s6,800035f4 <install_trans+0x36>
      bunpin(dbuf);
    80003660:	8526                	mv	a0,s1
    80003662:	fffff097          	auipc	ra,0xfffff
    80003666:	f34080e7          	jalr	-204(ra) # 80002596 <bunpin>
    8000366a:	b769                	j	800035f4 <install_trans+0x36>
}
    8000366c:	70e2                	ld	ra,56(sp)
    8000366e:	7442                	ld	s0,48(sp)
    80003670:	74a2                	ld	s1,40(sp)
    80003672:	7902                	ld	s2,32(sp)
    80003674:	69e2                	ld	s3,24(sp)
    80003676:	6a42                	ld	s4,16(sp)
    80003678:	6aa2                	ld	s5,8(sp)
    8000367a:	6b02                	ld	s6,0(sp)
    8000367c:	6121                	addi	sp,sp,64
    8000367e:	8082                	ret
    80003680:	8082                	ret

0000000080003682 <initlog>:
{
    80003682:	7179                	addi	sp,sp,-48
    80003684:	f406                	sd	ra,40(sp)
    80003686:	f022                	sd	s0,32(sp)
    80003688:	ec26                	sd	s1,24(sp)
    8000368a:	e84a                	sd	s2,16(sp)
    8000368c:	e44e                	sd	s3,8(sp)
    8000368e:	1800                	addi	s0,sp,48
    80003690:	892a                	mv	s2,a0
    80003692:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003694:	00018497          	auipc	s1,0x18
    80003698:	b9c48493          	addi	s1,s1,-1124 # 8001b230 <log>
    8000369c:	00005597          	auipc	a1,0x5
    800036a0:	e5458593          	addi	a1,a1,-428 # 800084f0 <etext+0x4f0>
    800036a4:	8526                	mv	a0,s1
    800036a6:	00003097          	auipc	ra,0x3
    800036aa:	d56080e7          	jalr	-682(ra) # 800063fc <initlock>
  log.start = sb->logstart;
    800036ae:	0149a583          	lw	a1,20(s3)
    800036b2:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800036b4:	0109a783          	lw	a5,16(s3)
    800036b8:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800036ba:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036be:	854a                	mv	a0,s2
    800036c0:	fffff097          	auipc	ra,0xfffff
    800036c4:	cce080e7          	jalr	-818(ra) # 8000238e <bread>
  log.lh.n = lh->n;
    800036c8:	4d30                	lw	a2,88(a0)
    800036ca:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800036cc:	00c05f63          	blez	a2,800036ea <initlog+0x68>
    800036d0:	87aa                	mv	a5,a0
    800036d2:	00018717          	auipc	a4,0x18
    800036d6:	b8e70713          	addi	a4,a4,-1138 # 8001b260 <log+0x30>
    800036da:	060a                	slli	a2,a2,0x2
    800036dc:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800036de:	4ff4                	lw	a3,92(a5)
    800036e0:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800036e2:	0791                	addi	a5,a5,4
    800036e4:	0711                	addi	a4,a4,4
    800036e6:	fec79ce3          	bne	a5,a2,800036de <initlog+0x5c>
  brelse(buf);
    800036ea:	fffff097          	auipc	ra,0xfffff
    800036ee:	dd4080e7          	jalr	-556(ra) # 800024be <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800036f2:	4505                	li	a0,1
    800036f4:	00000097          	auipc	ra,0x0
    800036f8:	eca080e7          	jalr	-310(ra) # 800035be <install_trans>
  log.lh.n = 0;
    800036fc:	00018797          	auipc	a5,0x18
    80003700:	b607a023          	sw	zero,-1184(a5) # 8001b25c <log+0x2c>
  write_head(); // clear the log
    80003704:	00000097          	auipc	ra,0x0
    80003708:	e50080e7          	jalr	-432(ra) # 80003554 <write_head>
}
    8000370c:	70a2                	ld	ra,40(sp)
    8000370e:	7402                	ld	s0,32(sp)
    80003710:	64e2                	ld	s1,24(sp)
    80003712:	6942                	ld	s2,16(sp)
    80003714:	69a2                	ld	s3,8(sp)
    80003716:	6145                	addi	sp,sp,48
    80003718:	8082                	ret

000000008000371a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000371a:	1101                	addi	sp,sp,-32
    8000371c:	ec06                	sd	ra,24(sp)
    8000371e:	e822                	sd	s0,16(sp)
    80003720:	e426                	sd	s1,8(sp)
    80003722:	e04a                	sd	s2,0(sp)
    80003724:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003726:	00018517          	auipc	a0,0x18
    8000372a:	b0a50513          	addi	a0,a0,-1270 # 8001b230 <log>
    8000372e:	00003097          	auipc	ra,0x3
    80003732:	d5e080e7          	jalr	-674(ra) # 8000648c <acquire>
  while(1){
    if(log.committing){
    80003736:	00018497          	auipc	s1,0x18
    8000373a:	afa48493          	addi	s1,s1,-1286 # 8001b230 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000373e:	4979                	li	s2,30
    80003740:	a039                	j	8000374e <begin_op+0x34>
      sleep(&log, &log.lock);
    80003742:	85a6                	mv	a1,s1
    80003744:	8526                	mv	a0,s1
    80003746:	ffffe097          	auipc	ra,0xffffe
    8000374a:	e6e080e7          	jalr	-402(ra) # 800015b4 <sleep>
    if(log.committing){
    8000374e:	50dc                	lw	a5,36(s1)
    80003750:	fbed                	bnez	a5,80003742 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003752:	5098                	lw	a4,32(s1)
    80003754:	2705                	addiw	a4,a4,1
    80003756:	0027179b          	slliw	a5,a4,0x2
    8000375a:	9fb9                	addw	a5,a5,a4
    8000375c:	0017979b          	slliw	a5,a5,0x1
    80003760:	54d4                	lw	a3,44(s1)
    80003762:	9fb5                	addw	a5,a5,a3
    80003764:	00f95963          	bge	s2,a5,80003776 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003768:	85a6                	mv	a1,s1
    8000376a:	8526                	mv	a0,s1
    8000376c:	ffffe097          	auipc	ra,0xffffe
    80003770:	e48080e7          	jalr	-440(ra) # 800015b4 <sleep>
    80003774:	bfe9                	j	8000374e <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003776:	00018517          	auipc	a0,0x18
    8000377a:	aba50513          	addi	a0,a0,-1350 # 8001b230 <log>
    8000377e:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003780:	00003097          	auipc	ra,0x3
    80003784:	dc0080e7          	jalr	-576(ra) # 80006540 <release>
      break;
    }
  }
}
    80003788:	60e2                	ld	ra,24(sp)
    8000378a:	6442                	ld	s0,16(sp)
    8000378c:	64a2                	ld	s1,8(sp)
    8000378e:	6902                	ld	s2,0(sp)
    80003790:	6105                	addi	sp,sp,32
    80003792:	8082                	ret

0000000080003794 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003794:	7139                	addi	sp,sp,-64
    80003796:	fc06                	sd	ra,56(sp)
    80003798:	f822                	sd	s0,48(sp)
    8000379a:	f426                	sd	s1,40(sp)
    8000379c:	f04a                	sd	s2,32(sp)
    8000379e:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800037a0:	00018497          	auipc	s1,0x18
    800037a4:	a9048493          	addi	s1,s1,-1392 # 8001b230 <log>
    800037a8:	8526                	mv	a0,s1
    800037aa:	00003097          	auipc	ra,0x3
    800037ae:	ce2080e7          	jalr	-798(ra) # 8000648c <acquire>
  log.outstanding -= 1;
    800037b2:	509c                	lw	a5,32(s1)
    800037b4:	37fd                	addiw	a5,a5,-1
    800037b6:	0007891b          	sext.w	s2,a5
    800037ba:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800037bc:	50dc                	lw	a5,36(s1)
    800037be:	e7b9                	bnez	a5,8000380c <end_op+0x78>
    panic("log.committing");
  if(log.outstanding == 0){
    800037c0:	06091163          	bnez	s2,80003822 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800037c4:	00018497          	auipc	s1,0x18
    800037c8:	a6c48493          	addi	s1,s1,-1428 # 8001b230 <log>
    800037cc:	4785                	li	a5,1
    800037ce:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800037d0:	8526                	mv	a0,s1
    800037d2:	00003097          	auipc	ra,0x3
    800037d6:	d6e080e7          	jalr	-658(ra) # 80006540 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800037da:	54dc                	lw	a5,44(s1)
    800037dc:	06f04763          	bgtz	a5,8000384a <end_op+0xb6>
    acquire(&log.lock);
    800037e0:	00018497          	auipc	s1,0x18
    800037e4:	a5048493          	addi	s1,s1,-1456 # 8001b230 <log>
    800037e8:	8526                	mv	a0,s1
    800037ea:	00003097          	auipc	ra,0x3
    800037ee:	ca2080e7          	jalr	-862(ra) # 8000648c <acquire>
    log.committing = 0;
    800037f2:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800037f6:	8526                	mv	a0,s1
    800037f8:	ffffe097          	auipc	ra,0xffffe
    800037fc:	e20080e7          	jalr	-480(ra) # 80001618 <wakeup>
    release(&log.lock);
    80003800:	8526                	mv	a0,s1
    80003802:	00003097          	auipc	ra,0x3
    80003806:	d3e080e7          	jalr	-706(ra) # 80006540 <release>
}
    8000380a:	a815                	j	8000383e <end_op+0xaa>
    8000380c:	ec4e                	sd	s3,24(sp)
    8000380e:	e852                	sd	s4,16(sp)
    80003810:	e456                	sd	s5,8(sp)
    panic("log.committing");
    80003812:	00005517          	auipc	a0,0x5
    80003816:	ce650513          	addi	a0,a0,-794 # 800084f8 <etext+0x4f8>
    8000381a:	00002097          	auipc	ra,0x2
    8000381e:	6f8080e7          	jalr	1784(ra) # 80005f12 <panic>
    wakeup(&log);
    80003822:	00018497          	auipc	s1,0x18
    80003826:	a0e48493          	addi	s1,s1,-1522 # 8001b230 <log>
    8000382a:	8526                	mv	a0,s1
    8000382c:	ffffe097          	auipc	ra,0xffffe
    80003830:	dec080e7          	jalr	-532(ra) # 80001618 <wakeup>
  release(&log.lock);
    80003834:	8526                	mv	a0,s1
    80003836:	00003097          	auipc	ra,0x3
    8000383a:	d0a080e7          	jalr	-758(ra) # 80006540 <release>
}
    8000383e:	70e2                	ld	ra,56(sp)
    80003840:	7442                	ld	s0,48(sp)
    80003842:	74a2                	ld	s1,40(sp)
    80003844:	7902                	ld	s2,32(sp)
    80003846:	6121                	addi	sp,sp,64
    80003848:	8082                	ret
    8000384a:	ec4e                	sd	s3,24(sp)
    8000384c:	e852                	sd	s4,16(sp)
    8000384e:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003850:	00018a97          	auipc	s5,0x18
    80003854:	a10a8a93          	addi	s5,s5,-1520 # 8001b260 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003858:	00018a17          	auipc	s4,0x18
    8000385c:	9d8a0a13          	addi	s4,s4,-1576 # 8001b230 <log>
    80003860:	018a2583          	lw	a1,24(s4)
    80003864:	012585bb          	addw	a1,a1,s2
    80003868:	2585                	addiw	a1,a1,1
    8000386a:	028a2503          	lw	a0,40(s4)
    8000386e:	fffff097          	auipc	ra,0xfffff
    80003872:	b20080e7          	jalr	-1248(ra) # 8000238e <bread>
    80003876:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003878:	000aa583          	lw	a1,0(s5)
    8000387c:	028a2503          	lw	a0,40(s4)
    80003880:	fffff097          	auipc	ra,0xfffff
    80003884:	b0e080e7          	jalr	-1266(ra) # 8000238e <bread>
    80003888:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000388a:	40000613          	li	a2,1024
    8000388e:	05850593          	addi	a1,a0,88
    80003892:	05848513          	addi	a0,s1,88
    80003896:	ffffd097          	auipc	ra,0xffffd
    8000389a:	940080e7          	jalr	-1728(ra) # 800001d6 <memmove>
    bwrite(to);  // write the log
    8000389e:	8526                	mv	a0,s1
    800038a0:	fffff097          	auipc	ra,0xfffff
    800038a4:	be0080e7          	jalr	-1056(ra) # 80002480 <bwrite>
    brelse(from);
    800038a8:	854e                	mv	a0,s3
    800038aa:	fffff097          	auipc	ra,0xfffff
    800038ae:	c14080e7          	jalr	-1004(ra) # 800024be <brelse>
    brelse(to);
    800038b2:	8526                	mv	a0,s1
    800038b4:	fffff097          	auipc	ra,0xfffff
    800038b8:	c0a080e7          	jalr	-1014(ra) # 800024be <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038bc:	2905                	addiw	s2,s2,1
    800038be:	0a91                	addi	s5,s5,4
    800038c0:	02ca2783          	lw	a5,44(s4)
    800038c4:	f8f94ee3          	blt	s2,a5,80003860 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800038c8:	00000097          	auipc	ra,0x0
    800038cc:	c8c080e7          	jalr	-884(ra) # 80003554 <write_head>
    install_trans(0); // Now install writes to home locations
    800038d0:	4501                	li	a0,0
    800038d2:	00000097          	auipc	ra,0x0
    800038d6:	cec080e7          	jalr	-788(ra) # 800035be <install_trans>
    log.lh.n = 0;
    800038da:	00018797          	auipc	a5,0x18
    800038de:	9807a123          	sw	zero,-1662(a5) # 8001b25c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800038e2:	00000097          	auipc	ra,0x0
    800038e6:	c72080e7          	jalr	-910(ra) # 80003554 <write_head>
    800038ea:	69e2                	ld	s3,24(sp)
    800038ec:	6a42                	ld	s4,16(sp)
    800038ee:	6aa2                	ld	s5,8(sp)
    800038f0:	bdc5                	j	800037e0 <end_op+0x4c>

00000000800038f2 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800038f2:	1101                	addi	sp,sp,-32
    800038f4:	ec06                	sd	ra,24(sp)
    800038f6:	e822                	sd	s0,16(sp)
    800038f8:	e426                	sd	s1,8(sp)
    800038fa:	e04a                	sd	s2,0(sp)
    800038fc:	1000                	addi	s0,sp,32
    800038fe:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003900:	00018917          	auipc	s2,0x18
    80003904:	93090913          	addi	s2,s2,-1744 # 8001b230 <log>
    80003908:	854a                	mv	a0,s2
    8000390a:	00003097          	auipc	ra,0x3
    8000390e:	b82080e7          	jalr	-1150(ra) # 8000648c <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003912:	02c92603          	lw	a2,44(s2)
    80003916:	47f5                	li	a5,29
    80003918:	06c7c563          	blt	a5,a2,80003982 <log_write+0x90>
    8000391c:	00018797          	auipc	a5,0x18
    80003920:	9307a783          	lw	a5,-1744(a5) # 8001b24c <log+0x1c>
    80003924:	37fd                	addiw	a5,a5,-1
    80003926:	04f65e63          	bge	a2,a5,80003982 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000392a:	00018797          	auipc	a5,0x18
    8000392e:	9267a783          	lw	a5,-1754(a5) # 8001b250 <log+0x20>
    80003932:	06f05063          	blez	a5,80003992 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003936:	4781                	li	a5,0
    80003938:	06c05563          	blez	a2,800039a2 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000393c:	44cc                	lw	a1,12(s1)
    8000393e:	00018717          	auipc	a4,0x18
    80003942:	92270713          	addi	a4,a4,-1758 # 8001b260 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003946:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003948:	4314                	lw	a3,0(a4)
    8000394a:	04b68c63          	beq	a3,a1,800039a2 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000394e:	2785                	addiw	a5,a5,1
    80003950:	0711                	addi	a4,a4,4
    80003952:	fef61be3          	bne	a2,a5,80003948 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003956:	0621                	addi	a2,a2,8
    80003958:	060a                	slli	a2,a2,0x2
    8000395a:	00018797          	auipc	a5,0x18
    8000395e:	8d678793          	addi	a5,a5,-1834 # 8001b230 <log>
    80003962:	97b2                	add	a5,a5,a2
    80003964:	44d8                	lw	a4,12(s1)
    80003966:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003968:	8526                	mv	a0,s1
    8000396a:	fffff097          	auipc	ra,0xfffff
    8000396e:	bf0080e7          	jalr	-1040(ra) # 8000255a <bpin>
    log.lh.n++;
    80003972:	00018717          	auipc	a4,0x18
    80003976:	8be70713          	addi	a4,a4,-1858 # 8001b230 <log>
    8000397a:	575c                	lw	a5,44(a4)
    8000397c:	2785                	addiw	a5,a5,1
    8000397e:	d75c                	sw	a5,44(a4)
    80003980:	a82d                	j	800039ba <log_write+0xc8>
    panic("too big a transaction");
    80003982:	00005517          	auipc	a0,0x5
    80003986:	b8650513          	addi	a0,a0,-1146 # 80008508 <etext+0x508>
    8000398a:	00002097          	auipc	ra,0x2
    8000398e:	588080e7          	jalr	1416(ra) # 80005f12 <panic>
    panic("log_write outside of trans");
    80003992:	00005517          	auipc	a0,0x5
    80003996:	b8e50513          	addi	a0,a0,-1138 # 80008520 <etext+0x520>
    8000399a:	00002097          	auipc	ra,0x2
    8000399e:	578080e7          	jalr	1400(ra) # 80005f12 <panic>
  log.lh.block[i] = b->blockno;
    800039a2:	00878693          	addi	a3,a5,8
    800039a6:	068a                	slli	a3,a3,0x2
    800039a8:	00018717          	auipc	a4,0x18
    800039ac:	88870713          	addi	a4,a4,-1912 # 8001b230 <log>
    800039b0:	9736                	add	a4,a4,a3
    800039b2:	44d4                	lw	a3,12(s1)
    800039b4:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800039b6:	faf609e3          	beq	a2,a5,80003968 <log_write+0x76>
  }
  release(&log.lock);
    800039ba:	00018517          	auipc	a0,0x18
    800039be:	87650513          	addi	a0,a0,-1930 # 8001b230 <log>
    800039c2:	00003097          	auipc	ra,0x3
    800039c6:	b7e080e7          	jalr	-1154(ra) # 80006540 <release>
}
    800039ca:	60e2                	ld	ra,24(sp)
    800039cc:	6442                	ld	s0,16(sp)
    800039ce:	64a2                	ld	s1,8(sp)
    800039d0:	6902                	ld	s2,0(sp)
    800039d2:	6105                	addi	sp,sp,32
    800039d4:	8082                	ret

00000000800039d6 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800039d6:	1101                	addi	sp,sp,-32
    800039d8:	ec06                	sd	ra,24(sp)
    800039da:	e822                	sd	s0,16(sp)
    800039dc:	e426                	sd	s1,8(sp)
    800039de:	e04a                	sd	s2,0(sp)
    800039e0:	1000                	addi	s0,sp,32
    800039e2:	84aa                	mv	s1,a0
    800039e4:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800039e6:	00005597          	auipc	a1,0x5
    800039ea:	b5a58593          	addi	a1,a1,-1190 # 80008540 <etext+0x540>
    800039ee:	0521                	addi	a0,a0,8
    800039f0:	00003097          	auipc	ra,0x3
    800039f4:	a0c080e7          	jalr	-1524(ra) # 800063fc <initlock>
  lk->name = name;
    800039f8:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800039fc:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a00:	0204a423          	sw	zero,40(s1)
}
    80003a04:	60e2                	ld	ra,24(sp)
    80003a06:	6442                	ld	s0,16(sp)
    80003a08:	64a2                	ld	s1,8(sp)
    80003a0a:	6902                	ld	s2,0(sp)
    80003a0c:	6105                	addi	sp,sp,32
    80003a0e:	8082                	ret

0000000080003a10 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a10:	1101                	addi	sp,sp,-32
    80003a12:	ec06                	sd	ra,24(sp)
    80003a14:	e822                	sd	s0,16(sp)
    80003a16:	e426                	sd	s1,8(sp)
    80003a18:	e04a                	sd	s2,0(sp)
    80003a1a:	1000                	addi	s0,sp,32
    80003a1c:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a1e:	00850913          	addi	s2,a0,8
    80003a22:	854a                	mv	a0,s2
    80003a24:	00003097          	auipc	ra,0x3
    80003a28:	a68080e7          	jalr	-1432(ra) # 8000648c <acquire>
  while (lk->locked) {
    80003a2c:	409c                	lw	a5,0(s1)
    80003a2e:	cb89                	beqz	a5,80003a40 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a30:	85ca                	mv	a1,s2
    80003a32:	8526                	mv	a0,s1
    80003a34:	ffffe097          	auipc	ra,0xffffe
    80003a38:	b80080e7          	jalr	-1152(ra) # 800015b4 <sleep>
  while (lk->locked) {
    80003a3c:	409c                	lw	a5,0(s1)
    80003a3e:	fbed                	bnez	a5,80003a30 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a40:	4785                	li	a5,1
    80003a42:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a44:	ffffd097          	auipc	ra,0xffffd
    80003a48:	4c2080e7          	jalr	1218(ra) # 80000f06 <myproc>
    80003a4c:	591c                	lw	a5,48(a0)
    80003a4e:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003a50:	854a                	mv	a0,s2
    80003a52:	00003097          	auipc	ra,0x3
    80003a56:	aee080e7          	jalr	-1298(ra) # 80006540 <release>
}
    80003a5a:	60e2                	ld	ra,24(sp)
    80003a5c:	6442                	ld	s0,16(sp)
    80003a5e:	64a2                	ld	s1,8(sp)
    80003a60:	6902                	ld	s2,0(sp)
    80003a62:	6105                	addi	sp,sp,32
    80003a64:	8082                	ret

0000000080003a66 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003a66:	1101                	addi	sp,sp,-32
    80003a68:	ec06                	sd	ra,24(sp)
    80003a6a:	e822                	sd	s0,16(sp)
    80003a6c:	e426                	sd	s1,8(sp)
    80003a6e:	e04a                	sd	s2,0(sp)
    80003a70:	1000                	addi	s0,sp,32
    80003a72:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a74:	00850913          	addi	s2,a0,8
    80003a78:	854a                	mv	a0,s2
    80003a7a:	00003097          	auipc	ra,0x3
    80003a7e:	a12080e7          	jalr	-1518(ra) # 8000648c <acquire>
  lk->locked = 0;
    80003a82:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a86:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003a8a:	8526                	mv	a0,s1
    80003a8c:	ffffe097          	auipc	ra,0xffffe
    80003a90:	b8c080e7          	jalr	-1140(ra) # 80001618 <wakeup>
  release(&lk->lk);
    80003a94:	854a                	mv	a0,s2
    80003a96:	00003097          	auipc	ra,0x3
    80003a9a:	aaa080e7          	jalr	-1366(ra) # 80006540 <release>
}
    80003a9e:	60e2                	ld	ra,24(sp)
    80003aa0:	6442                	ld	s0,16(sp)
    80003aa2:	64a2                	ld	s1,8(sp)
    80003aa4:	6902                	ld	s2,0(sp)
    80003aa6:	6105                	addi	sp,sp,32
    80003aa8:	8082                	ret

0000000080003aaa <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003aaa:	7179                	addi	sp,sp,-48
    80003aac:	f406                	sd	ra,40(sp)
    80003aae:	f022                	sd	s0,32(sp)
    80003ab0:	ec26                	sd	s1,24(sp)
    80003ab2:	e84a                	sd	s2,16(sp)
    80003ab4:	1800                	addi	s0,sp,48
    80003ab6:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003ab8:	00850913          	addi	s2,a0,8
    80003abc:	854a                	mv	a0,s2
    80003abe:	00003097          	auipc	ra,0x3
    80003ac2:	9ce080e7          	jalr	-1586(ra) # 8000648c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003ac6:	409c                	lw	a5,0(s1)
    80003ac8:	ef91                	bnez	a5,80003ae4 <holdingsleep+0x3a>
    80003aca:	4481                	li	s1,0
  release(&lk->lk);
    80003acc:	854a                	mv	a0,s2
    80003ace:	00003097          	auipc	ra,0x3
    80003ad2:	a72080e7          	jalr	-1422(ra) # 80006540 <release>
  return r;
}
    80003ad6:	8526                	mv	a0,s1
    80003ad8:	70a2                	ld	ra,40(sp)
    80003ada:	7402                	ld	s0,32(sp)
    80003adc:	64e2                	ld	s1,24(sp)
    80003ade:	6942                	ld	s2,16(sp)
    80003ae0:	6145                	addi	sp,sp,48
    80003ae2:	8082                	ret
    80003ae4:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003ae6:	0284a983          	lw	s3,40(s1)
    80003aea:	ffffd097          	auipc	ra,0xffffd
    80003aee:	41c080e7          	jalr	1052(ra) # 80000f06 <myproc>
    80003af2:	5904                	lw	s1,48(a0)
    80003af4:	413484b3          	sub	s1,s1,s3
    80003af8:	0014b493          	seqz	s1,s1
    80003afc:	69a2                	ld	s3,8(sp)
    80003afe:	b7f9                	j	80003acc <holdingsleep+0x22>

0000000080003b00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003b00:	1141                	addi	sp,sp,-16
    80003b02:	e406                	sd	ra,8(sp)
    80003b04:	e022                	sd	s0,0(sp)
    80003b06:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003b08:	00005597          	auipc	a1,0x5
    80003b0c:	a4858593          	addi	a1,a1,-1464 # 80008550 <etext+0x550>
    80003b10:	00018517          	auipc	a0,0x18
    80003b14:	86850513          	addi	a0,a0,-1944 # 8001b378 <ftable>
    80003b18:	00003097          	auipc	ra,0x3
    80003b1c:	8e4080e7          	jalr	-1820(ra) # 800063fc <initlock>
}
    80003b20:	60a2                	ld	ra,8(sp)
    80003b22:	6402                	ld	s0,0(sp)
    80003b24:	0141                	addi	sp,sp,16
    80003b26:	8082                	ret

0000000080003b28 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b28:	1101                	addi	sp,sp,-32
    80003b2a:	ec06                	sd	ra,24(sp)
    80003b2c:	e822                	sd	s0,16(sp)
    80003b2e:	e426                	sd	s1,8(sp)
    80003b30:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b32:	00018517          	auipc	a0,0x18
    80003b36:	84650513          	addi	a0,a0,-1978 # 8001b378 <ftable>
    80003b3a:	00003097          	auipc	ra,0x3
    80003b3e:	952080e7          	jalr	-1710(ra) # 8000648c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b42:	00018497          	auipc	s1,0x18
    80003b46:	84e48493          	addi	s1,s1,-1970 # 8001b390 <ftable+0x18>
    80003b4a:	00018717          	auipc	a4,0x18
    80003b4e:	7e670713          	addi	a4,a4,2022 # 8001c330 <disk>
    if(f->ref == 0){
    80003b52:	40dc                	lw	a5,4(s1)
    80003b54:	cf99                	beqz	a5,80003b72 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b56:	02848493          	addi	s1,s1,40
    80003b5a:	fee49ce3          	bne	s1,a4,80003b52 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003b5e:	00018517          	auipc	a0,0x18
    80003b62:	81a50513          	addi	a0,a0,-2022 # 8001b378 <ftable>
    80003b66:	00003097          	auipc	ra,0x3
    80003b6a:	9da080e7          	jalr	-1574(ra) # 80006540 <release>
  return 0;
    80003b6e:	4481                	li	s1,0
    80003b70:	a819                	j	80003b86 <filealloc+0x5e>
      f->ref = 1;
    80003b72:	4785                	li	a5,1
    80003b74:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003b76:	00018517          	auipc	a0,0x18
    80003b7a:	80250513          	addi	a0,a0,-2046 # 8001b378 <ftable>
    80003b7e:	00003097          	auipc	ra,0x3
    80003b82:	9c2080e7          	jalr	-1598(ra) # 80006540 <release>
}
    80003b86:	8526                	mv	a0,s1
    80003b88:	60e2                	ld	ra,24(sp)
    80003b8a:	6442                	ld	s0,16(sp)
    80003b8c:	64a2                	ld	s1,8(sp)
    80003b8e:	6105                	addi	sp,sp,32
    80003b90:	8082                	ret

0000000080003b92 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003b92:	1101                	addi	sp,sp,-32
    80003b94:	ec06                	sd	ra,24(sp)
    80003b96:	e822                	sd	s0,16(sp)
    80003b98:	e426                	sd	s1,8(sp)
    80003b9a:	1000                	addi	s0,sp,32
    80003b9c:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003b9e:	00017517          	auipc	a0,0x17
    80003ba2:	7da50513          	addi	a0,a0,2010 # 8001b378 <ftable>
    80003ba6:	00003097          	auipc	ra,0x3
    80003baa:	8e6080e7          	jalr	-1818(ra) # 8000648c <acquire>
  if(f->ref < 1)
    80003bae:	40dc                	lw	a5,4(s1)
    80003bb0:	02f05263          	blez	a5,80003bd4 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003bb4:	2785                	addiw	a5,a5,1
    80003bb6:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003bb8:	00017517          	auipc	a0,0x17
    80003bbc:	7c050513          	addi	a0,a0,1984 # 8001b378 <ftable>
    80003bc0:	00003097          	auipc	ra,0x3
    80003bc4:	980080e7          	jalr	-1664(ra) # 80006540 <release>
  return f;
}
    80003bc8:	8526                	mv	a0,s1
    80003bca:	60e2                	ld	ra,24(sp)
    80003bcc:	6442                	ld	s0,16(sp)
    80003bce:	64a2                	ld	s1,8(sp)
    80003bd0:	6105                	addi	sp,sp,32
    80003bd2:	8082                	ret
    panic("filedup");
    80003bd4:	00005517          	auipc	a0,0x5
    80003bd8:	98450513          	addi	a0,a0,-1660 # 80008558 <etext+0x558>
    80003bdc:	00002097          	auipc	ra,0x2
    80003be0:	336080e7          	jalr	822(ra) # 80005f12 <panic>

0000000080003be4 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003be4:	7139                	addi	sp,sp,-64
    80003be6:	fc06                	sd	ra,56(sp)
    80003be8:	f822                	sd	s0,48(sp)
    80003bea:	f426                	sd	s1,40(sp)
    80003bec:	0080                	addi	s0,sp,64
    80003bee:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003bf0:	00017517          	auipc	a0,0x17
    80003bf4:	78850513          	addi	a0,a0,1928 # 8001b378 <ftable>
    80003bf8:	00003097          	auipc	ra,0x3
    80003bfc:	894080e7          	jalr	-1900(ra) # 8000648c <acquire>
  if(f->ref < 1)
    80003c00:	40dc                	lw	a5,4(s1)
    80003c02:	04f05c63          	blez	a5,80003c5a <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80003c06:	37fd                	addiw	a5,a5,-1
    80003c08:	0007871b          	sext.w	a4,a5
    80003c0c:	c0dc                	sw	a5,4(s1)
    80003c0e:	06e04263          	bgtz	a4,80003c72 <fileclose+0x8e>
    80003c12:	f04a                	sd	s2,32(sp)
    80003c14:	ec4e                	sd	s3,24(sp)
    80003c16:	e852                	sd	s4,16(sp)
    80003c18:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c1a:	0004a903          	lw	s2,0(s1)
    80003c1e:	0094ca83          	lbu	s5,9(s1)
    80003c22:	0104ba03          	ld	s4,16(s1)
    80003c26:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c2a:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c2e:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c32:	00017517          	auipc	a0,0x17
    80003c36:	74650513          	addi	a0,a0,1862 # 8001b378 <ftable>
    80003c3a:	00003097          	auipc	ra,0x3
    80003c3e:	906080e7          	jalr	-1786(ra) # 80006540 <release>

  if(ff.type == FD_PIPE){
    80003c42:	4785                	li	a5,1
    80003c44:	04f90463          	beq	s2,a5,80003c8c <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c48:	3979                	addiw	s2,s2,-2
    80003c4a:	4785                	li	a5,1
    80003c4c:	0527fb63          	bgeu	a5,s2,80003ca2 <fileclose+0xbe>
    80003c50:	7902                	ld	s2,32(sp)
    80003c52:	69e2                	ld	s3,24(sp)
    80003c54:	6a42                	ld	s4,16(sp)
    80003c56:	6aa2                	ld	s5,8(sp)
    80003c58:	a02d                	j	80003c82 <fileclose+0x9e>
    80003c5a:	f04a                	sd	s2,32(sp)
    80003c5c:	ec4e                	sd	s3,24(sp)
    80003c5e:	e852                	sd	s4,16(sp)
    80003c60:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003c62:	00005517          	auipc	a0,0x5
    80003c66:	8fe50513          	addi	a0,a0,-1794 # 80008560 <etext+0x560>
    80003c6a:	00002097          	auipc	ra,0x2
    80003c6e:	2a8080e7          	jalr	680(ra) # 80005f12 <panic>
    release(&ftable.lock);
    80003c72:	00017517          	auipc	a0,0x17
    80003c76:	70650513          	addi	a0,a0,1798 # 8001b378 <ftable>
    80003c7a:	00003097          	auipc	ra,0x3
    80003c7e:	8c6080e7          	jalr	-1850(ra) # 80006540 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003c82:	70e2                	ld	ra,56(sp)
    80003c84:	7442                	ld	s0,48(sp)
    80003c86:	74a2                	ld	s1,40(sp)
    80003c88:	6121                	addi	sp,sp,64
    80003c8a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003c8c:	85d6                	mv	a1,s5
    80003c8e:	8552                	mv	a0,s4
    80003c90:	00000097          	auipc	ra,0x0
    80003c94:	3a2080e7          	jalr	930(ra) # 80004032 <pipeclose>
    80003c98:	7902                	ld	s2,32(sp)
    80003c9a:	69e2                	ld	s3,24(sp)
    80003c9c:	6a42                	ld	s4,16(sp)
    80003c9e:	6aa2                	ld	s5,8(sp)
    80003ca0:	b7cd                	j	80003c82 <fileclose+0x9e>
    begin_op();
    80003ca2:	00000097          	auipc	ra,0x0
    80003ca6:	a78080e7          	jalr	-1416(ra) # 8000371a <begin_op>
    iput(ff.ip);
    80003caa:	854e                	mv	a0,s3
    80003cac:	fffff097          	auipc	ra,0xfffff
    80003cb0:	25c080e7          	jalr	604(ra) # 80002f08 <iput>
    end_op();
    80003cb4:	00000097          	auipc	ra,0x0
    80003cb8:	ae0080e7          	jalr	-1312(ra) # 80003794 <end_op>
    80003cbc:	7902                	ld	s2,32(sp)
    80003cbe:	69e2                	ld	s3,24(sp)
    80003cc0:	6a42                	ld	s4,16(sp)
    80003cc2:	6aa2                	ld	s5,8(sp)
    80003cc4:	bf7d                	j	80003c82 <fileclose+0x9e>

0000000080003cc6 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003cc6:	715d                	addi	sp,sp,-80
    80003cc8:	e486                	sd	ra,72(sp)
    80003cca:	e0a2                	sd	s0,64(sp)
    80003ccc:	fc26                	sd	s1,56(sp)
    80003cce:	f44e                	sd	s3,40(sp)
    80003cd0:	0880                	addi	s0,sp,80
    80003cd2:	84aa                	mv	s1,a0
    80003cd4:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003cd6:	ffffd097          	auipc	ra,0xffffd
    80003cda:	230080e7          	jalr	560(ra) # 80000f06 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003cde:	409c                	lw	a5,0(s1)
    80003ce0:	37f9                	addiw	a5,a5,-2
    80003ce2:	4705                	li	a4,1
    80003ce4:	04f76863          	bltu	a4,a5,80003d34 <filestat+0x6e>
    80003ce8:	f84a                	sd	s2,48(sp)
    80003cea:	892a                	mv	s2,a0
    ilock(f->ip);
    80003cec:	6c88                	ld	a0,24(s1)
    80003cee:	fffff097          	auipc	ra,0xfffff
    80003cf2:	fb2080e7          	jalr	-78(ra) # 80002ca0 <ilock>
    stati(f->ip, &st);
    80003cf6:	fb840593          	addi	a1,s0,-72
    80003cfa:	6c88                	ld	a0,24(s1)
    80003cfc:	fffff097          	auipc	ra,0xfffff
    80003d00:	2dc080e7          	jalr	732(ra) # 80002fd8 <stati>
    iunlock(f->ip);
    80003d04:	6c88                	ld	a0,24(s1)
    80003d06:	fffff097          	auipc	ra,0xfffff
    80003d0a:	060080e7          	jalr	96(ra) # 80002d66 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d0e:	46e1                	li	a3,24
    80003d10:	fb840613          	addi	a2,s0,-72
    80003d14:	85ce                	mv	a1,s3
    80003d16:	05093503          	ld	a0,80(s2)
    80003d1a:	ffffd097          	auipc	ra,0xffffd
    80003d1e:	e32080e7          	jalr	-462(ra) # 80000b4c <copyout>
    80003d22:	41f5551b          	sraiw	a0,a0,0x1f
    80003d26:	7942                	ld	s2,48(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003d28:	60a6                	ld	ra,72(sp)
    80003d2a:	6406                	ld	s0,64(sp)
    80003d2c:	74e2                	ld	s1,56(sp)
    80003d2e:	79a2                	ld	s3,40(sp)
    80003d30:	6161                	addi	sp,sp,80
    80003d32:	8082                	ret
  return -1;
    80003d34:	557d                	li	a0,-1
    80003d36:	bfcd                	j	80003d28 <filestat+0x62>

0000000080003d38 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d38:	7179                	addi	sp,sp,-48
    80003d3a:	f406                	sd	ra,40(sp)
    80003d3c:	f022                	sd	s0,32(sp)
    80003d3e:	e84a                	sd	s2,16(sp)
    80003d40:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d42:	00854783          	lbu	a5,8(a0)
    80003d46:	cbc5                	beqz	a5,80003df6 <fileread+0xbe>
    80003d48:	ec26                	sd	s1,24(sp)
    80003d4a:	e44e                	sd	s3,8(sp)
    80003d4c:	84aa                	mv	s1,a0
    80003d4e:	89ae                	mv	s3,a1
    80003d50:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d52:	411c                	lw	a5,0(a0)
    80003d54:	4705                	li	a4,1
    80003d56:	04e78963          	beq	a5,a4,80003da8 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d5a:	470d                	li	a4,3
    80003d5c:	04e78f63          	beq	a5,a4,80003dba <fileread+0x82>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d60:	4709                	li	a4,2
    80003d62:	08e79263          	bne	a5,a4,80003de6 <fileread+0xae>
    ilock(f->ip);
    80003d66:	6d08                	ld	a0,24(a0)
    80003d68:	fffff097          	auipc	ra,0xfffff
    80003d6c:	f38080e7          	jalr	-200(ra) # 80002ca0 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003d70:	874a                	mv	a4,s2
    80003d72:	5094                	lw	a3,32(s1)
    80003d74:	864e                	mv	a2,s3
    80003d76:	4585                	li	a1,1
    80003d78:	6c88                	ld	a0,24(s1)
    80003d7a:	fffff097          	auipc	ra,0xfffff
    80003d7e:	288080e7          	jalr	648(ra) # 80003002 <readi>
    80003d82:	892a                	mv	s2,a0
    80003d84:	00a05563          	blez	a0,80003d8e <fileread+0x56>
      f->off += r;
    80003d88:	509c                	lw	a5,32(s1)
    80003d8a:	9fa9                	addw	a5,a5,a0
    80003d8c:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003d8e:	6c88                	ld	a0,24(s1)
    80003d90:	fffff097          	auipc	ra,0xfffff
    80003d94:	fd6080e7          	jalr	-42(ra) # 80002d66 <iunlock>
    80003d98:	64e2                	ld	s1,24(sp)
    80003d9a:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80003d9c:	854a                	mv	a0,s2
    80003d9e:	70a2                	ld	ra,40(sp)
    80003da0:	7402                	ld	s0,32(sp)
    80003da2:	6942                	ld	s2,16(sp)
    80003da4:	6145                	addi	sp,sp,48
    80003da6:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003da8:	6908                	ld	a0,16(a0)
    80003daa:	00000097          	auipc	ra,0x0
    80003dae:	400080e7          	jalr	1024(ra) # 800041aa <piperead>
    80003db2:	892a                	mv	s2,a0
    80003db4:	64e2                	ld	s1,24(sp)
    80003db6:	69a2                	ld	s3,8(sp)
    80003db8:	b7d5                	j	80003d9c <fileread+0x64>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003dba:	02451783          	lh	a5,36(a0)
    80003dbe:	03079693          	slli	a3,a5,0x30
    80003dc2:	92c1                	srli	a3,a3,0x30
    80003dc4:	4725                	li	a4,9
    80003dc6:	02d76a63          	bltu	a4,a3,80003dfa <fileread+0xc2>
    80003dca:	0792                	slli	a5,a5,0x4
    80003dcc:	00017717          	auipc	a4,0x17
    80003dd0:	50c70713          	addi	a4,a4,1292 # 8001b2d8 <devsw>
    80003dd4:	97ba                	add	a5,a5,a4
    80003dd6:	639c                	ld	a5,0(a5)
    80003dd8:	c78d                	beqz	a5,80003e02 <fileread+0xca>
    r = devsw[f->major].read(1, addr, n);
    80003dda:	4505                	li	a0,1
    80003ddc:	9782                	jalr	a5
    80003dde:	892a                	mv	s2,a0
    80003de0:	64e2                	ld	s1,24(sp)
    80003de2:	69a2                	ld	s3,8(sp)
    80003de4:	bf65                	j	80003d9c <fileread+0x64>
    panic("fileread");
    80003de6:	00004517          	auipc	a0,0x4
    80003dea:	78a50513          	addi	a0,a0,1930 # 80008570 <etext+0x570>
    80003dee:	00002097          	auipc	ra,0x2
    80003df2:	124080e7          	jalr	292(ra) # 80005f12 <panic>
    return -1;
    80003df6:	597d                	li	s2,-1
    80003df8:	b755                	j	80003d9c <fileread+0x64>
      return -1;
    80003dfa:	597d                	li	s2,-1
    80003dfc:	64e2                	ld	s1,24(sp)
    80003dfe:	69a2                	ld	s3,8(sp)
    80003e00:	bf71                	j	80003d9c <fileread+0x64>
    80003e02:	597d                	li	s2,-1
    80003e04:	64e2                	ld	s1,24(sp)
    80003e06:	69a2                	ld	s3,8(sp)
    80003e08:	bf51                	j	80003d9c <fileread+0x64>

0000000080003e0a <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003e0a:	00954783          	lbu	a5,9(a0)
    80003e0e:	12078963          	beqz	a5,80003f40 <filewrite+0x136>
{
    80003e12:	715d                	addi	sp,sp,-80
    80003e14:	e486                	sd	ra,72(sp)
    80003e16:	e0a2                	sd	s0,64(sp)
    80003e18:	f84a                	sd	s2,48(sp)
    80003e1a:	f052                	sd	s4,32(sp)
    80003e1c:	e85a                	sd	s6,16(sp)
    80003e1e:	0880                	addi	s0,sp,80
    80003e20:	892a                	mv	s2,a0
    80003e22:	8b2e                	mv	s6,a1
    80003e24:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e26:	411c                	lw	a5,0(a0)
    80003e28:	4705                	li	a4,1
    80003e2a:	02e78763          	beq	a5,a4,80003e58 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e2e:	470d                	li	a4,3
    80003e30:	02e78a63          	beq	a5,a4,80003e64 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e34:	4709                	li	a4,2
    80003e36:	0ee79863          	bne	a5,a4,80003f26 <filewrite+0x11c>
    80003e3a:	f44e                	sd	s3,40(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e3c:	0cc05463          	blez	a2,80003f04 <filewrite+0xfa>
    80003e40:	fc26                	sd	s1,56(sp)
    80003e42:	ec56                	sd	s5,24(sp)
    80003e44:	e45e                	sd	s7,8(sp)
    80003e46:	e062                	sd	s8,0(sp)
    int i = 0;
    80003e48:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80003e4a:	6b85                	lui	s7,0x1
    80003e4c:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003e50:	6c05                	lui	s8,0x1
    80003e52:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003e56:	a851                	j	80003eea <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80003e58:	6908                	ld	a0,16(a0)
    80003e5a:	00000097          	auipc	ra,0x0
    80003e5e:	248080e7          	jalr	584(ra) # 800040a2 <pipewrite>
    80003e62:	a85d                	j	80003f18 <filewrite+0x10e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e64:	02451783          	lh	a5,36(a0)
    80003e68:	03079693          	slli	a3,a5,0x30
    80003e6c:	92c1                	srli	a3,a3,0x30
    80003e6e:	4725                	li	a4,9
    80003e70:	0cd76a63          	bltu	a4,a3,80003f44 <filewrite+0x13a>
    80003e74:	0792                	slli	a5,a5,0x4
    80003e76:	00017717          	auipc	a4,0x17
    80003e7a:	46270713          	addi	a4,a4,1122 # 8001b2d8 <devsw>
    80003e7e:	97ba                	add	a5,a5,a4
    80003e80:	679c                	ld	a5,8(a5)
    80003e82:	c3f9                	beqz	a5,80003f48 <filewrite+0x13e>
    ret = devsw[f->major].write(1, addr, n);
    80003e84:	4505                	li	a0,1
    80003e86:	9782                	jalr	a5
    80003e88:	a841                	j	80003f18 <filewrite+0x10e>
      if(n1 > max)
    80003e8a:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80003e8e:	00000097          	auipc	ra,0x0
    80003e92:	88c080e7          	jalr	-1908(ra) # 8000371a <begin_op>
      ilock(f->ip);
    80003e96:	01893503          	ld	a0,24(s2)
    80003e9a:	fffff097          	auipc	ra,0xfffff
    80003e9e:	e06080e7          	jalr	-506(ra) # 80002ca0 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003ea2:	8756                	mv	a4,s5
    80003ea4:	02092683          	lw	a3,32(s2)
    80003ea8:	01698633          	add	a2,s3,s6
    80003eac:	4585                	li	a1,1
    80003eae:	01893503          	ld	a0,24(s2)
    80003eb2:	fffff097          	auipc	ra,0xfffff
    80003eb6:	260080e7          	jalr	608(ra) # 80003112 <writei>
    80003eba:	84aa                	mv	s1,a0
    80003ebc:	00a05763          	blez	a0,80003eca <filewrite+0xc0>
        f->off += r;
    80003ec0:	02092783          	lw	a5,32(s2)
    80003ec4:	9fa9                	addw	a5,a5,a0
    80003ec6:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003eca:	01893503          	ld	a0,24(s2)
    80003ece:	fffff097          	auipc	ra,0xfffff
    80003ed2:	e98080e7          	jalr	-360(ra) # 80002d66 <iunlock>
      end_op();
    80003ed6:	00000097          	auipc	ra,0x0
    80003eda:	8be080e7          	jalr	-1858(ra) # 80003794 <end_op>

      if(r != n1){
    80003ede:	029a9563          	bne	s5,s1,80003f08 <filewrite+0xfe>
        // error from writei
        break;
      }
      i += r;
    80003ee2:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003ee6:	0149da63          	bge	s3,s4,80003efa <filewrite+0xf0>
      int n1 = n - i;
    80003eea:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80003eee:	0004879b          	sext.w	a5,s1
    80003ef2:	f8fbdce3          	bge	s7,a5,80003e8a <filewrite+0x80>
    80003ef6:	84e2                	mv	s1,s8
    80003ef8:	bf49                	j	80003e8a <filewrite+0x80>
    80003efa:	74e2                	ld	s1,56(sp)
    80003efc:	6ae2                	ld	s5,24(sp)
    80003efe:	6ba2                	ld	s7,8(sp)
    80003f00:	6c02                	ld	s8,0(sp)
    80003f02:	a039                	j	80003f10 <filewrite+0x106>
    int i = 0;
    80003f04:	4981                	li	s3,0
    80003f06:	a029                	j	80003f10 <filewrite+0x106>
    80003f08:	74e2                	ld	s1,56(sp)
    80003f0a:	6ae2                	ld	s5,24(sp)
    80003f0c:	6ba2                	ld	s7,8(sp)
    80003f0e:	6c02                	ld	s8,0(sp)
    }
    ret = (i == n ? n : -1);
    80003f10:	033a1e63          	bne	s4,s3,80003f4c <filewrite+0x142>
    80003f14:	8552                	mv	a0,s4
    80003f16:	79a2                	ld	s3,40(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003f18:	60a6                	ld	ra,72(sp)
    80003f1a:	6406                	ld	s0,64(sp)
    80003f1c:	7942                	ld	s2,48(sp)
    80003f1e:	7a02                	ld	s4,32(sp)
    80003f20:	6b42                	ld	s6,16(sp)
    80003f22:	6161                	addi	sp,sp,80
    80003f24:	8082                	ret
    80003f26:	fc26                	sd	s1,56(sp)
    80003f28:	f44e                	sd	s3,40(sp)
    80003f2a:	ec56                	sd	s5,24(sp)
    80003f2c:	e45e                	sd	s7,8(sp)
    80003f2e:	e062                	sd	s8,0(sp)
    panic("filewrite");
    80003f30:	00004517          	auipc	a0,0x4
    80003f34:	65050513          	addi	a0,a0,1616 # 80008580 <etext+0x580>
    80003f38:	00002097          	auipc	ra,0x2
    80003f3c:	fda080e7          	jalr	-38(ra) # 80005f12 <panic>
    return -1;
    80003f40:	557d                	li	a0,-1
}
    80003f42:	8082                	ret
      return -1;
    80003f44:	557d                	li	a0,-1
    80003f46:	bfc9                	j	80003f18 <filewrite+0x10e>
    80003f48:	557d                	li	a0,-1
    80003f4a:	b7f9                	j	80003f18 <filewrite+0x10e>
    ret = (i == n ? n : -1);
    80003f4c:	557d                	li	a0,-1
    80003f4e:	79a2                	ld	s3,40(sp)
    80003f50:	b7e1                	j	80003f18 <filewrite+0x10e>

0000000080003f52 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f52:	7179                	addi	sp,sp,-48
    80003f54:	f406                	sd	ra,40(sp)
    80003f56:	f022                	sd	s0,32(sp)
    80003f58:	ec26                	sd	s1,24(sp)
    80003f5a:	e052                	sd	s4,0(sp)
    80003f5c:	1800                	addi	s0,sp,48
    80003f5e:	84aa                	mv	s1,a0
    80003f60:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f62:	0005b023          	sd	zero,0(a1)
    80003f66:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f6a:	00000097          	auipc	ra,0x0
    80003f6e:	bbe080e7          	jalr	-1090(ra) # 80003b28 <filealloc>
    80003f72:	e088                	sd	a0,0(s1)
    80003f74:	cd49                	beqz	a0,8000400e <pipealloc+0xbc>
    80003f76:	00000097          	auipc	ra,0x0
    80003f7a:	bb2080e7          	jalr	-1102(ra) # 80003b28 <filealloc>
    80003f7e:	00aa3023          	sd	a0,0(s4)
    80003f82:	c141                	beqz	a0,80004002 <pipealloc+0xb0>
    80003f84:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f86:	ffffc097          	auipc	ra,0xffffc
    80003f8a:	194080e7          	jalr	404(ra) # 8000011a <kalloc>
    80003f8e:	892a                	mv	s2,a0
    80003f90:	c13d                	beqz	a0,80003ff6 <pipealloc+0xa4>
    80003f92:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003f94:	4985                	li	s3,1
    80003f96:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003f9a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003f9e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003fa2:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003fa6:	00004597          	auipc	a1,0x4
    80003faa:	5ea58593          	addi	a1,a1,1514 # 80008590 <etext+0x590>
    80003fae:	00002097          	auipc	ra,0x2
    80003fb2:	44e080e7          	jalr	1102(ra) # 800063fc <initlock>
  (*f0)->type = FD_PIPE;
    80003fb6:	609c                	ld	a5,0(s1)
    80003fb8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003fbc:	609c                	ld	a5,0(s1)
    80003fbe:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003fc2:	609c                	ld	a5,0(s1)
    80003fc4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003fc8:	609c                	ld	a5,0(s1)
    80003fca:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003fce:	000a3783          	ld	a5,0(s4)
    80003fd2:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003fd6:	000a3783          	ld	a5,0(s4)
    80003fda:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003fde:	000a3783          	ld	a5,0(s4)
    80003fe2:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003fe6:	000a3783          	ld	a5,0(s4)
    80003fea:	0127b823          	sd	s2,16(a5)
  return 0;
    80003fee:	4501                	li	a0,0
    80003ff0:	6942                	ld	s2,16(sp)
    80003ff2:	69a2                	ld	s3,8(sp)
    80003ff4:	a03d                	j	80004022 <pipealloc+0xd0>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003ff6:	6088                	ld	a0,0(s1)
    80003ff8:	c119                	beqz	a0,80003ffe <pipealloc+0xac>
    80003ffa:	6942                	ld	s2,16(sp)
    80003ffc:	a029                	j	80004006 <pipealloc+0xb4>
    80003ffe:	6942                	ld	s2,16(sp)
    80004000:	a039                	j	8000400e <pipealloc+0xbc>
    80004002:	6088                	ld	a0,0(s1)
    80004004:	c50d                	beqz	a0,8000402e <pipealloc+0xdc>
    fileclose(*f0);
    80004006:	00000097          	auipc	ra,0x0
    8000400a:	bde080e7          	jalr	-1058(ra) # 80003be4 <fileclose>
  if(*f1)
    8000400e:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004012:	557d                	li	a0,-1
  if(*f1)
    80004014:	c799                	beqz	a5,80004022 <pipealloc+0xd0>
    fileclose(*f1);
    80004016:	853e                	mv	a0,a5
    80004018:	00000097          	auipc	ra,0x0
    8000401c:	bcc080e7          	jalr	-1076(ra) # 80003be4 <fileclose>
  return -1;
    80004020:	557d                	li	a0,-1
}
    80004022:	70a2                	ld	ra,40(sp)
    80004024:	7402                	ld	s0,32(sp)
    80004026:	64e2                	ld	s1,24(sp)
    80004028:	6a02                	ld	s4,0(sp)
    8000402a:	6145                	addi	sp,sp,48
    8000402c:	8082                	ret
  return -1;
    8000402e:	557d                	li	a0,-1
    80004030:	bfcd                	j	80004022 <pipealloc+0xd0>

0000000080004032 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004032:	1101                	addi	sp,sp,-32
    80004034:	ec06                	sd	ra,24(sp)
    80004036:	e822                	sd	s0,16(sp)
    80004038:	e426                	sd	s1,8(sp)
    8000403a:	e04a                	sd	s2,0(sp)
    8000403c:	1000                	addi	s0,sp,32
    8000403e:	84aa                	mv	s1,a0
    80004040:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004042:	00002097          	auipc	ra,0x2
    80004046:	44a080e7          	jalr	1098(ra) # 8000648c <acquire>
  if(writable){
    8000404a:	02090d63          	beqz	s2,80004084 <pipeclose+0x52>
    pi->writeopen = 0;
    8000404e:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004052:	21848513          	addi	a0,s1,536
    80004056:	ffffd097          	auipc	ra,0xffffd
    8000405a:	5c2080e7          	jalr	1474(ra) # 80001618 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000405e:	2204b783          	ld	a5,544(s1)
    80004062:	eb95                	bnez	a5,80004096 <pipeclose+0x64>
    release(&pi->lock);
    80004064:	8526                	mv	a0,s1
    80004066:	00002097          	auipc	ra,0x2
    8000406a:	4da080e7          	jalr	1242(ra) # 80006540 <release>
    kfree((char*)pi);
    8000406e:	8526                	mv	a0,s1
    80004070:	ffffc097          	auipc	ra,0xffffc
    80004074:	fac080e7          	jalr	-84(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004078:	60e2                	ld	ra,24(sp)
    8000407a:	6442                	ld	s0,16(sp)
    8000407c:	64a2                	ld	s1,8(sp)
    8000407e:	6902                	ld	s2,0(sp)
    80004080:	6105                	addi	sp,sp,32
    80004082:	8082                	ret
    pi->readopen = 0;
    80004084:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004088:	21c48513          	addi	a0,s1,540
    8000408c:	ffffd097          	auipc	ra,0xffffd
    80004090:	58c080e7          	jalr	1420(ra) # 80001618 <wakeup>
    80004094:	b7e9                	j	8000405e <pipeclose+0x2c>
    release(&pi->lock);
    80004096:	8526                	mv	a0,s1
    80004098:	00002097          	auipc	ra,0x2
    8000409c:	4a8080e7          	jalr	1192(ra) # 80006540 <release>
}
    800040a0:	bfe1                	j	80004078 <pipeclose+0x46>

00000000800040a2 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800040a2:	711d                	addi	sp,sp,-96
    800040a4:	ec86                	sd	ra,88(sp)
    800040a6:	e8a2                	sd	s0,80(sp)
    800040a8:	e4a6                	sd	s1,72(sp)
    800040aa:	e0ca                	sd	s2,64(sp)
    800040ac:	fc4e                	sd	s3,56(sp)
    800040ae:	f852                	sd	s4,48(sp)
    800040b0:	f456                	sd	s5,40(sp)
    800040b2:	1080                	addi	s0,sp,96
    800040b4:	84aa                	mv	s1,a0
    800040b6:	8aae                	mv	s5,a1
    800040b8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800040ba:	ffffd097          	auipc	ra,0xffffd
    800040be:	e4c080e7          	jalr	-436(ra) # 80000f06 <myproc>
    800040c2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800040c4:	8526                	mv	a0,s1
    800040c6:	00002097          	auipc	ra,0x2
    800040ca:	3c6080e7          	jalr	966(ra) # 8000648c <acquire>
  while(i < n){
    800040ce:	0d405863          	blez	s4,8000419e <pipewrite+0xfc>
    800040d2:	f05a                	sd	s6,32(sp)
    800040d4:	ec5e                	sd	s7,24(sp)
    800040d6:	e862                	sd	s8,16(sp)
  int i = 0;
    800040d8:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040da:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800040dc:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800040e0:	21c48b93          	addi	s7,s1,540
    800040e4:	a089                	j	80004126 <pipewrite+0x84>
      release(&pi->lock);
    800040e6:	8526                	mv	a0,s1
    800040e8:	00002097          	auipc	ra,0x2
    800040ec:	458080e7          	jalr	1112(ra) # 80006540 <release>
      return -1;
    800040f0:	597d                	li	s2,-1
    800040f2:	7b02                	ld	s6,32(sp)
    800040f4:	6be2                	ld	s7,24(sp)
    800040f6:	6c42                	ld	s8,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800040f8:	854a                	mv	a0,s2
    800040fa:	60e6                	ld	ra,88(sp)
    800040fc:	6446                	ld	s0,80(sp)
    800040fe:	64a6                	ld	s1,72(sp)
    80004100:	6906                	ld	s2,64(sp)
    80004102:	79e2                	ld	s3,56(sp)
    80004104:	7a42                	ld	s4,48(sp)
    80004106:	7aa2                	ld	s5,40(sp)
    80004108:	6125                	addi	sp,sp,96
    8000410a:	8082                	ret
      wakeup(&pi->nread);
    8000410c:	8562                	mv	a0,s8
    8000410e:	ffffd097          	auipc	ra,0xffffd
    80004112:	50a080e7          	jalr	1290(ra) # 80001618 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004116:	85a6                	mv	a1,s1
    80004118:	855e                	mv	a0,s7
    8000411a:	ffffd097          	auipc	ra,0xffffd
    8000411e:	49a080e7          	jalr	1178(ra) # 800015b4 <sleep>
  while(i < n){
    80004122:	05495f63          	bge	s2,s4,80004180 <pipewrite+0xde>
    if(pi->readopen == 0 || killed(pr)){
    80004126:	2204a783          	lw	a5,544(s1)
    8000412a:	dfd5                	beqz	a5,800040e6 <pipewrite+0x44>
    8000412c:	854e                	mv	a0,s3
    8000412e:	ffffd097          	auipc	ra,0xffffd
    80004132:	72e080e7          	jalr	1838(ra) # 8000185c <killed>
    80004136:	f945                	bnez	a0,800040e6 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004138:	2184a783          	lw	a5,536(s1)
    8000413c:	21c4a703          	lw	a4,540(s1)
    80004140:	2007879b          	addiw	a5,a5,512
    80004144:	fcf704e3          	beq	a4,a5,8000410c <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004148:	4685                	li	a3,1
    8000414a:	01590633          	add	a2,s2,s5
    8000414e:	faf40593          	addi	a1,s0,-81
    80004152:	0509b503          	ld	a0,80(s3)
    80004156:	ffffd097          	auipc	ra,0xffffd
    8000415a:	ad4080e7          	jalr	-1324(ra) # 80000c2a <copyin>
    8000415e:	05650263          	beq	a0,s6,800041a2 <pipewrite+0x100>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004162:	21c4a783          	lw	a5,540(s1)
    80004166:	0017871b          	addiw	a4,a5,1
    8000416a:	20e4ae23          	sw	a4,540(s1)
    8000416e:	1ff7f793          	andi	a5,a5,511
    80004172:	97a6                	add	a5,a5,s1
    80004174:	faf44703          	lbu	a4,-81(s0)
    80004178:	00e78c23          	sb	a4,24(a5)
      i++;
    8000417c:	2905                	addiw	s2,s2,1
    8000417e:	b755                	j	80004122 <pipewrite+0x80>
    80004180:	7b02                	ld	s6,32(sp)
    80004182:	6be2                	ld	s7,24(sp)
    80004184:	6c42                	ld	s8,16(sp)
  wakeup(&pi->nread);
    80004186:	21848513          	addi	a0,s1,536
    8000418a:	ffffd097          	auipc	ra,0xffffd
    8000418e:	48e080e7          	jalr	1166(ra) # 80001618 <wakeup>
  release(&pi->lock);
    80004192:	8526                	mv	a0,s1
    80004194:	00002097          	auipc	ra,0x2
    80004198:	3ac080e7          	jalr	940(ra) # 80006540 <release>
  return i;
    8000419c:	bfb1                	j	800040f8 <pipewrite+0x56>
  int i = 0;
    8000419e:	4901                	li	s2,0
    800041a0:	b7dd                	j	80004186 <pipewrite+0xe4>
    800041a2:	7b02                	ld	s6,32(sp)
    800041a4:	6be2                	ld	s7,24(sp)
    800041a6:	6c42                	ld	s8,16(sp)
    800041a8:	bff9                	j	80004186 <pipewrite+0xe4>

00000000800041aa <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800041aa:	715d                	addi	sp,sp,-80
    800041ac:	e486                	sd	ra,72(sp)
    800041ae:	e0a2                	sd	s0,64(sp)
    800041b0:	fc26                	sd	s1,56(sp)
    800041b2:	f84a                	sd	s2,48(sp)
    800041b4:	f44e                	sd	s3,40(sp)
    800041b6:	f052                	sd	s4,32(sp)
    800041b8:	ec56                	sd	s5,24(sp)
    800041ba:	0880                	addi	s0,sp,80
    800041bc:	84aa                	mv	s1,a0
    800041be:	892e                	mv	s2,a1
    800041c0:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800041c2:	ffffd097          	auipc	ra,0xffffd
    800041c6:	d44080e7          	jalr	-700(ra) # 80000f06 <myproc>
    800041ca:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800041cc:	8526                	mv	a0,s1
    800041ce:	00002097          	auipc	ra,0x2
    800041d2:	2be080e7          	jalr	702(ra) # 8000648c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041d6:	2184a703          	lw	a4,536(s1)
    800041da:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041de:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041e2:	02f71963          	bne	a4,a5,80004214 <piperead+0x6a>
    800041e6:	2244a783          	lw	a5,548(s1)
    800041ea:	cf95                	beqz	a5,80004226 <piperead+0x7c>
    if(killed(pr)){
    800041ec:	8552                	mv	a0,s4
    800041ee:	ffffd097          	auipc	ra,0xffffd
    800041f2:	66e080e7          	jalr	1646(ra) # 8000185c <killed>
    800041f6:	e10d                	bnez	a0,80004218 <piperead+0x6e>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041f8:	85a6                	mv	a1,s1
    800041fa:	854e                	mv	a0,s3
    800041fc:	ffffd097          	auipc	ra,0xffffd
    80004200:	3b8080e7          	jalr	952(ra) # 800015b4 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004204:	2184a703          	lw	a4,536(s1)
    80004208:	21c4a783          	lw	a5,540(s1)
    8000420c:	fcf70de3          	beq	a4,a5,800041e6 <piperead+0x3c>
    80004210:	e85a                	sd	s6,16(sp)
    80004212:	a819                	j	80004228 <piperead+0x7e>
    80004214:	e85a                	sd	s6,16(sp)
    80004216:	a809                	j	80004228 <piperead+0x7e>
      release(&pi->lock);
    80004218:	8526                	mv	a0,s1
    8000421a:	00002097          	auipc	ra,0x2
    8000421e:	326080e7          	jalr	806(ra) # 80006540 <release>
      return -1;
    80004222:	59fd                	li	s3,-1
    80004224:	a0a5                	j	8000428c <piperead+0xe2>
    80004226:	e85a                	sd	s6,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004228:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000422a:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000422c:	05505463          	blez	s5,80004274 <piperead+0xca>
    if(pi->nread == pi->nwrite)
    80004230:	2184a783          	lw	a5,536(s1)
    80004234:	21c4a703          	lw	a4,540(s1)
    80004238:	02f70e63          	beq	a4,a5,80004274 <piperead+0xca>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000423c:	0017871b          	addiw	a4,a5,1
    80004240:	20e4ac23          	sw	a4,536(s1)
    80004244:	1ff7f793          	andi	a5,a5,511
    80004248:	97a6                	add	a5,a5,s1
    8000424a:	0187c783          	lbu	a5,24(a5)
    8000424e:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004252:	4685                	li	a3,1
    80004254:	fbf40613          	addi	a2,s0,-65
    80004258:	85ca                	mv	a1,s2
    8000425a:	050a3503          	ld	a0,80(s4)
    8000425e:	ffffd097          	auipc	ra,0xffffd
    80004262:	8ee080e7          	jalr	-1810(ra) # 80000b4c <copyout>
    80004266:	01650763          	beq	a0,s6,80004274 <piperead+0xca>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000426a:	2985                	addiw	s3,s3,1
    8000426c:	0905                	addi	s2,s2,1
    8000426e:	fd3a91e3          	bne	s5,s3,80004230 <piperead+0x86>
    80004272:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004274:	21c48513          	addi	a0,s1,540
    80004278:	ffffd097          	auipc	ra,0xffffd
    8000427c:	3a0080e7          	jalr	928(ra) # 80001618 <wakeup>
  release(&pi->lock);
    80004280:	8526                	mv	a0,s1
    80004282:	00002097          	auipc	ra,0x2
    80004286:	2be080e7          	jalr	702(ra) # 80006540 <release>
    8000428a:	6b42                	ld	s6,16(sp)
  return i;
}
    8000428c:	854e                	mv	a0,s3
    8000428e:	60a6                	ld	ra,72(sp)
    80004290:	6406                	ld	s0,64(sp)
    80004292:	74e2                	ld	s1,56(sp)
    80004294:	7942                	ld	s2,48(sp)
    80004296:	79a2                	ld	s3,40(sp)
    80004298:	7a02                	ld	s4,32(sp)
    8000429a:	6ae2                	ld	s5,24(sp)
    8000429c:	6161                	addi	sp,sp,80
    8000429e:	8082                	ret

00000000800042a0 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800042a0:	1141                	addi	sp,sp,-16
    800042a2:	e422                	sd	s0,8(sp)
    800042a4:	0800                	addi	s0,sp,16
    800042a6:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800042a8:	8905                	andi	a0,a0,1
    800042aa:	050e                	slli	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    800042ac:	8b89                	andi	a5,a5,2
    800042ae:	c399                	beqz	a5,800042b4 <flags2perm+0x14>
      perm |= PTE_W;
    800042b0:	00456513          	ori	a0,a0,4
    return perm;
}
    800042b4:	6422                	ld	s0,8(sp)
    800042b6:	0141                	addi	sp,sp,16
    800042b8:	8082                	ret

00000000800042ba <exec>:

int
exec(char *path, char **argv)
{
    800042ba:	df010113          	addi	sp,sp,-528
    800042be:	20113423          	sd	ra,520(sp)
    800042c2:	20813023          	sd	s0,512(sp)
    800042c6:	ffa6                	sd	s1,504(sp)
    800042c8:	fbca                	sd	s2,496(sp)
    800042ca:	0c00                	addi	s0,sp,528
    800042cc:	892a                	mv	s2,a0
    800042ce:	dea43c23          	sd	a0,-520(s0)
    800042d2:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800042d6:	ffffd097          	auipc	ra,0xffffd
    800042da:	c30080e7          	jalr	-976(ra) # 80000f06 <myproc>
    800042de:	84aa                	mv	s1,a0

  begin_op();
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	43a080e7          	jalr	1082(ra) # 8000371a <begin_op>

  if((ip = namei(path)) == 0){
    800042e8:	854a                	mv	a0,s2
    800042ea:	fffff097          	auipc	ra,0xfffff
    800042ee:	230080e7          	jalr	560(ra) # 8000351a <namei>
    800042f2:	c135                	beqz	a0,80004356 <exec+0x9c>
    800042f4:	f3d2                	sd	s4,480(sp)
    800042f6:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	9a8080e7          	jalr	-1624(ra) # 80002ca0 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004300:	04000713          	li	a4,64
    80004304:	4681                	li	a3,0
    80004306:	e5040613          	addi	a2,s0,-432
    8000430a:	4581                	li	a1,0
    8000430c:	8552                	mv	a0,s4
    8000430e:	fffff097          	auipc	ra,0xfffff
    80004312:	cf4080e7          	jalr	-780(ra) # 80003002 <readi>
    80004316:	04000793          	li	a5,64
    8000431a:	00f51a63          	bne	a0,a5,8000432e <exec+0x74>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    8000431e:	e5042703          	lw	a4,-432(s0)
    80004322:	464c47b7          	lui	a5,0x464c4
    80004326:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000432a:	02f70c63          	beq	a4,a5,80004362 <exec+0xa8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000432e:	8552                	mv	a0,s4
    80004330:	fffff097          	auipc	ra,0xfffff
    80004334:	c80080e7          	jalr	-896(ra) # 80002fb0 <iunlockput>
    end_op();
    80004338:	fffff097          	auipc	ra,0xfffff
    8000433c:	45c080e7          	jalr	1116(ra) # 80003794 <end_op>
  }
  return -1;
    80004340:	557d                	li	a0,-1
    80004342:	7a1e                	ld	s4,480(sp)
}
    80004344:	20813083          	ld	ra,520(sp)
    80004348:	20013403          	ld	s0,512(sp)
    8000434c:	74fe                	ld	s1,504(sp)
    8000434e:	795e                	ld	s2,496(sp)
    80004350:	21010113          	addi	sp,sp,528
    80004354:	8082                	ret
    end_op();
    80004356:	fffff097          	auipc	ra,0xfffff
    8000435a:	43e080e7          	jalr	1086(ra) # 80003794 <end_op>
    return -1;
    8000435e:	557d                	li	a0,-1
    80004360:	b7d5                	j	80004344 <exec+0x8a>
    80004362:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004364:	8526                	mv	a0,s1
    80004366:	ffffd097          	auipc	ra,0xffffd
    8000436a:	c68080e7          	jalr	-920(ra) # 80000fce <proc_pagetable>
    8000436e:	8b2a                	mv	s6,a0
    80004370:	30050f63          	beqz	a0,8000468e <exec+0x3d4>
    80004374:	f7ce                	sd	s3,488(sp)
    80004376:	efd6                	sd	s5,472(sp)
    80004378:	e7de                	sd	s7,456(sp)
    8000437a:	e3e2                	sd	s8,448(sp)
    8000437c:	ff66                	sd	s9,440(sp)
    8000437e:	fb6a                	sd	s10,432(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004380:	e7042d03          	lw	s10,-400(s0)
    80004384:	e8845783          	lhu	a5,-376(s0)
    80004388:	14078d63          	beqz	a5,800044e2 <exec+0x228>
    8000438c:	f76e                	sd	s11,424(sp)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000438e:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004390:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80004392:	6c85                	lui	s9,0x1
    80004394:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80004398:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    8000439c:	6a85                	lui	s5,0x1
    8000439e:	a0b5                	j	8000440a <exec+0x150>
      panic("loadseg: address should exist");
    800043a0:	00004517          	auipc	a0,0x4
    800043a4:	1f850513          	addi	a0,a0,504 # 80008598 <etext+0x598>
    800043a8:	00002097          	auipc	ra,0x2
    800043ac:	b6a080e7          	jalr	-1174(ra) # 80005f12 <panic>
    if(sz - i < PGSIZE)
    800043b0:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800043b2:	8726                	mv	a4,s1
    800043b4:	012c06bb          	addw	a3,s8,s2
    800043b8:	4581                	li	a1,0
    800043ba:	8552                	mv	a0,s4
    800043bc:	fffff097          	auipc	ra,0xfffff
    800043c0:	c46080e7          	jalr	-954(ra) # 80003002 <readi>
    800043c4:	2501                	sext.w	a0,a0
    800043c6:	28a49863          	bne	s1,a0,80004656 <exec+0x39c>
  for(i = 0; i < sz; i += PGSIZE){
    800043ca:	012a893b          	addw	s2,s5,s2
    800043ce:	03397563          	bgeu	s2,s3,800043f8 <exec+0x13e>
    pa = walkaddr(pagetable, va + i);
    800043d2:	02091593          	slli	a1,s2,0x20
    800043d6:	9181                	srli	a1,a1,0x20
    800043d8:	95de                	add	a1,a1,s7
    800043da:	855a                	mv	a0,s6
    800043dc:	ffffc097          	auipc	ra,0xffffc
    800043e0:	120080e7          	jalr	288(ra) # 800004fc <walkaddr>
    800043e4:	862a                	mv	a2,a0
    if(pa == 0)
    800043e6:	dd4d                	beqz	a0,800043a0 <exec+0xe6>
    if(sz - i < PGSIZE)
    800043e8:	412984bb          	subw	s1,s3,s2
    800043ec:	0004879b          	sext.w	a5,s1
    800043f0:	fcfcf0e3          	bgeu	s9,a5,800043b0 <exec+0xf6>
    800043f4:	84d6                	mv	s1,s5
    800043f6:	bf6d                	j	800043b0 <exec+0xf6>
    sz = sz1;
    800043f8:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800043fc:	2d85                	addiw	s11,s11,1
    800043fe:	038d0d1b          	addiw	s10,s10,56 # 1038 <_entry-0x7fffefc8>
    80004402:	e8845783          	lhu	a5,-376(s0)
    80004406:	08fdd663          	bge	s11,a5,80004492 <exec+0x1d8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000440a:	2d01                	sext.w	s10,s10
    8000440c:	03800713          	li	a4,56
    80004410:	86ea                	mv	a3,s10
    80004412:	e1840613          	addi	a2,s0,-488
    80004416:	4581                	li	a1,0
    80004418:	8552                	mv	a0,s4
    8000441a:	fffff097          	auipc	ra,0xfffff
    8000441e:	be8080e7          	jalr	-1048(ra) # 80003002 <readi>
    80004422:	03800793          	li	a5,56
    80004426:	20f51063          	bne	a0,a5,80004626 <exec+0x36c>
    if(ph.type != ELF_PROG_LOAD)
    8000442a:	e1842783          	lw	a5,-488(s0)
    8000442e:	4705                	li	a4,1
    80004430:	fce796e3          	bne	a5,a4,800043fc <exec+0x142>
    if(ph.memsz < ph.filesz)
    80004434:	e4043483          	ld	s1,-448(s0)
    80004438:	e3843783          	ld	a5,-456(s0)
    8000443c:	1ef4e963          	bltu	s1,a5,8000462e <exec+0x374>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004440:	e2843783          	ld	a5,-472(s0)
    80004444:	94be                	add	s1,s1,a5
    80004446:	1ef4e863          	bltu	s1,a5,80004636 <exec+0x37c>
    if(ph.vaddr % PGSIZE != 0)
    8000444a:	df043703          	ld	a4,-528(s0)
    8000444e:	8ff9                	and	a5,a5,a4
    80004450:	1e079763          	bnez	a5,8000463e <exec+0x384>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004454:	e1c42503          	lw	a0,-484(s0)
    80004458:	00000097          	auipc	ra,0x0
    8000445c:	e48080e7          	jalr	-440(ra) # 800042a0 <flags2perm>
    80004460:	86aa                	mv	a3,a0
    80004462:	8626                	mv	a2,s1
    80004464:	85ca                	mv	a1,s2
    80004466:	855a                	mv	a0,s6
    80004468:	ffffc097          	auipc	ra,0xffffc
    8000446c:	47c080e7          	jalr	1148(ra) # 800008e4 <uvmalloc>
    80004470:	e0a43423          	sd	a0,-504(s0)
    80004474:	1c050963          	beqz	a0,80004646 <exec+0x38c>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004478:	e2843b83          	ld	s7,-472(s0)
    8000447c:	e2042c03          	lw	s8,-480(s0)
    80004480:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004484:	00098463          	beqz	s3,8000448c <exec+0x1d2>
    80004488:	4901                	li	s2,0
    8000448a:	b7a1                	j	800043d2 <exec+0x118>
    sz = sz1;
    8000448c:	e0843903          	ld	s2,-504(s0)
    80004490:	b7b5                	j	800043fc <exec+0x142>
    80004492:	7dba                	ld	s11,424(sp)
  iunlockput(ip);
    80004494:	8552                	mv	a0,s4
    80004496:	fffff097          	auipc	ra,0xfffff
    8000449a:	b1a080e7          	jalr	-1254(ra) # 80002fb0 <iunlockput>
  end_op();
    8000449e:	fffff097          	auipc	ra,0xfffff
    800044a2:	2f6080e7          	jalr	758(ra) # 80003794 <end_op>
  p = myproc();
    800044a6:	ffffd097          	auipc	ra,0xffffd
    800044aa:	a60080e7          	jalr	-1440(ra) # 80000f06 <myproc>
    800044ae:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800044b0:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    800044b4:	6985                	lui	s3,0x1
    800044b6:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    800044b8:	99ca                	add	s3,s3,s2
    800044ba:	77fd                	lui	a5,0xfffff
    800044bc:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800044c0:	4691                	li	a3,4
    800044c2:	6609                	lui	a2,0x2
    800044c4:	964e                	add	a2,a2,s3
    800044c6:	85ce                	mv	a1,s3
    800044c8:	855a                	mv	a0,s6
    800044ca:	ffffc097          	auipc	ra,0xffffc
    800044ce:	41a080e7          	jalr	1050(ra) # 800008e4 <uvmalloc>
    800044d2:	892a                	mv	s2,a0
    800044d4:	e0a43423          	sd	a0,-504(s0)
    800044d8:	e519                	bnez	a0,800044e6 <exec+0x22c>
  if(pagetable)
    800044da:	e1343423          	sd	s3,-504(s0)
    800044de:	4a01                	li	s4,0
    800044e0:	aaa5                	j	80004658 <exec+0x39e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800044e2:	4901                	li	s2,0
    800044e4:	bf45                	j	80004494 <exec+0x1da>
  uvmclear(pagetable, sz-2*PGSIZE);
    800044e6:	75f9                	lui	a1,0xffffe
    800044e8:	95aa                	add	a1,a1,a0
    800044ea:	855a                	mv	a0,s6
    800044ec:	ffffc097          	auipc	ra,0xffffc
    800044f0:	62e080e7          	jalr	1582(ra) # 80000b1a <uvmclear>
  stackbase = sp - PGSIZE;
    800044f4:	7bfd                	lui	s7,0xfffff
    800044f6:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    800044f8:	e0043783          	ld	a5,-512(s0)
    800044fc:	6388                	ld	a0,0(a5)
    800044fe:	c52d                	beqz	a0,80004568 <exec+0x2ae>
    80004500:	e9040993          	addi	s3,s0,-368
    80004504:	f9040c13          	addi	s8,s0,-112
    80004508:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    8000450a:	ffffc097          	auipc	ra,0xffffc
    8000450e:	de4080e7          	jalr	-540(ra) # 800002ee <strlen>
    80004512:	0015079b          	addiw	a5,a0,1
    80004516:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000451a:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    8000451e:	13796863          	bltu	s2,s7,8000464e <exec+0x394>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004522:	e0043d03          	ld	s10,-512(s0)
    80004526:	000d3a03          	ld	s4,0(s10)
    8000452a:	8552                	mv	a0,s4
    8000452c:	ffffc097          	auipc	ra,0xffffc
    80004530:	dc2080e7          	jalr	-574(ra) # 800002ee <strlen>
    80004534:	0015069b          	addiw	a3,a0,1
    80004538:	8652                	mv	a2,s4
    8000453a:	85ca                	mv	a1,s2
    8000453c:	855a                	mv	a0,s6
    8000453e:	ffffc097          	auipc	ra,0xffffc
    80004542:	60e080e7          	jalr	1550(ra) # 80000b4c <copyout>
    80004546:	10054663          	bltz	a0,80004652 <exec+0x398>
    ustack[argc] = sp;
    8000454a:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000454e:	0485                	addi	s1,s1,1
    80004550:	008d0793          	addi	a5,s10,8
    80004554:	e0f43023          	sd	a5,-512(s0)
    80004558:	008d3503          	ld	a0,8(s10)
    8000455c:	c909                	beqz	a0,8000456e <exec+0x2b4>
    if(argc >= MAXARG)
    8000455e:	09a1                	addi	s3,s3,8
    80004560:	fb8995e3          	bne	s3,s8,8000450a <exec+0x250>
  ip = 0;
    80004564:	4a01                	li	s4,0
    80004566:	a8cd                	j	80004658 <exec+0x39e>
  sp = sz;
    80004568:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    8000456c:	4481                	li	s1,0
  ustack[argc] = 0;
    8000456e:	00349793          	slli	a5,s1,0x3
    80004572:	f9078793          	addi	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffda8e0>
    80004576:	97a2                	add	a5,a5,s0
    80004578:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    8000457c:	00148693          	addi	a3,s1,1
    80004580:	068e                	slli	a3,a3,0x3
    80004582:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004586:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    8000458a:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    8000458e:	f57966e3          	bltu	s2,s7,800044da <exec+0x220>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004592:	e9040613          	addi	a2,s0,-368
    80004596:	85ca                	mv	a1,s2
    80004598:	855a                	mv	a0,s6
    8000459a:	ffffc097          	auipc	ra,0xffffc
    8000459e:	5b2080e7          	jalr	1458(ra) # 80000b4c <copyout>
    800045a2:	0e054863          	bltz	a0,80004692 <exec+0x3d8>
  p->trapframe->a1 = sp;
    800045a6:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    800045aa:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800045ae:	df843783          	ld	a5,-520(s0)
    800045b2:	0007c703          	lbu	a4,0(a5)
    800045b6:	cf11                	beqz	a4,800045d2 <exec+0x318>
    800045b8:	0785                	addi	a5,a5,1
    if(*s == '/')
    800045ba:	02f00693          	li	a3,47
    800045be:	a039                	j	800045cc <exec+0x312>
      last = s+1;
    800045c0:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    800045c4:	0785                	addi	a5,a5,1
    800045c6:	fff7c703          	lbu	a4,-1(a5)
    800045ca:	c701                	beqz	a4,800045d2 <exec+0x318>
    if(*s == '/')
    800045cc:	fed71ce3          	bne	a4,a3,800045c4 <exec+0x30a>
    800045d0:	bfc5                	j	800045c0 <exec+0x306>
  safestrcpy(p->name, last, sizeof(p->name));
    800045d2:	4641                	li	a2,16
    800045d4:	df843583          	ld	a1,-520(s0)
    800045d8:	158a8513          	addi	a0,s5,344
    800045dc:	ffffc097          	auipc	ra,0xffffc
    800045e0:	ce0080e7          	jalr	-800(ra) # 800002bc <safestrcpy>
  oldpagetable = p->pagetable;
    800045e4:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800045e8:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800045ec:	e0843783          	ld	a5,-504(s0)
    800045f0:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800045f4:	058ab783          	ld	a5,88(s5)
    800045f8:	e6843703          	ld	a4,-408(s0)
    800045fc:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800045fe:	058ab783          	ld	a5,88(s5)
    80004602:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004606:	85e6                	mv	a1,s9
    80004608:	ffffd097          	auipc	ra,0xffffd
    8000460c:	a62080e7          	jalr	-1438(ra) # 8000106a <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004610:	0004851b          	sext.w	a0,s1
    80004614:	79be                	ld	s3,488(sp)
    80004616:	7a1e                	ld	s4,480(sp)
    80004618:	6afe                	ld	s5,472(sp)
    8000461a:	6b5e                	ld	s6,464(sp)
    8000461c:	6bbe                	ld	s7,456(sp)
    8000461e:	6c1e                	ld	s8,448(sp)
    80004620:	7cfa                	ld	s9,440(sp)
    80004622:	7d5a                	ld	s10,432(sp)
    80004624:	b305                	j	80004344 <exec+0x8a>
    80004626:	e1243423          	sd	s2,-504(s0)
    8000462a:	7dba                	ld	s11,424(sp)
    8000462c:	a035                	j	80004658 <exec+0x39e>
    8000462e:	e1243423          	sd	s2,-504(s0)
    80004632:	7dba                	ld	s11,424(sp)
    80004634:	a015                	j	80004658 <exec+0x39e>
    80004636:	e1243423          	sd	s2,-504(s0)
    8000463a:	7dba                	ld	s11,424(sp)
    8000463c:	a831                	j	80004658 <exec+0x39e>
    8000463e:	e1243423          	sd	s2,-504(s0)
    80004642:	7dba                	ld	s11,424(sp)
    80004644:	a811                	j	80004658 <exec+0x39e>
    80004646:	e1243423          	sd	s2,-504(s0)
    8000464a:	7dba                	ld	s11,424(sp)
    8000464c:	a031                	j	80004658 <exec+0x39e>
  ip = 0;
    8000464e:	4a01                	li	s4,0
    80004650:	a021                	j	80004658 <exec+0x39e>
    80004652:	4a01                	li	s4,0
  if(pagetable)
    80004654:	a011                	j	80004658 <exec+0x39e>
    80004656:	7dba                	ld	s11,424(sp)
    proc_freepagetable(pagetable, sz);
    80004658:	e0843583          	ld	a1,-504(s0)
    8000465c:	855a                	mv	a0,s6
    8000465e:	ffffd097          	auipc	ra,0xffffd
    80004662:	a0c080e7          	jalr	-1524(ra) # 8000106a <proc_freepagetable>
  return -1;
    80004666:	557d                	li	a0,-1
  if(ip){
    80004668:	000a1b63          	bnez	s4,8000467e <exec+0x3c4>
    8000466c:	79be                	ld	s3,488(sp)
    8000466e:	7a1e                	ld	s4,480(sp)
    80004670:	6afe                	ld	s5,472(sp)
    80004672:	6b5e                	ld	s6,464(sp)
    80004674:	6bbe                	ld	s7,456(sp)
    80004676:	6c1e                	ld	s8,448(sp)
    80004678:	7cfa                	ld	s9,440(sp)
    8000467a:	7d5a                	ld	s10,432(sp)
    8000467c:	b1e1                	j	80004344 <exec+0x8a>
    8000467e:	79be                	ld	s3,488(sp)
    80004680:	6afe                	ld	s5,472(sp)
    80004682:	6b5e                	ld	s6,464(sp)
    80004684:	6bbe                	ld	s7,456(sp)
    80004686:	6c1e                	ld	s8,448(sp)
    80004688:	7cfa                	ld	s9,440(sp)
    8000468a:	7d5a                	ld	s10,432(sp)
    8000468c:	b14d                	j	8000432e <exec+0x74>
    8000468e:	6b5e                	ld	s6,464(sp)
    80004690:	b979                	j	8000432e <exec+0x74>
  sz = sz1;
    80004692:	e0843983          	ld	s3,-504(s0)
    80004696:	b591                	j	800044da <exec+0x220>

0000000080004698 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004698:	7179                	addi	sp,sp,-48
    8000469a:	f406                	sd	ra,40(sp)
    8000469c:	f022                	sd	s0,32(sp)
    8000469e:	ec26                	sd	s1,24(sp)
    800046a0:	e84a                	sd	s2,16(sp)
    800046a2:	1800                	addi	s0,sp,48
    800046a4:	892e                	mv	s2,a1
    800046a6:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    800046a8:	fdc40593          	addi	a1,s0,-36
    800046ac:	ffffe097          	auipc	ra,0xffffe
    800046b0:	97e080e7          	jalr	-1666(ra) # 8000202a <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800046b4:	fdc42703          	lw	a4,-36(s0)
    800046b8:	47bd                	li	a5,15
    800046ba:	02e7eb63          	bltu	a5,a4,800046f0 <argfd+0x58>
    800046be:	ffffd097          	auipc	ra,0xffffd
    800046c2:	848080e7          	jalr	-1976(ra) # 80000f06 <myproc>
    800046c6:	fdc42703          	lw	a4,-36(s0)
    800046ca:	01a70793          	addi	a5,a4,26
    800046ce:	078e                	slli	a5,a5,0x3
    800046d0:	953e                	add	a0,a0,a5
    800046d2:	611c                	ld	a5,0(a0)
    800046d4:	c385                	beqz	a5,800046f4 <argfd+0x5c>
    return -1;
  if(pfd)
    800046d6:	00090463          	beqz	s2,800046de <argfd+0x46>
    *pfd = fd;
    800046da:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800046de:	4501                	li	a0,0
  if(pf)
    800046e0:	c091                	beqz	s1,800046e4 <argfd+0x4c>
    *pf = f;
    800046e2:	e09c                	sd	a5,0(s1)
}
    800046e4:	70a2                	ld	ra,40(sp)
    800046e6:	7402                	ld	s0,32(sp)
    800046e8:	64e2                	ld	s1,24(sp)
    800046ea:	6942                	ld	s2,16(sp)
    800046ec:	6145                	addi	sp,sp,48
    800046ee:	8082                	ret
    return -1;
    800046f0:	557d                	li	a0,-1
    800046f2:	bfcd                	j	800046e4 <argfd+0x4c>
    800046f4:	557d                	li	a0,-1
    800046f6:	b7fd                	j	800046e4 <argfd+0x4c>

00000000800046f8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800046f8:	1101                	addi	sp,sp,-32
    800046fa:	ec06                	sd	ra,24(sp)
    800046fc:	e822                	sd	s0,16(sp)
    800046fe:	e426                	sd	s1,8(sp)
    80004700:	1000                	addi	s0,sp,32
    80004702:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004704:	ffffd097          	auipc	ra,0xffffd
    80004708:	802080e7          	jalr	-2046(ra) # 80000f06 <myproc>
    8000470c:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000470e:	0d050793          	addi	a5,a0,208
    80004712:	4501                	li	a0,0
    80004714:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004716:	6398                	ld	a4,0(a5)
    80004718:	cb19                	beqz	a4,8000472e <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    8000471a:	2505                	addiw	a0,a0,1
    8000471c:	07a1                	addi	a5,a5,8
    8000471e:	fed51ce3          	bne	a0,a3,80004716 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004722:	557d                	li	a0,-1
}
    80004724:	60e2                	ld	ra,24(sp)
    80004726:	6442                	ld	s0,16(sp)
    80004728:	64a2                	ld	s1,8(sp)
    8000472a:	6105                	addi	sp,sp,32
    8000472c:	8082                	ret
      p->ofile[fd] = f;
    8000472e:	01a50793          	addi	a5,a0,26
    80004732:	078e                	slli	a5,a5,0x3
    80004734:	963e                	add	a2,a2,a5
    80004736:	e204                	sd	s1,0(a2)
      return fd;
    80004738:	b7f5                	j	80004724 <fdalloc+0x2c>

000000008000473a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000473a:	715d                	addi	sp,sp,-80
    8000473c:	e486                	sd	ra,72(sp)
    8000473e:	e0a2                	sd	s0,64(sp)
    80004740:	fc26                	sd	s1,56(sp)
    80004742:	f84a                	sd	s2,48(sp)
    80004744:	f44e                	sd	s3,40(sp)
    80004746:	ec56                	sd	s5,24(sp)
    80004748:	e85a                	sd	s6,16(sp)
    8000474a:	0880                	addi	s0,sp,80
    8000474c:	8b2e                	mv	s6,a1
    8000474e:	89b2                	mv	s3,a2
    80004750:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004752:	fb040593          	addi	a1,s0,-80
    80004756:	fffff097          	auipc	ra,0xfffff
    8000475a:	de2080e7          	jalr	-542(ra) # 80003538 <nameiparent>
    8000475e:	84aa                	mv	s1,a0
    80004760:	14050e63          	beqz	a0,800048bc <create+0x182>
    return 0;

  ilock(dp);
    80004764:	ffffe097          	auipc	ra,0xffffe
    80004768:	53c080e7          	jalr	1340(ra) # 80002ca0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000476c:	4601                	li	a2,0
    8000476e:	fb040593          	addi	a1,s0,-80
    80004772:	8526                	mv	a0,s1
    80004774:	fffff097          	auipc	ra,0xfffff
    80004778:	ae4080e7          	jalr	-1308(ra) # 80003258 <dirlookup>
    8000477c:	8aaa                	mv	s5,a0
    8000477e:	c539                	beqz	a0,800047cc <create+0x92>
    iunlockput(dp);
    80004780:	8526                	mv	a0,s1
    80004782:	fffff097          	auipc	ra,0xfffff
    80004786:	82e080e7          	jalr	-2002(ra) # 80002fb0 <iunlockput>
    ilock(ip);
    8000478a:	8556                	mv	a0,s5
    8000478c:	ffffe097          	auipc	ra,0xffffe
    80004790:	514080e7          	jalr	1300(ra) # 80002ca0 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004794:	4789                	li	a5,2
    80004796:	02fb1463          	bne	s6,a5,800047be <create+0x84>
    8000479a:	044ad783          	lhu	a5,68(s5)
    8000479e:	37f9                	addiw	a5,a5,-2
    800047a0:	17c2                	slli	a5,a5,0x30
    800047a2:	93c1                	srli	a5,a5,0x30
    800047a4:	4705                	li	a4,1
    800047a6:	00f76c63          	bltu	a4,a5,800047be <create+0x84>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800047aa:	8556                	mv	a0,s5
    800047ac:	60a6                	ld	ra,72(sp)
    800047ae:	6406                	ld	s0,64(sp)
    800047b0:	74e2                	ld	s1,56(sp)
    800047b2:	7942                	ld	s2,48(sp)
    800047b4:	79a2                	ld	s3,40(sp)
    800047b6:	6ae2                	ld	s5,24(sp)
    800047b8:	6b42                	ld	s6,16(sp)
    800047ba:	6161                	addi	sp,sp,80
    800047bc:	8082                	ret
    iunlockput(ip);
    800047be:	8556                	mv	a0,s5
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	7f0080e7          	jalr	2032(ra) # 80002fb0 <iunlockput>
    return 0;
    800047c8:	4a81                	li	s5,0
    800047ca:	b7c5                	j	800047aa <create+0x70>
    800047cc:	f052                	sd	s4,32(sp)
  if((ip = ialloc(dp->dev, type)) == 0){
    800047ce:	85da                	mv	a1,s6
    800047d0:	4088                	lw	a0,0(s1)
    800047d2:	ffffe097          	auipc	ra,0xffffe
    800047d6:	32a080e7          	jalr	810(ra) # 80002afc <ialloc>
    800047da:	8a2a                	mv	s4,a0
    800047dc:	c531                	beqz	a0,80004828 <create+0xee>
  ilock(ip);
    800047de:	ffffe097          	auipc	ra,0xffffe
    800047e2:	4c2080e7          	jalr	1218(ra) # 80002ca0 <ilock>
  ip->major = major;
    800047e6:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800047ea:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800047ee:	4905                	li	s2,1
    800047f0:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    800047f4:	8552                	mv	a0,s4
    800047f6:	ffffe097          	auipc	ra,0xffffe
    800047fa:	3de080e7          	jalr	990(ra) # 80002bd4 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800047fe:	032b0d63          	beq	s6,s2,80004838 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    80004802:	004a2603          	lw	a2,4(s4)
    80004806:	fb040593          	addi	a1,s0,-80
    8000480a:	8526                	mv	a0,s1
    8000480c:	fffff097          	auipc	ra,0xfffff
    80004810:	c5c080e7          	jalr	-932(ra) # 80003468 <dirlink>
    80004814:	08054163          	bltz	a0,80004896 <create+0x15c>
  iunlockput(dp);
    80004818:	8526                	mv	a0,s1
    8000481a:	ffffe097          	auipc	ra,0xffffe
    8000481e:	796080e7          	jalr	1942(ra) # 80002fb0 <iunlockput>
  return ip;
    80004822:	8ad2                	mv	s5,s4
    80004824:	7a02                	ld	s4,32(sp)
    80004826:	b751                	j	800047aa <create+0x70>
    iunlockput(dp);
    80004828:	8526                	mv	a0,s1
    8000482a:	ffffe097          	auipc	ra,0xffffe
    8000482e:	786080e7          	jalr	1926(ra) # 80002fb0 <iunlockput>
    return 0;
    80004832:	8ad2                	mv	s5,s4
    80004834:	7a02                	ld	s4,32(sp)
    80004836:	bf95                	j	800047aa <create+0x70>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004838:	004a2603          	lw	a2,4(s4)
    8000483c:	00004597          	auipc	a1,0x4
    80004840:	d7c58593          	addi	a1,a1,-644 # 800085b8 <etext+0x5b8>
    80004844:	8552                	mv	a0,s4
    80004846:	fffff097          	auipc	ra,0xfffff
    8000484a:	c22080e7          	jalr	-990(ra) # 80003468 <dirlink>
    8000484e:	04054463          	bltz	a0,80004896 <create+0x15c>
    80004852:	40d0                	lw	a2,4(s1)
    80004854:	00004597          	auipc	a1,0x4
    80004858:	d6c58593          	addi	a1,a1,-660 # 800085c0 <etext+0x5c0>
    8000485c:	8552                	mv	a0,s4
    8000485e:	fffff097          	auipc	ra,0xfffff
    80004862:	c0a080e7          	jalr	-1014(ra) # 80003468 <dirlink>
    80004866:	02054863          	bltz	a0,80004896 <create+0x15c>
  if(dirlink(dp, name, ip->inum) < 0)
    8000486a:	004a2603          	lw	a2,4(s4)
    8000486e:	fb040593          	addi	a1,s0,-80
    80004872:	8526                	mv	a0,s1
    80004874:	fffff097          	auipc	ra,0xfffff
    80004878:	bf4080e7          	jalr	-1036(ra) # 80003468 <dirlink>
    8000487c:	00054d63          	bltz	a0,80004896 <create+0x15c>
    dp->nlink++;  // for ".."
    80004880:	04a4d783          	lhu	a5,74(s1)
    80004884:	2785                	addiw	a5,a5,1
    80004886:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000488a:	8526                	mv	a0,s1
    8000488c:	ffffe097          	auipc	ra,0xffffe
    80004890:	348080e7          	jalr	840(ra) # 80002bd4 <iupdate>
    80004894:	b751                	j	80004818 <create+0xde>
  ip->nlink = 0;
    80004896:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    8000489a:	8552                	mv	a0,s4
    8000489c:	ffffe097          	auipc	ra,0xffffe
    800048a0:	338080e7          	jalr	824(ra) # 80002bd4 <iupdate>
  iunlockput(ip);
    800048a4:	8552                	mv	a0,s4
    800048a6:	ffffe097          	auipc	ra,0xffffe
    800048aa:	70a080e7          	jalr	1802(ra) # 80002fb0 <iunlockput>
  iunlockput(dp);
    800048ae:	8526                	mv	a0,s1
    800048b0:	ffffe097          	auipc	ra,0xffffe
    800048b4:	700080e7          	jalr	1792(ra) # 80002fb0 <iunlockput>
  return 0;
    800048b8:	7a02                	ld	s4,32(sp)
    800048ba:	bdc5                	j	800047aa <create+0x70>
    return 0;
    800048bc:	8aaa                	mv	s5,a0
    800048be:	b5f5                	j	800047aa <create+0x70>

00000000800048c0 <sys_dup>:
{
    800048c0:	7179                	addi	sp,sp,-48
    800048c2:	f406                	sd	ra,40(sp)
    800048c4:	f022                	sd	s0,32(sp)
    800048c6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800048c8:	fd840613          	addi	a2,s0,-40
    800048cc:	4581                	li	a1,0
    800048ce:	4501                	li	a0,0
    800048d0:	00000097          	auipc	ra,0x0
    800048d4:	dc8080e7          	jalr	-568(ra) # 80004698 <argfd>
    return -1;
    800048d8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800048da:	02054763          	bltz	a0,80004908 <sys_dup+0x48>
    800048de:	ec26                	sd	s1,24(sp)
    800048e0:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    800048e2:	fd843903          	ld	s2,-40(s0)
    800048e6:	854a                	mv	a0,s2
    800048e8:	00000097          	auipc	ra,0x0
    800048ec:	e10080e7          	jalr	-496(ra) # 800046f8 <fdalloc>
    800048f0:	84aa                	mv	s1,a0
    return -1;
    800048f2:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800048f4:	00054f63          	bltz	a0,80004912 <sys_dup+0x52>
  filedup(f);
    800048f8:	854a                	mv	a0,s2
    800048fa:	fffff097          	auipc	ra,0xfffff
    800048fe:	298080e7          	jalr	664(ra) # 80003b92 <filedup>
  return fd;
    80004902:	87a6                	mv	a5,s1
    80004904:	64e2                	ld	s1,24(sp)
    80004906:	6942                	ld	s2,16(sp)
}
    80004908:	853e                	mv	a0,a5
    8000490a:	70a2                	ld	ra,40(sp)
    8000490c:	7402                	ld	s0,32(sp)
    8000490e:	6145                	addi	sp,sp,48
    80004910:	8082                	ret
    80004912:	64e2                	ld	s1,24(sp)
    80004914:	6942                	ld	s2,16(sp)
    80004916:	bfcd                	j	80004908 <sys_dup+0x48>

0000000080004918 <sys_read>:
{
    80004918:	7179                	addi	sp,sp,-48
    8000491a:	f406                	sd	ra,40(sp)
    8000491c:	f022                	sd	s0,32(sp)
    8000491e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004920:	fd840593          	addi	a1,s0,-40
    80004924:	4505                	li	a0,1
    80004926:	ffffd097          	auipc	ra,0xffffd
    8000492a:	724080e7          	jalr	1828(ra) # 8000204a <argaddr>
  argint(2, &n);
    8000492e:	fe440593          	addi	a1,s0,-28
    80004932:	4509                	li	a0,2
    80004934:	ffffd097          	auipc	ra,0xffffd
    80004938:	6f6080e7          	jalr	1782(ra) # 8000202a <argint>
  if(argfd(0, 0, &f) < 0)
    8000493c:	fe840613          	addi	a2,s0,-24
    80004940:	4581                	li	a1,0
    80004942:	4501                	li	a0,0
    80004944:	00000097          	auipc	ra,0x0
    80004948:	d54080e7          	jalr	-684(ra) # 80004698 <argfd>
    8000494c:	87aa                	mv	a5,a0
    return -1;
    8000494e:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004950:	0007cc63          	bltz	a5,80004968 <sys_read+0x50>
  return fileread(f, p, n);
    80004954:	fe442603          	lw	a2,-28(s0)
    80004958:	fd843583          	ld	a1,-40(s0)
    8000495c:	fe843503          	ld	a0,-24(s0)
    80004960:	fffff097          	auipc	ra,0xfffff
    80004964:	3d8080e7          	jalr	984(ra) # 80003d38 <fileread>
}
    80004968:	70a2                	ld	ra,40(sp)
    8000496a:	7402                	ld	s0,32(sp)
    8000496c:	6145                	addi	sp,sp,48
    8000496e:	8082                	ret

0000000080004970 <sys_write>:
{
    80004970:	7179                	addi	sp,sp,-48
    80004972:	f406                	sd	ra,40(sp)
    80004974:	f022                	sd	s0,32(sp)
    80004976:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004978:	fd840593          	addi	a1,s0,-40
    8000497c:	4505                	li	a0,1
    8000497e:	ffffd097          	auipc	ra,0xffffd
    80004982:	6cc080e7          	jalr	1740(ra) # 8000204a <argaddr>
  argint(2, &n);
    80004986:	fe440593          	addi	a1,s0,-28
    8000498a:	4509                	li	a0,2
    8000498c:	ffffd097          	auipc	ra,0xffffd
    80004990:	69e080e7          	jalr	1694(ra) # 8000202a <argint>
  if(argfd(0, 0, &f) < 0)
    80004994:	fe840613          	addi	a2,s0,-24
    80004998:	4581                	li	a1,0
    8000499a:	4501                	li	a0,0
    8000499c:	00000097          	auipc	ra,0x0
    800049a0:	cfc080e7          	jalr	-772(ra) # 80004698 <argfd>
    800049a4:	87aa                	mv	a5,a0
    return -1;
    800049a6:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800049a8:	0007cc63          	bltz	a5,800049c0 <sys_write+0x50>
  return filewrite(f, p, n);
    800049ac:	fe442603          	lw	a2,-28(s0)
    800049b0:	fd843583          	ld	a1,-40(s0)
    800049b4:	fe843503          	ld	a0,-24(s0)
    800049b8:	fffff097          	auipc	ra,0xfffff
    800049bc:	452080e7          	jalr	1106(ra) # 80003e0a <filewrite>
}
    800049c0:	70a2                	ld	ra,40(sp)
    800049c2:	7402                	ld	s0,32(sp)
    800049c4:	6145                	addi	sp,sp,48
    800049c6:	8082                	ret

00000000800049c8 <sys_close>:
{
    800049c8:	1101                	addi	sp,sp,-32
    800049ca:	ec06                	sd	ra,24(sp)
    800049cc:	e822                	sd	s0,16(sp)
    800049ce:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800049d0:	fe040613          	addi	a2,s0,-32
    800049d4:	fec40593          	addi	a1,s0,-20
    800049d8:	4501                	li	a0,0
    800049da:	00000097          	auipc	ra,0x0
    800049de:	cbe080e7          	jalr	-834(ra) # 80004698 <argfd>
    return -1;
    800049e2:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800049e4:	02054463          	bltz	a0,80004a0c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800049e8:	ffffc097          	auipc	ra,0xffffc
    800049ec:	51e080e7          	jalr	1310(ra) # 80000f06 <myproc>
    800049f0:	fec42783          	lw	a5,-20(s0)
    800049f4:	07e9                	addi	a5,a5,26
    800049f6:	078e                	slli	a5,a5,0x3
    800049f8:	953e                	add	a0,a0,a5
    800049fa:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800049fe:	fe043503          	ld	a0,-32(s0)
    80004a02:	fffff097          	auipc	ra,0xfffff
    80004a06:	1e2080e7          	jalr	482(ra) # 80003be4 <fileclose>
  return 0;
    80004a0a:	4781                	li	a5,0
}
    80004a0c:	853e                	mv	a0,a5
    80004a0e:	60e2                	ld	ra,24(sp)
    80004a10:	6442                	ld	s0,16(sp)
    80004a12:	6105                	addi	sp,sp,32
    80004a14:	8082                	ret

0000000080004a16 <sys_fstat>:
{
    80004a16:	1101                	addi	sp,sp,-32
    80004a18:	ec06                	sd	ra,24(sp)
    80004a1a:	e822                	sd	s0,16(sp)
    80004a1c:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004a1e:	fe040593          	addi	a1,s0,-32
    80004a22:	4505                	li	a0,1
    80004a24:	ffffd097          	auipc	ra,0xffffd
    80004a28:	626080e7          	jalr	1574(ra) # 8000204a <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004a2c:	fe840613          	addi	a2,s0,-24
    80004a30:	4581                	li	a1,0
    80004a32:	4501                	li	a0,0
    80004a34:	00000097          	auipc	ra,0x0
    80004a38:	c64080e7          	jalr	-924(ra) # 80004698 <argfd>
    80004a3c:	87aa                	mv	a5,a0
    return -1;
    80004a3e:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004a40:	0007ca63          	bltz	a5,80004a54 <sys_fstat+0x3e>
  return filestat(f, st);
    80004a44:	fe043583          	ld	a1,-32(s0)
    80004a48:	fe843503          	ld	a0,-24(s0)
    80004a4c:	fffff097          	auipc	ra,0xfffff
    80004a50:	27a080e7          	jalr	634(ra) # 80003cc6 <filestat>
}
    80004a54:	60e2                	ld	ra,24(sp)
    80004a56:	6442                	ld	s0,16(sp)
    80004a58:	6105                	addi	sp,sp,32
    80004a5a:	8082                	ret

0000000080004a5c <sys_link>:
{
    80004a5c:	7169                	addi	sp,sp,-304
    80004a5e:	f606                	sd	ra,296(sp)
    80004a60:	f222                	sd	s0,288(sp)
    80004a62:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a64:	08000613          	li	a2,128
    80004a68:	ed040593          	addi	a1,s0,-304
    80004a6c:	4501                	li	a0,0
    80004a6e:	ffffd097          	auipc	ra,0xffffd
    80004a72:	5fc080e7          	jalr	1532(ra) # 8000206a <argstr>
    return -1;
    80004a76:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a78:	12054663          	bltz	a0,80004ba4 <sys_link+0x148>
    80004a7c:	08000613          	li	a2,128
    80004a80:	f5040593          	addi	a1,s0,-176
    80004a84:	4505                	li	a0,1
    80004a86:	ffffd097          	auipc	ra,0xffffd
    80004a8a:	5e4080e7          	jalr	1508(ra) # 8000206a <argstr>
    return -1;
    80004a8e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a90:	10054a63          	bltz	a0,80004ba4 <sys_link+0x148>
    80004a94:	ee26                	sd	s1,280(sp)
  begin_op();
    80004a96:	fffff097          	auipc	ra,0xfffff
    80004a9a:	c84080e7          	jalr	-892(ra) # 8000371a <begin_op>
  if((ip = namei(old)) == 0){
    80004a9e:	ed040513          	addi	a0,s0,-304
    80004aa2:	fffff097          	auipc	ra,0xfffff
    80004aa6:	a78080e7          	jalr	-1416(ra) # 8000351a <namei>
    80004aaa:	84aa                	mv	s1,a0
    80004aac:	c949                	beqz	a0,80004b3e <sys_link+0xe2>
  ilock(ip);
    80004aae:	ffffe097          	auipc	ra,0xffffe
    80004ab2:	1f2080e7          	jalr	498(ra) # 80002ca0 <ilock>
  if(ip->type == T_DIR){
    80004ab6:	04449703          	lh	a4,68(s1)
    80004aba:	4785                	li	a5,1
    80004abc:	08f70863          	beq	a4,a5,80004b4c <sys_link+0xf0>
    80004ac0:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004ac2:	04a4d783          	lhu	a5,74(s1)
    80004ac6:	2785                	addiw	a5,a5,1
    80004ac8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004acc:	8526                	mv	a0,s1
    80004ace:	ffffe097          	auipc	ra,0xffffe
    80004ad2:	106080e7          	jalr	262(ra) # 80002bd4 <iupdate>
  iunlock(ip);
    80004ad6:	8526                	mv	a0,s1
    80004ad8:	ffffe097          	auipc	ra,0xffffe
    80004adc:	28e080e7          	jalr	654(ra) # 80002d66 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004ae0:	fd040593          	addi	a1,s0,-48
    80004ae4:	f5040513          	addi	a0,s0,-176
    80004ae8:	fffff097          	auipc	ra,0xfffff
    80004aec:	a50080e7          	jalr	-1456(ra) # 80003538 <nameiparent>
    80004af0:	892a                	mv	s2,a0
    80004af2:	cd35                	beqz	a0,80004b6e <sys_link+0x112>
  ilock(dp);
    80004af4:	ffffe097          	auipc	ra,0xffffe
    80004af8:	1ac080e7          	jalr	428(ra) # 80002ca0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004afc:	00092703          	lw	a4,0(s2)
    80004b00:	409c                	lw	a5,0(s1)
    80004b02:	06f71163          	bne	a4,a5,80004b64 <sys_link+0x108>
    80004b06:	40d0                	lw	a2,4(s1)
    80004b08:	fd040593          	addi	a1,s0,-48
    80004b0c:	854a                	mv	a0,s2
    80004b0e:	fffff097          	auipc	ra,0xfffff
    80004b12:	95a080e7          	jalr	-1702(ra) # 80003468 <dirlink>
    80004b16:	04054763          	bltz	a0,80004b64 <sys_link+0x108>
  iunlockput(dp);
    80004b1a:	854a                	mv	a0,s2
    80004b1c:	ffffe097          	auipc	ra,0xffffe
    80004b20:	494080e7          	jalr	1172(ra) # 80002fb0 <iunlockput>
  iput(ip);
    80004b24:	8526                	mv	a0,s1
    80004b26:	ffffe097          	auipc	ra,0xffffe
    80004b2a:	3e2080e7          	jalr	994(ra) # 80002f08 <iput>
  end_op();
    80004b2e:	fffff097          	auipc	ra,0xfffff
    80004b32:	c66080e7          	jalr	-922(ra) # 80003794 <end_op>
  return 0;
    80004b36:	4781                	li	a5,0
    80004b38:	64f2                	ld	s1,280(sp)
    80004b3a:	6952                	ld	s2,272(sp)
    80004b3c:	a0a5                	j	80004ba4 <sys_link+0x148>
    end_op();
    80004b3e:	fffff097          	auipc	ra,0xfffff
    80004b42:	c56080e7          	jalr	-938(ra) # 80003794 <end_op>
    return -1;
    80004b46:	57fd                	li	a5,-1
    80004b48:	64f2                	ld	s1,280(sp)
    80004b4a:	a8a9                	j	80004ba4 <sys_link+0x148>
    iunlockput(ip);
    80004b4c:	8526                	mv	a0,s1
    80004b4e:	ffffe097          	auipc	ra,0xffffe
    80004b52:	462080e7          	jalr	1122(ra) # 80002fb0 <iunlockput>
    end_op();
    80004b56:	fffff097          	auipc	ra,0xfffff
    80004b5a:	c3e080e7          	jalr	-962(ra) # 80003794 <end_op>
    return -1;
    80004b5e:	57fd                	li	a5,-1
    80004b60:	64f2                	ld	s1,280(sp)
    80004b62:	a089                	j	80004ba4 <sys_link+0x148>
    iunlockput(dp);
    80004b64:	854a                	mv	a0,s2
    80004b66:	ffffe097          	auipc	ra,0xffffe
    80004b6a:	44a080e7          	jalr	1098(ra) # 80002fb0 <iunlockput>
  ilock(ip);
    80004b6e:	8526                	mv	a0,s1
    80004b70:	ffffe097          	auipc	ra,0xffffe
    80004b74:	130080e7          	jalr	304(ra) # 80002ca0 <ilock>
  ip->nlink--;
    80004b78:	04a4d783          	lhu	a5,74(s1)
    80004b7c:	37fd                	addiw	a5,a5,-1
    80004b7e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004b82:	8526                	mv	a0,s1
    80004b84:	ffffe097          	auipc	ra,0xffffe
    80004b88:	050080e7          	jalr	80(ra) # 80002bd4 <iupdate>
  iunlockput(ip);
    80004b8c:	8526                	mv	a0,s1
    80004b8e:	ffffe097          	auipc	ra,0xffffe
    80004b92:	422080e7          	jalr	1058(ra) # 80002fb0 <iunlockput>
  end_op();
    80004b96:	fffff097          	auipc	ra,0xfffff
    80004b9a:	bfe080e7          	jalr	-1026(ra) # 80003794 <end_op>
  return -1;
    80004b9e:	57fd                	li	a5,-1
    80004ba0:	64f2                	ld	s1,280(sp)
    80004ba2:	6952                	ld	s2,272(sp)
}
    80004ba4:	853e                	mv	a0,a5
    80004ba6:	70b2                	ld	ra,296(sp)
    80004ba8:	7412                	ld	s0,288(sp)
    80004baa:	6155                	addi	sp,sp,304
    80004bac:	8082                	ret

0000000080004bae <sys_unlink>:
{
    80004bae:	7151                	addi	sp,sp,-240
    80004bb0:	f586                	sd	ra,232(sp)
    80004bb2:	f1a2                	sd	s0,224(sp)
    80004bb4:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004bb6:	08000613          	li	a2,128
    80004bba:	f3040593          	addi	a1,s0,-208
    80004bbe:	4501                	li	a0,0
    80004bc0:	ffffd097          	auipc	ra,0xffffd
    80004bc4:	4aa080e7          	jalr	1194(ra) # 8000206a <argstr>
    80004bc8:	1a054a63          	bltz	a0,80004d7c <sys_unlink+0x1ce>
    80004bcc:	eda6                	sd	s1,216(sp)
  begin_op();
    80004bce:	fffff097          	auipc	ra,0xfffff
    80004bd2:	b4c080e7          	jalr	-1204(ra) # 8000371a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004bd6:	fb040593          	addi	a1,s0,-80
    80004bda:	f3040513          	addi	a0,s0,-208
    80004bde:	fffff097          	auipc	ra,0xfffff
    80004be2:	95a080e7          	jalr	-1702(ra) # 80003538 <nameiparent>
    80004be6:	84aa                	mv	s1,a0
    80004be8:	cd71                	beqz	a0,80004cc4 <sys_unlink+0x116>
  ilock(dp);
    80004bea:	ffffe097          	auipc	ra,0xffffe
    80004bee:	0b6080e7          	jalr	182(ra) # 80002ca0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004bf2:	00004597          	auipc	a1,0x4
    80004bf6:	9c658593          	addi	a1,a1,-1594 # 800085b8 <etext+0x5b8>
    80004bfa:	fb040513          	addi	a0,s0,-80
    80004bfe:	ffffe097          	auipc	ra,0xffffe
    80004c02:	640080e7          	jalr	1600(ra) # 8000323e <namecmp>
    80004c06:	14050c63          	beqz	a0,80004d5e <sys_unlink+0x1b0>
    80004c0a:	00004597          	auipc	a1,0x4
    80004c0e:	9b658593          	addi	a1,a1,-1610 # 800085c0 <etext+0x5c0>
    80004c12:	fb040513          	addi	a0,s0,-80
    80004c16:	ffffe097          	auipc	ra,0xffffe
    80004c1a:	628080e7          	jalr	1576(ra) # 8000323e <namecmp>
    80004c1e:	14050063          	beqz	a0,80004d5e <sys_unlink+0x1b0>
    80004c22:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004c24:	f2c40613          	addi	a2,s0,-212
    80004c28:	fb040593          	addi	a1,s0,-80
    80004c2c:	8526                	mv	a0,s1
    80004c2e:	ffffe097          	auipc	ra,0xffffe
    80004c32:	62a080e7          	jalr	1578(ra) # 80003258 <dirlookup>
    80004c36:	892a                	mv	s2,a0
    80004c38:	12050263          	beqz	a0,80004d5c <sys_unlink+0x1ae>
  ilock(ip);
    80004c3c:	ffffe097          	auipc	ra,0xffffe
    80004c40:	064080e7          	jalr	100(ra) # 80002ca0 <ilock>
  if(ip->nlink < 1)
    80004c44:	04a91783          	lh	a5,74(s2)
    80004c48:	08f05563          	blez	a5,80004cd2 <sys_unlink+0x124>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004c4c:	04491703          	lh	a4,68(s2)
    80004c50:	4785                	li	a5,1
    80004c52:	08f70963          	beq	a4,a5,80004ce4 <sys_unlink+0x136>
  memset(&de, 0, sizeof(de));
    80004c56:	4641                	li	a2,16
    80004c58:	4581                	li	a1,0
    80004c5a:	fc040513          	addi	a0,s0,-64
    80004c5e:	ffffb097          	auipc	ra,0xffffb
    80004c62:	51c080e7          	jalr	1308(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c66:	4741                	li	a4,16
    80004c68:	f2c42683          	lw	a3,-212(s0)
    80004c6c:	fc040613          	addi	a2,s0,-64
    80004c70:	4581                	li	a1,0
    80004c72:	8526                	mv	a0,s1
    80004c74:	ffffe097          	auipc	ra,0xffffe
    80004c78:	49e080e7          	jalr	1182(ra) # 80003112 <writei>
    80004c7c:	47c1                	li	a5,16
    80004c7e:	0af51b63          	bne	a0,a5,80004d34 <sys_unlink+0x186>
  if(ip->type == T_DIR){
    80004c82:	04491703          	lh	a4,68(s2)
    80004c86:	4785                	li	a5,1
    80004c88:	0af70f63          	beq	a4,a5,80004d46 <sys_unlink+0x198>
  iunlockput(dp);
    80004c8c:	8526                	mv	a0,s1
    80004c8e:	ffffe097          	auipc	ra,0xffffe
    80004c92:	322080e7          	jalr	802(ra) # 80002fb0 <iunlockput>
  ip->nlink--;
    80004c96:	04a95783          	lhu	a5,74(s2)
    80004c9a:	37fd                	addiw	a5,a5,-1
    80004c9c:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004ca0:	854a                	mv	a0,s2
    80004ca2:	ffffe097          	auipc	ra,0xffffe
    80004ca6:	f32080e7          	jalr	-206(ra) # 80002bd4 <iupdate>
  iunlockput(ip);
    80004caa:	854a                	mv	a0,s2
    80004cac:	ffffe097          	auipc	ra,0xffffe
    80004cb0:	304080e7          	jalr	772(ra) # 80002fb0 <iunlockput>
  end_op();
    80004cb4:	fffff097          	auipc	ra,0xfffff
    80004cb8:	ae0080e7          	jalr	-1312(ra) # 80003794 <end_op>
  return 0;
    80004cbc:	4501                	li	a0,0
    80004cbe:	64ee                	ld	s1,216(sp)
    80004cc0:	694e                	ld	s2,208(sp)
    80004cc2:	a84d                	j	80004d74 <sys_unlink+0x1c6>
    end_op();
    80004cc4:	fffff097          	auipc	ra,0xfffff
    80004cc8:	ad0080e7          	jalr	-1328(ra) # 80003794 <end_op>
    return -1;
    80004ccc:	557d                	li	a0,-1
    80004cce:	64ee                	ld	s1,216(sp)
    80004cd0:	a055                	j	80004d74 <sys_unlink+0x1c6>
    80004cd2:	e5ce                	sd	s3,200(sp)
    panic("unlink: nlink < 1");
    80004cd4:	00004517          	auipc	a0,0x4
    80004cd8:	8f450513          	addi	a0,a0,-1804 # 800085c8 <etext+0x5c8>
    80004cdc:	00001097          	auipc	ra,0x1
    80004ce0:	236080e7          	jalr	566(ra) # 80005f12 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ce4:	04c92703          	lw	a4,76(s2)
    80004ce8:	02000793          	li	a5,32
    80004cec:	f6e7f5e3          	bgeu	a5,a4,80004c56 <sys_unlink+0xa8>
    80004cf0:	e5ce                	sd	s3,200(sp)
    80004cf2:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004cf6:	4741                	li	a4,16
    80004cf8:	86ce                	mv	a3,s3
    80004cfa:	f1840613          	addi	a2,s0,-232
    80004cfe:	4581                	li	a1,0
    80004d00:	854a                	mv	a0,s2
    80004d02:	ffffe097          	auipc	ra,0xffffe
    80004d06:	300080e7          	jalr	768(ra) # 80003002 <readi>
    80004d0a:	47c1                	li	a5,16
    80004d0c:	00f51c63          	bne	a0,a5,80004d24 <sys_unlink+0x176>
    if(de.inum != 0)
    80004d10:	f1845783          	lhu	a5,-232(s0)
    80004d14:	e7b5                	bnez	a5,80004d80 <sys_unlink+0x1d2>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004d16:	29c1                	addiw	s3,s3,16
    80004d18:	04c92783          	lw	a5,76(s2)
    80004d1c:	fcf9ede3          	bltu	s3,a5,80004cf6 <sys_unlink+0x148>
    80004d20:	69ae                	ld	s3,200(sp)
    80004d22:	bf15                	j	80004c56 <sys_unlink+0xa8>
      panic("isdirempty: readi");
    80004d24:	00004517          	auipc	a0,0x4
    80004d28:	8bc50513          	addi	a0,a0,-1860 # 800085e0 <etext+0x5e0>
    80004d2c:	00001097          	auipc	ra,0x1
    80004d30:	1e6080e7          	jalr	486(ra) # 80005f12 <panic>
    80004d34:	e5ce                	sd	s3,200(sp)
    panic("unlink: writei");
    80004d36:	00004517          	auipc	a0,0x4
    80004d3a:	8c250513          	addi	a0,a0,-1854 # 800085f8 <etext+0x5f8>
    80004d3e:	00001097          	auipc	ra,0x1
    80004d42:	1d4080e7          	jalr	468(ra) # 80005f12 <panic>
    dp->nlink--;
    80004d46:	04a4d783          	lhu	a5,74(s1)
    80004d4a:	37fd                	addiw	a5,a5,-1
    80004d4c:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004d50:	8526                	mv	a0,s1
    80004d52:	ffffe097          	auipc	ra,0xffffe
    80004d56:	e82080e7          	jalr	-382(ra) # 80002bd4 <iupdate>
    80004d5a:	bf0d                	j	80004c8c <sys_unlink+0xde>
    80004d5c:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    80004d5e:	8526                	mv	a0,s1
    80004d60:	ffffe097          	auipc	ra,0xffffe
    80004d64:	250080e7          	jalr	592(ra) # 80002fb0 <iunlockput>
  end_op();
    80004d68:	fffff097          	auipc	ra,0xfffff
    80004d6c:	a2c080e7          	jalr	-1492(ra) # 80003794 <end_op>
  return -1;
    80004d70:	557d                	li	a0,-1
    80004d72:	64ee                	ld	s1,216(sp)
}
    80004d74:	70ae                	ld	ra,232(sp)
    80004d76:	740e                	ld	s0,224(sp)
    80004d78:	616d                	addi	sp,sp,240
    80004d7a:	8082                	ret
    return -1;
    80004d7c:	557d                	li	a0,-1
    80004d7e:	bfdd                	j	80004d74 <sys_unlink+0x1c6>
    iunlockput(ip);
    80004d80:	854a                	mv	a0,s2
    80004d82:	ffffe097          	auipc	ra,0xffffe
    80004d86:	22e080e7          	jalr	558(ra) # 80002fb0 <iunlockput>
    goto bad;
    80004d8a:	694e                	ld	s2,208(sp)
    80004d8c:	69ae                	ld	s3,200(sp)
    80004d8e:	bfc1                	j	80004d5e <sys_unlink+0x1b0>

0000000080004d90 <sys_open>:

uint64
sys_open(void)
{
    80004d90:	7131                	addi	sp,sp,-192
    80004d92:	fd06                	sd	ra,184(sp)
    80004d94:	f922                	sd	s0,176(sp)
    80004d96:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004d98:	f4c40593          	addi	a1,s0,-180
    80004d9c:	4505                	li	a0,1
    80004d9e:	ffffd097          	auipc	ra,0xffffd
    80004da2:	28c080e7          	jalr	652(ra) # 8000202a <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004da6:	08000613          	li	a2,128
    80004daa:	f5040593          	addi	a1,s0,-176
    80004dae:	4501                	li	a0,0
    80004db0:	ffffd097          	auipc	ra,0xffffd
    80004db4:	2ba080e7          	jalr	698(ra) # 8000206a <argstr>
    80004db8:	87aa                	mv	a5,a0
    return -1;
    80004dba:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004dbc:	0a07ce63          	bltz	a5,80004e78 <sys_open+0xe8>
    80004dc0:	f526                	sd	s1,168(sp)

  begin_op();
    80004dc2:	fffff097          	auipc	ra,0xfffff
    80004dc6:	958080e7          	jalr	-1704(ra) # 8000371a <begin_op>

  if(omode & O_CREATE){
    80004dca:	f4c42783          	lw	a5,-180(s0)
    80004dce:	2007f793          	andi	a5,a5,512
    80004dd2:	cfd5                	beqz	a5,80004e8e <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004dd4:	4681                	li	a3,0
    80004dd6:	4601                	li	a2,0
    80004dd8:	4589                	li	a1,2
    80004dda:	f5040513          	addi	a0,s0,-176
    80004dde:	00000097          	auipc	ra,0x0
    80004de2:	95c080e7          	jalr	-1700(ra) # 8000473a <create>
    80004de6:	84aa                	mv	s1,a0
    if(ip == 0){
    80004de8:	cd41                	beqz	a0,80004e80 <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004dea:	04449703          	lh	a4,68(s1)
    80004dee:	478d                	li	a5,3
    80004df0:	00f71763          	bne	a4,a5,80004dfe <sys_open+0x6e>
    80004df4:	0464d703          	lhu	a4,70(s1)
    80004df8:	47a5                	li	a5,9
    80004dfa:	0ee7e163          	bltu	a5,a4,80004edc <sys_open+0x14c>
    80004dfe:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004e00:	fffff097          	auipc	ra,0xfffff
    80004e04:	d28080e7          	jalr	-728(ra) # 80003b28 <filealloc>
    80004e08:	892a                	mv	s2,a0
    80004e0a:	c97d                	beqz	a0,80004f00 <sys_open+0x170>
    80004e0c:	ed4e                	sd	s3,152(sp)
    80004e0e:	00000097          	auipc	ra,0x0
    80004e12:	8ea080e7          	jalr	-1814(ra) # 800046f8 <fdalloc>
    80004e16:	89aa                	mv	s3,a0
    80004e18:	0c054e63          	bltz	a0,80004ef4 <sys_open+0x164>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004e1c:	04449703          	lh	a4,68(s1)
    80004e20:	478d                	li	a5,3
    80004e22:	0ef70c63          	beq	a4,a5,80004f1a <sys_open+0x18a>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004e26:	4789                	li	a5,2
    80004e28:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004e2c:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004e30:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004e34:	f4c42783          	lw	a5,-180(s0)
    80004e38:	0017c713          	xori	a4,a5,1
    80004e3c:	8b05                	andi	a4,a4,1
    80004e3e:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004e42:	0037f713          	andi	a4,a5,3
    80004e46:	00e03733          	snez	a4,a4
    80004e4a:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004e4e:	4007f793          	andi	a5,a5,1024
    80004e52:	c791                	beqz	a5,80004e5e <sys_open+0xce>
    80004e54:	04449703          	lh	a4,68(s1)
    80004e58:	4789                	li	a5,2
    80004e5a:	0cf70763          	beq	a4,a5,80004f28 <sys_open+0x198>
    itrunc(ip);
  }

  iunlock(ip);
    80004e5e:	8526                	mv	a0,s1
    80004e60:	ffffe097          	auipc	ra,0xffffe
    80004e64:	f06080e7          	jalr	-250(ra) # 80002d66 <iunlock>
  end_op();
    80004e68:	fffff097          	auipc	ra,0xfffff
    80004e6c:	92c080e7          	jalr	-1748(ra) # 80003794 <end_op>

  return fd;
    80004e70:	854e                	mv	a0,s3
    80004e72:	74aa                	ld	s1,168(sp)
    80004e74:	790a                	ld	s2,160(sp)
    80004e76:	69ea                	ld	s3,152(sp)
}
    80004e78:	70ea                	ld	ra,184(sp)
    80004e7a:	744a                	ld	s0,176(sp)
    80004e7c:	6129                	addi	sp,sp,192
    80004e7e:	8082                	ret
      end_op();
    80004e80:	fffff097          	auipc	ra,0xfffff
    80004e84:	914080e7          	jalr	-1772(ra) # 80003794 <end_op>
      return -1;
    80004e88:	557d                	li	a0,-1
    80004e8a:	74aa                	ld	s1,168(sp)
    80004e8c:	b7f5                	j	80004e78 <sys_open+0xe8>
    if((ip = namei(path)) == 0){
    80004e8e:	f5040513          	addi	a0,s0,-176
    80004e92:	ffffe097          	auipc	ra,0xffffe
    80004e96:	688080e7          	jalr	1672(ra) # 8000351a <namei>
    80004e9a:	84aa                	mv	s1,a0
    80004e9c:	c90d                	beqz	a0,80004ece <sys_open+0x13e>
    ilock(ip);
    80004e9e:	ffffe097          	auipc	ra,0xffffe
    80004ea2:	e02080e7          	jalr	-510(ra) # 80002ca0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004ea6:	04449703          	lh	a4,68(s1)
    80004eaa:	4785                	li	a5,1
    80004eac:	f2f71fe3          	bne	a4,a5,80004dea <sys_open+0x5a>
    80004eb0:	f4c42783          	lw	a5,-180(s0)
    80004eb4:	d7a9                	beqz	a5,80004dfe <sys_open+0x6e>
      iunlockput(ip);
    80004eb6:	8526                	mv	a0,s1
    80004eb8:	ffffe097          	auipc	ra,0xffffe
    80004ebc:	0f8080e7          	jalr	248(ra) # 80002fb0 <iunlockput>
      end_op();
    80004ec0:	fffff097          	auipc	ra,0xfffff
    80004ec4:	8d4080e7          	jalr	-1836(ra) # 80003794 <end_op>
      return -1;
    80004ec8:	557d                	li	a0,-1
    80004eca:	74aa                	ld	s1,168(sp)
    80004ecc:	b775                	j	80004e78 <sys_open+0xe8>
      end_op();
    80004ece:	fffff097          	auipc	ra,0xfffff
    80004ed2:	8c6080e7          	jalr	-1850(ra) # 80003794 <end_op>
      return -1;
    80004ed6:	557d                	li	a0,-1
    80004ed8:	74aa                	ld	s1,168(sp)
    80004eda:	bf79                	j	80004e78 <sys_open+0xe8>
    iunlockput(ip);
    80004edc:	8526                	mv	a0,s1
    80004ede:	ffffe097          	auipc	ra,0xffffe
    80004ee2:	0d2080e7          	jalr	210(ra) # 80002fb0 <iunlockput>
    end_op();
    80004ee6:	fffff097          	auipc	ra,0xfffff
    80004eea:	8ae080e7          	jalr	-1874(ra) # 80003794 <end_op>
    return -1;
    80004eee:	557d                	li	a0,-1
    80004ef0:	74aa                	ld	s1,168(sp)
    80004ef2:	b759                	j	80004e78 <sys_open+0xe8>
      fileclose(f);
    80004ef4:	854a                	mv	a0,s2
    80004ef6:	fffff097          	auipc	ra,0xfffff
    80004efa:	cee080e7          	jalr	-786(ra) # 80003be4 <fileclose>
    80004efe:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    80004f00:	8526                	mv	a0,s1
    80004f02:	ffffe097          	auipc	ra,0xffffe
    80004f06:	0ae080e7          	jalr	174(ra) # 80002fb0 <iunlockput>
    end_op();
    80004f0a:	fffff097          	auipc	ra,0xfffff
    80004f0e:	88a080e7          	jalr	-1910(ra) # 80003794 <end_op>
    return -1;
    80004f12:	557d                	li	a0,-1
    80004f14:	74aa                	ld	s1,168(sp)
    80004f16:	790a                	ld	s2,160(sp)
    80004f18:	b785                	j	80004e78 <sys_open+0xe8>
    f->type = FD_DEVICE;
    80004f1a:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80004f1e:	04649783          	lh	a5,70(s1)
    80004f22:	02f91223          	sh	a5,36(s2)
    80004f26:	b729                	j	80004e30 <sys_open+0xa0>
    itrunc(ip);
    80004f28:	8526                	mv	a0,s1
    80004f2a:	ffffe097          	auipc	ra,0xffffe
    80004f2e:	e88080e7          	jalr	-376(ra) # 80002db2 <itrunc>
    80004f32:	b735                	j	80004e5e <sys_open+0xce>

0000000080004f34 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004f34:	7175                	addi	sp,sp,-144
    80004f36:	e506                	sd	ra,136(sp)
    80004f38:	e122                	sd	s0,128(sp)
    80004f3a:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004f3c:	ffffe097          	auipc	ra,0xffffe
    80004f40:	7de080e7          	jalr	2014(ra) # 8000371a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004f44:	08000613          	li	a2,128
    80004f48:	f7040593          	addi	a1,s0,-144
    80004f4c:	4501                	li	a0,0
    80004f4e:	ffffd097          	auipc	ra,0xffffd
    80004f52:	11c080e7          	jalr	284(ra) # 8000206a <argstr>
    80004f56:	02054963          	bltz	a0,80004f88 <sys_mkdir+0x54>
    80004f5a:	4681                	li	a3,0
    80004f5c:	4601                	li	a2,0
    80004f5e:	4585                	li	a1,1
    80004f60:	f7040513          	addi	a0,s0,-144
    80004f64:	fffff097          	auipc	ra,0xfffff
    80004f68:	7d6080e7          	jalr	2006(ra) # 8000473a <create>
    80004f6c:	cd11                	beqz	a0,80004f88 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f6e:	ffffe097          	auipc	ra,0xffffe
    80004f72:	042080e7          	jalr	66(ra) # 80002fb0 <iunlockput>
  end_op();
    80004f76:	fffff097          	auipc	ra,0xfffff
    80004f7a:	81e080e7          	jalr	-2018(ra) # 80003794 <end_op>
  return 0;
    80004f7e:	4501                	li	a0,0
}
    80004f80:	60aa                	ld	ra,136(sp)
    80004f82:	640a                	ld	s0,128(sp)
    80004f84:	6149                	addi	sp,sp,144
    80004f86:	8082                	ret
    end_op();
    80004f88:	fffff097          	auipc	ra,0xfffff
    80004f8c:	80c080e7          	jalr	-2036(ra) # 80003794 <end_op>
    return -1;
    80004f90:	557d                	li	a0,-1
    80004f92:	b7fd                	j	80004f80 <sys_mkdir+0x4c>

0000000080004f94 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004f94:	7135                	addi	sp,sp,-160
    80004f96:	ed06                	sd	ra,152(sp)
    80004f98:	e922                	sd	s0,144(sp)
    80004f9a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004f9c:	ffffe097          	auipc	ra,0xffffe
    80004fa0:	77e080e7          	jalr	1918(ra) # 8000371a <begin_op>
  argint(1, &major);
    80004fa4:	f6c40593          	addi	a1,s0,-148
    80004fa8:	4505                	li	a0,1
    80004faa:	ffffd097          	auipc	ra,0xffffd
    80004fae:	080080e7          	jalr	128(ra) # 8000202a <argint>
  argint(2, &minor);
    80004fb2:	f6840593          	addi	a1,s0,-152
    80004fb6:	4509                	li	a0,2
    80004fb8:	ffffd097          	auipc	ra,0xffffd
    80004fbc:	072080e7          	jalr	114(ra) # 8000202a <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fc0:	08000613          	li	a2,128
    80004fc4:	f7040593          	addi	a1,s0,-144
    80004fc8:	4501                	li	a0,0
    80004fca:	ffffd097          	auipc	ra,0xffffd
    80004fce:	0a0080e7          	jalr	160(ra) # 8000206a <argstr>
    80004fd2:	02054b63          	bltz	a0,80005008 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004fd6:	f6841683          	lh	a3,-152(s0)
    80004fda:	f6c41603          	lh	a2,-148(s0)
    80004fde:	458d                	li	a1,3
    80004fe0:	f7040513          	addi	a0,s0,-144
    80004fe4:	fffff097          	auipc	ra,0xfffff
    80004fe8:	756080e7          	jalr	1878(ra) # 8000473a <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fec:	cd11                	beqz	a0,80005008 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004fee:	ffffe097          	auipc	ra,0xffffe
    80004ff2:	fc2080e7          	jalr	-62(ra) # 80002fb0 <iunlockput>
  end_op();
    80004ff6:	ffffe097          	auipc	ra,0xffffe
    80004ffa:	79e080e7          	jalr	1950(ra) # 80003794 <end_op>
  return 0;
    80004ffe:	4501                	li	a0,0
}
    80005000:	60ea                	ld	ra,152(sp)
    80005002:	644a                	ld	s0,144(sp)
    80005004:	610d                	addi	sp,sp,160
    80005006:	8082                	ret
    end_op();
    80005008:	ffffe097          	auipc	ra,0xffffe
    8000500c:	78c080e7          	jalr	1932(ra) # 80003794 <end_op>
    return -1;
    80005010:	557d                	li	a0,-1
    80005012:	b7fd                	j	80005000 <sys_mknod+0x6c>

0000000080005014 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005014:	7135                	addi	sp,sp,-160
    80005016:	ed06                	sd	ra,152(sp)
    80005018:	e922                	sd	s0,144(sp)
    8000501a:	e14a                	sd	s2,128(sp)
    8000501c:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    8000501e:	ffffc097          	auipc	ra,0xffffc
    80005022:	ee8080e7          	jalr	-280(ra) # 80000f06 <myproc>
    80005026:	892a                	mv	s2,a0
  
  begin_op();
    80005028:	ffffe097          	auipc	ra,0xffffe
    8000502c:	6f2080e7          	jalr	1778(ra) # 8000371a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005030:	08000613          	li	a2,128
    80005034:	f6040593          	addi	a1,s0,-160
    80005038:	4501                	li	a0,0
    8000503a:	ffffd097          	auipc	ra,0xffffd
    8000503e:	030080e7          	jalr	48(ra) # 8000206a <argstr>
    80005042:	04054d63          	bltz	a0,8000509c <sys_chdir+0x88>
    80005046:	e526                	sd	s1,136(sp)
    80005048:	f6040513          	addi	a0,s0,-160
    8000504c:	ffffe097          	auipc	ra,0xffffe
    80005050:	4ce080e7          	jalr	1230(ra) # 8000351a <namei>
    80005054:	84aa                	mv	s1,a0
    80005056:	c131                	beqz	a0,8000509a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005058:	ffffe097          	auipc	ra,0xffffe
    8000505c:	c48080e7          	jalr	-952(ra) # 80002ca0 <ilock>
  if(ip->type != T_DIR){
    80005060:	04449703          	lh	a4,68(s1)
    80005064:	4785                	li	a5,1
    80005066:	04f71163          	bne	a4,a5,800050a8 <sys_chdir+0x94>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000506a:	8526                	mv	a0,s1
    8000506c:	ffffe097          	auipc	ra,0xffffe
    80005070:	cfa080e7          	jalr	-774(ra) # 80002d66 <iunlock>
  iput(p->cwd);
    80005074:	15093503          	ld	a0,336(s2)
    80005078:	ffffe097          	auipc	ra,0xffffe
    8000507c:	e90080e7          	jalr	-368(ra) # 80002f08 <iput>
  end_op();
    80005080:	ffffe097          	auipc	ra,0xffffe
    80005084:	714080e7          	jalr	1812(ra) # 80003794 <end_op>
  p->cwd = ip;
    80005088:	14993823          	sd	s1,336(s2)
  return 0;
    8000508c:	4501                	li	a0,0
    8000508e:	64aa                	ld	s1,136(sp)
}
    80005090:	60ea                	ld	ra,152(sp)
    80005092:	644a                	ld	s0,144(sp)
    80005094:	690a                	ld	s2,128(sp)
    80005096:	610d                	addi	sp,sp,160
    80005098:	8082                	ret
    8000509a:	64aa                	ld	s1,136(sp)
    end_op();
    8000509c:	ffffe097          	auipc	ra,0xffffe
    800050a0:	6f8080e7          	jalr	1784(ra) # 80003794 <end_op>
    return -1;
    800050a4:	557d                	li	a0,-1
    800050a6:	b7ed                	j	80005090 <sys_chdir+0x7c>
    iunlockput(ip);
    800050a8:	8526                	mv	a0,s1
    800050aa:	ffffe097          	auipc	ra,0xffffe
    800050ae:	f06080e7          	jalr	-250(ra) # 80002fb0 <iunlockput>
    end_op();
    800050b2:	ffffe097          	auipc	ra,0xffffe
    800050b6:	6e2080e7          	jalr	1762(ra) # 80003794 <end_op>
    return -1;
    800050ba:	557d                	li	a0,-1
    800050bc:	64aa                	ld	s1,136(sp)
    800050be:	bfc9                	j	80005090 <sys_chdir+0x7c>

00000000800050c0 <sys_exec>:

uint64
sys_exec(void)
{
    800050c0:	7121                	addi	sp,sp,-448
    800050c2:	ff06                	sd	ra,440(sp)
    800050c4:	fb22                	sd	s0,432(sp)
    800050c6:	0380                	addi	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800050c8:	e4840593          	addi	a1,s0,-440
    800050cc:	4505                	li	a0,1
    800050ce:	ffffd097          	auipc	ra,0xffffd
    800050d2:	f7c080e7          	jalr	-132(ra) # 8000204a <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800050d6:	08000613          	li	a2,128
    800050da:	f5040593          	addi	a1,s0,-176
    800050de:	4501                	li	a0,0
    800050e0:	ffffd097          	auipc	ra,0xffffd
    800050e4:	f8a080e7          	jalr	-118(ra) # 8000206a <argstr>
    800050e8:	87aa                	mv	a5,a0
    return -1;
    800050ea:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    800050ec:	0e07c263          	bltz	a5,800051d0 <sys_exec+0x110>
    800050f0:	f726                	sd	s1,424(sp)
    800050f2:	f34a                	sd	s2,416(sp)
    800050f4:	ef4e                	sd	s3,408(sp)
    800050f6:	eb52                	sd	s4,400(sp)
  }
  memset(argv, 0, sizeof(argv));
    800050f8:	10000613          	li	a2,256
    800050fc:	4581                	li	a1,0
    800050fe:	e5040513          	addi	a0,s0,-432
    80005102:	ffffb097          	auipc	ra,0xffffb
    80005106:	078080e7          	jalr	120(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000510a:	e5040493          	addi	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    8000510e:	89a6                	mv	s3,s1
    80005110:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005112:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005116:	00391513          	slli	a0,s2,0x3
    8000511a:	e4040593          	addi	a1,s0,-448
    8000511e:	e4843783          	ld	a5,-440(s0)
    80005122:	953e                	add	a0,a0,a5
    80005124:	ffffd097          	auipc	ra,0xffffd
    80005128:	e68080e7          	jalr	-408(ra) # 80001f8c <fetchaddr>
    8000512c:	02054a63          	bltz	a0,80005160 <sys_exec+0xa0>
      goto bad;
    }
    if(uarg == 0){
    80005130:	e4043783          	ld	a5,-448(s0)
    80005134:	c7b9                	beqz	a5,80005182 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005136:	ffffb097          	auipc	ra,0xffffb
    8000513a:	fe4080e7          	jalr	-28(ra) # 8000011a <kalloc>
    8000513e:	85aa                	mv	a1,a0
    80005140:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005144:	cd11                	beqz	a0,80005160 <sys_exec+0xa0>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005146:	6605                	lui	a2,0x1
    80005148:	e4043503          	ld	a0,-448(s0)
    8000514c:	ffffd097          	auipc	ra,0xffffd
    80005150:	e92080e7          	jalr	-366(ra) # 80001fde <fetchstr>
    80005154:	00054663          	bltz	a0,80005160 <sys_exec+0xa0>
    if(i >= NELEM(argv)){
    80005158:	0905                	addi	s2,s2,1
    8000515a:	09a1                	addi	s3,s3,8
    8000515c:	fb491de3          	bne	s2,s4,80005116 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005160:	f5040913          	addi	s2,s0,-176
    80005164:	6088                	ld	a0,0(s1)
    80005166:	c125                	beqz	a0,800051c6 <sys_exec+0x106>
    kfree(argv[i]);
    80005168:	ffffb097          	auipc	ra,0xffffb
    8000516c:	eb4080e7          	jalr	-332(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005170:	04a1                	addi	s1,s1,8
    80005172:	ff2499e3          	bne	s1,s2,80005164 <sys_exec+0xa4>
  return -1;
    80005176:	557d                	li	a0,-1
    80005178:	74ba                	ld	s1,424(sp)
    8000517a:	791a                	ld	s2,416(sp)
    8000517c:	69fa                	ld	s3,408(sp)
    8000517e:	6a5a                	ld	s4,400(sp)
    80005180:	a881                	j	800051d0 <sys_exec+0x110>
      argv[i] = 0;
    80005182:	0009079b          	sext.w	a5,s2
    80005186:	078e                	slli	a5,a5,0x3
    80005188:	fd078793          	addi	a5,a5,-48
    8000518c:	97a2                	add	a5,a5,s0
    8000518e:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80005192:	e5040593          	addi	a1,s0,-432
    80005196:	f5040513          	addi	a0,s0,-176
    8000519a:	fffff097          	auipc	ra,0xfffff
    8000519e:	120080e7          	jalr	288(ra) # 800042ba <exec>
    800051a2:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800051a4:	f5040993          	addi	s3,s0,-176
    800051a8:	6088                	ld	a0,0(s1)
    800051aa:	c901                	beqz	a0,800051ba <sys_exec+0xfa>
    kfree(argv[i]);
    800051ac:	ffffb097          	auipc	ra,0xffffb
    800051b0:	e70080e7          	jalr	-400(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800051b4:	04a1                	addi	s1,s1,8
    800051b6:	ff3499e3          	bne	s1,s3,800051a8 <sys_exec+0xe8>
  return ret;
    800051ba:	854a                	mv	a0,s2
    800051bc:	74ba                	ld	s1,424(sp)
    800051be:	791a                	ld	s2,416(sp)
    800051c0:	69fa                	ld	s3,408(sp)
    800051c2:	6a5a                	ld	s4,400(sp)
    800051c4:	a031                	j	800051d0 <sys_exec+0x110>
  return -1;
    800051c6:	557d                	li	a0,-1
    800051c8:	74ba                	ld	s1,424(sp)
    800051ca:	791a                	ld	s2,416(sp)
    800051cc:	69fa                	ld	s3,408(sp)
    800051ce:	6a5a                	ld	s4,400(sp)
}
    800051d0:	70fa                	ld	ra,440(sp)
    800051d2:	745a                	ld	s0,432(sp)
    800051d4:	6139                	addi	sp,sp,448
    800051d6:	8082                	ret

00000000800051d8 <sys_pipe>:

uint64
sys_pipe(void)
{
    800051d8:	7139                	addi	sp,sp,-64
    800051da:	fc06                	sd	ra,56(sp)
    800051dc:	f822                	sd	s0,48(sp)
    800051de:	f426                	sd	s1,40(sp)
    800051e0:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800051e2:	ffffc097          	auipc	ra,0xffffc
    800051e6:	d24080e7          	jalr	-732(ra) # 80000f06 <myproc>
    800051ea:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    800051ec:	fd840593          	addi	a1,s0,-40
    800051f0:	4501                	li	a0,0
    800051f2:	ffffd097          	auipc	ra,0xffffd
    800051f6:	e58080e7          	jalr	-424(ra) # 8000204a <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800051fa:	fc840593          	addi	a1,s0,-56
    800051fe:	fd040513          	addi	a0,s0,-48
    80005202:	fffff097          	auipc	ra,0xfffff
    80005206:	d50080e7          	jalr	-688(ra) # 80003f52 <pipealloc>
    return -1;
    8000520a:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000520c:	0c054463          	bltz	a0,800052d4 <sys_pipe+0xfc>
  fd0 = -1;
    80005210:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005214:	fd043503          	ld	a0,-48(s0)
    80005218:	fffff097          	auipc	ra,0xfffff
    8000521c:	4e0080e7          	jalr	1248(ra) # 800046f8 <fdalloc>
    80005220:	fca42223          	sw	a0,-60(s0)
    80005224:	08054b63          	bltz	a0,800052ba <sys_pipe+0xe2>
    80005228:	fc843503          	ld	a0,-56(s0)
    8000522c:	fffff097          	auipc	ra,0xfffff
    80005230:	4cc080e7          	jalr	1228(ra) # 800046f8 <fdalloc>
    80005234:	fca42023          	sw	a0,-64(s0)
    80005238:	06054863          	bltz	a0,800052a8 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000523c:	4691                	li	a3,4
    8000523e:	fc440613          	addi	a2,s0,-60
    80005242:	fd843583          	ld	a1,-40(s0)
    80005246:	68a8                	ld	a0,80(s1)
    80005248:	ffffc097          	auipc	ra,0xffffc
    8000524c:	904080e7          	jalr	-1788(ra) # 80000b4c <copyout>
    80005250:	02054063          	bltz	a0,80005270 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005254:	4691                	li	a3,4
    80005256:	fc040613          	addi	a2,s0,-64
    8000525a:	fd843583          	ld	a1,-40(s0)
    8000525e:	0591                	addi	a1,a1,4
    80005260:	68a8                	ld	a0,80(s1)
    80005262:	ffffc097          	auipc	ra,0xffffc
    80005266:	8ea080e7          	jalr	-1814(ra) # 80000b4c <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000526a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000526c:	06055463          	bgez	a0,800052d4 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005270:	fc442783          	lw	a5,-60(s0)
    80005274:	07e9                	addi	a5,a5,26
    80005276:	078e                	slli	a5,a5,0x3
    80005278:	97a6                	add	a5,a5,s1
    8000527a:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000527e:	fc042783          	lw	a5,-64(s0)
    80005282:	07e9                	addi	a5,a5,26
    80005284:	078e                	slli	a5,a5,0x3
    80005286:	94be                	add	s1,s1,a5
    80005288:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    8000528c:	fd043503          	ld	a0,-48(s0)
    80005290:	fffff097          	auipc	ra,0xfffff
    80005294:	954080e7          	jalr	-1708(ra) # 80003be4 <fileclose>
    fileclose(wf);
    80005298:	fc843503          	ld	a0,-56(s0)
    8000529c:	fffff097          	auipc	ra,0xfffff
    800052a0:	948080e7          	jalr	-1720(ra) # 80003be4 <fileclose>
    return -1;
    800052a4:	57fd                	li	a5,-1
    800052a6:	a03d                	j	800052d4 <sys_pipe+0xfc>
    if(fd0 >= 0)
    800052a8:	fc442783          	lw	a5,-60(s0)
    800052ac:	0007c763          	bltz	a5,800052ba <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    800052b0:	07e9                	addi	a5,a5,26
    800052b2:	078e                	slli	a5,a5,0x3
    800052b4:	97a6                	add	a5,a5,s1
    800052b6:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800052ba:	fd043503          	ld	a0,-48(s0)
    800052be:	fffff097          	auipc	ra,0xfffff
    800052c2:	926080e7          	jalr	-1754(ra) # 80003be4 <fileclose>
    fileclose(wf);
    800052c6:	fc843503          	ld	a0,-56(s0)
    800052ca:	fffff097          	auipc	ra,0xfffff
    800052ce:	91a080e7          	jalr	-1766(ra) # 80003be4 <fileclose>
    return -1;
    800052d2:	57fd                	li	a5,-1
}
    800052d4:	853e                	mv	a0,a5
    800052d6:	70e2                	ld	ra,56(sp)
    800052d8:	7442                	ld	s0,48(sp)
    800052da:	74a2                	ld	s1,40(sp)
    800052dc:	6121                	addi	sp,sp,64
    800052de:	8082                	ret

00000000800052e0 <kernelvec>:
    800052e0:	7111                	addi	sp,sp,-256
    800052e2:	e006                	sd	ra,0(sp)
    800052e4:	e40a                	sd	sp,8(sp)
    800052e6:	e80e                	sd	gp,16(sp)
    800052e8:	ec12                	sd	tp,24(sp)
    800052ea:	f016                	sd	t0,32(sp)
    800052ec:	f41a                	sd	t1,40(sp)
    800052ee:	f81e                	sd	t2,48(sp)
    800052f0:	fc22                	sd	s0,56(sp)
    800052f2:	e0a6                	sd	s1,64(sp)
    800052f4:	e4aa                	sd	a0,72(sp)
    800052f6:	e8ae                	sd	a1,80(sp)
    800052f8:	ecb2                	sd	a2,88(sp)
    800052fa:	f0b6                	sd	a3,96(sp)
    800052fc:	f4ba                	sd	a4,104(sp)
    800052fe:	f8be                	sd	a5,112(sp)
    80005300:	fcc2                	sd	a6,120(sp)
    80005302:	e146                	sd	a7,128(sp)
    80005304:	e54a                	sd	s2,136(sp)
    80005306:	e94e                	sd	s3,144(sp)
    80005308:	ed52                	sd	s4,152(sp)
    8000530a:	f156                	sd	s5,160(sp)
    8000530c:	f55a                	sd	s6,168(sp)
    8000530e:	f95e                	sd	s7,176(sp)
    80005310:	fd62                	sd	s8,184(sp)
    80005312:	e1e6                	sd	s9,192(sp)
    80005314:	e5ea                	sd	s10,200(sp)
    80005316:	e9ee                	sd	s11,208(sp)
    80005318:	edf2                	sd	t3,216(sp)
    8000531a:	f1f6                	sd	t4,224(sp)
    8000531c:	f5fa                	sd	t5,232(sp)
    8000531e:	f9fe                	sd	t6,240(sp)
    80005320:	b39fc0ef          	jal	80001e58 <kerneltrap>
    80005324:	6082                	ld	ra,0(sp)
    80005326:	6122                	ld	sp,8(sp)
    80005328:	61c2                	ld	gp,16(sp)
    8000532a:	7282                	ld	t0,32(sp)
    8000532c:	7322                	ld	t1,40(sp)
    8000532e:	73c2                	ld	t2,48(sp)
    80005330:	7462                	ld	s0,56(sp)
    80005332:	6486                	ld	s1,64(sp)
    80005334:	6526                	ld	a0,72(sp)
    80005336:	65c6                	ld	a1,80(sp)
    80005338:	6666                	ld	a2,88(sp)
    8000533a:	7686                	ld	a3,96(sp)
    8000533c:	7726                	ld	a4,104(sp)
    8000533e:	77c6                	ld	a5,112(sp)
    80005340:	7866                	ld	a6,120(sp)
    80005342:	688a                	ld	a7,128(sp)
    80005344:	692a                	ld	s2,136(sp)
    80005346:	69ca                	ld	s3,144(sp)
    80005348:	6a6a                	ld	s4,152(sp)
    8000534a:	7a8a                	ld	s5,160(sp)
    8000534c:	7b2a                	ld	s6,168(sp)
    8000534e:	7bca                	ld	s7,176(sp)
    80005350:	7c6a                	ld	s8,184(sp)
    80005352:	6c8e                	ld	s9,192(sp)
    80005354:	6d2e                	ld	s10,200(sp)
    80005356:	6dce                	ld	s11,208(sp)
    80005358:	6e6e                	ld	t3,216(sp)
    8000535a:	7e8e                	ld	t4,224(sp)
    8000535c:	7f2e                	ld	t5,232(sp)
    8000535e:	7fce                	ld	t6,240(sp)
    80005360:	6111                	addi	sp,sp,256
    80005362:	10200073          	sret
    80005366:	00000013          	nop
    8000536a:	00000013          	nop
    8000536e:	0001                	nop

0000000080005370 <timervec>:
    80005370:	34051573          	csrrw	a0,mscratch,a0
    80005374:	e10c                	sd	a1,0(a0)
    80005376:	e510                	sd	a2,8(a0)
    80005378:	e914                	sd	a3,16(a0)
    8000537a:	6d0c                	ld	a1,24(a0)
    8000537c:	7110                	ld	a2,32(a0)
    8000537e:	6194                	ld	a3,0(a1)
    80005380:	96b2                	add	a3,a3,a2
    80005382:	e194                	sd	a3,0(a1)
    80005384:	4589                	li	a1,2
    80005386:	14459073          	csrw	sip,a1
    8000538a:	6914                	ld	a3,16(a0)
    8000538c:	6510                	ld	a2,8(a0)
    8000538e:	610c                	ld	a1,0(a0)
    80005390:	34051573          	csrrw	a0,mscratch,a0
    80005394:	30200073          	mret
	...

000000008000539a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000539a:	1141                	addi	sp,sp,-16
    8000539c:	e422                	sd	s0,8(sp)
    8000539e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800053a0:	0c0007b7          	lui	a5,0xc000
    800053a4:	4705                	li	a4,1
    800053a6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800053a8:	0c0007b7          	lui	a5,0xc000
    800053ac:	c3d8                	sw	a4,4(a5)
}
    800053ae:	6422                	ld	s0,8(sp)
    800053b0:	0141                	addi	sp,sp,16
    800053b2:	8082                	ret

00000000800053b4 <plicinithart>:

void
plicinithart(void)
{
    800053b4:	1141                	addi	sp,sp,-16
    800053b6:	e406                	sd	ra,8(sp)
    800053b8:	e022                	sd	s0,0(sp)
    800053ba:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800053bc:	ffffc097          	auipc	ra,0xffffc
    800053c0:	b1e080e7          	jalr	-1250(ra) # 80000eda <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800053c4:	0085171b          	slliw	a4,a0,0x8
    800053c8:	0c0027b7          	lui	a5,0xc002
    800053cc:	97ba                	add	a5,a5,a4
    800053ce:	40200713          	li	a4,1026
    800053d2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800053d6:	00d5151b          	slliw	a0,a0,0xd
    800053da:	0c2017b7          	lui	a5,0xc201
    800053de:	97aa                	add	a5,a5,a0
    800053e0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800053e4:	60a2                	ld	ra,8(sp)
    800053e6:	6402                	ld	s0,0(sp)
    800053e8:	0141                	addi	sp,sp,16
    800053ea:	8082                	ret

00000000800053ec <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800053ec:	1141                	addi	sp,sp,-16
    800053ee:	e406                	sd	ra,8(sp)
    800053f0:	e022                	sd	s0,0(sp)
    800053f2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800053f4:	ffffc097          	auipc	ra,0xffffc
    800053f8:	ae6080e7          	jalr	-1306(ra) # 80000eda <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800053fc:	00d5151b          	slliw	a0,a0,0xd
    80005400:	0c2017b7          	lui	a5,0xc201
    80005404:	97aa                	add	a5,a5,a0
  return irq;
}
    80005406:	43c8                	lw	a0,4(a5)
    80005408:	60a2                	ld	ra,8(sp)
    8000540a:	6402                	ld	s0,0(sp)
    8000540c:	0141                	addi	sp,sp,16
    8000540e:	8082                	ret

0000000080005410 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005410:	1101                	addi	sp,sp,-32
    80005412:	ec06                	sd	ra,24(sp)
    80005414:	e822                	sd	s0,16(sp)
    80005416:	e426                	sd	s1,8(sp)
    80005418:	1000                	addi	s0,sp,32
    8000541a:	84aa                	mv	s1,a0
  int hart = cpuid();
    8000541c:	ffffc097          	auipc	ra,0xffffc
    80005420:	abe080e7          	jalr	-1346(ra) # 80000eda <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005424:	00d5151b          	slliw	a0,a0,0xd
    80005428:	0c2017b7          	lui	a5,0xc201
    8000542c:	97aa                	add	a5,a5,a0
    8000542e:	c3c4                	sw	s1,4(a5)
}
    80005430:	60e2                	ld	ra,24(sp)
    80005432:	6442                	ld	s0,16(sp)
    80005434:	64a2                	ld	s1,8(sp)
    80005436:	6105                	addi	sp,sp,32
    80005438:	8082                	ret

000000008000543a <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    8000543a:	1141                	addi	sp,sp,-16
    8000543c:	e406                	sd	ra,8(sp)
    8000543e:	e022                	sd	s0,0(sp)
    80005440:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005442:	479d                	li	a5,7
    80005444:	04a7cc63          	blt	a5,a0,8000549c <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005448:	00017797          	auipc	a5,0x17
    8000544c:	ee878793          	addi	a5,a5,-280 # 8001c330 <disk>
    80005450:	97aa                	add	a5,a5,a0
    80005452:	0187c783          	lbu	a5,24(a5)
    80005456:	ebb9                	bnez	a5,800054ac <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005458:	00451693          	slli	a3,a0,0x4
    8000545c:	00017797          	auipc	a5,0x17
    80005460:	ed478793          	addi	a5,a5,-300 # 8001c330 <disk>
    80005464:	6398                	ld	a4,0(a5)
    80005466:	9736                	add	a4,a4,a3
    80005468:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    8000546c:	6398                	ld	a4,0(a5)
    8000546e:	9736                	add	a4,a4,a3
    80005470:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005474:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005478:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    8000547c:	97aa                	add	a5,a5,a0
    8000547e:	4705                	li	a4,1
    80005480:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80005484:	00017517          	auipc	a0,0x17
    80005488:	ec450513          	addi	a0,a0,-316 # 8001c348 <disk+0x18>
    8000548c:	ffffc097          	auipc	ra,0xffffc
    80005490:	18c080e7          	jalr	396(ra) # 80001618 <wakeup>
}
    80005494:	60a2                	ld	ra,8(sp)
    80005496:	6402                	ld	s0,0(sp)
    80005498:	0141                	addi	sp,sp,16
    8000549a:	8082                	ret
    panic("free_desc 1");
    8000549c:	00003517          	auipc	a0,0x3
    800054a0:	16c50513          	addi	a0,a0,364 # 80008608 <etext+0x608>
    800054a4:	00001097          	auipc	ra,0x1
    800054a8:	a6e080e7          	jalr	-1426(ra) # 80005f12 <panic>
    panic("free_desc 2");
    800054ac:	00003517          	auipc	a0,0x3
    800054b0:	16c50513          	addi	a0,a0,364 # 80008618 <etext+0x618>
    800054b4:	00001097          	auipc	ra,0x1
    800054b8:	a5e080e7          	jalr	-1442(ra) # 80005f12 <panic>

00000000800054bc <virtio_disk_init>:
{
    800054bc:	1101                	addi	sp,sp,-32
    800054be:	ec06                	sd	ra,24(sp)
    800054c0:	e822                	sd	s0,16(sp)
    800054c2:	e426                	sd	s1,8(sp)
    800054c4:	e04a                	sd	s2,0(sp)
    800054c6:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800054c8:	00003597          	auipc	a1,0x3
    800054cc:	16058593          	addi	a1,a1,352 # 80008628 <etext+0x628>
    800054d0:	00017517          	auipc	a0,0x17
    800054d4:	f8850513          	addi	a0,a0,-120 # 8001c458 <disk+0x128>
    800054d8:	00001097          	auipc	ra,0x1
    800054dc:	f24080e7          	jalr	-220(ra) # 800063fc <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800054e0:	100017b7          	lui	a5,0x10001
    800054e4:	4398                	lw	a4,0(a5)
    800054e6:	2701                	sext.w	a4,a4
    800054e8:	747277b7          	lui	a5,0x74727
    800054ec:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800054f0:	18f71c63          	bne	a4,a5,80005688 <virtio_disk_init+0x1cc>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800054f4:	100017b7          	lui	a5,0x10001
    800054f8:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    800054fa:	439c                	lw	a5,0(a5)
    800054fc:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800054fe:	4709                	li	a4,2
    80005500:	18e79463          	bne	a5,a4,80005688 <virtio_disk_init+0x1cc>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005504:	100017b7          	lui	a5,0x10001
    80005508:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    8000550a:	439c                	lw	a5,0(a5)
    8000550c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    8000550e:	16e79d63          	bne	a5,a4,80005688 <virtio_disk_init+0x1cc>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005512:	100017b7          	lui	a5,0x10001
    80005516:	47d8                	lw	a4,12(a5)
    80005518:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000551a:	554d47b7          	lui	a5,0x554d4
    8000551e:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005522:	16f71363          	bne	a4,a5,80005688 <virtio_disk_init+0x1cc>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005526:	100017b7          	lui	a5,0x10001
    8000552a:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000552e:	4705                	li	a4,1
    80005530:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005532:	470d                	li	a4,3
    80005534:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005536:	10001737          	lui	a4,0x10001
    8000553a:	4b14                	lw	a3,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    8000553c:	c7ffe737          	lui	a4,0xc7ffe
    80005540:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fda0af>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005544:	8ef9                	and	a3,a3,a4
    80005546:	10001737          	lui	a4,0x10001
    8000554a:	d314                	sw	a3,32(a4)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000554c:	472d                	li	a4,11
    8000554e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005550:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    80005554:	439c                	lw	a5,0(a5)
    80005556:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    8000555a:	8ba1                	andi	a5,a5,8
    8000555c:	12078e63          	beqz	a5,80005698 <virtio_disk_init+0x1dc>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005560:	100017b7          	lui	a5,0x10001
    80005564:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005568:	100017b7          	lui	a5,0x10001
    8000556c:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    80005570:	439c                	lw	a5,0(a5)
    80005572:	2781                	sext.w	a5,a5
    80005574:	12079a63          	bnez	a5,800056a8 <virtio_disk_init+0x1ec>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005578:	100017b7          	lui	a5,0x10001
    8000557c:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80005580:	439c                	lw	a5,0(a5)
    80005582:	2781                	sext.w	a5,a5
  if(max == 0)
    80005584:	12078a63          	beqz	a5,800056b8 <virtio_disk_init+0x1fc>
  if(max < NUM)
    80005588:	471d                	li	a4,7
    8000558a:	12f77f63          	bgeu	a4,a5,800056c8 <virtio_disk_init+0x20c>
  disk.desc = kalloc();
    8000558e:	ffffb097          	auipc	ra,0xffffb
    80005592:	b8c080e7          	jalr	-1140(ra) # 8000011a <kalloc>
    80005596:	00017497          	auipc	s1,0x17
    8000559a:	d9a48493          	addi	s1,s1,-614 # 8001c330 <disk>
    8000559e:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800055a0:	ffffb097          	auipc	ra,0xffffb
    800055a4:	b7a080e7          	jalr	-1158(ra) # 8000011a <kalloc>
    800055a8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800055aa:	ffffb097          	auipc	ra,0xffffb
    800055ae:	b70080e7          	jalr	-1168(ra) # 8000011a <kalloc>
    800055b2:	87aa                	mv	a5,a0
    800055b4:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800055b6:	6088                	ld	a0,0(s1)
    800055b8:	12050063          	beqz	a0,800056d8 <virtio_disk_init+0x21c>
    800055bc:	00017717          	auipc	a4,0x17
    800055c0:	d7c73703          	ld	a4,-644(a4) # 8001c338 <disk+0x8>
    800055c4:	10070a63          	beqz	a4,800056d8 <virtio_disk_init+0x21c>
    800055c8:	10078863          	beqz	a5,800056d8 <virtio_disk_init+0x21c>
  memset(disk.desc, 0, PGSIZE);
    800055cc:	6605                	lui	a2,0x1
    800055ce:	4581                	li	a1,0
    800055d0:	ffffb097          	auipc	ra,0xffffb
    800055d4:	baa080e7          	jalr	-1110(ra) # 8000017a <memset>
  memset(disk.avail, 0, PGSIZE);
    800055d8:	00017497          	auipc	s1,0x17
    800055dc:	d5848493          	addi	s1,s1,-680 # 8001c330 <disk>
    800055e0:	6605                	lui	a2,0x1
    800055e2:	4581                	li	a1,0
    800055e4:	6488                	ld	a0,8(s1)
    800055e6:	ffffb097          	auipc	ra,0xffffb
    800055ea:	b94080e7          	jalr	-1132(ra) # 8000017a <memset>
  memset(disk.used, 0, PGSIZE);
    800055ee:	6605                	lui	a2,0x1
    800055f0:	4581                	li	a1,0
    800055f2:	6888                	ld	a0,16(s1)
    800055f4:	ffffb097          	auipc	ra,0xffffb
    800055f8:	b86080e7          	jalr	-1146(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800055fc:	100017b7          	lui	a5,0x10001
    80005600:	4721                	li	a4,8
    80005602:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80005604:	4098                	lw	a4,0(s1)
    80005606:	100017b7          	lui	a5,0x10001
    8000560a:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    8000560e:	40d8                	lw	a4,4(s1)
    80005610:	100017b7          	lui	a5,0x10001
    80005614:	08e7a223          	sw	a4,132(a5) # 10001084 <_entry-0x6fffef7c>
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80005618:	649c                	ld	a5,8(s1)
    8000561a:	0007869b          	sext.w	a3,a5
    8000561e:	10001737          	lui	a4,0x10001
    80005622:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005626:	9781                	srai	a5,a5,0x20
    80005628:	10001737          	lui	a4,0x10001
    8000562c:	08f72a23          	sw	a5,148(a4) # 10001094 <_entry-0x6fffef6c>
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80005630:	689c                	ld	a5,16(s1)
    80005632:	0007869b          	sext.w	a3,a5
    80005636:	10001737          	lui	a4,0x10001
    8000563a:	0ad72023          	sw	a3,160(a4) # 100010a0 <_entry-0x6fffef60>
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    8000563e:	9781                	srai	a5,a5,0x20
    80005640:	10001737          	lui	a4,0x10001
    80005644:	0af72223          	sw	a5,164(a4) # 100010a4 <_entry-0x6fffef5c>
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80005648:	10001737          	lui	a4,0x10001
    8000564c:	4785                	li	a5,1
    8000564e:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80005650:	00f48c23          	sb	a5,24(s1)
    80005654:	00f48ca3          	sb	a5,25(s1)
    80005658:	00f48d23          	sb	a5,26(s1)
    8000565c:	00f48da3          	sb	a5,27(s1)
    80005660:	00f48e23          	sb	a5,28(s1)
    80005664:	00f48ea3          	sb	a5,29(s1)
    80005668:	00f48f23          	sb	a5,30(s1)
    8000566c:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80005670:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005674:	100017b7          	lui	a5,0x10001
    80005678:	0727a823          	sw	s2,112(a5) # 10001070 <_entry-0x6fffef90>
}
    8000567c:	60e2                	ld	ra,24(sp)
    8000567e:	6442                	ld	s0,16(sp)
    80005680:	64a2                	ld	s1,8(sp)
    80005682:	6902                	ld	s2,0(sp)
    80005684:	6105                	addi	sp,sp,32
    80005686:	8082                	ret
    panic("could not find virtio disk");
    80005688:	00003517          	auipc	a0,0x3
    8000568c:	fb050513          	addi	a0,a0,-80 # 80008638 <etext+0x638>
    80005690:	00001097          	auipc	ra,0x1
    80005694:	882080e7          	jalr	-1918(ra) # 80005f12 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005698:	00003517          	auipc	a0,0x3
    8000569c:	fc050513          	addi	a0,a0,-64 # 80008658 <etext+0x658>
    800056a0:	00001097          	auipc	ra,0x1
    800056a4:	872080e7          	jalr	-1934(ra) # 80005f12 <panic>
    panic("virtio disk should not be ready");
    800056a8:	00003517          	auipc	a0,0x3
    800056ac:	fd050513          	addi	a0,a0,-48 # 80008678 <etext+0x678>
    800056b0:	00001097          	auipc	ra,0x1
    800056b4:	862080e7          	jalr	-1950(ra) # 80005f12 <panic>
    panic("virtio disk has no queue 0");
    800056b8:	00003517          	auipc	a0,0x3
    800056bc:	fe050513          	addi	a0,a0,-32 # 80008698 <etext+0x698>
    800056c0:	00001097          	auipc	ra,0x1
    800056c4:	852080e7          	jalr	-1966(ra) # 80005f12 <panic>
    panic("virtio disk max queue too short");
    800056c8:	00003517          	auipc	a0,0x3
    800056cc:	ff050513          	addi	a0,a0,-16 # 800086b8 <etext+0x6b8>
    800056d0:	00001097          	auipc	ra,0x1
    800056d4:	842080e7          	jalr	-1982(ra) # 80005f12 <panic>
    panic("virtio disk kalloc");
    800056d8:	00003517          	auipc	a0,0x3
    800056dc:	00050513          	mv	a0,a0
    800056e0:	00001097          	auipc	ra,0x1
    800056e4:	832080e7          	jalr	-1998(ra) # 80005f12 <panic>

00000000800056e8 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800056e8:	7159                	addi	sp,sp,-112
    800056ea:	f486                	sd	ra,104(sp)
    800056ec:	f0a2                	sd	s0,96(sp)
    800056ee:	eca6                	sd	s1,88(sp)
    800056f0:	e8ca                	sd	s2,80(sp)
    800056f2:	e4ce                	sd	s3,72(sp)
    800056f4:	e0d2                	sd	s4,64(sp)
    800056f6:	fc56                	sd	s5,56(sp)
    800056f8:	f85a                	sd	s6,48(sp)
    800056fa:	f45e                	sd	s7,40(sp)
    800056fc:	f062                	sd	s8,32(sp)
    800056fe:	ec66                	sd	s9,24(sp)
    80005700:	1880                	addi	s0,sp,112
    80005702:	8a2a                	mv	s4,a0
    80005704:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005706:	00c52c83          	lw	s9,12(a0) # 800086e4 <etext+0x6e4>
    8000570a:	001c9c9b          	slliw	s9,s9,0x1
    8000570e:	1c82                	slli	s9,s9,0x20
    80005710:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005714:	00017517          	auipc	a0,0x17
    80005718:	d4450513          	addi	a0,a0,-700 # 8001c458 <disk+0x128>
    8000571c:	00001097          	auipc	ra,0x1
    80005720:	d70080e7          	jalr	-656(ra) # 8000648c <acquire>
  for(int i = 0; i < 3; i++){
    80005724:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005726:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005728:	00017b17          	auipc	s6,0x17
    8000572c:	c08b0b13          	addi	s6,s6,-1016 # 8001c330 <disk>
  for(int i = 0; i < 3; i++){
    80005730:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005732:	00017c17          	auipc	s8,0x17
    80005736:	d26c0c13          	addi	s8,s8,-730 # 8001c458 <disk+0x128>
    8000573a:	a0ad                	j	800057a4 <virtio_disk_rw+0xbc>
      disk.free[i] = 0;
    8000573c:	00fb0733          	add	a4,s6,a5
    80005740:	00070c23          	sb	zero,24(a4) # 10001018 <_entry-0x6fffefe8>
    idx[i] = alloc_desc();
    80005744:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005746:	0207c563          	bltz	a5,80005770 <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    8000574a:	2905                	addiw	s2,s2,1
    8000574c:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    8000574e:	05590f63          	beq	s2,s5,800057ac <virtio_disk_rw+0xc4>
    idx[i] = alloc_desc();
    80005752:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005754:	00017717          	auipc	a4,0x17
    80005758:	bdc70713          	addi	a4,a4,-1060 # 8001c330 <disk>
    8000575c:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000575e:	01874683          	lbu	a3,24(a4)
    80005762:	fee9                	bnez	a3,8000573c <virtio_disk_rw+0x54>
  for(int i = 0; i < NUM; i++){
    80005764:	2785                	addiw	a5,a5,1
    80005766:	0705                	addi	a4,a4,1
    80005768:	fe979be3          	bne	a5,s1,8000575e <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000576c:	57fd                	li	a5,-1
    8000576e:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80005770:	03205163          	blez	s2,80005792 <virtio_disk_rw+0xaa>
        free_desc(idx[j]);
    80005774:	f9042503          	lw	a0,-112(s0)
    80005778:	00000097          	auipc	ra,0x0
    8000577c:	cc2080e7          	jalr	-830(ra) # 8000543a <free_desc>
      for(int j = 0; j < i; j++)
    80005780:	4785                	li	a5,1
    80005782:	0127d863          	bge	a5,s2,80005792 <virtio_disk_rw+0xaa>
        free_desc(idx[j]);
    80005786:	f9442503          	lw	a0,-108(s0)
    8000578a:	00000097          	auipc	ra,0x0
    8000578e:	cb0080e7          	jalr	-848(ra) # 8000543a <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005792:	85e2                	mv	a1,s8
    80005794:	00017517          	auipc	a0,0x17
    80005798:	bb450513          	addi	a0,a0,-1100 # 8001c348 <disk+0x18>
    8000579c:	ffffc097          	auipc	ra,0xffffc
    800057a0:	e18080e7          	jalr	-488(ra) # 800015b4 <sleep>
  for(int i = 0; i < 3; i++){
    800057a4:	f9040613          	addi	a2,s0,-112
    800057a8:	894e                	mv	s2,s3
    800057aa:	b765                	j	80005752 <virtio_disk_rw+0x6a>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800057ac:	f9042503          	lw	a0,-112(s0)
    800057b0:	00451693          	slli	a3,a0,0x4

  if(write)
    800057b4:	00017797          	auipc	a5,0x17
    800057b8:	b7c78793          	addi	a5,a5,-1156 # 8001c330 <disk>
    800057bc:	00a50713          	addi	a4,a0,10
    800057c0:	0712                	slli	a4,a4,0x4
    800057c2:	973e                	add	a4,a4,a5
    800057c4:	01703633          	snez	a2,s7
    800057c8:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800057ca:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    800057ce:	01973823          	sd	s9,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800057d2:	6398                	ld	a4,0(a5)
    800057d4:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800057d6:	0a868613          	addi	a2,a3,168
    800057da:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    800057dc:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800057de:	6390                	ld	a2,0(a5)
    800057e0:	00d605b3          	add	a1,a2,a3
    800057e4:	4741                	li	a4,16
    800057e6:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800057e8:	4805                	li	a6,1
    800057ea:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    800057ee:	f9442703          	lw	a4,-108(s0)
    800057f2:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800057f6:	0712                	slli	a4,a4,0x4
    800057f8:	963a                	add	a2,a2,a4
    800057fa:	058a0593          	addi	a1,s4,88
    800057fe:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005800:	0007b883          	ld	a7,0(a5)
    80005804:	9746                	add	a4,a4,a7
    80005806:	40000613          	li	a2,1024
    8000580a:	c710                	sw	a2,8(a4)
  if(write)
    8000580c:	001bb613          	seqz	a2,s7
    80005810:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005814:	00166613          	ori	a2,a2,1
    80005818:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    8000581c:	f9842583          	lw	a1,-104(s0)
    80005820:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005824:	00250613          	addi	a2,a0,2
    80005828:	0612                	slli	a2,a2,0x4
    8000582a:	963e                	add	a2,a2,a5
    8000582c:	577d                	li	a4,-1
    8000582e:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005832:	0592                	slli	a1,a1,0x4
    80005834:	98ae                	add	a7,a7,a1
    80005836:	03068713          	addi	a4,a3,48
    8000583a:	973e                	add	a4,a4,a5
    8000583c:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80005840:	6398                	ld	a4,0(a5)
    80005842:	972e                	add	a4,a4,a1
    80005844:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005848:	4689                	li	a3,2
    8000584a:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    8000584e:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005852:	010a2223          	sw	a6,4(s4)
  disk.info[idx[0]].b = b;
    80005856:	01463423          	sd	s4,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    8000585a:	6794                	ld	a3,8(a5)
    8000585c:	0026d703          	lhu	a4,2(a3)
    80005860:	8b1d                	andi	a4,a4,7
    80005862:	0706                	slli	a4,a4,0x1
    80005864:	96ba                	add	a3,a3,a4
    80005866:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    8000586a:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000586e:	6798                	ld	a4,8(a5)
    80005870:	00275783          	lhu	a5,2(a4)
    80005874:	2785                	addiw	a5,a5,1
    80005876:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    8000587a:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000587e:	100017b7          	lui	a5,0x10001
    80005882:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005886:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    8000588a:	00017917          	auipc	s2,0x17
    8000588e:	bce90913          	addi	s2,s2,-1074 # 8001c458 <disk+0x128>
  while(b->disk == 1) {
    80005892:	4485                	li	s1,1
    80005894:	01079c63          	bne	a5,a6,800058ac <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    80005898:	85ca                	mv	a1,s2
    8000589a:	8552                	mv	a0,s4
    8000589c:	ffffc097          	auipc	ra,0xffffc
    800058a0:	d18080e7          	jalr	-744(ra) # 800015b4 <sleep>
  while(b->disk == 1) {
    800058a4:	004a2783          	lw	a5,4(s4)
    800058a8:	fe9788e3          	beq	a5,s1,80005898 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800058ac:	f9042903          	lw	s2,-112(s0)
    800058b0:	00290713          	addi	a4,s2,2
    800058b4:	0712                	slli	a4,a4,0x4
    800058b6:	00017797          	auipc	a5,0x17
    800058ba:	a7a78793          	addi	a5,a5,-1414 # 8001c330 <disk>
    800058be:	97ba                	add	a5,a5,a4
    800058c0:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800058c4:	00017997          	auipc	s3,0x17
    800058c8:	a6c98993          	addi	s3,s3,-1428 # 8001c330 <disk>
    800058cc:	00491713          	slli	a4,s2,0x4
    800058d0:	0009b783          	ld	a5,0(s3)
    800058d4:	97ba                	add	a5,a5,a4
    800058d6:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800058da:	854a                	mv	a0,s2
    800058dc:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800058e0:	00000097          	auipc	ra,0x0
    800058e4:	b5a080e7          	jalr	-1190(ra) # 8000543a <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800058e8:	8885                	andi	s1,s1,1
    800058ea:	f0ed                	bnez	s1,800058cc <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800058ec:	00017517          	auipc	a0,0x17
    800058f0:	b6c50513          	addi	a0,a0,-1172 # 8001c458 <disk+0x128>
    800058f4:	00001097          	auipc	ra,0x1
    800058f8:	c4c080e7          	jalr	-948(ra) # 80006540 <release>
}
    800058fc:	70a6                	ld	ra,104(sp)
    800058fe:	7406                	ld	s0,96(sp)
    80005900:	64e6                	ld	s1,88(sp)
    80005902:	6946                	ld	s2,80(sp)
    80005904:	69a6                	ld	s3,72(sp)
    80005906:	6a06                	ld	s4,64(sp)
    80005908:	7ae2                	ld	s5,56(sp)
    8000590a:	7b42                	ld	s6,48(sp)
    8000590c:	7ba2                	ld	s7,40(sp)
    8000590e:	7c02                	ld	s8,32(sp)
    80005910:	6ce2                	ld	s9,24(sp)
    80005912:	6165                	addi	sp,sp,112
    80005914:	8082                	ret

0000000080005916 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005916:	1101                	addi	sp,sp,-32
    80005918:	ec06                	sd	ra,24(sp)
    8000591a:	e822                	sd	s0,16(sp)
    8000591c:	e426                	sd	s1,8(sp)
    8000591e:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005920:	00017497          	auipc	s1,0x17
    80005924:	a1048493          	addi	s1,s1,-1520 # 8001c330 <disk>
    80005928:	00017517          	auipc	a0,0x17
    8000592c:	b3050513          	addi	a0,a0,-1232 # 8001c458 <disk+0x128>
    80005930:	00001097          	auipc	ra,0x1
    80005934:	b5c080e7          	jalr	-1188(ra) # 8000648c <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005938:	100017b7          	lui	a5,0x10001
    8000593c:	53b8                	lw	a4,96(a5)
    8000593e:	8b0d                	andi	a4,a4,3
    80005940:	100017b7          	lui	a5,0x10001
    80005944:	d3f8                	sw	a4,100(a5)

  __sync_synchronize();
    80005946:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    8000594a:	689c                	ld	a5,16(s1)
    8000594c:	0204d703          	lhu	a4,32(s1)
    80005950:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80005954:	04f70863          	beq	a4,a5,800059a4 <virtio_disk_intr+0x8e>
    __sync_synchronize();
    80005958:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000595c:	6898                	ld	a4,16(s1)
    8000595e:	0204d783          	lhu	a5,32(s1)
    80005962:	8b9d                	andi	a5,a5,7
    80005964:	078e                	slli	a5,a5,0x3
    80005966:	97ba                	add	a5,a5,a4
    80005968:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000596a:	00278713          	addi	a4,a5,2
    8000596e:	0712                	slli	a4,a4,0x4
    80005970:	9726                	add	a4,a4,s1
    80005972:	01074703          	lbu	a4,16(a4)
    80005976:	e721                	bnez	a4,800059be <virtio_disk_intr+0xa8>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005978:	0789                	addi	a5,a5,2
    8000597a:	0792                	slli	a5,a5,0x4
    8000597c:	97a6                	add	a5,a5,s1
    8000597e:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80005980:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005984:	ffffc097          	auipc	ra,0xffffc
    80005988:	c94080e7          	jalr	-876(ra) # 80001618 <wakeup>

    disk.used_idx += 1;
    8000598c:	0204d783          	lhu	a5,32(s1)
    80005990:	2785                	addiw	a5,a5,1
    80005992:	17c2                	slli	a5,a5,0x30
    80005994:	93c1                	srli	a5,a5,0x30
    80005996:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000599a:	6898                	ld	a4,16(s1)
    8000599c:	00275703          	lhu	a4,2(a4)
    800059a0:	faf71ce3          	bne	a4,a5,80005958 <virtio_disk_intr+0x42>
  }

  release(&disk.vdisk_lock);
    800059a4:	00017517          	auipc	a0,0x17
    800059a8:	ab450513          	addi	a0,a0,-1356 # 8001c458 <disk+0x128>
    800059ac:	00001097          	auipc	ra,0x1
    800059b0:	b94080e7          	jalr	-1132(ra) # 80006540 <release>
}
    800059b4:	60e2                	ld	ra,24(sp)
    800059b6:	6442                	ld	s0,16(sp)
    800059b8:	64a2                	ld	s1,8(sp)
    800059ba:	6105                	addi	sp,sp,32
    800059bc:	8082                	ret
      panic("virtio_disk_intr status");
    800059be:	00003517          	auipc	a0,0x3
    800059c2:	d3250513          	addi	a0,a0,-718 # 800086f0 <etext+0x6f0>
    800059c6:	00000097          	auipc	ra,0x0
    800059ca:	54c080e7          	jalr	1356(ra) # 80005f12 <panic>

00000000800059ce <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800059ce:	1141                	addi	sp,sp,-16
    800059d0:	e422                	sd	s0,8(sp)
    800059d2:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800059d4:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800059d8:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800059dc:	0037979b          	slliw	a5,a5,0x3
    800059e0:	02004737          	lui	a4,0x2004
    800059e4:	97ba                	add	a5,a5,a4
    800059e6:	0200c737          	lui	a4,0x200c
    800059ea:	1761                	addi	a4,a4,-8 # 200bff8 <_entry-0x7dff4008>
    800059ec:	6318                	ld	a4,0(a4)
    800059ee:	000f4637          	lui	a2,0xf4
    800059f2:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800059f6:	9732                	add	a4,a4,a2
    800059f8:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800059fa:	00259693          	slli	a3,a1,0x2
    800059fe:	96ae                	add	a3,a3,a1
    80005a00:	068e                	slli	a3,a3,0x3
    80005a02:	00017717          	auipc	a4,0x17
    80005a06:	a6e70713          	addi	a4,a4,-1426 # 8001c470 <timer_scratch>
    80005a0a:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005a0c:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005a0e:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005a10:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005a14:	00000797          	auipc	a5,0x0
    80005a18:	95c78793          	addi	a5,a5,-1700 # 80005370 <timervec>
    80005a1c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a20:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005a24:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a28:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005a2c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005a30:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005a34:	30479073          	csrw	mie,a5
}
    80005a38:	6422                	ld	s0,8(sp)
    80005a3a:	0141                	addi	sp,sp,16
    80005a3c:	8082                	ret

0000000080005a3e <start>:
{
    80005a3e:	1141                	addi	sp,sp,-16
    80005a40:	e406                	sd	ra,8(sp)
    80005a42:	e022                	sd	s0,0(sp)
    80005a44:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a46:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005a4a:	7779                	lui	a4,0xffffe
    80005a4c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffda14f>
    80005a50:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005a52:	6705                	lui	a4,0x1
    80005a54:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005a58:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a5a:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005a5e:	ffffb797          	auipc	a5,0xffffb
    80005a62:	8ba78793          	addi	a5,a5,-1862 # 80000318 <main>
    80005a66:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005a6a:	4781                	li	a5,0
    80005a6c:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005a70:	67c1                	lui	a5,0x10
    80005a72:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005a74:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005a78:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005a7c:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005a80:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005a84:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005a88:	57fd                	li	a5,-1
    80005a8a:	83a9                	srli	a5,a5,0xa
    80005a8c:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005a90:	47bd                	li	a5,15
    80005a92:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005a96:	00000097          	auipc	ra,0x0
    80005a9a:	f38080e7          	jalr	-200(ra) # 800059ce <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005a9e:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005aa2:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005aa4:	823e                	mv	tp,a5
  asm volatile("mret");
    80005aa6:	30200073          	mret
}
    80005aaa:	60a2                	ld	ra,8(sp)
    80005aac:	6402                	ld	s0,0(sp)
    80005aae:	0141                	addi	sp,sp,16
    80005ab0:	8082                	ret

0000000080005ab2 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005ab2:	715d                	addi	sp,sp,-80
    80005ab4:	e486                	sd	ra,72(sp)
    80005ab6:	e0a2                	sd	s0,64(sp)
    80005ab8:	f84a                	sd	s2,48(sp)
    80005aba:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005abc:	04c05663          	blez	a2,80005b08 <consolewrite+0x56>
    80005ac0:	fc26                	sd	s1,56(sp)
    80005ac2:	f44e                	sd	s3,40(sp)
    80005ac4:	f052                	sd	s4,32(sp)
    80005ac6:	ec56                	sd	s5,24(sp)
    80005ac8:	8a2a                	mv	s4,a0
    80005aca:	84ae                	mv	s1,a1
    80005acc:	89b2                	mv	s3,a2
    80005ace:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005ad0:	5afd                	li	s5,-1
    80005ad2:	4685                	li	a3,1
    80005ad4:	8626                	mv	a2,s1
    80005ad6:	85d2                	mv	a1,s4
    80005ad8:	fbf40513          	addi	a0,s0,-65
    80005adc:	ffffc097          	auipc	ra,0xffffc
    80005ae0:	f36080e7          	jalr	-202(ra) # 80001a12 <either_copyin>
    80005ae4:	03550463          	beq	a0,s5,80005b0c <consolewrite+0x5a>
      break;
    uartputc(c);
    80005ae8:	fbf44503          	lbu	a0,-65(s0)
    80005aec:	00000097          	auipc	ra,0x0
    80005af0:	7e4080e7          	jalr	2020(ra) # 800062d0 <uartputc>
  for(i = 0; i < n; i++){
    80005af4:	2905                	addiw	s2,s2,1
    80005af6:	0485                	addi	s1,s1,1
    80005af8:	fd299de3          	bne	s3,s2,80005ad2 <consolewrite+0x20>
    80005afc:	894e                	mv	s2,s3
    80005afe:	74e2                	ld	s1,56(sp)
    80005b00:	79a2                	ld	s3,40(sp)
    80005b02:	7a02                	ld	s4,32(sp)
    80005b04:	6ae2                	ld	s5,24(sp)
    80005b06:	a039                	j	80005b14 <consolewrite+0x62>
    80005b08:	4901                	li	s2,0
    80005b0a:	a029                	j	80005b14 <consolewrite+0x62>
    80005b0c:	74e2                	ld	s1,56(sp)
    80005b0e:	79a2                	ld	s3,40(sp)
    80005b10:	7a02                	ld	s4,32(sp)
    80005b12:	6ae2                	ld	s5,24(sp)
  }

  return i;
}
    80005b14:	854a                	mv	a0,s2
    80005b16:	60a6                	ld	ra,72(sp)
    80005b18:	6406                	ld	s0,64(sp)
    80005b1a:	7942                	ld	s2,48(sp)
    80005b1c:	6161                	addi	sp,sp,80
    80005b1e:	8082                	ret

0000000080005b20 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005b20:	711d                	addi	sp,sp,-96
    80005b22:	ec86                	sd	ra,88(sp)
    80005b24:	e8a2                	sd	s0,80(sp)
    80005b26:	e4a6                	sd	s1,72(sp)
    80005b28:	e0ca                	sd	s2,64(sp)
    80005b2a:	fc4e                	sd	s3,56(sp)
    80005b2c:	f852                	sd	s4,48(sp)
    80005b2e:	f456                	sd	s5,40(sp)
    80005b30:	f05a                	sd	s6,32(sp)
    80005b32:	1080                	addi	s0,sp,96
    80005b34:	8aaa                	mv	s5,a0
    80005b36:	8a2e                	mv	s4,a1
    80005b38:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005b3a:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80005b3e:	0001f517          	auipc	a0,0x1f
    80005b42:	a7250513          	addi	a0,a0,-1422 # 800245b0 <cons>
    80005b46:	00001097          	auipc	ra,0x1
    80005b4a:	946080e7          	jalr	-1722(ra) # 8000648c <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005b4e:	0001f497          	auipc	s1,0x1f
    80005b52:	a6248493          	addi	s1,s1,-1438 # 800245b0 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005b56:	0001f917          	auipc	s2,0x1f
    80005b5a:	af290913          	addi	s2,s2,-1294 # 80024648 <cons+0x98>
  while(n > 0){
    80005b5e:	0d305763          	blez	s3,80005c2c <consoleread+0x10c>
    while(cons.r == cons.w){
    80005b62:	0984a783          	lw	a5,152(s1)
    80005b66:	09c4a703          	lw	a4,156(s1)
    80005b6a:	0af71c63          	bne	a4,a5,80005c22 <consoleread+0x102>
      if(killed(myproc())){
    80005b6e:	ffffb097          	auipc	ra,0xffffb
    80005b72:	398080e7          	jalr	920(ra) # 80000f06 <myproc>
    80005b76:	ffffc097          	auipc	ra,0xffffc
    80005b7a:	ce6080e7          	jalr	-794(ra) # 8000185c <killed>
    80005b7e:	e52d                	bnez	a0,80005be8 <consoleread+0xc8>
      sleep(&cons.r, &cons.lock);
    80005b80:	85a6                	mv	a1,s1
    80005b82:	854a                	mv	a0,s2
    80005b84:	ffffc097          	auipc	ra,0xffffc
    80005b88:	a30080e7          	jalr	-1488(ra) # 800015b4 <sleep>
    while(cons.r == cons.w){
    80005b8c:	0984a783          	lw	a5,152(s1)
    80005b90:	09c4a703          	lw	a4,156(s1)
    80005b94:	fcf70de3          	beq	a4,a5,80005b6e <consoleread+0x4e>
    80005b98:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005b9a:	0001f717          	auipc	a4,0x1f
    80005b9e:	a1670713          	addi	a4,a4,-1514 # 800245b0 <cons>
    80005ba2:	0017869b          	addiw	a3,a5,1
    80005ba6:	08d72c23          	sw	a3,152(a4)
    80005baa:	07f7f693          	andi	a3,a5,127
    80005bae:	9736                	add	a4,a4,a3
    80005bb0:	01874703          	lbu	a4,24(a4)
    80005bb4:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80005bb8:	4691                	li	a3,4
    80005bba:	04db8a63          	beq	s7,a3,80005c0e <consoleread+0xee>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005bbe:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005bc2:	4685                	li	a3,1
    80005bc4:	faf40613          	addi	a2,s0,-81
    80005bc8:	85d2                	mv	a1,s4
    80005bca:	8556                	mv	a0,s5
    80005bcc:	ffffc097          	auipc	ra,0xffffc
    80005bd0:	df0080e7          	jalr	-528(ra) # 800019bc <either_copyout>
    80005bd4:	57fd                	li	a5,-1
    80005bd6:	04f50a63          	beq	a0,a5,80005c2a <consoleread+0x10a>
      break;

    dst++;
    80005bda:	0a05                	addi	s4,s4,1
    --n;
    80005bdc:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80005bde:	47a9                	li	a5,10
    80005be0:	06fb8163          	beq	s7,a5,80005c42 <consoleread+0x122>
    80005be4:	6be2                	ld	s7,24(sp)
    80005be6:	bfa5                	j	80005b5e <consoleread+0x3e>
        release(&cons.lock);
    80005be8:	0001f517          	auipc	a0,0x1f
    80005bec:	9c850513          	addi	a0,a0,-1592 # 800245b0 <cons>
    80005bf0:	00001097          	auipc	ra,0x1
    80005bf4:	950080e7          	jalr	-1712(ra) # 80006540 <release>
        return -1;
    80005bf8:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80005bfa:	60e6                	ld	ra,88(sp)
    80005bfc:	6446                	ld	s0,80(sp)
    80005bfe:	64a6                	ld	s1,72(sp)
    80005c00:	6906                	ld	s2,64(sp)
    80005c02:	79e2                	ld	s3,56(sp)
    80005c04:	7a42                	ld	s4,48(sp)
    80005c06:	7aa2                	ld	s5,40(sp)
    80005c08:	7b02                	ld	s6,32(sp)
    80005c0a:	6125                	addi	sp,sp,96
    80005c0c:	8082                	ret
      if(n < target){
    80005c0e:	0009871b          	sext.w	a4,s3
    80005c12:	01677a63          	bgeu	a4,s6,80005c26 <consoleread+0x106>
        cons.r--;
    80005c16:	0001f717          	auipc	a4,0x1f
    80005c1a:	a2f72923          	sw	a5,-1486(a4) # 80024648 <cons+0x98>
    80005c1e:	6be2                	ld	s7,24(sp)
    80005c20:	a031                	j	80005c2c <consoleread+0x10c>
    80005c22:	ec5e                	sd	s7,24(sp)
    80005c24:	bf9d                	j	80005b9a <consoleread+0x7a>
    80005c26:	6be2                	ld	s7,24(sp)
    80005c28:	a011                	j	80005c2c <consoleread+0x10c>
    80005c2a:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80005c2c:	0001f517          	auipc	a0,0x1f
    80005c30:	98450513          	addi	a0,a0,-1660 # 800245b0 <cons>
    80005c34:	00001097          	auipc	ra,0x1
    80005c38:	90c080e7          	jalr	-1780(ra) # 80006540 <release>
  return target - n;
    80005c3c:	413b053b          	subw	a0,s6,s3
    80005c40:	bf6d                	j	80005bfa <consoleread+0xda>
    80005c42:	6be2                	ld	s7,24(sp)
    80005c44:	b7e5                	j	80005c2c <consoleread+0x10c>

0000000080005c46 <consputc>:
{
    80005c46:	1141                	addi	sp,sp,-16
    80005c48:	e406                	sd	ra,8(sp)
    80005c4a:	e022                	sd	s0,0(sp)
    80005c4c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005c4e:	10000793          	li	a5,256
    80005c52:	00f50a63          	beq	a0,a5,80005c66 <consputc+0x20>
    uartputc_sync(c);
    80005c56:	00000097          	auipc	ra,0x0
    80005c5a:	59c080e7          	jalr	1436(ra) # 800061f2 <uartputc_sync>
}
    80005c5e:	60a2                	ld	ra,8(sp)
    80005c60:	6402                	ld	s0,0(sp)
    80005c62:	0141                	addi	sp,sp,16
    80005c64:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005c66:	4521                	li	a0,8
    80005c68:	00000097          	auipc	ra,0x0
    80005c6c:	58a080e7          	jalr	1418(ra) # 800061f2 <uartputc_sync>
    80005c70:	02000513          	li	a0,32
    80005c74:	00000097          	auipc	ra,0x0
    80005c78:	57e080e7          	jalr	1406(ra) # 800061f2 <uartputc_sync>
    80005c7c:	4521                	li	a0,8
    80005c7e:	00000097          	auipc	ra,0x0
    80005c82:	574080e7          	jalr	1396(ra) # 800061f2 <uartputc_sync>
    80005c86:	bfe1                	j	80005c5e <consputc+0x18>

0000000080005c88 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005c88:	1101                	addi	sp,sp,-32
    80005c8a:	ec06                	sd	ra,24(sp)
    80005c8c:	e822                	sd	s0,16(sp)
    80005c8e:	e426                	sd	s1,8(sp)
    80005c90:	1000                	addi	s0,sp,32
    80005c92:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005c94:	0001f517          	auipc	a0,0x1f
    80005c98:	91c50513          	addi	a0,a0,-1764 # 800245b0 <cons>
    80005c9c:	00000097          	auipc	ra,0x0
    80005ca0:	7f0080e7          	jalr	2032(ra) # 8000648c <acquire>

  switch(c){
    80005ca4:	47d5                	li	a5,21
    80005ca6:	0af48563          	beq	s1,a5,80005d50 <consoleintr+0xc8>
    80005caa:	0297c963          	blt	a5,s1,80005cdc <consoleintr+0x54>
    80005cae:	47a1                	li	a5,8
    80005cb0:	0ef48c63          	beq	s1,a5,80005da8 <consoleintr+0x120>
    80005cb4:	47c1                	li	a5,16
    80005cb6:	10f49f63          	bne	s1,a5,80005dd4 <consoleintr+0x14c>
  case C('P'):  // Print process list.
    procdump();
    80005cba:	ffffc097          	auipc	ra,0xffffc
    80005cbe:	dae080e7          	jalr	-594(ra) # 80001a68 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005cc2:	0001f517          	auipc	a0,0x1f
    80005cc6:	8ee50513          	addi	a0,a0,-1810 # 800245b0 <cons>
    80005cca:	00001097          	auipc	ra,0x1
    80005cce:	876080e7          	jalr	-1930(ra) # 80006540 <release>
}
    80005cd2:	60e2                	ld	ra,24(sp)
    80005cd4:	6442                	ld	s0,16(sp)
    80005cd6:	64a2                	ld	s1,8(sp)
    80005cd8:	6105                	addi	sp,sp,32
    80005cda:	8082                	ret
  switch(c){
    80005cdc:	07f00793          	li	a5,127
    80005ce0:	0cf48463          	beq	s1,a5,80005da8 <consoleintr+0x120>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005ce4:	0001f717          	auipc	a4,0x1f
    80005ce8:	8cc70713          	addi	a4,a4,-1844 # 800245b0 <cons>
    80005cec:	0a072783          	lw	a5,160(a4)
    80005cf0:	09872703          	lw	a4,152(a4)
    80005cf4:	9f99                	subw	a5,a5,a4
    80005cf6:	07f00713          	li	a4,127
    80005cfa:	fcf764e3          	bltu	a4,a5,80005cc2 <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    80005cfe:	47b5                	li	a5,13
    80005d00:	0cf48d63          	beq	s1,a5,80005dda <consoleintr+0x152>
      consputc(c);
    80005d04:	8526                	mv	a0,s1
    80005d06:	00000097          	auipc	ra,0x0
    80005d0a:	f40080e7          	jalr	-192(ra) # 80005c46 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005d0e:	0001f797          	auipc	a5,0x1f
    80005d12:	8a278793          	addi	a5,a5,-1886 # 800245b0 <cons>
    80005d16:	0a07a683          	lw	a3,160(a5)
    80005d1a:	0016871b          	addiw	a4,a3,1
    80005d1e:	0007061b          	sext.w	a2,a4
    80005d22:	0ae7a023          	sw	a4,160(a5)
    80005d26:	07f6f693          	andi	a3,a3,127
    80005d2a:	97b6                	add	a5,a5,a3
    80005d2c:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005d30:	47a9                	li	a5,10
    80005d32:	0cf48b63          	beq	s1,a5,80005e08 <consoleintr+0x180>
    80005d36:	4791                	li	a5,4
    80005d38:	0cf48863          	beq	s1,a5,80005e08 <consoleintr+0x180>
    80005d3c:	0001f797          	auipc	a5,0x1f
    80005d40:	90c7a783          	lw	a5,-1780(a5) # 80024648 <cons+0x98>
    80005d44:	9f1d                	subw	a4,a4,a5
    80005d46:	08000793          	li	a5,128
    80005d4a:	f6f71ce3          	bne	a4,a5,80005cc2 <consoleintr+0x3a>
    80005d4e:	a86d                	j	80005e08 <consoleintr+0x180>
    80005d50:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005d52:	0001f717          	auipc	a4,0x1f
    80005d56:	85e70713          	addi	a4,a4,-1954 # 800245b0 <cons>
    80005d5a:	0a072783          	lw	a5,160(a4)
    80005d5e:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005d62:	0001f497          	auipc	s1,0x1f
    80005d66:	84e48493          	addi	s1,s1,-1970 # 800245b0 <cons>
    while(cons.e != cons.w &&
    80005d6a:	4929                	li	s2,10
    80005d6c:	02f70a63          	beq	a4,a5,80005da0 <consoleintr+0x118>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005d70:	37fd                	addiw	a5,a5,-1
    80005d72:	07f7f713          	andi	a4,a5,127
    80005d76:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005d78:	01874703          	lbu	a4,24(a4)
    80005d7c:	03270463          	beq	a4,s2,80005da4 <consoleintr+0x11c>
      cons.e--;
    80005d80:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005d84:	10000513          	li	a0,256
    80005d88:	00000097          	auipc	ra,0x0
    80005d8c:	ebe080e7          	jalr	-322(ra) # 80005c46 <consputc>
    while(cons.e != cons.w &&
    80005d90:	0a04a783          	lw	a5,160(s1)
    80005d94:	09c4a703          	lw	a4,156(s1)
    80005d98:	fcf71ce3          	bne	a4,a5,80005d70 <consoleintr+0xe8>
    80005d9c:	6902                	ld	s2,0(sp)
    80005d9e:	b715                	j	80005cc2 <consoleintr+0x3a>
    80005da0:	6902                	ld	s2,0(sp)
    80005da2:	b705                	j	80005cc2 <consoleintr+0x3a>
    80005da4:	6902                	ld	s2,0(sp)
    80005da6:	bf31                	j	80005cc2 <consoleintr+0x3a>
    if(cons.e != cons.w){
    80005da8:	0001f717          	auipc	a4,0x1f
    80005dac:	80870713          	addi	a4,a4,-2040 # 800245b0 <cons>
    80005db0:	0a072783          	lw	a5,160(a4)
    80005db4:	09c72703          	lw	a4,156(a4)
    80005db8:	f0f705e3          	beq	a4,a5,80005cc2 <consoleintr+0x3a>
      cons.e--;
    80005dbc:	37fd                	addiw	a5,a5,-1
    80005dbe:	0001f717          	auipc	a4,0x1f
    80005dc2:	88f72923          	sw	a5,-1902(a4) # 80024650 <cons+0xa0>
      consputc(BACKSPACE);
    80005dc6:	10000513          	li	a0,256
    80005dca:	00000097          	auipc	ra,0x0
    80005dce:	e7c080e7          	jalr	-388(ra) # 80005c46 <consputc>
    80005dd2:	bdc5                	j	80005cc2 <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005dd4:	ee0487e3          	beqz	s1,80005cc2 <consoleintr+0x3a>
    80005dd8:	b731                	j	80005ce4 <consoleintr+0x5c>
      consputc(c);
    80005dda:	4529                	li	a0,10
    80005ddc:	00000097          	auipc	ra,0x0
    80005de0:	e6a080e7          	jalr	-406(ra) # 80005c46 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005de4:	0001e797          	auipc	a5,0x1e
    80005de8:	7cc78793          	addi	a5,a5,1996 # 800245b0 <cons>
    80005dec:	0a07a703          	lw	a4,160(a5)
    80005df0:	0017069b          	addiw	a3,a4,1
    80005df4:	0006861b          	sext.w	a2,a3
    80005df8:	0ad7a023          	sw	a3,160(a5)
    80005dfc:	07f77713          	andi	a4,a4,127
    80005e00:	97ba                	add	a5,a5,a4
    80005e02:	4729                	li	a4,10
    80005e04:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005e08:	0001f797          	auipc	a5,0x1f
    80005e0c:	84c7a223          	sw	a2,-1980(a5) # 8002464c <cons+0x9c>
        wakeup(&cons.r);
    80005e10:	0001f517          	auipc	a0,0x1f
    80005e14:	83850513          	addi	a0,a0,-1992 # 80024648 <cons+0x98>
    80005e18:	ffffc097          	auipc	ra,0xffffc
    80005e1c:	800080e7          	jalr	-2048(ra) # 80001618 <wakeup>
    80005e20:	b54d                	j	80005cc2 <consoleintr+0x3a>

0000000080005e22 <consoleinit>:

void
consoleinit(void)
{
    80005e22:	1141                	addi	sp,sp,-16
    80005e24:	e406                	sd	ra,8(sp)
    80005e26:	e022                	sd	s0,0(sp)
    80005e28:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005e2a:	00003597          	auipc	a1,0x3
    80005e2e:	8de58593          	addi	a1,a1,-1826 # 80008708 <etext+0x708>
    80005e32:	0001e517          	auipc	a0,0x1e
    80005e36:	77e50513          	addi	a0,a0,1918 # 800245b0 <cons>
    80005e3a:	00000097          	auipc	ra,0x0
    80005e3e:	5c2080e7          	jalr	1474(ra) # 800063fc <initlock>

  uartinit();
    80005e42:	00000097          	auipc	ra,0x0
    80005e46:	354080e7          	jalr	852(ra) # 80006196 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005e4a:	00015797          	auipc	a5,0x15
    80005e4e:	48e78793          	addi	a5,a5,1166 # 8001b2d8 <devsw>
    80005e52:	00000717          	auipc	a4,0x0
    80005e56:	cce70713          	addi	a4,a4,-818 # 80005b20 <consoleread>
    80005e5a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005e5c:	00000717          	auipc	a4,0x0
    80005e60:	c5670713          	addi	a4,a4,-938 # 80005ab2 <consolewrite>
    80005e64:	ef98                	sd	a4,24(a5)
}
    80005e66:	60a2                	ld	ra,8(sp)
    80005e68:	6402                	ld	s0,0(sp)
    80005e6a:	0141                	addi	sp,sp,16
    80005e6c:	8082                	ret

0000000080005e6e <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005e6e:	7179                	addi	sp,sp,-48
    80005e70:	f406                	sd	ra,40(sp)
    80005e72:	f022                	sd	s0,32(sp)
    80005e74:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005e76:	c219                	beqz	a2,80005e7c <printint+0xe>
    80005e78:	08054963          	bltz	a0,80005f0a <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80005e7c:	2501                	sext.w	a0,a0
    80005e7e:	4881                	li	a7,0
    80005e80:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005e84:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005e86:	2581                	sext.w	a1,a1
    80005e88:	00003617          	auipc	a2,0x3
    80005e8c:	9e060613          	addi	a2,a2,-1568 # 80008868 <digits>
    80005e90:	883a                	mv	a6,a4
    80005e92:	2705                	addiw	a4,a4,1
    80005e94:	02b577bb          	remuw	a5,a0,a1
    80005e98:	1782                	slli	a5,a5,0x20
    80005e9a:	9381                	srli	a5,a5,0x20
    80005e9c:	97b2                	add	a5,a5,a2
    80005e9e:	0007c783          	lbu	a5,0(a5)
    80005ea2:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005ea6:	0005079b          	sext.w	a5,a0
    80005eaa:	02b5553b          	divuw	a0,a0,a1
    80005eae:	0685                	addi	a3,a3,1
    80005eb0:	feb7f0e3          	bgeu	a5,a1,80005e90 <printint+0x22>

  if(sign)
    80005eb4:	00088c63          	beqz	a7,80005ecc <printint+0x5e>
    buf[i++] = '-';
    80005eb8:	fe070793          	addi	a5,a4,-32
    80005ebc:	00878733          	add	a4,a5,s0
    80005ec0:	02d00793          	li	a5,45
    80005ec4:	fef70823          	sb	a5,-16(a4)
    80005ec8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005ecc:	02e05b63          	blez	a4,80005f02 <printint+0x94>
    80005ed0:	ec26                	sd	s1,24(sp)
    80005ed2:	e84a                	sd	s2,16(sp)
    80005ed4:	fd040793          	addi	a5,s0,-48
    80005ed8:	00e784b3          	add	s1,a5,a4
    80005edc:	fff78913          	addi	s2,a5,-1
    80005ee0:	993a                	add	s2,s2,a4
    80005ee2:	377d                	addiw	a4,a4,-1
    80005ee4:	1702                	slli	a4,a4,0x20
    80005ee6:	9301                	srli	a4,a4,0x20
    80005ee8:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005eec:	fff4c503          	lbu	a0,-1(s1)
    80005ef0:	00000097          	auipc	ra,0x0
    80005ef4:	d56080e7          	jalr	-682(ra) # 80005c46 <consputc>
  while(--i >= 0)
    80005ef8:	14fd                	addi	s1,s1,-1
    80005efa:	ff2499e3          	bne	s1,s2,80005eec <printint+0x7e>
    80005efe:	64e2                	ld	s1,24(sp)
    80005f00:	6942                	ld	s2,16(sp)
}
    80005f02:	70a2                	ld	ra,40(sp)
    80005f04:	7402                	ld	s0,32(sp)
    80005f06:	6145                	addi	sp,sp,48
    80005f08:	8082                	ret
    x = -xx;
    80005f0a:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005f0e:	4885                	li	a7,1
    x = -xx;
    80005f10:	bf85                	j	80005e80 <printint+0x12>

0000000080005f12 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005f12:	1101                	addi	sp,sp,-32
    80005f14:	ec06                	sd	ra,24(sp)
    80005f16:	e822                	sd	s0,16(sp)
    80005f18:	e426                	sd	s1,8(sp)
    80005f1a:	1000                	addi	s0,sp,32
    80005f1c:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005f1e:	0001e797          	auipc	a5,0x1e
    80005f22:	7407a923          	sw	zero,1874(a5) # 80024670 <pr+0x18>
  printf("panic: ");
    80005f26:	00002517          	auipc	a0,0x2
    80005f2a:	7ea50513          	addi	a0,a0,2026 # 80008710 <etext+0x710>
    80005f2e:	00000097          	auipc	ra,0x0
    80005f32:	02e080e7          	jalr	46(ra) # 80005f5c <printf>
  printf(s);
    80005f36:	8526                	mv	a0,s1
    80005f38:	00000097          	auipc	ra,0x0
    80005f3c:	024080e7          	jalr	36(ra) # 80005f5c <printf>
  printf("\n");
    80005f40:	00002517          	auipc	a0,0x2
    80005f44:	0d850513          	addi	a0,a0,216 # 80008018 <etext+0x18>
    80005f48:	00000097          	auipc	ra,0x0
    80005f4c:	014080e7          	jalr	20(ra) # 80005f5c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005f50:	4785                	li	a5,1
    80005f52:	00005717          	auipc	a4,0x5
    80005f56:	2cf72d23          	sw	a5,730(a4) # 8000b22c <panicked>
  for(;;)
    80005f5a:	a001                	j	80005f5a <panic+0x48>

0000000080005f5c <printf>:
{
    80005f5c:	7131                	addi	sp,sp,-192
    80005f5e:	fc86                	sd	ra,120(sp)
    80005f60:	f8a2                	sd	s0,112(sp)
    80005f62:	e8d2                	sd	s4,80(sp)
    80005f64:	f06a                	sd	s10,32(sp)
    80005f66:	0100                	addi	s0,sp,128
    80005f68:	8a2a                	mv	s4,a0
    80005f6a:	e40c                	sd	a1,8(s0)
    80005f6c:	e810                	sd	a2,16(s0)
    80005f6e:	ec14                	sd	a3,24(s0)
    80005f70:	f018                	sd	a4,32(s0)
    80005f72:	f41c                	sd	a5,40(s0)
    80005f74:	03043823          	sd	a6,48(s0)
    80005f78:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005f7c:	0001ed17          	auipc	s10,0x1e
    80005f80:	6f4d2d03          	lw	s10,1780(s10) # 80024670 <pr+0x18>
  if(locking)
    80005f84:	040d1463          	bnez	s10,80005fcc <printf+0x70>
  if (fmt == 0)
    80005f88:	040a0b63          	beqz	s4,80005fde <printf+0x82>
  va_start(ap, fmt);
    80005f8c:	00840793          	addi	a5,s0,8
    80005f90:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f94:	000a4503          	lbu	a0,0(s4)
    80005f98:	18050b63          	beqz	a0,8000612e <printf+0x1d2>
    80005f9c:	f4a6                	sd	s1,104(sp)
    80005f9e:	f0ca                	sd	s2,96(sp)
    80005fa0:	ecce                	sd	s3,88(sp)
    80005fa2:	e4d6                	sd	s5,72(sp)
    80005fa4:	e0da                	sd	s6,64(sp)
    80005fa6:	fc5e                	sd	s7,56(sp)
    80005fa8:	f862                	sd	s8,48(sp)
    80005faa:	f466                	sd	s9,40(sp)
    80005fac:	ec6e                	sd	s11,24(sp)
    80005fae:	4981                	li	s3,0
    if(c != '%'){
    80005fb0:	02500b13          	li	s6,37
    switch(c){
    80005fb4:	07000b93          	li	s7,112
  consputc('x');
    80005fb8:	4cc1                	li	s9,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005fba:	00003a97          	auipc	s5,0x3
    80005fbe:	8aea8a93          	addi	s5,s5,-1874 # 80008868 <digits>
    switch(c){
    80005fc2:	07300c13          	li	s8,115
    80005fc6:	06400d93          	li	s11,100
    80005fca:	a0b1                	j	80006016 <printf+0xba>
    acquire(&pr.lock);
    80005fcc:	0001e517          	auipc	a0,0x1e
    80005fd0:	68c50513          	addi	a0,a0,1676 # 80024658 <pr>
    80005fd4:	00000097          	auipc	ra,0x0
    80005fd8:	4b8080e7          	jalr	1208(ra) # 8000648c <acquire>
    80005fdc:	b775                	j	80005f88 <printf+0x2c>
    80005fde:	f4a6                	sd	s1,104(sp)
    80005fe0:	f0ca                	sd	s2,96(sp)
    80005fe2:	ecce                	sd	s3,88(sp)
    80005fe4:	e4d6                	sd	s5,72(sp)
    80005fe6:	e0da                	sd	s6,64(sp)
    80005fe8:	fc5e                	sd	s7,56(sp)
    80005fea:	f862                	sd	s8,48(sp)
    80005fec:	f466                	sd	s9,40(sp)
    80005fee:	ec6e                	sd	s11,24(sp)
    panic("null fmt");
    80005ff0:	00002517          	auipc	a0,0x2
    80005ff4:	73050513          	addi	a0,a0,1840 # 80008720 <etext+0x720>
    80005ff8:	00000097          	auipc	ra,0x0
    80005ffc:	f1a080e7          	jalr	-230(ra) # 80005f12 <panic>
      consputc(c);
    80006000:	00000097          	auipc	ra,0x0
    80006004:	c46080e7          	jalr	-954(ra) # 80005c46 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006008:	2985                	addiw	s3,s3,1
    8000600a:	013a07b3          	add	a5,s4,s3
    8000600e:	0007c503          	lbu	a0,0(a5)
    80006012:	10050563          	beqz	a0,8000611c <printf+0x1c0>
    if(c != '%'){
    80006016:	ff6515e3          	bne	a0,s6,80006000 <printf+0xa4>
    c = fmt[++i] & 0xff;
    8000601a:	2985                	addiw	s3,s3,1
    8000601c:	013a07b3          	add	a5,s4,s3
    80006020:	0007c783          	lbu	a5,0(a5)
    80006024:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80006028:	10078b63          	beqz	a5,8000613e <printf+0x1e2>
    switch(c){
    8000602c:	05778a63          	beq	a5,s7,80006080 <printf+0x124>
    80006030:	02fbf663          	bgeu	s7,a5,8000605c <printf+0x100>
    80006034:	09878863          	beq	a5,s8,800060c4 <printf+0x168>
    80006038:	07800713          	li	a4,120
    8000603c:	0ce79563          	bne	a5,a4,80006106 <printf+0x1aa>
      printint(va_arg(ap, int), 16, 1);
    80006040:	f8843783          	ld	a5,-120(s0)
    80006044:	00878713          	addi	a4,a5,8
    80006048:	f8e43423          	sd	a4,-120(s0)
    8000604c:	4605                	li	a2,1
    8000604e:	85e6                	mv	a1,s9
    80006050:	4388                	lw	a0,0(a5)
    80006052:	00000097          	auipc	ra,0x0
    80006056:	e1c080e7          	jalr	-484(ra) # 80005e6e <printint>
      break;
    8000605a:	b77d                	j	80006008 <printf+0xac>
    switch(c){
    8000605c:	09678f63          	beq	a5,s6,800060fa <printf+0x19e>
    80006060:	0bb79363          	bne	a5,s11,80006106 <printf+0x1aa>
      printint(va_arg(ap, int), 10, 1);
    80006064:	f8843783          	ld	a5,-120(s0)
    80006068:	00878713          	addi	a4,a5,8
    8000606c:	f8e43423          	sd	a4,-120(s0)
    80006070:	4605                	li	a2,1
    80006072:	45a9                	li	a1,10
    80006074:	4388                	lw	a0,0(a5)
    80006076:	00000097          	auipc	ra,0x0
    8000607a:	df8080e7          	jalr	-520(ra) # 80005e6e <printint>
      break;
    8000607e:	b769                	j	80006008 <printf+0xac>
      printptr(va_arg(ap, uint64));
    80006080:	f8843783          	ld	a5,-120(s0)
    80006084:	00878713          	addi	a4,a5,8
    80006088:	f8e43423          	sd	a4,-120(s0)
    8000608c:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80006090:	03000513          	li	a0,48
    80006094:	00000097          	auipc	ra,0x0
    80006098:	bb2080e7          	jalr	-1102(ra) # 80005c46 <consputc>
  consputc('x');
    8000609c:	07800513          	li	a0,120
    800060a0:	00000097          	auipc	ra,0x0
    800060a4:	ba6080e7          	jalr	-1114(ra) # 80005c46 <consputc>
    800060a8:	84e6                	mv	s1,s9
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800060aa:	03c95793          	srli	a5,s2,0x3c
    800060ae:	97d6                	add	a5,a5,s5
    800060b0:	0007c503          	lbu	a0,0(a5)
    800060b4:	00000097          	auipc	ra,0x0
    800060b8:	b92080e7          	jalr	-1134(ra) # 80005c46 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800060bc:	0912                	slli	s2,s2,0x4
    800060be:	34fd                	addiw	s1,s1,-1
    800060c0:	f4ed                	bnez	s1,800060aa <printf+0x14e>
    800060c2:	b799                	j	80006008 <printf+0xac>
      if((s = va_arg(ap, char*)) == 0)
    800060c4:	f8843783          	ld	a5,-120(s0)
    800060c8:	00878713          	addi	a4,a5,8
    800060cc:	f8e43423          	sd	a4,-120(s0)
    800060d0:	6384                	ld	s1,0(a5)
    800060d2:	cc89                	beqz	s1,800060ec <printf+0x190>
      for(; *s; s++)
    800060d4:	0004c503          	lbu	a0,0(s1)
    800060d8:	d905                	beqz	a0,80006008 <printf+0xac>
        consputc(*s);
    800060da:	00000097          	auipc	ra,0x0
    800060de:	b6c080e7          	jalr	-1172(ra) # 80005c46 <consputc>
      for(; *s; s++)
    800060e2:	0485                	addi	s1,s1,1
    800060e4:	0004c503          	lbu	a0,0(s1)
    800060e8:	f96d                	bnez	a0,800060da <printf+0x17e>
    800060ea:	bf39                	j	80006008 <printf+0xac>
        s = "(null)";
    800060ec:	00002497          	auipc	s1,0x2
    800060f0:	62c48493          	addi	s1,s1,1580 # 80008718 <etext+0x718>
      for(; *s; s++)
    800060f4:	02800513          	li	a0,40
    800060f8:	b7cd                	j	800060da <printf+0x17e>
      consputc('%');
    800060fa:	855a                	mv	a0,s6
    800060fc:	00000097          	auipc	ra,0x0
    80006100:	b4a080e7          	jalr	-1206(ra) # 80005c46 <consputc>
      break;
    80006104:	b711                	j	80006008 <printf+0xac>
      consputc('%');
    80006106:	855a                	mv	a0,s6
    80006108:	00000097          	auipc	ra,0x0
    8000610c:	b3e080e7          	jalr	-1218(ra) # 80005c46 <consputc>
      consputc(c);
    80006110:	8526                	mv	a0,s1
    80006112:	00000097          	auipc	ra,0x0
    80006116:	b34080e7          	jalr	-1228(ra) # 80005c46 <consputc>
      break;
    8000611a:	b5fd                	j	80006008 <printf+0xac>
    8000611c:	74a6                	ld	s1,104(sp)
    8000611e:	7906                	ld	s2,96(sp)
    80006120:	69e6                	ld	s3,88(sp)
    80006122:	6aa6                	ld	s5,72(sp)
    80006124:	6b06                	ld	s6,64(sp)
    80006126:	7be2                	ld	s7,56(sp)
    80006128:	7c42                	ld	s8,48(sp)
    8000612a:	7ca2                	ld	s9,40(sp)
    8000612c:	6de2                	ld	s11,24(sp)
  if(locking)
    8000612e:	020d1263          	bnez	s10,80006152 <printf+0x1f6>
}
    80006132:	70e6                	ld	ra,120(sp)
    80006134:	7446                	ld	s0,112(sp)
    80006136:	6a46                	ld	s4,80(sp)
    80006138:	7d02                	ld	s10,32(sp)
    8000613a:	6129                	addi	sp,sp,192
    8000613c:	8082                	ret
    8000613e:	74a6                	ld	s1,104(sp)
    80006140:	7906                	ld	s2,96(sp)
    80006142:	69e6                	ld	s3,88(sp)
    80006144:	6aa6                	ld	s5,72(sp)
    80006146:	6b06                	ld	s6,64(sp)
    80006148:	7be2                	ld	s7,56(sp)
    8000614a:	7c42                	ld	s8,48(sp)
    8000614c:	7ca2                	ld	s9,40(sp)
    8000614e:	6de2                	ld	s11,24(sp)
    80006150:	bff9                	j	8000612e <printf+0x1d2>
    release(&pr.lock);
    80006152:	0001e517          	auipc	a0,0x1e
    80006156:	50650513          	addi	a0,a0,1286 # 80024658 <pr>
    8000615a:	00000097          	auipc	ra,0x0
    8000615e:	3e6080e7          	jalr	998(ra) # 80006540 <release>
}
    80006162:	bfc1                	j	80006132 <printf+0x1d6>

0000000080006164 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006164:	1101                	addi	sp,sp,-32
    80006166:	ec06                	sd	ra,24(sp)
    80006168:	e822                	sd	s0,16(sp)
    8000616a:	e426                	sd	s1,8(sp)
    8000616c:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000616e:	0001e497          	auipc	s1,0x1e
    80006172:	4ea48493          	addi	s1,s1,1258 # 80024658 <pr>
    80006176:	00002597          	auipc	a1,0x2
    8000617a:	5ba58593          	addi	a1,a1,1466 # 80008730 <etext+0x730>
    8000617e:	8526                	mv	a0,s1
    80006180:	00000097          	auipc	ra,0x0
    80006184:	27c080e7          	jalr	636(ra) # 800063fc <initlock>
  pr.locking = 1;
    80006188:	4785                	li	a5,1
    8000618a:	cc9c                	sw	a5,24(s1)
}
    8000618c:	60e2                	ld	ra,24(sp)
    8000618e:	6442                	ld	s0,16(sp)
    80006190:	64a2                	ld	s1,8(sp)
    80006192:	6105                	addi	sp,sp,32
    80006194:	8082                	ret

0000000080006196 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006196:	1141                	addi	sp,sp,-16
    80006198:	e406                	sd	ra,8(sp)
    8000619a:	e022                	sd	s0,0(sp)
    8000619c:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000619e:	100007b7          	lui	a5,0x10000
    800061a2:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800061a6:	10000737          	lui	a4,0x10000
    800061aa:	f8000693          	li	a3,-128
    800061ae:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800061b2:	468d                	li	a3,3
    800061b4:	10000637          	lui	a2,0x10000
    800061b8:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800061bc:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800061c0:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800061c4:	10000737          	lui	a4,0x10000
    800061c8:	461d                	li	a2,7
    800061ca:	00c70123          	sb	a2,2(a4) # 10000002 <_entry-0x6ffffffe>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800061ce:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    800061d2:	00002597          	auipc	a1,0x2
    800061d6:	56658593          	addi	a1,a1,1382 # 80008738 <etext+0x738>
    800061da:	0001e517          	auipc	a0,0x1e
    800061de:	49e50513          	addi	a0,a0,1182 # 80024678 <uart_tx_lock>
    800061e2:	00000097          	auipc	ra,0x0
    800061e6:	21a080e7          	jalr	538(ra) # 800063fc <initlock>
}
    800061ea:	60a2                	ld	ra,8(sp)
    800061ec:	6402                	ld	s0,0(sp)
    800061ee:	0141                	addi	sp,sp,16
    800061f0:	8082                	ret

00000000800061f2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800061f2:	1101                	addi	sp,sp,-32
    800061f4:	ec06                	sd	ra,24(sp)
    800061f6:	e822                	sd	s0,16(sp)
    800061f8:	e426                	sd	s1,8(sp)
    800061fa:	1000                	addi	s0,sp,32
    800061fc:	84aa                	mv	s1,a0
  push_off();
    800061fe:	00000097          	auipc	ra,0x0
    80006202:	242080e7          	jalr	578(ra) # 80006440 <push_off>

  if(panicked){
    80006206:	00005797          	auipc	a5,0x5
    8000620a:	0267a783          	lw	a5,38(a5) # 8000b22c <panicked>
    8000620e:	eb85                	bnez	a5,8000623e <uartputc_sync+0x4c>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006210:	10000737          	lui	a4,0x10000
    80006214:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80006216:	00074783          	lbu	a5,0(a4)
    8000621a:	0207f793          	andi	a5,a5,32
    8000621e:	dfe5                	beqz	a5,80006216 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006220:	0ff4f513          	zext.b	a0,s1
    80006224:	100007b7          	lui	a5,0x10000
    80006228:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000622c:	00000097          	auipc	ra,0x0
    80006230:	2b4080e7          	jalr	692(ra) # 800064e0 <pop_off>
}
    80006234:	60e2                	ld	ra,24(sp)
    80006236:	6442                	ld	s0,16(sp)
    80006238:	64a2                	ld	s1,8(sp)
    8000623a:	6105                	addi	sp,sp,32
    8000623c:	8082                	ret
    for(;;)
    8000623e:	a001                	j	8000623e <uartputc_sync+0x4c>

0000000080006240 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006240:	00005797          	auipc	a5,0x5
    80006244:	ff07b783          	ld	a5,-16(a5) # 8000b230 <uart_tx_r>
    80006248:	00005717          	auipc	a4,0x5
    8000624c:	ff073703          	ld	a4,-16(a4) # 8000b238 <uart_tx_w>
    80006250:	06f70f63          	beq	a4,a5,800062ce <uartstart+0x8e>
{
    80006254:	7139                	addi	sp,sp,-64
    80006256:	fc06                	sd	ra,56(sp)
    80006258:	f822                	sd	s0,48(sp)
    8000625a:	f426                	sd	s1,40(sp)
    8000625c:	f04a                	sd	s2,32(sp)
    8000625e:	ec4e                	sd	s3,24(sp)
    80006260:	e852                	sd	s4,16(sp)
    80006262:	e456                	sd	s5,8(sp)
    80006264:	e05a                	sd	s6,0(sp)
    80006266:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006268:	10000937          	lui	s2,0x10000
    8000626c:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000626e:	0001ea97          	auipc	s5,0x1e
    80006272:	40aa8a93          	addi	s5,s5,1034 # 80024678 <uart_tx_lock>
    uart_tx_r += 1;
    80006276:	00005497          	auipc	s1,0x5
    8000627a:	fba48493          	addi	s1,s1,-70 # 8000b230 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    8000627e:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80006282:	00005997          	auipc	s3,0x5
    80006286:	fb698993          	addi	s3,s3,-74 # 8000b238 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000628a:	00094703          	lbu	a4,0(s2)
    8000628e:	02077713          	andi	a4,a4,32
    80006292:	c705                	beqz	a4,800062ba <uartstart+0x7a>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006294:	01f7f713          	andi	a4,a5,31
    80006298:	9756                	add	a4,a4,s5
    8000629a:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    8000629e:	0785                	addi	a5,a5,1
    800062a0:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    800062a2:	8526                	mv	a0,s1
    800062a4:	ffffb097          	auipc	ra,0xffffb
    800062a8:	374080e7          	jalr	884(ra) # 80001618 <wakeup>
    WriteReg(THR, c);
    800062ac:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    800062b0:	609c                	ld	a5,0(s1)
    800062b2:	0009b703          	ld	a4,0(s3)
    800062b6:	fcf71ae3          	bne	a4,a5,8000628a <uartstart+0x4a>
  }
}
    800062ba:	70e2                	ld	ra,56(sp)
    800062bc:	7442                	ld	s0,48(sp)
    800062be:	74a2                	ld	s1,40(sp)
    800062c0:	7902                	ld	s2,32(sp)
    800062c2:	69e2                	ld	s3,24(sp)
    800062c4:	6a42                	ld	s4,16(sp)
    800062c6:	6aa2                	ld	s5,8(sp)
    800062c8:	6b02                	ld	s6,0(sp)
    800062ca:	6121                	addi	sp,sp,64
    800062cc:	8082                	ret
    800062ce:	8082                	ret

00000000800062d0 <uartputc>:
{
    800062d0:	7179                	addi	sp,sp,-48
    800062d2:	f406                	sd	ra,40(sp)
    800062d4:	f022                	sd	s0,32(sp)
    800062d6:	ec26                	sd	s1,24(sp)
    800062d8:	e84a                	sd	s2,16(sp)
    800062da:	e44e                	sd	s3,8(sp)
    800062dc:	e052                	sd	s4,0(sp)
    800062de:	1800                	addi	s0,sp,48
    800062e0:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800062e2:	0001e517          	auipc	a0,0x1e
    800062e6:	39650513          	addi	a0,a0,918 # 80024678 <uart_tx_lock>
    800062ea:	00000097          	auipc	ra,0x0
    800062ee:	1a2080e7          	jalr	418(ra) # 8000648c <acquire>
  if(panicked){
    800062f2:	00005797          	auipc	a5,0x5
    800062f6:	f3a7a783          	lw	a5,-198(a5) # 8000b22c <panicked>
    800062fa:	e7c9                	bnez	a5,80006384 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800062fc:	00005717          	auipc	a4,0x5
    80006300:	f3c73703          	ld	a4,-196(a4) # 8000b238 <uart_tx_w>
    80006304:	00005797          	auipc	a5,0x5
    80006308:	f2c7b783          	ld	a5,-212(a5) # 8000b230 <uart_tx_r>
    8000630c:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80006310:	0001e997          	auipc	s3,0x1e
    80006314:	36898993          	addi	s3,s3,872 # 80024678 <uart_tx_lock>
    80006318:	00005497          	auipc	s1,0x5
    8000631c:	f1848493          	addi	s1,s1,-232 # 8000b230 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006320:	00005917          	auipc	s2,0x5
    80006324:	f1890913          	addi	s2,s2,-232 # 8000b238 <uart_tx_w>
    80006328:	00e79f63          	bne	a5,a4,80006346 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    8000632c:	85ce                	mv	a1,s3
    8000632e:	8526                	mv	a0,s1
    80006330:	ffffb097          	auipc	ra,0xffffb
    80006334:	284080e7          	jalr	644(ra) # 800015b4 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006338:	00093703          	ld	a4,0(s2)
    8000633c:	609c                	ld	a5,0(s1)
    8000633e:	02078793          	addi	a5,a5,32
    80006342:	fee785e3          	beq	a5,a4,8000632c <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006346:	0001e497          	auipc	s1,0x1e
    8000634a:	33248493          	addi	s1,s1,818 # 80024678 <uart_tx_lock>
    8000634e:	01f77793          	andi	a5,a4,31
    80006352:	97a6                	add	a5,a5,s1
    80006354:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80006358:	0705                	addi	a4,a4,1
    8000635a:	00005797          	auipc	a5,0x5
    8000635e:	ece7bf23          	sd	a4,-290(a5) # 8000b238 <uart_tx_w>
  uartstart();
    80006362:	00000097          	auipc	ra,0x0
    80006366:	ede080e7          	jalr	-290(ra) # 80006240 <uartstart>
  release(&uart_tx_lock);
    8000636a:	8526                	mv	a0,s1
    8000636c:	00000097          	auipc	ra,0x0
    80006370:	1d4080e7          	jalr	468(ra) # 80006540 <release>
}
    80006374:	70a2                	ld	ra,40(sp)
    80006376:	7402                	ld	s0,32(sp)
    80006378:	64e2                	ld	s1,24(sp)
    8000637a:	6942                	ld	s2,16(sp)
    8000637c:	69a2                	ld	s3,8(sp)
    8000637e:	6a02                	ld	s4,0(sp)
    80006380:	6145                	addi	sp,sp,48
    80006382:	8082                	ret
    for(;;)
    80006384:	a001                	j	80006384 <uartputc+0xb4>

0000000080006386 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006386:	1141                	addi	sp,sp,-16
    80006388:	e422                	sd	s0,8(sp)
    8000638a:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000638c:	100007b7          	lui	a5,0x10000
    80006390:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80006392:	0007c783          	lbu	a5,0(a5)
    80006396:	8b85                	andi	a5,a5,1
    80006398:	cb81                	beqz	a5,800063a8 <uartgetc+0x22>
    // input data is ready.
    return ReadReg(RHR);
    8000639a:	100007b7          	lui	a5,0x10000
    8000639e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800063a2:	6422                	ld	s0,8(sp)
    800063a4:	0141                	addi	sp,sp,16
    800063a6:	8082                	ret
    return -1;
    800063a8:	557d                	li	a0,-1
    800063aa:	bfe5                	j	800063a2 <uartgetc+0x1c>

00000000800063ac <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800063ac:	1101                	addi	sp,sp,-32
    800063ae:	ec06                	sd	ra,24(sp)
    800063b0:	e822                	sd	s0,16(sp)
    800063b2:	e426                	sd	s1,8(sp)
    800063b4:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800063b6:	54fd                	li	s1,-1
    800063b8:	a029                	j	800063c2 <uartintr+0x16>
      break;
    consoleintr(c);
    800063ba:	00000097          	auipc	ra,0x0
    800063be:	8ce080e7          	jalr	-1842(ra) # 80005c88 <consoleintr>
    int c = uartgetc();
    800063c2:	00000097          	auipc	ra,0x0
    800063c6:	fc4080e7          	jalr	-60(ra) # 80006386 <uartgetc>
    if(c == -1)
    800063ca:	fe9518e3          	bne	a0,s1,800063ba <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800063ce:	0001e497          	auipc	s1,0x1e
    800063d2:	2aa48493          	addi	s1,s1,682 # 80024678 <uart_tx_lock>
    800063d6:	8526                	mv	a0,s1
    800063d8:	00000097          	auipc	ra,0x0
    800063dc:	0b4080e7          	jalr	180(ra) # 8000648c <acquire>
  uartstart();
    800063e0:	00000097          	auipc	ra,0x0
    800063e4:	e60080e7          	jalr	-416(ra) # 80006240 <uartstart>
  release(&uart_tx_lock);
    800063e8:	8526                	mv	a0,s1
    800063ea:	00000097          	auipc	ra,0x0
    800063ee:	156080e7          	jalr	342(ra) # 80006540 <release>
}
    800063f2:	60e2                	ld	ra,24(sp)
    800063f4:	6442                	ld	s0,16(sp)
    800063f6:	64a2                	ld	s1,8(sp)
    800063f8:	6105                	addi	sp,sp,32
    800063fa:	8082                	ret

00000000800063fc <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800063fc:	1141                	addi	sp,sp,-16
    800063fe:	e422                	sd	s0,8(sp)
    80006400:	0800                	addi	s0,sp,16
  lk->name = name;
    80006402:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006404:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006408:	00053823          	sd	zero,16(a0)
}
    8000640c:	6422                	ld	s0,8(sp)
    8000640e:	0141                	addi	sp,sp,16
    80006410:	8082                	ret

0000000080006412 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006412:	411c                	lw	a5,0(a0)
    80006414:	e399                	bnez	a5,8000641a <holding+0x8>
    80006416:	4501                	li	a0,0
  return r;
}
    80006418:	8082                	ret
{
    8000641a:	1101                	addi	sp,sp,-32
    8000641c:	ec06                	sd	ra,24(sp)
    8000641e:	e822                	sd	s0,16(sp)
    80006420:	e426                	sd	s1,8(sp)
    80006422:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006424:	6904                	ld	s1,16(a0)
    80006426:	ffffb097          	auipc	ra,0xffffb
    8000642a:	ac4080e7          	jalr	-1340(ra) # 80000eea <mycpu>
    8000642e:	40a48533          	sub	a0,s1,a0
    80006432:	00153513          	seqz	a0,a0
}
    80006436:	60e2                	ld	ra,24(sp)
    80006438:	6442                	ld	s0,16(sp)
    8000643a:	64a2                	ld	s1,8(sp)
    8000643c:	6105                	addi	sp,sp,32
    8000643e:	8082                	ret

0000000080006440 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006440:	1101                	addi	sp,sp,-32
    80006442:	ec06                	sd	ra,24(sp)
    80006444:	e822                	sd	s0,16(sp)
    80006446:	e426                	sd	s1,8(sp)
    80006448:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000644a:	100024f3          	csrr	s1,sstatus
    8000644e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006452:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006454:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006458:	ffffb097          	auipc	ra,0xffffb
    8000645c:	a92080e7          	jalr	-1390(ra) # 80000eea <mycpu>
    80006460:	5d3c                	lw	a5,120(a0)
    80006462:	cf89                	beqz	a5,8000647c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006464:	ffffb097          	auipc	ra,0xffffb
    80006468:	a86080e7          	jalr	-1402(ra) # 80000eea <mycpu>
    8000646c:	5d3c                	lw	a5,120(a0)
    8000646e:	2785                	addiw	a5,a5,1
    80006470:	dd3c                	sw	a5,120(a0)
}
    80006472:	60e2                	ld	ra,24(sp)
    80006474:	6442                	ld	s0,16(sp)
    80006476:	64a2                	ld	s1,8(sp)
    80006478:	6105                	addi	sp,sp,32
    8000647a:	8082                	ret
    mycpu()->intena = old;
    8000647c:	ffffb097          	auipc	ra,0xffffb
    80006480:	a6e080e7          	jalr	-1426(ra) # 80000eea <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006484:	8085                	srli	s1,s1,0x1
    80006486:	8885                	andi	s1,s1,1
    80006488:	dd64                	sw	s1,124(a0)
    8000648a:	bfe9                	j	80006464 <push_off+0x24>

000000008000648c <acquire>:
{
    8000648c:	1101                	addi	sp,sp,-32
    8000648e:	ec06                	sd	ra,24(sp)
    80006490:	e822                	sd	s0,16(sp)
    80006492:	e426                	sd	s1,8(sp)
    80006494:	1000                	addi	s0,sp,32
    80006496:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006498:	00000097          	auipc	ra,0x0
    8000649c:	fa8080e7          	jalr	-88(ra) # 80006440 <push_off>
  if(holding(lk))
    800064a0:	8526                	mv	a0,s1
    800064a2:	00000097          	auipc	ra,0x0
    800064a6:	f70080e7          	jalr	-144(ra) # 80006412 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800064aa:	4705                	li	a4,1
  if(holding(lk))
    800064ac:	e115                	bnez	a0,800064d0 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800064ae:	87ba                	mv	a5,a4
    800064b0:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800064b4:	2781                	sext.w	a5,a5
    800064b6:	ffe5                	bnez	a5,800064ae <acquire+0x22>
  __sync_synchronize();
    800064b8:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    800064bc:	ffffb097          	auipc	ra,0xffffb
    800064c0:	a2e080e7          	jalr	-1490(ra) # 80000eea <mycpu>
    800064c4:	e888                	sd	a0,16(s1)
}
    800064c6:	60e2                	ld	ra,24(sp)
    800064c8:	6442                	ld	s0,16(sp)
    800064ca:	64a2                	ld	s1,8(sp)
    800064cc:	6105                	addi	sp,sp,32
    800064ce:	8082                	ret
    panic("acquire");
    800064d0:	00002517          	auipc	a0,0x2
    800064d4:	27050513          	addi	a0,a0,624 # 80008740 <etext+0x740>
    800064d8:	00000097          	auipc	ra,0x0
    800064dc:	a3a080e7          	jalr	-1478(ra) # 80005f12 <panic>

00000000800064e0 <pop_off>:

void
pop_off(void)
{
    800064e0:	1141                	addi	sp,sp,-16
    800064e2:	e406                	sd	ra,8(sp)
    800064e4:	e022                	sd	s0,0(sp)
    800064e6:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800064e8:	ffffb097          	auipc	ra,0xffffb
    800064ec:	a02080e7          	jalr	-1534(ra) # 80000eea <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800064f0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800064f4:	8b89                	andi	a5,a5,2
  if(intr_get())
    800064f6:	e78d                	bnez	a5,80006520 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800064f8:	5d3c                	lw	a5,120(a0)
    800064fa:	02f05b63          	blez	a5,80006530 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800064fe:	37fd                	addiw	a5,a5,-1
    80006500:	0007871b          	sext.w	a4,a5
    80006504:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006506:	eb09                	bnez	a4,80006518 <pop_off+0x38>
    80006508:	5d7c                	lw	a5,124(a0)
    8000650a:	c799                	beqz	a5,80006518 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000650c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006510:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006514:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006518:	60a2                	ld	ra,8(sp)
    8000651a:	6402                	ld	s0,0(sp)
    8000651c:	0141                	addi	sp,sp,16
    8000651e:	8082                	ret
    panic("pop_off - interruptible");
    80006520:	00002517          	auipc	a0,0x2
    80006524:	22850513          	addi	a0,a0,552 # 80008748 <etext+0x748>
    80006528:	00000097          	auipc	ra,0x0
    8000652c:	9ea080e7          	jalr	-1558(ra) # 80005f12 <panic>
    panic("pop_off");
    80006530:	00002517          	auipc	a0,0x2
    80006534:	23050513          	addi	a0,a0,560 # 80008760 <etext+0x760>
    80006538:	00000097          	auipc	ra,0x0
    8000653c:	9da080e7          	jalr	-1574(ra) # 80005f12 <panic>

0000000080006540 <release>:
{
    80006540:	1101                	addi	sp,sp,-32
    80006542:	ec06                	sd	ra,24(sp)
    80006544:	e822                	sd	s0,16(sp)
    80006546:	e426                	sd	s1,8(sp)
    80006548:	1000                	addi	s0,sp,32
    8000654a:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000654c:	00000097          	auipc	ra,0x0
    80006550:	ec6080e7          	jalr	-314(ra) # 80006412 <holding>
    80006554:	c115                	beqz	a0,80006578 <release+0x38>
  lk->cpu = 0;
    80006556:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000655a:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    8000655e:	0310000f          	fence	rw,w
    80006562:	0004a023          	sw	zero,0(s1)
  pop_off();
    80006566:	00000097          	auipc	ra,0x0
    8000656a:	f7a080e7          	jalr	-134(ra) # 800064e0 <pop_off>
}
    8000656e:	60e2                	ld	ra,24(sp)
    80006570:	6442                	ld	s0,16(sp)
    80006572:	64a2                	ld	s1,8(sp)
    80006574:	6105                	addi	sp,sp,32
    80006576:	8082                	ret
    panic("release");
    80006578:	00002517          	auipc	a0,0x2
    8000657c:	1f050513          	addi	a0,a0,496 # 80008768 <etext+0x768>
    80006580:	00000097          	auipc	ra,0x0
    80006584:	992080e7          	jalr	-1646(ra) # 80005f12 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
