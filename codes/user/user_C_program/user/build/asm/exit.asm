
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/exit:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a075                	j	10ae <__start_main>

0000000000001004 <test_exit>:
 * 测试成功则输出：
 * "exit OK."
 * 测试失败则输出：
 * "exit ERR."
 */
void test_exit(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eea50513          	addi	a0,a0,-278 # 1ef0 <__clone+0x2e>
void test_exit(void){
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    TEST_START(__func__);
    1012:	2d4000ef          	jal	ra,12e6 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f7250513          	addi	a0,a0,-142 # 1f88 <__func__.1166>
    101e:	2c8000ef          	jal	ra,12e6 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ee650513          	addi	a0,a0,-282 # 1f08 <__clone+0x46>
    102a:	2bc000ef          	jal	ra,12e6 <puts>
    int cpid, waitret, wstatus;
    cpid = fork();
    102e:	48b000ef          	jal	ra,1cb8 <fork>
    assert(cpid != -1);
    1032:	57fd                	li	a5,-1
    cpid = fork();
    1034:	842a                	mv	s0,a0
    assert(cpid != -1);
    1036:	02f50b63          	beq	a0,a5,106c <test_exit+0x68>
    if(cpid == 0){
    103a:	ed1d                	bnez	a0,1078 <test_exit+0x74>
        exit(0);
    103c:	49f000ef          	jal	ra,1cda <exit>
    }else{
        waitret = wait(&wstatus);
        if(waitret == cpid) printf("exit OK.\n");
        else printf("exit ERR.\n");
    }
    TEST_END(__func__);
    1040:	00001517          	auipc	a0,0x1
    1044:	f1850513          	addi	a0,a0,-232 # 1f58 <__clone+0x96>
    1048:	29e000ef          	jal	ra,12e6 <puts>
    104c:	00001517          	auipc	a0,0x1
    1050:	f3c50513          	addi	a0,a0,-196 # 1f88 <__func__.1166>
    1054:	292000ef          	jal	ra,12e6 <puts>
    1058:	00001517          	auipc	a0,0x1
    105c:	eb050513          	addi	a0,a0,-336 # 1f08 <__clone+0x46>
    1060:	286000ef          	jal	ra,12e6 <puts>
}
    1064:	60e2                	ld	ra,24(sp)
    1066:	6442                	ld	s0,16(sp)
    1068:	6105                	addi	sp,sp,32
    106a:	8082                	ret
    assert(cpid != -1);
    106c:	00001517          	auipc	a0,0x1
    1070:	eac50513          	addi	a0,a0,-340 # 1f18 <__clone+0x56>
    1074:	554000ef          	jal	ra,15c8 <panic>
        waitret = wait(&wstatus);
    1078:	0068                	addi	a0,sp,12
    107a:	525000ef          	jal	ra,1d9e <wait>
        if(waitret == cpid) printf("exit OK.\n");
    107e:	00a40963          	beq	s0,a0,1090 <test_exit+0x8c>
        else printf("exit ERR.\n");
    1082:	00001517          	auipc	a0,0x1
    1086:	ec650513          	addi	a0,a0,-314 # 1f48 <__clone+0x86>
    108a:	27e000ef          	jal	ra,1308 <printf>
    108e:	bf4d                	j	1040 <test_exit+0x3c>
        if(waitret == cpid) printf("exit OK.\n");
    1090:	00001517          	auipc	a0,0x1
    1094:	ea850513          	addi	a0,a0,-344 # 1f38 <__clone+0x76>
    1098:	270000ef          	jal	ra,1308 <printf>
    109c:	b755                	j	1040 <test_exit+0x3c>

000000000000109e <main>:

int main(void){
    109e:	1141                	addi	sp,sp,-16
    10a0:	e406                	sd	ra,8(sp)
    test_exit();
    10a2:	f63ff0ef          	jal	ra,1004 <test_exit>
    return 0;
}
    10a6:	60a2                	ld	ra,8(sp)
    10a8:	4501                	li	a0,0
    10aa:	0141                	addi	sp,sp,16
    10ac:	8082                	ret

00000000000010ae <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ae:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10b0:	4108                	lw	a0,0(a0)
{
    10b2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10b4:	05a1                	addi	a1,a1,8
{
    10b6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10b8:	fe7ff0ef          	jal	ra,109e <main>
    10bc:	41f000ef          	jal	ra,1cda <exit>
	return 0;
}
    10c0:	60a2                	ld	ra,8(sp)
    10c2:	4501                	li	a0,0
    10c4:	0141                	addi	sp,sp,16
    10c6:	8082                	ret

00000000000010c8 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10c8:	7179                	addi	sp,sp,-48
    10ca:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10cc:	12054b63          	bltz	a0,1202 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10d0:	02b577bb          	remuw	a5,a0,a1
    10d4:	00001697          	auipc	a3,0x1
    10d8:	ec468693          	addi	a3,a3,-316 # 1f98 <digits>
    buf[16] = 0;
    10dc:	00010c23          	sb	zero,24(sp)
    i = 15;
    10e0:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10e4:	1782                	slli	a5,a5,0x20
    10e6:	9381                	srli	a5,a5,0x20
    10e8:	97b6                	add	a5,a5,a3
    10ea:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10ee:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10f2:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f6:	16b56263          	bltu	a0,a1,125a <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    10fa:	02e8763b          	remuw	a2,a6,a4
    10fe:	1602                	slli	a2,a2,0x20
    1100:	9201                	srli	a2,a2,0x20
    1102:	9636                	add	a2,a2,a3
    1104:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1108:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    110c:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1110:	12e86963          	bltu	a6,a4,1242 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1114:	02e5f63b          	remuw	a2,a1,a4
    1118:	1602                	slli	a2,a2,0x20
    111a:	9201                	srli	a2,a2,0x20
    111c:	9636                	add	a2,a2,a3
    111e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1122:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1126:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    112a:	10e5ef63          	bltu	a1,a4,1248 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    112e:	02e8763b          	remuw	a2,a6,a4
    1132:	1602                	slli	a2,a2,0x20
    1134:	9201                	srli	a2,a2,0x20
    1136:	9636                	add	a2,a2,a3
    1138:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    113c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1140:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1144:	10e86563          	bltu	a6,a4,124e <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1148:	02e5f63b          	remuw	a2,a1,a4
    114c:	1602                	slli	a2,a2,0x20
    114e:	9201                	srli	a2,a2,0x20
    1150:	9636                	add	a2,a2,a3
    1152:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1156:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    115a:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    115e:	0ee5eb63          	bltu	a1,a4,1254 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1162:	02e8763b          	remuw	a2,a6,a4
    1166:	1602                	slli	a2,a2,0x20
    1168:	9201                	srli	a2,a2,0x20
    116a:	9636                	add	a2,a2,a3
    116c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1170:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1174:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1178:	0ce86263          	bltu	a6,a4,123c <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    117c:	02e5f63b          	remuw	a2,a1,a4
    1180:	1602                	slli	a2,a2,0x20
    1182:	9201                	srli	a2,a2,0x20
    1184:	9636                	add	a2,a2,a3
    1186:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    118a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    118e:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    1192:	0ce5e663          	bltu	a1,a4,125e <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    1196:	02e8763b          	remuw	a2,a6,a4
    119a:	1602                	slli	a2,a2,0x20
    119c:	9201                	srli	a2,a2,0x20
    119e:	9636                	add	a2,a2,a3
    11a0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a4:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a8:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11ac:	0ae86c63          	bltu	a6,a4,1264 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11b0:	02e5f63b          	remuw	a2,a1,a4
    11b4:	1602                	slli	a2,a2,0x20
    11b6:	9201                	srli	a2,a2,0x20
    11b8:	9636                	add	a2,a2,a3
    11ba:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11be:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11c2:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11c6:	0ae5e263          	bltu	a1,a4,126a <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11ca:	1782                	slli	a5,a5,0x20
    11cc:	9381                	srli	a5,a5,0x20
    11ce:	97b6                	add	a5,a5,a3
    11d0:	0007c703          	lbu	a4,0(a5)
    11d4:	4599                	li	a1,6
    11d6:	4795                	li	a5,5
    11d8:	00e10723          	sb	a4,14(sp)

    if (sign)
    11dc:	00055963          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    11e0:	1018                	addi	a4,sp,32
    11e2:	973e                	add	a4,a4,a5
    11e4:	02d00693          	li	a3,45
    11e8:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11ec:	85be                	mv	a1,a5
    write(f, s, l);
    11ee:	003c                	addi	a5,sp,8
    11f0:	4641                	li	a2,16
    11f2:	9e0d                	subw	a2,a2,a1
    11f4:	4505                	li	a0,1
    11f6:	95be                	add	a1,a1,a5
    11f8:	293000ef          	jal	ra,1c8a <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11fc:	70a2                	ld	ra,40(sp)
    11fe:	6145                	addi	sp,sp,48
    1200:	8082                	ret
        x = -xx;
    1202:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1206:	02b677bb          	remuw	a5,a2,a1
    120a:	00001697          	auipc	a3,0x1
    120e:	d8e68693          	addi	a3,a3,-626 # 1f98 <digits>
    buf[16] = 0;
    1212:	00010c23          	sb	zero,24(sp)
    i = 15;
    1216:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    121a:	1782                	slli	a5,a5,0x20
    121c:	9381                	srli	a5,a5,0x20
    121e:	97b6                	add	a5,a5,a3
    1220:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1224:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1228:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    122c:	ecb677e3          	bgeu	a2,a1,10fa <printint.constprop.0+0x32>
        buf[i--] = '-';
    1230:	02d00793          	li	a5,45
    1234:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1238:	45b9                	li	a1,14
    123a:	bf55                	j	11ee <printint.constprop.0+0x126>
    123c:	47a5                	li	a5,9
    123e:	45a9                	li	a1,10
    1240:	bf71                	j	11dc <printint.constprop.0+0x114>
    1242:	47b5                	li	a5,13
    1244:	45b9                	li	a1,14
    1246:	bf59                	j	11dc <printint.constprop.0+0x114>
    1248:	47b1                	li	a5,12
    124a:	45b5                	li	a1,13
    124c:	bf41                	j	11dc <printint.constprop.0+0x114>
    124e:	47ad                	li	a5,11
    1250:	45b1                	li	a1,12
    1252:	b769                	j	11dc <printint.constprop.0+0x114>
    1254:	47a9                	li	a5,10
    1256:	45ad                	li	a1,11
    1258:	b751                	j	11dc <printint.constprop.0+0x114>
    i = 15;
    125a:	45bd                	li	a1,15
    125c:	bf49                	j	11ee <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    125e:	47a1                	li	a5,8
    1260:	45a5                	li	a1,9
    1262:	bfad                	j	11dc <printint.constprop.0+0x114>
    1264:	479d                	li	a5,7
    1266:	45a1                	li	a1,8
    1268:	bf95                	j	11dc <printint.constprop.0+0x114>
    126a:	4799                	li	a5,6
    126c:	459d                	li	a1,7
    126e:	b7bd                	j	11dc <printint.constprop.0+0x114>

0000000000001270 <getchar>:
{
    1270:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1272:	00f10593          	addi	a1,sp,15
    1276:	4605                	li	a2,1
    1278:	4501                	li	a0,0
{
    127a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    127c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1280:	201000ef          	jal	ra,1c80 <read>
}
    1284:	60e2                	ld	ra,24(sp)
    1286:	00f14503          	lbu	a0,15(sp)
    128a:	6105                	addi	sp,sp,32
    128c:	8082                	ret

000000000000128e <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    128e:	00001797          	auipc	a5,0x1
    1292:	d2278793          	addi	a5,a5,-734 # 1fb0 <digits+0x18>
    1296:	04000893          	li	a7,64
    129a:	4505                	li	a0,1
    129c:	85be                	mv	a1,a5
    129e:	4611                	li	a2,4
    12a0:	00000073          	ecall
}
    12a4:	4501                	li	a0,0
    12a6:	8082                	ret

00000000000012a8 <putchar>:
{
    12a8:	1101                	addi	sp,sp,-32
    12aa:	ec06                	sd	ra,24(sp)
    12ac:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12ae:	3e700893          	li	a7,999
    12b2:	4505                	li	a0,1
    12b4:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12b8:	00001717          	auipc	a4,0x1
    12bc:	cf870713          	addi	a4,a4,-776 # 1fb0 <digits+0x18>
    12c0:	04000893          	li	a7,64
    12c4:	4505                	li	a0,1
    12c6:	85ba                	mv	a1,a4
    12c8:	4611                	li	a2,4
    12ca:	00000073          	ecall
    return write(stdout, &byte, 1);
    12ce:	4605                	li	a2,1
    12d0:	00f10593          	addi	a1,sp,15
    12d4:	4505                	li	a0,1
    char byte = c;
    12d6:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12da:	1b1000ef          	jal	ra,1c8a <write>
}
    12de:	60e2                	ld	ra,24(sp)
    12e0:	2501                	sext.w	a0,a0
    12e2:	6105                	addi	sp,sp,32
    12e4:	8082                	ret

00000000000012e6 <puts>:
{
    12e6:	1141                	addi	sp,sp,-16
    12e8:	e406                	sd	ra,8(sp)
    12ea:	e022                	sd	s0,0(sp)
    12ec:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12ee:	5b8000ef          	jal	ra,18a6 <strlen>
    12f2:	862a                	mv	a2,a0
    12f4:	85a2                	mv	a1,s0
    12f6:	4505                	li	a0,1
    12f8:	193000ef          	jal	ra,1c8a <write>
}
    12fc:	60a2                	ld	ra,8(sp)
    12fe:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1300:	957d                	srai	a0,a0,0x3f
    return r;
    1302:	2501                	sext.w	a0,a0
}
    1304:	0141                	addi	sp,sp,16
    1306:	8082                	ret

0000000000001308 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1308:	7171                	addi	sp,sp,-176
    130a:	e0d2                	sd	s4,64(sp)
    130c:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    130e:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1310:	18bc                	addi	a5,sp,120
{
    1312:	e8ca                	sd	s2,80(sp)
    1314:	e4ce                	sd	s3,72(sp)
    1316:	fc56                	sd	s5,56(sp)
    1318:	f85a                	sd	s6,48(sp)
    131a:	f486                	sd	ra,104(sp)
    131c:	f0a2                	sd	s0,96(sp)
    131e:	eca6                	sd	s1,88(sp)
    1320:	fcae                	sd	a1,120(sp)
    1322:	e132                	sd	a2,128(sp)
    1324:	e536                	sd	a3,136(sp)
    1326:	e93a                	sd	a4,144(sp)
    1328:	f142                	sd	a6,160(sp)
    132a:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    132c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    132e:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1332:	00001b17          	auipc	s6,0x1
    1336:	c36b0b13          	addi	s6,s6,-970 # 1f68 <__clone+0xa6>
	::"r"((unsigned long long)ac)
    133a:	00001a97          	auipc	s5,0x1
    133e:	c76a8a93          	addi	s5,s5,-906 # 1fb0 <digits+0x18>
    buf[i++] = '0';
    1342:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1346:	00001997          	auipc	s3,0x1
    134a:	c5298993          	addi	s3,s3,-942 # 1f98 <digits>
        if (!*s)
    134e:	00054783          	lbu	a5,0(a0)
    1352:	16078c63          	beqz	a5,14ca <printf+0x1c2>
    1356:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1358:	19278363          	beq	a5,s2,14de <printf+0x1d6>
    135c:	00164783          	lbu	a5,1(a2)
    1360:	0605                	addi	a2,a2,1
    1362:	fbfd                	bnez	a5,1358 <printf+0x50>
    1364:	84b2                	mv	s1,a2
        l = z - a;
    1366:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    136a:	85aa                	mv	a1,a0
    136c:	8622                	mv	a2,s0
    136e:	4505                	li	a0,1
    1370:	11b000ef          	jal	ra,1c8a <write>
        if (l)
    1374:	18041e63          	bnez	s0,1510 <printf+0x208>
        if (s[1] == 0)
    1378:	0014c783          	lbu	a5,1(s1)
    137c:	14078763          	beqz	a5,14ca <printf+0x1c2>
        switch (s[1])
    1380:	07300713          	li	a4,115
    1384:	1ce78063          	beq	a5,a4,1544 <printf+0x23c>
    1388:	18f76663          	bltu	a4,a5,1514 <printf+0x20c>
    138c:	06400713          	li	a4,100
    1390:	1ae78063          	beq	a5,a4,1530 <printf+0x228>
    1394:	07000713          	li	a4,112
    1398:	1ce79963          	bne	a5,a4,156a <printf+0x262>
            printptr(va_arg(ap, uint64));
    139c:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    139e:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13a2:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13a4:	631c                	ld	a5,0(a4)
    13a6:	0721                	addi	a4,a4,8
    13a8:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13aa:	00479293          	slli	t0,a5,0x4
    13ae:	00879f93          	slli	t6,a5,0x8
    13b2:	00c79f13          	slli	t5,a5,0xc
    13b6:	01079e93          	slli	t4,a5,0x10
    13ba:	01479e13          	slli	t3,a5,0x14
    13be:	01879313          	slli	t1,a5,0x18
    13c2:	01c79893          	slli	a7,a5,0x1c
    13c6:	02479813          	slli	a6,a5,0x24
    13ca:	02879513          	slli	a0,a5,0x28
    13ce:	02c79593          	slli	a1,a5,0x2c
    13d2:	03079693          	slli	a3,a5,0x30
    13d6:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13da:	03c7d413          	srli	s0,a5,0x3c
    13de:	01c7d39b          	srliw	t2,a5,0x1c
    13e2:	03c2d293          	srli	t0,t0,0x3c
    13e6:	03cfdf93          	srli	t6,t6,0x3c
    13ea:	03cf5f13          	srli	t5,t5,0x3c
    13ee:	03cede93          	srli	t4,t4,0x3c
    13f2:	03ce5e13          	srli	t3,t3,0x3c
    13f6:	03c35313          	srli	t1,t1,0x3c
    13fa:	03c8d893          	srli	a7,a7,0x3c
    13fe:	03c85813          	srli	a6,a6,0x3c
    1402:	9171                	srli	a0,a0,0x3c
    1404:	91f1                	srli	a1,a1,0x3c
    1406:	92f1                	srli	a3,a3,0x3c
    1408:	9371                	srli	a4,a4,0x3c
    140a:	96ce                	add	a3,a3,s3
    140c:	974e                	add	a4,a4,s3
    140e:	944e                	add	s0,s0,s3
    1410:	92ce                	add	t0,t0,s3
    1412:	9fce                	add	t6,t6,s3
    1414:	9f4e                	add	t5,t5,s3
    1416:	9ece                	add	t4,t4,s3
    1418:	9e4e                	add	t3,t3,s3
    141a:	934e                	add	t1,t1,s3
    141c:	98ce                	add	a7,a7,s3
    141e:	93ce                	add	t2,t2,s3
    1420:	984e                	add	a6,a6,s3
    1422:	954e                	add	a0,a0,s3
    1424:	95ce                	add	a1,a1,s3
    1426:	0006c083          	lbu	ra,0(a3)
    142a:	0002c283          	lbu	t0,0(t0)
    142e:	00074683          	lbu	a3,0(a4)
    1432:	000fcf83          	lbu	t6,0(t6)
    1436:	000f4f03          	lbu	t5,0(t5)
    143a:	000ece83          	lbu	t4,0(t4)
    143e:	000e4e03          	lbu	t3,0(t3)
    1442:	00034303          	lbu	t1,0(t1)
    1446:	0008c883          	lbu	a7,0(a7)
    144a:	0003c383          	lbu	t2,0(t2)
    144e:	00084803          	lbu	a6,0(a6)
    1452:	00054503          	lbu	a0,0(a0)
    1456:	0005c583          	lbu	a1,0(a1)
    145a:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    145e:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1462:	9371                	srli	a4,a4,0x3c
    1464:	8bbd                	andi	a5,a5,15
    1466:	974e                	add	a4,a4,s3
    1468:	97ce                	add	a5,a5,s3
    146a:	005105a3          	sb	t0,11(sp)
    146e:	01f10623          	sb	t6,12(sp)
    1472:	01e106a3          	sb	t5,13(sp)
    1476:	01d10723          	sb	t4,14(sp)
    147a:	01c107a3          	sb	t3,15(sp)
    147e:	00610823          	sb	t1,16(sp)
    1482:	011108a3          	sb	a7,17(sp)
    1486:	00710923          	sb	t2,18(sp)
    148a:	010109a3          	sb	a6,19(sp)
    148e:	00a10a23          	sb	a0,20(sp)
    1492:	00b10aa3          	sb	a1,21(sp)
    1496:	00110b23          	sb	ra,22(sp)
    149a:	00d10ba3          	sb	a3,23(sp)
    149e:	00810523          	sb	s0,10(sp)
    14a2:	00074703          	lbu	a4,0(a4)
    14a6:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14aa:	002c                	addi	a1,sp,8
    14ac:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ae:	00e10c23          	sb	a4,24(sp)
    14b2:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14b6:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14ba:	7d0000ef          	jal	ra,1c8a <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14be:	00248513          	addi	a0,s1,2
        if (!*s)
    14c2:	00054783          	lbu	a5,0(a0)
    14c6:	e80798e3          	bnez	a5,1356 <printf+0x4e>
    }
    va_end(ap);
}
    14ca:	70a6                	ld	ra,104(sp)
    14cc:	7406                	ld	s0,96(sp)
    14ce:	64e6                	ld	s1,88(sp)
    14d0:	6946                	ld	s2,80(sp)
    14d2:	69a6                	ld	s3,72(sp)
    14d4:	6a06                	ld	s4,64(sp)
    14d6:	7ae2                	ld	s5,56(sp)
    14d8:	7b42                	ld	s6,48(sp)
    14da:	614d                	addi	sp,sp,176
    14dc:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14de:	00064783          	lbu	a5,0(a2)
    14e2:	84b2                	mv	s1,a2
    14e4:	01278963          	beq	a5,s2,14f6 <printf+0x1ee>
    14e8:	bdbd                	j	1366 <printf+0x5e>
    14ea:	0024c783          	lbu	a5,2(s1)
    14ee:	0605                	addi	a2,a2,1
    14f0:	0489                	addi	s1,s1,2
    14f2:	e7279ae3          	bne	a5,s2,1366 <printf+0x5e>
    14f6:	0014c783          	lbu	a5,1(s1)
    14fa:	ff2788e3          	beq	a5,s2,14ea <printf+0x1e2>
        l = z - a;
    14fe:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1502:	85aa                	mv	a1,a0
    1504:	8622                	mv	a2,s0
    1506:	4505                	li	a0,1
    1508:	782000ef          	jal	ra,1c8a <write>
        if (l)
    150c:	e60406e3          	beqz	s0,1378 <printf+0x70>
    1510:	8526                	mv	a0,s1
    1512:	bd35                	j	134e <printf+0x46>
        switch (s[1])
    1514:	07800713          	li	a4,120
    1518:	04e79963          	bne	a5,a4,156a <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    151c:	6782                	ld	a5,0(sp)
    151e:	45c1                	li	a1,16
    1520:	4388                	lw	a0,0(a5)
    1522:	07a1                	addi	a5,a5,8
    1524:	e03e                	sd	a5,0(sp)
    1526:	ba3ff0ef          	jal	ra,10c8 <printint.constprop.0>
        s += 2;
    152a:	00248513          	addi	a0,s1,2
    152e:	bf51                	j	14c2 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1530:	6782                	ld	a5,0(sp)
    1532:	45a9                	li	a1,10
    1534:	4388                	lw	a0,0(a5)
    1536:	07a1                	addi	a5,a5,8
    1538:	e03e                	sd	a5,0(sp)
    153a:	b8fff0ef          	jal	ra,10c8 <printint.constprop.0>
        s += 2;
    153e:	00248513          	addi	a0,s1,2
    1542:	b741                	j	14c2 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1544:	6782                	ld	a5,0(sp)
    1546:	6380                	ld	s0,0(a5)
    1548:	07a1                	addi	a5,a5,8
    154a:	e03e                	sd	a5,0(sp)
    154c:	cc25                	beqz	s0,15c4 <printf+0x2bc>
            l = strnlen(a, 200);
    154e:	0c800593          	li	a1,200
    1552:	8522                	mv	a0,s0
    1554:	43e000ef          	jal	ra,1992 <strnlen>
    write(f, s, l);
    1558:	0005061b          	sext.w	a2,a0
    155c:	85a2                	mv	a1,s0
    155e:	4505                	li	a0,1
    1560:	72a000ef          	jal	ra,1c8a <write>
        s += 2;
    1564:	00248513          	addi	a0,s1,2
    1568:	bfa9                	j	14c2 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    156a:	3e700893          	li	a7,999
    156e:	4505                	li	a0,1
    1570:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1574:	04000893          	li	a7,64
    1578:	4505                	li	a0,1
    157a:	85d6                	mv	a1,s5
    157c:	4611                	li	a2,4
    157e:	00000073          	ecall
    char byte = c;
    1582:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    1586:	4605                	li	a2,1
    1588:	002c                	addi	a1,sp,8
    158a:	4505                	li	a0,1
    char byte = c;
    158c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1590:	6fa000ef          	jal	ra,1c8a <write>
            putchar(s[1]);
    1594:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1598:	3e700893          	li	a7,999
    159c:	4505                	li	a0,1
    159e:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15a2:	04000893          	li	a7,64
    15a6:	4505                	li	a0,1
    15a8:	85d6                	mv	a1,s5
    15aa:	4611                	li	a2,4
    15ac:	00000073          	ecall
    return write(stdout, &byte, 1);
    15b0:	4605                	li	a2,1
    15b2:	002c                	addi	a1,sp,8
    15b4:	4505                	li	a0,1
    char byte = c;
    15b6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ba:	6d0000ef          	jal	ra,1c8a <write>
        s += 2;
    15be:	00248513          	addi	a0,s1,2
    15c2:	b701                	j	14c2 <printf+0x1ba>
                a = "(null)";
    15c4:	845a                	mv	s0,s6
    15c6:	b761                	j	154e <printf+0x246>

