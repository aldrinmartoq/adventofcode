#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map do |data|
  id = data.tr('F', '0').tr('B', '1').tr('L', '0').tr('R', '1').to_i(2)
  row = id / 8
  col = id % 8
  OpenStruct.new id: id, row: row, col: col
end.sort_by(&:id)

max_id = input.map(&:id).max

seat_map = input.map do |seat|
  [seat.id, seat]
end.to_h

(0...max_id).each do |id|
  prev = seat_map[id - 1]
  post = seat_map[id + 1]
  next unless seat_map[id].nil? && prev && post

  row = id / 8
  col = id % 8
  puts "MY seat id: #{id} row: #{row} col: #{col} prev: #{prev} post: #{post}"
end
