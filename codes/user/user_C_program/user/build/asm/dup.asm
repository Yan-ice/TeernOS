
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/dup:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a069                	j	108c <__start_main>

0000000000001004 <test_dup>:
/*
 * 测试通过时应输出：
 * "  new fd is 3."
 */

void test_dup(){
    1004:	1101                	addi	sp,sp,-32
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ec250513          	addi	a0,a0,-318 # 1ec8 <__clone+0x28>
void test_dup(){
    100e:	ec06                	sd	ra,24(sp)
	TEST_START(__func__);
    1010:	2b4000ef          	jal	ra,12c4 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f4450513          	addi	a0,a0,-188 # 1f58 <__func__.1165>
    101c:	2a8000ef          	jal	ra,12c4 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ec050513          	addi	a0,a0,-320 # 1ee0 <__clone+0x40>
    1028:	29c000ef          	jal	ra,12c4 <puts>
	int fd = dup(STDOUT);
    102c:	4505                	li	a0,1
    102e:	643000ef          	jal	ra,1e70 <dup>
    1032:	85aa                	mv	a1,a0
	assert(fd >=0);
    1034:	02054b63          	bltz	a0,106a <test_dup+0x66>
	printf("  new fd is %d.\n", fd);
    1038:	00001517          	auipc	a0,0x1
    103c:	ed850513          	addi	a0,a0,-296 # 1f10 <__clone+0x70>
    1040:	2a6000ef          	jal	ra,12e6 <printf>
	TEST_END(__func__);
    1044:	00001517          	auipc	a0,0x1
    1048:	ee450513          	addi	a0,a0,-284 # 1f28 <__clone+0x88>
    104c:	278000ef          	jal	ra,12c4 <puts>
    1050:	00001517          	auipc	a0,0x1
    1054:	f0850513          	addi	a0,a0,-248 # 1f58 <__func__.1165>
    1058:	26c000ef          	jal	ra,12c4 <puts>
}
    105c:	60e2                	ld	ra,24(sp)
	TEST_END(__func__);
    105e:	00001517          	auipc	a0,0x1
    1062:	e8250513          	addi	a0,a0,-382 # 1ee0 <__clone+0x40>
}
    1066:	6105                	addi	sp,sp,32
	TEST_END(__func__);
    1068:	acb1                	j	12c4 <puts>
    106a:	e42a                	sd	a0,8(sp)
	assert(fd >=0);
    106c:	00001517          	auipc	a0,0x1
    1070:	e8450513          	addi	a0,a0,-380 # 1ef0 <__clone+0x50>
    1074:	532000ef          	jal	ra,15a6 <panic>
    1078:	65a2                	ld	a1,8(sp)
    107a:	bf7d                	j	1038 <test_dup+0x34>

000000000000107c <main>:

int main(void) {
    107c:	1141                	addi	sp,sp,-16
    107e:	e406                	sd	ra,8(sp)
	test_dup();
    1080:	f85ff0ef          	jal	ra,1004 <test_dup>
	return 0;
}
    1084:	60a2                	ld	ra,8(sp)
    1086:	4501                	li	a0,0
    1088:	0141                	addi	sp,sp,16
    108a:	8082                	ret

000000000000108c <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    108c:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    108e:	4108                	lw	a0,0(a0)
{
    1090:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1092:	05a1                	addi	a1,a1,8
{
    1094:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1096:	fe7ff0ef          	jal	ra,107c <main>
    109a:	41f000ef          	jal	ra,1cb8 <exit>
	return 0;
}
    109e:	60a2                	ld	ra,8(sp)
    10a0:	4501                	li	a0,0
    10a2:	0141                	addi	sp,sp,16
    10a4:	8082                	ret

00000000000010a6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10a6:	7179                	addi	sp,sp,-48
    10a8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10aa:	12054b63          	bltz	a0,11e0 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ae:	02b577bb          	remuw	a5,a0,a1
    10b2:	00001697          	auipc	a3,0x1
    10b6:	eb668693          	addi	a3,a3,-330 # 1f68 <digits>
    buf[16] = 0;
    10ba:	00010c23          	sb	zero,24(sp)
    i = 15;
    10be:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10c2:	1782                	slli	a5,a5,0x20
    10c4:	9381                	srli	a5,a5,0x20
    10c6:	97b6                	add	a5,a5,a3
    10c8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10cc:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10d0:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10d4:	16b56263          	bltu	a0,a1,1238 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10d8:	02e8763b          	remuw	a2,a6,a4
    10dc:	1602                	slli	a2,a2,0x20
    10de:	9201                	srli	a2,a2,0x20
    10e0:	9636                	add	a2,a2,a3
    10e2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    10e6:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    10ea:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    10ee:	12e86963          	bltu	a6,a4,1220 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    10f2:	02e5f63b          	remuw	a2,a1,a4
    10f6:	1602                	slli	a2,a2,0x20
    10f8:	9201                	srli	a2,a2,0x20
    10fa:	9636                	add	a2,a2,a3
    10fc:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1100:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1104:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1108:	10e5ef63          	bltu	a1,a4,1226 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    110c:	02e8763b          	remuw	a2,a6,a4
    1110:	1602                	slli	a2,a2,0x20
    1112:	9201                	srli	a2,a2,0x20
    1114:	9636                	add	a2,a2,a3
    1116:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    111a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    111e:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1122:	10e86563          	bltu	a6,a4,122c <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1126:	02e5f63b          	remuw	a2,a1,a4
    112a:	1602                	slli	a2,a2,0x20
    112c:	9201                	srli	a2,a2,0x20
    112e:	9636                	add	a2,a2,a3
    1130:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1134:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1138:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    113c:	0ee5eb63          	bltu	a1,a4,1232 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1140:	02e8763b          	remuw	a2,a6,a4
    1144:	1602                	slli	a2,a2,0x20
    1146:	9201                	srli	a2,a2,0x20
    1148:	9636                	add	a2,a2,a3
    114a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    114e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1152:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1156:	0ce86263          	bltu	a6,a4,121a <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    115a:	02e5f63b          	remuw	a2,a1,a4
    115e:	1602                	slli	a2,a2,0x20
    1160:	9201                	srli	a2,a2,0x20
    1162:	9636                	add	a2,a2,a3
    1164:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1168:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    116c:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    1170:	0ce5e663          	bltu	a1,a4,123c <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    1174:	02e8763b          	remuw	a2,a6,a4
    1178:	1602                	slli	a2,a2,0x20
    117a:	9201                	srli	a2,a2,0x20
    117c:	9636                	add	a2,a2,a3
    117e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1182:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1186:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    118a:	0ae86c63          	bltu	a6,a4,1242 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    118e:	02e5f63b          	remuw	a2,a1,a4
    1192:	1602                	slli	a2,a2,0x20
    1194:	9201                	srli	a2,a2,0x20
    1196:	9636                	add	a2,a2,a3
    1198:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    119c:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11a0:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11a4:	0ae5e263          	bltu	a1,a4,1248 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11a8:	1782                	slli	a5,a5,0x20
    11aa:	9381                	srli	a5,a5,0x20
    11ac:	97b6                	add	a5,a5,a3
    11ae:	0007c703          	lbu	a4,0(a5)
    11b2:	4599                	li	a1,6
    11b4:	4795                	li	a5,5
    11b6:	00e10723          	sb	a4,14(sp)

    if (sign)
    11ba:	00055963          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    11be:	1018                	addi	a4,sp,32
    11c0:	973e                	add	a4,a4,a5
    11c2:	02d00693          	li	a3,45
    11c6:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11ca:	85be                	mv	a1,a5
    write(f, s, l);
    11cc:	003c                	addi	a5,sp,8
    11ce:	4641                	li	a2,16
    11d0:	9e0d                	subw	a2,a2,a1
    11d2:	4505                	li	a0,1
    11d4:	95be                	add	a1,a1,a5
    11d6:	293000ef          	jal	ra,1c68 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11da:	70a2                	ld	ra,40(sp)
    11dc:	6145                	addi	sp,sp,48
    11de:	8082                	ret
        x = -xx;
    11e0:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    11e4:	02b677bb          	remuw	a5,a2,a1
    11e8:	00001697          	auipc	a3,0x1
    11ec:	d8068693          	addi	a3,a3,-640 # 1f68 <digits>
    buf[16] = 0;
    11f0:	00010c23          	sb	zero,24(sp)
    i = 15;
    11f4:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    11f8:	1782                	slli	a5,a5,0x20
    11fa:	9381                	srli	a5,a5,0x20
    11fc:	97b6                	add	a5,a5,a3
    11fe:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1202:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1206:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    120a:	ecb677e3          	bgeu	a2,a1,10d8 <printint.constprop.0+0x32>
        buf[i--] = '-';
    120e:	02d00793          	li	a5,45
    1212:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1216:	45b9                	li	a1,14
    1218:	bf55                	j	11cc <printint.constprop.0+0x126>
    121a:	47a5                	li	a5,9
    121c:	45a9                	li	a1,10
    121e:	bf71                	j	11ba <printint.constprop.0+0x114>
    1220:	47b5                	li	a5,13
    1222:	45b9                	li	a1,14
    1224:	bf59                	j	11ba <printint.constprop.0+0x114>
    1226:	47b1                	li	a5,12
    1228:	45b5                	li	a1,13
    122a:	bf41                	j	11ba <printint.constprop.0+0x114>
    122c:	47ad                	li	a5,11
    122e:	45b1                	li	a1,12
    1230:	b769                	j	11ba <printint.constprop.0+0x114>
    1232:	47a9                	li	a5,10
    1234:	45ad                	li	a1,11
    1236:	b751                	j	11ba <printint.constprop.0+0x114>
    i = 15;
    1238:	45bd                	li	a1,15
    123a:	bf49                	j	11cc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    123c:	47a1                	li	a5,8
    123e:	45a5                	li	a1,9
    1240:	bfad                	j	11ba <printint.constprop.0+0x114>
    1242:	479d                	li	a5,7
    1244:	45a1                	li	a1,8
    1246:	bf95                	j	11ba <printint.constprop.0+0x114>
    1248:	4799                	li	a5,6
    124a:	459d                	li	a1,7
    124c:	b7bd                	j	11ba <printint.constprop.0+0x114>

000000000000124e <getchar>:
{
    124e:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1250:	00f10593          	addi	a1,sp,15
    1254:	4605                	li	a2,1
    1256:	4501                	li	a0,0
{
    1258:	ec06                	sd	ra,24(sp)
    char byte = 0;
    125a:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    125e:	201000ef          	jal	ra,1c5e <read>
}
    1262:	60e2                	ld	ra,24(sp)
    1264:	00f14503          	lbu	a0,15(sp)
    1268:	6105                	addi	sp,sp,32
    126a:	8082                	ret

000000000000126c <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    126c:	00001797          	auipc	a5,0x1
    1270:	d1478793          	addi	a5,a5,-748 # 1f80 <digits+0x18>
    1274:	04000893          	li	a7,64
    1278:	4505                	li	a0,1
    127a:	85be                	mv	a1,a5
    127c:	4611                	li	a2,4
    127e:	00000073          	ecall
}
    1282:	4501                	li	a0,0
    1284:	8082                	ret

0000000000001286 <putchar>:
{
    1286:	1101                	addi	sp,sp,-32
    1288:	ec06                	sd	ra,24(sp)
    128a:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    128c:	3e700893          	li	a7,999
    1290:	4505                	li	a0,1
    1292:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1296:	00001717          	auipc	a4,0x1
    129a:	cea70713          	addi	a4,a4,-790 # 1f80 <digits+0x18>
    129e:	04000893          	li	a7,64
    12a2:	4505                	li	a0,1
    12a4:	85ba                	mv	a1,a4
    12a6:	4611                	li	a2,4
    12a8:	00000073          	ecall
    return write(stdout, &byte, 1);
    12ac:	4605                	li	a2,1
    12ae:	00f10593          	addi	a1,sp,15
    12b2:	4505                	li	a0,1
    char byte = c;
    12b4:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12b8:	1b1000ef          	jal	ra,1c68 <write>
}
    12bc:	60e2                	ld	ra,24(sp)
    12be:	2501                	sext.w	a0,a0
    12c0:	6105                	addi	sp,sp,32
    12c2:	8082                	ret

00000000000012c4 <puts>:
{
    12c4:	1141                	addi	sp,sp,-16
    12c6:	e406                	sd	ra,8(sp)
    12c8:	e022                	sd	s0,0(sp)
    12ca:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12cc:	5b8000ef          	jal	ra,1884 <strlen>
    12d0:	862a                	mv	a2,a0
    12d2:	85a2                	mv	a1,s0
    12d4:	4505                	li	a0,1
    12d6:	193000ef          	jal	ra,1c68 <write>
}
    12da:	60a2                	ld	ra,8(sp)
    12dc:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12de:	957d                	srai	a0,a0,0x3f
    return r;
    12e0:	2501                	sext.w	a0,a0
}
    12e2:	0141                	addi	sp,sp,16
    12e4:	8082                	ret

