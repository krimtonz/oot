glabel func_80918D6C
/* 0335C 80918D6C 27BDFFC0 */  addiu   $sp, $sp, 0xFFC0           ## $sp = FFFFFFC0
/* 03360 80918D70 AFBF002C */  sw      $ra, 0x002C($sp)
/* 03364 80918D74 AFB00028 */  sw      $s0, 0x0028($sp)
/* 03368 80918D78 AFA50044 */  sw      $a1, 0x0044($sp)
/* 0336C 80918D7C 8C8E0004 */  lw      $t6, 0x0004($a0)           ## 00000004
/* 03370 80918D80 3C010100 */  lui     $at, 0x0100                ## $at = 01000000
/* 03374 80918D84 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 03378 80918D88 01C17825 */  or      $t7, $t6, $at              ## $t7 = 01000000
/* 0337C 80918D8C AC8F0004 */  sw      $t7, 0x0004($a0)           ## 00000004
/* 03380 80918D90 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 03384 80918D94 0C02927F */  jal     SkelAnime_FrameUpdateMatrix

/* 03388 80918D98 AFA40030 */  sw      $a0, 0x0030($sp)
/* 0338C 80918D9C 860301D0 */  lh      $v1, 0x01D0($s0)           ## 000001D0
/* 03390 80918DA0 24010001 */  addiu   $at, $zero, 0x0001         ## $at = 00000001
/* 03394 80918DA4 3C054120 */  lui     $a1, 0x4120                ## $a1 = 41200000
/* 03398 80918DA8 50600009 */  beql    $v1, $zero, .L80918DD0
/* 0339C 80918DAC 8E0307D4 */  lw      $v1, 0x07D4($s0)           ## 000007D4
/* 033A0 80918DB0 10610051 */  beq     $v1, $at, .L80918EF8
/* 033A4 80918DB4 8FA40030 */  lw      $a0, 0x0030($sp)
/* 033A8 80918DB8 24010002 */  addiu   $at, $zero, 0x0002         ## $at = 00000002
/* 033AC 80918DBC 1061006B */  beq     $v1, $at, .L80918F6C
/* 033B0 80918DC0 3C040600 */  lui     $a0, 0x0600                ## $a0 = 06000000
/* 033B4 80918DC4 10000076 */  beq     $zero, $zero, .L80918FA0
/* 033B8 80918DC8 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
/* 033BC 80918DCC 8E0307D4 */  lw      $v1, 0x07D4($s0)           ## 000007D4
.L80918DD0:
/* 033C0 80918DD0 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
/* 033C4 80918DD4 240A000A */  addiu   $t2, $zero, 0x000A         ## $t2 = 0000000A
/* 033C8 80918DD8 1860000F */  blez    $v1, .L80918E18
/* 033CC 80918DDC 00000000 */  nop
/* 033D0 80918DE0 8E0407D8 */  lw      $a0, 0x07D8($s0)           ## 000007D8
/* 033D4 80918DE4 0002C180 */  sll     $t8, $v0,  6
.L80918DE8:
/* 033D8 80918DE8 0098C821 */  addu    $t9, $a0, $t8
/* 033DC 80918DEC 93280015 */  lbu     $t0, 0x0015($t9)           ## 00000015
/* 033E0 80918DF0 24420001 */  addiu   $v0, $v0, 0x0001           ## $v0 = 00000001
/* 033E4 80918DF4 00021400 */  sll     $v0, $v0, 16
/* 033E8 80918DF8 31090002 */  andi    $t1, $t0, 0x0002           ## $t1 = 00000000
/* 033EC 80918DFC 11200003 */  beq     $t1, $zero, .L80918E0C
/* 033F0 80918E00 00021403 */  sra     $v0, $v0, 16
/* 033F4 80918E04 10000004 */  beq     $zero, $zero, .L80918E18
/* 033F8 80918E08 A60A01D2 */  sh      $t2, 0x01D2($s0)           ## 000001D2
.L80918E0C:
/* 033FC 80918E0C 0043082A */  slt     $at, $v0, $v1
/* 03400 80918E10 5420FFF5 */  bnel    $at, $zero, .L80918DE8
/* 03404 80918E14 0002C180 */  sll     $t8, $v0,  6
.L80918E18:
/* 03408 80918E18 0C0295B2 */  jal     SkelAnime_FrameTest
/* 0340C 80918E1C 8FA40030 */  lw      $a0, 0x0030($sp)
/* 03410 80918E20 1040000A */  beq     $v0, $zero, .L80918E4C
/* 03414 80918E24 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 03418 80918E28 8FA50044 */  lw      $a1, 0x0044($sp)
/* 0341C 80918E2C 24060003 */  addiu   $a2, $zero, 0x0003         ## $a2 = 00000003
/* 03420 80918E30 0C24577E */  jal     func_80915DF8
/* 03424 80918E34 24070005 */  addiu   $a3, $zero, 0x0005         ## $a3 = 00000005
/* 03428 80918E38 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 0342C 80918E3C 8FA50044 */  lw      $a1, 0x0044($sp)
/* 03430 80918E40 24060005 */  addiu   $a2, $zero, 0x0005         ## $a2 = 00000005
/* 03434 80918E44 0C00CFA2 */  jal     func_80033E88
/* 03438 80918E48 2407000F */  addiu   $a3, $zero, 0x000F         ## $a3 = 0000000F
.L80918E4C:
/* 0343C 80918E4C 3C040600 */  lui     $a0, 0x0600                ## $a0 = 06000000
/* 03440 80918E50 0C028800 */  jal     SkelAnime_GetFrameCount

