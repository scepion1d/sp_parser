# frozen_string_literal: true

shared_examples 'generates unsorted stat' do
  it 'works correctly' do
    expect(subject.get).to eq(expected_result)
  end
end

shared_examples 'generates sorted stat' do
  it 'works correctly' do
    result = subject.get(order: order)

    expect(result).to eq(expected_result)
    expect(result.keys).to eq(expected_result.keys)
  end
end
