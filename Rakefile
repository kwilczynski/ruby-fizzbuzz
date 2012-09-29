# -*- encoding: utf-8 -*-

#
# Rakefile
#
# Copyright 2012 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
  t.warning = true
  t.libs << 'lib'
end

desc 'Build FizzBuzz gem file'
task :build do
  system "gem build #{FIZZBUZZ_GEMSPEC}"
end

task :test    => :tests
task :default => :build

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
