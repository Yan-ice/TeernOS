
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/clone:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0f5                	j	10ee <__start_main>

0000000000001004 <child_func>:
#include "unistd.h"

size_t stack[1024] = {0};
static int child_pid;

static int child_func(void){
    1004:	1141                	addi	sp,sp,-16
    printf("  Child says successfully!\n");
    1006:	00001517          	auipc	a0,0x1
    100a:	f2a50513          	addi	a0,a0,-214 # 1f30 <__clone+0x2e>
static int child_func(void){
    100e:	e406                	sd	ra,8(sp)
    printf("  Child says successfully!\n");
    1010:	338000ef          	jal	ra,1348 <printf>
    return 0;
}
    1014:	60a2                	ld	ra,8(sp)
    1016:	4501                	li	a0,0
    1018:	0141                	addi	sp,sp,16
    101a:	8082                	ret

000000000000101c <test_clone>:

void test_clone(void){
    101c:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    101e:	00001517          	auipc	a0,0x1
    1022:	f3250513          	addi	a0,a0,-206 # 1f50 <__clone+0x4e>
void test_clone(void){
    1026:	ec06                	sd	ra,24(sp)
    1028:	e822                	sd	s0,16(sp)
    TEST_START(__func__);
    102a:	2fc000ef          	jal	ra,1326 <puts>
    102e:	00003517          	auipc	a0,0x3
    1032:	fe250513          	addi	a0,a0,-30 # 4010 <__func__.1171>
    1036:	2f0000ef          	jal	ra,1326 <puts>
    103a:	00001517          	auipc	a0,0x1
    103e:	f2e50513          	addi	a0,a0,-210 # 1f68 <__clone+0x66>
    1042:	2e4000ef          	jal	ra,1326 <puts>
    int wstatus;
    child_pid = clone(child_func, NULL, stack, 1024, SIGCHLD);
    1046:	4745                	li	a4,17
    1048:	40000693          	li	a3,1024
    104c:	00001617          	auipc	a2,0x1
    1050:	fbc60613          	addi	a2,a2,-68 # 2008 <stack>
    1054:	4581                	li	a1,0
    1056:	00000517          	auipc	a0,0x0
    105a:	fae50513          	addi	a0,a0,-82 # 1004 <child_func>
    105e:	4ab000ef          	jal	ra,1d08 <clone>
    1062:	00003417          	auipc	s0,0x3
    1066:	fa640413          	addi	s0,s0,-90 # 4008 <child_pid>
    106a:	c008                	sw	a0,0(s0)
    assert(child_pid != -1);
    106c:	57fd                	li	a5,-1
    106e:	04f50863          	beq	a0,a5,10be <test_clone+0xa2>
    if (child_pid == 0){
    1072:	e90d                	bnez	a0,10a4 <test_clone+0x88>
	exit(0);
    1074:	4a7000ef          	jal	ra,1d1a <exit>
	    printf("clone process successfully.\npid:%d\n", child_pid);
	else
	    printf("clone process error.\n");
    }

    TEST_END(__func__);
    1078:	00001517          	auipc	a0,0x1
    107c:	f6050513          	addi	a0,a0,-160 # 1fd8 <__clone+0xd6>
    1080:	2a6000ef          	jal	ra,1326 <puts>
    1084:	00003517          	auipc	a0,0x3
    1088:	f8c50513          	addi	a0,a0,-116 # 4010 <__func__.1171>
    108c:	29a000ef          	jal	ra,1326 <puts>
    1090:	00001517          	auipc	a0,0x1
    1094:	ed850513          	addi	a0,a0,-296 # 1f68 <__clone+0x66>
    1098:	28e000ef          	jal	ra,1326 <puts>
}
    109c:	60e2                	ld	ra,24(sp)
    109e:	6442                	ld	s0,16(sp)
    10a0:	6105                	addi	sp,sp,32
    10a2:	8082                	ret
	if(wait(&wstatus) == child_pid)
    10a4:	0068                	addi	a0,sp,12
    10a6:	539000ef          	jal	ra,1dde <wait>
    10aa:	401c                	lw	a5,0(s0)
    10ac:	02f50163          	beq	a0,a5,10ce <test_clone+0xb2>
	    printf("clone process error.\n");
    10b0:	00001517          	auipc	a0,0x1
    10b4:	f1050513          	addi	a0,a0,-240 # 1fc0 <__clone+0xbe>
    10b8:	290000ef          	jal	ra,1348 <printf>
    10bc:	bf75                	j	1078 <test_clone+0x5c>
    assert(child_pid != -1);
    10be:	00001517          	auipc	a0,0x1
    10c2:	eba50513          	addi	a0,a0,-326 # 1f78 <__clone+0x76>
    10c6:	542000ef          	jal	ra,1608 <panic>
    10ca:	4008                	lw	a0,0(s0)
    10cc:	b75d                	j	1072 <test_clone+0x56>
	    printf("clone process successfully.\npid:%d\n", child_pid);
    10ce:	85aa                	mv	a1,a0
    10d0:	00001517          	auipc	a0,0x1
    10d4:	ec850513          	addi	a0,a0,-312 # 1f98 <__clone+0x96>
    10d8:	270000ef          	jal	ra,1348 <printf>
    10dc:	bf71                	j	1078 <test_clone+0x5c>

00000000000010de <main>:

int main(void){
    10de:	1141                	addi	sp,sp,-16
    10e0:	e406                	sd	ra,8(sp)
    test_clone();
    10e2:	f3bff0ef          	jal	ra,101c <test_clone>
    return 0;
}
    10e6:	60a2                	ld	ra,8(sp)
    10e8:	4501                	li	a0,0
    10ea:	0141                	addi	sp,sp,16
    10ec:	8082                	ret

00000000000010ee <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ee:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10f0:	4108                	lw	a0,0(a0)
{
    10f2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10f4:	05a1                	addi	a1,a1,8
{
    10f6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10f8:	fe7ff0ef          	jal	ra,10de <main>
    10fc:	41f000ef          	jal	ra,1d1a <exit>
	return 0;
}
    1100:	60a2                	ld	ra,8(sp)
    1102:	4501                	li	a0,0
    1104:	0141                	addi	sp,sp,16
    1106:	8082                	ret

0000000000001108 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1108:	7179                	addi	sp,sp,-48
    110a:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    110c:	12054b63          	bltz	a0,1242 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1110:	02b577bb          	remuw	a5,a0,a1
    1114:	00003697          	auipc	a3,0x3
    1118:	f0c68693          	addi	a3,a3,-244 # 4020 <digits>
    buf[16] = 0;
    111c:	00010c23          	sb	zero,24(sp)
    i = 15;
    1120:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1124:	1782                	slli	a5,a5,0x20
    1126:	9381                	srli	a5,a5,0x20
    1128:	97b6                	add	a5,a5,a3
    112a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    112e:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1132:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1136:	16b56263          	bltu	a0,a1,129a <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    113a:	02e8763b          	remuw	a2,a6,a4
    113e:	1602                	slli	a2,a2,0x20
    1140:	9201                	srli	a2,a2,0x20
    1142:	9636                	add	a2,a2,a3
    1144:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1148:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    114c:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1150:	12e86963          	bltu	a6,a4,1282 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1154:	02e5f63b          	remuw	a2,a1,a4
    1158:	1602                	slli	a2,a2,0x20
    115a:	9201                	srli	a2,a2,0x20
    115c:	9636                	add	a2,a2,a3
    115e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1162:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1166:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    116a:	10e5ef63          	bltu	a1,a4,1288 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    116e:	02e8763b          	remuw	a2,a6,a4
    1172:	1602                	slli	a2,a2,0x20
    1174:	9201                	srli	a2,a2,0x20
    1176:	9636                	add	a2,a2,a3
    1178:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    117c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1180:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1184:	10e86563          	bltu	a6,a4,128e <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1188:	02e5f63b          	remuw	a2,a1,a4
    118c:	1602                	slli	a2,a2,0x20
    118e:	9201                	srli	a2,a2,0x20
    1190:	9636                	add	a2,a2,a3
    1192:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1196:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119a:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    119e:	0ee5eb63          	bltu	a1,a4,1294 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    11a2:	02e8763b          	remuw	a2,a6,a4
    11a6:	1602                	slli	a2,a2,0x20
    11a8:	9201                	srli	a2,a2,0x20
    11aa:	9636                	add	a2,a2,a3
    11ac:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11b0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b4:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    11b8:	0ce86263          	bltu	a6,a4,127c <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    11bc:	02e5f63b          	remuw	a2,a1,a4
    11c0:	1602                	slli	a2,a2,0x20
    11c2:	9201                	srli	a2,a2,0x20
    11c4:	9636                	add	a2,a2,a3
    11c6:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11ca:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ce:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11d2:	0ce5e663          	bltu	a1,a4,129e <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11d6:	02e8763b          	remuw	a2,a6,a4
    11da:	1602                	slli	a2,a2,0x20
    11dc:	9201                	srli	a2,a2,0x20
    11de:	9636                	add	a2,a2,a3
    11e0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11e4:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11e8:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11ec:	0ae86c63          	bltu	a6,a4,12a4 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11f0:	02e5f63b          	remuw	a2,a1,a4
    11f4:	1602                	slli	a2,a2,0x20
    11f6:	9201                	srli	a2,a2,0x20
    11f8:	9636                	add	a2,a2,a3
    11fa:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11fe:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    1202:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    1206:	0ae5e263          	bltu	a1,a4,12aa <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    120a:	1782                	slli	a5,a5,0x20
    120c:	9381                	srli	a5,a5,0x20
    120e:	97b6                	add	a5,a5,a3
    1210:	0007c703          	lbu	a4,0(a5)
    1214:	4599                	li	a1,6
    1216:	4795                	li	a5,5
    1218:	00e10723          	sb	a4,14(sp)

    if (sign)
    121c:	00055963          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1220:	1018                	addi	a4,sp,32
    1222:	973e                	add	a4,a4,a5
    1224:	02d00693          	li	a3,45
    1228:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    122c:	85be                	mv	a1,a5
    write(f, s, l);
    122e:	003c                	addi	a5,sp,8
    1230:	4641                	li	a2,16
    1232:	9e0d                	subw	a2,a2,a1
    1234:	4505                	li	a0,1
    1236:	95be                	add	a1,a1,a5
    1238:	293000ef          	jal	ra,1cca <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    123c:	70a2                	ld	ra,40(sp)
    123e:	6145                	addi	sp,sp,48
    1240:	8082                	ret
        x = -xx;
    1242:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1246:	02b677bb          	remuw	a5,a2,a1
    124a:	00003697          	auipc	a3,0x3
    124e:	dd668693          	addi	a3,a3,-554 # 4020 <digits>
    buf[16] = 0;
    1252:	00010c23          	sb	zero,24(sp)
    i = 15;
    1256:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    125a:	1782                	slli	a5,a5,0x20
    125c:	9381                	srli	a5,a5,0x20
    125e:	97b6                	add	a5,a5,a3
    1260:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1264:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1268:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    126c:	ecb677e3          	bgeu	a2,a1,113a <printint.constprop.0+0x32>
        buf[i--] = '-';
    1270:	02d00793          	li	a5,45
    1274:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1278:	45b9                	li	a1,14
    127a:	bf55                	j	122e <printint.constprop.0+0x126>
    127c:	47a5                	li	a5,9
    127e:	45a9                	li	a1,10
    1280:	bf71                	j	121c <printint.constprop.0+0x114>
    1282:	47b5                	li	a5,13
    1284:	45b9                	li	a1,14
    1286:	bf59                	j	121c <printint.constprop.0+0x114>
    1288:	47b1                	li	a5,12
    128a:	45b5                	li	a1,13
    128c:	bf41                	j	121c <printint.constprop.0+0x114>
    128e:	47ad                	li	a5,11
    1290:	45b1                	li	a1,12
    1292:	b769                	j	121c <printint.constprop.0+0x114>
    1294:	47a9                	li	a5,10
    1296:	45ad                	li	a1,11
    1298:	b751                	j	121c <printint.constprop.0+0x114>
    i = 15;
    129a:	45bd                	li	a1,15
    129c:	bf49                	j	122e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    129e:	47a1                	li	a5,8
    12a0:	45a5                	li	a1,9
    12a2:	bfad                	j	121c <printint.constprop.0+0x114>
    12a4:	479d                	li	a5,7
    12a6:	45a1                	li	a1,8
    12a8:	bf95                	j	121c <printint.constprop.0+0x114>
    12aa:	4799                	li	a5,6
    12ac:	459d                	li	a1,7
    12ae:	b7bd                	j	121c <printint.constprop.0+0x114>

00000000000012b0 <getchar>:
{
    12b0:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12b2:	00f10593          	addi	a1,sp,15
    12b6:	4605                	li	a2,1
    12b8:	4501                	li	a0,0
{
    12ba:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12bc:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12c0:	201000ef          	jal	ra,1cc0 <read>
}
    12c4:	60e2                	ld	ra,24(sp)
    12c6:	00f14503          	lbu	a0,15(sp)
    12ca:	6105                	addi	sp,sp,32
    12cc:	8082                	ret

00000000000012ce <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12ce:	00003797          	auipc	a5,0x3
    12d2:	d6a78793          	addi	a5,a5,-662 # 4038 <digits+0x18>
    12d6:	04000893          	li	a7,64
    12da:	4505                	li	a0,1
    12dc:	85be                	mv	a1,a5
    12de:	4611                	li	a2,4
    12e0:	00000073          	ecall
}
    12e4:	4501                	li	a0,0
    12e6:	8082                	ret

00000000000012e8 <putchar>:
{
    12e8:	1101                	addi	sp,sp,-32
    12ea:	ec06                	sd	ra,24(sp)
    12ec:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12ee:	3e700893          	li	a7,999
    12f2:	4505                	li	a0,1
    12f4:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12f8:	00003717          	auipc	a4,0x3
    12fc:	d4070713          	addi	a4,a4,-704 # 4038 <digits+0x18>
    1300:	04000893          	li	a7,64
    1304:	4505                	li	a0,1
    1306:	85ba                	mv	a1,a4
    1308:	4611                	li	a2,4
    130a:	00000073          	ecall
    return write(stdout, &byte, 1);
    130e:	4605                	li	a2,1
    1310:	00f10593          	addi	a1,sp,15
    1314:	4505                	li	a0,1
    char byte = c;
    1316:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    131a:	1b1000ef          	jal	ra,1cca <write>
}
    131e:	60e2                	ld	ra,24(sp)
    1320:	2501                	sext.w	a0,a0
    1322:	6105                	addi	sp,sp,32
    1324:	8082                	ret

0000000000001326 <puts>:
{
    1326:	1141                	addi	sp,sp,-16
    1328:	e406                	sd	ra,8(sp)
    132a:	e022                	sd	s0,0(sp)
    132c:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    132e:	5b8000ef          	jal	ra,18e6 <strlen>
    1332:	862a                	mv	a2,a0
    1334:	85a2                	mv	a1,s0
    1336:	4505                	li	a0,1
    1338:	193000ef          	jal	ra,1cca <write>
}
    133c:	60a2                	ld	ra,8(sp)
    133e:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1340:	957d                	srai	a0,a0,0x3f
    return r;
    1342:	2501                	sext.w	a0,a0
}
    1344:	0141                	addi	sp,sp,16
    1346:	8082                	ret

0000000000001348 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1348:	7171                	addi	sp,sp,-176
    134a:	e0d2                	sd	s4,64(sp)
    134c:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    134e:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1350:	18bc                	addi	a5,sp,120
{
    1352:	e8ca                	sd	s2,80(sp)
    1354:	e4ce                	sd	s3,72(sp)
    1356:	fc56                	sd	s5,56(sp)
    1358:	f85a                	sd	s6,48(sp)
    135a:	f486                	sd	ra,104(sp)
    135c:	f0a2                	sd	s0,96(sp)
    135e:	eca6                	sd	s1,88(sp)
    1360:	fcae                	sd	a1,120(sp)
    1362:	e132                	sd	a2,128(sp)
    1364:	e536                	sd	a3,136(sp)
    1366:	e93a                	sd	a4,144(sp)
    1368:	f142                	sd	a6,160(sp)
    136a:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    136c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    136e:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1372:	00001b17          	auipc	s6,0x1
    1376:	c76b0b13          	addi	s6,s6,-906 # 1fe8 <__clone+0xe6>
	::"r"((unsigned long long)ac)
    137a:	00003a97          	auipc	s5,0x3
    137e:	cbea8a93          	addi	s5,s5,-834 # 4038 <digits+0x18>
    buf[i++] = '0';
    1382:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1386:	00003997          	auipc	s3,0x3
    138a:	c9a98993          	addi	s3,s3,-870 # 4020 <digits>
        if (!*s)
    138e:	00054783          	lbu	a5,0(a0)
    1392:	16078c63          	beqz	a5,150a <printf+0x1c2>
    1396:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1398:	19278363          	beq	a5,s2,151e <printf+0x1d6>
    139c:	00164783          	lbu	a5,1(a2)
    13a0:	0605                	addi	a2,a2,1
    13a2:	fbfd                	bnez	a5,1398 <printf+0x50>
    13a4:	84b2                	mv	s1,a2
        l = z - a;
    13a6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13aa:	85aa                	mv	a1,a0
    13ac:	8622                	mv	a2,s0
    13ae:	4505                	li	a0,1
    13b0:	11b000ef          	jal	ra,1cca <write>
        if (l)
    13b4:	18041e63          	bnez	s0,1550 <printf+0x208>
        if (s[1] == 0)
    13b8:	0014c783          	lbu	a5,1(s1)
    13bc:	14078763          	beqz	a5,150a <printf+0x1c2>
        switch (s[1])
    13c0:	07300713          	li	a4,115
    13c4:	1ce78063          	beq	a5,a4,1584 <printf+0x23c>
    13c8:	18f76663          	bltu	a4,a5,1554 <printf+0x20c>
    13cc:	06400713          	li	a4,100
    13d0:	1ae78063          	beq	a5,a4,1570 <printf+0x228>
    13d4:	07000713          	li	a4,112
    13d8:	1ce79963          	bne	a5,a4,15aa <printf+0x262>
            printptr(va_arg(ap, uint64));
    13dc:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13de:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13e2:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13e4:	631c                	ld	a5,0(a4)
    13e6:	0721                	addi	a4,a4,8
    13e8:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ea:	00479293          	slli	t0,a5,0x4
    13ee:	00879f93          	slli	t6,a5,0x8
    13f2:	00c79f13          	slli	t5,a5,0xc
    13f6:	01079e93          	slli	t4,a5,0x10
    13fa:	01479e13          	slli	t3,a5,0x14
    13fe:	01879313          	slli	t1,a5,0x18
    1402:	01c79893          	slli	a7,a5,0x1c
    1406:	02479813          	slli	a6,a5,0x24
    140a:	02879513          	slli	a0,a5,0x28
    140e:	02c79593          	slli	a1,a5,0x2c
    1412:	03079693          	slli	a3,a5,0x30
    1416:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    141a:	03c7d413          	srli	s0,a5,0x3c
    141e:	01c7d39b          	srliw	t2,a5,0x1c
    1422:	03c2d293          	srli	t0,t0,0x3c
    1426:	03cfdf93          	srli	t6,t6,0x3c
    142a:	03cf5f13          	srli	t5,t5,0x3c
    142e:	03cede93          	srli	t4,t4,0x3c
    1432:	03ce5e13          	srli	t3,t3,0x3c
    1436:	03c35313          	srli	t1,t1,0x3c
    143a:	03c8d893          	srli	a7,a7,0x3c
    143e:	03c85813          	srli	a6,a6,0x3c
    1442:	9171                	srli	a0,a0,0x3c
    1444:	91f1                	srli	a1,a1,0x3c
    1446:	92f1                	srli	a3,a3,0x3c
    1448:	9371                	srli	a4,a4,0x3c
    144a:	96ce                	add	a3,a3,s3
    144c:	974e                	add	a4,a4,s3
    144e:	944e                	add	s0,s0,s3
    1450:	92ce                	add	t0,t0,s3
    1452:	9fce                	add	t6,t6,s3
    1454:	9f4e                	add	t5,t5,s3
    1456:	9ece                	add	t4,t4,s3
    1458:	9e4e                	add	t3,t3,s3
    145a:	934e                	add	t1,t1,s3
    145c:	98ce                	add	a7,a7,s3
    145e:	93ce                	add	t2,t2,s3
    1460:	984e                	add	a6,a6,s3
    1462:	954e                	add	a0,a0,s3
    1464:	95ce                	add	a1,a1,s3
    1466:	0006c083          	lbu	ra,0(a3)
    146a:	0002c283          	lbu	t0,0(t0)
    146e:	00074683          	lbu	a3,0(a4)
    1472:	000fcf83          	lbu	t6,0(t6)
    1476:	000f4f03          	lbu	t5,0(t5)
    147a:	000ece83          	lbu	t4,0(t4)
    147e:	000e4e03          	lbu	t3,0(t3)
    1482:	00034303          	lbu	t1,0(t1)
    1486:	0008c883          	lbu	a7,0(a7)
    148a:	0003c383          	lbu	t2,0(t2)
    148e:	00084803          	lbu	a6,0(a6)
    1492:	00054503          	lbu	a0,0(a0)
    1496:	0005c583          	lbu	a1,0(a1)
    149a:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    149e:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14a2:	9371                	srli	a4,a4,0x3c
    14a4:	8bbd                	andi	a5,a5,15
    14a6:	974e                	add	a4,a4,s3
    14a8:	97ce                	add	a5,a5,s3
    14aa:	005105a3          	sb	t0,11(sp)
    14ae:	01f10623          	sb	t6,12(sp)
    14b2:	01e106a3          	sb	t5,13(sp)
    14b6:	01d10723          	sb	t4,14(sp)
    14ba:	01c107a3          	sb	t3,15(sp)
    14be:	00610823          	sb	t1,16(sp)
    14c2:	011108a3          	sb	a7,17(sp)
    14c6:	00710923          	sb	t2,18(sp)
    14ca:	010109a3          	sb	a6,19(sp)
    14ce:	00a10a23          	sb	a0,20(sp)
    14d2:	00b10aa3          	sb	a1,21(sp)
    14d6:	00110b23          	sb	ra,22(sp)
    14da:	00d10ba3          	sb	a3,23(sp)
    14de:	00810523          	sb	s0,10(sp)
    14e2:	00074703          	lbu	a4,0(a4)
    14e6:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14ea:	002c                	addi	a1,sp,8
    14ec:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ee:	00e10c23          	sb	a4,24(sp)
    14f2:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14f6:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14fa:	7d0000ef          	jal	ra,1cca <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14fe:	00248513          	addi	a0,s1,2
        if (!*s)
    1502:	00054783          	lbu	a5,0(a0)
    1506:	e80798e3          	bnez	a5,1396 <printf+0x4e>
    }
    va_end(ap);
}
    150a:	70a6                	ld	ra,104(sp)
    150c:	7406                	ld	s0,96(sp)
    150e:	64e6                	ld	s1,88(sp)
    1510:	6946                	ld	s2,80(sp)
    1512:	69a6                	ld	s3,72(sp)
    1514:	6a06                	ld	s4,64(sp)
    1516:	7ae2                	ld	s5,56(sp)
    1518:	7b42                	ld	s6,48(sp)
    151a:	614d                	addi	sp,sp,176
    151c:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    151e:	00064783          	lbu	a5,0(a2)
    1522:	84b2                	mv	s1,a2
    1524:	01278963          	beq	a5,s2,1536 <printf+0x1ee>
    1528:	bdbd                	j	13a6 <printf+0x5e>
    152a:	0024c783          	lbu	a5,2(s1)
    152e:	0605                	addi	a2,a2,1
    1530:	0489                	addi	s1,s1,2
    1532:	e7279ae3          	bne	a5,s2,13a6 <printf+0x5e>
    1536:	0014c783          	lbu	a5,1(s1)
    153a:	ff2788e3          	beq	a5,s2,152a <printf+0x1e2>
        l = z - a;
    153e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1542:	85aa                	mv	a1,a0
    1544:	8622                	mv	a2,s0
    1546:	4505                	li	a0,1
    1548:	782000ef          	jal	ra,1cca <write>
        if (l)
    154c:	e60406e3          	beqz	s0,13b8 <printf+0x70>
    1550:	8526                	mv	a0,s1
    1552:	bd35                	j	138e <printf+0x46>
        switch (s[1])
    1554:	07800713          	li	a4,120
    1558:	04e79963          	bne	a5,a4,15aa <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    155c:	6782                	ld	a5,0(sp)
    155e:	45c1                	li	a1,16
    1560:	4388                	lw	a0,0(a5)
    1562:	07a1                	addi	a5,a5,8
    1564:	e03e                	sd	a5,0(sp)
    1566:	ba3ff0ef          	jal	ra,1108 <printint.constprop.0>
        s += 2;
    156a:	00248513          	addi	a0,s1,2
    156e:	bf51                	j	1502 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1570:	6782                	ld	a5,0(sp)
    1572:	45a9                	li	a1,10
    1574:	4388                	lw	a0,0(a5)
    1576:	07a1                	addi	a5,a5,8
    1578:	e03e                	sd	a5,0(sp)
    157a:	b8fff0ef          	jal	ra,1108 <printint.constprop.0>
        s += 2;
    157e:	00248513          	addi	a0,s1,2
    1582:	b741                	j	1502 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1584:	6782                	ld	a5,0(sp)
    1586:	6380                	ld	s0,0(a5)
    1588:	07a1                	addi	a5,a5,8
    158a:	e03e                	sd	a5,0(sp)
    158c:	cc25                	beqz	s0,1604 <printf+0x2bc>
            l = strnlen(a, 200);
    158e:	0c800593          	li	a1,200
    1592:	8522                	mv	a0,s0
    1594:	43e000ef          	jal	ra,19d2 <strnlen>
    write(f, s, l);
    1598:	0005061b          	sext.w	a2,a0
    159c:	85a2                	mv	a1,s0
    159e:	4505                	li	a0,1
    15a0:	72a000ef          	jal	ra,1cca <write>
        s += 2;
    15a4:	00248513          	addi	a0,s1,2
    15a8:	bfa9                	j	1502 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15aa:	3e700893          	li	a7,999
    15ae:	4505                	li	a0,1
    15b0:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15b4:	04000893          	li	a7,64
    15b8:	4505                	li	a0,1
    15ba:	85d6                	mv	a1,s5
    15bc:	4611                	li	a2,4
    15be:	00000073          	ecall
    char byte = c;
    15c2:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    15c6:	4605                	li	a2,1
    15c8:	002c                	addi	a1,sp,8
    15ca:	4505                	li	a0,1
    char byte = c;
    15cc:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15d0:	6fa000ef          	jal	ra,1cca <write>
            putchar(s[1]);
    15d4:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15d8:	3e700893          	li	a7,999
    15dc:	4505                	li	a0,1
    15de:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15e2:	04000893          	li	a7,64
    15e6:	4505                	li	a0,1
    15e8:	85d6                	mv	a1,s5
    15ea:	4611                	li	a2,4
    15ec:	00000073          	ecall
    return write(stdout, &byte, 1);
    15f0:	4605                	li	a2,1
    15f2:	002c                	addi	a1,sp,8
    15f4:	4505                	li	a0,1
    char byte = c;
    15f6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15fa:	6d0000ef          	jal	ra,1cca <write>
        s += 2;
    15fe:	00248513          	addi	a0,s1,2
    1602:	b701                	j	1502 <printf+0x1ba>
                a = "(null)";
    1604:	845a                	mv	s0,s6
    1606:	b761                	j	158e <printf+0x246>

0000000000001608 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1608:	1141                	addi	sp,sp,-16
    160a:	e406                	sd	ra,8(sp)
    puts(m);
    160c:	d1bff0ef          	jal	ra,1326 <puts>
    exit(-100);
}
    1610:	60a2                	ld	ra,8(sp)
    exit(-100);
    1612:	f9c00513          	li	a0,-100
}
    1616:	0141                	addi	sp,sp,16
    exit(-100);
    1618:	a709                	j	1d1a <exit>

