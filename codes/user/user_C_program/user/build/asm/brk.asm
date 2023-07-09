
/home/yan_ice/Desktop/Teecert/TeernOS/codes/user/user_C_program/user/build/riscv64/brk:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a855                	j	10b6 <__start_main>

0000000000001004 <test_brk>:
 * "After alloc,heap pos: [num+64]"
 * "Alloc again,heap pos: [num+128]"
 * 
 * Linux 中brk(0)只返回0，此处与Linux表现不同，应特殊说明。
 */
void test_brk(){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eda50513          	addi	a0,a0,-294 # 1ee0 <__clone+0x28>
void test_brk(){
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e426                	sd	s1,8(sp)
    TEST_START(__func__);
    1014:	2da000ef          	jal	ra,12ee <puts>
    1018:	00001497          	auipc	s1,0x1
    101c:	f8048493          	addi	s1,s1,-128 # 1f98 <__func__.1191>
    1020:	8526                	mv	a0,s1
    1022:	2cc000ef          	jal	ra,12ee <puts>
    1026:	00001517          	auipc	a0,0x1
    102a:	ed250513          	addi	a0,a0,-302 # 1ef8 <__clone+0x40>
    102e:	2c0000ef          	jal	ra,12ee <puts>
    intptr_t cur_pos, alloc_pos, alloc_pos_1;

    cur_pos = brk(0);
    1032:	4501                	li	a0,0
    1034:	601000ef          	jal	ra,1e34 <brk>
    printf("Before alloc,heap pos: %d\n", cur_pos);
    1038:	85aa                	mv	a1,a0
    cur_pos = brk(0);
    103a:	842a                	mv	s0,a0
    printf("Before alloc,heap pos: %d\n", cur_pos);
    103c:	00001517          	auipc	a0,0x1
    1040:	ecc50513          	addi	a0,a0,-308 # 1f08 <__clone+0x50>
    1044:	2cc000ef          	jal	ra,1310 <printf>
    brk(cur_pos + 64);
    1048:	04040513          	addi	a0,s0,64
    104c:	5e9000ef          	jal	ra,1e34 <brk>
    alloc_pos = brk(0);
    1050:	4501                	li	a0,0
    1052:	5e3000ef          	jal	ra,1e34 <brk>
    printf("After alloc,heap pos: %d\n",alloc_pos);
    1056:	85aa                	mv	a1,a0
    alloc_pos = brk(0);
    1058:	842a                	mv	s0,a0
    printf("After alloc,heap pos: %d\n",alloc_pos);
    105a:	00001517          	auipc	a0,0x1
    105e:	ece50513          	addi	a0,a0,-306 # 1f28 <__clone+0x70>
    1062:	2ae000ef          	jal	ra,1310 <printf>
    brk(alloc_pos + 64);
    1066:	04040513          	addi	a0,s0,64
    106a:	5cb000ef          	jal	ra,1e34 <brk>
    alloc_pos_1 = brk(0);
    106e:	4501                	li	a0,0
    1070:	5c5000ef          	jal	ra,1e34 <brk>
    1074:	85aa                	mv	a1,a0
    printf("Alloc again,heap pos: %d\n",alloc_pos_1);
    1076:	00001517          	auipc	a0,0x1
    107a:	ed250513          	addi	a0,a0,-302 # 1f48 <__clone+0x90>
    107e:	292000ef          	jal	ra,1310 <printf>
    TEST_END(__func__);
    1082:	00001517          	auipc	a0,0x1
    1086:	ee650513          	addi	a0,a0,-282 # 1f68 <__clone+0xb0>
    108a:	264000ef          	jal	ra,12ee <puts>
    108e:	8526                	mv	a0,s1
    1090:	25e000ef          	jal	ra,12ee <puts>
}
    1094:	6442                	ld	s0,16(sp)
    1096:	60e2                	ld	ra,24(sp)
    1098:	64a2                	ld	s1,8(sp)
    TEST_END(__func__);
    109a:	00001517          	auipc	a0,0x1
    109e:	e5e50513          	addi	a0,a0,-418 # 1ef8 <__clone+0x40>
}
    10a2:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    10a4:	a4a9                	j	12ee <puts>

00000000000010a6 <main>:

int main(void) {
    10a6:	1141                	addi	sp,sp,-16
    10a8:	e406                	sd	ra,8(sp)
    test_brk();
    10aa:	f5bff0ef          	jal	ra,1004 <test_brk>
    return 0;
}
    10ae:	60a2                	ld	ra,8(sp)
    10b0:	4501                	li	a0,0
    10b2:	0141                	addi	sp,sp,16
    10b4:	8082                	ret

