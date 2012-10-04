/*
 * fizzbuzz.h
 *
 * Copyright 2012 Krzysztof Wilczynski
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _FIZZBUZZ_H
#define _FIZZBUZZ_H

#include <stdint.h>

#define FIZZBUZZ_VERSION "0.0.2"

#if HAVE_LONG_LONG
# define VALUE_TYPE int64_t
# define TYPE2NUM LL2NUM
# define NUM2TYPE NUM2LL
#else
# define VALUE_TYPE int32_t
# define TYPE2NUM LONG2NUM
# define NUM2TYPE NUM2LONG
#endif

#define SUCCESS 1
#define FAILURE 0

#define SCORE_VALUE(x) (!((x) % 3) + 2 * !((x) % 5))

#define IS_NON_ZERO(x) (!!(x) == SUCCESS)

#define IS_FIZZ(x)     (IS_NON_ZERO(x) && SCORE_VALUE(x) == 1)
#define IS_BUZZ(x)     (IS_NON_ZERO(x) && SCORE_VALUE(x) == 2)
#define IS_FIZZBUZZ(x) (IS_NON_ZERO(x) && SCORE_VALUE(x) == 3)

#define WANT_ARRAY(x) ((x) == R_TYPE_ARRAY)

#define LOOP_FORWARD(x) ((x) == D_LOOP_FORWARD)
#define LOOP_REVERSE(x) ((x) == D_LOOP_REVERSE)

#define CHECK_TYPE(x, m)                                   \
    do {                                                   \
        if (!(TYPE(x) == T_FIXNUM || TYPE(x) == T_BIGNUM)) \
            rb_raise(rb_eTypeError, m);                    \
    } while (0)

#define CHECK_BOUNDARY(a, b, m)         \
    do {                                \
        if (NUM2TYPE(a) > NUM2TYPE(b))  \
            rb_raise(rb_eArgError, m);  \
    } while (0)

typedef enum error       error_t;
typedef enum return_type return_type_t;
typedef enum direction   direction_t;

enum error {
    E_INVALID_TYPE = 0,
    E_INVALID_START_TYPE,
    E_INVALID_STOP_TYPE,
    E_BAD_VALUE_START,
    E_BAD_VALUE_STOP,
};

enum return_type {
  R_TYPE_ARRAY = 0,
  R_TYPE_ENUMERATOR
};

enum direction {
    D_LOOP_FORWARD = 0,
    D_LOOP_REVERSE
};

static const char *errors[] = {
    "must be an integer value",
    "must be an integer value for start",
    "must be an integer value for stop",
    "start value is higher than stop value",
    "stop value is lower than start value",
    NULL
};

static const char *words[] = {
    "Fizz", "Buzz",
    "FizzBuzz", NULL
};

RUBY_EXTERN ID id_at_start, id_at_stop;
RUBY_EXTERN VALUE rb_cFizzBuzz;

RUBY_EXTERN VALUE fizzbuzz_initialize(int argc, VALUE *argv, VALUE object);

RUBY_EXTERN VALUE fizzbuzz_get_start(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_set_start(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_get_stop(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_set_stop(VALUE object, VALUE value);

RUBY_EXTERN VALUE fizzbuzz_to_array(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_to_enumerator(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_to_reverse_enumerator(VALUE object);

RUBY_EXTERN VALUE fizzbuzz_is_fizz(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_is_buzz(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_is_fizzbuzz(VALUE object, VALUE value);

RUBY_EXTERN VALUE fizzbuzz_square(VALUE object, VALUE value);

#endif /* _FIZZBUZZ_H */

/* vim: set ts=8 sw=4 sts=2 et : */
