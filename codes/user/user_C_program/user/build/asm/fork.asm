
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/fork:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a05d                	j	10a8 <__start_main>

0000000000001004 <test_fork>:
 * 成功测试时子进程的输出：
 * "  child process."
 */
static int fd[2];

void test_fork(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ee250513          	addi	a0,a0,-286 # 1ee8 <__clone+0x2c>
void test_fork(void){
    100e:	ec06                	sd	ra,24(sp)
    TEST_START(__func__);
    1010:	2d0000ef          	jal	ra,12e0 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f8450513          	addi	a0,a0,-124 # 1f98 <__func__.1193>
    101c:	2c4000ef          	jal	ra,12e0 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ee050513          	addi	a0,a0,-288 # 1f00 <__clone+0x44>
    1028:	2b8000ef          	jal	ra,12e0 <puts>
    int cpid, wstatus;
    cpid = fork();
    102c:	487000ef          	jal	ra,1cb2 <fork>
    assert(cpid != -1);
    1030:	57fd                	li	a5,-1
    1032:	04f50363          	beq	a0,a5,1078 <test_fork+0x74>

    if(cpid > 0){
    1036:	04a05763          	blez	a0,1084 <test_fork+0x80>
	wait(&wstatus);
    103a:	0068                	addi	a0,sp,12
    103c:	55d000ef          	jal	ra,1d98 <wait>
	printf("  parent process. wstatus:%d\n", wstatus);
    1040:	45b2                	lw	a1,12(sp)
    1042:	00001517          	auipc	a0,0x1
    1046:	eee50513          	addi	a0,a0,-274 # 1f30 <__clone+0x74>
    104a:	2b8000ef          	jal	ra,1302 <printf>
    }else{
	printf("  child process.\n");
	exit(0);
    }
    TEST_END(__func__);
    104e:	00001517          	auipc	a0,0x1
    1052:	f1a50513          	addi	a0,a0,-230 # 1f68 <__clone+0xac>
    1056:	28a000ef          	jal	ra,12e0 <puts>
    105a:	00001517          	auipc	a0,0x1
    105e:	f3e50513          	addi	a0,a0,-194 # 1f98 <__func__.1193>
    1062:	27e000ef          	jal	ra,12e0 <puts>
    1066:	00001517          	auipc	a0,0x1
    106a:	e9a50513          	addi	a0,a0,-358 # 1f00 <__clone+0x44>
    106e:	272000ef          	jal	ra,12e0 <puts>
}
    1072:	60e2                	ld	ra,24(sp)
    1074:	6105                	addi	sp,sp,32
    1076:	8082                	ret
    assert(cpid != -1);
    1078:	00001517          	auipc	a0,0x1
    107c:	e9850513          	addi	a0,a0,-360 # 1f10 <__clone+0x54>
    1080:	542000ef          	jal	ra,15c2 <panic>
	printf("  child process.\n");
    1084:	00001517          	auipc	a0,0x1
    1088:	ecc50513          	addi	a0,a0,-308 # 1f50 <__clone+0x94>
    108c:	276000ef          	jal	ra,1302 <printf>
	exit(0);
    1090:	4501                	li	a0,0
    1092:	443000ef          	jal	ra,1cd4 <exit>
    1096:	bf65                	j	104e <test_fork+0x4a>

0000000000001098 <main>:

int main(void){
    1098:	1141                	addi	sp,sp,-16
    109a:	e406                	sd	ra,8(sp)
    test_fork();
    109c:	f69ff0ef          	jal	ra,1004 <test_fork>
    return 0;
}
    10a0:	60a2                	ld	ra,8(sp)
    10a2:	4501                	li	a0,0
    10a4:	0141                	addi	sp,sp,16
    10a6:	8082                	ret

00000000000010a8 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10a8:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10aa:	4108                	lw	a0,0(a0)
{
    10ac:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10ae:	05a1                	addi	a1,a1,8
{
    10b0:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10b2:	fe7ff0ef          	jal	ra,1098 <main>
    10b6:	41f000ef          	jal	ra,1cd4 <exit>
	return 0;
}
    10ba:	60a2                	ld	ra,8(sp)
    10bc:	4501                	li	a0,0
    10be:	0141                	addi	sp,sp,16
    10c0:	8082                	ret

00000000000010c2 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10c2:	7179                	addi	sp,sp,-48
    10c4:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10c6:	12054b63          	bltz	a0,11fc <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ca:	02b577bb          	remuw	a5,a0,a1
    10ce:	00001697          	auipc	a3,0x1
    10d2:	eda68693          	addi	a3,a3,-294 # 1fa8 <digits>
    buf[16] = 0;
    10d6:	00010c23          	sb	zero,24(sp)
    i = 15;
    10da:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10de:	1782                	slli	a5,a5,0x20
    10e0:	9381                	srli	a5,a5,0x20
    10e2:	97b6                	add	a5,a5,a3
    10e4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10e8:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10ec:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f0:	16b56263          	bltu	a0,a1,1254 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10f4:	02e8763b          	remuw	a2,a6,a4
    10f8:	1602                	slli	a2,a2,0x20
    10fa:	9201                	srli	a2,a2,0x20
    10fc:	9636                	add	a2,a2,a3
    10fe:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1102:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1106:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    110a:	12e86963          	bltu	a6,a4,123c <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    110e:	02e5f63b          	remuw	a2,a1,a4
    1112:	1602                	slli	a2,a2,0x20
    1114:	9201                	srli	a2,a2,0x20
    1116:	9636                	add	a2,a2,a3
    1118:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    111c:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1120:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1124:	10e5ef63          	bltu	a1,a4,1242 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    1128:	02e8763b          	remuw	a2,a6,a4
    112c:	1602                	slli	a2,a2,0x20
    112e:	9201                	srli	a2,a2,0x20
    1130:	9636                	add	a2,a2,a3
    1132:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1136:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    113a:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    113e:	10e86563          	bltu	a6,a4,1248 <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1142:	02e5f63b          	remuw	a2,a1,a4
    1146:	1602                	slli	a2,a2,0x20
    1148:	9201                	srli	a2,a2,0x20
    114a:	9636                	add	a2,a2,a3
    114c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1150:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1154:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    1158:	0ee5eb63          	bltu	a1,a4,124e <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    115c:	02e8763b          	remuw	a2,a6,a4
    1160:	1602                	slli	a2,a2,0x20
    1162:	9201                	srli	a2,a2,0x20
    1164:	9636                	add	a2,a2,a3
    1166:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    116a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    116e:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1172:	0ce86263          	bltu	a6,a4,1236 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1176:	02e5f63b          	remuw	a2,a1,a4
    117a:	1602                	slli	a2,a2,0x20
    117c:	9201                	srli	a2,a2,0x20
    117e:	9636                	add	a2,a2,a3
    1180:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1184:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1188:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    118c:	0ce5e663          	bltu	a1,a4,1258 <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    1190:	02e8763b          	remuw	a2,a6,a4
    1194:	1602                	slli	a2,a2,0x20
    1196:	9201                	srli	a2,a2,0x20
    1198:	9636                	add	a2,a2,a3
    119a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    119e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a2:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11a6:	0ae86c63          	bltu	a6,a4,125e <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11aa:	02e5f63b          	remuw	a2,a1,a4
    11ae:	1602                	slli	a2,a2,0x20
    11b0:	9201                	srli	a2,a2,0x20
    11b2:	9636                	add	a2,a2,a3
    11b4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11b8:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11bc:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11c0:	0ae5e263          	bltu	a1,a4,1264 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11c4:	1782                	slli	a5,a5,0x20
    11c6:	9381                	srli	a5,a5,0x20
    11c8:	97b6                	add	a5,a5,a3
    11ca:	0007c703          	lbu	a4,0(a5)
    11ce:	4599                	li	a1,6
    11d0:	4795                	li	a5,5
    11d2:	00e10723          	sb	a4,14(sp)

    if (sign)
    11d6:	00055963          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11da:	1018                	addi	a4,sp,32
    11dc:	973e                	add	a4,a4,a5
    11de:	02d00693          	li	a3,45
    11e2:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11e6:	85be                	mv	a1,a5
    write(f, s, l);
    11e8:	003c                	addi	a5,sp,8
    11ea:	4641                	li	a2,16
    11ec:	9e0d                	subw	a2,a2,a1
    11ee:	4505                	li	a0,1
    11f0:	95be                	add	a1,a1,a5
    11f2:	293000ef          	jal	ra,1c84 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11f6:	70a2                	ld	ra,40(sp)
    11f8:	6145                	addi	sp,sp,48
    11fa:	8082                	ret
        x = -xx;
    11fc:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1200:	02b677bb          	remuw	a5,a2,a1
    1204:	00001697          	auipc	a3,0x1
    1208:	da468693          	addi	a3,a3,-604 # 1fa8 <digits>
    buf[16] = 0;
    120c:	00010c23          	sb	zero,24(sp)
    i = 15;
    1210:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1214:	1782                	slli	a5,a5,0x20
    1216:	9381                	srli	a5,a5,0x20
    1218:	97b6                	add	a5,a5,a3
    121a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    121e:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1222:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1226:	ecb677e3          	bgeu	a2,a1,10f4 <printint.constprop.0+0x32>
        buf[i--] = '-';
    122a:	02d00793          	li	a5,45
    122e:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1232:	45b9                	li	a1,14
    1234:	bf55                	j	11e8 <printint.constprop.0+0x126>
    1236:	47a5                	li	a5,9
    1238:	45a9                	li	a1,10
    123a:	bf71                	j	11d6 <printint.constprop.0+0x114>
    123c:	47b5                	li	a5,13
    123e:	45b9                	li	a1,14
    1240:	bf59                	j	11d6 <printint.constprop.0+0x114>
    1242:	47b1                	li	a5,12
    1244:	45b5                	li	a1,13
    1246:	bf41                	j	11d6 <printint.constprop.0+0x114>
    1248:	47ad                	li	a5,11
    124a:	45b1                	li	a1,12
    124c:	b769                	j	11d6 <printint.constprop.0+0x114>
    124e:	47a9                	li	a5,10
    1250:	45ad                	li	a1,11
    1252:	b751                	j	11d6 <printint.constprop.0+0x114>
    i = 15;
    1254:	45bd                	li	a1,15
    1256:	bf49                	j	11e8 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1258:	47a1                	li	a5,8
    125a:	45a5                	li	a1,9
    125c:	bfad                	j	11d6 <printint.constprop.0+0x114>
    125e:	479d                	li	a5,7
    1260:	45a1                	li	a1,8
    1262:	bf95                	j	11d6 <printint.constprop.0+0x114>
    1264:	4799                	li	a5,6
    1266:	459d                	li	a1,7
    1268:	b7bd                	j	11d6 <printint.constprop.0+0x114>

000000000000126a <getchar>:
{
    126a:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    126c:	00f10593          	addi	a1,sp,15
    1270:	4605                	li	a2,1
    1272:	4501                	li	a0,0
{
    1274:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1276:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    127a:	201000ef          	jal	ra,1c7a <read>
}
    127e:	60e2                	ld	ra,24(sp)
    1280:	00f14503          	lbu	a0,15(sp)
    1284:	6105                	addi	sp,sp,32
    1286:	8082                	ret

0000000000001288 <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1288:	00001797          	auipc	a5,0x1
    128c:	d3878793          	addi	a5,a5,-712 # 1fc0 <digits+0x18>
    1290:	04000893          	li	a7,64
    1294:	4505                	li	a0,1
    1296:	85be                	mv	a1,a5
    1298:	4611                	li	a2,4
    129a:	00000073          	ecall
}
    129e:	4501                	li	a0,0
    12a0:	8082                	ret

00000000000012a2 <putchar>:
{
    12a2:	1101                	addi	sp,sp,-32
    12a4:	ec06                	sd	ra,24(sp)
    12a6:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12a8:	3e700893          	li	a7,999
    12ac:	4505                	li	a0,1
    12ae:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12b2:	00001717          	auipc	a4,0x1
    12b6:	d0e70713          	addi	a4,a4,-754 # 1fc0 <digits+0x18>
    12ba:	04000893          	li	a7,64
    12be:	4505                	li	a0,1
    12c0:	85ba                	mv	a1,a4
    12c2:	4611                	li	a2,4
    12c4:	00000073          	ecall
    return write(stdout, &byte, 1);
    12c8:	4605                	li	a2,1
    12ca:	00f10593          	addi	a1,sp,15
    12ce:	4505                	li	a0,1
    char byte = c;
    12d0:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12d4:	1b1000ef          	jal	ra,1c84 <write>
}
    12d8:	60e2                	ld	ra,24(sp)
    12da:	2501                	sext.w	a0,a0
    12dc:	6105                	addi	sp,sp,32
    12de:	8082                	ret

00000000000012e0 <puts>:
{
    12e0:	1141                	addi	sp,sp,-16
    12e2:	e406                	sd	ra,8(sp)
    12e4:	e022                	sd	s0,0(sp)
    12e6:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12e8:	5b8000ef          	jal	ra,18a0 <strlen>
    12ec:	862a                	mv	a2,a0
    12ee:	85a2                	mv	a1,s0
    12f0:	4505                	li	a0,1
    12f2:	193000ef          	jal	ra,1c84 <write>
}
    12f6:	60a2                	ld	ra,8(sp)
    12f8:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12fa:	957d                	srai	a0,a0,0x3f
    return r;
    12fc:	2501                	sext.w	a0,a0
}
    12fe:	0141                	addi	sp,sp,16
    1300:	8082                	ret

0000000000001302 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1302:	7171                	addi	sp,sp,-176
    1304:	e0d2                	sd	s4,64(sp)
    1306:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    1308:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    130a:	18bc                	addi	a5,sp,120
{
    130c:	e8ca                	sd	s2,80(sp)
    130e:	e4ce                	sd	s3,72(sp)
    1310:	fc56                	sd	s5,56(sp)
    1312:	f85a                	sd	s6,48(sp)
    1314:	f486                	sd	ra,104(sp)
    1316:	f0a2                	sd	s0,96(sp)
    1318:	eca6                	sd	s1,88(sp)
    131a:	fcae                	sd	a1,120(sp)
    131c:	e132                	sd	a2,128(sp)
    131e:	e536                	sd	a3,136(sp)
    1320:	e93a                	sd	a4,144(sp)
    1322:	f142                	sd	a6,160(sp)
    1324:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1326:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1328:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    132c:	00001b17          	auipc	s6,0x1
    1330:	c4cb0b13          	addi	s6,s6,-948 # 1f78 <__clone+0xbc>
	::"r"((unsigned long long)ac)
    1334:	00001a97          	auipc	s5,0x1
    1338:	c8ca8a93          	addi	s5,s5,-884 # 1fc0 <digits+0x18>
    buf[i++] = '0';
    133c:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1340:	00001997          	auipc	s3,0x1
    1344:	c6898993          	addi	s3,s3,-920 # 1fa8 <digits>
        if (!*s)
    1348:	00054783          	lbu	a5,0(a0)
    134c:	16078c63          	beqz	a5,14c4 <printf+0x1c2>
    1350:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1352:	19278363          	beq	a5,s2,14d8 <printf+0x1d6>
    1356:	00164783          	lbu	a5,1(a2)
    135a:	0605                	addi	a2,a2,1
    135c:	fbfd                	bnez	a5,1352 <printf+0x50>
    135e:	84b2                	mv	s1,a2
        l = z - a;
    1360:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1364:	85aa                	mv	a1,a0
    1366:	8622                	mv	a2,s0
    1368:	4505                	li	a0,1
    136a:	11b000ef          	jal	ra,1c84 <write>
        if (l)
    136e:	18041e63          	bnez	s0,150a <printf+0x208>
        if (s[1] == 0)
    1372:	0014c783          	lbu	a5,1(s1)
    1376:	14078763          	beqz	a5,14c4 <printf+0x1c2>
        switch (s[1])
    137a:	07300713          	li	a4,115
    137e:	1ce78063          	beq	a5,a4,153e <printf+0x23c>
    1382:	18f76663          	bltu	a4,a5,150e <printf+0x20c>
    1386:	06400713          	li	a4,100
    138a:	1ae78063          	beq	a5,a4,152a <printf+0x228>
    138e:	07000713          	li	a4,112
    1392:	1ce79963          	bne	a5,a4,1564 <printf+0x262>
            printptr(va_arg(ap, uint64));
    1396:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1398:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    139c:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    139e:	631c                	ld	a5,0(a4)
    13a0:	0721                	addi	a4,a4,8
    13a2:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13a4:	00479293          	slli	t0,a5,0x4
    13a8:	00879f93          	slli	t6,a5,0x8
    13ac:	00c79f13          	slli	t5,a5,0xc
    13b0:	01079e93          	slli	t4,a5,0x10
    13b4:	01479e13          	slli	t3,a5,0x14
    13b8:	01879313          	slli	t1,a5,0x18
    13bc:	01c79893          	slli	a7,a5,0x1c
    13c0:	02479813          	slli	a6,a5,0x24
    13c4:	02879513          	slli	a0,a5,0x28
    13c8:	02c79593          	slli	a1,a5,0x2c
    13cc:	03079693          	slli	a3,a5,0x30
    13d0:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13d4:	03c7d413          	srli	s0,a5,0x3c
    13d8:	01c7d39b          	srliw	t2,a5,0x1c
    13dc:	03c2d293          	srli	t0,t0,0x3c
    13e0:	03cfdf93          	srli	t6,t6,0x3c
    13e4:	03cf5f13          	srli	t5,t5,0x3c
    13e8:	03cede93          	srli	t4,t4,0x3c
    13ec:	03ce5e13          	srli	t3,t3,0x3c
    13f0:	03c35313          	srli	t1,t1,0x3c
    13f4:	03c8d893          	srli	a7,a7,0x3c
    13f8:	03c85813          	srli	a6,a6,0x3c
    13fc:	9171                	srli	a0,a0,0x3c
    13fe:	91f1                	srli	a1,a1,0x3c
    1400:	92f1                	srli	a3,a3,0x3c
    1402:	9371                	srli	a4,a4,0x3c
    1404:	96ce                	add	a3,a3,s3
    1406:	974e                	add	a4,a4,s3
    1408:	944e                	add	s0,s0,s3
    140a:	92ce                	add	t0,t0,s3
    140c:	9fce                	add	t6,t6,s3
    140e:	9f4e                	add	t5,t5,s3
    1410:	9ece                	add	t4,t4,s3
    1412:	9e4e                	add	t3,t3,s3
    1414:	934e                	add	t1,t1,s3
    1416:	98ce                	add	a7,a7,s3
    1418:	93ce                	add	t2,t2,s3
    141a:	984e                	add	a6,a6,s3
    141c:	954e                	add	a0,a0,s3
    141e:	95ce                	add	a1,a1,s3
    1420:	0006c083          	lbu	ra,0(a3)
    1424:	0002c283          	lbu	t0,0(t0)
    1428:	00074683          	lbu	a3,0(a4)
    142c:	000fcf83          	lbu	t6,0(t6)
    1430:	000f4f03          	lbu	t5,0(t5)
    1434:	000ece83          	lbu	t4,0(t4)
    1438:	000e4e03          	lbu	t3,0(t3)
    143c:	00034303          	lbu	t1,0(t1)
    1440:	0008c883          	lbu	a7,0(a7)
    1444:	0003c383          	lbu	t2,0(t2)
    1448:	00084803          	lbu	a6,0(a6)
    144c:	00054503          	lbu	a0,0(a0)
    1450:	0005c583          	lbu	a1,0(a1)
    1454:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1458:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    145c:	9371                	srli	a4,a4,0x3c
    145e:	8bbd                	andi	a5,a5,15
    1460:	974e                	add	a4,a4,s3
    1462:	97ce                	add	a5,a5,s3
    1464:	005105a3          	sb	t0,11(sp)
    1468:	01f10623          	sb	t6,12(sp)
    146c:	01e106a3          	sb	t5,13(sp)
    1470:	01d10723          	sb	t4,14(sp)
    1474:	01c107a3          	sb	t3,15(sp)
    1478:	00610823          	sb	t1,16(sp)
    147c:	011108a3          	sb	a7,17(sp)
    1480:	00710923          	sb	t2,18(sp)
    1484:	010109a3          	sb	a6,19(sp)
    1488:	00a10a23          	sb	a0,20(sp)
    148c:	00b10aa3          	sb	a1,21(sp)
    1490:	00110b23          	sb	ra,22(sp)
    1494:	00d10ba3          	sb	a3,23(sp)
    1498:	00810523          	sb	s0,10(sp)
    149c:	00074703          	lbu	a4,0(a4)
    14a0:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14a4:	002c                	addi	a1,sp,8
    14a6:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14a8:	00e10c23          	sb	a4,24(sp)
    14ac:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14b0:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14b4:	7d0000ef          	jal	ra,1c84 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14b8:	00248513          	addi	a0,s1,2
        if (!*s)
    14bc:	00054783          	lbu	a5,0(a0)
    14c0:	e80798e3          	bnez	a5,1350 <printf+0x4e>
    }
    va_end(ap);
}
    14c4:	70a6                	ld	ra,104(sp)
    14c6:	7406                	ld	s0,96(sp)
    14c8:	64e6                	ld	s1,88(sp)
    14ca:	6946                	ld	s2,80(sp)
    14cc:	69a6                	ld	s3,72(sp)
    14ce:	6a06                	ld	s4,64(sp)
    14d0:	7ae2                	ld	s5,56(sp)
    14d2:	7b42                	ld	s6,48(sp)
    14d4:	614d                	addi	sp,sp,176
    14d6:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14d8:	00064783          	lbu	a5,0(a2)
    14dc:	84b2                	mv	s1,a2
    14de:	01278963          	beq	a5,s2,14f0 <printf+0x1ee>
    14e2:	bdbd                	j	1360 <printf+0x5e>
    14e4:	0024c783          	lbu	a5,2(s1)
    14e8:	0605                	addi	a2,a2,1
    14ea:	0489                	addi	s1,s1,2
    14ec:	e7279ae3          	bne	a5,s2,1360 <printf+0x5e>
    14f0:	0014c783          	lbu	a5,1(s1)
    14f4:	ff2788e3          	beq	a5,s2,14e4 <printf+0x1e2>
        l = z - a;
    14f8:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14fc:	85aa                	mv	a1,a0
    14fe:	8622                	mv	a2,s0
    1500:	4505                	li	a0,1
    1502:	782000ef          	jal	ra,1c84 <write>
        if (l)
    1506:	e60406e3          	beqz	s0,1372 <printf+0x70>
    150a:	8526                	mv	a0,s1
    150c:	bd35                	j	1348 <printf+0x46>
        switch (s[1])
    150e:	07800713          	li	a4,120
    1512:	04e79963          	bne	a5,a4,1564 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1516:	6782                	ld	a5,0(sp)
    1518:	45c1                	li	a1,16
    151a:	4388                	lw	a0,0(a5)
    151c:	07a1                	addi	a5,a5,8
    151e:	e03e                	sd	a5,0(sp)
    1520:	ba3ff0ef          	jal	ra,10c2 <printint.constprop.0>
        s += 2;
    1524:	00248513          	addi	a0,s1,2
    1528:	bf51                	j	14bc <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    152a:	6782                	ld	a5,0(sp)
    152c:	45a9                	li	a1,10
    152e:	4388                	lw	a0,0(a5)
    1530:	07a1                	addi	a5,a5,8
    1532:	e03e                	sd	a5,0(sp)
    1534:	b8fff0ef          	jal	ra,10c2 <printint.constprop.0>
        s += 2;
    1538:	00248513          	addi	a0,s1,2
    153c:	b741                	j	14bc <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    153e:	6782                	ld	a5,0(sp)
    1540:	6380                	ld	s0,0(a5)
    1542:	07a1                	addi	a5,a5,8
    1544:	e03e                	sd	a5,0(sp)
    1546:	cc25                	beqz	s0,15be <printf+0x2bc>
            l = strnlen(a, 200);
    1548:	0c800593          	li	a1,200
    154c:	8522                	mv	a0,s0
    154e:	43e000ef          	jal	ra,198c <strnlen>
    write(f, s, l);
    1552:	0005061b          	sext.w	a2,a0
    1556:	85a2                	mv	a1,s0
    1558:	4505                	li	a0,1
    155a:	72a000ef          	jal	ra,1c84 <write>
        s += 2;
    155e:	00248513          	addi	a0,s1,2
    1562:	bfa9                	j	14bc <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1564:	3e700893          	li	a7,999
    1568:	4505                	li	a0,1
    156a:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    156e:	04000893          	li	a7,64
    1572:	4505                	li	a0,1
    1574:	85d6                	mv	a1,s5
    1576:	4611                	li	a2,4
    1578:	00000073          	ecall
    char byte = c;
    157c:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1580:	4605                	li	a2,1
    1582:	002c                	addi	a1,sp,8
    1584:	4505                	li	a0,1
    char byte = c;
    1586:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    158a:	6fa000ef          	jal	ra,1c84 <write>
            putchar(s[1]);
    158e:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1592:	3e700893          	li	a7,999
    1596:	4505                	li	a0,1
    1598:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    159c:	04000893          	li	a7,64
    15a0:	4505                	li	a0,1
    15a2:	85d6                	mv	a1,s5
    15a4:	4611                	li	a2,4
    15a6:	00000073          	ecall
    return write(stdout, &byte, 1);
    15aa:	4605                	li	a2,1
    15ac:	002c                	addi	a1,sp,8
    15ae:	4505                	li	a0,1
    char byte = c;
    15b0:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15b4:	6d0000ef          	jal	ra,1c84 <write>
        s += 2;
    15b8:	00248513          	addi	a0,s1,2
    15bc:	b701                	j	14bc <printf+0x1ba>
                a = "(null)";
    15be:	845a                	mv	s0,s6
    15c0:	b761                	j	1548 <printf+0x246>

