# frozen_string_literal: true

module Files
  describe AccessValidator do
    describe '#valid?' do
      subject(:validation) { described_class.valid?(path) }
      let(:path) { '/file/path' }

      before { allow(File).to receive(:readable?).with(path).and_return(expected_value) }

      context 'when file is accessable' do
        let(:expected_value) { true }

        it 'passes validtion' do
          expect(validation).to eq(expected_value)
        end
      end

      context 'when file isn\'t accessable' do
        let(:expected_value) { false }

        it 'fails validtion' do
          expect(validation).to eq(expected_value)
        end
      end
    end
  end
end
