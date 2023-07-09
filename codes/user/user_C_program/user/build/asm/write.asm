
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/write:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a851                	j	1096 <__start_main>

0000000000001004 <test_write>:
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

void test_write(){
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ed250513          	addi	a0,a0,-302 # 1ed8 <__clone+0x2e>
void test_write(){
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
	TEST_START(__func__);
    1012:	2bc000ef          	jal	ra,12ce <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f6250513          	addi	a0,a0,-158 # 1f78 <__func__.1191>
    101e:	2b0000ef          	jal	ra,12ce <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ece50513          	addi	a0,a0,-306 # 1ef0 <__clone+0x46>
    102a:	2a4000ef          	jal	ra,12ce <puts>
	const char *str = "Hello operating system contest.\n";
	int str_len = strlen(str);
    102e:	00001517          	auipc	a0,0x1
    1032:	ed250513          	addi	a0,a0,-302 # 1f00 <__clone+0x56>
    1036:	059000ef          	jal	ra,188e <strlen>
    103a:	0005041b          	sext.w	s0,a0
	assert(write(STDOUT, str, str_len) == str_len);
    103e:	8622                	mv	a2,s0
    1040:	00001597          	auipc	a1,0x1
    1044:	ec058593          	addi	a1,a1,-320 # 1f00 <__clone+0x56>
    1048:	4505                	li	a0,1
    104a:	429000ef          	jal	ra,1c72 <write>
    104e:	00850863          	beq	a0,s0,105e <test_write+0x5a>
    1052:	00001517          	auipc	a0,0x1
    1056:	ed650513          	addi	a0,a0,-298 # 1f28 <__clone+0x7e>
    105a:	556000ef          	jal	ra,15b0 <panic>
	TEST_END(__func__);
    105e:	00001517          	auipc	a0,0x1
    1062:	eea50513          	addi	a0,a0,-278 # 1f48 <__clone+0x9e>
    1066:	268000ef          	jal	ra,12ce <puts>
    106a:	00001517          	auipc	a0,0x1
    106e:	f0e50513          	addi	a0,a0,-242 # 1f78 <__func__.1191>
    1072:	25c000ef          	jal	ra,12ce <puts>
}
    1076:	6402                	ld	s0,0(sp)
    1078:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    107a:	00001517          	auipc	a0,0x1
    107e:	e7650513          	addi	a0,a0,-394 # 1ef0 <__clone+0x46>
}
    1082:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    1084:	a4a9                	j	12ce <puts>

0000000000001086 <main>:

int main(void) {
    1086:	1141                	addi	sp,sp,-16
    1088:	e406                	sd	ra,8(sp)
	test_write();
    108a:	f7bff0ef          	jal	ra,1004 <test_write>
	return 0;
}
    108e:	60a2                	ld	ra,8(sp)
    1090:	4501                	li	a0,0
    1092:	0141                	addi	sp,sp,16
    1094:	8082                	ret

0000000000001096 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1096:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1098:	4108                	lw	a0,0(a0)
{
    109a:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    109c:	05a1                	addi	a1,a1,8
{
    109e:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10a0:	fe7ff0ef          	jal	ra,1086 <main>
    10a4:	41f000ef          	jal	ra,1cc2 <exit>
	return 0;
}
    10a8:	60a2                	ld	ra,8(sp)
    10aa:	4501                	li	a0,0
    10ac:	0141                	addi	sp,sp,16
    10ae:	8082                	ret

00000000000010b0 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10b0:	7179                	addi	sp,sp,-48
    10b2:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10b4:	12054b63          	bltz	a0,11ea <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10b8:	02b577bb          	remuw	a5,a0,a1
    10bc:	00001697          	auipc	a3,0x1
    10c0:	ecc68693          	addi	a3,a3,-308 # 1f88 <digits>
    buf[16] = 0;
    10c4:	00010c23          	sb	zero,24(sp)
    i = 15;
    10c8:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10cc:	1782                	slli	a5,a5,0x20
    10ce:	9381                	srli	a5,a5,0x20
    10d0:	97b6                	add	a5,a5,a3
    10d2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10d6:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10da:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10de:	16b56263          	bltu	a0,a1,1242 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10e2:	02e8763b          	remuw	a2,a6,a4
    10e6:	1602                	slli	a2,a2,0x20
    10e8:	9201                	srli	a2,a2,0x20
    10ea:	9636                	add	a2,a2,a3
    10ec:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    10f0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    10f4:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    10f8:	12e86963          	bltu	a6,a4,122a <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    10fc:	02e5f63b          	remuw	a2,a1,a4
    1100:	1602                	slli	a2,a2,0x20
    1102:	9201                	srli	a2,a2,0x20
    1104:	9636                	add	a2,a2,a3
    1106:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    110a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    110e:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1112:	10e5ef63          	bltu	a1,a4,1230 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    1116:	02e8763b          	remuw	a2,a6,a4
    111a:	1602                	slli	a2,a2,0x20
    111c:	9201                	srli	a2,a2,0x20
    111e:	9636                	add	a2,a2,a3
    1120:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1124:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1128:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    112c:	10e86563          	bltu	a6,a4,1236 <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1130:	02e5f63b          	remuw	a2,a1,a4
    1134:	1602                	slli	a2,a2,0x20
    1136:	9201                	srli	a2,a2,0x20
    1138:	9636                	add	a2,a2,a3
    113a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    113e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1142:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    1146:	0ee5eb63          	bltu	a1,a4,123c <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    114a:	02e8763b          	remuw	a2,a6,a4
    114e:	1602                	slli	a2,a2,0x20
    1150:	9201                	srli	a2,a2,0x20
    1152:	9636                	add	a2,a2,a3
    1154:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1158:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    115c:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1160:	0ce86263          	bltu	a6,a4,1224 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1164:	02e5f63b          	remuw	a2,a1,a4
    1168:	1602                	slli	a2,a2,0x20
    116a:	9201                	srli	a2,a2,0x20
    116c:	9636                	add	a2,a2,a3
    116e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1172:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1176:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    117a:	0ce5e663          	bltu	a1,a4,1246 <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    117e:	02e8763b          	remuw	a2,a6,a4
    1182:	1602                	slli	a2,a2,0x20
    1184:	9201                	srli	a2,a2,0x20
    1186:	9636                	add	a2,a2,a3
    1188:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    118c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1190:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1194:	0ae86c63          	bltu	a6,a4,124c <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    1198:	02e5f63b          	remuw	a2,a1,a4
    119c:	1602                	slli	a2,a2,0x20
    119e:	9201                	srli	a2,a2,0x20
    11a0:	9636                	add	a2,a2,a3
    11a2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a6:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11aa:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11ae:	0ae5e263          	bltu	a1,a4,1252 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11b2:	1782                	slli	a5,a5,0x20
    11b4:	9381                	srli	a5,a5,0x20
    11b6:	97b6                	add	a5,a5,a3
    11b8:	0007c703          	lbu	a4,0(a5)
    11bc:	4599                	li	a1,6
    11be:	4795                	li	a5,5
    11c0:	00e10723          	sb	a4,14(sp)

    if (sign)
    11c4:	00055963          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11c8:	1018                	addi	a4,sp,32
    11ca:	973e                	add	a4,a4,a5
    11cc:	02d00693          	li	a3,45
    11d0:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11d4:	85be                	mv	a1,a5
    write(f, s, l);
    11d6:	003c                	addi	a5,sp,8
    11d8:	4641                	li	a2,16
    11da:	9e0d                	subw	a2,a2,a1
    11dc:	4505                	li	a0,1
    11de:	95be                	add	a1,a1,a5
    11e0:	293000ef          	jal	ra,1c72 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11e4:	70a2                	ld	ra,40(sp)
    11e6:	6145                	addi	sp,sp,48
    11e8:	8082                	ret
        x = -xx;
    11ea:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    11ee:	02b677bb          	remuw	a5,a2,a1
    11f2:	00001697          	auipc	a3,0x1
    11f6:	d9668693          	addi	a3,a3,-618 # 1f88 <digits>
    buf[16] = 0;
    11fa:	00010c23          	sb	zero,24(sp)
    i = 15;
    11fe:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1202:	1782                	slli	a5,a5,0x20
    1204:	9381                	srli	a5,a5,0x20
    1206:	97b6                	add	a5,a5,a3
    1208:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    120c:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1210:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1214:	ecb677e3          	bgeu	a2,a1,10e2 <printint.constprop.0+0x32>
        buf[i--] = '-';
    1218:	02d00793          	li	a5,45
    121c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1220:	45b9                	li	a1,14
    1222:	bf55                	j	11d6 <printint.constprop.0+0x126>
    1224:	47a5                	li	a5,9
    1226:	45a9                	li	a1,10
    1228:	bf71                	j	11c4 <printint.constprop.0+0x114>
    122a:	47b5                	li	a5,13
    122c:	45b9                	li	a1,14
    122e:	bf59                	j	11c4 <printint.constprop.0+0x114>
    1230:	47b1                	li	a5,12
    1232:	45b5                	li	a1,13
    1234:	bf41                	j	11c4 <printint.constprop.0+0x114>
    1236:	47ad                	li	a5,11
    1238:	45b1                	li	a1,12
    123a:	b769                	j	11c4 <printint.constprop.0+0x114>
    123c:	47a9                	li	a5,10
    123e:	45ad                	li	a1,11
    1240:	b751                	j	11c4 <printint.constprop.0+0x114>
    i = 15;
    1242:	45bd                	li	a1,15
    1244:	bf49                	j	11d6 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1246:	47a1                	li	a5,8
    1248:	45a5                	li	a1,9
    124a:	bfad                	j	11c4 <printint.constprop.0+0x114>
    124c:	479d                	li	a5,7
    124e:	45a1                	li	a1,8
    1250:	bf95                	j	11c4 <printint.constprop.0+0x114>
    1252:	4799                	li	a5,6
    1254:	459d                	li	a1,7
    1256:	b7bd                	j	11c4 <printint.constprop.0+0x114>

0000000000001258 <getchar>:
{
    1258:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    125a:	00f10593          	addi	a1,sp,15
    125e:	4605                	li	a2,1
    1260:	4501                	li	a0,0
{
    1262:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1264:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1268:	201000ef          	jal	ra,1c68 <read>
}
    126c:	60e2                	ld	ra,24(sp)
    126e:	00f14503          	lbu	a0,15(sp)
    1272:	6105                	addi	sp,sp,32
    1274:	8082                	ret

0000000000001276 <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1276:	00001797          	auipc	a5,0x1
    127a:	d2a78793          	addi	a5,a5,-726 # 1fa0 <digits+0x18>
    127e:	04000893          	li	a7,64
    1282:	4505                	li	a0,1
    1284:	85be                	mv	a1,a5
    1286:	4611                	li	a2,4
    1288:	00000073          	ecall
}
    128c:	4501                	li	a0,0
    128e:	8082                	ret

0000000000001290 <putchar>:
{
    1290:	1101                	addi	sp,sp,-32
    1292:	ec06                	sd	ra,24(sp)
    1294:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1296:	3e700893          	li	a7,999
    129a:	4505                	li	a0,1
    129c:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12a0:	00001717          	auipc	a4,0x1
    12a4:	d0070713          	addi	a4,a4,-768 # 1fa0 <digits+0x18>
    12a8:	04000893          	li	a7,64
    12ac:	4505                	li	a0,1
    12ae:	85ba                	mv	a1,a4
    12b0:	4611                	li	a2,4
    12b2:	00000073          	ecall
    return write(stdout, &byte, 1);
    12b6:	4605                	li	a2,1
    12b8:	00f10593          	addi	a1,sp,15
    12bc:	4505                	li	a0,1
    char byte = c;
    12be:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12c2:	1b1000ef          	jal	ra,1c72 <write>
}
    12c6:	60e2                	ld	ra,24(sp)
    12c8:	2501                	sext.w	a0,a0
    12ca:	6105                	addi	sp,sp,32
    12cc:	8082                	ret

00000000000012ce <puts>:
{
    12ce:	1141                	addi	sp,sp,-16
    12d0:	e406                	sd	ra,8(sp)
    12d2:	e022                	sd	s0,0(sp)
    12d4:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12d6:	5b8000ef          	jal	ra,188e <strlen>
    12da:	862a                	mv	a2,a0
    12dc:	85a2                	mv	a1,s0
    12de:	4505                	li	a0,1
    12e0:	193000ef          	jal	ra,1c72 <write>
}
    12e4:	60a2                	ld	ra,8(sp)
    12e6:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12e8:	957d                	srai	a0,a0,0x3f
    return r;
    12ea:	2501                	sext.w	a0,a0
}
    12ec:	0141                	addi	sp,sp,16
    12ee:	8082                	ret

