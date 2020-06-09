.late_rodata
glabel D_8013A204
    .float 0.01

glabel jtbl_8013A208
    .word L800520A8
    .word L800520EC
    .word L800521A0
    .word L80052208
    .word L80052230
    .word L80052318

glabel D_8013A220
    .float 0.001

.text
glabel Camera_Unique3
/* AC90F8 80051F58 27BDFF98 */  addiu $sp, $sp, -0x68
/* AC90FC 80051F5C AFB00018 */  sw    $s0, 0x18($sp)
/* AC9100 80051F60 00808025 */  move  $s0, $a0
/* AC9104 80051F64 AFBF001C */  sw    $ra, 0x1c($sp)
/* AC9108 80051F68 0C00B721 */  jal   Player_GetCameraYOffset
/* AC910C 80051F6C 8C840090 */   lw    $a0, 0x90($a0)
/* AC9110 80051F70 E7A0005C */  swc1  $f0, 0x5c($sp)
/* AC9114 80051F74 860E014C */  lh    $t6, 0x14c($s0)
/* AC9118 80051F78 8602015E */  lh    $v0, 0x15e($s0)
/* AC911C 80051F7C 2401000A */  li    $at, 10
/* AC9120 80051F80 31CFFFEF */  andi  $t7, $t6, 0xffef
/* AC9124 80051F84 10400008 */  beqz  $v0, .L80051FA8
/* AC9128 80051F88 A60F014C */   sh    $t7, 0x14c($s0)
/* AC912C 80051F8C 10410006 */  beq   $v0, $at, .L80051FA8
/* AC9130 80051F90 24010014 */   li    $at, 20
/* AC9134 80051F94 10410004 */  beq   $v0, $at, .L80051FA8
/* AC9138 80051F98 3C188016 */   lui   $t8, %hi(gGameInfo) # $t8, 0x8016
/* AC913C 80051F9C 8F18FA90 */  lw    $t8, %lo(gGameInfo)($t8)
/* AC9140 80051FA0 87030314 */  lh    $v1, 0x314($t8)
/* AC9144 80051FA4 1060002E */  beqz  $v1, .L80052060
.L80051FA8:
/* AC9148 80051FA8 3C018014 */   lui   $at, %hi(D_8013A204)
/* AC914C 80051FAC C42EA204 */  lwc1  $f14, %lo(D_8013A204)($at)
/* AC9150 80051FB0 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC9154 80051FB4 44814000 */  mtc1  $at, $f8
/* AC9158 80051FB8 3C014288 */  lui   $at, 0x4288
/* AC915C 80051FBC 3C0D8016 */  lui   $t5, %hi(gGameInfo)
/* AC9160 80051FC0 8DADFA90 */  lw    $t5, %lo(gGameInfo)($t5)
/* AC9164 80051FC4 44818000 */  mtc1  $at, $f16
/* AC9168 80051FC8 86190142 */  lh    $t9, 0x142($s0)
/* AC916C 80051FCC 85AE01F0 */  lh    $t6, 0x1f0($t5)
/* AC9170 80051FD0 46008483 */  div.s $f18, $f16, $f0
/* AC9174 80051FD4 3C098012 */  lui   $t1, %hi(sCameraSettings)
/* AC9178 80051FD8 448E2000 */  mtc1  $t6, $f4
/* AC917C 80051FDC 001940C0 */  sll   $t0, $t9, 3
/* AC9180 80051FE0 860A0144 */  lh    $t2, 0x144($s0)
/* AC9184 80051FE4 468021A0 */  cvt.s.w $f6, $f4
/* AC9188 80051FE8 01284821 */  addu  $t1, $t1, $t0
/* AC918C 80051FEC 8D29D068 */  lw    $t1, %lo(sCameraSettings+4)($t1)
/* AC9190 80051FF0 000A58C0 */  sll   $t3, $t2, 3
/* AC9194 80051FF4 2604000C */  addiu $a0, $s0, 0xc
/* AC9198 80051FF8 012B6021 */  addu  $t4, $t1, $t3
/* AC919C 80051FFC 8D820004 */  lw    $v0, 4($t4)
/* AC91A0 80052000 3C088016 */  lui   $t0, %hi(gGameInfo) # $t0, 0x8016
/* AC91A4 80052004 844F0000 */  lh    $t7, ($v0)
/* AC91A8 80052008 24420008 */  addiu $v0, $v0, 8
/* AC91AC 8005200C 460E3082 */  mul.s $f2, $f6, $f14
/* AC91B0 80052010 448F3000 */  mtc1  $t7, $f6
/* AC91B4 80052014 46024280 */  add.s $f10, $f8, $f2
/* AC91B8 80052018 46121102 */  mul.s $f4, $f2, $f18
/* AC91BC 8005201C 46803220 */  cvt.s.w $f8, $f6
/* AC91C0 80052020 46045301 */  sub.s $f12, $f10, $f4
/* AC91C4 80052024 460E4402 */  mul.s $f16, $f8, $f14
/* AC91C8 80052028 00000000 */  nop
/* AC91CC 8005202C 46008482 */  mul.s $f18, $f16, $f0
/* AC91D0 80052030 00000000 */  nop
/* AC91D4 80052034 460C9282 */  mul.s $f10, $f18, $f12
/* AC91D8 80052038 E48A0000 */  swc1  $f10, ($a0)
/* AC91DC 8005203C 8458FFFC */  lh    $t8, -4($v0)
/* AC91E0 80052040 44982000 */  mtc1  $t8, $f4
/* AC91E4 80052044 00000000 */  nop
/* AC91E8 80052048 468021A0 */  cvt.s.w $f6, $f4
/* AC91EC 8005204C E4860004 */  swc1  $f6, 4($a0)
/* AC91F0 80052050 84590000 */  lh    $t9, ($v0)
/* AC91F4 80052054 A4990008 */  sh    $t9, 8($a0)
/* AC91F8 80052058 8D08FA90 */  lw    $t0, %lo(gGameInfo)($t0)
/* AC91FC 8005205C 85030314 */  lh    $v1, 0x314($t0)
.L80052060:
/* AC9200 80052060 260A000C */  addiu $t2, $s0, 0xc
/* AC9204 80052064 10600003 */  beqz  $v1, .L80052074
/* AC9208 80052068 AFAA0028 */   sw    $t2, 0x28($sp)
/* AC920C 8005206C 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC9210 80052070 02002025 */   move  $a0, $s0
.L80052074:
/* AC9214 80052074 8FA90028 */  lw    $t1, 0x28($sp)
/* AC9218 80052078 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags) # $at, 0x8012
/* AC921C 8005207C 852B0008 */  lh    $t3, 8($t1)
/* AC9220 80052080 AC2BD3A0 */  sw    $t3, %lo(sCameraInterfaceFlags)($at)
/* AC9224 80052084 960C015E */  lhu   $t4, 0x15e($s0)
/* AC9228 80052088 2D810006 */  sltiu $at, $t4, 6
/* AC922C 8005208C 102000D1 */  beqz  $at, .L800523D4
/* AC9230 80052090 000C6080 */   sll   $t4, $t4, 2
/* AC9234 80052094 3C018014 */  lui   $at, %hi(jtbl_8013A208)
/* AC9238 80052098 002C0821 */  addu  $at, $at, $t4
/* AC923C 8005209C 8C2CA208 */  lw    $t4, %lo(jtbl_8013A208)($at)
/* AC9240 800520A0 01800008 */  jr    $t4
/* AC9244 800520A4 00000000 */   nop