/* 03444 80918E54 24844318 */  addiu   $a0, $a0, 0x4318           ## $a0 = 06004318
/* 03448 80918E58 44822000 */  mtc1    $v0, $f4                   ## $f4 = 0.00
/* 0344C 80918E5C 8FA40030 */  lw      $a0, 0x0030($sp)
/* 03450 80918E60 46802120 */  cvt.s.w $f4, $f4
/* 03454 80918E64 44052000 */  mfc1    $a1, $f4
/* 03458 80918E68 0C0295B2 */  jal     SkelAnime_FrameTest
/* 0345C 80918E6C 00000000 */  nop
/* 03460 80918E70 1040004A */  beq     $v0, $zero, .L80918F9C
/* 03464 80918E74 240B0001 */  addiu   $t3, $zero, 0x0001         ## $t3 = 00000001
/* 03468 80918E78 3C040600 */  lui     $a0, 0x0600                ## $a0 = 06000000
/* 0346C 80918E7C A60B01D0 */  sh      $t3, 0x01D0($s0)           ## 000001D0
/* 03470 80918E80 0C028800 */  jal     SkelAnime_GetFrameCount

/* 03474 80918E84 24844A20 */  addiu   $a0, $a0, 0x4A20           ## $a0 = 06004A20
/* 03478 80918E88 44823000 */  mtc1    $v0, $f6                   ## $f6 = 0.00
/* 0347C 80918E8C 3C01BF80 */  lui     $at, 0xBF80                ## $at = BF800000
/* 03480 80918E90 44815000 */  mtc1    $at, $f10                  ## $f10 = -1.00
/* 03484 80918E94 46803220 */  cvt.s.w $f8, $f6
/* 03488 80918E98 3C050600 */  lui     $a1, 0x0600                ## $a1 = 06000000
/* 0348C 80918E9C 24A54A20 */  addiu   $a1, $a1, 0x4A20           ## $a1 = 06004A20
/* 03490 80918EA0 8FA40030 */  lw      $a0, 0x0030($sp)
/* 03494 80918EA4 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 03498 80918EA8 24070000 */  addiu   $a3, $zero, 0x0000         ## $a3 = 00000000
/* 0349C 80918EAC E7A80010 */  swc1    $f8, 0x0010($sp)
/* 034A0 80918EB0 AFA00014 */  sw      $zero, 0x0014($sp)
/* 034A4 80918EB4 0C029468 */  jal     SkelAnime_ChangeAnim

/* 034A8 80918EB8 E7AA0018 */  swc1    $f10, 0x0018($sp)
/* 034AC 80918EBC 860C01D2 */  lh      $t4, 0x01D2($s0)           ## 000001D2
/* 034B0 80918EC0 55800037 */  bnel    $t4, $zero, .L80918FA0
/* 034B4 80918EC4 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
/* 034B8 80918EC8 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 034BC 80918ECC 00000000 */  nop
/* 034C0 80918ED0 3C0141F0 */  lui     $at, 0x41F0                ## $at = 41F00000
/* 034C4 80918ED4 44818000 */  mtc1    $at, $f16                  ## $f16 = 30.00
/* 034C8 80918ED8 00000000 */  nop
/* 034CC 80918EDC 46100482 */  mul.s   $f18, $f0, $f16
/* 034D0 80918EE0 4600910D */  trunc.w.s $f4, $f18
/* 034D4 80918EE4 44182000 */  mfc1    $t8, $f4
/* 034D8 80918EE8 00000000 */  nop
/* 034DC 80918EEC 2719001E */  addiu   $t9, $t8, 0x001E           ## $t9 = 0000001E
/* 034E0 80918EF0 1000002A */  beq     $zero, $zero, .L80918F9C
/* 034E4 80918EF4 A61901D4 */  sh      $t9, 0x01D4($s0)           ## 000001D4
.L80918EF8:
/* 034E8 80918EF8 0C0295B2 */  jal     SkelAnime_FrameTest
/* 034EC 80918EFC 3C054040 */  lui     $a1, 0x4040                ## $a1 = 40400000
/* 034F0 80918F00 10400003 */  beq     $v0, $zero, .L80918F10
/* 034F4 80918F04 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 034F8 80918F08 0C00BE0A */  jal     Audio_PlayActorSound2