00000000000015c8 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15c8:	1141                	addi	sp,sp,-16
    15ca:	e406                	sd	ra,8(sp)
    puts(m);
    15cc:	d1bff0ef          	jal	ra,12e6 <puts>
    exit(-100);
}
    15d0:	60a2                	ld	ra,8(sp)
    exit(-100);
    15d2:	f9c00513          	li	a0,-100
}
    15d6:	0141                	addi	sp,sp,16
    exit(-100);
    15d8:	a709                	j	1cda <exit>

00000000000015da <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15da:	02000793          	li	a5,32
    15de:	00f50663          	beq	a0,a5,15ea <isspace+0x10>
    15e2:	355d                	addiw	a0,a0,-9
    15e4:	00553513          	sltiu	a0,a0,5
    15e8:	8082                	ret
    15ea:	4505                	li	a0,1
}
    15ec:	8082                	ret

00000000000015ee <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15ee:	fd05051b          	addiw	a0,a0,-48
}
    15f2:	00a53513          	sltiu	a0,a0,10
    15f6:	8082                	ret

00000000000015f8 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f8:	02000613          	li	a2,32
    15fc:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15fe:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1602:	ff77069b          	addiw	a3,a4,-9
    1606:	04c70d63          	beq	a4,a2,1660 <atoi+0x68>
    160a:	0007079b          	sext.w	a5,a4
    160e:	04d5f963          	bgeu	a1,a3,1660 <atoi+0x68>
        s++;
    switch (*s)
    1612:	02b00693          	li	a3,43
    1616:	04d70a63          	beq	a4,a3,166a <atoi+0x72>
    161a:	02d00693          	li	a3,45
    161e:	06d70463          	beq	a4,a3,1686 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1622:	fd07859b          	addiw	a1,a5,-48
    1626:	4625                	li	a2,9
    1628:	873e                	mv	a4,a5
    162a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    162c:	4e01                	li	t3,0
    while (isdigit(*s))
    162e:	04b66a63          	bltu	a2,a1,1682 <atoi+0x8a>
    int n = 0, neg = 0;
    1632:	4501                	li	a0,0
    while (isdigit(*s))
    1634:	4825                	li	a6,9
    1636:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    163a:	0025179b          	slliw	a5,a0,0x2
    163e:	9d3d                	addw	a0,a0,a5
    1640:	fd07031b          	addiw	t1,a4,-48
    1644:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1648:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    164c:	0685                	addi	a3,a3,1
    164e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1652:	0006071b          	sext.w	a4,a2
    1656:	feb870e3          	bgeu	a6,a1,1636 <atoi+0x3e>
    return neg ? n : -n;
    165a:	000e0563          	beqz	t3,1664 <atoi+0x6c>
}
    165e:	8082                	ret
        s++;
    1660:	0505                	addi	a0,a0,1
    1662:	bf71                	j	15fe <atoi+0x6>
    1664:	4113053b          	subw	a0,t1,a7
    1668:	8082                	ret
    while (isdigit(*s))
    166a:	00154783          	lbu	a5,1(a0)
    166e:	4625                	li	a2,9
        s++;
    1670:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1674:	fd07859b          	addiw	a1,a5,-48
    1678:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    167c:	4e01                	li	t3,0
    while (isdigit(*s))
    167e:	fab67ae3          	bgeu	a2,a1,1632 <atoi+0x3a>
    1682:	4501                	li	a0,0
}
    1684:	8082                	ret
    while (isdigit(*s))
    1686:	00154783          	lbu	a5,1(a0)
    168a:	4625                	li	a2,9
        s++;
    168c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1690:	fd07859b          	addiw	a1,a5,-48
    1694:	0007871b          	sext.w	a4,a5
    1698:	feb665e3          	bltu	a2,a1,1682 <atoi+0x8a>
        neg = 1;
    169c:	4e05                	li	t3,1
    169e:	bf51                	j	1632 <atoi+0x3a>

