.late_rodata
glabel D_8013A22C
    .float 0.01

.text
glabel Camera_Unique7
/* AC9D30 80052B90 27BDFFA0 */  addiu $sp, $sp, -0x60
/* AC9D34 80052B94 AFBF001C */  sw    $ra, 0x1c($sp)
/* AC9D38 80052B98 AFB00018 */  sw    $s0, 0x18($sp)
/* AC9D3C 80052B9C 8482015E */  lh    $v0, 0x15e($a0)
/* AC9D40 80052BA0 00808025 */  move  $s0, $a0
/* AC9D44 80052BA4 10400009 */  beqz  $v0, .L80052BCC
/* AC9D48 80052BA8 2401000A */   li    $at, 10
/* AC9D4C 80052BAC 10410007 */  beq   $v0, $at, .L80052BCC
/* AC9D50 80052BB0 24010014 */   li    $at, 20
/* AC9D54 80052BB4 10410005 */  beq   $v0, $at, .L80052BCC
/* AC9D58 80052BB8 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC9D5C 80052BBC 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC9D60 80052BC0 85C30314 */  lh    $v1, 0x314($t6)
/* AC9D64 80052BC4 10600015 */  beqz  $v1, .L80052C1C
/* AC9D68 80052BC8 00000000 */   nop
.L80052BCC:
/* AC9D6C 80052BCC 860F0142 */  lh    $t7, 0x142($s0)
/* AC9D70 80052BD0 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC9D74 80052BD4 86080144 */  lh    $t0, 0x144($s0)
/* AC9D78 80052BD8 000FC0C0 */  sll   $t8, $t7, 3
/* AC9D7C 80052BDC 0338C821 */  addu  $t9, $t9, $t8
/* AC9D80 80052BE0 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC9D84 80052BE4 000848C0 */  sll   $t1, $t0, 3
/* AC9D88 80052BE8 3C0D8016 */  lui   $t5, %hi(gGameInfo) # $t5, 0x8016
/* AC9D8C 80052BEC 03295021 */  addu  $t2, $t9, $t1
/* AC9D90 80052BF0 8D420004 */  lw    $v0, 4($t2)
/* AC9D94 80052BF4 844B0000 */  lh    $t3, ($v0)
/* AC9D98 80052BF8 24420004 */  addiu $v0, $v0, 4
/* AC9D9C 80052BFC 448B2000 */  mtc1  $t3, $f4
/* AC9DA0 80052C00 00000000 */  nop
/* AC9DA4 80052C04 468021A0 */  cvt.s.w $f6, $f4
/* AC9DA8 80052C08 E6060000 */  swc1  $f6, ($s0)
/* AC9DAC 80052C0C 844C0000 */  lh    $t4, ($v0)
/* AC9DB0 80052C10 A60C0004 */  sh    $t4, 4($s0)
/* AC9DB4 80052C14 8DADFA90 */  lw    $t5, %lo(gGameInfo)($t5)
/* AC9DB8 80052C18 85A30314 */  lh    $v1, 0x314($t5)
.L80052C1C:
/* AC9DBC 80052C1C 10600003 */  beqz  $v1, .L80052C2C
/* AC9DC0 80052C20 00000000 */   nop
/* AC9DC4 80052C24 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC9DC8 80052C28 02002025 */   move  $a0, $s0
.L80052C2C:
/* AC9DCC 80052C2C 0C0111DB */  jal   func_8004476C
/* AC9DD0 80052C30 02002025 */   move  $a0, $s0
/* AC9DD4 80052C34 26070074 */  addiu $a3, $s0, 0x74
/* AC9DD8 80052C38 AFA20044 */  sw    $v0, 0x44($sp)
/* AC9DDC 80052C3C 00E02025 */  move  $a0, $a3
/* AC9DE0 80052C40 AFA70020 */  sw    $a3, 0x20($sp)
/* AC9DE4 80052C44 0C010EF1 */  jal   Camera_Vec3sToVec3f
/* AC9DE8 80052C48 00402825 */   move  $a1, $v0
/* AC9DEC 80052C4C 8FA70020 */  lw    $a3, 0x20($sp)
/* AC9DF0 80052C50 2605005C */  addiu $a1, $s0, 0x5c
/* AC9DF4 80052C54 27B8003C */  addiu $t8, $sp, 0x3c
/* AC9DF8 80052C58 8CEF0000 */  lw    $t7, ($a3)
/* AC9DFC 80052C5C 27A4004C */  addiu $a0, $sp, 0x4c
/* AC9E00 80052C60 26060094 */  addiu $a2, $s0, 0x94
/* AC9E04 80052C64 ACAF0000 */  sw    $t7, ($a1)
/* AC9E08 80052C68 8CEE0004 */  lw    $t6, 4($a3)
/* AC9E0C 80052C6C ACAE0004 */  sw    $t6, 4($a1)
/* AC9E10 80052C70 8CEF0008 */  lw    $t7, 8($a3)
/* AC9E14 80052C74 ACAF0008 */  sw    $t7, 8($a1)
/* AC9E18 80052C78 8FA80044 */  lw    $t0, 0x44($sp)
/* AC9E1C 80052C7C 89090006 */  lwl   $t1, 6($t0)
/* AC9E20 80052C80 99090009 */  lwr   $t1, 9($t0)
/* AC9E24 80052C84 AF090000 */  sw    $t1, ($t8)
/* AC9E28 80052C88 9509000A */  lhu   $t1, 0xa($t0)
/* AC9E2C 80052C8C A7090004 */  sh    $t1, 4($t8)
/* AC9E30 80052C90 0C01F124 */  jal   OLib_Vec3fDiffToVecSphRot90
/* AC9E34 80052C94 AFA50024 */   sw    $a1, 0x24($sp)
/* AC9E38 80052C98 8FAA0044 */  lw    $t2, 0x44($sp)
/* AC9E3C 80052C9C 2401FFFF */  li    $at, -1
/* AC9E40 80052CA0 3C063ECC */  lui   $a2, (0x3ECCCCCD >> 16) # lui $a2, 0x3ecc
/* AC9E44 80052CA4 8543000C */  lh    $v1, 0xc($t2)
/* AC9E48 80052CA8 34C6CCCD */  ori   $a2, (0x3ECCCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC9E4C 80052CAC 14610009 */  bne   $v1, $at, .L80052CD4
/* AC9E50 80052CB0 3C0142C8 */   li    $at, 0x42C80000 # 0.000000
/* AC9E54 80052CB4 44815000 */  mtc1  $at, $f10
/* AC9E58 80052CB8 C6080000 */  lwc1  $f8, ($s0)
/* AC9E5C 80052CBC 460A4402 */  mul.s $f16, $f8, $f10
/* AC9E60 80052CC0 4600848D */  trunc.w.s $f18, $f16
/* AC9E64 80052CC4 44039000 */  mfc1  $v1, $f18
/* AC9E68 80052CC8 00000000 */  nop
/* AC9E6C 80052CCC 00031C00 */  sll   $v1, $v1, 0x10
/* AC9E70 80052CD0 00031C03 */  sra   $v1, $v1, 0x10
.L80052CD4:
/* AC9E74 80052CD4 28610169 */  slti  $at, $v1, 0x169
/* AC9E78 80052CD8 10200008 */  beqz  $at, .L80052CFC
/* AC9E7C 80052CDC 00600821 */   addu  $at, $v1, $zero
/* AC9E80 80052CE0 00031880 */  sll   $v1, $v1, 2
/* AC9E84 80052CE4 00611823 */  subu  $v1, $v1, $at
/* AC9E88 80052CE8 000318C0 */  sll   $v1, $v1, 3
/* AC9E8C 80052CEC 00611821 */  addu  $v1, $v1, $at
/* AC9E90 80052CF0 00031880 */  sll   $v1, $v1, 2
/* AC9E94 80052CF4 00031C00 */  sll   $v1, $v1, 0x10
/* AC9E98 80052CF8 00031C03 */  sra   $v1, $v1, 0x10
.L80052CFC:
/* AC9E9C 80052CFC 860C0004 */  lh    $t4, 4($s0)
/* AC9EA0 80052D00 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags)
/* AC9EA4 80052D04 AC2CD3A0 */  sw    $t4, %lo(sCameraInterfaceFlags)($at)
/* AC9EA8 80052D08 8602015E */  lh    $v0, 0x15e($s0)
/* AC9EAC 80052D0C 5440000F */  bnezl $v0, .L80052D4C
/* AC9EB0 80052D10 3C014270 */   li    $at, 0x42700000 # 0.000000
/* AC9EB4 80052D14 44832000 */  mtc1  $v1, $f4
/* AC9EB8 80052D18 244D0001 */  addiu $t5, $v0, 1
/* AC9EBC 80052D1C A60D015E */  sh    $t5, 0x15e($s0)
/* AC9EC0 80052D20 468021A0 */  cvt.s.w $f6, $f4
/* AC9EC4 80052D24 3C018014 */  lui   $at, %hi(D_8013A22C)
/* AC9EC8 80052D28 C428A22C */  lwc1  $f8, %lo(D_8013A22C)($at)
/* AC9ECC 80052D2C 44808000 */  mtc1  $zero, $f16
/* AC9ED0 80052D30 A600015A */  sh    $zero, 0x15a($s0)
/* AC9ED4 80052D34 46083282 */  mul.s $f10, $f6, $f8
/* AC9ED8 80052D38 E6100100 */  swc1  $f16, 0x100($s0)
/* AC9EDC 80052D3C E60A00FC */  swc1  $f10, 0xfc($s0)
/* AC9EE0 80052D40 87AE0052 */  lh    $t6, 0x52($sp)
/* AC9EE4 80052D44 A60E0008 */  sh    $t6, 8($s0)
/* AC9EE8 80052D48 3C014270 */  li    $at, 0x42700000 # 0.000000
.L80052D4C:
/* AC9EEC 80052D4C 44819000 */  mtc1  $at, $f18
/* AC9EF0 80052D50 26030008 */  addiu $v1, $s0, 8
/* AC9EF4 80052D54 240707D0 */  li    $a3, 2000
/* AC9EF8 80052D58 E61200FC */  swc1  $f18, 0xfc($s0)
/* AC9EFC 80052D5C 84650000 */  lh    $a1, ($v1)
/* AC9F00 80052D60 AFA30020 */  sw    $v1, 0x20($sp)
/* AC9F04 80052D64 0C010E6B */  jal   Camera_LERPFloorS
/* AC9F08 80052D68 87A40052 */   lh    $a0, 0x52($sp)
/* AC9F0C 80052D6C 8FA30020 */  lw    $v1, 0x20($sp)
/* AC9F10 80052D70 A4620000 */  sh    $v0, ($v1)
/* AC9F14 80052D74 8FB80044 */  lw    $t8, 0x44($sp)
/* AC9F18 80052D78 87AF0052 */  lh    $t7, 0x52($sp)
/* AC9F1C 80052D7C 87080008 */  lh    $t0, 8($t8)
/* AC9F20 80052D80 01E82023 */  subu  $a0, $t7, $t0
/* AC9F24 80052D84 00042400 */  sll   $a0, $a0, 0x10
/* AC9F28 80052D88 0C01DE0D */  jal   Math_Coss
/* AC9F2C 80052D8C 00042403 */   sra   $a0, $a0, 0x10
/* AC9F30 80052D90 8FB90044 */  lw    $t9, 0x44($sp)
/* AC9F34 80052D94 26040050 */  addiu $a0, $s0, 0x50
/* AC9F38 80052D98 8FA50024 */  lw    $a1, 0x24($sp)
/* AC9F3C 80052D9C 87290006 */  lh    $t1, 6($t9)
/* AC9F40 80052DA0 27A6004C */  addiu $a2, $sp, 0x4c
/* AC9F44 80052DA4 00095023 */  negu  $t2, $t1
/* AC9F48 80052DA8 448A2000 */  mtc1  $t2, $f4
/* AC9F4C 80052DAC 00000000 */  nop
/* AC9F50 80052DB0 468021A0 */  cvt.s.w $f6, $f4
/* AC9F54 80052DB4 46060202 */  mul.s $f8, $f0, $f6
/* AC9F58 80052DB8 4600428D */  trunc.w.s $f10, $f8
/* AC9F5C 80052DBC 440C5000 */  mfc1  $t4, $f10
/* AC9F60 80052DC0 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC9F64 80052DC4 A7AC0050 */   sh    $t4, 0x50($sp)
/* AC9F68 80052DC8 860D014C */  lh    $t5, 0x14c($s0)
/* AC9F6C 80052DCC 24020001 */  li    $v0, 1
/* AC9F70 80052DD0 35AE0400 */  ori   $t6, $t5, 0x400
/* AC9F74 80052DD4 A60E014C */  sh    $t6, 0x14c($s0)
/* AC9F78 80052DD8 8FBF001C */  lw    $ra, 0x1c($sp)
/* AC9F7C 80052DDC 8FB00018 */  lw    $s0, 0x18($sp)
/* AC9F80 80052DE0 27BD0060 */  addiu $sp, $sp, 0x60
/* AC9F84 80052DE4 03E00008 */  jr    $ra
/* AC9F88 80052DE8 00000000 */   nop
