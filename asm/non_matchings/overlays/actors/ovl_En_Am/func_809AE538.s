glabel func_809AE538
/* 00618 809AE538 27BDFFE8 */  addiu   $sp, $sp, 0xFFE8           ## $sp = FFFFFFE8
/* 0061C 809AE53C AFBF0014 */  sw      $ra, 0x0014($sp)
/* 00620 809AE540 00803825 */  or      $a3, $a0, $zero            ## $a3 = 00000000
/* 00624 809AE544 3C050600 */  lui     $a1, 0x0600                ## $a1 = 06000000
/* 00628 809AE548 24A50238 */  addiu   $a1, $a1, 0x0238           ## $a1 = 06000238
/* 0062C 809AE54C AFA70018 */  sw      $a3, 0x0018($sp)
/* 00630 809AE550 24840164 */  addiu   $a0, $a0, 0x0164           ## $a0 = 00000164
/* 00634 809AE554 0C0294E1 */  jal     SkelAnime_ChangeAnimPlaybackRepeat
/* 00638 809AE558 3C064080 */  lui     $a2, 0x4080                ## $a2 = 40800000
/* 0063C 809AE55C 8FA40018 */  lw      $a0, 0x0018($sp)
/* 00640 809AE560 44802000 */  mtc1    $zero, $f4                 ## $f4 = 0.00
/* 00644 809AE564 240E0003 */  addiu   $t6, $zero, 0x0003         ## $t6 = 00000003
/* 00648 809AE568 849800B6 */  lh      $t8, 0x00B6($a0)           ## 000000B6
/* 0064C 809AE56C 240F000A */  addiu   $t7, $zero, 0x000A         ## $t7 = 0000000A
/* 00650 809AE570 3C05809B */  lui     $a1, %hi(func_809AF0DC)    ## $a1 = 809B0000
/* 00654 809AE574 24A5F0DC */  addiu   $a1, $a1, %lo(func_809AF0DC) ## $a1 = 809AF0DC
/* 00658 809AE578 A48E0258 */  sh      $t6, 0x0258($a0)           ## 00000258
/* 0065C 809AE57C AC8F01A8 */  sw      $t7, 0x01A8($a0)           ## 000001A8
/* 00660 809AE580 E4840068 */  swc1    $f4, 0x0068($a0)           ## 00000068
/* 00664 809AE584 0C26B7C8 */  jal     func_809ADF20
/* 00668 809AE588 A4980032 */  sh      $t8, 0x0032($a0)           ## 00000032
/* 0066C 809AE58C 8FBF0014 */  lw      $ra, 0x0014($sp)
/* 00670 809AE590 27BD0018 */  addiu   $sp, $sp, 0x0018           ## $sp = 00000000
/* 00674 809AE594 03E00008 */  jr      $ra
/* 00678 809AE598 00000000 */  nop


