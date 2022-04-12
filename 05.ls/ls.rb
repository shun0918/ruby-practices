# frozen_string_literal: true

COLMUN = 3
DEFAULT_PATH = './'

def print_item(item, path)
  print "#{item.slice(path.length..)}  "
end

def show_dir(path)
  Dir.glob("#{path}*").each_with_index do |item, index|
    puts if index.positive? && (index % COLMUN).zero?
    print_item(item, path)
  end
  puts
end

def trailing_slash(path)
  path.end_with?('/') ? path : "#{path}/"
end

def ls
  path = !ARGV[0].nil? && !ARGV[0].empty? ? trailing_slash(ARGV[0]) : DEFAULT_PATH
  show_dir(path)
end

ls
