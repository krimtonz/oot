#include <ultra64.h>
#include <global.h>

#define CAM_MODE_INIT(funcIdx, modeValues) { funcIdx, ARRAY_COUNT(modeValues), modeValues, }
#define CAM_MODE_NONE { CAM_FUNC_NONE, 0, NULL, }
#define RELOAD_PARAMS (camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14 || R_RELOAD_CAM_PARAMS)

#define PCT(x) (x * 0.01f)
#define NEXTSETTING ((values++)->val)
#define NEXTPCT PCT(NEXTSETTING)

// Macros for creating a Camera Mode's setting set
#define CAM_PARA1_INIT(var, val0, distLERPTarget, phiLERPTarget, thetaLERPTarget, val4, val5, \
                       fovLERPTarget, val7, interfaceFlags, val9, val10) \
CameraModeValue var[] = { \
    { val0, 0 }, { distLERPTarget, 1 }, { phiLERPTarget, 3 }, \
    { thetaLERPTarget, 10 }, { val4, 4 }, { val5, 5 }, \
    { fovLERPTarget, 7 }, { val7, 8 }, { interfaceFlags, 9 },  \
    { val9, 11 }, { val10, 12 } \
}

#define CAM_IFACE_INIT(var, interfaceFlags) \
CameraModeValue var[] = { interfaceFlags, 9 }

#define CAM_BATT4_INIT(var, yOffset, rTarget, phiTarget, lerpUpdateRate, fovTarget, atLERPTarget, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { rTarget, 1 }, { phiTarget, 3}, { lerpUpdateRate, 4 },  \
    { fovTarget, 7 }, { atLERPTarget, 8 }, { interfaceFlags, 9 }, \
}

#define CAM_KEEP0_INIT(var, fovScale, thetaScale, timerInit, interfaceFlags) \
CameraModeValue var[] = { \
    { fovScale, 24 }, { thetaScale, 25 }, { timerInit, 4 }, { interfaceFlags, 9 } \
}

#define CAM_FIXD1_INIT(var, unused0, lerpStep, fov, interfaceFlags) \
CameraModeValue var[] = { \
    { unused0, 0 }, { lerpStep, 4 }, { fov, 7 }, { interfaceFlags, 9 }, \
}

#define CAM_FIXD2_INIT(var, yOffset, eyeStepScale, posStepScale, fov, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { eyeStepScale, 4 }, { posStepScale, 5 }, {fov, 7 }, \
    { interfaceFlags, 9 }, \
}

#define CAM_UNIQ1_INIT(var, yOffset, distClampMin, distClampMax, phiTarget, fovTarget, atLERPScaleMax, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { distClampMin, 1 }, { distClampMax, 2 }, { phiTarget, 3 }, { fovTarget, 7 }, \
    { atLERPScaleMax, 8 }, { interfaceFlags, 9 } \
}

#define CAM_UNIQ2_INIT(var, yOffset, distTarget, fovTarget, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { distTarget, 1 }, { fovTarget, 7 }, { interfaceFlags, 9 }, \
}

#define CAM_UNIQ7_INIT(var, fov, interfaceFlags) \
CameraModeValue var[] = { \
    { fov, 7 }, { interfaceFlags, 9 }, \
}

#define CAM_DEMO3_INIT(var, fov, unused4, interfaceFlags)\
CameraModeValue var[] = { \
    { fov, 7 }, { unused4, 8 }, {interfaceFlags, 9 }, \
}

#define CAM_SPEC0_INIT(var, lerpAtScale, interfaceFlags) \
CameraModeValue var[] = { \
    { lerpAtScale, 4 }, { interfaceFlags, 9 }, \
}

#define CAM_SPEC5_INIT(var, yOffset, eyeDist, minDistForRot, timerInit, phi, fovTarget, atMaxLERPScale, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { eyeDist, 1 }, { minDistForRot, 2 }, { timerInit, 3 }, { phi, 7 }, { fovTarget, 8 }, { atMaxLERPScale, 22 }, { interfaceFlags, 9 }, \
}

#define CAM_SPEC5_INIT2(var, yOffset, eyeDist, minDistForRot, timerInit, phi, fovTarget, atMaxLERPScale, interfaceFlags) \
CameraModeValue var[] = { \
    { yOffset, 0 }, { eyeDist, 1 }, { minDistForRot, 2 }, { timerInit, 22 }, { phi, 3 }, { fovTarget, 7 }, { atMaxLERPScale, 8 }, { interfaceFlags, 9 }, \
}

/**
 * Copies scene camera data to dpos and drot
*/
#define CPY_SCENECAM(dpos,drot) { \
    Camera_Vec3sToVec3f(dpos, &sceneCamData->pos); \
    *eye = *(dpos); \
    drot = sceneCamData->rot; \
}

/*==================================================================*/
// Data
s16 sOREGInit[] = {
    0,   1,   5,  5,  5,   14500, 20,  16, 150, 25,   150, 6,  10, 10, 0,  0,   1,     100,
    250, 120, 80, 30, 120, 4,     1,   50, 20,  1800, 50,  50, 50, 20, 20, -10, -5460, -9100,
    -6,  8,   15, 75, 60,  12,    110, 40, 50,  250,  -10, 30, 30, 70, 20, 20,  20,
};

s16 sOREGInitCnt = 53;

s16 sPREGInit[] = {
    -20, 200, 300, 10, 12, 10, 35, 60, 60, 3, 0, -40, 20, 25, 45, -5, 15, 15, 20, 0, 0, 0, 6, 60, 30, 0, 5,
};

s16 sPREGInitCnt = 27;

char sCameraSettingNames[][12] = {
    "NONE      ",  "NORMAL0    ", "NORMAL1    ", "DUNGEON0   ", "DUNGEON1   ", "NORMAL3    ", "HORSE0     ",
    "BOSS_GOMA  ", "BOSS_DODO  ", "BOSS_BARI  ", "BOSS_FGANON", "BOSS_BAL   ", "BOSS_SHADES", "BOSS_MOFA  ",
    "BOSS_TWIN0 ", "BOSS_TWIN1 ", "BOSS_GANON1", "BOSS_GANON2", "TOWER0     ", "TOWER1     ", "FIXED0     ",
    "FIXED1     ", "CIRCLE0    ", "CIRCLE2    ", "CIRCLE3    ", "PREREND0   ", "PREREND1   ", "PREREND3   ",
    "DOOR0      ", "DOORC      ", "RAIL3      ", "START0     ", "START1     ", "FREE0      ", "FREE2      ",
    "CIRCLE4    ", "CIRCLE5    ", "DEMO0      ", "DEMO1      ", "MORI1      ", "ITEM0      ", "ITEM1      ",
    "DEMO3      ", "DEMO4      ", "UFOBEAN    ", "LIFTBEAN   ", "SCENE0     ", "SCENE1     ", "HIDAN1     ",
    "HIDAN2     ", "MORI2      ", "MORI3      ", "TAKO       ", "SPOT05A    ", "SPOT05B    ", "HIDAN3     ",
    "ITEM2      ", "CIRCLE6    ", "NORMAL2    ", "FISHING    ", "DEMOC      ", "UO_FIBER   ", "DUNGEON2   ",
    "TEPPEN     ", "CIRCLE7    ", "NORMAL4    ",
};

char sCameraModeNames[][12] = {
    "NORMAL     ", "PARALLEL   ", "KEEPON     ", "TALK       ", "BATTLE     ", "CLIMB      ", "SUBJECT    ",
    "BOWARROW   ", "BOWARROWZ  ", "FOOKSHOT   ", "BOOMERANG  ", "PACHINCO   ", "CLIMBZ     ", "JUMP       ",
    "HANG       ", "HANGZ      ", "FREEFALL   ", "CHARGE     ", "STILL      ", "PUSHPULL   ", "BOOKEEPON  ",
};

CameraModeValue D_8011A3A0[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 10, 3 }, { 12, 4 }, { 10, 5 }, { 35, 6 }, { 60, 7 }, { 60, 8 }, { 3, 9 },
};

CAM_PARA1_INIT(D_8011A3C8, -20, 250, 0x0000, 0x0000, 5, 5, 45, 50, 0x200A, -40, 20);

CameraModeValue D_8011A3F4[] = {
    { -20, 0 }, { 120, 1 }, { 140, 2 }, { 25, 13 },  { 45, 14 },  { -5, 15 }, { 15, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 8193, 9 }, { -50, 11 }, { 30, 12 },
};

CameraModeValue D_8011A428[] = {
    { -30, 0 }, { 70, 1 },  { 200, 2 }, { 40, 13 }, { 10, 14 }, { 0, 15 },
    { 5, 16 },  { 70, 17 }, { 45, 7 },  { 50, 8 },  { 10, 4 },  { 13568, 9 },
};

CameraModeValue D_8011A458[] = {
    { -20, 0 }, { 180, 1 }, { 10, 13 }, { 80, 14 },  { 0, 15 },   { 10, 16 },
    { 25, 17 }, { 50, 7 },  { 80, 8 },  { 8194, 9 }, { -40, 11 }, { 25, 12 },
};

