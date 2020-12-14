#!/usr/bin/env ruby

require 'ostruct'

input = File.read(File.join(__dir__, 'input')).split("\n").map do |line|
  items = line.split(/[ :-]/)
  OpenStruct.new min: items[0].to_i, max: items[1].to_i, char: items[2], password: items[4]
end

valid_list = input.select do |item|
  count = item.password.count(item.char)
  item.valid = item.min <= count && count <= item.max
end

# puts valid_list
puts valid_list.count
