
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/unlink:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a8f9                	j	10e0 <__start_main>

0000000000001004 <test_unlink>:
 * 测试失败，应有如下输出：
 * "  unlink error!"
 */

int test_unlink()
{
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f1a50513          	addi	a0,a0,-230 # 1f20 <__clone+0x2c>
{
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	306000ef          	jal	ra,1318 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fc250513          	addi	a0,a0,-62 # 1fd8 <__func__.1191>
    101e:	2fa000ef          	jal	ra,1318 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f1650513          	addi	a0,a0,-234 # 1f38 <__clone+0x44>
    102a:	2ee000ef          	jal	ra,1318 <puts>

    char *fname = "./test_unlink";
    int fd, ret;

    fd = open(fname, O_CREATE | O_WRONLY);
    102e:	04100593          	li	a1,65
    1032:	00001517          	auipc	a0,0x1
    1036:	f1650513          	addi	a0,a0,-234 # 1f48 <__clone+0x54>
    103a:	445000ef          	jal	ra,1c7e <open>
    103e:	842a                	mv	s0,a0
    assert(fd > 0);
    1040:	08a05163          	blez	a0,10c2 <test_unlink+0xbe>
    close(fd);
    1044:	8522                	mv	a0,s0
    1046:	461000ef          	jal	ra,1ca6 <close>

    // unlink test
    ret = unlink(fname);
    104a:	00001517          	auipc	a0,0x1
    104e:	efe50513          	addi	a0,a0,-258 # 1f48 <__clone+0x54>
    1052:	5ff000ef          	jal	ra,1e50 <unlink>
    assert(ret == 0);
    1056:	ed39                	bnez	a0,10b4 <test_unlink+0xb0>
    fd = open(fname, O_RDONLY);
    1058:	4581                	li	a1,0
    105a:	00001517          	auipc	a0,0x1
    105e:	eee50513          	addi	a0,a0,-274 # 1f48 <__clone+0x54>
    1062:	41d000ef          	jal	ra,1c7e <open>
    1066:	842a                	mv	s0,a0
    if(fd < 0){
    1068:	02054f63          	bltz	a0,10a6 <test_unlink+0xa2>
        printf("  unlink success!\n");
    }else{
	printf("  unlink error!\n");
    106c:	00001517          	auipc	a0,0x1
    1070:	f2450513          	addi	a0,a0,-220 # 1f90 <__clone+0x9c>
    1074:	2c6000ef          	jal	ra,133a <printf>
        close(fd);
    1078:	8522                	mv	a0,s0
    107a:	42d000ef          	jal	ra,1ca6 <close>
    }
    // It's Ok if you don't delete the inode and data blocks.

    TEST_END(__func__);
    107e:	00001517          	auipc	a0,0x1
    1082:	f2a50513          	addi	a0,a0,-214 # 1fa8 <__clone+0xb4>
    1086:	292000ef          	jal	ra,1318 <puts>
    108a:	00001517          	auipc	a0,0x1
    108e:	f4e50513          	addi	a0,a0,-178 # 1fd8 <__func__.1191>
    1092:	286000ef          	jal	ra,1318 <puts>
}
    1096:	6402                	ld	s0,0(sp)
    1098:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    109a:	00001517          	auipc	a0,0x1
    109e:	e9e50513          	addi	a0,a0,-354 # 1f38 <__clone+0x44>
}
    10a2:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10a4:	ac95                	j	1318 <puts>
        printf("  unlink success!\n");
    10a6:	00001517          	auipc	a0,0x1
    10aa:	ed250513          	addi	a0,a0,-302 # 1f78 <__clone+0x84>
    10ae:	28c000ef          	jal	ra,133a <printf>
    10b2:	b7f1                	j	107e <test_unlink+0x7a>
    assert(ret == 0);
    10b4:	00001517          	auipc	a0,0x1
    10b8:	ea450513          	addi	a0,a0,-348 # 1f58 <__clone+0x64>
    10bc:	53e000ef          	jal	ra,15fa <panic>
    10c0:	bf61                	j	1058 <test_unlink+0x54>
    assert(fd > 0);
    10c2:	00001517          	auipc	a0,0x1
    10c6:	e9650513          	addi	a0,a0,-362 # 1f58 <__clone+0x64>
    10ca:	530000ef          	jal	ra,15fa <panic>
    10ce:	bf9d                	j	1044 <test_unlink+0x40>

00000000000010d0 <main>:

int main(void) {
    10d0:	1141                	addi	sp,sp,-16
    10d2:	e406                	sd	ra,8(sp)
	test_unlink();
    10d4:	f31ff0ef          	jal	ra,1004 <test_unlink>
	return 0;
}
    10d8:	60a2                	ld	ra,8(sp)
    10da:	4501                	li	a0,0
    10dc:	0141                	addi	sp,sp,16
    10de:	8082                	ret