000000000000161a <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    161a:	02000793          	li	a5,32
    161e:	00f50663          	beq	a0,a5,162a <isspace+0x10>
    1622:	355d                	addiw	a0,a0,-9
    1624:	00553513          	sltiu	a0,a0,5
    1628:	8082                	ret
    162a:	4505                	li	a0,1
}
    162c:	8082                	ret

000000000000162e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    162e:	fd05051b          	addiw	a0,a0,-48
}
    1632:	00a53513          	sltiu	a0,a0,10
    1636:	8082                	ret

0000000000001638 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1638:	02000613          	li	a2,32
    163c:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    163e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1642:	ff77069b          	addiw	a3,a4,-9
    1646:	04c70d63          	beq	a4,a2,16a0 <atoi+0x68>
    164a:	0007079b          	sext.w	a5,a4
    164e:	04d5f963          	bgeu	a1,a3,16a0 <atoi+0x68>
        s++;
    switch (*s)
    1652:	02b00693          	li	a3,43
    1656:	04d70a63          	beq	a4,a3,16aa <atoi+0x72>
    165a:	02d00693          	li	a3,45
    165e:	06d70463          	beq	a4,a3,16c6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1662:	fd07859b          	addiw	a1,a5,-48
    1666:	4625                	li	a2,9
    1668:	873e                	mv	a4,a5
    166a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    166c:	4e01                	li	t3,0
    while (isdigit(*s))
    166e:	04b66a63          	bltu	a2,a1,16c2 <atoi+0x8a>
    int n = 0, neg = 0;
    1672:	4501                	li	a0,0
    while (isdigit(*s))
    1674:	4825                	li	a6,9
    1676:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    167a:	0025179b          	slliw	a5,a0,0x2
    167e:	9d3d                	addw	a0,a0,a5
    1680:	fd07031b          	addiw	t1,a4,-48
    1684:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1688:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    168c:	0685                	addi	a3,a3,1
    168e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1692:	0006071b          	sext.w	a4,a2
    1696:	feb870e3          	bgeu	a6,a1,1676 <atoi+0x3e>
    return neg ? n : -n;
    169a:	000e0563          	beqz	t3,16a4 <atoi+0x6c>
}
    169e:	8082                	ret
        s++;
    16a0:	0505                	addi	a0,a0,1
    16a2:	bf71                	j	163e <atoi+0x6>
    16a4:	4113053b          	subw	a0,t1,a7
    16a8:	8082                	ret
    while (isdigit(*s))
    16aa:	00154783          	lbu	a5,1(a0)
    16ae:	4625                	li	a2,9
        s++;
    16b0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b4:	fd07859b          	addiw	a1,a5,-48
    16b8:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16bc:	4e01                	li	t3,0
    while (isdigit(*s))
    16be:	fab67ae3          	bgeu	a2,a1,1672 <atoi+0x3a>
    16c2:	4501                	li	a0,0
}
    16c4:	8082                	ret
    while (isdigit(*s))
    16c6:	00154783          	lbu	a5,1(a0)
    16ca:	4625                	li	a2,9
        s++;
    16cc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16d0:	fd07859b          	addiw	a1,a5,-48
    16d4:	0007871b          	sext.w	a4,a5
    16d8:	feb665e3          	bltu	a2,a1,16c2 <atoi+0x8a>
        neg = 1;
    16dc:	4e05                	li	t3,1
    16de:	bf51                	j	1672 <atoi+0x3a>

