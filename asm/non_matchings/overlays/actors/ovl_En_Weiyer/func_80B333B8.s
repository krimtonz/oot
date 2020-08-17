glabel func_80B333B8
/* 01128 80B333B8 27BDFFD8 */  addiu   $sp, $sp, 0xFFD8           ## $sp = FFFFFFD8
/* 0112C 80B333BC AFBF001C */  sw      $ra, 0x001C($sp)           
/* 01130 80B333C0 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 01134 80B333C4 AFA5002C */  sw      $a1, 0x002C($sp)           
/* 01138 80B333C8 84820194 */  lh      $v0, 0x0194($a0)           ## 00000194
/* 0113C 80B333CC 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 01140 80B333D0 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 01144 80B333D4 10400003 */  beq     $v0, $zero, .L80B333E4     
/* 01148 80B333D8 24060200 */  addiu   $a2, $zero, 0x0200         ## $a2 = 00000200
/* 0114C 80B333DC 244EFFFF */  addiu   $t6, $v0, 0xFFFF           ## $t6 = FFFFFFFF
/* 01150 80B333E0 A48E0194 */  sh      $t6, 0x0194($a0)           ## 00000194
.L80B333E4:
/* 01154 80B333E4 0C01DE2B */  jal     Math_ApproxUpdateScaledS
              
/* 01158 80B333E8 260400B4 */  addiu   $a0, $s0, 0x00B4           ## $a0 = 000000B4
/* 0115C 80B333EC 260400B8 */  addiu   $a0, $s0, 0x00B8           ## $a0 = 000000B8
/* 01160 80B333F0 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 01164 80B333F4 0C01DE2B */  jal     Math_ApproxUpdateScaledS
              
/* 01168 80B333F8 24060200 */  addiu   $a2, $zero, 0x0200         ## $a2 = 00000200
/* 0116C 80B333FC 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 01170 80B33400 0C02927F */  jal     SkelAnime_FrameUpdateMatrix
              
/* 01174 80B33404 AFA40024 */  sw      $a0, 0x0024($sp)           
/* 01178 80B33408 C604000C */  lwc1    $f4, 0x000C($s0)           ## 0000000C
/* 0117C 80B3340C C6060080 */  lwc1    $f6, 0x0080($s0)           ## 00000080
/* 01180 80B33410 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 01184 80B33414 4606203C */  c.lt.s  $f4, $f6                   
/* 01188 80B33418 00000000 */  nop
/* 0118C 80B3341C 4502000F */  bc1fl   .L80B3345C                 
/* 01190 80B33420 86190194 */  lh      $t9, 0x0194($s0)           ## 00000194
/* 01194 80B33424 0C0295B2 */  jal     SkelAnime_FrameTest              
/* 01198 80B33428 24050000 */  addiu   $a1, $zero, 0x0000         ## $a1 = 00000000
/* 0119C 80B3342C 10400003 */  beq     $v0, $zero, .L80B3343C     
/* 011A0 80B33430 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 011A4 80B33434 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 011A8 80B33438 2405394E */  addiu   $a1, $zero, 0x394E         ## $a1 = 0000394E
.L80B3343C:
/* 011AC 80B3343C 960F0088 */  lhu     $t7, 0x0088($s0)           ## 00000088
/* 011B0 80B33440 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 011B4 80B33444 31F80002 */  andi    $t8, $t7, 0x0002           ## $t8 = 00000000
/* 011B8 80B33448 53000004 */  beql    $t8, $zero, .L80B3345C     
/* 011BC 80B3344C 86190194 */  lh      $t9, 0x0194($s0)           ## 00000194
/* 011C0 80B33450 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 011C4 80B33454 2405387B */  addiu   $a1, $zero, 0x387B         ## $a1 = 0000387B
/* 011C8 80B33458 86190194 */  lh      $t9, 0x0194($s0)           ## 00000194
.L80B3345C:
/* 011CC 80B3345C 5720000B */  bnel    $t9, $zero, .L80B3348C     
/* 011D0 80B33460 8FBF001C */  lw      $ra, 0x001C($sp)           
/* 011D4 80B33464 44804000 */  mtc1    $zero, $f8                 ## $f8 = 0.00
/* 011D8 80B33468 44805000 */  mtc1    $zero, $f10                ## $f10 = 0.00
/* 011DC 80B3346C 3C0880B3 */  lui     $t0, %hi(D_80B33AB2)       ## $t0 = 80B30000
/* 011E0 80B33470 E608006C */  swc1    $f8, 0x006C($s0)           ## 0000006C
/* 011E4 80B33474 E60A0060 */  swc1    $f10, 0x0060($s0)          ## 00000060
/* 011E8 80B33478 85083AB2 */  lh      $t0, %lo(D_80B33AB2)($t0)  
/* 011EC 80B3347C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 011F0 80B33480 0C2CC8E1 */  jal     func_80B32384              
/* 011F4 80B33484 A60802C6 */  sh      $t0, 0x02C6($s0)           ## 000002C6
/* 011F8 80B33488 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80B3348C:
/* 011FC 80B3348C 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 01200 80B33490 27BD0028 */  addiu   $sp, $sp, 0x0028           ## $sp = 00000000
/* 01204 80B33494 03E00008 */  jr      $ra                        
/* 01208 80B33498 00000000 */  nop
