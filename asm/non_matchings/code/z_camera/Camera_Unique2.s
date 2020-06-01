.late_rodata
glabel D_8013A1EC
    .float 0.01

glabel D_8013A1F0
    .float 0.6

glabel D_8013A1F4
    .float 0.4

glabel D_8013A1F8
    .float 0.05

glabel D_8013A1FC
    .float 0.2

glabel D_8013A200
    .float 0.2

.text
glabel Camera_Unique2
/* AC8CDC 80051B3C 27BDFF78 */  addiu $sp, $sp, -0x88
/* AC8CE0 80051B40 AFB0001C */  sw    $s0, 0x1c($sp)
/* AC8CE4 80051B44 00808025 */  move  $s0, $a0
/* AC8CE8 80051B48 AFBF0024 */  sw    $ra, 0x24($sp)
/* AC8CEC 80051B4C AFB10020 */  sw    $s1, 0x20($sp)
/* AC8CF0 80051B50 0C00B721 */  jal   Player_GetCameraYOffset
/* AC8CF4 80051B54 8C840090 */   lw    $a0, 0x90($a0)
/* AC8CF8 80051B58 26110050 */  addiu $s1, $s0, 0x50
/* AC8CFC 80051B5C 2606005C */  addiu $a2, $s0, 0x5c
/* AC8D00 80051B60 E7A00048 */  swc1  $f0, 0x48($sp)
/* AC8D04 80051B64 AFA6003C */  sw    $a2, 0x3c($sp)
/* AC8D08 80051B68 02202825 */  move  $a1, $s1
/* AC8D0C 80051B6C 0C01F124 */  jal   func_8007C490
/* AC8D10 80051B70 27A40060 */   addiu $a0, $sp, 0x60
/* AC8D14 80051B74 8603015E */  lh    $v1, 0x15e($s0)
/* AC8D18 80051B78 2401000A */  li    $at, 10
/* AC8D1C 80051B7C 10600008 */  beqz  $v1, .L80051BA0
/* AC8D20 80051B80 00000000 */   nop
/* AC8D24 80051B84 10610006 */  beq   $v1, $at, .L80051BA0
/* AC8D28 80051B88 24010014 */   li    $at, 20
/* AC8D2C 80051B8C 10610004 */  beq   $v1, $at, .L80051BA0
/* AC8D30 80051B90 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC8D34 80051B94 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC8D38 80051B98 85C30314 */  lh    $v1, 0x314($t6)
/* AC8D3C 80051B9C 10600033 */  beqz  $v1, .L80051C6C
.L80051BA0:
/* AC8D40 80051BA0 3C0B8016 */   lui   $t3, %hi(gGameInfo) # $t3, 0x8016
/* AC8D44 80051BA4 8D6BFA90 */  lw    $t3, %lo(gGameInfo)($t3)
/* AC8D48 80051BA8 3C018014 */  lui   $at, %hi(D_8013A1EC)
/* AC8D4C 80051BAC C42CA1EC */  lwc1  $f12, %lo(D_8013A1EC)($at)
/* AC8D50 80051BB0 856C01F0 */  lh    $t4, 0x1f0($t3)
/* AC8D54 80051BB4 3C014288 */  li    $at, 0x42880000 # 0.000000
/* AC8D58 80051BB8 44814000 */  mtc1  $at, $f8
/* AC8D5C 80051BBC 448C2000 */  mtc1  $t4, $f4
/* AC8D60 80051BC0 C7AA0048 */  lwc1  $f10, 0x48($sp)
/* AC8D64 80051BC4 860F0142 */  lh    $t7, 0x142($s0)
/* AC8D68 80051BC8 468021A0 */  cvt.s.w $f6, $f4
/* AC8D6C 80051BCC 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC8D70 80051BD0 000FC0C0 */  sll   $t8, $t7, 3
/* AC8D74 80051BD4 86080144 */  lh    $t0, 0x144($s0)
/* AC8D78 80051BD8 0338C821 */  addu  $t9, $t9, $t8
/* AC8D7C 80051BDC 460A4103 */  div.s $f4, $f8, $f10
/* AC8D80 80051BE0 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC8D84 80051BE4 000848C0 */  sll   $t1, $t0, 3
/* AC8D88 80051BE8 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC8D8C 80051BEC 460C3002 */  mul.s $f0, $f6, $f12
/* AC8D90 80051BF0 03295021 */  addu  $t2, $t9, $t1
/* AC8D94 80051BF4 8D420004 */  lw    $v0, 4($t2)
/* AC8D98 80051BF8 44814000 */  mtc1  $at, $f8
/* AC8D9C 80051BFC 3C088016 */  lui   $t0, %hi(gGameInfo) # $t0, 0x8016
/* AC8DA0 80051C00 844D0000 */  lh    $t5, ($v0)
/* AC8DA4 80051C04 2442000C */  addiu $v0, $v0, 0xc
/* AC8DA8 80051C08 46040182 */  mul.s $f6, $f0, $f4
/* AC8DAC 80051C0C 46004100 */  add.s $f4, $f8, $f0
/* AC8DB0 80051C10 448D4000 */  mtc1  $t5, $f8
/* AC8DB4 80051C14 46062081 */  sub.s $f2, $f4, $f6
/* AC8DB8 80051C18 46804120 */  cvt.s.w $f4, $f8
/* AC8DBC 80051C1C 460C2182 */  mul.s $f6, $f4, $f12
/* AC8DC0 80051C20 00000000 */  nop
/* AC8DC4 80051C24 460A3202 */  mul.s $f8, $f6, $f10
/* AC8DC8 80051C28 00000000 */  nop
/* AC8DCC 80051C2C 46024102 */  mul.s $f4, $f8, $f2
/* AC8DD0 80051C30 E6040000 */  swc1  $f4, ($s0)
/* AC8DD4 80051C34 844EFFF8 */  lh    $t6, -8($v0)
/* AC8DD8 80051C38 448E3000 */  mtc1  $t6, $f6
/* AC8DDC 80051C3C 00000000 */  nop
/* AC8DE0 80051C40 468032A0 */  cvt.s.w $f10, $f6
/* AC8DE4 80051C44 E60A0004 */  swc1  $f10, 4($s0)
/* AC8DE8 80051C48 844FFFFC */  lh    $t7, -4($v0)
/* AC8DEC 80051C4C 448F4000 */  mtc1  $t7, $f8
/* AC8DF0 80051C50 00000000 */  nop
/* AC8DF4 80051C54 46804120 */  cvt.s.w $f4, $f8
/* AC8DF8 80051C58 E6040008 */  swc1  $f4, 8($s0)
/* AC8DFC 80051C5C 84580000 */  lh    $t8, ($v0)
/* AC8E00 80051C60 A618000C */  sh    $t8, 0xc($s0)
/* AC8E04 80051C64 8D08FA90 */  lw    $t0, %lo(gGameInfo)($t0)
/* AC8E08 80051C68 85030314 */  lh    $v1, 0x314($t0)
.L80051C6C:
/* AC8E0C 80051C6C 50600004 */  beql  $v1, $zero, .L80051C80
/* AC8E10 80051C70 8619000C */   lh    $t9, 0xc($s0)
/* AC8E14 80051C74 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC8E18 80051C78 02002025 */   move  $a0, $s0
/* AC8E1C 80051C7C 8619000C */  lh    $t9, 0xc($s0)
.L80051C80:
/* AC8E20 80051C80 3C018012 */  lui   $at, %hi(D_8011D3A0) # $at, 0x8012
/* AC8E24 80051C84 26020010 */  addiu $v0, $s0, 0x10
/* AC8E28 80051C88 AC39D3A0 */  sw    $t9, %lo(D_8011D3A0)($at)
/* AC8E2C 80051C8C 8603015E */  lh    $v1, 0x15e($s0)
/* AC8E30 80051C90 240C0001 */  li    $t4, 1
/* AC8E34 80051C94 02002025 */  move  $a0, $s0
/* AC8E38 80051C98 50600006 */  beql  $v1, $zero, .L80051CB4
/* AC8E3C 80051C9C 860B000C */   lh    $t3, 0xc($s0)
/* AC8E40 80051CA0 8609000C */  lh    $t1, 0xc($s0)
/* AC8E44 80051CA4 844A0004 */  lh    $t2, 4($v0)
/* AC8E48 80051CA8 112A0005 */  beq   $t1, $t2, .L80051CC0
/* AC8E4C 80051CAC 00000000 */   nop
/* AC8E50 80051CB0 860B000C */  lh    $t3, 0xc($s0)
.L80051CB4:
/* AC8E54 80051CB4 26020010 */  addiu $v0, $s0, 0x10
/* AC8E58 80051CB8 A44B0004 */  sh    $t3, 4($v0)
/* AC8E5C 80051CBC 8603015E */  lh    $v1, 0x15e($s0)
.L80051CC0:
/* AC8E60 80051CC0 54600011 */  bnezl $v1, .L80051D08
/* AC8E64 80051CC4 8E090094 */   lw    $t1, 0x94($s0)
/* AC8E68 80051CC8 A60C015E */  sh    $t4, 0x15e($s0)
/* AC8E6C 80051CCC 0C010ED8 */  jal   func_80043B60
/* AC8E70 80051CD0 AFA20034 */   sw    $v0, 0x34($sp)
/* AC8E74 80051CD4 3C014348 */  li    $at, 0x43480000 # 0.000000
/* AC8E78 80051CD8 8FA20034 */  lw    $v0, 0x34($sp)
/* AC8E7C 80051CDC 44813000 */  mtc1  $at, $f6
/* AC8E80 80051CE0 00000000 */  nop
/* AC8E84 80051CE4 E4460000 */  swc1  $f6, ($v0)
/* AC8E88 80051CE8 860D000C */  lh    $t5, 0xc($s0)
/* AC8E8C 80051CEC 31AE0010 */  andi  $t6, $t5, 0x10
/* AC8E90 80051CF0 51C00005 */  beql  $t6, $zero, .L80051D08
/* AC8E94 80051CF4 8E090094 */   lw    $t1, 0x94($s0)
/* AC8E98 80051CF8 860F014C */  lh    $t7, 0x14c($s0)
/* AC8E9C 80051CFC 31F8FFFB */  andi  $t8, $t7, 0xfffb
/* AC8EA0 80051D00 A618014C */  sh    $t8, 0x14c($s0)
/* AC8EA4 80051D04 8E090094 */  lw    $t1, 0x94($s0)
.L80051D08:
/* AC8EA8 80051D08 27A80070 */  addiu $t0, $sp, 0x70
/* AC8EAC 80051D0C 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC8EB0 80051D10 AD090000 */  sw    $t1, ($t0)
/* AC8EB4 80051D14 8E190098 */  lw    $t9, 0x98($s0)
/* AC8EB8 80051D18 27A40068 */  addiu $a0, $sp, 0x68
/* AC8EBC 80051D1C 02202825 */  move  $a1, $s1
/* AC8EC0 80051D20 AD190004 */  sw    $t9, 4($t0)
/* AC8EC4 80051D24 8E09009C */  lw    $t1, 0x9c($s0)
/* AC8EC8 80051D28 AD090008 */  sw    $t1, 8($t0)
/* AC8ECC 80051D2C 860A000C */  lh    $t2, 0xc($s0)
/* AC8ED0 80051D30 C7AA0070 */  lwc1  $f10, 0x70($sp)
/* AC8ED4 80051D34 314B0001 */  andi  $t3, $t2, 1
/* AC8ED8 80051D38 51600005 */  beql  $t3, $zero, .L80051D50
/* AC8EDC 80051D3C C61000E0 */   lwc1  $f16, 0xe0($s0)
/* AC8EE0 80051D40 44818000 */  mtc1  $at, $f16
/* AC8EE4 80051D44 10000003 */  b     .L80051D54
/* AC8EE8 80051D48 C6200000 */   lwc1  $f0, ($s1)
/* AC8EEC 80051D4C C61000E0 */  lwc1  $f16, 0xe0($s0)
.L80051D50:
/* AC8EF0 80051D50 C6200000 */  lwc1  $f0, ($s1)
.L80051D54:
/* AC8EF4 80051D54 3C018014 */  lui   $at, %hi(D_8013A1F0)
/* AC8EF8 80051D58 C432A1F0 */  lwc1  $f18, %lo(D_8013A1F0)($at)
/* AC8EFC 80051D5C 46005201 */  sub.s $f8, $f10, $f0
/* AC8F00 80051D60 C6220004 */  lwc1  $f2, 4($s1)
/* AC8F04 80051D64 3C018014 */  lui   $at, %hi(D_8013A1F4)
/* AC8F08 80051D68 C62C0008 */  lwc1  $f12, 8($s1)
/* AC8F0C 80051D6C 46104102 */  mul.s $f4, $f8, $f16
/* AC8F10 80051D70 00000000 */  nop
/* AC8F14 80051D74 46122182 */  mul.s $f6, $f4, $f18
/* AC8F18 80051D78 46060280 */  add.s $f10, $f0, $f6
/* AC8F1C 80051D7C E62A0000 */  swc1  $f10, ($s1)
/* AC8F20 80051D80 C7A40048 */  lwc1  $f4, 0x48($sp)
/* AC8F24 80051D84 C7A80074 */  lwc1  $f8, 0x74($sp)
/* AC8F28 80051D88 C60A0000 */  lwc1  $f10, ($s0)
/* AC8F2C 80051D8C 46044180 */  add.s $f6, $f8, $f4
/* AC8F30 80051D90 460A3200 */  add.s $f8, $f6, $f10
/* AC8F34 80051D94 C426A1F4 */  lwc1  $f6, %lo(D_8013A1F4)($at)
/* AC8F38 80051D98 3C014000 */  li    $at, 0x40000000 # 0.000000
/* AC8F3C 80051D9C 46024101 */  sub.s $f4, $f8, $f2
/* AC8F40 80051DA0 46062282 */  mul.s $f10, $f4, $f6
/* AC8F44 80051DA4 460A1200 */  add.s $f8, $f2, $f10
/* AC8F48 80051DA8 E6280004 */  swc1  $f8, 4($s1)
/* AC8F4C 80051DAC C7A40078 */  lwc1  $f4, 0x78($sp)
/* AC8F50 80051DB0 460C2181 */  sub.s $f6, $f4, $f12
/* AC8F54 80051DB4 46103282 */  mul.s $f10, $f6, $f16
/* AC8F58 80051DB8 44813000 */  mtc1  $at, $f6
/* AC8F5C 80051DBC 3C018014 */  lui   $at, %hi(D_8013A1F8)
/* AC8F60 80051DC0 46125202 */  mul.s $f8, $f10, $f18
/* AC8F64 80051DC4 46086100 */  add.s $f4, $f12, $f8
/* AC8F68 80051DC8 E6240008 */  swc1  $f4, 8($s1)
/* AC8F6C 80051DCC C44E0000 */  lwc1  $f14, ($v0)
/* AC8F70 80051DD0 C428A1F8 */  lwc1  $f8, %lo(D_8013A1F8)($at)
/* AC8F74 80051DD4 460E3281 */  sub.s $f10, $f6, $f14
/* AC8F78 80051DD8 46085102 */  mul.s $f4, $f10, $f8
/* AC8F7C 80051DDC 46047180 */  add.s $f6, $f14, $f4
/* AC8F80 80051DE0 E4460000 */  swc1  $f6, ($v0)
/* AC8F84 80051DE4 8603000C */  lh    $v1, 0xc($s0)
/* AC8F88 80051DE8 306C0001 */  andi  $t4, $v1, 1
/* AC8F8C 80051DEC 11800015 */  beqz  $t4, .L80051E44
/* AC8F90 80051DF0 306D0002 */   andi  $t5, $v1, 2
/* AC8F94 80051DF4 0C01F124 */  jal   func_8007C490
/* AC8F98 80051DF8 26060074 */   addiu $a2, $s0, 0x74
/* AC8F9C 80051DFC C60A0004 */  lwc1  $f10, 4($s0)
/* AC8FA0 80051E00 27A40070 */  addiu $a0, $sp, 0x70
/* AC8FA4 80051E04 02202825 */  move  $a1, $s1
/* AC8FA8 80051E08 27A60068 */  addiu $a2, $sp, 0x68
/* AC8FAC 80051E0C 0C010F0A */  jal   func_80043C28
/* AC8FB0 80051E10 E7AA0068 */   swc1  $f10, 0x68($sp)
/* AC8FB4 80051E14 3C013E80 */  li    $at, 0x3E800000 # 0.000000
/* AC8FB8 80051E18 44810000 */  mtc1  $at, $f0
/* AC8FBC 80051E1C 3C018014 */  lui   $at, %hi(D_8013A1FC)
/* AC8FC0 80051E20 C428A1FC */  lwc1  $f8, %lo(D_8013A1FC)($at)
/* AC8FC4 80051E24 44060000 */  mfc1  $a2, $f0
/* AC8FC8 80051E28 44070000 */  mfc1  $a3, $f0
/* AC8FCC 80051E2C 27A40070 */  addiu $a0, $sp, 0x70
/* AC8FD0 80051E30 8FA5003C */  lw    $a1, 0x3c($sp)
/* AC8FD4 80051E34 0C010E8F */  jal   func_80043A3C
/* AC8FD8 80051E38 E7A80010 */   swc1  $f8, 0x10($sp)
/* AC8FDC 80051E3C 1000002C */  b     .L80051EF0
/* AC8FE0 80051E40 02002025 */   move  $a0, $s0
.L80051E44:
/* AC8FE4 80051E44 11A00029 */  beqz  $t5, .L80051EEC
/* AC8FE8 80051E48 02202025 */   move  $a0, $s1
/* AC8FEC 80051E4C 26050074 */  addiu $a1, $s0, 0x74
/* AC8FF0 80051E50 0C01F00A */  jal   func_8007C028
/* AC8FF4 80051E54 AFA50034 */   sw    $a1, 0x34($sp)
/* AC8FF8 80051E58 C6040004 */  lwc1  $f4, 4($s0)
/* AC8FFC 80051E5C 8FA60034 */  lw    $a2, 0x34($sp)
/* AC9000 80051E60 3C013E80 */  li    $at, 0x3E800000 # 0.000000
/* AC9004 80051E64 4604003C */  c.lt.s $f0, $f4
/* AC9008 80051E68 8FA40034 */  lw    $a0, 0x34($sp)
/* AC900C 80051E6C 8FA5003C */  lw    $a1, 0x3c($sp)
/* AC9010 80051E70 45020018 */  bc1fl .L80051ED4
/* AC9014 80051E74 44810000 */   mtc1  $at, $f0
/* AC9018 80051E78 27A40068 */  addiu $a0, $sp, 0x68
/* AC901C 80051E7C 0C01F124 */  jal   func_8007C490
/* AC9020 80051E80 02202825 */   move  $a1, $s1
/* AC9024 80051E84 3C063DCC */  li    $a2, 0x3DCC0000 # 0.000000
/* AC9028 80051E88 34C6CCCD */  ori   $a2, (0x3DCCCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC902C 80051E8C 87A4006E */  lh    $a0, 0x6e($sp)
/* AC9030 80051E90 87A50066 */  lh    $a1, 0x66($sp)
/* AC9034 80051E94 0C010E47 */  jal   func_8004391C
/* AC9038 80051E98 2407000A */   li    $a3, 10
/* AC903C 80051E9C A7A2006E */  sh    $v0, 0x6e($sp)
/* AC9040 80051EA0 C6060004 */  lwc1  $f6, 4($s0)
/* AC9044 80051EA4 A7A0006C */  sh    $zero, 0x6c($sp)
/* AC9048 80051EA8 8FA4003C */  lw    $a0, 0x3c($sp)
/* AC904C 80051EAC 02202825 */  move  $a1, $s1
/* AC9050 80051EB0 27A60068 */  addiu $a2, $sp, 0x68
/* AC9054 80051EB4 0C010F0A */  jal   func_80043C28
/* AC9058 80051EB8 E7A60068 */   swc1  $f6, 0x68($sp)
/* AC905C 80051EBC 8FAE0034 */  lw    $t6, 0x34($sp)
/* AC9060 80051EC0 8FAF003C */  lw    $t7, 0x3c($sp)
/* AC9064 80051EC4 C5CA0004 */  lwc1  $f10, 4($t6)
/* AC9068 80051EC8 10000008 */  b     .L80051EEC
/* AC906C 80051ECC E5EA0004 */   swc1  $f10, 4($t7)
/* AC9070 80051ED0 44810000 */  mtc1  $at, $f0
.L80051ED4:
/* AC9074 80051ED4 3C018014 */  lui   $at, %hi(D_8013A200)
/* AC9078 80051ED8 C428A200 */  lwc1  $f8, %lo(D_8013A200)($at)
/* AC907C 80051EDC 44060000 */  mfc1  $a2, $f0
/* AC9080 80051EE0 44070000 */  mfc1  $a3, $f0
/* AC9084 80051EE4 0C010E8F */  jal   func_80043A3C
/* AC9088 80051EE8 E7A80010 */   swc1  $f8, 0x10($sp)
.L80051EEC:
/* AC908C 80051EEC 02002025 */  move  $a0, $s0
.L80051EF0:
/* AC9090 80051EF0 02202825 */  move  $a1, $s1
/* AC9094 80051EF4 0C010FCD */  jal   func_80043F34
/* AC9098 80051EF8 8FA6003C */   lw    $a2, 0x3c($sp)
/* AC909C 80051EFC 02202025 */  move  $a0, $s1
/* AC90A0 80051F00 0C01EFE4 */  jal   func_8007BF90
/* AC90A4 80051F04 8FA5003C */   lw    $a1, 0x3c($sp)
/* AC90A8 80051F08 3C063E4C */  lui   $a2, (0x3E4CCCCD >> 16) # lui $a2, 0x3e4c
/* AC90AC 80051F0C 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC90B0 80051F10 E60000DC */  swc1  $f0, 0xdc($s0)
/* AC90B4 80051F14 A600015A */  sh    $zero, 0x15a($s0)
/* AC90B8 80051F18 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC90BC 80051F1C 34C6CCCD */  ori   $a2, (0x3E4CCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC90C0 80051F20 C60C0008 */  lwc1  $f12, 8($s0)
/* AC90C4 80051F24 0C010E27 */  jal   func_8004389C
/* AC90C8 80051F28 C60E00FC */   lwc1  $f14, 0xfc($s0)
/* AC90CC 80051F2C E60000FC */  swc1  $f0, 0xfc($s0)
/* AC90D0 80051F30 02002025 */  move  $a0, $s0
/* AC90D4 80051F34 0C011429 */  jal   func_800450A4
/* AC90D8 80051F38 3C053F80 */   lui   $a1, 0x3f80
/* AC90DC 80051F3C E6000100 */  swc1  $f0, 0x100($s0)
/* AC90E0 80051F40 8FBF0024 */  lw    $ra, 0x24($sp)
/* AC90E4 80051F44 8FB10020 */  lw    $s1, 0x20($sp)
/* AC90E8 80051F48 8FB0001C */  lw    $s0, 0x1c($sp)
/* AC90EC 80051F4C 27BD0088 */  addiu $sp, $sp, 0x88
/* AC90F0 80051F50 03E00008 */  jr    $ra
/* AC90F4 80051F54 24020001 */   li    $v0, 1
