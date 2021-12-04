#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n\n")

rules = input[0].split("\n").map do |line|
  name, other = line.split(': ')
  values = other.split(' or ').map { |x| x.split('-').map(&:to_i) }
  OpenStruct.new name: name, values: values, cols: [], col: nil
end

your_ticket = input[1].split("\n").last.split(',').map(&:to_i)

nearby_tickets = input[2].split("\n").drop(1).map { |x| x.split(',').map(&:to_i) }

valids = nearby_tickets.select do |ticket|
  ticket.reject do |n|
    rules.any? do |rule|
      rule.values.any? do |v|
        n >= v[0] && n <= v[1]
      end
    end
  end.empty?
end

rules.each do |rule|
  rules.count.times do |col|
    numbers = valids.map { |ticket| ticket[col] }
    matched = numbers.all? do |n|
      rule.values.any? do |v|
        n >= v[0] && n <= v[1]
      end
    end

    rule.cols.push col if matched
    # puts "col: #{col} rule: #{rule} numbers: #{numbers}" if matched
  end
end

loop do
  pending = rules.select do |rule|
    rule.cols.count == 1
  end

  break if pending.empty?

  cols = pending.map do |rule|
    rule.col = rule.cols.first
    rule.cols = []
    rule.col
  end

  rules.each do |rule|
    rule.cols -= cols
  end
end

rules.sort_by!(&:col)

# pp rules

departure_rules = rules.select do |rule|
  rule.name.start_with? 'departure'
end

values = departure_rules.map do |rule|
  your_ticket[rule.col]
end

puts values.reduce(&:*)

# require 'pry'; binding.pry
