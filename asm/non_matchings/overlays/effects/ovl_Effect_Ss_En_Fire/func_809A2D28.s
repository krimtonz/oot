.rdata
glabel D_809A3260
    .asciz "../z_eff_en_fire.c"
    .balign 4

glabel D_809A3274
    .asciz "../z_eff_en_fire.c"
    .balign 4

glabel D_809A3288
    .asciz "../z_eff_en_fire.c"
    .balign 4

.late_rodata
glabel D_809A329C
    .float 9.58738019108e-05

glabel D_809A32A0
    .float 0.00005

glabel D_809A32A4
    .float 12.7

.text
glabel func_809A2D28
/* 001C8 809A2D28 27BDFF68 */  addiu   $sp, $sp, 0xFF68           ## $sp = FFFFFF68
/* 001CC 809A2D2C AFB10038 */  sw      $s1, 0x0038($sp)           
/* 001D0 809A2D30 AFBF003C */  sw      $ra, 0x003C($sp)           
/* 001D4 809A2D34 AFB00034 */  sw      $s0, 0x0034($sp)           
/* 001D8 809A2D38 AFA40098 */  sw      $a0, 0x0098($sp)           
/* 001DC 809A2D3C AFA5009C */  sw      $a1, 0x009C($sp)           
/* 001E0 809A2D40 8C900000 */  lw      $s0, 0x0000($a0)           ## 00000000
/* 001E4 809A2D44 00C08825 */  or      $s1, $a2, $zero            ## $s1 = 00000000
/* 001E8 809A2D48 3C06809A */  lui     $a2, %hi(D_809A3260)       ## $a2 = 809A0000
/* 001EC 809A2D4C 24C63260 */  addiu   $a2, $a2, %lo(D_809A3260)  ## $a2 = 809A3260
/* 001F0 809A2D50 27A40068 */  addiu   $a0, $sp, 0x0068           ## $a0 = FFFFFFD0
/* 001F4 809A2D54 240700A9 */  addiu   $a3, $zero, 0x00A9         ## $a3 = 000000A9
/* 001F8 809A2D58 0C031AB1 */  jal     Graph_OpenDisps              
/* 001FC 809A2D5C 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 00200 809A2D60 C62C0000 */  lwc1    $f12, 0x0000($s1)          ## 00000000
/* 00204 809A2D64 C62E0004 */  lwc1    $f14, 0x0004($s1)          ## 00000004
/* 00208 809A2D68 8E260008 */  lw      $a2, 0x0008($s1)           ## 00000008
/* 0020C 809A2D6C 0C034261 */  jal     Matrix_Translate              
/* 00210 809A2D70 00003825 */  or      $a3, $zero, $zero          ## $a3 = 00000000
/* 00214 809A2D74 8FA20098 */  lw      $v0, 0x0098($sp)           
/* 00218 809A2D78 844F07A0 */  lh      $t7, 0x07A0($v0)           ## 000007A0
/* 0021C 809A2D7C 000FC080 */  sll     $t8, $t7,  2               
/* 00220 809A2D80 0058C821 */  addu    $t9, $v0, $t8              
/* 00224 809A2D84 0C016A7D */  jal     Camera_GetCamDirYaw              
/* 00228 809A2D88 8F240790 */  lw      $a0, 0x0790($t9)           ## 00000790
/* 0022C 809A2D8C 34018000 */  ori     $at, $zero, 0x8000         ## $at = 00008000
/* 00230 809A2D90 00414021 */  addu    $t0, $v0, $at              
/* 00234 809A2D94 00084C00 */  sll     $t1, $t0, 16               
/* 00238 809A2D98 00095403 */  sra     $t2, $t1, 16               
/* 0023C 809A2D9C 448A2000 */  mtc1    $t2, $f4                   ## $f4 = 0.00
/* 00240 809A2DA0 3C01809A */  lui     $at, %hi(D_809A329C)       ## $at = 809A0000
/* 00244 809A2DA4 C428329C */  lwc1    $f8, %lo(D_809A329C)($at)  
/* 00248 809A2DA8 468021A0 */  cvt.s.w $f6, $f4                   
/* 0024C 809A2DAC 24050001 */  addiu   $a1, $zero, 0x0001         ## $a1 = 00000001
/* 00250 809A2DB0 46083302 */  mul.s   $f12, $f6, $f8             
/* 00254 809A2DB4 0C034348 */  jal     Matrix_RotateY              
/* 00258 809A2DB8 00000000 */  nop
/* 0025C 809A2DBC 8624005C */  lh      $a0, 0x005C($s1)           ## 0000005C
/* 00260 809A2DC0 24010333 */  addiu   $at, $zero, 0x0333         ## $at = 00000333
/* 00264 809A2DC4 00810019 */  multu   $a0, $at                   
/* 00268 809A2DC8 00002012 */  mflo    $a0                        
/* 0026C 809A2DCC 00042400 */  sll     $a0, $a0, 16               
/* 00270 809A2DD0 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 00274 809A2DD4 00042403 */  sra     $a0, $a0, 16               
/* 00278 809A2DD8 862B0042 */  lh      $t3, 0x0042($s1)           ## 00000042
/* 0027C 809A2DDC 3C01809A */  lui     $at, %hi(D_809A32A0)       ## $at = 809A0000
/* 00280 809A2DE0 C43232A0 */  lwc1    $f18, %lo(D_809A32A0)($at) 
/* 00284 809A2DE4 448B5000 */  mtc1    $t3, $f10                  ## $f10 = 0.00
/* 00288 809A2DE8 24070001 */  addiu   $a3, $zero, 0x0001         ## $a3 = 00000001
/* 0028C 809A2DEC 46805420 */  cvt.s.w $f16, $f10                 
/* 00290 809A2DF0 46128102 */  mul.s   $f4, $f16, $f18            
/* 00294 809A2DF4 00000000 */  nop
/* 00298 809A2DF8 46002302 */  mul.s   $f12, $f4, $f0             
/* 0029C 809A2DFC 44066000 */  mfc1    $a2, $f12                  
/* 002A0 809A2E00 0C0342A3 */  jal     Matrix_Scale              
/* 002A4 809A2E04 46006386 */  mov.s   $f14, $f12                 
/* 002A8 809A2E08 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 002AC 809A2E0C 3C0DDA38 */  lui     $t5, 0xDA38                ## $t5 = DA380000
/* 002B0 809A2E10 35AD0003 */  ori     $t5, $t5, 0x0003           ## $t5 = DA380003
/* 002B4 809A2E14 244C0008 */  addiu   $t4, $v0, 0x0008           ## $t4 = 00000008
/* 002B8 809A2E18 AE0C02D0 */  sw      $t4, 0x02D0($s0)           ## 000002D0
/* 002BC 809A2E1C AC4D0000 */  sw      $t5, 0x0000($v0)           ## 00000000
/* 002C0 809A2E20 8FAE0098 */  lw      $t6, 0x0098($sp)           
/* 002C4 809A2E24 3C05809A */  lui     $a1, %hi(D_809A3274)       ## $a1 = 809A0000
/* 002C8 809A2E28 24A53274 */  addiu   $a1, $a1, %lo(D_809A3274)  ## $a1 = 809A3274
/* 002CC 809A2E2C 8DC40000 */  lw      $a0, 0x0000($t6)           ## 00000000
/* 002D0 809A2E30 240600B4 */  addiu   $a2, $zero, 0x00B4         ## $a2 = 000000B4
/* 002D4 809A2E34 0C0346A2 */  jal     Matrix_NewMtx              
/* 002D8 809A2E38 AFA20064 */  sw      $v0, 0x0064($sp)           
/* 002DC 809A2E3C 8FA30064 */  lw      $v1, 0x0064($sp)           
/* 002E0 809A2E40 AC620004 */  sw      $v0, 0x0004($v1)           ## 00000004
/* 002E4 809A2E44 8625005C */  lh      $a1, 0x005C($s1)           ## 0000005C
/* 002E8 809A2E48 8FAF0098 */  lw      $t7, 0x0098($sp)           
/* 002EC 809A2E4C 24A5FFFB */  addiu   $a1, $a1, 0xFFFB           ## $a1 = FFFFFFFB
/* 002F0 809A2E50 00052C00 */  sll     $a1, $a1, 16               
/* 002F4 809A2E54 00052C03 */  sra     $a1, $a1, 16               
/* 002F8 809A2E58 04A30003 */  bgezl   $a1, .L809A2E68            
/* 002FC 809A2E5C 8DE40000 */  lw      $a0, 0x0000($t7)           ## 00000000
/* 00300 809A2E60 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 00304 809A2E64 8DE40000 */  lw      $a0, 0x0000($t7)           ## 00000000
.L809A2E68:
/* 00308 809A2E68 0C024F61 */  jal     func_80093D84              
/* 0030C 809A2E6C A7A5007E */  sh      $a1, 0x007E($sp)           
/* 00310 809A2E70 87A5007E */  lh      $a1, 0x007E($sp)           
/* 00314 809A2E74 8E0302D0 */  lw      $v1, 0x02D0($s0)           ## 000002D0
/* 00318 809A2E78 3C19FB00 */  lui     $t9, 0xFB00                ## $t9 = FB000000
/* 0031C 809A2E7C 44853000 */  mtc1    $a1, $f6                   ## $f6 = 0.00
/* 00320 809A2E80 24780008 */  addiu   $t8, $v1, 0x0008           ## $t8 = 00000008
/* 00324 809A2E84 AE1802D0 */  sw      $t8, 0x02D0($s0)           ## 000002D0
/* 00328 809A2E88 46803220 */  cvt.s.w $f8, $f6                   
/* 0032C 809A2E8C 3C01809A */  lui     $at, %hi(D_809A32A4)       ## $at = 809A0000
/* 00330 809A2E90 AC790000 */  sw      $t9, 0x0000($v1)           ## 00000000
/* 00334 809A2E94 C42A32A4 */  lwc1    $f10, %lo(D_809A32A4)($at) 
/* 00338 809A2E98 24040001 */  addiu   $a0, $zero, 0x0001         ## $a0 = 00000001
/* 0033C 809A2E9C 3C0AFA00 */  lui     $t2, 0xFA00                ## $t2 = FA000000
/* 00340 809A2EA0 460A4402 */  mul.s   $f16, $f8, $f10            
/* 00344 809A2EA4 3C0FDB06 */  lui     $t7, 0xDB06                ## $t7 = DB060000
/* 00348 809A2EA8 3C014F00 */  lui     $at, 0x4F00                ## $at = 4F000000
/* 0034C 809A2EAC 354A0080 */  ori     $t2, $t2, 0x0080           ## $t2 = FA000080
/* 00350 809A2EB0 35EF0020 */  ori     $t7, $t7, 0x0020           ## $t7 = DB060020
/* 00354 809A2EB4 24190020 */  addiu   $t9, $zero, 0x0020         ## $t9 = 00000020
/* 00358 809A2EB8 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 0035C 809A2EBC 4448F800 */  cfc1    $t0, $31
/* 00360 809A2EC0 44C4F800 */  ctc1    $a0, $31
/* 00364 809A2EC4 00003825 */  or      $a3, $zero, $zero          ## $a3 = 00000000
/* 00368 809A2EC8 460084A4 */  cvt.w.s $f18, $f16                 
/* 0036C 809A2ECC 4444F800 */  cfc1    $a0, $31
/* 00370 809A2ED0 00000000 */  nop
/* 00374 809A2ED4 30840078 */  andi    $a0, $a0, 0x0078           ## $a0 = 00000000
/* 00378 809A2ED8 50800013 */  beql    $a0, $zero, .L809A2F28     
/* 0037C 809A2EDC 44049000 */  mfc1    $a0, $f18                  
/* 00380 809A2EE0 44819000 */  mtc1    $at, $f18                  ## $f18 = 2147483648.00
/* 00384 809A2EE4 24040001 */  addiu   $a0, $zero, 0x0001         ## $a0 = 00000001
/* 00388 809A2EE8 46128481 */  sub.s   $f18, $f16, $f18           
/* 0038C 809A2EEC 44C4F800 */  ctc1    $a0, $31
/* 00390 809A2EF0 00000000 */  nop
/* 00394 809A2EF4 460094A4 */  cvt.w.s $f18, $f18                 
/* 00398 809A2EF8 4444F800 */  cfc1    $a0, $31
/* 0039C 809A2EFC 00000000 */  nop
/* 003A0 809A2F00 30840078 */  andi    $a0, $a0, 0x0078           ## $a0 = 00000000
/* 003A4 809A2F04 14800005 */  bne     $a0, $zero, .L809A2F1C     
/* 003A8 809A2F08 00000000 */  nop
/* 003AC 809A2F0C 44049000 */  mfc1    $a0, $f18                  
/* 003B0 809A2F10 3C018000 */  lui     $at, 0x8000                ## $at = 80000000
/* 003B4 809A2F14 10000007 */  beq     $zero, $zero, .L809A2F34   
/* 003B8 809A2F18 00812025 */  or      $a0, $a0, $at              ## $a0 = 80000000
.L809A2F1C:
/* 003BC 809A2F1C 10000005 */  beq     $zero, $zero, .L809A2F34   
/* 003C0 809A2F20 2404FFFF */  addiu   $a0, $zero, 0xFFFF         ## $a0 = FFFFFFFF
/* 003C4 809A2F24 44049000 */  mfc1    $a0, $f18                  
.L809A2F28:
/* 003C8 809A2F28 00000000 */  nop
/* 003CC 809A2F2C 0480FFFB */  bltz    $a0, .L809A2F1C            
/* 003D0 809A2F30 00000000 */  nop
.L809A2F34:
/* 003D4 809A2F34 308400FF */  andi    $a0, $a0, 0x00FF           ## $a0 = 000000FF
/* 003D8 809A2F38 00043600 */  sll     $a2, $a0, 24               
/* 003DC 809A2F3C AC660004 */  sw      $a2, 0x0004($v1)           ## 00000004
/* 003E0 809A2F40 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 003E4 809A2F44 00045C00 */  sll     $t3, $a0, 16               
/* 003E8 809A2F48 00CB6025 */  or      $t4, $a2, $t3              ## $t4 = 00000000
/* 003EC 809A2F4C 24490008 */  addiu   $t1, $v0, 0x0008           ## $t1 = 00000008
/* 003F0 809A2F50 AE0902D0 */  sw      $t1, 0x02D0($s0)           ## 000002D0
/* 003F4 809A2F54 358D00FF */  ori     $t5, $t4, 0x00FF           ## $t5 = 000000FF
/* 003F8 809A2F58 AC4D0004 */  sw      $t5, 0x0004($v0)           ## 00000004
/* 003FC 809A2F5C AC4A0000 */  sw      $t2, 0x0000($v0)           ## 00000000
/* 00400 809A2F60 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 00404 809A2F64 44C8F800 */  ctc1    $t0, $31
/* 00408 809A2F68 24080040 */  addiu   $t0, $zero, 0x0040         ## $t0 = 00000040
/* 0040C 809A2F6C 244E0008 */  addiu   $t6, $v0, 0x0008           ## $t6 = 00000008
/* 00410 809A2F70 AE0E02D0 */  sw      $t6, 0x02D0($s0)           ## 000002D0
/* 00414 809A2F74 AC4F0000 */  sw      $t7, 0x0000($v0)           ## 00000000
/* 00418 809A2F78 8FB80098 */  lw      $t8, 0x0098($sp)           
/* 0041C 809A2F7C 24090001 */  addiu   $t1, $zero, 0x0001         ## $t1 = 00000001
/* 00420 809A2F80 240E0080 */  addiu   $t6, $zero, 0x0080         ## $t6 = 00000080
/* 00424 809A2F84 8F040000 */  lw      $a0, 0x0000($t8)           ## 00000008
/* 00428 809A2F88 AFA0001C */  sw      $zero, 0x001C($sp)         
/* 0042C 809A2F8C AFA90018 */  sw      $t1, 0x0018($sp)           
/* 00430 809A2F90 AFA80014 */  sw      $t0, 0x0014($sp)           
/* 00434 809A2F94 AFB90010 */  sw      $t9, 0x0010($sp)           
/* 00438 809A2F98 862A0052 */  lh      $t2, 0x0052($s1)           ## 00000052
/* 0043C 809A2F9C 240D0020 */  addiu   $t5, $zero, 0x0020         ## $t5 = 00000020
/* 00440 809A2FA0 AFAD0024 */  sw      $t5, 0x0024($sp)           
/* 00444 809A2FA4 000A0823 */  subu    $at, $zero, $t2            
/* 00448 809A2FA8 00015880 */  sll     $t3, $at,  2               
/* 0044C 809A2FAC 01615821 */  addu    $t3, $t3, $at              
/* 00450 809A2FB0 000B5880 */  sll     $t3, $t3,  2               
/* 00454 809A2FB4 316C01FF */  andi    $t4, $t3, 0x01FF           ## $t4 = 00000000
/* 00458 809A2FB8 AFAC0020 */  sw      $t4, 0x0020($sp)           
/* 0045C 809A2FBC AFAE0028 */  sw      $t6, 0x0028($sp)           
/* 00460 809A2FC0 00003025 */  or      $a2, $zero, $zero          ## $a2 = 00000000
/* 00464 809A2FC4 0C0253D0 */  jal     Gfx_TwoTexScroll              
/* 00468 809A2FC8 AFA20058 */  sw      $v0, 0x0058($sp)           
/* 0046C 809A2FCC 8FA30058 */  lw      $v1, 0x0058($sp)           
/* 00470 809A2FD0 3C06809A */  lui     $a2, %hi(D_809A3288)       ## $a2 = 809A0000
/* 00474 809A2FD4 3C09DE00 */  lui     $t1, 0xDE00                ## $t1 = DE000000
/* 00478 809A2FD8 AC620004 */  sw      $v0, 0x0004($v1)           ## 00000004
/* 0047C 809A2FDC 862F0050 */  lh      $t7, 0x0050($s1)           ## 00000050
/* 00480 809A2FE0 24C63288 */  addiu   $a2, $a2, %lo(D_809A3288)  ## $a2 = 809A3288
/* 00484 809A2FE4 27A40068 */  addiu   $a0, $sp, 0x0068           ## $a0 = FFFFFFD0
/* 00488 809A2FE8 31F87FFF */  andi    $t8, $t7, 0x7FFF           ## $t8 = 00000000
/* 0048C 809A2FEC 17000006 */  bne     $t8, $zero, .L809A3008     
/* 00490 809A2FF0 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 00494 809A2FF4 8639005C */  lh      $t9, 0x005C($s1)           ## 0000005C
/* 00498 809A2FF8 3C0CDE00 */  lui     $t4, 0xDE00                ## $t4 = DE000000
/* 0049C 809A2FFC 2B210012 */  slti    $at, $t9, 0x0012           
/* 004A0 809A3000 5020000A */  beql    $at, $zero, .L809A302C     
/* 004A4 809A3004 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
.L809A3008:
/* 004A8 809A3008 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 004AC 809A300C 3C0A0405 */  lui     $t2, 0x0405                ## $t2 = 04050000
/* 004B0 809A3010 254AD5A0 */  addiu   $t2, $t2, 0xD5A0           ## $t2 = 0404D5A0
/* 004B4 809A3014 24480008 */  addiu   $t0, $v0, 0x0008           ## $t0 = 00000008
/* 004B8 809A3018 AE0802D0 */  sw      $t0, 0x02D0($s0)           ## 000002D0
/* 004BC 809A301C AC4A0004 */  sw      $t2, 0x0004($v0)           ## 00000004
/* 004C0 809A3020 10000008 */  beq     $zero, $zero, .L809A3044   
/* 004C4 809A3024 AC490000 */  sw      $t1, 0x0000($v0)           ## 00000000
/* 004C8 809A3028 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
.L809A302C:
/* 004CC 809A302C 3C0D0405 */  lui     $t5, 0x0405                ## $t5 = 04050000
/* 004D0 809A3030 25ADD4E0 */  addiu   $t5, $t5, 0xD4E0           ## $t5 = 0404D4E0
/* 004D4 809A3034 244B0008 */  addiu   $t3, $v0, 0x0008           ## $t3 = 00000008
/* 004D8 809A3038 AE0B02D0 */  sw      $t3, 0x02D0($s0)           ## 000002D0
/* 004DC 809A303C AC4D0004 */  sw      $t5, 0x0004($v0)           ## 00000004
/* 004E0 809A3040 AC4C0000 */  sw      $t4, 0x0000($v0)           ## 00000000
.L809A3044:
/* 004E4 809A3044 0C031AD5 */  jal     Graph_CloseDisps              
/* 004E8 809A3048 240700D5 */  addiu   $a3, $zero, 0x00D5         ## $a3 = 000000D5
/* 004EC 809A304C 8FBF003C */  lw      $ra, 0x003C($sp)           
/* 004F0 809A3050 8FB00034 */  lw      $s0, 0x0034($sp)           
/* 004F4 809A3054 8FB10038 */  lw      $s1, 0x0038($sp)           
/* 004F8 809A3058 03E00008 */  jr      $ra                        
/* 004FC 809A305C 27BD0098 */  addiu   $sp, $sp, 0x0098           ## $sp = 00000000
