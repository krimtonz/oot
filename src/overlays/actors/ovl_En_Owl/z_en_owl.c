#include "vt.h"
#include "z_en_owl.h"

#define FLAGS 0x00000019

#define THIS ((EnOwl*)thisx)

extern AnimationHeader D_0600C1C4;
extern CsCmdActorAction D_0201E6A0;
extern CsCmdActorAction D_0201B0C0;
extern AnimationHeader D_06001168;
extern SkeletonHeader D_0600C0E8;
extern SkeletonHeader D_060100B0;
extern AnimationHeader D_060015CC;
extern AnimationHeader D_0600C8A0;
extern AnimationHeader D_0600C684;

void EnOwl_Init(Actor* thisx, GlobalContext* globalCtx);
void EnOwl_Destroy(Actor* thisx, GlobalContext* globalCtx);
void EnOwl_Update(Actor* thisx, GlobalContext* globalCtx);
void EnOwl_Draw(Actor* thisx, GlobalContext* globalCtx);
void EnOwl_ChangeMode(EnOwl* this, EnOwlActionFunc, OwlFunc, SkelAnime*, AnimationHeader*, f32);
void EnOwl_WaitDefault(EnOwl* this, GlobalContext* globalCtx);
void func_80ACC540(EnOwl* this);
void EnOwl_WaitOutsideKokiri(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitHyruleCastle(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitKakariko(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitGerudo(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitLakeHylia(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitZoraRiver(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitHyliaShortcut(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitDeathMountainShortcut(EnOwl* this, GlobalContext* globalCtx);
void func_80ACB3E0(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitLWPreSaria(EnOwl* this, GlobalContext* globalCtx);
void EnOwl_WaitLWPostSaria(EnOwl* this, GlobalContext* globalCtx);
void func_80ACD4D4(EnOwl* this, GlobalContext* globalCtx);
void func_80ACD130(EnOwl* this, GlobalContext* globalCtx, s32 arg2);
void func_80ACBAB8(EnOwl* this, GlobalContext* globalCtx);
void func_80ACD2CC(EnOwl* this, GlobalContext* globalCtx);
void func_80ACAA54(EnOwl* this, GlobalContext* globalCtx);
void func_80ACAC6C(EnOwl* this, GlobalContext* globalCtx);
void func_80ACADF0(EnOwl* this, GlobalContext* globalCtx);
void func_80ACAF74(EnOwl* this, GlobalContext* globalCtx);
void func_80ACC30C(EnOwl* this, GlobalContext* globalCtx);
void func_80ACB4FC(EnOwl* this, GlobalContext* globalCtx);
void func_80ACB680(EnOwl* this, GlobalContext* globalCtx);
void func_80ACC460(EnOwl* this);
void func_80ACBEA0(EnOwl*, GlobalContext*);

typedef enum {
    /* 0x00 */ OWL_DEFAULT,
    /* 0x01 */ OWL_OUTSIDE_KOKIRI,
    /* 0x02 */ OWL_HYRULE_CASTLE,
    /* 0x03 */ OWL_KAKARIKO,
    /* 0x04 */ OWL_HYLIA_GERUDO,
    /* 0x05 */ OWL_LAKE_HYLIA,
    /* 0x06 */ OWL_ZORA_RIVER,
    /* 0x07 */ OWL_HYLIA_SHORTCUT,
    /* 0x08 */ OWL_DEATH_MOUNTAIN,
    /* 0x09 */ OWL_DEATH_MOUNTAIN2,
    /* 0x0A */ OWL_DESSERT_COLOSSUS,
    /* 0x0B */ OWL_LOST_WOODS_PRESARIA,
    /* 0x0C */ OWL_LOST_WOODS_POSTSARIA
} EnOwlType;

typedef enum {
    /* 0x00 */ OWL_REPEAT,
    /* 0x01 */ OWL_OK,
} EnOwlMessageChoice;

const ActorInit En_Owl_InitVars = {
    ACTOR_EN_OWL,
    ACTORTYPE_NPC,
    FLAGS,
    OBJECT_OWL,
    sizeof(EnOwl),
    (ActorFunc)EnOwl_Init,
    (ActorFunc)EnOwl_Destroy,
    (ActorFunc)EnOwl_Update,
    (ActorFunc)EnOwl_Draw,
};

ColliderCylinderInit sOwlCylinderInit = {
    { COLTYPE_UNK10, 0x00, 0x11, 0x39, 0x10, COLSHAPE_CYLINDER },
    { 0x00, { 0x00000000, 0x00, 0x00 }, { 0xFFCFFFFF, 0x00, 0x00 }, 0x00, 0x01, 0x01 },
    { 30, 40, 0, { 0, 0, 0 } },
};

InitChainEntry sOwlInitChain[] = {
    ICHAIN_VEC3F_DIV1000(scale, 25, ICHAIN_CONTINUE),
    ICHAIN_F32(uncullZoneForward, 1400, ICHAIN_CONTINUE),
    ICHAIN_F32(uncullZoneScale, 2000, ICHAIN_CONTINUE),
    ICHAIN_F32(uncullZoneDownward, 2400, ICHAIN_STOP),
};

void EnOwl_Init(Actor* thisx, GlobalContext* globalCtx) {
    EnOwl* this = THIS;
    ColliderCylinder* collider;
    s32 owlType;
    s32 switchFlag;

    Actor_ProcessInitChain(&this->actor, sOwlInitChain);
    ActorShape_Init(&this->actor.shape, 0, ActorShadow_DrawFunc_Circle, 36.0f);
    SkelAnime_InitFlex(globalCtx, &this->skelAnime, &D_0600C0E8, &D_060015CC, this->jointTable, this->morphTable, 21);
    SkelAnime_InitFlex(globalCtx, &this->skelAnime2, &D_060100B0, &D_0600C8A0, this->jointTable2, this->morphTable2,
                       16);
    Collider_InitCylinder(globalCtx, &this->collider);
    Collider_SetCylinder(globalCtx, &this->collider, &this->actor, &sOwlCylinderInit);
    this->actor.colChkInfo.mass = 0xFF;
    this->actor.minVelocityY = -10.0f;
    this->actor.unk_4C = 500.0f;
    EnOwl_ChangeMode(this, EnOwl_WaitDefault, func_80ACC540, &this->skelAnime2, &D_0600C8A0, 0.0f);
    this->actionFlags = this->unk_406 = this->unk_409 = 0;
    this->unk_405 = 4;
    this->unk_404 = this->unk_407 = 0;
    this->unk_408 = 4;
    owlType = (this->actor.params & 0xFC0) >> 6;
    switchFlag = (this->actor.params & 0x3F);
    if (this->actor.params == 0xFFF) {
        owlType = 1;
        switchFlag = 0x20;
    }
    osSyncPrintf(VT_FGCOL(CYAN) " 会話フクロウ %4x no = %d, sv = %d\n" VT_RST, this->actor.params, owlType,
                 switchFlag); // conversation owl %4x no = %d, sv = %d

    if ((owlType != OWL_DEFAULT) && (switchFlag < 0x20) && Flags_GetSwitch(globalCtx, switchFlag)) {
        osSyncPrintf("savebitでフクロウ退避\n"); // Save owl with savebit
        Actor_Kill(&this->actor);
        return;
    }

    this->unk_3EE = 0;
    this->unk_400 = this->actor.posRot.rot.y;

    switch (owlType) {
        case OWL_DEFAULT:
            this->actionFunc = EnOwl_WaitDefault;
            this->actor.uncullZoneForward = 4000.0f;
            this->unk_40A = 0;
            break;
        case OWL_OUTSIDE_KOKIRI:
            this->actionFunc = EnOwl_WaitOutsideKokiri;
            break;
        case OWL_HYRULE_CASTLE:
            this->actionFlags |= 2;
            this->unk_3EE = 0x20;
            this->actionFunc = EnOwl_WaitHyruleCastle;
            break;
        case OWL_KAKARIKO:
            if (gSaveContext.eventChkInf[4] & 1) {
                // has zelda's letter
                osSyncPrintf("フクロウ退避\n"); // Owl evacuation
                Actor_Kill(&this->actor);
                return;
            }

            this->actionFunc = EnOwl_WaitKakariko;
            break;
        case OWL_HYLIA_GERUDO:
            if (gSaveContext.eventChkInf[4] & 8) {
                // has ocarina of time
                osSyncPrintf("フクロウ退避\n"); // Owl evacuation
                Actor_Kill(&this->actor);
                return;
            }
            this->actionFunc = EnOwl_WaitGerudo;
            break;
        case OWL_LAKE_HYLIA:
            this->actionFunc = EnOwl_WaitLakeHylia;
            break;
        case OWL_ZORA_RIVER:
            if ((gSaveContext.eventChkInf[3] & 0x200) || !(gSaveContext.eventChkInf[4] & 1)) {
                // opened zora's domain or has zelda's letter
                osSyncPrintf("フクロウ退避\n"); // Owl evacuation
                Actor_Kill(&this->actor);
                return;
            }

            this->actionFunc = EnOwl_WaitZoraRiver;
            break;
        case OWL_HYLIA_SHORTCUT:
            this->actionFunc = EnOwl_WaitHyliaShortcut;
            Flags_UnsetSwitch(globalCtx, 0x23);
            return;
        case OWL_DEATH_MOUNTAIN:
            this->actionFunc = EnOwl_WaitDeathMountainShortcut;
            break;
        case OWL_DEATH_MOUNTAIN2:
            this->actionFunc = EnOwl_WaitDeathMountainShortcut;
            break;
        case OWL_DESSERT_COLOSSUS:
            this->actionFunc = func_80ACB3E0;
            break;
        case OWL_LOST_WOODS_PRESARIA:
            if (!CHECK_QUEST_ITEM(QUEST_SONG_LULLABY)) {
                osSyncPrintf("フクロウ退避\n"); // Owl evacuation
                Actor_Kill(&this->actor);
                return;
            }
            this->actionFunc = EnOwl_WaitLWPreSaria;
            break;
        case OWL_LOST_WOODS_POSTSARIA:
            if (!CHECK_QUEST_ITEM(QUEST_SONG_SARIA)) {
                osSyncPrintf("フクロウ退避\n"); // Owl evacuation
                Actor_Kill(&this->actor);
                return;
            }
            this->actionFunc = EnOwl_WaitLWPostSaria;
            break;
        default:
            // Outside kokiri forest
            osSyncPrintf(VT_FGCOL(CYAN));
            osSyncPrintf("no = %d  \n", owlType);
            osSyncPrintf(
                "未完成のフクロウ未完成のフクロウ未完成のフクロウ\n"); // Unfinished owl unfinished owl unfinished owl
            osSyncPrintf(VT_RST);
            this->actionFlags |= 2;
            this->unk_3EE = 0x20;
            this->actionFunc = EnOwl_WaitOutsideKokiri;
            break;
    }
}

void EnOwl_Destroy(Actor* thisx, GlobalContext* globalCtx) {
    EnOwl* this = THIS;

    Collider_DestroyCylinder(globalCtx, &this->collider);
}

/*
 * Rotates this to the player instance
 */
void EnOwl_LookAtLink(EnOwl* this, GlobalContext* globalCtx) {
    s16 yaw;
    Player* player = PLAYER;

    yaw = Math_Vec3f_Yaw(&this->actor.posRot.pos, &player->actor.posRot.pos);
    this->actor.posRot.rot.y = yaw;
    this->actor.shape.rot.y = yaw;
}

/*
 * Checks if link is within `targetDist` units, initalize the camera for the owl.
 * returns 0 if the link is not within `targetDistance`, returns 1 once link is within
 * the distance, and the camera has been initalized.
 */
s32 EnOwl_CheckInitTalk(EnOwl* this, GlobalContext* globalCtx, u16 textId, f32 targetDist, u16 flags) {
    s32 cameraFlags;
    f32 distCheck;

    if (func_8002F194(&this->actor, globalCtx) != 0) {
        if (this->actor.params == 0xFFF) {
            this->actionFlags |= 0x40;
            cameraFlags = -0x64;
        } else {
            if (Rand_ZeroOne() < 0.5f) {
                cameraFlags = (flags & 1) != 0 ? -0x61 : -0x63;
                this->actionFlags |= 0x40;
            } else {
                cameraFlags = (flags & 1) ? -0x60 : -0x62;
                this->actionFlags &= ~0x40;
            }
        }
        this->cameraIdx = func_800800F8(globalCtx, 0x21FC, cameraFlags, &this->actor, 0);
        return true;
    } else {
        this->actor.textId = textId;
        distCheck = (flags & 2) ? 200.0f : 1000.0f;
        if (this->actor.xzDistFromLink < targetDist) {
            this->actor.flags |= 0x10000;
            func_8002F1C4(&this->actor, globalCtx, targetDist, distCheck, 0);
        }

        return false;
    }
}

s32 func_80ACA558(EnOwl* this, GlobalContext* globalCtx, u16 textId) {
    if (func_8002F194(&this->actor, globalCtx)) {
        return true;
    } else {
        this->actor.textId = textId;
        if (this->actor.xzDistFromLink < 120.0f) {
            func_8002F1C4(&this->actor, globalCtx, 350.0f, 1000.0f, 0);
        }

        return false;
    }
}

void func_80ACA5C8(EnOwl* this) {
    EnOwl_ChangeMode(this, func_80ACBEA0, func_80ACC540, &this->skelAnime, &D_0600C684, 0.0f);
    this->curDlistIdx = 0;
    this->nextDlistIdx = Rand_S16Offset(60, 60);
}

void func_80ACA62C(EnOwl* this, GlobalContext* globalCtx) {
    s32 switchFlag;

    switchFlag = this->actor.params & 0x3F;
    if (switchFlag < 0x20) {
        Flags_SetSwitch(globalCtx, switchFlag);
        osSyncPrintf(VT_FGCOL(CYAN) " Actor_Environment_sw = %d\n" VT_RST, Flags_GetSwitch(globalCtx, switchFlag));
    }
    func_80ACA5C8(this);
}

void func_80ACA690(EnOwl* this, GlobalContext* globalCtx) {
    if ((this->unk_3EE & 0x3F) == 0) {
        func_80ACA62C(this, globalCtx);
    }
}

void func_80ACA6C0(EnOwl* this) {
    if (Rand_CenteredFloat(1.0f) < 0.0f) {
        this->actionFlags |= 0x20;
    } else {
        this->actionFlags &= ~0x20;
    }
}

void func_80ACA71C(EnOwl* this) {
    func_80ACA6C0(this);
    this->unk_3F2 = 0;
    this->actionFlags |= 0x10;
    this->unk_408 = 4;
    this->unk_404 = 0;
    this->unk_406 = 0;
    this->unk_405 = 4;
    this->unk_407 = this->unk_3F2;
}

void func_80ACA76C(EnOwl* this, GlobalContext* globalCtx) {
    func_8002DF54(globalCtx, &this->actor, 8);
    if (func_8002F334(&this->actor, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        func_80ACA62C(this, globalCtx);
        this->actor.flags &= ~0x10000;
    }
}

void func_80ACA7E0(EnOwl* this, GlobalContext* globalCtx) {
    func_8002DF54(globalCtx, &this->actor, 8);
    if (func_8002F334(&this->actor, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        if ((this->unk_3EE & 0x3F) == 0) {
            func_80ACA62C(this, globalCtx);
        } else {
            this->actionFlags &= ~2;
            func_80ACA71C(this);
            this->actionFunc = func_80ACA690;
        }
        this->actor.flags &= ~0x10000;
    }
}

void EnOwl_ConfirmKokiriMessage(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x2065);
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x2067);
                this->actionFunc = func_80ACA76C;
                break;
        }
    }
}

void EnOwl_WaitOutsideKokiri(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x2064, 360.0f, 0) != 0) {
        // Sets BGM
        func_800F5C64(0x5A);

        this->actionFunc = EnOwl_ConfirmKokiriMessage;
        // spoke to owl by lost woods
        gSaveContext.eventChkInf[6] |= 0x8000;
    }
}

void func_80ACA998(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x2069);
                this->actionFunc = func_80ACAA54;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x206B);
                this->actionFunc = func_80ACA7E0;
                break;
        }
        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACAA54(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x206A);
        this->actionFunc = func_80ACA998;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void func_80ACAAC0(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x2069);
        this->actionFunc = func_80ACAA54;
        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitHyruleCastle(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x2068, 540.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACAAC0;
    }
}

void func_80ACAB88(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                // obtained zelda's letter
                if (gSaveContext.eventChkInf[4] & 1) {
                    func_8010B720(globalCtx, 0x206D);
                } else {
                    func_8010B720(globalCtx, 0x206C);
                }
                this->actionFunc = func_80ACAC6C;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x206E);
                this->actionFunc = func_80ACA7E0;
                break;
        }

        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACAC6C(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x206A);
        this->actionFunc = func_80ACAB88;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitKakariko(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x206C, 480.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACAC6C;
    }
}

