glabel func_800390A0
/* AB0240 800390A0 27BDFFC8 */  addiu $sp, $sp, -0x38
/* AB0244 800390A4 AFBF0024 */  sw    $ra, 0x24($sp)
/* AB0248 800390A8 AFA5003C */  sw    $a1, 0x3c($sp)
/* AB024C 800390AC AFA60040 */  sw    $a2, 0x40($sp)
/* AB0250 800390B0 AFA70044 */  sw    $a3, 0x44($sp)
/* AB0254 800390B4 848E000E */  lh    $t6, 0xe($a0)
/* AB0258 800390B8 3C018016 */  lui   $at, %hi(D_8015BD04)
/* AB025C 800390BC 44807000 */  mtc1  $zero, $f14
/* AB0260 800390C0 448E2000 */  mtc1  $t6, $f4
/* AB0264 800390C4 00000000 */  nop   
/* AB0268 800390C8 468021A0 */  cvt.s.w $f6, $f4
/* AB026C 800390CC E426BD04 */  swc1  $f6, %lo(D_8015BD04)($at)
/* AB0270 800390D0 848F0008 */  lh    $t7, 8($a0)
/* AB0274 800390D4 8498000A */  lh    $t8, 0xa($a0)
/* AB0278 800390D8 8499000C */  lh    $t9, 0xc($a0)
/* AB027C 800390DC 448F4000 */  mtc1  $t7, $f8
/* AB0280 800390E0 44985000 */  mtc1  $t8, $f10
/* AB0284 800390E4 C4C60000 */  lwc1  $f6, ($a2)
/* AB0288 800390E8 46804020 */  cvt.s.w $f0, $f8
/* AB028C 800390EC 44992000 */  mtc1  $t9, $f4
/* AB0290 800390F0 3C018014 */  lui   $at, %hi(D_80138F50)
/* AB0294 800390F4 468050A0 */  cvt.s.w $f2, $f10
/* AB0298 800390F8 46060202 */  mul.s $f8, $f0, $f6
/* AB029C 800390FC C4CA0004 */  lwc1  $f10, 4($a2)
/* AB02A0 80039100 46802320 */  cvt.s.w $f12, $f4
/* AB02A4 80039104 460A1102 */  mul.s $f4, $f2, $f10
/* AB02A8 80039108 C4CA0008 */  lwc1  $f10, 8($a2)
/* AB02AC 8003910C 46044180 */  add.s $f6, $f8, $f4
/* AB02B0 80039110 460A6202 */  mul.s $f8, $f12, $f10
/* AB02B4 80039114 C42A8F50 */  lwc1  $f10, %lo(D_80138F50)($at)
/* AB02B8 80039118 3C018016 */  lui   $at, %hi(D_8015BD04)
/* AB02BC 8003911C 46083100 */  add.s $f4, $f6, $f8
/* AB02C0 80039120 C428BD04 */  lwc1  $f8, %lo(D_8015BD04)($at)
/* AB02C4 80039124 3C018014 */  lui   $at, %hi(D_80138F54)
/* AB02C8 80039128 460A2182 */  mul.s $f6, $f4, $f10
/* AB02CC 8003912C C4E40000 */  lwc1  $f4, ($a3)
/* AB02D0 80039130 46040282 */  mul.s $f10, $f0, $f4
/* AB02D4 80039134 46083480 */  add.s $f18, $f6, $f8
/* AB02D8 80039138 C4E60004 */  lwc1  $f6, 4($a3)
/* AB02DC 8003913C 46061102 */  mul.s $f4, $f2, $f6
/* AB02E0 80039140 4612703E */  c.le.s $f14, $f18
/* AB02E4 80039144 46045180 */  add.s $f6, $f10, $f4
/* AB02E8 80039148 C4EA0008 */  lwc1  $f10, 8($a3)
/* AB02EC 8003914C 460A6102 */  mul.s $f4, $f12, $f10
/* AB02F0 80039150 46043280 */  add.s $f10, $f6, $f4
/* AB02F4 80039154 C4268F54 */  lwc1  $f6, %lo(D_80138F54)($at)
/* AB02F8 80039158 46065102 */  mul.s $f4, $f10, $f6
/* AB02FC 8003915C 45000005 */  bc1f  .L80039174
/* AB0300 80039160 46082400 */   add.s $f16, $f4, $f8
/* AB0304 80039164 4610703E */  c.le.s $f14, $f16
/* AB0308 80039168 00000000 */  nop   
/* AB030C 8003916C 4501001F */  bc1t  .L800391EC
/* AB0310 80039170 00000000 */   nop   
.L80039174:
/* AB0314 80039174 460E903C */  c.lt.s $f18, $f14
/* AB0318 80039178 8FAA004C */  lw    $t2, 0x4c($sp)
/* AB031C 8003917C 45000005 */  bc1f  .L80039194
/* AB0320 80039180 00000000 */   nop   
/* AB0324 80039184 460E803C */  c.lt.s $f16, $f14
/* AB0328 80039188 00000000 */  nop   
/* AB032C 8003918C 45010017 */  bc1t  .L800391EC
/* AB0330 80039190 00000000 */   nop   
.L80039194:
/* AB0334 80039194 5140000A */  beql  $t2, $zero, .L800391C0
/* AB0338 80039198 46109081 */   sub.s $f2, $f18, $f16
/* AB033C 8003919C 460E903C */  c.lt.s $f18, $f14
/* AB0340 800391A0 00000000 */  nop   
/* AB0344 800391A4 45020006 */  bc1fl .L800391C0
/* AB0348 800391A8 46109081 */   sub.s $f2, $f18, $f16
/* AB034C 800391AC 4610703C */  c.lt.s $f14, $f16
/* AB0350 800391B0 00000000 */  nop   
/* AB0354 800391B4 4501000D */  bc1t  .L800391EC
/* AB0358 800391B8 00000000 */   nop   
/* AB035C 800391BC 46109081 */  sub.s $f2, $f18, $f16
.L800391C0:
/* AB0360 800391C0 3C018014 */  lui   $at, %hi(D_80138F58)
/* AB0364 800391C4 C42A8F58 */  lwc1  $f10, %lo(D_80138F58)($at)
/* AB0368 800391C8 3C058016 */  lui   $a1, %hi(D_8015BCF8) # $a1, 0x8016
/* AB036C 800391CC 46001005 */  abs.s $f0, $f2
/* AB0370 800391D0 3C068016 */  lui   $a2, %hi(D_8015BCFC) # $a2, 0x8016
/* AB0374 800391D4 460A003C */  c.lt.s $f0, $f10
/* AB0378 800391D8 3C078016 */  lui   $a3, %hi(D_8015BD00) # $a3, 0x8016
/* AB037C 800391DC 24E7BD00 */  addiu $a3, %lo(D_8015BD00) # addiu $a3, $a3, -0x4300
/* AB0380 800391E0 24C6BCFC */  addiu $a2, %lo(D_8015BCFC) # addiu $a2, $a2, -0x4304
/* AB0384 800391E4 45000003 */  bc1f  .L800391F4
/* AB0388 800391E8 24A5BCF8 */   addiu $a1, %lo(D_8015BCF8) # addiu $a1, $a1, -0x4308
.L800391EC:
/* AB038C 800391EC 1000005F */  b     .L8003936C
/* AB0390 800391F0 00001025 */   move  $v0, $zero
.L800391F4:
/* AB0394 800391F4 AFA40038 */  sw    $a0, 0x38($sp)
/* AB0398 800391F8 E7A20028 */  swc1  $f2, 0x28($sp)
/* AB039C 800391FC 0C00E275 */  jal   func_800389D4
/* AB03A0 80039200 E7B20034 */   swc1  $f18, 0x34($sp)
/* AB03A4 80039204 3C068016 */  lui   $a2, %hi(D_8015BCD0) # $a2, 0x8016
/* AB03A8 80039208 8FA40038 */  lw    $a0, 0x38($sp)
/* AB03AC 8003920C 24C6BCD0 */  addiu $a2, %lo(D_8015BCD0) # addiu $a2, $a2, -0x4330
/* AB03B0 80039210 0C00E2F8 */  jal   func_80038BE0
/* AB03B4 80039214 8FA5003C */   lw    $a1, 0x3c($sp)
/* AB03B8 80039218 C7A20028 */  lwc1  $f2, 0x28($sp)
/* AB03BC 8003921C C7B20034 */  lwc1  $f18, 0x34($sp)
/* AB03C0 80039220 8FA40040 */  lw    $a0, 0x40($sp)
/* AB03C4 80039224 8FA50044 */  lw    $a1, 0x44($sp)
/* AB03C8 80039228 46029183 */  div.s $f6, $f18, $f2
/* AB03CC 8003922C 8FA70048 */  lw    $a3, 0x48($sp)
/* AB03D0 80039230 44063000 */  mfc1  $a2, $f6
/* AB03D4 80039234 0C032BE8 */  jal   Math3D_LineSplitRatio
/* AB03D8 80039238 00000000 */   nop   
/* AB03DC 8003923C 3C018016 */  lui   $at, %hi(D_8015BCF8)
/* AB03E0 80039240 C420BCF8 */  lwc1  $f0, %lo(D_8015BCF8)($at)
/* AB03E4 80039244 3C013F00 */  li    $at, 0x3F000000 # 0.000000
/* AB03E8 80039248 44812000 */  mtc1  $at, $f4
/* AB03EC 8003924C 46000005 */  abs.s $f0, $f0
/* AB03F0 80039250 3C048016 */  lui   $a0, %hi(D_8015BCD0) # $a0, 0x8016
/* AB03F4 80039254 4600203C */  c.lt.s $f4, $f0
/* AB03F8 80039258 3C058016 */  lui   $a1, %hi(D_8015BCDC) # $a1, 0x8016
/* AB03FC 8003925C 8FA30048 */  lw    $v1, 0x48($sp)
/* AB0400 80039260 24A5BCDC */  addiu $a1, %lo(D_8015BCDC) # addiu $a1, $a1, -0x4324
/* AB0404 80039264 4500000E */  bc1f  .L800392A0
/* AB0408 80039268 2484BCD0 */   addiu $a0, %lo(D_8015BCD0) # addiu $a0, $a0, -0x4330
/* AB040C 8003926C C4680004 */  lwc1  $f8, 4($v1)
/* AB0410 80039270 C7A60050 */  lwc1  $f6, 0x50($sp)
/* AB0414 80039274 3C068016 */  lui   $a2, %hi(D_8015BCE8) # $a2, 0x8016
/* AB0418 80039278 E7A80010 */  swc1  $f8, 0x10($sp)
/* AB041C 8003927C C46A0008 */  lwc1  $f10, 8($v1)
/* AB0420 80039280 3C078016 */  lui   $a3, %hi(D_8015BCF8) # $a3, 0x8016
/* AB0424 80039284 24E7BCF8 */  addiu $a3, %lo(D_8015BCF8) # addiu $a3, $a3, -0x4308
/* AB0428 80039288 24C6BCE8 */  addiu $a2, %lo(D_8015BCE8) # addiu $a2, $a2, -0x4318
/* AB042C 8003928C E7A60018 */  swc1  $f6, 0x18($sp)
/* AB0430 80039290 0C033657 */  jal   func_800CD95C
/* AB0434 80039294 E7AA0014 */   swc1  $f10, 0x14($sp)
/* AB0438 80039298 14400031 */  bnez  $v0, .L80039360
/* AB043C 8003929C 8FA30048 */   lw    $v1, 0x48($sp)
.L800392A0:
/* AB0440 800392A0 3C018016 */  lui   $at, %hi(D_8015BCFC)
/* AB0444 800392A4 C420BCFC */  lwc1  $f0, %lo(D_8015BCFC)($at)
/* AB0448 800392A8 3C013F00 */  li    $at, 0x3F000000 # 0.000000
/* AB044C 800392AC 44812000 */  mtc1  $at, $f4
/* AB0450 800392B0 46000005 */  abs.s $f0, $f0
/* AB0454 800392B4 3C048016 */  lui   $a0, %hi(D_8015BCD0) # $a0, 0x8016
/* AB0458 800392B8 4600203C */  c.lt.s $f4, $f0
/* AB045C 800392BC 3C058016 */  lui   $a1, %hi(D_8015BCDC) # $a1, 0x8016
/* AB0460 800392C0 24A5BCDC */  addiu $a1, %lo(D_8015BCDC) # addiu $a1, $a1, -0x4324
/* AB0464 800392C4 2484BCD0 */  addiu $a0, %lo(D_8015BCD0) # addiu $a0, $a0, -0x4330
/* AB0468 800392C8 4500000D */  bc1f  .L80039300
/* AB046C 800392CC 3C068016 */   lui   $a2, %hi(D_8015BCE8) # $a2, 0x8016
/* AB0470 800392D0 C4680008 */  lwc1  $f8, 8($v1)
/* AB0474 800392D4 C7A60050 */  lwc1  $f6, 0x50($sp)
/* AB0478 800392D8 3C078016 */  lui   $a3, %hi(D_8015BCF8) # $a3, 0x8016
/* AB047C 800392DC E7A80010 */  swc1  $f8, 0x10($sp)
/* AB0480 800392E0 C46A0000 */  lwc1  $f10, ($v1)
/* AB0484 800392E4 24E7BCF8 */  addiu $a3, %lo(D_8015BCF8) # addiu $a3, $a3, -0x4308
/* AB0488 800392E8 24C6BCE8 */  addiu $a2, %lo(D_8015BCE8) # addiu $a2, $a2, -0x4318
/* AB048C 800392EC E7A60018 */  swc1  $f6, 0x18($sp)
/* AB0490 800392F0 0C0334B6 */  jal   func_800CD2D8
/* AB0494 800392F4 E7AA0014 */   swc1  $f10, 0x14($sp)
/* AB0498 800392F8 14400019 */  bnez  $v0, .L80039360
/* AB049C 800392FC 8FA30048 */   lw    $v1, 0x48($sp)
.L80039300:
/* AB04A0 80039300 3C018016 */  lui   $at, %hi(D_8015BD00)
/* AB04A4 80039304 C420BD00 */  lwc1  $f0, %lo(D_8015BD00)($at)
/* AB04A8 80039308 3C013F00 */  li    $at, 0x3F000000 # 0.000000
/* AB04AC 8003930C 44812000 */  mtc1  $at, $f4
/* AB04B0 80039310 46000005 */  abs.s $f0, $f0
/* AB04B4 80039314 3C048016 */  lui   $a0, %hi(D_8015BCD0) # $a0, 0x8016
/* AB04B8 80039318 4600203C */  c.lt.s $f4, $f0
/* AB04BC 8003931C 3C058016 */  lui   $a1, %hi(D_8015BCDC) # $a1, 0x8016
/* AB04C0 80039320 24A5BCDC */  addiu $a1, %lo(D_8015BCDC) # addiu $a1, $a1, -0x4324
/* AB04C4 80039324 2484BCD0 */  addiu $a0, %lo(D_8015BCD0) # addiu $a0, $a0, -0x4330
/* AB04C8 80039328 4500000F */  bc1f  .L80039368
/* AB04CC 8003932C 3C068016 */   lui   $a2, %hi(D_8015BCE8) # $a2, 0x8016
/* AB04D0 80039330 C4680000 */  lwc1  $f8, ($v1)
/* AB04D4 80039334 C7A60050 */  lwc1  $f6, 0x50($sp)
/* AB04D8 80039338 3C078016 */  lui   $a3, %hi(D_8015BCF8) # $a3, 0x8016
/* AB04DC 8003933C E7A80010 */  swc1  $f8, 0x10($sp)
/* AB04E0 80039340 C46A0004 */  lwc1  $f10, 4($v1)
/* AB04E4 80039344 24E7BCF8 */  addiu $a3, %lo(D_8015BCF8) # addiu $a3, $a3, -0x4308
/* AB04E8 80039348 24C6BCE8 */  addiu $a2, %lo(D_8015BCE8) # addiu $a2, $a2, -0x4318
/* AB04EC 8003934C E7A60018 */  swc1  $f6, 0x18($sp)
/* AB04F0 80039350 0C033804 */  jal   func_800CE010
/* AB04F4 80039354 E7AA0014 */   swc1  $f10, 0x14($sp)
/* AB04F8 80039358 50400004 */  beql  $v0, $zero, .L8003936C
/* AB04FC 8003935C 00001025 */   move  $v0, $zero
.L80039360:
/* AB0500 80039360 10000002 */  b     .L8003936C
/* AB0504 80039364 24020001 */   li    $v0, 1
.L80039368:
/* AB0508 80039368 00001025 */  move  $v0, $zero
.L8003936C:
/* AB050C 8003936C 8FBF0024 */  lw    $ra, 0x24($sp)
/* AB0510 80039370 27BD0038 */  addiu $sp, $sp, 0x38
/* AB0514 80039374 03E00008 */  jr    $ra
/* AB0518 80039378 00000000 */   nop   

