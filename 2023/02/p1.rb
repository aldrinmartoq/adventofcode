#!/usr/bin/env ruby

require_relative '../lib/aoc'

cubes = { red: 12, green: 13, blue: 14 }

result = read_input(__dir__).split("\n").map do |line|
  game, sets = line.split(': ')
  sets = sets.split('; ').map do |set|
    set.split(', ').map(&:split).to_h do |item| # rubocop:disable Style/MapToHash
      [item.last.to_sym, item.first.to_i]
    end
  end
  A0Struct.new id: game.split.last.to_i, sets:
end.reject do |item|
  item.sets.any? do |set|
    set.any? do |key, value|
      cubes[key] < value
    end
  end
end.map(&:id).sum

puts <<~FIN
  result: #{result}
FIN
