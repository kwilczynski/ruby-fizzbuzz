# -*- encoding: utf-8 -*-

$LOAD_PATH << './lib'

begin
  require 'rake'
rescue LoadError
  require 'rubygems'
  require 'rake'
end

FIZZBUZZ_GEMSPEC = 'fizzbuzz.gemspec'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name    = :tests
  t.verbose = true
  t.libs << 'lib'
end

desc 'Build FizzBuzz gem file'
task :build do
  system "gem build #{FIZZBUZZ_GEMSPEC}"
end

task :test    => :tests
task :default => :build

# vim: set ts=2 sw=2 et :
# encoding: utf-8