00000000000016a0 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16a0:	16060d63          	beqz	a2,181a <memset+0x17a>
    16a4:	40a007b3          	neg	a5,a0
    16a8:	8b9d                	andi	a5,a5,7
    16aa:	00778713          	addi	a4,a5,7
    16ae:	482d                	li	a6,11
    16b0:	0ff5f593          	zext.b	a1,a1
    16b4:	fff60693          	addi	a3,a2,-1
    16b8:	17076263          	bltu	a4,a6,181c <memset+0x17c>
    16bc:	16e6ea63          	bltu	a3,a4,1830 <memset+0x190>
    16c0:	16078563          	beqz	a5,182a <memset+0x18a>
    16c4:	00b50023          	sb	a1,0(a0)
    16c8:	4705                	li	a4,1
    16ca:	00150e93          	addi	t4,a0,1
    16ce:	14e78c63          	beq	a5,a4,1826 <memset+0x186>
    16d2:	00b500a3          	sb	a1,1(a0)
    16d6:	4709                	li	a4,2
    16d8:	00250e93          	addi	t4,a0,2
    16dc:	14e78d63          	beq	a5,a4,1836 <memset+0x196>
    16e0:	00b50123          	sb	a1,2(a0)
    16e4:	470d                	li	a4,3
    16e6:	00350e93          	addi	t4,a0,3
    16ea:	12e78b63          	beq	a5,a4,1820 <memset+0x180>
    16ee:	00b501a3          	sb	a1,3(a0)
    16f2:	4711                	li	a4,4
    16f4:	00450e93          	addi	t4,a0,4
    16f8:	14e78163          	beq	a5,a4,183a <memset+0x19a>
    16fc:	00b50223          	sb	a1,4(a0)
    1700:	4715                	li	a4,5
    1702:	00550e93          	addi	t4,a0,5
    1706:	12e78c63          	beq	a5,a4,183e <memset+0x19e>
    170a:	00b502a3          	sb	a1,5(a0)
    170e:	471d                	li	a4,7
    1710:	00650e93          	addi	t4,a0,6
    1714:	12e79763          	bne	a5,a4,1842 <memset+0x1a2>
    1718:	00750e93          	addi	t4,a0,7
    171c:	00b50323          	sb	a1,6(a0)
    1720:	4f1d                	li	t5,7
    1722:	00859713          	slli	a4,a1,0x8
    1726:	8f4d                	or	a4,a4,a1
    1728:	01059e13          	slli	t3,a1,0x10
    172c:	01c76e33          	or	t3,a4,t3
    1730:	01859313          	slli	t1,a1,0x18
    1734:	006e6333          	or	t1,t3,t1
    1738:	02059893          	slli	a7,a1,0x20
    173c:	011368b3          	or	a7,t1,a7
    1740:	02859813          	slli	a6,a1,0x28
    1744:	40f60333          	sub	t1,a2,a5
    1748:	0108e833          	or	a6,a7,a6
    174c:	03059693          	slli	a3,a1,0x30
    1750:	00d866b3          	or	a3,a6,a3
    1754:	03859713          	slli	a4,a1,0x38
    1758:	97aa                	add	a5,a5,a0
    175a:	ff837813          	andi	a6,t1,-8
    175e:	8f55                	or	a4,a4,a3
    1760:	00f806b3          	add	a3,a6,a5
    1764:	e398                	sd	a4,0(a5)
    1766:	07a1                	addi	a5,a5,8
    1768:	fed79ee3          	bne	a5,a3,1764 <memset+0xc4>
    176c:	ff837693          	andi	a3,t1,-8
    1770:	00de87b3          	add	a5,t4,a3
    1774:	01e6873b          	addw	a4,a3,t5
    1778:	0ad30663          	beq	t1,a3,1824 <memset+0x184>
    177c:	00b78023          	sb	a1,0(a5)
    1780:	0017069b          	addiw	a3,a4,1
    1784:	08c6fb63          	bgeu	a3,a2,181a <memset+0x17a>
    1788:	00b780a3          	sb	a1,1(a5)
    178c:	0027069b          	addiw	a3,a4,2
    1790:	08c6f563          	bgeu	a3,a2,181a <memset+0x17a>
    1794:	00b78123          	sb	a1,2(a5)
    1798:	0037069b          	addiw	a3,a4,3
    179c:	06c6ff63          	bgeu	a3,a2,181a <memset+0x17a>
    17a0:	00b781a3          	sb	a1,3(a5)
    17a4:	0047069b          	addiw	a3,a4,4
    17a8:	06c6f963          	bgeu	a3,a2,181a <memset+0x17a>
    17ac:	00b78223          	sb	a1,4(a5)
    17b0:	0057069b          	addiw	a3,a4,5
    17b4:	06c6f363          	bgeu	a3,a2,181a <memset+0x17a>
    17b8:	00b782a3          	sb	a1,5(a5)
    17bc:	0067069b          	addiw	a3,a4,6
    17c0:	04c6fd63          	bgeu	a3,a2,181a <memset+0x17a>
    17c4:	00b78323          	sb	a1,6(a5)
    17c8:	0077069b          	addiw	a3,a4,7
    17cc:	04c6f763          	bgeu	a3,a2,181a <memset+0x17a>
    17d0:	00b783a3          	sb	a1,7(a5)
    17d4:	0087069b          	addiw	a3,a4,8
    17d8:	04c6f163          	bgeu	a3,a2,181a <memset+0x17a>
    17dc:	00b78423          	sb	a1,8(a5)
    17e0:	0097069b          	addiw	a3,a4,9
    17e4:	02c6fb63          	bgeu	a3,a2,181a <memset+0x17a>
    17e8:	00b784a3          	sb	a1,9(a5)
    17ec:	00a7069b          	addiw	a3,a4,10
    17f0:	02c6f563          	bgeu	a3,a2,181a <memset+0x17a>
    17f4:	00b78523          	sb	a1,10(a5)
    17f8:	00b7069b          	addiw	a3,a4,11
    17fc:	00c6ff63          	bgeu	a3,a2,181a <memset+0x17a>
    1800:	00b785a3          	sb	a1,11(a5)
    1804:	00c7069b          	addiw	a3,a4,12
    1808:	00c6f963          	bgeu	a3,a2,181a <memset+0x17a>
    180c:	00b78623          	sb	a1,12(a5)
    1810:	2735                	addiw	a4,a4,13
    1812:	00c77463          	bgeu	a4,a2,181a <memset+0x17a>
    1816:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    181a:	8082                	ret
    181c:	472d                	li	a4,11
    181e:	bd79                	j	16bc <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1820:	4f0d                	li	t5,3
    1822:	b701                	j	1722 <memset+0x82>
    1824:	8082                	ret
    1826:	4f05                	li	t5,1
    1828:	bded                	j	1722 <memset+0x82>
    182a:	8eaa                	mv	t4,a0
    182c:	4f01                	li	t5,0
    182e:	bdd5                	j	1722 <memset+0x82>
    1830:	87aa                	mv	a5,a0
    1832:	4701                	li	a4,0
    1834:	b7a1                	j	177c <memset+0xdc>
    1836:	4f09                	li	t5,2
    1838:	b5ed                	j	1722 <memset+0x82>
    183a:	4f11                	li	t5,4
    183c:	b5dd                	j	1722 <memset+0x82>
    183e:	4f15                	li	t5,5
    1840:	b5cd                	j	1722 <memset+0x82>
    1842:	4f19                	li	t5,6
    1844:	bdf9                	j	1722 <memset+0x82>