00000000000010b6 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10b6:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10b8:	4108                	lw	a0,0(a0)
{
    10ba:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10bc:	05a1                	addi	a1,a1,8
{
    10be:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10c0:	fe7ff0ef          	jal	ra,10a6 <main>
    10c4:	40d000ef          	jal	ra,1cd0 <exit>
	return 0;
}
    10c8:	60a2                	ld	ra,8(sp)
    10ca:	4501                	li	a0,0
    10cc:	0141                	addi	sp,sp,16
    10ce:	8082                	ret

00000000000010d0 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10d0:	7179                	addi	sp,sp,-48
    10d2:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10d4:	12054b63          	bltz	a0,120a <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10d8:	02b577bb          	remuw	a5,a0,a1
    10dc:	00001697          	auipc	a3,0x1
    10e0:	ecc68693          	addi	a3,a3,-308 # 1fa8 <digits>
    buf[16] = 0;
    10e4:	00010c23          	sb	zero,24(sp)
    i = 15;
    10e8:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    10ec:	1782                	slli	a5,a5,0x20
    10ee:	9381                	srli	a5,a5,0x20
    10f0:	97b6                	add	a5,a5,a3
    10f2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10f6:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10fa:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10fe:	16b56263          	bltu	a0,a1,1262 <printint.constprop.0+0x192>
        buf[i--] = digits[x % base];
    1102:	02e8763b          	remuw	a2,a6,a4
    1106:	1602                	slli	a2,a2,0x20
    1108:	9201                	srli	a2,a2,0x20
    110a:	9636                	add	a2,a2,a3
    110c:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1110:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1114:	00c10b23          	sb	a2,22(sp)
    } while ((x /= base) != 0);
    1118:	12e86963          	bltu	a6,a4,124a <printint.constprop.0+0x17a>
        buf[i--] = digits[x % base];
    111c:	02e5f63b          	remuw	a2,a1,a4
    1120:	1602                	slli	a2,a2,0x20
    1122:	9201                	srli	a2,a2,0x20
    1124:	9636                	add	a2,a2,a3
    1126:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    112a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    112e:	00c10aa3          	sb	a2,21(sp)
    } while ((x /= base) != 0);
    1132:	10e5ef63          	bltu	a1,a4,1250 <printint.constprop.0+0x180>
        buf[i--] = digits[x % base];
    1136:	02e8763b          	remuw	a2,a6,a4
    113a:	1602                	slli	a2,a2,0x20
    113c:	9201                	srli	a2,a2,0x20
    113e:	9636                	add	a2,a2,a3
    1140:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1144:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1148:	00c10a23          	sb	a2,20(sp)
    } while ((x /= base) != 0);
    114c:	10e86563          	bltu	a6,a4,1256 <printint.constprop.0+0x186>
        buf[i--] = digits[x % base];
    1150:	02e5f63b          	remuw	a2,a1,a4
    1154:	1602                	slli	a2,a2,0x20
    1156:	9201                	srli	a2,a2,0x20
    1158:	9636                	add	a2,a2,a3
    115a:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    115e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1162:	00c109a3          	sb	a2,19(sp)
    } while ((x /= base) != 0);
    1166:	0ee5eb63          	bltu	a1,a4,125c <printint.constprop.0+0x18c>
        buf[i--] = digits[x % base];
    116a:	02e8763b          	remuw	a2,a6,a4
    116e:	1602                	slli	a2,a2,0x20
    1170:	9201                	srli	a2,a2,0x20
    1172:	9636                	add	a2,a2,a3
    1174:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1178:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    117c:	00c10923          	sb	a2,18(sp)
    } while ((x /= base) != 0);
    1180:	0ce86263          	bltu	a6,a4,1244 <printint.constprop.0+0x174>
        buf[i--] = digits[x % base];
    1184:	02e5f63b          	remuw	a2,a1,a4
    1188:	1602                	slli	a2,a2,0x20
    118a:	9201                	srli	a2,a2,0x20
    118c:	9636                	add	a2,a2,a3
    118e:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    1192:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1196:	00c108a3          	sb	a2,17(sp)
    } while ((x /= base) != 0);
    119a:	0ce5e663          	bltu	a1,a4,1266 <printint.constprop.0+0x196>
        buf[i--] = digits[x % base];
    119e:	02e8763b          	remuw	a2,a6,a4
    11a2:	1602                	slli	a2,a2,0x20
    11a4:	9201                	srli	a2,a2,0x20
    11a6:	9636                	add	a2,a2,a3
    11a8:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11ac:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b0:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    11b4:	0ae86c63          	bltu	a6,a4,126c <printint.constprop.0+0x19c>
        buf[i--] = digits[x % base];
    11b8:	02e5f63b          	remuw	a2,a1,a4
    11bc:	1602                	slli	a2,a2,0x20
    11be:	9201                	srli	a2,a2,0x20
    11c0:	9636                	add	a2,a2,a3
    11c2:	00064603          	lbu	a2,0(a2)
    } while ((x /= base) != 0);
    11c6:	02e5d7bb          	divuw	a5,a1,a4
        buf[i--] = digits[x % base];
    11ca:	00c107a3          	sb	a2,15(sp)
    } while ((x /= base) != 0);
    11ce:	0ae5e263          	bltu	a1,a4,1272 <printint.constprop.0+0x1a2>
        buf[i--] = digits[x % base];
    11d2:	1782                	slli	a5,a5,0x20
    11d4:	9381                	srli	a5,a5,0x20
    11d6:	97b6                	add	a5,a5,a3
    11d8:	0007c703          	lbu	a4,0(a5)
    11dc:	4599                	li	a1,6
    11de:	4795                	li	a5,5
    11e0:	00e10723          	sb	a4,14(sp)

    if (sign)
    11e4:	00055963          	bgez	a0,11f6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11e8:	1018                	addi	a4,sp,32
    11ea:	973e                	add	a4,a4,a5
    11ec:	02d00693          	li	a3,45
    11f0:	fed70423          	sb	a3,-24(a4)
    i++;
    if (i < 0)
    11f4:	85be                	mv	a1,a5
    write(f, s, l);
    11f6:	003c                	addi	a5,sp,8
    11f8:	4641                	li	a2,16
    11fa:	9e0d                	subw	a2,a2,a1
    11fc:	4505                	li	a0,1
    11fe:	95be                	add	a1,a1,a5
    1200:	281000ef          	jal	ra,1c80 <write>
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1204:	70a2                	ld	ra,40(sp)
    1206:	6145                	addi	sp,sp,48
    1208:	8082                	ret
        x = -xx;
    120a:	40a0063b          	negw	a2,a0
        buf[i--] = digits[x % base];
    120e:	02b677bb          	remuw	a5,a2,a1
    1212:	00001697          	auipc	a3,0x1
    1216:	d9668693          	addi	a3,a3,-618 # 1fa8 <digits>
    buf[16] = 0;
    121a:	00010c23          	sb	zero,24(sp)
    i = 15;
    121e:	0005871b          	sext.w	a4,a1
        buf[i--] = digits[x % base];
    1222:	1782                	slli	a5,a5,0x20
    1224:	9381                	srli	a5,a5,0x20
    1226:	97b6                	add	a5,a5,a3
    1228:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    122c:	02b6583b          	divuw	a6,a2,a1
        buf[i--] = digits[x % base];
    1230:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1234:	ecb677e3          	bgeu	a2,a1,1102 <printint.constprop.0+0x32>
        buf[i--] = '-';
    1238:	02d00793          	li	a5,45
    123c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1240:	45b9                	li	a1,14
    1242:	bf55                	j	11f6 <printint.constprop.0+0x126>
    1244:	47a5                	li	a5,9
    1246:	45a9                	li	a1,10
    1248:	bf71                	j	11e4 <printint.constprop.0+0x114>
    124a:	47b5                	li	a5,13
    124c:	45b9                	li	a1,14
    124e:	bf59                	j	11e4 <printint.constprop.0+0x114>
    1250:	47b1                	li	a5,12
    1252:	45b5                	li	a1,13
    1254:	bf41                	j	11e4 <printint.constprop.0+0x114>
    1256:	47ad                	li	a5,11
    1258:	45b1                	li	a1,12
    125a:	b769                	j	11e4 <printint.constprop.0+0x114>
    125c:	47a9                	li	a5,10
    125e:	45ad                	li	a1,11
    1260:	b751                	j	11e4 <printint.constprop.0+0x114>
    i = 15;
    1262:	45bd                	li	a1,15
    1264:	bf49                	j	11f6 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1266:	47a1                	li	a5,8
    1268:	45a5                	li	a1,9
    126a:	bfad                	j	11e4 <printint.constprop.0+0x114>
    126c:	479d                	li	a5,7
    126e:	45a1                	li	a1,8
    1270:	bf95                	j	11e4 <printint.constprop.0+0x114>
    1272:	4799                	li	a5,6
    1274:	459d                	li	a1,7
    1276:	b7bd                	j	11e4 <printint.constprop.0+0x114>

0000000000001278 <getchar>:
{
    1278:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    127a:	00f10593          	addi	a1,sp,15
    127e:	4605                	li	a2,1
    1280:	4501                	li	a0,0
{
    1282:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1284:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1288:	1ef000ef          	jal	ra,1c76 <read>
}
    128c:	60e2                	ld	ra,24(sp)
    128e:	00f14503          	lbu	a0,15(sp)
    1292:	6105                	addi	sp,sp,32
    1294:	8082                	ret

0000000000001296 <printt>:
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    1296:	00001797          	auipc	a5,0x1
    129a:	d2a78793          	addi	a5,a5,-726 # 1fc0 <digits+0x18>
    129e:	04000893          	li	a7,64
    12a2:	4505                	li	a0,1
    12a4:	85be                	mv	a1,a5
    12a6:	4611                	li	a2,4
    12a8:	00000073          	ecall
}
    12ac:	4501                	li	a0,0
    12ae:	8082                	ret

00000000000012b0 <putchar>:
{
    12b0:	1101                	addi	sp,sp,-32
    12b2:	ec06                	sd	ra,24(sp)
    12b4:	87aa                	mv	a5,a0
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    12b6:	3e700893          	li	a7,999
    12ba:	4505                	li	a0,1
    12bc:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    12c0:	00001717          	auipc	a4,0x1
    12c4:	d0070713          	addi	a4,a4,-768 # 1fc0 <digits+0x18>
    12c8:	04000893          	li	a7,64
    12cc:	4505                	li	a0,1
    12ce:	85ba                	mv	a1,a4
    12d0:	4611                	li	a2,4
    12d2:	00000073          	ecall
    return write(stdout, &byte, 1);
    12d6:	4605                	li	a2,1
    12d8:	00f10593          	addi	a1,sp,15
    12dc:	4505                	li	a0,1
    char byte = c;
    12de:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12e2:	19f000ef          	jal	ra,1c80 <write>
}
    12e6:	60e2                	ld	ra,24(sp)
    12e8:	2501                	sext.w	a0,a0
    12ea:	6105                	addi	sp,sp,32
    12ec:	8082                	ret

00000000000012ee <puts>:
{
    12ee:	1141                	addi	sp,sp,-16
    12f0:	e406                	sd	ra,8(sp)
    12f2:	e022                	sd	s0,0(sp)
    12f4:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12f6:	5a6000ef          	jal	ra,189c <strlen>
    12fa:	862a                	mv	a2,a0
    12fc:	85a2                	mv	a1,s0
    12fe:	4505                	li	a0,1
    1300:	181000ef          	jal	ra,1c80 <write>
}
    1304:	60a2                	ld	ra,8(sp)
    1306:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1308:	957d                	srai	a0,a0,0x3f
    return r;
    130a:	2501                	sext.w	a0,a0
}
    130c:	0141                	addi	sp,sp,16
    130e:	8082                	ret

