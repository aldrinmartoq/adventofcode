#!/usr/bin/env ruby

require_relative '../lib/aoc'

data = read_input(__dir__).split("\n").map do |line|
  lados = line.split('x').map(&:to_i)

  ribbon = lados.reduce(:*) + 2 * lados.sort.first(2).reduce(:+)

  puts "ribbon: #{ribbon} lados: #{lados}"
  A0Struct.create ribbon: ribbon, lados: lados
end

puts <<~FIN
  ribbon: #{data.map(&:ribbon).sum}
FIN
