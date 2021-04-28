glabel func_8086318C
/* 03B3C 8086318C 27BDFFE0 */  addiu   $sp, $sp, 0xFFE0           ## $sp = FFFFFFE0
/* 03B40 80863190 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 03B44 80863194 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 03B48 80863198 AFBF001C */  sw      $ra, 0x001C($sp)           
/* 03B4C 8086319C AFA50024 */  sw      $a1, 0x0024($sp)           
/* 03B50 808631A0 0C02927F */  jal     SkelAnime_Update
              
/* 03B54 808631A4 24840188 */  addiu   $a0, $a0, 0x0188           ## $a0 = 00000188
/* 03B58 808631A8 50400015 */  beql    $v0, $zero, .L80863200     
/* 03B5C 808631AC C60A01A0 */  lwc1    $f10, 0x01A0($s0)          ## 000001A0
/* 03B60 808631B0 0C03F66B */  jal     Rand_ZeroOne
              ## Rand.Next() float
/* 03B64 808631B4 00000000 */  nop
/* 03B68 808631B8 3C014120 */  lui     $at, 0x4120                ## $at = 41200000
/* 03B6C 808631BC 44811000 */  mtc1    $at, $f2                   ## $f2 = 10.00
/* 03B70 808631C0 24180007 */  addiu   $t8, $zero, 0x0007         ## $t8 = 00000007
/* 03B74 808631C4 3C058086 */  lui     $a1, %hi(func_808633E8)    ## $a1 = 80860000
/* 03B78 808631C8 46020102 */  mul.s   $f4, $f0, $f2              
/* 03B7C 808631CC A21807C8 */  sb      $t8, 0x07C8($s0)           ## 000007C8
/* 03B80 808631D0 24A533E8 */  addiu   $a1, $a1, %lo(func_808633E8) ## $a1 = 808633E8
/* 03B84 808631D4 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 03B88 808631D8 46022180 */  add.s   $f6, $f4, $f2              
/* 03B8C 808631DC 4600320D */  trunc.w.s $f8, $f6                   
/* 03B90 808631E0 440F4000 */  mfc1    $t7, $f8                   
/* 03B94 808631E4 0C217D94 */  jal     EnTest_SetupAction              
/* 03B98 808631E8 AE0F07E8 */  sw      $t7, 0x07E8($s0)           ## 000007E8
/* 03B9C 808631EC 260407F0 */  addiu   $a0, $s0, 0x07F0           ## $a0 = 000007F0
/* 03BA0 808631F0 2405003C */  addiu   $a1, $zero, 0x003C         ## $a1 = 0000003C
/* 03BA4 808631F4 0C00CB89 */  jal     BodyBreak_Alloc              
/* 03BA8 808631F8 8FA60024 */  lw      $a2, 0x0024($sp)           
/* 03BAC 808631FC C60A01A0 */  lwc1    $f10, 0x01A0($s0)          ## 000001A0
.L80863200:
/* 03BB0 80863200 2401000A */  addiu   $at, $zero, 0x000A         ## $at = 0000000A
/* 03BB4 80863204 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 03BB8 80863208 4600540D */  trunc.w.s $f16, $f10                 
/* 03BBC 8086320C 44028000 */  mfc1    $v0, $f16                  
/* 03BC0 80863210 00000000 */  nop
/* 03BC4 80863214 10410003 */  beq     $v0, $at, .L80863224       
/* 03BC8 80863218 24010019 */  addiu   $at, $zero, 0x0019         ## $at = 00000019
/* 03BCC 8086321C 54410004 */  bnel    $v0, $at, .L80863230       
/* 03BD0 80863220 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80863224:
/* 03BD4 80863224 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 03BD8 80863228 2405387A */  addiu   $a1, $zero, 0x387A         ## $a1 = 0000387A
/* 03BDC 8086322C 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80863230:
/* 03BE0 80863230 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 03BE4 80863234 27BD0020 */  addiu   $sp, $sp, 0x0020           ## $sp = 00000000
/* 03BE8 80863238 03E00008 */  jr      $ra                        
/* 03BEC 8086323C 00000000 */  nop
