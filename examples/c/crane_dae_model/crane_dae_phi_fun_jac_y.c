/* This file was automatically generated by CasADi.
   The CasADi copyright holders make no ownership claim of its contents. */
#ifdef __cplusplus
extern "C" {
#endif

/* How to prefix internal symbols */
#ifdef CODEGEN_PREFIX
  #define NAMESPACE_CONCAT(NS, ID) _NAMESPACE_CONCAT(NS, ID)
  #define _NAMESPACE_CONCAT(NS, ID) NS ## ID
  #define CASADI_PREFIX(ID) NAMESPACE_CONCAT(CODEGEN_PREFIX, ID)
#else
  #define CASADI_PREFIX(ID) crane_dae_phi_fun_jac_y_ ## ID
#endif

#include <math.h>

#ifndef casadi_real
#define casadi_real double
#endif

#ifndef casadi_int
#define casadi_int int
#endif

/* Add prefix to internal symbols */
#define casadi_f0 CASADI_PREFIX(f0)
#define casadi_s0 CASADI_PREFIX(s0)
#define casadi_s1 CASADI_PREFIX(s1)
#define casadi_s2 CASADI_PREFIX(s2)
#define casadi_s3 CASADI_PREFIX(s3)
#define casadi_sq CASADI_PREFIX(sq)

/* Symbol visibility in DLLs */
#ifndef CASADI_SYMBOL_EXPORT
  #if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
    #if defined(STATIC_LINKED)
      #define CASADI_SYMBOL_EXPORT
    #else
      #define CASADI_SYMBOL_EXPORT __declspec(dllexport)
    #endif
  #elif defined(__GNUC__) && defined(GCC_HASCLASSVISIBILITY)
    #define CASADI_SYMBOL_EXPORT __attribute__ ((visibility ("default")))
  #else
    #define CASADI_SYMBOL_EXPORT
  #endif
#endif

static const casadi_int casadi_s0[8] = {4, 1, 0, 4, 0, 1, 2, 3};
static const casadi_int casadi_s1[5] = {1, 1, 0, 1, 0};
static const casadi_int casadi_s2[7] = {3, 1, 0, 3, 0, 1, 2};
static const casadi_int casadi_s3[15] = {3, 4, 0, 2, 4, 6, 8, 0, 1, 0, 2, 0, 1, 0, 2};

casadi_real casadi_sq(casadi_real x) { return x*x;}

/* crane_dae_phi_fun_jac_y:(i0[4],i1)->(o0[3],o1[3x4,8nz]) */
static int casadi_f0(const casadi_real** arg, casadi_real** res, casadi_int* iw, casadi_real* w, void* mem) {
  casadi_real a0, a1, a10, a11, a2, a3, a4, a5, a6, a7, a8, a9;
  a0=4.7418203070092001e-02;
  a1=arg[1] ? arg[1][0] : 0;
  a0=(a0*a1);
  a2=arg[0] ? arg[0][2] : 0;
  a3=cos(a2);
  a3=(a0*a3);
  a4=9.8100000000000005e+00;
  a5=sin(a2);
  a5=(a4*a5);
  a3=(a3+a5);
  a5=2.;
  a6=arg[0] ? arg[0][1] : 0;
  a7=(a5*a6);
  a8=arg[0] ? arg[0][3] : 0;
  a9=(a7*a8);
  a3=(a3+a9);
  a9=arg[0] ? arg[0][0] : 0;
  a3=(a3/a9);
  a10=(-a3);
  if (res[0]!=0) res[0][0]=a10;
  a10=casadi_sq(a2);
  a11=8.;
  a10=(a10/a11);
  a10=(a10+a9);
  if (res[0]!=0) res[0][1]=a10;
  a10=1.0000000000000001e-01;
  a10=(a8+a10);
  a11=cos(a10);
  a6=(a1*a6);
  a11=(a11+a6);
  if (res[0]!=0) res[0][2]=a11;
  a3=(a3/a9);
  if (res[1]!=0) res[1][0]=a3;
  a3=1.;
  if (res[1]!=0) res[1][1]=a3;
  a5=(a5*a8);
  a5=(a5/a9);
  a5=(-a5);
  if (res[1]!=0) res[1][2]=a5;
  if (res[1]!=0) res[1][3]=a1;
  a1=cos(a2);
  a4=(a4*a1);
  a1=sin(a2);
  a0=(a0*a1);
  a4=(a4-a0);
  a4=(a4/a9);
  a4=(-a4);
  if (res[1]!=0) res[1][4]=a4;
  a4=1.2500000000000000e-01;
  a2=(a2+a2);
  a4=(a4*a2);
  if (res[1]!=0) res[1][5]=a4;
  a7=(a7/a9);
  a7=(-a7);
  if (res[1]!=0) res[1][6]=a7;
  a10=sin(a10);
  a10=(-a10);
  if (res[1]!=0) res[1][7]=a10;
  return 0;
}

CASADI_SYMBOL_EXPORT int crane_dae_phi_fun_jac_y(const casadi_real** arg, casadi_real** res, casadi_int* iw, casadi_real* w, void* mem){
  return casadi_f0(arg, res, iw, w, mem);
}

CASADI_SYMBOL_EXPORT void crane_dae_phi_fun_jac_y_incref(void) {
}

CASADI_SYMBOL_EXPORT void crane_dae_phi_fun_jac_y_decref(void) {
}

CASADI_SYMBOL_EXPORT casadi_int crane_dae_phi_fun_jac_y_n_in(void) { return 2;}

CASADI_SYMBOL_EXPORT casadi_int crane_dae_phi_fun_jac_y_n_out(void) { return 2;}

CASADI_SYMBOL_EXPORT const char* crane_dae_phi_fun_jac_y_name_in(casadi_int i){
  switch (i) {
    case 0: return "i0";
    case 1: return "i1";
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const char* crane_dae_phi_fun_jac_y_name_out(casadi_int i){
  switch (i) {
    case 0: return "o0";
    case 1: return "o1";
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const casadi_int* crane_dae_phi_fun_jac_y_sparsity_in(casadi_int i) {
  switch (i) {
    case 0: return casadi_s0;
    case 1: return casadi_s1;
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const casadi_int* crane_dae_phi_fun_jac_y_sparsity_out(casadi_int i) {
  switch (i) {
    case 0: return casadi_s2;
    case 1: return casadi_s3;
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT int crane_dae_phi_fun_jac_y_work(casadi_int *sz_arg, casadi_int* sz_res, casadi_int *sz_iw, casadi_int *sz_w) {
  if (sz_arg) *sz_arg = 2;
  if (sz_res) *sz_res = 2;
  if (sz_iw) *sz_iw = 0;
  if (sz_w) *sz_w = 0;
  return 0;
}


#ifdef __cplusplus
} /* extern "C" */
#endif
