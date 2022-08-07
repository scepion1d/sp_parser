# frozen_string_literal: true

module Stat
  describe TotalVisits do
    subject(:stat) { described_class.new(logs) }

    let(:logs) do
      [
        { path: '/help_page/1', ip: '126.318.035.038' },
        { path: '/contact', ip: '184.123.665.067' },
        { path: '/help_page/1', ip: '184.123.665.067' },
        { path: '/help_page/1', ip: '184.123.665.067' },
        { path: '/contact', ip: '184.123.665.067' },
        { path: '/index', ip: '184.123.665.067' }
      ]
    end

    describe '#get_report' do
      let(:header) { 'Total visits:' }
      let(:suffix) { 'visits' }

      context 'without sort' do
        let(:expected_header) { "#{header}\n" }
        let(:expected_entries) do
          [
            "/contact 2 #{suffix}\n",
            "/index 1 #{suffix}\n",
            "/help_page/1 3 #{suffix}\n"
          ]
        end

        it_behaves_like 'generates correct unsorted report'
      end

      context 'without asc sort' do
        let(:expected_result) do
          "#{header}\n" \
            "/index 1 #{suffix}\n" \
            "/contact 2 #{suffix}\n" \
            "/help_page/1 3 #{suffix}\n" \
            "\n"
        end
        let(:order) { :asc }

        it_behaves_like 'generates correct sorted report'
      end

      context 'without dsc sort' do
        let(:expected_result) do
          "#{header}\n" \
            "/help_page/1 3 #{suffix}\n" \
            "/contact 2 #{suffix}\n" \
            "/index 1 #{suffix}\n" \
            "\n"
        end
        let(:order) { :dsc }

        it_behaves_like 'generates correct sorted report'
      end
    end

    describe '#get_data' do
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
end
