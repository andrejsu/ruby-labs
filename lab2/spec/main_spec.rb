require 'rspec'
require_relative '../main'

RSpec.describe '#foo' do
  it 'returns the reversed word' do
    word = 'Hello'
    expect(foo(word)).to eq(word.reverse)
  end

  it 'returns the number 2 to the power of the length of the entered word' do
    word = 'HelloCS'
    expect(foo(word)).to eq(2**word.length)
  end

  it 'checks case sensitivity' do
    word = 'Hellocs'
    expect(foo(word)).to eq(word.reverse)
  end
end
