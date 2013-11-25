# -*- encoding: utf-8 -*-

# :enddoc:

#
# benchmark_fizzbuzz.rb
#
# Copyright 2012-2013 Krzysztof Wilczynski
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

require 'benchmark'
require 'fizzbuzz'

n     = 1_000_000
array = (1 .. n).to_a

Benchmark.bm(24) do |bm|
  bm.report('FizzBuzz::fizzbuzz') do
    FizzBuzz.fizzbuzz(1, n)
  end

  bm.report('FizzBuzz#each') do
    FizzBuzz.new(1, n).each {|i| i }
  end

  bm.report('FizzBuzz#reverse_each') do
    FizzBuzz.new(1, n).reverse_each {|i| i }
  end

   bm.report('FizzBuzz#to_a') do
    FizzBuzz.new(1, n).to_a
  end

  bm.report('FizzBuzz::[]') do
    n.times {|i| FizzBuzz[i] }
  end

  bm.report('FizzBuzz::is_fizz?') do
    n.times {|i| FizzBuzz.is_fizz?(i) }
  end

  bm.report('FizzBuzz::is_buzz?') do
    n.times {|i| FizzBuzz.is_buzz?(i) }
  end

  bm.report('FizzBuzz::is_fizzbuzz?') do
    n.times {|i| FizzBuzz.is_fizzbuzz?(i) }
  end

  bm.report('Array#fizzbuzz') do
    (1 .. n).fizzbuzz
  end

  bm.report('Range#fizzbuzz') do
    array.fizzbuzz
  end
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