00000000000016e0 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16e0:	16060d63          	beqz	a2,185a <memset+0x17a>
    16e4:	40a007b3          	neg	a5,a0
    16e8:	8b9d                	andi	a5,a5,7
    16ea:	00778713          	addi	a4,a5,7
    16ee:	482d                	li	a6,11
    16f0:	0ff5f593          	zext.b	a1,a1
    16f4:	fff60693          	addi	a3,a2,-1
    16f8:	17076263          	bltu	a4,a6,185c <memset+0x17c>
    16fc:	16e6ea63          	bltu	a3,a4,1870 <memset+0x190>
    1700:	16078563          	beqz	a5,186a <memset+0x18a>
    1704:	00b50023          	sb	a1,0(a0)
    1708:	4705                	li	a4,1
    170a:	00150e93          	addi	t4,a0,1
    170e:	14e78c63          	beq	a5,a4,1866 <memset+0x186>
    1712:	00b500a3          	sb	a1,1(a0)
    1716:	4709                	li	a4,2
    1718:	00250e93          	addi	t4,a0,2
    171c:	14e78d63          	beq	a5,a4,1876 <memset+0x196>
    1720:	00b50123          	sb	a1,2(a0)
    1724:	470d                	li	a4,3
    1726:	00350e93          	addi	t4,a0,3
    172a:	12e78b63          	beq	a5,a4,1860 <memset+0x180>
    172e:	00b501a3          	sb	a1,3(a0)
    1732:	4711                	li	a4,4
    1734:	00450e93          	addi	t4,a0,4
    1738:	14e78163          	beq	a5,a4,187a <memset+0x19a>
    173c:	00b50223          	sb	a1,4(a0)
    1740:	4715                	li	a4,5
    1742:	00550e93          	addi	t4,a0,5
    1746:	12e78c63          	beq	a5,a4,187e <memset+0x19e>
    174a:	00b502a3          	sb	a1,5(a0)
    174e:	471d                	li	a4,7
    1750:	00650e93          	addi	t4,a0,6
    1754:	12e79763          	bne	a5,a4,1882 <memset+0x1a2>
    1758:	00750e93          	addi	t4,a0,7
    175c:	00b50323          	sb	a1,6(a0)
    1760:	4f1d                	li	t5,7
    1762:	00859713          	slli	a4,a1,0x8
    1766:	8f4d                	or	a4,a4,a1
    1768:	01059e13          	slli	t3,a1,0x10
    176c:	01c76e33          	or	t3,a4,t3
    1770:	01859313          	slli	t1,a1,0x18
    1774:	006e6333          	or	t1,t3,t1
    1778:	02059893          	slli	a7,a1,0x20
    177c:	011368b3          	or	a7,t1,a7
    1780:	02859813          	slli	a6,a1,0x28
    1784:	40f60333          	sub	t1,a2,a5
    1788:	0108e833          	or	a6,a7,a6
    178c:	03059693          	slli	a3,a1,0x30
    1790:	00d866b3          	or	a3,a6,a3
    1794:	03859713          	slli	a4,a1,0x38
    1798:	97aa                	add	a5,a5,a0
    179a:	ff837813          	andi	a6,t1,-8
    179e:	8f55                	or	a4,a4,a3
    17a0:	00f806b3          	add	a3,a6,a5
    17a4:	e398                	sd	a4,0(a5)
    17a6:	07a1                	addi	a5,a5,8
    17a8:	fed79ee3          	bne	a5,a3,17a4 <memset+0xc4>
    17ac:	ff837693          	andi	a3,t1,-8
    17b0:	00de87b3          	add	a5,t4,a3
    17b4:	01e6873b          	addw	a4,a3,t5
    17b8:	0ad30663          	beq	t1,a3,1864 <memset+0x184>
    17bc:	00b78023          	sb	a1,0(a5)
    17c0:	0017069b          	addiw	a3,a4,1
    17c4:	08c6fb63          	bgeu	a3,a2,185a <memset+0x17a>
    17c8:	00b780a3          	sb	a1,1(a5)
    17cc:	0027069b          	addiw	a3,a4,2
    17d0:	08c6f563          	bgeu	a3,a2,185a <memset+0x17a>
    17d4:	00b78123          	sb	a1,2(a5)
    17d8:	0037069b          	addiw	a3,a4,3
    17dc:	06c6ff63          	bgeu	a3,a2,185a <memset+0x17a>
    17e0:	00b781a3          	sb	a1,3(a5)
    17e4:	0047069b          	addiw	a3,a4,4
    17e8:	06c6f963          	bgeu	a3,a2,185a <memset+0x17a>
    17ec:	00b78223          	sb	a1,4(a5)
    17f0:	0057069b          	addiw	a3,a4,5
    17f4:	06c6f363          	bgeu	a3,a2,185a <memset+0x17a>
    17f8:	00b782a3          	sb	a1,5(a5)
    17fc:	0067069b          	addiw	a3,a4,6
    1800:	04c6fd63          	bgeu	a3,a2,185a <memset+0x17a>
    1804:	00b78323          	sb	a1,6(a5)
    1808:	0077069b          	addiw	a3,a4,7
    180c:	04c6f763          	bgeu	a3,a2,185a <memset+0x17a>
    1810:	00b783a3          	sb	a1,7(a5)
    1814:	0087069b          	addiw	a3,a4,8
    1818:	04c6f163          	bgeu	a3,a2,185a <memset+0x17a>
    181c:	00b78423          	sb	a1,8(a5)
    1820:	0097069b          	addiw	a3,a4,9
    1824:	02c6fb63          	bgeu	a3,a2,185a <memset+0x17a>
    1828:	00b784a3          	sb	a1,9(a5)
    182c:	00a7069b          	addiw	a3,a4,10
    1830:	02c6f563          	bgeu	a3,a2,185a <memset+0x17a>
    1834:	00b78523          	sb	a1,10(a5)
    1838:	00b7069b          	addiw	a3,a4,11
    183c:	00c6ff63          	bgeu	a3,a2,185a <memset+0x17a>
    1840:	00b785a3          	sb	a1,11(a5)
    1844:	00c7069b          	addiw	a3,a4,12
    1848:	00c6f963          	bgeu	a3,a2,185a <memset+0x17a>
    184c:	00b78623          	sb	a1,12(a5)
    1850:	2735                	addiw	a4,a4,13
    1852:	00c77463          	bgeu	a4,a2,185a <memset+0x17a>
    1856:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    185a:	8082                	ret
    185c:	472d                	li	a4,11
    185e:	bd79                	j	16fc <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1860:	4f0d                	li	t5,3
    1862:	b701                	j	1762 <memset+0x82>
    1864:	8082                	ret
    1866:	4f05                	li	t5,1
    1868:	bded                	j	1762 <memset+0x82>
    186a:	8eaa                	mv	t4,a0
    186c:	4f01                	li	t5,0
    186e:	bdd5                	j	1762 <memset+0x82>
    1870:	87aa                	mv	a5,a0
    1872:	4701                	li	a4,0
    1874:	b7a1                	j	17bc <memset+0xdc>
    1876:	4f09                	li	t5,2
    1878:	b5ed                	j	1762 <memset+0x82>
    187a:	4f11                	li	t5,4
    187c:	b5dd                	j	1762 <memset+0x82>
    187e:	4f15                	li	t5,5
    1880:	b5cd                	j	1762 <memset+0x82>
    1882:	4f19                	li	t5,6
    1884:	bdf9                	j	1762 <memset+0x82>

