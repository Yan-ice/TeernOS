
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/wait:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0e1                	j	10ca <__start_main>

0000000000001004 <test_wait>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

void test_wait(void){
    1004:	7179                	addi	sp,sp,-48
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0250513          	addi	a0,a0,-254 # 1f08 <__clone+0x2a>
void test_wait(void){
    100e:	f406                	sd	ra,40(sp)
    1010:	f022                	sd	s0,32(sp)
    1012:	ec26                	sd	s1,24(sp)
    TEST_START(__func__);
    1014:	2ee000ef          	jal	ra,1302 <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	fc050513          	addi	a0,a0,-64 # 1fd8 <__func__.1166>
    1020:	2e2000ef          	jal	ra,1302 <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	efc50513          	addi	a0,a0,-260 # 1f20 <__clone+0x42>
    102c:	2d6000ef          	jal	ra,1302 <puts>
    int cpid, wstatus;
    cpid = fork();
    1030:	4a5000ef          	jal	ra,1cd4 <fork>
    if(cpid == 0){
    1034:	e129                	bnez	a0,1076 <test_wait+0x72>
	printf("This is child process\n");
    1036:	00001517          	auipc	a0,0x1
    103a:	efa50513          	addi	a0,a0,-262 # 1f30 <__clone+0x52>
    103e:	2e6000ef          	jal	ra,1324 <printf>
        exit(0);
    1042:	4501                	li	a0,0
    1044:	4b3000ef          	jal	ra,1cf6 <exit>
	if(ret == cpid)
	    printf("wait child success.\nwstatus: %d\n", wstatus);
	else
	    printf("wait child error.\n");
    }
    TEST_END(__func__);
    1048:	00001517          	auipc	a0,0x1
    104c:	f6050513          	addi	a0,a0,-160 # 1fa8 <__clone+0xca>
    1050:	2b2000ef          	jal	ra,1302 <puts>
    1054:	00001517          	auipc	a0,0x1
    1058:	f8450513          	addi	a0,a0,-124 # 1fd8 <__func__.1166>
    105c:	2a6000ef          	jal	ra,1302 <puts>
    1060:	00001517          	auipc	a0,0x1
    1064:	ec050513          	addi	a0,a0,-320 # 1f20 <__clone+0x42>
    1068:	29a000ef          	jal	ra,1302 <puts>
}
    106c:	70a2                	ld	ra,40(sp)
    106e:	7402                	ld	s0,32(sp)
    1070:	64e2                	ld	s1,24(sp)
    1072:	6145                	addi	sp,sp,48
    1074:	8082                	ret
	pid_t ret = wait(&wstatus);
    1076:	842a                	mv	s0,a0
    1078:	0068                	addi	a0,sp,12
    107a:	541000ef          	jal	ra,1dba <wait>
	assert(ret != -1);
    107e:	57fd                	li	a5,-1
	pid_t ret = wait(&wstatus);
    1080:	84aa                	mv	s1,a0
	assert(ret != -1);
    1082:	02f50363          	beq	a0,a5,10a8 <test_wait+0xa4>
	if(ret == cpid)
    1086:	00940963          	beq	s0,s1,1098 <test_wait+0x94>
	    printf("wait child error.\n");
    108a:	00001517          	auipc	a0,0x1
    108e:	f0650513          	addi	a0,a0,-250 # 1f90 <__clone+0xb2>
    1092:	292000ef          	jal	ra,1324 <printf>
    1096:	bf4d                	j	1048 <test_wait+0x44>
	    printf("wait child success.\nwstatus: %d\n", wstatus);
    1098:	45b2                	lw	a1,12(sp)
    109a:	00001517          	auipc	a0,0x1
    109e:	ece50513          	addi	a0,a0,-306 # 1f68 <__clone+0x8a>
    10a2:	282000ef          	jal	ra,1324 <printf>
    10a6:	b74d                	j	1048 <test_wait+0x44>
	assert(ret != -1);
    10a8:	00001517          	auipc	a0,0x1
    10ac:	ea050513          	addi	a0,a0,-352 # 1f48 <__clone+0x6a>
    10b0:	534000ef          	jal	ra,15e4 <panic>
	if(ret == cpid)
    10b4:	fc941be3          	bne	s0,s1,108a <test_wait+0x86>
    10b8:	b7c5                	j	1098 <test_wait+0x94>

00000000000010ba <main>:

int main(void){
    10ba:	1141                	addi	sp,sp,-16
    10bc:	e406                	sd	ra,8(sp)
    test_wait();
    10be:	f47ff0ef          	jal	ra,1004 <test_wait>
    return 0;
}
    10c2:	60a2                	ld	ra,8(sp)
    10c4:	4501                	li	a0,0
    10c6:	0141                	addi	sp,sp,16
    10c8:	8082                	ret

00000000000010ca <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ca:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10cc:	4108                	lw	a0,0(a0)
{
    10ce:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10d0:	05a1                	addi	a1,a1,8
{
    10d2:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10d4:	fe7ff0ef          	jal	ra,10ba <main>
    10d8:	41f000ef          	jal	ra,1cf6 <exit>
	return 0;
}
    10dc:	60a2                	ld	ra,8(sp)
    10de:	4501                	li	a0,0
    10e0:	0141                	addi	sp,sp,16
    10e2:	8082                	ret

00000000000010e4 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10e4:	7179                	addi	sp,sp,-48
    10e6:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10e8:	12054b63          	bltz	a0,121e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ec:	02b577bb          	remuw	a5,a0,a1
    10f0:	00001697          	auipc	a3,0x1
    10f4:	ef868693          	addi	a3,a3,-264 # 1fe8 <digits>
    buf[16] = 0;
    10f8:	00010c23          	sb	zero,24(sp)
    i = 15;
    10fc:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1100:	1782                	slli	a5,a5,0x20
    1102:	9381                	srli	a5,a5,0x20
    1104:	97b6                	add	a5,a5,a3
    1106:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110a:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    110e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1112:	16b56263          	bltu	a0,a1,1276 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    1116:	02e8763b          	remuw	a2,a6,a4
    111a:	1602                	slli	a2,a2,0x20
    111c:	9201                	srli	a2,a2,0x20
    111e:	9636                	add	a2,a2,a3
    1120:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1124:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1128:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    112c:	12e86963          	bltu	a6,a4,125e <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1130:	02e5f63b          	remuw	a2,a1,a4
    1134:	1602                	slli	a2,a2,0x20
    1136:	9201                	srli	a2,a2,0x20
    1138:	9636                	add	a2,a2,a3
    113a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    113e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1142:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1146:	10e5ef63          	bltu	a1,a4,1264 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    114a:	02e8763b          	remuw	a2,a6,a4
    114e:	1602                	slli	a2,a2,0x20
    1150:	9201                	srli	a2,a2,0x20
    1152:	9636                	add	a2,a2,a3
    1154:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1158:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    115c:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1160:	10e86563          	bltu	a6,a4,126a <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1164:	02e5f63b          	remuw	a2,a1,a4
    1168:	1602                	slli	a2,a2,0x20
    116a:	9201                	srli	a2,a2,0x20
    116c:	9636                	add	a2,a2,a3
    116e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1172:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1176:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    117a:	0ee5eb63          	bltu	a1,a4,1270 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    117e:	02e8763b          	remuw	a2,a6,a4
    1182:	1602                	slli	a2,a2,0x20
    1184:	9201                	srli	a2,a2,0x20
    1186:	9636                	add	a2,a2,a3
    1188:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    118c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1190:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1194:	0ce86263          	bltu	a6,a4,1258 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1198:	02e5f63b          	remuw	a2,a1,a4
    119c:	1602                	slli	a2,a2,0x20
    119e:	9201                	srli	a2,a2,0x20
    11a0:	9636                	add	a2,a2,a3
    11a2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11aa:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11ae:	0ce5e663          	bltu	a1,a4,127a <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11b2:	02e8763b          	remuw	a2,a6,a4
    11b6:	1602                	slli	a2,a2,0x20
    11b8:	9201                	srli	a2,a2,0x20
    11ba:	9636                	add	a2,a2,a3
    11bc:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11c0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11c4:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11c8:	0ae86c63          	bltu	a6,a4,1280 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11cc:	02e5f63b          	remuw	a2,a1,a4
    11d0:	1602                	slli	a2,a2,0x20
    11d2:	9201                	srli	a2,a2,0x20
    11d4:	9636                	add	a2,a2,a3
    11d6:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11da:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11de:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11e2:	0ae5e263          	bltu	a1,a4,1286 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11e6:	1782                	slli	a5,a5,0x20
    11e8:	9381                	srli	a5,a5,0x20
    11ea:	97b6                	add	a5,a5,a3
    11ec:	0007c703          	lbu	a4,0(a5)
    11f0:	4599                	li	a1,6
    11f2:	4795                	li	a5,5
    11f4:	00e10723          	sb	a4,14(sp)

    if (sign)
    11f8:	00055963          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    11fc:	1018                	addi	a4,sp,32
    11fe:	973e                	add	a4,a4,a5
    1200:	02d00693          	li	a3,45
    1204:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    1208:	85be                	mv	a1,a5
    write(f, s, l);
    120a:	003c                	addi	a5,sp,8
    120c:	4641                	li	a2,16
    120e:	9e0d                	subw	a2,a2,a1
    1210:	4505                	li	a0,1
    1212:	95be                	add	a1,a1,a5
    1214:	293000ef          	jal	ra,1ca6 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1218:	70a2                	ld	ra,40(sp)
    121a:	6145                	addi	sp,sp,48
    121c:	8082                	ret
        x = -xx;
    121e:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1222:	02b677bb          	remuw	a5,a2,a1
    1226:	00001697          	auipc	a3,0x1
    122a:	dc268693          	addi	a3,a3,-574 # 1fe8 <digits>
    buf[16] = 0;
    122e:	00010c23          	sb	zero,24(sp)
    i = 15;
    1232:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1236:	1782                	slli	a5,a5,0x20
    1238:	9381                	srli	a5,a5,0x20
    123a:	97b6                	add	a5,a5,a3
    123c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1240:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1244:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1248:	ecb677e3          	bgeu	a2,a1,1116 <printint.constprop.0+0x32>
        buf[i--] = '-';
    124c:	02d00793          	li	a5,45
    1250:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1254:	45b9                	li	a1,14
    1256:	bf55                	j	120a <printint.constprop.0+0x126>
    1258:	47a5                	li	a5,9
    125a:	45a9                	li	a1,10
    125c:	bf71                	j	11f8 <printint.constprop.0+0x114>
    125e:	47b5                	li	a5,13
    1260:	45b9                	li	a1,14
    1262:	bf59                	j	11f8 <printint.constprop.0+0x114>
    1264:	47b1                	li	a5,12
    1266:	45b5                	li	a1,13
    1268:	bf41                	j	11f8 <printint.constprop.0+0x114>
    126a:	47ad                	li	a5,11
    126c:	45b1                	li	a1,12
    126e:	b769                	j	11f8 <printint.constprop.0+0x114>
    1270:	47a9                	li	a5,10
    1272:	45ad                	li	a1,11
    1274:	b751                	j	11f8 <printint.constprop.0+0x114>
    i = 15;
    1276:	45bd                	li	a1,15
    1278:	bf49                	j	120a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    127a:	47a1                	li	a5,8
    127c:	45a5                	li	a1,9
    127e:	bfad                	j	11f8 <printint.constprop.0+0x114>
    1280:	479d                	li	a5,7
    1282:	45a1                	li	a1,8
    1284:	bf95                	j	11f8 <printint.constprop.0+0x114>
    1286:	4799                	li	a5,6
    1288:	459d                	li	a1,7
    128a:	b7bd                	j	11f8 <printint.constprop.0+0x114>

000000000000128c <getchar>:
{
    128c:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    128e:	00f10593          	addi	a1,sp,15
    1292:	4605                	li	a2,1
    1294:	4501                	li	a0,0
{
    1296:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1298:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    129c:	201000ef          	jal	ra,1c9c <read>
}
    12a0:	60e2                	ld	ra,24(sp)
    12a2:	00f14503          	lbu	a0,15(sp)
    12a6:	6105                	addi	sp,sp,32
    12a8:	8082                	ret

00000000000012aa <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12aa:	00001797          	auipc	a5,0x1
    12ae:	d5678793          	addi	a5,a5,-682 # 2000 <digits+0x18>
    12b2:	04000893          	li	a7,64
    12b6:	4505                	li	a0,1
    12b8:	85be                	mv	a1,a5
    12ba:	4611                	li	a2,4
    12bc:	00000073          	ecall
}
    12c0:	4501                	li	a0,0
    12c2:	8082                	ret

00000000000012c4 <putchar>:
{
    12c4:	1101                	addi	sp,sp,-32
    12c6:	ec06                	sd	ra,24(sp)
    12c8:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12ca:	3e700893          	li	a7,999
    12ce:	4505                	li	a0,1
    12d0:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12d4:	00001717          	auipc	a4,0x1
    12d8:	d2c70713          	addi	a4,a4,-724 # 2000 <digits+0x18>
    12dc:	04000893          	li	a7,64
    12e0:	4505                	li	a0,1
    12e2:	85ba                	mv	a1,a4
    12e4:	4611                	li	a2,4
    12e6:	00000073          	ecall
    return write(stdout, &byte, 1);
    12ea:	4605                	li	a2,1
    12ec:	00f10593          	addi	a1,sp,15
    12f0:	4505                	li	a0,1
    char byte = c;
    12f2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12f6:	1b1000ef          	jal	ra,1ca6 <write>
}
    12fa:	60e2                	ld	ra,24(sp)
    12fc:	2501                	sext.w	a0,a0
    12fe:	6105                	addi	sp,sp,32
    1300:	8082                	ret

0000000000001302 <puts>:
{
    1302:	1141                	addi	sp,sp,-16
    1304:	e406                	sd	ra,8(sp)
    1306:	e022                	sd	s0,0(sp)
    1308:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    130a:	5b8000ef          	jal	ra,18c2 <strlen>
    130e:	862a                	mv	a2,a0
    1310:	85a2                	mv	a1,s0
    1312:	4505                	li	a0,1
    1314:	193000ef          	jal	ra,1ca6 <write>
}
    1318:	60a2                	ld	ra,8(sp)
    131a:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    131c:	957d                	srai	a0,a0,0x3f
    return r;
    131e:	2501                	sext.w	a0,a0
}
    1320:	0141                	addi	sp,sp,16
    1322:	8082                	ret

0000000000001324 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1324:	7171                	addi	sp,sp,-176
    1326:	e0d2                	sd	s4,64(sp)
    1328:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    132a:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    132c:	18bc                	addi	a5,sp,120
{
    132e:	e8ca                	sd	s2,80(sp)
    1330:	e4ce                	sd	s3,72(sp)
    1332:	fc56                	sd	s5,56(sp)
    1334:	f85a                	sd	s6,48(sp)
    1336:	f486                	sd	ra,104(sp)
    1338:	f0a2                	sd	s0,96(sp)
    133a:	eca6                	sd	s1,88(sp)
    133c:	fcae                	sd	a1,120(sp)
    133e:	e132                	sd	a2,128(sp)
    1340:	e536                	sd	a3,136(sp)
    1342:	e93a                	sd	a4,144(sp)
    1344:	f142                	sd	a6,160(sp)
    1346:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1348:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    134a:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    134e:	00001b17          	auipc	s6,0x1
    1352:	c6ab0b13          	addi	s6,s6,-918 # 1fb8 <__clone+0xda>
	::"r"((unsigned long long)ac)
    1356:	00001a97          	auipc	s5,0x1
    135a:	caaa8a93          	addi	s5,s5,-854 # 2000 <digits+0x18>
    buf[i++] = '0';
    135e:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1362:	00001997          	auipc	s3,0x1
    1366:	c8698993          	addi	s3,s3,-890 # 1fe8 <digits>
        if (!*s)
    136a:	00054783          	lbu	a5,0(a0)
    136e:	16078c63          	beqz	a5,14e6 <printf+0x1c2>
    1372:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1374:	19278363          	beq	a5,s2,14fa <printf+0x1d6>
    1378:	00164783          	lbu	a5,1(a2)
    137c:	0605                	addi	a2,a2,1
    137e:	fbfd                	bnez	a5,1374 <printf+0x50>
    1380:	84b2                	mv	s1,a2
        l = z - a;
    1382:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1386:	85aa                	mv	a1,a0
    1388:	8622                	mv	a2,s0
    138a:	4505                	li	a0,1
    138c:	11b000ef          	jal	ra,1ca6 <write>
        if (l)
    1390:	18041e63          	bnez	s0,152c <printf+0x208>
        if (s[1] == 0)
    1394:	0014c783          	lbu	a5,1(s1)
    1398:	14078763          	beqz	a5,14e6 <printf+0x1c2>
        switch (s[1])
    139c:	07300713          	li	a4,115
    13a0:	1ce78063          	beq	a5,a4,1560 <printf+0x23c>
    13a4:	18f76663          	bltu	a4,a5,1530 <printf+0x20c>
    13a8:	06400713          	li	a4,100
    13ac:	1ae78063          	beq	a5,a4,154c <printf+0x228>
    13b0:	07000713          	li	a4,112
    13b4:	1ce79963          	bne	a5,a4,1586 <printf+0x262>
            printptr(va_arg(ap, uint64));
    13b8:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ba:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13be:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13c0:	631c                	ld	a5,0(a4)
    13c2:	0721                	addi	a4,a4,8
    13c4:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13c6:	00479293          	slli	t0,a5,0x4
    13ca:	00879f93          	slli	t6,a5,0x8
    13ce:	00c79f13          	slli	t5,a5,0xc
    13d2:	01079e93          	slli	t4,a5,0x10
    13d6:	01479e13          	slli	t3,a5,0x14
    13da:	01879313          	slli	t1,a5,0x18
    13de:	01c79893          	slli	a7,a5,0x1c
    13e2:	02479813          	slli	a6,a5,0x24
    13e6:	02879513          	slli	a0,a5,0x28
    13ea:	02c79593          	slli	a1,a5,0x2c
    13ee:	03079693          	slli	a3,a5,0x30
    13f2:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f6:	03c7d413          	srli	s0,a5,0x3c
    13fa:	01c7d39b          	srliw	t2,a5,0x1c
    13fe:	03c2d293          	srli	t0,t0,0x3c
    1402:	03cfdf93          	srli	t6,t6,0x3c
    1406:	03cf5f13          	srli	t5,t5,0x3c
    140a:	03cede93          	srli	t4,t4,0x3c
    140e:	03ce5e13          	srli	t3,t3,0x3c
    1412:	03c35313          	srli	t1,t1,0x3c
    1416:	03c8d893          	srli	a7,a7,0x3c
    141a:	03c85813          	srli	a6,a6,0x3c
    141e:	9171                	srli	a0,a0,0x3c
    1420:	91f1                	srli	a1,a1,0x3c
    1422:	92f1                	srli	a3,a3,0x3c
    1424:	9371                	srli	a4,a4,0x3c
    1426:	96ce                	add	a3,a3,s3
    1428:	974e                	add	a4,a4,s3
    142a:	944e                	add	s0,s0,s3
    142c:	92ce                	add	t0,t0,s3
    142e:	9fce                	add	t6,t6,s3
    1430:	9f4e                	add	t5,t5,s3
    1432:	9ece                	add	t4,t4,s3
    1434:	9e4e                	add	t3,t3,s3
    1436:	934e                	add	t1,t1,s3
    1438:	98ce                	add	a7,a7,s3
    143a:	93ce                	add	t2,t2,s3
    143c:	984e                	add	a6,a6,s3
    143e:	954e                	add	a0,a0,s3
    1440:	95ce                	add	a1,a1,s3
    1442:	0006c083          	lbu	ra,0(a3)
    1446:	0002c283          	lbu	t0,0(t0)
    144a:	00074683          	lbu	a3,0(a4)
    144e:	000fcf83          	lbu	t6,0(t6)
    1452:	000f4f03          	lbu	t5,0(t5)
    1456:	000ece83          	lbu	t4,0(t4)
    145a:	000e4e03          	lbu	t3,0(t3)
    145e:	00034303          	lbu	t1,0(t1)
    1462:	0008c883          	lbu	a7,0(a7)
    1466:	0003c383          	lbu	t2,0(t2)
    146a:	00084803          	lbu	a6,0(a6)
    146e:	00054503          	lbu	a0,0(a0)
    1472:	0005c583          	lbu	a1,0(a1)
    1476:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    147a:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    147e:	9371                	srli	a4,a4,0x3c
    1480:	8bbd                	andi	a5,a5,15
    1482:	974e                	add	a4,a4,s3
    1484:	97ce                	add	a5,a5,s3
    1486:	005105a3          	sb	t0,11(sp)
    148a:	01f10623          	sb	t6,12(sp)
    148e:	01e106a3          	sb	t5,13(sp)
    1492:	01d10723          	sb	t4,14(sp)
    1496:	01c107a3          	sb	t3,15(sp)
    149a:	00610823          	sb	t1,16(sp)
    149e:	011108a3          	sb	a7,17(sp)
    14a2:	00710923          	sb	t2,18(sp)
    14a6:	010109a3          	sb	a6,19(sp)
    14aa:	00a10a23          	sb	a0,20(sp)
    14ae:	00b10aa3          	sb	a1,21(sp)
    14b2:	00110b23          	sb	ra,22(sp)
    14b6:	00d10ba3          	sb	a3,23(sp)
    14ba:	00810523          	sb	s0,10(sp)
    14be:	00074703          	lbu	a4,0(a4)
    14c2:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14c6:	002c                	addi	a1,sp,8
    14c8:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ca:	00e10c23          	sb	a4,24(sp)
    14ce:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14d2:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14d6:	7d0000ef          	jal	ra,1ca6 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14da:	00248513          	addi	a0,s1,2
        if (!*s)
    14de:	00054783          	lbu	a5,0(a0)
    14e2:	e80798e3          	bnez	a5,1372 <printf+0x4e>
    }
    va_end(ap);
}
    14e6:	70a6                	ld	ra,104(sp)
    14e8:	7406                	ld	s0,96(sp)
    14ea:	64e6                	ld	s1,88(sp)
    14ec:	6946                	ld	s2,80(sp)
    14ee:	69a6                	ld	s3,72(sp)
    14f0:	6a06                	ld	s4,64(sp)
    14f2:	7ae2                	ld	s5,56(sp)
    14f4:	7b42                	ld	s6,48(sp)
    14f6:	614d                	addi	sp,sp,176
    14f8:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14fa:	00064783          	lbu	a5,0(a2)
    14fe:	84b2                	mv	s1,a2
    1500:	01278963          	beq	a5,s2,1512 <printf+0x1ee>
    1504:	bdbd                	j	1382 <printf+0x5e>
    1506:	0024c783          	lbu	a5,2(s1)
    150a:	0605                	addi	a2,a2,1
    150c:	0489                	addi	s1,s1,2
    150e:	e7279ae3          	bne	a5,s2,1382 <printf+0x5e>
    1512:	0014c783          	lbu	a5,1(s1)
    1516:	ff2788e3          	beq	a5,s2,1506 <printf+0x1e2>
        l = z - a;
    151a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    151e:	85aa                	mv	a1,a0
    1520:	8622                	mv	a2,s0
    1522:	4505                	li	a0,1
    1524:	782000ef          	jal	ra,1ca6 <write>
        if (l)
    1528:	e60406e3          	beqz	s0,1394 <printf+0x70>
    152c:	8526                	mv	a0,s1
    152e:	bd35                	j	136a <printf+0x46>
        switch (s[1])
    1530:	07800713          	li	a4,120
    1534:	04e79963          	bne	a5,a4,1586 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1538:	6782                	ld	a5,0(sp)
    153a:	45c1                	li	a1,16
    153c:	4388                	lw	a0,0(a5)
    153e:	07a1                	addi	a5,a5,8
    1540:	e03e                	sd	a5,0(sp)
    1542:	ba3ff0ef          	jal	ra,10e4 <printint.constprop.0>
        s += 2;
    1546:	00248513          	addi	a0,s1,2
    154a:	bf51                	j	14de <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    154c:	6782                	ld	a5,0(sp)
    154e:	45a9                	li	a1,10
    1550:	4388                	lw	a0,0(a5)
    1552:	07a1                	addi	a5,a5,8
    1554:	e03e                	sd	a5,0(sp)
    1556:	b8fff0ef          	jal	ra,10e4 <printint.constprop.0>
        s += 2;
    155a:	00248513          	addi	a0,s1,2
    155e:	b741                	j	14de <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1560:	6782                	ld	a5,0(sp)
    1562:	6380                	ld	s0,0(a5)
    1564:	07a1                	addi	a5,a5,8
    1566:	e03e                	sd	a5,0(sp)
    1568:	cc25                	beqz	s0,15e0 <printf+0x2bc>
            l = strnlen(a, 200);
    156a:	0c800593          	li	a1,200
    156e:	8522                	mv	a0,s0
    1570:	43e000ef          	jal	ra,19ae <strnlen>
    write(f, s, l);
    1574:	0005061b          	sext.w	a2,a0
    1578:	85a2                	mv	a1,s0
    157a:	4505                	li	a0,1
    157c:	72a000ef          	jal	ra,1ca6 <write>
        s += 2;
    1580:	00248513          	addi	a0,s1,2
    1584:	bfa9                	j	14de <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1586:	3e700893          	li	a7,999
    158a:	4505                	li	a0,1
    158c:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1590:	04000893          	li	a7,64
    1594:	4505                	li	a0,1
    1596:	85d6                	mv	a1,s5
    1598:	4611                	li	a2,4
    159a:	00000073          	ecall
    char byte = c;
    159e:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    15a2:	4605                	li	a2,1
    15a4:	002c                	addi	a1,sp,8
    15a6:	4505                	li	a0,1
    char byte = c;
    15a8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ac:	6fa000ef          	jal	ra,1ca6 <write>
            putchar(s[1]);
    15b0:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15b4:	3e700893          	li	a7,999
    15b8:	4505                	li	a0,1
    15ba:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15be:	04000893          	li	a7,64
    15c2:	4505                	li	a0,1
    15c4:	85d6                	mv	a1,s5
    15c6:	4611                	li	a2,4
    15c8:	00000073          	ecall
    return write(stdout, &byte, 1);
    15cc:	4605                	li	a2,1
    15ce:	002c                	addi	a1,sp,8
    15d0:	4505                	li	a0,1
    char byte = c;
    15d2:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15d6:	6d0000ef          	jal	ra,1ca6 <write>
        s += 2;
    15da:	00248513          	addi	a0,s1,2
    15de:	b701                	j	14de <printf+0x1ba>
                a = "(null)";
    15e0:	845a                	mv	s0,s6
    15e2:	b761                	j	156a <printf+0x246>

