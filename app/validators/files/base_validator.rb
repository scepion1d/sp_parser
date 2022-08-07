# frozen_string_literal: true

module Files
  class BaseValidator < ::BaseValidator
    protected

    attr_reader :path

    def initialize(args)
      @path = args[0].to_s
      super
    end
  end
end
