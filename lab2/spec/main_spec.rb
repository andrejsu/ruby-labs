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

RSpec.describe '#add_pokemons' do
  it 'returns an array with Pokemons' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Pikachu', 'Yellow',
                                                               'Snorlax', 'Light Blue',
                                                               'Charizard', 'Orange')
    expect(add_pokemons(3)).to eq([{ 'Pikachu' => 'Yellow' },
                                   { 'Snorlax' => 'Light Blue' },
                                   { 'Charizard' => 'Orange' }])
  end
end

RSpec.describe '#validate_int_input' do
  it 'returns an int' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('3')
    expect(validate_int_input).to eq(3)
  end

  it 'returns an error message' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('', '5!', 0)
    expect(validate_int_input).to eq(0)
  end
end

RSpec.describe '#format_pokemons' do
  it 'returns empty array' do
    expect(format_pokemons([])).to eq('[]')
  end

  it 'returns array with one pokemon' do
    expect(format_pokemons([{ 'Pikachu' => 'Yellow' }])).to eq('[{ name: \'Pikachu\', color: \'Yellow\' }]')
  end
end
