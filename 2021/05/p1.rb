#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n")
vents = input.map do |line|
  x1, y1, x2, y2 = line.split(' -> ').join(',').split(',').map(&:to_i)
  dx = x2 <=> x1
  dy = y2 <=> y1

  A0Struct.new x1: x1, y1: y1, x2: x2, y2: y2, dx: dx, dy: dy
end

max_x = (vents.map(&:x1) + vents.map(&:x2)).max
max_y = (vents.map(&:y1) + vents.map(&:y2)).max

board = Array.new(max_y + 1) do
  Array.new(max_x + 1, 0)
end

vents.each.with_index do |vent, index|
  puts "##{index} vent: #{vent}"

  next unless vent.dx.zero? || vent.dy.zero?

  x, y = vent.x1, vent.y1
  board[y][x] += 1
  while x != vent.x2 || y != vent.y2
    x += vent.dx
    y += vent.dy
    board[y][x] += 1
  end
end

board.each do |row|
  puts row.map { |x| x.zero? ? '.' : x }.join
end

puts <<~FIN

  points: #{board.flatten.select { |x| x >= 2 }.count}

FIN
