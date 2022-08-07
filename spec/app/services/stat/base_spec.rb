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

module Stat
  describe Base do
    subject(:service) { described_class.new(logs) }
    let(:logs) { [] }

    describe '#stat' do
      it 'throws NotImplementedError error' do
        expect { service.send(:stat) }.to raise_error(NotImplementedError)
      end

      context 'when #stat method implemented' do
        let(:initial_data) { [{ path: '/index', ip: '192.168.1.1' }] }
        let(:processed_data) { [{ path: '/about', ip: '192.168.1.2' }] }

        before do
          allow_any_instance_of(described_class).to receive(:stat).and_return(initial_data)
        end

        shared_examples '#sort receives call and returns sorted data' do
          it 'correctly' do
            expect(service.get(order: order)).to eq(processed_data)
            expect(service).to have_received(:sort).with(order)
          end
        end

        shared_examples '#sort receives call and returns unsorted data' do
          it 'correctly' do
            expect(service.get(order: order)).to eq(initial_data)
            expect(service).to_not receive(:sort)
          end
        end

        context 'when provided sotring order' do
          before do
            allow_any_instance_of(described_class).to receive(:sort).with(order).and_return(processed_data)
          end

          context ':asc' do
            let(:order) { :asc }

            it_behaves_like '#sort receives call and returns sorted data'
          end

          context ':dsc' do
            let(:order) { :dsc }

            it_behaves_like '#sort receives call and returns sorted data'
          end

          context 'incorrect value' do
            let(:order) { :test }

            it_behaves_like '#sort receives call and returns unsorted data'
          end

          context 'nil value' do
            let(:order) { nil }

            it_behaves_like '#sort receives call and returns unsorted data'
          end
        end

        context 'when sorting order isn\'t provided' do
          it '#sort doesn\'t receive call' do
            expect(service.get).to eq(initial_data)
            expect(service).not_to receive(:sort)
          end
        end
      end
    end

    describe '#get' do
      it 'throws NotImplementedError error' do
        expect { service.get }.to raise_error(NotImplementedError)
      end
    end

    describe 'self#get' do
      it 'throws NotImplementedError error' do
        expect { described_class.get(logs) }.to raise_error(NotImplementedError)
      end
    end
  end
end
