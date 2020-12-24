#ifndef _Z_BG_MORI_ELEVATOR_H_
#define _Z_BG_MORI_ELEVATOR_H_

#include "ultra64.h"
#include "global.h"

struct BgMoriElevator;

typedef void (*BgMoriElevatorActionFunc)(struct BgMoriElevator*, struct GlobalCtx*);

typedef struct BgMoriElevator {
    /* 0x0000 */ DynaPolyActor dyna;
    /* 0x0164 */ BgMoriElevatorActionFunc actionFunc;
    /* 0x0168 */ f32 targetY;
    /* 0x016C */ s32 unk_16C;
    /* 0x0170 */ u8 unk_170;
    /* 0x0171 */ s8 moriTexObjIndex;
    /* 0x0172 */ s16 unk_172;
} BgMoriElevator; // size = 0x0174

extern const ActorInit Bg_Mori_Elevator_InitVars;

#endif