00000000000010e0 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10e0:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10e2:	4108                	lw	a0,0(a0)
{
    10e4:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10e6:	05a1                	addi	a1,a1,8
{
    10e8:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ea:	fe7ff0ef          	jal	ra,10d0 <main>
    10ee:	41f000ef          	jal	ra,1d0c <exit>
	return 0;
}
    10f2:	60a2                	ld	ra,8(sp)
    10f4:	4501                	li	a0,0
    10f6:	0141                	addi	sp,sp,16
    10f8:	8082                	ret

00000000000010fa <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10fa:	7179                	addi	sp,sp,-48
    10fc:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10fe:	12054b63          	bltz	a0,1234 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1102:	02b577bb          	remuw	a5,a0,a1
    1106:	00001697          	auipc	a3,0x1
    110a:	ee268693          	addi	a3,a3,-286 # 1fe8 <digits>
    buf[16] = 0;
    110e:	00010c23          	sb	zero,24(sp)
    i = 15;
    1112:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1116:	1782                	slli	a5,a5,0x20
    1118:	9381                	srli	a5,a5,0x20
    111a:	97b6                	add	a5,a5,a3
    111c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1120:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1124:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1128:	16b56263          	bltu	a0,a1,128c <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    112c:	02e8763b          	remuw	a2,a6,a4
    1130:	1602                	slli	a2,a2,0x20
    1132:	9201                	srli	a2,a2,0x20
    1134:	9636                	add	a2,a2,a3
    1136:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    113a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    113e:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1142:	12e86963          	bltu	a6,a4,1274 <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    1146:	02e5f63b          	remuw	a2,a1,a4
    114a:	1602                	slli	a2,a2,0x20
    114c:	9201                	srli	a2,a2,0x20
    114e:	9636                	add	a2,a2,a3
    1150:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1154:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1158:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    115c:	10e5ef63          	bltu	a1,a4,127a <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    1160:	02e8763b          	remuw	a2,a6,a4
    1164:	1602                	slli	a2,a2,0x20
    1166:	9201                	srli	a2,a2,0x20
    1168:	9636                	add	a2,a2,a3
    116a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    116e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1172:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    1176:	10e86563          	bltu	a6,a4,1280 <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    117a:	02e5f63b          	remuw	a2,a1,a4
    117e:	1602                	slli	a2,a2,0x20
    1180:	9201                	srli	a2,a2,0x20
    1182:	9636                	add	a2,a2,a3
    1184:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1188:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    118c:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    1190:	0ee5eb63          	bltu	a1,a4,1286 <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    1194:	02e8763b          	remuw	a2,a6,a4
    1198:	1602                	slli	a2,a2,0x20
    119a:	9201                	srli	a2,a2,0x20
    119c:	9636                	add	a2,a2,a3
    119e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11a2:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a6:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    11aa:	0ce86263          	bltu	a6,a4,126e <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    11ae:	02e5f63b          	remuw	a2,a1,a4
    11b2:	1602                	slli	a2,a2,0x20
    11b4:	9201                	srli	a2,a2,0x20
    11b6:	9636                	add	a2,a2,a3
    11b8:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11bc:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11c0:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    11c4:	0ce5e663          	bltu	a1,a4,1290 <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    11c8:	02e8763b          	remuw	a2,a6,a4
    11cc:	1602                	slli	a2,a2,0x20
    11ce:	9201                	srli	a2,a2,0x20
    11d0:	9636                	add	a2,a2,a3
    11d2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11d6:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11da:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11de:	0ae86c63          	bltu	a6,a4,1296 <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11e2:	02e5f63b          	remuw	a2,a1,a4
    11e6:	1602                	slli	a2,a2,0x20
    11e8:	9201                	srli	a2,a2,0x20
    11ea:	9636                	add	a2,a2,a3
    11ec:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11f0:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11f4:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11f8:	0ae5e263          	bltu	a1,a4,129c <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11fc:	1782                	slli	a5,a5,0x20
    11fe:	9381                	srli	a5,a5,0x20
    1200:	97b6                	add	a5,a5,a3
    1202:	0007c703          	lbu	a4,0(a5)
    1206:	4599                	li	a1,6
    1208:	4795                	li	a5,5
    120a:	00e10723          	sb	a4,14(sp)

    if (sign)
    120e:	00055963          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1212:	1018                	addi	a4,sp,32
    1214:	973e                	add	a4,a4,a5
    1216:	02d00693          	li	a3,45
    121a:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    121e:	85be                	mv	a1,a5
    write(f, s, l);
    1220:	003c                	addi	a5,sp,8
    1222:	4641                	li	a2,16
    1224:	9e0d                	subw	a2,a2,a1
    1226:	4505                	li	a0,1
    1228:	95be                	add	a1,a1,a5
    122a:	293000ef          	jal	ra,1cbc <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    122e:	70a2                	ld	ra,40(sp)
    1230:	6145                	addi	sp,sp,48
    1232:	8082                	ret
        x = -xx;
    1234:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    1238:	02b677bb          	remuw	a5,a2,a1
    123c:	00001697          	auipc	a3,0x1
    1240:	dac68693          	addi	a3,a3,-596 # 1fe8 <digits>
    buf[16] = 0;
    1244:	00010c23          	sb	zero,24(sp)
    i = 15;
    1248:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    124c:	1782                	slli	a5,a5,0x20
    124e:	9381                	srli	a5,a5,0x20
    1250:	97b6                	add	a5,a5,a3
    1252:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1256:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    125a:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    125e:	ecb677e3          	bgeu	a2,a1,112c <printint.constprop.0+0x32>
        buf[i--] = '-';
    1262:	02d00793          	li	a5,45
    1266:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    126a:	45b9                	li	a1,14
    126c:	bf55                	j	1220 <printint.constprop.0+0x126>
    126e:	47a5                	li	a5,9
    1270:	45a9                	li	a1,10
    1272:	bf71                	j	120e <printint.constprop.0+0x114>
    1274:	47b5                	li	a5,13
    1276:	45b9                	li	a1,14
    1278:	bf59                	j	120e <printint.constprop.0+0x114>
    127a:	47b1                	li	a5,12
    127c:	45b5                	li	a1,13
    127e:	bf41                	j	120e <printint.constprop.0+0x114>
    1280:	47ad                	li	a5,11
    1282:	45b1                	li	a1,12
    1284:	b769                	j	120e <printint.constprop.0+0x114>
    1286:	47a9                	li	a5,10
    1288:	45ad                	li	a1,11
    128a:	b751                	j	120e <printint.constprop.0+0x114>
    i = 15;
    128c:	45bd                	li	a1,15
    128e:	bf49                	j	1220 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1290:	47a1                	li	a5,8
    1292:	45a5                	li	a1,9
    1294:	bfad                	j	120e <printint.constprop.0+0x114>
    1296:	479d                	li	a5,7
    1298:	45a1                	li	a1,8
    129a:	bf95                	j	120e <printint.constprop.0+0x114>
    129c:	4799                	li	a5,6
    129e:	459d                	li	a1,7
    12a0:	b7bd                	j	120e <printint.constprop.0+0x114>

00000000000012a2 <getchar>:
{
    12a2:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12a4:	00f10593          	addi	a1,sp,15
    12a8:	4605                	li	a2,1
    12aa:	4501                	li	a0,0
{
    12ac:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12ae:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12b2:	201000ef          	jal	ra,1cb2 <read>
}
    12b6:	60e2                	ld	ra,24(sp)
    12b8:	00f14503          	lbu	a0,15(sp)
    12bc:	6105                	addi	sp,sp,32
    12be:	8082                	ret

00000000000012c0 <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12c0:	00001797          	auipc	a5,0x1
    12c4:	d4078793          	addi	a5,a5,-704 # 2000 <digits+0x18>
    12c8:	04000893          	li	a7,64
    12cc:	4505                	li	a0,1
    12ce:	85be                	mv	a1,a5
    12d0:	4611                	li	a2,4
    12d2:	00000073          	ecall
}
    12d6:	4501                	li	a0,0
    12d8:	8082                	ret

00000000000012da <putchar>:
{
    12da:	1101                	addi	sp,sp,-32
    12dc:	ec06                	sd	ra,24(sp)
    12de:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12e0:	3e700893          	li	a7,999
    12e4:	4505                	li	a0,1
    12e6:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12ea:	00001717          	auipc	a4,0x1
    12ee:	d1670713          	addi	a4,a4,-746 # 2000 <digits+0x18>
    12f2:	04000893          	li	a7,64
    12f6:	4505                	li	a0,1
    12f8:	85ba                	mv	a1,a4
    12fa:	4611                	li	a2,4
    12fc:	00000073          	ecall
    return write(stdout, &byte, 1);
    1300:	4605                	li	a2,1
    1302:	00f10593          	addi	a1,sp,15
    1306:	4505                	li	a0,1
    char byte = c;
    1308:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    130c:	1b1000ef          	jal	ra,1cbc <write>
}
    1310:	60e2                	ld	ra,24(sp)
    1312:	2501                	sext.w	a0,a0
    1314:	6105                	addi	sp,sp,32
    1316:	8082                	ret

0000000000001318 <puts>:
{
    1318:	1141                	addi	sp,sp,-16
    131a:	e406                	sd	ra,8(sp)
    131c:	e022                	sd	s0,0(sp)
    131e:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1320:	5b8000ef          	jal	ra,18d8 <strlen>
    1324:	862a                	mv	a2,a0
    1326:	85a2                	mv	a1,s0
    1328:	4505                	li	a0,1
    132a:	193000ef          	jal	ra,1cbc <write>
}
    132e:	60a2                	ld	ra,8(sp)
    1330:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1332:	957d                	srai	a0,a0,0x3f
    return r;
    1334:	2501                	sext.w	a0,a0
}
    1336:	0141                	addi	sp,sp,16
    1338:	8082                	ret

