# frozen_string_literal: true

require 'debug'
require './frame'

class Game
  MAX_FLAME = 10

  def initialize(scores)
    @total = 0
    @scores = scores
    @frames = []
    @current_frame = Frame.new
  end

  def last?
    @frames.size == MAX_FLAME - 1
  end

  def next
    @total += @current_frame.sum
    @frames.push @current_frame
    @current_frame = Frame.new
  end

  def start
    @scores.each_with_index do |score, index|
      @current_frame.add score
      next if last?

      if @current_frame.strike?
        @total += Frame.new([@scores[index + 1], @scores[index + 2]]).sum
        self.next
      elsif @current_frame.end?
        @total += Frame.new([@scores[index + 1]]).sum if @current_frame.spare?
        self.next
      end
    end
    self.next
    p @total
  end
end
