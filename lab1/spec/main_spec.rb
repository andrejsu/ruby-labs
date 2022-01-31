require 'rspec'
require_relative '../main'

RSpec.describe '#greeting' do
  let(:first_name) { 'Andrew' }
  let(:second_name) { 'Sukhikh' }

  it 'returns a message saying that you are under 18 yo' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return(first_name, second_name, 9)
    expect(greeting).to eq("Привет, #{first_name} #{second_name}. Тебе меньше 18 лет, но начать " \
                           'учиться программировать никогда не рано.')
  end

  it 'returns a message saying that you are over 18 yo' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return(first_name, second_name, 30)
    expect(greeting).to eq("Привет, #{first_name} #{second_name}. Самое время заняться делом!")
  end
end
