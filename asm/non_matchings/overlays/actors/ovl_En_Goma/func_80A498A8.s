glabel func_80A498A8
/* 009E8 80A498A8 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 009EC 80A498AC AFB00028 */  sw      $s0, 0x0028($sp)
/* 009F0 80A498B0 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 009F4 80A498B4 AFBF002C */  sw      $ra, 0x002C($sp)
/* 009F8 80A498B8 3C040600 */  lui     $a0, %hi(D_06000544)                ## $a0 = 06000000
/* 009FC 80A498BC AFA50034 */  sw      $a1, 0x0034($sp)
/* 00A00 80A498C0 0C028800 */  jal     SkelAnime_GetFrameCount

/* 00A04 80A498C4 24840544 */  addiu   $a0, $a0, %lo(D_06000544)           ## $a0 = 06000544
/* 00A08 80A498C8 44822000 */  mtc1    $v0, $f4                   ## $f4 = 0.00
/* 00A0C 80A498CC 44800000 */  mtc1    $zero, $f0                 ## $f0 = 0.00
/* 00A10 80A498D0 3C050600 */  lui     $a1, %hi(D_06000544)                ## $a1 = 06000000
/* 00A14 80A498D4 468021A0 */  cvt.s.w $f6, $f4
/* 00A18 80A498D8 240E0002 */  addiu   $t6, $zero, 0x0002         ## $t6 = 00000002
/* 00A1C 80A498DC 44070000 */  mfc1    $a3, $f0
/* 00A20 80A498E0 AFAE0014 */  sw      $t6, 0x0014($sp)
/* 00A24 80A498E4 24A50544 */  addiu   $a1, $a1, %lo(D_06000544)           ## $a1 = 06000544
/* 00A28 80A498E8 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 00A2C 80A498EC E7A60010 */  swc1    $f6, 0x0010($sp)
/* 00A30 80A498F0 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 00A34 80A498F4 0C029468 */  jal     SkelAnime_ChangeAnim

/* 00A38 80A498F8 E7A00018 */  swc1    $f0, 0x0018($sp)
/* 00A3C 80A498FC 3C0F80A5 */  lui     $t7, %hi(func_80A49974)    ## $t7 = 80A50000
/* 00A40 80A49900 25EF9974 */  addiu   $t7, $t7, %lo(func_80A49974) ## $t7 = 80A49974
/* 00A44 80A49904 3C053BA3 */  lui     $a1, 0x3BA3                ## $a1 = 3BA30000
/* 00A48 80A49908 AE0F02B0 */  sw      $t7, 0x02B0($s0)           ## 000002B0
/* 00A4C 80A4990C 34A5D70A */  ori     $a1, $a1, 0xD70A           ## $a1 = 3BA3D70A
/* 00A50 80A49910 0C00B58B */  jal     Actor_SetScale

/* 00A54 80A49914 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 00A58 80A49918 24180005 */  addiu   $t8, $zero, 0x0005         ## $t8 = 00000005
/* 00A5C 80A4991C A60002B8 */  sh      $zero, 0x02B8($s0)         ## 000002B8
/* 00A60 80A49920 A61802CC */  sh      $t8, 0x02CC($s0)           ## 000002CC
/* 00A64 80A49924 8FB90034 */  lw      $t9, 0x0034($sp)
/* 00A68 80A49928 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 00A6C 80A4992C 0C00B69E */  jal     func_8002DA78
/* 00A70 80A49930 8F251C44 */  lw      $a1, 0x1C44($t9)           ## 00001C44
/* 00A74 80A49934 A60200B6 */  sh      $v0, 0x00B6($s0)           ## 000000B6
/* 00A78 80A49938 860800B6 */  lh      $t0, 0x00B6($s0)           ## 000000B6
/* 00A7C 80A4993C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 00A80 80A49940 A6080032 */  sh      $t0, 0x0032($s0)           ## 00000032
/* 00A84 80A49944 0C292CFC */  jal     func_80A4B3F0
/* 00A88 80A49948 8FA50034 */  lw      $a1, 0x0034($sp)
/* 00A8C 80A4994C 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 00A90 80A49950 44814000 */  mtc1    $at, $f8                   ## $f8 = 1.00
/* 00A94 80A49954 44805000 */  mtc1    $zero, $f10                ## $f10 = 0.00
/* 00A98 80A49958 E60802D0 */  swc1    $f8, 0x02D0($s0)           ## 000002D0
/* 00A9C 80A4995C E60A0068 */  swc1    $f10, 0x0068($s0)          ## 00000068
/* 00AA0 80A49960 8FBF002C */  lw      $ra, 0x002C($sp)
/* 00AA4 80A49964 8FB00028 */  lw      $s0, 0x0028($sp)
/* 00AA8 80A49968 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 00AAC 80A4996C 03E00008 */  jr      $ra
/* 00AB0 80A49970 00000000 */  nop
