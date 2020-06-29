.late_rodata
glabel jtbl_8013A2B8
    .word L800548B8
    .word L80054AB4
    .word L80054C40
    .word L80054DD8
    .word L80054FAC
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L80054F90
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L80054F90
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L8005508C
    .word L80054F6C

glabel D_8013A334
    .float 0.006849315

glabel D_8013A338
    .float 0.002739726

glabel D_8013A33C
    .float 0.1

glabel D_8013A340
    .float 0.04

glabel D_8013A344
    .float 0.11111111

glabel D_8013A348
    .float 0.08888889

glabel D_8013A34C
    .float 0.1

glabel D_8013A350
    .float 0.001

glabel D_8013A354
    .float 0.1

.text
glabel Camera_Demo3
/* ACB934 80054794 27BDFF58 */  addiu $sp, $sp, -0xa8
/* ACB938 80054798 AFB10018 */  sw    $s1, 0x18($sp)
/* ACB93C 8005479C 00808825 */  move  $s1, $a0
/* ACB940 800547A0 AFBF001C */  sw    $ra, 0x1c($sp)
/* ACB944 800547A4 AFB00014 */  sw    $s0, 0x14($sp)
/* ACB948 800547A8 A3A00053 */  sb    $zero, 0x53($sp)
/* ACB94C 800547AC 0C00B721 */  jal   Player_GetCameraYOffset
/* ACB950 800547B0 8C840090 */   lw    $a0, 0x90($a0)
/* ACB954 800547B4 862E014C */  lh    $t6, 0x14c($s1)
/* ACB958 800547B8 8622015E */  lh    $v0, 0x15e($s1)
/* ACB95C 800547BC 46000406 */  mov.s $f16, $f0
/* ACB960 800547C0 31CFFFEF */  andi  $t7, $t6, 0xffef
/* ACB964 800547C4 1040000A */  beqz  $v0, .L800547F0
/* ACB968 800547C8 A62F014C */   sh    $t7, 0x14c($s1)
/* ACB96C 800547CC 2401000A */  li    $at, 10
/* ACB970 800547D0 10410007 */  beq   $v0, $at, .L800547F0
/* ACB974 800547D4 24010014 */   li    $at, 20
/* ACB978 800547D8 10410005 */  beq   $v0, $at, .L800547F0
/* ACB97C 800547DC 3C188016 */   lui   $t8, %hi(gGameInfo) # $t8, 0x8016
/* ACB980 800547E0 8F18FA90 */  lw    $t8, %lo(gGameInfo)($t8)
/* ACB984 800547E4 87030314 */  lh    $v1, 0x314($t8)
/* ACB988 800547E8 1060001A */  beqz  $v1, .L80054854
/* ACB98C 800547EC 00000000 */   nop
.L800547F0:
/* ACB990 800547F0 86390142 */  lh    $t9, 0x142($s1)
/* ACB994 800547F4 3C098012 */  lui   $t1, %hi(sCameraSettings)
/* ACB998 800547F8 862A0144 */  lh    $t2, 0x144($s1)
/* ACB99C 800547FC 001940C0 */  sll   $t0, $t9, 3
/* ACB9A0 80054800 01284821 */  addu  $t1, $t1, $t0
/* ACB9A4 80054804 8D29D068 */  lw    $t1, %lo(sCameraSettings+4)($t1)
/* ACB9A8 80054808 000A58C0 */  sll   $t3, $t2, 3
/* ACB9AC 8005480C 3C188016 */  lui   $t8, %hi(gGameInfo) # $t8, 0x8016
/* ACB9B0 80054810 012B6021 */  addu  $t4, $t1, $t3
/* ACB9B4 80054814 8D820004 */  lw    $v0, 4($t4)
/* ACB9B8 80054818 844D0000 */  lh    $t5, ($v0)
/* ACB9BC 8005481C 24420008 */  addiu $v0, $v0, 8
/* ACB9C0 80054820 448D2000 */  mtc1  $t5, $f4
/* ACB9C4 80054824 00000000 */  nop
/* ACB9C8 80054828 468021A0 */  cvt.s.w $f6, $f4
/* ACB9CC 8005482C E6260000 */  swc1  $f6, ($s1)
/* ACB9D0 80054830 844EFFFC */  lh    $t6, -4($v0)
/* ACB9D4 80054834 448E4000 */  mtc1  $t6, $f8
/* ACB9D8 80054838 00000000 */  nop
/* ACB9DC 8005483C 468042A0 */  cvt.s.w $f10, $f8
/* ACB9E0 80054840 E62A0004 */  swc1  $f10, 4($s1)
/* ACB9E4 80054844 844F0000 */  lh    $t7, ($v0)
/* ACB9E8 80054848 A62F0008 */  sh    $t7, 8($s1)
/* ACB9EC 8005484C 8F18FA90 */  lw    $t8, %lo(gGameInfo)($t8)
/* ACB9F0 80054850 87030314 */  lh    $v1, 0x314($t8)
.L80054854:
/* ACB9F4 80054854 10600004 */  beqz  $v1, .L80054868
/* ACB9F8 80054858 02202025 */   move  $a0, $s1
/* ACB9FC 8005485C 0C011495 */  jal   Camera_CopyPREGToModeValues
/* ACBA00 80054860 E7B0004C */   swc1  $f16, 0x4c($sp)
/* ACBA04 80054864 C7B0004C */  lwc1  $f16, 0x4c($sp)
.L80054868:
/* ACBA08 80054868 26250050 */  addiu $a1, $s1, 0x50
/* ACBA0C 8005486C 2626005C */  addiu $a2, $s1, 0x5c
/* ACBA10 80054870 AFA60034 */  sw    $a2, 0x34($sp)
/* ACBA14 80054874 AFA50030 */  sw    $a1, 0x30($sp)
/* ACBA18 80054878 27A40090 */  addiu $a0, $sp, 0x90
/* ACBA1C 8005487C 0C01F124 */  jal   OLib_Vec3fDiffToVecSphRot90
/* ACBA20 80054880 E7B0004C */   swc1  $f16, 0x4c($sp)
/* ACBA24 80054884 86390008 */  lh    $t9, 8($s1)
/* ACBA28 80054888 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags) # $at, 0x8012
/* ACBA2C 8005488C C7B0004C */  lwc1  $f16, 0x4c($sp)
/* ACBA30 80054890 AC39D3A0 */  sw    $t9, %lo(sCameraInterfaceFlags)($at)
/* ACBA34 80054894 9628015E */  lhu   $t0, 0x15e($s1)
/* ACBA38 80054898 2D01001F */  sltiu $at, $t0, 0x1f
/* ACBA3C 8005489C 102001FB */  beqz  $at, .L8005508C
/* ACBA40 800548A0 00084080 */   sll   $t0, $t0, 2
/* ACBA44 800548A4 3C018014 */  lui   $at, %hi(jtbl_8013A2B8)
/* ACBA48 800548A8 00280821 */  addu  $at, $at, $t0
/* ACBA4C 800548AC 8C28A2B8 */  lw    $t0, %lo(jtbl_8013A2B8)($at)
/* ACBA50 800548B0 01000008 */  jr    $t0
/* ACBA54 800548B4 00000000 */   nop