void func_80ACAD34(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x206F);
                this->actionFunc = func_80ACADF0;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x2070);
                this->actionFunc = func_80ACA7E0;
                break;
        }

        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACADF0(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x206A);
        this->actionFunc = func_80ACAD34;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitGerudo(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x206F, 360.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACADF0;
    }
}

void func_80ACAEB8(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x2071);
                this->actionFunc = func_80ACAF74;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x2072);
                this->actionFunc = func_80ACA7E0;
                break;
        }

        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACAF74(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x206A);
        this->actionFunc = func_80ACAEB8;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitLakeHylia(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x2071, 360.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACAF74;
    }
}

void func_80ACB03C(EnOwl* this, GlobalContext* globalCtx) {
    func_8002DF54(globalCtx, &this->actor, 8);
    if (func_8002F334(&this->actor, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        func_80ACA62C(this, globalCtx);
        this->actor.flags &= ~0x10000;
    }
}

void EnOwl_WaitZoraRiver(EnOwl* this, GlobalContext* globalCtx) {
    u16 textId;

    EnOwl_LookAtLink(this, globalCtx);
    if (CHECK_QUEST_ITEM(QUEST_SONG_SARIA)) {
        if (CHECK_QUEST_ITEM(QUEST_SONG_LULLABY)) {
            textId = 0x4031;
        } else {
            textId = 0x4017;
        }
    } else {
        textId = 0x4002;
    }

    if (EnOwl_CheckInitTalk(this, globalCtx, textId, 360.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACB03C;
    }
}

void func_80ACB148(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8002F334(&this->actor, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        func_80ACA5C8(this);
        this->actionFunc = func_80ACC30C;
        Flags_SetSwitch(globalCtx, 0x23);
    }
}

void EnOwl_WaitHyliaShortcut(EnOwl* this, GlobalContext* globalCtx) {
    u16 textId;
    // Spoke to Owl in Lake Hylia
    if ((gSaveContext.infTable[25] & 0x20) != 0) {
        textId = 0x4004;
    } else {
        textId = 0x4003;
    }

    EnOwl_LookAtLink(this, globalCtx);
    if (func_80ACA558(this, globalCtx, textId) != 0) {
        gSaveContext.infTable[25] |= 0x20;
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACB148;
    }
}

void func_80ACB22C(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8002F334(&this->actor, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        func_80ACA5C8(this);
        this->actionFunc = func_80ACC30C;
    }
}

void func_80ACB274(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8002F334(this, globalCtx) != 0) {
        Audio_SetBGM(0x110000FF);
        this->actionFunc = EnOwl_WaitDeathMountainShortcut;
    }
}

void EnOwl_WaitDeathMountainShortcut(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (!gSaveContext.magicAcquired) {
        if (func_80ACA558(this, globalCtx, 0x3062) != 0) {
            func_800F5C64(0x5A);
            this->actionFunc = func_80ACB274;
            return;
        }
    } else {
        if (func_80ACA558(this, globalCtx, 0x3063) != 0) {
            func_800F5C64(0x5A);
            this->actionFunc = func_80ACB22C;
        }
    }
}

void func_80ACB344(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x607A);
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x607C);
                this->actionFunc = func_80ACA7E0;
                break;
        }
    }
}

