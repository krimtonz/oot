.rdata
glabel D_80A077CC
    .asciz "[32m☆☆☆☆☆ 発生できません！ ☆☆☆☆☆\n[m"
    .balign 4

glabel D_80A077FC
    .asciz "[32m☆☆☆☆☆ 発生できません！ ☆☆☆☆☆\n[m"
    .balign 4

glabel D_80A0782C
    .asciz "[32m☆☆☆☆☆ 発生できません！ ☆☆☆☆☆\n[m"
    .balign 4

.text
glabel func_80A06E88
/* 00768 80A06E88 27BDFF48 */  addiu   $sp, $sp, 0xFF48           ## $sp = FFFFFF48
/* 0076C 80A06E8C AFBF0074 */  sw      $ra, 0x0074($sp)           
/* 00770 80A06E90 AFB60070 */  sw      $s6, 0x0070($sp)           
/* 00774 80A06E94 AFB5006C */  sw      $s5, 0x006C($sp)           
/* 00778 80A06E98 AFB40068 */  sw      $s4, 0x0068($sp)           
/* 0077C 80A06E9C AFB30064 */  sw      $s3, 0x0064($sp)           
/* 00780 80A06EA0 AFB20060 */  sw      $s2, 0x0060($sp)           
/* 00784 80A06EA4 AFB1005C */  sw      $s1, 0x005C($sp)           
/* 00788 80A06EA8 AFB00058 */  sw      $s0, 0x0058($sp)           
/* 0078C 80A06EAC F7BA0050 */  sdc1    $f26, 0x0050($sp)          
/* 00790 80A06EB0 F7B80048 */  sdc1    $f24, 0x0048($sp)          
/* 00794 80A06EB4 F7B60040 */  sdc1    $f22, 0x0040($sp)          
/* 00798 80A06EB8 F7B40038 */  sdc1    $f20, 0x0038($sp)          
/* 0079C 80A06EBC 84AE00A4 */  lh      $t6, 0x00A4($a1)           ## 000000A4
/* 007A0 80A06EC0 24160051 */  addiu   $s6, $zero, 0x0051         ## $s6 = 00000051
/* 007A4 80A06EC4 00808825 */  or      $s1, $a0, $zero            ## $s1 = 00000000
/* 007A8 80A06EC8 00A0A025 */  or      $s4, $a1, $zero            ## $s4 = 00000000
/* 007AC 80A06ECC 12CE0015 */  beq     $s6, $t6, .L80A06F24       
/* 007B0 80A06ED0 8CB21C44 */  lw      $s2, 0x1C44($a1)           ## 00001C44
/* 007B4 80A06ED4 C6440028 */  lwc1    $f4, 0x0028($s2)           ## 00000028
/* 007B8 80A06ED8 C4860028 */  lwc1    $f6, 0x0028($a0)           ## 00000028
/* 007BC 80A06EDC 3C0142C8 */  lui     $at, 0x42C8                ## $at = 42C80000
/* 007C0 80A06EE0 44814000 */  mtc1    $at, $f8                   ## $f8 = 100.00
/* 007C4 80A06EE4 46062001 */  sub.s   $f0, $f4, $f6              
/* 007C8 80A06EE8 46000005 */  abs.s   $f0, $f0                   
/* 007CC 80A06EEC 4600403C */  c.lt.s  $f8, $f0                   
/* 007D0 80A06EF0 00000000 */  nop
/* 007D4 80A06EF4 45030008 */  bc1tl   .L80A06F18                 
/* 007D8 80A06EF8 862F015A */  lh      $t7, 0x015A($s1)           ## 0000015A
/* 007DC 80A06EFC C48A0168 */  lwc1    $f10, 0x0168($a0)          ## 00000168
/* 007E0 80A06F00 C4900090 */  lwc1    $f16, 0x0090($a0)          ## 00000090
/* 007E4 80A06F04 4610503C */  c.lt.s  $f10, $f16                 
/* 007E8 80A06F08 00000000 */  nop
/* 007EC 80A06F0C 45020011 */  bc1fl   .L80A06F54                 
/* 007F0 80A06F10 8E2B0024 */  lw      $t3, 0x0024($s1)           ## 00000024
/* 007F4 80A06F14 862F015A */  lh      $t7, 0x015A($s1)           ## 0000015A
.L80A06F18:
/* 007F8 80A06F18 25F80001 */  addiu   $t8, $t7, 0x0001           ## $t8 = 00000001
/* 007FC 80A06F1C 100000EC */  beq     $zero, $zero, .L80A072D0   
/* 00800 80A06F20 A638015A */  sh      $t8, 0x015A($s1)           ## 0000015A
.L80A06F24:
/* 00804 80A06F24 3C198016 */  lui     $t9, 0x8016                ## $t9 = 80160000
/* 00808 80A06F28 8F39E670 */  lw      $t9, -0x1990($t9)          ## 8015E670
/* 0080C 80A06F2C 13200006 */  beq     $t9, $zero, .L80A06F48     
/* 00810 80A06F30 00000000 */  nop
/* 00814 80A06F34 0C023C20 */  jal     func_8008F080              
/* 00818 80A06F38 02802025 */  or      $a0, $s4, $zero            ## $a0 = 00000000
/* 0081C 80A06F3C 24010004 */  addiu   $at, $zero, 0x0004         ## $at = 00000004
/* 00820 80A06F40 54410004 */  bnel    $v0, $at, .L80A06F54       
/* 00824 80A06F44 8E2B0024 */  lw      $t3, 0x0024($s1)           ## 00000024
.L80A06F48:
/* 00828 80A06F48 100000E1 */  beq     $zero, $zero, .L80A072D0   
/* 0082C 80A06F4C A620015E */  sh      $zero, 0x015E($s1)         ## 0000015E
/* 00830 80A06F50 8E2B0024 */  lw      $t3, 0x0024($s1)           ## 00000024
.L80A06F54:
/* 00834 80A06F54 A620015A */  sh      $zero, 0x015A($s1)         ## 0000015A
/* 00838 80A06F58 27A90098 */  addiu   $t1, $sp, 0x0098           ## $t1 = FFFFFFE0
/* 0083C 80A06F5C AD2B0000 */  sw      $t3, 0x0000($t1)           ## FFFFFFE0
/* 00840 80A06F60 8E2A0028 */  lw      $t2, 0x0028($s1)           ## 00000028
/* 00844 80A06F64 AD2A0004 */  sw      $t2, 0x0004($t1)           ## FFFFFFE4
/* 00848 80A06F68 8E2B002C */  lw      $t3, 0x002C($s1)           ## 0000002C
/* 0084C 80A06F6C AD2B0008 */  sw      $t3, 0x0008($t1)           ## FFFFFFE8
/* 00850 80A06F70 86230150 */  lh      $v1, 0x0150($s1)           ## 00000150
/* 00854 80A06F74 86220152 */  lh      $v0, 0x0152($s1)           ## 00000152
/* 00858 80A06F78 0043082A */  slt     $at, $v0, $v1              
/* 0085C 80A06F7C 502000D5 */  beql    $at, $zero, .L80A072D4     
/* 00860 80A06F80 8FBF0074 */  lw      $ra, 0x0074($sp)           
/* 00864 80A06F84 86240158 */  lh      $a0, 0x0158($s1)           ## 00000158
/* 00868 80A06F88 86250156 */  lh      $a1, 0x0156($s1)           ## 00000156
/* 0086C 80A06F8C 0085082A */  slt     $at, $a0, $a1              
/* 00870 80A06F90 102000CF */  beq     $at, $zero, .L80A072D0     
/* 00874 80A06F94 0043082A */  slt     $at, $v0, $v1              
/* 00878 80A06F98 102000CD */  beq     $at, $zero, .L80A072D0     
/* 0087C 80A06F9C 0085082A */  slt     $at, $a0, $a1              
/* 00880 80A06FA0 102000CB */  beq     $at, $zero, .L80A072D0     
/* 00884 80A06FA4 3C01C6FA */  lui     $at, 0xC6FA                ## $at = C6FA0000
/* 00888 80A06FA8 4481D000 */  mtc1    $at, $f26                  ## $f26 = -32000.00
/* 0088C 80A06FAC 3C014220 */  lui     $at, 0x4220                ## $at = 42200000
/* 00890 80A06FB0 4481C000 */  mtc1    $at, $f24                  ## $f24 = 40.00
/* 00894 80A06FB4 2415000A */  addiu   $s5, $zero, 0x000A         ## $s5 = 0000000A
/* 00898 80A06FB8 868C00A4 */  lh      $t4, 0x00A4($s4)           ## 000000A4
.L80A06FBC:
/* 0089C 80A06FBC 56CC0062 */  bnel    $s6, $t4, .L80A07148       
/* 008A0 80A06FC0 862F0154 */  lh      $t7, 0x0154($s1)           ## 00000154
/* 008A4 80A06FC4 964D089E */  lhu     $t5, 0x089E($s2)           ## 0000089E
/* 008A8 80A06FC8 269307C0 */  addiu   $s3, $s4, 0x07C0           ## $s3 = 000007C0
/* 008AC 80A06FCC 51A0000E */  beql    $t5, $zero, .L80A07008     
/* 008B0 80A06FD0 240A003C */  addiu   $t2, $zero, 0x003C         ## $t2 = 0000003C
/* 008B4 80A06FD4 924E007D */  lbu     $t6, 0x007D($s2)           ## 0000007D
/* 008B8 80A06FD8 24010032 */  addiu   $at, $zero, 0x0032         ## $at = 00000032
/* 008BC 80A06FDC 55C1000A */  bnel    $t6, $at, .L80A07008       
/* 008C0 80A06FE0 240A003C */  addiu   $t2, $zero, 0x003C         ## $t2 = 0000003C
/* 008C4 80A06FE4 964F0088 */  lhu     $t7, 0x0088($s2)           ## 00000088
/* 008C8 80A06FE8 240B0002 */  addiu   $t3, $zero, 0x0002         ## $t3 = 00000002
/* 008CC 80A06FEC 31F80001 */  andi    $t8, $t7, 0x0001           ## $t8 = 00000000
/* 008D0 80A06FF0 53000005 */  beql    $t8, $zero, .L80A07008     
/* 008D4 80A06FF4 240A003C */  addiu   $t2, $zero, 0x003C         ## $t2 = 0000003C
/* 008D8 80A06FF8 8E59067C */  lw      $t9, 0x067C($s2)           ## 0000067C
/* 008DC 80A06FFC 00194900 */  sll     $t1, $t9,  4               
/* 008E0 80A07000 05210003 */  bgez    $t1, .L80A07010            
/* 008E4 80A07004 240A003C */  addiu   $t2, $zero, 0x003C         ## $t2 = 0000003C
.L80A07008:
/* 008E8 80A07008 100000B1 */  beq     $zero, $zero, .L80A072D0   
/* 008EC 80A0700C A62A015C */  sh      $t2, 0x015C($s1)           ## 0000015C
.L80A07010:
/* 008F0 80A07010 8622015C */  lh      $v0, 0x015C($s1)           ## 0000015C
/* 008F4 80A07014 2401003C */  addiu   $at, $zero, 0x003C         ## $at = 0000003C
/* 008F8 80A07018 14410003 */  bne     $v0, $at, .L80A07028       
/* 008FC 80A0701C 00000000 */  nop
/* 00900 80A07020 A62B0150 */  sh      $t3, 0x0150($s1)           ## 00000150
/* 00904 80A07024 8622015C */  lh      $v0, 0x015C($s1)           ## 0000015C
.L80A07028:
/* 00908 80A07028 10400003 */  beq     $v0, $zero, .L80A07038     
/* 0090C 80A0702C 244CFFFF */  addiu   $t4, $v0, 0xFFFF           ## $t4 = FFFFFFFF
/* 00910 80A07030 100000A7 */  beq     $zero, $zero, .L80A072D0   
/* 00914 80A07034 A62C015C */  sh      $t4, 0x015C($s1)           ## 0000015C
.L80A07038:
/* 00918 80A07038 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 0091C 80A0703C 4600C306 */  mov.s   $f12, $f24                 
/* 00920 80A07040 862D0152 */  lh      $t5, 0x0152($s1)           ## 00000152
/* 00924 80A07044 3C014348 */  lui     $at, 0x4348                ## $at = 43480000
/* 00928 80A07048 44819000 */  mtc1    $at, $f18                  ## $f18 = 200.00
/* 0092C 80A0704C 865000B6 */  lh      $s0, 0x00B6($s2)           ## 000000B6
/* 00930 80A07050 11A0000A */  beq     $t5, $zero, .L80A0707C     
/* 00934 80A07054 46120580 */  add.s   $f22, $f0, $f18            
/* 00938 80A07058 00108023 */  subu    $s0, $zero, $s0            
/* 0093C 80A0705C 00108400 */  sll     $s0, $s0, 16               
/* 00940 80A07060 00108403 */  sra     $s0, $s0, 16               
/* 00944 80A07064 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 00948 80A07068 4600C306 */  mov.s   $f12, $f24                 
/* 0094C 80A0706C 3C0142C8 */  lui     $at, 0x42C8                ## $at = 42C80000
/* 00950 80A07070 44812000 */  mtc1    $at, $f4                   ## $f4 = 100.00
/* 00954 80A07074 00000000 */  nop
/* 00958 80A07078 46040580 */  add.s   $f22, $f0, $f4             
.L80A0707C:
/* 0095C 80A0707C 00102400 */  sll     $a0, $s0, 16               
/* 00960 80A07080 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 00964 80A07084 00042403 */  sra     $a0, $a0, 16               
/* 00968 80A07088 46000506 */  mov.s   $f20, $f0                  
/* 0096C 80A0708C 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 00970 80A07090 4600C306 */  mov.s   $f12, $f24                 
/* 00974 80A07094 4616A202 */  mul.s   $f8, $f20, $f22            
/* 00978 80A07098 C6460024 */  lwc1    $f6, 0x0024($s2)           ## 00000024
/* 0097C 80A0709C 3C0142F0 */  lui     $at, 0x42F0                ## $at = 42F00000
/* 00980 80A070A0 44812000 */  mtc1    $at, $f4                   ## $f4 = 120.00
/* 00984 80A070A4 00102400 */  sll     $a0, $s0, 16               
/* 00988 80A070A8 00042403 */  sra     $a0, $a0, 16               
/* 0098C 80A070AC 46083280 */  add.s   $f10, $f6, $f8             
/* 00990 80A070B0 460A0400 */  add.s   $f16, $f0, $f10            
/* 00994 80A070B4 E7B00098 */  swc1    $f16, 0x0098($sp)          
/* 00998 80A070B8 C6520080 */  lwc1    $f18, 0x0080($s2)          ## 00000080
/* 0099C 80A070BC 46049180 */  add.s   $f6, $f18, $f4             
/* 009A0 80A070C0 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 009A4 80A070C4 E7A6009C */  swc1    $f6, 0x009C($sp)           
/* 009A8 80A070C8 46000506 */  mov.s   $f20, $f0                  
/* 009AC 80A070CC 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 009B0 80A070D0 4600C306 */  mov.s   $f12, $f24                 
/* 009B4 80A070D4 4616A282 */  mul.s   $f10, $f20, $f22           
/* 009B8 80A070D8 C648002C */  lwc1    $f8, 0x002C($s2)           ## 0000002C
/* 009BC 80A070DC 27AE0098 */  addiu   $t6, $sp, 0x0098           ## $t6 = FFFFFFE0
/* 009C0 80A070E0 AFAE0010 */  sw      $t6, 0x0010($sp)           
/* 009C4 80A070E4 02602025 */  or      $a0, $s3, $zero            ## $a0 = 000007C0
/* 009C8 80A070E8 27A50094 */  addiu   $a1, $sp, 0x0094           ## $a1 = FFFFFFDC
/* 009CC 80A070EC 27A60090 */  addiu   $a2, $sp, 0x0090           ## $a2 = FFFFFFD8
/* 009D0 80A070F0 460A4400 */  add.s   $f16, $f8, $f10            
/* 009D4 80A070F4 02203825 */  or      $a3, $s1, $zero            ## $a3 = 00000000
/* 009D8 80A070F8 46100480 */  add.s   $f18, $f0, $f16            
/* 009DC 80A070FC 0C00F269 */  jal     func_8003C9A4              
/* 009E0 80A07100 E7B200A0 */  swc1    $f18, 0x00A0($sp)          
/* 009E4 80A07104 461A003E */  c.le.s  $f0, $f26                  
/* 009E8 80A07108 00000000 */  nop
/* 009EC 80A0710C 45030071 */  bc1tl   .L80A072D4                 
/* 009F0 80A07110 8FBF0074 */  lw      $ra, 0x0074($sp)           
/* 009F4 80A07114 C6420084 */  lwc1    $f2, 0x0084($s2)           ## 00000084
/* 009F8 80A07118 4602D032 */  c.eq.s  $f26, $f2                  
/* 009FC 80A0711C 00000000 */  nop
/* 00A00 80A07120 45030008 */  bc1tl   .L80A07144                 
/* 00A04 80A07124 E7A0009C */  swc1    $f0, 0x009C($sp)           
/* 00A08 80A07128 C6440028 */  lwc1    $f4, 0x0028($s2)           ## 00000028
/* 00A0C 80A0712C 46022181 */  sub.s   $f6, $f4, $f2              
/* 00A10 80A07130 4606003C */  c.lt.s  $f0, $f6                   
/* 00A14 80A07134 00000000 */  nop
/* 00A18 80A07138 45030066 */  bc1tl   .L80A072D4                 
/* 00A1C 80A0713C 8FBF0074 */  lw      $ra, 0x0074($sp)           
/* 00A20 80A07140 E7A0009C */  swc1    $f0, 0x009C($sp)           
.L80A07144:
/* 00A24 80A07144 862F0154 */  lh      $t7, 0x0154($s1)           ## 00000154
.L80A07148:
/* 00A28 80A07148 24010003 */  addiu   $at, $zero, 0x0003         ## $at = 00000003
/* 00A2C 80A0714C 26901C24 */  addiu   $s0, $s4, 0x1C24           ## $s0 = 00001C24
/* 00A30 80A07150 15E10004 */  bne     $t7, $at, .L80A07164       
/* 00A34 80A07154 02202825 */  or      $a1, $s1, $zero            ## $a1 = 00000000
/* 00A38 80A07158 240701AF */  addiu   $a3, $zero, 0x01AF         ## $a3 = 000001AF
/* 00A3C 80A0715C 10000028 */  beq     $zero, $zero, .L80A07200   
/* 00A40 80A07160 2408FF00 */  addiu   $t0, $zero, 0xFF00         ## $t0 = FFFFFF00
.L80A07164:
/* 00A44 80A07164 8622015E */  lh      $v0, 0x015E($s1)           ## 0000015E
/* 00A48 80A07168 240701B0 */  addiu   $a3, $zero, 0x01B0         ## $a3 = 000001B0
/* 00A4C 80A0716C 00004025 */  or      $t0, $zero, $zero          ## $t0 = 00000000
/* 00A50 80A07170 0055001A */  div     $zero, $v0, $s5            
/* 00A54 80A07174 00002012 */  mflo    $a0                        
/* 00A58 80A07178 00042400 */  sll     $a0, $a0, 16               
/* 00A5C 80A0717C 00042403 */  sra     $a0, $a0, 16               
/* 00A60 80A07180 16A00002 */  bne     $s5, $zero, .L80A0718C     
/* 00A64 80A07184 00000000 */  nop
/* 00A68 80A07188 0007000D */  break 7
.L80A0718C:
/* 00A6C 80A0718C 2401FFFF */  addiu   $at, $zero, 0xFFFF         ## $at = FFFFFFFF
/* 00A70 80A07190 16A10004 */  bne     $s5, $at, .L80A071A4       
/* 00A74 80A07194 3C018000 */  lui     $at, 0x8000                ## $at = 80000000
/* 00A78 80A07198 14410002 */  bne     $v0, $at, .L80A071A4       
/* 00A7C 80A0719C 00000000 */  nop
/* 00A80 80A071A0 0006000D */  break 6
.L80A071A4:
/* 00A84 80A071A4 24580001 */  addiu   $t8, $v0, 0x0001           ## $t8 = 00000001
/* 00A88 80A071A8 58800015 */  blezl   $a0, .L80A07200            
/* 00A8C 80A071AC A638015E */  sh      $t8, 0x015E($s1)           ## 0000015E
/* 00A90 80A071B0 0055001A */  div     $zero, $v0, $s5            
/* 00A94 80A071B4 00001810 */  mfhi    $v1                        
/* 00A98 80A071B8 00031C00 */  sll     $v1, $v1, 16               
/* 00A9C 80A071BC 00031C03 */  sra     $v1, $v1, 16               
/* 00AA0 80A071C0 16A00002 */  bne     $s5, $zero, .L80A071CC     
/* 00AA4 80A071C4 00000000 */  nop
/* 00AA8 80A071C8 0007000D */  break 7
.L80A071CC:
/* 00AAC 80A071CC 2401FFFF */  addiu   $at, $zero, 0xFFFF         ## $at = FFFFFFFF
/* 00AB0 80A071D0 16A10004 */  bne     $s5, $at, .L80A071E4       
/* 00AB4 80A071D4 3C018000 */  lui     $at, 0x8000                ## $at = 80000000
/* 00AB8 80A071D8 14410002 */  bne     $v0, $at, .L80A071E4       
/* 00ABC 80A071DC 00000000 */  nop
/* 00AC0 80A071E0 0006000D */  break 6
.L80A071E4:
/* 00AC4 80A071E4 54600006 */  bnel    $v1, $zero, .L80A07200     
/* 00AC8 80A071E8 A638015E */  sh      $t8, 0x015E($s1)           ## 0000015E
/* 00ACC 80A071EC 00044080 */  sll     $t0, $a0,  2               
/* 00AD0 80A071F0 01044021 */  addu    $t0, $t0, $a0              
/* 00AD4 80A071F4 00084400 */  sll     $t0, $t0, 16               
/* 00AD8 80A071F8 00084403 */  sra     $t0, $t0, 16               
/* 00ADC 80A071FC A638015E */  sh      $t8, 0x015E($s1)           ## 0000015E
.L80A07200:
/* 00AE0 80A07200 C7A80098 */  lwc1    $f8, 0x0098($sp)           
/* 00AE4 80A07204 C7AA009C */  lwc1    $f10, 0x009C($sp)          
/* 00AE8 80A07208 C7B000A0 */  lwc1    $f16, 0x00A0($sp)          
/* 00AEC 80A0720C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00001C24
/* 00AF0 80A07210 02803025 */  or      $a2, $s4, $zero            ## $a2 = 00000000
/* 00AF4 80A07214 AFA0001C */  sw      $zero, 0x001C($sp)         
/* 00AF8 80A07218 AFA00020 */  sw      $zero, 0x0020($sp)         
/* 00AFC 80A0721C AFA00024 */  sw      $zero, 0x0024($sp)         
/* 00B00 80A07220 AFA80028 */  sw      $t0, 0x0028($sp)           
/* 00B04 80A07224 E7A80010 */  swc1    $f8, 0x0010($sp)           
/* 00B08 80A07228 E7AA0014 */  swc1    $f10, 0x0014($sp)          
/* 00B0C 80A0722C 0C00C916 */  jal     Actor_SpawnAttached
              
