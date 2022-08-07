#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

file_path = ARGV[0]

logs = FileProcessor.call(file_path)

Stat::TotalVisits.new(logs).print(order: :dsc)
Stat::UniqueVisits.new(logs).print(order: :dsc)
