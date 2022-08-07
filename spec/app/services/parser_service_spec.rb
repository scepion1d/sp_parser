# frozen_string_literal: true

describe ParserService do
  subject(:service_call) { described_class.call(path) }

  shared_examples 'process file' do
    it 'correctly' do
      expect { service_call }.to_not raise_error
      expect(service_call).to eq(expected_result)
    end
  end

  context 'when path is incorrect' do
    let(:path) { '' }
    let(:expected_result) do
      [
        "Total visits:\n\n",
        "Unique visits:\n\n"
      ]
    end

    it_behaves_like 'process file'
  end

  context 'when path is correct and content is valid' do
    let(:path) { 'spec/fixtures/mixed_logs' }
    let(:expected_result) do
      [
        "Total visits:\n/home 19 visits\n/about 19 visits\n" \
        "/help_page/1 18 visits\n/about/2 17 visits\n/contact 16 visits\n\n",
        "Unique visits:\n/home 14 unique visits\n/about 13 unique visits\n" \
        "/help_page/1 12 unique visits\n/about/2 12 unique visits\n/contact 10 unique visits\n\n"
      ]
    end

    it_behaves_like 'process file'
  end

  context 'when path is correct and content is invalid' do
    let(:path) { 'spec/fixtures/invalid_logs' }
    let(:expected_result) do
      [
        "Total visits:\n\n",
        "Unique visits:\n\n"
      ]
    end

    it_behaves_like 'process file'
  end
end
