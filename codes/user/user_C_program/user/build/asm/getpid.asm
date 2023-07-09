
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/getpid:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a061                	j	108a <__start_main>

0000000000001004 <test_getpid>:
/*
理想结果：得到进程 pid，注意要关注 pid 是否符合内核逻辑，不要单纯以 Test OK! 作为判断。
*/

int test_getpid()
{
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ec250513          	addi	a0,a0,-318 # 1ec8 <__clone+0x2a>
{
    100e:	ec06                	sd	ra,24(sp)
    TEST_START(__func__);
    1010:	2b2000ef          	jal	ra,12c2 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f4c50513          	addi	a0,a0,-180 # 1f60 <__func__.1165>
    101c:	2a6000ef          	jal	ra,12c2 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ec050513          	addi	a0,a0,-320 # 1ee0 <__clone+0x42>
    1028:	29a000ef          	jal	ra,12c2 <puts>
    int pid = getpid();
    102c:	445000ef          	jal	ra,1c70 <getpid>
    1030:	85aa                	mv	a1,a0
    assert(pid >= 0);
    1032:	02054b63          	bltz	a0,1068 <test_getpid+0x64>
    printf("getpid success.\npid = %d\n", pid);
    1036:	00001517          	auipc	a0,0x1
    103a:	eda50513          	addi	a0,a0,-294 # 1f10 <__clone+0x72>
    103e:	2a6000ef          	jal	ra,12e4 <printf>
    TEST_END(__func__);
    1042:	00001517          	auipc	a0,0x1
    1046:	eee50513          	addi	a0,a0,-274 # 1f30 <__clone+0x92>
    104a:	278000ef          	jal	ra,12c2 <puts>
    104e:	00001517          	auipc	a0,0x1
    1052:	f1250513          	addi	a0,a0,-238 # 1f60 <__func__.1165>
    1056:	26c000ef          	jal	ra,12c2 <puts>
}
    105a:	60e2                	ld	ra,24(sp)
    TEST_END(__func__);
    105c:	00001517          	auipc	a0,0x1
    1060:	e8450513          	addi	a0,a0,-380 # 1ee0 <__clone+0x42>
}
    1064:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    1066:	acb1                	j	12c2 <puts>
    1068:	e42a                	sd	a0,8(sp)
    assert(pid >= 0);
    106a:	00001517          	auipc	a0,0x1
    106e:	e8650513          	addi	a0,a0,-378 # 1ef0 <__clone+0x52>
    1072:	532000ef          	jal	ra,15a4 <panic>
    1076:	65a2                	ld	a1,8(sp)
    1078:	bf7d                	j	1036 <test_getpid+0x32>

000000000000107a <main>:

int main(void) {
    107a:	1141                	addi	sp,sp,-16
    107c:	e406                	sd	ra,8(sp)
	test_getpid();
    107e:	f87ff0ef          	jal	ra,1004 <test_getpid>
	return 0;
}
    1082:	60a2                	ld	ra,8(sp)
    1084:	4501                	li	a0,0
    1086:	0141                	addi	sp,sp,16
    1088:	8082                	ret

000000000000108a <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    108a:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    108c:	4108                	lw	a0,0(a0)
{
    108e:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1090:	05a1                	addi	a1,a1,8
{
    1092:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1094:	fe7ff0ef          	jal	ra,107a <main>
    1098:	41f000ef          	jal	ra,1cb6 <exit>
	return 0;
}
    109c:	60a2                	ld	ra,8(sp)
    109e:	4501                	li	a0,0
    10a0:	0141                	addi	sp,sp,16
    10a2:	8082                	ret

00000000000010a4 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10a4:	7179                	addi	sp,sp,-48
    10a6:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10a8:	12054b63          	bltz	a0,11de <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ac:	02b577bb          	remuw	a5,a0,a1
    10b0:	00001697          	auipc	a3,0x1
    10b4:	ec068693          	addi	a3,a3,-320 # 1f70 <digits>
    buf[16] = 0;
    10b8:	00010c23          	sb	zero,24(sp)
    i = 15;
    10bc:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10c0:	1782                	slli	a5,a5,0x20
    10c2:	9381                	srli	a5,a5,0x20
    10c4:	97b6                	add	a5,a5,a3
    10c6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10ca:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10ce:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10d2:	16b56263          	bltu	a0,a1,1236 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10d6:	02e8763b          	remuw	a2,a6,a4
    10da:	1602                	slli	a2,a2,0x20
    10dc:	9201                	srli	a2,a2,0x20
    10de:	9636                	add	a2,a2,a3
    10e0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    10e4:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    10e8:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    10ec:	12e86963          	bltu	a6,a4,121e <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    10f0:	02e5f63b          	remuw	a2,a1,a4
    10f4:	1602                	slli	a2,a2,0x20
    10f6:	9201                	srli	a2,a2,0x20
    10f8:	9636                	add	a2,a2,a3
    10fa:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    10fe:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1102:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1106:	10e5ef63          	bltu	a1,a4,1224 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    110a:	02e8763b          	remuw	a2,a6,a4
    110e:	1602                	slli	a2,a2,0x20
    1110:	9201                	srli	a2,a2,0x20
    1112:	9636                	add	a2,a2,a3
    1114:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1118:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    111c:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1120:	10e86563          	bltu	a6,a4,122a <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1124:	02e5f63b          	remuw	a2,a1,a4
    1128:	1602                	slli	a2,a2,0x20
    112a:	9201                	srli	a2,a2,0x20
    112c:	9636                	add	a2,a2,a3
    112e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1132:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1136:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    113a:	0ee5eb63          	bltu	a1,a4,1230 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    113e:	02e8763b          	remuw	a2,a6,a4
    1142:	1602                	slli	a2,a2,0x20
    1144:	9201                	srli	a2,a2,0x20
    1146:	9636                	add	a2,a2,a3
    1148:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    114c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1150:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1154:	0ce86263          	bltu	a6,a4,1218 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1158:	02e5f63b          	remuw	a2,a1,a4
    115c:	1602                	slli	a2,a2,0x20
    115e:	9201                	srli	a2,a2,0x20
    1160:	9636                	add	a2,a2,a3
    1162:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1166:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    116a:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    116e:	0ce5e663          	bltu	a1,a4,123a <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    1172:	02e8763b          	remuw	a2,a6,a4
    1176:	1602                	slli	a2,a2,0x20
    1178:	9201                	srli	a2,a2,0x20
    117a:	9636                	add	a2,a2,a3
    117c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1180:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1184:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1188:	0ae86c63          	bltu	a6,a4,1240 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    118c:	02e5f63b          	remuw	a2,a1,a4
    1190:	1602                	slli	a2,a2,0x20
    1192:	9201                	srli	a2,a2,0x20
    1194:	9636                	add	a2,a2,a3
    1196:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    119a:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    119e:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11a2:	0ae5e263          	bltu	a1,a4,1246 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11a6:	1782                	slli	a5,a5,0x20
    11a8:	9381                	srli	a5,a5,0x20
    11aa:	97b6                	add	a5,a5,a3
    11ac:	0007c703          	lbu	a4,0(a5)
    11b0:	4599                	li	a1,6
    11b2:	4795                	li	a5,5
    11b4:	00e10723          	sb	a4,14(sp)

    if (sign)
    11b8:	00055963          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    11bc:	1018                	addi	a4,sp,32
    11be:	973e                	add	a4,a4,a5
    11c0:	02d00693          	li	a3,45
    11c4:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11c8:	85be                	mv	a1,a5
    write(f, s, l);
    11ca:	003c                	addi	a5,sp,8
    11cc:	4641                	li	a2,16
    11ce:	9e0d                	subw	a2,a2,a1
    11d0:	4505                	li	a0,1
    11d2:	95be                	add	a1,a1,a5
    11d4:	293000ef          	jal	ra,1c66 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11d8:	70a2                	ld	ra,40(sp)
    11da:	6145                	addi	sp,sp,48
    11dc:	8082                	ret
        x = -xx;
    11de:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    11e2:	02b677bb          	remuw	a5,a2,a1
    11e6:	00001697          	auipc	a3,0x1
    11ea:	d8a68693          	addi	a3,a3,-630 # 1f70 <digits>
    buf[16] = 0;
    11ee:	00010c23          	sb	zero,24(sp)
    i = 15;
    11f2:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    11f6:	1782                	slli	a5,a5,0x20
    11f8:	9381                	srli	a5,a5,0x20
    11fa:	97b6                	add	a5,a5,a3
    11fc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1200:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1204:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1208:	ecb677e3          	bgeu	a2,a1,10d6 <printint.constprop.0+0x32>
        buf[i--] = '-';
    120c:	02d00793          	li	a5,45
    1210:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1214:	45b9                	li	a1,14
    1216:	bf55                	j	11ca <printint.constprop.0+0x126>
    1218:	47a5                	li	a5,9
    121a:	45a9                	li	a1,10
    121c:	bf71                	j	11b8 <printint.constprop.0+0x114>
    121e:	47b5                	li	a5,13
    1220:	45b9                	li	a1,14
    1222:	bf59                	j	11b8 <printint.constprop.0+0x114>
    1224:	47b1                	li	a5,12
    1226:	45b5                	li	a1,13
    1228:	bf41                	j	11b8 <printint.constprop.0+0x114>
    122a:	47ad                	li	a5,11
    122c:	45b1                	li	a1,12
    122e:	b769                	j	11b8 <printint.constprop.0+0x114>
    1230:	47a9                	li	a5,10
    1232:	45ad                	li	a1,11
    1234:	b751                	j	11b8 <printint.constprop.0+0x114>
    i = 15;
    1236:	45bd                	li	a1,15
    1238:	bf49                	j	11ca <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    123a:	47a1                	li	a5,8
    123c:	45a5                	li	a1,9
    123e:	bfad                	j	11b8 <printint.constprop.0+0x114>
    1240:	479d                	li	a5,7
    1242:	45a1                	li	a1,8
    1244:	bf95                	j	11b8 <printint.constprop.0+0x114>
    1246:	4799                	li	a5,6
    1248:	459d                	li	a1,7
    124a:	b7bd                	j	11b8 <printint.constprop.0+0x114>

000000000000124c <getchar>:
{
    124c:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    124e:	00f10593          	addi	a1,sp,15
    1252:	4605                	li	a2,1
    1254:	4501                	li	a0,0
{
    1256:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1258:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    125c:	201000ef          	jal	ra,1c5c <read>
}
    1260:	60e2                	ld	ra,24(sp)
    1262:	00f14503          	lbu	a0,15(sp)
    1266:	6105                	addi	sp,sp,32
    1268:	8082                	ret

000000000000126a <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    126a:	00001797          	auipc	a5,0x1
    126e:	d1e78793          	addi	a5,a5,-738 # 1f88 <digits+0x18>
    1272:	04000893          	li	a7,64
    1276:	4505                	li	a0,1
    1278:	85be                	mv	a1,a5
    127a:	4611                	li	a2,4
    127c:	00000073          	ecall
}
    1280:	4501                	li	a0,0
    1282:	8082                	ret

0000000000001284 <putchar>:
{
    1284:	1101                	addi	sp,sp,-32
    1286:	ec06                	sd	ra,24(sp)
    1288:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    128a:	3e700893          	li	a7,999
    128e:	4505                	li	a0,1
    1290:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1294:	00001717          	auipc	a4,0x1
    1298:	cf470713          	addi	a4,a4,-780 # 1f88 <digits+0x18>
    129c:	04000893          	li	a7,64
    12a0:	4505                	li	a0,1
    12a2:	85ba                	mv	a1,a4
    12a4:	4611                	li	a2,4
    12a6:	00000073          	ecall
    return write(stdout, &byte, 1);
    12aa:	4605                	li	a2,1
    12ac:	00f10593          	addi	a1,sp,15
    12b0:	4505                	li	a0,1
    char byte = c;
    12b2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12b6:	1b1000ef          	jal	ra,1c66 <write>
}
    12ba:	60e2                	ld	ra,24(sp)
    12bc:	2501                	sext.w	a0,a0
    12be:	6105                	addi	sp,sp,32
    12c0:	8082                	ret

00000000000012c2 <puts>:
{
    12c2:	1141                	addi	sp,sp,-16
    12c4:	e406                	sd	ra,8(sp)
    12c6:	e022                	sd	s0,0(sp)
    12c8:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12ca:	5b8000ef          	jal	ra,1882 <strlen>
    12ce:	862a                	mv	a2,a0
    12d0:	85a2                	mv	a1,s0
    12d2:	4505                	li	a0,1
    12d4:	193000ef          	jal	ra,1c66 <write>
}
    12d8:	60a2                	ld	ra,8(sp)
    12da:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12dc:	957d                	srai	a0,a0,0x3f
    return r;
    12de:	2501                	sext.w	a0,a0
}
    12e0:	0141                	addi	sp,sp,16
    12e2:	8082                	ret

