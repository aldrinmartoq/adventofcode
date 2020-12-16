#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map { |line| line.split('') }

adj_map = []
max_row_index = input.count
max_col_index = input.first.count
input.each_with_index do |row, row_index|
  adj_map[row_index] = []
  row.each_with_index do |_cell, col_index|
    adj_map[row_index][col_index] = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        ry = row_index + y
        cx = col_index + x
        next unless ry >= 0 && ry < max_row_index
        next unless cx >= 0 && cx < max_col_index
        next if x.zero? && y.zero?

        adj_map[row_index][col_index].push([ry, cx])
      end
    end
  end
end

last_state = input.flatten.join

loop do
  new_input = []
  input.each_with_index do |row, row_index|
    new_input.push([])
    row.each_with_index do |cell, col_index|
      if cell != '.'
        adj = adj_map[row_index][col_index].map do |coord|
          x, y = coord
          input[x][y]
        end

        cell = '#' if cell == 'L' && adj.all? { |x| x != '#' }
        cell = 'L' if cell == '#' && adj.select { |x| x == '#' }.count >= 4
      end
      new_input[row_index][col_index] = cell
    end
  end

  new_state = new_input.flatten.join

  break if new_state == last_state

  input = new_input
  last_state = input.flatten.join
  # puts input.map(&:join).join("\n") + "\n\n"
end

puts last_state.count('#')

# require 'pry'; binding.pry
