# frozen_string_literal: true

module Logs
  describe EntryValidator do
    describe '#valid?' do
      subject(:validation) { described_class.valid?(log_line) }

      context 'when passed line is nil' do
        let(:log_line) { nil }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed line is empty string' do
        let(:log_line) { '' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed line is non string object' do
        let(:log_line) { Object.new }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed invalid log line (invalid path)' do
        let(:log_line) { 'index 192.168.10.10' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed invalid log line (invalid ip)' do
        let(:log_line) { '/index 192.168.10' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed invalid log line (double space delimeter)' do
        let(:log_line) { '/index  192.168.10.10' }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed invalid log line (tab symbol delimiter)' do
        let(:log_line) { "/index\t192.168.10.10" }

        it 'fails validtion' do
          expect(validation).to be_falsey
        end
      end

      context 'when passed valid log line' do
        let(:log_line) { '/index 192.168.10.10' }

        it 'fails validtion' do
          expect(validation).to be_truthy
        end
      end
    end
  end
end
