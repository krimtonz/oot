glabel EnHata_Update
/* 00178 80A50EC8 27BDFFA0 */  addiu   $sp, $sp, 0xFFA0           ## $sp = FFFFFFA0
/* 0017C 80A50ECC 3C0F80A5 */  lui     $t7, %hi(D_80A51248)       ## $t7 = 80A50000
/* 00180 80A50ED0 AFBF002C */  sw      $ra, 0x002C($sp)           
/* 00184 80A50ED4 AFB20028 */  sw      $s2, 0x0028($sp)           
/* 00188 80A50ED8 AFB10024 */  sw      $s1, 0x0024($sp)           
/* 0018C 80A50EDC AFB00020 */  sw      $s0, 0x0020($sp)           
/* 00190 80A50EE0 25EF1248 */  addiu   $t7, $t7, %lo(D_80A51248)  ## $t7 = 80A51248
/* 00194 80A50EE4 8DF90000 */  lw      $t9, 0x0000($t7)           ## 80A51248
/* 00198 80A50EE8 27AE0048 */  addiu   $t6, $sp, 0x0048           ## $t6 = FFFFFFE8
/* 0019C 80A50EEC 8DF80004 */  lw      $t8, 0x0004($t7)           ## 80A5124C
/* 001A0 80A50EF0 ADD90000 */  sw      $t9, 0x0000($t6)           ## FFFFFFE8
/* 001A4 80A50EF4 8DF90008 */  lw      $t9, 0x0008($t7)           ## 80A51250
/* 001A8 80A50EF8 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 001AC 80A50EFC 00A09025 */  or      $s2, $a1, $zero            ## $s2 = 00000000
/* 001B0 80A50F00 24840164 */  addiu   $a0, $a0, 0x0164           ## $a0 = 00000164
/* 001B4 80A50F04 ADD80004 */  sw      $t8, 0x0004($t6)           ## FFFFFFEC
/* 001B8 80A50F08 0C02927F */  jal     SkelAnime_FrameUpdateMatrix
              
