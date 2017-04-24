/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASMATH_
#define _ASMATH_
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
 #define amE 2.71828
 #define amPI 3.14159
 #define amLN2 0.693147
 #define am1_PI 0.31831
 #define am2_PI 0.63662
 #define amLN10 2.30259
 #define amPI_2 1.5708
 #define amPI_4 0.785398
 #define am3PI_4 2.35619
 #define amLN2HI 0.693147
 #define amLN2LO 1.90821e-010
 #define amLOG2E 1.4427
 #define amSQRT2 1.41421
 #define amSQRT3 1.73205
 #define amTWOPI 6.28319
 #define amINVLN2 1.4427
 #define amIVLN10 0.434294
 #define amLOG10E 0.434294
 #define amLOG2_E 0.693147
 #define amSQRTPI 1.77245
 #define amSQRT1_2 0.707107
 #define am2_SQRTPI 1.12838
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST float amE;
 _GLOBAL_CONST float amPI;
 _GLOBAL_CONST float amLN2;
 _GLOBAL_CONST float am1_PI;
 _GLOBAL_CONST float am2_PI;
 _GLOBAL_CONST float amLN10;
 _GLOBAL_CONST float amPI_2;
 _GLOBAL_CONST float amPI_4;
 _GLOBAL_CONST float am3PI_4;
 _GLOBAL_CONST float amLN2HI;
 _GLOBAL_CONST float amLN2LO;
 _GLOBAL_CONST float amLOG2E;
 _GLOBAL_CONST float amSQRT2;
 _GLOBAL_CONST float amSQRT3;
 _GLOBAL_CONST float amTWOPI;
 _GLOBAL_CONST float amINVLN2;
 _GLOBAL_CONST float amIVLN10;
 _GLOBAL_CONST float amLOG10E;
 _GLOBAL_CONST float amLOG2_E;
 _GLOBAL_CONST float amSQRTPI;
 _GLOBAL_CONST float amSQRT1_2;
 _GLOBAL_CONST float am2_SQRTPI;
#endif







/* Prototyping of functions and function blocks */
_BUR_PUBLIC float atan2(float y, float x);
_BUR_PUBLIC float ceil(float x);
_BUR_PUBLIC float cosh(float x);
_BUR_PUBLIC float floor(float x);
_BUR_PUBLIC float fmod(float x, float y);
_BUR_PUBLIC float frexp(float x, unsigned long pExp);
_BUR_PUBLIC float ldexp(float x, signed long exp_val);
_BUR_PUBLIC float modf(float x, unsigned long plp);
_BUR_PUBLIC float pow(float x, float y);
_BUR_PUBLIC float sinh(float x);
_BUR_PUBLIC float tanh(float x);


#ifdef __cplusplus
};
#endif
#endif /* _ASMATH_ */

