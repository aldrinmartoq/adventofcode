#!/usr/bin/env ruby

require_relative '../lib/aoc'

digits = File.read(File.join(__dir__, 'digits')).split("\n\n").map do |lines|
  data = lines.split("\n").map do |line|
    5.times.map do |index|
      index *= 8
      ini, fin = 0 + index, 6 + index
      line[ini...fin]
    end
  end
  5.times.map do |index|
    digit, *segments = data.map do |line|
      line[index]
    end.join.delete(' :.').chars.uniq.sort
    [digit.to_i, segments.join]
  end
end.flatten(1).to_h

digits_segment_count = digits.transform_values(&:size)

input = File.read(File.join(__dir__, ARGV[0] || 'input')).gsub("|\n", '| ').split("\n")
entries = input.map do |line|
  a, b = line.split(' | ')
  [a, b].map do |x|
    x.split.map(&:chars).map(&:sort).map(&:join)
  end
end

digits_size_map = digits_segment_count.map(&:reverse).group_by(&:first).map do |a, b|
  result = b.map(&:second)
  [a, result.count == 1 ? result.first : result]
end.to_h

values = entries.map do |numbers, codes|
  guess = {}
  numbers.each do |item|
    posible_digits = digits_size_map[item.size]
    if posible_digits.is_a? Array
      posible_digits.each do |value|
        guess[value] ||= []
        guess[value].push item.chars
      end
    else
      guess[posible_digits] = item.chars
    end
  end

  guess[3] = guess[3].find { |item| (item - guess[1]).count == 3 }
  guess[6] = guess[6].find { |item| (item - guess[1]).count == 5 }
  guess[5] = guess[5].find { |item| (item - guess[6]).empty? }
  guess[0] = guess[0].find { |item| (item - guess[5]).count == 2 }
  guess[9] = (guess[9] - [guess[6], guess[0]]).first
  guess[2] = (guess[2] - [guess[3], guess[5]]).first

  guess = guess.map(&:reverse).to_h.transform_keys(&:join)

  codes.map do |code|
    guess[code]
  end.join.to_i
end

puts <<~FIN

  sum: #{values.sum}

FIN
