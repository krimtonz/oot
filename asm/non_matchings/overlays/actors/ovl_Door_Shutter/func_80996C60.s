glabel func_80996C60
/* 009C0 80996C60 27BDFFC0 */  addiu   $sp, $sp, 0xFFC0           ## $sp = FFFFFFC0
/* 009C4 80996C64 AFBF002C */  sw      $ra, 0x002C($sp)           
/* 009C8 80996C68 AFB00028 */  sw      $s0, 0x0028($sp)           
/* 009CC 80996C6C 908E0002 */  lbu     $t6, 0x0002($a0)           ## 00000002
/* 009D0 80996C70 2401000A */  addiu   $at, $zero, 0x000A         ## $at = 0000000A
/* 009D4 80996C74 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 009D8 80996C78 55C10022 */  bnel    $t6, $at, .L80996D04       
/* 009DC 80996C7C 8FBF002C */  lw      $ra, 0x002C($sp)           
/* 009E0 80996C80 8CAF1C44 */  lw      $t7, 0x1C44($a1)           ## 00001C44
/* 009E4 80996C84 2419000F */  addiu   $t9, $zero, 0x000F         ## $t9 = 0000000F
/* 009E8 80996C88 AFAF003C */  sw      $t7, 0x003C($sp)           
/* 009EC 80996C8C 9098016C */  lbu     $t8, 0x016C($a0)           ## 0000016C
/* 009F0 80996C90 AFB90034 */  sw      $t9, 0x0034($sp)           
/* 009F4 80996C94 AFA50044 */  sw      $a1, 0x0044($sp)           
/* 009F8 80996C98 0C2658AB */  jal     func_809962AC              
/* 009FC 80996C9C AFB80038 */  sw      $t8, 0x0038($sp)           
/* 00A00 80996CA0 10400003 */  beq     $v0, $zero, .L80996CB0     
/* 00A04 80996CA4 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 00A08 80996CA8 24080020 */  addiu   $t0, $zero, 0x0020         ## $t0 = 00000020
/* 00A0C 80996CAC AFA80034 */  sw      $t0, 0x0034($sp)           
.L80996CB0:
/* 00A10 80996CB0 3C058099 */  lui     $a1, %hi(func_80997004)    ## $a1 = 80990000
/* 00A14 80996CB4 0C2658A8 */  jal     func_809962A0              
/* 00A18 80996CB8 24A57004 */  addiu   $a1, $a1, %lo(func_80997004) ## $a1 = 80997004
/* 00A1C 80996CBC 44800000 */  mtc1    $zero, $f0                 ## $f0 = 0.00
/* 00A20 80996CC0 8FA90038 */  lw      $t1, 0x0038($sp)           
/* 00A24 80996CC4 240C000C */  addiu   $t4, $zero, 0x000C         ## $t4 = 0000000C
/* 00A28 80996CC8 E6000170 */  swc1    $f0, 0x0170($s0)           ## 00000170
/* 00A2C 80996CCC A209016C */  sb      $t1, 0x016C($s0)           ## 0000016C
/* 00A30 80996CD0 8FAB003C */  lw      $t3, 0x003C($sp)           
/* 00A34 80996CD4 8FAA0044 */  lw      $t2, 0x0044($sp)           
/* 00A38 80996CD8 8FAD0034 */  lw      $t5, 0x0034($sp)           
/* 00A3C 80996CDC 8566046A */  lh      $a2, 0x046A($t3)           ## 0000046A
/* 00A40 80996CE0 8D440790 */  lw      $a0, 0x0790($t2)           ## 00000790
/* 00A44 80996CE4 240E000A */  addiu   $t6, $zero, 0x000A         ## $t6 = 0000000A
/* 00A48 80996CE8 44070000 */  mfc1    $a3, $f0                   
/* 00A4C 80996CEC AFAE0018 */  sw      $t6, 0x0018($sp)           
/* 00A50 80996CF0 AFAC0010 */  sw      $t4, 0x0010($sp)           
/* 00A54 80996CF4 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 00A58 80996CF8 0C016B50 */  jal     Camera_ChangeDoorCam              
/* 00A5C 80996CFC AFAD0014 */  sw      $t5, 0x0014($sp)           
/* 00A60 80996D00 8FBF002C */  lw      $ra, 0x002C($sp)           
.L80996D04:
/* 00A64 80996D04 8FB00028 */  lw      $s0, 0x0028($sp)           
/* 00A68 80996D08 27BD0040 */  addiu   $sp, $sp, 0x0040           ## $sp = 00000000
/* 00A6C 80996D0C 03E00008 */  jr      $ra                        
/* 00A70 80996D10 00000000 */  nop