void func_80ACB3E0(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x6079, 360.0f, 2) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACB344;
    }
}

void func_80ACB440(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x10C1);
                this->actionFunc = func_80ACB4FC;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x10C3);
                this->actionFunc = func_80ACA7E0;
        }

        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACB4FC(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x10C2);
        this->actionFunc = func_80ACB440;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitLWPreSaria(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x10C0, 190.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACB4FC;
    }
}

void func_80ACB5C4(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 4 && func_80106BC8(globalCtx) != 0) {
        switch (globalCtx->msgCtx.choiceIndex) {
            case OWL_REPEAT:
                func_8010B720(globalCtx, 0x10C5);
                this->actionFunc = func_80ACB680;
                break;
            case OWL_OK:
                func_8010B720(globalCtx, 0x10C7);
                this->actionFunc = func_80ACA7E0;
                break;
        }

        this->actionFlags &= ~2;
        func_80ACA71C(this);
    }
}

void func_80ACB680(EnOwl* this, GlobalContext* globalCtx) {
    if (func_8010BDBC(&globalCtx->msgCtx) == 5 && func_80106BC8(globalCtx) != 0) {
        func_8010B720(globalCtx, 0x10C6);
        this->actionFunc = func_80ACB5C4;
        this->actionFlags |= 2;
        func_80ACA71C(this);
    }
}