000000000000133a <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    133a:	7171                	addi	sp,sp,-176
    133c:	e0d2                	sd	s4,64(sp)
    133e:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    1340:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1342:	18bc                	addi	a5,sp,120
{
    1344:	e8ca                	sd	s2,80(sp)
    1346:	e4ce                	sd	s3,72(sp)
    1348:	fc56                	sd	s5,56(sp)
    134a:	f85a                	sd	s6,48(sp)
    134c:	f486                	sd	ra,104(sp)
    134e:	f0a2                	sd	s0,96(sp)
    1350:	eca6                	sd	s1,88(sp)
    1352:	fcae                	sd	a1,120(sp)
    1354:	e132                	sd	a2,128(sp)
    1356:	e536                	sd	a3,136(sp)
    1358:	e93a                	sd	a4,144(sp)
    135a:	f142                	sd	a6,160(sp)
    135c:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    135e:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1360:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1364:	00001b17          	auipc	s6,0x1
    1368:	c54b0b13          	addi	s6,s6,-940 # 1fb8 <__clone+0xc4>
	::"r"((unsigned long long)ac)
    136c:	00001a97          	auipc	s5,0x1
    1370:	c94a8a93          	addi	s5,s5,-876 # 2000 <digits+0x18>
    buf[i++] = '0';
    1374:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1378:	00001997          	auipc	s3,0x1
    137c:	c7098993          	addi	s3,s3,-912 # 1fe8 <digits>
        if (!*s)
    1380:	00054783          	lbu	a5,0(a0)
    1384:	16078c63          	beqz	a5,14fc <printf+0x1c2>
    1388:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    138a:	19278363          	beq	a5,s2,1510 <printf+0x1d6>
    138e:	00164783          	lbu	a5,1(a2)
    1392:	0605                	addi	a2,a2,1
    1394:	fbfd                	bnez	a5,138a <printf+0x50>
    1396:	84b2                	mv	s1,a2
        l = z - a;
    1398:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    139c:	85aa                	mv	a1,a0
    139e:	8622                	mv	a2,s0
    13a0:	4505                	li	a0,1
    13a2:	11b000ef          	jal	ra,1cbc <write>
        if (l)
    13a6:	18041e63          	bnez	s0,1542 <printf+0x208>
        if (s[1] == 0)
    13aa:	0014c783          	lbu	a5,1(s1)
    13ae:	14078763          	beqz	a5,14fc <printf+0x1c2>
        switch (s[1])
    13b2:	07300713          	li	a4,115
    13b6:	1ce78063          	beq	a5,a4,1576 <printf+0x23c>
    13ba:	18f76663          	bltu	a4,a5,1546 <printf+0x20c>
    13be:	06400713          	li	a4,100
    13c2:	1ae78063          	beq	a5,a4,1562 <printf+0x228>
    13c6:	07000713          	li	a4,112
    13ca:	1ce79963          	bne	a5,a4,159c <printf+0x262>
            printptr(va_arg(ap, uint64));
    13ce:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13d0:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13d4:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13d6:	631c                	ld	a5,0(a4)
    13d8:	0721                	addi	a4,a4,8
    13da:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13dc:	00479293          	slli	t0,a5,0x4
    13e0:	00879f93          	slli	t6,a5,0x8
    13e4:	00c79f13          	slli	t5,a5,0xc
    13e8:	01079e93          	slli	t4,a5,0x10
    13ec:	01479e13          	slli	t3,a5,0x14
    13f0:	01879313          	slli	t1,a5,0x18
    13f4:	01c79893          	slli	a7,a5,0x1c
    13f8:	02479813          	slli	a6,a5,0x24
    13fc:	02879513          	slli	a0,a5,0x28
    1400:	02c79593          	slli	a1,a5,0x2c
    1404:	03079693          	slli	a3,a5,0x30
    1408:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    140c:	03c7d413          	srli	s0,a5,0x3c
    1410:	01c7d39b          	srliw	t2,a5,0x1c
    1414:	03c2d293          	srli	t0,t0,0x3c
    1418:	03cfdf93          	srli	t6,t6,0x3c
    141c:	03cf5f13          	srli	t5,t5,0x3c
    1420:	03cede93          	srli	t4,t4,0x3c
    1424:	03ce5e13          	srli	t3,t3,0x3c
    1428:	03c35313          	srli	t1,t1,0x3c
    142c:	03c8d893          	srli	a7,a7,0x3c
    1430:	03c85813          	srli	a6,a6,0x3c
    1434:	9171                	srli	a0,a0,0x3c
    1436:	91f1                	srli	a1,a1,0x3c
    1438:	92f1                	srli	a3,a3,0x3c
    143a:	9371                	srli	a4,a4,0x3c
    143c:	96ce                	add	a3,a3,s3
    143e:	974e                	add	a4,a4,s3
    1440:	944e                	add	s0,s0,s3
    1442:	92ce                	add	t0,t0,s3
    1444:	9fce                	add	t6,t6,s3
    1446:	9f4e                	add	t5,t5,s3
    1448:	9ece                	add	t4,t4,s3
    144a:	9e4e                	add	t3,t3,s3
    144c:	934e                	add	t1,t1,s3
    144e:	98ce                	add	a7,a7,s3
    1450:	93ce                	add	t2,t2,s3
    1452:	984e                	add	a6,a6,s3
    1454:	954e                	add	a0,a0,s3
    1456:	95ce                	add	a1,a1,s3
    1458:	0006c083          	lbu	ra,0(a3)
    145c:	0002c283          	lbu	t0,0(t0)
    1460:	00074683          	lbu	a3,0(a4)
    1464:	000fcf83          	lbu	t6,0(t6)
    1468:	000f4f03          	lbu	t5,0(t5)
    146c:	000ece83          	lbu	t4,0(t4)
    1470:	000e4e03          	lbu	t3,0(t3)
    1474:	00034303          	lbu	t1,0(t1)
    1478:	0008c883          	lbu	a7,0(a7)
    147c:	0003c383          	lbu	t2,0(t2)
    1480:	00084803          	lbu	a6,0(a6)
    1484:	00054503          	lbu	a0,0(a0)
    1488:	0005c583          	lbu	a1,0(a1)
    148c:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1490:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1494:	9371                	srli	a4,a4,0x3c
    1496:	8bbd                	andi	a5,a5,15
    1498:	974e                	add	a4,a4,s3
    149a:	97ce                	add	a5,a5,s3
    149c:	005105a3          	sb	t0,11(sp)
    14a0:	01f10623          	sb	t6,12(sp)
    14a4:	01e106a3          	sb	t5,13(sp)
    14a8:	01d10723          	sb	t4,14(sp)
    14ac:	01c107a3          	sb	t3,15(sp)
    14b0:	00610823          	sb	t1,16(sp)
    14b4:	011108a3          	sb	a7,17(sp)
    14b8:	00710923          	sb	t2,18(sp)
    14bc:	010109a3          	sb	a6,19(sp)
    14c0:	00a10a23          	sb	a0,20(sp)
    14c4:	00b10aa3          	sb	a1,21(sp)
    14c8:	00110b23          	sb	ra,22(sp)
    14cc:	00d10ba3          	sb	a3,23(sp)
    14d0:	00810523          	sb	s0,10(sp)
    14d4:	00074703          	lbu	a4,0(a4)
    14d8:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14dc:	002c                	addi	a1,sp,8
    14de:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e0:	00e10c23          	sb	a4,24(sp)
    14e4:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14e8:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14ec:	7d0000ef          	jal	ra,1cbc <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14f0:	00248513          	addi	a0,s1,2
        if (!*s)
    14f4:	00054783          	lbu	a5,0(a0)
    14f8:	e80798e3          	bnez	a5,1388 <printf+0x4e>
    }
    va_end(ap);
}
    14fc:	70a6                	ld	ra,104(sp)
    14fe:	7406                	ld	s0,96(sp)
    1500:	64e6                	ld	s1,88(sp)
    1502:	6946                	ld	s2,80(sp)
    1504:	69a6                	ld	s3,72(sp)
    1506:	6a06                	ld	s4,64(sp)
    1508:	7ae2                	ld	s5,56(sp)
    150a:	7b42                	ld	s6,48(sp)
    150c:	614d                	addi	sp,sp,176
    150e:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1510:	00064783          	lbu	a5,0(a2)
    1514:	84b2                	mv	s1,a2
    1516:	01278963          	beq	a5,s2,1528 <printf+0x1ee>
    151a:	bdbd                	j	1398 <printf+0x5e>
    151c:	0024c783          	lbu	a5,2(s1)
    1520:	0605                	addi	a2,a2,1
    1522:	0489                	addi	s1,s1,2
    1524:	e7279ae3          	bne	a5,s2,1398 <printf+0x5e>
    1528:	0014c783          	lbu	a5,1(s1)
    152c:	ff2788e3          	beq	a5,s2,151c <printf+0x1e2>
        l = z - a;
    1530:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1534:	85aa                	mv	a1,a0
    1536:	8622                	mv	a2,s0
    1538:	4505                	li	a0,1
    153a:	782000ef          	jal	ra,1cbc <write>
        if (l)
    153e:	e60406e3          	beqz	s0,13aa <printf+0x70>
    1542:	8526                	mv	a0,s1
    1544:	bd35                	j	1380 <printf+0x46>
        switch (s[1])
    1546:	07800713          	li	a4,120
    154a:	04e79963          	bne	a5,a4,159c <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    154e:	6782                	ld	a5,0(sp)
    1550:	45c1                	li	a1,16
    1552:	4388                	lw	a0,0(a5)
    1554:	07a1                	addi	a5,a5,8
    1556:	e03e                	sd	a5,0(sp)
    1558:	ba3ff0ef          	jal	ra,10fa <printint.constprop.0>
        s += 2;
    155c:	00248513          	addi	a0,s1,2
    1560:	bf51                	j	14f4 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1562:	6782                	ld	a5,0(sp)
    1564:	45a9                	li	a1,10
    1566:	4388                	lw	a0,0(a5)
    1568:	07a1                	addi	a5,a5,8
    156a:	e03e                	sd	a5,0(sp)
    156c:	b8fff0ef          	jal	ra,10fa <printint.constprop.0>
        s += 2;
    1570:	00248513          	addi	a0,s1,2
    1574:	b741                	j	14f4 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1576:	6782                	ld	a5,0(sp)
    1578:	6380                	ld	s0,0(a5)
    157a:	07a1                	addi	a5,a5,8
    157c:	e03e                	sd	a5,0(sp)
    157e:	cc25                	beqz	s0,15f6 <printf+0x2bc>
            l = strnlen(a, 200);
    1580:	0c800593          	li	a1,200
    1584:	8522                	mv	a0,s0
    1586:	43e000ef          	jal	ra,19c4 <strnlen>
    write(f, s, l);
    158a:	0005061b          	sext.w	a2,a0
    158e:	85a2                	mv	a1,s0
    1590:	4505                	li	a0,1
    1592:	72a000ef          	jal	ra,1cbc <write>
        s += 2;
    1596:	00248513          	addi	a0,s1,2
    159a:	bfa9                	j	14f4 <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    159c:	3e700893          	li	a7,999
    15a0:	4505                	li	a0,1
    15a2:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15a6:	04000893          	li	a7,64
    15aa:	4505                	li	a0,1
    15ac:	85d6                	mv	a1,s5
    15ae:	4611                	li	a2,4
    15b0:	00000073          	ecall
    char byte = c;
    15b4:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    15b8:	4605                	li	a2,1
    15ba:	002c                	addi	a1,sp,8
    15bc:	4505                	li	a0,1
    char byte = c;
    15be:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15c2:	6fa000ef          	jal	ra,1cbc <write>
            putchar(s[1]);
    15c6:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15ca:	3e700893          	li	a7,999
    15ce:	4505                	li	a0,1
    15d0:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15d4:	04000893          	li	a7,64
    15d8:	4505                	li	a0,1
    15da:	85d6                	mv	a1,s5
    15dc:	4611                	li	a2,4
    15de:	00000073          	ecall
    return write(stdout, &byte, 1);
    15e2:	4605                	li	a2,1
    15e4:	002c                	addi	a1,sp,8
    15e6:	4505                	li	a0,1
    char byte = c;
    15e8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ec:	6d0000ef          	jal	ra,1cbc <write>
        s += 2;
    15f0:	00248513          	addi	a0,s1,2
    15f4:	b701                	j	14f4 <printf+0x1ba>
                a = "(null)";
    15f6:	845a                	mv	s0,s6
    15f8:	b761                	j	1580 <printf+0x246>

