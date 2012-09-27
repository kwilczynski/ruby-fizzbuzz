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

#define FIZZBUZZ_VERSION "0.0.1"
#define WANT_ARRAY(x) ((x) == (ARRAY))

typedef enum {
  ARRAY = 0,
  ENUMERATOR
} return_t;

static const char *words[] = {
  "Fizz", "Buzz",
  "FizzBuzz", NULL
};

RUBY_EXTERN ID id_at_size;
RUBY_EXTERN VALUE rb_cFizzBuzz;

RUBY_EXTERN VALUE fizzbuzz_initialize(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_get_size(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_set_size(VALUE object, VALUE value);
RUBY_EXTERN VALUE fizzbuzz_to_array(VALUE object);
RUBY_EXTERN VALUE fizzbuzz_to_enumerator(VALUE object);

#endif /* __FIZZBUZZ_H__ */
