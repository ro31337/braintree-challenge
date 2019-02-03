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

require_relative '../lib/decorator'

# Valid card decorator.
# Author:: Roman Pushkin (roman.pushkin@gmail.com)
# Copyright:: Copyright (c) 2019 Roman Pushkin
# License:: MIT
class CardValid
  include Decorator
  attr_reader :origin

  def initialize(origin)
    @origin = origin
  end

  def charge(amount)
    return unless valid?
    origin.charge(amount)
  end

  def credit(amount)
    return unless valid?
    origin.credit(amount)
  end

  def value
    return 'error' unless valid?
    origin.value
  end

  private

  def valid?
    number = origin.number
      .gsub(/\D/, '') # remove non-digits
      .reverse # read from right to left

    sum = 0
    i = 0

    number.each_char do |ch|
      n = ch.to_i

      # Step 1
      n *= 2 if i.odd?

      # Step 2
      n = 1 + (n - 10) if n >= 10

      sum += n
      i   += 1
    end

    # Step 3
    (sum % 10).zero?
  end
end
