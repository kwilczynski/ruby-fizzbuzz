/* :stopdoc: */

/*
 * fizzbuzz.c
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

/* :startdoc: */

#include <fizzbuzz.h>

ID id_at_start, id_at_stop;

VALUE rb_cFizzBuzz = Qnil;

VALUE rb_fb_eError = Qnil;
VALUE rb_fb_eTypeError = Qnil;
VALUE rb_fb_eRangeError = Qnil;

void Init_fizzbuzz(void);

static VALUE fizzbuzz_evaluate(VALUE value);
static VALUE fizzbuzz_values(VALUE object, return_type_t type,
        direction_t direction);

static VALUE fizzbuzz_exception_wrapper(VALUE value);
static VALUE fizzbuzz_exception(void *data);

static VALUE fizzbuzz_type_error(VALUE klass, const char *message);
static VALUE fizzbuzz_range_error(VALUE klass, VALUE start, VALUE stop,
        const char *message);

/*
 * call-seq:
 *    FizzBuzz.new( start, stop ) -> self
 *
 * Returns a new _FizzBuzz_.
 *
 * The given +start+ and +stop+ values must be of an integer type and
 * will establish a +range+ within which calculation of any relevant
 * _FizzBuzz_ results will have place.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 100)     #=> #<FizzBuzz:0xb6fd3b38 @stop=100, @start=1>
 *    fb = FizzBuzz.new(-100,-1)    #=> #<FizzBuzz:0xb72d5700 @stop=-1, @start=-100>
 *    fb = FizzBuzz.new(-15, 15)    #=> #<FizzBuzz:0xb6fd0460 @stop=15, @start=-15>
 *
 * The given value of +stop+ must always be greater than or equal to the
 * given value of +start+, otherwise raises an +FizzBuzz::RangeError+
 * exception.
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value of either
 * +start+ or +stop+ is not an integer type.
 *
 * See also:
 *
 *    FizzBuzz::fizzbuzz
 */
VALUE
rb_fb_initialize(int argc, VALUE *argv, VALUE object)
{
    VALUE start, stop;

    rb_scan_args(argc, argv, "20", &start, &stop);

    CHECK_TYPE(start, error(E_INVALID_START_TYPE));
    CHECK_TYPE(stop, error(E_INVALID_STOP_TYPE));

    CHECK_RANGE(start, stop, error(E_BAD_VALUE_START));

    rb_ivar_set(object, id_at_start, start);
    rb_ivar_set(object, id_at_stop, stop);

    return object;
}

/*
 * call-seq:
 *    fizzfuzz.start -> integer
 *
 * Returns the current value for +start+.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 100)   #=> #<FizzBuzz:0xf726b48c @stop=100, @start=1>
 *    fb.start                    #=> 1
 */
VALUE
rb_fb_get_start(VALUE object)
{
    return rb_ivar_get(object, id_at_start);
}

/*
 * call-seq:
 *    fizzfuzz.start= (integer) -> integer
 *
 * Sets the current value of +start+ if given new value is lower or equal
 * to the current value of +stop+, or raises an +FizzBuzz::RangeError+
 * exception otherwise.
 *
 * Examples:
 *
 *    fb = FizzBuzz.new(1, 100)   #=> #<FizzBuzz:0xf726f03c @stop=100, @start=1>
 *    fb.start                    #=> 1
 *    fb.start = 15               #=> 15
 *    fb.start                    #=> 15
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 */
VALUE
rb_fb_set_start(VALUE object, VALUE value)
{
    VALUE stop = rb_ivar_get(object, id_at_stop);

    CHECK_TYPE(value, error(E_INVALID_START_TYPE));
    CHECK_RANGE(value, stop, error(E_BAD_VALUE_START));

    return rb_ivar_set(object, id_at_start, value);
}

/*
 * call-seq:
 *    fizzfuzz.stop -> integer
 *
 * Returns the current value for +stop+.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 100)   #=> #<FizzBuzz:0xf7272bec @stop=100, @start=1>
 *    fb.stop                     #=> 100
 */
VALUE
rb_fb_get_stop(VALUE object)
{
    return rb_ivar_get(object, id_at_stop);
}

