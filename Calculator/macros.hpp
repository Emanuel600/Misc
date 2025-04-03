#ifndef MACROS
#define MACROS

#ifdef _DEBUG
    #define Print(s) printf(s)
    #define DEBUG(s) std::cout << s;
#else
    #define Print(s)
    #define DEBUG(s)
#endif

#endif