glabel L800520A8
/* AC9248 800520A8 0C010ED8 */  jal   func_80043B60
/* AC924C 800520AC 02002025 */   move  $a0, $s0
/* AC9250 800520B0 860D014C */  lh    $t5, 0x14c($s0)
/* AC9254 800520B4 C60800FC */  lwc1  $f8, 0xfc($s0)
/* AC9258 800520B8 26020018 */  addiu $v0, $s0, 0x18
/* AC925C 800520BC 31AEFFF3 */  andi  $t6, $t5, 0xfff3
/* AC9260 800520C0 A60E014C */  sh    $t6, 0x14c($s0)
/* AC9264 800520C4 E4480000 */  swc1  $f8, ($v0)
/* AC9268 800520C8 AFA2002C */  sw    $v0, 0x2c($sp)
/* AC926C 800520CC 26040050 */  addiu $a0, $s0, 0x50
/* AC9270 800520D0 0C01EFE4 */  jal   OLib_Vec3fDist
/* AC9274 800520D4 2605005C */   addiu $a1, $s0, 0x5c
/* AC9278 800520D8 8FA2002C */  lw    $v0, 0x2c($sp)
/* AC927C 800520DC E4400004 */  swc1  $f0, 4($v0)
/* AC9280 800520E0 860F015E */  lh    $t7, 0x15e($s0)
/* AC9284 800520E4 25F80001 */  addiu $t8, $t7, 1
/* AC9288 800520E8 A618015E */  sh    $t8, 0x15e($s0)

