# -*- encoding: utf-8 -*-

# :enddoc:

#
# extconf.rb
#
# Copyright 2012-2015 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << ' -std=c99 -g -Wall -Wextra -pedantic'

unless RbConfig::CONFIG['host_os'][/darwin/]
  $LDFLAGS << ' -Wl,--as-needed'
end

$LDFLAGS << " %s" % ENV['LDFLAGS'] if ENV['LDFLAGS']

%w(CFLAGS CXXFLAGS CPPFLAGS).each do |variable|
    $CFLAGS << " %s" % ENV[variable] if ENV[variable]
end

unless have_header('ruby.h')
  abort <<-EOS

  You appear to be missing Ruby development libraries and/or header
  files. You can install missing compile-time dependencies in one of
  the following ways:

  - Debian / Ubuntu

      apt-get install ruby-dev

  - Red Hat / CentOS / Fedora

      yum install ruby-devel


  Alternatively, you can use either of the following Ruby version
  managers in order to install Ruby locally (for your user only)
  and/or system-wide:

  - Ruby Version Manager (for RVM, see http://rvm.io/)
  - Ruby Environment (for rbenv, see http://github.com/sstephenson/rbenv)

  EOS
end

dir_config('fizzbuzz')

create_header
create_makefile('fizzbuzz/fizzbuzz')

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
