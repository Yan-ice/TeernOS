
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/dup2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a871                	j	109e <__start_main>

0000000000001004 <test_dup2>:

/*
 * 测试通过时应输出：
 * "  from fd 100"
 */
void test_dup2(){
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eda50513          	addi	a0,a0,-294 # 1ee0 <__clone+0x2e>
void test_dup2(){
    100e:	e406                	sd	ra,8(sp)
	TEST_START(__func__);
    1010:	2c6000ef          	jal	ra,12d6 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f5450513          	addi	a0,a0,-172 # 1f68 <__func__.1191>
    101c:	2ba000ef          	jal	ra,12d6 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ed850513          	addi	a0,a0,-296 # 1ef8 <__clone+0x46>
    1028:	2ae000ef          	jal	ra,12d6 <puts>
	int fd = dup2(STDOUT, 100);
    102c:	06400593          	li	a1,100
    1030:	4505                	li	a0,1
    1032:	65b000ef          	jal	ra,1e8c <dup2>
	assert(fd != -1);
    1036:	57fd                	li	a5,-1
    1038:	04f50463          	beq	a0,a5,1080 <test_dup2+0x7c>
	const char *str = "  from fd 100\n";
	write(100, str, strlen(str));
    103c:	00001517          	auipc	a0,0x1
    1040:	eec50513          	addi	a0,a0,-276 # 1f28 <__clone+0x76>
    1044:	053000ef          	jal	ra,1896 <strlen>
    1048:	862a                	mv	a2,a0
    104a:	00001597          	auipc	a1,0x1
    104e:	ede58593          	addi	a1,a1,-290 # 1f28 <__clone+0x76>
    1052:	06400513          	li	a0,100
    1056:	425000ef          	jal	ra,1c7a <write>
	TEST_END(__func__);
    105a:	00001517          	auipc	a0,0x1
    105e:	ede50513          	addi	a0,a0,-290 # 1f38 <__clone+0x86>
    1062:	274000ef          	jal	ra,12d6 <puts>
    1066:	00001517          	auipc	a0,0x1
    106a:	f0250513          	addi	a0,a0,-254 # 1f68 <__func__.1191>
    106e:	268000ef          	jal	ra,12d6 <puts>
}
    1072:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    1074:	00001517          	auipc	a0,0x1
    1078:	e8450513          	addi	a0,a0,-380 # 1ef8 <__clone+0x46>
}
    107c:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    107e:	aca1                	j	12d6 <puts>
	assert(fd != -1);
    1080:	00001517          	auipc	a0,0x1
    1084:	e8850513          	addi	a0,a0,-376 # 1f08 <__clone+0x56>
    1088:	530000ef          	jal	ra,15b8 <panic>
    108c:	bf45                	j	103c <test_dup2+0x38>

000000000000108e <main>:

int main(void) {
    108e:	1141                	addi	sp,sp,-16
    1090:	e406                	sd	ra,8(sp)
	test_dup2();
    1092:	f73ff0ef          	jal	ra,1004 <test_dup2>
	return 0;
}
    1096:	60a2                	ld	ra,8(sp)
    1098:	4501                	li	a0,0
    109a:	0141                	addi	sp,sp,16
    109c:	8082                	ret

000000000000109e <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    109e:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10a0:	4108                	lw	a0,0(a0)
{
    10a2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10a4:	05a1                	addi	a1,a1,8
{
    10a6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10a8:	fe7ff0ef          	jal	ra,108e <main>
    10ac:	41f000ef          	jal	ra,1cca <exit>
	return 0;
}
    10b0:	60a2                	ld	ra,8(sp)
    10b2:	4501                	li	a0,0
    10b4:	0141                	addi	sp,sp,16
    10b6:	8082                	ret

00000000000010b8 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10b8:	7179                	addi	sp,sp,-48
    10ba:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10bc:	12054b63          	bltz	a0,11f2 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10c0:	02b577bb          	remuw	a5,a0,a1
    10c4:	00001697          	auipc	a3,0x1
    10c8:	eb468693          	addi	a3,a3,-332 # 1f78 <digits>
    buf[16] = 0;
    10cc:	00010c23          	sb	zero,24(sp)
    i = 15;
    10d0:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10d4:	1782                	slli	a5,a5,0x20
    10d6:	9381                	srli	a5,a5,0x20
    10d8:	97b6                	add	a5,a5,a3
    10da:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10de:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10e2:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10e6:	16b56263          	bltu	a0,a1,124a <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10ea:	02e8763b          	remuw	a2,a6,a4
    10ee:	1602                	slli	a2,a2,0x20
    10f0:	9201                	srli	a2,a2,0x20
    10f2:	9636                	add	a2,a2,a3
    10f4:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    10f8:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    10fc:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1100:	12e86963          	bltu	a6,a4,1232 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1104:	02e5f63b          	remuw	a2,a1,a4
    1108:	1602                	slli	a2,a2,0x20
    110a:	9201                	srli	a2,a2,0x20
    110c:	9636                	add	a2,a2,a3
    110e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1112:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1116:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    111a:	10e5ef63          	bltu	a1,a4,1238 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    111e:	02e8763b          	remuw	a2,a6,a4
    1122:	1602                	slli	a2,a2,0x20
    1124:	9201                	srli	a2,a2,0x20
    1126:	9636                	add	a2,a2,a3
    1128:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    112c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1130:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1134:	10e86563          	bltu	a6,a4,123e <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1138:	02e5f63b          	remuw	a2,a1,a4
    113c:	1602                	slli	a2,a2,0x20
    113e:	9201                	srli	a2,a2,0x20
    1140:	9636                	add	a2,a2,a3
    1142:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1146:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    114a:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    114e:	0ee5eb63          	bltu	a1,a4,1244 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1152:	02e8763b          	remuw	a2,a6,a4
    1156:	1602                	slli	a2,a2,0x20
    1158:	9201                	srli	a2,a2,0x20
    115a:	9636                	add	a2,a2,a3
    115c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1160:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1164:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1168:	0ce86263          	bltu	a6,a4,122c <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    116c:	02e5f63b          	remuw	a2,a1,a4
    1170:	1602                	slli	a2,a2,0x20
    1172:	9201                	srli	a2,a2,0x20
    1174:	9636                	add	a2,a2,a3
    1176:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    117a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    117e:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    1182:	0ce5e663          	bltu	a1,a4,124e <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    1186:	02e8763b          	remuw	a2,a6,a4
    118a:	1602                	slli	a2,a2,0x20
    118c:	9201                	srli	a2,a2,0x20
    118e:	9636                	add	a2,a2,a3
    1190:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1194:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1198:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    119c:	0ae86c63          	bltu	a6,a4,1254 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11a0:	02e5f63b          	remuw	a2,a1,a4
    11a4:	1602                	slli	a2,a2,0x20
    11a6:	9201                	srli	a2,a2,0x20
    11a8:	9636                	add	a2,a2,a3
    11aa:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11ae:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11b2:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11b6:	0ae5e263          	bltu	a1,a4,125a <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11ba:	1782                	slli	a5,a5,0x20
    11bc:	9381                	srli	a5,a5,0x20
    11be:	97b6                	add	a5,a5,a3
    11c0:	0007c703          	lbu	a4,0(a5)
    11c4:	4599                	li	a1,6
    11c6:	4795                	li	a5,5
    11c8:	00e10723          	sb	a4,14(sp)

    if (sign)
    11cc:	00055963          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    11d0:	1018                	addi	a4,sp,32
    11d2:	973e                	add	a4,a4,a5
    11d4:	02d00693          	li	a3,45
    11d8:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11dc:	85be                	mv	a1,a5
    write(f, s, l);
    11de:	003c                	addi	a5,sp,8
    11e0:	4641                	li	a2,16
    11e2:	9e0d                	subw	a2,a2,a1
    11e4:	4505                	li	a0,1
    11e6:	95be                	add	a1,a1,a5
    11e8:	293000ef          	jal	ra,1c7a <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11ec:	70a2                	ld	ra,40(sp)
    11ee:	6145                	addi	sp,sp,48
    11f0:	8082                	ret
        x = -xx;
    11f2:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    11f6:	02b677bb          	remuw	a5,a2,a1
    11fa:	00001697          	auipc	a3,0x1
    11fe:	d7e68693          	addi	a3,a3,-642 # 1f78 <digits>
    buf[16] = 0;
    1202:	00010c23          	sb	zero,24(sp)
    i = 15;
    1206:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    120a:	1782                	slli	a5,a5,0x20
    120c:	9381                	srli	a5,a5,0x20
    120e:	97b6                	add	a5,a5,a3
    1210:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1214:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1218:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    121c:	ecb677e3          	bgeu	a2,a1,10ea <printint.constprop.0+0x32>
        buf[i--] = '-';
    1220:	02d00793          	li	a5,45
    1224:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1228:	45b9                	li	a1,14
    122a:	bf55                	j	11de <printint.constprop.0+0x126>
    122c:	47a5                	li	a5,9
    122e:	45a9                	li	a1,10
    1230:	bf71                	j	11cc <printint.constprop.0+0x114>
    1232:	47b5                	li	a5,13
    1234:	45b9                	li	a1,14
    1236:	bf59                	j	11cc <printint.constprop.0+0x114>
    1238:	47b1                	li	a5,12
    123a:	45b5                	li	a1,13
    123c:	bf41                	j	11cc <printint.constprop.0+0x114>
    123e:	47ad                	li	a5,11
    1240:	45b1                	li	a1,12
    1242:	b769                	j	11cc <printint.constprop.0+0x114>
    1244:	47a9                	li	a5,10
    1246:	45ad                	li	a1,11
    1248:	b751                	j	11cc <printint.constprop.0+0x114>
    i = 15;
    124a:	45bd                	li	a1,15
    124c:	bf49                	j	11de <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    124e:	47a1                	li	a5,8
    1250:	45a5                	li	a1,9
    1252:	bfad                	j	11cc <printint.constprop.0+0x114>
    1254:	479d                	li	a5,7
    1256:	45a1                	li	a1,8
    1258:	bf95                	j	11cc <printint.constprop.0+0x114>
    125a:	4799                	li	a5,6
    125c:	459d                	li	a1,7
    125e:	b7bd                	j	11cc <printint.constprop.0+0x114>

0000000000001260 <getchar>:
{
    1260:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1262:	00f10593          	addi	a1,sp,15
    1266:	4605                	li	a2,1
    1268:	4501                	li	a0,0
{
    126a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    126c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1270:	201000ef          	jal	ra,1c70 <read>
}
    1274:	60e2                	ld	ra,24(sp)
    1276:	00f14503          	lbu	a0,15(sp)
    127a:	6105                	addi	sp,sp,32
    127c:	8082                	ret

000000000000127e <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    127e:	00001797          	auipc	a5,0x1
    1282:	d1278793          	addi	a5,a5,-750 # 1f90 <digits+0x18>
    1286:	04000893          	li	a7,64
    128a:	4505                	li	a0,1
    128c:	85be                	mv	a1,a5
    128e:	4611                	li	a2,4
    1290:	00000073          	ecall
}
    1294:	4501                	li	a0,0
    1296:	8082                	ret

0000000000001298 <putchar>:
{
    1298:	1101                	addi	sp,sp,-32
    129a:	ec06                	sd	ra,24(sp)
    129c:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    129e:	3e700893          	li	a7,999
    12a2:	4505                	li	a0,1
    12a4:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12a8:	00001717          	auipc	a4,0x1
    12ac:	ce870713          	addi	a4,a4,-792 # 1f90 <digits+0x18>
    12b0:	04000893          	li	a7,64
    12b4:	4505                	li	a0,1
    12b6:	85ba                	mv	a1,a4
    12b8:	4611                	li	a2,4
    12ba:	00000073          	ecall
    return write(stdout, &byte, 1);
    12be:	4605                	li	a2,1
    12c0:	00f10593          	addi	a1,sp,15
    12c4:	4505                	li	a0,1
    char byte = c;
    12c6:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12ca:	1b1000ef          	jal	ra,1c7a <write>
}
    12ce:	60e2                	ld	ra,24(sp)
    12d0:	2501                	sext.w	a0,a0
    12d2:	6105                	addi	sp,sp,32
    12d4:	8082                	ret

00000000000012d6 <puts>:
{
    12d6:	1141                	addi	sp,sp,-16
    12d8:	e406                	sd	ra,8(sp)
    12da:	e022                	sd	s0,0(sp)
    12dc:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12de:	5b8000ef          	jal	ra,1896 <strlen>
    12e2:	862a                	mv	a2,a0
    12e4:	85a2                	mv	a1,s0
    12e6:	4505                	li	a0,1
    12e8:	193000ef          	jal	ra,1c7a <write>
}
    12ec:	60a2                	ld	ra,8(sp)
    12ee:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12f0:	957d                	srai	a0,a0,0x3f
    return r;
    12f2:	2501                	sext.w	a0,a0
}
    12f4:	0141                	addi	sp,sp,16
    12f6:	8082                	ret

