glabel func_809AE270
/* 00350 809AE270 27BDFF70 */  addiu   $sp, $sp, 0xFF70           ## $sp = FFFFFF70
/* 00354 809AE274 F7BA0040 */  sdc1    $f26, 0x0040($sp)          
/* 00358 809AE278 3C0E809B */  lui     $t6, %hi(D_809B0054)       ## $t6 = 809B0000
/* 0035C 809AE27C AFBF006C */  sw      $ra, 0x006C($sp)           
/* 00360 809AE280 AFB70068 */  sw      $s7, 0x0068($sp)           
/* 00364 809AE284 AFB60064 */  sw      $s6, 0x0064($sp)           
/* 00368 809AE288 AFB50060 */  sw      $s5, 0x0060($sp)           
/* 0036C 809AE28C AFB4005C */  sw      $s4, 0x005C($sp)           
/* 00370 809AE290 AFB30058 */  sw      $s3, 0x0058($sp)           
/* 00374 809AE294 AFB20054 */  sw      $s2, 0x0054($sp)           
/* 00378 809AE298 AFB10050 */  sw      $s1, 0x0050($sp)           
/* 0037C 809AE29C AFB0004C */  sw      $s0, 0x004C($sp)           
/* 00380 809AE2A0 F7B80038 */  sdc1    $f24, 0x0038($sp)          
/* 00384 809AE2A4 F7B60030 */  sdc1    $f22, 0x0030($sp)          
/* 00388 809AE2A8 F7B40028 */  sdc1    $f20, 0x0028($sp)          
/* 0038C 809AE2AC 25CE0054 */  addiu   $t6, $t6, %lo(D_809B0054)  ## $t6 = 809B0054
/* 00390 809AE2B0 3C014220 */  lui     $at, 0x4220                ## $at = 42200000
/* 00394 809AE2B4 8DD80000 */  lw      $t8, 0x0000($t6)           ## 809B0054
/* 00398 809AE2B8 4481D000 */  mtc1    $at, $f26                  ## $f26 = 40.00
/* 0039C 809AE2BC 3C014120 */  lui     $at, 0x4120                ## $at = 41200000
/* 003A0 809AE2C0 27B6007C */  addiu   $s6, $sp, 0x007C           ## $s6 = FFFFFFEC
/* 003A4 809AE2C4 3C19809B */  lui     $t9, %hi(D_809B0058)       ## $t9 = 809B0000
/* 003A8 809AE2C8 4481C000 */  mtc1    $at, $f24                  ## $f24 = 10.00
/* 003AC 809AE2CC 27390058 */  addiu   $t9, $t9, %lo(D_809B0058)  ## $t9 = 809B0058
/* 003B0 809AE2D0 3C014282 */  lui     $at, 0x4282                ## $at = 42820000
/* 003B4 809AE2D4 AED80000 */  sw      $t8, 0x0000($s6)           ## FFFFFFEC
/* 003B8 809AE2D8 8F290000 */  lw      $t1, 0x0000($t9)           ## 809B0058
/* 003BC 809AE2DC 4481B000 */  mtc1    $at, $f22                  ## $f22 = 65.00
/* 003C0 809AE2E0 3C013F00 */  lui     $at, 0x3F00                ## $at = 3F000000
/* 003C4 809AE2E4 27B70078 */  addiu   $s7, $sp, 0x0078           ## $s7 = FFFFFFE8
/* 003C8 809AE2E8 3C13809B */  lui     $s3, %hi(D_809B005C)       ## $s3 = 809B0000
/* 003CC 809AE2EC 3C14809B */  lui     $s4, %hi(D_809B0068)       ## $s4 = 809B0000
/* 003D0 809AE2F0 4481A000 */  mtc1    $at, $f20                  ## $f20 = 0.50
/* 003D4 809AE2F4 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 003D8 809AE2F8 00A0A825 */  or      $s5, $a1, $zero            ## $s5 = 00000000
/* 003DC 809AE2FC 26940068 */  addiu   $s4, $s4, %lo(D_809B0068)  ## $s4 = 809B0068
/* 003E0 809AE300 2673005C */  addiu   $s3, $s3, %lo(D_809B005C)  ## $s3 = 809B005C
/* 003E4 809AE304 24110004 */  addiu   $s1, $zero, 0x0004         ## $s1 = 00000004
/* 003E8 809AE308 27B20080 */  addiu   $s2, $sp, 0x0080           ## $s2 = FFFFFFF0
/* 003EC 809AE30C AEE90000 */  sw      $t1, 0x0000($s7)           ## FFFFFFE8
.L809AE310:
/* 003F0 809AE310 0C03F66B */  jal     Rand_ZeroOne
              ## Rand.Next() float
/* 003F4 809AE314 00000000 */  nop
/* 003F8 809AE318 46140101 */  sub.s   $f4, $f0, $f20             
/* 003FC 809AE31C C6080024 */  lwc1    $f8, 0x0024($s0)           ## 00000024
/* 00400 809AE320 46162182 */  mul.s   $f6, $f4, $f22             
/* 00404 809AE324 46083280 */  add.s   $f10, $f6, $f8             
/* 00408 809AE328 0C03F66B */  jal     Rand_ZeroOne
              ## Rand.Next() float
