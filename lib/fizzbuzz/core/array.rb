# frozen_string_literal: true

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
  #    array.fizzbuzz          #=> [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
  #    array.fizzbuzz(true)    #=> ["FizzBuzz", 14, 13, "Fizz", 11, "Buzz", "Fizz", 8, 7, "Fizz", "Buzz", 4, "Fizz", 2, 1]
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
  def fizzbuzz(reverse = false, &block)
    if block_given?
      send(reverse ? :reverse : :to_a).each do |i|
        yield FizzBuzz[i]
      end
      self
    else
      send(reverse ? :reverse : :to_a).map do |i|
        FizzBuzz[i]
      end
    end
  end
end