00000000000012e6 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12e6:	7171                	addi	sp,sp,-176
    12e8:	e0d2                	sd	s4,64(sp)
    12ea:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    12ec:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    12ee:	18bc                	addi	a5,sp,120
{
    12f0:	e8ca                	sd	s2,80(sp)
    12f2:	e4ce                	sd	s3,72(sp)
    12f4:	fc56                	sd	s5,56(sp)
    12f6:	f85a                	sd	s6,48(sp)
    12f8:	f486                	sd	ra,104(sp)
    12fa:	f0a2                	sd	s0,96(sp)
    12fc:	eca6                	sd	s1,88(sp)
    12fe:	fcae                	sd	a1,120(sp)
    1300:	e132                	sd	a2,128(sp)
    1302:	e536                	sd	a3,136(sp)
    1304:	e93a                	sd	a4,144(sp)
    1306:	f142                	sd	a6,160(sp)
    1308:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    130a:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    130c:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1310:	00001b17          	auipc	s6,0x1
    1314:	c28b0b13          	addi	s6,s6,-984 # 1f38 <__clone+0x98>
	::"r"((unsigned long long)ac)
    1318:	00001a97          	auipc	s5,0x1
    131c:	c68a8a93          	addi	s5,s5,-920 # 1f80 <digits+0x18>
    buf[i++] = '0';
    1320:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1324:	00001997          	auipc	s3,0x1
    1328:	c4498993          	addi	s3,s3,-956 # 1f68 <digits>
        if (!*s)
    132c:	00054783          	lbu	a5,0(a0)
    1330:	16078c63          	beqz	a5,14a8 <printf+0x1c2>
    1334:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1336:	19278363          	beq	a5,s2,14bc <printf+0x1d6>
    133a:	00164783          	lbu	a5,1(a2)
    133e:	0605                	addi	a2,a2,1
    1340:	fbfd                	bnez	a5,1336 <printf+0x50>
    1342:	84b2                	mv	s1,a2
        l = z - a;
    1344:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1348:	85aa                	mv	a1,a0
    134a:	8622                	mv	a2,s0
    134c:	4505                	li	a0,1
    134e:	11b000ef          	jal	ra,1c68 <write>
        if (l)
    1352:	18041e63          	bnez	s0,14ee <printf+0x208>
        if (s[1] == 0)
    1356:	0014c783          	lbu	a5,1(s1)
    135a:	14078763          	beqz	a5,14a8 <printf+0x1c2>
        switch (s[1])
    135e:	07300713          	li	a4,115
    1362:	1ce78063          	beq	a5,a4,1522 <printf+0x23c>
    1366:	18f76663          	bltu	a4,a5,14f2 <printf+0x20c>
    136a:	06400713          	li	a4,100
    136e:	1ae78063          	beq	a5,a4,150e <printf+0x228>
    1372:	07000713          	li	a4,112
    1376:	1ce79963          	bne	a5,a4,1548 <printf+0x262>
            printptr(va_arg(ap, uint64));
    137a:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    137c:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    1380:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    1382:	631c                	ld	a5,0(a4)
    1384:	0721                	addi	a4,a4,8
    1386:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1388:	00479293          	slli	t0,a5,0x4
    138c:	00879f93          	slli	t6,a5,0x8
    1390:	00c79f13          	slli	t5,a5,0xc
    1394:	01079e93          	slli	t4,a5,0x10
    1398:	01479e13          	slli	t3,a5,0x14
    139c:	01879313          	slli	t1,a5,0x18
    13a0:	01c79893          	slli	a7,a5,0x1c
    13a4:	02479813          	slli	a6,a5,0x24
    13a8:	02879513          	slli	a0,a5,0x28
    13ac:	02c79593          	slli	a1,a5,0x2c
    13b0:	03079693          	slli	a3,a5,0x30
    13b4:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13b8:	03c7d413          	srli	s0,a5,0x3c
    13bc:	01c7d39b          	srliw	t2,a5,0x1c
    13c0:	03c2d293          	srli	t0,t0,0x3c
    13c4:	03cfdf93          	srli	t6,t6,0x3c
    13c8:	03cf5f13          	srli	t5,t5,0x3c
    13cc:	03cede93          	srli	t4,t4,0x3c
    13d0:	03ce5e13          	srli	t3,t3,0x3c
    13d4:	03c35313          	srli	t1,t1,0x3c
    13d8:	03c8d893          	srli	a7,a7,0x3c
    13dc:	03c85813          	srli	a6,a6,0x3c
    13e0:	9171                	srli	a0,a0,0x3c
    13e2:	91f1                	srli	a1,a1,0x3c
    13e4:	92f1                	srli	a3,a3,0x3c
    13e6:	9371                	srli	a4,a4,0x3c
    13e8:	96ce                	add	a3,a3,s3
    13ea:	974e                	add	a4,a4,s3
    13ec:	944e                	add	s0,s0,s3
    13ee:	92ce                	add	t0,t0,s3
    13f0:	9fce                	add	t6,t6,s3
    13f2:	9f4e                	add	t5,t5,s3
    13f4:	9ece                	add	t4,t4,s3
    13f6:	9e4e                	add	t3,t3,s3
    13f8:	934e                	add	t1,t1,s3
    13fa:	98ce                	add	a7,a7,s3
    13fc:	93ce                	add	t2,t2,s3
    13fe:	984e                	add	a6,a6,s3
    1400:	954e                	add	a0,a0,s3
    1402:	95ce                	add	a1,a1,s3
    1404:	0006c083          	lbu	ra,0(a3)
    1408:	0002c283          	lbu	t0,0(t0)
    140c:	00074683          	lbu	a3,0(a4)
    1410:	000fcf83          	lbu	t6,0(t6)
    1414:	000f4f03          	lbu	t5,0(t5)
    1418:	000ece83          	lbu	t4,0(t4)
    141c:	000e4e03          	lbu	t3,0(t3)
    1420:	00034303          	lbu	t1,0(t1)
    1424:	0008c883          	lbu	a7,0(a7)
    1428:	0003c383          	lbu	t2,0(t2)
    142c:	00084803          	lbu	a6,0(a6)
    1430:	00054503          	lbu	a0,0(a0)
    1434:	0005c583          	lbu	a1,0(a1)
    1438:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    143c:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1440:	9371                	srli	a4,a4,0x3c
    1442:	8bbd                	andi	a5,a5,15
    1444:	974e                	add	a4,a4,s3
    1446:	97ce                	add	a5,a5,s3
    1448:	005105a3          	sb	t0,11(sp)
    144c:	01f10623          	sb	t6,12(sp)
    1450:	01e106a3          	sb	t5,13(sp)
    1454:	01d10723          	sb	t4,14(sp)
    1458:	01c107a3          	sb	t3,15(sp)
    145c:	00610823          	sb	t1,16(sp)
    1460:	011108a3          	sb	a7,17(sp)
    1464:	00710923          	sb	t2,18(sp)
    1468:	010109a3          	sb	a6,19(sp)
    146c:	00a10a23          	sb	a0,20(sp)
    1470:	00b10aa3          	sb	a1,21(sp)
    1474:	00110b23          	sb	ra,22(sp)
    1478:	00d10ba3          	sb	a3,23(sp)
    147c:	00810523          	sb	s0,10(sp)
    1480:	00074703          	lbu	a4,0(a4)
    1484:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1488:	002c                	addi	a1,sp,8
    148a:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    148c:	00e10c23          	sb	a4,24(sp)
    1490:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1494:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1498:	7d0000ef          	jal	ra,1c68 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    149c:	00248513          	addi	a0,s1,2
        if (!*s)
    14a0:	00054783          	lbu	a5,0(a0)
    14a4:	e80798e3          	bnez	a5,1334 <printf+0x4e>
    }
    va_end(ap);
}
    14a8:	70a6                	ld	ra,104(sp)
    14aa:	7406                	ld	s0,96(sp)
    14ac:	64e6                	ld	s1,88(sp)
    14ae:	6946                	ld	s2,80(sp)
    14b0:	69a6                	ld	s3,72(sp)
    14b2:	6a06                	ld	s4,64(sp)
    14b4:	7ae2                	ld	s5,56(sp)
    14b6:	7b42                	ld	s6,48(sp)
    14b8:	614d                	addi	sp,sp,176
    14ba:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14bc:	00064783          	lbu	a5,0(a2)
    14c0:	84b2                	mv	s1,a2
    14c2:	01278963          	beq	a5,s2,14d4 <printf+0x1ee>
    14c6:	bdbd                	j	1344 <printf+0x5e>
    14c8:	0024c783          	lbu	a5,2(s1)
    14cc:	0605                	addi	a2,a2,1
    14ce:	0489                	addi	s1,s1,2
    14d0:	e7279ae3          	bne	a5,s2,1344 <printf+0x5e>
    14d4:	0014c783          	lbu	a5,1(s1)
    14d8:	ff2788e3          	beq	a5,s2,14c8 <printf+0x1e2>
        l = z - a;
    14dc:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14e0:	85aa                	mv	a1,a0
    14e2:	8622                	mv	a2,s0
    14e4:	4505                	li	a0,1
    14e6:	782000ef          	jal	ra,1c68 <write>
        if (l)
    14ea:	e60406e3          	beqz	s0,1356 <printf+0x70>
    14ee:	8526                	mv	a0,s1
    14f0:	bd35                	j	132c <printf+0x46>
        switch (s[1])
    14f2:	07800713          	li	a4,120
    14f6:	04e79963          	bne	a5,a4,1548 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    14fa:	6782                	ld	a5,0(sp)
    14fc:	45c1                	li	a1,16
    14fe:	4388                	lw	a0,0(a5)
    1500:	07a1                	addi	a5,a5,8
    1502:	e03e                	sd	a5,0(sp)
    1504:	ba3ff0ef          	jal	ra,10a6 <printint.constprop.0>
        s += 2;
    1508:	00248513          	addi	a0,s1,2
    150c:	bf51                	j	14a0 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    150e:	6782                	ld	a5,0(sp)
    1510:	45a9                	li	a1,10
    1512:	4388                	lw	a0,0(a5)
    1514:	07a1                	addi	a5,a5,8
    1516:	e03e                	sd	a5,0(sp)
    1518:	b8fff0ef          	jal	ra,10a6 <printint.constprop.0>
        s += 2;
    151c:	00248513          	addi	a0,s1,2
    1520:	b741                	j	14a0 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1522:	6782                	ld	a5,0(sp)
    1524:	6380                	ld	s0,0(a5)
    1526:	07a1                	addi	a5,a5,8
    1528:	e03e                	sd	a5,0(sp)
    152a:	cc25                	beqz	s0,15a2 <printf+0x2bc>
            l = strnlen(a, 200);
    152c:	0c800593          	li	a1,200
    1530:	8522                	mv	a0,s0
    1532:	43e000ef          	jal	ra,1970 <strnlen>
    write(f, s, l);
    1536:	0005061b          	sext.w	a2,a0
    153a:	85a2                	mv	a1,s0
    153c:	4505                	li	a0,1
    153e:	72a000ef          	jal	ra,1c68 <write>
        s += 2;
    1542:	00248513          	addi	a0,s1,2
    1546:	bfa9                	j	14a0 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1548:	3e700893          	li	a7,999
    154c:	4505                	li	a0,1
    154e:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1552:	04000893          	li	a7,64
    1556:	4505                	li	a0,1
    1558:	85d6                	mv	a1,s5
    155a:	4611                	li	a2,4
    155c:	00000073          	ecall
    char byte = c;
    1560:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1564:	4605                	li	a2,1
    1566:	002c                	addi	a1,sp,8
    1568:	4505                	li	a0,1
    char byte = c;
    156a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    156e:	6fa000ef          	jal	ra,1c68 <write>
            putchar(s[1]);
    1572:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1576:	3e700893          	li	a7,999
    157a:	4505                	li	a0,1
    157c:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1580:	04000893          	li	a7,64
    1584:	4505                	li	a0,1
    1586:	85d6                	mv	a1,s5
    1588:	4611                	li	a2,4
    158a:	00000073          	ecall
    return write(stdout, &byte, 1);
    158e:	4605                	li	a2,1
    1590:	002c                	addi	a1,sp,8
    1592:	4505                	li	a0,1
    char byte = c;
    1594:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1598:	6d0000ef          	jal	ra,1c68 <write>
        s += 2;
    159c:	00248513          	addi	a0,s1,2
    15a0:	b701                	j	14a0 <printf+0x1ba>
                a = "(null)";
    15a2:	845a                	mv	s0,s6
    15a4:	b761                	j	152c <printf+0x246>

