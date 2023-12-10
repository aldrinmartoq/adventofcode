#!/usr/bin/env ruby

require_relative '../lib/aoc'

read_input(__dir__).split("\n").map do |line|
  x = y = 0
  mapa = {}
  mapa[[x, y]] = 1

  line.chars.each do |char|
    case char
    when '>'
      x += 1
    when '<'
      x -= 1
    when '^'
      y -= 1
    when 'v'
      y += 1
    else
      next
    end

    mapa[[x, y]] = (mapa[[x, y]] || 0) + 1
  end

  casas = mapa.keys.count
  puts "casas: #{casas} line: #{line.first(20)}…"
end