glabel L800548B8
/* ACBA58 800548B8 862A014C */  lh    $t2, 0x14c($s1)
/* ACBA5C 800548BC 02202025 */  move  $a0, $s1
/* ACBA60 800548C0 3149FFF3 */  andi  $t1, $t2, 0xfff3
/* ACBA64 800548C4 0C010ED8 */  jal   func_80043B60
/* ACBA68 800548C8 A629014C */   sh    $t1, 0x14c($s1)
/* ACBA6C 800548CC C6320000 */  lwc1  $f18, ($s1)
/* ACBA70 800548D0 2630000C */  addiu $s0, $s1, 0xc
/* ACBA74 800548D4 26220094 */  addiu $v0, $s1, 0x94
/* ACBA78 800548D8 E63200FC */  swc1  $f18, 0xfc($s1)
/* ACBA7C 800548DC A6000010 */  sh    $zero, 0x10($s0)
/* ACBA80 800548E0 860B0010 */  lh    $t3, 0x10($s0)
/* ACBA84 800548E4 3C01C6FA */  li    $at, 0xC6FA0000 # 0.000000
/* ACBA88 800548E8 44812000 */  mtc1  $at, $f4
/* ACBA8C 800548EC A62B015A */  sh    $t3, 0x15a($s1)
/* ACBA90 800548F0 8C4D0000 */  lw    $t5, ($v0)
/* ACBA94 800548F4 AE0D0000 */  sw    $t5, ($s0)
/* ACBA98 800548F8 8C4C0004 */  lw    $t4, 4($v0)
/* ACBA9C 800548FC AE0C0004 */  sw    $t4, 4($s0)
/* ACBAA0 80054900 8C4D0008 */  lw    $t5, 8($v0)
/* ACBAA4 80054904 AE0D0008 */  sw    $t5, 8($s0)
/* ACBAA8 80054908 C6200104 */  lwc1  $f0, 0x104($s1)
/* ACBAAC 8005490C 46002032 */  c.eq.s $f4, $f0
/* ACBAB0 80054910 00000000 */  nop
/* ACBAB4 80054914 45030003 */  bc1tl .L80054924
/* ACBAB8 80054918 8444000E */   lh    $a0, 0xe($v0)
/* ACBABC 8005491C E6000004 */  swc1  $f0, 4($s0)
/* ACBAC0 80054920 8444000E */  lh    $a0, 0xe($v0)
.L80054924:
/* ACBAC4 80054924 AFA20028 */  sw    $v0, 0x28($sp)
/* ACBAC8 80054928 0C01DE1C */  jal   Math_Sins
/* ACBACC 8005492C A7A4004A */   sh    $a0, 0x4a($sp)
/* ACBAD0 80054930 3C014220 */  li    $at, 0x42200000 # 0.000000
/* ACBAD4 80054934 44811000 */  mtc1  $at, $f2
/* ACBAD8 80054938 C6080000 */  lwc1  $f8, ($s0)
/* ACBADC 8005493C 87A4004A */  lh    $a0, 0x4a($sp)
/* ACBAE0 80054940 46020182 */  mul.s $f6, $f0, $f2
/* ACBAE4 80054944 46083280 */  add.s $f10, $f6, $f8
/* ACBAE8 80054948 E7AA0068 */  swc1  $f10, 0x68($sp)
/* ACBAEC 8005494C C6120004 */  lwc1  $f18, 4($s0)
/* ACBAF0 80054950 46029100 */  add.s $f4, $f18, $f2
/* ACBAF4 80054954 0C01DE0D */  jal   Math_Coss
/* ACBAF8 80054958 E7A4006C */   swc1  $f4, 0x6c($sp)
/* ACBAFC 8005495C 3C014220 */  li    $at, 0x42200000 # 0.000000
/* ACBB00 80054960 44813000 */  mtc1  $at, $f6
/* ACBB04 80054964 C60A0008 */  lwc1  $f10, 8($s0)
/* ACBB08 80054968 87A4004A */  lh    $a0, 0x4a($sp)
/* ACBB0C 8005496C 46060202 */  mul.s $f8, $f0, $f6
/* ACBB10 80054970 24190001 */  li    $t9, 1
/* ACBB14 80054974 2408FFFF */  li    $t0, -1
/* ACBB18 80054978 460A4480 */  add.s $f18, $f8, $f10
/* ACBB1C 8005497C E7B20070 */  swc1  $f18, 0x70($sp)
/* ACBB20 80054980 8E2E008C */  lw    $t6, 0x8c($s1)
/* ACBB24 80054984 8DCF009C */  lw    $t7, 0x9c($t6)
/* ACBB28 80054988 31F80001 */  andi  $t8, $t7, 1
/* ACBB2C 8005498C 53000007 */  beql  $t8, $zero, .L800549AC
/* ACBB30 80054990 24843FFF */   addiu $a0, $a0, 0x3fff
/* ACBB34 80054994 2484C001 */  addiu $a0, $a0, -0x3fff
/* ACBB38 80054998 00042400 */  sll   $a0, $a0, 0x10
/* ACBB3C 8005499C 00042403 */  sra   $a0, $a0, 0x10
/* ACBB40 800549A0 10000005 */  b     .L800549B8
/* ACBB44 800549A4 A6190012 */   sh    $t9, 0x12($s0)
/* ACBB48 800549A8 24843FFF */  addiu $a0, $a0, 0x3fff
.L800549AC:
/* ACBB4C 800549AC 00042400 */  sll   $a0, $a0, 0x10
/* ACBB50 800549B0 00042403 */  sra   $a0, $a0, 0x10
/* ACBB54 800549B4 A6080012 */  sh    $t0, 0x12($s0)
.L800549B8:
/* ACBB58 800549B8 0C01DE1C */  jal   Math_Sins
/* ACBB5C 800549BC A7A4004A */   sh    $a0, 0x4a($sp)
/* ACBB60 800549C0 3C038012 */  lui   $v1, %hi(D_8011D658) # $v1, 0x8012
/* ACBB64 800549C4 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACBB68 800549C8 C4640008 */  lwc1  $f4, 8($v1)
/* ACBB6C 800549CC C7A80068 */  lwc1  $f8, 0x68($sp)
/* ACBB70 800549D0 3C0140A0 */  li    $at, 0x40A00000 # 0.000000
/* ACBB74 800549D4 46040182 */  mul.s $f6, $f0, $f4
/* ACBB78 800549D8 44812000 */  mtc1  $at, $f4
/* ACBB7C 800549DC 87A4004A */  lh    $a0, 0x4a($sp)
/* ACBB80 800549E0 46083280 */  add.s $f10, $f6, $f8
/* ACBB84 800549E4 E7AA0074 */  swc1  $f10, 0x74($sp)
/* ACBB88 800549E8 C6120004 */  lwc1  $f18, 4($s0)
/* ACBB8C 800549EC 46049180 */  add.s $f6, $f18, $f4
/* ACBB90 800549F0 0C01DE0D */  jal   Math_Coss
/* ACBB94 800549F4 E7A60078 */   swc1  $f6, 0x78($sp)
/* ACBB98 800549F8 3C038012 */  lui   $v1, %hi(D_8011D658) # $v1, 0x8012
/* ACBB9C 800549FC 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACBBA0 80054A00 C4680008 */  lwc1  $f8, 8($v1)
/* ACBBA4 80054A04 C7B20070 */  lwc1  $f18, 0x70($sp)
/* ACBBA8 80054A08 02202025 */  move  $a0, $s1
/* ACBBAC 80054A0C 46080282 */  mul.s $f10, $f0, $f8
/* ACBBB0 80054A10 27A50068 */  addiu $a1, $sp, 0x68
/* ACBBB4 80054A14 27A60074 */  addiu $a2, $sp, 0x74
/* ACBBB8 80054A18 46125100 */  add.s $f4, $f10, $f18
/* ACBBBC 80054A1C 0C010FCD */  jal   func_80043F34
/* ACBBC0 80054A20 E7A4007C */   swc1  $f4, 0x7c($sp)
/* ACBBC4 80054A24 10400004 */  beqz  $v0, .L80054A38
/* ACBBC8 80054A28 3C068012 */   lui   $a2, %hi(D_8011D678)
/* ACBBCC 80054A2C 860A0012 */  lh    $t2, 0x12($s0)
/* ACBBD0 80054A30 000A4823 */  negu  $t1, $t2
/* ACBBD4 80054A34 A6090012 */  sh    $t1, 0x12($s0)
.L80054A38:
/* ACBBD8 80054A38 24C5D678 */  addiu $a1, $a2, %lo(D_8011D678)
/* ACBBDC 80054A3C 0C01F0FD */  jal   OLib_Vec3fToVecSphRot90
/* ACBBE0 80054A40 27A40080 */   addiu $a0, $sp, 0x80
/* ACBBE4 80054A44 8FAC0028 */  lw    $t4, 0x28($sp)
/* ACBBE8 80054A48 87AB0086 */  lh    $t3, 0x86($sp)
/* ACBBEC 80054A4C 8FA40030 */  lw    $a0, 0x30($sp)
/* ACBBF0 80054A50 858D000E */  lh    $t5, 0xe($t4)
/* ACBBF4 80054A54 02002825 */  move  $a1, $s0
/* ACBBF8 80054A58 27A60080 */  addiu $a2, $sp, 0x80
/* ACBBFC 80054A5C 016D7021 */  addu  $t6, $t3, $t5
/* ACBC00 80054A60 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* ACBC04 80054A64 A7AE0086 */   sh    $t6, 0x86($sp)
/* ACBC08 80054A68 3C038012 */  lui   $v1, %hi(D_8011D658) # $v1, 0x8012
/* ACBC0C 80054A6C 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACBC10 80054A70 C4660000 */  lwc1  $f6, ($v1)
/* ACBC14 80054A74 846F0004 */  lh    $t7, 4($v1)
/* ACBC18 80054A78 84780006 */  lh    $t8, 6($v1)
/* ACBC1C 80054A7C E7A60088 */  swc1  $f6, 0x88($sp)
/* ACBC20 80054A80 A7AF008C */  sh    $t7, 0x8c($sp)
/* ACBC24 80054A84 86190012 */  lh    $t9, 0x12($s0)
/* ACBC28 80054A88 8FAA0028 */  lw    $t2, 0x28($sp)
/* ACBC2C 80054A8C 3C013F80 */  li    $at, 0x3F800000 # 0.000000
/* ACBC30 80054A90 03190019 */  multu $t8, $t9
/* ACBC34 80054A94 8549000E */  lh    $t1, 0xe($t2)
/* ACBC38 80054A98 44814000 */  mtc1  $at, $f8
/* ACBC3C 80054A9C 00004012 */  mflo  $t0
/* ACBC40 80054AA0 01096021 */  addu  $t4, $t0, $t1
/* ACBC44 80054AA4 A7AC008E */  sh    $t4, 0x8e($sp)
/* ACBC48 80054AA8 86060010 */  lh    $a2, 0x10($s0)
/* ACBC4C 80054AAC 10000191 */  b     .L800550F4
/* ACBC50 80054AB0 E608000C */   swc1  $f8, 0xc($s0)

