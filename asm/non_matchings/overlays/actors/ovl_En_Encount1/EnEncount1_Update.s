glabel EnEncount1_Update
/* 00BE8 80A07308 27BDFFB8 */  addiu   $sp, $sp, 0xFFB8           ## $sp = FFFFFFB8
/* 00BEC 80A0730C AFBF0044 */  sw      $ra, 0x0044($sp)           
/* 00BF0 80A07310 84820164 */  lh      $v0, 0x0164($a0)           ## 00000164
/* 00BF4 80A07314 10400002 */  beq     $v0, $zero, .L80A07320     
/* 00BF8 80A07318 244EFFFF */  addiu   $t6, $v0, 0xFFFF           ## $t6 = FFFFFFFF
/* 00BFC 80A0731C A48E0164 */  sh      $t6, 0x0164($a0)           ## 00000164
.L80A07320:
/* 00C00 80A07320 AFA40048 */  sw      $a0, 0x0048($sp)           
/* 00C04 80A07324 AFA5004C */  sw      $a1, 0x004C($sp)           
/* 00C08 80A07328 8C99014C */  lw      $t9, 0x014C($a0)           ## 0000014C
/* 00C0C 80A0732C 0320F809 */  jalr    $ra, $t9                   
/* 00C10 80A07330 00000000 */  nop
/* 00C14 80A07334 3C0F8016 */  lui     $t7, 0x8016                ## $t7 = 80160000
/* 00C18 80A07338 8DEFFA90 */  lw      $t7, -0x0570($t7)          ## 8015FA90
/* 00C1C 80A0733C 8FA40048 */  lw      $a0, 0x0048($sp)           
/* 00C20 80A07340 8FA5004C */  lw      $a1, 0x004C($sp)           
/* 00C24 80A07344 85F812D4 */  lh      $t8, 0x12D4($t7)           ## 801612D4
/* 00C28 80A07348 5300003B */  beql    $t8, $zero, .L80A07438     
/* 00C2C 80A0734C 8FBF0044 */  lw      $ra, 0x0044($sp)           
/* 00C30 80A07350 8482015A */  lh      $v0, 0x015A($a0)           ## 0000015A
/* 00C34 80A07354 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 00C38 80A07358 240900FF */  addiu   $t1, $zero, 0x00FF         ## $t1 = 000000FF
/* 00C3C 80A0735C 1040001F */  beq     $v0, $zero, .L80A073DC     
/* 00C40 80A07360 240A00FF */  addiu   $t2, $zero, 0x00FF         ## $t2 = 000000FF
/* 00C44 80A07364 30480001 */  andi    $t0, $v0, 0x0001           ## $t0 = 00000000
/* 00C48 80A07368 15000032 */  bne     $t0, $zero, .L80A07434     
/* 00C4C 80A0736C 3C013F80 */  lui     $at, 0x3F80                ## $at = 3F800000
/* 00C50 80A07370 84890032 */  lh      $t1, 0x0032($a0)           ## 00000032
/* 00C54 80A07374 C48C0024 */  lwc1    $f12, 0x0024($a0)          ## 00000024
/* 00C58 80A07378 C48E0028 */  lwc1    $f14, 0x0028($a0)          ## 00000028
/* 00C5C 80A0737C 8C86002C */  lw      $a2, 0x002C($a0)           ## 0000002C
/* 00C60 80A07380 84870030 */  lh      $a3, 0x0030($a0)           ## 00000030
/* 00C64 80A07384 AFA90010 */  sw      $t1, 0x0010($sp)           
/* 00C68 80A07388 848A0034 */  lh      $t2, 0x0034($a0)           ## 00000034
/* 00C6C 80A0738C 44810000 */  mtc1    $at, $f0                   ## $f0 = 1.00
/* 00C70 80A07390 240B0078 */  addiu   $t3, $zero, 0x0078         ## $t3 = 00000078
/* 00C74 80A07394 240C0078 */  addiu   $t4, $zero, 0x0078         ## $t4 = 00000078
/* 00C78 80A07398 240D0078 */  addiu   $t5, $zero, 0x0078         ## $t5 = 00000078
/* 00C7C 80A0739C 240E00FF */  addiu   $t6, $zero, 0x00FF         ## $t6 = 000000FF
/* 00C80 80A073A0 24190004 */  addiu   $t9, $zero, 0x0004         ## $t9 = 00000004
/* 00C84 80A073A4 AFB90034 */  sw      $t9, 0x0034($sp)           
/* 00C88 80A073A8 AFAE0030 */  sw      $t6, 0x0030($sp)           
/* 00C8C 80A073AC AFAD002C */  sw      $t5, 0x002C($sp)           
/* 00C90 80A073B0 AFAC0028 */  sw      $t4, 0x0028($sp)           
/* 00C94 80A073B4 AFAB0024 */  sw      $t3, 0x0024($sp)           
/* 00C98 80A073B8 AFAA0014 */  sw      $t2, 0x0014($sp)           
/* 00C9C 80A073BC E7A00018 */  swc1    $f0, 0x0018($sp)           
/* 00CA0 80A073C0 E7A0001C */  swc1    $f0, 0x001C($sp)           
/* 00CA4 80A073C4 E7A00020 */  swc1    $f0, 0x0020($sp)           
/* 00CA8 80A073C8 8CAF0000 */  lw      $t7, 0x0000($a1)           ## 00000000
/* 00CAC 80A073CC 0C018FA7 */  jal     DebugDisplay_AddObject
              
