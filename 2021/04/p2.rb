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

winner_numbers = []

numbers.each.with_index do |number, number_index|
  winner_numbers.push number

  row_count.times do |row_index|
    col_count.times do |col_index|
      boards.each do |board|
        next if board.score
        next unless board.numbers[row_index][col_index] == number

        row_matches = board.row_matches[row_index] += 1
        col_matches = board.col_matches[col_index] += 1

        next unless row_matches == row_count || col_matches == col_count

        not_matched_numbers = board.numbers.flatten - winner_numbers
        board.score = not_matched_numbers.map(&:to_i).sum * winner_numbers.last.to_i
        board.winner_number_index = number_index
        board.winner_numbers = winner_numbers.dup
      end
    end
  end
end

last_winner_number_index = boards.map(&:winner_number_index).compact.max
last_winners = boards.select do |board|
  board.winner_number_index == last_winner_number_index
end

puts <<~FIN
  boards:
  #{boards.map(&:to_s).join("\n")}

  last_winners:
  #{last_winners.map(&:to_s).join("\n")}
FIN
