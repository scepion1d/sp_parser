# frozen_string_literal: true

module Stat
  describe TotalVisitsPresenter do
    let(:header) { 'Total visits:' }
    let(:suffix) { 'visits' }

    describe '#call' do
      it_behaves_like 'generates presentation for stat'
    end
  end
end
