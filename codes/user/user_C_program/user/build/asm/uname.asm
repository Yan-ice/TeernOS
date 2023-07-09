
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/uname:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a86d                	j	10bc <__start_main>

0000000000001004 <test_uname>:
	char domainname[65];
};

struct utsname un;

void test_uname() {
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ef250513          	addi	a0,a0,-270 # 1ef8 <__clone+0x28>
void test_uname() {
    100e:	e406                	sd	ra,8(sp)
	TEST_START(__func__);
    1010:	2e4000ef          	jal	ra,12f4 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	10450513          	addi	a0,a0,260 # 2118 <__func__.1199>
    101c:	2d8000ef          	jal	ra,12f4 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ef050513          	addi	a0,a0,-272 # 1f10 <__clone+0x40>
    1028:	2cc000ef          	jal	ra,12f4 <puts>
	int test_ret = uname(&un);
    102c:	00001517          	auipc	a0,0x1
    1030:	f6450513          	addi	a0,a0,-156 # 1f90 <un>
    1034:	60d000ef          	jal	ra,1e40 <uname>
	assert(test_ret >= 0);
    1038:	06054363          	bltz	a0,109e <test_uname+0x9a>

	printf("Uname: %s %s %s %s %s %s\n", 
    103c:	00001817          	auipc	a6,0x1
    1040:	09980813          	addi	a6,a6,153 # 20d5 <un+0x145>
    1044:	00001797          	auipc	a5,0x1
    1048:	05078793          	addi	a5,a5,80 # 2094 <un+0x104>
    104c:	00001717          	auipc	a4,0x1
    1050:	00770713          	addi	a4,a4,7 # 2053 <un+0xc3>
    1054:	00001697          	auipc	a3,0x1
    1058:	fbe68693          	addi	a3,a3,-66 # 2012 <un+0x82>
    105c:	00001617          	auipc	a2,0x1
    1060:	f7560613          	addi	a2,a2,-139 # 1fd1 <un+0x41>
    1064:	00001597          	auipc	a1,0x1
    1068:	f2c58593          	addi	a1,a1,-212 # 1f90 <un>
    106c:	00001517          	auipc	a0,0x1
    1070:	ed450513          	addi	a0,a0,-300 # 1f40 <__clone+0x70>
    1074:	2a2000ef          	jal	ra,1316 <printf>
		un.sysname, un.nodename, un.release, un.version, un.machine, un.domainname);

	TEST_END(__func__);
    1078:	00001517          	auipc	a0,0x1
    107c:	ee850513          	addi	a0,a0,-280 # 1f60 <__clone+0x90>
    1080:	274000ef          	jal	ra,12f4 <puts>
    1084:	00001517          	auipc	a0,0x1
    1088:	09450513          	addi	a0,a0,148 # 2118 <__func__.1199>
    108c:	268000ef          	jal	ra,12f4 <puts>
}
    1090:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    1092:	00001517          	auipc	a0,0x1
    1096:	e7e50513          	addi	a0,a0,-386 # 1f10 <__clone+0x40>
}
    109a:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    109c:	aca1                	j	12f4 <puts>
	assert(test_ret >= 0);
    109e:	00001517          	auipc	a0,0x1
    10a2:	e8250513          	addi	a0,a0,-382 # 1f20 <__clone+0x50>
    10a6:	530000ef          	jal	ra,15d6 <panic>
    10aa:	bf49                	j	103c <test_uname+0x38>

00000000000010ac <main>:

int main(void) {
    10ac:	1141                	addi	sp,sp,-16
    10ae:	e406                	sd	ra,8(sp)
	test_uname();
    10b0:	f55ff0ef          	jal	ra,1004 <test_uname>
	return 0;
}
    10b4:	60a2                	ld	ra,8(sp)
    10b6:	4501                	li	a0,0
    10b8:	0141                	addi	sp,sp,16
    10ba:	8082                	ret

