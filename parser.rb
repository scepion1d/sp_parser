#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

file_path = ARGV[0]

if (logs = FileProcessor.call(file_path)).instance_of?(Array)
  Stat::TotalVisits.new(logs).print(order: :dsc)
  Stat::UniqueVisits.new(logs).print(order: :dsc)
end
