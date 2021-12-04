require 'ostruct'
require 'pry'
require 'binding_of_caller'

def reload!
  puts "RELOADING #{$0}"
  load $0
end

def console
  return if $CONSOLE

  $CONSOLE = true
  binding.of_caller(1).pry
  $CONSOLE = false
end
