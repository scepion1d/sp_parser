# frozen_string_literal: true

class FileParsingService
  def self.call(path, aggregators = [])
    new(path, aggregators).call
  end

  def call
    AppLogger.info "Started processing of the file #{path}"
    readlines
  rescue FileError => error
    AppLogger.error("Processing failure: #{error.message}")
  ensure
    AppLogger.info "Finished processing of the file #{path}"
  end

  private

  attr_reader :path, :parser, :aggregators

  private_methods :new

  def initialize(path, aggregators)
    @path = path
    @aggregators = aggregators
  end

  def file
    @file ||= FileReaderService.file_stream(path)
  end

  def readlines
    while (raw_line = file.gets)
      parsed_line = parse(raw_line)
      aggregators.each { |agg| agg.call(parsed_line) } if parsed_line
    end
  end

  # :reek:UtilityFunction
  def parse(line)
    LogParserService.call(line)
  rescue LogsError => error
    AppLogger.warn "Can't process line: #{error.message}"
  end
end
