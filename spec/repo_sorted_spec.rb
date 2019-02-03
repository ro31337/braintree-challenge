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
require_relative '../objects/repo_sorted'

describe RepoSorted do
  subject do
    RepoSorted.new(
      OpenStruct.new(
        db: {
          c: 3,
          b: 2,
          a: 1
        }
      )
    )
  end

  it 'should sort results' do
    expectations = [
      { expected_key: :a, expected_value: 1 },
      { expected_key: :b, expected_value: 2 },
      { expected_key: :c, expected_value: 3 }
    ].lazy
    subject.results do |k, v|
      e = expectations.next
      expect(k).to eq(e[:expected_key])
      expect(v).to eq(e[:expected_value])
    end
  end
end