00000000000012f0 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12f0:	7171                	addi	sp,sp,-176
    12f2:	e0d2                	sd	s4,64(sp)
    12f4:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    12f6:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    12f8:	18bc                	addi	a5,sp,120
{
    12fa:	e8ca                	sd	s2,80(sp)
    12fc:	e4ce                	sd	s3,72(sp)
    12fe:	fc56                	sd	s5,56(sp)
    1300:	f85a                	sd	s6,48(sp)
    1302:	f486                	sd	ra,104(sp)
    1304:	f0a2                	sd	s0,96(sp)
    1306:	eca6                	sd	s1,88(sp)
    1308:	fcae                	sd	a1,120(sp)
    130a:	e132                	sd	a2,128(sp)
    130c:	e536                	sd	a3,136(sp)
    130e:	e93a                	sd	a4,144(sp)
    1310:	f142                	sd	a6,160(sp)
    1312:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1314:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1316:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    131a:	00001b17          	auipc	s6,0x1
    131e:	c3eb0b13          	addi	s6,s6,-962 # 1f58 <__clone+0xae>
	::"r"((unsigned long long)ac)
    1322:	00001a97          	auipc	s5,0x1
    1326:	c7ea8a93          	addi	s5,s5,-898 # 1fa0 <digits+0x18>
    buf[i++] = '0';
    132a:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    132e:	00001997          	auipc	s3,0x1
    1332:	c5a98993          	addi	s3,s3,-934 # 1f88 <digits>
        if (!*s)
    1336:	00054783          	lbu	a5,0(a0)
    133a:	16078c63          	beqz	a5,14b2 <printf+0x1c2>
    133e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1340:	19278363          	beq	a5,s2,14c6 <printf+0x1d6>
    1344:	00164783          	lbu	a5,1(a2)
    1348:	0605                	addi	a2,a2,1
    134a:	fbfd                	bnez	a5,1340 <printf+0x50>
    134c:	84b2                	mv	s1,a2
        l = z - a;
    134e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1352:	85aa                	mv	a1,a0
    1354:	8622                	mv	a2,s0
    1356:	4505                	li	a0,1
    1358:	11b000ef          	jal	ra,1c72 <write>
        if (l)
    135c:	18041e63          	bnez	s0,14f8 <printf+0x208>
        if (s[1] == 0)
    1360:	0014c783          	lbu	a5,1(s1)
    1364:	14078763          	beqz	a5,14b2 <printf+0x1c2>
        switch (s[1])
    1368:	07300713          	li	a4,115
    136c:	1ce78063          	beq	a5,a4,152c <printf+0x23c>
    1370:	18f76663          	bltu	a4,a5,14fc <printf+0x20c>
    1374:	06400713          	li	a4,100
    1378:	1ae78063          	beq	a5,a4,1518 <printf+0x228>
    137c:	07000713          	li	a4,112
    1380:	1ce79963          	bne	a5,a4,1552 <printf+0x262>
            printptr(va_arg(ap, uint64));
    1384:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1386:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    138a:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    138c:	631c                	ld	a5,0(a4)
    138e:	0721                	addi	a4,a4,8
    1390:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1392:	00479293          	slli	t0,a5,0x4
    1396:	00879f93          	slli	t6,a5,0x8
    139a:	00c79f13          	slli	t5,a5,0xc
    139e:	01079e93          	slli	t4,a5,0x10
    13a2:	01479e13          	slli	t3,a5,0x14
    13a6:	01879313          	slli	t1,a5,0x18
    13aa:	01c79893          	slli	a7,a5,0x1c
    13ae:	02479813          	slli	a6,a5,0x24
    13b2:	02879513          	slli	a0,a5,0x28
    13b6:	02c79593          	slli	a1,a5,0x2c
    13ba:	03079693          	slli	a3,a5,0x30
    13be:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13c2:	03c7d413          	srli	s0,a5,0x3c
    13c6:	01c7d39b          	srliw	t2,a5,0x1c
    13ca:	03c2d293          	srli	t0,t0,0x3c
    13ce:	03cfdf93          	srli	t6,t6,0x3c
    13d2:	03cf5f13          	srli	t5,t5,0x3c
    13d6:	03cede93          	srli	t4,t4,0x3c
    13da:	03ce5e13          	srli	t3,t3,0x3c
    13de:	03c35313          	srli	t1,t1,0x3c
    13e2:	03c8d893          	srli	a7,a7,0x3c
    13e6:	03c85813          	srli	a6,a6,0x3c
    13ea:	9171                	srli	a0,a0,0x3c
    13ec:	91f1                	srli	a1,a1,0x3c
    13ee:	92f1                	srli	a3,a3,0x3c
    13f0:	9371                	srli	a4,a4,0x3c
    13f2:	96ce                	add	a3,a3,s3
    13f4:	974e                	add	a4,a4,s3
    13f6:	944e                	add	s0,s0,s3
    13f8:	92ce                	add	t0,t0,s3
    13fa:	9fce                	add	t6,t6,s3
    13fc:	9f4e                	add	t5,t5,s3
    13fe:	9ece                	add	t4,t4,s3
    1400:	9e4e                	add	t3,t3,s3
    1402:	934e                	add	t1,t1,s3
    1404:	98ce                	add	a7,a7,s3
    1406:	93ce                	add	t2,t2,s3
    1408:	984e                	add	a6,a6,s3
    140a:	954e                	add	a0,a0,s3
    140c:	95ce                	add	a1,a1,s3
    140e:	0006c083          	lbu	ra,0(a3)
    1412:	0002c283          	lbu	t0,0(t0)
    1416:	00074683          	lbu	a3,0(a4)
    141a:	000fcf83          	lbu	t6,0(t6)
    141e:	000f4f03          	lbu	t5,0(t5)
    1422:	000ece83          	lbu	t4,0(t4)
    1426:	000e4e03          	lbu	t3,0(t3)
    142a:	00034303          	lbu	t1,0(t1)
    142e:	0008c883          	lbu	a7,0(a7)
    1432:	0003c383          	lbu	t2,0(t2)
    1436:	00084803          	lbu	a6,0(a6)
    143a:	00054503          	lbu	a0,0(a0)
    143e:	0005c583          	lbu	a1,0(a1)
    1442:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1446:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    144a:	9371                	srli	a4,a4,0x3c
    144c:	8bbd                	andi	a5,a5,15
    144e:	974e                	add	a4,a4,s3
    1450:	97ce                	add	a5,a5,s3
    1452:	005105a3          	sb	t0,11(sp)
    1456:	01f10623          	sb	t6,12(sp)
    145a:	01e106a3          	sb	t5,13(sp)
    145e:	01d10723          	sb	t4,14(sp)
    1462:	01c107a3          	sb	t3,15(sp)
    1466:	00610823          	sb	t1,16(sp)
    146a:	011108a3          	sb	a7,17(sp)
    146e:	00710923          	sb	t2,18(sp)
    1472:	010109a3          	sb	a6,19(sp)
    1476:	00a10a23          	sb	a0,20(sp)
    147a:	00b10aa3          	sb	a1,21(sp)
    147e:	00110b23          	sb	ra,22(sp)
    1482:	00d10ba3          	sb	a3,23(sp)
    1486:	00810523          	sb	s0,10(sp)
    148a:	00074703          	lbu	a4,0(a4)
    148e:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1492:	002c                	addi	a1,sp,8
    1494:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1496:	00e10c23          	sb	a4,24(sp)
    149a:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    149e:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14a2:	7d0000ef          	jal	ra,1c72 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14a6:	00248513          	addi	a0,s1,2
        if (!*s)
    14aa:	00054783          	lbu	a5,0(a0)
    14ae:	e80798e3          	bnez	a5,133e <printf+0x4e>
    }
    va_end(ap);
}
    14b2:	70a6                	ld	ra,104(sp)
    14b4:	7406                	ld	s0,96(sp)
    14b6:	64e6                	ld	s1,88(sp)
    14b8:	6946                	ld	s2,80(sp)
    14ba:	69a6                	ld	s3,72(sp)
    14bc:	6a06                	ld	s4,64(sp)
    14be:	7ae2                	ld	s5,56(sp)
    14c0:	7b42                	ld	s6,48(sp)
    14c2:	614d                	addi	sp,sp,176
    14c4:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14c6:	00064783          	lbu	a5,0(a2)
    14ca:	84b2                	mv	s1,a2
    14cc:	01278963          	beq	a5,s2,14de <printf+0x1ee>
    14d0:	bdbd                	j	134e <printf+0x5e>
    14d2:	0024c783          	lbu	a5,2(s1)
    14d6:	0605                	addi	a2,a2,1
    14d8:	0489                	addi	s1,s1,2
    14da:	e7279ae3          	bne	a5,s2,134e <printf+0x5e>
    14de:	0014c783          	lbu	a5,1(s1)
    14e2:	ff2788e3          	beq	a5,s2,14d2 <printf+0x1e2>
        l = z - a;
    14e6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14ea:	85aa                	mv	a1,a0
    14ec:	8622                	mv	a2,s0
    14ee:	4505                	li	a0,1
    14f0:	782000ef          	jal	ra,1c72 <write>
        if (l)
    14f4:	e60406e3          	beqz	s0,1360 <printf+0x70>
    14f8:	8526                	mv	a0,s1
    14fa:	bd35                	j	1336 <printf+0x46>
        switch (s[1])
    14fc:	07800713          	li	a4,120
    1500:	04e79963          	bne	a5,a4,1552 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1504:	6782                	ld	a5,0(sp)
    1506:	45c1                	li	a1,16
    1508:	4388                	lw	a0,0(a5)
    150a:	07a1                	addi	a5,a5,8
    150c:	e03e                	sd	a5,0(sp)
    150e:	ba3ff0ef          	jal	ra,10b0 <printint.constprop.0>
        s += 2;
    1512:	00248513          	addi	a0,s1,2
    1516:	bf51                	j	14aa <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1518:	6782                	ld	a5,0(sp)
    151a:	45a9                	li	a1,10
    151c:	4388                	lw	a0,0(a5)
    151e:	07a1                	addi	a5,a5,8
    1520:	e03e                	sd	a5,0(sp)
    1522:	b8fff0ef          	jal	ra,10b0 <printint.constprop.0>
        s += 2;
    1526:	00248513          	addi	a0,s1,2
    152a:	b741                	j	14aa <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    152c:	6782                	ld	a5,0(sp)
    152e:	6380                	ld	s0,0(a5)
    1530:	07a1                	addi	a5,a5,8
    1532:	e03e                	sd	a5,0(sp)
    1534:	cc25                	beqz	s0,15ac <printf+0x2bc>
            l = strnlen(a, 200);
    1536:	0c800593          	li	a1,200
    153a:	8522                	mv	a0,s0
    153c:	43e000ef          	jal	ra,197a <strnlen>
    write(f, s, l);
    1540:	0005061b          	sext.w	a2,a0
    1544:	85a2                	mv	a1,s0
    1546:	4505                	li	a0,1
    1548:	72a000ef          	jal	ra,1c72 <write>
        s += 2;
    154c:	00248513          	addi	a0,s1,2
    1550:	bfa9                	j	14aa <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1552:	3e700893          	li	a7,999
    1556:	4505                	li	a0,1
    1558:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    155c:	04000893          	li	a7,64
    1560:	4505                	li	a0,1
    1562:	85d6                	mv	a1,s5
    1564:	4611                	li	a2,4
    1566:	00000073          	ecall
    char byte = c;
    156a:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    156e:	4605                	li	a2,1
    1570:	002c                	addi	a1,sp,8
    1572:	4505                	li	a0,1
    char byte = c;
    1574:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1578:	6fa000ef          	jal	ra,1c72 <write>
            putchar(s[1]);
    157c:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1580:	3e700893          	li	a7,999
    1584:	4505                	li	a0,1
    1586:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    158a:	04000893          	li	a7,64
    158e:	4505                	li	a0,1
    1590:	85d6                	mv	a1,s5
    1592:	4611                	li	a2,4
    1594:	00000073          	ecall
    return write(stdout, &byte, 1);
    1598:	4605                	li	a2,1
    159a:	002c                	addi	a1,sp,8
    159c:	4505                	li	a0,1
    char byte = c;
    159e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15a2:	6d0000ef          	jal	ra,1c72 <write>
        s += 2;
    15a6:	00248513          	addi	a0,s1,2
    15aa:	b701                	j	14aa <printf+0x1ba>
                a = "(null)";
    15ac:	845a                	mv	s0,s6
    15ae:	b761                	j	1536 <printf+0x246>

