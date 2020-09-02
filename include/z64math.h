#ifndef _Z64MATH_H_
#define _Z64MATH_H_

#include <ultra64.h>

#define VEC_SET(V,X,Y,Z) V.x=X;V.y=Y;V.z=Z

typedef struct {
    f32 x, y;
} Vec2f; // size = 0x08

typedef struct {
    f32 x, y, z;
} Vec3f; // size = 0x0C

typedef struct {
    u16 x, y, z;
} Vec3us; // size = 0x06

typedef struct {
    s16 x, y, z;
} Vec3s; // size = 0x06

typedef struct {
    s32 x, y, z;
} Vec3i; // size = 0x0C

typedef struct {
    Vec3s center;
    s16 radius;
} Sphere16; // size = 0x08

typedef struct {
    Vec3f center;
    f32 radius;
} Spheref; // size = 0x10

typedef struct {
    Vec3f normal;
    f32 originDist;
} Plane; // size = 0x10

typedef struct {
    Vec3f vtx[3];
    Plane plane;
} TriNorm; // size = 0x34

typedef struct {
    /* 0x0000 */ s16 radius;
    /* 0x0002 */ s16 height;
    /* 0x0004 */ s16 yShift;
    /* 0x0006 */ Vec3s pos;
} Cylinder16; // size = 0x0C

typedef struct {
    f32 radius;
    f32 height;
    f32 yShift;
    Vec3f pos;
} Cylinderf; // size = 0x18

typedef struct {
    /* 0x0000 */ Vec3f point;
    /* 0x000C */ Vec3f dir;
} InfiniteLine; // size = 0x18

typedef struct {
    /* 0x0000 */ Vec3f a;
    /* 0x000C */ Vec3f b;
} Linef; // size = 0x18

// Defines a point in the spherical coordinate system
typedef struct {
    f32 r;      // radius
    s16 pitch;  // polar (zenith) angle
    s16 yaw;    // azimuthal angle
} VecSph; // size = 0x08

#define F32_LERP(v0,v1,t) ((1.0f - (t)) * (v0) + (t) * (v1))
#define F32_LERPIMP(v0, v1, t) (v0 + ((v1 - v0) * t))
#define F32_LERPIMPINV(v0, v1, t) ((v0) + (((v1) - (v0)) / (t)))
#define BINANG_LERPIMP(v0, v1, t) ((v0) + (s16)(BINANG_SUB((v1), (v0)) * (t)))
#define BINANG_LERPIMPINV(v0, v1, t) ((v0) + BINANG_SUB((v1), (v0)) / (t))

#define VEC3F_LERPIMP(v0, v1, xzt, yt, v1yoffset) { \
    (v0)->x = (v0)->x + (((v1)->x - (v0)->x) * xzt); \
    (v0)->y = (v0)->y + ((((v1)->y + v1yoffset) - (v0)->y) * yt); \
    (v0)->z = (v0)->z + (((v1)->z - (v0)->z) * xzt); \
}

#define VEC3F_LERPIMPDST(dst, v0, v1, t){ \
    (dst)->x = (v0)->x + (((v1)->x - (v0)->x) * t); \
    (dst)->y = (v0)->y + (((v1)->y - (v0)->y) * t); \
    (dst)->z = (v0)->z + (((v1)->z - (v0)->z) * t); \
}

#define IS_ZERO(f) (fabsf(f) < 0.008f)
#define COLPOLY_NORM_FRAC (1.0f / 32767)
#define BGCHECK_Y_MIN -32000.0f

/**
 * Trig macros
*/
#define DEGF_TO_BINANG(degreesf) (s16)(degreesf * (65535.0f / 360.0f) + 0.5f)
#define RADF_TO_DEGF(radf) (radf * (180.0f / M_PI))
#define DEGF_TO_RADF(degf) (degf * (M_PI / 180.0f))
#define BINANG_ROT180(angle) ((s16)(angle - 0x7FFF))
#define BINANG_SUB(a, b) ((s16)(a - b))
#define BINANG_ADD(a, b) ((s16)(a + b))
#define DEG_TO_RAD(degrees) ((degrees) * (M_PI / 180.0f))
#define BINANG_TO_DEGF(binang) ((f32)binang * (360.0001525f / 65535.0f))

#endif