0000000000001886 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1886:	00054783          	lbu	a5,0(a0)
    188a:	0005c703          	lbu	a4,0(a1)
    188e:	00e79863          	bne	a5,a4,189e <strcmp+0x18>
    1892:	0505                	addi	a0,a0,1
    1894:	0585                	addi	a1,a1,1
    1896:	fbe5                	bnez	a5,1886 <strcmp>
    1898:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    189a:	9d19                	subw	a0,a0,a4
    189c:	8082                	ret
    189e:	0007851b          	sext.w	a0,a5
    18a2:	bfe5                	j	189a <strcmp+0x14>

00000000000018a4 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18a4:	ce05                	beqz	a2,18dc <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18a6:	00054703          	lbu	a4,0(a0)
    18aa:	0005c783          	lbu	a5,0(a1)
    18ae:	cb0d                	beqz	a4,18e0 <strncmp+0x3c>
    if (!n--)
    18b0:	167d                	addi	a2,a2,-1
    18b2:	00c506b3          	add	a3,a0,a2
    18b6:	a819                	j	18cc <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18b8:	00a68e63          	beq	a3,a0,18d4 <strncmp+0x30>
    18bc:	0505                	addi	a0,a0,1
    18be:	00e79b63          	bne	a5,a4,18d4 <strncmp+0x30>
    18c2:	00054703          	lbu	a4,0(a0)
    18c6:	0005c783          	lbu	a5,0(a1)
    18ca:	cb19                	beqz	a4,18e0 <strncmp+0x3c>
    18cc:	0005c783          	lbu	a5,0(a1)
    18d0:	0585                	addi	a1,a1,1
    18d2:	f3fd                	bnez	a5,18b8 <strncmp+0x14>
        ;
    return *l - *r;
    18d4:	0007051b          	sext.w	a0,a4
    18d8:	9d1d                	subw	a0,a0,a5
    18da:	8082                	ret
        return 0;
    18dc:	4501                	li	a0,0
}
    18de:	8082                	ret
    18e0:	4501                	li	a0,0
    return *l - *r;
    18e2:	9d1d                	subw	a0,a0,a5
    18e4:	8082                	ret

