# frozen_string_literal: true

SEPARATER = ','
FLAMES_PER_GAME = 10
PIN_NUMBER = 10
THROWABLE_PER_FLAME = 2
STRIKE_STR = 'X'

def split_at_separator(str, sep = SEPARATER)
  str.split(sep)
end

def calc_pin(scores)
  sum = 0
  scores.each do |score|
    sum += score == STRIKE_STR ? PIN_NUMBER : score.to_i
  end
  sum
end

def spare?(flame)
  flame.size == 2 && calc_pin(flame) == PIN_NUMBER
end

def strike?(flame)
  flame[0] == STRIKE_STR
end

def calc_total_score(scores)
  total = 0
  flame_index = 1
  current_flame = []
  scores.each_with_index do |score, score_index|
    current_flame.push score
    next if flame_index >= FLAMES_PER_GAME

    # ストライク、スペア
    if strike?(current_flame)
      total += calc_pin(current_flame) + calc_pin([scores[score_index + 1], scores[score_index + 2]])
      # @Todo OOPで共通化する
      current_flame = []
      flame_index += 1
    elsif current_flame.size == 2
      # @Todo OOPで共通化する
      total += calc_pin(current_flame) + (spare?(current_flame) ? calc_pin([scores[score_index + 1]]) : 0)
      current_flame = []
      flame_index += 1
    end
  end
  total += calc_pin(current_flame)
end

def main
  scores = ARGV[0]
  p calc_total_score split_at_separator scores
end

main
