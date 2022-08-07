# frozen_string_literal: true

module Files
  describe PathValidator do
    describe '#valid?' do
      subject(:validation) { described_class.valid?(path) }

      context 'when path is nil' do
        let(:path) { nil }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when path is empty' do
        let(:path) { '' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when path points to an absent file' do
        let(:path) { './spec/fixtures/absent_file' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when path points to a dir' do
        let(:path) { './spec/fixtures/' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when path points file' do
        let(:path) { './spec/fixtures/valid_logs' }

        it 'passes validtion' do
          expect(validation).to be_truthy
        end
      end
    end
  end
end
