#!/usr/bin/env ruby

require_relative '../lib/aoc'

result = read_input(__dir__).split("\n").map do |line|
  game, sets = line.split(': ')
  sets = sets.split('; ').map do |set|
    set.split(', ').map(&:split).to_h do |item| # rubocop:disable Style/MapToHash
      [item.last.to_sym, item.first.to_i]
    end
  end
  A0Struct.new id: game.split.last.to_i, sets:
end.each do |item|
  cubes = {}
  item.sets.each do |set|
    set.each do |key, value|
      cubes[key] = [cubes[key] || 0, value].max
    end
  end
  item.power = cubes.values.reduce(:*)
end.map(&:power).sum

puts <<~FIN
  result: #{result}
FIN
