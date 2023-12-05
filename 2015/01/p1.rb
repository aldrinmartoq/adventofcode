#!/usr/bin/env ruby

require_relative '../lib/aoc'

read_input(__dir__).split("\n").each do |line|
  floor = 0
  line.chars.each do |char|
    floor -= 1 if char == ')'
    floor += 1 if char == '('
  end
  puts "floor: #{floor} line: #{line}"
end