00000000000015a6 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15a6:	1141                	addi	sp,sp,-16
    15a8:	e406                	sd	ra,8(sp)
    puts(m);
    15aa:	d1bff0ef          	jal	ra,12c4 <puts>
    exit(-100);
}
    15ae:	60a2                	ld	ra,8(sp)
    exit(-100);
    15b0:	f9c00513          	li	a0,-100
}
    15b4:	0141                	addi	sp,sp,16
    exit(-100);
    15b6:	a709                	j	1cb8 <exit>

00000000000015b8 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15b8:	02000793          	li	a5,32
    15bc:	00f50663          	beq	a0,a5,15c8 <isspace+0x10>
    15c0:	355d                	addiw	a0,a0,-9
    15c2:	00553513          	sltiu	a0,a0,5
    15c6:	8082                	ret
    15c8:	4505                	li	a0,1
}
    15ca:	8082                	ret

00000000000015cc <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15cc:	fd05051b          	addiw	a0,a0,-48
}
    15d0:	00a53513          	sltiu	a0,a0,10
    15d4:	8082                	ret

00000000000015d6 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d6:	02000613          	li	a2,32
    15da:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15dc:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e0:	ff77069b          	addiw	a3,a4,-9
    15e4:	04c70d63          	beq	a4,a2,163e <atoi+0x68>
    15e8:	0007079b          	sext.w	a5,a4
    15ec:	04d5f963          	bgeu	a1,a3,163e <atoi+0x68>
        s++;
    switch (*s)
    15f0:	02b00693          	li	a3,43
    15f4:	04d70a63          	beq	a4,a3,1648 <atoi+0x72>
    15f8:	02d00693          	li	a3,45
    15fc:	06d70463          	beq	a4,a3,1664 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1600:	fd07859b          	addiw	a1,a5,-48
    1604:	4625                	li	a2,9
    1606:	873e                	mv	a4,a5
    1608:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    160a:	4e01                	li	t3,0
    while (isdigit(*s))
    160c:	04b66a63          	bltu	a2,a1,1660 <atoi+0x8a>
    int n = 0, neg = 0;
    1610:	4501                	li	a0,0
    while (isdigit(*s))
    1612:	4825                	li	a6,9
    1614:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1618:	0025179b          	slliw	a5,a0,0x2
    161c:	9d3d                	addw	a0,a0,a5
    161e:	fd07031b          	addiw	t1,a4,-48
    1622:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1626:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    162a:	0685                	addi	a3,a3,1
    162c:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1630:	0006071b          	sext.w	a4,a2
    1634:	feb870e3          	bgeu	a6,a1,1614 <atoi+0x3e>
    return neg ? n : -n;
    1638:	000e0563          	beqz	t3,1642 <atoi+0x6c>
}
    163c:	8082                	ret
        s++;
    163e:	0505                	addi	a0,a0,1
    1640:	bf71                	j	15dc <atoi+0x6>
    1642:	4113053b          	subw	a0,t1,a7
    1646:	8082                	ret
    while (isdigit(*s))
    1648:	00154783          	lbu	a5,1(a0)
    164c:	4625                	li	a2,9
        s++;
    164e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1652:	fd07859b          	addiw	a1,a5,-48
    1656:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    165a:	4e01                	li	t3,0
    while (isdigit(*s))
    165c:	fab67ae3          	bgeu	a2,a1,1610 <atoi+0x3a>
    1660:	4501                	li	a0,0
}
    1662:	8082                	ret
    while (isdigit(*s))
    1664:	00154783          	lbu	a5,1(a0)
    1668:	4625                	li	a2,9
        s++;
    166a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    166e:	fd07859b          	addiw	a1,a5,-48
    1672:	0007871b          	sext.w	a4,a5
    1676:	feb665e3          	bltu	a2,a1,1660 <atoi+0x8a>
        neg = 1;
    167a:	4e05                	li	t3,1
    167c:	bf51                	j	1610 <atoi+0x3a>

