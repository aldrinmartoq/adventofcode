#!/usr/bin/env ruby

# usage: ruby 004/part_1.rb [input_path]
input = File.read(ARGV.first || File.join(__dir__, 'input')).split("\n\n").map do |data|
  data.split.map { |item| item.split(':') }.to_h
end

required = <<~FIN.split
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
FIN

valid = input.select do |passport|
  (passport.keys & required).count == required.count
end

# puts "valid: #{valid}"
puts "Valid / Total: #{valid.count} / #{input.count}"
