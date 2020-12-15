#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map do |line|
  opcode, offset = line.split
  OpenStruct.new opcode: opcode.to_sym, offset: offset.to_i
end

pc = 0
ac = 0
executed = {}

loop do
  break if executed[pc]

  executed[pc] = true
  instruction = input[pc]
  case instruction.opcode
  when :nop
    pc += 1
  when :acc
    ac += instruction.offset
    pc += 1
  when :jmp
    pc += instruction.offset
  end
end

puts "pc: #{pc} ac: #{ac}"

# require 'pry'; binding.pry
