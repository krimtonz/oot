.rdata
glabel D_80B88B5C
    .asciz "../z_magic_dark.c"
    .balign 4

glabel D_80B88B70
    .asciz "../z_magic_dark.c"
    .balign 4

glabel D_80B88B84
    .asciz "../z_magic_dark.c"
    .balign 4

glabel D_80B88B98
    .asciz "../z_magic_dark.c"
    .balign 4

.late_rodata
glabel D_80B88BFC
    .float 1.4

glabel D_80B88C00
 .word 0x3DC90FDB
glabel D_80B88C04
 .word 0x3DC90FDB, 0x00000000, 0x00000000

.text
glabel MagicDark_Draw
/* 008EC 80B87CBC 27BDFF78 */  addiu   $sp, $sp, 0xFF78           ## $sp = FFFFFF78
/* 008F0 80B87CC0 AFBF0024 */  sw      $ra, 0x0024($sp)           
/* 008F4 80B87CC4 AFB20020 */  sw      $s2, 0x0020($sp)           
/* 008F8 80B87CC8 AFB1001C */  sw      $s1, 0x001C($sp)           
/* 008FC 80B87CCC AFB00018 */  sw      $s0, 0x0018($sp)           
/* 00900 80B87CD0 8CAE009C */  lw      $t6, 0x009C($a1)           ## 0000009C
/* 00904 80B87CD4 00808825 */  or      $s1, $a0, $zero            ## $s1 = 00000000
/* 00908 80B87CD8 00A09025 */  or      $s2, $a1, $zero            ## $s2 = 00000000
/* 0090C 80B87CDC 31CF001F */  andi    $t7, $t6, 0x001F           ## $t7 = 00000000
/* 00910 80B87CE0 448F2000 */  mtc1    $t7, $f4                   ## $f4 = 0.00
/* 00914 80B87CE4 8CA21C44 */  lw      $v0, 0x1C44($a1)           ## 00001C44
/* 00918 80B87CE8 05E10005 */  bgez    $t7, .L80B87D00            
/* 0091C 80B87CEC 468021A0 */  cvt.s.w $f6, $f4                   
/* 00920 80B87CF0 3C014F80 */  lui     $at, 0x4F80                ## $at = 4F800000
/* 00924 80B87CF4 44814000 */  mtc1    $at, $f8                   ## $f8 = 4294967296.00
/* 00928 80B87CF8 00000000 */  nop
/* 0092C 80B87CFC 46083180 */  add.s   $f6, $f6, $f8              
.L80B87D00:
/* 00930 80B87D00 E7A6006C */  swc1    $f6, 0x006C($sp)           
/* 00934 80B87D04 8623014C */  lh      $v1, 0x014C($s1)           ## 0000014C
/* 00938 80B87D08 28610020 */  slti    $at, $v1, 0x0020           
/* 0093C 80B87D0C 50200026 */  beql    $at, $zero, .L80B87DA8     
/* 00940 80B87D10 28610082 */  slti    $at, $v1, 0x0082           
/* 00944 80B87D14 C44A09BC */  lwc1    $f10, 0x09BC($v0)          ## 000009BC
/* 00948 80B87D18 C4500998 */  lwc1    $f16, 0x0998($v0)          ## 00000998
/* 0094C 80B87D1C 3C013F00 */  lui     $at, 0x3F00                ## $at = 3F000000
/* 00950 80B87D20 44810000 */  mtc1    $at, $f0                   ## $f0 = 0.50
/* 00954 80B87D24 46105480 */  add.s   $f18, $f10, $f16           
/* 00958 80B87D28 27B90078 */  addiu   $t9, $sp, 0x0078           ## $t9 = FFFFFFF0
/* 0095C 80B87D2C 46009102 */  mul.s   $f4, $f18, $f0             
/* 00960 80B87D30 E7A40078 */  swc1    $f4, 0x0078($sp)           
/* 00964 80B87D34 C446099C */  lwc1    $f6, 0x099C($v0)           ## 0000099C
/* 00968 80B87D38 C44809C0 */  lwc1    $f8, 0x09C0($v0)           ## 000009C0
/* 0096C 80B87D3C 46064280 */  add.s   $f10, $f8, $f6             
/* 00970 80B87D40 46005402 */  mul.s   $f16, $f10, $f0            
/* 00974 80B87D44 E7B0007C */  swc1    $f16, 0x007C($sp)          
/* 00978 80B87D48 C44409A0 */  lwc1    $f4, 0x09A0($v0)           ## 000009A0
/* 0097C 80B87D4C C45209C4 */  lwc1    $f18, 0x09C4($v0)          ## 000009C4
/* 00980 80B87D50 46049200 */  add.s   $f8, $f18, $f4             
/* 00984 80B87D54 46004182 */  mul.s   $f6, $f8, $f0              
/* 00988 80B87D58 E7A60080 */  swc1    $f6, 0x0080($sp)           
/* 0098C 80B87D5C 8623014C */  lh      $v1, 0x014C($s1)           ## 0000014C
/* 00990 80B87D60 28610015 */  slti    $at, $v1, 0x0015           
/* 00994 80B87D64 14200008 */  bne     $at, $zero, .L80B87D88     
/* 00998 80B87D68 2478FFEC */  addiu   $t8, $v1, 0xFFEC           ## $t8 = FFFFFFEC
/* 0099C 80B87D6C 44985000 */  mtc1    $t8, $f10                  ## $f10 = NaN
/* 009A0 80B87D70 3C0180B9 */  lui     $at, %hi(D_80B88BFC)       ## $at = 80B90000
/* 009A4 80B87D74 C4248BFC */  lwc1    $f4, %lo(D_80B88BFC)($at)  
/* 009A8 80B87D78 468054A0 */  cvt.s.w $f18, $f10                 
/* 009AC 80B87D7C 46049202 */  mul.s   $f8, $f18, $f4             
/* 009B0 80B87D80 46088180 */  add.s   $f6, $f16, $f8             
/* 009B4 80B87D84 E7A6007C */  swc1    $f6, 0x007C($sp)           
.L80B87D88:
/* 009B8 80B87D88 8F290000 */  lw      $t1, 0x0000($t9)           ## FFFFFFF0
/* 009BC 80B87D8C AE290150 */  sw      $t1, 0x0150($s1)           ## 00000150
/* 009C0 80B87D90 8F280004 */  lw      $t0, 0x0004($t9)           ## FFFFFFF4
/* 009C4 80B87D94 AE280154 */  sw      $t0, 0x0154($s1)           ## 00000154
/* 009C8 80B87D98 8F290008 */  lw      $t1, 0x0008($t9)           ## FFFFFFF8
/* 009CC 80B87D9C 1000000B */  beq     $zero, $zero, .L80B87DCC   
/* 009D0 80B87DA0 AE290158 */  sw      $t1, 0x0158($s1)           ## 00000158
/* 009D4 80B87DA4 28610082 */  slti    $at, $v1, 0x0082           
.L80B87DA8:
/* 009D8 80B87DA8 502000BD */  beql    $at, $zero, .L80B880A0     
/* 009DC 80B87DAC 8FBF0024 */  lw      $ra, 0x0024($sp)           
/* 009E0 80B87DB0 8E2C0150 */  lw      $t4, 0x0150($s1)           ## 00000150
/* 009E4 80B87DB4 27AA0078 */  addiu   $t2, $sp, 0x0078           ## $t2 = FFFFFFF0
/* 009E8 80B87DB8 AD4C0000 */  sw      $t4, 0x0000($t2)           ## FFFFFFF0
/* 009EC 80B87DBC 8E2B0154 */  lw      $t3, 0x0154($s1)           ## 00000154
/* 009F0 80B87DC0 AD4B0004 */  sw      $t3, 0x0004($t2)           ## FFFFFFF4
/* 009F4 80B87DC4 8E2C0158 */  lw      $t4, 0x0158($s1)           ## 00000158
/* 009F8 80B87DC8 AD4C0008 */  sw      $t4, 0x0008($t2)           ## FFFFFFF8
.L80B87DCC:
/* 009FC 80B87DCC 864D07A0 */  lh      $t5, 0x07A0($s2)           ## 000007A0
/* 00A00 80B87DD0 000D7080 */  sll     $t6, $t5,  2               
/* 00A04 80B87DD4 024E7821 */  addu    $t7, $s2, $t6              
/* 00A08 80B87DD8 0C016A73 */  jal     Camera_GetCamDirPitch              
/* 00A0C 80B87DDC 8DE40790 */  lw      $a0, 0x0790($t7)           ## 00000790
/* 00A10 80B87DE0 00022400 */  sll     $a0, $v0, 16               
/* 00A14 80B87DE4 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 00A18 80B87DE8 00042403 */  sra     $a0, $a0, 16               
/* 00A1C 80B87DEC E7A00034 */  swc1    $f0, 0x0034($sp)           
/* 00A20 80B87DF0 865807A0 */  lh      $t8, 0x07A0($s2)           ## 000007A0
/* 00A24 80B87DF4 0018C880 */  sll     $t9, $t8,  2               
/* 00A28 80B87DF8 02594021 */  addu    $t0, $s2, $t9              
/* 00A2C 80B87DFC 0C016A7D */  jal     Camera_GetCamDirYaw              
/* 00A30 80B87E00 8D040790 */  lw      $a0, 0x0790($t0)           ## 00000790
/* 00A34 80B87E04 00022400 */  sll     $a0, $v0, 16               
/* 00A38 80B87E08 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 00A3C 80B87E0C 00042403 */  sra     $a0, $a0, 16               
/* 00A40 80B87E10 3C014396 */  lui     $at, 0x4396                ## $at = 43960000
/* 00A44 80B87E14 44819000 */  mtc1    $at, $f18                  ## $f18 = 300.00
/* 00A48 80B87E18 C62A0050 */  lwc1    $f10, 0x0050($s1)          ## 00000050
/* 00A4C 80B87E1C C7A80034 */  lwc1    $f8, 0x0034($sp)           
/* 00A50 80B87E20 46125102 */  mul.s   $f4, $f10, $f18            
/* 00A54 80B87E24 C7AA0078 */  lwc1    $f10, 0x0078($sp)          
/* 00A58 80B87E28 46002402 */  mul.s   $f16, $f4, $f0             
/* 00A5C 80B87E2C 00000000 */  nop
/* 00A60 80B87E30 46088182 */  mul.s   $f6, $f16, $f8             
/* 00A64 80B87E34 46065481 */  sub.s   $f18, $f10, $f6            
/* 00A68 80B87E38 E7B20078 */  swc1    $f18, 0x0078($sp)          
/* 00A6C 80B87E3C 864907A0 */  lh      $t1, 0x07A0($s2)           ## 000007A0
/* 00A70 80B87E40 00095080 */  sll     $t2, $t1,  2               
/* 00A74 80B87E44 024A5821 */  addu    $t3, $s2, $t2              
/* 00A78 80B87E48 0C016A73 */  jal     Camera_GetCamDirPitch              
/* 00A7C 80B87E4C 8D640790 */  lw      $a0, 0x0790($t3)           ## 00000790
/* 00A80 80B87E50 00022400 */  sll     $a0, $v0, 16               
/* 00A84 80B87E54 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 00A88 80B87E58 00042403 */  sra     $a0, $a0, 16               
/* 00A8C 80B87E5C 3C014396 */  lui     $at, 0x4396                ## $at = 43960000
/* 00A90 80B87E60 44818000 */  mtc1    $at, $f16                  ## $f16 = 300.00
/* 00A94 80B87E64 C6240050 */  lwc1    $f4, 0x0050($s1)           ## 00000050
/* 00A98 80B87E68 C7A6007C */  lwc1    $f6, 0x007C($sp)           
/* 00A9C 80B87E6C 46102202 */  mul.s   $f8, $f4, $f16             
/* 00AA0 80B87E70 00000000 */  nop
/* 00AA4 80B87E74 46004282 */  mul.s   $f10, $f8, $f0             
/* 00AA8 80B87E78 460A3481 */  sub.s   $f18, $f6, $f10            
/* 00AAC 80B87E7C E7B2007C */  swc1    $f18, 0x007C($sp)          
/* 00AB0 80B87E80 864C07A0 */  lh      $t4, 0x07A0($s2)           ## 000007A0
/* 00AB4 80B87E84 000C6880 */  sll     $t5, $t4,  2               
/* 00AB8 80B87E88 024D7021 */  addu    $t6, $s2, $t5              
/* 00ABC 80B87E8C 0C016A73 */  jal     Camera_GetCamDirPitch              
/* 00AC0 80B87E90 8DC40790 */  lw      $a0, 0x0790($t6)           ## 00000790
/* 00AC4 80B87E94 00022400 */  sll     $a0, $v0, 16               
/* 00AC8 80B87E98 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 00ACC 80B87E9C 00042403 */  sra     $a0, $a0, 16               
/* 00AD0 80B87EA0 E7A00034 */  swc1    $f0, 0x0034($sp)           
/* 00AD4 80B87EA4 864F07A0 */  lh      $t7, 0x07A0($s2)           ## 000007A0
/* 00AD8 80B87EA8 000FC080 */  sll     $t8, $t7,  2               
/* 00ADC 80B87EAC 0258C821 */  addu    $t9, $s2, $t8              
/* 00AE0 80B87EB0 0C016A7D */  jal     Camera_GetCamDirYaw              
/* 00AE4 80B87EB4 8F240790 */  lw      $a0, 0x0790($t9)           ## 00000790
/* 00AE8 80B87EB8 00022400 */  sll     $a0, $v0, 16               
/* 00AEC 80B87EBC 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 00AF0 80B87EC0 00042403 */  sra     $a0, $a0, 16               
/* 00AF4 80B87EC4 3C014396 */  lui     $at, 0x4396                ## $at = 43960000
/* 00AF8 80B87EC8 44818000 */  mtc1    $at, $f16                  ## $f16 = 300.00
/* 00AFC 80B87ECC C6240050 */  lwc1    $f4, 0x0050($s1)           ## 00000050
/* 00B00 80B87ED0 C7AA0034 */  lwc1    $f10, 0x0034($sp)          
/* 00B04 80B87ED4 3C0680B9 */  lui     $a2, %hi(D_80B88B5C)       ## $a2 = 80B90000
/* 00B08 80B87ED8 46102202 */  mul.s   $f8, $f4, $f16             
/* 00B0C 80B87EDC C7A40080 */  lwc1    $f4, 0x0080($sp)           
/* 00B10 80B87EE0 24C68B5C */  addiu   $a2, $a2, %lo(D_80B88B5C)  ## $a2 = 80B88B5C
/* 00B14 80B87EE4 27A40058 */  addiu   $a0, $sp, 0x0058           ## $a0 = FFFFFFD0
/* 00B18 80B87EE8 2407026B */  addiu   $a3, $zero, 0x026B         ## $a3 = 0000026B
/* 00B1C 80B87EEC 46004182 */  mul.s   $f6, $f8, $f0              
/* 00B20 80B87EF0 00000000 */  nop
/* 00B24 80B87EF4 460A3482 */  mul.s   $f18, $f6, $f10            
/* 00B28 80B87EF8 46122401 */  sub.s   $f16, $f4, $f18            
/* 00B2C 80B87EFC E7B00080 */  swc1    $f16, 0x0080($sp)          
/* 00B30 80B87F00 8E450000 */  lw      $a1, 0x0000($s2)           ## 00000000
/* 00B34 80B87F04 0C031AB1 */  jal     Graph_OpenDisps              
/* 00B38 80B87F08 00A08025 */  or      $s0, $a1, $zero            ## $s0 = 00000000
/* 00B3C 80B87F0C 0C024F61 */  jal     func_80093D84              
/* 00B40 80B87F10 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 00B44 80B87F14 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00B48 80B87F18 3C09FA00 */  lui     $t1, 0xFA00                ## $t1 = FA000000
/* 00B4C 80B87F1C 3C0AAAFF */  lui     $t2, 0xAAFF                ## $t2 = AAFF0000
/* 00B50 80B87F20 24480008 */  addiu   $t0, $v0, 0x0008           ## $t0 = 00000008
/* 00B54 80B87F24 AE0802D0 */  sw      $t0, 0x02D0($s0)           ## 000002D0
/* 00B58 80B87F28 354AFFFF */  ori     $t2, $t2, 0xFFFF           ## $t2 = AAFFFFFF
/* 00B5C 80B87F2C 35290080 */  ori     $t1, $t1, 0x0080           ## $t1 = FA000080
/* 00B60 80B87F30 AC490000 */  sw      $t1, 0x0000($v0)           ## 00000000
/* 00B64 80B87F34 AC4A0004 */  sw      $t2, 0x0004($v0)           ## 00000004
/* 00B68 80B87F38 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00B6C 80B87F3C 3C0D0096 */  lui     $t5, 0x0096                ## $t5 = 00960000
/* 00B70 80B87F40 35ADFFFF */  ori     $t5, $t5, 0xFFFF           ## $t5 = 0096FFFF
/* 00B74 80B87F44 244B0008 */  addiu   $t3, $v0, 0x0008           ## $t3 = 00000008
/* 00B78 80B87F48 AE0B02D0 */  sw      $t3, 0x02D0($s0)           ## 000002D0
/* 00B7C 80B87F4C 3C0CFB00 */  lui     $t4, 0xFB00                ## $t4 = FB000000
/* 00B80 80B87F50 AC4C0000 */  sw      $t4, 0x0000($v0)           ## 00000000
/* 00B84 80B87F54 AC4D0004 */  sw      $t5, 0x0004($v0)           ## 00000004
/* 00B88 80B87F58 8FA60080 */  lw      $a2, 0x0080($sp)           
/* 00B8C 80B87F5C C7AE007C */  lwc1    $f14, 0x007C($sp)          
/* 00B90 80B87F60 C7AC0078 */  lwc1    $f12, 0x0078($sp)          
/* 00B94 80B87F64 0C034261 */  jal     Matrix_Translate              
/* 00B98 80B87F68 00003825 */  or      $a3, $zero, $zero          ## $a3 = 00000000
/* 00B9C 80B87F6C C62C0050 */  lwc1    $f12, 0x0050($s1)          ## 00000050
/* 00BA0 80B87F70 C62E0054 */  lwc1    $f14, 0x0054($s1)          ## 00000054
/* 00BA4 80B87F74 8E260058 */  lw      $a2, 0x0058($s1)           ## 00000058
/* 00BA8 80B87F78 0C0342A3 */  jal     Matrix_Scale              
/* 00BAC 80B87F7C 24070001 */  addiu   $a3, $zero, 0x0001         ## $a3 = 00000001
/* 00BB0 80B87F80 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 00BB4 80B87F84 34211DA0 */  ori     $at, $at, 0x1DA0           ## $at = 00011DA0
/* 00BB8 80B87F88 02412021 */  addu    $a0, $s2, $at              
/* 00BBC 80B87F8C 0C03424C */  jal     Matrix_Mult              
/* 00BC0 80B87F90 24050001 */  addiu   $a1, $zero, 0x0001         ## $a1 = 00000001
/* 00BC4 80B87F94 0C034213 */  jal     Matrix_Push              
/* 00BC8 80B87F98 00000000 */  nop
/* 00BCC 80B87F9C 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00BD0 80B87FA0 3C0FDA38 */  lui     $t7, 0xDA38                ## $t7 = DA380000
/* 00BD4 80B87FA4 35EF0003 */  ori     $t7, $t7, 0x0003           ## $t7 = DA380003
/* 00BD8 80B87FA8 244E0008 */  addiu   $t6, $v0, 0x0008           ## $t6 = 00000008
/* 00BDC 80B87FAC AE0E02D0 */  sw      $t6, 0x02D0($s0)           ## 000002D0
/* 00BE0 80B87FB0 3C0580B9 */  lui     $a1, %hi(D_80B88B70)       ## $a1 = 80B90000
/* 00BE4 80B87FB4 AC4F0000 */  sw      $t7, 0x0000($v0)           ## 00000000
/* 00BE8 80B87FB8 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 00BEC 80B87FBC 24A58B70 */  addiu   $a1, $a1, %lo(D_80B88B70)  ## $a1 = 80B88B70
/* 00BF0 80B87FC0 24060278 */  addiu   $a2, $zero, 0x0278         ## $a2 = 00000278
/* 00BF4 80B87FC4 0C0346A2 */  jal     Matrix_NewMtx              
/* 00BF8 80B87FC8 00408825 */  or      $s1, $v0, $zero            ## $s1 = 00000000
/* 00BFC 80B87FCC AE220004 */  sw      $v0, 0x0004($s1)           ## 00000004
/* 00C00 80B87FD0 3C0180B9 */  lui     $at, %hi(D_80B88C00)       ## $at = 80B90000
/* 00C04 80B87FD4 C4268C00 */  lwc1    $f6, %lo(D_80B88C00)($at)  
/* 00C08 80B87FD8 C7A8006C */  lwc1    $f8, 0x006C($sp)           
/* 00C0C 80B87FDC 24050001 */  addiu   $a1, $zero, 0x0001         ## $a1 = 00000001
/* 00C10 80B87FE0 46064302 */  mul.s   $f12, $f8, $f6             
/* 00C14 80B87FE4 0C0343B5 */  jal     Matrix_RotateZ              
/* 00C18 80B87FE8 00000000 */  nop
/* 00C1C 80B87FEC 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00C20 80B87FF0 3C040401 */  lui     $a0, 0x0401                ## $a0 = 04010000
/* 00C24 80B87FF4 24840130 */  addiu   $a0, $a0, 0x0130           ## $a0 = 04010130
/* 00C28 80B87FF8 24580008 */  addiu   $t8, $v0, 0x0008           ## $t8 = 00000008
/* 00C2C 80B87FFC AE1802D0 */  sw      $t8, 0x02D0($s0)           ## 000002D0
/* 00C30 80B88000 3C19DE00 */  lui     $t9, 0xDE00                ## $t9 = DE000000
/* 00C34 80B88004 AC590000 */  sw      $t9, 0x0000($v0)           ## 00000000
/* 00C38 80B88008 AC440004 */  sw      $a0, 0x0004($v0)           ## 00000004
/* 00C3C 80B8800C 0C034221 */  jal     Matrix_Pull              
/* 00C40 80B88010 AFA4002C */  sw      $a0, 0x002C($sp)           
/* 00C44 80B88014 C7AA006C */  lwc1    $f10, 0x006C($sp)          
/* 00C48 80B88018 3C0180B9 */  lui     $at, %hi(D_80B88C04)       ## $at = 80B90000
/* 00C4C 80B8801C C4328C04 */  lwc1    $f18, %lo(D_80B88C04)($at) 
/* 00C50 80B88020 46005107 */  neg.s   $f4, $f10                  
/* 00C54 80B88024 24050001 */  addiu   $a1, $zero, 0x0001         ## $a1 = 00000001
/* 00C58 80B88028 46122302 */  mul.s   $f12, $f4, $f18            
/* 00C5C 80B8802C 0C0343B5 */  jal     Matrix_RotateZ              
/* 00C60 80B88030 00000000 */  nop
/* 00C64 80B88034 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00C68 80B88038 3C09DA38 */  lui     $t1, 0xDA38                ## $t1 = DA380000
/* 00C6C 80B8803C 35290003 */  ori     $t1, $t1, 0x0003           ## $t1 = DA380003
/* 00C70 80B88040 24480008 */  addiu   $t0, $v0, 0x0008           ## $t0 = 00000008
/* 00C74 80B88044 AE0802D0 */  sw      $t0, 0x02D0($s0)           ## 000002D0
/* 00C78 80B88048 3C0580B9 */  lui     $a1, %hi(D_80B88B84)       ## $a1 = 80B90000
/* 00C7C 80B8804C AC490000 */  sw      $t1, 0x0000($v0)           ## 00000000
/* 00C80 80B88050 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 00C84 80B88054 24A58B84 */  addiu   $a1, $a1, %lo(D_80B88B84)  ## $a1 = 80B88B84
/* 00C88 80B88058 2406027F */  addiu   $a2, $zero, 0x027F         ## $a2 = 0000027F
/* 00C8C 80B8805C 0C0346A2 */  jal     Matrix_NewMtx              
/* 00C90 80B88060 00408825 */  or      $s1, $v0, $zero            ## $s1 = 00000000
/* 00C94 80B88064 AE220004 */  sw      $v0, 0x0004($s1)           ## 00000004
/* 00C98 80B88068 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00C9C 80B8806C 3C0BDE00 */  lui     $t3, 0xDE00                ## $t3 = DE000000
/* 00CA0 80B88070 3C0680B9 */  lui     $a2, %hi(D_80B88B98)       ## $a2 = 80B90000
/* 00CA4 80B88074 244A0008 */  addiu   $t2, $v0, 0x0008           ## $t2 = 00000008
/* 00CA8 80B88078 AE0A02D0 */  sw      $t2, 0x02D0($s0)           ## 000002D0
/* 00CAC 80B8807C AC4B0000 */  sw      $t3, 0x0000($v0)           ## 00000000
/* 00CB0 80B88080 8FAC002C */  lw      $t4, 0x002C($sp)           
/* 00CB4 80B88084 24C68B98 */  addiu   $a2, $a2, %lo(D_80B88B98)  ## $a2 = 80B88B98
/* 00CB8 80B88088 27A40058 */  addiu   $a0, $sp, 0x0058           ## $a0 = FFFFFFD0
/* 00CBC 80B8808C AC4C0004 */  sw      $t4, 0x0004($v0)           ## 00000004
/* 00CC0 80B88090 8E450000 */  lw      $a1, 0x0000($s2)           ## 00000000
/* 00CC4 80B88094 0C031AD5 */  jal     Graph_CloseDisps              
/* 00CC8 80B88098 24070283 */  addiu   $a3, $zero, 0x0283         ## $a3 = 00000283
/* 00CCC 80B8809C 8FBF0024 */  lw      $ra, 0x0024($sp)           
.L80B880A0:
/* 00CD0 80B880A0 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 00CD4 80B880A4 8FB1001C */  lw      $s1, 0x001C($sp)           
/* 00CD8 80B880A8 8FB20020 */  lw      $s2, 0x0020($sp)           
/* 00CDC 80B880AC 03E00008 */  jr      $ra                        
/* 00CE0 80B880B0 27BD0088 */  addiu   $sp, $sp, 0x0088           ## $sp = 00000000
/* 00CE4 80B880B4 00000000 */  nop
/* 00CE8 80B880B8 00000000 */  nop
/* 00CEC 80B880BC 00000000 */  nop
