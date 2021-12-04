#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map.with_index do |line, x|
  [x, line.split('').map.with_index { |a, b| [b, a] }.to_h]
end.to_h

def pw(pocket, z, y, x, val)
  pocket[z] ||= {}
  pocket[z][y] ||= {}
  pocket[z][y][x] = val
end

def pr(pocket, z, y, x)
  pocket[z] && pocket[z][y] && pocket[z][y][x] || '.'
end

p = { 0 => input }

def range(pocket, d = 0)
  zmin, zmax = pocket.keys.min - d, pocket.keys.max + d
  ymin, ymax = pocket.values.map(&:keys).flatten.min - d, pocket.values.map(&:keys).flatten.max + d
  xmin, xmax = pocket.values.map(&:values).flatten.map(&:keys).flatten.min - d, pocket.values.map(&:values).flatten.map(&:keys).flatten.max + d

  [zmin, zmax, ymin, ymax, xmin, xmax]
end

def dump(pocket)
  zmin, zmax, ymin, ymax, xmin, xmax = range pocket

  (zmin..zmax).each do |z|
    puts "z=#{z}"
    (ymin..ymax).each do |y|
      (xmin..xmax).each do |x|
        print pr(pocket, z, y, x)
      end
      puts
    end
    puts
  end
end

def exactly(pocket, z, y, x, expected)
  max = expected.max

  count = 0
  (z - 1..z + 1).each do |nz|
    (y - 1..y + 1).each do |ny|
      (x - 1..x + 1).each do |nx|
        next if nz == z && ny == y && nx == x

        count += 1 if pr(pocket, nz, ny, nx) == '#'

        # puts "count: #{count} #{nz}, #{ny}, #{nx}"

        return false if count > max
      end
    end
  end

  expected.include?(count)
end

def cycle(pocket)
  other = {}

  zmin, zmax, ymin, ymax, xmin, xmax = range pocket, 1

  (zmin..zmax).each do |z|
    # puts "z=#{z}"
    (ymin..ymax).each do |y|
      (xmin..xmax).each do |x|
        val = pr(pocket, z, y, x)
        case val
        when '#'
          pw(other, z, y, x, '#') if exactly(pocket, z, y, x, [2, 3])
        else
          pw(other, z, y, x, '#') if exactly(pocket, z, y, x, [3])
        end

        # puts "#{z}, #{y}, #{x} val: #{val} new: #{pr(other, z, y, x)}"
      end
      puts
    end
  end

  other
end

def run(times, pocket)
  o = pocket
  times.times do
    o = cycle o
  end

  dump o
  o
end

def count(pocket)
  pocket.values.map(&:values).flatten.map(&:values).flatten.count
end

puts count(run(6, p))

# require 'pry'; binding.pry
