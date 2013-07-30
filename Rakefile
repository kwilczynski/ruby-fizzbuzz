# -*- encoding: utf-8 -*-

# :enddoc:

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

begin
  require 'rake'
  require 'rdoc/task'
  require 'rake/testtask'
  require 'rake/extensiontask'
rescue LoadError
  require 'rubygems'
  require 'rake'
  require 'rdoc/task'
  require 'rake/testtask'
  require 'rake/extensiontask'
end

CLEAN.include   '*{.h,.o,.log,.so}', 'ext/**/*{.o,.log,.so}', 'Makefile', 'ext/**/Makefile'
CLOBBER.include 'lib/**/*.so', 'doc/**/*'

gem = Gem::Specification.new do |s|
  s.name        = 'fizzbuzz'
  s.description = 'Yet another FizzBuzz in Ruby'
  s.platform    = Gem::Platform::RUBY
  s.version     = File.read('VERSION').strip
  s.license     = 'Apache License, Version 2.0'
  s.author      = 'Krzysztof Wilczynski'
  s.email       = 'krzysztof.wilczynski@linux.com'
  s.homepage    = 'http://about.me/kwilczynski'

  s.rubyforge_project = 'fizzbuzz'
  s.rubygems_version  = '~> 1.3.7'
  s.has_rdoc          = true

  s.summary = <<-EOS
Provides simple and fast solution to a popular FizzBuzz problem for Ruby.
  EOS

  s.files = Dir['ext/**/*.{c,h,rb}'] +
            Dir['lib/**/*.rb'] +
            %w(Rakefile AUTHORS CHANGES CHANGES.rdoc COPYRIGHT
               LICENSE README README.rdoc TODO VERSION)

  s.executables   << 'fizzbuzz'
  s.require_paths << 'lib'
  s.extensions    << 'ext/fizzbuzz/extconf.rb'

  s.add_development_dependency 'rake', '~> 0.8.7'
  s.add_development_dependency 'rdoc', '~> 3.12'
  s.add_development_dependency 'test-unit', '~> 2.5.2'
  s.add_development_dependency 'rake-compiler', '~> 0.7.1'
end

RDoc::Task.new do |d|
  files = %w(AUTHORS CHANGES.rdoc COPYRIGHT LICENSE README.rdoc TODO)

  d.title = 'Yet another FizzBuzz in Ruby'
  d.main  = 'README.rdoc'

  d.rdoc_dir = 'doc/rdoc'

  d.rdoc_files.include 'ext/**/*.{c,h}', 'lib/**/*.rb'
  d.rdoc_files.include.add(files)

  d.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.verbose    = true
  t.warning    = true
  t.test_files = Dir['test/**/test_*']
end

Gem::PackageTask.new(gem) do |p|
  p.need_zip = true
  p.need_tar = true
end

Rake::ExtensionTask.new('fizzbuzz', gem) do |e|
  e.ext_dir = 'ext/fizzbuzz'
  e.lib_dir = 'lib/fizzbuzz'
end

Rake::Task[:test].prerequisites << :compile

task :default => :package

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
