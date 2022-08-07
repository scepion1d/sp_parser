# frozen_string_literal: true

describe LogsError do
  context 'when message provided' do
    subject(:error) { described_class.new msg }
    let(:msg) { 'Test message' }

    it_behaves_like 'generates error message'
  end

  context 'when message not provided' do
    subject(:error) { described_class.new }
    let(:msg) { 'Can\'t process provided logs' }

    it_behaves_like 'generates error message'
  end
end
