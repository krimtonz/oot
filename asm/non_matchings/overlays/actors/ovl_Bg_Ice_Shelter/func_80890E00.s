.late_rodata
glabel D_808918DC
 .word 0x3D8F5C29
glabel D_808918E0
 .word 0x3E0F5C29
glabel D_808918E4
    .float 0.2

glabel D_808918E8
    .float 0.8

.text
glabel func_80890E00
/* 006C0 80890E00 27BDFF28 */  addiu   $sp, $sp, 0xFF28           ## $sp = FFFFFF28
/* 006C4 80890E04 F7BC0048 */  sdc1    $f28, 0x0048($sp)          
/* 006C8 80890E08 3C014220 */  lui     $at, 0x4220                ## $at = 42200000
/* 006CC 80890E0C 4481E000 */  mtc1    $at, $f28                  ## $f28 = 40.00
/* 006D0 80890E10 F7BA0040 */  sdc1    $f26, 0x0040($sp)          
/* 006D4 80890E14 3C018089 */  lui     $at, %hi(D_808918DC)       ## $at = 80890000
/* 006D8 80890E18 F7B80038 */  sdc1    $f24, 0x0038($sp)          
/* 006DC 80890E1C C43A18DC */  lwc1    $f26, %lo(D_808918DC)($at) 
/* 006E0 80890E20 AFBF007C */  sw      $ra, 0x007C($sp)           
/* 006E4 80890E24 AFBE0078 */  sw      $s8, 0x0078($sp)           
/* 006E8 80890E28 AFB70074 */  sw      $s7, 0x0074($sp)           
/* 006EC 80890E2C AFB60070 */  sw      $s6, 0x0070($sp)           
/* 006F0 80890E30 AFB5006C */  sw      $s5, 0x006C($sp)           
/* 006F4 80890E34 AFB40068 */  sw      $s4, 0x0068($sp)           
/* 006F8 80890E38 AFB30064 */  sw      $s3, 0x0064($sp)           
/* 006FC 80890E3C AFB20060 */  sw      $s2, 0x0060($sp)           
/* 00700 80890E40 AFB1005C */  sw      $s1, 0x005C($sp)           
/* 00704 80890E44 AFB00058 */  sw      $s0, 0x0058($sp)           
/* 00708 80890E48 F7BE0050 */  sdc1    $f30, 0x0050($sp)          
/* 0070C 80890E4C F7B60030 */  sdc1    $f22, 0x0030($sp)          
/* 00710 80890E50 F7B40028 */  sdc1    $f20, 0x0028($sp)          
/* 00714 80890E54 AFA700E4 */  sw      $a3, 0x00E4($sp)           
/* 00718 80890E58 3C018089 */  lui     $at, %hi(D_808918E0)       ## $at = 80890000
/* 0071C 80890E5C 84B6009E */  lh      $s6, 0x009E($a1)           ## 0000009E
/* 00720 80890E60 C43818E0 */  lwc1    $f24, %lo(D_808918E0)($at) 
/* 00724 80890E64 3C013FC0 */  lui     $at, 0x3FC0                ## $at = 3FC00000
/* 00728 80890E68 4481B000 */  mtc1    $at, $f22                  ## $f22 = 1.50
/* 0072C 80890E6C 3C014040 */  lui     $at, 0x4040                ## $at = 40400000
/* 00730 80890E70 32D60007 */  andi    $s6, $s6, 0x0007           ## $s6 = 00000000
/* 00734 80890E74 0016B400 */  sll     $s6, $s6, 16               
/* 00738 80890E78 4486F000 */  mtc1    $a2, $f30                  ## $f30 = 0.00
/* 0073C 80890E7C 4481A000 */  mtc1    $at, $f20                  ## $f20 = 3.00
/* 00740 80890E80 0080A825 */  or      $s5, $a0, $zero            ## $s5 = 00000000
/* 00744 80890E84 00A0B825 */  or      $s7, $a1, $zero            ## $s7 = 00000000
/* 00748 80890E88 0016B403 */  sra     $s6, $s6, 16               
/* 0074C 80890E8C 00009825 */  or      $s3, $zero, $zero          ## $s3 = 00000000
/* 00750 80890E90 27B400BC */  addiu   $s4, $sp, 0x00BC           ## $s4 = FFFFFFE4
/* 00754 80890E94 241E0002 */  addiu   $s8, $zero, 0x0002         ## $s8 = 00000002
.L80890E98:
/* 00758 80890E98 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 0075C 80890E9C 00000000 */  nop
/* 00760 80890EA0 4600F03C */  c.lt.s  $f30, $f0                  
/* 00764 80890EA4 3C0F8089 */  lui     $t7, %hi(D_808917B4)       ## $t7 = 80890000
/* 00768 80890EA8 25EF17B4 */  addiu   $t7, $t7, %lo(D_808917B4)  ## $t7 = 808917B4
/* 0076C 80890EAC 26B00024 */  addiu   $s0, $s5, 0x0024           ## $s0 = 00000024
/* 00770 80890EB0 45010057 */  bc1t    .L80891010                 
/* 00774 80890EB4 00137080 */  sll     $t6, $s3,  2               
/* 00778 80890EB8 3C198089 */  lui     $t9, %hi(D_808917A4)       ## $t9 = 80890000
/* 0077C 80890EBC 273917A4 */  addiu   $t9, $t9, %lo(D_808917A4)  ## $t9 = 808917A4
/* 00780 80890EC0 0016C040 */  sll     $t8, $s6,  1               
/* 00784 80890EC4 03199021 */  addu    $s2, $t8, $t9              
/* 00788 80890EC8 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 0078C 80890ECC 01CF8821 */  addu    $s1, $t6, $t7              
/* 00790 80890ED0 3C014140 */  lui     $at, 0x4140                ## $at = 41400000
/* 00794 80890ED4 44812000 */  mtc1    $at, $f4                   ## $f4 = 12.00
/* 00798 80890ED8 86480000 */  lh      $t0, 0x0000($s2)           ## 00000000
/* 0079C 80890EDC 3C0140C0 */  lui     $at, 0x40C0                ## $at = 40C00000
/* 007A0 80890EE0 46040182 */  mul.s   $f6, $f0, $f4              
/* 007A4 80890EE4 44888000 */  mtc1    $t0, $f16                  ## $f16 = 0.00
/* 007A8 80890EE8 44814000 */  mtc1    $at, $f8                   ## $f8 = 6.00
/* 007AC 80890EEC 3C014170 */  lui     $at, 0x4170                ## $at = 41700000
/* 007B0 80890EF0 468084A0 */  cvt.s.w $f18, $f16                 
/* 007B4 80890EF4 44818000 */  mtc1    $at, $f16                  ## $f16 = 15.00
/* 007B8 80890EF8 00000000 */  nop
/* 007BC 80890EFC E7B0009C */  swc1    $f16, 0x009C($sp)          
/* 007C0 80890F00 46083281 */  sub.s   $f10, $f6, $f8             
/* 007C4 80890F04 C6260000 */  lwc1    $f6, 0x0000($s1)           ## 00000000
/* 007C8 80890F08 460A9100 */  add.s   $f4, $f18, $f10            
/* 007CC 80890F0C 46043202 */  mul.s   $f8, $f6, $f4              
/* 007D0 80890F10 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 007D4 80890F14 E7A80098 */  swc1    $f8, 0x0098($sp)           
/* 007D8 80890F18 3C0142A8 */  lui     $at, 0x42A8                ## $at = 42A80000
/* 007DC 80890F1C 44819000 */  mtc1    $at, $f18                  ## $f18 = 84.00
/* 007E0 80890F20 C7AA0098 */  lwc1    $f10, 0x0098($sp)          
/* 007E4 80890F24 3C018089 */  lui     $at, %hi(D_808918E4)       ## $at = 80890000
/* 007E8 80890F28 C42418E4 */  lwc1    $f4, %lo(D_808918E4)($at)  
/* 007EC 80890F2C 460A9181 */  sub.s   $f6, $f18, $f10            
/* 007F0 80890F30 3C0141A0 */  lui     $at, 0x41A0                ## $at = 41A00000
/* 007F4 80890F34 44818000 */  mtc1    $at, $f16                  ## $f16 = 20.00
/* 007F8 80890F38 02802025 */  or      $a0, $s4, $zero            ## $a0 = FFFFFFE4
/* 007FC 80890F3C 46043202 */  mul.s   $f8, $f6, $f4              
/* 00800 80890F40 27A50098 */  addiu   $a1, $sp, 0x0098           ## $a1 = FFFFFFC0
/* 00804 80890F44 46100482 */  mul.s   $f18, $f0, $f16            
/* 00808 80890F48 46089280 */  add.s   $f10, $f18, $f8            
/* 0080C 80890F4C E7AA00A0 */  swc1    $f10, 0x00A0($sp)          
/* 00810 80890F50 0C22423F */  jal     func_808908FC              
/* 00814 80890F54 86A60032 */  lh      $a2, 0x0032($s5)           ## 00000032
/* 00818 80890F58 02802025 */  or      $a0, $s4, $zero            ## $a0 = FFFFFFE4
/* 0081C 80890F5C 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000024
/* 00820 80890F60 0C01DFA7 */  jal     Math_Vec3f_Sum
              ## Vec3f_Add
