# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.7.0] - 2014-12-15
### Added

- Added `to_hash`, `as_json`, `to_json` and `from_json` (_singleton_) to the _FizzBuzz_ class.
- Added rudimentary `Vagrantfile` that can be used to build a development environment.
- Added the `Guard` Ruby gem for convenience, with an appropriate `Guardfile`.
- Added _LLVM_ (`clang`) compiler to build with to _Travis CI_.

### Changed

- Re-factored `fizzbuzz` (_singleton_) from the _FizzBuzz_ class to speed it up.
- Re-factored tests to utilise modern version of the `test-unit` Ruby gem.
- Re-factored and cleaned up small portions of code and documentation.
- Updated `Rakefile` to no longer run `test` before `benchmark`.

### Fixed

- Correctly return `Enumerator` when integrating with the _Range_ class.
- Fixed benchmarks concerning _Array_ and _Range_ integration.
- Fixed _Travis CI_ build against _Rubinius_.
- Fixed build to make it work with _C++_ compilers.
- Fixed version number to comply with [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

### Deprecated

- No longer use of `Enumerable#entries` in the _Array_ integration, achieving
better performance.
- Retired testing with Ruby _1.9.2_ and _2.1.0_, and added _2.1.5_ on _Travis CI_.
- Removed _BitDeli_ badge.

## [0.6.0] - 2014-02-23
### Added

- Added Ruby _2.1.0_ to _Travis CI_.
- Added _BitDeli_ and _Gemnasium_ integration.

### Changed

- Updated development dependencies.
- Re-factored and cleaned up small portions of code.
- Made _Rake_ `test` task to be the default tasks.
- Updated the `.gitignore` file to cover _Bundler_, _rbenv_, etc.

### Fixed

- Fixed issue reported by _LLVM_ (`clang`).

## [0.5.0] - 2013-11-26
### Added

- Added integration with Array and Range types.
- Added simple benchmark.

## [0.4.0] - 2013-11-18
### Added

- Added _Coveralls_ and _Code Climate_ integration (and hence improved code test coverage).

### Changed

- Improved error handling and made code more resilient to errors.

### Fixed

- Fixed formatting and white spaces.

### Deprecated

- Retired support for Ruby 1.8.x (no support for _MRI_, _Ruby Enterprise Edition_ and _Rubinius_).

## [0.3.0] - 2013-08-31
### Added

- Added custom exceptions and improved error handling.
- Added more variety of Rubies on which tests are being run with _Travis CI_.
- Added project to [RubyGems](http://rubygems.org) so it can be installed with
just `gem install ruby-fizzbuzz` command.

### Changed

- Renamed project from _fizzbuzz_ to _ruby-fizzbuzz_ to avoid clashes with other
Ruby gems hosted on _RubyGems_ web site.
- Made `mkmf` in `extconf.rb` more user-friendly (it now reports missing build-time
dependencies better).
- Split Ruby gem specification (or _gemspec_ if you wish) away from _Rakefile_
into its own file (namely `ruby-fizzbuzz.gemspec`).
- Improved documentation and removed bunch of small code smells.

## [0.2.0] - 2012-09-29
### Added

- Added `is_fizz?`, `is_buzz?` and `is_fizzbuzz?` singleton methods to _FizzBuzz_ class.
- Added `fizz?`, `buzz?` and `fizzbuzz?` methods to the _Integer_ class via a monkey-patch
for convenience. ([#2](https://github.com/kwilczynski/ruby-fizzbuzz/issues/2))

### Changed

- Changed behaviour of the `FizzBuzz#[]` singleton method, so it will yield a _FizzBuzz_
result for a given arbitrary Integer value. ([#1](https://github.com/kwilczynski/ruby-fizzbuzz/issues/1))
- Re-factored code to make it cleaner, and added more tests and improved coverage.
- Re-factored `FizzBuzz` so it now does not assume that we always want to calculate
results from `1` to `n` -- it is now possible to calculate _FizzBuzz_ results for
given `n`, `m` values, where `n` denotes start and `m` denotes stop value.

## [0.1.0] - 2012-09-27
### Added

- First version of FizzBuzz.

[Unreleased]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.8.0...HEAD
[0.7.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.7.0...v0.8.0
[0.6.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.6.0...v0.7.0
[0.5.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/kwilczynski/ruby-fizzbuzz/compare/v0.1.0...v0.2.0