CameraModeValue D_8011A488[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 20, 18 }, { 5, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011A4AC[] = {
    { 0, 0 }, { 5, 1 }, { 50, 2 }, { 10, 4 }, { 0, 19 }, { 0, 20 }, { 0, 21 }, { 45, 7 }, { 0, 9 },
};

CameraModeValue D_8011A4D0[] = {
    { -7, 0 }, { 14, 1 }, { 50, 2 }, { 10, 4 }, { 0, 19 }, { -30, 20 }, { -5, 21 }, { 45, 7 }, { 8192, 9 },
};

CameraModeValue D_8011A4F4[] = {
    { 20, 0 }, { 70, 1 }, { 70, 2 }, { 10, 4 }, { -120, 19 }, { 20, 20 }, { 0, 21 }, { 45, 7 }, { 8192, 9 },
};

CAM_SPEC5_INIT(D_8011A518, -20, 80, 250, 45, 60, 40, 6, 0x2000);

CameraModeValue D_8011A538[] = {
    { 5, 0 }, { 50, 1 }, { 50, 2 }, { 10, 4 }, { 0, 19 }, { 0, 20 }, { 0, 21 }, { 45, 7 }, { 8192, 9 },
};

CameraModeValue D_8011A55C[] = {
    { -7, 0 }, { 14, 1 }, { 50, 2 }, { 10, 4 }, { -9, 19 }, { -63, 20 }, { -30, 21 }, { 45, 7 }, { 8192, 9 },
};

CameraModeValue D_8011A580[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 20, 18 }, { 999, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 8198, 9 },
};

CameraModeValue D_8011A5A4[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 12, 4 }, { 35, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};


CAM_UNIQ1_INIT(D_8011A5C4, -80, 200, 300, 40, 60, 10, 0x0000);
CAM_UNIQ1_INIT(D_8011A5E0, -120, 300, 300, 70, 45, 10, 0x2000);

CameraModeValue D_8011A5FC[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 15, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 0, 9 },
};

CAM_BATT4_INIT(D_8011A61C, -20, 300, 50, 2, 80, 20, 0xF000);

CameraModeValue D_8011A638[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 10, 3 }, { 100, 4 }, { 10, 5 }, { 100, 6 }, { 60, 7 }, { 5, 8 }, { -4093, 9 },
};

CameraModeValue D_8011A660[] = {
    { 0, 0 },  { 250, 1 }, { 25, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 }, { 30, 8 },  { 8298, 9 }, { -20, 11 }, { 30, 12 },
};

CameraModeValue D_8011A68C[] = {
    { -5, 0 },  { 120, 1 }, { 140, 2 }, { 5, 13 },   { 85, 14 },  { 10, 15 }, { 5, 16 },
    { 25, 17 }, { 45, 7 },  { 50, 8 },  { 8193, 9 }, { -15, 11 }, { 30, 12 },
};

CameraModeValue D_8011A6C0[] = {
    { 0, 0 }, { 200, 1 }, { 400, 2 }, { 10, 3 }, { 12, 4 }, { 20, 5 }, { 40, 6 }, { 60, 7 }, { 60, 8 }, { 3, 9 },
};

