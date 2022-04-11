# frozen_string_literal: true

require './shot'

class Frame
  def initialize(shots = [])
    @shots = shots.map do |shot|
      Shot.new(shot)
    end
  end

  def add(score)
    @shots.push Shot.new(score)
  end

  def sum
    total = 0
    @shots.each do |shot|
      total += shot.score
    end
    total
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    !strike? && sum == 10
  end

  def end?
    @shots.size == 2 || strike?
  end

  def to_a
    "[#{@shots.inject('') { |result, shot| "#{result}, #{shot.score}" }}]"
  end
end