00000000000015c2 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15c2:	1141                	addi	sp,sp,-16
    15c4:	e406                	sd	ra,8(sp)
    puts(m);
    15c6:	d1bff0ef          	jal	ra,12e0 <puts>
    exit(-100);
}
    15ca:	60a2                	ld	ra,8(sp)
    exit(-100);
    15cc:	f9c00513          	li	a0,-100
}
    15d0:	0141                	addi	sp,sp,16
    exit(-100);
    15d2:	a709                	j	1cd4 <exit>

00000000000015d4 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d4:	02000793          	li	a5,32
    15d8:	00f50663          	beq	a0,a5,15e4 <isspace+0x10>
    15dc:	355d                	addiw	a0,a0,-9
    15de:	00553513          	sltiu	a0,a0,5
    15e2:	8082                	ret
    15e4:	4505                	li	a0,1
}
    15e6:	8082                	ret

00000000000015e8 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15e8:	fd05051b          	addiw	a0,a0,-48
}
    15ec:	00a53513          	sltiu	a0,a0,10
    15f0:	8082                	ret

00000000000015f2 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f2:	02000613          	li	a2,32
    15f6:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15f8:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fc:	ff77069b          	addiw	a3,a4,-9
    1600:	04c70d63          	beq	a4,a2,165a <atoi+0x68>
    1604:	0007079b          	sext.w	a5,a4
    1608:	04d5f963          	bgeu	a1,a3,165a <atoi+0x68>
        s++;
    switch (*s)
    160c:	02b00693          	li	a3,43
    1610:	04d70a63          	beq	a4,a3,1664 <atoi+0x72>
    1614:	02d00693          	li	a3,45
    1618:	06d70463          	beq	a4,a3,1680 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    161c:	fd07859b          	addiw	a1,a5,-48
    1620:	4625                	li	a2,9
    1622:	873e                	mv	a4,a5
    1624:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1626:	4e01                	li	t3,0
    while (isdigit(*s))
    1628:	04b66a63          	bltu	a2,a1,167c <atoi+0x8a>
    int n = 0, neg = 0;
    162c:	4501                	li	a0,0
    while (isdigit(*s))
    162e:	4825                	li	a6,9
    1630:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1634:	0025179b          	slliw	a5,a0,0x2
    1638:	9d3d                	addw	a0,a0,a5
    163a:	fd07031b          	addiw	t1,a4,-48
    163e:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1642:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1646:	0685                	addi	a3,a3,1
    1648:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    164c:	0006071b          	sext.w	a4,a2
    1650:	feb870e3          	bgeu	a6,a1,1630 <atoi+0x3e>
    return neg ? n : -n;
    1654:	000e0563          	beqz	t3,165e <atoi+0x6c>
}
    1658:	8082                	ret
        s++;
    165a:	0505                	addi	a0,a0,1
    165c:	bf71                	j	15f8 <atoi+0x6>
    165e:	4113053b          	subw	a0,t1,a7
    1662:	8082                	ret
    while (isdigit(*s))
    1664:	00154783          	lbu	a5,1(a0)
    1668:	4625                	li	a2,9
        s++;
    166a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    166e:	fd07859b          	addiw	a1,a5,-48
    1672:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1676:	4e01                	li	t3,0
    while (isdigit(*s))
    1678:	fab67ae3          	bgeu	a2,a1,162c <atoi+0x3a>
    167c:	4501                	li	a0,0
}
    167e:	8082                	ret
    while (isdigit(*s))
    1680:	00154783          	lbu	a5,1(a0)
    1684:	4625                	li	a2,9
        s++;
    1686:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    168a:	fd07859b          	addiw	a1,a5,-48
    168e:	0007871b          	sext.w	a4,a5
    1692:	feb665e3          	bltu	a2,a1,167c <atoi+0x8a>
        neg = 1;
    1696:	4e05                	li	t3,1
    1698:	bf51                	j	162c <atoi+0x3a>

