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

#ifndef H_Work_mod_m_counter_arch_H
#define H_Work_mod_m_counter_arch_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_mod_m_counter_arch: public HSim__s6 {
public:

    HSim__s4 PE[2];
    HSim__s1 SE[4];

    HSim__s1 SA[2];
  char t0;
  char *t1;
HSimConstraints *c2;
    Work_mod_m_counter_arch(const char * name);
    ~Work_mod_m_counter_arch();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_mod_m_counter_arch(const char *name);

#endif