00000000000015b0 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15b0:	1141                	addi	sp,sp,-16
    15b2:	e406                	sd	ra,8(sp)
    puts(m);
    15b4:	d1bff0ef          	jal	ra,12ce <puts>
    exit(-100);
}
    15b8:	60a2                	ld	ra,8(sp)
    exit(-100);
    15ba:	f9c00513          	li	a0,-100
}
    15be:	0141                	addi	sp,sp,16
    exit(-100);
    15c0:	a709                	j	1cc2 <exit>

00000000000015c2 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15c2:	02000793          	li	a5,32
    15c6:	00f50663          	beq	a0,a5,15d2 <isspace+0x10>
    15ca:	355d                	addiw	a0,a0,-9
    15cc:	00553513          	sltiu	a0,a0,5
    15d0:	8082                	ret
    15d2:	4505                	li	a0,1
}
    15d4:	8082                	ret

00000000000015d6 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15d6:	fd05051b          	addiw	a0,a0,-48
}
    15da:	00a53513          	sltiu	a0,a0,10
    15de:	8082                	ret

00000000000015e0 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e0:	02000613          	li	a2,32
    15e4:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15e6:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ea:	ff77069b          	addiw	a3,a4,-9
    15ee:	04c70d63          	beq	a4,a2,1648 <atoi+0x68>
    15f2:	0007079b          	sext.w	a5,a4
    15f6:	04d5f963          	bgeu	a1,a3,1648 <atoi+0x68>
        s++;
    switch (*s)
    15fa:	02b00693          	li	a3,43
    15fe:	04d70a63          	beq	a4,a3,1652 <atoi+0x72>
    1602:	02d00693          	li	a3,45
    1606:	06d70463          	beq	a4,a3,166e <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    160a:	fd07859b          	addiw	a1,a5,-48
    160e:	4625                	li	a2,9
    1610:	873e                	mv	a4,a5
    1612:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1614:	4e01                	li	t3,0
    while (isdigit(*s))
    1616:	04b66a63          	bltu	a2,a1,166a <atoi+0x8a>
    int n = 0, neg = 0;
    161a:	4501                	li	a0,0
    while (isdigit(*s))
    161c:	4825                	li	a6,9
    161e:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1622:	0025179b          	slliw	a5,a0,0x2
    1626:	9d3d                	addw	a0,a0,a5
    1628:	fd07031b          	addiw	t1,a4,-48
    162c:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1630:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1634:	0685                	addi	a3,a3,1
    1636:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    163a:	0006071b          	sext.w	a4,a2
    163e:	feb870e3          	bgeu	a6,a1,161e <atoi+0x3e>
    return neg ? n : -n;
    1642:	000e0563          	beqz	t3,164c <atoi+0x6c>
}
    1646:	8082                	ret
        s++;
    1648:	0505                	addi	a0,a0,1
    164a:	bf71                	j	15e6 <atoi+0x6>
    164c:	4113053b          	subw	a0,t1,a7
    1650:	8082                	ret
    while (isdigit(*s))
    1652:	00154783          	lbu	a5,1(a0)
    1656:	4625                	li	a2,9
        s++;
    1658:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    165c:	fd07859b          	addiw	a1,a5,-48
    1660:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1664:	4e01                	li	t3,0
    while (isdigit(*s))
    1666:	fab67ae3          	bgeu	a2,a1,161a <atoi+0x3a>
    166a:	4501                	li	a0,0
}
    166c:	8082                	ret
    while (isdigit(*s))
    166e:	00154783          	lbu	a5,1(a0)
    1672:	4625                	li	a2,9
        s++;
    1674:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1678:	fd07859b          	addiw	a1,a5,-48
    167c:	0007871b          	sext.w	a4,a5
    1680:	feb665e3          	bltu	a2,a1,166a <atoi+0x8a>
        neg = 1;
    1684:	4e05                	li	t3,1
    1686:	bf51                	j	161a <atoi+0x3a>