000000000000169a <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    169a:	16060d63          	beqz	a2,1814 <memset+0x17a>
    169e:	40a007b3          	neg	a5,a0
    16a2:	8b9d                	andi	a5,a5,7
    16a4:	00778713          	addi	a4,a5,7
    16a8:	482d                	li	a6,11
    16aa:	0ff5f593          	zext.b	a1,a1
    16ae:	fff60693          	addi	a3,a2,-1
    16b2:	17076263          	bltu	a4,a6,1816 <memset+0x17c>
    16b6:	16e6ea63          	bltu	a3,a4,182a <memset+0x190>
    16ba:	16078563          	beqz	a5,1824 <memset+0x18a>
    16be:	00b50023          	sb	a1,0(a0)
    16c2:	4705                	li	a4,1
    16c4:	00150e93          	addi	t4,a0,1
    16c8:	14e78c63          	beq	a5,a4,1820 <memset+0x186>
    16cc:	00b500a3          	sb	a1,1(a0)
    16d0:	4709                	li	a4,2
    16d2:	00250e93          	addi	t4,a0,2
    16d6:	14e78d63          	beq	a5,a4,1830 <memset+0x196>
    16da:	00b50123          	sb	a1,2(a0)
    16de:	470d                	li	a4,3
    16e0:	00350e93          	addi	t4,a0,3
    16e4:	12e78b63          	beq	a5,a4,181a <memset+0x180>
    16e8:	00b501a3          	sb	a1,3(a0)
    16ec:	4711                	li	a4,4
    16ee:	00450e93          	addi	t4,a0,4
    16f2:	14e78163          	beq	a5,a4,1834 <memset+0x19a>
    16f6:	00b50223          	sb	a1,4(a0)
    16fa:	4715                	li	a4,5
    16fc:	00550e93          	addi	t4,a0,5
    1700:	12e78c63          	beq	a5,a4,1838 <memset+0x19e>
    1704:	00b502a3          	sb	a1,5(a0)
    1708:	471d                	li	a4,7
    170a:	00650e93          	addi	t4,a0,6
    170e:	12e79763          	bne	a5,a4,183c <memset+0x1a2>
    1712:	00750e93          	addi	t4,a0,7
    1716:	00b50323          	sb	a1,6(a0)
    171a:	4f1d                	li	t5,7
    171c:	00859713          	slli	a4,a1,0x8
    1720:	8f4d                	or	a4,a4,a1
    1722:	01059e13          	slli	t3,a1,0x10
    1726:	01c76e33          	or	t3,a4,t3
    172a:	01859313          	slli	t1,a1,0x18
    172e:	006e6333          	or	t1,t3,t1
    1732:	02059893          	slli	a7,a1,0x20
    1736:	011368b3          	or	a7,t1,a7
    173a:	02859813          	slli	a6,a1,0x28
    173e:	40f60333          	sub	t1,a2,a5
    1742:	0108e833          	or	a6,a7,a6
    1746:	03059693          	slli	a3,a1,0x30
    174a:	00d866b3          	or	a3,a6,a3
    174e:	03859713          	slli	a4,a1,0x38
    1752:	97aa                	add	a5,a5,a0
    1754:	ff837813          	andi	a6,t1,-8
    1758:	8f55                	or	a4,a4,a3
    175a:	00f806b3          	add	a3,a6,a5
    175e:	e398                	sd	a4,0(a5)
    1760:	07a1                	addi	a5,a5,8
    1762:	fed79ee3          	bne	a5,a3,175e <memset+0xc4>
    1766:	ff837693          	andi	a3,t1,-8
    176a:	00de87b3          	add	a5,t4,a3
    176e:	01e6873b          	addw	a4,a3,t5
    1772:	0ad30663          	beq	t1,a3,181e <memset+0x184>
    1776:	00b78023          	sb	a1,0(a5)
    177a:	0017069b          	addiw	a3,a4,1
    177e:	08c6fb63          	bgeu	a3,a2,1814 <memset+0x17a>
    1782:	00b780a3          	sb	a1,1(a5)
    1786:	0027069b          	addiw	a3,a4,2
    178a:	08c6f563          	bgeu	a3,a2,1814 <memset+0x17a>
    178e:	00b78123          	sb	a1,2(a5)
    1792:	0037069b          	addiw	a3,a4,3
    1796:	06c6ff63          	bgeu	a3,a2,1814 <memset+0x17a>
    179a:	00b781a3          	sb	a1,3(a5)
    179e:	0047069b          	addiw	a3,a4,4
    17a2:	06c6f963          	bgeu	a3,a2,1814 <memset+0x17a>
    17a6:	00b78223          	sb	a1,4(a5)
    17aa:	0057069b          	addiw	a3,a4,5
    17ae:	06c6f363          	bgeu	a3,a2,1814 <memset+0x17a>
    17b2:	00b782a3          	sb	a1,5(a5)
    17b6:	0067069b          	addiw	a3,a4,6
    17ba:	04c6fd63          	bgeu	a3,a2,1814 <memset+0x17a>
    17be:	00b78323          	sb	a1,6(a5)
    17c2:	0077069b          	addiw	a3,a4,7
    17c6:	04c6f763          	bgeu	a3,a2,1814 <memset+0x17a>
    17ca:	00b783a3          	sb	a1,7(a5)
    17ce:	0087069b          	addiw	a3,a4,8
    17d2:	04c6f163          	bgeu	a3,a2,1814 <memset+0x17a>
    17d6:	00b78423          	sb	a1,8(a5)
    17da:	0097069b          	addiw	a3,a4,9
    17de:	02c6fb63          	bgeu	a3,a2,1814 <memset+0x17a>
    17e2:	00b784a3          	sb	a1,9(a5)
    17e6:	00a7069b          	addiw	a3,a4,10
    17ea:	02c6f563          	bgeu	a3,a2,1814 <memset+0x17a>
    17ee:	00b78523          	sb	a1,10(a5)
    17f2:	00b7069b          	addiw	a3,a4,11
    17f6:	00c6ff63          	bgeu	a3,a2,1814 <memset+0x17a>
    17fa:	00b785a3          	sb	a1,11(a5)
    17fe:	00c7069b          	addiw	a3,a4,12
    1802:	00c6f963          	bgeu	a3,a2,1814 <memset+0x17a>
    1806:	00b78623          	sb	a1,12(a5)
    180a:	2735                	addiw	a4,a4,13
    180c:	00c77463          	bgeu	a4,a2,1814 <memset+0x17a>
    1810:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1814:	8082                	ret
    1816:	472d                	li	a4,11
    1818:	bd79                	j	16b6 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    181a:	4f0d                	li	t5,3
    181c:	b701                	j	171c <memset+0x82>
    181e:	8082                	ret
    1820:	4f05                	li	t5,1
    1822:	bded                	j	171c <memset+0x82>
    1824:	8eaa                	mv	t4,a0
    1826:	4f01                	li	t5,0
    1828:	bdd5                	j	171c <memset+0x82>
    182a:	87aa                	mv	a5,a0
    182c:	4701                	li	a4,0
    182e:	b7a1                	j	1776 <memset+0xdc>
    1830:	4f09                	li	t5,2
    1832:	b5ed                	j	171c <memset+0x82>
    1834:	4f11                	li	t5,4
    1836:	b5dd                	j	171c <memset+0x82>
    1838:	4f15                	li	t5,5
    183a:	b5cd                	j	171c <memset+0x82>
    183c:	4f19                	li	t5,6
    183e:	bdf9                	j	171c <memset+0x82>