00000000000010bc <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10bc:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10be:	4108                	lw	a0,0(a0)
{
    10c0:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10c2:	05a1                	addi	a1,a1,8
{
    10c4:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10c6:	fe7ff0ef          	jal	ra,10ac <main>
    10ca:	41f000ef          	jal	ra,1ce8 <exit>
	return 0;
}
    10ce:	60a2                	ld	ra,8(sp)
    10d0:	4501                	li	a0,0
    10d2:	0141                	addi	sp,sp,16
    10d4:	8082                	ret

00000000000010d6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10d6:	7179                	addi	sp,sp,-48
    10d8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10da:	12054b63          	bltz	a0,1210 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10de:	02b577bb          	remuw	a5,a0,a1
    10e2:	00001697          	auipc	a3,0x1
    10e6:	04668693          	addi	a3,a3,70 # 2128 <digits>
    buf[16] = 0;
    10ea:	00010c23          	sb	zero,24(sp)
    i = 15;
    10ee:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10f2:	1782                	slli	a5,a5,0x20
    10f4:	9381                	srli	a5,a5,0x20
    10f6:	97b6                	add	a5,a5,a3
    10f8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10fc:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1100:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1104:	16b56263          	bltu	a0,a1,1268 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    1108:	02e8763b          	remuw	a2,a6,a4
    110c:	1602                	slli	a2,a2,0x20
    110e:	9201                	srli	a2,a2,0x20
    1110:	9636                	add	a2,a2,a3
    1112:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1116:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    111a:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    111e:	12e86963          	bltu	a6,a4,1250 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1122:	02e5f63b          	remuw	a2,a1,a4
    1126:	1602                	slli	a2,a2,0x20
    1128:	9201                	srli	a2,a2,0x20
    112a:	9636                	add	a2,a2,a3
    112c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1130:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1134:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1138:	10e5ef63          	bltu	a1,a4,1256 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    113c:	02e8763b          	remuw	a2,a6,a4
    1140:	1602                	slli	a2,a2,0x20
    1142:	9201                	srli	a2,a2,0x20
    1144:	9636                	add	a2,a2,a3
    1146:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    114a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    114e:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1152:	10e86563          	bltu	a6,a4,125c <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1156:	02e5f63b          	remuw	a2,a1,a4
    115a:	1602                	slli	a2,a2,0x20
    115c:	9201                	srli	a2,a2,0x20
    115e:	9636                	add	a2,a2,a3
    1160:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1164:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1168:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    116c:	0ee5eb63          	bltu	a1,a4,1262 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1170:	02e8763b          	remuw	a2,a6,a4
    1174:	1602                	slli	a2,a2,0x20
    1176:	9201                	srli	a2,a2,0x20
    1178:	9636                	add	a2,a2,a3
    117a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    117e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1182:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1186:	0ce86263          	bltu	a6,a4,124a <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    118a:	02e5f63b          	remuw	a2,a1,a4
    118e:	1602                	slli	a2,a2,0x20
    1190:	9201                	srli	a2,a2,0x20
    1192:	9636                	add	a2,a2,a3
    1194:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1198:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119c:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11a0:	0ce5e663          	bltu	a1,a4,126c <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11a4:	02e8763b          	remuw	a2,a6,a4
    11a8:	1602                	slli	a2,a2,0x20
    11aa:	9201                	srli	a2,a2,0x20
    11ac:	9636                	add	a2,a2,a3
    11ae:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11b2:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b6:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11ba:	0ae86c63          	bltu	a6,a4,1272 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11be:	02e5f63b          	remuw	a2,a1,a4
    11c2:	1602                	slli	a2,a2,0x20
    11c4:	9201                	srli	a2,a2,0x20
    11c6:	9636                	add	a2,a2,a3
    11c8:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11cc:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11d0:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11d4:	0ae5e263          	bltu	a1,a4,1278 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11d8:	1782                	slli	a5,a5,0x20
    11da:	9381                	srli	a5,a5,0x20
    11dc:	97b6                	add	a5,a5,a3
    11de:	0007c703          	lbu	a4,0(a5)
    11e2:	4599                	li	a1,6
    11e4:	4795                	li	a5,5
    11e6:	00e10723          	sb	a4,14(sp)

    if (sign)
    11ea:	00055963          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    11ee:	1018                	addi	a4,sp,32
    11f0:	973e                	add	a4,a4,a5
    11f2:	02d00693          	li	a3,45
    11f6:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11fa:	85be                	mv	a1,a5
    write(f, s, l);
    11fc:	003c                	addi	a5,sp,8
    11fe:	4641                	li	a2,16
    1200:	9e0d                	subw	a2,a2,a1
    1202:	4505                	li	a0,1
    1204:	95be                	add	a1,a1,a5
    1206:	293000ef          	jal	ra,1c98 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    120a:	70a2                	ld	ra,40(sp)
    120c:	6145                	addi	sp,sp,48
    120e:	8082                	ret
        x = -xx;
    1210:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1214:	02b677bb          	remuw	a5,a2,a1
    1218:	00001697          	auipc	a3,0x1
    121c:	f1068693          	addi	a3,a3,-240 # 2128 <digits>
    buf[16] = 0;
    1220:	00010c23          	sb	zero,24(sp)
    i = 15;
    1224:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1228:	1782                	slli	a5,a5,0x20
    122a:	9381                	srli	a5,a5,0x20
    122c:	97b6                	add	a5,a5,a3
    122e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1232:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1236:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    123a:	ecb677e3          	bgeu	a2,a1,1108 <printint.constprop.0+0x32>
        buf[i--] = '-';
    123e:	02d00793          	li	a5,45
    1242:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1246:	45b9                	li	a1,14
    1248:	bf55                	j	11fc <printint.constprop.0+0x126>
    124a:	47a5                	li	a5,9
    124c:	45a9                	li	a1,10
    124e:	bf71                	j	11ea <printint.constprop.0+0x114>
    1250:	47b5                	li	a5,13
    1252:	45b9                	li	a1,14
    1254:	bf59                	j	11ea <printint.constprop.0+0x114>
    1256:	47b1                	li	a5,12
    1258:	45b5                	li	a1,13
    125a:	bf41                	j	11ea <printint.constprop.0+0x114>
    125c:	47ad                	li	a5,11
    125e:	45b1                	li	a1,12
    1260:	b769                	j	11ea <printint.constprop.0+0x114>
    1262:	47a9                	li	a5,10
    1264:	45ad                	li	a1,11
    1266:	b751                	j	11ea <printint.constprop.0+0x114>
    i = 15;
    1268:	45bd                	li	a1,15
    126a:	bf49                	j	11fc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    126c:	47a1                	li	a5,8
    126e:	45a5                	li	a1,9
    1270:	bfad                	j	11ea <printint.constprop.0+0x114>
    1272:	479d                	li	a5,7
    1274:	45a1                	li	a1,8
    1276:	bf95                	j	11ea <printint.constprop.0+0x114>
    1278:	4799                	li	a5,6
    127a:	459d                	li	a1,7
    127c:	b7bd                	j	11ea <printint.constprop.0+0x114>

000000000000127e <getchar>:
{
    127e:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1280:	00f10593          	addi	a1,sp,15
    1284:	4605                	li	a2,1
    1286:	4501                	li	a0,0
{
    1288:	ec06                	sd	ra,24(sp)
    char byte = 0;
    128a:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    128e:	201000ef          	jal	ra,1c8e <read>
}
    1292:	60e2                	ld	ra,24(sp)
    1294:	00f14503          	lbu	a0,15(sp)
    1298:	6105                	addi	sp,sp,32
    129a:	8082                	ret

000000000000129c <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    129c:	00001797          	auipc	a5,0x1
    12a0:	ea478793          	addi	a5,a5,-348 # 2140 <digits+0x18>
    12a4:	04000893          	li	a7,64
    12a8:	4505                	li	a0,1
    12aa:	85be                	mv	a1,a5
    12ac:	4611                	li	a2,4
    12ae:	00000073          	ecall
}
    12b2:	4501                	li	a0,0
    12b4:	8082                	ret

00000000000012b6 <putchar>:
{
    12b6:	1101                	addi	sp,sp,-32
    12b8:	ec06                	sd	ra,24(sp)
    12ba:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12bc:	3e700893          	li	a7,999
    12c0:	4505                	li	a0,1
    12c2:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12c6:	00001717          	auipc	a4,0x1
    12ca:	e7a70713          	addi	a4,a4,-390 # 2140 <digits+0x18>
    12ce:	04000893          	li	a7,64
    12d2:	4505                	li	a0,1
    12d4:	85ba                	mv	a1,a4
    12d6:	4611                	li	a2,4
    12d8:	00000073          	ecall
    return write(stdout, &byte, 1);
    12dc:	4605                	li	a2,1
    12de:	00f10593          	addi	a1,sp,15
    12e2:	4505                	li	a0,1
    char byte = c;
    12e4:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12e8:	1b1000ef          	jal	ra,1c98 <write>
}
    12ec:	60e2                	ld	ra,24(sp)
    12ee:	2501                	sext.w	a0,a0
    12f0:	6105                	addi	sp,sp,32
    12f2:	8082                	ret

00000000000012f4 <puts>:
{
    12f4:	1141                	addi	sp,sp,-16
    12f6:	e406                	sd	ra,8(sp)
    12f8:	e022                	sd	s0,0(sp)
    12fa:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12fc:	5b8000ef          	jal	ra,18b4 <strlen>
    1300:	862a                	mv	a2,a0
    1302:	85a2                	mv	a1,s0
    1304:	4505                	li	a0,1
    1306:	193000ef          	jal	ra,1c98 <write>
}
    130a:	60a2                	ld	ra,8(sp)
    130c:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    130e:	957d                	srai	a0,a0,0x3f
    return r;
    1310:	2501                	sext.w	a0,a0
}
    1312:	0141                	addi	sp,sp,16
    1314:	8082                	ret

