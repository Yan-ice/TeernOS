
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/chdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0c9                	j	10c4 <__start_main>

0000000000001004 <test_chdir>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

static char buffer[30];
void test_chdir(void){
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	efa50513          	addi	a0,a0,-262 # 1f00 <__clone+0x28>
void test_chdir(void){
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	2ea000ef          	jal	ra,12fc <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fc250513          	addi	a0,a0,-62 # 1fd8 <__func__.1167>
    101e:	2de000ef          	jal	ra,12fc <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ef650513          	addi	a0,a0,-266 # 1f18 <__clone+0x40>
    102a:	2d2000ef          	jal	ra,12fc <puts>
    mkdir("test_chdir", 0666);
    102e:	1b600593          	li	a1,438
    1032:	00001517          	auipc	a0,0x1
    1036:	ef650513          	addi	a0,a0,-266 # 1f28 <__clone+0x50>
    103a:	63b000ef          	jal	ra,1e74 <mkdir>
    int ret = chdir("test_chdir");
    103e:	00001517          	auipc	a0,0x1
    1042:	eea50513          	addi	a0,a0,-278 # 1f28 <__clone+0x50>
    1046:	623000ef          	jal	ra,1e68 <chdir>
    104a:	842a                	mv	s0,a0
    printf("chdir ret: %d\n", ret);
    104c:	85aa                	mv	a1,a0
    104e:	00001517          	auipc	a0,0x1
    1052:	eea50513          	addi	a0,a0,-278 # 1f38 <__clone+0x60>
    1056:	2c8000ef          	jal	ra,131e <printf>
    assert(ret == 0);
    105a:	e431                	bnez	s0,10a6 <test_chdir+0xa2>
    getcwd(buffer, 30);
    105c:	45f9                	li	a1,30
    105e:	00001517          	auipc	a0,0x1
    1062:	f5a50513          	addi	a0,a0,-166 # 1fb8 <buffer>
    1066:	5fb000ef          	jal	ra,1e60 <getcwd>
    printf("  current working dir : %s\n", buffer);
    106a:	00001597          	auipc	a1,0x1
    106e:	f4e58593          	addi	a1,a1,-178 # 1fb8 <buffer>
    1072:	00001517          	auipc	a0,0x1
    1076:	ef650513          	addi	a0,a0,-266 # 1f68 <__clone+0x90>
    107a:	2a4000ef          	jal	ra,131e <printf>
    TEST_END(__func__);
    107e:	00001517          	auipc	a0,0x1
    1082:	f0a50513          	addi	a0,a0,-246 # 1f88 <__clone+0xb0>
    1086:	276000ef          	jal	ra,12fc <puts>
    108a:	00001517          	auipc	a0,0x1
    108e:	f4e50513          	addi	a0,a0,-178 # 1fd8 <__func__.1167>
    1092:	26a000ef          	jal	ra,12fc <puts>
}
    1096:	6402                	ld	s0,0(sp)
    1098:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    109a:	00001517          	auipc	a0,0x1
    109e:	e7e50513          	addi	a0,a0,-386 # 1f18 <__clone+0x40>
}
    10a2:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10a4:	aca1                	j	12fc <puts>
    assert(ret == 0);
    10a6:	00001517          	auipc	a0,0x1
    10aa:	ea250513          	addi	a0,a0,-350 # 1f48 <__clone+0x70>
    10ae:	530000ef          	jal	ra,15de <panic>
    10b2:	b76d                	j	105c <test_chdir+0x58>

00000000000010b4 <main>:

int main(void){
    10b4:	1141                	addi	sp,sp,-16
    10b6:	e406                	sd	ra,8(sp)
    test_chdir();
    10b8:	f4dff0ef          	jal	ra,1004 <test_chdir>
    return 0;
}
    10bc:	60a2                	ld	ra,8(sp)
    10be:	4501                	li	a0,0
    10c0:	0141                	addi	sp,sp,16
    10c2:	8082                	ret