0000000000001688 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1688:	16060d63          	beqz	a2,1802 <memset+0x17a>
    168c:	40a007b3          	neg	a5,a0
    1690:	8b9d                	andi	a5,a5,7
    1692:	00778713          	addi	a4,a5,7
    1696:	482d                	li	a6,11
    1698:	0ff5f593          	zext.b	a1,a1
    169c:	fff60693          	addi	a3,a2,-1
    16a0:	17076263          	bltu	a4,a6,1804 <memset+0x17c>
    16a4:	16e6ea63          	bltu	a3,a4,1818 <memset+0x190>
    16a8:	16078563          	beqz	a5,1812 <memset+0x18a>
    16ac:	00b50023          	sb	a1,0(a0)
    16b0:	4705                	li	a4,1
    16b2:	00150e93          	addi	t4,a0,1
    16b6:	14e78c63          	beq	a5,a4,180e <memset+0x186>
    16ba:	00b500a3          	sb	a1,1(a0)
    16be:	4709                	li	a4,2
    16c0:	00250e93          	addi	t4,a0,2
    16c4:	14e78d63          	beq	a5,a4,181e <memset+0x196>
    16c8:	00b50123          	sb	a1,2(a0)
    16cc:	470d                	li	a4,3
    16ce:	00350e93          	addi	t4,a0,3
    16d2:	12e78b63          	beq	a5,a4,1808 <memset+0x180>
    16d6:	00b501a3          	sb	a1,3(a0)
    16da:	4711                	li	a4,4
    16dc:	00450e93          	addi	t4,a0,4
    16e0:	14e78163          	beq	a5,a4,1822 <memset+0x19a>
    16e4:	00b50223          	sb	a1,4(a0)
    16e8:	4715                	li	a4,5
    16ea:	00550e93          	addi	t4,a0,5
    16ee:	12e78c63          	beq	a5,a4,1826 <memset+0x19e>
    16f2:	00b502a3          	sb	a1,5(a0)
    16f6:	471d                	li	a4,7
    16f8:	00650e93          	addi	t4,a0,6
    16fc:	12e79763          	bne	a5,a4,182a <memset+0x1a2>
    1700:	00750e93          	addi	t4,a0,7
    1704:	00b50323          	sb	a1,6(a0)
    1708:	4f1d                	li	t5,7
    170a:	00859713          	slli	a4,a1,0x8
    170e:	8f4d                	or	a4,a4,a1
    1710:	01059e13          	slli	t3,a1,0x10
    1714:	01c76e33          	or	t3,a4,t3
    1718:	01859313          	slli	t1,a1,0x18
    171c:	006e6333          	or	t1,t3,t1
    1720:	02059893          	slli	a7,a1,0x20
    1724:	011368b3          	or	a7,t1,a7
    1728:	02859813          	slli	a6,a1,0x28
    172c:	40f60333          	sub	t1,a2,a5
    1730:	0108e833          	or	a6,a7,a6
    1734:	03059693          	slli	a3,a1,0x30
    1738:	00d866b3          	or	a3,a6,a3
    173c:	03859713          	slli	a4,a1,0x38
    1740:	97aa                	add	a5,a5,a0
    1742:	ff837813          	andi	a6,t1,-8
    1746:	8f55                	or	a4,a4,a3
    1748:	00f806b3          	add	a3,a6,a5
    174c:	e398                	sd	a4,0(a5)
    174e:	07a1                	addi	a5,a5,8
    1750:	fed79ee3          	bne	a5,a3,174c <memset+0xc4>
    1754:	ff837693          	andi	a3,t1,-8
    1758:	00de87b3          	add	a5,t4,a3
    175c:	01e6873b          	addw	a4,a3,t5
    1760:	0ad30663          	beq	t1,a3,180c <memset+0x184>
    1764:	00b78023          	sb	a1,0(a5)
    1768:	0017069b          	addiw	a3,a4,1
    176c:	08c6fb63          	bgeu	a3,a2,1802 <memset+0x17a>
    1770:	00b780a3          	sb	a1,1(a5)
    1774:	0027069b          	addiw	a3,a4,2
    1778:	08c6f563          	bgeu	a3,a2,1802 <memset+0x17a>
    177c:	00b78123          	sb	a1,2(a5)
    1780:	0037069b          	addiw	a3,a4,3
    1784:	06c6ff63          	bgeu	a3,a2,1802 <memset+0x17a>
    1788:	00b781a3          	sb	a1,3(a5)
    178c:	0047069b          	addiw	a3,a4,4
    1790:	06c6f963          	bgeu	a3,a2,1802 <memset+0x17a>
    1794:	00b78223          	sb	a1,4(a5)
    1798:	0057069b          	addiw	a3,a4,5
    179c:	06c6f363          	bgeu	a3,a2,1802 <memset+0x17a>
    17a0:	00b782a3          	sb	a1,5(a5)
    17a4:	0067069b          	addiw	a3,a4,6
    17a8:	04c6fd63          	bgeu	a3,a2,1802 <memset+0x17a>
    17ac:	00b78323          	sb	a1,6(a5)
    17b0:	0077069b          	addiw	a3,a4,7
    17b4:	04c6f763          	bgeu	a3,a2,1802 <memset+0x17a>
    17b8:	00b783a3          	sb	a1,7(a5)
    17bc:	0087069b          	addiw	a3,a4,8
    17c0:	04c6f163          	bgeu	a3,a2,1802 <memset+0x17a>
    17c4:	00b78423          	sb	a1,8(a5)
    17c8:	0097069b          	addiw	a3,a4,9
    17cc:	02c6fb63          	bgeu	a3,a2,1802 <memset+0x17a>
    17d0:	00b784a3          	sb	a1,9(a5)
    17d4:	00a7069b          	addiw	a3,a4,10
    17d8:	02c6f563          	bgeu	a3,a2,1802 <memset+0x17a>
    17dc:	00b78523          	sb	a1,10(a5)
    17e0:	00b7069b          	addiw	a3,a4,11
    17e4:	00c6ff63          	bgeu	a3,a2,1802 <memset+0x17a>
    17e8:	00b785a3          	sb	a1,11(a5)
    17ec:	00c7069b          	addiw	a3,a4,12
    17f0:	00c6f963          	bgeu	a3,a2,1802 <memset+0x17a>
    17f4:	00b78623          	sb	a1,12(a5)
    17f8:	2735                	addiw	a4,a4,13
    17fa:	00c77463          	bgeu	a4,a2,1802 <memset+0x17a>
    17fe:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1802:	8082                	ret
    1804:	472d                	li	a4,11
    1806:	bd79                	j	16a4 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1808:	4f0d                	li	t5,3
    180a:	b701                	j	170a <memset+0x82>
    180c:	8082                	ret
    180e:	4f05                	li	t5,1
    1810:	bded                	j	170a <memset+0x82>
    1812:	8eaa                	mv	t4,a0
    1814:	4f01                	li	t5,0
    1816:	bdd5                	j	170a <memset+0x82>
    1818:	87aa                	mv	a5,a0
    181a:	4701                	li	a4,0
    181c:	b7a1                	j	1764 <memset+0xdc>
    181e:	4f09                	li	t5,2
    1820:	b5ed                	j	170a <memset+0x82>
    1822:	4f11                	li	t5,4
    1824:	b5dd                	j	170a <memset+0x82>
    1826:	4f15                	li	t5,5
    1828:	b5cd                	j	170a <memset+0x82>
    182a:	4f19                	li	t5,6
    182c:	bdf9                	j	170a <memset+0x82>