/* 001BC 80A50F0C ADD90008 */  sw      $t9, 0x0008($t6)           ## FFFFFFF0
/* 001C0 80A50F10 2409C000 */  addiu   $t1, $zero, 0xC000         ## $t1 = FFFFC000
/* 001C4 80A50F14 A609023E */  sh      $t1, 0x023E($s0)           ## 0000023E
/* 001C8 80A50F18 860A023E */  lh      $t2, 0x023E($s0)           ## 0000023E
/* 001CC 80A50F1C 3C01437F */  lui     $at, 0x437F                ## $at = 437F0000
/* 001D0 80A50F20 44811000 */  mtc1    $at, $f2                   ## $f2 = 255.00
/* 001D4 80A50F24 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 001D8 80A50F28 02418821 */  addu    $s1, $s2, $at              
/* 001DC 80A50F2C A60A0208 */  sh      $t2, 0x0208($s0)           ## 00000208
/* 001E0 80A50F30 862B0ACC */  lh      $t3, 0x0ACC($s1)           ## 00000ACC
/* 001E4 80A50F34 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 001E8 80A50F38 44806000 */  mtc1    $zero, $f12                ## $f12 = 0.00
/* 001EC 80A50F3C 448B2000 */  mtc1    $t3, $f4                   ## $f4 = 0.00
/* 001F0 80A50F40 00320821 */  addu    $at, $at, $s2              
/* 001F4 80A50F44 468021A0 */  cvt.s.w $f6, $f4                   
/* 001F8 80A50F48 E7A6003C */  swc1    $f6, 0x003C($sp)           
/* 001FC 80A50F4C 862C0ACE */  lh      $t4, 0x0ACE($s1)           ## 00000ACE
/* 00200 80A50F50 448C4000 */  mtc1    $t4, $f8                   ## $f8 = 0.00
/* 00204 80A50F54 00000000 */  nop
/* 00208 80A50F58 468042A0 */  cvt.s.w $f10, $f8                  
/* 0020C 80A50F5C E7AA0040 */  swc1    $f10, 0x0040($sp)          
/* 00210 80A50F60 862D0AD0 */  lh      $t5, 0x0AD0($s1)           ## 00000AD0
/* 00214 80A50F64 448D8000 */  mtc1    $t5, $f16                  ## $f16 = 0.00
/* 00218 80A50F68 00000000 */  nop
/* 0021C 80A50F6C 468084A0 */  cvt.s.w $f18, $f16                 
/* 00220 80A50F70 E7B20044 */  swc1    $f18, 0x0044($sp)          
/* 00224 80A50F74 C6200AD4 */  lwc1    $f0, 0x0AD4($s1)           ## 00000AD4
/* 00228 80A50F78 4600103C */  c.lt.s  $f2, $f0                   
/* 0022C 80A50F7C 00000000 */  nop
/* 00230 80A50F80 45020004 */  bc1fl   .L80A50F94                 
/* 00234 80A50F84 460C003C */  c.lt.s  $f0, $f12                  
/* 00238 80A50F88 E4220AD4 */  swc1    $f2, 0x0AD4($at)           ## 00010AD4
/* 0023C 80A50F8C C6200AD4 */  lwc1    $f0, 0x0AD4($s1)           ## 00000AD4
/* 00240 80A50F90 460C003C */  c.lt.s  $f0, $f12                  
.L80A50F94:
/* 00244 80A50F94 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 00248 80A50F98 00320821 */  addu    $at, $at, $s2              
/* 0024C 80A50F9C 45000002 */  bc1f    .L80A50FA8                 
/* 00250 80A50FA0 00000000 */  nop
/* 00254 80A50FA4 E42C0AD4 */  swc1    $f12, 0x0AD4($at)          ## 00010AD4
.L80A50FA8:
/* 00258 80A50FA8 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 0025C 80A50FAC 00000000 */  nop
/* 00260 80A50FB0 3C013F00 */  lui     $at, 0x3F00                ## $at = 3F000000
/* 00264 80A50FB4 44812000 */  mtc1    $at, $f4                   ## $f4 = 0.50
/* 00268 80A50FB8 00000000 */  nop
/* 0026C 80A50FBC 4600203C */  c.lt.s  $f4, $f0                   
/* 00270 80A50FC0 00000000 */  nop
/* 00274 80A50FC4 45020006 */  bc1fl   .L80A50FE0                 
/* 00278 80A50FC8 86180278 */  lh      $t8, 0x0278($s0)           ## 00000278
/* 0027C 80A50FCC 860E0278 */  lh      $t6, 0x0278($s0)           ## 00000278
/* 00280 80A50FD0 25CF1770 */  addiu   $t7, $t6, 0x1770           ## $t7 = 00001770
/* 00284 80A50FD4 10000004 */  beq     $zero, $zero, .L80A50FE8   
/* 00288 80A50FD8 A60F0278 */  sh      $t7, 0x0278($s0)           ## 00000278
/* 0028C 80A50FDC 86180278 */  lh      $t8, 0x0278($s0)           ## 00000278
.L80A50FE0:
/* 00290 80A50FE0 27190BB8 */  addiu   $t9, $t8, 0x0BB8           ## $t9 = 00000BB8
/* 00294 80A50FE4 A6190278 */  sh      $t9, 0x0278($s0)           ## 00000278
.L80A50FE8:
/* 00298 80A50FE8 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 0029C 80A50FEC 86040278 */  lh      $a0, 0x0278($s0)           ## 00000278
/* 002A0 80A50FF0 3C0142A0 */  lui     $at, 0x42A0                ## $at = 42A00000
/* 002A4 80A50FF4 44813000 */  mtc1    $at, $f6                   ## $f6 = 80.00
/* 002A8 80A50FF8 27A40048 */  addiu   $a0, $sp, 0x0048           ## $a0 = FFFFFFE8
/* 002AC 80A50FFC 27A5003C */  addiu   $a1, $sp, 0x003C           ## $a1 = FFFFFFDC
/* 002B0 80A51000 46060202 */  mul.s   $f8, $f0, $f6              
/* 002B4 80A51004 0C01E027 */  jal     Math_Vec3f_Pitch
              
