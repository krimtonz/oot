.rdata
glabel D_8090D944
    .asciz "../z_boss_ganon2.c"
    .balign 4

glabel D_8090D958
    .asciz "../z_boss_ganon2.c"
    .balign 4

glabel D_8090D96C
    .asciz "../z_boss_ganon2.c"
    .balign 4

.text
glabel func_80905508
/* 085C8 80905508 3C0E8090 */  lui     $t6, %hi(D_80907144)       ## $t6 = 80900000
/* 085CC 8090550C 25CE7144 */  addiu   $t6, $t6, %lo(D_80907144)  ## $t6 = 80907144
/* 085D0 80905510 00AE1021 */  addu    $v0, $a1, $t6              
/* 085D4 80905514 80430000 */  lb      $v1, 0x0000($v0)           ## 00000000
/* 085D8 80905518 27BDFFC0 */  addiu   $sp, $sp, 0xFFC0           ## $sp = FFFFFFC0
/* 085DC 8090551C AFBF0014 */  sw      $ra, 0x0014($sp)           
/* 085E0 80905520 AFA40040 */  sw      $a0, 0x0040($sp)           
/* 085E4 80905524 AFA60048 */  sw      $a2, 0x0048($sp)           
/* 085E8 80905528 0460000C */  bltz    $v1, .L8090555C            
/* 085EC 8090552C AFA7004C */  sw      $a3, 0x004C($sp)           
/* 085F0 80905530 8FAF0050 */  lw      $t7, 0x0050($sp)           
/* 085F4 80905534 0003C080 */  sll     $t8, $v1,  2               
/* 085F8 80905538 0303C023 */  subu    $t8, $t8, $v1              
/* 085FC 8090553C 0018C080 */  sll     $t8, $t8,  2               
/* 08600 80905540 3C048090 */  lui     $a0, %hi(D_80906D60)       ## $a0 = 80900000
/* 08604 80905544 01F82821 */  addu    $a1, $t7, $t8              
/* 08608 80905548 24A50234 */  addiu   $a1, $a1, 0x0234           ## $a1 = 00000234
/* 0860C 8090554C 24846D60 */  addiu   $a0, $a0, %lo(D_80906D60)  ## $a0 = 80906D60
/* 08610 80905550 0C0346BD */  jal     Matrix_MultVec3f              
/* 08614 80905554 AFA20018 */  sw      $v0, 0x0018($sp)           
/* 08618 80905558 8FA20018 */  lw      $v0, 0x0018($sp)           
.L8090555C:
/* 0861C 8090555C 3C198090 */  lui     $t9, %hi(D_8090714F)       ## $t9 = 80900000
/* 08620 80905560 2739714F */  addiu   $t9, $t9, %lo(D_8090714F)  ## $t9 = 8090714F
/* 08624 80905564 14590038 */  bne     $v0, $t9, .L80905648       
/* 08628 80905568 3C0E8090 */  lui     $t6, %hi(D_8090714E)       ## $t6 = 80900000
/* 0862C 8090556C 8FA90040 */  lw      $t1, 0x0040($sp)           
/* 08630 80905570 3C068091 */  lui     $a2, %hi(D_8090D944)       ## $a2 = 80910000
/* 08634 80905574 24C6D944 */  addiu   $a2, $a2, %lo(D_8090D944)  ## $a2 = 8090D944
/* 08638 80905578 8D250000 */  lw      $a1, 0x0000($t1)           ## 00000000
/* 0863C 8090557C 27A40024 */  addiu   $a0, $sp, 0x0024           ## $a0 = FFFFFFE4
/* 08640 80905580 24071675 */  addiu   $a3, $zero, 0x1675         ## $a3 = 00001675
/* 08644 80905584 0C031AB1 */  jal     Graph_OpenDisps              
/* 08648 80905588 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 0864C 8090558C 8FA80034 */  lw      $t0, 0x0034($sp)           
/* 08650 80905590 3C0BDA38 */  lui     $t3, 0xDA38                ## $t3 = DA380000
/* 08654 80905594 356B0003 */  ori     $t3, $t3, 0x0003           ## $t3 = DA380003
/* 08658 80905598 8D0202D0 */  lw      $v0, 0x02D0($t0)           ## 000002D0
/* 0865C 8090559C 3C058091 */  lui     $a1, %hi(D_8090D958)       ## $a1 = 80910000
/* 08660 809055A0 24A5D958 */  addiu   $a1, $a1, %lo(D_8090D958)  ## $a1 = 8090D958
/* 08664 809055A4 244A0008 */  addiu   $t2, $v0, 0x0008           ## $t2 = 00000008
/* 08668 809055A8 AD0A02D0 */  sw      $t2, 0x02D0($t0)           ## 000002D0
/* 0866C 809055AC AC4B0000 */  sw      $t3, 0x0000($v0)           ## 00000000
/* 08670 809055B0 8FAC0040 */  lw      $t4, 0x0040($sp)           
/* 08674 809055B4 24061678 */  addiu   $a2, $zero, 0x1678         ## $a2 = 00001678
/* 08678 809055B8 8D840000 */  lw      $a0, 0x0000($t4)           ## 00000000
/* 0867C 809055BC AFA80034 */  sw      $t0, 0x0034($sp)           
/* 08680 809055C0 0C0346A2 */  jal     Matrix_NewMtx              
/* 08684 809055C4 AFA20020 */  sw      $v0, 0x0020($sp)           
/* 08688 809055C8 8FA30020 */  lw      $v1, 0x0020($sp)           
/* 0868C 809055CC 8FA80034 */  lw      $t0, 0x0034($sp)           
/* 08690 809055D0 3C040601 */  lui     $a0, 0x0601                ## $a0 = 06010000
/* 08694 809055D4 AC620004 */  sw      $v0, 0x0004($v1)           ## 00000004
/* 08698 809055D8 8D0202D0 */  lw      $v0, 0x02D0($t0)           ## 000002D0
/* 0869C 809055DC 2484BE90 */  addiu   $a0, $a0, 0xBE90           ## $a0 = 0600BE90
/* 086A0 809055E0 00047900 */  sll     $t7, $a0,  4               
/* 086A4 809055E4 000FC702 */  srl     $t8, $t7, 28               
/* 086A8 809055E8 244D0008 */  addiu   $t5, $v0, 0x0008           ## $t5 = 00000008
/* 086AC 809055EC 0018C880 */  sll     $t9, $t8,  2               
/* 086B0 809055F0 3C0EDE00 */  lui     $t6, 0xDE00                ## $t6 = DE000000
/* 086B4 809055F4 3C098016 */  lui     $t1, 0x8016                ## $t1 = 80160000
/* 086B8 809055F8 AD0D02D0 */  sw      $t5, 0x02D0($t0)           ## 000002D0
/* 086BC 809055FC 01394821 */  addu    $t1, $t1, $t9              
/* 086C0 80905600 3C0100FF */  lui     $at, 0x00FF                ## $at = 00FF0000
/* 086C4 80905604 AC4E0000 */  sw      $t6, 0x0000($v0)           ## 00000000
/* 086C8 80905608 8D296FA8 */  lw      $t1, 0x6FA8($t1)           ## 80166FA8
/* 086CC 8090560C 3421FFFF */  ori     $at, $at, 0xFFFF           ## $at = 00FFFFFF
/* 086D0 80905610 00815024 */  and     $t2, $a0, $at              
/* 086D4 80905614 3C018000 */  lui     $at, 0x8000                ## $at = 80000000
/* 086D8 80905618 012A5821 */  addu    $t3, $t1, $t2              
/* 086DC 8090561C 01616021 */  addu    $t4, $t3, $at              
/* 086E0 80905620 AC4C0004 */  sw      $t4, 0x0004($v0)           ## 00000004
/* 086E4 80905624 8FAD0040 */  lw      $t5, 0x0040($sp)           
/* 086E8 80905628 3C068091 */  lui     $a2, %hi(D_8090D96C)       ## $a2 = 80910000
/* 086EC 8090562C 24C6D96C */  addiu   $a2, $a2, %lo(D_8090D96C)  ## $a2 = 8090D96C
/* 086F0 80905630 27A40024 */  addiu   $a0, $sp, 0x0024           ## $a0 = FFFFFFE4
/* 086F4 80905634 2407167A */  addiu   $a3, $zero, 0x167A         ## $a3 = 0000167A
/* 086F8 80905638 0C031AD5 */  jal     Graph_CloseDisps              
/* 086FC 8090563C 8DA50000 */  lw      $a1, 0x0000($t5)           ## 00000008
/* 08700 80905640 10000009 */  beq     $zero, $zero, .L80905668   
/* 08704 80905644 8FBF0014 */  lw      $ra, 0x0014($sp)           
.L80905648:
/* 08708 80905648 25CE714E */  addiu   $t6, $t6, %lo(D_8090714E)  ## $t6 = 0000714E
/* 0870C 8090564C 144E0005 */  bne     $v0, $t6, .L80905664       
/* 08710 80905650 3C048090 */  lui     $a0, %hi(D_80907164)       ## $a0 = 80900000
/* 08714 80905654 8FA50050 */  lw      $a1, 0x0050($sp)           
/* 08718 80905658 24847164 */  addiu   $a0, $a0, %lo(D_80907164)  ## $a0 = 80907164
/* 0871C 8090565C 0C0346BD */  jal     Matrix_MultVec3f              
/* 08720 80905660 24A501B8 */  addiu   $a1, $a1, 0x01B8           ## $a1 = 000001B8
.L80905664:
/* 08724 80905664 8FBF0014 */  lw      $ra, 0x0014($sp)           
.L80905668:
/* 08728 80905668 27BD0040 */  addiu   $sp, $sp, 0x0040           ## $sp = 00000000
/* 0872C 8090566C 03E00008 */  jr      $ra                        
/* 08730 80905670 00000000 */  nop
