glabel func_80B93164
/* 001D4 80B93164 27BDFF28 */  addiu   $sp, $sp, 0xFF28           ## $sp = FFFFFF28
/* 001D8 80B93168 F7BE0070 */  sdc1    $f30, 0x0070($sp)          
/* 001DC 80B9316C 3C014000 */  lui     $at, 0x4000                ## $at = 40000000
/* 001E0 80B93170 4481F000 */  mtc1    $at, $f30                  ## $f30 = 2.00
/* 001E4 80B93174 F7BC0068 */  sdc1    $f28, 0x0068($sp)          
/* 001E8 80B93178 3C0140A0 */  lui     $at, 0x40A0                ## $at = 40A00000
/* 001EC 80B9317C 4481E000 */  mtc1    $at, $f28                  ## $f28 = 5.00
/* 001F0 80B93180 F7BA0060 */  sdc1    $f26, 0x0060($sp)          
/* 001F4 80B93184 3C014220 */  lui     $at, 0x4220                ## $at = 42200000
/* 001F8 80B93188 4481D000 */  mtc1    $at, $f26                  ## $f26 = 40.00
/* 001FC 80B9318C AFBE0098 */  sw      $s8, 0x0098($sp)           
/* 00200 80B93190 AFB30084 */  sw      $s3, 0x0084($sp)           
/* 00204 80B93194 F7B80058 */  sdc1    $f24, 0x0058($sp)          
/* 00208 80B93198 3C014120 */  lui     $at, 0x4120                ## $at = 41200000
/* 0020C 80B9319C AFB70094 */  sw      $s7, 0x0094($sp)           
/* 00210 80B931A0 AFB60090 */  sw      $s6, 0x0090($sp)           
/* 00214 80B931A4 AFB5008C */  sw      $s5, 0x008C($sp)           
/* 00218 80B931A8 AFB40088 */  sw      $s4, 0x0088($sp)           
/* 0021C 80B931AC AFB20080 */  sw      $s2, 0x0080($sp)           
/* 00220 80B931B0 AFB1007C */  sw      $s1, 0x007C($sp)           
/* 00224 80B931B4 AFB00078 */  sw      $s0, 0x0078($sp)           
/* 00228 80B931B8 3C1380B9 */  lui     $s3, %hi(D_80B93784)       ## $s3 = 80B90000
/* 0022C 80B931BC 3C1E0501 */  lui     $s8, 0x0501                ## $s8 = 05010000
/* 00230 80B931C0 4481C000 */  mtc1    $at, $f24                  ## $f24 = 10.00
/* 00234 80B931C4 00809025 */  or      $s2, $a0, $zero            ## $s2 = 00000000
/* 00238 80B931C8 00A0A825 */  or      $s5, $a1, $zero            ## $s5 = 00000000
/* 0023C 80B931CC AFBF009C */  sw      $ra, 0x009C($sp)           
/* 00240 80B931D0 F7B60050 */  sdc1    $f22, 0x0050($sp)          
/* 00244 80B931D4 F7B40048 */  sdc1    $f20, 0x0048($sp)          
/* 00248 80B931D8 241003E8 */  addiu   $s0, $zero, 0x03E8         ## $s0 = 000003E8
/* 0024C 80B931DC 27DEA5E8 */  addiu   $s8, $s8, 0xA5E8           ## $s8 = 0500A5E8
/* 00250 80B931E0 26733784 */  addiu   $s3, $s3, %lo(D_80B93784)  ## $s3 = 80B93784
/* 00254 80B931E4 00008825 */  or      $s1, $zero, $zero          ## $s1 = 00000000
/* 00258 80B931E8 24940024 */  addiu   $s4, $a0, 0x0024           ## $s4 = 00000024
/* 0025C 80B931EC 27B600BC */  addiu   $s6, $sp, 0x00BC           ## $s6 = FFFFFFE4
/* 00260 80B931F0 27B700C8 */  addiu   $s7, $sp, 0x00C8           ## $s7 = FFFFFFF0
.L80B931F4:
/* 00264 80B931F4 26104E20 */  addiu   $s0, $s0, 0x4E20           ## $s0 = 00005208
/* 00268 80B931F8 00108400 */  sll     $s0, $s0, 16               
/* 0026C 80B931FC 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00270 80B93200 00108403 */  sra     $s0, $s0, 16               
/* 00274 80B93204 46180502 */  mul.s   $f20, $f0, $f24            
/* 00278 80B93208 00102400 */  sll     $a0, $s0, 16               
/* 0027C 80B9320C 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 00280 80B93210 00042403 */  sra     $a0, $a0, 16               
/* 00284 80B93214 46140102 */  mul.s   $f4, $f0, $f20             
/* 00288 80B93218 C6460024 */  lwc1    $f6, 0x0024($s2)           ## 00000024
/* 0028C 80B9321C 46062200 */  add.s   $f8, $f4, $f6              
/* 00290 80B93220 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 00294 80B93224 E7A800BC */  swc1    $f8, 0x00BC($sp)           
/* 00298 80B93228 461A0282 */  mul.s   $f10, $f0, $f26            
/* 0029C 80B9322C C6500028 */  lwc1    $f16, 0x0028($s2)          ## 00000028
/* 002A0 80B93230 00102400 */  sll     $a0, $s0, 16               
/* 002A4 80B93234 00042403 */  sra     $a0, $a0, 16               
/* 002A8 80B93238 46105480 */  add.s   $f18, $f10, $f16           
/* 002AC 80B9323C 461C9100 */  add.s   $f4, $f18, $f28            
/* 002B0 80B93240 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 002B4 80B93244 E7A400C0 */  swc1    $f4, 0x00C0($sp)           
/* 002B8 80B93248 46140182 */  mul.s   $f6, $f0, $f20             
/* 002BC 80B9324C C648002C */  lwc1    $f8, 0x002C($s2)           ## 0000002C
/* 002C0 80B93250 46083280 */  add.s   $f10, $f6, $f8             
/* 002C4 80B93254 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 002C8 80B93258 E7AA00C4 */  swc1    $f10, 0x00C4($sp)          
/* 002CC 80B9325C 46180402 */  mul.s   $f16, $f0, $f24            
/* 002D0 80B93260 00102400 */  sll     $a0, $s0, 16               
/* 002D4 80B93264 00042403 */  sra     $a0, $a0, 16               
/* 002D8 80B93268 0C01DE1C */  jal     Math_Sins
              ## sins?
