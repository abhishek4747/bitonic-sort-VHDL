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

#ifndef H_Work_fifo_arch_H
#define H_Work_fifo_arch_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_fifo_arch: public HSim__s6 {
public:

    HSim__s4 PE[2];
    HSim__s1 SE[8];

  HSimArrayType Reg_file_typebase;
  HSimArrayType Reg_file_type;
    HSim__s1 SA[13];
  int t20;
  char *t21;
  char t22;
  char t23;
HSimConstraints *c24;
    Work_fifo_arch(const char * name);
    ~Work_fifo_arch();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_fifo_arch(const char *name);

#endif