000000000000167e <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    167e:	16060d63          	beqz	a2,17f8 <memset+0x17a>
    1682:	40a007b3          	neg	a5,a0
    1686:	8b9d                	andi	a5,a5,7
    1688:	00778713          	addi	a4,a5,7
    168c:	482d                	li	a6,11
    168e:	0ff5f593          	zext.b	a1,a1
    1692:	fff60693          	addi	a3,a2,-1
    1696:	17076263          	bltu	a4,a6,17fa <memset+0x17c>
    169a:	16e6ea63          	bltu	a3,a4,180e <memset+0x190>
    169e:	16078563          	beqz	a5,1808 <memset+0x18a>
    16a2:	00b50023          	sb	a1,0(a0)
    16a6:	4705                	li	a4,1
    16a8:	00150e93          	addi	t4,a0,1
    16ac:	14e78c63          	beq	a5,a4,1804 <memset+0x186>
    16b0:	00b500a3          	sb	a1,1(a0)
    16b4:	4709                	li	a4,2
    16b6:	00250e93          	addi	t4,a0,2
    16ba:	14e78d63          	beq	a5,a4,1814 <memset+0x196>
    16be:	00b50123          	sb	a1,2(a0)
    16c2:	470d                	li	a4,3
    16c4:	00350e93          	addi	t4,a0,3
    16c8:	12e78b63          	beq	a5,a4,17fe <memset+0x180>
    16cc:	00b501a3          	sb	a1,3(a0)
    16d0:	4711                	li	a4,4
    16d2:	00450e93          	addi	t4,a0,4
    16d6:	14e78163          	beq	a5,a4,1818 <memset+0x19a>
    16da:	00b50223          	sb	a1,4(a0)
    16de:	4715                	li	a4,5
    16e0:	00550e93          	addi	t4,a0,5
    16e4:	12e78c63          	beq	a5,a4,181c <memset+0x19e>
    16e8:	00b502a3          	sb	a1,5(a0)
    16ec:	471d                	li	a4,7
    16ee:	00650e93          	addi	t4,a0,6
    16f2:	12e79763          	bne	a5,a4,1820 <memset+0x1a2>
    16f6:	00750e93          	addi	t4,a0,7
    16fa:	00b50323          	sb	a1,6(a0)
    16fe:	4f1d                	li	t5,7
    1700:	00859713          	slli	a4,a1,0x8
    1704:	8f4d                	or	a4,a4,a1
    1706:	01059e13          	slli	t3,a1,0x10
    170a:	01c76e33          	or	t3,a4,t3
    170e:	01859313          	slli	t1,a1,0x18
    1712:	006e6333          	or	t1,t3,t1
    1716:	02059893          	slli	a7,a1,0x20
    171a:	011368b3          	or	a7,t1,a7
    171e:	02859813          	slli	a6,a1,0x28
    1722:	40f60333          	sub	t1,a2,a5
    1726:	0108e833          	or	a6,a7,a6
    172a:	03059693          	slli	a3,a1,0x30
    172e:	00d866b3          	or	a3,a6,a3
    1732:	03859713          	slli	a4,a1,0x38
    1736:	97aa                	add	a5,a5,a0
    1738:	ff837813          	andi	a6,t1,-8
    173c:	8f55                	or	a4,a4,a3
    173e:	00f806b3          	add	a3,a6,a5
    1742:	e398                	sd	a4,0(a5)
    1744:	07a1                	addi	a5,a5,8
    1746:	fed79ee3          	bne	a5,a3,1742 <memset+0xc4>
    174a:	ff837693          	andi	a3,t1,-8
    174e:	00de87b3          	add	a5,t4,a3
    1752:	01e6873b          	addw	a4,a3,t5
    1756:	0ad30663          	beq	t1,a3,1802 <memset+0x184>
    175a:	00b78023          	sb	a1,0(a5)
    175e:	0017069b          	addiw	a3,a4,1
    1762:	08c6fb63          	bgeu	a3,a2,17f8 <memset+0x17a>
    1766:	00b780a3          	sb	a1,1(a5)
    176a:	0027069b          	addiw	a3,a4,2
    176e:	08c6f563          	bgeu	a3,a2,17f8 <memset+0x17a>
    1772:	00b78123          	sb	a1,2(a5)
    1776:	0037069b          	addiw	a3,a4,3
    177a:	06c6ff63          	bgeu	a3,a2,17f8 <memset+0x17a>
    177e:	00b781a3          	sb	a1,3(a5)
    1782:	0047069b          	addiw	a3,a4,4
    1786:	06c6f963          	bgeu	a3,a2,17f8 <memset+0x17a>
    178a:	00b78223          	sb	a1,4(a5)
    178e:	0057069b          	addiw	a3,a4,5
    1792:	06c6f363          	bgeu	a3,a2,17f8 <memset+0x17a>
    1796:	00b782a3          	sb	a1,5(a5)
    179a:	0067069b          	addiw	a3,a4,6
    179e:	04c6fd63          	bgeu	a3,a2,17f8 <memset+0x17a>
    17a2:	00b78323          	sb	a1,6(a5)
    17a6:	0077069b          	addiw	a3,a4,7
    17aa:	04c6f763          	bgeu	a3,a2,17f8 <memset+0x17a>
    17ae:	00b783a3          	sb	a1,7(a5)
    17b2:	0087069b          	addiw	a3,a4,8
    17b6:	04c6f163          	bgeu	a3,a2,17f8 <memset+0x17a>
    17ba:	00b78423          	sb	a1,8(a5)
    17be:	0097069b          	addiw	a3,a4,9
    17c2:	02c6fb63          	bgeu	a3,a2,17f8 <memset+0x17a>
    17c6:	00b784a3          	sb	a1,9(a5)
    17ca:	00a7069b          	addiw	a3,a4,10
    17ce:	02c6f563          	bgeu	a3,a2,17f8 <memset+0x17a>
    17d2:	00b78523          	sb	a1,10(a5)
    17d6:	00b7069b          	addiw	a3,a4,11
    17da:	00c6ff63          	bgeu	a3,a2,17f8 <memset+0x17a>
    17de:	00b785a3          	sb	a1,11(a5)
    17e2:	00c7069b          	addiw	a3,a4,12
    17e6:	00c6f963          	bgeu	a3,a2,17f8 <memset+0x17a>
    17ea:	00b78623          	sb	a1,12(a5)
    17ee:	2735                	addiw	a4,a4,13
    17f0:	00c77463          	bgeu	a4,a2,17f8 <memset+0x17a>
    17f4:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    17f8:	8082                	ret
    17fa:	472d                	li	a4,11
    17fc:	bd79                	j	169a <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    17fe:	4f0d                	li	t5,3
    1800:	b701                	j	1700 <memset+0x82>
    1802:	8082                	ret
    1804:	4f05                	li	t5,1
    1806:	bded                	j	1700 <memset+0x82>
    1808:	8eaa                	mv	t4,a0
    180a:	4f01                	li	t5,0
    180c:	bdd5                	j	1700 <memset+0x82>
    180e:	87aa                	mv	a5,a0
    1810:	4701                	li	a4,0
    1812:	b7a1                	j	175a <memset+0xdc>
    1814:	4f09                	li	t5,2
    1816:	b5ed                	j	1700 <memset+0x82>
    1818:	4f11                	li	t5,4
    181a:	b5dd                	j	1700 <memset+0x82>
    181c:	4f15                	li	t5,5
    181e:	b5cd                	j	1700 <memset+0x82>
    1820:	4f19                	li	t5,6
    1822:	bdf9                	j	1700 <memset+0x82>

