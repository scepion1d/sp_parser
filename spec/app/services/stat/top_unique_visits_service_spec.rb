# frozen_string_literal: true

module Stat
  describe TopUniqueVisitsService do
    subject(:service) { described_class.new }

    let(:logs) do
      [
        { path: '/help_page/1', ip: '126.318.035.001' },
        { path: '/contact', ip: '184.123.665.001' },
        { path: '/help_page/1', ip: '184.123.665.002' },
        { path: '/help_page/1', ip: '184.123.665.003' },
        { path: '/contact', ip: '184.123.665.002' },
        { path: '/index', ip: '184.123.665.001' },
        { path: '/index', ip: '184.123.665.001' }
      ]
    end

    let(:expected_result) do
      {
        '/help_page/1' => 3,
        '/contact' => 2,
        '/index' => 1,
      }
    end

    it_behaves_like 'implements #add_entry'

    it_behaves_like 'generates stat'
  end
end