0000000000001840 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1840:	00054783          	lbu	a5,0(a0)
    1844:	0005c703          	lbu	a4,0(a1)
    1848:	00e79863          	bne	a5,a4,1858 <strcmp+0x18>
    184c:	0505                	addi	a0,a0,1
    184e:	0585                	addi	a1,a1,1
    1850:	fbe5                	bnez	a5,1840 <strcmp>
    1852:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1854:	9d19                	subw	a0,a0,a4
    1856:	8082                	ret
    1858:	0007851b          	sext.w	a0,a5
    185c:	bfe5                	j	1854 <strcmp+0x14>

000000000000185e <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    185e:	ce05                	beqz	a2,1896 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1860:	00054703          	lbu	a4,0(a0)
    1864:	0005c783          	lbu	a5,0(a1)
    1868:	cb0d                	beqz	a4,189a <strncmp+0x3c>
    if (!n--)
    186a:	167d                	addi	a2,a2,-1
    186c:	00c506b3          	add	a3,a0,a2
    1870:	a819                	j	1886 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1872:	00a68e63          	beq	a3,a0,188e <strncmp+0x30>
    1876:	0505                	addi	a0,a0,1
    1878:	00e79b63          	bne	a5,a4,188e <strncmp+0x30>
    187c:	00054703          	lbu	a4,0(a0)
    1880:	0005c783          	lbu	a5,0(a1)
    1884:	cb19                	beqz	a4,189a <strncmp+0x3c>
    1886:	0005c783          	lbu	a5,0(a1)
    188a:	0585                	addi	a1,a1,1
    188c:	f3fd                	bnez	a5,1872 <strncmp+0x14>
        ;
    return *l - *r;
    188e:	0007051b          	sext.w	a0,a4
    1892:	9d1d                	subw	a0,a0,a5
    1894:	8082                	ret
        return 0;
    1896:	4501                	li	a0,0
}
    1898:	8082                	ret
    189a:	4501                	li	a0,0
    return *l - *r;
    189c:	9d1d                	subw	a0,a0,a5
    189e:	8082                	ret