/* 00B10 80A07230 E7B00018 */  swc1    $f16, 0x0018($sp)          
/* 00B14 80A07234 10400013 */  beq     $v0, $zero, .L80A07284     
/* 00B18 80A07238 240C0064 */  addiu   $t4, $zero, 0x0064         ## $t4 = 00000064
/* 00B1C 80A0723C 86390152 */  lh      $t9, 0x0152($s1)           ## 00000152
/* 00B20 80A07240 862B0150 */  lh      $t3, 0x0150($s1)           ## 00000150
/* 00B24 80A07244 27290001 */  addiu   $t1, $t9, 0x0001           ## $t1 = 00000001
/* 00B28 80A07248 A6290152 */  sh      $t1, 0x0152($s1)           ## 00000152
/* 00B2C 80A0724C 862A0152 */  lh      $t2, 0x0152($s1)           ## 00000152
/* 00B30 80A07250 014B082A */  slt     $at, $t2, $t3              
/* 00B34 80A07254 54200003 */  bnel    $at, $zero, .L80A07264     
/* 00B38 80A07258 868D00A4 */  lh      $t5, 0x00A4($s4)           ## 000000A4
/* 00B3C 80A0725C A62C015C */  sh      $t4, 0x015C($s1)           ## 0000015C
/* 00B40 80A07260 868D00A4 */  lh      $t5, 0x00A4($s4)           ## 000000A4
.L80A07264:
/* 00B44 80A07264 52CD0005 */  beql    $s6, $t5, .L80A0727C       
/* 00B48 80A07268 86220152 */  lh      $v0, 0x0152($s1)           ## 00000152
/* 00B4C 80A0726C 862E0158 */  lh      $t6, 0x0158($s1)           ## 00000158
/* 00B50 80A07270 25CF0001 */  addiu   $t7, $t6, 0x0001           ## $t7 = 00000001
/* 00B54 80A07274 A62F0158 */  sh      $t7, 0x0158($s1)           ## 00000158
/* 00B58 80A07278 86220152 */  lh      $v0, 0x0152($s1)           ## 00000152
.L80A0727C:
/* 00B5C 80A0727C 1000000C */  beq     $zero, $zero, .L80A072B0   
/* 00B60 80A07280 86230150 */  lh      $v1, 0x0150($s1)           ## 00000150
.L80A07284:
/* 00B64 80A07284 3C0480A0 */  lui     $a0, %hi(D_80A077CC)       ## $a0 = 80A00000
/* 00B68 80A07288 0C00084C */  jal     osSyncPrintf
              
