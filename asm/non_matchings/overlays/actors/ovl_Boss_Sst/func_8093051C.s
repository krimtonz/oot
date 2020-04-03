glabel func_8093051C
/* 03F4C 8093051C 27BDFFC0 */  addiu   $sp, $sp, 0xFFC0           ## $sp = FFFFFFC0
/* 03F50 80930520 AFB00020 */  sw      $s0, 0x0020($sp)
/* 03F54 80930524 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 03F58 80930528 AFBF0024 */  sw      $ra, 0x0024($sp)
/* 03F5C 8093052C 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 03F60 80930530 AFA50044 */  sw      $a1, 0x0044($sp)
/* 03F64 80930534 0C02927F */  jal     SkelAnime_FrameUpdateMatrix

/* 03F68 80930538 AFA4002C */  sw      $a0, 0x002C($sp)
/* 03F6C 8093053C 3C014248 */  lui     $at, 0x4248                ## $at = 42480000
/* 03F70 80930540 44811000 */  mtc1    $at, $f2                   ## $f2 = 50.00
/* 03F74 80930544 3C018093 */  lui     $at, %hi(D_809379E8)       ## $at = 80930000
/* 03F78 80930548 C42679E8 */  lwc1    $f6, %lo(D_809379E8)($at)
/* 03F7C 8093054C C6040068 */  lwc1    $f4, 0x0068($s0)           ## 00000068
/* 03F80 80930550 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 03F84 80930554 44815000 */  mtc1    $at, $f10                  ## $f10 = 1.00
/* 03F88 80930558 46062202 */  mul.s   $f8, $f4, $f6
/* 03F8C 8093055C 3C063E99 */  lui     $a2, 0x3E99                ## $a2 = 3E990000
/* 03F90 80930560 34C6999A */  ori     $a2, $a2, 0x999A           ## $a2 = 3E99999A
/* 03F94 80930564 26040024 */  addiu   $a0, $s0, 0x0024           ## $a0 = 00000024
/* 03F98 80930568 E6080068 */  swc1    $f8, 0x0068($s0)           ## 00000068
/* 03F9C 8093056C C6000068 */  lwc1    $f0, 0x0068($s0)           ## 00000068
/* 03FA0 80930570 4600103C */  c.lt.s  $f2, $f0
/* 03FA4 80930574 00000000 */  nop
/* 03FA8 80930578 45020004 */  bc1fl   .L8093058C
/* 03FAC 8093057C E6000068 */  swc1    $f0, 0x0068($s0)           ## 00000068
/* 03FB0 80930580 10000002 */  beq     $zero, $zero, .L8093058C
/* 03FB4 80930584 E6020068 */  swc1    $f2, 0x0068($s0)           ## 00000068
/* 03FB8 80930588 E6000068 */  swc1    $f0, 0x0068($s0)           ## 00000068
.L8093058C:
/* 03FBC 8093058C 8E050008 */  lw      $a1, 0x0008($s0)           ## 00000008
/* 03FC0 80930590 8E070068 */  lw      $a3, 0x0068($s0)           ## 00000068
/* 03FC4 80930594 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF

/* 03FC8 80930598 E7AA0010 */  swc1    $f10, 0x0010($sp)
/* 03FCC 8093059C E7A0003C */  swc1    $f0, 0x003C($sp)
/* 03FD0 809305A0 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 03FD4 809305A4 44818000 */  mtc1    $at, $f16                  ## $f16 = 1.00
/* 03FD8 809305A8 8E070068 */  lw      $a3, 0x0068($s0)           ## 00000068
/* 03FDC 809305AC 8E050010 */  lw      $a1, 0x0010($s0)           ## 00000010
/* 03FE0 809305B0 3C063E99 */  lui     $a2, 0x3E99                ## $a2 = 3E990000
/* 03FE4 809305B4 34C6999A */  ori     $a2, $a2, 0x999A           ## $a2 = 3E99999A
/* 03FE8 809305B8 2604002C */  addiu   $a0, $s0, 0x002C           ## $a0 = 0000002C
/* 03FEC 809305BC 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF

/* 03FF0 809305C0 E7B00010 */  swc1    $f16, 0x0010($sp)
/* 03FF4 809305C4 C7B2003C */  lwc1    $f18, 0x003C($sp)
/* 03FF8 809305C8 260400B6 */  addiu   $a0, $s0, 0x00B6           ## $a0 = 000000B6
/* 03FFC 809305CC 24060200 */  addiu   $a2, $zero, 0x0200         ## $a2 = 00000200
/* 04000 809305D0 46009100 */  add.s   $f4, $f18, $f0
/* 04004 809305D4 E7A4003C */  swc1    $f4, 0x003C($sp)
/* 04008 809305D8 86020198 */  lh      $v0, 0x0198($s0)           ## 00000198
/* 0400C 809305DC 10400028 */  beq     $v0, $zero, .L80930680
/* 04010 809305E0 00000000 */  nop
/* 04014 809305E4 10400003 */  beq     $v0, $zero, .L809305F4
/* 04018 809305E8 244EFFFF */  addiu   $t6, $v0, 0xFFFF           ## $t6 = FFFFFFFF
/* 0401C 809305EC A60E0198 */  sh      $t6, 0x0198($s0)           ## 00000198
/* 04020 809305F0 86020198 */  lh      $v0, 0x0198($s0)           ## 00000198
.L809305F4:
/* 04024 809305F4 44823000 */  mtc1    $v0, $f6                   ## $f6 = 0.00
/* 04028 809305F8 3C018093 */  lui     $at, %hi(D_809379EC)       ## $at = 80930000
/* 0402C 809305FC C42A79EC */  lwc1    $f10, %lo(D_809379EC)($at)
/* 04030 80930600 46803220 */  cvt.s.w $f8, $f6
/* 04034 80930604 3C013D80 */  lui     $at, 0x3D80                ## $at = 3D800000
/* 04038 80930608 44819000 */  mtc1    $at, $f18                  ## $f18 = 0.06
/* 0403C 8093060C 460A4402 */  mul.s   $f16, $f8, $f10
/* 04040 80930610 00000000 */  nop
/* 04044 80930614 46128302 */  mul.s   $f12, $f16, $f18
/* 04048 80930618 0C0400A4 */  jal     sinf