000000000000182e <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    182e:	00054783          	lbu	a5,0(a0)
    1832:	0005c703          	lbu	a4,0(a1)
    1836:	00e79863          	bne	a5,a4,1846 <strcmp+0x18>
    183a:	0505                	addi	a0,a0,1
    183c:	0585                	addi	a1,a1,1
    183e:	fbe5                	bnez	a5,182e <strcmp>
    1840:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1842:	9d19                	subw	a0,a0,a4
    1844:	8082                	ret
    1846:	0007851b          	sext.w	a0,a5
    184a:	bfe5                	j	1842 <strcmp+0x14>

000000000000184c <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    184c:	ce05                	beqz	a2,1884 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    184e:	00054703          	lbu	a4,0(a0)
    1852:	0005c783          	lbu	a5,0(a1)
    1856:	cb0d                	beqz	a4,1888 <strncmp+0x3c>
    if (!n--)
    1858:	167d                	addi	a2,a2,-1
    185a:	00c506b3          	add	a3,a0,a2
    185e:	a819                	j	1874 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1860:	00a68e63          	beq	a3,a0,187c <strncmp+0x30>
    1864:	0505                	addi	a0,a0,1
    1866:	00e79b63          	bne	a5,a4,187c <strncmp+0x30>
    186a:	00054703          	lbu	a4,0(a0)
    186e:	0005c783          	lbu	a5,0(a1)
    1872:	cb19                	beqz	a4,1888 <strncmp+0x3c>
    1874:	0005c783          	lbu	a5,0(a1)
    1878:	0585                	addi	a1,a1,1
    187a:	f3fd                	bnez	a5,1860 <strncmp+0x14>
        ;
    return *l - *r;
    187c:	0007051b          	sext.w	a0,a4
    1880:	9d1d                	subw	a0,a0,a5
    1882:	8082                	ret
        return 0;
    1884:	4501                	li	a0,0
}
    1886:	8082                	ret
    1888:	4501                	li	a0,0
    return *l - *r;
    188a:	9d1d                	subw	a0,a0,a5
    188c:	8082                	ret

000000000000188e <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    188e:	00757793          	andi	a5,a0,7
    1892:	cf89                	beqz	a5,18ac <strlen+0x1e>
    1894:	87aa                	mv	a5,a0
    1896:	a029                	j	18a0 <strlen+0x12>
    1898:	0785                	addi	a5,a5,1
    189a:	0077f713          	andi	a4,a5,7
    189e:	cb01                	beqz	a4,18ae <strlen+0x20>
        if (!*s)
    18a0:	0007c703          	lbu	a4,0(a5)
    18a4:	fb75                	bnez	a4,1898 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18a6:	40a78533          	sub	a0,a5,a0
}
    18aa:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18ac:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18ae:	6394                	ld	a3,0(a5)
    18b0:	00000597          	auipc	a1,0x0
    18b4:	6b05b583          	ld	a1,1712(a1) # 1f60 <__clone+0xb6>
    18b8:	00000617          	auipc	a2,0x0
    18bc:	6b063603          	ld	a2,1712(a2) # 1f68 <__clone+0xbe>
    18c0:	a019                	j	18c6 <strlen+0x38>
    18c2:	6794                	ld	a3,8(a5)
    18c4:	07a1                	addi	a5,a5,8
    18c6:	00b68733          	add	a4,a3,a1
    18ca:	fff6c693          	not	a3,a3
    18ce:	8f75                	and	a4,a4,a3
    18d0:	8f71                	and	a4,a4,a2
    18d2:	db65                	beqz	a4,18c2 <strlen+0x34>
    for (; *s; s++)
    18d4:	0007c703          	lbu	a4,0(a5)
    18d8:	d779                	beqz	a4,18a6 <strlen+0x18>
    18da:	0017c703          	lbu	a4,1(a5)
    18de:	0785                	addi	a5,a5,1
    18e0:	d379                	beqz	a4,18a6 <strlen+0x18>
    18e2:	0017c703          	lbu	a4,1(a5)
    18e6:	0785                	addi	a5,a5,1
    18e8:	fb6d                	bnez	a4,18da <strlen+0x4c>
    18ea:	bf75                	j	18a6 <strlen+0x18>

