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
    [digit, segments.join]
  end
end.flatten(1).to_h

digits_segment_count = digits.transform_values(&:size)
uniq_segment_count = digits_segment_count.values.group_by(&:itself).transform_values(&:size).select do |segments, freq|
  freq == 1
end.map(&:first).sort

input = File.read(File.join(__dir__, ARGV[0] || 'input')).gsub("|\n", '| ').split("\n")
items = input.map do |line|
  line.split(' | ')
end.map(&:second).map(&:split).flatten

uniq_digits = items.select do |item|
  item.size.in?(uniq_segment_count)
end

puts <<~FIN

  uniq_digits: #{uniq_digits.count}

FIN