00000000000012e4 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12e4:	7171                	addi	sp,sp,-176
    12e6:	e0d2                	sd	s4,64(sp)
    12e8:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    12ea:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    12ec:	18bc                	addi	a5,sp,120
{
    12ee:	e8ca                	sd	s2,80(sp)
    12f0:	e4ce                	sd	s3,72(sp)
    12f2:	fc56                	sd	s5,56(sp)
    12f4:	f85a                	sd	s6,48(sp)
    12f6:	f486                	sd	ra,104(sp)
    12f8:	f0a2                	sd	s0,96(sp)
    12fa:	eca6                	sd	s1,88(sp)
    12fc:	fcae                	sd	a1,120(sp)
    12fe:	e132                	sd	a2,128(sp)
    1300:	e536                	sd	a3,136(sp)
    1302:	e93a                	sd	a4,144(sp)
    1304:	f142                	sd	a6,160(sp)
    1306:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1308:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    130a:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    130e:	00001b17          	auipc	s6,0x1
    1312:	c32b0b13          	addi	s6,s6,-974 # 1f40 <__clone+0xa2>
	::"r"((unsigned long long)ac)
    1316:	00001a97          	auipc	s5,0x1
    131a:	c72a8a93          	addi	s5,s5,-910 # 1f88 <digits+0x18>
    buf[i++] = '0';
    131e:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1322:	00001997          	auipc	s3,0x1
    1326:	c4e98993          	addi	s3,s3,-946 # 1f70 <digits>
        if (!*s)
    132a:	00054783          	lbu	a5,0(a0)
    132e:	16078c63          	beqz	a5,14a6 <printf+0x1c2>
    1332:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1334:	19278363          	beq	a5,s2,14ba <printf+0x1d6>
    1338:	00164783          	lbu	a5,1(a2)
    133c:	0605                	addi	a2,a2,1
    133e:	fbfd                	bnez	a5,1334 <printf+0x50>
    1340:	84b2                	mv	s1,a2
        l = z - a;
    1342:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1346:	85aa                	mv	a1,a0
    1348:	8622                	mv	a2,s0
    134a:	4505                	li	a0,1
    134c:	11b000ef          	jal	ra,1c66 <write>
        if (l)
    1350:	18041e63          	bnez	s0,14ec <printf+0x208>
        if (s[1] == 0)
    1354:	0014c783          	lbu	a5,1(s1)
    1358:	14078763          	beqz	a5,14a6 <printf+0x1c2>
        switch (s[1])
    135c:	07300713          	li	a4,115
    1360:	1ce78063          	beq	a5,a4,1520 <printf+0x23c>
    1364:	18f76663          	bltu	a4,a5,14f0 <printf+0x20c>
    1368:	06400713          	li	a4,100
    136c:	1ae78063          	beq	a5,a4,150c <printf+0x228>
    1370:	07000713          	li	a4,112
    1374:	1ce79963          	bne	a5,a4,1546 <printf+0x262>
            printptr(va_arg(ap, uint64));
    1378:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    137a:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    137e:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    1380:	631c                	ld	a5,0(a4)
    1382:	0721                	addi	a4,a4,8
    1384:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1386:	00479293          	slli	t0,a5,0x4
    138a:	00879f93          	slli	t6,a5,0x8
    138e:	00c79f13          	slli	t5,a5,0xc
    1392:	01079e93          	slli	t4,a5,0x10
    1396:	01479e13          	slli	t3,a5,0x14
    139a:	01879313          	slli	t1,a5,0x18
    139e:	01c79893          	slli	a7,a5,0x1c
    13a2:	02479813          	slli	a6,a5,0x24
    13a6:	02879513          	slli	a0,a5,0x28
    13aa:	02c79593          	slli	a1,a5,0x2c
    13ae:	03079693          	slli	a3,a5,0x30
    13b2:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13b6:	03c7d413          	srli	s0,a5,0x3c
    13ba:	01c7d39b          	srliw	t2,a5,0x1c
    13be:	03c2d293          	srli	t0,t0,0x3c
    13c2:	03cfdf93          	srli	t6,t6,0x3c
    13c6:	03cf5f13          	srli	t5,t5,0x3c
    13ca:	03cede93          	srli	t4,t4,0x3c
    13ce:	03ce5e13          	srli	t3,t3,0x3c
    13d2:	03c35313          	srli	t1,t1,0x3c
    13d6:	03c8d893          	srli	a7,a7,0x3c
    13da:	03c85813          	srli	a6,a6,0x3c
    13de:	9171                	srli	a0,a0,0x3c
    13e0:	91f1                	srli	a1,a1,0x3c
    13e2:	92f1                	srli	a3,a3,0x3c
    13e4:	9371                	srli	a4,a4,0x3c
    13e6:	96ce                	add	a3,a3,s3
    13e8:	974e                	add	a4,a4,s3
    13ea:	944e                	add	s0,s0,s3
    13ec:	92ce                	add	t0,t0,s3
    13ee:	9fce                	add	t6,t6,s3
    13f0:	9f4e                	add	t5,t5,s3
    13f2:	9ece                	add	t4,t4,s3
    13f4:	9e4e                	add	t3,t3,s3
    13f6:	934e                	add	t1,t1,s3
    13f8:	98ce                	add	a7,a7,s3
    13fa:	93ce                	add	t2,t2,s3
    13fc:	984e                	add	a6,a6,s3
    13fe:	954e                	add	a0,a0,s3
    1400:	95ce                	add	a1,a1,s3
    1402:	0006c083          	lbu	ra,0(a3)
    1406:	0002c283          	lbu	t0,0(t0)
    140a:	00074683          	lbu	a3,0(a4)
    140e:	000fcf83          	lbu	t6,0(t6)
    1412:	000f4f03          	lbu	t5,0(t5)
    1416:	000ece83          	lbu	t4,0(t4)
    141a:	000e4e03          	lbu	t3,0(t3)
    141e:	00034303          	lbu	t1,0(t1)
    1422:	0008c883          	lbu	a7,0(a7)
    1426:	0003c383          	lbu	t2,0(t2)
    142a:	00084803          	lbu	a6,0(a6)
    142e:	00054503          	lbu	a0,0(a0)
    1432:	0005c583          	lbu	a1,0(a1)
    1436:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    143a:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    143e:	9371                	srli	a4,a4,0x3c
    1440:	8bbd                	andi	a5,a5,15
    1442:	974e                	add	a4,a4,s3
    1444:	97ce                	add	a5,a5,s3
    1446:	005105a3          	sb	t0,11(sp)
    144a:	01f10623          	sb	t6,12(sp)
    144e:	01e106a3          	sb	t5,13(sp)
    1452:	01d10723          	sb	t4,14(sp)
    1456:	01c107a3          	sb	t3,15(sp)
    145a:	00610823          	sb	t1,16(sp)
    145e:	011108a3          	sb	a7,17(sp)
    1462:	00710923          	sb	t2,18(sp)
    1466:	010109a3          	sb	a6,19(sp)
    146a:	00a10a23          	sb	a0,20(sp)
    146e:	00b10aa3          	sb	a1,21(sp)
    1472:	00110b23          	sb	ra,22(sp)
    1476:	00d10ba3          	sb	a3,23(sp)
    147a:	00810523          	sb	s0,10(sp)
    147e:	00074703          	lbu	a4,0(a4)
    1482:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1486:	002c                	addi	a1,sp,8
    1488:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    148a:	00e10c23          	sb	a4,24(sp)
    148e:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1492:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1496:	7d0000ef          	jal	ra,1c66 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    149a:	00248513          	addi	a0,s1,2
        if (!*s)
    149e:	00054783          	lbu	a5,0(a0)
    14a2:	e80798e3          	bnez	a5,1332 <printf+0x4e>
    }
    va_end(ap);
}
    14a6:	70a6                	ld	ra,104(sp)
    14a8:	7406                	ld	s0,96(sp)
    14aa:	64e6                	ld	s1,88(sp)
    14ac:	6946                	ld	s2,80(sp)
    14ae:	69a6                	ld	s3,72(sp)
    14b0:	6a06                	ld	s4,64(sp)
    14b2:	7ae2                	ld	s5,56(sp)
    14b4:	7b42                	ld	s6,48(sp)
    14b6:	614d                	addi	sp,sp,176
    14b8:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14ba:	00064783          	lbu	a5,0(a2)
    14be:	84b2                	mv	s1,a2
    14c0:	01278963          	beq	a5,s2,14d2 <printf+0x1ee>
    14c4:	bdbd                	j	1342 <printf+0x5e>
    14c6:	0024c783          	lbu	a5,2(s1)
    14ca:	0605                	addi	a2,a2,1
    14cc:	0489                	addi	s1,s1,2
    14ce:	e7279ae3          	bne	a5,s2,1342 <printf+0x5e>
    14d2:	0014c783          	lbu	a5,1(s1)
    14d6:	ff2788e3          	beq	a5,s2,14c6 <printf+0x1e2>
        l = z - a;
    14da:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14de:	85aa                	mv	a1,a0
    14e0:	8622                	mv	a2,s0
    14e2:	4505                	li	a0,1
    14e4:	782000ef          	jal	ra,1c66 <write>
        if (l)
    14e8:	e60406e3          	beqz	s0,1354 <printf+0x70>
    14ec:	8526                	mv	a0,s1
    14ee:	bd35                	j	132a <printf+0x46>
        switch (s[1])
    14f0:	07800713          	li	a4,120
    14f4:	04e79963          	bne	a5,a4,1546 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    14f8:	6782                	ld	a5,0(sp)
    14fa:	45c1                	li	a1,16
    14fc:	4388                	lw	a0,0(a5)
    14fe:	07a1                	addi	a5,a5,8
    1500:	e03e                	sd	a5,0(sp)
    1502:	ba3ff0ef          	jal	ra,10a4 <printint.constprop.0>
        s += 2;
    1506:	00248513          	addi	a0,s1,2
    150a:	bf51                	j	149e <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    150c:	6782                	ld	a5,0(sp)
    150e:	45a9                	li	a1,10
    1510:	4388                	lw	a0,0(a5)
    1512:	07a1                	addi	a5,a5,8
    1514:	e03e                	sd	a5,0(sp)
    1516:	b8fff0ef          	jal	ra,10a4 <printint.constprop.0>
        s += 2;
    151a:	00248513          	addi	a0,s1,2
    151e:	b741                	j	149e <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1520:	6782                	ld	a5,0(sp)
    1522:	6380                	ld	s0,0(a5)
    1524:	07a1                	addi	a5,a5,8
    1526:	e03e                	sd	a5,0(sp)
    1528:	cc25                	beqz	s0,15a0 <printf+0x2bc>
            l = strnlen(a, 200);
    152a:	0c800593          	li	a1,200
    152e:	8522                	mv	a0,s0
    1530:	43e000ef          	jal	ra,196e <strnlen>
    write(f, s, l);
    1534:	0005061b          	sext.w	a2,a0
    1538:	85a2                	mv	a1,s0
    153a:	4505                	li	a0,1
    153c:	72a000ef          	jal	ra,1c66 <write>
        s += 2;
    1540:	00248513          	addi	a0,s1,2
    1544:	bfa9                	j	149e <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1546:	3e700893          	li	a7,999
    154a:	4505                	li	a0,1
    154c:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1550:	04000893          	li	a7,64
    1554:	4505                	li	a0,1
    1556:	85d6                	mv	a1,s5
    1558:	4611                	li	a2,4
    155a:	00000073          	ecall
    char byte = c;
    155e:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1562:	4605                	li	a2,1
    1564:	002c                	addi	a1,sp,8
    1566:	4505                	li	a0,1
    char byte = c;
    1568:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    156c:	6fa000ef          	jal	ra,1c66 <write>
            putchar(s[1]);
    1570:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1574:	3e700893          	li	a7,999
    1578:	4505                	li	a0,1
    157a:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    157e:	04000893          	li	a7,64
    1582:	4505                	li	a0,1
    1584:	85d6                	mv	a1,s5
    1586:	4611                	li	a2,4
    1588:	00000073          	ecall
    return write(stdout, &byte, 1);
    158c:	4605                	li	a2,1
    158e:	002c                	addi	a1,sp,8
    1590:	4505                	li	a0,1
    char byte = c;
    1592:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1596:	6d0000ef          	jal	ra,1c66 <write>
        s += 2;
    159a:	00248513          	addi	a0,s1,2
    159e:	b701                	j	149e <printf+0x1ba>
                a = "(null)";
    15a0:	845a                	mv	s0,s6
    15a2:	b761                	j	152a <printf+0x246>