0000000000001310 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1310:	7171                	addi	sp,sp,-176
    1312:	e0d2                	sd	s4,64(sp)
    1314:	ed3e                	sd	a5,152(sp)
    buf[i++] = '0';
    1316:	7a61                	lui	s4,0xffff8
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1318:	18bc                	addi	a5,sp,120
{
    131a:	e8ca                	sd	s2,80(sp)
    131c:	e4ce                	sd	s3,72(sp)
    131e:	fc56                	sd	s5,56(sp)
    1320:	f85a                	sd	s6,48(sp)
    1322:	f486                	sd	ra,104(sp)
    1324:	f0a2                	sd	s0,96(sp)
    1326:	eca6                	sd	s1,88(sp)
    1328:	fcae                	sd	a1,120(sp)
    132a:	e132                	sd	a2,128(sp)
    132c:	e536                	sd	a3,136(sp)
    132e:	e93a                	sd	a4,144(sp)
    1330:	f142                	sd	a6,160(sp)
    1332:	f546                	sd	a7,168(sp)
    va_start(ap, fmt);
    1334:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1336:	02500913          	li	s2,37
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    133a:	00001b17          	auipc	s6,0x1
    133e:	c3eb0b13          	addi	s6,s6,-962 # 1f78 <__clone+0xc0>
	::"r"((unsigned long long)ac)
    1342:	00001a97          	auipc	s5,0x1
    1346:	c7ea8a93          	addi	s5,s5,-898 # 1fc0 <digits+0x18>
    buf[i++] = '0';
    134a:	830a4a13          	xori	s4,s4,-2000
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    134e:	00001997          	auipc	s3,0x1
    1352:	c5a98993          	addi	s3,s3,-934 # 1fa8 <digits>
        if (!*s)
    1356:	00054783          	lbu	a5,0(a0)
    135a:	16078c63          	beqz	a5,14d2 <printf+0x1c2>
    135e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1360:	19278363          	beq	a5,s2,14e6 <printf+0x1d6>
    1364:	00164783          	lbu	a5,1(a2)
    1368:	0605                	addi	a2,a2,1
    136a:	fbfd                	bnez	a5,1360 <printf+0x50>
    136c:	84b2                	mv	s1,a2
        l = z - a;
    136e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1372:	85aa                	mv	a1,a0
    1374:	8622                	mv	a2,s0
    1376:	4505                	li	a0,1
    1378:	109000ef          	jal	ra,1c80 <write>
        if (l)
    137c:	18041e63          	bnez	s0,1518 <printf+0x208>
        if (s[1] == 0)
    1380:	0014c783          	lbu	a5,1(s1)
    1384:	14078763          	beqz	a5,14d2 <printf+0x1c2>
        switch (s[1])
    1388:	07300713          	li	a4,115
    138c:	1ce78063          	beq	a5,a4,154c <printf+0x23c>
    1390:	18f76663          	bltu	a4,a5,151c <printf+0x20c>
    1394:	06400713          	li	a4,100
    1398:	1ae78063          	beq	a5,a4,1538 <printf+0x228>
    139c:	07000713          	li	a4,112
    13a0:	1ce79963          	bne	a5,a4,1572 <printf+0x262>
            printptr(va_arg(ap, uint64));
    13a4:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13a6:	01411423          	sh	s4,8(sp)
    write(f, s, l);
    13aa:	4649                	li	a2,18
            printptr(va_arg(ap, uint64));
    13ac:	631c                	ld	a5,0(a4)
    13ae:	0721                	addi	a4,a4,8
    13b0:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13b2:	00479293          	slli	t0,a5,0x4
    13b6:	00879f93          	slli	t6,a5,0x8
    13ba:	00c79f13          	slli	t5,a5,0xc
    13be:	01079e93          	slli	t4,a5,0x10
    13c2:	01479e13          	slli	t3,a5,0x14
    13c6:	01879313          	slli	t1,a5,0x18
    13ca:	01c79893          	slli	a7,a5,0x1c
    13ce:	02479813          	slli	a6,a5,0x24
    13d2:	02879513          	slli	a0,a5,0x28
    13d6:	02c79593          	slli	a1,a5,0x2c
    13da:	03079693          	slli	a3,a5,0x30
    13de:	03479713          	slli	a4,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13e2:	03c7d413          	srli	s0,a5,0x3c
    13e6:	01c7d39b          	srliw	t2,a5,0x1c
    13ea:	03c2d293          	srli	t0,t0,0x3c
    13ee:	03cfdf93          	srli	t6,t6,0x3c
    13f2:	03cf5f13          	srli	t5,t5,0x3c
    13f6:	03cede93          	srli	t4,t4,0x3c
    13fa:	03ce5e13          	srli	t3,t3,0x3c
    13fe:	03c35313          	srli	t1,t1,0x3c
    1402:	03c8d893          	srli	a7,a7,0x3c
    1406:	03c85813          	srli	a6,a6,0x3c
    140a:	9171                	srli	a0,a0,0x3c
    140c:	91f1                	srli	a1,a1,0x3c
    140e:	92f1                	srli	a3,a3,0x3c
    1410:	9371                	srli	a4,a4,0x3c
    1412:	96ce                	add	a3,a3,s3
    1414:	974e                	add	a4,a4,s3
    1416:	944e                	add	s0,s0,s3
    1418:	92ce                	add	t0,t0,s3
    141a:	9fce                	add	t6,t6,s3
    141c:	9f4e                	add	t5,t5,s3
    141e:	9ece                	add	t4,t4,s3
    1420:	9e4e                	add	t3,t3,s3
    1422:	934e                	add	t1,t1,s3
    1424:	98ce                	add	a7,a7,s3
    1426:	93ce                	add	t2,t2,s3
    1428:	984e                	add	a6,a6,s3
    142a:	954e                	add	a0,a0,s3
    142c:	95ce                	add	a1,a1,s3
    142e:	0006c083          	lbu	ra,0(a3)
    1432:	0002c283          	lbu	t0,0(t0)
    1436:	00074683          	lbu	a3,0(a4)
    143a:	000fcf83          	lbu	t6,0(t6)
    143e:	000f4f03          	lbu	t5,0(t5)
    1442:	000ece83          	lbu	t4,0(t4)
    1446:	000e4e03          	lbu	t3,0(t3)
    144a:	00034303          	lbu	t1,0(t1)
    144e:	0008c883          	lbu	a7,0(a7)
    1452:	0003c383          	lbu	t2,0(t2)
    1456:	00084803          	lbu	a6,0(a6)
    145a:	00054503          	lbu	a0,0(a0)
    145e:	0005c583          	lbu	a1,0(a1)
    1462:	00044403          	lbu	s0,0(s0)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1466:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    146a:	9371                	srli	a4,a4,0x3c
    146c:	8bbd                	andi	a5,a5,15
    146e:	974e                	add	a4,a4,s3
    1470:	97ce                	add	a5,a5,s3
    1472:	005105a3          	sb	t0,11(sp)
    1476:	01f10623          	sb	t6,12(sp)
    147a:	01e106a3          	sb	t5,13(sp)
    147e:	01d10723          	sb	t4,14(sp)
    1482:	01c107a3          	sb	t3,15(sp)
    1486:	00610823          	sb	t1,16(sp)
    148a:	011108a3          	sb	a7,17(sp)
    148e:	00710923          	sb	t2,18(sp)
    1492:	010109a3          	sb	a6,19(sp)
    1496:	00a10a23          	sb	a0,20(sp)
    149a:	00b10aa3          	sb	a1,21(sp)
    149e:	00110b23          	sb	ra,22(sp)
    14a2:	00d10ba3          	sb	a3,23(sp)
    14a6:	00810523          	sb	s0,10(sp)
    14aa:	00074703          	lbu	a4,0(a4)
    14ae:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14b2:	002c                	addi	a1,sp,8
    14b4:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b6:	00e10c23          	sb	a4,24(sp)
    14ba:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14be:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14c2:	7be000ef          	jal	ra,1c80 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14c6:	00248513          	addi	a0,s1,2
        if (!*s)
    14ca:	00054783          	lbu	a5,0(a0)
    14ce:	e80798e3          	bnez	a5,135e <printf+0x4e>
    }
    va_end(ap);
}
    14d2:	70a6                	ld	ra,104(sp)
    14d4:	7406                	ld	s0,96(sp)
    14d6:	64e6                	ld	s1,88(sp)
    14d8:	6946                	ld	s2,80(sp)
    14da:	69a6                	ld	s3,72(sp)
    14dc:	6a06                	ld	s4,64(sp)
    14de:	7ae2                	ld	s5,56(sp)
    14e0:	7b42                	ld	s6,48(sp)
    14e2:	614d                	addi	sp,sp,176
    14e4:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14e6:	00064783          	lbu	a5,0(a2)
    14ea:	84b2                	mv	s1,a2
    14ec:	01278963          	beq	a5,s2,14fe <printf+0x1ee>
    14f0:	bdbd                	j	136e <printf+0x5e>
    14f2:	0024c783          	lbu	a5,2(s1)
    14f6:	0605                	addi	a2,a2,1
    14f8:	0489                	addi	s1,s1,2
    14fa:	e7279ae3          	bne	a5,s2,136e <printf+0x5e>
    14fe:	0014c783          	lbu	a5,1(s1)
    1502:	ff2788e3          	beq	a5,s2,14f2 <printf+0x1e2>
        l = z - a;
    1506:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    150a:	85aa                	mv	a1,a0
    150c:	8622                	mv	a2,s0
    150e:	4505                	li	a0,1
    1510:	770000ef          	jal	ra,1c80 <write>
        if (l)
    1514:	e60406e3          	beqz	s0,1380 <printf+0x70>
    1518:	8526                	mv	a0,s1
    151a:	bd35                	j	1356 <printf+0x46>
        switch (s[1])
    151c:	07800713          	li	a4,120
    1520:	04e79963          	bne	a5,a4,1572 <printf+0x262>
            printint(va_arg(ap, int), 16, 1);
    1524:	6782                	ld	a5,0(sp)
    1526:	45c1                	li	a1,16
    1528:	4388                	lw	a0,0(a5)
    152a:	07a1                	addi	a5,a5,8
    152c:	e03e                	sd	a5,0(sp)
    152e:	ba3ff0ef          	jal	ra,10d0 <printint.constprop.0>
        s += 2;
    1532:	00248513          	addi	a0,s1,2
    1536:	bf51                	j	14ca <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1538:	6782                	ld	a5,0(sp)
    153a:	45a9                	li	a1,10
    153c:	4388                	lw	a0,0(a5)
    153e:	07a1                	addi	a5,a5,8
    1540:	e03e                	sd	a5,0(sp)
    1542:	b8fff0ef          	jal	ra,10d0 <printint.constprop.0>
        s += 2;
    1546:	00248513          	addi	a0,s1,2
    154a:	b741                	j	14ca <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    154c:	6782                	ld	a5,0(sp)
    154e:	6380                	ld	s0,0(a5)
    1550:	07a1                	addi	a5,a5,8
    1552:	e03e                	sd	a5,0(sp)
    1554:	cc25                	beqz	s0,15cc <printf+0x2bc>
            l = strnlen(a, 200);
    1556:	0c800593          	li	a1,200
    155a:	8522                	mv	a0,s0
    155c:	42c000ef          	jal	ra,1988 <strnlen>
    write(f, s, l);
    1560:	0005061b          	sext.w	a2,a0
    1564:	85a2                	mv	a1,s0
    1566:	4505                	li	a0,1
    1568:	718000ef          	jal	ra,1c80 <write>
        s += 2;
    156c:	00248513          	addi	a0,s1,2
    1570:	bfa9                	j	14ca <printf+0x1ba>
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    1572:	3e700893          	li	a7,999
    1576:	4505                	li	a0,1
    1578:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    157c:	04000893          	li	a7,64
    1580:	4505                	li	a0,1
    1582:	85d6                	mv	a1,s5
    1584:	4611                	li	a2,4
    1586:	00000073          	ecall
    char byte = c;
    158a:	02500793          	li	a5,37
    return write(stdout, &byte, 1);
    158e:	4605                	li	a2,1
    1590:	002c                	addi	a1,sp,8
    1592:	4505                	li	a0,1
    char byte = c;
    1594:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1598:	6e8000ef          	jal	ra,1c80 <write>
            putchar(s[1]);
    159c:	0014c783          	lbu	a5,1(s1)