00000000000015e4 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15e4:	1141                	addi	sp,sp,-16
    15e6:	e406                	sd	ra,8(sp)
    puts(m);
    15e8:	d1bff0ef          	jal	ra,1302 <puts>
    exit(-100);
}
    15ec:	60a2                	ld	ra,8(sp)
    exit(-100);
    15ee:	f9c00513          	li	a0,-100
}
    15f2:	0141                	addi	sp,sp,16
    exit(-100);
    15f4:	a709                	j	1cf6 <exit>

00000000000015f6 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f6:	02000793          	li	a5,32
    15fa:	00f50663          	beq	a0,a5,1606 <isspace+0x10>
    15fe:	355d                	addiw	a0,a0,-9
    1600:	00553513          	sltiu	a0,a0,5
    1604:	8082                	ret
    1606:	4505                	li	a0,1
}
    1608:	8082                	ret

000000000000160a <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    160a:	fd05051b          	addiw	a0,a0,-48
}
    160e:	00a53513          	sltiu	a0,a0,10
    1612:	8082                	ret

0000000000001614 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1614:	02000613          	li	a2,32
    1618:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    161a:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    161e:	ff77069b          	addiw	a3,a4,-9
    1622:	04c70d63          	beq	a4,a2,167c <atoi+0x68>
    1626:	0007079b          	sext.w	a5,a4
    162a:	04d5f963          	bgeu	a1,a3,167c <atoi+0x68>
        s++;
    switch (*s)
    162e:	02b00693          	li	a3,43
    1632:	04d70a63          	beq	a4,a3,1686 <atoi+0x72>
    1636:	02d00693          	li	a3,45
    163a:	06d70463          	beq	a4,a3,16a2 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    163e:	fd07859b          	addiw	a1,a5,-48
    1642:	4625                	li	a2,9
    1644:	873e                	mv	a4,a5
    1646:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1648:	4e01                	li	t3,0
    while (isdigit(*s))
    164a:	04b66a63          	bltu	a2,a1,169e <atoi+0x8a>
    int n = 0, neg = 0;
    164e:	4501                	li	a0,0
    while (isdigit(*s))
    1650:	4825                	li	a6,9
    1652:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1656:	0025179b          	slliw	a5,a0,0x2
    165a:	9d3d                	addw	a0,a0,a5
    165c:	fd07031b          	addiw	t1,a4,-48
    1660:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1664:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1668:	0685                	addi	a3,a3,1
    166a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    166e:	0006071b          	sext.w	a4,a2
    1672:	feb870e3          	bgeu	a6,a1,1652 <atoi+0x3e>
    return neg ? n : -n;
    1676:	000e0563          	beqz	t3,1680 <atoi+0x6c>
}
    167a:	8082                	ret
        s++;
    167c:	0505                	addi	a0,a0,1
    167e:	bf71                	j	161a <atoi+0x6>
    1680:	4113053b          	subw	a0,t1,a7
    1684:	8082                	ret
    while (isdigit(*s))
    1686:	00154783          	lbu	a5,1(a0)
    168a:	4625                	li	a2,9
        s++;
    168c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1690:	fd07859b          	addiw	a1,a5,-48
    1694:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1698:	4e01                	li	t3,0
    while (isdigit(*s))
    169a:	fab67ae3          	bgeu	a2,a1,164e <atoi+0x3a>
    169e:	4501                	li	a0,0
}
    16a0:	8082                	ret
    while (isdigit(*s))
    16a2:	00154783          	lbu	a5,1(a0)
    16a6:	4625                	li	a2,9
        s++;
    16a8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16ac:	fd07859b          	addiw	a1,a5,-48
    16b0:	0007871b          	sext.w	a4,a5
    16b4:	feb665e3          	bltu	a2,a1,169e <atoi+0x8a>
        neg = 1;
    16b8:	4e05                	li	t3,1
    16ba:	bf51                	j	164e <atoi+0x3a>

