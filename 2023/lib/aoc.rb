require 'active_support'
require 'active_support/core_ext'
require 'binding_of_caller'
require 'pry'

require_relative 'a0_struct'

def read_input(dir, name: nil)
  File.read(first_exists(dir, ARGV[0], name, p_input_name, 'input.txt'))
end

def first_exists(dir, *args)
  args.each do |item|
    next unless item

    filename = File.join(dir, item)
    next unless File.exist?(filename)

    puts "reading #{filename}"
    return filename
  end
end

def p_input_name
  "#{File.basename($PROGRAM_NAME).split('.rb').first}_input.txt"
end