00000000000018ec <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18ec:	00757713          	andi	a4,a0,7
{
    18f0:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18f2:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f6:	cb19                	beqz	a4,190c <memchr+0x20>
    18f8:	ce25                	beqz	a2,1970 <memchr+0x84>
    18fa:	0007c703          	lbu	a4,0(a5)
    18fe:	04b70e63          	beq	a4,a1,195a <memchr+0x6e>
    1902:	0785                	addi	a5,a5,1
    1904:	0077f713          	andi	a4,a5,7
    1908:	167d                	addi	a2,a2,-1
    190a:	f77d                	bnez	a4,18f8 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    190c:	4501                	li	a0,0
    if (n && *s != c)
    190e:	c235                	beqz	a2,1972 <memchr+0x86>
    1910:	0007c703          	lbu	a4,0(a5)
    1914:	04b70363          	beq	a4,a1,195a <memchr+0x6e>
        size_t k = ONES * c;
    1918:	00000517          	auipc	a0,0x0
    191c:	65853503          	ld	a0,1624(a0) # 1f70 <__clone+0xc6>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1920:	471d                	li	a4,7
        size_t k = ONES * c;
    1922:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1926:	02c77a63          	bgeu	a4,a2,195a <memchr+0x6e>
    192a:	00000897          	auipc	a7,0x0
    192e:	6368b883          	ld	a7,1590(a7) # 1f60 <__clone+0xb6>
    1932:	00000817          	auipc	a6,0x0
    1936:	63683803          	ld	a6,1590(a6) # 1f68 <__clone+0xbe>
    193a:	431d                	li	t1,7
    193c:	a029                	j	1946 <memchr+0x5a>
    193e:	1661                	addi	a2,a2,-8
    1940:	07a1                	addi	a5,a5,8
    1942:	02c37963          	bgeu	t1,a2,1974 <memchr+0x88>
    1946:	6398                	ld	a4,0(a5)
    1948:	8f29                	xor	a4,a4,a0
    194a:	011706b3          	add	a3,a4,a7
    194e:	fff74713          	not	a4,a4
    1952:	8f75                	and	a4,a4,a3
    1954:	01077733          	and	a4,a4,a6
    1958:	d37d                	beqz	a4,193e <memchr+0x52>
    195a:	853e                	mv	a0,a5
    195c:	97b2                	add	a5,a5,a2
    195e:	a021                	j	1966 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1960:	0505                	addi	a0,a0,1
    1962:	00f50763          	beq	a0,a5,1970 <memchr+0x84>
    1966:	00054703          	lbu	a4,0(a0)
    196a:	feb71be3          	bne	a4,a1,1960 <memchr+0x74>
    196e:	8082                	ret
    return n ? (void *)s : 0;
    1970:	4501                	li	a0,0
}
    1972:	8082                	ret
    return n ? (void *)s : 0;
    1974:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1976:	f275                	bnez	a2,195a <memchr+0x6e>
}
    1978:	8082                	ret

000000000000197a <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    197a:	1101                	addi	sp,sp,-32
    197c:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    197e:	862e                	mv	a2,a1
{
    1980:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1982:	4581                	li	a1,0
{
    1984:	e426                	sd	s1,8(sp)
    1986:	ec06                	sd	ra,24(sp)
    1988:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    198a:	f63ff0ef          	jal	ra,18ec <memchr>
    return p ? p - s : n;
    198e:	c519                	beqz	a0,199c <strnlen+0x22>
}
    1990:	60e2                	ld	ra,24(sp)
    1992:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1994:	8d05                	sub	a0,a0,s1
}
    1996:	64a2                	ld	s1,8(sp)
    1998:	6105                	addi	sp,sp,32
    199a:	8082                	ret
    199c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    199e:	8522                	mv	a0,s0
}
    19a0:	6442                	ld	s0,16(sp)
    19a2:	64a2                	ld	s1,8(sp)
    19a4:	6105                	addi	sp,sp,32
    19a6:	8082                	ret

00000000000019a8 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19a8:	00b547b3          	xor	a5,a0,a1
    19ac:	8b9d                	andi	a5,a5,7
    19ae:	eb95                	bnez	a5,19e2 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19b0:	0075f793          	andi	a5,a1,7
    19b4:	e7b1                	bnez	a5,1a00 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19b6:	6198                	ld	a4,0(a1)
    19b8:	00000617          	auipc	a2,0x0
    19bc:	5a863603          	ld	a2,1448(a2) # 1f60 <__clone+0xb6>
    19c0:	00000817          	auipc	a6,0x0
    19c4:	5a883803          	ld	a6,1448(a6) # 1f68 <__clone+0xbe>
    19c8:	a029                	j	19d2 <strcpy+0x2a>
    19ca:	e118                	sd	a4,0(a0)
    19cc:	6598                	ld	a4,8(a1)
    19ce:	05a1                	addi	a1,a1,8
    19d0:	0521                	addi	a0,a0,8
    19d2:	00c707b3          	add	a5,a4,a2
    19d6:	fff74693          	not	a3,a4
    19da:	8ff5                	and	a5,a5,a3
    19dc:	0107f7b3          	and	a5,a5,a6
    19e0:	d7ed                	beqz	a5,19ca <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19e2:	0005c783          	lbu	a5,0(a1)
    19e6:	00f50023          	sb	a5,0(a0)
    19ea:	c785                	beqz	a5,1a12 <strcpy+0x6a>
    19ec:	0015c783          	lbu	a5,1(a1)
    19f0:	0505                	addi	a0,a0,1
    19f2:	0585                	addi	a1,a1,1
    19f4:	00f50023          	sb	a5,0(a0)
    19f8:	fbf5                	bnez	a5,19ec <strcpy+0x44>
        ;
    return d;
}
    19fa:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19fc:	0505                	addi	a0,a0,1
    19fe:	df45                	beqz	a4,19b6 <strcpy+0xe>
            if (!(*d = *s))
    1a00:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a04:	0585                	addi	a1,a1,1
    1a06:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a0a:	00f50023          	sb	a5,0(a0)
    1a0e:	f7fd                	bnez	a5,19fc <strcpy+0x54>
}
    1a10:	8082                	ret
    1a12:	8082                	ret

