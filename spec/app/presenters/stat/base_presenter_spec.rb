# frozen_string_literal: true

shared_examples 'generates presentation for stat' do
  subject(:presentation) { described_class.call(stat_) }

  let(:stat_) do
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
  describe BasePresenter do
    let(:header) { 'Statistics:' }
    let(:suffix) { '' }

    describe '#call' do
      it_behaves_like 'generates presentation for stat'
    end
  end
end