00000000000018e6 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18e6:	00757793          	andi	a5,a0,7
    18ea:	cf89                	beqz	a5,1904 <strlen+0x1e>
    18ec:	87aa                	mv	a5,a0
    18ee:	a029                	j	18f8 <strlen+0x12>
    18f0:	0785                	addi	a5,a5,1
    18f2:	0077f713          	andi	a4,a5,7
    18f6:	cb01                	beqz	a4,1906 <strlen+0x20>
        if (!*s)
    18f8:	0007c703          	lbu	a4,0(a5)
    18fc:	fb75                	bnez	a4,18f0 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18fe:	40a78533          	sub	a0,a5,a0
}
    1902:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1904:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    1906:	6394                	ld	a3,0(a5)
    1908:	00000597          	auipc	a1,0x0
    190c:	6e85b583          	ld	a1,1768(a1) # 1ff0 <__clone+0xee>
    1910:	00000617          	auipc	a2,0x0
    1914:	6e863603          	ld	a2,1768(a2) # 1ff8 <__clone+0xf6>
    1918:	a019                	j	191e <strlen+0x38>
    191a:	6794                	ld	a3,8(a5)
    191c:	07a1                	addi	a5,a5,8
    191e:	00b68733          	add	a4,a3,a1
    1922:	fff6c693          	not	a3,a3
    1926:	8f75                	and	a4,a4,a3
    1928:	8f71                	and	a4,a4,a2
    192a:	db65                	beqz	a4,191a <strlen+0x34>
    for (; *s; s++)
    192c:	0007c703          	lbu	a4,0(a5)
    1930:	d779                	beqz	a4,18fe <strlen+0x18>
    1932:	0017c703          	lbu	a4,1(a5)
    1936:	0785                	addi	a5,a5,1
    1938:	d379                	beqz	a4,18fe <strlen+0x18>
    193a:	0017c703          	lbu	a4,1(a5)
    193e:	0785                	addi	a5,a5,1
    1940:	fb6d                	bnez	a4,1932 <strlen+0x4c>
    1942:	bf75                	j	18fe <strlen+0x18>