CameraModeValue D_8011A6E8[] = {
    { 0, 0 },  { 250, 1 }, { 0, 3 },    { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 }, { 50, 8 },  { 8194, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011A714[] = {
    { -20, 0 }, { 120, 1 }, { 140, 2 }, { 25, 13 },  { 45, 14 },  { -5, 15 }, { 15, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 8193, 9 }, { -50, 11 }, { 20, 12 },
};

CameraModeValue D_8011A748[] = {
    { -20, 0 }, { 250, 1 }, { 10, 13 }, { 80, 14 },  { 0, 15 },   { 10, 16 },
    { 25, 17 }, { 50, 7 },  { 65, 8 },  { 8194, 9 }, { -40, 11 }, { 25, 12 },
};

CAM_SPEC5_INIT2(D_8011A778, -20, 80, 250, 6, 45, 60, 40, 0x2000);

CameraModeValue D_8011A798[] = {
    { 0, 0 }, { 250, 1 }, { 400, 2 }, { 15, 4 }, { 50, 6 }, { 60, 7 }, { 30, 8 }, { 0, 9 },
};

CameraModeValue D_8011A7B8[] = {
    { 0, 0 }, { 200, 1 }, { 400, 2 }, { 30, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 0, 9 },
};

CameraModeValue D_8011A7D8[] = {
    { -20, 0 }, { 200, 1 }, { 400, 2 }, { 20, 18 }, { 5, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011A7FC[] = {
    { -20, 0 }, { 250, 1 }, { 400, 2 }, { 20, 18 }, { 999, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 8198, 9 },
};

CAM_BATT4_INIT(D_8011A820, 0, 300, 50, 2, 80, 20, 0xF000);

CAM_UNIQ1_INIT(D_8011A83C, -80, 200, 400, 40, 60, 10, 0x0000);
CAM_UNIQ1_INIT(D_8011A858, -120, 400, 400, 70, 45, 10, 0x2000);

CameraModeValue D_8011A874[] = {
    { 0, 0 }, { 200, 1 }, { 400, 2 }, { 10, 3 }, { 100, 4 }, { 20, 5 }, { 100, 6 }, { 60, 7 }, { 5, 8 }, { -4093, 9 },
};

CameraModeValue D_8011A89C[] = {
    { -10, 0 }, { 150, 1 }, { 250, 2 }, { 5, 3 }, { 10, 4 }, { 5, 5 }, { 30, 6 }, { 60, 7 }, { 60, 8 }, { 3, 9 },
};

CameraModeValue D_8011A8C4[] = {
    { -20, 0 }, { 150, 1 }, { 0, 3 },    { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 },  { 50, 8 },  { 8202, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011A8F0[] = {
    { -20, 0 }, { 120, 1 }, { 140, 2 }, { 25, 13 },  { 45, 14 },  { -5, 15 }, { 15, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 8193, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011A924[] = {
    { -20, 0 }, { 180, 1 }, { 10, 13 }, { 80, 14 },  { 0, 15 },   { 10, 16 },
    { 25, 17 }, { 45, 7 },  { 80, 8 },  { 8194, 9 }, { -40, 11 }, { 25, 12 },
};

CameraModeValue D_8011A954[] = {
    { -10, 0 }, { 150, 1 }, { 250, 2 }, { 10, 4 }, { 50, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011A974[] = {
    { -10, 0 }, { 150, 1 }, { 250, 2 }, { 10, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 0, 9 },
};

CameraModeValue D_8011A994[] = {
    { -40, 0 }, { 150, 1 }, { 250, 2 }, { 20, 18 }, { 5, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011A9B8[] = {
    { -40, 0 }, { 250, 1 }, { 250, 2 }, { 20, 18 }, { 999, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 8198, 9 },
};

CAM_BATT4_INIT(D_8011A9DC, -10, 300, 50, 2, 80, 20, 0xF000);

CAM_UNIQ1_INIT(D_8011A9F8, -80, 150, 250, 40, 60, 10, 0x0000);
CAM_UNIQ1_INIT(D_8011AA14, -120, 250, 250, 70, 45, 10, 0x2000);

CameraModeValue D_8011AA30[] = {
    { -10, 0 }, { 150, 1 }, { 250, 2 }, { 5, 3 }, { 100, 4 }, { 5, 5 }, { 100, 6 }, { 60, 7 }, { 5, 8 }, { -4093, 9 },
};

CameraModeValue D_8011AA58[] = {
    { -40, 0 }, { 150, 1 }, { 150, 2 }, { 0, 3 }, { 10, 4 }, { 5, 5 }, { 30, 6 }, { 60, 7 }, { 60, 8 }, { 3, 9 },
};

CameraModeValue D_8011AA80[] = {
    { -20, 0 }, { 70, 1 },  { 200, 2 }, { 40, 13 }, { 10, 14 }, { 0, 15 },
    { 5, 16 },  { 70, 17 }, { 45, 7 },  { 50, 8 },  { 10, 4 },  { 13568, 9 },
};

CameraModeValue D_8011AAB0[] = {
    { -40, 0 }, { 150, 1 }, { 150, 2 }, { 10, 4 }, { 50, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011AAD0[] = {
    { -40, 0 }, { 150, 1 }, { 180, 2 }, { 12, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 0, 9 },
};

CameraModeValue D_8011AAF0[] = {
    { -40, 0 }, { 150, 1 }, { 150, 2 }, { 20, 18 }, { 5, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011AB14[] = {
    { -40, 0 }, { 150, 1 }, { 150, 2 }, { 20, 18 }, { 999, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 8198, 9 },
};

CAM_BATT4_INIT(D_8011AB38, -40, 200, 50, 2, 80, 20, 0xF000);

CAM_UNIQ1_INIT(D_8011AB54, -80, 150, 150, 40, 60, 10, 0x0000);
CAM_UNIQ1_INIT(D_8011AB70, -120, 150, 150, 70, 45, 10, 0x2000);

CameraModeValue D_8011AB8C[] = {
    { -40, 0 }, { 150, 1 }, { 150, 2 }, { 0, 3 }, { 100, 4 }, { 5, 5 }, { 100, 6 }, { 60, 7 }, { 5, 8 }, { -4093, 9 },
};

CameraModeValue D_8011ABB4[] = {
    { -40, 0 }, { 180, 1 }, { 25, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 60, 7 },  { 50, 8 },  { 8298, 9 }, { -20, 11 }, { 30, 12 },
};

CameraModeValue D_8011ABE0[] = {
    { -20, 0 }, { 280, 1 }, { 300, 2 }, { 20, 3 }, { 15, 4 }, { 5, 5 }, { 40, 6 }, { 60, 7 }, { 100, 8 }, { 4, 9 },
};

CameraModeValue D_8011AC08[] = {
    { -50, 0 }, { 250, 1 }, { 70, 3 },   { 0, 10 },   { 15, 4 },  { 5, 5 },
    { 60, 7 },  { 100, 8 }, { 8202, 9 }, { -50, 11 }, { 20, 12 },
};

CameraModeValue D_8011AC34[] = {
    { -30, 0 }, { 70, 1 },  { 200, 2 }, { 40, 13 }, { 10, 14 }, { 10, 15 },
    { 20, 16 }, { 70, 17 }, { 45, 7 },  { 10, 8 },  { 10, 4 },  { 13568, 9 },
};

CameraModeValue D_8011AC64[] = {
    { -40, 0 }, { 150, 1 }, { 250, 2 }, { -5, 3 }, { 18, 4 }, { 5, 5 }, { 60, 6 }, { 60, 7 }, { 40, 8 }, { 5, 9 },
};

CameraModeValue D_8011AC8C[] = {
    { -50, 0 }, { 220, 1 }, { 250, 2 }, { 10, 3 }, { 16, 4 }, { 20, 5 }, { 60, 7 }, { 100, 8 }, { 1536, 9 },
};

CameraModeValue D_8011ACB0[] = {
    { -40, 0 }, { 180, 1 }, { 220, 2 }, { -2, 3 }, { 12, 4 }, { 100, 5 }, { 45, 7 }, { 100, 8 }, { 9728, 9 },
};

CameraModeValue D_8011ACD4[] = {
    { -7, 0 }, { 14, 1 }, { 100, 2 }, { 10, 4 }, { 0, 19 }, { -30, 20 }, { -5, 21 }, { 40, 7 }, { 9728, 9 },
};

CameraModeValue D_8011ACF8[] = {
    { -60, 0 }, { 180, 1 }, { 220, 2 }, { 25, 13 },  { 45, 14 },  { -5, 15 }, { 15, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 9729, 9 }, { -60, 11 }, { 20, 12 },
};

CameraModeValue D_8011AD2C[] = {
    { -60, 0 }, { 140, 1 }, { 200, 2 }, { 40, 13 }, { 10, 14 }, { 0, 15 },
    { 5, 16 },  { 70, 17 }, { 45, 7 },  { 50, 8 },  { 10, 4 },  { 13568, 9 },
};

CameraModeValue D_8011AD5C[] = {
    { -20, 0 }, { 150, 1 }, { 250, 2 }, { 0, 3 }, { 15, 4 }, { 5, 5 }, { 40, 6 }, { 60, 7 }, { 60, 8 }, { 1, 9 },
};

CameraModeValue D_8011AD84[] = {
    { -30, 0 }, { 150, 1 }, { 10, 13 }, { 40, 14 },  { -10, 15 }, { 0, 16 },
    { 25, 17 }, { 60, 7 },  { 40, 8 },  { 8194, 9 }, { -50, 11 }, { 20, 12 },
};

CameraModeValue D_8011ADB4[] = {
    { 0, 0 }, { 150, 1 }, { 300, 2 }, { 0, 3 }, { 12, 4 }, { 5, 5 }, { 70, 6 }, { 70, 7 }, { 40, 8 }, { 3, 9 },
};

CameraModeValue D_8011ADDC[] = {
    { -20, 0 }, { 160, 1 }, { 10, 13 }, { 60, 14 },  { -5, 15 },  { 0, 16 },
    { 25, 17 }, { 70, 7 },  { 50, 8 },  { 8194, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011AE0C[] = {
    { -20, 0 }, { 150, 1 }, { 300, 2 }, { -5, 3 }, { 15, 4 }, { 5, 5 }, { 40, 6 }, { 70, 7 }, { 70, 8 }, { 3, 9 },
};

CameraModeValue D_8011AE34[] = {
    { -30, 0 }, { 125, 1 }, { 10, 13 }, { 10, 14 },  { 0, 15 },   { 0, 16 },
    { 50, 17 }, { 60, 7 },  { 50, 8 },  { 8194, 9 }, { -50, 11 }, { 20, 12 },
};

CameraModeValue D_8011AE64[] = {
    { 10, 0 }, { 150, 1 }, { 250, 2 }, { 0, 3 }, { 15, 4 }, { 15, 5 }, { 40, 6 }, { 60, 7 }, { 100, 8 }, { 3, 9 },
};

CameraModeValue D_8011AE8C[] = {
    { -20, 0 }, { 200, 1 }, { 45, 13 }, { 40, 14 },  { 5, 15 },   { -5, 16 },
    { 35, 17 }, { 60, 7 },  { 100, 8 }, { 8194, 9 }, { -40, 11 }, { 60, 12 },
};

CameraModeValue D_8011AEBC[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 10, 3 }, { 16, 4 }, { 10, 5 }, { 40, 6 }, { 60, 7 }, { 80, 8 }, { 3, 9 },
};

CameraModeValue D_8011AEE4[] = {
    { -20, 0 }, { 200, 1 }, { 20, 13 }, { 60, 14 },  { 0, 15 },   { 10, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 8194, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011AF14[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 10, 3 }, { 20, 4 }, { 10, 5 }, { 40, 6 }, { 60, 7 }, { 80, 8 }, { 131, 9 },
};

CameraModeValue D_8011AF3C[] = {
    { -20, 0 }, { 200, 1 }, { 20, 13 }, { 60, 14 },  { 0, 15 },   { 10, 16 },
    { 15, 17 }, { 45, 7 },  { 50, 8 },  { 8322, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011AF6C[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 10, 3 }, { 20, 4 }, { 10, 5 }, { 80, 6 }, { 60, 7 }, { 80, 8 }, { 131, 9 },
};

CameraModeValue D_8011AF94[] = {
    { -20, 0 }, { 100, 1 }, { 150, 2 }, { -10, 3 }, { 15, 4 }, { 10, 5 }, { 40, 6 }, { 80, 7 }, { 60, 8 }, { 3, 9 },
};

CameraModeValue D_8011AFBC[] = {
    { -20, 0 }, { 200, 1 }, { 10, 13 }, { 80, 14 },  { -10, 15 }, { 10, 16 },
    { 25, 17 }, { 70, 7 },  { 40, 8 },  { 8194, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011AFEC[] = {
    { -20, 0 }, { 150, 1 }, { 300, 2 }, { 0, 3 }, { 20, 4 }, { 10, 5 }, { 40, 6 }, { 60, 7 }, { 80, 8 }, { 3, 9 },
};

CameraModeValue D_8011B014[] = {
    { 0, 0 },   { 400, 1 }, { 0, 13 }, { 60, 14 },  { -10, 15 }, { 5, 16 },
    { 25, 17 }, { 45, 7 },  { 40, 8 }, { 8194, 9 }, { -20, 11 }, { 20, 12 },
};

CameraModeValue D_8011B044[] = {
    { -10, 0 }, { 150, 1 }, { 200, 2 }, { -10, 3 }, { 12, 4 }, { 10, 5 }, { 40, 6 }, { 60, 7 }, { 50, 8 }, { 3, 9 },
};

CameraModeValue D_8011B06C[] = {
    { 40, 0 }, { 330, 1 }, { 330, 2 }, { -5, 3 }, { 15, 4 }, { 15, 5 }, { 40, 6 }, { 60, 7 }, { 100, 8 }, { 0, 9 },
};

CAM_BATT4_INIT(D_8011B094, -40, 250, 0, 2, 80, 20, 0xF000);

CameraModeValue D_8011B0B0[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 10, 3 }, { 20, 4 }, { 10, 5 }, { 40, 6 }, { 60, 7 }, { 80, 8 }, { 3, 9 },
};

CameraModeValue D_8011B0D8[] = {
    { -20, 0 }, { 180, 1 }, { 20, 13 }, { 60, 14 },  { 0, 15 },   { 10, 16 },
    { 25, 17 }, { 45, 7 },  { 50, 8 },  { 8194, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011B108[] = {
    { 0, 0 }, { 120, 1 }, { 280, 2 }, { 60, 23 }, { 8, 4 }, { 40, 6 }, { 60, 7 }, { 50, 8 }, { 0, 9 },
};

CameraModeValue D_8011B12C[] = {
    { 0, 0 }, { 120, 1 }, { 280, 2 }, { 60, 23 }, { 8, 4 }, { 40, 6 }, { 60, 7 }, { 50, 8 }, { 128, 9 },
};

CameraModeValue D_8011B150[] = {
    { 0, 0 }, { 270, 1 }, { 300, 2 }, { 120, 23 }, { 8, 4 }, { 60, 6 }, { 60, 7 }, { 100, 8 }, { 0, 9 },
};

CameraModeValue D_8011B174[] = {
    { 0, 0 }, { 270, 1 }, { 300, 2 }, { 120, 23 }, { 6, 4 }, { 60, 6 }, { 60, 7 }, { 100, 8 }, { 0, 9 },
};

CAM_FIXD1_INIT(D_8011B198, -40, 100, 60, 0x0000);
CAM_FIXD1_INIT(D_8011B1A8, -40, 100, 60, 0x2000);
CAM_FIXD1_INIT(D_8011B1B8, -40, 100, 60, 0x3500);
CAM_FIXD1_INIT(D_8011B1C8, -40, 25, 60, 0);

CAM_FIXD2_INIT(D_8011B1D8, -40, 50, 80, 60, 0x0001);

CameraModeValue sData4Normal[] = {
    { -40, 0 },
    { 60, 7 },
    { 16128, 9 },
};

CameraModeValue D_8011B1F8[] = {
    { -40, 0 }, { 50, 4 }, { 80, 5 }, { 60, 7 }, { 4, 9 },
};

CAM_IFACE_INIT(D_8011B20C, 0);

CAM_IFACE_INIT(D_8011B210, 0x2000);

CAM_UNIQ7_INIT(D_8011B214, 60, 0x0000);
CAM_UNIQ7_INIT(D_8011B21C, 60, 0x2000);

CAM_KEEP0_INIT(D_8011B224, 30, 0, 4, 0x3500);

CameraModeValue D_8011B234[] = {
    { -40, 0 },
    { 60, 7 },
    { 12800, 9 },
};

CameraModeValue D_8011B240[] = {
    { -5, 0 },
    { 60, 7 },
    { 12802, 9 },
};

CameraModeValue D_8011B24C[] = {
    { -5, 0 },
    { 60, 7 },
    { 12810, 9 },
};

CameraModeValue D_8011B258[] = {
    { 0, 0 }, { 2, 1 }, { 30, 2 }, { 10, 4 }, { 45, 7 }, { 12800, 9 },
};

CAM_IFACE_INIT(D_8011B270, 0x0001);
CAM_IFACE_INIT(D_8011B274, 0xFF00);
CAM_IFACE_INIT(D_8011B278, 0xFF01);

CameraModeValue D_8011B27C[] = {
    { -40, 0 }, { 100, 4 }, { 80, 5 }, { 60, 7 }, { 0, 9 },
};

CAM_UNIQ2_INIT(D_8011B290, -40, 60, 60, 0x0002);
CAM_UNIQ2_INIT(D_8011B2A0, -30, 45, 100, 0x2001);

CAM_IFACE_INIT(D_8011B2B0, 0x3200);

CameraModeValue D_8011B2B4[] = {
    { -50, 0 }, { 450, 1 }, { 40, 3 }, { 180, 10 }, { 5, 4 },   { 5, 5 },
    { 70, 7 },  { 30, 8 },  { 12, 9 }, { -50, 11 }, { 20, 12 },
};

CAM_IFACE_INIT(D_8011B2E0, 0x3501);

CAM_DEMO3_INIT(D_8011B2E4, 60, 30, 0x3200);

CAM_IFACE_INIT(D_8011B2F0, 0x3212);

CameraModeValue D_8011B2F4[] = {
    { -50, 0 }, { 300, 1 }, { 300, 2 }, { 50, 3 }, { 20, 4 }, { 10, 5 }, { 50, 6 }, { 70, 7 }, { 40, 8 }, { 2, 9 },
};

CameraModeValue D_8011B31C[] = {
    { -50, 0 }, { 300, 1 }, { 10, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 },  { 50, 8 },  { 8202, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011B348[] = {
    { -50, 0 }, { 300, 1 }, { 300, 2 }, { 12, 4 }, { 35, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CAM_UNIQ1_INIT(D_8011B368, -80, 300, 300, 60, 70, 30, 0x0000);
CAM_UNIQ1_INIT(D_8011B384, -120, 300, 300, 70, 50, 30, 0x2000);

CameraModeValue D_8011B3A0[] = {
    { -20, 0 }, { 300, 1 }, { 350, 2 }, { 50, 3 }, { 100, 4 },
    { 10, 5 },  { 100, 6 }, { 70, 7 },  { 30, 8 }, { -4094, 9 },
};

CameraModeValue D_8011B3C8[] = {
    { -50, 0 }, { 200, 1 }, { 200, 2 }, { 20, 3 }, { 16, 4 }, { 10, 5 }, { 50, 6 }, { 60, 7 }, { 50, 8 }, { 2, 9 },
};

CameraModeValue D_8011B3F0[] = {
    { -50, 0 }, { 200, 1 }, { 40, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 },  { 50, 8 },  { 8202, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011B41C[] = {
    { -50, 0 }, { 150, 1 }, { 250, 2 }, { 12, 4 }, { 35, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CAM_UNIQ1_INIT(D_8011B43C, -80, 200, 200, 40, 60, 30, 0x0000);
CAM_UNIQ1_INIT(D_8011B458, -120, 200, 200, 60, 50, 30, 0x2000);

CameraModeValue D_8011B474[] = {
    { -20, 0 }, { 200, 1 }, { 250, 2 }, { 20, 3 }, { 100, 4 },
    { 10, 5 },  { 100, 6 }, { 60, 7 },  { 30, 8 }, { -4094, 9 },
};

CameraModeValue D_8011B49C[] = {
    { -30, 0 },
    { 60, 7 },
    { 266, 9 },
};

CAM_UNIQ2_INIT(D_8011B4A8, -20, 150, 60, 0x0210);

CameraModeValue D_8011B4B8[] = {
    { 0, 0 }, { 400, 1 }, { 500, 2 }, { 35, 3 }, { 14, 4 }, { 5, 5 }, { 20, 6 }, { 60, 7 }, { 40, 8 }, { 18, 9 },
};

CameraModeValue D_8011B4E0[] = {
    { -20, 0 }, { 250, 1 }, { 5, 13 }, { 10, 14 },  { 30, 15 },  { 20, 16 },
    { 25, 17 }, { 45, 7 },  { 60, 8 }, { 8194, 9 }, { -40, 11 }, { 25, 12 },
};

CameraModeValue D_8011B510[] = {
    { 0, 0 }, { 300, 1 }, { 500, 2 }, { 60, 3 }, { 8, 4 }, { 5, 5 }, { 60, 6 }, { 60, 7 }, { 30, 8 }, { 18, 9 },
};

CameraModeValue D_8011B538[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 70, 6 }, { 70, 7 }, { 80, 8 }, { 18, 9 },
};

CameraModeValue D_8011B560[] = {
    { -20, 0 }, { 500, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 },  { 80, 8 },  { 8218, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B58C[] = {
    { -20, 0 }, { 500, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 60, 7 },  { 80, 8 },  { 8218, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B5B8[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 18, 9 },
};

CameraModeValue D_8011B5E0[] = {
    { -20, 0 }, { 750, 1 }, { 750, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 70, 6 }, { 70, 7 }, { 80, 8 }, { 18, 9 },
};

CameraModeValue D_8011B608[] = {
    { -20, 0 }, { 750, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 },  { 80, 8 },  { 8218, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B634[] = {
    { -20, 0 }, { 750, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 },  { 80, 8 },  { 8202, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B660[] = {
    { -20, 0 }, { 750, 1 }, { 750, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 80, 6 }, { 70, 7 }, { 20, 8 }, { 18, 9 },
};

CameraModeValue D_8011B688[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 70, 6 }, { 70, 7 }, { 80, 8 }, { 2, 9 },
};

CameraModeValue D_8011B6B0[] = {
    { -20, 0 }, { 500, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 },  { 80, 8 },  { 8202, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B6DC[] = {
    { -20, 0 }, { 500, 1 }, { 80, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 60, 7 },  { 80, 8 },  { 8202, 9 }, { -40, 11 }, { 40, 12 },
};

CameraModeValue D_8011B708[] = {
    { -20, 0 }, { 500, 1 }, { 500, 2 }, { 80, 3 }, { 20, 4 }, { 10, 5 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 2, 9 },
};

CameraModeValue D_8011B730[] = {
    { -30, 0 }, { 120, 1 }, { -10, 3 }, { 170, 10 }, { 0, 21 }, { 60, 7 }, { 9474, 9 }, { 25, 4 }, { 6, 22 },
};

CAM_SPEC0_INIT(D_8011B754, 20, 0x3200);

CameraModeValue D_8011B75C[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 10, 3 }, { 12, 4 }, { 10, 5 }, { 35, 6 }, { 60, 7 }, { 60, 8 }, { 2, 9 },
};

CameraModeValue D_8011B784[] = {
    { 0, 0 }, { 200, 1 }, { 300, 2 }, { 20, 3 }, { 12, 4 }, { 10, 5 }, { 35, 6 }, { 55, 7 }, { 60, 8 }, { 3842, 9 },
};

CameraModeValue D_8011B7AC[] = {
    { -20, 0 }, { 250, 1 }, { 0, 3 },     { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 },  { 50, 8 },  { 12042, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011B7D8[] = {
    { -20, 0 }, { 250, 1 }, { 0, 13 }, { 80, 14 },   { 0, 15 },   { 0, 16 },
    { 25, 17 }, { 55, 7 },  { 80, 8 }, { 12034, 9 }, { -40, 11 }, { 25, 12 },
};

CameraModeValue D_8011B808[] = {
    { -30, 0 }, { 70, 1 },  { 200, 2 }, { 40, 13 }, { 10, 14 }, { 0, 15 },
    { 5, 16 },  { 70, 17 }, { 45, 7 },  { 50, 8 },  { 10, 4 },  { 16160, 9 },
};

CameraModeValue D_8011B838[] = {
    { 0, 0 }, { 5, 1 }, { 50, 2 }, { 10, 4 }, { 0, 19 }, { 0, 20 }, { 0, 21 }, { 45, 7 }, { 3840, 9 },
};

CameraModeValue D_8011B85C[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 12, 4 }, { 35, 6 }, { 60, 7 }, { 40, 8 }, { 3840, 9 },
};

CameraModeValue D_8011B87C[] = {
    { -20, 0 }, { 200, 1 }, { 300, 2 }, { 15, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 3840, 9 },
};

CAM_UNIQ1_INIT(D_8011B89C, -80, 200, 300, 40, 60, 10,  0x0F00);
CAM_UNIQ1_INIT(D_8011B8B8, -120, 300, 300, 70, 45, 10, 0x2F00);

CameraModeValue D_8011B8D4[] = {
    { 16128, 9 },
};

CameraModeValue D_8011B8D8[] = {
    { 30, 0 }, { 200, 1 }, { 300, 2 }, { -20, 3 }, { 15, 4 }, { 5, 26 }, { 50, 6 }, { 70, 7 }, { 70, 8 }, { 3, 9 },
};

CameraModeValue D_8011B900[] = {
    { -30, 0 }, { 160, 1 }, { 10, 13 }, { 10, 14 },  { 0, 15 },   { 0, 16 },
    { 70, 17 }, { 60, 7 },  { 40, 8 },  { 8194, 9 }, { -50, 11 }, { 20, 12 },
};

CameraModeValue D_8011B930[] = {
    { -20, 0 }, { 350, 1 }, { 350, 2 }, { 20, 3 }, { 15, 4 }, { 5, 5 }, { 30, 6 }, { 60, 7 }, { 60, 8 }, { 3, 9 },
};

CameraModeValue D_8011B958[] = {
    { -20, 0 }, { 200, 1 }, { 0, 3 },    { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 45, 7 },  { 50, 8 },  { 8202, 9 }, { -40, 11 }, { 20, 12 },
};

CameraModeValue D_8011B984[] = {
    { -20, 0 }, { 180, 1 }, { 10, 13 }, { 80, 14 },  { -10, 15 }, { 10, 16 },
    { 25, 17 }, { 45, 7 },  { 80, 8 },  { 8194, 9 }, { -40, 11 }, { 25, 12 },
};

CameraModeValue D_8011B9B4[] = {
    { -20, 0 }, { 350, 1 }, { 350, 2 }, { 10, 4 }, { 50, 6 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011B9D4[] = {
    { -20, 0 }, { 350, 1 }, { 350, 2 }, { 15, 4 }, { 80, 6 }, { 60, 7 }, { 20, 8 }, { 0, 9 },
};

CameraModeValue D_8011B9F4[] = {
    { -40, 0 }, { 350, 1 }, { 350, 2 }, { 20, 18 }, { 5, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 0, 9 },
};

CameraModeValue D_8011BA18[] = {
    { -40, 0 }, { 350, 1 }, { 350, 2 }, { 20, 18 }, { 999, 4 }, { 5, 5 }, { 60, 7 }, { 40, 8 }, { 8198, 9 },
};

CAM_UNIQ1_INIT(D_8011BA3C, -50, 350, 350, 40, 60, 10, 0x0000);
CAM_UNIQ1_INIT(D_8011BA58, -100, 350, 350, 70, 45, 10, 0x2000);

CameraModeValue D_8011BA74[] = {
    { -10, 0 }, { 350, 1 }, { 350, 2 }, { 20, 3 }, { 100, 4 }, { 5, 5 }, { 100, 6 }, { 60, 7 }, { 5, 8 }, { -4093, 9 },
};

CameraModeValue D_8011BA9C[] = {
    { 0, 0 },  { 280, 1 }, { 25, 3 },   { 0, 10 },   { 5, 4 },   { 5, 5 },
    { 70, 7 }, { 30, 8 },  { 8298, 9 }, { -20, 11 }, { 30, 12 },
};

CameraModeValue D_8011BAC8[] = {
    { -10, 0 }, { 280, 1 }, { 320, 2 }, { -8, 3 }, { 20, 4 }, { 10, 5 }, { 80, 6 }, { 60, 7 }, { 80, 8 }, { 2, 9 },
};

CameraModeValue D_8011BAF0[] = {
    { -20, 0 }, { 180, 1 }, { 200, 2 }, { 35, 13 },  { 45, 14 },  { 0, 15 },  { -5, 16 },
    { 20, 17 }, { 50, 7 },  { 50, 8 },  { 8193, 9 }, { -50, 11 }, { 30, 12 },
};

CameraModeValue D_8011BB24[] = {
    { -80, 0 }, { 200, 1 }, { 250, 2 }, { 30, 13 }, { 10, 14 }, { -8, 15 },
    { -8, 16 }, { 30, 17 }, { 50, 7 },  { 50, 8 },  { 10, 4 },  { 13600, 9 },
};

CameraModeValue D_8011BB54[] = {
    { -30, 0 }, { 70, 1 },  { 200, 2 }, { 40, 13 }, { 10, 14 }, { 0, 15 },
    { 5, 16 },  { 70, 17 }, { 45, 7 },  { 50, 8 },  { 10, 4 },  { 13728, 9 },
};

CameraModeValue valueSettings[] = {
    { 40, 0 }, { 60, 7 }, { 3, 9 },
};

CameraMode D_8011BB84[] = {
    { CAM_FUNC_RADIAL, 3, valueSettings },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A458 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5FC },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011BC2C[] = {
    { CAM_FUNC_RADIAL, 3, valueSettings },  { 7, 11, D_8011A6E8 }, { 12, 13, D_8011A714 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A7D8 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A778), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A7FC },  { 22, 8, D_8011A798 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A83C),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A858),
    { 22, 8, D_8011A7B8 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A820), { 2, 10, D_8011A874 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011BCD4[] = {
    { 2, 10, D_8011A89C },  { 7, 11, D_8011A8C4 }, { 12, 13, D_8011A8F0 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A924 }, { 23, 9, D_8011A994 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A778), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A9B8 },  { 22, 8, D_8011A954 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A9F8),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011AA14),
    { 22, 8, D_8011A974 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A9DC), { 2, 10, D_8011AA30 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011BD7C[] = {
    { 2, 10, D_8011AA58 },  { 7, 11, D_8011A8C4 }, { 12, 13, D_8011A714 }, { 14, 12, D_8011AA80 },
    { 27, 12, D_8011A924 }, { 23, 9, D_8011AAF0 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A778), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011AB14 },  { 22, 8, D_8011AAB0 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011AB54),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011AB70),
    { 22, 8, D_8011AAD0 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011AB38), { 2, 10, D_8011AB8C },  { 7, 11, D_8011ABB4 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011BE24[] = {
    { 24, 10, D_8011ABE0 }, { 7, 11, D_8011AC08 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011AC34 },
    { 27, 12, D_8011A458 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 24, 10, D_8011AC64 }, { 0, 0, NULL },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
};

CameraMode D_8011BEC4[] = {
    { 4, 9, D_8011AC8C }, { 4, 9, D_8011ACB0 }, { 12, 13, D_8011ACF8 }, { 14, 12, D_8011AD2C }, { 0, 0, NULL },
    { 0, 0, NULL },       { 0, 0, NULL },       { 19, 9, D_8011ACD4 },  { 19, 9, D_8011A4F4 },
};

CameraMode D_8011BF0C[] = {
    { 2, 10, D_8011AD5C },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AD84 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A9DC), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011BFB4[] = {
    { 2, 10, D_8011ADB4 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011ADDC }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C05C[] = {
    { 2, 10, D_8011AE0C },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AE34 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C104[] = {
    { 2, 10, D_8011AE64 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AE8C }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C1AC[] = {
    { 2, 10, D_8011AEBC },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AEE4 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C254[] = {
    { 2, 10, D_8011AF14 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AF3C }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 2, 10, D_8011AF6C }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 2, 10, D_8011AF6C },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C2FC[] = {
    { 2, 10, D_8011AF94 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AFBC }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C3A4[] = {
    { 2, 10, D_8011AFEC },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B014 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C44C[] = {
    { 2, 10, D_8011B044 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B014 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C4F4[] = {
    { 2, 10, D_8011B06C },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011AE8C }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011B094), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C59C[] = {
    { 2, 10, D_8011B0B0 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B0D8 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C644[] = {
    { 3, 9, D_8011B108 },   { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A458 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 3, 9, D_8011B12C },  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C6EC[] = {
    { 3, 9, D_8011B150 },   { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A458 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 3, 9, D_8011B174 },  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C794[] = {
    CAM_MODE_INIT(CAM_FUNC_FIXD1, D_8011B198),
    { 0, 0, NULL },
    CAM_MODE_INIT(CAM_FUNC_FIXD1, D_8011B1A8),
    CAM_MODE_INIT(CAM_FUNC_FIXD1, D_8011B1B8),
};

CameraMode D_8011C7B4[] = {
    CAM_MODE_INIT(CAM_FUNC_FIXD1, D_8011B1C8),
};

CameraMode D_8011C7BC[] = {
    CAM_MODE_INIT(CAM_FUNC_FIXD2, D_8011B1D8),
};

CameraMode sData4Modes[] = {
    { 40, 3, sData4Normal },
};

CameraMode D_8011C7CC[] = {
    { 35, 5, D_8011B1F8 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 0, 0, NULL },        { 0, 0, NULL },         { 0, 0, NULL },
    { 0, 0, NULL },         CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011C874[] = {
    CAM_MODE_INIT(CAM_FUNC_FIXD3, D_8011B20C),
    CAM_MODE_NONE,
    CAM_MODE_INIT(CAM_FUNC_FIXD3, D_8011B210),
    CAM_MODE_INIT(CAM_FUNC_FIXD3, D_8011B210),
};

CameraMode D_8011C894[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ7, D_8011B214),
    CAM_MODE_NONE,
    CAM_MODE_INIT(CAM_FUNC_UNIQ7, D_8011B21C),
    CAM_MODE_INIT(CAM_FUNC_KEEP0, D_8011B224),
};

CameraMode D_8011C8B4[] = {
    CAM_MODE_INIT(CAM_FUNC_SPEC6, D_8011B20C),
};

CameraMode D_8011C8BC[] = {
    { 44, 3, D_8011B234 },
};

CameraMode D_8011C8C4[] = {
    { 70, 3, D_8011B240 },
    { 70, 3, D_8011B24C },
};

CameraMode D_8011C8D4[] = {
    { 20, 6, D_8011B258 },
};

CameraMode D_8011C8DC[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ0, D_8011B20C),
};

CameraMode D_8011C8E4[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ0, D_8011B270),
};

CameraMode D_8011C8EC[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ6, D_8011B274),
};

CameraMode D_8011C8F4[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ6, D_8011B278),
};

CameraMode D_8011C8FC[] = {
    { 33, 5, D_8011B27C },
};

CameraMode D_8011C904[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ2, D_8011B290),
    CAM_MODE_INIT(CAM_FUNC_UNIQ2, D_8011B2A0),
};

CameraMode D_8011C914[] = {
    CAM_MODE_INIT(CAM_FUNC_DEMO1, D_8011B2B0),
};

CameraMode D_8011C91C[] = {
    { 53, 1, D_8011B2B0 },
};

CameraMode D_8011C924[] = {
    { 7, 11, D_8011B2B4 },
    { 0, 0, NULL },
    { 0, 0, NULL },
    { 9, 1, D_8011B2E0 },
};

CameraMode D_8011C944[] = {
    CAM_MODE_INIT(CAM_FUNC_DEMO3, D_8011B2E4),
};

CameraMode D_8011C94C[] = {
    { 55, 3, D_8011B2E4 },
};

CameraMode D_8011C954[] = {
    CAM_MODE_INIT(CAM_FUNC_DEMO9, D_8011B2F0),
};

CameraMode D_8011C95C[] = {
    { 56, 1, D_8011B2B0 },
};

CameraMode D_8011C964[] = {
    { 2, 10, D_8011B2F4 },  { 7, 11, D_8011B31C }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011B348 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B368),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B384),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011B3A0 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CA0C[] = {
    { 2, 10, D_8011B3C8 },  { 7, 11, D_8011B3F0 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011B41C }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B43C),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B458),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011B474 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CAB4[] = {
    { 70, 3, D_8011B49C },
};

CameraMode D_8011CABC[] = {
    CAM_MODE_INIT(CAM_FUNC_UNIQ2, D_8011B4A8),
};

CameraMode D_8011CAC4[] = {
    CAM_MODE_INIT(CAM_FUNC_SPEC7, D_8011B20C),
};

CameraMode D_8011CACC[] = {
    CAM_MODE_INIT(CAM_FUNC_SPEC4, D_8011B2B0),
};

CameraMode D_8011CAD4[] = {
    { 46, 1, D_8011B2B0 },
};

CameraMode D_8011CADC[] = {
    CAM_MODE_INIT(CAM_FUNC_DEMO6, D_8011B2B0),
};

CameraMode D_8011CAE4[] = {
    { 2, 10, D_8011B4B8 },  { 7, 11, D_8011A8C4 }, { 12, 13, D_8011A8F0 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B4E0 }, { 23, 9, D_8011A994 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A778), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A9B8 },  { 22, 8, D_8011A954 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A9F8),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011AA14),
    { 22, 8, D_8011A974 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A9DC), { 2, 10, D_8011B510 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CB8C[] = {
    { 2, 10, D_8011B538 }, { 7, 11, D_8011B560 }, { 0, 0, NULL },
    { 0, 0, NULL },        { 7, 11, D_8011B58C }, { 2, 10, D_8011B5B8 },
};

CameraMode D_8011CBBC[] = {
    { 2, 10, D_8011B5E0 }, { 7, 11, D_8011B608 }, { 0, 0, NULL },
    { 0, 0, NULL },        { 7, 11, D_8011B634 }, { 2, 10, D_8011B660 },
};

CameraMode D_8011CBEC[] = {
    { 2, 10, D_8011B688 }, { 7, 11, D_8011B6B0 }, { 0, 0, NULL },
    { 0, 0, NULL },        { 7, 11, D_8011B6DC }, { 2, 10, D_8011B708 },
};

CameraMode D_8011CC1C[] = {
    { 15, 9, D_8011B730 },
};

CameraMode D_8011CC24[] = {
    CAM_MODE_INIT(CAM_FUNC_SPEC0, D_8011B754),
};

CameraMode D_8011CC2C[] = {
    { 2, 10, D_8011B75C },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CCD4[] = {
    { 2, 10, D_8011B784 },  { 7, 11, D_8011B7AC }, { 27, 12, D_8011B7D8 }, { 14, 12, D_8011B808 },
    { 27, 12, D_8011B7D8 }, { 0, 0, NULL },        { 19, 9, D_8011B838 },  { 0, 0, NULL },
    { 0, 0, NULL },         { 0, 0, NULL },        { 0, 0, NULL },         { 0, 0, NULL },
    { 0, 0, NULL },         { 22, 8, D_8011B85C }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B89C),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011B8B8),
    { 22, 8, D_8011B87C },
};

CameraMode D_8011CD5C[] = {
    { 50, 1, D_8011B8D4 },
};

CameraMode D_8011CD64[] = {
    { 2, 10, D_8011B8D8 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B900 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CE0C[] = {
    { 2, 10, D_8011B930 },  { 7, 11, D_8011B958 }, { 12, 13, D_8011A8F0 }, { 14, 12, D_8011A428 },
    { 27, 12, D_8011B984 }, { 23, 9, D_8011B9F4 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A778), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011BA18 },  { 22, 8, D_8011B9B4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011BA3C),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011BA58),
    { 22, 8, D_8011B9D4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011BA74 },  { 7, 11, D_8011BA9C },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CEB4[] = {
    { 2, 10, D_8011BAC8 },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011BAF0 }, { 14, 12, D_8011BB24 },
    { 27, 12, D_8011A458 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraMode D_8011CF5C[] = {
    { 35, 5, D_8011B1F8 }, { 0, 0, NULL },        { 35, 5, D_8011B1F8 }, { 14, 12, D_8011A428 },
    { 0, 0, NULL },        { 0, 0, NULL },        { 19, 9, D_8011A4AC }, { 19, 9, D_8011A4D0 },
    { 0, 0, NULL },        CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 }, { 19, 9, D_8011A55C },
};

CameraMode D_8011CFBC[] = {
    { 2, 10, D_8011B75C },  { 7, 11, D_8011A3C8 }, { 12, 13, D_8011A3F4 }, { 14, 12, D_8011BB54 },
    { 27, 12, D_8011A748 }, { 23, 9, D_8011A488 }, { 19, 9, D_8011A4AC },  { 19, 9, D_8011A4D0 },
    { 19, 9, D_8011A4F4 },  CAM_MODE_INIT(CAM_FUNC_SPEC5, D_8011A518), { 19, 9, D_8011A538 },  { 19, 9, D_8011A55C },
    { 23, 9, D_8011A580 },  { 22, 8, D_8011A5A4 }, CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5C4),  CAM_MODE_INIT(CAM_FUNC_UNIQ1, D_8011A5E0),
    { 22, 8, D_8011A5A4 },  CAM_MODE_INIT(CAM_FUNC_BATT4, D_8011A61C), { 2, 10, D_8011A638 },  { 7, 11, D_8011A660 },
    { 12, 13, D_8011A68C },
};

CameraSetting sCameraSettings[] = {
    { { 0x00000000 }, NULL },       { { 0x051FFFFF }, D_8011BB84 }, { { 0x051FFFFF }, D_8011BC2C },
    { { 0x051FFFFF }, D_8011BCD4 }, { { 0x051FFFFF }, D_8011BD7C }, { { 0x050FF7FF }, D_8011BE24 },
    { { 0x8500018F }, D_8011BEC4 }, { { 0x051FFFFF }, D_8011BF0C }, { { 0x051FFFFF }, D_8011BFB4 },
    { { 0x051FFFFF }, D_8011C05C }, { { 0x051FFFFF }, D_8011C104 }, { { 0x051FFFFF }, D_8011C1AC },
    { { 0x051FFFFF }, D_8011C254 }, { { 0x051FFFFF }, D_8011C2FC }, { { 0x051FFFFF }, D_8011C3A4 },
    { { 0x051FFFFF }, D_8011C44C }, { { 0x051FFFFF }, D_8011C4F4 }, { { 0x051FFFFF }, D_8011C59C },
    { { 0x851FFFFF }, D_8011C644 }, { { 0x851FFFFF }, D_8011C6EC }, { { 0x8500000D }, D_8011C794 },
    { { 0x85000001 }, D_8011C7B4 }, { { 0x85000001 }, D_8011C7BC }, { { 0x85000001 }, sData4Modes },
    { { 0x851E1FFF }, D_8011C7CC }, { { 0x8C00000D }, D_8011C874 }, { { 0x8C00000D }, D_8011C894 },
    { { 0x8C000001 }, D_8011C8B4 }, { { 0xC5000001 }, D_8011C8BC }, { { 0xC5000003 }, D_8011C8C4 },
    { { 0xC5000001 }, D_8011C8D4 }, { { 0xC5000001 }, D_8011C8DC }, { { 0xC5000001 }, D_8011C8E4 },
    { { 0x05000001 }, D_8011C8EC }, { { 0x05000001 }, D_8011C8F4 }, { { 0x85000001 }, D_8011C8FC },
    { { 0x05000003 }, D_8011C904 }, { { 0xCE000001 }, D_8011C914 }, { { 0x4E000001 }, D_8011C91C },
    { { 0x05000009 }, D_8011C924 }, { { 0x45000001 }, D_8011C944 }, { { 0x45000001 }, D_8011C94C },
    { { 0x45000001 }, D_8011C954 }, { { 0x45000001 }, D_8011C95C }, { { 0x451FFFFF }, D_8011C964 },
    { { 0x451FFFFF }, D_8011CA0C }, { { 0xC5000001 }, D_8011CAB4 }, { { 0x45000001 }, D_8011CABC },
    { { 0x05000001 }, D_8011CAC4 }, { { 0x45000001 }, D_8011CACC }, { { 0x45000001 }, D_8011CAD4 },
    { { 0x45000001 }, D_8011CADC }, { { 0x451FFFFF }, D_8011CAE4 }, { { 0x05000033 }, D_8011CB8C },
    { { 0x05000033 }, D_8011CBBC }, { { 0x05000033 }, D_8011CBEC }, { { 0x4A000001 }, D_8011CC1C },
    { { 0x05000001 }, D_8011CC24 }, { { 0x051FFFFF }, D_8011CC2C }, { { 0x0501E05F }, D_8011CCD4 },
    { { 0x45000001 }, D_8011CD5C }, { { 0x051FFFFF }, D_8011CD64 }, { { 0x051FFFFF }, D_8011CE0C },
    { { 0x051FFFFF }, D_8011CEB4 }, { { 0xC5000ECD }, D_8011CF5C }, { { 0x051FFFFF }, D_8011CFBC },
};

s32 Camera_Normal0(Camera* camera);
s32 Camera_Normal1(Camera* camera);
s32 Camera_Normal2(Camera* camera);
s32 Camera_Normal3(Camera* camera);
s32 Camera_Normal4(Camera* camera);
s32 Camera_Parallel0(Camera* camera);
s32 Camera_Parallel1(Camera* camera);
s32 Camera_Parallel2(Camera* camera);
s32 Camera_Parallel3(Camera* camera);
s32 Camera_Parallel4(Camera* camera);
s32 Camera_KeepOn0(Camera* camera);
s32 Camera_KeepOn1(Camera* camera);
s32 Camera_KeepOn2(Camera* camera);
s32 Camera_KeepOn3(Camera* camera);
s32 Camera_KeepOn4(Camera* camera);
s32 Camera_Subj0(Camera* camera);
s32 Camera_Subj1(Camera* camera);
s32 Camera_Subj2(Camera* camera);
s32 Camera_Subj3(Camera* camera);
s32 Camera_Subj4(Camera* camera);
s32 Camera_Jump0(Camera* camera);
s32 Camera_Jump1(Camera* camera);
s32 Camera_Jump2(Camera* camera);
s32 Camera_Jump3(Camera* camera);
s32 Camera_Jump4(Camera* camera);
s32 Camera_Battle0(Camera* camera);
s32 Camera_Battle1(Camera* camera);
s32 Camera_Battle2(Camera* camera);
s32 Camera_Battle3(Camera* camera);
s32 Camera_Battle4(Camera* camera);
s32 Camera_Fixed0(Camera* camera);
s32 Camera_Fixed1(Camera* camera);
s32 Camera_Fixed2(Camera* camera);
s32 Camera_Fixed3(Camera* camera);
s32 Camera_Fixed4(Camera* camera);
s32 Camera_Data0(Camera* camera);
s32 Camera_Data1(Camera* camera);
s32 Camera_Data2(Camera* camera);
s32 Camera_Data3(Camera* camera);
s32 Camera_Data4(Camera* camera);
s32 Camera_Unique0(Camera* camera);
s32 Camera_Unique1(Camera* camera);
s32 Camera_Unique2(Camera* camera);
s32 Camera_Unique3(Camera* camera);
s32 Camera_Unique4(Camera* camera);
s32 Camera_Unique5(Camera* camera);
s32 Camera_Unique6(Camera* camera);
s32 Camera_Unique7(Camera* camera);
s32 Camera_Unique8(Camera* camera);
s32 Camera_Unique9(Camera* camera);
s32 Camera_Demo0(Camera* camera);
s32 Camera_Demo1(Camera* camera);
s32 Camera_Demo2(Camera* camera);
s32 Camera_Demo3(Camera* camera);
s32 Camera_Demo4(Camera* camera);
s32 Camera_Demo5(Camera* camera);
s32 Camera_Demo6(Camera* camera);
s32 Camera_Demo7(Camera* camera);
s32 Camera_Demo8(Camera* camera);
s32 Camera_Demo9(Camera* camera);
s32 Camera_Special0(Camera* camera);
s32 Camera_Special1(Camera* camera);
s32 Camera_Special2(Camera* camera);
s32 Camera_Special3(Camera* camera);
s32 Camera_Special4(Camera* camera);
s32 Camera_Special5(Camera* camera);
s32 Camera_Special6(Camera* camera);
s32 Camera_Special7(Camera* camera);
s32 Camera_Special8(Camera* camera);
s32 Camera_Special9(Camera* camera);
s32 Camera_CustomRadial(Camera* camera);

typedef s32(*CameraFunc)(Camera*);
CameraFunc sCameraFunctions[] = {
    NULL,
    Camera_Normal0,
    Camera_Normal1,
    Camera_Normal2,
    Camera_Normal3,
    Camera_Normal4,
    Camera_Parallel0,
    Camera_Parallel1,
    Camera_Parallel2,
    Camera_Parallel3,
    Camera_Parallel4,
    Camera_KeepOn0,
    Camera_KeepOn1,
    Camera_KeepOn2,
    Camera_KeepOn3,
    Camera_KeepOn4,
    Camera_Subj0,
    Camera_Subj1,
    Camera_Subj2,
    Camera_Subj3,
    Camera_Subj4,
    Camera_Jump0,
    Camera_Jump1,
    Camera_Jump2,
    Camera_Jump3,
    Camera_Jump4,
    Camera_Battle0,
    Camera_Battle1,
    Camera_Battle2,
    Camera_Battle3,
    Camera_Battle4,
    Camera_Fixed0,
    Camera_Fixed1,
    Camera_Fixed2,
    Camera_Fixed3,
    Camera_Fixed4,
    Camera_Data0,
    Camera_Data1,
    Camera_Data2,
    Camera_Data3,
    Camera_Data4,
    Camera_Unique0,
    Camera_Unique1,
    Camera_Unique2,
    Camera_Unique3,
    Camera_Unique4,
    Camera_Unique5,
    Camera_Unique6,
    Camera_Unique7,
    Camera_Unique8,
    Camera_Unique9,
    Camera_Demo0,
    Camera_Demo1,
    Camera_Demo2,
    Camera_Demo3,
    Camera_Demo4,
    Camera_Demo5,
    Camera_Demo6,
    Camera_Demo7,
    Camera_Demo8,
    Camera_Demo9,
    Camera_Special0,
    Camera_Special1,
    Camera_Special2,
    Camera_Special3,
    Camera_Special4,
    Camera_Special5,
    Camera_Special6,
    Camera_Special7,
    Camera_Special8,
    Camera_Special9,
    Camera_CustomRadial,
};

s32 sInitRegs = 1; // 8011D390

s32 gDbgCamEnabled = 0;
s32 sDbgModeIdx = -1;
s16 sNextUID = 0; // size = 4 ?

s32 sCameraInterfaceFlags = 1;


s32 sCameraInterfaceAlpha = 0x02;
s32 sCameraShrinkWindowVal = 0x20;
s32 D_8011D3AC = -1;

s16 D_8011D3B0[] = {
    0x0AAA, 0xF556, 0x1555, 0xEAAB, 0x2AAA, 0xD556, 0x3FFF, 0xC001, 0x5555, 0xAAAB, 0x6AAA, 0x9556, 0x7FFF, 0x0000,
};

s16 D_8011D3CC[] = {
    0x0000, 0x02C6, 0x058C, 0x0000, 0x0000, 0xFD3A, 0x0000, 0x0852, 0x0000, 0x0000, 0x0B18, 0x02C6, 0xFA74, 0x0000,
};

s32 sUpdateCameraDirection = 0; // size = 8?
s32 D_8011D3EC = 0;
s32 D_8011D3F0 = 0;

s32 sDemo5PrevAction12Frame = -16;

char sCameraFunctionNames[][8] = {
    "NONE   ", "NORM0()", "NORM1()", "NORM2()", "NORM3()", "NORM4()", "PARA0()", "PARA1()", "PARA2()", "PARA3()",
    "PARA4()", "KEEP0()", "KEEP1()", "KEEP2()", "KEEP3()", "KEEP4()", "SUBJ0()", "SUBJ1()", "SUBJ2()", "SUBJ3()",
    "SUBJ4()", "JUMP0()", "JUMP1()", "JUMP2()", "JUMP3()", "JUMP4()", "BATT0()", "BATT1()", "BATT2()", "BATT3()",
    "BATT4()", "FIXD0()", "FIXD1()", "FIXD2()", "FIXD3()", "FIXD4()", "DATA0()", "DATA1()", "DATA2()", "DATA3()",
    "DATA4()", "UNIQ0()", "UNIQ1()", "UNIQ2()", "UNIQ3()", "UNIQ4()", "UNIQ5()", "UNIQ6()", "UNIQ7()", "UNIQ8()",
    "UNIQ9()", "DEMO0()", "DEMO1()", "DEMO2()", "DEMO3()", "DEMO4()", "DEMO5()", "DEMO6()", "DEMO7()", "DEMO8()",
    "DEMO9()", "SPEC0()", "SPEC1()", "SPEC2()", "SPEC3()", "SPEC4()", "SPEC5()", "SPEC6()", "SPEC7()", "SPEC8()",
    "SPEC9()", "RADI1()",        "",        "",        "",        "",
};

VecSph D_8011D658[] = {
    { 50.0f, 0xEE3A, 0xD558 },
    { 75.0f, 0x0000, 0x8008 },
    { 80.0f, 0xEE3A, 0x8008 },
    { 15.0f, 0xEE3A, 0x8008 },
};

Vec3f D_8011D678[] = {
    { 0.0f, 40.0f, 20.0f },
    { 0.0f, 40.0f, 0.0f },
    { 0.0f, 3.0f, -3.0f },
    { 0.0f, 3.0f, -3.0 },
};

/*******************************************************
 * OnePoint initalization values for Demo5
********************************************************/
s32 sDemo5PrevSfxFrame = -200;

// target is player, far from eye
OnePointDemoFull D_8011D6AC[] = {
    {
        // initflags & 0x00FF (at): 2, atTarget is view lookAt + atInit
        // initFlags & 0xFF00 (eye): none
        // action: 15, copy at, eye, roll, fov to camera
        // result: eye remains in the same locaiton, at is View's lookAt
        0x8F, 0xFF, 0x0002, 0x0001, 0x0000, 60.0f, 1.0f,
        { 0.0f, 0.0f, 0.0f },
        { 0.0f, 0.0f, 0.0f }
    },
    {
        // initFlags & 0x00FF (at): 3, atTarget is camera's current at + atInit
        // initFlags & 0xFF00 (eye): 3, eyeTarget is the camera's current eye + eyeInit
        // action: interplate eye and at.
        // result: eye and at's y interpolate to become +20 from their current location.
        0x81, 0xFF, 0x0303, 0x0013, 0x0000, 45.0f, 1.0f,
        { 0.0f, 20.0f, 0.0f },
        { 0.0f, 20.0f, 0.0f}
    },
    {
        // initFlags & 0x00FF (at): 0 none
        // initFlags & 0xFF00 (eye): 0 none
        // action: 18, copy this camera to default camera.
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// target is player close to current eye
OnePointDemoFull D_8011D724[] = {
    {
        0x8F, 0xFF, 0x2424, 0x0001, 0x0000, 60.0f, 1.0f,
        { 0.0f, 0.0f, 0.0f },
        { 0.0f, 10.0f, -20.0f }
    },
    {
        0x81, 0xFF, 0x2121, 0x0013, 0x0000, 50.0f, 1.0f,
        { 0.0f, -10.0f, 0.0f },
        { 0.0f, 0.0f, 60.0f }
    },
    { 
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// target is close to player
OnePointDemoFull D_8011D79C[] = {
    {
        0xCF, 0xFF, 0x0002, 0x0001, 0x0000, 60.0f, 1.0f,
        { 0.0f, 0.0f, 0.0f },
        { 0.0f, 0.0f, 0.0f }
    },
    {
        0xC1, 0xFF, 0x0303, 0x0013, 0x0000, 45.0f, 1.0f,
        { 0.0f, -20.0f, 0.0f },
        { 0.0f, -10.0f, 5.0f }
    },
    {
        0xC1, 0xFF, 0x0303, 0x0009, 0x0000, 60.0f, 1.0f,
        { 0.0f, 10.0f, 0.0f },
        { 0.0f, 10.0f, 0.0f },
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// target is within 300 units of eye, and player is within 30 units of eye
OnePointDemoFull D_8011D83C[] = {
    {
        0x83, 0xFF, 0x2141, 0x0014, 0x0000, 45.0f, 0.2f,
        { 0.0f, 0.0f, 10.0f },
        { 0.0f, 0.0f, 10.0f }
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// target is within 700 units of eye, angle between player/eye and target/eye is less than
// 76.9 degrees.  The x/y coordinates of the target on screen is between (21, 41) and (300, 200),
// and the player is farther than 30 units of the eye
OnePointDemoFull D_8011D88C[] = {
    { 
        0x81, 0xFF, 0x0303, 0x0014, 0x0000, 45.0f, 1.0f,
        { 0.0f, 0.0f, 0.0f },
        { 0.0f, 0.0f, 0.0f }
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// same as above, but the target is NOT within the screen area.
OnePointDemoFull D_8011D8DC[] = {
    {
        0x8F, 0xFF, 0x0404, 0x0014, 0x0001, 50.0f, 1.0f,
        { 0.0f, 5.0f, 10.0f },
        { 0.0f, 10.0f, -80.0f }
    },
    {
        0x82, 0xFF, 0x2121, 0x0005, 0x0000, 60.0f, 1.0f,
        { 0.0f, 5.0f, 0.0f },
        { 5.0f, 5.0f, -200.0f }
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// target is a door.
OnePointDemoFull D_8011D954[] = {
    {
        0x0F, 0xFF, 0xC1C1, 0x0014, 0x0000, 60.0f, 1.0f,
        { 0.0f, 0.0f, 50.0f },
        { 0.0f, 0.0f, 250.0f }
    },
    {
        0x83, 0xFF, 0x05B1, 0x0005, 0x0000, 60.0f, 0.1f,
        { 0.0f, 10.0f, 50.0f },
        { 0.0f, 10.0f, 100.0f }
    },
    {
        0x82, 0xFF, 0x2121, 0x0005, 0x0002, 60.0f, 1.0f,
        { 0.0f, 10.0f, 0.0f },
        { 0.0f, 20.0f, -150.0f }
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

// otherwise
OnePointDemoFull D_8011D9F4[] = {
    {
        0x8F, 0xFF, 0x0504, 0x0014, 0x0002, 60.0f, 1.0f,
        { 0.0f, 5.0f, 50.0f },
        { 0.0f, 20.0f, 300.0f }
    },
    {
        0x82, 0xFF, 0x2121, 0x0005, 0x0002, 60.0f, 1.0f,
        { 0.0f, 10.0f, 0.0f },
        { 0.0f, 20.0f, -150.0f }
    },
    {
        0x12, 0xFF, 0x0000, 0x0001, 0x0000, 60.0f, 1.0f,
        { -1.0f, -1.0f, -1.0f },
        { -1.0f, -1.0f, -1.0f }
    },
};

Vec3f D_8011DA6C[] = {
    { 3050.0f, 700.0f, 0.0f },
    { 1755.0f, 3415.0f, -380.0f },
    { -3120.0f, 3160.0f, 245.0f },
    { 0.0f, -10.0f, 240.0f }
};

Vec3f D_8011DA9C[] = {
    { 3160.0f, 2150.0f, 0.0f },
    { 1515.0f, 4130.0f, -835.0f },
    { -3040.0f, 4135.0f, 230.0f },
    { -50.0f, 600.0f, -75.0f }, 
};

f32 D_8011DACC[] = {
    1570.0f, 3680.0f, 3700.0f, 395.0f
};

f32 D_8011DADC[] = {
    320.0f, 320.0f, 320.0f, 0.0f
};

s16 D_8011DAEC[] = { -2000, -1000, 0, 0, 0, 0, 0, 0 };

s16 D_8011DAFC[] = {
    CAM_SET_NORMAL0, CAM_SET_NORMAL1, CAM_SET_NORMAL2, CAM_SET_DUNGEON0, CAM_SET_DUNGEON1, CAM_SET_DUNGEON2,
};

Vec3f D_8015BD50;
Vec3f D_8015BD60;
Vec3f D_8015BD70;
GlobalContext* D_8015BD7C;
DBCamera D_8015BD80;
CollisionPoly *playerFloorPoly;

// statics
f32 D_8015CE50;
f32 D_8015CE54;
CamColChk D_8015CE58;

CamColChk D_8015CE80;
CamColChk D_8015CEA8;
CamColChk D_8015CED0;
