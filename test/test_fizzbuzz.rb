# -*- encoding: utf-8 -*-

require 'test/unit'
require 'fizzbuzz'

DEFAULT_WORDS    = [ 'Fizz', 'Buzz', 'FizzBuzz' ]
DEFAULT_EXPECTED = [ 1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz' ]

class BizzBuzz_Test < Test::Unit::TestCase
  def test_singleton_fizzbuzz
    obtained = FizzBuzz.fizzbuzz(DEFAULT_EXPECTED.size)
    assert_equal(obtained, DEFAULT_EXPECTED)
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
      FizzBuzz.is_fizz?(15) == false
    end
  end

  def test_singleton_is_buzz
    assert_block do
      FizzBuzz.is_buzz?(5)
      FizzBuzz.is_buzz?(15) == false
    end
  end

  def test_singleton_is_fizzbuzz
    assert_block do
      FizzBuzz.is_fizzbuzz?(15)
      FizzBuzz.is_fizzbuzz?(3) == false
      FizzBuzz.is_fizzbuzz?(5) == false
    end
  end

  def test_to_a
    fb = FizzBuzz.new(DEFAULT_EXPECTED.size)
    assert_equal(fb.to_a, DEFAULT_EXPECTED)
  end

  def test_each
    obtainted = []

    fb = FizzBuzz.new(DEFAULT_EXPECTED.size)
    fb.each {|i| obtainted << i }

    assert_equal(obtainted, DEFAULT_EXPECTED)
  end

  def test_for_fizzbuzz
    fb = FizzBuzz.new(15)
    assert_equal(fb.to_a[14], 'FizzBuzz')
  end

  def test_type_error
    assert_raise TypeError do
      FizzBuzz.new('')
    end
  end

  def test_argument_error
    assert_raise ArgumentError do
      FizzBuzz.new(-1)
    end
  end
end

# vim: set ts=2 sw=2 et :
# # encoding: utf-8
