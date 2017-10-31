$: << File.expand_path('../../lib', __FILE__)

require 'time'
require 'benchmark'
require 'fizzbuzz'

CAPTION = "%8s%12s%11s%10s\n" % %w(User System Total Real)

n = (ARGV.shift || 1_000_000).to_i

start   = Time.now
array   = Array(1..n)
reports = []

def fizzbuzz_1(array)
  array.each do |n|
    divisible_by_3 = (n % 3 == 0)
    divisible_by_5 = (n % 5 == 0)

    if divisible_by_3 && divisible_by_5
      'FizzBuzz'
    elsif divisible_by_3
      'Fizz'
    elsif divisible_by_5
      'Buzz'
    else
      n
    end
  end
end

def fizzbuzz_2(array)
  array.each do |n|
    FB[n]
  end
end

Benchmark.benchmark(CAPTION, 24) do |bm|
  reports << bm.report('Pure Ruby') do
    fizzbuzz_1(array)
  end

  reports << bm.report('Using FizzBuzz') do
    fizzbuzz_2(array)
  end

  []
end

reports.sort_by! {|i| i.real }

overall = reports.reduce(:+)
average = overall / reports.size

fastest, slowest = reports.shift, reports.pop

padding = [fastest.label, slowest.label].max
padding = padding.size > 16 ? 24 : 16

puts "\n%15s%s%16s\n" % ['', CAPTION.strip, 'Name'] +
  "%s%48s [ %-#{padding}s ]\n" % ['Fastest:', fastest.to_s.strip, fastest.label.strip] +
  "%s%48s [ %-#{padding}s ]\n" % ['Slowest:', slowest.to_s.strip, slowest.label.strip] +
  "%s%48s\n" % ['Average:', average.to_s.strip] +
  "%s%48s\n" % ['Overall:', overall.to_s.strip] +
  "\n%s%13.6f\n" % ['Wall Clock Time:', Time.now.to_f - start.to_f]
