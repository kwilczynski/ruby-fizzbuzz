# frozen_string_literal: true

#
# Provides a convenient integration of _FizzBuzz_ with _Integer_ class.
#
class Integer
  #
  # call-seq:
  #    Integer.fizz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *three* (given
  # value is a _Fizz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.fizz?    #=> true
  #     5.fizz?    #=> false
  #    15.fizz?    #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizz?
  #
  def fizz?
    FizzBuzz.is_fizz?(self)
  end

  #
  # call-seq:
  #    Integer.buzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by *five* (given
  # value is a _Buzz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.buzz?    #=> false
  #     5.buzz?    #=> true
  #    15.buzz?    #=> false
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_buzz?
  #
  def buzz?
    FizzBuzz.is_buzz?(self)
  end

  #
  # call-seq:
  #   Integer.fizzbuzz? -> true or false
  #
  # Returns +true+ if a given integer value is divisible by both *three*
  # and *five* (given value is a _FizzBuzz_), or +false+ otherwise.
  #
  # Example:
  #
  #     3.fizzbuzz?    #=> false
  #     5.fizzbuzz?    #=> false
  #    15.fizzbuzz?    #=> true
  #
  # See also: FizzBuzz::[] and FizzBuzz::is_fizzbuzz?
  #
  def fizzbuzz?
    FizzBuzz.is_fizzbuzz?(self)
  end
end