/*
 * call-seq:
 *    fizzfuzz.start= (integer) -> integer
 *
 * Sets the current value of +stop+ if given new value is greater or equal
 * to the current value of +start+, or raises an +FizzBuzz::RangeError+
 * exception otherwise.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 100)   #=> #<FizzBuzz:0xf727679c @stop=100, @start=1>
 *    fb.stop                     #=> 100
 *    fb.stop = 15                #=> 15
 *    fb.stop                     #=> 15
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 */
VALUE
rb_fb_set_stop(VALUE object, VALUE value)
{
    VALUE start = rb_ivar_get(object, id_at_start);

    CHECK_TYPE(value, error(E_INVALID_STOP_TYPE));
    CHECK_RANGE(start, value, error(E_BAD_VALUE_STOP));

    return rb_ivar_set(object, id_at_stop, value);
}

/*
 * call-seq:
 *    fizzbuzz.to_a -> array
 *
 * Returns an array containing results upon calculating an appropriate
 * values for a given range from +start+ to +stop+.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 15)   #=> #<FizzBuzz:0xf727fd60 @stop=15, @start=1>
 *    fb.to_a                    #=> [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
 *
 * See also:
 *
 *    FizzBuzz::fizzbuzz
 */
VALUE
rb_fb_array(VALUE object)
{
    return fizzbuzz_values(object, R_TYPE_ARRAY, D_LOOP_FORWARD);
}

/*
 * call-seq:
 *    fizzbuzz.each {|value| block } -> self
 *    fizzbuzz.each                  -> an Enumerator
 *
 * Calls the block once for each subsequent value for a given range
 * from +start+ to +stop+, passing the value as a parameter to the block.
 *
 * If no block is given, an +Enumerator+ is returned instead.
 *
 * Example:
 *
 *    fb = FizzBuzz.new(1, 15)   #=> #<FizzBuzz:0xf722f8ec @stop=15, @start=1>
 *    fb.each {|value| puts "Got #{value}" }
 *
 * Produces:
 *
 *    Got 1
 *    Got 2
 *    Got Fizz
 *    Got 4
 *    Got Buzz
 *    Got Fizz
 *    Got 7
 *    Got 8
 *    Got Fizz
 *    Got Buzz
 *    Got 11
 *    Got Fizz
 *    Got 13
 *    Got 14
 *    Got FizzBuzz
 *
 * See also:
 *
 *    FizzBuzz#reverse_each
 */
VALUE
rb_fb_enumerator(VALUE object)
{
    return fizzbuzz_values(object, R_TYPE_ENUMERATOR, D_LOOP_FORWARD);
}

/*
 * call-seq:
 *    fizzbuzz.reverse_each {|value| block } -> self
 *    fizzbuzz.reverse_each                  -> an Enumerator
 *
 * Calls the block once for each subsequent value for a given range
 * from +start+ to +stop+ in an <i>reverse order</i>, passing the value
 * as a parameter to the block.
 *
 * Example:
 *
 * If no block is given, an +Enumerator+ is returned instead.
 *
 *    fb = FizzBuzz.new(1, 15)   #=> #<FizzBuzz:0xb7308664 @stop=15, @start=1>
 *    fb.reverse_each {|value| puts "Got #{value}" }
 *
 * Produces:
 *
 *    Got FizzBuzz
 *    Got 14
 *    Got 13
 *    Got Fizz
 *    Got 11
 *    Got Buzz
 *    Got Fizz
 *    Got 8
 *    Got 7
 *    Got Fizz
 *    Got Buzz
 *    Got 4
 *    Got Fizz
 *    Got 2
 *    Got 1
 *
 * See also:
 *
 *    FizzBuzz#each
 */
VALUE
rb_fb_reverse_enumerator(VALUE object)
{
    return fizzbuzz_values(object, R_TYPE_ENUMERATOR, D_LOOP_REVERSE);
}

/*
 * call-seq:
 *    FizzBuzz.is_fizz?( integer ) -> true or false
 *
 * Returns +true+ if a given integer value is divisible by *three* (given
 * value is a _Fizz_), or +false+ otherwise.
 *
 * Example:
 *
 *    FizzBuzz.is_fizz?(3)    #=> true
 *    FizzBuzz.is_fizz?(5)    #=> false
 *    FizzBuzz.is_fizz?(15)   #=> false
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 *
 * See also:
 *
 *    FizzBuzz::[]
 */