00000000000016bc <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16bc:	16060d63          	beqz	a2,1836 <memset+0x17a>
    16c0:	40a007b3          	neg	a5,a0
    16c4:	8b9d                	andi	a5,a5,7
    16c6:	00778713          	addi	a4,a5,7
    16ca:	482d                	li	a6,11
    16cc:	0ff5f593          	zext.b	a1,a1
    16d0:	fff60693          	addi	a3,a2,-1
    16d4:	17076263          	bltu	a4,a6,1838 <memset+0x17c>
    16d8:	16e6ea63          	bltu	a3,a4,184c <memset+0x190>
    16dc:	16078563          	beqz	a5,1846 <memset+0x18a>
    16e0:	00b50023          	sb	a1,0(a0)
    16e4:	4705                	li	a4,1
    16e6:	00150e93          	addi	t4,a0,1
    16ea:	14e78c63          	beq	a5,a4,1842 <memset+0x186>
    16ee:	00b500a3          	sb	a1,1(a0)
    16f2:	4709                	li	a4,2
    16f4:	00250e93          	addi	t4,a0,2
    16f8:	14e78d63          	beq	a5,a4,1852 <memset+0x196>
    16fc:	00b50123          	sb	a1,2(a0)
    1700:	470d                	li	a4,3
    1702:	00350e93          	addi	t4,a0,3
    1706:	12e78b63          	beq	a5,a4,183c <memset+0x180>
    170a:	00b501a3          	sb	a1,3(a0)
    170e:	4711                	li	a4,4
    1710:	00450e93          	addi	t4,a0,4
    1714:	14e78163          	beq	a5,a4,1856 <memset+0x19a>
    1718:	00b50223          	sb	a1,4(a0)
    171c:	4715                	li	a4,5
    171e:	00550e93          	addi	t4,a0,5
    1722:	12e78c63          	beq	a5,a4,185a <memset+0x19e>
    1726:	00b502a3          	sb	a1,5(a0)
    172a:	471d                	li	a4,7
    172c:	00650e93          	addi	t4,a0,6
    1730:	12e79763          	bne	a5,a4,185e <memset+0x1a2>
    1734:	00750e93          	addi	t4,a0,7
    1738:	00b50323          	sb	a1,6(a0)
    173c:	4f1d                	li	t5,7
    173e:	00859713          	slli	a4,a1,0x8
    1742:	8f4d                	or	a4,a4,a1
    1744:	01059e13          	slli	t3,a1,0x10
    1748:	01c76e33          	or	t3,a4,t3
    174c:	01859313          	slli	t1,a1,0x18
    1750:	006e6333          	or	t1,t3,t1
    1754:	02059893          	slli	a7,a1,0x20
    1758:	011368b3          	or	a7,t1,a7
    175c:	02859813          	slli	a6,a1,0x28
    1760:	40f60333          	sub	t1,a2,a5
    1764:	0108e833          	or	a6,a7,a6
    1768:	03059693          	slli	a3,a1,0x30
    176c:	00d866b3          	or	a3,a6,a3
    1770:	03859713          	slli	a4,a1,0x38
    1774:	97aa                	add	a5,a5,a0
    1776:	ff837813          	andi	a6,t1,-8
    177a:	8f55                	or	a4,a4,a3
    177c:	00f806b3          	add	a3,a6,a5
    1780:	e398                	sd	a4,0(a5)
    1782:	07a1                	addi	a5,a5,8
    1784:	fed79ee3          	bne	a5,a3,1780 <memset+0xc4>
    1788:	ff837693          	andi	a3,t1,-8
    178c:	00de87b3          	add	a5,t4,a3
    1790:	01e6873b          	addw	a4,a3,t5
    1794:	0ad30663          	beq	t1,a3,1840 <memset+0x184>
    1798:	00b78023          	sb	a1,0(a5)
    179c:	0017069b          	addiw	a3,a4,1
    17a0:	08c6fb63          	bgeu	a3,a2,1836 <memset+0x17a>
    17a4:	00b780a3          	sb	a1,1(a5)
    17a8:	0027069b          	addiw	a3,a4,2
    17ac:	08c6f563          	bgeu	a3,a2,1836 <memset+0x17a>
    17b0:	00b78123          	sb	a1,2(a5)
    17b4:	0037069b          	addiw	a3,a4,3
    17b8:	06c6ff63          	bgeu	a3,a2,1836 <memset+0x17a>
    17bc:	00b781a3          	sb	a1,3(a5)
    17c0:	0047069b          	addiw	a3,a4,4
    17c4:	06c6f963          	bgeu	a3,a2,1836 <memset+0x17a>
    17c8:	00b78223          	sb	a1,4(a5)
    17cc:	0057069b          	addiw	a3,a4,5
    17d0:	06c6f363          	bgeu	a3,a2,1836 <memset+0x17a>
    17d4:	00b782a3          	sb	a1,5(a5)
    17d8:	0067069b          	addiw	a3,a4,6
    17dc:	04c6fd63          	bgeu	a3,a2,1836 <memset+0x17a>
    17e0:	00b78323          	sb	a1,6(a5)
    17e4:	0077069b          	addiw	a3,a4,7
    17e8:	04c6f763          	bgeu	a3,a2,1836 <memset+0x17a>
    17ec:	00b783a3          	sb	a1,7(a5)
    17f0:	0087069b          	addiw	a3,a4,8
    17f4:	04c6f163          	bgeu	a3,a2,1836 <memset+0x17a>
    17f8:	00b78423          	sb	a1,8(a5)
    17fc:	0097069b          	addiw	a3,a4,9
    1800:	02c6fb63          	bgeu	a3,a2,1836 <memset+0x17a>
    1804:	00b784a3          	sb	a1,9(a5)
    1808:	00a7069b          	addiw	a3,a4,10
    180c:	02c6f563          	bgeu	a3,a2,1836 <memset+0x17a>
    1810:	00b78523          	sb	a1,10(a5)
    1814:	00b7069b          	addiw	a3,a4,11
    1818:	00c6ff63          	bgeu	a3,a2,1836 <memset+0x17a>
    181c:	00b785a3          	sb	a1,11(a5)
    1820:	00c7069b          	addiw	a3,a4,12
    1824:	00c6f963          	bgeu	a3,a2,1836 <memset+0x17a>
    1828:	00b78623          	sb	a1,12(a5)
    182c:	2735                	addiw	a4,a4,13
    182e:	00c77463          	bgeu	a4,a2,1836 <memset+0x17a>
    1832:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1836:	8082                	ret
    1838:	472d                	li	a4,11
    183a:	bd79                	j	16d8 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    183c:	4f0d                	li	t5,3
    183e:	b701                	j	173e <memset+0x82>
    1840:	8082                	ret
    1842:	4f05                	li	t5,1
    1844:	bded                	j	173e <memset+0x82>
    1846:	8eaa                	mv	t4,a0
    1848:	4f01                	li	t5,0
    184a:	bdd5                	j	173e <memset+0x82>
    184c:	87aa                	mv	a5,a0
    184e:	4701                	li	a4,0
    1850:	b7a1                	j	1798 <memset+0xdc>
    1852:	4f09                	li	t5,2
    1854:	b5ed                	j	173e <memset+0x82>
    1856:	4f11                	li	t5,4
    1858:	b5dd                	j	173e <memset+0x82>
    185a:	4f15                	li	t5,5
    185c:	b5cd                	j	173e <memset+0x82>
    185e:	4f19                	li	t5,6
    1860:	bdf9                	j	173e <memset+0x82>