0000000000001824 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1824:	00054783          	lbu	a5,0(a0)
    1828:	0005c703          	lbu	a4,0(a1)
    182c:	00e79863          	bne	a5,a4,183c <strcmp+0x18>
    1830:	0505                	addi	a0,a0,1
    1832:	0585                	addi	a1,a1,1
    1834:	fbe5                	bnez	a5,1824 <strcmp>
    1836:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1838:	9d19                	subw	a0,a0,a4
    183a:	8082                	ret
    183c:	0007851b          	sext.w	a0,a5
    1840:	bfe5                	j	1838 <strcmp+0x14>

0000000000001842 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1842:	ce05                	beqz	a2,187a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1844:	00054703          	lbu	a4,0(a0)
    1848:	0005c783          	lbu	a5,0(a1)
    184c:	cb0d                	beqz	a4,187e <strncmp+0x3c>
    if (!n--)
    184e:	167d                	addi	a2,a2,-1
    1850:	00c506b3          	add	a3,a0,a2
    1854:	a819                	j	186a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1856:	00a68e63          	beq	a3,a0,1872 <strncmp+0x30>
    185a:	0505                	addi	a0,a0,1
    185c:	00e79b63          	bne	a5,a4,1872 <strncmp+0x30>
    1860:	00054703          	lbu	a4,0(a0)
    1864:	0005c783          	lbu	a5,0(a1)
    1868:	cb19                	beqz	a4,187e <strncmp+0x3c>
    186a:	0005c783          	lbu	a5,0(a1)
    186e:	0585                	addi	a1,a1,1
    1870:	f3fd                	bnez	a5,1856 <strncmp+0x14>
        ;
    return *l - *r;
    1872:	0007051b          	sext.w	a0,a4
    1876:	9d1d                	subw	a0,a0,a5
    1878:	8082                	ret
        return 0;
    187a:	4501                	li	a0,0
}
    187c:	8082                	ret
    187e:	4501                	li	a0,0
    return *l - *r;
    1880:	9d1d                	subw	a0,a0,a5
    1882:	8082                	ret

0000000000001884 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1884:	00757793          	andi	a5,a0,7
    1888:	cf89                	beqz	a5,18a2 <strlen+0x1e>
    188a:	87aa                	mv	a5,a0
    188c:	a029                	j	1896 <strlen+0x12>
    188e:	0785                	addi	a5,a5,1
    1890:	0077f713          	andi	a4,a5,7
    1894:	cb01                	beqz	a4,18a4 <strlen+0x20>
        if (!*s)
    1896:	0007c703          	lbu	a4,0(a5)
    189a:	fb75                	bnez	a4,188e <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    189c:	40a78533          	sub	a0,a5,a0
}
    18a0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18a2:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18a4:	6394                	ld	a3,0(a5)
    18a6:	00000597          	auipc	a1,0x0
    18aa:	69a5b583          	ld	a1,1690(a1) # 1f40 <__clone+0xa0>
    18ae:	00000617          	auipc	a2,0x0
    18b2:	69a63603          	ld	a2,1690(a2) # 1f48 <__clone+0xa8>
    18b6:	a019                	j	18bc <strlen+0x38>
    18b8:	6794                	ld	a3,8(a5)
    18ba:	07a1                	addi	a5,a5,8
    18bc:	00b68733          	add	a4,a3,a1
    18c0:	fff6c693          	not	a3,a3
    18c4:	8f75                	and	a4,a4,a3
    18c6:	8f71                	and	a4,a4,a2
    18c8:	db65                	beqz	a4,18b8 <strlen+0x34>
    for (; *s; s++)
    18ca:	0007c703          	lbu	a4,0(a5)
    18ce:	d779                	beqz	a4,189c <strlen+0x18>
    18d0:	0017c703          	lbu	a4,1(a5)
    18d4:	0785                	addi	a5,a5,1
    18d6:	d379                	beqz	a4,189c <strlen+0x18>
    18d8:	0017c703          	lbu	a4,1(a5)
    18dc:	0785                	addi	a5,a5,1
    18de:	fb6d                	bnez	a4,18d0 <strlen+0x4c>
    18e0:	bf75                	j	189c <strlen+0x18>

