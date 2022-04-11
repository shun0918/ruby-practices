# frozen_string_literal: true

COLMUN = 3

def print_item(item)
  print "#{item}  "
end

def show_dir
  Dir.glob('*').each_with_index do |item, index|
    puts if index.positive? && (index % COLMUN).zero?
    print_item(item)
  end
  puts
end

def ls
  show_dir
end

ls