00000000000015fa <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15fa:	1141                	addi	sp,sp,-16
    15fc:	e406                	sd	ra,8(sp)
    puts(m);
    15fe:	d1bff0ef          	jal	ra,1318 <puts>
    exit(-100);
}
    1602:	60a2                	ld	ra,8(sp)
    exit(-100);
    1604:	f9c00513          	li	a0,-100
}
    1608:	0141                	addi	sp,sp,16
    exit(-100);
    160a:	a709                	j	1d0c <exit>

000000000000160c <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    160c:	02000793          	li	a5,32
    1610:	00f50663          	beq	a0,a5,161c <isspace+0x10>
    1614:	355d                	addiw	a0,a0,-9
    1616:	00553513          	sltiu	a0,a0,5
    161a:	8082                	ret
    161c:	4505                	li	a0,1
}
    161e:	8082                	ret

0000000000001620 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1620:	fd05051b          	addiw	a0,a0,-48
}
    1624:	00a53513          	sltiu	a0,a0,10
    1628:	8082                	ret

000000000000162a <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    162a:	02000613          	li	a2,32
    162e:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1630:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1634:	ff77069b          	addiw	a3,a4,-9
    1638:	04c70d63          	beq	a4,a2,1692 <atoi+0x68>
    163c:	0007079b          	sext.w	a5,a4
    1640:	04d5f963          	bgeu	a1,a3,1692 <atoi+0x68>
        s++;
    switch (*s)
    1644:	02b00693          	li	a3,43
    1648:	04d70a63          	beq	a4,a3,169c <atoi+0x72>
    164c:	02d00693          	li	a3,45
    1650:	06d70463          	beq	a4,a3,16b8 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1654:	fd07859b          	addiw	a1,a5,-48
    1658:	4625                	li	a2,9
    165a:	873e                	mv	a4,a5
    165c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    165e:	4e01                	li	t3,0
    while (isdigit(*s))
    1660:	04b66a63          	bltu	a2,a1,16b4 <atoi+0x8a>
    int n = 0, neg = 0;
    1664:	4501                	li	a0,0
    while (isdigit(*s))
    1666:	4825                	li	a6,9
    1668:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    166c:	0025179b          	slliw	a5,a0,0x2
    1670:	9d3d                	addw	a0,a0,a5
    1672:	fd07031b          	addiw	t1,a4,-48
    1676:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    167a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    167e:	0685                	addi	a3,a3,1
    1680:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1684:	0006071b          	sext.w	a4,a2
    1688:	feb870e3          	bgeu	a6,a1,1668 <atoi+0x3e>
    return neg ? n : -n;
    168c:	000e0563          	beqz	t3,1696 <atoi+0x6c>
}
    1690:	8082                	ret
        s++;
    1692:	0505                	addi	a0,a0,1
    1694:	bf71                	j	1630 <atoi+0x6>
    1696:	4113053b          	subw	a0,t1,a7
    169a:	8082                	ret
    while (isdigit(*s))
    169c:	00154783          	lbu	a5,1(a0)
    16a0:	4625                	li	a2,9
        s++;
    16a2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16a6:	fd07859b          	addiw	a1,a5,-48
    16aa:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16ae:	4e01                	li	t3,0
    while (isdigit(*s))
    16b0:	fab67ae3          	bgeu	a2,a1,1664 <atoi+0x3a>
    16b4:	4501                	li	a0,0
}
    16b6:	8082                	ret
    while (isdigit(*s))
    16b8:	00154783          	lbu	a5,1(a0)
    16bc:	4625                	li	a2,9
        s++;
    16be:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16c2:	fd07859b          	addiw	a1,a5,-48
    16c6:	0007871b          	sext.w	a4,a5
    16ca:	feb665e3          	bltu	a2,a1,16b4 <atoi+0x8a>
        neg = 1;
    16ce:	4e05                	li	t3,1
    16d0:	bf51                	j	1664 <atoi+0x3a>

