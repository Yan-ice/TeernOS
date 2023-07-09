
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/waitpid:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a8e5                	j	10fa <__start_main>

0000000000001004 <test_waitpid>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

int i = 1000;
void test_waitpid(void){
    1004:	7179                	addi	sp,sp,-48
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f3250513          	addi	a0,a0,-206 # 1f38 <__clone+0x2a>
void test_waitpid(void){
    100e:	f406                	sd	ra,40(sp)
    1010:	f022                	sd	s0,32(sp)
    1012:	ec26                	sd	s1,24(sp)
    TEST_START(__func__);
    1014:	31e000ef          	jal	ra,1332 <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	fe850513          	addi	a0,a0,-24 # 2000 <__func__.1167>
    1020:	312000ef          	jal	ra,1332 <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f2c50513          	addi	a0,a0,-212 # 1f50 <__clone+0x42>
    102c:	306000ef          	jal	ra,1332 <puts>
    int cpid, wstatus;
    cpid = fork();
    1030:	4d5000ef          	jal	ra,1d04 <fork>
    assert(cpid != -1);
    1034:	547d                	li	s0,-1
    cpid = fork();
    1036:	84aa                	mv	s1,a0
    assert(cpid != -1);
    1038:	04850963          	beq	a0,s0,108a <test_waitpid+0x86>
    if(cpid == 0){
    103c:	e93d                	bnez	a0,10b2 <test_waitpid+0xae>
	while(i--);
    103e:	00001797          	auipc	a5,0x1
    1042:	fe87a923          	sw	s0,-14(a5) # 2030 <i>
	sched_yield();
    1046:	4b3000ef          	jal	ra,1cf8 <sched_yield>
	printf("This is child process\n");
    104a:	00001517          	auipc	a0,0x1
    104e:	f3650513          	addi	a0,a0,-202 # 1f80 <__clone+0x72>
    1052:	302000ef          	jal	ra,1354 <printf>
        exit(3);
    1056:	450d                	li	a0,3
    1058:	4cf000ef          	jal	ra,1d26 <exit>
	    printf("waitpid successfully.\nwstatus: %x\n", WEXITSTATUS(wstatus));
	else
	    printf("waitpid error.\n");

    }
    TEST_END(__func__);
    105c:	00001517          	auipc	a0,0x1
    1060:	f7450513          	addi	a0,a0,-140 # 1fd0 <__clone+0xc2>
    1064:	2ce000ef          	jal	ra,1332 <puts>
    1068:	00001517          	auipc	a0,0x1
    106c:	f9850513          	addi	a0,a0,-104 # 2000 <__func__.1167>
    1070:	2c2000ef          	jal	ra,1332 <puts>
    1074:	00001517          	auipc	a0,0x1
    1078:	edc50513          	addi	a0,a0,-292 # 1f50 <__clone+0x42>
    107c:	2b6000ef          	jal	ra,1332 <puts>
}
    1080:	70a2                	ld	ra,40(sp)
    1082:	7402                	ld	s0,32(sp)
    1084:	64e2                	ld	s1,24(sp)
    1086:	6145                	addi	sp,sp,48
    1088:	8082                	ret
    assert(cpid != -1);
    108a:	00001517          	auipc	a0,0x1
    108e:	ed650513          	addi	a0,a0,-298 # 1f60 <__clone+0x52>
    1092:	582000ef          	jal	ra,1614 <panic>
	pid_t ret = waitpid(cpid, &wstatus, 0);
    1096:	4601                	li	a2,0
    1098:	006c                	addi	a1,sp,12
    109a:	557d                	li	a0,-1
    109c:	495000ef          	jal	ra,1d30 <waitpid>
	assert(ret != -1);
    10a0:	00950f63          	beq	a0,s1,10be <test_waitpid+0xba>
	    printf("waitpid error.\n");
    10a4:	00001517          	auipc	a0,0x1
    10a8:	f1c50513          	addi	a0,a0,-228 # 1fc0 <__clone+0xb2>
    10ac:	2a8000ef          	jal	ra,1354 <printf>
    10b0:	b775                	j	105c <test_waitpid+0x58>
	pid_t ret = waitpid(cpid, &wstatus, 0);
    10b2:	4601                	li	a2,0
    10b4:	006c                	addi	a1,sp,12
    10b6:	47b000ef          	jal	ra,1d30 <waitpid>
	assert(ret != -1);
    10ba:	00851963          	bne	a0,s0,10cc <test_waitpid+0xc8>
    10be:	00001517          	auipc	a0,0x1
    10c2:	ea250513          	addi	a0,a0,-350 # 1f60 <__clone+0x52>
    10c6:	54e000ef          	jal	ra,1614 <panic>
    10ca:	557d                	li	a0,-1
	if(ret == cpid && WEXITSTATUS(wstatus) == 3)
    10cc:	fca49ce3          	bne	s1,a0,10a4 <test_waitpid+0xa0>
    10d0:	00d14703          	lbu	a4,13(sp)
    10d4:	478d                	li	a5,3
    10d6:	fcf717e3          	bne	a4,a5,10a4 <test_waitpid+0xa0>
	    printf("waitpid successfully.\nwstatus: %x\n", WEXITSTATUS(wstatus));
    10da:	458d                	li	a1,3
    10dc:	00001517          	auipc	a0,0x1
    10e0:	ebc50513          	addi	a0,a0,-324 # 1f98 <__clone+0x8a>
    10e4:	270000ef          	jal	ra,1354 <printf>
    10e8:	bf95                	j	105c <test_waitpid+0x58>

00000000000010ea <main>:

int main(void){
    10ea:	1141                	addi	sp,sp,-16
    10ec:	e406                	sd	ra,8(sp)
    test_waitpid();
    10ee:	f17ff0ef          	jal	ra,1004 <test_waitpid>
    return 0;
}
    10f2:	60a2                	ld	ra,8(sp)
    10f4:	4501                	li	a0,0
    10f6:	0141                	addi	sp,sp,16
    10f8:	8082                	ret

00000000000010fa <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10fa:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10fc:	4108                	lw	a0,0(a0)
{
    10fe:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1100:	05a1                	addi	a1,a1,8
{
    1102:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1104:	fe7ff0ef          	jal	ra,10ea <main>
    1108:	41f000ef          	jal	ra,1d26 <exit>
	return 0;
}
    110c:	60a2                	ld	ra,8(sp)
    110e:	4501                	li	a0,0
    1110:	0141                	addi	sp,sp,16
    1112:	8082                	ret

0000000000001114 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1114:	7179                	addi	sp,sp,-48
    1116:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1118:	12054b63          	bltz	a0,124e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    111c:	02b577bb          	remuw	a5,a0,a1
    1120:	00001697          	auipc	a3,0x1
    1124:	ef068693          	addi	a3,a3,-272 # 2010 <digits>
    buf[16] = 0;
    1128:	00010c23          	sb	zero,24(sp)
    i = 15;
    112c:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1130:	1782                	slli	a5,a5,0x20
    1132:	9381                	srli	a5,a5,0x20
    1134:	97b6                	add	a5,a5,a3
    1136:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    113a:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    113e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1142:	16b56263          	bltu	a0,a1,12a6 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    1146:	02e8763b          	remuw	a2,a6,a4
    114a:	1602                	slli	a2,a2,0x20
    114c:	9201                	srli	a2,a2,0x20
    114e:	9636                	add	a2,a2,a3
    1150:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1154:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1158:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    115c:	12e86963          	bltu	a6,a4,128e <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1160:	02e5f63b          	remuw	a2,a1,a4
    1164:	1602                	slli	a2,a2,0x20
    1166:	9201                	srli	a2,a2,0x20
    1168:	9636                	add	a2,a2,a3
    116a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    116e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1172:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1176:	10e5ef63          	bltu	a1,a4,1294 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    117a:	02e8763b          	remuw	a2,a6,a4
    117e:	1602                	slli	a2,a2,0x20
    1180:	9201                	srli	a2,a2,0x20
    1182:	9636                	add	a2,a2,a3
    1184:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1188:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    118c:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1190:	10e86563          	bltu	a6,a4,129a <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1194:	02e5f63b          	remuw	a2,a1,a4
    1198:	1602                	slli	a2,a2,0x20
    119a:	9201                	srli	a2,a2,0x20
    119c:	9636                	add	a2,a2,a3
    119e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a2:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11a6:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    11aa:	0ee5eb63          	bltu	a1,a4,12a0 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    11ae:	02e8763b          	remuw	a2,a6,a4
    11b2:	1602                	slli	a2,a2,0x20
    11b4:	9201                	srli	a2,a2,0x20
    11b6:	9636                	add	a2,a2,a3
    11b8:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11bc:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11c0:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    11c4:	0ce86263          	bltu	a6,a4,1288 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    11c8:	02e5f63b          	remuw	a2,a1,a4
    11cc:	1602                	slli	a2,a2,0x20
    11ce:	9201                	srli	a2,a2,0x20
    11d0:	9636                	add	a2,a2,a3
    11d2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11d6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11da:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11de:	0ce5e663          	bltu	a1,a4,12aa <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11e2:	02e8763b          	remuw	a2,a6,a4
    11e6:	1602                	slli	a2,a2,0x20
    11e8:	9201                	srli	a2,a2,0x20
    11ea:	9636                	add	a2,a2,a3
    11ec:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11f0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11f4:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11f8:	0ae86c63          	bltu	a6,a4,12b0 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11fc:	02e5f63b          	remuw	a2,a1,a4
    1200:	1602                	slli	a2,a2,0x20
    1202:	9201                	srli	a2,a2,0x20
    1204:	9636                	add	a2,a2,a3
    1206:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    120a:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    120e:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    1212:	0ae5e263          	bltu	a1,a4,12b6 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    1216:	1782                	slli	a5,a5,0x20
    1218:	9381                	srli	a5,a5,0x20
    121a:	97b6                	add	a5,a5,a3
    121c:	0007c703          	lbu	a4,0(a5)
    1220:	4599                	li	a1,6
    1222:	4795                	li	a5,5
    1224:	00e10723          	sb	a4,14(sp)

    if (sign)
    1228:	00055963          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    122c:	1018                	addi	a4,sp,32
    122e:	973e                	add	a4,a4,a5
    1230:	02d00693          	li	a3,45
    1234:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    1238:	85be                	mv	a1,a5
    write(f, s, l);
    123a:	003c                	addi	a5,sp,8
    123c:	4641                	li	a2,16
    123e:	9e0d                	subw	a2,a2,a1
    1240:	4505                	li	a0,1
    1242:	95be                	add	a1,a1,a5
    1244:	293000ef          	jal	ra,1cd6 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1248:	70a2                	ld	ra,40(sp)
    124a:	6145                	addi	sp,sp,48
    124c:	8082                	ret
        x = -xx;
    124e:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1252:	02b677bb          	remuw	a5,a2,a1
    1256:	00001697          	auipc	a3,0x1
    125a:	dba68693          	addi	a3,a3,-582 # 2010 <digits>
    buf[16] = 0;
    125e:	00010c23          	sb	zero,24(sp)
    i = 15;
    1262:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1266:	1782                	slli	a5,a5,0x20
    1268:	9381                	srli	a5,a5,0x20
    126a:	97b6                	add	a5,a5,a3
    126c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1270:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1274:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1278:	ecb677e3          	bgeu	a2,a1,1146 <printint.constprop.0+0x32>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1284:	45b9                	li	a1,14
    1286:	bf55                	j	123a <printint.constprop.0+0x126>
    1288:	47a5                	li	a5,9
    128a:	45a9                	li	a1,10
    128c:	bf71                	j	1228 <printint.constprop.0+0x114>
    128e:	47b5                	li	a5,13
    1290:	45b9                	li	a1,14
    1292:	bf59                	j	1228 <printint.constprop.0+0x114>
    1294:	47b1                	li	a5,12
    1296:	45b5                	li	a1,13
    1298:	bf41                	j	1228 <printint.constprop.0+0x114>
    129a:	47ad                	li	a5,11
    129c:	45b1                	li	a1,12
    129e:	b769                	j	1228 <printint.constprop.0+0x114>
    12a0:	47a9                	li	a5,10
    12a2:	45ad                	li	a1,11
    12a4:	b751                	j	1228 <printint.constprop.0+0x114>
    i = 15;
    12a6:	45bd                	li	a1,15
    12a8:	bf49                	j	123a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12aa:	47a1                	li	a5,8
    12ac:	45a5                	li	a1,9
    12ae:	bfad                	j	1228 <printint.constprop.0+0x114>
    12b0:	479d                	li	a5,7
    12b2:	45a1                	li	a1,8
    12b4:	bf95                	j	1228 <printint.constprop.0+0x114>
    12b6:	4799                	li	a5,6
    12b8:	459d                	li	a1,7
    12ba:	b7bd                	j	1228 <printint.constprop.0+0x114>

00000000000012bc <getchar>:
{
    12bc:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12be:	00f10593          	addi	a1,sp,15
    12c2:	4605                	li	a2,1
    12c4:	4501                	li	a0,0
{
    12c6:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12c8:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12cc:	201000ef          	jal	ra,1ccc <read>
}
    12d0:	60e2                	ld	ra,24(sp)
    12d2:	00f14503          	lbu	a0,15(sp)
    12d6:	6105                	addi	sp,sp,32
    12d8:	8082                	ret

00000000000012da <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12da:	00001797          	auipc	a5,0x1
    12de:	d4e78793          	addi	a5,a5,-690 # 2028 <digits+0x18>
    12e2:	04000893          	li	a7,64
    12e6:	4505                	li	a0,1
    12e8:	85be                	mv	a1,a5
    12ea:	4611                	li	a2,4
    12ec:	00000073          	ecall
}
    12f0:	4501                	li	a0,0
    12f2:	8082                	ret

00000000000012f4 <putchar>:
{
    12f4:	1101                	addi	sp,sp,-32
    12f6:	ec06                	sd	ra,24(sp)
    12f8:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12fa:	3e700893          	li	a7,999
    12fe:	4505                	li	a0,1
    1300:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1304:	00001717          	auipc	a4,0x1
    1308:	d2470713          	addi	a4,a4,-732 # 2028 <digits+0x18>
    130c:	04000893          	li	a7,64
    1310:	4505                	li	a0,1
    1312:	85ba                	mv	a1,a4
    1314:	4611                	li	a2,4
    1316:	00000073          	ecall
    return write(stdout, &byte, 1);
    131a:	4605                	li	a2,1
    131c:	00f10593          	addi	a1,sp,15
    1320:	4505                	li	a0,1
    char byte = c;
    1322:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1326:	1b1000ef          	jal	ra,1cd6 <write>
}
    132a:	60e2                	ld	ra,24(sp)
    132c:	2501                	sext.w	a0,a0
    132e:	6105                	addi	sp,sp,32
    1330:	8082                	ret

0000000000001332 <puts>:
{
    1332:	1141                	addi	sp,sp,-16
    1334:	e406                	sd	ra,8(sp)
    1336:	e022                	sd	s0,0(sp)
    1338:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    133a:	5b8000ef          	jal	ra,18f2 <strlen>
    133e:	862a                	mv	a2,a0
    1340:	85a2                	mv	a1,s0
    1342:	4505                	li	a0,1
    1344:	193000ef          	jal	ra,1cd6 <write>
}
    1348:	60a2                	ld	ra,8(sp)
    134a:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    134c:	957d                	srai	a0,a0,0x3f
    return r;
    134e:	2501                	sext.w	a0,a0
}
    1350:	0141                	addi	sp,sp,16
    1352:	8082                	ret

0000000000001354 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1354:	7171                	addi	sp,sp,-176
    1356:	e0d2                	sd	s4,64(sp)
    1358:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    135a:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    135c:	18bc                	addi	a5,sp,120
{
    135e:	e8ca                	sd	s2,80(sp)
    1360:	e4ce                	sd	s3,72(sp)
    1362:	fc56                	sd	s5,56(sp)
    1364:	f85a                	sd	s6,48(sp)
    1366:	f486                	sd	ra,104(sp)
    1368:	f0a2                	sd	s0,96(sp)
    136a:	eca6                	sd	s1,88(sp)
    136c:	fcae                	sd	a1,120(sp)
    136e:	e132                	sd	a2,128(sp)
    1370:	e536                	sd	a3,136(sp)
    1372:	e93a                	sd	a4,144(sp)
    1374:	f142                	sd	a6,160(sp)
    1376:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1378:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    137a:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    137e:	00001b17          	auipc	s6,0x1
    1382:	c62b0b13          	addi	s6,s6,-926 # 1fe0 <__clone+0xd2>
	::"r"((unsigned long long)ac)
    1386:	00001a97          	auipc	s5,0x1
    138a:	ca2a8a93          	addi	s5,s5,-862 # 2028 <digits+0x18>
    buf[i++] = '0';
    138e:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1392:	00001997          	auipc	s3,0x1
    1396:	c7e98993          	addi	s3,s3,-898 # 2010 <digits>
        if (!*s)
    139a:	00054783          	lbu	a5,0(a0)
    139e:	16078c63          	beqz	a5,1516 <printf+0x1c2>
    13a2:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13a4:	19278363          	beq	a5,s2,152a <printf+0x1d6>
    13a8:	00164783          	lbu	a5,1(a2)
    13ac:	0605                	addi	a2,a2,1
    13ae:	fbfd                	bnez	a5,13a4 <printf+0x50>
    13b0:	84b2                	mv	s1,a2
        l = z - a;
    13b2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13b6:	85aa                	mv	a1,a0
    13b8:	8622                	mv	a2,s0
    13ba:	4505                	li	a0,1
    13bc:	11b000ef          	jal	ra,1cd6 <write>
        if (l)
    13c0:	18041e63          	bnez	s0,155c <printf+0x208>
        if (s[1] == 0)
    13c4:	0014c783          	lbu	a5,1(s1)
    13c8:	14078763          	beqz	a5,1516 <printf+0x1c2>
        switch (s[1])
    13cc:	07300713          	li	a4,115
    13d0:	1ce78063          	beq	a5,a4,1590 <printf+0x23c>
    13d4:	18f76663          	bltu	a4,a5,1560 <printf+0x20c>
    13d8:	06400713          	li	a4,100
    13dc:	1ae78063          	beq	a5,a4,157c <printf+0x228>
    13e0:	07000713          	li	a4,112
    13e4:	1ce79963          	bne	a5,a4,15b6 <printf+0x262>
            printptr(va_arg(ap, uint64));
    13e8:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ea:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13ee:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13f0:	631c                	ld	a5,0(a4)
    13f2:	0721                	addi	a4,a4,8
    13f4:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13f6:	00479293          	slli	t0,a5,0x4
    13fa:	00879f93          	slli	t6,a5,0x8
    13fe:	00c79f13          	slli	t5,a5,0xc
    1402:	01079e93          	slli	t4,a5,0x10
    1406:	01479e13          	slli	t3,a5,0x14
    140a:	01879313          	slli	t1,a5,0x18
    140e:	01c79893          	slli	a7,a5,0x1c
    1412:	02479813          	slli	a6,a5,0x24
    1416:	02879513          	slli	a0,a5,0x28
    141a:	02c79593          	slli	a1,a5,0x2c
    141e:	03079693          	slli	a3,a5,0x30
    1422:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1426:	03c7d413          	srli	s0,a5,0x3c
    142a:	01c7d39b          	srliw	t2,a5,0x1c
    142e:	03c2d293          	srli	t0,t0,0x3c
    1432:	03cfdf93          	srli	t6,t6,0x3c
    1436:	03cf5f13          	srli	t5,t5,0x3c
    143a:	03cede93          	srli	t4,t4,0x3c
    143e:	03ce5e13          	srli	t3,t3,0x3c
    1442:	03c35313          	srli	t1,t1,0x3c
    1446:	03c8d893          	srli	a7,a7,0x3c
    144a:	03c85813          	srli	a6,a6,0x3c
    144e:	9171                	srli	a0,a0,0x3c
    1450:	91f1                	srli	a1,a1,0x3c
    1452:	92f1                	srli	a3,a3,0x3c
    1454:	9371                	srli	a4,a4,0x3c
    1456:	96ce                	add	a3,a3,s3
    1458:	974e                	add	a4,a4,s3
    145a:	944e                	add	s0,s0,s3
    145c:	92ce                	add	t0,t0,s3
    145e:	9fce                	add	t6,t6,s3
    1460:	9f4e                	add	t5,t5,s3
    1462:	9ece                	add	t4,t4,s3
    1464:	9e4e                	add	t3,t3,s3
    1466:	934e                	add	t1,t1,s3
    1468:	98ce                	add	a7,a7,s3
    146a:	93ce                	add	t2,t2,s3
    146c:	984e                	add	a6,a6,s3
    146e:	954e                	add	a0,a0,s3
    1470:	95ce                	add	a1,a1,s3
    1472:	0006c083          	lbu	ra,0(a3)
    1476:	0002c283          	lbu	t0,0(t0)
    147a:	00074683          	lbu	a3,0(a4)
    147e:	000fcf83          	lbu	t6,0(t6)
    1482:	000f4f03          	lbu	t5,0(t5)
    1486:	000ece83          	lbu	t4,0(t4)
    148a:	000e4e03          	lbu	t3,0(t3)
    148e:	00034303          	lbu	t1,0(t1)
    1492:	0008c883          	lbu	a7,0(a7)
    1496:	0003c383          	lbu	t2,0(t2)
    149a:	00084803          	lbu	a6,0(a6)
    149e:	00054503          	lbu	a0,0(a0)
    14a2:	0005c583          	lbu	a1,0(a1)
    14a6:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14aa:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ae:	9371                	srli	a4,a4,0x3c
    14b0:	8bbd                	andi	a5,a5,15
    14b2:	974e                	add	a4,a4,s3
    14b4:	97ce                	add	a5,a5,s3
    14b6:	005105a3          	sb	t0,11(sp)
    14ba:	01f10623          	sb	t6,12(sp)
    14be:	01e106a3          	sb	t5,13(sp)
    14c2:	01d10723          	sb	t4,14(sp)
    14c6:	01c107a3          	sb	t3,15(sp)
    14ca:	00610823          	sb	t1,16(sp)
    14ce:	011108a3          	sb	a7,17(sp)
    14d2:	00710923          	sb	t2,18(sp)
    14d6:	010109a3          	sb	a6,19(sp)
    14da:	00a10a23          	sb	a0,20(sp)
    14de:	00b10aa3          	sb	a1,21(sp)
    14e2:	00110b23          	sb	ra,22(sp)
    14e6:	00d10ba3          	sb	a3,23(sp)
    14ea:	00810523          	sb	s0,10(sp)
    14ee:	00074703          	lbu	a4,0(a4)
    14f2:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14f6:	002c                	addi	a1,sp,8
    14f8:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14fa:	00e10c23          	sb	a4,24(sp)
    14fe:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1502:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1506:	7d0000ef          	jal	ra,1cd6 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    150a:	00248513          	addi	a0,s1,2
        if (!*s)
    150e:	00054783          	lbu	a5,0(a0)
    1512:	e80798e3          	bnez	a5,13a2 <printf+0x4e>
    }
    va_end(ap);
}
    1516:	70a6                	ld	ra,104(sp)
    1518:	7406                	ld	s0,96(sp)
    151a:	64e6                	ld	s1,88(sp)
    151c:	6946                	ld	s2,80(sp)
    151e:	69a6                	ld	s3,72(sp)
    1520:	6a06                	ld	s4,64(sp)
    1522:	7ae2                	ld	s5,56(sp)
    1524:	7b42                	ld	s6,48(sp)
    1526:	614d                	addi	sp,sp,176
    1528:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    152a:	00064783          	lbu	a5,0(a2)
    152e:	84b2                	mv	s1,a2
    1530:	01278963          	beq	a5,s2,1542 <printf+0x1ee>
    1534:	bdbd                	j	13b2 <printf+0x5e>
    1536:	0024c783          	lbu	a5,2(s1)
    153a:	0605                	addi	a2,a2,1
    153c:	0489                	addi	s1,s1,2
    153e:	e7279ae3          	bne	a5,s2,13b2 <printf+0x5e>
    1542:	0014c783          	lbu	a5,1(s1)
    1546:	ff2788e3          	beq	a5,s2,1536 <printf+0x1e2>
        l = z - a;
    154a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    154e:	85aa                	mv	a1,a0
    1550:	8622                	mv	a2,s0
    1552:	4505                	li	a0,1
    1554:	782000ef          	jal	ra,1cd6 <write>
        if (l)
    1558:	e60406e3          	beqz	s0,13c4 <printf+0x70>
    155c:	8526                	mv	a0,s1
    155e:	bd35                	j	139a <printf+0x46>
        switch (s[1])
    1560:	07800713          	li	a4,120
    1564:	04e79963          	bne	a5,a4,15b6 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1568:	6782                	ld	a5,0(sp)
    156a:	45c1                	li	a1,16
    156c:	4388                	lw	a0,0(a5)
    156e:	07a1                	addi	a5,a5,8
    1570:	e03e                	sd	a5,0(sp)
    1572:	ba3ff0ef          	jal	ra,1114 <printint.constprop.0>
        s += 2;
    1576:	00248513          	addi	a0,s1,2
    157a:	bf51                	j	150e <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    157c:	6782                	ld	a5,0(sp)
    157e:	45a9                	li	a1,10
    1580:	4388                	lw	a0,0(a5)
    1582:	07a1                	addi	a5,a5,8
    1584:	e03e                	sd	a5,0(sp)
    1586:	b8fff0ef          	jal	ra,1114 <printint.constprop.0>
        s += 2;
    158a:	00248513          	addi	a0,s1,2
    158e:	b741                	j	150e <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1590:	6782                	ld	a5,0(sp)
    1592:	6380                	ld	s0,0(a5)
    1594:	07a1                	addi	a5,a5,8
    1596:	e03e                	sd	a5,0(sp)
    1598:	cc25                	beqz	s0,1610 <printf+0x2bc>
            l = strnlen(a, 200);
    159a:	0c800593          	li	a1,200
    159e:	8522                	mv	a0,s0
    15a0:	43e000ef          	jal	ra,19de <strnlen>
    write(f, s, l);
    15a4:	0005061b          	sext.w	a2,a0
    15a8:	85a2                	mv	a1,s0
    15aa:	4505                	li	a0,1
    15ac:	72a000ef          	jal	ra,1cd6 <write>
        s += 2;
    15b0:	00248513          	addi	a0,s1,2
    15b4:	bfa9                	j	150e <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15b6:	3e700893          	li	a7,999
    15ba:	4505                	li	a0,1
    15bc:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15c0:	04000893          	li	a7,64
    15c4:	4505                	li	a0,1
    15c6:	85d6                	mv	a1,s5
    15c8:	4611                	li	a2,4
    15ca:	00000073          	ecall
    char byte = c;
    15ce:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    15d2:	4605                	li	a2,1
    15d4:	002c                	addi	a1,sp,8
    15d6:	4505                	li	a0,1
    char byte = c;
    15d8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15dc:	6fa000ef          	jal	ra,1cd6 <write>
            putchar(s[1]);
    15e0:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15e4:	3e700893          	li	a7,999
    15e8:	4505                	li	a0,1
    15ea:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15ee:	04000893          	li	a7,64
    15f2:	4505                	li	a0,1
    15f4:	85d6                	mv	a1,s5
    15f6:	4611                	li	a2,4
    15f8:	00000073          	ecall
    return write(stdout, &byte, 1);
    15fc:	4605                	li	a2,1
    15fe:	002c                	addi	a1,sp,8
    1600:	4505                	li	a0,1
    char byte = c;
    1602:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1606:	6d0000ef          	jal	ra,1cd6 <write>
        s += 2;
    160a:	00248513          	addi	a0,s1,2
    160e:	b701                	j	150e <printf+0x1ba>
                a = "(null)";
    1610:	845a                	mv	s0,s6
    1612:	b761                	j	159a <printf+0x246>

