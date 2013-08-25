# -*- encoding: utf-8 -*-

# :stopdoc:

#
# integer.rb
#
# Copyright 2012 Krzysztof Wilczynski
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
# Provides a convenient integration of _FizzBuzz_ with _Integer_ class.
#
class Integer
  #
  # call-seq:
  #    Integer.fizz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *three* (given
  # value is a _Fizz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.fizz?   #=> true
  #     5.fizz?   #=> false
  #    15.fizz?   #=> false
  #
  # See also:
  #
  #    FizzBuzz::[] and FizzBuzz::is_fizz?
  #
  def fizz?
    FizzBuzz.is_fizz?(self)
  end

  #
  # call-seq:
  #    Integer.buzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *five* (given
  # value is a _Buzz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.buzz?   #=> false
  #     5.buzz?   #=> true
  #    15.buzz?   #=> false
  #
  # See also:
  #
  #    FizzBuzz::[] and FizzBuzz::is_buzz?
  #
  def buzz?
    FizzBuzz.is_buzz?(self)
  end

  #
  # call-seq:
  #   Integer.fizzbuzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by both *three*
  # and *five* (given value is a _FizzBuzz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.fizzbuzz?   #=> false
  #     5.fizzbuzz?   #=> false
  #    15.fizzbuzz?   #=> true
  #
  # See also:
  #
  #    FizzBuzz::[] and FizzBuzz::is_fizzbuzz?
  #
  def fizzbuzz?
    FizzBuzz.is_fizzbuzz?(self)
  end
end

# :enddoc:

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
