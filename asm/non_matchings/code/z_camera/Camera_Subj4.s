.late_rodata
glabel D_8013A1B0
    .float 0.416667

.text
glabel Camera_Subj4
/* AC7CC4 80050B24 27BDFF48 */  addiu $sp, $sp, -0xb8
/* AC7CC8 80050B28 AFBF0024 */  sw    $ra, 0x24($sp)
/* AC7CCC 80050B2C AFB30020 */  sw    $s3, 0x20($sp)
/* AC7CD0 80050B30 AFB2001C */  sw    $s2, 0x1c($sp)
/* AC7CD4 80050B34 AFB10018 */  sw    $s1, 0x18($sp)
/* AC7CD8 80050B38 AFB00014 */  sw    $s0, 0x14($sp)
/* AC7CDC 80050B3C 8482015E */  lh    $v0, 0x15e($a0)
/* AC7CE0 80050B40 00808825 */  move  $s1, $a0
/* AC7CE4 80050B44 2401000A */  li    $at, 10
/* AC7CE8 80050B48 5040000A */  beql  $v0, $zero, .L80050B74
/* AC7CEC 80050B4C 862F0142 */   lh    $t7, 0x142($s1)
/* AC7CF0 80050B50 10410007 */  beq   $v0, $at, .L80050B70
/* AC7CF4 80050B54 24010014 */   li    $at, 20
/* AC7CF8 80050B58 10410005 */  beq   $v0, $at, .L80050B70
/* AC7CFC 80050B5C 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC7D00 80050B60 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC7D04 80050B64 85C20314 */  lh    $v0, 0x314($t6)
/* AC7D08 80050B68 1040000F */  beqz  $v0, .L80050BA8
/* AC7D0C 80050B6C 00000000 */   nop
.L80050B70:
/* AC7D10 80050B70 862F0142 */  lh    $t7, 0x142($s1)
.L80050B74:
/* AC7D14 80050B74 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC7D18 80050B78 86280144 */  lh    $t0, 0x144($s1)
/* AC7D1C 80050B7C 000FC0C0 */  sll   $t8, $t7, 3
/* AC7D20 80050B80 0338C821 */  addu  $t9, $t9, $t8
/* AC7D24 80050B84 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC7D28 80050B88 000848C0 */  sll   $t1, $t0, 3
/* AC7D2C 80050B8C 3C0C8016 */  lui   $t4, %hi(gGameInfo) # $t4, 0x8016
/* AC7D30 80050B90 03295021 */  addu  $t2, $t9, $t1
/* AC7D34 80050B94 8D430004 */  lw    $v1, 4($t2)
/* AC7D38 80050B98 846B0000 */  lh    $t3, ($v1)
/* AC7D3C 80050B9C A62B0000 */  sh    $t3, ($s1)
/* AC7D40 80050BA0 8D8CFA90 */  lw    $t4, %lo(gGameInfo)($t4)
/* AC7D44 80050BA4 85820314 */  lh    $v0, 0x314($t4)
.L80050BA8:
/* AC7D48 80050BA8 50400004 */  beql  $v0, $zero, .L80050BBC
/* AC7D4C 80050BAC 8E23008C */   lw    $v1, 0x8c($s1)
/* AC7D50 80050BB0 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC7D54 80050BB4 02202025 */   move  $a0, $s1
/* AC7D58 80050BB8 8E23008C */  lw    $v1, 0x8c($s1)
.L80050BBC:
/* AC7D5C 80050BBC 27A4006C */  addiu $a0, $sp, 0x6c
/* AC7D60 80050BC0 8C6D01DC */  lw    $t5, 0x1dc($v1)
/* AC7D64 80050BC4 15A00008 */  bnez  $t5, .L80050BE8
/* AC7D68 80050BC8 00000000 */   nop
/* AC7D6C 80050BCC 862E0164 */  lh    $t6, 0x164($s1)
/* AC7D70 80050BD0 24020001 */  li    $v0, 1
/* AC7D74 80050BD4 35CF0050 */  ori   $t7, $t6, 0x50
/* AC7D78 80050BD8 AC6F01DC */  sw    $t7, 0x1dc($v1)
/* AC7D7C 80050BDC C62400D8 */  lwc1  $f4, 0xd8($s1)
/* AC7D80 80050BE0 10000168 */  b     .L80051184
/* AC7D84 80050BE4 E6240028 */   swc1  $f4, 0x28($s1)
.L80050BE8:
/* AC7D88 80050BE8 0C00BBD1 */  jal   func_8002EF44
/* AC7D8C 80050BEC 8E250090 */   lw    $a1, 0x90($s1)
/* AC7D90 80050BF0 26320050 */  addiu $s2, $s1, 0x50
/* AC7D94 80050BF4 2633005C */  addiu $s3, $s1, 0x5c
/* AC7D98 80050BF8 02603025 */  move  $a2, $s3
/* AC7D9C 80050BFC 02402825 */  move  $a1, $s2
/* AC7DA0 80050C00 0C01F124 */  jal   func_8007C490
/* AC7DA4 80050C04 27A4005C */   addiu $a0, $sp, 0x5c
/* AC7DA8 80050C08 86380000 */  lh    $t8, ($s1)
/* AC7DAC 80050C0C 3C018012 */  lui   $at, %hi(D_8011D3A0)
/* AC7DB0 80050C10 02202025 */  move  $a0, $s1
/* AC7DB4 80050C14 AC38D3A0 */  sw    $t8, %lo(D_8011D3A0)($at)
/* AC7DB8 80050C18 8628015E */  lh    $t0, 0x15e($s1)
/* AC7DBC 80050C1C 55000056 */  bnezl $t0, .L80050D78
/* AC7DC0 80050C20 26300004 */   addiu $s0, $s1, 4
/* AC7DC4 80050C24 0C011207 */  jal   func_8004481C
/* AC7DC8 80050C28 27A500AA */   addiu $a1, $sp, 0xaa
/* AC7DCC 80050C2C 26300004 */  addiu $s0, $s1, 4
/* AC7DD0 80050C30 AFA200A4 */  sw    $v0, 0xa4($sp)
/* AC7DD4 80050C34 02002025 */  move  $a0, $s0
/* AC7DD8 80050C38 0C010EF1 */  jal   func_80043BC4
/* AC7DDC 80050C3C 24450006 */   addiu $a1, $v0, 6
/* AC7DE0 80050C40 97B900AA */  lhu   $t9, 0xaa($sp)
/* AC7DE4 80050C44 8FAA00A4 */  lw    $t2, 0xa4($sp)
/* AC7DE8 80050C48 27A40098 */  addiu $a0, $sp, 0x98
/* AC7DEC 80050C4C 00194880 */  sll   $t1, $t9, 2
/* AC7DF0 80050C50 01394823 */  subu  $t1, $t1, $t9
/* AC7DF4 80050C54 00094840 */  sll   $t1, $t1, 1
/* AC7DF8 80050C58 012A2821 */  addu  $a1, $t1, $t2
/* AC7DFC 80050C5C 0C010EF1 */  jal   func_80043BC4
/* AC7E00 80050C60 24A5FFF4 */   addiu $a1, $a1, -0xc
/* AC7E04 80050C64 3C014120 */  li    $at, 0x41200000 # 0.000000
/* AC7E08 80050C68 44813000 */  mtc1  $at, $f6
/* AC7E0C 80050C6C 240B238C */  li    $t3, 9100
/* AC7E10 80050C70 A7AB0068 */  sh    $t3, 0x68($sp)
/* AC7E14 80050C74 27A40098 */  addiu $a0, $sp, 0x98
/* AC7E18 80050C78 02002825 */  move  $a1, $s0
/* AC7E1C 80050C7C 0C01129D */  jal   func_80044A74
/* AC7E20 80050C80 E7A60064 */   swc1  $f6, 0x64($sp)
/* AC7E24 80050C84 26240094 */  addiu $a0, $s1, 0x94
/* AC7E28 80050C88 A7A2006A */  sh    $v0, 0x6a($sp)
/* AC7E2C 80050C8C AFA40034 */  sw    $a0, 0x34($sp)
/* AC7E30 80050C90 0C01EFE4 */  jal   func_8007BF90
/* AC7E34 80050C94 02002825 */   move  $a1, $s0
/* AC7E38 80050C98 8FA40034 */  lw    $a0, 0x34($sp)
/* AC7E3C 80050C9C 27A50098 */  addiu $a1, $sp, 0x98
/* AC7E40 80050CA0 0C01EFE4 */  jal   func_8007BF90
/* AC7E44 80050CA4 E7A00088 */   swc1  $f0, 0x88($sp)
/* AC7E48 80050CA8 C7A20088 */  lwc1  $f2, 0x88($sp)
/* AC7E4C 80050CAC C7AA0098 */  lwc1  $f10, 0x98($sp)
/* AC7E50 80050CB0 2419000A */  li    $t9, 10
/* AC7E54 80050CB4 4602003C */  c.lt.s $f0, $f2
/* AC7E58 80050CB8 00000000 */  nop
/* AC7E5C 80050CBC 45020016 */  bc1fl .L80050D18
/* AC7E60 80050CC0 C6040000 */   lwc1  $f4, ($s0)
/* AC7E64 80050CC4 C6080000 */  lwc1  $f8, ($s0)
/* AC7E68 80050CC8 C7AA0098 */  lwc1  $f10, 0x98($sp)
/* AC7E6C 80050CCC C6060004 */  lwc1  $f6, 4($s0)
/* AC7E70 80050CD0 27AC0098 */  addiu $t4, $sp, 0x98
/* AC7E74 80050CD4 460A4101 */  sub.s $f4, $f8, $f10
/* AC7E78 80050CD8 E604000C */  swc1  $f4, 0xc($s0)
/* AC7E7C 80050CDC C7A8009C */  lwc1  $f8, 0x9c($sp)
/* AC7E80 80050CE0 C6040008 */  lwc1  $f4, 8($s0)
/* AC7E84 80050CE4 46083281 */  sub.s $f10, $f6, $f8
/* AC7E88 80050CE8 E60A0010 */  swc1  $f10, 0x10($s0)
/* AC7E8C 80050CEC C7A600A0 */  lwc1  $f6, 0xa0($sp)
/* AC7E90 80050CF0 46062201 */  sub.s $f8, $f4, $f6
/* AC7E94 80050CF4 E6080014 */  swc1  $f8, 0x14($s0)
/* AC7E98 80050CF8 8D8E0000 */  lw    $t6, ($t4)
/* AC7E9C 80050CFC AE0E0000 */  sw    $t6, ($s0)
/* AC7EA0 80050D00 8D8D0004 */  lw    $t5, 4($t4)
/* AC7EA4 80050D04 AE0D0004 */  sw    $t5, 4($s0)
/* AC7EA8 80050D08 8D8E0008 */  lw    $t6, 8($t4)
/* AC7EAC 80050D0C 1000000F */  b     .L80050D4C
/* AC7EB0 80050D10 AE0E0008 */   sw    $t6, 8($s0)
/* AC7EB4 80050D14 C6040000 */  lwc1  $f4, ($s0)
.L80050D18:
/* AC7EB8 80050D18 46045181 */  sub.s $f6, $f10, $f4
/* AC7EBC 80050D1C C60A0004 */  lwc1  $f10, 4($s0)
/* AC7EC0 80050D20 E606000C */  swc1  $f6, 0xc($s0)
/* AC7EC4 80050D24 C7A8009C */  lwc1  $f8, 0x9c($sp)
/* AC7EC8 80050D28 460A4101 */  sub.s $f4, $f8, $f10
/* AC7ECC 80050D2C C6080008 */  lwc1  $f8, 8($s0)
/* AC7ED0 80050D30 E6040010 */  swc1  $f4, 0x10($s0)
/* AC7ED4 80050D34 C7A600A0 */  lwc1  $f6, 0xa0($sp)
/* AC7ED8 80050D38 46083281 */  sub.s $f10, $f6, $f8
/* AC7EDC 80050D3C E60A0014 */  swc1  $f10, 0x14($s0)
/* AC7EE0 80050D40 87AF006A */  lh    $t7, 0x6a($sp)
/* AC7EE4 80050D44 25F88001 */  addiu $t8, $t7, -0x7fff
/* AC7EE8 80050D48 A7B8006A */  sh    $t8, 0x6a($sp)
.L80050D4C:
/* AC7EEC 80050D4C 87A8006A */  lh    $t0, 0x6a($sp)
/* AC7EF0 80050D50 44802000 */  mtc1  $zero, $f4
/* AC7EF4 80050D54 A6190032 */  sh    $t9, 0x32($s0)
/* AC7EF8 80050D58 A600002C */  sh    $zero, 0x2c($s0)
/* AC7EFC 80050D5C A600002E */  sh    $zero, 0x2e($s0)
/* AC7F00 80050D60 A6080030 */  sh    $t0, 0x30($s0)
/* AC7F04 80050D64 E6040028 */  swc1  $f4, 0x28($s0)
/* AC7F08 80050D68 8629015E */  lh    $t1, 0x15e($s1)
/* AC7F0C 80050D6C 252A0001 */  addiu $t2, $t1, 1
/* AC7F10 80050D70 A62A015E */  sh    $t2, 0x15e($s1)
/* AC7F14 80050D74 26300004 */  addiu $s0, $s1, 4
.L80050D78:
/* AC7F18 80050D78 860B0032 */  lh    $t3, 0x32($s0)
/* AC7F1C 80050D7C 240C238C */  li    $t4, 9100
/* AC7F20 80050D80 27A4008C */  addiu $a0, $sp, 0x8c
/* AC7F24 80050D84 11600062 */  beqz  $t3, .L80050F10
/* AC7F28 80050D88 3C013F00 */   lui   $at, 0x3f00
/* AC7F2C 80050D8C 3C014120 */  li    $at, 0x41200000 # 0.000000
/* AC7F30 80050D90 44813000 */  mtc1  $at, $f6
/* AC7F34 80050D94 A7AC0068 */  sh    $t4, 0x68($sp)
/* AC7F38 80050D98 27A5006C */  addiu $a1, $sp, 0x6c
/* AC7F3C 80050D9C E7A60064 */  swc1  $f6, 0x64($sp)
/* AC7F40 80050DA0 860D0030 */  lh    $t5, 0x30($s0)
/* AC7F44 80050DA4 27A60064 */  addiu $a2, $sp, 0x64
/* AC7F48 80050DA8 0C010F0A */  jal   func_80043C28
/* AC7F4C 80050DAC A7AD006A */   sh    $t5, 0x6a($sp)
/* AC7F50 80050DB0 860E0032 */  lh    $t6, 0x32($s0)
/* AC7F54 80050DB4 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC7F58 80050DB8 44812000 */  mtc1  $at, $f4
/* AC7F5C 80050DBC 448E4000 */  mtc1  $t6, $f8
/* AC7F60 80050DC0 C6400000 */  lwc1  $f0, ($s2)
/* AC7F64 80050DC4 C7A6008C */  lwc1  $f6, 0x8c($sp)
/* AC7F68 80050DC8 468042A0 */  cvt.s.w $f10, $f8
/* AC7F6C 80050DCC C64C0004 */  lwc1  $f12, 4($s2)
/* AC7F70 80050DD0 C64E0008 */  lwc1  $f14, 8($s2)
/* AC7F74 80050DD4 26270074 */  addiu $a3, $s1, 0x74
/* AC7F78 80050DD8 00E02025 */  move  $a0, $a3
/* AC7F7C 80050DDC 46003201 */  sub.s $f8, $f6, $f0
/* AC7F80 80050DE0 02402825 */  move  $a1, $s2
/* AC7F84 80050DE4 27A6005C */  addiu $a2, $sp, 0x5c
/* AC7F88 80050DE8 46045080 */  add.s $f2, $f10, $f4
/* AC7F8C 80050DEC 46024283 */  div.s $f10, $f8, $f2
/* AC7F90 80050DF0 460A0100 */  add.s $f4, $f0, $f10
/* AC7F94 80050DF4 E6440000 */  swc1  $f4, ($s2)
/* AC7F98 80050DF8 C7A60090 */  lwc1  $f6, 0x90($sp)
/* AC7F9C 80050DFC 460C3201 */  sub.s $f8, $f6, $f12
/* AC7FA0 80050E00 46024283 */  div.s $f10, $f8, $f2
/* AC7FA4 80050E04 460A6100 */  add.s $f4, $f12, $f10
/* AC7FA8 80050E08 E6440004 */  swc1  $f4, 4($s2)
/* AC7FAC 80050E0C C7A60094 */  lwc1  $f6, 0x94($sp)
/* AC7FB0 80050E10 460E3201 */  sub.s $f8, $f6, $f14
/* AC7FB4 80050E14 46024283 */  div.s $f10, $f8, $f2
/* AC7FB8 80050E18 460A7100 */  add.s $f4, $f14, $f10
/* AC7FBC 80050E1C E6440008 */  swc1  $f4, 8($s2)
/* AC7FC0 80050E20 C7A6005C */  lwc1  $f6, 0x5c($sp)
/* AC7FC4 80050E24 87AF007A */  lh    $t7, 0x7a($sp)
/* AC7FC8 80050E28 87A90062 */  lh    $t1, 0x62($sp)
/* AC7FCC 80050E2C 46023203 */  div.s $f8, $f6, $f2
/* AC7FD0 80050E30 25F88001 */  addiu $t8, $t7, -0x7fff
/* AC7FD4 80050E34 00184400 */  sll   $t0, $t8, 0x10
/* AC7FD8 80050E38 0008CC03 */  sra   $t9, $t0, 0x10
/* AC7FDC 80050E3C 03295023 */  subu  $t2, $t9, $t1
/* AC7FE0 80050E40 000A5C00 */  sll   $t3, $t2, 0x10
/* AC7FE4 80050E44 000B6403 */  sra   $t4, $t3, 0x10
/* AC7FE8 80050E48 87A80060 */  lh    $t0, 0x60($sp)
/* AC7FEC 80050E4C 87B80078 */  lh    $t8, 0x78($sp)
/* AC7FF0 80050E50 0308C823 */  subu  $t9, $t8, $t0
/* AC7FF4 80050E54 00195400 */  sll   $t2, $t9, 0x10
/* AC7FF8 80050E58 000A5C03 */  sra   $t3, $t2, 0x10
/* AC7FFC 80050E5C 46083281 */  sub.s $f10, $f6, $f8
/* AC8000 80050E60 E7AA005C */  swc1  $f10, 0x5c($sp)
/* AC8004 80050E64 860D0032 */  lh    $t5, 0x32($s0)
/* AC8008 80050E68 018D001A */  div   $zero, $t4, $t5
/* AC800C 80050E6C 00007012 */  mflo  $t6
/* AC8010 80050E70 012E7821 */  addu  $t7, $t1, $t6
/* AC8014 80050E74 15A00002 */  bnez  $t5, .L80050E80
/* AC8018 80050E78 00000000 */   nop
/* AC801C 80050E7C 0007000D */  break 7
.L80050E80:
/* AC8020 80050E80 2401FFFF */  li    $at, -1
/* AC8024 80050E84 15A10004 */  bne   $t5, $at, .L80050E98
/* AC8028 80050E88 3C018000 */   lui   $at, 0x8000
/* AC802C 80050E8C 15810002 */  bne   $t4, $at, .L80050E98
/* AC8030 80050E90 00000000 */   nop
/* AC8034 80050E94 0006000D */  break 6
.L80050E98:
/* AC8038 80050E98 A7AF0062 */  sh    $t7, 0x62($sp)
/* AC803C 80050E9C 860C0032 */  lh    $t4, 0x32($s0)
/* AC8040 80050EA0 AFA70034 */  sw    $a3, 0x34($sp)
/* AC8044 80050EA4 016C001A */  div   $zero, $t3, $t4
/* AC8048 80050EA8 00006812 */  mflo  $t5
/* AC804C 80050EAC 010D4821 */  addu  $t1, $t0, $t5
/* AC8050 80050EB0 15800002 */  bnez  $t4, .L80050EBC
/* AC8054 80050EB4 00000000 */   nop
/* AC8058 80050EB8 0007000D */  break 7
.L80050EBC:
/* AC805C 80050EBC 2401FFFF */  li    $at, -1
/* AC8060 80050EC0 15810004 */  bne   $t4, $at, .L80050ED4
/* AC8064 80050EC4 3C018000 */   li    $at, 0x80000000 # 0.000000
/* AC8068 80050EC8 15610002 */  bne   $t3, $at, .L80050ED4
/* AC806C 80050ECC 00000000 */   nop
/* AC8070 80050ED0 0006000D */  break 6
.L80050ED4:
/* AC8074 80050ED4 A7A90060 */  sh    $t1, 0x60($sp)
/* AC8078 80050ED8 0C010F0A */  jal   func_80043C28
/* AC807C 80050EDC 00000000 */   nop
/* AC8080 80050EE0 8FA70034 */  lw    $a3, 0x34($sp)
/* AC8084 80050EE4 00001025 */  move  $v0, $zero
/* AC8088 80050EE8 8CEF0000 */  lw    $t7, ($a3)
/* AC808C 80050EEC AE6F0000 */  sw    $t7, ($s3)
/* AC8090 80050EF0 8CEE0004 */  lw    $t6, 4($a3)
/* AC8094 80050EF4 AE6E0004 */  sw    $t6, 4($s3)
/* AC8098 80050EF8 8CEF0008 */  lw    $t7, 8($a3)
/* AC809C 80050EFC AE6F0008 */  sw    $t7, 8($s3)
/* AC80A0 80050F00 86180032 */  lh    $t8, 0x32($s0)
/* AC80A4 80050F04 2719FFFF */  addiu $t9, $t8, -1
/* AC80A8 80050F08 1000009E */  b     .L80051184
/* AC80AC 80050F0C A6190032 */   sh    $t9, 0x32($s0)
.L80050F10:
/* AC80B0 80050F10 C6040024 */  lwc1  $f4, 0x24($s0)
/* AC80B4 80050F14 44813000 */  mtc1  $at, $f6
/* AC80B8 80050F18 27A4006C */  addiu $a0, $sp, 0x6c
/* AC80BC 80050F1C 4606203C */  c.lt.s $f4, $f6
/* AC80C0 80050F20 00000000 */  nop
/* AC80C4 80050F24 45000003 */  bc1f  .L80050F34
/* AC80C8 80050F28 00000000 */   nop
/* AC80CC 80050F2C 10000095 */  b     .L80051184
/* AC80D0 80050F30 00001025 */   move  $v0, $zero
.L80050F34:
/* AC80D4 80050F34 0C00BBD1 */  jal   func_8002EF44
/* AC80D8 80050F38 8E250090 */   lw    $a1, 0x90($s1)
/* AC80DC 80050F3C 26270074 */  addiu $a3, $s1, 0x74
/* AC80E0 80050F40 00E03025 */  move  $a2, $a3
/* AC80E4 80050F44 AFA70034 */  sw    $a3, 0x34($sp)
/* AC80E8 80050F48 02002025 */  move  $a0, $s0
/* AC80EC 80050F4C 0C032AE5 */  jal   Math3D_LineVsPos
/* AC80F0 80050F50 27A5006C */   addiu $a1, $sp, 0x6c
/* AC80F4 80050F54 8FA50034 */  lw    $a1, 0x34($sp)
/* AC80F8 80050F58 C60A000C */  lwc1  $f10, 0xc($s0)
/* AC80FC 80050F5C 3C0140A0 */  li    $at, 0x40A00000 # 0.000000
/* AC8100 80050F60 C4A80000 */  lwc1  $f8, ($a1)
/* AC8104 80050F64 2408238C */  li    $t0, 9100
/* AC8108 80050F68 27A40098 */  addiu $a0, $sp, 0x98
/* AC810C 80050F6C 460A4100 */  add.s $f4, $f8, $f10
/* AC8110 80050F70 27A60064 */  addiu $a2, $sp, 0x64
/* AC8114 80050F74 E6440000 */  swc1  $f4, ($s2)
/* AC8118 80050F78 C6080010 */  lwc1  $f8, 0x10($s0)
/* AC811C 80050F7C C4A60004 */  lwc1  $f6, 4($a1)
/* AC8120 80050F80 46083280 */  add.s $f10, $f6, $f8
/* AC8124 80050F84 E64A0004 */  swc1  $f10, 4($s2)
/* AC8128 80050F88 C6060014 */  lwc1  $f6, 0x14($s0)
/* AC812C 80050F8C C4A40008 */  lwc1  $f4, 8($a1)
/* AC8130 80050F90 44815000 */  mtc1  $at, $f10
/* AC8134 80050F94 46062200 */  add.s $f8, $f4, $f6
/* AC8138 80050F98 E6480008 */  swc1  $f8, 8($s2)
/* AC813C 80050F9C 8CAB0000 */  lw    $t3, ($a1)
/* AC8140 80050FA0 AE6B0000 */  sw    $t3, ($s3)
/* AC8144 80050FA4 8CAA0004 */  lw    $t2, 4($a1)
/* AC8148 80050FA8 AE6A0004 */  sw    $t2, 4($s3)
/* AC814C 80050FAC 8CAB0008 */  lw    $t3, 8($a1)
/* AC8150 80050FB0 AE6B0008 */  sw    $t3, 8($s3)
/* AC8154 80050FB4 860C0030 */  lh    $t4, 0x30($s0)
/* AC8158 80050FB8 A7A80068 */  sh    $t0, 0x68($sp)
/* AC815C 80050FBC E7AA0064 */  swc1  $f10, 0x64($sp)
/* AC8160 80050FC0 0C010F0A */  jal   func_80043C28
/* AC8164 80050FC4 A7AC006A */   sh    $t4, 0x6a($sp)
/* AC8168 80050FC8 860D002C */  lh    $t5, 0x2c($s0)
/* AC816C 80050FCC 25A90BB8 */  addiu $t1, $t5, 0xbb8
/* AC8170 80050FD0 A609002C */  sh    $t1, 0x2c($s0)
/* AC8174 80050FD4 0C01DE0D */  jal   Math_Coss
/* AC8178 80050FD8 8604002C */   lh    $a0, 0x2c($s0)
/* AC817C 80050FDC C66C0000 */  lwc1  $f12, ($s3)
/* AC8180 80050FE0 C7A40098 */  lwc1  $f4, 0x98($sp)
/* AC8184 80050FE4 46000406 */  mov.s $f16, $f0
/* AC8188 80050FE8 46000005 */  abs.s $f0, $f0
/* AC818C 80050FEC 460C2181 */  sub.s $f6, $f4, $f12
/* AC8190 80050FF0 8FA70034 */  lw    $a3, 0x34($sp)
/* AC8194 80050FF4 C66E0004 */  lwc1  $f14, 4($s3)
/* AC8198 80050FF8 C6620008 */  lwc1  $f2, 8($s3)
/* AC819C 80050FFC 46003202 */  mul.s $f8, $f6, $f0
/* AC81A0 80051000 46008005 */  abs.s $f0, $f16
/* AC81A4 80051004 46086280 */  add.s $f10, $f12, $f8
/* AC81A8 80051008 E66A0000 */  swc1  $f10, ($s3)
/* AC81AC 8005100C C7A4009C */  lwc1  $f4, 0x9c($sp)
/* AC81B0 80051010 460E2181 */  sub.s $f6, $f4, $f14
/* AC81B4 80051014 46003202 */  mul.s $f8, $f6, $f0
/* AC81B8 80051018 46087280 */  add.s $f10, $f14, $f8
/* AC81BC 8005101C E66A0004 */  swc1  $f10, 4($s3)
/* AC81C0 80051020 C7A400A0 */  lwc1  $f4, 0xa0($sp)
/* AC81C4 80051024 46022181 */  sub.s $f6, $f4, $f2
/* AC81C8 80051028 46003202 */  mul.s $f8, $f6, $f0
/* AC81CC 8005102C 46081280 */  add.s $f10, $f2, $f8
/* AC81D0 80051030 E66A0008 */  swc1  $f10, 8($s3)
/* AC81D4 80051034 C6120028 */  lwc1  $f18, 0x28($s0)
/* AC81D8 80051038 4610903C */  c.lt.s $f18, $f16
/* AC81DC 8005103C 00000000 */  nop
/* AC81E0 80051040 45020013 */  bc1fl .L80051090
/* AC81E4 80051044 4612803C */   c.lt.s $f16, $f18
/* AC81E8 80051048 860E002E */  lh    $t6, 0x2e($s0)
/* AC81EC 8005104C 240F0001 */  li    $t7, 1
/* AC81F0 80051050 55C0000F */  bnezl $t6, .L80051090
/* AC81F4 80051054 4612803C */   c.lt.s $f16, $f18
/* AC81F8 80051058 8E220090 */  lw    $v0, 0x90($s1)
/* AC81FC 8005105C A60F002E */  sh    $t7, 0x2e($s0)
/* AC8200 80051060 3C064080 */  lui   $a2, 0x4080
/* AC8204 80051064 9445089E */  lhu   $a1, 0x89e($v0)
/* AC8208 80051068 E7B00080 */  swc1  $f16, 0x80($sp)
/* AC820C 8005106C AFA70034 */  sw    $a3, 0x34($sp)
/* AC8210 80051070 24A508B0 */  addiu $a1, $a1, 0x8b0
/* AC8214 80051074 30A5FFFF */  andi  $a1, $a1, 0xffff
/* AC8218 80051078 0C03D004 */  jal   func_800F4010
/* AC821C 8005107C 244400E4 */   addiu $a0, $v0, 0xe4
/* AC8220 80051080 8FA70034 */  lw    $a3, 0x34($sp)
/* AC8224 80051084 10000006 */  b     .L800510A0
/* AC8228 80051088 C7B00080 */   lwc1  $f16, 0x80($sp)
/* AC822C 8005108C 4612803C */  c.lt.s $f16, $f18
.L80051090:
/* AC8230 80051090 00000000 */  nop
/* AC8234 80051094 45020003 */  bc1fl .L800510A4
/* AC8238 80051098 E6100028 */   swc1  $f16, 0x28($s0)
/* AC823C 8005109C A600002E */  sh    $zero, 0x2e($s0)
.L800510A0:
/* AC8240 800510A0 E6100028 */  swc1  $f16, 0x28($s0)
.L800510A4:
/* AC8244 800510A4 8E380090 */  lw    $t8, 0x90($s1)
/* AC8248 800510A8 8CEA0000 */  lw    $t2, ($a3)
/* AC824C 800510AC 3C018014 */  lui   $at, %hi(D_8013A1B0)
/* AC8250 800510B0 AF0A0024 */  sw    $t2, 0x24($t8)
/* AC8254 800510B4 8CF90004 */  lw    $t9, 4($a3)
/* AC8258 800510B8 AF190028 */  sw    $t9, 0x28($t8)
/* AC825C 800510BC 8CEA0008 */  lw    $t2, 8($a3)
/* AC8260 800510C0 AF0A002C */  sw    $t2, 0x2c($t8)
/* AC8264 800510C4 8E2B0090 */  lw    $t3, 0x90($s1)
/* AC8268 800510C8 C6240104 */  lwc1  $f4, 0x104($s1)
/* AC826C 800510CC E5640028 */  swc1  $f4, 0x28($t3)
/* AC8270 800510D0 8E280090 */  lw    $t0, 0x90($s1)
/* AC8274 800510D4 87AC006A */  lh    $t4, 0x6a($sp)
/* AC8278 800510D8 A50C00B6 */  sh    $t4, 0xb6($t0)
/* AC827C 800510DC C428A1B0 */  lwc1  $f8, %lo(D_8013A1B0)($at)
/* AC8280 800510E0 C6060024 */  lwc1  $f6, 0x24($s0)
/* AC8284 800510E4 3C014370 */  li    $at, 0x43700000 # 0.000000
/* AC8288 800510E8 44812000 */  mtc1  $at, $f4
/* AC828C 800510EC 46083282 */  mul.s $f10, $f6, $f8
/* AC8290 800510F0 860D0030 */  lh    $t5, 0x30($s0)
/* AC8294 800510F4 46102182 */  mul.s $f6, $f4, $f16
/* AC8298 800510F8 448D4000 */  mtc1  $t5, $f8
/* AC829C 800510FC 00000000 */  nop
/* AC82A0 80051100 46804120 */  cvt.s.w $f4, $f8
/* AC82A4 80051104 460A3402 */  mul.s $f16, $f6, $f10
/* AC82A8 80051108 46102180 */  add.s $f6, $f4, $f16
/* AC82AC 8005110C 4600328D */  trunc.w.s $f10, $f6
/* AC82B0 80051110 44045000 */  mfc1  $a0, $f10
/* AC82B4 80051114 00000000 */  nop
/* AC82B8 80051118 00042400 */  sll   $a0, $a0, 0x10
/* AC82BC 8005111C 00042403 */  sra   $a0, $a0, 0x10
/* AC82C0 80051120 0C01DE1C */  jal   Math_Sins
/* AC82C4 80051124 A7A4005A */   sh    $a0, 0x5a($sp)
/* AC82C8 80051128 3C014120 */  li    $at, 0x41200000 # 0.000000
/* AC82CC 8005112C 44814000 */  mtc1  $at, $f8
/* AC82D0 80051130 C6660000 */  lwc1  $f6, ($s3)
/* AC82D4 80051134 87A4005A */  lh    $a0, 0x5a($sp)
/* AC82D8 80051138 46080102 */  mul.s $f4, $f0, $f8
/* AC82DC 8005113C 46062280 */  add.s $f10, $f4, $f6
/* AC82E0 80051140 E64A0000 */  swc1  $f10, ($s2)
/* AC82E4 80051144 C6680004 */  lwc1  $f8, 4($s3)
/* AC82E8 80051148 0C01DE0D */  jal   Math_Coss
/* AC82EC 8005114C E6480004 */   swc1  $f8, 4($s2)
/* AC82F0 80051150 3C014120 */  li    $at, 0x41200000 # 0.000000
/* AC82F4 80051154 44812000 */  mtc1  $at, $f4
/* AC82F8 80051158 C66A0008 */  lwc1  $f10, 8($s3)
/* AC82FC 8005115C 00002025 */  move  $a0, $zero
/* AC8300 80051160 46040182 */  mul.s $f6, $f0, $f4
/* AC8304 80051164 3C063F00 */  lui   $a2, 0x3f00
/* AC8308 80051168 2407000A */  li    $a3, 10
/* AC830C 8005116C 460A3200 */  add.s $f8, $f6, $f10
/* AC8310 80051170 E6480008 */  swc1  $f8, 8($s2)
/* AC8314 80051174 0C010E47 */  jal   func_8004391C
/* AC8318 80051178 8625015A */   lh    $a1, 0x15a($s1)
/* AC831C 8005117C A622015A */  sh    $v0, 0x15a($s1)
/* AC8320 80051180 24020001 */  li    $v0, 1
.L80051184:
/* AC8324 80051184 8FBF0024 */  lw    $ra, 0x24($sp)
/* AC8328 80051188 8FB00014 */  lw    $s0, 0x14($sp)
/* AC832C 8005118C 8FB10018 */  lw    $s1, 0x18($sp)
/* AC8330 80051190 8FB2001C */  lw    $s2, 0x1c($sp)
/* AC8334 80051194 8FB30020 */  lw    $s3, 0x20($sp)
/* AC8338 80051198 03E00008 */  jr    $ra
/* AC833C 8005119C 27BD00B8 */   addiu $sp, $sp, 0xb8
