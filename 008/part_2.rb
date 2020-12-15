#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map.with_index do |line, index|
  opcode, offset = line.split
  OpenStruct.new opcode: opcode.to_sym, offset: offset.to_i, index: index
end

def run(input)
  pc = 0
  ac = 0
  executed = {}

  loop do
    break if executed[pc] || pc == input.count

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

  OpenStruct.new ac: ac, done: pc == input.count
end

jmps = input.select do |instruction|
  instruction.opcode == :jmp
end

jmps.each do |instruction|
  instruction.opcode = :nop
  result = run(input)
  instruction.opcode = :jmp
  next unless result.done

  puts "result: #{result} instruction: #{instruction}"
end

# require 'pry'; binding.pry