00000000000010c4 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10c4:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10c6:	4108                	lw	a0,0(a0)
{
    10c8:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10ca:	05a1                	addi	a1,a1,8
{
    10cc:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ce:	fe7ff0ef          	jal	ra,10b4 <main>
    10d2:	41f000ef          	jal	ra,1cf0 <exit>
	return 0;
}
    10d6:	60a2                	ld	ra,8(sp)
    10d8:	4501                	li	a0,0
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10de:	7179                	addi	sp,sp,-48
    10e0:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10e2:	12054b63          	bltz	a0,1218 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10e6:	02b577bb          	remuw	a5,a0,a1
    10ea:	00001697          	auipc	a3,0x1
    10ee:	efe68693          	addi	a3,a3,-258 # 1fe8 <digits>
    buf[16] = 0;
    10f2:	00010c23          	sb	zero,24(sp)
    i = 15;
    10f6:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10fa:	1782                	slli	a5,a5,0x20
    10fc:	9381                	srli	a5,a5,0x20
    10fe:	97b6                	add	a5,a5,a3
    1100:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1104:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1108:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    110c:	16b56263          	bltu	a0,a1,1270 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    1110:	02e8763b          	remuw	a2,a6,a4
    1114:	1602                	slli	a2,a2,0x20
    1116:	9201                	srli	a2,a2,0x20
    1118:	9636                	add	a2,a2,a3
    111a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    111e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1122:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1126:	12e86963          	bltu	a6,a4,1258 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    112a:	02e5f63b          	remuw	a2,a1,a4
    112e:	1602                	slli	a2,a2,0x20
    1130:	9201                	srli	a2,a2,0x20
    1132:	9636                	add	a2,a2,a3
    1134:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1138:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    113c:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1140:	10e5ef63          	bltu	a1,a4,125e <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    1144:	02e8763b          	remuw	a2,a6,a4
    1148:	1602                	slli	a2,a2,0x20
    114a:	9201                	srli	a2,a2,0x20
    114c:	9636                	add	a2,a2,a3
    114e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1152:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1156:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    115a:	10e86563          	bltu	a6,a4,1264 <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    115e:	02e5f63b          	remuw	a2,a1,a4
    1162:	1602                	slli	a2,a2,0x20
    1164:	9201                	srli	a2,a2,0x20
    1166:	9636                	add	a2,a2,a3
    1168:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    116c:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1170:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    1174:	0ee5eb63          	bltu	a1,a4,126a <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1178:	02e8763b          	remuw	a2,a6,a4
    117c:	1602                	slli	a2,a2,0x20
    117e:	9201                	srli	a2,a2,0x20
    1180:	9636                	add	a2,a2,a3
    1182:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1186:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    118a:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    118e:	0ce86263          	bltu	a6,a4,1252 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1192:	02e5f63b          	remuw	a2,a1,a4
    1196:	1602                	slli	a2,a2,0x20
    1198:	9201                	srli	a2,a2,0x20
    119a:	9636                	add	a2,a2,a3
    119c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a0:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11a4:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11a8:	0ce5e663          	bltu	a1,a4,1274 <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11ac:	02e8763b          	remuw	a2,a6,a4
    11b0:	1602                	slli	a2,a2,0x20
    11b2:	9201                	srli	a2,a2,0x20
    11b4:	9636                	add	a2,a2,a3
    11b6:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11ba:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11be:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11c2:	0ae86c63          	bltu	a6,a4,127a <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11c6:	02e5f63b          	remuw	a2,a1,a4
    11ca:	1602                	slli	a2,a2,0x20
    11cc:	9201                	srli	a2,a2,0x20
    11ce:	9636                	add	a2,a2,a3
    11d0:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11d4:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11d8:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11dc:	0ae5e263          	bltu	a1,a4,1280 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11e0:	1782                	slli	a5,a5,0x20
    11e2:	9381                	srli	a5,a5,0x20
    11e4:	97b6                	add	a5,a5,a3
    11e6:	0007c703          	lbu	a4,0(a5)
    11ea:	4599                	li	a1,6
    11ec:	4795                	li	a5,5
    11ee:	00e10723          	sb	a4,14(sp)

    if (sign)
    11f2:	00055963          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11f6:	1018                	addi	a4,sp,32
    11f8:	973e                	add	a4,a4,a5
    11fa:	02d00693          	li	a3,45
    11fe:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    1202:	85be                	mv	a1,a5
    write(f, s, l);
    1204:	003c                	addi	a5,sp,8
    1206:	4641                	li	a2,16
    1208:	9e0d                	subw	a2,a2,a1
    120a:	4505                	li	a0,1
    120c:	95be                	add	a1,a1,a5
    120e:	293000ef          	jal	ra,1ca0 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1212:	70a2                	ld	ra,40(sp)
    1214:	6145                	addi	sp,sp,48
    1216:	8082                	ret
        x = -xx;
    1218:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    121c:	02b677bb          	remuw	a5,a2,a1
    1220:	00001697          	auipc	a3,0x1
    1224:	dc868693          	addi	a3,a3,-568 # 1fe8 <digits>
    buf[16] = 0;
    1228:	00010c23          	sb	zero,24(sp)
    i = 15;
    122c:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1230:	1782                	slli	a5,a5,0x20
    1232:	9381                	srli	a5,a5,0x20
    1234:	97b6                	add	a5,a5,a3
    1236:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    123a:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    123e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1242:	ecb677e3          	bgeu	a2,a1,1110 <printint.constprop.0+0x32>
        buf[i--] = '-';
    1246:	02d00793          	li	a5,45
    124a:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    124e:	45b9                	li	a1,14
    1250:	bf55                	j	1204 <printint.constprop.0+0x126>
    1252:	47a5                	li	a5,9
    1254:	45a9                	li	a1,10
    1256:	bf71                	j	11f2 <printint.constprop.0+0x114>
    1258:	47b5                	li	a5,13
    125a:	45b9                	li	a1,14
    125c:	bf59                	j	11f2 <printint.constprop.0+0x114>
    125e:	47b1                	li	a5,12
    1260:	45b5                	li	a1,13
    1262:	bf41                	j	11f2 <printint.constprop.0+0x114>
    1264:	47ad                	li	a5,11
    1266:	45b1                	li	a1,12
    1268:	b769                	j	11f2 <printint.constprop.0+0x114>
    126a:	47a9                	li	a5,10
    126c:	45ad                	li	a1,11
    126e:	b751                	j	11f2 <printint.constprop.0+0x114>
    i = 15;
    1270:	45bd                	li	a1,15
    1272:	bf49                	j	1204 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1274:	47a1                	li	a5,8
    1276:	45a5                	li	a1,9
    1278:	bfad                	j	11f2 <printint.constprop.0+0x114>
    127a:	479d                	li	a5,7
    127c:	45a1                	li	a1,8
    127e:	bf95                	j	11f2 <printint.constprop.0+0x114>
    1280:	4799                	li	a5,6
    1282:	459d                	li	a1,7
    1284:	b7bd                	j	11f2 <printint.constprop.0+0x114>

0000000000001286 <getchar>:
{
    1286:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1288:	00f10593          	addi	a1,sp,15
    128c:	4605                	li	a2,1
    128e:	4501                	li	a0,0
{
    1290:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1292:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1296:	201000ef          	jal	ra,1c96 <read>
}
    129a:	60e2                	ld	ra,24(sp)
    129c:	00f14503          	lbu	a0,15(sp)
    12a0:	6105                	addi	sp,sp,32
    12a2:	8082                	ret

00000000000012a4 <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12a4:	00001797          	auipc	a5,0x1
    12a8:	d5c78793          	addi	a5,a5,-676 # 2000 <digits+0x18>
    12ac:	04000893          	li	a7,64
    12b0:	4505                	li	a0,1
    12b2:	85be                	mv	a1,a5
    12b4:	4611                	li	a2,4
    12b6:	00000073          	ecall
}
    12ba:	4501                	li	a0,0
    12bc:	8082                	ret

00000000000012be <putchar>:
{
    12be:	1101                	addi	sp,sp,-32
    12c0:	ec06                	sd	ra,24(sp)
    12c2:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12c4:	3e700893          	li	a7,999
    12c8:	4505                	li	a0,1
    12ca:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12ce:	00001717          	auipc	a4,0x1
    12d2:	d3270713          	addi	a4,a4,-718 # 2000 <digits+0x18>
    12d6:	04000893          	li	a7,64
    12da:	4505                	li	a0,1
    12dc:	85ba                	mv	a1,a4
    12de:	4611                	li	a2,4
    12e0:	00000073          	ecall
    return write(stdout, &byte, 1);
    12e4:	4605                	li	a2,1
    12e6:	00f10593          	addi	a1,sp,15
    12ea:	4505                	li	a0,1
    char byte = c;
    12ec:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12f0:	1b1000ef          	jal	ra,1ca0 <write>
}
    12f4:	60e2                	ld	ra,24(sp)
    12f6:	2501                	sext.w	a0,a0
    12f8:	6105                	addi	sp,sp,32
    12fa:	8082                	ret

00000000000012fc <puts>:
{
    12fc:	1141                	addi	sp,sp,-16
    12fe:	e406                	sd	ra,8(sp)
    1300:	e022                	sd	s0,0(sp)
    1302:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1304:	5b8000ef          	jal	ra,18bc <strlen>
    1308:	862a                	mv	a2,a0
    130a:	85a2                	mv	a1,s0
    130c:	4505                	li	a0,1
    130e:	193000ef          	jal	ra,1ca0 <write>
}
    1312:	60a2                	ld	ra,8(sp)
    1314:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1316:	957d                	srai	a0,a0,0x3f
    return r;
    1318:	2501                	sext.w	a0,a0
}
    131a:	0141                	addi	sp,sp,16
    131c:	8082                	ret

