# frozen_string_literal: true

class FileReaderService
  def self.file_stream(path)
    new(path).file_stream
  end

  def file_stream
    File.open(path, 'r')
  end

  private_methods :new

  private

  attr_reader :path

  def validate
    return if Files::PathValidator.valid?(path) && Files::AccessValidator.valid?(path)

    raise FileError, path
  end

  def initialize(path)
    @path = File.expand_path(path.to_s)
    validate
  end
end
