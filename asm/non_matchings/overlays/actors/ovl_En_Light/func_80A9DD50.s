glabel func_80A9DD50
/* 00210 80A9DD50 27BDFFE8 */  addiu   $sp, $sp, 0xFFE8           ## $sp = FFFFFFE8
/* 00214 80A9DD54 AFBF0014 */  sw      $ra, 0x0014($sp)           
/* 00218 80A9DD58 84AE07A0 */  lh      $t6, 0x07A0($a1)           ## 000007A0
/* 0021C 80A9DD5C 00803025 */  or      $a2, $a0, $zero            ## $a2 = 00000000
/* 00220 80A9DD60 000E7880 */  sll     $t7, $t6,  2               
/* 00224 80A9DD64 00AFC021 */  addu    $t8, $a1, $t7              
/* 00228 80A9DD68 8F040790 */  lw      $a0, 0x0790($t8)           ## 00000790
/* 0022C 80A9DD6C 0C016A7D */  jal     Camera_GetRealDirYaw              
/* 00230 80A9DD70 AFA60018 */  sw      $a2, 0x0018($sp)           
/* 00234 80A9DD74 8FA60018 */  lw      $a2, 0x0018($sp)           
/* 00238 80A9DD78 34018000 */  ori     $at, $zero, 0x8000         ## $at = 00008000
/* 0023C 80A9DD7C 0041C821 */  addu    $t9, $v0, $at              
/* 00240 80A9DD80 8CC30118 */  lw      $v1, 0x0118($a2)           ## 00000118
/* 00244 80A9DD84 A4D900B6 */  sh      $t9, 0x00B6($a2)           ## 000000B6
/* 00248 80A9DD88 24C40024 */  addiu   $a0, $a2, 0x0024           ## $a0 = 00000024
/* 0024C 80A9DD8C 10600009 */  beq     $v1, $zero, .L80A9DDB4     
/* 00250 80A9DD90 24650024 */  addiu   $a1, $v1, 0x0024           ## $a1 = 00000024
/* 00254 80A9DD94 0C01DF90 */  jal     Math_Vec3f_Copy
              ## Vec3f_Copy
/* 00258 80A9DD98 AFA60018 */  sw      $a2, 0x0018($sp)           
/* 0025C 80A9DD9C 8FA60018 */  lw      $a2, 0x0018($sp)           
/* 00260 80A9DDA0 3C014188 */  lui     $at, 0x4188                ## $at = 41880000
/* 00264 80A9DDA4 44813000 */  mtc1    $at, $f6                   ## $f6 = 17.00
/* 00268 80A9DDA8 C4C40028 */  lwc1    $f4, 0x0028($a2)           ## 00000028
/* 0026C 80A9DDAC 46062200 */  add.s   $f8, $f4, $f6              
/* 00270 80A9DDB0 E4C80028 */  swc1    $f8, 0x0028($a2)           ## 00000028
.L80A9DDB4:
/* 00274 80A9DDB4 90C8014C */  lbu     $t0, 0x014C($a2)           ## 0000014C
/* 00278 80A9DDB8 25090001 */  addiu   $t1, $t0, 0x0001           ## $t1 = 00000001
/* 0027C 80A9DDBC A0C9014C */  sb      $t1, 0x014C($a2)           ## 0000014C
/* 00280 80A9DDC0 8FBF0014 */  lw      $ra, 0x0014($sp)           
/* 00284 80A9DDC4 27BD0018 */  addiu   $sp, $sp, 0x0018           ## $sp = 00000000
/* 00288 80A9DDC8 03E00008 */  jr      $ra                        
/* 0028C 80A9DDCC 00000000 */  nop
