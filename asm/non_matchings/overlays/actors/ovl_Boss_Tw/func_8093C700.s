glabel func_8093C700
/* 03A30 8093C700 27BDFFD8 */  addiu   $sp, $sp, 0xFFD8           ## $sp = FFFFFFD8
/* 03A34 8093C704 AFBF001C */  sw      $ra, 0x001C($sp)           
/* 03A38 8093C708 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 03A3C 8093C70C AFA5002C */  sw      $a1, 0x002C($sp)           
/* 03A40 8093C710 84820178 */  lh      $v0, 0x0178($a0)           ## 00000178
/* 03A44 8093C714 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 03A48 8093C718 240E0009 */  addiu   $t6, $zero, 0x0009         ## $t6 = 00000009
/* 03A4C 8093C71C 5040000C */  beql    $v0, $zero, .L8093C750     
/* 03A50 8093C720 26040568 */  addiu   $a0, $s0, 0x0568           ## $a0 = 00000568
/* 03A54 8093C724 848F00B6 */  lh      $t7, 0x00B6($a0)           ## 0000061E
/* 03A58 8093C728 30590003 */  andi    $t9, $v0, 0x0003           ## $t9 = 00000000
/* 03A5C 8093C72C A08E05C0 */  sb      $t6, 0x05C0($a0)           ## 00000B28
/* 03A60 8093C730 25F8D000 */  addiu   $t8, $t7, 0xD000           ## $t8 = FFFFD000
/* 03A64 8093C734 17200014 */  bne     $t9, $zero, .L8093C788     
/* 03A68 8093C738 A49800B6 */  sh      $t8, 0x00B6($a0)           ## 0000061E
/* 03A6C 8093C73C 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 03A70 8093C740 24053921 */  addiu   $a1, $zero, 0x3921         ## $a1 = 00003921
/* 03A74 8093C744 10000011 */  beq     $zero, $zero, .L8093C78C   
/* 03A78 8093C748 8FBF001C */  lw      $ra, 0x001C($sp)           
/* 03A7C 8093C74C 26040568 */  addiu   $a0, $s0, 0x0568           ## $a0 = 00000568
.L8093C750:
/* 03A80 8093C750 0C02927F */  jal     SkelAnime_FrameUpdateMatrix
              
/* 03A84 8093C754 AFA40024 */  sw      $a0, 0x0024($sp)           
/* 03A88 8093C758 260400B6 */  addiu   $a0, $s0, 0x00B6           ## $a0 = 000000B6
/* 03A8C 8093C75C 86050032 */  lh      $a1, 0x0032($s0)           ## 00000032
/* 03A90 8093C760 24060003 */  addiu   $a2, $zero, 0x0003         ## $a2 = 00000003
/* 03A94 8093C764 0C01E1EF */  jal     Math_SmoothScaleMaxS
              
/* 03A98 8093C768 24072000 */  addiu   $a3, $zero, 0x2000         ## $a3 = 00002000
/* 03A9C 8093C76C 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 03AA0 8093C770 0C0295B2 */  jal     SkelAnime_FrameTest              
/* 03AA4 8093C774 8E0501A4 */  lw      $a1, 0x01A4($s0)           ## 000001A4
/* 03AA8 8093C778 10400003 */  beq     $v0, $zero, .L8093C788     
/* 03AAC 8093C77C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 03AB0 8093C780 0C24E82A */  jal     func_8093A0A8              
/* 03AB4 8093C784 8FA5002C */  lw      $a1, 0x002C($sp)           
.L8093C788:
/* 03AB8 8093C788 8FBF001C */  lw      $ra, 0x001C($sp)           
.L8093C78C:
/* 03ABC 8093C78C 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 03AC0 8093C790 27BD0028 */  addiu   $sp, $sp, 0x0028           ## $sp = 00000000
/* 03AC4 8093C794 03E00008 */  jr      $ra                        
/* 03AC8 8093C798 00000000 */  nop