glabel L80054AB4
/* ACBC54 80054AB4 2630000C */  addiu $s0, $s1, 0xc
/* ACBC58 80054AB8 860B0010 */  lh    $t3, 0x10($s0)
/* ACBC5C 80054ABC 3C018014 */  lui   $at, %hi(D_8013A334)
/* ACBC60 80054AC0 C424A334 */  lwc1  $f4, %lo(D_8013A334)($at)
/* ACBC64 80054AC4 256DFFFE */  addiu $t5, $t3, -2
/* ACBC68 80054AC8 448D5000 */  mtc1  $t5, $f10
/* ACBC6C 80054ACC 3C068012 */  lui   $a2, %hi(D_8011D678)
/* ACBC70 80054AD0 24C6D678 */  addiu $a2, %lo(D_8011D678) # addiu $a2, $a2, -0x2988
/* ACBC74 80054AD4 468054A0 */  cvt.s.w $f18, $f10
/* ACBC78 80054AD8 C4C20000 */  lwc1  $f2, ($a2)
/* ACBC7C 80054ADC C4C6000C */  lwc1  $f6, 0xc($a2)
/* ACBC80 80054AE0 C4CC0004 */  lwc1  $f12, 4($a2)
/* ACBC84 80054AE4 C4CE0008 */  lwc1  $f14, 8($a2)
/* ACBC88 80054AE8 46023201 */  sub.s $f8, $f6, $f2
/* ACBC8C 80054AEC 46049002 */  mul.s $f0, $f18, $f4
/* ACBC90 80054AF0 C4C40010 */  lwc1  $f4, 0x10($a2)
/* ACBC94 80054AF4 27A40080 */  addiu $a0, $sp, 0x80
/* ACBC98 80054AF8 27A5005C */  addiu $a1, $sp, 0x5c
/* ACBC9C 80054AFC 460C2181 */  sub.s $f6, $f4, $f12
/* ACBCA0 80054B00 46004282 */  mul.s $f10, $f8, $f0
/* ACBCA4 80054B04 E7A00058 */  swc1  $f0, 0x58($sp)
/* ACBCA8 80054B08 46003202 */  mul.s $f8, $f6, $f0
/* ACBCAC 80054B0C 46025480 */  add.s $f18, $f10, $f2
/* ACBCB0 80054B10 460C4280 */  add.s $f10, $f8, $f12
/* ACBCB4 80054B14 E7B2005C */  swc1  $f18, 0x5c($sp)
/* ACBCB8 80054B18 C4D20014 */  lwc1  $f18, 0x14($a2)
/* ACBCBC 80054B1C E7AA0060 */  swc1  $f10, 0x60($sp)
/* ACBCC0 80054B20 460E9101 */  sub.s $f4, $f18, $f14
/* ACBCC4 80054B24 46002182 */  mul.s $f6, $f4, $f0
/* ACBCC8 80054B28 460E3200 */  add.s $f8, $f6, $f14
/* ACBCCC 80054B2C 0C01F0FD */  jal   OLib_Vec3fToVecSphRot90
/* ACBCD0 80054B30 E7A80064 */   swc1  $f8, 0x64($sp)
/* ACBCD4 80054B34 87AE0086 */  lh    $t6, 0x86($sp)
/* ACBCD8 80054B38 860F0012 */  lh    $t7, 0x12($s0)
/* ACBCDC 80054B3C 26230094 */  addiu $v1, $s1, 0x94
/* ACBCE0 80054B40 8479000E */  lh    $t9, 0xe($v1)
/* ACBCE4 80054B44 01CF0019 */  multu $t6, $t7
/* ACBCE8 80054B48 AFA30028 */  sw    $v1, 0x28($sp)
/* ACBCEC 80054B4C 8FA40030 */  lw    $a0, 0x30($sp)
/* ACBCF0 80054B50 02002825 */  move  $a1, $s0
/* ACBCF4 80054B54 27A60080 */  addiu $a2, $sp, 0x80
/* ACBCF8 80054B58 0000C012 */  mflo  $t8
/* ACBCFC 80054B5C 03195021 */  addu  $t2, $t8, $t9
/* ACBD00 80054B60 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* ACBD04 80054B64 A7AA0086 */   sh    $t2, 0x86($sp)
/* ACBD08 80054B68 3C038012 */  lui   $v1, %hi(D_8011D658)
/* ACBD0C 80054B6C 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACBD10 80054B70 84640004 */  lh    $a0, 4($v1)
/* ACBD14 80054B74 8468000C */  lh    $t0, 0xc($v1)
/* ACBD18 80054B78 C4620000 */  lwc1  $f2, ($v1)
/* ACBD1C 80054B7C C46A0008 */  lwc1  $f10, 8($v1)
/* ACBD20 80054B80 01044823 */  subu  $t1, $t0, $a0
/* ACBD24 80054B84 00096400 */  sll   $t4, $t1, 0x10
/* ACBD28 80054B88 000C5C03 */  sra   $t3, $t4, 0x10
/* ACBD2C 80054B8C 448B4000 */  mtc1  $t3, $f8
/* ACBD30 80054B90 46025481 */  sub.s $f18, $f10, $f2
/* ACBD34 80054B94 84650006 */  lh    $a1, 6($v1)
/* ACBD38 80054B98 846A000E */  lh    $t2, 0xe($v1)
/* ACBD3C 80054B9C 468042A0 */  cvt.s.w $f10, $f8
/* ACBD40 80054BA0 C7A00058 */  lwc1  $f0, 0x58($sp)
/* ACBD44 80054BA4 01454023 */  subu  $t0, $t2, $a1
/* ACBD48 80054BA8 00084C00 */  sll   $t1, $t0, 0x10
/* ACBD4C 80054BAC 46009102 */  mul.s $f4, $f18, $f0
/* ACBD50 80054BB0 00096403 */  sra   $t4, $t1, 0x10
/* ACBD54 80054BB4 448C4000 */  mtc1  $t4, $f8
/* ACBD58 80054BB8 46005482 */  mul.s $f18, $f10, $f0
/* ACBD5C 80054BBC 8FAE0028 */  lw    $t6, 0x28($sp)
/* ACBD60 80054BC0 3C018014 */  lui   $at, %hi(D_8013A338)
/* ACBD64 80054BC4 46022180 */  add.s $f6, $f4, $f2
/* ACBD68 80054BC8 468042A0 */  cvt.s.w $f10, $f8
/* ACBD6C 80054BCC E7A60080 */  swc1  $f6, 0x80($sp)
/* ACBD70 80054BD0 E7A60088 */  swc1  $f6, 0x88($sp)
/* ACBD74 80054BD4 4600910D */  trunc.w.s $f4, $f18
/* ACBD78 80054BD8 46005482 */  mul.s $f18, $f10, $f0
/* ACBD7C 80054BDC C42AA338 */  lwc1  $f10, %lo(D_8013A338)($at)
/* ACBD80 80054BE0 44182000 */  mfc1  $t8, $f4
/* ACBD84 80054BE4 00000000 */  nop
/* ACBD88 80054BE8 0304C821 */  addu  $t9, $t8, $a0
/* ACBD8C 80054BEC 4600910D */  trunc.w.s $f4, $f18
/* ACBD90 80054BF0 03204025 */  move  $t0, $t9
/* ACBD94 80054BF4 A7B90084 */  sh    $t9, 0x84($sp)
/* ACBD98 80054BF8 A7A8008C */  sh    $t0, 0x8c($sp)
/* ACBD9C 80054BFC 440F2000 */  mfc1  $t7, $f4
/* ACBDA0 80054C00 00000000 */  nop
/* ACBDA4 80054C04 01E5C021 */  addu  $t8, $t7, $a1
/* ACBDA8 80054C08 A7B80086 */  sh    $t8, 0x86($sp)
/* ACBDAC 80054C0C 86090012 */  lh    $t1, 0x12($s0)
/* ACBDB0 80054C10 00186400 */  sll   $t4, $t8, 0x10
/* ACBDB4 80054C14 000C5C03 */  sra   $t3, $t4, 0x10
/* ACBDB8 80054C18 01690019 */  multu $t3, $t1
/* ACBDBC 80054C1C 85CF000E */  lh    $t7, 0xe($t6)
/* ACBDC0 80054C20 00006812 */  mflo  $t5
/* ACBDC4 80054C24 01AFC821 */  addu  $t9, $t5, $t7
/* ACBDC8 80054C28 A7B9008E */  sh    $t9, 0x8e($sp)
/* ACBDCC 80054C2C C608000C */  lwc1  $f8, 0xc($s0)
/* ACBDD0 80054C30 86060010 */  lh    $a2, 0x10($s0)
/* ACBDD4 80054C34 460A4481 */  sub.s $f18, $f8, $f10
/* ACBDD8 80054C38 1000012E */  b     .L800550F4
/* ACBDDC 80054C3C E612000C */   swc1  $f18, 0xc($s0)