0000000000001944 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1944:	00757713          	andi	a4,a0,7
{
    1948:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    194a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    194e:	cb19                	beqz	a4,1964 <memchr+0x20>
    1950:	ce25                	beqz	a2,19c8 <memchr+0x84>
    1952:	0007c703          	lbu	a4,0(a5)
    1956:	04b70e63          	beq	a4,a1,19b2 <memchr+0x6e>
    195a:	0785                	addi	a5,a5,1
    195c:	0077f713          	andi	a4,a5,7
    1960:	167d                	addi	a2,a2,-1
    1962:	f77d                	bnez	a4,1950 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1964:	4501                	li	a0,0
    if (n && *s != c)
    1966:	c235                	beqz	a2,19ca <memchr+0x86>
    1968:	0007c703          	lbu	a4,0(a5)
    196c:	04b70363          	beq	a4,a1,19b2 <memchr+0x6e>
        size_t k = ONES * c;
    1970:	00000517          	auipc	a0,0x0
    1974:	69053503          	ld	a0,1680(a0) # 2000 <__clone+0xfe>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1978:	471d                	li	a4,7
        size_t k = ONES * c;
    197a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    197e:	02c77a63          	bgeu	a4,a2,19b2 <memchr+0x6e>
    1982:	00000897          	auipc	a7,0x0
    1986:	66e8b883          	ld	a7,1646(a7) # 1ff0 <__clone+0xee>
    198a:	00000817          	auipc	a6,0x0
    198e:	66e83803          	ld	a6,1646(a6) # 1ff8 <__clone+0xf6>
    1992:	431d                	li	t1,7
    1994:	a029                	j	199e <memchr+0x5a>
    1996:	1661                	addi	a2,a2,-8
    1998:	07a1                	addi	a5,a5,8
    199a:	02c37963          	bgeu	t1,a2,19cc <memchr+0x88>
    199e:	6398                	ld	a4,0(a5)
    19a0:	8f29                	xor	a4,a4,a0
    19a2:	011706b3          	add	a3,a4,a7
    19a6:	fff74713          	not	a4,a4
    19aa:	8f75                	and	a4,a4,a3
    19ac:	01077733          	and	a4,a4,a6
    19b0:	d37d                	beqz	a4,1996 <memchr+0x52>
    19b2:	853e                	mv	a0,a5
    19b4:	97b2                	add	a5,a5,a2
    19b6:	a021                	j	19be <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19b8:	0505                	addi	a0,a0,1
    19ba:	00f50763          	beq	a0,a5,19c8 <memchr+0x84>
    19be:	00054703          	lbu	a4,0(a0)
    19c2:	feb71be3          	bne	a4,a1,19b8 <memchr+0x74>
    19c6:	8082                	ret
    return n ? (void *)s : 0;
    19c8:	4501                	li	a0,0
}
    19ca:	8082                	ret
    return n ? (void *)s : 0;
    19cc:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19ce:	f275                	bnez	a2,19b2 <memchr+0x6e>
}
    19d0:	8082                	ret

00000000000019d2 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19d2:	1101                	addi	sp,sp,-32
    19d4:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19d6:	862e                	mv	a2,a1
{
    19d8:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19da:	4581                	li	a1,0
{
    19dc:	e426                	sd	s1,8(sp)
    19de:	ec06                	sd	ra,24(sp)
    19e0:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19e2:	f63ff0ef          	jal	ra,1944 <memchr>
    return p ? p - s : n;
    19e6:	c519                	beqz	a0,19f4 <strnlen+0x22>
}
    19e8:	60e2                	ld	ra,24(sp)
    19ea:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19ec:	8d05                	sub	a0,a0,s1
}
    19ee:	64a2                	ld	s1,8(sp)
    19f0:	6105                	addi	sp,sp,32
    19f2:	8082                	ret
    19f4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19f6:	8522                	mv	a0,s0
}
    19f8:	6442                	ld	s0,16(sp)
    19fa:	64a2                	ld	s1,8(sp)
    19fc:	6105                	addi	sp,sp,32
    19fe:	8082                	ret

0000000000001a00 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a00:	00b547b3          	xor	a5,a0,a1
    1a04:	8b9d                	andi	a5,a5,7
    1a06:	eb95                	bnez	a5,1a3a <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a08:	0075f793          	andi	a5,a1,7
    1a0c:	e7b1                	bnez	a5,1a58 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a0e:	6198                	ld	a4,0(a1)
    1a10:	00000617          	auipc	a2,0x0
    1a14:	5e063603          	ld	a2,1504(a2) # 1ff0 <__clone+0xee>
    1a18:	00000817          	auipc	a6,0x0
    1a1c:	5e083803          	ld	a6,1504(a6) # 1ff8 <__clone+0xf6>
    1a20:	a029                	j	1a2a <strcpy+0x2a>
    1a22:	e118                	sd	a4,0(a0)
    1a24:	6598                	ld	a4,8(a1)
    1a26:	05a1                	addi	a1,a1,8
    1a28:	0521                	addi	a0,a0,8
    1a2a:	00c707b3          	add	a5,a4,a2
    1a2e:	fff74693          	not	a3,a4
    1a32:	8ff5                	and	a5,a5,a3
    1a34:	0107f7b3          	and	a5,a5,a6
    1a38:	d7ed                	beqz	a5,1a22 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a3a:	0005c783          	lbu	a5,0(a1)
    1a3e:	00f50023          	sb	a5,0(a0)
    1a42:	c785                	beqz	a5,1a6a <strcpy+0x6a>
    1a44:	0015c783          	lbu	a5,1(a1)
    1a48:	0505                	addi	a0,a0,1
    1a4a:	0585                	addi	a1,a1,1
    1a4c:	00f50023          	sb	a5,0(a0)
    1a50:	fbf5                	bnez	a5,1a44 <strcpy+0x44>
        ;
    return d;
}
    1a52:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a54:	0505                	addi	a0,a0,1
    1a56:	df45                	beqz	a4,1a0e <strcpy+0xe>
            if (!(*d = *s))
    1a58:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a5c:	0585                	addi	a1,a1,1
    1a5e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a62:	00f50023          	sb	a5,0(a0)
    1a66:	f7fd                	bnez	a5,1a54 <strcpy+0x54>
}
    1a68:	8082                	ret
    1a6a:	8082                	ret

