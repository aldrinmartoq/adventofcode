#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n").map do |line|
  command, units = line.split
  A0Struct.new command: command, units: units.to_i
end

pos = depth = 0

input.each do |command|
  case command.command
  when 'forward'
    pos += command.units
  when 'down'
    depth += command.units
  when 'up'
    depth -= command.units
  end
end

puts <<~FIN
  pos: #{pos}
  depth: #{depth}

  pos * depth: #{pos * depth}
FIN
