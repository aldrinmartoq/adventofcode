#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map do |line|
  color, contains = line.split(' bags contain ')
  contains = contains.split(', ').map do |item|
    if (match = item.match(/^(\d+) (.+) bag/))
      OpenStruct.new count: match[1], color: match[2]
    end
  end.compact

  OpenStruct.new color: color, contains: contains
end

color_map = {}
input.each do |rule|
  rule.contains.each do |contained|
    color_map[contained.color] ||= OpenStruct.new color: contained.color, containers: []
    color_map[contained.color].containers.push rule
  end
end

def navigate(color_map, color, answer = [], visited = [])
  if visited.include?(color)
    puts "ALREADY VISITED NODE: #{color}"
  else
    visited.push color
    color_map[color]&.containers&.each do |container|
      answer << container.color unless answer.include?(container.color)
      navigate color_map, container.color, answer, visited
    end
  end
  answer
end
answer = navigate(color_map, 'shiny gold')

puts "answer: #{answer}"
puts answer.count
