/* :enddoc: */

/*
 * common.h
 *
 * Copyright 2012-2015 Krzysztof Wilczynski
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#if !defined(_COMMON_H)
#define _COMMON_H 1

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdint.h>
#include <assert.h>
#include <ruby.h>

#if !(defined(INT8_MIN) || defined(INT8_MAX))
typedef signed char int8_t;
#endif

#if !(defined(UINT8_MIN) || defined(UINT8_MAX))
typedef unsigned char uint8_t;
#endif

#if defined(UNUSED)
# undef(UNUSED)
#endif

#define UNUSED(x) (void)(x)

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

#if __GNUC__ >= 3
# define LIKELY(x)   (__builtin_expect(!!(x), 1))
# define UNLIKELY(x) (__builtin_expect(!!(x), 0))
#else
# define LIKELY(x)   (x)
# define UNLIKELY(x) (x)
#endif

#if defined(__cplusplus)
}
#endif

#endif /* _COMMON_H */

/* vim: set ts=8 sw=4 sts=2 et : */
