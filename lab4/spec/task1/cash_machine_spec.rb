require 'rspec'
require_relative '../../task1/cash_machine'

TEST_FILE_PATH = './test_file.txt'.freeze

RSpec.describe CashMachine, 'using external file' do
  subject { CashMachine.new(TEST_FILE_PATH) }

  let(:balance) { 150.0 }
  let(:amount) { 20.5 }

  before { File.write(TEST_FILE_PATH, balance) }
  after { File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH) }

  describe '#deposit' do
    it 'adds funds to the account ' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(amount)
      subject.deposit
      expect { subject.balance }.to output("Current balance: #{balance + amount}\n").to_stdout
    end
  end

  describe '#withdraw' do
    it 'withdraw funds from the account ' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(amount)
      subject.withdraw
      expect { subject.balance }.to output("Current balance: #{balance - amount}\n").to_stdout
    end
  end

  describe '#balance' do
    it 'displays the current balance' do
      expect { subject.balance }.to output("Current balance: #{balance}\n").to_stdout
    end
  end

  describe '#init' do
    it 'saves balance to file after exit' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('D', amount, 'W', amount * 2, 'Q')
      subject.init
      expect(File.read(TEST_FILE_PATH)).to eq((balance + amount - (amount * 2)).to_s)
    end
  end

end
