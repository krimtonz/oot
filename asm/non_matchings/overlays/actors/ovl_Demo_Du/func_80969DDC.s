glabel func_80969DDC
/* 0030C 80969DDC 27BDFFD8 */  addiu   $sp, $sp, 0xFFD8           ## $sp = FFFFFFD8
/* 00310 80969DE0 AFBF0024 */  sw      $ra, 0x0024($sp)
/* 00314 80969DE4 AFA40028 */  sw      $a0, 0x0028($sp)
/* 00318 80969DE8 AFA5002C */  sw      $a1, 0x002C($sp)
/* 0031C 80969DEC AFA60030 */  sw      $a2, 0x0030($sp)
/* 00320 80969DF0 AFA70034 */  sw      $a3, 0x0034($sp)
/* 00324 80969DF4 0C028800 */  jal     Animation_GetLastFrame

/* 00328 80969DF8 00A02025 */  or      $a0, $a1, $zero            ## $a0 = 00000000
/* 0032C 80969DFC 8FAE0038 */  lw      $t6, 0x0038($sp)
/* 00330 80969E00 8FA40028 */  lw      $a0, 0x0028($sp)
/* 00334 80969E04 8FA5002C */  lw      $a1, 0x002C($sp)
/* 00338 80969E08 15C00007 */  bne     $t6, $zero, .L80969E28
/* 0033C 80969E0C 2484014C */  addiu   $a0, $a0, 0x014C           ## $a0 = 0000014C
/* 00340 80969E10 44822000 */  mtc1    $v0, $f4                   ## $f4 = 0.00
/* 00344 80969E14 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 00348 80969E18 44800000 */  mtc1    $zero, $f0                 ## $f0 = 0.00
/* 0034C 80969E1C 44816000 */  mtc1    $at, $f12                  ## $f12 = 1.00
/* 00350 80969E20 10000006 */  beq     $zero, $zero, .L80969E3C
/* 00354 80969E24 468020A0 */  cvt.s.w $f2, $f4
.L80969E28:
/* 00358 80969E28 44823000 */  mtc1    $v0, $f6                   ## $f6 = 0.00
/* 0035C 80969E2C 3C01BF80 */  lui     $at, 0xBF80                ## $at = BF800000
/* 00360 80969E30 44801000 */  mtc1    $zero, $f2                 ## $f2 = 0.00
/* 00364 80969E34 44816000 */  mtc1    $at, $f12                  ## $f12 = -1.00
/* 00368 80969E38 46803020 */  cvt.s.w $f0, $f6
.L80969E3C:
/* 0036C 80969E3C 93AF0033 */  lbu     $t7, 0x0033($sp)
/* 00370 80969E40 C7A80034 */  lwc1    $f8, 0x0034($sp)
/* 00374 80969E44 44066000 */  mfc1    $a2, $f12
/* 00378 80969E48 44070000 */  mfc1    $a3, $f0
/* 0037C 80969E4C E7A20010 */  swc1    $f2, 0x0010($sp)
/* 00380 80969E50 AFAF0014 */  sw      $t7, 0x0014($sp)
/* 00384 80969E54 0C029468 */  jal     Animation_Change

/* 00388 80969E58 E7A80018 */  swc1    $f8, 0x0018($sp)
/* 0038C 80969E5C 8FBF0024 */  lw      $ra, 0x0024($sp)
/* 00390 80969E60 27BD0028 */  addiu   $sp, $sp, 0x0028           ## $sp = 00000000
/* 00394 80969E64 03E00008 */  jr      $ra
/* 00398 80969E68 00000000 */  nop