0000000000001316 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1316:	7171                	addi	sp,sp,-176
    1318:	e0d2                	sd	s4,64(sp)
    131a:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    131c:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    131e:	18bc                	addi	a5,sp,120
{
    1320:	e8ca                	sd	s2,80(sp)
    1322:	e4ce                	sd	s3,72(sp)
    1324:	fc56                	sd	s5,56(sp)
    1326:	f85a                	sd	s6,48(sp)
    1328:	f486                	sd	ra,104(sp)
    132a:	f0a2                	sd	s0,96(sp)
    132c:	eca6                	sd	s1,88(sp)
    132e:	fcae                	sd	a1,120(sp)
    1330:	e132                	sd	a2,128(sp)
    1332:	e536                	sd	a3,136(sp)
    1334:	e93a                	sd	a4,144(sp)
    1336:	f142                	sd	a6,160(sp)
    1338:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    133a:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    133c:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1340:	00001b17          	auipc	s6,0x1
    1344:	c30b0b13          	addi	s6,s6,-976 # 1f70 <__clone+0xa0>
	::"r"((unsigned long long)ac)
    1348:	00001a97          	auipc	s5,0x1
    134c:	df8a8a93          	addi	s5,s5,-520 # 2140 <digits+0x18>
    buf[i++] = '0';
    1350:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1354:	00001997          	auipc	s3,0x1
    1358:	dd498993          	addi	s3,s3,-556 # 2128 <digits>
        if (!*s)
    135c:	00054783          	lbu	a5,0(a0)
    1360:	16078c63          	beqz	a5,14d8 <printf+0x1c2>
    1364:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1366:	19278363          	beq	a5,s2,14ec <printf+0x1d6>
    136a:	00164783          	lbu	a5,1(a2)
    136e:	0605                	addi	a2,a2,1
    1370:	fbfd                	bnez	a5,1366 <printf+0x50>
    1372:	84b2                	mv	s1,a2
        l = z - a;
    1374:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1378:	85aa                	mv	a1,a0
    137a:	8622                	mv	a2,s0
    137c:	4505                	li	a0,1
    137e:	11b000ef          	jal	ra,1c98 <write>
        if (l)
    1382:	18041e63          	bnez	s0,151e <printf+0x208>
        if (s[1] == 0)
    1386:	0014c783          	lbu	a5,1(s1)
    138a:	14078763          	beqz	a5,14d8 <printf+0x1c2>
        switch (s[1])
    138e:	07300713          	li	a4,115
    1392:	1ce78063          	beq	a5,a4,1552 <printf+0x23c>
    1396:	18f76663          	bltu	a4,a5,1522 <printf+0x20c>
    139a:	06400713          	li	a4,100
    139e:	1ae78063          	beq	a5,a4,153e <printf+0x228>
    13a2:	07000713          	li	a4,112
    13a6:	1ce79963          	bne	a5,a4,1578 <printf+0x262>
            printptr(va_arg(ap, uint64));
    13aa:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ac:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13b0:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13b2:	631c                	ld	a5,0(a4)
    13b4:	0721                	addi	a4,a4,8
    13b6:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13b8:	00479293          	slli	t0,a5,0x4
    13bc:	00879f93          	slli	t6,a5,0x8
    13c0:	00c79f13          	slli	t5,a5,0xc
    13c4:	01079e93          	slli	t4,a5,0x10
    13c8:	01479e13          	slli	t3,a5,0x14
    13cc:	01879313          	slli	t1,a5,0x18
    13d0:	01c79893          	slli	a7,a5,0x1c
    13d4:	02479813          	slli	a6,a5,0x24
    13d8:	02879513          	slli	a0,a5,0x28
    13dc:	02c79593          	slli	a1,a5,0x2c
    13e0:	03079693          	slli	a3,a5,0x30
    13e4:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13e8:	03c7d413          	srli	s0,a5,0x3c
    13ec:	01c7d39b          	srliw	t2,a5,0x1c
    13f0:	03c2d293          	srli	t0,t0,0x3c
    13f4:	03cfdf93          	srli	t6,t6,0x3c
    13f8:	03cf5f13          	srli	t5,t5,0x3c
    13fc:	03cede93          	srli	t4,t4,0x3c
    1400:	03ce5e13          	srli	t3,t3,0x3c
    1404:	03c35313          	srli	t1,t1,0x3c
    1408:	03c8d893          	srli	a7,a7,0x3c
    140c:	03c85813          	srli	a6,a6,0x3c
    1410:	9171                	srli	a0,a0,0x3c
    1412:	91f1                	srli	a1,a1,0x3c
    1414:	92f1                	srli	a3,a3,0x3c
    1416:	9371                	srli	a4,a4,0x3c
    1418:	96ce                	add	a3,a3,s3
    141a:	974e                	add	a4,a4,s3
    141c:	944e                	add	s0,s0,s3
    141e:	92ce                	add	t0,t0,s3
    1420:	9fce                	add	t6,t6,s3
    1422:	9f4e                	add	t5,t5,s3
    1424:	9ece                	add	t4,t4,s3
    1426:	9e4e                	add	t3,t3,s3
    1428:	934e                	add	t1,t1,s3
    142a:	98ce                	add	a7,a7,s3
    142c:	93ce                	add	t2,t2,s3
    142e:	984e                	add	a6,a6,s3
    1430:	954e                	add	a0,a0,s3
    1432:	95ce                	add	a1,a1,s3
    1434:	0006c083          	lbu	ra,0(a3)
    1438:	0002c283          	lbu	t0,0(t0)
    143c:	00074683          	lbu	a3,0(a4)
    1440:	000fcf83          	lbu	t6,0(t6)
    1444:	000f4f03          	lbu	t5,0(t5)
    1448:	000ece83          	lbu	t4,0(t4)
    144c:	000e4e03          	lbu	t3,0(t3)
    1450:	00034303          	lbu	t1,0(t1)
    1454:	0008c883          	lbu	a7,0(a7)
    1458:	0003c383          	lbu	t2,0(t2)
    145c:	00084803          	lbu	a6,0(a6)
    1460:	00054503          	lbu	a0,0(a0)
    1464:	0005c583          	lbu	a1,0(a1)
    1468:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    146c:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1470:	9371                	srli	a4,a4,0x3c
    1472:	8bbd                	andi	a5,a5,15
    1474:	974e                	add	a4,a4,s3
    1476:	97ce                	add	a5,a5,s3
    1478:	005105a3          	sb	t0,11(sp)
    147c:	01f10623          	sb	t6,12(sp)
    1480:	01e106a3          	sb	t5,13(sp)
    1484:	01d10723          	sb	t4,14(sp)
    1488:	01c107a3          	sb	t3,15(sp)
    148c:	00610823          	sb	t1,16(sp)
    1490:	011108a3          	sb	a7,17(sp)
    1494:	00710923          	sb	t2,18(sp)
    1498:	010109a3          	sb	a6,19(sp)
    149c:	00a10a23          	sb	a0,20(sp)
    14a0:	00b10aa3          	sb	a1,21(sp)
    14a4:	00110b23          	sb	ra,22(sp)
    14a8:	00d10ba3          	sb	a3,23(sp)
    14ac:	00810523          	sb	s0,10(sp)
    14b0:	00074703          	lbu	a4,0(a4)
    14b4:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14b8:	002c                	addi	a1,sp,8
    14ba:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14bc:	00e10c23          	sb	a4,24(sp)
    14c0:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14c4:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14c8:	7d0000ef          	jal	ra,1c98 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14cc:	00248513          	addi	a0,s1,2
        if (!*s)
    14d0:	00054783          	lbu	a5,0(a0)
    14d4:	e80798e3          	bnez	a5,1364 <printf+0x4e>
    }
    va_end(ap);
}
    14d8:	70a6                	ld	ra,104(sp)
    14da:	7406                	ld	s0,96(sp)
    14dc:	64e6                	ld	s1,88(sp)
    14de:	6946                	ld	s2,80(sp)
    14e0:	69a6                	ld	s3,72(sp)
    14e2:	6a06                	ld	s4,64(sp)
    14e4:	7ae2                	ld	s5,56(sp)
    14e6:	7b42                	ld	s6,48(sp)
    14e8:	614d                	addi	sp,sp,176
    14ea:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14ec:	00064783          	lbu	a5,0(a2)
    14f0:	84b2                	mv	s1,a2
    14f2:	01278963          	beq	a5,s2,1504 <printf+0x1ee>
    14f6:	bdbd                	j	1374 <printf+0x5e>
    14f8:	0024c783          	lbu	a5,2(s1)
    14fc:	0605                	addi	a2,a2,1
    14fe:	0489                	addi	s1,s1,2
    1500:	e7279ae3          	bne	a5,s2,1374 <printf+0x5e>
    1504:	0014c783          	lbu	a5,1(s1)
    1508:	ff2788e3          	beq	a5,s2,14f8 <printf+0x1e2>
        l = z - a;
    150c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1510:	85aa                	mv	a1,a0
    1512:	8622                	mv	a2,s0
    1514:	4505                	li	a0,1
    1516:	782000ef          	jal	ra,1c98 <write>
        if (l)
    151a:	e60406e3          	beqz	s0,1386 <printf+0x70>
    151e:	8526                	mv	a0,s1
    1520:	bd35                	j	135c <printf+0x46>
        switch (s[1])
    1522:	07800713          	li	a4,120
    1526:	04e79963          	bne	a5,a4,1578 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    152a:	6782                	ld	a5,0(sp)
    152c:	45c1                	li	a1,16
    152e:	4388                	lw	a0,0(a5)
    1530:	07a1                	addi	a5,a5,8
    1532:	e03e                	sd	a5,0(sp)
    1534:	ba3ff0ef          	jal	ra,10d6 <printint.constprop.0>
        s += 2;
    1538:	00248513          	addi	a0,s1,2
    153c:	bf51                	j	14d0 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    153e:	6782                	ld	a5,0(sp)
    1540:	45a9                	li	a1,10
    1542:	4388                	lw	a0,0(a5)
    1544:	07a1                	addi	a5,a5,8
    1546:	e03e                	sd	a5,0(sp)
    1548:	b8fff0ef          	jal	ra,10d6 <printint.constprop.0>
        s += 2;
    154c:	00248513          	addi	a0,s1,2
    1550:	b741                	j	14d0 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1552:	6782                	ld	a5,0(sp)
    1554:	6380                	ld	s0,0(a5)
    1556:	07a1                	addi	a5,a5,8
    1558:	e03e                	sd	a5,0(sp)
    155a:	cc25                	beqz	s0,15d2 <printf+0x2bc>
            l = strnlen(a, 200);
    155c:	0c800593          	li	a1,200
    1560:	8522                	mv	a0,s0
    1562:	43e000ef          	jal	ra,19a0 <strnlen>
    write(f, s, l);
    1566:	0005061b          	sext.w	a2,a0
    156a:	85a2                	mv	a1,s0
    156c:	4505                	li	a0,1
    156e:	72a000ef          	jal	ra,1c98 <write>
        s += 2;
    1572:	00248513          	addi	a0,s1,2
    1576:	bfa9                	j	14d0 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1578:	3e700893          	li	a7,999
    157c:	4505                	li	a0,1
    157e:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1582:	04000893          	li	a7,64
    1586:	4505                	li	a0,1
    1588:	85d6                	mv	a1,s5
    158a:	4611                	li	a2,4
    158c:	00000073          	ecall
    char byte = c;
    1590:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1594:	4605                	li	a2,1
    1596:	002c                	addi	a1,sp,8
    1598:	4505                	li	a0,1
    char byte = c;
    159a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    159e:	6fa000ef          	jal	ra,1c98 <write>
            putchar(s[1]);
    15a2:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15a6:	3e700893          	li	a7,999
    15aa:	4505                	li	a0,1
    15ac:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15b0:	04000893          	li	a7,64
    15b4:	4505                	li	a0,1
    15b6:	85d6                	mv	a1,s5
    15b8:	4611                	li	a2,4
    15ba:	00000073          	ecall
    return write(stdout, &byte, 1);
    15be:	4605                	li	a2,1
    15c0:	002c                	addi	a1,sp,8
    15c2:	4505                	li	a0,1
    char byte = c;
    15c4:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15c8:	6d0000ef          	jal	ra,1c98 <write>
        s += 2;
    15cc:	00248513          	addi	a0,s1,2
    15d0:	b701                	j	14d0 <printf+0x1ba>
                a = "(null)";
    15d2:	845a                	mv	s0,s6
    15d4:	b761                	j	155c <printf+0x246>

