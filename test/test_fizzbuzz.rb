# -*- encoding: utf-8 -*-

require 'test/unit'
require 'fizzbuzz'

DEFAULT_START    = 1
DEFAULT_STOP     = 10
DEFAULT_WORDS    = [ 'Fizz', 'Buzz', 'FizzBuzz' ]
DEFAULT_EXPECTED = [ 1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz' ]

class BizzBuzz_Test < Test::Unit::TestCase
  def test_fizzbuzz_alias
    assert_equal(FB, FizzBuzz)
  end

  def test_singleton_fizzbuzz
    obtained = FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP)
    assert_equal(obtained, DEFAULT_EXPECTED)
  end

  def test_singleton_fizzbuzz_array
    assert_block do
      FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP).is_a?(Array)
    end
  end

  def test_singleton_fizzbuzz_block
    obtainted = []
    FizzBuzz.fizzbuzz(DEFAULT_START, DEFAULT_STOP).each {|i| obtainted << i }
    assert_equal(obtainted, DEFAULT_EXPECTED)
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

  def test_for_fizzbuzz
    fb = FizzBuzz.new(DEFAULT_START, 15)
    assert_equal(fb.to_a[14], 'FizzBuzz')
  end

  def test_correct_start
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      fb.start.is_a?(Integer) and fb.start.equal?(1)
      fb.start = 2
      fb.start.is_a?(Integer) and fb.start.equal?(2)
    end
  end

  def test_correct_stop
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_block do
      fb.stop.is_a?(Integer) and fb.stop.equal?(10)
      fb.stop = 5
      fb.stop.is_a?(Integer) and fb.stop.equal?(5)
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

      fb.start.is_a?(Integer) and fb.start.equal?(2)
      fb.stop.is_a?(Integer) and fb.stop.equal?(3)
    end
  end

  def test_start_boundary_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise ArgumentError do
      fb.start = 11
    end
  end

  def test_stop_bondary_error
    fb = FizzBuzz.new(DEFAULT_START, DEFAULT_STOP)

    assert_raise ArgumentError do
      fb.stop = -1
    end
  end
end

# vim: set ts=2 sw=2 et :
# # encoding: utf-8
