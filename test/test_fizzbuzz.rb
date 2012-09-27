# -*- encoding: utf-8 -*-

require 'test/unit'
require 'fizzbuzz'

DEFAULT_EXPECTED = [ 1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz' ]

class BizzBuzz_Test < Test::Unit::TestCase
  def test_for_fizzbuzz
    fb = FizzBuzz.new(15)
    assert_equal(fb.to_a[14], 'FizzBuzz')
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