00000000000015a4 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15a4:	1141                	addi	sp,sp,-16
    15a6:	e406                	sd	ra,8(sp)
    puts(m);
    15a8:	d1bff0ef          	jal	ra,12c2 <puts>
    exit(-100);
}
    15ac:	60a2                	ld	ra,8(sp)
    exit(-100);
    15ae:	f9c00513          	li	a0,-100
}
    15b2:	0141                	addi	sp,sp,16
    exit(-100);
    15b4:	a709                	j	1cb6 <exit>

00000000000015b6 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15b6:	02000793          	li	a5,32
    15ba:	00f50663          	beq	a0,a5,15c6 <isspace+0x10>
    15be:	355d                	addiw	a0,a0,-9
    15c0:	00553513          	sltiu	a0,a0,5
    15c4:	8082                	ret
    15c6:	4505                	li	a0,1
}
    15c8:	8082                	ret

00000000000015ca <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15ca:	fd05051b          	addiw	a0,a0,-48
}
    15ce:	00a53513          	sltiu	a0,a0,10
    15d2:	8082                	ret

00000000000015d4 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d4:	02000613          	li	a2,32
    15d8:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15da:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15de:	ff77069b          	addiw	a3,a4,-9
    15e2:	04c70d63          	beq	a4,a2,163c <atoi+0x68>
    15e6:	0007079b          	sext.w	a5,a4
    15ea:	04d5f963          	bgeu	a1,a3,163c <atoi+0x68>
        s++;
    switch (*s)
    15ee:	02b00693          	li	a3,43
    15f2:	04d70a63          	beq	a4,a3,1646 <atoi+0x72>
    15f6:	02d00693          	li	a3,45
    15fa:	06d70463          	beq	a4,a3,1662 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15fe:	fd07859b          	addiw	a1,a5,-48
    1602:	4625                	li	a2,9
    1604:	873e                	mv	a4,a5
    1606:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1608:	4e01                	li	t3,0
    while (isdigit(*s))
    160a:	04b66a63          	bltu	a2,a1,165e <atoi+0x8a>
    int n = 0, neg = 0;
    160e:	4501                	li	a0,0
    while (isdigit(*s))
    1610:	4825                	li	a6,9
    1612:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1616:	0025179b          	slliw	a5,a0,0x2
    161a:	9d3d                	addw	a0,a0,a5
    161c:	fd07031b          	addiw	t1,a4,-48
    1620:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1624:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1628:	0685                	addi	a3,a3,1
    162a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    162e:	0006071b          	sext.w	a4,a2
    1632:	feb870e3          	bgeu	a6,a1,1612 <atoi+0x3e>
    return neg ? n : -n;
    1636:	000e0563          	beqz	t3,1640 <atoi+0x6c>
}
    163a:	8082                	ret
        s++;
    163c:	0505                	addi	a0,a0,1
    163e:	bf71                	j	15da <atoi+0x6>
    1640:	4113053b          	subw	a0,t1,a7
    1644:	8082                	ret
    while (isdigit(*s))
    1646:	00154783          	lbu	a5,1(a0)
    164a:	4625                	li	a2,9
        s++;
    164c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1650:	fd07859b          	addiw	a1,a5,-48
    1654:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1658:	4e01                	li	t3,0
    while (isdigit(*s))
    165a:	fab67ae3          	bgeu	a2,a1,160e <atoi+0x3a>
    165e:	4501                	li	a0,0
}
    1660:	8082                	ret
    while (isdigit(*s))
    1662:	00154783          	lbu	a5,1(a0)
    1666:	4625                	li	a2,9
        s++;
    1668:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    166c:	fd07859b          	addiw	a1,a5,-48
    1670:	0007871b          	sext.w	a4,a5
    1674:	feb665e3          	bltu	a2,a1,165e <atoi+0x8a>
        neg = 1;
    1678:	4e05                	li	t3,1
    167a:	bf51                	j	160e <atoi+0x3a>