glabel L800520EC
/* AC928C 800520EC 86020006 */  lh    $v0, 6($s0)
/* AC9290 800520F0 02002025 */  move  $a0, $s0
/* AC9294 800520F4 26080050 */  addiu $t0, $s0, 0x50
/* AC9298 800520F8 0002182A */  slt   $v1, $zero, $v0
/* AC929C 800520FC 2459FFFF */  addiu $t9, $v0, -1
/* AC92A0 80052100 146000D2 */  bnez  $v1, .L8005244C
/* AC92A4 80052104 A6190006 */   sh    $t9, 6($s0)
/* AC92A8 80052108 260A005C */  addiu $t2, $s0, 0x5c
/* AC92AC 8005210C AFAA0024 */  sw    $t2, 0x24($sp)
/* AC92B0 80052110 0C0111DB */  jal   func_8004476C
/* AC92B4 80052114 AFA8002C */   sw    $t0, 0x2c($sp)
/* AC92B8 80052118 26040074 */  addiu $a0, $s0, 0x74
/* AC92BC 8005211C AFA20054 */  sw    $v0, 0x54($sp)
/* AC92C0 80052120 AFA40020 */  sw    $a0, 0x20($sp)
/* AC92C4 80052124 0C010EF1 */  jal   Camera_Vec3sToVec3f
/* AC92C8 80052128 00402825 */   move  $a1, $v0
/* AC92CC 8005212C 8FA90020 */  lw    $t1, 0x20($sp)
/* AC92D0 80052130 8FA50024 */  lw    $a1, 0x24($sp)
/* AC92D4 80052134 27AD004C */  addiu $t5, $sp, 0x4c
/* AC92D8 80052138 8D2C0000 */  lw    $t4, ($t1)
/* AC92DC 8005213C 3C0142C8 */  li    $at, 0x42C80000 # 0.000000
/* AC92E0 80052140 44818000 */  mtc1  $at, $f16
/* AC92E4 80052144 ACAC0000 */  sw    $t4, ($a1)
/* AC92E8 80052148 8D2B0004 */  lw    $t3, 4($t1)
/* AC92EC 8005214C 27A60060 */  addiu $a2, $sp, 0x60
/* AC92F0 80052150 ACAB0004 */  sw    $t3, 4($a1)
/* AC92F4 80052154 8D2C0008 */  lw    $t4, 8($t1)
/* AC92F8 80052158 ACAC0008 */  sw    $t4, 8($a1)
/* AC92FC 8005215C 8FAE0054 */  lw    $t6, 0x54($sp)
/* AC9300 80052160 89D80006 */  lwl   $t8, 6($t6)
/* AC9304 80052164 99D80009 */  lwr   $t8, 9($t6)
/* AC9308 80052168 ADB80000 */  sw    $t8, ($t5)
/* AC930C 8005216C 95D8000A */  lhu   $t8, 0xa($t6)
/* AC9310 80052170 A5B80004 */  sh    $t8, 4($t5)
/* AC9314 80052174 87A8004C */  lh    $t0, 0x4c($sp)
/* AC9318 80052178 87B9004E */  lh    $t9, 0x4e($sp)
/* AC931C 8005217C 8FA4002C */  lw    $a0, 0x2c($sp)
/* AC9320 80052180 00085023 */  negu  $t2, $t0
/* AC9324 80052184 A7AA0064 */  sh    $t2, 0x64($sp)
/* AC9328 80052188 E7B00060 */  swc1  $f16, 0x60($sp)
/* AC932C 8005218C 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC9330 80052190 A7B90066 */   sh    $t9, 0x66($sp)
/* AC9334 80052194 8609015E */  lh    $t1, 0x15e($s0)
/* AC9338 80052198 252B0001 */  addiu $t3, $t1, 1
/* AC933C 8005219C A60B015E */  sh    $t3, 0x15e($s0)