0000000000001846 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1846:	00054783          	lbu	a5,0(a0)
    184a:	0005c703          	lbu	a4,0(a1)
    184e:	00e79863          	bne	a5,a4,185e <strcmp+0x18>
    1852:	0505                	addi	a0,a0,1
    1854:	0585                	addi	a1,a1,1
    1856:	fbe5                	bnez	a5,1846 <strcmp>
    1858:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    185a:	9d19                	subw	a0,a0,a4
    185c:	8082                	ret
    185e:	0007851b          	sext.w	a0,a5
    1862:	bfe5                	j	185a <strcmp+0x14>

0000000000001864 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1864:	ce05                	beqz	a2,189c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1866:	00054703          	lbu	a4,0(a0)
    186a:	0005c783          	lbu	a5,0(a1)
    186e:	cb0d                	beqz	a4,18a0 <strncmp+0x3c>
    if (!n--)
    1870:	167d                	addi	a2,a2,-1
    1872:	00c506b3          	add	a3,a0,a2
    1876:	a819                	j	188c <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1878:	00a68e63          	beq	a3,a0,1894 <strncmp+0x30>
    187c:	0505                	addi	a0,a0,1
    187e:	00e79b63          	bne	a5,a4,1894 <strncmp+0x30>
    1882:	00054703          	lbu	a4,0(a0)
    1886:	0005c783          	lbu	a5,0(a1)
    188a:	cb19                	beqz	a4,18a0 <strncmp+0x3c>
    188c:	0005c783          	lbu	a5,0(a1)
    1890:	0585                	addi	a1,a1,1
    1892:	f3fd                	bnez	a5,1878 <strncmp+0x14>
        ;
    return *l - *r;
    1894:	0007051b          	sext.w	a0,a4
    1898:	9d1d                	subw	a0,a0,a5
    189a:	8082                	ret
        return 0;
    189c:	4501                	li	a0,0
}
    189e:	8082                	ret
    18a0:	4501                	li	a0,0
    return *l - *r;
    18a2:	9d1d                	subw	a0,a0,a5
    18a4:	8082                	ret

