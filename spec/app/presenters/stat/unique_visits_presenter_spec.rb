# frozen_string_literal: true

module Stat
  describe UniqueVisitsPresetner do
    let(:header) { 'Unique views:' }
    let(:suffix) { 'unique views' }

    describe '#call' do
      it_behaves_like 'generates presentation for stat'
    end
  end
end
