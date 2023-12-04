#!/usr/bin/env ruby

require_relative '../lib/aoc'

cards = read_input(__dir__).split("\n").map do |line|
  next unless (match = line.match(/^Card\s+(\d+): (.*?) \| (.*?)$/))

  winning = match[2].split(/\s+/).map(&:to_i)
  numbers = match[3].split(/\s+/).map(&:to_i)
  matches = winning & numbers
  points = 2**(matches.count - 1) if matches.present?

  A0Struct.create(card: match[1], points:, winning:, numbers:, matches:)
end

puts <<~FIN
  result: #{cards.map(&:points).compact.sum}
FIN
