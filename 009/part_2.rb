#!/usr/bin/env ruby

require 'ostruct'

preamble_length = ARGV.first ? 5 : 25
input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map(&:to_i)

invalid = nil
(preamble_length...input.length).each do |index|
  current = input[index]
  ini = index - preamble_length
  fin = index
  subarray = input[ini...fin]
  coarray = subarray.map { |x| current - x != x ? current - x : nil }.compact
  inter = (subarray & coarray)
  # puts "index: #{index} current: #{current} subarray: #{subarray} inter: #{inter}"
  next unless inter.empty?

  invalid = current

  puts "not found: #{invalid}"
  break
end

ini = 0
fin = 1
subarray = nil
loop do
  subarray = input[ini...fin]
  sum = subarray.sum

  # puts "ini: #{ini} fin: #{fin} subarray: #{subarray} sum: #{sum}"
  break if sum == invalid

  if sum > invalid
    ini += 1
  else
    fin += 1
  end
end

min = subarray.min
max = subarray.max

puts "encryption weakness: #{min + max}"

# require 'pry'; binding.pry
