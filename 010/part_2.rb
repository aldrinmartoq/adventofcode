#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map(&:to_i).sort

delta = {}

input.push input.last + 3

last = 0
last_diff = 0
diff_repeat = 0
repeated = []
input.each do |n|
  diff = n - last
  delta[diff] ||= 0
  delta[diff] += 1

  if diff == last_diff && diff == 1
    diff_repeat += 1
  elsif diff_repeat > 0
    puts "Repeated: #{diff_repeat}"
    repeated.push 2**diff_repeat
    diff_repeat = 0
  end

  puts "last: #{last} n: #{n} diff: #{diff}"
  last = n
  last_diff = diff
end

puts delta[1] * delta[3]

puts delta
puts repeated.reduce(&:*)

require 'pry'; binding.pry