00000000000016d2 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16d2:	16060d63          	beqz	a2,184c <memset+0x17a>
    16d6:	40a007b3          	neg	a5,a0
    16da:	8b9d                	andi	a5,a5,7
    16dc:	00778713          	addi	a4,a5,7
    16e0:	482d                	li	a6,11
    16e2:	0ff5f593          	zext.b	a1,a1
    16e6:	fff60693          	addi	a3,a2,-1
    16ea:	17076263          	bltu	a4,a6,184e <memset+0x17c>
    16ee:	16e6ea63          	bltu	a3,a4,1862 <memset+0x190>
    16f2:	16078563          	beqz	a5,185c <memset+0x18a>
    16f6:	00b50023          	sb	a1,0(a0)
    16fa:	4705                	li	a4,1
    16fc:	00150e93          	addi	t4,a0,1
    1700:	14e78c63          	beq	a5,a4,1858 <memset+0x186>
    1704:	00b500a3          	sb	a1,1(a0)
    1708:	4709                	li	a4,2
    170a:	00250e93          	addi	t4,a0,2
    170e:	14e78d63          	beq	a5,a4,1868 <memset+0x196>
    1712:	00b50123          	sb	a1,2(a0)
    1716:	470d                	li	a4,3
    1718:	00350e93          	addi	t4,a0,3
    171c:	12e78b63          	beq	a5,a4,1852 <memset+0x180>
    1720:	00b501a3          	sb	a1,3(a0)
    1724:	4711                	li	a4,4
    1726:	00450e93          	addi	t4,a0,4
    172a:	14e78163          	beq	a5,a4,186c <memset+0x19a>
    172e:	00b50223          	sb	a1,4(a0)
    1732:	4715                	li	a4,5
    1734:	00550e93          	addi	t4,a0,5
    1738:	12e78c63          	beq	a5,a4,1870 <memset+0x19e>
    173c:	00b502a3          	sb	a1,5(a0)
    1740:	471d                	li	a4,7
    1742:	00650e93          	addi	t4,a0,6
    1746:	12e79763          	bne	a5,a4,1874 <memset+0x1a2>
    174a:	00750e93          	addi	t4,a0,7
    174e:	00b50323          	sb	a1,6(a0)
    1752:	4f1d                	li	t5,7
    1754:	00859713          	slli	a4,a1,0x8
    1758:	8f4d                	or	a4,a4,a1
    175a:	01059e13          	slli	t3,a1,0x10
    175e:	01c76e33          	or	t3,a4,t3
    1762:	01859313          	slli	t1,a1,0x18
    1766:	006e6333          	or	t1,t3,t1
    176a:	02059893          	slli	a7,a1,0x20
    176e:	011368b3          	or	a7,t1,a7
    1772:	02859813          	slli	a6,a1,0x28
    1776:	40f60333          	sub	t1,a2,a5
    177a:	0108e833          	or	a6,a7,a6
    177e:	03059693          	slli	a3,a1,0x30
    1782:	00d866b3          	or	a3,a6,a3
    1786:	03859713          	slli	a4,a1,0x38
    178a:	97aa                	add	a5,a5,a0
    178c:	ff837813          	andi	a6,t1,-8
    1790:	8f55                	or	a4,a4,a3
    1792:	00f806b3          	add	a3,a6,a5
    1796:	e398                	sd	a4,0(a5)
    1798:	07a1                	addi	a5,a5,8
    179a:	fed79ee3          	bne	a5,a3,1796 <memset+0xc4>
    179e:	ff837693          	andi	a3,t1,-8
    17a2:	00de87b3          	add	a5,t4,a3
    17a6:	01e6873b          	addw	a4,a3,t5
    17aa:	0ad30663          	beq	t1,a3,1856 <memset+0x184>
    17ae:	00b78023          	sb	a1,0(a5)
    17b2:	0017069b          	addiw	a3,a4,1
    17b6:	08c6fb63          	bgeu	a3,a2,184c <memset+0x17a>
    17ba:	00b780a3          	sb	a1,1(a5)
    17be:	0027069b          	addiw	a3,a4,2
    17c2:	08c6f563          	bgeu	a3,a2,184c <memset+0x17a>
    17c6:	00b78123          	sb	a1,2(a5)
    17ca:	0037069b          	addiw	a3,a4,3
    17ce:	06c6ff63          	bgeu	a3,a2,184c <memset+0x17a>
    17d2:	00b781a3          	sb	a1,3(a5)
    17d6:	0047069b          	addiw	a3,a4,4
    17da:	06c6f963          	bgeu	a3,a2,184c <memset+0x17a>
    17de:	00b78223          	sb	a1,4(a5)
    17e2:	0057069b          	addiw	a3,a4,5
    17e6:	06c6f363          	bgeu	a3,a2,184c <memset+0x17a>
    17ea:	00b782a3          	sb	a1,5(a5)
    17ee:	0067069b          	addiw	a3,a4,6
    17f2:	04c6fd63          	bgeu	a3,a2,184c <memset+0x17a>
    17f6:	00b78323          	sb	a1,6(a5)
    17fa:	0077069b          	addiw	a3,a4,7
    17fe:	04c6f763          	bgeu	a3,a2,184c <memset+0x17a>
    1802:	00b783a3          	sb	a1,7(a5)
    1806:	0087069b          	addiw	a3,a4,8
    180a:	04c6f163          	bgeu	a3,a2,184c <memset+0x17a>
    180e:	00b78423          	sb	a1,8(a5)
    1812:	0097069b          	addiw	a3,a4,9
    1816:	02c6fb63          	bgeu	a3,a2,184c <memset+0x17a>
    181a:	00b784a3          	sb	a1,9(a5)
    181e:	00a7069b          	addiw	a3,a4,10
    1822:	02c6f563          	bgeu	a3,a2,184c <memset+0x17a>
    1826:	00b78523          	sb	a1,10(a5)
    182a:	00b7069b          	addiw	a3,a4,11
    182e:	00c6ff63          	bgeu	a3,a2,184c <memset+0x17a>
    1832:	00b785a3          	sb	a1,11(a5)
    1836:	00c7069b          	addiw	a3,a4,12
    183a:	00c6f963          	bgeu	a3,a2,184c <memset+0x17a>
    183e:	00b78623          	sb	a1,12(a5)
    1842:	2735                	addiw	a4,a4,13
    1844:	00c77463          	bgeu	a4,a2,184c <memset+0x17a>
    1848:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    184c:	8082                	ret
    184e:	472d                	li	a4,11
    1850:	bd79                	j	16ee <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1852:	4f0d                	li	t5,3
    1854:	b701                	j	1754 <memset+0x82>
    1856:	8082                	ret
    1858:	4f05                	li	t5,1
    185a:	bded                	j	1754 <memset+0x82>
    185c:	8eaa                	mv	t4,a0
    185e:	4f01                	li	t5,0
    1860:	bdd5                	j	1754 <memset+0x82>
    1862:	87aa                	mv	a5,a0
    1864:	4701                	li	a4,0
    1866:	b7a1                	j	17ae <memset+0xdc>
    1868:	4f09                	li	t5,2
    186a:	b5ed                	j	1754 <memset+0x82>
    186c:	4f11                	li	t5,4
    186e:	b5dd                	j	1754 <memset+0x82>
    1870:	4f15                	li	t5,5
    1872:	b5cd                	j	1754 <memset+0x82>
    1874:	4f19                	li	t5,6
    1876:	bdf9                	j	1754 <memset+0x82>

0000000000001878 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1878:	00054783          	lbu	a5,0(a0)
    187c:	0005c703          	lbu	a4,0(a1)
    1880:	00e79863          	bne	a5,a4,1890 <strcmp+0x18>
    1884:	0505                	addi	a0,a0,1
    1886:	0585                	addi	a1,a1,1
    1888:	fbe5                	bnez	a5,1878 <strcmp>
    188a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    188c:	9d19                	subw	a0,a0,a4
    188e:	8082                	ret
    1890:	0007851b          	sext.w	a0,a5
    1894:	bfe5                	j	188c <strcmp+0x14>

0000000000001896 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1896:	ce05                	beqz	a2,18ce <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1898:	00054703          	lbu	a4,0(a0)
    189c:	0005c783          	lbu	a5,0(a1)
    18a0:	cb0d                	beqz	a4,18d2 <strncmp+0x3c>
    if (!n--)
    18a2:	167d                	addi	a2,a2,-1
    18a4:	00c506b3          	add	a3,a0,a2
    18a8:	a819                	j	18be <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18aa:	00a68e63          	beq	a3,a0,18c6 <strncmp+0x30>
    18ae:	0505                	addi	a0,a0,1
    18b0:	00e79b63          	bne	a5,a4,18c6 <strncmp+0x30>
    18b4:	00054703          	lbu	a4,0(a0)
    18b8:	0005c783          	lbu	a5,0(a1)
    18bc:	cb19                	beqz	a4,18d2 <strncmp+0x3c>
    18be:	0005c783          	lbu	a5,0(a1)
    18c2:	0585                	addi	a1,a1,1
    18c4:	f3fd                	bnez	a5,18aa <strncmp+0x14>
        ;
    return *l - *r;
    18c6:	0007051b          	sext.w	a0,a4
    18ca:	9d1d                	subw	a0,a0,a5
    18cc:	8082                	ret
        return 0;
    18ce:	4501                	li	a0,0
}
    18d0:	8082                	ret
    18d2:	4501                	li	a0,0
    return *l - *r;
    18d4:	9d1d                	subw	a0,a0,a5
    18d6:	8082                	ret

00000000000018d8 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18d8:	00757793          	andi	a5,a0,7
    18dc:	cf89                	beqz	a5,18f6 <strlen+0x1e>
    18de:	87aa                	mv	a5,a0
    18e0:	a029                	j	18ea <strlen+0x12>
    18e2:	0785                	addi	a5,a5,1
    18e4:	0077f713          	andi	a4,a5,7
    18e8:	cb01                	beqz	a4,18f8 <strlen+0x20>
        if (!*s)
    18ea:	0007c703          	lbu	a4,0(a5)
    18ee:	fb75                	bnez	a4,18e2 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18f0:	40a78533          	sub	a0,a5,a0
}
    18f4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18f6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18f8:	6394                	ld	a3,0(a5)
    18fa:	00000597          	auipc	a1,0x0
    18fe:	6c65b583          	ld	a1,1734(a1) # 1fc0 <__clone+0xcc>
    1902:	00000617          	auipc	a2,0x0
    1906:	6c663603          	ld	a2,1734(a2) # 1fc8 <__clone+0xd4>
    190a:	a019                	j	1910 <strlen+0x38>
    190c:	6794                	ld	a3,8(a5)
    190e:	07a1                	addi	a5,a5,8
    1910:	00b68733          	add	a4,a3,a1
    1914:	fff6c693          	not	a3,a3
    1918:	8f75                	and	a4,a4,a3
    191a:	8f71                	and	a4,a4,a2
    191c:	db65                	beqz	a4,190c <strlen+0x34>
    for (; *s; s++)
    191e:	0007c703          	lbu	a4,0(a5)
    1922:	d779                	beqz	a4,18f0 <strlen+0x18>
    1924:	0017c703          	lbu	a4,1(a5)
    1928:	0785                	addi	a5,a5,1
    192a:	d379                	beqz	a4,18f0 <strlen+0x18>
    192c:	0017c703          	lbu	a4,1(a5)
    1930:	0785                	addi	a5,a5,1
    1932:	fb6d                	bnez	a4,1924 <strlen+0x4c>
    1934:	bf75                	j	18f0 <strlen+0x18>

