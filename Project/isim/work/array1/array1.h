////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_array1_H
#define H_Work_array1_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/numeric_std/numeric_std.h"
#include "ieee/std_logic_unsigned/std_logic_unsigned.h"
#include "ieee/std_logic_arith/std_logic_arith.h"
#include "ieee/std_logic_1164/std_logic_1164.h"

class Work_array1: public HSim__s6 {
public:
  HSimArrayType Arrbase;
  HSimArrayType Arr;
  Work_array1(const HSimString &name);
  ~Work_array1();
};

extern Work_array1 *WorkArray1;

#endif