00000000000018a0 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18a0:	00757793          	andi	a5,a0,7
    18a4:	cf89                	beqz	a5,18be <strlen+0x1e>
    18a6:	87aa                	mv	a5,a0
    18a8:	a029                	j	18b2 <strlen+0x12>
    18aa:	0785                	addi	a5,a5,1
    18ac:	0077f713          	andi	a4,a5,7
    18b0:	cb01                	beqz	a4,18c0 <strlen+0x20>
        if (!*s)
    18b2:	0007c703          	lbu	a4,0(a5)
    18b6:	fb75                	bnez	a4,18aa <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18b8:	40a78533          	sub	a0,a5,a0
}
    18bc:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18be:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18c0:	6394                	ld	a3,0(a5)
    18c2:	00000597          	auipc	a1,0x0
    18c6:	6be5b583          	ld	a1,1726(a1) # 1f80 <__clone+0xc4>
    18ca:	00000617          	auipc	a2,0x0
    18ce:	6be63603          	ld	a2,1726(a2) # 1f88 <__clone+0xcc>
    18d2:	a019                	j	18d8 <strlen+0x38>
    18d4:	6794                	ld	a3,8(a5)
    18d6:	07a1                	addi	a5,a5,8
    18d8:	00b68733          	add	a4,a3,a1
    18dc:	fff6c693          	not	a3,a3
    18e0:	8f75                	and	a4,a4,a3
    18e2:	8f71                	and	a4,a4,a2
    18e4:	db65                	beqz	a4,18d4 <strlen+0x34>
    for (; *s; s++)
    18e6:	0007c703          	lbu	a4,0(a5)
    18ea:	d779                	beqz	a4,18b8 <strlen+0x18>
    18ec:	0017c703          	lbu	a4,1(a5)
    18f0:	0785                	addi	a5,a5,1
    18f2:	d379                	beqz	a4,18b8 <strlen+0x18>
    18f4:	0017c703          	lbu	a4,1(a5)
    18f8:	0785                	addi	a5,a5,1
    18fa:	fb6d                	bnez	a4,18ec <strlen+0x4c>
    18fc:	bf75                	j	18b8 <strlen+0x18>