VALUE
rb_fb_is_fizz(VALUE object, VALUE value)
{
    UNUSED(object);
    CHECK_TYPE(value, error(E_INVALID_TYPE));

    return CBOOL2RVAL(IS_FIZZ(value));
}

/*
 * call-seq:
 *    FizzBuzz.is_buzz?( integer ) -> true or false
 *
 * Returns +true+ if a given integer value is divisible by *five* (given
 * value is a _Buzz_), or +false+ otherwise.
 *
 * Example:
 *
 *    FizzBuzz.is_buzz?(3)    #=> false
 *    FizzBuzz.is_buzz?(5)    #=> true
 *    FizzBuzz.is_buzz?(15)   #=> false
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 *
 * See also:
 *
 *    FizzBuzz::[]
 */
VALUE
rb_fb_is_buzz(VALUE object, VALUE value)
{
    UNUSED(object);
    CHECK_TYPE(value, error(E_INVALID_TYPE));

    return CBOOL2RVAL(IS_BUZZ(value));
}

/*
 * call-seq:
 *    FizzBuzz.is_fizzbuzz?( integer ) -> true or false
 *
 * Returns +true+ if a given integer value is divisible by both *three*
 * and *five* (given value is a _FizzBuzz_), or +false+ otherwise.
 *
 * Example:
 *
 *    FizzBuzz.is_fizzbuzz?(3)    #=> false
 *    FizzBuzz.is_fizzbuzz?(5)    #=> false
 *    FizzBuzz.is_fizzbuzz?(15)   #=> true
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 *
 * See also:
 *
 *    FizzBuzz::[]
 */
VALUE
rb_fb_is_fizzbuzz(VALUE object, VALUE value)
{
    UNUSED(object);
    CHECK_TYPE(value, error(E_INVALID_TYPE));

    return CBOOL2RVAL(IS_FIZZBUZZ(value));
}

/*
 * call-seq:
 *    FizzBuzz[ integer ] -> integer or string
 *
 * Returns _Fizz_ if the given value is divisible by *three*, _Buzz_
 * if the given value is divisible by *five* and _FizzBuzz_ if the
 * given value is divisible by both *three* and *five*, or the given
 * integer value otherwise.
 *
 * Example:
 *
 *    FizzBuzz[1]    #=> 1
 *    FizzBuzz[3]    #=> "Fizz"
 *    FizzBuzz[5]    #=> "Buzz"
 *    FizzBuzz[15]   #=> "FizzBuzz"
 *
 * Will raise a +FizzBuzz::TypeError+ exception if given value is not
 * an integer type.
 *
 * See also:
 *
 *    FizzBuzz::is_fizz?, FizzBuzz::is_buzz? and FizzBuzz::is_fizzbuzz?
 */
VALUE
rb_fb_square(VALUE object, VALUE value)
{
    UNUSED(object);
    CHECK_TYPE(value, error(E_INVALID_TYPE));

    return fizzbuzz_evaluate(value);
}

/* :enddoc: */

static VALUE
fizzbuzz_evaluate(VALUE value)
{
    int8_t score;

    VALUE result = Qnil;

    if (ZERO_P(value)) {
        return value;
    }

    score = SCORE_VALUE(value);

    switch(score) {
        case 0:
            result = value;
            break;
        case 1:
            result = CSTR2RVAL(words[score - 1]);
            break;
        case 2:
            result = CSTR2RVAL(words[score - 1]);
            break;
        case 3:
            result = CSTR2RVAL(words[score - 1]);
            break;
    }

    return result;
}

static VALUE
fizzbuzz_values(VALUE object, return_type_t type, direction_t direction)
{
    VALUE i = Qnil;

    VALUE array = Qnil;
    VALUE value = Qnil;

    VALUE start = rb_ivar_get(object, id_at_start);
    VALUE stop  = rb_ivar_get(object, id_at_stop);

    if (WANT_ARRAY(type)) {
        array = rb_ary_new();
    }
    else {
        RETURN_ENUMERATOR(object, 0, 0);
    }

    if (LOOP_FORWARD(direction)) {
        for (i = start; LESS_EQUAL(i, stop); i = INCREASE(i)) {
            value = fizzbuzz_evaluate(i);
            WANT_ARRAY(type) ? rb_ary_push(array, value) : rb_yield(value);
        }
    }
    else {
        for (i = stop; GREATER_EQUAL(i, start); i = DECREASE(i)) {
            value = fizzbuzz_evaluate(i);
            WANT_ARRAY(type) ? rb_ary_push(array, value) : rb_yield(value);
        }
    }

    return WANT_ARRAY(type) ? array : object;
}

