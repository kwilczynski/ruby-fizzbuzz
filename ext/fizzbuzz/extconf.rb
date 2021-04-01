# frozen_string_literal: true

require 'mkmf'

def darwin?
  RbConfig::CONFIG['target_os'] =~ /darwin/
end

def windows?
  RbConfig::CONFIG['target_os'] =~ /mswin|mingw32|windows/
end

if ENV['CC']
  RbConfig::CONFIG['CC'] = RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC']
end

ENV['CC'] = RbConfig::CONFIG['CC']

append_cflags(ENV["CFLAGS"].split) if ENV["CFLAGS"]
append_cppflags(ENV["CPPFLAGS"].split) if ENV["CPPFLAGS"]
append_ldflags(ENV["LDFLAGS"].split) if ENV["LDFLAGS"]

$CFLAGS += ' -std=c99'

if RbConfig::CONFIG['CC'] =~ /gcc/
  $CFLAGS += ' -O3' unless $CFLAGS =~ /-O\d/
end

%w[
  -Wcast-qual
  -Wwrite-strings
  -Wconversion
  -Wmissing-noreturn
  -Winline
].select do |flag|
  try_link('int main(void) { return 0; }', flag)
end.each do |flag|
  $CFLAGS += ' ' + flag
end

unless darwin?
  $LDFLAGS += ' -Wl,--as-needed -Wl,--no-undefined -Wl,--exclude-libs,ALL'
end

if windows?
  $LDFLAGS += ' -static-libgcc'
end

unless have_header('ruby.h')
  abort "\n" + (<<-EOS).gsub(/^[ ]{,3}/, '') + "\n"
    You appear to be missing Ruby development libraries and/or header
    files. You can install missing compile-time dependencies in one of
    the following ways:

    - Debian / Ubuntu

        apt-get install ruby-dev

    - Red Hat / CentOS / Fedora

        yum install ruby-devel or dnf install ruby-devel

    - Mac OS X (Darwin)

        brew install ruby (for Homebrew, see https://brew.sh)
        port install ruby2.6 (for MacPorts, see https://www.macports.org)

    - OpenBSD / NetBSD

        pkg_add ruby (for pkgsrc, see https://www.pkgsrc.org)

    - FreeBSD

        pkg install ruby (for FreeBSD Ports, see https://www.freebsd.org/ports)

    Alternatively, you can use either of the following Ruby version
    managers in order to install Ruby locally (for your user only)
    and/or system-wide:

    - Ruby Version Manager (for RVM, see https://rvm.io)
    - Ruby Environment (for rbenv, see https://github.com/sstephenson/rbenv)
    - Change Ruby (for chruby, see https://github.com/postmodern/chruby)

    More information about how to install Ruby on various platforms
    available at the following web site:

      https://www.ruby-lang.org/en/documentation/installation
  EOS
end

dir_config('fizzbuzz')

create_header
create_makefile('fizzbuzz/fizzbuzz')
