glabel func_80A0E578
/* 000C8 80A0E578 AFA50004 */  sw      $a1, 0x0004($sp)           
/* 000CC 80A0E57C 8C8F014C */  lw      $t7, 0x014C($a0)           ## 0000014C
/* 000D0 80A0E580 3C0E80A1 */  lui     $t6, %hi(func_80A0EA34)    ## $t6 = 80A10000
/* 000D4 80A0E584 25CEEA34 */  addiu   $t6, $t6, %lo(func_80A0EA34) ## $t6 = 80A0EA34
/* 000D8 80A0E588 55CF0004 */  bnel    $t6, $t7, .L80A0E59C       
/* 000DC 80A0E58C 90830161 */  lbu     $v1, 0x0161($a0)           ## 00000161
/* 000E0 80A0E590 03E00008 */  jr      $ra                        
/* 000E4 80A0E594 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80A0E598:
/* 000E8 80A0E598 90830161 */  lbu     $v1, 0x0161($a0)           ## 00000161
.L80A0E59C:
/* 000EC 80A0E59C 24020001 */  addiu   $v0, $zero, 0x0001         ## $v0 = 00000001
/* 000F0 80A0E5A0 30780002 */  andi    $t8, $v1, 0x0002           ## $t8 = 00000000
/* 000F4 80A0E5A4 13000003 */  beq     $t8, $zero, .L80A0E5B4     
/* 000F8 80A0E5A8 3079FFFD */  andi    $t9, $v1, 0xFFFD           ## $t9 = 00000000
/* 000FC 80A0E5AC 03E00008 */  jr      $ra                        
/* 00100 80A0E5B0 A0990161 */  sb      $t9, 0x0161($a0)           ## 00000161
.L80A0E5B4:
/* 00104 80A0E5B4 90830163 */  lbu     $v1, 0x0163($a0)           ## 00000163
/* 00108 80A0E5B8 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
/* 0010C 80A0E5BC 30680001 */  andi    $t0, $v1, 0x0001           ## $t0 = 00000000
/* 00110 80A0E5C0 11000004 */  beq     $t0, $zero, .L80A0E5D4     
/* 00114 80A0E5C4 3069FFFE */  andi    $t1, $v1, 0xFFFE           ## $t1 = 00000000
/* 00118 80A0E5C8 A0890163 */  sb      $t1, 0x0163($a0)           ## 00000163
/* 0011C 80A0E5CC 03E00008 */  jr      $ra                        
/* 00120 80A0E5D0 24020001 */  addiu   $v0, $zero, 0x0001         ## $v0 = 00000001
.L80A0E5D4:
/* 00124 80A0E5D4 03E00008 */  jr      $ra                        
/* 00128 80A0E5D8 00000000 */  nop
