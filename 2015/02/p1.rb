#!/usr/bin/env ruby

require_relative '../lib/aoc'

data = read_input(__dir__).split("\n").map do |line|
  lados = line.split('x').map(&:to_i)

  total = 2*(lados.first * lados.second + lados.first * lados.third + lados.second * lados.third) + lados.sort.first(2).reduce(:*)

  puts "total: #{total} lados: #{lados}"
  A0Struct.create total: total, lados: lados
end

puts <<~FIN
  total: #{data.map(&:total).sum}
FIN