00000000000012f8 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12f8:	7171                	addi	sp,sp,-176
    12fa:	e0d2                	sd	s4,64(sp)
    12fc:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    12fe:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1300:	18bc                	addi	a5,sp,120
{
    1302:	e8ca                	sd	s2,80(sp)
    1304:	e4ce                	sd	s3,72(sp)
    1306:	fc56                	sd	s5,56(sp)
    1308:	f85a                	sd	s6,48(sp)
    130a:	f486                	sd	ra,104(sp)
    130c:	f0a2                	sd	s0,96(sp)
    130e:	eca6                	sd	s1,88(sp)
    1310:	fcae                	sd	a1,120(sp)
    1312:	e132                	sd	a2,128(sp)
    1314:	e536                	sd	a3,136(sp)
    1316:	e93a                	sd	a4,144(sp)
    1318:	f142                	sd	a6,160(sp)
    131a:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    131c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    131e:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1322:	00001b17          	auipc	s6,0x1
    1326:	c26b0b13          	addi	s6,s6,-986 # 1f48 <__clone+0x96>
	::"r"((unsigned long long)ac)
    132a:	00001a97          	auipc	s5,0x1
    132e:	c66a8a93          	addi	s5,s5,-922 # 1f90 <digits+0x18>
    buf[i++] = '0';
    1332:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1336:	00001997          	auipc	s3,0x1
    133a:	c4298993          	addi	s3,s3,-958 # 1f78 <digits>
        if (!*s)
    133e:	00054783          	lbu	a5,0(a0)
    1342:	16078c63          	beqz	a5,14ba <printf+0x1c2>
    1346:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1348:	19278363          	beq	a5,s2,14ce <printf+0x1d6>
    134c:	00164783          	lbu	a5,1(a2)
    1350:	0605                	addi	a2,a2,1
    1352:	fbfd                	bnez	a5,1348 <printf+0x50>
    1354:	84b2                	mv	s1,a2
        l = z - a;
    1356:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    135a:	85aa                	mv	a1,a0
    135c:	8622                	mv	a2,s0
    135e:	4505                	li	a0,1
    1360:	11b000ef          	jal	ra,1c7a <write>
        if (l)
    1364:	18041e63          	bnez	s0,1500 <printf+0x208>
        if (s[1] == 0)
    1368:	0014c783          	lbu	a5,1(s1)
    136c:	14078763          	beqz	a5,14ba <printf+0x1c2>
        switch (s[1])
    1370:	07300713          	li	a4,115
    1374:	1ce78063          	beq	a5,a4,1534 <printf+0x23c>
    1378:	18f76663          	bltu	a4,a5,1504 <printf+0x20c>
    137c:	06400713          	li	a4,100
    1380:	1ae78063          	beq	a5,a4,1520 <printf+0x228>
    1384:	07000713          	li	a4,112
    1388:	1ce79963          	bne	a5,a4,155a <printf+0x262>
            printptr(va_arg(ap, uint64));
    138c:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    138e:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    1392:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    1394:	631c                	ld	a5,0(a4)
    1396:	0721                	addi	a4,a4,8
    1398:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    139a:	00479293          	slli	t0,a5,0x4
    139e:	00879f93          	slli	t6,a5,0x8
    13a2:	00c79f13          	slli	t5,a5,0xc
    13a6:	01079e93          	slli	t4,a5,0x10
    13aa:	01479e13          	slli	t3,a5,0x14
    13ae:	01879313          	slli	t1,a5,0x18
    13b2:	01c79893          	slli	a7,a5,0x1c
    13b6:	02479813          	slli	a6,a5,0x24
    13ba:	02879513          	slli	a0,a5,0x28
    13be:	02c79593          	slli	a1,a5,0x2c
    13c2:	03079693          	slli	a3,a5,0x30
    13c6:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13ca:	03c7d413          	srli	s0,a5,0x3c
    13ce:	01c7d39b          	srliw	t2,a5,0x1c
    13d2:	03c2d293          	srli	t0,t0,0x3c
    13d6:	03cfdf93          	srli	t6,t6,0x3c
    13da:	03cf5f13          	srli	t5,t5,0x3c
    13de:	03cede93          	srli	t4,t4,0x3c
    13e2:	03ce5e13          	srli	t3,t3,0x3c
    13e6:	03c35313          	srli	t1,t1,0x3c
    13ea:	03c8d893          	srli	a7,a7,0x3c
    13ee:	03c85813          	srli	a6,a6,0x3c
    13f2:	9171                	srli	a0,a0,0x3c
    13f4:	91f1                	srli	a1,a1,0x3c
    13f6:	92f1                	srli	a3,a3,0x3c
    13f8:	9371                	srli	a4,a4,0x3c
    13fa:	96ce                	add	a3,a3,s3
    13fc:	974e                	add	a4,a4,s3
    13fe:	944e                	add	s0,s0,s3
    1400:	92ce                	add	t0,t0,s3
    1402:	9fce                	add	t6,t6,s3
    1404:	9f4e                	add	t5,t5,s3
    1406:	9ece                	add	t4,t4,s3
    1408:	9e4e                	add	t3,t3,s3
    140a:	934e                	add	t1,t1,s3
    140c:	98ce                	add	a7,a7,s3
    140e:	93ce                	add	t2,t2,s3
    1410:	984e                	add	a6,a6,s3
    1412:	954e                	add	a0,a0,s3
    1414:	95ce                	add	a1,a1,s3
    1416:	0006c083          	lbu	ra,0(a3)
    141a:	0002c283          	lbu	t0,0(t0)
    141e:	00074683          	lbu	a3,0(a4)
    1422:	000fcf83          	lbu	t6,0(t6)
    1426:	000f4f03          	lbu	t5,0(t5)
    142a:	000ece83          	lbu	t4,0(t4)
    142e:	000e4e03          	lbu	t3,0(t3)
    1432:	00034303          	lbu	t1,0(t1)
    1436:	0008c883          	lbu	a7,0(a7)
    143a:	0003c383          	lbu	t2,0(t2)
    143e:	00084803          	lbu	a6,0(a6)
    1442:	00054503          	lbu	a0,0(a0)
    1446:	0005c583          	lbu	a1,0(a1)
    144a:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    144e:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1452:	9371                	srli	a4,a4,0x3c
    1454:	8bbd                	andi	a5,a5,15
    1456:	974e                	add	a4,a4,s3
    1458:	97ce                	add	a5,a5,s3
    145a:	005105a3          	sb	t0,11(sp)
    145e:	01f10623          	sb	t6,12(sp)
    1462:	01e106a3          	sb	t5,13(sp)
    1466:	01d10723          	sb	t4,14(sp)
    146a:	01c107a3          	sb	t3,15(sp)
    146e:	00610823          	sb	t1,16(sp)
    1472:	011108a3          	sb	a7,17(sp)
    1476:	00710923          	sb	t2,18(sp)
    147a:	010109a3          	sb	a6,19(sp)
    147e:	00a10a23          	sb	a0,20(sp)
    1482:	00b10aa3          	sb	a1,21(sp)
    1486:	00110b23          	sb	ra,22(sp)
    148a:	00d10ba3          	sb	a3,23(sp)
    148e:	00810523          	sb	s0,10(sp)
    1492:	00074703          	lbu	a4,0(a4)
    1496:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    149a:	002c                	addi	a1,sp,8
    149c:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    149e:	00e10c23          	sb	a4,24(sp)
    14a2:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14a6:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14aa:	7d0000ef          	jal	ra,1c7a <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14ae:	00248513          	addi	a0,s1,2
        if (!*s)
    14b2:	00054783          	lbu	a5,0(a0)
    14b6:	e80798e3          	bnez	a5,1346 <printf+0x4e>
    }
    va_end(ap);
}
    14ba:	70a6                	ld	ra,104(sp)
    14bc:	7406                	ld	s0,96(sp)
    14be:	64e6                	ld	s1,88(sp)
    14c0:	6946                	ld	s2,80(sp)
    14c2:	69a6                	ld	s3,72(sp)
    14c4:	6a06                	ld	s4,64(sp)
    14c6:	7ae2                	ld	s5,56(sp)
    14c8:	7b42                	ld	s6,48(sp)
    14ca:	614d                	addi	sp,sp,176
    14cc:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14ce:	00064783          	lbu	a5,0(a2)
    14d2:	84b2                	mv	s1,a2
    14d4:	01278963          	beq	a5,s2,14e6 <printf+0x1ee>
    14d8:	bdbd                	j	1356 <printf+0x5e>
    14da:	0024c783          	lbu	a5,2(s1)
    14de:	0605                	addi	a2,a2,1
    14e0:	0489                	addi	s1,s1,2
    14e2:	e7279ae3          	bne	a5,s2,1356 <printf+0x5e>
    14e6:	0014c783          	lbu	a5,1(s1)
    14ea:	ff2788e3          	beq	a5,s2,14da <printf+0x1e2>
        l = z - a;
    14ee:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14f2:	85aa                	mv	a1,a0
    14f4:	8622                	mv	a2,s0
    14f6:	4505                	li	a0,1
    14f8:	782000ef          	jal	ra,1c7a <write>
        if (l)
    14fc:	e60406e3          	beqz	s0,1368 <printf+0x70>
    1500:	8526                	mv	a0,s1
    1502:	bd35                	j	133e <printf+0x46>
        switch (s[1])
    1504:	07800713          	li	a4,120
    1508:	04e79963          	bne	a5,a4,155a <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    150c:	6782                	ld	a5,0(sp)
    150e:	45c1                	li	a1,16
    1510:	4388                	lw	a0,0(a5)
    1512:	07a1                	addi	a5,a5,8
    1514:	e03e                	sd	a5,0(sp)
    1516:	ba3ff0ef          	jal	ra,10b8 <printint.constprop.0>
        s += 2;
    151a:	00248513          	addi	a0,s1,2
    151e:	bf51                	j	14b2 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1520:	6782                	ld	a5,0(sp)
    1522:	45a9                	li	a1,10
    1524:	4388                	lw	a0,0(a5)
    1526:	07a1                	addi	a5,a5,8
    1528:	e03e                	sd	a5,0(sp)
    152a:	b8fff0ef          	jal	ra,10b8 <printint.constprop.0>
        s += 2;
    152e:	00248513          	addi	a0,s1,2
    1532:	b741                	j	14b2 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1534:	6782                	ld	a5,0(sp)
    1536:	6380                	ld	s0,0(a5)
    1538:	07a1                	addi	a5,a5,8
    153a:	e03e                	sd	a5,0(sp)
    153c:	cc25                	beqz	s0,15b4 <printf+0x2bc>
            l = strnlen(a, 200);
    153e:	0c800593          	li	a1,200
    1542:	8522                	mv	a0,s0
    1544:	43e000ef          	jal	ra,1982 <strnlen>
    write(f, s, l);
    1548:	0005061b          	sext.w	a2,a0
    154c:	85a2                	mv	a1,s0
    154e:	4505                	li	a0,1
    1550:	72a000ef          	jal	ra,1c7a <write>
        s += 2;
    1554:	00248513          	addi	a0,s1,2
    1558:	bfa9                	j	14b2 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    155a:	3e700893          	li	a7,999
    155e:	4505                	li	a0,1
    1560:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1564:	04000893          	li	a7,64
    1568:	4505                	li	a0,1
    156a:	85d6                	mv	a1,s5
    156c:	4611                	li	a2,4
    156e:	00000073          	ecall
    char byte = c;
    1572:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1576:	4605                	li	a2,1
    1578:	002c                	addi	a1,sp,8
    157a:	4505                	li	a0,1
    char byte = c;
    157c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1580:	6fa000ef          	jal	ra,1c7a <write>
            putchar(s[1]);
    1584:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1588:	3e700893          	li	a7,999
    158c:	4505                	li	a0,1
    158e:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1592:	04000893          	li	a7,64
    1596:	4505                	li	a0,1
    1598:	85d6                	mv	a1,s5
    159a:	4611                	li	a2,4
    159c:	00000073          	ecall
    return write(stdout, &byte, 1);
    15a0:	4605                	li	a2,1
    15a2:	002c                	addi	a1,sp,8
    15a4:	4505                	li	a0,1
    char byte = c;
    15a6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15aa:	6d0000ef          	jal	ra,1c7a <write>
        s += 2;
    15ae:	00248513          	addi	a0,s1,2
    15b2:	b701                	j	14b2 <printf+0x1ba>
                a = "(null)";
    15b4:	845a                	mv	s0,s6
    15b6:	b761                	j	153e <printf+0x246>