0000000000001a6c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a6c:	00b547b3          	xor	a5,a0,a1
    1a70:	8b9d                	andi	a5,a5,7
    1a72:	1a079863          	bnez	a5,1c22 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a76:	0075f793          	andi	a5,a1,7
    1a7a:	16078463          	beqz	a5,1be2 <strncpy+0x176>
    1a7e:	ea01                	bnez	a2,1a8e <strncpy+0x22>
    1a80:	a421                	j	1c88 <strncpy+0x21c>
    1a82:	167d                	addi	a2,a2,-1
    1a84:	0505                	addi	a0,a0,1
    1a86:	14070e63          	beqz	a4,1be2 <strncpy+0x176>
    1a8a:	1a060863          	beqz	a2,1c3a <strncpy+0x1ce>
    1a8e:	0005c783          	lbu	a5,0(a1)
    1a92:	0585                	addi	a1,a1,1
    1a94:	0075f713          	andi	a4,a1,7
    1a98:	00f50023          	sb	a5,0(a0)
    1a9c:	f3fd                	bnez	a5,1a82 <strncpy+0x16>
    1a9e:	4805                	li	a6,1
    1aa0:	1a061863          	bnez	a2,1c50 <strncpy+0x1e4>
    1aa4:	40a007b3          	neg	a5,a0
    1aa8:	8b9d                	andi	a5,a5,7
    1aaa:	4681                	li	a3,0
    1aac:	18061a63          	bnez	a2,1c40 <strncpy+0x1d4>
    1ab0:	00778713          	addi	a4,a5,7
    1ab4:	45ad                	li	a1,11
    1ab6:	18b76363          	bltu	a4,a1,1c3c <strncpy+0x1d0>
    1aba:	1ae6eb63          	bltu	a3,a4,1c70 <strncpy+0x204>
    1abe:	1a078363          	beqz	a5,1c64 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ac2:	00050023          	sb	zero,0(a0)
    1ac6:	4685                	li	a3,1
    1ac8:	00150713          	addi	a4,a0,1
    1acc:	18d78f63          	beq	a5,a3,1c6a <strncpy+0x1fe>
    1ad0:	000500a3          	sb	zero,1(a0)
    1ad4:	4689                	li	a3,2
    1ad6:	00250713          	addi	a4,a0,2
    1ada:	18d78e63          	beq	a5,a3,1c76 <strncpy+0x20a>
    1ade:	00050123          	sb	zero,2(a0)
    1ae2:	468d                	li	a3,3
    1ae4:	00350713          	addi	a4,a0,3
    1ae8:	16d78c63          	beq	a5,a3,1c60 <strncpy+0x1f4>
    1aec:	000501a3          	sb	zero,3(a0)
    1af0:	4691                	li	a3,4
    1af2:	00450713          	addi	a4,a0,4
    1af6:	18d78263          	beq	a5,a3,1c7a <strncpy+0x20e>
    1afa:	00050223          	sb	zero,4(a0)
    1afe:	4695                	li	a3,5
    1b00:	00550713          	addi	a4,a0,5
    1b04:	16d78d63          	beq	a5,a3,1c7e <strncpy+0x212>
    1b08:	000502a3          	sb	zero,5(a0)
    1b0c:	469d                	li	a3,7
    1b0e:	00650713          	addi	a4,a0,6
    1b12:	16d79863          	bne	a5,a3,1c82 <strncpy+0x216>
    1b16:	00750713          	addi	a4,a0,7
    1b1a:	00050323          	sb	zero,6(a0)
    1b1e:	40f80833          	sub	a6,a6,a5
    1b22:	ff887593          	andi	a1,a6,-8
    1b26:	97aa                	add	a5,a5,a0
    1b28:	95be                	add	a1,a1,a5
    1b2a:	0007b023          	sd	zero,0(a5)
    1b2e:	07a1                	addi	a5,a5,8
    1b30:	feb79de3          	bne	a5,a1,1b2a <strncpy+0xbe>
    1b34:	ff887593          	andi	a1,a6,-8
    1b38:	9ead                	addw	a3,a3,a1
    1b3a:	00b707b3          	add	a5,a4,a1
    1b3e:	12b80863          	beq	a6,a1,1c6e <strncpy+0x202>
    1b42:	00078023          	sb	zero,0(a5)
    1b46:	0016871b          	addiw	a4,a3,1
    1b4a:	0ec77863          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b4e:	000780a3          	sb	zero,1(a5)
    1b52:	0026871b          	addiw	a4,a3,2
    1b56:	0ec77263          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b5a:	00078123          	sb	zero,2(a5)
    1b5e:	0036871b          	addiw	a4,a3,3
    1b62:	0cc77c63          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b66:	000781a3          	sb	zero,3(a5)
    1b6a:	0046871b          	addiw	a4,a3,4
    1b6e:	0cc77663          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b72:	00078223          	sb	zero,4(a5)
    1b76:	0056871b          	addiw	a4,a3,5
    1b7a:	0cc77063          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b7e:	000782a3          	sb	zero,5(a5)
    1b82:	0066871b          	addiw	a4,a3,6
    1b86:	0ac77a63          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b8a:	00078323          	sb	zero,6(a5)
    1b8e:	0076871b          	addiw	a4,a3,7
    1b92:	0ac77463          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1b96:	000783a3          	sb	zero,7(a5)
    1b9a:	0086871b          	addiw	a4,a3,8
    1b9e:	08c77e63          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1ba2:	00078423          	sb	zero,8(a5)
    1ba6:	0096871b          	addiw	a4,a3,9
    1baa:	08c77863          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1bae:	000784a3          	sb	zero,9(a5)
    1bb2:	00a6871b          	addiw	a4,a3,10
    1bb6:	08c77263          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1bba:	00078523          	sb	zero,10(a5)
    1bbe:	00b6871b          	addiw	a4,a3,11
    1bc2:	06c77c63          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1bc6:	000785a3          	sb	zero,11(a5)
    1bca:	00c6871b          	addiw	a4,a3,12
    1bce:	06c77663          	bgeu	a4,a2,1c3a <strncpy+0x1ce>
    1bd2:	00078623          	sb	zero,12(a5)
    1bd6:	26b5                	addiw	a3,a3,13
    1bd8:	06c6f163          	bgeu	a3,a2,1c3a <strncpy+0x1ce>
    1bdc:	000786a3          	sb	zero,13(a5)
    1be0:	8082                	ret
            ;
        if (!n || !*s)
    1be2:	c645                	beqz	a2,1c8a <strncpy+0x21e>
    1be4:	0005c783          	lbu	a5,0(a1)
    1be8:	ea078be3          	beqz	a5,1a9e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bec:	479d                	li	a5,7
    1bee:	02c7ff63          	bgeu	a5,a2,1c2c <strncpy+0x1c0>
    1bf2:	00000897          	auipc	a7,0x0
    1bf6:	3fe8b883          	ld	a7,1022(a7) # 1ff0 <__clone+0xee>
    1bfa:	00000817          	auipc	a6,0x0
    1bfe:	3fe83803          	ld	a6,1022(a6) # 1ff8 <__clone+0xf6>
    1c02:	431d                	li	t1,7
    1c04:	6198                	ld	a4,0(a1)
    1c06:	011707b3          	add	a5,a4,a7
    1c0a:	fff74693          	not	a3,a4
    1c0e:	8ff5                	and	a5,a5,a3
    1c10:	0107f7b3          	and	a5,a5,a6
    1c14:	ef81                	bnez	a5,1c2c <strncpy+0x1c0>
            *wd = *ws;
    1c16:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c18:	1661                	addi	a2,a2,-8
    1c1a:	05a1                	addi	a1,a1,8
    1c1c:	0521                	addi	a0,a0,8
    1c1e:	fec363e3          	bltu	t1,a2,1c04 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c22:	e609                	bnez	a2,1c2c <strncpy+0x1c0>
    1c24:	a08d                	j	1c86 <strncpy+0x21a>
    1c26:	167d                	addi	a2,a2,-1
    1c28:	0505                	addi	a0,a0,1
    1c2a:	ca01                	beqz	a2,1c3a <strncpy+0x1ce>
    1c2c:	0005c783          	lbu	a5,0(a1)
    1c30:	0585                	addi	a1,a1,1
    1c32:	00f50023          	sb	a5,0(a0)
    1c36:	fbe5                	bnez	a5,1c26 <strncpy+0x1ba>
        ;
tail:
    1c38:	b59d                	j	1a9e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c3a:	8082                	ret
    1c3c:	472d                	li	a4,11
    1c3e:	bdb5                	j	1aba <strncpy+0x4e>
    1c40:	00778713          	addi	a4,a5,7
    1c44:	45ad                	li	a1,11
    1c46:	fff60693          	addi	a3,a2,-1
    1c4a:	e6b778e3          	bgeu	a4,a1,1aba <strncpy+0x4e>
    1c4e:	b7fd                	j	1c3c <strncpy+0x1d0>
    1c50:	40a007b3          	neg	a5,a0
    1c54:	8832                	mv	a6,a2
    1c56:	8b9d                	andi	a5,a5,7
    1c58:	4681                	li	a3,0
    1c5a:	e4060be3          	beqz	a2,1ab0 <strncpy+0x44>
    1c5e:	b7cd                	j	1c40 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c60:	468d                	li	a3,3
    1c62:	bd75                	j	1b1e <strncpy+0xb2>
    1c64:	872a                	mv	a4,a0
    1c66:	4681                	li	a3,0
    1c68:	bd5d                	j	1b1e <strncpy+0xb2>
    1c6a:	4685                	li	a3,1
    1c6c:	bd4d                	j	1b1e <strncpy+0xb2>
    1c6e:	8082                	ret
    1c70:	87aa                	mv	a5,a0
    1c72:	4681                	li	a3,0
    1c74:	b5f9                	j	1b42 <strncpy+0xd6>
    1c76:	4689                	li	a3,2
    1c78:	b55d                	j	1b1e <strncpy+0xb2>
    1c7a:	4691                	li	a3,4
    1c7c:	b54d                	j	1b1e <strncpy+0xb2>
    1c7e:	4695                	li	a3,5
    1c80:	bd79                	j	1b1e <strncpy+0xb2>
    1c82:	4699                	li	a3,6
    1c84:	bd69                	j	1b1e <strncpy+0xb2>
    1c86:	8082                	ret
    1c88:	8082                	ret
    1c8a:	8082                	ret