__asm__("li a7, 999 \n\t li a0, 1\n\t ecall");
    15a0:	3e700893          	li	a7,999
    15a4:	4505                	li	a0,1
    15a6:	00000073          	ecall
	__asm__("li a7, 64 \n\t li a0, 1 \n\t mv a1,%0 \n\t li a2,4 \n\t   ecall"
    15aa:	04000893          	li	a7,64
    15ae:	4505                	li	a0,1
    15b0:	85d6                	mv	a1,s5
    15b2:	4611                	li	a2,4
    15b4:	00000073          	ecall
    return write(stdout, &byte, 1);
    15b8:	4605                	li	a2,1
    15ba:	002c                	addi	a1,sp,8
    15bc:	4505                	li	a0,1
    char byte = c;
    15be:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15c2:	6be000ef          	jal	ra,1c80 <write>
        s += 2;
    15c6:	00248513          	addi	a0,s1,2
    15ca:	b701                	j	14ca <printf+0x1ba>
                a = "(null)";
    15cc:	845a                	mv	s0,s6
    15ce:	b761                	j	1556 <printf+0x246>

00000000000015d0 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d0:	02000793          	li	a5,32
    15d4:	00f50663          	beq	a0,a5,15e0 <isspace+0x10>
    15d8:	355d                	addiw	a0,a0,-9
    15da:	00553513          	sltiu	a0,a0,5
    15de:	8082                	ret
    15e0:	4505                	li	a0,1
}
    15e2:	8082                	ret

00000000000015e4 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15e4:	fd05051b          	addiw	a0,a0,-48
}
    15e8:	00a53513          	sltiu	a0,a0,10
    15ec:	8082                	ret

00000000000015ee <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ee:	02000613          	li	a2,32
    15f2:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15f4:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f8:	ff77069b          	addiw	a3,a4,-9
    15fc:	04c70d63          	beq	a4,a2,1656 <atoi+0x68>
    1600:	0007079b          	sext.w	a5,a4
    1604:	04d5f963          	bgeu	a1,a3,1656 <atoi+0x68>
        s++;
    switch (*s)
    1608:	02b00693          	li	a3,43
    160c:	04d70a63          	beq	a4,a3,1660 <atoi+0x72>
    1610:	02d00693          	li	a3,45
    1614:	06d70463          	beq	a4,a3,167c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1618:	fd07859b          	addiw	a1,a5,-48
    161c:	4625                	li	a2,9
    161e:	873e                	mv	a4,a5
    1620:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1622:	4e01                	li	t3,0
    while (isdigit(*s))
    1624:	04b66a63          	bltu	a2,a1,1678 <atoi+0x8a>
    int n = 0, neg = 0;
    1628:	4501                	li	a0,0
    while (isdigit(*s))
    162a:	4825                	li	a6,9
    162c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1630:	0025179b          	slliw	a5,a0,0x2
    1634:	9d3d                	addw	a0,a0,a5
    1636:	fd07031b          	addiw	t1,a4,-48
    163a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    163e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1642:	0685                	addi	a3,a3,1
    1644:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1648:	0006071b          	sext.w	a4,a2
    164c:	feb870e3          	bgeu	a6,a1,162c <atoi+0x3e>
    return neg ? n : -n;
    1650:	000e0563          	beqz	t3,165a <atoi+0x6c>
}
    1654:	8082                	ret
        s++;
    1656:	0505                	addi	a0,a0,1
    1658:	bf71                	j	15f4 <atoi+0x6>
    165a:	4113053b          	subw	a0,t1,a7
    165e:	8082                	ret
    while (isdigit(*s))
    1660:	00154783          	lbu	a5,1(a0)
    1664:	4625                	li	a2,9
        s++;
    1666:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    166a:	fd07859b          	addiw	a1,a5,-48
    166e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1672:	4e01                	li	t3,0
    while (isdigit(*s))
    1674:	fab67ae3          	bgeu	a2,a1,1628 <atoi+0x3a>
    1678:	4501                	li	a0,0
}
    167a:	8082                	ret
    while (isdigit(*s))
    167c:	00154783          	lbu	a5,1(a0)
    1680:	4625                	li	a2,9
        s++;
    1682:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1686:	fd07859b          	addiw	a1,a5,-48
    168a:	0007871b          	sext.w	a4,a5
    168e:	feb665e3          	bltu	a2,a1,1678 <atoi+0x8a>
        neg = 1;
    1692:	4e05                	li	t3,1
    1694:	bf51                	j	1628 <atoi+0x3a>