glabel L80054C40
/* ACBDE0 80054C40 2630000C */  addiu $s0, $s1, 0xc
/* ACBDE4 80054C44 860A0010 */  lh    $t2, 0x10($s0)
/* ACBDE8 80054C48 3C018014 */  lui   $at, %hi(D_8013A33C)
/* ACBDEC 80054C4C C428A33C */  lwc1  $f8, %lo(D_8013A33C)($at)
/* ACBDF0 80054C50 2548FF6C */  addiu $t0, $t2, -0x94
/* ACBDF4 80054C54 44882000 */  mtc1  $t0, $f4
/* ACBDF8 80054C58 3C068012 */  lui   $a2, %hi(D_8011D678)
/* ACBDFC 80054C5C 24C6D678 */  addiu $a2, %lo(D_8011D678) # addiu $a2, $a2, -0x2988
/* ACBE00 80054C60 468021A0 */  cvt.s.w $f6, $f4
/* ACBE04 80054C64 C4C2000C */  lwc1  $f2, 0xc($a2)
/* ACBE08 80054C68 C4CA0018 */  lwc1  $f10, 0x18($a2)
/* ACBE0C 80054C6C C4CC0014 */  lwc1  $f12, 0x14($a2)
/* ACBE10 80054C70 27A40080 */  addiu $a0, $sp, 0x80
/* ACBE14 80054C74 46025481 */  sub.s $f18, $f10, $f2
/* ACBE18 80054C78 46083002 */  mul.s $f0, $f6, $f8
/* ACBE1C 80054C7C C4C80010 */  lwc1  $f8, 0x10($a2)
/* ACBE20 80054C80 C4CA001C */  lwc1  $f10, 0x1c($a2)
/* ACBE24 80054C84 27A5005C */  addiu $a1, $sp, 0x5c
/* ACBE28 80054C88 46104381 */  sub.s $f14, $f8, $f16
/* ACBE2C 80054C8C 46009102 */  mul.s $f4, $f18, $f0
/* ACBE30 80054C90 E7A00058 */  swc1  $f0, 0x58($sp)
/* ACBE34 80054C94 460E5481 */  sub.s $f18, $f10, $f14
/* ACBE38 80054C98 C4CA0020 */  lwc1  $f10, 0x20($a2)
/* ACBE3C 80054C9C 46022180 */  add.s $f6, $f4, $f2
/* ACBE40 80054CA0 46009102 */  mul.s $f4, $f18, $f0
/* ACBE44 80054CA4 460C5481 */  sub.s $f18, $f10, $f12
/* ACBE48 80054CA8 E7A6005C */  swc1  $f6, 0x5c($sp)
/* ACBE4C 80054CAC 460E2180 */  add.s $f6, $f4, $f14
/* ACBE50 80054CB0 46009102 */  mul.s $f4, $f18, $f0
/* ACBE54 80054CB4 E7A60060 */  swc1  $f6, 0x60($sp)
/* ACBE58 80054CB8 46103200 */  add.s $f8, $f6, $f16
/* ACBE5C 80054CBC 460C2180 */  add.s $f6, $f4, $f12
/* ACBE60 80054CC0 E7A80060 */  swc1  $f8, 0x60($sp)
/* ACBE64 80054CC4 0C01F0FD */  jal   OLib_Vec3fToVecSphRot90
/* ACBE68 80054CC8 E7A60064 */   swc1  $f6, 0x64($sp)
/* ACBE6C 80054CCC 87B80086 */  lh    $t8, 0x86($sp)
/* ACBE70 80054CD0 860C0012 */  lh    $t4, 0x12($s0)
/* ACBE74 80054CD4 26230094 */  addiu $v1, $s1, 0x94
/* ACBE78 80054CD8 8469000E */  lh    $t1, 0xe($v1)
/* ACBE7C 80054CDC 030C0019 */  multu $t8, $t4
/* ACBE80 80054CE0 AFA30028 */  sw    $v1, 0x28($sp)
/* ACBE84 80054CE4 8FA40030 */  lw    $a0, 0x30($sp)
/* ACBE88 80054CE8 02002825 */  move  $a1, $s0
/* ACBE8C 80054CEC 27A60080 */  addiu $a2, $sp, 0x80
/* ACBE90 80054CF0 00005812 */  mflo  $t3
/* ACBE94 80054CF4 01697021 */  addu  $t6, $t3, $t1
/* ACBE98 80054CF8 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* ACBE9C 80054CFC A7AE0086 */   sh    $t6, 0x86($sp)
/* ACBEA0 80054D00 3C038012 */  lui   $v1, %hi(D_8011D658)
/* ACBEA4 80054D04 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACBEA8 80054D08 8464000C */  lh    $a0, 0xc($v1)
/* ACBEAC 80054D0C 846D0014 */  lh    $t5, 0x14($v1)
/* ACBEB0 80054D10 C4620008 */  lwc1  $f2, 8($v1)
/* ACBEB4 80054D14 C4680010 */  lwc1  $f8, 0x10($v1)
/* ACBEB8 80054D18 01A47823 */  subu  $t7, $t5, $a0
/* ACBEBC 80054D1C 000FCC00 */  sll   $t9, $t7, 0x10
/* ACBEC0 80054D20 00195403 */  sra   $t2, $t9, 0x10
/* ACBEC4 80054D24 448A3000 */  mtc1  $t2, $f6
/* ACBEC8 80054D28 46024281 */  sub.s $f10, $f8, $f2
/* ACBECC 80054D2C 8465000E */  lh    $a1, 0xe($v1)
/* ACBED0 80054D30 846E0016 */  lh    $t6, 0x16($v1)
/* ACBED4 80054D34 46803220 */  cvt.s.w $f8, $f6
/* ACBED8 80054D38 C7A00058 */  lwc1  $f0, 0x58($sp)
/* ACBEDC 80054D3C 01C56823 */  subu  $t5, $t6, $a1
/* ACBEE0 80054D40 000D7C00 */  sll   $t7, $t5, 0x10
/* ACBEE4 80054D44 46005482 */  mul.s $f18, $f10, $f0
/* ACBEE8 80054D48 000FCC03 */  sra   $t9, $t7, 0x10
/* ACBEEC 80054D4C 44993000 */  mtc1  $t9, $f6
/* ACBEF0 80054D50 46004282 */  mul.s $f10, $f8, $f0
/* ACBEF4 80054D54 8FB80028 */  lw    $t8, 0x28($sp)
/* ACBEF8 80054D58 3C018014 */  lui   $at, %hi(D_8013A340)
/* ACBEFC 80054D5C 46029100 */  add.s $f4, $f18, $f2
/* ACBF00 80054D60 46803220 */  cvt.s.w $f8, $f6
/* ACBF04 80054D64 E7A40080 */  swc1  $f4, 0x80($sp)
/* ACBF08 80054D68 E7A40088 */  swc1  $f4, 0x88($sp)
/* ACBF0C 80054D6C 4600548D */  trunc.w.s $f18, $f10
/* ACBF10 80054D70 46004282 */  mul.s $f10, $f8, $f0
/* ACBF14 80054D74 C428A340 */  lwc1  $f8, %lo(D_8013A340)($at)
/* ACBF18 80054D78 440B9000 */  mfc1  $t3, $f18
/* ACBF1C 80054D7C 00000000 */  nop
/* ACBF20 80054D80 01644821 */  addu  $t1, $t3, $a0
/* ACBF24 80054D84 4600548D */  trunc.w.s $f18, $f10
/* ACBF28 80054D88 01206825 */  move  $t5, $t1
/* ACBF2C 80054D8C A7A90084 */  sh    $t1, 0x84($sp)
/* ACBF30 80054D90 A7AD008C */  sh    $t5, 0x8c($sp)
/* ACBF34 80054D94 440C9000 */  mfc1  $t4, $f18
/* ACBF38 80054D98 00000000 */  nop
/* ACBF3C 80054D9C 01855821 */  addu  $t3, $t4, $a1
/* ACBF40 80054DA0 A7AB0086 */  sh    $t3, 0x86($sp)
/* ACBF44 80054DA4 860F0012 */  lh    $t7, 0x12($s0)
/* ACBF48 80054DA8 000BCC00 */  sll   $t9, $t3, 0x10
/* ACBF4C 80054DAC 00195403 */  sra   $t2, $t9, 0x10
/* ACBF50 80054DB0 014F0019 */  multu $t2, $t7
/* ACBF54 80054DB4 870C000E */  lh    $t4, 0xe($t8)
/* ACBF58 80054DB8 00004012 */  mflo  $t0
/* ACBF5C 80054DBC 010C4821 */  addu  $t1, $t0, $t4
/* ACBF60 80054DC0 A7A9008E */  sh    $t1, 0x8e($sp)
/* ACBF64 80054DC4 C606000C */  lwc1  $f6, 0xc($s0)
/* ACBF68 80054DC8 86060010 */  lh    $a2, 0x10($s0)
/* ACBF6C 80054DCC 46083281 */  sub.s $f10, $f6, $f8
/* ACBF70 80054DD0 100000C8 */  b     .L800550F4
/* ACBF74 80054DD4 E60A000C */   swc1  $f10, 0xc($s0)