0000000000001862 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1862:	00054783          	lbu	a5,0(a0)
    1866:	0005c703          	lbu	a4,0(a1)
    186a:	00e79863          	bne	a5,a4,187a <strcmp+0x18>
    186e:	0505                	addi	a0,a0,1
    1870:	0585                	addi	a1,a1,1
    1872:	fbe5                	bnez	a5,1862 <strcmp>
    1874:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1876:	9d19                	subw	a0,a0,a4
    1878:	8082                	ret
    187a:	0007851b          	sext.w	a0,a5
    187e:	bfe5                	j	1876 <strcmp+0x14>

0000000000001880 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1880:	ce05                	beqz	a2,18b8 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1882:	00054703          	lbu	a4,0(a0)
    1886:	0005c783          	lbu	a5,0(a1)
    188a:	cb0d                	beqz	a4,18bc <strncmp+0x3c>
    if (!n--)
    188c:	167d                	addi	a2,a2,-1
    188e:	00c506b3          	add	a3,a0,a2
    1892:	a819                	j	18a8 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1894:	00a68e63          	beq	a3,a0,18b0 <strncmp+0x30>
    1898:	0505                	addi	a0,a0,1
    189a:	00e79b63          	bne	a5,a4,18b0 <strncmp+0x30>
    189e:	00054703          	lbu	a4,0(a0)
    18a2:	0005c783          	lbu	a5,0(a1)
    18a6:	cb19                	beqz	a4,18bc <strncmp+0x3c>
    18a8:	0005c783          	lbu	a5,0(a1)
    18ac:	0585                	addi	a1,a1,1
    18ae:	f3fd                	bnez	a5,1894 <strncmp+0x14>
        ;
    return *l - *r;
    18b0:	0007051b          	sext.w	a0,a4
    18b4:	9d1d                	subw	a0,a0,a5
    18b6:	8082                	ret
        return 0;
    18b8:	4501                	li	a0,0
}
    18ba:	8082                	ret
    18bc:	4501                	li	a0,0
    return *l - *r;
    18be:	9d1d                	subw	a0,a0,a5
    18c0:	8082                	ret

