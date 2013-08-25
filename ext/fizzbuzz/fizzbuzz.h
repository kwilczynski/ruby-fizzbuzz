/* :enddoc: */

/*
 * fizzbuzz.h
 *
 * Copyright 2012-2013 Krzysztof Wilczynski
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

#if !defined(_FIZZBUZZ_H)
#define _FIZZBUZZ_H 1

#include "common.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define ZERO  INT2FIX(0)
#define ONE   INT2FIX(1)
#define THREE INT2FIX(3)
#define FIVE  INT2FIX(5)

#define PLUS(a, b)  fizzbuzz_plus((a), (b))
#define MINUS(a, b) fizzbuzz_minus((a), (b))
#define MOD(a, b)   fizzbuzz_modulo((a), (b))

#define GREATER(a, b)       fizzbuzz_greater((a), (b))
#define GREATER_EQUAL(a, b) fizzbuzz_greater_equal((a), (b))
#define LESS_EQUAL(a, b)    fizzbuzz_less_equal((a), (b))

#define INTEGER_P(x) (TYPE(x) == T_FIXNUM || TYPE(x) == T_BIGNUM)

#define ZERO_P(x) \
    (FIXNUM_P(x) ? (NUM2TYPE(x) == 0) : fizzbuzz_equal((x), ZERO))

#define INCREASE(x) PLUS((x),  ONE)
#define DECREASE(x) MINUS((x), ONE)

#define COMPUTE_MOD_3(x) ZERO_P(MOD((x), THREE))
#define COMPUTE_MOD_5(x) ZERO_P(MOD((x), FIVE))

#define SCORE_FIXNUM(x) (uint8_t)(!((x) % 3) + 2 * !((x) % 5))
#define SCORE_BIGNUM(x) (uint8_t)(COMPUTE_MOD_3(x) + 2 * COMPUTE_MOD_5(x))

#define SCORE_VALUE(x) \
    (FIXNUM_P(x) ? SCORE_FIXNUM(NUM2TYPE(x)) : SCORE_BIGNUM(x))

#define IS_FIZZ(x)     (!ZERO_P(x) && (SCORE_VALUE(x) == 1))
#define IS_BUZZ(x)     (!ZERO_P(x) && (SCORE_VALUE(x) == 2))
#define IS_FIZZBUZZ(x) (!ZERO_P(x) && (SCORE_VALUE(x) == 3))

#define WANT_ARRAY(x) ((x) == R_TYPE_ARRAY)

#define LOOP_FORWARD(x) ((x) == D_LOOP_FORWARD)
#define LOOP_REVERSE(x) ((x) == D_LOOP_REVERSE)

#define CHECK_TYPE(x, m)						    \
    do {								    \
        if (!INTEGER_P(x)) {						    \
	    VALUE __e_type = fizzbuzz_type_error(rb_fb_eTypeError, (m));    \
	    rb_exc_raise(__e_type);					    \
	}								    \
    } while (0)

#define CHECK_RANGE(x, y, m)								\
    do {										\
        if (GREATER(x, y)) {								\
	    VALUE __e_range = fizzbuzz_range_error(rb_fb_eRangeError, (x), (y), (m));	\
	    rb_exc_raise(__e_range);							\
	}										\
    } while (0)

enum error {
    E_INVALID_TYPE = 0,
    E_INVALID_START_TYPE,
    E_INVALID_STOP_TYPE,
    E_BAD_VALUE_START,
    E_BAD_VALUE_STOP
};

enum return_type {
    R_TYPE_ARRAY = 0,
    R_TYPE_ENUMERATOR
};

enum direction {
    D_LOOP_FORWARD = 0,
    D_LOOP_REVERSE
};

struct exception {
    VALUE start;
    VALUE stop;
    const char *message;
    VALUE klass;
};

typedef enum error error_t;
typedef enum return_type return_type_t;
typedef enum direction direction_t;
typedef struct exception exception_t;

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

inline static VALUE
fizzbuzz_plus(VALUE a, VALUE b)
{
    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        return TYPE2NUM(NUM2TYPE(a) + NUM2TYPE(b));
    }

    return rb_funcall(a, rb_intern("+"), 1, b);
}

inline static VALUE
fizzbuzz_minus(VALUE a, VALUE b)
{
    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        return TYPE2NUM(NUM2TYPE(a) - NUM2TYPE(b));
    }

    return rb_funcall(a, rb_intern("-"), 1, b);
}

inline static VALUE
fizzbuzz_modulo(VALUE a, VALUE b)
{
    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        return TYPE2NUM(NUM2TYPE(a) % NUM2TYPE(b));
    }

    return rb_funcall(a, rb_intern("%"), 1, b);
}

inline static VALUE
fizzbuzz_equal(VALUE a, VALUE b)
{
    VALUE result;

    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        result = (NUM2TYPE(a) == NUM2TYPE(b));
    }
    else {
        result = rb_funcall(a, rb_intern("=="), 1, b);
    }

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_greater(VALUE a, VALUE b)
{
    VALUE result;

    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        result = (NUM2TYPE(a) > NUM2TYPE(b));
    }
    else {
        result = rb_funcall(a, rb_intern(">"), 1, b);
    }

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_greater_equal(VALUE a, VALUE b)
{
    VALUE result;

    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        result = (NUM2TYPE(a) >= NUM2TYPE(b));
    }
    else {
        result = rb_funcall(a, rb_intern(">="), 1, b);
    }

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_less_equal(VALUE a, VALUE b)
{
    VALUE result;

    if (FIXNUM_P(a) && FIXNUM_P(b)) {
        result = (NUM2TYPE(a) <= NUM2TYPE(b));
    }
    else {
        result = rb_funcall(a, rb_intern("<="), 1, b);
    }

    return RVAL2CBOOL(result);
}

RUBY_EXTERN ID id_at_start, id_at_stop;

RUBY_EXTERN VALUE rb_cFizzBuzz;

RUBY_EXTERN VALUE rb_fb_eError;
RUBY_EXTERN VALUE rb_fb_eTypeError;
RUBY_EXTERN VALUE rb_fb_eRangeError;

RUBY_EXTERN VALUE rb_fb_initialize(int argc, VALUE *argv, VALUE object);

RUBY_EXTERN VALUE rb_fb_get_start(VALUE object);
RUBY_EXTERN VALUE rb_fb_set_start(VALUE object, VALUE value);
RUBY_EXTERN VALUE rb_fb_get_stop(VALUE object);
RUBY_EXTERN VALUE rb_fb_set_stop(VALUE object, VALUE value);

RUBY_EXTERN VALUE rb_fb_array(VALUE object);
RUBY_EXTERN VALUE rb_fb_enumerator(VALUE object);
RUBY_EXTERN VALUE rb_fb_reverse_enumerator(VALUE object);

RUBY_EXTERN VALUE rb_fb_is_fizz(VALUE object, VALUE value);
RUBY_EXTERN VALUE rb_fb_is_buzz(VALUE object, VALUE value);
RUBY_EXTERN VALUE rb_fb_is_fizzbuzz(VALUE object, VALUE value);

RUBY_EXTERN VALUE rb_fb_square(VALUE object, VALUE value);

#if defined(__cplusplus)
}
#endif

#endif /* _FIZZBUZZ_H */

/* vim: set ts=8 sw=4 sts=2 et : */
