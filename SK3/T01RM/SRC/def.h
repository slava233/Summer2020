/* FILE NAME   : def.h
 * PROGRAMMER  : SK3.
 * LAST UPDATE : 25.07.2020.
 */

#ifndef __DEF_H_
#define __DEF_H_

/* WinAPI and OpenGL depended files */
#define GLEW_STATIC
#include <glew.h>
#include <gl/glu.h>

#include <cassert>
#include <commondf.h>

/* Debug memory allocation support */
#ifndef NDEBUG 
# define _CRTDBG_MAP_ALLOC
# include <crtdbg.h> 
# define SetDbgMemHooks() \
  _CrtSetDbgFlag(_CRTDBG_LEAK_CHECK_DF | _CRTDBG_CHECK_ALWAYS_DF | \
  _CRTDBG_ALLOC_MEM_DF | _CrtSetDbgFlag(_CRTDBG_REPORT_FLAG))
static class __Dummy
{
public:
  /* Class constructor */
  __Dummy( VOID )
  {
    SetDbgMemHooks();
  } /* End of '__Dummy' constructor */
} __oops;

#endif /* _DEBUG */ 

#ifndef NDEBUG 
# ifdef _CRTDBG_MAP_ALLOC 
#   define new new(_NORMAL_BLOCK, __FILE__, __LINE__) 
# endif /* _CRTDBG_MAP_ALLOC */ 
#endif /* _DEBUG */

#include <vector>
#include <map>
#include <string>
#include "MTH/mth.h"

/* Base large INTeger types */
typedef unsigned long long UINT64;
typedef long long INT64;

/* Project namespace */
namespace t01rm
{
  typedef mth::vec<FLT> vec;
  typedef mth::vec2<FLT> vec2;
  typedef mth::camera<FLT> camera;
  typedef mth::matr<FLT> matr;
  typedef mth::vec4<FLT> vec4;

  /* Stock class */
  template<class T>
    class stock : public std::vector<T>
    {
    public:
      /* Add stock element function
       * ARGUMENTS:
       *   - element:
       *       const T & X;
       * RETURNS:
       *   (stock &) reference to added element.
       */
      stock & operator<<( const T & X )
      {
        this->push_back(X);
        return *this;
      } /* End of 'operator<<' function */
      
      /* Walker by stock function
       * ARGUMENTS:
       *   - element:
       *     - WalkType W;
       * RETURNS: none.
       */
      template <class WalkType>
        VOID Walk( WalkType W )
        {
          for (auto &X : *this)
            W(X);
        } /* End of 'Walk' function */
    }; /* End of 'stock' class */
} /* end of 't01rm' namespace */

/* Topology namespace */
namespace topology
{
  typedef mth::vec<FLT> vec;
  typedef mth::vec2<FLT> vec2;
  typedef mth::camera<FLT> camera;
  typedef mth::matr<FLT> matr;
  typedef mth::vec4<FLT> vec4;
} /* end of 'topology' namespace */

#endif /* __DEF_H_ */

/* END OF 'def.h' FILE */