00000000000018c2 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18c2:	00757793          	andi	a5,a0,7
    18c6:	cf89                	beqz	a5,18e0 <strlen+0x1e>
    18c8:	87aa                	mv	a5,a0
    18ca:	a029                	j	18d4 <strlen+0x12>
    18cc:	0785                	addi	a5,a5,1
    18ce:	0077f713          	andi	a4,a5,7
    18d2:	cb01                	beqz	a4,18e2 <strlen+0x20>
        if (!*s)
    18d4:	0007c703          	lbu	a4,0(a5)
    18d8:	fb75                	bnez	a4,18cc <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18da:	40a78533          	sub	a0,a5,a0
}
    18de:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18e0:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18e2:	6394                	ld	a3,0(a5)
    18e4:	00000597          	auipc	a1,0x0
    18e8:	6dc5b583          	ld	a1,1756(a1) # 1fc0 <__clone+0xe2>
    18ec:	00000617          	auipc	a2,0x0
    18f0:	6dc63603          	ld	a2,1756(a2) # 1fc8 <__clone+0xea>
    18f4:	a019                	j	18fa <strlen+0x38>
    18f6:	6794                	ld	a3,8(a5)
    18f8:	07a1                	addi	a5,a5,8
    18fa:	00b68733          	add	a4,a3,a1
    18fe:	fff6c693          	not	a3,a3
    1902:	8f75                	and	a4,a4,a3
    1904:	8f71                	and	a4,a4,a2
    1906:	db65                	beqz	a4,18f6 <strlen+0x34>
    for (; *s; s++)
    1908:	0007c703          	lbu	a4,0(a5)
    190c:	d779                	beqz	a4,18da <strlen+0x18>
    190e:	0017c703          	lbu	a4,1(a5)
    1912:	0785                	addi	a5,a5,1
    1914:	d379                	beqz	a4,18da <strlen+0x18>
    1916:	0017c703          	lbu	a4,1(a5)
    191a:	0785                	addi	a5,a5,1
    191c:	fb6d                	bnez	a4,190e <strlen+0x4c>
    191e:	bf75                	j	18da <strlen+0x18>

