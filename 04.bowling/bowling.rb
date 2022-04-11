# frozen_string_literal: true

SEPARATER = ','
FLAMES_PER_GAME = 10
PIN_NUMBER = 10
THROWABLE_PER_FLAME = 2
STRIKE_STR = 'X'

def spare?(flame)
  flame.size == 2 && flame.sum == PIN_NUMBER
end

def strike?(flame)
  flame[0] == STRIKE_STR
end

def split_at_separator(str, sep = SEPARATER)
  str.split(sep)
end

def calc_pin(flame)
  sum = 0
  flame.each do |score|
    sum += score == STRIKE_STR ? PIN_NUMBER : score
  end
  sum
end

def calc_total_score(flames)
  total = 0
  strike_now = false
  spare_now = false
  flames.each_with_index do |flame, flame_index|
    # 前回のストライク、スペア分反映
    if strike_now
      total += calc_pin((flame + (flames[flame_index + 1] || [])).slice(0, THROWABLE_PER_FLAME))
    elsif spare_now
      total += strike?(flame) ? PIN_NUMBER : flame[0]
    end

    # init
    strike_now = false
    spare_now = false

    # 最後は普通に加算
    if flame_index == FLAMES_PER_GAME - 1
      total += calc_pin(flame)
      next
    end

    # 現在のスコア加算
    if strike? flame
      total += PIN_NUMBER
      strike_now = true
    elsif spare? flame
      total += PIN_NUMBER
      spare_now = true
    else
      total += flame.sum
    end
  end
  total
end

def scores_to_flames(scores)
  flames = []
  current_flame = []
  scores.each do |score|
    # 最終フレームは
    if flames.size >= FLAMES_PER_GAME - 1
      current_flame.push score == STRIKE_STR ? score : score.to_i
      next
    end

    if strike?(score)
      flames.push [score]
      current_flame = []
      next
    end

    current_flame.push score.to_i
    if current_flame.size == THROWABLE_PER_FLAME
      flames.push current_flame
      current_flame = []
    end
  end
  flames.push current_flame
  flames
end

def game(scores)
  flames = scores_to_flames scores
  puts calc_total_score(flames)
end

def main
  scores = ARGV[0]
  game split_at_separator scores
end

main
