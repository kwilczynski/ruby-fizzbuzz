# -*- encoding: utf-8 -*-

# :enddoc:

#
# test_fizzbuzz.rb
#
# Copyright 2012-2015 Krzysztof Wilczynski
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

gem 'test-unit', '>= 3.0.0'

require 'test/unit'
require 'fizzbuzz'

class Fixnum
  def self.overflow_size_with_sign
    bits = [''].pack('p').size * 8
    2 ** (bits - 1) - 1
  end
end

class FizzBuzzTest < Test::Unit::TestCase
  def setup
    @fixnum = 1

    @bignum       = 1_000_000_000_000
    @large_bignum = 1_000_000_000_000_000

    if Fixnum.overflow_size_with_sign + 1 > 2147483647
      @bignum       = @bignum       ** 2
      @large_bignum = @large_bignum ** 2
    end

    @words = %w(Fizz Buzz FizzBuzz).freeze

    @expected = [
      1,      2,      'Fizz',
      4,      'Buzz', 'Fizz',
      7,      8,      'Fizz',
      'Buzz', 11,     'Fizz',
      13,     14,     'FizzBuzz'
    ].freeze

    @expected_bignum = [
      @bignum + 1,  'Fizz',     @bignum + 3,
      @bignum + 4,  'FizzBuzz', @bignum + 6,
      @bignum + 7,  'Fizz',     @bignum + 9,
      'Buzz',       'Fizz',     @bignum + 12,
      @bignum + 13, 'Fizz',     'Buzz'
    ]

    @fizzbuzz = FizzBuzz.new(1, 15)
  end

  def test_fizzbuzz_alias
    assert_same(FB, FizzBuzz)
  end

  def test_fizzbuzz_singleton_methods
    [
      :fizzbuzz,
      :is_fizz?,
      :is_buzz?,
      :is_fizzbuzz?
    ].each {|i| assert_respond_to(FizzBuzz, i) }
  end

  def test_fizzbuzz_new_instance
    assert(@fizzbuzz.class == FizzBuzz)
  end

  def test_fizzbuzz_instance_methods
    [
      :to_a,
      :each,
      :reverse_each,
      :to_hash,
      :as_json,
      :to_json
    ].each {|i| assert_respond_to(@fizzbuzz, i) }
  end

  def test_fixnum_integration
    [
      :fizz?,
      :buzz?,
      :fizzbuzz?
    ].each {|i| assert_respond_to(@fixnum, i) }
  end

  def test_to_hash
    obtained = @fizzbuzz.to_hash
    assert({
      'fizzbuzz' => {
        'start' => 1,
        'stop' => 15
      }
    } == obtained)
  end

  def test_as_json
    obtained = @fizzbuzz.as_json
    assert({
      'json_class' => 'FizzBuzz',
      'fizzbuzz' => {
        'start' => 1,
        'stop' => 15
      }
    } == obtained)
  end

  def test_to_json
    obtained = @fizzbuzz.to_json
    assert({
      'json_class' => 'FizzBuzz',
      'fizzbuzz' => {
        'start' => 1,
        'stop' => 15
      }
    }.to_json == obtained)
  end

  def test_singleton_from_json
    # About JSON::parse, see:
    # https://www.ruby-lang.org/en/news/2013/02/22/json-dos-cve-2013-0269/
    obtained = @fizzbuzz.to_json
    assert({
      'fizzbuzz' => {
        'start' => 1,
        'stop' => 15
      }
    } == JSON.load(obtained).to_hash)
  end

  def test_fixnum_is_fizz
    assert_true(3.fizz?)
    assert_false(15.fizz?)
  end

  def test_fixnum_is_buzz
    assert_true(5.buzz?)
    assert_false(15.buzz?)
  end

  def test_fixnum_is_fizzbuzz
    assert_equal(15.fizzbuzz?, true)
    assert_false(3.fizzbuzz?, false)
    assert_false(5.fizzbuzz?, false)
  end

  def test_bignum_integration
    [
      :fizz?,
      :buzz?,
      :fizzbuzz?
    ].each {|i| assert_respond_to(@bignum, i) }
  end

  def test_bignum_is_fizz
    assert_true((@bignum + 2).fizz?)
    assert_false((@bignum + 15).fizz?)
  end

  def test_bignum_is_buzz
    assert_true((@bignum + 15).buzz?)
    assert_false((@bignum + 5).buzz?)
  end

  def test_bignum_is_fizzbuzz
    assert_true((@bignum + 5).fizzbuzz?)
    assert_false((@bignum + 2).fizzbuzz?)
    assert_false((@bignum + 15).fizzbuzz?)
  end

  def test_array_integration
    assert_respond_to([], :fizzbuzz)
  end

  def test_array_integration_fizzbuzz
    obtained = Array(1..15).fizzbuzz
    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected)
  end

  def test_array_integration_fizzbuzz_reverse
    obtained = Array(1..15).fizzbuzz(true)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected.reverse)
  end

  def test_array_integration_fizzbuzz_block
    obtained = []
    Array(1..15).fizzbuzz {|i| obtained << i }
    assert_equal(obtained, @expected)
  end

  def test_array_integration_fizzbuzz_block_reverse
    obtained = []
    Array(1..15).fizzbuzz(true) {|i| obtained << i }
    assert_equal(obtained, @expected.reverse)
  end

  def test_range_integration
    assert_respond_to((0..0), :fizzbuzz)
  end

  def test_range_integration_fizzbuzz
    obtained = (1..15).fizzbuzz
    assert_kind_of(Enumerator, obtained)
    assert_equal(obtained.to_a, @expected)
  end

  def test_range_integration_fizzbuzz_reverse
    obtained = (1..15).fizzbuzz(true)
    assert_kind_of(Enumerator, obtained)
    assert_equal(obtained.to_a, @expected.reverse)
  end

  def test_range_integration_fizzbuzz_block
    obtained = []
    (1..15).fizzbuzz {|i| obtained << i }
    assert_equal(obtained, @expected)
  end

  def test_range_integration_fizzbuzz_block_reverse
    obtained = []
    (1..15).fizzbuzz(true) {|i| obtained << i }
    assert_equal(obtained, @expected.reverse)
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

  def test_singleton_fizzbuzz_fixnum
    obtained = FizzBuzz.fizzbuzz(15, 15)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_bignum
    obtained = FizzBuzz.fizzbuzz(@bignum + 5, @bignum + 5)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_large_bignum
    obtained = FizzBuzz.fizzbuzz(@large_bignum + 5, @large_bignum + 5)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_array
    obtained = FizzBuzz.fizzbuzz(1, 15)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected)
  end

  def test_singleton_fizzbuzz_array_reverse
    obtained = FizzBuzz.fizzbuzz(1, 15, true)
    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected.reverse)
  end

  def test_singleton_fizzbuzz_block
    obtained = []
    FizzBuzz.fizzbuzz(1, 15) {|i| obtained << i }
    assert_equal(obtained, @expected)
  end

  def test_singleton_fizzbuzz_block_reverse
    obtained = []
    FizzBuzz.fizzbuzz(1, 15, true) {|i| obtained << i }
    assert_equal(obtained, @expected.reverse)
  end

  def test_singleton_squre_fixnum
    obtained = []

    obtained << FizzBuzz[3]
    obtained << FizzBuzz[5]
    obtained << FizzBuzz[15]

    assert_kind_of(Fixnum, FizzBuzz[0])

    obtained.each_with_index do |v,i|
      assert_kind_of(String, v)
      assert_equal(obtained[i], @words[i])
    end
  end

  def test_singleton_squre_bignum
    obtained = []

    obtained << FizzBuzz[@bignum + 2]
    obtained << FizzBuzz[@bignum + 15]
    obtained << FizzBuzz[@bignum + 5]

    assert_kind_of(Bignum, FizzBuzz[@bignum + 3])

    obtained.each_with_index do |v,i|
      assert_kind_of(String, v)
      assert_equal(obtained[i], @words[i])
    end
  end

  def test_singleton_squre_large_bignum
    obtained = []

    obtained << FizzBuzz[@large_bignum + 2]
    obtained << FizzBuzz[@large_bignum + 15]
    obtained << FizzBuzz[@large_bignum + 5]

    assert_kind_of(Bignum, FizzBuzz[@large_bignum + 3])

    obtained.each_with_index do |v,i|
      assert_kind_of(String, v)
      assert_equal(obtained[i], @words[i])
    end
  end

  def test_singleton_is_fizz
    assert_true(FizzBuzz.is_fizz?(3))
    assert_false(FizzBuzz.is_fizz?(15))
  end

  def test_singleton_is_buzz
    assert_true(FizzBuzz.is_buzz?(5))
    assert_false(FizzBuzz.is_buzz?(15))
  end

  def test_singleton_is_fizzbuzz
    assert_true(FizzBuzz.is_fizzbuzz?(15))
    assert_false(FizzBuzz.is_fizzbuzz?(3))
    assert_false(FizzBuzz.is_fizzbuzz?(5))
  end

  def test_fizzbuzz_for_0
    obtained_square      = FizzBuzz[0]
    obtained_is_fizzbuzz = FizzBuzz.is_fizzbuzz?(0)

    assert_kind_of(Fixnum, obtained_square)
    assert_equal(obtained_square, 0)
    assert_false(obtained_is_fizzbuzz)
  end

  def test_fizzbuzz_for_negative_fixnum
    obtained_square      = FizzBuzz[-1]
    obtained_is_fizzbuzz = FizzBuzz.is_fizzbuzz?(-1)

    assert_kind_of(Fixnum, obtained_square)
    assert_equal(obtained_square, -1)
    assert_false(obtained_is_fizzbuzz)
  end

  def test_to_a_fixnum
    obtained = @fizzbuzz.to_a

    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected)
  end

  def test_each_fixnum
    obtained = []
    @fizzbuzz.each {|i| obtained << i }
    assert_equal(obtained, @expected)
  end

  def test_reverse_each_fixnum
    obtained = []
    @fizzbuzz.reverse_each {|i| obtained << i }
    assert_equal(obtained, @expected.reverse)
  end

  def test_to_a_bignum
    @fizzbuzz = FizzBuzz.new(@bignum + 1, @bignum + 15)
    obtained = @fizzbuzz.to_a

    assert_kind_of(Array, obtained)
    assert_equal(obtained, @expected_bignum)
  end

  def test_each_bignum
    @fizzbuzz = FizzBuzz.new(@bignum + 1, @bignum + 15)

    obtained = []
    @fizzbuzz.each {|i| obtained << i }

    assert_equal(obtained, @expected_bignum)
  end

  def test_reverse_each_bignum
    @fizzbuzz = FizzBuzz.new(@bignum + 1, @bignum + 15)

    obtained = []
    @fizzbuzz.reverse_each {|i| obtained << i }

    assert_equal(obtained, @expected_bignum.reverse)
  end

  def test_for_fizzbuzz_fixnum
    obtained = @fizzbuzz.to_a

    assert_kind_of(Array, obtained)
    assert_equal(obtained[14], 'FizzBuzz')
  end

  def test_for_fizzbuzz_bignum
    @fizzbuzz = FizzBuzz.new(@bignum + 5, @bignum + 5)

    obtained = @fizzbuzz.to_a

    assert_kind_of(Array, obtained)
    assert_equal(obtained[0], 'FizzBuzz')
  end

  def test_for_fizzbuzz_large_bignum
    @fizzbuzz = FizzBuzz.new(@large_bignum + 5, @large_bignum + 5)

    obtained = @fizzbuzz.to_a

    assert_kind_of(Array, obtained)
    assert_equal(obtained[0], 'FizzBuzz')
  end

  def test_correct_start_fixnum
    assert_kind_of(Fixnum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, 1)

    @fizzbuzz.start = 2

    assert_kind_of(Fixnum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, 2)
  end

  def test_correct_start_bignum
    @fizzbuzz = FizzBuzz.new(@bignum, @bignum)

    assert_kind_of(Bignum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, @bignum)

    @fizzbuzz.start = @bignum - 5

    assert_kind_of(Bignum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, @bignum - 5)
  end

  def test_correct_start_large_bignum
    @fizzbuzz = FizzBuzz.new(@large_bignum, @large_bignum)

    assert_kind_of(Bignum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, @large_bignum)

    @fizzbuzz.start = @large_bignum - 5

    assert_kind_of(Bignum, @fizzbuzz.start)
    assert_equal(@fizzbuzz.start, @large_bignum - 5)
  end

  def test_correct_stop_fixnum
    assert_kind_of(Fixnum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, 15)

    @fizzbuzz.stop = 5

    assert_kind_of(Fixnum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, 5)
  end

  def test_correct_stop_bignum
    @fizzbuzz = FizzBuzz.new(@bignum, @bignum)

    assert_kind_of(Bignum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, @bignum)

    @fizzbuzz.stop = @bignum + 5

    assert_kind_of(Bignum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, @bignum + 5)
  end

  def test_correct_stop_large_bignum
    @fizzbuzz = FizzBuzz.new(@large_bignum, @large_bignum)

    assert_kind_of(Bignum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, @large_bignum)

    @fizzbuzz.stop = @large_bignum + 5

    assert_kind_of(Bignum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.stop, @large_bignum + 5)
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

  def test_arguments_type_error_message
    FizzBuzz['']
  rescue FizzBuzz::TypeError => error
    assert_equal(error.message, 'must be a Fixnum or Bignum type')
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
      @fizzbuzz.start = ''
    end
  end

  def test_stop_type_error
    assert_raise FizzBuzz::TypeError do
      @fizzbuzz.stop = ''
    end
  end

  def test_correct_start_stop
    @fizzbuzz.start = 2
    @fizzbuzz.stop  = 3

    assert_kind_of(Fixnum, @fizzbuzz.start)
    assert_kind_of(Fixnum, @fizzbuzz.stop)
    assert_equal(@fizzbuzz.start, 2)
    assert_equal(@fizzbuzz.stop, 3)
  end

  def test_fizzbuzz_error
    message = 'The quick brown fox jumps over the lazy dog'
    error = FizzBuzz::Error.new(message)

    assert_respond_to(error, :start)
    assert_respond_to(error, :stop)
    assert_equal(error.message, message)
    assert_nil(error.start)
    assert_nil(error.stop)
  end

  def test_start_range_error
    assert_raise FizzBuzz::RangeError do
      @fizzbuzz.start = 16
    end
  end

  def test_stop_range_error
    assert_raise FizzBuzz::RangeError do
      @fizzbuzz.stop = -1
    end
  end

  def test_for_not_raising_range_error
    assert_nothing_raised do
      FizzBuzz.new(1, @bignum ** 2)
      FizzBuzz.new(-@large_bignum, 15)
    end
  end

  def test_error_attributes_not_nil
    @fizzbuzz.start = 1
    @fizzbuzz.stop  = 0
  rescue FizzBuzz::RangeError => error
    assert_equal(error.start, 1)
    assert_equal(error.stop, 0)
  end

  def test_error_attributes_nil
    FizzBuzz.new('', '')
  rescue FizzBuzz::TypeError => error
    assert_nil(error.start)
    assert_nil(error.stop)
  end

  def test_start_type_error_message
    FizzBuzz.new('', 15)
  rescue FizzBuzz::TypeError => error
    assert_equal(error.message, 'must be a Fixnum or Bignum type for start')
  end

  def test_stop_type_error_message
    FizzBuzz.new(1, '')
  rescue FizzBuzz::TypeError => error
    assert_equal(error.message, 'must be a Fixnum or Bignum type for stop')
  end

  def test_range_error_message
    FizzBuzz.new(15, 1)
  rescue FizzBuzz::RangeError => error
    assert_equal(error.message, 'start value is higher than stop value')
  end
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
