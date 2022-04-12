# frozen_string_literal: true

COLUMN = 3
DEFAULT_PATH = './'

def file_name(item, path)
  item.slice(path.length..)
end

def max_row(items)
  (items.size / COLUMN.to_f).ceil
end

def print_table(table)
  table.each do |rows|
    puts rows.join('  ')
  end
end

def blank_table(items)
  count = items.size
  table = []
  while count.positive?
    table.push(Array.new([COLUMN, count].min, ''))
    count -= COLUMN
  end
  table
end

def fill_table(table, items, path)
  col = 0
  row = 0
  items.each do |item|
    # 縦に入れる
    table[row][col] = file_name(item, path)
    row += 1
    if row >= table.size || table[row][col].nil?
      col += 1
      row = 0
    end
  end
end

def print_items(items, path)
  # 一覧表示させる
  table = blank_table(items)
  fill_table(table, items, path)
  print_table(table)
end

def show_dir(path)
  items = Dir.glob("#{path}*")
  print_items(items, path)
end

def trailing_slash(path)
  path.end_with?('/') ? path : "#{path}/"
end

def ls
  path = !ARGV[0].nil? && !ARGV[0].empty? ? trailing_slash(ARGV[0]) : DEFAULT_PATH
  show_dir(path)
end

ls
