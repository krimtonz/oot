glabel func_80918FBC
/* 035AC 80918FBC 27BDFFD8 */  addiu   $sp, $sp, 0xFFD8           ## $sp = FFFFFFD8
/* 035B0 80918FC0 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 035B4 80918FC4 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 035B8 80918FC8 AFBF001C */  sw      $ra, 0x001C($sp)           
/* 035BC 80918FCC 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 035C0 80918FD0 AFA5002C */  sw      $a1, 0x002C($sp)           
/* 035C4 80918FD4 0C02927F */  jal     SkelAnime_FrameUpdateMatrix
              
/* 035C8 80918FD8 AFA40020 */  sw      $a0, 0x0020($sp)           
/* 035CC 80918FDC 3C040600 */  lui     $a0, 0x0600                ## $a0 = 06000000
/* 035D0 80918FE0 0C028800 */  jal     SkelAnime_GetFrameCount
              
/* 035D4 80918FE4 24846E60 */  addiu   $a0, $a0, 0x6E60           ## $a0 = 06006E60
/* 035D8 80918FE8 44822000 */  mtc1    $v0, $f4                   ## $f4 = 0.00
/* 035DC 80918FEC 8FA40020 */  lw      $a0, 0x0020($sp)           
/* 035E0 80918FF0 46802120 */  cvt.s.w $f4, $f4                   
/* 035E4 80918FF4 44052000 */  mfc1    $a1, $f4                   
/* 035E8 80918FF8 0C0295B2 */  jal     SkelAnime_FrameTest              
/* 035EC 80918FFC 00000000 */  nop
/* 035F0 80919000 50400005 */  beql    $v0, $zero, .L80919018     
/* 035F4 80919004 240E0001 */  addiu   $t6, $zero, 0x0001         ## $t6 = 00000001
/* 035F8 80919008 0C24599A */  jal     func_80916668              
/* 035FC 8091900C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 03600 80919010 A6000196 */  sh      $zero, 0x0196($s0)         ## 00000196
/* 03604 80919014 240E0001 */  addiu   $t6, $zero, 0x0001         ## $t6 = 00000001
.L80919018:
/* 03608 80919018 3C053ECC */  lui     $a1, 0x3ECC                ## $a1 = 3ECC0000
/* 0360C 8091901C 3C073E4C */  lui     $a3, 0x3E4C                ## $a3 = 3E4C0000
/* 03610 80919020 A60E01B4 */  sh      $t6, 0x01B4($s0)           ## 000001B4
/* 03614 80919024 34E7CCCD */  ori     $a3, $a3, 0xCCCD           ## $a3 = 3E4CCCCD
/* 03618 80919028 34A5CCCD */  ori     $a1, $a1, 0xCCCD           ## $a1 = 3ECCCCCD
/* 0361C 8091902C 260401F8 */  addiu   $a0, $s0, 0x01F8           ## $a0 = 000001F8
/* 03620 80919030 0C01E107 */  jal     Math_SmoothScaleMaxF
              
/* 03624 80919034 3C063F00 */  lui     $a2, 0x3F00                ## $a2 = 3F000000
/* 03628 80919038 240F0005 */  addiu   $t7, $zero, 0x0005         ## $t7 = 00000005
/* 0362C 8091903C A60F01B8 */  sh      $t7, 0x01B8($s0)           ## 000001B8
/* 03630 80919040 8FBF001C */  lw      $ra, 0x001C($sp)           
/* 03634 80919044 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 03638 80919048 27BD0028 */  addiu   $sp, $sp, 0x0028           ## $sp = 00000000
/* 0363C 8091904C 03E00008 */  jr      $ra                        
/* 03640 80919050 00000000 */  nop
