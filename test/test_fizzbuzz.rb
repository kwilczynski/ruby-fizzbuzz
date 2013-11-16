# -*- encoding: utf-8 -*-

# :enddoc:

#
# test_fizzbuzz.rb
#
# Copyright 2012-2013 Krzysztof Wilczynski
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

begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
  STDERR.puts 'The Coveralls gem is not installed, skipping ...'
end

gem 'test-unit', '>= 2.5.2'

require 'test/unit'
require 'fizzbuzz'

DEFAULT_START    = 1
DEFAULT_STOP     = 15
DEFAULT_WORDS    = ['Fizz', 'Buzz', 'FizzBuzz']
DEFAULT_EXPECTED = [1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz', 11, 'Fizz', 13, 14, 'FizzBuzz']

DEFAULT_SINGLETON_METHODS = [:fizzbuzz, :is_fizz?, :is_buzz?, :is_fizzbuzz?]
DEFAULT_INSTANCE_METHODS  = [:to_a, :each, :reverse_each]

DEFAULT_INSTANCE_METHODS_ADDED = [:fizz?, :buzz?, :fizzbuzz?]

class Fixnum
  class << self
    def overflow_size_with_sign
      bits = [''].pack('p').size * 8
      2 ** (bits - 1) - 1
    end
  end
end

class FizzBuzzTest < Test::Unit::TestCase
  def setup
    @integer = 1
    @bignum       = 1_000_000_000_000
    @large_bignum = 1_000_000_000_000_000

    if Fixnum::overflow_size_with_sign + 1 > 2147483647
      @bignum       = @bignum       ** 2
      @large_bignum = @large_bignum ** 2
    end
  end

  def test_fizzbuzz_alias
    assert(FB == FizzBuzz)
  end

  def test_fizzbuzz_singleton_methods
    fb = FizzBuzz

    assert_block do
      DEFAULT_SINGLETON_METHODS.all? {|i| fb.respond_to?(i) }
    end
  end

  def test_fizzbuzz_new_instance
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
    assert(fb.class == FizzBuzz)
  end

  def test_fizzbuzz_instance_methods
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      DEFAULT_INSTANCE_METHODS.all? {|i| fb.respond_to?(i) }
    end
  end

  def test_integer_integration
    assert_block do
      DEFAULT_INSTANCE_METHODS_ADDED.all? {|i| @integer.respond_to?(i) }
    end
  end

  def test_integer_is_fizz
    assert_equal(3.fizz?, true)
    assert_equal(15.fizz?, false)
  end

  def test_integer_is_buzz
    assert_equal(5.buzz?, true)
    assert_equal(15.buzz?, false)
  end

  def test_integer_is_fizzbuzz
    assert_equal(15.fizzbuzz?, true)
    assert_equal(3.fizzbuzz?, false)
    assert_equal(5.fizzbuzz?, false)
  end

  def test_bignum_integration
    assert_block do
      DEFAULT_INSTANCE_METHODS_ADDED.all? {|i| @bignum.respond_to?(i) }
    end
  end

  def test_bignum_is_fizz
    assert_equal((@bignum + 2).fizz?, true)
    assert_equal((@bignum + 15).fizz?, false)
  end

  def test_bignum_is_buzz
    assert_equal((@bignum + 15).buzz?, true)
    assert_equal((@bignum + 5).buzz?, false)
  end

  def test_bignum_is_fizzbuzz
    assert_equal((@bignum + 5).fizzbuzz?, true)
    assert_equal((@bignum + 2).fizzbuzz?, false)
    assert_equal((@bignum + 15).fizzbuzz?, false)
  end

  def test_singleton_fizzbuzz_incorrect_range_error
    assert_raise FizzBuzz::RangeError do
      FizzBuzz.fizzbuzz(2, 1)
    end
  end

  def test_singleton_fizzbuzz_incorrect_type_error
    assert_raise FizzBuzz::TypeError do
      FizzBuzz.fizzbuzz('', '')
    end
  end

  def test_singleton_fizzbuzz_integer
    integer = @integer + 14
    obtainted = FizzBuzz.fizzbuzz(integer, integer)
    assert_equal(obtainted, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_bignum
    bignum = @bignum + 5
    obtainted = FizzBuzz.fizzbuzz(bignum, bignum)
    assert_equal(obtainted, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_large_bignum
    bignum = @large_bignum + 5
    obtainted = FizzBuzz.fizzbuzz(bignum, bignum)
    assert_equal(obtainted, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_array
    obtained = FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP)
    assert_equal(obtained, DEFAULT_EXPECTED)
  end

  def test_singleton_fizzbuzz_array_reverse
    obtained = FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP, true)
    assert_equal(obtained, DEFAULT_EXPECTED.reverse)
  end

  def test_singleton_fizzbuzz_block
    obtainted = []
    FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP) {|i| obtainted << i }
    assert_equal(obtainted, DEFAULT_EXPECTED)
  end

  def test_singleton_fizzbuzz_block_reverse
    obtainted = []
    FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP, true) {|i| obtainted << i }
    assert_equal(obtainted, DEFAULT_EXPECTED.reverse)
  end

  def test_singleton_squre
    obtained_fizz     = FizzBuzz[3]
    obtained_buzz     = FizzBuzz[5]
    obtained_fizzbuzz = FizzBuzz[15]

    obtained = [obtained_fizz, obtained_buzz, obtained_fizzbuzz]

    assert(FizzBuzz[@integer].class == Fixnum)
    assert_block do
      obtained.each_with_index.all? do |v,i|
        v.is_a?(String) && obtained[i] == DEFAULT_WORDS[i]
      end
    end
  end

  def test_singleton_squre_bignum
    obtained_fizz     = FizzBuzz[@bignum + 2]
    obtained_buzz     = FizzBuzz[@bignum + 15]
    obtained_fizzbuzz = FizzBuzz[@bignum + 5]

    obtained = [obtained_fizz, obtained_buzz, obtained_fizzbuzz]

    assert(FizzBuzz[@bignum + 3].class == Bignum)
    assert_block do
      obtained.each_with_index.all? do |v,i|
        v.is_a?(String) && obtained[i] == DEFAULT_WORDS[i]
      end
    end
  end

  def test_singleton_squre_large_bignum
    obtained_fizz     = FizzBuzz[@large_bignum + 2]
    obtained_buzz     = FizzBuzz[@large_bignum + 15]
    obtained_fizzbuzz = FizzBuzz[@large_bignum + 5]

    obtained = [obtained_fizz, obtained_buzz, obtained_fizzbuzz]

    assert(FizzBuzz[@large_bignum + 3].class == Bignum)
    assert_block do
      obtained.each_with_index.all? do |v,i|
        v.is_a?(String) && obtained[i] == DEFAULT_WORDS[i]
      end
    end
  end

  def test_singleton_is_fizz
    assert_equal(FizzBuzz.is_fizz?(3), true)
    assert_equal(FizzBuzz.is_fizz?(15), false)
  end

  def test_singleton_is_buzz
    assert_equal(FizzBuzz.is_buzz?(5), true)
    assert_equal(FizzBuzz.is_buzz?(15), false)
  end

  def test_singleton_is_fizzbuzz
    assert_equal(FizzBuzz.is_fizzbuzz?(15), true)
    assert_equal(FizzBuzz.is_fizzbuzz?(3), false)
    assert_equal(FizzBuzz.is_fizzbuzz?(5), false)
  end

  def test_fizzbuzz_for_0
    obtained_square      = FizzBuzz[0]
    obtained_is_fizzbuzz = FizzBuzz.is_fizzbuzz?(0)

    assert(obtained_square.is_a?(Integer) && obtained_square == 0)
    assert(obtained_is_fizzbuzz.is_a?(FalseClass) && obtained_is_fizzbuzz == false)
  end

  def test_to_a
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
    assert_equal(fb.to_a, DEFAULT_EXPECTED)
  end

  def test_each
    obtainted = []

    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
    fb.each {|i| obtainted << i }

    assert_equal(obtainted, DEFAULT_EXPECTED)
  end

  def test_reverse_each
    obtainted = []

    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
    fb.reverse_each {|i| obtainted << i }

    assert_equal(obtainted, DEFAULT_EXPECTED.reverse)
  end

  def test_for_fizzbuzz_integer
    fb = FizzBuzz.new(DEFAULT_START, 15)
    assert_equal(fb.to_a[14], 'FizzBuzz')
  end

  def test_for_fizzbuzz_bignum
    fb = FizzBuzz.new(@bignum + 5, @bignum + 5)
    assert_equal(fb.to_a[0], 'FizzBuzz')
  end

  def test_for_fizzbuzz_large_bignum
    fb = FizzBuzz.new(@large_bignum + 5, @large_bignum + 5)
    assert_equal(fb.to_a[0], 'FizzBuzz')
  end

  def test_correct_start_integer
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert(fb.start.is_a?(Integer) && fb.start == 1)
    fb.start = 2
    assert(fb.start.is_a?(Integer) && fb.start == 2)
  end

  def test_correct_start_bignum
    fb = FizzBuzz.new(@bignum, @bignum)

    assert_block do
      fb.start.is_a?(Bignum) && fb.start == @bignum
      fb.start = @bignum - 5
      fb.start.is_a?(Bignum) && fb.start == (@bignum - 5)
    end
  end

  def test_correct_start_large_bignum
    fb = FizzBuzz.new(@large_bignum, @large_bignum)

    assert(fb.start.is_a?(Bignum) && fb.start == @large_bignum)
    fb.start = @large_bignum - 5
    assert(fb.start.is_a?(Bignum) && fb.start == (@large_bignum - 5))
  end

  def test_correct_stop_integer
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert(fb.stop.is_a?(Integer) && fb.stop == 15)
    fb.stop = 5
    assert(fb.stop.is_a?(Integer) && fb.stop == 5)
  end

  def test_correct_stop_bignum
    fb = FizzBuzz.new(@bignum, @bignum)

    assert(fb.stop.is_a?(Bignum) && fb.stop == @bignum)
    fb.stop = @bignum + 5
    assert(fb.stop.is_a?(Bignum) && fb.stop == (@bignum + 5))
  end

  def test_correct_stop_large_bignum
    fb = FizzBuzz.new(@large_bignum, @large_bignum)

    assert(fb.stop.is_a?(Bignum) && fb.stop == @large_bignum)
    fb.stop = @large_bignum + 5
    assert(fb.stop.is_a?(Bignum) && fb.stop == (@large_bignum + 5))
  end

  def test_missing_arguments
    assert_raise ArgumentError do
      FizzBuzz.new
    end
  end

  def test_arguments_type_error_strings
    assert_raise FizzBuzz::TypeError do
      FizzBuzz.new('', '')
    end
  end

  def test_arguments_type_error_nils
    assert_raise FizzBuzz::TypeError do
      FizzBuzz.new(nil, nil)
    end
  end

  def test_incorrect_range_error
    assert_raise FizzBuzz::RangeError do
      FizzBuzz.new(2, 1)
    end
  end

  def test_start_type_error
    assert_raise FizzBuzz::TypeError do
      fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
      fb.start = ''
    end
  end

  def test_stop_type_error
    assert_raise FizzBuzz::TypeError do
      fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
      fb.stop = ''
    end
  end

  def test_correct_start_stop
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    fb.start = 2
    fb.stop  = 3

    assert(fb.start.is_a?(Integer) && fb.start == 2)
    assert(fb.stop.is_a?(Integer) && fb.stop == 3)
  end

  def test_start_range_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise FizzBuzz::RangeError do
      fb.start = 16
    end
  end

  def test_stop_range_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise FizzBuzz::RangeError do
      fb.stop = -1
    end
  end

  def test_for_range_error
    assert_nothing_raised do
      FizzBuzz.new(DEFAULT_START, @bignum ** 2)
      FizzBuzz.new(-@large_bignum, DEFAULT_STOP)
    end
  end

  def test_error_attributes_not_nil
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    begin
      fb.start = 1
      fb.stop  = 0
    rescue FizzBuzz::RangeError => error
      assert_equal(error.start, 1)
      assert_equal(error.stop, 0)
    end
  end

  def test_error_attributes_nil
    begin
      FizzBuzz.new('', '')
    rescue FizzBuzz::TypeError => error
      assert_equal(error.start, nil)
      assert_equal(error.stop, nil)
    end
  end

  def test_start_type_error_message
    begin
      FizzBuzz.new('', DEFAULT_STOP)
    rescue FizzBuzz::TypeError => error
      assert_equal(error.message, 'must be an Integer or Bignum type for start')
    end
  end

  def test_stop_type_error_message
    begin
      FizzBuzz.new(DEFAULT_START, '')
    rescue FizzBuzz::TypeError => error
      assert_equal(error.message, 'must be an Integer or Bignum type for stop')
    end
  end

  def test_range_error_message
    begin
      FizzBuzz.new(DEFAULT_STOP, DEFAULT_START)
    rescue FizzBuzz::RangeError => error
      assert_equal(error.message, 'start value is higher than stop value')
    end
  end
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
