#!/usr/bin/env ruby

# input = File.read(File.join(__dir__, 'example')).split("\n")
input = File.read(File.join(__dir__, 'input')).split("\n")

def count_trees(input, dx, dy)
  count = x = y = 0

  while y < input.length
    line = input[y]
    count += line[x % line.length] == '#' ? 1 : 0
    x += dx
    y += dy
  end

  count
end

product = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |config|
  dx, dy = config
  count = count_trees(input, dx, dy)
  puts "dx: #{dx} dy: #{dy} trees: #{count}"
  count
end.reduce(&:*)

puts "product: #{product}"
