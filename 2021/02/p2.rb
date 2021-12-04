#!/usr/bin/env ruby

require_relative '../lib/aoc'

input = File.read(File.join(__dir__, ARGV[0] || 'input')).split("\n").map do |line|
  command, units = line.split
  A0Struct.new command: command, units: units.to_i
end

pos = depth = aim = 0

input.each do |command|
  case command.command
  when 'forward'
    pos += command.units
    depth += aim * command.units
  when 'down'
    aim += command.units
  when 'up'
    aim -= command.units
  end
end

puts <<~FIN
  pos: #{pos}
  depth: #{depth}
  aim: #{aim}

  pos * depth: #{pos * depth}
FIN
