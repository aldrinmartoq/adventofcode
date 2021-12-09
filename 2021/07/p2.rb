#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split(',').map(&:to_i).sort!

min, max = input.minmax

costs = (0..max).map do |pos|
  cost = input.map do |crab|
    a, b = [crab, pos].minmax
    (1..(b-a)).sum
  end.sum
  [cost, pos]
end.to_h

min_cost = costs.keys.min

puts <<~FIN

  costs: #{costs}
  min_pos: #{costs[min_cost]}
  min_cost: #{min_cost}

FIN