000000000000131e <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    131e:	7171                	addi	sp,sp,-176
    1320:	e0d2                	sd	s4,64(sp)
    1322:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    1324:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1326:	18bc                	addi	a5,sp,120
{
    1328:	e8ca                	sd	s2,80(sp)
    132a:	e4ce                	sd	s3,72(sp)
    132c:	fc56                	sd	s5,56(sp)
    132e:	f85a                	sd	s6,48(sp)
    1330:	f486                	sd	ra,104(sp)
    1332:	f0a2                	sd	s0,96(sp)
    1334:	eca6                	sd	s1,88(sp)
    1336:	fcae                	sd	a1,120(sp)
    1338:	e132                	sd	a2,128(sp)
    133a:	e536                	sd	a3,136(sp)
    133c:	e93a                	sd	a4,144(sp)
    133e:	f142                	sd	a6,160(sp)
    1340:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1342:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1344:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1348:	00001b17          	auipc	s6,0x1
    134c:	c50b0b13          	addi	s6,s6,-944 # 1f98 <__clone+0xc0>
	::"r"((unsigned long long)ac)
    1350:	00001a97          	auipc	s5,0x1
    1354:	cb0a8a93          	addi	s5,s5,-848 # 2000 <digits+0x18>
    buf[i++] = '0';
    1358:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    135c:	00001997          	auipc	s3,0x1
    1360:	c8c98993          	addi	s3,s3,-884 # 1fe8 <digits>
        if (!*s)
    1364:	00054783          	lbu	a5,0(a0)
    1368:	16078c63          	beqz	a5,14e0 <printf+0x1c2>
    136c:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    136e:	19278363          	beq	a5,s2,14f4 <printf+0x1d6>
    1372:	00164783          	lbu	a5,1(a2)
    1376:	0605                	addi	a2,a2,1
    1378:	fbfd                	bnez	a5,136e <printf+0x50>
    137a:	84b2                	mv	s1,a2
        l = z - a;
    137c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1380:	85aa                	mv	a1,a0
    1382:	8622                	mv	a2,s0
    1384:	4505                	li	a0,1
    1386:	11b000ef          	jal	ra,1ca0 <write>
        if (l)
    138a:	18041e63          	bnez	s0,1526 <printf+0x208>
        if (s[1] == 0)
    138e:	0014c783          	lbu	a5,1(s1)
    1392:	14078763          	beqz	a5,14e0 <printf+0x1c2>
        switch (s[1])
    1396:	07300713          	li	a4,115
    139a:	1ce78063          	beq	a5,a4,155a <printf+0x23c>
    139e:	18f76663          	bltu	a4,a5,152a <printf+0x20c>
    13a2:	06400713          	li	a4,100
    13a6:	1ae78063          	beq	a5,a4,1546 <printf+0x228>
    13aa:	07000713          	li	a4,112
    13ae:	1ce79963          	bne	a5,a4,1580 <printf+0x262>
            printptr(va_arg(ap, uint64));
    13b2:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13b4:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13b8:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13ba:	631c                	ld	a5,0(a4)
    13bc:	0721                	addi	a4,a4,8
    13be:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13c0:	00479293          	slli	t0,a5,0x4
    13c4:	00879f93          	slli	t6,a5,0x8
    13c8:	00c79f13          	slli	t5,a5,0xc
    13cc:	01079e93          	slli	t4,a5,0x10
    13d0:	01479e13          	slli	t3,a5,0x14
    13d4:	01879313          	slli	t1,a5,0x18
    13d8:	01c79893          	slli	a7,a5,0x1c
    13dc:	02479813          	slli	a6,a5,0x24
    13e0:	02879513          	slli	a0,a5,0x28
    13e4:	02c79593          	slli	a1,a5,0x2c
    13e8:	03079693          	slli	a3,a5,0x30
    13ec:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f0:	03c7d413          	srli	s0,a5,0x3c
    13f4:	01c7d39b          	srliw	t2,a5,0x1c
    13f8:	03c2d293          	srli	t0,t0,0x3c
    13fc:	03cfdf93          	srli	t6,t6,0x3c
    1400:	03cf5f13          	srli	t5,t5,0x3c
    1404:	03cede93          	srli	t4,t4,0x3c
    1408:	03ce5e13          	srli	t3,t3,0x3c
    140c:	03c35313          	srli	t1,t1,0x3c
    1410:	03c8d893          	srli	a7,a7,0x3c
    1414:	03c85813          	srli	a6,a6,0x3c
    1418:	9171                	srli	a0,a0,0x3c
    141a:	91f1                	srli	a1,a1,0x3c
    141c:	92f1                	srli	a3,a3,0x3c
    141e:	9371                	srli	a4,a4,0x3c
    1420:	96ce                	add	a3,a3,s3
    1422:	974e                	add	a4,a4,s3
    1424:	944e                	add	s0,s0,s3
    1426:	92ce                	add	t0,t0,s3
    1428:	9fce                	add	t6,t6,s3
    142a:	9f4e                	add	t5,t5,s3
    142c:	9ece                	add	t4,t4,s3
    142e:	9e4e                	add	t3,t3,s3
    1430:	934e                	add	t1,t1,s3
    1432:	98ce                	add	a7,a7,s3
    1434:	93ce                	add	t2,t2,s3
    1436:	984e                	add	a6,a6,s3
    1438:	954e                	add	a0,a0,s3
    143a:	95ce                	add	a1,a1,s3
    143c:	0006c083          	lbu	ra,0(a3)
    1440:	0002c283          	lbu	t0,0(t0)
    1444:	00074683          	lbu	a3,0(a4)
    1448:	000fcf83          	lbu	t6,0(t6)
    144c:	000f4f03          	lbu	t5,0(t5)
    1450:	000ece83          	lbu	t4,0(t4)
    1454:	000e4e03          	lbu	t3,0(t3)
    1458:	00034303          	lbu	t1,0(t1)
    145c:	0008c883          	lbu	a7,0(a7)
    1460:	0003c383          	lbu	t2,0(t2)
    1464:	00084803          	lbu	a6,0(a6)
    1468:	00054503          	lbu	a0,0(a0)
    146c:	0005c583          	lbu	a1,0(a1)
    1470:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1474:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1478:	9371                	srli	a4,a4,0x3c
    147a:	8bbd                	andi	a5,a5,15
    147c:	974e                	add	a4,a4,s3
    147e:	97ce                	add	a5,a5,s3
    1480:	005105a3          	sb	t0,11(sp)
    1484:	01f10623          	sb	t6,12(sp)
    1488:	01e106a3          	sb	t5,13(sp)
    148c:	01d10723          	sb	t4,14(sp)
    1490:	01c107a3          	sb	t3,15(sp)
    1494:	00610823          	sb	t1,16(sp)
    1498:	011108a3          	sb	a7,17(sp)
    149c:	00710923          	sb	t2,18(sp)
    14a0:	010109a3          	sb	a6,19(sp)
    14a4:	00a10a23          	sb	a0,20(sp)
    14a8:	00b10aa3          	sb	a1,21(sp)
    14ac:	00110b23          	sb	ra,22(sp)
    14b0:	00d10ba3          	sb	a3,23(sp)
    14b4:	00810523          	sb	s0,10(sp)
    14b8:	00074703          	lbu	a4,0(a4)
    14bc:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14c0:	002c                	addi	a1,sp,8
    14c2:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14c4:	00e10c23          	sb	a4,24(sp)
    14c8:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14cc:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14d0:	7d0000ef          	jal	ra,1ca0 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14d4:	00248513          	addi	a0,s1,2
        if (!*s)
    14d8:	00054783          	lbu	a5,0(a0)
    14dc:	e80798e3          	bnez	a5,136c <printf+0x4e>
    }
    va_end(ap);
}
    14e0:	70a6                	ld	ra,104(sp)
    14e2:	7406                	ld	s0,96(sp)
    14e4:	64e6                	ld	s1,88(sp)
    14e6:	6946                	ld	s2,80(sp)
    14e8:	69a6                	ld	s3,72(sp)
    14ea:	6a06                	ld	s4,64(sp)
    14ec:	7ae2                	ld	s5,56(sp)
    14ee:	7b42                	ld	s6,48(sp)
    14f0:	614d                	addi	sp,sp,176
    14f2:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14f4:	00064783          	lbu	a5,0(a2)
    14f8:	84b2                	mv	s1,a2
    14fa:	01278963          	beq	a5,s2,150c <printf+0x1ee>
    14fe:	bdbd                	j	137c <printf+0x5e>
    1500:	0024c783          	lbu	a5,2(s1)
    1504:	0605                	addi	a2,a2,1
    1506:	0489                	addi	s1,s1,2
    1508:	e7279ae3          	bne	a5,s2,137c <printf+0x5e>
    150c:	0014c783          	lbu	a5,1(s1)
    1510:	ff2788e3          	beq	a5,s2,1500 <printf+0x1e2>
        l = z - a;
    1514:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1518:	85aa                	mv	a1,a0
    151a:	8622                	mv	a2,s0
    151c:	4505                	li	a0,1
    151e:	782000ef          	jal	ra,1ca0 <write>
        if (l)
    1522:	e60406e3          	beqz	s0,138e <printf+0x70>
    1526:	8526                	mv	a0,s1
    1528:	bd35                	j	1364 <printf+0x46>
        switch (s[1])
    152a:	07800713          	li	a4,120
    152e:	04e79963          	bne	a5,a4,1580 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1532:	6782                	ld	a5,0(sp)
    1534:	45c1                	li	a1,16
    1536:	4388                	lw	a0,0(a5)
    1538:	07a1                	addi	a5,a5,8
    153a:	e03e                	sd	a5,0(sp)
    153c:	ba3ff0ef          	jal	ra,10de <printint.constprop.0>
        s += 2;
    1540:	00248513          	addi	a0,s1,2
    1544:	bf51                	j	14d8 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1546:	6782                	ld	a5,0(sp)
    1548:	45a9                	li	a1,10
    154a:	4388                	lw	a0,0(a5)
    154c:	07a1                	addi	a5,a5,8
    154e:	e03e                	sd	a5,0(sp)
    1550:	b8fff0ef          	jal	ra,10de <printint.constprop.0>
        s += 2;
    1554:	00248513          	addi	a0,s1,2
    1558:	b741                	j	14d8 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    155a:	6782                	ld	a5,0(sp)
    155c:	6380                	ld	s0,0(a5)
    155e:	07a1                	addi	a5,a5,8
    1560:	e03e                	sd	a5,0(sp)
    1562:	cc25                	beqz	s0,15da <printf+0x2bc>
            l = strnlen(a, 200);
    1564:	0c800593          	li	a1,200
    1568:	8522                	mv	a0,s0
    156a:	43e000ef          	jal	ra,19a8 <strnlen>
    write(f, s, l);
    156e:	0005061b          	sext.w	a2,a0
    1572:	85a2                	mv	a1,s0
    1574:	4505                	li	a0,1
    1576:	72a000ef          	jal	ra,1ca0 <write>
        s += 2;
    157a:	00248513          	addi	a0,s1,2
    157e:	bfa9                	j	14d8 <printf+0x1ba>
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
    char byte = c;
    1598:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    159c:	4605                	li	a2,1
    159e:	002c                	addi	a1,sp,8
    15a0:	4505                	li	a0,1
    char byte = c;
    15a2:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15a6:	6fa000ef          	jal	ra,1ca0 <write>
            putchar(s[1]);
    15aa:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15ae:	3e700893          	li	a7,999
    15b2:	4505                	li	a0,1
    15b4:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15b8:	04000893          	li	a7,64
    15bc:	4505                	li	a0,1
    15be:	85d6                	mv	a1,s5
    15c0:	4611                	li	a2,4
    15c2:	00000073          	ecall
    return write(stdout, &byte, 1);
    15c6:	4605                	li	a2,1
    15c8:	002c                	addi	a1,sp,8
    15ca:	4505                	li	a0,1
    char byte = c;
    15cc:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15d0:	6d0000ef          	jal	ra,1ca0 <write>
        s += 2;
    15d4:	00248513          	addi	a0,s1,2
    15d8:	b701                	j	14d8 <printf+0x1ba>
                a = "(null)";
    15da:	845a                	mv	s0,s6
    15dc:	b761                	j	1564 <printf+0x246>

