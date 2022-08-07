# frozen_string_literal: true

shared_examples 'generates unsorted stat' do
  it 'works correctly' do
    expect(subject.get_data).to eq(expected_result)
  end
end

shared_examples 'generates sorted stat' do
  it 'works correctly' do
    result = subject.get_data(order: order)

    expect(result).to eq(expected_result)
    expect(result.keys).to eq(expected_result.keys)
  end
end

shared_examples 'generates correct unsorted report' do
  it 'works correctly' do
    result = subject.get_report

    expect(result).to start_with(expected_header)
    expected_entries.each do |expected_entry|
      expect(result).to include(expected_entry)
    end
  end
end

shared_examples 'generates correct sorted report' do
  it 'works correctly' do
    expect(subject.get_report(order: order)).to eq(expected_result)
  end
end

module Stat
  describe Base do
    subject(:stat) { described_class.new([]) }

    describe '#stat' do
      it 'throws NotImplementedError error' do
        expect { stat.send(:stat) }.to raise_error(NotImplementedError)
      end
    end

    describe '#get_data' do
      it 'throws NotImplementedError error' do
        expect { stat.get_data }.to raise_error(NotImplementedError)
      end
    end

    describe '#get_report' do
      it 'throws NotImplementedError error' do
        expect { stat.get_report }.to raise_error(NotImplementedError)
      end
    end
  end
end
