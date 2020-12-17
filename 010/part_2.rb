#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map(&:to_i).sort

last = 0
diffs = input.map do |n|
  diff = n - last

  last = n
  diff
end

a = diffs.join.split('3').map(&:length).map do |length|
  case length
  when 4
    7
  when 3
    4
  when 2
    2
  else
    1
  end
end

puts a.reduce(&:*)
