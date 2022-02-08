require 'rspec'
require_relative '../../task2/controller'

RSpec.describe Controller do
  subject { Controller.new(['Element 1', 'Element 2']) }

  describe '#index' do
    it 'displays all elements' do
      expect { subject.index }.to output("1. Element 1\n2. Element 2\n").to_stdout
    end
  end

  describe '#validate_input' do
    it "enter 'q' and exit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('q')
      expect(subject.send(:validate_input)).to eq(nil)
    end

    it 'enter empty string' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('', 'q')
      expect { subject.send(:validate_input) }.to output("Oops, you didn't enter anything. Try again\n").to_stdout
    end

    it 'enter number less than one' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('0', 'q')
      expect { subject.send(:validate_input) }.to output("The number cannot be less than one. Try again\n").to_stdout
    end

    it 'enter not a number' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('not a number', 'q')
      expect { subject.send(:validate_input) }.to output("Oops, you entered not a number. Try again\n").to_stdout
    end
  end

  describe '#validate_element' do
    it 'returns id if the element exists' do
      expect(subject.send(:validate_element) { 1 }).to eq(1)
    end

    it 'displays an error if such an element does not exist' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(3, 1)
      expect { subject.send(:validate_element) { gets } }.to output("There is no element with this number\n").to_stdout
    end
  end
end
