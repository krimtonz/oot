glabel func_80B152D0
/* 01830 80B152D0 AFA50004 */  sw      $a1, 0x0004($sp)           
/* 01834 80B152D4 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 01838 80B152D8 00001825 */  or      $v1, $zero, $zero          ## $v1 = 00000000
/* 0183C 80B152DC 00803025 */  or      $a2, $a0, $zero            ## $a2 = 00000000
/* 01840 80B152E0 2402000C */  addiu   $v0, $zero, 0x000C         ## $v0 = 0000000C
.L80B152E4:
/* 01844 80B152E4 8CCE02B8 */  lw      $t6, 0x02B8($a2)           ## 000002B8
/* 01848 80B152E8 24A50004 */  addiu   $a1, $a1, 0x0004           ## $a1 = 00000004
/* 0184C 80B152EC 11C00002 */  beq     $t6, $zero, .L80B152F8     
/* 01850 80B152F0 00000000 */  nop
/* 01854 80B152F4 24630001 */  addiu   $v1, $v1, 0x0001           ## $v1 = 00000001
.L80B152F8:
/* 01858 80B152F8 14A2FFFA */  bne     $a1, $v0, .L80B152E4       
/* 0185C 80B152FC 24C60004 */  addiu   $a2, $a2, 0x0004           ## $a2 = 00000004
/* 01860 80B15300 03E00008 */  jr      $ra                        
/* 01864 80B15304 00601025 */  or      $v0, $v1, $zero            ## $v0 = 00000001