glabel L80054DD8
/* ACBF78 80054DD8 2630000C */  addiu $s0, $s1, 0xc
/* ACBF7C 80054DDC 860E0010 */  lh    $t6, 0x10($s0)
/* ACBF80 80054DE0 3C018014 */  lui   $at, %hi(D_8013A344)
/* ACBF84 80054DE4 C426A344 */  lwc1  $f6, %lo(D_8013A344)($at)
/* ACBF88 80054DE8 25CDFF61 */  addiu $t5, $t6, -0x9f
/* ACBF8C 80054DEC 448D9000 */  mtc1  $t5, $f18
/* ACBF90 80054DF0 3C068012 */  lui   $a2, %hi(D_8011D678)
/* ACBF94 80054DF4 24C6D678 */  addiu $a2, %lo(D_8011D678) # addiu $a2, $a2, -0x2988
/* ACBF98 80054DF8 46809120 */  cvt.s.w $f4, $f18
/* ACBF9C 80054DFC C4C20018 */  lwc1  $f2, 0x18($a2)
/* ACBFA0 80054E00 C4C80024 */  lwc1  $f8, 0x24($a2)
/* ACBFA4 80054E04 C4CC001C */  lwc1  $f12, 0x1c($a2)
/* ACBFA8 80054E08 C4CE0020 */  lwc1  $f14, 0x20($a2)
/* ACBFAC 80054E0C 46024281 */  sub.s $f10, $f8, $f2
/* ACBFB0 80054E10 46062002 */  mul.s $f0, $f4, $f6
/* ACBFB4 80054E14 C4C60028 */  lwc1  $f6, 0x28($a2)
/* ACBFB8 80054E18 27A40080 */  addiu $a0, $sp, 0x80
/* ACBFBC 80054E1C 27A5005C */  addiu $a1, $sp, 0x5c
/* ACBFC0 80054E20 460C3201 */  sub.s $f8, $f6, $f12
/* ACBFC4 80054E24 C4C6002C */  lwc1  $f6, 0x2c($a2)
/* ACBFC8 80054E28 46005482 */  mul.s $f18, $f10, $f0
/* ACBFCC 80054E2C E7A00058 */  swc1  $f0, 0x58($sp)
/* ACBFD0 80054E30 46004282 */  mul.s $f10, $f8, $f0
/* ACBFD4 80054E34 460E3201 */  sub.s $f8, $f6, $f14
/* ACBFD8 80054E38 46029100 */  add.s $f4, $f18, $f2
/* ACBFDC 80054E3C 460C5480 */  add.s $f18, $f10, $f12
/* ACBFE0 80054E40 46004282 */  mul.s $f10, $f8, $f0
/* ACBFE4 80054E44 E7A4005C */  swc1  $f4, 0x5c($sp)
/* ACBFE8 80054E48 E7B20060 */  swc1  $f18, 0x60($sp)
/* ACBFEC 80054E4C 46109100 */  add.s $f4, $f18, $f16
/* ACBFF0 80054E50 460E5480 */  add.s $f18, $f10, $f14
/* ACBFF4 80054E54 E7A40060 */  swc1  $f4, 0x60($sp)
/* ACBFF8 80054E58 0C01F0FD */  jal   OLib_Vec3fToVecSphRot90
/* ACBFFC 80054E5C E7B20064 */   swc1  $f18, 0x64($sp)
/* ACC000 80054E60 87AB0086 */  lh    $t3, 0x86($sp)
/* ACC004 80054E64 86190012 */  lh    $t9, 0x12($s0)
/* ACC008 80054E68 26230094 */  addiu $v1, $s1, 0x94
/* ACC00C 80054E6C 846F000E */  lh    $t7, 0xe($v1)
/* ACC010 80054E70 01790019 */  multu $t3, $t9
/* ACC014 80054E74 AFA30028 */  sw    $v1, 0x28($sp)
/* ACC018 80054E78 8FA40030 */  lw    $a0, 0x30($sp)
/* ACC01C 80054E7C 02002825 */  move  $a1, $s0
/* ACC020 80054E80 27A60080 */  addiu $a2, $sp, 0x80
/* ACC024 80054E84 00005012 */  mflo  $t2
/* ACC028 80054E88 014FC021 */  addu  $t8, $t2, $t7
/* ACC02C 80054E8C 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* ACC030 80054E90 A7B80086 */   sh    $t8, 0x86($sp)
/* ACC034 80054E94 3C038012 */  lui   $v1, %hi(D_8011D658)
/* ACC038 80054E98 2463D658 */  addiu $v1, %lo(D_8011D658) # addiu $v1, $v1, -0x29a8
/* ACC03C 80054E9C 84640014 */  lh    $a0, 0x14($v1)
/* ACC040 80054EA0 8468001C */  lh    $t0, 0x1c($v1)
/* ACC044 80054EA4 C4620010 */  lwc1  $f2, 0x10($v1)
/* ACC048 80054EA8 C4640018 */  lwc1  $f4, 0x18($v1)
/* ACC04C 80054EAC 01046023 */  subu  $t4, $t0, $a0
/* ACC050 80054EB0 000C4C00 */  sll   $t1, $t4, 0x10
/* ACC054 80054EB4 00097403 */  sra   $t6, $t1, 0x10
/* ACC058 80054EB8 448E9000 */  mtc1  $t6, $f18
/* ACC05C 80054EBC 46022181 */  sub.s $f6, $f4, $f2
/* ACC060 80054EC0 84650016 */  lh    $a1, 0x16($v1)
/* ACC064 80054EC4 8478001E */  lh    $t8, 0x1e($v1)
/* ACC068 80054EC8 46809120 */  cvt.s.w $f4, $f18
/* ACC06C 80054ECC C7A00058 */  lwc1  $f0, 0x58($sp)
/* ACC070 80054ED0 03054023 */  subu  $t0, $t8, $a1
/* ACC074 80054ED4 00086400 */  sll   $t4, $t0, 0x10
/* ACC078 80054ED8 46003202 */  mul.s $f8, $f6, $f0
/* ACC07C 80054EDC 000C4C03 */  sra   $t1, $t4, 0x10
/* ACC080 80054EE0 44899000 */  mtc1  $t1, $f18
/* ACC084 80054EE4 46002182 */  mul.s $f6, $f4, $f0
/* ACC088 80054EE8 8FAB0028 */  lw    $t3, 0x28($sp)
/* ACC08C 80054EEC 3C018014 */  lui   $at, %hi(D_8013A348)
/* ACC090 80054EF0 46024280 */  add.s $f10, $f8, $f2
/* ACC094 80054EF4 46809120 */  cvt.s.w $f4, $f18
/* ACC098 80054EF8 E7AA0080 */  swc1  $f10, 0x80($sp)
/* ACC09C 80054EFC E7AA0088 */  swc1  $f10, 0x88($sp)
/* ACC0A0 80054F00 4600320D */  trunc.w.s $f8, $f6
/* ACC0A4 80054F04 46002182 */  mul.s $f6, $f4, $f0
/* ACC0A8 80054F08 C424A348 */  lwc1  $f4, %lo(D_8013A348)($at)
/* ACC0AC 80054F0C 440A4000 */  mfc1  $t2, $f8
/* ACC0B0 80054F10 00000000 */  nop
/* ACC0B4 80054F14 01447821 */  addu  $t7, $t2, $a0
/* ACC0B8 80054F18 4600320D */  trunc.w.s $f8, $f6
/* ACC0BC 80054F1C 01E04025 */  move  $t0, $t7
/* ACC0C0 80054F20 A7AF0084 */  sh    $t7, 0x84($sp)
/* ACC0C4 80054F24 A7A8008C */  sh    $t0, 0x8c($sp)
/* ACC0C8 80054F28 44194000 */  mfc1  $t9, $f8
/* ACC0CC 80054F2C 00000000 */  nop
/* ACC0D0 80054F30 03255021 */  addu  $t2, $t9, $a1
/* ACC0D4 80054F34 A7AA0086 */  sh    $t2, 0x86($sp)
/* ACC0D8 80054F38 860C0012 */  lh    $t4, 0x12($s0)
/* ACC0DC 80054F3C 000A4C00 */  sll   $t1, $t2, 0x10
/* ACC0E0 80054F40 00097403 */  sra   $t6, $t1, 0x10
/* ACC0E4 80054F44 01CC0019 */  multu $t6, $t4
/* ACC0E8 80054F48 8579000E */  lh    $t9, 0xe($t3)
/* ACC0EC 80054F4C 00006812 */  mflo  $t5
/* ACC0F0 80054F50 01B97821 */  addu  $t7, $t5, $t9
/* ACC0F4 80054F54 A7AF008E */  sh    $t7, 0x8e($sp)
/* ACC0F8 80054F58 C612000C */  lwc1  $f18, 0xc($s0)
/* ACC0FC 80054F5C 86060010 */  lh    $a2, 0x10($s0)
/* ACC100 80054F60 46049180 */  add.s $f6, $f18, $f4
/* ACC104 80054F64 10000063 */  b     .L800550F4
/* ACC108 80054F68 E606000C */   swc1  $f6, 0xc($s0)

