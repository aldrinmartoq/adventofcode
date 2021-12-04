#!/usr/bin/env ruby

require 'ostruct'

input_file = ARGV.first || File.join(__dir__, 'input')
input = File.read(input_file).split("\n").map.with_index do |line, x|
  [x, line.split('').map.with_index { |a, b| [b, a] }.to_h]
end.to_h

def pw(pocket, w, z, y, x, val)
  pocket[w] ||= {}
  pocket[w][z] ||= {}
  pocket[w][z][y] ||= {}
  pocket[w][z][y][x] = val
end

def pr(pocket, w, z, y, x)
  pocket[w] && pocket[w][z] && pocket[w][z][y] && pocket[w][z][y][x] || '.'
end

p = { 0 => { 0 => input } }

def range(pocket, d = 0)
  wmin, wmax = pocket.keys.min - d, pocket.keys.max + d
  zmin, zmax = pocket.values.map(&:keys).flatten.min - d, pocket.values.map(&:keys).flatten.max + d
  ymin, ymax = pocket.values.map(&:values).flatten.map(&:keys).flatten.min - d, pocket.values.map(&:values).flatten.map(&:keys).flatten.max + d
  xmin       = pocket.values.map(&:values).flatten.map(&:values).flatten.map(&:keys).flatten.min - d
  xmax       = pocket.values.map(&:values).flatten.map(&:values).flatten.map(&:keys).flatten.max + d

  [wmin, wmax, zmin, zmax, ymin, ymax, xmin, xmax]
end

def dump(pocket)
  wmin, wmax, zmin, zmax, ymin, ymax, xmin, xmax = range pocket

  (wmin..wmax).each do |w|
    (zmin..zmax).each do |z|
      puts "z=#{z} w=#{w}"
      (ymin..ymax).each do |y|
        (xmin..xmax).each do |x|
          print pr(pocket, w, z, y, x)
        end
        puts
      end
      puts
    end
  end
end

def exactly(pocket, w, z, y, x, expected)
  max = expected.max

  count = 0
  (w - 1..w + 1).each do |nw|
    (z - 1..z + 1).each do |nz|
      (y - 1..y + 1).each do |ny|
        (x - 1..x + 1).each do |nx|
          next if nw == w && nz == z && ny == y && nx == x

          count += 1 if pr(pocket, nw, nz, ny, nx) == '#'

          # puts "count: #{count} #{nz}, #{ny}, #{nx}"

          return false if count > max
        end
      end
    end
  end

  expected.include?(count)
end

def cycle(pocket)
  other = {}

  wmin, wmax, zmin, zmax, ymin, ymax, xmin, xmax = range pocket, 1

  (wmin..wmax).each do |w|
    (zmin..zmax).each do |z|
      # puts "z=#{z}"
      (ymin..ymax).each do |y|
        (xmin..xmax).each do |x|
          val = pr(pocket, w, z, y, x)
          case val
          when '#'
            pw(other, w, z, y, x, '#') if exactly(pocket, w, z, y, x, [2, 3])
          else
            pw(other, w, z, y, x, '#') if exactly(pocket, w, z, y, x, [3])
          end

          # puts "#{z}, #{y}, #{x} val: #{val} new: #{pr(other, z, y, x)}"
        end
        # puts
      end
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
  pocket.values.map(&:values).flatten.map(&:values).flatten.map(&:values).flatten.count
end

puts count(run(6, p))

# require 'pry'; binding.pry