00000000000015b8 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15b8:	1141                	addi	sp,sp,-16
    15ba:	e406                	sd	ra,8(sp)
    puts(m);
    15bc:	d1bff0ef          	jal	ra,12d6 <puts>
    exit(-100);
}
    15c0:	60a2                	ld	ra,8(sp)
    exit(-100);
    15c2:	f9c00513          	li	a0,-100
}
    15c6:	0141                	addi	sp,sp,16
    exit(-100);
    15c8:	a709                	j	1cca <exit>

00000000000015ca <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ca:	02000793          	li	a5,32
    15ce:	00f50663          	beq	a0,a5,15da <isspace+0x10>
    15d2:	355d                	addiw	a0,a0,-9
    15d4:	00553513          	sltiu	a0,a0,5
    15d8:	8082                	ret
    15da:	4505                	li	a0,1
}
    15dc:	8082                	ret

00000000000015de <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15de:	fd05051b          	addiw	a0,a0,-48
}
    15e2:	00a53513          	sltiu	a0,a0,10
    15e6:	8082                	ret

00000000000015e8 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e8:	02000613          	li	a2,32
    15ec:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15ee:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f2:	ff77069b          	addiw	a3,a4,-9
    15f6:	04c70d63          	beq	a4,a2,1650 <atoi+0x68>
    15fa:	0007079b          	sext.w	a5,a4
    15fe:	04d5f963          	bgeu	a1,a3,1650 <atoi+0x68>
        s++;
    switch (*s)
    1602:	02b00693          	li	a3,43
    1606:	04d70a63          	beq	a4,a3,165a <atoi+0x72>
    160a:	02d00693          	li	a3,45
    160e:	06d70463          	beq	a4,a3,1676 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1612:	fd07859b          	addiw	a1,a5,-48
    1616:	4625                	li	a2,9
    1618:	873e                	mv	a4,a5
    161a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    161c:	4e01                	li	t3,0
    while (isdigit(*s))
    161e:	04b66a63          	bltu	a2,a1,1672 <atoi+0x8a>
    int n = 0, neg = 0;
    1622:	4501                	li	a0,0
    while (isdigit(*s))
    1624:	4825                	li	a6,9
    1626:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    162a:	0025179b          	slliw	a5,a0,0x2
    162e:	9d3d                	addw	a0,a0,a5
    1630:	fd07031b          	addiw	t1,a4,-48
    1634:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1638:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    163c:	0685                	addi	a3,a3,1
    163e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1642:	0006071b          	sext.w	a4,a2
    1646:	feb870e3          	bgeu	a6,a1,1626 <atoi+0x3e>
    return neg ? n : -n;
    164a:	000e0563          	beqz	t3,1654 <atoi+0x6c>
}
    164e:	8082                	ret
        s++;
    1650:	0505                	addi	a0,a0,1
    1652:	bf71                	j	15ee <atoi+0x6>
    1654:	4113053b          	subw	a0,t1,a7
    1658:	8082                	ret
    while (isdigit(*s))
    165a:	00154783          	lbu	a5,1(a0)
    165e:	4625                	li	a2,9
        s++;
    1660:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1664:	fd07859b          	addiw	a1,a5,-48
    1668:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    166c:	4e01                	li	t3,0
    while (isdigit(*s))
    166e:	fab67ae3          	bgeu	a2,a1,1622 <atoi+0x3a>
    1672:	4501                	li	a0,0
}
    1674:	8082                	ret
    while (isdigit(*s))
    1676:	00154783          	lbu	a5,1(a0)
    167a:	4625                	li	a2,9
        s++;
    167c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1680:	fd07859b          	addiw	a1,a5,-48
    1684:	0007871b          	sext.w	a4,a5
    1688:	feb665e3          	bltu	a2,a1,1672 <atoi+0x8a>
        neg = 1;
    168c:	4e05                	li	t3,1
    168e:	bf51                	j	1622 <atoi+0x3a>

