# frozen_string_literal: true

describe FileError do
  context 'when file path provided' do
    subject(:error) { described_class.new path }

    let(:msg) { "Can't process file `#{path}`" }
    let(:path) { '/file/path' }

    it_behaves_like 'generates error message'
  end

  context 'when file path not provided' do
    subject(:error) { described_class.new }

    let(:msg) { 'Can\'t process file ``' }

    it_behaves_like 'generates error message'
  end
end
