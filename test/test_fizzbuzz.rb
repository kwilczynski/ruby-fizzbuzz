# -*- encoding: utf-8 -*-

require 'test/unit'
require 'fizzbuzz'

DEFAULT_START    = 1
DEFAULT_STOP     = 15
DEFAULT_WORDS    = ['Fizz', 'Buzz', 'FizzBuzz']
DEFAULT_EXPECTED = [1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz', 11, 'Fizz', 13, 14, 'FizzBuzz']

DEFAULT_SINGLETON_METHODS = [:fizzbuzz, :is_fizz?, :is_buzz?, :is_fizzbuzz?]
DEFAULT_INSTANCE_METHODS  = [:to_a, :each, :reverse_each]

DEFAULT_INSTANCE_METHODS_ADDED = [:fizz?, :buzz?, :fizzbuzz?]

DEFAULT_INTEGER = 1
DEFAULT_BIGNUM  = 1_000_000_000_000

class BizzBuzz_Test < Test::Unit::TestCase
  def test_fizzbuzz_alias
    assert_equal(FB, FizzBuzz)
  end

  def test_fizzbuzz_singleton_methods
    fb = FizzBuzz

    assert_block do
      DEFAULT_SINGLETON_METHODS.all? {|i| fb.respond_to?(i) }
    end
  end

  def test_fizzbuzz_instance_methods
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      DEFAULT_INSTANCE_METHODS.all? {|i| fb.respond_to?(i) }
    end
  end

  def test_integer_integration
    assert_block do
      DEFAULT_INSTANCE_METHODS_ADDED.all? {|i| DEFAULT_INTEGER.respond_to?(i) }
    end
  end

  def test_bignum_integration
    assert_block do
      DEFAULT_INSTANCE_METHODS_ADDED.all? {|i| DEFAULT_BIGNUM.respond_to?(i) }
    end
  end

  def test_singleton_fizzbuzz_incorrect_argument_error
    assert_raise ArgumentError do
      FizzBuzz.fizzbuzz(2, 1)
    end
  end

  def test_singleton_fizzbuzz_incorrect_type_error
    assert_raise TypeError do
      FizzBuzz.fizzbuzz('', '')
    end
  end

  def test_singleton_fizzbuzz_integer
    integer = DEFAULT_INTEGER + 14
    obtainted = FizzBuzz.fizzbuzz(integer, integer)
    assert_equal(obtainted, ['FizzBuzz'])
  end

  def test_singleton_fizzbuzz_bignum
    bignum = DEFAULT_BIGNUM + 5
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
    assert_block do
      FizzBuzz[1].is_a?(Integer)

      obtained_fizz     = FizzBuzz[3]
      obtained_buzz     = FizzBuzz[5]
      obtained_fizzbuzz = FizzBuzz[15]

      [obtained_fizz, obtained_buzz, obtained_fizzbuzz].all? do |i|
        i.is_a?(String) and DEFAULT_WORDS.include?(i)
      end
    end
  end

  def test_singleton_squre_bignum
    assert_block do
      FizzBuzz[DEFAULT_BIGNUM].is_a?(Bignum)

      obtained_fizz     = FizzBuzz[DEFAULT_BIGNUM + 2]
      obtained_buzz     = FizzBuzz[DEFAULT_BIGNUM + 5]
      obtained_fizzbuzz = FizzBuzz[DEFAULT_BIGNUM + 15]

      [obtained_fizz, obtained_buzz, obtained_fizzbuzz].all? do |i|
        i.is_a?(String) and DEFAULT_WORDS.include?(i)
      end
    end
  end

  def test_singleton_is_fizz
    assert_block do
      FizzBuzz.is_fizz?(3)
      FizzBuzz.is_fizz?(15).is_a?(FalseClass)
    end
  end

  def test_singleton_is_buzz
    assert_block do
      FizzBuzz.is_buzz?(5)
      FizzBuzz.is_buzz?(15).is_a?(FalseClass)
    end
  end

  def test_singleton_is_fizzbuzz
    assert_block do
      FizzBuzz.is_fizzbuzz?(15)
      FizzBuzz.is_fizzbuzz?(3).is_a?(FalseClass)
      FizzBuzz.is_fizzbuzz?(5).is_a?(FalseClass)
    end
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
    fb = FizzBuzz.new(DEFAULT_BIGNUM + 5, DEFAULT_BIGNUM + 5)
    assert_equal(fb.to_a[0], 'FizzBuzz')
  end

  def test_correct_start_integer
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      fb.start.is_a?(Integer) and fb.start == 1
      fb.start = 2
      fb.start.is_a?(Integer) and fb.start == 2
    end
  end

  def test_correct_start_bignum
    fb = FizzBuzz.new(DEFAULT_BIGNUM, DEFAULT_BIGNUM)

    assert_block do
      fb.start.is_a?(Bignum) and fb.start == DEFAULT_BIGNUM
      fb.start = DEFAULT_BIGNUM - 5
      fb.start.is_a?(Bignum) and fb.start == (DEFAULT_BIGNUM - 5)
    end
  end

  def test_correct_stop_integer
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      fb.stop.is_a?(Integer) and fb.stop == 10
      fb.stop = 5
      fb.stop.is_a?(Integer) and fb.stop == 5
    end
  end

  def test_correct_stop_bignum
    fb = FizzBuzz.new(DEFAULT_BIGNUM, DEFAULT_BIGNUM)

    assert_block do
      fb.stop.is_a?(Bignum) and fb.stop == DEFAULT_BIGNUM
      fb.stop = DEFAULT_BIGNUM + 5
      fb.stop.is_a?(Bignum) and fb.stop == (DEFAULT_BIGNUM + 5)
    end
  end

  def test_missing_arguments
    assert_raise ArgumentError do
      FizzBuzz.new
    end
  end

  def test_arguments_type_error_strings
    assert_raise TypeError do
      FizzBuzz.new('', '')
    end
  end

  def test_arguments_type_error_nils
    assert_raise TypeError do
      FizzBuzz.new(nil, nil)
    end
  end

  def test_incorrect_argument_error
    assert_raise ArgumentError do
      FizzBuzz.new(2, 1)
    end
  end

  def test_start_type_error
    assert_raise TypeError do
      fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
      fb.start = ''
    end
  end

  def test_stop_type_error
    assert_raise TypeError do
      fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)
      fb.stop = ''
    end
  end

  def test_correct_start_stop
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      fb.start = 2
      fb.stop  = 3

      fb.start.is_a?(Integer) and fb.start == 2
      fb.stop.is_a?(Integer) and fb.stop == 3
    end
  end

  def test_start_boundary_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise ArgumentError do
      fb.start = 16
    end
  end

  def test_stop_bondary_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise ArgumentError do
      fb.stop = -1
    end
  end

  def test_for_range_error
    assert_raise RangeError do
      FizzBuzz.new(DEFAULT_START, DEFAULT_BIGNUM ** 2)
    end
  end
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