00000000000018fe <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18fe:	00757713          	andi	a4,a0,7
{
    1902:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1904:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1908:	cb19                	beqz	a4,191e <memchr+0x20>
    190a:	ce25                	beqz	a2,1982 <memchr+0x84>
    190c:	0007c703          	lbu	a4,0(a5)
    1910:	04b70e63          	beq	a4,a1,196c <memchr+0x6e>
    1914:	0785                	addi	a5,a5,1
    1916:	0077f713          	andi	a4,a5,7
    191a:	167d                	addi	a2,a2,-1
    191c:	f77d                	bnez	a4,190a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    191e:	4501                	li	a0,0
    if (n && *s != c)
    1920:	c235                	beqz	a2,1984 <memchr+0x86>
    1922:	0007c703          	lbu	a4,0(a5)
    1926:	04b70363          	beq	a4,a1,196c <memchr+0x6e>
        size_t k = ONES * c;
    192a:	00000517          	auipc	a0,0x0
    192e:	66653503          	ld	a0,1638(a0) # 1f90 <__clone+0xd4>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1932:	471d                	li	a4,7
        size_t k = ONES * c;
    1934:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1938:	02c77a63          	bgeu	a4,a2,196c <memchr+0x6e>
    193c:	00000897          	auipc	a7,0x0
    1940:	6448b883          	ld	a7,1604(a7) # 1f80 <__clone+0xc4>
    1944:	00000817          	auipc	a6,0x0
    1948:	64483803          	ld	a6,1604(a6) # 1f88 <__clone+0xcc>
    194c:	431d                	li	t1,7
    194e:	a029                	j	1958 <memchr+0x5a>
    1950:	1661                	addi	a2,a2,-8
    1952:	07a1                	addi	a5,a5,8
    1954:	02c37963          	bgeu	t1,a2,1986 <memchr+0x88>
    1958:	6398                	ld	a4,0(a5)
    195a:	8f29                	xor	a4,a4,a0
    195c:	011706b3          	add	a3,a4,a7
    1960:	fff74713          	not	a4,a4
    1964:	8f75                	and	a4,a4,a3
    1966:	01077733          	and	a4,a4,a6
    196a:	d37d                	beqz	a4,1950 <memchr+0x52>
    196c:	853e                	mv	a0,a5
    196e:	97b2                	add	a5,a5,a2
    1970:	a021                	j	1978 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1972:	0505                	addi	a0,a0,1
    1974:	00f50763          	beq	a0,a5,1982 <memchr+0x84>
    1978:	00054703          	lbu	a4,0(a0)
    197c:	feb71be3          	bne	a4,a1,1972 <memchr+0x74>
    1980:	8082                	ret
    return n ? (void *)s : 0;
    1982:	4501                	li	a0,0
}
    1984:	8082                	ret
    return n ? (void *)s : 0;
    1986:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1988:	f275                	bnez	a2,196c <memchr+0x6e>
}
    198a:	8082                	ret

000000000000198c <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    198c:	1101                	addi	sp,sp,-32
    198e:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1990:	862e                	mv	a2,a1
{
    1992:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1994:	4581                	li	a1,0
{
    1996:	e426                	sd	s1,8(sp)
    1998:	ec06                	sd	ra,24(sp)
    199a:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    199c:	f63ff0ef          	jal	ra,18fe <memchr>
    return p ? p - s : n;
    19a0:	c519                	beqz	a0,19ae <strnlen+0x22>
}
    19a2:	60e2                	ld	ra,24(sp)
    19a4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19a6:	8d05                	sub	a0,a0,s1
}
    19a8:	64a2                	ld	s1,8(sp)
    19aa:	6105                	addi	sp,sp,32
    19ac:	8082                	ret
    19ae:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19b0:	8522                	mv	a0,s0
}
    19b2:	6442                	ld	s0,16(sp)
    19b4:	64a2                	ld	s1,8(sp)
    19b6:	6105                	addi	sp,sp,32
    19b8:	8082                	ret

00000000000019ba <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19ba:	00b547b3          	xor	a5,a0,a1
    19be:	8b9d                	andi	a5,a5,7
    19c0:	eb95                	bnez	a5,19f4 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19c2:	0075f793          	andi	a5,a1,7
    19c6:	e7b1                	bnez	a5,1a12 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19c8:	6198                	ld	a4,0(a1)
    19ca:	00000617          	auipc	a2,0x0
    19ce:	5b663603          	ld	a2,1462(a2) # 1f80 <__clone+0xc4>
    19d2:	00000817          	auipc	a6,0x0
    19d6:	5b683803          	ld	a6,1462(a6) # 1f88 <__clone+0xcc>
    19da:	a029                	j	19e4 <strcpy+0x2a>
    19dc:	e118                	sd	a4,0(a0)
    19de:	6598                	ld	a4,8(a1)
    19e0:	05a1                	addi	a1,a1,8
    19e2:	0521                	addi	a0,a0,8
    19e4:	00c707b3          	add	a5,a4,a2
    19e8:	fff74693          	not	a3,a4
    19ec:	8ff5                	and	a5,a5,a3
    19ee:	0107f7b3          	and	a5,a5,a6
    19f2:	d7ed                	beqz	a5,19dc <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19f4:	0005c783          	lbu	a5,0(a1)
    19f8:	00f50023          	sb	a5,0(a0)
    19fc:	c785                	beqz	a5,1a24 <strcpy+0x6a>
    19fe:	0015c783          	lbu	a5,1(a1)
    1a02:	0505                	addi	a0,a0,1
    1a04:	0585                	addi	a1,a1,1
    1a06:	00f50023          	sb	a5,0(a0)
    1a0a:	fbf5                	bnez	a5,19fe <strcpy+0x44>
        ;
    return d;
}
    1a0c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a0e:	0505                	addi	a0,a0,1
    1a10:	df45                	beqz	a4,19c8 <strcpy+0xe>
            if (!(*d = *s))
    1a12:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a16:	0585                	addi	a1,a1,1
    1a18:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a1c:	00f50023          	sb	a5,0(a0)
    1a20:	f7fd                	bnez	a5,1a0e <strcpy+0x54>
}
    1a22:	8082                	ret
    1a24:	8082                	ret

