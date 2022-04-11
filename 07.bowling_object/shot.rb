# frozen_string_literal: true

class Shot
  def initialize(score)
    @score = score
  end

  def strike?
    @score == 'X'
  end

  def score
    strike? ? 10 : @score.to_i
  end
end
