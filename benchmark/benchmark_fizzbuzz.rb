$: << File.expand_path('../../lib', __FILE__)

require 'time'
require 'benchmark'
require 'fizzbuzz'

CAPTION = "%8s%12s%11s%10s\n" % %w(User System Total Real)

n = (ARGV.shift || 1_000_000).to_i

start   = Time.now
array   = (1..n).to_a
reports = []

puts "FizzBuzz #{FizzBuzz::VERSION}, n = #{n}\n\n"

Benchmark.benchmark(CAPTION, 24) do |bm|
  reports << bm.report('FizzBuzz::fizzbuzz') do
    FizzBuzz.fizzbuzz(1, n)
  end

  reports << bm.report('FizzBuzz#each') do
    FizzBuzz.new(1, n).each {|i| i }
  end

  reports << bm.report('FizzBuzz#reverse_each') do
    FizzBuzz.new(1, n).reverse_each {|i| i }
  end

  reports << bm.report('FizzBuzz#to_a') do
    FizzBuzz.new(1, n).to_a
  end

  reports << bm.report('FizzBuzz::[]') do
    n.times {|i| FizzBuzz[i] }
  end

  reports << bm.report('FizzBuzz::is_fizz?') do
    n.times {|i| FizzBuzz.is_fizz?(i) }
  end

  reports << bm.report('FizzBuzz::is_buzz?') do
    n.times {|i| FizzBuzz.is_buzz?(i) }
  end

  reports << bm.report('FizzBuzz::is_fizzbuzz?') do
    n.times {|i| FizzBuzz.is_fizzbuzz?(i) }
  end

  reports << bm.report('Array#fizzbuzz') do
    array.fizzbuzz
  end

  reports << bm.report('Range#fizzbuzz') do
    (1..n).fizzbuzz {|i| i }
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