0000000000001690 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1690:	16060d63          	beqz	a2,180a <memset+0x17a>
    1694:	40a007b3          	neg	a5,a0
    1698:	8b9d                	andi	a5,a5,7
    169a:	00778713          	addi	a4,a5,7
    169e:	482d                	li	a6,11
    16a0:	0ff5f593          	zext.b	a1,a1
    16a4:	fff60693          	addi	a3,a2,-1
    16a8:	17076263          	bltu	a4,a6,180c <memset+0x17c>
    16ac:	16e6ea63          	bltu	a3,a4,1820 <memset+0x190>
    16b0:	16078563          	beqz	a5,181a <memset+0x18a>
    16b4:	00b50023          	sb	a1,0(a0)
    16b8:	4705                	li	a4,1
    16ba:	00150e93          	addi	t4,a0,1
    16be:	14e78c63          	beq	a5,a4,1816 <memset+0x186>
    16c2:	00b500a3          	sb	a1,1(a0)
    16c6:	4709                	li	a4,2
    16c8:	00250e93          	addi	t4,a0,2
    16cc:	14e78d63          	beq	a5,a4,1826 <memset+0x196>
    16d0:	00b50123          	sb	a1,2(a0)
    16d4:	470d                	li	a4,3
    16d6:	00350e93          	addi	t4,a0,3
    16da:	12e78b63          	beq	a5,a4,1810 <memset+0x180>
    16de:	00b501a3          	sb	a1,3(a0)
    16e2:	4711                	li	a4,4
    16e4:	00450e93          	addi	t4,a0,4
    16e8:	14e78163          	beq	a5,a4,182a <memset+0x19a>
    16ec:	00b50223          	sb	a1,4(a0)
    16f0:	4715                	li	a4,5
    16f2:	00550e93          	addi	t4,a0,5
    16f6:	12e78c63          	beq	a5,a4,182e <memset+0x19e>
    16fa:	00b502a3          	sb	a1,5(a0)
    16fe:	471d                	li	a4,7
    1700:	00650e93          	addi	t4,a0,6
    1704:	12e79763          	bne	a5,a4,1832 <memset+0x1a2>
    1708:	00750e93          	addi	t4,a0,7
    170c:	00b50323          	sb	a1,6(a0)
    1710:	4f1d                	li	t5,7
    1712:	00859713          	slli	a4,a1,0x8
    1716:	8f4d                	or	a4,a4,a1
    1718:	01059e13          	slli	t3,a1,0x10
    171c:	01c76e33          	or	t3,a4,t3
    1720:	01859313          	slli	t1,a1,0x18
    1724:	006e6333          	or	t1,t3,t1
    1728:	02059893          	slli	a7,a1,0x20
    172c:	011368b3          	or	a7,t1,a7
    1730:	02859813          	slli	a6,a1,0x28
    1734:	40f60333          	sub	t1,a2,a5
    1738:	0108e833          	or	a6,a7,a6
    173c:	03059693          	slli	a3,a1,0x30
    1740:	00d866b3          	or	a3,a6,a3
    1744:	03859713          	slli	a4,a1,0x38
    1748:	97aa                	add	a5,a5,a0
    174a:	ff837813          	andi	a6,t1,-8
    174e:	8f55                	or	a4,a4,a3
    1750:	00f806b3          	add	a3,a6,a5
    1754:	e398                	sd	a4,0(a5)
    1756:	07a1                	addi	a5,a5,8
    1758:	fed79ee3          	bne	a5,a3,1754 <memset+0xc4>
    175c:	ff837693          	andi	a3,t1,-8
    1760:	00de87b3          	add	a5,t4,a3
    1764:	01e6873b          	addw	a4,a3,t5
    1768:	0ad30663          	beq	t1,a3,1814 <memset+0x184>
    176c:	00b78023          	sb	a1,0(a5)
    1770:	0017069b          	addiw	a3,a4,1
    1774:	08c6fb63          	bgeu	a3,a2,180a <memset+0x17a>
    1778:	00b780a3          	sb	a1,1(a5)
    177c:	0027069b          	addiw	a3,a4,2
    1780:	08c6f563          	bgeu	a3,a2,180a <memset+0x17a>
    1784:	00b78123          	sb	a1,2(a5)
    1788:	0037069b          	addiw	a3,a4,3
    178c:	06c6ff63          	bgeu	a3,a2,180a <memset+0x17a>
    1790:	00b781a3          	sb	a1,3(a5)
    1794:	0047069b          	addiw	a3,a4,4
    1798:	06c6f963          	bgeu	a3,a2,180a <memset+0x17a>
    179c:	00b78223          	sb	a1,4(a5)
    17a0:	0057069b          	addiw	a3,a4,5
    17a4:	06c6f363          	bgeu	a3,a2,180a <memset+0x17a>
    17a8:	00b782a3          	sb	a1,5(a5)
    17ac:	0067069b          	addiw	a3,a4,6
    17b0:	04c6fd63          	bgeu	a3,a2,180a <memset+0x17a>
    17b4:	00b78323          	sb	a1,6(a5)
    17b8:	0077069b          	addiw	a3,a4,7
    17bc:	04c6f763          	bgeu	a3,a2,180a <memset+0x17a>
    17c0:	00b783a3          	sb	a1,7(a5)
    17c4:	0087069b          	addiw	a3,a4,8
    17c8:	04c6f163          	bgeu	a3,a2,180a <memset+0x17a>
    17cc:	00b78423          	sb	a1,8(a5)
    17d0:	0097069b          	addiw	a3,a4,9
    17d4:	02c6fb63          	bgeu	a3,a2,180a <memset+0x17a>
    17d8:	00b784a3          	sb	a1,9(a5)
    17dc:	00a7069b          	addiw	a3,a4,10
    17e0:	02c6f563          	bgeu	a3,a2,180a <memset+0x17a>
    17e4:	00b78523          	sb	a1,10(a5)
    17e8:	00b7069b          	addiw	a3,a4,11
    17ec:	00c6ff63          	bgeu	a3,a2,180a <memset+0x17a>
    17f0:	00b785a3          	sb	a1,11(a5)
    17f4:	00c7069b          	addiw	a3,a4,12
    17f8:	00c6f963          	bgeu	a3,a2,180a <memset+0x17a>
    17fc:	00b78623          	sb	a1,12(a5)
    1800:	2735                	addiw	a4,a4,13
    1802:	00c77463          	bgeu	a4,a2,180a <memset+0x17a>
    1806:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    180a:	8082                	ret
    180c:	472d                	li	a4,11
    180e:	bd79                	j	16ac <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1810:	4f0d                	li	t5,3
    1812:	b701                	j	1712 <memset+0x82>
    1814:	8082                	ret
    1816:	4f05                	li	t5,1
    1818:	bded                	j	1712 <memset+0x82>
    181a:	8eaa                	mv	t4,a0
    181c:	4f01                	li	t5,0
    181e:	bdd5                	j	1712 <memset+0x82>
    1820:	87aa                	mv	a5,a0
    1822:	4701                	li	a4,0
    1824:	b7a1                	j	176c <memset+0xdc>
    1826:	4f09                	li	t5,2
    1828:	b5ed                	j	1712 <memset+0x82>
    182a:	4f11                	li	t5,4
    182c:	b5dd                	j	1712 <memset+0x82>
    182e:	4f15                	li	t5,5
    1830:	b5cd                	j	1712 <memset+0x82>
    1832:	4f19                	li	t5,6
    1834:	bdf9                	j	1712 <memset+0x82>