00000000000015d6 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15d6:	1141                	addi	sp,sp,-16
    15d8:	e406                	sd	ra,8(sp)
    puts(m);
    15da:	d1bff0ef          	jal	ra,12f4 <puts>
    exit(-100);
}
    15de:	60a2                	ld	ra,8(sp)
    exit(-100);
    15e0:	f9c00513          	li	a0,-100
}
    15e4:	0141                	addi	sp,sp,16
    exit(-100);
    15e6:	a709                	j	1ce8 <exit>

00000000000015e8 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e8:	02000793          	li	a5,32
    15ec:	00f50663          	beq	a0,a5,15f8 <isspace+0x10>
    15f0:	355d                	addiw	a0,a0,-9
    15f2:	00553513          	sltiu	a0,a0,5
    15f6:	8082                	ret
    15f8:	4505                	li	a0,1
}
    15fa:	8082                	ret

00000000000015fc <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15fc:	fd05051b          	addiw	a0,a0,-48
}
    1600:	00a53513          	sltiu	a0,a0,10
    1604:	8082                	ret

0000000000001606 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1606:	02000613          	li	a2,32
    160a:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    160c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1610:	ff77069b          	addiw	a3,a4,-9
    1614:	04c70d63          	beq	a4,a2,166e <atoi+0x68>
    1618:	0007079b          	sext.w	a5,a4
    161c:	04d5f963          	bgeu	a1,a3,166e <atoi+0x68>
        s++;
    switch (*s)
    1620:	02b00693          	li	a3,43
    1624:	04d70a63          	beq	a4,a3,1678 <atoi+0x72>
    1628:	02d00693          	li	a3,45
    162c:	06d70463          	beq	a4,a3,1694 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1630:	fd07859b          	addiw	a1,a5,-48
    1634:	4625                	li	a2,9
    1636:	873e                	mv	a4,a5
    1638:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    163a:	4e01                	li	t3,0
    while (isdigit(*s))
    163c:	04b66a63          	bltu	a2,a1,1690 <atoi+0x8a>
    int n = 0, neg = 0;
    1640:	4501                	li	a0,0
    while (isdigit(*s))
    1642:	4825                	li	a6,9
    1644:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1648:	0025179b          	slliw	a5,a0,0x2
    164c:	9d3d                	addw	a0,a0,a5
    164e:	fd07031b          	addiw	t1,a4,-48
    1652:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1656:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    165a:	0685                	addi	a3,a3,1
    165c:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1660:	0006071b          	sext.w	a4,a2
    1664:	feb870e3          	bgeu	a6,a1,1644 <atoi+0x3e>
    return neg ? n : -n;
    1668:	000e0563          	beqz	t3,1672 <atoi+0x6c>
}
    166c:	8082                	ret
        s++;
    166e:	0505                	addi	a0,a0,1
    1670:	bf71                	j	160c <atoi+0x6>
    1672:	4113053b          	subw	a0,t1,a7
    1676:	8082                	ret
    while (isdigit(*s))
    1678:	00154783          	lbu	a5,1(a0)
    167c:	4625                	li	a2,9
        s++;
    167e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1682:	fd07859b          	addiw	a1,a5,-48
    1686:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    168a:	4e01                	li	t3,0
    while (isdigit(*s))
    168c:	fab67ae3          	bgeu	a2,a1,1640 <atoi+0x3a>
    1690:	4501                	li	a0,0
}
    1692:	8082                	ret
    while (isdigit(*s))
    1694:	00154783          	lbu	a5,1(a0)
    1698:	4625                	li	a2,9
        s++;
    169a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    169e:	fd07859b          	addiw	a1,a5,-48
    16a2:	0007871b          	sext.w	a4,a5
    16a6:	feb665e3          	bltu	a2,a1,1690 <atoi+0x8a>
        neg = 1;
    16aa:	4e05                	li	t3,1
    16ac:	bf51                	j	1640 <atoi+0x3a>

