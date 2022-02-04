require 'rspec'
require_relative '../task2/duplicator'

TEST_FILE_PATH = './test_file.txt'.freeze
RESULT_FILE_PATH = './result.txt'.freeze

RSpec.describe 'dublicator' do
  let(:string) do
    <<-STRING
      Linda Summers 20
      Richard Robinson 18
      Heather Rogers 19
      Doris Brown 18
    STRING
  end
  let(:lines) { string.split("\n").map { |line| line.strip.chomp } }

  before { File.write(TEST_FILE_PATH, string) }
  after { File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH) }
  after { File.delete(RESULT_FILE_PATH) if File.exist?(RESULT_FILE_PATH) }

  describe '#read_file' do
    it 'returns an array of file lines' do
      expect(read_file(TEST_FILE_PATH)).to eq(lines)
    end
  end

  describe '#find_all' do
    it 'finds and returns all rows with the specified id' do
      expect(find_all(lines, 18)).to eq(['Richard Robinson 18', 'Doris Brown 18'])
    end
  end

  describe '#id_list' do
    it 'returns a hash with unique ids' do
      hash = { '18' => false, '19' => false, '20' => false }
      expect(id_list(lines)).to eq(hash)
    end
  end

  describe '#duplicator' do
    let(:input_message) { 'Enter the age of the students you want to include in the resulting list (to exit, enter -1): ' }

    context 'validation of the entered data' do
      it 'prints the contents of the file' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('Not a number', -1)
        expect { duplicator(TEST_FILE_PATH) }.to output("#{input_message}" \
                                                        "It's not a number.Try again, enter a number: \n").to_stdout
      end

      it 'prints the contents of the file' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(0, -1)
        expect { duplicator(TEST_FILE_PATH) }.to output("#{input_message}" \
                                                        'The entered number cannot be less than or equal to 0. ' \
                                                        "Try again\n#{input_message}\n").to_stdout
      end
    end

    context 'exit from method' do
      it 'by entering -1' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(-1)
        expect { duplicator(TEST_FILE_PATH) }.to output("#{input_message}\n").to_stdout
      end

      it 'by entering all ids' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(20, 19, 18)
        expect { duplicator(TEST_FILE_PATH) }.to output("#{input_message * 3}" \
                                                        "All data has been copied\n" \
                                                        "Linda Summers 20\n" \
                                                        "Heather Rogers 19\n" \
                                                        "Richard Robinson 18\n" \
                                                        "Doris Brown 18\n").to_stdout
      end
    end

    it 'writes the received data to a file result.txt .' do
      lines = ["Heather Rogers 19\n", "Richard Robinson 18\n", "Doris Brown 18"]
      allow_any_instance_of(Kernel).to receive(:gets).and_return(19, 18, -1)
      expect { duplicator(TEST_FILE_PATH) }.to output("#{input_message * 3}#{lines.join}\n").to_stdout
      expect(File.exist?(RESULT_FILE_PATH)).to be
      expect(File.readlines(RESULT_FILE_PATH)).to eq(lines)
    end
  end
end