void EnOwl_WaitLWPostSaria(EnOwl* this, GlobalContext* globalCtx) {
    EnOwl_LookAtLink(this, globalCtx);
    if (EnOwl_CheckInitTalk(this, globalCtx, 0x10C4, 360.0f, 0) != 0) {
        func_800F5C64(0x5A);
        this->actionFunc = func_80ACB680;
    }
}

void func_80ACB748(EnOwl* this, GlobalContext* globalCtx) {
    static Vec3s D_80ACD62C = { 0.0f, 0.0f, 0.0f };
    f32 unkf2;
    f32 xyzDist;
    u32 owlType;

    owlType = (this->actor.params & 0xFC0) >> 6;
    xyzDist = Math3D_Vec3f_DistXYZ(&this->eye, &globalCtx->view.eye) / 45.0f;
    this->eye.x = globalCtx->view.eye.x;
    this->eye.y = globalCtx->view.eye.y;
    this->eye.z = globalCtx->view.eye.z;
    xyzDist = xyzDist;
    if (xyzDist > 1.0f) {
        xyzDist = 1.0f;
    }

    switch (owlType) {
        case 7:
            unkf2 = xyzDist * 2.f;
            func_800F436C(&D_80ACD62C, 0x20BD, unkf2);
            if ((0x144 < globalCtx->csCtx.frames) ||
                ((0x8D < globalCtx->csCtx.frames && (globalCtx->csCtx.frames < 0x10b)))) {
                func_800F4414(&D_80ACD62C, 0x3926, unkf2);
            }
            if (globalCtx->csCtx.frames == 0x55) {
                func_800F436C(&D_80ACD62C, 0x28BE, unkf2);
            }
            break;
        case 8:
        case 9:
            unkf2 = xyzDist * 2.f;
            func_800F436C(&D_80ACD62C, 0x20BD, unkf2);
            if ((0x1A3 < globalCtx->csCtx.frames) ||
                ((0xC1 < globalCtx->csCtx.frames && (globalCtx->csCtx.frames < 0x119)))) {
                func_800F4414(&D_80ACD62C, 0x3926, unkf2);
            }
            if (globalCtx->csCtx.frames == 0xd9) {
                func_800F436C(&D_80ACD62C, 0x28BE, unkf2);
            }
            break;
    }
}

void func_80ACB904(EnOwl* this, GlobalContext* globalCtx) {
    if (globalCtx->csCtx.state != CS_STATE_IDLE && (globalCtx->csCtx.npcActions[7] != NULL)) {
        if (this->unk_40A != globalCtx->csCtx.npcActions[7]->action) {
            func_80ACD130(this, globalCtx, 7);
            func_80ACBAB8(this, globalCtx);
        }
        func_80ACD2CC(this, globalCtx);
    }

    if (this->actionFlags & 0x80) {
        func_80ACB748(this, globalCtx);
    }
}

void func_80ACB994(EnOwl* this, GlobalContext* globalCtx) {
    if (globalCtx->csCtx.state != CS_STATE_IDLE && (globalCtx->csCtx.npcActions[7] != NULL)) {
        if (this->unk_40A != globalCtx->csCtx.npcActions[7]->action) {
            func_80ACD130(this, globalCtx, 7);
            func_80ACBAB8(this, globalCtx);
        }
        func_80ACD4D4(this, globalCtx);
    }

    if (this->actionFlags & 0x80) {
        func_80ACB748(this, globalCtx);
    }
}

