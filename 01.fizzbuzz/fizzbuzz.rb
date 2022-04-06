# frozen_string_literal: true

def fizzbuzz(num)
  if (num % 15).zero?
    puts 'FizzBuzz'
  elsif (num % 3).zero?
    puts 'Fizz'
  elsif (num % 5).zero?
    puts 'Buzz'
  else
    puts num
  end
end

(1..20).each do |num|
  fizzbuzz(num)
end