0000000000001614 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1614:	1141                	addi	sp,sp,-16
    1616:	e406                	sd	ra,8(sp)
    puts(m);
    1618:	d1bff0ef          	jal	ra,1332 <puts>
    exit(-100);
}
    161c:	60a2                	ld	ra,8(sp)
    exit(-100);
    161e:	f9c00513          	li	a0,-100
}
    1622:	0141                	addi	sp,sp,16
    exit(-100);
    1624:	a709                	j	1d26 <exit>

0000000000001626 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1626:	02000793          	li	a5,32
    162a:	00f50663          	beq	a0,a5,1636 <isspace+0x10>
    162e:	355d                	addiw	a0,a0,-9
    1630:	00553513          	sltiu	a0,a0,5
    1634:	8082                	ret
    1636:	4505                	li	a0,1
}
    1638:	8082                	ret

000000000000163a <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    163a:	fd05051b          	addiw	a0,a0,-48
}
    163e:	00a53513          	sltiu	a0,a0,10
    1642:	8082                	ret

0000000000001644 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1644:	02000613          	li	a2,32
    1648:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    164a:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    164e:	ff77069b          	addiw	a3,a4,-9
    1652:	04c70d63          	beq	a4,a2,16ac <atoi+0x68>
    1656:	0007079b          	sext.w	a5,a4
    165a:	04d5f963          	bgeu	a1,a3,16ac <atoi+0x68>
        s++;
    switch (*s)
    165e:	02b00693          	li	a3,43
    1662:	04d70a63          	beq	a4,a3,16b6 <atoi+0x72>
    1666:	02d00693          	li	a3,45
    166a:	06d70463          	beq	a4,a3,16d2 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    166e:	fd07859b          	addiw	a1,a5,-48
    1672:	4625                	li	a2,9
    1674:	873e                	mv	a4,a5
    1676:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1678:	4e01                	li	t3,0
    while (isdigit(*s))
    167a:	04b66a63          	bltu	a2,a1,16ce <atoi+0x8a>
    int n = 0, neg = 0;
    167e:	4501                	li	a0,0
    while (isdigit(*s))
    1680:	4825                	li	a6,9
    1682:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1686:	0025179b          	slliw	a5,a0,0x2
    168a:	9d3d                	addw	a0,a0,a5
    168c:	fd07031b          	addiw	t1,a4,-48
    1690:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1694:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1698:	0685                	addi	a3,a3,1
    169a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    169e:	0006071b          	sext.w	a4,a2
    16a2:	feb870e3          	bgeu	a6,a1,1682 <atoi+0x3e>
    return neg ? n : -n;
    16a6:	000e0563          	beqz	t3,16b0 <atoi+0x6c>
}
    16aa:	8082                	ret
        s++;
    16ac:	0505                	addi	a0,a0,1
    16ae:	bf71                	j	164a <atoi+0x6>
    16b0:	4113053b          	subw	a0,t1,a7
    16b4:	8082                	ret
    while (isdigit(*s))
    16b6:	00154783          	lbu	a5,1(a0)
    16ba:	4625                	li	a2,9
        s++;
    16bc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16c0:	fd07859b          	addiw	a1,a5,-48
    16c4:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16c8:	4e01                	li	t3,0
    while (isdigit(*s))
    16ca:	fab67ae3          	bgeu	a2,a1,167e <atoi+0x3a>
    16ce:	4501                	li	a0,0
}
    16d0:	8082                	ret
    while (isdigit(*s))
    16d2:	00154783          	lbu	a5,1(a0)
    16d6:	4625                	li	a2,9
        s++;
    16d8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16dc:	fd07859b          	addiw	a1,a5,-48
    16e0:	0007871b          	sext.w	a4,a5
    16e4:	feb665e3          	bltu	a2,a1,16ce <atoi+0x8a>
        neg = 1;
    16e8:	4e05                	li	t3,1
    16ea:	bf51                	j	167e <atoi+0x3a>

