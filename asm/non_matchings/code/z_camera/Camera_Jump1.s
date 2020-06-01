.late_rodata
glabel D_80139F44
    .float 0.01
    .float 0.01
    .float 0.01

glabel D_80139F50
    .float 0.0001

glabel D_80139F54
    .float 0.01

glabel D_80139F58
    .float 0.01

glabel D_80139F5C
    .float 0.01

glabel D_80139F60
    .float 0.01

glabel D_80139F64
    .float 0.01

glabel D_80139F68
    .float 0.01

glabel D_80139F6C
    .float 0.01

glabel D_80139F70
    .float 0.01

glabel D_80139F74
    .float 0.01

glabel D_80139F78
    .float 0.01

glabel D_80139F7C
    .float 0.99

.text
glabel Camera_Jump1
/* AC0BE8 80049A48 27BDFF48 */  addiu $sp, $sp, -0xb8
/* AC0BEC 80049A4C AFB0001C */  sw    $s0, 0x1c($sp)
/* AC0BF0 80049A50 00808025 */  move  $s0, $a0
/* AC0BF4 80049A54 AFBF0024 */  sw    $ra, 0x24($sp)
/* AC0BF8 80049A58 AFB10020 */  sw    $s1, 0x20($sp)
/* AC0BFC 80049A5C 0C00B721 */  jal   Player_GetCameraYOffset
/* AC0C00 80049A60 8C840090 */   lw    $a0, 0x90($a0)
/* AC0C04 80049A64 8603015E */  lh    $v1, 0x15e($s0)
/* AC0C08 80049A68 10600008 */  beqz  $v1, .L80049A8C
/* AC0C0C 80049A6C 2401000A */   li    $at, 10
/* AC0C10 80049A70 10610006 */  beq   $v1, $at, .L80049A8C
/* AC0C14 80049A74 24010014 */   li    $at, 20
/* AC0C18 80049A78 10610004 */  beq   $v1, $at, .L80049A8C
/* AC0C1C 80049A7C 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC0C20 80049A80 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC0C24 80049A84 85C30314 */  lh    $v1, 0x314($t6)
/* AC0C28 80049A88 10600052 */  beqz  $v1, .L80049BD4
.L80049A8C:
/* AC0C2C 80049A8C 3C018014 */   lui   $at, %hi(D_80139F44)
/* AC0C30 80049A90 C42E9F44 */  lwc1  $f14, %lo(D_80139F44)($at)
/* AC0C34 80049A94 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC0C38 80049A98 44814000 */  mtc1  $at, $f8
/* AC0C3C 80049A9C 3C014288 */  lui   $at, 0x4288
/* AC0C40 80049AA0 3C0B8016 */  lui   $t3, %hi(gGameInfo)
/* AC0C44 80049AA4 8D6BFA90 */  lw    $t3, %lo(gGameInfo)($t3)
/* AC0C48 80049AA8 44818000 */  mtc1  $at, $f16
/* AC0C4C 80049AAC 860F0142 */  lh    $t7, 0x142($s0)
/* AC0C50 80049AB0 856C01F0 */  lh    $t4, 0x1f0($t3)
/* AC0C54 80049AB4 46008483 */  div.s $f18, $f16, $f0
/* AC0C58 80049AB8 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC0C5C 80049ABC 448C2000 */  mtc1  $t4, $f4
/* AC0C60 80049AC0 000FC0C0 */  sll   $t8, $t7, 3
/* AC0C64 80049AC4 86080144 */  lh    $t0, 0x144($s0)
/* AC0C68 80049AC8 468021A0 */  cvt.s.w $f6, $f4
/* AC0C6C 80049ACC 0338C821 */  addu  $t9, $t9, $t8
/* AC0C70 80049AD0 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC0C74 80049AD4 000848C0 */  sll   $t1, $t0, 3
/* AC0C78 80049AD8 3C0B8016 */  lui   $t3, %hi(gGameInfo) # $t3, 0x8016
/* AC0C7C 80049ADC 03295021 */  addu  $t2, $t9, $t1
/* AC0C80 80049AE0 8D420004 */  lw    $v0, 4($t2)
/* AC0C84 80049AE4 844D0000 */  lh    $t5, ($v0)
/* AC0C88 80049AE8 2442001C */  addiu $v0, $v0, 0x1c
/* AC0C8C 80049AEC 460E3302 */  mul.s $f12, $f6, $f14
/* AC0C90 80049AF0 448D3000 */  mtc1  $t5, $f6
/* AC0C94 80049AF4 460C4280 */  add.s $f10, $f8, $f12
/* AC0C98 80049AF8 46126102 */  mul.s $f4, $f12, $f18
/* AC0C9C 80049AFC 46803220 */  cvt.s.w $f8, $f6
/* AC0CA0 80049B00 46045081 */  sub.s $f2, $f10, $f4
/* AC0CA4 80049B04 460E4402 */  mul.s $f16, $f8, $f14
/* AC0CA8 80049B08 00000000 */  nop
/* AC0CAC 80049B0C 46008482 */  mul.s $f18, $f16, $f0
/* AC0CB0 80049B10 00000000 */  nop
/* AC0CB4 80049B14 46029282 */  mul.s $f10, $f18, $f2
/* AC0CB8 80049B18 E60A0000 */  swc1  $f10, ($s0)
/* AC0CBC 80049B1C 844EFFE8 */  lh    $t6, -0x18($v0)
/* AC0CC0 80049B20 448E2000 */  mtc1  $t6, $f4
/* AC0CC4 80049B24 00000000 */  nop
/* AC0CC8 80049B28 468021A0 */  cvt.s.w $f6, $f4
/* AC0CCC 80049B2C 460E3202 */  mul.s $f8, $f6, $f14
/* AC0CD0 80049B30 00000000 */  nop
/* AC0CD4 80049B34 46004402 */  mul.s $f16, $f8, $f0
/* AC0CD8 80049B38 00000000 */  nop
/* AC0CDC 80049B3C 46028482 */  mul.s $f18, $f16, $f2
/* AC0CE0 80049B40 E6120004 */  swc1  $f18, 4($s0)
/* AC0CE4 80049B44 844FFFEC */  lh    $t7, -0x14($v0)
/* AC0CE8 80049B48 448F5000 */  mtc1  $t7, $f10
/* AC0CEC 80049B4C 00000000 */  nop
/* AC0CF0 80049B50 46805120 */  cvt.s.w $f4, $f10
/* AC0CF4 80049B54 460E2182 */  mul.s $f6, $f4, $f14
/* AC0CF8 80049B58 00000000 */  nop
/* AC0CFC 80049B5C 46003202 */  mul.s $f8, $f6, $f0
/* AC0D00 80049B60 00000000 */  nop
/* AC0D04 80049B64 46024402 */  mul.s $f16, $f8, $f2
/* AC0D08 80049B68 E6100008 */  swc1  $f16, 8($s0)
/* AC0D0C 80049B6C 8458FFF0 */  lh    $t8, -0x10($v0)
/* AC0D10 80049B70 44989000 */  mtc1  $t8, $f18
/* AC0D14 80049B74 00000000 */  nop
/* AC0D18 80049B78 468092A0 */  cvt.s.w $f10, $f18
/* AC0D1C 80049B7C E60A000C */  swc1  $f10, 0xc($s0)
/* AC0D20 80049B80 8448FFF4 */  lh    $t0, -0xc($v0)
/* AC0D24 80049B84 44882000 */  mtc1  $t0, $f4
/* AC0D28 80049B88 00000000 */  nop
/* AC0D2C 80049B8C 468021A0 */  cvt.s.w $f6, $f4
/* AC0D30 80049B90 460E3202 */  mul.s $f8, $f6, $f14
/* AC0D34 80049B94 E6080010 */  swc1  $f8, 0x10($s0)
/* AC0D38 80049B98 8459FFF8 */  lh    $t9, -8($v0)
/* AC0D3C 80049B9C 44998000 */  mtc1  $t9, $f16
/* AC0D40 80049BA0 00000000 */  nop
/* AC0D44 80049BA4 468084A0 */  cvt.s.w $f18, $f16
/* AC0D48 80049BA8 E6120014 */  swc1  $f18, 0x14($s0)
/* AC0D4C 80049BAC 8449FFFC */  lh    $t1, -4($v0)
/* AC0D50 80049BB0 44895000 */  mtc1  $t1, $f10
/* AC0D54 80049BB4 00000000 */  nop
/* AC0D58 80049BB8 46805120 */  cvt.s.w $f4, $f10
/* AC0D5C 80049BBC 460E2182 */  mul.s $f6, $f4, $f14
/* AC0D60 80049BC0 E6060018 */  swc1  $f6, 0x18($s0)
/* AC0D64 80049BC4 844A0000 */  lh    $t2, ($v0)
/* AC0D68 80049BC8 A60A001C */  sh    $t2, 0x1c($s0)
/* AC0D6C 80049BCC 8D6BFA90 */  lw    $t3, %lo(gGameInfo)($t3)
/* AC0D70 80049BD0 85630314 */  lh    $v1, 0x314($t3)
.L80049BD4:
/* AC0D74 80049BD4 50600004 */  beql  $v1, $zero, .L80049BE8
/* AC0D78 80049BD8 27A40060 */   addiu $a0, $sp, 0x60
/* AC0D7C 80049BDC 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC0D80 80049BE0 02002025 */   move  $a0, $s0
/* AC0D84 80049BE4 27A40060 */  addiu $a0, $sp, 0x60
.L80049BE8:
/* AC0D88 80049BE8 0C00BBB9 */  jal   func_8002EEE4
/* AC0D8C 80049BEC 8E050090 */   lw    $a1, 0x90($s0)
/* AC0D90 80049BF0 26050050 */  addiu $a1, $s0, 0x50
/* AC0D94 80049BF4 2606005C */  addiu $a2, $s0, 0x5c
/* AC0D98 80049BF8 AFA60040 */  sw    $a2, 0x40($sp)
/* AC0D9C 80049BFC AFA5003C */  sw    $a1, 0x3c($sp)
/* AC0DA0 80049C00 0C01F124 */  jal   func_8007C490
/* AC0DA4 80049C04 27A40090 */   addiu $a0, $sp, 0x90
/* AC0DA8 80049C08 26060074 */  addiu $a2, $s0, 0x74
/* AC0DAC 80049C0C AFA60038 */  sw    $a2, 0x38($sp)
/* AC0DB0 80049C10 27A40088 */  addiu $a0, $sp, 0x88
/* AC0DB4 80049C14 0C01F124 */  jal   func_8007C490
/* AC0DB8 80049C18 8FA5003C */   lw    $a1, 0x3c($sp)
/* AC0DBC 80049C1C 860C001C */  lh    $t4, 0x1c($s0)
/* AC0DC0 80049C20 3C018012 */  lui   $at, %hi(D_8011D3A0) # $at, 0x8012
/* AC0DC4 80049C24 AC2CD3A0 */  sw    $t4, %lo(D_8011D3A0)($at)
/* AC0DC8 80049C28 8603015E */  lh    $v1, 0x15e($s0)
/* AC0DCC 80049C2C 10600004 */  beqz  $v1, .L80049C40
/* AC0DD0 80049C30 2401000A */   li    $at, 10
/* AC0DD4 80049C34 10610002 */  beq   $v1, $at, .L80049C40
/* AC0DD8 80049C38 24010014 */   li    $at, 20
/* AC0DDC 80049C3C 1461001B */  bne   $v1, $at, .L80049CAC
.L80049C40:
/* AC0DE0 80049C40 26110020 */   addiu $s1, $s0, 0x20
/* AC0DE4 80049C44 A6200018 */  sh    $zero, 0x18($s1)
/* AC0DE8 80049C48 862D0018 */  lh    $t5, 0x18($s1)
/* AC0DEC 80049C4C 240E00C8 */  li    $t6, 200
/* AC0DF0 80049C50 AE20000C */  sw    $zero, 0xc($s1)
/* AC0DF4 80049C54 A6200024 */  sh    $zero, 0x24($s1)
/* AC0DF8 80049C58 A62E0026 */  sh    $t6, 0x26($s1)
/* AC0DFC 80049C5C A620001A */  sh    $zero, 0x1a($s1)
/* AC0E00 80049C60 A62D0016 */  sh    $t5, 0x16($s1)
/* AC0E04 80049C64 C608000C */  lwc1  $f8, 0xc($s0)
/* AC0E08 80049C68 3C018014 */  lui   $at, %hi(D_80139F50)
/* AC0E0C 80049C6C E6280010 */  swc1  $f8, 0x10($s1)
/* AC0E10 80049C70 C61200F4 */  lwc1  $f18, 0xf4($s0)
/* AC0E14 80049C74 C6100098 */  lwc1  $f16, 0x98($s0)
/* AC0E18 80049C78 46128281 */  sub.s $f10, $f16, $f18
/* AC0E1C 80049C7C E62A001C */  swc1  $f10, 0x1c($s1)
/* AC0E20 80049C80 C7A40090 */  lwc1  $f4, 0x90($sp)
/* AC0E24 80049C84 E6240020 */  swc1  $f4, 0x20($s1)
/* AC0E28 80049C88 C60600E8 */  lwc1  $f6, 0xe8($s0)
/* AC0E2C 80049C8C C60800F4 */  lwc1  $f8, 0xf4($s0)
/* AC0E30 80049C90 860F015E */  lh    $t7, 0x15e($s0)
/* AC0E34 80049C94 46083401 */  sub.s $f16, $f6, $f8
/* AC0E38 80049C98 25F80001 */  addiu $t8, $t7, 1
/* AC0E3C 80049C9C E61000E8 */  swc1  $f16, 0xe8($s0)
/* AC0E40 80049CA0 C4329F50 */  lwc1  $f18, %lo(D_80139F50)($at)
/* AC0E44 80049CA4 A618015E */  sh    $t8, 0x15e($s0)
/* AC0E48 80049CA8 E61200CC */  swc1  $f18, 0xcc($s0)
.L80049CAC:
/* AC0E4C 80049CAC 26110020 */  addiu $s1, $s0, 0x20
/* AC0E50 80049CB0 8622001A */  lh    $v0, 0x1a($s1)
/* AC0E54 80049CB4 1040002D */  beqz  $v0, .L80049D6C
/* AC0E58 80049CB8 3C088016 */   lui   $t0, %hi(gGameInfo)
/* AC0E5C 80049CBC 8D08FA90 */  lw    $t0, %lo(gGameInfo)($t0)
/* AC0E60 80049CC0 44822000 */  mtc1  $v0, $f4
/* AC0E64 80049CC4 3C018014 */  lui   $at, %hi(D_80139F54)
/* AC0E68 80049CC8 851901C8 */  lh    $t9, 0x1c8($t0)
/* AC0E6C 80049CCC C4329F54 */  lwc1  $f18, %lo(D_80139F54)($at)
/* AC0E70 80049CD0 468021A0 */  cvt.s.w $f6, $f4
/* AC0E74 80049CD4 44994000 */  mtc1  $t9, $f8
/* AC0E78 80049CD8 C60A000C */  lwc1  $f10, 0xc($s0)
/* AC0E7C 80049CDC 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC0E80 80049CE0 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0E84 80049CE4 46804420 */  cvt.s.w $f16, $f8
/* AC0E88 80049CE8 C60E00C8 */  lwc1  $f14, 0xc8($s0)
/* AC0E8C 80049CEC 46065300 */  add.s $f12, $f10, $f6
/* AC0E90 80049CF0 46128102 */  mul.s $f4, $f16, $f18
/* AC0E94 80049CF4 44062000 */  mfc1  $a2, $f4
/* AC0E98 80049CF8 0C010E27 */  jal   func_8004389C
/* AC0E9C 80049CFC 00000000 */   nop
/* AC0EA0 80049D00 E60000C8 */  swc1  $f0, 0xc8($s0)
/* AC0EA4 80049D04 3C028016 */  lui   $v0, %hi(gGameInfo) # $v0, 0x8016
/* AC0EA8 80049D08 8C42FA90 */  lw    $v0, %lo(gGameInfo)($v0)
/* AC0EAC 80049D0C 862A001A */  lh    $t2, 0x1a($s1)
/* AC0EB0 80049D10 3C018014 */  lui   $at, %hi(D_80139F58)
/* AC0EB4 80049D14 844B01C8 */  lh    $t3, 0x1c8($v0)
/* AC0EB8 80049D18 844901A2 */  lh    $t1, 0x1a2($v0)
/* AC0EBC 80049D1C 448A4000 */  mtc1  $t2, $f8
/* AC0EC0 80049D20 448B9000 */  mtc1  $t3, $f18
/* AC0EC4 80049D24 44895000 */  mtc1  $t1, $f10
/* AC0EC8 80049D28 46804420 */  cvt.s.w $f16, $f8
/* AC0ECC 80049D2C 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC0ED0 80049D30 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0ED4 80049D34 C60E00C4 */  lwc1  $f14, 0xc4($s0)
/* AC0ED8 80049D38 46809120 */  cvt.s.w $f4, $f18
/* AC0EDC 80049D3C 468051A0 */  cvt.s.w $f6, $f10
/* AC0EE0 80049D40 C42A9F58 */  lwc1  $f10, %lo(D_80139F58)($at)
/* AC0EE4 80049D44 460A2202 */  mul.s $f8, $f4, $f10
/* AC0EE8 80049D48 46103300 */  add.s $f12, $f6, $f16
/* AC0EEC 80049D4C 44064000 */  mfc1  $a2, $f8
/* AC0EF0 80049D50 0C010E27 */  jal   func_8004389C
/* AC0EF4 80049D54 00000000 */   nop
/* AC0EF8 80049D58 E60000C4 */  swc1  $f0, 0xc4($s0)
/* AC0EFC 80049D5C 862C001A */  lh    $t4, 0x1a($s1)
/* AC0F00 80049D60 258DFFFF */  addiu $t5, $t4, -1
/* AC0F04 80049D64 10000023 */  b     .L80049DF4
/* AC0F08 80049D68 A62D001A */   sh    $t5, 0x1a($s1)
.L80049D6C:
/* AC0F0C 80049D6C 3C0E8016 */  lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC0F10 80049D70 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC0F14 80049D74 3C018014 */  lui   $at, %hi(D_80139F5C)
/* AC0F18 80049D78 C4329F5C */  lwc1  $f18, %lo(D_80139F5C)($at)
/* AC0F1C 80049D7C 85CF01C8 */  lh    $t7, 0x1c8($t6)
/* AC0F20 80049D80 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC0F24 80049D84 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0F28 80049D88 448F3000 */  mtc1  $t7, $f6
/* AC0F2C 80049D8C C60C000C */  lwc1  $f12, 0xc($s0)
/* AC0F30 80049D90 C60E00C8 */  lwc1  $f14, 0xc8($s0)
/* AC0F34 80049D94 46803420 */  cvt.s.w $f16, $f6
/* AC0F38 80049D98 46128102 */  mul.s $f4, $f16, $f18
/* AC0F3C 80049D9C 44062000 */  mfc1  $a2, $f4
/* AC0F40 80049DA0 0C010E27 */  jal   func_8004389C
/* AC0F44 80049DA4 00000000 */   nop
/* AC0F48 80049DA8 E60000C8 */  swc1  $f0, 0xc8($s0)
/* AC0F4C 80049DAC 3C028016 */  lui   $v0, %hi(gGameInfo) # $v0, 0x8016
/* AC0F50 80049DB0 8C42FA90 */  lw    $v0, %lo(gGameInfo)($v0)
/* AC0F54 80049DB4 3C018014 */  lui   $at, %hi(D_80139F60)
/* AC0F58 80049DB8 C4309F60 */  lwc1  $f16, %lo(D_80139F60)($at)
/* AC0F5C 80049DBC 844801C8 */  lh    $t0, 0x1c8($v0)
/* AC0F60 80049DC0 845801A2 */  lh    $t8, 0x1a2($v0)
/* AC0F64 80049DC4 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC0F68 80049DC8 44884000 */  mtc1  $t0, $f8
/* AC0F6C 80049DCC 44985000 */  mtc1  $t8, $f10
/* AC0F70 80049DD0 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0F74 80049DD4 468041A0 */  cvt.s.w $f6, $f8
/* AC0F78 80049DD8 C60E00C4 */  lwc1  $f14, 0xc4($s0)
/* AC0F7C 80049DDC 46805320 */  cvt.s.w $f12, $f10
/* AC0F80 80049DE0 46103482 */  mul.s $f18, $f6, $f16
/* AC0F84 80049DE4 44069000 */  mfc1  $a2, $f18
/* AC0F88 80049DE8 0C010E27 */  jal   func_8004389C
/* AC0F8C 80049DEC 00000000 */   nop
/* AC0F90 80049DF0 E60000C4 */  swc1  $f0, 0xc4($s0)
.L80049DF4:
/* AC0F94 80049DF4 3C028016 */  lui   $v0, %hi(gGameInfo) # $v0, 0x8016
/* AC0F98 80049DF8 8C42FA90 */  lw    $v0, %lo(gGameInfo)($v0)
/* AC0F9C 80049DFC 3C018014 */  lui   $at, %hi(D_80139F64)
/* AC0FA0 80049E00 C4209F64 */  lwc1  $f0, %lo(D_80139F64)($at)
/* AC0FA4 80049E04 84590198 */  lh    $t9, 0x198($v0)
/* AC0FA8 80049E08 844901C6 */  lh    $t1, 0x1c6($v0)
/* AC0FAC 80049E0C 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC0FB0 80049E10 44992000 */  mtc1  $t9, $f4
/* AC0FB4 80049E14 44894000 */  mtc1  $t1, $f8
/* AC0FB8 80049E18 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0FBC 80049E1C 468022A0 */  cvt.s.w $f10, $f4
/* AC0FC0 80049E20 C60E00CC */  lwc1  $f14, 0xcc($s0)
/* AC0FC4 80049E24 468041A0 */  cvt.s.w $f6, $f8
/* AC0FC8 80049E28 46005302 */  mul.s $f12, $f10, $f0
/* AC0FCC 80049E2C 00000000 */  nop
/* AC0FD0 80049E30 46003402 */  mul.s $f16, $f6, $f0
/* AC0FD4 80049E34 44068000 */  mfc1  $a2, $f16
/* AC0FD8 80049E38 0C010E27 */  jal   func_8004389C
/* AC0FDC 80049E3C 00000000 */   nop
/* AC0FE0 80049E40 3C018014 */  lui   $at, %hi(D_80139F68)
/* AC0FE4 80049E44 C4229F68 */  lwc1  $f2, %lo(D_80139F68)($at)
/* AC0FE8 80049E48 E60000CC */  swc1  $f0, 0xcc($s0)
/* AC0FEC 80049E4C 3C028016 */  lui   $v0, %hi(gGameInfo) # $v0, 0x8016
/* AC0FF0 80049E50 8C42FA90 */  lw    $v0, %lo(gGameInfo)($v0)
/* AC0FF4 80049E54 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC0FF8 80049E58 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC0FFC 80049E5C 844A019A */  lh    $t2, 0x19a($v0)
/* AC1000 80049E60 844B01C8 */  lh    $t3, 0x1c8($v0)
/* AC1004 80049E64 C60E00D0 */  lwc1  $f14, 0xd0($s0)
/* AC1008 80049E68 448A9000 */  mtc1  $t2, $f18
/* AC100C 80049E6C 448B5000 */  mtc1  $t3, $f10
/* AC1010 80049E70 46809120 */  cvt.s.w $f4, $f18
/* AC1014 80049E74 46805220 */  cvt.s.w $f8, $f10
/* AC1018 80049E78 46022302 */  mul.s $f12, $f4, $f2
/* AC101C 80049E7C 00000000 */  nop
/* AC1020 80049E80 46024182 */  mul.s $f6, $f8, $f2
/* AC1024 80049E84 44063000 */  mfc1  $a2, $f6
/* AC1028 80049E88 0C010E27 */  jal   func_8004389C
/* AC102C 80049E8C 00000000 */   nop
/* AC1030 80049E90 E60000D0 */  swc1  $f0, 0xd0($s0)
/* AC1034 80049E94 3C0C8016 */  lui   $t4, %hi(gGameInfo) # $t4, 0x8016
/* AC1038 80049E98 8D8CFA90 */  lw    $t4, %lo(gGameInfo)($t4)
/* AC103C 80049E9C 3C018014 */  lui   $at, %hi(D_80139F6C)
/* AC1040 80049EA0 C4249F6C */  lwc1  $f4, %lo(D_80139F6C)($at)
/* AC1044 80049EA4 858D019C */  lh    $t5, 0x19c($t4)
/* AC1048 80049EA8 3C063D4C */  lui   $a2, (0x3D4CCCCD >> 16) # lui $a2, 0x3d4c
/* AC104C 80049EAC 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC1050 80049EB0 448D8000 */  mtc1  $t5, $f16
/* AC1054 80049EB4 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC1058 80049EB8 34C6CCCD */  ori   $a2, (0x3D4CCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC105C 80049EBC 468084A0 */  cvt.s.w $f18, $f16
/* AC1060 80049EC0 46000386 */  mov.s $f14, $f0
/* AC1064 80049EC4 46049302 */  mul.s $f12, $f18, $f4
/* AC1068 80049EC8 0C010E27 */  jal   func_8004389C
/* AC106C 80049ECC 00000000 */   nop
/* AC1070 80049ED0 E60000D4 */  swc1  $f0, 0xd4($s0)
/* AC1074 80049ED4 8E060000 */  lw    $a2, ($s0)
/* AC1078 80049ED8 AFA00010 */  sw    $zero, 0x10($sp)
/* AC107C 80049EDC 02002025 */  move  $a0, $s0
/* AC1080 80049EE0 27A50088 */  addiu $a1, $sp, 0x88
/* AC1084 80049EE4 0C011635 */  jal   func_800458D4
/* AC1088 80049EE8 2627001C */   addiu $a3, $s1, 0x1c
/* AC108C 80049EEC 27AF0090 */  addiu $t7, $sp, 0x90
/* AC1090 80049EF0 8DE80000 */  lw    $t0, ($t7)
/* AC1094 80049EF4 27AE0080 */  addiu $t6, $sp, 0x80
/* AC1098 80049EF8 27A40078 */  addiu $a0, $sp, 0x78
/* AC109C 80049EFC ADC80000 */  sw    $t0, ($t6)
/* AC10A0 80049F00 8DF80004 */  lw    $t8, 4($t7)
/* AC10A4 80049F04 ADD80004 */  sw    $t8, 4($t6)
/* AC10A8 80049F08 8FA60040 */  lw    $a2, 0x40($sp)
/* AC10AC 80049F0C 0C01F124 */  jal   func_8007C490
/* AC10B0 80049F10 8FA5003C */   lw    $a1, 0x3c($sp)
/* AC10B4 80049F14 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* AC10B8 80049F18 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* AC10BC 80049F1C 3C018014 */  lui   $at, %hi(D_80139F70)
/* AC10C0 80049F20 C4269F70 */  lwc1  $f6, %lo(D_80139F70)($at)
/* AC10C4 80049F24 872901CE */  lh    $t1, 0x1ce($t9)
/* AC10C8 80049F28 C7AC0078 */  lwc1  $f12, 0x78($sp)
/* AC10CC 80049F2C C7AE0090 */  lwc1  $f14, 0x90($sp)
/* AC10D0 80049F30 44895000 */  mtc1  $t1, $f10
/* AC10D4 80049F34 3C073F80 */  lui   $a3, 0x3f80
/* AC10D8 80049F38 46805220 */  cvt.s.w $f8, $f10
/* AC10DC 80049F3C 46064402 */  mul.s $f16, $f8, $f6
/* AC10E0 80049F40 44068000 */  mfc1  $a2, $f16
/* AC10E4 80049F44 0C010E27 */  jal   func_8004389C
/* AC10E8 80049F48 00000000 */   nop
/* AC10EC 80049F4C 3C0A8016 */  lui   $t2, %hi(gGameInfo) # $t2, 0x8016
/* AC10F0 80049F50 8D4AFA90 */  lw    $t2, %lo(gGameInfo)($t2)
/* AC10F4 80049F54 E7A00080 */  swc1  $f0, 0x80($sp)
/* AC10F8 80049F58 3C018014 */  lui   $at, %hi(D_80139F74)
/* AC10FC 80049F5C 854B01CE */  lh    $t3, 0x1ce($t2)
/* AC1100 80049F60 C42A9F74 */  lwc1  $f10, %lo(D_80139F74)($at)
/* AC1104 80049F64 87A4007C */  lh    $a0, 0x7c($sp)
/* AC1108 80049F68 448B9000 */  mtc1  $t3, $f18
/* AC110C 80049F6C 87A50094 */  lh    $a1, 0x94($sp)
/* AC1110 80049F70 2407000A */  li    $a3, 10
/* AC1114 80049F74 46809120 */  cvt.s.w $f4, $f18
/* AC1118 80049F78 460A2202 */  mul.s $f8, $f4, $f10
/* AC111C 80049F7C 44064000 */  mfc1  $a2, $f8
/* AC1120 80049F80 0C010E47 */  jal   func_8004391C
/* AC1124 80049F84 00000000 */   nop
/* AC1128 80049F88 A7A20084 */  sh    $v0, 0x84($sp)
/* AC112C 80049F8C 862C0018 */  lh    $t4, 0x18($s1)
/* AC1130 80049F90 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC1134 80049F94 02002025 */  move  $a0, $s0
/* AC1138 80049F98 11800017 */  beqz  $t4, .L80049FF8
/* AC113C 80049F9C 87A5008E */   lh    $a1, 0x8e($sp)
/* AC1140 80049FA0 44813000 */  mtc1  $at, $f6
/* AC1144 80049FA4 C61000C8 */  lwc1  $f16, 0xc8($s0)
/* AC1148 80049FA8 86240016 */  lh    $a0, 0x16($s1)
/* AC114C 80049FAC 87A5008E */  lh    $a1, 0x8e($sp)
/* AC1150 80049FB0 46103483 */  div.s $f18, $f6, $f16
/* AC1154 80049FB4 2407000A */  li    $a3, 10
/* AC1158 80049FB8 44069000 */  mfc1  $a2, $f18
/* AC115C 80049FBC 0C010E47 */  jal   func_8004391C
/* AC1160 80049FC0 00000000 */   nop
/* AC1164 80049FC4 A7A20086 */  sh    $v0, 0x86($sp)
/* AC1168 80049FC8 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC116C 80049FCC 44812000 */  mtc1  $at, $f4
/* AC1170 80049FD0 C60A00C8 */  lwc1  $f10, 0xc8($s0)
/* AC1174 80049FD4 86240014 */  lh    $a0, 0x14($s1)
/* AC1178 80049FD8 87A5008C */  lh    $a1, 0x8c($sp)
/* AC117C 80049FDC 460A2203 */  div.s $f8, $f4, $f10
/* AC1180 80049FE0 2407000A */  li    $a3, 10
/* AC1184 80049FE4 44064000 */  mfc1  $a2, $f8
/* AC1188 80049FE8 0C010E47 */  jal   func_8004391C
/* AC118C 80049FEC 00000000 */   nop
/* AC1190 80049FF0 10000007 */  b     .L8004A010
/* AC1194 80049FF4 A7A20084 */   sh    $v0, 0x84($sp)
.L80049FF8:
/* AC1198 80049FF8 44803000 */  mtc1  $zero, $f6
/* AC119C 80049FFC 860600A2 */  lh    $a2, 0xa2($s0)
/* AC11A0 8004A000 8E070010 */  lw    $a3, 0x10($s0)
/* AC11A4 8004A004 0C011B2D */  jal   func_80046CB4
/* AC11A8 8004A008 E7A60010 */   swc1  $f6, 0x10($sp)
/* AC11AC 8004A00C A7A20086 */  sh    $v0, 0x86($sp)
.L8004A010:
/* AC11B0 8004A010 C6000004 */  lwc1  $f0, 4($s0)
/* AC11B4 8004A014 C7B00080 */  lwc1  $f16, 0x80($sp)
/* AC11B8 8004A018 C7B20080 */  lwc1  $f18, 0x80($sp)
/* AC11BC 8004A01C 3C028016 */  lui   $v0, %hi(gGameInfo) # $v0, 0x8016
/* AC11C0 8004A020 4600803C */  c.lt.s $f16, $f0
/* AC11C4 8004A024 27A40098 */  addiu $a0, $sp, 0x98
/* AC11C8 8004A028 27A60080 */  addiu $a2, $sp, 0x80
/* AC11CC 8004A02C 45020004 */  bc1fl .L8004A040
/* AC11D0 8004A030 C6000008 */   lwc1  $f0, 8($s0)
/* AC11D4 8004A034 10000007 */  b     .L8004A054
/* AC11D8 8004A038 E7A00080 */   swc1  $f0, 0x80($sp)
/* AC11DC 8004A03C C6000008 */  lwc1  $f0, 8($s0)
.L8004A040:
/* AC11E0 8004A040 4612003C */  c.lt.s $f0, $f18
/* AC11E4 8004A044 00000000 */  nop
/* AC11E8 8004A048 45000002 */  bc1f  .L8004A054
/* AC11EC 8004A04C 00000000 */   nop
/* AC11F0 8004A050 E7A00080 */  swc1  $f0, 0x80($sp)
.L8004A054:
/* AC11F4 8004A054 8C42FA90 */  lw    $v0, %lo(gGameInfo)($v0)
/* AC11F8 8004A058 87AD0084 */  lh    $t5, 0x84($sp)
/* AC11FC 8004A05C 87AE0084 */  lh    $t6, 0x84($sp)
/* AC1200 8004A060 8443019E */  lh    $v1, 0x19e($v0)
/* AC1204 8004A064 006D082A */  slt   $at, $v1, $t5
/* AC1208 8004A068 50200004 */  beql  $at, $zero, .L8004A07C
/* AC120C 8004A06C 844301DA */   lh    $v1, 0x1da($v0)
/* AC1210 8004A070 10000006 */  b     .L8004A08C
/* AC1214 8004A074 A7A30084 */   sh    $v1, 0x84($sp)
/* AC1218 8004A078 844301DA */  lh    $v1, 0x1da($v0)
.L8004A07C:
/* AC121C 8004A07C 01C3082A */  slt   $at, $t6, $v1
/* AC1220 8004A080 10200002 */  beqz  $at, .L8004A08C
/* AC1224 8004A084 00000000 */   nop
/* AC1228 8004A088 A7A30084 */  sh    $v1, 0x84($sp)
.L8004A08C:
/* AC122C 8004A08C 0C010F0A */  jal   func_80043C28
/* AC1230 8004A090 8FA5003C */   lw    $a1, 0x3c($sp)
/* AC1234 8004A094 8FA30038 */  lw    $v1, 0x38($sp)
/* AC1238 8004A098 C7A40098 */  lwc1  $f4, 0x98($sp)
/* AC123C 8004A09C 3C0F8016 */  lui   $t7, %hi(gGameInfo) # $t7, 0x8016
/* AC1240 8004A0A0 3C018014 */  lui   $at, %hi(D_80139F78)
/* AC1244 8004A0A4 E4640000 */  swc1  $f4, ($v1)
/* AC1248 8004A0A8 C7AA00A0 */  lwc1  $f10, 0xa0($sp)
/* AC124C 8004A0AC C4600004 */  lwc1  $f0, 4($v1)
/* AC1250 8004A0B0 E46A0008 */  swc1  $f10, 8($v1)
/* AC1254 8004A0B4 8DEFFA90 */  lw    $t7, %lo(gGameInfo)($t7)
/* AC1258 8004A0B8 C4309F78 */  lwc1  $f16, %lo(D_80139F78)($at)
/* AC125C 8004A0BC C7A4009C */  lwc1  $f4, 0x9c($sp)
/* AC1260 8004A0C0 85F801D2 */  lh    $t8, 0x1d2($t7)
/* AC1264 8004A0C4 24010007 */  li    $at, 7
/* AC1268 8004A0C8 46002281 */  sub.s $f10, $f4, $f0
/* AC126C 8004A0CC 44984000 */  mtc1  $t8, $f8
/* AC1270 8004A0D0 00000000 */  nop
/* AC1274 8004A0D4 468041A0 */  cvt.s.w $f6, $f8
/* AC1278 8004A0D8 46103482 */  mul.s $f18, $f6, $f16
/* AC127C 8004A0DC 00000000 */  nop
/* AC1280 8004A0E0 46125202 */  mul.s $f8, $f10, $f18
/* AC1284 8004A0E4 46080180 */  add.s $f6, $f0, $f8
/* AC1288 8004A0E8 E4660004 */  swc1  $f6, 4($v1)
/* AC128C 8004A0EC 86080140 */  lh    $t0, 0x140($s0)
/* AC1290 8004A0F0 15010037 */  bne   $t0, $at, .L8004A1D0
/* AC1294 8004A0F4 00000000 */   nop
/* AC1298 8004A0F8 8619001C */  lh    $t9, 0x1c($s0)
/* AC129C 8004A0FC 02002025 */  move  $a0, $s0
/* AC12A0 8004A100 27A50080 */  addiu $a1, $sp, 0x80
/* AC12A4 8004A104 33290010 */  andi  $t1, $t9, 0x10
/* AC12A8 8004A108 15200031 */  bnez  $t1, .L8004A1D0
/* AC12AC 8004A10C 27AA00A4 */   addiu $t2, $sp, 0xa4
/* AC12B0 8004A110 8E060004 */  lw    $a2, 4($s0)
/* AC12B4 8004A114 8E07000C */  lw    $a3, 0xc($s0)
/* AC12B8 8004A118 AFB10014 */  sw    $s1, 0x14($sp)
/* AC12BC 8004A11C 0C011B88 */  jal   func_80046E20
/* AC12C0 8004A120 AFAA0010 */   sw    $t2, 0x10($sp)
/* AC12C4 8004A124 860B001C */  lh    $t3, 0x1c($s0)
/* AC12C8 8004A128 87AD0094 */  lh    $t5, 0x94($sp)
/* AC12CC 8004A12C 27A40080 */  addiu $a0, $sp, 0x80
/* AC12D0 8004A130 316C0004 */  andi  $t4, $t3, 4
/* AC12D4 8004A134 11800008 */  beqz  $t4, .L8004A158
/* AC12D8 8004A138 8FA50040 */   lw    $a1, 0x40($sp)
/* AC12DC 8004A13C 000D7023 */  negu  $t6, $t5
/* AC12E0 8004A140 A60E0134 */  sh    $t6, 0x134($s0)
/* AC12E4 8004A144 87AF0096 */  lh    $t7, 0x96($sp)
/* AC12E8 8004A148 A6000138 */  sh    $zero, 0x138($s0)
/* AC12EC 8004A14C 25F88001 */  addiu $t8, $t7, -0x7fff
/* AC12F0 8004A150 10000008 */  b     .L8004A174
/* AC12F4 8004A154 A6180136 */   sh    $t8, 0x136($s0)
.L8004A158:
/* AC12F8 8004A158 0C01F124 */  jal   func_8007C490
/* AC12FC 8004A15C 8FA6003C */   lw    $a2, 0x3c($sp)
/* AC1300 8004A160 87A80084 */  lh    $t0, 0x84($sp)
/* AC1304 8004A164 A6080134 */  sh    $t0, 0x134($s0)
/* AC1308 8004A168 87B90086 */  lh    $t9, 0x86($sp)
/* AC130C 8004A16C A6000138 */  sh    $zero, 0x138($s0)
/* AC1310 8004A170 A6190136 */  sh    $t9, 0x136($s0)
.L8004A174:
/* AC1314 8004A174 86290018 */  lh    $t1, 0x18($s1)
/* AC1318 8004A178 3C018014 */  lui   $at, %hi(D_80139F7C)
/* AC131C 8004A17C C7A400A4 */  lwc1  $f4, 0xa4($sp)
/* AC1320 8004A180 51200020 */  beql  $t1, $zero, .L8004A204
/* AC1324 8004A184 8FA4003C */   lw    $a0, 0x3c($sp)
/* AC1328 8004A188 C4309F7C */  lwc1  $f16, %lo(D_80139F7C)($at)
/* AC132C 8004A18C 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC1330 8004A190 44819000 */  mtc1  $at, $f18
/* AC1334 8004A194 46048282 */  mul.s $f10, $f16, $f4
/* AC1338 8004A198 862A0016 */  lh    $t2, 0x16($s1)
/* AC133C 8004A19C 86050136 */  lh    $a1, 0x136($s0)
/* AC1340 8004A1A0 2407000A */  li    $a3, 10
/* AC1344 8004A1A4 254D8001 */  addiu $t5, $t2, -0x7fff
/* AC1348 8004A1A8 01A5C023 */  subu  $t8, $t5, $a1
/* AC134C 8004A1AC 00B82021 */  addu  $a0, $a1, $t8
/* AC1350 8004A1B0 460A9201 */  sub.s $f8, $f18, $f10
/* AC1354 8004A1B4 00042400 */  sll   $a0, $a0, 0x10
/* AC1358 8004A1B8 00042403 */  sra   $a0, $a0, 0x10
/* AC135C 8004A1BC 44064000 */  mfc1  $a2, $f8
/* AC1360 8004A1C0 0C010E47 */  jal   func_8004391C
/* AC1364 8004A1C4 00000000 */   nop
/* AC1368 8004A1C8 1000000D */  b     .L8004A200
/* AC136C 8004A1CC A6020136 */   sh    $v0, 0x136($s0)
.L8004A1D0:
/* AC1370 8004A1D0 C606000C */  lwc1  $f6, 0xc($s0)
/* AC1374 8004A1D4 A6200018 */  sh    $zero, 0x18($s1)
/* AC1378 8004A1D8 3C018012 */  lui   $at, %hi(D_8011D3E8) # $at, 0x8012
/* AC137C 8004A1DC E6260010 */  swc1  $f6, 0x10($s1)
/* AC1380 8004A1E0 AC20D3E8 */  sw    $zero, %lo(D_8011D3E8)($at)
/* AC1384 8004A1E4 8C690000 */  lw    $t1, ($v1)
/* AC1388 8004A1E8 8FA80040 */  lw    $t0, 0x40($sp)
/* AC138C 8004A1EC AD090000 */  sw    $t1, ($t0)
/* AC1390 8004A1F0 8C790004 */  lw    $t9, 4($v1)
/* AC1394 8004A1F4 AD190004 */  sw    $t9, 4($t0)
/* AC1398 8004A1F8 8C690008 */  lw    $t1, 8($v1)
/* AC139C 8004A1FC AD090008 */  sw    $t1, 8($t0)
.L8004A200:
/* AC13A0 8004A200 8FA4003C */  lw    $a0, 0x3c($sp)
.L8004A204:
/* AC13A4 8004A204 0C01EFE4 */  jal   func_8007BF90
/* AC13A8 8004A208 8FA50040 */   lw    $a1, 0x40($sp)
/* AC13AC 8004A20C E60000DC */  swc1  $f0, 0xdc($s0)
/* AC13B0 8004A210 00002025 */  move  $a0, $zero
/* AC13B4 8004A214 8605015A */  lh    $a1, 0x15a($s0)
/* AC13B8 8004A218 3C063F00 */  lui   $a2, 0x3f00
/* AC13BC 8004A21C 0C010E47 */  jal   func_8004391C
/* AC13C0 8004A220 2407000A */   li    $a3, 10
/* AC13C4 8004A224 A602015A */  sh    $v0, 0x15a($s0)
/* AC13C8 8004A228 02002025 */  move  $a0, $s0
/* AC13CC 8004A22C 0C011429 */  jal   func_800450A4
/* AC13D0 8004A230 8E050018 */   lw    $a1, 0x18($s0)
/* AC13D4 8004A234 E6000100 */  swc1  $f0, 0x100($s0)
/* AC13D8 8004A238 8FBF0024 */  lw    $ra, 0x24($sp)
/* AC13DC 8004A23C 8FB10020 */  lw    $s1, 0x20($sp)
/* AC13E0 8004A240 8FB0001C */  lw    $s0, 0x1c($sp)
/* AC13E4 8004A244 27BD00B8 */  addiu $sp, $sp, 0xb8
/* AC13E8 8004A248 03E00008 */  jr    $ra
/* AC13EC 8004A24C 24020001 */   li    $v0, 1
