# frozen_string_literal: true

shared_examples 'generates presentation for stat' do
  let(:stat) do
    {
      '/index' => 1,
      '/contact' => 2,
      '/help_page/1' => 3
    }
  end

  let(:expected_result) do
    "#{header}\n" \
      "/index 1 #{suffix}\n" \
      "/contact 2 #{suffix}\n" \
      "/help_page/1 3 #{suffix}\n" \
      "\n"
  end

  it 'correctly' do
    expect(presentation).to eq(expected_result)
  end
end

module Stat
  describe StringPresenter do
    describe '#call' do
      context 'when options not provided' do
        subject(:presentation) { described_class.call(stat) }

        let(:header) { 'Statistics:' }
        let(:suffix) { '' }

        it_behaves_like 'generates presentation for stat'
      end
    end

    describe '#call' do
      context 'when options not provided' do
        subject(:presentation) { described_class.call(stat, header: header, line_suffix: suffix) }

        let(:header) { 'Test header:' }
        let(:suffix) { 'test suffix' }

        it_behaves_like 'generates presentation for stat'
      end
    end
  end
end
