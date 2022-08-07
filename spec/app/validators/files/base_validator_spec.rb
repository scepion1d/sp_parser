# frozen_string_literal: true

module Files
  describe BaseValidator do
    describe '#valid?' do
      subject(:validation) { described_class.valid?(path) }

      context 'when path points to an absent file' do
        let(:path) { './spec/fixtures/absent_file' }

        it 'rises NotImplementedError exception' do
          expect { validation }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
