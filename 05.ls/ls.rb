# frozen_string_literal: true

COLUMN = 3
DEFAULT_PATH = './'

def print_item(item, path)
  print "#{item.slice(path.length..)}  "
end

# def max_row(items)
#   (items.size / COLUMN.to_f).ceil
# end

def print_table(table)
  table.each do |rows|
    puts rows.join('  ')
  end
end

def print_items(items)
  # 一覧表示させる
end

def show_dir(path)
  items = Dir.glob("#{path}*")
  print_items(items)
end

def trailing_slash(path)
  path.end_with?('/') ? path : "#{path}/"
end

def ls
  path = !ARGV[0].nil? && !ARGV[0].empty? ? trailing_slash(ARGV[0]) : DEFAULT_PATH
  show_dir(path)
end


#