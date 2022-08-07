#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

AppLogger.use(Logger.new('logs/parser.log'))

path = ARGV[0]

total_visits = Stat::TopTotalVisitsService.new
uniq_visits = Stat::TopUniqueVisitsService.new

FileParsingService.call(
  path,
  LogParserService,
  [
    ->(log) { total_visits.add_entry(log) },
    ->(log) { uniq_visits.add_entry(log) }
  ]
)

puts Stat::StringPresenter.call(total_visits.finalized_stat, header: 'Total visits:', line_suffix: 'visits')
puts Stat::StringPresenter.call(uniq_visits.finalized_stat, header: 'Unique visits:', line_suffix: 'unique visits')