0000000000001920 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1920:	00757713          	andi	a4,a0,7
{
    1924:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1926:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    192a:	cb19                	beqz	a4,1940 <memchr+0x20>
    192c:	ce25                	beqz	a2,19a4 <memchr+0x84>
    192e:	0007c703          	lbu	a4,0(a5)
    1932:	04b70e63          	beq	a4,a1,198e <memchr+0x6e>
    1936:	0785                	addi	a5,a5,1
    1938:	0077f713          	andi	a4,a5,7
    193c:	167d                	addi	a2,a2,-1
    193e:	f77d                	bnez	a4,192c <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1940:	4501                	li	a0,0
    if (n && *s != c)
    1942:	c235                	beqz	a2,19a6 <memchr+0x86>
    1944:	0007c703          	lbu	a4,0(a5)
    1948:	04b70363          	beq	a4,a1,198e <memchr+0x6e>
        size_t k = ONES * c;
    194c:	00000517          	auipc	a0,0x0
    1950:	68453503          	ld	a0,1668(a0) # 1fd0 <__clone+0xf2>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1954:	471d                	li	a4,7
        size_t k = ONES * c;
    1956:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    195a:	02c77a63          	bgeu	a4,a2,198e <memchr+0x6e>
    195e:	00000897          	auipc	a7,0x0
    1962:	6628b883          	ld	a7,1634(a7) # 1fc0 <__clone+0xe2>
    1966:	00000817          	auipc	a6,0x0
    196a:	66283803          	ld	a6,1634(a6) # 1fc8 <__clone+0xea>
    196e:	431d                	li	t1,7
    1970:	a029                	j	197a <memchr+0x5a>
    1972:	1661                	addi	a2,a2,-8
    1974:	07a1                	addi	a5,a5,8
    1976:	02c37963          	bgeu	t1,a2,19a8 <memchr+0x88>
    197a:	6398                	ld	a4,0(a5)
    197c:	8f29                	xor	a4,a4,a0
    197e:	011706b3          	add	a3,a4,a7
    1982:	fff74713          	not	a4,a4
    1986:	8f75                	and	a4,a4,a3
    1988:	01077733          	and	a4,a4,a6
    198c:	d37d                	beqz	a4,1972 <memchr+0x52>
    198e:	853e                	mv	a0,a5
    1990:	97b2                	add	a5,a5,a2
    1992:	a021                	j	199a <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1994:	0505                	addi	a0,a0,1
    1996:	00f50763          	beq	a0,a5,19a4 <memchr+0x84>
    199a:	00054703          	lbu	a4,0(a0)
    199e:	feb71be3          	bne	a4,a1,1994 <memchr+0x74>
    19a2:	8082                	ret
    return n ? (void *)s : 0;
    19a4:	4501                	li	a0,0
}
    19a6:	8082                	ret
    return n ? (void *)s : 0;
    19a8:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19aa:	f275                	bnez	a2,198e <memchr+0x6e>
}
    19ac:	8082                	ret

00000000000019ae <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19ae:	1101                	addi	sp,sp,-32
    19b0:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19b2:	862e                	mv	a2,a1
{
    19b4:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19b6:	4581                	li	a1,0
{
    19b8:	e426                	sd	s1,8(sp)
    19ba:	ec06                	sd	ra,24(sp)
    19bc:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19be:	f63ff0ef          	jal	ra,1920 <memchr>
    return p ? p - s : n;
    19c2:	c519                	beqz	a0,19d0 <strnlen+0x22>
}
    19c4:	60e2                	ld	ra,24(sp)
    19c6:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19c8:	8d05                	sub	a0,a0,s1
}
    19ca:	64a2                	ld	s1,8(sp)
    19cc:	6105                	addi	sp,sp,32
    19ce:	8082                	ret
    19d0:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19d2:	8522                	mv	a0,s0
}
    19d4:	6442                	ld	s0,16(sp)
    19d6:	64a2                	ld	s1,8(sp)
    19d8:	6105                	addi	sp,sp,32
    19da:	8082                	ret

00000000000019dc <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19dc:	00b547b3          	xor	a5,a0,a1
    19e0:	8b9d                	andi	a5,a5,7
    19e2:	eb95                	bnez	a5,1a16 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19e4:	0075f793          	andi	a5,a1,7
    19e8:	e7b1                	bnez	a5,1a34 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ea:	6198                	ld	a4,0(a1)
    19ec:	00000617          	auipc	a2,0x0
    19f0:	5d463603          	ld	a2,1492(a2) # 1fc0 <__clone+0xe2>
    19f4:	00000817          	auipc	a6,0x0
    19f8:	5d483803          	ld	a6,1492(a6) # 1fc8 <__clone+0xea>
    19fc:	a029                	j	1a06 <strcpy+0x2a>
    19fe:	e118                	sd	a4,0(a0)
    1a00:	6598                	ld	a4,8(a1)
    1a02:	05a1                	addi	a1,a1,8
    1a04:	0521                	addi	a0,a0,8
    1a06:	00c707b3          	add	a5,a4,a2
    1a0a:	fff74693          	not	a3,a4
    1a0e:	8ff5                	and	a5,a5,a3
    1a10:	0107f7b3          	and	a5,a5,a6
    1a14:	d7ed                	beqz	a5,19fe <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a16:	0005c783          	lbu	a5,0(a1)
    1a1a:	00f50023          	sb	a5,0(a0)
    1a1e:	c785                	beqz	a5,1a46 <strcpy+0x6a>
    1a20:	0015c783          	lbu	a5,1(a1)
    1a24:	0505                	addi	a0,a0,1
    1a26:	0585                	addi	a1,a1,1
    1a28:	00f50023          	sb	a5,0(a0)
    1a2c:	fbf5                	bnez	a5,1a20 <strcpy+0x44>
        ;
    return d;
}
    1a2e:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a30:	0505                	addi	a0,a0,1
    1a32:	df45                	beqz	a4,19ea <strcpy+0xe>
            if (!(*d = *s))
    1a34:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a38:	0585                	addi	a1,a1,1
    1a3a:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a3e:	00f50023          	sb	a5,0(a0)
    1a42:	f7fd                	bnez	a5,1a30 <strcpy+0x54>
}
    1a44:	8082                	ret
    1a46:	8082                	ret

