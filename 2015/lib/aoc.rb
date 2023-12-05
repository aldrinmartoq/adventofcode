require 'active_support'
require 'active_support/core_ext'
require 'binding_of_caller'
require 'pry'

require_relative 'a0_struct'

def read_input(dir, name: nil)
  program_name = File.basename($PROGRAM_NAME).split('.rb').first
  tries = [
    ARGV[0],
    name,
    "#{program_name}_input.txt",
    'input.txt',
    "#{program_name}_sample.txt",
    'sample.txt'
  ]
  File.read(first_exists(dir, *tries))
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