/* 00824 80890F64 02803025 */  or      $a2, $s4, $zero            ## $a2 = FFFFFFE4
/* 00828 80890F68 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 0082C 80890F6C 00000000 */  nop
/* 00830 80890F70 46140182 */  mul.s   $f6, $f0, $f20             
/* 00834 80890F74 44808000 */  mtc1    $zero, $f16                ## $f16 = 0.00
/* 00838 80890F78 00000000 */  nop
/* 0083C 80890F7C E7B000B4 */  swc1    $f16, 0x00B4($sp)          
/* 00840 80890F80 46163101 */  sub.s   $f4, $f6, $f22             
/* 00844 80890F84 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00848 80890F88 E7A400B0 */  swc1    $f4, 0x00B0($sp)           
/* 0084C 80890F8C 46140482 */  mul.s   $f18, $f0, $f20            
/* 00850 80890F90 46169201 */  sub.s   $f8, $f18, $f22            
/* 00854 80890F94 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00858 80890F98 E7A800B8 */  swc1    $f8, 0x00B8($sp)           
/* 0085C 80890F9C 46180282 */  mul.s   $f10, $f0, $f24            
/* 00860 80890FA0 3C018089 */  lui     $at, %hi(D_808918E8)       ## $at = 80890000
/* 00864 80890FA4 C42418E8 */  lwc1    $f4, %lo(D_808918E8)($at)  
/* 00868 80890FA8 E7A400A8 */  swc1    $f4, 0x00A8($sp)           
/* 0086C 80890FAC 461A5181 */  sub.s   $f6, $f10, $f26            
/* 00870 80890FB0 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00874 80890FB4 E7A600A4 */  swc1    $f6, 0x00A4($sp)           
/* 00878 80890FB8 46180402 */  mul.s   $f16, $f0, $f24            
/* 0087C 80890FBC 461A8481 */  sub.s   $f18, $f16, $f26           
/* 00880 80890FC0 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00884 80890FC4 E7B200AC */  swc1    $f18, 0x00AC($sp)          
/* 00888 80890FC8 461C0202 */  mul.s   $f8, $f0, $f28             
/* 0088C 80890FCC 3C098089 */  lui     $t1, %hi(D_80891704)       ## $t1 = 80890000
/* 00890 80890FD0 3C0A8089 */  lui     $t2, %hi(D_80891708)       ## $t2 = 80890000
/* 00894 80890FD4 254A1708 */  addiu   $t2, $t2, %lo(D_80891708)  ## $t2 = 80891708
/* 00898 80890FD8 25291704 */  addiu   $t1, $t1, %lo(D_80891704)  ## $t1 = 80891704
/* 0089C 80890FDC 240B01C2 */  addiu   $t3, $zero, 0x01C2         ## $t3 = 000001C2
/* 008A0 80890FE0 AFAB0018 */  sw      $t3, 0x0018($sp)           
/* 008A4 80890FE4 461C4280 */  add.s   $f10, $f8, $f28            
/* 008A8 80890FE8 AFA90010 */  sw      $t1, 0x0010($sp)           
/* 008AC 80890FEC AFAA0014 */  sw      $t2, 0x0014($sp)           
/* 008B0 80890FF0 02E02025 */  or      $a0, $s7, $zero            ## $a0 = 00000000
/* 008B4 80890FF4 4600518D */  trunc.w.s $f6, $f10                  
/* 008B8 80890FF8 02802825 */  or      $a1, $s4, $zero            ## $a1 = FFFFFFE4
/* 008BC 80890FFC 27A600B0 */  addiu   $a2, $sp, 0x00B0           ## $a2 = FFFFFFD8
/* 008C0 80891000 27A700A4 */  addiu   $a3, $sp, 0x00A4           ## $a3 = FFFFFFCC
/* 008C4 80891004 440D3000 */  mfc1    $t5, $f6                   
/* 008C8 80891008 0C00A0A7 */  jal     func_8002829C              
/* 008CC 8089100C AFAD001C */  sw      $t5, 0x001C($sp)           
.L80891010:
/* 008D0 80891010 26730001 */  addiu   $s3, $s3, 0x0001           ## $s3 = 00000001
/* 008D4 80891014 167EFFA0 */  bne     $s3, $s8, .L80890E98       
/* 008D8 80891018 00000000 */  nop
/* 008DC 8089101C 8FBF007C */  lw      $ra, 0x007C($sp)           
/* 008E0 80891020 D7B40028 */  ldc1    $f20, 0x0028($sp)          
/* 008E4 80891024 D7B60030 */  ldc1    $f22, 0x0030($sp)          
/* 008E8 80891028 D7B80038 */  ldc1    $f24, 0x0038($sp)          
/* 008EC 8089102C D7BA0040 */  ldc1    $f26, 0x0040($sp)          
/* 008F0 80891030 D7BC0048 */  ldc1    $f28, 0x0048($sp)          
/* 008F4 80891034 D7BE0050 */  ldc1    $f30, 0x0050($sp)          
/* 008F8 80891038 8FB00058 */  lw      $s0, 0x0058($sp)           
/* 008FC 8089103C 8FB1005C */  lw      $s1, 0x005C($sp)           
/* 00900 80891040 8FB20060 */  lw      $s2, 0x0060($sp)           
/* 00904 80891044 8FB30064 */  lw      $s3, 0x0064($sp)           
/* 00908 80891048 8FB40068 */  lw      $s4, 0x0068($sp)           
/* 0090C 8089104C 8FB5006C */  lw      $s5, 0x006C($sp)           
/* 00910 80891050 8FB60070 */  lw      $s6, 0x0070($sp)           
/* 00914 80891054 8FB70074 */  lw      $s7, 0x0074($sp)           
/* 00918 80891058 8FBE0078 */  lw      $s8, 0x0078($sp)           
/* 0091C 8089105C 03E00008 */  jr      $ra                        
/* 00920 80891060 27BD00D8 */  addiu   $sp, $sp, 0x00D8           ## $sp = 00000000