0000000000001836 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1836:	00054783          	lbu	a5,0(a0)
    183a:	0005c703          	lbu	a4,0(a1)
    183e:	00e79863          	bne	a5,a4,184e <strcmp+0x18>
    1842:	0505                	addi	a0,a0,1
    1844:	0585                	addi	a1,a1,1
    1846:	fbe5                	bnez	a5,1836 <strcmp>
    1848:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    184a:	9d19                	subw	a0,a0,a4
    184c:	8082                	ret
    184e:	0007851b          	sext.w	a0,a5
    1852:	bfe5                	j	184a <strcmp+0x14>

0000000000001854 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1854:	ce05                	beqz	a2,188c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1856:	00054703          	lbu	a4,0(a0)
    185a:	0005c783          	lbu	a5,0(a1)
    185e:	cb0d                	beqz	a4,1890 <strncmp+0x3c>
    if (!n--)
    1860:	167d                	addi	a2,a2,-1
    1862:	00c506b3          	add	a3,a0,a2
    1866:	a819                	j	187c <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1868:	00a68e63          	beq	a3,a0,1884 <strncmp+0x30>
    186c:	0505                	addi	a0,a0,1
    186e:	00e79b63          	bne	a5,a4,1884 <strncmp+0x30>
    1872:	00054703          	lbu	a4,0(a0)
    1876:	0005c783          	lbu	a5,0(a1)
    187a:	cb19                	beqz	a4,1890 <strncmp+0x3c>
    187c:	0005c783          	lbu	a5,0(a1)
    1880:	0585                	addi	a1,a1,1
    1882:	f3fd                	bnez	a5,1868 <strncmp+0x14>
        ;
    return *l - *r;
    1884:	0007051b          	sext.w	a0,a4
    1888:	9d1d                	subw	a0,a0,a5
    188a:	8082                	ret
        return 0;
    188c:	4501                	li	a0,0
}
    188e:	8082                	ret
    1890:	4501                	li	a0,0
    return *l - *r;
    1892:	9d1d                	subw	a0,a0,a5
    1894:	8082                	ret

0000000000001896 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1896:	00757793          	andi	a5,a0,7
    189a:	cf89                	beqz	a5,18b4 <strlen+0x1e>
    189c:	87aa                	mv	a5,a0
    189e:	a029                	j	18a8 <strlen+0x12>
    18a0:	0785                	addi	a5,a5,1
    18a2:	0077f713          	andi	a4,a5,7
    18a6:	cb01                	beqz	a4,18b6 <strlen+0x20>
        if (!*s)
    18a8:	0007c703          	lbu	a4,0(a5)
    18ac:	fb75                	bnez	a4,18a0 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18ae:	40a78533          	sub	a0,a5,a0
}
    18b2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18b4:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18b6:	6394                	ld	a3,0(a5)
    18b8:	00000597          	auipc	a1,0x0
    18bc:	6985b583          	ld	a1,1688(a1) # 1f50 <__clone+0x9e>
    18c0:	00000617          	auipc	a2,0x0
    18c4:	69863603          	ld	a2,1688(a2) # 1f58 <__clone+0xa6>
    18c8:	a019                	j	18ce <strlen+0x38>
    18ca:	6794                	ld	a3,8(a5)
    18cc:	07a1                	addi	a5,a5,8
    18ce:	00b68733          	add	a4,a3,a1
    18d2:	fff6c693          	not	a3,a3
    18d6:	8f75                	and	a4,a4,a3
    18d8:	8f71                	and	a4,a4,a2
    18da:	db65                	beqz	a4,18ca <strlen+0x34>
    for (; *s; s++)
    18dc:	0007c703          	lbu	a4,0(a5)
    18e0:	d779                	beqz	a4,18ae <strlen+0x18>
    18e2:	0017c703          	lbu	a4,1(a5)
    18e6:	0785                	addi	a5,a5,1
    18e8:	d379                	beqz	a4,18ae <strlen+0x18>
    18ea:	0017c703          	lbu	a4,1(a5)
    18ee:	0785                	addi	a5,a5,1
    18f0:	fb6d                	bnez	a4,18e2 <strlen+0x4c>
    18f2:	bf75                	j	18ae <strlen+0x18>