0000000000001696 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1696:	16060d63          	beqz	a2,1810 <memset+0x17a>
    169a:	40a007b3          	neg	a5,a0
    169e:	8b9d                	andi	a5,a5,7
    16a0:	00778713          	addi	a4,a5,7
    16a4:	482d                	li	a6,11
    16a6:	0ff5f593          	zext.b	a1,a1
    16aa:	fff60693          	addi	a3,a2,-1
    16ae:	17076263          	bltu	a4,a6,1812 <memset+0x17c>
    16b2:	16e6ea63          	bltu	a3,a4,1826 <memset+0x190>
    16b6:	16078563          	beqz	a5,1820 <memset+0x18a>
    16ba:	00b50023          	sb	a1,0(a0)
    16be:	4705                	li	a4,1
    16c0:	00150e93          	addi	t4,a0,1
    16c4:	14e78c63          	beq	a5,a4,181c <memset+0x186>
    16c8:	00b500a3          	sb	a1,1(a0)
    16cc:	4709                	li	a4,2
    16ce:	00250e93          	addi	t4,a0,2
    16d2:	14e78d63          	beq	a5,a4,182c <memset+0x196>
    16d6:	00b50123          	sb	a1,2(a0)
    16da:	470d                	li	a4,3
    16dc:	00350e93          	addi	t4,a0,3
    16e0:	12e78b63          	beq	a5,a4,1816 <memset+0x180>
    16e4:	00b501a3          	sb	a1,3(a0)
    16e8:	4711                	li	a4,4
    16ea:	00450e93          	addi	t4,a0,4
    16ee:	14e78163          	beq	a5,a4,1830 <memset+0x19a>
    16f2:	00b50223          	sb	a1,4(a0)
    16f6:	4715                	li	a4,5
    16f8:	00550e93          	addi	t4,a0,5
    16fc:	12e78c63          	beq	a5,a4,1834 <memset+0x19e>
    1700:	00b502a3          	sb	a1,5(a0)
    1704:	471d                	li	a4,7
    1706:	00650e93          	addi	t4,a0,6
    170a:	12e79763          	bne	a5,a4,1838 <memset+0x1a2>
    170e:	00750e93          	addi	t4,a0,7
    1712:	00b50323          	sb	a1,6(a0)
    1716:	4f1d                	li	t5,7
    1718:	00859713          	slli	a4,a1,0x8
    171c:	8f4d                	or	a4,a4,a1
    171e:	01059e13          	slli	t3,a1,0x10
    1722:	01c76e33          	or	t3,a4,t3
    1726:	01859313          	slli	t1,a1,0x18
    172a:	006e6333          	or	t1,t3,t1
    172e:	02059893          	slli	a7,a1,0x20
    1732:	011368b3          	or	a7,t1,a7
    1736:	02859813          	slli	a6,a1,0x28
    173a:	40f60333          	sub	t1,a2,a5
    173e:	0108e833          	or	a6,a7,a6
    1742:	03059693          	slli	a3,a1,0x30
    1746:	00d866b3          	or	a3,a6,a3
    174a:	03859713          	slli	a4,a1,0x38
    174e:	97aa                	add	a5,a5,a0
    1750:	ff837813          	andi	a6,t1,-8
    1754:	8f55                	or	a4,a4,a3
    1756:	00f806b3          	add	a3,a6,a5
    175a:	e398                	sd	a4,0(a5)
    175c:	07a1                	addi	a5,a5,8
    175e:	fed79ee3          	bne	a5,a3,175a <memset+0xc4>
    1762:	ff837693          	andi	a3,t1,-8
    1766:	00de87b3          	add	a5,t4,a3
    176a:	01e6873b          	addw	a4,a3,t5
    176e:	0ad30663          	beq	t1,a3,181a <memset+0x184>
    1772:	00b78023          	sb	a1,0(a5)
    1776:	0017069b          	addiw	a3,a4,1
    177a:	08c6fb63          	bgeu	a3,a2,1810 <memset+0x17a>
    177e:	00b780a3          	sb	a1,1(a5)
    1782:	0027069b          	addiw	a3,a4,2
    1786:	08c6f563          	bgeu	a3,a2,1810 <memset+0x17a>
    178a:	00b78123          	sb	a1,2(a5)
    178e:	0037069b          	addiw	a3,a4,3
    1792:	06c6ff63          	bgeu	a3,a2,1810 <memset+0x17a>
    1796:	00b781a3          	sb	a1,3(a5)
    179a:	0047069b          	addiw	a3,a4,4
    179e:	06c6f963          	bgeu	a3,a2,1810 <memset+0x17a>
    17a2:	00b78223          	sb	a1,4(a5)
    17a6:	0057069b          	addiw	a3,a4,5
    17aa:	06c6f363          	bgeu	a3,a2,1810 <memset+0x17a>
    17ae:	00b782a3          	sb	a1,5(a5)
    17b2:	0067069b          	addiw	a3,a4,6
    17b6:	04c6fd63          	bgeu	a3,a2,1810 <memset+0x17a>
    17ba:	00b78323          	sb	a1,6(a5)
    17be:	0077069b          	addiw	a3,a4,7
    17c2:	04c6f763          	bgeu	a3,a2,1810 <memset+0x17a>
    17c6:	00b783a3          	sb	a1,7(a5)
    17ca:	0087069b          	addiw	a3,a4,8
    17ce:	04c6f163          	bgeu	a3,a2,1810 <memset+0x17a>
    17d2:	00b78423          	sb	a1,8(a5)
    17d6:	0097069b          	addiw	a3,a4,9
    17da:	02c6fb63          	bgeu	a3,a2,1810 <memset+0x17a>
    17de:	00b784a3          	sb	a1,9(a5)
    17e2:	00a7069b          	addiw	a3,a4,10
    17e6:	02c6f563          	bgeu	a3,a2,1810 <memset+0x17a>
    17ea:	00b78523          	sb	a1,10(a5)
    17ee:	00b7069b          	addiw	a3,a4,11
    17f2:	00c6ff63          	bgeu	a3,a2,1810 <memset+0x17a>
    17f6:	00b785a3          	sb	a1,11(a5)
    17fa:	00c7069b          	addiw	a3,a4,12
    17fe:	00c6f963          	bgeu	a3,a2,1810 <memset+0x17a>
    1802:	00b78623          	sb	a1,12(a5)
    1806:	2735                	addiw	a4,a4,13
    1808:	00c77463          	bgeu	a4,a2,1810 <memset+0x17a>
    180c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1810:	8082                	ret
    1812:	472d                	li	a4,11
    1814:	bd79                	j	16b2 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1816:	4f0d                	li	t5,3
    1818:	b701                	j	1718 <memset+0x82>
    181a:	8082                	ret
    181c:	4f05                	li	t5,1
    181e:	bded                	j	1718 <memset+0x82>
    1820:	8eaa                	mv	t4,a0
    1822:	4f01                	li	t5,0
    1824:	bdd5                	j	1718 <memset+0x82>
    1826:	87aa                	mv	a5,a0
    1828:	4701                	li	a4,0
    182a:	b7a1                	j	1772 <memset+0xdc>
    182c:	4f09                	li	t5,2
    182e:	b5ed                	j	1718 <memset+0x82>
    1830:	4f11                	li	t5,4
    1832:	b5dd                	j	1718 <memset+0x82>
    1834:	4f15                	li	t5,5
    1836:	b5cd                	j	1718 <memset+0x82>
    1838:	4f19                	li	t5,6
    183a:	bdf9                	j	1718 <memset+0x82>

000000000000183c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    183c:	00054783          	lbu	a5,0(a0)
    1840:	0005c703          	lbu	a4,0(a1)
    1844:	00e79863          	bne	a5,a4,1854 <strcmp+0x18>
    1848:	0505                	addi	a0,a0,1
    184a:	0585                	addi	a1,a1,1
    184c:	fbe5                	bnez	a5,183c <strcmp>
    184e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1850:	9d19                	subw	a0,a0,a4
    1852:	8082                	ret
    1854:	0007851b          	sext.w	a0,a5
    1858:	bfe5                	j	1850 <strcmp+0x14>

000000000000185a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    185a:	ce05                	beqz	a2,1892 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    185c:	00054703          	lbu	a4,0(a0)
    1860:	0005c783          	lbu	a5,0(a1)
    1864:	cb0d                	beqz	a4,1896 <strncmp+0x3c>
    if (!n--)
    1866:	167d                	addi	a2,a2,-1
    1868:	00c506b3          	add	a3,a0,a2
    186c:	a819                	j	1882 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186e:	00a68e63          	beq	a3,a0,188a <strncmp+0x30>
    1872:	0505                	addi	a0,a0,1
    1874:	00e79b63          	bne	a5,a4,188a <strncmp+0x30>
    1878:	00054703          	lbu	a4,0(a0)
    187c:	0005c783          	lbu	a5,0(a1)
    1880:	cb19                	beqz	a4,1896 <strncmp+0x3c>
    1882:	0005c783          	lbu	a5,0(a1)
    1886:	0585                	addi	a1,a1,1
    1888:	f3fd                	bnez	a5,186e <strncmp+0x14>
        ;
    return *l - *r;
    188a:	0007051b          	sext.w	a0,a4
    188e:	9d1d                	subw	a0,a0,a5
    1890:	8082                	ret
        return 0;
    1892:	4501                	li	a0,0
}
    1894:	8082                	ret
    1896:	4501                	li	a0,0
    return *l - *r;
    1898:	9d1d                	subw	a0,a0,a5
    189a:	8082                	ret

