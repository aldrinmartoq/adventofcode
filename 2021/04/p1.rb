#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n\n")
numbers, *boards = input
numbers = numbers.split(',').map(&:to_i)

boards.map! { |data| data.split("\n").map(&:split).map { |x| x.map!(&:to_i) } }.map!.with_index do |elems, index|
  A0Struct.new index: index, row_matches: Array.new(elems.count, 0), col_matches: Array.new(elems.first.count, 0), numbers: elems
end

row_count = boards.first.numbers.count
col_count = boards.first.numbers.first.count

winners = []

winner_numbers = numbers.select do |number|
  next if winners.present?

  row_count.times do |row_index|
    col_count.times do |col_index|
      boards.each do |board|
        next unless board.numbers[row_index][col_index] == number

        row_matches = board.row_matches[row_index] += 1
        col_matches = board.col_matches[col_index] += 1

        next unless row_matches == row_count || col_matches == col_count

        winners.push board
      end
    end
  end

  true
end

winners.each do |board|
  not_matched_numbers = board.numbers.flatten - winner_numbers
  board.score = not_matched_numbers.map(&:to_i).sum * winner_numbers.last.to_i
end

puts <<~FIN
  winners:
  #{winners.map(&:to_s).join("\n")}

  winners_numbers:
  #{winner_numbers}
FIN