/* 00CB0 80A073D0 AFAF0038 */  sw      $t7, 0x0038($sp)           
/* 00CB4 80A073D4 10000018 */  beq     $zero, $zero, .L80A07438   
/* 00CB8 80A073D8 8FBF0044 */  lw      $ra, 0x0044($sp)           
.L80A073DC:
/* 00CBC 80A073DC 84980032 */  lh      $t8, 0x0032($a0)           ## 00000032
/* 00CC0 80A073E0 C48C0024 */  lwc1    $f12, 0x0024($a0)          ## 00000024
/* 00CC4 80A073E4 C48E0028 */  lwc1    $f14, 0x0028($a0)          ## 00000028
/* 00CC8 80A073E8 8C86002C */  lw      $a2, 0x002C($a0)           ## 0000002C
/* 00CCC 80A073EC 84870030 */  lh      $a3, 0x0030($a0)           ## 00000030
/* 00CD0 80A073F0 AFB80010 */  sw      $t8, 0x0010($sp)           
/* 00CD4 80A073F4 84880034 */  lh      $t0, 0x0034($a0)           ## 00000034
/* 00CD8 80A073F8 44810000 */  mtc1    $at, $f0                   ## $f0 = 0.00
/* 00CDC 80A073FC 240B00FF */  addiu   $t3, $zero, 0x00FF         ## $t3 = 000000FF
/* 00CE0 80A07400 240C0004 */  addiu   $t4, $zero, 0x0004         ## $t4 = 00000004
/* 00CE4 80A07404 AFAC0034 */  sw      $t4, 0x0034($sp)           
/* 00CE8 80A07408 AFAB0030 */  sw      $t3, 0x0030($sp)           
/* 00CEC 80A0740C AFAA002C */  sw      $t2, 0x002C($sp)           
/* 00CF0 80A07410 AFA00028 */  sw      $zero, 0x0028($sp)         
/* 00CF4 80A07414 AFA90024 */  sw      $t1, 0x0024($sp)           
/* 00CF8 80A07418 AFA80014 */  sw      $t0, 0x0014($sp)           
/* 00CFC 80A0741C E7A00018 */  swc1    $f0, 0x0018($sp)           
/* 00D00 80A07420 E7A0001C */  swc1    $f0, 0x001C($sp)           
/* 00D04 80A07424 E7A00020 */  swc1    $f0, 0x0020($sp)           
/* 00D08 80A07428 8CAD0000 */  lw      $t5, 0x0000($a1)           ## 00000000
/* 00D0C 80A0742C 0C018FA7 */  jal     DebugDisplay_AddObject
              
/* 00D10 80A07430 AFAD0038 */  sw      $t5, 0x0038($sp)           
.L80A07434:
/* 00D14 80A07434 8FBF0044 */  lw      $ra, 0x0044($sp)           
.L80A07438:
/* 00D18 80A07438 27BD0048 */  addiu   $sp, $sp, 0x0048           ## $sp = 00000000
/* 00D1C 80A0743C 03E00008 */  jr      $ra                        
/* 00D20 80A07440 00000000 */  nop
/* 00D24 80A07444 00000000 */  nop
/* 00D28 80A07448 00000000 */  nop
/* 00D2C 80A0744C 00000000 */  nop
