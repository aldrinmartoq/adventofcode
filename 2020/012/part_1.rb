#!/usr/bin/env ruby

require_relative '../lib/aoc'

def parse_input(input_file)
  File.read(input_file).split("\n").map { |line| line.split('') }
end

def process(input)
end

def run(input_file = File.join(__dir__, 'input'))
  puts "-- INI -- #{input_file} --"

  process parse_input(input_file)

  puts "data: #{data}"

  puts "-- #{input_file} -- FIN --"
  nil
end

def runex
  dir = Pathname.new(__dir__)
  run dir.join 'example'
end

console
