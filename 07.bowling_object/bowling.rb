# frozen_string_literal: true

require './game'

SEPARATER = ','

Game.new(ARGV[0].split(SEPARATER)).start