0000000000001a48 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a48:	00b547b3          	xor	a5,a0,a1
    1a4c:	8b9d                	andi	a5,a5,7
    1a4e:	1a079863          	bnez	a5,1bfe <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a52:	0075f793          	andi	a5,a1,7
    1a56:	16078463          	beqz	a5,1bbe <strncpy+0x176>
    1a5a:	ea01                	bnez	a2,1a6a <strncpy+0x22>
    1a5c:	a421                	j	1c64 <strncpy+0x21c>
    1a5e:	167d                	addi	a2,a2,-1
    1a60:	0505                	addi	a0,a0,1
    1a62:	14070e63          	beqz	a4,1bbe <strncpy+0x176>
    1a66:	1a060863          	beqz	a2,1c16 <strncpy+0x1ce>
    1a6a:	0005c783          	lbu	a5,0(a1)
    1a6e:	0585                	addi	a1,a1,1
    1a70:	0075f713          	andi	a4,a1,7
    1a74:	00f50023          	sb	a5,0(a0)
    1a78:	f3fd                	bnez	a5,1a5e <strncpy+0x16>
    1a7a:	4805                	li	a6,1
    1a7c:	1a061863          	bnez	a2,1c2c <strncpy+0x1e4>
    1a80:	40a007b3          	neg	a5,a0
    1a84:	8b9d                	andi	a5,a5,7
    1a86:	4681                	li	a3,0
    1a88:	18061a63          	bnez	a2,1c1c <strncpy+0x1d4>
    1a8c:	00778713          	addi	a4,a5,7
    1a90:	45ad                	li	a1,11
    1a92:	18b76363          	bltu	a4,a1,1c18 <strncpy+0x1d0>
    1a96:	1ae6eb63          	bltu	a3,a4,1c4c <strncpy+0x204>
    1a9a:	1a078363          	beqz	a5,1c40 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a9e:	00050023          	sb	zero,0(a0)
    1aa2:	4685                	li	a3,1
    1aa4:	00150713          	addi	a4,a0,1
    1aa8:	18d78f63          	beq	a5,a3,1c46 <strncpy+0x1fe>
    1aac:	000500a3          	sb	zero,1(a0)
    1ab0:	4689                	li	a3,2
    1ab2:	00250713          	addi	a4,a0,2
    1ab6:	18d78e63          	beq	a5,a3,1c52 <strncpy+0x20a>
    1aba:	00050123          	sb	zero,2(a0)
    1abe:	468d                	li	a3,3
    1ac0:	00350713          	addi	a4,a0,3
    1ac4:	16d78c63          	beq	a5,a3,1c3c <strncpy+0x1f4>
    1ac8:	000501a3          	sb	zero,3(a0)
    1acc:	4691                	li	a3,4
    1ace:	00450713          	addi	a4,a0,4
    1ad2:	18d78263          	beq	a5,a3,1c56 <strncpy+0x20e>
    1ad6:	00050223          	sb	zero,4(a0)
    1ada:	4695                	li	a3,5
    1adc:	00550713          	addi	a4,a0,5
    1ae0:	16d78d63          	beq	a5,a3,1c5a <strncpy+0x212>
    1ae4:	000502a3          	sb	zero,5(a0)
    1ae8:	469d                	li	a3,7
    1aea:	00650713          	addi	a4,a0,6
    1aee:	16d79863          	bne	a5,a3,1c5e <strncpy+0x216>
    1af2:	00750713          	addi	a4,a0,7
    1af6:	00050323          	sb	zero,6(a0)
    1afa:	40f80833          	sub	a6,a6,a5
    1afe:	ff887593          	andi	a1,a6,-8
    1b02:	97aa                	add	a5,a5,a0
    1b04:	95be                	add	a1,a1,a5
    1b06:	0007b023          	sd	zero,0(a5)
    1b0a:	07a1                	addi	a5,a5,8
    1b0c:	feb79de3          	bne	a5,a1,1b06 <strncpy+0xbe>
    1b10:	ff887593          	andi	a1,a6,-8
    1b14:	9ead                	addw	a3,a3,a1
    1b16:	00b707b3          	add	a5,a4,a1
    1b1a:	12b80863          	beq	a6,a1,1c4a <strncpy+0x202>
    1b1e:	00078023          	sb	zero,0(a5)
    1b22:	0016871b          	addiw	a4,a3,1
    1b26:	0ec77863          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b2a:	000780a3          	sb	zero,1(a5)
    1b2e:	0026871b          	addiw	a4,a3,2
    1b32:	0ec77263          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b36:	00078123          	sb	zero,2(a5)
    1b3a:	0036871b          	addiw	a4,a3,3
    1b3e:	0cc77c63          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b42:	000781a3          	sb	zero,3(a5)
    1b46:	0046871b          	addiw	a4,a3,4
    1b4a:	0cc77663          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b4e:	00078223          	sb	zero,4(a5)
    1b52:	0056871b          	addiw	a4,a3,5
    1b56:	0cc77063          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b5a:	000782a3          	sb	zero,5(a5)
    1b5e:	0066871b          	addiw	a4,a3,6
    1b62:	0ac77a63          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b66:	00078323          	sb	zero,6(a5)
    1b6a:	0076871b          	addiw	a4,a3,7
    1b6e:	0ac77463          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b72:	000783a3          	sb	zero,7(a5)
    1b76:	0086871b          	addiw	a4,a3,8
    1b7a:	08c77e63          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b7e:	00078423          	sb	zero,8(a5)
    1b82:	0096871b          	addiw	a4,a3,9
    1b86:	08c77863          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b8a:	000784a3          	sb	zero,9(a5)
    1b8e:	00a6871b          	addiw	a4,a3,10
    1b92:	08c77263          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1b96:	00078523          	sb	zero,10(a5)
    1b9a:	00b6871b          	addiw	a4,a3,11
    1b9e:	06c77c63          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1ba2:	000785a3          	sb	zero,11(a5)
    1ba6:	00c6871b          	addiw	a4,a3,12
    1baa:	06c77663          	bgeu	a4,a2,1c16 <strncpy+0x1ce>
    1bae:	00078623          	sb	zero,12(a5)
    1bb2:	26b5                	addiw	a3,a3,13
    1bb4:	06c6f163          	bgeu	a3,a2,1c16 <strncpy+0x1ce>
    1bb8:	000786a3          	sb	zero,13(a5)
    1bbc:	8082                	ret
            ;
        if (!n || !*s)
    1bbe:	c645                	beqz	a2,1c66 <strncpy+0x21e>
    1bc0:	0005c783          	lbu	a5,0(a1)
    1bc4:	ea078be3          	beqz	a5,1a7a <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc8:	479d                	li	a5,7
    1bca:	02c7ff63          	bgeu	a5,a2,1c08 <strncpy+0x1c0>
    1bce:	00000897          	auipc	a7,0x0
    1bd2:	3f28b883          	ld	a7,1010(a7) # 1fc0 <__clone+0xe2>
    1bd6:	00000817          	auipc	a6,0x0
    1bda:	3f283803          	ld	a6,1010(a6) # 1fc8 <__clone+0xea>
    1bde:	431d                	li	t1,7
    1be0:	6198                	ld	a4,0(a1)
    1be2:	011707b3          	add	a5,a4,a7
    1be6:	fff74693          	not	a3,a4
    1bea:	8ff5                	and	a5,a5,a3
    1bec:	0107f7b3          	and	a5,a5,a6
    1bf0:	ef81                	bnez	a5,1c08 <strncpy+0x1c0>
            *wd = *ws;
    1bf2:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf4:	1661                	addi	a2,a2,-8
    1bf6:	05a1                	addi	a1,a1,8
    1bf8:	0521                	addi	a0,a0,8
    1bfa:	fec363e3          	bltu	t1,a2,1be0 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bfe:	e609                	bnez	a2,1c08 <strncpy+0x1c0>
    1c00:	a08d                	j	1c62 <strncpy+0x21a>
    1c02:	167d                	addi	a2,a2,-1
    1c04:	0505                	addi	a0,a0,1
    1c06:	ca01                	beqz	a2,1c16 <strncpy+0x1ce>
    1c08:	0005c783          	lbu	a5,0(a1)
    1c0c:	0585                	addi	a1,a1,1
    1c0e:	00f50023          	sb	a5,0(a0)
    1c12:	fbe5                	bnez	a5,1c02 <strncpy+0x1ba>
        ;
tail:
    1c14:	b59d                	j	1a7a <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c16:	8082                	ret
    1c18:	472d                	li	a4,11
    1c1a:	bdb5                	j	1a96 <strncpy+0x4e>
    1c1c:	00778713          	addi	a4,a5,7
    1c20:	45ad                	li	a1,11
    1c22:	fff60693          	addi	a3,a2,-1
    1c26:	e6b778e3          	bgeu	a4,a1,1a96 <strncpy+0x4e>
    1c2a:	b7fd                	j	1c18 <strncpy+0x1d0>
    1c2c:	40a007b3          	neg	a5,a0
    1c30:	8832                	mv	a6,a2
    1c32:	8b9d                	andi	a5,a5,7
    1c34:	4681                	li	a3,0
    1c36:	e4060be3          	beqz	a2,1a8c <strncpy+0x44>
    1c3a:	b7cd                	j	1c1c <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c3c:	468d                	li	a3,3
    1c3e:	bd75                	j	1afa <strncpy+0xb2>
    1c40:	872a                	mv	a4,a0
    1c42:	4681                	li	a3,0
    1c44:	bd5d                	j	1afa <strncpy+0xb2>
    1c46:	4685                	li	a3,1
    1c48:	bd4d                	j	1afa <strncpy+0xb2>
    1c4a:	8082                	ret
    1c4c:	87aa                	mv	a5,a0
    1c4e:	4681                	li	a3,0
    1c50:	b5f9                	j	1b1e <strncpy+0xd6>
    1c52:	4689                	li	a3,2
    1c54:	b55d                	j	1afa <strncpy+0xb2>
    1c56:	4691                	li	a3,4
    1c58:	b54d                	j	1afa <strncpy+0xb2>
    1c5a:	4695                	li	a3,5
    1c5c:	bd79                	j	1afa <strncpy+0xb2>
    1c5e:	4699                	li	a3,6
    1c60:	bd69                	j	1afa <strncpy+0xb2>
    1c62:	8082                	ret
    1c64:	8082                	ret
    1c66:	8082                	ret