00000000000018e2 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18e2:	00757713          	andi	a4,a0,7
{
    18e6:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18e8:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18ec:	cb19                	beqz	a4,1902 <memchr+0x20>
    18ee:	ce25                	beqz	a2,1966 <memchr+0x84>
    18f0:	0007c703          	lbu	a4,0(a5)
    18f4:	04b70e63          	beq	a4,a1,1950 <memchr+0x6e>
    18f8:	0785                	addi	a5,a5,1
    18fa:	0077f713          	andi	a4,a5,7
    18fe:	167d                	addi	a2,a2,-1
    1900:	f77d                	bnez	a4,18ee <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1902:	4501                	li	a0,0
    if (n && *s != c)
    1904:	c235                	beqz	a2,1968 <memchr+0x86>
    1906:	0007c703          	lbu	a4,0(a5)
    190a:	04b70363          	beq	a4,a1,1950 <memchr+0x6e>
        size_t k = ONES * c;
    190e:	00000517          	auipc	a0,0x0
    1912:	64253503          	ld	a0,1602(a0) # 1f50 <__clone+0xb0>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1916:	471d                	li	a4,7
        size_t k = ONES * c;
    1918:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    191c:	02c77a63          	bgeu	a4,a2,1950 <memchr+0x6e>
    1920:	00000897          	auipc	a7,0x0
    1924:	6208b883          	ld	a7,1568(a7) # 1f40 <__clone+0xa0>
    1928:	00000817          	auipc	a6,0x0
    192c:	62083803          	ld	a6,1568(a6) # 1f48 <__clone+0xa8>
    1930:	431d                	li	t1,7
    1932:	a029                	j	193c <memchr+0x5a>
    1934:	1661                	addi	a2,a2,-8
    1936:	07a1                	addi	a5,a5,8
    1938:	02c37963          	bgeu	t1,a2,196a <memchr+0x88>
    193c:	6398                	ld	a4,0(a5)
    193e:	8f29                	xor	a4,a4,a0
    1940:	011706b3          	add	a3,a4,a7
    1944:	fff74713          	not	a4,a4
    1948:	8f75                	and	a4,a4,a3
    194a:	01077733          	and	a4,a4,a6
    194e:	d37d                	beqz	a4,1934 <memchr+0x52>
    1950:	853e                	mv	a0,a5
    1952:	97b2                	add	a5,a5,a2
    1954:	a021                	j	195c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1956:	0505                	addi	a0,a0,1
    1958:	00f50763          	beq	a0,a5,1966 <memchr+0x84>
    195c:	00054703          	lbu	a4,0(a0)
    1960:	feb71be3          	bne	a4,a1,1956 <memchr+0x74>
    1964:	8082                	ret
    return n ? (void *)s : 0;
    1966:	4501                	li	a0,0
}
    1968:	8082                	ret
    return n ? (void *)s : 0;
    196a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    196c:	f275                	bnez	a2,1950 <memchr+0x6e>
}
    196e:	8082                	ret

0000000000001970 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1970:	1101                	addi	sp,sp,-32
    1972:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1974:	862e                	mv	a2,a1
{
    1976:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1978:	4581                	li	a1,0
{
    197a:	e426                	sd	s1,8(sp)
    197c:	ec06                	sd	ra,24(sp)
    197e:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1980:	f63ff0ef          	jal	ra,18e2 <memchr>
    return p ? p - s : n;
    1984:	c519                	beqz	a0,1992 <strnlen+0x22>
}
    1986:	60e2                	ld	ra,24(sp)
    1988:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    198a:	8d05                	sub	a0,a0,s1
}
    198c:	64a2                	ld	s1,8(sp)
    198e:	6105                	addi	sp,sp,32
    1990:	8082                	ret
    1992:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1994:	8522                	mv	a0,s0
}
    1996:	6442                	ld	s0,16(sp)
    1998:	64a2                	ld	s1,8(sp)
    199a:	6105                	addi	sp,sp,32
    199c:	8082                	ret

000000000000199e <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    199e:	00b547b3          	xor	a5,a0,a1
    19a2:	8b9d                	andi	a5,a5,7
    19a4:	eb95                	bnez	a5,19d8 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19a6:	0075f793          	andi	a5,a1,7
    19aa:	e7b1                	bnez	a5,19f6 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ac:	6198                	ld	a4,0(a1)
    19ae:	00000617          	auipc	a2,0x0
    19b2:	59263603          	ld	a2,1426(a2) # 1f40 <__clone+0xa0>
    19b6:	00000817          	auipc	a6,0x0
    19ba:	59283803          	ld	a6,1426(a6) # 1f48 <__clone+0xa8>
    19be:	a029                	j	19c8 <strcpy+0x2a>
    19c0:	e118                	sd	a4,0(a0)
    19c2:	6598                	ld	a4,8(a1)
    19c4:	05a1                	addi	a1,a1,8
    19c6:	0521                	addi	a0,a0,8
    19c8:	00c707b3          	add	a5,a4,a2
    19cc:	fff74693          	not	a3,a4
    19d0:	8ff5                	and	a5,a5,a3
    19d2:	0107f7b3          	and	a5,a5,a6
    19d6:	d7ed                	beqz	a5,19c0 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19d8:	0005c783          	lbu	a5,0(a1)
    19dc:	00f50023          	sb	a5,0(a0)
    19e0:	c785                	beqz	a5,1a08 <strcpy+0x6a>
    19e2:	0015c783          	lbu	a5,1(a1)
    19e6:	0505                	addi	a0,a0,1
    19e8:	0585                	addi	a1,a1,1
    19ea:	00f50023          	sb	a5,0(a0)
    19ee:	fbf5                	bnez	a5,19e2 <strcpy+0x44>
        ;
    return d;
}
    19f0:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19f2:	0505                	addi	a0,a0,1
    19f4:	df45                	beqz	a4,19ac <strcpy+0xe>
            if (!(*d = *s))
    19f6:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19fa:	0585                	addi	a1,a1,1
    19fc:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a00:	00f50023          	sb	a5,0(a0)
    1a04:	f7fd                	bnez	a5,19f2 <strcpy+0x54>
}
    1a06:	8082                	ret
    1a08:	8082                	ret

