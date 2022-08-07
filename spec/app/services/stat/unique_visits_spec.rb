# frozen_string_literal: true

module Stat
  describe UniqueVisits do
    subject(:stat) { described_class.new(logs) }

    let(:logs) do
      [
        { path: '/help_page/1', ip: '126.318.035.001' },
        { path: '/contact', ip: '184.123.665.001' },
        { path: '/help_page/1', ip: '184.123.665.002' },
        { path: '/help_page/1', ip: '184.123.665.003' },
        { path: '/contact', ip: '184.123.665.002' },
        { path: '/index', ip: '184.123.665.001' }
      ]
    end

    context 'without sort' do
      let(:expected_result) do
        {
          '/contact' => 2,
          '/index' => 1,
          '/help_page/1' => 3
        }
      end

      it_behaves_like 'generates unsorted stat'
    end

    context 'with asc sort' do
      let(:expected_result) do
        {
          '/index' => 1,
          '/contact' => 2,
          '/help_page/1' => 3
        }
      end
      let(:order) { :asc }

      it_behaves_like 'generates sorted stat'
    end

    context 'with dsc sort' do
      let(:expected_result) do
        {
          '/help_page/1' => 3,
          '/contact' => 2,
          '/index' => 1
        }
      end
      let(:order) { :dsc }

      it_behaves_like 'generates sorted stat'
    end
  end
end