VALUE
fizzbuzz_exception_wrapper(VALUE value)
{
    exception_t *e = (struct exception *)value;

    return rb_exc_new2(e->klass, e->message);
}

VALUE
fizzbuzz_exception(void *data)
{
    int exception = 0;
    VALUE object = Qnil;

    exception_t *e = data;

    object = rb_protect(fizzbuzz_exception_wrapper, (VALUE)e, &exception);

    if (exception != 0) {
        rb_jump_tag(exception);
    }

    rb_iv_set(object, "@start", e->start);
    rb_iv_set(object, "@stop", e->stop);

    return object;
}

VALUE
fizzbuzz_type_error(VALUE klass, const char *message)
{
    exception_t e;

    e.start = Qnil;
    e.stop = Qnil;
    e.message = message;
    e.klass = klass;

    return fizzbuzz_exception(&e);
}

VALUE
fizzbuzz_range_error(VALUE klass, VALUE start, VALUE stop, const char *message)
{
    exception_t e;

    e.start = start;
    e.stop = stop;
    e.message = message;
    e.klass = klass;

    return fizzbuzz_exception(&e);
}

void
Init_fizzbuzz(void)
{
    id_at_start = rb_intern("@start");
    id_at_stop  = rb_intern("@stop");

    rb_cFizzBuzz = rb_define_class("FizzBuzz", rb_cObject);
    rb_include_module(rb_cFizzBuzz, rb_mEnumerable);

    rb_fb_eError = rb_define_class_under(rb_cFizzBuzz, "Error", rb_eStandardError);
    rb_define_attr(rb_fb_eError, "start", 1, 0);
    rb_define_attr(rb_fb_eError, "stop", 1, 0);

    rb_fb_eTypeError = rb_define_class_under(rb_cFizzBuzz, "TypeError", rb_fb_eError);
    rb_fb_eRangeError = rb_define_class_under(rb_cFizzBuzz, "RangeError", rb_fb_eError);

    rb_define_method(rb_cFizzBuzz, "initialize", RUBY_METHOD_FUNC(rb_fb_initialize), -1);

    rb_define_method(rb_cFizzBuzz, "start", RUBY_METHOD_FUNC(rb_fb_get_start), 0);
    rb_define_method(rb_cFizzBuzz, "start=", RUBY_METHOD_FUNC(rb_fb_set_start), 1);
    rb_define_method(rb_cFizzBuzz, "stop", RUBY_METHOD_FUNC(rb_fb_get_stop), 0);
    rb_define_method(rb_cFizzBuzz, "stop=", RUBY_METHOD_FUNC(rb_fb_set_stop), 1);

    rb_define_method(rb_cFizzBuzz, "to_a", RUBY_METHOD_FUNC(rb_fb_array), 0);
    rb_define_method(rb_cFizzBuzz, "each", RUBY_METHOD_FUNC(rb_fb_enumerator), 0);
    rb_define_method(rb_cFizzBuzz, "reverse_each", RUBY_METHOD_FUNC(rb_fb_reverse_enumerator), 0);

    rb_define_singleton_method(rb_cFizzBuzz, "is_fizz?", RUBY_METHOD_FUNC(rb_fb_is_fizz), 1);
    rb_define_singleton_method(rb_cFizzBuzz, "is_buzz?", RUBY_METHOD_FUNC(rb_fb_is_buzz), 1);
    rb_define_singleton_method(rb_cFizzBuzz, "is_fizzbuzz?", RUBY_METHOD_FUNC(rb_fb_is_fizzbuzz), 1);

    rb_define_singleton_method(rb_cFizzBuzz, "[]", RUBY_METHOD_FUNC(rb_fb_square), 1);
}

/* vim: set ts=8 sw=4 sts=2 et : */