/* 002DC 80B9326C 461E8500 */  add.s   $f20, $f16, $f30           
/* 002E0 80B93270 46140482 */  mul.s   $f18, $f0, $f20            
/* 002E4 80B93274 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 002E8 80B93278 E7B200C8 */  swc1    $f18, 0x00C8($sp)          
/* 002EC 80B9327C 0C03F66B */  jal     Math_Rand_ZeroOne
              ## Rand.Next() float
/* 002F0 80B93280 46000586 */  mov.s   $f22, $f0                  
/* 002F4 80B93284 44912000 */  mtc1    $s1, $f4                   ## $f4 = 0.00
/* 002F8 80B93288 3C014020 */  lui     $at, 0x4020                ## $at = 40200000
/* 002FC 80B9328C 44815000 */  mtc1    $at, $f10                  ## $f10 = 2.50
/* 00300 80B93290 468021A0 */  cvt.s.w $f6, $f4                   
/* 00304 80B93294 3C014170 */  lui     $at, 0x4170                ## $at = 41700000
/* 00308 80B93298 44819000 */  mtc1    $at, $f18                  ## $f18 = 15.00
/* 0030C 80B9329C 00102400 */  sll     $a0, $s0, 16               
/* 00310 80B932A0 00042403 */  sra     $a0, $a0, 16               
/* 00314 80B932A4 46060202 */  mul.s   $f8, $f0, $f6              
/* 00318 80B932A8 00000000 */  nop
/* 0031C 80B932AC 460A4402 */  mul.s   $f16, $f8, $f10            
/* 00320 80B932B0 00000000 */  nop
/* 00324 80B932B4 4612B102 */  mul.s   $f4, $f22, $f18            
/* 00328 80B932B8 46048180 */  add.s   $f6, $f16, $f4             
/* 0032C 80B932BC 0C01DE0D */  jal     Math_Coss
              ## coss?
