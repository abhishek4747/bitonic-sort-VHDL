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

#ifndef H_Work_debounce_modified_fsmd_arch_rep_H
#define H_Work_debounce_modified_fsmd_arch_rep_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_debounce_modified_fsmd_arch_rep: public HSim__s6 {
public:

    HSim__s1 SE[5];

HSim__s4 C8;
  HSimEnumType State_type;
    HSim__s1 SA[4];
    Work_debounce_modified_fsmd_arch_rep(const char * name);
    ~Work_debounce_modified_fsmd_arch_rep();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_debounce_modified_fsmd_arch_rep(const char *name);

#endif
