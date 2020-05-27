.late_rodata
glabel D_8013A36C
    .float 0.1

.text
glabel Camera_Demo6
/* ACCE18 80055C78 27BDFF88 */  addiu $sp, $sp, -0x78
/* ACCE1C 80055C7C AFB00020 */  sw    $s0, 0x20($sp)
/* ACCE20 80055C80 00808025 */  move  $s0, $a0
/* ACCE24 80055C84 AFBF0024 */  sw    $ra, 0x24($sp)
/* ACCE28 80055C88 8C84008C */  lw    $a0, 0x8c($a0)
/* ACCE2C 80055C8C 0C030129 */  jal   Gameplay_GetCamera
/* ACCE30 80055C90 00002825 */   move  $a1, $zero
/* ACCE34 80055C94 AFA20074 */  sw    $v0, 0x74($sp)
/* ACCE38 80055C98 8E0E00A8 */  lw    $t6, 0xa8($s0)
/* ACCE3C 80055C9C 240F0037 */  li    $t7, 55
/* ACCE40 80055CA0 24180046 */  li    $t8, 70
/* ACCE44 80055CA4 2419005A */  li    $t9, 90
/* ACCE48 80055CA8 A7AF0042 */  sh    $t7, 0x42($sp)
/* ACCE4C 80055CAC A7B80044 */  sh    $t8, 0x44($sp)
/* ACCE50 80055CB0 A7B90046 */  sh    $t9, 0x46($sp)
/* ACCE54 80055CB4 AFAE005C */  sw    $t6, 0x5c($sp)
/* ACCE58 80055CB8 8603015E */  lh    $v1, 0x15e($s0)
/* ACCE5C 80055CBC 2401000A */  li    $at, 10
/* ACCE60 80055CC0 5060000A */  beql  $v1, $zero, .L80055CEC
/* ACCE64 80055CC4 860A0142 */   lh    $t2, 0x142($s0)
/* ACCE68 80055CC8 10610007 */  beq   $v1, $at, .L80055CE8
/* ACCE6C 80055CCC 24010014 */   li    $at, 20
/* ACCE70 80055CD0 10610005 */  beq   $v1, $at, .L80055CE8
/* ACCE74 80055CD4 3C098016 */   lui   $t1, %hi(gGameInfo) # $t1, 0x8016
/* ACCE78 80055CD8 8D29FA90 */  lw    $t1, %lo(gGameInfo)($t1)
/* ACCE7C 80055CDC 85220314 */  lh    $v0, 0x314($t1)
/* ACCE80 80055CE0 1040000F */  beqz  $v0, .L80055D20
/* ACCE84 80055CE4 00000000 */   nop
.L80055CE8:
/* ACCE88 80055CE8 860A0142 */  lh    $t2, 0x142($s0)
.L80055CEC:
/* ACCE8C 80055CEC 3C0C8012 */  lui   $t4, %hi(sCameraSettings)
/* ACCE90 80055CF0 860D0144 */  lh    $t5, 0x144($s0)
/* ACCE94 80055CF4 000A58C0 */  sll   $t3, $t2, 3
/* ACCE98 80055CF8 018B6021 */  addu  $t4, $t4, $t3
/* ACCE9C 80055CFC 8D8CD068 */  lw    $t4, %lo(sCameraSettings+4)($t4)
/* ACCEA0 80055D00 000D70C0 */  sll   $t6, $t5, 3
/* ACCEA4 80055D04 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* ACCEA8 80055D08 018E7821 */  addu  $t7, $t4, $t6
/* ACCEAC 80055D0C 8DE30004 */  lw    $v1, 4($t7)
/* ACCEB0 80055D10 84780000 */  lh    $t8, ($v1)
/* ACCEB4 80055D14 A6180000 */  sh    $t8, ($s0)
/* ACCEB8 80055D18 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* ACCEBC 80055D1C 87220314 */  lh    $v0, 0x314($t9)
.L80055D20:
/* ACCEC0 80055D20 50400004 */  beql  $v0, $zero, .L80055D34
/* ACCEC4 80055D24 8603015E */   lh    $v1, 0x15e($s0)
/* ACCEC8 80055D28 0C011495 */  jal   func_80045254
/* ACCECC 80055D2C 02002025 */   move  $a0, $s0
/* ACCED0 80055D30 8603015E */  lh    $v1, 0x15e($s0)
.L80055D34:
/* ACCED4 80055D34 3C014270 */  li    $at, 0x42700000 # 0.000000
/* ACCED8 80055D38 1060000A */  beqz  $v1, .L80055D64
/* ACCEDC 80055D3C 00601025 */   move  $v0, $v1
/* ACCEE0 80055D40 24010001 */  li    $at, 1
/* ACCEE4 80055D44 10610031 */  beq   $v1, $at, .L80055E0C
/* ACCEE8 80055D48 24010002 */   li    $at, 2
/* ACCEEC 80055D4C 1041004C */  beq   $v0, $at, .L80055E80
/* ACCEF0 80055D50 24010003 */   li    $at, 3
/* ACCEF4 80055D54 10410061 */  beq   $v0, $at, .L80055EDC
/* ACCEF8 80055D58 26080004 */   addiu $t0, $s0, 4
/* ACCEFC 80055D5C 10000076 */  b     .L80055F38
/* ACCF00 80055D60 85020000 */   lh    $v0, ($t0)
.L80055D64:
/* ACCF04 80055D64 44812000 */  mtc1  $at, $f4
/* ACCF08 80055D68 A6000004 */  sh    $zero, 4($s0)
/* ACCF0C 80055D6C 27A40048 */  addiu $a0, $sp, 0x48
/* ACCF10 80055D70 E60400FC */  swc1  $f4, 0xfc($s0)
/* ACCF14 80055D74 0C00BBC5 */  jal   func_8002EF14
/* ACCF18 80055D78 8FA5005C */   lw    $a1, 0x5c($sp)
/* ACCF1C 80055D7C C7A60048 */  lwc1  $f6, 0x48($sp)
/* ACCF20 80055D80 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* ACCF24 80055D84 44815000 */  mtc1  $at, $f10
/* ACCF28 80055D88 E6060050 */  swc1  $f6, 0x50($s0)
/* ACCF2C 80055D8C C7A8004C */  lwc1  $f8, 0x4c($sp)
/* ACCF30 80055D90 3C014348 */  li    $at, 0x43480000 # 0.000000
/* ACCF34 80055D94 44812000 */  mtc1  $at, $f4
/* ACCF38 80055D98 460A4400 */  add.s $f16, $f8, $f10
/* ACCF3C 80055D9C 27A40048 */  addiu $a0, $sp, 0x48
/* ACCF40 80055DA0 E6100054 */  swc1  $f16, 0x54($s0)
/* ACCF44 80055DA4 C7B20050 */  lwc1  $f18, 0x50($sp)
/* ACCF48 80055DA8 E6120058 */  swc1  $f18, 0x58($s0)
/* ACCF4C 80055DAC 8FA50074 */  lw    $a1, 0x74($sp)
/* ACCF50 80055DB0 E7A40060 */  swc1  $f4, 0x60($sp)
/* ACCF54 80055DB4 0C01129D */  jal   func_80044A74
/* ACCF58 80055DB8 24A50094 */   addiu $a1, $a1, 0x94
/* ACCF5C 80055DBC 244907D0 */  addiu $t1, $v0, 0x7d0
/* ACCF60 80055DC0 240AFC18 */  li    $t2, -1000
/* ACCF64 80055DC4 26040074 */  addiu $a0, $s0, 0x74
/* ACCF68 80055DC8 A7A90066 */  sh    $t1, 0x66($sp)
/* ACCF6C 80055DCC A7AA0064 */  sh    $t2, 0x64($sp)
/* ACCF70 80055DD0 AFA40034 */  sw    $a0, 0x34($sp)
/* ACCF74 80055DD4 26050050 */  addiu $a1, $s0, 0x50
/* ACCF78 80055DD8 0C010F0A */  jal   func_80043C28
/* ACCF7C 80055DDC 27A60060 */   addiu $a2, $sp, 0x60
/* ACCF80 80055DE0 8FA40034 */  lw    $a0, 0x34($sp)
/* ACCF84 80055DE4 860C015E */  lh    $t4, 0x15e($s0)
/* ACCF88 80055DE8 8C8D0000 */  lw    $t5, ($a0)
/* ACCF8C 80055DEC 258E0001 */  addiu $t6, $t4, 1
/* ACCF90 80055DF0 AE0D005C */  sw    $t5, 0x5c($s0)
/* ACCF94 80055DF4 8C8B0004 */  lw    $t3, 4($a0)
/* ACCF98 80055DF8 AE0B0060 */  sw    $t3, 0x60($s0)
/* ACCF9C 80055DFC 8C8D0008 */  lw    $t5, 8($a0)
/* ACCFA0 80055E00 A60E015E */  sh    $t6, 0x15e($s0)
/* ACCFA4 80055E04 8603015E */  lh    $v1, 0x15e($s0)
/* ACCFA8 80055E08 AE0D0064 */  sw    $t5, 0x64($s0)
.L80055E0C:
/* ACCFAC 80055E0C 00037840 */  sll   $t7, $v1, 1
/* ACCFB0 80055E10 03AFC021 */  addu  $t8, $sp, $t7
/* ACCFB4 80055E14 26080004 */  addiu $t0, $s0, 4
/* ACCFB8 80055E18 85020000 */  lh    $v0, ($t0)
/* ACCFBC 80055E1C 87180040 */  lh    $t8, 0x40($t8)
/* ACCFC0 80055E20 24060008 */  li    $a2, 8
/* ACCFC4 80055E24 0302082A */  slt   $at, $t8, $v0
/* ACCFC8 80055E28 50200044 */  beql  $at, $zero, .L80055F3C
/* ACCFCC 80055E2C 24580001 */   addiu $t8, $v0, 1
/* ACCFD0 80055E30 8E04008C */  lw    $a0, 0x8c($s0)
/* ACCFD4 80055E34 8E050090 */  lw    $a1, 0x90($s0)
/* ACCFD8 80055E38 0C00B7D5 */  jal   func_8002DF54
/* ACCFDC 80055E3C AFA80034 */   sw    $t0, 0x34($sp)
/* ACCFE0 80055E40 27A40048 */  addiu $a0, $sp, 0x48
/* ACCFE4 80055E44 0C00BBC5 */  jal   func_8002EF14
/* ACCFE8 80055E48 8FA5005C */   lw    $a1, 0x5c($sp)
/* ACCFEC 80055E4C 8FA80034 */  lw    $t0, 0x34($sp)
/* ACCFF0 80055E50 C7A60048 */  lwc1  $f6, 0x48($sp)
/* ACCFF4 80055E54 3C0141A0 */  li    $at, 0x41A00000 # 0.000000
/* ACCFF8 80055E58 44815000 */  mtc1  $at, $f10
/* ACCFFC 80055E5C E5060004 */  swc1  $f6, 4($t0)
/* ACD000 80055E60 C7A8004C */  lwc1  $f8, 0x4c($sp)
/* ACD004 80055E64 460A4401 */  sub.s $f16, $f8, $f10
/* ACD008 80055E68 E5100008 */  swc1  $f16, 8($t0)
/* ACD00C 80055E6C C7B20050 */  lwc1  $f18, 0x50($sp)
/* ACD010 80055E70 E512000C */  swc1  $f18, 0xc($t0)
/* ACD014 80055E74 8619015E */  lh    $t9, 0x15e($s0)
/* ACD018 80055E78 27290001 */  addiu $t1, $t9, 1
/* ACD01C 80055E7C A609015E */  sh    $t1, 0x15e($s0)
.L80055E80:
/* ACD020 80055E80 3C018014 */  lui   $at, %hi(D_8013A36C)
/* ACD024 80055E84 C420A36C */  lwc1  $f0, %lo(D_8013A36C)($at)
/* ACD028 80055E88 3C014100 */  li    $at, 0x41000000 # 0.000000
/* ACD02C 80055E8C 44812000 */  mtc1  $at, $f4
/* ACD030 80055E90 26080004 */  addiu $t0, $s0, 4
/* ACD034 80055E94 44060000 */  mfc1  $a2, $f0
/* ACD038 80055E98 44070000 */  mfc1  $a3, $f0
/* ACD03C 80055E9C 25040004 */  addiu $a0, $t0, 4
/* ACD040 80055EA0 AFA80034 */  sw    $t0, 0x34($sp)
/* ACD044 80055EA4 26050050 */  addiu $a1, $s0, 0x50
/* ACD048 80055EA8 0C010E8F */  jal   func_80043A3C
/* ACD04C 80055EAC E7A40010 */   swc1  $f4, 0x10($sp)
/* ACD050 80055EB0 8603015E */  lh    $v1, 0x15e($s0)
/* ACD054 80055EB4 8FA80034 */  lw    $t0, 0x34($sp)
/* ACD058 80055EB8 00035040 */  sll   $t2, $v1, 1
/* ACD05C 80055EBC 03AA5821 */  addu  $t3, $sp, $t2
/* ACD060 80055EC0 856B0040 */  lh    $t3, 0x40($t3)
/* ACD064 80055EC4 85020000 */  lh    $v0, ($t0)
/* ACD068 80055EC8 246D0001 */  addiu $t5, $v1, 1
/* ACD06C 80055ECC 0162082A */  slt   $at, $t3, $v0
/* ACD070 80055ED0 5020001A */  beql  $at, $zero, .L80055F3C
/* ACD074 80055ED4 24580001 */   addiu $t8, $v0, 1
/* ACD078 80055ED8 A60D015E */  sh    $t5, 0x15e($s0)
.L80055EDC:
/* ACD07C 80055EDC 3C014248 */  li    $at, 0x42480000 # 0.000000
/* ACD080 80055EE0 44816000 */  mtc1  $at, $f12
/* ACD084 80055EE4 C60E00FC */  lwc1  $f14, 0xfc($s0)
/* ACD088 80055EE8 3C063E4C */  lui   $a2, (0x3E4CCCCD >> 16) # lui $a2, 0x3e4c
/* ACD08C 80055EEC 3C073C23 */  lui   $a3, (0x3C23D70A >> 16) # lui $a3, 0x3c23
/* ACD090 80055EF0 26080004 */  addiu $t0, $s0, 4
/* ACD094 80055EF4 AFA80034 */  sw    $t0, 0x34($sp)
/* ACD098 80055EF8 34E7D70A */  ori   $a3, (0x3C23D70A & 0xFFFF) # ori $a3, $a3, 0xd70a
/* ACD09C 80055EFC 0C010E27 */  jal   func_8004389C
/* ACD0A0 80055F00 34C6CCCD */   ori   $a2, (0x3E4CCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* ACD0A4 80055F04 860C015E */  lh    $t4, 0x15e($s0)
/* ACD0A8 80055F08 8FA80034 */  lw    $t0, 0x34($sp)
/* ACD0AC 80055F0C E60000FC */  swc1  $f0, 0xfc($s0)
/* ACD0B0 80055F10 000C7040 */  sll   $t6, $t4, 1
/* ACD0B4 80055F14 03AE7821 */  addu  $t7, $sp, $t6
/* ACD0B8 80055F18 85EF0040 */  lh    $t7, 0x40($t7)
/* ACD0BC 80055F1C 85020000 */  lh    $v0, ($t0)
/* ACD0C0 80055F20 01E2082A */  slt   $at, $t7, $v0
/* ACD0C4 80055F24 50200005 */  beql  $at, $zero, .L80055F3C
/* ACD0C8 80055F28 24580001 */   addiu $t8, $v0, 1
/* ACD0CC 80055F2C A6000160 */  sh    $zero, 0x160($s0)
/* ACD0D0 80055F30 10000007 */  b     .L80055F50
/* ACD0D4 80055F34 24020001 */   li    $v0, 1
.L80055F38:
/* ACD0D8 80055F38 24580001 */  addiu $t8, $v0, 1
.L80055F3C:
/* ACD0DC 80055F3C A5180000 */  sh    $t8, ($t0)
/* ACD0E0 80055F40 8FA5005C */  lw    $a1, 0x5c($sp)
/* ACD0E4 80055F44 0C00BBC5 */  jal   func_8002EF14
/* ACD0E8 80055F48 27A40048 */   addiu $a0, $sp, 0x48
/* ACD0EC 80055F4C 24020001 */  li    $v0, 1
.L80055F50:
/* ACD0F0 80055F50 8FBF0024 */  lw    $ra, 0x24($sp)
/* ACD0F4 80055F54 8FB00020 */  lw    $s0, 0x20($sp)
/* ACD0F8 80055F58 27BD0078 */  addiu $sp, $sp, 0x78
/* ACD0FC 80055F5C 03E00008 */  jr    $ra
/* ACD100 80055F60 00000000 */   nop
