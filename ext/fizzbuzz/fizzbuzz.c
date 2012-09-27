/*
 fizzbuzz.c

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

#include <fizzbuzz.h>

ID id_at_limit;
VALUE rb_cFizzBuzz = Qnil;

void Init_fizzbuzz(void);
static void validate_limit(VALUE value);
static VALUE calculate(VALUE object, return_t type);

VALUE
fizzbuzz_initialize(VALUE object, VALUE value)
{
  validate_limit(value);

  rb_ivar_set(object, id_at_limit, value);
  return object;
}

VALUE
fizzbuzz_get_limit(VALUE object)
{
  return rb_ivar_get(object, id_at_limit);
}

VALUE
fizzbuzz_set_limit(VALUE object, VALUE value)
{
  validate_limit(value);

  rb_ivar_set(object, id_at_limit, value);
  return Qnil;
}

VALUE
fizzbuzz_to_array(VALUE object)
{
  return calculate(object, ARRAY);
}

VALUE
fizzbuzz_to_enumerator(VALUE object)
{
  return calculate(object, ENUMERATOR);
}

VALUE
fizzbuzz_is_fizz(VALUE object, VALUE value)
{
  CHECK_TYPE(value, "invalid value type")
  return IS_FIZZ(FIX2INT(value)) ? Qtrue : Qfalse;
}

VALUE
fizzbuzz_is_buzz(VALUE object, VALUE value)
{
  CHECK_TYPE(value, "invalid value type")
  return IS_BUZZ(FIX2INT(value)) ? Qtrue : Qfalse;
}

VALUE
fizzbuzz_is_fizzbuzz(VALUE object, VALUE value)
{
  CHECK_TYPE(value, "invalid value type")
  return IS_FIZZBUZZ(FIX2INT(value)) ? Qtrue : Qfalse;
}

VALUE
fizzbuzz_square(VALUE object, VALUE value)
{
  VALUE result = Qnil;

  int score = SCORE_VALUE(FIX2INT(value));

  CHECK_TYPE(value, "invalid value type")

  switch(score) {
    case 0:
      result = value;
      break;

    case 1:
      result = rb_str_new2(words[score - 1]);
      break;

    case 2:
      result = rb_str_new2(words[score - 1]);
      break;

    case 3:
      result = rb_str_new2(words[score - 1]);
    break;
  }

  return result;
}

static VALUE
calculate(VALUE object, return_t type)
{
  int i;
  int limit = FIX2INT(rb_ivar_get(object, id_at_limit));

  VALUE array;

  if (WANT_ARRAY(type)) {
    array = rb_ary_new();
  }
  else { 
    RETURN_ENUMERATOR(object, 0, 0);
  }

  for (i = 1; i <= limit; i++) {
    if (i % 15 == 0) {
      WANT_ARRAY(type) ? rb_ary_push(array, rb_str_new2(words[2]))
                       : rb_yield(rb_str_new2(words[2]));
    }
    else if (i % 5 == 0) {
      WANT_ARRAY(type) ? rb_ary_push(array, rb_str_new2(words[1]))
                       : rb_yield(rb_str_new2(words[1]));
    }
    else if (i % 3 == 0) {
      WANT_ARRAY(type) ? rb_ary_push(array, rb_str_new2(words[0]))
                       : rb_yield(rb_str_new2(words[0]));
    }
    else {
      WANT_ARRAY(type) ? rb_ary_push(array, INT2FIX(i))
                       : rb_yield(INT2FIX(i));
    }
  }

  return WANT_ARRAY(type) ? array : object;
}

static void
validate_limit(VALUE value)
{
  CHECK_TYPE(value, "invalid value for limit");
  CHECK_LOWER_BOUNDARY(value, "incorrect value for limit");
}
  
void
Init_fizzbuzz(void)
{
  id_at_limit = rb_intern("@limit");

  rb_cFizzBuzz = rb_define_class("FizzBuzz", rb_cObject);

  rb_include_module(rb_cFizzBuzz, rb_mEnumerable);

  rb_define_const(rb_cFizzBuzz, "VERSION", rb_str_new2(FIZZBUZZ_VERSION));

  rb_define_method(rb_cFizzBuzz, "initialize", fizzbuzz_initialize, 1);

  rb_define_method(rb_cFizzBuzz, "limit", fizzbuzz_get_limit, 0);
  rb_define_method(rb_cFizzBuzz, "limit=", fizzbuzz_set_limit, 1);

  rb_define_method(rb_cFizzBuzz, "to_a", fizzbuzz_to_array, 0);
  rb_define_method(rb_cFizzBuzz, "each", fizzbuzz_to_enumerator, 0);

  rb_define_singleton_method(rb_cFizzBuzz, "is_fizz?", fizzbuzz_is_fizz, 1);
  rb_define_singleton_method(rb_cFizzBuzz, "is_buzz?", fizzbuzz_is_buzz, 1);
  rb_define_singleton_method(rb_cFizzBuzz, "is_fizzbuzz?", fizzbuzz_is_fizzbuzz, 1);

  rb_define_singleton_method(rb_cFizzBuzz, "[]", fizzbuzz_square, 1);
}