0000000000001936 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1936:	00757713          	andi	a4,a0,7
{
    193a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    193c:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1940:	cb19                	beqz	a4,1956 <memchr+0x20>
    1942:	ce25                	beqz	a2,19ba <memchr+0x84>
    1944:	0007c703          	lbu	a4,0(a5)
    1948:	04b70e63          	beq	a4,a1,19a4 <memchr+0x6e>
    194c:	0785                	addi	a5,a5,1
    194e:	0077f713          	andi	a4,a5,7
    1952:	167d                	addi	a2,a2,-1
    1954:	f77d                	bnez	a4,1942 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1956:	4501                	li	a0,0
    if (n && *s != c)
    1958:	c235                	beqz	a2,19bc <memchr+0x86>
    195a:	0007c703          	lbu	a4,0(a5)
    195e:	04b70363          	beq	a4,a1,19a4 <memchr+0x6e>
        size_t k = ONES * c;
    1962:	00000517          	auipc	a0,0x0
    1966:	66e53503          	ld	a0,1646(a0) # 1fd0 <__clone+0xdc>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    196a:	471d                	li	a4,7
        size_t k = ONES * c;
    196c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1970:	02c77a63          	bgeu	a4,a2,19a4 <memchr+0x6e>
    1974:	00000897          	auipc	a7,0x0
    1978:	64c8b883          	ld	a7,1612(a7) # 1fc0 <__clone+0xcc>
    197c:	00000817          	auipc	a6,0x0
    1980:	64c83803          	ld	a6,1612(a6) # 1fc8 <__clone+0xd4>
    1984:	431d                	li	t1,7
    1986:	a029                	j	1990 <memchr+0x5a>
    1988:	1661                	addi	a2,a2,-8
    198a:	07a1                	addi	a5,a5,8
    198c:	02c37963          	bgeu	t1,a2,19be <memchr+0x88>
    1990:	6398                	ld	a4,0(a5)
    1992:	8f29                	xor	a4,a4,a0
    1994:	011706b3          	add	a3,a4,a7
    1998:	fff74713          	not	a4,a4
    199c:	8f75                	and	a4,a4,a3
    199e:	01077733          	and	a4,a4,a6
    19a2:	d37d                	beqz	a4,1988 <memchr+0x52>
    19a4:	853e                	mv	a0,a5
    19a6:	97b2                	add	a5,a5,a2
    19a8:	a021                	j	19b0 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19aa:	0505                	addi	a0,a0,1
    19ac:	00f50763          	beq	a0,a5,19ba <memchr+0x84>
    19b0:	00054703          	lbu	a4,0(a0)
    19b4:	feb71be3          	bne	a4,a1,19aa <memchr+0x74>
    19b8:	8082                	ret
    return n ? (void *)s : 0;
    19ba:	4501                	li	a0,0
}
    19bc:	8082                	ret
    return n ? (void *)s : 0;
    19be:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19c0:	f275                	bnez	a2,19a4 <memchr+0x6e>
}
    19c2:	8082                	ret

00000000000019c4 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19c4:	1101                	addi	sp,sp,-32
    19c6:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19c8:	862e                	mv	a2,a1
{
    19ca:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19cc:	4581                	li	a1,0
{
    19ce:	e426                	sd	s1,8(sp)
    19d0:	ec06                	sd	ra,24(sp)
    19d2:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19d4:	f63ff0ef          	jal	ra,1936 <memchr>
    return p ? p - s : n;
    19d8:	c519                	beqz	a0,19e6 <strnlen+0x22>
}
    19da:	60e2                	ld	ra,24(sp)
    19dc:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19de:	8d05                	sub	a0,a0,s1
}
    19e0:	64a2                	ld	s1,8(sp)
    19e2:	6105                	addi	sp,sp,32
    19e4:	8082                	ret
    19e6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19e8:	8522                	mv	a0,s0
}
    19ea:	6442                	ld	s0,16(sp)
    19ec:	64a2                	ld	s1,8(sp)
    19ee:	6105                	addi	sp,sp,32
    19f0:	8082                	ret

00000000000019f2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19f2:	00b547b3          	xor	a5,a0,a1
    19f6:	8b9d                	andi	a5,a5,7
    19f8:	eb95                	bnez	a5,1a2c <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19fa:	0075f793          	andi	a5,a1,7
    19fe:	e7b1                	bnez	a5,1a4a <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a00:	6198                	ld	a4,0(a1)
    1a02:	00000617          	auipc	a2,0x0
    1a06:	5be63603          	ld	a2,1470(a2) # 1fc0 <__clone+0xcc>
    1a0a:	00000817          	auipc	a6,0x0
    1a0e:	5be83803          	ld	a6,1470(a6) # 1fc8 <__clone+0xd4>
    1a12:	a029                	j	1a1c <strcpy+0x2a>
    1a14:	e118                	sd	a4,0(a0)
    1a16:	6598                	ld	a4,8(a1)
    1a18:	05a1                	addi	a1,a1,8
    1a1a:	0521                	addi	a0,a0,8
    1a1c:	00c707b3          	add	a5,a4,a2
    1a20:	fff74693          	not	a3,a4
    1a24:	8ff5                	and	a5,a5,a3
    1a26:	0107f7b3          	and	a5,a5,a6
    1a2a:	d7ed                	beqz	a5,1a14 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a2c:	0005c783          	lbu	a5,0(a1)
    1a30:	00f50023          	sb	a5,0(a0)
    1a34:	c785                	beqz	a5,1a5c <strcpy+0x6a>
    1a36:	0015c783          	lbu	a5,1(a1)
    1a3a:	0505                	addi	a0,a0,1
    1a3c:	0585                	addi	a1,a1,1
    1a3e:	00f50023          	sb	a5,0(a0)
    1a42:	fbf5                	bnez	a5,1a36 <strcpy+0x44>
        ;
    return d;
}
    1a44:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a46:	0505                	addi	a0,a0,1
    1a48:	df45                	beqz	a4,1a00 <strcpy+0xe>
            if (!(*d = *s))
    1a4a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a4e:	0585                	addi	a1,a1,1
    1a50:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a54:	00f50023          	sb	a5,0(a0)
    1a58:	f7fd                	bnez	a5,1a46 <strcpy+0x54>
}
    1a5a:	8082                	ret
    1a5c:	8082                	ret