glabel L800521A0
/* AC9340 800521A0 8FAC0028 */  lw    $t4, 0x28($sp)
/* AC9344 800521A4 858D0008 */  lh    $t5, 8($t4)
/* AC9348 800521A8 31AE0004 */  andi  $t6, $t5, 4
/* AC934C 800521AC 51C0000F */  beql  $t6, $zero, .L800521EC
/* AC9350 800521B0 86020008 */   lh    $v0, 8($s0)
/* AC9354 800521B4 8E180094 */  lw    $t8, 0x94($s0)
/* AC9358 800521B8 8E0F0098 */  lw    $t7, 0x98($s0)
/* AC935C 800521BC AE180050 */  sw    $t8, 0x50($s0)
/* AC9360 800521C0 8E18009C */  lw    $t8, 0x9c($s0)
/* AC9364 800521C4 AE0F0054 */  sw    $t7, 0x54($s0)
/* AC9368 800521C8 C6060054 */  lwc1  $f6, 0x54($s0)
/* AC936C 800521CC AE180058 */  sw    $t8, 0x58($s0)
/* AC9370 800521D0 8FB90028 */  lw    $t9, 0x28($sp)
/* AC9374 800521D4 C7B2005C */  lwc1  $f18, 0x5c($sp)
/* AC9378 800521D8 C72A0000 */  lwc1  $f10, ($t9)
/* AC937C 800521DC 460A9100 */  add.s $f4, $f18, $f10
/* AC9380 800521E0 46043200 */  add.s $f8, $f6, $f4
/* AC9384 800521E4 E6080054 */  swc1  $f8, 0x54($s0)
/* AC9388 800521E8 86020008 */  lh    $v0, 8($s0)
.L800521EC:
/* AC938C 800521EC 0002182A */  slt   $v1, $zero, $v0
/* AC9390 800521F0 2448FFFF */  addiu $t0, $v0, -1
/* AC9394 800521F4 14600095 */  bnez  $v1, .L8005244C
/* AC9398 800521F8 A6080008 */   sh    $t0, 8($s0)
/* AC939C 800521FC 860A015E */  lh    $t2, 0x15e($s0)
/* AC93A0 80052200 25490001 */  addiu $t1, $t2, 1
/* AC93A4 80052204 A609015E */  sh    $t1, 0x15e($s0)

glabel L80052208
/* AC93A8 80052208 860B014C */  lh    $t3, 0x14c($s0)
/* AC93AC 8005220C 356C0410 */  ori   $t4, $t3, 0x410
/* AC93B0 80052210 A60C014C */  sh    $t4, 0x14c($s0)
/* AC93B4 80052214 860D014C */  lh    $t5, 0x14c($s0)
/* AC93B8 80052218 31AE0008 */  andi  $t6, $t5, 8
/* AC93BC 8005221C 51C0008C */  beql  $t6, $zero, .L80052450
/* AC93C0 80052220 8FBF001C */   lw    $ra, 0x1c($sp)
/* AC93C4 80052224 860F015E */  lh    $t7, 0x15e($s0)
/* AC93C8 80052228 25F80001 */  addiu $t8, $t7, 1
/* AC93CC 8005222C A618015E */  sh    $t8, 0x15e($s0)

