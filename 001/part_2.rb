#!/usr/bin/env ruby

target = 2020

input = File.read(File.join(__dir__, 'input')).split.map(&:to_i)

result = []
input.each.with_index do |first, index|
  next_target = target - first
  complement = input.map.with_index do |x, complement_index|
    complement_index != index ? (next_target - x) : nil
  end.compact
  result = (input & complement)

  # puts "first: #{first} next_target: #{next_target} complement: #{complement} result: #{result}"
  if result.count == 2
    result.push first
    break
  end
end

puts result.reduce(&:*)
