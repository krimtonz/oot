glabel func_809E389C
/* 00D6C 809E389C 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 00D70 809E38A0 AFBF0024 */  sw      $ra, 0x0024($sp)           
/* 00D74 809E38A4 AFB00020 */  sw      $s0, 0x0020($sp)           
/* 00D78 809E38A8 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 00D7C 809E38AC 3C014270 */  lui     $at, 0x4270                ## $at = 42700000
/* 00D80 809E38B0 44813000 */  mtc1    $at, $f6                   ## $f6 = 60.00
/* 00D84 809E38B4 C4840028 */  lwc1    $f4, 0x0028($a0)           ## 00000028
/* 00D88 809E38B8 C4800024 */  lwc1    $f0, 0x0024($a0)           ## 00000024
/* 00D8C 809E38BC C48A002C */  lwc1    $f10, 0x002C($a0)          ## 0000002C
/* 00D90 809E38C0 46062200 */  add.s   $f8, $f4, $f6              
/* 00D94 809E38C4 44808000 */  mtc1    $zero, $f16                ## $f16 = 0.00
/* 00D98 809E38C8 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 00D9C 809E38CC 24840230 */  addiu   $a0, $a0, 0x0230           ## $a0 = 00000230
/* 00DA0 809E38D0 E488FFEC */  swc1    $f8, -0x0014($a0)          ## 0000021C
/* 00DA4 809E38D4 E480FFE8 */  swc1    $f0, -0x0018($a0)          ## 00000218
/* 00DA8 809E38D8 44050000 */  mfc1    $a1, $f0                   
/* 00DAC 809E38DC E48AFFF0 */  swc1    $f10, -0x0010($a0)         ## 00000220
/* 00DB0 809E38E0 AFA40028 */  sw      $a0, 0x0028($sp)           
/* 00DB4 809E38E4 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 00DB8 809E38E8 3C07447A */  lui     $a3, 0x447A                ## $a3 = 447A0000
/* 00DBC 809E38EC 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF
              
/* 00DC0 809E38F0 E7B00010 */  swc1    $f16, 0x0010($sp)          
/* 00DC4 809E38F4 44809000 */  mtc1    $zero, $f18                ## $f18 = 0.00
/* 00DC8 809E38F8 8E05021C */  lw      $a1, 0x021C($s0)           ## 0000021C
/* 00DCC 809E38FC 26040234 */  addiu   $a0, $s0, 0x0234           ## $a0 = 00000234
/* 00DD0 809E3900 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 00DD4 809E3904 3C07447A */  lui     $a3, 0x447A                ## $a3 = 447A0000
/* 00DD8 809E3908 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF
              
/* 00DDC 809E390C E7B20010 */  swc1    $f18, 0x0010($sp)          
/* 00DE0 809E3910 44802000 */  mtc1    $zero, $f4                 ## $f4 = 0.00
/* 00DE4 809E3914 8E050220 */  lw      $a1, 0x0220($s0)           ## 00000220
/* 00DE8 809E3918 26040238 */  addiu   $a0, $s0, 0x0238           ## $a0 = 00000238
/* 00DEC 809E391C 3C063F80 */  lui     $a2, 0x3F80                ## $a2 = 3F800000
/* 00DF0 809E3920 3C07447A */  lui     $a3, 0x447A                ## $a3 = 447A0000
/* 00DF4 809E3924 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF
              
/* 00DF8 809E3928 E7A40010 */  swc1    $f4, 0x0010($sp)           
/* 00DFC 809E392C 8FA40034 */  lw      $a0, 0x0034($sp)           
/* 00E00 809E3930 86050206 */  lh      $a1, 0x0206($s0)           ## 00000206
/* 00E04 809E3934 8FA60028 */  lw      $a2, 0x0028($sp)           
/* 00E08 809E3938 0C030136 */  jal     Gameplay_CameraSetAtEye              
/* 00E0C 809E393C 26070224 */  addiu   $a3, $s0, 0x0224           ## $a3 = 00000224
/* 00E10 809E3940 8FBF0024 */  lw      $ra, 0x0024($sp)           
/* 00E14 809E3944 8FB00020 */  lw      $s0, 0x0020($sp)           
/* 00E18 809E3948 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 00E1C 809E394C 03E00008 */  jr      $ra                        
/* 00E20 809E3950 00000000 */  nop
