/*
 fizzbuzz.h

 Copyright 2012 Krzysztof Wilczynski

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

#ifndef __FIZZBUZZ_H__
#define __FIZZBUZZ_H__

#include <ruby.h>

#define FIZZBUZZ_VERSION "0.0.2"

#define SCORE_VALUE(x) (!((x) % 3) + 2 * !((x) % 5))

#define IS_FIZZ(x)     (SCORE_VALUE(x) == 1)
#define IS_BUZZ(x)     (SCORE_VALUE(x) == 2)
#define IS_FIZZBUZZ(x) (SCORE_VALUE(x) == 3)

#define WANT_ARRAY(x) ((x) == R_TYPE_ARRAY)

#define CHECK_TYPE(x, m) \
  if (!FIXNUM_P(x)) \
    rb_raise(rb_eTypeError, m);

#define CHECK_BOUNDARY(a, b, m) \
  if (FIX2INT(a) > FIX2INT(b)) \
    rb_raise(rb_eArgError, m);

typedef enum {
  E_INVALID_TYPE = 0,
  E_INVALID_START_TYPE,
  E_INVALID_STOP_TYPE,
  E_MISSING_ARGUMENTS,
  E_INCORRECT_START,
  E_INCORRECT_STOP,
  E_INCORRECT_START_STOP
} error_t;

typedef enum {
  R_TYPE_ARRAY = 0,
  R_TYPE_ENUMERATOR
} return_t;

static const char *errors[] = {
  "invalid value type",
  "invalid value type for start",
  "invalid value type for stop",
  "must provide start and stop values",
  "incorrect start value",
  "incorrect stop value",
  "incorrect start and stop values",
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

RUBY_EXTERN VALUE fizzbuzz_is_fizz(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_is_buzz(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_is_fizzbuzz(VALUE object, VALUE value);

RUBY_EXTERN VALUE fizzbuzz_square(VALUE object, VALUE value);

#endif /* __FIZZBUZZ_H__ */
