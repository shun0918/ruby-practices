# frozen_string_literal: true

require 'date'

MIN_YEAR = 1970
MAX_YEAR = 2100
MIN_MONTH = 1
MAX_MONTH = 12
OPTION_KEY = { month: '-m', year: '-y' }.freeze
TODAY = Date.today.freeze

def validate_year(year)
  MIN_YEAR <= year && year <= MAX_YEAR
end

def validate_month(year)
  MIN_MONTH <= year && year <= MAX_MONTH
end

def negative_color(str)
  "\e[47m#{str}\e[0m"
end

def error_message(str)
  "\e[31mERROR: #{str}\e[0m"
end

def show_calendar_head(date)
  puts "     #{date.strftime('%-m月 %Y')}"
  puts '日 月 火 水 木 金 土  '
end

def show_calendar_week(weeks = [], year = MIN_YEAR - 1)
  weeks.each do |day|
    day == TODAY.day.to_s.rjust(2, ' ') && year == TODAY.year ? print(negative_color(day)) : print(day)
    print(' ')
  end
  puts
end

# 年月をもとにカレンダー出力
def show_calendar(year:, month:)
  raise "#{year}は年に指定できません。1970~2100で指定してください" unless validate_year(year)
  raise "#{month}は月に指定できません。1~12で指定してください" unless validate_month(month)

  head = Date.new(year, month, 1)
  tail = Date.new(year, month, -1)
  weeks = []
  tmp_week = Array.new(7, '  ')

  (head..tail).each do |date|
    tmp_week[date.wday] = date.day.to_s.rjust(2, ' ')
    if date.wday == 6
      weeks.push tmp_week
      tmp_week = []
    end
  end
  weeks.push tmp_week

  show_calendar_head(head)
  weeks.each { |week| show_calendar_week(week, year) }
end

def read_calendar_options
  options = { OPTION_KEY[:month] => TODAY.month, OPTION_KEY[:year] => TODAY.year }
  current_option = nil

  ARGV.each do |arg|
    if current_option.nil?
      raise "不正なオプションです: オプション: #{arg}" unless options.key?(arg.to_s)

      current_option = arg.to_s
      next
    end

    raise "オプションに対する値が不正です。 オプション: #{current_option}, 値: #{arg}" unless arg.to_s.match?(/^[0-9]+$/)

    options[current_option] = arg.to_i
    current_option = nil
  end

  raise "#{current_option}オプションの後には引数が必要です" unless current_option.nil?

  { year: options[OPTION_KEY[:year]], month: options[OPTION_KEY[:month]] }
end

def main
  inputed_date = read_calendar_options
  show_calendar(year: inputed_date[:year], month: inputed_date[:month])
rescue StandardError => e
  puts error_message(e.message)
end

main