00000000000018f4 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f4:	00757713          	andi	a4,a0,7
{
    18f8:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18fa:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18fe:	cb19                	beqz	a4,1914 <memchr+0x20>
    1900:	ce25                	beqz	a2,1978 <memchr+0x84>
    1902:	0007c703          	lbu	a4,0(a5)
    1906:	04b70e63          	beq	a4,a1,1962 <memchr+0x6e>
    190a:	0785                	addi	a5,a5,1
    190c:	0077f713          	andi	a4,a5,7
    1910:	167d                	addi	a2,a2,-1
    1912:	f77d                	bnez	a4,1900 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1914:	4501                	li	a0,0
    if (n && *s != c)
    1916:	c235                	beqz	a2,197a <memchr+0x86>
    1918:	0007c703          	lbu	a4,0(a5)
    191c:	04b70363          	beq	a4,a1,1962 <memchr+0x6e>
        size_t k = ONES * c;
    1920:	00000517          	auipc	a0,0x0
    1924:	64053503          	ld	a0,1600(a0) # 1f60 <__clone+0xae>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1928:	471d                	li	a4,7
        size_t k = ONES * c;
    192a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192e:	02c77a63          	bgeu	a4,a2,1962 <memchr+0x6e>
    1932:	00000897          	auipc	a7,0x0
    1936:	61e8b883          	ld	a7,1566(a7) # 1f50 <__clone+0x9e>
    193a:	00000817          	auipc	a6,0x0
    193e:	61e83803          	ld	a6,1566(a6) # 1f58 <__clone+0xa6>
    1942:	431d                	li	t1,7
    1944:	a029                	j	194e <memchr+0x5a>
    1946:	1661                	addi	a2,a2,-8
    1948:	07a1                	addi	a5,a5,8
    194a:	02c37963          	bgeu	t1,a2,197c <memchr+0x88>
    194e:	6398                	ld	a4,0(a5)
    1950:	8f29                	xor	a4,a4,a0
    1952:	011706b3          	add	a3,a4,a7
    1956:	fff74713          	not	a4,a4
    195a:	8f75                	and	a4,a4,a3
    195c:	01077733          	and	a4,a4,a6
    1960:	d37d                	beqz	a4,1946 <memchr+0x52>
    1962:	853e                	mv	a0,a5
    1964:	97b2                	add	a5,a5,a2
    1966:	a021                	j	196e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1968:	0505                	addi	a0,a0,1
    196a:	00f50763          	beq	a0,a5,1978 <memchr+0x84>
    196e:	00054703          	lbu	a4,0(a0)
    1972:	feb71be3          	bne	a4,a1,1968 <memchr+0x74>
    1976:	8082                	ret
    return n ? (void *)s : 0;
    1978:	4501                	li	a0,0
}
    197a:	8082                	ret
    return n ? (void *)s : 0;
    197c:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    197e:	f275                	bnez	a2,1962 <memchr+0x6e>
}
    1980:	8082                	ret

0000000000001982 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1982:	1101                	addi	sp,sp,-32
    1984:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1986:	862e                	mv	a2,a1
{
    1988:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    198a:	4581                	li	a1,0
{
    198c:	e426                	sd	s1,8(sp)
    198e:	ec06                	sd	ra,24(sp)
    1990:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1992:	f63ff0ef          	jal	ra,18f4 <memchr>
    return p ? p - s : n;
    1996:	c519                	beqz	a0,19a4 <strnlen+0x22>
}
    1998:	60e2                	ld	ra,24(sp)
    199a:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    199c:	8d05                	sub	a0,a0,s1
}
    199e:	64a2                	ld	s1,8(sp)
    19a0:	6105                	addi	sp,sp,32
    19a2:	8082                	ret
    19a4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19a6:	8522                	mv	a0,s0
}
    19a8:	6442                	ld	s0,16(sp)
    19aa:	64a2                	ld	s1,8(sp)
    19ac:	6105                	addi	sp,sp,32
    19ae:	8082                	ret

00000000000019b0 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19b0:	00b547b3          	xor	a5,a0,a1
    19b4:	8b9d                	andi	a5,a5,7
    19b6:	eb95                	bnez	a5,19ea <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19b8:	0075f793          	andi	a5,a1,7
    19bc:	e7b1                	bnez	a5,1a08 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19be:	6198                	ld	a4,0(a1)
    19c0:	00000617          	auipc	a2,0x0
    19c4:	59063603          	ld	a2,1424(a2) # 1f50 <__clone+0x9e>
    19c8:	00000817          	auipc	a6,0x0
    19cc:	59083803          	ld	a6,1424(a6) # 1f58 <__clone+0xa6>
    19d0:	a029                	j	19da <strcpy+0x2a>
    19d2:	e118                	sd	a4,0(a0)
    19d4:	6598                	ld	a4,8(a1)
    19d6:	05a1                	addi	a1,a1,8
    19d8:	0521                	addi	a0,a0,8
    19da:	00c707b3          	add	a5,a4,a2
    19de:	fff74693          	not	a3,a4
    19e2:	8ff5                	and	a5,a5,a3
    19e4:	0107f7b3          	and	a5,a5,a6
    19e8:	d7ed                	beqz	a5,19d2 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19ea:	0005c783          	lbu	a5,0(a1)
    19ee:	00f50023          	sb	a5,0(a0)
    19f2:	c785                	beqz	a5,1a1a <strcpy+0x6a>
    19f4:	0015c783          	lbu	a5,1(a1)
    19f8:	0505                	addi	a0,a0,1
    19fa:	0585                	addi	a1,a1,1
    19fc:	00f50023          	sb	a5,0(a0)
    1a00:	fbf5                	bnez	a5,19f4 <strcpy+0x44>
        ;
    return d;
}
    1a02:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a04:	0505                	addi	a0,a0,1
    1a06:	df45                	beqz	a4,19be <strcpy+0xe>
            if (!(*d = *s))
    1a08:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a0c:	0585                	addi	a1,a1,1
    1a0e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a12:	00f50023          	sb	a5,0(a0)
    1a16:	f7fd                	bnez	a5,1a04 <strcpy+0x54>
}
    1a18:	8082                	ret
    1a1a:	8082                	ret

