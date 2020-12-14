#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n\n").map do |data|
  data.split("\n").map { |item| item.split('') }.reduce(:&)
end

puts input.map(&:count).sum
