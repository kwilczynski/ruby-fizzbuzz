#
# Provides a convenient integration of _FizzBuzz_ with _Range_ class.
#
class Range
  #
  # call-seq:
  #    range.fizzbuzz( reverse ) {|value| block } -> self
  #    range.fizzbuzz( reverse )                  -> an Enumerator
  #
  # Returns either an +Enumerator+ or accepts a block if such is given. When a block is
  # given then it will call the block once for each subsequent value for a given range,
  # passing the value as a parameter to the block.
  #
  # Additionally, if the value of +reverse+ is set to be +true+ then the results will
  # be given in an <em>reverse order</em> whether in a resulting array or when passing
  # values to a block given.
  #
  # Example:
  #
  #    (1..15).fizzbuzz          #=> #<Enumerator: 1..15:fizzbuzz(false)>
  #    (1..15).fizzbuzz(true)    #=> #<Enumerator: 1..15:fizzbuzz(true)>
  #
  # Example:
  #
  #    (1..15).fizzbuzz {|value| puts "Got #{value}" }
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
      FizzBuzz.fizzbuzz(self.begin, self.end, reverse, &block)
      self
    else
      enum_for(:fizzbuzz, reverse)
    end
  end
end
