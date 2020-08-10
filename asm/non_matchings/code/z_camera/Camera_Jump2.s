.rdata
glabel D_80139140
    .asciz "\x1b[43;30mcamera: climb: no floor \n\x1b[m"
    .balign 4

.late_rodata
glabel D_80139F80
    .float 0.01
    .float 0.01
    .float 0.01

glabel D_80139F8C
    .float 0.01

glabel D_80139F90
    .float 0.01

glabel D_80139F94
    .float 0.01

glabel D_80139F98
    .float 0.05

glabel D_80139F9C
    .float 2.2

glabel D_80139FA0
    .float 0.01

glabel D_80139FA4
    .float 0.01

glabel D_80139FA8
    .float 0.01

glabel D_80139FAC
    .float 0.01

.text
glabel Camera_Jump2
/* AC13F0 8004A250 27BDFF20 */  addiu $sp, $sp, -0xe0
/* AC13F4 8004A254 AFB00018 */  sw    $s0, 0x18($sp)
/* AC13F8 8004A258 00808025 */  move  $s0, $a0
/* AC13FC 8004A25C AFBF001C */  sw    $ra, 0x1c($sp)
/* AC1400 8004A260 0C00B721 */  jal   Player_GetCameraYOffset
/* AC1404 8004A264 8C840090 */   lw    $a0, 0x90($a0)
/* AC1408 8004A268 E7A00048 */  swc1  $f0, 0x48($sp)
/* AC140C 8004A26C 8603015E */  lh    $v1, 0x15e($s0)
/* AC1410 8004A270 10600009 */  beqz  $v1, .L8004A298
/* AC1414 8004A274 2401000A */   li    $at, 10
/* AC1418 8004A278 10610007 */  beq   $v1, $at, .L8004A298
/* AC141C 8004A27C 24010014 */   li    $at, 20
/* AC1420 8004A280 10610005 */  beq   $v1, $at, .L8004A298
/* AC1424 8004A284 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC1428 8004A288 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC142C 8004A28C 85C30314 */  lh    $v1, 0x314($t6)
/* AC1430 8004A290 10600066 */  beqz  $v1, .L8004A42C
/* AC1434 8004A294 00000000 */   nop
.L8004A298:
/* AC1438 8004A298 860F0142 */  lh    $t7, 0x142($s0)
/* AC143C 8004A29C 3C0E8016 */  lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC1440 8004A2A0 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC1444 8004A2A4 3C018014 */  lui   $at, %hi(D_80139F80)
/* AC1448 8004A2A8 000FC0C0 */  sll   $t8, $t7, 3
/* AC144C 8004A2AC C42E9F80 */  lwc1  $f14, %lo(D_80139F80)($at)
/* AC1450 8004A2B0 85CF01F0 */  lh    $t7, 0x1f0($t6)
/* AC1454 8004A2B4 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC1458 8004A2B8 44814000 */  mtc1  $at, $f8
/* AC145C 8004A2BC 448F2000 */  mtc1  $t7, $f4
/* AC1460 8004A2C0 3C014288 */  li    $at, 0x42880000 # 0.000000
/* AC1464 8004A2C4 44819000 */  mtc1  $at, $f18
/* AC1468 8004A2C8 468021A0 */  cvt.s.w $f6, $f4
/* AC146C 8004A2CC 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC1470 8004A2D0 860B0144 */  lh    $t3, 0x144($s0)
/* AC1474 8004A2D4 0338C821 */  addu  $t9, $t9, $t8
/* AC1478 8004A2D8 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC147C 8004A2DC 46009103 */  div.s $f4, $f18, $f0
/* AC1480 8004A2E0 C61200F4 */  lwc1  $f18, 0xf4($s0)
/* AC1484 8004A2E4 000B60C0 */  sll   $t4, $t3, 3
/* AC1488 8004A2E8 032C6821 */  addu  $t5, $t9, $t4
/* AC148C 8004A2EC 460E3082 */  mul.s $f2, $f6, $f14
/* AC1490 8004A2F0 8DA20004 */  lw    $v0, 4($t5)
/* AC1494 8004A2F4 3C014120 */  li    $at, 0x41200000 # 0.000000
/* AC1498 8004A2F8 46024280 */  add.s $f10, $f8, $f2
/* AC149C 8004A2FC 44804000 */  mtc1  $zero, $f8
/* AC14A0 8004A300 46041182 */  mul.s $f6, $f2, $f4
/* AC14A4 8004A304 4612403C */  c.lt.s $f8, $f18
/* AC14A8 8004A308 00000000 */  nop
/* AC14AC 8004A30C 45000005 */  bc1f  .L8004A324
/* AC14B0 8004A310 46065301 */   sub.s $f12, $f10, $f6
/* AC14B4 8004A314 3C01C120 */  li    $at, 0xC1200000 # 0.000000
/* AC14B8 8004A318 44811000 */  mtc1  $at, $f2
/* AC14BC 8004A31C 10000004 */  b     .L8004A330
/* AC14C0 8004A320 84580000 */   lh    $t8, ($v0)
.L8004A324:
/* AC14C4 8004A324 44811000 */  mtc1  $at, $f2
/* AC14C8 8004A328 00000000 */  nop
/* AC14CC 8004A32C 84580000 */  lh    $t8, ($v0)
.L8004A330:
/* AC14D0 8004A330 24420020 */  addiu $v0, $v0, 0x20
/* AC14D4 8004A334 44982000 */  mtc1  $t8, $f4
/* AC14D8 8004A338 00000000 */  nop
/* AC14DC 8004A33C 468022A0 */  cvt.s.w $f10, $f4
/* AC14E0 8004A340 46025180 */  add.s $f6, $f10, $f2
/* AC14E4 8004A344 460E3202 */  mul.s $f8, $f6, $f14
/* AC14E8 8004A348 00000000 */  nop
/* AC14EC 8004A34C 46004482 */  mul.s $f18, $f8, $f0
/* AC14F0 8004A350 00000000 */  nop
/* AC14F4 8004A354 460C9102 */  mul.s $f4, $f18, $f12
/* AC14F8 8004A358 E6040000 */  swc1  $f4, ($s0)
/* AC14FC 8004A35C 844BFFE4 */  lh    $t3, -0x1c($v0)
/* AC1500 8004A360 448B5000 */  mtc1  $t3, $f10
/* AC1504 8004A364 00000000 */  nop
/* AC1508 8004A368 468051A0 */  cvt.s.w $f6, $f10
/* AC150C 8004A36C 460E3202 */  mul.s $f8, $f6, $f14
/* AC1510 8004A370 00000000 */  nop
/* AC1514 8004A374 46004482 */  mul.s $f18, $f8, $f0
/* AC1518 8004A378 00000000 */  nop
/* AC151C 8004A37C 460C9102 */  mul.s $f4, $f18, $f12
/* AC1520 8004A380 E6040004 */  swc1  $f4, 4($s0)
/* AC1524 8004A384 8459FFE8 */  lh    $t9, -0x18($v0)
/* AC1528 8004A388 44995000 */  mtc1  $t9, $f10
/* AC152C 8004A38C 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* AC1530 8004A390 468051A0 */  cvt.s.w $f6, $f10
/* AC1534 8004A394 460E3202 */  mul.s $f8, $f6, $f14
/* AC1538 8004A398 00000000 */  nop
/* AC153C 8004A39C 46004482 */  mul.s $f18, $f8, $f0
/* AC1540 8004A3A0 00000000 */  nop
/* AC1544 8004A3A4 460C9102 */  mul.s $f4, $f18, $f12
/* AC1548 8004A3A8 E6040008 */  swc1  $f4, 8($s0)
/* AC154C 8004A3AC 844CFFEC */  lh    $t4, -0x14($v0)
/* AC1550 8004A3B0 448C5000 */  mtc1  $t4, $f10
/* AC1554 8004A3B4 00000000 */  nop
/* AC1558 8004A3B8 468051A0 */  cvt.s.w $f6, $f10
/* AC155C 8004A3BC 460E3202 */  mul.s $f8, $f6, $f14
/* AC1560 8004A3C0 E608000C */  swc1  $f8, 0xc($s0)
/* AC1564 8004A3C4 844DFFF0 */  lh    $t5, -0x10($v0)
/* AC1568 8004A3C8 448D9000 */  mtc1  $t5, $f18
/* AC156C 8004A3CC 00000000 */  nop
/* AC1570 8004A3D0 46809120 */  cvt.s.w $f4, $f18
/* AC1574 8004A3D4 E6040010 */  swc1  $f4, 0x10($s0)
/* AC1578 8004A3D8 844EFFF4 */  lh    $t6, -0xc($v0)
/* AC157C 8004A3DC 448E5000 */  mtc1  $t6, $f10
/* AC1580 8004A3E0 00000000 */  nop
/* AC1584 8004A3E4 468051A0 */  cvt.s.w $f6, $f10
/* AC1588 8004A3E8 460E3202 */  mul.s $f8, $f6, $f14
/* AC158C 8004A3EC E6080014 */  swc1  $f8, 0x14($s0)
/* AC1590 8004A3F0 844FFFF8 */  lh    $t7, -8($v0)
/* AC1594 8004A3F4 448F9000 */  mtc1  $t7, $f18
/* AC1598 8004A3F8 00000000 */  nop
/* AC159C 8004A3FC 46809120 */  cvt.s.w $f4, $f18
/* AC15A0 8004A400 E6040018 */  swc1  $f4, 0x18($s0)
/* AC15A4 8004A404 8458FFFC */  lh    $t8, -4($v0)
/* AC15A8 8004A408 44985000 */  mtc1  $t8, $f10
/* AC15AC 8004A40C 00000000 */  nop
/* AC15B0 8004A410 468051A0 */  cvt.s.w $f6, $f10
/* AC15B4 8004A414 460E3202 */  mul.s $f8, $f6, $f14
/* AC15B8 8004A418 E608001C */  swc1  $f8, 0x1c($s0)
/* AC15BC 8004A41C 844B0000 */  lh    $t3, ($v0)
/* AC15C0 8004A420 A60B0020 */  sh    $t3, 0x20($s0)
/* AC15C4 8004A424 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* AC15C8 8004A428 87230314 */  lh    $v1, 0x314($t9)
.L8004A42C:
/* AC15CC 8004A42C 50600004 */  beql  $v1, $zero, .L8004A440
/* AC15D0 8004A430 26050050 */   addiu $a1, $s0, 0x50
/* AC15D4 8004A434 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC15D8 8004A438 02002025 */   move  $a0, $s0
/* AC15DC 8004A43C 26050050 */  addiu $a1, $s0, 0x50
.L8004A440:
/* AC15E0 8004A440 2606005C */  addiu $a2, $s0, 0x5c
/* AC15E4 8004A444 AFA60038 */  sw    $a2, 0x38($sp)
/* AC15E8 8004A448 AFA50034 */  sw    $a1, 0x34($sp)
/* AC15EC 8004A44C 0C01F124 */  jal   OLib_Vec3fDiffToVecSphGeo
/* AC15F0 8004A450 27A4009C */   addiu $a0, $sp, 0x9c
/* AC15F4 8004A454 26060074 */  addiu $a2, $s0, 0x74
/* AC15F8 8004A458 AFA60030 */  sw    $a2, 0x30($sp)
/* AC15FC 8004A45C 27A400A4 */  addiu $a0, $sp, 0xa4
/* AC1600 8004A460 0C01F124 */  jal   OLib_Vec3fDiffToVecSphGeo
/* AC1604 8004A464 8FA50034 */   lw    $a1, 0x34($sp)
/* AC1608 8004A468 860C0020 */  lh    $t4, 0x20($s0)
/* AC160C 8004A46C 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags) # $at, 0x8012
/* AC1610 8004A470 AC2CD3A0 */  sw    $t4, %lo(sCameraInterfaceFlags)($at)
/* AC1614 8004A474 8603015E */  lh    $v1, 0x15e($s0)
/* AC1618 8004A478 10600004 */  beqz  $v1, .L8004A48C
/* AC161C 8004A47C 2401000A */   li    $at, 10
/* AC1620 8004A480 10610002 */  beq   $v1, $at, .L8004A48C
/* AC1624 8004A484 24010014 */   li    $at, 20
/* AC1628 8004A488 1461006C */  bne   $v1, $at, .L8004A63C
.L8004A48C:
/* AC162C 8004A48C 26080094 */   addiu $t0, $s0, 0x94
/* AC1630 8004A490 8D0E0000 */  lw    $t6, ($t0)
/* AC1634 8004A494 27A500C8 */  addiu $a1, $sp, 0xc8
/* AC1638 8004A498 02002025 */  move  $a0, $s0
/* AC163C 8004A49C ACAE0000 */  sw    $t6, ($a1)
/* AC1640 8004A4A0 8D0D0004 */  lw    $t5, 4($t0)
/* AC1644 8004A4A4 ACAD0004 */  sw    $t5, 4($a1)
/* AC1648 8004A4A8 8D0E0008 */  lw    $t6, 8($t0)
/* AC164C 8004A4AC ACAE0008 */  sw    $t6, 8($a1)
/* AC1650 8004A4B0 0C011144 */  jal   func_80044510
/* AC1654 8004A4B4 AFA8002C */   sw    $t0, 0x2c($sp)
/* AC1658 8004A4B8 3C01C6FA */  li    $at, 0xC6FA0000 # 0.000000
/* AC165C 8004A4BC 44819000 */  mtc1  $at, $f18
/* AC1660 8004A4C0 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1664 8004A4C4 26090024 */  addiu $t1, $s0, 0x24
/* AC1668 8004A4C8 46120032 */  c.eq.s $f0, $f18
/* AC166C 8004A4CC E5200000 */  swc1  $f0, ($t1)
/* AC1670 8004A4D0 87AF00AA */  lh    $t7, 0xaa($sp)
/* AC1674 8004A4D4 A5200006 */  sh    $zero, 6($t1)
/* AC1678 8004A4D8 45000010 */  bc1f  .L8004A51C
/* AC167C 8004A4DC A52F0004 */   sh    $t7, 4($t1)
/* AC1680 8004A4E0 3C048014 */  lui   $a0, %hi(D_80139140) # $a0, 0x8014
/* AC1684 8004A4E4 24849140 */  addiu $a0, %lo(D_80139140) # addiu $a0, $a0, -0x6ec0
/* AC1688 8004A4E8 AFA8002C */  sw    $t0, 0x2c($sp)
/* AC168C 8004A4EC 0C00084C */  jal   osSyncPrintf
/* AC1690 8004A4F0 AFA90028 */   sw    $t1, 0x28($sp)
/* AC1694 8004A4F4 8FA90028 */  lw    $t1, 0x28($sp)
/* AC1698 8004A4F8 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC169C 8004A4FC 2418FFFF */  li    $t8, -1
/* AC16A0 8004A500 3C01447A */  li    $at, 0x447A0000 # 0.000000
/* AC16A4 8004A504 A538000A */  sh    $t8, 0xa($t1)
/* AC16A8 8004A508 44815000 */  mtc1  $at, $f10
/* AC16AC 8004A50C C5040004 */  lwc1  $f4, 4($t0)
/* AC16B0 8004A510 460A2181 */  sub.s $f6, $f4, $f10
/* AC16B4 8004A514 1000000E */  b     .L8004A550
/* AC16B8 8004A518 E5260000 */   swc1  $f6, ($t1)
.L8004A51C:
/* AC16BC 8004A51C C5080004 */  lwc1  $f8, 4($t0)
/* AC16C0 8004A520 C5320000 */  lwc1  $f18, ($t1)
/* AC16C4 8004A524 C7AA0048 */  lwc1  $f10, 0x48($sp)
/* AC16C8 8004A528 240B0001 */  li    $t3, 1
/* AC16CC 8004A52C 46124101 */  sub.s $f4, $f8, $f18
/* AC16D0 8004A530 2419FFFF */  li    $t9, -1
/* AC16D4 8004A534 460A203C */  c.lt.s $f4, $f10
/* AC16D8 8004A538 00000000 */  nop
/* AC16DC 8004A53C 45020004 */  bc1fl .L8004A550
/* AC16E0 8004A540 A539000A */   sh    $t9, 0xa($t1)
/* AC16E4 8004A544 10000002 */  b     .L8004A550
/* AC16E8 8004A548 A52B000A */   sh    $t3, 0xa($t1)
/* AC16EC 8004A54C A539000A */  sh    $t9, 0xa($t1)
.L8004A550:
/* AC16F0 8004A550 850C000E */  lh    $t4, 0xe($t0)
/* AC16F4 8004A554 3C038016 */  lui   $v1, %hi(gGameInfo) # $v1, 0x8016
/* AC16F8 8004A558 2463FA90 */  addiu $v1, %lo(gGameInfo) # addiu $v1, $v1, -0x570
/* AC16FC 8004A55C 87B800AA */  lh    $t8, 0xaa($sp)
/* AC1700 8004A560 8C6B0000 */  lw    $t3, ($v1)
/* AC1704 8004A564 258D8001 */  addiu $t5, $t4, -0x7fff
/* AC1708 8004A568 000D7400 */  sll   $t6, $t5, 0x10
/* AC170C 8004A56C 000E7C03 */  sra   $t7, $t6, 0x10
/* AC1710 8004A570 857901C2 */  lh    $t9, 0x1c2($t3)
/* AC1714 8004A574 01F81023 */  subu  $v0, $t7, $t8
/* AC1718 8004A578 00021400 */  sll   $v0, $v0, 0x10
/* AC171C 8004A57C 00021403 */  sra   $v0, $v0, 0x10
/* AC1720 8004A580 0059001A */  div   $zero, $v0, $t9
/* AC1724 8004A584 17200002 */  bnez  $t9, .L8004A590
/* AC1728 8004A588 00000000 */   nop
/* AC172C 8004A58C 0007000D */  break 7
.L8004A590:
/* AC1730 8004A590 2401FFFF */  li    $at, -1
/* AC1734 8004A594 17210004 */  bne   $t9, $at, .L8004A5A8
/* AC1738 8004A598 3C018000 */   lui   $at, 0x8000
/* AC173C 8004A59C 14410002 */  bne   $v0, $at, .L8004A5A8
/* AC1740 8004A5A0 00000000 */   nop
/* AC1744 8004A5A4 0006000D */  break 6
.L8004A5A8:
/* AC1748 8004A5A8 00006012 */  mflo  $t4
/* AC174C 8004A5AC 240B000A */  li    $t3, 10
/* AC1750 8004A5B0 05810003 */  bgez  $t4, .L8004A5C0
/* AC1754 8004A5B4 000C6883 */   sra   $t5, $t4, 2
/* AC1758 8004A5B8 25810003 */  addiu $at, $t4, 3
/* AC175C 8004A5BC 00016883 */  sra   $t5, $at, 2
.L8004A5C0:
/* AC1760 8004A5C0 000D7080 */  sll   $t6, $t5, 2
/* AC1764 8004A5C4 01CD7023 */  subu  $t6, $t6, $t5
/* AC1768 8004A5C8 A52E0006 */  sh    $t6, 6($t1)
/* AC176C 8004A5CC 860F0020 */  lh    $t7, 0x20($s0)
/* AC1770 8004A5D0 24192710 */  li    $t9, 10000
/* AC1774 8004A5D4 31F80002 */  andi  $t8, $t7, 2
/* AC1778 8004A5D8 53000004 */  beql  $t8, $zero, .L8004A5EC
/* AC177C 8004A5DC A5390008 */   sh    $t9, 8($t1)
/* AC1780 8004A5E0 10000002 */  b     .L8004A5EC
/* AC1784 8004A5E4 A52B0008 */   sh    $t3, 8($t1)
/* AC1788 8004A5E8 A5390008 */  sh    $t9, 8($t1)
.L8004A5EC:
/* AC178C 8004A5EC C5060000 */  lwc1  $f6, ($t0)
/* AC1790 8004A5F0 C60800F0 */  lwc1  $f8, 0xf0($s0)
/* AC1794 8004A5F4 C5040004 */  lwc1  $f4, 4($t0)
/* AC1798 8004A5F8 46083481 */  sub.s $f18, $f6, $f8
/* AC179C 8004A5FC C5080008 */  lwc1  $f8, 8($t0)
/* AC17A0 8004A600 E5120000 */  swc1  $f18, ($t0)
/* AC17A4 8004A604 C60A00F4 */  lwc1  $f10, 0xf4($s0)
/* AC17A8 8004A608 460A2181 */  sub.s $f6, $f4, $f10
/* AC17AC 8004A60C E5060004 */  swc1  $f6, 4($t0)
/* AC17B0 8004A610 C61200F8 */  lwc1  $f18, 0xf8($s0)
/* AC17B4 8004A614 46124101 */  sub.s $f4, $f8, $f18
/* AC17B8 8004A618 E5040008 */  swc1  $f4, 8($t0)
/* AC17BC 8004A61C 8C6C0000 */  lw    $t4, ($v1)
/* AC17C0 8004A620 858D01C2 */  lh    $t5, 0x1c2($t4)
/* AC17C4 8004A624 A52D000C */  sh    $t5, 0xc($t1)
/* AC17C8 8004A628 860E015E */  lh    $t6, 0x15e($s0)
/* AC17CC 8004A62C C60A001C */  lwc1  $f10, 0x1c($s0)
/* AC17D0 8004A630 25CF0001 */  addiu $t7, $t6, 1
/* AC17D4 8004A634 A60F015E */  sh    $t7, 0x15e($s0)
/* AC17D8 8004A638 E60A0100 */  swc1  $f10, 0x100($s0)
.L8004A63C:
/* AC17DC 8004A63C 3C038016 */  lui   $v1, %hi(gGameInfo) # $v1, 0x8016
/* AC17E0 8004A640 2463FA90 */  addiu $v1, %lo(gGameInfo) # addiu $v1, $v1, -0x570
/* AC17E4 8004A644 8C620000 */  lw    $v0, ($v1)
/* AC17E8 8004A648 3C018014 */  lui   $at, %hi(D_80139F8C)
/* AC17EC 8004A64C C4309F8C */  lwc1  $f16, %lo(D_80139F8C)($at)
/* AC17F0 8004A650 845801C6 */  lh    $t8, 0x1c6($v0)
/* AC17F4 8004A654 844B01C8 */  lh    $t3, 0x1c8($v0)
/* AC17F8 8004A658 C60000E0 */  lwc1  $f0, 0xe0($s0)
/* AC17FC 8004A65C 44983000 */  mtc1  $t8, $f6
/* AC1800 8004A660 448B2000 */  mtc1  $t3, $f4
/* AC1804 8004A664 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC1808 8004A668 46803220 */  cvt.s.w $f8, $f6
/* AC180C 8004A66C 26080094 */  addiu $t0, $s0, 0x94
/* AC1810 8004A670 26090024 */  addiu $t1, $s0, 0x24
/* AC1814 8004A674 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1818 8004A678 468022A0 */  cvt.s.w $f10, $f4
/* AC181C 8004A67C 46104482 */  mul.s $f18, $f8, $f16
/* AC1820 8004A680 00000000 */  nop
/* AC1824 8004A684 46009082 */  mul.s $f2, $f18, $f0
/* AC1828 8004A688 00000000 */  nop
/* AC182C 8004A68C 46105182 */  mul.s $f6, $f10, $f16
/* AC1830 8004A690 44061000 */  mfc1  $a2, $f2
/* AC1834 8004A694 46003202 */  mul.s $f8, $f6, $f0
/* AC1838 8004A698 E7A8008C */  swc1  $f8, 0x8c($sp)
/* AC183C 8004A69C C60E00C8 */  lwc1  $f14, 0xc8($s0)
/* AC1840 8004A6A0 C60C0010 */  lwc1  $f12, 0x10($s0)
/* AC1844 8004A6A4 E7A20090 */  swc1  $f2, 0x90($sp)
/* AC1848 8004A6A8 AFA90028 */  sw    $t1, 0x28($sp)
/* AC184C 8004A6AC 0C010E27 */  jal   Camera_LERPCeilF
/* AC1850 8004A6B0 AFA8002C */   sw    $t0, 0x2c($sp)
/* AC1854 8004A6B4 C7A20090 */  lwc1  $f2, 0x90($sp)
/* AC1858 8004A6B8 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC185C 8004A6BC E60000C8 */  swc1  $f0, 0xc8($s0)
/* AC1860 8004A6C0 44061000 */  mfc1  $a2, $f2
/* AC1864 8004A6C4 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1868 8004A6C8 C60C0014 */  lwc1  $f12, 0x14($s0)
/* AC186C 8004A6CC 0C010E27 */  jal   Camera_LERPCeilF
/* AC1870 8004A6D0 C60E00CC */   lwc1  $f14, 0xcc($s0)
/* AC1874 8004A6D4 E60000CC */  swc1  $f0, 0xcc($s0)
/* AC1878 8004A6D8 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* AC187C 8004A6DC 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* AC1880 8004A6E0 3C018014 */  lui   $at, %hi(D_80139F90)
/* AC1884 8004A6E4 C42A9F90 */  lwc1  $f10, %lo(D_80139F90)($at)
/* AC1888 8004A6E8 872C019A */  lh    $t4, 0x19a($t9)
/* AC188C 8004A6EC 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC1890 8004A6F0 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1894 8004A6F4 448C9000 */  mtc1  $t4, $f18
/* AC1898 8004A6F8 8FA6008C */  lw    $a2, 0x8c($sp)
/* AC189C 8004A6FC C60E00D0 */  lwc1  $f14, 0xd0($s0)
/* AC18A0 8004A700 46809120 */  cvt.s.w $f4, $f18
/* AC18A4 8004A704 460A2302 */  mul.s $f12, $f4, $f10
/* AC18A8 8004A708 0C010E27 */  jal   Camera_LERPCeilF
/* AC18AC 8004A70C 00000000 */   nop
/* AC18B0 8004A710 E60000D0 */  swc1  $f0, 0xd0($s0)
/* AC18B4 8004A714 3C0D8016 */  lui   $t5, %hi(gGameInfo) # $t5, 0x8016
/* AC18B8 8004A718 8DADFA90 */  lw    $t5, %lo(gGameInfo)($t5)
/* AC18BC 8004A71C 3C018014 */  lui   $at, %hi(D_80139F94)
/* AC18C0 8004A720 C4329F94 */  lwc1  $f18, %lo(D_80139F94)($at)
/* AC18C4 8004A724 85AE019C */  lh    $t6, 0x19c($t5)
/* AC18C8 8004A728 3C018014 */  lui   $at, %hi(D_80139F98)
/* AC18CC 8004A72C C42A9F98 */  lwc1  $f10, %lo(D_80139F98)($at)
/* AC18D0 8004A730 448E3000 */  mtc1  $t6, $f6
/* AC18D4 8004A734 C60400E0 */  lwc1  $f4, 0xe0($s0)
/* AC18D8 8004A738 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC18DC 8004A73C 46803220 */  cvt.s.w $f8, $f6
/* AC18E0 8004A740 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC18E4 8004A744 46000386 */  mov.s $f14, $f0
/* AC18E8 8004A748 46124302 */  mul.s $f12, $f8, $f18
/* AC18EC 8004A74C 00000000 */  nop
/* AC18F0 8004A750 460A2182 */  mul.s $f6, $f4, $f10
/* AC18F4 8004A754 44063000 */  mfc1  $a2, $f6
/* AC18F8 8004A758 0C010E27 */  jal   Camera_LERPCeilF
/* AC18FC 8004A75C 00000000 */   nop
/* AC1900 8004A760 E60000D4 */  swc1  $f0, 0xd4($s0)
/* AC1904 8004A764 3C0F8016 */  lui   $t7, %hi(gGameInfo) # $t7, 0x8016
/* AC1908 8004A768 8DEFFA90 */  lw    $t7, %lo(gGameInfo)($t7)
/* AC190C 8004A76C 02002025 */  move  $a0, $s0
/* AC1910 8004A770 27A500A4 */  addiu $a1, $sp, 0xa4
/* AC1914 8004A774 85F801CA */  lh    $t8, 0x1ca($t7)
/* AC1918 8004A778 8E060000 */  lw    $a2, ($s0)
/* AC191C 8004A77C 00003825 */  move  $a3, $zero
/* AC1920 8004A780 44984000 */  mtc1  $t8, $f8
/* AC1924 8004A784 00000000 */  nop
/* AC1928 8004A788 468044A0 */  cvt.s.w $f18, $f8
/* AC192C 8004A78C 0C0115EA */  jal   func_800457A8
/* AC1930 8004A790 E61200C0 */   swc1  $f18, 0xc0($s0)
/* AC1934 8004A794 27A400B4 */  addiu $a0, $sp, 0xb4
/* AC1938 8004A798 8FA50034 */  lw    $a1, 0x34($sp)
/* AC193C 8004A79C 0C01F124 */  jal   OLib_Vec3fDiffToVecSphGeo
/* AC1940 8004A7A0 8FA60038 */   lw    $a2, 0x38($sp)
/* AC1944 8004A7A4 C60C0008 */  lwc1  $f12, 8($s0)
/* AC1948 8004A7A8 C60E000C */  lwc1  $f14, 0xc($s0)
/* AC194C 8004A7AC C6000004 */  lwc1  $f0, 4($s0)
/* AC1950 8004A7B0 C7A600B4 */  lwc1  $f6, 0xb4($sp)
/* AC1954 8004A7B4 460E6102 */  mul.s $f4, $f12, $f14
/* AC1958 8004A7B8 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC195C 8004A7BC 8FA90028 */  lw    $t1, 0x28($sp)
/* AC1960 8004A7C0 460E0282 */  mul.s $f10, $f0, $f14
/* AC1964 8004A7C4 46046080 */  add.s $f2, $f12, $f4
/* AC1968 8004A7C8 460A0401 */  sub.s $f16, $f0, $f10
/* AC196C 8004A7CC 4606103C */  c.lt.s $f2, $f6
/* AC1970 8004A7D0 00000000 */  nop
/* AC1974 8004A7D4 45020004 */  bc1fl .L8004A7E8
/* AC1978 8004A7D8 C7A800B4 */   lwc1  $f8, 0xb4($sp)
/* AC197C 8004A7DC 10000007 */  b     .L8004A7FC
/* AC1980 8004A7E0 E7A200B4 */   swc1  $f2, 0xb4($sp)
/* AC1984 8004A7E4 C7A800B4 */  lwc1  $f8, 0xb4($sp)
.L8004A7E8:
/* AC1988 8004A7E8 4610403C */  c.lt.s $f8, $f16
/* AC198C 8004A7EC 00000000 */  nop
/* AC1990 8004A7F0 45020003 */  bc1fl .L8004A800
/* AC1994 8004A7F4 850A000E */   lh    $t2, 0xe($t0)
/* AC1998 8004A7F8 E7B000B4 */  swc1  $f16, 0xb4($sp)
.L8004A7FC:
/* AC199C 8004A7FC 850A000E */  lh    $t2, 0xe($t0)
.L8004A800:
/* AC19A0 8004A800 87AC00BA */  lh    $t4, 0xba($sp)
/* AC19A4 8004A804 8523000C */  lh    $v1, 0xc($t1)
/* AC19A8 8004A808 254A8001 */  addiu $t2, $t2, -0x7fff
/* AC19AC 8004A80C 014C1023 */  subu  $v0, $t2, $t4
/* AC19B0 8004A810 00021400 */  sll   $v0, $v0, 0x10
/* AC19B4 8004A814 1060000F */  beqz  $v1, .L8004A854
/* AC19B8 8004A818 00021403 */   sra   $v0, $v0, 0x10
/* AC19BC 8004A81C A52A0004 */  sh    $t2, 4($t1)
/* AC19C0 8004A820 246DFFFF */  addiu $t5, $v1, -1
/* AC19C4 8004A824 A52D000C */  sh    $t5, 0xc($t1)
/* AC19C8 8004A828 85240004 */  lh    $a0, 4($t1)
/* AC19CC 8004A82C AFA90028 */  sw    $t1, 0x28($sp)
/* AC19D0 8004A830 AFA8002C */  sw    $t0, 0x2c($sp)
/* AC19D4 8004A834 87A500AA */  lh    $a1, 0xaa($sp)
/* AC19D8 8004A838 3C063F00 */  lui   $a2, 0x3f00
/* AC19DC 8004A83C 0C010E47 */  jal   Camera_LERPCeilS
/* AC19E0 8004A840 2407000A */   li    $a3, 10
/* AC19E4 8004A844 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC19E8 8004A848 8FA90028 */  lw    $t1, 0x28($sp)
/* AC19EC 8004A84C 10000029 */  b     .L8004A8F4
/* AC19F0 8004A850 A7A200BA */   sh    $v0, 0xba($sp)
.L8004A854:
/* AC19F4 8004A854 04400003 */  bltz  $v0, .L8004A864
/* AC19F8 8004A858 00021823 */   negu  $v1, $v0
/* AC19FC 8004A85C 10000001 */  b     .L8004A864
/* AC1A00 8004A860 00401825 */   move  $v1, $v0
.L8004A864:
/* AC1A04 8004A864 85240008 */  lh    $a0, 8($t1)
/* AC1A08 8004A868 87A500AA */  lh    $a1, 0xaa($sp)
/* AC1A0C 8004A86C 3C063E80 */  lui   $a2, 0x3e80
/* AC1A10 8004A870 0083082A */  slt   $at, $a0, $v1
/* AC1A14 8004A874 10200018 */  beqz  $at, .L8004A8D8
/* AC1A18 8004A878 2407000A */   li    $a3, 10
/* AC1A1C 8004A87C 000A2C00 */  sll   $a1, $t2, 0x10
/* AC1A20 8004A880 04410005 */  bgez  $v0, .L8004A898
/* AC1A24 8004A884 00052C03 */   sra   $a1, $a1, 0x10
/* AC1A28 8004A888 00A41821 */  addu  $v1, $a1, $a0
/* AC1A2C 8004A88C 00031C00 */  sll   $v1, $v1, 0x10
/* AC1A30 8004A890 10000004 */  b     .L8004A8A4
/* AC1A34 8004A894 00031C03 */   sra   $v1, $v1, 0x10
.L8004A898:
/* AC1A38 8004A898 00A41823 */  subu  $v1, $a1, $a0
/* AC1A3C 8004A89C 00031C00 */  sll   $v1, $v1, 0x10
/* AC1A40 8004A8A0 00031C03 */  sra   $v1, $v1, 0x10
.L8004A8A4:
/* AC1A44 8004A8A4 00032400 */  sll   $a0, $v1, 0x10
/* AC1A48 8004A8A8 3C063DCC */  lui   $a2, (0x3DCCCCCD >> 16) # lui $a2, 0x3dcc
/* AC1A4C 8004A8AC 34C6CCCD */  ori   $a2, (0x3DCCCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC1A50 8004A8B0 00042403 */  sra   $a0, $a0, 0x10
/* AC1A54 8004A8B4 87A500AA */  lh    $a1, 0xaa($sp)
/* AC1A58 8004A8B8 2407000A */  li    $a3, 10
/* AC1A5C 8004A8BC AFA8002C */  sw    $t0, 0x2c($sp)
/* AC1A60 8004A8C0 0C010E6B */  jal   Camera_LERPFloorS
/* AC1A64 8004A8C4 AFA90028 */   sw    $t1, 0x28($sp)
/* AC1A68 8004A8C8 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1A6C 8004A8CC 8FA90028 */  lw    $t1, 0x28($sp)
/* AC1A70 8004A8D0 10000008 */  b     .L8004A8F4
/* AC1A74 8004A8D4 A7A200BA */   sh    $v0, 0xba($sp)
.L8004A8D8:
/* AC1A78 8004A8D8 87A400BA */  lh    $a0, 0xba($sp)
/* AC1A7C 8004A8DC AFA8002C */  sw    $t0, 0x2c($sp)
/* AC1A80 8004A8E0 0C010E47 */  jal   Camera_LERPCeilS
/* AC1A84 8004A8E4 AFA90028 */   sw    $t1, 0x28($sp)
/* AC1A88 8004A8E8 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1A8C 8004A8EC 8FA90028 */  lw    $t1, 0x28($sp)
/* AC1A90 8004A8F0 A7A200BA */  sh    $v0, 0xba($sp)
.L8004A8F4:
/* AC1A94 8004A8F4 8504000E */  lh    $a0, 0xe($t0)
/* AC1A98 8004A8F8 AFA90028 */  sw    $t1, 0x28($sp)
/* AC1A9C 8004A8FC 0C01DE1C */  jal   Math_Sins
/* AC1AA0 8004A900 AFA8002C */   sw    $t0, 0x2c($sp)
/* AC1AA4 8004A904 3C0141C8 */  li    $at, 0x41C80000 # 0.000000
/* AC1AA8 8004A908 44819000 */  mtc1  $at, $f18
/* AC1AAC 8004A90C 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1AB0 8004A910 3C018014 */  lui   $at, %hi(D_80139F9C)
/* AC1AB4 8004A914 46120102 */  mul.s $f4, $f0, $f18
/* AC1AB8 8004A918 C50A0000 */  lwc1  $f10, ($t0)
/* AC1ABC 8004A91C C4329F9C */  lwc1  $f18, %lo(D_80139F9C)($at)
/* AC1AC0 8004A920 C7A80048 */  lwc1  $f8, 0x48($sp)
/* AC1AC4 8004A924 460A2180 */  add.s $f6, $f4, $f10
/* AC1AC8 8004A928 46124102 */  mul.s $f4, $f8, $f18
/* AC1ACC 8004A92C E7A600C8 */  swc1  $f6, 0xc8($sp)
/* AC1AD0 8004A930 C50A0004 */  lwc1  $f10, 4($t0)
/* AC1AD4 8004A934 46045180 */  add.s $f6, $f10, $f4
/* AC1AD8 8004A938 E7A600CC */  swc1  $f6, 0xcc($sp)
/* AC1ADC 8004A93C 0C01DE0D */  jal   Math_Coss
/* AC1AE0 8004A940 8504000E */   lh    $a0, 0xe($t0)
/* AC1AE4 8004A944 3C0141C8 */  li    $at, 0x41C80000 # 0.000000
/* AC1AE8 8004A948 44814000 */  mtc1  $at, $f8
/* AC1AEC 8004A94C 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1AF0 8004A950 02002025 */  move  $a0, $s0
/* AC1AF4 8004A954 46080482 */  mul.s $f18, $f0, $f8
/* AC1AF8 8004A958 C50A0008 */  lwc1  $f10, 8($t0)
/* AC1AFC 8004A95C 27A500BC */  addiu $a1, $sp, 0xbc
/* AC1B00 8004A960 27A600C8 */  addiu $a2, $sp, 0xc8
/* AC1B04 8004A964 27A70088 */  addiu $a3, $sp, 0x88
/* AC1B08 8004A968 460A9100 */  add.s $f4, $f18, $f10
/* AC1B0C 8004A96C 0C01110D */  jal   func_80044434
/* AC1B10 8004A970 E7A400D0 */   swc1  $f4, 0xd0($sp)
/* AC1B14 8004A974 3C01C6FA */  li    $at, 0xC6FA0000 # 0.000000
/* AC1B18 8004A978 44813000 */  mtc1  $at, $f6
/* AC1B1C 8004A97C 8FA8002C */  lw    $t0, 0x2c($sp)
/* AC1B20 8004A980 8FA90028 */  lw    $t1, 0x28($sp)
/* AC1B24 8004A984 46060032 */  c.eq.s $f0, $f6
/* AC1B28 8004A988 00000000 */  nop
/* AC1B2C 8004A98C 45030036 */  bc1tl .L8004AA68
/* AC1B30 8004A990 C50A0004 */   lwc1  $f10, 4($t0)
/* AC1B34 8004A994 C5080004 */  lwc1  $f8, 4($t0)
/* AC1B38 8004A998 3C0E8016 */  lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC1B3C 8004A99C 4600403C */  c.lt.s $f8, $f0
/* AC1B40 8004A9A0 00000000 */  nop
/* AC1B44 8004A9A4 45020030 */  bc1fl .L8004AA68
/* AC1B48 8004A9A8 C50A0004 */   lwc1  $f10, 4($t0)
/* AC1B4C 8004A9AC 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC1B50 8004A9B0 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* AC1B54 8004A9B4 44816000 */  mtc1  $at, $f12
/* AC1B58 8004A9B8 85CF01C8 */  lh    $t7, 0x1c8($t6)
/* AC1B5C 8004A9BC 3C018014 */  lui   $at, %hi(D_80139FA0)
/* AC1B60 8004A9C0 C4249FA0 */  lwc1  $f4, %lo(D_80139FA0)($at)
/* AC1B64 8004A9C4 448F9000 */  mtc1  $t7, $f18
/* AC1B68 8004A9C8 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC1B6C 8004A9CC 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1B70 8004A9D0 468092A0 */  cvt.s.w $f10, $f18
/* AC1B74 8004A9D4 C60E00C4 */  lwc1  $f14, 0xc4($s0)
/* AC1B78 8004A9D8 46045182 */  mul.s $f6, $f10, $f4
/* AC1B7C 8004A9DC 44063000 */  mfc1  $a2, $f6
/* AC1B80 8004A9E0 0C010E27 */  jal   Camera_LERPCeilF
/* AC1B84 8004A9E4 00000000 */   nop
/* AC1B88 8004A9E8 E60000C4 */  swc1  $f0, 0xc4($s0)
/* AC1B8C 8004A9EC 3C188016 */  lui   $t8, %hi(gGameInfo) # $t8, 0x8016
/* AC1B90 8004A9F0 8F18FA90 */  lw    $t8, %lo(gGameInfo)($t8)
/* AC1B94 8004A9F4 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* AC1B98 8004A9F8 44816000 */  mtc1  $at, $f12
/* AC1B9C 8004A9FC 870B01C8 */  lh    $t3, 0x1c8($t8)
/* AC1BA0 8004AA00 3C018014 */  lui   $at, %hi(D_80139FA4)
/* AC1BA4 8004AA04 C42A9FA4 */  lwc1  $f10, %lo(D_80139FA4)($at)
/* AC1BA8 8004AA08 448B4000 */  mtc1  $t3, $f8
/* AC1BAC 8004AA0C 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC1BB0 8004AA10 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1BB4 8004AA14 468044A0 */  cvt.s.w $f18, $f8
/* AC1BB8 8004AA18 C60E00C0 */  lwc1  $f14, 0xc0($s0)
/* AC1BBC 8004AA1C 460A9102 */  mul.s $f4, $f18, $f10
/* AC1BC0 8004AA20 44062000 */  mfc1  $a2, $f4
/* AC1BC4 8004AA24 0C010E27 */  jal   Camera_LERPCeilF
/* AC1BC8 8004AA28 00000000 */   nop
/* AC1BCC 8004AA2C 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC1BD0 8004AA30 44813000 */  mtc1  $at, $f6
/* AC1BD4 8004AA34 C60800C4 */  lwc1  $f8, 0xc4($s0)
/* AC1BD8 8004AA38 E60000C0 */  swc1  $f0, 0xc0($s0)
/* AC1BDC 8004AA3C 87A500A8 */  lh    $a1, 0xa8($sp)
/* AC1BE0 8004AA40 46083483 */  div.s $f18, $f6, $f8
/* AC1BE4 8004AA44 240401F4 */  li    $a0, 500
/* AC1BE8 8004AA48 2407000A */  li    $a3, 10
/* AC1BEC 8004AA4C 44069000 */  mfc1  $a2, $f18
/* AC1BF0 8004AA50 0C010E47 */  jal   Camera_LERPCeilS
/* AC1BF4 8004AA54 00000000 */   nop
/* AC1BF8 8004AA58 00021C00 */  sll   $v1, $v0, 0x10
/* AC1BFC 8004AA5C 1000003E */  b     .L8004AB58
/* AC1C00 8004AA60 00031C03 */   sra   $v1, $v1, 0x10
/* AC1C04 8004AA64 C50A0004 */  lwc1  $f10, 4($t0)
.L8004AA68:
/* AC1C08 8004AA68 C5240000 */  lwc1  $f4, ($t1)
/* AC1C0C 8004AA6C C7A80048 */  lwc1  $f8, 0x48($sp)
/* AC1C10 8004AA70 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* AC1C14 8004AA74 46045181 */  sub.s $f6, $f10, $f4
/* AC1C18 8004AA78 3C0142C8 */  li    $at, 0x42C80000 # 0.000000
/* AC1C1C 8004AA7C 4608303C */  c.lt.s $f6, $f8
/* AC1C20 8004AA80 00000000 */  nop
/* AC1C24 8004AA84 45020030 */  bc1fl .L8004AB48
/* AC1C28 8004AA88 44810000 */   mtc1  $at, $f0
/* AC1C2C 8004AA8C 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* AC1C30 8004AA90 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* AC1C34 8004AA94 44816000 */  mtc1  $at, $f12
/* AC1C38 8004AA98 872C01C8 */  lh    $t4, 0x1c8($t9)
/* AC1C3C 8004AA9C 3C018014 */  lui   $at, %hi(D_80139FA8)
/* AC1C40 8004AAA0 C4249FA8 */  lwc1  $f4, %lo(D_80139FA8)($at)
/* AC1C44 8004AAA4 448C9000 */  mtc1  $t4, $f18
/* AC1C48 8004AAA8 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC1C4C 8004AAAC 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1C50 8004AAB0 468092A0 */  cvt.s.w $f10, $f18
/* AC1C54 8004AAB4 C60E00C4 */  lwc1  $f14, 0xc4($s0)
/* AC1C58 8004AAB8 46045182 */  mul.s $f6, $f10, $f4
/* AC1C5C 8004AABC 44063000 */  mfc1  $a2, $f6
/* AC1C60 8004AAC0 0C010E27 */  jal   Camera_LERPCeilF
/* AC1C64 8004AAC4 00000000 */   nop
/* AC1C68 8004AAC8 E60000C4 */  swc1  $f0, 0xc4($s0)
/* AC1C6C 8004AACC 3C0D8016 */  lui   $t5, %hi(gGameInfo) # $t5, 0x8016
/* AC1C70 8004AAD0 8DADFA90 */  lw    $t5, %lo(gGameInfo)($t5)
/* AC1C74 8004AAD4 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* AC1C78 8004AAD8 44816000 */  mtc1  $at, $f12
/* AC1C7C 8004AADC 85AE01C8 */  lh    $t6, 0x1c8($t5)
/* AC1C80 8004AAE0 3C018014 */  lui   $at, %hi(D_80139FAC)
/* AC1C84 8004AAE4 C42A9FAC */  lwc1  $f10, %lo(D_80139FAC)($at)
/* AC1C88 8004AAE8 448E4000 */  mtc1  $t6, $f8
/* AC1C8C 8004AAEC 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC1C90 8004AAF0 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1C94 8004AAF4 468044A0 */  cvt.s.w $f18, $f8
/* AC1C98 8004AAF8 C60E00C0 */  lwc1  $f14, 0xc0($s0)
/* AC1C9C 8004AAFC 460A9102 */  mul.s $f4, $f18, $f10
/* AC1CA0 8004AB00 44062000 */  mfc1  $a2, $f4
/* AC1CA4 8004AB04 0C010E27 */  jal   Camera_LERPCeilF
/* AC1CA8 8004AB08 00000000 */   nop
/* AC1CAC 8004AB0C 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC1CB0 8004AB10 44813000 */  mtc1  $at, $f6
/* AC1CB4 8004AB14 C60800C4 */  lwc1  $f8, 0xc4($s0)
/* AC1CB8 8004AB18 E60000C0 */  swc1  $f0, 0xc0($s0)
/* AC1CBC 8004AB1C 87A500A8 */  lh    $a1, 0xa8($sp)
/* AC1CC0 8004AB20 46083483 */  div.s $f18, $f6, $f8
/* AC1CC4 8004AB24 240401F4 */  li    $a0, 500
/* AC1CC8 8004AB28 2407000A */  li    $a3, 10
/* AC1CCC 8004AB2C 44069000 */  mfc1  $a2, $f18
/* AC1CD0 8004AB30 0C010E47 */  jal   Camera_LERPCeilS
/* AC1CD4 8004AB34 00000000 */   nop
/* AC1CD8 8004AB38 A7A200B8 */  sh    $v0, 0xb8($sp)
/* AC1CDC 8004AB3C 10000006 */  b     .L8004AB58
/* AC1CE0 8004AB40 87A300B8 */   lh    $v1, 0xb8($sp)
/* AC1CE4 8004AB44 44810000 */  mtc1  $at, $f0
.L8004AB48:
/* AC1CE8 8004AB48 00000000 */  nop
/* AC1CEC 8004AB4C E60000C4 */  swc1  $f0, 0xc4($s0)
/* AC1CF0 8004AB50 E60000C0 */  swc1  $f0, 0xc0($s0)
/* AC1CF4 8004AB54 87A300B8 */  lh    $v1, 0xb8($sp)
.L8004AB58:
/* AC1CF8 8004AB58 28612AF9 */  slti  $at, $v1, 0x2af9
/* AC1CFC 8004AB5C 14200002 */  bnez  $at, .L8004AB68
/* AC1D00 8004AB60 27A600B4 */   addiu $a2, $sp, 0xb4
/* AC1D04 8004AB64 24032AF8 */  li    $v1, 11000
.L8004AB68:
/* AC1D08 8004AB68 2861D508 */  slti  $at, $v1, -0x2af8
/* AC1D0C 8004AB6C 10200003 */  beqz  $at, .L8004AB7C
/* AC1D10 8004AB70 A7A300B8 */   sh    $v1, 0xb8($sp)
/* AC1D14 8004AB74 2403D508 */  li    $v1, -11000
/* AC1D18 8004AB78 A7A300B8 */  sh    $v1, 0xb8($sp)
.L8004AB7C:
/* AC1D1C 8004AB7C 8FA40030 */  lw    $a0, 0x30($sp)
/* AC1D20 8004AB80 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC1D24 8004AB84 8FA50034 */   lw    $a1, 0x34($sp)
/* AC1D28 8004AB88 8FAF0030 */  lw    $t7, 0x30($sp)
/* AC1D2C 8004AB8C 27A60060 */  addiu $a2, $sp, 0x60
/* AC1D30 8004AB90 02002025 */  move  $a0, $s0
/* AC1D34 8004AB94 8DEB0000 */  lw    $t3, ($t7)
/* AC1D38 8004AB98 ACCB0000 */  sw    $t3, ($a2)
/* AC1D3C 8004AB9C 8DF80004 */  lw    $t8, 4($t7)
/* AC1D40 8004ABA0 ACD80004 */  sw    $t8, 4($a2)
/* AC1D44 8004ABA4 8DEB0008 */  lw    $t3, 8($t7)
/* AC1D48 8004ABA8 ACCB0008 */  sw    $t3, 8($a2)
/* AC1D4C 8004ABAC 0C010F46 */  jal   func_80043D18
/* AC1D50 8004ABB0 8FA50034 */   lw    $a1, 0x34($sp)
/* AC1D54 8004ABB4 10400030 */  beqz  $v0, .L8004AC78
/* AC1D58 8004ABB8 8FAD0030 */   lw    $t5, 0x30($sp)
/* AC1D5C 8004ABBC 27A40060 */  addiu $a0, $sp, 0x60
/* AC1D60 8004ABC0 8C8D0000 */  lw    $t5, ($a0)
/* AC1D64 8004ABC4 27B900C8 */  addiu $t9, $sp, 0xc8
/* AC1D68 8004ABC8 27A600AC */  addiu $a2, $sp, 0xac
/* AC1D6C 8004ABCC AF2D0000 */  sw    $t5, ($t9)
/* AC1D70 8004ABD0 8C8C0004 */  lw    $t4, 4($a0)
/* AC1D74 8004ABD4 AF2C0004 */  sw    $t4, 4($t9)
/* AC1D78 8004ABD8 8C8D0008 */  lw    $t5, 8($a0)
/* AC1D7C 8004ABDC AF2D0008 */  sw    $t5, 8($t9)
/* AC1D80 8004ABE0 C7AA00B4 */  lwc1  $f10, 0xb4($sp)
/* AC1D84 8004ABE4 87AE00BA */  lh    $t6, 0xba($sp)
/* AC1D88 8004ABE8 A7A000B0 */  sh    $zero, 0xb0($sp)
/* AC1D8C 8004ABEC 8FA50034 */  lw    $a1, 0x34($sp)
/* AC1D90 8004ABF0 E7AA00AC */  swc1  $f10, 0xac($sp)
/* AC1D94 8004ABF4 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC1D98 8004ABF8 A7AE00B2 */   sh    $t6, 0xb2($sp)
/* AC1D9C 8004ABFC 02002025 */  move  $a0, $s0
/* AC1DA0 8004AC00 8FA50034 */  lw    $a1, 0x34($sp)
/* AC1DA4 8004AC04 0C010F46 */  jal   func_80043D18
/* AC1DA8 8004AC08 27A60060 */   addiu $a2, $sp, 0x60
/* AC1DAC 8004AC0C 1040000A */  beqz  $v0, .L8004AC38
/* AC1DB0 8004AC10 00002025 */   move  $a0, $zero
/* AC1DB4 8004AC14 27B800C8 */  addiu $t8, $sp, 0xc8
/* AC1DB8 8004AC18 8F190000 */  lw    $t9, ($t8)
/* AC1DBC 8004AC1C 8FAF0038 */  lw    $t7, 0x38($sp)
/* AC1DC0 8004AC20 ADF90000 */  sw    $t9, ($t7)
/* AC1DC4 8004AC24 8F0B0004 */  lw    $t3, 4($t8)
/* AC1DC8 8004AC28 ADEB0004 */  sw    $t3, 4($t7)
/* AC1DCC 8004AC2C 8F190008 */  lw    $t9, 8($t8)
/* AC1DD0 8004AC30 10000018 */  b     .L8004AC94
/* AC1DD4 8004AC34 ADF90008 */   sw    $t9, 8($t7)
.L8004AC38:
/* AC1DD8 8004AC38 3C063E4C */  lui   $a2, (0x3E4CCCCD >> 16) # lui $a2, 0x3e4c
/* AC1DDC 8004AC3C 34C6CCCD */  ori   $a2, (0x3E4CCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC1DE0 8004AC40 87A500B8 */  lh    $a1, 0xb8($sp)
/* AC1DE4 8004AC44 0C010E47 */  jal   Camera_LERPCeilS
/* AC1DE8 8004AC48 2407000A */   li    $a3, 10
/* AC1DEC 8004AC4C A7A200B8 */  sh    $v0, 0xb8($sp)
/* AC1DF0 8004AC50 8FA40038 */  lw    $a0, 0x38($sp)
/* AC1DF4 8004AC54 8FA50034 */  lw    $a1, 0x34($sp)
/* AC1DF8 8004AC58 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC1DFC 8004AC5C 27A600B4 */   addiu $a2, $sp, 0xb4
/* AC1E00 8004AC60 02002025 */  move  $a0, $s0
/* AC1E04 8004AC64 8FA50034 */  lw    $a1, 0x34($sp)
/* AC1E08 8004AC68 0C010FCD */  jal   func_80043F34
/* AC1E0C 8004AC6C 8FA60038 */   lw    $a2, 0x38($sp)
/* AC1E10 8004AC70 10000009 */  b     .L8004AC98
/* AC1E14 8004AC74 C7A400B4 */   lwc1  $f4, 0xb4($sp)
.L8004AC78:
/* AC1E18 8004AC78 8FAC0038 */  lw    $t4, 0x38($sp)
/* AC1E1C 8004AC7C 8DAF0000 */  lw    $t7, ($t5)
/* AC1E20 8004AC80 AD8F0000 */  sw    $t7, ($t4)
/* AC1E24 8004AC84 8DAE0004 */  lw    $t6, 4($t5)
/* AC1E28 8004AC88 AD8E0004 */  sw    $t6, 4($t4)
/* AC1E2C 8004AC8C 8DAF0008 */  lw    $t7, 8($t5)
/* AC1E30 8004AC90 AD8F0008 */  sw    $t7, 8($t4)
.L8004AC94:
/* AC1E34 8004AC94 C7A400B4 */  lwc1  $f4, 0xb4($sp)
.L8004AC98:
/* AC1E38 8004AC98 C60C0018 */  lwc1  $f12, 0x18($s0)
/* AC1E3C 8004AC9C C60E00FC */  lwc1  $f14, 0xfc($s0)
/* AC1E40 8004ACA0 8E0600D4 */  lw    $a2, 0xd4($s0)
/* AC1E44 8004ACA4 3C073F80 */  lui   $a3, 0x3f80
/* AC1E48 8004ACA8 0C010E27 */  jal   Camera_LERPCeilF
/* AC1E4C 8004ACAC E60400DC */   swc1  $f4, 0xdc($s0)
/* AC1E50 8004ACB0 E60000FC */  swc1  $f0, 0xfc($s0)
/* AC1E54 8004ACB4 00002025 */  move  $a0, $zero
/* AC1E58 8004ACB8 8605015A */  lh    $a1, 0x15a($s0)
/* AC1E5C 8004ACBC 3C063F00 */  lui   $a2, 0x3f00
/* AC1E60 8004ACC0 0C010E47 */  jal   Camera_LERPCeilS
/* AC1E64 8004ACC4 2407000A */   li    $a3, 10
/* AC1E68 8004ACC8 A602015A */  sh    $v0, 0x15a($s0)
/* AC1E6C 8004ACCC 8FBF001C */  lw    $ra, 0x1c($sp)
/* AC1E70 8004ACD0 8FB00018 */  lw    $s0, 0x18($sp)
/* AC1E74 8004ACD4 27BD00E0 */  addiu $sp, $sp, 0xe0
/* AC1E78 8004ACD8 03E00008 */  jr    $ra
/* AC1E7C 8004ACDC 24020001 */   li    $v0, 1
