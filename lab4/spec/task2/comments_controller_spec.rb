require 'rspec'
require_relative '../../task2/comments_controller'

RSpec.describe CommentsController do
  describe '#show' do
    it 'show comment' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('Comment 1', 'Comment 2', '2')
      subject.create
      subject.create
      expect { subject.show }.to output('Enter the number of the comment you want to display \\ q to exit: ' \
                                        "2. Comment 2\n").to_stdout
    end
  end

  describe '#create' do
    let(:text) { 'Comment 1' }

    it 'create comment' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(text)
      expect(subject.create).to eq({ 1 => text })
    end

    it "enter 'q' and exit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('q')
      expect(subject.create).to be_nil
    end
  end

  describe '#update' do
    let(:id) { 1 }
    let(:text) { 'Updated comment' }

    it 'update comment' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('Comment 1', id.to_s, text)
      subject.create
      expect(subject.update).to eq({ id => text })
    end

    it "enter 'q' and exit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('q')
      expect(subject.create).to be_nil
    end
  end

  describe '#delete' do
    let(:id) { 1 }

    it 'delete comment' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('Comment 1', id.to_s)
      subject.create
      expect(subject.destroy).to be_nil
    end
  end
end
