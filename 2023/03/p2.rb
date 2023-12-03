#!/usr/bin/env ruby
# rubocop:disable Style/GlobalVars

require_relative '../lib/aoc'

data = read_input(__dir__).split("\n")

$numbers = []
$symbols = []
$curr_number = nil

def emit_number
  return unless $curr_number

  $numbers.push($curr_number)
  $curr_number.x1 = $curr_number.x - 1
  $curr_number.x2 = $curr_number.x + $curr_number.text.length
  $curr_number.y1 = $curr_number.y - 1
  $curr_number.y2 = $curr_number.y + 1
  $curr_number.int = $curr_number.text.to_i
  $curr_number = nil
end

def emit_symbol(char, x, y)
  $symbols.push A0Struct.new(x:, y:, text: char)
end

data.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    if char == '.'
      emit_number
    elsif char >= '0' && char <= '9'
      $curr_number ||= A0Struct.new(text: '', y:, x:)
      $curr_number.text += char
    else
      emit_number
      emit_symbol(char, x, y)
    end
  end
  emit_number
end

gears_ratios = $symbols.select do |symbol|
  symbol.text == '*'
end.map do |symbol|
  list = $numbers.select do |number|
    (symbol.x >= number.x1) && (symbol.x <= number.x2) && (symbol.y >= number.y1) && (symbol.y <= number.y2)
  end.map(&:int)
  next if list.length != 2

  list.reduce(:*)
end.compact

puts <<~FIN
  result: #{gears_ratios.sum}
FIN

# rubocop:enable Style/GlobalVars
