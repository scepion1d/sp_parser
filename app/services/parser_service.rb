# frozen_string_literal: true

class ParserService
  def self.call(file_path)
    new.call(file_path)
  end

  def call(path)
    process_file(path)
    present_stat
  end

  attr_reader :total_visits, :uniq_visits

  private_methods :new

  def initialize
    @total_visits = Stat::TopTotalVisitsService.new
    @uniq_visits = Stat::TopUniqueVisitsService.new
  end

  def present_stat
    [
      Stat::StringPresenter.call(total_visits.finalized_stat, header: 'Total visits:', line_suffix: 'visits'),
      Stat::StringPresenter.call(uniq_visits.finalized_stat, header: 'Unique visits:', line_suffix: 'unique visits')
    ]
  end

  def process_file(path)
    FileParsingService.call(
      path,
      [
        ->(log) { total_visits.add_entry(log) },
        ->(log) { uniq_visits.add_entry(log) }
      ]
    )
  end
end
