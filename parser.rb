#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

file_path = ARGV[0]

logs = ParsingService.call(file_path)

return if logs.nil? || logs.class != Array

{
  Stat::TotalVisits => Stat::TotalVisitsPresenter,
  Stat::UniqueVisits => Stat::UniqueVisitsPresetner
}.each do |service, presenter|
  report = service.get(logs, order: :dsc)
  puts presenter.call(report) unless report.count.zero?
end