/* 0040C 809AE32C E7AA0080 */  swc1    $f10, 0x0080($sp)          
/* 00410 809AE330 46140401 */  sub.s   $f16, $f0, $f20            
/* 00414 809AE334 C6040028 */  lwc1    $f4, 0x0028($s0)           ## 00000028
/* 00418 809AE338 46188482 */  mul.s   $f18, $f16, $f24           
/* 0041C 809AE33C 461A2180 */  add.s   $f6, $f4, $f26             
/* 00420 809AE340 46069200 */  add.s   $f8, $f18, $f6             
/* 00424 809AE344 0C03F66B */  jal     Rand_ZeroOne
              ## Rand.Next() float
/* 00428 809AE348 E7A80084 */  swc1    $f8, 0x0084($sp)           
/* 0042C 809AE34C 46140281 */  sub.s   $f10, $f0, $f20            
/* 00430 809AE350 C604002C */  lwc1    $f4, 0x002C($s0)           ## 0000002C
/* 00434 809AE354 AFB70014 */  sw      $s7, 0x0014($sp)           
/* 00438 809AE358 AFB60010 */  sw      $s6, 0x0010($sp)           
/* 0043C 809AE35C 46165402 */  mul.s   $f16, $f10, $f22           
/* 00440 809AE360 02A02025 */  or      $a0, $s5, $zero            ## $a0 = 00000000
/* 00444 809AE364 02402825 */  or      $a1, $s2, $zero            ## $a1 = FFFFFFF0
/* 00448 809AE368 02603025 */  or      $a2, $s3, $zero            ## $a2 = 809B005C
/* 0044C 809AE36C 02803825 */  or      $a3, $s4, $zero            ## $a3 = 809B0068
/* 00450 809AE370 46048480 */  add.s   $f18, $f16, $f4            
/* 00454 809AE374 0C00A2DD */  jal     EffectSsKiraKira_SpawnSmall              
/* 00458 809AE378 E7B20088 */  swc1    $f18, 0x0088($sp)          
/* 0045C 809AE37C 2631FFFF */  addiu   $s1, $s1, 0xFFFF           ## $s1 = 00000003
/* 00460 809AE380 1620FFE3 */  bne     $s1, $zero, .L809AE310     
/* 00464 809AE384 00000000 */  nop
/* 00468 809AE388 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 0046C 809AE38C 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 00470 809AE390 24053844 */  addiu   $a1, $zero, 0x3844         ## $a1 = 00003844
/* 00474 809AE394 3C014100 */  lui     $at, 0x4100                ## $at = 41000000
/* 00478 809AE398 44813000 */  mtc1    $at, $f6                   ## $f6 = 8.00
/* 0047C 809AE39C 240A0003 */  addiu   $t2, $zero, 0x0003         ## $t2 = 00000003
/* 00480 809AE3A0 240B012C */  addiu   $t3, $zero, 0x012C         ## $t3 = 0000012C
/* 00484 809AE3A4 240C000F */  addiu   $t4, $zero, 0x000F         ## $t4 = 0000000F
/* 00488 809AE3A8 AFAC001C */  sw      $t4, 0x001C($sp)           
/* 0048C 809AE3AC AFAB0018 */  sw      $t3, 0x0018($sp)           
/* 00490 809AE3B0 AFAA0010 */  sw      $t2, 0x0010($sp)           
/* 00494 809AE3B4 02A02025 */  or      $a0, $s5, $zero            ## $a0 = 00000000
/* 00498 809AE3B8 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 0049C 809AE3BC 26060024 */  addiu   $a2, $s0, 0x0024           ## $a2 = 00000024
/* 004A0 809AE3C0 3C074080 */  lui     $a3, 0x4080                ## $a3 = 40800000
/* 004A4 809AE3C4 AFA00020 */  sw      $zero, 0x0020($sp)         
/* 004A8 809AE3C8 0C00CC98 */  jal     func_80033260              
/* 004AC 809AE3CC E7A60014 */  swc1    $f6, 0x0014($sp)           
/* 004B0 809AE3D0 8FBF006C */  lw      $ra, 0x006C($sp)           
/* 004B4 809AE3D4 D7B40028 */  ldc1    $f20, 0x0028($sp)          
/* 004B8 809AE3D8 D7B60030 */  ldc1    $f22, 0x0030($sp)          
/* 004BC 809AE3DC D7B80038 */  ldc1    $f24, 0x0038($sp)          
/* 004C0 809AE3E0 D7BA0040 */  ldc1    $f26, 0x0040($sp)          
/* 004C4 809AE3E4 8FB0004C */  lw      $s0, 0x004C($sp)           
/* 004C8 809AE3E8 8FB10050 */  lw      $s1, 0x0050($sp)           
/* 004CC 809AE3EC 8FB20054 */  lw      $s2, 0x0054($sp)           
/* 004D0 809AE3F0 8FB30058 */  lw      $s3, 0x0058($sp)           
/* 004D4 809AE3F4 8FB4005C */  lw      $s4, 0x005C($sp)           
/* 004D8 809AE3F8 8FB50060 */  lw      $s5, 0x0060($sp)           
/* 004DC 809AE3FC 8FB60064 */  lw      $s6, 0x0064($sp)           
/* 004E0 809AE400 8FB70068 */  lw      $s7, 0x0068($sp)           
/* 004E4 809AE404 03E00008 */  jr      $ra                        
/* 004E8 809AE408 27BD0090 */  addiu   $sp, $sp, 0x0090           ## $sp = 00000000