0000000000001a26 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a26:	00b547b3          	xor	a5,a0,a1
    1a2a:	8b9d                	andi	a5,a5,7
    1a2c:	1a079863          	bnez	a5,1bdc <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a30:	0075f793          	andi	a5,a1,7
    1a34:	16078463          	beqz	a5,1b9c <strncpy+0x176>
    1a38:	ea01                	bnez	a2,1a48 <strncpy+0x22>
    1a3a:	a421                	j	1c42 <strncpy+0x21c>
    1a3c:	167d                	addi	a2,a2,-1
    1a3e:	0505                	addi	a0,a0,1
    1a40:	14070e63          	beqz	a4,1b9c <strncpy+0x176>
    1a44:	1a060863          	beqz	a2,1bf4 <strncpy+0x1ce>
    1a48:	0005c783          	lbu	a5,0(a1)
    1a4c:	0585                	addi	a1,a1,1
    1a4e:	0075f713          	andi	a4,a1,7
    1a52:	00f50023          	sb	a5,0(a0)
    1a56:	f3fd                	bnez	a5,1a3c <strncpy+0x16>
    1a58:	4805                	li	a6,1
    1a5a:	1a061863          	bnez	a2,1c0a <strncpy+0x1e4>
    1a5e:	40a007b3          	neg	a5,a0
    1a62:	8b9d                	andi	a5,a5,7
    1a64:	4681                	li	a3,0
    1a66:	18061a63          	bnez	a2,1bfa <strncpy+0x1d4>
    1a6a:	00778713          	addi	a4,a5,7
    1a6e:	45ad                	li	a1,11
    1a70:	18b76363          	bltu	a4,a1,1bf6 <strncpy+0x1d0>
    1a74:	1ae6eb63          	bltu	a3,a4,1c2a <strncpy+0x204>
    1a78:	1a078363          	beqz	a5,1c1e <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a7c:	00050023          	sb	zero,0(a0)
    1a80:	4685                	li	a3,1
    1a82:	00150713          	addi	a4,a0,1
    1a86:	18d78f63          	beq	a5,a3,1c24 <strncpy+0x1fe>
    1a8a:	000500a3          	sb	zero,1(a0)
    1a8e:	4689                	li	a3,2
    1a90:	00250713          	addi	a4,a0,2
    1a94:	18d78e63          	beq	a5,a3,1c30 <strncpy+0x20a>
    1a98:	00050123          	sb	zero,2(a0)
    1a9c:	468d                	li	a3,3
    1a9e:	00350713          	addi	a4,a0,3
    1aa2:	16d78c63          	beq	a5,a3,1c1a <strncpy+0x1f4>
    1aa6:	000501a3          	sb	zero,3(a0)
    1aaa:	4691                	li	a3,4
    1aac:	00450713          	addi	a4,a0,4
    1ab0:	18d78263          	beq	a5,a3,1c34 <strncpy+0x20e>
    1ab4:	00050223          	sb	zero,4(a0)
    1ab8:	4695                	li	a3,5
    1aba:	00550713          	addi	a4,a0,5
    1abe:	16d78d63          	beq	a5,a3,1c38 <strncpy+0x212>
    1ac2:	000502a3          	sb	zero,5(a0)
    1ac6:	469d                	li	a3,7
    1ac8:	00650713          	addi	a4,a0,6
    1acc:	16d79863          	bne	a5,a3,1c3c <strncpy+0x216>
    1ad0:	00750713          	addi	a4,a0,7
    1ad4:	00050323          	sb	zero,6(a0)
    1ad8:	40f80833          	sub	a6,a6,a5
    1adc:	ff887593          	andi	a1,a6,-8
    1ae0:	97aa                	add	a5,a5,a0
    1ae2:	95be                	add	a1,a1,a5
    1ae4:	0007b023          	sd	zero,0(a5)
    1ae8:	07a1                	addi	a5,a5,8
    1aea:	feb79de3          	bne	a5,a1,1ae4 <strncpy+0xbe>
    1aee:	ff887593          	andi	a1,a6,-8
    1af2:	9ead                	addw	a3,a3,a1
    1af4:	00b707b3          	add	a5,a4,a1
    1af8:	12b80863          	beq	a6,a1,1c28 <strncpy+0x202>
    1afc:	00078023          	sb	zero,0(a5)
    1b00:	0016871b          	addiw	a4,a3,1
    1b04:	0ec77863          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b08:	000780a3          	sb	zero,1(a5)
    1b0c:	0026871b          	addiw	a4,a3,2
    1b10:	0ec77263          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b14:	00078123          	sb	zero,2(a5)
    1b18:	0036871b          	addiw	a4,a3,3
    1b1c:	0cc77c63          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b20:	000781a3          	sb	zero,3(a5)
    1b24:	0046871b          	addiw	a4,a3,4
    1b28:	0cc77663          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b2c:	00078223          	sb	zero,4(a5)
    1b30:	0056871b          	addiw	a4,a3,5
    1b34:	0cc77063          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b38:	000782a3          	sb	zero,5(a5)
    1b3c:	0066871b          	addiw	a4,a3,6
    1b40:	0ac77a63          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b44:	00078323          	sb	zero,6(a5)
    1b48:	0076871b          	addiw	a4,a3,7
    1b4c:	0ac77463          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b50:	000783a3          	sb	zero,7(a5)
    1b54:	0086871b          	addiw	a4,a3,8
    1b58:	08c77e63          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b5c:	00078423          	sb	zero,8(a5)
    1b60:	0096871b          	addiw	a4,a3,9
    1b64:	08c77863          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b68:	000784a3          	sb	zero,9(a5)
    1b6c:	00a6871b          	addiw	a4,a3,10
    1b70:	08c77263          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b74:	00078523          	sb	zero,10(a5)
    1b78:	00b6871b          	addiw	a4,a3,11
    1b7c:	06c77c63          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b80:	000785a3          	sb	zero,11(a5)
    1b84:	00c6871b          	addiw	a4,a3,12
    1b88:	06c77663          	bgeu	a4,a2,1bf4 <strncpy+0x1ce>
    1b8c:	00078623          	sb	zero,12(a5)
    1b90:	26b5                	addiw	a3,a3,13
    1b92:	06c6f163          	bgeu	a3,a2,1bf4 <strncpy+0x1ce>
    1b96:	000786a3          	sb	zero,13(a5)
    1b9a:	8082                	ret
            ;
        if (!n || !*s)
    1b9c:	c645                	beqz	a2,1c44 <strncpy+0x21e>
    1b9e:	0005c783          	lbu	a5,0(a1)
    1ba2:	ea078be3          	beqz	a5,1a58 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ba6:	479d                	li	a5,7
    1ba8:	02c7ff63          	bgeu	a5,a2,1be6 <strncpy+0x1c0>
    1bac:	00000897          	auipc	a7,0x0
    1bb0:	3d48b883          	ld	a7,980(a7) # 1f80 <__clone+0xc4>
    1bb4:	00000817          	auipc	a6,0x0
    1bb8:	3d483803          	ld	a6,980(a6) # 1f88 <__clone+0xcc>
    1bbc:	431d                	li	t1,7
    1bbe:	6198                	ld	a4,0(a1)
    1bc0:	011707b3          	add	a5,a4,a7
    1bc4:	fff74693          	not	a3,a4
    1bc8:	8ff5                	and	a5,a5,a3
    1bca:	0107f7b3          	and	a5,a5,a6
    1bce:	ef81                	bnez	a5,1be6 <strncpy+0x1c0>
            *wd = *ws;
    1bd0:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bd2:	1661                	addi	a2,a2,-8
    1bd4:	05a1                	addi	a1,a1,8
    1bd6:	0521                	addi	a0,a0,8
    1bd8:	fec363e3          	bltu	t1,a2,1bbe <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bdc:	e609                	bnez	a2,1be6 <strncpy+0x1c0>
    1bde:	a08d                	j	1c40 <strncpy+0x21a>
    1be0:	167d                	addi	a2,a2,-1
    1be2:	0505                	addi	a0,a0,1
    1be4:	ca01                	beqz	a2,1bf4 <strncpy+0x1ce>
    1be6:	0005c783          	lbu	a5,0(a1)
    1bea:	0585                	addi	a1,a1,1
    1bec:	00f50023          	sb	a5,0(a0)
    1bf0:	fbe5                	bnez	a5,1be0 <strncpy+0x1ba>
        ;
tail:
    1bf2:	b59d                	j	1a58 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bf4:	8082                	ret
    1bf6:	472d                	li	a4,11
    1bf8:	bdb5                	j	1a74 <strncpy+0x4e>
    1bfa:	00778713          	addi	a4,a5,7
    1bfe:	45ad                	li	a1,11
    1c00:	fff60693          	addi	a3,a2,-1
    1c04:	e6b778e3          	bgeu	a4,a1,1a74 <strncpy+0x4e>
    1c08:	b7fd                	j	1bf6 <strncpy+0x1d0>
    1c0a:	40a007b3          	neg	a5,a0
    1c0e:	8832                	mv	a6,a2
    1c10:	8b9d                	andi	a5,a5,7
    1c12:	4681                	li	a3,0
    1c14:	e4060be3          	beqz	a2,1a6a <strncpy+0x44>
    1c18:	b7cd                	j	1bfa <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c1a:	468d                	li	a3,3
    1c1c:	bd75                	j	1ad8 <strncpy+0xb2>
    1c1e:	872a                	mv	a4,a0
    1c20:	4681                	li	a3,0
    1c22:	bd5d                	j	1ad8 <strncpy+0xb2>
    1c24:	4685                	li	a3,1
    1c26:	bd4d                	j	1ad8 <strncpy+0xb2>
    1c28:	8082                	ret
    1c2a:	87aa                	mv	a5,a0
    1c2c:	4681                	li	a3,0
    1c2e:	b5f9                	j	1afc <strncpy+0xd6>
    1c30:	4689                	li	a3,2
    1c32:	b55d                	j	1ad8 <strncpy+0xb2>
    1c34:	4691                	li	a3,4
    1c36:	b54d                	j	1ad8 <strncpy+0xb2>
    1c38:	4695                	li	a3,5
    1c3a:	bd79                	j	1ad8 <strncpy+0xb2>
    1c3c:	4699                	li	a3,6
    1c3e:	bd69                	j	1ad8 <strncpy+0xb2>
    1c40:	8082                	ret
    1c42:	8082                	ret
    1c44:	8082                	ret