000000000000189c <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    189c:	00757793          	andi	a5,a0,7
    18a0:	cf89                	beqz	a5,18ba <strlen+0x1e>
    18a2:	87aa                	mv	a5,a0
    18a4:	a029                	j	18ae <strlen+0x12>
    18a6:	0785                	addi	a5,a5,1
    18a8:	0077f713          	andi	a4,a5,7
    18ac:	cb01                	beqz	a4,18bc <strlen+0x20>
        if (!*s)
    18ae:	0007c703          	lbu	a4,0(a5)
    18b2:	fb75                	bnez	a4,18a6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18b4:	40a78533          	sub	a0,a5,a0
}
    18b8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18ba:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18bc:	6394                	ld	a3,0(a5)
    18be:	00000597          	auipc	a1,0x0
    18c2:	6c25b583          	ld	a1,1730(a1) # 1f80 <__clone+0xc8>
    18c6:	00000617          	auipc	a2,0x0
    18ca:	6c263603          	ld	a2,1730(a2) # 1f88 <__clone+0xd0>
    18ce:	a019                	j	18d4 <strlen+0x38>
    18d0:	6794                	ld	a3,8(a5)
    18d2:	07a1                	addi	a5,a5,8
    18d4:	00b68733          	add	a4,a3,a1
    18d8:	fff6c693          	not	a3,a3
    18dc:	8f75                	and	a4,a4,a3
    18de:	8f71                	and	a4,a4,a2
    18e0:	db65                	beqz	a4,18d0 <strlen+0x34>
    for (; *s; s++)
    18e2:	0007c703          	lbu	a4,0(a5)
    18e6:	d779                	beqz	a4,18b4 <strlen+0x18>
    18e8:	0017c703          	lbu	a4,1(a5)
    18ec:	0785                	addi	a5,a5,1
    18ee:	d379                	beqz	a4,18b4 <strlen+0x18>
    18f0:	0017c703          	lbu	a4,1(a5)
    18f4:	0785                	addi	a5,a5,1
    18f6:	fb6d                	bnez	a4,18e8 <strlen+0x4c>
    18f8:	bf75                	j	18b4 <strlen+0x18>

00000000000018fa <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18fa:	00757713          	andi	a4,a0,7
{
    18fe:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1900:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1904:	cb19                	beqz	a4,191a <memchr+0x20>
    1906:	ce25                	beqz	a2,197e <memchr+0x84>
    1908:	0007c703          	lbu	a4,0(a5)
    190c:	04b70e63          	beq	a4,a1,1968 <memchr+0x6e>
    1910:	0785                	addi	a5,a5,1
    1912:	0077f713          	andi	a4,a5,7
    1916:	167d                	addi	a2,a2,-1
    1918:	f77d                	bnez	a4,1906 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    191a:	4501                	li	a0,0
    if (n && *s != c)
    191c:	c235                	beqz	a2,1980 <memchr+0x86>
    191e:	0007c703          	lbu	a4,0(a5)
    1922:	04b70363          	beq	a4,a1,1968 <memchr+0x6e>
        size_t k = ONES * c;
    1926:	00000517          	auipc	a0,0x0
    192a:	66a53503          	ld	a0,1642(a0) # 1f90 <__clone+0xd8>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192e:	471d                	li	a4,7
        size_t k = ONES * c;
    1930:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1934:	02c77a63          	bgeu	a4,a2,1968 <memchr+0x6e>
    1938:	00000897          	auipc	a7,0x0
    193c:	6488b883          	ld	a7,1608(a7) # 1f80 <__clone+0xc8>
    1940:	00000817          	auipc	a6,0x0
    1944:	64883803          	ld	a6,1608(a6) # 1f88 <__clone+0xd0>
    1948:	431d                	li	t1,7
    194a:	a029                	j	1954 <memchr+0x5a>
    194c:	1661                	addi	a2,a2,-8
    194e:	07a1                	addi	a5,a5,8
    1950:	02c37963          	bgeu	t1,a2,1982 <memchr+0x88>
    1954:	6398                	ld	a4,0(a5)
    1956:	8f29                	xor	a4,a4,a0
    1958:	011706b3          	add	a3,a4,a7
    195c:	fff74713          	not	a4,a4
    1960:	8f75                	and	a4,a4,a3
    1962:	01077733          	and	a4,a4,a6
    1966:	d37d                	beqz	a4,194c <memchr+0x52>
    1968:	853e                	mv	a0,a5
    196a:	97b2                	add	a5,a5,a2
    196c:	a021                	j	1974 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    196e:	0505                	addi	a0,a0,1
    1970:	00f50763          	beq	a0,a5,197e <memchr+0x84>
    1974:	00054703          	lbu	a4,0(a0)
    1978:	feb71be3          	bne	a4,a1,196e <memchr+0x74>
    197c:	8082                	ret
    return n ? (void *)s : 0;
    197e:	4501                	li	a0,0
}
    1980:	8082                	ret
    return n ? (void *)s : 0;
    1982:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1984:	f275                	bnez	a2,1968 <memchr+0x6e>
}
    1986:	8082                	ret

0000000000001988 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1988:	1101                	addi	sp,sp,-32
    198a:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    198c:	862e                	mv	a2,a1
{
    198e:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1990:	4581                	li	a1,0
{
    1992:	e426                	sd	s1,8(sp)
    1994:	ec06                	sd	ra,24(sp)
    1996:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1998:	f63ff0ef          	jal	ra,18fa <memchr>
    return p ? p - s : n;
    199c:	c519                	beqz	a0,19aa <strnlen+0x22>
}
    199e:	60e2                	ld	ra,24(sp)
    19a0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19a2:	8d05                	sub	a0,a0,s1
}
    19a4:	64a2                	ld	s1,8(sp)
    19a6:	6105                	addi	sp,sp,32
    19a8:	8082                	ret
    19aa:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19ac:	8522                	mv	a0,s0
}
    19ae:	6442                	ld	s0,16(sp)
    19b0:	64a2                	ld	s1,8(sp)
    19b2:	6105                	addi	sp,sp,32
    19b4:	8082                	ret

00000000000019b6 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19b6:	00b547b3          	xor	a5,a0,a1
    19ba:	8b9d                	andi	a5,a5,7
    19bc:	eb95                	bnez	a5,19f0 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19be:	0075f793          	andi	a5,a1,7
    19c2:	e7b1                	bnez	a5,1a0e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19c4:	6198                	ld	a4,0(a1)
    19c6:	00000617          	auipc	a2,0x0
    19ca:	5ba63603          	ld	a2,1466(a2) # 1f80 <__clone+0xc8>
    19ce:	00000817          	auipc	a6,0x0
    19d2:	5ba83803          	ld	a6,1466(a6) # 1f88 <__clone+0xd0>
    19d6:	a029                	j	19e0 <strcpy+0x2a>
    19d8:	e118                	sd	a4,0(a0)
    19da:	6598                	ld	a4,8(a1)
    19dc:	05a1                	addi	a1,a1,8
    19de:	0521                	addi	a0,a0,8
    19e0:	00c707b3          	add	a5,a4,a2
    19e4:	fff74693          	not	a3,a4
    19e8:	8ff5                	and	a5,a5,a3
    19ea:	0107f7b3          	and	a5,a5,a6
    19ee:	d7ed                	beqz	a5,19d8 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19f0:	0005c783          	lbu	a5,0(a1)
    19f4:	00f50023          	sb	a5,0(a0)
    19f8:	c785                	beqz	a5,1a20 <strcpy+0x6a>
    19fa:	0015c783          	lbu	a5,1(a1)
    19fe:	0505                	addi	a0,a0,1
    1a00:	0585                	addi	a1,a1,1
    1a02:	00f50023          	sb	a5,0(a0)
    1a06:	fbf5                	bnez	a5,19fa <strcpy+0x44>
        ;
    return d;
}
    1a08:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a0a:	0505                	addi	a0,a0,1
    1a0c:	df45                	beqz	a4,19c4 <strcpy+0xe>
            if (!(*d = *s))
    1a0e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a12:	0585                	addi	a1,a1,1
    1a14:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a18:	00f50023          	sb	a5,0(a0)
    1a1c:	f7fd                	bnez	a5,1a0a <strcpy+0x54>
}
    1a1e:	8082                	ret
    1a20:	8082                	ret