0000000000001a0a <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a0a:	00b547b3          	xor	a5,a0,a1
    1a0e:	8b9d                	andi	a5,a5,7
    1a10:	1a079863          	bnez	a5,1bc0 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a14:	0075f793          	andi	a5,a1,7
    1a18:	16078463          	beqz	a5,1b80 <strncpy+0x176>
    1a1c:	ea01                	bnez	a2,1a2c <strncpy+0x22>
    1a1e:	a421                	j	1c26 <strncpy+0x21c>
    1a20:	167d                	addi	a2,a2,-1
    1a22:	0505                	addi	a0,a0,1
    1a24:	14070e63          	beqz	a4,1b80 <strncpy+0x176>
    1a28:	1a060863          	beqz	a2,1bd8 <strncpy+0x1ce>
    1a2c:	0005c783          	lbu	a5,0(a1)
    1a30:	0585                	addi	a1,a1,1
    1a32:	0075f713          	andi	a4,a1,7
    1a36:	00f50023          	sb	a5,0(a0)
    1a3a:	f3fd                	bnez	a5,1a20 <strncpy+0x16>
    1a3c:	4805                	li	a6,1
    1a3e:	1a061863          	bnez	a2,1bee <strncpy+0x1e4>
    1a42:	40a007b3          	neg	a5,a0
    1a46:	8b9d                	andi	a5,a5,7
    1a48:	4681                	li	a3,0
    1a4a:	18061a63          	bnez	a2,1bde <strncpy+0x1d4>
    1a4e:	00778713          	addi	a4,a5,7
    1a52:	45ad                	li	a1,11
    1a54:	18b76363          	bltu	a4,a1,1bda <strncpy+0x1d0>
    1a58:	1ae6eb63          	bltu	a3,a4,1c0e <strncpy+0x204>
    1a5c:	1a078363          	beqz	a5,1c02 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a60:	00050023          	sb	zero,0(a0)
    1a64:	4685                	li	a3,1
    1a66:	00150713          	addi	a4,a0,1
    1a6a:	18d78f63          	beq	a5,a3,1c08 <strncpy+0x1fe>
    1a6e:	000500a3          	sb	zero,1(a0)
    1a72:	4689                	li	a3,2
    1a74:	00250713          	addi	a4,a0,2
    1a78:	18d78e63          	beq	a5,a3,1c14 <strncpy+0x20a>
    1a7c:	00050123          	sb	zero,2(a0)
    1a80:	468d                	li	a3,3
    1a82:	00350713          	addi	a4,a0,3
    1a86:	16d78c63          	beq	a5,a3,1bfe <strncpy+0x1f4>
    1a8a:	000501a3          	sb	zero,3(a0)
    1a8e:	4691                	li	a3,4
    1a90:	00450713          	addi	a4,a0,4
    1a94:	18d78263          	beq	a5,a3,1c18 <strncpy+0x20e>
    1a98:	00050223          	sb	zero,4(a0)
    1a9c:	4695                	li	a3,5
    1a9e:	00550713          	addi	a4,a0,5
    1aa2:	16d78d63          	beq	a5,a3,1c1c <strncpy+0x212>
    1aa6:	000502a3          	sb	zero,5(a0)
    1aaa:	469d                	li	a3,7
    1aac:	00650713          	addi	a4,a0,6
    1ab0:	16d79863          	bne	a5,a3,1c20 <strncpy+0x216>
    1ab4:	00750713          	addi	a4,a0,7
    1ab8:	00050323          	sb	zero,6(a0)
    1abc:	40f80833          	sub	a6,a6,a5
    1ac0:	ff887593          	andi	a1,a6,-8
    1ac4:	97aa                	add	a5,a5,a0
    1ac6:	95be                	add	a1,a1,a5
    1ac8:	0007b023          	sd	zero,0(a5)
    1acc:	07a1                	addi	a5,a5,8
    1ace:	feb79de3          	bne	a5,a1,1ac8 <strncpy+0xbe>
    1ad2:	ff887593          	andi	a1,a6,-8
    1ad6:	9ead                	addw	a3,a3,a1
    1ad8:	00b707b3          	add	a5,a4,a1
    1adc:	12b80863          	beq	a6,a1,1c0c <strncpy+0x202>
    1ae0:	00078023          	sb	zero,0(a5)
    1ae4:	0016871b          	addiw	a4,a3,1
    1ae8:	0ec77863          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1aec:	000780a3          	sb	zero,1(a5)
    1af0:	0026871b          	addiw	a4,a3,2
    1af4:	0ec77263          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1af8:	00078123          	sb	zero,2(a5)
    1afc:	0036871b          	addiw	a4,a3,3
    1b00:	0cc77c63          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b04:	000781a3          	sb	zero,3(a5)
    1b08:	0046871b          	addiw	a4,a3,4
    1b0c:	0cc77663          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b10:	00078223          	sb	zero,4(a5)
    1b14:	0056871b          	addiw	a4,a3,5
    1b18:	0cc77063          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b1c:	000782a3          	sb	zero,5(a5)
    1b20:	0066871b          	addiw	a4,a3,6
    1b24:	0ac77a63          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b28:	00078323          	sb	zero,6(a5)
    1b2c:	0076871b          	addiw	a4,a3,7
    1b30:	0ac77463          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b34:	000783a3          	sb	zero,7(a5)
    1b38:	0086871b          	addiw	a4,a3,8
    1b3c:	08c77e63          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b40:	00078423          	sb	zero,8(a5)
    1b44:	0096871b          	addiw	a4,a3,9
    1b48:	08c77863          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b4c:	000784a3          	sb	zero,9(a5)
    1b50:	00a6871b          	addiw	a4,a3,10
    1b54:	08c77263          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b58:	00078523          	sb	zero,10(a5)
    1b5c:	00b6871b          	addiw	a4,a3,11
    1b60:	06c77c63          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b64:	000785a3          	sb	zero,11(a5)
    1b68:	00c6871b          	addiw	a4,a3,12
    1b6c:	06c77663          	bgeu	a4,a2,1bd8 <strncpy+0x1ce>
    1b70:	00078623          	sb	zero,12(a5)
    1b74:	26b5                	addiw	a3,a3,13
    1b76:	06c6f163          	bgeu	a3,a2,1bd8 <strncpy+0x1ce>
    1b7a:	000786a3          	sb	zero,13(a5)
    1b7e:	8082                	ret
            ;
        if (!n || !*s)
    1b80:	c645                	beqz	a2,1c28 <strncpy+0x21e>
    1b82:	0005c783          	lbu	a5,0(a1)
    1b86:	ea078be3          	beqz	a5,1a3c <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b8a:	479d                	li	a5,7
    1b8c:	02c7ff63          	bgeu	a5,a2,1bca <strncpy+0x1c0>
    1b90:	00000897          	auipc	a7,0x0
    1b94:	3b08b883          	ld	a7,944(a7) # 1f40 <__clone+0xa0>
    1b98:	00000817          	auipc	a6,0x0
    1b9c:	3b083803          	ld	a6,944(a6) # 1f48 <__clone+0xa8>
    1ba0:	431d                	li	t1,7
    1ba2:	6198                	ld	a4,0(a1)
    1ba4:	011707b3          	add	a5,a4,a7
    1ba8:	fff74693          	not	a3,a4
    1bac:	8ff5                	and	a5,a5,a3
    1bae:	0107f7b3          	and	a5,a5,a6
    1bb2:	ef81                	bnez	a5,1bca <strncpy+0x1c0>
            *wd = *ws;
    1bb4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bb6:	1661                	addi	a2,a2,-8
    1bb8:	05a1                	addi	a1,a1,8
    1bba:	0521                	addi	a0,a0,8
    1bbc:	fec363e3          	bltu	t1,a2,1ba2 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bc0:	e609                	bnez	a2,1bca <strncpy+0x1c0>
    1bc2:	a08d                	j	1c24 <strncpy+0x21a>
    1bc4:	167d                	addi	a2,a2,-1
    1bc6:	0505                	addi	a0,a0,1
    1bc8:	ca01                	beqz	a2,1bd8 <strncpy+0x1ce>
    1bca:	0005c783          	lbu	a5,0(a1)
    1bce:	0585                	addi	a1,a1,1
    1bd0:	00f50023          	sb	a5,0(a0)
    1bd4:	fbe5                	bnez	a5,1bc4 <strncpy+0x1ba>
        ;
tail:
    1bd6:	b59d                	j	1a3c <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bd8:	8082                	ret
    1bda:	472d                	li	a4,11
    1bdc:	bdb5                	j	1a58 <strncpy+0x4e>
    1bde:	00778713          	addi	a4,a5,7
    1be2:	45ad                	li	a1,11
    1be4:	fff60693          	addi	a3,a2,-1
    1be8:	e6b778e3          	bgeu	a4,a1,1a58 <strncpy+0x4e>
    1bec:	b7fd                	j	1bda <strncpy+0x1d0>
    1bee:	40a007b3          	neg	a5,a0
    1bf2:	8832                	mv	a6,a2
    1bf4:	8b9d                	andi	a5,a5,7
    1bf6:	4681                	li	a3,0
    1bf8:	e4060be3          	beqz	a2,1a4e <strncpy+0x44>
    1bfc:	b7cd                	j	1bde <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1bfe:	468d                	li	a3,3
    1c00:	bd75                	j	1abc <strncpy+0xb2>
    1c02:	872a                	mv	a4,a0
    1c04:	4681                	li	a3,0
    1c06:	bd5d                	j	1abc <strncpy+0xb2>
    1c08:	4685                	li	a3,1
    1c0a:	bd4d                	j	1abc <strncpy+0xb2>
    1c0c:	8082                	ret
    1c0e:	87aa                	mv	a5,a0
    1c10:	4681                	li	a3,0
    1c12:	b5f9                	j	1ae0 <strncpy+0xd6>
    1c14:	4689                	li	a3,2
    1c16:	b55d                	j	1abc <strncpy+0xb2>
    1c18:	4691                	li	a3,4
    1c1a:	b54d                	j	1abc <strncpy+0xb2>
    1c1c:	4695                	li	a3,5
    1c1e:	bd79                	j	1abc <strncpy+0xb2>
    1c20:	4699                	li	a3,6
    1c22:	bd69                	j	1abc <strncpy+0xb2>
    1c24:	8082                	ret
    1c26:	8082                	ret
    1c28:	8082                	ret

0000000000001c2a <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c2a:	87aa                	mv	a5,a0
    1c2c:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c2e:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c32:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c36:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c38:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c3a:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c3e:	2501                	sext.w	a0,a0
    1c40:	8082                	ret

