glabel Camera_Parallel3
/* AC0B44 800499A4 848E0142 */  lh    $t6, 0x142($a0)
/* AC0B48 800499A8 3C188012 */  lui   $t8, %hi(sCameraSettings)
/* AC0B4C 800499AC 84990144 */  lh    $t9, 0x144($a0)
/* AC0B50 800499B0 000E78C0 */  sll   $t7, $t6, 3
/* AC0B54 800499B4 030FC021 */  addu  $t8, $t8, $t7
/* AC0B58 800499B8 8F18D068 */  lw    $t8, %lo(sCameraSettings+4)($t8)
/* AC0B5C 800499BC 001940C0 */  sll   $t0, $t9, 3
/* AC0B60 800499C0 3C018012 */  lui   $at, %hi(D_8011D3A0) # $at, 0x8012
/* AC0B64 800499C4 03084821 */  addu  $t1, $t8, $t0
/* AC0B68 800499C8 8D220004 */  lw    $v0, 4($t1)
/* AC0B6C 800499CC 84430000 */  lh    $v1, ($v0)
/* AC0B70 800499D0 306A0001 */  andi  $t2, $v1, 1
/* AC0B74 800499D4 11400004 */  beqz  $t2, .L800499E8
/* AC0B78 800499D8 AC23D3A0 */   sw    $v1, %lo(D_8011D3A0)($at)
/* AC0B7C 800499DC 848B014C */  lh    $t3, 0x14c($a0)
/* AC0B80 800499E0 356C0400 */  ori   $t4, $t3, 0x400
/* AC0B84 800499E4 A48C014C */  sh    $t4, 0x14c($a0)
.L800499E8:
/* AC0B88 800499E8 306D0002 */  andi  $t5, $v1, 2
/* AC0B8C 800499EC 11A00004 */  beqz  $t5, .L80049A00
/* AC0B90 800499F0 00000000 */   nop
/* AC0B94 800499F4 848E014C */  lh    $t6, 0x14c($a0)
/* AC0B98 800499F8 35CF0010 */  ori   $t7, $t6, 0x10
/* AC0B9C 800499FC A48F014C */  sh    $t7, 0x14c($a0)
.L80049A00:
/* AC0BA0 80049A00 03E00008 */  jr    $ra
/* AC0BA4 80049A04 00000000 */   nop