/* 0404C 8093061C 00000000 */  nop
/* 04050 80930620 3C01437A */  lui     $at, 0x437A                ## $at = 437A0000
/* 04054 80930624 44812000 */  mtc1    $at, $f4                   ## $f4 = 250.00
/* 04058 80930628 C608000C */  lwc1    $f8, 0x000C($s0)           ## 0000000C
/* 0405C 8093062C 86020198 */  lh      $v0, 0x0198($s0)           ## 00000198
/* 04060 80930630 46040182 */  mul.s   $f6, $f0, $f4
/* 04064 80930634 24010004 */  addiu   $at, $zero, 0x0004         ## $at = 00000004
/* 04068 80930638 46083280 */  add.s   $f10, $f6, $f8
/* 0406C 8093063C 14400005 */  bne     $v0, $zero, .L80930654
/* 04070 80930640 E60A0028 */  swc1    $f10, 0x0028($s0)          ## 00000028
/* 04074 80930644 0C24BEF9 */  jal     func_8092FBE4
/* 04078 80930648 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 0407C 8093064C 1000003A */  beq     $zero, $zero, .L80930738
/* 04080 80930650 8FBF0024 */  lw      $ra, 0x0024($sp)
.L80930654:
/* 04084 80930654 14410037 */  bne     $v0, $at, .L80930734
/* 04088 80930658 8FA4002C */  lw      $a0, 0x002C($sp)
/* 0408C 8093065C 860F001C */  lh      $t7, 0x001C($s0)           ## 0000001C
/* 04090 80930660 3C058093 */  lui     $a1, %hi(D_8093784C)       ## $a1 = 80930000
/* 04094 80930664 3C064080 */  lui     $a2, 0x4080                ## $a2 = 40800000
/* 04098 80930668 000FC080 */  sll     $t8, $t7,  2
/* 0409C 8093066C 00B82821 */  addu    $a1, $a1, $t8
/* 040A0 80930670 0C0294D3 */  jal     SkelAnime_ChangeAnimTransitionRepeat
/* 040A4 80930674 8CA5784C */  lw      $a1, %lo(D_8093784C)($a1)
/* 040A8 80930678 1000002F */  beq     $zero, $zero, .L80930738
/* 040AC 8093067C 8FBF0024 */  lw      $ra, 0x0024($sp)
.L80930680:
/* 040B0 80930680 0C01DE2B */  jal     Math_ApproxUpdateScaledS