void EnOwl_WaitDefault(EnOwl* this, GlobalContext* globalCtx) {
    u16 angle;
    if (globalCtx->csCtx.state != CS_STATE_IDLE && (globalCtx->csCtx.npcActions[7] != NULL)) {
        if (this->unk_40A != globalCtx->csCtx.npcActions[7]->action) {
            this->actionFlags |= 4;
            func_80ACD130(this, globalCtx, 7);
            func_80ACBAB8(this, globalCtx);
        } else {
            this->actor.posRot.rot.z = globalCtx->csCtx.npcActions[7]->urot.y;
        }
    }

    if (this->actionFlags & 0x80) {
        func_80ACB748(this, globalCtx);
    }
}

void func_80ACBAB8(EnOwl* this, GlobalContext* globalCtx) {
    switch (globalCtx->csCtx.npcActions[7]->action - 1) {
        case CS_STATE_IDLE:
            EnOwl_ChangeMode(this, func_80ACB904, func_80ACC540, &this->skelAnime, &D_060015CC, 0.0f);
            break;
        case CS_STATE_SKIPPABLE_INIT:
            this->actor.draw = EnOwl_Draw;
            EnOwl_ChangeMode(this, EnOwl_WaitDefault, func_80ACC540, &this->skelAnime, &D_0600C8A0, 0.0f);
            break;
        case CS_STATE_SKIPPABLE_EXEC:
            this->actor.draw = EnOwl_Draw;
            EnOwl_ChangeMode(this, func_80ACB994, func_80ACC540, &this->skelAnime, &D_060015CC, 0.0f);
            break;
        case CS_STATE_UNSKIPPABLE_INIT:
            this->actor.draw = NULL;
            this->actionFunc = EnOwl_WaitDefault;
            break;
        case CS_STATE_UNSKIPPABLE_EXEC:
            Actor_Kill(&this->actor);
            break;
    }

    this->unk_40A = globalCtx->csCtx.npcActions[7]->action;
}

void func_80ACBC0C(EnOwl* this, GlobalContext* globalCtx) {
    this->actor.flags |= 0x20;
    if (this->actor.xzDistFromLink > 6000.0f && !(this->actionFlags & 0x80)) {
        Actor_Kill(&this->actor);
    }

    Math_SmoothStepToS(&this->actor.posRot.rot.y, this->unk_400, 2, 0x80, 0x40);
    this->actor.shape.rot.y = this->actor.posRot.rot.y;
    if (this->actor.speedXZ < 16.0f) {
        this->actor.speedXZ += 0.5f;
    }
    if ((this->unk_3F8 + 1000.0f) < this->actor.posRot.pos.y) {
        if (this->actor.velocity.y > 0.0f) {
            this->actor.velocity.y -= 0.4f;
        }
    } else if (this->actor.velocity.y < 4.0f) {
        this->actor.velocity.y += 0.2f;
    }

    this->actionFlags |= 8;
}

void func_80ACBD4C(EnOwl* this, GlobalContext* globalCtx) {
    if (this->skelAnime.curFrame > 10.0f) {
        Math_SmoothStepToS(&this->actor.posRot.rot.y, this->unk_400, 2, 0x400, 0x40);
        this->actor.shape.rot.y = this->actor.posRot.rot.y;
    }

    if (this->skelAnime.curFrame > 45.0f) {
        this->actor.velocity.y = 2.0f;
        this->actor.gravity = 0.0f;
        this->actor.speedXZ = 8.0f;
    } else if (this->skelAnime.curFrame > 17.0f) {
        this->actor.velocity.y = 6.0f;
        this->actor.gravity = 0.0f;
        this->actor.speedXZ = 4.0f;
    }

    if (this->actionFlags & 1) {
        EnOwl_ChangeMode(this, func_80ACBC0C, func_80ACC460, &this->skelAnime, &D_060015CC, 0.0f);
        this->unk_3FE = 6;
        if (this->actionFlags & 0x40) {
            this->unk_400 += 0x2000;
        } else {
            this->unk_400 -= 0x2000;
        }
    }

    this->actionFlags |= 8;
}

void func_80ACBEA0(EnOwl* this, GlobalContext* GlobalContext) {
    if (this->actionFlags & 1) {
        this->unk_3FE = 3;
        EnOwl_ChangeMode(this, func_80ACBD4C, func_80ACC540, &this->skelAnime, &D_06001168, 0.0f);
        this->unk_3F8 = this->actor.posRot.pos.y;
        this->actor.velocity.y = 2.0f;
        if (this->actionFlags & 0x40) {
            this->unk_400 = this->actor.posRot.rot.y + 0x4000;
        } else {
            this->unk_400 = this->actor.posRot.rot.y - 0x4000;
        }
    }

    this->actionFlags |= 8;
}

void func_80ACBF50(EnOwl* this, GlobalContext* globalCtx) {
    Math_SmoothStepToS(&this->actor.posRot.rot.y, this->unk_400, 2, 0x384, 0x258);
    this->actor.shape.rot.y = this->actor.posRot.rot.y;
    if (this->actionFlags & 1) {
        EnOwl_ChangeMode(this, func_80ACBC0C, func_80ACC460, &this->skelAnime, &D_060015CC, 0.0f);
        this->unk_3FE = 6;
        this->actor.velocity.y = 2.0f;
        this->actor.gravity = 0.0f;
        this->actor.speedXZ = 4.0f;
    }
    this->actionFlags |= 8;
}