0000000000001c68 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c68:	87aa                	mv	a5,a0
    1c6a:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c6c:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c70:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c74:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c76:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c78:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c7c:	2501                	sext.w	a0,a0
    1c7e:	8082                	ret

0000000000001c80 <openat>:
    register long a7 __asm__("a7") = n;
    1c80:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c84:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c88:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c8c:	2501                	sext.w	a0,a0
    1c8e:	8082                	ret

0000000000001c90 <close>:
    register long a7 __asm__("a7") = n;
    1c90:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c94:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c98:	2501                	sext.w	a0,a0
    1c9a:	8082                	ret

0000000000001c9c <read>:
    register long a7 __asm__("a7") = n;
    1c9c:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca0:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1ca4:	8082                	ret

0000000000001ca6 <write>:
    register long a7 __asm__("a7") = n;
    1ca6:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1caa:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cae:	8082                	ret

0000000000001cb0 <getpid>:
    register long a7 __asm__("a7") = n;
    1cb0:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cb4:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cb8:	2501                	sext.w	a0,a0
    1cba:	8082                	ret

0000000000001cbc <getppid>:
    register long a7 __asm__("a7") = n;
    1cbc:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cc0:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cc8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ccc:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <fork>:
    register long a7 __asm__("a7") = n;
    1cd4:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cd8:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cda:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cdc:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ce4:	85b2                	mv	a1,a2
    1ce6:	863a                	mv	a2,a4
    if (stack)
    1ce8:	c191                	beqz	a1,1cec <clone+0x8>
	stack += stack_size;
    1cea:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cec:	4781                	li	a5,0
    1cee:	4701                	li	a4,0
    1cf0:	4681                	li	a3,0
    1cf2:	2601                	sext.w	a2,a2
    1cf4:	a2ed                	j	1ede <__clone>

0000000000001cf6 <exit>:
    register long a7 __asm__("a7") = n;
    1cf6:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cfa:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cfe:	8082                	ret

0000000000001d00 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d00:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d04:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d06:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d0a:	2501                	sext.w	a0,a0
    1d0c:	8082                	ret

0000000000001d0e <exec>:
    register long a7 __asm__("a7") = n;
    1d0e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d12:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d16:	2501                	sext.w	a0,a0
    1d18:	8082                	ret

0000000000001d1a <execve>:
    register long a7 __asm__("a7") = n;
    1d1a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d1e:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d22:	2501                	sext.w	a0,a0
    1d24:	8082                	ret

0000000000001d26 <times>:
    register long a7 __asm__("a7") = n;
    1d26:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d2a:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d2e:	2501                	sext.w	a0,a0
    1d30:	8082                	ret

0000000000001d32 <get_time>:

int64 get_time()
{
    1d32:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d34:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d38:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d3a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3c:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d40:	2501                	sext.w	a0,a0
    1d42:	ed09                	bnez	a0,1d5c <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d44:	67a2                	ld	a5,8(sp)
    1d46:	3e800713          	li	a4,1000
    1d4a:	00015503          	lhu	a0,0(sp)
    1d4e:	02e7d7b3          	divu	a5,a5,a4
    1d52:	02e50533          	mul	a0,a0,a4
    1d56:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d58:	0141                	addi	sp,sp,16
    1d5a:	8082                	ret
        return -1;
    1d5c:	557d                	li	a0,-1
    1d5e:	bfed                	j	1d58 <get_time+0x26>

0000000000001d60 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d60:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d64:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d68:	2501                	sext.w	a0,a0
    1d6a:	8082                	ret

0000000000001d6c <time>:
    register long a7 __asm__("a7") = n;
    1d6c:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d70:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d74:	2501                	sext.w	a0,a0
    1d76:	8082                	ret

0000000000001d78 <sleep>:

int sleep(unsigned long long time)
{
    1d78:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d7a:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d7c:	850a                	mv	a0,sp
    1d7e:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d80:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d84:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d86:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d8a:	e501                	bnez	a0,1d92 <sleep+0x1a>
    return 0;
    1d8c:	4501                	li	a0,0
}
    1d8e:	0141                	addi	sp,sp,16
    1d90:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d92:	4502                	lw	a0,0(sp)
}
    1d94:	0141                	addi	sp,sp,16
    1d96:	8082                	ret

0000000000001d98 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d98:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d9c:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1da0:	2501                	sext.w	a0,a0
    1da2:	8082                	ret

0000000000001da4 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1da4:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1da8:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dac:	8082                	ret

0000000000001dae <munmap>:
    register long a7 __asm__("a7") = n;
    1dae:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db2:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1db6:	2501                	sext.w	a0,a0
    1db8:	8082                	ret

0000000000001dba <wait>:

int wait(int *code)
{
    1dba:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dbc:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dc0:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dc2:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dc4:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dc6:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <spawn>:
    register long a7 __asm__("a7") = n;
    1dce:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dd2:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dd6:	2501                	sext.w	a0,a0
    1dd8:	8082                	ret

0000000000001dda <mailread>:
    register long a7 __asm__("a7") = n;
    1dda:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dde:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1de2:	2501                	sext.w	a0,a0
    1de4:	8082                	ret

0000000000001de6 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1de6:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dea:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <fstat>:
    register long a7 __asm__("a7") = n;
    1df2:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df6:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dfa:	2501                	sext.w	a0,a0
    1dfc:	8082                	ret

0000000000001dfe <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dfe:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e00:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e04:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e06:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e0e:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e10:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e14:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e16:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e1a:	2501                	sext.w	a0,a0
    1e1c:	8082                	ret

0000000000001e1e <link>:

int link(char *old_path, char *new_path)
{
    1e1e:	87aa                	mv	a5,a0
    1e20:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e22:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e26:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e2a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e2c:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e30:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e32:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e36:	2501                	sext.w	a0,a0
    1e38:	8082                	ret

0000000000001e3a <unlink>:

int unlink(char *path)
{
    1e3a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e3c:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e40:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e44:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e46:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e4a:	2501                	sext.w	a0,a0
    1e4c:	8082                	ret

0000000000001e4e <uname>:
    register long a7 __asm__("a7") = n;
    1e4e:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e52:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e56:	2501                	sext.w	a0,a0
    1e58:	8082                	ret

0000000000001e5a <brk>:
    register long a7 __asm__("a7") = n;
    1e5a:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e5e:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e62:	2501                	sext.w	a0,a0
    1e64:	8082                	ret

0000000000001e66 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e66:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e68:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e6c:	8082                	ret

0000000000001e6e <chdir>:
    register long a7 __asm__("a7") = n;
    1e6e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e72:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e7a:	862e                	mv	a2,a1
    1e7c:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e7e:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e80:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e84:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e88:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e8a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8c:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <getdents>:
    register long a7 __asm__("a7") = n;
    1e94:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e98:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e9c:	2501                	sext.w	a0,a0
    1e9e:	8082                	ret

0000000000001ea0 <pipe>:
    register long a7 __asm__("a7") = n;
    1ea0:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ea4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea6:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <dup>:
    register long a7 __asm__("a7") = n;
    1eae:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eb0:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eb4:	2501                	sext.w	a0,a0
    1eb6:	8082                	ret

0000000000001eb8 <dup2>:
    register long a7 __asm__("a7") = n;
    1eb8:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eba:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ebc:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <mount>:
    register long a7 __asm__("a7") = n;
    1ec4:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ec8:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ecc:	2501                	sext.w	a0,a0
    1ece:	8082                	ret

0000000000001ed0 <umount>:
    register long a7 __asm__("a7") = n;
    1ed0:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ed4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed6:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eda:	2501                	sext.w	a0,a0
    1edc:	8082                	ret

0000000000001ede <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ede:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ee0:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ee2:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ee4:	8532                	mv	a0,a2
	mv a2, a4
    1ee6:	863a                	mv	a2,a4
	mv a3, a5
    1ee8:	86be                	mv	a3,a5
	mv a4, a6
    1eea:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eec:	0dc00893          	li	a7,220
	ecall
    1ef0:	00000073          	ecall

	beqz a0, 1f
    1ef4:	c111                	beqz	a0,1ef8 <__clone+0x1a>
	# Parent
	ret
    1ef6:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ef8:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1efa:	6522                	ld	a0,8(sp)
	jalr a1
    1efc:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1efe:	05d00893          	li	a7,93
	ecall
    1f02:	00000073          	ecall
