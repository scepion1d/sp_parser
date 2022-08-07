# frozen_string_literal: true

require './lib/app_logger'

describe AppLogger do
  let(:msg) { 'test' }

  %i[debug info warn error fatal unknown].each do |level|
    it "Responds to :#{level}" do
      expect(described_class).to respond_to(level)
    end

    it "Writes the correct message with the correct log level (:#{level})" do
      allow_any_instance_of(Logger).to receive(level).with(msg)

      described_class.public_send(level, msg)

      expect(described_class.instance.logger).to have_received(level).with(msg)
    end
  end

  it 'Returns returns same instance of logger for each call' do
    expect(described_class.instance.logger).to eq(described_class.instance.logger)
  end
end