000000000000167c <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    167c:	16060d63          	beqz	a2,17f6 <memset+0x17a>
    1680:	40a007b3          	neg	a5,a0
    1684:	8b9d                	andi	a5,a5,7
    1686:	00778713          	addi	a4,a5,7
    168a:	482d                	li	a6,11
    168c:	0ff5f593          	zext.b	a1,a1
    1690:	fff60693          	addi	a3,a2,-1
    1694:	17076263          	bltu	a4,a6,17f8 <memset+0x17c>
    1698:	16e6ea63          	bltu	a3,a4,180c <memset+0x190>
    169c:	16078563          	beqz	a5,1806 <memset+0x18a>
    16a0:	00b50023          	sb	a1,0(a0)
    16a4:	4705                	li	a4,1
    16a6:	00150e93          	addi	t4,a0,1
    16aa:	14e78c63          	beq	a5,a4,1802 <memset+0x186>
    16ae:	00b500a3          	sb	a1,1(a0)
    16b2:	4709                	li	a4,2
    16b4:	00250e93          	addi	t4,a0,2
    16b8:	14e78d63          	beq	a5,a4,1812 <memset+0x196>
    16bc:	00b50123          	sb	a1,2(a0)
    16c0:	470d                	li	a4,3
    16c2:	00350e93          	addi	t4,a0,3
    16c6:	12e78b63          	beq	a5,a4,17fc <memset+0x180>
    16ca:	00b501a3          	sb	a1,3(a0)
    16ce:	4711                	li	a4,4
    16d0:	00450e93          	addi	t4,a0,4
    16d4:	14e78163          	beq	a5,a4,1816 <memset+0x19a>
    16d8:	00b50223          	sb	a1,4(a0)
    16dc:	4715                	li	a4,5
    16de:	00550e93          	addi	t4,a0,5
    16e2:	12e78c63          	beq	a5,a4,181a <memset+0x19e>
    16e6:	00b502a3          	sb	a1,5(a0)
    16ea:	471d                	li	a4,7
    16ec:	00650e93          	addi	t4,a0,6
    16f0:	12e79763          	bne	a5,a4,181e <memset+0x1a2>
    16f4:	00750e93          	addi	t4,a0,7
    16f8:	00b50323          	sb	a1,6(a0)
    16fc:	4f1d                	li	t5,7
    16fe:	00859713          	slli	a4,a1,0x8
    1702:	8f4d                	or	a4,a4,a1
    1704:	01059e13          	slli	t3,a1,0x10
    1708:	01c76e33          	or	t3,a4,t3
    170c:	01859313          	slli	t1,a1,0x18
    1710:	006e6333          	or	t1,t3,t1
    1714:	02059893          	slli	a7,a1,0x20
    1718:	011368b3          	or	a7,t1,a7
    171c:	02859813          	slli	a6,a1,0x28
    1720:	40f60333          	sub	t1,a2,a5
    1724:	0108e833          	or	a6,a7,a6
    1728:	03059693          	slli	a3,a1,0x30
    172c:	00d866b3          	or	a3,a6,a3
    1730:	03859713          	slli	a4,a1,0x38
    1734:	97aa                	add	a5,a5,a0
    1736:	ff837813          	andi	a6,t1,-8
    173a:	8f55                	or	a4,a4,a3
    173c:	00f806b3          	add	a3,a6,a5
    1740:	e398                	sd	a4,0(a5)
    1742:	07a1                	addi	a5,a5,8
    1744:	fed79ee3          	bne	a5,a3,1740 <memset+0xc4>
    1748:	ff837693          	andi	a3,t1,-8
    174c:	00de87b3          	add	a5,t4,a3
    1750:	01e6873b          	addw	a4,a3,t5
    1754:	0ad30663          	beq	t1,a3,1800 <memset+0x184>
    1758:	00b78023          	sb	a1,0(a5)
    175c:	0017069b          	addiw	a3,a4,1
    1760:	08c6fb63          	bgeu	a3,a2,17f6 <memset+0x17a>
    1764:	00b780a3          	sb	a1,1(a5)
    1768:	0027069b          	addiw	a3,a4,2
    176c:	08c6f563          	bgeu	a3,a2,17f6 <memset+0x17a>
    1770:	00b78123          	sb	a1,2(a5)
    1774:	0037069b          	addiw	a3,a4,3
    1778:	06c6ff63          	bgeu	a3,a2,17f6 <memset+0x17a>
    177c:	00b781a3          	sb	a1,3(a5)
    1780:	0047069b          	addiw	a3,a4,4
    1784:	06c6f963          	bgeu	a3,a2,17f6 <memset+0x17a>
    1788:	00b78223          	sb	a1,4(a5)
    178c:	0057069b          	addiw	a3,a4,5
    1790:	06c6f363          	bgeu	a3,a2,17f6 <memset+0x17a>
    1794:	00b782a3          	sb	a1,5(a5)
    1798:	0067069b          	addiw	a3,a4,6
    179c:	04c6fd63          	bgeu	a3,a2,17f6 <memset+0x17a>
    17a0:	00b78323          	sb	a1,6(a5)
    17a4:	0077069b          	addiw	a3,a4,7
    17a8:	04c6f763          	bgeu	a3,a2,17f6 <memset+0x17a>
    17ac:	00b783a3          	sb	a1,7(a5)
    17b0:	0087069b          	addiw	a3,a4,8
    17b4:	04c6f163          	bgeu	a3,a2,17f6 <memset+0x17a>
    17b8:	00b78423          	sb	a1,8(a5)
    17bc:	0097069b          	addiw	a3,a4,9
    17c0:	02c6fb63          	bgeu	a3,a2,17f6 <memset+0x17a>
    17c4:	00b784a3          	sb	a1,9(a5)
    17c8:	00a7069b          	addiw	a3,a4,10
    17cc:	02c6f563          	bgeu	a3,a2,17f6 <memset+0x17a>
    17d0:	00b78523          	sb	a1,10(a5)
    17d4:	00b7069b          	addiw	a3,a4,11
    17d8:	00c6ff63          	bgeu	a3,a2,17f6 <memset+0x17a>
    17dc:	00b785a3          	sb	a1,11(a5)
    17e0:	00c7069b          	addiw	a3,a4,12
    17e4:	00c6f963          	bgeu	a3,a2,17f6 <memset+0x17a>
    17e8:	00b78623          	sb	a1,12(a5)
    17ec:	2735                	addiw	a4,a4,13
    17ee:	00c77463          	bgeu	a4,a2,17f6 <memset+0x17a>
    17f2:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    17f6:	8082                	ret
    17f8:	472d                	li	a4,11
    17fa:	bd79                	j	1698 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    17fc:	4f0d                	li	t5,3
    17fe:	b701                	j	16fe <memset+0x82>
    1800:	8082                	ret
    1802:	4f05                	li	t5,1
    1804:	bded                	j	16fe <memset+0x82>
    1806:	8eaa                	mv	t4,a0
    1808:	4f01                	li	t5,0
    180a:	bdd5                	j	16fe <memset+0x82>
    180c:	87aa                	mv	a5,a0
    180e:	4701                	li	a4,0
    1810:	b7a1                	j	1758 <memset+0xdc>
    1812:	4f09                	li	t5,2
    1814:	b5ed                	j	16fe <memset+0x82>
    1816:	4f11                	li	t5,4
    1818:	b5dd                	j	16fe <memset+0x82>
    181a:	4f15                	li	t5,5
    181c:	b5cd                	j	16fe <memset+0x82>
    181e:	4f19                	li	t5,6
    1820:	bdf9                	j	16fe <memset+0x82>