/* 00330 80B932C0 E7A600CC */  swc1    $f6, 0x00CC($sp)           
/* 00334 80B932C4 46140202 */  mul.s   $f8, $f0, $f20             
/* 00338 80B932C8 02A02025 */  or      $a0, $s5, $zero            ## $a0 = 00000000
/* 0033C 80B932CC 02C02825 */  or      $a1, $s6, $zero            ## $a1 = FFFFFFE4
/* 00340 80B932D0 02E03025 */  or      $a2, $s7, $zero            ## $a2 = FFFFFFF0
/* 00344 80B932D4 02803825 */  or      $a3, $s4, $zero            ## $a3 = 00000024
/* 00348 80B932D8 240E001E */  addiu   $t6, $zero, 0x001E         ## $t6 = 0000001E
/* 0034C 80B932DC 16200004 */  bne     $s1, $zero, .L80B932F0     
/* 00350 80B932E0 E7A800D0 */  swc1    $f8, 0x00D0($sp)           
/* 00354 80B932E4 24020029 */  addiu   $v0, $zero, 0x0029         ## $v0 = 00000029
/* 00358 80B932E8 10000008 */  beq     $zero, $zero, .L80B9330C   
/* 0035C 80B932EC 2403FE3E */  addiu   $v1, $zero, 0xFE3E         ## $v1 = FFFFFE3E
.L80B932F0:
/* 00360 80B932F0 2A210004 */  slti    $at, $s1, 0x0004           
/* 00364 80B932F4 10200004 */  beq     $at, $zero, .L80B93308     
/* 00368 80B932F8 24020045 */  addiu   $v0, $zero, 0x0045         ## $v0 = 00000045
/* 0036C 80B932FC 24020025 */  addiu   $v0, $zero, 0x0025         ## $v0 = 00000025
/* 00370 80B93300 10000002 */  beq     $zero, $zero, .L80B9330C   
/* 00374 80B93304 2403FE84 */  addiu   $v1, $zero, 0xFE84         ## $v1 = FFFFFE84
.L80B93308:
/* 00378 80B93308 2403FEC0 */  addiu   $v1, $zero, 0xFEC0         ## $v1 = FFFFFEC0
.L80B9330C:
/* 0037C 80B9330C 86780000 */  lh      $t8, 0x0000($s3)           ## 80B93784
/* 00380 80B93310 240F0005 */  addiu   $t7, $zero, 0x0005         ## $t7 = 00000005
/* 00384 80B93314 24190003 */  addiu   $t9, $zero, 0x0003         ## $t9 = 00000003
/* 00388 80B93318 24080046 */  addiu   $t0, $zero, 0x0046         ## $t0 = 00000046
/* 0038C 80B9331C 24090001 */  addiu   $t1, $zero, 0x0001         ## $t1 = 00000001
/* 00390 80B93320 240A0002 */  addiu   $t2, $zero, 0x0002         ## $t2 = 00000002
/* 00394 80B93324 AFAA0038 */  sw      $t2, 0x0038($sp)           
/* 00398 80B93328 AFA90034 */  sw      $t1, 0x0034($sp)           
/* 0039C 80B9332C AFA80030 */  sw      $t0, 0x0030($sp)           
/* 003A0 80B93330 AFB90028 */  sw      $t9, 0x0028($sp)           
/* 003A4 80B93334 AFAF001C */  sw      $t7, 0x001C($sp)           
/* 003A8 80B93338 AFA30010 */  sw      $v1, 0x0010($sp)           
/* 003AC 80B9333C AFA20014 */  sw      $v0, 0x0014($sp)           
/* 003B0 80B93340 AFAE0018 */  sw      $t6, 0x0018($sp)           
/* 003B4 80B93344 AFA00020 */  sw      $zero, 0x0020($sp)         
/* 003B8 80B93348 AFA0002C */  sw      $zero, 0x002C($sp)         
/* 003BC 80B9334C AFBE003C */  sw      $s8, 0x003C($sp)           
/* 003C0 80B93350 0C00A7A3 */  jal     EffectSsKakera_Spawn
              
