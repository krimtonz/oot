glabel func_8005A8C4
/* AD1A64 8005A8C4 3C0E8012 */  lui   $t6, %hi(gDbgCamEnabled) # $t6, 0x8012
/* AD1A68 8005A8C8 8DCED394 */  lw    $t6, %lo(gDbgCamEnabled)($t6)
/* AD1A6C 8005A8CC 3C0F8016 */  lui   $t7, %hi(D_8015CE46) # $t7, 0x8016
/* AD1A70 8005A8D0 25EFCE46 */  addiu $t7, %lo(D_8015CE46) # addiu $t7, $t7, -0x31ba
/* AD1A74 8005A8D4 51C0000A */  beql  $t6, $zero, .L8005A900
/* AD1A78 8005A8D8 88A90134 */   lwl   $t1, 0x134($a1)
/* AD1A7C 8005A8DC 89F90000 */  lwl   $t9, ($t7)
/* AD1A80 8005A8E0 99F90003 */  lwr   $t9, 3($t7)
/* AD1A84 8005A8E4 00801025 */  move  $v0, $a0
/* AD1A88 8005A8E8 A8990000 */  swl   $t9, ($a0)
/* AD1A8C 8005A8EC B8990003 */  swr   $t9, 3($a0)
/* AD1A90 8005A8F0 95F90004 */  lhu   $t9, 4($t7)
/* AD1A94 8005A8F4 03E00008 */  jr    $ra
/* AD1A98 8005A8F8 A4990004 */   sh    $t9, 4($a0)

/* AD1A9C 8005A8FC 88A90134 */  lwl   $t1, 0x134($a1)
.L8005A900:
/* AD1AA0 8005A900 98A90137 */  lwr   $t1, 0x137($a1)
/* AD1AA4 8005A904 00801025 */  move  $v0, $a0
/* AD1AA8 8005A908 A8890000 */  swl   $t1, ($a0)
/* AD1AAC 8005A90C B8890003 */  swr   $t1, 3($a0)
/* AD1AB0 8005A910 94A90138 */  lhu   $t1, 0x138($a1)
/* AD1AB4 8005A914 A4890004 */  sh    $t1, 4($a0)
/* AD1AB8 8005A918 03E00008 */  jr    $ra
/* AD1ABC 8005A91C 00000000 */   nop

/* AD1AC0 8005A920 27BDFFE0 */  addiu $sp, $sp, -0x20
/* AD1AC4 8005A924 AFBF0014 */  sw    $ra, 0x14($sp)
/* AD1AC8 8005A928 00802825 */  move  $a1, $a0
/* AD1ACC 8005A92C 0C016A31 */  jal   func_8005A8C4
/* AD1AD0 8005A930 27A40018 */   addiu $a0, $sp, 0x18
/* AD1AD4 8005A934 8FBF0014 */  lw    $ra, 0x14($sp)
/* AD1AD8 8005A938 87A20018 */  lh    $v0, 0x18($sp)
/* AD1ADC 8005A93C 27BD0020 */  addiu $sp, $sp, 0x20
/* AD1AE0 8005A940 03E00008 */  jr    $ra
/* AD1AE4 8005A944 00000000 */   nop

