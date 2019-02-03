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

require_relative '../objects/card'
require_relative '../objects/card_valid'

describe CardValid do
  subject { CardValid.new(Card.new('12345', 100)) }

  it 'should initialize' do
    expect(subject.number).to eq('12345')
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(0)
  end

  context 'when card is valid' do
    let(:card) { CardValid.new(Card.new('4111111111111111', 100)) }

    it 'should credit' do
      card.credit(5)
      expect(card.balance).to eq(-5)
    end

    it 'should charge' do
      card.charge(5)
      expect(card.balance).to eq(5)
    end

    it 'should have value' do
      card.charge(5)
      expect(card.value).to eq('$5')
    end
  end

  context 'when card is not valid' do
    let(:card) { CardValid.new(Card.new('1234567890123456', 100)) }

    it 'should not credit' do
      card.credit(5)
      expect(card.balance).to eq(0)
    end

    it 'should not charge' do
      card.charge(5)
      expect(card.balance).to eq(0)
    end

    it 'should not have value' do
      card.charge(5)
      expect(card.value).to eq('error')
    end
  end
end