00000000000016ae <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16ae:	16060d63          	beqz	a2,1828 <memset+0x17a>
    16b2:	40a007b3          	neg	a5,a0
    16b6:	8b9d                	andi	a5,a5,7
    16b8:	00778713          	addi	a4,a5,7
    16bc:	482d                	li	a6,11
    16be:	0ff5f593          	zext.b	a1,a1
    16c2:	fff60693          	addi	a3,a2,-1
    16c6:	17076263          	bltu	a4,a6,182a <memset+0x17c>
    16ca:	16e6ea63          	bltu	a3,a4,183e <memset+0x190>
    16ce:	16078563          	beqz	a5,1838 <memset+0x18a>
    16d2:	00b50023          	sb	a1,0(a0)
    16d6:	4705                	li	a4,1
    16d8:	00150e93          	addi	t4,a0,1
    16dc:	14e78c63          	beq	a5,a4,1834 <memset+0x186>
    16e0:	00b500a3          	sb	a1,1(a0)
    16e4:	4709                	li	a4,2
    16e6:	00250e93          	addi	t4,a0,2
    16ea:	14e78d63          	beq	a5,a4,1844 <memset+0x196>
    16ee:	00b50123          	sb	a1,2(a0)
    16f2:	470d                	li	a4,3
    16f4:	00350e93          	addi	t4,a0,3
    16f8:	12e78b63          	beq	a5,a4,182e <memset+0x180>
    16fc:	00b501a3          	sb	a1,3(a0)
    1700:	4711                	li	a4,4
    1702:	00450e93          	addi	t4,a0,4
    1706:	14e78163          	beq	a5,a4,1848 <memset+0x19a>
    170a:	00b50223          	sb	a1,4(a0)
    170e:	4715                	li	a4,5
    1710:	00550e93          	addi	t4,a0,5
    1714:	12e78c63          	beq	a5,a4,184c <memset+0x19e>
    1718:	00b502a3          	sb	a1,5(a0)
    171c:	471d                	li	a4,7
    171e:	00650e93          	addi	t4,a0,6
    1722:	12e79763          	bne	a5,a4,1850 <memset+0x1a2>
    1726:	00750e93          	addi	t4,a0,7
    172a:	00b50323          	sb	a1,6(a0)
    172e:	4f1d                	li	t5,7
    1730:	00859713          	slli	a4,a1,0x8
    1734:	8f4d                	or	a4,a4,a1
    1736:	01059e13          	slli	t3,a1,0x10
    173a:	01c76e33          	or	t3,a4,t3
    173e:	01859313          	slli	t1,a1,0x18
    1742:	006e6333          	or	t1,t3,t1
    1746:	02059893          	slli	a7,a1,0x20
    174a:	011368b3          	or	a7,t1,a7
    174e:	02859813          	slli	a6,a1,0x28
    1752:	40f60333          	sub	t1,a2,a5
    1756:	0108e833          	or	a6,a7,a6
    175a:	03059693          	slli	a3,a1,0x30
    175e:	00d866b3          	or	a3,a6,a3
    1762:	03859713          	slli	a4,a1,0x38
    1766:	97aa                	add	a5,a5,a0
    1768:	ff837813          	andi	a6,t1,-8
    176c:	8f55                	or	a4,a4,a3
    176e:	00f806b3          	add	a3,a6,a5
    1772:	e398                	sd	a4,0(a5)
    1774:	07a1                	addi	a5,a5,8
    1776:	fed79ee3          	bne	a5,a3,1772 <memset+0xc4>
    177a:	ff837693          	andi	a3,t1,-8
    177e:	00de87b3          	add	a5,t4,a3
    1782:	01e6873b          	addw	a4,a3,t5
    1786:	0ad30663          	beq	t1,a3,1832 <memset+0x184>
    178a:	00b78023          	sb	a1,0(a5)
    178e:	0017069b          	addiw	a3,a4,1
    1792:	08c6fb63          	bgeu	a3,a2,1828 <memset+0x17a>
    1796:	00b780a3          	sb	a1,1(a5)
    179a:	0027069b          	addiw	a3,a4,2
    179e:	08c6f563          	bgeu	a3,a2,1828 <memset+0x17a>
    17a2:	00b78123          	sb	a1,2(a5)
    17a6:	0037069b          	addiw	a3,a4,3
    17aa:	06c6ff63          	bgeu	a3,a2,1828 <memset+0x17a>
    17ae:	00b781a3          	sb	a1,3(a5)
    17b2:	0047069b          	addiw	a3,a4,4
    17b6:	06c6f963          	bgeu	a3,a2,1828 <memset+0x17a>
    17ba:	00b78223          	sb	a1,4(a5)
    17be:	0057069b          	addiw	a3,a4,5
    17c2:	06c6f363          	bgeu	a3,a2,1828 <memset+0x17a>
    17c6:	00b782a3          	sb	a1,5(a5)
    17ca:	0067069b          	addiw	a3,a4,6
    17ce:	04c6fd63          	bgeu	a3,a2,1828 <memset+0x17a>
    17d2:	00b78323          	sb	a1,6(a5)
    17d6:	0077069b          	addiw	a3,a4,7
    17da:	04c6f763          	bgeu	a3,a2,1828 <memset+0x17a>
    17de:	00b783a3          	sb	a1,7(a5)
    17e2:	0087069b          	addiw	a3,a4,8
    17e6:	04c6f163          	bgeu	a3,a2,1828 <memset+0x17a>
    17ea:	00b78423          	sb	a1,8(a5)
    17ee:	0097069b          	addiw	a3,a4,9
    17f2:	02c6fb63          	bgeu	a3,a2,1828 <memset+0x17a>
    17f6:	00b784a3          	sb	a1,9(a5)
    17fa:	00a7069b          	addiw	a3,a4,10
    17fe:	02c6f563          	bgeu	a3,a2,1828 <memset+0x17a>
    1802:	00b78523          	sb	a1,10(a5)
    1806:	00b7069b          	addiw	a3,a4,11
    180a:	00c6ff63          	bgeu	a3,a2,1828 <memset+0x17a>
    180e:	00b785a3          	sb	a1,11(a5)
    1812:	00c7069b          	addiw	a3,a4,12
    1816:	00c6f963          	bgeu	a3,a2,1828 <memset+0x17a>
    181a:	00b78623          	sb	a1,12(a5)
    181e:	2735                	addiw	a4,a4,13
    1820:	00c77463          	bgeu	a4,a2,1828 <memset+0x17a>
    1824:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1828:	8082                	ret
    182a:	472d                	li	a4,11
    182c:	bd79                	j	16ca <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    182e:	4f0d                	li	t5,3
    1830:	b701                	j	1730 <memset+0x82>
    1832:	8082                	ret
    1834:	4f05                	li	t5,1
    1836:	bded                	j	1730 <memset+0x82>
    1838:	8eaa                	mv	t4,a0
    183a:	4f01                	li	t5,0
    183c:	bdd5                	j	1730 <memset+0x82>
    183e:	87aa                	mv	a5,a0
    1840:	4701                	li	a4,0
    1842:	b7a1                	j	178a <memset+0xdc>
    1844:	4f09                	li	t5,2
    1846:	b5ed                	j	1730 <memset+0x82>
    1848:	4f11                	li	t5,4
    184a:	b5dd                	j	1730 <memset+0x82>
    184c:	4f15                	li	t5,5
    184e:	b5cd                	j	1730 <memset+0x82>
    1850:	4f19                	li	t5,6
    1852:	bdf9                	j	1730 <memset+0x82>

0000000000001854 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1854:	00054783          	lbu	a5,0(a0)
    1858:	0005c703          	lbu	a4,0(a1)
    185c:	00e79863          	bne	a5,a4,186c <strcmp+0x18>
    1860:	0505                	addi	a0,a0,1
    1862:	0585                	addi	a1,a1,1
    1864:	fbe5                	bnez	a5,1854 <strcmp>
    1866:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1868:	9d19                	subw	a0,a0,a4
    186a:	8082                	ret
    186c:	0007851b          	sext.w	a0,a5
    1870:	bfe5                	j	1868 <strcmp+0x14>

0000000000001872 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1872:	ce05                	beqz	a2,18aa <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1874:	00054703          	lbu	a4,0(a0)
    1878:	0005c783          	lbu	a5,0(a1)
    187c:	cb0d                	beqz	a4,18ae <strncmp+0x3c>
    if (!n--)
    187e:	167d                	addi	a2,a2,-1
    1880:	00c506b3          	add	a3,a0,a2
    1884:	a819                	j	189a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1886:	00a68e63          	beq	a3,a0,18a2 <strncmp+0x30>
    188a:	0505                	addi	a0,a0,1
    188c:	00e79b63          	bne	a5,a4,18a2 <strncmp+0x30>
    1890:	00054703          	lbu	a4,0(a0)
    1894:	0005c783          	lbu	a5,0(a1)
    1898:	cb19                	beqz	a4,18ae <strncmp+0x3c>
    189a:	0005c783          	lbu	a5,0(a1)
    189e:	0585                	addi	a1,a1,1
    18a0:	f3fd                	bnez	a5,1886 <strncmp+0x14>
        ;
    return *l - *r;
    18a2:	0007051b          	sext.w	a0,a4
    18a6:	9d1d                	subw	a0,a0,a5
    18a8:	8082                	ret
        return 0;
    18aa:	4501                	li	a0,0
}
    18ac:	8082                	ret
    18ae:	4501                	li	a0,0
    return *l - *r;
    18b0:	9d1d                	subw	a0,a0,a5
    18b2:	8082                	ret

00000000000018b4 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18b4:	00757793          	andi	a5,a0,7
    18b8:	cf89                	beqz	a5,18d2 <strlen+0x1e>
    18ba:	87aa                	mv	a5,a0
    18bc:	a029                	j	18c6 <strlen+0x12>
    18be:	0785                	addi	a5,a5,1
    18c0:	0077f713          	andi	a4,a5,7
    18c4:	cb01                	beqz	a4,18d4 <strlen+0x20>
        if (!*s)
    18c6:	0007c703          	lbu	a4,0(a5)
    18ca:	fb75                	bnez	a4,18be <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18cc:	40a78533          	sub	a0,a5,a0
}
    18d0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18d2:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18d4:	6394                	ld	a3,0(a5)
    18d6:	00000597          	auipc	a1,0x0
    18da:	6a25b583          	ld	a1,1698(a1) # 1f78 <__clone+0xa8>
    18de:	00000617          	auipc	a2,0x0
    18e2:	6a263603          	ld	a2,1698(a2) # 1f80 <__clone+0xb0>
    18e6:	a019                	j	18ec <strlen+0x38>
    18e8:	6794                	ld	a3,8(a5)
    18ea:	07a1                	addi	a5,a5,8
    18ec:	00b68733          	add	a4,a3,a1
    18f0:	fff6c693          	not	a3,a3
    18f4:	8f75                	and	a4,a4,a3
    18f6:	8f71                	and	a4,a4,a2
    18f8:	db65                	beqz	a4,18e8 <strlen+0x34>
    for (; *s; s++)
    18fa:	0007c703          	lbu	a4,0(a5)
    18fe:	d779                	beqz	a4,18cc <strlen+0x18>
    1900:	0017c703          	lbu	a4,1(a5)
    1904:	0785                	addi	a5,a5,1
    1906:	d379                	beqz	a4,18cc <strlen+0x18>
    1908:	0017c703          	lbu	a4,1(a5)
    190c:	0785                	addi	a5,a5,1
    190e:	fb6d                	bnez	a4,1900 <strlen+0x4c>
    1910:	bf75                	j	18cc <strlen+0x18>