glabel L80054F6C
/* ACC10C 80054F6C 8638014C */  lh    $t8, 0x14c($s1)
/* ACC110 80054F70 240E0004 */  li    $t6, 4
/* ACC114 80054F74 37080400 */  ori   $t0, $t8, 0x400
/* ACC118 80054F78 A628014C */  sh    $t0, 0x14c($s1)
/* ACC11C 80054F7C 862A014C */  lh    $t2, 0x14c($s1)
/* ACC120 80054F80 31490008 */  andi  $t1, $t2, 8
/* ACC124 80054F84 51200003 */  beql  $t1, $zero, .L80054F94
/* ACC128 80054F88 240C0001 */   li    $t4, 1
/* ACC12C 80054F8C A62E015E */  sh    $t6, 0x15e($s1)

glabel L80054F90
/* ACC130 80054F90 240C0001 */  li    $t4, 1
.L80054F94:
/* ACC134 80054F94 262B0094 */  addiu $t3, $s1, 0x94
/* ACC138 80054F98 A3AC0053 */  sb    $t4, 0x53($sp)
/* ACC13C 80054F9C AFAB0028 */  sw    $t3, 0x28($sp)
/* ACC140 80054FA0 2630000C */  addiu $s0, $s1, 0xc
/* ACC144 80054FA4 10000053 */  b     .L800550F4
/* ACC148 80054FA8 86060010 */   lh    $a2, 0x10($s0)

