glabel func_80B32494
/* 00204 80B32494 44800000 */  mtc1    $zero, $f0                 ## $f0 = 0.00
/* 00208 80B32498 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 0020C 80B3249C 3C01C100 */  lui     $at, 0xC100                ## $at = C1000000
/* 00210 80B324A0 44812000 */  mtc1    $at, $f4                   ## $f4 = -8.00
/* 00214 80B324A4 AFB00028 */  sw      $s0, 0x0028($sp)
/* 00218 80B324A8 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 0021C 80B324AC AFBF002C */  sw      $ra, 0x002C($sp)
/* 00220 80B324B0 3C050600 */  lui     $a1, 0x0600                ## $a1 = 06000000
/* 00224 80B324B4 44070000 */  mfc1    $a3, $f0
/* 00228 80B324B8 24A50288 */  addiu   $a1, $a1, 0x0288           ## $a1 = 06000288
/* 0022C 80B324BC 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 00230 80B324C0 AFA00014 */  sw      $zero, 0x0014($sp)
/* 00234 80B324C4 3C064000 */  lui     $a2, 0x4000                ## $a2 = 40000000
/* 00238 80B324C8 E7A00010 */  swc1    $f0, 0x0010($sp)
/* 0023C 80B324CC 0C029468 */  jal     SkelAnime_ChangeAnim

/* 00240 80B324D0 E7A40018 */  swc1    $f4, 0x0018($sp)
/* 00244 80B324D4 920F0294 */  lbu     $t7, 0x0294($s0)           ## 00000294
/* 00248 80B324D8 3C1980B3 */  lui     $t9, %hi(func_80B32D30)    ## $t9 = 80B30000
/* 0024C 80B324DC 240E0028 */  addiu   $t6, $zero, 0x0028         ## $t6 = 00000028
/* 00250 80B324E0 27392D30 */  addiu   $t9, $t9, %lo(func_80B32D30) ## $t9 = 80B32D30
/* 00254 80B324E4 35F80001 */  ori     $t8, $t7, 0x0001           ## $t8 = 00000001
/* 00258 80B324E8 A60E0194 */  sh      $t6, 0x0194($s0)           ## 00000194
/* 0025C 80B324EC A2180294 */  sb      $t8, 0x0294($s0)           ## 00000294
/* 00260 80B324F0 AE190190 */  sw      $t9, 0x0190($s0)           ## 00000190
/* 00264 80B324F4 8FBF002C */  lw      $ra, 0x002C($sp)
/* 00268 80B324F8 8FB00028 */  lw      $s0, 0x0028($sp)
/* 0026C 80B324FC 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 00270 80B32500 03E00008 */  jr      $ra
/* 00274 80B32504 00000000 */  nop