void func_80ACC00C(EnOwl* this, GlobalContext* globalCtx) {
    s32 owlType;
    s32 temp_v0;
    s32 temp_v0_2;

    Math_SmoothStepToS(&this->actor.posRot.rot.y, this->unk_400, 2, 0x384, 0x258);
    this->actor.shape.rot.y = this->actor.posRot.rot.y;
    if (this->actor.xzDistFromLink < 50.0f) {
        if (!Gameplay_InCsMode(globalCtx)) {
            owlType = (this->actor.params & 0xFC0) >> 6;
            osSyncPrintf(VT_FGCOL(CYAN));
            osSyncPrintf("%dのフクロウ\n", owlType); // "%d owl"
            osSyncPrintf(VT_RST);
            switch (owlType) {
                case 7:
                    osSyncPrintf(VT_FGCOL(CYAN));
                    osSyncPrintf("SPOT 06 の デモがはしった\n"); // Demo of SPOT 06
                    osSyncPrintf(VT_RST);
                    globalCtx->csCtx.segment = SEGMENTED_TO_VIRTUAL(&D_0201B0C0);
                    this->actor.draw = NULL;
                    break;
                case 8:
                case 9:
                    globalCtx->csCtx.segment = SEGMENTED_TO_VIRTUAL(&D_0201E6A0);
                    this->actor.draw = NULL;
                    break;
                default:
                    __assert("0", "../z_en_owl.c", 1693);
                    break;
            }

            func_80078884(NA_SE_SY_TRE_BOX_APPEAR);
            gSaveContext.cutsceneTrigger = 1;
            func_800F44EC(0x14, 0xA);
            this->actionFunc = EnOwl_WaitDefault;
            this->unk_40A = 0;
            this->actionFlags |= 0x80;
            D_8011FB40 = 0;
        }
    }

    if (this->skelAnime.curFrame >= 37.0f) {
        if (this->unk_3FE > 0) {
            this->skelAnime.curFrame = 21.0f;
            this->unk_3FE--;
        } else {
            this->actionFunc = func_80ACBF50;
        }
    }

    this->actionFlags |= 8;
}

void func_80ACC23C(EnOwl* this, GlobalContext* globalCtx) {
    if (this->skelAnime.curFrame < 20.0f) {
        this->actor.speedXZ = 1.5f;
    } else {
        this->actor.speedXZ = 0.0f;
        Math_SmoothStepToS(&this->actor.posRot.rot.y, this->unk_400, 2, 0x384, 0x258);
        this->actor.shape.rot.y = this->actor.posRot.rot.y;
    }

    if (this->skelAnime.curFrame >= 37.0f) {
        this->skelAnime.curFrame = 21.0f;
        this->actionFunc = func_80ACC00C;
        this->unk_3FE = 5;
        this->actor.velocity.y = 0.0f;
        this->actor.gravity = 0.0f;
        this->actor.speedXZ = 0.0f;
    }

    this->actionFlags |= 8;
}

void func_80ACC30C(EnOwl* this, GlobalContext* globalCtx) {
    if (this->actionFlags & 1) {
        this->unk_3FE = 3;
        EnOwl_ChangeMode(this, func_80ACC23C, func_80ACC540, &this->skelAnime, &D_06001168, 0.0f);
        this->unk_3F8 = this->actor.posRot.pos.y;
        this->actor.velocity.y = 0.2f;
    }

    this->actionFlags |= 8;
}

void func_80ACC390(EnOwl* this) {
    SkelAnime_Update(this->curSkelAnime);
    if (this->unk_3FE > 0) {
        this->unk_3FE--;
        this->actor.shape.rot.z = Math_SinS(this->unk_3FE * 0x333) * 1000.0f;
    } else {
        this->unk_410 = &func_80ACC460;
        this->unk_3FE = 6;
        Animation_Change(this->curSkelAnime, &D_060015CC, 1.0f, 0.0f, Animation_GetLastFrame(&D_060015CC), 2, 5.0f);
    }
}

void func_80ACC460(EnOwl* this) {
    if (SkelAnime_Update(this->curSkelAnime) != 0) {
        if (this->unk_3FE > 0) {
            this->unk_3FE--;
            Animation_Change(this->curSkelAnime, this->curSkelAnime->animation, 1.0f, 0.0f,
                             Animation_GetLastFrame(this->curSkelAnime->animation), 2, 0.0f);
        } else {
            this->unk_3FE = 0xA0;
            this->unk_410 = func_80ACC390;
            Animation_Change(this->curSkelAnime, &D_0600C1C4, 1.0f, 0.0f, Animation_GetLastFrame(&D_0600C1C4), 0, 5.0f);
        }
    }
}

void func_80ACC540(EnOwl* this) {
    if (SkelAnime_Update(this->curSkelAnime) != 0) {
        Animation_Change(this->curSkelAnime, this->curSkelAnime->animation, 1.0f, 0.0f,
                         Animation_GetLastFrame(this->curSkelAnime->animation), 2, 0.0f);
        this->actionFlags |= 1;
    } else {
        this->actionFlags &= ~1;
    }
}

s32 func_80ACC5CC(EnOwl* this) {
    s32 phi_v1;
    s32 ret;

    phi_v1 = (this->actionFlags & 2) ? 0x20 : 0;
    if (phi_v1 == (this->unk_3EE & 0x3F)) {
        return true;
    } else {
        if ((this->actionFlags & 0x20) != 0) {
            this->unk_3EE += 4;
        } else {
            this->unk_3EE -= 4;
        }

        return false;
    }
}

s32 func_80ACC624(EnOwl* this, GlobalContext* globalCtx) {
    s32 switchFlag = (this->actor.params & 0xFC0) >> 6;
    if ((globalCtx->sceneNum != 0x5C)) {
        return true;
    } else if (switchFlag == 0xA) {
        return true;
    } else if (globalCtx->csCtx.frames >= 0x12C && globalCtx->csCtx.frames < 0x1AF) {
        return true;
    } else if (globalCtx->csCtx.frames >= 0x438 && globalCtx->csCtx.frames < 0x493) {
        return true;
    } else {
        return false;
    }
}

