/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASBRMATH_
#define _ASBRMATH_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define brmE 2.71828
 #define brmPI 3.14159
 #define brmLN2 0.693147
 #define brm1_PI 0.31831
 #define brm2_PI 0.63662
 #define brmLN10 2.30259
 #define brmPI_2 1.5708
 #define brmPI_4 0.785398
 #define brm3PI_4 2.35619
 #define brmLN2HI 0.693147
 #define brmLN2LO 1.90821e-010
 #define brmLOG2E 1.4427
 #define brmSQRT2 1.41421
 #define brmSQRT3 1.73205
 #define brmTWOPI 6.28319
 #define brmINVLN2 1.4427
 #define brmIVLN10 0.434294
 #define brmLOG10E 0.434294
 #define brmLOG2_E 0.693147
 #define brmSQRTPI 1.77245
 #define brmSQRT1_2 0.707107
 #define brm2_SQRTPI 1.12838
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST float brmE;
 _GLOBAL_CONST float brmPI;
 _GLOBAL_CONST float brmLN2;
 _GLOBAL_CONST float brm1_PI;
 _GLOBAL_CONST float brm2_PI;
 _GLOBAL_CONST float brmLN10;
 _GLOBAL_CONST float brmPI_2;
 _GLOBAL_CONST float brmPI_4;
 _GLOBAL_CONST float brm3PI_4;
 _GLOBAL_CONST float brmLN2HI;
 _GLOBAL_CONST float brmLN2LO;
 _GLOBAL_CONST float brmLOG2E;
 _GLOBAL_CONST float brmSQRT2;
 _GLOBAL_CONST float brmSQRT3;
 _GLOBAL_CONST float brmTWOPI;
 _GLOBAL_CONST float brmINVLN2;
 _GLOBAL_CONST float brmIVLN10;
 _GLOBAL_CONST float brmLOG10E;
 _GLOBAL_CONST float brmLOG2_E;
 _GLOBAL_CONST float brmSQRTPI;
 _GLOBAL_CONST float brmSQRT1_2;
 _GLOBAL_CONST float brm2_SQRTPI;
#endif







/* Prototyping of functions and function blocks */
_BUR_PUBLIC float brmatan2(float y, float x);
_BUR_PUBLIC float brmceil(float x);
_BUR_PUBLIC float brmcosh(float x);
_BUR_PUBLIC float brmfloor(float x);
_BUR_PUBLIC float brmfmod(float x, float y);
_BUR_PUBLIC float brmfrexp(float x, unsigned long pExp);
_BUR_PUBLIC float brmldexp(float x, signed long exp_val);
_BUR_PUBLIC float brmmodf(float x, unsigned long plp);
_BUR_PUBLIC float brmpow(float x, float y);
_BUR_PUBLIC float brmsinh(float x);
_BUR_PUBLIC float brmtanh(float x);


#ifdef __cplusplus
};
#endif
#endif /* _ASBRMATH_ */