0000000000001822 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1822:	00054783          	lbu	a5,0(a0)
    1826:	0005c703          	lbu	a4,0(a1)
    182a:	00e79863          	bne	a5,a4,183a <strcmp+0x18>
    182e:	0505                	addi	a0,a0,1
    1830:	0585                	addi	a1,a1,1
    1832:	fbe5                	bnez	a5,1822 <strcmp>
    1834:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1836:	9d19                	subw	a0,a0,a4
    1838:	8082                	ret
    183a:	0007851b          	sext.w	a0,a5
    183e:	bfe5                	j	1836 <strcmp+0x14>

0000000000001840 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1840:	ce05                	beqz	a2,1878 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1842:	00054703          	lbu	a4,0(a0)
    1846:	0005c783          	lbu	a5,0(a1)
    184a:	cb0d                	beqz	a4,187c <strncmp+0x3c>
    if (!n--)
    184c:	167d                	addi	a2,a2,-1
    184e:	00c506b3          	add	a3,a0,a2
    1852:	a819                	j	1868 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1854:	00a68e63          	beq	a3,a0,1870 <strncmp+0x30>
    1858:	0505                	addi	a0,a0,1
    185a:	00e79b63          	bne	a5,a4,1870 <strncmp+0x30>
    185e:	00054703          	lbu	a4,0(a0)
    1862:	0005c783          	lbu	a5,0(a1)
    1866:	cb19                	beqz	a4,187c <strncmp+0x3c>
    1868:	0005c783          	lbu	a5,0(a1)
    186c:	0585                	addi	a1,a1,1
    186e:	f3fd                	bnez	a5,1854 <strncmp+0x14>
        ;
    return *l - *r;
    1870:	0007051b          	sext.w	a0,a4
    1874:	9d1d                	subw	a0,a0,a5
    1876:	8082                	ret
        return 0;
    1878:	4501                	li	a0,0
}
    187a:	8082                	ret
    187c:	4501                	li	a0,0
    return *l - *r;
    187e:	9d1d                	subw	a0,a0,a5
    1880:	8082                	ret

0000000000001882 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1882:	00757793          	andi	a5,a0,7
    1886:	cf89                	beqz	a5,18a0 <strlen+0x1e>
    1888:	87aa                	mv	a5,a0
    188a:	a029                	j	1894 <strlen+0x12>
    188c:	0785                	addi	a5,a5,1
    188e:	0077f713          	andi	a4,a5,7
    1892:	cb01                	beqz	a4,18a2 <strlen+0x20>
        if (!*s)
    1894:	0007c703          	lbu	a4,0(a5)
    1898:	fb75                	bnez	a4,188c <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    189a:	40a78533          	sub	a0,a5,a0
}
    189e:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18a0:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18a2:	6394                	ld	a3,0(a5)
    18a4:	00000597          	auipc	a1,0x0
    18a8:	6a45b583          	ld	a1,1700(a1) # 1f48 <__clone+0xaa>
    18ac:	00000617          	auipc	a2,0x0
    18b0:	6a463603          	ld	a2,1700(a2) # 1f50 <__clone+0xb2>
    18b4:	a019                	j	18ba <strlen+0x38>
    18b6:	6794                	ld	a3,8(a5)
    18b8:	07a1                	addi	a5,a5,8
    18ba:	00b68733          	add	a4,a3,a1
    18be:	fff6c693          	not	a3,a3
    18c2:	8f75                	and	a4,a4,a3
    18c4:	8f71                	and	a4,a4,a2
    18c6:	db65                	beqz	a4,18b6 <strlen+0x34>
    for (; *s; s++)
    18c8:	0007c703          	lbu	a4,0(a5)
    18cc:	d779                	beqz	a4,189a <strlen+0x18>
    18ce:	0017c703          	lbu	a4,1(a5)
    18d2:	0785                	addi	a5,a5,1
    18d4:	d379                	beqz	a4,189a <strlen+0x18>
    18d6:	0017c703          	lbu	a4,1(a5)
    18da:	0785                	addi	a5,a5,1
    18dc:	fb6d                	bnez	a4,18ce <strlen+0x4c>
    18de:	bf75                	j	189a <strlen+0x18>

