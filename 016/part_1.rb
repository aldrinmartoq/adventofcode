#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n\n")

rules = input[0].split("\n").map do |line|
  name, other = line.split(': ')
  values = other.split(' or ').map { |x| x.split('-').map(&:to_i) }
  OpenStruct.new name: name, values: values
end

# your_ticket = input[1].split("\n").last.split(',').map(&:to_i)

nearby_tickets = input[2].split("\n").drop(1).map { |x| x.split(',').map(&:to_i) }

invalids = nearby_tickets.map do |ticket|
  ticket.reject do |n|
    rules.any? do |rule|
      rule.values.any? do |v|
        n >= v[0] && n <= v[1]
      end
    end
  end
end.flatten

puts invalids.reduce(&:+)

# require 'pry'; binding.pry