00000000000016ec <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16ec:	16060d63          	beqz	a2,1866 <memset+0x17a>
    16f0:	40a007b3          	neg	a5,a0
    16f4:	8b9d                	andi	a5,a5,7
    16f6:	00778713          	addi	a4,a5,7
    16fa:	482d                	li	a6,11
    16fc:	0ff5f593          	zext.b	a1,a1
    1700:	fff60693          	addi	a3,a2,-1
    1704:	17076263          	bltu	a4,a6,1868 <memset+0x17c>
    1708:	16e6ea63          	bltu	a3,a4,187c <memset+0x190>
    170c:	16078563          	beqz	a5,1876 <memset+0x18a>
    1710:	00b50023          	sb	a1,0(a0)
    1714:	4705                	li	a4,1
    1716:	00150e93          	addi	t4,a0,1
    171a:	14e78c63          	beq	a5,a4,1872 <memset+0x186>
    171e:	00b500a3          	sb	a1,1(a0)
    1722:	4709                	li	a4,2
    1724:	00250e93          	addi	t4,a0,2
    1728:	14e78d63          	beq	a5,a4,1882 <memset+0x196>
    172c:	00b50123          	sb	a1,2(a0)
    1730:	470d                	li	a4,3
    1732:	00350e93          	addi	t4,a0,3
    1736:	12e78b63          	beq	a5,a4,186c <memset+0x180>
    173a:	00b501a3          	sb	a1,3(a0)
    173e:	4711                	li	a4,4
    1740:	00450e93          	addi	t4,a0,4
    1744:	14e78163          	beq	a5,a4,1886 <memset+0x19a>
    1748:	00b50223          	sb	a1,4(a0)
    174c:	4715                	li	a4,5
    174e:	00550e93          	addi	t4,a0,5
    1752:	12e78c63          	beq	a5,a4,188a <memset+0x19e>
    1756:	00b502a3          	sb	a1,5(a0)
    175a:	471d                	li	a4,7
    175c:	00650e93          	addi	t4,a0,6
    1760:	12e79763          	bne	a5,a4,188e <memset+0x1a2>
    1764:	00750e93          	addi	t4,a0,7
    1768:	00b50323          	sb	a1,6(a0)
    176c:	4f1d                	li	t5,7
    176e:	00859713          	slli	a4,a1,0x8
    1772:	8f4d                	or	a4,a4,a1
    1774:	01059e13          	slli	t3,a1,0x10
    1778:	01c76e33          	or	t3,a4,t3
    177c:	01859313          	slli	t1,a1,0x18
    1780:	006e6333          	or	t1,t3,t1
    1784:	02059893          	slli	a7,a1,0x20
    1788:	011368b3          	or	a7,t1,a7
    178c:	02859813          	slli	a6,a1,0x28
    1790:	40f60333          	sub	t1,a2,a5
    1794:	0108e833          	or	a6,a7,a6
    1798:	03059693          	slli	a3,a1,0x30
    179c:	00d866b3          	or	a3,a6,a3
    17a0:	03859713          	slli	a4,a1,0x38
    17a4:	97aa                	add	a5,a5,a0
    17a6:	ff837813          	andi	a6,t1,-8
    17aa:	8f55                	or	a4,a4,a3
    17ac:	00f806b3          	add	a3,a6,a5
    17b0:	e398                	sd	a4,0(a5)
    17b2:	07a1                	addi	a5,a5,8
    17b4:	fed79ee3          	bne	a5,a3,17b0 <memset+0xc4>
    17b8:	ff837693          	andi	a3,t1,-8
    17bc:	00de87b3          	add	a5,t4,a3
    17c0:	01e6873b          	addw	a4,a3,t5
    17c4:	0ad30663          	beq	t1,a3,1870 <memset+0x184>
    17c8:	00b78023          	sb	a1,0(a5)
    17cc:	0017069b          	addiw	a3,a4,1
    17d0:	08c6fb63          	bgeu	a3,a2,1866 <memset+0x17a>
    17d4:	00b780a3          	sb	a1,1(a5)
    17d8:	0027069b          	addiw	a3,a4,2
    17dc:	08c6f563          	bgeu	a3,a2,1866 <memset+0x17a>
    17e0:	00b78123          	sb	a1,2(a5)
    17e4:	0037069b          	addiw	a3,a4,3
    17e8:	06c6ff63          	bgeu	a3,a2,1866 <memset+0x17a>
    17ec:	00b781a3          	sb	a1,3(a5)
    17f0:	0047069b          	addiw	a3,a4,4
    17f4:	06c6f963          	bgeu	a3,a2,1866 <memset+0x17a>
    17f8:	00b78223          	sb	a1,4(a5)
    17fc:	0057069b          	addiw	a3,a4,5
    1800:	06c6f363          	bgeu	a3,a2,1866 <memset+0x17a>
    1804:	00b782a3          	sb	a1,5(a5)
    1808:	0067069b          	addiw	a3,a4,6
    180c:	04c6fd63          	bgeu	a3,a2,1866 <memset+0x17a>
    1810:	00b78323          	sb	a1,6(a5)
    1814:	0077069b          	addiw	a3,a4,7
    1818:	04c6f763          	bgeu	a3,a2,1866 <memset+0x17a>
    181c:	00b783a3          	sb	a1,7(a5)
    1820:	0087069b          	addiw	a3,a4,8
    1824:	04c6f163          	bgeu	a3,a2,1866 <memset+0x17a>
    1828:	00b78423          	sb	a1,8(a5)
    182c:	0097069b          	addiw	a3,a4,9
    1830:	02c6fb63          	bgeu	a3,a2,1866 <memset+0x17a>
    1834:	00b784a3          	sb	a1,9(a5)
    1838:	00a7069b          	addiw	a3,a4,10
    183c:	02c6f563          	bgeu	a3,a2,1866 <memset+0x17a>
    1840:	00b78523          	sb	a1,10(a5)
    1844:	00b7069b          	addiw	a3,a4,11
    1848:	00c6ff63          	bgeu	a3,a2,1866 <memset+0x17a>
    184c:	00b785a3          	sb	a1,11(a5)
    1850:	00c7069b          	addiw	a3,a4,12
    1854:	00c6f963          	bgeu	a3,a2,1866 <memset+0x17a>
    1858:	00b78623          	sb	a1,12(a5)
    185c:	2735                	addiw	a4,a4,13
    185e:	00c77463          	bgeu	a4,a2,1866 <memset+0x17a>
    1862:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1866:	8082                	ret
    1868:	472d                	li	a4,11
    186a:	bd79                	j	1708 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    186c:	4f0d                	li	t5,3
    186e:	b701                	j	176e <memset+0x82>
    1870:	8082                	ret
    1872:	4f05                	li	t5,1
    1874:	bded                	j	176e <memset+0x82>
    1876:	8eaa                	mv	t4,a0
    1878:	4f01                	li	t5,0
    187a:	bdd5                	j	176e <memset+0x82>
    187c:	87aa                	mv	a5,a0
    187e:	4701                	li	a4,0
    1880:	b7a1                	j	17c8 <memset+0xdc>
    1882:	4f09                	li	t5,2
    1884:	b5ed                	j	176e <memset+0x82>
    1886:	4f11                	li	t5,4
    1888:	b5dd                	j	176e <memset+0x82>
    188a:	4f15                	li	t5,5
    188c:	b5cd                	j	176e <memset+0x82>
    188e:	4f19                	li	t5,6
    1890:	bdf9                	j	176e <memset+0x82>