/* 003C4 80B93354 AFB80024 */  sw      $t8, 0x0024($sp)           
/* 003C8 80B93358 26310001 */  addiu   $s1, $s1, 0x0001           ## $s1 = 00000001
/* 003CC 80B9335C 24010009 */  addiu   $at, $zero, 0x0009         ## $at = 00000009
/* 003D0 80B93360 1621FFA4 */  bne     $s1, $at, .L80B931F4       
/* 003D4 80B93364 26730002 */  addiu   $s3, $s3, 0x0002           ## $s3 = 80B93786
/* 003D8 80B93368 3C01430C */  lui     $at, 0x430C                ## $at = 430C0000
/* 003DC 80B9336C 4481A000 */  mtc1    $at, $f20                  ## $f20 = 140.00
/* 003E0 80B93370 240B00B4 */  addiu   $t3, $zero, 0x00B4         ## $t3 = 000000B4
/* 003E4 80B93374 240C005A */  addiu   $t4, $zero, 0x005A         ## $t4 = 0000005A
/* 003E8 80B93378 240D0001 */  addiu   $t5, $zero, 0x0001         ## $t5 = 00000001
/* 003EC 80B9337C 4406A000 */  mfc1    $a2, $f20                  
/* 003F0 80B93380 AFAD0018 */  sw      $t5, 0x0018($sp)           
/* 003F4 80B93384 AFAC0014 */  sw      $t4, 0x0014($sp)           
/* 003F8 80B93388 AFAB0010 */  sw      $t3, 0x0010($sp)           
/* 003FC 80B9338C 02A02025 */  or      $a0, $s5, $zero            ## $a0 = 00000000
/* 00400 80B93390 02802825 */  or      $a1, $s4, $zero            ## $a1 = 00000024
/* 00404 80B93394 0C00CD20 */  jal     func_80033480              
/* 00408 80B93398 24070006 */  addiu   $a3, $zero, 0x0006         ## $a3 = 00000006
/* 0040C 80B9339C 4406A000 */  mfc1    $a2, $f20                  
/* 00410 80B933A0 240E0050 */  addiu   $t6, $zero, 0x0050         ## $t6 = 00000050
/* 00414 80B933A4 240F005A */  addiu   $t7, $zero, 0x005A         ## $t7 = 0000005A
/* 00418 80B933A8 24180001 */  addiu   $t8, $zero, 0x0001         ## $t8 = 00000001
/* 0041C 80B933AC AFB80018 */  sw      $t8, 0x0018($sp)           
/* 00420 80B933B0 AFAF0014 */  sw      $t7, 0x0014($sp)           
/* 00424 80B933B4 AFAE0010 */  sw      $t6, 0x0010($sp)           
/* 00428 80B933B8 02A02025 */  or      $a0, $s5, $zero            ## $a0 = 00000000
/* 0042C 80B933BC 02802825 */  or      $a1, $s4, $zero            ## $a1 = 00000024
/* 00430 80B933C0 0C00CD20 */  jal     func_80033480              
/* 00434 80B933C4 2407000C */  addiu   $a3, $zero, 0x000C         ## $a3 = 0000000C
/* 00438 80B933C8 8FBF009C */  lw      $ra, 0x009C($sp)           
/* 0043C 80B933CC D7B40048 */  ldc1    $f20, 0x0048($sp)          
/* 00440 80B933D0 D7B60050 */  ldc1    $f22, 0x0050($sp)          
/* 00444 80B933D4 D7B80058 */  ldc1    $f24, 0x0058($sp)          
/* 00448 80B933D8 D7BA0060 */  ldc1    $f26, 0x0060($sp)          
/* 0044C 80B933DC D7BC0068 */  ldc1    $f28, 0x0068($sp)          
/* 00450 80B933E0 D7BE0070 */  ldc1    $f30, 0x0070($sp)          
/* 00454 80B933E4 8FB00078 */  lw      $s0, 0x0078($sp)           
/* 00458 80B933E8 8FB1007C */  lw      $s1, 0x007C($sp)           
/* 0045C 80B933EC 8FB20080 */  lw      $s2, 0x0080($sp)           
/* 00460 80B933F0 8FB30084 */  lw      $s3, 0x0084($sp)           
/* 00464 80B933F4 8FB40088 */  lw      $s4, 0x0088($sp)           
/* 00468 80B933F8 8FB5008C */  lw      $s5, 0x008C($sp)           
/* 0046C 80B933FC 8FB60090 */  lw      $s6, 0x0090($sp)           
/* 00470 80B93400 8FB70094 */  lw      $s7, 0x0094($sp)           
/* 00474 80B93404 8FBE0098 */  lw      $s8, 0x0098($sp)           
/* 00478 80B93408 03E00008 */  jr      $ra                        
/* 0047C 80B9340C 27BD00D8 */  addiu   $sp, $sp, 0x00D8           ## $sp = 00000000
