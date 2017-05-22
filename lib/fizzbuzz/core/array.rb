# -*- encoding: utf-8 -*-

# :stopdoc:

#
# core/array.rb
#
# Copyright 2012-2017 Krzysztof Wilczynski
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
# Provides a convenient integration of _FizzBuzz_ with _Array_ class.
#
class Array
  #
  # call-seq:
  #    array.fizzbuzz( reverse ) {|value| block } -> self
  #    array.fizzbuzz( reverse )                  -> array
  #
  # Returns either an +array+ or accepts a block if such is given. When a block is given
  # then it will call the block once for each subsequent value for a given array, passing
  # the value as a parameter to the block.
  #
  # Additionally, if the value of +reverse+ is set to be +true+ then the results will
  # be given in an <em>reverse order</em> whether in a resulting array or when passing
  # values to a block given.
  #
  # Example:
  #
  #    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  #    array.fizzbuzz         #=> [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
  #    array.fizzbuzz(true)   #=> ["FizzBuzz", 14, 13, "Fizz", 11, "Buzz", "Fizz", 8, 7, "Fizz", "Buzz", 4, "Fizz", 2, 1]
  #
  # Example:
  #
  #    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  #    array.fizzbuzz {|value| puts "Got #{value}" }
  #
  # Produces:
  #
  #    Got 1
  #    Got 2
  #    Got Fizz
  #    Got 4
  #    Got Buzz
  #    Got Fizz
  #    Got 7
  #    Got 8
  #    Got Fizz
  #    Got Buzz
  #    Got 11
  #    Got Fizz
  #    Got 13
  #    Got 14
  #    Got FizzBuzz
  #
  # See also: FizzBuzz::fizzbuzz, FizzBuzz#to_a, FizzBuzz#each and FizzBuzz#reverse_each
  #
  def fizzbuzz(reverse = false)
    values = send(reverse ? :reverse : :to_a)

    if block_given?
      values.each { |i| yield FizzBuzz[i] }
      self
    else
      values.collect { |i| FizzBuzz[i] }
    end
  end
end

# :enddoc:

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