0000000000001892 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1892:	00054783          	lbu	a5,0(a0)
    1896:	0005c703          	lbu	a4,0(a1)
    189a:	00e79863          	bne	a5,a4,18aa <strcmp+0x18>
    189e:	0505                	addi	a0,a0,1
    18a0:	0585                	addi	a1,a1,1
    18a2:	fbe5                	bnez	a5,1892 <strcmp>
    18a4:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18a6:	9d19                	subw	a0,a0,a4
    18a8:	8082                	ret
    18aa:	0007851b          	sext.w	a0,a5
    18ae:	bfe5                	j	18a6 <strcmp+0x14>

00000000000018b0 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18b0:	ce05                	beqz	a2,18e8 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18b2:	00054703          	lbu	a4,0(a0)
    18b6:	0005c783          	lbu	a5,0(a1)
    18ba:	cb0d                	beqz	a4,18ec <strncmp+0x3c>
    if (!n--)
    18bc:	167d                	addi	a2,a2,-1
    18be:	00c506b3          	add	a3,a0,a2
    18c2:	a819                	j	18d8 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18c4:	00a68e63          	beq	a3,a0,18e0 <strncmp+0x30>
    18c8:	0505                	addi	a0,a0,1
    18ca:	00e79b63          	bne	a5,a4,18e0 <strncmp+0x30>
    18ce:	00054703          	lbu	a4,0(a0)
    18d2:	0005c783          	lbu	a5,0(a1)
    18d6:	cb19                	beqz	a4,18ec <strncmp+0x3c>
    18d8:	0005c783          	lbu	a5,0(a1)
    18dc:	0585                	addi	a1,a1,1
    18de:	f3fd                	bnez	a5,18c4 <strncmp+0x14>
        ;
    return *l - *r;
    18e0:	0007051b          	sext.w	a0,a4
    18e4:	9d1d                	subw	a0,a0,a5
    18e6:	8082                	ret
        return 0;
    18e8:	4501                	li	a0,0
}
    18ea:	8082                	ret
    18ec:	4501                	li	a0,0
    return *l - *r;
    18ee:	9d1d                	subw	a0,a0,a5
    18f0:	8082                	ret