/* 040B4 80930684 86050016 */  lh      $a1, 0x0016($s0)           ## 00000016
/* 040B8 80930688 AFA20038 */  sw      $v0, 0x0038($sp)
/* 040BC 8093068C 86050018 */  lh      $a1, 0x0018($s0)           ## 00000018
/* 040C0 80930690 260400B8 */  addiu   $a0, $s0, 0x00B8           ## $a0 = 000000B8
/* 040C4 80930694 0C01DE2B */  jal     Math_ApproxUpdateScaledS

/* 040C8 80930698 24060200 */  addiu   $a2, $zero, 0x0200         ## $a2 = 00000200
/* 040CC 8093069C 8FB90038 */  lw      $t9, 0x0038($sp)
/* 040D0 809306A0 260401A0 */  addiu   $a0, $s0, 0x01A0           ## $a0 = 000001A0
/* 040D4 809306A4 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 040D8 809306A8 03224024 */  and     $t0, $t9, $v0
/* 040DC 809306AC AFA80038 */  sw      $t0, 0x0038($sp)
/* 040E0 809306B0 0C01DE2B */  jal     Math_ApproxUpdateScaledS

/* 040E4 809306B4 24060800 */  addiu   $a2, $zero, 0x0800         ## $a2 = 00000800
/* 040E8 809306B8 8FA90038 */  lw      $t1, 0x0038($sp)
/* 040EC 809306BC 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 040F0 809306C0 24053167 */  addiu   $a1, $zero, 0x3167         ## $a1 = 00003167
/* 040F4 809306C4 01225024 */  and     $t2, $t1, $v0
/* 040F8 809306C8 0C00BE5D */  jal     func_8002F974
/* 040FC 809306CC AFAA0038 */  sw      $t2, 0x0038($sp)
/* 04100 809306D0 3C0140A0 */  lui     $at, 0x40A0                ## $at = 40A00000
/* 04104 809306D4 44818000 */  mtc1    $at, $f16                  ## $f16 = 5.00
/* 04108 809306D8 26040028 */  addiu   $a0, $s0, 0x0028           ## $a0 = 00000028
/* 0410C 809306DC 3C05437A */  lui     $a1, 0x437A                ## $a1 = 437A0000
/* 04110 809306E0 3C063F00 */  lui     $a2, 0x3F00                ## $a2 = 3F000000
/* 04114 809306E4 3C07428C */  lui     $a3, 0x428C                ## $a3 = 428C0000
/* 04118 809306E8 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF

/* 0411C 809306EC E7B00010 */  swc1    $f16, 0x0010($sp)
/* 04120 809306F0 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 04124 809306F4 44819000 */  mtc1    $at, $f18                  ## $f18 = 1.00
/* 04128 809306F8 8FAB0038 */  lw      $t3, 0x0038($sp)
/* 0412C 809306FC 4612003C */  c.lt.s  $f0, $f18
/* 04130 80930700 00000000 */  nop
/* 04134 80930704 4502000C */  bc1fl   .L80930738
/* 04138 80930708 8FBF0024 */  lw      $ra, 0x0024($sp)
/* 0413C 8093070C 11600009 */  beq     $t3, $zero, .L80930734
/* 04140 80930710 C7A4003C */  lwc1    $f4, 0x003C($sp)
/* 04144 80930714 3C014120 */  lui     $at, 0x4120                ## $at = 41200000
/* 04148 80930718 44813000 */  mtc1    $at, $f6                   ## $f6 = 10.00
/* 0414C 8093071C 240C0008 */  addiu   $t4, $zero, 0x0008         ## $t4 = 00000008
/* 04150 80930720 4606203C */  c.lt.s  $f4, $f6
/* 04154 80930724 00000000 */  nop
/* 04158 80930728 45020003 */  bc1fl   .L80930738
/* 0415C 8093072C 8FBF0024 */  lw      $ra, 0x0024($sp)
/* 04160 80930730 A60C0198 */  sh      $t4, 0x0198($s0)           ## 00000198
.L80930734:
/* 04164 80930734 8FBF0024 */  lw      $ra, 0x0024($sp)
.L80930738:
/* 04168 80930738 8FB00020 */  lw      $s0, 0x0020($sp)
/* 0416C 8093073C 27BD0040 */  addiu   $sp, $sp, 0x0040           ## $sp = 00000000
/* 04170 80930740 03E00008 */  jr      $ra
/* 04174 80930744 00000000 */  nop


