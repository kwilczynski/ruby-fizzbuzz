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

ID id_at_size;
VALUE rb_cFizzBuzz = Qnil;

void Init_fizzbuzz(void);
static void validate_size(VALUE value);
static VALUE calculate(VALUE object, return_t type);

VALUE
fizzbuzz_initialize(VALUE object, VALUE value)
{
  validate_size(value);

  rb_ivar_set(object, id_at_size, value);
  return object;
}

VALUE
fizzbuzz_get_size(VALUE object)
{
  return rb_ivar_get(object, id_at_size);
}

VALUE
fizzbuzz_set_size(VALUE object, VALUE value)
{
  validate_size(value);

  rb_ivar_set(object, id_at_size, value);
  return Qnil;
}

VALUE
fizzbuzz_to_enumerator(VALUE object)
{
  return calculate(object, ENUMERATOR);
}

VALUE
fizzbuzz_to_array(VALUE object)
{
  return calculate(object, ARRAY);
}

static VALUE
calculate(VALUE object, return_t type)
{
  int i;
  int size = FIX2INT(rb_ivar_get(object, id_at_size));

  VALUE array;

  if (WANT_ARRAY(type)) {
    array = rb_ary_new();
  }
  else { 
    RETURN_ENUMERATOR(object, 0, 0);
  }

  for (i = 1; i <= size; i++) {
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
validate_size(VALUE value)
{
  if (!FIXNUM_P(value))
    rb_raise(rb_eTypeError, "invalid value for size");

  if (FIX2INT(value) < 1)
    rb_raise(rb_eArgError, "incorrect value for size");
}
  
void
Init_fizzbuzz(void)
{
  id_at_size = rb_intern("@size");

  rb_cFizzBuzz = rb_define_class("FizzBuzz", rb_cObject);

  rb_include_module(rb_cFizzBuzz, rb_mEnumerable);

  rb_define_const(rb_cFizzBuzz, "VERSION", rb_str_new2(FIZZBUZZ_VERSION));

  rb_define_method(rb_cFizzBuzz, "initialize", fizzbuzz_initialize, 1);

  rb_define_method(rb_cFizzBuzz, "size", fizzbuzz_get_size, 0);
  rb_define_method(rb_cFizzBuzz, "size=", fizzbuzz_set_size, 1);

  rb_define_method(rb_cFizzBuzz, "to_a", fizzbuzz_to_array, 0);
  rb_define_method(rb_cFizzBuzz, "each", fizzbuzz_to_enumerator, 0);
}