00000000000015de <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15de:	1141                	addi	sp,sp,-16
    15e0:	e406                	sd	ra,8(sp)
    puts(m);
    15e2:	d1bff0ef          	jal	ra,12fc <puts>
    exit(-100);
}
    15e6:	60a2                	ld	ra,8(sp)
    exit(-100);
    15e8:	f9c00513          	li	a0,-100
}
    15ec:	0141                	addi	sp,sp,16
    exit(-100);
    15ee:	a709                	j	1cf0 <exit>

00000000000015f0 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f0:	02000793          	li	a5,32
    15f4:	00f50663          	beq	a0,a5,1600 <isspace+0x10>
    15f8:	355d                	addiw	a0,a0,-9
    15fa:	00553513          	sltiu	a0,a0,5
    15fe:	8082                	ret
    1600:	4505                	li	a0,1
}
    1602:	8082                	ret

0000000000001604 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1604:	fd05051b          	addiw	a0,a0,-48
}
    1608:	00a53513          	sltiu	a0,a0,10
    160c:	8082                	ret

000000000000160e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    160e:	02000613          	li	a2,32
    1612:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1614:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1618:	ff77069b          	addiw	a3,a4,-9
    161c:	04c70d63          	beq	a4,a2,1676 <atoi+0x68>
    1620:	0007079b          	sext.w	a5,a4
    1624:	04d5f963          	bgeu	a1,a3,1676 <atoi+0x68>
        s++;
    switch (*s)
    1628:	02b00693          	li	a3,43
    162c:	04d70a63          	beq	a4,a3,1680 <atoi+0x72>
    1630:	02d00693          	li	a3,45
    1634:	06d70463          	beq	a4,a3,169c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1638:	fd07859b          	addiw	a1,a5,-48
    163c:	4625                	li	a2,9
    163e:	873e                	mv	a4,a5
    1640:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1642:	4e01                	li	t3,0
    while (isdigit(*s))
    1644:	04b66a63          	bltu	a2,a1,1698 <atoi+0x8a>
    int n = 0, neg = 0;
    1648:	4501                	li	a0,0
    while (isdigit(*s))
    164a:	4825                	li	a6,9
    164c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1650:	0025179b          	slliw	a5,a0,0x2
    1654:	9d3d                	addw	a0,a0,a5
    1656:	fd07031b          	addiw	t1,a4,-48
    165a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    165e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1662:	0685                	addi	a3,a3,1
    1664:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1668:	0006071b          	sext.w	a4,a2
    166c:	feb870e3          	bgeu	a6,a1,164c <atoi+0x3e>
    return neg ? n : -n;
    1670:	000e0563          	beqz	t3,167a <atoi+0x6c>
}
    1674:	8082                	ret
        s++;
    1676:	0505                	addi	a0,a0,1
    1678:	bf71                	j	1614 <atoi+0x6>
    167a:	4113053b          	subw	a0,t1,a7
    167e:	8082                	ret
    while (isdigit(*s))
    1680:	00154783          	lbu	a5,1(a0)
    1684:	4625                	li	a2,9
        s++;
    1686:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    168a:	fd07859b          	addiw	a1,a5,-48
    168e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1692:	4e01                	li	t3,0
    while (isdigit(*s))
    1694:	fab67ae3          	bgeu	a2,a1,1648 <atoi+0x3a>
    1698:	4501                	li	a0,0
}
    169a:	8082                	ret
    while (isdigit(*s))
    169c:	00154783          	lbu	a5,1(a0)
    16a0:	4625                	li	a2,9
        s++;
    16a2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16a6:	fd07859b          	addiw	a1,a5,-48
    16aa:	0007871b          	sext.w	a4,a5
    16ae:	feb665e3          	bltu	a2,a1,1698 <atoi+0x8a>
        neg = 1;
    16b2:	4e05                	li	t3,1
    16b4:	bf51                	j	1648 <atoi+0x3a>

