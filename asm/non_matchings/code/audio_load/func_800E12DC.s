.rdata
glabel D_80149420
    .asciz "SUPERDMA"
    .balign 4

.text
glabel func_800E12DC
/* B5847C 800E12DC 27BDFFB0 */  addiu $sp, $sp, -0x50
/* B58480 800E12E0 AFB10030 */  sw    $s1, 0x30($sp)
/* B58484 800E12E4 AFB0002C */  sw    $s0, 0x2c($sp)
/* B58488 800E12E8 00A08025 */  move  $s0, $a1
/* B5848C 800E12EC 00808825 */  move  $s1, $a0
/* B58490 800E12F0 AFBF0034 */  sw    $ra, 0x34($sp)
/* B58494 800E12F4 AFA60058 */  sw    $a2, 0x58($sp)
/* B58498 800E12F8 AFA7005C */  sw    $a3, 0x5c($sp)
/* B5849C 800E12FC 14C00008 */  bnez  $a2, .L800E1320
/* B584A0 800E1300 00005825 */   move  $t3, $zero
/* B584A4 800E1304 3C098017 */  lui   $t1, %hi(gAudioContext) # $t1, 0x8017
/* B584A8 800E1308 2529F180 */  addiu $t1, %lo(gAudioContext) # addiu $t1, $t1, -0xe80
/* B584AC 800E130C 8D262624 */  lw    $a2, 0x2624($t1)
/* B584B0 800E1310 90E20000 */  lbu   $v0, ($a3)
/* B584B4 800E1314 0046082B */  sltu  $at, $v0, $a2
/* B584B8 800E1318 54200057 */  bnezl $at, .L800E1478
/* B584BC 800E131C 8D25261C */   lw    $a1, 0x261c($t1)
.L800E1320:
/* B584C0 800E1320 3C098017 */  lui   $t1, %hi(gAudioContext) # $t1, 0x8017
/* B584C4 800E1324 2529F180 */  addiu $t1, %lo(gAudioContext) # addiu $t1, $t1, -0xe80
/* B584C8 800E1328 8D262624 */  lw    $a2, 0x2624($t1)
/* B584CC 800E132C 8D252620 */  lw    $a1, 0x2620($t1)
/* B584D0 800E1330 00C02025 */  move  $a0, $a2
/* B584D4 800E1334 00C5082B */  sltu  $at, $a2, $a1
/* B584D8 800E1338 50200036 */  beql  $at, $zero, .L800E1414
/* B584DC 800E133C 8FB90058 */   lw    $t9, 0x58($sp)
/* B584E0 800E1340 8D39261C */  lw    $t9, 0x261c($t1)
/* B584E4 800E1344 0004C100 */  sll   $t8, $a0, 4
/* B584E8 800E1348 03191821 */  addu  $v1, $t8, $t9
.L800E134C:
/* B584EC 800E134C 8C6C0004 */  lw    $t4, 4($v1)
/* B584F0 800E1350 00604025 */  move  $t0, $v1
/* B584F4 800E1354 022C1023 */  subu  $v0, $s1, $t4
/* B584F8 800E1358 04420029 */  bltzl $v0, .L800E1400
/* B584FC 800E135C 24840001 */   addiu $a0, $a0, 1
/* B58500 800E1360 950D000A */  lhu   $t5, 0xa($t0)
/* B58504 800E1364 01B07023 */  subu  $t6, $t5, $s0
/* B58508 800E1368 01C2082B */  sltu  $at, $t6, $v0
/* B5850C 800E136C 54200024 */  bnezl $at, .L800E1400
/* B58510 800E1370 24840001 */   addiu $a0, $a0, 1
/* B58514 800E1374 910F000E */  lbu   $t7, 0xe($t0)
/* B58518 800E1378 55E00018 */  bnezl $t7, .L800E13DC
/* B5851C 800E137C 240C0020 */   li    $t4, 32
/* B58520 800E1380 9122282D */  lbu   $v0, 0x282d($t1)
/* B58524 800E1384 9138282F */  lbu   $t8, 0x282f($t1)
/* B58528 800E1388 53020014 */  beql  $t8, $v0, .L800E13DC
/* B5852C 800E138C 240C0020 */   li    $t4, 32
/* B58530 800E1390 9103000D */  lbu   $v1, 0xd($t0)
/* B58534 800E1394 0122C821 */  addu  $t9, $t1, $v0
/* B58538 800E1398 5043000E */  beql  $v0, $v1, .L800E13D4
/* B5853C 800E139C 24590001 */   addiu $t9, $v0, 1
/* B58540 800E13A0 932C272C */  lbu   $t4, 0x272c($t9)
/* B58544 800E13A4 01236821 */  addu  $t5, $t1, $v1
/* B58548 800E13A8 A1AC272C */  sb    $t4, 0x272c($t5)
/* B5854C 800E13AC 9138282D */  lbu   $t8, 0x282d($t1)
/* B58550 800E13B0 8D2F261C */  lw    $t7, 0x261c($t1)
/* B58554 800E13B4 910E000D */  lbu   $t6, 0xd($t0)
/* B58558 800E13B8 0138C821 */  addu  $t9, $t1, $t8
/* B5855C 800E13BC 932C272C */  lbu   $t4, 0x272c($t9)
/* B58560 800E13C0 000C6900 */  sll   $t5, $t4, 4
/* B58564 800E13C4 01EDC021 */  addu  $t8, $t7, $t5
/* B58568 800E13C8 A30E000D */  sb    $t6, 0xd($t8)
/* B5856C 800E13CC 9122282D */  lbu   $v0, 0x282d($t1)
/* B58570 800E13D0 24590001 */  addiu $t9, $v0, 1
.L800E13D4:
/* B58574 800E13D4 A139282D */  sb    $t9, 0x282d($t1)
/* B58578 800E13D8 240C0020 */  li    $t4, 32
.L800E13DC:
/* B5857C 800E13DC A10C000E */  sb    $t4, 0xe($t0)
/* B58580 800E13E0 8FAF005C */  lw    $t7, 0x5c($sp)
/* B58584 800E13E4 A1E40000 */  sb    $a0, ($t7)
/* B58588 800E13E8 8D0D0000 */  lw    $t5, ($t0)
/* B5858C 800E13EC 8D180004 */  lw    $t8, 4($t0)
/* B58590 800E13F0 01B17021 */  addu  $t6, $t5, $s1
/* B58594 800E13F4 10000083 */  b     .L800E1604
/* B58598 800E13F8 01D81023 */   subu  $v0, $t6, $t8
/* B5859C 800E13FC 24840001 */  addiu $a0, $a0, 1
.L800E1400:
/* B585A0 800E1400 0085082B */  sltu  $at, $a0, $a1
/* B585A4 800E1404 1420FFD1 */  bnez  $at, .L800E134C
/* B585A8 800E1408 24630010 */   addiu $v1, $v1, 0x10
/* B585AC 800E140C AFA80048 */  sw    $t0, 0x48($sp)
/* B585B0 800E1410 8FB90058 */  lw    $t9, 0x58($sp)
.L800E1414:
/* B585B4 800E1414 8FA80048 */  lw    $t0, 0x48($sp)
/* B585B8 800E1418 8FAC005C */  lw    $t4, 0x5c($sp)
/* B585BC 800E141C 57200005 */  bnezl $t9, .L800E1434
/* B585C0 800E1420 9122282D */   lbu   $v0, 0x282d($t1)
/* B585C4 800E1424 91820000 */  lbu   $v0, ($t4)
/* B585C8 800E1428 10000013 */  b     .L800E1478
/* B585CC 800E142C 8D25261C */   lw    $a1, 0x261c($t1)
/* B585D0 800E1430 9122282D */  lbu   $v0, 0x282d($t1)
.L800E1434:
/* B585D4 800E1434 912F282F */  lbu   $t7, 0x282f($t1)
/* B585D8 800E1438 8FAD0058 */  lw    $t5, 0x58($sp)
/* B585DC 800E143C 11E2000B */  beq   $t7, $v0, .L800E146C
/* B585E0 800E1440 00000000 */   nop
/* B585E4 800E1444 11A00009 */  beqz  $t5, .L800E146C
/* B585E8 800E1448 01227021 */   addu  $t6, $t1, $v0
/* B585EC 800E144C 91CA272C */  lbu   $t2, 0x272c($t6)
/* B585F0 800E1450 8D2C261C */  lw    $t4, 0x261c($t1)
/* B585F4 800E1454 24580001 */  addiu $t8, $v0, 1
/* B585F8 800E1458 000AC900 */  sll   $t9, $t2, 4
/* B585FC 800E145C A138282D */  sb    $t8, 0x282d($t1)
/* B58600 800E1460 240B0001 */  li    $t3, 1
/* B58604 800E1464 AFAA0038 */  sw    $t2, 0x38($sp)
/* B58608 800E1468 032C4021 */  addu  $t0, $t9, $t4
.L800E146C:
/* B5860C 800E146C 10000030 */  b     .L800E1530
/* B58610 800E1470 00000000 */   nop
/* B58614 800E1474 8D25261C */  lw    $a1, 0x261c($t1)
.L800E1478:
/* B58618 800E1478 00027900 */  sll   $t7, $v0, 4
/* B5861C 800E147C 01E54021 */  addu  $t0, $t7, $a1
/* B58620 800E1480 00002025 */  move  $a0, $zero
.L800E1484:
/* B58624 800E1484 8D030004 */  lw    $v1, 4($t0)
/* B58628 800E1488 02231023 */  subu  $v0, $s1, $v1
/* B5862C 800E148C 04420024 */  bltzl $v0, .L800E1520
/* B58630 800E1490 00046900 */   sll   $t5, $a0, 4
/* B58634 800E1494 950D000A */  lhu   $t5, 0xa($t0)
/* B58638 800E1498 01B07023 */  subu  $t6, $t5, $s0
/* B5863C 800E149C 01C2082B */  sltu  $at, $t6, $v0
/* B58640 800E14A0 5420001F */  bnezl $at, .L800E1520
/* B58644 800E14A4 00046900 */   sll   $t5, $a0, 4
/* B58648 800E14A8 9118000E */  lbu   $t8, 0xe($t0)
/* B5864C 800E14AC 57000016 */  bnezl $t8, .L800E1508
/* B58650 800E14B0 8D0E0000 */   lw    $t6, ($t0)
/* B58654 800E14B4 9122282C */  lbu   $v0, 0x282c($t1)
/* B58658 800E14B8 9103000D */  lbu   $v1, 0xd($t0)
/* B5865C 800E14BC 0122C821 */  addu  $t9, $t1, $v0
/* B58660 800E14C0 5043000E */  beql  $v0, $v1, .L800E14FC
/* B58664 800E14C4 24590001 */   addiu $t9, $v0, 1
/* B58668 800E14C8 932C262C */  lbu   $t4, 0x262c($t9)
/* B5866C 800E14CC 01237821 */  addu  $t7, $t1, $v1
/* B58670 800E14D0 A1EC262C */  sb    $t4, 0x262c($t7)
/* B58674 800E14D4 9138282C */  lbu   $t8, 0x282c($t1)
/* B58678 800E14D8 8D2E261C */  lw    $t6, 0x261c($t1)
/* B5867C 800E14DC 910D000D */  lbu   $t5, 0xd($t0)
/* B58680 800E14E0 0138C821 */  addu  $t9, $t1, $t8
/* B58684 800E14E4 932C262C */  lbu   $t4, 0x262c($t9)
/* B58688 800E14E8 000C7900 */  sll   $t7, $t4, 4
/* B5868C 800E14EC 01CFC021 */  addu  $t8, $t6, $t7
/* B58690 800E14F0 A30D000D */  sb    $t5, 0xd($t8)
/* B58694 800E14F4 9122282C */  lbu   $v0, 0x282c($t1)
/* B58698 800E14F8 24590001 */  addiu $t9, $v0, 1
.L800E14FC:
/* B5869C 800E14FC A139282C */  sb    $t9, 0x282c($t1)
/* B586A0 800E1500 8D030004 */  lw    $v1, 4($t0)
/* B586A4 800E1504 8D0E0000 */  lw    $t6, ($t0)
.L800E1508:
/* B586A8 800E1508 240C0002 */  li    $t4, 2
/* B586AC 800E150C A10C000E */  sb    $t4, 0xe($t0)
/* B586B0 800E1510 01D17821 */  addu  $t7, $t6, $s1
/* B586B4 800E1514 1000003B */  b     .L800E1604
/* B586B8 800E1518 01E31023 */   subu  $v0, $t7, $v1
/* B586BC 800E151C 00046900 */  sll   $t5, $a0, 4
.L800E1520:
/* B586C0 800E1520 24840001 */  addiu $a0, $a0, 1
/* B586C4 800E1524 00C4082B */  sltu  $at, $a2, $a0
/* B586C8 800E1528 1020FFD6 */  beqz  $at, .L800E1484
/* B586CC 800E152C 01A54021 */   addu  $t0, $t5, $a1
.L800E1530:
/* B586D0 800E1530 1560000D */  bnez  $t3, .L800E1568
/* B586D4 800E1534 8FAA0038 */   lw    $t2, 0x38($sp)
/* B586D8 800E1538 9122282C */  lbu   $v0, 0x282c($t1)
/* B586DC 800E153C 9138282E */  lbu   $t8, 0x282e($t1)
/* B586E0 800E1540 0122C821 */  addu  $t9, $t1, $v0
/* B586E4 800E1544 17020003 */  bne   $t8, $v0, .L800E1554
/* B586E8 800E1548 244C0001 */   addiu $t4, $v0, 1
/* B586EC 800E154C 1000002D */  b     .L800E1604
/* B586F0 800E1550 00001025 */   move  $v0, $zero
.L800E1554:
/* B586F4 800E1554 932A262C */  lbu   $t2, 0x262c($t9)
/* B586F8 800E1558 8D2F261C */  lw    $t7, 0x261c($t1)
/* B586FC 800E155C A12C282C */  sb    $t4, 0x282c($t1)
/* B58700 800E1560 000A7100 */  sll   $t6, $t2, 4
/* B58704 800E1564 01CF4021 */  addu  $t0, $t6, $t7
.L800E1568:
/* B58708 800E1568 9502000A */  lhu   $v0, 0xa($t0)
/* B5870C 800E156C 240D0003 */  li    $t5, 3
/* B58710 800E1570 2401FFF0 */  li    $at, -16
/* B58714 800E1574 A10D000E */  sb    $t5, 0xe($t0)
/* B58718 800E1578 02218024 */  and   $s0, $s1, $at
/* B5871C 800E157C AD100004 */  sw    $s0, 4($t0)
/* B58720 800E1580 A5020008 */  sh    $v0, 8($t0)
/* B58724 800E1584 8D2328A0 */  lw    $v1, 0x28a0($t1)
/* B58728 800E1588 8D190000 */  lw    $t9, ($t0)
/* B5872C 800E158C 8FAE0060 */  lw    $t6, 0x60($sp)
/* B58730 800E1590 0003C080 */  sll   $t8, $v1, 2
/* B58734 800E1594 0303C023 */  subu  $t8, $t8, $v1
/* B58738 800E1598 0018C0C0 */  sll   $t8, $t8, 3
/* B5873C 800E159C 3C0C8017 */  lui   $t4, %hi(gAudioContext+0x1ed0) # $t4, 0x8017
/* B58740 800E15A0 3C0F8015 */  lui   $t7, %hi(D_80149420) # $t7, 0x8015
/* B58744 800E15A4 25EF9420 */  addiu $t7, %lo(D_80149420) # addiu $t7, $t7, -0x6be0
/* B58748 800E15A8 258C1050 */  addiu $t4, %lo(gAudioContext+0x1ed0) # addiu $t4, $t4, 0x1050
/* B5874C 800E15AC 01382021 */  addu  $a0, $t1, $t8
/* B58750 800E15B0 246D0001 */  addiu $t5, $v1, 1
/* B58754 800E15B4 AD2D28A0 */  sw    $t5, 0x28a0($t1)
/* B58758 800E15B8 24841FE8 */  addiu $a0, $a0, 0x1fe8
/* B5875C 800E15BC AFAC0018 */  sw    $t4, 0x18($sp)
/* B58760 800E15C0 AFAF0020 */  sw    $t7, 0x20($sp)
/* B58764 800E15C4 AFAA0038 */  sw    $t2, 0x38($sp)
/* B58768 800E15C8 AFA80048 */  sw    $t0, 0x48($sp)
/* B5876C 800E15CC 02003825 */  move  $a3, $s0
/* B58770 800E15D0 00002825 */  move  $a1, $zero
/* B58774 800E15D4 00003025 */  move  $a2, $zero
/* B58778 800E15D8 AFA20014 */  sw    $v0, 0x14($sp)
/* B5877C 800E15DC AFB90010 */  sw    $t9, 0x10($sp)
/* B58780 800E15E0 0C038AF8 */  jal   Audio_DMA
/* B58784 800E15E4 AFAE001C */   sw    $t6, 0x1c($sp)
/* B58788 800E15E8 8FAA0038 */  lw    $t2, 0x38($sp)
/* B5878C 800E15EC 8FB8005C */  lw    $t8, 0x5c($sp)
/* B58790 800E15F0 8FA80048 */  lw    $t0, 0x48($sp)
/* B58794 800E15F4 0230C823 */  subu  $t9, $s1, $s0
/* B58798 800E15F8 A30A0000 */  sb    $t2, ($t8)
/* B5879C 800E15FC 8D0C0000 */  lw    $t4, ($t0)
/* B587A0 800E1600 032C1021 */  addu  $v0, $t9, $t4
.L800E1604:
/* B587A4 800E1604 8FBF0034 */  lw    $ra, 0x34($sp)
/* B587A8 800E1608 8FB0002C */  lw    $s0, 0x2c($sp)
/* B587AC 800E160C 8FB10030 */  lw    $s1, 0x30($sp)
/* B587B0 800E1610 03E00008 */  jr    $ra
/* B587B4 800E1614 27BD0050 */   addiu $sp, $sp, 0x50

