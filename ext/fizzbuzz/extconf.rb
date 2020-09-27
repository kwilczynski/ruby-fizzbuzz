# frozen_string_literal: true

require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << ' -std=c99'
$CFLAGS << ' -Wall -Wextra -pedantic' if ENV['WALL']

if RbConfig::MAKEFILE_CONFIG['CC'] =~ /gcc/
  $CFLAGS << ' -O3' unless $CFLAGS =~ /-O\d/
  $CFLAGS << ' -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline'
end

unless RbConfig::CONFIG['host_os'] =~ /darwin/
  $LDFLAGS << ' -Wl,--as-needed'
end

if RbConfig::CONFIG['host_os'] =~ /mswin|mingw32|windows/
  $LDFLAGS << ' -static-libgcc'
end

$LDFLAGS << format(' %s', ENV['LDFLAGS']) if ENV['LDFLAGS']

%w(CFLAGS CXXFLAGS CPPFLAGS).each do |variable|
  $CFLAGS << format(' %s', ENV[variable]) if ENV[variable]
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


    Alternatively, you can use either of the following Ruby version
    managers in order to install Ruby locally (for your user only)
    and/or system-wide:

    - Ruby Version Manager (for RVM, see http://rvm.io/)
    - Ruby Environment (for rbenv, see http://github.com/sstephenson/rbenv)
    - Change Ruby (for chruby, see https://github.com/postmodern/chruby)
  EOS
end

dir_config('fizzbuzz')

create_header
create_makefile('fizzbuzz/fizzbuzz')
