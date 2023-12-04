#!/usr/bin/env ruby

require_relative '../lib/aoc'

cards = read_input(__dir__).split("\n").map do |line|
  next unless (match = line.match(/^Card\s+(\d+): (.*?) \| (.*?)$/))

  winning = match[2].split(/\s+/).map(&:to_i)
  numbers = match[3].split(/\s+/).map(&:to_i)
  matches = winning & numbers
  matches_count = matches.count

  A0Struct.create(card: match[1], count: 1, matches_count:, winning:, numbers:, matches:)
end

cards.each_with_index do |card, index|
  1.upto(card.matches_count).each do |i|
    cards[index + i].count += card.count
  end
end

puts <<~FIN
  result: #{cards.map(&:count).sum}
FIN
