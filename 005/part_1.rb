#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map do |data|
  id = data.tr('F', '0').tr('B', '1').tr('L', '0').tr('R', '1').to_i(2)
  row = id / 8
  col = id % 8
  OpenStruct.new id: id, row: row, col: col
end

max_id = input.map(&:id).max
puts max_id
