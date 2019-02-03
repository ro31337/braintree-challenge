# frozen_string_literal: true

# Copyright (c) 2019 Roman Pushkin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Decorator pattern for Ruby.
# Author:: Roman Pushkin (roman.pushkin@gmail.com)
# Copyright:: Copyright (c) 2019 Roman Pushkin
# License:: MIT
module Decorator
  def method_missing(method, *args)
    if any_origin_in_chain_respond_to?(method, args)
      origin.send(method, *args)
    else
      super
    end
  end

  def respond_to_missing?(method_name, *args)
    any_origin_in_chain_respond_to?(method_name, args)
  end

  private

  def any_origin_in_chain_respond_to?(method, current = origin, *args)
    if current.respond_to?(method, args)
      true
    elsif current.respond_to?(:origin, args)
      any_origin_in_chain_respond_to?(method, current.origin, args)
    else
      false
    end
  end
end
