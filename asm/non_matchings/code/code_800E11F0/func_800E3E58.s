glabel func_800E3E58
/* B5AFF8 800E3E58 27BDFFD8 */  addiu $sp, $sp, -0x28
/* B5AFFC 800E3E5C AFBF001C */  sw    $ra, 0x1c($sp)
/* B5B000 800E3E60 AFB00018 */  sw    $s0, 0x18($sp)
/* B5B004 800E3E64 80820001 */  lb    $v0, 1($a0)
/* B5B008 800E3E68 3C038017 */  lui   $v1, %hi(gAudioContext+0x2838) # $v1, 0x8017
/* B5B00C 800E3E6C 00808025 */  move  $s0, $a0
/* B5B010 800E3E70 28410002 */  slti  $at, $v0, 2
/* B5B014 800E3E74 14200004 */  bnez  $at, .L800E3E88
/* B5B018 800E3E78 8C6319B8 */   lw    $v1, %lo(gAudioContext+0x2838)($v1)
/* B5B01C 800E3E7C 244EFFFF */  addiu $t6, $v0, -1
/* B5B020 800E3E80 10000047 */  b     .L800E3FA0
/* B5B024 800E3E84 A08E0001 */   sb    $t6, 1($a0)
.L800E3E88:
/* B5B028 800E3E88 24070001 */  li    $a3, 1
/* B5B02C 800E3E8C 14E20003 */  bne   $a3, $v0, .L800E3E9C
/* B5B030 800E3E90 00000000 */   nop
/* B5B034 800E3E94 10000011 */  b     .L800E3EDC
/* B5B038 800E3E98 A2000001 */   sb    $zero, 1($s0)
.L800E3E9C:
/* B5B03C 800E3E9C 10A00007 */  beqz  $a1, .L800E3EBC
/* B5B040 800E3EA0 26040024 */   addiu $a0, $s0, 0x24
/* B5B044 800E3EA4 26040024 */  addiu $a0, $s0, 0x24
/* B5B048 800E3EA8 00002825 */  move  $a1, $zero
/* B5B04C 800E3EAC 0C000CA0 */  jal   osRecvMesg
/* B5B050 800E3EB0 24060001 */   li    $a2, 1
/* B5B054 800E3EB4 1000003A */  b     .L800E3FA0
/* B5B058 800E3EB8 A2000000 */   sb    $zero, ($s0)
.L800E3EBC:
/* B5B05C 800E3EBC 00002825 */  move  $a1, $zero
/* B5B060 800E3EC0 00003025 */  move  $a2, $zero
/* B5B064 800E3EC4 0C000CA0 */  jal   osRecvMesg
/* B5B068 800E3EC8 AFA30024 */   sw    $v1, 0x24($sp)
/* B5B06C 800E3ECC 2401FFFF */  li    $at, -1
/* B5B070 800E3ED0 8FA30024 */  lw    $v1, 0x24($sp)
/* B5B074 800E3ED4 10410032 */  beq   $v0, $at, .L800E3FA0
/* B5B078 800E3ED8 24070001 */   li    $a3, 1
.L800E3EDC:
/* B5B07C 800E3EDC 8E0F0010 */  lw    $t7, 0x10($s0)
/* B5B080 800E3EE0 15E00005 */  bnez  $t7, .L800E3EF8
/* B5B084 800E3EE4 AFAF0020 */   sw    $t7, 0x20($sp)
/* B5B088 800E3EE8 0C038F47 */  jal   func_800E3D1C
/* B5B08C 800E3EEC 02002025 */   move  $a0, $s0
/* B5B090 800E3EF0 1000002C */  b     .L800E3FA4
/* B5B094 800E3EF4 8FBF001C */   lw    $ra, 0x1c($sp)
.L800E3EF8:
/* B5B098 800E3EF8 8E060014 */  lw    $a2, 0x14($s0)
/* B5B09C 800E3EFC 8FB90020 */  lw    $t9, 0x20($sp)
/* B5B0A0 800E3F00 0326082B */  sltu  $at, $t9, $a2
/* B5B0A4 800E3F04 50200011 */  beql  $at, $zero, .L800E3F4C
/* B5B0A8 800E3F08 82090002 */   lb    $t1, 2($s0)
/* B5B0AC 800E3F0C 82080002 */  lb    $t0, 2($s0)
/* B5B0B0 800E3F10 03203025 */  move  $a2, $t9
/* B5B0B4 800E3F14 02002025 */  move  $a0, $s0
/* B5B0B8 800E3F18 14E80007 */  bne   $a3, $t0, .L800E3F38
/* B5B0BC 800E3F1C 00000000 */   nop
/* B5B0C0 800E3F20 8E040008 */  lw    $a0, 8($s0)
/* B5B0C4 800E3F24 8E05000C */  lw    $a1, 0xc($s0)
/* B5B0C8 800E3F28 0C039011 */  jal   func_800E4044
/* B5B0CC 800E3F2C 84670002 */   lh    $a3, 2($v1)
/* B5B0D0 800E3F30 10000003 */  b     .L800E3F40
/* B5B0D4 800E3F34 00000000 */   nop
.L800E3F38:
/* B5B0D8 800E3F38 0C038FED */  jal   func_800E3FB4
/* B5B0DC 800E3F3C 8FA50020 */   lw    $a1, 0x20($sp)
.L800E3F40:
/* B5B0E0 800E3F40 10000017 */  b     .L800E3FA0
/* B5B0E4 800E3F44 AE000010 */   sw    $zero, 0x10($s0)
/* B5B0E8 800E3F48 82090002 */  lb    $t1, 2($s0)
.L800E3F4C:
/* B5B0EC 800E3F4C 02002025 */  move  $a0, $s0
/* B5B0F0 800E3F50 14E90007 */  bne   $a3, $t1, .L800E3F70
/* B5B0F4 800E3F54 00000000 */   nop
/* B5B0F8 800E3F58 8E040008 */  lw    $a0, 8($s0)
/* B5B0FC 800E3F5C 8E05000C */  lw    $a1, 0xc($s0)
/* B5B100 800E3F60 0C039011 */  jal   func_800E4044
/* B5B104 800E3F64 84670002 */   lh    $a3, 2($v1)
/* B5B108 800E3F68 10000004 */  b     .L800E3F7C
/* B5B10C 800E3F6C 8E060014 */   lw    $a2, 0x14($s0)
.L800E3F70:
/* B5B110 800E3F70 0C038FED */  jal   func_800E3FB4
/* B5B114 800E3F74 00C02825 */   move  $a1, $a2
/* B5B118 800E3F78 8E060014 */  lw    $a2, 0x14($s0)
.L800E3F7C:
/* B5B11C 800E3F7C 8E0A0010 */  lw    $t2, 0x10($s0)
/* B5B120 800E3F80 8E0C0008 */  lw    $t4, 8($s0)
/* B5B124 800E3F84 8E0E000C */  lw    $t6, 0xc($s0)
/* B5B128 800E3F88 01465823 */  subu  $t3, $t2, $a2
/* B5B12C 800E3F8C 01866821 */  addu  $t5, $t4, $a2
/* B5B130 800E3F90 01C67821 */  addu  $t7, $t6, $a2
/* B5B134 800E3F94 AE0B0010 */  sw    $t3, 0x10($s0)
/* B5B138 800E3F98 AE0D0008 */  sw    $t5, 8($s0)
/* B5B13C 800E3F9C AE0F000C */  sw    $t7, 0xc($s0)
.L800E3FA0:
/* B5B140 800E3FA0 8FBF001C */  lw    $ra, 0x1c($sp)
.L800E3FA4:
/* B5B144 800E3FA4 8FB00018 */  lw    $s0, 0x18($sp)
/* B5B148 800E3FA8 27BD0028 */  addiu $sp, $sp, 0x28
/* B5B14C 800E3FAC 03E00008 */  jr    $ra
/* B5B150 800E3FB0 00000000 */   nop