0000000000001a22 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a22:	00b547b3          	xor	a5,a0,a1
    1a26:	8b9d                	andi	a5,a5,7
    1a28:	1a079863          	bnez	a5,1bd8 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a2c:	0075f793          	andi	a5,a1,7
    1a30:	16078463          	beqz	a5,1b98 <strncpy+0x176>
    1a34:	ea01                	bnez	a2,1a44 <strncpy+0x22>
    1a36:	a421                	j	1c3e <strncpy+0x21c>
    1a38:	167d                	addi	a2,a2,-1
    1a3a:	0505                	addi	a0,a0,1
    1a3c:	14070e63          	beqz	a4,1b98 <strncpy+0x176>
    1a40:	1a060863          	beqz	a2,1bf0 <strncpy+0x1ce>
    1a44:	0005c783          	lbu	a5,0(a1)
    1a48:	0585                	addi	a1,a1,1
    1a4a:	0075f713          	andi	a4,a1,7
    1a4e:	00f50023          	sb	a5,0(a0)
    1a52:	f3fd                	bnez	a5,1a38 <strncpy+0x16>
    1a54:	4805                	li	a6,1
    1a56:	1a061863          	bnez	a2,1c06 <strncpy+0x1e4>
    1a5a:	40a007b3          	neg	a5,a0
    1a5e:	8b9d                	andi	a5,a5,7
    1a60:	4681                	li	a3,0
    1a62:	18061a63          	bnez	a2,1bf6 <strncpy+0x1d4>
    1a66:	00778713          	addi	a4,a5,7
    1a6a:	45ad                	li	a1,11
    1a6c:	18b76363          	bltu	a4,a1,1bf2 <strncpy+0x1d0>
    1a70:	1ae6eb63          	bltu	a3,a4,1c26 <strncpy+0x204>
    1a74:	1a078363          	beqz	a5,1c1a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a78:	00050023          	sb	zero,0(a0)
    1a7c:	4685                	li	a3,1
    1a7e:	00150713          	addi	a4,a0,1
    1a82:	18d78f63          	beq	a5,a3,1c20 <strncpy+0x1fe>
    1a86:	000500a3          	sb	zero,1(a0)
    1a8a:	4689                	li	a3,2
    1a8c:	00250713          	addi	a4,a0,2
    1a90:	18d78e63          	beq	a5,a3,1c2c <strncpy+0x20a>
    1a94:	00050123          	sb	zero,2(a0)
    1a98:	468d                	li	a3,3
    1a9a:	00350713          	addi	a4,a0,3
    1a9e:	16d78c63          	beq	a5,a3,1c16 <strncpy+0x1f4>
    1aa2:	000501a3          	sb	zero,3(a0)
    1aa6:	4691                	li	a3,4
    1aa8:	00450713          	addi	a4,a0,4
    1aac:	18d78263          	beq	a5,a3,1c30 <strncpy+0x20e>
    1ab0:	00050223          	sb	zero,4(a0)
    1ab4:	4695                	li	a3,5
    1ab6:	00550713          	addi	a4,a0,5
    1aba:	16d78d63          	beq	a5,a3,1c34 <strncpy+0x212>
    1abe:	000502a3          	sb	zero,5(a0)
    1ac2:	469d                	li	a3,7
    1ac4:	00650713          	addi	a4,a0,6
    1ac8:	16d79863          	bne	a5,a3,1c38 <strncpy+0x216>
    1acc:	00750713          	addi	a4,a0,7
    1ad0:	00050323          	sb	zero,6(a0)
    1ad4:	40f80833          	sub	a6,a6,a5
    1ad8:	ff887593          	andi	a1,a6,-8
    1adc:	97aa                	add	a5,a5,a0
    1ade:	95be                	add	a1,a1,a5
    1ae0:	0007b023          	sd	zero,0(a5)
    1ae4:	07a1                	addi	a5,a5,8
    1ae6:	feb79de3          	bne	a5,a1,1ae0 <strncpy+0xbe>
    1aea:	ff887593          	andi	a1,a6,-8
    1aee:	9ead                	addw	a3,a3,a1
    1af0:	00b707b3          	add	a5,a4,a1
    1af4:	12b80863          	beq	a6,a1,1c24 <strncpy+0x202>
    1af8:	00078023          	sb	zero,0(a5)
    1afc:	0016871b          	addiw	a4,a3,1
    1b00:	0ec77863          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b04:	000780a3          	sb	zero,1(a5)
    1b08:	0026871b          	addiw	a4,a3,2
    1b0c:	0ec77263          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b10:	00078123          	sb	zero,2(a5)
    1b14:	0036871b          	addiw	a4,a3,3
    1b18:	0cc77c63          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b1c:	000781a3          	sb	zero,3(a5)
    1b20:	0046871b          	addiw	a4,a3,4
    1b24:	0cc77663          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b28:	00078223          	sb	zero,4(a5)
    1b2c:	0056871b          	addiw	a4,a3,5
    1b30:	0cc77063          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b34:	000782a3          	sb	zero,5(a5)
    1b38:	0066871b          	addiw	a4,a3,6
    1b3c:	0ac77a63          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b40:	00078323          	sb	zero,6(a5)
    1b44:	0076871b          	addiw	a4,a3,7
    1b48:	0ac77463          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b4c:	000783a3          	sb	zero,7(a5)
    1b50:	0086871b          	addiw	a4,a3,8
    1b54:	08c77e63          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b58:	00078423          	sb	zero,8(a5)
    1b5c:	0096871b          	addiw	a4,a3,9
    1b60:	08c77863          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b64:	000784a3          	sb	zero,9(a5)
    1b68:	00a6871b          	addiw	a4,a3,10
    1b6c:	08c77263          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b70:	00078523          	sb	zero,10(a5)
    1b74:	00b6871b          	addiw	a4,a3,11
    1b78:	06c77c63          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b7c:	000785a3          	sb	zero,11(a5)
    1b80:	00c6871b          	addiw	a4,a3,12
    1b84:	06c77663          	bgeu	a4,a2,1bf0 <strncpy+0x1ce>
    1b88:	00078623          	sb	zero,12(a5)
    1b8c:	26b5                	addiw	a3,a3,13
    1b8e:	06c6f163          	bgeu	a3,a2,1bf0 <strncpy+0x1ce>
    1b92:	000786a3          	sb	zero,13(a5)
    1b96:	8082                	ret
            ;
        if (!n || !*s)
    1b98:	c645                	beqz	a2,1c40 <strncpy+0x21e>
    1b9a:	0005c783          	lbu	a5,0(a1)
    1b9e:	ea078be3          	beqz	a5,1a54 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ba2:	479d                	li	a5,7
    1ba4:	02c7ff63          	bgeu	a5,a2,1be2 <strncpy+0x1c0>
    1ba8:	00000897          	auipc	a7,0x0
    1bac:	3d88b883          	ld	a7,984(a7) # 1f80 <__clone+0xc8>
    1bb0:	00000817          	auipc	a6,0x0
    1bb4:	3d883803          	ld	a6,984(a6) # 1f88 <__clone+0xd0>
    1bb8:	431d                	li	t1,7
    1bba:	6198                	ld	a4,0(a1)
    1bbc:	011707b3          	add	a5,a4,a7
    1bc0:	fff74693          	not	a3,a4
    1bc4:	8ff5                	and	a5,a5,a3
    1bc6:	0107f7b3          	and	a5,a5,a6
    1bca:	ef81                	bnez	a5,1be2 <strncpy+0x1c0>
            *wd = *ws;
    1bcc:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bce:	1661                	addi	a2,a2,-8
    1bd0:	05a1                	addi	a1,a1,8
    1bd2:	0521                	addi	a0,a0,8
    1bd4:	fec363e3          	bltu	t1,a2,1bba <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bd8:	e609                	bnez	a2,1be2 <strncpy+0x1c0>
    1bda:	a08d                	j	1c3c <strncpy+0x21a>
    1bdc:	167d                	addi	a2,a2,-1
    1bde:	0505                	addi	a0,a0,1
    1be0:	ca01                	beqz	a2,1bf0 <strncpy+0x1ce>
    1be2:	0005c783          	lbu	a5,0(a1)
    1be6:	0585                	addi	a1,a1,1
    1be8:	00f50023          	sb	a5,0(a0)
    1bec:	fbe5                	bnez	a5,1bdc <strncpy+0x1ba>
        ;