glabel L80054FAC
/* ACC14C 80054FAC 3C0142A0 */  li    $at, 0x42A00000 # 0.000000
/* ACC150 80054FB0 44814000 */  mtc1  $at, $f8
/* ACC154 80054FB4 87AD0096 */  lh    $t5, 0x96($sp)
/* ACC158 80054FB8 3C018014 */  lui   $at, %hi(D_8013A34C)
/* ACC15C 80054FBC C42AA34C */  lwc1  $f10, %lo(D_8013A34C)($at)
/* ACC160 80054FC0 A7A0008C */  sh    $zero, 0x8c($sp)
/* ACC164 80054FC4 2630000C */  addiu $s0, $s1, 0xc
/* ACC168 80054FC8 E7A80088 */  swc1  $f8, 0x88($sp)
/* ACC16C 80054FCC A7AD008E */  sh    $t5, 0x8e($sp)
/* ACC170 80054FD0 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags) # $at, 0x8012
/* ACC174 80054FD4 24193400 */  li    $t9, 13312
/* ACC178 80054FD8 E60A000C */  swc1  $f10, 0xc($s0)
/* ACC17C 80054FDC AC39D3A0 */  sw    $t9, %lo(sCameraInterfaceFlags)($at)
/* ACC180 80054FE0 86060010 */  lh    $a2, 0x10($s0)
/* ACC184 80054FE4 3C018014 */  lui   $at, %hi(D_8013A350)
/* ACC188 80054FE8 04C20025 */  bltzl $a2, .L80055080
/* ACC18C 80054FEC 8639014C */   lh    $t9, 0x14c($s1)
/* ACC190 80054FF0 C432A350 */  lwc1  $f18, %lo(D_8013A350)($at)
/* ACC194 80054FF4 C62400D8 */  lwc1  $f4, 0xd8($s1)
/* ACC198 80054FF8 3C0F8016 */  lui   $t7, %hi(D_8015BD7C) # $t7, 0x8016
/* ACC19C 80054FFC 4604903C */  c.lt.s $f18, $f4
/* ACC1A0 80055000 00000000 */  nop
/* ACC1A4 80055004 4503001E */  bc1tl .L80055080
/* ACC1A8 80055008 8639014C */   lh    $t9, 0x14c($s1)
/* ACC1AC 8005500C 8DEFBD7C */  lw    $t7, %lo(D_8015BD7C)($t7)
/* ACC1B0 80055010 3C01FFFF */  lui   $at, (0xFFFF7FFF >> 16) # lui $at, 0xffff
/* ACC1B4 80055014 34217FFF */  ori   $at, (0xFFFF7FFF & 0xFFFF) # ori $at, $at, 0x7fff
/* ACC1B8 80055018 95E20020 */  lhu   $v0, 0x20($t7)
/* ACC1BC 8005501C 0041C027 */  nor   $t8, $v0, $at
/* ACC1C0 80055020 13000016 */  beqz  $t8, .L8005507C
/* ACC1C4 80055024 2401BFFF */   li    $at, -16385
/* ACC1C8 80055028 00414027 */  nor   $t0, $v0, $at
/* ACC1CC 8005502C 11000013 */  beqz  $t0, .L8005507C
/* ACC1D0 80055030 2401FFFD */   li    $at, -3
/* ACC1D4 80055034 00415027 */  nor   $t2, $v0, $at
/* ACC1D8 80055038 11400010 */  beqz  $t2, .L8005507C
/* ACC1DC 8005503C 2401FFFB */   li    $at, -5
/* ACC1E0 80055040 00414827 */  nor   $t1, $v0, $at
/* ACC1E4 80055044 1120000D */  beqz  $t1, .L8005507C
/* ACC1E8 80055048 2401FFF7 */   li    $at, -9
/* ACC1EC 8005504C 00417027 */  nor   $t6, $v0, $at
/* ACC1F0 80055050 11C0000A */  beqz  $t6, .L8005507C
/* ACC1F4 80055054 2401FFFE */   li    $at, -2
/* ACC1F8 80055058 00416027 */  nor   $t4, $v0, $at
/* ACC1FC 8005505C 11800007 */  beqz  $t4, .L8005507C
/* ACC200 80055060 2401FFEF */   li    $at, -17
/* ACC204 80055064 00415827 */  nor   $t3, $v0, $at
/* ACC208 80055068 11600004 */  beqz  $t3, .L8005507C
/* ACC20C 8005506C 2401DFFF */   li    $at, -8193
/* ACC210 80055070 00416827 */  nor   $t5, $v0, $at
/* ACC214 80055074 55A0001C */  bnezl $t5, .L800550E8
/* ACC218 80055078 240C0001 */   li    $t4, 1
.L8005507C:
/* ACC21C 8005507C 8639014C */  lh    $t9, 0x14c($s1)
.L80055080:
/* ACC220 80055080 332F0008 */  andi  $t7, $t9, 8
/* ACC224 80055084 51E00018 */  beql  $t7, $zero, .L800550E8
/* ACC228 80055088 240C0001 */   li    $t4, 1

