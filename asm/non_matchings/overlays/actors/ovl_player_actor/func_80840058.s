glabel func_80840058
/* 0DE48 80840058 27BDFFE8 */  addiu   $sp, $sp, 0xFFE8           ## $sp = FFFFFFE8
/* 0DE4C 8084005C AFBF0014 */  sw      $ra, 0x0014($sp)           
/* 0DE50 80840060 AFA5001C */  sw      $a1, 0x001C($sp)           
/* 0DE54 80840064 AFA40018 */  sw      $a0, 0x0018($sp)           
/* 0DE58 80840068 AFA60020 */  sw      $a2, 0x0020($sp)           
/* 0DE5C 8084006C 00E02825 */  or      $a1, $a3, $zero            ## $a1 = 00000000
/* 0DE60 80840070 0C20F715 */  jal     func_8083DC54              
/* 0DE64 80840074 AFA70024 */  sw      $a3, 0x0024($sp)           
/* 0DE68 80840078 8FAE001C */  lw      $t6, 0x001C($sp)           
/* 0DE6C 8084007C 44802000 */  mtc1    $zero, $f4                 ## $f4 = 0.00
/* 0DE70 80840080 8FA70024 */  lw      $a3, 0x0024($sp)           
/* 0DE74 80840084 C5C60000 */  lwc1    $f6, 0x0000($t6)           ## 00000000
/* 0DE78 80840088 8FAF0018 */  lw      $t7, 0x0018($sp)           
/* 0DE7C 8084008C 46062032 */  c.eq.s  $f4, $f6                   
/* 0DE80 80840090 00000000 */  nop
/* 0DE84 80840094 4502000A */  bc1fl   .L808400C0                 
/* 0DE88 80840098 84F807A0 */  lh      $t8, 0x07A0($a3)           ## 000007A0
/* 0DE8C 8084009C 85E2087C */  lh      $v0, 0x087C($t7)           ## 0000087C
/* 0DE90 808400A0 04400003 */  bltz    $v0, .L808400B0            
/* 0DE94 808400A4 00021823 */  subu    $v1, $zero, $v0            
/* 0DE98 808400A8 10000001 */  beq     $zero, $zero, .L808400B0   
/* 0DE9C 808400AC 00401825 */  or      $v1, $v0, $zero            ## $v1 = 00000000
.L808400B0:
/* 0DEA0 808400B0 28610191 */  slti    $at, $v1, 0x0191           
/* 0DEA4 808400B4 1420001C */  bne     $at, $zero, .L80840128     
/* 0DEA8 808400B8 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
/* 0DEAC 808400BC 84F807A0 */  lh      $t8, 0x07A0($a3)           ## 000007A0
.L808400C0:
/* 0DEB0 808400C0 0018C880 */  sll     $t9, $t8,  2               
/* 0DEB4 808400C4 00F94021 */  addu    $t0, $a3, $t9              
/* 0DEB8 808400C8 0C016A52 */  jal     Camera_GetDirYaw              
/* 0DEBC 808400CC 8D040790 */  lw      $a0, 0x0790($t0)           ## 00000790
/* 0DEC0 808400D0 8FA90020 */  lw      $t1, 0x0020($sp)           
/* 0DEC4 808400D4 8FAE0018 */  lw      $t6, 0x0018($sp)           
/* 0DEC8 808400D8 852A0000 */  lh      $t2, 0x0000($t1)           ## 00000000
/* 0DECC 808400DC 01422023 */  subu    $a0, $t2, $v0              
/* 0DED0 808400E0 00042400 */  sll     $a0, $a0, 16               
/* 0DED4 808400E4 00042403 */  sra     $a0, $a0, 16               
/* 0DED8 808400E8 04800003 */  bltz    $a0, .L808400F8            
/* 0DEDC 808400EC 00041823 */  subu    $v1, $zero, $a0            
/* 0DEE0 808400F0 10000001 */  beq     $zero, $zero, .L808400F8   
/* 0DEE4 808400F4 00801825 */  or      $v1, $a0, $zero            ## $v1 = 00000000
.L808400F8:
/* 0DEE8 808400F8 246CE000 */  addiu   $t4, $v1, 0xE000           ## $t4 = FFFFE000
/* 0DEEC 808400FC 318DFFFF */  andi    $t5, $t4, 0xFFFF           ## $t5 = 0000E000
/* 0DEF0 80840100 29A14000 */  slti    $at, $t5, 0x4000           
/* 0DEF4 80840104 14200004 */  bne     $at, $zero, .L80840118     
/* 0DEF8 80840108 00000000 */  nop
/* 0DEFC 8084010C 85CF087C */  lh      $t7, 0x087C($t6)           ## 0000087C
/* 0DF00 80840110 11E00003 */  beq     $t7, $zero, .L80840120     
/* 0DF04 80840114 00000000 */  nop
.L80840118:
/* 0DF08 80840118 10000003 */  beq     $zero, $zero, .L80840128   
/* 0DF0C 8084011C 2402FFFF */  addiu   $v0, $zero, 0xFFFF         ## $v0 = FFFFFFFF
.L80840120:
/* 0DF10 80840120 10000001 */  beq     $zero, $zero, .L80840128   
/* 0DF14 80840124 24020001 */  addiu   $v0, $zero, 0x0001         ## $v0 = 00000001
.L80840128:
/* 0DF18 80840128 8FBF0014 */  lw      $ra, 0x0014($sp)           
/* 0DF1C 8084012C 27BD0018 */  addiu   $sp, $sp, 0x0018           ## $sp = 00000000
/* 0DF20 80840130 03E00008 */  jr      $ra                        
/* 0DF24 80840134 00000000 */  nop
