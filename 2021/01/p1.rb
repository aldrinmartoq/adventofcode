#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split.map(&:to_i)
changes = (1...input.count).map do |index|
  a, b = input[index - 1], input[index]
  a <=> b
end

increased = changes.select do |x|
  x == -1
end

puts <<~FIN

  increased: #{increased.count}

FIN
