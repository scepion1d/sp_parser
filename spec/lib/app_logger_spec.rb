# frozen_string_literal: true

describe AppLogger do
  let(:msg) { 'test' }

  %i[debug info warn error fatal unknown].each do |level|
    it "responds to :#{level}" do
      expect(described_class).to respond_to(level)
    end

    it "writes the correct message with the correct log level (:#{level})" do
      allow_any_instance_of(Logger).to receive(level).with(msg)

      described_class.public_send(level, msg)

      expect(described_class.instance.logger).to have_received(level).with(msg)
    end
  end

  it 'returns same instance of logger for each call' do
    expect(described_class.instance.logger).to eq(described_class.instance.logger)
  end

  context 'when custom logger provided' do
    subject(:logger) { described_class.instance.logger }

    let(:custom_logger) { Object.new }

    before do
      Singleton.__init__(described_class)
      described_class.use(custom_logger)
    end

    after { Singleton.__init__(described_class) }

    it 'uses custom logger instead of default' do
      expect(logger).to eq(custom_logger)
    end
  end
end