0000000000001912 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1912:	00757713          	andi	a4,a0,7
{
    1916:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1918:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    191c:	cb19                	beqz	a4,1932 <memchr+0x20>
    191e:	ce25                	beqz	a2,1996 <memchr+0x84>
    1920:	0007c703          	lbu	a4,0(a5)
    1924:	04b70e63          	beq	a4,a1,1980 <memchr+0x6e>
    1928:	0785                	addi	a5,a5,1
    192a:	0077f713          	andi	a4,a5,7
    192e:	167d                	addi	a2,a2,-1
    1930:	f77d                	bnez	a4,191e <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1932:	4501                	li	a0,0
    if (n && *s != c)
    1934:	c235                	beqz	a2,1998 <memchr+0x86>
    1936:	0007c703          	lbu	a4,0(a5)
    193a:	04b70363          	beq	a4,a1,1980 <memchr+0x6e>
        size_t k = ONES * c;
    193e:	00000517          	auipc	a0,0x0
    1942:	64a53503          	ld	a0,1610(a0) # 1f88 <__clone+0xb8>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1946:	471d                	li	a4,7
        size_t k = ONES * c;
    1948:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    194c:	02c77a63          	bgeu	a4,a2,1980 <memchr+0x6e>
    1950:	00000897          	auipc	a7,0x0
    1954:	6288b883          	ld	a7,1576(a7) # 1f78 <__clone+0xa8>
    1958:	00000817          	auipc	a6,0x0
    195c:	62883803          	ld	a6,1576(a6) # 1f80 <__clone+0xb0>
    1960:	431d                	li	t1,7
    1962:	a029                	j	196c <memchr+0x5a>
    1964:	1661                	addi	a2,a2,-8
    1966:	07a1                	addi	a5,a5,8
    1968:	02c37963          	bgeu	t1,a2,199a <memchr+0x88>
    196c:	6398                	ld	a4,0(a5)
    196e:	8f29                	xor	a4,a4,a0
    1970:	011706b3          	add	a3,a4,a7
    1974:	fff74713          	not	a4,a4
    1978:	8f75                	and	a4,a4,a3
    197a:	01077733          	and	a4,a4,a6
    197e:	d37d                	beqz	a4,1964 <memchr+0x52>
    1980:	853e                	mv	a0,a5
    1982:	97b2                	add	a5,a5,a2
    1984:	a021                	j	198c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1986:	0505                	addi	a0,a0,1
    1988:	00f50763          	beq	a0,a5,1996 <memchr+0x84>
    198c:	00054703          	lbu	a4,0(a0)
    1990:	feb71be3          	bne	a4,a1,1986 <memchr+0x74>
    1994:	8082                	ret
    return n ? (void *)s : 0;
    1996:	4501                	li	a0,0
}
    1998:	8082                	ret
    return n ? (void *)s : 0;
    199a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    199c:	f275                	bnez	a2,1980 <memchr+0x6e>
}
    199e:	8082                	ret

00000000000019a0 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19a0:	1101                	addi	sp,sp,-32
    19a2:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19a4:	862e                	mv	a2,a1
{
    19a6:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19a8:	4581                	li	a1,0
{
    19aa:	e426                	sd	s1,8(sp)
    19ac:	ec06                	sd	ra,24(sp)
    19ae:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19b0:	f63ff0ef          	jal	ra,1912 <memchr>
    return p ? p - s : n;
    19b4:	c519                	beqz	a0,19c2 <strnlen+0x22>
}
    19b6:	60e2                	ld	ra,24(sp)
    19b8:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19ba:	8d05                	sub	a0,a0,s1
}
    19bc:	64a2                	ld	s1,8(sp)
    19be:	6105                	addi	sp,sp,32
    19c0:	8082                	ret
    19c2:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19c4:	8522                	mv	a0,s0
}
    19c6:	6442                	ld	s0,16(sp)
    19c8:	64a2                	ld	s1,8(sp)
    19ca:	6105                	addi	sp,sp,32
    19cc:	8082                	ret

00000000000019ce <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19ce:	00b547b3          	xor	a5,a0,a1
    19d2:	8b9d                	andi	a5,a5,7
    19d4:	eb95                	bnez	a5,1a08 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19d6:	0075f793          	andi	a5,a1,7
    19da:	e7b1                	bnez	a5,1a26 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19dc:	6198                	ld	a4,0(a1)
    19de:	00000617          	auipc	a2,0x0
    19e2:	59a63603          	ld	a2,1434(a2) # 1f78 <__clone+0xa8>
    19e6:	00000817          	auipc	a6,0x0
    19ea:	59a83803          	ld	a6,1434(a6) # 1f80 <__clone+0xb0>
    19ee:	a029                	j	19f8 <strcpy+0x2a>
    19f0:	e118                	sd	a4,0(a0)
    19f2:	6598                	ld	a4,8(a1)
    19f4:	05a1                	addi	a1,a1,8
    19f6:	0521                	addi	a0,a0,8
    19f8:	00c707b3          	add	a5,a4,a2
    19fc:	fff74693          	not	a3,a4
    1a00:	8ff5                	and	a5,a5,a3
    1a02:	0107f7b3          	and	a5,a5,a6
    1a06:	d7ed                	beqz	a5,19f0 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a08:	0005c783          	lbu	a5,0(a1)
    1a0c:	00f50023          	sb	a5,0(a0)
    1a10:	c785                	beqz	a5,1a38 <strcpy+0x6a>
    1a12:	0015c783          	lbu	a5,1(a1)
    1a16:	0505                	addi	a0,a0,1
    1a18:	0585                	addi	a1,a1,1
    1a1a:	00f50023          	sb	a5,0(a0)
    1a1e:	fbf5                	bnez	a5,1a12 <strcpy+0x44>
        ;
    return d;
}
    1a20:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a22:	0505                	addi	a0,a0,1
    1a24:	df45                	beqz	a4,19dc <strcpy+0xe>
            if (!(*d = *s))
    1a26:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a2a:	0585                	addi	a1,a1,1
    1a2c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a30:	00f50023          	sb	a5,0(a0)
    1a34:	f7fd                	bnez	a5,1a22 <strcpy+0x54>
}
    1a36:	8082                	ret
    1a38:	8082                	ret

