#!/usr/bin/env ruby

# input = File.read(File.join(__dir__, 'example')).split("\n")
input = File.read(File.join(__dir__, 'input')).split("\n")

count = x = y = 0
while y < input.length
  line = input[y]
  count += line[x % line.length] == '#' ? 1 : 0
  x += 3
  y += 1
end

puts count