0000000000001c46 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c46:	87aa                	mv	a5,a0
    1c48:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c4a:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c4e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c52:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c54:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c56:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c5a:	2501                	sext.w	a0,a0
    1c5c:	8082                	ret

0000000000001c5e <openat>:
    register long a7 __asm__("a7") = n;
    1c5e:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c62:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c66:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c6a:	2501                	sext.w	a0,a0
    1c6c:	8082                	ret

0000000000001c6e <close>:
    register long a7 __asm__("a7") = n;
    1c6e:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c72:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c76:	2501                	sext.w	a0,a0
    1c78:	8082                	ret

0000000000001c7a <read>:
    register long a7 __asm__("a7") = n;
    1c7a:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7e:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c82:	8082                	ret

0000000000001c84 <write>:
    register long a7 __asm__("a7") = n;
    1c84:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c88:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c8c:	8082                	ret

0000000000001c8e <getpid>:
    register long a7 __asm__("a7") = n;
    1c8e:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <getppid>:
    register long a7 __asm__("a7") = n;
    1c9a:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c9e:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ca6:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1caa:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <fork>:
    register long a7 __asm__("a7") = n;
    1cb2:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cb6:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cb8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cba:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cbe:	2501                	sext.w	a0,a0
    1cc0:	8082                	ret

0000000000001cc2 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cc2:	85b2                	mv	a1,a2
    1cc4:	863a                	mv	a2,a4
    if (stack)
    1cc6:	c191                	beqz	a1,1cca <clone+0x8>
	stack += stack_size;
    1cc8:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cca:	4781                	li	a5,0
    1ccc:	4701                	li	a4,0
    1cce:	4681                	li	a3,0
    1cd0:	2601                	sext.w	a2,a2
    1cd2:	a2ed                	j	1ebc <__clone>

0000000000001cd4 <exit>:
    register long a7 __asm__("a7") = n;
    1cd4:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cd8:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cdc:	8082                	ret

0000000000001cde <waitpid>:
    register long a7 __asm__("a7") = n;
    1cde:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1ce2:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ce4:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <exec>:
    register long a7 __asm__("a7") = n;
    1cec:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cf0:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <execve>:
    register long a7 __asm__("a7") = n;
    1cf8:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cfc:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <times>:
    register long a7 __asm__("a7") = n;
    1d04:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d08:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	8082                	ret

0000000000001d10 <get_time>:

int64 get_time()
{
    1d10:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d12:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d16:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d18:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d1a:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d1e:	2501                	sext.w	a0,a0
    1d20:	ed09                	bnez	a0,1d3a <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d22:	67a2                	ld	a5,8(sp)
    1d24:	3e800713          	li	a4,1000
    1d28:	00015503          	lhu	a0,0(sp)
    1d2c:	02e7d7b3          	divu	a5,a5,a4
    1d30:	02e50533          	mul	a0,a0,a4
    1d34:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d36:	0141                	addi	sp,sp,16
    1d38:	8082                	ret
        return -1;
    1d3a:	557d                	li	a0,-1
    1d3c:	bfed                	j	1d36 <get_time+0x26>

0000000000001d3e <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d3e:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d42:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d46:	2501                	sext.w	a0,a0
    1d48:	8082                	ret

0000000000001d4a <time>:
    register long a7 __asm__("a7") = n;
    1d4a:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d4e:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d52:	2501                	sext.w	a0,a0
    1d54:	8082                	ret

0000000000001d56 <sleep>:

int sleep(unsigned long long time)
{
    1d56:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d58:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d5a:	850a                	mv	a0,sp
    1d5c:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d5e:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d62:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d64:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d68:	e501                	bnez	a0,1d70 <sleep+0x1a>
    return 0;
    1d6a:	4501                	li	a0,0
}
    1d6c:	0141                	addi	sp,sp,16
    1d6e:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d70:	4502                	lw	a0,0(sp)
}
    1d72:	0141                	addi	sp,sp,16
    1d74:	8082                	ret

0000000000001d76 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d76:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d7a:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d7e:	2501                	sext.w	a0,a0
    1d80:	8082                	ret

0000000000001d82 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d82:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d86:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d8a:	8082                	ret

0000000000001d8c <munmap>:
    register long a7 __asm__("a7") = n;
    1d8c:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d90:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d94:	2501                	sext.w	a0,a0
    1d96:	8082                	ret

0000000000001d98 <wait>:

int wait(int *code)
{
    1d98:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d9a:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d9e:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1da0:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1da2:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1da4:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1da8:	2501                	sext.w	a0,a0
    1daa:	8082                	ret

0000000000001dac <spawn>:
    register long a7 __asm__("a7") = n;
    1dac:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1db0:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1db4:	2501                	sext.w	a0,a0
    1db6:	8082                	ret

0000000000001db8 <mailread>:
    register long a7 __asm__("a7") = n;
    1db8:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dbc:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dc4:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dc8:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <fstat>:
    register long a7 __asm__("a7") = n;
    1dd0:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd4:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dd8:	2501                	sext.w	a0,a0
    1dda:	8082                	ret

0000000000001ddc <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1ddc:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dde:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1de2:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1de4:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1de8:	2501                	sext.w	a0,a0
    1dea:	8082                	ret

0000000000001dec <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dec:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dee:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1df2:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df4:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <link>:

int link(char *old_path, char *new_path)
{
    1dfc:	87aa                	mv	a5,a0
    1dfe:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e00:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e04:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e08:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e0a:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e0e:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e10:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e14:	2501                	sext.w	a0,a0
    1e16:	8082                	ret

0000000000001e18 <unlink>:

int unlink(char *path)
{
    1e18:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e1a:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e1e:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e22:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e24:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <uname>:
    register long a7 __asm__("a7") = n;
    1e2c:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e30:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <brk>:
    register long a7 __asm__("a7") = n;
    1e38:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e3c:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e44:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e46:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e4a:	8082                	ret

0000000000001e4c <chdir>:
    register long a7 __asm__("a7") = n;
    1e4c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e50:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e58:	862e                	mv	a2,a1
    1e5a:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e5c:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e5e:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e62:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e66:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e68:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6a:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e6e:	2501                	sext.w	a0,a0
    1e70:	8082                	ret

0000000000001e72 <getdents>:
    register long a7 __asm__("a7") = n;
    1e72:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e76:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <pipe>:
    register long a7 __asm__("a7") = n;
    1e7e:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e82:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e84:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e88:	2501                	sext.w	a0,a0
    1e8a:	8082                	ret

0000000000001e8c <dup>:
    register long a7 __asm__("a7") = n;
    1e8c:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e8e:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <dup2>:
    register long a7 __asm__("a7") = n;
    1e96:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e98:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9a:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <mount>:
    register long a7 __asm__("a7") = n;
    1ea2:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ea6:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <umount>:
    register long a7 __asm__("a7") = n;
    1eae:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eb2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eb4:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eb8:	2501                	sext.w	a0,a0
    1eba:	8082                	ret

0000000000001ebc <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ebc:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ebe:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ec0:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ec2:	8532                	mv	a0,a2
	mv a2, a4
    1ec4:	863a                	mv	a2,a4
	mv a3, a5
    1ec6:	86be                	mv	a3,a5
	mv a4, a6
    1ec8:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eca:	0dc00893          	li	a7,220
	ecall
    1ece:	00000073          	ecall

	beqz a0, 1f
    1ed2:	c111                	beqz	a0,1ed6 <__clone+0x1a>
	# Parent
	ret
    1ed4:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ed6:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ed8:	6522                	ld	a0,8(sp)
	jalr a1
    1eda:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1edc:	05d00893          	li	a7,93
	ecall
    1ee0:	00000073          	ecall
