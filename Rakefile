require 'rake'

require 'rake/clean'
require 'rake/extensiontask'
require 'rake/testtask'

require 'rdoc/task'
require 'rubocop/rake_task'

CLEAN.include FileList['**/*{.o,.so,.dylib,.bundle}'],
              FileList['**/extconf.h'],
              FileList['**/Makefile']

CLOBBER.include FileList['**/tmp'],
                FileList['**/*.log'],
                FileList['doc/**'],
                FileList['tmp/']

gem = Gem::Specification.load('ruby-fizzbuzz.gemspec')

RDoc::Task.new do |d|
  d.title = 'Yet another FizzBuzz in Ruby!'
  d.main = 'README.md'
  d.options << '--line-numbers'
  d.rdoc_dir = 'doc/rdoc'
  d.rdoc_files.include FileList['ext/**/*.{c,h}', 'lib/**/*.rb']
  d.rdoc_files.include.add(%w[
    AUTHORS
    COPYRIGHT
    LICENSE
    CHANGELOG.md
    README.md
  ])
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/test_*']
  t.warning = true
end

RuboCop::RakeTask.new('lint') do |t|
  t.patterns = FileList['lib/**/*.rb', 'test/**/*.rb']
  t.fail_on_error = false
end

Gem::PackageTask.new(gem) do |p|
  p.need_zip = false
  p.need_tar = false
end

Rake::ExtensionTask.new('fizzbuzz', gem) do |e|
  e.source_pattern = '*.{c,h}'
  e.ext_dir = 'ext/fizzbuzz'
  e.lib_dir = 'lib/fizzbuzz'
end

desc 'Run benchmarks'
task :benchmark, [:first] do |_, argument|
  glob = File.expand_path('./benchmark/benchmark_*.rb', __dir__)

  file = 0
  Dir[glob].each do |f|
    process = ['ruby', f]
    process << argument[:first] if argument[:first]

    $stdout.sync = true
    $stderr.sync = true

    IO.popen(process) do |stream|
      stream.each { |line| puts line }
    end

    Process.waitpid rescue Errno::ECHILD

    file += 1
    puts if glob.size > 1 && file < 2
  end
end

task('default').clear

task default: %w[lint test]
