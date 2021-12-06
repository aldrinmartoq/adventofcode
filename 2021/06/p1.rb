#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split(',').map(&:to_i)

puts "Initial state: #{input.join(',')}"
(1..80).each do |index|
  new_fish = 0
  input.map! do |counter|
    counter -= 1
    if counter.negative?
      new_fish += 1
      counter = 6
    end
    counter
  end
  input += Array.new(new_fish, 8)
  puts "After #{format('%2d', index)} days: #{input.join(',')}"
end

puts <<~FIN

  total fish: #{input.count}

FIN
