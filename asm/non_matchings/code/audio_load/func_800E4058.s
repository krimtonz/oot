glabel Audio_SampleReloc
/* B5B1F8 800E4058 8C820000 */  lw    $v0, ($a0)
/* B5B1FC 800E405C 3C018000 */  lui   $at, (0x80000001 >> 16) # lui $at, 0x8000
/* B5B200 800E4060 34210001 */  ori   $at, (0x80000001 & 0xFFFF) # ori $at, $at, 1
/* B5B204 800E4064 0041082B */  sltu  $at, $v0, $at
/* B5B208 800E4068 10200049 */  beqz  $at, .L800E4190
/* B5B20C 800E406C 00C03825 */   move  $a3, $a2
/* B5B210 800E4070 00451821 */  addu  $v1, $v0, $a1
/* B5B214 800E4074 AC830000 */  sw    $v1, ($a0)
/* B5B218 800E4078 8C6E0000 */  lw    $t6, ($v1)
/* B5B21C 800E407C 3C0100FF */  lui   $at, (0x00FFFFFF >> 16) # lui $at, 0xff
/* B5B220 800E4080 3421FFFF */  ori   $at, (0x00FFFFFF & 0xFFFF) # ori $at, $at, 0xffff
/* B5B224 800E4084 01C17824 */  and   $t7, $t6, $at
/* B5B228 800E4088 11E00041 */  beqz  $t7, .L800E4190
/* B5B22C 800E408C 00603025 */   move  $a2, $v1
/* B5B230 800E4090 90780000 */  lbu   $t8, ($v1)
/* B5B234 800E4094 24040001 */  li    $a0, 1
/* B5B238 800E4098 33190001 */  andi  $t9, $t8, 1
/* B5B23C 800E409C 1099003C */  beq   $a0, $t9, .L800E4190
/* B5B240 800E40A0 00000000 */   nop
/* B5B244 800E40A4 8C680008 */  lw    $t0, 8($v1)
/* B5B248 800E40A8 8CC20000 */  lw    $v0, ($a2)
/* B5B24C 800E40AC 8CC9000C */  lw    $t1, 0xc($a2)
/* B5B250 800E40B0 01051821 */  addu  $v1, $t0, $a1
/* B5B254 800E40B4 ACC30008 */  sw    $v1, 8($a2)
/* B5B258 800E40B8 00021100 */  sll   $v0, $v0, 4
/* B5B25C 800E40BC 00021782 */  srl   $v0, $v0, 0x1e
/* B5B260 800E40C0 01251821 */  addu  $v1, $t1, $a1
/* B5B264 800E40C4 10400009 */  beqz  $v0, .L800E40EC
/* B5B268 800E40C8 ACC3000C */   sw    $v1, 0xc($a2)
/* B5B26C 800E40CC 10440013 */  beq   $v0, $a0, .L800E411C
/* B5B270 800E40D0 24010002 */   li    $at, 2
/* B5B274 800E40D4 1041001C */  beq   $v0, $at, .L800E4148
/* B5B278 800E40D8 24010003 */   li    $at, 3
/* B5B27C 800E40DC 5041001B */  beql  $v0, $at, .L800E414C
/* B5B280 800E40E0 90C90000 */   lbu   $t1, ($a2)
/* B5B284 800E40E4 10000019 */  b     .L800E414C
/* B5B288 800E40E8 90C90000 */   lbu   $t1, ($a2)
.L800E40EC:
/* B5B28C 800E40EC 8CCA0004 */  lw    $t2, 4($a2)
/* B5B290 800E40F0 8CEB0008 */  lw    $t3, 8($a3)
/* B5B294 800E40F4 90D80000 */  lbu   $t8, ($a2)
/* B5B298 800E40F8 014B1821 */  addu  $v1, $t2, $t3
/* B5B29C 800E40FC ACC30004 */  sw    $v1, 4($a2)
/* B5B2A0 800E4100 8CED0010 */  lw    $t5, 0x10($a3)
/* B5B2A4 800E4104 3319FFF3 */  andi  $t9, $t8, 0xfff3
/* B5B2A8 800E4108 000D7080 */  sll   $t6, $t5, 2
/* B5B2AC 800E410C 31CF000C */  andi  $t7, $t6, 0xc
/* B5B2B0 800E4110 01F94025 */  or    $t0, $t7, $t9
/* B5B2B4 800E4114 1000000C */  b     .L800E4148
/* B5B2B8 800E4118 A0C80000 */   sb    $t0, ($a2)
.L800E411C:
/* B5B2BC 800E411C 8CC90004 */  lw    $t1, 4($a2)
/* B5B2C0 800E4120 8CEA000C */  lw    $t2, 0xc($a3)
/* B5B2C4 800E4124 90D80000 */  lbu   $t8, ($a2)
/* B5B2C8 800E4128 012A1821 */  addu  $v1, $t1, $t2
/* B5B2CC 800E412C ACC30004 */  sw    $v1, 4($a2)
/* B5B2D0 800E4130 8CEC0014 */  lw    $t4, 0x14($a3)
/* B5B2D4 800E4134 330FFFF3 */  andi  $t7, $t8, 0xfff3
/* B5B2D8 800E4138 000C6880 */  sll   $t5, $t4, 2
/* B5B2DC 800E413C 31AE000C */  andi  $t6, $t5, 0xc
/* B5B2E0 800E4140 01CFC825 */  or    $t9, $t6, $t7
/* B5B2E4 800E4144 A0D90000 */  sb    $t9, ($a2)
.L800E4148:
/* B5B2E8 800E4148 90C90000 */  lbu   $t1, ($a2)
.L800E414C:
/* B5B2EC 800E414C 352A0001 */  ori   $t2, $t1, 1
/* B5B2F0 800E4150 A0CA0000 */  sb    $t2, ($a2)
/* B5B2F4 800E4154 8CC20000 */  lw    $v0, ($a2)
/* B5B2F8 800E4158 00026180 */  sll   $t4, $v0, 6
/* B5B2FC 800E415C 0581000C */  bgez  $t4, .L800E4190
/* B5B300 800E4160 00026900 */   sll   $t5, $v0, 4
/* B5B304 800E4164 000DC782 */  srl   $t8, $t5, 0x1e
/* B5B308 800E4168 13000009 */  beqz  $t8, .L800E4190
/* B5B30C 800E416C 3C028017 */   lui   $v0, %hi(gAudioContext) # $v0, 0x8017
/* B5B310 800E4170 2442F180 */  addiu $v0, %lo(gAudioContext) # addiu $v0, $v0, -0xe80
/* B5B314 800E4174 8C4E1768 */  lw    $t6, 0x1768($v0)
/* B5B318 800E4178 000E7880 */  sll   $t7, $t6, 2
/* B5B31C 800E417C 004FC821 */  addu  $t9, $v0, $t7
/* B5B320 800E4180 AF260B68 */  sw    $a2, 0xb68($t9)
/* B5B324 800E4184 8C481768 */  lw    $t0, 0x1768($v0)
/* B5B328 800E4188 25090001 */  addiu $t1, $t0, 1
/* B5B32C 800E418C AC491768 */  sw    $t1, 0x1768($v0)
.L800E4190:
/* B5B330 800E4190 03E00008 */  jr    $ra
/* B5B334 800E4194 00000000 */   nop

