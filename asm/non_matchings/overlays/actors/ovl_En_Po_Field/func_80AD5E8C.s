.rdata
glabel D_80AD7160
    .asciz "../z_en_po_field.c"
    .balign 4

glabel D_80AD7174
    .asciz "../z_en_po_field.c"
    .balign 4

glabel D_80AD7188
    .asciz "../z_en_po_field.c"
    .balign 4

.late_rodata
glabel D_80AD7284
 .word 0x47A60400
glabel D_80AD7288
    .float 9.58738019108e-05

glabel D_80AD728C
 .word 0x3B449BA6
glabel D_80AD7290
    .float 0.7

glabel D_80AD7294
 .word 0x3A6BEDFB

.text
glabel func_80AD5E8C
/* 0238C 80AD5E8C 27BDFF78 */  addiu   $sp, $sp, 0xFF78           ## $sp = FFFFFF78
/* 02390 80AD5E90 AFBF0044 */  sw      $ra, 0x0044($sp)           
/* 02394 80AD5E94 AFB20040 */  sw      $s2, 0x0040($sp)           
/* 02398 80AD5E98 AFB1003C */  sw      $s1, 0x003C($sp)           
/* 0239C 80AD5E9C AFB00038 */  sw      $s0, 0x0038($sp)           
/* 023A0 80AD5EA0 848E019A */  lh      $t6, 0x019A($a0)           ## 0000019A
/* 023A4 80AD5EA4 00808825 */  or      $s1, $a0, $zero            ## $s1 = 00000000
/* 023A8 80AD5EA8 00A09025 */  or      $s2, $a1, $zero            ## $s2 = 00000000
/* 023AC 80AD5EAC 11C000B5 */  beq     $t6, $zero, .L80AD6184     
/* 023B0 80AD5EB0 27A4006C */  addiu   $a0, $sp, 0x006C           ## $a0 = FFFFFFE4
/* 023B4 80AD5EB4 8CA50000 */  lw      $a1, 0x0000($a1)           ## 00000000
/* 023B8 80AD5EB8 3C0680AD */  lui     $a2, %hi(D_80AD7160)       ## $a2 = 80AD0000
/* 023BC 80AD5EBC 24C67160 */  addiu   $a2, $a2, %lo(D_80AD7160)  ## $a2 = 80AD7160
/* 023C0 80AD5EC0 24070685 */  addiu   $a3, $zero, 0x0685         ## $a3 = 00000685
/* 023C4 80AD5EC4 0C031AB1 */  jal     Graph_OpenDisps              
/* 023C8 80AD5EC8 00A08025 */  or      $s0, $a1, $zero            ## $s0 = 00000000
/* 023CC 80AD5ECC 0C024F61 */  jal     func_80093D84              
/* 023D0 80AD5ED0 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 023D4 80AD5ED4 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 023D8 80AD5ED8 3C18DB06 */  lui     $t8, 0xDB06                ## $t8 = DB060000
/* 023DC 80AD5EDC 37180020 */  ori     $t8, $t8, 0x0020           ## $t8 = DB060020
/* 023E0 80AD5EE0 244F0008 */  addiu   $t7, $v0, 0x0008           ## $t7 = 00000008
/* 023E4 80AD5EE4 AE0F02D0 */  sw      $t7, 0x02D0($s0)           ## 000002D0
/* 023E8 80AD5EE8 AC580000 */  sw      $t8, 0x0000($v0)           ## 00000000
/* 023EC 80AD5EEC 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 023F0 80AD5EF0 24190020 */  addiu   $t9, $zero, 0x0020         ## $t9 = 00000020
/* 023F4 80AD5EF4 24080040 */  addiu   $t0, $zero, 0x0040         ## $t0 = 00000040
/* 023F8 80AD5EF8 24090001 */  addiu   $t1, $zero, 0x0001         ## $t1 = 00000001
/* 023FC 80AD5EFC 3C0A0001 */  lui     $t2, 0x0001                ## $t2 = 00010000
/* 02400 80AD5F00 01525021 */  addu    $t2, $t2, $s2              
/* 02404 80AD5F04 AFA90018 */  sw      $t1, 0x0018($sp)           
/* 02408 80AD5F08 AFA80014 */  sw      $t0, 0x0014($sp)           
/* 0240C 80AD5F0C AFB90010 */  sw      $t9, 0x0010($sp)           
/* 02410 80AD5F10 AFA0001C */  sw      $zero, 0x001C($sp)         
/* 02414 80AD5F14 8D4A1DE4 */  lw      $t2, 0x1DE4($t2)           ## 00011DE4
/* 02418 80AD5F18 240D0020 */  addiu   $t5, $zero, 0x0020         ## $t5 = 00000020
/* 0241C 80AD5F1C 240E0080 */  addiu   $t6, $zero, 0x0080         ## $t6 = 00000080
/* 02420 80AD5F20 000A0823 */  subu    $at, $zero, $t2            
/* 02424 80AD5F24 00015880 */  sll     $t3, $at,  2               
/* 02428 80AD5F28 01615821 */  addu    $t3, $t3, $at              
/* 0242C 80AD5F2C 000B5880 */  sll     $t3, $t3,  2               
/* 02430 80AD5F30 316C01FF */  andi    $t4, $t3, 0x01FF           ## $t4 = 00000000
/* 02434 80AD5F34 AFAC0020 */  sw      $t4, 0x0020($sp)           
/* 02438 80AD5F38 AFAE0028 */  sw      $t6, 0x0028($sp)           
/* 0243C 80AD5F3C AFAD0024 */  sw      $t5, 0x0024($sp)           
/* 02440 80AD5F40 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 02444 80AD5F44 00003025 */  or      $a2, $zero, $zero          ## $a2 = 00000000
/* 02448 80AD5F48 00003825 */  or      $a3, $zero, $zero          ## $a3 = 00000000
/* 0244C 80AD5F4C 0C0253D0 */  jal     Gfx_TwoTexScroll              
/* 02450 80AD5F50 AFA20068 */  sw      $v0, 0x0068($sp)           
/* 02454 80AD5F54 8FA30068 */  lw      $v1, 0x0068($sp)           
/* 02458 80AD5F58 3C0180AD */  lui     $at, %hi(D_80AD7284)       ## $at = 80AD0000
/* 0245C 80AD5F5C 24040001 */  addiu   $a0, $zero, 0x0001         ## $a0 = 00000001
/* 02460 80AD5F60 AC620004 */  sw      $v0, 0x0004($v1)           ## 00000004
/* 02464 80AD5F64 C4267284 */  lwc1    $f6, %lo(D_80AD7284)($at)  
/* 02468 80AD5F68 C6240220 */  lwc1    $f4, 0x0220($s1)           ## 00000220
/* 0246C 80AD5F6C 8E0302D0 */  lw      $v1, 0x02D0($s0)           ## 000002D0
/* 02470 80AD5F70 3C18FA00 */  lui     $t8, 0xFA00                ## $t8 = FA000000
/* 02474 80AD5F74 46062002 */  mul.s   $f0, $f4, $f6              
/* 02478 80AD5F78 246F0008 */  addiu   $t7, $v1, 0x0008           ## $t7 = 00000008
/* 0247C 80AD5F7C AE0F02D0 */  sw      $t7, 0x02D0($s0)           ## 000002D0
/* 02480 80AD5F80 37188080 */  ori     $t8, $t8, 0x8080           ## $t8 = FA008080
/* 02484 80AD5F84 3C014F00 */  lui     $at, 0x4F00                ## $at = 4F000000
/* 02488 80AD5F88 00003825 */  or      $a3, $zero, $zero          ## $a3 = 00000000
/* 0248C 80AD5F8C AC780000 */  sw      $t8, 0x0000($v1)           ## 00000000
/* 02490 80AD5F90 4459F800 */  cfc1    $t9, $31
/* 02494 80AD5F94 44C4F800 */  ctc1    $a0, $31
/* 02498 80AD5F98 00000000 */  nop
/* 0249C 80AD5F9C 46000224 */  cvt.w.s $f8, $f0                   
/* 024A0 80AD5FA0 4444F800 */  cfc1    $a0, $31
/* 024A4 80AD5FA4 00000000 */  nop
/* 024A8 80AD5FA8 30840078 */  andi    $a0, $a0, 0x0078           ## $a0 = 00000000
/* 024AC 80AD5FAC 50800013 */  beql    $a0, $zero, .L80AD5FFC     
/* 024B0 80AD5FB0 44044000 */  mfc1    $a0, $f8                   
/* 024B4 80AD5FB4 44814000 */  mtc1    $at, $f8                   ## $f8 = 2147483648.00
/* 024B8 80AD5FB8 24040001 */  addiu   $a0, $zero, 0x0001         ## $a0 = 00000001
/* 024BC 80AD5FBC 46080201 */  sub.s   $f8, $f0, $f8              
/* 024C0 80AD5FC0 44C4F800 */  ctc1    $a0, $31
/* 024C4 80AD5FC4 00000000 */  nop
/* 024C8 80AD5FC8 46004224 */  cvt.w.s $f8, $f8                   
/* 024CC 80AD5FCC 4444F800 */  cfc1    $a0, $31
/* 024D0 80AD5FD0 00000000 */  nop
/* 024D4 80AD5FD4 30840078 */  andi    $a0, $a0, 0x0078           ## $a0 = 00000000
/* 024D8 80AD5FD8 14800005 */  bne     $a0, $zero, .L80AD5FF0     
/* 024DC 80AD5FDC 00000000 */  nop
/* 024E0 80AD5FE0 44044000 */  mfc1    $a0, $f8                   
/* 024E4 80AD5FE4 3C018000 */  lui     $at, 0x8000                ## $at = 80000000
/* 024E8 80AD5FE8 10000007 */  beq     $zero, $zero, .L80AD6008   
/* 024EC 80AD5FEC 00812025 */  or      $a0, $a0, $at              ## $a0 = 80000000
.L80AD5FF0:
/* 024F0 80AD5FF0 10000005 */  beq     $zero, $zero, .L80AD6008   
/* 024F4 80AD5FF4 2404FFFF */  addiu   $a0, $zero, 0xFFFF         ## $a0 = FFFFFFFF
/* 024F8 80AD5FF8 44044000 */  mfc1    $a0, $f8                   
.L80AD5FFC:
/* 024FC 80AD5FFC 00000000 */  nop
/* 02500 80AD6000 0480FFFB */  bltz    $a0, .L80AD5FF0            
/* 02504 80AD6004 00000000 */  nop
.L80AD6008:
/* 02508 80AD6008 308400FF */  andi    $a0, $a0, 0x00FF           ## $a0 = 000000FF
/* 0250C 80AD600C 3C01FFFF */  lui     $at, 0xFFFF                ## $at = FFFF0000
/* 02510 80AD6010 00814025 */  or      $t0, $a0, $at              ## $t0 = FFFF00FF
/* 02514 80AD6014 AC680004 */  sw      $t0, 0x0004($v1)           ## 00000004
/* 02518 80AD6018 44D9F800 */  ctc1    $t9, $31
/* 0251C 80AD601C 8E26022C */  lw      $a2, 0x022C($s1)           ## 0000022C
/* 02520 80AD6020 C62E0228 */  lwc1    $f14, 0x0228($s1)          ## 00000228
/* 02524 80AD6024 C62C0224 */  lwc1    $f12, 0x0224($s1)          ## 00000224
/* 02528 80AD6028 0C034261 */  jal     Matrix_Translate              
/* 0252C 80AD602C AFA4004C */  sw      $a0, 0x004C($sp)           
/* 02530 80AD6030 864907A0 */  lh      $t1, 0x07A0($s2)           ## 000007A0
/* 02534 80AD6034 00095080 */  sll     $t2, $t1,  2               
/* 02538 80AD6038 024A5821 */  addu    $t3, $s2, $t2              
/* 0253C 80AD603C 0C016A7D */  jal     Camera_GetRealDirYaw              
/* 02540 80AD6040 8D640790 */  lw      $a0, 0x0790($t3)           ## 00000790
/* 02544 80AD6044 34018000 */  ori     $at, $zero, 0x8000         ## $at = 00008000
/* 02548 80AD6048 00416021 */  addu    $t4, $v0, $at              
/* 0254C 80AD604C 000C6C00 */  sll     $t5, $t4, 16               
/* 02550 80AD6050 000D7403 */  sra     $t6, $t5, 16               
/* 02554 80AD6054 448E5000 */  mtc1    $t6, $f10                  ## $f10 = 0.00
/* 02558 80AD6058 3C0180AD */  lui     $at, %hi(D_80AD7288)       ## $at = 80AD0000
/* 0255C 80AD605C C4327288 */  lwc1    $f18, %lo(D_80AD7288)($at) 
/* 02560 80AD6060 46805420 */  cvt.s.w $f16, $f10                 
/* 02564 80AD6064 24050001 */  addiu   $a1, $zero, 0x0001         ## $a1 = 00000001
/* 02568 80AD6068 46128302 */  mul.s   $f12, $f16, $f18           
/* 0256C 80AD606C 0C034348 */  jal     Matrix_RotateY              
/* 02570 80AD6070 00000000 */  nop
/* 02574 80AD6074 862F019A */  lh      $t7, 0x019A($s1)           ## 0000019A
/* 02578 80AD6078 29E10014 */  slti    $at, $t7, 0x0014           
/* 0257C 80AD607C 54200010 */  bnel    $at, $zero, .L80AD60C0     
/* 02580 80AD6080 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 02584 80AD6084 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 02588 80AD6088 3C19FB00 */  lui     $t9, 0xFB00                ## $t9 = FB000000
/* 0258C 80AD608C 3C08FF00 */  lui     $t0, 0xFF00                ## $t0 = FF000000
/* 02590 80AD6090 24580008 */  addiu   $t8, $v0, 0x0008           ## $t8 = 00000008
/* 02594 80AD6094 AE1802D0 */  sw      $t8, 0x02D0($s0)           ## 000002D0
/* 02598 80AD6098 AC480004 */  sw      $t0, 0x0004($v0)           ## 00000004
/* 0259C 80AD609C AC590000 */  sw      $t9, 0x0000($v0)           ## 00000000
/* 025A0 80AD60A0 C62C0220 */  lwc1    $f12, 0x0220($s1)          ## 00000220
/* 025A4 80AD60A4 24070001 */  addiu   $a3, $zero, 0x0001         ## $a3 = 00000001
/* 025A8 80AD60A8 44066000 */  mfc1    $a2, $f12                  
/* 025AC 80AD60AC 0C0342A3 */  jal     Matrix_Scale              
/* 025B0 80AD60B0 46006386 */  mov.s   $f14, $f12                 
/* 025B4 80AD60B4 10000018 */  beq     $zero, $zero, .L80AD6118   
/* 025B8 80AD60B8 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 025BC 80AD60BC 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
.L80AD60C0:
/* 025C0 80AD60C0 3C0AFB00 */  lui     $t2, 0xFB00                ## $t2 = FB000000
/* 025C4 80AD60C4 3C0180AD */  lui     $at, %hi(D_80AD728C)       ## $at = 80AD0000
/* 025C8 80AD60C8 24490008 */  addiu   $t1, $v0, 0x0008           ## $t1 = 00000008
/* 025CC 80AD60CC AE0902D0 */  sw      $t1, 0x02D0($s0)           ## 000002D0
/* 025D0 80AD60D0 AC4A0000 */  sw      $t2, 0x0000($v0)           ## 00000000
/* 025D4 80AD60D4 8FAB004C */  lw      $t3, 0x004C($sp)           
/* 025D8 80AD60D8 24070001 */  addiu   $a3, $zero, 0x0001         ## $a3 = 00000001
/* 025DC 80AD60DC 000B6600 */  sll     $t4, $t3, 24               
/* 025E0 80AD60E0 AC4C0004 */  sw      $t4, 0x0004($v0)           ## 00000004
/* 025E4 80AD60E4 C422728C */  lwc1    $f2, %lo(D_80AD728C)($at)  
/* 025E8 80AD60E8 3C0180AD */  lui     $at, %hi(D_80AD7290)       ## $at = 80AD0000
/* 025EC 80AD60EC C4247290 */  lwc1    $f4, %lo(D_80AD7290)($at)  
/* 025F0 80AD60F0 C6200220 */  lwc1    $f0, 0x0220($s1)           ## 00000220
/* 025F4 80AD60F4 3C0180AD */  lui     $at, %hi(D_80AD7294)       ## $at = 80AD0000
/* 025F8 80AD60F8 C4287294 */  lwc1    $f8, %lo(D_80AD7294)($at)  
/* 025FC 80AD60FC 46040182 */  mul.s   $f6, $f0, $f4              
/* 02600 80AD6100 46001281 */  sub.s   $f10, $f2, $f0             
/* 02604 80AD6104 44061000 */  mfc1    $a2, $f2                   
/* 02608 80AD6108 46025380 */  add.s   $f14, $f10, $f2            
/* 0260C 80AD610C 0C0342A3 */  jal     Matrix_Scale              
/* 02610 80AD6110 46083300 */  add.s   $f12, $f6, $f8             
/* 02614 80AD6114 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
.L80AD6118:
/* 02618 80AD6118 3C0EDA38 */  lui     $t6, 0xDA38                ## $t6 = DA380000
/* 0261C 80AD611C 35CE0003 */  ori     $t6, $t6, 0x0003           ## $t6 = DA380003
/* 02620 80AD6120 244D0008 */  addiu   $t5, $v0, 0x0008           ## $t5 = 00000008
/* 02624 80AD6124 AE0D02D0 */  sw      $t5, 0x02D0($s0)           ## 000002D0
/* 02628 80AD6128 AC4E0000 */  sw      $t6, 0x0000($v0)           ## 00000000
/* 0262C 80AD612C 8E440000 */  lw      $a0, 0x0000($s2)           ## 00000000
/* 02630 80AD6130 3C0580AD */  lui     $a1, %hi(D_80AD7174)       ## $a1 = 80AD0000
/* 02634 80AD6134 24A57174 */  addiu   $a1, $a1, %lo(D_80AD7174)  ## $a1 = 80AD7174
/* 02638 80AD6138 240606AD */  addiu   $a2, $zero, 0x06AD         ## $a2 = 000006AD
/* 0263C 80AD613C 0C0346A2 */  jal     Matrix_NewMtx              
/* 02640 80AD6140 AFA20058 */  sw      $v0, 0x0058($sp)           
/* 02644 80AD6144 8FA30058 */  lw      $v1, 0x0058($sp)           
/* 02648 80AD6148 3C190405 */  lui     $t9, 0x0405                ## $t9 = 04050000
/* 0264C 80AD614C 2739D4E0 */  addiu   $t9, $t9, 0xD4E0           ## $t9 = 0404D4E0
/* 02650 80AD6150 AC620004 */  sw      $v0, 0x0004($v1)           ## 00000004
/* 02654 80AD6154 8E0202D0 */  lw      $v0, 0x02D0($s0)           ## 000002D0
/* 02658 80AD6158 3C18DE00 */  lui     $t8, 0xDE00                ## $t8 = DE000000
/* 0265C 80AD615C 3C0680AD */  lui     $a2, %hi(D_80AD7188)       ## $a2 = 80AD0000
/* 02660 80AD6160 244F0008 */  addiu   $t7, $v0, 0x0008           ## $t7 = 00000008
/* 02664 80AD6164 AE0F02D0 */  sw      $t7, 0x02D0($s0)           ## 000002D0
/* 02668 80AD6168 AC590004 */  sw      $t9, 0x0004($v0)           ## 00000004
/* 0266C 80AD616C AC580000 */  sw      $t8, 0x0000($v0)           ## 00000000
/* 02670 80AD6170 8E450000 */  lw      $a1, 0x0000($s2)           ## 00000000
/* 02674 80AD6174 24C67188 */  addiu   $a2, $a2, %lo(D_80AD7188)  ## $a2 = 80AD7188
/* 02678 80AD6178 27A4006C */  addiu   $a0, $sp, 0x006C           ## $a0 = FFFFFFE4
/* 0267C 80AD617C 0C031AD5 */  jal     Graph_CloseDisps              
/* 02680 80AD6180 240706B0 */  addiu   $a3, $zero, 0x06B0         ## $a3 = 000006B0
.L80AD6184:
/* 02684 80AD6184 8FBF0044 */  lw      $ra, 0x0044($sp)           
/* 02688 80AD6188 8FB00038 */  lw      $s0, 0x0038($sp)           
/* 0268C 80AD618C 8FB1003C */  lw      $s1, 0x003C($sp)           
/* 02690 80AD6190 8FB20040 */  lw      $s2, 0x0040($sp)           
/* 02694 80AD6194 03E00008 */  jr      $ra                        
/* 02698 80AD6198 27BD0088 */  addiu   $sp, $sp, 0x0088           ## $sp = 00000000
