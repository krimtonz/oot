glabel func_8005A970
/* AD1B10 8005A970 3C0E8012 */  lui   $t6, %hi(gDbgCamEnabled) # $t6, 0x8012
/* AD1B14 8005A974 8DCED394 */  lw    $t6, %lo(gDbgCamEnabled)($t6)
/* AD1B18 8005A978 3C0F8016 */  lui   $t7, %hi(D_8015CE46) # $t7, 0x8016
/* AD1B1C 8005A97C 25EFCE46 */  addiu $t7, %lo(D_8015CE46) # addiu $t7, $t7, -0x31ba
/* AD1B20 8005A980 51C0000A */  beql  $t6, $zero, .L8005A9AC
/* AD1B24 8005A984 88A9013A */   lwl   $t1, 0x13a($a1)
/* AD1B28 8005A988 89F90000 */  lwl   $t9, ($t7)
/* AD1B2C 8005A98C 99F90003 */  lwr   $t9, 3($t7)
/* AD1B30 8005A990 00801025 */  move  $v0, $a0
/* AD1B34 8005A994 A8990000 */  swl   $t9, ($a0)
/* AD1B38 8005A998 B8990003 */  swr   $t9, 3($a0)
/* AD1B3C 8005A99C 95F90004 */  lhu   $t9, 4($t7)
/* AD1B40 8005A9A0 03E00008 */  jr    $ra
/* AD1B44 8005A9A4 A4990004 */   sh    $t9, 4($a0)

/* AD1B48 8005A9A8 88A9013A */  lwl   $t1, 0x13a($a1)
.L8005A9AC:
/* AD1B4C 8005A9AC 98A9013D */  lwr   $t1, 0x13d($a1)
/* AD1B50 8005A9B0 00801025 */  move  $v0, $a0
/* AD1B54 8005A9B4 A8890000 */  swl   $t1, ($a0)
/* AD1B58 8005A9B8 B8890003 */  swr   $t1, 3($a0)
/* AD1B5C 8005A9BC 94A9013E */  lhu   $t1, 0x13e($a1)
/* AD1B60 8005A9C0 A4890004 */  sh    $t1, 4($a0)
/* AD1B64 8005A9C4 03E00008 */  jr    $ra
/* AD1B68 8005A9C8 00000000 */   nop

