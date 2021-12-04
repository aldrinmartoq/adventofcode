#!/usr/bin/env ruby

require 'ostruct'

input = File.read(File.join(__dir__, 'input')).split("\n").map do |line|
  items = line.split(/[ :-]/)
  OpenStruct.new a: items[0].to_i, b: items[1].to_i, char: items[2], password: items[4]
end

valid_list = input.select do |item|
  item.valid = (item.password[item.a - 1] == item.char) ^ (item.password[item.b - 1] == item.char)
end

puts valid_list.count
