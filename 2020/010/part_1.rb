#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map(&:to_i).sort

delta = {}

input.push input.last + 3

last = 0
input.each do |n|
  diff = n - last
  delta[diff] ||= 0
  delta[diff] += 1

  # puts "last: #{last} n: #{n} diff: #{diff}"
  last = n
end

puts delta[1] * delta[3]

# require 'pry'; binding.pry
