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

describe Card do
  subject { Card.new('12345', 100) }

  it 'should initialize' do
    expect(subject.number).to eq('12345')
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(0)
  end

  it 'should charge' do
    subject.charge(5)
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(5)
  end

  it 'should credit' do
    subject.credit(5)
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(-5)
  end

  it 'should not charge over limit' do
    subject.charge(101)
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(0)
  end

  it 'should calculate value' do
    subject.charge(50)
    subject.credit(20)
    expect(subject.limit).to eq(100)
    expect(subject.balance).to eq(30)
    expect(subject.value).to eq('$30')
  end
end