00000000000018e0 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18e0:	00757713          	andi	a4,a0,7
{
    18e4:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18e6:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18ea:	cb19                	beqz	a4,1900 <memchr+0x20>
    18ec:	ce25                	beqz	a2,1964 <memchr+0x84>
    18ee:	0007c703          	lbu	a4,0(a5)
    18f2:	04b70e63          	beq	a4,a1,194e <memchr+0x6e>
    18f6:	0785                	addi	a5,a5,1
    18f8:	0077f713          	andi	a4,a5,7
    18fc:	167d                	addi	a2,a2,-1
    18fe:	f77d                	bnez	a4,18ec <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1900:	4501                	li	a0,0
    if (n && *s != c)
    1902:	c235                	beqz	a2,1966 <memchr+0x86>
    1904:	0007c703          	lbu	a4,0(a5)
    1908:	04b70363          	beq	a4,a1,194e <memchr+0x6e>
        size_t k = ONES * c;
    190c:	00000517          	auipc	a0,0x0
    1910:	64c53503          	ld	a0,1612(a0) # 1f58 <__clone+0xba>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1914:	471d                	li	a4,7
        size_t k = ONES * c;
    1916:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    191a:	02c77a63          	bgeu	a4,a2,194e <memchr+0x6e>
    191e:	00000897          	auipc	a7,0x0
    1922:	62a8b883          	ld	a7,1578(a7) # 1f48 <__clone+0xaa>
    1926:	00000817          	auipc	a6,0x0
    192a:	62a83803          	ld	a6,1578(a6) # 1f50 <__clone+0xb2>
    192e:	431d                	li	t1,7
    1930:	a029                	j	193a <memchr+0x5a>
    1932:	1661                	addi	a2,a2,-8
    1934:	07a1                	addi	a5,a5,8
    1936:	02c37963          	bgeu	t1,a2,1968 <memchr+0x88>
    193a:	6398                	ld	a4,0(a5)
    193c:	8f29                	xor	a4,a4,a0
    193e:	011706b3          	add	a3,a4,a7
    1942:	fff74713          	not	a4,a4
    1946:	8f75                	and	a4,a4,a3
    1948:	01077733          	and	a4,a4,a6
    194c:	d37d                	beqz	a4,1932 <memchr+0x52>
    194e:	853e                	mv	a0,a5
    1950:	97b2                	add	a5,a5,a2
    1952:	a021                	j	195a <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1954:	0505                	addi	a0,a0,1
    1956:	00f50763          	beq	a0,a5,1964 <memchr+0x84>
    195a:	00054703          	lbu	a4,0(a0)
    195e:	feb71be3          	bne	a4,a1,1954 <memchr+0x74>
    1962:	8082                	ret
    return n ? (void *)s : 0;
    1964:	4501                	li	a0,0
}
    1966:	8082                	ret
    return n ? (void *)s : 0;
    1968:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    196a:	f275                	bnez	a2,194e <memchr+0x6e>
}
    196c:	8082                	ret

000000000000196e <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    196e:	1101                	addi	sp,sp,-32
    1970:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1972:	862e                	mv	a2,a1
{
    1974:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1976:	4581                	li	a1,0
{
    1978:	e426                	sd	s1,8(sp)
    197a:	ec06                	sd	ra,24(sp)
    197c:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    197e:	f63ff0ef          	jal	ra,18e0 <memchr>
    return p ? p - s : n;
    1982:	c519                	beqz	a0,1990 <strnlen+0x22>
}
    1984:	60e2                	ld	ra,24(sp)
    1986:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1988:	8d05                	sub	a0,a0,s1
}
    198a:	64a2                	ld	s1,8(sp)
    198c:	6105                	addi	sp,sp,32
    198e:	8082                	ret
    1990:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1992:	8522                	mv	a0,s0
}
    1994:	6442                	ld	s0,16(sp)
    1996:	64a2                	ld	s1,8(sp)
    1998:	6105                	addi	sp,sp,32
    199a:	8082                	ret

000000000000199c <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    199c:	00b547b3          	xor	a5,a0,a1
    19a0:	8b9d                	andi	a5,a5,7
    19a2:	eb95                	bnez	a5,19d6 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19a4:	0075f793          	andi	a5,a1,7
    19a8:	e7b1                	bnez	a5,19f4 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19aa:	6198                	ld	a4,0(a1)
    19ac:	00000617          	auipc	a2,0x0
    19b0:	59c63603          	ld	a2,1436(a2) # 1f48 <__clone+0xaa>
    19b4:	00000817          	auipc	a6,0x0
    19b8:	59c83803          	ld	a6,1436(a6) # 1f50 <__clone+0xb2>
    19bc:	a029                	j	19c6 <strcpy+0x2a>
    19be:	e118                	sd	a4,0(a0)
    19c0:	6598                	ld	a4,8(a1)
    19c2:	05a1                	addi	a1,a1,8
    19c4:	0521                	addi	a0,a0,8
    19c6:	00c707b3          	add	a5,a4,a2
    19ca:	fff74693          	not	a3,a4
    19ce:	8ff5                	and	a5,a5,a3
    19d0:	0107f7b3          	and	a5,a5,a6
    19d4:	d7ed                	beqz	a5,19be <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19d6:	0005c783          	lbu	a5,0(a1)
    19da:	00f50023          	sb	a5,0(a0)
    19de:	c785                	beqz	a5,1a06 <strcpy+0x6a>
    19e0:	0015c783          	lbu	a5,1(a1)
    19e4:	0505                	addi	a0,a0,1
    19e6:	0585                	addi	a1,a1,1
    19e8:	00f50023          	sb	a5,0(a0)
    19ec:	fbf5                	bnez	a5,19e0 <strcpy+0x44>
        ;
    return d;
}
    19ee:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19f0:	0505                	addi	a0,a0,1
    19f2:	df45                	beqz	a4,19aa <strcpy+0xe>
            if (!(*d = *s))
    19f4:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19f8:	0585                	addi	a1,a1,1
    19fa:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    19fe:	00f50023          	sb	a5,0(a0)
    1a02:	f7fd                	bnez	a5,19f0 <strcpy+0x54>
}
    1a04:	8082                	ret
    1a06:	8082                	ret