glabel L80052230
/* AC93D0 80052230 8FB90028 */  lw    $t9, 0x28($sp)
/* AC93D4 80052234 240E0005 */  li    $t6, 5
/* AC93D8 80052238 3C018014 */  lui   $at, %hi(D_8013A220)
/* AC93DC 8005223C 87280008 */  lh    $t0, 8($t9)
/* AC93E0 80052240 310A0002 */  andi  $t2, $t0, 2
/* AC93E4 80052244 5140000E */  beql  $t2, $zero, .L80052280
/* AC93E8 80052248 A60E000A */   sh    $t6, 0xa($s0)
/* AC93EC 8005224C 8609014C */  lh    $t1, 0x14c($s0)
/* AC93F0 80052250 02002025 */  move  $a0, $s0
/* AC93F4 80052254 24050018 */  li    $a1, 24
/* AC93F8 80052258 352B0004 */  ori   $t3, $t1, 4
/* AC93FC 8005225C A60B014C */  sh    $t3, 0x14c($s0)
/* AC9400 80052260 860C014C */  lh    $t4, 0x14c($s0)
/* AC9404 80052264 24060002 */  li    $a2, 2
/* AC9408 80052268 318DFFF7 */  andi  $t5, $t4, 0xfff7
/* AC940C 8005226C 0C016952 */  jal   Camera_ChangeSetting
/* AC9410 80052270 A60D014C */   sh    $t5, 0x14c($s0)
/* AC9414 80052274 10000076 */  b     .L80052450
/* AC9418 80052278 8FBF001C */   lw    $ra, 0x1c($sp)
/* AC941C 8005227C A60E000A */  sh    $t6, 0xa($s0)
.L80052280:
/* AC9420 80052280 C430A220 */  lwc1  $f16, %lo(D_8013A220)($at)
/* AC9424 80052284 C61200D8 */  lwc1  $f18, 0xd8($s0)
/* AC9428 80052288 3C0F8016 */  lui   $t7, %hi(D_8015BD7C) # $t7, 0x8016
/* AC942C 8005228C 4612803C */  c.lt.s $f16, $f18
/* AC9430 80052290 00000000 */  nop
/* AC9434 80052294 4503001E */  bc1tl .L80052310
/* AC9438 80052298 860E015E */   lh    $t6, 0x15e($s0)
/* AC943C 8005229C 8DEFBD7C */  lw    $t7, %lo(D_8015BD7C)($t7)
/* AC9440 800522A0 3C01FFFF */  lui   $at, (0xFFFF7FFF >> 16) # lui $at, 0xffff
/* AC9444 800522A4 34217FFF */  ori   $at, (0xFFFF7FFF & 0xFFFF) # ori $at, $at, 0x7fff
/* AC9448 800522A8 95E20020 */  lhu   $v0, 0x20($t7)
/* AC944C 800522AC 0041C027 */  nor   $t8, $v0, $at
/* AC9450 800522B0 13000016 */  beqz  $t8, .L8005230C
/* AC9454 800522B4 2401BFFF */   li    $at, -16385
/* AC9458 800522B8 0041C827 */  nor   $t9, $v0, $at
/* AC945C 800522BC 13200013 */  beqz  $t9, .L8005230C
/* AC9460 800522C0 2401FFFD */   li    $at, -3
/* AC9464 800522C4 00414027 */  nor   $t0, $v0, $at
/* AC9468 800522C8 11000010 */  beqz  $t0, .L8005230C
/* AC946C 800522CC 2401FFFB */   li    $at, -5
/* AC9470 800522D0 00415027 */  nor   $t2, $v0, $at
/* AC9474 800522D4 1140000D */  beqz  $t2, .L8005230C
/* AC9478 800522D8 2401FFF7 */   li    $at, -9
/* AC947C 800522DC 00414827 */  nor   $t1, $v0, $at
/* AC9480 800522E0 1120000A */  beqz  $t1, .L8005230C
/* AC9484 800522E4 2401FFFE */   li    $at, -2
/* AC9488 800522E8 00415827 */  nor   $t3, $v0, $at
/* AC948C 800522EC 11600007 */  beqz  $t3, .L8005230C
/* AC9490 800522F0 2401FFEF */   li    $at, -17
/* AC9494 800522F4 00416027 */  nor   $t4, $v0, $at
/* AC9498 800522F8 11800004 */  beqz  $t4, .L8005230C
/* AC949C 800522FC 2401DFFF */   li    $at, -8193
/* AC94A0 80052300 00416827 */  nor   $t5, $v0, $at
/* AC94A4 80052304 55A00052 */  bnezl $t5, .L80052450
/* AC94A8 80052308 8FBF001C */   lw    $ra, 0x1c($sp)
.L8005230C:
/* AC94AC 8005230C 860E015E */  lh    $t6, 0x15e($s0)
.L80052310:
/* AC94B0 80052310 25CF0001 */  addiu $t7, $t6, 1
/* AC94B4 80052314 A60F015E */  sh    $t7, 0x15e($s0)