0000000000001a5e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a5e:	00b547b3          	xor	a5,a0,a1
    1a62:	8b9d                	andi	a5,a5,7
    1a64:	1a079863          	bnez	a5,1c14 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a68:	0075f793          	andi	a5,a1,7
    1a6c:	16078463          	beqz	a5,1bd4 <strncpy+0x176>
    1a70:	ea01                	bnez	a2,1a80 <strncpy+0x22>
    1a72:	a421                	j	1c7a <strncpy+0x21c>
    1a74:	167d                	addi	a2,a2,-1
    1a76:	0505                	addi	a0,a0,1
    1a78:	14070e63          	beqz	a4,1bd4 <strncpy+0x176>
    1a7c:	1a060863          	beqz	a2,1c2c <strncpy+0x1ce>
    1a80:	0005c783          	lbu	a5,0(a1)
    1a84:	0585                	addi	a1,a1,1
    1a86:	0075f713          	andi	a4,a1,7
    1a8a:	00f50023          	sb	a5,0(a0)
    1a8e:	f3fd                	bnez	a5,1a74 <strncpy+0x16>
    1a90:	4805                	li	a6,1
    1a92:	1a061863          	bnez	a2,1c42 <strncpy+0x1e4>
    1a96:	40a007b3          	neg	a5,a0
    1a9a:	8b9d                	andi	a5,a5,7
    1a9c:	4681                	li	a3,0
    1a9e:	18061a63          	bnez	a2,1c32 <strncpy+0x1d4>
    1aa2:	00778713          	addi	a4,a5,7
    1aa6:	45ad                	li	a1,11
    1aa8:	18b76363          	bltu	a4,a1,1c2e <strncpy+0x1d0>
    1aac:	1ae6eb63          	bltu	a3,a4,1c62 <strncpy+0x204>
    1ab0:	1a078363          	beqz	a5,1c56 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ab4:	00050023          	sb	zero,0(a0)
    1ab8:	4685                	li	a3,1
    1aba:	00150713          	addi	a4,a0,1
    1abe:	18d78f63          	beq	a5,a3,1c5c <strncpy+0x1fe>
    1ac2:	000500a3          	sb	zero,1(a0)
    1ac6:	4689                	li	a3,2
    1ac8:	00250713          	addi	a4,a0,2
    1acc:	18d78e63          	beq	a5,a3,1c68 <strncpy+0x20a>
    1ad0:	00050123          	sb	zero,2(a0)
    1ad4:	468d                	li	a3,3
    1ad6:	00350713          	addi	a4,a0,3
    1ada:	16d78c63          	beq	a5,a3,1c52 <strncpy+0x1f4>
    1ade:	000501a3          	sb	zero,3(a0)
    1ae2:	4691                	li	a3,4
    1ae4:	00450713          	addi	a4,a0,4
    1ae8:	18d78263          	beq	a5,a3,1c6c <strncpy+0x20e>
    1aec:	00050223          	sb	zero,4(a0)
    1af0:	4695                	li	a3,5
    1af2:	00550713          	addi	a4,a0,5
    1af6:	16d78d63          	beq	a5,a3,1c70 <strncpy+0x212>
    1afa:	000502a3          	sb	zero,5(a0)
    1afe:	469d                	li	a3,7
    1b00:	00650713          	addi	a4,a0,6
    1b04:	16d79863          	bne	a5,a3,1c74 <strncpy+0x216>
    1b08:	00750713          	addi	a4,a0,7
    1b0c:	00050323          	sb	zero,6(a0)
    1b10:	40f80833          	sub	a6,a6,a5
    1b14:	ff887593          	andi	a1,a6,-8
    1b18:	97aa                	add	a5,a5,a0
    1b1a:	95be                	add	a1,a1,a5
    1b1c:	0007b023          	sd	zero,0(a5)
    1b20:	07a1                	addi	a5,a5,8
    1b22:	feb79de3          	bne	a5,a1,1b1c <strncpy+0xbe>
    1b26:	ff887593          	andi	a1,a6,-8
    1b2a:	9ead                	addw	a3,a3,a1
    1b2c:	00b707b3          	add	a5,a4,a1
    1b30:	12b80863          	beq	a6,a1,1c60 <strncpy+0x202>
    1b34:	00078023          	sb	zero,0(a5)
    1b38:	0016871b          	addiw	a4,a3,1
    1b3c:	0ec77863          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b40:	000780a3          	sb	zero,1(a5)
    1b44:	0026871b          	addiw	a4,a3,2
    1b48:	0ec77263          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b4c:	00078123          	sb	zero,2(a5)
    1b50:	0036871b          	addiw	a4,a3,3
    1b54:	0cc77c63          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b58:	000781a3          	sb	zero,3(a5)
    1b5c:	0046871b          	addiw	a4,a3,4
    1b60:	0cc77663          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b64:	00078223          	sb	zero,4(a5)
    1b68:	0056871b          	addiw	a4,a3,5
    1b6c:	0cc77063          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b70:	000782a3          	sb	zero,5(a5)
    1b74:	0066871b          	addiw	a4,a3,6
    1b78:	0ac77a63          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b7c:	00078323          	sb	zero,6(a5)
    1b80:	0076871b          	addiw	a4,a3,7
    1b84:	0ac77463          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b88:	000783a3          	sb	zero,7(a5)
    1b8c:	0086871b          	addiw	a4,a3,8
    1b90:	08c77e63          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1b94:	00078423          	sb	zero,8(a5)
    1b98:	0096871b          	addiw	a4,a3,9
    1b9c:	08c77863          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1ba0:	000784a3          	sb	zero,9(a5)
    1ba4:	00a6871b          	addiw	a4,a3,10
    1ba8:	08c77263          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1bac:	00078523          	sb	zero,10(a5)
    1bb0:	00b6871b          	addiw	a4,a3,11
    1bb4:	06c77c63          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1bb8:	000785a3          	sb	zero,11(a5)
    1bbc:	00c6871b          	addiw	a4,a3,12
    1bc0:	06c77663          	bgeu	a4,a2,1c2c <strncpy+0x1ce>
    1bc4:	00078623          	sb	zero,12(a5)
    1bc8:	26b5                	addiw	a3,a3,13
    1bca:	06c6f163          	bgeu	a3,a2,1c2c <strncpy+0x1ce>
    1bce:	000786a3          	sb	zero,13(a5)
    1bd2:	8082                	ret
            ;
        if (!n || !*s)
    1bd4:	c645                	beqz	a2,1c7c <strncpy+0x21e>
    1bd6:	0005c783          	lbu	a5,0(a1)
    1bda:	ea078be3          	beqz	a5,1a90 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bde:	479d                	li	a5,7
    1be0:	02c7ff63          	bgeu	a5,a2,1c1e <strncpy+0x1c0>
    1be4:	00000897          	auipc	a7,0x0
    1be8:	3dc8b883          	ld	a7,988(a7) # 1fc0 <__clone+0xcc>
    1bec:	00000817          	auipc	a6,0x0
    1bf0:	3dc83803          	ld	a6,988(a6) # 1fc8 <__clone+0xd4>
    1bf4:	431d                	li	t1,7
    1bf6:	6198                	ld	a4,0(a1)
    1bf8:	011707b3          	add	a5,a4,a7
    1bfc:	fff74693          	not	a3,a4
    1c00:	8ff5                	and	a5,a5,a3
    1c02:	0107f7b3          	and	a5,a5,a6
    1c06:	ef81                	bnez	a5,1c1e <strncpy+0x1c0>
            *wd = *ws;
    1c08:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c0a:	1661                	addi	a2,a2,-8
    1c0c:	05a1                	addi	a1,a1,8
    1c0e:	0521                	addi	a0,a0,8
    1c10:	fec363e3          	bltu	t1,a2,1bf6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c14:	e609                	bnez	a2,1c1e <strncpy+0x1c0>
    1c16:	a08d                	j	1c78 <strncpy+0x21a>
    1c18:	167d                	addi	a2,a2,-1
    1c1a:	0505                	addi	a0,a0,1
    1c1c:	ca01                	beqz	a2,1c2c <strncpy+0x1ce>
    1c1e:	0005c783          	lbu	a5,0(a1)
    1c22:	0585                	addi	a1,a1,1
    1c24:	00f50023          	sb	a5,0(a0)
    1c28:	fbe5                	bnez	a5,1c18 <strncpy+0x1ba>
        ;
tail:
    1c2a:	b59d                	j	1a90 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c2c:	8082                	ret
    1c2e:	472d                	li	a4,11
    1c30:	bdb5                	j	1aac <strncpy+0x4e>
    1c32:	00778713          	addi	a4,a5,7
    1c36:	45ad                	li	a1,11
    1c38:	fff60693          	addi	a3,a2,-1
    1c3c:	e6b778e3          	bgeu	a4,a1,1aac <strncpy+0x4e>
    1c40:	b7fd                	j	1c2e <strncpy+0x1d0>
    1c42:	40a007b3          	neg	a5,a0
    1c46:	8832                	mv	a6,a2
    1c48:	8b9d                	andi	a5,a5,7
    1c4a:	4681                	li	a3,0
    1c4c:	e4060be3          	beqz	a2,1aa2 <strncpy+0x44>
    1c50:	b7cd                	j	1c32 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c52:	468d                	li	a3,3
    1c54:	bd75                	j	1b10 <strncpy+0xb2>
    1c56:	872a                	mv	a4,a0
    1c58:	4681                	li	a3,0
    1c5a:	bd5d                	j	1b10 <strncpy+0xb2>
    1c5c:	4685                	li	a3,1
    1c5e:	bd4d                	j	1b10 <strncpy+0xb2>
    1c60:	8082                	ret
    1c62:	87aa                	mv	a5,a0
    1c64:	4681                	li	a3,0
    1c66:	b5f9                	j	1b34 <strncpy+0xd6>
    1c68:	4689                	li	a3,2
    1c6a:	b55d                	j	1b10 <strncpy+0xb2>
    1c6c:	4691                	li	a3,4
    1c6e:	b54d                	j	1b10 <strncpy+0xb2>
    1c70:	4695                	li	a3,5
    1c72:	bd79                	j	1b10 <strncpy+0xb2>
    1c74:	4699                	li	a3,6
    1c76:	bd69                	j	1b10 <strncpy+0xb2>
    1c78:	8082                	ret
    1c7a:	8082                	ret
    1c7c:	8082                	ret