00000000000018a6 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18a6:	00757793          	andi	a5,a0,7
    18aa:	cf89                	beqz	a5,18c4 <strlen+0x1e>
    18ac:	87aa                	mv	a5,a0
    18ae:	a029                	j	18b8 <strlen+0x12>
    18b0:	0785                	addi	a5,a5,1
    18b2:	0077f713          	andi	a4,a5,7
    18b6:	cb01                	beqz	a4,18c6 <strlen+0x20>
        if (!*s)
    18b8:	0007c703          	lbu	a4,0(a5)
    18bc:	fb75                	bnez	a4,18b0 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18be:	40a78533          	sub	a0,a5,a0
}
    18c2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18c4:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18c6:	6394                	ld	a3,0(a5)
    18c8:	00000597          	auipc	a1,0x0
    18cc:	6a85b583          	ld	a1,1704(a1) # 1f70 <__clone+0xae>
    18d0:	00000617          	auipc	a2,0x0
    18d4:	6a863603          	ld	a2,1704(a2) # 1f78 <__clone+0xb6>
    18d8:	a019                	j	18de <strlen+0x38>
    18da:	6794                	ld	a3,8(a5)
    18dc:	07a1                	addi	a5,a5,8
    18de:	00b68733          	add	a4,a3,a1
    18e2:	fff6c693          	not	a3,a3
    18e6:	8f75                	and	a4,a4,a3
    18e8:	8f71                	and	a4,a4,a2
    18ea:	db65                	beqz	a4,18da <strlen+0x34>
    for (; *s; s++)
    18ec:	0007c703          	lbu	a4,0(a5)
    18f0:	d779                	beqz	a4,18be <strlen+0x18>
    18f2:	0017c703          	lbu	a4,1(a5)
    18f6:	0785                	addi	a5,a5,1
    18f8:	d379                	beqz	a4,18be <strlen+0x18>
    18fa:	0017c703          	lbu	a4,1(a5)
    18fe:	0785                	addi	a5,a5,1
    1900:	fb6d                	bnez	a4,18f2 <strlen+0x4c>
    1902:	bf75                	j	18be <strlen+0x18>