00000000000016b6 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16b6:	16060d63          	beqz	a2,1830 <memset+0x17a>
    16ba:	40a007b3          	neg	a5,a0
    16be:	8b9d                	andi	a5,a5,7
    16c0:	00778713          	addi	a4,a5,7
    16c4:	482d                	li	a6,11
    16c6:	0ff5f593          	zext.b	a1,a1
    16ca:	fff60693          	addi	a3,a2,-1
    16ce:	17076263          	bltu	a4,a6,1832 <memset+0x17c>
    16d2:	16e6ea63          	bltu	a3,a4,1846 <memset+0x190>
    16d6:	16078563          	beqz	a5,1840 <memset+0x18a>
    16da:	00b50023          	sb	a1,0(a0)
    16de:	4705                	li	a4,1
    16e0:	00150e93          	addi	t4,a0,1
    16e4:	14e78c63          	beq	a5,a4,183c <memset+0x186>
    16e8:	00b500a3          	sb	a1,1(a0)
    16ec:	4709                	li	a4,2
    16ee:	00250e93          	addi	t4,a0,2
    16f2:	14e78d63          	beq	a5,a4,184c <memset+0x196>
    16f6:	00b50123          	sb	a1,2(a0)
    16fa:	470d                	li	a4,3
    16fc:	00350e93          	addi	t4,a0,3
    1700:	12e78b63          	beq	a5,a4,1836 <memset+0x180>
    1704:	00b501a3          	sb	a1,3(a0)
    1708:	4711                	li	a4,4
    170a:	00450e93          	addi	t4,a0,4
    170e:	14e78163          	beq	a5,a4,1850 <memset+0x19a>
    1712:	00b50223          	sb	a1,4(a0)
    1716:	4715                	li	a4,5
    1718:	00550e93          	addi	t4,a0,5
    171c:	12e78c63          	beq	a5,a4,1854 <memset+0x19e>
    1720:	00b502a3          	sb	a1,5(a0)
    1724:	471d                	li	a4,7
    1726:	00650e93          	addi	t4,a0,6
    172a:	12e79763          	bne	a5,a4,1858 <memset+0x1a2>
    172e:	00750e93          	addi	t4,a0,7
    1732:	00b50323          	sb	a1,6(a0)
    1736:	4f1d                	li	t5,7
    1738:	00859713          	slli	a4,a1,0x8
    173c:	8f4d                	or	a4,a4,a1
    173e:	01059e13          	slli	t3,a1,0x10
    1742:	01c76e33          	or	t3,a4,t3
    1746:	01859313          	slli	t1,a1,0x18
    174a:	006e6333          	or	t1,t3,t1
    174e:	02059893          	slli	a7,a1,0x20
    1752:	011368b3          	or	a7,t1,a7
    1756:	02859813          	slli	a6,a1,0x28
    175a:	40f60333          	sub	t1,a2,a5
    175e:	0108e833          	or	a6,a7,a6
    1762:	03059693          	slli	a3,a1,0x30
    1766:	00d866b3          	or	a3,a6,a3
    176a:	03859713          	slli	a4,a1,0x38
    176e:	97aa                	add	a5,a5,a0
    1770:	ff837813          	andi	a6,t1,-8
    1774:	8f55                	or	a4,a4,a3
    1776:	00f806b3          	add	a3,a6,a5
    177a:	e398                	sd	a4,0(a5)
    177c:	07a1                	addi	a5,a5,8
    177e:	fed79ee3          	bne	a5,a3,177a <memset+0xc4>
    1782:	ff837693          	andi	a3,t1,-8
    1786:	00de87b3          	add	a5,t4,a3
    178a:	01e6873b          	addw	a4,a3,t5
    178e:	0ad30663          	beq	t1,a3,183a <memset+0x184>
    1792:	00b78023          	sb	a1,0(a5)
    1796:	0017069b          	addiw	a3,a4,1
    179a:	08c6fb63          	bgeu	a3,a2,1830 <memset+0x17a>
    179e:	00b780a3          	sb	a1,1(a5)
    17a2:	0027069b          	addiw	a3,a4,2
    17a6:	08c6f563          	bgeu	a3,a2,1830 <memset+0x17a>
    17aa:	00b78123          	sb	a1,2(a5)
    17ae:	0037069b          	addiw	a3,a4,3
    17b2:	06c6ff63          	bgeu	a3,a2,1830 <memset+0x17a>
    17b6:	00b781a3          	sb	a1,3(a5)
    17ba:	0047069b          	addiw	a3,a4,4
    17be:	06c6f963          	bgeu	a3,a2,1830 <memset+0x17a>
    17c2:	00b78223          	sb	a1,4(a5)
    17c6:	0057069b          	addiw	a3,a4,5
    17ca:	06c6f363          	bgeu	a3,a2,1830 <memset+0x17a>
    17ce:	00b782a3          	sb	a1,5(a5)
    17d2:	0067069b          	addiw	a3,a4,6
    17d6:	04c6fd63          	bgeu	a3,a2,1830 <memset+0x17a>
    17da:	00b78323          	sb	a1,6(a5)
    17de:	0077069b          	addiw	a3,a4,7
    17e2:	04c6f763          	bgeu	a3,a2,1830 <memset+0x17a>
    17e6:	00b783a3          	sb	a1,7(a5)
    17ea:	0087069b          	addiw	a3,a4,8
    17ee:	04c6f163          	bgeu	a3,a2,1830 <memset+0x17a>
    17f2:	00b78423          	sb	a1,8(a5)
    17f6:	0097069b          	addiw	a3,a4,9
    17fa:	02c6fb63          	bgeu	a3,a2,1830 <memset+0x17a>
    17fe:	00b784a3          	sb	a1,9(a5)
    1802:	00a7069b          	addiw	a3,a4,10
    1806:	02c6f563          	bgeu	a3,a2,1830 <memset+0x17a>
    180a:	00b78523          	sb	a1,10(a5)
    180e:	00b7069b          	addiw	a3,a4,11
    1812:	00c6ff63          	bgeu	a3,a2,1830 <memset+0x17a>
    1816:	00b785a3          	sb	a1,11(a5)
    181a:	00c7069b          	addiw	a3,a4,12
    181e:	00c6f963          	bgeu	a3,a2,1830 <memset+0x17a>
    1822:	00b78623          	sb	a1,12(a5)
    1826:	2735                	addiw	a4,a4,13
    1828:	00c77463          	bgeu	a4,a2,1830 <memset+0x17a>
    182c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1830:	8082                	ret
    1832:	472d                	li	a4,11
    1834:	bd79                	j	16d2 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1836:	4f0d                	li	t5,3
    1838:	b701                	j	1738 <memset+0x82>
    183a:	8082                	ret
    183c:	4f05                	li	t5,1
    183e:	bded                	j	1738 <memset+0x82>
    1840:	8eaa                	mv	t4,a0
    1842:	4f01                	li	t5,0
    1844:	bdd5                	j	1738 <memset+0x82>
    1846:	87aa                	mv	a5,a0
    1848:	4701                	li	a4,0
    184a:	b7a1                	j	1792 <memset+0xdc>
    184c:	4f09                	li	t5,2
    184e:	b5ed                	j	1738 <memset+0x82>
    1850:	4f11                	li	t5,4
    1852:	b5dd                	j	1738 <memset+0x82>
    1854:	4f15                	li	t5,5
    1856:	b5cd                	j	1738 <memset+0x82>
    1858:	4f19                	li	t5,6
    185a:	bdf9                	j	1738 <memset+0x82>

000000000000185c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    185c:	00054783          	lbu	a5,0(a0)
    1860:	0005c703          	lbu	a4,0(a1)
    1864:	00e79863          	bne	a5,a4,1874 <strcmp+0x18>
    1868:	0505                	addi	a0,a0,1
    186a:	0585                	addi	a1,a1,1
    186c:	fbe5                	bnez	a5,185c <strcmp>
    186e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1870:	9d19                	subw	a0,a0,a4
    1872:	8082                	ret
    1874:	0007851b          	sext.w	a0,a5
    1878:	bfe5                	j	1870 <strcmp+0x14>

000000000000187a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    187a:	ce05                	beqz	a2,18b2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    187c:	00054703          	lbu	a4,0(a0)
    1880:	0005c783          	lbu	a5,0(a1)
    1884:	cb0d                	beqz	a4,18b6 <strncmp+0x3c>
    if (!n--)
    1886:	167d                	addi	a2,a2,-1
    1888:	00c506b3          	add	a3,a0,a2
    188c:	a819                	j	18a2 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    188e:	00a68e63          	beq	a3,a0,18aa <strncmp+0x30>
    1892:	0505                	addi	a0,a0,1
    1894:	00e79b63          	bne	a5,a4,18aa <strncmp+0x30>
    1898:	00054703          	lbu	a4,0(a0)
    189c:	0005c783          	lbu	a5,0(a1)
    18a0:	cb19                	beqz	a4,18b6 <strncmp+0x3c>
    18a2:	0005c783          	lbu	a5,0(a1)
    18a6:	0585                	addi	a1,a1,1
    18a8:	f3fd                	bnez	a5,188e <strncmp+0x14>
        ;
    return *l - *r;
    18aa:	0007051b          	sext.w	a0,a4
    18ae:	9d1d                	subw	a0,a0,a5
    18b0:	8082                	ret
        return 0;
    18b2:	4501                	li	a0,0
}
    18b4:	8082                	ret
    18b6:	4501                	li	a0,0
    return *l - *r;
    18b8:	9d1d                	subw	a0,a0,a5
    18ba:	8082                	ret

00000000000018bc <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18bc:	00757793          	andi	a5,a0,7
    18c0:	cf89                	beqz	a5,18da <strlen+0x1e>
    18c2:	87aa                	mv	a5,a0
    18c4:	a029                	j	18ce <strlen+0x12>
    18c6:	0785                	addi	a5,a5,1
    18c8:	0077f713          	andi	a4,a5,7
    18cc:	cb01                	beqz	a4,18dc <strlen+0x20>
        if (!*s)
    18ce:	0007c703          	lbu	a4,0(a5)
    18d2:	fb75                	bnez	a4,18c6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18d4:	40a78533          	sub	a0,a5,a0
}
    18d8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18da:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18dc:	6394                	ld	a3,0(a5)
    18de:	00000597          	auipc	a1,0x0
    18e2:	6c25b583          	ld	a1,1730(a1) # 1fa0 <__clone+0xc8>
    18e6:	00000617          	auipc	a2,0x0
    18ea:	6c263603          	ld	a2,1730(a2) # 1fa8 <__clone+0xd0>
    18ee:	a019                	j	18f4 <strlen+0x38>
    18f0:	6794                	ld	a3,8(a5)
    18f2:	07a1                	addi	a5,a5,8
    18f4:	00b68733          	add	a4,a3,a1
    18f8:	fff6c693          	not	a3,a3
    18fc:	8f75                	and	a4,a4,a3
    18fe:	8f71                	and	a4,a4,a2
    1900:	db65                	beqz	a4,18f0 <strlen+0x34>
    for (; *s; s++)
    1902:	0007c703          	lbu	a4,0(a5)
    1906:	d779                	beqz	a4,18d4 <strlen+0x18>
    1908:	0017c703          	lbu	a4,1(a5)
    190c:	0785                	addi	a5,a5,1
    190e:	d379                	beqz	a4,18d4 <strlen+0x18>
    1910:	0017c703          	lbu	a4,1(a5)
    1914:	0785                	addi	a5,a5,1
    1916:	fb6d                	bnez	a4,1908 <strlen+0x4c>
    1918:	bf75                	j	18d4 <strlen+0x18>

