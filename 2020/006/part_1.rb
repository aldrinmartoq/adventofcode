#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n\n").map do |data|
  data.delete("\n").split('').uniq.count
end

puts input.sum
