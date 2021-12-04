#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n").map(&:chars)

len = input.first.count

filter = proc do |list, pos, oper|
  result = list.map { |item| item[pos] }.group_by { |bit| bit }.transform_values(&:count)
  bit = result['0'].send(oper, result['1']) ? '0' : '1'
  list.select { |item| item[pos] == bit }
end

oxygen_list = input
oxygen = len.times.each do |pos|
  oxygen_list = filter.call oxygen_list, pos, :>
  break oxygen_list if oxygen_list.count == 1
end.first.join

co2_list = input
co2 = len.times.each do |pos|
  co2_list = filter.call co2_list, pos, :<=
  break co2_list if co2_list.count == 1
end.first.join

puts <<~FIN
  oxygen: #{oxygen.to_i(2)}\t#{oxygen}
     co2: #{co2.to_i(2)}\t#{co2}

  oxygen * co2: #{oxygen.to_i(2) * co2.to_i(2)}
FIN
