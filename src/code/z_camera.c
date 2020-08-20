#include <ultra64.h>
#include <global.h>
#include <vt.h>

s16 Camera_ChangeSettingFlags(Camera*, s16, s16);
s32 Camera_ChangeMode(Camera* camera, s16 mode, u8 flags);
s32 Camera_ChangeModeDefaultFlags(Camera* camera, s16 mode);
s32 Camera_ChangeDataIdx(Camera* arg0, s32 arg1);
s32 func_800458D4(Camera* camera, VecSph* arg1, f32 arg2, f32* arg3, s16 arg4);
s16 func_80046CB4(Camera* camera, s16 arg1, s16 arg2, f32 arg3, f32 arg4);
s32 func_80045C74(Camera *camera, VecSph *arg1, f32 arg2, f32 *arg3, s16 arg4);
s32 Camera_QRegInit(void);

//#define NON_MATCHING

#include "z_camera_data.c"

/*===============================================================*/

f32 func_800437F0(f32 arg0, f32 arg1) {
    const f32 t = 0.4f;
    f32 t2;
    f32 temp_f0;

    temp_f0 = fabsf(arg1);
    if (arg0 < temp_f0) {
        temp_f0 = 1.0f;
    } else {
        t2 = 1.0f - t;
        if ((arg0 * t2) > temp_f0) {
            temp_f0 = (SQ(arg1) * (1.0f - t)) / SQ(arg0 * (1.0f - t));
        } else {
            temp_f0 = 1.0f - ((SQ(arg0 - temp_f0) * t) / SQ(0.4f * arg0));
        }
    }
    return temp_f0;
}

/*
 * Performs linear interpoloation between `cur` and `target`.  If `cur` is within
 * `minDiff` units, The result is rounded up to `target`
*/
f32 Camera_LERPCeilF(f32 target, f32 cur, f32 stepScale, f32 minDiff) {
    f32 diff = target - cur;
    f32 step;
    f32 ret;

    if (fabsf(diff) >= minDiff) {
        step = diff * stepScale;
        ret = cur + step;
    } else {
        ret = target;
    }

    return ret;
}

/*
 * Performs linear interpoloation between `cur` and `target`.  If `cur` is within
 * `minDiff` units, The result is rounded down to `cur`
*/
f32 Camera_LERPFloorF(f32 target, f32 cur, f32 stepScale, f32 minDiff) {
    f32 diff = target - cur;
    f32 step;
    f32 ret;

    if (fabsf(diff) >= minDiff) {
        step = diff * stepScale;
        ret = cur + step;
    } else {
        ret = cur;
    }

    return ret;
}

/*
 * Performs linear interpoloation between `cur` and `target`.  If `cur` is within
 * `minDiff` units, The result is rounded up to `target`
*/
s16 Camera_LERPCeilS(s16 target, s16 cur, f32 stepScale, s16 minDiff) {
    s16 diff = target - cur;
    s16 step;
    s32 ret;

    if (ABS(diff) >= minDiff) {
        step = diff * stepScale + 0.5f;
        ret = cur + step;
    } else {
        ret = target;
    }

    return ret;
}

/*
 * Performs linear interpoloation between `cur` and `target`.  If `cur` is within
 * `minDiff` units, The result is rounded down to `cur`
*/
s16 Camera_LERPFloorS(s16 target, s16 cur, f32 stepScale, s16 minDiff) {
    s16 diff = target - cur;
    s16 step;
    s32 ret;

    if (ABS(diff) >= minDiff) {
        step = diff * stepScale + 0.5f;
        ret = cur + step;
    } else {
        ret = cur;
    }

    return ret;
}

/*
 * Performs linear interpoloation between `cur` and `target`.  If `cur` is within
 * `minDiff` units, The result is rounded up to `target`
*/
void Camera_LERPCeilVec3f(Vec3f* target, Vec3f* cur, f32 yStepScale, f32 xzStepScale, f32 minDiff) {
    cur->x = Camera_LERPCeilF(target->x, cur->x, xzStepScale, minDiff);
    cur->y = Camera_LERPCeilF(target->y, cur->y, yStepScale, minDiff);
    cur->z = Camera_LERPCeilF(target->z, cur->z, xzStepScale, minDiff);
}

void func_80043ABC(Camera* camera) {
    camera->yawUpdateRateInv = 100.0f;
    camera->pitchUpdateRateInv = R_CAM_DEFA_PHI_UPDRATE;
    camera->rUpdateRateInv = OREG(6);
    camera->xzOffsetUpdateRate = PCT(OREG(2));
    camera->yOffsetUpdateRate = PCT(OREG(3));
    camera->fovUpdateRate = PCT(OREG(4));
}

void func_80043B60(Camera* camera) {
    camera->rUpdateRateInv = OREG(27);
    camera->yawUpdateRateInv = OREG(27);
    camera->pitchUpdateRateInv = OREG(27);
    camera->xzOffsetUpdateRate = 0.001f;
    camera->yOffsetUpdateRate = 0.001f;
    camera->fovUpdateRate = 0.001f;
}

Vec3f* Camera_Vec3sToVec3f(Vec3f* dest, Vec3s* src) {
    Vec3f copy;

    copy.x = src->x;
    copy.y = src->y;
    copy.z = src->z;

    *dest = copy;
    return dest;
}

Vec3f* Camera_Vec3fVecSphGeoAdd(Vec3f* dest, Vec3f* a, VecSph* b) {
    Vec3f copy, vecB;
    OLib_VecSphGeoToVec3f(&vecB, b);

    copy.x = a->x + vecB.x;
    copy.y = a->y + vecB.y;
    copy.z = a->z + vecB.z;

    *dest = copy;
    return dest;
}

Vec3f* Camera_Vec3fScaleXYZFactor(Vec3f* dest, Vec3f* src, Vec3f* scale, f32 scaleFactor) {
    Vec3f copy;

    copy.x = src->x + (scale->x * scaleFactor);
    copy.y = src->y + (scale->y * scaleFactor);
    copy.z = src->z + (scale->z * scaleFactor);

    *dest = copy;
    return dest;
}

/**
 * Detects the collision poly between `from` and `to`
*/
s32 func_80043D18(Camera* camera, Vec3f* from, CamColChk* to) {
    CollisionContext* colCtx;
    Vec3f toNewPos, toPoint, fromToNorm;
    f32 floorPolyY;
    CollisionPoly* floorPoly;
    s32 floorBgId;
    VecSph fromToOffset;

    colCtx = &camera->globalCtx->colCtx;
    OLib_Vec3fDiffToVecSphGeo(&fromToOffset, from, &to->pos);
    fromToOffset.r += 8.0f;
    Camera_Vec3fVecSphGeoAdd(&toPoint, from, &fromToOffset);

    if (!func_8003DD6C(colCtx, from, &toPoint, &toNewPos, &to->poly, 1, 1, 1, -1, &to->bgId)) {
        // no poly in path.
        OLib_Vec3fDistNormalize(&fromToNorm, from, &to->pos);

        to->norm.x = -fromToNorm.x;
        to->norm.y = -fromToNorm.y;
        to->norm.z = -fromToNorm.z;

        toNewPos = to->pos;
        toNewPos.y += 5.0f;
        floorPolyY = func_8003CCA4(colCtx, &floorPoly, &floorBgId, &toNewPos);

        if ((to->pos.y - floorPolyY) > 5.0f) {
            // if the y distance from the check point to the floor is more than 5 units
            // the point is not colliding with any collision.
            to->pos.x += to->norm.x;
            to->pos.y += to->norm.y;
            to->pos.z += to->norm.z;
            return 0;
        }

        to->poly = floorPoly;
        toNewPos.y = floorPolyY + 1.0f;
        to->bgId = floorBgId;
    }
    
    to->norm.x = to->poly->norm.x * COLPOLY_NORM_FRAC;
    to->norm.y = to->poly->norm.y * COLPOLY_NORM_FRAC;
    to->norm.z = to->poly->norm.z * COLPOLY_NORM_FRAC;
    to->pos.x = to->norm.x + toNewPos.x;
    to->pos.y = to->norm.y + toNewPos.y;
    to->pos.z = to->norm.z + toNewPos.z;

    return floorBgId + 1;
}

s32 func_80043F34(Camera* camera, Vec3f* from, Vec3f* to) {
    CamColChk toCol;
    s32 bgId;

    toCol.pos = *to;
    bgId = func_80043D18(camera, from, &toCol);
    *to = toCol.pos;
    return bgId;
}

s32 func_80043F94(Camera *camera, Vec3f *from, CamColChk *to) {
    CollisionContext* colCtx;
    Vec3f toNewPos;
    Vec3f toPos;
    Vec3f fromToNorm;
    Vec3f playerFloorNormF;
    f32 floorY;
    CollisionPoly *floorPoly;
    s32 bgId;
    VecSph fromToGeo;
    
    colCtx = &camera->globalCtx->colCtx;
    OLib_Vec3fDiffToVecSphGeo(&fromToGeo, from, &to->pos);
    fromToGeo.r += 8.0f;
    Camera_Vec3fVecSphGeoAdd(&toPos, from, &fromToGeo);
    if (!func_8003DD6C(colCtx, from, &toPos, &toNewPos, &to->poly, 1, 1, 1, -1, &to->bgId)) {
        OLib_Vec3fDistNormalize(&fromToNorm, from, &to->pos);
        to->norm.x = -fromToNorm.x;
        to->norm.y = -fromToNorm.y;
        to->norm.z = -fromToNorm.z;
        toNewPos = to->pos;
        toNewPos.y += 5.0f;
        floorY = func_8003CCA4(colCtx, &floorPoly, &bgId, &toNewPos);
        if ((to->pos.y - floorY) > 5.0f) {
            // to is not on the ground or below it.
            to->pos.x += to->norm.x;
            to->pos.y += to->norm.y;
            to->pos.z += to->norm.z;
            return 0;
        }
        // to is touching the ground, move it up 1 unit.
        to->poly = floorPoly;
        toNewPos.y = floorY + 1.0f;
        to->bgId = bgId;
    }
    to->norm.x = to->poly->norm.x * COLPOLY_NORM_FRAC;
    to->norm.y = to->poly->norm.y * COLPOLY_NORM_FRAC;
    to->norm.z = to->poly->norm.z * COLPOLY_NORM_FRAC;
    if ((to->norm.y > 0.5f) || (to->norm.y < -0.8f)) {
        to->pos.x = to->norm.x + toNewPos.x;
        to->pos.y = to->norm.y + toNewPos.y;
        to->pos.z = to->norm.z + toNewPos.z;
    } else if (playerFloorPoly != NULL) {
        playerFloorNormF.x = playerFloorPoly->norm.x * COLPOLY_NORM_FRAC;
        playerFloorNormF.y = playerFloorPoly->norm.y * COLPOLY_NORM_FRAC;
        playerFloorNormF.z = playerFloorPoly->norm.z * COLPOLY_NORM_FRAC;
        if (Math3D_LineSegVsPlane(playerFloorNormF.x, playerFloorNormF.y, playerFloorNormF.z, playerFloorPoly->dist, from, &toPos, &toNewPos, 1)) {
            // line is from->to is touching the poly the player is on.
            to->norm = playerFloorNormF;
            to->poly = playerFloorPoly;
            to->bgId = camera->bgCheckId;
            to->pos.x = to->norm.x + toNewPos.x;
            to->pos.y = to->norm.y + toNewPos.y;
            to->pos.z = to->norm.z + toNewPos.z;
        } else {
            OLib_Vec3fDistNormalize(&fromToNorm, from, &to->pos);
            to->norm.x = -fromToNorm.x;
            to->norm.y = -fromToNorm.y;
            to->norm.z = -fromToNorm.z;
            to->pos.x += to->norm.x;
            to->pos.y += to->norm.y;
            to->pos.z += to->norm.z;
            return 0;
        }
    }
    return 1;
}

void func_80044340(Camera* camera, Vec3f* arg1, Vec3f* arg2) {
    CamColChk sp20;
    Vec3s unused;

    sp20.pos = *arg2;
    func_80043F94(camera, arg1, &sp20);
    *arg2 = sp20.pos;
}

s32 func_800443A0(Camera* camera, Vec3f* arg1, Vec3f* arg2) {
    s32 pad;
    Vec3f sp40;
    s32 pad2;
    s32 sp38;
    CollisionPoly* sp34;
    CollisionContext* colCtx;
    colCtx = &camera->globalCtx->colCtx;

    sp34 = NULL;
    if (func_8003DD6C(colCtx, arg1, arg2, &sp40, &sp34, 1, 1, 1, 0, &sp38) && (func_80038B7C(sp34, arg1) < 0.0f)) {
        return true;
    }

    return false;
}

f32 func_80044434(Camera* camera, Vec3f* floorNorm, Vec3f* arg2, s32* bgId) {
    s32 sp2C; // unused
    CollisionPoly* floorPoly;
    f32 temp_ret = func_8003C940(&camera->globalCtx->colCtx, &floorPoly, bgId, arg2);

    if (temp_ret == BGCHECK_Y_MIN) {
        floorNorm->x = 0.0f;
        floorNorm->z = 0.0f;
        floorNorm->y = 1.0f;
    } else {
        floorNorm->x = floorPoly->norm.x * COLPOLY_NORM_FRAC;
        floorNorm->y = floorPoly->norm.y * COLPOLY_NORM_FRAC;
        floorNorm->z = floorPoly->norm.z * COLPOLY_NORM_FRAC;
    }

    return temp_ret;
}

f32 func_80044510(Camera* camera, Vec3f* pos) {
    Vec3f posCheck, floorNorm;
    s32 bgId;

    posCheck = *pos;
    posCheck.y += 80.0f;

    return func_80044434(camera, &floorNorm, &posCheck, &bgId);
}

f32 func_80044568(Camera *camera, Vec3f *norm, Vec3f *pos, u32 *bgId) {
    CollisionPoly *floorPoly;
    CollisionContext *colCtx = &camera->globalCtx->colCtx;
    f32 floorY;
    s32 i;

    for(i = 3; i > 0; i--){
        floorY = func_8003CCA4(colCtx, &floorPoly, bgId, pos);
        if (floorY == BGCHECK_Y_MIN || (camera->playerGroundY < floorY && !((floorPoly->norm.y * COLPOLY_NORM_FRAC) > 0.5f))) {
            norm->x = 0.0f;
            norm->y = 1.0f;
            norm->z = 0.0f;
            floorY = BGCHECK_Y_MIN;
            break;
        } else if (func_80041D4C(colCtx, floorPoly, *bgId) == 1) {
            // poly behavior == 1, what is 1? grass in kokiri forest
            pos->y = floorY - 10.0f;
            continue;
        } else {
            norm->x = floorPoly->norm.x * COLPOLY_NORM_FRAC;
            norm->y = floorPoly->norm.y * COLPOLY_NORM_FRAC;
            norm->z = floorPoly->norm.z * COLPOLY_NORM_FRAC;
            break;
        }
    }
    if (i == 0) {
        osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: foward check: too many layer!\n" VT_RST);
    }
    return floorY;
}

s16 Camera_GetCamDataSetting(Camera* camera, s32 camDataIdx) {
    return func_80041A4C(&camera->globalCtx->colCtx, camDataIdx, 50);
}

CamPosData* func_8004476C(Camera* camera) {
    return func_80041C10(&camera->globalCtx->colCtx, camera->camDataIdx, 50);
}

s32 func_8004479C(Camera* camera, u32* arg1, CollisionPoly* arg2) {
    s32 temp_ret;
    PosRot sp20;
    s32 ret;

    func_8002EF44(&sp20, &camera->player->actor);
    temp_ret = func_80041A28(&camera->globalCtx->colCtx, arg2, *arg1);

    if (func_80041A4C(&camera->globalCtx->colCtx, temp_ret, *arg1) == 0) {
        ret = -1;
    } else {
        ret = temp_ret;
    }
    return ret;
}

Vec3s* func_8004481C(Camera* camera, u16* cameraCnt) {
    CollisionPoly* floorPoly;
    s32 pad;
    s32 bgId;
    PosRot playerPosShape;

    func_8002EF44(&playerPosShape, &camera->player->actor);
    playerPosShape.pos.y += Player_GetCameraYOffset(camera->player);
    if (func_8003C940(&camera->globalCtx->colCtx, &floorPoly, &bgId, &playerPosShape.pos) == BGCHECK_Y_MIN) {
        return NULL;
    }
    *cameraCnt = func_80041B80(&camera->globalCtx->colCtx, floorPoly, bgId);
    return func_80041C98(&camera->globalCtx->colCtx, floorPoly, bgId);
}

/**
 * Gets the Camera information for the water box the player is in.
 * Returns -1 if the player is not in a water box, or does not have a swimming state.
 * Returns -2 if there is no camera index for the water box.
 * Returns the camera setting otherwise.
*/
s32 func_800448CC(Camera* camera, f32* waterY) {
    PosRot playerPosShape;
    WaterBox* waterBox;
    s32 temp_ret;

    func_8002EF44(&playerPosShape, &camera->player->actor);
    *waterY = playerPosShape.pos.y;

    if (func_8004213C(camera->globalCtx, &camera->globalCtx->colCtx, playerPosShape.pos.x, playerPosShape.pos.z, waterY, &waterBox) == 0) {
        // player's position is not in a water box.
        *waterY = BGCHECK_Y_MIN;
        return -1;
    }
    if (!(camera->player->stateFlags1 & 0x8000000)) {
        // player is not swimming
        *waterY = BGCHECK_Y_MIN;
        return -1;
    }

    temp_ret = func_80042538(&camera->globalCtx->colCtx, waterBox);
    if ((temp_ret <= 0) || (func_80042548(&camera->globalCtx->colCtx, waterBox) <= 0)) {
        return -2;
    }

    return temp_ret;
}

f32 func_800449AC(Camera* camera, Vec3f* arg1, s32* arg2) {
    PosRot sp2C;
    f32 sp28;
    WaterBox* sp24;

    func_8002EF44(&sp2C, &camera->player->actor);
    sp28 = sp2C.pos.y;

    if (func_8004213C(camera->globalCtx, &camera->globalCtx->colCtx, arg1->x, arg1->z, &sp28, &sp24) == 0) {
        return BGCHECK_Y_MIN;
    }
    if (sp28 < arg1->y) {
        return BGCHECK_Y_MIN;
    }

    *arg2 = func_8004259C(&camera->globalCtx->colCtx, sp24);
    return sp28;
}

/**
 * Calculates the angle between points `from` and `to`
*/
s16 Camera_XZAngle(Vec3f* to, Vec3f* from) {
    return DEGF_TO_BINANG(RADF_TO_DEGF(Math_atan2f(from->x - to->x, from->z - to->z)));
}

#ifdef NON_MATCHING
// matching, but marked NON_MATCHING until bss is resolved.
s16 func_80044ADC(Camera *camera, s16 yaw, s16 arg2) {
    static f32 D_8015CE50;
    static f32 D_8015CE54;
    static CamColChk D_8015CE58;

    Vec3f playerPos;
    Vec3f rotatedPos;
    Vec3f floorNorm;
    f32 temp_f2;
    s16 temp_s0;
    s16 temp_s1;
    f32 phi_f18;
    f32 sinYaw;
    f32 cosYaw;
    u32 bgId;
    f32 sp30;
    f32 sp2C;
    f32 phi_f16;
    f32 playerYOffset;

    sinYaw = Math_Sins(yaw);
    cosYaw = Math_Coss(yaw);
    playerYOffset = Player_GetCameraYOffset(camera->player);
    temp_f2 = PCT(OREG(19)) * playerYOffset;
    sp30 = PCT(OREG(17)) * playerYOffset;
    sp2C = PCT(OREG(18)) * playerYOffset;
    playerPos.x = camera->playerPosRot.pos.x;
    playerPos.y = camera->playerGroundY + temp_f2;
    playerPos.z = camera->playerPosRot.pos.z;
    rotatedPos.x = playerPos.x + (sp30 * sinYaw);
    rotatedPos.y = playerPos.y;
    rotatedPos.z = playerPos.z + (sp30 * cosYaw);
    if (arg2 || (camera->globalCtx->state.frames % 2) == 0) {
        D_8015CE58.pos.x = playerPos.x + (sp2C * sinYaw);
        D_8015CE58.pos.y = playerPos.y;
        D_8015CE58.pos.z = playerPos.z + (sp2C * cosYaw);
        func_80043D18(camera, &playerPos, &D_8015CE58);
        if (arg2) {
            D_8015CE50 = D_8015CE54 = camera->playerGroundY;
        }
    } else {
        sp2C = OLib_Vec3fDistXZ(&playerPos, &D_8015CE58.pos);
        D_8015CE58.pos.x += D_8015CE58.norm.x * 5.0f;
        D_8015CE58.pos.y += D_8015CE58.norm.y * 5.0f;
        D_8015CE58.pos.z += D_8015CE58.norm.z * 5.0f;
        if (sp2C < sp30) {
            sp30 = sp2C;
            D_8015CE50 = D_8015CE54 = func_80044568(camera, &floorNorm, &D_8015CE58.pos, &bgId);
        } else {
            D_8015CE50 = func_80044568(camera, &floorNorm, &rotatedPos, &bgId);
            D_8015CE54 = func_80044568(camera, &floorNorm, &D_8015CE58.pos, &bgId);
        }

        if(D_8015CE50 == BGCHECK_Y_MIN){
            D_8015CE50 = camera->playerGroundY;
        }

        if(D_8015CE54 == BGCHECK_Y_MIN){
            D_8015CE54 = D_8015CE50;
        }
        
    }
    phi_f16 = PCT(OREG(20)) * (D_8015CE50 - camera->playerGroundY);
    phi_f18 = (1.0f - PCT(OREG(20))) * (D_8015CE54 - camera->playerGroundY);
    temp_s0 = DEGF_TO_BINANG(RADF_TO_DEGF(Math_atan2f(phi_f16, sp30)));
    temp_s1 = DEGF_TO_BINANG(RADF_TO_DEGF(Math_atan2f(phi_f18, sp2C)));
    return temp_s0 + temp_s1;
            
}
#else
s16 func_80044ADC(Camera* camera, s16, s32);
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_80044ADC.s")
#endif
#undef NON_MATCHING

Vec3f *Camera_CalcUpFromPitchYawRoll(Vec3f *dest, s16 pitch, s16 yaw, s16 roll) {
    f32 sinPitch;
    f32 cosPitch;
    f32 sinYaw;
    f32 cosYaw;
    f32 sinNegRoll;
    f32 cosNegRoll;
    Vec3f spA4;
    f32 pad;
    f32 sp54;
    f32 sp4C;
    f32 cosPitchCosYawSinRoll;
    f32 negSinPitch;
    f32 temp_f10_2;
    f32 cosPitchcosYaw;
    f32 temp_f14;
    f32 negSinPitchSinYaw;
    f32 negSinPitchCosYaw;
    f32 cosPitchSinYaw;
    f32 temp_f4_2;
    f32 temp_f6;
    f32 temp_f8;
    f32 temp_f8_2;
    f32 temp_f8_3;

    sinPitch = Math_Sins(pitch);
    cosPitch = Math_Coss(pitch);
    sinYaw = Math_Sins(yaw);
    cosYaw = Math_Coss(yaw);
    negSinPitch = -sinPitch;
    sinNegRoll = Math_Sins(-roll);
    cosNegRoll = Math_Coss(-roll);
    negSinPitchSinYaw = negSinPitch * sinYaw;
    temp_f14 = 1.0f - cosNegRoll;
    cosPitchSinYaw = cosPitch * sinYaw;
    sp54 = SQ(cosPitchSinYaw);
    sp4C = (cosPitchSinYaw * sinPitch) * temp_f14;
    cosPitchcosYaw = cosPitch * cosYaw;
    temp_f4_2 = ((1.0f - sp54) * cosNegRoll) + sp54;
    cosPitchCosYawSinRoll = cosPitchcosYaw * sinNegRoll;
    negSinPitchCosYaw = negSinPitch * cosYaw;
    temp_f6 = (cosPitchcosYaw * cosPitchSinYaw) * temp_f14;
    temp_f10_2 = sinPitch * sinNegRoll;
    spA4.x = ((negSinPitchSinYaw * temp_f4_2) + (cosPitch * (sp4C - cosPitchCosYawSinRoll))) + (negSinPitchCosYaw * (temp_f6 + temp_f10_2));
    sp54 = SQ(sinPitch);
    temp_f4_2 = (sinPitch * cosPitchcosYaw) * temp_f14;
    temp_f8_3 = cosPitchSinYaw * sinNegRoll;
    temp_f8 = sp4C + cosPitchCosYawSinRoll;
    spA4.y = ((negSinPitchSinYaw * temp_f8) + (cosPitch * (((1.0f - sp54) * cosNegRoll) + sp54))) + (negSinPitchCosYaw * (temp_f4_2 - temp_f8_3));
    temp_f8_2 = temp_f6 - temp_f10_2;
    spA4.z = ((negSinPitchSinYaw * temp_f8_2) + (cosPitch * (temp_f4_2 + temp_f8_3))) + (negSinPitchCosYaw * (((1.0f - SQ(cosPitchcosYaw)) * cosNegRoll) + SQ(cosPitchcosYaw)));
    *dest = spA4;
    return dest;
}

f32 Camera_ClampLERPScale(Camera* camera, f32 maxLERPScale) {
    f32 ret;

    if (camera->atLERPStepScale < PCT(R_AT_LERP_MIN)) {
        ret = PCT(R_AT_LERP_MIN);
    } else if (camera->atLERPStepScale >= maxLERPScale) {
        ret = maxLERPScale;
    } else {
        ret = PCT(R_AT_LERP_SCALE) * camera->atLERPStepScale;
    }

    return ret;
}

void Camera_CopyModeValuesToPREG(Camera* camera, s16 mode) {
    CameraModeValue *values;
    CameraModeValue *valueP;
    s32 i;

    if (PREG(82)) {
        osSyncPrintf("camera: res: stat (%d/%d/%d)\n", camera->thisIdx, camera->setting, mode);
    }

    values = sCameraSettings[camera->setting].cameraModes[mode].values;

    for (i = 0;i < sCameraSettings[camera->setting].cameraModes[mode].valueCnt; i++) {
        valueP = &values[i];
        PREG(valueP->param) = valueP->val;
        if (PREG(82)) {
            osSyncPrintf("camera: res: PREG(%02d) = %d\n", valueP->param, valueP->val);
        }
    }
    camera->animState = 0;
}

s32 Camera_CopyPREGToModeValues(Camera* camera) {
    CameraModeValue* values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
    CameraModeValue* valueP;
    s32 i;

    for (i = 0; i < sCameraSettings[camera->setting].cameraModes[camera->mode].valueCnt; i++) {
        valueP = &values[i];
        valueP->val = PREG(valueP->param);
        if (PREG(82)) {
            osSyncPrintf("camera: res: %d = PREG(%02d)\n", valueP->val, valueP->param);
        }
    }
    return true;
}

void Camera_UpdateInterface(s16 arg0) {
    s16 interfaceAlpha;

    if((arg0 & 0xF000) != 0xF000){
        switch(arg0 & 0x7000){
            case 0x1000:
                sCameraShrinkWindowVal = 0x1A;
                break;
            case 0x2000:
                sCameraShrinkWindowVal = 0x1B;
                break;
            case 0x3000:
                sCameraShrinkWindowVal = 0x20;
                break;
            default:
                sCameraShrinkWindowVal = 0;
                break;
        }

        if(arg0 & 0x8000){
            ShrinkWindow_SetCurrentVal(sCameraShrinkWindowVal);
        } else {
            ShrinkWindow_SetVal(sCameraShrinkWindowVal);
        }
    }

    if ((arg0 & 0xF00) != 0xF00) {
        interfaceAlpha = (arg0 & 0xF00) >> 8;
        if(interfaceAlpha == 0) {
            interfaceAlpha = 0x32;
        }
        if (interfaceAlpha != sCameraInterfaceAlpha) {
            sCameraInterfaceAlpha = interfaceAlpha;
            Interface_ChangeAlpha(sCameraInterfaceAlpha);
        }
    }
}

Vec3f* Camera_BGCheckCorner(Vec3f* dst, Vec3f* linePointA, Vec3f* linePointB, CamColChk* pointAColChk, CamColChk* pointBColChk) {
    Vec3f closestPoint;

    if (!func_800427B4(pointAColChk->poly, pointBColChk->poly, linePointA, linePointB, &closestPoint)) {
        osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: corner check no cross point %x %x\n" VT_RST, pointAColChk, pointBColChk);
        *dst = pointAColChk->pos;
        return dst;
    }

    *dst = closestPoint;
    return dst;
}

/**
 * Checks collision between at and eyeNext, if `checkEye` is set, if there is no collsion between
 * eyeNext->at, then eye->at is also checked. 
 * Returns:
 * 0 if no collsion is found between at->eyeNext
 * 2 if the angle between the polys is between 60 degrees and 120 degrees
 * 3 ?
 * 6 if the angle between the polys is greater than 120 degrees
*/
s32 func_80045508(Camera *camera, VecSph *diffSph, CamColChk *eyeChk, CamColChk *atChk, s16 checkEye) {
    Vec3f* at = &camera->at;
    Vec3f* eye = &camera->eye;
    Vec3f* eyeNext = &camera->eyeNext;

    Vec3f eyePos;
    s32 atEyeBgId;
    s32 eyeAtBgId;
    s32 ret;
    f32 cosEyeAt;

    eyeChk->pos = camera->eyeNext;
    
    ret = 0;
    
    atEyeBgId = func_80043D18(camera, at, eyeChk);
    if (atEyeBgId != 0) {
        // collision found between at->eye
        atChk->pos = camera->at;

        OLib_Vec3fToVecSphGeo(&eyeChk->sphNorm, &eyeChk->norm);
        
        if (eyeChk->sphNorm.pitch >= 0x2EE1) {
            eyeChk->sphNorm.yaw = diffSph->yaw;
        }
        
        eyeAtBgId = func_80043D18(camera, eyeNext, atChk);
        
        if (eyeAtBgId == 0) {
            // no collision from eyeNext->at
            if (checkEye & 1) {
            
                atChk->pos = *at;
                eyePos = *eye;
                
                if (func_80043D18(camera, &eyePos, atChk) == 0) {
                    // no collision from eye->at
                    return 3;
                } else if (eyeChk->poly == atChk->poly) {
                    // at->eye and eye->at is the same poly
                    return 3;
                }
            } else {
                return 3;
            }
        } else if (eyeChk->poly == atChk->poly) {
            // at->eyeNext and eyeNext->at is the same poly
            return 3;
        }

        OLib_Vec3fToVecSphGeo(&atChk->sphNorm, &atChk->norm);
        
        if (atChk->sphNorm.pitch >= 0x2EE1) {
            atChk->sphNorm.yaw = BINANG_ROT180(diffSph->yaw);
        }

        if (atEyeBgId != eyeAtBgId) {
            // different bgIds for at->eye[Next] and eye[Next]->at
            ret = 3;
        } else {
            cosEyeAt = Math3D_Cos(&eyeChk->norm, &atChk->norm);
            if (cosEyeAt < -0.5f) {
                ret = 6;
            } else if (cosEyeAt > 0.5f) {
                ret = 3;
            } else {
                ret = 2;
            }
        }
    }
    return ret;
}

f32 func_80045714(Vec3f* arg0, s16 arg1, s16 arg2, f32 arg3) {
    f32 sp18;
    VecSph sp1C;

    OLib_Vec3fToVecSphGeo(&sp1C, arg0);
    sp18 = Math_Coss(sp1C.pitch) * Math_Coss(arg1 - sp1C.yaw);
    return (fabsf(sp18) * arg3) * Math_Coss(arg1 - arg2);
}

s32 func_800457A8(Camera* camera, VecSph* arg1, f32 extraYOffset, s16 arg3) {
    f32 unused;
    Vec3f posOffsetTarget;
    Vec3f atTarget;
    s32 unused2;
    PosRot* playerPosRot = &camera->playerPosRot;
    f32 yOffset;

    yOffset = Player_GetCameraYOffset(camera->player);

    posOffsetTarget.x = 0.f;
    posOffsetTarget.z = 0.f;
    posOffsetTarget.y = yOffset + extraYOffset;

    if (arg3) {
        posOffsetTarget.y -= OLib_ClampMaxDist(func_80045714(&camera->unk_108, playerPosRot->rot.y, arg1->yaw, OREG(9)), yOffset);
    }

    Camera_LERPCeilVec3f(&posOffsetTarget, &camera->posOffset, camera->yOffsetUpdateRate, camera->xzOffsetUpdateRate, 0.1f);

    atTarget.x = playerPosRot->pos.x + camera->posOffset.x;
    atTarget.y = playerPosRot->pos.y + camera->posOffset.y;
    atTarget.z = playerPosRot->pos.z + camera->posOffset.z;

    Camera_LERPCeilVec3f(&atTarget, &camera->at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);

    return true;
}

// Adjust pitch for y delta? 
s32 func_800458D4(Camera* camera, VecSph* arg1, f32 arg2, f32* arg3, s16 arg4) {
    f32 phi_f2;
    Vec3f posOffsetTarget;
    Vec3f atTarget;
    f32 eyeAtAngle;
    PosRot* playerPosRot = &camera->playerPosRot;
    f32 deltaY;
    s32 pad[2];

    posOffsetTarget.y = Player_GetCameraYOffset(camera->player) + arg2;
    posOffsetTarget.x = 0.0f;
    posOffsetTarget.z = 0.0f;

    if (arg4) {
        posOffsetTarget.y -= func_80045714(&camera->unk_108, playerPosRot->rot.y, arg1->yaw, OREG(9));
    }

    deltaY = playerPosRot->pos.y - *arg3;
    eyeAtAngle = Math_atan2f(deltaY, OLib_Vec3fDistXZ(&camera->at, &camera->eye));
    
    if (eyeAtAngle > DEGF_TO_RADF(OREG(32))) {
        if(1){}
        phi_f2 = 1.0f - sinf(DEGF_TO_RADF(eyeAtAngle - OREG(32)));
    } else if (eyeAtAngle < DEGF_TO_RADF(OREG(33))) {
        phi_f2 = 1.0f - sinf(DEGF_TO_RADF(OREG(33)) - eyeAtAngle);
    } else {
        phi_f2 = 1.0f;
    }

    posOffsetTarget.y -= deltaY * phi_f2;
    Camera_LERPCeilVec3f(&posOffsetTarget, &camera->posOffset, OREG(29) * 0.01f, OREG(30) * 0.01f, 0.1f);

    atTarget.x = playerPosRot->pos.x + camera->posOffset.x;
    atTarget.y = playerPosRot->pos.y + camera->posOffset.y;
    atTarget.z = playerPosRot->pos.z + camera->posOffset.z;
    Camera_LERPCeilVec3f(&atTarget, &camera->at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);

    return 1;
}

s32 func_80045B08(Camera* camera, VecSph* arg1, f32 yExtra, s16 arg3) {
    f32 phi_f2;
    Vec3f posOffsetTarget;
    Vec3f atTarget;
    f32 sp38; // unused
    f32 temp_ret;
    PosRot* playerPosRot = &camera->playerPosRot;

    posOffsetTarget.y = Player_GetCameraYOffset(camera->player) + yExtra;
    posOffsetTarget.x = 0.0f;
    posOffsetTarget.z = 0.0f;

    temp_ret = Math_Sins(arg3);

    if (temp_ret < 0.0f) {
        phi_f2 = Math_Coss(playerPosRot->rot.y - arg1->yaw);
    } else {
        phi_f2 = -Math_Coss(playerPosRot->rot.y - arg1->yaw);
    }

    posOffsetTarget.y -= temp_ret * phi_f2 * OREG(9);
    Camera_LERPCeilVec3f(&posOffsetTarget, &camera->posOffset, camera->yOffsetUpdateRate, camera->xzOffsetUpdateRate, 0.1f);

    atTarget.x = playerPosRot->pos.x + camera->posOffset.x;
    atTarget.y = playerPosRot->pos.y + camera->posOffset.y;
    atTarget.z = playerPosRot->pos.z + camera->posOffset.z;
    Camera_LERPCeilVec3f(&atTarget, &camera->at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);

    return 1;
}
#ifdef NON_MATCHING
// regalloc and some minor reordering. 
s32 func_80045C74(Camera *camera, VecSph *arg1, f32 arg2, f32 *arg3, s16 arg4) {
    f32 temp_f0_4;
    Vec3f sp70;
    Vec3f sp64;
    f32 sp54;
    Vec3f *at = &camera->at;
    PosRot *sp3C = &camera->playerPosRot;
    f32 temp_f14_2;
    f32 temp_f2;
    f32 phi_f20;
    f32 phi_f16;

    sp70.y = Player_GetCameraYOffset(camera->player) + arg2;
    sp70.x = 0.0f;
    sp70.z = 0.0f;
    if (PREG(76) != 0) {
        if (arg4 != 0) {
            sp70.y -= func_80045714(&camera->unk_108, sp3C->rot.y, arg1->yaw, OREG(9));
        }
    }
    if (camera->playerGroundY == camera->playerPosRot.pos.y || camera->player->actor.gravity > -0.1f || camera->player->stateFlags1 & 0x200000) {
        *arg3 = Camera_LERPCeilF(sp3C->pos.y, *arg3, OREG(43) * 0.01f, 0.1f);
        sp70.y-= sp3C->pos.y - *arg3;
        Camera_LERPCeilVec3f(&sp70, &camera->posOffset, camera->yOffsetUpdateRate, camera->xzOffsetUpdateRate, 0.1f);
    } else {
        if (PREG(75) == 0) {
            phi_f20 = sp3C->pos.y - *arg3;
            sp54 = OLib_Vec3fDistXZ(at, &camera->eye);
            Math_atan2f(phi_f20, sp54);
            temp_f2 = Math_tanf(DEG_TO_RAD(camera->fov * 0.4f)) * sp54;
            if (temp_f2 < phi_f20) {
                *arg3 += phi_f20 - temp_f2;
                phi_f20 = temp_f2;
            } else if (phi_f20 < -temp_f2) {
                *arg3 += phi_f20 + temp_f2;
                phi_f20 = -temp_f2;
            }
            sp70.y -= phi_f20;
        } else {
            phi_f20 = sp3C->pos.y - *arg3;
            temp_f0_4 = Math_atan2f(phi_f20, OLib_Vec3fDistXZ(at, &camera->eye));
            temp_f14_2 = DEG_TO_RAD(OREG(32));
            if (temp_f14_2 < temp_f0_4) {
                phi_f16 = 1.0f - sinf(temp_f0_4 - temp_f14_2);
            } else {
                temp_f14_2 = DEG_TO_RAD(OREG(33));
                if (temp_f0_4 < temp_f14_2) {
                    phi_f16 = 1.0f - sinf(temp_f14_2 - temp_f0_4);
                } else {
                    phi_f16 = 1.0f;
                }
            }
            sp70.y -= phi_f20 * phi_f16;
        }
        Camera_LERPCeilVec3f(&sp70, &camera->posOffset, OREG(29) * 0.01f, OREG(30) * 0.01f, 0.1f);
        camera->yOffsetUpdateRate = OREG(29) * 0.01f;
        camera->xzOffsetUpdateRate = OREG(30) * 0.01f;
    }
    sp64.x = sp3C->pos.x + camera->posOffset.x;
    sp64.y = sp3C->pos.y + camera->posOffset.y;
    sp64.z = sp3C->pos.z + camera->posOffset.z;
    Camera_LERPCeilVec3f(&sp64, at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_80045C74.s")
#endif

#ifdef NON_MATCHING
s32 func_800460A8(Camera *camera, VecSph *arg1, Vec3f *arg2, f32 arg3, f32 arg4, f32 *arg5, VecSph *arg6, s16 arg7) {
    f32 temp_f20;
    Vec3f sp98;
    Vec3f sp8C;
    Vec3f sp80;
    f32 phi_f16;
    VecSph sp74;
    f32 sp68;
    PosRot *sp50 = &camera->playerPosRot;
    f32 temp_f0;
    f32 temp_f0_2;
    f32 temp_f2_2;
    f32 temp_f4;

    temp_f0 = Player_GetCameraYOffset(camera->player);

    sp98.x = 0.0f;
    sp98.y = temp_f0 + arg3;
    sp98.z = 0.0f;
    if (PREG(76) && arg7 & 1) {
        sp98.y -= func_80045714(&camera->unk_108, sp50->rot.y, arg1->yaw, OREG(9));
    }
    sp8C = sp50->pos;
    sp8C.y += temp_f0;
    OLib_Vec3fDiffToVecSphGeo(arg6, &sp8C, arg2);
    sp74 = *arg6;
    if (arg4 < sp74.r) {
        sp68 = PCT(OREG(38));
        sp74.r *= sp68;
    } else{
        temp_f0_2 = OLib_ClampMaxDist((sp50->pos.y - camera->playerGroundY) / temp_f0, 1.0f);
        temp_f4 = (sp74.r * PCT(OREG(39))) - (((PCT(OREG(39)) - PCT(OREG(38))) * sp74.r) * (sp74.r / arg4));
        sp74.r = temp_f4;
        if (sp50->pos.x){}
        sp74.r -= sp74.r * temp_f0_2 * temp_f0_2;
    }

    if (arg7 & 0x80) {
        sp74.r = 0.2f * sp74.r;
        if(0){}
        camera->xzOffsetUpdateRate = 0.01f;
        camera->yOffsetUpdateRate = 0.01f;
    }
    
    OLib_VecSphGeoToVec3f(&sp80, &sp74);
    
    if (PREG(89)) {
        osSyncPrintf("%f (%f %f %f) %f\n", sp74.r / arg4, sp80.x, sp80.y, sp80.z, camera->atLERPStepScale);
    }
    
    sp98.x += sp80.x;
    sp98.y += sp80.y;
    sp98.z += sp80.z;
    
    if (((camera->playerGroundY == camera->playerPosRot.pos.y) || (-0.1f < camera->player->actor.gravity)) || camera->player->stateFlags1 & 0x200000) {
        *arg5 = Camera_LERPCeilF(sp50->pos.y, *arg5, PCT(OREG(43)), 0.1f);
        temp_f20 = sp50->pos.y - *arg5;
        sp98.y = sp98.y - temp_f20;
        Camera_LERPCeilVec3f(&sp98, &camera->posOffset, camera->yOffsetUpdateRate, camera->xzOffsetUpdateRate, 0.1f);
    } else {
        if (!(arg7 & 0x80)) {
            temp_f20 = sp50->pos.y - *arg5;
            sp68 = OLib_Vec3fDistXZ(&camera->at, &camera->eye);
            Math_atan2f(temp_f20, sp68);
            temp_f2_2 = Math_tanf(DEG_TO_RAD(camera->fov * 0.4f)) * sp68;
            if (temp_f2_2 < temp_f20) {
                *arg5 += temp_f20 - temp_f2_2;
                temp_f20 = temp_f2_2;
            } else if (temp_f20 < -temp_f2_2) {
                *arg5 += temp_f20 + temp_f2_2;
                temp_f20 = -temp_f2_2;
            }
            sp98.y -= temp_f20;
        } else {
            temp_f20 = sp50->pos.y - *arg5;
            temp_f2_2 = Math_atan2f(temp_f20, OLib_Vec3fDistXZ(&camera->at, &camera->eye));
            
            if(DEG_TO_RAD(OREG(32)) < temp_f2_2){
                phi_f16 = 1.0f - sinf(temp_f2_2 - DEG_TO_RAD(OREG(32)));
            } else if(temp_f2_2 < DEG_TO_RAD(OREG(33))){
                phi_f16 = 1.0f - sinf(DEG_TO_RAD(OREG(33)) - temp_f2_2);
            } else {
                phi_f16 = 1.0f;
            }
                
            sp98.y -= temp_f20 * phi_f16;
        }
        Camera_LERPCeilVec3f(&sp98, &camera->posOffset, PCT(OREG(29)), PCT(OREG(30)), 0.1f);
        camera->yOffsetUpdateRate = PCT(OREG(29));
        camera->xzOffsetUpdateRate = PCT(OREG(30));
    }

    
    sp8C.x = sp50->pos.x + camera->posOffset.x;
    sp8C.y = sp50->pos.y + camera->posOffset.y;
    sp8C.z = sp50->pos.z + camera->posOffset.z;
    Camera_LERPCeilVec3f(&sp8C, &camera->at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);
    return 1;
}
#else
s32 func_800460A8(Camera *camera, VecSph *arg1, Vec3f *arg2, f32 arg3, f32 arg4, f32 *arg5, VecSph *arg6, s16 arg7);
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_800460A8.s")
#endif
#undef NON_MATCHING

s32 func_800466F8(Camera* camera, VecSph* arg1, f32 arg2, f32* arg3, s16 arg4) {
    s32 phi_v0;
    Vec3f sp60;
    Vec3f sp54;
    f32 sp50; // unused
    f32 sp4C; // unused
    f32 sp48; // I doubt this is a Vec3f
    Player* sp44;
    PosRot sp30;

    sp48 = Player_GetCameraYOffset(camera->player);
    sp44 = camera->player;
    func_8002EF44(&sp30, sp44->rideActor);

    if ((*(s32*)((s32)(sp44->rideActor) + 0x1F0) & 4) != 0) { // actors aren't this big, is rideActor a different type?
        phi_v0 = 1;
    } else {
        phi_v0 = 0;
    }

    if (phi_v0 != 0) {
        sp30.pos.y -= 49.f;
        *arg3 = Camera_LERPCeilF(sp30.pos.y, *arg3, 0.1f, 0.2f);
        camera->atLERPStepScale = Camera_LERPCeilF(0.4f, camera->atLERPStepScale, 0.2f, 0.02f);
    } else {
        *arg3 = Camera_LERPCeilF(sp30.pos.y, *arg3, 0.5f, 0.2f);
    }

    sp60.x = 0.0f;
    sp60.z = 0.0f;
    sp60.y = sp48 + arg2;

    if (arg4 != 0) {
        sp60.y -= func_80045714(&camera->unk_108, camera->playerPosRot.rot.y, arg1->yaw, OREG(9));
    }

    Camera_LERPCeilVec3f(&sp60, &camera->posOffset, camera->yOffsetUpdateRate, camera->xzOffsetUpdateRate, 0.1f);

    sp54.x = camera->posOffset.x + sp30.pos.x;
    sp54.y = camera->posOffset.y + sp30.pos.y;
    sp54.z = camera->posOffset.z + sp30.pos.z;
    Camera_LERPCeilVec3f(&sp54, &camera->at, camera->atLERPStepScale, camera->atLERPStepScale, 0.2f);

    return 1;
}

f32 Camera_LERPClampDist(Camera* camera, f32 dist, f32 min, f32 max) {
    f32 distTarget;
    f32 rUpdateRateInvTarget;

    if (dist < min) {
        distTarget = min;
        rUpdateRateInvTarget = OREG(6);
    } else if (dist > max) {
        distTarget = max;
        rUpdateRateInvTarget = OREG(6);
    } else {
        distTarget = dist;
        rUpdateRateInvTarget = 1.0f;
    }

    camera->rUpdateRateInv = Camera_LERPCeilF(rUpdateRateInvTarget, camera->rUpdateRateInv, PCT(OREG(25)), 0.1f);
    return Camera_LERPCeilF(distTarget, camera->dist, 1.f / camera->rUpdateRateInv, 0.2f);
}

f32 Camera_ClampDist(Camera* camera, f32 dist, f32 minDist, f32 maxDist, s16 timer) {
    f32 distTarget;
    f32 rUpdateRateInvTarget;

    if (dist < minDist) {
        distTarget = minDist;

        rUpdateRateInvTarget = timer != 0 ? OREG(6) * 0.5f : OREG(6);
    } else if (maxDist < dist) {
        distTarget = maxDist;

        rUpdateRateInvTarget = timer != 0 ? OREG(6) * 0.5f : OREG(6);
    } else {
        distTarget = dist;

        rUpdateRateInvTarget = timer != 0 ? OREG(6) : 1.0f;
    }

    camera->rUpdateRateInv = Camera_LERPCeilF(rUpdateRateInvTarget, camera->rUpdateRateInv, PCT(OREG(25)), 0.1f);
    return Camera_LERPCeilF(distTarget, camera->dist, 1.0f / camera->rUpdateRateInv, 0.2f);
}

#ifdef NON_MATCHING
// lots of regalloc and stack issues, but that's it
s16 func_80046B44(Camera* camera, s16 arg1, s16 arg2, s16 arg3) {
    s32 pad[2];
    s16 sp1C;
    s16 phi_v1;
    s16 phi_v0;
    f32 phi_a2;

    phi_v1 = ABS(arg1);

    if(arg3 > 0){
        phi_v0 = arg3 * Math_Coss(arg3);
    } else {
        phi_v0 = arg3;
    }
    sp1C = arg2 - phi_v0;
    if (ABS(sp1C) < phi_v1) {
        phi_a2 = (1.0f / camera->pitchUpdateRateInv) * 3.0f;
    } else {
        phi_a2 = (1.0f / camera->pitchUpdateRateInv) * func_800437F0(0.8f, 1.0f - phi_v0 * (1.0f / R_CAM_MAX_PHI));
    }
    return Camera_LERPCeilS(sp1C, arg1, phi_a2, 0xA);
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_80046B44.s")
#endif

s16 func_80046CB4(Camera* camera, s16 arg1, s16 arg2, f32 arg3, f32 arg4) {
    f32 sp34;
    s16 sp1C;
    f32 temp_ret;
    f32 phi_f14;
    f32 temp_ret2;
    f32 yawUpdRate;
    
    if (camera->xzSpeed > 0.001f) {
        sp1C = arg2 - BINANG_ROT180(arg1);
        phi_f14 = BINANG_ROT180(sp1C) * COLPOLY_NORM_FRAC;
    } else {
        sp1C = arg2 - BINANG_ROT180(arg1);
        phi_f14 = PCT(OREG(48));
    }

    temp_ret = func_800437F0(arg3, phi_f14);
    
    sp34 = F32_LERPIMP(temp_ret, 1.0f, arg4);
    if (sp34 < 0.0f) {
        sp34 = 0.0f;
    }
    temp_ret2 = func_800437F0(0.5f, camera->speedRatio);
    yawUpdRate = 1.0f / camera->yawUpdateRateInv;
    return arg1 + (s16)(sp1C * sp34 * temp_ret2 * yawUpdRate);
}

#ifdef NON_MATCHING
// matching, but cannot be compiled unitl other in function statics are added.
void func_80046E20(Camera *camera, VecSph *eyeAdjustment, f32 minDist, f32 arg3, f32 *arg4, SwingAnimation *anim) {
    static CamColChk atEyeColChk;
    static CamColChk eyeAtColChk;
    static CamColChk newEyeColChk;

    Vec3f *eye = &camera->eye;
    s32 temp_v0;
    Vec3f *at = &camera->at;
    Vec3f peekAroundPoint;
    Vec3f *eyeNext = &camera->eyeNext;
    f32 temp_f0;
    VecSph newEyeAdjustment;
    VecSph sp40;

    temp_v0 = func_80045508(camera, eyeAdjustment, &atEyeColChk, &eyeAtColChk, !anim->unk_18);
    
    switch(temp_v0){
        case 1:
        case 2:
            // angle between polys is between 60 and 120 degrees.
            Camera_BGCheckCorner(&anim->collisionClosePoint, at, eyeNext, &atEyeColChk, &eyeAtColChk);
            peekAroundPoint.x = anim->collisionClosePoint.x + (atEyeColChk.norm.x + eyeAtColChk.norm.x);
            peekAroundPoint.y = anim->collisionClosePoint.y + (atEyeColChk.norm.y + eyeAtColChk.norm.y);
            peekAroundPoint.z = anim->collisionClosePoint.z + (atEyeColChk.norm.z + eyeAtColChk.norm.z);
            
            temp_f0 = OLib_Vec3fDist(at, &atEyeColChk.pos);
            *arg4 = temp_f0 > minDist ? 1.0f : temp_f0 / minDist;
            
            anim->swingUpdateRate = PCT(OREG(10));
            anim->unk_18 = 1;
            anim->atEyePoly = eyeAtColChk.poly;
            OLib_Vec3fDiffToVecSphGeo(&newEyeAdjustment, at, &peekAroundPoint);
            
            newEyeAdjustment.r = eyeAdjustment->r;
            Camera_Vec3fVecSphGeoAdd(eye, at, &newEyeAdjustment);
            newEyeColChk.pos = *eye;
            if (func_80043D18(camera, at, &newEyeColChk) == 0) {
                // no collision found between at->newEyePos
                newEyeAdjustment.yaw += BINANG_SUB(eyeAdjustment->yaw, newEyeAdjustment.yaw) >> 1;
                newEyeAdjustment.pitch += BINANG_SUB(eyeAdjustment->pitch, newEyeAdjustment.pitch) >> 1;
                Camera_Vec3fVecSphGeoAdd(eye, at, &newEyeAdjustment);
                if (atEyeColChk.sphNorm.pitch < 0x2AA8) {
                    // ~ 60 degrees
                    anim->unk_16 = newEyeAdjustment.yaw;
                    anim->unk_14 = newEyeAdjustment.pitch;
                } else {
                    anim->unk_16 = eyeAdjustment->yaw;
                    anim->unk_14 = eyeAdjustment->pitch;
                }
                peekAroundPoint.x = anim->collisionClosePoint.x - (atEyeColChk.norm.x + eyeAtColChk.norm.x);
                peekAroundPoint.y = anim->collisionClosePoint.y - (atEyeColChk.norm.y + eyeAtColChk.norm.y);
                peekAroundPoint.z = anim->collisionClosePoint.z - (atEyeColChk.norm.z + eyeAtColChk.norm.z);
                OLib_Vec3fDiffToVecSphGeo(&newEyeAdjustment, at, &peekAroundPoint);
                newEyeAdjustment.r = eyeAdjustment->r;
                Camera_Vec3fVecSphGeoAdd(eyeNext, at, &newEyeAdjustment);
                break;
            }
            
            camera->eye = newEyeColChk.pos;
            atEyeColChk = newEyeColChk;
            
        case 3:
        case 6:
            if (anim->unk_18 != 0) {
                anim->swingUpdateRateTimer = OREG(52);
                anim->unk_18 = 0;
                *eyeNext = *eye;
            }

            temp_f0 = OLib_Vec3fDist(at, &atEyeColChk.pos);
            *arg4 = temp_f0 > minDist ? 1.0f : temp_f0/minDist;

            anim->swingUpdateRate = *arg4 * arg3;
            
            Camera_Vec3fScaleXYZFactor(eye, &atEyeColChk.pos, &atEyeColChk.norm, 1.0f);
            anim->atEyePoly = NULL;
            if (temp_f0 < OREG(21)) {
                sp40.yaw = eyeAdjustment->yaw;
                sp40.pitch = Math_Sins(atEyeColChk.sphNorm.pitch + 0x3FFF) * 16380.0f;
                sp40.r = (OREG(21) - temp_f0) * PCT(OREG(22));
                Camera_Vec3fVecSphGeoAdd(eye, eye, &sp40);
                return;
            }
            break;
        default:
            if (anim->unk_18 != 0) {
                anim->swingUpdateRateTimer = OREG(52);
                *eyeNext = *eye;
                anim->unk_18 = 0;
            }
            anim->swingUpdateRate = arg3;
            anim->atEyePoly = NULL;
            eye->x = atEyeColChk.pos.x + atEyeColChk.norm.x;
            eye->y = atEyeColChk.pos.y + atEyeColChk.norm.y;
            eye->z = atEyeColChk.pos.z + atEyeColChk.norm.z;
            break;
    }
}
#else
void func_80046E20(Camera *arg0, VecSph *arg1, f32 arg2, f32 arg3, f32 *arg4, SwingAnimation *arg5);
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_80046E20.s")
#endif
#undef NON_MATCHING

s32 Camera_NOP(Camera* camera) {
    return true;
}
s16 func_80046B44(Camera*, s16, s16, s16);

typedef struct {
    f32 yOffset;
    f32 fov;
    VecSph radial;
    s16 interfaceFlags;
} CamRadial;

s32 Camera_CustomRadial(Camera* camera){
    f32 yOffset = Player_GetCameraYOffset(camera->player);
    CamRadial* radial = (CamRadial*)&camera->params;
    VecSph curEyeAt;
    if(RELOAD_PARAMS){
        CameraModeValue* values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        f32 yOffsetNormal = (1.0f - PCT(OREG(46))) - (PCT(OREG(46)) * (68.0f / yOffset));
        radial->yOffset = NEXTPCT * yOffset * yOffsetNormal;
        radial->fov = NEXTSETTING;
        radial->radial.r = 200.0f;
        radial->radial.yaw = BINANG_ROT180(camera->playerPosRot.rot.y);
        radial->radial.pitch = 0x1000;
        radial->interfaceFlags = NEXTSETTING;
    }

    if(R_RELOAD_CAM_PARAMS){
        Camera_CopyPREGToModeValues(camera);
    }

    sUpdateCameraDirection = true;
    sCameraInterfaceFlags = radial->interfaceFlags;

    camera->at = camera->playerPosRot.pos;
    camera->at.y += radial->yOffset;
    OLib_Vec3fDiffToVecSphGeo(&curEyeAt, &camera->at, &camera->eyeNext);

    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
            camera->animState++;
            break;
    }

    if(CHECK_PAD(camera->globalCtx->state.input[0].cur, L_JPAD)){
        radial->radial.yaw -= 0x300;
    } else if (CHECK_PAD(camera->globalCtx->state.input[0].cur, R_JPAD)){
        radial->radial.yaw += 0x300;
    } else if (CHECK_PAD(camera->globalCtx->state.input[0].cur, D_JPAD | L_TRIG)){
        radial->radial.r -= 5.0f;
    } else if (CHECK_PAD(camera->globalCtx->state.input[0].cur, U_JPAD | L_TRIG)){
        radial->radial.r += 5.0f;
    } else if(CHECK_PAD(camera->globalCtx->state.input[0].cur, D_JPAD)){
        radial->radial.pitch -= 0x100;
    } else if(CHECK_PAD(camera->globalCtx->state.input[0].cur, U_JPAD)){
        radial->radial.pitch += 0x100;
    }
    Camera_Vec3fVecSphGeoAdd(&camera->eyeNext, &camera->at, &radial->radial);
    camera->eye = camera->eyeNext;

    {
        VecSph atEyeDir;
        OLib_Vec3fDiffToVecSphGeo(&atEyeDir, &camera->eye, &camera->at);
        camera->direction.x = atEyeDir.pitch;
        camera->direction.y = atEyeDir.yaw;
        camera->direction.z = 0;
    }
    camera->fov = Camera_LERPCeilF(radial->fov, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    return 1;

}

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 Camera_Normal1(Camera *camera) {
    Normal1* norm1 = &camera->params.norm1;
    CameraModeValue* values;
    f32 yOffset;
    f32 spA0;
    f32 sp9C;
    f32 sp98;
    f32 sp94;
    Vec3f sp88;

    VecSph eyeAdjustment;
    f32 temp_f0_5;
    VecSph atEyeGeo;
    VecSph atEyeNextGeo;
    f32 yOffsetInverse;
    f32 phi_f16;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Normal1_Anim* anim = &norm1->anim;
    SwingAnimation* swing = &anim->swing;

    yOffset = Player_GetCameraYOffset(camera->player);
    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM) - PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        yOffsetInverse *= 0.01f * yOffset;
        norm1->yOffset = NEXTSETTING * yOffsetInverse;
        norm1->distMin = NEXTSETTING * yOffsetInverse;
        norm1->distMax = NEXTSETTING * yOffsetInverse;
        norm1->pitchTarget = DEGF_TO_BINANG(NEXTSETTING);
        norm1->unk_0C = NEXTSETTING;
        norm1->unk_10 = NEXTSETTING;
        norm1->unk_14 = NEXTPCT;
        norm1->fovTarget = NEXTSETTING;
        norm1->atLERPScaleMax = NEXTPCT;
        norm1->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = norm1->interfaceFlags;

    OLib_Vec3fDiffToVecSphGeo(&atEyeGeo, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&atEyeNextGeo, at, eyeNext);

    switch(camera->animState){
        case 0x14:
            camera->yawUpdateRateInv = OREG(27);
            camera->pitchUpdateRateInv = OREG(27);
        case 0:
        case 0xA:
        case 0x19:
            swing->unk_18 = 0;
            swing->atEyePoly = NULL;
            anim->unk_24 = 0;
            anim->unk_28 = 0xA;
            swing->unk_14 = swing->unk_18;
            swing->unk_16 = swing->unk_18;
            swing->swingUpdateRate = norm1->unk_0C;
            anim->yOffset = camera->playerPosRot.pos.y;
            anim->unk_20 = camera->xzSpeed;
            swing->swingUpdateRateTimer = 0;
            anim->swingYawTarget = atEyeGeo.yaw;
            sUpdateCameraDirection = 0;
            anim->startSwingTimer = OREG(50) + OREG(51);
            break;
        default:
            break;
    }

    camera->animState = 1;
    sUpdateCameraDirection = 1;

    if (anim->unk_28 != 0) {
        anim->unk_28--;
    }

    if (camera->xzSpeed > 0.001f) {
        anim->startSwingTimer = OREG(50) + OREG(51);
    } else if (anim->startSwingTimer > 0) {
        if (anim->startSwingTimer > OREG(50)) {
            anim->swingYawTarget = atEyeGeo.yaw + (BINANG_SUB(BINANG_ROT180(camera->playerPosRot.rot.y), atEyeGeo.yaw) / anim->startSwingTimer);
        }
        anim->startSwingTimer--;
    }

    spA0 = PCT(OREG(25)) * camera->speedRatio;
    sp9C = camera->speedRatio * PCT(OREG(26));
    sp98 = swing->unk_18 != 0 ? PCT(OREG(25)) : spA0;
    
    sp94 = (camera->xzSpeed - anim->unk_20) * (1.0f / 3.0f);
    if(sp94 > 1.0f){
        sp94 = 1.0f;
    }
    if(sp94 > -1.0f){
        sp94 = -1.0f;
    }

    anim->unk_20 = camera->xzSpeed;
    
    if (swing->swingUpdateRateTimer != 0) {
        camera->yawUpdateRateInv = Camera_LERPCeilF(swing->swingUpdateRate + (f32) (swing->swingUpdateRateTimer * 2), camera->yawUpdateRateInv, sp98, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF((f32) R_CAM_DEFA_PHI_UPDRATE + (f32) (swing->swingUpdateRateTimer * 2), camera->pitchUpdateRateInv, sp9C, 0.1f);
        swing->swingUpdateRateTimer--;
    } else {
        camera->yawUpdateRateInv = Camera_LERPCeilF(swing->swingUpdateRate - ((OREG(49) * 0.01f) * swing->swingUpdateRate * sp94), camera->yawUpdateRateInv, sp98, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF(R_CAM_DEFA_PHI_UPDRATE, camera->pitchUpdateRateInv, sp9C, 0.1f);
    }

    camera->pitchUpdateRateInv = Camera_LERPCeilF(R_CAM_DEFA_PHI_UPDRATE, camera->pitchUpdateRateInv, sp9C, 0.1f);
    camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, spA0, 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, sp9C, 0.1f);
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->yOffsetUpdateRate, camera->speedRatio * 0.05f, 0.1f);


    if (norm1->interfaceFlags & 1) {
        anim->unk_24 = Camera_LERPCeilS(func_80044ADC(camera, BINANG_ROT180(atEyeGeo.yaw), 0), 
                                    anim->unk_24, 
                                    ((1.0f / norm1->unk_10) * 0.5f) + (((1.0f / norm1->unk_10) * 0.5f) * (1.0f - camera->speedRatio)), 
                                    0xF);
    } else {
        anim->unk_24 = 0;
        if (camera->playerGroundY == camera->playerPosRot.pos.y) {
            anim->yOffset = camera->playerPosRot.pos.y;
        }
    }

    phi_f16 = ((swing->unk_18 != 0) && (norm1->yOffset > -40.0f)) ?
                (temp_f0_5 = Math_Sins(swing->unk_14), F32_LERP(norm1->yOffset, -40.0f, temp_f0_5)) :
                norm1->yOffset;

    if (norm1->interfaceFlags & 0x80) {

        func_800458D4(camera, &atEyeNextGeo, phi_f16, &anim->yOffset, norm1->interfaceFlags & 1);
    } else if (norm1->interfaceFlags & 0x20) {
        func_80045B08(camera, &atEyeNextGeo, phi_f16, anim->unk_24);
    } else {
        func_800457A8(camera, &atEyeNextGeo, phi_f16, norm1->interfaceFlags & 1);
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeAdjustment, at, eyeNext);
    
    camera->dist = eyeAdjustment.r = Camera_ClampDist(camera, eyeAdjustment.r, norm1->distMin, norm1->distMax, anim->unk_28);
    
    if (anim->startSwingTimer <= 0) {
        eyeAdjustment.pitch = atEyeNextGeo.pitch;
        eyeAdjustment.yaw = Camera_LERPCeilS(anim->swingYawTarget, atEyeNextGeo.yaw, 1.0f / camera->yawUpdateRateInv, 0xA);
    } else if (swing->unk_18 != 0) {
        // this case seems to be impossible, unk_18 is set and not changed
        eyeAdjustment.yaw = Camera_LERPCeilS(swing->unk_16, atEyeNextGeo.yaw, 1.0f / camera->yawUpdateRateInv, 0xA);
        eyeAdjustment.pitch = Camera_LERPCeilS(swing->unk_14, atEyeNextGeo.pitch, 1.0f / camera->yawUpdateRateInv, 0xA);
    } else {
        // rotate yaw to follow player.
        eyeAdjustment.yaw = func_80046CB4(camera, atEyeNextGeo.yaw, camera->playerPosRot.rot.y, norm1->unk_14, sp94);
        eyeAdjustment.pitch = func_80046B44(camera, atEyeNextGeo.pitch, norm1->pitchTarget, anim->unk_24);
    }

    // set eyeAdjustment pitch from 79.65 degrees to -85 degrees
    if (eyeAdjustment.pitch >= 0x38A5) {
        eyeAdjustment.pitch = 0x38A4;
    }
    if (eyeAdjustment.pitch < -0x3C8C) {
        eyeAdjustment.pitch = -0x3C8C;
    }

    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeAdjustment);
    if ((camera->status == CAM_STATUS_ACTIVE) &&  (!(norm1->interfaceFlags & 0x10))) {
        anim->swingYawTarget = BINANG_ROT180(camera->playerPosRot.rot.y);
        if (anim->startSwingTimer > 0) {
            func_80046E20(camera, &eyeAdjustment, norm1->distMin, norm1->unk_0C, &sp98, swing);
        } else {
            sp88 = *eyeNext;
            spA0 = norm1->unk_0C * 2.0f;
            swing->swingUpdateRate = camera->yawUpdateRateInv = spA0;
            if (func_80043F34(camera, at, &sp88)) {
                anim->swingYawTarget = atEyeNextGeo.yaw;
                anim->startSwingTimer = -1;
            } else {
                *eye = *eyeNext;
            }
            swing->unk_18 = 0;
        }
        if (swing->unk_18 != 0) {
            camera->direction.y = Camera_LERPCeilS(camera->direction.y + BINANG_SUB(BINANG_ROT180(swing->unk_16), camera->direction.y), camera->direction.y, 1.0f - (0.99f * sp98), 0xA);
        }

        if (norm1->interfaceFlags & 4) {
            camera->direction.x = -atEyeGeo.pitch;
            camera->direction.y = BINANG_ROT180(atEyeGeo.yaw);
            camera->direction.z = 0;
        } else {
            OLib_Vec3fDiffToVecSphGeo(&eyeAdjustment, eye, at);
            camera->direction.x = eyeAdjustment.pitch;
            camera->direction.y = eyeAdjustment.yaw;
            camera->direction.z = 0;
        }

        if(1){
            // crit wiggle
            if (gSaveContext.health <= 0x10 && ((camera->globalCtx->state.frames % 256) == 0)) {
                camera->direction.y += (s16)(Math_Rand_ZeroOne() * 10000.0f);
            }
        }
    } else {
        swing->swingUpdateRate = norm1->unk_0C;
        swing->unk_18 = 0;
        sUpdateCameraDirection = 0;
        *eye = *eyeNext;
    }

    camera->fov = Camera_LERPCeilF(norm1->fovTarget * (gSaveContext.health <= 0x10 ? 0.8f : 1.0f), camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, norm1->atLERPScaleMax);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Normal1.s")
#endif
#undef NON_MATCHING

#ifdef NON_MATCHING
s32 Camera_Normal2(Camera *camera) {
    Vec3f *sp48 = &camera->eye;
    CamColChk spAC;
    f32 spA4;
    f32 spA0;
    VecSph sp98;
    Vec3f *sp44 = &camera->at;
    Vec3f *sp40 = &camera->eyeNext;
    VecSph sp90;
    VecSph sp88;
    VecSph sp80;
    VecSph sp78;
    PosRot *sp3C = &camera->playerPosRot;
    Normal2* norm2 = &camera->params.norm2;
    Normal2Anim *temp_s1 = &norm2->anim;
    CameraModeValue *values;
    s32 phi_a1;
    CamPosData *sp64;
    f32 yOffset;
    f32 temp_f14;
    s32 temp_v1;
    s16 phi_a0;
    
    yOffset = Player_GetCameraYOffset(camera->player);
    temp_f14 = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
    
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        norm2->unk_00 = NEXTPCT * yOffset * temp_f14;
        norm2->unk_04 = NEXTPCT * yOffset * temp_f14;
        norm2->unk_08 = NEXTPCT * yOffset * temp_f14;
        norm2->unk_1C = DEGF_TO_BINANG(NEXTSETTING);
        norm2->unk_0C = NEXTSETTING;
        norm2->unk_10 = NEXTPCT;
        norm2->unk_14 = NEXTSETTING;
        norm2->unk_18 = NEXTPCT;
        norm2->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = norm2->interfaceFlags;
    
    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
        case 0x19:
            sp64 = func_8004476C(camera);
            Camera_Vec3sToVec3f(&temp_s1->unk_00, &sp64->pos);
            temp_s1->unk_20 = sp64->rot.x;
            temp_s1->unk_22 = sp64->rot.y;
            temp_s1->unk_24 = sp3C->pos.y;

            temp_s1->unk_1C = sp64->fov == -1 ? norm2->unk_14 :
                sp64->fov >= 0x169 ? PCT(sp64->fov) : sp64->fov;
            
            temp_s1->unk_28 = sp64->jfifId == -1 ? 0 : sp64->jfifId;

            temp_s1->unk_18 = 0.0f;

            if (1 && norm2->interfaceFlags & 4) {
                sp88.pitch = temp_s1->unk_20;
                sp88.yaw = temp_s1->unk_22 + 0x3FFF;
                sp88.r = 100.0f;
                OLib_VecSphGeoToVec3f(&temp_s1->unk_0C, &sp88);
            }
            
            camera->animState = 1;
            camera->yawUpdateRateInv = 50.0f;
            break;
        default:
            if (camera->playerGroundY == sp3C->pos.y) {
                temp_s1->unk_24 = sp3C->pos.y;
            }
            break;
    }
    
    OLib_Vec3fDiffToVecSphGeo(&sp80, sp44, sp48);
    OLib_Vec3fDiffToVecSphGeo(&sp78, sp44, sp40);

    camera->speedRatio *= 0.5f;
    spA4 = PCT(OREG(25)) * camera->speedRatio;
    spA0 = PCT(OREG(26)) * camera->speedRatio;

    camera->yawUpdateRateInv = Camera_LERPCeilF(norm2->unk_0C, camera->yawUpdateRateInv * camera->speedRatio, PCT(OREG(25)), 0.1f);
    camera->pitchUpdateRateInv = Camera_LERPCeilF(OREG(7), camera->pitchUpdateRateInv, spA0, 0.1f);
    camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, spA4, 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, spA0, 0.1f);
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->yOffsetUpdateRate, camera->speedRatio * 0.05f, 0.1f);
    
    if (!(norm2->interfaceFlags & 0x80)) {
        func_800457A8(camera, &sp78, norm2->unk_00, norm2->interfaceFlags & 1);
    } else {
        func_800458D4(camera, &sp78, norm2->unk_00, &temp_s1->unk_24, norm2->interfaceFlags & 1);
    }

    if (norm2->interfaceFlags & 4) {
        temp_s1->unk_00.x = sp3C->pos.x + temp_s1->unk_0C.x;
        temp_s1->unk_00.z = sp3C->pos.z + temp_s1->unk_0C.z;
    }

    temp_s1->unk_00.y = sp3C->pos.y;

    OLib_Vec3fDiffToVecSphGeo(&sp88, &temp_s1->unk_00, sp44);
    OLib_Vec3fDiffToVecSphGeo(&sp90, sp44, sp40);

    phi_a1 = temp_s1->unk_28 & 2 ? temp_s1->unk_22 : norm2->unk_1C;
    if ((phi_a1 < 0x4000 && (temp_v1 = BINANG_SUB(sp90.yaw, sp88.yaw), phi_a1 < ABS(temp_v1))) || 
        (phi_a1 >= 0x4000 && (temp_v1 = BINANG_SUB(sp90.yaw, sp88.yaw), ABS(temp_v1) < phi_a1))){
        
        phi_a0 = (temp_v1 < 0 ? -phi_a1 : phi_a1);
        phi_a0 += sp88.yaw;
        sp98.yaw = Camera_LERPCeilS(phi_a0, sp80.yaw, (1.0f / camera->yawUpdateRateInv) * camera->speedRatio, 0xA);
        if(temp_s1->unk_28 & 1){
            sp98.pitch = func_80046B44(camera, sp78.pitch, temp_s1->unk_20, 0);
        } else {
            sp98.pitch = sp80.pitch;
        }
    } else {
        sp98 = sp90;
    }

    camera->dist = sp98.r = Camera_ClampDist(camera, sp90.r, norm2->unk_04, norm2->unk_08, 0);
    
    if (!(temp_s1->unk_28 & 1)) {
        if (sp98.pitch >= 0xE39) {
            sp98.pitch += (s16)(BINANG_SUB(0x38E, sp98.pitch) >> 2);
        }

        if (sp98.pitch < 0) {
            sp98.pitch += (s16)(BINANG_SUB(-0x38E, sp98.pitch) >> 2);
        }
    }

    Camera_Vec3fVecSphGeoAdd(sp40, sp44, &sp98);

    if (camera->status == CAM_STATUS_ACTIVE) {
        spAC.pos = *sp40;
        if ((camera->globalCtx->envCtx.skyDisabled == 0) || norm2->interfaceFlags & 0x10) {
            func_80043D18(camera, sp44, &spAC);
            *sp48 = spAC.pos;
        } else {
            func_80043F94(camera, sp44, &spAC);
            *sp48 = spAC.pos;
            OLib_Vec3fDiffToVecSphGeo(&sp98, sp48, sp44);
            camera->direction.x = sp98.pitch;
            camera->direction.y = sp98.yaw;
            camera->direction.z = 0;
        }
    }
    camera->fov = Camera_LERPCeilF(temp_s1->unk_1C, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, norm2->unk_18);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Normal2.s")
#endif
#undef NON_MATCHING

#define lerpt(v0,v1,t) v0+(t*(v1-v0))

#ifdef NON_MATCHING
// riding epona
s32 Camera_Normal3(Camera *camera) {
    f32 sp98;
    f32 sp94;
    f32 sp90;
    f32 sp8C;
    VecSph sp84;
    VecSph sp7C;
    VecSph sp74;
    Vec3f *sp48 = &camera->eye;
    Vec3f *sp44 = &camera->at;
    Vec3f *sp40 = &camera->eyeNext;
    PosRot *sp3C = &camera->playerPosRot;
    Vec3f *temp_a1;
    Vec3f *temp_a2;
    Vec3f *temp_a2_2;
    f32 temp_f0;
    f32 temp_f0_2;
    f32 temp_f0_3;
    f32 temp_f16;
    f32 temp_f16_2;
    f32 temp_f2;
    f32 temp_f2_2;
    f32 temp_f2_3;
    f32 temp_f6;
    s16 temp_a0;
    s16 temp_t3;
    s16 temp_v0;
    s16 temp_v0_3;
    s16 temp_v0_4;
    s16 temp_v0_5;
    s16 temp_v0_6;
    s16 temp_v0_7;
    s16 temp_v1;
    s16 temp_v1_2;
    s32 temp_a0_2;
    s16 phi_v1;
    s32 phi_v1_2;
    s16 phi_a0;
    CameraModeValue* values;
    Normal3* norm3 = &camera->params.norm3;
    Normal3Anim* anim = &norm3->anim;

    temp_f2 = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        norm3->unk_00 = NEXTSETTING * PCT(temp_f2);
        norm3->unk_04 = NEXTSETTING * PCT(temp_f2);
        norm3->unk_08 = NEXTSETTING * PCT(temp_f2);
        norm3->unk_1C = DEGF_TO_BINANG(NEXTSETTING);
        norm3->unk_0C = NEXTSETTING;
        norm3->unk_10 = NEXTSETTING;
        norm3->unk_14 = NEXTSETTING;
        norm3->unk_18 = NEXTPCT;
        norm3->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    OLib_Vec3fDiffToVecSphGeo(&sp7C, sp44, sp48);
    OLib_Vec3fDiffToVecSphGeo(&sp74, sp44, sp40);
    sUpdateCameraDirection = 1;
    sCameraInterfaceFlags = norm3->interfaceFlags;
    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
        case 0x19:
            anim->unk_0C = 0;
            anim->unk_24 = 0;
            anim->unk_1C = 0.0f;
            anim->unk_20 = camera->playerGroundY;
            anim->unk_16 = anim->unk_14 = anim->unk_18 = 0;
            anim->unk_10 = norm3->unk_0C;
            anim->unk_26 = BINANG_SUB(BINANG_ROT180(sp3C->rot.y), sp7C.yaw) * (1.0f / OREG(23));
            anim->unk_2A = 0xA;
            anim->unk_28 = OREG(23);
            camera->animState = 1;
            anim->unk_1A = 0;
    }

    if (anim->unk_2A != 0) {
        anim->unk_2A--;
    }
    
    
    temp_f16_2 = PCT(OREG(25)) * camera->speedRatio;
    sp98 = temp_f16_2;
    sp94 = PCT(OREG(26)) * camera->speedRatio;
    
    if (anim->unk_1A != 0) {
        camera->yawUpdateRateInv = Camera_LERPCeilF(norm3->unk_0C + (anim->unk_1A * 2), camera->yawUpdateRateInv, sp98, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF((f32)OREG(7) + (anim->unk_1A * 2), camera->pitchUpdateRateInv, sp94, 0.1f);
        anim->unk_1A--;
    } else {
        camera->yawUpdateRateInv = Camera_LERPCeilF(norm3->unk_0C, camera->yawUpdateRateInv, sp98, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF(OREG(7), camera->pitchUpdateRateInv, sp94, 0.1f);
    }
    
    camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, sp98, 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, sp94, 0.1f);
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->fovUpdateRate, sp94, 0.1f);
    
    anim->unk_24 = Camera_LERPCeilS(func_80044ADC(camera, BINANG_ROT180(sp7C.yaw), 1), anim->unk_24, ((1.0f / norm3->unk_10) * 0.5f) + (((1.0f / norm3->unk_10) * 0.5f) * (1.0f - camera->speedRatio)), 0xF);
    
    func_800466F8(camera, &sp74, norm3->unk_00, &anim->unk_20, 1);
    
    sp90 = (norm3->unk_08 + norm3->unk_04) * 0.5f;
    OLib_Vec3fDiffToVecSphGeo(&sp84, sp44, sp40);
    camera->dist = sp84.r = Camera_ClampDist(camera, sp84.r, norm3->unk_04, norm3->unk_08, anim->unk_2A);
    if (camera->xzSpeed > 0.001f) {
        sp84.r = F32_LERPIMP(sp84.r, sp90, 0.002f);
    }
    sp84.pitch = Camera_LERPCeilS(BINANG_SUB(norm3->unk_1C, anim->unk_24), sp74.pitch, 1.0f / camera->pitchUpdateRateInv, 0xA);
    
    if (OREG(5) < sp84.pitch) {
        sp84.pitch = OREG(5);
    }
    if (sp84.pitch < OREG(34)) {
        sp84.pitch = OREG(34);
    }

    phi_a0 = BINANG_SUB(sp3C->rot.y, BINANG_ROT180(sp74.yaw));
    if (ABS(phi_a0) >= 0x2AF9) {
        if (phi_a0 > 0) {
            phi_a0 = 0x2AF8;
        } else {
            phi_a0 = -0x2AF8;
        }
    }
    {
        const f32 t = 0.5f;
        const f32 t2 = 1.0f;
        temp_f6 = camera->speedRatio * (t2 - t);
        temp_f0 = t + temp_f6;
        if(1){}
        temp_f16_2 = (temp_f0 * phi_a0) / camera->yawUpdateRateInv;
    
    sp84.yaw = ((150.0f * (1.0f - camera->speedRatio)) < fabsf(temp_f16_2)) ?
        sp84.yaw = sp74.yaw + temp_f16_2 : sp74.yaw;
    }

    if (anim->unk_28 > 0) {
        sp84.yaw += anim->unk_26;
        anim->unk_28--;
    }

    Camera_Vec3fVecSphGeoAdd(sp40, sp44, &sp84);

    if (camera->status == CAM_STATUS_ACTIVE) {
        func_80046E20(camera, &sp84, norm3->unk_04, norm3->unk_0C, &sp8C, anim);
    } else {
        *sp48 = *sp40;
    }

    camera->fov = Camera_LERPCeilF(norm3->unk_14, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, norm3->unk_18);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Normal3.s")
#endif

s32 Camera_Normal4(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Normal0(Camera* camera) {
    return Camera_NOP(camera);
}

#undef NON_MATCHING
#ifdef NON_MATCHING
/**
 * Z-Targeting
*/
s32 Camera_Parallel1(Camera *camera) {
    Vec3f spB4;
    VecSph spA8;
    VecSph spA0;
    VecSph sp98;
    CamColChk sp6C;
    s16 sp6A;
    Vec3f *sp3C;
    Parallel1* para1 = &camera->params.para1;
    Parallel1Anim *sp34 = &para1->anim;
    f32 yOffset;
    f32 temp_f0_2;
    f32 yOffsetInverse;
    f32 temp_f2;
    f32 temp_f2_2;
    s16 temp_a0;
    s16 temp_a0_2;
    s16 temp_t6;
    s16 temp_v0_2;
    s16 phi_v0;
    s16 phi_v0_2;
    s16 phi_a0;
    f32 phi_f0;
    Vec3f* eye = &camera->eye;
    Vec3f* at = &camera->at;
    Vec3f* eyeNext = &camera->eyeNext;
    CameraModeValue* values;

    yOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        para1->unk_00 = NEXTPCT * yOffset * yOffsetInverse;
        para1->distTarget = NEXTPCT * yOffset * yOffsetInverse;
        para1->pitchTarget = DEGF_TO_BINANG(NEXTSETTING);
        para1->yawTarget = DEGF_TO_BINANG(NEXTSETTING);
        para1->unk_08 = NEXTSETTING;
        para1->unk_0C = NEXTSETTING;
        para1->fovTarget = NEXTSETTING;
        para1->unk_14 = NEXTPCT;
        para1->interfaceFlags = NEXTSETTING;
        para1->unk_18 = NEXTPCT * yOffset * yOffsetInverse;
        para1->unk_1C = NEXTPCT;
    }
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&spA0, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&sp98, at, eyeNext);

    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
        case 0x19:
            sp34->unk_16 = 0;
            sp34->unk_10 = 0;
            if (para1->interfaceFlags & 4) {
                sp34->animTimer = 20;
            } else {
                sp34->animTimer = OREG(23);
            }
            sp34->unk_00.x = 0;
            sp34->yTarget = camera->playerPosRot.pos.y - camera->playerPosDelta.y;
            camera->animState++;
    }

    if (sp34->animTimer != 0) {
        if (para1->interfaceFlags & 2) {
            sp34->yawTarget = BINANG_ROT180(camera->playerPosRot.rot.y) + para1->yawTarget;
        } else if (para1->interfaceFlags & 4) {
            sp34->yawTarget = para1->yawTarget;
        } else {
            sp34->yawTarget = sp98.yaw;
        }
    } else {
        if (para1->interfaceFlags & 0x20) {
            sp34->yawTarget = BINANG_ROT180(camera->playerPosRot.rot.y) + para1->yawTarget;
        }
        sCameraInterfaceFlags = para1->interfaceFlags;
    }
    
    sp34->pitchTarget = para1->pitchTarget;
    if(camera->animState == 0x15){
        sp34->unk_16 = 1;
        camera->animState = 1;
    } else if(camera->animState == 0xB){
        camera->animState = 1;
    }
    
    {
        f32 o26 = OREG(26);
        spB4.y = PCT(OREG(25));
        spB4.y *= camera->speedRatio;
        spB4.x = PCT(o26) * camera->speedRatio;

        camera->rUpdateRateInv = Camera_LERPCeilF(OREG(6), camera->rUpdateRateInv, spB4.y, 0.1f);
        camera->yawUpdateRateInv = Camera_LERPCeilF(para1->unk_08, camera->yawUpdateRateInv, spB4.y, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF(2.0f, camera->pitchUpdateRateInv, spB4.x, 0.1f);
        camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, spB4.y, 0.1f);
        camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, spB4.x, 0.1f);
        camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->fovUpdateRate, camera->speedRatio * 0.05f, 0.1f);
    }

    sp34->unk_10 = para1->interfaceFlags & 1 ? 
        Camera_LERPCeilS(func_80044ADC(camera, BINANG_ROT180(spA0.yaw), 1), sp34->unk_10, ((1.0f / para1->unk_0C) * 0.3f) + (((1.0f / para1->unk_0C) * 0.7f) * (1.0f - camera->speedRatio)), 0xF) :
        0;
    
    if (camera->playerPosRot.pos.y == camera->playerGroundY || camera->player->actor.gravity > -0.1f || camera->player->stateFlags1 & 0x200000) {
        sp34->yTarget = camera->playerPosRot.pos.y;
        sp6A = 0;
    } else {
        sp6A = 1;
    }

    if (((para1->interfaceFlags & 0x80) == 0) && (sp6A == 0)) {
        func_80045C74(camera, &sp98, para1->unk_00, &sp34->yTarget, para1->interfaceFlags & 1);
    } else {
        func_800458D4(camera, &sp98, para1->unk_18, &sp34->yTarget, para1->interfaceFlags & 1);
    }

    if (sp34->animTimer != 0) {
        
        camera->unk_14C |= 0x20;
        if(1){
            s32 t = (BINANG_SUB(sp34->yawTarget, spA0.yaw) / (s16)(((sp34->animTimer + 1) * sp34->animTimer) >> 1)) * sp34->animTimer;
            spA8.pitch = spA0.pitch;
            spA8.r = spA0.r;
            spA8.yaw = spA0.yaw + t;
        }
        sp34->animTimer--;
    } else {
        s16 pitchTarg;
        sp34->unk_16 = 0;
        camera->dist = Camera_LERPCeilF(para1->distTarget, camera->dist, 1.0f / camera->rUpdateRateInv, 2.0f);
        OLib_Vec3fDiffToVecSphGeo(&spA8, at, eyeNext);
        spA8.r = camera->dist;
        spA8.yaw = para1->interfaceFlags & 0x40 ?
            Camera_LERPCeilS(sp34->yawTarget, sp98.yaw, 0.6f, 0xA) :
            Camera_LERPCeilS(sp34->yawTarget, sp98.yaw, 0.8f, 0xA);

        if(para1->interfaceFlags & 1){
            pitchTarg = BINANG_SUB(sp34->pitchTarget, sp34->unk_10);
        } else {
             pitchTarg = sp34->pitchTarget;
        }

        spA8.pitch = Camera_LERPCeilS(pitchTarg, sp98.pitch, 1.0f / camera->pitchUpdateRateInv, 4);

        if(spA8.pitch > OREG(5)){
            spA8.pitch = OREG(5);
        }
        if(spA8.pitch < OREG(34)){
            spA8.pitch = OREG(34);
        }

    }
    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &spA8);
    if (camera->status == CAM_STATUS_ACTIVE) {
        sp6C.unk_00 = *eyeNext;
        if ((camera->globalCtx->envCtx.skyDisabled == 0) || para1->interfaceFlags & 0x10) {
            func_80043D18(camera, at, &sp6C);
            *eye = sp6C.unk_00;
        } else {
            func_80043F94(camera, at, &sp6C);
            *eye = sp6C.unk_00;
            OLib_Vec3fDiffToVecSphGeo(&spA8, eye, at);
            camera->direction.x = spA8.pitch;
            camera->direction.y = spA8.yaw;
            camera->direction.z = 0;
        }
    }
    camera->fov = Camera_LERPCeilF(para1->fovTarget, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, sp6A ? para1->unk_1C : para1->unk_14);
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Parallel1.s")
#endif

s32 Camera_Parallel2(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Parallel3(Camera* camera) {
    CameraModeValue* reg = &sCameraSettings[camera->setting].cameraModes[camera->mode].values[0];
    s16 val = reg->val;

    sCameraInterfaceFlags = val;

    if (val & 1) {
        camera->unk_14C |= 0x400;
    }
    if (val & 2) {
        camera->unk_14C |= 0x10;
    }
    // @bug doesn't return
}

s32 Camera_Parallel4(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Parallel0(Camera* camera) {
    return Camera_NOP(camera);
}

/**
 * Generic jump, jumping off ledges
*/
s32 Camera_Jump1(Camera *camera) {
    s32 pad;
    s32 pad2;
    f32 yOffsetInverse;
    Jump1 *jump1 = &camera->params.jump1;
    f32 spA4;
    Vec3f newEye;
    VecSph eyeAtOffset;
    VecSph eyeNextAtOffset;
    VecSph eyeDiffSph;
    VecSph eyeDiffTarget;
    f32 pad3;
    PosRot playerPosRot2;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    f32 playerYOffset;
    CameraModeValue* values;
    s32 pad4;
    Jump1Anim *anim = &jump1->anim;

    playerYOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / playerYOffset));
        jump1->atYOffset = PCT(NEXTSETTING) * playerYOffset * yOffsetInverse;
        jump1->distMin = PCT(NEXTSETTING) * playerYOffset * yOffsetInverse;
        jump1->distMax = PCT(NEXTSETTING) * playerYOffset * yOffsetInverse;
        jump1->yawUpateRateTarget = NEXTSETTING;
        jump1->maxYawUpdate = PCT(NEXTSETTING);
        jump1->unk_14 = NEXTSETTING;
        jump1->atLERPScaleMax = PCT(NEXTSETTING);
        jump1->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    // playerPosRot2 never gets used.
    func_8002EEE4(&playerPosRot2, &camera->player->actor);

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);
    
    sCameraInterfaceFlags = jump1->interfaceFlags;

    if (camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14) {
        anim->swing.unk_16 = anim->swing.unk_18 = 0;
        anim->swing.atEyePoly = NULL;
        anim->unk_20.pitch = 0;
        anim->unk_20.yaw = 0xC8;
        anim->swing.swingUpdateRateTimer = 0;
        anim->swing.swingUpdateRate = jump1->yawUpateRateTarget;
        anim->unk_1C = camera->playerPosRot.pos.y - camera->playerPosDelta.y;
        anim->unk_20.r = eyeAtOffset.r;
        camera->posOffset.y -= camera->playerPosDelta.y;
        camera->xzOffsetUpdateRate = (1.0f / 10000.0f);
        camera->animState++;
    }

    if (anim->swing.swingUpdateRateTimer != 0) {
        camera->yawUpdateRateInv = Camera_LERPCeilF(jump1->yawUpateRateTarget + anim->swing.swingUpdateRateTimer, camera->yawUpdateRateInv, PCT(OREG(26)), 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF((f32)R_CAM_DEFA_PHI_UPDRATE + anim->swing.swingUpdateRateTimer, camera->pitchUpdateRateInv, PCT(OREG(26)), 0.1f);
        anim->swing.swingUpdateRateTimer--;
    } else {
        camera->yawUpdateRateInv = Camera_LERPCeilF(jump1->yawUpateRateTarget, camera->yawUpdateRateInv, PCT(OREG(26)), 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF((f32)R_CAM_DEFA_PHI_UPDRATE, camera->pitchUpdateRateInv, PCT(OREG(26)), 0.1f);
    }

    camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, PCT(OREG(25)), 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, PCT(OREG(26)), 0.1f);
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->yOffsetUpdateRate, 0.05f, 0.1f);
    
    func_800458D4(camera, &eyeNextAtOffset, jump1->atYOffset, &anim->unk_1C, 0);

    eyeDiffSph = eyeAtOffset;
    
    OLib_Vec3fDiffToVecSphGeo(&eyeDiffTarget, at, eye);

    eyeDiffSph.r = Camera_LERPCeilF(eyeDiffTarget.r, eyeAtOffset.r, PCT(OREG(29)), 1.0f);
    eyeDiffSph.pitch = Camera_LERPCeilS(eyeDiffTarget.pitch, eyeAtOffset.pitch, PCT(OREG(29)), 0xA);

    if (anim->swing.unk_18) {
        eyeDiffSph.yaw = Camera_LERPCeilS(anim->swing.unk_16, eyeNextAtOffset.yaw, 1.0f / camera->yawUpdateRateInv, 0xA);
        eyeDiffSph.pitch = Camera_LERPCeilS(anim->swing.unk_14, eyeNextAtOffset.pitch, 1.0f / camera->yawUpdateRateInv, 0xA);
    } else {
        eyeDiffSph.yaw = func_80046CB4(camera, eyeNextAtOffset.yaw, camera->playerPosRot.rot.y, jump1->maxYawUpdate, 0.0f);
    }
    
    // Clamp the eye->at distance to jump1->distMin < eyeDiffSph.r < jump1->distMax
    if(eyeDiffSph.r < jump1->distMin){
        eyeDiffSph.r = jump1->distMin;
    } else if(eyeDiffSph.r > jump1->distMax){
        eyeDiffSph.r = jump1->distMax;
    }

    // Clamp the phi rotation at R_CAM_MAX_PHI AND R_CAM_MIN_PHI2
    if(eyeDiffSph.pitch > R_CAM_MAX_PHI){
        eyeDiffSph.pitch = R_CAM_MAX_PHI;
    } else if(eyeDiffSph.pitch < R_CAM_MIN_PHI2){
        eyeDiffSph.pitch = R_CAM_MIN_PHI2;
    }

    Camera_Vec3fVecSphGeoAdd(&newEye, at, &eyeDiffSph);
    eyeNext->x = newEye.x;
    eyeNext->z = newEye.z;
    eyeNext->y += (newEye.y - eyeNext->y) * PCT(OREG(31));
    if ((camera->status == CAM_STATUS_ACTIVE) && !(jump1->interfaceFlags & 0x10)) {
        func_80046E20(camera, &eyeDiffSph, jump1->distMin, jump1->yawUpateRateTarget, &spA4, &anim->swing);
        if (jump1->interfaceFlags & 4) {
            camera->direction.x = -eyeAtOffset.pitch;
            camera->direction.y = BINANG_ROT180(eyeAtOffset.yaw);
            camera->direction.z = 0;
        } else {
            OLib_Vec3fDiffToVecSphGeo(&eyeDiffSph, eye, at);
            camera->direction.x = eyeDiffSph.pitch;
            camera->direction.y = eyeDiffSph.yaw;
            camera->direction.z = 0;
        }
        if (anim->swing.unk_18) {
            camera->direction.y = Camera_LERPCeilS(camera->direction.y + BINANG_SUB(BINANG_ROT180(anim->swing.unk_16), camera->direction.y), camera->direction.y, 1.0f - (0.99f * spA4), 0xA);
        }
    } else {
        anim->swing.swingUpdateRate = jump1->yawUpateRateTarget;
        anim->swing.unk_18 = 0;
        sUpdateCameraDirection = 0;
        *eye = *eyeNext;
    }

    camera->dist = OLib_Vec3fDist(at, eye);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, jump1->atLERPScaleMax);
    return true;
}

#ifdef NON_MATCHING
// Climbing ladders/vines
s32 Camera_Jump2(Camera *camera) {
    Vec3f spC8;
    Vec3f spBC;
    VecSph spB4;
    VecSph spAC;
    VecSph spA4;
    VecSph sp9C;
    f32 sp90;
    f32 sp8C;
    s32 sp88;
    CamColChk sp60;
    f32 sp48;
    Vec3f *sp38 = &camera->eye;
    Vec3f *sp34 = &camera->at;
    Vec3f *sp30 = &camera->eyeNext;
    PosRot *sp2C = &camera->playerPosRot;
    f32 temp_f0_4;
    f32 temp_f12;
    s16 t;
    Jump2* jump2 = &camera->params.jump2;
    Jump2_Unk24* unk24 = &jump2->unk_24;
    CameraModeValue* values;
    f32 temp_f2_3;
    f32 temp_f16;

    sp48 = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        /*        temp_t5 = *(&sCameraSettings + (arg0->unk142 * 8)) + (arg0->unk144 * 8);
        temp_f2 = (f32) gGameInfo->unk1F0 * 0.009999999776482582f;
        temp_f12 = (1.0f + temp_f2) - (temp_f2 * (68.0f / temp_f0));
        if (0.0f < arg0->unkF4) {
            phi_f2 = -10.0f;
        } else {
            phi_f2 = 10.0f;
        }
        temp_t8 = *temp_t5->unk4;
        temp_v0 = temp_t5->unk4 + 0x20;
        arg0->unk0 = (f32) (((((f32) temp_t8 + phi_f2) * 0.009999999776482582f) * temp_f0) * temp_f12);
        arg0->unk4 = (f32) ((((f32) temp_v0->unk-1C * 0.009999999776482582f) * temp_f0) * temp_f12);
        arg0->unk8 = (f32) ((((f32) temp_v0->unk-18 * 0.009999999776482582f) * temp_f0) * temp_f12);
        arg0->unkC = (f32) ((f32) temp_v0->unk-14 * 0.009999999776482582f);
        arg0->unk10 = (f32) temp_v0->unk-10;
        arg0->unk14 = (f32) ((f32) temp_v0->unk-C * 0.009999999776482582f);
        arg0->unk18 = (f32) temp_v0->unk-8;
        arg0->unk1C = (f32) ((f32) temp_v0->unk-4 * 0.009999999776482582f);
        arg0->unk20 = (s16) temp_v0->unk0;
        phi_v1 = gGameInfo->unk314;
    } else {
        */
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        temp_f12 = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / sp48));
        temp_f0_4 = camera->playerPosDelta.y > 0.0f ? -10.0f : 10.0f;
        jump2->unk_00 = PCT(NEXTSETTING + temp_f0_4) * sp48 * temp_f12;
        jump2->unk_04 = NEXTPCT * sp48 * temp_f12;
        jump2->unk_08 = NEXTPCT * sp48 * temp_f12;
        jump2->unk_0C = NEXTPCT;    
        jump2->unk_10 = NEXTSETTING;
        jump2->unk_14 = NEXTPCT;
        jump2->unk_18 = NEXTSETTING;
        jump2->unk_1C = NEXTPCT;
        jump2->unk_20 = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&sp9C, sp34, sp38);
    OLib_Vec3fDiffToVecSphGeo(&spA4, sp34, sp30);

    sCameraInterfaceFlags = jump2->unk_20;
    if (camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14) {
        spC8 = sp2C->pos;
        unk24->unk_00 = func_80044510(camera, &spC8);
        unk24->unk_04 = spA4.yaw;
        unk24->unk_06 = 0;
        if (unk24->unk_00 == BGCHECK_Y_MIN) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: climb: no floor \n" VT_RST);
            unk24->unk_0A = -1;
            unk24->unk_00 = sp2C->pos.y - 1000.0f;
        } else{
            unk24->unk_0A = (sp2C->pos.y - unk24->unk_00) < sp48 ? 1 : -1;
        }


        t = BINANG_SUB(BINANG_ROT180(sp2C->rot.y), spA4.yaw);
        unk24->unk_06 = t / OREG(23) / 4 * 3;
        
        unk24->unk_08 = jump2->unk_20 & 2 ? 0xA : 0x2710;

        sp2C->pos.x -= camera->playerPosDelta.x;
        sp2C->pos.y -= camera->playerPosDelta.y;
        sp2C->pos.z -= camera->playerPosDelta.z;

        unk24->unk_0C = OREG(23);
        camera->animState++;
        camera->atLERPStepScale = jump2->unk_1C;
    }

    // I'm guessing this is some kind of macro? 
    {
        sp90 = PCT(OREG(25)) * camera->speedRatio;
        sp8C = PCT(OREG(26)) * camera->speedRatio;
        camera->yawUpdateRateInv = Camera_LERPCeilF(jump2->unk_10, camera->yawUpdateRateInv, sp90, 0.1f);
        camera->xzOffsetUpdateRate = Camera_LERPCeilF(jump2->unk_14, camera->xzOffsetUpdateRate, sp90, 0.1f);

        camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, sp8C, 0.1f);
        // 0.1f is loaded before 0.05f * camera->speedRatio 
        camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->yOffsetUpdateRate, 0.05f * camera->speedRatio, 0.1f);
        camera->rUpdateRateInv = OREG(27);
        
    }

    func_800457A8(camera, &spA4, jump2->unk_00, 0);
    OLib_Vec3fDiffToVecSphGeo(&spB4, sp34, sp38);
    
    //spB4.r = CLAMP(spB4.r, jump2->unk_08 - (jump2->unk_08 * jump2->unk_0C), jump2->unk_04 + (jump2->unk_04 * jump2->unk_0C));


    temp_f2_3 = jump2->unk_08 + (jump2->unk_08 * jump2->unk_0C);
    temp_f16 = jump2->unk_04 - (jump2->unk_04 * jump2->unk_0C);
    
    if (temp_f2_3 < spB4.r) {
        spB4.r = jump2->unk_08 + (jump2->unk_08 * jump2->unk_0C);
    } else {
        if (spB4.r < temp_f16) {
            spB4.r = jump2->unk_04 - (jump2->unk_04 * jump2->unk_0C);
        }
    }

    {
        s16 tangle = BINANG_ROT180(sp2C->rot.y);
        s16 tangle2 = BINANG_SUB(tangle, spB4.yaw);
        if (unk24->unk_0C != 0) {
            unk24->unk_04 = tangle;
            unk24->unk_0C--;
            spB4.yaw = Camera_LERPCeilS(unk24->unk_04, spA4.yaw, 0.5f, 0xA);
        } else if (unk24->unk_08 < ABS(tangle2)) {
            tangle2 = tangle2 < 0 ? tangle + unk24->unk_08 : tangle - unk24->unk_08;
            spB4.yaw = Camera_LERPFloorS(tangle2, spA4.yaw, 0.1f, 0xA);
        } else {
            spB4.yaw = Camera_LERPCeilS(spB4.yaw, spA4.yaw, 0.25f, 0xA);
        }
    }
    
    spC8.x = sp2C->pos.x + (Math_Sins(sp2C->rot.y) * 25.0f);
    spC8.y = sp2C->pos.y + (sp48 * 2.2f);
    spC8.z = sp2C->pos.z + (Math_Coss(sp2C->rot.y) * 25.0f);
    
    temp_f0_4 = func_80044434(camera, &spBC, &spC8, &sp88);
    if ((temp_f0_4 != BGCHECK_Y_MIN) && (sp2C->pos.y < temp_f0_4)) {
        camera->pitchUpdateRateInv = Camera_LERPCeilF(20.0f, camera->pitchUpdateRateInv, PCT(OREG(26)), 0.1f);
        camera->rUpdateRateInv = Camera_LERPCeilF(20.0f, camera->rUpdateRateInv, PCT(OREG(26)), 0.1f);
        spB4.pitch = Camera_LERPCeilS(0x1F4, spA4.pitch, 1.0f / camera->pitchUpdateRateInv, 0xA);
    } else if ((sp2C->pos.y - unk24->unk_00) < sp48) {
        camera->pitchUpdateRateInv = Camera_LERPCeilF(20.0f, camera->pitchUpdateRateInv, PCT(OREG(26)), 0.1f);
        camera->rUpdateRateInv = Camera_LERPCeilF(20.0f, camera->rUpdateRateInv, PCT(OREG(26)), 0.1f);
        spB4.pitch = Camera_LERPCeilS(0x1F4, spA4.pitch, 1.0f / camera->pitchUpdateRateInv, 0xA);
    } else {
        camera->pitchUpdateRateInv = 100.0f;
        camera->rUpdateRateInv = 100.0f;
    }

    
    if (spB4.pitch >= 0x2AF9) {
        spB4.pitch = 0x2AF8;
    }

    if (spB4.pitch < -0x2AF8) {
        spB4.pitch = -0x2AF8;
    }

    Camera_Vec3fVecSphGeoAdd(sp30, sp34, &spB4);
    sp60.unk_00 = *sp30;

    if (func_80043D18(camera, sp34, &sp60)) {
        spC8 = sp60.unk_00;
        
        spAC.r = spB4.r;
        spAC.pitch = 0;
        spAC.yaw = spB4.yaw;
        Camera_Vec3fVecSphGeoAdd(&sp60.unk_00, sp34, &spAC);
        if (func_80043D18(camera, sp34, &sp60)) {
            *sp38 = spC8;
        } else {
            spB4.pitch = Camera_LERPCeilS(0, spB4.pitch, 0.2f, 0xA);
            Camera_Vec3fVecSphGeoAdd(sp38, sp34, &spB4);
            func_80043F34(camera, sp34, sp38);
        }
    } else {
        *sp38 = *sp30;
    }
    camera->dist = spB4.r;
    camera->fov = Camera_LERPCeilF(jump2->unk_18, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Jump2.s")
#endif

// swimming
s32 Camera_Jump3(Camera *camera) {  
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    s32 spC8;
    f32 spC4;
    f32 spC0;
    f32 spBC;
    Vec3f spB0; // unused
    VecSph eyeDiffSph;
    PosRot* playerPosRot = &camera->playerPosRot;
    Jump3* jump3 = &camera->params.jump3;
    VecSph eyeAtOffset;
    VecSph eyeNextAtOffset;
    s32 pad;
    s32 pad2;
    CameraModeValue* values;
    f32 t2;
    f32 phi_f0;
    f32 phi_f2;
    f32 sp74;
    PosRot playerPosRot2;
    f32 temp_f0_2;
    f32 temp_f18;
    s32 sp54;
    f32 temp_f2_2;
    Jump3Anim *anim = &jump3->anim;    

    sp74 = Player_GetCameraYOffset(camera->player);
    func_8002EEE4(&playerPosRot2, &camera->player->actor);

    sp54 = 0;
    if (((camera->waterYPos - eye->y) < OREG(44) || (camera->animState == 0))){
        if(anim->unk_22 != 0){
            anim->unk_22 = 0;
            sp54 = 1;
        }
    } else if (((camera->waterYPos - eye->y) > OREG(45)) && (anim->unk_22 != 0xA)) {
        anim->unk_22 = 0xA;
        sp54 = 1;
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);
    
    if (camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14 || sp54 || R_RELOAD_CAM_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[anim->unk_22].values;
        temp_f0_2 = ((1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / sp74)));
        t2 = PCT(sp74) * temp_f0_2;
        jump3->yOffsetTarget = NEXTSETTING * t2;
        jump3->distTargetMin = NEXTSETTING * t2;
        jump3->distTargetMax = NEXTSETTING * t2;
        jump3->unk_20 = DEGF_TO_BINANG(NEXTSETTING);
        jump3->swingUpdateRate = NEXTSETTING;
        jump3->unk_10 = NEXTSETTING;
        jump3->unk_14 = NEXTPCT;
        jump3->fovTarget = NEXTSETTING;
        jump3->unk_1C = NEXTPCT;
        jump3->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        spC8 = camera->mode;
        camera->mode = anim->unk_22;
        Camera_CopyPREGToModeValues(camera);
        camera->mode = spC8;
    }

    sCameraInterfaceFlags = jump3->interfaceFlags;
    
    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
        case 0x19:
            anim->swing.atEyePoly = NULL;
            anim->unk_1C = camera->playerGroundY;
            anim->swing.unk_16 = anim->swing.unk_14 = anim->swing.unk_18 = 0;
            anim->animTimer = 0xA;
            anim->swing.swingUpdateRate = jump3->swingUpdateRate;
            camera->animState++;
            anim->swing.swingUpdateRateTimer = 0;
            break;
        default:
            if (anim->animTimer != 0) {
                anim->animTimer--;
            }
            break;
    }

    // unused
    spB0 = *eye;
    
    spC4 = PCT(OREG(25)) * camera->speedRatio;
    spC0 = camera->speedRatio * PCT(OREG(26));
    spBC = anim->swing.unk_18 != 0 ? PCT(OREG(25)) : spC4;

    if (anim->swing.swingUpdateRateTimer != 0) {
        camera->yawUpdateRateInv = Camera_LERPCeilF(anim->swing.swingUpdateRate + (anim->swing.swingUpdateRateTimer * 2), camera->yawUpdateRateInv, spC4, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF((anim->swing.swingUpdateRateTimer * 2) + 40.0f, camera->pitchUpdateRateInv, spC0, 0.1f);
        anim->swing.swingUpdateRateTimer--;
    } else {
        camera->yawUpdateRateInv = Camera_LERPCeilF(anim->swing.swingUpdateRate, camera->yawUpdateRateInv, spBC, 0.1f);
        camera->pitchUpdateRateInv = Camera_LERPCeilF(40.0f, camera->pitchUpdateRateInv, spC0, 0.1f);
    }

    camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(2)), camera->xzOffsetUpdateRate, spC4, 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, spC0, 0.1f);
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->yOffsetUpdateRate, camera->speedRatio * 0.05f, 0.1f);
    
    func_800457A8(camera, &eyeNextAtOffset, jump3->yOffsetTarget, jump3->interfaceFlags);
    OLib_Vec3fDiffToVecSphGeo(&eyeDiffSph, at, eyeNext);
    
    camera->dist = eyeDiffSph.r = Camera_ClampDist(camera, eyeDiffSph.r, jump3->distTargetMin, jump3->distTargetMax, anim->animTimer);
    
    if (camera->playerGroundY <= playerPosRot->pos.y) {
        phi_f0 = playerPosRot->pos.y - camera->playerGroundY;
    } else {
        phi_f0 = -(playerPosRot->pos.y - camera->playerGroundY);
    }

    if (!(phi_f0 < 10.0f)) {
        if (camera->waterYPos <= playerPosRot2.pos.y) {
            phi_f2 = playerPosRot2.pos.y - camera->waterYPos;
        } else {
            phi_f2 = -(playerPosRot2.pos.y - camera->waterYPos);
        }
        if (!(phi_f2 < 50.0f)) {
            camera->pitchUpdateRateInv = 100.0f;
        }
    }
    if (anim->swing.unk_18 != 0) {
        eyeDiffSph.yaw = Camera_LERPCeilS(anim->swing.unk_16, eyeNextAtOffset.yaw, 1.0f / camera->yawUpdateRateInv, 0xA);
        eyeDiffSph.pitch = Camera_LERPCeilS(anim->swing.unk_14, eyeNextAtOffset.pitch, 1.0f / camera->yawUpdateRateInv, 0xA);
    } else {
        eyeDiffSph.yaw = func_80046CB4(camera, eyeNextAtOffset.yaw, playerPosRot->rot.y, jump3->unk_14, 0.0f);
        eyeDiffSph.pitch = func_80046B44(camera, eyeNextAtOffset.pitch, jump3->unk_20, 0);
    }

    if (eyeDiffSph.pitch > OREG(5)) {
        eyeDiffSph.pitch = OREG(5);
    }

    if (eyeDiffSph.pitch < OREG(34)) {
        eyeDiffSph.pitch = OREG(34);
    }

    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeDiffSph);
    if ((camera->status == CAM_STATUS_ACTIVE) && !(jump3->interfaceFlags & 0x10)) {
        func_80046E20(camera, &eyeDiffSph, jump3->distTargetMin, jump3->swingUpdateRate, &spBC, &anim->swing);
        if (jump3->interfaceFlags & 4) {
            camera->direction.x = -eyeAtOffset.pitch;
            camera->direction.y = BINANG_ROT180(eyeAtOffset.yaw);
            camera->direction.z = 0;
        } else {
            OLib_Vec3fDiffToVecSphGeo(&eyeDiffSph, eye, at);
            camera->direction.x = eyeDiffSph.pitch;
            camera->direction.y = eyeDiffSph.yaw;
            camera->direction.z = 0;
        }

        if (anim->swing.unk_18 != 0) {
            camera->direction.y = Camera_LERPCeilS(camera->direction.y + BINANG_SUB(BINANG_ROT180(anim->swing.unk_16), camera->direction.y), camera->direction.y, 1.0f - (0.99f * spBC), 0xA);
        }
    } else {
        anim->swing.swingUpdateRate = jump3->swingUpdateRate;
        anim->swing.unk_18 = 0;
        sUpdateCameraDirection = 0;
        *eye = *eyeNext;
    }
    camera->fov = Camera_LERPCeilF(jump3->fovTarget, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, jump3->unk_1C);
    return true;
}

s32 Camera_Jump4(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Jump0(Camera* camera) {
    return Camera_NOP(camera);
}

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 Camera_Battle1(Camera *camera) {
    Vec3f sp128;
    Vec3f sp11C;
    Vec3f sp110;
    f32 spFC;
    f32 spF8;
    f32 spF4;
    s32 spE8;
    f32 spE4;
    CamColChk spBC;
    VecSph spB4;
    VecSph spAC;
    VecSph spA4;
    VecSph sp9C;
    VecSph sp94;
    s16 sp8E;
    s16 sp8C;
    struct Player *sp88;
    s16 sp86;
    s16 sp84;
    f32 sp80;
    f32 sp7C;
    f32 sp78;
    f32 sp74;
    f32 sp64;
    Vec3f *sp4C = &camera->eye;
    Vec3f *sp48 = &camera->at;
    Vec3f *sp44 = &camera->eyeNext;
    PosRot *sp40 = &camera->playerPosRot;
    PosRot *sp38 = &camera->targetPosRot;
    f32 temp_f0_2;
    f32 temp_f0_3;
    f32 temp_f12;
    f32 temp_f12_2;
    f32 temp_f14;
    f32 temp_f16;
    f32 temp_f18;
    f32 temp_f2;
    f32 temp_f2_2;
    s16 temp_t6;
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_f4;
    s32 temp_t0;
    s32 temp_v0_2;
    s32 temp_v0_3;
    s32 temp_v1_3;
    s32 temp_v1_4;
    s16 phi_v1;
    f32 phi_f2;
    f32 phi_f2_3;
    s32 phi_v0_2;
    s32 phi_t0;
    s32 phi_t0_2;
    s16 phi_a0;
    f32 phi_f2_4;
    f32 phi_f0;
    Battle1* batt1 = &camera->params.batt1;
    Battle1Anim* anim = &batt1->anim;
    CameraModeValue* values;

    spE8 = 0;
    sp88 = camera->player;
    sp64 = Player_GetCameraYOffset((Player *) camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        temp_f12 = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / sp64));
        camera->params.batt1.unk_00 = (NEXTPCT * sp64) * temp_f12;
        camera->params.batt1.unk_04 = NEXTSETTING;
        camera->params.batt1.unk_08 = NEXTSETTING;
        camera->params.batt1.unk_0C = NEXTSETTING;
        camera->params.batt1.unk_10 = NEXTSETTING;
        camera->params.batt1.unk_14 = NEXTSETTING;
        camera->params.batt1.unk_18 = NEXTPCT;
        camera->params.batt1.unk_1C = NEXTSETTING;
        camera->params.batt1.unk_20 = NEXTPCT;
        camera->params.batt1.interfaceFlags = NEXTSETTING;
        camera->params.batt1.unk_24 = (NEXTPCT * sp64) * temp_f12;
        camera->params.batt1.unk_28 = NEXTPCT;
        anim->unk_10 = NEXTPCT;
        anim->unk_1C = 0x28;
    }

    if (R_RELOAD_CAM_PARAMS != 0) {
        Camera_CopyPREGToModeValues(camera);
    }

    sp80 = camera->params.batt1.unk_04;
    sp7C = camera->params.batt1.unk_10;
    sp78 = camera->params.batt1.unk_14;
    sp74 = camera->params.batt1.unk_1C;

    if ((camera->player->stateFlags1 & 0x1000) != 0) {
        anim->unk_10 = Camera_LERPCeilF(PCT(OREG(12)) * 0.5f, anim->unk_10, PCT(OREG(25)), 0.1f);
        camera->xzOffsetUpdateRate = Camera_LERPCeilF(0.2f, camera->xzOffsetUpdateRate, PCT(OREG(25)), 0.1f);
        camera->yOffsetUpdateRate = Camera_LERPCeilF(0.2f, camera->yOffsetUpdateRate, PCT(OREG(25)), 0.1f);
        if (anim->unk_1C >= -0x13) {
            anim->unk_1C--;
        } else {
            sp80 = 250.0f;
            sp7C = 50.0f;
            sp78 = 40.0f;
            sp74 = 60.0f;
        }
    } else if ((s32) anim->unk_1C < 0) {
        sp80 = 250.0f;
        sp7C = 50.0f;
        sp78 = 40.0f;
        sp74 = 60.0f;
        anim->unk_1C++;
    } else {
        anim->unk_1C = 0x28;
        anim->unk_10 = Camera_LERPCeilF(PCT(OREG(12)), anim->unk_10, PCT(OREG(25)), 0.1f);
        camera->xzOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(40)), camera->xzOffsetUpdateRate, PCT(OREG(25)) * camera->speedRatio, 0.1f);
        camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(40)), camera->yOffsetUpdateRate, PCT(OREG(26)) * camera->speedRatio, 0.1f);
    }
    camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->fovUpdateRate, camera->speedRatio * 0.05f, 0.1f);
    
    
    sp64 += batt1->unk_00;
    OLib_Vec3fDiffToVecSphGeo(&sp9C, sp48, sp4C);
    OLib_Vec3fDiffToVecSphGeo(&sp94, sp48, sp44);
    if (camera->target == NULL || camera->target->update == NULL) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: battle: target is not valid, change parallel" VT_RST);
        }
        camera->target = NULL;
        Camera_ChangeModeDefaultFlags(camera, CAM_MODE_PARALLEL);
        return 1;
    }
    sCameraInterfaceFlags = batt1->interfaceFlags;
    switch(camera->animState){
        case 0: 
        case 0xA:
        case 0x14:
            anim->unk_14 = 0;
            anim->unk_04 = 0.0f;
            anim->target = camera->target;
            camera->animState++;
            if (anim->target->id > 0) {
                osSyncPrintf("camera: battle: target actor name " VT_FGCOL(BLUE) "%d" VT_RST "\n", anim->target->id);
            } else  {
                osSyncPrintf("camera: battle: target actor name " VT_COL(RED, WHITE) "%d" VT_RST"\n", anim->target->id);
                camera->target = NULL;
                Camera_ChangeModeDefaultFlags(camera, CAM_MODE_PARALLEL);
                return 1;
            }
            anim->swingUpdateRateTimer = OREG(23) + OREG(24);
            anim->unk_16 = sp9C.yaw;
            anim->unk_18 = sp9C.pitch;
            anim->unk_00 = sp9C.r;
            anim->unk_08 = camera->playerPosRot.pos.y - camera->playerPosDelta.y;
            break;
    }

    if (camera->status == CAM_STATUS_ACTIVE) {
        sUpdateCameraDirection = 1;
        camera->direction.x = -sp9C.pitch;
        camera->direction.y = BINANG_ROT180(sp9C.yaw);
        camera->direction.z = 0;
    }
    if (camera->playerPosRot.pos.y == camera->playerGroundY || camera->player->actor.gravity > -0.1f || camera->player->stateFlags1 & 0x200000) {
        anim->unk_08 = camera->playerPosRot.pos.y;
        sp84 = 0;
    } else {
        sp84 = 1;
    }

    if (anim->swingUpdateRateTimer == 0) {
        camera->atLERPStepScale = Camera_ClampLERPScale(camera, sp84 != 0 ? batt1->unk_28 : batt1->unk_20);
    }
    
    func_8002EEE4(sp38, camera->target);
    if (camera->target != anim->target) {
        osSyncPrintf("camera: battle: change target %d -> " VT_FGCOL(BLUE) "%d" VT_RST "\n", anim->target->id, camera->target->id);
        camera->animState = 0;
        return 1;
    }
    
    func_800460A8(camera, &sp94, &sp38->pos, sp84 !=0 ? batt1->unk_24 : batt1->unk_00, sp80, &anim->unk_08, &spA4, (sp84 != 0 ? 0x81 : 0x1) | camera->params.batt1.interfaceFlags);
    sp11C = sp40->pos;
    sp8C = spA4.yaw;
    sp11C.y += sp64;
    OLib_Vec3fDiffToVecSphGeo(&spA4, &sp11C, &sp38->pos);
    if (sp80 < spA4.r) {
        spE4 = 1.0f;
    } else {
        spE4 = spA4.r / sp80;
    }
    sp110 = sp38->pos;
    sp8C = spA4.yaw;
    OLib_Vec3fDiffToVecSphGeo(&spAC, sp48, &sp110);
    phi_f2_3 = sp80;
    if (spAC.r <= sp80) {
        phi_f2_3 = spAC.r;
    }
    spAC.r = sp80 - (phi_f2_3 * 0.5f);
    //temp_f18 = camera->params.batt1.unk_08 + ((camera->params.batt1.unk_0C - camera->params.batt1.unk_08) * (1.1f - spE4));
    spF4 = F32_LERPIMP(batt1->unk_08, batt1->unk_0C, (1.1f - spE4));
    spF8 = OREG(13) + spF4;
    sp8C = spA4.yaw;
    spB4.r = camera->dist = Camera_LERPCeilF(sp80, camera->dist, PCT(OREG(11)), 2.0f);
    spB4.yaw = sp94.yaw;
    temp_v0_2 = BINANG_SUB(spAC.yaw, BINANG_ROT180(sp94.yaw));
    temp_a1 = (s32) (temp_v0_2 << 0x10) >> 0x10;
    if (anim->unk_1A != 0) {
        if (anim->unk_1A >= OREG(24)) {
            sp86 = anim->unk_1A - OREG(24);
            sp8C = spA4.yaw;
            OLib_Vec3fDiffToVecSphGeo(&spA4, sp48, sp4C);
            spA4.yaw = BINANG_ROT180(spA4.yaw);
            temp_f0_3 = 1.0f / OREG(23);
            
            sp8E = BINANG_SUB(anim->unk_16, spA4.yaw) * temp_f0_3;
            sp8C = BINANG_SUB(anim->unk_18, spA4.pitch) * temp_f0_3;

            // might need to use sp8e, sp8C here, and not use LERPIMP
            spB4.r = Camera_LERPCeilF(F32_LERPIMP(spA4.r, anim->unk_00, sp86 * temp_f0_3), sp9C.r, PCT(OREG(28)), 1.0f);
            spB4.yaw = Camera_LERPCeilS(BINANG_LERPIMP(spA4.yaw, anim->unk_16, sp86 * temp_f0_3), sp9C.yaw, PCT(OREG(28)), 0xA);
            spB4.pitch = Camera_LERPCeilS(BINANG_LERPIMP(spA4.pitch, anim->unk_18, sp86 * temp_f0_3), sp9C.pitch, PCT(OREG(28)), 0xA);
        } else {
            spE8 = 1;
        }
        anim->unk_1A--;
    } else {
        temp_a0 = (s32) (temp_v0_2 << 0x10) >> 0x10;
        if (temp_a0 >= 0) {
            phi_v0_2 = temp_a0;
        } else {
            phi_v0_2 = -temp_a0;
        }
        temp_v1_3 = DEGF_TO_BINANG(spF4);
        if (temp_v1_3 < ABS(temp_v0_2)) {
            sp8E = temp_v0_2;
            spF4 = spF4;
            spFC = BINANG_TO_DEGF(temp_v0_2);
            temp_f2_2 = F32_LERP(spF4, spF8, OLib_ClampMaxDist(spAC.r, spB4.r) / spB4.r);
            temp_f12_2 = (SQ(temp_f2_2) - 2.0f) / (temp_f2_2 - 360.0f);
            temp_f14 = SQ(spFC) / ((temp_f12_2 * spFC) + (2.0f - (360.0f * temp_f12_2)));
            if (sp8E >= 0) {
                phi_t0 = DEGF_TO_BINANG(temp_f14);
            } else {
                phi_t0 = -DEGF_TO_BINANG(temp_f14);
            }
            spB4.yaw = BINANG_ROT180(BINANG_ROT180(sp94.yaw) + (sp8E >= 0 ? DEGF_TO_BINANG(temp_f14) : -DEGF_TO_BINANG(temp_f14)));
        } else {
            spB4.yaw = BINANG_SUB(sp94.yaw, (BINANG_SUB(ABS(temp_v1_3), temp_v0_2)) * ((1.0f - camera->speedRatio) * 0.05f));
        }
    }

    if (spE8 == 0) {
        temp_v0_3 = DEGF_TO_BINANG(BINANG_LERPIMP(sp7C, sp78, spE4)) - (s32) ((f32) spA4.pitch * (0.5f + (spE4 * 0.5f))) + (s32) ((f32) spAC.pitch * camera->params.batt1.unk_18);
        temp_v1_4 = (s32) (temp_v0_3 << 0x10) >> 0x10;
        if (temp_v1_4 < -0x2AA8) {
            phi_a0 = (u16)-0x2AA8;
        } else {
            phi_a0 = (s16) ((s32) (temp_v0_3 << 0x10) >> 0x10);
            if (temp_v1_4 >= 0x2AA9) {
                phi_a0 = (u16)0x2AA8;
            }
        }
        spB4.pitch = Camera_LERPCeilS(phi_a0, sp94.pitch, anim->unk_10, 0xA);
        Camera_Vec3fVecSphGeoAdd(sp44, sp48, &spB4);
        spBC.unk_00 = *sp44;
        if (camera->status == CAM_STATUS_ACTIVE) {
            if ((camera->globalCtx->envCtx.skyDisabled == 0) || ((camera->params.batt1.interfaceFlags & 1) != 0)) {
                func_80043D18(camera, sp48, &spBC);
            } else if (batt1->interfaceFlags & 2) {
                func_80043F94(camera, sp48, &spBC);
            } else {
                OLib_Vec3fDistNormalize(&sp128, sp48, &spBC.unk_00);
                spBC.unk_00.x -= sp128.x;
                spBC.unk_00.y -= sp128.y;
                spBC.unk_00.z -= sp128.z;
            }
            *sp4C = spBC.unk_00;
        } else {
            *sp4C = *sp44;
        }
    }
    anim->unk_04 = (f32) (anim->unk_04 + ((((OREG(36) * camera->speedRatio) * (1.0f - spE4)) - anim->unk_04) * PCT(OREG(37))));
    camera->roll = DEGF_TO_BINANG(anim->unk_04);
    camera->fov = Camera_LERPCeilF((sp88->swordState != 0 || gSaveContext.health <= 0x10 ? 0.8f : 1.0f) * (sp74 - ((sp74 * 0.05f) * spE4)), camera->fov, camera->fovUpdateRate, 1.0f);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Battle1.s")
#endif
#undef NON_MATCHING

s32 Camera_Battle2(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Battle3(Camera* camera) {
    Camera_NOP(camera);
}

/**
 * Charging spin attack
 * Camera zooms out slowly for 50 frames, then tilts up to a specified
 * setting value.
*/
s32 Camera_Battle4(Camera *camera) {
    Battle4* batt4 = &camera->params.batt4;
    f32 yOffsetInverse;
    f32 yOffset;
    VecSph eyeNextOffset;
    VecSph eyeAtOffset;
    VecSph eyeNextAtOffset;
    CameraModeValue* values;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Battle4Anim* anim = &batt4->anim;
    s32 pad;

    yOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        batt4->yOffset = (NEXTPCT * yOffset) * yOffsetInverse;
        batt4->rTarget = (NEXTPCT * yOffset) * yOffsetInverse;
        batt4->pitchTarget = DEGF_TO_BINANG(NEXTSETTING);
        batt4->lerpUpdateRate = NEXTPCT;
        batt4->fovTarget = NEXTSETTING;
        batt4->atLERPTarget = NEXTPCT;
        batt4->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS){
        Camera_CopyPREGToModeValues(camera);
    }
    
    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);

    sCameraInterfaceFlags = batt4->interfaceFlags;
    
    switch(camera->animState){
        case 0:
        case 0xA:
        case 0x14:
            anim->animTimer = 50;
            camera->animState++;
    }

    camera->yawUpdateRateInv = Camera_LERPCeilF(batt4->lerpUpdateRate, camera->yawUpdateRateInv, PCT(OREG(25)) * camera->speedRatio, 0.1f);
    camera->rUpdateRateInv = 1000.0f;
    camera->pitchUpdateRateInv = 1000.0f;
    camera->xzOffsetUpdateRate = Camera_LERPCeilF(0.025f, camera->xzOffsetUpdateRate, PCT(OREG(25)), 0.1f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(PCT(OREG(3)), camera->yOffsetUpdateRate, PCT(OREG(26)) * camera->speedRatio, 0.1f);
    camera->fovUpdateRate = 0.0001f;
    func_800457A8(camera, &eyeNextAtOffset, batt4->yOffset, 1);
    if (anim->animTimer != 0) {
        eyeNextOffset.yaw = eyeAtOffset.yaw;
        eyeNextOffset.pitch = eyeAtOffset.pitch;
        eyeNextOffset.r = eyeAtOffset.r;
        anim->animTimer--;
    } else {
        eyeNextOffset.yaw = eyeAtOffset.yaw;
        eyeNextOffset.pitch = Camera_LERPCeilS(batt4->pitchTarget, eyeAtOffset.pitch, batt4->lerpUpdateRate, 2);
        eyeNextOffset.r = Camera_LERPCeilF(batt4->rTarget, eyeAtOffset.r, batt4->lerpUpdateRate, 0.001f);
    }
    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeNextOffset);
    *eye = *eyeNext;
    camera->dist = eyeNextOffset.r;
    camera->fov = Camera_LERPCeilF(batt4->fovTarget, camera->fov, batt4->lerpUpdateRate, 1.0f);
    camera->roll = 0;
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, batt4->atLERPTarget);
    return true;
}

s32 Camera_Battle0(Camera* camera) {
    return Camera_NOP(camera);
}

//#define NON_MATCHING
#ifdef NON_MATCHING
// Targeting non-enemy
s32 Camera_KeepOn1(Camera *camera) {
    Vec3f sp120;
    Vec3f sp114;
    Vec3f sp108;
    f32 sp104;
    f32 spF4;
    f32 spF0;
    f32 spEC;
    f32 spE8;
    s16 spE2;
    s16 spE0;
    VecSph spD8;
    VecSph spD0;
    VecSph spC8;
    VecSph spC0;
    VecSph spB8;
    CamColChk sp8C;
    s32 sp88;
    f32 sp84;
    s16 sp82;
    s16 sp80;
    f32 sp70;
    PosRot sp54;
    Vec3f *sp48 = &camera->eye;
    Vec3f *sp44 = &camera->at;
    Vec3f *sp40 = &camera->eyeNext;
    PosRot *sp3C = &camera->playerPosRot;
    PosRot *sp30 = &camera->targetPosRot;
    f32 temp_f0_5;
    f32 temp_f12;
    f32 temp_f12_2;
    f32 temp_f14;
    f32 temp_f18;
    f32 temp_f2;
    f32 temp_f2_2;
    s32 temp_a0;
    s32 temp_a1;
    s32 temp_v1;
    f32 phi_f2;
    s32 phi_v0;
    f32 phi_f12;
    f32 phi_f2_2;
    s32 phi_v0_2;
    s32 phi_t0;
    s16 phi_a0;
    KeepOn1* keep1 = &camera->params.keep1;
    Keep1_Unk34* unk34 = &keep1->unk_34;
    CameraModeValue* values;

    sp88 = 0;
    sp70 = Player_GetCameraYOffset(camera->player);
    if ((camera->target == NULL) || (camera->target->update == NULL)) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: keepon: target is not valid, change parallel\n" VT_RST);
        }
        camera->target = NULL;
        Camera_ChangeModeDefaultFlags(camera, CAM_MODE_PARALLEL);
        return true;
    }

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        temp_f12 = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / sp70));
        keep1->unk_00 = (NEXTPCT * sp70) * temp_f12;
        keep1->unk_04 = NEXTSETTING;
        keep1->unk_08 = NEXTSETTING;
        keep1->unk_0C = NEXTSETTING;
        keep1->unk_10 = NEXTSETTING;
        keep1->unk_14 = NEXTSETTING;
        keep1->unk_18 = NEXTSETTING;
        keep1->unk_1C = NEXTPCT;
        keep1->unk_20 = NEXTSETTING;
        keep1->unk_24 = NEXTPCT;
        keep1->unk_30 = NEXTSETTING;
        keep1->unk_28 = (NEXTPCT * sp70) * temp_f12;
        keep1->unk_2C = NEXTPCT;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    
    sp70 += keep1->unk_00;
    OLib_Vec3fDiffToVecSphGeo(&spC0, sp44, sp48);
    OLib_Vec3fDiffToVecSphGeo(&spB8, sp44, sp40);
    sCameraInterfaceFlags = keep1->unk_30;
    if(camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14){
        camera->animState++;
        unk34->unk_10 = 0;
        unk34->unk_04 = 0.0f;
        unk34->unk_0C = camera->target;
        unk34->unk_16 = OREG(24) + OREG(23);
        unk34->unk_12 = spC0.yaw;
        unk34->unk_14 = spC0.pitch;
        unk34->unk_00 = spC0.r;
        unk34->unk_08 = (f32) (sp3C->pos.y - camera->playerPosDelta.y);
    }

    
    if (camera->status == 7) {
        sUpdateCameraDirection = 1;
        camera->direction.x = -spC0.pitch;
        camera->direction.y = BINANG_ROT180(spC0.yaw);
        camera->direction.z = 0;
    }

    sp104 = keep1->unk_04;
    sp84 = 1.0f;
    switch(camera->paramFlags & 0x18){
        case 0x8:
            if ((camera->player->actor.type == ACTORTYPE_PLAYER) && (camera->player->interactRangeActor == camera->target)) {
                func_8002EEE4(&sp54, &camera->player->actor);
                spC8.r = 60.0f;
                spC8.pitch = 0x2EE0;
                spC8.yaw = camera->playerPosRot.rot.y;
                Camera_Vec3fVecSphGeoAdd(&sp30->pos, &sp54.pos, &spC8);
            } else {
                func_8002EEE4(sp30, camera->target);
            }

            func_8002EEE4(sp30, camera->target);
            if (camera->target != unk34->unk_0C) {
                unk34->unk_0C = camera->target;
                camera->atLERPStepScale = 0.0f;
            }

            camera->xzOffsetUpdateRate = Camera_LERPCeilF(1.0f, camera->xzOffsetUpdateRate, PCT(OREG(25)) * camera->speedRatio, 0.1f);
            camera->yOffsetUpdateRate = Camera_LERPCeilF(1.0f, camera->yOffsetUpdateRate, PCT(OREG(26)) * camera->speedRatio, 0.1f);
            camera->fovUpdateRate = Camera_LERPCeilF(PCT(OREG(4)), camera->fovUpdateRate, camera->speedRatio * 0.05f, 0.1f);
        case 0x10:
            // this should not exist for case 8
            //unk34->unk_0C = NULL;

            if (((sp3C->pos.y == camera->playerGroundY) || (-0.1f < camera->player->actor.gravity)) || camera->player->stateFlags1 & 0x200000) {
                unk34->unk_08 = sp3C->pos.y;
                sp80 = 0;
            } else {
                sp80 = 1;
            }
            
            phi_f2 = sp80 ? keep1->unk_28 : keep1->unk_00;
            phi_v0 = sp80 ? 0x80 : 0;
            //s32 func_800460A8(Camera *camera, VecSph *arg1, Vec3f *arg2, f32 arg3, f32 arg4, f32 *arg5, VecSph *arg6, s16 arg7);
            func_800460A8(camera, &spB8, &sp30->pos, phi_f2, sp104, &unk34->unk_08, &spC8, phi_v0 | keep1->unk_30);
            sp114 = sp3C->pos;
            sp114.y += sp70;
            OLib_Vec3fDiffToVecSphGeo(&spC8, &sp114, &sp30->pos);
            sp84 = sp104 < spC8.r ? 1.0f : spC8.r / sp104;
            break;
        default:
            *sp44 = sp3C->pos;
            sp44->y += sp70;
            unk34->unk_0C = NULL;
            break;
    }

    OLib_Vec3fDiffToVecSphGeo(&spD8, sp44, sp40);
    if (spD8.r < keep1->unk_04) {
        sp104 = keep1->unk_04;
        spE8 = OREG(6);
    } else {
        if (keep1->unk_08 < spD8.r) {
            sp104 = keep1->unk_08;
            phi_f12 = OREG(6);
        } else {
            sp104 = spD8.r;
            phi_f12 = 1.0f;
        }
        spE8 = phi_f12;
    }
    camera->rUpdateRateInv = Camera_LERPCeilF(spE8, camera->rUpdateRateInv, PCT(OREG(25)), 0.1f);
    spE8 = spD8.r = camera->dist = Camera_LERPCeilF(sp104, camera->dist, 1.0f / camera->rUpdateRateInv, 0.2f);
    sp108 = sp30->pos;
    OLib_Vec3fDiffToVecSphGeo(&spD0, sp44, &sp108);
    phi_f2_2 = spD0.r <= spE8 ? spD0.r : spE8;
    spD0.r = spE8 - (phi_f2_2 * 0.5f);
    temp_f18 = keep1->unk_0C + ((keep1->unk_10 - keep1->unk_0C) * (1.1f - sp84));
    spF0 = OREG(13) + temp_f18;
    spEC = temp_f18;
    spD8.r = camera->dist = Camera_LERPCeilF(spE8, camera->dist, PCT(OREG(11)), 2.0f);
    spD8.yaw = spB8.yaw;
    temp_a1 = BINANG_SUB(spD0.yaw, BINANG_ROT180(spB8.yaw));
    if (unk34->unk_16 != 0) {
        if (unk34->unk_16 >= OREG(24)) {
            sp82 = unk34->unk_16 - OREG(24);
            spE2 = spC8.yaw;
            OLib_Vec3fDiffToVecSphGeo(&spC8, sp44, sp48);
            spC8.yaw = BINANG_ROT180(spE2);
            temp_f0_5 = 1.0f / OREG(23);
            spE2 = BINANG_SUB(unk34->unk_12, spC8.yaw) * temp_f0_5;
            spE0 = BINANG_SUB(unk34->unk_14, spC8.pitch) * temp_f0_5;
            spD8.r = Camera_LERPCeilF((sp82 * (unk34->unk_00 - spC8.r) * temp_f0_5) + spC8.r, spC0.r, PCT(OREG(28)), 1.0f);
            spD8.yaw = Camera_LERPCeilS(spC8.yaw + (spE2 * sp82), spC0.yaw, PCT(OREG(28)), (u16)0xA);
            spD8.pitch = Camera_LERPCeilS(spC8.pitch + (spE0 * sp82), spC0.pitch, PCT(OREG(28)), (u16)0xA);

        } else {
            sp88 = 1;
        }
        unk34->unk_16--;
    } else {
        phi_v0_2 = ABS(temp_a1);
        temp_v1 = DEGF_TO_BINANG(temp_f18);
        if (DEGF_TO_BINANG(temp_f18) < ABS(temp_a1)) {
            spE2 = temp_a1;
            spEC = temp_f18;
            spF4 = temp_a1 * (360.00015f / 65535.0f);
            temp_f2_2 = ((OLib_ClampMaxDist(spD0.r, spD8.r) / spD8.r) * (spF0 - temp_f18)) + temp_f18;
            temp_f12_2 = (SQ(temp_f2_2) - 2.0f) / (temp_f2_2 - 360.0f);
            temp_f14 = SQ(spF4) / ((temp_f12_2 * spF4) + (2.0f - (360.0f * temp_f12_2)));
            if (spE2 >= 0) {
                phi_t0 = DEGF_TO_BINANG(temp_f14);
            } else {
                phi_t0 = -DEGF_TO_BINANG(temp_f14);
            }
            spD8.yaw = BINANG_ROT180(BINANG_ROT180(spB8.yaw) + (phi_t0 >> 0x10));
        } else {
            spD8.yaw = spB8.yaw - (s16)((f32) (ABS(temp_a0) - temp_a0) * ((1.0f - camera->speedRatio) * 0.02f));
        }
    }

    if (sp88 == 0) {
        phi_a0 = BINANG_SUB(DEGF_TO_BINANG(keep1->unk_14 + ((keep1->unk_18 - keep1->unk_14) * sp84)), spC8.pitch * (0.5f + (sp84 * 0.5f))) + (s16)(spD0.pitch * keep1->unk_1C);
        phi_a0 = CLAMP(phi_a0, -0x3200, 0x3200);
        spD8.pitch = Camera_LERPCeilS(phi_a0, spB8.pitch, PCT(OREG(12)), 0xA);
        Camera_Vec3fVecSphGeoAdd(sp40, sp44, &spD8);
        sp8C.unk_00 = *sp40;
        if (camera->status == CAM_STATUS_ACTIVE) {
            if ((camera->globalCtx->envCtx.skyDisabled == 0) || ((keep1->unk_30 & 1) != 0)) {
                func_80043D18(camera, sp44, &sp8C);
            } else {
                if ((keep1->unk_30 & 2) != 0) {
                    func_80043F94(camera, sp44, &sp8C);
                } else {
                    OLib_Vec3fDistNormalize(&sp120, sp44, &sp8C.unk_00);
                    sp8C.unk_00.x -= sp120.x;
                    sp8C.unk_00.y -= sp120.y;
                    sp8C.unk_00.z -= sp120.z;
                }
            }
            *sp48 = sp8C.unk_00;
        } else {
            *sp48 = *sp40;
        }
        OLib_Vec3fDistNormalize(&sp120, sp48, sp44);
        Camera_Vec3fScaleXYZFactor(sp48, sp48, &sp120, OREG(1));
    }

    camera->fov = Camera_LERPCeilF(keep1->unk_20, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, sp80 ? keep1->unk_2C : keep1->unk_24);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_KeepOn1.s")
#endif
#undef NON_MATCHING

s32 Camera_KeepOn2(Camera* camera) {
    return Camera_NOP(camera);
}

s32 func_800626B0(GlobalContext* globalCtx, CollisionCheckContext* colChkCtx, Vec3f* camera_3C, Vec3f* arg3, Actor** arg4, s32 arg5);

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 Camera_KeepOn3(Camera *camera) {
    KeepOn3* keep3 = &camera->params.keep3;
    f32 spD4;
    Vec3f spD0;
    Vec3f spC4;
    f32 spBC;
    f32 spB8;
    Actor* spAC[2];
    VecSph spA4;
    VecSph sp9C;
    VecSph sp94;
    VecSph sp8C;
    s32 sp84;
    s16 sp82;
    s16 sp80;
    PosRot sp6C;
    f32 sp58;
    Vec3f *sp48 = &camera->eye;
    PosRot *sp3C = &camera->playerPosRot;
    KeepOn3_Unk2C *unk2C = &keep3->unk_2C;
    PosRot *temp_s1 = &camera->targetPosRot;
    Vec3f *temp_s0 = &camera->at;
    Vec3f *temp_s1_2 = &unk2C->unk_10;
    Vec3f *temp_s2 = &camera->eyeNext;
    f32 *temp_a2;
    f32 *temp_a2_2;
    f32 *temp_a2_3;
    f32 temp_f0;
    f32 temp_f0_2;
    f32 temp_f14;
    f32 temp_f14_2;
    f32 temp_f2;
    s16 temp_t7;
    s32 temp_s0_2;
    s32 temp_v0_2;
    void *temp_t4;
    void *temp_v0;
    s16 phi_v0;
    f32 phi_f12;
    s32 phi_a0;
    s16 phi_t3;
    s32 phi_s0;
    s32 phi_s0_2;
    CameraModeValue* values;
    f32 t;
    s16* i;
    const f32 zero6 = 0.6f;

    sp58 = Player_GetCameraYOffset(camera->player);
    if (camera->target == NULL || camera->target->update == NULL) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: talk: target is not valid, change parallel\n" VT_RST);
        }
        camera->target = NULL;
        Camera_ChangeModeDefaultFlags(camera, CAM_MODE_PARALLEL);
        return 1;
    }

    // Might be a switch
    if (((camera->animState == 0) || (camera->animState == 0xA)) || (camera->animState == 0x14)) {
        if (camera->globalCtx->view.unk_124 == 0) {
            camera->unk_14C |= 0x20;
            camera->globalCtx->view.unk_124 = camera->thisIdx | 0x50;
            return 1;
        }
        camera->unk_14C &= ~0x20;
    }

    camera->unk_14C &= ~0x10;
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        t = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / sp58));
        keep3->unk_00 = NEXTPCT * sp58 * t;
        keep3->unk_04 = NEXTSETTING;
        keep3->unk_08 = NEXTSETTING;
        keep3->unk_0C = NEXTSETTING;
        keep3->unk_10 = NEXTSETTING;
        keep3->unk_14 = NEXTSETTING;
        keep3->unk_18 = NEXTSETTING;
        keep3->unk_1C = NEXTPCT;
        keep3->unk_20 = NEXTSETTING;
        keep3->unk_24 = NEXTPCT;
        keep3->unk_28 = NEXTSETTING;
        keep3->unk_2A = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sp58 += keep3->unk_00;
    OLib_Vec3fDiffToVecSphGeo(&sp94, temp_s0, &camera->eye);
    OLib_Vec3fDiffToVecSphGeo(&sp8C, temp_s0, temp_s2);
    func_8002EEE4(temp_s1, camera->target);
    func_8002EEE4(&sp6C, &camera->player->actor);
    spD0 = sp3C->pos;
    spD0.y += sp58;
    OLib_Vec3fDiffToVecSphGeo(&spA4, &spD0, temp_s1);
    sCameraInterfaceFlags = keep3->unk_2A;
    if (camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14) {
        spAC[0] = camera->target;
        spAC[1] = camera->player;
        camera->animState++;
        unk2C->unk_0C = camera->target;
        phi_f12 = keep3->unk_08 < spA4.r ? 1.0f : spA4.r / keep3->unk_08;
        unk2C->unk_1C = keep3->unk_28;
        spBC = ((1.0f - phi_f12) * spA4.r) / unk2C->unk_1C;
        sp9C.pitch = DEGF_TO_BINANG(F32_LERPIMP(keep3->unk_14, keep3->unk_18, phi_f12)) + (s32)-(spA4.pitch * keep3->unk_1C);
        temp_f14 = keep3->unk_0C + ((keep3->unk_10 - keep3->unk_0C) * phi_f12);

        if(keep3->unk_2A & 0x10){
            sp9C.yaw = (BINANG_SUB(spA4.yaw, sp8C.yaw) < 0 ?
                spA4.yaw + DEGF_TO_BINANG(temp_f14) :
                spA4.yaw - DEGF_TO_BINANG(temp_f14));
        } else if(keep3->unk_2A & 0x20){
            sp9C.yaw = (BINANG_SUB(spA4.yaw, sp9C.yaw) < 0 ?
                BINANG_ROT180(spA4.yaw) - DEGF_TO_BINANG(temp_f14) :
                BINANG_ROT180(spA4.yaw) + DEGF_TO_BINANG(temp_f14));
        } else {
            if(ABS(BINANG_SUB(spA4.yaw, sp8C.yaw)) < 0x3FFF) {
                sp9C.yaw = BINANG_SUB(spA4.yaw, sp8C.yaw) < 0 ? 
                    spA4.yaw + DEGF_TO_BINANG(temp_f14) :
                    spA4.yaw - DEGF_TO_BINANG(temp_f14);
            } else {
                sp9C.yaw = BINANG_SUB(spA4.yaw, sp8C.yaw) < 0 ?
                BINANG_ROT180(spA4.yaw) - DEGF_TO_BINANG(temp_f14) :
                BINANG_ROT180(spA4.yaw) + DEGF_TO_BINANG(temp_f14);
            }
        }
        temp_f14_2 = spA4.r;
        sp80 = sp9C.yaw;
        sp82 = sp9C.pitch;
        spA4.r = (spBC * zero6) + (temp_f14_2 * (1.0f - zero6));
        spD0 = sp3C->pos;
        spB8 = temp_f14_2;
        spD4 = spD4 + sp58;
        Camera_Vec3fVecSphGeoAdd(temp_s1_2, &spD0, &spA4);
        spA4.r = temp_f14_2;
        sp9C.r = ((keep3->unk_04 + (temp_f14_2 * 0.5f)) - sp8C.r) + sp8C.r;
        Camera_Vec3fVecSphGeoAdd(&spC4, temp_s1_2, &sp9C);
        if (!(keep3->unk_2A & 0x80)) {
            sp84 = ARRAY_COUNT(D_8011D3B0);
            for(phi_s0 = 0; phi_s0 < sp84; phi_s0++){
                if (!func_800626B0(camera->globalCtx, &camera->globalCtx->colChkCtx, temp_s1_2, &spC4, &spAC, 2) &&
                    !func_80043F34(camera, temp_s1_2, &spC4)) {
                        break;
                }
                sp9C.yaw = D_8011D3B0[phi_s0] + sp80;
                sp9C.pitch = D_8011D3CC[phi_s0] + sp82;
                Camera_Vec3fVecSphGeoAdd(&spC4, temp_s1_2, &sp9C);
            }
        }   
        osSyncPrintf("camera: talk: BG&collision check %d time(s)\n", phi_s0);
        camera->unk_14C &= ~4;
        temp_f0_2 = (f32) ((s32) ((unk2C->unk_1C + 1) * unk2C->unk_1C) >> 1);
        unk2C->unk_00.y = BINANG_SUB(sp9C.yaw, sp8C.yaw)  / temp_f0_2;
        unk2C->unk_00.z = BINANG_SUB(sp9C.pitch, sp8C.pitch) / temp_f0_2;
        unk2C->unk_00.x = BINANG_SUB(sp9C.r, sp8C.r) / temp_f0_2;
        return 1;
    }

    if (unk2C->unk_1C != 0) {
        temp_s0->x = F32_LERPIMPINV(temp_s0->x, unk2C->unk_10.x, unk2C->unk_1C);
        temp_s0->y = F32_LERPIMPINV(temp_s0->y, unk2C->unk_10.y, unk2C->unk_1C);
        temp_s0->z = F32_LERPIMPINV(temp_s0->z, unk2C->unk_10.z, unk2C->unk_1C);
        sp9C.r = ((unk2C->unk_00.x * unk2C->unk_1C) + sp8C.r) + 1.0f;
        sp9C.yaw = sp8C.yaw + (unk2C->unk_00.y * unk2C->unk_1C);
        sp9C.pitch = sp8C.pitch + (unk2C->unk_00.z * unk2C->unk_1C);
        Camera_Vec3fVecSphGeoAdd(temp_s2, temp_s0, &sp9C);
        *sp48 = *temp_s2;
        camera->fov = Camera_LERPCeilF(keep3->unk_20, camera->fov, 0.5f, 1.0f);
        camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
        camera->atLERPStepScale = Camera_ClampLERPScale(camera, keep3->unk_24);
        func_80043F34(camera, temp_s0, sp48);
        unk2C->unk_1C--;
    } else {
        camera->unk_14C |= (0x400 | 0x10);
    }
    if ((camera->unk_14C & 8)) {
        sCameraInterfaceFlags = 0;
        func_80043B60(camera);
        camera->atLERPStepScale = 0.0f;
        if (camera->xzSpeed > 0.001f || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG)) {
            camera->unk_14C |= 4;
            camera->unk_14C &= ~8;
        }
    }
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_KeepOn3.s")
#endif

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 Camera_KeepOn4(Camera *camera) {
    static Vec3f D_8015BD50;
    static Vec3f D_8015BD60;
    static Vec3f D_8015BD70;
    s16 *temp_s0 = &camera->unk_12C;
    Vec3f *sp44 = &camera->eye;
    Vec3f *sp40 = &camera->at;
    
    Actor* spCC[2];
    Vec3f *sp3C = &camera->eyeNext;
    PosRot *sp38 = &camera->playerPosRot;
    CollisionPoly *spC0;
    VecSph spB8;
    VecSph spB0;
    VecSph spA8;
    KeepOn4* keep4 = &camera->params.keep4;
    s16 spA2;
    s16 spA0;
    s16 pad2;
    s16 sp9C;
    f32 temp_f0_2;
    s32 pad;
    CameraModeValue *values;
    KeepOn4_Unk20* unk20 = &keep4->unk_20;
    f32 sp88;
    Player *sp84;
    s16 sp82;
    s16 temp_v0_3;
    s32 sp7C;
    f32 temp_f12;
    
    sp84 = (Player*)camera->globalCtx->actorCtx.actorList[ACTORTYPE_PLAYER].first;
    
    if(camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14){
        if(camera->globalCtx->view.unk_124 == 0){
            camera->unk_14C |= 0x20;
            camera->unk_14C &= ~(0x4 | 0x2);
            camera->globalCtx->view.unk_124 = camera->thisIdx | 0x50;
            return 1;
        }
        camera->unk_14C &= ~0x20;
        unk20->unk_14 = *temp_s0;
    }
    
    if (unk20->unk_14 != *temp_s0) {
        osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: item: item type changed %d -> %d\n" VT_RST, unk20->unk_14, *temp_s0);
        camera->unk_14C |= 0x20;
        camera->animState = 0x14;
        camera->unk_14C &= ~(0x4 | 0x2);
        camera->globalCtx->view.unk_124 = camera->thisIdx | 0x50;
        return 1;
    }

    sp88 = Player_GetCameraYOffset(camera->player);
    camera->unk_14C &= ~0x10;
    if(RELOAD_PARAMS){
        const f32 t = -0.5f;
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        temp_f12 = (1.0f + t) - ((68.0f / sp88) * t);
        keep4->unk_00 = NEXTPCT * sp88 * temp_f12;
        keep4->unk_04 = NEXTPCT * sp88 * temp_f12;
        keep4->unk_08 = NEXTSETTING;
        keep4->unk_0C = NEXTSETTING;
        keep4->unk_10 = NEXTSETTING;
        keep4->unk_18 = NEXTSETTING;
        keep4->unk_1C = NEXTSETTING;
        keep4->unk_14 = NEXTPCT;
        keep4->unk_1E = NEXTSETTING;
        osSyncPrintf("camera: item: type %d\n", *temp_s0);
        switch(*temp_s0){
            case 1:
                keep4->unk_00 = (sp88 * -0.6f) * temp_f12;
                keep4->unk_04 = (sp88 * 2.0f) * temp_f12;
                keep4->unk_08 = 10.0f;
                break;
            case 2:
            case 3:
                keep4->unk_08 = -20.0f;
                keep4->unk_18 = 80.0f;
                break;
            case 4:
                keep4->unk_00 = (sp88 * -0.2f) * temp_f12;
                keep4->unk_08 = 25.0f;
                break;
            case 8:
                keep4->unk_00 = (sp88 * -0.2f) * temp_f12;
                keep4->unk_04 = (sp88 * 0.8f) * temp_f12;
                keep4->unk_08 = 50.0f;
                keep4->unk_18 = 70.0f;
                break;
            case 9:
                keep4->unk_00 = (sp88 * 0.1f) * temp_f12;
                keep4->unk_04 = (sp88 * 0.5f) * temp_f12;
                keep4->unk_08 = -20.0f;
                keep4->unk_0C = 0.0f;
                keep4->unk_1C = 0x2540;
                break;
            case 5:
                keep4->unk_00 = (sp88 * -0.4f) * temp_f12;
                keep4->unk_08 = -10.0f;
                keep4->unk_0C = 45.0f;
                keep4->unk_1C = 0x2002;
                break;  
            case 10:
                keep4->unk_00 = (sp88 * -0.5f) * temp_f12;
                keep4->unk_04 = (sp88 * 1.5f) * temp_f12;
                keep4->unk_08 = -15.0f;
                keep4->unk_0C = 175.0f;
                keep4->unk_18 = 70.0f;
                keep4->unk_1C = 0x2202;
                keep4->unk_1E = 0x3C;
                break;
            case 12:
                keep4->unk_00 = (sp88 * -0.6f) * temp_f12;
                keep4->unk_04 = (sp88 * 1.6f) * temp_f12;
                keep4->unk_08 = -2.0f;
                keep4->unk_0C = 120.0f;
                keep4->unk_10 = sp84->stateFlags1 & 0x8000000 ? 0.0f : 20.0f;
                keep4->unk_1C = 0x3212;
                keep4->unk_1E = 0x1E;
                keep4->unk_18 = 50.0f;
                break;
            case 0x5A:
                keep4->unk_00 = (sp88 * -0.3f) * temp_f12;
                keep4->unk_18 = 45.0f;
                keep4->unk_1C = 0x2F02;
                break;
            case 0x5B:
                keep4->unk_00 = (sp88 * -0.1f) * temp_f12;
                keep4->unk_04 = (sp88 * 1.5f) * temp_f12;
                keep4->unk_08 = -3.0f;
                keep4->unk_0C = 10.0f;
                keep4->unk_18 = 55.0f;
                keep4->unk_1C = 0x2F08;
                break;
            case 0x51:
                keep4->unk_00 = (sp88 * -0.3f) * temp_f12;
                keep4->unk_04 = (sp88 * 1.5f) * temp_f12;
                keep4->unk_08 = 2.0f;
                keep4->unk_0C = 20.0f;
                keep4->unk_10 = 20.0f;
                keep4->unk_1C = 0x2280;
                keep4->unk_1E = 0x1E;
                keep4->unk_18 = 45.0f;
                break;
            case 11:
                keep4->unk_00 = (sp88 * -0.19f) * temp_f12;
                keep4->unk_04 = (sp88 * 0.7f) * temp_f12;
                keep4->unk_0C = 130.0f;
                keep4->unk_10 = 10.0f;
                keep4->unk_1C = 0x2522;
                break;
            default:
                break;
        }
    }
    
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    
    sUpdateCameraDirection = 1;
    sCameraInterfaceFlags = keep4->unk_1C;
    OLib_Vec3fDiffToVecSphGeo(&spB0, sp40, sp44);
    OLib_Vec3fDiffToVecSphGeo(&spA8, sp40, sp3C);
    D_8015BD50 = sp38->pos;
    D_8015BD50.y += sp88;
    temp_f0_2 = func_8003CCA4(&camera->globalCtx->colCtx, &spC0, &sp7C, &D_8015BD50);
    if ((keep4->unk_00 + D_8015BD50.y) < temp_f0_2) {
        D_8015BD50.y = temp_f0_2 + 10.0f;
    } else {
        D_8015BD50.y += keep4->unk_00;
    }

    sp9C = 0;
    switch(camera->animState){
        case 0:
        case 0x14:
            spCC[0] = &camera->player->actor;
            sp9C++;
            func_80043ABC(camera);
            camera->unk_14C &= ~(0x4 | 0x2);
            unk20->unk_10 = keep4->unk_1E;
            unk20->unk_08 = sp38->pos.y - camera->playerPosDelta.y;
            if(keep4->unk_1C & 2){
                spA2 = DEGF_TO_BINANG(keep4->unk_08);
                spA0 = BINANG_SUB(BINANG_ROT180(sp38->rot.y), spA8.yaw) > 0 ? 
                    BINANG_ROT180(sp38->rot.y) + DEGF_TO_BINANG(keep4->unk_0C) :
                    BINANG_ROT180(sp38->rot.y) - DEGF_TO_BINANG(keep4->unk_0C);
            } else if(keep4->unk_1C & 4){
                spA2 = DEGF_TO_BINANG(keep4->unk_08);
                spA0 = DEGF_TO_BINANG(keep4->unk_0C);
            } else if(keep4->unk_1C & 8 && camera->target != NULL){
                PosRot sp60;
                func_8002EF44(&sp60, camera->target);
                spA2 = DEGF_TO_BINANG(keep4->unk_08) - sp60.rot.x;
                spA0 = BINANG_SUB(BINANG_ROT180(sp60.rot.y), spA8.yaw) > 0 ?
                    BINANG_ROT180(sp60.rot.y) + DEGF_TO_BINANG(keep4->unk_0C) :
                    BINANG_ROT180(sp60.rot.y) - DEGF_TO_BINANG(keep4->unk_0C);
                spCC[1] = camera->target;
                sp9C++;
            } else if(keep4->unk_1C & 0x80 && camera->target != NULL){
                PosRot sp4C;
                func_8002EF14(&sp4C, camera->target);
                spA2 = DEGF_TO_BINANG(keep4->unk_08);
                spA0 = Camera_XZAngle(&sp4C.pos, &sp38->pos);
                spA0 = (BINANG_SUB(spA0, spA8.yaw) > 0) ?
                    DEGF_TO_BINANG(keep4->unk_0C) + spA0:
                    spA0 - DEGF_TO_BINANG(keep4->unk_0C);
                spCC[1] = camera->target;
                sp9C++;
            } else if(keep4->unk_1C & 0x40){
                spA2 = DEGF_TO_BINANG(keep4->unk_08);
                spA0 = spA8.yaw;
            } else {
                spA2 = spA8.pitch;
                spA0 = spA8.yaw;
            }
            spB8.pitch = spA2;
            spB8.yaw = spA0;
            spB8.r = keep4->unk_04;
            Camera_Vec3fVecSphGeoAdd(&D_8015BD70, &D_8015BD50, &spB8);
            if(!(keep4->unk_1C & 1)){
                sp82 = ARRAY_COUNT(D_8011D3B0);
                for(sp7C = 0; sp7C < sp82; sp7C++){
                    if(!func_800626B0(camera->globalCtx, &camera->globalCtx->colChkCtx, &D_8015BD50, &D_8015BD70, spCC, sp9C) &&
                        !func_80043F34(camera, &D_8015BD50, &D_8015BD70)){
                            break;
                    }
                    spB8.yaw = D_8011D3B0[sp7C] + spA0;
                    spB8.pitch = D_8011D3CC[sp7C] + spA2;
                    Camera_Vec3fVecSphGeoAdd(&D_8015BD70, &D_8015BD50, &spB8);
                }
                osSyncPrintf("camera: item: BG&collision check %d time(s)\n", sp7C);
            }
            unk20->unk_04 = BINANG_SUB(spB8.pitch, spA8.pitch) / (f32)unk20->unk_10;
            unk20->unk_00 = BINANG_SUB(spB8.yaw, spA8.yaw) / (f32)unk20->unk_10;
            unk20->unk_0C = spA8.yaw;
            unk20->unk_0E = spA8.pitch;
            camera->animState++;
            unk20->unk_12 = 1;
            break;
        case 0xA:
            unk20->unk_08 = sp38->pos.y - camera->playerPosDelta.y;
        default:
            break;
    }
    camera->xzOffsetUpdateRate = 0.25f;
    camera->yOffsetUpdateRate = 0.25f;
    camera->atLERPStepScale = 0.75f;
    Camera_LERPCeilVec3f(&D_8015BD50, sp40, 0.5f, 0.5f, 0.2f);
    if (keep4->unk_10 != 0.0f) {
        spB8.r = keep4->unk_10;
        spB8.pitch = 0;
        spB8.yaw = sp38->rot.y;
        Camera_Vec3fVecSphGeoAdd(sp40, sp40, &spB8);
    }
    camera->atLERPStepScale = 0.0f;
    spB8.r = camera->dist = Camera_LERPCeilF(keep4->unk_04, camera->dist, 0.25f, 2.0f);
    if(unk20->unk_10 != 0){
        camera->unk_14C |= 0x20;
        unk20->unk_0C += (s16)unk20->unk_00;
        unk20->unk_0E += (s16)unk20->unk_04;
        unk20->unk_10--;
    } else if(keep4->unk_1C & 0x10){
        camera->unk_14C |= (0x400 | 0x10);
        camera->unk_14C |= (0x4 | 0x2);
        camera->unk_14C &= ~8;
        if(camera->timer > 0){
            camera->timer--;
        }
    } else {
        camera->unk_14C |= (0x400 | 0x10);
        if(camera->unk_14C & 8 || keep4->unk_1C & 0x80){
            sCameraInterfaceFlags = 0;
            camera->unk_14C |= (0x4 | 0x2);
            camera->unk_14C &= ~8;
            if(camera->prevCamDataIdx < 0){
                Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
            } else{
                Camera_ChangeDataIdx(camera, camera->prevCamDataIdx);
                camera->prevCamDataIdx = -1;
            }
        }
    }
    spB8.yaw = Camera_LERPCeilS(unk20->unk_0C, spA8.pitch, keep4->unk_14, 4);
    spB8.pitch = Camera_LERPCeilS(unk20->unk_0E, spA8.yaw, keep4->unk_14, 4);
    Camera_Vec3fVecSphGeoAdd(sp3C, sp40, &spB8);
    *sp44 = *sp3C;
    func_80043F34(camera, sp40, sp44);
    camera->fov = Camera_LERPCeilF(keep4->unk_18, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_KeepOn4.s")
#endif
#undef NON_MATCHING

/**
 * Talking in a pre-rendered room
*/
s32 Camera_KeepOn0(Camera *camera) {
    Vec3f *eye = &camera->eye;
    Vec3f *eyeNext = &camera->eyeNext;
    Vec3f *at = &camera->at;
    VecSph eyeTargetPosOffset;
    VecSph eyeAtOffset;
    KeepOn0 *keep0 = &camera->params.keep0;
    CameraModeValue* values;
    PosRot *targetPosRot = &camera->targetPosRot;
    CamPosData *sceneCamData;
    Vec3s sceneCameraRot;
    s16 fov;
    KeepOn0Anim *anim = &keep0->anim;
   
    camera->unk_14C &= ~0x10;
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        keep0->fovScale = NEXTPCT;
        keep0->yawScale = NEXTPCT;
        keep0->timerInit = NEXTSETTING;
        keep0->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    sceneCamData = func_8004476C(camera);
    Camera_Vec3sToVec3f(eyeNext, &sceneCamData->pos);
    *eye = *eyeNext;

    sceneCameraRot = sceneCamData->rot; // unused
    
    fov = sceneCamData->fov;
    if (fov == -1) {
        fov = 6000;
    }

    if (camera->target == NULL || camera->target->update == NULL) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: talk: target is not valid, change normal camera\n" VT_RST);
        }
        camera->target = NULL;
        Camera_ChangeModeDefaultFlags(camera, CAM_MODE_NORMAL);
        return true;
    }

    func_8002EEE4(targetPosRot, camera->target);
    
    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, eye, at);
    OLib_Vec3fDiffToVecSphGeo(&eyeTargetPosOffset, eye, &targetPosRot->pos);

    sCameraInterfaceFlags = keep0->interfaceFlags;
    
    if (camera->animState == 0) {
        camera->animState++;
        camera->fov = PCT(fov);
        camera->roll = 0;
        camera->atLERPStepScale = 0.0f;
        anim->animTimer = keep0->timerInit;
        anim->fovTarget = camera->fov - (camera->fov * keep0->fovScale);
    }

    if (anim->animTimer != 0) {
        eyeAtOffset.yaw += (BINANG_SUB(eyeTargetPosOffset.yaw, eyeAtOffset.yaw) / anim->animTimer) * keep0->yawScale;
        Camera_Vec3fVecSphGeoAdd(at, eye, &eyeAtOffset);
        anim->animTimer--;
    } else {
        camera->unk_14C |= (0x400 | 0x10);
    }
    camera->fov = Camera_LERPCeilF(anim->fovTarget, camera->fov, 0.5f, 10.0f);
    return true;
}

s32 Camera_Fixed1(Camera *camera) {
    Fixed1 *fixd1 = &camera->params.fixd1;
    Fixed1Anim* anim = &fixd1->anim;
    s32 pad;
    VecSph eyeOffset;
    VecSph eyeAtOffset;
    s32 pad2;
    Vec3f adjustedPos;
    CamPosData *scenePosData;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    PosRot *playerPosRot = &camera->playerPosRot;
    f32 yOffset;
    CameraModeValue *values;

    yOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        scenePosData = func_8004476C(camera);
        Camera_Vec3sToVec3f(&anim->eyePosRotTarget.pos, &scenePosData->pos);
        anim->eyePosRotTarget.rot = scenePosData->rot;
        anim->fov = scenePosData->fov;
        fixd1->unk_00 = NEXTPCT * yOffset;
        fixd1->lerpStep = NEXTPCT;
        fixd1->fov = NEXTSETTING;
        fixd1->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    if (anim->fov == -1) {
        anim->fov = fixd1->fov * 100.0f;
    } else if (anim->fov < 361) {
        anim->fov *= 100;
    }

    sCameraInterfaceFlags = fixd1->interfaceFlags;

    if (camera->animState == 0) {
        camera->animState++;
        func_80043B60(camera);
        if (anim->fov != -1) {
            fixd1->fov = PCT(anim->fov);
        }
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, eye, at);

    Camera_LERPCeilVec3f(&anim->eyePosRotTarget.pos, eye, 0.1f, 0.1f, 0.2f);
    adjustedPos = playerPosRot->pos;
    adjustedPos.y += yOffset;
    camera->dist = OLib_Vec3fDist(&adjustedPos, eye);

    eyeOffset.r = camera->dist;
    eyeOffset.pitch = Camera_LERPCeilS(-anim->eyePosRotTarget.rot.x, eyeAtOffset.pitch, fixd1->lerpStep, 5);
    eyeOffset.yaw = Camera_LERPCeilS(anim->eyePosRotTarget.rot.y, eyeAtOffset.yaw, fixd1->lerpStep, 5);
    
    Camera_Vec3fVecSphGeoAdd(at, eye, &eyeOffset);
    
    camera->eyeNext = *eye;

    camera->fov = Camera_LERPCeilF(fixd1->fov, camera->fov, fixd1->lerpStep, 0.01f);
    camera->roll = 0;
    camera->atLERPStepScale = 0.0f;

    camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - playerPosRot->pos.z;

    return true;
}

s32 Camera_Fixed2(Camera *camera) {
    s32 pad;
    Fixed2 *fixd2 = &camera->params.fixd2;
    CameraModeValue* values;
    Vec3f atTarget;
    Vec3f posOffsetTarget;
    f32 yOffsetInverse;
    CamPosData *scenePosData;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    f32 yOffset;
    PosRot *playerPosRot = &camera->playerPosRot;
    Fixed2_InitParams *initParams = &fixd2->initParams;

    yOffset = Player_GetCameraYOffset(camera->player);

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        fixd2->yOffset = (NEXTPCT * yOffset) * yOffsetInverse;
        fixd2->eyeStepScale = NEXTPCT;
        fixd2->posStepScale = NEXTPCT;
        fixd2->fov = NEXTSETTING;
        fixd2->interfaceFlags = NEXTSETTING;
        initParams->fov = fixd2->fov * 100.0f;
        scenePosData = func_8004476C(camera);
        if (scenePosData != NULL) {
            Camera_Vec3sToVec3f(&initParams->eye, &scenePosData->pos);
            if (scenePosData->fov != -1) {
                initParams->fov = scenePosData->fov;
            }
        } else {
            initParams->eye = *eye;
        }
        if (initParams->fov < 0x169) {
            initParams->fov *= 100;
        }
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = fixd2->interfaceFlags;

    posOffsetTarget.x = 0.0f;
    posOffsetTarget.y = fixd2->yOffset + yOffset;
    posOffsetTarget.z = 0.0f;

    Camera_LERPCeilVec3f(&posOffsetTarget, &camera->posOffset, fixd2->posStepScale, fixd2->posStepScale, 0.1f);
    atTarget.x = playerPosRot->pos.x + camera->posOffset.x;
    atTarget.y = playerPosRot->pos.y + camera->posOffset.y;
    atTarget.z = playerPosRot->pos.z + camera->posOffset.z;
    if (camera->animState == 0) {
        camera->animState++;
        func_80043B60(camera);
        if (!(fixd2->interfaceFlags & 1)) {
            *eye = *eyeNext = initParams->eye;
            camera->at = atTarget;
        }
    }

    Camera_LERPCeilVec3f(&atTarget, &camera->at, fixd2->posStepScale, fixd2->posStepScale, 10.0f);
    Camera_LERPCeilVec3f(&initParams->eye, eyeNext, fixd2->eyeStepScale, fixd2->eyeStepScale, 0.1f);
    
    *eye = *eyeNext;
    camera->dist = OLib_Vec3fDist(at, eye);
    camera->roll = 0;
    camera->xzSpeed = 0.0f;
    camera->fov = PCT(initParams->fov);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, 1.0f);
    camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
    return true;
}

/**
 * Camera's position is fixed, does not move, or rotate
*/
s32 Camera_Fixed3(Camera *camera) {
    s32 pad;
    Fixed3 *fixd3 = &camera->params.fixd3;
    CameraModeValue *values;
    VecSph atSph;
    CamPosData *sceneCamData;
    VecSph eyeAtOffset;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Fixed3Anim *anim = &fixd3->anim;

    sceneCamData = func_8004476C(camera);

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, eye, at);

    if (RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        fixd3->interfaceFlags = NEXTSETTING;
        CPY_SCENECAM(eyeNext, anim->rot);
        anim->fov = sceneCamData->fov;
        anim->jfifId = sceneCamData->jfifId;
        if (anim->fov == -1) {
            anim->fov = 6000;
        }
        if (anim->fov <= 360) {
            anim->fov *= 100;
        }
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    if (camera->animState == 0) {
        anim->updDirTimer = 5;
        R_CAM_FIXED3_FOV =  anim->fov;
        camera->animState++;
    }

    if (sceneCamData->jfifId != anim->jfifId) {
        osSyncPrintf("camera: position change %d \n", anim->jfifId);
        anim->jfifId = sceneCamData->jfifId;
        anim->updDirTimer = 5;
    }

    if (anim->updDirTimer > 0) {
        anim->updDirTimer--;
        sUpdateCameraDirection = true;
    } else {
        sUpdateCameraDirection = false;
    }

    atSph.r = 150.0f;
    atSph.yaw = anim->rot.y;
    atSph.pitch = -anim->rot.x;
    
    Camera_Vec3fVecSphGeoAdd(at, eye, &atSph);
    sCameraInterfaceFlags = fixd3->interfaceFlags;
    anim->fov = R_CAM_FIXED3_FOV;
    camera->roll = 0;
    camera->fov = anim->fov * 0.01f;
    camera->atLERPStepScale = 0.0f;
    return true;
}

/**
 * camera follow player, eye is in a fixed offset of the previous eye, and a value
 * specified in the scene.
*/
s32 Camera_Fixed4(Camera *camera) {
    Fixed4 *fixed4 = &camera->params.fixd4;
    PosRot *playerPosRot = &camera->playerPosRot;
    Vec3f *eye = &camera->eye;
    Vec3f playerPosWithCamOffset;

    Vec3f atTarget;
    Vec3f posOffsetTarget;
    VecSph atEyeNextOffset;
    VecSph atTargetEyeNextOffset;
    
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Fixed4Anim* anim = &fixed4->anim;
    CamPosData *camPosData;
    Vec3f *posOffset = &camera->posOffset;
    
    f32 playerYOffset;
    f32 playerYOffsetNormalized;
    CameraModeValue *values;
    

    playerYOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        playerYOffsetNormalized = ((1.0f + PCT(OREG(46))) - (PCT(OREG(46)) * (68.0f / playerYOffset)));
        fixed4->yOffset = NEXTPCT * playerYOffset * playerYOffsetNormalized;
        fixed4->unk_04 = NEXTPCT;
        fixed4->unk_08 = NEXTPCT;
        fixed4->fov = NEXTSETTING;
        fixed4->interfaceFlags = NEXTSETTING;
        camPosData = func_8004476C(camera);
        if (camPosData != NULL) {
            Camera_Vec3sToVec3f(&anim->eyeTarget, &camPosData->pos);
        } else {
            anim->eyeTarget = *eye;
        }
    }
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    sCameraInterfaceFlags = fixed4->interfaceFlags;
    if (camera->animState == 0) {
        camera->animState++;
        if (!(fixed4->interfaceFlags & 4)) {
            func_80043B60(camera);
        }
        anim->unk_0C = fixed4->unk_08;
    }
    VEC3F_LERPIMPDST(eyeNext, eyeNext, &anim->eyeTarget, fixed4->unk_04);
    *eye = *eyeNext;
    posOffsetTarget.x = 0.0f;
    posOffsetTarget.y = fixed4->yOffset + playerYOffset;
    posOffsetTarget.z = 0.0f;
    Camera_LERPCeilVec3f(&posOffsetTarget, &camera->posOffset, 0.1f, 0.1f, 0.1f);
    playerPosWithCamOffset.x = playerPosRot->pos.x + camera->posOffset.x;
    playerPosWithCamOffset.y = playerPosRot->pos.y + camera->posOffset.y;
    playerPosWithCamOffset.z = playerPosRot->pos.z + camera->posOffset.z;
    VEC3F_LERPIMPDST(&atTarget, at, &playerPosWithCamOffset, 0.5f);

    OLib_Vec3fDiffToVecSphGeo(&atEyeNextOffset, eyeNext, at);
    OLib_Vec3fDiffToVecSphGeo(&atTargetEyeNextOffset, eyeNext, &atTarget);

    atEyeNextOffset.r += (atTargetEyeNextOffset.r - atEyeNextOffset.r) * anim->unk_0C;
    atEyeNextOffset.pitch = Camera_LERPCeilS(atTargetEyeNextOffset.pitch, atEyeNextOffset.pitch, anim->unk_0C * camera->speedRatio, 0xA);
    atEyeNextOffset.yaw = Camera_LERPCeilS(atTargetEyeNextOffset.yaw, atEyeNextOffset.yaw, anim->unk_0C * camera->speedRatio, 0xA);
    Camera_Vec3fVecSphGeoAdd(at, eyeNext, &atEyeNextOffset);
    camera->dist = OLib_Vec3fDist(at, eye);
    camera->roll = 0;
    camera->fov = fixed4->fov;
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, 1.0f);
    return true;
}

s32 Camera_Fixed0(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Subj1(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Subj2(Camera* camera) {
    return Camera_NOP(camera);
}

//#define NON_MATCHING
#ifdef NON_MATCHING
/** 
 * First person view
*/
/*
s32 Camera_Subj3(Camera *camera) {
    Subj3* subj3 = &camera->params.subj3;
    Vec3f sp98;
    Vec3f sp8C;
    VecSph sp84;
    VecSph sp7C;
    PosRot sp60;
    f32 sp58;
    s16 sp52;
    s16 sp50;
    f32 sp3C;
    Vec3f *sp38 = &camera->eye;
    Vec3f *sp30 = &camera->eyeNext;
    Subj3_Anim* anim = &subj3->anim;
    Vec3f *temp_s1 = &camera->at;
    PosRot* playerPosRot = &camera->playerPosRot;
    f32 temp_f0;
    f32 temp_f0_2;
    f32 temp_f0_3;
    f32 temp_f6;
    f32 temp_f8;
    s32 temp_f10;
    CameraModeValue* values;
    f32 t;

    func_8002EEE4(&sp60, camera->player);
    sp3C = Player_GetCameraYOffset(camera->player);
    if (camera->globalCtx->view.unk_124 == 0) {
        camera->globalCtx->view.unk_124 = camera->thisIdx | 0x50;
        return 1;
    }
    func_80043ABC(camera);
    Camera_CopyPREGToModeValues(camera);
    values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
    subj3->eyeNextYOffset = (f32) ((NEXTPCT) * sp3C);
    subj3->eyeDist = (f32) NEXTSETTING;
    subj3->eyeNextDist = (f32) NEXTSETTING;
    subj3->unk_0C = (f32) NEXTSETTING;
    subj3->atOffset.x = NEXTPCT;
    subj3->atOffset.y = NEXTPCT;
    subj3->atOffset.z = NEXTPCT;
    subj3->fovTarget = NEXTSETTING;
    subj3->interfaceFlags = NEXTSETTING;
    sp84.r = subj3->eyeNextDist;
    sp84.pitch = sp60.rot.x;
    sp84.yaw = BINANG_ROT180(sp60.rot.y);
    sp98 = sp60.pos;
    sp98.y += subj3->eyeNextYOffset;
    Camera_Vec3fVecSphGeoAdd(&sp8C, &sp98, &sp84);
    OLib_Vec3fDiffToVecSphGeo(&sp7C, temp_s1, sp38);

    sCameraInterfaceFlags = subj3->interfaceFlags;
    
    if (((camera->animState == 0) || (camera->animState == 0xA)) || (camera->animState == 0x14)) {
        anim->r = sp7C.r;
        anim->yaw = sp7C.yaw;
        anim->pitch = sp7C.pitch;
        anim->animTimer = R_DEFA_CAM_ANIM_TIME;
        camera->dist = subj3->eyeNextDist;
        camera->animState++;
        camera->rUpdateRateInv = 1.0f;
        camera->dist = subj3->eyeNextDist;
    }

    if (anim->animTimer != 0) {
        temp_s1->x = F32_LERPIMP(temp_s1->x, sp98.x, 1.0f / anim->animTimer);
        temp_s1->y = F32_LERPIMP(temp_s1->y, sp98.y, 1.0f / anim->animTimer);
        temp_s1->z = F32_LERPIMP(temp_s1->z, sp98.z, 1.0f / anim->animTimer);

        sp50 = BINANG_LERPIMP(sp84.pitch, anim->pitch, (1.0f / R_DEFA_CAM_ANIM_TIME));
        sp52 = BINANG_LERPIMP(sp84.yaw, anim->yaw, (1.0f / R_DEFA_CAM_ANIM_TIME));
        sp7C.r = Camera_LERPCeilF(anim->animTimer * (anim->r - sp84.r) * (1.0f / R_DEFA_CAM_ANIM_TIME) + sp84.r, sp7C.r, PCT(OREG(28)), 1.0f);
        sp7C.yaw = Camera_LERPCeilS(sp84.yaw + (sp52 * anim->animTimer), sp7C.yaw, PCT(OREG(28)), 0xA);
        sp7C.pitch = Camera_LERPCeilS(sp84.pitch + (sp50 * anim->animTimer), sp7C.pitch, PCT(OREG(28)), 0xA);
        Camera_Vec3fVecSphGeoAdd(sp30, temp_s1, &sp7C);
        *sp38 = *sp30;
        anim->animTimer--;
        if (camera->globalCtx->envCtx.skyDisabled == 0) {
            func_80043F34(camera, temp_s1, sp38);
        } else {
            func_80044340(camera, temp_s1, sp38);
        }
    } else {
        sp58 = Math_Sins(-sp60.rot.x);
        temp_f0_3 = Math_Coss(-sp60.rot.x);
        sp98.x = subj3->atOffset.x;
        sp98.y = (subj3->atOffset.y * temp_f0_3) - (subj3->atOffset.z * sp58);
        sp98.z = (subj3->atOffset.y * sp58) + (subj3->atOffset.z * temp_f0_3);
        sp58 = Math_Sins(BINANG_ROT180(sp60.rot.y));
        temp_f0_3 = Math_Coss(BINANG_ROT180(sp60.rot.y));
        subj3->atOffset.x = (sp98.z * sp58) + (sp98.x * temp_f0_3);
        subj3->atOffset.y = sp98.y;
        subj3->atOffset.z = (sp98.z * temp_f0_3) - (subj3->atOffset.x * sp58);
        temp_s1->x = subj3->atOffset.x + sp60.pos.x;
        temp_s1->y = subj3->atOffset.y + sp60.pos.y;
        temp_s1->z = subj3->atOffset.z + sp60.pos.z;
        sp7C.r = subj3->eyeNextDist;
        sp7C.pitch = sp60.rot.x;
        sp7C.yaw = BINANG_ROT180(sp60.rot.y);
        Camera_Vec3fVecSphGeoAdd(sp30, temp_s1, &sp7C);
        sp7C.r = subj3->eyeDist;
        Camera_Vec3fVecSphGeoAdd(sp38, temp_s1, &sp7C);
    }
    camera->posOffset.x = temp_s1->x - playerPosRot->pos.x;
    camera->posOffset.y = temp_s1->y - playerPosRot->pos.y;
    camera->posOffset.z = temp_s1->z - playerPosRot->pos.z;
    camera->fov = Camera_LERPCeilF(subj3->fovTarget, camera->fov, 0.25f, 1.0f);
    camera->roll = 0;
    camera->atLERPStepScale = 0.0f;
    return 1;
}*/
s32 Camera_Subj3(Camera *camera) {
    Vec3f sp98;
    Vec3f sp8C;
    VecSph sp84;
    VecSph sp7C;
    PosRot sp60;
    f32 sp58;
    s16 sp52;
    s16 sp50;
    f32 sp3C;
    Vec3f *sp38 = &camera->eye;
    Vec3f *sp30 = &camera->eyeNext;
    Vec3f *temp_s1 = &camera->at;
    f32 temp_f0_2;
    f32 temp_f0_3;
    f32 temp_f0_4;
    Subj3* subj3 = &camera->params.subj3;
    Subj3_Anim* anim = &subj3->anim;
    CameraModeValue* values;

    func_8002EEE4(&sp60, &camera->player->actor);
    sp3C = Player_GetCameraYOffset(camera->player);
    if (camera->globalCtx->view.unk_124 == 0) {
        camera->globalCtx->view.unk_124 = camera->thisIdx | 0x50;
        return true;
    }
    func_80043ABC(camera);
    Camera_CopyPREGToModeValues(camera);
    values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
    subj3->eyeNextYOffset = NEXTPCT * sp3C;
    subj3->eyeDist = NEXTSETTING;
    subj3->eyeNextDist = NEXTSETTING;
    subj3->unk_0C = NEXTSETTING;
    subj3->atOffset.x = NEXTPCT;
    subj3->atOffset.y = NEXTPCT;
    subj3->atOffset.z = NEXTPCT;
    subj3->fovTarget = NEXTSETTING;
    subj3->interfaceFlags = NEXTSETTING;
    sp84.r = camera->params.subj3.eyeNextDist;
    sp84.pitch = sp60.rot.x;
    sp84.yaw = BINANG_ROT180(sp60.rot.y);
    sp98 = sp60.pos;
    sp98.y += subj3->eyeNextYOffset;
    Camera_Vec3fVecSphGeoAdd(&sp8C, &sp98, &sp84);
    
    OLib_Vec3fDiffToVecSphGeo(&sp7C, temp_s1, sp38);
    sCameraInterfaceFlags = subj3->interfaceFlags;
    if(camera->animState == 0 || camera->animState == 0xA || camera->animState == 0x14){
        anim->r = sp7C.r;
        anim->yaw = sp7C.yaw;
        anim->pitch = sp7C.pitch;
        anim->animTimer = OREG(23);
        camera->dist = subj3->eyeNextDist;
        camera->animState++;
        camera->rUpdateRateInv = 1.0f;
        camera->dist = subj3->eyeNextDist;
    }

    if (anim->animTimer != 0) {
        temp_s1->x += (sp98.x - temp_s1->x) * (1.0f / anim->animTimer);
        temp_s1->y += (sp98.y - temp_s1->y) * (1.0f / anim->animTimer);
        temp_s1->z += (sp98.z - temp_s1->z) * (1.0f / anim->animTimer);
        sp50 = BINANG_SUB(anim->pitch, sp84.pitch) * (1.0f / OREG(23));
        sp52 = BINANG_SUB(anim->yaw, sp84.yaw) * (1.0f / OREG(23));
        sp7C.r = Camera_LERPCeilF(sp84.r + (((anim->r - sp84.r) * (1.0f / OREG(23))) * anim->animTimer), sp7C.r, PCT(OREG(28)), 1.0f);
        sp7C.yaw = Camera_LERPCeilS(sp84.yaw + (sp52 * anim->animTimer), sp7C.yaw, PCT(OREG(28)), 0xA);
        sp7C.pitch = Camera_LERPCeilS(sp84.pitch + (sp50 * anim->animTimer), sp7C.pitch, PCT(OREG(28)), 0xA);
        Camera_Vec3fVecSphGeoAdd(sp30, temp_s1, &sp7C);
        *sp38 = *sp30;
        anim->animTimer--;
        if (camera->globalCtx->envCtx.skyDisabled == 0) {
            func_80043F34(camera, temp_s1, sp38);
        } else {
            func_80044340(camera, temp_s1, sp38);
        }
    } else {
        sp58 = Math_Sins(-sp60.rot.x);
        temp_f0_3 = Math_Coss(sp60.rot.x);
        sp98.x = subj3->atOffset.x;
        sp98.y = (subj3->atOffset.y * temp_f0_3) - (subj3->atOffset.z * sp58);
        sp98.z = (subj3->atOffset.y * sp58) + (subj3->atOffset.z * temp_f0_3);
        sp58 = Math_Sins(BINANG_ROT180(sp60.rot.y));
        temp_f0_3 = Math_Coss(BINANG_ROT180(sp60.rot.y));
        subj3->atOffset.x = (sp98.z * sp58) + (sp98.x * temp_f0_3);
        subj3->atOffset.y = sp98.y;
        subj3->atOffset.z = (sp98.z * temp_f0_3) - (sp98.x * sp58);
        temp_s1->x = sp60.pos.x + subj3->atOffset.x;
        temp_s1->y = sp60.pos.y + subj3->atOffset.y;
        temp_s1->z = sp60.pos.z + subj3->atOffset.z;
        sp7C.yaw = BINANG_ROT180(sp60.rot.y);
        sp7C.r = subj3->eyeNextDist;
        sp7C.pitch = sp60.rot.x;
        Camera_Vec3fVecSphGeoAdd(sp30, temp_s1, &sp7C);
        sp7C.r = subj3->eyeDist;
        Camera_Vec3fVecSphGeoAdd(sp38, temp_s1, &sp7C);
    }
    camera->posOffset.x = camera->at.x - camera->playerPosRot.pos.x;
    camera->posOffset.y = camera->at.y - camera->playerPosRot.pos.y;
    camera->posOffset.z = camera->at.z - camera->playerPosRot.pos.z;
    camera->fov = Camera_LERPCeilF(subj3->fovTarget, camera->fov, 0.25f, 1.0f);
    camera->roll = 0;
    camera->atLERPStepScale = 0.0f;
    return true;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Subj3.s")
#endif
#undef NON_MATCHING

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 Camera_Subj4(Camera *camera) {
    f32 tx2;
    f32 tx;
    f32 temp_f2;
    u16 spAA;
    Vec3s *spA4;
    Vec3f sp98;
    Vec3f sp8C;
    f32 sp88;
    f32 temp_f16;
    s16 pad2;
    PosRot sp6C;
    VecSph sp64;
    VecSph sp5C;
    s16 temp_a0;
    Vec3f *sp34 = &camera->eyeNext;
    PosRot* playerPosRot = &camera->playerPosRot;
    Subj4Anim *temp_s0 = &camera->params.subj4.anim;
    Vec3f *temp_s2 = &camera->at;
    Vec3f *temp_s3 = &camera->eye;
    CameraModeValue* values;
    Player* player;

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        camera->params.subj4.interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    if (camera->globalCtx->view.unk_124 == 0) {
        camera->globalCtx->view.unk_124 = (camera->thisIdx | 0x50);
        camera->params.subj4.anim.unk_24 = camera->xzSpeed;
        return true;
    }

    func_8002EF44(&sp6C, &camera->player->actor);
    
    OLib_Vec3fDiffToVecSphGeo(&sp5C, temp_s2, temp_s3);
    sCameraInterfaceFlags = camera->params.subj4.interfaceFlags;
    if (camera->animState == 0) {
        spA4 = func_8004481C(camera, &spAA);
        Camera_Vec3sToVec3f(&temp_s0->unk_00.a, &spA4[1]);
        Camera_Vec3sToVec3f(&sp98, &spA4[spAA - 2]);

        sp64.r = 10.0f;
        // 0x238C ~ 50 degrees
        sp64.pitch = 0x238C;
        sp64.yaw = Camera_XZAngle(&sp98, &temp_s0->unk_00.a);
        sp88 = OLib_Vec3fDist(&playerPosRot->pos, &temp_s0->unk_00.a);
        if (OLib_Vec3fDist(&playerPosRot->pos, &sp98) < sp88) {
            temp_s0->unk_00.b.x = temp_s0->unk_00.a.x - sp98.x;
            temp_s0->unk_00.b.y = temp_s0->unk_00.a.y - sp98.y;
            temp_s0->unk_00.b.z = temp_s0->unk_00.a.z - sp98.z;
            temp_s0->unk_00.a = sp98;
        } else {
            temp_s0->unk_00.b.x = sp98.x - temp_s0->unk_00.a.x;
            temp_s0->unk_00.b.y = sp98.y - temp_s0->unk_00.a.y;
            temp_s0->unk_00.b.z = sp98.z - temp_s0->unk_00.a.z;
            sp64.yaw = BINANG_ROT180(sp64.yaw);
        }
        temp_s0->unk_30 = sp64.yaw;
        temp_s0->unk_32 = 0xA;
        temp_s0->unk_2C = 0;
        temp_s0->unk_2E = false;
        temp_s0->unk_28 = 0.0f;
        camera->animState++;
    }

    if (temp_s0->unk_32 != 0) {
        sp64.pitch = 0x238C;
        sp64.r = 10.0f;
        sp64.yaw = temp_s0->unk_30;
        Camera_Vec3fVecSphGeoAdd(&sp8C, &sp6C.pos, &sp64);
        temp_f2 = temp_s0->unk_32 + 1.0f;
        temp_s2->x = F32_LERPIMPINV(temp_s2->x, sp8C.x, temp_f2);
        temp_s2->y = F32_LERPIMPINV(temp_s2->y, sp8C.y, temp_f2);
        temp_s2->z = F32_LERPIMPINV(temp_s2->z, sp8C.z, temp_f2);
        sp5C.r -= (sp5C.r / temp_f2);
        sp5C.yaw = BINANG_LERPIMPINV(sp5C.yaw, BINANG_ROT180(sp6C.rot.y), temp_s0->unk_32);
        sp5C.pitch = BINANG_LERPIMPINV(sp5C.pitch, sp6C.rot.x, temp_s0->unk_32);
        Camera_Vec3fVecSphGeoAdd(sp34, temp_s2, &sp5C);
        *temp_s3 = *sp34;
        temp_s0->unk_32--;
        return false;
    } else if (temp_s0->unk_24 < 0.5f) {
        return false;
    }

    func_8002EF44(&sp6C, &camera->player->actor);
    Math3D_LineClosestToPoint(&temp_s0->unk_00, &sp6C.pos, sp34);
    temp_s2->x = sp34->x + temp_s0->unk_00.b.x;
    temp_s2->y = sp34->y + temp_s0->unk_00.b.y;
    temp_s2->z = sp34->z + temp_s0->unk_00.b.z;
    *temp_s3 = *sp34;
    sp64.yaw = temp_s0->unk_30;
    sp64.pitch = 0x238C;
    sp64.r = 5.0f;
    Camera_Vec3fVecSphGeoAdd(&sp98, sp34, &sp64);
    temp_s0->unk_2C += 0xBB8;
    temp_f16 = Math_Coss(temp_s0->unk_2C);
    temp_s3->x = F32_LERPIMP(temp_s3->x, sp98.x, fabsf(temp_f16));
    temp_s3->y = F32_LERPIMP(temp_s3->y, sp98.y, fabsf(temp_f16));
    temp_s3->z = F32_LERPIMP(temp_s3->z, sp98.z, fabsf(temp_f16));

    if ((temp_s0->unk_28 < temp_f16) && !temp_s0->unk_2E) {
        player = camera->player;
        temp_s0->unk_2E = true;
        func_800F4010(&player->actor.projectedPos, player->unk_89E + 0x8B0, 4.0f);
    } else if (temp_s0->unk_28 > temp_f16) {
        temp_s0->unk_2E = false;
    }

    temp_s0->unk_28 = temp_f16;
    camera->player->actor.posRot.pos = *sp34;
    camera->player->actor.posRot.pos.y = camera->playerGroundY;
    camera->player->actor.shape.rot.y = sp64.yaw;
    
    tx = temp_s0->unk_24 * (5.0f / 12.0f);
    tx2 = temp_f16 * 240.0f;
    temp_a0 = tx * tx2 + temp_s0->unk_30;
    temp_s2->x = temp_s3->x + (Math_Sins(temp_a0) * 10.0f);
    temp_s2->y = temp_s3->y;
    temp_s2->z = temp_s3->z + (Math_Coss(temp_a0) * 10.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    return 1;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Subj4.s")
#endif
#undef NON_MATCHING

s32 Camera_Subj0(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Data0(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Data1(Camera* camera) {
    osSyncPrintf("chau!chau!\n");
    return Camera_Normal1(camera);
}

s32 Camera_Data2(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Data3(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Data4(Camera *camera)
{
    s32 pad2[2];
    Data4* data4 = &camera->params.data4;
    VecSph eyeAtOffset;
    VecSph atOffset;
    VecSph eyeNextAtOffset;
    f32 t;
    s16 fov;
    Vec3f *eyeNext = &camera->eyeNext;
    CamPosData *sceneCamData;
    Vec3f lookAt;
    CameraModeValue *values;
    Data4InitParams *initParams = &data4->initParams;
    Vec3f *eye = &camera->eye;
    f32 yOffset;
    Vec3f *at = &camera->at;
    s32 pad;

    yOffset = Player_GetCameraYOffset(camera->player);

    if (RELOAD_PARAMS)
    {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        t = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        data4->yOffset = (NEXTPCT * yOffset) * t;
        data4->fov = NEXTSETTING;
        data4->interfaceFlags = NEXTSETTING;
        sceneCamData = func_8004476C(camera);
        Camera_Vec3sToVec3f(&initParams->eyePosRot.pos, &sceneCamData->pos);
        initParams->eyePosRot.rot = sceneCamData->rot;
        fov = sceneCamData->fov;
        initParams->fov = fov;
        if (fov != -1)
        {
            data4->fov = initParams->fov < 361 ? initParams->fov : PCT(initParams->fov);
        }

        initParams->jfifId = sceneCamData->jfifId;
        *eye = initParams->eyePosRot.pos;
    }

    if (R_RELOAD_CAM_PARAMS)
    {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = data4->interfaceFlags;

    if (camera->animState == 0)
    {
        camera->animState++;
        func_80043B60(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);
    func_800457A8(camera, &eyeNextAtOffset, data4->yOffset, false);
    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, eye, at);
    
    atOffset.r = eyeAtOffset.r;
    atOffset.yaw = (initParams->jfifId & 1) ? (DEGF_TO_BINANG(camera->unk_12C) + initParams->eyePosRot.rot.y) : eyeAtOffset.yaw;
    atOffset.pitch = (initParams->jfifId & 2) ? (DEGF_TO_BINANG(camera->unk_12E) + initParams->eyePosRot.rot.x) : eyeAtOffset.pitch;
    
    Camera_Vec3fVecSphGeoAdd(at, eye, &atOffset);
    
    lookAt = camera->playerPosRot.pos;
    lookAt.y += yOffset;
    
    camera->dist = OLib_Vec3fDist(&lookAt, eye);
    camera->roll = 0;
    camera->xzSpeed = 0.0f;
    camera->fov = data4->fov;
    camera->atLERPStepScale = 0;
    return true;
}

/**
 * Hanging off of a ledge
*/
s32 Camera_Unique1(Camera *camera) {
    Unique1* uniq1 = &camera->params.uniq1;
    CameraModeValue* values;
    s32 pad;
    Vec3f playerUnk908;
    s32 pad2;
    VecSph sp8C;
    VecSph unk908PlayerPosOffset;
    VecSph eyeAtOffset;
    VecSph eyeNextAtOffset;
    f32 yOffset;
    PosRot playerPosRot2;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    f32 pad3;
    f32 yOffsetInverse;
    Unique1Anim* anim = &uniq1->anim;
    s16 phiTarget;

    yOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + (R_CAM_YOFFSET_NORM * 0.01f)) - ((R_CAM_YOFFSET_NORM * 0.01f) * (68.0f / yOffset));
        uniq1->yOffset = NEXTPCT * yOffset * yOffsetInverse;
        uniq1->distClampMin = NEXTPCT * yOffset * yOffsetInverse;
        uniq1->distClampMax = NEXTPCT * yOffset * yOffsetInverse;
        uniq1->pitchTarget = DEGF_TO_BINANG(NEXTSETTING);
        uniq1->fovTarget = NEXTSETTING;
        uniq1->atLERPScaleMax = NEXTPCT;
        uniq1->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS != 0) {
        Camera_CopyPREGToModeValues(camera);
    }

    sUpdateCameraDirection = 1;
    
    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);

    sCameraInterfaceFlags = uniq1->interfaceFlags;

    if (camera->animState == 0) {
        camera->posOffset.y = camera->posOffset.y - camera->playerPosDelta.y;
        anim->yawTarget = eyeNextAtOffset.yaw;
        anim->unk_00 = 0.0f;
        playerUnk908 = camera->player->unk_908;
        OLib_Vec3fDiffToVecSphGeo(&unk908PlayerPosOffset, &camera->playerPosRot.pos, &playerUnk908);
        anim->timer = R_DEFA_CAM_ANIM_TIME;
        anim->yawTargetAdj = ABS(BINANG_SUB(unk908PlayerPosOffset.yaw, eyeAtOffset.yaw)) < 0x3A98 ? 0 :
            ((BINANG_SUB(unk908PlayerPosOffset.yaw, eyeAtOffset.yaw) / anim->timer) / 4) * 3;
        camera->animState++;
    }

    func_8002EEE4(&playerPosRot2, &camera->player->actor); // unused

    camera->yawUpdateRateInv = Camera_LERPCeilF(100.0f, camera->yawUpdateRateInv, OREG(25) * 0.01f, 0.1f);
    camera->pitchUpdateRateInv = Camera_LERPCeilF(100.0f, camera->pitchUpdateRateInv, OREG(25) * 0.01f, 0.1f);
    camera->xzOffsetUpdateRate = Camera_LERPCeilF(0.005f, camera->xzOffsetUpdateRate, OREG(25) * 0.01f, 0.01f);
    camera->yOffsetUpdateRate = Camera_LERPCeilF(0.01f, camera->yOffsetUpdateRate, OREG(26) * 0.01f, 0.01f);
    camera->fovUpdateRate = Camera_LERPCeilF(OREG(4) * 0.01f, camera->fovUpdateRate, 0.05f, 0.1f);

    func_800457A8(camera, &eyeNextAtOffset, uniq1->yOffset, 1);
    OLib_Vec3fDiffToVecSphGeo(&sp8C, at, eyeNext);

    camera->dist = Camera_LERPClampDist(camera, sp8C.r, uniq1->distClampMin, uniq1->distClampMax);

    // temp is necessary to match.
    phiTarget = uniq1->pitchTarget;
    sp8C.pitch = Camera_LERPCeilS(phiTarget, eyeNextAtOffset.pitch, 1.0f / camera->pitchUpdateRateInv, 0xA);
    
    if (sp8C.pitch > OREG(5)) {
        sp8C.pitch = OREG(5);
    }
    if (sp8C.pitch < -OREG(5)) {
        sp8C.pitch = -OREG(5);
    }

    if (anim->timer != 0) {
        anim->yawTarget += anim->yawTargetAdj;
        anim->timer--;
    }

    sp8C.yaw = Camera_LERPFloorS(anim->yawTarget, eyeNextAtOffset.yaw, 0.5f, 0x2710);
    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &sp8C);
    *eye = *eyeNext;
    func_80043F34(camera, at, eye);
    camera->fov = Camera_LERPCeilF(uniq1->fovTarget, camera->fov, camera->fovUpdateRate, 1.0f);
    camera->roll = 0;
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, uniq1->atLERPScaleMax);
    return true;
}

s32 Camera_Unique2(Camera *camera) {
    Unique2* uniq2 = &camera->params.uniq2;
    s32 pad;
    f32 lerpRateFactor;
    Vec3f playerPos;
    VecSph eyeOffset;
    VecSph eyeAtOffset;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Unique2_Unk10* unk10 = &uniq2->unk_10;
    CameraModeValue* values;
    f32 yOffset;
    s32 pad2;
    f32 yOffsetInverse;
    
    yOffset = Player_GetCameraYOffset(camera->player);
    
    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = ((1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset)));
        uniq2->yOffset = (NEXTPCT * yOffset) * yOffsetInverse;
        uniq2->distTarget = NEXTSETTING;
        uniq2->fovTarget = NEXTSETTING;
        uniq2->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    
    sCameraInterfaceFlags = uniq2->interfaceFlags;

    if ((camera->animState == 0) || (unk10->unk_04 != uniq2->interfaceFlags)) {
        unk10->unk_04 = uniq2->interfaceFlags;
    }

    if (camera->animState == 0) {
        camera->animState = 1;
        func_80043B60(camera);
        unk10->unk_00 = 200.0f;
        if (uniq2->interfaceFlags & 0x10) {
            camera->unk_14C &= ~4;
        }
    }

    playerPos = camera->playerPosRot.pos;
    lerpRateFactor = (uniq2->interfaceFlags & 1 ? 1.0f : camera->speedRatio);
    at->x = F32_LERPIMP(at->x, playerPos.x, lerpRateFactor * 0.6f);
    at->y = F32_LERPIMP(at->y, playerPos.y + yOffset + uniq2->yOffset, 0.4f);
    at->z = F32_LERPIMP(at->z, playerPos.z, lerpRateFactor * 0.6f);
    unk10->unk_00 = F32_LERPIMP(unk10->unk_00, 2.0f, 0.05f); // unused.

    if (uniq2->interfaceFlags & 1) {
        OLib_Vec3fDiffToVecSphGeo(&eyeOffset, at, eyeNext);
        eyeOffset.r = uniq2->distTarget;
        Camera_Vec3fVecSphGeoAdd(&playerPos, at, &eyeOffset);
        Camera_LERPCeilVec3f(&playerPos, eye, 0.25f, 0.25f, 0.2f);
    } else if (uniq2->interfaceFlags & 2) {
        if (OLib_Vec3fDistXZ(at, eyeNext) < uniq2->distTarget) {
            OLib_Vec3fDiffToVecSphGeo(&eyeOffset, at, eyeNext);
            eyeOffset.yaw = Camera_LERPCeilS(eyeOffset.yaw, eyeAtOffset.yaw, 0.1f, 0xA);
            eyeOffset.r = uniq2->distTarget;
            eyeOffset.pitch = 0;
            Camera_Vec3fVecSphGeoAdd(eye, at, &eyeOffset);
            eye->y = eyeNext->y;
        } else {
            Camera_LERPCeilVec3f(eyeNext, eye, 0.25f, 0.25f, 0.2f);
        }
    }

    func_80043F34(camera, at, eye);
    camera->dist = OLib_Vec3fDist(at, eye);
    camera->roll = 0;
    camera->fov = Camera_LERPCeilF(uniq2->fovTarget, camera->fov, 0.2f, 0.1f);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, 1.0f);
    return true;
}

s32 Camera_Unique3(Camera *camera) {
    VecSph sp60;
    f32 yOffset;
    Unique3* uniq3 = &camera->params.uniq3;
    CamPosData *temp_v0_2;
    Vec3s sp4C;
    Unique3_Unk18* unk18 = &uniq3->unk_18;
    Unique3_UnkC* unkC = &uniq3->unk_0C;
    Vec3f* at = &camera->at;
    CameraModeValue *values;
    PosRot* cameraPlayerPosRot = &camera->playerPosRot;
    f32 yOffsetInverse;

    yOffset = Player_GetCameraYOffset(camera->player);
    camera->unk_14C &= ~0x10;
    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        unkC->unk_00 = (NEXTPCT * yOffset) * yOffsetInverse;
        unkC->unk_04 = NEXTSETTING;
        unkC->interfaceFlags = NEXTSETTING;
    }
    if (R_RELOAD_CAM_PARAMS != 0) {
        Camera_CopyPREGToModeValues(camera);
    }
    sCameraInterfaceFlags = unkC->interfaceFlags;
    switch(camera->animState){
        case 0:
            func_80043B60(camera);
            camera->unk_14C &= ~(0x8 | 0x4);
            unk18->unk_00 = camera->fov;
            unk18->unk_04 = OLib_Vec3fDist(at, &camera->eye);
            camera->animState++;
        case 1:
            if(uniq3->unk_06-- > 0){
                break;
            }
            temp_v0_2 = func_8004476C(camera);
            Camera_Vec3sToVec3f(&camera->eyeNext, &temp_v0_2->pos);
            camera->eye = camera->eyeNext;
            sp4C = temp_v0_2->rot;
            sp60.r = 100.0f;
            sp60.yaw = sp4C.y;
            sp60.pitch = -sp4C.x;
            Camera_Vec3fVecSphGeoAdd(at, &camera->eye, &sp60);
            camera->animState++;
            
        case 2:
            if ((unkC->interfaceFlags & 4) != 0) {
                camera->at = cameraPlayerPosRot->pos;
                camera->at.y += yOffset + unkC->unk_00;
            }
            if(uniq3->unk_08-- > 0){
                break;
            }
            camera->animState++;
            
        case 3:
            camera->unk_14C |= (0x400 | 0x10);
            if ((camera->unk_14C & 8) != 0) {
                camera->animState++;
            } else {
                break;
            }
        case 4:
            if ((unkC->interfaceFlags & 2) != 0) {
                camera->unk_14C |= 4;
                camera->unk_14C &= ~8;
                Camera_ChangeSettingFlags(camera, CAM_SET_CIRCLE3, 2);
                break;
            }
            uniq3->unk_0A = 5;
            if(camera->xzSpeed > 0.001f || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) ||
                CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) ||
                CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) ||
                CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || 
                CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG)){
                camera->animState++;
            } else {
                break;
            }
        case 5:
            camera->fov = Camera_LERPCeilF(uniq3->unk_18.unk_00, camera->fov, 0.4f, 0.1f);
            OLib_Vec3fDiffToVecSphGeo(&sp60, at, &camera->eye);
            sp60.r = Camera_LERPCeilF(100.0f, sp60.r, 0.4f, 0.1f);
            Camera_Vec3fVecSphGeoAdd(&camera->eyeNext, at, &sp60);
            camera->eye = camera->eyeNext;
            if(uniq3->unk_0A-- > 0){
                break;
            }
            camera->animState++;
        default:
            camera->unk_14C |= 4;
            camera->unk_14C &= ~8;
            camera->fov = unkC->unk_04;
            Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
            camera->atLERPStepScale = 0.0f;
            camera->posOffset.x = camera->at.x - cameraPlayerPosRot->pos.x;
            camera->posOffset.y = camera->at.y - cameraPlayerPosRot->pos.y;
            camera->posOffset.z = camera->at.z - cameraPlayerPosRot->pos.z;
            break;
    }
            
    return true;
}

/**
 * Camera's eye is specified by scene camera data, at point is genered at the intersection
 * of the eye to the player
 */
s32 Camera_Unique0(Camera *camera) {
    f32 yOffset;
    CameraModeValue* values;
    Player *player;
    Vec3f playerPosWithOffset;
    VecSph atPlayerOffset;
    CamPosData *sceneCamData;
    Vec3s sceneCamRot;
    PosRot *playerPosRot = &camera->playerPosRot;
    PersonalizedUnique0* persUniq0 = &camera->params.uniq0;
    Unique0 *uniq0 = &persUniq0->uniq0;
    Unique0Anim* anim = &uniq0->anim;
    Vec3f *eye = &camera->eye;
    s16 fov;

    yOffset = Player_GetCameraYOffset(camera->player);
    player = camera->player;
    
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        uniq0->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    
    playerPosWithOffset = playerPosRot->pos;
    playerPosWithOffset.y += yOffset;

    sCameraInterfaceFlags = uniq0->interfaceFlags;

    if (camera->animState == 0) {
        func_80043B60(camera);
        camera->unk_14C &= ~4;
        sceneCamData = func_8004476C(camera);
        Camera_Vec3sToVec3f(&anim->sceneCamPosPlayerLine.a, &sceneCamData->pos);

        *eye = camera->eyeNext = anim->sceneCamPosPlayerLine.a;
        sceneCamRot = sceneCamData->rot;
        fov = sceneCamData->fov;
        if (fov != -1) {
            camera->fov = fov < 361 ? fov : PCT(fov);
        }
        anim->animTimer = sceneCamData->jfifId;
        if (anim->animTimer == -1) {
            anim->animTimer = persUniq0->personalizeParams.timer1 + persUniq0->personalizeParams.timer2;
        }
        atPlayerOffset.r = OLib_Vec3fDist(&playerPosWithOffset, eye);
        atPlayerOffset.yaw = sceneCamRot.y;
        atPlayerOffset.pitch = -sceneCamRot.x;
        OLib_VecSphGeoToVec3f(&anim->sceneCamPosPlayerLine.b, &atPlayerOffset);
        Math3D_LineClosestToPoint(&anim->sceneCamPosPlayerLine, &playerPosRot->pos, &camera->at);
        anim->initalPos = playerPosRot->pos;
        camera->animState++;
    }

    if (player->stateFlags1 & 0x20000000) {
        anim->initalPos = playerPosRot->pos;
    }

    if (uniq0->interfaceFlags & 1) {
        if (anim->animTimer > 0) {
            anim->animTimer--;
            anim->initalPos = playerPosRot->pos;
        } else if ((!(player->stateFlags1 & 0x20000000)) && ((OLib_Vec3fDistXZ(&playerPosRot->pos, &anim->initalPos) >= 10.0f) || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG))){
            camera->dist = OLib_Vec3fDist(&camera->at, eye);
            camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
            camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
            camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
            camera->atLERPStepScale = 0.0f;
            camera->unk_14C |= 4;
            Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
        }
    } else {
        if (anim->animTimer > 0) {
            anim->animTimer--;
            if (anim->animTimer == 0) {
                sCameraInterfaceFlags = 0;
            }
        } else {
            anim->initalPos = playerPosRot->pos;
        }

        if ((!(player->stateFlags1 & 0x20000000)) && ((0.001f < camera->xzSpeed) || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG))){
            camera->dist = OLib_Vec3fDist(&camera->at, &camera->eye);
            camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
            camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
            camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
            camera->atLERPStepScale = 0.0f;
            Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
            camera->unk_14C |= 4;
        }
    }
    return true;
}

s32 Camera_Unique4(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Unique5(Camera* camera) {
    return Camera_NOP(camera);
}

/**
 * This function doesn't really update much.  
 * Eye/at positions are updated via Camera_SetParam
*/
s32 Camera_Unique6(Camera* camera) {
    Unique6* uniq6 = &camera->params.uniq6;
    CameraModeValue* values;
    Vec3f sp2C;
    PosRot* playerPosRot = &camera->playerPosRot;
    f32 offset;

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        uniq6->interfaceFlags = NEXTSETTING;
    }
    
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = uniq6->interfaceFlags;

    if (camera->animState == 0) {
        camera->animState++;
        func_80043ABC(camera);
    }

    if (camera->player != NULL) {
        offset = Player_GetCameraYOffset(camera->player);
        sp2C = playerPosRot->pos;
        sp2C.y += offset;
        camera->dist = OLib_Vec3fDist(&sp2C, &camera->eye);
        camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
        camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
        camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
    } else {
        camera->dist = OLib_Vec3fDist(&camera->at, &camera->eye);
    }

    if (uniq6->interfaceFlags & 1 && camera->timer > 0) {
        camera->timer--;
    }

    return true;
}

/**
 * Camera is at a fixed point specified by the scene's camera data,
 * camera rotates to follow player
*/
s32 Camera_Unique7(Camera *camera) {
    s32 pad;
    Unique7* uniq7 = &camera->params.uniq7;
    CameraModeValue* values;
    VecSph playerPosEyeOffset;
    s16 fov;
    CamPosData *sceneCamData;
    Vec3s sceneCamRot;
    Vec3f *at = &camera->at;
    PosRot *playerPosRot = &camera->playerPosRot;
    Vec3f *eye = &camera->eye;
    Vec3f *eyeNext = &camera->eyeNext;
    Unique7_Unk8* unk08 = &uniq7->unk_08;

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        uniq7->fov = NEXTSETTING;
        uniq7->interfaceFlags = (s16) NEXTSETTING;
    }
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sceneCamData = func_8004476C(camera);
    CPY_SCENECAM(eyeNext, sceneCamRot);

    OLib_Vec3fDiffToVecSphGeo(&playerPosEyeOffset, eye, &playerPosRot->pos);

    // fov actually goes unused since it's hard set later on.
    fov = sceneCamData->fov;
    if (fov == -1) {
        fov = uniq7->fov * 100.0f;
    }

    if (fov < 361) {
        fov *= 100;
    }

    sCameraInterfaceFlags = uniq7->interfaceFlags;
    
    if (camera->animState == 0) {
        camera->animState++;
        camera->fov = PCT(fov);
        camera->atLERPStepScale = 0.0f;
        camera->roll = 0;
        unk08->unk_00.x = playerPosEyeOffset.yaw;
    }

    camera->fov = 60.0f;

    // 0x7D0 ~ 10.98 degres.
    unk08->unk_00.x = Camera_LERPFloorS(playerPosEyeOffset.yaw, unk08->unk_00.x, 0.4f, 0x7D0);
    playerPosEyeOffset.pitch = Math_Coss(playerPosEyeOffset.yaw - sceneCamData->rot.y) * -sceneCamData->rot.x;
    Camera_Vec3fVecSphGeoAdd(at, eye, &playerPosEyeOffset);
    camera->unk_14C |= 0x400;
    return true;
}

s32 Camera_Unique8(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Unique9(Camera *camera) {
    Vec3f atTarget;
    Vec3f eyeTarget;
    Unique9* uniq9 = &camera->params.uniq9.uniq9;
    Unique9Anim *anim = &camera->params.uniq9.uniq9.anim;
    f32 invKeyFrameTimer;
    VecSph eyeNextAtOffset;
    VecSph scratchSph; // reused for different purposes throughout
    VecSph playerTargetOffset;

    /* might be some kind of struct? */
    s16 pad;
    s16 atInitFlags;
    s16 eyeInitFlags;
    s16 pad2;

    PosRot targetPosRot2;
    PosRot playerPosRot2;
    PosRot playerPosRot;
    Vec3f *eyeNext = &camera->eyeNext;
    Vec3f *at = &camera->at;
    s16 action;
    Player *player;
    Actor *focusActor;
    f32 spB4;
    PosRot atFocusPosRot;
    Vec3f eyeLookAtPos;
    Vec3f *eye = &camera->eye;
    PosRot eyeFocusPosRot;
    CameraModeValue* values;

    player = camera->player;

    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        uniq9->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    
    sCameraInterfaceFlags = uniq9->interfaceFlags;

    func_8002EF14(&playerPosRot, &camera->player->actor);
    
    if (camera->animState == 0) {
        camera->animState++;
        anim->curKeyFrameIdx = -1;
        anim->keyFrameTimer = 1;
        anim->unk_38 = 0;
        anim->playerPos.x = playerPosRot.pos.x;
        anim->playerPos.y = playerPosRot.pos.y;
        anim->playerPos.z = playerPosRot.pos.z;
        camera->atLERPStepScale = 0.0f;
        func_80043B60(camera);
    }

    if (anim->unk_38 == 0 && anim->keyFrameTimer > 0) {
        anim->keyFrameTimer--;
    }
    
    if (anim->keyFrameTimer == 0) {
        anim->isNewKeyFrame = true;
        anim->curKeyFrameIdx++;
        if (anim->curKeyFrameIdx < camera->params.uniq9.keyFrameCnt) {
            anim->curKeyFrame = &camera->params.uniq9.keyFrames[anim->curKeyFrameIdx];
            anim->keyFrameTimer = anim->curKeyFrame->timerInit;
            
            if (anim->curKeyFrame->unk_01 != 0xFF) {
                if ((anim->curKeyFrame->unk_01 & 0xF0) == 0x80) {
                    D_8011D3AC = anim->curKeyFrame->unk_01 & 0xF;
                } else if ((anim->curKeyFrame->unk_01 & 0xF0) == 0xC0) {
                    Camera_UpdateInterface(0xF000 | ((anim->curKeyFrame->unk_01 & 0xF) << 8));
                } else if (camera->player->stateFlags1 & 0x8000000 && player->currentBoots != 1) {
                    func_8002DF38(camera->globalCtx, camera->target, 8);
                    osSyncPrintf("camera: demo: player demo set WAIT\n");
                } else {
                    osSyncPrintf("camera: demo: player demo set %d\n", anim->curKeyFrame->unk_01);
                    func_8002DF38(camera->globalCtx, camera->target, anim->curKeyFrame->unk_01);
                }
            }
        } else {
            // We've gone through all the keyframes.
            if (camera->thisIdx != 0) {
                camera->timer = 0;
            }
            return true;
        }
    } else {
        anim->isNewKeyFrame = false;
    }

    atInitFlags = anim->curKeyFrame->initFlags & 0xFF;
    if(atInitFlags == 1){
        anim->atTarget = anim->curKeyFrame->atTargetInit;
    } else if(atInitFlags == 2){
        if (anim->isNewKeyFrame) {
            anim->atTarget.x = camera->globalCtx->view.lookAt.x + anim->curKeyFrame->atTargetInit.x;
            anim->atTarget.y = camera->globalCtx->view.lookAt.y + anim->curKeyFrame->atTargetInit.y;
            anim->atTarget.z = camera->globalCtx->view.lookAt.z + anim->curKeyFrame->atTargetInit.z;
        }
    } else if(atInitFlags == 3){
        if (anim->isNewKeyFrame) {
            anim->atTarget.x = camera->at.x + anim->curKeyFrame->atTargetInit.x;
            anim->atTarget.y = camera->at.y + anim->curKeyFrame->atTargetInit.y;
            anim->atTarget.z = camera->at.z + anim->curKeyFrame->atTargetInit.z;
        }
    } else if(atInitFlags == 4 || atInitFlags == 0x84){
        if (camera->target != NULL && camera->target->update != NULL) {
            func_8002EEE4(&targetPosRot2, camera->target);
            func_8002EEE4(&playerPosRot2, &camera->player->actor);
            playerPosRot2.pos.x = playerPosRot.pos.x;
            playerPosRot2.pos.z = playerPosRot.pos.z;
            OLib_Vec3fDiffToVecSphGeo(&playerTargetOffset, &targetPosRot2.pos, &playerPosRot2.pos);
            if (atInitFlags & (s16)0x8080) {
                scratchSph.pitch = DEGF_TO_BINANG(anim->curKeyFrame->atTargetInit.x);
                scratchSph.yaw = DEGF_TO_BINANG(anim->curKeyFrame->atTargetInit.y);
                scratchSph.r = anim->curKeyFrame->atTargetInit.z;
            } else {
                OLib_Vec3fToVecSphGeo(&scratchSph, &anim->curKeyFrame->atTargetInit);
            }
            scratchSph.yaw += playerTargetOffset.yaw;
            scratchSph.pitch += playerTargetOffset.pitch;
            Camera_Vec3fVecSphGeoAdd(&anim->atTarget, &targetPosRot2.pos, &scratchSph);
        } else {
            if (camera->target == NULL) {
                osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: demo C: actor is not valid\n" VT_RST);
            }
            
            camera->target = NULL;
            anim->atTarget = camera->at;
        }
    } else if (atInitFlags & 0x6060) {
        if (!(atInitFlags & 4) || anim->isNewKeyFrame) {
            if (atInitFlags & 0x2020) {
                focusActor = &camera->player->actor;
            } else if (camera->target != NULL && camera->target->update != NULL) {
                focusActor = camera->target;
            } else {
                camera->target = NULL;
                focusActor = NULL;
            }

            if (focusActor != NULL) {
                if ((atInitFlags & 0xF) == 1) {
                    // posRot2
                    func_8002EEE4(&atFocusPosRot, focusActor);
                } else if ((atInitFlags & 0xF) == 2) {
                    // posRot
                    func_8002EF14(&atFocusPosRot, focusActor);
                } else {
                    // posRot, shape rot
                    func_8002EF44(&atFocusPosRot, focusActor);
                }
                
                if (atInitFlags & (s16)0x8080) {
                    scratchSph.pitch = DEGF_TO_BINANG(anim->curKeyFrame->atTargetInit.x);
                    scratchSph.yaw = DEGF_TO_BINANG(anim->curKeyFrame->atTargetInit.y);
                    scratchSph.r = anim->curKeyFrame->atTargetInit.z;
                } else {
                    OLib_Vec3fToVecSphGeo(&scratchSph, &anim->curKeyFrame->atTargetInit);
                }

                scratchSph.yaw += atFocusPosRot.rot.y;
                scratchSph.pitch -= atFocusPosRot.rot.x;
                Camera_Vec3fVecSphGeoAdd(&anim->atTarget, &atFocusPosRot.pos, &scratchSph);
            } else {
                if (camera->target == NULL) {
                    osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: demo C: actor is not valid\n" VT_RST);
                }
                anim->atTarget = *at;
            }
        }
    } else {
        anim->atTarget = *at;
    }

    eyeInitFlags = anim->curKeyFrame->initFlags & 0xFF00;
    if (eyeInitFlags == 0x100) {
        anim->eyeTarget = anim->curKeyFrame->eyeTargetInit;
    } else if (eyeInitFlags == 0x200) {
        if (anim->isNewKeyFrame) {
            anim->eyeTarget.x = camera->globalCtx->view.eye.x + anim->curKeyFrame->eyeTargetInit.x;
            anim->eyeTarget.y = camera->globalCtx->view.eye.y + anim->curKeyFrame->eyeTargetInit.y;
            anim->eyeTarget.z = camera->globalCtx->view.eye.z + anim->curKeyFrame->eyeTargetInit.z;
        }
    } else if (eyeInitFlags == 0x300) {
        if (anim->isNewKeyFrame) {
            anim->eyeTarget.x = camera->eyeNext.x + anim->curKeyFrame->eyeTargetInit.x;
            anim->eyeTarget.y = camera->eyeNext.y + anim->curKeyFrame->eyeTargetInit.y;
            anim->eyeTarget.z = camera->eyeNext.z + anim->curKeyFrame->eyeTargetInit.z;
        }
    } else {
        if(eyeInitFlags == 0x400 || eyeInitFlags == (s16)0x8400 || eyeInitFlags == 0x500 || eyeInitFlags == (s16)0x8500){
            if (camera->target != NULL && camera->target->update != NULL) {
                func_8002EEE4(&targetPosRot2, camera->target);
                func_8002EEE4(&playerPosRot2, &camera->player->actor);
                playerPosRot2.pos.x = playerPosRot.pos.x;
                playerPosRot2.pos.z = playerPosRot.pos.z;
                OLib_Vec3fDiffToVecSphGeo(&playerTargetOffset, &targetPosRot2.pos, &playerPosRot2.pos);
                if (eyeInitFlags == 0x400 || eyeInitFlags == (s16)0x8400) {
                    eyeLookAtPos = targetPosRot2.pos;
                } else {
                    eyeLookAtPos = anim->atTarget;
                }

                if (eyeInitFlags & (s16)0x8080) {
                    scratchSph.pitch = DEGF_TO_BINANG(anim->curKeyFrame->eyeTargetInit.x);
                    scratchSph.yaw = DEGF_TO_BINANG(anim->curKeyFrame->eyeTargetInit.y);
                    scratchSph.r = anim->curKeyFrame->eyeTargetInit.z;
                } else {
                    OLib_Vec3fToVecSphGeo(&scratchSph, &anim->curKeyFrame->eyeTargetInit);
                }

                scratchSph.yaw += playerTargetOffset.yaw;
                scratchSph.pitch += playerTargetOffset.pitch;
                Camera_Vec3fVecSphGeoAdd(&anim->eyeTarget, &eyeLookAtPos, &scratchSph);
            } else {
                if (camera->target == NULL) {
                    osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: demo C: actor is not valid\n" VT_RST);
                }
                camera->target = NULL;
                anim->eyeTarget = *eyeNext;
            }
        } else {
            if (eyeInitFlags & 0x6060) {
                if(!(eyeInitFlags & 0x400) || anim->isNewKeyFrame){
                    if (eyeInitFlags & 0x2020) {
                        focusActor = &camera->player->actor;
                    } else if (camera->target != NULL && camera->target->update != NULL) {
                        focusActor = camera->target;
                    } else {
                        camera->target = NULL;
                        focusActor = NULL;
                    }

                    if (focusActor != NULL) {
                        if ((eyeInitFlags & 0xF00) == 0x100){
                            // posRot2
                            func_8002EEE4(&eyeFocusPosRot, focusActor);
                        } else  if ((eyeInitFlags & 0xF00) == 0x200) {
                            // posRot
                            func_8002EF14(&eyeFocusPosRot, focusActor);
                        } else {
                            // posRot, shapeRot
                            func_8002EF44(&eyeFocusPosRot, focusActor);
                        }

                        if (eyeInitFlags & (s16)0x8080) {
                            scratchSph.pitch = DEGF_TO_BINANG(anim->curKeyFrame->eyeTargetInit.x);
                            scratchSph.yaw = DEGF_TO_BINANG(anim->curKeyFrame->eyeTargetInit.y);
                            scratchSph.r = anim->curKeyFrame->eyeTargetInit.z;
                        } else {
                            OLib_Vec3fToVecSphGeo(&scratchSph, &anim->curKeyFrame->eyeTargetInit);
                        }

                        scratchSph.yaw += eyeFocusPosRot.rot.y;
                        scratchSph.pitch -= eyeFocusPosRot.rot.x;
                        Camera_Vec3fVecSphGeoAdd(&anim->eyeTarget, &eyeFocusPosRot.pos, &scratchSph);
                    } else {
                        if (camera->target == NULL) {
                            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: demo C: actor is not valid\n" VT_RST);
                        }
                        camera->target = NULL;
                        anim->eyeTarget = *eyeNext;
                    }
                }
            } else {
                anim->eyeTarget = *eyeNext;
            }
        }
    }

    if (anim->curKeyFrame->initFlags == 2) {
        anim->fovTarget = camera->globalCtx->view.fovy;
        anim->rollTarget = 0;
    } else if (anim->curKeyFrame->initFlags == 0) {
        anim->fovTarget = camera->fov;
        anim->rollTarget = camera->roll;
    } else {
        anim->fovTarget = anim->curKeyFrame->fovTargetInit;
        anim->rollTarget = DEGF_TO_BINANG(anim->curKeyFrame->rollTargetInit);
    }

    action = anim->curKeyFrame->actionFlags & 0x1F;
    switch(action){
        case 15:
            // static copy to at/eye/fov/roll
            *at = anim->atTarget;
            *eyeNext = anim->eyeTarget;
            camera->fov = anim->fovTarget;
            camera->roll = anim->rollTarget;
            camera->unk_14C |= 0x400;
            break;
        case 21:
            // same as 15, but with unk_38 ? 
            if (anim->unk_38 == 0) {
                anim->unk_38 = 1;
            } else if (camera->unk_14C & 8) {
                anim->unk_38 = 0;
                camera->unk_14C &= ~8;
            }
            *at = anim->atTarget;
            *eyeNext = anim->eyeTarget;
            camera->fov = anim->fovTarget;
            camera->roll = anim->rollTarget;
            break;
        case 16:
            // same as 16, but don't unset bit 0x8 on unk_14C
            if (anim->unk_38 == 0) {
                anim->unk_38 = 1;
            } else if (camera->unk_14C & 8) {
                anim->unk_38 = 0;
            }

            *at = anim->atTarget;
            *eyeNext = anim->eyeTarget;
            camera->fov = anim->fovTarget;
            camera->roll = anim->rollTarget;
            break;
        case 1:
            // linear interpolation of eye/at using the spherical coordinates
            OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);
            OLib_Vec3fDiffToVecSphGeo(&anim->atEyeOffsetTarget, &anim->atTarget, &anim->eyeTarget);
            invKeyFrameTimer = 1.0f / anim->keyFrameTimer;
            scratchSph.r = F32_LERPIMP(eyeNextAtOffset.r, anim->atEyeOffsetTarget.r, invKeyFrameTimer);
            scratchSph.pitch = eyeNextAtOffset.pitch + (BINANG_SUB(anim->atEyeOffsetTarget.pitch, eyeNextAtOffset.pitch) * invKeyFrameTimer);
            scratchSph.yaw = eyeNextAtOffset.yaw + (BINANG_SUB(anim->atEyeOffsetTarget.yaw, eyeNextAtOffset.yaw) * invKeyFrameTimer);
            Camera_Vec3fVecSphGeoAdd(&eyeTarget, at, &scratchSph);
            goto setEyeNext;
        case 2:
            // linear interpolation of eye/at using the eyeTarget 
            invKeyFrameTimer = 1.0f / anim->keyFrameTimer;
            eyeTarget.x = F32_LERPIMP(camera->eyeNext.x, anim->eyeTarget.x, invKeyFrameTimer);
            eyeTarget.y = F32_LERPIMP(camera->eyeNext.y, anim->eyeTarget.y, invKeyFrameTimer);
            eyeTarget.z = F32_LERPIMP(camera->eyeNext.z, anim->eyeTarget.z, invKeyFrameTimer);

setEyeNext:
            camera->eyeNext.x = Camera_LERPFloorF(eyeTarget.x, camera->eyeNext.x, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->eyeNext.y = Camera_LERPFloorF(eyeTarget.y, camera->eyeNext.y, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->eyeNext.z = Camera_LERPFloorF(eyeTarget.z, camera->eyeNext.z, anim->curKeyFrame->lerpStepScale, 1.0f);
        case 9:
        case 10:
            // linear interpolation of at/fov/roll
            invKeyFrameTimer = 1.0f / anim->keyFrameTimer;
            atTarget.x = F32_LERPIMP(camera->at.x, anim->atTarget.x, invKeyFrameTimer);
            atTarget.y = F32_LERPIMP(camera->at.y, anim->atTarget.y, invKeyFrameTimer);
            atTarget.z = F32_LERPIMP(camera->at.z, anim->atTarget.z, invKeyFrameTimer);
            camera->at.x = Camera_LERPFloorF(atTarget.x, camera->at.x, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->at.y = Camera_LERPFloorF(atTarget.y, camera->at.y, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->at.z = Camera_LERPFloorF(atTarget.z, camera->at.z, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->fov = Camera_LERPFloorF(F32_LERPIMP(camera->fov, anim->fovTarget, invKeyFrameTimer), camera->fov, anim->curKeyFrame->lerpStepScale, 0.01f);
            camera->roll = Camera_LERPFloorS(BINANG_LERPIMPINV(camera->roll, anim->rollTarget, anim->keyFrameTimer), camera->roll, anim->curKeyFrame->lerpStepScale, 0xA);
            break;
        case 4:
            // linear interpolation of eye/at/fov/roll using the step scale, and spherical coordinates
            OLib_Vec3fDiffToVecSphGeo(&eyeNextAtOffset, at, eyeNext);
            OLib_Vec3fDiffToVecSphGeo(&anim->atEyeOffsetTarget, &anim->atTarget, &anim->eyeTarget);
            scratchSph.r = Camera_LERPCeilF(anim->atEyeOffsetTarget.r, eyeNextAtOffset.r, anim->curKeyFrame->lerpStepScale, 0.1f);
            scratchSph.pitch = Camera_LERPCeilS(anim->atEyeOffsetTarget.pitch, eyeNextAtOffset.pitch, anim->curKeyFrame->lerpStepScale, 1);
            scratchSph.yaw = Camera_LERPCeilS(anim->atEyeOffsetTarget.yaw, eyeNextAtOffset.yaw, anim->curKeyFrame->lerpStepScale, 1);
            Camera_Vec3fVecSphGeoAdd(eyeNext, at, &scratchSph);
            goto setAtFOVRoll;
        case 3:
            // linear interplation of eye/at/fov/roll using the step scale using eyeTarget
            camera->eyeNext.x = Camera_LERPCeilF(anim->eyeTarget.x, camera->eyeNext.x, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->eyeNext.y = Camera_LERPCeilF(anim->eyeTarget.y, camera->eyeNext.y, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->eyeNext.z = Camera_LERPCeilF(anim->eyeTarget.z, camera->eyeNext.z, anim->curKeyFrame->lerpStepScale, 1.0f);
        case 11:
        case 12:
setAtFOVRoll:
            // linear interpolation of at/fov/roll using the step scale. 
            camera->at.x = Camera_LERPCeilF(anim->atTarget.x, camera->at.x, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->at.y = Camera_LERPCeilF(anim->atTarget.y, camera->at.y, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->at.z = Camera_LERPCeilF(anim->atTarget.z, camera->at.z, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->fov = Camera_LERPCeilF(anim->fovTarget, camera->fov, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->roll = Camera_LERPCeilS(anim->rollTarget, camera->roll, anim->curKeyFrame->lerpStepScale, 1);
            break;
        case 13:
            // linear interpolation of at, with rotation around eyeTargetInit.y
            camera->at.x = Camera_LERPCeilF(anim->atTarget.x, camera->at.x, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->at.y += camera->playerPosDelta.y * anim->curKeyFrame->lerpStepScale;
            camera->at.z = Camera_LERPCeilF(anim->atTarget.z, camera->at.z, anim->curKeyFrame->lerpStepScale, 1.0f);
            OLib_Vec3fDiffToVecSphGeo(&scratchSph, at, eyeNext);
            scratchSph.yaw += DEGF_TO_BINANG(anim->curKeyFrame->eyeTargetInit.y);

            // 3A98 ~ 82.40 degrees
            if (scratchSph.pitch >= 0x3A99) {
                scratchSph.pitch = 0x3A98;
            }

            if (scratchSph.pitch < -0x3A98) {
                scratchSph.pitch = -0x3A98;
            }

            spB4 = scratchSph.r;
            if(1){}
            scratchSph.r = !(spB4 < anim->curKeyFrame->eyeTargetInit.z) ? Camera_LERPCeilF(anim->curKeyFrame->eyeTargetInit.z, spB4, anim->curKeyFrame->lerpStepScale, 1.0f) : scratchSph.r;

            Camera_Vec3fVecSphGeoAdd(eyeNext, at, &scratchSph);
            camera->fov = Camera_LERPCeilF(F32_LERPIMPINV(camera->fov, anim->curKeyFrame->fovTargetInit, anim->keyFrameTimer), camera->fov, anim->curKeyFrame->lerpStepScale, 1.0f);
            camera->roll = Camera_LERPCeilS(anim->rollTarget, camera->roll, anim->curKeyFrame->lerpStepScale, 1);
            break;
        case 24:
            // Set current keyframe to the roll target? 
            anim->curKeyFrameIdx = anim->rollTarget;
            break;
        case 19:
            // Change the parent camera (or default)'s mode to normal 
            Camera_ChangeMode(camera->globalCtx->cameraPtrs[camera->parentCamIdx < 0 ? 0 : camera->parentCamIdx], CAM_MODE_NORMAL, 1);
        case 18:
            // copy the current camera to the parent (or default)'s camera.
            {
                Camera* cam = camera->globalCtx->cameraPtrs[camera->parentCamIdx < 0 ? 0 : camera->parentCamIdx];
                *eye = *eyeNext;
                Camera_Copy(cam, camera);
            }
        default:
            if (camera->thisIdx != 0) {
                camera->timer = 0;
            }
    }

    *eye = *eyeNext;

    if (anim->curKeyFrame->actionFlags & 0x80) {
        func_80043F34(camera, at, eye);
    }

    if (anim->curKeyFrame->actionFlags & 0x40) {
        // Set the player's position
        camera->player->actor.posRot.pos.x = anim->playerPos.x;
        camera->player->actor.posRot.pos.z = anim->playerPos.z;
        if (camera->player->stateFlags1 & 0x8000000 && player->currentBoots != 1) {
            camera->player->actor.posRot.pos.y = anim->playerPos.y;
        }
    } else {
        anim->playerPos.x = playerPosRot.pos.x;
        anim->playerPos.y = playerPosRot.pos.y;
        anim->playerPos.z = playerPosRot.pos.z;
    }

    if (anim->unk_38 == 0 && camera->timer > 0) {
        camera->timer--;
    }

    if (camera->player != NULL) {
        camera->posOffset.x = camera->at.x - camera->playerPosRot.pos.x;
        camera->posOffset.y = camera->at.y - camera->playerPosRot.pos.y;
        camera->posOffset.z = camera->at.z - camera->playerPosRot.pos.z;
    }

    camera->dist = OLib_Vec3fDist(at, eye);
    return true;
}

void Camera_DebugPrintSplineArray(char* name, s16 length, CutsceneCameraPoint cameraPoints[]) {
    s32 i;

    osSyncPrintf("static SplinedatZ  %s[] = {\n", name);
    for (i = 0; i < length; i++) {
        osSyncPrintf("    /* key frame %2d */ {\n", i);
        osSyncPrintf("    /*     code     */ %d,\n", cameraPoints[i].continueFlag);
        osSyncPrintf("    /*     z        */ %d,\n", cameraPoints[i].cameraRoll);
        osSyncPrintf("    /*     T        */ %d,\n", cameraPoints[i].nextPointFrame);
        osSyncPrintf("    /*     zoom     */ %f,\n", cameraPoints[i].viewAngle);
        osSyncPrintf("    /*     pos      */ { %d, %d, %d }\n", cameraPoints[i].pos.x, cameraPoints[i].pos.y,
                     cameraPoints[i].pos.z);
        osSyncPrintf("    },\n");
    }
    osSyncPrintf("};\n\n");
}

/**
 * Copies `src` to `dst`, used in Camera_Demo1
 * Name from AC map: Camera2_SetPos_Demo
*/
void Camera_Vec3fCopy(Vec3f* src, Vec3f* dst) {
    dst->x = src->x;
    dst->y = src->y;
    dst->z = src->z;
}

/**
 * Calculates new position from `at` to `pos`, outputs to `dst
 * Name from AC map: Camera2_CalcPos_Demo
*/
void Camera_RotateAroundPoint(PosRot* at, Vec3f* pos, Vec3f* dst) {
    VecSph posSph;
    Vec3f posCopy;

    Camera_Vec3fCopy(pos, &posCopy);
    OLib_Vec3fToVecSphGeo(&posSph, &posCopy);
    posSph.yaw += at->rot.y;
    Camera_Vec3fVecSphGeoAdd(dst, &at->pos, &posSph);
}

/**
 * Camera follows points specified at camera + 0x124 and camera + 0x128
 * until all keyFrames have been exhausted.
*/
s32 Camera_Demo1(Camera* camera) {
    s32 pad;
    Demo1* demo1 = &camera->params.demo1;
    CameraModeValue* values;
    Vec3f* at = &camera->at;
    CutsceneCameraPoint* csAtPoints = camera->atPoints;
    CutsceneCameraPoint* csEyePoints = camera->eyePoints;
    Vec3f* eye = &camera->eye;
    PosRot curPlayerPosRot;
    Vec3f csEyeUpdate;
    Vec3f csAtUpdate;
    f32 newRoll;
    Vec3f* eyeNext = &camera->eyeNext;
    f32* cameraFOV = &camera->fov;
    s16* relativeToPlayer = &camera->unk_12C;
    Demo1Anim* anim = &demo1->anim;

    
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        demo1->interfaceFlags = NEXTSETTING;
    }

    sCameraInterfaceFlags = demo1->interfaceFlags;

    switch (camera->animState) {
        case 0:
            // initalize camera state
            anim->keyframe = 0;
            anim->curFrame = 0.0f;
            camera->animState++;
            // absolute / relative
            osSyncPrintf(VT_SGR("1") "%06u:" VT_RST " camera: spline demo: start %s \n",
                camera->globalCtx->state.frames, 
                *relativeToPlayer == 0 ? "絶対" : "相対");

            if (PREG(93)) {
                Camera_DebugPrintSplineArray("CENTER", 5, csAtPoints);
                Camera_DebugPrintSplineArray("   EYE", 5, csEyePoints);
            }
        case 1:
            // follow CutsceneCameraPoints.  function returns 1 if at the end.
            if (func_800BB2B4(&csEyeUpdate, &newRoll, cameraFOV, csEyePoints, &anim->keyframe, &anim->curFrame) ||
                func_800BB2B4(&csAtUpdate, &newRoll, cameraFOV, csAtPoints, &anim->keyframe, &anim->curFrame)) {
                camera->animState++;
            }
            if (*relativeToPlayer) {
                // if the camera is set to be relative to the player, move the interpolated points
                // relative to the player's position
                if (camera->player != NULL && camera->player->actor.update != NULL) {
                    func_8002EF14(&curPlayerPosRot, &camera->player->actor);
                    Camera_RotateAroundPoint(&curPlayerPosRot, &csEyeUpdate, eyeNext);
                    Camera_RotateAroundPoint(&curPlayerPosRot, &csAtUpdate, at);
                } else {
                    osSyncPrintf(VT_COL(RED, WHITE) "camera: spline demo: owner dead\n" VT_RST);
                }
            } else {
                // simply copy the interpolated values to the eye and at
                Camera_Vec3fCopy(&csEyeUpdate, eyeNext);
                Camera_Vec3fCopy(&csAtUpdate, at);
            }
            *eye = *eyeNext;
            camera->roll = newRoll * 256.0f;
            camera->dist = OLib_Vec3fDist(at, eye);
            break;
    }
    return true;
}

s32 Camera_Demo2(Camera* camera) {
    return Camera_NOP(camera);
}

#ifdef NON_MATCHING
/**
 * Opening large chests. 
 * The camera position will be at a fixed point, and rotate around at different intervals.
 * The direction, and initial position is dependent on when the camera was started.
*/
s32 Camera_Demo3(Camera *camera) {
    s32 pad;
    Demo3* demo3 = &camera->params.demo3;
    CameraModeValue* values;
    Demo3Anim* anim = &demo3->anim;
    VecSph eyeAtOffset;
    VecSph eyeOffset;
    VecSph atOffset;
    Vec3f sp74;
    Vec3f sp68;
    Vec3f sp5C;
    f32 temp_f0;
    s32 pad2;
    u8 skipUpdateEye = false;
    f32 yOffset = Player_GetCameraYOffset(camera->player);
    s16 angle;
    Vec3f* eye = &camera->eye;
    Vec3f* at = &camera->at;
    PosRot *camPlayerPosRot = &camera->playerPosRot;

    camera->unk_14C &= ~0x10;

    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        demo3->fov = NEXTSETTING;
        demo3->unk_04 = NEXTSETTING; // unused.
        demo3->interfaceFlags = NEXTSETTING;
    }
    
    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, at, eye);

    sCameraInterfaceFlags = demo3->interfaceFlags;
    
    switch(camera->animState){
        case 0:
            camera->unk_14C &= ~(0x8 | 0x4);
            func_80043B60(camera);
            camera->fov = demo3->fov;
            camera->roll = anim->animFrame = 0;
            anim->initialAt = camPlayerPosRot->pos;
            if (BGCHECK_Y_MIN != camera->playerGroundY) {
                anim->initialAt.y = camera->playerGroundY;
            }
            angle = camPlayerPosRot->rot.y;
            sp68.x = (Math_Sins(angle) * 40.0f) + anim->initialAt.x;
            sp68.y = anim->initialAt.y + 40.0f;
            sp68.z = (Math_Coss(angle) * 40.0f) + anim->initialAt.z;
            if (camera->globalCtx->state.frames & 1) {
                angle -= 0x3FFF;
                anim->yawDir = 1;
            } else {
                angle += 0x3FFF;
                anim->yawDir = -1;
            }
            sp74.x = (D_8011D658[1].r * Math_Sins(angle)) + sp68.x;
            sp74.y = anim->initialAt.y + 5.0f;
            sp74.z = (D_8011D658[1].r * Math_Coss(angle)) + sp68.z;
            if (func_80043F34(camera, &sp68, &sp74)) {
                anim->yawDir = -anim->yawDir;
            }
            OLib_Vec3fToVecSphGeo(&atOffset, &D_8011D678[0]);
            atOffset.yaw += camPlayerPosRot->rot.y;
            Camera_Vec3fVecSphGeoAdd(at, &anim->initialAt, &atOffset);
            eyeOffset.r = D_8011D658[0].r;
            eyeOffset.pitch = D_8011D658[0].pitch;
            eyeOffset.yaw = (D_8011D658[0].yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            anim->unk_0C = 1.0f;
            break;
        case 1:
            // todo: what is 0.006849315017461777?
            temp_f0 = (anim->animFrame - 2) * 0.006849315017461777f;

            sp5C.x = F32_LERPIMP(D_8011D678[0].x, D_8011D678[1].x, temp_f0);
            sp5C.y = F32_LERPIMP(D_8011D678[0].y, D_8011D678[1].y, temp_f0);
            sp5C.z = F32_LERPIMP(D_8011D678[0].z, D_8011D678[1].z, temp_f0);
            
            OLib_Vec3fToVecSphGeo(&atOffset, &sp5C);
            atOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            Camera_Vec3fVecSphGeoAdd(at, &anim->initialAt, &atOffset);

            atOffset.r = F32_LERPIMP(D_8011D658[0].r, D_8011D658[1].r, temp_f0);
            atOffset.pitch = BINANG_LERPIMP(D_8011D658[0].pitch, D_8011D658[1].pitch, temp_f0);
            atOffset.yaw = BINANG_LERPIMP(D_8011D658[0].yaw, D_8011D658[1].yaw, temp_f0);
            
            eyeOffset.r = atOffset.r;
            eyeOffset.pitch = atOffset.pitch;
            eyeOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            
            // todo: what is 0.002739726100116969?
            anim->unk_0C -= 0.002739726100116968f;
            break;
        case 2:
            temp_f0 = (anim->animFrame - 0x94) * 0.1f;
            
            sp5C.x = F32_LERPIMP(D_8011D678[1].x, D_8011D678[2].x, temp_f0);
            sp5C.y = F32_LERPIMP((D_8011D678[1].y - yOffset), D_8011D678[2].y, temp_f0);
            sp5C.y += yOffset;
            sp5C.z = F32_LERPIMP(D_8011D678[1].z, D_8011D678[2].z, temp_f0);

            OLib_Vec3fToVecSphGeo(&atOffset, &sp5C);
            atOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            Camera_Vec3fVecSphGeoAdd(at, &anim->initialAt, &atOffset);

            atOffset.r = F32_LERPIMP(D_8011D658[1].r, D_8011D658[2].r, temp_f0);
            atOffset.pitch = BINANG_LERPIMP(D_8011D658[1].pitch, D_8011D658[2].pitch, temp_f0);
            atOffset.yaw = BINANG_LERPIMP(D_8011D658[1].yaw, D_8011D658[2].yaw, temp_f0);

            eyeOffset.r = atOffset.r;
            eyeOffset.pitch = atOffset.pitch;
            eyeOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            anim->unk_0C -= 0.04f;
            break;
        case 3:
            temp_f0 = (anim->animFrame - 0x9F) * (1.0f / 9.0f);

            sp5C.x = F32_LERPIMP(D_8011D678[2].x, D_8011D678[3].x, temp_f0);
            sp5C.y = F32_LERPIMP(D_8011D678[2].y, D_8011D678[3].y, temp_f0);
            sp5C.y += yOffset;
            sp5C.z = F32_LERPIMP(D_8011D678[2].z, D_8011D678[3].z, temp_f0);
            
            OLib_Vec3fToVecSphGeo(&atOffset, &sp5C);
            atOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            Camera_Vec3fVecSphGeoAdd(at, &anim->initialAt, &atOffset);

            atOffset.r = F32_LERPIMP(D_8011D658[2].r, D_8011D658[3].r, temp_f0);
            atOffset.pitch = BINANG_LERPIMP(D_8011D658[2].pitch, D_8011D658[3].pitch, temp_f0);
            atOffset.yaw = BINANG_LERPIMP(D_8011D658[2].yaw, D_8011D658[3].yaw, temp_f0);
            
            eyeOffset.r = atOffset.r;
            eyeOffset.pitch = atOffset.pitch;
            eyeOffset.yaw = (atOffset.yaw * anim->yawDir) + camPlayerPosRot->rot.y;
            anim->unk_0C += (4.0f / 45.0f);
            break;
        case 30:
            camera->unk_14C |= 0x400;
            if (camera->unk_14C & 8) {
                camera->animState = 4;
            }
        case 10:
        case 20:
            skipUpdateEye = true;
            break;
        case 4:
            eyeOffset.r = 80.0f;
            eyeOffset.pitch = 0;
            eyeOffset.yaw = eyeAtOffset.yaw;
            anim->unk_0C = 0.1f;
            sCameraInterfaceFlags = 0x3400;

            if (!((anim->animFrame < 0 || camera->xzSpeed > 0.001f || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) ||
                        CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) ||
                        CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) ||
                        CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || 
                        CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG)) && camera->unk_14C & 8)) {
                            goto skipeyeUpdate;
            }


        default:
            camera->unk_14C |= 0x14;
            camera->unk_14C &= ~8;
            if (camera->prevCamDataIdx < 0) {
                Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
            } else {
                Camera_ChangeDataIdx(camera, camera->prevCamDataIdx);
                camera->prevCamDataIdx = -1;
            }
            sCameraInterfaceFlags = 0;
skipeyeUpdate:
            skipUpdateEye = 1;
            break;
    }

    anim->animFrame++;

    if(anim->animFrame == 1){
        camera->animState = 0xA;
    } else if(anim->animFrame == 2){
        camera->animState = 0x1;
    } else if(anim->animFrame == 0x94){
        camera->animState = 2;
    } else if(anim->animFrame == 0x9E){
        camera->animState = 0x14;
    } else if(anim->animFrame == 0x9F){
        camera->animState = 3;
    } else if(anim->animFrame == 0xA8){
        camera->animState = 0x1E;
    } else if(anim->animFrame == 0xE4){
        camera->animState = 4;
    }

    if (!skipUpdateEye) {
        eyeOffset.r = Camera_LERPCeilF(eyeOffset.r, eyeAtOffset.r, anim->unk_0C, 2.0f);
        eyeOffset.pitch = Camera_LERPCeilS(eyeOffset.pitch, eyeAtOffset.pitch, anim->unk_0C, 0xA);
        eyeOffset.yaw = Camera_LERPCeilS(eyeOffset.yaw, eyeAtOffset.yaw, anim->unk_0C, 0xA);
        Camera_Vec3fVecSphGeoAdd(&camera->eyeNext, at, &eyeOffset);
        *eye = camera->eyeNext;
    }

    camera->dist = OLib_Vec3fDist(at, eye);
    camera->atLERPStepScale = 0.1f;
    camera->posOffset.x = camera->at.x - camPlayerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - camPlayerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - camPlayerPosRot->pos.z;
    return true;
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_Demo3.s")
#endif
#undef NON_MATCHING

s32 Camera_Demo4(Camera* camera) {
    return Camera_NOP(camera);
}

/**
 * Sets up a cutscene for Camera_Uniq9
*/
s32 Camera_Demo5(Camera *camera) {
    f32 eyeTargetDist;
    f32 sp90;
    VecSph playerTargetGeo;
    VecSph eyePlayerGeo;
    VecSph sp78;
    PosRot playerPosRot2;
    PosRot targetPosRot2;
    Player *player;
    s16 sp4A;
    s32 pad;
    s32 temp_v0;
    s16 t;
    s32 pad2;

    func_8002EEE4(&playerPosRot2, &camera->player->actor);
    player = camera->player;
    sCameraInterfaceFlags = 0x3200;
    if ((camera->target == NULL) || (camera->target->update == NULL)) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: attention: target is not valid, stop!\n" VT_RST);
        }
        camera->target = NULL;
        return true;
    }
    func_8002EEE4(&camera->targetPosRot, camera->target);
    OLib_Vec3fDiffToVecSphGeo(&playerTargetGeo, &camera->targetPosRot, &camera->playerPosRot.pos);
    D_8011D3AC = camera->target->type;
    func_8002F374(camera->globalCtx, camera->target, &sp78.yaw, &sp78.pitch);
    eyeTargetDist = OLib_Vec3fDist(&camera->targetPosRot, &camera->eye);
    OLib_Vec3fDiffToVecSphGeo(&eyePlayerGeo, &playerPosRot2.pos, &camera->eyeNext);
    sp4A = eyePlayerGeo.yaw - playerTargetGeo.yaw;
    if (camera->target->type == ACTORTYPE_PLAYER) {
        // camera is targeting a(the) player actor
        if (eyePlayerGeo.r > 30.0f) {
            D_8011D6AC[1].timerInit = camera->timer - 1;
            D_8011D6AC[1].atTargetInit.z = Math_Rand_ZeroOne() * 10.0f;
            D_8011D6AC[1].eyeTargetInit.x = Math_Rand_ZeroOne() * 10.0f;
            camera->params.uniq9.keyFrames = D_8011D6AC;
            camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D6AC);
            if (camera->parentCamIdx != 0) {
                camera->params.uniq9.keyFrameCnt--;
            } else {
                camera->timer += D_8011D6AC[2].timerInit;
            }
        } else {
            D_8011D724[1].eyeTargetInit.x = Math_Rand_ZeroOne() * 10.0f;
            D_8011D724[1].timerInit = camera->timer - 1;
            camera->params.uniq9.keyFrames = D_8011D724;
            camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D724);
            if (camera->parentCamIdx != 0) {
                camera->params.uniq9.keyFrameCnt--;
            } else {
                camera->timer += D_8011D724[2].timerInit;
            }
        }
    } else if (playerTargetGeo.r < 30.0f) {
        // distance between player and target is less than 30 units.
        camera->params.uniq9.keyFrames = D_8011D79C;
        camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D79C);
        if ((sp78.yaw < 0x15) || (sp78.yaw >= 0x12C) || (sp78.pitch < 0x29) || (sp78.pitch >= 0xC8)) {
            D_8011D79C[0].actionFlags = 0x41;
            D_8011D79C[0].atTargetInit.y = -30.0f;
            D_8011D79C[0].atTargetInit.x = 0.0f;
            D_8011D79C[0].atTargetInit.z = 0.0f;
            D_8011D79C[0].eyeTargetInit.y = 0.0f;
            D_8011D79C[0].eyeTargetInit.x = 10.0f;
            D_8011D79C[0].eyeTargetInit.z = -50.0f;
        }

        D_8011D79C[1].timerInit = camera->timer - 1;
        
        if (camera->parentCamIdx != 0) {
            camera->params.uniq9.keyFrameCnt -= 2;
        } else {
            camera->timer += D_8011D79C[2].timerInit + D_8011D79C[3].timerInit;
        }
    } else if (eyeTargetDist < 300.0f && eyePlayerGeo.r < 30.0f) {
        // distance from the camera's current positon and the target is less than 300 units
        // and the distance fromthe camera's current position to the player is less than 30 units
        D_8011D83C[0].timerInit = camera->timer;
        camera->params.uniq9.keyFrames = D_8011D83C;
        camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D83C);
        if (camera->parentCamIdx != 0) {
            camera->params.uniq9.keyFrameCnt--;
        } else {
            camera->timer += D_8011D83C[1].timerInit;
        }
    } else if(eyeTargetDist < 700.0f && ABS(sp4A) < 0x36B0) {
        // The distance between the camera's current position and the target is less than 700 units
        // and the angle between the camera's position and the player, and the player to the target
        // is less than ~76.9 degrees
        if(sp78.yaw >= 0x15 && sp78.yaw < 0x12C && sp78.pitch >= 0x29 && sp78.pitch < 0xC8 && eyePlayerGeo.r > 30.0f){
            D_8011D88C[0].timerInit = camera->timer;
            camera->params.uniq9.keyFrames = D_8011D88C;
            camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D88C);
            if (camera->parentCamIdx != 0) {
                camera->params.uniq9.keyFrameCnt--;
            } else {
                camera->timer += D_8011D88C[1].timerInit;
            }
        } else {
            D_8011D8DC[0].atTargetInit.z = eyeTargetDist * 0.6f;
            D_8011D8DC[0].eyeTargetInit.z = eyeTargetDist + 50.0f;
            D_8011D8DC[0].eyeTargetInit.x = Math_Rand_ZeroOne() * 10.0f;
            if (BINANG_SUB(eyePlayerGeo.yaw, playerTargetGeo.yaw) > 0) {
                D_8011D8DC[0].atTargetInit.x = -D_8011D8DC[0].atTargetInit.x;
                D_8011D8DC[0].eyeTargetInit.x = -D_8011D8DC[0].eyeTargetInit.x;
                D_8011D8DC[0].rollTargetInit = -D_8011D8DC[0].rollTargetInit;
            }
            D_8011D8DC[0].timerInit = camera->timer;
            D_8011D8DC[1].timerInit = (s16)(eyeTargetDist * 0.005f) + 8;
            camera->params.uniq9.keyFrames = D_8011D8DC;
            camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D8DC);
            if (camera->parentCamIdx != 0) {
                camera->params.uniq9.keyFrameCnt -= 2;
            } else {
                camera->timer += D_8011D8DC[1].timerInit + D_8011D8DC[2].timerInit;
            }
        }
    } else if (camera->target->type == ACTORTYPE_DOOR) {
        // the target is a door.
        D_8011D954[0].timerInit = camera->timer - 5;
        sp4A = 0;
        if (!func_800C0D34(camera->globalCtx, camera->target, &sp4A)) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: attention demo: this door is dummy door!\n" VT_RST);
            if (ABS(playerTargetGeo.yaw - camera->target->shape.rot.y) >= 0x4000) {
                sp4A = camera->target->shape.rot.y;
            } else {
                sp4A = BINANG_ROT180(camera->target->shape.rot.y);
            }
        }

        D_8011D954[0].atTargetInit.y = D_8011D954[0].eyeTargetInit.y = D_8011D954[1].atTargetInit.y = camera->target->shape.rot.y == sp4A ? 180.0f : 0.0f;
        sp90 = (BINANG_SUB(playerTargetGeo.yaw, sp4A) < 0 ? 20.0f : -20.0f) * Math_Rand_ZeroOne();
        D_8011D954[0].eyeTargetInit.y = D_8011D954->eyeTargetInit.y + sp90;
        temp_v0 = Math_Rand_ZeroOne() * (sp90 * -0.2f);
        D_8011D954[1].rollTargetInit = temp_v0;
        D_8011D954[0].rollTargetInit = temp_v0;
        func_8002EEE4(&targetPosRot2, camera->target);
        targetPosRot2.pos.x += 50.0f * Math_Sins(BINANG_ROT180(sp4A));
        targetPosRot2.pos.z += 50.0f * Math_Coss(BINANG_ROT180(sp4A));
        if (func_80043F34(camera, &playerPosRot2, &targetPosRot2.pos)) {
            D_8011D954[1].actionFlags = 0xC1;
            D_8011D954[2].actionFlags = 0x8F;
        } else {
            D_8011D954[2].timerInit = (s16)(eyeTargetDist * 0.004f) + 6;
        }
        camera->params.uniq9.keyFrames = D_8011D954;
        camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D954);
        if (camera->parentCamIdx != 0) {
            camera->params.uniq9.keyFrameCnt -= 2;
        } else {
            camera->timer += D_8011D954[2].timerInit + D_8011D954[3].timerInit;
        }
    } else {
        if (playerTargetGeo.r < 200.0f) {
            D_8011D9F4[0].eyeTargetInit.z = playerTargetGeo.r;
            D_8011D9F4[0].atTargetInit.z = playerTargetGeo.r * 0.25f;
        }
        if (playerTargetGeo.r < 400.0f) {
            D_8011D9F4[0].eyeTargetInit.x = Math_Rand_ZeroOne() * 25.0f;
        }
        Player_GetCameraYOffset(camera->player);
        D_8011D9F4[0].timerInit = camera->timer;
        func_8002EEE4(&targetPosRot2, camera->target);
        if (func_80043F34(camera, &playerPosRot2, &targetPosRot2.pos)) {
            D_8011D9F4[1].timerInit = 4;
            D_8011D9F4[1].actionFlags = 0x8F;
        } else {
            t = eyeTargetDist * 0.005f;
            D_8011D9F4[1].timerInit = t + 8;
        }
        camera->params.uniq9.keyFrames = D_8011D9F4;
        camera->params.uniq9.keyFrameCnt = ARRAY_COUNT(D_8011D9F4);
        if (camera->parentCamIdx != 0) {
            if (camera->globalCtx->state.frames & 1) {
                D_8011D9F4[0].rollTargetInit = -D_8011D9F4[0].rollTargetInit;
                D_8011D9F4[1].rollTargetInit = -D_8011D9F4[1].rollTargetInit;
            }
            camera->params.uniq9.keyFrameCnt -= 2;
        } else {
            camera->timer += D_8011D9F4[1].timerInit + D_8011D9F4[2].timerInit;
            D_8011D9F4[0].rollTargetInit = D_8011D9F4[1].rollTargetInit = 0;
        }
    }

    pad = sDemo5PrevSfxFrame - camera->globalCtx->state.frames;
    if ((pad >= 0x33) || (pad < -0x32)) {
        func_80078884(camera->unkSfx);
    }
    
    sDemo5PrevSfxFrame = camera->globalCtx->state.frames;
    
    if (camera->player->stateFlags1 & 0x8000000 && (player->currentBoots != 1)) {
        // swimming, and not iron boots
        player->stateFlags1 |= 0x20000000;
        // env frozen
        player->actor.freezeTimer = camera->timer;
    } else {
        sp4A = playerPosRot2.rot.y - playerTargetGeo.yaw;
        if (camera->target->type == ACTORTYPE_PLAYER) {
            pad = camera->globalCtx->state.frames - sDemo5PrevAction12Frame;
            if (player->stateFlags1 & 0x800) {
                // holding object over head.
                func_8002DF54(camera->globalCtx, camera->target, 8);
            } else if (ABS(pad) > 3000) {
                func_8002DF54(camera->globalCtx, camera->target, 12);
            } else {
                func_8002DF54(camera->globalCtx, camera->target, 69);
            }
        } else {
            func_8002DF54(camera->globalCtx, camera->target, 1);
        }
    }

    sDemo5PrevAction12Frame = camera->globalCtx->state.frames;
    Camera_ChangeSettingFlags(camera, CAM_SET_DEMOC, (4 | 1));
    Camera_Unique9(camera);
    return true;
}

/**
 * Used in Forest Temple when poes are defeated, follows the flames to the torches.
 * Fixed position, rotates to follow the target
*/
s32 Camera_Demo6(Camera *camera) {
    Camera *cam0;
    Demo6Anim* anim = &camera->params.demo6.anim;
    Vec3f* eyeNext = &camera->eyeNext;
    CameraModeValue *values;
    VecSph eyeOffset;
    Actor* camFocus;
    PosRot focusPosRot;
    s16 stateTimers[4];
    Vec3f* at = &camera->at;

    cam0 = Gameplay_GetCamera(camera->globalCtx, 0);
    camFocus = camera->target;
    stateTimers[1] = 0x37;
    stateTimers[2] = 0x46;
    stateTimers[3] = 0x5A;

    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        camera->params.demo6.interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    switch(camera->animState){
        case 0:
            // initalizes the camera state.
            anim->animTimer = 0;
            camera->fov = 60.0f;
            func_8002EF14(&focusPosRot, camFocus);
            camera->at.x = focusPosRot.pos.x;
            camera->at.y = focusPosRot.pos.y + 20.0f;
            camera->at.z = focusPosRot.pos.z;
            eyeOffset.r = 200.0f;
            // 0x7D0 ~10.99 degrees
            eyeOffset.yaw = Camera_XZAngle(&focusPosRot.pos, &cam0->playerPosRot.pos) + 0x7D0;
            // -0x3E8 ~5.49 degrees
            eyeOffset.pitch = -0x3E8;
            Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeOffset);
            camera->eye = *eyeNext;
            camera->animState++;
        case 1:
            if (stateTimers[camera->animState] < anim->animTimer) {
                func_8002DF54(camera->globalCtx, &camera->player->actor, 8);
                func_8002EF14(&focusPosRot, camFocus);
                anim->atTarget.x = focusPosRot.pos.x;
                anim->atTarget.y = focusPosRot.pos.y - 20.0f;
                anim->atTarget.z = focusPosRot.pos.z;
                camera->animState++;
            } else {
                break;
            }
        case 2:
            Camera_LERPCeilVec3f(&anim->atTarget, at, 0.1f, 0.1f, 8.0f);
            if (stateTimers[camera->animState] < anim->animTimer) {
                camera->animState++;
            } else {
                break;
            }
        case 3:
            camera->fov = Camera_LERPCeilF(50.0f, camera->fov, 0.2f, 0.01f);
            if (stateTimers[camera->animState] < anim->animTimer) {
                camera->timer = 0;
                return true;
            }
            break;
    }
    
    anim->animTimer++;
    // useless copy
    func_8002EF14(&focusPosRot, camFocus);

    return true;
}

s32 Camera_Demo7(Camera* camera) {
    if (camera->animState == 0) {
        camera->unk_14C &= ~4;
        camera->unk_14C |= 0x1000;
        camera->animState++;
    }
    // @bug doesn't return
}

s32 Camera_Demo8(Camera* camera) {
    return Camera_NOP(camera);
}

/**
 * Camera follows points specified by demo9.atPoints and demo9.eyePoints, allows finer control
 * over the final eye and at points than Camera_Demo1, by allowing the interpolated at and eye points
 * to be relative to the main camera's player, the current camera's player, or the main camera's target
*/
s32 Camera_Demo9(Camera *camera) {
    s32 pad;
    s32 finishAction;
    s16 onePointParam;
    Demo9OnePointDemo* demo9OnePoint = &camera->params.demo9;
    Vec3f csEyeUpdate;
    Vec3f csAtUpdate;
    Vec3f newEye;
    Vec3f newAt;
    f32 newRoll;
    CameraModeValue* values;
    Camera *cam0;
    Vec3f* eye = &camera->eye;
    PosRot *cam0PlayerPosRot;
    PosRot focusPosRot;
    s32 pad3;
    Vec3f* eyeNext = &camera->eyeNext;
    Demo9* demo9 = &demo9OnePoint->demo9;
    Vec3f* at = &camera->at;
    f32* camFOV = &camera->fov;
    Demo9Anim* anim = &demo9->anim;

    cam0 = Gameplay_GetCamera(camera->globalCtx, 0);
    cam0PlayerPosRot = &cam0->playerPosRot;
    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        demo9->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }
    
    sCameraInterfaceFlags = demo9->interfaceFlags;
    
    switch(camera->animState){
        case 0:
            // initalize the camera state
            anim->keyframe = 0;
            anim->finishAction = 0;
            anim->curFrame = 0.0f;
            camera->animState++;
            anim->doLERPAt = false;
            finishAction = demo9OnePoint->onePointDemo.actionParameters & 0xF000;
            if (finishAction != 0) {
                anim->finishAction = finishAction;

                // Clear finish parameters
                demo9OnePoint->onePointDemo.actionParameters &= 0xFFF;
            }
            anim->animTimer = demo9OnePoint->onePointDemo.initTimer;
        case 1:
            // Run the camera state
            if (anim->animTimer > 0) {
                // if the animation timer is still running, run the demo logic
                // if it is not, then the case will fallthrough to the finish logic.

                // Run the at and eye cs interpoloation functions, if either of them return 1 (that no more points exist)
                // change the animation state to 2 (standby)
                if (func_800BB2B4(&csEyeUpdate, &newRoll, camFOV, demo9OnePoint->onePointDemo.eyePoints, &anim->keyframe, &anim->curFrame) != 0 ||
                    func_800BB2B4(&csAtUpdate, &newRoll, camFOV, demo9OnePoint->onePointDemo.atPoints, &anim->keyframe, &anim->curFrame) != 0)
                {
                    camera->animState = 2;
                }

                if (demo9OnePoint->onePointDemo.actionParameters == 1) {
                    // rotate around cam0's player
                    Camera_RotateAroundPoint(cam0PlayerPosRot, &csEyeUpdate, &newEye);
                    Camera_RotateAroundPoint(cam0PlayerPosRot, &csAtUpdate, &newAt);
                } else if (demo9OnePoint->onePointDemo.actionParameters == 4) {
                    // rotate around the current camera's player
                    func_8002EF14(&focusPosRot, &camera->player->actor);
                    Camera_RotateAroundPoint(&focusPosRot, &csEyeUpdate, &newEye);
                    Camera_RotateAroundPoint(&focusPosRot, &csAtUpdate, &newAt);
                } else if (demo9OnePoint->onePointDemo.actionParameters == 8) {
                    // rotate around the current camera's target
                    if (camera->target != NULL && camera->target->update != NULL) {
                        func_8002EF14(&focusPosRot, camera->target);
                        Camera_RotateAroundPoint(&focusPosRot, &csEyeUpdate, &newEye);
                        Camera_RotateAroundPoint(&focusPosRot, &csAtUpdate, &newAt);
                    } else {
                        camera->target = NULL;
                        newEye = *eye;
                        newAt = *at;
                    }
                } else {
                    // simple copy
                    Camera_Vec3fCopy(&csEyeUpdate, &newEye);
                    Camera_Vec3fCopy(&csAtUpdate, &newAt);
                }

                *eyeNext = newEye;
                *eye = *eyeNext;
                if (anim->doLERPAt) {
                    Camera_LERPCeilVec3f(&newAt, at, 0.5f, 0.5f, 0.1f);
                } else {
                    *at = newAt;
                    anim->doLERPAt = true;
                }
                camera->roll = newRoll * 256.0f;
                anim->animTimer--;
                break;
            }
        case 3:
            // the cs is finished, decide the next action
            camera->timer = 0;
            if (anim->finishAction != 0) {
                if (anim->finishAction != 0x1000) {
                    if (anim->finishAction == 0x2000) {
                        // finish action = 0x2000, run OnePointDemo 0x3FC (Dramatic Return to Link)
                        onePointParam = demo9OnePoint->onePointDemo.initTimer < 0x32 ? 5 : demo9OnePoint->onePointDemo.initTimer / 5;
                        func_800800F8(camera->globalCtx, 0x3FC, onePointParam, NULL, camera->parentCamIdx);
                    }
                } else {
                    // finish action = 0x1000, copy the current camera's values to the
                    // default camera.
                    Camera_Copy(cam0, camera);
                }
            }
            break;
        case 2:
            // standby while the timer finishes, change the animState to finish when
            // the timer runs out.
            anim->animTimer--;
            if (anim->animTimer < 0) {
                camera->animState++;
            }
            break;
        case 4:
            // do nothing.
            break;

    }

    return true;
}

s32 Camera_Demo0(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Special0(Camera* camera) {
    CameraModeValue* values;
    PosRot* playerPosRot = &camera->playerPosRot;
    Special0* spec0 = &camera->params.spec0;

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        spec0->lerpAtScale = NEXTPCT;
        spec0->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    sCameraInterfaceFlags = spec0->interfaceFlags;

    if (camera->animState == 0) {
        camera->animState++;
    }

    if ((camera->target == NULL) || (camera->target->update == NULL)) {
        if (camera->target == NULL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: warning: circle: target is not valid, stop!\n" VT_RST);
        }
        camera->target = NULL;
        return true;
    }

    func_8002EEE4(&camera->targetPosRot, camera->target);
    Camera_LERPCeilVec3f(&camera->targetPosRot.pos, &camera->at, spec0->lerpAtScale, spec0->lerpAtScale, 0.1f);

    camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - playerPosRot->pos.z;

    camera->dist = OLib_Vec3fDist(&camera->at, &camera->eye);
    camera->xzSpeed = 0.0f;
    if (camera->timer > 0) {
        camera->timer--;
    }
    return true;
}

s32 Camera_Special1(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Special2(Camera* camera) {
    return Camera_Unique2(camera);
}

s32 Camera_Special3(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Special4(Camera* camera) {
    PosRot curTargetPosRot;
    s16 sp3A;
    s16* timer = &camera->timer;
    Special4* spec4 = &camera->params.spec4;

    if (camera->animState == 0) {
        sCameraInterfaceFlags = 0x3200;
        camera->fov = 40.0f;
        camera->animState++;
        spec4->unk_00 = camera->timer;
    }

    camera->fov = Camera_LERPCeilF(80.0f, camera->fov, 1.0f / *timer, 0.1f);
    if ((spec4->unk_00 - *timer) < 0xF) {
        (*timer)--;
        return false;
    } else {
        camera->roll = -0x1F4;
        func_8002EF14(&curTargetPosRot, camera->target);
        
        camera->at = curTargetPosRot.pos;
        camera->at.y -= 150.0f;

        // 0x3E8 ~ 5.49 degrees
        sp3A = BINANG_ROT180(curTargetPosRot.rot.y) + 0x3E8;
        camera->eye.x = camera->eyeNext.x = (Math_Sins(sp3A) * 780.0f) + camera->at.x;
        camera->eyeNext.y = camera->at.y;
        camera->eye.z = camera->eyeNext.z = (Math_Coss(sp3A) * 780.0f) + camera->at.z;
        camera->eye.y = curTargetPosRot.pos.y;
        camera->eye.y = func_80044510(camera, &camera->eye) + 20.0f;
        (*timer)--;
        return true;
    }
}

/**
 * Flying with hookshot
*/
s32 Camera_Special5(Camera *camera) {
    f32 yOffsetInverse;
    Special5* spec5 = &camera->params.spec5;
    CameraModeValue *values;
    PosRot spA8;
    s16 pad;
    s16 spA4;
    CamColChk sp7C;
    VecSph sp74;
    VecSph sp6C;
    VecSph sp64;
    VecSph sp5C;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    f32 yOffset;
    PosRot *playerPosRot = &camera->playerPosRot;
    Special5Anim* anim = &spec5->anim;
    f32 temp_f0_2;
    
    yOffset = Player_GetCameraYOffset(camera->player);
    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        yOffsetInverse = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / yOffset));
        spec5->yOffset = (NEXTPCT * yOffset) * yOffsetInverse;
        spec5->eyeDist = NEXTSETTING;
        spec5->minDistForRot = NEXTSETTING;
        spec5->timerInit = NEXTSETTING;
        spec5->pitch = DEGF_TO_BINANG(NEXTSETTING);
        spec5->fovTarget = NEXTSETTING;
        spec5->atMaxLERPScale = NEXTPCT;
        spec5->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&sp64, at, eye);
    OLib_Vec3fDiffToVecSphGeo(&sp5C, at, eyeNext);
    func_8002EF14(&spA8, camera->target);

    sCameraInterfaceFlags = spec5->interfaceFlags;

    if (camera->animState == 0) {
        camera->animState++;
        anim->animTimer = spec5->timerInit;
    }

    if (anim->animTimer > 0) {
        anim->animTimer--;
    } else if (anim->animTimer == 0) {
        if (camera->target == NULL || camera->target->update == NULL) {
            camera->target = NULL;
            return true;
        }

        anim->animTimer--;
        if (spec5->minDistForRot < OLib_Vec3fDist(&spA8.pos, &playerPosRot->pos)) {
            sp6C.yaw = playerPosRot->rot.y;
            sp6C.pitch = -playerPosRot->rot.x;
            sp6C.r = 20.0f;
            Camera_Vec3fVecSphGeoAdd(&sp7C.pos, &spA8.pos, &sp6C);
            func_80043D18(camera, at, &sp7C);
            OLib_Vec3fToVecSphGeo(&sp6C, &sp7C.norm);
            spA4 = BINANG_SUB(playerPosRot->rot.y, sp6C.yaw);
            sp74.r = spec5->eyeDist;
            temp_f0_2 = Math_Rand_ZeroOne();
            sp74.yaw = BINANG_ROT180(playerPosRot->rot.y) +  
                        (s16)(spA4 < 0 ? 
                            -(s16)(0x1553 + (s16)(temp_f0_2 * 2730.0f)) :
                            (s16)(0x1553 + (s16)(temp_f0_2 * 2730.0f)));
            sp74.pitch = spec5->pitch;
            Camera_Vec3fVecSphGeoAdd(eyeNext, &spA8.pos, &sp74);
            *eye = *eyeNext;
            func_80043F34(camera, &spA8.pos, eye);
        }
    }
    
    func_800457A8(camera, &sp5C, spec5->yOffset, 0);
    camera->fov = Camera_LERPCeilF(spec5->fovTarget, camera->fov, camera->atLERPStepScale * PCT(OREG(4)), 1.0f);
    camera->roll = Camera_LERPCeilS(0, camera->roll, 0.5f, 0xA);
    camera->atLERPStepScale = Camera_ClampLERPScale(camera, spec5->atMaxLERPScale);
    return true;
}

/**
 * Camera's eye is fixed at points specified at D_8011DA6C / D_8011DA9C
 * depending on the player's position
*/
s32 Camera_Special7(Camera *camera) {
    Special7* spec7 = &camera->params.spec7;
    PosRot *playerPosRot = &camera->playerPosRot;
    Vec3f atTarget;
    f32 yOffset;
    f32 temp_f0;

    yOffset = Player_GetCameraYOffset(camera->player);
    if (camera->animState == 0) {
        if (camera->globalCtx->sceneNum == SCENE_JYASINZOU) {
            // Spirit Temple
            spec7->idx = 3;
        } else if (playerPosRot->pos.x < 1500.0f) {
            spec7->idx = 2;
        } else if (playerPosRot->pos.y < 3000.0f) {
            spec7->idx = 0;
        } else {
            spec7->idx = 1;
        }
        camera->animState++;
        camera->roll = 0;
    }

    if (camera->at.y < D_8011DACC[spec7->idx]) {
        atTarget = playerPosRot->pos;
        atTarget.y -= 20.0f;
        Camera_LERPCeilVec3f(&atTarget, &camera->at, 0.4f, 0.4f, 0.10f);
        camera->eye = camera->eyeNext = D_8011DA6C[spec7->idx];
        temp_f0 = (playerPosRot->pos.y - D_8011DADC[spec7->idx]) / (D_8011DACC[spec7->idx] - D_8011DADC[spec7->idx]);
        camera->roll = D_8011DAEC[spec7->idx] * temp_f0;
        camera->fov = (20.0f * temp_f0) + 60.0f;
    } else {
        atTarget = playerPosRot->pos;
        atTarget.y += yOffset;
        Camera_LERPCeilVec3f(&atTarget, &camera->at, 0.4f, 0.4f, 0.1f);
        camera->roll = 0;
        camera->eye = camera->eyeNext = D_8011DA9C[spec7->idx];
        camera->fov = 70.0f;
    }

    camera->dist = OLib_Vec3fDist(&camera->at, &camera->eye);
    camera->atLERPStepScale = 0.0f;
    camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
    return true;
}

/**
 * Courtyard.
 * Camera's eye is fixed on the z plane, slides on the xy plane with link
 * When the camera's scene data changes the animation to the next "screen"
 * happens for 12 frames.  The camera's eyeNext is the scene's camera data's position
*/
s32 Camera_Special6(Camera *camera) {
    s32 pad;
    Vec3f *at = &camera->at;
    Special6 *spec6 = &camera->params.spec6;
    VecSph atOffset;
    Vec3f sceneCamPos;
    Vec3f eyePosCalc;
    Vec3f eyeAnim;
    Vec3f atAnim;
    VecSph eyeAtOffset;
    CameraModeValue *values;
    CamPosData *sceneCamData;
    Vec3s sceneCamRot;
    s16 fov;
    Vec3f *eye = &camera->eye;
    f32 timerF;
    f32 timerDivisor;
    f32 sp54;

    Vec3f *eyeNext = &camera->eyeNext;
    PosRot* playerPosRot = &camera->playerPosRot;
    Special6Anim* anim = &spec6->anim;

    if (RELOAD_PARAMS) {
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        spec6->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    OLib_Vec3fDiffToVecSphGeo(&eyeAtOffset, eye, at);

    sceneCamData = func_8004476C(camera);
    Camera_Vec3sToVec3f(&sceneCamPos, &sceneCamData->pos);
    sceneCamRot = sceneCamData->rot;
    fov = sceneCamData->fov;
    if (fov == -1) {
        fov = 6000;
    }

    if (fov < 361) {
        fov *= 100;
    }

    sCameraInterfaceFlags = spec6->interfaceFlags;

    if (eyeNext->x != sceneCamPos.x || eyeNext->y != sceneCamPos.y || eyeNext->z != sceneCamPos.z || camera->animState == 0) {
        // A change in the current scene's camera positon has been detected,
        // Change "screens"
        camera->player->actor.freezeTimer = 12;
        sCameraInterfaceFlags = (sCameraInterfaceFlags & 0xF0FF) | 0x300;
        anim->initalPlayerY = playerPosRot->pos.y;
        anim->animTimer = 12;
        *eyeNext = sceneCamPos;
        if (camera->animState == 0) {
            camera->animState++;
        }
    }

    if (anim->animTimer > 0) {
        // In transition between "screens"
        timerF = anim->animTimer;
        eyePosCalc = *eyeNext;
        eyePosCalc.x += (playerPosRot->pos.x - eyePosCalc.x) * 0.5f;
        eyePosCalc.y += (playerPosRot->pos.y - anim->initalPlayerY) * 0.2f;
        eyeAnim = eyePosCalc;
        eyeAnim.y = Camera_LERPCeilF(eyePosCalc.y, eye->y, 0.5f, 0.01f);

        // set the at point to be 100 units from the eye looking at the 
        // direction specified in the scene's camera data. 
        atOffset.r = 100.0f;
        atOffset.yaw = sceneCamRot.y;
        atOffset.pitch = -sceneCamRot.x;
        Camera_Vec3fVecSphGeoAdd(&atAnim, &eyeAnim, &atOffset);
        timerDivisor = 1.0f / timerF;
        eye->x += (eyeAnim.x - eye->x) * timerDivisor;
        eye->y += (eyeAnim.y - eye->y) * timerDivisor;
        eye->z += (eyeAnim.z - eye->z) * timerDivisor;
        at->x += (atAnim.x - at->x) * timerDivisor;
        at->y += (atAnim.y - at->y) * timerDivisor;
        at->z += (atAnim.z - at->z) * timerDivisor;
        camera->fov += (PCT(fov) - camera->fov) / anim->animTimer;
        anim->animTimer--;
    } else {
        // Camera following link on the x axis.
        sCameraInterfaceFlags &= 0xF0FF;
        eyePosCalc = *eyeNext;
        eyePosCalc.x += (playerPosRot->pos.x - eyePosCalc.x) * 0.5f;
        eyePosCalc.y += (playerPosRot->pos.y - anim->initalPlayerY) * 0.2f;
        *eye = eyePosCalc;
        eye->y = Camera_LERPCeilF(eyePosCalc.y, eye->y, 0.5f, 0.01f);
        
        // set the at point to be 100 units from the eye looking at the 
        // direction specified in the scene's camera data. 
        atOffset.r = 100.0f;
        atOffset.yaw = sceneCamRot.y;
        atOffset.pitch = -sceneCamRot.x;
        Camera_Vec3fVecSphGeoAdd(at, eye, &atOffset);
    }
    return true;
}

s32 Camera_Special8(Camera* camera) {
    return Camera_NOP(camera);
}

s32 Camera_Special9(Camera *camera) {
    s32 pad;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;
    Vec3f spAC;
    VecSph eyeAdjustment;
    VecSph atEyeOffsetGeo;
    f32 playerYOffset;
    CameraModeValue* values;
    s32 pad3;
    PosRot adjustedPlayerPosRot;
    f32 playerYNormalized;
    PosRot *playerPosRot = &camera->playerPosRot;
    PersonalizedDoor* doorc = &camera->params.doorCam;
    Special9 *spec9 = &doorc->spec9;
    Special9Anim *anim = &spec9->anim;
    s32 pad4;
    CamPosData *camPosData;

    playerYOffset = Player_GetCameraYOffset(camera->player);
    camera->unk_14C &= ~0x10;
    playerYNormalized = (1.0f + PCT(R_CAM_YOFFSET_NORM)) - (PCT(R_CAM_YOFFSET_NORM) * (68.0f / playerYOffset));

    if(RELOAD_PARAMS){
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        
        spec9->yOffset = NEXTPCT * playerYOffset * playerYNormalized;
        spec9->unk_04 = NEXTSETTING;
        spec9->interfaceFlags = NEXTSETTING;
    }

    if (R_RELOAD_CAM_PARAMS) {
        Camera_CopyPREGToModeValues(camera);
    }

    if (doorc->personalizeParams.actor != NULL) {
        func_8002EF44(&adjustedPlayerPosRot, doorc->personalizeParams.actor);
    } else {
        adjustedPlayerPosRot = *playerPosRot;
        adjustedPlayerPosRot.pos.y += playerYOffset + spec9->yOffset;
        adjustedPlayerPosRot.rot.x = 0;
    }
    
    OLib_Vec3fDiffToVecSphGeo(&atEyeOffsetGeo, at, eye);
    
    sCameraInterfaceFlags = spec9->interfaceFlags;

    switch(camera->animState){
        do{}while(0);
        case 0:
            camera->unk_14C &= ~(0x4 | 0x2);
            camera->animState++;
            anim->targetYaw = ABS(playerPosRot->rot.y - adjustedPlayerPosRot.rot.y) >= 0x4000 ? 
                BINANG_ROT180(adjustedPlayerPosRot.rot.y) : 
                adjustedPlayerPosRot.rot.y;
        case 1:
            doorc->personalizeParams.timer1--;
            if (doorc->personalizeParams.timer1 <= 0) {
                camera->animState++;
                if (spec9->interfaceFlags & 1) {
                    camPosData = func_8004476C(camera);
                    Camera_Vec3sToVec3f(eyeNext, &camPosData->pos);
                    spAC = *eye = *eyeNext;
                } else {
                    s16 yaw;
                    // 0xE38 ~ 20 degrees
                    eyeAdjustment.pitch = 0xE38;
                    // 0xAAA ~ 15 degrees.
                    yaw = 0xAAA * ((camera->globalCtx->state.frames & 1) ? 1 : -1);
                    eyeAdjustment.yaw = anim->targetYaw + yaw;
                    eyeAdjustment.r = 200.0f * playerYNormalized;
                    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeAdjustment);
                    spAC = *eye = *eyeNext;
                    if (func_800443A0(camera, &spAC, &playerPosRot->pos)) {
                        yaw = -yaw;
                        eyeAdjustment.yaw = anim->targetYaw + yaw;
                        Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeAdjustment);
                        *eye = *eyeNext;
                    }
                }
            } else {
                break;
            }
        case 2:
            spAC = playerPosRot->pos;
            spAC.y += playerYOffset + spec9->yOffset;
            
            Camera_LERPCeilVec3f(&spAC, at, 0.25f, 0.25f, 0.1f);
            doorc->personalizeParams.timer2--;
            if (doorc->personalizeParams.timer2 <= 0) {
                camera->animState++;
                anim->targetYaw = BINANG_ROT180(anim->targetYaw);
            } else {
                break;
            }
        case 3:
            spAC = playerPosRot->pos;
            spAC.y += (playerYOffset + spec9->yOffset);
            Camera_LERPCeilVec3f(&spAC, at, 0.5f, 0.5f, 0.1f);
            eyeAdjustment.pitch = Camera_LERPCeilS(0xAAA, atEyeOffsetGeo.pitch, 0.3f, 0xA);
            eyeAdjustment.yaw = Camera_LERPCeilS(anim->targetYaw, atEyeOffsetGeo.yaw, 0.3f, 0xA);
            eyeAdjustment.r = Camera_LERPCeilF(60.0f, atEyeOffsetGeo.r, 0.3f, 1.0f);
            Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeAdjustment);
            *eye = *eyeNext;
            doorc->personalizeParams.timer3--;
            if (doorc->personalizeParams.timer3 <= 0) {
                camera->animState++;
            } else {
                break;
            }
        case 4:
            camera->animState++;
        default:
            camera->unk_14C |= (0x400 | 0x10);
            sCameraInterfaceFlags = 0;

            if(camera->xzSpeed > 0.001f || CHECK_PAD(D_8015BD7C->state.input[0].press, A_BUTTON) ||
                                CHECK_PAD(D_8015BD7C->state.input[0].press, B_BUTTON) || CHECK_PAD(D_8015BD7C->state.input[0].press, L_CBUTTONS) ||
                                CHECK_PAD(D_8015BD7C->state.input[0].press, D_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, U_CBUTTONS) ||
                                CHECK_PAD(D_8015BD7C->state.input[0].press, R_CBUTTONS) || CHECK_PAD(D_8015BD7C->state.input[0].press, R_TRIG) || 
                                CHECK_PAD(D_8015BD7C->state.input[0].press, Z_TRIG) || spec9->interfaceFlags & 0x8){

                                    Camera_ChangeSettingFlags(camera, camera->prevSetting, 2);
                                    camera->unk_14C |= (0x4 | 0x2);
            }
            break;
            
    }
    if(!camera->globalCtx->state.frames){}
    spAC = playerPosRot->pos;
    spAC.y += playerYOffset;
    camera->dist = OLib_Vec3fDist(&spAC, eye);
    camera->posOffset.x = camera->at.x - playerPosRot->pos.x;
    camera->posOffset.y = camera->at.y - playerPosRot->pos.y;
    camera->posOffset.z = camera->at.z - playerPosRot->pos.z;
    return true;
}

Camera* Camera_Create(View* view, CollisionContext* colCtx, GlobalContext* globalCtx) {
    Camera* newCamera = ZeldaArena_MallocDebug(sizeof(*newCamera), "../z_camera.c", 9370);
    if (newCamera != NULL) {
        osSyncPrintf(VT_FGCOL(BLUE) "camera: create --- allocate %d byte" VT_RST "\n", sizeof(*newCamera) * 4);
        Camera_Init(newCamera, view, colCtx, globalCtx);
    } else {
        osSyncPrintf(VT_COL(RED, WHITE) "camera: create: not enough memory\n" VT_RST);
    }
    return newCamera;
}

void Camera_Destroy(Camera* camera) {
    if (camera != NULL) {
        osSyncPrintf(VT_FGCOL(BLUE) "camera: destroy ---" VT_RST "\n");
        ZeldaArena_FreeDebug(camera, "../z_camera.c", 9391);
    } else {
        osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: destroy: already cleared\n" VT_RST);
    }
}

void Camera_Init(Camera *camera, View *view, CollisionContext *colCtx, GlobalContext *globalCtx) {
    Camera *camP;
    s32 i;
    s16 curUID;
    s16 j;

    func_80106860(camera, 0, sizeof(*camera));
    if (sInitRegs) {
        for(i = 0; i < sOREGInitCnt; i++){
            OREG(i) = sOREGInit[i];
        }

        for(i = 0; i < sPREGInitCnt; i++){
            PREG(i) = sPREGInit[i];
        }

        DbgCamera_FirstInit(camera, &D_8015BD80);
        sInitRegs = false;
        PREG(88) = -1;
    }
    camera->globalCtx = D_8015BD7C = globalCtx;
    DbgCamera_Init(&D_8015BD80, camera);
    curUID = sNextUID;
    sNextUID++;
    while(curUID != 0){
        if (curUID == 0) {
            sNextUID++;
        }

        for(j = 0; j < 4; j++){
            camP = camera->globalCtx->cameraPtrs[j];
            if (camP != NULL && curUID == camP->uid) {
                break;
            }
        }

        if(j == 4){
            break;
        }

        curUID = sNextUID++;
    }

    camera->direction.y = 0x3FFF;
    camera->uid = curUID;
    camera->realDir = camera->direction;
    camera->rUpdateRateInv = 10.0f;
    camera->yawUpdateRateInv = 10.0f;
    camera->up.x = 0.0f;
    camera->up.y = 1.0f;
    camera->up.z = 0.0f;
    camera->fov = 60.0f;
    camera->pitchUpdateRateInv = R_CAM_DEFA_PHI_UPDRATE;
    camera->xzOffsetUpdateRate = PCT(OREG(2));
    camera->yOffsetUpdateRate = PCT(OREG(3));
    camera->fovUpdateRate = PCT(OREG(4));
    sCameraShrinkWindowVal = 0x20;
    sCameraInterfaceAlpha = 0;
    camera->unk_14C = 0;
    camera->setting = camera->prevSetting = 0x21;
    camera->camDataIdx = camera->prevCamDataIdx = -1;
    camera->mode = 0;
    camera->bgCheckId = 0x32;
    camera->unk_168 = 0x7FFF;
    camera->timer = -1;
    camera->unk_14C |= 0x4000;

    camera->up.y = 1.0f;
    camera->up.z = camera->up.x = 0.0f;
    camera->skyboxOffset.x = camera->skyboxOffset.y = camera->skyboxOffset.z = 0;
    camera->atLERPStepScale = 1;
    sCameraInterfaceFlags = 0xFF00;
    sDbgModeIdx = -1;
    D_8011D3F0 = 3;
    osSyncPrintf(VT_FGCOL(BLUE) "camera: initialize --- " VT_RST " UID %d\n", camera->uid);
}

s32 Camera_ChangeDoorCam(Camera* camera, Actor* doorActor, s16 arg2, f32 arg3, s16 arg4, s16 arg5, s16 arg6);

void func_80057FC4(Camera* camera) {
    if (camera != &camera->globalCtx->cameras[0]) {
        camera->prevSetting = camera->setting = CAM_SET_FREE0;
        camera->unk_14C &= ~0x4;
    } else if (camera->globalCtx->roomCtx.curRoom.mesh->polygon.type != 1) {
        switch (camera->globalCtx->roomCtx.curRoom.unk_03) {
            case 1:
                Camera_ChangeDoorCam(camera, NULL, -99, 0, 0, 18, 10);
                camera->prevSetting = camera->setting = CAM_SET_DUNGEON0;
                break;
            case 0:
                osSyncPrintf("camera: room type: default set field\n");
                Camera_ChangeDoorCam(camera, NULL, -99, 0, 0, 18, 10);
                camera->prevSetting = camera->setting = CAM_SET_NORMAL0;
                break;
            default:
                osSyncPrintf("camera: room type: default set etc (%d)\n", camera->globalCtx->roomCtx.curRoom.unk_03);
                Camera_ChangeDoorCam(camera, NULL, -99, 0, 0, 18, 10);
                camera->prevSetting = camera->setting = CAM_SET_NORMAL0;
                camera->unk_14C |= 4;
                break;
        }
    } else {
        osSyncPrintf("camera: room type: prerender\n");
        camera->prevSetting = camera->setting = CAM_SET_FREE0;
        camera->unk_14C &= ~0x4;
    }
}

void Camera_Stub80058140(Camera* camera) {
}

void func_80058148(Camera* camera, Player* player) {
    PosRot playerPosShape;
    VecSph eyeNextAtOffset;
    s32 bgId;
    Vec3f floorPos;
    s32 upXZ;
    f32 playerYOffset;
    Vec3f *eye = &camera->eye;
    Vec3f *at = &camera->at;
    Vec3f *eyeNext = &camera->eyeNext;

    func_8002EF44(&playerPosShape, &player->actor);
    playerYOffset = Player_GetCameraYOffset(player);
    camera->player = player;
    camera->playerPosRot = playerPosShape;
    camera->dist = eyeNextAtOffset.r = 180.0f;
    camera->direction.y = playerPosShape.rot.y;
    eyeNextAtOffset.yaw = BINANG_ROT180(camera->direction.y);
    camera->direction.x = eyeNextAtOffset.pitch = 0x71C;
    camera->direction.z = 0;
    camera->realDir = camera->direction;
    camera->xzSpeed = 0.0f;
    camera->playerPosDelta.y = 0.0f;
    camera->at = playerPosShape.pos;
    camera->at.y += playerYOffset;
    
    {
        camera->posOffset.x = 0;
        camera->posOffset.y = playerYOffset;
        camera->posOffset.z = 0;
    }

    Camera_Vec3fVecSphGeoAdd(eyeNext, at, &eyeNextAtOffset);
    *eye = *eyeNext;
    camera->roll = 0;
    
    {
        upXZ = 0;
        camera->up.z = upXZ;
        camera->up.y = 1.0f;
        camera->up.x = upXZ;
    }

    if (func_80044434(camera, &floorPos, at, &bgId) != BGCHECK_Y_MIN) {
        camera->bgCheckId = bgId;
    }

    camera->waterPrevCamIdx = -1;
    camera->waterPrevCamSetting = -1;
    camera->unk_14C |= 4;

    if (camera == &camera->globalCtx->cameras[0]) {
        sCameraInterfaceFlags = 0xB200;
    } else {
        sCameraInterfaceFlags = 0;
    }
    func_80057FC4(camera);
    camera->unk_14A = 0;
    camera->paramFlags = 0;
    camera->nextCamDataIdx = -1;
    camera->atLERPStepScale = 1.0f;
    Camera_CopyModeValuesToPREG(camera, camera->mode);
    Camera_QRegInit();
    osSyncPrintf(VT_FGCOL(BLUE) "camera: personalize ---" VT_RST "\n");
    if (camera->thisIdx == 0) {
        func_800588B4(camera);
    }
}

s16 Camera_ChangeStatus(Camera* camera, s16 status) {
    CameraModeValue* values;
    CameraModeValue* valueP;
    s32 i;

    if (PREG(82)) {
        osSyncPrintf("camera: change camera status: cond %c%c\n", status == 7 ? 'o' : 'x', camera->status != 7 ? 'o' : 'x');
    }

    if (PREG(82)) {
        osSyncPrintf("camera: res: stat (%d/%d/%d)\n", camera->thisIdx, camera->setting, camera->mode);
    }

    if (status == CAM_STATUS_ACTIVE && camera->status != CAM_STATUS_ACTIVE) {
        // if we're making the camera active, but it is not already active, update PREG values
        values = sCameraSettings[camera->setting].cameraModes[camera->mode].values;
        for(i = 0; i <sCameraSettings[camera->setting].cameraModes[camera->mode].valueCnt; i++){
            valueP = &values[i];
            PREG(valueP->param) = valueP->val;
            if(PREG(82)){
                osSyncPrintf("camera: change camera status: PREG(%02d) = %d\n", valueP->param, valueP->val);
            }
        }
    }
    camera->status = status;
    return camera->status;
}

#ifdef NON_MATCHING
void Camera_PrintSettings(Camera *camera) {
    char allCamStatus[5];
    char camDataIdx[8];
    char activeCamStatus[5];
    s32 i;
    const char t = ' ';

    if (OREG(0) & 1 && camera->thisIdx == camera->globalCtx->activeCamera && gDbgCamEnabled == 0) {
        for(i = 0; i < ARRAY_COUNT(allCamStatus) - 1; i++){
            if(camera->globalCtx->cameraPtrs[i] == NULL){
                activeCamStatus[i] = t;
                allCamStatus[i] = '-';
                break;
            }

            // code is using beql over beq, and loading 0x20 each time.
            switch(camera->globalCtx->cameraPtrs[i]->status){
                default: 
                    activeCamStatus[i] = ' '; 
                    allCamStatus[i] = '*'; 
                    break;
                case CAM_STATUS_CUT: 
                    allCamStatus[i] = 'c';
                    activeCamStatus[i] = ' ';
                    break; 
                case CAM_STATUS_WAIT:
                    allCamStatus[i] = 'w'; 
                    activeCamStatus[i] = ' '; 
                    break; 
                case CAM_STATUS_UNK3: 
                    allCamStatus[i] = 's'; 
                    activeCamStatus[i] = ' '; 
                    break; 
                case CAM_STATUS_ACTIVE:
                    allCamStatus[i] = 'a'; 
                    activeCamStatus[i] = ' '; 
                    break; 
                case CAM_STATUS_UNKT:
                    allCamStatus[i] = 'd'; 
                    activeCamStatus[i] = ' '; 
                    break; 
            }
            
        }

        activeCamStatus[i + 1] = '\0';
        allCamStatus[i + 1] = '\0';
        
        activeCamStatus[camera->globalCtx->activeCamera] = 'a';
        
        func_8006376C(3, 22, 5, allCamStatus);
        func_8006376C(3, 22, 1, activeCamStatus);
        func_8006376C(3, 23, 5, "S:");
        func_8006376C(5, 23, 4, sCameraSettingNames[camera->setting]);
        func_8006376C(3, 24, 5, "M:");
        func_8006376C(5, 24, 4, sCameraModeNames[camera->mode]);
        func_8006376C(3, 25, 5, "F:");
        func_8006376C(5, 25, 4, sCameraFunctionNames[sCameraSettings[camera->setting].cameraModes[camera->mode].funcIdx]);
        
        // there's some ordering issues here.  This might be some kind of macro?
        i = 0;
        if (camera->camDataIdx < 0) {
            camDataIdx[i++] = '-';
        }

        if ((camera->camDataIdx / 10) != 0) {
            camDataIdx[i++] = (i / 10) + '0';
        }

        camDataIdx[i++] = (i % 10) + '0';
        camDataIdx[i++] = t;
        camDataIdx[i++] = t;
        camDataIdx[i++] = t;
        camDataIdx[i++] = t;
        camDataIdx[i++] = '\0';
        func_8006376C(3, 26, 5, "I:");
        func_8006376C(5, 26, 4, camDataIdx);
    }
}
#else
void Camera_PrintSettings(Camera *camera);
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/Camera_PrintSettings.s")
#endif

//#define NON_MATCHING
#ifdef NON_MATCHING
s32 func_800588B4(Camera *camera) {
    f32 waterY;
    s32 waterBoxProp;
    s16 sp32;
    s32 *sp2C;
    f32 temp_f0;
    s16 temp_v0_2;
    s32 temp_a1;
    s16 temp_v0;
    s32 temp_v1;
    u32 phi_v1;
    s32* unk_11C = &camera->waterPrevCamSetting;
    Player* player = camera->player;

    temp_v1 = camera->unk_14C;
    if(!(camera->unk_14C & 2) || sCameraSettings[camera->setting].unk_00 & 0x40000000) {
        return 0;
    }

    if (camera->unk_14C & 0x200) {
        if (player->stateFlags2 & 0x800) {
            Camera_ChangeSettingFlags(camera, CAM_SET_CIRCLE5, 6);
            camera->unk_14C |= (s16)0x8000;
        } else if (camera->unk_14C & (s16)0x8000) {
            Camera_ChangeSettingFlags(camera, *unk_11C, 6);
            camera->unk_14C &= ~((s16)0x8000);
        }
    }
    if (!(camera->unk_14C & (s16)0x8000)) {
        temp_v0 = func_800448CC(camera, &waterY);
        if (temp_v0 == -2) {
            // No camera data idx
            if (!(camera->unk_14C & 0x200)) {
                camera->unk_14C |= 0x200;
                camera->waterYPos = waterY;
                camera->waterPrevCamIdx = camera->camDataIdx;
                camera->waterQuakeId = -1;
            }
            if (camera->playerGroundY != camera->playerPosRot.pos.y) {
                sp32 = camera->bgCheckId;
                camera->bgCheckId = 0x32;
                Camera_ChangeSettingFlags(camera, CAM_SET_NORMAL3, 2);
                *unk_11C = camera->setting;
                camera->bgCheckId = sp32;
                camera->camDataIdx = -2;
            }
        } else if (temp_v0 != -1) {
            // player is in a water box
            if (!(camera->unk_14C & 0x200)) {
                camera->unk_14C |= 0x200;
                camera->waterYPos = waterY;
                camera->waterPrevCamIdx = camera->camDataIdx;
                camera->waterQuakeId = -1;
            }
            if (camera->playerGroundY != camera->playerPosRot.pos.y) {
                sp32 = camera->bgCheckId;
                camera->bgCheckId = 0x32;
                Camera_ChangeDataIdx(camera, temp_v0);
                *unk_11C = camera->setting;
                camera->bgCheckId = sp32;
            }
        } else if (camera->unk_14C & 0x200) {
            // player is out of a water box.
            osSyncPrintf("camera: water: off\n");
            camera->unk_14C &= ~0x200;
            sp32 = camera->bgCheckId;
            camera->bgCheckId = (u16)0x32;
            if (camera->waterPrevCamIdx < 0) {
                func_80057FC4(camera);
                camera->camDataIdx = -1;
            } else {
                Camera_ChangeDataIdx(camera, camera->waterPrevCamIdx);
            }
            camera->bgCheckId = sp32;
        }
    }

    if (waterY = func_800449AC(camera, &camera->eye, &waterBoxProp), waterY != BGCHECK_Y_MIN) {
        camera->waterYPos = waterY;
        if ((camera->unk_14C & 0x100) == 0) {
            camera->unk_14C |= 0100;
            osSyncPrintf("kankyo changed water, sound on\n");
            func_80070600(camera->globalCtx, waterBoxProp);
            camera->unk_150 = 0x50;
        }

        func_800F6828(0x20);
        
        if (PREG(81)) {
            Quake_RemoveFromIdx(camera->waterQuakeId);
            camera->waterQuakeId = -1;
            PREG(81) = 0;
        }

        if ((camera->waterQuakeId == -1) || (Quake_GetCountdown(camera->waterQuakeId) == 0xA)) {
            camera->waterQuakeId = Quake_Add(camera, 5U);
            if (camera->waterQuakeId != 0) {
                Quake_SetSpeed(camera->waterQuakeId, 0x226);
                Quake_SetQuakeValues(camera->waterQuakeId, 1, 1, 0xB4, 0);
                Quake_SetCountdown(camera->waterQuakeId, 0x3E8);
            }
        }
        if (camera->unk_150 > 0) {
            camera->unk_152 |= 8;
            camera->unk_150--;
            return;
        } else if (camera->globalCtx->sceneNum == 0x49) {
            camera->unk_152 |= 0x10;
            return;
        } else {
            camera->unk_152 |= 2;
            return;
        }
    }
    if (camera->unk_14C & 0x100) {
        camera->unk_14C &= ~0x100;
        osSyncPrintf("kankyo changed water off, sound off\n");
        func_800706A0(camera->globalCtx);
        if (camera->waterQuakeId != 0) {
            Quake_RemoveFromIdx(camera->waterQuakeId);
        }
        camera->unk_150 = 0;
        camera->unk_152 = 0;
    }
    func_800F6828(0);
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/code/z_camera/func_800588B4.s")
#endif

/**
 * Sets the room to be hot camera quake flag
*/
s32 Camera_SetRoomHotFlag(Camera* camera) {
    camera->unk_152 &= ~1;
    if (camera->globalCtx->roomCtx.curRoom.unk_02 == 3) {
        camera->unk_152 |= 1;
    }

    return 1;
}

s32 Camera_DbgChangeMode(Camera* camera) {
    s32 changeDir = 0;

    if (gDbgCamEnabled == 0 && camera->globalCtx->activeCamera == 0) {
        if (CHECK_PAD(D_8015BD7C->state.input[2].press, U_CBUTTONS)) {
            osSyncPrintf("attention sound URGENCY\n");
            func_80078884(NA_SE_SY_ATTENTION_URGENCY);
        }
        if (CHECK_PAD(D_8015BD7C->state.input[2].press, D_CBUTTONS)) {
            osSyncPrintf("attention sound NORMAL\n");
            func_80078884(NA_SE_SY_ATTENTION_ON);
        }

        if (CHECK_PAD(D_8015BD7C->state.input[2].press, R_CBUTTONS)) {
            changeDir = 1;
        }
        if (CHECK_PAD(D_8015BD7C->state.input[2].press, L_CBUTTONS)) {
            changeDir = -1;
        }
        if (changeDir != 0) {
            sDbgModeIdx = (sDbgModeIdx + changeDir) % 6;
            if (Camera_ChangeSetting(camera, D_8011DAFC[sDbgModeIdx]) > 0) {
                osSyncPrintf("camera: force change SET to %s!\n", sCameraSettingNames[D_8011DAFC[sDbgModeIdx]]);
            }
        }
    }
    return true;
}

void func_80058E8C(Camera *camera) {
    static s16 D_8011DB08 = 0x3F0;
    static s16 D_8011DB0C = 0x156;
    s32 pad3;
    f32 sp60;
    s32 pad;
    s32 pad1;
    s32 pad4;
    f32 phi_f2;
    s32 pad2;
    f32 phi_f0;
    f32 phi_f20;
    f32 sp40;
    f32 sp3C;
    f32 sp38;
    f32 sp34;

    if (camera->unk_152 != 0) {
        if (camera->unk_152 & 4) {
            phi_f0 = 0.0f;
            phi_f2 = 170.0f;
            sp3C = 0.01f;
            sp40 = -0.01f;
            sp38 = 0.0f;
            sp34 = 0.6f;
            phi_f20 = camera->unk_150 / 60.0f;
            sp60 = 1.0f;
        } else if (camera->unk_152 & 8) {
            phi_f0 = 248.0f;
            phi_f2 = -90.0f;
            sp38 = 0.2f;
            sp34 = 0.2f;
            sp40 = -0.3f;
            sp3C = 0.3f;
            phi_f20 = camera->unk_150 / 80.0f;
            sp60 = 1.0f;
        } else if (camera->unk_152 & 2) {
            phi_f0 = 359.2f;
            phi_f2 = -18.5f;
            sp40 = 0.09f;
            sp38 = 0.01f;
            sp3C = 0.09f;
            sp34 = 0.08f;
            phi_f20 = (((camera->waterYPos - camera->eye.y) > 150.0f ? 1.0f : (camera->waterYPos - camera->eye.y) / 150.0f) * 0.45f) + (camera->speedRatio * 0.45f);
            sp60 = phi_f20;
        } else if (camera->unk_152 & 1) {
            // hot room flag
            phi_f2 = 150.0f;
            phi_f0 = 0.0f;
            sp3C = 0.01f;
            sp38 = 0.01f;
            sp40 = -0.01f;
            sp34 = 0.6f;
            sp60 = 1.0f;
            phi_f20 = 1.0f;

        } else {
            return;
        }
        D_8011DB08 += DEGF_TO_BINANG(phi_f0);
        D_8011DB0C += DEGF_TO_BINANG(phi_f2);
        /* why? */
        Math_Coss(D_8011DB08);
        Math_Sins(D_8011DB08);
        Math_Sins(D_8011DB0C);
        func_800AA76C(&camera->globalCtx->view, 0.0f, 0.0f, 0.0f);
        func_800AA78C(&camera->globalCtx->view, Math_Sins(D_8011DB0C) * (sp40 * phi_f20) + 1.0f,
                                                Math_Coss(D_8011DB0C) * (sp3C * phi_f20) + 1.0f,
                                                Math_Coss(D_8011DB08) * (sp38 * phi_f20) + 1.0f);
        func_800AA7AC(&camera->globalCtx->view, sp34 * sp60);
        camera->unk_14C |= 0x40;
    } else if (camera->unk_14C & 0x40) {
        func_800AA814(&camera->globalCtx->view);
        camera->unk_14C &= ~0x40;
    }
}

Vec3s *Camera_Update(Vec3s *outVec, Camera *camera) {
    static s32 sOOBTimer = 0;

    Vec3f viewAt;
    Vec3f viewEye;
    Vec3f viewUp;
    f32 viewFov;
    Vec3f spAC;
    u32 bgCheckId;
    f32 playerGroundY;
    f32 playerXZSpeed;
    VecSph eyeAtAngle;
    s16 camDataIdx;
    PosRot curPlayerPosRot;
    QuakeCamCalc quake;
    Player *player;

    player = camera->globalCtx->cameraPtrs[0]->player;

    if (R_DBG_CAM_UPDATE) {
        osSyncPrintf("camera: in %x\n", camera);
    }
    
    if (camera->status == CAM_STATUS_CUT) {
        if (R_DBG_CAM_UPDATE) {
            osSyncPrintf("camera: cut out %x\n", camera);
        }
        *outVec = camera->direction;
        return outVec;
    }

    sUpdateCameraDirection = 0;

    if (camera->player != NULL) {
        func_8002EF44(&curPlayerPosRot, &camera->player->actor);
        camera->xzSpeed = playerXZSpeed = OLib_Vec3fDistXZ(&curPlayerPosRot.pos, &camera->playerPosRot.pos);
        
        camera->speedRatio = OLib_ClampMaxDist(playerXZSpeed / (func_8002DCE4(camera->player) * PCT(OREG(8))), 1.0f);
        camera->playerPosDelta.x = curPlayerPosRot.pos.x - camera->playerPosRot.pos.x;
        camera->playerPosDelta.y = curPlayerPosRot.pos.y - camera->playerPosRot.pos.y;
        camera->playerPosDelta.z = curPlayerPosRot.pos.z - camera->playerPosRot.pos.z;
        spAC = curPlayerPosRot.pos;
        spAC.y += Player_GetCameraYOffset(camera->player);

        // This has to do with out of bounds Camera
        playerGroundY = func_8003CA0C(camera->globalCtx, &camera->globalCtx->colCtx, &playerFloorPoly, &bgCheckId, &camera->player->actor, &spAC);
        if (playerGroundY != BGCHECK_Y_MIN) {
            sOOBTimer = 0;
            camera->unk_108.x = playerFloorPoly->norm.x * COLPOLY_NORM_FRAC;
            camera->unk_108.y = playerFloorPoly->norm.y * COLPOLY_NORM_FRAC;
            camera->unk_108.z = playerFloorPoly->norm.z * COLPOLY_NORM_FRAC;
            camera->bgCheckId = bgCheckId;
            camera->playerGroundY = playerGroundY;
        } else {
            sOOBTimer++;
            if(1){
                camera->unk_108.x = 0.0;
                camera->unk_108.y = 1.0f;
                camera->unk_108.z = 0.0;
            }
        }

        camera->playerPosRot = curPlayerPosRot;
        
        if (sOOBTimer < 200) {
            if (camera->status == CAM_STATUS_ACTIVE) {
                func_800588B4(camera);
                Camera_SetRoomHotFlag(camera);
            }

            if (!(camera->unk_14C & 4)) {
                camera->nextCamDataIdx = -1;
            }

            if ((camera->unk_14C & 1) && (camera->unk_14C & 4) && 
                (!(camera->unk_14C & 0x400)) &&
                (!(camera->unk_14C & 0x200) || (player->currentBoots == 1)) &&
                (!(camera->unk_14C & (s16)0x8000)) && (playerGroundY != BGCHECK_Y_MIN)) {
                    camDataIdx = func_8004479C(camera, &bgCheckId, playerFloorPoly);
                    if (camDataIdx != -1) {
                        camera->nextBGCheckId = bgCheckId;
                        if (bgCheckId == 0x32) {
                            camera->nextCamDataIdx = camDataIdx;
                        }
                    }
            }

            if (camera->nextCamDataIdx != -1 && (fabsf(curPlayerPosRot.pos.y - playerGroundY) < 2.0f) &&
                (!(camera->unk_14C & 0x200) || (player->currentBoots == 1))) {
                camera->bgCheckId = camera->nextBGCheckId;
                Camera_ChangeDataIdx(camera, camera->nextCamDataIdx);
                camera->nextCamDataIdx = -1;
            }
        }
    }
    Camera_PrintSettings(camera);
    Camera_DbgChangeMode(camera);

    if (camera->status == CAM_STATUS_WAIT) {
        if (R_DBG_CAM_UPDATE) {
            osSyncPrintf("camera: wait out %x\n", camera);
        }
        *outVec = camera->direction;
        return outVec;
    }

    camera->unk_14A = 0;
    camera->unk_14C &= ~(0x400 | 0x20);
    camera->unk_14C |= 0x10;

    if (R_DBG_CAM_UPDATE) {
        osSyncPrintf("camera: engine (%d %d %d) %04x \n", camera->setting, camera->mode, sCameraSettings[camera->setting].cameraModes[camera->mode].funcIdx, camera->unk_14C);
    }

    if (sOOBTimer < 200) {
        sCameraFunctions[sCameraSettings[camera->setting].cameraModes[camera->mode].funcIdx](camera);
    } else if (camera->player != NULL) {
        OLib_Vec3fDiffToVecSphGeo(&eyeAtAngle, &camera->at, &camera->eye);
        func_800457A8(camera, &eyeAtAngle, 0.0f, 0);
    }

    if (camera->status == CAM_STATUS_ACTIVE) {
        if ((gSaveContext.gameMode != 0) && (gSaveContext.gameMode != 3)) {
            sCameraInterfaceFlags = 0;
            Camera_UpdateInterface(sCameraInterfaceFlags);
        } else if ((D_8011D3F0 != 0) && (camera->thisIdx == 0)) {
            D_8011D3F0--;
            sCameraInterfaceFlags = 0x3200;
            Camera_UpdateInterface(sCameraInterfaceFlags);
        } else if (camera->globalCtx->transitionMode != 0) {
            sCameraInterfaceFlags = 0xF200;
            Camera_UpdateInterface(sCameraInterfaceFlags);
        } else if (camera->globalCtx->csCtx.state != 0) {
            sCameraInterfaceFlags = 0x3200;
            Camera_UpdateInterface(sCameraInterfaceFlags);
        } else {
            Camera_UpdateInterface(sCameraInterfaceFlags);
        }
    }

    if (R_DBG_CAM_UPDATE) {
        osSyncPrintf("camera: shrink_and_bitem %x(%d)\n", sCameraInterfaceFlags, camera->globalCtx->transitionMode);
    }

    if (R_DBG_CAM_UPDATE) {
        osSyncPrintf("camera: engine (%s(%d) %s(%d) %s(%d)) ok!\n", &sCameraSettingNames[camera->setting], camera->setting, &sCameraModeNames[camera->mode], camera->mode, &sCameraFunctionNames[sCameraSettings[camera->setting].cameraModes[camera->mode].funcIdx], sCameraSettings[camera->setting].cameraModes[camera->mode].funcIdx);
    }

    // enable/disable debug cam
    if (CHECK_PAD(D_8015BD7C->state.input[2].press, START_BUTTON)) {
        gDbgCamEnabled ^= 1;
        if (gDbgCamEnabled) {
            DbgCamera_Enable(&D_8015BD80, camera);
        } else if (camera->globalCtx->csCtx.state != 0) {
            func_80064534(camera->globalCtx, &camera->globalCtx->csCtx);
        }
    }

    // Debug cam update
    if (gDbgCamEnabled) {
        camera->globalCtx->view.fovy = D_8015BD80.fov;
        DbgCamera_Update(&D_8015BD80, camera);
        func_800AA358(&camera->globalCtx->view, &D_8015BD80.eye, &D_8015BD80.at, &D_8015BD80.up);
        if (R_DBG_CAM_UPDATE) {
            osSyncPrintf("camera: debug out\n");
        }
        *outVec = D_8015BD80.unk_10C6;
        return outVec;
    }

    OREG(0) &= ~8;

    if (camera->status == 3) {
        *outVec = camera->direction;
        return outVec;
    }
    
    // setting bgCheckId to the ret of Quake_Calc, and checking that 
    // is required, it doesn't make too much sense though.
    if ((bgCheckId = Quake_Calc(camera, &quake), bgCheckId != 0) && (camera->setting != CAM_SET_ITEM2)) {
        viewAt.x = camera->at.x + quake.atOffset.x;
        viewAt.y = camera->at.y + quake.atOffset.y;
        viewAt.z = camera->at.z + quake.atOffset.z;
        viewEye.x = camera->eye.x + quake.eyeOffset.x;
        viewEye.y = camera->eye.y + quake.eyeOffset.y;
        viewEye.z = camera->eye.z + quake.eyeOffset.z;
        OLib_Vec3fDiffToVecSphGeo(&eyeAtAngle, &viewEye, &viewAt);
        Camera_CalcUpFromPitchYawRoll(&viewUp, eyeAtAngle.pitch + quake.rotZ, eyeAtAngle.yaw + quake.unk_1A, camera->roll);
        viewFov = camera->fov + BINANG_TO_DEGF(quake.zoom);
    } else {
        viewAt = camera->at;
        viewEye = camera->eye;
        OLib_Vec3fDiffToVecSphGeo(&eyeAtAngle, &viewEye, &viewAt);
        Camera_CalcUpFromPitchYawRoll(&viewUp, eyeAtAngle.pitch, eyeAtAngle.yaw, camera->roll);
        viewFov = camera->fov;
    }

    if (camera->paramFlags & 4) {
        camera->paramFlags &= ~4;
        viewUp = camera->up;
    } else {
        camera->up = viewUp;
    }

    camera->skyboxOffset = quake.eyeOffset;

    func_80058E8C(camera);
    if ((camera->globalCtx->sceneNum == SCENE_SPOT00) && (camera->fov < 59.0f)) {
        View_SetScale(&camera->globalCtx->view, 0.79f);
    } else {
        View_SetScale(&camera->globalCtx->view, 1.0f);
    }
    camera->globalCtx->view.fovy = viewFov;
    func_800AA358(&camera->globalCtx->view, &viewEye, &viewAt, &viewUp);
    camera->realDir.x = eyeAtAngle.pitch;
    camera->realDir.y = eyeAtAngle.yaw;
    camera->realDir.z = 0;
    if (sUpdateCameraDirection == 0) {
        camera->direction.x = eyeAtAngle.pitch;
        camera->direction.y = eyeAtAngle.yaw;
        camera->direction.z = 0;
    }
    if (PREG(81)) {
        osSyncPrintf("dir  (%d) %d(%f) %d(%f) 0(0) \n", sUpdateCameraDirection, camera->direction.x, BINANG_TO_DEGF(camera->direction.x), camera->direction.y, BINANG_TO_DEGF(camera->direction.y));
        osSyncPrintf("real (%d) %d(%f) %d(%f) 0(0) \n", sUpdateCameraDirection, camera->realDir.x, BINANG_TO_DEGF(camera->realDir.x), camera->realDir.y, BINANG_TO_DEGF(camera->realDir.y));
    }
    if (camera->timer != -1 && CHECK_PAD(D_8015BD7C->state.input[0].press, R_JPAD)) {
        camera->timer = 0;
    }
    if (R_DBG_CAM_UPDATE) {
        osSyncPrintf("camera: out (%f %f %f) (%f %f %f)\n", camera->at.x, camera->at.y, camera->at.z, camera->eye.x, camera->eye.y, camera->eye.z);
        osSyncPrintf("camera: dir (%f %d(%f) %d(%f)) (%f)\n", eyeAtAngle.r, eyeAtAngle.pitch, BINANG_TO_DEGF(eyeAtAngle.pitch), eyeAtAngle.yaw, BINANG_TO_DEGF(eyeAtAngle.yaw), camera->fov);
        if (camera->player != NULL) {
            osSyncPrintf("camera: foot(%f %f %f) dist (%f)\n", curPlayerPosRot.pos.x, curPlayerPosRot.pos.y, curPlayerPosRot.pos.z, camera->dist);
        }
    }

    *outVec = camera->direction;
    return outVec;
}

/**
 * When the camera's timer is 0, change the camera to it's parent
*/
void Camera_Finish(Camera* camera) {
    Camera* defaultCam = camera->globalCtx->cameraPtrs[0];
    Player* player = (Player*)camera->globalCtx->actorCtx.actorList[2].first;

    if (camera->timer == 0) {
        Gameplay_ChangeCameraStatus(camera->globalCtx, camera->parentCamIdx, 7);

        if ((camera->parentCamIdx == 0) && (camera->unk_168 != 0)) {
            player->actor.freezeTimer = 0;
            player->stateFlags1 &= ~0x20000000;

            if (player->action != 0) {
                func_8002DF54(camera->globalCtx, &player->actor, 7);
                osSyncPrintf("camera: player demo end!!\n");
            }

            defaultCam->unk_14C |= 8;
        }

        if (camera->globalCtx->cameraPtrs[camera->childCamIdx]->parentCamIdx == camera->thisIdx) {
            camera->globalCtx->cameraPtrs[camera->childCamIdx]->parentCamIdx = camera->parentCamIdx;
        }

        if (camera->globalCtx->cameraPtrs[camera->parentCamIdx]->childCamIdx == camera->thisIdx) {
            camera->globalCtx->cameraPtrs[camera->parentCamIdx]->childCamIdx = camera->childCamIdx;
        }

        if (camera->globalCtx->cameraPtrs[camera->parentCamIdx]->thisIdx == 0) {
            camera->globalCtx->cameraPtrs[camera->parentCamIdx]->animState = 0;
        }

        camera->parentCamIdx = 0;
        camera->childCamIdx = camera->parentCamIdx;
        camera->timer = -1;
        camera->globalCtx->envCtx.unk_E1 = 0;

        Gameplay_ClearCamera(camera->globalCtx, camera->thisIdx);
    }
}

s32 func_8005A02C(Camera* camera) {
    camera->unk_14C |= 0xC;
    camera->unk_14C &= ~(0x1000 | 0x8);
    return true;
}

s32 Camera_ChangeMode(Camera *camera, s16 mode, u8 flags) {
    static s32 D_8011DB14 = 0;

    if (QREG(89)) {
        osSyncPrintf("+=+(%d)+=+ recive request -> %s\n", camera->globalCtx->state.frames, sCameraModeNames[mode]);
    }

    if (camera->unk_14C & 0x20 && flags == 0) {
        camera->unk_14A |= 0x20;
        return -1;
    }

    if (!((sCameraSettings[camera->setting].unk_00 & 0x3FFFFFFF) & (1 << mode))) {
        if (mode == CAM_MODE_SUBJECT) {
            osSyncPrintf("camera: error sound\n");
            func_80078884(NA_SE_SY_ERROR);
        }

        if (camera->mode != CAM_MODE_NORMAL) {
            osSyncPrintf(VT_COL(YELLOW, BLACK) "camera: change camera mode: force NORMAL: %s %s refused\n" VT_RST, sCameraSettingNames[camera->setting], sCameraModeNames[mode]);
            camera->mode = CAM_MODE_NORMAL;
            Camera_CopyModeValuesToPREG(camera, camera->mode);
            func_8005A02C(camera);
            return 0xC0000000 | mode;
        } else {
            camera->unk_14A |= 0x20;
            camera->unk_14A |= 2;
            return 0;
        }
    } else {
        if (mode == camera->mode) {
            if (flags == 0) {
                camera->unk_14A |= 0x20;
                camera->unk_14A |= 2;
                return -1;
            }
        }
        camera->unk_14A |= 0x20;
        camera->unk_14A |= 2;
        Camera_CopyModeValuesToPREG(camera, mode);
        D_8011DB14 = 0;
        switch(mode){
            case 6:
                D_8011DB14 = 0x20;
                break;
            case 4:
                D_8011DB14 = 4;
                break;
            case 2:
                if (camera->target != NULL && camera->target->id != ACTOR_EN_BOOM) {
                    D_8011DB14 = 8;
                }
                break;
            case 1:
            case 3:
            case 8:
            case 15:
            case 19:
                D_8011DB14 = 2;
                break;
        }

        switch(camera->mode){
            case 6:
                if (D_8011DB14 & 0x20) {
                    camera->animState = 0xA;
                }
                break;
            case 1:
                if (D_8011DB14 & 0x10) {
                    camera->animState = 0xA;
                }
                D_8011DB14 |= 1;
                break;
            case 17:
                D_8011DB14 |= 1;
                break;
            case 2:
                if (D_8011DB14 & 8) {
                    camera->animState = 0xA;
                }
                D_8011DB14 |= 1;
                break;
            case 4:
                if (D_8011DB14 & 4) {
                    camera->animState = 0xA;
                }
                D_8011DB14 |= 1;
                break;
            case 8:
            case 15:
            case 19:
                D_8011DB14 |= 1;
                break;
            case 0:
                if (D_8011DB14 & 0x10) {
                    camera->animState = 0xA;
                }
                break;
        }
        D_8011DB14 &= ~0x10;
        if (camera->status == CAM_STATUS_ACTIVE) {
            switch(D_8011DB14){
                case 1:
                    func_80078884(0);
                    break;
                case 2:
                    if (camera->globalCtx->roomCtx.curRoom.unk_03 == 1) {
                        func_80078884(NA_SE_SY_ATTENTION_URGENCY);
                    } else {
                        func_80078884(NA_SE_SY_ATTENTION_ON);
                    }
                    break;
                case 4:
                    func_80078884(NA_SE_SY_ATTENTION_URGENCY);
                    break;
                case 8:
                    func_80078884(NA_SE_SY_ATTENTION_ON);
                    break;
            }
        }
        func_8005A02C(camera);
        camera->mode = mode;
        return 0x80000000 | mode;
    }
}

s32 Camera_ChangeModeDefaultFlags(Camera* camera, s16 mode) {
    return Camera_ChangeMode(camera, mode, 0);
}

s32 Camera_CheckValidMode(Camera* camera, s16 mode) {
    if (QREG(89) != 0) {
        osSyncPrintf("+=+=+=+ recive asking -> %s (%s)\n", sCameraModeNames[mode],
                     sCameraSettingNames[camera->setting]);
    }
    if (!(sCameraSettings[camera->setting].validModes & (1 << mode))) {
        return 0;
    } else if (mode == camera->mode) {
        return -1;
    } else {
        return mode | 0x80000000;
    }
}

s16 Camera_ChangeSettingFlags(Camera *camera, s16 setting, s16 flags) {
    if ((camera->unk_14A & 1) != 0) {
        if ((u32) ((u32) (sCameraSettings[camera->setting].unk_00 & 0xF000000) >> 0x18) >= (u32) ((u32) (sCameraSettings[setting].unk_00 & 0xF000000) >> 0x18)) {
            camera->unk_14A |= 0x10;
            return -2;
        }
    }
    if ((setting == 0x35) || (setting == 0x36)) {
        if (gSaveContext.linkAge == 0) {
            if (camera->globalCtx->sceneNum == 0x56) {
                camera->unk_14A |= 0x10;
                return -5;
            }
        }
    }

    if (setting == CAM_SET_NONE || setting >= CAM_SET_MAX) {
        osSyncPrintf("\x1b[41;37mcamera: error: illegal camera set (%d) !!!!\n\x1b[m", setting);
        return -0x63;
    }

    if (setting == camera->setting) {
        if ((flags & 1) == 0) {
            camera->unk_14A |= 0x10;
            if ((flags & 2) == 0) {
                camera->unk_14A |= 1;
            }
            return -1;
        }
    }

    camera->unk_14A |= 0x10;
    if ((flags & 2) == 0) {
        camera->unk_14A |= 1;
    }

    camera->unk_14C |= 0xC;
    camera->unk_14C &= ~0x1008;

    if (!(sCameraSettings[camera->setting].unk_00 & 0x40000000)) {
        camera->prevSetting = camera->setting;
    }
    
    if (flags & 8) {
        if(1){}
        camera->camDataIdx = camera->prevCamDataIdx;
        camera->prevCamDataIdx = -1;
    } else if (!(flags & 4)) {
        if (!(sCameraSettings[camera->setting].unk_00 & 0x40000000)) {
            camera->prevCamDataIdx = camera->camDataIdx;
        }
        camera->camDataIdx = -1;
    }

    camera->setting = setting;
    
    if (Camera_ChangeMode(camera, camera->mode, 1) >= 0) {
        Camera_CopyModeValuesToPREG(camera, camera->mode);
    }
    
    osSyncPrintf("\x1b[1m%06u:\x1b[m camera: change camera[%d] set %s\n", camera->globalCtx->state.frames, camera->thisIdx, sCameraSettingNames[camera->setting]);
    
    return setting;
}

s32 Camera_ChangeSetting(Camera* camera, s16 setting) {
    return Camera_ChangeSettingFlags(camera, setting, 0);
}

s32 Camera_ChangeDataIdx(Camera *camera, s32 camDataIdx) {
    s16 newCameraSetting;
    s16 settingChangeSuccessful;

    if (camDataIdx == -1 || camDataIdx == camera->camDataIdx) {
        camera->unk_14A |= 0x40;
        return -1;
    }

    if ((camera->unk_14A & 0x40) == 0) {
        newCameraSetting = Camera_GetCamDataSetting(camera, camDataIdx);
        camera->unk_14A |= 0x40;
        settingChangeSuccessful = Camera_ChangeSettingFlags(camera, newCameraSetting, 5) >= 0;
        if (settingChangeSuccessful || sCameraSettings[camera->setting].unk_00 & 0x80000000) {
            camera->camDataIdx = camDataIdx;
            camera->unk_14A |= 4;
            Camera_CopyModeValuesToPREG(camera, camera->mode);
        } else if (settingChangeSuccessful < -1) {
            // @bug: This condition can never happen since settingChangeSuccesful is only ever 0 or 1.
            osSyncPrintf(VT_COL(RED, WHITE) "camera: error: illegal camera ID (%d) !! (%d|%d|%d)\n" VT_RST, camDataIdx, camera->thisIdx, 0x32, newCameraSetting);
        }
        return 0x80000000 | camDataIdx;
    }
}

Vec3s* Camera_GetDir(Vec3s* dst, Camera* camera) {
    if (gDbgCamEnabled != 0) {
        *dst = D_8015BD80.unk_10C6;
        return dst;
    } else {
        *dst = camera->direction;
        return dst;
    }
}

s16 Camera_GetDirPitch(Camera* camera){
    Vec3s dir;
    Camera_GetDir(&dir, camera);
    return dir.x;
}

s16 Camera_GetDirYaw(Camera* camera) {
    Vec3s dir;

    Camera_GetDir(&dir, camera);
    return dir.y;
}

Vec3s* Camera_GetRealDir(Vec3s* dst, Camera* camera) {
    if (gDbgCamEnabled != 0) {
        *dst = D_8015BD80.unk_10C6;
        return dst;
    } else {
        *dst = camera->realDir;
        return dst;
    }
}

s16 Camera_GetRealDirPitch(Camera* camera) {
    Vec3s realDir;

    Camera_GetRealDir(&realDir, camera);
    return realDir.x;
}

s16 Camera_GetRealDirYaw(Camera* camera) {
    Vec3s realDir;

    Camera_GetRealDir(&realDir, camera);
    return realDir.y;
}

s32 func_8005AA1C(Camera* camera, s32 arg1, s16 y, s32 countdown) {
    s16 quakeIdx;

    quakeIdx = Quake_Add(camera, 3);
    if (quakeIdx == 0) {
        return 0;
    }
    Quake_SetSpeed(quakeIdx, 0x61A8);
    Quake_SetQuakeValues(quakeIdx, y, 0, 0, 0);
    Quake_SetCountdown(quakeIdx, countdown);
    return 1;
}

s32 Camera_SetParam(Camera* camera, s32 param, void* value) {
    s32 pad[3];
    if (value != NULL) {
        switch (param) {
            case 1:
                camera->paramFlags &= ~(0x10 | 0x8 | 0x1);
                camera->at = *(Vec3f*)value;
                break;
            case 16:
                camera->paramFlags &= ~(0x10 | 0x8 | 0x1);
                camera->targetPosRot.pos = *(Vec3f*)value;
                break;
            case 8:
                if (camera->setting == CAM_SET_DEMOC || camera->setting == CAM_SET_DEMO4) {
                    break;
                }
                camera->target = (Actor*)value;
                camera->paramFlags &= ~(0x10 | 0x8 | 0x1);
                break;
            case 2:
                 camera->eye = camera->eyeNext = *(Vec3f*)value;
                break;
            case 4:
                camera->up = *(Vec3f*)value;
                break;
            case 0x40:
                camera->roll = DEGF_TO_BINANG(*(f32*)value);
                break;
            case 0x20:
                camera->fov = *(f32*)value;
                break;
            default:
                return false;
        }
        camera->paramFlags |= param;
    } else {
        return false;
    }
    return true;
}

s32 Camera_UnsetParam(Camera* camera, s16 param) {
    camera->paramFlags &= ~param;
    return true;
}

s32 func_8005AC48(Camera* camera, s16 arg1) {
    camera->unk_14C = arg1;
    return true;
}

s32 Camera_ResetAnim(Camera* camera) {
    camera->animState = 0;
    return 1;
}

s32 func_8005AC6C(Camera* camera, CutsceneCameraPoint* atPoints, CutsceneCameraPoint* eyePoints, Player* player,
                  s16 relativeToPlayer) {
    PosRot playerPosRot;

    camera->atPoints = atPoints;
    camera->eyePoints = eyePoints;
    camera->unk_12C = relativeToPlayer;

    if (camera->unk_12C != 0) {
        camera->player = player;
        func_8002EF44(&playerPosRot, &player->actor);
        camera->playerPosRot = playerPosRot;

        camera->nextCamDataIdx = -1;
        camera->xzSpeed = 0.0f;
        camera->speedRatio = 0.0f;
    }

    return 1;
}

s16 func_8005ACFC(Camera* camera, s16 arg1) {
    camera->unk_14C |= arg1;
    return camera->unk_14C;
}

s16 func_8005AD1C(Camera* camera, s16 arg1) {
    camera->unk_14C &= ~arg1;
    return camera->unk_14C;
}

s32 Camera_ChangeDoorCam(Camera* camera, Actor* doorActor, s16 camDataIdx, f32 arg3, s16 timer1, s16 timer2, s16 timer3) {
    PersonalizeParams* params = &camera->params.personalize;

    if ((camera->setting == CAM_SET_DEMO4) || (camera->setting == CAM_SET_DOORC)) {
        return 0;
    }

    params->actor = doorActor;
    params->timer1 = timer1;
    params->timer2 = timer2;
    params->timer3 = timer3;
    params->camDataIdx = camDataIdx;

    if (camDataIdx == -99) {
        Camera_CopyModeValuesToPREG(camera, camera->mode);
        return -99;
    }

    if (camDataIdx == -1) {
        Camera_ChangeSetting(camera, CAM_SET_DOORC);
        osSyncPrintf(".... change default door camera (set %d)\n", CAM_SET_DOORC);
    } else {
        s32 setting = Camera_GetCamDataSetting(camera, camDataIdx);
        camera->unk_14A |= 0x40;

        if (Camera_ChangeSetting(camera, setting) >= 0) {
            camera->camDataIdx = camDataIdx;
            camera->unk_14A |= 4;
        }

        osSyncPrintf("....change door camera ID %d (set %d)\n", camera->camDataIdx, camera->setting);
    }

    Camera_CopyModeValuesToPREG(camera, camera->mode);
    return -1;
}

s32 Camera_Copy(Camera* dstCamera, Camera* srcCamera) {
    s32 pad;

    dstCamera->posOffset.x = 0.0f;
    dstCamera->posOffset.y = 0.0f;
    dstCamera->posOffset.z = 0.0f;
    dstCamera->atLERPStepScale = 0.1f;
    dstCamera->at = srcCamera->at;

    dstCamera->eye = dstCamera->eyeNext = srcCamera->eye;

    dstCamera->dist = OLib_Vec3fDist(&dstCamera->at, &dstCamera->eye);
    dstCamera->fov = srcCamera->fov;
    dstCamera->roll = srcCamera->roll;
    func_80043B60(dstCamera);

    if (dstCamera->player != NULL) {
        func_8002EF14(&dstCamera->playerPosRot, &dstCamera->player->actor);
        dstCamera->posOffset.x = dstCamera->at.x - dstCamera->playerPosRot.pos.x;
        dstCamera->posOffset.y = dstCamera->at.y - dstCamera->playerPosRot.pos.y;
        dstCamera->posOffset.z = dstCamera->at.z - dstCamera->playerPosRot.pos.z;
        dstCamera->dist = OLib_Vec3fDist(&dstCamera->playerPosRot.pos, &dstCamera->eye);
        dstCamera->xzOffsetUpdateRate = 1.0f;
        dstCamera->yOffsetUpdateRate = 1.0f;
    }
    return true;
}

s32 Camera_GetDbgCamEnabled() {
    return gDbgCamEnabled;
}

Vec3f* Camera_GetSkyboxOffset(Vec3f* dst, Camera* camera) {
    *dst = camera->skyboxOffset;
    return dst;
}

void Camera_SetCameraData(Camera* camera, s16 setDataFlags, CutsceneCameraPoint* atPoints, CutsceneCameraPoint* eyePoints,
                          s16 relativeToPlayer, s16 arg5, UNK_TYPE arg6) {
    if (setDataFlags & 0x1) {
        camera->atPoints = atPoints;
    }

    if (setDataFlags & 0x2) {
        camera->eyePoints = eyePoints;
    }

    if (setDataFlags & 0x4) {
        camera->unk_12C = relativeToPlayer;
    }

    if (setDataFlags & 0x8) {
        camera->unk_12E = arg5;
    }

    if (setDataFlags & 0x10) {
        osSyncPrintf(VT_COL(RED, WHITE) "camera: setCameraData: last argument not alive!\n" VT_RST);
    }
}

s32 Camera_QRegInit() {
    if (!R_RELOAD_CAM_PARAMS) {
        QREG(2) = 1;
        QREG(10) = -1;
        QREG(11) = 100;
        QREG(12) = 80;
        QREG(20) = 90;
        QREG(21) = 10;
        QREG(22) = 10;
        QREG(23) = 50;
        QREG(24) = 6000;
        QREG(25) = 240;
        QREG(26) = 40;
        QREG(27) = 85;
        QREG(28) = 55;
        QREG(29) = 87;
        QREG(30) = 23;
        QREG(31) = 20;
        QREG(32) = 4;
        QREG(33) = 5;
        QREG(50) = 1;
        QREG(51) = 20;
        QREG(52) = 200;
        QREG(53) = 1;
        QREG(54) = 15;
        QREG(55) = 60;
        QREG(56) = 15;
        QREG(57) = 30;
        QREG(58) = 0;
    }

    QREG(65) = 50;
    return true;
}

s32 func_8005B198() {
    return D_8011D3AC;
}

s16 func_8005B1A4(Camera* camera) {
    camera->unk_14C |= 0x8;

    if ((camera->thisIdx == 0) && (camera->globalCtx->activeCamera != 0)) {
        camera->globalCtx->cameraPtrs[camera->globalCtx->activeCamera]->unk_14C |= 0x8;
        return camera->globalCtx->activeCamera;
    }

    return camera->thisIdx;
}
