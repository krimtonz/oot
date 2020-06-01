.late_rodata
glabel D_8013A194
    .float 0.01

glabel D_8013A198
    .float 0.1

.text
glabel Camera_Fixed4
/* AC7208 80050068 27BDFF58 */  addiu $sp, $sp, -0xa8
/* AC720C 8005006C AFB00020 */  sw    $s0, 0x20($sp)
/* AC7210 80050070 00808025 */  move  $s0, $a0
/* AC7214 80050074 AFBF002C */  sw    $ra, 0x2c($sp)
/* AC7218 80050078 AFB20028 */  sw    $s2, 0x28($sp)
/* AC721C 8005007C AFB10024 */  sw    $s1, 0x24($sp)
/* AC7220 80050080 0C00B721 */  jal   Player_GetCameraYOffset
/* AC7224 80050084 8C840090 */   lw    $a0, 0x90($a0)
/* AC7228 80050088 E7A00050 */  swc1  $f0, 0x50($sp)
/* AC722C 8005008C 8602015E */  lh    $v0, 0x15e($s0)
/* AC7230 80050090 10400008 */  beqz  $v0, .L800500B4
/* AC7234 80050094 2401000A */   li    $at, 10
/* AC7238 80050098 10410006 */  beq   $v0, $at, .L800500B4
/* AC723C 8005009C 24010014 */   li    $at, 20
/* AC7240 800500A0 10410004 */  beq   $v0, $at, .L800500B4
/* AC7244 800500A4 3C0E8016 */   lui   $t6, %hi(gGameInfo) # $t6, 0x8016
/* AC7248 800500A8 8DCEFA90 */  lw    $t6, %lo(gGameInfo)($t6)
/* AC724C 800500AC 85C30314 */  lh    $v1, 0x314($t6)
/* AC7250 800500B0 10600049 */  beqz  $v1, .L800501D8
.L800500B4:
/* AC7254 800500B4 3C0B8016 */   lui   $t3, %hi(gGameInfo) # $t3, 0x8016
/* AC7258 800500B8 8D6BFA90 */  lw    $t3, %lo(gGameInfo)($t3)
/* AC725C 800500BC 3C018014 */  lui   $at, %hi(D_8013A194)
/* AC7260 800500C0 C42CA194 */  lwc1  $f12, %lo(D_8013A194)($at)
/* AC7264 800500C4 856C01F0 */  lh    $t4, 0x1f0($t3)
/* AC7268 800500C8 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* AC726C 800500CC 44814000 */  mtc1  $at, $f8
/* AC7270 800500D0 448C2000 */  mtc1  $t4, $f4
/* AC7274 800500D4 3C014288 */  li    $at, 0x42880000 # 0.000000
/* AC7278 800500D8 860F0142 */  lh    $t7, 0x142($s0)
/* AC727C 800500DC 468021A0 */  cvt.s.w $f6, $f4
/* AC7280 800500E0 44812000 */  mtc1  $at, $f4
/* AC7284 800500E4 3C198012 */  lui   $t9, %hi(sCameraSettings)
/* AC7288 800500E8 000FC0C0 */  sll   $t8, $t7, 3
/* AC728C 800500EC 86080144 */  lh    $t0, 0x144($s0)
/* AC7290 800500F0 0338C821 */  addu  $t9, $t9, $t8
/* AC7294 800500F4 460C3082 */  mul.s $f2, $f6, $f12
/* AC7298 800500F8 46002183 */  div.s $f6, $f4, $f0
/* AC729C 800500FC 8F39D068 */  lw    $t9, %lo(sCameraSettings+4)($t9)
/* AC72A0 80050100 000848C0 */  sll   $t1, $t0, 3
/* AC72A4 80050104 02002025 */  move  $a0, $s0
/* AC72A8 80050108 03295021 */  addu  $t2, $t9, $t1
/* AC72AC 8005010C 8D420004 */  lw    $v0, 4($t2)
/* AC72B0 80050110 46024280 */  add.s $f10, $f8, $f2
/* AC72B4 80050114 844D0000 */  lh    $t5, ($v0)
/* AC72B8 80050118 24420010 */  addiu $v0, $v0, 0x10
/* AC72BC 8005011C 448D2000 */  mtc1  $t5, $f4
/* AC72C0 80050120 46061202 */  mul.s $f8, $f2, $f6
/* AC72C4 80050124 468021A0 */  cvt.s.w $f6, $f4
/* AC72C8 80050128 46085381 */  sub.s $f14, $f10, $f8
/* AC72CC 8005012C 460C3282 */  mul.s $f10, $f6, $f12
/* AC72D0 80050130 00000000 */  nop
/* AC72D4 80050134 46005202 */  mul.s $f8, $f10, $f0
/* AC72D8 80050138 00000000 */  nop
/* AC72DC 8005013C 460E4102 */  mul.s $f4, $f8, $f14
/* AC72E0 80050140 E6040000 */  swc1  $f4, ($s0)
/* AC72E4 80050144 844EFFF4 */  lh    $t6, -0xc($v0)
/* AC72E8 80050148 448E3000 */  mtc1  $t6, $f6
/* AC72EC 8005014C 00000000 */  nop
/* AC72F0 80050150 468032A0 */  cvt.s.w $f10, $f6
/* AC72F4 80050154 460C5202 */  mul.s $f8, $f10, $f12
/* AC72F8 80050158 E6080004 */  swc1  $f8, 4($s0)
/* AC72FC 8005015C 844FFFF8 */  lh    $t7, -8($v0)
/* AC7300 80050160 448F2000 */  mtc1  $t7, $f4
/* AC7304 80050164 00000000 */  nop
/* AC7308 80050168 468021A0 */  cvt.s.w $f6, $f4
/* AC730C 8005016C 460C3282 */  mul.s $f10, $f6, $f12
/* AC7310 80050170 E60A0008 */  swc1  $f10, 8($s0)
/* AC7314 80050174 8458FFFC */  lh    $t8, -4($v0)
/* AC7318 80050178 44984000 */  mtc1  $t8, $f8
/* AC731C 8005017C 00000000 */  nop
/* AC7320 80050180 46804120 */  cvt.s.w $f4, $f8
/* AC7324 80050184 E604000C */  swc1  $f4, 0xc($s0)
/* AC7328 80050188 84480000 */  lh    $t0, ($v0)
/* AC732C 8005018C 0C0111DB */  jal   func_8004476C
/* AC7330 80050190 A6080010 */   sh    $t0, 0x10($s0)
/* AC7334 80050194 10400007 */  beqz  $v0, .L800501B4
/* AC7338 80050198 00402825 */   move  $a1, $v0
/* AC733C 8005019C 0C010EF1 */  jal   func_80043BC4
/* AC7340 800501A0 26040014 */   addiu $a0, $s0, 0x14
/* AC7344 800501A4 3C198016 */  lui   $t9, %hi(gGameInfo) # $t9, 0x8016
/* AC7348 800501A8 8F39FA90 */  lw    $t9, %lo(gGameInfo)($t9)
/* AC734C 800501AC 1000000A */  b     .L800501D8
/* AC7350 800501B0 87230314 */   lh    $v1, 0x314($t9)
.L800501B4:
/* AC7354 800501B4 8E0A005C */  lw    $t2, 0x5c($s0)
/* AC7358 800501B8 8E090060 */  lw    $t1, 0x60($s0)
/* AC735C 800501BC 3C0B8016 */  lui   $t3, %hi(gGameInfo)
/* AC7360 800501C0 AE0A0014 */  sw    $t2, 0x14($s0)
/* AC7364 800501C4 8E0A0064 */  lw    $t2, 0x64($s0)
/* AC7368 800501C8 AE090018 */  sw    $t1, 0x18($s0)
/* AC736C 800501CC AE0A001C */  sw    $t2, 0x1c($s0)
/* AC7370 800501D0 8D6BFA90 */  lw    $t3, %lo(gGameInfo)($t3)
/* AC7374 800501D4 85630314 */  lh    $v1, 0x314($t3)
.L800501D8:
/* AC7378 800501D8 260C005C */  addiu $t4, $s0, 0x5c
/* AC737C 800501DC AFAC0044 */  sw    $t4, 0x44($sp)
/* AC7380 800501E0 10600003 */  beqz  $v1, .L800501F0
/* AC7384 800501E4 26120014 */   addiu $s2, $s0, 0x14
/* AC7388 800501E8 0C011495 */  jal   Camera_CopyPREGToModeValues
/* AC738C 800501EC 02002025 */   move  $a0, $s0
.L800501F0:
/* AC7390 800501F0 860D0010 */  lh    $t5, 0x10($s0)
/* AC7394 800501F4 3C018012 */  lui   $at, %hi(D_8011D3A0)
/* AC7398 800501F8 AC2DD3A0 */  sw    $t5, %lo(D_8011D3A0)($at)
/* AC739C 800501FC 8602015E */  lh    $v0, 0x15e($s0)
/* AC73A0 80050200 5440000C */  bnezl $v0, .L80050234
/* AC73A4 80050204 26110074 */   addiu $s1, $s0, 0x74
/* AC73A8 80050208 860F0010 */  lh    $t7, 0x10($s0)
/* AC73AC 8005020C 244E0001 */  addiu $t6, $v0, 1
/* AC73B0 80050210 A60E015E */  sh    $t6, 0x15e($s0)
/* AC73B4 80050214 31F80004 */  andi  $t8, $t7, 4
/* AC73B8 80050218 57000004 */  bnezl $t8, .L8005022C
/* AC73BC 8005021C C6060008 */   lwc1  $f6, 8($s0)
/* AC73C0 80050220 0C010ED8 */  jal   func_80043B60
/* AC73C4 80050224 02002025 */   move  $a0, $s0
/* AC73C8 80050228 C6060008 */  lwc1  $f6, 8($s0)
.L8005022C:
/* AC73CC 8005022C E646000C */  swc1  $f6, 0xc($s2)
/* AC73D0 80050230 26110074 */  addiu $s1, $s0, 0x74
.L80050234:
/* AC73D4 80050234 C6200000 */  lwc1  $f0, ($s1)
/* AC73D8 80050238 C64A0000 */  lwc1  $f10, ($s2)
/* AC73DC 8005023C C6040004 */  lwc1  $f4, 4($s0)
/* AC73E0 80050240 3C018014 */  lui   $at, %hi(D_8013A198)
/* AC73E4 80050244 46005201 */  sub.s $f8, $f10, $f0
/* AC73E8 80050248 C42EA198 */  lwc1  $f14, %lo(D_8013A198)($at)
/* AC73EC 8005024C C6220004 */  lwc1  $f2, 4($s1)
/* AC73F0 80050250 C62C0008 */  lwc1  $f12, 8($s1)
/* AC73F4 80050254 46044182 */  mul.s $f6, $f8, $f4
/* AC73F8 80050258 44808000 */  mtc1  $zero, $f16
/* AC73FC 8005025C 44067000 */  mfc1  $a2, $f14
/* AC7400 80050260 44077000 */  mfc1  $a3, $f14
/* AC7404 80050264 27A40078 */  addiu $a0, $sp, 0x78
/* AC7408 80050268 260500E4 */  addiu $a1, $s0, 0xe4
/* AC740C 8005026C 46060280 */  add.s $f10, $f0, $f6
/* AC7410 80050270 E62A0000 */  swc1  $f10, ($s1)
/* AC7414 80050274 C6480004 */  lwc1  $f8, 4($s2)
/* AC7418 80050278 C6060004 */  lwc1  $f6, 4($s0)
/* AC741C 8005027C 8E290000 */  lw    $t1, ($s1)
/* AC7420 80050280 46024101 */  sub.s $f4, $f8, $f2
/* AC7424 80050284 46062282 */  mul.s $f10, $f4, $f6
/* AC7428 80050288 460A1200 */  add.s $f8, $f2, $f10
/* AC742C 8005028C E6280004 */  swc1  $f8, 4($s1)
/* AC7430 80050290 C6440008 */  lwc1  $f4, 8($s2)
/* AC7434 80050294 C60A0004 */  lwc1  $f10, 4($s0)
/* AC7438 80050298 460C2181 */  sub.s $f6, $f4, $f12
/* AC743C 8005029C 460A3202 */  mul.s $f8, $f6, $f10
/* AC7440 800502A0 46086100 */  add.s $f4, $f12, $f8
/* AC7444 800502A4 E6240008 */  swc1  $f4, 8($s1)
/* AC7448 800502A8 8FA80044 */  lw    $t0, 0x44($sp)
/* AC744C 800502AC AD090000 */  sw    $t1, ($t0)
/* AC7450 800502B0 8E390004 */  lw    $t9, 4($s1)
/* AC7454 800502B4 AD190004 */  sw    $t9, 4($t0)
/* AC7458 800502B8 8E290008 */  lw    $t1, 8($s1)
/* AC745C 800502BC AD090008 */  sw    $t1, 8($t0)
/* AC7460 800502C0 E7B00078 */  swc1  $f16, 0x78($sp)
/* AC7464 800502C4 C6060000 */  lwc1  $f6, ($s0)
/* AC7468 800502C8 C7AA0050 */  lwc1  $f10, 0x50($sp)
/* AC746C 800502CC E7AE0010 */  swc1  $f14, 0x10($sp)
/* AC7470 800502D0 E7B00080 */  swc1  $f16, 0x80($sp)
/* AC7474 800502D4 460A3200 */  add.s $f8, $f6, $f10
/* AC7478 800502D8 0C010E8F */  jal   func_80043A3C
/* AC747C 800502DC E7A8007C */   swc1  $f8, 0x7c($sp)
/* AC7480 800502E0 26020094 */  addiu $v0, $s0, 0x94
/* AC7484 800502E4 C4440000 */  lwc1  $f4, ($v0)
/* AC7488 800502E8 C60600E4 */  lwc1  $f6, 0xe4($s0)
/* AC748C 800502EC C44A0004 */  lwc1  $f10, 4($v0)
/* AC7490 800502F0 C60800E8 */  lwc1  $f8, 0xe8($s0)
/* AC7494 800502F4 46062380 */  add.s $f14, $f4, $f6
/* AC7498 800502F8 26060050 */  addiu $a2, $s0, 0x50
/* AC749C 800502FC C4C00000 */  lwc1  $f0, ($a2)
/* AC74A0 80050300 46085400 */  add.s $f16, $f10, $f8
/* AC74A4 80050304 C60600EC */  lwc1  $f6, 0xec($s0)
/* AC74A8 80050308 C4440008 */  lwc1  $f4, 8($v0)
/* AC74AC 8005030C 46007281 */  sub.s $f10, $f14, $f0
/* AC74B0 80050310 3C013F00 */  li    $at, 0x3F000000 # 0.000000
/* AC74B4 80050314 44814000 */  mtc1  $at, $f8
/* AC74B8 80050318 46062480 */  add.s $f18, $f4, $f6
/* AC74BC 8005031C 27A40070 */  addiu $a0, $sp, 0x70
/* AC74C0 80050320 46085102 */  mul.s $f4, $f10, $f8
/* AC74C4 80050324 44814000 */  mtc1  $at, $f8
/* AC74C8 80050328 02202825 */  move  $a1, $s1
/* AC74CC 8005032C 46040180 */  add.s $f6, $f0, $f4
/* AC74D0 80050330 E7A60084 */  swc1  $f6, 0x84($sp)
/* AC74D4 80050334 C4C20004 */  lwc1  $f2, 4($a2)
/* AC74D8 80050338 46028281 */  sub.s $f10, $f16, $f2
/* AC74DC 8005033C 46085102 */  mul.s $f4, $f10, $f8
/* AC74E0 80050340 44814000 */  mtc1  $at, $f8
/* AC74E4 80050344 46041180 */  add.s $f6, $f2, $f4
/* AC74E8 80050348 E7A60088 */  swc1  $f6, 0x88($sp)
/* AC74EC 8005034C C4CC0008 */  lwc1  $f12, 8($a2)
/* AC74F0 80050350 AFA60040 */  sw    $a2, 0x40($sp)
/* AC74F4 80050354 460C9281 */  sub.s $f10, $f18, $f12
/* AC74F8 80050358 46085102 */  mul.s $f4, $f10, $f8
/* AC74FC 8005035C 46046180 */  add.s $f6, $f12, $f4
/* AC7500 80050360 0C01F124 */  jal   func_8007C490
/* AC7504 80050364 E7A6008C */   swc1  $f6, 0x8c($sp)
/* AC7508 80050368 27A40068 */  addiu $a0, $sp, 0x68
/* AC750C 8005036C 02202825 */  move  $a1, $s1
/* AC7510 80050370 0C01F124 */  jal   func_8007C490
/* AC7514 80050374 27A60084 */   addiu $a2, $sp, 0x84
/* AC7518 80050378 C7AA0068 */  lwc1  $f10, 0x68($sp)
/* AC751C 8005037C C7A80070 */  lwc1  $f8, 0x70($sp)
/* AC7520 80050380 C646000C */  lwc1  $f6, 0xc($s2)
/* AC7524 80050384 87A4006C */  lh    $a0, 0x6c($sp)
/* AC7528 80050388 46085101 */  sub.s $f4, $f10, $f8
/* AC752C 8005038C 87A50074 */  lh    $a1, 0x74($sp)
/* AC7530 80050390 2407000A */  li    $a3, 10
/* AC7534 80050394 46062282 */  mul.s $f10, $f4, $f6
/* AC7538 80050398 460A4100 */  add.s $f4, $f8, $f10
/* AC753C 8005039C E7A40070 */  swc1  $f4, 0x70($sp)
/* AC7540 800503A0 C60800E0 */  lwc1  $f8, 0xe0($s0)
/* AC7544 800503A4 C646000C */  lwc1  $f6, 0xc($s2)
/* AC7548 800503A8 46083282 */  mul.s $f10, $f6, $f8
/* AC754C 800503AC 44065000 */  mfc1  $a2, $f10
/* AC7550 800503B0 0C010E47 */  jal   func_8004391C
/* AC7554 800503B4 00000000 */   nop
/* AC7558 800503B8 A7A20074 */  sh    $v0, 0x74($sp)
/* AC755C 800503BC C60600E0 */  lwc1  $f6, 0xe0($s0)
/* AC7560 800503C0 C644000C */  lwc1  $f4, 0xc($s2)
/* AC7564 800503C4 87A4006E */  lh    $a0, 0x6e($sp)
/* AC7568 800503C8 87A50076 */  lh    $a1, 0x76($sp)
/* AC756C 800503CC 46062202 */  mul.s $f8, $f4, $f6
/* AC7570 800503D0 2407000A */  li    $a3, 10
/* AC7574 800503D4 44064000 */  mfc1  $a2, $f8
/* AC7578 800503D8 0C010E47 */  jal   func_8004391C
/* AC757C 800503DC 00000000 */   nop
/* AC7580 800503E0 A7A20076 */  sh    $v0, 0x76($sp)
/* AC7584 800503E4 8FA40040 */  lw    $a0, 0x40($sp)
/* AC7588 800503E8 02202825 */  move  $a1, $s1
/* AC758C 800503EC 0C010F0A */  jal   func_80043C28
/* AC7590 800503F0 27A60070 */   addiu $a2, $sp, 0x70
/* AC7594 800503F4 8FA40040 */  lw    $a0, 0x40($sp)
/* AC7598 800503F8 0C01EFE4 */  jal   func_8007BF90
/* AC759C 800503FC 8FA50044 */   lw    $a1, 0x44($sp)
/* AC75A0 80050400 C60A000C */  lwc1  $f10, 0xc($s0)
/* AC75A4 80050404 E60000DC */  swc1  $f0, 0xdc($s0)
/* AC75A8 80050408 A600015A */  sh    $zero, 0x15a($s0)
/* AC75AC 8005040C 02002025 */  move  $a0, $s0
/* AC75B0 80050410 3C053F80 */  lui   $a1, 0x3f80
/* AC75B4 80050414 0C011429 */  jal   func_800450A4
/* AC75B8 80050418 E60A00FC */   swc1  $f10, 0xfc($s0)
/* AC75BC 8005041C E6000100 */  swc1  $f0, 0x100($s0)
/* AC75C0 80050420 8FBF002C */  lw    $ra, 0x2c($sp)
/* AC75C4 80050424 8FB20028 */  lw    $s2, 0x28($sp)
/* AC75C8 80050428 8FB10024 */  lw    $s1, 0x24($sp)
/* AC75CC 8005042C 8FB00020 */  lw    $s0, 0x20($sp)
/* AC75D0 80050430 27BD00A8 */  addiu $sp, $sp, 0xa8
/* AC75D4 80050434 03E00008 */  jr    $ra
/* AC75D8 80050438 24020001 */   li    $v0, 1