000000000000191a <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    191a:	00757713          	andi	a4,a0,7
{
    191e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1920:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1924:	cb19                	beqz	a4,193a <memchr+0x20>
    1926:	ce25                	beqz	a2,199e <memchr+0x84>
    1928:	0007c703          	lbu	a4,0(a5)
    192c:	04b70e63          	beq	a4,a1,1988 <memchr+0x6e>
    1930:	0785                	addi	a5,a5,1
    1932:	0077f713          	andi	a4,a5,7
    1936:	167d                	addi	a2,a2,-1
    1938:	f77d                	bnez	a4,1926 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    193a:	4501                	li	a0,0
    if (n && *s != c)
    193c:	c235                	beqz	a2,19a0 <memchr+0x86>
    193e:	0007c703          	lbu	a4,0(a5)
    1942:	04b70363          	beq	a4,a1,1988 <memchr+0x6e>
        size_t k = ONES * c;
    1946:	00000517          	auipc	a0,0x0
    194a:	66a53503          	ld	a0,1642(a0) # 1fb0 <__clone+0xd8>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    194e:	471d                	li	a4,7
        size_t k = ONES * c;
    1950:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1954:	02c77a63          	bgeu	a4,a2,1988 <memchr+0x6e>
    1958:	00000897          	auipc	a7,0x0
    195c:	6488b883          	ld	a7,1608(a7) # 1fa0 <__clone+0xc8>
    1960:	00000817          	auipc	a6,0x0
    1964:	64883803          	ld	a6,1608(a6) # 1fa8 <__clone+0xd0>
    1968:	431d                	li	t1,7
    196a:	a029                	j	1974 <memchr+0x5a>
    196c:	1661                	addi	a2,a2,-8
    196e:	07a1                	addi	a5,a5,8
    1970:	02c37963          	bgeu	t1,a2,19a2 <memchr+0x88>
    1974:	6398                	ld	a4,0(a5)
    1976:	8f29                	xor	a4,a4,a0
    1978:	011706b3          	add	a3,a4,a7
    197c:	fff74713          	not	a4,a4
    1980:	8f75                	and	a4,a4,a3
    1982:	01077733          	and	a4,a4,a6
    1986:	d37d                	beqz	a4,196c <memchr+0x52>
    1988:	853e                	mv	a0,a5
    198a:	97b2                	add	a5,a5,a2
    198c:	a021                	j	1994 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    198e:	0505                	addi	a0,a0,1
    1990:	00f50763          	beq	a0,a5,199e <memchr+0x84>
    1994:	00054703          	lbu	a4,0(a0)
    1998:	feb71be3          	bne	a4,a1,198e <memchr+0x74>
    199c:	8082                	ret
    return n ? (void *)s : 0;
    199e:	4501                	li	a0,0
}
    19a0:	8082                	ret
    return n ? (void *)s : 0;
    19a2:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19a4:	f275                	bnez	a2,1988 <memchr+0x6e>
}
    19a6:	8082                	ret

00000000000019a8 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19a8:	1101                	addi	sp,sp,-32
    19aa:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19ac:	862e                	mv	a2,a1
{
    19ae:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19b0:	4581                	li	a1,0
{
    19b2:	e426                	sd	s1,8(sp)
    19b4:	ec06                	sd	ra,24(sp)
    19b6:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19b8:	f63ff0ef          	jal	ra,191a <memchr>
    return p ? p - s : n;
    19bc:	c519                	beqz	a0,19ca <strnlen+0x22>
}
    19be:	60e2                	ld	ra,24(sp)
    19c0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19c2:	8d05                	sub	a0,a0,s1
}
    19c4:	64a2                	ld	s1,8(sp)
    19c6:	6105                	addi	sp,sp,32
    19c8:	8082                	ret
    19ca:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19cc:	8522                	mv	a0,s0
}
    19ce:	6442                	ld	s0,16(sp)
    19d0:	64a2                	ld	s1,8(sp)
    19d2:	6105                	addi	sp,sp,32
    19d4:	8082                	ret

00000000000019d6 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19d6:	00b547b3          	xor	a5,a0,a1
    19da:	8b9d                	andi	a5,a5,7
    19dc:	eb95                	bnez	a5,1a10 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19de:	0075f793          	andi	a5,a1,7
    19e2:	e7b1                	bnez	a5,1a2e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19e4:	6198                	ld	a4,0(a1)
    19e6:	00000617          	auipc	a2,0x0
    19ea:	5ba63603          	ld	a2,1466(a2) # 1fa0 <__clone+0xc8>
    19ee:	00000817          	auipc	a6,0x0
    19f2:	5ba83803          	ld	a6,1466(a6) # 1fa8 <__clone+0xd0>
    19f6:	a029                	j	1a00 <strcpy+0x2a>
    19f8:	e118                	sd	a4,0(a0)
    19fa:	6598                	ld	a4,8(a1)
    19fc:	05a1                	addi	a1,a1,8
    19fe:	0521                	addi	a0,a0,8
    1a00:	00c707b3          	add	a5,a4,a2
    1a04:	fff74693          	not	a3,a4
    1a08:	8ff5                	and	a5,a5,a3
    1a0a:	0107f7b3          	and	a5,a5,a6
    1a0e:	d7ed                	beqz	a5,19f8 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a10:	0005c783          	lbu	a5,0(a1)
    1a14:	00f50023          	sb	a5,0(a0)
    1a18:	c785                	beqz	a5,1a40 <strcpy+0x6a>
    1a1a:	0015c783          	lbu	a5,1(a1)
    1a1e:	0505                	addi	a0,a0,1
    1a20:	0585                	addi	a1,a1,1
    1a22:	00f50023          	sb	a5,0(a0)
    1a26:	fbf5                	bnez	a5,1a1a <strcpy+0x44>
        ;
    return d;
}
    1a28:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a2a:	0505                	addi	a0,a0,1
    1a2c:	df45                	beqz	a4,19e4 <strcpy+0xe>
            if (!(*d = *s))
    1a2e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a32:	0585                	addi	a1,a1,1
    1a34:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a38:	00f50023          	sb	a5,0(a0)
    1a3c:	f7fd                	bnez	a5,1a2a <strcpy+0x54>
}
    1a3e:	8082                	ret
    1a40:	8082                	ret