tail:
    1bee:	b59d                	j	1a54 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bf0:	8082                	ret
    1bf2:	472d                	li	a4,11
    1bf4:	bdb5                	j	1a70 <strncpy+0x4e>
    1bf6:	00778713          	addi	a4,a5,7
    1bfa:	45ad                	li	a1,11
    1bfc:	fff60693          	addi	a3,a2,-1
    1c00:	e6b778e3          	bgeu	a4,a1,1a70 <strncpy+0x4e>
    1c04:	b7fd                	j	1bf2 <strncpy+0x1d0>
    1c06:	40a007b3          	neg	a5,a0
    1c0a:	8832                	mv	a6,a2
    1c0c:	8b9d                	andi	a5,a5,7
    1c0e:	4681                	li	a3,0
    1c10:	e4060be3          	beqz	a2,1a66 <strncpy+0x44>
    1c14:	b7cd                	j	1bf6 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c16:	468d                	li	a3,3
    1c18:	bd75                	j	1ad4 <strncpy+0xb2>
    1c1a:	872a                	mv	a4,a0
    1c1c:	4681                	li	a3,0
    1c1e:	bd5d                	j	1ad4 <strncpy+0xb2>
    1c20:	4685                	li	a3,1
    1c22:	bd4d                	j	1ad4 <strncpy+0xb2>
    1c24:	8082                	ret
    1c26:	87aa                	mv	a5,a0
    1c28:	4681                	li	a3,0
    1c2a:	b5f9                	j	1af8 <strncpy+0xd6>
    1c2c:	4689                	li	a3,2
    1c2e:	b55d                	j	1ad4 <strncpy+0xb2>
    1c30:	4691                	li	a3,4
    1c32:	b54d                	j	1ad4 <strncpy+0xb2>
    1c34:	4695                	li	a3,5
    1c36:	bd79                	j	1ad4 <strncpy+0xb2>
    1c38:	4699                	li	a3,6
    1c3a:	bd69                	j	1ad4 <strncpy+0xb2>
    1c3c:	8082                	ret
    1c3e:	8082                	ret
    1c40:	8082                	ret

0000000000001c42 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c42:	87aa                	mv	a5,a0
    1c44:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c46:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c4a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c4e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c50:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c52:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c56:	2501                	sext.w	a0,a0
    1c58:	8082                	ret

0000000000001c5a <openat>:
    register long a7 __asm__("a7") = n;
    1c5a:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c5e:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c62:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c66:	2501                	sext.w	a0,a0
    1c68:	8082                	ret

0000000000001c6a <close>:
    register long a7 __asm__("a7") = n;
    1c6a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c6e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <read>:
    register long a7 __asm__("a7") = n;
    1c76:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7a:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c7e:	8082                	ret

0000000000001c80 <write>:
    register long a7 __asm__("a7") = n;
    1c80:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c84:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c88:	8082                	ret

0000000000001c8a <getpid>:
    register long a7 __asm__("a7") = n;
    1c8a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c8e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c92:	2501                	sext.w	a0,a0
    1c94:	8082                	ret

0000000000001c96 <getppid>:
    register long a7 __asm__("a7") = n;
    1c96:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c9a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c9e:	2501                	sext.w	a0,a0
    1ca0:	8082                	ret

0000000000001ca2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ca2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ca6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1caa:	2501                	sext.w	a0,a0
    1cac:	8082                	ret

0000000000001cae <fork>:
    register long a7 __asm__("a7") = n;
    1cae:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cb2:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cb4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cbe:	85b2                	mv	a1,a2
    1cc0:	863a                	mv	a2,a4
    if (stack)
    1cc2:	c191                	beqz	a1,1cc6 <clone+0x8>
	stack += stack_size;
    1cc4:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cc6:	4781                	li	a5,0
    1cc8:	4701                	li	a4,0
    1cca:	4681                	li	a3,0
    1ccc:	2601                	sext.w	a2,a2
    1cce:	a2ed                	j	1eb8 <__clone>

0000000000001cd0 <exit>:
    register long a7 __asm__("a7") = n;
    1cd0:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cd4:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cd8:	8082                	ret

0000000000001cda <waitpid>:
    register long a7 __asm__("a7") = n;
    1cda:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cde:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ce0:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <exec>:
    register long a7 __asm__("a7") = n;
    1ce8:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <execve>:
    register long a7 __asm__("a7") = n;
    1cf4:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf8:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cfc:	2501                	sext.w	a0,a0
    1cfe:	8082                	ret

0000000000001d00 <times>:
    register long a7 __asm__("a7") = n;
    1d00:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d04:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <get_time>:

int64 get_time()
{
    1d0c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d0e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d12:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d14:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d16:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d1a:	2501                	sext.w	a0,a0
    1d1c:	ed09                	bnez	a0,1d36 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d1e:	67a2                	ld	a5,8(sp)
    1d20:	3e800713          	li	a4,1000
    1d24:	00015503          	lhu	a0,0(sp)
    1d28:	02e7d7b3          	divu	a5,a5,a4
    1d2c:	02e50533          	mul	a0,a0,a4
    1d30:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d32:	0141                	addi	sp,sp,16
    1d34:	8082                	ret
        return -1;
    1d36:	557d                	li	a0,-1
    1d38:	bfed                	j	1d32 <get_time+0x26>

0000000000001d3a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d3a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d42:	2501                	sext.w	a0,a0
    1d44:	8082                	ret

0000000000001d46 <time>:
    register long a7 __asm__("a7") = n;
    1d46:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d4a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d4e:	2501                	sext.w	a0,a0
    1d50:	8082                	ret

0000000000001d52 <sleep>:

int sleep(unsigned long long time)
{
    1d52:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d54:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d56:	850a                	mv	a0,sp
    1d58:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d5a:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d5e:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d60:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d64:	e501                	bnez	a0,1d6c <sleep+0x1a>
    return 0;
    1d66:	4501                	li	a0,0
}
    1d68:	0141                	addi	sp,sp,16
    1d6a:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d6c:	4502                	lw	a0,0(sp)
}
    1d6e:	0141                	addi	sp,sp,16
    1d70:	8082                	ret

0000000000001d72 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d72:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d76:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d7e:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d82:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d86:	8082                	ret

0000000000001d88 <munmap>:
    register long a7 __asm__("a7") = n;
    1d88:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8c:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d90:	2501                	sext.w	a0,a0
    1d92:	8082                	ret

0000000000001d94 <wait>:

int wait(int *code)
{
    1d94:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d96:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d9a:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d9c:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d9e:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1da0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <spawn>:
    register long a7 __asm__("a7") = n;
    1da8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dac:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1db0:	2501                	sext.w	a0,a0
    1db2:	8082                	ret

0000000000001db4 <mailread>:
    register long a7 __asm__("a7") = n;
    1db4:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dc0:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dc4:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <fstat>:
    register long a7 __asm__("a7") = n;
    1dcc:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd0:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dd8:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dda:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dde:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1de0:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1de8:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dea:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dee:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df0:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <link>:

int link(char *old_path, char *new_path)
{
    1df8:	87aa                	mv	a5,a0
    1dfa:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1dfc:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e00:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e04:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e06:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e0a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e0c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e10:	2501                	sext.w	a0,a0
    1e12:	8082                	ret

0000000000001e14 <unlink>:

int unlink(char *path)
{
    1e14:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e16:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e1a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e1e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e20:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e24:	2501                	sext.w	a0,a0
    1e26:	8082                	ret

0000000000001e28 <uname>:
    register long a7 __asm__("a7") = n;
    1e28:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e2c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e30:	2501                	sext.w	a0,a0
    1e32:	8082                	ret

0000000000001e34 <brk>:
    register long a7 __asm__("a7") = n;
    1e34:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e38:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e3c:	2501                	sext.w	a0,a0
    1e3e:	8082                	ret

0000000000001e40 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e40:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e42:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e46:	8082                	ret

0000000000001e48 <chdir>:
    register long a7 __asm__("a7") = n;
    1e48:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e4c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e50:	2501                	sext.w	a0,a0
    1e52:	8082                	ret

0000000000001e54 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e54:	862e                	mv	a2,a1
    1e56:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e58:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e5a:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e5e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e62:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e64:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e66:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <getdents>:
    register long a7 __asm__("a7") = n;
    1e6e:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e72:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <pipe>:
    register long a7 __asm__("a7") = n;
    1e7a:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e7e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e80:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e84:	2501                	sext.w	a0,a0
    1e86:	8082                	ret

0000000000001e88 <dup>:
    register long a7 __asm__("a7") = n;
    1e88:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e8a:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <dup2>:
    register long a7 __asm__("a7") = n;
    1e92:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e94:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e96:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <mount>:
    register long a7 __asm__("a7") = n;
    1e9e:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ea2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <umount>:
    register long a7 __asm__("a7") = n;
    1eaa:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eae:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eb0:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eb4:	2501                	sext.w	a0,a0
    1eb6:	8082                	ret

0000000000001eb8 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eb8:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eba:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ebc:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ebe:	8532                	mv	a0,a2
	mv a2, a4
    1ec0:	863a                	mv	a2,a4
	mv a3, a5
    1ec2:	86be                	mv	a3,a5
	mv a4, a6
    1ec4:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ec6:	0dc00893          	li	a7,220
	ecall
    1eca:	00000073          	ecall

	beqz a0, 1f
    1ece:	c111                	beqz	a0,1ed2 <__clone+0x1a>
	# Parent
	ret
    1ed0:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ed2:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ed4:	6522                	ld	a0,8(sp)
	jalr a1
    1ed6:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ed8:	05d00893          	li	a7,93
	ecall
    1edc:	00000073          	ecall
