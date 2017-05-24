gem 'rdoc', '>= 4.1.1'

require 'rake'
require 'rake/testtask'
require 'rake/extensiontask'
require 'rdoc/task'

CLEAN.include   '*{.h,.o,.log,.so}', 'ext/**/*{.o,.log,.so}', 'Makefile', 'ext/**/Makefile'
CLOBBER.include 'lib/**/*.so', 'doc/**/*'

gem = eval File.read('ruby-fizzbuzz.gemspec')

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

desc 'Run benchmarks'
task :benchmark, [:first] do |t,argument|
  glob = File.expand_path("../benchmark/*.rb", __FILE__)
  Dir[glob].each do |f|
    process = ['ruby', f]
    process << argument[:first] if argument[:first]

    STDOUT.sync = true
    STDERR.sync = true

    IO.popen(process) do |stream|
      stream.each {|line| puts line }
    end

    Process.waitpid rescue Errno::ECHILD
  end
end

Rake::Task[:test].prerequisites << :clobber
Rake::Task[:test].prerequisites << :compile

task :default => :test
