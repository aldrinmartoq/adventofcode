#!/usr/bin/env ruby

require_relative '../lib/aoc'

read_input(__dir__).split("\n").each do |line|
  floor = 0
  line.chars.each_with_index do |char, index|
    floor -= 1 if char == ')'
    floor += 1 if char == '('
    next unless floor == -1

    puts "position: #{index + 1}"
    exit 0
  end
end