/* 034FC 80918F0C 2405381D */  addiu   $a1, $zero, 0x381D         ## $a1 = 0000381D
.L80918F10:
/* 03500 80918F10 860801D4 */  lh      $t0, 0x01D4($s0)           ## 000001D4
/* 03504 80918F14 3C040600 */  lui     $a0, 0x0600                ## $a0 = 06000000
/* 03508 80918F18 24090002 */  addiu   $t1, $zero, 0x0002         ## $t1 = 00000002
/* 0350C 80918F1C 1500001F */  bne     $t0, $zero, .L80918F9C
/* 03510 80918F20 24845330 */  addiu   $a0, $a0, 0x5330           ## $a0 = 06005330
/* 03514 80918F24 0C028800 */  jal     SkelAnime_GetFrameCount

/* 03518 80918F28 A60901D0 */  sh      $t1, 0x01D0($s0)           ## 000001D0
/* 0351C 80918F2C 44823000 */  mtc1    $v0, $f6                   ## $f6 = 0.00
/* 03520 80918F30 3C01C0A0 */  lui     $at, 0xC0A0                ## $at = C0A00000
/* 03524 80918F34 44815000 */  mtc1    $at, $f10                  ## $f10 = -5.00
/* 03528 80918F38 46803220 */  cvt.s.w $f8, $f6
/* 0352C 80918F3C 3C050600 */  lui     $a1, 0x0600                ## $a1 = 06000000
/* 03530 80918F40 240A0002 */  addiu   $t2, $zero, 0x0002         ## $t2 = 00000002
/* 03534 80918F44 AFAA0014 */  sw      $t2, 0x0014($sp)
/* 03538 80918F48 24A55330 */  addiu   $a1, $a1, 0x5330           ## $a1 = 06005330
/* 0353C 80918F4C 8FA40030 */  lw      $a0, 0x0030($sp)
/* 03540 80918F50 E7A80010 */  swc1    $f8, 0x0010($sp)
/* 03544 80918F54 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 03548 80918F58 24070000 */  addiu   $a3, $zero, 0x0000         ## $a3 = 00000000
/* 0354C 80918F5C 0C029468 */  jal     SkelAnime_ChangeAnim

/* 03550 80918F60 E7AA0018 */  swc1    $f10, 0x0018($sp)
/* 03554 80918F64 1000000E */  beq     $zero, $zero, .L80918FA0
/* 03558 80918F68 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
.L80918F6C:
/* 0355C 80918F6C 0C028800 */  jal     SkelAnime_GetFrameCount

/* 03560 80918F70 24845330 */  addiu   $a0, $a0, 0x5330           ## $a0 = 00005330
/* 03564 80918F74 44828000 */  mtc1    $v0, $f16                  ## $f16 = 0.00
/* 03568 80918F78 8FA40030 */  lw      $a0, 0x0030($sp)
/* 0356C 80918F7C 46808420 */  cvt.s.w $f16, $f16
/* 03570 80918F80 44058000 */  mfc1    $a1, $f16
/* 03574 80918F84 0C0295B2 */  jal     SkelAnime_FrameTest
/* 03578 80918F88 00000000 */  nop
/* 0357C 80918F8C 50400004 */  beql    $v0, $zero, .L80918FA0
/* 03580 80918F90 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
/* 03584 80918F94 0C245829 */  jal     func_809160A4
/* 03588 80918F98 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
.L80918F9C:
/* 0358C 80918F9C 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
.L80918FA0:
/* 03590 80918FA0 A60B01B4 */  sh      $t3, 0x01B4($s0)           ## 000001B4
/* 03594 80918FA4 A60001B8 */  sh      $zero, 0x01B8($s0)         ## 000001B8
/* 03598 80918FA8 8FBF002C */  lw      $ra, 0x002C($sp)
/* 0359C 80918FAC 8FB00028 */  lw      $s0, 0x0028($sp)
/* 035A0 80918FB0 27BD0040 */  addiu   $sp, $sp, 0x0040           ## $sp = 00000000
/* 035A4 80918FB4 03E00008 */  jr      $ra
/* 035A8 80918FB8 00000000 */  nop
