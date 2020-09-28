#if !defined(_COMMON_H)
#define _COMMON_H 1

#if !defined(_GNU_SOURCE)
# define _GNU_SOURCE 1
#endif

#if !defined(_BSD_SOURCE)
# define _BSD_SOURCE 1
#endif

#if !defined(_DEFAULT_SOURCE)
# define _DEFAULT_SOURCE 1
#endif

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>
#include <assert.h>
#include <ruby.h>

#if !defined(ANYARGS)
# if defined(__cplusplus)
#  define ANYARGS ...
# else
#  define ANYARGS
# endif
#endif

#if !defined(RB_UNUSED_VAR)
# if defined(__GNUC__)
#  define RB_UNUSED_VAR(x) (x) __attribute__ ((unused))
# else
#  define RB_UNUSED_VAR(x) (x)
# endif
#endif

#if !(defined(RB_LIKELY) || defined(RB_UNLIKELY))
# if defined(__GNUC__) && __GNUC__ >= 3
#  define RB_LIKELY(x)	 (__builtin_expect(!!(x), 1))
#  define RB_UNLIKELY(x) (__builtin_expect(!!(x), 0))
# else
#  define RB_LIKELY(x)	 (x)
#  define RB_UNLIKELY(x) (x)
# endif
#endif

#if !defined(RUBY_METHOD_FUNC)
# define RUBY_METHOD_FUNC(f) ((VALUE (*)(ANYARGS))(f))
#endif

#if !defined(CSTR2RVAL)
# define CSTR2RVAL(x) ((x) == NULL ? Qnil : rb_str_new2(x))
#endif

#if !defined(RVAL2CBOOL)
# define RVAL2CBOOL(x) (RTEST(x))
#endif

#if !defined(CBOOL2RVAL)
# define CBOOL2RVAL(x) ((x) ? Qtrue : Qfalse)
#endif

#if !defined(HAVE_LONG_LONG)
# define TYPE2NUM LONG2NUM
# define NUM2TYPE NUM2LONG
#else
# define TYPE2NUM LL2NUM
# define NUM2TYPE NUM2LL
#endif

#if defined(__cplusplus)
}
#endif

#endif /* _COMMON_H */