00000000000018f2 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18f2:	00757793          	andi	a5,a0,7
    18f6:	cf89                	beqz	a5,1910 <strlen+0x1e>
    18f8:	87aa                	mv	a5,a0
    18fa:	a029                	j	1904 <strlen+0x12>
    18fc:	0785                	addi	a5,a5,1
    18fe:	0077f713          	andi	a4,a5,7
    1902:	cb01                	beqz	a4,1912 <strlen+0x20>
        if (!*s)
    1904:	0007c703          	lbu	a4,0(a5)
    1908:	fb75                	bnez	a4,18fc <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    190a:	40a78533          	sub	a0,a5,a0
}
    190e:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1910:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    1912:	6394                	ld	a3,0(a5)
    1914:	00000597          	auipc	a1,0x0
    1918:	6d45b583          	ld	a1,1748(a1) # 1fe8 <__clone+0xda>
    191c:	00000617          	auipc	a2,0x0
    1920:	6d463603          	ld	a2,1748(a2) # 1ff0 <__clone+0xe2>
    1924:	a019                	j	192a <strlen+0x38>
    1926:	6794                	ld	a3,8(a5)
    1928:	07a1                	addi	a5,a5,8
    192a:	00b68733          	add	a4,a3,a1
    192e:	fff6c693          	not	a3,a3
    1932:	8f75                	and	a4,a4,a3
    1934:	8f71                	and	a4,a4,a2
    1936:	db65                	beqz	a4,1926 <strlen+0x34>
    for (; *s; s++)
    1938:	0007c703          	lbu	a4,0(a5)
    193c:	d779                	beqz	a4,190a <strlen+0x18>
    193e:	0017c703          	lbu	a4,1(a5)
    1942:	0785                	addi	a5,a5,1
    1944:	d379                	beqz	a4,190a <strlen+0x18>
    1946:	0017c703          	lbu	a4,1(a5)
    194a:	0785                	addi	a5,a5,1
    194c:	fb6d                	bnez	a4,193e <strlen+0x4c>
    194e:	bf75                	j	190a <strlen+0x18>

