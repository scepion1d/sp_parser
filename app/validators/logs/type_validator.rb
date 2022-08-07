# frozen_string_literal: true

module Logs
  class TypeValidator < BaseValidator
    def valid?
      logs.instance_of?(Array) && logs.all? { |log| log.instance_of?(String) }
    end

    private

    attr_reader :logs

    def initialize(args)
      @logs = args[0]
      super
    end
  end
end
