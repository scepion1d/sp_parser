#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

file_path = ARGV[0]

begin
  logs = FileProcessor.call(file_path)

  puts Stat::TotalVisits.new(logs).get_report(order: :dsc)
  puts Stat::UniqueVisits.new(logs).get_report(order: :dsc)
rescue ArgumentError => error
  AppLogger.warn("Processing of file `#{file_path}` failed: #{error.message}")
end