0000000000001950 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1950:	00757713          	andi	a4,a0,7
{
    1954:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1956:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    195a:	cb19                	beqz	a4,1970 <memchr+0x20>
    195c:	ce25                	beqz	a2,19d4 <memchr+0x84>
    195e:	0007c703          	lbu	a4,0(a5)
    1962:	04b70e63          	beq	a4,a1,19be <memchr+0x6e>
    1966:	0785                	addi	a5,a5,1
    1968:	0077f713          	andi	a4,a5,7
    196c:	167d                	addi	a2,a2,-1
    196e:	f77d                	bnez	a4,195c <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1970:	4501                	li	a0,0
    if (n && *s != c)
    1972:	c235                	beqz	a2,19d6 <memchr+0x86>
    1974:	0007c703          	lbu	a4,0(a5)
    1978:	04b70363          	beq	a4,a1,19be <memchr+0x6e>
        size_t k = ONES * c;
    197c:	00000517          	auipc	a0,0x0
    1980:	67c53503          	ld	a0,1660(a0) # 1ff8 <__clone+0xea>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1984:	471d                	li	a4,7
        size_t k = ONES * c;
    1986:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    198a:	02c77a63          	bgeu	a4,a2,19be <memchr+0x6e>
    198e:	00000897          	auipc	a7,0x0
    1992:	65a8b883          	ld	a7,1626(a7) # 1fe8 <__clone+0xda>
    1996:	00000817          	auipc	a6,0x0
    199a:	65a83803          	ld	a6,1626(a6) # 1ff0 <__clone+0xe2>
    199e:	431d                	li	t1,7
    19a0:	a029                	j	19aa <memchr+0x5a>
    19a2:	1661                	addi	a2,a2,-8
    19a4:	07a1                	addi	a5,a5,8
    19a6:	02c37963          	bgeu	t1,a2,19d8 <memchr+0x88>
    19aa:	6398                	ld	a4,0(a5)
    19ac:	8f29                	xor	a4,a4,a0
    19ae:	011706b3          	add	a3,a4,a7
    19b2:	fff74713          	not	a4,a4
    19b6:	8f75                	and	a4,a4,a3
    19b8:	01077733          	and	a4,a4,a6
    19bc:	d37d                	beqz	a4,19a2 <memchr+0x52>
    19be:	853e                	mv	a0,a5
    19c0:	97b2                	add	a5,a5,a2
    19c2:	a021                	j	19ca <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19c4:	0505                	addi	a0,a0,1
    19c6:	00f50763          	beq	a0,a5,19d4 <memchr+0x84>
    19ca:	00054703          	lbu	a4,0(a0)
    19ce:	feb71be3          	bne	a4,a1,19c4 <memchr+0x74>
    19d2:	8082                	ret
    return n ? (void *)s : 0;
    19d4:	4501                	li	a0,0
}
    19d6:	8082                	ret
    return n ? (void *)s : 0;
    19d8:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19da:	f275                	bnez	a2,19be <memchr+0x6e>
}
    19dc:	8082                	ret

00000000000019de <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19de:	1101                	addi	sp,sp,-32
    19e0:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19e2:	862e                	mv	a2,a1
{
    19e4:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19e6:	4581                	li	a1,0
{
    19e8:	e426                	sd	s1,8(sp)
    19ea:	ec06                	sd	ra,24(sp)
    19ec:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19ee:	f63ff0ef          	jal	ra,1950 <memchr>
    return p ? p - s : n;
    19f2:	c519                	beqz	a0,1a00 <strnlen+0x22>
}
    19f4:	60e2                	ld	ra,24(sp)
    19f6:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19f8:	8d05                	sub	a0,a0,s1
}
    19fa:	64a2                	ld	s1,8(sp)
    19fc:	6105                	addi	sp,sp,32
    19fe:	8082                	ret
    1a00:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a02:	8522                	mv	a0,s0
}
    1a04:	6442                	ld	s0,16(sp)
    1a06:	64a2                	ld	s1,8(sp)
    1a08:	6105                	addi	sp,sp,32
    1a0a:	8082                	ret

0000000000001a0c <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a0c:	00b547b3          	xor	a5,a0,a1
    1a10:	8b9d                	andi	a5,a5,7
    1a12:	eb95                	bnez	a5,1a46 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a14:	0075f793          	andi	a5,a1,7
    1a18:	e7b1                	bnez	a5,1a64 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a1a:	6198                	ld	a4,0(a1)
    1a1c:	00000617          	auipc	a2,0x0
    1a20:	5cc63603          	ld	a2,1484(a2) # 1fe8 <__clone+0xda>
    1a24:	00000817          	auipc	a6,0x0
    1a28:	5cc83803          	ld	a6,1484(a6) # 1ff0 <__clone+0xe2>
    1a2c:	a029                	j	1a36 <strcpy+0x2a>
    1a2e:	e118                	sd	a4,0(a0)
    1a30:	6598                	ld	a4,8(a1)
    1a32:	05a1                	addi	a1,a1,8
    1a34:	0521                	addi	a0,a0,8
    1a36:	00c707b3          	add	a5,a4,a2
    1a3a:	fff74693          	not	a3,a4
    1a3e:	8ff5                	and	a5,a5,a3
    1a40:	0107f7b3          	and	a5,a5,a6
    1a44:	d7ed                	beqz	a5,1a2e <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a46:	0005c783          	lbu	a5,0(a1)
    1a4a:	00f50023          	sb	a5,0(a0)
    1a4e:	c785                	beqz	a5,1a76 <strcpy+0x6a>
    1a50:	0015c783          	lbu	a5,1(a1)
    1a54:	0505                	addi	a0,a0,1
    1a56:	0585                	addi	a1,a1,1
    1a58:	00f50023          	sb	a5,0(a0)
    1a5c:	fbf5                	bnez	a5,1a50 <strcpy+0x44>
        ;
    return d;
}
    1a5e:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a60:	0505                	addi	a0,a0,1
    1a62:	df45                	beqz	a4,1a1a <strcpy+0xe>
            if (!(*d = *s))
    1a64:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a68:	0585                	addi	a1,a1,1
    1a6a:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a6e:	00f50023          	sb	a5,0(a0)
    1a72:	f7fd                	bnez	a5,1a60 <strcpy+0x54>
}
    1a74:	8082                	ret
    1a76:	8082                	ret

