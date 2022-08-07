# frozen_string_literal: true

shared_examples 'generates error message' do
  let(:attrubutes) { { message: msg } }

  it 'correctly' do
    expect { raise error }.to raise_error(
      an_instance_of(described_class).and(having_attributes(attrubutes))
    )
  end
end
