require 'rspec'
require_relative '..//cash_machine'

TEST_FILE_PATH = './test_file.txt'.freeze

RSpec.describe CashMachine, 'using external file' do
  subject { CashMachine.new(TEST_FILE_PATH) }

  let(:balance) { 150.0 }
  let(:amount) { 20.5 }

  before { File.write(TEST_FILE_PATH, balance) }
  after { File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH) }

  describe '#deposit' do
    it 'successful adds funds to the account' do
      expect(subject.deposit(amount)).to be
      expect(subject.balance).to eq(balance + amount)
    end

    it 'not successful adds funds to the account, when the deposit amount is less than zero' do
      expect(subject.deposit(-amount)).not_to be
    end
  end

  describe '#withdraw' do
    it 'successful withdraw funds from the account' do
      expect(subject.withdraw(amount)).to be
      expect(subject.balance).to eq(balance - amount)
    end

    it 'not successful withdraw funds from the account, when the withdraw amount is greater than the balance' do
      expect(subject.withdraw(balance + amount)).not_to be
    end
  end

  describe '#balance' do
    it 'returns the current balance' do
      expect(subject.balance).to eq(balance)
    end
  end
end