0000000000001a78 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a78:	00b547b3          	xor	a5,a0,a1
    1a7c:	8b9d                	andi	a5,a5,7
    1a7e:	1a079863          	bnez	a5,1c2e <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a82:	0075f793          	andi	a5,a1,7
    1a86:	16078463          	beqz	a5,1bee <strncpy+0x176>
    1a8a:	ea01                	bnez	a2,1a9a <strncpy+0x22>
    1a8c:	a421                	j	1c94 <strncpy+0x21c>
    1a8e:	167d                	addi	a2,a2,-1
    1a90:	0505                	addi	a0,a0,1
    1a92:	14070e63          	beqz	a4,1bee <strncpy+0x176>
    1a96:	1a060863          	beqz	a2,1c46 <strncpy+0x1ce>
    1a9a:	0005c783          	lbu	a5,0(a1)
    1a9e:	0585                	addi	a1,a1,1
    1aa0:	0075f713          	andi	a4,a1,7
    1aa4:	00f50023          	sb	a5,0(a0)
    1aa8:	f3fd                	bnez	a5,1a8e <strncpy+0x16>
    1aaa:	4805                	li	a6,1
    1aac:	1a061863          	bnez	a2,1c5c <strncpy+0x1e4>
    1ab0:	40a007b3          	neg	a5,a0
    1ab4:	8b9d                	andi	a5,a5,7
    1ab6:	4681                	li	a3,0
    1ab8:	18061a63          	bnez	a2,1c4c <strncpy+0x1d4>
    1abc:	00778713          	addi	a4,a5,7
    1ac0:	45ad                	li	a1,11
    1ac2:	18b76363          	bltu	a4,a1,1c48 <strncpy+0x1d0>
    1ac6:	1ae6eb63          	bltu	a3,a4,1c7c <strncpy+0x204>
    1aca:	1a078363          	beqz	a5,1c70 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ace:	00050023          	sb	zero,0(a0)
    1ad2:	4685                	li	a3,1
    1ad4:	00150713          	addi	a4,a0,1
    1ad8:	18d78f63          	beq	a5,a3,1c76 <strncpy+0x1fe>
    1adc:	000500a3          	sb	zero,1(a0)
    1ae0:	4689                	li	a3,2
    1ae2:	00250713          	addi	a4,a0,2
    1ae6:	18d78e63          	beq	a5,a3,1c82 <strncpy+0x20a>
    1aea:	00050123          	sb	zero,2(a0)
    1aee:	468d                	li	a3,3
    1af0:	00350713          	addi	a4,a0,3
    1af4:	16d78c63          	beq	a5,a3,1c6c <strncpy+0x1f4>
    1af8:	000501a3          	sb	zero,3(a0)
    1afc:	4691                	li	a3,4
    1afe:	00450713          	addi	a4,a0,4
    1b02:	18d78263          	beq	a5,a3,1c86 <strncpy+0x20e>
    1b06:	00050223          	sb	zero,4(a0)
    1b0a:	4695                	li	a3,5
    1b0c:	00550713          	addi	a4,a0,5
    1b10:	16d78d63          	beq	a5,a3,1c8a <strncpy+0x212>
    1b14:	000502a3          	sb	zero,5(a0)
    1b18:	469d                	li	a3,7
    1b1a:	00650713          	addi	a4,a0,6
    1b1e:	16d79863          	bne	a5,a3,1c8e <strncpy+0x216>
    1b22:	00750713          	addi	a4,a0,7
    1b26:	00050323          	sb	zero,6(a0)
    1b2a:	40f80833          	sub	a6,a6,a5
    1b2e:	ff887593          	andi	a1,a6,-8
    1b32:	97aa                	add	a5,a5,a0
    1b34:	95be                	add	a1,a1,a5
    1b36:	0007b023          	sd	zero,0(a5)
    1b3a:	07a1                	addi	a5,a5,8
    1b3c:	feb79de3          	bne	a5,a1,1b36 <strncpy+0xbe>
    1b40:	ff887593          	andi	a1,a6,-8
    1b44:	9ead                	addw	a3,a3,a1
    1b46:	00b707b3          	add	a5,a4,a1
    1b4a:	12b80863          	beq	a6,a1,1c7a <strncpy+0x202>
    1b4e:	00078023          	sb	zero,0(a5)
    1b52:	0016871b          	addiw	a4,a3,1
    1b56:	0ec77863          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b5a:	000780a3          	sb	zero,1(a5)
    1b5e:	0026871b          	addiw	a4,a3,2
    1b62:	0ec77263          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b66:	00078123          	sb	zero,2(a5)
    1b6a:	0036871b          	addiw	a4,a3,3
    1b6e:	0cc77c63          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b72:	000781a3          	sb	zero,3(a5)
    1b76:	0046871b          	addiw	a4,a3,4
    1b7a:	0cc77663          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b7e:	00078223          	sb	zero,4(a5)
    1b82:	0056871b          	addiw	a4,a3,5
    1b86:	0cc77063          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b8a:	000782a3          	sb	zero,5(a5)
    1b8e:	0066871b          	addiw	a4,a3,6
    1b92:	0ac77a63          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1b96:	00078323          	sb	zero,6(a5)
    1b9a:	0076871b          	addiw	a4,a3,7
    1b9e:	0ac77463          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1ba2:	000783a3          	sb	zero,7(a5)
    1ba6:	0086871b          	addiw	a4,a3,8
    1baa:	08c77e63          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1bae:	00078423          	sb	zero,8(a5)
    1bb2:	0096871b          	addiw	a4,a3,9
    1bb6:	08c77863          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1bba:	000784a3          	sb	zero,9(a5)
    1bbe:	00a6871b          	addiw	a4,a3,10
    1bc2:	08c77263          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1bc6:	00078523          	sb	zero,10(a5)
    1bca:	00b6871b          	addiw	a4,a3,11
    1bce:	06c77c63          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1bd2:	000785a3          	sb	zero,11(a5)
    1bd6:	00c6871b          	addiw	a4,a3,12
    1bda:	06c77663          	bgeu	a4,a2,1c46 <strncpy+0x1ce>
    1bde:	00078623          	sb	zero,12(a5)
    1be2:	26b5                	addiw	a3,a3,13
    1be4:	06c6f163          	bgeu	a3,a2,1c46 <strncpy+0x1ce>
    1be8:	000786a3          	sb	zero,13(a5)
    1bec:	8082                	ret
            ;
        if (!n || !*s)
    1bee:	c645                	beqz	a2,1c96 <strncpy+0x21e>
    1bf0:	0005c783          	lbu	a5,0(a1)
    1bf4:	ea078be3          	beqz	a5,1aaa <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf8:	479d                	li	a5,7
    1bfa:	02c7ff63          	bgeu	a5,a2,1c38 <strncpy+0x1c0>
    1bfe:	00000897          	auipc	a7,0x0
    1c02:	3ea8b883          	ld	a7,1002(a7) # 1fe8 <__clone+0xda>
    1c06:	00000817          	auipc	a6,0x0
    1c0a:	3ea83803          	ld	a6,1002(a6) # 1ff0 <__clone+0xe2>
    1c0e:	431d                	li	t1,7
    1c10:	6198                	ld	a4,0(a1)
    1c12:	011707b3          	add	a5,a4,a7
    1c16:	fff74693          	not	a3,a4
    1c1a:	8ff5                	and	a5,a5,a3
    1c1c:	0107f7b3          	and	a5,a5,a6
    1c20:	ef81                	bnez	a5,1c38 <strncpy+0x1c0>
            *wd = *ws;
    1c22:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c24:	1661                	addi	a2,a2,-8
    1c26:	05a1                	addi	a1,a1,8
    1c28:	0521                	addi	a0,a0,8
    1c2a:	fec363e3          	bltu	t1,a2,1c10 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c2e:	e609                	bnez	a2,1c38 <strncpy+0x1c0>
    1c30:	a08d                	j	1c92 <strncpy+0x21a>
    1c32:	167d                	addi	a2,a2,-1
    1c34:	0505                	addi	a0,a0,1
    1c36:	ca01                	beqz	a2,1c46 <strncpy+0x1ce>
    1c38:	0005c783          	lbu	a5,0(a1)
    1c3c:	0585                	addi	a1,a1,1
    1c3e:	00f50023          	sb	a5,0(a0)
    1c42:	fbe5                	bnez	a5,1c32 <strncpy+0x1ba>
        ;
tail:
    1c44:	b59d                	j	1aaa <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c46:	8082                	ret
    1c48:	472d                	li	a4,11
    1c4a:	bdb5                	j	1ac6 <strncpy+0x4e>
    1c4c:	00778713          	addi	a4,a5,7
    1c50:	45ad                	li	a1,11
    1c52:	fff60693          	addi	a3,a2,-1
    1c56:	e6b778e3          	bgeu	a4,a1,1ac6 <strncpy+0x4e>
    1c5a:	b7fd                	j	1c48 <strncpy+0x1d0>
    1c5c:	40a007b3          	neg	a5,a0
    1c60:	8832                	mv	a6,a2
    1c62:	8b9d                	andi	a5,a5,7
    1c64:	4681                	li	a3,0
    1c66:	e4060be3          	beqz	a2,1abc <strncpy+0x44>
    1c6a:	b7cd                	j	1c4c <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c6c:	468d                	li	a3,3
    1c6e:	bd75                	j	1b2a <strncpy+0xb2>
    1c70:	872a                	mv	a4,a0
    1c72:	4681                	li	a3,0
    1c74:	bd5d                	j	1b2a <strncpy+0xb2>
    1c76:	4685                	li	a3,1
    1c78:	bd4d                	j	1b2a <strncpy+0xb2>
    1c7a:	8082                	ret
    1c7c:	87aa                	mv	a5,a0
    1c7e:	4681                	li	a3,0
    1c80:	b5f9                	j	1b4e <strncpy+0xd6>
    1c82:	4689                	li	a3,2
    1c84:	b55d                	j	1b2a <strncpy+0xb2>
    1c86:	4691                	li	a3,4
    1c88:	b54d                	j	1b2a <strncpy+0xb2>
    1c8a:	4695                	li	a3,5
    1c8c:	bd79                	j	1b2a <strncpy+0xb2>
    1c8e:	4699                	li	a3,6
    1c90:	bd69                	j	1b2a <strncpy+0xb2>
    1c92:	8082                	ret
    1c94:	8082                	ret
    1c96:	8082                	ret

