#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map(&:to_i)

index_map = {}
last = nil
input.each_with_index do |n, index|
  index_map[n] ||= []
  index_map[n].unshift index
  last = n
end

(input.length...30_000_000).each do |index|
  last_pos = index_map[last]
  n = last_pos && last_pos[1] ? last_pos[0] - last_pos[1] : 0
  index_map[n] ||= []
  index_map[n].unshift index
  # puts "last: #{last} n: #{n} index: #{index}"
  last = n
end

puts "last: #{last}"

# require 'pry'; binding.pry