0000000000001a3a <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a3a:	00b547b3          	xor	a5,a0,a1
    1a3e:	8b9d                	andi	a5,a5,7
    1a40:	1a079863          	bnez	a5,1bf0 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a44:	0075f793          	andi	a5,a1,7
    1a48:	16078463          	beqz	a5,1bb0 <strncpy+0x176>
    1a4c:	ea01                	bnez	a2,1a5c <strncpy+0x22>
    1a4e:	a421                	j	1c56 <strncpy+0x21c>
    1a50:	167d                	addi	a2,a2,-1
    1a52:	0505                	addi	a0,a0,1
    1a54:	14070e63          	beqz	a4,1bb0 <strncpy+0x176>
    1a58:	1a060863          	beqz	a2,1c08 <strncpy+0x1ce>
    1a5c:	0005c783          	lbu	a5,0(a1)
    1a60:	0585                	addi	a1,a1,1
    1a62:	0075f713          	andi	a4,a1,7
    1a66:	00f50023          	sb	a5,0(a0)
    1a6a:	f3fd                	bnez	a5,1a50 <strncpy+0x16>
    1a6c:	4805                	li	a6,1
    1a6e:	1a061863          	bnez	a2,1c1e <strncpy+0x1e4>
    1a72:	40a007b3          	neg	a5,a0
    1a76:	8b9d                	andi	a5,a5,7
    1a78:	4681                	li	a3,0
    1a7a:	18061a63          	bnez	a2,1c0e <strncpy+0x1d4>
    1a7e:	00778713          	addi	a4,a5,7
    1a82:	45ad                	li	a1,11
    1a84:	18b76363          	bltu	a4,a1,1c0a <strncpy+0x1d0>
    1a88:	1ae6eb63          	bltu	a3,a4,1c3e <strncpy+0x204>
    1a8c:	1a078363          	beqz	a5,1c32 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a90:	00050023          	sb	zero,0(a0)
    1a94:	4685                	li	a3,1
    1a96:	00150713          	addi	a4,a0,1
    1a9a:	18d78f63          	beq	a5,a3,1c38 <strncpy+0x1fe>
    1a9e:	000500a3          	sb	zero,1(a0)
    1aa2:	4689                	li	a3,2
    1aa4:	00250713          	addi	a4,a0,2
    1aa8:	18d78e63          	beq	a5,a3,1c44 <strncpy+0x20a>
    1aac:	00050123          	sb	zero,2(a0)
    1ab0:	468d                	li	a3,3
    1ab2:	00350713          	addi	a4,a0,3
    1ab6:	16d78c63          	beq	a5,a3,1c2e <strncpy+0x1f4>
    1aba:	000501a3          	sb	zero,3(a0)
    1abe:	4691                	li	a3,4
    1ac0:	00450713          	addi	a4,a0,4
    1ac4:	18d78263          	beq	a5,a3,1c48 <strncpy+0x20e>
    1ac8:	00050223          	sb	zero,4(a0)
    1acc:	4695                	li	a3,5
    1ace:	00550713          	addi	a4,a0,5
    1ad2:	16d78d63          	beq	a5,a3,1c4c <strncpy+0x212>
    1ad6:	000502a3          	sb	zero,5(a0)
    1ada:	469d                	li	a3,7
    1adc:	00650713          	addi	a4,a0,6
    1ae0:	16d79863          	bne	a5,a3,1c50 <strncpy+0x216>
    1ae4:	00750713          	addi	a4,a0,7
    1ae8:	00050323          	sb	zero,6(a0)
    1aec:	40f80833          	sub	a6,a6,a5
    1af0:	ff887593          	andi	a1,a6,-8
    1af4:	97aa                	add	a5,a5,a0
    1af6:	95be                	add	a1,a1,a5
    1af8:	0007b023          	sd	zero,0(a5)
    1afc:	07a1                	addi	a5,a5,8
    1afe:	feb79de3          	bne	a5,a1,1af8 <strncpy+0xbe>
    1b02:	ff887593          	andi	a1,a6,-8
    1b06:	9ead                	addw	a3,a3,a1
    1b08:	00b707b3          	add	a5,a4,a1
    1b0c:	12b80863          	beq	a6,a1,1c3c <strncpy+0x202>
    1b10:	00078023          	sb	zero,0(a5)
    1b14:	0016871b          	addiw	a4,a3,1
    1b18:	0ec77863          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b1c:	000780a3          	sb	zero,1(a5)
    1b20:	0026871b          	addiw	a4,a3,2
    1b24:	0ec77263          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b28:	00078123          	sb	zero,2(a5)
    1b2c:	0036871b          	addiw	a4,a3,3
    1b30:	0cc77c63          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b34:	000781a3          	sb	zero,3(a5)
    1b38:	0046871b          	addiw	a4,a3,4
    1b3c:	0cc77663          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b40:	00078223          	sb	zero,4(a5)
    1b44:	0056871b          	addiw	a4,a3,5
    1b48:	0cc77063          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b4c:	000782a3          	sb	zero,5(a5)
    1b50:	0066871b          	addiw	a4,a3,6
    1b54:	0ac77a63          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b58:	00078323          	sb	zero,6(a5)
    1b5c:	0076871b          	addiw	a4,a3,7
    1b60:	0ac77463          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b64:	000783a3          	sb	zero,7(a5)
    1b68:	0086871b          	addiw	a4,a3,8
    1b6c:	08c77e63          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b70:	00078423          	sb	zero,8(a5)
    1b74:	0096871b          	addiw	a4,a3,9
    1b78:	08c77863          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b7c:	000784a3          	sb	zero,9(a5)
    1b80:	00a6871b          	addiw	a4,a3,10
    1b84:	08c77263          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b88:	00078523          	sb	zero,10(a5)
    1b8c:	00b6871b          	addiw	a4,a3,11
    1b90:	06c77c63          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1b94:	000785a3          	sb	zero,11(a5)
    1b98:	00c6871b          	addiw	a4,a3,12
    1b9c:	06c77663          	bgeu	a4,a2,1c08 <strncpy+0x1ce>
    1ba0:	00078623          	sb	zero,12(a5)
    1ba4:	26b5                	addiw	a3,a3,13
    1ba6:	06c6f163          	bgeu	a3,a2,1c08 <strncpy+0x1ce>
    1baa:	000786a3          	sb	zero,13(a5)
    1bae:	8082                	ret
            ;
        if (!n || !*s)
    1bb0:	c645                	beqz	a2,1c58 <strncpy+0x21e>
    1bb2:	0005c783          	lbu	a5,0(a1)
    1bb6:	ea078be3          	beqz	a5,1a6c <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bba:	479d                	li	a5,7
    1bbc:	02c7ff63          	bgeu	a5,a2,1bfa <strncpy+0x1c0>
    1bc0:	00000897          	auipc	a7,0x0
    1bc4:	3b88b883          	ld	a7,952(a7) # 1f78 <__clone+0xa8>
    1bc8:	00000817          	auipc	a6,0x0
    1bcc:	3b883803          	ld	a6,952(a6) # 1f80 <__clone+0xb0>
    1bd0:	431d                	li	t1,7
    1bd2:	6198                	ld	a4,0(a1)
    1bd4:	011707b3          	add	a5,a4,a7
    1bd8:	fff74693          	not	a3,a4
    1bdc:	8ff5                	and	a5,a5,a3
    1bde:	0107f7b3          	and	a5,a5,a6
    1be2:	ef81                	bnez	a5,1bfa <strncpy+0x1c0>
            *wd = *ws;
    1be4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1be6:	1661                	addi	a2,a2,-8
    1be8:	05a1                	addi	a1,a1,8
    1bea:	0521                	addi	a0,a0,8
    1bec:	fec363e3          	bltu	t1,a2,1bd2 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bf0:	e609                	bnez	a2,1bfa <strncpy+0x1c0>
    1bf2:	a08d                	j	1c54 <strncpy+0x21a>
    1bf4:	167d                	addi	a2,a2,-1
    1bf6:	0505                	addi	a0,a0,1
    1bf8:	ca01                	beqz	a2,1c08 <strncpy+0x1ce>
    1bfa:	0005c783          	lbu	a5,0(a1)
    1bfe:	0585                	addi	a1,a1,1
    1c00:	00f50023          	sb	a5,0(a0)
    1c04:	fbe5                	bnez	a5,1bf4 <strncpy+0x1ba>
        ;
tail:
    1c06:	b59d                	j	1a6c <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c08:	8082                	ret
    1c0a:	472d                	li	a4,11
    1c0c:	bdb5                	j	1a88 <strncpy+0x4e>
    1c0e:	00778713          	addi	a4,a5,7
    1c12:	45ad                	li	a1,11
    1c14:	fff60693          	addi	a3,a2,-1
    1c18:	e6b778e3          	bgeu	a4,a1,1a88 <strncpy+0x4e>
    1c1c:	b7fd                	j	1c0a <strncpy+0x1d0>
    1c1e:	40a007b3          	neg	a5,a0
    1c22:	8832                	mv	a6,a2
    1c24:	8b9d                	andi	a5,a5,7
    1c26:	4681                	li	a3,0
    1c28:	e4060be3          	beqz	a2,1a7e <strncpy+0x44>
    1c2c:	b7cd                	j	1c0e <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c2e:	468d                	li	a3,3
    1c30:	bd75                	j	1aec <strncpy+0xb2>
    1c32:	872a                	mv	a4,a0
    1c34:	4681                	li	a3,0
    1c36:	bd5d                	j	1aec <strncpy+0xb2>
    1c38:	4685                	li	a3,1
    1c3a:	bd4d                	j	1aec <strncpy+0xb2>
    1c3c:	8082                	ret
    1c3e:	87aa                	mv	a5,a0
    1c40:	4681                	li	a3,0
    1c42:	b5f9                	j	1b10 <strncpy+0xd6>
    1c44:	4689                	li	a3,2
    1c46:	b55d                	j	1aec <strncpy+0xb2>
    1c48:	4691                	li	a3,4
    1c4a:	b54d                	j	1aec <strncpy+0xb2>
    1c4c:	4695                	li	a3,5
    1c4e:	bd79                	j	1aec <strncpy+0xb2>
    1c50:	4699                	li	a3,6
    1c52:	bd69                	j	1aec <strncpy+0xb2>
    1c54:	8082                	ret
    1c56:	8082                	ret
    1c58:	8082                	ret