0000000000001c98 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c98:	87aa                	mv	a5,a0
    1c9a:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c9c:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1ca0:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ca4:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1ca6:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ca8:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cac:	2501                	sext.w	a0,a0
    1cae:	8082                	ret

0000000000001cb0 <openat>:
    register long a7 __asm__("a7") = n;
    1cb0:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cb4:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cb8:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cbc:	2501                	sext.w	a0,a0
    1cbe:	8082                	ret

0000000000001cc0 <close>:
    register long a7 __asm__("a7") = n;
    1cc0:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cc4:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cc8:	2501                	sext.w	a0,a0
    1cca:	8082                	ret

0000000000001ccc <read>:
    register long a7 __asm__("a7") = n;
    1ccc:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cd0:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cd4:	8082                	ret

0000000000001cd6 <write>:
    register long a7 __asm__("a7") = n;
    1cd6:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cda:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cde:	8082                	ret

0000000000001ce0 <getpid>:
    register long a7 __asm__("a7") = n;
    1ce0:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1ce4:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <getppid>:
    register long a7 __asm__("a7") = n;
    1cec:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cf0:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cf8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cfc:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <fork>:
    register long a7 __asm__("a7") = n;
    1d04:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d08:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d0a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d0c:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d14:	85b2                	mv	a1,a2
    1d16:	863a                	mv	a2,a4
    if (stack)
    1d18:	c191                	beqz	a1,1d1c <clone+0x8>
	stack += stack_size;
    1d1a:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d1c:	4781                	li	a5,0
    1d1e:	4701                	li	a4,0
    1d20:	4681                	li	a3,0
    1d22:	2601                	sext.w	a2,a2
    1d24:	a2ed                	j	1f0e <__clone>

0000000000001d26 <exit>:
    register long a7 __asm__("a7") = n;
    1d26:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d2a:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d2e:	8082                	ret

0000000000001d30 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d30:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d34:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d36:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d3a:	2501                	sext.w	a0,a0
    1d3c:	8082                	ret

0000000000001d3e <exec>:
    register long a7 __asm__("a7") = n;
    1d3e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d42:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d46:	2501                	sext.w	a0,a0
    1d48:	8082                	ret

0000000000001d4a <execve>:
    register long a7 __asm__("a7") = n;
    1d4a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d4e:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d52:	2501                	sext.w	a0,a0
    1d54:	8082                	ret

0000000000001d56 <times>:
    register long a7 __asm__("a7") = n;
    1d56:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d5a:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d5e:	2501                	sext.w	a0,a0
    1d60:	8082                	ret

0000000000001d62 <get_time>:

int64 get_time()
{
    1d62:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d64:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d68:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d6a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6c:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d70:	2501                	sext.w	a0,a0
    1d72:	ed09                	bnez	a0,1d8c <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d74:	67a2                	ld	a5,8(sp)
    1d76:	3e800713          	li	a4,1000
    1d7a:	00015503          	lhu	a0,0(sp)
    1d7e:	02e7d7b3          	divu	a5,a5,a4
    1d82:	02e50533          	mul	a0,a0,a4
    1d86:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d88:	0141                	addi	sp,sp,16
    1d8a:	8082                	ret
        return -1;
    1d8c:	557d                	li	a0,-1
    1d8e:	bfed                	j	1d88 <get_time+0x26>

0000000000001d90 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d90:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d94:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d98:	2501                	sext.w	a0,a0
    1d9a:	8082                	ret

0000000000001d9c <time>:
    register long a7 __asm__("a7") = n;
    1d9c:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1da0:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <sleep>:

int sleep(unsigned long long time)
{
    1da8:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1daa:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1dac:	850a                	mv	a0,sp
    1dae:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1db0:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1db4:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db6:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dba:	e501                	bnez	a0,1dc2 <sleep+0x1a>
    return 0;
    1dbc:	4501                	li	a0,0
}
    1dbe:	0141                	addi	sp,sp,16
    1dc0:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dc2:	4502                	lw	a0,0(sp)
}
    1dc4:	0141                	addi	sp,sp,16
    1dc6:	8082                	ret

0000000000001dc8 <set_priority>:
    register long a7 __asm__("a7") = n;
    1dc8:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dcc:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dd4:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dd8:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1ddc:	8082                	ret

0000000000001dde <munmap>:
    register long a7 __asm__("a7") = n;
    1dde:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de2:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1de6:	2501                	sext.w	a0,a0
    1de8:	8082                	ret

0000000000001dea <wait>:

int wait(int *code)
{
    1dea:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dec:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1df0:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1df2:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1df4:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1df6:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dfa:	2501                	sext.w	a0,a0
    1dfc:	8082                	ret

0000000000001dfe <spawn>:
    register long a7 __asm__("a7") = n;
    1dfe:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e02:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e06:	2501                	sext.w	a0,a0
    1e08:	8082                	ret

0000000000001e0a <mailread>:
    register long a7 __asm__("a7") = n;
    1e0a:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e0e:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e12:	2501                	sext.w	a0,a0
    1e14:	8082                	ret

0000000000001e16 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e16:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1a:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e1e:	2501                	sext.w	a0,a0
    1e20:	8082                	ret

0000000000001e22 <fstat>:
    register long a7 __asm__("a7") = n;
    1e22:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e26:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e2a:	2501                	sext.w	a0,a0
    1e2c:	8082                	ret

0000000000001e2e <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e2e:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e30:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e34:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e36:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e3e:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e40:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e44:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e46:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e4a:	2501                	sext.w	a0,a0
    1e4c:	8082                	ret

0000000000001e4e <link>:

int link(char *old_path, char *new_path)
{
    1e4e:	87aa                	mv	a5,a0
    1e50:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e52:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e56:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e5a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e5c:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e60:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e62:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e66:	2501                	sext.w	a0,a0
    1e68:	8082                	ret

0000000000001e6a <unlink>:

int unlink(char *path)
{
    1e6a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e6c:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e70:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e74:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e76:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <uname>:
    register long a7 __asm__("a7") = n;
    1e7e:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e82:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <brk>:
    register long a7 __asm__("a7") = n;
    1e8a:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e8e:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e96:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e98:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e9c:	8082                	ret

0000000000001e9e <chdir>:
    register long a7 __asm__("a7") = n;
    1e9e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1ea2:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <mkdir>:

int mkdir(const char *path, mode_t mode){
    1eaa:	862e                	mv	a2,a1
    1eac:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1eae:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1eb0:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1eb4:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1eb8:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1eba:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ebc:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <getdents>:
    register long a7 __asm__("a7") = n;
    1ec4:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec8:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ecc:	2501                	sext.w	a0,a0
    1ece:	8082                	ret

0000000000001ed0 <pipe>:
    register long a7 __asm__("a7") = n;
    1ed0:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ed4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed6:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eda:	2501                	sext.w	a0,a0
    1edc:	8082                	ret

0000000000001ede <dup>:
    register long a7 __asm__("a7") = n;
    1ede:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ee0:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ee4:	2501                	sext.w	a0,a0
    1ee6:	8082                	ret

0000000000001ee8 <dup2>:
    register long a7 __asm__("a7") = n;
    1ee8:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eea:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eec:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ef0:	2501                	sext.w	a0,a0
    1ef2:	8082                	ret

0000000000001ef4 <mount>:
    register long a7 __asm__("a7") = n;
    1ef4:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ef8:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1efc:	2501                	sext.w	a0,a0
    1efe:	8082                	ret

0000000000001f00 <umount>:
    register long a7 __asm__("a7") = n;
    1f00:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f04:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f06:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f0a:	2501                	sext.w	a0,a0
    1f0c:	8082                	ret

0000000000001f0e <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f0e:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f10:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f12:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f14:	8532                	mv	a0,a2
	mv a2, a4
    1f16:	863a                	mv	a2,a4
	mv a3, a5
    1f18:	86be                	mv	a3,a5
	mv a4, a6
    1f1a:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f1c:	0dc00893          	li	a7,220
	ecall
    1f20:	00000073          	ecall

	beqz a0, 1f
    1f24:	c111                	beqz	a0,1f28 <__clone+0x1a>
	# Parent
	ret
    1f26:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f28:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f2a:	6522                	ld	a0,8(sp)
	jalr a1
    1f2c:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f2e:	05d00893          	li	a7,93
	ecall
    1f32:	00000073          	ecall