0000000000001904 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1904:	00757713          	andi	a4,a0,7
{
    1908:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    190a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    190e:	cb19                	beqz	a4,1924 <memchr+0x20>
    1910:	ce25                	beqz	a2,1988 <memchr+0x84>
    1912:	0007c703          	lbu	a4,0(a5)
    1916:	04b70e63          	beq	a4,a1,1972 <memchr+0x6e>
    191a:	0785                	addi	a5,a5,1
    191c:	0077f713          	andi	a4,a5,7
    1920:	167d                	addi	a2,a2,-1
    1922:	f77d                	bnez	a4,1910 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1924:	4501                	li	a0,0
    if (n && *s != c)
    1926:	c235                	beqz	a2,198a <memchr+0x86>
    1928:	0007c703          	lbu	a4,0(a5)
    192c:	04b70363          	beq	a4,a1,1972 <memchr+0x6e>
        size_t k = ONES * c;
    1930:	00000517          	auipc	a0,0x0
    1934:	65053503          	ld	a0,1616(a0) # 1f80 <__clone+0xbe>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1938:	471d                	li	a4,7
        size_t k = ONES * c;
    193a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    193e:	02c77a63          	bgeu	a4,a2,1972 <memchr+0x6e>
    1942:	00000897          	auipc	a7,0x0
    1946:	62e8b883          	ld	a7,1582(a7) # 1f70 <__clone+0xae>
    194a:	00000817          	auipc	a6,0x0
    194e:	62e83803          	ld	a6,1582(a6) # 1f78 <__clone+0xb6>
    1952:	431d                	li	t1,7
    1954:	a029                	j	195e <memchr+0x5a>
    1956:	1661                	addi	a2,a2,-8
    1958:	07a1                	addi	a5,a5,8
    195a:	02c37963          	bgeu	t1,a2,198c <memchr+0x88>
    195e:	6398                	ld	a4,0(a5)
    1960:	8f29                	xor	a4,a4,a0
    1962:	011706b3          	add	a3,a4,a7
    1966:	fff74713          	not	a4,a4
    196a:	8f75                	and	a4,a4,a3
    196c:	01077733          	and	a4,a4,a6
    1970:	d37d                	beqz	a4,1956 <memchr+0x52>
    1972:	853e                	mv	a0,a5
    1974:	97b2                	add	a5,a5,a2
    1976:	a021                	j	197e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1978:	0505                	addi	a0,a0,1
    197a:	00f50763          	beq	a0,a5,1988 <memchr+0x84>
    197e:	00054703          	lbu	a4,0(a0)
    1982:	feb71be3          	bne	a4,a1,1978 <memchr+0x74>
    1986:	8082                	ret
    return n ? (void *)s : 0;
    1988:	4501                	li	a0,0
}
    198a:	8082                	ret
    return n ? (void *)s : 0;
    198c:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    198e:	f275                	bnez	a2,1972 <memchr+0x6e>
}
    1990:	8082                	ret

0000000000001992 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1992:	1101                	addi	sp,sp,-32
    1994:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1996:	862e                	mv	a2,a1
{
    1998:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    199a:	4581                	li	a1,0
{
    199c:	e426                	sd	s1,8(sp)
    199e:	ec06                	sd	ra,24(sp)
    19a0:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19a2:	f63ff0ef          	jal	ra,1904 <memchr>
    return p ? p - s : n;
    19a6:	c519                	beqz	a0,19b4 <strnlen+0x22>
}
    19a8:	60e2                	ld	ra,24(sp)
    19aa:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19ac:	8d05                	sub	a0,a0,s1
}
    19ae:	64a2                	ld	s1,8(sp)
    19b0:	6105                	addi	sp,sp,32
    19b2:	8082                	ret
    19b4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19b6:	8522                	mv	a0,s0
}
    19b8:	6442                	ld	s0,16(sp)
    19ba:	64a2                	ld	s1,8(sp)
    19bc:	6105                	addi	sp,sp,32
    19be:	8082                	ret

00000000000019c0 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19c0:	00b547b3          	xor	a5,a0,a1
    19c4:	8b9d                	andi	a5,a5,7
    19c6:	eb95                	bnez	a5,19fa <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19c8:	0075f793          	andi	a5,a1,7
    19cc:	e7b1                	bnez	a5,1a18 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ce:	6198                	ld	a4,0(a1)
    19d0:	00000617          	auipc	a2,0x0
    19d4:	5a063603          	ld	a2,1440(a2) # 1f70 <__clone+0xae>
    19d8:	00000817          	auipc	a6,0x0
    19dc:	5a083803          	ld	a6,1440(a6) # 1f78 <__clone+0xb6>
    19e0:	a029                	j	19ea <strcpy+0x2a>
    19e2:	e118                	sd	a4,0(a0)
    19e4:	6598                	ld	a4,8(a1)
    19e6:	05a1                	addi	a1,a1,8
    19e8:	0521                	addi	a0,a0,8
    19ea:	00c707b3          	add	a5,a4,a2
    19ee:	fff74693          	not	a3,a4
    19f2:	8ff5                	and	a5,a5,a3
    19f4:	0107f7b3          	and	a5,a5,a6
    19f8:	d7ed                	beqz	a5,19e2 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19fa:	0005c783          	lbu	a5,0(a1)
    19fe:	00f50023          	sb	a5,0(a0)
    1a02:	c785                	beqz	a5,1a2a <strcpy+0x6a>
    1a04:	0015c783          	lbu	a5,1(a1)
    1a08:	0505                	addi	a0,a0,1
    1a0a:	0585                	addi	a1,a1,1
    1a0c:	00f50023          	sb	a5,0(a0)
    1a10:	fbf5                	bnez	a5,1a04 <strcpy+0x44>
        ;
    return d;
}
    1a12:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a14:	0505                	addi	a0,a0,1
    1a16:	df45                	beqz	a4,19ce <strcpy+0xe>
            if (!(*d = *s))
    1a18:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a1c:	0585                	addi	a1,a1,1
    1a1e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a22:	00f50023          	sb	a5,0(a0)
    1a26:	f7fd                	bnez	a5,1a14 <strcpy+0x54>
}
    1a28:	8082                	ret
    1a2a:	8082                	ret