/* 00B6C 80A0728C 248477CC */  addiu   $a0, $a0, %lo(D_80A077CC)  ## $a0 = 80A077CC
/* 00B70 80A07290 3C0480A0 */  lui     $a0, %hi(D_80A077FC)       ## $a0 = 80A00000
/* 00B74 80A07294 0C00084C */  jal     osSyncPrintf
              
/* 00B78 80A07298 248477FC */  addiu   $a0, $a0, %lo(D_80A077FC)  ## $a0 = 80A077FC
/* 00B7C 80A0729C 3C0480A0 */  lui     $a0, %hi(D_80A0782C)       ## $a0 = 80A00000
/* 00B80 80A072A0 0C00084C */  jal     osSyncPrintf
              
/* 00B84 80A072A4 2484782C */  addiu   $a0, $a0, %lo(D_80A0782C)  ## $a0 = 80A0782C
/* 00B88 80A072A8 1000000A */  beq     $zero, $zero, .L80A072D4   
/* 00B8C 80A072AC 8FBF0074 */  lw      $ra, 0x0074($sp)           
.L80A072B0:
/* 00B90 80A072B0 0043082A */  slt     $at, $v0, $v1              
/* 00B94 80A072B4 50200007 */  beql    $at, $zero, .L80A072D4     
/* 00B98 80A072B8 8FBF0074 */  lw      $ra, 0x0074($sp)           
/* 00B9C 80A072BC 86380158 */  lh      $t8, 0x0158($s1)           ## 00000158
/* 00BA0 80A072C0 86390156 */  lh      $t9, 0x0156($s1)           ## 00000156
/* 00BA4 80A072C4 0319082A */  slt     $at, $t8, $t9              
/* 00BA8 80A072C8 5420FF3C */  bnel    $at, $zero, .L80A06FBC     
/* 00BAC 80A072CC 868C00A4 */  lh      $t4, 0x00A4($s4)           ## 000000A4
.L80A072D0:
/* 00BB0 80A072D0 8FBF0074 */  lw      $ra, 0x0074($sp)           
.L80A072D4:
/* 00BB4 80A072D4 D7B40038 */  ldc1    $f20, 0x0038($sp)          
/* 00BB8 80A072D8 D7B60040 */  ldc1    $f22, 0x0040($sp)          
/* 00BBC 80A072DC D7B80048 */  ldc1    $f24, 0x0048($sp)          
/* 00BC0 80A072E0 D7BA0050 */  ldc1    $f26, 0x0050($sp)          
/* 00BC4 80A072E4 8FB00058 */  lw      $s0, 0x0058($sp)           
/* 00BC8 80A072E8 8FB1005C */  lw      $s1, 0x005C($sp)           
/* 00BCC 80A072EC 8FB20060 */  lw      $s2, 0x0060($sp)           
/* 00BD0 80A072F0 8FB30064 */  lw      $s3, 0x0064($sp)           
/* 00BD4 80A072F4 8FB40068 */  lw      $s4, 0x0068($sp)           
/* 00BD8 80A072F8 8FB5006C */  lw      $s5, 0x006C($sp)           
/* 00BDC 80A072FC 8FB60070 */  lw      $s6, 0x0070($sp)           
/* 00BE0 80A07300 03E00008 */  jr      $ra                        
/* 00BE4 80A07304 27BD00B8 */  addiu   $sp, $sp, 0x00B8           ## $sp = 00000000