0000000000001c8c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c8c:	87aa                	mv	a5,a0
    1c8e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c90:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c94:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c98:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c9a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c9c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1ca0:	2501                	sext.w	a0,a0
    1ca2:	8082                	ret

0000000000001ca4 <openat>:
    register long a7 __asm__("a7") = n;
    1ca4:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1ca8:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cac:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cb0:	2501                	sext.w	a0,a0
    1cb2:	8082                	ret

0000000000001cb4 <close>:
    register long a7 __asm__("a7") = n;
    1cb4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cb8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cbc:	2501                	sext.w	a0,a0
    1cbe:	8082                	ret

0000000000001cc0 <read>:
    register long a7 __asm__("a7") = n;
    1cc0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cc4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cc8:	8082                	ret

0000000000001cca <write>:
    register long a7 __asm__("a7") = n;
    1cca:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cce:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cd2:	8082                	ret

0000000000001cd4 <getpid>:
    register long a7 __asm__("a7") = n;
    1cd4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cd8:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cdc:	2501                	sext.w	a0,a0
    1cde:	8082                	ret

0000000000001ce0 <getppid>:
    register long a7 __asm__("a7") = n;
    1ce0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ce4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cec:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cf0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <fork>:
    register long a7 __asm__("a7") = n;
    1cf8:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cfc:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cfe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d00:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d08:	85b2                	mv	a1,a2
    1d0a:	863a                	mv	a2,a4
    if (stack)
    1d0c:	c191                	beqz	a1,1d10 <clone+0x8>
	stack += stack_size;
    1d0e:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d10:	4781                	li	a5,0
    1d12:	4701                	li	a4,0
    1d14:	4681                	li	a3,0
    1d16:	2601                	sext.w	a2,a2
    1d18:	a2ed                	j	1f02 <__clone>

0000000000001d1a <exit>:
    register long a7 __asm__("a7") = n;
    1d1a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d1e:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d22:	8082                	ret

0000000000001d24 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d24:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d28:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d2a:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d2e:	2501                	sext.w	a0,a0
    1d30:	8082                	ret

0000000000001d32 <exec>:
    register long a7 __asm__("a7") = n;
    1d32:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d36:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d3a:	2501                	sext.w	a0,a0
    1d3c:	8082                	ret

0000000000001d3e <execve>:
    register long a7 __asm__("a7") = n;
    1d3e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d42:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d46:	2501                	sext.w	a0,a0
    1d48:	8082                	ret

0000000000001d4a <times>:
    register long a7 __asm__("a7") = n;
    1d4a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d4e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d52:	2501                	sext.w	a0,a0
    1d54:	8082                	ret

0000000000001d56 <get_time>:

int64 get_time()
{
    1d56:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d58:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d5c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d5e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d60:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d64:	2501                	sext.w	a0,a0
    1d66:	ed09                	bnez	a0,1d80 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d68:	67a2                	ld	a5,8(sp)
    1d6a:	3e800713          	li	a4,1000
    1d6e:	00015503          	lhu	a0,0(sp)
    1d72:	02e7d7b3          	divu	a5,a5,a4
    1d76:	02e50533          	mul	a0,a0,a4
    1d7a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d7c:	0141                	addi	sp,sp,16
    1d7e:	8082                	ret
        return -1;
    1d80:	557d                	li	a0,-1
    1d82:	bfed                	j	1d7c <get_time+0x26>

0000000000001d84 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d84:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d88:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d8c:	2501                	sext.w	a0,a0
    1d8e:	8082                	ret

0000000000001d90 <time>:
    register long a7 __asm__("a7") = n;
    1d90:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d94:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d98:	2501                	sext.w	a0,a0
    1d9a:	8082                	ret

0000000000001d9c <sleep>:

int sleep(unsigned long long time)
{
    1d9c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d9e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1da0:	850a                	mv	a0,sp
    1da2:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1da4:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1da8:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1daa:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dae:	e501                	bnez	a0,1db6 <sleep+0x1a>
    return 0;
    1db0:	4501                	li	a0,0
}
    1db2:	0141                	addi	sp,sp,16
    1db4:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1db6:	4502                	lw	a0,0(sp)
}
    1db8:	0141                	addi	sp,sp,16
    1dba:	8082                	ret

0000000000001dbc <set_priority>:
    register long a7 __asm__("a7") = n;
    1dbc:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dc0:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dc4:	2501                	sext.w	a0,a0
    1dc6:	8082                	ret

0000000000001dc8 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dc8:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dcc:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dd0:	8082                	ret

0000000000001dd2 <munmap>:
    register long a7 __asm__("a7") = n;
    1dd2:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd6:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dda:	2501                	sext.w	a0,a0
    1ddc:	8082                	ret

0000000000001dde <wait>:

int wait(int *code)
{
    1dde:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1de0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1de4:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1de6:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1de8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dea:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <spawn>:
    register long a7 __asm__("a7") = n;
    1df2:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1df6:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dfa:	2501                	sext.w	a0,a0
    1dfc:	8082                	ret

0000000000001dfe <mailread>:
    register long a7 __asm__("a7") = n;
    1dfe:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e02:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e06:	2501                	sext.w	a0,a0
    1e08:	8082                	ret

0000000000001e0a <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e0a:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e0e:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e12:	2501                	sext.w	a0,a0
    1e14:	8082                	ret

0000000000001e16 <fstat>:
    register long a7 __asm__("a7") = n;
    1e16:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e1a:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e1e:	2501                	sext.w	a0,a0
    1e20:	8082                	ret

0000000000001e22 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e22:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e24:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e28:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e2a:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e32:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e34:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e38:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e3a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e3e:	2501                	sext.w	a0,a0
    1e40:	8082                	ret

0000000000001e42 <link>:

int link(char *old_path, char *new_path)
{
    1e42:	87aa                	mv	a5,a0
    1e44:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e46:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e4a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e4e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e50:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e54:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e56:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e5a:	2501                	sext.w	a0,a0
    1e5c:	8082                	ret

0000000000001e5e <unlink>:

int unlink(char *path)
{
    1e5e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e60:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e64:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e68:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e6e:	2501                	sext.w	a0,a0
    1e70:	8082                	ret

0000000000001e72 <uname>:
    register long a7 __asm__("a7") = n;
    1e72:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e76:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <brk>:
    register long a7 __asm__("a7") = n;
    1e7e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e82:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e8a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e8c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e90:	8082                	ret

0000000000001e92 <chdir>:
    register long a7 __asm__("a7") = n;
    1e92:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e96:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e9e:	862e                	mv	a2,a1
    1ea0:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1ea2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ea4:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1ea8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1eac:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1eae:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb0:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1eb4:	2501                	sext.w	a0,a0
    1eb6:	8082                	ret

0000000000001eb8 <getdents>:
    register long a7 __asm__("a7") = n;
    1eb8:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ebc:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <pipe>:
    register long a7 __asm__("a7") = n;
    1ec4:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ec8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eca:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ece:	2501                	sext.w	a0,a0
    1ed0:	8082                	ret

0000000000001ed2 <dup>:
    register long a7 __asm__("a7") = n;
    1ed2:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ed4:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ed8:	2501                	sext.w	a0,a0
    1eda:	8082                	ret

0000000000001edc <dup2>:
    register long a7 __asm__("a7") = n;
    1edc:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ede:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee0:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ee4:	2501                	sext.w	a0,a0
    1ee6:	8082                	ret

0000000000001ee8 <mount>:
    register long a7 __asm__("a7") = n;
    1ee8:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eec:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ef0:	2501                	sext.w	a0,a0
    1ef2:	8082                	ret

0000000000001ef4 <umount>:
    register long a7 __asm__("a7") = n;
    1ef4:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ef8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1efa:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1efe:	2501                	sext.w	a0,a0
    1f00:	8082                	ret

0000000000001f02 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f02:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f04:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f06:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f08:	8532                	mv	a0,a2
	mv a2, a4
    1f0a:	863a                	mv	a2,a4
	mv a3, a5
    1f0c:	86be                	mv	a3,a5
	mv a4, a6
    1f0e:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f10:	0dc00893          	li	a7,220
	ecall
    1f14:	00000073          	ecall

	beqz a0, 1f
    1f18:	c111                	beqz	a0,1f1c <__clone+0x1a>
	# Parent
	ret
    1f1a:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f1c:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f1e:	6522                	ld	a0,8(sp)
	jalr a1
    1f20:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f22:	05d00893          	li	a7,93
	ecall
    1f26:	00000073          	ecall
