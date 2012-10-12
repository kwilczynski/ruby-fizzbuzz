fizzbuzz (0.0.2)

  * Added is_fizz?, is_buzz? and is_fizzbuzz? singleton methods to FizzBuzz class;
  * Added fizz?, buzz? and fizzbuzz? methods to the Integer class via a monkey-patch
    for convenience;
  * Changed behaviour of the FizzBuzz#[] singleton method, so it will yield a FizzBuzz
    result for a given arbitrary Integer value;
  * Re-factored code to make it cleaner, and added more tests and improved coverage;
  * Re-factored FizzBuzz so it now does not assume that we always want to calculate
    results from 1 to n -- it is now possible to calculate FizzBuzz results for given
    n, m values, where n denotes start and m denotes stop value.

-- Krzysztof Wilczynski <krzysztof.wilczynski@linux.com>  Sat, 29 Sep 2012 14:53:35 +0100

fizzbuzz (0.0.1)

  * First version.

-- Krzysztof Wilczynski <krzysztof.wilczynski@linux.com>  Thu, 27 Sep 2012 12:54:45 +0200