0000000000001a1c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a1c:	00b547b3          	xor	a5,a0,a1
    1a20:	8b9d                	andi	a5,a5,7
    1a22:	1a079863          	bnez	a5,1bd2 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a26:	0075f793          	andi	a5,a1,7
    1a2a:	16078463          	beqz	a5,1b92 <strncpy+0x176>
    1a2e:	ea01                	bnez	a2,1a3e <strncpy+0x22>
    1a30:	a421                	j	1c38 <strncpy+0x21c>
    1a32:	167d                	addi	a2,a2,-1
    1a34:	0505                	addi	a0,a0,1
    1a36:	14070e63          	beqz	a4,1b92 <strncpy+0x176>
    1a3a:	1a060863          	beqz	a2,1bea <strncpy+0x1ce>
    1a3e:	0005c783          	lbu	a5,0(a1)
    1a42:	0585                	addi	a1,a1,1
    1a44:	0075f713          	andi	a4,a1,7
    1a48:	00f50023          	sb	a5,0(a0)
    1a4c:	f3fd                	bnez	a5,1a32 <strncpy+0x16>
    1a4e:	4805                	li	a6,1
    1a50:	1a061863          	bnez	a2,1c00 <strncpy+0x1e4>
    1a54:	40a007b3          	neg	a5,a0
    1a58:	8b9d                	andi	a5,a5,7
    1a5a:	4681                	li	a3,0
    1a5c:	18061a63          	bnez	a2,1bf0 <strncpy+0x1d4>
    1a60:	00778713          	addi	a4,a5,7
    1a64:	45ad                	li	a1,11
    1a66:	18b76363          	bltu	a4,a1,1bec <strncpy+0x1d0>
    1a6a:	1ae6eb63          	bltu	a3,a4,1c20 <strncpy+0x204>
    1a6e:	1a078363          	beqz	a5,1c14 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a72:	00050023          	sb	zero,0(a0)
    1a76:	4685                	li	a3,1
    1a78:	00150713          	addi	a4,a0,1
    1a7c:	18d78f63          	beq	a5,a3,1c1a <strncpy+0x1fe>
    1a80:	000500a3          	sb	zero,1(a0)
    1a84:	4689                	li	a3,2
    1a86:	00250713          	addi	a4,a0,2
    1a8a:	18d78e63          	beq	a5,a3,1c26 <strncpy+0x20a>
    1a8e:	00050123          	sb	zero,2(a0)
    1a92:	468d                	li	a3,3
    1a94:	00350713          	addi	a4,a0,3
    1a98:	16d78c63          	beq	a5,a3,1c10 <strncpy+0x1f4>
    1a9c:	000501a3          	sb	zero,3(a0)
    1aa0:	4691                	li	a3,4
    1aa2:	00450713          	addi	a4,a0,4
    1aa6:	18d78263          	beq	a5,a3,1c2a <strncpy+0x20e>
    1aaa:	00050223          	sb	zero,4(a0)
    1aae:	4695                	li	a3,5
    1ab0:	00550713          	addi	a4,a0,5
    1ab4:	16d78d63          	beq	a5,a3,1c2e <strncpy+0x212>
    1ab8:	000502a3          	sb	zero,5(a0)
    1abc:	469d                	li	a3,7
    1abe:	00650713          	addi	a4,a0,6
    1ac2:	16d79863          	bne	a5,a3,1c32 <strncpy+0x216>
    1ac6:	00750713          	addi	a4,a0,7
    1aca:	00050323          	sb	zero,6(a0)
    1ace:	40f80833          	sub	a6,a6,a5
    1ad2:	ff887593          	andi	a1,a6,-8
    1ad6:	97aa                	add	a5,a5,a0
    1ad8:	95be                	add	a1,a1,a5
    1ada:	0007b023          	sd	zero,0(a5)
    1ade:	07a1                	addi	a5,a5,8
    1ae0:	feb79de3          	bne	a5,a1,1ada <strncpy+0xbe>
    1ae4:	ff887593          	andi	a1,a6,-8
    1ae8:	9ead                	addw	a3,a3,a1
    1aea:	00b707b3          	add	a5,a4,a1
    1aee:	12b80863          	beq	a6,a1,1c1e <strncpy+0x202>
    1af2:	00078023          	sb	zero,0(a5)
    1af6:	0016871b          	addiw	a4,a3,1
    1afa:	0ec77863          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1afe:	000780a3          	sb	zero,1(a5)
    1b02:	0026871b          	addiw	a4,a3,2
    1b06:	0ec77263          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b0a:	00078123          	sb	zero,2(a5)
    1b0e:	0036871b          	addiw	a4,a3,3
    1b12:	0cc77c63          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b16:	000781a3          	sb	zero,3(a5)
    1b1a:	0046871b          	addiw	a4,a3,4
    1b1e:	0cc77663          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b22:	00078223          	sb	zero,4(a5)
    1b26:	0056871b          	addiw	a4,a3,5
    1b2a:	0cc77063          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b2e:	000782a3          	sb	zero,5(a5)
    1b32:	0066871b          	addiw	a4,a3,6
    1b36:	0ac77a63          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b3a:	00078323          	sb	zero,6(a5)
    1b3e:	0076871b          	addiw	a4,a3,7
    1b42:	0ac77463          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b46:	000783a3          	sb	zero,7(a5)
    1b4a:	0086871b          	addiw	a4,a3,8
    1b4e:	08c77e63          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b52:	00078423          	sb	zero,8(a5)
    1b56:	0096871b          	addiw	a4,a3,9
    1b5a:	08c77863          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b5e:	000784a3          	sb	zero,9(a5)
    1b62:	00a6871b          	addiw	a4,a3,10
    1b66:	08c77263          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b6a:	00078523          	sb	zero,10(a5)
    1b6e:	00b6871b          	addiw	a4,a3,11
    1b72:	06c77c63          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b76:	000785a3          	sb	zero,11(a5)
    1b7a:	00c6871b          	addiw	a4,a3,12
    1b7e:	06c77663          	bgeu	a4,a2,1bea <strncpy+0x1ce>
    1b82:	00078623          	sb	zero,12(a5)
    1b86:	26b5                	addiw	a3,a3,13
    1b88:	06c6f163          	bgeu	a3,a2,1bea <strncpy+0x1ce>
    1b8c:	000786a3          	sb	zero,13(a5)
    1b90:	8082                	ret
            ;
        if (!n || !*s)
    1b92:	c645                	beqz	a2,1c3a <strncpy+0x21e>
    1b94:	0005c783          	lbu	a5,0(a1)
    1b98:	ea078be3          	beqz	a5,1a4e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b9c:	479d                	li	a5,7
    1b9e:	02c7ff63          	bgeu	a5,a2,1bdc <strncpy+0x1c0>
    1ba2:	00000897          	auipc	a7,0x0
    1ba6:	3ae8b883          	ld	a7,942(a7) # 1f50 <__clone+0x9e>
    1baa:	00000817          	auipc	a6,0x0
    1bae:	3ae83803          	ld	a6,942(a6) # 1f58 <__clone+0xa6>
    1bb2:	431d                	li	t1,7
    1bb4:	6198                	ld	a4,0(a1)
    1bb6:	011707b3          	add	a5,a4,a7
    1bba:	fff74693          	not	a3,a4
    1bbe:	8ff5                	and	a5,a5,a3
    1bc0:	0107f7b3          	and	a5,a5,a6
    1bc4:	ef81                	bnez	a5,1bdc <strncpy+0x1c0>
            *wd = *ws;
    1bc6:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc8:	1661                	addi	a2,a2,-8
    1bca:	05a1                	addi	a1,a1,8
    1bcc:	0521                	addi	a0,a0,8
    1bce:	fec363e3          	bltu	t1,a2,1bb4 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bd2:	e609                	bnez	a2,1bdc <strncpy+0x1c0>
    1bd4:	a08d                	j	1c36 <strncpy+0x21a>
    1bd6:	167d                	addi	a2,a2,-1
    1bd8:	0505                	addi	a0,a0,1
    1bda:	ca01                	beqz	a2,1bea <strncpy+0x1ce>
    1bdc:	0005c783          	lbu	a5,0(a1)
    1be0:	0585                	addi	a1,a1,1
    1be2:	00f50023          	sb	a5,0(a0)
    1be6:	fbe5                	bnez	a5,1bd6 <strncpy+0x1ba>
        ;
tail:
    1be8:	b59d                	j	1a4e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bea:	8082                	ret
    1bec:	472d                	li	a4,11
    1bee:	bdb5                	j	1a6a <strncpy+0x4e>
    1bf0:	00778713          	addi	a4,a5,7
    1bf4:	45ad                	li	a1,11
    1bf6:	fff60693          	addi	a3,a2,-1
    1bfa:	e6b778e3          	bgeu	a4,a1,1a6a <strncpy+0x4e>
    1bfe:	b7fd                	j	1bec <strncpy+0x1d0>
    1c00:	40a007b3          	neg	a5,a0
    1c04:	8832                	mv	a6,a2
    1c06:	8b9d                	andi	a5,a5,7
    1c08:	4681                	li	a3,0
    1c0a:	e4060be3          	beqz	a2,1a60 <strncpy+0x44>
    1c0e:	b7cd                	j	1bf0 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c10:	468d                	li	a3,3
    1c12:	bd75                	j	1ace <strncpy+0xb2>
    1c14:	872a                	mv	a4,a0
    1c16:	4681                	li	a3,0
    1c18:	bd5d                	j	1ace <strncpy+0xb2>
    1c1a:	4685                	li	a3,1
    1c1c:	bd4d                	j	1ace <strncpy+0xb2>
    1c1e:	8082                	ret
    1c20:	87aa                	mv	a5,a0
    1c22:	4681                	li	a3,0
    1c24:	b5f9                	j	1af2 <strncpy+0xd6>
    1c26:	4689                	li	a3,2
    1c28:	b55d                	j	1ace <strncpy+0xb2>
    1c2a:	4691                	li	a3,4
    1c2c:	b54d                	j	1ace <strncpy+0xb2>
    1c2e:	4695                	li	a3,5
    1c30:	bd79                	j	1ace <strncpy+0xb2>
    1c32:	4699                	li	a3,6
    1c34:	bd69                	j	1ace <strncpy+0xb2>
    1c36:	8082                	ret
    1c38:	8082                	ret
    1c3a:	8082                	ret

0000000000001c3c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c3c:	87aa                	mv	a5,a0
    1c3e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c40:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c44:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c48:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c4a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c4c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c50:	2501                	sext.w	a0,a0
    1c52:	8082                	ret

0000000000001c54 <openat>:
    register long a7 __asm__("a7") = n;
    1c54:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c58:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c5c:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c60:	2501                	sext.w	a0,a0
    1c62:	8082                	ret

