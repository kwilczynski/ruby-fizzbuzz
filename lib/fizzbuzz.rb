# -*- encoding: utf-8 -*-

# :stopdoc:

#
# fizzbuzz.rb
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

require 'fizzbuzz/fizzbuzz'
require 'fizzbuzz/version'
require 'fizzbuzz/core/integer'
require 'fizzbuzz/core/bignum'
require 'fizzbuzz/core/array'
require 'fizzbuzz/core/range'

#
# Yet another _FizzBuzz_ in Ruby.
#
# Provides simple and fast solution to a popular _FizzBuzz_ problem for Ruby.
#
class FizzBuzz
  #
  # call-seq:
  #    FizzBuzz.fizzbuzz( start, stop, reverse )                  -> array
  #    FizzBuzz.fizzbuzz( start, stop, reverse ) {|value| block } -> self
  #
  # Returns either an array or accepts a block if such is given. When a block is given
  # then it will call the block once for each subsequent value for a given range from
  # +start+ to +stop+, passing the value as a parameter to the block.
  #
  # Additionally, if the value of +reverse+ is set to be +true+ then the results will
  # be given in an <em>reverse order</em> whether in a resulting array or when passing
  # values to a block given.
  #
  # Example:
  #
  #    FizzBuzz.fizzbuzz(1, 15)         #=> [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
  #    FizzBuzz.fizzbuzz(1, 15, true)   #=> ["FizzBuzz", 14, 13, "Fizz", 11, "Buzz", "Fizz", 8, 7, "Fizz", "Buzz", 4, "Fizz", 2, 1]
  #
  # Example:
  #
  #    FizzBuzz.fizzbuzz(1, 15) {|value| puts "Got #{value}" }
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
  # See also: FizzBuzz::[], FizzBuzz::new, FizzBuzz#to_a, FizzBuzz#each and FizzBuzz#reverse_each
  #
  def self.fizzbuzz(start, stop, reverse = false, &block)
    fb = new(start, stop)

    if block_given?
      fb.send(reverse ? :reverse_each : :each, &block)
      self
    else
      fb.to_a.send(reverse ? :reverse : :to_a)
    end
  end
end

# :enddoc:

FB = FizzBuzz

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
