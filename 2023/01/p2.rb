#!/usr/bin/env ruby

require_relative '../lib/aoc'

digits = %w[one two three four five six seven eight nine].map.with_index.to_h do |digit, index|
  [digit, (index + 1).to_s]
end

result = read_input(__dir__).split("\n").map do |line|
  pos = 0
  while pos <= line.length
    digits.each do |text, value|
      next unless line[pos..].start_with? text

      line[pos] = value
      break
    end
    pos += 1
  end

  line
end.map do |line|
  numbers = line.tr('^0-9', '').chars
  "#{numbers.first}#{numbers.last}".to_i
end.sum

puts <<~FIN
  result: #{result}
FIN
