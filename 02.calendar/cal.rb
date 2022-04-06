require 'date'

MIN_YEAR = 1970
MAX_YEAR = 2100
MIN_MONTH = 1
MAX_MONTH = 12
OPTION_KEY = {MONTH: "-m", YEAR: "-y"}
TODAY = Date.today

def validate_year(year)
  MIN_YEAR <= year && year <= MAX_YEAR
end

def validate_month(year)
  MIN_MONTH <= year && year <= MAX_MONTH
end

def bg_red(str)
  "\e[41m#{str}\e[0m"
end

def error_message(str)
  "\e[31mERROR: #{str}\e[0m"
end

# 年月をもとにカレンダー出力
def show_calendar(year:, month:)
  head = Date.new(year, month, 1)
  tail = Date.new(year, month, -1)
  weekTable = []
  weekRow = Array.new(7, "  ")

  (head..tail).each do |date|
    weekRow[date.wday] = date.day.to_s.rjust(2, " ")
    if date.wday == 6
      weekTable.push weekRow
      weekRow = Array.new(7, "  ")
    end
  end

  puts "     #{head.strftime("%-m月 %Y")}"
  puts "日 月 火 水 木 金 土  "
  weekTable.each do |row|
    row.each do |day|
      day == TODAY.day.to_s.rjust(2, " ") ? print(bg_red(day)) : print(day)
      print(" ")
    end
    puts()
  end
end

def main
  begin
    options = { OPTION_KEY[:MONTH] => TODAY.month, "-y" => TODAY.year }
    current_option = nil
    
    ARGV.each_with_index do |arg, i|
      if current_option.nil?
        raise "不正なオプションです: オプション: #{arg.to_s}" unless options.has_key?(arg.to_s)
        current_option = arg.to_s
        next
      end

      raise "オプションの値が不正です。 オプション: #{current_option}, 値: #{arg.to_s}" unless arg.to_s =~ /^[0-9]+$/
      options[current_option] = arg.to_i
      current_option = nil
    end

    raise "#{current_option} オプションの後には引数が必要です" unless current_option.nil?
    raise "年の値が不正です" unless validate_year(options["-y"])
    raise "月の値が不正です" unless validate_month(options[OPTION_KEY[:MONTH]])

    show_calendar(year: options["-y"], month: options[OPTION_KEY[:MONTH]])
  rescue => e
    puts error_message(e.message)
  end
end

main