0000000000001a42 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a42:	00b547b3          	xor	a5,a0,a1
    1a46:	8b9d                	andi	a5,a5,7
    1a48:	1a079863          	bnez	a5,1bf8 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a4c:	0075f793          	andi	a5,a1,7
    1a50:	16078463          	beqz	a5,1bb8 <strncpy+0x176>
    1a54:	ea01                	bnez	a2,1a64 <strncpy+0x22>
    1a56:	a421                	j	1c5e <strncpy+0x21c>
    1a58:	167d                	addi	a2,a2,-1
    1a5a:	0505                	addi	a0,a0,1
    1a5c:	14070e63          	beqz	a4,1bb8 <strncpy+0x176>
    1a60:	1a060863          	beqz	a2,1c10 <strncpy+0x1ce>
    1a64:	0005c783          	lbu	a5,0(a1)
    1a68:	0585                	addi	a1,a1,1
    1a6a:	0075f713          	andi	a4,a1,7
    1a6e:	00f50023          	sb	a5,0(a0)
    1a72:	f3fd                	bnez	a5,1a58 <strncpy+0x16>
    1a74:	4805                	li	a6,1
    1a76:	1a061863          	bnez	a2,1c26 <strncpy+0x1e4>
    1a7a:	40a007b3          	neg	a5,a0
    1a7e:	8b9d                	andi	a5,a5,7
    1a80:	4681                	li	a3,0
    1a82:	18061a63          	bnez	a2,1c16 <strncpy+0x1d4>
    1a86:	00778713          	addi	a4,a5,7
    1a8a:	45ad                	li	a1,11
    1a8c:	18b76363          	bltu	a4,a1,1c12 <strncpy+0x1d0>
    1a90:	1ae6eb63          	bltu	a3,a4,1c46 <strncpy+0x204>
    1a94:	1a078363          	beqz	a5,1c3a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a98:	00050023          	sb	zero,0(a0)
    1a9c:	4685                	li	a3,1
    1a9e:	00150713          	addi	a4,a0,1
    1aa2:	18d78f63          	beq	a5,a3,1c40 <strncpy+0x1fe>
    1aa6:	000500a3          	sb	zero,1(a0)
    1aaa:	4689                	li	a3,2
    1aac:	00250713          	addi	a4,a0,2
    1ab0:	18d78e63          	beq	a5,a3,1c4c <strncpy+0x20a>
    1ab4:	00050123          	sb	zero,2(a0)
    1ab8:	468d                	li	a3,3
    1aba:	00350713          	addi	a4,a0,3
    1abe:	16d78c63          	beq	a5,a3,1c36 <strncpy+0x1f4>
    1ac2:	000501a3          	sb	zero,3(a0)
    1ac6:	4691                	li	a3,4
    1ac8:	00450713          	addi	a4,a0,4
    1acc:	18d78263          	beq	a5,a3,1c50 <strncpy+0x20e>
    1ad0:	00050223          	sb	zero,4(a0)
    1ad4:	4695                	li	a3,5
    1ad6:	00550713          	addi	a4,a0,5
    1ada:	16d78d63          	beq	a5,a3,1c54 <strncpy+0x212>
    1ade:	000502a3          	sb	zero,5(a0)
    1ae2:	469d                	li	a3,7
    1ae4:	00650713          	addi	a4,a0,6
    1ae8:	16d79863          	bne	a5,a3,1c58 <strncpy+0x216>
    1aec:	00750713          	addi	a4,a0,7
    1af0:	00050323          	sb	zero,6(a0)
    1af4:	40f80833          	sub	a6,a6,a5
    1af8:	ff887593          	andi	a1,a6,-8
    1afc:	97aa                	add	a5,a5,a0
    1afe:	95be                	add	a1,a1,a5
    1b00:	0007b023          	sd	zero,0(a5)
    1b04:	07a1                	addi	a5,a5,8
    1b06:	feb79de3          	bne	a5,a1,1b00 <strncpy+0xbe>
    1b0a:	ff887593          	andi	a1,a6,-8
    1b0e:	9ead                	addw	a3,a3,a1
    1b10:	00b707b3          	add	a5,a4,a1
    1b14:	12b80863          	beq	a6,a1,1c44 <strncpy+0x202>
    1b18:	00078023          	sb	zero,0(a5)
    1b1c:	0016871b          	addiw	a4,a3,1
    1b20:	0ec77863          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b24:	000780a3          	sb	zero,1(a5)
    1b28:	0026871b          	addiw	a4,a3,2
    1b2c:	0ec77263          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b30:	00078123          	sb	zero,2(a5)
    1b34:	0036871b          	addiw	a4,a3,3
    1b38:	0cc77c63          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b3c:	000781a3          	sb	zero,3(a5)
    1b40:	0046871b          	addiw	a4,a3,4
    1b44:	0cc77663          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b48:	00078223          	sb	zero,4(a5)
    1b4c:	0056871b          	addiw	a4,a3,5
    1b50:	0cc77063          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b54:	000782a3          	sb	zero,5(a5)
    1b58:	0066871b          	addiw	a4,a3,6
    1b5c:	0ac77a63          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b60:	00078323          	sb	zero,6(a5)
    1b64:	0076871b          	addiw	a4,a3,7
    1b68:	0ac77463          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b6c:	000783a3          	sb	zero,7(a5)
    1b70:	0086871b          	addiw	a4,a3,8
    1b74:	08c77e63          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b78:	00078423          	sb	zero,8(a5)
    1b7c:	0096871b          	addiw	a4,a3,9
    1b80:	08c77863          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b84:	000784a3          	sb	zero,9(a5)
    1b88:	00a6871b          	addiw	a4,a3,10
    1b8c:	08c77263          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b90:	00078523          	sb	zero,10(a5)
    1b94:	00b6871b          	addiw	a4,a3,11
    1b98:	06c77c63          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1b9c:	000785a3          	sb	zero,11(a5)
    1ba0:	00c6871b          	addiw	a4,a3,12
    1ba4:	06c77663          	bgeu	a4,a2,1c10 <strncpy+0x1ce>
    1ba8:	00078623          	sb	zero,12(a5)
    1bac:	26b5                	addiw	a3,a3,13
    1bae:	06c6f163          	bgeu	a3,a2,1c10 <strncpy+0x1ce>
    1bb2:	000786a3          	sb	zero,13(a5)
    1bb6:	8082                	ret
            ;
        if (!n || !*s)
    1bb8:	c645                	beqz	a2,1c60 <strncpy+0x21e>
    1bba:	0005c783          	lbu	a5,0(a1)
    1bbe:	ea078be3          	beqz	a5,1a74 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc2:	479d                	li	a5,7
    1bc4:	02c7ff63          	bgeu	a5,a2,1c02 <strncpy+0x1c0>
    1bc8:	00000897          	auipc	a7,0x0
    1bcc:	3d88b883          	ld	a7,984(a7) # 1fa0 <__clone+0xc8>
    1bd0:	00000817          	auipc	a6,0x0
    1bd4:	3d883803          	ld	a6,984(a6) # 1fa8 <__clone+0xd0>
    1bd8:	431d                	li	t1,7
    1bda:	6198                	ld	a4,0(a1)
    1bdc:	011707b3          	add	a5,a4,a7
    1be0:	fff74693          	not	a3,a4
    1be4:	8ff5                	and	a5,a5,a3
    1be6:	0107f7b3          	and	a5,a5,a6
    1bea:	ef81                	bnez	a5,1c02 <strncpy+0x1c0>
            *wd = *ws;
    1bec:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bee:	1661                	addi	a2,a2,-8
    1bf0:	05a1                	addi	a1,a1,8
    1bf2:	0521                	addi	a0,a0,8
    1bf4:	fec363e3          	bltu	t1,a2,1bda <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bf8:	e609                	bnez	a2,1c02 <strncpy+0x1c0>
    1bfa:	a08d                	j	1c5c <strncpy+0x21a>
    1bfc:	167d                	addi	a2,a2,-1
    1bfe:	0505                	addi	a0,a0,1
    1c00:	ca01                	beqz	a2,1c10 <strncpy+0x1ce>
    1c02:	0005c783          	lbu	a5,0(a1)
    1c06:	0585                	addi	a1,a1,1
    1c08:	00f50023          	sb	a5,0(a0)
    1c0c:	fbe5                	bnez	a5,1bfc <strncpy+0x1ba>
        ;
tail:
    1c0e:	b59d                	j	1a74 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c10:	8082                	ret
    1c12:	472d                	li	a4,11
    1c14:	bdb5                	j	1a90 <strncpy+0x4e>
    1c16:	00778713          	addi	a4,a5,7
    1c1a:	45ad                	li	a1,11
    1c1c:	fff60693          	addi	a3,a2,-1
    1c20:	e6b778e3          	bgeu	a4,a1,1a90 <strncpy+0x4e>
    1c24:	b7fd                	j	1c12 <strncpy+0x1d0>
    1c26:	40a007b3          	neg	a5,a0
    1c2a:	8832                	mv	a6,a2
    1c2c:	8b9d                	andi	a5,a5,7
    1c2e:	4681                	li	a3,0
    1c30:	e4060be3          	beqz	a2,1a86 <strncpy+0x44>
    1c34:	b7cd                	j	1c16 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c36:	468d                	li	a3,3
    1c38:	bd75                	j	1af4 <strncpy+0xb2>
    1c3a:	872a                	mv	a4,a0
    1c3c:	4681                	li	a3,0
    1c3e:	bd5d                	j	1af4 <strncpy+0xb2>
    1c40:	4685                	li	a3,1
    1c42:	bd4d                	j	1af4 <strncpy+0xb2>
    1c44:	8082                	ret
    1c46:	87aa                	mv	a5,a0
    1c48:	4681                	li	a3,0
    1c4a:	b5f9                	j	1b18 <strncpy+0xd6>
    1c4c:	4689                	li	a3,2
    1c4e:	b55d                	j	1af4 <strncpy+0xb2>
    1c50:	4691                	li	a3,4
    1c52:	b54d                	j	1af4 <strncpy+0xb2>
    1c54:	4695                	li	a3,5
    1c56:	bd79                	j	1af4 <strncpy+0xb2>
    1c58:	4699                	li	a3,6
    1c5a:	bd69                	j	1af4 <strncpy+0xb2>
    1c5c:	8082                	ret
    1c5e:	8082                	ret
    1c60:	8082                	ret

