# frozen_string_literal: true

module Files
  class Reader
    def self.call(path)
      new(path).call
    end

    def call
      validate
      File.readlines(path)
    end

    private

    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path.to_s)
    end

    def validate
      return if Files::PathValidator.valid?(path) && Files::AccessValidator.valid?(path)

      raise FileError, path
    end
  end
end
