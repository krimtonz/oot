glabel func_8080BE84
/* 08144 8080BE84 3C0E8016 */  lui     $t6, 0x8016                ## $t6 = 80160000
/* 08148 8080BE88 8DCEFA90 */  lw      $t6, -0x0570($t6)          ## 8015FA90
/* 0814C 8080BE8C 3C01439D */  lui     $at, 0x439D                ## $at = 439D0000
/* 08150 8080BE90 44810000 */  mtc1    $at, $f0                   ## $f0 = 314.00
/* 08154 8080BE94 85CF0F34 */  lh      $t7, 0x0F34($t6)           ## 80160F34
/* 08158 8080BE98 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 0815C 8080BE9C 34218000 */  ori     $at, $at, 0x8000           ## $at = 00018000
/* 08160 8080BEA0 448F3000 */  mtc1    $t7, $f6                   ## $f6 = 0.00
/* 08164 8080BEA4 00811021 */  addu    $v0, $a0, $at              
/* 08168 8080BEA8 C4444AC4 */  lwc1    $f4, 0x4AC4($v0)           ## 00004AC4
/* 0816C 8080BEAC 46803220 */  cvt.s.w $f8, $f6                   
/* 08170 8080BEB0 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 08174 8080BEB4 00240821 */  addu    $at, $at, $a0              
/* 08178 8080BEB8 24180022 */  addiu   $t8, $zero, 0x0022         ## $t8 = 00000022
/* 0817C 8080BEBC 46082280 */  add.s   $f10, $f4, $f8             
/* 08180 8080BEC0 E42ACAC4 */  swc1    $f10, -0x353C($at)         ## 0001CAC4
/* 08184 8080BEC4 C4504AC4 */  lwc1    $f16, 0x4AC4($v0)          ## 00004AC4
/* 08188 8080BEC8 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 0818C 8080BECC 00240821 */  addu    $at, $at, $a0              
/* 08190 8080BED0 4610003E */  c.le.s  $f0, $f16                  
/* 08194 8080BED4 00000000 */  nop
/* 08198 8080BED8 45000005 */  bc1f    .L8080BEF0                 
/* 0819C 8080BEDC 00000000 */  nop
/* 081A0 8080BEE0 E420CAC4 */  swc1    $f0, -0x353C($at)          ## 0001CAC4
/* 081A4 8080BEE4 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 081A8 8080BEE8 00240821 */  addu    $at, $at, $a0              
/* 081AC 8080BEEC A438CA3E */  sh      $t8, -0x35C2($at)          ## 0001CA3E
.L8080BEF0:
/* 081B0 8080BEF0 03E00008 */  jr      $ra                        
/* 081B4 8080BEF4 00000000 */  nop