.L8005508C:
glabel L8005508C
/* ACC22C 8005508C 8638014C */  lh    $t8, 0x14c($s1)
/* ACC230 80055090 86250166 */  lh    $a1, 0x166($s1)
/* ACC234 80055094 2630000C */  addiu $s0, $s1, 0xc
/* ACC238 80055098 37080014 */  ori   $t0, $t8, 0x14
/* ACC23C 8005509C A628014C */  sh    $t0, 0x14c($s1)
/* ACC240 800550A0 862A014C */  lh    $t2, 0x14c($s1)
/* ACC244 800550A4 02202025 */  move  $a0, $s1
/* ACC248 800550A8 24060002 */  li    $a2, 2
/* ACC24C 800550AC 3149FFF7 */  andi  $t1, $t2, 0xfff7
/* ACC250 800550B0 04A10005 */  bgez  $a1, .L800550C8
/* ACC254 800550B4 A629014C */   sh    $t1, 0x14c($s1)
/* ACC258 800550B8 0C016952 */  jal   Camera_ChangeSetting
/* ACC25C 800550BC 86250154 */   lh    $a1, 0x154($s1)
/* ACC260 800550C0 10000005 */  b     .L800550D8
/* ACC264 800550C4 00000000 */   nop
.L800550C8:
/* ACC268 800550C8 0C0169EA */  jal   Camera_ChangeDataIdx
/* ACC26C 800550CC 02202025 */   move  $a0, $s1
/* ACC270 800550D0 240EFFFF */  li    $t6, -1
/* ACC274 800550D4 A62E0166 */  sh    $t6, 0x166($s1)
.L800550D8:
/* ACC278 800550D8 3C018012 */  lui   $at, %hi(sCameraInterfaceFlags) # $at, 0x8012
/* ACC27C 800550DC AC20D3A0 */  sw    $zero, %lo(sCameraInterfaceFlags)($at)
/* ACC280 800550E0 86060010 */  lh    $a2, 0x10($s0)
/* ACC284 800550E4 240C0001 */  li    $t4, 1
.L800550E8:
/* ACC288 800550E8 262B0094 */  addiu $t3, $s1, 0x94
/* ACC28C 800550EC A3AC0053 */  sb    $t4, 0x53($sp)
/* ACC290 800550F0 AFAB0028 */  sw    $t3, 0x28($sp)
.L800550F4:
/* ACC294 800550F4 24CD0001 */  addiu $t5, $a2, 1
/* ACC298 800550F8 A60D0010 */  sh    $t5, 0x10($s0)
/* ACC29C 800550FC 86060010 */  lh    $a2, 0x10($s0)
/* ACC2A0 80055100 24010001 */  li    $at, 1
/* ACC2A4 80055104 14C10003 */  bne   $a2, $at, .L80055114
/* ACC2A8 80055108 2419000A */   li    $t9, 10
/* ACC2AC 8005510C 1000001E */  b     .L80055188
/* ACC2B0 80055110 A639015E */   sh    $t9, 0x15e($s1)
.L80055114:
/* ACC2B4 80055114 24020002 */  li    $v0, 2
/* ACC2B8 80055118 14460004 */  bne   $v0, $a2, .L8005512C
/* ACC2BC 8005511C 24010094 */   li    $at, 148
/* ACC2C0 80055120 240F0001 */  li    $t7, 1
/* ACC2C4 80055124 10000018 */  b     .L80055188
/* ACC2C8 80055128 A62F015E */   sh    $t7, 0x15e($s1)
.L8005512C:
/* ACC2CC 8005512C 54C10004 */  bnel  $a2, $at, .L80055140
/* ACC2D0 80055130 2401009E */   li    $at, 158
/* ACC2D4 80055134 10000014 */  b     .L80055188
/* ACC2D8 80055138 A622015E */   sh    $v0, 0x15e($s1)
/* ACC2DC 8005513C 2401009E */  li    $at, 158
.L80055140:
/* ACC2E0 80055140 14C10003 */  bne   $a2, $at, .L80055150
/* ACC2E4 80055144 24180014 */   li    $t8, 20
/* ACC2E8 80055148 1000000F */  b     .L80055188
/* ACC2EC 8005514C A638015E */   sh    $t8, 0x15e($s1)
.L80055150:
/* ACC2F0 80055150 2401009F */  li    $at, 159
/* ACC2F4 80055154 14C10003 */  bne   $a2, $at, .L80055164
/* ACC2F8 80055158 24080003 */   li    $t0, 3
/* ACC2FC 8005515C 1000000A */  b     .L80055188
/* ACC300 80055160 A628015E */   sh    $t0, 0x15e($s1)
.L80055164:
/* ACC304 80055164 240100A8 */  li    $at, 168
/* ACC308 80055168 14C10003 */  bne   $a2, $at, .L80055178
/* ACC30C 8005516C 240A001E */   li    $t2, 30
/* ACC310 80055170 10000005 */  b     .L80055188
/* ACC314 80055174 A62A015E */   sh    $t2, 0x15e($s1)
.L80055178:
/* ACC318 80055178 240100E4 */  li    $at, 228
/* ACC31C 8005517C 14C10002 */  bne   $a2, $at, .L80055188
/* ACC320 80055180 24090004 */   li    $t1, 4
/* ACC324 80055184 A629015E */  sh    $t1, 0x15e($s1)
.L80055188:
/* ACC328 80055188 93AE0053 */  lbu   $t6, 0x53($sp)
/* ACC32C 8005518C 55C00020 */  bnezl $t6, .L80055210
/* ACC330 80055190 8FA40030 */   lw    $a0, 0x30($sp)
/* ACC334 80055194 C7AC0088 */  lwc1  $f12, 0x88($sp)
/* ACC338 80055198 C7AE0090 */  lwc1  $f14, 0x90($sp)
/* ACC33C 8005519C 8E06000C */  lw    $a2, 0xc($s0)
/* ACC340 800551A0 0C010E27 */  jal   Camera_LERPCeilF
/* ACC344 800551A4 3C074000 */   lui   $a3, 0x4000
/* ACC348 800551A8 E7A00088 */  swc1  $f0, 0x88($sp)
/* ACC34C 800551AC 8E06000C */  lw    $a2, 0xc($s0)
/* ACC350 800551B0 87A4008C */  lh    $a0, 0x8c($sp)
/* ACC354 800551B4 87A50094 */  lh    $a1, 0x94($sp)
/* ACC358 800551B8 0C010E47 */  jal   Camera_LERPCeilS
/* ACC35C 800551BC 2407000A */   li    $a3, 10
/* ACC360 800551C0 A7A2008C */  sh    $v0, 0x8c($sp)
/* ACC364 800551C4 8E06000C */  lw    $a2, 0xc($s0)
/* ACC368 800551C8 87A4008E */  lh    $a0, 0x8e($sp)
/* ACC36C 800551CC 87A50096 */  lh    $a1, 0x96($sp)
/* ACC370 800551D0 0C010E47 */  jal   Camera_LERPCeilS
/* ACC374 800551D4 2407000A */   li    $a3, 10
/* ACC378 800551D8 26300074 */  addiu $s0, $s1, 0x74
/* ACC37C 800551DC A7A2008E */  sh    $v0, 0x8e($sp)
/* ACC380 800551E0 02002025 */  move  $a0, $s0
/* ACC384 800551E4 8FA50030 */  lw    $a1, 0x30($sp)
/* ACC388 800551E8 0C010F0A */  jal   Camera_Vec3fVecSphAdd
/* ACC38C 800551EC 27A60088 */   addiu $a2, $sp, 0x88
/* ACC390 800551F0 8FAC0034 */  lw    $t4, 0x34($sp)
/* ACC394 800551F4 8E0D0000 */  lw    $t5, ($s0)
/* ACC398 800551F8 AD8D0000 */  sw    $t5, ($t4)
/* ACC39C 800551FC 8E0B0004 */  lw    $t3, 4($s0)
/* ACC3A0 80055200 AD8B0004 */  sw    $t3, 4($t4)
/* ACC3A4 80055204 8E0D0008 */  lw    $t5, 8($s0)
/* ACC3A8 80055208 AD8D0008 */  sw    $t5, 8($t4)
/* ACC3AC 8005520C 8FA40030 */  lw    $a0, 0x30($sp)
.L80055210:
/* ACC3B0 80055210 0C01EFE4 */  jal   OLib_Vec3fDist
/* ACC3B4 80055214 8FA50034 */   lw    $a1, 0x34($sp)
/* ACC3B8 80055218 E62000DC */  swc1  $f0, 0xdc($s1)
/* ACC3BC 8005521C 3C018014 */  lui   $at, %hi(D_8013A354)
/* ACC3C0 80055220 C426A354 */  lwc1  $f6, %lo(D_8013A354)($at)
/* ACC3C4 80055224 C6280050 */  lwc1  $f8, 0x50($s1)
/* ACC3C8 80055228 C6240054 */  lwc1  $f4, 0x54($s1)
/* ACC3CC 8005522C E6260100 */  swc1  $f6, 0x100($s1)
/* ACC3D0 80055230 8FB90028 */  lw    $t9, 0x28($sp)
/* ACC3D4 80055234 24020001 */  li    $v0, 1
/* ACC3D8 80055238 C72A0000 */  lwc1  $f10, ($t9)
/* ACC3DC 8005523C 460A4481 */  sub.s $f18, $f8, $f10
/* ACC3E0 80055240 C62A0058 */  lwc1  $f10, 0x58($s1)
/* ACC3E4 80055244 E63200E4 */  swc1  $f18, 0xe4($s1)
/* ACC3E8 80055248 8FAF0028 */  lw    $t7, 0x28($sp)
/* ACC3EC 8005524C C5E60004 */  lwc1  $f6, 4($t7)
/* ACC3F0 80055250 46062201 */  sub.s $f8, $f4, $f6
/* ACC3F4 80055254 E62800E8 */  swc1  $f8, 0xe8($s1)
/* ACC3F8 80055258 8FB80028 */  lw    $t8, 0x28($sp)
/* ACC3FC 8005525C C7120008 */  lwc1  $f18, 8($t8)
/* ACC400 80055260 46125101 */  sub.s $f4, $f10, $f18
/* ACC404 80055264 E62400EC */  swc1  $f4, 0xec($s1)
/* ACC408 80055268 8FBF001C */  lw    $ra, 0x1c($sp)
/* ACC40C 8005526C 8FB10018 */  lw    $s1, 0x18($sp)
/* ACC410 80055270 8FB00014 */  lw    $s0, 0x14($sp)
/* ACC414 80055274 03E00008 */  jr    $ra
/* ACC418 80055278 27BD00A8 */   addiu $sp, $sp, 0xa8
