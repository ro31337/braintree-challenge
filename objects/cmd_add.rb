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

require 'bigdecimal'
require_relative 'card/card'
require_relative 'card/valid_card'

# Add command.
# Author:: Roman Pushkin (roman.pushkin@gmail.com)
# Copyright:: Copyright (c) 2019 Roman Pushkin
# License:: MIT
class CmdAdd
  REGEX = /^Add\s(?<who>\w+)\s(?<card>\d+)\s\$(?<limit>\d+)/i.freeze
  attr_reader :verb, :who, :card, :limit

  def initialize(who:, card:)
    @verb = :add
    @who = who
    @card = card
  end

  def self.from(line)
    m = line.match(CmdAdd::REGEX)
    CmdAdd.new(
      who: m[:who],
      card: ValidCard.new(
        Card.new(
          m[:card],
          BigDecimal(m[:limit])
        )
      )
    )
  end
end
