#!/usr/bin/env ruby

target = 2020

input = File.read(File.join(__dir__, 'input')).split.map(&:to_i)
complement = input.map { |x| target - x }
result = (input & complement).reduce(&:*)

puts result