0000000000001a2c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a2c:	00b547b3          	xor	a5,a0,a1
    1a30:	8b9d                	andi	a5,a5,7
    1a32:	1a079863          	bnez	a5,1be2 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a36:	0075f793          	andi	a5,a1,7
    1a3a:	16078463          	beqz	a5,1ba2 <strncpy+0x176>
    1a3e:	ea01                	bnez	a2,1a4e <strncpy+0x22>
    1a40:	a421                	j	1c48 <strncpy+0x21c>
    1a42:	167d                	addi	a2,a2,-1
    1a44:	0505                	addi	a0,a0,1
    1a46:	14070e63          	beqz	a4,1ba2 <strncpy+0x176>
    1a4a:	1a060863          	beqz	a2,1bfa <strncpy+0x1ce>
    1a4e:	0005c783          	lbu	a5,0(a1)
    1a52:	0585                	addi	a1,a1,1
    1a54:	0075f713          	andi	a4,a1,7
    1a58:	00f50023          	sb	a5,0(a0)
    1a5c:	f3fd                	bnez	a5,1a42 <strncpy+0x16>
    1a5e:	4805                	li	a6,1
    1a60:	1a061863          	bnez	a2,1c10 <strncpy+0x1e4>
    1a64:	40a007b3          	neg	a5,a0
    1a68:	8b9d                	andi	a5,a5,7
    1a6a:	4681                	li	a3,0
    1a6c:	18061a63          	bnez	a2,1c00 <strncpy+0x1d4>
    1a70:	00778713          	addi	a4,a5,7
    1a74:	45ad                	li	a1,11
    1a76:	18b76363          	bltu	a4,a1,1bfc <strncpy+0x1d0>
    1a7a:	1ae6eb63          	bltu	a3,a4,1c30 <strncpy+0x204>
    1a7e:	1a078363          	beqz	a5,1c24 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a82:	00050023          	sb	zero,0(a0)
    1a86:	4685                	li	a3,1
    1a88:	00150713          	addi	a4,a0,1
    1a8c:	18d78f63          	beq	a5,a3,1c2a <strncpy+0x1fe>
    1a90:	000500a3          	sb	zero,1(a0)
    1a94:	4689                	li	a3,2
    1a96:	00250713          	addi	a4,a0,2
    1a9a:	18d78e63          	beq	a5,a3,1c36 <strncpy+0x20a>
    1a9e:	00050123          	sb	zero,2(a0)
    1aa2:	468d                	li	a3,3
    1aa4:	00350713          	addi	a4,a0,3
    1aa8:	16d78c63          	beq	a5,a3,1c20 <strncpy+0x1f4>
    1aac:	000501a3          	sb	zero,3(a0)
    1ab0:	4691                	li	a3,4
    1ab2:	00450713          	addi	a4,a0,4
    1ab6:	18d78263          	beq	a5,a3,1c3a <strncpy+0x20e>
    1aba:	00050223          	sb	zero,4(a0)
    1abe:	4695                	li	a3,5
    1ac0:	00550713          	addi	a4,a0,5
    1ac4:	16d78d63          	beq	a5,a3,1c3e <strncpy+0x212>
    1ac8:	000502a3          	sb	zero,5(a0)
    1acc:	469d                	li	a3,7
    1ace:	00650713          	addi	a4,a0,6
    1ad2:	16d79863          	bne	a5,a3,1c42 <strncpy+0x216>
    1ad6:	00750713          	addi	a4,a0,7
    1ada:	00050323          	sb	zero,6(a0)
    1ade:	40f80833          	sub	a6,a6,a5
    1ae2:	ff887593          	andi	a1,a6,-8
    1ae6:	97aa                	add	a5,a5,a0
    1ae8:	95be                	add	a1,a1,a5
    1aea:	0007b023          	sd	zero,0(a5)
    1aee:	07a1                	addi	a5,a5,8
    1af0:	feb79de3          	bne	a5,a1,1aea <strncpy+0xbe>
    1af4:	ff887593          	andi	a1,a6,-8
    1af8:	9ead                	addw	a3,a3,a1
    1afa:	00b707b3          	add	a5,a4,a1
    1afe:	12b80863          	beq	a6,a1,1c2e <strncpy+0x202>
    1b02:	00078023          	sb	zero,0(a5)
    1b06:	0016871b          	addiw	a4,a3,1
    1b0a:	0ec77863          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b0e:	000780a3          	sb	zero,1(a5)
    1b12:	0026871b          	addiw	a4,a3,2
    1b16:	0ec77263          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b1a:	00078123          	sb	zero,2(a5)
    1b1e:	0036871b          	addiw	a4,a3,3
    1b22:	0cc77c63          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b26:	000781a3          	sb	zero,3(a5)
    1b2a:	0046871b          	addiw	a4,a3,4
    1b2e:	0cc77663          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b32:	00078223          	sb	zero,4(a5)
    1b36:	0056871b          	addiw	a4,a3,5
    1b3a:	0cc77063          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b3e:	000782a3          	sb	zero,5(a5)
    1b42:	0066871b          	addiw	a4,a3,6
    1b46:	0ac77a63          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b4a:	00078323          	sb	zero,6(a5)
    1b4e:	0076871b          	addiw	a4,a3,7
    1b52:	0ac77463          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b56:	000783a3          	sb	zero,7(a5)
    1b5a:	0086871b          	addiw	a4,a3,8
    1b5e:	08c77e63          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b62:	00078423          	sb	zero,8(a5)
    1b66:	0096871b          	addiw	a4,a3,9
    1b6a:	08c77863          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b6e:	000784a3          	sb	zero,9(a5)
    1b72:	00a6871b          	addiw	a4,a3,10
    1b76:	08c77263          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b7a:	00078523          	sb	zero,10(a5)
    1b7e:	00b6871b          	addiw	a4,a3,11
    1b82:	06c77c63          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b86:	000785a3          	sb	zero,11(a5)
    1b8a:	00c6871b          	addiw	a4,a3,12
    1b8e:	06c77663          	bgeu	a4,a2,1bfa <strncpy+0x1ce>
    1b92:	00078623          	sb	zero,12(a5)
    1b96:	26b5                	addiw	a3,a3,13
    1b98:	06c6f163          	bgeu	a3,a2,1bfa <strncpy+0x1ce>
    1b9c:	000786a3          	sb	zero,13(a5)
    1ba0:	8082                	ret
            ;
        if (!n || !*s)
    1ba2:	c645                	beqz	a2,1c4a <strncpy+0x21e>
    1ba4:	0005c783          	lbu	a5,0(a1)
    1ba8:	ea078be3          	beqz	a5,1a5e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bac:	479d                	li	a5,7
    1bae:	02c7ff63          	bgeu	a5,a2,1bec <strncpy+0x1c0>
    1bb2:	00000897          	auipc	a7,0x0
    1bb6:	3be8b883          	ld	a7,958(a7) # 1f70 <__clone+0xae>
    1bba:	00000817          	auipc	a6,0x0
    1bbe:	3be83803          	ld	a6,958(a6) # 1f78 <__clone+0xb6>
    1bc2:	431d                	li	t1,7
    1bc4:	6198                	ld	a4,0(a1)
    1bc6:	011707b3          	add	a5,a4,a7
    1bca:	fff74693          	not	a3,a4
    1bce:	8ff5                	and	a5,a5,a3
    1bd0:	0107f7b3          	and	a5,a5,a6
    1bd4:	ef81                	bnez	a5,1bec <strncpy+0x1c0>
            *wd = *ws;
    1bd6:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bd8:	1661                	addi	a2,a2,-8
    1bda:	05a1                	addi	a1,a1,8
    1bdc:	0521                	addi	a0,a0,8
    1bde:	fec363e3          	bltu	t1,a2,1bc4 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1be2:	e609                	bnez	a2,1bec <strncpy+0x1c0>
    1be4:	a08d                	j	1c46 <strncpy+0x21a>
    1be6:	167d                	addi	a2,a2,-1
    1be8:	0505                	addi	a0,a0,1
    1bea:	ca01                	beqz	a2,1bfa <strncpy+0x1ce>
    1bec:	0005c783          	lbu	a5,0(a1)
    1bf0:	0585                	addi	a1,a1,1
    1bf2:	00f50023          	sb	a5,0(a0)
    1bf6:	fbe5                	bnez	a5,1be6 <strncpy+0x1ba>
        ;
tail:
    1bf8:	b59d                	j	1a5e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bfa:	8082                	ret
    1bfc:	472d                	li	a4,11
    1bfe:	bdb5                	j	1a7a <strncpy+0x4e>
    1c00:	00778713          	addi	a4,a5,7
    1c04:	45ad                	li	a1,11
    1c06:	fff60693          	addi	a3,a2,-1
    1c0a:	e6b778e3          	bgeu	a4,a1,1a7a <strncpy+0x4e>
    1c0e:	b7fd                	j	1bfc <strncpy+0x1d0>
    1c10:	40a007b3          	neg	a5,a0
    1c14:	8832                	mv	a6,a2
    1c16:	8b9d                	andi	a5,a5,7
    1c18:	4681                	li	a3,0
    1c1a:	e4060be3          	beqz	a2,1a70 <strncpy+0x44>
    1c1e:	b7cd                	j	1c00 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c20:	468d                	li	a3,3
    1c22:	bd75                	j	1ade <strncpy+0xb2>
    1c24:	872a                	mv	a4,a0
    1c26:	4681                	li	a3,0
    1c28:	bd5d                	j	1ade <strncpy+0xb2>
    1c2a:	4685                	li	a3,1
    1c2c:	bd4d                	j	1ade <strncpy+0xb2>
    1c2e:	8082                	ret
    1c30:	87aa                	mv	a5,a0
    1c32:	4681                	li	a3,0
    1c34:	b5f9                	j	1b02 <strncpy+0xd6>
    1c36:	4689                	li	a3,2
    1c38:	b55d                	j	1ade <strncpy+0xb2>
    1c3a:	4691                	li	a3,4
    1c3c:	b54d                	j	1ade <strncpy+0xb2>
    1c3e:	4695                	li	a3,5
    1c40:	bd79                	j	1ade <strncpy+0xb2>
    1c42:	4699                	li	a3,6
    1c44:	bd69                	j	1ade <strncpy+0xb2>
    1c46:	8082                	ret
    1c48:	8082                	ret
    1c4a:	8082                	ret

