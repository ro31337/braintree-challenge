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

require 'ostruct'
require_relative '../objects/card/card'
require_relative '../objects/repository'

describe Repository do
  subject { Repository.new }

  let(:card) do
    double(Card)
  end

  before do
    subject.register(
      OpenStruct.new(
        verb: :add,
        who: 'foo',
        card: card
      )
    )
  end

  it 'should register add command' do
    expect(subject.db['foo']).to be
  end

  it 'should charge card on charge' do
    expect(card).to receive(:charge).with(123).exactly(1)
    subject.register(
      OpenStruct.new(
        verb: :charge,
        who: 'foo',
        balance: 123
      )
    )
  end

  it 'should credit card on credit' do
    expect(card).to receive(:credit).with(123).exactly(1)
    subject.register(
      OpenStruct.new(
        verb: :credit,
        who: 'foo',
        balance: 123
      )
    )
  end

  it 'should provide results' do
    expectations = [{ expected_key: 'foo', expected_value: card }].lazy
    expect(subject.results.size).to eq(1)
    subject.results do |k, v|
      e = expectations.next
      expect(k).to eq(e[:expected_key])
      expect(v).to eq(e[:expected_value])
    end
  end
end