0000000000001c7e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c7e:	87aa                	mv	a5,a0
    1c80:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c82:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c86:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c8a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c8c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c8e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c92:	2501                	sext.w	a0,a0
    1c94:	8082                	ret

0000000000001c96 <openat>:
    register long a7 __asm__("a7") = n;
    1c96:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c9a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c9e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <close>:
    register long a7 __asm__("a7") = n;
    1ca6:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1caa:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <read>:
    register long a7 __asm__("a7") = n;
    1cb2:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb6:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cba:	8082                	ret

0000000000001cbc <write>:
    register long a7 __asm__("a7") = n;
    1cbc:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cc0:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cc4:	8082                	ret

0000000000001cc6 <getpid>:
    register long a7 __asm__("a7") = n;
    1cc6:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cca:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cce:	2501                	sext.w	a0,a0
    1cd0:	8082                	ret

0000000000001cd2 <getppid>:
    register long a7 __asm__("a7") = n;
    1cd2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cd6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cde:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ce2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ce6:	2501                	sext.w	a0,a0
    1ce8:	8082                	ret

0000000000001cea <fork>:
    register long a7 __asm__("a7") = n;
    1cea:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cee:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cf0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cf6:	2501                	sext.w	a0,a0
    1cf8:	8082                	ret

0000000000001cfa <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cfa:	85b2                	mv	a1,a2
    1cfc:	863a                	mv	a2,a4
    if (stack)
    1cfe:	c191                	beqz	a1,1d02 <clone+0x8>
	stack += stack_size;
    1d00:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d02:	4781                	li	a5,0
    1d04:	4701                	li	a4,0
    1d06:	4681                	li	a3,0
    1d08:	2601                	sext.w	a2,a2
    1d0a:	a2ed                	j	1ef4 <__clone>

0000000000001d0c <exit>:
    register long a7 __asm__("a7") = n;
    1d0c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d10:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d14:	8082                	ret

0000000000001d16 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d16:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d1a:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d1c:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d20:	2501                	sext.w	a0,a0
    1d22:	8082                	ret

0000000000001d24 <exec>:
    register long a7 __asm__("a7") = n;
    1d24:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d28:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <execve>:
    register long a7 __asm__("a7") = n;
    1d30:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d34:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <times>:
    register long a7 __asm__("a7") = n;
    1d3c:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d40:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d44:	2501                	sext.w	a0,a0
    1d46:	8082                	ret

0000000000001d48 <get_time>:

int64 get_time()
{
    1d48:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d4a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d4e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d50:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d52:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d56:	2501                	sext.w	a0,a0
    1d58:	ed09                	bnez	a0,1d72 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d5a:	67a2                	ld	a5,8(sp)
    1d5c:	3e800713          	li	a4,1000
    1d60:	00015503          	lhu	a0,0(sp)
    1d64:	02e7d7b3          	divu	a5,a5,a4
    1d68:	02e50533          	mul	a0,a0,a4
    1d6c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d6e:	0141                	addi	sp,sp,16
    1d70:	8082                	ret
        return -1;
    1d72:	557d                	li	a0,-1
    1d74:	bfed                	j	1d6e <get_time+0x26>

0000000000001d76 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d76:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d7e:	2501                	sext.w	a0,a0
    1d80:	8082                	ret

0000000000001d82 <time>:
    register long a7 __asm__("a7") = n;
    1d82:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d86:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d8a:	2501                	sext.w	a0,a0
    1d8c:	8082                	ret

0000000000001d8e <sleep>:

int sleep(unsigned long long time)
{
    1d8e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d90:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d92:	850a                	mv	a0,sp
    1d94:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d96:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d9a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d9c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1da0:	e501                	bnez	a0,1da8 <sleep+0x1a>
    return 0;
    1da2:	4501                	li	a0,0
}
    1da4:	0141                	addi	sp,sp,16
    1da6:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1da8:	4502                	lw	a0,0(sp)
}
    1daa:	0141                	addi	sp,sp,16
    1dac:	8082                	ret

0000000000001dae <set_priority>:
    register long a7 __asm__("a7") = n;
    1dae:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1db2:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1db6:	2501                	sext.w	a0,a0
    1db8:	8082                	ret

0000000000001dba <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dba:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dbe:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dc2:	8082                	ret

0000000000001dc4 <munmap>:
    register long a7 __asm__("a7") = n;
    1dc4:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc8:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <wait>:

int wait(int *code)
{
    1dd0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dd2:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dd6:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dd8:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dda:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ddc:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <spawn>:
    register long a7 __asm__("a7") = n;
    1de4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1de8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <mailread>:
    register long a7 __asm__("a7") = n;
    1df0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dfc:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e00:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e04:	2501                	sext.w	a0,a0
    1e06:	8082                	ret

0000000000001e08 <fstat>:
    register long a7 __asm__("a7") = n;
    1e08:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e0c:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e10:	2501                	sext.w	a0,a0
    1e12:	8082                	ret

0000000000001e14 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e14:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e16:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e1a:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e1c:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e20:	2501                	sext.w	a0,a0
    1e22:	8082                	ret

0000000000001e24 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e24:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e26:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e2a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e2c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e30:	2501                	sext.w	a0,a0
    1e32:	8082                	ret

0000000000001e34 <link>:

int link(char *old_path, char *new_path)
{
    1e34:	87aa                	mv	a5,a0
    1e36:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e38:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e3c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e40:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e42:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e46:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e48:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e4c:	2501                	sext.w	a0,a0
    1e4e:	8082                	ret

0000000000001e50 <unlink>:

int unlink(char *path)
{
    1e50:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e52:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e56:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e5a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e5c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <uname>:
    register long a7 __asm__("a7") = n;
    1e64:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e68:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e6c:	2501                	sext.w	a0,a0
    1e6e:	8082                	ret

0000000000001e70 <brk>:
    register long a7 __asm__("a7") = n;
    1e70:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e74:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e78:	2501                	sext.w	a0,a0
    1e7a:	8082                	ret

0000000000001e7c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e7c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e7e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e82:	8082                	ret

0000000000001e84 <chdir>:
    register long a7 __asm__("a7") = n;
    1e84:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e88:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e90:	862e                	mv	a2,a1
    1e92:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e94:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e96:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e9a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e9e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ea0:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea2:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <getdents>:
    register long a7 __asm__("a7") = n;
    1eaa:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eae:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <pipe>:
    register long a7 __asm__("a7") = n;
    1eb6:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1eba:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ebc:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <dup>:
    register long a7 __asm__("a7") = n;
    1ec4:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ec6:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eca:	2501                	sext.w	a0,a0
    1ecc:	8082                	ret

0000000000001ece <dup2>:
    register long a7 __asm__("a7") = n;
    1ece:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ed0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ed2:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ed6:	2501                	sext.w	a0,a0
    1ed8:	8082                	ret

0000000000001eda <mount>:
    register long a7 __asm__("a7") = n;
    1eda:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ede:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ee2:	2501                	sext.w	a0,a0
    1ee4:	8082                	ret

0000000000001ee6 <umount>:
    register long a7 __asm__("a7") = n;
    1ee6:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eea:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eec:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ef0:	2501                	sext.w	a0,a0
    1ef2:	8082                	ret

0000000000001ef4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ef4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ef6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ef8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1efa:	8532                	mv	a0,a2
	mv a2, a4
    1efc:	863a                	mv	a2,a4
	mv a3, a5
    1efe:	86be                	mv	a3,a5
	mv a4, a6
    1f00:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f02:	0dc00893          	li	a7,220
	ecall
    1f06:	00000073          	ecall

	beqz a0, 1f
    1f0a:	c111                	beqz	a0,1f0e <__clone+0x1a>
	# Parent
	ret
    1f0c:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f0e:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f10:	6522                	ld	a0,8(sp)
	jalr a1
    1f12:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f14:	05d00893          	li	a7,93
	ecall
    1f18:	00000073          	ecall
