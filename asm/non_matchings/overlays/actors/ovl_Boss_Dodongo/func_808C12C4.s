glabel func_808C12C4
/* 00134 808C12C4 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00138 808C12C8 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 0013C 808C12CC 24425890 */  addiu   $v0, $v0, 0x5890           ## $v0 = 06015890
/* 00140 808C12D0 AFB20020 */  sw      $s2, 0x0020($sp)           
/* 00144 808C12D4 00027100 */  sll     $t6, $v0,  4               
/* 00148 808C12D8 3C128016 */  lui     $s2, 0x8016                ## $s2 = 80160000
/* 0014C 808C12DC 000E7F02 */  srl     $t7, $t6, 28               
/* 00150 808C12E0 26526FA8 */  addiu   $s2, $s2, 0x6FA8           ## $s2 = 80166FA8
/* 00154 808C12E4 000FC080 */  sll     $t8, $t7,  2               
/* 00158 808C12E8 AFB30024 */  sw      $s3, 0x0024($sp)           
/* 0015C 808C12EC 0258C821 */  addu    $t9, $s2, $t8              
/* 00160 808C12F0 8F280000 */  lw      $t0, 0x0000($t9)           ## 00000000
/* 00164 808C12F4 3C1300FF */  lui     $s3, 0x00FF                ## $s3 = 00FF0000
/* 00168 808C12F8 AFB1001C */  sw      $s1, 0x001C($sp)           
/* 0016C 808C12FC 00058C00 */  sll     $s1, $a1, 16               
/* 00170 808C1300 3673FFFF */  ori     $s3, $s3, 0xFFFF           ## $s3 = 00FFFFFF
/* 00174 808C1304 00118C03 */  sra     $s1, $s1, 16               
/* 00178 808C1308 AFB40028 */  sw      $s4, 0x0028($sp)           
/* 0017C 808C130C AFB00018 */  sw      $s0, 0x0018($sp)           
/* 00180 808C1310 00534824 */  and     $t1, $v0, $s3              
/* 00184 808C1314 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 00188 808C1318 3C148000 */  lui     $s4, 0x8000                ## $s4 = 80000000
/* 0018C 808C131C AFBF002C */  sw      $ra, 0x002C($sp)           
/* 00190 808C1320 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 00194 808C1324 00113400 */  sll     $a2, $s1, 16               
/* 00198 808C1328 01095021 */  addu    $t2, $t0, $t1              
/* 0019C 808C132C 01542021 */  addu    $a0, $t2, $s4              
/* 001A0 808C1330 00063403 */  sra     $a2, $a2, 16               
/* 001A4 808C1334 0C230464 */  jal     func_808C1190              
/* 001A8 808C1338 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 001AC 808C133C 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 001B0 808C1340 24427210 */  addiu   $v0, $v0, 0x7210           ## $v0 = 06017210
/* 001B4 808C1344 00025900 */  sll     $t3, $v0,  4               
/* 001B8 808C1348 000B6702 */  srl     $t4, $t3, 28               
/* 001BC 808C134C 000C6880 */  sll     $t5, $t4,  2               
/* 001C0 808C1350 024D7021 */  addu    $t6, $s2, $t5              
/* 001C4 808C1354 8DCF0000 */  lw      $t7, 0x0000($t6)           ## 00000000
/* 001C8 808C1358 0053C024 */  and     $t8, $v0, $s3              
/* 001CC 808C135C 00113400 */  sll     $a2, $s1, 16               
/* 001D0 808C1360 01F8C821 */  addu    $t9, $t7, $t8              
/* 001D4 808C1364 03342021 */  addu    $a0, $t9, $s4              
/* 001D8 808C1368 00063403 */  sra     $a2, $a2, 16               
/* 001DC 808C136C 0C230480 */  jal     func_808C1200              
/* 001E0 808C1370 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 001E4 808C1374 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 001E8 808C1378 24425D90 */  addiu   $v0, $v0, 0x5D90           ## $v0 = 06015D90
/* 001EC 808C137C 00024100 */  sll     $t0, $v0,  4               
/* 001F0 808C1380 00084F02 */  srl     $t1, $t0, 28               
/* 001F4 808C1384 00095080 */  sll     $t2, $t1,  2               
/* 001F8 808C1388 024A5821 */  addu    $t3, $s2, $t2              
/* 001FC 808C138C 8D6C0000 */  lw      $t4, 0x0000($t3)           ## 00000000
/* 00200 808C1390 00536824 */  and     $t5, $v0, $s3              
/* 00204 808C1394 00113400 */  sll     $a2, $s1, 16               
/* 00208 808C1398 018D7021 */  addu    $t6, $t4, $t5              
/* 0020C 808C139C 01D42021 */  addu    $a0, $t6, $s4              
/* 00210 808C13A0 00063403 */  sra     $a2, $a2, 16               
/* 00214 808C13A4 0C230474 */  jal     func_808C11D0              
/* 00218 808C13A8 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 0021C 808C13AC 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00220 808C13B0 24426390 */  addiu   $v0, $v0, 0x6390           ## $v0 = 06016390
/* 00224 808C13B4 00027900 */  sll     $t7, $v0,  4               
/* 00228 808C13B8 000FC702 */  srl     $t8, $t7, 28               
/* 0022C 808C13BC 0018C880 */  sll     $t9, $t8,  2               
/* 00230 808C13C0 02594021 */  addu    $t0, $s2, $t9              
/* 00234 808C13C4 8D090000 */  lw      $t1, 0x0000($t0)           ## 00000000
/* 00238 808C13C8 00535024 */  and     $t2, $v0, $s3              
/* 0023C 808C13CC 00113400 */  sll     $a2, $s1, 16               
/* 00240 808C13D0 012A5821 */  addu    $t3, $t1, $t2              
/* 00244 808C13D4 01742021 */  addu    $a0, $t3, $s4              
/* 00248 808C13D8 00063403 */  sra     $a2, $a2, 16               
/* 0024C 808C13DC 0C230474 */  jal     func_808C11D0              
/* 00250 808C13E0 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 00254 808C13E4 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00258 808C13E8 24426590 */  addiu   $v0, $v0, 0x6590           ## $v0 = 06016590
/* 0025C 808C13EC 00026100 */  sll     $t4, $v0,  4               
/* 00260 808C13F0 000C6F02 */  srl     $t5, $t4, 28               
/* 00264 808C13F4 000D7080 */  sll     $t6, $t5,  2               
/* 00268 808C13F8 024E7821 */  addu    $t7, $s2, $t6              
/* 0026C 808C13FC 8DF80000 */  lw      $t8, 0x0000($t7)           ## 00000000
/* 00270 808C1400 0053C824 */  and     $t9, $v0, $s3              
/* 00274 808C1404 00113400 */  sll     $a2, $s1, 16               
/* 00278 808C1408 03194021 */  addu    $t0, $t8, $t9              
/* 0027C 808C140C 01142021 */  addu    $a0, $t0, $s4              
/* 00280 808C1410 00063403 */  sra     $a2, $a2, 16               
/* 00284 808C1414 0C230474 */  jal     func_808C11D0              
/* 00288 808C1418 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 0028C 808C141C 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00290 808C1420 24426790 */  addiu   $v0, $v0, 0x6790           ## $v0 = 06016790
/* 00294 808C1424 00024900 */  sll     $t1, $v0,  4               
/* 00298 808C1428 00095702 */  srl     $t2, $t1, 28               
/* 0029C 808C142C 000A5880 */  sll     $t3, $t2,  2               
/* 002A0 808C1430 024B6021 */  addu    $t4, $s2, $t3              
/* 002A4 808C1434 8D8D0000 */  lw      $t5, 0x0000($t4)           ## 00000000
/* 002A8 808C1438 00537024 */  and     $t6, $v0, $s3              
/* 002AC 808C143C 00113400 */  sll     $a2, $s1, 16               
/* 002B0 808C1440 01AE7821 */  addu    $t7, $t5, $t6              
/* 002B4 808C1444 01F42021 */  addu    $a0, $t7, $s4              
/* 002B8 808C1448 00063403 */  sra     $a2, $a2, 16               
/* 002BC 808C144C 0C230474 */  jal     func_808C11D0              
/* 002C0 808C1450 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 002C4 808C1454 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 002C8 808C1458 24425990 */  addiu   $v0, $v0, 0x5990           ## $v0 = 06015990
/* 002CC 808C145C 0002C100 */  sll     $t8, $v0,  4               
/* 002D0 808C1460 0018CF02 */  srl     $t9, $t8, 28               
/* 002D4 808C1464 00194080 */  sll     $t0, $t9,  2               
/* 002D8 808C1468 02484821 */  addu    $t1, $s2, $t0              
/* 002DC 808C146C 8D2A0000 */  lw      $t2, 0x0000($t1)           ## 00000000
/* 002E0 808C1470 00535824 */  and     $t3, $v0, $s3              
/* 002E4 808C1474 00113400 */  sll     $a2, $s1, 16               
/* 002E8 808C1478 014B6021 */  addu    $t4, $t2, $t3              
/* 002EC 808C147C 01942021 */  addu    $a0, $t4, $s4              
/* 002F0 808C1480 00063403 */  sra     $a2, $a2, 16               
/* 002F4 808C1484 0C23048C */  jal     func_808C1230              
/* 002F8 808C1488 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 002FC 808C148C 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00300 808C1490 24425F90 */  addiu   $v0, $v0, 0x5F90           ## $v0 = 06015F90
/* 00304 808C1494 00026900 */  sll     $t5, $v0,  4               
/* 00308 808C1498 000D7702 */  srl     $t6, $t5, 28               
/* 0030C 808C149C 000E7880 */  sll     $t7, $t6,  2               
/* 00310 808C14A0 024FC021 */  addu    $t8, $s2, $t7              
/* 00314 808C14A4 8F190000 */  lw      $t9, 0x0000($t8)           ## 00000000
/* 00318 808C14A8 00534024 */  and     $t0, $v0, $s3              
/* 0031C 808C14AC 00113400 */  sll     $a2, $s1, 16               
/* 00320 808C14B0 03284821 */  addu    $t1, $t9, $t0              
/* 00324 808C14B4 01342021 */  addu    $a0, $t1, $s4              
/* 00328 808C14B8 00063403 */  sra     $a2, $a2, 16               
/* 0032C 808C14BC 0C23048C */  jal     func_808C1230              
/* 00330 808C14C0 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 00334 808C14C4 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00338 808C14C8 24426990 */  addiu   $v0, $v0, 0x6990           ## $v0 = 06016990
/* 0033C 808C14CC 00025100 */  sll     $t2, $v0,  4               
/* 00340 808C14D0 000A5F02 */  srl     $t3, $t2, 28               
/* 00344 808C14D4 000B6080 */  sll     $t4, $t3,  2               
/* 00348 808C14D8 024C6821 */  addu    $t5, $s2, $t4              
/* 0034C 808C14DC 8DAE0000 */  lw      $t6, 0x0000($t5)           ## 00000000
/* 00350 808C14E0 00537824 */  and     $t7, $v0, $s3              
/* 00354 808C14E4 00113400 */  sll     $a2, $s1, 16               
/* 00358 808C14E8 01CFC021 */  addu    $t8, $t6, $t7              
/* 0035C 808C14EC 03142021 */  addu    $a0, $t8, $s4              
/* 00360 808C14F0 00063403 */  sra     $a2, $a2, 16               
/* 00364 808C14F4 0C23049E */  jal     func_808C1278              
/* 00368 808C14F8 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 0036C 808C14FC 3C020601 */  lui     $v0, 0x0601                ## $v0 = 06010000
/* 00370 808C1500 24426E10 */  addiu   $v0, $v0, 0x6E10           ## $v0 = 06016E10
/* 00374 808C1504 0002C900 */  sll     $t9, $v0,  4               
/* 00378 808C1508 00194702 */  srl     $t0, $t9, 28               
/* 0037C 808C150C 00084880 */  sll     $t1, $t0,  2               
/* 00380 808C1510 02495021 */  addu    $t2, $s2, $t1              
/* 00384 808C1514 8D4B0000 */  lw      $t3, 0x0000($t2)           ## 00000000
/* 00388 808C1518 00536024 */  and     $t4, $v0, $s3              
/* 0038C 808C151C 00113400 */  sll     $a2, $s1, 16               
/* 00390 808C1520 016C6821 */  addu    $t5, $t3, $t4              
/* 00394 808C1524 01B42021 */  addu    $a0, $t5, $s4              
/* 00398 808C1528 00063403 */  sra     $a2, $a2, 16               
/* 0039C 808C152C 0C23049E */  jal     func_808C1278              
/* 003A0 808C1530 02002825 */  or      $a1, $s0, $zero            ## $a1 = 00000000
/* 003A4 808C1534 8FBF002C */  lw      $ra, 0x002C($sp)           
/* 003A8 808C1538 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 003AC 808C153C 8FB1001C */  lw      $s1, 0x001C($sp)           
/* 003B0 808C1540 8FB20020 */  lw      $s2, 0x0020($sp)           
/* 003B4 808C1544 8FB30024 */  lw      $s3, 0x0024($sp)           
/* 003B8 808C1548 8FB40028 */  lw      $s4, 0x0028($sp)           
/* 003BC 808C154C 03E00008 */  jr      $ra                        
/* 003C0 808C1550 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