0000000000001c64 <close>:
    register long a7 __asm__("a7") = n;
    1c64:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c68:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c6c:	2501                	sext.w	a0,a0
    1c6e:	8082                	ret

0000000000001c70 <read>:
    register long a7 __asm__("a7") = n;
    1c70:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c74:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c78:	8082                	ret

0000000000001c7a <write>:
    register long a7 __asm__("a7") = n;
    1c7a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7e:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c82:	8082                	ret

0000000000001c84 <getpid>:
    register long a7 __asm__("a7") = n;
    1c84:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c88:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c8c:	2501                	sext.w	a0,a0
    1c8e:	8082                	ret

0000000000001c90 <getppid>:
    register long a7 __asm__("a7") = n;
    1c90:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c94:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c98:	2501                	sext.w	a0,a0
    1c9a:	8082                	ret

0000000000001c9c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c9c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ca0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ca4:	2501                	sext.w	a0,a0
    1ca6:	8082                	ret

0000000000001ca8 <fork>:
    register long a7 __asm__("a7") = n;
    1ca8:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cac:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cae:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cb4:	2501                	sext.w	a0,a0
    1cb6:	8082                	ret

0000000000001cb8 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cb8:	85b2                	mv	a1,a2
    1cba:	863a                	mv	a2,a4
    if (stack)
    1cbc:	c191                	beqz	a1,1cc0 <clone+0x8>
	stack += stack_size;
    1cbe:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cc0:	4781                	li	a5,0
    1cc2:	4701                	li	a4,0
    1cc4:	4681                	li	a3,0
    1cc6:	2601                	sext.w	a2,a2
    1cc8:	a2ed                	j	1eb2 <__clone>

0000000000001cca <exit>:
    register long a7 __asm__("a7") = n;
    1cca:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cce:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cd2:	8082                	ret

0000000000001cd4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cd4:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cd8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cda:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cde:	2501                	sext.w	a0,a0
    1ce0:	8082                	ret

0000000000001ce2 <exec>:
    register long a7 __asm__("a7") = n;
    1ce2:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1ce6:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cea:	2501                	sext.w	a0,a0
    1cec:	8082                	ret

0000000000001cee <execve>:
    register long a7 __asm__("a7") = n;
    1cee:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf2:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cf6:	2501                	sext.w	a0,a0
    1cf8:	8082                	ret

0000000000001cfa <times>:
    register long a7 __asm__("a7") = n;
    1cfa:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cfe:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d02:	2501                	sext.w	a0,a0
    1d04:	8082                	ret

0000000000001d06 <get_time>:

int64 get_time()
{
    1d06:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d08:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d0c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d0e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d10:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d14:	2501                	sext.w	a0,a0
    1d16:	ed09                	bnez	a0,1d30 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d18:	67a2                	ld	a5,8(sp)
    1d1a:	3e800713          	li	a4,1000
    1d1e:	00015503          	lhu	a0,0(sp)
    1d22:	02e7d7b3          	divu	a5,a5,a4
    1d26:	02e50533          	mul	a0,a0,a4
    1d2a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d2c:	0141                	addi	sp,sp,16
    1d2e:	8082                	ret
        return -1;
    1d30:	557d                	li	a0,-1
    1d32:	bfed                	j	1d2c <get_time+0x26>

0000000000001d34 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d34:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d38:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d3c:	2501                	sext.w	a0,a0
    1d3e:	8082                	ret

0000000000001d40 <time>:
    register long a7 __asm__("a7") = n;
    1d40:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d44:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d48:	2501                	sext.w	a0,a0
    1d4a:	8082                	ret

0000000000001d4c <sleep>:

int sleep(unsigned long long time)
{
    1d4c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d4e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d50:	850a                	mv	a0,sp
    1d52:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d54:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d58:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5a:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d5e:	e501                	bnez	a0,1d66 <sleep+0x1a>
    return 0;
    1d60:	4501                	li	a0,0
}
    1d62:	0141                	addi	sp,sp,16
    1d64:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d66:	4502                	lw	a0,0(sp)
}
    1d68:	0141                	addi	sp,sp,16
    1d6a:	8082                	ret

0000000000001d6c <set_priority>:
    register long a7 __asm__("a7") = n;
    1d6c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d70:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d74:	2501                	sext.w	a0,a0
    1d76:	8082                	ret

0000000000001d78 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d78:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d7c:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d80:	8082                	ret

0000000000001d82 <munmap>:
    register long a7 __asm__("a7") = n;
    1d82:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d86:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d8a:	2501                	sext.w	a0,a0
    1d8c:	8082                	ret

0000000000001d8e <wait>:

int wait(int *code)
{
    1d8e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d90:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d94:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d96:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d98:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d9a:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <spawn>:
    register long a7 __asm__("a7") = n;
    1da2:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1da6:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <mailread>:
    register long a7 __asm__("a7") = n;
    1dae:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db2:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1db6:	2501                	sext.w	a0,a0
    1db8:	8082                	ret

0000000000001dba <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dba:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dbe:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dc2:	2501                	sext.w	a0,a0
    1dc4:	8082                	ret

0000000000001dc6 <fstat>:
    register long a7 __asm__("a7") = n;
    1dc6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dca:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dce:	2501                	sext.w	a0,a0
    1dd0:	8082                	ret

0000000000001dd2 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dd2:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dd4:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dd8:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dda:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1de2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1de4:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1de8:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dea:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <link>:

int link(char *old_path, char *new_path)
{
    1df2:	87aa                	mv	a5,a0
    1df4:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1df6:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1dfa:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1dfe:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e00:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e04:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e06:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <unlink>:

int unlink(char *path)
{
    1e0e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e10:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e14:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e18:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e1e:	2501                	sext.w	a0,a0
    1e20:	8082                	ret

0000000000001e22 <uname>:
    register long a7 __asm__("a7") = n;
    1e22:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e26:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e2a:	2501                	sext.w	a0,a0
    1e2c:	8082                	ret

0000000000001e2e <brk>:
    register long a7 __asm__("a7") = n;
    1e2e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e32:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e36:	2501                	sext.w	a0,a0
    1e38:	8082                	ret

0000000000001e3a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e3a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e3c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e40:	8082                	ret

0000000000001e42 <chdir>:
    register long a7 __asm__("a7") = n;
    1e42:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e46:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e4a:	2501                	sext.w	a0,a0
    1e4c:	8082                	ret

0000000000001e4e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e4e:	862e                	mv	a2,a1
    1e50:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e52:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e54:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e58:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e5c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e5e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e60:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e64:	2501                	sext.w	a0,a0
    1e66:	8082                	ret

0000000000001e68 <getdents>:
    register long a7 __asm__("a7") = n;
    1e68:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6c:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e70:	2501                	sext.w	a0,a0
    1e72:	8082                	ret

0000000000001e74 <pipe>:
    register long a7 __asm__("a7") = n;
    1e74:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e78:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e7a:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e7e:	2501                	sext.w	a0,a0
    1e80:	8082                	ret

0000000000001e82 <dup>:
    register long a7 __asm__("a7") = n;
    1e82:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e84:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e88:	2501                	sext.w	a0,a0
    1e8a:	8082                	ret

0000000000001e8c <dup2>:
    register long a7 __asm__("a7") = n;
    1e8c:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e8e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e90:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e94:	2501                	sext.w	a0,a0
    1e96:	8082                	ret

0000000000001e98 <mount>:
    register long a7 __asm__("a7") = n;
    1e98:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e9c:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ea0:	2501                	sext.w	a0,a0
    1ea2:	8082                	ret

0000000000001ea4 <umount>:
    register long a7 __asm__("a7") = n;
    1ea4:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ea8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eaa:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eb2:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eb4:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eb6:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eb8:	8532                	mv	a0,a2
	mv a2, a4
    1eba:	863a                	mv	a2,a4
	mv a3, a5
    1ebc:	86be                	mv	a3,a5
	mv a4, a6
    1ebe:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ec0:	0dc00893          	li	a7,220
	ecall
    1ec4:	00000073          	ecall

	beqz a0, 1f
    1ec8:	c111                	beqz	a0,1ecc <__clone+0x1a>
	# Parent
	ret
    1eca:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ecc:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ece:	6522                	ld	a0,8(sp)
	jalr a1
    1ed0:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ed2:	05d00893          	li	a7,93
	ecall
    1ed6:	00000073          	ecall