0000000000001a14 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a14:	00b547b3          	xor	a5,a0,a1
    1a18:	8b9d                	andi	a5,a5,7
    1a1a:	1a079863          	bnez	a5,1bca <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a1e:	0075f793          	andi	a5,a1,7
    1a22:	16078463          	beqz	a5,1b8a <strncpy+0x176>
    1a26:	ea01                	bnez	a2,1a36 <strncpy+0x22>
    1a28:	a421                	j	1c30 <strncpy+0x21c>
    1a2a:	167d                	addi	a2,a2,-1
    1a2c:	0505                	addi	a0,a0,1
    1a2e:	14070e63          	beqz	a4,1b8a <strncpy+0x176>
    1a32:	1a060863          	beqz	a2,1be2 <strncpy+0x1ce>
    1a36:	0005c783          	lbu	a5,0(a1)
    1a3a:	0585                	addi	a1,a1,1
    1a3c:	0075f713          	andi	a4,a1,7
    1a40:	00f50023          	sb	a5,0(a0)
    1a44:	f3fd                	bnez	a5,1a2a <strncpy+0x16>
    1a46:	4805                	li	a6,1
    1a48:	1a061863          	bnez	a2,1bf8 <strncpy+0x1e4>
    1a4c:	40a007b3          	neg	a5,a0
    1a50:	8b9d                	andi	a5,a5,7
    1a52:	4681                	li	a3,0
    1a54:	18061a63          	bnez	a2,1be8 <strncpy+0x1d4>
    1a58:	00778713          	addi	a4,a5,7
    1a5c:	45ad                	li	a1,11
    1a5e:	18b76363          	bltu	a4,a1,1be4 <strncpy+0x1d0>
    1a62:	1ae6eb63          	bltu	a3,a4,1c18 <strncpy+0x204>
    1a66:	1a078363          	beqz	a5,1c0c <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a6a:	00050023          	sb	zero,0(a0)
    1a6e:	4685                	li	a3,1
    1a70:	00150713          	addi	a4,a0,1
    1a74:	18d78f63          	beq	a5,a3,1c12 <strncpy+0x1fe>
    1a78:	000500a3          	sb	zero,1(a0)
    1a7c:	4689                	li	a3,2
    1a7e:	00250713          	addi	a4,a0,2
    1a82:	18d78e63          	beq	a5,a3,1c1e <strncpy+0x20a>
    1a86:	00050123          	sb	zero,2(a0)
    1a8a:	468d                	li	a3,3
    1a8c:	00350713          	addi	a4,a0,3
    1a90:	16d78c63          	beq	a5,a3,1c08 <strncpy+0x1f4>
    1a94:	000501a3          	sb	zero,3(a0)
    1a98:	4691                	li	a3,4
    1a9a:	00450713          	addi	a4,a0,4
    1a9e:	18d78263          	beq	a5,a3,1c22 <strncpy+0x20e>
    1aa2:	00050223          	sb	zero,4(a0)
    1aa6:	4695                	li	a3,5
    1aa8:	00550713          	addi	a4,a0,5
    1aac:	16d78d63          	beq	a5,a3,1c26 <strncpy+0x212>
    1ab0:	000502a3          	sb	zero,5(a0)
    1ab4:	469d                	li	a3,7
    1ab6:	00650713          	addi	a4,a0,6
    1aba:	16d79863          	bne	a5,a3,1c2a <strncpy+0x216>
    1abe:	00750713          	addi	a4,a0,7
    1ac2:	00050323          	sb	zero,6(a0)
    1ac6:	40f80833          	sub	a6,a6,a5
    1aca:	ff887593          	andi	a1,a6,-8
    1ace:	97aa                	add	a5,a5,a0
    1ad0:	95be                	add	a1,a1,a5
    1ad2:	0007b023          	sd	zero,0(a5)
    1ad6:	07a1                	addi	a5,a5,8
    1ad8:	feb79de3          	bne	a5,a1,1ad2 <strncpy+0xbe>
    1adc:	ff887593          	andi	a1,a6,-8
    1ae0:	9ead                	addw	a3,a3,a1
    1ae2:	00b707b3          	add	a5,a4,a1
    1ae6:	12b80863          	beq	a6,a1,1c16 <strncpy+0x202>
    1aea:	00078023          	sb	zero,0(a5)
    1aee:	0016871b          	addiw	a4,a3,1
    1af2:	0ec77863          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1af6:	000780a3          	sb	zero,1(a5)
    1afa:	0026871b          	addiw	a4,a3,2
    1afe:	0ec77263          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b02:	00078123          	sb	zero,2(a5)
    1b06:	0036871b          	addiw	a4,a3,3
    1b0a:	0cc77c63          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b0e:	000781a3          	sb	zero,3(a5)
    1b12:	0046871b          	addiw	a4,a3,4
    1b16:	0cc77663          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b1a:	00078223          	sb	zero,4(a5)
    1b1e:	0056871b          	addiw	a4,a3,5
    1b22:	0cc77063          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b26:	000782a3          	sb	zero,5(a5)
    1b2a:	0066871b          	addiw	a4,a3,6
    1b2e:	0ac77a63          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b32:	00078323          	sb	zero,6(a5)
    1b36:	0076871b          	addiw	a4,a3,7
    1b3a:	0ac77463          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b3e:	000783a3          	sb	zero,7(a5)
    1b42:	0086871b          	addiw	a4,a3,8
    1b46:	08c77e63          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b4a:	00078423          	sb	zero,8(a5)
    1b4e:	0096871b          	addiw	a4,a3,9
    1b52:	08c77863          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b56:	000784a3          	sb	zero,9(a5)
    1b5a:	00a6871b          	addiw	a4,a3,10
    1b5e:	08c77263          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b62:	00078523          	sb	zero,10(a5)
    1b66:	00b6871b          	addiw	a4,a3,11
    1b6a:	06c77c63          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b6e:	000785a3          	sb	zero,11(a5)
    1b72:	00c6871b          	addiw	a4,a3,12
    1b76:	06c77663          	bgeu	a4,a2,1be2 <strncpy+0x1ce>
    1b7a:	00078623          	sb	zero,12(a5)
    1b7e:	26b5                	addiw	a3,a3,13
    1b80:	06c6f163          	bgeu	a3,a2,1be2 <strncpy+0x1ce>
    1b84:	000786a3          	sb	zero,13(a5)
    1b88:	8082                	ret
            ;
        if (!n || !*s)
    1b8a:	c645                	beqz	a2,1c32 <strncpy+0x21e>
    1b8c:	0005c783          	lbu	a5,0(a1)
    1b90:	ea078be3          	beqz	a5,1a46 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b94:	479d                	li	a5,7
    1b96:	02c7ff63          	bgeu	a5,a2,1bd4 <strncpy+0x1c0>
    1b9a:	00000897          	auipc	a7,0x0
    1b9e:	3c68b883          	ld	a7,966(a7) # 1f60 <__clone+0xb6>
    1ba2:	00000817          	auipc	a6,0x0
    1ba6:	3c683803          	ld	a6,966(a6) # 1f68 <__clone+0xbe>
    1baa:	431d                	li	t1,7
    1bac:	6198                	ld	a4,0(a1)
    1bae:	011707b3          	add	a5,a4,a7
    1bb2:	fff74693          	not	a3,a4
    1bb6:	8ff5                	and	a5,a5,a3
    1bb8:	0107f7b3          	and	a5,a5,a6
    1bbc:	ef81                	bnez	a5,1bd4 <strncpy+0x1c0>
            *wd = *ws;
    1bbe:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc0:	1661                	addi	a2,a2,-8
    1bc2:	05a1                	addi	a1,a1,8
    1bc4:	0521                	addi	a0,a0,8
    1bc6:	fec363e3          	bltu	t1,a2,1bac <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bca:	e609                	bnez	a2,1bd4 <strncpy+0x1c0>
    1bcc:	a08d                	j	1c2e <strncpy+0x21a>
    1bce:	167d                	addi	a2,a2,-1
    1bd0:	0505                	addi	a0,a0,1
    1bd2:	ca01                	beqz	a2,1be2 <strncpy+0x1ce>
    1bd4:	0005c783          	lbu	a5,0(a1)
    1bd8:	0585                	addi	a1,a1,1
    1bda:	00f50023          	sb	a5,0(a0)
    1bde:	fbe5                	bnez	a5,1bce <strncpy+0x1ba>
        ;
tail:
    1be0:	b59d                	j	1a46 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1be2:	8082                	ret
    1be4:	472d                	li	a4,11
    1be6:	bdb5                	j	1a62 <strncpy+0x4e>
    1be8:	00778713          	addi	a4,a5,7
    1bec:	45ad                	li	a1,11
    1bee:	fff60693          	addi	a3,a2,-1
    1bf2:	e6b778e3          	bgeu	a4,a1,1a62 <strncpy+0x4e>
    1bf6:	b7fd                	j	1be4 <strncpy+0x1d0>
    1bf8:	40a007b3          	neg	a5,a0
    1bfc:	8832                	mv	a6,a2
    1bfe:	8b9d                	andi	a5,a5,7
    1c00:	4681                	li	a3,0
    1c02:	e4060be3          	beqz	a2,1a58 <strncpy+0x44>
    1c06:	b7cd                	j	1be8 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c08:	468d                	li	a3,3
    1c0a:	bd75                	j	1ac6 <strncpy+0xb2>
    1c0c:	872a                	mv	a4,a0
    1c0e:	4681                	li	a3,0
    1c10:	bd5d                	j	1ac6 <strncpy+0xb2>
    1c12:	4685                	li	a3,1
    1c14:	bd4d                	j	1ac6 <strncpy+0xb2>
    1c16:	8082                	ret
    1c18:	87aa                	mv	a5,a0
    1c1a:	4681                	li	a3,0
    1c1c:	b5f9                	j	1aea <strncpy+0xd6>
    1c1e:	4689                	li	a3,2
    1c20:	b55d                	j	1ac6 <strncpy+0xb2>
    1c22:	4691                	li	a3,4
    1c24:	b54d                	j	1ac6 <strncpy+0xb2>
    1c26:	4695                	li	a3,5
    1c28:	bd79                	j	1ac6 <strncpy+0xb2>
    1c2a:	4699                	li	a3,6
    1c2c:	bd69                	j	1ac6 <strncpy+0xb2>
    1c2e:	8082                	ret
    1c30:	8082                	ret
    1c32:	8082                	ret