glabel L80052318
/* AC94B8 80052318 C60C0018 */  lwc1  $f12, 0x18($s0)
/* AC94BC 8005231C C60E00FC */  lwc1  $f14, 0xfc($s0)
/* AC94C0 80052320 3C063ECC */  lui   $a2, (0x3ECCCCCD >> 16) # lui $a2, 0x3ecc
/* AC94C4 80052324 3C073DCC */  lui   $a3, (0x3DCCCCCD >> 16) # lui $a3, 0x3dcc
/* AC94C8 80052328 26180050 */  addiu $t8, $s0, 0x50
/* AC94CC 8005232C 2619005C */  addiu $t9, $s0, 0x5c
/* AC94D0 80052330 26080074 */  addiu $t0, $s0, 0x74
/* AC94D4 80052334 AFA80020 */  sw    $t0, 0x20($sp)
/* AC94D8 80052338 AFB90024 */  sw    $t9, 0x24($sp)
/* AC94DC 8005233C AFB8002C */  sw    $t8, 0x2c($sp)
/* AC94E0 80052340 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC94E4 80052344 0C010E27 */  jal   Camera_LERPCeilF
/* AC94E8 80052348 34C6CCCD */   ori   $a2, (0x3ECCCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC94EC 8005234C E60000FC */  swc1  $f0, 0xfc($s0)
/* AC94F0 80052350 8FA60024 */  lw    $a2, 0x24($sp)
/* AC94F4 80052354 8FA5002C */  lw    $a1, 0x2c($sp)
/* AC94F8 80052358 0C01F124 */  jal   OLib_Vec3fDiffToVecSphRot90
/* AC94FC 8005235C 27A40060 */   addiu $a0, $sp, 0x60
/* AC9500 80052360 3C0142C8 */  li    $at, 0x42C80000 # 0.000000
/* AC9504 80052364 44816000 */  mtc1  $at, $f12
/* AC9508 80052368 3C063ECC */  lui   $a2, (0x3ECCCCCD >> 16) # lui $a2, 0x3ecc
/* AC950C 8005236C 3C073DCC */  li    $a3, 0x3DCC0000 # 0.000000
/* AC9510 80052370 34E7CCCD */  ori   $a3, (0x3DCCCCCD & 0xFFFF) # ori $a3, $a3, 0xcccd
/* AC9514 80052374 34C6CCCD */  ori   $a2, (0x3ECCCCCD & 0xFFFF) # ori $a2, $a2, 0xcccd
/* AC9518 80052378 0C010E27 */  jal   Camera_LERPCeilF
/* AC951C 8005237C C7AE0060 */   lwc1  $f14, 0x60($sp)
/* AC9520 80052380 E7A00060 */  swc1  $f0, 0x60($sp)
/* AC9524 80052384 8FA40020 */  lw    $a0, 0x20($sp)
/* AC9528 80052388 8FA5002C */  lw    $a1, 0x2c($sp)
/* AC952C 8005238C 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* AC9530 80052390 27A60060 */   addiu $a2, $sp, 0x60
/* AC9534 80052394 8FA90020 */  lw    $t1, 0x20($sp)
/* AC9538 80052398 8FAA0024 */  lw    $t2, 0x24($sp)
/* AC953C 8005239C 8D2C0000 */  lw    $t4, ($t1)
/* AC9540 800523A0 AD4C0000 */  sw    $t4, ($t2)
/* AC9544 800523A4 8D2B0004 */  lw    $t3, 4($t1)
/* AC9548 800523A8 AD4B0004 */  sw    $t3, 4($t2)
/* AC954C 800523AC 8D2C0008 */  lw    $t4, 8($t1)
/* AC9550 800523B0 AD4C0008 */  sw    $t4, 8($t2)
/* AC9554 800523B4 8604000A */  lh    $a0, 0xa($s0)
/* AC9558 800523B8 0004182A */  slt   $v1, $zero, $a0
/* AC955C 800523BC 248DFFFF */  addiu $t5, $a0, -1
/* AC9560 800523C0 14600022 */  bnez  $v1, .L8005244C
/* AC9564 800523C4 A60D000A */   sh    $t5, 0xa($s0)
/* AC9568 800523C8 860E015E */  lh    $t6, 0x15e($s0)
/* AC956C 800523CC 25CF0001 */  addiu $t7, $t6, 1
/* AC9570 800523D0 A60F015E */  sh    $t7, 0x15e($s0)
.L800523D4:
/* AC9574 800523D4 8618014C */  lh    $t8, 0x14c($s0)
/* AC9578 800523D8 86050154 */  lh    $a1, 0x154($s0)
/* AC957C 800523DC 26030094 */  addiu $v1, $s0, 0x94
/* AC9580 800523E0 37190004 */  ori   $t9, $t8, 4
/* AC9584 800523E4 A619014C */  sh    $t9, 0x14c($s0)
/* AC9588 800523E8 8608014C */  lh    $t0, 0x14c($s0)
/* AC958C 800523EC 02002025 */  move  $a0, $s0
/* AC9590 800523F0 24060002 */  li    $a2, 2
/* AC9594 800523F4 310AFFF7 */  andi  $t2, $t0, 0xfff7
/* AC9598 800523F8 A60A014C */  sh    $t2, 0x14c($s0)
/* AC959C 800523FC 8FA90028 */  lw    $t1, 0x28($sp)
/* AC95A0 80052400 C52A0004 */  lwc1  $f10, 4($t1)
/* AC95A4 80052404 E60A00FC */  swc1  $f10, 0xfc($s0)
/* AC95A8 80052408 0C016952 */  jal   Camera_ChangeSetting
/* AC95AC 8005240C AFA3002C */   sw    $v1, 0x2c($sp)
/* AC95B0 80052410 44803000 */  mtc1  $zero, $f6
/* AC95B4 80052414 8FA3002C */  lw    $v1, 0x2c($sp)
/* AC95B8 80052418 C6040050 */  lwc1  $f4, 0x50($s0)
/* AC95BC 8005241C E6060100 */  swc1  $f6, 0x100($s0)
/* AC95C0 80052420 C4680000 */  lwc1  $f8, ($v1)
/* AC95C4 80052424 C6120054 */  lwc1  $f18, 0x54($s0)
/* AC95C8 80052428 46082401 */  sub.s $f16, $f4, $f8
/* AC95CC 8005242C C6040058 */  lwc1  $f4, 0x58($s0)
/* AC95D0 80052430 E61000E4 */  swc1  $f16, 0xe4($s0)
/* AC95D4 80052434 C46A0004 */  lwc1  $f10, 4($v1)
/* AC95D8 80052438 460A9181 */  sub.s $f6, $f18, $f10
/* AC95DC 8005243C E60600E8 */  swc1  $f6, 0xe8($s0)
/* AC95E0 80052440 C4680008 */  lwc1  $f8, 8($v1)
/* AC95E4 80052444 46082401 */  sub.s $f16, $f4, $f8
/* AC95E8 80052448 E61000EC */  swc1  $f16, 0xec($s0)
.L8005244C:
/* AC95EC 8005244C 8FBF001C */  lw    $ra, 0x1c($sp)
.L80052450:
/* AC95F0 80052450 8FB00018 */  lw    $s0, 0x18($sp)
/* AC95F4 80052454 27BD0068 */  addiu $sp, $sp, 0x68
/* AC95F8 80052458 03E00008 */  jr    $ra
/* AC95FC 8005245C 24020001 */   li    $v0, 1
