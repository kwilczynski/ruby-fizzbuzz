#if !defined(_FIZZBUZZ_H)
#define _FIZZBUZZ_H 1

#if defined(__cplusplus)
extern "C" {
#endif

#include "common.h"

#define ZERO  INT2FIX(0)
#define ONE   INT2FIX(1)
#define THREE INT2FIX(3)
#define FIVE  INT2FIX(5)

#define PLUS(a, b)  fizzbuzz_plus((a), (b))
#define MINUS(a, b) fizzbuzz_minus((a), (b))
#define MOD(a, b)   fizzbuzz_modulo((a), (b))

#define GREATER(a, b)	    fizzbuzz_greater((a), (b))
#define GREATER_EQUAL(a, b) fizzbuzz_greater_equal((a), (b))
#define LESS_EQUAL(a, b)    fizzbuzz_less_equal((a), (b))

#define INTEGER_P(x) \
	(RB_TYPE_P((x), T_FIXNUM) || RB_TYPE_P((x), T_BIGNUM))

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

#define CHECK_TYPE(x, m)						\
    do {								\
	if (!INTEGER_P(x))						\
	    rb_exc_raise(fizzbuzz_type_error(rb_fb_eTypeError, (m)));	\
    } while (0)

#define CHECK_RANGE(x, y, m)							    \
    do {									    \
	if (GREATER(x, y))							    \
	    rb_exc_raise(fizzbuzz_range_error(rb_fb_eRangeError, (x), (y), (m)));   \
    } while (0)

#define error(t) errors[(t)]
#define word(n)  words[(n) - 1]

typedef enum fizzbuzz_error {
    E_INVALID_TYPE = 0,
    E_INVALID_START_TYPE,
    E_INVALID_STOP_TYPE,
    E_BAD_VALUE_START,
    E_BAD_VALUE_STOP
} fizzbuzz_error_t;

typedef enum fizzbuzz_return {
    R_TYPE_ARRAY = 0,
    R_TYPE_ENUMERATOR
} fizzbuzz_return_t;

typedef enum fizzbuzz_direction {
    D_LOOP_FORWARD = 0,
    D_LOOP_REVERSE
} fizzbuzz_direction_t;

typedef struct fizzbuzz_exception {
    VALUE start;
    VALUE stop;
    const char *message;
    VALUE klass;
} fizzbuzz_exception_t;

static const char *errors[] = {
#if defined(HAVE_INTEGER_UNIFICATION)
    "must be an Integer type",
    "must be an Integer type for start",
    "must be an Integer type for stop",
#else
    "must be a Fixnum or Bignum type",
    "must be a Fixnum or Bignum type for start",
    "must be a Fixnum or Bignum type for stop",
#endif
    "start value is higher than stop value",
    "stop value is lower than start value",
    NULL
};

static VALUE words[] = {
    Qnil, Qnil, Qnil, Qnil,
    Qundef
};

inline static VALUE
fizzbuzz_plus(VALUE a, VALUE b)
{
    return (FIXNUM_P(a) && FIXNUM_P(b)) ?	 \
	   TYPE2NUM(NUM2TYPE(a) + NUM2TYPE(b)) : \
	   rb_funcall(a, rb_intern("+"), 1, b);
}

inline static VALUE
fizzbuzz_minus(VALUE a, VALUE b)
{
    return (FIXNUM_P(a) && FIXNUM_P(b)) ?	 \
	   TYPE2NUM(NUM2TYPE(a) - NUM2TYPE(b)) : \
	   rb_funcall(a, rb_intern("-"), 1, b);
}

inline static VALUE
fizzbuzz_modulo(VALUE a, VALUE b)
{
    return (FIXNUM_P(a) && FIXNUM_P(b)) ?	 \
	   TYPE2NUM(NUM2TYPE(a) % NUM2TYPE(b)) : \
	   rb_funcall(a, rb_intern("%"), 1, b);
}

inline static VALUE
fizzbuzz_equal(VALUE a, VALUE b)
{
    VALUE result;

    result = (FIXNUM_P(a) && FIXNUM_P(b)) ? \
    	     (NUM2TYPE(a) == NUM2TYPE(b)) : \
    	     rb_funcall(a, rb_intern("=="), 1, b);

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_greater(VALUE a, VALUE b)
{
    VALUE result;

    result = (FIXNUM_P(a) && FIXNUM_P(b)) ? \
    	     (NUM2TYPE(a) > NUM2TYPE(b)) :  \
    	     rb_funcall(a, rb_intern(">"), 1, b);

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_greater_equal(VALUE a, VALUE b)
{
    VALUE result;

    result = (FIXNUM_P(a) && FIXNUM_P(b)) ? \
    	     (NUM2TYPE(a) >= NUM2TYPE(b)) : \
    	     rb_funcall(a, rb_intern(">="), 1, b);

    return RVAL2CBOOL(result);
}

inline static VALUE
fizzbuzz_less_equal(VALUE a, VALUE b)
{
    VALUE result;

    result = (FIXNUM_P(a) && FIXNUM_P(b)) ? \
    	     (NUM2TYPE(a) <= NUM2TYPE(b)) : \
    	     rb_funcall(a, rb_intern("<="), 1, b);

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
