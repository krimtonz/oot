glabel func_8080B40C
/* 076CC 8080B40C 27BDFFE8 */  addiu   $sp, $sp, 0xFFE8           ## $sp = FFFFFFE8
/* 076D0 8080B410 AFBF0014 */  sw      $ra, 0x0014($sp)           
/* 076D4 8080B414 0C202C8B */  jal     func_8080B22C              
/* 076D8 8080B418 AFA40018 */  sw      $a0, 0x0018($sp)           
/* 076DC 8080B41C 3C038081 */  lui     $v1, %hi(D_80812724)       ## $v1 = 80810000
/* 076E0 8080B420 24632724 */  addiu   $v1, $v1, %lo(D_80812724)  ## $v1 = 80812724
/* 076E4 8080B424 846E0000 */  lh      $t6, 0x0000($v1)           ## 80812724
/* 076E8 8080B428 8FA40018 */  lw      $a0, 0x0018($sp)           
/* 076EC 8080B42C 3C010001 */  lui     $at, 0x0001                ## $at = 00010000
/* 076F0 8080B430 34218000 */  ori     $at, $at, 0x8000           ## $at = 00018000
/* 076F4 8080B434 25CFFFD8 */  addiu   $t7, $t6, 0xFFD8           ## $t7 = FFFFFFD8
/* 076F8 8080B438 A46F0000 */  sh      $t7, 0x0000($v1)           ## 80812724
/* 076FC 8080B43C 00811021 */  addu    $v0, $a0, $at              
/* 07700 8080B440 84584AC0 */  lh      $t8, 0x4AC0($v0)           ## 00004AC0
/* 07704 8080B444 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 07708 8080B448 00240821 */  addu    $at, $at, $a0              
/* 0770C 8080B44C 2719FFEC */  addiu   $t9, $t8, 0xFFEC           ## $t9 = FFFFFFEC
/* 07710 8080B450 A439CAC0 */  sh      $t9, -0x3540($at)          ## 0001CAC0
/* 07714 8080B454 84484AC0 */  lh      $t0, 0x4AC0($v0)           ## 00004AC0
/* 07718 8080B458 2409FFA2 */  addiu   $t1, $zero, 0xFFA2         ## $t1 = FFFFFFA2
/* 0771C 8080B45C 240A0001 */  addiu   $t2, $zero, 0x0001         ## $t2 = 00000001
/* 07720 8080B460 2901FFA3 */  slti    $at, $t0, 0xFFA3           
/* 07724 8080B464 10200007 */  beq     $at, $zero, .L8080B484     
/* 07728 8080B468 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 0772C 8080B46C 00240821 */  addu    $at, $at, $a0              
/* 07730 8080B470 A429CAC0 */  sh      $t1, -0x3540($at)          ## 0001CAC0
/* 07734 8080B474 3C010002 */  lui     $at, 0x0002                ## $at = 00020000
/* 07738 8080B478 00240821 */  addu    $at, $at, $a0              
/* 0773C 8080B47C A42ACA3E */  sh      $t2, -0x35C2($at)          ## 0001CA3E
/* 07740 8080B480 A4600000 */  sh      $zero, 0x0000($v1)         ## 80812724
.L8080B484:
/* 07744 8080B484 8FBF0014 */  lw      $ra, 0x0014($sp)           
/* 07748 8080B488 27BD0018 */  addiu   $sp, $sp, 0x0018           ## $sp = 00000000
/* 0774C 8080B48C 03E00008 */  jr      $ra                        
/* 07750 8080B490 00000000 */  nop
