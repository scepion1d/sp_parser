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

    def stat
      @stat ||= Hash.new(default_value)
    end

    def default_value
      raise NotImplementedError
    end
  end
end
