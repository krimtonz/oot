.rdata
glabel D_8013938C
    .asciz "\x1B[43;30mcamera: warning: talk: target is not valid, change normal camera\n\x1B[m"
    .balign 4

.late_rodata
glabel D_8013A160
    .float 0.01

glabel D_8013A164
    .float 0.01

glabel D_8013A168
    .float 0.01

.text
glabel Camera_KeepOn0
/* AC6544 8004F3A4 27BDFF90 */  addiu $sp, $sp, -0x70
/* AC6548 8004F3A8 AFBF001C */  sw    $ra, 0x1c($sp)
/* AC654C 8004F3AC AFB00018 */  sw    $s0, 0x18($sp)
/* AC6550 8004F3B0 848E014C */  lh    $t6, 0x14c($a0)
/* AC6554 8004F3B4 8483015E */  lh    $v1, 0x15e($a0)
/* AC6558 8004F3B8 00808025 */  move  $s0, $a0
/* AC655C 8004F3BC 31CFFFEF */  andi  $t7, $t6, 0xffef
/* AC6560 8004F3C0 1060000A */  beqz  $v1, .L8004F3EC
/* AC6564 8004F3C4 A48F014C */   sh    $t7, 0x14c($a0)
/* AC6568 8004F3C8 2401000A */  li    $at, 10
/* AC656C 8004F3CC 10610007 */  beq   $v1, $at, .L8004F3EC
/* AC6570 8004F3D0 24010014 */   li    $at, 20
/* AC6574 8004F3D4 10610005 */  beq   $v1, $at, .L8004F3EC
/* AC6578 8004F3D8 3C188016 */   lui   $t8, %hi(gGameInfo) # $t8, 0x8016
/* AC657C 8004F3DC 8F18FA90 */  lw    $t8, %lo(gGameInfo)($t8)
/* AC6580 8004F3E0 87030314 */  lh    $v1, 0x314($t8)
/* AC6584 8004F3E4 10600022 */  beqz  $v1, .L8004F470
/* AC6588 8004F3E8 00000000 */   nop
.L8004F3EC:
/* AC658C 8004F3EC 86190142 */  lh    $t9, 0x142($s0)
/* AC6590 8004F3F0 3C0A8012 */  lui   $t2, %hi(sCameraSettings)
/* AC6594 8004F3F4 860B0144 */  lh    $t3, 0x144($s0)
/* AC6598 8004F3F8 001948C0 */  sll   $t1, $t9, 3
/* AC659C 8004F3FC 01495021 */  addu  $t2, $t2, $t1
/* AC65A0 8004F400 8D4AD068 */  lw    $t2, %lo(sCameraSettings+4)($t2)
/* AC65A4 8004F404 000B60C0 */  sll   $t4, $t3, 3
/* AC65A8 8004F408 3C018014 */  lui   $at, %hi(D_8013A160)
/* AC65AC 8004F40C 014C6821 */  addu  $t5, $t2, $t4
/* AC65B0 8004F410 8DA20004 */  lw    $v0, 4($t5)
/* AC65B4 8004F414 C428A160 */  lwc1  $f8, %lo(D_8013A160)($at)
/* AC65B8 8004F418 3C018014 */  lui   $at, %hi(D_8013A164)
/* AC65BC 8004F41C 844E0000 */  lh    $t6, ($v0)
/* AC65C0 8004F420 3C098016 */  lui   $t1, %hi(gGameInfo)
/* AC65C4 8004F424 2442000C */  addiu $v0, $v0, 0xc
/* AC65C8 8004F428 448E2000 */  mtc1  $t6, $f4
/* AC65CC 8004F42C 00000000 */  nop
/* AC65D0 8004F430 468021A0 */  cvt.s.w $f6, $f4
/* AC65D4 8004F434 46083282 */  mul.s $f10, $f6, $f8
/* AC65D8 8004F438 E60A0000 */  swc1  $f10, ($s0)
/* AC65DC 8004F43C 844FFFF8 */  lh    $t7, -8($v0)
/* AC65E0 8004F440 C424A164 */  lwc1  $f4, %lo(D_8013A164)($at)
/* AC65E4 8004F444 448F8000 */  mtc1  $t7, $f16
/* AC65E8 8004F448 00000000 */  nop
/* AC65EC 8004F44C 468084A0 */  cvt.s.w $f18, $f16
/* AC65F0 8004F450 46049182 */  mul.s $f6, $f18, $f4
/* AC65F4 8004F454 E6060004 */  swc1  $f6, 4($s0)
/* AC65F8 8004F458 8458FFFC */  lh    $t8, -4($v0)
/* AC65FC 8004F45C A6180008 */  sh    $t8, 8($s0)
/* AC6600 8004F460 84590000 */  lh    $t9, ($v0)
/* AC6604 8004F464 A619000A */  sh    $t9, 0xa($s0)
/* AC6608 8004F468 8D29FA90 */  lw    $t1, %lo(gGameInfo)($t1)
/* AC660C 8004F46C 85230314 */  lh    $v1, 0x314($t1)
.L8004F470:
/* AC6610 8004F470 10600003 */  beqz  $v1, .L8004F480
/* AC6614 8004F474 00000000 */   nop
/* AC6618 8004F478 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC661C 8004F47C 02002025 */   move  $a0, $s0
.L8004F480:
/* AC6620 8004F480 0C0111DB */  jal   func_8004476C
/* AC6624 8004F484 02002025 */   move  $a0, $s0
/* AC6628 8004F488 26040074 */  addiu $a0, $s0, 0x74
/* AC662C 8004F48C AFA4002C */  sw    $a0, 0x2c($sp)
/* AC6630 8004F490 00402825 */  move  $a1, $v0
/* AC6634 8004F494 0C010EF1 */  jal   Camera_Vec3sToVec3f
/* AC6638 8004F498 AFA20044 */   sw    $v0, 0x44($sp)
/* AC663C 8004F49C 8FA4002C */  lw    $a0, 0x2c($sp)
/* AC6640 8004F4A0 8FA30044 */  lw    $v1, 0x44($sp)
/* AC6644 8004F4A4 2606005C */  addiu $a2, $s0, 0x5c
/* AC6648 8004F4A8 8C8A0000 */  lw    $t2, ($a0)
/* AC664C 8004F4AC 27AC003C */  addiu $t4, $sp, 0x3c
/* AC6650 8004F4B0 2401FFFF */  li    $at, -1
/* AC6654 8004F4B4 ACCA0000 */  sw    $t2, ($a2)
/* AC6658 8004F4B8 8C8B0004 */  lw    $t3, 4($a0)
/* AC665C 8004F4BC ACCB0004 */  sw    $t3, 4($a2)
/* AC6660 8004F4C0 8C8A0008 */  lw    $t2, 8($a0)
/* AC6664 8004F4C4 ACCA0008 */  sw    $t2, 8($a2)
/* AC6668 8004F4C8 886E0006 */  lwl   $t6, 6($v1)
/* AC666C 8004F4CC 986E0009 */  lwr   $t6, 9($v1)
/* AC6670 8004F4D0 AD8E0000 */  sw    $t6, ($t4)
/* AC6674 8004F4D4 946E000A */  lhu   $t6, 0xa($v1)
/* AC6678 8004F4D8 A58E0004 */  sh    $t6, 4($t4)
/* AC667C 8004F4DC 8467000C */  lh    $a3, 0xc($v1)
/* AC6680 8004F4E0 54E10003 */  bnel  $a3, $at, .L8004F4F0
/* AC6684 8004F4E4 8E0500A8 */   lw    $a1, 0xa8($s0)
/* AC6688 8004F4E8 24071770 */  li    $a3, 6000
/* AC668C 8004F4EC 8E0500A8 */  lw    $a1, 0xa8($s0)
.L8004F4F0:
/* AC6690 8004F4F0 10A00005 */  beqz  $a1, .L8004F508
/* AC6694 8004F4F4 00000000 */   nop
/* AC6698 8004F4F8 8CAF0130 */  lw    $t7, 0x130($a1)
/* AC669C 8004F4FC 260400AC */  addiu $a0, $s0, 0xac
/* AC66A0 8004F500 55E0000C */  bnezl $t7, .L8004F534
/* AC66A4 8004F504 AFA40028 */   sw    $a0, 0x28($sp)
.L8004F508:
/* AC66A8 8004F508 14A00003 */  bnez  $a1, .L8004F518
/* AC66AC 8004F50C 3C048014 */   lui   $a0, %hi(D_8013938C) # $a0, 0x8014
/* AC66B0 8004F510 0C00084C */  jal   osSyncPrintf
/* AC66B4 8004F514 2484938C */   addiu $a0, %lo(D_8013938C) # addiu $a0, $a0, -0x6c74
.L8004F518:
/* AC66B8 8004F518 AE0000A8 */  sw    $zero, 0xa8($s0)
/* AC66BC 8004F51C 02002025 */  move  $a0, $s0
/* AC66C0 8004F520 0C016911 */  jal   Camera_ChangeModeDefaultFlags
/* AC66C4 8004F524 00002825 */   move  $a1, $zero
/* AC66C8 8004F528 10000059 */  b     .L8004F690
/* AC66CC 8004F52C 24020001 */   li    $v0, 1
/* AC66D0 8004F530 AFA40028 */  sw    $a0, 0x28($sp)
.L8004F534:
/* AC66D4 8004F534 AFA60030 */  sw    $a2, 0x30($sp)
/* AC66D8 8004F538 0C00BBB9 */  jal   func_8002EEE4
/* AC66DC 8004F53C A7A7003A */   sh    $a3, 0x3a($sp)
/* AC66E0 8004F540 26060050 */  addiu $a2, $s0, 0x50
/* AC66E4 8004F544 AFA6002C */  sw    $a2, 0x2c($sp)
/* AC66E8 8004F548 27A40054 */  addiu $a0, $sp, 0x54
/* AC66EC 8004F54C 0C01F124 */  jal   OLib_Vec3fDiffToVecSphRot90
/* AC66F0 8004F550 8FA50030 */   lw    $a1, 0x30($sp)
/* AC66F4 8004F554 27A4005C */  addiu $a0, $sp, 0x5c
/* AC66F8 8004F558 8FA50030 */  lw    $a1, 0x30($sp)
/* AC66FC 8004F55C 0C01F124 */  jal   OLib_Vec3fDiffToVecSphRot90
/* AC6700 8004F560 8FA60028 */   lw    $a2, 0x28($sp)
/* AC6704 8004F564 8618000A */  lh    $t8, 0xa($s0)
/* AC6708 8004F568 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags)
/* AC670C 8004F56C 87A7003A */  lh    $a3, 0x3a($sp)
/* AC6710 8004F570 AC38D3A0 */  sw    $t8, %lo(sCameraInterfaceFlags)($at)
/* AC6714 8004F574 8603015E */  lh    $v1, 0x15e($s0)
/* AC6718 8004F578 54600015 */  bnezl $v1, .L8004F5D0
/* AC671C 8004F57C 2608000C */   addiu $t0, $s0, 0xc
/* AC6720 8004F580 44874000 */  mtc1  $a3, $f8
/* AC6724 8004F584 24790001 */  addiu $t9, $v1, 1
/* AC6728 8004F588 A619015E */  sh    $t9, 0x15e($s0)
/* AC672C 8004F58C 468042A0 */  cvt.s.w $f10, $f8
/* AC6730 8004F590 3C018014 */  lui   $at, %hi(D_8013A168)
/* AC6734 8004F594 C430A168 */  lwc1  $f16, %lo(D_8013A168)($at)
/* AC6738 8004F598 44802000 */  mtc1  $zero, $f4
/* AC673C 8004F59C 86090008 */  lh    $t1, 8($s0)
/* AC6740 8004F5A0 A600015A */  sh    $zero, 0x15a($s0)
/* AC6744 8004F5A4 46105482 */  mul.s $f18, $f10, $f16
/* AC6748 8004F5A8 2608000C */  addiu $t0, $s0, 0xc
/* AC674C 8004F5AC E6040100 */  swc1  $f4, 0x100($s0)
/* AC6750 8004F5B0 E61200FC */  swc1  $f18, 0xfc($s0)
/* AC6754 8004F5B4 A5090004 */  sh    $t1, 4($t0)
/* AC6758 8004F5B8 C6060000 */  lwc1  $f6, ($s0)
/* AC675C 8004F5BC C60000FC */  lwc1  $f0, 0xfc($s0)
/* AC6760 8004F5C0 46060202 */  mul.s $f8, $f0, $f6
/* AC6764 8004F5C4 46080281 */  sub.s $f10, $f0, $f8
/* AC6768 8004F5C8 E50A0000 */  swc1  $f10, ($t0)
/* AC676C 8004F5CC 2608000C */  addiu $t0, $s0, 0xc
.L8004F5D0:
/* AC6770 8004F5D0 85020004 */  lh    $v0, 4($t0)
/* AC6774 8004F5D4 87AB0062 */  lh    $t3, 0x62($sp)
/* AC6778 8004F5D8 87AA005A */  lh    $t2, 0x5a($sp)
/* AC677C 8004F5DC 10400022 */  beqz  $v0, .L8004F668
/* AC6780 8004F5E0 016A6023 */   subu  $t4, $t3, $t2
/* AC6784 8004F5E4 000C6C00 */  sll   $t5, $t4, 0x10
/* AC6788 8004F5E8 000D7403 */  sra   $t6, $t5, 0x10
/* AC678C 8004F5EC 01C2001A */  div   $zero, $t6, $v0
/* AC6790 8004F5F0 00007812 */  mflo  $t7
/* AC6794 8004F5F4 448F8000 */  mtc1  $t7, $f16
/* AC6798 8004F5F8 C6040004 */  lwc1  $f4, 4($s0)
/* AC679C 8004F5FC 448A4000 */  mtc1  $t2, $f8
/* AC67A0 8004F600 468084A0 */  cvt.s.w $f18, $f16
/* AC67A4 8004F604 14400002 */  bnez  $v0, .L8004F610
/* AC67A8 8004F608 00000000 */   nop
/* AC67AC 8004F60C 0007000D */  break 7
.L8004F610:
/* AC67B0 8004F610 2401FFFF */  li    $at, -1
/* AC67B4 8004F614 14410004 */  bne   $v0, $at, .L8004F628
/* AC67B8 8004F618 3C018000 */   lui   $at, 0x8000
/* AC67BC 8004F61C 15C10002 */  bne   $t6, $at, .L8004F628
/* AC67C0 8004F620 00000000 */   nop
/* AC67C4 8004F624 0006000D */  break 6
.L8004F628:
/* AC67C8 8004F628 46049182 */  mul.s $f6, $f18, $f4
/* AC67CC 8004F62C AFA80028 */  sw    $t0, 0x28($sp)
/* AC67D0 8004F630 8FA4002C */  lw    $a0, 0x2c($sp)
/* AC67D4 8004F634 8FA50030 */  lw    $a1, 0x30($sp)
/* AC67D8 8004F638 27A60054 */  addiu $a2, $sp, 0x54
/* AC67DC 8004F63C 468042A0 */  cvt.s.w $f10, $f8
/* AC67E0 8004F640 46065400 */  add.s $f16, $f10, $f6
/* AC67E4 8004F644 4600848D */  trunc.w.s $f18, $f16
/* AC67E8 8004F648 44199000 */  mfc1  $t9, $f18
/* AC67EC 8004F64C 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC67F0 8004F650 A7B9005A */   sh    $t9, 0x5a($sp)
/* AC67F4 8004F654 8FA80028 */  lw    $t0, 0x28($sp)
/* AC67F8 8004F658 85090004 */  lh    $t1, 4($t0)
/* AC67FC 8004F65C 252BFFFF */  addiu $t3, $t1, -1
/* AC6800 8004F660 10000004 */  b     .L8004F674
/* AC6804 8004F664 A50B0004 */   sh    $t3, 4($t0)
.L8004F668:
/* AC6808 8004F668 860C014C */  lh    $t4, 0x14c($s0)
/* AC680C 8004F66C 358D0410 */  ori   $t5, $t4, 0x410
/* AC6810 8004F670 A60D014C */  sh    $t5, 0x14c($s0)
.L8004F674:
/* AC6814 8004F674 C50C0000 */  lwc1  $f12, ($t0)
/* AC6818 8004F678 C60E00FC */  lwc1  $f14, 0xfc($s0)
/* AC681C 8004F67C 3C063F00 */  lui   $a2, 0x3f00
/* AC6820 8004F680 0C010E27 */  jal   Camera_LERPCeilF
/* AC6824 8004F684 3C074120 */   lui   $a3, 0x4120
/* AC6828 8004F688 E60000FC */  swc1  $f0, 0xfc($s0)
/* AC682C 8004F68C 24020001 */  li    $v0, 1
.L8004F690:
/* AC6830 8004F690 8FBF001C */  lw    $ra, 0x1c($sp)
/* AC6834 8004F694 8FB00018 */  lw    $s0, 0x18($sp)
/* AC6838 8004F698 27BD0070 */  addiu $sp, $sp, 0x70
/* AC683C 8004F69C 03E00008 */  jr    $ra
/* AC6840 8004F6A0 00000000 */   nop