0000000000001c34 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c34:	87aa                	mv	a5,a0
    1c36:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c38:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c3c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c40:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c42:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c44:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c48:	2501                	sext.w	a0,a0
    1c4a:	8082                	ret

0000000000001c4c <openat>:
    register long a7 __asm__("a7") = n;
    1c4c:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c50:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c54:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c58:	2501                	sext.w	a0,a0
    1c5a:	8082                	ret

0000000000001c5c <close>:
    register long a7 __asm__("a7") = n;
    1c5c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c60:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c64:	2501                	sext.w	a0,a0
    1c66:	8082                	ret

0000000000001c68 <read>:
    register long a7 __asm__("a7") = n;
    1c68:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c6c:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c70:	8082                	ret

0000000000001c72 <write>:
    register long a7 __asm__("a7") = n;
    1c72:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c76:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c7a:	8082                	ret

0000000000001c7c <getpid>:
    register long a7 __asm__("a7") = n;
    1c7c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c80:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c84:	2501                	sext.w	a0,a0
    1c86:	8082                	ret

0000000000001c88 <getppid>:
    register long a7 __asm__("a7") = n;
    1c88:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c8c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c90:	2501                	sext.w	a0,a0
    1c92:	8082                	ret

0000000000001c94 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c94:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c98:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c9c:	2501                	sext.w	a0,a0
    1c9e:	8082                	ret

0000000000001ca0 <fork>:
    register long a7 __asm__("a7") = n;
    1ca0:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1ca4:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ca6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca8:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cac:	2501                	sext.w	a0,a0
    1cae:	8082                	ret

0000000000001cb0 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cb0:	85b2                	mv	a1,a2
    1cb2:	863a                	mv	a2,a4
    if (stack)
    1cb4:	c191                	beqz	a1,1cb8 <clone+0x8>
	stack += stack_size;
    1cb6:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cb8:	4781                	li	a5,0
    1cba:	4701                	li	a4,0
    1cbc:	4681                	li	a3,0
    1cbe:	2601                	sext.w	a2,a2
    1cc0:	a2ed                	j	1eaa <__clone>

0000000000001cc2 <exit>:
    register long a7 __asm__("a7") = n;
    1cc2:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cc6:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cca:	8082                	ret

0000000000001ccc <waitpid>:
    register long a7 __asm__("a7") = n;
    1ccc:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cd0:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cd2:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <exec>:
    register long a7 __asm__("a7") = n;
    1cda:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cde:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <execve>:
    register long a7 __asm__("a7") = n;
    1ce6:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cea:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <times>:
    register long a7 __asm__("a7") = n;
    1cf2:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cf6:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cfa:	2501                	sext.w	a0,a0
    1cfc:	8082                	ret

0000000000001cfe <get_time>:

int64 get_time()
{
    1cfe:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d00:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d04:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d06:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d08:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	ed09                	bnez	a0,1d28 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d10:	67a2                	ld	a5,8(sp)
    1d12:	3e800713          	li	a4,1000
    1d16:	00015503          	lhu	a0,0(sp)
    1d1a:	02e7d7b3          	divu	a5,a5,a4
    1d1e:	02e50533          	mul	a0,a0,a4
    1d22:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d24:	0141                	addi	sp,sp,16
    1d26:	8082                	ret
        return -1;
    1d28:	557d                	li	a0,-1
    1d2a:	bfed                	j	1d24 <get_time+0x26>

0000000000001d2c <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d2c:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d30:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <time>:
    register long a7 __asm__("a7") = n;
    1d38:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d3c:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <sleep>:

int sleep(unsigned long long time)
{
    1d44:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d46:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d48:	850a                	mv	a0,sp
    1d4a:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d4c:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d50:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d52:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d56:	e501                	bnez	a0,1d5e <sleep+0x1a>
    return 0;
    1d58:	4501                	li	a0,0
}
    1d5a:	0141                	addi	sp,sp,16
    1d5c:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d5e:	4502                	lw	a0,0(sp)
}
    1d60:	0141                	addi	sp,sp,16
    1d62:	8082                	ret

0000000000001d64 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d64:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d68:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d6c:	2501                	sext.w	a0,a0
    1d6e:	8082                	ret

0000000000001d70 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d70:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d74:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d78:	8082                	ret

0000000000001d7a <munmap>:
    register long a7 __asm__("a7") = n;
    1d7a:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7e:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <wait>:

int wait(int *code)
{
    1d86:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d88:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d8c:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d8e:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d90:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d92:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d96:	2501                	sext.w	a0,a0
    1d98:	8082                	ret

0000000000001d9a <spawn>:
    register long a7 __asm__("a7") = n;
    1d9a:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d9e:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1da2:	2501                	sext.w	a0,a0
    1da4:	8082                	ret

0000000000001da6 <mailread>:
    register long a7 __asm__("a7") = n;
    1da6:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1daa:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dae:	2501                	sext.w	a0,a0
    1db0:	8082                	ret

0000000000001db2 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1db2:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1db6:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <fstat>:
    register long a7 __asm__("a7") = n;
    1dbe:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc2:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dc6:	2501                	sext.w	a0,a0
    1dc8:	8082                	ret

0000000000001dca <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dca:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dcc:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dd0:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dd2:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dd6:	2501                	sext.w	a0,a0
    1dd8:	8082                	ret

0000000000001dda <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dda:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ddc:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1de0:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1de2:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1de6:	2501                	sext.w	a0,a0
    1de8:	8082                	ret

0000000000001dea <link>:

int link(char *old_path, char *new_path)
{
    1dea:	87aa                	mv	a5,a0
    1dec:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1dee:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1df2:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1df6:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1df8:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1dfc:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dfe:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e02:	2501                	sext.w	a0,a0
    1e04:	8082                	ret

0000000000001e06 <unlink>:

int unlink(char *path)
{
    1e06:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e08:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e0c:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e10:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e12:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e16:	2501                	sext.w	a0,a0
    1e18:	8082                	ret

0000000000001e1a <uname>:
    register long a7 __asm__("a7") = n;
    1e1a:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e1e:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <brk>:
    register long a7 __asm__("a7") = n;
    1e26:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e2a:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e32:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e34:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e38:	8082                	ret

0000000000001e3a <chdir>:
    register long a7 __asm__("a7") = n;
    1e3a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e3e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e42:	2501                	sext.w	a0,a0
    1e44:	8082                	ret

0000000000001e46 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e46:	862e                	mv	a2,a1
    1e48:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e4a:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e4c:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e50:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e54:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e56:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e58:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e5c:	2501                	sext.w	a0,a0
    1e5e:	8082                	ret

0000000000001e60 <getdents>:
    register long a7 __asm__("a7") = n;
    1e60:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e64:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <pipe>:
    register long a7 __asm__("a7") = n;
    1e6c:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e70:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e72:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <dup>:
    register long a7 __asm__("a7") = n;
    1e7a:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e7c:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <dup2>:
    register long a7 __asm__("a7") = n;
    1e84:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e86:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e88:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <mount>:
    register long a7 __asm__("a7") = n;
    1e90:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e94:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e98:	2501                	sext.w	a0,a0
    1e9a:	8082                	ret

0000000000001e9c <umount>:
    register long a7 __asm__("a7") = n;
    1e9c:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ea0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea2:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eaa:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eac:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eae:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eb0:	8532                	mv	a0,a2
	mv a2, a4
    1eb2:	863a                	mv	a2,a4
	mv a3, a5
    1eb4:	86be                	mv	a3,a5
	mv a4, a6
    1eb6:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eb8:	0dc00893          	li	a7,220
	ecall
    1ebc:	00000073          	ecall

	beqz a0, 1f
    1ec0:	c111                	beqz	a0,1ec4 <__clone+0x1a>
	# Parent
	ret
    1ec2:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ec4:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ec6:	6522                	ld	a0,8(sp)
	jalr a1
    1ec8:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1eca:	05d00893          	li	a7,93
	ecall
    1ece:	00000073          	ecall