0000000000001a08 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a08:	00b547b3          	xor	a5,a0,a1
    1a0c:	8b9d                	andi	a5,a5,7
    1a0e:	1a079863          	bnez	a5,1bbe <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a12:	0075f793          	andi	a5,a1,7
    1a16:	16078463          	beqz	a5,1b7e <strncpy+0x176>
    1a1a:	ea01                	bnez	a2,1a2a <strncpy+0x22>
    1a1c:	a421                	j	1c24 <strncpy+0x21c>
    1a1e:	167d                	addi	a2,a2,-1
    1a20:	0505                	addi	a0,a0,1
    1a22:	14070e63          	beqz	a4,1b7e <strncpy+0x176>
    1a26:	1a060863          	beqz	a2,1bd6 <strncpy+0x1ce>
    1a2a:	0005c783          	lbu	a5,0(a1)
    1a2e:	0585                	addi	a1,a1,1
    1a30:	0075f713          	andi	a4,a1,7
    1a34:	00f50023          	sb	a5,0(a0)
    1a38:	f3fd                	bnez	a5,1a1e <strncpy+0x16>
    1a3a:	4805                	li	a6,1
    1a3c:	1a061863          	bnez	a2,1bec <strncpy+0x1e4>
    1a40:	40a007b3          	neg	a5,a0
    1a44:	8b9d                	andi	a5,a5,7
    1a46:	4681                	li	a3,0
    1a48:	18061a63          	bnez	a2,1bdc <strncpy+0x1d4>
    1a4c:	00778713          	addi	a4,a5,7
    1a50:	45ad                	li	a1,11
    1a52:	18b76363          	bltu	a4,a1,1bd8 <strncpy+0x1d0>
    1a56:	1ae6eb63          	bltu	a3,a4,1c0c <strncpy+0x204>
    1a5a:	1a078363          	beqz	a5,1c00 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a5e:	00050023          	sb	zero,0(a0)
    1a62:	4685                	li	a3,1
    1a64:	00150713          	addi	a4,a0,1
    1a68:	18d78f63          	beq	a5,a3,1c06 <strncpy+0x1fe>
    1a6c:	000500a3          	sb	zero,1(a0)
    1a70:	4689                	li	a3,2
    1a72:	00250713          	addi	a4,a0,2
    1a76:	18d78e63          	beq	a5,a3,1c12 <strncpy+0x20a>
    1a7a:	00050123          	sb	zero,2(a0)
    1a7e:	468d                	li	a3,3
    1a80:	00350713          	addi	a4,a0,3
    1a84:	16d78c63          	beq	a5,a3,1bfc <strncpy+0x1f4>
    1a88:	000501a3          	sb	zero,3(a0)
    1a8c:	4691                	li	a3,4
    1a8e:	00450713          	addi	a4,a0,4
    1a92:	18d78263          	beq	a5,a3,1c16 <strncpy+0x20e>
    1a96:	00050223          	sb	zero,4(a0)
    1a9a:	4695                	li	a3,5
    1a9c:	00550713          	addi	a4,a0,5
    1aa0:	16d78d63          	beq	a5,a3,1c1a <strncpy+0x212>
    1aa4:	000502a3          	sb	zero,5(a0)
    1aa8:	469d                	li	a3,7
    1aaa:	00650713          	addi	a4,a0,6
    1aae:	16d79863          	bne	a5,a3,1c1e <strncpy+0x216>
    1ab2:	00750713          	addi	a4,a0,7
    1ab6:	00050323          	sb	zero,6(a0)
    1aba:	40f80833          	sub	a6,a6,a5
    1abe:	ff887593          	andi	a1,a6,-8
    1ac2:	97aa                	add	a5,a5,a0
    1ac4:	95be                	add	a1,a1,a5
    1ac6:	0007b023          	sd	zero,0(a5)
    1aca:	07a1                	addi	a5,a5,8
    1acc:	feb79de3          	bne	a5,a1,1ac6 <strncpy+0xbe>
    1ad0:	ff887593          	andi	a1,a6,-8
    1ad4:	9ead                	addw	a3,a3,a1
    1ad6:	00b707b3          	add	a5,a4,a1
    1ada:	12b80863          	beq	a6,a1,1c0a <strncpy+0x202>
    1ade:	00078023          	sb	zero,0(a5)
    1ae2:	0016871b          	addiw	a4,a3,1
    1ae6:	0ec77863          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1aea:	000780a3          	sb	zero,1(a5)
    1aee:	0026871b          	addiw	a4,a3,2
    1af2:	0ec77263          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1af6:	00078123          	sb	zero,2(a5)
    1afa:	0036871b          	addiw	a4,a3,3
    1afe:	0cc77c63          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b02:	000781a3          	sb	zero,3(a5)
    1b06:	0046871b          	addiw	a4,a3,4
    1b0a:	0cc77663          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b0e:	00078223          	sb	zero,4(a5)
    1b12:	0056871b          	addiw	a4,a3,5
    1b16:	0cc77063          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b1a:	000782a3          	sb	zero,5(a5)
    1b1e:	0066871b          	addiw	a4,a3,6
    1b22:	0ac77a63          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b26:	00078323          	sb	zero,6(a5)
    1b2a:	0076871b          	addiw	a4,a3,7
    1b2e:	0ac77463          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b32:	000783a3          	sb	zero,7(a5)
    1b36:	0086871b          	addiw	a4,a3,8
    1b3a:	08c77e63          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b3e:	00078423          	sb	zero,8(a5)
    1b42:	0096871b          	addiw	a4,a3,9
    1b46:	08c77863          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b4a:	000784a3          	sb	zero,9(a5)
    1b4e:	00a6871b          	addiw	a4,a3,10
    1b52:	08c77263          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b56:	00078523          	sb	zero,10(a5)
    1b5a:	00b6871b          	addiw	a4,a3,11
    1b5e:	06c77c63          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b62:	000785a3          	sb	zero,11(a5)
    1b66:	00c6871b          	addiw	a4,a3,12
    1b6a:	06c77663          	bgeu	a4,a2,1bd6 <strncpy+0x1ce>
    1b6e:	00078623          	sb	zero,12(a5)
    1b72:	26b5                	addiw	a3,a3,13
    1b74:	06c6f163          	bgeu	a3,a2,1bd6 <strncpy+0x1ce>
    1b78:	000786a3          	sb	zero,13(a5)
    1b7c:	8082                	ret
            ;
        if (!n || !*s)
    1b7e:	c645                	beqz	a2,1c26 <strncpy+0x21e>
    1b80:	0005c783          	lbu	a5,0(a1)
    1b84:	ea078be3          	beqz	a5,1a3a <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b88:	479d                	li	a5,7
    1b8a:	02c7ff63          	bgeu	a5,a2,1bc8 <strncpy+0x1c0>
    1b8e:	00000897          	auipc	a7,0x0
    1b92:	3ba8b883          	ld	a7,954(a7) # 1f48 <__clone+0xaa>
    1b96:	00000817          	auipc	a6,0x0
    1b9a:	3ba83803          	ld	a6,954(a6) # 1f50 <__clone+0xb2>
    1b9e:	431d                	li	t1,7
    1ba0:	6198                	ld	a4,0(a1)
    1ba2:	011707b3          	add	a5,a4,a7
    1ba6:	fff74693          	not	a3,a4
    1baa:	8ff5                	and	a5,a5,a3
    1bac:	0107f7b3          	and	a5,a5,a6
    1bb0:	ef81                	bnez	a5,1bc8 <strncpy+0x1c0>
            *wd = *ws;
    1bb2:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bb4:	1661                	addi	a2,a2,-8
    1bb6:	05a1                	addi	a1,a1,8
    1bb8:	0521                	addi	a0,a0,8
    1bba:	fec363e3          	bltu	t1,a2,1ba0 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bbe:	e609                	bnez	a2,1bc8 <strncpy+0x1c0>
    1bc0:	a08d                	j	1c22 <strncpy+0x21a>
    1bc2:	167d                	addi	a2,a2,-1
    1bc4:	0505                	addi	a0,a0,1
    1bc6:	ca01                	beqz	a2,1bd6 <strncpy+0x1ce>
    1bc8:	0005c783          	lbu	a5,0(a1)
    1bcc:	0585                	addi	a1,a1,1
    1bce:	00f50023          	sb	a5,0(a0)
    1bd2:	fbe5                	bnez	a5,1bc2 <strncpy+0x1ba>
        ;
tail:
    1bd4:	b59d                	j	1a3a <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bd6:	8082                	ret
    1bd8:	472d                	li	a4,11
    1bda:	bdb5                	j	1a56 <strncpy+0x4e>
    1bdc:	00778713          	addi	a4,a5,7
    1be0:	45ad                	li	a1,11
    1be2:	fff60693          	addi	a3,a2,-1
    1be6:	e6b778e3          	bgeu	a4,a1,1a56 <strncpy+0x4e>
    1bea:	b7fd                	j	1bd8 <strncpy+0x1d0>
    1bec:	40a007b3          	neg	a5,a0
    1bf0:	8832                	mv	a6,a2
    1bf2:	8b9d                	andi	a5,a5,7
    1bf4:	4681                	li	a3,0
    1bf6:	e4060be3          	beqz	a2,1a4c <strncpy+0x44>
    1bfa:	b7cd                	j	1bdc <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1bfc:	468d                	li	a3,3
    1bfe:	bd75                	j	1aba <strncpy+0xb2>
    1c00:	872a                	mv	a4,a0
    1c02:	4681                	li	a3,0
    1c04:	bd5d                	j	1aba <strncpy+0xb2>
    1c06:	4685                	li	a3,1
    1c08:	bd4d                	j	1aba <strncpy+0xb2>
    1c0a:	8082                	ret
    1c0c:	87aa                	mv	a5,a0
    1c0e:	4681                	li	a3,0
    1c10:	b5f9                	j	1ade <strncpy+0xd6>
    1c12:	4689                	li	a3,2
    1c14:	b55d                	j	1aba <strncpy+0xb2>
    1c16:	4691                	li	a3,4
    1c18:	b54d                	j	1aba <strncpy+0xb2>
    1c1a:	4695                	li	a3,5
    1c1c:	bd79                	j	1aba <strncpy+0xb2>
    1c1e:	4699                	li	a3,6
    1c20:	bd69                	j	1aba <strncpy+0xb2>
    1c22:	8082                	ret
    1c24:	8082                	ret
    1c26:	8082                	ret

