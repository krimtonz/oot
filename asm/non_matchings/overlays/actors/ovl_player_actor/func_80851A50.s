glabel func_80851A50
/* 1F840 80851A50 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 1F844 80851A54 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 1F848 80851A58 00A08025 */  or      $s0, $a1, $zero            ## $s0 = 00000000
/* 1F84C 80851A5C AFBF001C */  sw      $ra, 0x001C($sp)           
/* 1F850 80851A60 24A501B4 */  addiu   $a1, $a1, 0x01B4           ## $a1 = 000001B4
/* 1F854 80851A64 AFA60038 */  sw      $a2, 0x0038($sp)           
/* 1F858 80851A68 0C028EF0 */  jal     func_800A3BC0              
/* 1F85C 80851A6C AFA50024 */  sw      $a1, 0x0024($sp)           
/* 1F860 80851A70 3C078016 */  lui     $a3, %hi(gSaveContext)
/* 1F864 80851A74 24E7E660 */  addiu   $a3, %lo(gSaveContext)
/* 1F868 80851A78 8CE30004 */  lw      $v1, 0x0004($a3)           ## 8015E664
/* 1F86C 80851A7C 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 1F870 80851A80 14600007 */  bne     $v1, $zero, .L80851AA0     
/* 1F874 80851A84 00000000 */  nop
/* 1F878 80851A88 0C02914C */  jal     SkelAnime_PastFrameTestUpdRate              
/* 1F87C 80851A8C 3C05428C */  lui     $a1, 0x428C                ## $a1 = 428C0000
/* 1F880 80851A90 3C078016 */  lui     $a3, %hi(gSaveContext)
/* 1F884 80851A94 14400009 */  bne     $v0, $zero, .L80851ABC     
/* 1F888 80851A98 24E7E660 */  addiu   $a3, %lo(gSaveContext)
/* 1F88C 80851A9C 8CE30004 */  lw      $v1, 0x0004($a3)           ## 8015E664
.L80851AA0:
/* 1F890 80851AA0 10600026 */  beq     $v1, $zero, .L80851B3C     
/* 1F894 80851AA4 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 1F898 80851AA8 0C02914C */  jal     SkelAnime_PastFrameTestUpdRate              
/* 1F89C 80851AAC 3C0542AE */  lui     $a1, 0x42AE                ## $a1 = 42AE0000
/* 1F8A0 80851AB0 3C078016 */  lui     $a3, %hi(gSaveContext)
/* 1F8A4 80851AB4 10400021 */  beq     $v0, $zero, .L80851B3C     
/* 1F8A8 80851AB8 24E7E660 */  addiu   $a3, %lo(gSaveContext)
.L80851ABC:
/* 1F8AC 80851ABC 8E190438 */  lw      $t9, 0x0438($s0)           ## 00000438
/* 1F8B0 80851AC0 8CEE0004 */  lw      $t6, 0x0004($a3)           ## 8015E664
/* 1F8B4 80851AC4 3C188085 */  lui     $t8, %hi(D_808551A4)       ## $t8 = 80850000
/* 1F8B8 80851AC8 AF300118 */  sw      $s0, 0x0118($t9)           ## 00000118
/* 1F8BC 80851ACC 8CE30004 */  lw      $v1, 0x0004($a3)           ## 8015E664
/* 1F8C0 80851AD0 271851A4 */  addiu   $t8, $t8, %lo(D_808551A4)  ## $t8 = 808551A4
/* 1F8C4 80851AD4 000E7880 */  sll     $t7, $t6,  2               
/* 1F8C8 80851AD8 10600004 */  beq     $v1, $zero, .L80851AEC     
/* 1F8CC 80851ADC 01F83021 */  addu    $a2, $t7, $t8              
/* 1F8D0 80851AE0 3C028012 */  lui     $v0, %hi(D_80125DE8)
/* 1F8D4 80851AE4 10000003 */  beq     $zero, $zero, .L80851AF4   
/* 1F8D8 80851AE8 24425DE8 */  addiu   $v0, %lo(D_80125DE8)
.L80851AEC:
/* 1F8DC 80851AEC 3C028012 */  lui     $v0, %hi(D_80125E18)
/* 1F8E0 80851AF0 24425E18 */  addiu   $v0, %lo(D_80125E18)
.L80851AF4:
/* 1F8E4 80851AF4 00034080 */  sll     $t0, $v1,  2               
/* 1F8E8 80851AF8 01024821 */  addu    $t1, $t0, $v0              
/* 1F8EC 80851AFC AE090164 */  sw      $t1, 0x0164($s0)           ## 00000164
/* 1F8F0 80851B00 94C50000 */  lhu     $a1, 0x0000($a2)           ## 00000000
/* 1F8F4 80851B04 AFA6002C */  sw      $a2, 0x002C($sp)           
/* 1F8F8 80851B08 0C00BDF7 */  jal     func_8002F7DC              
/* 1F8FC 80851B0C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1F900 80851B10 3C078016 */  lui     $a3, %hi(gSaveContext)
/* 1F904 80851B14 24E7E660 */  addiu   $a3, %lo(gSaveContext)
/* 1F908 80851B18 8CEA0004 */  lw      $t2, 0x0004($a3)           ## 8015E664
/* 1F90C 80851B1C 8FA6002C */  lw      $a2, 0x002C($sp)           
/* 1F910 80851B20 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1F914 80851B24 51400016 */  beql    $t2, $zero, .L80851B80     
/* 1F918 80851B28 8FBF001C */  lw      $ra, 0x001C($sp)           
/* 1F91C 80851B2C 0C20C9A6 */  jal     func_80832698              
/* 1F920 80851B30 94C50002 */  lhu     $a1, 0x0002($a2)           ## 00000002
/* 1F924 80851B34 10000012 */  beq     $zero, $zero, .L80851B80   
/* 1F928 80851B38 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80851B3C:
/* 1F92C 80851B3C 8CEB0004 */  lw      $t3, 0x0004($a3)           ## 00000004
/* 1F930 80851B40 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1F934 80851B44 3C058085 */  lui     $a1, %hi(D_808551AC)       ## $a1 = 80850000
/* 1F938 80851B48 1560000A */  bne     $t3, $zero, .L80851B74     
/* 1F93C 80851B4C 00000000 */  nop
/* 1F940 80851B50 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 1F944 80851B54 0C02914C */  jal     SkelAnime_PastFrameTestUpdRate              
/* 1F948 80851B58 3C054284 */  lui     $a1, 0x4284                ## $a1 = 42840000
/* 1F94C 80851B5C 10400007 */  beq     $v0, $zero, .L80851B7C     
/* 1F950 80851B60 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1F954 80851B64 0C20C9A6 */  jal     func_80832698              
/* 1F958 80851B68 24056801 */  addiu   $a1, $zero, 0x6801         ## $a1 = 00006801
/* 1F95C 80851B6C 10000004 */  beq     $zero, $zero, .L80851B80   
/* 1F960 80851B70 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80851B74:
/* 1F964 80851B74 0C20CA49 */  jal     func_80832924              
/* 1F968 80851B78 24A551AC */  addiu   $a1, $a1, %lo(D_808551AC)  ## $a1 = 000051AC
.L80851B7C:
/* 1F96C 80851B7C 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80851B80:
/* 1F970 80851B80 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 1F974 80851B84 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 1F978 80851B88 03E00008 */  jr      $ra                        
/* 1F97C 80851B8C 00000000 */  nop