#ifdef NON_MATCHING
// Minor regalloc surrounding the unk_3EE at the end of the function.
void EnOwl_Update(Actor* thisx, GlobalContext* globalCtx) {
    s32 pad;
    EnOwl* this = THIS;
    s16 phi_a1;

    Collider_CylinderUpdate(&this->actor, &this->collider);
    CollisionCheck_SetOC(globalCtx, &globalCtx->colChkCtx, &this->collider);
    func_8002E4B4(globalCtx, &this->actor, 10.0f, 10.0f, 10.0f, 5);
    this->unk_410(this);
    this->actionFlags &= ~8;
    this->actionFunc(this, globalCtx);
    if (this->actor.update == NULL) {
        // Owl disappears
        osSyncPrintf("フクロウ消滅!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        return;
    }

    if (!(this->actionFlags & 0x80) && func_80ACC624(this, globalCtx)) {
        if ((this->skelAnime.animation == &D_06001168 &&
             (this->skelAnime.curFrame == 2.0f || this->skelAnime.curFrame == 9.0f ||
              this->skelAnime.curFrame == 23.0f || this->skelAnime.curFrame == 40.0f ||
              this->skelAnime.curFrame == 58.0f)) ||
            (this->skelAnime.animation == &D_060015CC && this->skelAnime.curFrame == 4.0f)) {
            Audio_PlayActorSound2(&this->actor, NA_SE_EN_OWL_FLUTTER);
        }
    }

    if (this->actor.draw != NULL) {
        Actor_MoveForward(&this->actor);
    }

    if (this->actionFlags & 2) {
        this->curDlistIdx = 2;
    } else {
        if (DECR(this->nextDlistIdx) == 0) {
            this->nextDlistIdx = Rand_S16Offset(0x3C, 0x3C);
        }

        this->curDlistIdx = this->nextDlistIdx;

        if (this->curDlistIdx >= 3) {
            this->curDlistIdx = 0;
        }
    }

    if (!(this->actionFlags & 8)) {
        phi_a1 = 0;
        if (this->actionFlags & 0x10) {
            switch (this->unk_404) {
                case 0:
                    this->unk_404 = 1;
                    this->unk_405 = 6;
                    break;
                case 1:
                    this->unk_405--;

                    if (this->unk_405 != 0) {
                        phi_a1 = Math_CosS(this->unk_405 * 8192) * 4096.0f;
                    } else {
                        if (this->actionFlags & 2) {
                            this->unk_3EE = 0;
                        } else {
                            this->unk_3EE = 0x20;
                        }

                        if (this->actionFlags & 0x20) {
                            this->unk_3EE -= 4;
                        } else {
                            this->unk_3EE += 4;
                        }
                        this->unk_404++;
                    }

                    if (this->actionFlags & 0x20) {
                        phi_a1 = -phi_a1;
                    }
                    break;
                case 2:
                    if (func_80ACC5CC(this)) {
                        this->actionFlags &= ~0x10;
                        this->unk_406 = (s32)Rand_ZeroFloat(20.0f) + 0x3C;
                        this->unk_404 = 0;
                        func_80ACA6C0(this);
                    }
                    break;
                default:
                    break;
            }
        } else {
            if (this->unk_406 > 0) {
                this->unk_406--;
            } else {
                if (this->unk_404 == 0) {
                    if (Rand_ZeroOne() < 0.3f) {
                        this->unk_404 = 4;
                        this->unk_405 = 0xC;
                    } else {
                        this->unk_404 = 1;
                        this->unk_405 = 4;
                    }
                }

                this->unk_405--;

                switch (this->unk_404) {
                    case 1:
                        phi_a1 = Math_SinS((-this->unk_405 * 4096) + 0x4000) * 5000.0f;
                        if (this->unk_405 <= 0) {
                            this->unk_405 = (s32)(Rand_ZeroFloat(15.0f) + 5.0f);
                            this->unk_404 = 2;
                        }
                        break;
                    case 2:
                        phi_a1 = 0x1388;
                        if (this->unk_405 <= 0) {
                            this->unk_404 = 3;
                            this->unk_405 = 4;
                        }
                        break;
                    case 3:
                        phi_a1 = Math_SinS(this->unk_405 * 4096) * 5000.0f;
                        if (this->unk_405 <= 0) {
                            this->unk_406 = (s32)Rand_ZeroFloat(20.0f) + 0x3C;
                            this->unk_404 = 0;
                            func_80ACA6C0(this);
                        }
                        break;
                    case 4:
                        phi_a1 = Math_SinS(this->unk_405 * 8192) * 5000.0f;
                        if (this->unk_405 <= 0) {
                            this->unk_406 = (s32)Rand_ZeroFloat(20.0f) + 0x3C;
                            this->unk_404 = 0;
                            func_80ACA6C0(this);
                        }
                        break;
                    default:
                        break;
                }

                if (this->actionFlags & 0x20) {
                    phi_a1 = -phi_a1;
                }
            }

            if (this->unk_409 > 0) {
                this->unk_409--;
            } else {
                this->unk_408--;
                switch (this->unk_407) {
                    case 0:
                        this->unk_3F2 = (-this->unk_408 * 0x5DC) + 0x1770;
                        if (this->unk_408 <= 0) {
                            this->unk_407 = 1;
                            this->unk_408 = (s32)(Rand_ZeroFloat(15.0f) + 5.0f);
                        }
                        break;
                    case 1:
                        this->unk_3F2 = 0x1770;
                        if (this->unk_408 <= 0) {
                            this->unk_407 = 2;
                            this->unk_408 = 4;
                        }
                        break;
                    case 2:
                        this->unk_3F2 = this->unk_408 * 0x5DC;
                        if (this->unk_408 <= 0) {
                            this->unk_407 = 0;
                            this->unk_408 = 4;
                            this->unk_409 = (s32)Rand_ZeroFloat(40.0f) + 0xA0;
                        }
                        break;
                    default:
                        break;
                }
            }
        }
        if (phi_a1) {}
        this->unk_3F0 = (s16)(this->unk_3EE * 1024) + phi_a1;
        this->unk_3EC = ABS(this->unk_3F0) >> 3;
    } else {
        this->unk_3F2 = 0;
        if (this->actionFlags & 2) {
            this->unk_3F0 = -0x8000;
        } else {
            this->unk_3F0 = 0;
        }

        this->unk_3EC = ABS(this->unk_3F0) >> 3;
    }
}
#else
#pragma GLOBAL_ASM("asm/non_matchings/overlays/actors/ovl_En_Owl/EnOwl_Update.s")
#endif

s32 EnOwl_OverrideLimbDraw(GlobalContext* globalCtx, s32 limbIndex, Gfx** gfx, Vec3f* pos, Vec3s* rot, void* thisx) {
    EnOwl* this = THIS;
    switch (limbIndex) {
        case 3:
            rot->x += this->unk_3F0;
            rot->z += this->unk_3EC;
            rot->z -= this->unk_3F2;
            break;
        case 2:
            rot->z += this->unk_3F2;
            break;
        case 4:
            if ((this->actionFlags & 8) == 0) {
                rot->y -= (s16)(this->unk_3EC * 1.5f);
            }
            break;
        case 5:
            if ((this->actionFlags & 8) == 0) {
                rot->y += (s16)(this->unk_3EC * 1.5f);
            }
            break;
        default:
            break;
    }
    return 0;
}

void EnOwl_PostLimbUpdate(GlobalContext* globalCtx, s32 limbIndex, Gfx** gfx, Vec3s* rot, void* thisx) {
    EnOwl* this = THIS;
    Vec3f vec;

    vec.z = 0.0f;
    if (this->actionFlags & 2) {
        vec.x = 700.0f;
        vec.y = 400.0f;
    } else {
        vec.y = 0.0f;
        vec.x = 1400.0f;
    }
    if (limbIndex == 3) {
        Matrix_MultVec3f(&vec, &this->actor.posRot2.pos);
    }
}

void EnOwl_Draw(Actor* thisx, GlobalContext* globalCtx) {
    static Gfx* dLists[] = { NULL, 0x060089A8, 0x06008DA8, 0x060091A8 };
    EnOwl* this = THIS;
    s32 pad;

    OPEN_DISPS(globalCtx->state.gfxCtx, "../z_en_owl.c", 2247);
    func_800943C8(globalCtx->state.gfxCtx);
    gSPSegment(POLY_OPA_DISP++, 8, SEGMENTED_TO_VIRTUAL(dLists[this->curDlistIdx + 1]));
    SkelAnime_DrawFlexOpa(globalCtx, this->curSkelAnime->skeleton, this->curSkelAnime->jointTable,
                          this->curSkelAnime->dListCount, EnOwl_OverrideLimbDraw, EnOwl_PostLimbUpdate, this);
    CLOSE_DISPS(globalCtx->state.gfxCtx, "../z_en_owl.c", 2264);
}

void EnOwl_ChangeMode(EnOwl* this, EnOwlActionFunc actionFunc, OwlFunc arg2, SkelAnime* skelAnime,
                      AnimationHeader* animation, f32 transitionRate) {
    this->curSkelAnime = skelAnime;
    Animation_Change(this->curSkelAnime, animation, 1.0f, 0.0f, Animation_GetLastFrame(animation), 2, transitionRate);
    this->actionFunc = actionFunc;
    this->unk_410 = arg2;
}

void func_80ACD130(EnOwl* this, GlobalContext* globalCtx, s32 idx) {
    Vec3f startPos;

    startPos.x = globalCtx->csCtx.npcActions[idx]->startPos.x;
    startPos.y = globalCtx->csCtx.npcActions[idx]->startPos.y;
    startPos.z = globalCtx->csCtx.npcActions[idx]->startPos.z;
    this->actor.posRot.pos = startPos;
    this->actor.posRot.rot.y = this->actor.shape.rot.y = globalCtx->csCtx.npcActions[idx]->rot.y;
    this->actor.shape.rot.z = globalCtx->csCtx.npcActions[idx]->urot.z;
}

f32 func_80ACD1C4(GlobalContext* globalCtx, s32 idx) {
    f32 ret;

    ret = func_8006F93C(globalCtx->csCtx.npcActions[idx]->endFrame, globalCtx->csCtx.npcActions[idx]->startFrame,
                        globalCtx->csCtx.frames);
    if (ret > 1.0f) {
        ret = 1.0f;
    }
    return ret;
}

void func_80ACD220(EnOwl* this, Vec3f* arg1, f32 arg2) {
    Vec3f rpy;

    rpy.x = (arg1->x - this->actor.posRot.pos.x) * arg2;
    rpy.y = (arg1->y - this->actor.posRot.pos.y) * arg2;
    rpy.z = (arg1->z - this->actor.posRot.pos.z) * arg2;

    Math_StepToF(&this->actor.velocity.y, rpy.y, 1.0f);
    this->actor.speedXZ = sqrtf(SQ(rpy.x) + SQ(rpy.z));
    this->actor.posRot.rot.y = Math_Vec3f_Yaw(&this->actor.posRot.pos, arg1);
    this->actor.shape.rot.y = this->actor.posRot.rot.y;
}

void func_80ACD2CC(EnOwl* this, GlobalContext* globalCtx) {
    Vec3f pos;
    s32 angle;
    f32 t;
    f32 phi_f2;

    t = func_80ACD1C4(globalCtx, 7);
    pos.x = globalCtx->csCtx.npcActions[7]->startPos.x;
    pos.y = globalCtx->csCtx.npcActions[7]->startPos.y;
    pos.z = globalCtx->csCtx.npcActions[7]->startPos.z;
    angle = (s16)globalCtx->csCtx.npcActions[7]->rot.y - this->actor.posRot.rot.z;
    if (angle < 0) {
        angle += 0x10000;
    }
    angle = (s16)((t * angle) + this->actor.posRot.rot.z);
    angle = (u16)angle;
    if (this->actionFlags & 4) {
        phi_f2 = globalCtx->csCtx.npcActions[7]->urot.x;
        phi_f2 *= 0.054931640625f;
        if (phi_f2 < 0.0f) {
            phi_f2 += 360.0f;
        }
        pos.x -= Math_SinS(angle) * phi_f2;
        pos.z += Math_CosS(angle) * phi_f2;
        this->unk_3F8 = phi_f2;
        this->actor.posRot.pos = pos;
        this->actor.draw = &EnOwl_Draw;
        this->actionFlags &= ~4;
        this->actor.speedXZ = 0.0f;
        return;
    }
    pos.x -= Math_SinS(angle) * this->unk_3F8;
    pos.z += Math_CosS(angle) * this->unk_3F8;
    func_80ACD220(this, &pos, 1.0f);
}

void func_80ACD4D4(EnOwl* this, GlobalContext* globalCtx) {
    Vec3f pos;
    Vec3f endPosf;
    f32 temp_ret;
    CsCmdActorAction* actorCmd;

    temp_ret = func_80ACD1C4(globalCtx, 7);
    pos.x = globalCtx->csCtx.npcActions[7]->startPos.x;
    pos.y = globalCtx->csCtx.npcActions[7]->startPos.y;
    pos.z = globalCtx->csCtx.npcActions[7]->startPos.z;
    actorCmd = globalCtx->csCtx.npcActions[7];
    endPosf.x = actorCmd->endPos.x;
    endPosf.y = actorCmd->endPos.y;
    endPosf.z = actorCmd->endPos.z;
    pos.x = (endPosf.x - pos.x) * temp_ret + pos.x;
    pos.y = (endPosf.y - pos.y) * temp_ret + pos.y;
    pos.z = (endPosf.z - pos.z) * temp_ret + pos.z;
    func_80ACD220(this, &pos, 1.0f);
}
