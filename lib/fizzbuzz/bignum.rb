# -*- encoding: utf-8 -*-

# :stopdoc:

#
# bignum.rb
#
# Copyright 2012-2014 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# :startdoc:

#
# Provides a convenient integration of _FizzBuzz_ with _Bignum_ class.
#
class Bignum
  #
  # call-seq:
  #    Bignum.fizz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *three* (given
  # value is a _Fizz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.fizz?   #=> false
  #    1000000000002.fizz?   #=> true
  #    1000000000005.fizz?   #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizz?
  #
  def fizz?
    FizzBuzz.is_fizz?(self)
  end

  #
  # call-seq:
  #    Bignum.buzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *five* (given
  # value is a _Buzz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.buzz?   #=> true
  #    1000000000002.buzz?   #=> false
  #    1000000000005.buzz?   #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_buzz?
  #
  def buzz?
    FizzBuzz.is_buzz?(self)
  end

  #
  # call-seq:
  #    Bignum.fizzbuzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by both *three*
  # and *five* (given value is a _FizzBuzz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.fizzbuzz?   #=> false
  #    1000000000002.fizzbuzz?   #=> false
  #    1000000000005.fizzbuzz?   #=> true
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizzbuzz?
  #
  def fizzbuzz?
    FizzBuzz.is_fizzbuzz?(self)
  end
end

# :enddoc:

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