0000000000001c5a <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c5a:	87aa                	mv	a5,a0
    1c5c:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c5e:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c62:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c66:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c68:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6a:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c6e:	2501                	sext.w	a0,a0
    1c70:	8082                	ret

0000000000001c72 <openat>:
    register long a7 __asm__("a7") = n;
    1c72:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c76:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c7a:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <close>:
    register long a7 __asm__("a7") = n;
    1c82:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c86:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <read>:
    register long a7 __asm__("a7") = n;
    1c8e:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c92:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c96:	8082                	ret

0000000000001c98 <write>:
    register long a7 __asm__("a7") = n;
    1c98:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c9c:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ca0:	8082                	ret

0000000000001ca2 <getpid>:
    register long a7 __asm__("a7") = n;
    1ca2:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1ca6:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1caa:	2501                	sext.w	a0,a0
    1cac:	8082                	ret

0000000000001cae <getppid>:
    register long a7 __asm__("a7") = n;
    1cae:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cb2:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cba:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cbe:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <fork>:
    register long a7 __asm__("a7") = n;
    1cc6:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cca:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ccc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cce:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cd2:	2501                	sext.w	a0,a0
    1cd4:	8082                	ret

0000000000001cd6 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cd6:	85b2                	mv	a1,a2
    1cd8:	863a                	mv	a2,a4
    if (stack)
    1cda:	c191                	beqz	a1,1cde <clone+0x8>
	stack += stack_size;
    1cdc:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cde:	4781                	li	a5,0
    1ce0:	4701                	li	a4,0
    1ce2:	4681                	li	a3,0
    1ce4:	2601                	sext.w	a2,a2
    1ce6:	a2ed                	j	1ed0 <__clone>

0000000000001ce8 <exit>:
    register long a7 __asm__("a7") = n;
    1ce8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cf0:	8082                	ret

0000000000001cf2 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cf2:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cf6:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cf8:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cfc:	2501                	sext.w	a0,a0
    1cfe:	8082                	ret

0000000000001d00 <exec>:
    register long a7 __asm__("a7") = n;
    1d00:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d04:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <execve>:
    register long a7 __asm__("a7") = n;
    1d0c:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d10:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <times>:
    register long a7 __asm__("a7") = n;
    1d18:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d1c:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d20:	2501                	sext.w	a0,a0
    1d22:	8082                	ret

0000000000001d24 <get_time>:

int64 get_time()
{
    1d24:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d26:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d2a:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d2c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d2e:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d32:	2501                	sext.w	a0,a0
    1d34:	ed09                	bnez	a0,1d4e <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d36:	67a2                	ld	a5,8(sp)
    1d38:	3e800713          	li	a4,1000
    1d3c:	00015503          	lhu	a0,0(sp)
    1d40:	02e7d7b3          	divu	a5,a5,a4
    1d44:	02e50533          	mul	a0,a0,a4
    1d48:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d4a:	0141                	addi	sp,sp,16
    1d4c:	8082                	ret
        return -1;
    1d4e:	557d                	li	a0,-1
    1d50:	bfed                	j	1d4a <get_time+0x26>

0000000000001d52 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d52:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d56:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d5a:	2501                	sext.w	a0,a0
    1d5c:	8082                	ret

0000000000001d5e <time>:
    register long a7 __asm__("a7") = n;
    1d5e:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d62:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d66:	2501                	sext.w	a0,a0
    1d68:	8082                	ret

0000000000001d6a <sleep>:

int sleep(unsigned long long time)
{
    1d6a:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d6c:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d6e:	850a                	mv	a0,sp
    1d70:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d72:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d76:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d78:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d7c:	e501                	bnez	a0,1d84 <sleep+0x1a>
    return 0;
    1d7e:	4501                	li	a0,0
}
    1d80:	0141                	addi	sp,sp,16
    1d82:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d84:	4502                	lw	a0,0(sp)
}
    1d86:	0141                	addi	sp,sp,16
    1d88:	8082                	ret

0000000000001d8a <set_priority>:
    register long a7 __asm__("a7") = n;
    1d8a:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d8e:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d92:	2501                	sext.w	a0,a0
    1d94:	8082                	ret

0000000000001d96 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d96:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d9a:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d9e:	8082                	ret

0000000000001da0 <munmap>:
    register long a7 __asm__("a7") = n;
    1da0:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da4:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1da8:	2501                	sext.w	a0,a0
    1daa:	8082                	ret

0000000000001dac <wait>:

int wait(int *code)
{
    1dac:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dae:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1db2:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1db4:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1db6:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1db8:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <spawn>:
    register long a7 __asm__("a7") = n;
    1dc0:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dc4:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <mailread>:
    register long a7 __asm__("a7") = n;
    1dcc:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd0:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dd8:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ddc:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <fstat>:
    register long a7 __asm__("a7") = n;
    1de4:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de8:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1df0:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1df2:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1df6:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df8:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dfc:	2501                	sext.w	a0,a0
    1dfe:	8082                	ret

0000000000001e00 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e00:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e02:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e06:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e08:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e0c:	2501                	sext.w	a0,a0
    1e0e:	8082                	ret

0000000000001e10 <link>:

int link(char *old_path, char *new_path)
{
    1e10:	87aa                	mv	a5,a0
    1e12:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e14:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e18:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e1c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e1e:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e22:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e24:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <unlink>:

int unlink(char *path)
{
    1e2c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e2e:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e32:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e36:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e38:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e3c:	2501                	sext.w	a0,a0
    1e3e:	8082                	ret

0000000000001e40 <uname>:
    register long a7 __asm__("a7") = n;
    1e40:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e44:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e48:	2501                	sext.w	a0,a0
    1e4a:	8082                	ret

0000000000001e4c <brk>:
    register long a7 __asm__("a7") = n;
    1e4c:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e50:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e58:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e5a:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e5e:	8082                	ret

0000000000001e60 <chdir>:
    register long a7 __asm__("a7") = n;
    1e60:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e64:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e6c:	862e                	mv	a2,a1
    1e6e:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e70:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e72:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e76:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e7a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e7c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7e:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e82:	2501                	sext.w	a0,a0
    1e84:	8082                	ret

0000000000001e86 <getdents>:
    register long a7 __asm__("a7") = n;
    1e86:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8a:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <pipe>:
    register long a7 __asm__("a7") = n;
    1e92:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e96:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e98:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e9c:	2501                	sext.w	a0,a0
    1e9e:	8082                	ret

0000000000001ea0 <dup>:
    register long a7 __asm__("a7") = n;
    1ea0:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ea2:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <dup2>:
    register long a7 __asm__("a7") = n;
    1eaa:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eac:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eae:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <mount>:
    register long a7 __asm__("a7") = n;
    1eb6:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eba:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ebe:	2501                	sext.w	a0,a0
    1ec0:	8082                	ret

0000000000001ec2 <umount>:
    register long a7 __asm__("a7") = n;
    1ec2:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ec6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ec8:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ecc:	2501                	sext.w	a0,a0
    1ece:	8082                	ret

0000000000001ed0 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ed0:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ed2:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ed4:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ed6:	8532                	mv	a0,a2
	mv a2, a4
    1ed8:	863a                	mv	a2,a4
	mv a3, a5
    1eda:	86be                	mv	a3,a5
	mv a4, a6
    1edc:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ede:	0dc00893          	li	a7,220
	ecall
    1ee2:	00000073          	ecall

	beqz a0, 1f
    1ee6:	c111                	beqz	a0,1eea <__clone+0x1a>
	# Parent
	ret
    1ee8:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eea:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1eec:	6522                	ld	a0,8(sp)
	jalr a1
    1eee:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ef0:	05d00893          	li	a7,93
	ecall
    1ef4:	00000073          	ecall
