glabel func_80A4725C
/* 0452C 80A4725C 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 04530 80A47260 AFBF0024 */  sw      $ra, 0x0024($sp)           
/* 04534 80A47264 AFB00020 */  sw      $s0, 0x0020($sp)           
/* 04538 80A47268 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 0453C 80A4726C 90820212 */  lbu     $v0, 0x0212($a0)           ## 00000212
/* 04540 80A47270 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 04544 80A47274 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 04548 80A47278 10400008 */  beq     $v0, $zero, .L80A4729C     
/* 0454C 80A4727C 3C0580A5 */  lui     $a1, %hi(D_80A48348)       ## $a1 = 80A50000
/* 04550 80A47280 24010001 */  addiu   $at, $zero, 0x0001         ## $at = 00000001
/* 04554 80A47284 1041002A */  beq     $v0, $at, .L80A47330       
/* 04558 80A47288 24010002 */  addiu   $at, $zero, 0x0002         ## $at = 00000002
/* 0455C 80A4728C 1041005A */  beq     $v0, $at, .L80A473F8       
/* 04560 80A47290 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 04564 80A47294 1000007A */  beq     $zero, $zero, .L80A47480   
/* 04568 80A47298 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A4729C:
/* 0456C 80A4729C 24A58348 */  addiu   $a1, $a1, %lo(D_80A48348)  ## $a1 = 80A48348
/* 04570 80A472A0 0C00D3B0 */  jal     func_80034EC0              
/* 04574 80A472A4 24060005 */  addiu   $a2, $zero, 0x0005         ## $a2 = 00000005
/* 04578 80A472A8 3C014270 */  lui     $at, 0x4270                ## $at = 42700000
/* 0457C 80A472AC 44810000 */  mtc1    $at, $f0                   ## $f0 = 60.00
/* 04580 80A472B0 C604015C */  lwc1    $f4, 0x015C($s0)           ## 0000015C
/* 04584 80A472B4 8E0E0004 */  lw      $t6, 0x0004($s0)           ## 00000004
/* 04588 80A472B8 861800B6 */  lh      $t8, 0x00B6($s0)           ## 000000B6
/* 0458C 80A472BC 46002180 */  add.s   $f6, $f4, $f0              
/* 04590 80A472C0 920C0212 */  lbu     $t4, 0x0212($s0)           ## 00000212
/* 04594 80A472C4 2401FFFE */  addiu   $at, $zero, 0xFFFE         ## $at = FFFFFFFE
/* 04598 80A472C8 24080001 */  addiu   $t0, $zero, 0x0001         ## $t0 = 00000001
/* 0459C 80A472CC 46003200 */  add.s   $f8, $f6, $f0              
/* 045A0 80A472D0 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
/* 045A4 80A472D4 01C17824 */  and     $t7, $t6, $at              
/* 045A8 80A472D8 271905B0 */  addiu   $t9, $t8, 0x05B0           ## $t9 = 000005B0
/* 045AC 80A472DC 4600428D */  trunc.w.s $f10, $f8                  
/* 045B0 80A472E0 258D0001 */  addiu   $t5, $t4, 0x0001           ## $t5 = 00000001
/* 045B4 80A472E4 AE0F0004 */  sw      $t7, 0x0004($s0)           ## 00000004
/* 045B8 80A472E8 A61900B6 */  sh      $t9, 0x00B6($s0)           ## 000000B6
/* 045BC 80A472EC 440A5000 */  mfc1    $t2, $f10                  
/* 045C0 80A472F0 A608026E */  sh      $t0, 0x026E($s0)           ## 0000026E
/* 045C4 80A472F4 A20B0213 */  sb      $t3, 0x0213($s0)           ## 00000213
/* 045C8 80A472F8 A200020C */  sb      $zero, 0x020C($s0)         ## 0000020C
/* 045CC 80A472FC A20D0212 */  sb      $t5, 0x0212($s0)           ## 00000212
/* 045D0 80A47300 24040028 */  addiu   $a0, $zero, 0x0028         ## $a0 = 00000028
/* 045D4 80A47304 24050005 */  addiu   $a1, $zero, 0x0005         ## $a1 = 00000005
/* 045D8 80A47308 0C03D20F */  jal     func_800F483C              
/* 045DC 80A4730C A60A0592 */  sh      $t2, 0x0592($s0)           ## 00000592
/* 045E0 80A47310 8FA40034 */  lw      $a0, 0x0034($sp)           
/* 045E4 80A47314 2405105E */  addiu   $a1, $zero, 0x105E         ## $a1 = 0000105E
/* 045E8 80A47318 2406FF9D */  addiu   $a2, $zero, 0xFF9D         ## $a2 = FFFFFF9D
/* 045EC 80A4731C 02003825 */  or      $a3, $s0, $zero            ## $a3 = 00000000
/* 045F0 80A47320 0C02003E */  jal     func_800800F8              
/* 045F4 80A47324 AFA00010 */  sw      $zero, 0x0010($sp)         
/* 045F8 80A47328 10000055 */  beq     $zero, $zero, .L80A47480   
/* 045FC 80A4732C 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A47330:
/* 04600 80A47330 86030592 */  lh      $v1, 0x0592($s0)           ## 00000592
/* 04604 80A47334 3C048013 */  lui     $a0, %hi(D_801333D4)
/* 04608 80A47338 248433D4 */  addiu   $a0, %lo(D_801333D4)
/* 0460C 80A4733C 14600003 */  bne     $v1, $zero, .L80A4734C     
/* 04610 80A47340 246EFFFF */  addiu   $t6, $v1, 0xFFFF           ## $t6 = FFFFFFFF
/* 04614 80A47344 10000004 */  beq     $zero, $zero, .L80A47358   
/* 04618 80A47348 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80A4734C:
/* 0461C 80A4734C A60E0592 */  sh      $t6, 0x0592($s0)           ## 00000592
/* 04620 80A47350 86030592 */  lh      $v1, 0x0592($s0)           ## 00000592
/* 04624 80A47354 00601025 */  or      $v0, $v1, $zero            ## $v0 = 00000000
.L80A47358:
/* 04628 80A47358 10400013 */  beq     $v0, $zero, .L80A473A8     
/* 0462C 80A4735C 2405391D */  addiu   $a1, $zero, 0x391D         ## $a1 = 0000391D
/* 04630 80A47360 2401003C */  addiu   $at, $zero, 0x003C         ## $at = 0000003C
/* 04634 80A47364 10610004 */  beq     $v1, $at, .L80A47378       
/* 04638 80A47368 8FAF0034 */  lw      $t7, 0x0034($sp)           
/* 0463C 80A4736C 24010078 */  addiu   $at, $zero, 0x0078         ## $at = 00000078
/* 04640 80A47370 54610043 */  bnel    $v1, $at, .L80A47480       
/* 04644 80A47374 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A47378:
/* 04648 80A47378 85F807A0 */  lh      $t8, 0x07A0($t7)           ## 000007A0
/* 0464C 80A4737C 0018C880 */  sll     $t9, $t8,  2               
/* 04650 80A47380 01F94021 */  addu    $t0, $t7, $t9              
/* 04654 80A47384 0C016C69 */  jal     func_8005B1A4              
/* 04658 80A47388 8D040790 */  lw      $a0, 0x0790($t0)           ## 00000790
/* 0465C 80A4738C 3C048013 */  lui     $a0, %hi(D_801333D4)
/* 04660 80A47390 248433D4 */  addiu   $a0, %lo(D_801333D4)
/* 04664 80A47394 240528B5 */  addiu   $a1, $zero, 0x28B5         ## $a1 = 000028B5
/* 04668 80A47398 0C03D149 */  jal     func_800F4524              
/* 0466C 80A4739C 2406003C */  addiu   $a2, $zero, 0x003C         ## $a2 = 0000003C
/* 04670 80A473A0 10000037 */  beq     $zero, $zero, .L80A47480   
/* 04674 80A473A4 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A473A8:
/* 04678 80A473A8 0C03D149 */  jal     func_800F4524              
/* 0467C 80A473AC 2406003C */  addiu   $a2, $zero, 0x003C         ## $a2 = 0000003C
/* 04680 80A473B0 3C0580A5 */  lui     $a1, %hi(D_80A48348)       ## $a1 = 80A50000
/* 04684 80A473B4 24A58348 */  addiu   $a1, $a1, %lo(D_80A48348)  ## $a1 = 80A48348
/* 04688 80A473B8 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 0468C 80A473BC 0C00D3B0 */  jal     func_80034EC0              
/* 04690 80A473C0 24060006 */  addiu   $a2, $zero, 0x0006         ## $a2 = 00000006
/* 04694 80A473C4 8FA40034 */  lw      $a0, 0x0034($sp)           
/* 04698 80A473C8 0C042DC8 */  jal     func_8010B720              
/* 0469C 80A473CC 2405305A */  addiu   $a1, $zero, 0x305A         ## $a1 = 0000305A
/* 046A0 80A473D0 920A0212 */  lbu     $t2, 0x0212($s0)           ## 00000212
/* 046A4 80A473D4 24090003 */  addiu   $t1, $zero, 0x0003         ## $t1 = 00000003
/* 046A8 80A473D8 A2090213 */  sb      $t1, 0x0213($s0)           ## 00000213
/* 046AC 80A473DC 254B0001 */  addiu   $t3, $t2, 0x0001           ## $t3 = 00000001
/* 046B0 80A473E0 A20B0212 */  sb      $t3, 0x0212($s0)           ## 00000212
/* 046B4 80A473E4 2404007F */  addiu   $a0, $zero, 0x007F         ## $a0 = 0000007F
/* 046B8 80A473E8 0C03D20F */  jal     func_800F483C              
/* 046BC 80A473EC 24050005 */  addiu   $a1, $zero, 0x0005         ## $a1 = 00000005
/* 046C0 80A473F0 10000023 */  beq     $zero, $zero, .L80A47480   
/* 046C4 80A473F4 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A473F8:
/* 046C8 80A473F8 8E05015C */  lw      $a1, 0x015C($s0)           ## 0000015C
/* 046CC 80A473FC 0C0295B2 */  jal     SkelAnime_FrameTest              
/* 046D0 80A47400 AFA40028 */  sw      $a0, 0x0028($sp)           
/* 046D4 80A47404 50400003 */  beql    $v0, $zero, .L80A47414     
/* 046D8 80A47408 8FA40034 */  lw      $a0, 0x0034($sp)           
/* 046DC 80A4740C A2000213 */  sb      $zero, 0x0213($s0)         ## 00000213
/* 046E0 80A47410 8FA40034 */  lw      $a0, 0x0034($sp)           
.L80A47414:
/* 046E4 80A47414 0C042F6F */  jal     func_8010BDBC              
/* 046E8 80A47418 248420D8 */  addiu   $a0, $a0, 0x20D8           ## $a0 = 000020D8
/* 046EC 80A4741C 24010002 */  addiu   $at, $zero, 0x0002         ## $at = 00000002
/* 046F0 80A47420 14410016 */  bne     $v0, $at, .L80A4747C       
/* 046F4 80A47424 8FA40028 */  lw      $a0, 0x0028($sp)           
/* 046F8 80A47428 3C0580A5 */  lui     $a1, %hi(D_80A48348)       ## $a1 = 80A50000
/* 046FC 80A4742C 24A58348 */  addiu   $a1, $a1, %lo(D_80A48348)  ## $a1 = 80A48348
/* 04700 80A47430 0C00D3B0 */  jal     func_80034EC0              
/* 04704 80A47434 24060001 */  addiu   $a2, $zero, 0x0001         ## $a2 = 00000001
/* 04708 80A47438 8E0C0004 */  lw      $t4, 0x0004($s0)           ## 00000004
/* 0470C 80A4743C 44808000 */  mtc1    $zero, $f16                ## $f16 = 0.00
/* 04710 80A47440 C612015C */  lwc1    $f18, 0x015C($s0)          ## 0000015C
/* 04714 80A47444 240E0002 */  addiu   $t6, $zero, 0x0002         ## $t6 = 00000002
/* 04718 80A47448 358D0001 */  ori     $t5, $t4, 0x0001           ## $t5 = 00000001
/* 0471C 80A4744C AE0D0004 */  sw      $t5, 0x0004($s0)           ## 00000004
/* 04720 80A47450 A60E026E */  sh      $t6, 0x026E($s0)           ## 0000026E
/* 04724 80A47454 E6100168 */  swc1    $f16, 0x0168($s0)          ## 00000168
/* 04728 80A47458 E6120164 */  swc1    $f18, 0x0164($s0)          ## 00000164
/* 0472C 80A4745C 8FA50034 */  lw      $a1, 0x0034($sp)           
/* 04730 80A47460 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 04734 80A47464 0C290D09 */  jal     func_80A43424              
/* 04738 80A47468 24060026 */  addiu   $a2, $zero, 0x0026         ## $a2 = 00000026
/* 0473C 80A4746C 3C1880A4 */  lui     $t8, %hi(func_80A470E8)    ## $t8 = 80A40000
/* 04740 80A47470 271870E8 */  addiu   $t8, $t8, %lo(func_80A470E8) ## $t8 = 80A470E8
/* 04744 80A47474 AE180190 */  sw      $t8, 0x0190($s0)           ## 00000190
/* 04748 80A47478 A2000212 */  sb      $zero, 0x0212($s0)         ## 00000212
.L80A4747C:
/* 0474C 80A4747C 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80A47480:
/* 04750 80A47480 8FB00020 */  lw      $s0, 0x0020($sp)           
/* 04754 80A47484 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 04758 80A47488 03E00008 */  jr      $ra                        
/* 0475C 80A4748C 00000000 */  nop
