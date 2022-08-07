# frozen_string_literal: true

shared_examples 'implements #add_entry' do
  it 'correctly' do
    expect do
      logs.each { |log| service.add_entry(log) }
    end.to_not raise_error
  end
end

shared_examples 'generates stat' do
  let(:finalized_stat) { service.finalized_stat }
  before do
    logs.each { |log| service.add_entry(log) }
  end

  it 'correctly' do
    expect(finalized_stat).to eq(expected_result)
    expect(finalized_stat.keys).to eq(expected_result.keys)
  end
end

module Stat
  describe BaseService do
    subject(:service) { described_class.new }

    describe '#add_entry' do
      let(:log) { nil }

      it 'throws NotImplementedError error' do
        expect { service.add_entry(log) }.to raise_error(NotImplementedError)
      end
    end

    describe '#finalized_stat' do
      let(:expected_value) { {} }

      it 'throws NotImplementedError error' do
        expect(service.finalized_stat).to eq(expected_value)
      end
    end
  end
end
