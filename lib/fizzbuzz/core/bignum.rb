#
# Provides a convenient integration of _FizzBuzz_ with _Bignum_ class.
#
class Bignum
  #
  # call-seq:
  #    Bignum.fizz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *three* (given
  # value is a _Fizz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.fizz?    #=> false
  #    1000000000002.fizz?    #=> true
  #    1000000000005.fizz?    #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizz?
  #
  def fizz?
    FizzBuzz.is_fizz?(self)
  end

  #
  # call-seq:
  #    Bignum.buzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *five* (given
  # value is a _Buzz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.buzz?    #=> true
  #    1000000000002.buzz?    #=> false
  #    1000000000005.buzz?    #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_buzz?
  #
  def buzz?
    FizzBuzz.is_buzz?(self)
  end

  #
  # call-seq:
  #    Bignum.fizzbuzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by both *three*
  # and *five* (given value is a _FizzBuzz_), or +false+ otherwise.
  #
  # Example:
  #
  #    1000000000000.fizzbuzz?    #=> false
  #    1000000000002.fizzbuzz?    #=> false
  #    1000000000005.fizzbuzz?    #=> true
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizzbuzz?
  #
  def fizzbuzz?
    FizzBuzz.is_fizzbuzz?(self)
  end
end
