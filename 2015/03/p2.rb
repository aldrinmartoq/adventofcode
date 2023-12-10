#!/usr/bin/env ruby

require_relative '../lib/aoc'

read_input(__dir__).split("\n").map do |line|
  x1 = y1 = x2 = y2 = 0
  mapa = {}
  mapa[[0, 0]] = 2

  line.chars.each_with_index do |char, index|
    if index.even?
      case char
      when '>'
        x1 += 1
      when '<'
        x1 -= 1
      when '^'
        y1 -= 1
      when 'v'
        y1 += 1
      else
        next
      end

      mapa[[x1, y1]] = (mapa[[x1, y1]] || 0) + 1
    else
      case char
      when '>'
        x2 += 1
      when '<'
        x2 -= 1
      when '^'
        y2 -= 1
      when 'v'
        y2 += 1
      else
        next
      end

      mapa[[x2, y2]] = (mapa[[x2, y2]] || 0) + 1
    end
  end

  casas = mapa.keys.count
  puts "casas: #{casas} line: #{line.first(20)}"
end
