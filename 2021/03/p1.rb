#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n").map(&:chars)

len = input.first.count

gamma = len.times.map do |index|
  result = input.map { |item| item[index] }.group_by { |bit| bit }.transform_values(&:count)
  result['0'] > result['1'] ? '0' : '1'
end.join

epsilon = len.times.map do |index|
  result = input.map { |item| item[index] }.group_by { |bit| bit }.transform_values(&:count)
  result['0'] < result['1'] ? '0' : '1'
end.join

puts <<~FIN
    gamma: #{gamma.to_i(2)}\t#{gamma}
  epsilon: #{epsilon.to_i(2)}\t#{epsilon}

  gamma * epsilon: #{gamma.to_i(2) * epsilon.to_i(2)}
FIN
