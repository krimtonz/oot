glabel func_8084E604
/* 1C3F4 8084E604 27BDFFC0 */  addiu   $sp, $sp, 0xFFC0           ## $sp = FFFFFFC0
/* 1C3F8 8084E608 AFB00030 */  sw      $s0, 0x0030($sp)           
/* 1C3FC 8084E60C 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 1C400 8084E610 AFBF0034 */  sw      $ra, 0x0034($sp)           
/* 1C404 8084E614 AFA50044 */  sw      $a1, 0x0044($sp)           
/* 1C408 8084E618 260601B4 */  addiu   $a2, $s0, 0x01B4           ## $a2 = 000001B4
/* 1C40C 8084E61C 00A02025 */  or      $a0, $a1, $zero            ## $a0 = 00000000
/* 1C410 8084E620 00C02825 */  or      $a1, $a2, $zero            ## $a1 = 000001B4
/* 1C414 8084E624 0C028EF0 */  jal     func_800A3BC0              
/* 1C418 8084E628 AFA6003C */  sw      $a2, 0x003C($sp)           
/* 1C41C 8084E62C 10400008 */  beq     $v0, $zero, .L8084E650     
/* 1C420 8084E630 8FA6003C */  lw      $a2, 0x003C($sp)           
/* 1C424 8084E634 3C050400 */  lui     $a1, 0x0400                ## $a1 = 04000000
/* 1C428 8084E638 24A53050 */  addiu   $a1, $a1, 0x3050           ## $a1 = 04003050
/* 1C42C 8084E63C 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1C430 8084E640 0C20E826 */  jal     func_8083A098              
/* 1C434 8084E644 8FA60044 */  lw      $a2, 0x0044($sp)           
/* 1C438 8084E648 1000001B */  beq     $zero, $zero, .L8084E6B8   
/* 1C43C 8084E64C 00000000 */  nop
.L8084E650:
/* 1C440 8084E650 00C02025 */  or      $a0, $a2, $zero            ## $a0 = 00000000
/* 1C444 8084E654 0C02914C */  jal     SkelAnime_PastFrameTestUpdRate              
/* 1C448 8084E658 3C054040 */  lui     $a1, 0x4040                ## $a1 = 40400000
/* 1C44C 8084E65C 10400016 */  beq     $v0, $zero, .L8084E6B8     
/* 1C450 8084E660 24040001 */  addiu   $a0, $zero, 0x0001         ## $a0 = 00000001
/* 1C454 8084E664 0C021CCC */  jal     Inventory_ChangeAmmo              
/* 1C458 8084E668 2405FFFF */  addiu   $a1, $zero, 0xFFFF         ## $a1 = FFFFFFFF
/* 1C45C 8084E66C C60409C0 */  lwc1    $f4, 0x09C0($s0)           ## 000009C0
/* 1C460 8084E670 8E0709BC */  lw      $a3, 0x09BC($s0)           ## 000009BC
/* 1C464 8084E674 240E0FA0 */  addiu   $t6, $zero, 0x0FA0         ## $t6 = 00000FA0
/* 1C468 8084E678 E7A40010 */  swc1    $f4, 0x0010($sp)           
/* 1C46C 8084E67C C60609C4 */  lwc1    $f6, 0x09C4($s0)           ## 000009C4
/* 1C470 8084E680 AFAE0018 */  sw      $t6, 0x0018($sp)           
/* 1C474 8084E684 8FA50044 */  lw      $a1, 0x0044($sp)           
/* 1C478 8084E688 E7A60014 */  swc1    $f6, 0x0014($sp)           
/* 1C47C 8084E68C 860F00B6 */  lh      $t7, 0x00B6($s0)           ## 000000B6
/* 1C480 8084E690 2418000A */  addiu   $t8, $zero, 0x000A         ## $t8 = 0000000A
/* 1C484 8084E694 AFB80024 */  sw      $t8, 0x0024($sp)           
/* 1C488 8084E698 AFA00020 */  sw      $zero, 0x0020($sp)         
/* 1C48C 8084E69C 24060016 */  addiu   $a2, $zero, 0x0016         ## $a2 = 00000016
/* 1C490 8084E6A0 24A41C24 */  addiu   $a0, $a1, 0x1C24           ## $a0 = 00001C24
/* 1C494 8084E6A4 0C00C7D4 */  jal     Actor_Spawn
              ## ActorSpawn
/* 1C498 8084E6A8 AFAF001C */  sw      $t7, 0x001C($sp)           
/* 1C49C 8084E6AC 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1C4A0 8084E6B0 0C20C9A6 */  jal     func_80832698              
/* 1C4A4 8084E6B4 24056800 */  addiu   $a1, $zero, 0x6800         ## $a1 = 00006800
.L8084E6B8:
/* 1C4A8 8084E6B8 0C20DC87 */  jal     func_8083721C              
/* 1C4AC 8084E6BC 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 1C4B0 8084E6C0 8FBF0034 */  lw      $ra, 0x0034($sp)           
/* 1C4B4 8084E6C4 8FB00030 */  lw      $s0, 0x0030($sp)           
/* 1C4B8 8084E6C8 27BD0040 */  addiu   $sp, $sp, 0x0040           ## $sp = 00000000
/* 1C4BC 8084E6CC 03E00008 */  jr      $ra                        
/* 1C4C0 8084E6D0 00000000 */  nop
