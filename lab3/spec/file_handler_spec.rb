require 'rspec'
require_relative '../task1/file_handler'

TEST_FILE_PATH = './test_file.txt'.freeze

RSpec.describe FileHandler do
  subject { FileHandler.new(TEST_FILE_PATH) }

  let(:string) do
    <<-STRING
      Matthew McConaughey
      Ryan Gosling
      Sylvester Stallone
      Leonardo DiCaprio
      Ryan Reynolds
    STRING
  end
  let(:array) { string.split("\n") }

  before { File.write(TEST_FILE_PATH, string) }
  after { File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH) }

  context 'validates instance variables' do
    describe '#filename=' do
      it 'throws an exception when a file does not exist' do
        expect { subject.filename = '' }.to raise_error(SystemCallError)
      end
    end
  end

  describe '#index' do
    it 'prints the contents of the file' do
      expect { subject.index }.to output(string).to_stdout
    end
  end

  describe '#find' do
    let(:index) { 1 }
    it 'finds a specific line in the file and returns it' do
      expect(subject.find(index)).to eq(array[index].strip.chomp)
    end
  end
end