0000000000001c28 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c28:	87aa                	mv	a5,a0
    1c2a:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c2c:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c30:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c34:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c36:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c38:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c3c:	2501                	sext.w	a0,a0
    1c3e:	8082                	ret

0000000000001c40 <openat>:
    register long a7 __asm__("a7") = n;
    1c40:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c44:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c48:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c4c:	2501                	sext.w	a0,a0
    1c4e:	8082                	ret

0000000000001c50 <close>:
    register long a7 __asm__("a7") = n;
    1c50:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c54:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c58:	2501                	sext.w	a0,a0
    1c5a:	8082                	ret

0000000000001c5c <read>:
    register long a7 __asm__("a7") = n;
    1c5c:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c60:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c64:	8082                	ret

0000000000001c66 <write>:
    register long a7 __asm__("a7") = n;
    1c66:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c6a:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c6e:	8082                	ret

0000000000001c70 <getpid>:
    register long a7 __asm__("a7") = n;
    1c70:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c74:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c78:	2501                	sext.w	a0,a0
    1c7a:	8082                	ret

0000000000001c7c <getppid>:
    register long a7 __asm__("a7") = n;
    1c7c:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c80:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c84:	2501                	sext.w	a0,a0
    1c86:	8082                	ret

0000000000001c88 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c88:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c8c:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c90:	2501                	sext.w	a0,a0
    1c92:	8082                	ret

0000000000001c94 <fork>:
    register long a7 __asm__("a7") = n;
    1c94:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c98:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1c9a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c9c:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ca0:	2501                	sext.w	a0,a0
    1ca2:	8082                	ret

0000000000001ca4 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ca4:	85b2                	mv	a1,a2
    1ca6:	863a                	mv	a2,a4
    if (stack)
    1ca8:	c191                	beqz	a1,1cac <clone+0x8>
	stack += stack_size;
    1caa:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cac:	4781                	li	a5,0
    1cae:	4701                	li	a4,0
    1cb0:	4681                	li	a3,0
    1cb2:	2601                	sext.w	a2,a2
    1cb4:	a2ed                	j	1e9e <__clone>

0000000000001cb6 <exit>:
    register long a7 __asm__("a7") = n;
    1cb6:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cba:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cbe:	8082                	ret

0000000000001cc0 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc0:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cc4:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cc6:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <exec>:
    register long a7 __asm__("a7") = n;
    1cce:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cd2:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <execve>:
    register long a7 __asm__("a7") = n;
    1cda:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cde:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <times>:
    register long a7 __asm__("a7") = n;
    1ce6:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cea:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <get_time>:

int64 get_time()
{
    1cf2:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1cf4:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1cf8:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1cfa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfc:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d00:	2501                	sext.w	a0,a0
    1d02:	ed09                	bnez	a0,1d1c <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d04:	67a2                	ld	a5,8(sp)
    1d06:	3e800713          	li	a4,1000
    1d0a:	00015503          	lhu	a0,0(sp)
    1d0e:	02e7d7b3          	divu	a5,a5,a4
    1d12:	02e50533          	mul	a0,a0,a4
    1d16:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d18:	0141                	addi	sp,sp,16
    1d1a:	8082                	ret
        return -1;
    1d1c:	557d                	li	a0,-1
    1d1e:	bfed                	j	1d18 <get_time+0x26>

0000000000001d20 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d20:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d24:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d28:	2501                	sext.w	a0,a0
    1d2a:	8082                	ret

0000000000001d2c <time>:
    register long a7 __asm__("a7") = n;
    1d2c:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d30:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <sleep>:

int sleep(unsigned long long time)
{
    1d38:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d3a:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d3c:	850a                	mv	a0,sp
    1d3e:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d40:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d44:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d46:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d4a:	e501                	bnez	a0,1d52 <sleep+0x1a>
    return 0;
    1d4c:	4501                	li	a0,0
}
    1d4e:	0141                	addi	sp,sp,16
    1d50:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d52:	4502                	lw	a0,0(sp)
}
    1d54:	0141                	addi	sp,sp,16
    1d56:	8082                	ret

0000000000001d58 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d58:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d5c:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d60:	2501                	sext.w	a0,a0
    1d62:	8082                	ret

0000000000001d64 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d64:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d68:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d6c:	8082                	ret

0000000000001d6e <munmap>:
    register long a7 __asm__("a7") = n;
    1d6e:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d72:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d76:	2501                	sext.w	a0,a0
    1d78:	8082                	ret

0000000000001d7a <wait>:

int wait(int *code)
{
    1d7a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d7c:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d80:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d82:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d84:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d86:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d8a:	2501                	sext.w	a0,a0
    1d8c:	8082                	ret

0000000000001d8e <spawn>:
    register long a7 __asm__("a7") = n;
    1d8e:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d92:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d96:	2501                	sext.w	a0,a0
    1d98:	8082                	ret

0000000000001d9a <mailread>:
    register long a7 __asm__("a7") = n;
    1d9a:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d9e:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1da2:	2501                	sext.w	a0,a0
    1da4:	8082                	ret

0000000000001da6 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1da6:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1daa:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dae:	2501                	sext.w	a0,a0
    1db0:	8082                	ret

0000000000001db2 <fstat>:
    register long a7 __asm__("a7") = n;
    1db2:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db6:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dbe:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dc0:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dc4:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dc6:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dce:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dd0:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dd4:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dd6:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dda:	2501                	sext.w	a0,a0
    1ddc:	8082                	ret

0000000000001dde <link>:

int link(char *old_path, char *new_path)
{
    1dde:	87aa                	mv	a5,a0
    1de0:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1de2:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1de6:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1dea:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1dec:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1df0:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df2:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1df6:	2501                	sext.w	a0,a0
    1df8:	8082                	ret

0000000000001dfa <unlink>:

int unlink(char *path)
{
    1dfa:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dfc:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e00:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e04:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e06:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <uname>:
    register long a7 __asm__("a7") = n;
    1e0e:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e12:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e16:	2501                	sext.w	a0,a0
    1e18:	8082                	ret

0000000000001e1a <brk>:
    register long a7 __asm__("a7") = n;
    1e1a:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e1e:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e26:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e28:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e2c:	8082                	ret

0000000000001e2e <chdir>:
    register long a7 __asm__("a7") = n;
    1e2e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e32:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e36:	2501                	sext.w	a0,a0
    1e38:	8082                	ret

0000000000001e3a <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e3a:	862e                	mv	a2,a1
    1e3c:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e3e:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e40:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e44:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e48:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e4a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4c:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e50:	2501                	sext.w	a0,a0
    1e52:	8082                	ret

0000000000001e54 <getdents>:
    register long a7 __asm__("a7") = n;
    1e54:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e58:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e5c:	2501                	sext.w	a0,a0
    1e5e:	8082                	ret

0000000000001e60 <pipe>:
    register long a7 __asm__("a7") = n;
    1e60:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e64:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e66:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <dup>:
    register long a7 __asm__("a7") = n;
    1e6e:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e70:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <dup2>:
    register long a7 __asm__("a7") = n;
    1e78:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e7a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7c:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <mount>:
    register long a7 __asm__("a7") = n;
    1e84:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e88:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <umount>:
    register long a7 __asm__("a7") = n;
    1e90:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e94:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e96:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1e9e:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ea0:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ea2:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ea4:	8532                	mv	a0,a2
	mv a2, a4
    1ea6:	863a                	mv	a2,a4
	mv a3, a5
    1ea8:	86be                	mv	a3,a5
	mv a4, a6
    1eaa:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eac:	0dc00893          	li	a7,220
	ecall
    1eb0:	00000073          	ecall

	beqz a0, 1f
    1eb4:	c111                	beqz	a0,1eb8 <__clone+0x1a>
	# Parent
	ret
    1eb6:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eb8:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1eba:	6522                	ld	a0,8(sp)
	jalr a1
    1ebc:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ebe:	05d00893          	li	a7,93
	ecall
    1ec2:	00000073          	ecall
