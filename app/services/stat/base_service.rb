# frozen_string_literal: true

module Stat
  class BaseService
    def add_entry(_log)
      raise NotImplementedError
    end

    def finalized_stat
      stat
    end

    protected

    DEFAULT_VALUE = nil

    def stat
      @stat ||= Hash.new(self.class::DEFAULT_VALUE)
    end
  end
end
