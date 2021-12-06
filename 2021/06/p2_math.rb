#!/usr/bin/env ruby

require_relative '../lib/aoc'
require 'matrix'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split(',').map(&:to_i)

# Idea taken from:
# https://www.reddit.com/r/adventofcode/comments/r9zhul/exponential_growth_checks_out/hnfm94i/?utm_source=reddit&utm_medium=web2x&context=3

# v := vector with the amount of fish at each v_i state, ex:
# Example:
#   for the input = [3, 4, 3, 1, 2]
#   v = Matrix[[0, 1, 1, 2, 1, 0, 0, 0, 0]] # two 3s; one 1, 2 and 4 
v = input.group_by { |state| state }.transform_values(&:count) # {3=>2, 4=>1, 1=>1, 2=>1}
v = Matrix[(0...9).map { |x| v[x] || 0 }]

# A is a transition matrix
a = <<~FIN.split("\n").map { |l| l.split.map(&:to_i) }
  0 0 0 0 0 0 1 0 1
  1 0 0 0 0 0 0 0 0
  0 1 0 0 0 0 0 0 0
  0 0 1 0 0 0 0 0 0
  0 0 0 1 0 0 0 0 0
  0 0 0 0 1 0 0 0 0
  0 0 0 0 0 1 0 0 0
  0 0 0 0 0 0 1 0 0
  0 0 0 0 0 0 0 1 0
FIN
a = Matrix[*a]

# Multiplying v' = v * a, we get the vector v' for the next day.
256.times do
  v *= a
end

puts <<~FIN

  total fish: #{v.sum}

FIN
