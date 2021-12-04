#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split.map(&:to_i)

window = (2...input.count).map do |index|
  [-2, -1, 0].map do |subindex|
    input[index + subindex]
  end
end

changes = (1...window.count).map do |index|
  a, b = window[index - 1].sum, window[index].sum
  a <=> b
end

increased = changes.select do |x|
  x == -1
end

puts <<~FIN

  increased: #{increased.count}

FIN