0000000000001c62 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c62:	87aa                	mv	a5,a0
    1c64:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c66:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c6a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c6e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c70:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c72:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c76:	2501                	sext.w	a0,a0
    1c78:	8082                	ret

0000000000001c7a <openat>:
    register long a7 __asm__("a7") = n;
    1c7a:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c7e:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c82:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c86:	2501                	sext.w	a0,a0
    1c88:	8082                	ret

0000000000001c8a <close>:
    register long a7 __asm__("a7") = n;
    1c8a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c8e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c92:	2501                	sext.w	a0,a0
    1c94:	8082                	ret

0000000000001c96 <read>:
    register long a7 __asm__("a7") = n;
    1c96:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c9a:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c9e:	8082                	ret

0000000000001ca0 <write>:
    register long a7 __asm__("a7") = n;
    1ca0:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca4:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ca8:	8082                	ret

0000000000001caa <getpid>:
    register long a7 __asm__("a7") = n;
    1caa:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cae:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cb2:	2501                	sext.w	a0,a0
    1cb4:	8082                	ret

0000000000001cb6 <getppid>:
    register long a7 __asm__("a7") = n;
    1cb6:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cba:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cbe:	2501                	sext.w	a0,a0
    1cc0:	8082                	ret

0000000000001cc2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cc2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cc6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <fork>:
    register long a7 __asm__("a7") = n;
    1cce:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cd2:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cd4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cde:	85b2                	mv	a1,a2
    1ce0:	863a                	mv	a2,a4
    if (stack)
    1ce2:	c191                	beqz	a1,1ce6 <clone+0x8>
	stack += stack_size;
    1ce4:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1ce6:	4781                	li	a5,0
    1ce8:	4701                	li	a4,0
    1cea:	4681                	li	a3,0
    1cec:	2601                	sext.w	a2,a2
    1cee:	a2ed                	j	1ed8 <__clone>

0000000000001cf0 <exit>:
    register long a7 __asm__("a7") = n;
    1cf0:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cf4:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cf8:	8082                	ret

0000000000001cfa <waitpid>:
    register long a7 __asm__("a7") = n;
    1cfa:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cfe:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d00:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <exec>:
    register long a7 __asm__("a7") = n;
    1d08:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d0c:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <execve>:
    register long a7 __asm__("a7") = n;
    1d14:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d18:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d1c:	2501                	sext.w	a0,a0
    1d1e:	8082                	ret

0000000000001d20 <times>:
    register long a7 __asm__("a7") = n;
    1d20:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d24:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d28:	2501                	sext.w	a0,a0
    1d2a:	8082                	ret

0000000000001d2c <get_time>:

int64 get_time()
{
    1d2c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d2e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d32:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d34:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d36:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d3a:	2501                	sext.w	a0,a0
    1d3c:	ed09                	bnez	a0,1d56 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d3e:	67a2                	ld	a5,8(sp)
    1d40:	3e800713          	li	a4,1000
    1d44:	00015503          	lhu	a0,0(sp)
    1d48:	02e7d7b3          	divu	a5,a5,a4
    1d4c:	02e50533          	mul	a0,a0,a4
    1d50:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d52:	0141                	addi	sp,sp,16
    1d54:	8082                	ret
        return -1;
    1d56:	557d                	li	a0,-1
    1d58:	bfed                	j	1d52 <get_time+0x26>

0000000000001d5a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d5a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <time>:
    register long a7 __asm__("a7") = n;
    1d66:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d6a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d6e:	2501                	sext.w	a0,a0
    1d70:	8082                	ret

0000000000001d72 <sleep>:

int sleep(unsigned long long time)
{
    1d72:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d74:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d76:	850a                	mv	a0,sp
    1d78:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d7a:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d7e:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d80:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d84:	e501                	bnez	a0,1d8c <sleep+0x1a>
    return 0;
    1d86:	4501                	li	a0,0
}
    1d88:	0141                	addi	sp,sp,16
    1d8a:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d8c:	4502                	lw	a0,0(sp)
}
    1d8e:	0141                	addi	sp,sp,16
    1d90:	8082                	ret

0000000000001d92 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d92:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d96:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d9e:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1da2:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1da6:	8082                	ret

0000000000001da8 <munmap>:
    register long a7 __asm__("a7") = n;
    1da8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dac:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1db0:	2501                	sext.w	a0,a0
    1db2:	8082                	ret

0000000000001db4 <wait>:

int wait(int *code)
{
    1db4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1db6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dba:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dbc:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dbe:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dc0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dc4:	2501                	sext.w	a0,a0
    1dc6:	8082                	ret

0000000000001dc8 <spawn>:
    register long a7 __asm__("a7") = n;
    1dc8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dcc:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <mailread>:
    register long a7 __asm__("a7") = n;
    1dd4:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd8:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1ddc:	2501                	sext.w	a0,a0
    1dde:	8082                	ret

0000000000001de0 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1de0:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1de4:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1de8:	2501                	sext.w	a0,a0
    1dea:	8082                	ret

0000000000001dec <fstat>:
    register long a7 __asm__("a7") = n;
    1dec:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df0:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1df8:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dfa:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dfe:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e00:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e04:	2501                	sext.w	a0,a0
    1e06:	8082                	ret

0000000000001e08 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e08:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e0a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e0e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e10:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e14:	2501                	sext.w	a0,a0
    1e16:	8082                	ret

0000000000001e18 <link>:

int link(char *old_path, char *new_path)
{
    1e18:	87aa                	mv	a5,a0
    1e1a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e1c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e20:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e24:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e26:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e2a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e2c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e30:	2501                	sext.w	a0,a0
    1e32:	8082                	ret

0000000000001e34 <unlink>:

int unlink(char *path)
{
    1e34:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e36:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e3a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e3e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e40:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e44:	2501                	sext.w	a0,a0
    1e46:	8082                	ret

0000000000001e48 <uname>:
    register long a7 __asm__("a7") = n;
    1e48:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e4c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e50:	2501                	sext.w	a0,a0
    1e52:	8082                	ret

0000000000001e54 <brk>:
    register long a7 __asm__("a7") = n;
    1e54:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e58:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e5c:	2501                	sext.w	a0,a0
    1e5e:	8082                	ret

0000000000001e60 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e60:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e62:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e66:	8082                	ret

0000000000001e68 <chdir>:
    register long a7 __asm__("a7") = n;
    1e68:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e6c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e70:	2501                	sext.w	a0,a0
    1e72:	8082                	ret

0000000000001e74 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e74:	862e                	mv	a2,a1
    1e76:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e78:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e7a:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e7e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e82:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e84:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e86:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e8a:	2501                	sext.w	a0,a0
    1e8c:	8082                	ret

0000000000001e8e <getdents>:
    register long a7 __asm__("a7") = n;
    1e8e:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e92:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <pipe>:
    register long a7 __asm__("a7") = n;
    1e9a:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e9e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea0:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ea4:	2501                	sext.w	a0,a0
    1ea6:	8082                	ret

0000000000001ea8 <dup>:
    register long a7 __asm__("a7") = n;
    1ea8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eaa:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <dup2>:
    register long a7 __asm__("a7") = n;
    1eb2:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eb4:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb6:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eba:	2501                	sext.w	a0,a0
    1ebc:	8082                	ret

0000000000001ebe <mount>:
    register long a7 __asm__("a7") = n;
    1ebe:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ec2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ec6:	2501                	sext.w	a0,a0
    1ec8:	8082                	ret

0000000000001eca <umount>:
    register long a7 __asm__("a7") = n;
    1eca:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ece:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed0:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ed4:	2501                	sext.w	a0,a0
    1ed6:	8082                	ret

0000000000001ed8 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ed8:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eda:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1edc:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ede:	8532                	mv	a0,a2
	mv a2, a4
    1ee0:	863a                	mv	a2,a4
	mv a3, a5
    1ee2:	86be                	mv	a3,a5
	mv a4, a6
    1ee4:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ee6:	0dc00893          	li	a7,220
	ecall
    1eea:	00000073          	ecall

	beqz a0, 1f
    1eee:	c111                	beqz	a0,1ef2 <__clone+0x1a>
	# Parent
	ret
    1ef0:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ef2:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ef4:	6522                	ld	a0,8(sp)
	jalr a1
    1ef6:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ef8:	05d00893          	li	a7,93
	ecall
    1efc:	00000073          	ecall
