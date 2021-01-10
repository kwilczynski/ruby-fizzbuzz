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

#if !defined(HAVE_LONG_LONG)
# define TYPE2NUM LONG2NUM
# define NUM2TYPE NUM2LONG
#else
# define TYPE2NUM LL2NUM
# define NUM2TYPE NUM2LL
#endif

#define RVAL2CBOOL(x) (RTEST(x))
#define CBOOL2RVAL(x) ((x) ? Qtrue : Qfalse)

#define CSTR2RVAL(x) ((x) == NULL ? Qnil : rb_str_new2(x))

#if defined(__cplusplus)
}
#endif

#endif /* _COMMON_H */
