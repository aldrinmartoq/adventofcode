#!/usr/bin/env ruby

require 'ostruct'

# usage: ruby 004/part_2.rb [input_path]
input = File.read(ARGV.first || File.join(__dir__, 'input')).split("\n\n").map do |data|
  OpenStruct.new(data.split.map { |item| item.split(':') }.to_h)
end

required = <<~FIN.split.map(&:to_sym)
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
FIN

valid = input.select do |passport|
  (passport.to_h.keys & required).count == required.count
end

valid.select! do |passport|
  validations = []
  validations << (passport.byr.to_i >= 1920 && passport.byr.to_i <= 2002)
  validations << (passport.iyr.to_i >= 2010 && passport.iyr.to_i <= 2020)
  validations << (passport.eyr.to_i >= 2020 && passport.eyr.to_i <= 2030)
  validations << ((passport.hgt.end_with?('cm') && passport.hgt.to_i >= 150 && passport.hgt.to_i <= 193) ||
                  (passport.hgt.end_with?('in') && passport.hgt.to_i >= 59 && passport.hgt.to_i <= 76))
  validations << passport.hcl.match(/^#[0-9a-f]{6}$/)
  validations << %w[amb blu brn gry grn hzl oth].include?(passport.ecl)
  validations << passport.pid.match(/^[0-9]{9}$/)

  # puts "passport: #{passport}\n  validations: #{validations}\n\n"

  validations.all?
end

# puts "valid: #{valid}"
# require 'pry'; binding.pry
puts "Valid / Total: #{valid.count} / #{input.count}"
