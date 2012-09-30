# -*- encoding: utf-8 -*-

#
# fizzbuzz.gemspec
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

Gem::Specification.new do |s|
  s.name     = 'fizzbuzz'
  s.version  = File.read('VERSION').strip
  s.license  = 'Apache License, Version 2.0'
  s.author   = 'Krzysztof Wilczynski'
  s.email    = 'krzysztof.wilczynski@linux.com'
  s.homepage = 'http://about.me/kwilczynski'

  s.rubyforge_project = 'fizzbuzz'
  s.rubygems_version  = '1.3.7'
  s.has_rdoc          = false

  s.description = 'Yet another FizzBuzz in Ruby'

  s.summary = <<-EOS
Provides simple and fast solution to a popular FizzBuzz problem for Ruby.
  EOS

  s.require_paths << 'lib'

  s.files = Dir['lib/**/*.rb'] +
            Dir['ext/**/*.{c,h,rb}'] +
            Dir['*.gemspec'] +
            [ 'Rakefile', 'AUTHORS', 'CHANGES', 'CHANGES.markdown', 'COPYRIGHT',
              'LICENSE', 'README', 'README.markdown', 'TODO', 'VERSION' ]

  s.bindir = 'bin'

  s.executables << 'fizzbuzz'
  s.extensions  << 'ext/fizzbuzz/extconf.rb'
  s.test_files  << 'test/test_fizzbuzz.rb'
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
