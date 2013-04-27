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

#ifndef H_Work_interface_arch_H
#define H_Work_interface_arch_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_interface_arch: public HSim__s6 {
public:

    HSim__s1 SE[6];

  char *t0;
  char *t1;
  HSimEnumType State;
    HSim__s1 SA[16];
  char t2;
    Work_interface_arch(const char * name);
    ~Work_interface_arch();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_interface_arch(const char *name);

#endif
