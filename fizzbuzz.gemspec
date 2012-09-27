# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name     = 'fizzbuzz'
  s.version  = File.read('VERSION').strip
  s.license  = 'Apache 2'
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

# vim: set ts=2 sw=2 et :
# encoding: utf-8
