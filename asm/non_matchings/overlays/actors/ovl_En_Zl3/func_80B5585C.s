glabel func_80B5585C
/* 024AC 80B5585C 27BDFFE8 */  addiu   $sp, $sp, 0xFFE8           ## $sp = FFFFFFE8
/* 024B0 80B55860 AFBF0014 */  sw      $ra, 0x0014($sp)           
/* 024B4 80B55864 908E014D */  lbu     $t6, 0x014D($a0)           ## 0000014D
/* 024B8 80B55868 00803025 */  or      $a2, $a0, $zero            ## $a2 = 00000000
/* 024BC 80B5586C 24010002 */  addiu   $at, $zero, 0x0002         ## $at = 00000002
/* 024C0 80B55870 15C10009 */  bne     $t6, $at, .L80B55898       
/* 024C4 80B55874 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 024C8 80B55878 3C054080 */  lui     $a1, 0x4080                ## $a1 = 40800000
/* 024CC 80B5587C 0C0295B2 */  jal     SkelAnime_FrameTest              
/* 024D0 80B55880 AFA60018 */  sw      $a2, 0x0018($sp)           
/* 024D4 80B55884 10400004 */  beq     $v0, $zero, .L80B55898     
/* 024D8 80B55888 8FA60018 */  lw      $a2, 0x0018($sp)           
/* 024DC 80B5588C 24C400E4 */  addiu   $a0, $a2, 0x00E4           ## $a0 = 000000E4
/* 024E0 80B55890 0C01E245 */  jal     func_80078914              
/* 024E4 80B55894 24056879 */  addiu   $a1, $zero, 0x6879         ## $a1 = 00006879
.L80B55898:
/* 024E8 80B55898 8FBF0014 */  lw      $ra, 0x0014($sp)           
/* 024EC 80B5589C 27BD0018 */  addiu   $sp, $sp, 0x0018           ## $sp = 00000000
/* 024F0 80B558A0 03E00008 */  jr      $ra                        
/* 024F4 80B558A4 00000000 */  nop
