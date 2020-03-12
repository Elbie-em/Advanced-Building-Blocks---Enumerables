# rubocop:disable Style/MixinUsage

require_relative 'module_enumerable.rb'
include Enumerable

# Testing of inject method
def multiply_els(my_array)
  my_array.my_inject { |result, value| result * value }
end

puts multiply_els([2, 4, 5])

# rubocop:enable Style/MixinUsage
