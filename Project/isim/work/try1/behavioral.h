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

#ifndef H_Work_try1_behavioral_H
#define H_Work_try1_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_try1_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[2];

/* subprogram name bitonicmerge */
char *Fj(const char *C8, const int Cb, const int Cd, const char Cg);
/* subprogram name bitonicsort */
char *F1I(const char *C1z, const int C1B, const int C1D, const char C1F);
  char *t0;
    Work_try1_behavioral(const char * name);
    ~Work_try1_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_try1_behavioral(const char *name);

#endif
