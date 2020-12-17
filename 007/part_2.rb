#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map do |line|
  color, contains = line.split(' bags contain ')
  contains = contains.split(', ').map do |item|
    if (match = item.match(/^(\d+) (.+) bag/))
      OpenStruct.new count: match[1].to_i, color: match[2]
    end
  end.compact

  OpenStruct.new color: color, contains: contains
end

color_map = {}
input.each do |rule|
  color_map[rule.color] ||= OpenStruct.new color: rule.color, contains: []
  rule.contains.each do |contain|
    color_map[rule.color].contains.push OpenStruct.new(count: contain.count, color: contain.color)
  end
end

def navigate(color_map, color)
  return unless (node = color_map[color])

  node.contains.map do |contain|
    contain.count + contain.count * navigate(color_map, contain.color)
  end.sum
end
answer = navigate(color_map, 'shiny gold')

puts answer