0000000000001c4c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c4c:	87aa                	mv	a5,a0
    1c4e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c50:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c54:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c58:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c5a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c5c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c60:	2501                	sext.w	a0,a0
    1c62:	8082                	ret

0000000000001c64 <openat>:
    register long a7 __asm__("a7") = n;
    1c64:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c68:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6c:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c70:	2501                	sext.w	a0,a0
    1c72:	8082                	ret

0000000000001c74 <close>:
    register long a7 __asm__("a7") = n;
    1c74:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c78:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c7c:	2501                	sext.w	a0,a0
    1c7e:	8082                	ret

0000000000001c80 <read>:
    register long a7 __asm__("a7") = n;
    1c80:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c84:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c88:	8082                	ret

0000000000001c8a <write>:
    register long a7 __asm__("a7") = n;
    1c8a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c8e:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c92:	8082                	ret

0000000000001c94 <getpid>:
    register long a7 __asm__("a7") = n;
    1c94:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c98:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c9c:	2501                	sext.w	a0,a0
    1c9e:	8082                	ret

0000000000001ca0 <getppid>:
    register long a7 __asm__("a7") = n;
    1ca0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ca4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ca8:	2501                	sext.w	a0,a0
    1caa:	8082                	ret

0000000000001cac <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cac:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cb0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cb4:	2501                	sext.w	a0,a0
    1cb6:	8082                	ret

0000000000001cb8 <fork>:
    register long a7 __asm__("a7") = n;
    1cb8:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cbc:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cbe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cc8:	85b2                	mv	a1,a2
    1cca:	863a                	mv	a2,a4
    if (stack)
    1ccc:	c191                	beqz	a1,1cd0 <clone+0x8>
	stack += stack_size;
    1cce:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cd0:	4781                	li	a5,0
    1cd2:	4701                	li	a4,0
    1cd4:	4681                	li	a3,0
    1cd6:	2601                	sext.w	a2,a2
    1cd8:	a2ed                	j	1ec2 <__clone>

0000000000001cda <exit>:
    register long a7 __asm__("a7") = n;
    1cda:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cde:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1ce2:	8082                	ret

0000000000001ce4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1ce4:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1ce8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cea:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <exec>:
    register long a7 __asm__("a7") = n;
    1cf2:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cf6:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cfa:	2501                	sext.w	a0,a0
    1cfc:	8082                	ret

0000000000001cfe <execve>:
    register long a7 __asm__("a7") = n;
    1cfe:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d02:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d06:	2501                	sext.w	a0,a0
    1d08:	8082                	ret

0000000000001d0a <times>:
    register long a7 __asm__("a7") = n;
    1d0a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d0e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d12:	2501                	sext.w	a0,a0
    1d14:	8082                	ret

0000000000001d16 <get_time>:

int64 get_time()
{
    1d16:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d18:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d1c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d1e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d20:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d24:	2501                	sext.w	a0,a0
    1d26:	ed09                	bnez	a0,1d40 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d28:	67a2                	ld	a5,8(sp)
    1d2a:	3e800713          	li	a4,1000
    1d2e:	00015503          	lhu	a0,0(sp)
    1d32:	02e7d7b3          	divu	a5,a5,a4
    1d36:	02e50533          	mul	a0,a0,a4
    1d3a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d3c:	0141                	addi	sp,sp,16
    1d3e:	8082                	ret
        return -1;
    1d40:	557d                	li	a0,-1
    1d42:	bfed                	j	1d3c <get_time+0x26>

0000000000001d44 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d44:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d48:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <time>:
    register long a7 __asm__("a7") = n;
    1d50:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d54:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d58:	2501                	sext.w	a0,a0
    1d5a:	8082                	ret

0000000000001d5c <sleep>:

int sleep(unsigned long long time)
{
    1d5c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d5e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d60:	850a                	mv	a0,sp
    1d62:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d64:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d68:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6a:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d6e:	e501                	bnez	a0,1d76 <sleep+0x1a>
    return 0;
    1d70:	4501                	li	a0,0
}
    1d72:	0141                	addi	sp,sp,16
    1d74:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d76:	4502                	lw	a0,0(sp)
}
    1d78:	0141                	addi	sp,sp,16
    1d7a:	8082                	ret

0000000000001d7c <set_priority>:
    register long a7 __asm__("a7") = n;
    1d7c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d80:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d84:	2501                	sext.w	a0,a0
    1d86:	8082                	ret

0000000000001d88 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d88:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d8c:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d90:	8082                	ret

0000000000001d92 <munmap>:
    register long a7 __asm__("a7") = n;
    1d92:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d96:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <wait>:

int wait(int *code)
{
    1d9e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1da0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1da4:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1da6:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1da8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1daa:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dae:	2501                	sext.w	a0,a0
    1db0:	8082                	ret

0000000000001db2 <spawn>:
    register long a7 __asm__("a7") = n;
    1db2:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1db6:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <mailread>:
    register long a7 __asm__("a7") = n;
    1dbe:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc2:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dc6:	2501                	sext.w	a0,a0
    1dc8:	8082                	ret

0000000000001dca <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dca:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dce:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dd2:	2501                	sext.w	a0,a0
    1dd4:	8082                	ret

0000000000001dd6 <fstat>:
    register long a7 __asm__("a7") = n;
    1dd6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dda:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1de2:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1de4:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1de8:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dea:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1df2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1df4:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1df8:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dfa:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dfe:	2501                	sext.w	a0,a0
    1e00:	8082                	ret

0000000000001e02 <link>:

int link(char *old_path, char *new_path)
{
    1e02:	87aa                	mv	a5,a0
    1e04:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e06:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e0a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e0e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e10:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e14:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e16:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e1a:	2501                	sext.w	a0,a0
    1e1c:	8082                	ret

0000000000001e1e <unlink>:

int unlink(char *path)
{
    1e1e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e20:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e24:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e28:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e2a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <uname>:
    register long a7 __asm__("a7") = n;
    1e32:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e36:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <brk>:
    register long a7 __asm__("a7") = n;
    1e3e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e42:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e4a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e50:	8082                	ret

0000000000001e52 <chdir>:
    register long a7 __asm__("a7") = n;
    1e52:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e56:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e5a:	2501                	sext.w	a0,a0
    1e5c:	8082                	ret

0000000000001e5e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e5e:	862e                	mv	a2,a1
    1e60:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e62:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e64:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e68:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e6c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e6e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e70:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <getdents>:
    register long a7 __asm__("a7") = n;
    1e78:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7c:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <pipe>:
    register long a7 __asm__("a7") = n;
    1e84:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e88:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e8a:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <dup>:
    register long a7 __asm__("a7") = n;
    1e92:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e94:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e98:	2501                	sext.w	a0,a0
    1e9a:	8082                	ret

0000000000001e9c <dup2>:
    register long a7 __asm__("a7") = n;
    1e9c:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e9e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea0:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ea4:	2501                	sext.w	a0,a0
    1ea6:	8082                	ret

0000000000001ea8 <mount>:
    register long a7 __asm__("a7") = n;
    1ea8:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eac:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eb0:	2501                	sext.w	a0,a0
    1eb2:	8082                	ret

0000000000001eb4 <umount>:
    register long a7 __asm__("a7") = n;
    1eb4:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eb8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eba:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ebe:	2501                	sext.w	a0,a0
    1ec0:	8082                	ret

0000000000001ec2 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ec2:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ec4:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ec6:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ec8:	8532                	mv	a0,a2
	mv a2, a4
    1eca:	863a                	mv	a2,a4
	mv a3, a5
    1ecc:	86be                	mv	a3,a5
	mv a4, a6
    1ece:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ed0:	0dc00893          	li	a7,220
	ecall
    1ed4:	00000073          	ecall

	beqz a0, 1f
    1ed8:	c111                	beqz	a0,1edc <__clone+0x1a>
	# Parent
	ret
    1eda:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1edc:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ede:	6522                	ld	a0,8(sp)
	jalr a1
    1ee0:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ee2:	05d00893          	li	a7,93
	ecall
    1ee6:	00000073          	ecall