0000000000001c42 <openat>:
    register long a7 __asm__("a7") = n;
    1c42:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c46:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c4a:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c4e:	2501                	sext.w	a0,a0
    1c50:	8082                	ret

0000000000001c52 <close>:
    register long a7 __asm__("a7") = n;
    1c52:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c56:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c5a:	2501                	sext.w	a0,a0
    1c5c:	8082                	ret

0000000000001c5e <read>:
    register long a7 __asm__("a7") = n;
    1c5e:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c62:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c66:	8082                	ret

0000000000001c68 <write>:
    register long a7 __asm__("a7") = n;
    1c68:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c6c:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c70:	8082                	ret

0000000000001c72 <getpid>:
    register long a7 __asm__("a7") = n;
    1c72:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c76:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c7a:	2501                	sext.w	a0,a0
    1c7c:	8082                	ret

0000000000001c7e <getppid>:
    register long a7 __asm__("a7") = n;
    1c7e:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c82:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c86:	2501                	sext.w	a0,a0
    1c88:	8082                	ret

0000000000001c8a <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c8a:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c8e:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c92:	2501                	sext.w	a0,a0
    1c94:	8082                	ret

0000000000001c96 <fork>:
    register long a7 __asm__("a7") = n;
    1c96:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c9a:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1c9c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c9e:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ca6:	85b2                	mv	a1,a2
    1ca8:	863a                	mv	a2,a4
    if (stack)
    1caa:	c191                	beqz	a1,1cae <clone+0x8>
	stack += stack_size;
    1cac:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cae:	4781                	li	a5,0
    1cb0:	4701                	li	a4,0
    1cb2:	4681                	li	a3,0
    1cb4:	2601                	sext.w	a2,a2
    1cb6:	a2ed                	j	1ea0 <__clone>

0000000000001cb8 <exit>:
    register long a7 __asm__("a7") = n;
    1cb8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cbc:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cc0:	8082                	ret

0000000000001cc2 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc2:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cc6:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cc8:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1ccc:	2501                	sext.w	a0,a0
    1cce:	8082                	ret

0000000000001cd0 <exec>:
    register long a7 __asm__("a7") = n;
    1cd0:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cd4:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cd8:	2501                	sext.w	a0,a0
    1cda:	8082                	ret

0000000000001cdc <execve>:
    register long a7 __asm__("a7") = n;
    1cdc:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ce0:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <times>:
    register long a7 __asm__("a7") = n;
    1ce8:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <get_time>:

int64 get_time()
{
    1cf4:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1cf6:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1cfa:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1cfc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfe:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d02:	2501                	sext.w	a0,a0
    1d04:	ed09                	bnez	a0,1d1e <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d06:	67a2                	ld	a5,8(sp)
    1d08:	3e800713          	li	a4,1000
    1d0c:	00015503          	lhu	a0,0(sp)
    1d10:	02e7d7b3          	divu	a5,a5,a4
    1d14:	02e50533          	mul	a0,a0,a4
    1d18:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d1a:	0141                	addi	sp,sp,16
    1d1c:	8082                	ret
        return -1;
    1d1e:	557d                	li	a0,-1
    1d20:	bfed                	j	1d1a <get_time+0x26>

0000000000001d22 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d22:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d26:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d2a:	2501                	sext.w	a0,a0
    1d2c:	8082                	ret

0000000000001d2e <time>:
    register long a7 __asm__("a7") = n;
    1d2e:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d32:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d36:	2501                	sext.w	a0,a0
    1d38:	8082                	ret

0000000000001d3a <sleep>:

int sleep(unsigned long long time)
{
    1d3a:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d3c:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d3e:	850a                	mv	a0,sp
    1d40:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d42:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d46:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d48:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d4c:	e501                	bnez	a0,1d54 <sleep+0x1a>
    return 0;
    1d4e:	4501                	li	a0,0
}
    1d50:	0141                	addi	sp,sp,16
    1d52:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d54:	4502                	lw	a0,0(sp)
}
    1d56:	0141                	addi	sp,sp,16
    1d58:	8082                	ret

0000000000001d5a <set_priority>:
    register long a7 __asm__("a7") = n;
    1d5a:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d5e:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d66:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d6a:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d6e:	8082                	ret

0000000000001d70 <munmap>:
    register long a7 __asm__("a7") = n;
    1d70:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d74:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d78:	2501                	sext.w	a0,a0
    1d7a:	8082                	ret

0000000000001d7c <wait>:

int wait(int *code)
{
    1d7c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d7e:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d82:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d84:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d86:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d88:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d8c:	2501                	sext.w	a0,a0
    1d8e:	8082                	ret

0000000000001d90 <spawn>:
    register long a7 __asm__("a7") = n;
    1d90:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d94:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d98:	2501                	sext.w	a0,a0
    1d9a:	8082                	ret

0000000000001d9c <mailread>:
    register long a7 __asm__("a7") = n;
    1d9c:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da0:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1da8:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dac:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1db0:	2501                	sext.w	a0,a0
    1db2:	8082                	ret

0000000000001db4 <fstat>:
    register long a7 __asm__("a7") = n;
    1db4:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dc0:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dc2:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dc6:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dc8:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dd0:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dd2:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dd6:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dd8:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1ddc:	2501                	sext.w	a0,a0
    1dde:	8082                	ret

0000000000001de0 <link>:

int link(char *old_path, char *new_path)
{
    1de0:	87aa                	mv	a5,a0
    1de2:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1de4:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1de8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1dec:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1dee:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1df2:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df4:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <unlink>:

int unlink(char *path)
{
    1dfc:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dfe:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e02:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e06:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e08:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e0c:	2501                	sext.w	a0,a0
    1e0e:	8082                	ret

0000000000001e10 <uname>:
    register long a7 __asm__("a7") = n;
    1e10:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e14:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e18:	2501                	sext.w	a0,a0
    1e1a:	8082                	ret

0000000000001e1c <brk>:
    register long a7 __asm__("a7") = n;
    1e1c:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e20:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e24:	2501                	sext.w	a0,a0
    1e26:	8082                	ret

0000000000001e28 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e28:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2a:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e2e:	8082                	ret

0000000000001e30 <chdir>:
    register long a7 __asm__("a7") = n;
    1e30:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e34:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e38:	2501                	sext.w	a0,a0
    1e3a:	8082                	ret

0000000000001e3c <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e3c:	862e                	mv	a2,a1
    1e3e:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e40:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e42:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e46:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e4a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e4c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4e:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e52:	2501                	sext.w	a0,a0
    1e54:	8082                	ret

0000000000001e56 <getdents>:
    register long a7 __asm__("a7") = n;
    1e56:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e5a:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e5e:	2501                	sext.w	a0,a0
    1e60:	8082                	ret

0000000000001e62 <pipe>:
    register long a7 __asm__("a7") = n;
    1e62:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e66:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e68:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e6c:	2501                	sext.w	a0,a0
    1e6e:	8082                	ret

0000000000001e70 <dup>:
    register long a7 __asm__("a7") = n;
    1e70:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e72:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <dup2>:
    register long a7 __asm__("a7") = n;
    1e7a:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e7c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7e:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e82:	2501                	sext.w	a0,a0
    1e84:	8082                	ret

0000000000001e86 <mount>:
    register long a7 __asm__("a7") = n;
    1e86:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e8a:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <umount>:
    register long a7 __asm__("a7") = n;
    1e92:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e96:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e98:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1e9c:	2501                	sext.w	a0,a0
    1e9e:	8082                	ret

0000000000001ea0 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ea0:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ea2:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ea4:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ea6:	8532                	mv	a0,a2
	mv a2, a4
    1ea8:	863a                	mv	a2,a4
	mv a3, a5
    1eaa:	86be                	mv	a3,a5
	mv a4, a6
    1eac:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eae:	0dc00893          	li	a7,220
	ecall
    1eb2:	00000073          	ecall

	beqz a0, 1f
    1eb6:	c111                	beqz	a0,1eba <__clone+0x1a>
	# Parent
	ret
    1eb8:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eba:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ebc:	6522                	ld	a0,8(sp)
	jalr a1
    1ebe:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ec0:	05d00893          	li	a7,93
	ecall
    1ec4:	00000073          	ecall
