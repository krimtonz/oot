.rdata
glabel D_80812AF0
    .asciz "../z_file_nameset_PAL.c"
    .balign 4

glabel D_80812B08
    .asciz "../z_file_nameset_PAL.c"
    .balign 4

.text
glabel func_80807DCC
/* 0408C 80807DCC 27BDFF78 */  addiu   $sp, $sp, 0xFF78           ## $sp = FFFFFF78
/* 04090 80807DD0 AFBF003C */  sw      $ra, 0x003C($sp)           
/* 04094 80807DD4 AFBE0038 */  sw      $s8, 0x0038($sp)           
/* 04098 80807DD8 AFB70034 */  sw      $s7, 0x0034($sp)           
/* 0409C 80807DDC AFB60030 */  sw      $s6, 0x0030($sp)           
/* 040A0 80807DE0 AFB5002C */  sw      $s5, 0x002C($sp)           
/* 040A4 80807DE4 AFB40028 */  sw      $s4, 0x0028($sp)           
/* 040A8 80807DE8 AFB30024 */  sw      $s3, 0x0024($sp)           
/* 040AC 80807DEC AFB20020 */  sw      $s2, 0x0020($sp)           
/* 040B0 80807DF0 AFB1001C */  sw      $s1, 0x001C($sp)           
/* 040B4 80807DF4 AFB00018 */  sw      $s0, 0x0018($sp)           
/* 040B8 80807DF8 8C850000 */  lw      $a1, 0x0000($a0)           ## 00000000
/* 040BC 80807DFC 0080A025 */  or      $s4, $a0, $zero            ## $s4 = 00000000
/* 040C0 80807E00 3C068081 */  lui     $a2, %hi(D_80812AF0)       ## $a2 = 80810000
/* 040C4 80807E04 00008825 */  or      $s1, $zero, $zero          ## $s1 = 00000000
/* 040C8 80807E08 0000A825 */  or      $s5, $zero, $zero          ## $s5 = 00000000
/* 040CC 80807E0C 24C62AF0 */  addiu   $a2, $a2, %lo(D_80812AF0)  ## $a2 = 80812AF0
/* 040D0 80807E10 27A40064 */  addiu   $a0, $sp, 0x0064           ## $a0 = FFFFFFDC
/* 040D4 80807E14 24070144 */  addiu   $a3, $zero, 0x0144         ## $a3 = 00000144
/* 040D8 80807E18 0C031AB1 */  jal     Graph_OpenDisps              
/* 040DC 80807E1C 00A0B025 */  or      $s6, $a1, $zero            ## $s6 = 00000000
/* 040E0 80807E20 0C02526A */  jal     func_800949A8              
/* 040E4 80807E24 8E840000 */  lw      $a0, 0x0000($s4)           ## 00000000
/* 040E8 80807E28 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 040EC 80807E2C 3C0FE300 */  lui     $t7, 0xE300                ## $t7 = E3000000
/* 040F0 80807E30 35EF0A01 */  ori     $t7, $t7, 0x0A01           ## $t7 = E3000A01
/* 040F4 80807E34 246E0008 */  addiu   $t6, $v1, 0x0008           ## $t6 = 00000008
/* 040F8 80807E38 AECE02C0 */  sw      $t6, 0x02C0($s6)           ## 000002C0
/* 040FC 80807E3C 3C180010 */  lui     $t8, 0x0010                ## $t8 = 00100000
/* 04100 80807E40 AC780004 */  sw      $t8, 0x0004($v1)           ## 00000004
/* 04104 80807E44 AC6F0000 */  sw      $t7, 0x0000($v1)           ## 00000000
/* 04108 80807E48 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 0410C 80807E4C 3C08E200 */  lui     $t0, 0xE200                ## $t0 = E2000000
/* 04110 80807E50 3C090C18 */  lui     $t1, 0x0C18                ## $t1 = 0C180000
/* 04114 80807E54 24790008 */  addiu   $t9, $v1, 0x0008           ## $t9 = 00000008
/* 04118 80807E58 AED902C0 */  sw      $t9, 0x02C0($s6)           ## 000002C0
/* 0411C 80807E5C 35294240 */  ori     $t1, $t1, 0x4240           ## $t1 = 0C184240
/* 04120 80807E60 3508001C */  ori     $t0, $t0, 0x001C           ## $t0 = E200001C
/* 04124 80807E64 AC680000 */  sw      $t0, 0x0000($v1)           ## 00000000
/* 04128 80807E68 AC690004 */  sw      $t1, 0x0004($v1)           ## 00000004
/* 0412C 80807E6C 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 04130 80807E70 3C0BFCFF */  lui     $t3, 0xFCFF                ## $t3 = FCFF0000
/* 04134 80807E74 3C0CFFFD */  lui     $t4, 0xFFFD                ## $t4 = FFFD0000
/* 04138 80807E78 246A0008 */  addiu   $t2, $v1, 0x0008           ## $t2 = 00000008
/* 0413C 80807E7C AECA02C0 */  sw      $t2, 0x02C0($s6)           ## 000002C0
/* 04140 80807E80 358C9238 */  ori     $t4, $t4, 0x9238           ## $t4 = FFFD9238
/* 04144 80807E84 356BADFF */  ori     $t3, $t3, 0xADFF           ## $t3 = FCFFADFF
/* 04148 80807E88 AC6B0000 */  sw      $t3, 0x0000($v1)           ## 00000000
/* 0414C 80807E8C AC6C0004 */  sw      $t4, 0x0004($v1)           ## 00000004
/* 04150 80807E90 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 04154 80807E94 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 04158 80807E98 34218000 */  ori     $at, $at, 0x8000           ## $at = 00018000
/* 0415C 80807E9C 246D0008 */  addiu   $t5, $v1, 0x0008           ## $t5 = 00000008
/* 04160 80807EA0 AECD02C0 */  sw      $t5, 0x02C0($s6)           ## 000002C0
/* 04164 80807EA4 0281F021 */  addu    $s8, $s4, $at              
/* 04168 80807EA8 87CE4ACC */  lh      $t6, 0x4ACC($s8)           ## 00004ACC
/* 0416C 80807EAC 3C01FA00 */  lui     $at, 0xFA00                ## $at = FA000000
/* 04170 80807EB0 2419FFFF */  addiu   $t9, $zero, 0xFFFF         ## $t9 = FFFFFFFF
/* 04174 80807EB4 31CF00FF */  andi    $t7, $t6, 0x00FF           ## $t7 = 00000008
/* 04178 80807EB8 01E1C025 */  or      $t8, $t7, $at              ## $t8 = FA000008
/* 0417C 80807EBC 3401E760 */  ori     $at, $zero, 0xE760         ## $at = 0000E760
/* 04180 80807EC0 3C170102 */  lui     $s7, 0x0102                ## $s7 = 01020000
/* 04184 80807EC4 3C138081 */  lui     $s3, %hi(D_808123F0)       ## $s3 = 80810000
/* 04188 80807EC8 267323F0 */  addiu   $s3, $s3, %lo(D_808123F0)  ## $s3 = 808123F0
/* 0418C 80807ECC 36F70040 */  ori     $s7, $s7, 0x0040           ## $s7 = 01020040
/* 04190 80807ED0 02819021 */  addu    $s2, $s4, $at              
/* 04194 80807ED4 AC780000 */  sw      $t8, 0x0000($v1)           ## 00000000
/* 04198 80807ED8 AC790004 */  sw      $t9, 0x0004($v1)           ## 00000004
/* 0419C 80807EDC 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
.L80807EE0:
/* 041A0 80807EE0 00155100 */  sll     $t2, $s5,  4               
/* 041A4 80807EE4 00008025 */  or      $s0, $zero, $zero          ## $s0 = 00000000
/* 041A8 80807EE8 24680008 */  addiu   $t0, $v1, 0x0008           ## $t0 = 00000008
/* 041AC 80807EEC AEC802C0 */  sw      $t0, 0x02C0($s6)           ## 000002C0
/* 041B0 80807EF0 AC770000 */  sw      $s7, 0x0000($v1)           ## 00000000
/* 041B4 80807EF4 8FC949EC */  lw      $t1, 0x49EC($s8)           ## 000049EC
/* 041B8 80807EF8 012A5821 */  addu    $t3, $t1, $t2              
/* 041BC 80807EFC AC6B0004 */  sw      $t3, 0x0004($v1)           ## 00000004
.L80807F00:
/* 041C0 80807F00 00116040 */  sll     $t4, $s1,  1               
/* 041C4 80807F04 026C6821 */  addu    $t5, $s3, $t4              
/* 041C8 80807F08 85AE0000 */  lh      $t6, 0x0000($t5)           ## 00000008
/* 041CC 80807F0C 00103400 */  sll     $a2, $s0, 16               
/* 041D0 80807F10 00063403 */  sra     $a2, $a2, 16               
/* 041D4 80807F14 000E79C0 */  sll     $t7, $t6,  7               
/* 041D8 80807F18 01F22821 */  addu    $a1, $t7, $s2              
/* 041DC 80807F1C 24A53C88 */  addiu   $a1, $a1, 0x3C88           ## $a1 = 00003C88
/* 041E0 80807F20 0C201B6C */  jal     func_80806DB0              
/* 041E4 80807F24 8E840000 */  lw      $a0, 0x0000($s4)           ## 00000000
/* 041E8 80807F28 26100004 */  addiu   $s0, $s0, 0x0004           ## $s0 = 00000004
/* 041EC 80807F2C 00108400 */  sll     $s0, $s0, 16               
/* 041F0 80807F30 00108403 */  sra     $s0, $s0, 16               
/* 041F4 80807F34 26310001 */  addiu   $s1, $s1, 0x0001           ## $s1 = 00000001
/* 041F8 80807F38 00118C00 */  sll     $s1, $s1, 16               
/* 041FC 80807F3C 2A010020 */  slti    $at, $s0, 0x0020           
/* 04200 80807F40 1420FFEF */  bne     $at, $zero, .L80807F00     
/* 04204 80807F44 00118C03 */  sra     $s1, $s1, 16               
/* 04208 80807F48 26B50020 */  addiu   $s5, $s5, 0x0020           ## $s5 = 00000020
/* 0420C 80807F4C 0015AC00 */  sll     $s5, $s5, 16               
/* 04210 80807F50 0015AC03 */  sra     $s5, $s5, 16               
/* 04214 80807F54 2AA10100 */  slti    $at, $s5, 0x0100           
/* 04218 80807F58 5420FFE1 */  bnel    $at, $zero, .L80807EE0     
/* 0421C 80807F5C 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 04220 80807F60 8EC302C0 */  lw      $v1, 0x02C0($s6)           ## 000002C0
/* 04224 80807F64 3C190100 */  lui     $t9, 0x0100                ## $t9 = 01000000
/* 04228 80807F68 37394008 */  ori     $t9, $t9, 0x4008           ## $t9 = 01004008
/* 0422C 80807F6C 24780008 */  addiu   $t8, $v1, 0x0008           ## $t8 = 00000008
/* 04230 80807F70 AED802C0 */  sw      $t8, 0x02C0($s6)           ## 000002C0
/* 04234 80807F74 AC790000 */  sw      $t9, 0x0000($v1)           ## 00000000
/* 04238 80807F78 8FC849EC */  lw      $t0, 0x49EC($s8)           ## 000049EC
/* 0423C 80807F7C 3C138081 */  lui     $s3, %hi(D_808123F0)       ## $s3 = 80810000
/* 04240 80807F80 267323F0 */  addiu   $s3, $s3, %lo(D_808123F0)  ## $s3 = 808123F0
/* 04244 80807F84 00115040 */  sll     $t2, $s1,  1               
/* 04248 80807F88 25091000 */  addiu   $t1, $t0, 0x1000           ## $t1 = 00001000
/* 0424C 80807F8C 026A5821 */  addu    $t3, $s3, $t2              
/* 04250 80807F90 AC690004 */  sw      $t1, 0x0004($v1)           ## 00000004
/* 04254 80807F94 856C0000 */  lh      $t4, 0x0000($t3)           ## 00000000
/* 04258 80807F98 3401E760 */  ori     $at, $zero, 0xE760         ## $at = 0000E760
/* 0425C 80807F9C 02819021 */  addu    $s2, $s4, $at              
/* 04260 80807FA0 000C69C0 */  sll     $t5, $t4,  7               
/* 04264 80807FA4 01B22821 */  addu    $a1, $t5, $s2              
/* 04268 80807FA8 24A53C88 */  addiu   $a1, $a1, 0x3C88           ## $a1 = 00003C88
/* 0426C 80807FAC 8E840000 */  lw      $a0, 0x0000($s4)           ## 00000000
/* 04270 80807FB0 0C201B6C */  jal     func_80806DB0              
/* 04274 80807FB4 00003025 */  or      $a2, $zero, $zero          ## $a2 = 00000000
/* 04278 80807FB8 3C068081 */  lui     $a2, %hi(D_80812B08)       ## $a2 = 80810000
/* 0427C 80807FBC 24C62B08 */  addiu   $a2, $a2, %lo(D_80812B08)  ## $a2 = 80812B08
/* 04280 80807FC0 27A40064 */  addiu   $a0, $sp, 0x0064           ## $a0 = FFFFFFDC
/* 04284 80807FC4 8E850000 */  lw      $a1, 0x0000($s4)           ## 00000000
/* 04288 80807FC8 0C031AD5 */  jal     Graph_CloseDisps              
/* 0428C 80807FCC 2407015B */  addiu   $a3, $zero, 0x015B         ## $a3 = 0000015B
/* 04290 80807FD0 8FBF003C */  lw      $ra, 0x003C($sp)           
/* 04294 80807FD4 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 04298 80807FD8 8FB1001C */  lw      $s1, 0x001C($sp)           
/* 0429C 80807FDC 8FB20020 */  lw      $s2, 0x0020($sp)           
/* 042A0 80807FE0 8FB30024 */  lw      $s3, 0x0024($sp)           
/* 042A4 80807FE4 8FB40028 */  lw      $s4, 0x0028($sp)           
/* 042A8 80807FE8 8FB5002C */  lw      $s5, 0x002C($sp)           
/* 042AC 80807FEC 8FB60030 */  lw      $s6, 0x0030($sp)           
/* 042B0 80807FF0 8FB70034 */  lw      $s7, 0x0034($sp)           
/* 042B4 80807FF4 8FBE0038 */  lw      $s8, 0x0038($sp)           
/* 042B8 80807FF8 03E00008 */  jr      $ra                        
/* 042BC 80807FFC 27BD0088 */  addiu   $sp, $sp, 0x0088           ## $sp = 00000000
