#!/usr/bin/env ruby

require_relative '../lib/aoc'

result = read_input(__dir__).split("\n").map do |line|
  line.tr('^0-9', '').chars
end.map do |numbers|
  "#{numbers.first}#{numbers.last}".to_i
end.sum

puts <<~FIN
  result: #{result}
FIN