/* 002B8 80A51008 E7A80038 */  swc1    $f8, 0x0038($sp)           
/* 002BC 80A5100C 3C01437F */  lui     $at, 0x437F                ## $at = 437F0000
/* 002C0 80A51010 44815000 */  mtc1    $at, $f10                  ## $f10 = 255.00
/* 002C4 80A51014 C7B00038 */  lwc1    $f16, 0x0038($sp)          
/* 002C8 80A51018 C6240AD4 */  lwc1    $f4, 0x0AD4($s1)           ## 00000AD4
/* 002CC 80A5101C 00021823 */  subu    $v1, $zero, $v0            
/* 002D0 80A51020 46105481 */  sub.s   $f18, $f10, $f16           
/* 002D4 80A51024 24093A98 */  addiu   $t1, $zero, 0x3A98         ## $t1 = 00003A98
/* 002D8 80A51028 01235023 */  subu    $t2, $t1, $v1              
/* 002DC 80A5102C 448A8000 */  mtc1    $t2, $f16                  ## $f16 = 0.00
/* 002E0 80A51030 46122183 */  div.s   $f6, $f4, $f18             
/* 002E4 80A51034 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 002E8 80A51038 44814000 */  mtc1    $at, $f8                   ## $f8 = 1.00
/* 002EC 80A5103C 860D0276 */  lh      $t5, 0x0276($s0)           ## 00000276
/* 002F0 80A51040 46808120 */  cvt.s.w $f4, $f16                  
/* 002F4 80A51044 86060272 */  lh      $a2, 0x0272($s0)           ## 00000272
/* 002F8 80A51048 86070274 */  lh      $a3, 0x0274($s0)           ## 00000274
/* 002FC 80A5104C 2604020E */  addiu   $a0, $s0, 0x020E           ## $a0 = 0000020E
/* 00300 80A51050 AFAD0010 */  sw      $t5, 0x0010($sp)           
/* 00304 80A51054 46064281 */  sub.s   $f10, $f8, $f6             
/* 00308 80A51058 460A2482 */  mul.s   $f18, $f4, $f10            
/* 0030C 80A5105C 4600920D */  trunc.w.s $f8, $f18                  
/* 00310 80A51060 440C4000 */  mfc1    $t4, $f8                   
/* 00314 80A51064 00000000 */  nop
/* 00318 80A51068 01834021 */  addu    $t0, $t4, $v1              
/* 0031C 80A5106C 00082C00 */  sll     $a1, $t0, 16               
/* 00320 80A51070 0C01E1A7 */  jal     Math_SmoothScaleMaxMinS
              
/* 00324 80A51074 00052C03 */  sra     $a1, $a1, 16               
/* 00328 80A51078 860E020E */  lh      $t6, 0x020E($s0)           ## 0000020E
/* 0032C 80A5107C 27A40048 */  addiu   $a0, $sp, 0x0048           ## $a0 = FFFFFFE8
/* 00330 80A51080 27A5003C */  addiu   $a1, $sp, 0x003C           ## $a1 = FFFFFFDC
/* 00334 80A51084 0C01E01A */  jal     Math_Vec3f_Yaw
              
/* 00338 80A51088 A60E0244 */  sh      $t6, 0x0244($s0)           ## 00000244
/* 0033C 80A5108C 00027823 */  subu    $t7, $zero, $v0            
/* 00340 80A51090 A60F0210 */  sh      $t7, 0x0210($s0)           ## 00000210
/* 00344 80A51094 86180210 */  lh      $t8, 0x0210($s0)           ## 00000210
/* 00348 80A51098 3C013FA0 */  lui     $at, 0x3FA0                ## $at = 3FA00000
/* 0034C 80A5109C 44816000 */  mtc1    $at, $f12                  ## $f12 = 1.25
/* 00350 80A510A0 0C00CFBE */  jal     Math_Rand_ZeroFloat
              
/* 00354 80A510A4 A6180246 */  sh      $t8, 0x0246($s0)           ## 00000246
/* 00358 80A510A8 3C01437F */  lui     $at, 0x437F                ## $at = 437F0000
/* 0035C 80A510AC 44818000 */  mtc1    $at, $f16                  ## $f16 = 255.00
/* 00360 80A510B0 C6260AD4 */  lwc1    $f6, 0x0AD4($s1)           ## 00000AD4
/* 00364 80A510B4 3C014030 */  lui     $at, 0x4030                ## $at = 40300000
/* 00368 80A510B8 44815000 */  mtc1    $at, $f10                  ## $f10 = 2.75
/* 0036C 80A510BC 46103103 */  div.s   $f4, $f6, $f16             
/* 00370 80A510C0 460A0480 */  add.s   $f18, $f0, $f10            
/* 00374 80A510C4 46049202 */  mul.s   $f8, $f18, $f4             
/* 00378 80A510C8 E6080180 */  swc1    $f8, 0x0180($s0)           ## 00000180
/* 0037C 80A510CC 8FBF002C */  lw      $ra, 0x002C($sp)           
/* 00380 80A510D0 8FB20028 */  lw      $s2, 0x0028($sp)           
/* 00384 80A510D4 8FB10024 */  lw      $s1, 0x0024($sp)           
/* 00388 80A510D8 8FB00020 */  lw      $s0, 0x0020($sp)           
/* 0038C 80A510DC 03E00008 */  jr      $ra                        
/* 00390 80A510E0 27BD0060 */  addiu   $sp, $sp, 0x0060           ## $sp = 00000000
