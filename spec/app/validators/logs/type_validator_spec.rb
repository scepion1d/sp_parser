# frozen_string_literal: true

module Logs
  describe TypeValidator do
    describe '#valid?' do
      subject(:validation) { described_class.valid?(logs) }

      context 'when passed logs is nil' do
        let(:logs) { nil }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed logs isn\' an array' do
        let(:logs) { 'invalid logs' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed logs is empty array' do
        let(:logs) { [] }

        it 'fails validtion' do
          expect(validation).to be_truthy
        end
      end

      context 'when passed logs array contain nonstring entries' do
        let(:logs) { ['log line', nil, 'log line'] }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed logs array contain only string entries' do
        let(:logs) { ['log line', 'log_line', 'log line'] }

        it 'fails validtion' do
          expect(validation).to be_truthy
        end
      end
    end
  end
end
