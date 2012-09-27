# -*- encoding: utf-8 -*-

#
# fizzbuzz.rb
#
# Copyright 2012 Krzysztof Wilczynski
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

require 'fizzbuzz/fizzbuzz'

class FizzBuzz
  def self.fizzbuzz(size, &block)
    if block_given?
      FizzBuzz.new(size).each {|i| block.call(i) }
    else
      FizzBuzz.new(size).to_a
    end
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
