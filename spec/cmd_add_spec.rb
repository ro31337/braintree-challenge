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

require_relative '../objects/cmd_add'

describe CmdAdd do
  it 'should initialize' do
    cmd = CmdAdd.new(who: 'foo', card: 'object')
    expect(cmd.verb).to eq(:add)
    expect(cmd.who).to eq('foo')
    expect(cmd.card).to eq('object')
  end

  it 'should build from string' do
    cmd = CmdAdd.from('Add foo 12345 $123')
    expect(cmd.verb).to eq(:add)
    expect(cmd.who).to eq('foo')
    expect(cmd.card.number).to eq('12345')
    expect(cmd.card.limit).to eq(123)
  end
end
